local warchess_strategy = {
  {
    {
      expSum = 10,
      id = 1,
      level = 1
    },
    {
      expSum = 30,
      id = 1,
      level = 2
    },
    {
      expSum = 60,
      id = 1,
      level = 3
    },
    {
      expSum = 100,
      id = 1,
      level = 4
    },
    {
      expSum = 150,
      id = 1,
      level = 5
    },
    {
      expSum = 200,
      id = 1,
      level = 6
    },
    {
      expSum = 250,
      id = 1,
      level = 7
    },
    {
      expSum = 300,
      id = 1,
      level = 8
    },
    {
      expSum = 350,
      id = 1,
      level = 9
    },
    {
      expSum = 400,
      id = 1,
      level = 10
    },
    {
      expSum = 450,
      id = 1,
      level = 11
    },
    {
      expSum = 500,
      id = 1,
      level = 12
    },
    {
      expSum = 550,
      id = 1,
      level = 13
    },
    {
      expSum = 600,
      id = 1,
      level = 14
    },
    {
      expSum = 650,
      id = 1,
      level = 15
    },
    {
      expSum = 700,
      id = 1,
      level = 16
    },
    {
      expSum = 750,
      id = 1,
      level = 17
    },
    {
      expSum = 800,
      id = 1,
      level = 18
    },
    {
      expSum = 850,
      id = 1,
      level = 19
    },
    {
      expSum = 900,
      id = 1,
      level = 20
    },
    {
      expSum = 950,
      id = 1,
      level = 21
    },
    {
      expSum = 1000,
      id = 1,
      level = 22
    },
    {
      expSum = 1050,
      id = 1,
      level = 23
    },
    {
      expSum = 1100,
      id = 1,
      level = 24
    },
    {
      expSum = 1150,
      id = 1,
      level = 25
    }
  }
}
local __default_values = {expItemId = 14}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_strategy) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_strategy, {__index = __rawdata})
return warchess_strategy
