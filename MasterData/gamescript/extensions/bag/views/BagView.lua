local ItemType = CommonDefine.ItemType
local BS_Normal = CommonDefine.BtnType.Normal
local BS_Unclickable = CommonDefine.BtnType.Unclickable
local T_ScrollRect = typeof(CS.UnityEngine.UI.ScrollRect)
local BagView, Super = NewClass("BagView", BaseView)
BagView.uiResCls = UI_Bag_Panel_Main_OptimizedResource

function BagView:ctor(targetPage, targetItemTid)
  Super.ctor(self)
  self.targetPage = targetPage
  self.targetItemTid = targetItemTid
end

function BagView:OnBuildView()
  self.compBtnClosed = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, function()
    if not self.clickClose then
      self:Close()
    end
  end)
  self:SetButtonText(self.ui.Btn_Use, LT.Text("BagItemUseBtnText"))
  self:AddViewComponent(self.ui.UI_Bag_Item_Detail, UICompBagItemDetailTipsItem).refreshLayoutImmediate = true
  self:AddViewComponent(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, DT.Constant.BagPanelCurrencies.Data)
end

function BagView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnBagItemTabChanged, self._OnBagItemTabChanged, self)
  self:RegisterLocalNotify(NotifyId.OnBagItemChoosed, self._OnBagItemChoosed, self)
  self:RegisterNotify(NotifyId.OnItemDetailLockStates, self._OnItemDetailLockStates, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketFiltersChanged, self._OnTrinketFiltersChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketSortTypeChanged, self._OnTrinketSortTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnTrinketSortOrderChanged, self._OnTrinketSortOrderChanged, self)
  self:RegisterLocalNotify(NotifyId.OnWeaponSortTypeChanged, self._OnWeaponSortTypeChanged, self)
  self:RegisterLocalNotify(NotifyId.OnWeaponSortOrderChanged, self._OnWeaponSortOrderChanged, self)
  self:RegisterNotify(NotifyId.OnTrinketUpdategraded, self._OnTrinketUpdategraded, self)
  self:RegisterNotify(NotifyId.OnRemoveRedData, self._OnRemoveRedData, self)
  self:BindEvent(EventMgr.Instance.UpdateBagEvent, System.fn(self, self._OnBagItemDataChanged))
end

function BagView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Replacement, System.fn(self, self._OnClickExchangeBtn))
  self:AddButtonClickListener(self.ui.Btn_Synthesis, System.fn(self, self._OnClickComposeBtn))
  self:AddButtonClickListener(self.ui.Btn_Recast, System.fn(self, self._OnClickRecastBtn))
  self:AddButtonClickListener(self.ui.Btn_Resolve, System.fn(self, self._OnClickDecomposeBtn))
  self:AddButtonClickListener(self.ui.Btn_Trinket_Filter, System.fn(self, self._OnClickTrinketFilter))
  self:AddButtonClickListener(self.ui.Btn_Trinket_Level, System.fn(self, self._OnClickTrinketCommonFilter))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket_Litre, System.fn(self, self._OnClickTrinketLitre))
  self:AddButtonClickListener(self.ui.Btn_Intensify, System.fn(self, self._OnClickBtnIntensify))
  self:AddButtonClickListener(self.ui.Btn_SortType_Weapon, System.fn(self, self._OnClickSortTypeWeaponBtn))
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Weapon_LitreWeapon, System.fn(self, self._OnClickWeaponLitreWeapon))
  self:AddButtonClickListener(self.ui.Btn_Normotopia, System.fn(self, self._OnClickWeaponNormotopiaBtn))
  self:AddButtonClickListener(self.ui.Btn_Backtrack, System.fn(self, self._OnClickBacktrackBtn))
  self:AddButtonClickListener(self.ui.Btn_Use, System.fn(self, self._OnClickUseBtn))
  self:_RegisterBagTableviewEvents()
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Weapon, function(isOn)
    if isOn then
      BagExtModel.Instance:SetCurShowType(ItemType.Weapon)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Trinket, function(isOn)
    if isOn then
      BagExtModel.Instance:SetCurShowType(ItemType.Trinket)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Material, function(isOn)
    if isOn then
      BagExtModel.Instance:SetCurShowType(ItemType.Material)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_Special, function(isOn)
    if isOn then
      BagExtModel.Instance:SetCurShowType(ItemType.Special)
    end
  end)
  self:AddZ1ToggleValueChangedListener(self.ui.Btn_KeeperSkill, function(isOn)
    if isOn then
      BagExtModel.Instance:SetCurShowType(ItemType.KeeperSkill)
    end
  end)
