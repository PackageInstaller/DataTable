local reinforce_card_label = {
  {name = 9013},
  {id = 2, name = 337369},
  {id = 3, name = 182327},
  {id = 4, name = 180243},
  {id = 5, name = 383560},
  {id = 6, name = 53739},
  {id = 7},
  {id = 8, name = 66324},
  {id = 9, name = 359819},
  {id = 10, name = 326679},
  {id = 11, name = 83178},
  {id = 12, name = 388173},
  {id = 13, name = 421484},
  {id = 14, name = 399983}
}
local __default_values = {id = 1, name = 170377}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_card_label) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(reinforce_card_label, {__index = __rawdata})
return reinforce_card_label
