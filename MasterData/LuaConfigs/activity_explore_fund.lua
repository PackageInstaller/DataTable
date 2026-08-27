local __rt_1 = {3}
local __rt_2 = {}
local activity_explore_fund = {
  {
    name = 486655,
    pre_condition2 = __rt_2,
    pre_para3 = __rt_2
  },
  {
    fund_id = 2,
    pre_para1 = {3115},
    reward_tips = 48308,
    senior_price = 100558
  }
}
local __default_values = {
  fund_id = 1,
  name = 342701,
  pre_condition = __rt_1,
  pre_condition2 = {35},
  pre_para1 = {1104},
  pre_para2 = __rt_2,
  pre_para3 = {1},
  pre_para4 = __rt_2,
  rebate_num = "500%",
  reward_tips = 134141,
  senior_price = 100557
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_explore_fund) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_explore_fund, {__index = __rawdata})
return activity_explore_fund
