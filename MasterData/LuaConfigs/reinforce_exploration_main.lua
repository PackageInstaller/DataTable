local reinforce_exploration_main = {
  [59001] = {}
}
local __default_values = {
  continue_sector = 590013,
  daily_friend_frequency = 99,
  default_issue_list = {
    [61010] = 1,
    [61011] = 1,
    [61012] = 1,
    [61013] = 1,
    [61014] = 1
  },
  factor_chip_num = 15,
  factor_num = 10,
  factor_rule = 25,
  guide_id = 5900101,
  id = 59001,
  need_card = 5,
  one_friend_reward = {
    [1282] = 50
  },
  save_guide_id = 5900102,
  sec_guide_id = 5900103,
  set_friend_factor = 3,
  slots_num = 10,
  tips_id = 72,
  total_friend_reward = 50
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_exploration_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(reinforce_exploration_main, {__index = __rawdata})
return reinforce_exploration_main
