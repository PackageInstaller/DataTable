local MainShopViewUtils = {}

function MainShopViewUtils.OpenActivityTicketBuyPanel(targetItemTid)
  local ticketInfo = ActivityCfgUtils.GetTicketInfoByTicketItemTid(targetItemTid)
  if not ticketInfo then
    return
  end
  local shopTid = ticketInfo.ticketShopTid
  local shopCfg = ShopCfgUtils.GetCfg(shopTid)
  if not shopCfg then
    return
  end
  local costItemTid = shopCfg.Price[1]
  local itemTid = shopCfg.Item[1]
  local shopType = shopCfg.ShopType
  local shopData = MainShopDataUtils.GetShopGoodDataByItemTid(shopType, itemTid)
  local maxBuyNum = shopData.maxBuyCount
  UIManager.Instance:Reopen(Urls.MainShopSingleBuyConfirmPanel, {
    itemId = costItemTid,
    shopItemData = shopData,
    shopType = shopCfg.ShopType,
    maxNum = maxBuyNum,
    currencyList = {itemTid, costItemTid}
  })
end

return MainShopViewUtils
