local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local RU = require("Common/RedMarkUtil")
local AU = require("Common/ActorUtil")
local SU = require("Common/SortUtil")
local m_medals, m_selectedId, m_pos, m_selectedSlot, m_playerInfo, m_newMedals, m_mode, m_showMedals, m_medalList, m_allMedals, m_init, m_isClicking

function SetupWindow()
  REF.LabelDetail.UIHtmlLabel.text = ""
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
  WU.BindButtonEvent(REF.BtnFinish, OnFinishClick)
end

function InitWindow()
  m_isClicking = false
  m_allMedals = PB.all("MedalInfo"):select(function(m)
    return {
      id = m.id,
      category = m.category,
      order = m.order,
      hide = m.hide,
      quality = m.quality
    }
  end)
  table.sort(m_allMedals, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  m_init = true
end

function UninitWindow()
  SU.ClearNewFlag(PB.enum.ResourceType.ResMedal, m_newMedals)
end

function OnListChange(list)
  if list == nil then
    return
  end
  m_medals = {}
  table.copy(list, m_medals, true)
  local bilibiliMedalIndex = table.find(m_medals, function(k, v)
    return v.id == 80005
  end)
  if bilibiliMedalIndex then
    table.remove(m_medals, bilibiliMedalIndex)
  end
  table.sort(m_medals, Sort)
  if m_pos == nil and not table.empty(m_medals) then
    m_selectedId = m_medals[1].id
  end
  for i = 1, #m_medals do
    if m_medals[i].isNew then
      table.insert(m_newMedals, m_medals[i])
    end
  end
  local expireTime
  local _, selectedMedal = _ENV["!"](m_medals):find(function(k, v)
    return v.id == m_selectedId
  end)
  if selectedMedal ~= nil then
    expireTime = selectedMedal.expireTime
  end
  SetSelecedMedal(m_selectedId, expireTime)
  local row = math.ceil(#m_medals / #REF.WrapContent[0].root)
  REF.NodeEmpty.gameObject:SetActive(#m_medals == 0)
  LU.Set(REF.WrapContent, row)
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContent.UIWrapContent.itemSize)
  REF.BottomBarSpace.gameObject:SetActive(0 < row)
  REF.ScrollView.UIScrollView:ResetPosition()
  WU.ToggleRendering(REF.Content, true)
end

function Sort(a, b)
  if m_pos == nil and (a.id == m_selectedId or b.id == m_selectedId) then
    return a.id == m_selectedId
  elseif m_pos ~= nil then
    local show1 = m_playerInfo.showMedals[1]
    local show2 = m_playerInfo.showMedals[2]
    if a.id == show1 or b.id == show1 then
      return a.id == show1
    elseif a.id == show2 or b.id == show2 then
      return a.id == show2
    else
      return _Sort(a, b)
    end
  else
    return _Sort(a, b)
  end
end

function _Sort(a, b)
  local orderA = PB.get("MedalInfo", a.id).order
  local orderB = PB.get("MedalInfo", b.id).order
  if orderA ~= orderB then
    return orderA < orderB
  else
    return a.id < b.id
  end
end

function OnConfirmClick()
  local fightMedal = m_playerInfo.fightMedal
  local showMedals = m_playerInfo.showMedals
  local changed = fif(m_pos == nil, fightMedal ~= m_selectedId, showMedals[m_pos] ~= m_selectedId)
  if not changed then
    WU.RecycleWindow("MedalSelection")
    return
  end
  local param
  if m_pos == nil then
    param = {fightMedal = m_selectedId}
  else
    if showMedals[1] == nil then
      showMedals[1] = 0
    end
    if showMedals[2] == nil then
      showMedals[2] = 0
    end
    local otherPos = fif(m_pos == 1, 2, 1)
    if showMedals[otherPos] == m_selectedId then
      showMedals[otherPos] = 0
    end
    showMedals[m_pos] = m_selectedId
    param = {showMedals = showMedals}
  end
  local wireFormatparam = ProtobufT("ApiRelationPlayerPageInfo", param)
  this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatparam, function(result)
    this:SetData("Space/SelectedPlayer", result)
    this:SetData("PlayerFightMedal", m_selectedId)
    RU.SetRedMark("Journey/Medal/New", false)
    WU.RecycleWindow("MedalSelection")
  end)
end

function UpdateMedalSlot(ref, info)
  if m_mode ~= 1 then
    if info == nil then
      ref["$$ClearSlot"]()
    else
      local id = info.id
      ref["$$SetData"](PB.enum.ResourceType.ResMedal, id)
      ref["$$ShowCustom"]({
        isNew = info.isNew,
        name = true
      })
      ref["$$SetHighlighted"](id == m_selectedId)
      ref.SelectedSpriteNum.gameObject:SetActive(false)
      local equipped = m_pos == nil and id == m_playerInfo.fightMedal
      local shown = m_pos ~= nil and (id == m_playerInfo.showMedals[1] or id == m_playerInfo.showMedals[2])
      if equipped then
        ref["$$SetTips"]("equipEquipped")
      elseif shown then
        ref["$$SetTips"]("equipUsing")
      else
        ref["$$SetTips"](nil)
      end
      if id == m_selectedId then
        m_selectedSlot = ref
      end
      ref["$$SetClickCallback"](function()
        m_selectedId = id
        if m_selectedSlot ~= nil then
          m_selectedSlot["$$SetHighlighted"](false)
        end
        ref["$$SetHighlighted"](true)
        m_selectedSlot = ref
        SetSelecedMedal(m_selectedId, info.expireTime)
      end)
    end
  elseif info == nil then
    ref["$$ClearSlot"]()
  else
    local id = info.id
    if not m_isClicking then
      ref["$$SetData"](PB.enum.ResourceType.ResMedal, id)
      ref["$$ShowCustom"]({
        isNew = info.isNew,
        name = true
      })
    end
    local index = table.find(m_showMedals, function(_, v)
      return v == id
    end)
    if index then
      ref["@index"] = index
      ref.SelectedSpriteNum.gameObject:SetActive(true)
      ref.SelectedSpriteNum.UISprite.spriteName = "number_icon_" .. index
    else
      ref["@index"] = nil
      ref.SelectedSpriteNum.gameObject:SetActive(false)
    end
    ref["$$SetClickCallback"](function()
      WU.RecordButtonClick(100137101)
      if ref["@index"] then
        table.remove(m_showMedals, ref["@index"])
        ref["@index"] = nil
        m_isClicking = true
        RefreshShowList()
        m_isClicking = false
      elseif #m_showMedals < 6 then
        local curIndex = #m_showMedals + 1
        ref["@index"] = curIndex
        table.insert(m_showMedals, curIndex, id)
        m_isClicking = true
        RefreshShowList()
        m_isClicking = false
      end
    end)
  end
end

function SetSelecedMedal(id, expireTime)
  if id == nil or id == 0 then
    REF.BottomBar["$Hide"]()
  else
    REF.BottomBar["$Show"]()
    REF.SelectedWidgetIconSlot["$SetData"](PB.enum.ResourceType.ResMedal, id)
    REF.SelectedWidgetIconSlot["$ShowCustom"]({name = false})
    local medalInfo = PB.get("MedalInfo", id)
    local expireText
    if medalInfo.expireDay ~= 0 then
      local expireDate = CS.GameTime.UtcToLocal(expireTime).Date
      expireText = WU.GetString("Window_ValidTime") .. expireDate:ToString("yyyy-MM-dd")
    elseif medalInfo.expireTime ~= "" then
      expireText = WU.GetString("Window_ValidTime") .. medalInfo.expireTime:split(" ")[1]
    end
    local detailText = "<font size=40>" .. WU.GetString("MedalName_" .. id) .. "</font>&nbsp;<font size=26 color=#F4DD51FF>(" .. WU.GetString("MedalSource_" .. medalInfo.source) .. ")</font><br>"
    if expireText ~= nil then
      detailText = detailText .. expireText .. "<br>"
    end
    detailText = detailText .. AU.RenderAuraOrMedalAttr(medalInfo) .. "<font color=#B4C7EBFF>" .. WU.GetString("MedalStory_" .. id) .. "</font>"
    REF.LabelDetail.UIHtmlLabel.text = detailText
  end
end

function SetMode(mode)
  m_mode = mode
  if mode == 1 then
    WU.SetWindowTitle("MedalSelection", "MedalSelection1")
    LU.Bind(REF.WrapContent, {
      dataSource = function(dataIndex)
        return m_medalList and m_medalList[dataIndex]
      end,
      updateSlot = UpdateMedalSlot
    })
    REF.BottomBar.gameObject:SetActive(false)
    REF.NodePreview.gameObject:SetActive(true)
    m_playerInfo = this:GetData("Space/SelectedPlayer")
    this:Bind("fci/medal/", OnShowListChange)
  else
    WU.SetWindowTitle("MedalSelection", "MedalSelection")
    LU.Bind(REF.WrapContent, {
      dataSource = function(dataIndex)
        return m_medals and m_medals[dataIndex]
      end,
      updateSlot = UpdateMedalSlot,
      delta = 0.01
    })
    REF.BottomBar.gameObject:SetActive(true)
    REF.NodePreview.gameObject:SetActive(false)
    m_newMedals = {}
    local selectedMedal = this:GetData("SelectedMedal")
    m_pos = selectedMedal.pos
    m_selectedId = selectedMedal.id
    m_selectedSlot = nil
    m_playerInfo = this:GetData("Space/SelectedPlayer")
    WU.ToggleRendering(REF.Content, false)
    if m_playerInfo == nil then
      return
    end
    this:Bind("fci/medal/", OnListChange)
  end
end

function OnShowListChange(list)
  if list == nil then
    return
  end
  m_init = true
  m_medals = list
  m_medalList = {}
  m_showMedals = {}
  if not m_playerInfo.showMedals then
    return
  end
  local bilibiliMedalIndex = table.find(m_playerInfo.showMedals, function(k, v)
    return v == 80005
  end)
  if bilibiliMedalIndex then
    table.remove(m_playerInfo.showMedals, bilibiliMedalIndex)
  end
  for i = 1, #m_playerInfo.showMedals do
    local hasIndex = table.find(m_medals, function(k, v)
      return v.id == m_playerInfo.showMedals[i]
    end)
    if hasIndex then
      table.insert(m_showMedals, m_playerInfo.showMedals[i])
    end
  end
  local isPreCommit = WU.IsPreCommit()
  for _, m in pairs(m_allMedals) do
    local _, obtainedMedal = table.find(list, function(k, v)
      return v.id == m.id
    end)
    if obtainedMedal then
      m.obtained = true
      local hideSpecial = false
      hideSpecial = m.id == 80005
      if m.obtained and not hideSpecial then
        if isPreCommit then
          if m.category ~= 4 then
            table.insert(m_medalList, m)
          end
        else
          table.insert(m_medalList, m)
        end
      end
    end
  end
  table.sort(m_medalList, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    else
      return a.id < b.id
    end
  end)
  RefreshShowList()
  m_init = false
end

function RefreshShowList()
  local row = math.ceil(#m_medalList / #REF.WrapContent[0].root)
  REF.NodeEmpty.gameObject:SetActive(#m_medalList == 0)
  if #m_showMedals == 0 then
    REF.NodePreview["$Hide"]()
  else
    REF.NodePreview["$Show"]()
  end
  if m_init then
    LU.Set(REF.WrapContent, row, true)
  else
    LU.Set(REF.WrapContent, row, false)
  end
  REF.BottomBarSpace.transform.localPosition = CS.UnityEngine.Vector3(0, (1 - row) * REF.WrapContent.UIWrapContent.itemSize)
  REF.BottomBarSpace.gameObject:SetActive(0 < row)
  RefreshSelectList()
end

function RefreshSelectList()
  for i = 1, #REF.PreviewSeq do
    local ref = REF.PreviewSeq[i - 1]
    ref.NumberLabel.UILabel.text = i
    local id = m_showMedals[i]
    if m_showMedals[i] then
      ref.Selection.gameObject:SetActive(true)
      local index = table.find(m_medalList, function(k, v)
        return v.id == id
      end)
      ref.BGSprite1.UISprite.spriteName = "icon_bg_" .. m_medalList[index].quality
      ref.ActorSprite.UISprite.atlasPath = fif(8000 <= id and id < 10000, "MedalIcon2", "MedalIcon")
      ref.ActorSprite.UISprite.spriteName = "medal_icon_" .. id
    else
      ref.Selection.gameObject:SetActive(false)
    end
  end
end

function OnFinishClick()
  WU.RecordButtonClick(100137102)
  local param = {showMedals = m_showMedals}
  local wireFormatparam = ProtobufT("ApiRelationPlayerPageInfo", param)
  this:GameRequest("fci/playerpageinfo/"):Patch(wireFormatparam, function(result)
    this:SetData("Space/SelectedPlayer", result)
    WU.RecycleWindow("MedalSelection")
  end)
end
