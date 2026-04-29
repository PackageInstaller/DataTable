local key = {
  DrawOnceText = 1,
  DrawMultiText = 2,
  HelpInfo = 3,
  CurrencyId = 4
}
local config = {
  [1002] = {
    "str_sakura_draw_shop_get_one",
    "str_sakura_draw_shop_get_multi",
    "str_sakura_draw_shop_intro",
    3500001
  },
  [1011] = {
    "str_n10_lottery_one",
    "str_n10_lottery_multi"
  }
}
return config, "CampaignID", key
