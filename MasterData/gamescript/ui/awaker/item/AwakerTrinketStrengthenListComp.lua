local ToggleType = CommonDefine.TrinketUpgradeMatType
local ItemType = CommonDefine.ItemType
local AwakerTrinketStrengthenListComp, Super = System.NewComponent("AwakerTrinketStrengthenListComp")

function AwakerTrinketStrengthenListComp:ctor(uiNode, strengthenModel)
  Super.ctor(self)
  self.ui = UI_Awaker_Popup_Trinket_Intensify_ListResource(uiNode)
  self.strengthenModel = strengthenModel
end

local StateTable = {"Normal", "Select"}

function AwakerTrinketStrengthenListComp:OnBind(binder)
  binder:BindButtonClick(self.ui.Btn_Sort, function()
    self.strengthenModel:SetSortOrder()
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Level, nil, function(isOn)
    self.strengthenModel:SetSortTypeShow(isOn)
    if isOn then
      binder:SetActive(self.ui.Group_Sort_List, true)
    end
  end, function()
    return self.strengthenModel.sortTypeShow
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Trinket, nil, function(isOn)
    if isOn then
      self.strengthenModel:SetToggleType(ToggleType.Trinket)
    end
  end, function()
    return self.strengthenModel.currToggle == ToggleType.Trinket
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Weapon, nil, function(isOn)
    if isOn then
      self.strengthenModel:SetToggleType(ToggleType.Weapon)
    end
  end, function()
    return self.strengthenModel.currToggle == ToggleType.Weapon
  end)
  binder:BindToText(self.ui.Text_None, function()
    local listSize = #self.strengthenModel.showList
    if listSize > 0 then
      return ""
    end
    local tipKey = "TrinketStrengthenEmptyStateTips_1"
    if self.strengthenModel.currToggle == ToggleType.Weapon then
      tipKey = "TrinketStrengthenEmptyStateTips_2"
    end
    do return LT.Text end
    return LT.Text, tipKey
  end)
  local commonIconItemModel = binder:createModel(CommonIconItemModel)
  binder:BindToCircularListView(self.ui.ScrollView_Trinket_List, function()
    return self.strengthenModel.showList
  end, function(childBinder, obj, index)
    local materialUid = self.strengthenModel.showList[index]
    local data = self.strengthenModel:GetItemData(materialUid)
    local itemType = self.strengthenModel:GetItemType(data.tid)
    
    local function OnClick(tid, uid)
      if not tid or not uid then
        return
      end
      self.strengthenModel.trinketModel:ReqRemoveNew(uid)
      local chosenUidMap = self.strengthenModel.chosenUidMap
      local hasChosen = nil ~= chosenUidMap[uid]
      local isTrinketExpItem = self.strengthenModel:IsTrinketExpItem(uid)
      if isTrinketExpItem then
        self.strengthenModel:SetShowTipUid(0)
      else
        self.strengthenModel:SetShowTipUid(uid)
      end
      local maxLevel = self.strengthenModel:GetTrinketMaxLevel(self.strengthenModel.strengthenTid)
      if maxLevel <= self.strengthenModel.currTrinketLevel then
        Alert.Show(10496)
        return
      end
      if ItemDataUtils.GetItemLocked(uid) then
        if itemType == ItemType.Weapon then
          Alert.Show(10493)
        elseif itemType == ItemType.Trinket then
          Alert.Show(10492)
        end
        return
      end
      local afterLevelData = self.strengthenModel.afterLevelData
      local isMaxLevel = afterLevelData.isMaxLevel
      if isMaxLevel then
        Alert.Show(10496)
        return
      end
      if hasChosen and not isTrinketExpItem then
        return
      end
      self.strengthenModel:ChooseMaterial(uid)
    end
    
    local function OnSubClick(tid, uid)
      if not tid or not uid then
        return
      end
      local hasRemove = not self.strengthenModel:ChooseMaterial(uid, -1)
      if hasRemove then
        self.strengthenModel:SetShowTipUid(0)
      end
    end
    
    local function IsLastClicked()
      return materialUid == self.strengthenModel.showTipUid
    end
    
    local function IsChosen()
      local chosenData = self.strengthenModel.chosenUidMap[materialUid]
      return chosenData and chosenData.num > 0
    end
    
    local function selectNumFunc()
      local chosenData = self.strengthenModel.chosenUidMap[materialUid]
      return chosenData and chosenData.num or 0
    end
    
    local itemData = {
      tid = data.tid,
      uid = data.uid,
      model = commonIconItemModel,
      showMultiSelect = itemType == ItemType.Material,
      selectedFunc = IsChosen,
      selectNumFunc = selectNumFunc,
      clickFrameShowFunc = IsLastClicked,
      btnSubFunc = OnSubClick,
      callback = OnClick,
      strengthenModel = self.strengthenModel
    }
    childBinder:BindComponent(AwakerTrinketStrengthenMaterial(obj, itemData))
  end)
  binder:BindToCircularListView(self.ui.ScrollView_Sort_List, function()
    return self.strengthenModel.sortTypeList
  end, function(childBinder, obj, index)
    local sortTypeName = ""
    if self.strengthenModel.currToggle == ToggleType.Trinket then
      sortTypeName = self.strengthenModel:GetSortTypeName(index)
    elseif self.strengthenModel.currToggle == ToggleType.Weapon then
      sortTypeName = self.strengthenModel:GetWeaponSortTypeName(index)
    end
    
    local function IsSelected()
      return self.strengthenModel.sortType == index
    end
    
    local function OnClick(sortType)
      if not sortType then
        return
      end
      self.strengthenModel:SetSortType(sortType)
      self.strengthenModel:SetSortTypeShow(false)
    end
    
    local itemData = {
      tid = index,
      name = sortTypeName,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    childBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
  binder:BindToAnimator(self.ui.Group_Sort_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.Group_Sort_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.strengthenModel.sortTypeShow
  end)
  for _, stateName in pairs(StateTable) do
    local TextSortObj = self.ui["Text_Level_" .. stateName]
    if TextSortObj then
      binder:BindToText(TextSortObj, function()
        local sortType = self.strengthenModel.sortType
        local sortTypeName = ""
        if self.strengthenModel.currToggle == ToggleType.Trinket then
          sortTypeName = self.strengthenModel:GetSortTypeName(sortType)
        elseif self.strengthenModel.currToggle == ToggleType.Weapon then
          sortTypeName = self.strengthenModel:GetWeaponSortTypeName(sortType)
        end
        return sortTypeName
      end)
    end
    local TextTabTrinketObj = self.ui["Text_1_" .. stateName]
    if TextTabTrinketObj then
      binder:BindToText(TextTabTrinketObj, function()
        local list = self.strengthenModel.trinketMaterialList
        local title = LT.Textf("TrinketStrengthenItemNum_1", #list)
        return title
      end)
    end
    local TextTabWeaponObj = self.ui["Text_2_" .. stateName]
    if TextTabWeaponObj then
      binder:BindToText(TextTabWeaponObj, function()
        local list = self.strengthenModel.weaponMaterialList
        local title = LT.Textf("TrinketStrengthenItemNum_2", #list)
        return title
      end)
    end
  end
  binder:BindToText(self.ui.Text_Sort_Normal, function()
    local sortOrder = self.strengthenModel.sortOrder
    do return self.strengthenModel.GetSortOrderName, self.strengthenModel end
    return self.strengthenModel.GetSortOrderName, self.strengthenModel, sortOrder
  end)
end

function AwakerTrinketStrengthenListComp:OnUnbind()
  Super.OnUnbind(self)
end

return AwakerTrinketStrengthenListComp
