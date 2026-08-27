local activity_carnival_difficulty = {
  {
    difficulty_des = 410314,
    difficulty_name = 204801,
    difficulty_name_en = "Jolly Parade"
  },
  {
    catalog = {
      201,
      202,
      203,
      204
    },
    difficulty_des = 369963,
    difficulty_name = 171951,
    id = 2
  },
  {
    catalog = {
      301,
      302,
      303,
      304,
      305
    },
    difficulty_des = 354502,
    difficulty_name = 46257,
    difficulty_name_en = "Risky Dilemma",
    id = 3
  },
  {
    catalog = {
      401,
      402,
      403,
      404,
      405,
      406
    },
    difficulty_name_en = "Nightmare",
    id = 4
  }
}
local __default_values = {
  catalog = {
    101,
    102,
    103,
    104
  },
  difficulty_des = 325096,
  difficulty_name = 16311,
  difficulty_name_en = "Full Experience",
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival_difficulty) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxDiffculty = 4}
setmetatable(activity_carnival_difficulty, {__index = __rawdata})
return activity_carnival_difficulty