end

function BagView:_RegisterBagTableviewEvents()
  self.bagMaterialsView = self:CreateTableview(self.ui.ScrollView_Bag_Material, function()
    return self.bagItemsData and #self.bagItemsData or 0
  end, function(view, index)
    local cell = view:DequeueCell(index)
    cell = cell or view:AddChild(self.ui.IconNode)
    local itemData = self.bagItemsData[index]
    self:SetIcon(MaterialIconType.CommonIcon, cell.gameObject, itemData)
    return cell
  end)
  
  function self.bagMaterialsView.reloadFinishCallback()
    if self.targetItemIndex then
      local offset = self.bagMaterialsView:GetOffsetByIndex(self.targetItemIndex - 1)
      self.bagMaterialsView:SetOffset(offset, false)
    end
  end
end

function BagView:OnEnterView()
  TrinketSortingModel.Instance:StartCalSortingParams()
  Super.OnEnterView(self)
  BagExtModel.Instance:InitFilters()
  self:SetButtonText(self.ui.Btn_Backtrack, LT.Text("BackTrack"))
  self:_CalShowPageAndItem()
  self:_RefreshToggles()
  self:_RefreshBag()
  self:_CheckExpiredItems()
end

function BagView:_CheckExpiredItems()
  local list = ItemDataUtils.GetExpiredItems()
  if #list > 0 then
    ProtoManager.Instance:ReqServer("GameRequest", "OnItemOpen")
    UIManager.Instance:Show(Urls.ItemExpiredPanel, list)
  end
  ProtoManager.Instance:ReqServer("GameRequest", "OnCheckExpiryItem")
end

function BagView:_CalShowPageAndItem()
  if self.targetItemTid then
    self.targetPage = ItemDataUtils.GetItemType(self.targetItemTid)
  end
  local curType = self.targetPage or ItemType.Weapon
  BagExtModel.Instance.currShowType = curType
end

function BagView:_RefreshToggles()
  local curType = BagExtModel.Instance:GetCurShowType()
  self:SetZ1Toggle(self.ui.Btn_Weapon, curType == ItemType.Weapon, true)
  self:SetZ1Toggle(self.ui.Btn_Trinket, curType == ItemType.Trinket, true)
  self:SetZ1Toggle(self.ui.Btn_Material, curType == ItemType.Material, true)
  self:SetZ1Toggle(self.ui.Btn_Special, curType == ItemType.Special, true)
  self:SetZ1Toggle(self.ui.Btn_KeeperSkill, curType == ItemType.KeeperSkill, true)
end

function BagView:OnExitView()
  Super.OnExitView(self)
end

function BagView:Close()
  self.clickClose = true
  self.compBtnClosed:PlayCloseAnim()
  Super.Close(self)
end

function BagView:_OnBagItemTabChanged()
  if BagExtModel.Instance:GetCurShowType() == ItemType.Trinket then
    BagExtModel.Instance:InitFilters()
  end
  self:_RefreshBag()
end

function BagView:_OnBagItemChoosed()
  self:PushCommand(self._RefreshVisibleCells, self)
end

function BagView:_OnItemDetailLockStates()
  self:PushCommand(self._RefreshVisibleCells, self)
end

function BagView:_OnTrinketFiltersChanged()
  self:_RefreshBag()
end

function BagView:_OnTrinketSortTypeChanged()
  self:_RefreshBag()
end

function BagView:_OnTrinketSortOrderChanged()
  self:_RefreshBag()
end

function BagView:_OnWeaponSortTypeChanged()
  self:_RefreshBag()
end

function BagView:_OnWeaponSortOrderChanged()
  self:_RefreshBag()
end

function BagView:_OnTrinketUpdategraded(targetUid)
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  if curUid ~= targetUid then
    return
  end
  self.bagMaterialsView:Refresh()
end

function BagView:_PushOnBagItemDataChanged()
  self:PushCommand(self._OnBagItemDataChanged, self)
end

function BagView:_OnBagItemDataChanged()
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  if ItemDataUtils.GetItemByUid(curUid) then
    self:_RefreshBag(true)
  else
    self:_RefreshBag()
  end
end

function BagView:_OnRemoveRedData()
  self:_RefreshBagRedDots()
