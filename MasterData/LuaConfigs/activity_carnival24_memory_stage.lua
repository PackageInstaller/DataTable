local activity_carnival24_memory_stage = {
  [1001] = {
    handbook_des = 440768,
    handbook_title = 245346,
    name = 417669,
    next_need = {}
  },
  [1002] = {
    handbook_des = 271127,
    handbook_title = 406380,
    lobby_id = 2,
    name = 273715,
    stage_id = 1002
  },
  [1003] = {
    handbook_des = 341881,
    handbook_title = 65271,
    lobby_id = 3,
    name = 152332,
    next_need = {
      [1002] = 2
    },
    stage_id = 1003
  },
  [1004] = {
    handbook_des = 2524,
    handbook_title = 278747,
    lobby_id = 4,
    name = 497240,
    next_need = {
      [1003] = 2
    },
    stage_id = 1004
  },
  [1005] = {
    handbook_des = 83933,
    handbook_title = 421076,
    lobby_id = 5,
    name = 329131,
    next_need = {
      [1004] = 2
    },
    stage_id = 1005
  },
  [1006] = {
    handbook_des = 241077,
    handbook_title = 224715,
    lobby_id = 6,
    next_need = {
      [1005] = 2
    },
    stage_id = 1006
  },
  [1007] = {
    handbook_des = 326134,
    lobby_id = 7,
    name = 503986,
    next_need = {
      [1006] = 2
    },
    stage_id = 1007
  },
  [1008] = {
    handbook_title = 89969,
    lobby_id = 8,
    name = 222346,
    next_need = {
      [1007] = 2
    },
    stage_id = 1008
  },
  [1009] = {
    handbook_des = 451176,
    handbook_title = 302578,
    lobby_id = 9,
    name = 308405,
    next_need = {
      [1008] = 2
    },
    stage_id = 1009
  }
}
local __default_values = {
  fragmentBG = "",
  handbook_des = 222856,
  handbook_title = 185321,
  lobby_id = 1,
  name = 105128,
  next_need = {
    [1001] = 1
  },
  stage_id = 1001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival24_memory_stage) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival24_memory_stage, {__index = __rawdata})
return activity_carnival24_memory_stage
