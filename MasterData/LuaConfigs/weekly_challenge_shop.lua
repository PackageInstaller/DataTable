local weekly_challenge_shop = {
  {function_limit_bonus = 0},
  {
    exp = 1,
    function_drop_ratio = {
      950,
      50,
      0
    },
    level = 2
  },
  {
    exp = 2,
    function_drop_ratio = {
      900,
      100,
      0
    },
    level = 3
  },
  {
    exp = 4,
    function_drop_ratio = {
      850,
      150,
      0
    },
    level = 4
  },
  {
    exp = 8,
    function_drop_ratio = {
      800,
      200,
      0
    },
    level = 5
  },
  {
    exp = 16,
    function_drop_ratio = {
      700,
      250,
      50
    },
    level = 6
  },
  {
    exp = 32,
    function_drop_ratio = {
      600,
      300,
      100
    },
    level = 7
  },
  {
    exp = 56,
    function_drop_ratio = {
      500,
      350,
      150
    },
    level = 8
  },
  {
    exp = 88,
    function_drop_ratio = {
      400,
      400,
      200
    },
    level = 9
  },
  {
    exp = 128,
    function_drop_ratio = {
      300,
      400,
      300
    },
    level = 10
  }
}
local __default_values = {
  exp = 0,
  function_drop_ratio = {
    1000,
    0,
    0
  },
  function_limit_bonus = 1,
  level = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(weekly_challenge_shop) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxLevel = 10}
setmetatable(weekly_challenge_shop, {__index = __rawdata})
return weekly_challenge_shop
