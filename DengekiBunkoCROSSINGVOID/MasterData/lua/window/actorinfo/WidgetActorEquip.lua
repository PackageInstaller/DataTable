local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local HU = require("Common/HtmlUtil")
local LU = require("Common/ListUtil")
local EA = require("Common/EquipAttr")
local DBH = require("Manager/DataBindingHandler")
local SU = require("Common/SortUtil")
local m_actor
local m_equipListMap = _ENV["!"]({})
local m_candidateEquips = _ENV["!"]({})
local m_recommendEquipIds = _ENV["!"]({})
local m_pos, m_targetPos, m_focusId, m_focusUid
local m_sortMateIds = {
  54,
  55,
  56,
  57,
  58,
  59
}
local m_curSortMatId
local m_reverse = false

function Awake()
  for i = 0, #REF.EquipSlotGrid - 1 do
    local slotRef = REF.EquipSlotGrid[i]
    slotRef["$$SetEquipPos"](i)
    slotRef["$$SetShowHighlight"](false)
    slotRef["$$SetClickCallback"](OnBodyEquipClick)
  end
  for i = 0, #REF.PosButtonGrid - 1 do
    local posButtonRef = REF.PosButtonGrid[i]
    posButtonRef["@pos"] = i
    WU.BindButtonEvent(posButtonRef["$"], function(go)
      WU.RecordButtonClick("8007" .. i)
      OnEquipPosChange(_ENV["$"](go)["@pos"])
    end)
  end
  LU.Bind(REF.WrapContentEquip, {
    dataSource = function(dataIndex)
      return m_candidateEquips and m_candidateEquips[dataIndex]
    end,
    updateSlot = UpdateEquipSlot,
    delta = 0.03
  })
  WU.BindButtonEvent(REF.ButtonToggleAll, OnToggleAllClick)
  WU.BindButtonEvent(REF.ButtonEnhance, OnEnhanceClick)
  WU.BindButtonEvent(REF.ButtonHideSuitStatus, HideSuitStatus)
  WU.BindButtonEvent(REF.ButtonSaveMatch, OnSaveMatch)
  WU.BindButtonEvent(REF.ButtonLoadMatch, OnLoadMatch)
  REF.DropList.gameObject:SetActive(false)
  WU.BindButtonEvent(REF.ButtonSort, function()
    REF.DropList.gameObject:SetActive(true)
  end)
  WU.BindButtonEvent(REF.DropListButtonMask, function()
    REF.DropList.gameObject:SetActive(false)
  end)
  WU.TraverseChildren(REF.DropListGrid, function(go, index)
    if index < #m_sortMateIds then
      local ref = _ENV["$"](go)
      ref["@sortMatId"] = m_sortMateIds[index + 1]
      local xlsx = PB.get("Sort", ref["@sortMatId"])
      ref.DropListLabelItemSelected.UILabel.text = WU.GetString(xlsx.localization)
      ref.DropListLabelItem.UILabel.text = WU.GetString(xlsx.localization)
      WU.BindButtonEvent(ref.root, OnClickSortItem)
    else
      go.SetActive(false)
    end
  end)
  OnClickSortItem(REF.DropListGrid[0].root.gameObject)
end

function OnClickSortItem(go)
  local ref = _ENV["$"](go)
  if m_curSortMatId ~= ref["@sortMatId"] then
    local xlsx = PB.get("Sort", ref["@sortMatId"])
    REF.LabelSort.UILabel.text = WU.GetString(xlsx.localization)
    m_curSortMatId = ref["@sortMatId"]
    WU.TraverseChildren(REF.DropListGrid, function(go, index)
      _ENV["$"](go).DropListNodeSelected.gameObject:SetActive(false)
    end)
    ref.DropListNodeSelected.gameObject:SetActive(true)
    m_reverse = true
    ref.DropListSpriteSeqTagChild.UISprite.flip = CS.UISprite.Flip.Nothing
    UpdateEquipList()
  else
    m_reverse = not m_reverse
    ref.DropListSpriteSeqTagChild.UISprite.flip = fif(m_reverse, CS.UISprite.Flip.Nothing, CS.UISprite.Flip.Vertically)
    UpdateEquipList()
  end
end

