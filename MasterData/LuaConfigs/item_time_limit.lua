local item_time_limit = {
  [906] = {
    id = 906,
    time = 15552000,
    type = 2
  },
  [1086] = {time = 1709193599},
  [1300] = {
    id = 1300,
    time = 2592000,
    type = 2
  },
  [3009] = {id = 3009, time = 1666857599},
  [3010] = {id = 3010, time = 1680163199},
  [3011] = {id = 3011, time = 1687420799},
  [3012] = {id = 3012, time = 1694678399},
  [3013] = {id = 3013, time = 1698307199},
  [3014] = {id = 3014, time = 1706169599},
  [3015] = {id = 3015, time = 1706169599},
  [3016] = {id = 3016, time = 1718870399},
  [3017] = {id = 3017, time = 1728547199},
  [5012] = {id = 5012, type = 2},
  [5013] = {id = 5013, type = 2},
  [5014] = {id = 5014, type = 2},
  [39006] = {
    id = 39006,
    time = 259200,
    type = 2
  }
}
local __default_values = {
  id = 1086,
  time = 604800,
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(item_time_limit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(item_time_limit, {__index = __rawdata})
return item_time_limit
