local ShopController = NewClass("ShopController", BaseController)
local ShopBulkBuyConfirmThresholdKey = "ShopBulkBuyConfirmThreshold"
local ShopBulkBuyConfirmTipsKey = "ShopBulkBuyConfirm"
local CoinBulkBuyConfirmTipsKey = "CoinBulkBuyConfirm"

function ShopController:OnInit()
end

function ShopController:OnReset()
end

function ShopController:OpenActivityShopView(activityTid)
  MainShopDataUtils.ReqShopData(function(_)
    UIManager.Instance:Reopen(Urls.ActivityShopView, activityTid)
  end)
end

function ShopController:OpenShopOneKeyPurchaseView(tbl, shopTypeId)
  ShopOneKeyPurchaseModel.Instance:OnReset()
  ShopOneKeyPurchaseModel.Instance:SetDefaultShopItemList(tbl)
  ShopOneKeyPurchaseModel.Instance:Set_shopTypeId(shopTypeId)
  UIManager.Instance:Reopen(Urls.ShopOneKeyPurchaseView)
end

function ShopController:OpenMainShopView()
  self:ReqMonthCardInfo(CommonDefine.MonthCardType.Energy)
  MainShopDataUtils.ReqShopData(function(_)
    UIManager.Instance:Reopen(Urls.MainShopView)
  end)
end

function ShopController:ReqPurchaseMonthCard(monthCardType, callback)
  MainShopDataUtils.PurchaseMonthCard(callback, monthCardType)
end

function ShopController:ReqMonthCardInfo(monthCardType, callback)
  MainShopDataUtils.RequestMonthCardInfo(function(svrData)
    ShopExtModel.Instance:UpdateMonthCardData(monthCardType, svrData)
    if callback then
      callback()
    end
  end, monthCardType)
end

function ShopController:OnMonthCardDataChanged(monthCardType)
  self:LocalNotify(NotifyId.OnUpdateMonthCardData, monthCardType)
end

function ShopController:GetBulkBuyThreshold(costItemId)
  local data = DT.GetOriginalConstant(ShopBulkBuyConfirmThresholdKey)
  if not data then
    return 0
  end
  for i = 1, #data do
    local pair = data[i]
    if pair and pair[1] == costItemId then
      return pair[2] or 0
    end
  end
  return 0
end

function ShopController:NeedBulkBuyConfirm(costItemId, totalCost)
  local threshold = self:GetBulkBuyThreshold(costItemId)
  return threshold > 0 and totalCost >= threshold
end

function ShopController:CheckBulkBuyConfirm(params, onConfirm)
  if not onConfirm then
    return
  end
  if not self:NeedBulkBuyConfirm(params.costItemId, params.totalCost) then
    onConfirm()
    return
  end
  local costItemName = ItemDataUtils.GetItemName(params.costItemId)
  local gainItemName = ItemDataUtils.GetItemName(params.gainItemTid)
  Alert.ShowWithParams(ShopBulkBuyConfirmTipsKey, {
    params.totalCost,
    costItemName,
    params.gainNum,
    gainItemName
  }, nil, onConfirm)
end

function ShopController:CheckBulkBuyConfirmForMulti(params, onConfirm)
  if not onConfirm then
    return
  end
  if not self:NeedBulkBuyConfirm(params.costItemId, params.totalCost) then
    onConfirm()
    return
  end
  Alert.ShowWithParams(CoinBulkBuyConfirmTipsKey, {
    params.totalCost
  }, nil, onConfirm)
end

return ShopController
