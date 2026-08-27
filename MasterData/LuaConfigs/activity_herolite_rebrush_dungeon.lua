local __rt_1 = {min = 1500}
local activity_herolite_rebrush_dungeon = {
  {
    background_pic = "UI_ShaleSectorEntranceBG",
    buff_task = 5800
  },
  {
    assistance_id = 123,
    buff_task = 5816,
    drop_show = {
      [1304] = __rt_1
    },
    dungeon_id = 44041,
    id = 2
  },
  {
    assistance_id = 134,
    background_pic = "UI_LewisSectorEntranceBG",
    buff_task = 5832,
    drop_show = {
      [1305] = __rt_1
    },
    dungeon_id = 45041,
    id = 3
  },
  {
    assistance_id = 144,
    background_pic = "UI_OliviaSectorEntranceBG",
    buff_task = 5848,
    drop_show = {
      [1306] = __rt_1
    },
    dungeon_id = 46041,
    id = 4
  },
  {
    assistance_id = 147,
    background_pic = "UI_InolaSectorEntranceBG",
    drop_show = {
      [1307] = __rt_1
    },
    dungeon_id = 47041,
    id = 5
  },
  {
    assistance_id = 149,
    background_pic = "UI_EniacSectorEntranceBG",
    drop_show = {
      [1308] = __rt_1
    },
    dungeon_id = 48041,
    id = 6
  }
}
local __default_values = {
  assistance_id = 103,
  background_pic = "UI_BelladonnaSectorEntranceBG",
  buff_name = 87169,
  buff_task = 5864,
  drop_show = {
    [1303] = __rt_1
  },
  dungeon_des = 457328,
  dungeon_icon = "UI_DunIcon1",
  dungeon_id = 43041,
  dungeon_pic = "small_4",
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_herolite_rebrush_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_herolite_rebrush_dungeon, {__index = __rawdata})
return activity_herolite_rebrush_dungeon
