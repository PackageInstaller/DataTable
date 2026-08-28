local CommonItem = require("Common/BtnItem")
local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local DataModel = require("UIGroup_Weapon/UIGroup_WeaponDataModel")
local Controller = {}
local StateEnum = {
  [0] = "Btn_All",
  "Btn_S01",
  "Btn_S02"
}
local GroupEnum = {
  [0] = "Btn_All",
  "Btn_C01",
  "Btn_C02",
  "Btn_C03",
  "Btn_C04",
  "Btn_C05",
  "Btn_C06",
  "Btn_C07",
  "Btn_C08",
  "Btn_C09"
}
local RarityEnum = {
  [0] = "Btn_All",
  "Btn_G01",
  "Btn_G02",
  "Btn_G03",
  "Btn_G04"
}
local RarityFilterIndex = {
  [1] = 5,
  [2] = 4,
  [3] = 3,
  [4] = 2
}
local RaritySwitchIndex = {
  2,
  3,
  4,
  5
}

local function GetFilterSelf()
  if View.Group_Filter.self == nil and View.self then
    local transform = View.self.transform:Find("Group_Filter")
    if transform then
      View.Group_Filter.self = transform:GetComponent(typeof(CS.Seven.UIGroup))
    end
  end
  return View.Group_Filter.self
end

local function SwitchFilter(filter, index)
  if index ~= 0 or not filter[index] then
    filter[index] = not filter[index]
  end
  local len = #filter
  if filter[0] then
    for i = 1, len do
      filter[i] = false
    end
  else
    local isAll = true
    local isAntiAll = true
    for i = 1, len do
      isAll = isAll and filter[i]
      isAntiAll = isAntiAll and not filter[i]
    end
    if isAll or isAntiAll then
      filter[0] = true
      for i = 1, len do
        filter[i] = false
      end
    else
      filter[0] = false
    end
  end
end

local function SwitchFilterWithIndexList(filter, index, indexList)
  if index ~= 0 or not filter[index] then
    filter[index] = not filter[index]
  end
  if filter[0] then
    for _, filterIndex in ipairs(indexList) do
      filter[filterIndex] = false
    end
  else
    local isAll = true
    local isAntiAll = true
    for _, filterIndex in ipairs(indexList) do
      isAll = isAll and filter[filterIndex]
      isAntiAll = isAntiAll and not filter[filterIndex]
    end
    if isAll or isAntiAll then
      filter[0] = true
      for _, filterIndex in ipairs(indexList) do
        filter[filterIndex] = false
      end
    else
      filter[0] = false
    end
  end
end

local function IsSameButton(btn, viewBtn)
  if btn == nil or viewBtn == nil or viewBtn.self == nil then
    return false
  end
  if btn == viewBtn.self then
    return true
  end
  return btn.transform ~= nil and viewBtn.self.transform ~= nil and btn.transform == viewBtn.self.transform
end

local function GetButtonIndex(btn, group, enum, fallbackIndex)
  for i = 0, #enum do
    local viewBtn = group[enum[i]]
    if IsSameButton(btn, viewBtn) then
      return i
    end
  end
  return fallbackIndex
end

function Controller:RefreshFilterView()
  local Group_Group = View.Group_Filter.Group_Group
  Group_Group.Btn_All.Img_Select:SetActive(DataModel.FilterGroup[0])
  for i = 1, #DataModel.FilterGroup do
    local btn = Group_Group[GroupEnum[i]]
    if btn and btn.Img_Select then
      btn.Img_Select:SetActive(DataModel.FilterGroup[i])
    end
  end
  local Group_Rarity = View.Group_Filter.Group_Rarity
  Group_Rarity.Btn_All.Img_Select:SetActive(DataModel.FilterRarity[0])
  for i = 1, #RarityEnum do
    local btn = Group_Rarity[RarityEnum[i]]
    if btn and btn.Img_Select then
      btn.Img_Select:SetActive(DataModel.FilterRarity[RarityFilterIndex[i]])
    end
  end
  local Group_State = View.Group_Filter.Group_State
  for i = 0, #DataModel.FilterState do
    if Group_State[StateEnum[i]] then
      Group_State[StateEnum[i]].Img_Select:SetActive(DataModel.FilterState[i])
    end
  end
