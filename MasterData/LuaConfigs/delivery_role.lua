local delivery_role = {
  [300208] = {hero_id = 1002},
  [301004] = {hero_id = 1010, skin_id = 301004},
  [301604] = {hero_id = 1016, skin_id = 301604},
  [301706] = {skin_id = 301706},
  [301707] = {skin_id = 301707},
  [302503] = {hero_id = 1025, skin_id = 302503},
  [302606] = {hero_id = 1026, skin_id = 302606},
  [304804] = {hero_id = 1048, skin_id = 304804},
  [305805] = {hero_id = 1058, skin_id = 305805},
  [306100] = {hero_id = 1061, skin_id = 306100},
  [306108] = {hero_id = 1061, skin_id = 306108},
  [306200] = {hero_id = 1062, skin_id = 306200},
  [306205] = {hero_id = 1062, skin_id = 306205},
  [308000] = {hero_id = 1080, skin_id = 308000},
  [308003] = {hero_id = 1080, skin_id = 308003}
}
local __default_values = {
  attribute_id = 1,
  hero_id = 1017,
  skin_id = 300208
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_role) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_role, {__index = __rawdata})
return delivery_role