function OnEnable()
  this:DelayInvokeInFrames(1, function()
    this:Bind("ActorInfo/CurrentActor", OnCurrentActorChange)
    this:Bind("fci/equip", OnEquipListChange)
  end)
  this:RegisterGameEvent("EventSelectEquipPos", OnEventSelectEquipPos)
  this:RegisterGameEvent("EventSuitClick", OnSuitClick)
  this:RegisterGameEvent("EventLocateEquip", OnEventLocateEquip)
  HideSuitStatus()
  REF["$Animator"]:Play("Open", -1, 0)
  local tutorial = this:GetData("CurrentTutorial")
  if tutorial == 58 or tutorial == 59 then
    local equips = this:GetData("fci/equip")
    local _, equip = table.find(equips, function(_, v)
      return v.quality == 1
    end)
    WU.TraverseChildren(REF.PosButtonGrid, function(go)
      _ENV["$"](go)["$UIToggle"].value = false
    end)
    if equip ~= nil then
      local position = equip.position
      REF.PosButtonGrid[position]["$UIToggle"].value = true
      REF.PosButtonGrid[0]["$UIToggle"].value = false
      OnEquipPosChange(position)
    end
  end
end

function OnDisable()
  this:Unbind("ActorInfo/CurrentActor", OnCurrentActorChange)
  this:Unbind("fci/equip", OnEquipListChange)
  this:UnregisterGameEvent("EventSelectEquipPos", OnEventSelectEquipPos)
  this:UnregisterGameEvent("EventSuitClick", OnSuitClick)
  this:UnregisterGameEvent("EventLocateEquip", OnEventLocateEquip)
end

function HideSuitStatus()
  WU.ToggleRendering(REF.NodeSuitStatus.gameObject, false)
end

function OnCurrentActorChange(actor)
  m_actor = actor
  if m_actor then
    local hasEquip = table.count(m_actor.bodyEquips) > 0
    _ENV["$"](REF.ButtonToggleAll).Label.UILabel.text = WU.GetString(fif(hasEquip, "WindowActorEquip_UnequipAll", "WindowActorEquip_EquipAll"))
    WU.ToggleRendering(REF.ButtonEnhance.gameObject, hasEquip)
    REF.EquipEmpty.gameObject:SetActive(not hasEquip)
    local suits = EU.GetSuits(actor)
    m_recommendEquipIds = _ENV["!"]({})
    for _, suit in pairs(suits) do
      for _, id in pairs(suit.equipId) do
        table.insert(m_recommendEquipIds, id)
      end
    end
    local equips = EU.GetEquips(m_actor)
    for _, equip in pairs(equips) do
      local index = m_recommendEquipIds:find(function(k, v)
        return v == equip.id
      end)
      if index then
        table.remove(m_recommendEquipIds, index)
      end
    end
    local posList = EU.GetAvailableEquipPosList(m_actor)
    for _, pos in pairs(PB.enum.EquipPos) do
      REF.PosButtonGrid[pos].SpriteBadge.gameObject:SetActive(table.has(posList, pos))
    end
    this:DelayInvokeInFrames(1, function()
      UpdateScore()
    end)
    UpdateAttrs()
    REF.ScrollViewAttr.UIScrollView:ResetPosition()
    if m_pos then
      UpdateEquipList()
    else
      OnEquipPosChange(m_targetPos or 0)
    end
    HideSuitStatus()
  end
end

function OnEquipListChange(equipList)
  m_equipListMap = _ENV["!"]({})
  for _, pos in pairs(PB.enum.EquipPos) do
    m_equipListMap[pos] = _ENV["!"]({})
  end
  if equipList then
    for _, equip in pairs(equipList) do
      local equipInfo = PB.get("EquipInfo", equip.id)
      if equipInfo then
        table.insert(m_equipListMap[equipInfo.pos], equip)
      end
    end
    for _, equipListByPos in pairs(m_equipListMap) do
      table.sort(equipListByPos, function(a, b)
        local aInfo = PB.get("EquipInfo", a.id)
        local bInfo = PB.get("EquipInfo", b.id)
        local aQuality = aInfo.quality or 0
        local bQuality = bInfo.quality or 0
        if aQuality ~= bQuality then
          return aQuality > bQuality
        elseif a.level ~= b.level then
          return a.level > b.level
        elseif a.score ~= b.score then
          return a.score > b.score
        else
          return a.uid > b.uid
        end
      end)
    end
    UpdateAttrs()
    REF.ScrollViewAttr.UIScrollView:ResetPosition()
    if m_pos then
      UpdateEquipList()
    else
      OnEquipPosChange(m_targetPos or 0)
    end
  end
end