end

function BagView:_RefreshVisibleCells()
  self.bagMaterialsView:Refresh()
  self.ui.ScrollView_Detail:GetComponent(T_ScrollRect).verticalNormalizedPosition = 1
end

function BagView:_RefreshBag(donotSelectedFirst)
  self:SetText(self.ui.Text_Label, BagExtModel.Instance:GetItemTypeName())
  self:_ReloadBagItemsData()
  if not donotSelectedFirst then
    if not self.targetItemIndex then
      self.bagMaterialsView:SetOffset(0, false)
    end
    self:_SelectFirstItem()
  end
  self:_RefreshItemsNum()
  self:_RefreshMaterialButtonStatus()
  self:_RefreshIsEmptyItemList()
  self:_RefreshTrinketSortEditor()
  self:_RefreshTrinketIntensifyBtn()
  self:_RefreshWeaponSortEditor()
  self:_RefreshWeaponNormotopiaBtn()
  self:_RefreshBacktrackBtn()
  self:_RefreshBtnUsed()
  self:_RefreshBagRedDots()
end

function BagView:_ReloadBagItemsData()
  self.bagItemsData = BagExtModel.Instance:GetCurItemList()
  self.targetItemIndex = nil
  if self.bagItemsData then
    local isChoosed = System.fn(self, self._IsItemChosen)
    local onChoosed = System.fn(self, self._OnChosenItem)
    for i = 1, #self.bagItemsData do
      self.bagItemsData[i].onClick = onChoosed
      self.bagItemsData[i].isChoosed = isChoosed
      if self.targetItemTid and not self.targetItemIndex and self.targetItemTid == self.bagItemsData[i].tid then
        self.targetItemIndex = i
      end
    end
  end
  self.bagMaterialsView:ReloadData()
end

function BagView:_RefreshBagRedDots()
  local weaponRedDot = self:FindChild(self.ui.Btn_Weapon, "Com_RedDot")
  local trinketRedDot = self:FindChild(self.ui.Btn_Trinket, "Com_RedDot")
  local specialRedDot = self:FindChild(self.ui.Btn_Special, "Com_RedDot")
  local keeperSkillRedDot = self:FindChild(self.ui.Btn_KeeperSkill, "Com_RedDot")
  local synthesisRedDot = self:FindChild(self.ui.Btn_Synthesis, "Com_RedDot")
  local materialRedDot = self:FindChild(self.ui.Btn_Material, "Com_RedDot_Material")
  self:SetActive(weaponRedDot.gameObject, BagExtModel.Instance:CheckItemTypeRed(ItemType.Weapon))
  self:SetActive(trinketRedDot.gameObject, BagExtModel.Instance:CheckItemTypeRed(ItemType.Trinket))
  self:SetActive(specialRedDot.gameObject, BagExtModel.Instance:CheckItemTypeRed(ItemType.Special))
  self:SetActive(keeperSkillRedDot.gameObject, BagExtModel.Instance:CheckItemTypeRed(ItemType.KeeperSkill))
  self:SetActive(self.ui.Com_RedDot_Material, BagExtModel.Instance:CheckItemTypeRed(ItemType.Material))
  self:AddViewComponentOnce(synthesisRedDot.gameObject, UICompRedDotNew, RedDotDefine.DynamicRedDotID.RedDotConversionRemain)
  self:AddViewComponentOnce(materialRedDot.gameObject, UICompRedDotNew, RedDotDefine.DynamicRedDotID.RedDotConversionRemain)
end

function BagView:_RefreshBtnUsed()
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  if 0 == curUid then
    self:SetActive(self.ui.Btn_Use, false)
    return
  end
  local isUsable = BagExtModel.Instance:IsCanUse(curUid)
  if not isUsable then
    self:SetActive(self.ui.Btn_Use, false)
    return
  end
  self:SetActive(self.ui.Btn_Use, true)
  local isLessUseCount = BagExtModel.Instance:IsLessUseCount(curUid)
  self:SetButtonState(self.ui.Btn_Use, isLessUseCount and cd.Z1ButtonState.Unclickable or cd.Z1ButtonState.High)
end

