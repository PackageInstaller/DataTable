local overload = {
  {
    dps_up = 5,
    heal_down = 25,
    pop_up = true
  },
  {heal_down = 25, time = 2},
  {
    dps_up = 15,
    heal_down = 25,
    time = 3
  },
  {
    dps_up = 20,
    heal_down = 25,
    time = 4
  },
  {
    dps_up = 25,
    heal_down = 25,
    time = 5
  },
  {
    dps_up = 30,
    heal_down = 50,
    time = 6
  },
  {
    dps_up = 35,
    heal_down = 50,
    time = 7
  },
  {
    dps_up = 40,
    heal_down = 50,
    time = 8
  },
  {
    dps_up = 45,
    heal_down = 50,
    time = 9
  },
  {
    dps_up = 50,
    heal_down = 50,
    pop_up = true,
    time = 10
  },
  {
    dps_up = 55,
    heal_down = 75,
    time = 11
  },
  {
    dps_up = 60,
    heal_down = 75,
    time = 12
  },
  {
    dps_up = 65,
    heal_down = 75,
    time = 13
  },
  {
    dps_up = 70,
    heal_down = 75,
    time = 14
  },
  {
    dps_up = 75,
    heal_down = 75,
    time = 15
  },
  {dps_up = 80, time = 16},
  {dps_up = 85, time = 17},
  {dps_up = 90, time = 18},
  {dps_up = 95, time = 19},
  {
    dps_up = 100,
    pop_up = true,
    time = 20
  }
}
local __default_values = {
  dps_up = 10,
  heal_down = 100,
  pop_up = false,
  time = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(overload) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(overload, {__index = __rawdata})
return overload
