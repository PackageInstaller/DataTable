local homeside_switch = {
  {type_name = 402876},
  {id = 2, type_name = 505990},
  {id = 3, type_name = 207152},
  {id = 4, type_name = 328680},
  [6] = {id = 6, type_name = 368168},
  [7] = {id = 7, type_name = 512101},
  [100] = {id = 100},
  [101] = {id = 101, type_name = 64409}
}
local __default_values = {id = 1, type_name = 192918}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(homeside_switch) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(homeside_switch, {__index = __rawdata})
return homeside_switch
