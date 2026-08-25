local LIMIT_NUM = DT.GetConstant("MaximumQuantityLimitForDecomposition")
local AlchemyDecomposeBaseView, Super = NewClass("AlchemyDecomposeBaseView", BaseView)

function AlchemyDecomposeBaseView:ctor()
  Super.ctor(self)
  self.rewardObjGroup = {}
end

function AlchemyDecomposeBaseView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnAlchemyDecomposeSelectChanged, self.RefreshView, self)
  self:RegisterLocalNotify(NotifyId.OnAlchemyDecomposeToggleAllChanged, self.ToggleAllChanged, self)
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, function()
    self.model:UpdateData()
    self:RefreshView()
  end, self)
end

function AlchemyDecomposeBaseView:ToggleAllChanged(isOn)
  self:SetZ1Toggle(self.ui.Toggle_All, isOn, true)
end

function AlchemyDecomposeBaseView:RegisterEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.Toggle_All, System.fn(self, self.OnToggleAll))
  self:AddButtonClickListener(self.ui.Btn_Resolve, System.fn(self, self.OnDecompositeClick))
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, function()
    self.model:UpdateData()
    self:RefreshView()
  end)
  self:BindEvent(EventMgr.Instance.DecomposeLockStateEvent, function(uid)
    self.model:UpdateCurSelectItemUidGroup(uid)
  end)
  self:_OnInitOriListView()
end

function AlchemyDecomposeBaseView:_OnInitOriListView()
  self.oriListView = self:CreateTableview(self.ui.ScrollView_Item, function()
    if not self.model.oriLit then
      return 0
    end
    return #self.model.oriLit
  end, function(view, index)
    do return self._OriItemCellAtIndex, self, view end
    return self._OriItemCellAtIndex, self, view, index
  end)
end

