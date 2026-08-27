local tiny_game_type = {
  {game_name = 333532},
  {game_name = 89222, type_id = 2},
  {game_name = 113104, type_id = 3},
  {type_id = 4},
  {game_name = 349607, type_id = 5},
  {game_name = 286832, type_id = 6},
  {game_name = 237298, type_id = 7},
  {game_name = 402314, type_id = 8},
  {type_id = 9}
}
local __default_values = {game_name = 320251, type_id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tiny_game_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tiny_game_type, {__index = __rawdata})
return tiny_game_type
