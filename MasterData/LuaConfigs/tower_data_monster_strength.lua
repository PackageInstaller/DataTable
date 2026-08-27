local tower_data_monster_strength = {
  [400] = {
    {
      exp = 0,
      hp_amplify = 0,
      level = 1,
      levelexp = 1,
      pow_amplify = 0,
      skill_amplify = 0,
      system_id = 400
    },
    {
      exp = 1,
      hp_amplify = 30,
      level = 2,
      levelexp = 1,
      pow_amplify = 30,
      skill_amplify = 30,
      system_id = 400
    },
    {
      exp = 2,
      hp_amplify = 80,
      level = 3,
      levelexp = 1,
      pow_amplify = 80,
      skill_amplify = 80,
      system_id = 400
    },
    {
      exp = 3,
      hp_amplify = 160,
      level = 4,
      levelexp = 1,
      pow_amplify = 160,
      skill_amplify = 160,
      system_id = 400
    },
    {
      exp = 4,
      hp_amplify = 220,
      level = 5,
      levelexp = 1,
      pow_amplify = 220,
      skill_amplify = 220,
      system_id = 400
    },
    {
      exp = 5,
      hp_amplify = 330,
      level = 6,
      levelexp = 1,
      pow_amplify = 330,
      skill_amplify = 330,
      system_id = 400
    },
    {
      exp = 6,
      hp_amplify = 490,
      level = 7,
      levelexp = 1,
      pow_amplify = 490,
      skill_amplify = 490,
      system_id = 400
    },
    {
      exp = 7,
      hp_amplify = 660,
      level = 8,
      levelexp = 1,
      pow_amplify = 660,
      skill_amplify = 660,
      system_id = 400
    },
    {
      exp = 8,
      hp_amplify = 730,
      level = 9,
      levelexp = 1,
      pow_amplify = 730,
      skill_amplify = 730,
      system_id = 400
    },
    {
      exp = 9,
      hp_amplify = 800,
      level = 10,
      pow_amplify = 800,
      skill_amplify = 800,
      system_id = 400
    }
  },
  [2201] = {
    {
      exp = 0,
      hp_amplify = 0,
      level = 1,
      levelexp = 1,
      pow_amplify = 0,
      skill_amplify = 0,
      system_id = 2201
    },
    {
      exp = 1,
      hp_amplify = 30,
      level = 2,
      levelexp = 1,
      pow_amplify = 30,
      skill_amplify = 30,
      system_id = 2201
    },
    {
      exp = 2,
      hp_amplify = 80,
      level = 3,
      levelexp = 1,
      pow_amplify = 80,
      skill_amplify = 80,
      system_id = 2201
    },
    {
      exp = 3,
      hp_amplify = 160,
      level = 4,
      levelexp = 1,
      pow_amplify = 160,
      skill_amplify = 160,
      system_id = 2201
    },
    {
      exp = 4,
      hp_amplify = 220,
      level = 5,
      levelexp = 1,
      pow_amplify = 220,
      skill_amplify = 220,
      system_id = 2201
    },
    {
      exp = 5,
      hp_amplify = 330,
      level = 6,
      levelexp = 1,
      pow_amplify = 330,
      skill_amplify = 330,
      system_id = 2201
    },
    {
      exp = 6,
      hp_amplify = 490,
      level = 7,
      levelexp = 1,
      pow_amplify = 490,
      skill_amplify = 490,
      system_id = 2201
    },
    {
      exp = 7,
      hp_amplify = 660,
      level = 8,
      levelexp = 1,
      pow_amplify = 660,
      skill_amplify = 660,
      system_id = 2201
    },
    {
      exp = 8,
      hp_amplify = 730,
      level = 9,
      levelexp = 1,
      pow_amplify = 730,
      skill_amplify = 730,
      system_id = 2201
    },
    {
      exp = 9,
      hp_amplify = 800,
      level = 10,
      pow_amplify = 800,
      skill_amplify = 800,
      system_id = 2201
    }
  }
}
local __default_values = {maxLevel = 10}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tower_data_monster_strength) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tower_data_monster_strength, {__index = __rawdata})
return tower_data_monster_strength
