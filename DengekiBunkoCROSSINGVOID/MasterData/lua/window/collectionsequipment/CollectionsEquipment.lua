local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local EA = require("Common/EquipAttr")
local AU = require("Common/ActorUtil")
local EU = require("Common/EquipUtil")
local m_displaySuit, m_suitEquipmentData, m_isolatedEquipmentData
local m_ownEquipments = {}
local m_showMaxAttr = false
local m_currentSuitId, m_EquipmentCount, m_sortWrapData
local m_reuseTable = REF.WrapContentSuitArmList.ReuseTable
local m_scrollView = REF.ScrollViewArm.UIScrollView
local m_maxCol = 6
local m_allArms = {}
local m_currentArmsInfo = {}

function SetupWindow()
  local allArms = PB.all("UniqueWeaponInfo")
  table.copy(allArms, m_allArms, true)
  CreateEquipmentData()
  REF.WidgetTabSlotSuit["$SetClickCallback"](function()
    WU.RecordButtonClick(100136101)
    ShowSuit()
    REF.CollectionProgress.gameObject:SetActive(true)
  end)
  REF.WidgetTabSlotSingle["$SetClickCallback"](function()
    WU.RecordButtonClick(100136002)
    ShowSingle()
    REF.CollectionProgress.gameObject:SetActive(true)
  end)
  REF.WidgetTabSlotSuitArm["$SetClickCallback"](function()
    ShowArms()
    REF.CollectionProgress.gameObject:SetActive(false)
  end)
  REF.WidgetTabSlotSuit["$SetTab"](WU.GetString("WindowCollections_Suit"), "Journey", "equipment/collection_category_1", false)
  REF.WidgetTabSlotSingle["$SetTab"](WU.GetString("WindowCollections_SingleEquipment"), "Journey", "equipment/collection_category_2", false)
  REF.WidgetTabSlotSuitArm["$SetTab"](WU.GetString("UniqueWeapon_Impression"), "ActorUI", "profile_category_7", false)
  WU.TraverseChildren(REF.WrapContentSuitList, function(rowGo)
    WU.BindButtonEvent(_ENV["$"](rowGo).root, function(go)
      SetSuitSelected(_ENV["$"](go))
    end)
  end)
  m_reuseTable.onInitializeItem = UpdateSlotArms
  m_reuseTable.onGetChildWidget = Trans2BoundsWidget
  m_reuseTable:SetDataCount(0)
end

function UpdateSlotArms(go, wrapIndex, realIndex)
  if m_sortWrapData ~= nil and realIndex < #m_sortWrapData then
    local ref = _ENV["$"](go)
    local armInfo = m_sortWrapData[realIndex + 1]
    if armInfo ~= nil then
      if armInfo.Desc ~= nil then
        ref["$$ShowDesc"](armInfo)
      else
        ref["$$ShowCustom"](armInfo)
      end
    end
  end
end

