local __rt_1 = {12}
local __rt_2 = {
  21101,
  21102,
  21103,
  21036,
  21037,
  21038,
  21039,
  21040,
  21041
}
local __rt_3 = {-1}
local __rt_4 = {
  1,
  2,
  2
}
local __rt_5 = {1041, 1042}
local activity_carnival = {
  {
    cir_reward = {},
    exp_rule_id = 2,
    hard_rule_id = 4,
    pool_quality = {
      [8210] = 1,
      [8211] = 1,
      [8212] = 1,
      [8213] = 1,
      [8214] = 1,
      [8215] = 1,
      [8216] = 1,
      [8217] = 2,
      [8218] = 2,
      [8219] = 2,
      [8220] = 2,
      [8221] = 2,
      [8222] = 2,
      [8223] = 2,
      [8224] = 2,
      [8225] = 2,
      [8226] = 2,
      [8227] = 3,
      [8228] = 3,
      [8229] = 3,
      [8230] = 3,
      [8231] = 3,
      [8232] = 3,
      [8233] = 3,
      [8234] = 3,
      [8235] = 2,
      [8236] = 1,
      [8238] = 1,
      [8239] = 1,
      [8240] = 1,
      [8241] = 1,
      [8242] = 2,
      [8243] = 2,
      [8244] = 2,
      [8245] = 2,
      [8246] = 2,
      [8247] = 3,
      [8248] = 3,
      [8249] = 3,
      [8250] = 3,
      [8251] = 3,
      [8252] = 3
    },
    task_rule_id = 3
  },
  {
    cir_reward_tip = 7138,
    exp_logic = 2,
    game_mash_up = 3,
    guide_id = 44,
    hard_level_type = 2,
    id = 2,
    main_stage = 130022,
    pre_para2 = {1681977599},
    story_stage = 130021,
    tech_id = 8
  }
}
local __default_values = {
  change_frequency = 1,
  cir_reward = {
    [1037] = 1
  },
  cir_reward_tip = 0,
  exp_item = 1043,
  exp_logic = 1,
  exp_rule_id = 16,
  first_avg = 19,
  game_mash_up = 1,
  guide_id = 21,
  hard_level_type = 1,
  hard_pre_condition = __rt_1,
  hard_rule_id = 14,
  id = 1,
  initial_protocol_all = __rt_2,
  main_stage = 130012,
  norTechItem = 1041,
  pool_quality = {
    [6200] = 1,
    [6201] = 1,
    [6202] = 1,
    [6203] = 1,
    [6204] = 1,
    [6205] = 1,
    [6206] = 1,
    [6207] = 1,
    [6208] = 2,
    [6209] = 2,
    [6210] = 2,
    [6211] = 2,
    [6212] = 2,
    [6213] = 2,
    [6214] = 2,
    [6215] = 2,
    [6216] = 2,
    [6217] = 2,
    [6218] = 2,
    [6219] = 3,
    [6220] = 3,
    [6221] = 3,
    [6222] = 3,
    [6223] = 3,
    [6224] = 3,
    [6225] = 3,
    [6226] = 3,
    [6227] = 3,
    [6228] = 3,
    [6229] = 3
  },
  pre_para1 = __rt_3,
  pre_para2 = {1655971199},
  speTechItem = 1042,
  story_stage = 130011,
  task_allot = __rt_4,
  task_rule_id = 15,
  tech_id = 2,
  tech_item = __rt_5,
  ticket_item = 1040
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  sectorMapping = {
    [130011] = 1,
    [130012] = 1,
    [130021] = 2,
    [130022] = 2
  }
}
setmetatable(activity_carnival, {__index = __rawdata})
return activity_carnival
