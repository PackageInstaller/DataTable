local __rt_1 = {}
local tiny_game_brotato = {
  {
    join_reward = {
      [1066] = 200,
      [1504] = 5,
      [400061] = 1
    },
    join_score = 50,
    snake_guide_id = 48,
    stage_id = 330013100,
    type_difficulty = 1
  },
  {
    id = 2,
    snake_guide_id = 53,
    stage_id = 240032100,
    task_item = 1073,
    task_type = 1800
  },
  {
    id = 3,
    task_item = 1088,
    task_type = 1801
  },
  {
    id = 4,
    task_item = 1091,
    task_type = 1802
  },
  {
    id = 5,
    join_reward = {
      [1099] = 200,
      [1504] = 5,
      [400061] = 1
    },
    join_score = 50,
    snake_guide_id = 48,
    stage_id = 330123100,
    type_difficulty = 1
  },
  {
    id = 6,
    stage_id = 570011100,
    task_item = 1267,
    task_type = 1803
  }
}
local __default_values = {
  id = 1,
  join_reward = __rt_1,
  join_score = 0,
  snake_guide_id = 61,
  stage_id = 450014100,
  task_item = 0,
  task_type = 0,
  type_difficulty = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tiny_game_brotato) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tiny_game_brotato, {__index = __rawdata})
return tiny_game_brotato
