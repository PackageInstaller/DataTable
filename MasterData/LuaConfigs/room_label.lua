local room_label = {
  {
    name = 63497,
    show_type = 2,
    tag = 1
  },
  {
    id = 2,
    name = 148865,
    tag = 2
  },
  {id = 3},
  {id = 4},
  {id = 5},
  {id = 6},
  {id = 7, name = 45672},
  {
    id = 8,
    name = 512149,
    tag = 2
  },
  {
    id = 9,
    name = 505897,
    tag = 2
  },
  {id = 10},
  {id = 11},
  {id = 12},
  {
    id = 13,
    name = 388376,
    tag = 2
  },
  {
    id = 14,
    name = 388376,
    tag = 2
  },
  {id = 15},
  {id = 16},
  {id = 17}
}
local __default_values = {
  id = 1,
  name = 455202,
  show_type = 1,
  tag = 3,
  type = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(room_label) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(room_label, {__index = __rawdata})
return room_label
