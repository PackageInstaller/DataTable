local skin_skin_lable = {
  {id = 1, name = 474101},
  {id = 2},
  {id = 3, name = 500955},
  {id = 4, name = 57483},
  [0] = {name = 347211}
}
local __default_values = {id = 0, name = "Live2D"}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(skin_skin_lable) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(skin_skin_lable, {__index = __rawdata})
return skin_skin_lable
