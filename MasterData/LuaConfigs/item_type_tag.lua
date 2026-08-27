local item_type_tag = {
  [2] = {id = 2, name = 444480},
  [13] = {name = 244266},
  [15] = {id = 15, name = 421882},
  [16] = {id = 16, name = 235828},
  [17] = {id = 17, name = 75455},
  [18] = {id = 18, name = 464848},
  [20] = {id = 20},
  [21] = {id = 21, name = 499971},
  [22] = {id = 22, name = 266201},
  [23] = {id = 23, name = 207444},
  [25] = {id = 25, name = 7089}
}
local __default_values = {id = 13, name = 159487}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(item_type_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(item_type_tag, {__index = __rawdata})
return item_type_tag
