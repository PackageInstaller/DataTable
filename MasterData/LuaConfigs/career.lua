local career = {
  {
    algorithm_suit_recommend = 2,
    click_audio = 4101,
    name = 66324
  },
  {
    click_audio = 4102,
    icon = "career_2",
    id = 2,
    name = 359819
  },
  {
    click_audio = 4103,
    icon = "career_3",
    id = 3,
    name = 326679
  },
  {
    algorithm_suit_recommend = 3,
    click_audio = 4104,
    icon = "career_4",
    id = 4,
    name = 83178
  },
  {
    algorithm_suit_recommend = 3,
    click_audio = 4105,
    icon = "career_5",
    id = 5,
    name = 388173
  },
  {
    algorithm_suit_recommend = 0,
    icon = "career_all",
    id = 6
  }
}
local __default_values = {
  algorithm_suit_recommend = 1,
  click_audio = 0,
  icon = "career_1",
  id = 1,
  name = 140754
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(career) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(career, {__index = __rawdata})
return career
