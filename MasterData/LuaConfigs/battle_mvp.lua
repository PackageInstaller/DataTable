local __rt_1 = {
  -0.2,
  1.2,
  -0.03
}
local __rt_2 = {
  -0.4,
  1.2,
  -0.03
}
local __rt_3 = {
  0.5,
  2,
  0.7
}
local __rt_4 = {
  0.5,
  1.2,
  0.5
}
local battle_mvp = {
  [300703] = {camera_offset_vector3 = __rt_1},
  [301003] = {camera_offset_vector3 = __rt_2, id = 301003},
  [301204] = {
    camera_offset_vector3 = {
      0.2,
      1.4,
      -0.03
    },
    id = 301204
  },
  [301604] = {
    camera_offset_vector3 = {
      0.55,
      1.3,
      0.4
    },
    id = 301604
  },
  [301803] = {camera_offset_vector3 = __rt_2, id = 301803},
  [302404] = {
    camera_offset_vector3 = {
      0.2,
      1.3,
      0.75
    },
    id = 302404
  },
  [303205] = {
    camera_offset_vector3 = {
      0.55,
      1.3,
      0.5
    },
    id = 303205
  },
  [304804] = {
    camera_offset_vector3 = {
      0.4,
      1.5,
      0.27
    },
    id = 304804
  },
  [305005] = {
    camera_offset_vector3 = {
      0.3,
      1.2,
      0.7
    },
    id = 305005
  },
  [307200] = {camera_offset_vector3 = __rt_3, id = 307200},
  [307201] = {camera_offset_vector3 = __rt_3, id = 307201},
  [307202] = {camera_offset_vector3 = __rt_3, id = 307202},
  [307203] = {
    camera_offset_vector3 = {
      0.3,
      1.2,
      -0.03
    },
    id = 307203
  },
  [307204] = {
    camera_offset_vector3 = {
      0.15,
      1.2,
      0.03
    },
    id = 307204
  },
  [307403] = {
    camera_offset_vector3 = {
      0.4,
      1.4,
      0.4
    },
    id = 307403
  },
  [308000] = {id = 308000},
  [308001] = {id = 308001},
  [308002] = {id = 308002},
  [308003] = {camera_offset_vector3 = __rt_1, id = 308003}
}
local __default_values = {camera_offset_vector3 = __rt_4, id = 300703}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(battle_mvp) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(battle_mvp, {__index = __rawdata})
return battle_mvp
