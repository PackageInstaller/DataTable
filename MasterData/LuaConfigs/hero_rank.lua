local __rt_1 = {1006}
local __rt_2 = {5}
local __rt_3 = {60}
local __rt_4 = {300}
local hero_rank = {
  {
    rare = 1,
    repeat_extra_trans_num = __rt_2,
    repeat_frag_trans = 1
  },
  {
    rank = 2,
    rare = 1,
    repeat_extra_trans_num = __rt_2,
    repeat_frag_trans = 1,
    star = 2,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 1000}
    },
    upgrade_star_frag_cost = 5
  },
  {
    rank = 3,
    rare = 1,
    repeat_extra_trans_num = __rt_3,
    repeat_frag_trans = 5,
    star = 3,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 2000}
    },
    upgrade_star_frag_cost = 10
  },
  {
    rank = 4,
    rare = 2,
    repeat_extra_trans_num = __rt_3,
    repeat_frag_trans = 5,
    star = 4,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 3000}
    },
    upgrade_star_frag_cost = 25
  },
  {
    rank = 5,
    rare = 2,
    star = 5,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 4000}
    },
    upgrade_star_frag_cost = 40
  },
  {
    rank = 6,
    star = 6,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 5000}
    },
    upgrade_star_frag_cost = 60
  },
  {
    rank = 7,
    star = 7,
    ultimateskill_level = 2,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 7500}
    },
    upgrade_star_frag_cost = 70
  },
  {
    rank = 8,
    star = 8,
    ultimateskill_level = 3,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 10000}
    },
    upgrade_star_frag_cost = 90
  },
  {
    rank = 9,
    star = 9,
    ultimateskill_level = 4,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 20000}
    },
    upgrade_star_frag_cost = 100
  },
  {
    rank = 10,
    star = 10,
    ultimateskill_level = 5,
    upgrade_star_extra_cost = {
      {itemId = 1003, num = 25000}
    }
  }
}
local __default_values = {
  rank = 1,
  rare = 3,
  repeat_extra_trans_id = __rt_1,
  repeat_extra_trans_num = __rt_4,
  repeat_frag_trans = 50,
  skill_level_max = 10,
  star = 1,
  ultimateskill_level = 1,
  upgrade_star_extra_cost = {
    {itemId = 1003, num = 0}
  },
  upgrade_star_frag_cost = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_rank) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  maxRank = 10,
  maxRare = 3,
  maxSkillLevel = 10,
  maxStar = 10
}
setmetatable(hero_rank, {__index = __rawdata})
return hero_rank
