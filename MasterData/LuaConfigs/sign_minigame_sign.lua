local __rt_1 = {
  188,
  288,
  388
}
local __rt_2 = {
  100,
  200,
  300
}
local sign_minigame_sign = {
  {avg_id = 2000101},
  {
    atlas_name = "UI_SignInMiniGameBq2",
    id = 2
  },
  {
    atlas_name = "UI_SignInMiniGameBq3",
    id = 3
  }
}
local __default_values = {
  atlas_name = "UI_SignInMiniGameBq",
  avg_id = 0,
  award_num_max = __rt_1,
  award_num_min = __rt_2,
  id = 1,
  total_sign_times = 7
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sign_minigame_sign) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sign_minigame_sign, {__index = __rawdata})
return sign_minigame_sign