end

function Controller:InitFilter()
  DataModel:InitFilter()
  local filterSelf = GetFilterSelf()
  if filterSelf == nil then
    return
  end
  filterSelf:SetActive(false)
  local Group_Group = View.Group_Filter.Group_Group
  for i = 1, #GroupEnum do
    local btn = Group_Group[GroupEnum[i]]
    local data = DataModel.FilterCampList[i]
    if btn and btn.self then
      btn.self:SetActive(data ~= nil)
      btn.self:SetClickParam(tostring(i))
      if data and btn.Txt_ then
        btn.Txt_:SetText(data.name)
      end
    end
  end
  local Group_Rarity = View.Group_Filter.Group_Rarity
  for i = 1, #RarityEnum do
    local btn = Group_Rarity[RarityEnum[i]]
    local rarityIndex = RarityFilterIndex[i]
    if btn and btn.self then
      btn.self:SetClickParam(tostring(rarityIndex))
      if btn.Img_ and UIConfig and UIConfig.EquipTipRarity and UIConfig.EquipTipRarity[rarityIndex] then
        btn.Img_:SetSprite(UIConfig.EquipTipRarity[rarityIndex])
        btn.Img_:SetActive(true)
      end
    end
  end
  Controller:RefreshFilterView()
  DataModel.IsFilterViewInit = true
end

function Controller:OpenFilter()
  if DataModel.IsFilterViewInit ~= true then
    Controller:InitFilter()
  end
  local filterSelf = GetFilterSelf()
  if filterSelf then
    filterSelf:SetActive(true)
    filterSelf.transform:SetAsLastSibling()
  end
end

function Controller:SwitchFilterGroup(index)
  if index ~= 0 then
    DataModel.FilterGroup[0] = false
  end
  SwitchFilter(DataModel.FilterGroup, index)
  Controller:RefreshFilterView()
end

function Controller:SwitchFilterGroupByBtn(btn, index)
  Controller:SwitchFilterGroup(GetButtonIndex(btn, View.Group_Filter.Group_Group, GroupEnum, index))
end

function Controller:SwitchFilterRarity(index)
  if index ~= 0 then
    DataModel.FilterRarity[0] = false
  end
  SwitchFilterWithIndexList(DataModel.FilterRarity, index, RaritySwitchIndex)
  Controller:RefreshFilterView()
end

function Controller:SwitchFilterRarityByBtn(btn, index)
  local buttonIndex = GetButtonIndex(btn, View.Group_Filter.Group_Rarity, RarityEnum, index)
  Controller:SwitchFilterRarity(RarityFilterIndex[buttonIndex] or buttonIndex)
end

function Controller:SwitchFilterState(index)
  if index ~= 0 then
    DataModel.FilterState[0] = false
  end
  SwitchFilter(DataModel.FilterState, index)
  Controller:RefreshFilterView()
end

function Controller:SwitchFilterStateByBtn(btn, index)
  Controller:SwitchFilterState(GetButtonIndex(btn, View.Group_Filter.Group_State, StateEnum, index))
end

function Controller:Init()
  Controller:InitFilter()
  View.Group_Detail.self:SetActive(false)
  View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(true)
  View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(false)
  View.Group_Center.StaticGrid_Character.self:SetActive(DataModel.IsSquad)
  Controller:ClosePresets(false, true)
  DataModel:RefreshAllRoleData()
  DataModel:ChooseLeftTop(DataModel.RoleEquipIndex)
  Controller:Load()
  View.self:PlayAnim("In_Equipment")
  Controller:RefreshCenterEquip()
  if DataModel.IsSquad then
    DataModel:SetCenterSquadsData()
    Controller:RefreshCenterSquad()
  end
end

function Controller:RefreshCenterSquad()
  View.Group_Center.StaticGrid_Character.grid.self:SetDataCount(table.count(DataModel.SquadRoleListData))
  View.Group_Center.StaticGrid_Character.grid.self:RefreshAllElement()
  local index = DataModel.CenterSquadsIndex
  DataModel.CenterSquadsIndex = nil
  if index == nil then
    return
  end
  Controller:ClickCenterSquads(index)
end