function OnBodyEquipClick(pos)
  local targetUid = m_actor.bodyEquips[tostring(pos)]
  if m_pos ~= pos then
    OnEquipPosChange(pos)
  end
  if targetUid then
    WU.AcquireWindowAsync("ActorEquipCompare", function(window)
      _ENV["$"](window)["$$SetEquip"](this:GetData("fci/equip/" .. targetUid))
    end)
  end
end

function OnToggleAllClick()
  if m_actor then
    if table.count(m_actor.bodyEquips) > 0 then
      this:GameRequest("fci/equip/off/1"):Post({
        actorUid = m_actor.uid
      }, function(result)
        DBH.UpdateEquips(result.offEquips)
        DBH.UpdateActors(result.newActor)
      end)
    else
      WU.RecordButtonClick(8001)
      local equipUids = {}
      for pos, equipList in pairs(m_equipListMap) do
        for _, equip in ipairs(equipList) do
          if equip.actorUid == 0 and equip.requireLevel <= m_actor.level then
            table.insert(equipUids, equip.uid)
            break
          end
        end
      end
      if 0 < #equipUids then
        this:GameRequest("fci/equip/on-all/"):Post({
          actorUid = m_actor.uid,
          equipUids = equipUids
        }, function(result)
          DBH.UpdateEquips(result.newEquips)
          DBH.UpdateActors(result.newActor)
        end)
      else
        WU.ShowHintText(WU.GetString("WindowActorEquip_NoEquips"))
      end
    end
  end
end

function OnEnhanceClick()
  WU.RecordButtonClick(8008)
  WU.AcquireWindowAsync("ActorEquipLevelup")
end

function OnEquipPosChange(pos)
  if m_pos ~= pos then
    m_pos = pos
    this:SetData("Actor/Equip/SelectedPos", m_pos)
    if m_pos then
      REF.PosButtonGrid[m_pos]["$UIToggle"].value = true
      UpdateEquipList()
    end
  end
end

