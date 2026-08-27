local activity_bond_dunlist = {
  [65001] = {dungeon_des = 39881},
  [65002] = {
    dungeon_des = 143196,
    dungeon_id = 65002,
    is_infinite = 1
  },
  [65003] = {dungeon_des = 385182, dungeon_id = 65003},
  [65004] = {
    dungeon_des = 140753,
    dungeon_id = 65004,
    is_infinite = 1
  },
  [65005] = {dungeon_des = 142482, dungeon_id = 65005},
  [65006] = {
    dungeon_des = 339013,
    dungeon_id = 65006,
    is_infinite = 1
  },
  [65007] = {dungeon_des = 479072, dungeon_id = 65007},
  [65008] = {dungeon_id = 65008, is_infinite = 1},
  [65009] = {dungeon_des = 452800, dungeon_id = 65009},
  [65010] = {
    dungeon_des = 395315,
    dungeon_id = 65010,
    is_infinite = 1
  },
  [65011] = {dungeon_des = 164598, dungeon_id = 65011},
  [65012] = {
    dungeon_des = 351017,
    dungeon_id = 65012,
    is_infinite = 1
  },
  [65013] = {dungeon_des = 372466, dungeon_id = 65013},
  [65014] = {
    dungeon_des = 334501,
    dungeon_id = 65014,
    is_infinite = 1
  }
}
local __default_values = {
  dungeon_des = 139987,
  dungeon_id = 65001,
  dungeon_pic = "small_4",
  is_infinite = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_bond_dunlist) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_bond_dunlist, {__index = __rawdata})
return activity_bond_dunlist