function Controller:SetCenterSquadsRole(element, elementIndex)
  local row = DataModel.SquadRoleListData[elementIndex]
  element.Btn_ProfilePhoto.Img_Head:SetSprite(row.face)
  element.Btn_ProfilePhoto:SetClickParam(elementIndex)
  element:SetAlpha(0.5)
end

function Controller:ClickCenterSquads(index)
  local function callBack()
    local index = tonumber(index)
    
    local row = DataModel.SquadRoleListData[index]
    if DataModel.CenterSquadsIndex then
      local old = View.Group_Center.StaticGrid_Character.grid[DataModel.CenterSquadsIndex]
      old:SetAlpha(0.5)
    end
    local element = View.Group_Center.StaticGrid_Character.grid[index]
    if element then
      element:SetAlpha(1)
    end
    DataModel.CenterSquadsIndex = index
    if tostring(row.roleId) ~= DataModel.RoleId then
      DataModel:RefreshSquadsRole(row.roleId, true)
      Controller:Init()
    end
  end
  
  DataModel:SendEquipLockData(callBack)
end

function Controller:RefreshCenterEquip()
  View.Group_Center.StaticGrid_Equipment.grid.self:RefreshAllElement()
end

function Controller:SetCenterEquipElement(element, elementIndex)
  local row = DataModel.RoleSeverEquip[elementIndex]
  element.Btn_Item:SetClickParam(elementIndex)
  element.Group_Equipment.Btn_Item:SetClickParam(elementIndex)
  element.Btn_Item:SetActive(true)
  element.Img_Ban:SetActive(false)
  element.Group_Equipment.Img_NoType:SetActive(false)
  element.Group_Equipment.Img_Select:SetActive(false)
  element.Btn_Item.Img_Type:SetActive(row.eid ~= "")
  if row.eid == "" then
    element.Group_Equipment:SetActive(false)
    element.Img_Select:SetActive(false)
  else
    local index = row.index
    element.Img_Select:SetActive(index == DataModel.RoleEquipIndex)
    element.Group_Equipment:SetActive(true)
    element.Btn_Item.Img_Type:SetSprite(UIConfig.EquipBgType[index])
    CommonItem:SetEquipment(element.Group_Equipment, row.list, false)
    element.Group_Equipment.Group_Face:SetActive(false)
    element.Group_Equipment.Img_Lock:SetActive(false)
  end
end

function Controller:ClickCenterEquip(index)
  local index = tonumber(index)
  local row = DataModel.RoleSeverEquip[index]
  
  local function callBack()
    DataModel:ChooseLeftTop(index)
    if row.eid ~= "" then
      DataModel:ChooseEquip(1)
    end
  end
  
  DataModel:SendEquipLockData(callBack)
  Controller:RefreshCenterEquip()
end

function Controller:ClosePresets(state, init)
  DataModel.isPresets = false
  View.Group_Left.self:SetActive(true)
  View.Group_Left_Presets.self:SetActive(false)
  View.Group_Center.Btn_Detail.self:SetActive(false)
  View.Group_Center.Btn_Presets.self:SetActive(true)
  View.Group_Center.Btn_Compare.self:SetActive(true)
  if state then
    local index = DataModel.LeftTopTagIndex
    DataModel.LeftTopTagIndex = nil
    DataModel:ChooseLeftTop(index)
  end
  if not init then
    View.self:PlayAnim("Out_Presets")
  end
end

