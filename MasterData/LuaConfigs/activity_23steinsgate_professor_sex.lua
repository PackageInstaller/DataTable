local activity_23steinsgate_professor_sex = {
  [2] = {lobby_index = 2, parent_obj = "STAGE_2"},
  [3] = {
    id = 2,
    lobby_index = 3,
    parent_obj = "STAGE_2"
  },
  [5] = {
    female_obj = "2023STEINS_professor_1_g",
    id = 3,
    lobby_index = 5,
    obj_id = 10,
    parent_obj = "STAGE_5"
  },
  [6] = {
    id = 4,
    lobby_index = 6,
    parent_obj = "STAGE_2"
  },
  [11] = {id = 5, obj_id = 9},
  [12] = {
    id = 6,
    lobby_index = 12,
    obj_id = 9
  },
  [13] = {
    id = 7,
    lobby_index = 13,
    obj_id = 9
  },
  [14] = {
    id = 8,
    lobby_index = 14,
    obj_id = 10
  },
  [15] = {
    female_obj = "2023STEINS_professor_1_g",
    id = 9,
    lobby_index = 15,
    obj_id = 11,
    parent_obj = "STAGE_4"
  },
  [16] = {
    female_obj = "2023STEINS_professor_1_g",
    id = 10,
    lobby_index = 16,
    obj_id = 11,
    parent_obj = "STAGE_4"
  },
  [18] = {
    id = 11,
    lobby_index = 18,
    parent_obj = ""
  },
  [19] = {
    id = 12,
    lobby_index = 19,
    obj_id = 12,
    parent_obj = ""
  },
  [21] = {
    id = 13,
    lobby_index = 21,
    obj_id = 10
  },
  [22] = {id = 14, lobby_index = 22},
  [23] = {
    female_obj = "2023STEINS_professor_1_g",
    id = 15,
    lobby_index = 23,
    obj_id = 10,
    parent_obj = "STAGE_3"
  },
  [27] = {
    id = 16,
    lobby_index = 27,
    obj_id = 10,
    parent_obj = "STAGE_2"
  },
  [30] = {
    female_obj = "2023STEINS_professor_1_g",
    id = 17,
    lobby_index = 30,
    parent_obj = "STAGE_3"
  }
}
local __default_values = {
  female_obj = "2023STEINS_professor_g",
  id = 1,
  lobby_index = 11,
  obj_id = 8,
  parent_obj = "STAGE_1"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_professor_sex) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_professor_sex, {__index = __rawdata})
return activity_23steinsgate_professor_sex
