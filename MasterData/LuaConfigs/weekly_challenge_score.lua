local __rt_1 = {1}
local __rt_2 = {1, 2}
local __rt_3 = {2}
local weekly_challenge_score = {
  {
    intro = 251215,
    title = 464870,
    type = __rt_1,
    unit_score = 10
  },
  {
    id = 2,
    intro = 335844,
    title = 93063,
    type = __rt_1,
    unit_score = 25
  },
  {
    id = 3,
    intro = 368880,
    unit_score = 50
  },
  {
    id = 4,
    title = 3606,
    unit_score = 5
  },
  {
    id = 5,
    intro = 433685,
    title = 334878,
    unit_score = 15
  },
  {
    id = 6,
    intro = 112001,
    title = 13194,
    unit_score = 30
  },
  [8] = {
    const_show = false,
    id = 8,
    intro = 408238,
    title = 176355,
    unit_score = 200
  },
  [18] = {
    check_type = 4,
    check_value = 100,
    const_show = false,
    id = 18,
    intro = 491103,
    title = 164948
  },
  [19] = {
    check_type = 4,
    check_value = 15,
    const_show = false,
    id = 19,
    intro = 197904,
    title = 62605,
    type = __rt_1
  },
  [20] = {
    id = 20,
    intro = 62978,
    title = 374864,
    type = __rt_3,
    unit_score = 5
  },
  [21] = {
    check_type = 4,
    check_value = 10,
    const_show = false,
    id = 21,
    intro = 73109,
    title = 41777,
    type = __rt_3,
    unit_score = 40
  },
  [22] = {
    check_value = 1,
    const_show = false,
    id = 22,
    intro = 203227,
    title = 260866,
    type = __rt_3,
    unit_score = 40
  }
}
local __default_values = {
  check_type = 1,
  check_value = 0,
  const_show = true,
  id = 1,
  intro = 102413,
  max_score = 9000,
  title = 116345,
  type = __rt_2,
  unit_score = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(weekly_challenge_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge_score, {__index = __rawdata})
return weekly_challenge_score
