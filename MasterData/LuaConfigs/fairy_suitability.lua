local fairy_suitability = {
  {name = 337369},
  {id = 2},
  {id = 3, name = 363642},
  {id = 4, name = 182327},
  {id = 5, name = 383560}
}
local __default_values = {id = 1, name = 180243}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(fairy_suitability) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(fairy_suitability, {__index = __rawdata})
return fairy_suitability
