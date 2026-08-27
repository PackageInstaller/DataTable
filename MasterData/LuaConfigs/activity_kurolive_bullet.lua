local activity_kurolive_bullet = {
  {text = 87723},
  {id = 2, text = 493517},
  {id = 3, text = 449434},
  {id = 4, text = 62700},
  {id = 5, text = 117823},
  {id = 6, text = 37520},
  {id = 7, text = 284340},
  {id = 8, text = 144767},
  {id = 9, text = 453496},
  {id = 10, text = 293580},
  {id = 11, text = 172260},
  {id = 12, text = 306460},
  {id = 13, text = 72187},
  {id = 14, text = 420508},
  {id = 15, text = 514752},
  {id = 16, text = 197757},
  {id = 17, text = 264300},
  {id = 18, text = 177982},
  {id = 19},
  {id = 20, text = 319943},
  {id = 21, text = 22089},
  {id = 22, text = 75641}
}
local __default_values = {id = 1, text = 103636}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_kurolive_bullet) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_kurolive_bullet, {__index = __rawdata})
return activity_kurolive_bullet
