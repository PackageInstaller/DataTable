local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local BoundTrinketTagNodeName = "Image_Trinket_Bind"
local UICompChoosedTrinketListBase, Super = NewViewComponent("UICompChoosedTrinketListBase")

function UICompChoosedTrinketListBase:SetDelegate(delegate)
  self.delegate = delegate
end

function UICompChoosedTrinketListBase:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTrinketFiltersChanged, self._RefreshTrinketSortEditor, self)
end

function UICompChoosedTrinketListBase:RegisterEvents()
  BagExtModel.Instance:InitFilters()
  self:_RegisterPartsTogglesListener()
  self:_CreateTrinketTableview()
  self:AddButtonClickListener(self.ui.Btn_Trinket_Filter, System.fn(self, self.OnClickTrinketFilter))
  self:AddButtonClickListener(self.ui.Btn_Trinket_Level, System.fn(self, self.OnClickTrinketCommonFilter))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, System.fn(self, self.OnClickTrinketLitre))
  self.clickScrollViewParts = UIClickableScrollView(self.ui.ScrollView_Parts, System.fn(self, self._OnClickScrollViewParts))
end

function UICompChoosedTrinketListBase:_RegisterPartsTogglesListener()
  for i = 1, MaxEquipTrinketsNum do
    self:AddZ1ToggleValueChangedListener(self.ui["Toggle_" .. i], function(isOn)
      if isOn then
        self:OnClickTrinketPartType(i)
      end
    end)
  end
end

function UICompChoosedTrinketListBase:_CreateTrinketTableview()
  self.trinketListView = self:CreateTableview(self.ui.ScrollView_Parts, function()
    return self.trinketViewDatas and #self.trinketViewDatas or 0
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.IconEmpty)
    local itemData = self.trinketViewDatas[index]
    local isInOtherPlan = self:IsTrinketInOtherPlan(itemData.uid)
    itemData.displayDisableNode = isInOtherPlan
    if isInOtherPlan then
      itemData.disableText = LT.Text("TrinketApplyingToSuitPlan")
    end
    self:_RefreshCellBoundTrinketTag(itemData)
    self:_RefreshCellBoundTrinketQuality(itemData)
    self:SetIcon(MaterialIconType.CommonIcon, cell.gameObject, itemData)
    return cell
  end)
end

function UICompChoosedTrinketListBase:_RefreshCellBoundTrinketTag(itemData)
  itemData.isBoundTrinketTag = self.showBoundTrinketCellTag or nil
end

function UICompChoosedTrinketListBase:_RefreshCellBoundTrinketQuality(itemData)
  itemData.boundTrinketUrQuality = self.showBoundTrinketUrQuality or nil
end

function UICompChoosedTrinketListBase:_RefreshTrinketListView()
  self.trinketViewDatas = self:GetFilterTrinksList()
  if self.trinketViewDatas then
    local function isChoosed(uid)
      do return self.IsTrinketChoosing, self end
      
      return self.IsTrinketChoosing, self, uid
    end
    
    local function onChoosed(tid, uid)
      local isInOtherPlan = self:IsTrinketInOtherPlan(uid)
      if isInOtherPlan then
        local planId = AwakerTrinketExtModel.Instance:GetTrinketPlanId(uid)
        local tipConfig = DT.TipsType[10806]
        Alert.Show(10802, nil, nil, nil, LT.Textf(tipConfig.Desc, AwakerTrinketExtModel.Instance:GetTrinketPlanName(planId)))
        return
      end
      self:ChooseTrinket(uid)
    end
    
    local function getOwnerTid(uid)
      do return self.GetTrinketOwnerTid, self end
      return self.GetTrinketOwnerTid, self, uid
    end
    
    for i = 1, #self.trinketViewDatas do
      self.trinketViewDatas[i].onClick = onChoosed
      self.trinketViewDatas[i].isChoosed = isChoosed
      self.trinketViewDatas[i].getOwnerTid = getOwnerTid
    end
  end
  self.trinketListView:SetOffsetWithoutRefresh(0)
  self.trinketListView:ReloadData()
end

function UICompChoosedTrinketListBase:_RefreshParts()
  local partType = self:GetCurPartType()
  for i = 1, MaxEquipTrinketsNum do
    local partNode = self.ui["Toggle_" .. i]
    self:SetZ1Toggle(partNode, i == partType, true)
    self:_RefreshPartBoundTrinketTag(partNode, i)
  end
end

function UICompChoosedTrinketListBase:_RefreshPartBoundTrinketTag(partNode, partType)
  if not partNode then
    return
  end
  local tagTrans = partNode.transform:Find(BoundTrinketTagNodeName)
  if not tagTrans then
    return
  end
  tagTrans.gameObject:SetActive(self:_IsPartBoundTrinketValid(partType))
end

function UICompChoosedTrinketListBase:_IsPartBoundTrinketValid(partType)
  local model = self:GetModel()
  if not model or not model.GetCurAwakerTid then
    return false
  end
  local awakerTid = model:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return false
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, partType)
  if 0 == boundUid then
    return false
  end
  return ItemDataUtils.GetItemByUid(boundUid) ~= nil
end

