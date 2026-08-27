local activity_monster_card_label = {
  {name = 421484},
  {id = 2, name = 66324},
  {id = 3, name = 388173},
  {id = 4, name = 359819},
  {id = 5, name = 231848},
  {id = 6, name = 247321},
  {id = 7, name = 266642},
  {id = 8, name = 387002},
  {id = 9, name = 337369},
  {id = 10, name = 180243},
  {id = 11, name = 182327},
  {id = 12, name = 9013},
  {id = 13, name = 500473},
  {id = 14},
  {id = 15, name = 46305},
  {id = 16, name = 317646},
  {id = 17, name = 53739}
}
local __default_values = {id = 1, name = 130574}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_monster_card_label) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_monster_card_label, {__index = __rawdata})
return activity_monster_card_label
