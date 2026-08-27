local monster_level = {
  {levelexp = 4},
  {
    exp = 4,
    hp_amplify = 180,
    level = 2,
    levelexp = 4,
    pow_amplify = 160,
    skill_amplify = 160
  },
  {
    exp = 8,
    hp_amplify = 480,
    level = 3,
    pow_amplify = 360,
    skill_amplify = 360
  },
  {
    exp = 13,
    hp_amplify = 960,
    level = 4,
    pow_amplify = 840,
    skill_amplify = 840
  },
  {
    exp = 18,
    hp_amplify = 1320,
    level = 5,
    pow_amplify = 1180,
    skill_amplify = 1180
  },
  {
    exp = 23,
    hp_amplify = 1960,
    level = 6,
    pow_amplify = 1590,
    skill_amplify = 1590
  },
  {
    exp = 28,
    hp_amplify = 2940,
    level = 7,
    pow_amplify = 2380,
    skill_amplify = 2380
  },
  {
    exp = 33,
    hp_amplify = 3960,
    level = 8,
    pow_amplify = 3200,
    skill_amplify = 3200
  },
  {
    exp = 38,
    hp_amplify = 4380,
    level = 9,
    pow_amplify = 3540,
    skill_amplify = 3540
  },
  {
    exp = 43,
    hp_amplify = 4800,
    level = 10,
    levelexp = 0,
    pow_amplify = 3880,
    skill_amplify = 3880
  }
}
local __default_values = {
  exp = 0,
  hp_amplify = 0,
  level = 1,
  levelexp = 5,
  pow_amplify = 0,
  skill_amplify = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(monster_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxLevel = 10}
setmetatable(monster_level, {__index = __rawdata})
return monster_level
