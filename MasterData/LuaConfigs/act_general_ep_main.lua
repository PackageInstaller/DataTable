local __rt_1 = {
  1,
  2,
  3,
  4
}
local __rt_2 = {}
local act_general_ep_main = {
  [40001] = {},
  [40002] = {
    activity_id = 40002,
    env_list = {
      4,
      5,
      6
    },
    main_stage = 400022
  },
  [56001] = {
    activity_id = 56001,
    difficulty_list = {
      1,
      2,
      3,
      4,
      5
    },
    env_list = {
      7,
      8,
      9,
      10
    },
    main_stage = 560011
  }
}
local __default_values = {
  activity_id = 40001,
  difficulty_list = __rt_1,
  env_list = {
    1,
    2,
    3
  },
  initial_protocol = __rt_2,
  initial_protocol_all = __rt_2,
  main_stage = 400011,
  ticket_item = 1007
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_ep_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(act_general_ep_main, {__index = __rawdata})
return act_general_ep_main