function BagView:_RefreshWeaponSortEditor()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType ~= ItemType.Weapon or not BagExtModel.Instance:HasAnyWeapons() then
    self:SetActive(self.ui.Group_Weapon_Bag_Toggle, false)
    return
  end
  self:SetActive(self.ui.Group_Weapon_Bag_Toggle, true)
  self:SetText(self.ui.Text_SortType_Weapon, BagExtModel.Instance:GetWeaponSortTypeName())
  self:SetZ1Toggle(self.ui.Btn_Weapon_LitreWeapon, BagExtModel.Instance.weaponSortOrder == CommonDefine.SortOrder.Descend, true)
end

function BagView:_RefreshWeaponNormotopiaBtn()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType ~= ItemType.Weapon then
    self:SetActive(self.ui.Btn_Normotopia, false)
    self:SetActive(self.ui.Group_Awaker_NormotopiaCap, false)
    return
  end
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  if RedPointDataUtils.IsBackTrackShowRed(curUid) then
    self:SetActive(self.ui.Btn_Normotopia, false)
    return
  end
  self:SetActive(self.ui.Btn_Normotopia, true)
  local isShowRefineBtn = ItemDataUtils.IsShowRefineBtn(curUid)
  self:SetActive(self.ui.Group_Awaker_NormotopiaCap, false)
  local backTrackRedDot = self:FindChild(self.ui.Btn_Normotopia, "Com_RedDot")
  if backTrackRedDot and backTrackRedDot.gameObject then
    self:SetActive(backTrackRedDot.gameObject, isShowRefineBtn and RedPointDataUtils.IsBackTrackShowRed(curUid) or false)
  end
end

function BagView:_RefreshBacktrackBtn()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType ~= ItemType.Weapon then
    self:SetActive(self.ui.Btn_Backtrack, false)
    return
  end
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  self:SetActive(self.ui.Btn_Backtrack, RedPointDataUtils.IsBackTrackShowRed(curUid))
end

function BagView:_RefreshTrinketSortEditor()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType ~= ItemType.Trinket or not BagExtModel.Instance:HasAnyTrinkets() then
    self:SetActive(self.ui.Group_Trinket_List_Toggle, false)
    return
  end
  self:SetActive(self.ui.Group_Trinket_List_Toggle, true)
  local hasFilter = BagExtModel.Instance:IsExistedTrinketFilter()
  local btnState = CommonDefine.BtnType.Normal
  if hasFilter then
    btnState = CommonDefine.BtnType.High
  end
  self:SetButtonState(self.ui.Btn_Trinket_Filter, btnState)
  self:SetText(self.ui.Text_Trinket_SortType_1, BagExtModel.Instance:GetTrinketSortTypeName())
  self:SetZ1Toggle(self.ui.Btn_Trinket_Litre, BagExtModel.Instance.trinketSortOrder == CommonDefine.SortOrder.Descend, true)
end

function BagView:_RefreshTrinketIntensifyBtn()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType ~= ItemType.Trinket then
    self:SetActive(self.ui.Btn_Intensify, false)
    return
  end
  self:SetActive(self.ui.Btn_Intensify, true)
  local btnState = CommonDefine.BtnType.High
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
  if not unlocked then
    btnState = CommonDefine.BtnType.Unclickable
  end
  self:SetButtonState(self.ui.Btn_Intensify, btnState)
end

function BagView:_OnClickTrinketFilter()
  TrinketFilterController.Instance:OpenTrinkFilterView(BagExtModel.Instance, self.ui.TrinkFilterPos.transform.position, function(isChanged)
    if isChanged then
      self:_RefreshBag()
    end
  end)
end

function BagView:_OnClickTrinketCommonFilter()
  local sortTypeList = BagExtModel.Instance:GetTrinketSortTypeList()
  local curType = BagExtModel.Instance.trinketSortType
  TrinketFilterController.Instance:OpenCommonFilterView(self.ui.Trinke_Filter_List_Level_Pos.transform.position, curType, sortTypeList, function(t)
    BagExtModel.Instance:SetTrinketSortType(t)
  end)
end

function BagView:_OnClickTrinketLitre(isOn)
  local order = isOn and CommonDefine.SortOrder.Descend or CommonDefine.SortOrder.Ascend
  BagExtModel.Instance:SetTrinketSortOrder(order)
end

function BagView:_OnClickWeaponLitreWeapon(isOn)
  local order = isOn and CommonDefine.SortOrder.Descend or CommonDefine.SortOrder.Ascend
  BagExtModel.Instance:SetWeaponSortOrder(order)
end

