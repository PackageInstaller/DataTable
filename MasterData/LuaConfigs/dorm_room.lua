local dorm_room = {
  {
    default_floor = "CommonPrefab/DefaultFloor",
    default_wall = "CommonPrefab/DefaultWall",
    max_hero = 4,
    model_size = 4,
    name = 517748
  },
  {
    edit_cam_distance = {3, 15},
    grid_length = 54,
    id = 2,
    lock_prefab = "CommonPrefab/LockDormRoomBig",
    room_type = 1,
    unlock_fx = "FX/UI_effct/DormitoryEffcet/FXP_Shelter_lock_big_js"
  }
}
local __default_values = {
  default_floor = "CommonPrefab/BigDefaultFloor",
  default_wall = "CommonPrefab/BigDefaultWall",
  edit_cam_distance = {3, 10},
  grid_height = 12,
  grid_length = 18,
  id = 1,
  lock_prefab = "CommonPrefab/LockDormRoom",
  max_hero = 10,
  model_size = 11.2,
  name = 487205,
  room_type = 0,
  unlock_fx = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_room) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_room, {__index = __rawdata})
return dorm_room
