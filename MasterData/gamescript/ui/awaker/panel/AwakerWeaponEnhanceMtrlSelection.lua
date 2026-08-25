local AwakerWeaponEnhanceMtrlSelection, Super = System.NewClass("AwakerWeaponEnhanceMtrlSelection", UIBasePanel)
AwakerWeaponEnhanceMtrlSelection.uiResCls = UI_Awaker_Popup_JewelryResource

function AwakerWeaponEnhanceMtrlSelection:ctor(model, weaponDetailModel)
  Super.ctor(self)
  self.model = model
  self.weaponDetailModel = weaponDetailModel
end

function AwakerWeaponEnhanceMtrlSelection:InitUI(uiNode)
  Super.InitUI(self, uiNode)
end

function AwakerWeaponEnhanceMtrlSelection:OnBind(binder)
  self.model:SetSortTypeShow(false)
  binder:SetActive(self.ui.UI_Common_Filter_List, false)
  local defaultSortType = self.model.sortTypeList[1]
  self.model:SetSortType(defaultSortType)
  local defaultSortOrder = self.model.sortOrderList[1]
  self.model:SetSortOrder(defaultSortOrder)
  self.model:ClearCurrClickedMtrl()
  self.model:CollectMtrls()
  binder:BindToCircularListView(self.ui.ScrollView_Items, function()
    do return self.model.GetMtrls end
    return self.model.GetMtrls, self.model
  end, function(itemBinder, obj, index)
    local mtrls = self.model:GetMtrls()
    itemBinder:BindComponent(WeaponEnhanceMaterialForSelection(obj, self.model, mtrls[index], self.weaponDetailModel))
  end)
  binder:BindToRaw(function(childBinder, mtrl)
    if mtrl then
      self.ui.UI_Awaker_Popup_Trinket_Tip:SetActive(true)
      childBinder:BindComponent(WeaponEnhanceMaterialTips(self.ui.UI_Awaker_Popup_Trinket_Tip, mtrl, self.model))
    else
      self.ui.UI_Awaker_Popup_Trinket_Tip:SetActive(false)
    end
  end, function()
    do return self.model.GetCurrClickedMtrl end
    return self.model.GetCurrClickedMtrl, self.model
  end, nil)
  binder:BindToCircularListView(self.ui.ScrollView_Sort_List, function()
    return self.model.sortTypeList
  end, function(childBinder, obj, index)
    local sortType = self.model.sortTypeList[index]
    
    local function IsSelected()
      return self.model.sortType == sortType
    end
    
    local function OnClick(itemIdx)
      if not itemIdx then
        return
      end
      local clickSortType = self.model.sortTypeList[itemIdx]
      self.model:SetSortType(clickSortType)
      self.model:SetSortTypeShow(false)
      self.model:SortMtrls()
    end
    
    local itemData = {
      tid = index,
      name = sortType,
      selectedFunc = IsSelected,
      callback = OnClick
    }
    childBinder:BindComponent(CommonFilterListItem(obj, itemData))
  end)
  binder:BindToAnimator(self.ui.UI_Common_Filter_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.UI_Common_Filter_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return self.model.sortTypeShow
  end)
  binder:BindToRaw(function(_, sortType)
    binder:SetText(self.ui.Text_Sort_Type_1, sortType)
    binder:SetText(self.ui.Text_Sort_Type_2, sortType)
  end, function()
    return self.model.sortType
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Sort_Type, nil, function(isOn)
    self.model:SetSortTypeShow(isOn)
    if isOn then
      binder:SetActive(self.ui.UI_Common_Filter_List, true)
    end
  end, function()
    return self.model.sortTypeShow
  end)
  binder:BindToText(self.ui.Text_Sort_Order, function()
    return self.model.sortOrder
  end)
  binder:BindButtonClick(self.ui.Btn_Sort_Order, function()
    local currOrder = self.model.sortOrder
    local order_1 = self.model.sortOrderList[1]
    local order_2 = self.model.sortOrderList[2]
    if currOrder == order_1 then
      self.model:SetSortOrder(order_2)
    elseif currOrder == order_2 then
      self.model:SetSortOrder(order_1)
    end
    self.model:SortMtrls()
    self.model:SetSortTypeShow(false)
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, function()
    self:ClosePanel()
  end)
  binder:BindToVisible(self.ui.Group_No_Trinket, function()
    local mtrls = self.model:GetMtrls()
    return 0 == #mtrls
  end)
end

function AwakerWeaponEnhanceMtrlSelection:ClosePanel()
  local currClickedMtrl = self.model:GetCurrClickedMtrl()
  if currClickedMtrl then
    self.model:ClearCurrClickedMtrl()
    self.model:SetSortTypeShow(false)
  else
    self:Close()
  end
end

function AwakerWeaponEnhanceMtrlSelection:PushBackCommand()
  UIBackCommandStack.Push(self:_CreateBackCommand())
end

function AwakerWeaponEnhanceMtrlSelection:_CreateBackCommand()
  return {
    uiPanel = self,
    Execute = function()
      local currClickedMtrl = self.model:GetCurrClickedMtrl()
      if currClickedMtrl then
        self.model:ClearCurrClickedMtrl()
        self.model:SetSortTypeShow(false)
        UIBackCommandStack.Push(self:_CreateBackCommand())
      else
        self:Close()
      end
    end
  }
end

return AwakerWeaponEnhanceMtrlSelection
