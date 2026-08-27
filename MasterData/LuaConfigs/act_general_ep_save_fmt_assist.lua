local __rt_1 = {20006}
local act_general_ep_save_fmt_assist = {
  {
    func_group = {
      [17311] = 1,
      [17312] = 1,
      [17313] = 1,
      [17314] = 1
    },
    score_num = 50
  },
  {
    assistance_id = 2,
    score_num = 25,
    team_id = 268
  },
  {
    assistance_id = 3,
    func_group = {
      [17321] = 1,
      [17322] = 1,
      [17323] = 1,
      [17324] = 1
    },
    team_id = 269
  }
}
local __default_values = {
  assistance_id = 1,
  func_group = {
    [17301] = 1,
    [17302] = 1,
    [17303] = 1,
    [17304] = 1
  },
  proto_group = __rt_1,
  score_num = 0,
  team_id = 267
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_ep_save_fmt_assist) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(act_general_ep_save_fmt_assist, {__index = __rawdata})
return act_general_ep_save_fmt_assist
