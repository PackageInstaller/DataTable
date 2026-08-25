local ShopOneKeyPurchaseView, Super = NewClass("ShopOneKeyPurchaseView", BaseView)
ShopOneKeyPurchaseView.uiResCls = UI_Recharge_OnekeyPurchaseResource

function ShopOneKeyPurchaseView:ctor()
  Super.ctor(self)
  self.model = ShopOneKeyPurchaseModel.Instance
end

function ShopOneKeyPurchaseView:OnBuildView()
  Super.OnBuildView(self)
end

function ShopOneKeyPurchaseView:RegisterEvents()
  Super.RegisterEvents(self)
end

function ShopOneKeyPurchaseView:RegisterNotifications()
  Super.RegisterNotifications(self)
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self.OnClickConfirm))
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
  self:InitShopItemListView()
end

function ShopOneKeyPurchaseView:OnEnterView()
  Super.OnEnterView(self)
  self:BindCurrency(self.ui.UI_Common_Item_Coin_Group, ShopTypeDataUtils.GetCfgByField(self.model:Get_shopTypeId()) or {})
  self:SetButtonText(self.ui.Btn_Cancel, LT.Text("UniversalCancelButton"))
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("Shop_Buy_Btn"))
  self:SetImage(self.ui.Image_GoldShop, ItemDataUtils.GetItemIcon(self.model:GetCostCurrecyTid()))
  local currencyList = {
    self.model:GetCostCurrecyTid()
  }
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, currencyList)
  self:RefreshView()
end

function ShopOneKeyPurchaseView:RefreshView()
  self.rewardListView:ReloadData()
  self:SetText(self.ui.Text_Cost_Num, self.model:Get_totalCostNum())
  self:_RefreshCoinCost()
end

function ShopOneKeyPurchaseView:_RefreshCoinCost()
  self:SetTextColorByHtml(self.ui.Text_Cost_Num, self.model:CheckCurrencyEnough() and "#ffffff" or DT.ColorConfig.Red.Light)
end

function ShopOneKeyPurchaseView:_OnBagItemDataChanged(_, tid)
  if self.model:GetCostCurrecyTid() == tid then
    self:_RefreshCoinCost()
  end
end

function ShopOneKeyPurchaseView:InitShopItemListView()
  self.rewardListView = self:CreateTableview(self.ui.ScrollView, function()
    if not self.model:Get_showShopItemList() then
      return 0
    end
    return #self.model:Get_showShopItemList()
  end, function(view, index)
    do return self._ShopItemCellAtIndex, self, view end
    return self._ShopItemCellAtIndex, self, view, index
  end)
  self.rewardListView:ReloadData()
end

function ShopOneKeyPurchaseView:_ShopItemCellAtIndex(view, index)
  local cell = view:DequeueCell()
  cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type1)
  local shopItemData = self.model:Get_showShopItemList()[index]
  local tid = MainShopDataUtils.GetShopGoodTid(shopItemData)
  local isSelect = self.model:IsInShopItemList(shopItemData)
  local viewData = {
    num = MainShopDataUtils.GetGoodRemaining(shopItemData),
    tid = tid,
    callback = function()
      self.model:Add_shopItemList(shopItemData)
      self:RefreshView()
      ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, tid)
      self.model:SaveSelectItems()
    end,
    btnSubFunc = function()
      self.model:Remove_shopItemList(shopItemData)
      self:RefreshView()
      self.model:SaveSelectItems()
    end,
    clickFrameShowFunc = function()
      return isSelect
    end,
    selectedFunc = function()
      return isSelect
    end,
    showSubBtn = isSelect
  }
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType1, viewData)
  return cell
end

function ShopOneKeyPurchaseView:OnClickConfirm()
  if not self.model:CheckCurrencyEnough() then
    Alert.ShowStr(LT.Textf(DT.TipsType[10709].Desc, ItemDataUtils.GetItemName(self.model:GetCostCurrecyTid())))
    return
  end
  local sendTbl = self.model:GetGoodTid2NumMap()
  if not table.next(sendTbl) then
    self:Close()
    return
  end
  local costNum = self.model:Get_totalCostNum()
  
  local function reqFunc()
    MainShopDataUtils.ReqOnShopOneKeyBuy(self.model:Get_shopTypeId(), self.model:GetGoodTid2NumMap(), System.fn(self, self.Close))
  end
  
  ShopController.Instance:CheckBulkBuyConfirmForMulti({
    costItemId = self.model:GetCostCurrecyTid(),
    totalCost = costNum
  }, reqFunc)
end

function ShopOneKeyPurchaseView:OnExitView()
  Super.OnExitView(self)
end

return ShopOneKeyPurchaseView
