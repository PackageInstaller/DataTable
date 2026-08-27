local __rt_1 = {
  [8130] = 1
}
local __rt_2 = {
  [8131] = 1
}
local __rt_3 = {
  [8147] = 1
}
local __rt_4 = {
  [8133] = 1
}
local __rt_5 = {
  [8134] = 1
}
local __rt_6 = {
  [1028] = 1
}
local __rt_7 = {
  [8135] = 1
}
local activity_white_day_order = {
  [101] = {
    order_exp = 240,
    product = __rt_1,
    time_cost = 86400,
    unlock_level = 3
  },
  [102] = {
    id = 102,
    max_time = 18,
    order_exp = 120,
    product = __rt_2,
    time_cost = 43200,
    unlock_level = 5
  },
  [103] = {
    id = 103,
    max_time = 4,
    order_exp = 240,
    product = __rt_3,
    time_cost = 86400,
    unlock_level = 6
  },
  [104] = {
    id = 104,
    max_time = 8,
    order_exp = 120,
    product = __rt_4,
    time_cost = 43200,
    unlock_level = 2
  },
  [105] = {
    id = 105,
    order_exp = 80,
    product = __rt_5,
    time_cost = 28800
  },
  [106] = {
    id = 106,
    max_time = 15,
    unlock_level = 4
  },
  [107] = {
    id = 107,
    max_time = 999,
    order_exp = 80,
    product = __rt_7,
    time_cost = 28800,
    unlock_level = 8
  },
  [201] = {
    id = 201,
    max_time = 7,
    order_exp = 40,
    product = {
      [8142] = 1
    },
    time_cost = 14400,
    unlock_level = 2
  },
  [202] = {
    id = 202,
    max_time = 8,
    order_exp = 120,
    product = {
      [8141] = 1
    },
    time_cost = 43200,
    unlock_level = 2
  },
  [203] = {
    id = 203,
    max_time = 4,
    product = {
      [8140] = 1
    },
    unlock_level = 7
  },
  [204] = {
    id = 204,
    max_time = 25,
    product = {
      [8139] = 1
    },
    unlock_level = 4
  },
  [205] = {
    id = 205,
    product = {
      [8138] = 1
    },
    unlock_level = 6
  },
  [206] = {
    id = 206,
    max_time = 12,
    unlock_level = 5
  },
  [207] = {
    id = 207,
    max_time = 999,
    product = {
      [8143] = 1
    },
    unlock_level = 7
  },
  [208] = {
    id = 208,
    max_time = 1,
    order_exp = 40,
    product = {
      [8145] = 1
    },
    time_cost = 10
  },
  [301] = {
    id = 301,
    order_exp = 240,
    product = __rt_1,
    unlock_level = 3
  },
  [302] = {
    id = 302,
    max_time = 18,
    order_exp = 120,
    product = __rt_2,
    time_cost = 43200,
    unlock_level = 5
  },
  [303] = {
    id = 303,
    max_time = 4,
    order_exp = 240,
    product = __rt_3,
    unlock_level = 6
  },
  [304] = {
    id = 304,
    max_time = 8,
    order_exp = 120,
    product = __rt_4,
    time_cost = 43200,
    unlock_level = 2
  },
  [305] = {
    id = 305,
    order_exp = 80,
    product = __rt_5,
    time_cost = 28800
  },
  [306] = {
    id = 306,
    max_time = 15,
    product = {
      [1058] = 1
    },
    unlock_level = 4
  },
  [307] = {
    id = 307,
    max_time = 999,
    order_exp = 80,
    product = __rt_7,
    time_cost = 28800,
    unlock_level = 8
  },
  [308] = {
    id = 308,
    max_time = 1,
    order_exp = 40,
    product = {
      [8148] = 1
    },
    time_cost = 10
  }
}
local __default_values = {
  id = 101,
  max_time = 6,
  order_exp = 200,
  product = __rt_6,
  time_cost = 72000,
  unlock_level = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_white_day_order) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_white_day_order, {__index = __rawdata})
return activity_white_day_order
