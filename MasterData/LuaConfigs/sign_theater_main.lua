local sign_theater_main = {
  {
    BG_pos = {280, 20},
    background_skin = 306204,
    hero_id = 1062,
    name = 49233,
    reward_id = {
      [3013] = 1
    },
    text = ""
  },
  {
    activity_rule = 9717,
    icon = "UI_EventPreciousCompany_RewardIcon_2",
    id = 2,
    start_avg = 3900201
  },
  {
    BG_pos = {281, 16},
    activity_rule = 9718,
    background_skin = 300210,
    icon = "UI_EventPreciousCompany_RewardIcon_3",
    id = 3,
    name = 434969,
    reward_id = {
      [3002] = 30
    },
    stage = 7,
    start_avg = 3900301
  }
}
local __default_values = {
  BG_pos = {268, 23},
  activity_rule = 9702,
  background_skin = 300202,
  file = "UI_EventPreciousCompany",
  hero_id = 1002,
  icon = "UI_EventPreciousCompany_RewardIcon_1",
  id = 1,
  name = 404540,
  reward_id = {
    [1505] = 1
  },
  skin_type = 1,
  stage = 10,
  start_avg = 0,
  text = 42422
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sign_theater_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sign_theater_main, {__index = __rawdata})
return sign_theater_main