function BagView:_OnClickWeaponNormotopiaBtn()
  UIManager.Instance:Reopen(Urls.AwakerWeaponStrengthPanel, BagExtModel.Instance:GetCurChosenUid())
end

function BagView:_OnClickBacktrackBtn()
  UIManager.Instance:Reopen(Urls.AwakerWeaponStrengthPanel, BagExtModel.Instance:GetCurChosenUid(), true)
end

function BagView:_OnClickUseBtn()
  ItemDataUtils.OnClickItemUse(BagExtModel.Instance:GetCurChosenUid())
end

function BagView:_RefreshItemsNum()
  local curType = BagExtModel.Instance:GetCurShowType()
  local isActived = curType == ItemType.Weapon or curType == ItemType.Trinket
  self:SetActive(self.ui.Group_Amount, isActived)
  if isActived then
    self:SetText(self.ui.Text_AmountSum, LT.Text(BagExtModel.Instance:GetMaxItemNum()))
    self:SetText(self.ui.Text_AmountNow, self.bagItemsData and #self.bagItemsData or 0)
  end
end

function BagView:_RefreshIsEmptyItemList()
  if not self.bagItemsData or 0 == #self.bagItemsData then
    self:SetActive(self.ui.Group_Content, false)
    self:SetActive(self.ui.Group_None, true)
    self:SetText(self.ui.Text_None, BagExtModel.Instance:GetEmptyTips())
    self:SetText(self.ui.Text_None_Desc, BagExtModel.Instance:GetEmptySourceTips())
  else
    self:SetActive(self.ui.Group_Content, true)
    self:SetActive(self.ui.Group_None, false)
  end
end

function BagView:_RefreshMaterialButtonStatus()
  local curType = BagExtModel.Instance:GetCurShowType()
  self:SetActive(self.ui.Btn_Replacement, curType == ItemType.Material)
  if curType == ItemType.Material then
    local featureExchange = CommonDefine.FeatureId.Exchange
    local keyExchange = PlayerDataUtils.GetFeatureMainTypeKey()
    local _, unlockedExchange = PlayerDataUtils.IsFeatureUnlock(featureExchange, keyExchange)
    self:SetButtonState(self.ui.Btn_Replacement, unlockedExchange and BS_Normal or BS_Unclickable)
  end
  self:SetActive(self.ui.Btn_Synthesis, curType == ItemType.Material)
  if curType == ItemType.Material then
    local featureCompose = CommonDefine.FeatureId.Compose
    local keyCompose = PlayerDataUtils.GetFeatureMainTypeKey()
    local _, unlockedCompose = PlayerDataUtils.IsFeatureUnlock(featureCompose, keyCompose)
    self:SetButtonState(self.ui.Btn_Synthesis, unlockedCompose and BS_Normal or BS_Unclickable)
  end
  local _, unlockedRecast = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Recast, PlayerDataUtils.GetFeatureMainTypeKey())
  local isVisibleRecast = curType == ItemType.Trinket and unlockedRecast
  self:SetActive(self.ui.Btn_Recast, isVisibleRecast)
  if isVisibleRecast then
    self:SetButtonState(self.ui.Btn_Recast, unlockedRecast and BS_Normal or BS_Unclickable)
  end
  if curType == ItemType.Weapon or curType == ItemType.Trinket then
    self:SetButtonState(self.ui.Btn_Resolve, self:_IsDecomposeUnlock() and BS_Normal or BS_Unclickable)
    if curType == ItemType.Weapon then
      self:SetActive(self.ui.Btn_Resolve, table.next(ItemDataUtils.GetRedundantWeaponList()))
    else
      self:SetActive(self.ui.Btn_Resolve, true)
    end
  else
    self:SetActive(self.ui.Btn_Resolve, false)
  end
end

function BagView:_SelectFirstItem()
  local uid
  if self.targetItemTid and self.bagItemsData then
    for i = 1, #self.bagItemsData do
      if self.bagItemsData[i].tid == self.targetItemTid then
        uid = self.bagItemsData[i].uid
        break
      end
    end
  end
  self.targetItemTid = nil
  uid = not uid and self.bagItemsData and #self.bagItemsData > 0 and self.bagItemsData[1] and self.bagItemsData[1].uid or uid
  self:_OnChosenItem(nil, uid or 0)
end

function BagView:_IsItemChosen(uid)
  return BagExtModel.Instance:GetCurChosenUid() == uid
end

