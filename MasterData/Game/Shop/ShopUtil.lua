local ShopUtil = {}
local ShopEnum = require("Game.Shop.ShopEnum")
local CheckerTypeId, _ = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))

function ShopUtil.CommonSortGoodList(dataList)
  table.sort(dataList, function(a, b)
    if a.currencyId ~= b.currencyId then
      return a.currencyId > b.currencyId
    end
    if a.discount ~= b.discount then
      return a.discount < b.discount
    end
    if a.order ~= b.order then
      return a.order < b.order
    end
    return a.shelfId < b.shelfId
  end)
end

local function RefreshShopSorter(a, b)
  if a.isSoldOut ~= b.isSoldOut then
    return not a.isSoldOut
  end
  if a.isSoldOut then
    local aIsLimitHold = PlayerDataCenter:IsItemLimitHold(a.itemId)
    local bIsLimitHold = PlayerDataCenter:IsItemLimitHold(b.itemId)
    if aIsLimitHold ~= bIsLimitHold then
      return aIsLimitHold
    end
    if a:IsReplenishGoodsAndCount() ~= b:IsReplenishGoodsAndCount() then
      return a:IsReplenishGoodsAndCount()
    end
  end
  local aFragMax = false
  local bFragMax = false
  if a.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[a.itemCfg.arg[1]]
    if heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0 then
      aFragMax = true
    end
  end
  if b.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[b.itemCfg.arg[1]]
    if heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0 then
      bFragMax = true
    end
  end
  if aFragMax ~= bFragMax then
    return bFragMax
  end
  if a.currencyId ~= b.currencyId then
    return a.currencyId > b.currencyId
  end
  if a.discount ~= b.discount then
    return a.discount < b.discount
  end
  if a.order ~= b.order then
    return a.order < b.order
  end
  return a.shelfId < b.shelfId
end

local function NonRefreshShopSorter(a, b)
  if a.isSoldOut ~= b.isSoldOut then
    return not a.isSoldOut
  end
  if a.isSoldOut then
    local aIsLimitHold = PlayerDataCenter:IsItemLimitHold(a.itemId)
    local bIsLimitHold = PlayerDataCenter:IsItemLimitHold(b.itemId)
    if aIsLimitHold ~= bIsLimitHold then
      return aIsLimitHold
    end
    if a:IsReplenishGoodsAndCount() ~= b:IsReplenishGoodsAndCount() then
      return a:IsReplenishGoodsAndCount()
    end
  end
  local aFragMax = false
  local bFragMax = false
  if a.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[a.itemCfg.arg[1]]
    if heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0 then
      aFragMax = true
    end
  end
  if b.itemCfg.action_type == eItemActionType.HeroCardFrag then
    local heroData = PlayerDataCenter.heroDic[b.itemCfg.arg[1]]
    if heroData ~= nil and heroData:GetMaxNeedFragNum(true) <= 0 then
      bFragMax = true
    end
  end
  if aFragMax ~= bFragMax then
    return bFragMax
  end
  if a.order ~= b.order then
    return a.order < b.order
  end
  if a.currencyId ~= b.currencyId then
    return a.currencyId > b.currencyId
  end
  if a.discount ~= b.discount then
    return a.discount < b.discount
  end
  return a.shelfId < b.shelfId
end

function ShopUtil.CommonAndFragSrotGoodList(dataList, isRefeshShop)
  if isRefeshShop then
    table.sort(dataList, RefreshShopSorter)
  else
    table.sort(dataList, NonRefreshShopSorter)
  end
end

function ShopUtil.GetSkinShopIdList()
  local needStoreList = {}
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Store) then
    for k, shopId in ipairs(ConfigData.skin.skinShopIds) do
      local shopCfg = ConfigData.shop[shopId]
      if shopCfg == nil then
        if isGameDev then
          error("shopCfg is nil shopId=" .. tostring(shopId))
        end
      elseif CheckCondition.CheckLua(shopCfg.pre_condition, shopCfg.pre_para1, shopCfg.pre_para2) then
        table.insert(needStoreList, shopId)
      end
    end
  end
  return needStoreList
end

function ShopUtil.GetShopPriorityGiftId(shopId)
  local shopCfg = ConfigData.shop[shopId]
  if shopCfg == nil then
    error("shopCfg is nil shopId=" .. tostring(shopId))
    return 0
  end
  return shopCfg.priority_gift
end

function ShopUtil.ExistShopPriorityGift(shopId)
  if shopId <= 0 then
    return false
  end
  local giftId = ShopUtil.GetShopPriorityGiftId(shopId)
  if giftId <= 0 then
    return false
  end
  local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
  if payGiftCtrl == nil then
    return false
  end
  local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
  if giftInfo == nil or giftInfo:IsSoldOut() or not giftInfo:IsUnlock() then
    return false
  end
  return true
end

local ShopCurrencyGiftCheck = {
  [ConstGlobalItem.BpSkinCoin] = function()
    for _, passInfo in pairs(PlayerDataCenter.battlepassData.passInfos) do
      if passInfo:IsBattleType() and passInfo:GetBpSkinCoinGift() > 0 then
        return true
      end
    end
    return false
  end
}
local ShopCurrencyGiftBuy = {
  [ConstGlobalItem.BpSkinCoin] = function()
    for _, passInfo in pairs(PlayerDataCenter.battlepassData.passInfos) do
      if passInfo:IsBattleType() and passInfo:GetBpSkinCoinGift() > 0 then
        local payGiftCtrl = ControllerManager:GetController(ControllerTypeId.PayGift)
        if payGiftCtrl == nil then
          return false
        end
        local giftId = passInfo:GetBpSkinCoinGift()
        local shopId = passInfo:GetBPSkinShopId()
        if ShopUtil.ExistShopPriorityGift(shopId) then
          local priorityGiftId = ShopUtil.GetShopPriorityGiftId(shopId)
          giftId = priorityGiftId
        end
        local giftInfo = payGiftCtrl:GetPayGiftDataById(giftId)
        if giftInfo ~= nil and giftInfo:IsUnlock() then
          local quickBuy = UIManager:GetWindow(UIWindowTypeID.QuickBuy)
          if quickBuy ~= nil then
            quickBuy:SlideOutImmediately()
          end
          UIManager:ShowWindowAsync(UIWindowTypeID.QuickBuy, function(window)
            window:SlideIn()
            window:InitBuyPayGift(giftInfo)
          end)
          return true
        end
        return false
      end
    end
  end
}

function ShopUtil.CheckCurrencyExchange(itemId)
  local func = ShopCurrencyGiftCheck[itemId]
  if func ~= nil then
    return func()
  end
  return false
end

function ShopUtil.StartCurrencyExchange(itemId)
  local buyFunc = ShopCurrencyGiftBuy[itemId]
  if buyFunc == nil then
    return nil
  end
  return buyFunc()
end

function ShopUtil.GetShopGoodStillTime(shelfCfg)
  if shelfCfg == nil or shelfCfg.pre_condition == nil then
    return false
  end
  for index, coditon in ipairs(shelfCfg.pre_condition) do
    if coditon == CheckerTypeId.TimeRange then
      local startTime = shelfCfg.pre_para1[index]
      local endTime = shelfCfg.pre_para2[index]
      local inTime = startTime < PlayerDataCenter.timestamp and (endTime > PlayerDataCenter.timestamp or endTime == -1)
      return true, inTime, startTime, endTime
    end
  end
  return false
end

return ShopUtil
