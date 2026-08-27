local activity_card_rank_round = {
  {
    {
      id = 1,
      rank_check_value = 61250,
      round_des = ""
    }
  },
  {
    {rank_check_value = 10000, round_des = 381308},
    {
      rank_check_value = 10000,
      round_des = 304136,
      round_id = 2
    }
  },
  {
    {id = 3, round_des = 436762},
    {
      id = 3,
      round_des = 199165,
      round_id = 2
    }
  },
  {
    {id = 4},
    {
      id = 4,
      round_des = 457492,
      round_id = 2
    }
  },
  {
    {id = 5},
    {
      id = 5,
      round_des = 457492,
      round_id = 2
    }
  }
}
local __default_values = {
  id = 2,
  rank_check_value = 12000,
  round_des = 199236,
  round_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_rank_round) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_card_rank_round, {__index = __rawdata})
return activity_card_rank_round
