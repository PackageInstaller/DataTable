local star_score = {
  {},
  {rank_id = 2, score = 1295},
  {rank_id = 3, score = 1560},
  {rank_id = 4, score = 1703},
  {rank_id = 5, score = 1911},
  {rank_id = 6, score = 2184},
  {rank_id = 7, score = 2536},
  {rank_id = 8, score = 2953},
  {rank_id = 9, score = 3435},
  {rank_id = 10, score = 4000}
}
local __default_values = {rank_id = 1, score = 1000}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(star_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(star_score, {__index = __rawdata})
return star_score
