local __rt_1 = {1, 100}
local active_level = {
  [6400] = {id = 6400, type = 1},
  [6401] = {id = 6401},
  [9600] = {id = 9600, type = 1},
  [9601] = {id = 9601},
  [15001] = {type = 1},
  [15002] = {id = 15002, type = 1},
  [15003] = {id = 15003, type = 1},
  [15004] = {id = 15004, type = 1},
  [15005] = {id = 15005, type = 1},
  [15006] = {id = 15006, type = 1},
  [15007] = {id = 15007, type = 1},
  [15008] = {id = 15008, type = 1},
  [15009] = {id = 15009, type = 1},
  [15010] = {id = 15010, type = 1},
  [15011] = {id = 15011},
  [15012] = {id = 15012},
  [15013] = {id = 15013},
  [15014] = {id = 15014},
  [15015] = {id = 15015},
  [15016] = {id = 15016},
  [15017] = {id = 15017},
  [15018] = {id = 15018},
  [15019] = {id = 15019},
  [15020] = {id = 15020},
  [15021] = {id = 15021},
  [15022] = {id = 15022},
  [15023] = {id = 15023},
  [15024] = {id = 15024, type = 1},
  [15025] = {id = 15025, type = 1},
  [15026] = {id = 15026},
  [15027] = {id = 15027, type = 1},
  [16001] = {id = 16001, type = 3},
  [16002] = {id = 16002, type = 3},
  [16003] = {id = 16003, type = 3},
  [16004] = {id = 16004, type = 3},
  [16005] = {id = 16005, type = 3},
  [16006] = {id = 16006, type = 3},
  [16007] = {id = 16007, type = 3},
  [16008] = {id = 16008, type = 3},
  [16009] = {id = 16009, type = 3},
  [16010] = {id = 16010, type = 3},
  [16011] = {id = 16011, type = 3},
  [16012] = {id = 16012, type = 3},
  [16013] = {id = 16013, type = 3},
  [16014] = {
    id = 16014,
    is_daily = true,
    type = 3
  }
}
local __default_values = {
  id = 15001,
  is_daily = false,
  level = __rt_1,
  type = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(active_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(active_level, {__index = __rawdata})
return active_level