function BagView:_OnChosenItem(tid, uid)
  BagExtModel.Instance:SetCurChosenUid(uid)
  BagItemDetailsModel.Instance:SetItemUid(uid)
  self:_RefreshItemOwner()
  self:_RefreshWeaponNormotopiaBtn()
  self:_RefreshBacktrackBtn()
  self:_RefreshBtnUsed()
  FrameWaiter.OnNextFrame(function()
    self:_RefreshBagRedDots()
  end, 1)
end

function BagView:_RefreshItemOwner()
  local curUid = BagExtModel.Instance:GetCurChosenUid()
  local ownAwaker = ItemDataUtils.GetItemOwner(curUid)
  self:SetActive(self.ui.Group_Awaker_Equip, ownAwaker and ownAwaker > 0)
  if not ownAwaker or 0 == ownAwaker then
    return
  end
  if not AwakerDataUtils.IsAwakerShow(ownAwaker) then
    ownAwaker = AwakerDataUtils.GetChangerForm(ownAwaker)
  end
  local awakerIconPath = AwakerDataUtils.GetLittleIcon(ownAwaker)
  self:SetImage(self.ui.Icon_Awaker, awakerIconPath)
  local name = AwakerDataUtils.GetAwakerName(ownAwaker)
  name = LT.Textf("TipsAwakerEquip", name)
  self:SetText(self.ui.Text_Equip, name)
end

function BagView:_OnClickExchangeBtn()
  local feature = CommonDefine.FeatureId.Exchange
  local key = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, key)
  if unlocked then
    UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Exchange)
  else
    PlayerDataUtils.AlertLockedTips(feature, key)
  end
end

function BagView:_OnClickComposeBtn()
  local feature = CommonDefine.FeatureId.Compose
  local key = PlayerDataUtils.GetFeatureMainTypeKey()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, key)
  if unlocked then
    UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Compose)
  else
    PlayerDataUtils.AlertLockedTips(feature, key)
  end
end

function BagView:_OnClickRecastBtn()
  UIManager.Instance:Reopen(Urls.AlchemyMainPanel, AlchemyDefine.AlchemyType.Recast)
end

function BagView:_OnClickDecomposeBtn()
  local curType = BagExtModel.Instance:GetCurShowType()
  if self:_IsDecomposeUnlock() then
    local page = AlchemyDefine.AlchemyType.Decompose
    page = curType == ItemType.Weapon and page or AlchemyDefine.AlchemyType.TrinketDecompose
    UIManager.Instance:Reopen(Urls.AlchemyMainPanel, page)
  else
    local FeatureId = CommonDefine.FeatureId
    local feature = curType == ItemType.Weapon and FeatureId.Decompose or FeatureId.TrinketDecompose
    PlayerDataUtils.AlertLockedTips(feature, PlayerDataUtils.GetFeatureMainTypeKey())
  end
end

function BagView:_IsDecomposeUnlock()
  local curType = BagExtModel.Instance:GetCurShowType()
  if curType == ItemType.Weapon then
    local _, unDecomposelocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.Decompose, PlayerDataUtils.GetFeatureMainTypeKey())
    return unDecomposelocked
  elseif curType == ItemType.Trinket then
    local _, unTrinketDecomposelocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketDecompose, PlayerDataUtils.GetFeatureMainTypeKey())
    return unTrinketDecomposelocked
  end
  return false
end

function BagView:_OnClickBtnIntensify()
  local curType = BagExtModel.Instance:GetCurShowType()
  local isTrinket = curType == ItemType.Trinket
  if isTrinket then
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.TrinketLevelUp, 0)
    if not unlocked then
      PlayerDataUtils.AlertLockedTips(CommonDefine.FeatureId.TrinketLevelUp, 0)
      return
    end
  end
  local tabType = CommonDefine.TrinketStrengthenTap.Upgrade
  UIManager.Instance:Reopen(Urls.TrinketStrengthenPanel, tabType, BagExtModel.Instance:GetCurChosenUid())
end

function BagView:_OnClickSortTypeWeaponBtn()
  local sortTypeList = BagExtModel.Instance:GetWeaponSortTypeList()
  local curType = BagExtModel.Instance.weaponSortType
  TrinketFilterController.Instance:OpenCommonFilterView(self.ui.WeaponFilterPos.transform.position, curType, sortTypeList, function(t)
    BagExtModel.Instance:SetWeaponSortType(t)
  end)
end

return BagView