function SortWrapData()
  local seriesList = {}
  m_sortWrapData = {}
  local now = CS.GameTime.serverUtc
  table.sort(m_allArms, function(a, b)
    if a.seriesId == b.seriesId then
      return a.id < b.id
    else
      return a.seriesId < b.seriesId
    end
  end)
  for k, v in pairs(m_allArms) do
    if v.seriesId then
      if seriesList[v.seriesId] == nil then
        seriesList[v.seriesId] = {}
      end
      local index = table.find(m_currentArmsInfo, function(_, m)
        return v.id == m.id
      end)
      local preInfo = {
        id = v.id,
        phase = 1,
        openTime = v.openTime,
        hideLevel = true,
        showEquip = false,
        showStar = false
      }
      local maxInfo = {
        id = v.id,
        phase = PB.all("Misc")[1].weaponMisc.weaponMaxPhase,
        openTime = v.openTime,
        hideLevel = true,
        showEquip = false,
        showStar = false
      }
      if index then
        preInfo.isHas = true
        if m_currentArmsInfo[index].phase < PB.all("Misc")[1].weaponMisc.weaponMaxPhase - 1 then
          maxInfo.isHas = false
        else
          maxInfo.isHas = true
        end
      else
        preInfo.isHas = false
        maxInfo.isHas = false
      end
      if now >= CS.GameTime.ServerTimeStrToUtc(v.openTime) then
        table.insert(seriesList[v.seriesId], preInfo)
        table.insert(seriesList[v.seriesId], maxInfo)
      end
    end
  end
  for k, data in pairs(seriesList) do
    local allNum = #data
    local hasNum = 0
    for i = 0, math.ceil(#data / m_maxCol) - 1 do
      local showInfo = {}
      for j = 1, m_maxCol do
        showInfo[j] = data[i * m_maxCol + j]
        if showInfo[j] and showInfo[j].isHas == true then
          hasNum = hasNum + 1
        end
      end
      table.insert(m_sortWrapData, showInfo)
    end
    table.insert(m_sortWrapData, {
      Desc = k,
      heightNum = math.ceil(#data / m_maxCol),
      textNum = hasNum .. "/" .. allNum
    })
  end
end

function OnArmsChange(armsInfo)
  m_currentArmsInfo = armsInfo
  SortWrapData()
end

function InitWindow()
  WU.ToggleRendering(REF.NodeEquipmentList, false)
  REF.CollectionProgress.gameObject:SetActive(false)
  this:Bind("fci/arms", OnArmsChange)
  LU.Bind(REF.WrapContentSuitList, {
    dataSource = SlotDataPrivoder,
    updateSlot = UpdateSlot,
    updateRow = UpdateRowSuit,
    delta = 0.01,
    slotsName = "Slots"
  })
  LU.Bind(REF.WrapContentSingleList, {
    dataSource = SlotDataPrivoder,
    updateSlot = UpdateSlot,
    delta = 0.01,
    slotsName = "Slots"
  })
end

function CreateEquipmentData()
  local suitEquips = {}
  m_EquipmentCount = 0
  m_suitEquipmentData = _ENV["!"]({})
  local suitInfos = PB.all("EquipSuitAttr")
  local suitCount = #suitInfos
  for i = 1, suitCount do
    local index = suitCount - i + 1
    local suitId = suitInfos[index].id
    local equipments = {}
    for j = 1, 4 do
      local equipId = suitInfos[index].equipId[j]
      if equipId and EU.IsEquipOpen(equipId) then
        table.insert(equipments, equipId)
        suitEquips[equipId] = true
      end
    end
    if 0 < #equipments then
      m_suitEquipmentData:insert({suitId = suitId, equipments = equipments})
      m_EquipmentCount = m_EquipmentCount + #equipments
    end
  end
  m_suitEquipmentData:sort(function(a, b)
    local ia = PB.get("EquipSuitAttr", a.suitId).collectionsIndex
    local ib = PB.get("EquipSuitAttr", b.suitId).collectionsIndex
    if ia ~= ib then
      return ia < ib
    end
    return a.suitId < b.suitId
  end)
  m_isolatedEquipmentData = _ENV["!"]({})
  local isPreCommit = WU.IsPreCommit()
  local isolatedEquips = PB.all("EquipInfo"):where(function(_, v)
    if not EU.IsEquipOpen(v.equipId) then
      return false
    end
    if isPreCommit then
      return v.collectionsIndex ~= 0 and v.collectionsIndex ~= 5 and suitEquips[v.equipId] == nil
    else
      return v.collectionsIndex ~= 0 and suitEquips[v.equipId] == nil
    end
  end):toarray():sort(function(a, b)
    if a.collectionsIndex ~= b.collectionsIndex then
      return a.collectionsIndex < b.collectionsIndex
    end
    if a.pos ~= b.pos then
      return a.pos < b.pos
    end
    return a.equipId < b.equipId
  end)
  local count = #isolatedEquips
  m_EquipmentCount = m_EquipmentCount + count
  for i = 1, (count + 5) // 6 do
    local equipments = {}
    for j = 1, 6 do
      local eIndex = (i - 1) * 6 + j
      if count < eIndex then
        break
      end
      table.insert(equipments, isolatedEquips[eIndex].equipId)
    end
    if #equipments ~= 0 then
      m_isolatedEquipmentData:insert(equipments)
    end
  end
end

function ShowSuit()
  m_displaySuit = true
  WU.ToggleRendering(REF.NodeSuitList, true)
  WU.ToggleRendering(REF.NodeSingleList, false)
  WU.ToggleRendering(REF.NodeSuitEffect, true)
  WU.ToggleRendering(REF.NodeSuitArmList, false)
  LU.Set(REF.WrapContentSuitList, #m_suitEquipmentData)
  SetSuitSelected(REF.WrapContentSuitList[0])
end

function ShowSingle()
  m_displaySuit = false
  WU.ToggleRendering(REF.NodeSingleList, true)
  WU.ToggleRendering(REF.NodeSuitList, false)
  WU.ToggleRendering(REF.NodeSuitEffect, false)
  WU.ToggleRendering(REF.NodeSuitArmList, false)
  LU.Set(REF.WrapContentSingleList, #m_isolatedEquipmentData)
end

function ShowArms()
  m_displaySuit = false
  WU.ToggleRendering(REF.NodeSuitList, false)
  WU.ToggleRendering(REF.NodeSingleList, false)
  WU.ToggleRendering(REF.NodeSuitEffect, false)
  WU.ToggleRendering(REF.NodeSuitArmList, true)
  m_reuseTable:SetDataCount(#m_sortWrapData)
  m_scrollView:ResetPosition()
end

function ShowProgress()
  local ownCount = _ENV["!"](m_ownEquipments):count()
  if ownCount > m_EquipmentCount then
    ownCount = m_EquipmentCount
  end
  local str = tostring(ownCount)
  REF.LabelHaveNum.UILabel.text = string.sub(str, 1, 1)
  REF.LabelHaveNumR.UILabel.text = string.sub(str, 2, string.len(str))
  str = tostring(m_EquipmentCount)
  REF.LabelAllNum.UILabel.text = string.sub(str, 1, 1)
  REF.LabelAllNumR.UILabel.text = string.sub(str, 2, string.len(str))
  REF.CollectionProgress.gameObject:SetActive(true)
end

function SlotDataPrivoder(dataIndex)
  local result
  if m_displaySuit then
    local row = (dataIndex + 3) // 4
    local suitInfo = m_suitEquipmentData[row]
    if suitInfo ~= nil then
      for i = 1, #suitInfo.equipments do
        local equipInfo = PB.get("EquipInfo", suitInfo.equipments[i])
        if equipInfo and equipInfo.pos == (dataIndex - 1) % 4 then
          result = equipInfo
          break
        end
      end
    end
  else
    local row = (dataIndex + 5) // 6
    local col = dataIndex - (row - 1) * 6
    local isolateInfo = m_isolatedEquipmentData[row]
    if isolateInfo ~= nil then
      result = PB.get("EquipInfo", isolateInfo[col])
    end
  end
  if result == nil then
    result = 0
  end
  return result
end

function UpdateSlot(slotRef, data)
  slotRef = slotRef["$"][0]
  slotRef["@equipId"] = nil
  if data ~= nil then
    if data ~= 0 then
      slotRef["@equipId"] = data.equipId
      slotRef["$$SetData"](PB.enum.ResourceType.ResEquip, data.equipId, 1)
      slotRef["$$ShowCustom"]({
        unknown = not m_ownEquipments[data.equipId]
      })
      slotRef["$$SetClickCallback"](OnClickEquipmentSlot)
    else
      slotRef["$$SetEmpty"](2)
    end
  else
    slotRef["$$ClearSlot"]()
  end
end

function UpdateRowSuit(rowRef, wrapIndex, rowIndex)
  local rowSpriteName = "equipment/collection_bg_1"
  if m_displaySuit and rowIndex then
    local suitInfo = m_suitEquipmentData[rowIndex + 1]
    if suitInfo ~= nil then
      rowRef["@suitId"] = suitInfo.suitId
      if suitInfo.suitId == m_currentSuitId then
        rowSpriteName = "equipment/collection_bg_2"
      end
      rowRef.LabelSuitName.UILabel.text = WU.GetString("Window_SuitName_" .. tostring(suitInfo.suitId))
    end
  end
  rowRef["$UISprite"].spriteName = rowSpriteName
end

function OnClickEquipmentSlot(go)
  local ref = _ENV["$"](go)
  if m_displaySuit then
    SetSuitSelected(_ENV["$"](go.transform.parent.parent.parent))
  end
  local level = 1
  if m_showMaxAttr then
    level = PB.all("PlayerLevelInitConfig"):last().equipLevelLimit
  end
  if ref["@equipId"] ~= nil then
    WU.ShowEquipDetailById(ref["@equipId"], level)
  end
end

function SetSuitSelected(ref)
  if not m_displaySuit then
    return
  end
  local suitId = ref["@suitId"]
  m_currentSuitId = suitId
  WU.TraverseChildren(REF.WrapContentSuitList, function(rowGo)
    local theRef = _ENV["$"](rowGo)
    if theRef == ref then
      theRef["$UISprite"].spriteName = "equipment/collection_bg_2"
    else
      theRef["$UISprite"].spriteName = "equipment/collection_bg_1"
    end
  end)
  SetSuitEffectLabel(suitId)
end

function SetSuitEffectLabel(suitId, isMax)
  local desc = ""
  local resSuit = PB.get("EquipSuitAttr", suitId)
  local suitAttrListHtml = ""
  local count = 0
  for i = 1, #resSuit.equipId do
    if m_ownEquipments[resSuit.equipId[i]] then
      count = count + 1
    end
  end
  for i = 1, #resSuit.suitAttr do
    local specialAttrId = resSuit.suitAttr[i].specialAttrId
    local specialAttr = EA.GetSpecialAttr(specialAttrId)
    if specialAttr then
      local suitCount = resSuit.suitAttr[i].suitCount
      local active = count >= suitCount
      local countHtml = WU.GetString("Window_SuitNum", suitCount)
      local suitHtml = AU.GetSpecialEffectDesc(specialAttrId, specialAttr.effect, "#72e6ff")
      if 1 < i then
        suitAttrListHtml = suitAttrListHtml .. "<br/><br/>"
      end
      suitAttrListHtml = suitAttrListHtml .. countHtml .. suitHtml
    end
  end
  REF.LabelSuitEffect.UIHtmlLabel.text = suitAttrListHtml
end

function Trans2BoundsWidget(trans)
  local ref = _ENV["$"](trans)
  if ref["@type"] == 1 then
    ref.Container.transform.localPosition = CS.UnityEngine.zero
    ref.Container.UIWidget.height = 380
  elseif ref["@type"] == 2 then
    ref.Container.transform.localPosition = CS.UnityEngine.Vector3(0, 142, 0)
    ref.Container.UIWidget.height = 100
  end
  return ref.Container.UIWidget
end

function SetArmTab()
  this:GameRequest("fci/CollectionsEquip"):Get(function(response)
    if response == nil then
      return
    end
    for i = 1, #response.equips do
      m_ownEquipments[response.equips[i].equipId] = true
    end
    WU.ToggleRendering(REF.NodeEquipmentList, true)
    REF.WidgetTabSlotSuitArm["$SetSelected"]()
    ShowArms()
    ShowProgress()
    REF.CollectionProgress.gameObject:SetActive(false)
  end)
end

function ResetUIToggle()
  REF.WidgetTabSlotSingle.UIToggle.optionCanBeNone = true
  REF.WidgetTabSlotSingle.UIToggle.value = false
  REF.WidgetTabSlotSingle.UIToggle.optionCanBeNone = false
  REF.WidgetTabSlotSuit.UIToggle.optionCanBeNone = true
  REF.WidgetTabSlotSuit.UIToggle.value = false
  REF.WidgetTabSlotSuit.UIToggle.optionCanBeNone = false
  REF.WidgetTabSlotSuitArm.UIToggle.optionCanBeNone = true
  REF.WidgetTabSlotSuitArm.UIToggle.value = false
  REF.WidgetTabSlotSuitArm.UIToggle.optionCanBeNone = false
end

function Focus(on)
  WU.RecordWindowFocus(1001361, on)
end

function SetSuitTab()
  this:GameRequest("fci/CollectionsEquip"):Get(function(response)
    if response == nil then
      return
    end
    for i = 1, #response.equips do
      m_ownEquipments[response.equips[i].equipId] = true
    end
    WU.ToggleRendering(REF.NodeEquipmentList, true)
    REF.WidgetTabSlotSuit["$SetSelected"]()
    ShowSuit()
    ShowProgress()
  end)
end