function Controller:Load(self, skinId, isSkin)
  local portraitId = DataModel.RoleSeverData.current_skin[1]
  if skinId then
    portraitId = skinId
  end
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  View.Group_Middle.SpineAnimation_Character:SetActive(false)
  View.Group_Middle.SpineSecondMode_Character:SetActive(false)
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  local live2D = PlayerData:GetPlayerPrefs("int", DataModel.RoleId .. "live2d")
  DataModel.live2D = live2D
  local isSpine2 = false
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    View.Group_Middle.Group_Character.self:SetActive(false)
    View.Group_Middle.SpineAnimation_Character:SetActive(true)
    local spineUrl = portrailData.spineUrl
    local state = false
    if DataModel.RoleSeverData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" and DataModel.RoleSeverData.current_skin[2] == 1 then
      state = true
    end
    if isSkin ~= nil then
      state = isSkin
    end
    if state == true then
      spineUrl = portrailData.spine2Url
      isSpine2 = true
    end
    View.Group_Middle.SpineAnimation_Character:SetActive(not isSpine2)
    View.Group_Middle.SpineSecondMode_Character:SetActive(isSpine2)
    View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(1, 1, 1))
    if live2D == 1 then
      View.Group_Middle.SpineAnimation_Character:SetActive(false)
      View.Group_Middle.SpineSecondMode_Character:SetActive(false)
      View.Group_Middle.Group_Character.self:SetActive(true)
      if isSpine2 == true then
        View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.State2Res)
      else
        View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
      end
      View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
      DataModel.InfoInitPos.isRecord = true
      if DataModel.InfoInitPos.isRecord then
        DataModel.InfoInitPos.isRecord = false
        local transform = View.Group_Middle.transform
        View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
        DataModel.InfoInitPos.y = transform.localPosition.y
        DataModel.InfoInitPos.scale = transform.localScale.x
      end
      DataModel.InfoInitPos.offsetX = portrailData.offsetX
      DataModel.InfoInitPos.offsetY = portrailData.offsetY
    elseif isSpine2 then
      View.Group_Middle.SpineSecondMode_Character:SetPrefab(spineUrl)
      View.Group_Middle.SpineAnimation_Character:SetData("")
      View.Group_Middle.SpineSecondMode_Character.transform.localPosition = Vector3(0, 0, 0)
      if portrailData.state2Overturn == true then
        View.Group_Middle.SpineSecondMode_Character:SetLocalScale(Vector3(-1, 1, 1))
      end
    else
      View.Group_Middle.SpineAnimation_Character:SetActive(true)
      View.Group_Middle.SpineSecondMode_Character:SetPrefab("")
      View.Group_Middle.SpineAnimation_Character:SetData(spineUrl)
      View.Group_Middle.SpineAnimation_Character:SetLocalScale(Vector3(100, 100, 1))
      View.Group_Middle.SpineAnimation_Character.transform.localPosition = Vector3(0, -1200 + portrailData.spineY, 0)
    end
  else
    View.Group_Middle.SpineAnimation_Character:SetActive(false)
    View.Group_Middle.Group_Character.self:SetActive(true)
    View.Group_Middle.Group_Character.Img_Character:SetSprite(portrailData.resUrl)
    View.Group_Middle.Group_Character.Img_Character:SetNativeSize()
    if DataModel.InfoInitPos.isRecord then
      DataModel.InfoInitPos.isRecord = false
      local transform = View.Group_Middle.transform
      View.Group_Middle.Group_Character.self:SetLocalPositionX(DataModel.InfoInitPos.x)
      DataModel.InfoInitPos.y = transform.localPosition.y
      DataModel.InfoInitPos.scale = transform.localScale.x
    end
    DataModel.InfoInitPos.offsetX = portrailData.offsetX
    DataModel.InfoInitPos.offsetY = portrailData.offsetY
  end
  View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(1, 1, 1))
  if DataModel.InfoInitPos.isRecord == false and isSpine2 == false then
    local portrailData = PlayerData:GetFactoryData(DataModel.RoleSeverData.current_skin[1], "UnitViewFactory")
    local pos = DataModel.InfoInitPos
    local posX = pos.x + portrailData.offsetX * pos.scale
    local posY = pos.y + portrailData.offsetY * pos.scale
    View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(0, portrailData.offsetY, 0))
    if isSpine2 == true then
      posX = pos.x + portrailData.spine2X * pos.scale
      posY = pos.y + portrailData.spine2Y * pos.scale
      View.Group_Middle.Group_Character.Img_Character:SetLocalPosition(Vector3(0, 0, 0))
    end
    View.Group_Middle.Group_Character.Img_Character:SetLocalScale(Vector3(portrailData.offsetScale, portrailData.offsetScale, portrailData.offsetScale))
  end
  DataModel.NowSkin = {}
  DataModel.NowSkin.portraitId = tonumber(portraitId)
  DataModel.NowSkin.isSpine2 = isSpine2 == true and 1 or 0
end

return Controller
