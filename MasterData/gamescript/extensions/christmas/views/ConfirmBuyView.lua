local ConfirmBuyView, Super = NewClass("ConfirmBuyView", BaseView)
ConfirmBuyView.uiResCls = "UI/UI_Research/UI_Research_Prefab/UI_Recharge_Popup_OptionGift.prefab"
local TempVector2 = CS.UnityEngine.Vector2.zero

function ConfirmBuyView:ctor(itemList, priceArr, buyCallback, extraInfo)
  Super.ctor(self)
  self.itemList = itemList or {}
  self.priceArr = priceArr or {}
  self.buyCallback = buyCallback
  self.extraInfo = extraInfo or {}
end

function ConfirmBuyView:OnBuildView()
  Super.OnBuildView(self)
  self:_SetBuyTips()
  self:_CreateCoinListDisplay()
  self:_CreateItemTableView()
end

function ConfirmBuyView:RegisterNotifications()
  self:RegisterNotify(NotifyId.OnBagItemDataChanged, self._OnBagItemDataChanged, self)
end

function ConfirmBuyView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnConfirmClick))
  self:AddButtonClickListener(self.ui.Btn_Cancel, System.fn(self, self._OnCancelClick))
end

function ConfirmBuyView:OnEnterView()
  Super.OnEnterView(self)
  self:_RefreshView()
end

function ConfirmBuyView:OnExitView()
  Super.OnExitView(self)
end

function ConfirmBuyView:_SetBuyTips()
  local buyTips = self.extraInfo.buyTips or LT.Text("MultiSelectBox_BuyConfirmText")
  self:SetText(self.ui.Text_Tip, buyTips)
end

function ConfirmBuyView:_CreateCoinListDisplay()
  if not self.extraInfo.currencyList then
    return
  end
  self:AddViewComponentOnce(self.ui.UI_Common_Item_Coin_Group, UICompCommonCurrencyGroupItem, self.extraInfo.currencyList, true)
end

function ConfirmBuyView:_CreateCloseButtonListener()
  local closeBtn = self.ui.UI_Common_Btn_Back3
  if closeBtn then
    self:AddViewComponent(closeBtn, UICompBtnCloseItem, {
      callbackFunc = System.fn(self, self.Close)
    })
  end
end

function ConfirmBuyView:_CreateItemTableView()
  local itemGameObj = self.ui.UI_Common_Item_WuPin_Type1
  local sizeDelta = itemGameObj.transform.sizeDelta
  local w, h = sizeDelta.x, sizeDelta.y
  self._itemTableView = self:CreateTableview(self.ui.ScrollView_Item, function()
    return #self.itemList
  end, function(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(itemGameObj)
    self:_FillItemCell(cell, index)
    return cell
  end, function()
    return w, h
  end)
end

function ConfirmBuyView:_FillItemCell(cell, index)
  local itemData = self.itemList[index]
  if not itemData then
    return
  end
  local itemTid = itemData.tid or itemData.itemTid or itemData.id
  local itemNum = itemData.num or itemData.count or 1
  self:AddViewComponentOnce(cell.gameObject, CompPublicIconItemType1, {
    tid = itemTid,
    num = itemNum,
    callback = function()
      ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, itemTid)
    end
  })
end

function ConfirmBuyView:_RefreshPriceDisplay()
  local priceItem = self.priceArr[1]
  local priceNum = self.priceArr[2]
  if self.ui.Image_Cost_Currency then
    local iconPath = ItemDataUtils.GetIcon(priceItem)
    if iconPath then
      self:SetImage(self.ui.Image_Cost_Currency, iconPath)
    end
  end
  if self.ui.Text_Cost_Num then
    local haveNum = ItemDataUtils.GetItemNum(priceItem)
    local isEnough = priceNum <= haveNum
    local color = "#ffffff"
    if not isEnough then
      color = "#FF6262"
    end
    local costText = string.format("<color=%s>x%d</color>", color, priceNum)
    self:SetText(self.ui.Text_Cost_Num, costText)
  end
end

function ConfirmBuyView:_RefreshView()
  self:RefreshItems()
  self:_RefreshPriceDisplay()
end

function ConfirmBuyView:RefreshItems()
  local offsetX = 0
  local maxShowCount = 6
  if maxShowCount > #self.itemList then
    local tableW = self.ui.ScrollView_Item.transform.sizeDelta.x
    local cellW = tableW / maxShowCount
    offsetX = (maxShowCount - #self.itemList) * cellW * 0.5
  end
  TempVector2.x = offsetX
  self._itemTableView.cellOffset = TempVector2
  self._itemTableView:ReloadData()
end

function ConfirmBuyView:_OnBagItemDataChanged()
  self:_RefreshPriceDisplay()
end

function ConfirmBuyView:_OnConfirmClick()
  if self.buyCallback then
    self.buyCallback()
  end
  if not self.extraInfo.keepAfterBuy then
    self:Close()
  end
end

function ConfirmBuyView:_OnCancelClick()
  self:Close()
end

return ConfirmBuyView
