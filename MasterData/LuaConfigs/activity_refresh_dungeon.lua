local activity_refresh_dungeon = {
  {}
}
local __default_values = {
  activity_avg = 1300101,
  avg_name = 103042,
  color_shop = {
    255,
    148,
    0
  },
  color_shoplist = {
    255,
    130,
    0
  },
  costList = {
    0,
    50,
    100,
    100,
    150
  },
  exchange = 5,
  exchange_txt = 7302,
  finish_avg = 1300119,
  finish_condition = 17,
  id = 1,
  pic = "Res/Images/Activity/AprilFool22/AprilFoolPic_PlotReview_Memeko.png",
  refreshCostId = 1002,
  refresh_times = {
    1,
    2,
    3,
    4,
    5
  },
  refresh_txt = 7301,
  shop_bg = "NoAtlas/UI_AprilFoolShopBG",
  shop_list = {1023, 1024},
  shop_name = 464082,
  task_list = {
    8106,
    8107,
    8108,
    8109,
    8110,
    8111,
    8112,
    8113,
    8114,
    8115,
    8116,
    8117,
    8118,
    8119,
    8120,
    8121,
    8122,
    8123,
    8124,
    8125,
    8126,
    8127,
    8128,
    8129,
    8130,
    8131,
    8132
  },
  tiny_game = 1,
  token = 1035
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_refresh_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_refresh_dungeon, {__index = __rawdata})
return activity_refresh_dungeon
