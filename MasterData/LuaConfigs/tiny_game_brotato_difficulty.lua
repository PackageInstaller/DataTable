local __rt_1 = {}
local __rt_2 = {523755}
local tiny_game_brotato_difficulty = {
  {
    {brotato_id = 1, stage_id = 330013100}
  },
  {
    {name = 248204},
    {
      des = {332702},
      id = 2,
      name = 215360,
      stage_id = 240032101
    },
    {
      des = {332702, 293308},
      id = 3,
      name = 360027,
      stage_id = 240032102
    },
    {
      des = {
        332702,
        293308,
        244861
      },
      id = 4,
      name = 94840,
      stage_id = 240032103
    }
  },
  {
    {
      brotato_id = 3,
      des = {131776, 215559},
      name = 144559,
      stage_id = 450014100
    },
    {
      brotato_id = 3,
      des = {433940, 391836},
      id = 2,
      name = 205978,
      stage_id = 450014101
    }
  },
  {
    {
      brotato_id = 4,
      name = 40635,
      stage_id = 400025100
    },
    {
      brotato_id = 4,
      des = __rt_2,
      id = 2,
      name = 70989,
      stage_id = 400025101
    }
  },
  {
    {brotato_id = 5, stage_id = 330123100}
  },
  {
    {
      brotato_id = 6,
      name = 40635,
      stage_id = 570011100
    },
    {
      brotato_id = 6,
      des = __rt_2,
      id = 2,
      name = 70989,
      stage_id = 570011101
    },
    {
      brotato_id = 6,
      des = {523755, 244861},
      id = 3,
      name = 412296,
      stage_id = 570011102
    }
  }
}
local __default_values = {
  brotato_id = 2,
  des = __rt_1,
  id = 1,
  name = 237298,
  stage_id = 240032100
}
local base = {__index = __default_values}
for k, v in pairs(tiny_game_brotato_difficulty) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  stageBrotatoDic = {
    [240032100] = 2,
    [240032101] = 2,
    [240032102] = 2,
    [240032103] = 2,
    [330013100] = 1,
    [330123100] = 5,
    [400025100] = 4,
    [400025101] = 4,
    [450014100] = 3,
    [450014101] = 3,
    [570011100] = 6,
    [570011101] = 6,
    [570011102] = 6
  }
}
setmetatable(tiny_game_brotato_difficulty, {__index = __rawdata})
return tiny_game_brotato_difficulty
