local hero_merge = {
  [2] = {},
  [4] = {frag_merge = 25, rank = 4},
  [6] = {frag_merge = 90, rank = 6}
}
local __default_values = {frag_merge = 10, rank = 2}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_merge) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_merge, {__index = __rawdata})
return hero_merge