function UICompChoosedTrinketListBase:_RefreshTrinketSortEditor()
  local model = self:GetModel()
  local hasFilter = model and model:IsExistedTrinketFilter() or false
  local btnState = CommonDefine.BtnType.Normal
  if hasFilter then
    btnState = CommonDefine.BtnType.High
  end
  self:SetButtonState(self.ui.Btn_Trinket_Filter, btnState)
  self:SetText(self.ui.Text_Trinket_SortType_1, model and model:GetTrinketSortTypeName() or "")
  self:SetZ1Toggle(self.ui.Btn_Trinket_Litre, model and model.trinketSortOrder == CommonDefine.SortOrder.Descend or false, true)
end

function UICompChoosedTrinketListBase:_OnClickScrollViewParts()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
end

function UICompChoosedTrinketListBase:OnExitComponent()
  if self.clickScrollViewParts then
    self.clickScrollViewParts:Dispose()
  end
  Super.OnExitComponent(self)
end

function UICompChoosedTrinketListBase:GetFilterTrinksList()
  if self.delegate and self.delegate.GetFilterTrinksList then
    do return self.delegate.GetFilterTrinksList end
    return self.delegate.GetFilterTrinksList, self.delegate
  end
end

function UICompChoosedTrinketListBase:OnClickTrinketFilter()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  if self.delegate and self.delegate.OnClickTrinketFilter then
    self.delegate:OnClickTrinketFilter()
    return
  end
  local partType = self:GetCurPartType()
  local model = self:GetModel()
  model.lockTrinketPos = partType
  TrinketFilterController.Instance:OpenTrinkFilterView(self:GetModel(), self.ui.TrinkFilterPos.transform.position, function(isChanged)
    if isChanged then
      model:CalFilterTrinketsList()
      self:OnTrinketFilterChanged()
      self:RefreshView()
    end
  end)
end

function UICompChoosedTrinketListBase:OnTrinketFilterChanged()
  if self.delegate and self.delegate.OnTrinketFilterChanged then
    self.delegate:OnTrinketFilterChanged()
  end
end

function UICompChoosedTrinketListBase:OnClickTrinketCommonFilter()
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  if self.delegate and self.delegate.OnClickTrinketCommonFilter then
    self.delegate:OnClickTrinketCommonFilter()
    return
  end
  local model = self:GetModel()
  local sortTypeList = BagExtModel.Instance:GetTrinketSortTypeList()
  local curType = BagExtModel.Instance:GetTrinketSortType()
  TrinketFilterController.Instance:OpenCommonFilterView(self.ui.Trinke_Filter_List_Level_Pos.transform.position, curType, sortTypeList, function(t)
    model:SetTrinketSortType(t)
    BagExtModel.Instance:SetTrinketSortType(t)
    model:CalFilterTrinketsList()
    self:RefreshView()
  end)
end

function UICompChoosedTrinketListBase:OnClickTrinketLitre(isOn)
  self:LocalNotify(NotifyId.OnCloseTrinketDetailsTips)
  if self.delegate and self.delegate.OnClickTrinketLitre then
    self.delegate:OnClickTrinketLitre(isOn)
    return
  end
  local model = self:GetModel()
  local order = isOn and CommonDefine.SortOrder.Descend or CommonDefine.SortOrder.Ascend
  model:SetTrinketSortOrder(order)
  model:CalFilterTrinketsList()
  self:RefreshView()
end

function UICompChoosedTrinketListBase:OnClickTrinketPartType(partType)
  if self.delegate and self.delegate.OnClickTrinketPartType then
    self.delegate:OnClickTrinketPartType(partType)
  end
end

function UICompChoosedTrinketListBase:IsTrinketChoosing(uid)
  if self.delegate and self.delegate.IsTrinketChoosing then
    do return self.delegate.IsTrinketChoosing, self.delegate end
    return self.delegate.IsTrinketChoosing, self.delegate, uid
  end
  return false
end

function UICompChoosedTrinketListBase:ChooseTrinket(uid)
  if self.delegate and self.delegate.ChooseTrinket then
    self.delegate:ChooseTrinket(uid)
  end
end

function UICompChoosedTrinketListBase:GetTrinketOwnerTid(uid)
  if self.delegate and self.delegate.GetTrinketOwnerTid then
    do return self.delegate.GetTrinketOwnerTid, self.delegate end
    return self.delegate.GetTrinketOwnerTid, self.delegate, uid
  end
  return 0
end

function UICompChoosedTrinketListBase:GetCurPartType()
  if self.delegate and self.delegate.GetCurPartType then
    do return self.delegate.GetCurPartType end
    return self.delegate.GetCurPartType, self.delegate
  end
  return 0
end

function UICompChoosedTrinketListBase:GetModel()
  if self.delegate and self.delegate.GetModel then
    do return self.delegate.GetModel end
    return self.delegate.GetModel, self.delegate
  end
end

function UICompChoosedTrinketListBase:IsTrinketInOtherPlan(uid)
  return false
end

function UICompChoosedTrinketListBase:RefreshTableview()
  self.trinketListView:Refresh()
end

function UICompChoosedTrinketListBase:RefreshView()
  self:_RefreshParts()
  self:_RefreshTrinketListView()
  self:_RefreshTrinketSortEditor()
  local isExistTrinkets = self.trinketViewDatas and #self.trinketViewDatas > 0
  self.ui.Text_C_Null:SetActive(not isExistTrinkets)
  self.ui.Group_Trinket_Bag_Toggle:SetActive(TrinketModel.Instance:HasAnyTrinketsInBag(self:GetCurPartType()))
end

return UICompChoosedTrinketListBase
