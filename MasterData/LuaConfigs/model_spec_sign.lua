local model_spec_sign = {
  {
    pre_sign = "low_monster_"
  },
  {id = 2},
  {id = 3, pre_sign = "universe_"}
}
local __default_values = {id = 1, pre_sign = "ew_"}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(model_spec_sign) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(model_spec_sign, {__index = __rawdata})
return model_spec_sign
