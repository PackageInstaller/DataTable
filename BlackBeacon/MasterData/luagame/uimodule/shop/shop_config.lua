local config = {}
config.SHOP_NAME = {
  [1] = Util.format_str("推荐商品"),
  [2] = Util.format_str("月卡购买"),
  [3] = Util.format_str("礼包商城"),
  [4] = Util.format_str("角色装扮"),
  [5] = Util.format_str("货币兑换"),
  [6] = Util.format_str("楔石兑换")
}
config.DEF_SHOP_TYPE = 1
config.SHOP_TYPE_NAME = {
  "Recommend",
  "MonthCard",
  "GiftShop",
  "Skin",
  "Exchange",
  "Recharge",
  "TokenExchange"
}
config.SHOP_TYPE = {
  Recommend = 1,
  MonthCard = 2,
  GiftShop = 3,
  Skin = 4,
  Exchange = 5,
  Recharge = 6,
  TokenExchange = 7
}
config.SHOP_RESET_TYPE = {
  DAILY = 1,
  WEEKLY = 2,
  MONTHLY = 3
}
config.GIFT_TIPS_TYPE = {DETAIL = 1, SKIN_SHORT = 2}
config.GIFT_LIMIT_TYPES = {
  [1] = Util.format_str("每日限购"),
  [2] = Util.format_str("每周限购"),
  [3] = Util.format_str("每月限购")
}
config.EXCHANGE_LIMIT_TYPES = {
  [0] = Util.format_str("永久限购"),
  [1] = Util.format_str("每日限购"),
  [2] = Util.format_str("每周限购"),
  [3] = Util.format_str("每月限购")
}
config.GIFT_SHOP_SHELF = {}
for _, v in pairs(ShareRes.create("recharge.gift_shop_page")) do
  table.insert(config.GIFT_SHOP_SHELF, v)
end
table.sort(config.GIFT_SHOP_SHELF, function(a, b)
  return a.Priority > b.Priority
end)
config.DEF_SHOP_SHELF = config.GIFT_SHOP_SHELF[1].Id
config.SKIN_GIFT_SHOP_SHELF = 10000
config.WEAPON_SKIN_GIFT_SHOP_SHELF = 10001
config.REMD_SHOP_SHELF = {
  VERSION = 1,
  CARD = 2,
  ORDER = 3,
  RECOMMOND = 4,
  FIRSTCHARGE = 5,
  LIVENESSGIFT = 6
}
config.SKIN_COUPON_ID = 25
config.DF_CARD_TYPE = 1
return config
