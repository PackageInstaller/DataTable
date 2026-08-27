local activity_hallowmas_name = {
  {},
  {id = 2, name = 221374},
  {id = 3, name = 313123},
  {id = 4, name = 355922},
  {id = 5, name = 298662}
}
local __default_values = {id = 1, name = 175251}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hallowmas_name) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hallowmas_name, {__index = __rawdata})
return activity_hallowmas_name