function AlchemyDecomposeBaseView:_RefreshDecomposeState()
  self:SetText(self.ui.Text_AmountNow, LT.Text(#self.model.curSelectItemUidGroup))
  self:SetButtonState(self.ui.Btn_Resolve, self:CanDecomposite() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  if self.ui.Image_Null then
    self.ui.Image_Null:SetActive(0 == #self.model.curDecompositeList)
  end
  self:RefreshRewardGroup()
end

function AlchemyDecomposeBaseView:_OriItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.IconNode)
  local deComposeData = self.model.oriLit[index]
  local tid = deComposeData.itemTid or 0
  local uid = deComposeData.itemUid or 0
  local type = DT.Item[tid].Type
  if 0 ~= uid and not ItemDataUtils.GetItemByUid(uid) then
    return cell
  end
  local isNotEnough = ItemDataUtils.GetItemNum(tid) <= 0
  
  local function isUsingFunc()
    if type == CommonDefine.ItemType.Weapon then
      do return AwakerWeaponExtModel.Instance.IsWeaponUsing, AwakerWeaponExtModel.Instance end
      return AwakerWeaponExtModel.Instance.IsWeaponUsing, AwakerWeaponExtModel.Instance, uid
    elseif type == CommonDefine.ItemType.Trinket then
      do return self.model.IsTrinketUsing, self.model end
      return self.model.IsTrinketUsing, self.model, uid
    end
    return false
  end
  
  local function addDecomposeItem(itemUid)
    if not table.contains(self.model.curSelectItemUidGroup, itemUid) then
      self.model:AddItem(itemUid)
      self.model:Update_curDecompositeList()
      self:RefreshView()
    end
  end
  
  local function addDecomposeItemWithQuantity(deltaNum)
    deltaNum = deltaNum or 1
    local haveNum = ItemDataUtils.GetItemNum(tid)
    local selectNum = self.model.GetSelectCountByUid and self.model:GetSelectCountByUid(uid) or 0
    local canAddNum = math.min(deltaNum, haveNum - selectNum)
    if canAddNum <= 0 then
      return false
    end
    for i = 1, canAddNum do
      self.model:AddItem(uid)
    end
    self.model:Update_curDecompositeList()
    self.model:Set_curSelectUid(uid)
    return true
  end
  
  local function removeDecomposeItemWithQuantity(deltaNum)
    deltaNum = deltaNum or 1
    local selectNum = self.model.GetSelectCountByUid and self.model:GetSelectCountByUid(uid) or 0
    local canRemoveNum = math.min(deltaNum, selectNum)
    if canRemoveNum <= 0 then
      return
    end
    for i = 1, canRemoveNum do
      self.model:RemoveItem(uid)
    end
    self.model:Update_curDecompositeList()
    self.model:Set_curSelectUid(uid)
  end
  
  local function showClickAlert(tipsId)
    Alert.Show(tipsId)
  end
  
  local function onClickWeapon(weaponUid)
    local isWeaponUsing = AwakerWeaponExtModel.Instance:IsWeaponUsing(weaponUid)
    if isWeaponUsing and not table.contains(self.model.curSelectItemUidGroup, weaponUid) then
      showClickAlert(10489)
    else
      addDecomposeItem(weaponUid)
    end
  end
  
  local function checkTrinketInTeam(trinketUid)
    local isTrinketUsing = AwakerTrinketExtModel.Instance:IsTrinketUsing(trinketUid)
    if isTrinketUsing and not table.contains(self.model.curSelectItemUidGroup, trinketUid) then
      showClickAlert(10488)
    else
      addDecomposeItem(trinketUid)
    end
  end
  
  local function onClickTrinket(trinketUid)
    local planId = AwakerTrinketExtModel.Instance:GetTrinketPlanId(trinketUid)
    if 0 ~= planId and not table.contains(self.model.curSelectItemUidGroup, trinketUid) then
      showClickAlert(10488)
    else
      checkTrinketInTeam(trinketUid)
    end
  end
  
  local function clickCb()
    if type ~= CommonDefine.ItemType.Weapon and type ~= CommonDefine.ItemType.Trinket and isNotEnough then
      Alert.ShowStr(LT.Text("ExchangeCostItemNotEnoughTips"))
      return
    end
    local isLock = ItemDataUtils.GetItemLocked(uid)
    if type == CommonDefine.ItemType.Weapon then
      if AwakerWeaponExtModel.Instance:IsWeaponUsing(uid) then
        onClickWeapon(uid)
      elseif isLock then
        Alert.ShowStr(LT.Text("AlchemyDecomposeWeaponLockTip"))
      else
        addDecomposeItem(uid)
      end
    elseif type == CommonDefine.ItemType.Trinket then
      if AwakerTrinketExtModel.Instance:IsTrinketUsing(uid) then
        onClickTrinket(uid)
      elseif isLock then
        Alert.ShowStr(LT.Text("AlchemyDecomposeTrinketLockTip"))
      else
        addDecomposeItem(uid)
      end
    elseif isLock then
      Alert.ShowStr(LT.Text("AlchemyDecomposeItemLockTip"))
    else
      addDecomposeItemWithQuantity()
    end
    self.model:Set_curSelectUid(uid)
  end
  
  local function selectFunc()
    return 0 ~= uid and self.model:Get_curSelectUid() == uid
  end
  
  local function btnSubFunc()
    if not table.contains(self.model.curSelectItemUidGroup, uid) then
      return
    end
    if type == CommonDefine.ItemType.Weapon or type == CommonDefine.ItemType.Trinket then
      self.model:RemoveItem(uid)
      self.model:Update_curDecompositeList()
      self.model:Set_curSelectUid(uid)
    else
      removeDecomposeItemWithQuantity(1)
    end
  end
  
  local function selectedFunc()
    do return table.contains, self.model.curSelectItemUidGroup end
    return table.contains, self.model.curSelectItemUidGroup, uid
  end
  
  local itemData = {
    tid = tid,
    uid = uid,
    clickCb = clickCb,
    selectFunc = selectFunc,
    btnSubFunc = btnSubFunc,
    selectedFunc = selectedFunc,
    isUsingFunc = isUsingFunc,
    alchemyItemType = AlchemyDefine.AlchemyItemType.Formula,
    sortType = self.model.trinketSortType
  }
  if type ~= CommonDefine.ItemType.Weapon and type ~= CommonDefine.ItemType.Trinket then
    itemData.alchemyItemType = AlchemyDefine.AlchemyItemType.DecomposeItem
    
    function itemData.numFunc()
      do return ItemDataUtils.GetItemNum end
      return ItemDataUtils.GetItemNum, tid
    end
    
    function itemData.itemLockFunc()
      return isNotEnough
    end
    
    if not isNotEnough then
      itemData.showMultiSelect = true
      
      function itemData.selectNumFunc()
        return self.model.GetSelectCountByUid and self.model:GetSelectCountByUid(uid) or 0
      end
      
      function itemData.addLongPressFunc(tidVal, uidVal, deltaNum)
        addDecomposeItemWithQuantity(deltaNum)
      end
      
      function itemData.subLongPressFunc(tidVal, uidVal, deltaNum)
        removeDecomposeItemWithQuantity(deltaNum)
      end
    end
  end
  self:SetIcon(MaterialIconType.AlchemyIcon, cell.gameObject, itemData)
  return cell
end

function AlchemyDecomposeBaseView:OnEnterView()
  Super.OnEnterView(self)
  local capacity = self:GetBagCapacity()
  self.ui.Group_Tips:SetActive(true)
  self:SetText(self.ui.Text_GoodsNumAll, capacity)
  self:SetText(self.ui.Text_AmountAll, LT.Text(LIMIT_NUM))
  self:SetButtonText(self.ui.Btn_Resolve, LT.Text("DecomposeButtonText"))
  self:_OnInitItemDetailComp()
  self:RefreshView()
end

function AlchemyDecomposeBaseView:_OnInitItemDetailComp()
  if not self.commonItemDetailTipItem then
    self.commonItemDetailTipItem = self:AddViewComponent(self.ui.UI_Bag_Item_Detail, CompFixedItemDetailTipsItem)
    self.commonItemDetailTipItem.refreshLayoutImmediate = true
  end
end

function AlchemyDecomposeBaseView:OnToggleAll(isOn)
  if isOn then
    self.model:SetIsSelectAll(true)
    for _, deComposeData in pairs(self.model.oriLit) do
      local uid = deComposeData.itemUid
      if ItemDataUtils.GetItemLocked(uid) then
      elseif self:CheckCanAddDecompose(uid) then
      else
        if #self.model.curSelectItemUidGroup >= LIMIT_NUM then
          break
        end
        if not table.contains(self.model.curSelectItemUidGroup, uid) then
          self.model:AddItem(uid)
        end
      end
    end
  else
    self.model:SetIsSelectAll(false)
    self.model:SetCurSelectItemUidGroup({})
  end
  self.model:Update_curDecompositeList()
  self:RefreshView()
end

function AlchemyDecomposeBaseView:RefreshView()
  self.oriListView:ReloadData()
  local selectUid = self.model:Get_curSelectUid()
  self.ui.UI_Bag_Item_Detail:SetActive(selectUid and 0 ~= selectUid)
  self.ui.Group_Null:SetActive(0 == selectUid)
  self.ui.Group_NullBag:SetActive(0 == #self.model.oriLit)
  self.ui.ScrollView_Item:SetActive(0 ~= #self.model.oriLit)
  if self.ui.Image_Null then
    self.ui.Image_Null:SetActive(0 == #self.model.curDecompositeList)
  end
  self:SetText(self.ui.Text_AmountNow, LT.Text(#self.model.curSelectItemUidGroup))
  self:SetText(self.ui.Text_GoodsNumNow, #self.model.oriLit)
  self:SetButtonState(self.ui.Btn_Resolve, self:CanDecomposite() and CommonDefine.BtnType.High or CommonDefine.BtnType.Unclickable)
  if self.commonItemDetailTipItem then
    self.commonItemDetailTipItem:SetItemUid(selectUid)
  end
  self:RefreshRewardGroup()
end

function AlchemyDecomposeBaseView:RefreshRewardGroup()
  local decompositeCnt = #self.model.curDecompositeList
  for index = 1, decompositeCnt do
    local decompositeData = self.model.curDecompositeList[index]
    if decompositeData then
      local uiName = "Reward_" .. index
      local obj = self.rewardObjGroup[index]
      if not obj then
        obj = self:Instantiate(self.ui.UI_Common_Item_WuPin_Type2, self.ui.Content.transform)
        obj.name = uiName
        self.rewardObjGroup[index] = obj
      end
      obj:SetActive(true)
      local tid = decompositeData.tid
      local num = decompositeData.num
      
      local function clickCb()
        ItemDataUtils.ShowItemDetailTips(self.binder, obj.gameObject, nil, tid)
      end
      
      local viewData = {
        itemTid = tid,
        itemCount = num,
        clickFunc = clickCb
      }
      self:AddViewComponentOnce(obj, CompPublicIconItemType2, viewData)
    end
  end
  if #self.rewardObjGroup > #self.model.curDecompositeList then
    for index = #self.model.curDecompositeList + 1, #self.rewardObjGroup do
      local obj = self.rewardObjGroup[index]
      if obj then
        obj:SetActive(false)
      end
    end
  end
end

function AlchemyDecomposeBaseView:CanDecomposite()
  return 0 ~= #self.model.curDecompositeList
end

function AlchemyDecomposeBaseView:OnDecompositeClick()
  if not self:CanDecomposite() then
    Alert.ShowStr(LT.Text("ChooseItemForDecompose"))
    return
  end
  
  local function confirmCb()
    AlchemyDataUtils.DecomposeItem(table.deepclone(self.model.curSelectItemUidGroup))
    self.model:SetDecomposedItemUidGroup(table.deepclone(self.model.curSelectItemUidGroup))
    self.model:SetCurSelectItemUidGroup({})
    self.model:SetIsSelectAll(false)
    self.model:Set_curSelectUid(0, true)
  end
  
  UIManager.Instance:Reopen(Urls.AlchemyDecomposeConfirmView, confirmCb, self.model)
end

function AlchemyDecomposeBaseView:OnExitView()
  Super.OnExitView(self)
end

return AlchemyDecomposeBaseView
