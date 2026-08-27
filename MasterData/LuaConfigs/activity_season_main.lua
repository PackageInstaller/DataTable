local activity_season_main = {
  {}
}
local __default_values = {
  activity_end_mail = 171,
  activity_general_id = 31001,
  battle_title = 57318,
  battle_title_en = "REVIEW",
  cirRewardIds = {8235},
  cirRewardNums = {1},
  cirRewardPreviewIds = {
    1012,
    1003,
    8231,
    6003,
    8205
  },
  cirRewardPreviewNums = {
    30000,
    30000,
    1,
    2,
    10
  },
  cir_des = 53939,
  id = 1,
  mail_eliminate = {1227, 1228},
  refresh_max_tips = 7501,
  story_stage = 310001,
  tech_id = 9,
  tech_item = 1227,
  tech_special_branch = 26,
  ticket_item = 1007,
  token_item = 1064,
  warchess_guide_sector = 220012,
  warchess_season_id = 4
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_season_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_season_main, {__index = __rawdata})
return activity_season_main
