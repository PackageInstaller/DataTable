local __rt_1 = {}
local warchess_level_trigger = {
  [5000] = {ap_cost = 1},
  [5001] = {ap_cost = 1, tirgger_id = 5001},
  [5002] = {ap_cost = 1, tirgger_id = 5002},
  [6000] = {
    item = {
      3,
      3,
      1220,
      3
    },
    tirgger_id = 6000
  },
  [7000] = {
    item = {
      3,
      3,
      1222,
      3
    },
    tirgger_id = 7000
  },
  [7100] = {tirgger_id = 7100},
  [7200] = {
    item = {
      1,
      1,
      1220,
      1
    },
    tirgger_id = 7200
  }
}
local __default_values = {
  ap_cost = 0,
  item = __rt_1,
  tirgger_id = 5000
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_level_trigger) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_level_trigger, {__index = __rawdata})
return warchess_level_trigger
