local __rt_1 = {3}
local __rt_2 = {}
local __rt_3 = {1, 2}
local __rt_4 = {3112}
local weekly_challenge = {
  [1501] = {
    base_reward = {1},
    hero_star_max = 6,
    hero_star_min = 4,
    pre_para1 = {3102},
    score_ratio = 0,
    short_intro = 279246
  },
  [1502] = {
    challenge_id = 102,
    have_rank = 1,
    hero_level_max = 45,
    hero_level_min = 35,
    hero_rank_max = 4,
    hero_rank_min = 3,
    hero_skill_level_max = 5,
    hero_star_max = 8,
    id = 1502,
    introduce = 457183,
    name = 47575,
    short_intro = 91717,
    weekly_challenge_type = 2
  },
  [1503] = {
    challenge_id = 103,
    have_rank = 2,
    hero_level_max = 60,
    hero_level_min = 40,
    hero_rank_max = 5,
    hero_rank_min = 4,
    hero_skill_level_max = 10,
    id = 1503,
    introduce = 170903,
    name = 95380,
    weekly_challenge_type = 3
  }
}
local __default_values = {
  base_reward = __rt_3,
  challenge_id = 101,
  have_rank = 0,
  hero_level_max = 35,
  hero_level_min = 25,
  hero_rank_max = 3,
  hero_rank_min = 2,
  hero_skill_level_max = 1,
  hero_skill_level_min = 1,
  hero_star_max = 10,
  hero_star_min = 6,
  id = 1501,
  introduce = 131696,
  name = 151744,
  pic_small = "small_1",
  pre_condition = __rt_1,
  pre_para1 = __rt_4,
  pre_para2 = __rt_2,
  score_ratio = 500,
  short_intro = 187190,
  weekly_challenge_type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(weekly_challenge) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge, {__index = __rawdata})
return weekly_challenge