function UpdateAttrs()
  local equips = EU.GetEquipsSortedByPos(m_actor)
  REF.WidgetEquipAttrMixedTable.gameObject:SetActive(0 < #equips)
  if 0 < #equips then
    local suitInfoList = _ENV["!"]({})
    for i = 1, #equips do
      local equip = equips[i]
      if equip then
        local suitInfo = EA.GetSuitInfo(equip.id, equips)
        if suitInfo and not suitInfoList:find(function(k, v)
          return v.id == suitInfo.id
        end) then
          table.insert(suitInfoList, suitInfo)
        end
      end
    end
    REF.WidgetEquipAttrMixedTable["$SetMixedAttrs"](suitInfoList, AU.NormalizeAttrs(m_actor.equipAttrs))
  end
end

function UpdateScore()
  local totalScore = AU.GetActorEquipTotalScore(m_actor)
  if 0 < totalScore then
    REF.LabelScore.UIHtmlLabel.text = WU.GetString("WindowActorEquip_TitleScore", totalScore)
  else
    REF.LabelScore.UIHtmlLabel.text = ""
  end
end

function UpdateEquipList()
  m_candidateEquips = m_equipListMap[m_pos]
  if m_candidateEquips then
    if m_curSortMatId then
      local xlsx = PB.get("Sort", m_curSortMatId)
      SU.SortOnce(m_candidateEquips, xlsx, m_reverse)
    end
    local equipCount = #m_candidateEquips
    local scrollViewOffset
    if 0 < equipCount and m_focusId then
      local index
      for i = 1, #m_candidateEquips do
        if m_candidateEquips[i].id == m_focusId then
          m_focusUid = m_candidateEquips[i].uid
          index = i
          break
        end
      end
      if index then
        local row = math.floor((index - 1) / #REF.WrapContentEquip[0]["$"])
        local candidateSlot = REF.WidgetIconSlotSubstitutionEquip
        local slotHeight = candidateSlot.transform.localScale.y * _ENV["$"](candidateSlot).Bounds.UIWidget.height
        local buttomPos = row * REF.WrapContentEquip.UIWrapContent.itemSize + slotHeight
        scrollViewOffset = CS.UnityEngine.Vector3(0, buttomPos - REF.ScrollviewEquip.UIPanel.finalClipRegion.w, 0)
      end
    end
    local rowCount = math.ceil(equipCount / #REF.WrapContentEquip[0]["$"])
    local tutorial = this:GetData("CurrentTutorial")
    if tutorial == 58 or tutorial == 59 then
      local index, green = table.find(m_candidateEquips, function(k, v)
        return v.quality == 1
      end)
      if index ~= 1 then
        m_candidateEquips[index] = m_candidateEquips[1]
        m_candidateEquips[1] = green
      end
    end
    LU.Set(REF.WrapContentEquip, rowCount, true, m_focusId)
    REF.NodeEquipEmpty.gameObject:SetActive(equipCount == 0)
    if scrollViewOffset and 0 < scrollViewOffset.y then
      REF.ScrollviewEquip.UIScrollView:MoveRelative(scrollViewOffset)
    end
    m_focusId = nil
    m_focusUid = nil
  end
end

function UpdateEquipSlot(widgetRef, context)
  if context then
    widgetRef["$$BindEquip"](context)
    if m_focusUid and m_focusUid == context.uid then
      local pos = REF.WrapContentEquip.transform:InverseTransformPoint(widgetRef["$transform"].position)
      REF.EffectFocus.transform.localPosition = pos
      REF.EffectFocus.EffectGenerator:Play()
      widgetRef["$UIPlayTween"]:Play()
    end
    local isRecommended = m_recommendEquipIds:find(function(_, id)
      return id == context.id
    end)
    widgetRef["$$ShowCustom"]({
      overload = context.requireLevel > m_actor.level,
      recommend = isRecommended and context.actorUid ~= m_actor.uid,
      lock = false,
      showNew = true,
      ownerUid = context.actorUid
    })
    if context.actorUid == m_actor.uid then
      widgetRef["$$SetTips"]("equipEquipped")
    end
    widgetRef["$$SetClickCallback"](OnCandidateEquipClick)
  else
    widgetRef["$$ClearSlot"]()
  end
end

function OnCandidateEquipClick(go)
  WU.RecordButtonClick(80041)
  local candidateEquip = _ENV["$"](go)["@context"]
  if candidateEquip then
    local targetEquip
    local targetUid = m_actor.bodyEquips[tostring(m_pos)]
    if targetUid then
      targetEquip = this:GetData("fci/equip/" .. targetUid)
    end
    if targetUid == candidateEquip.uid then
      candidateEquip = nil
    end
    WU.AcquireWindowAsync("ActorEquipCompare", function(window)
      _ENV["$"](window)["$$SetEquip"](targetEquip, candidateEquip)
    end)
  end
end

function OnSuitClick(suitInfo, worldPos)
  if suitInfo then
    WU.ToggleRendering(REF.NodeSuitStatus.gameObject, true)
    local pos = REF.NodeSuitStatus.transform:InverseTransformPoint(worldPos)
    local widgetSuitPos = REF.WidgetSuit.transform.localPosition
    REF.WidgetSuit.transform.localPosition = CS.UnityEngine.Vector3(widgetSuitPos.x, pos.y - 32, 0)
    REF.WidgetSuit["$SetSuitInfo"](suitInfo)
  end
end

function OnEventSelectEquipPos(pos)
  m_targetPos = pos
  OnEquipPosChange(m_targetPos)
end

function OnEventLocateEquip(pos, id)
  HideSuitStatus()
  m_focusId = id
  if m_pos ~= pos then
    OnEquipPosChange(pos)
  else
    UpdateEquipList()
  end
end

function OnSaveMatch()
  WU.RecordButtonClick(8002)
  if m_actor then
    this:SetData("EquipMatch/State", "save")
    local hasEquip = table.count(m_actor.bodyEquips) > 0
    if hasEquip then
      WU.AcquireWindowAsync("EquipMatch")
    else
      WU.ShowHintText(WU.GetString("WindowActorEquip_NoEquipForMatch"))
    end
  end
end

function OnLoadMatch()
  WU.RecordButtonClick(8003)
  if m_actor then
    local matchLimit = PB.all("CostumeInfo"):last().maxCount
    local matchAvailable = false
    for i = 1, matchLimit do
      local match = this:GetData("Equip/Match/" .. i)
      if match then
        for _, equipUid in pairs(match.matchEquipUids) do
          local equip = this:GetData("fci/equip/" .. equipUid)
          if equip then
            matchAvailable = true
            break
          end
        end
        if matchAvailable then
          break
        end
      end
    end
    if matchAvailable then
      this:SetData("EquipMatch/State", "load")
      WU.AcquireWindowAsync("EquipMatch")
    else
      WU.ShowHintText(WU.GetString("WindowActorEquip_NoMatchAvailable"))
    end
  end
end
