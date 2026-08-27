local __rt_1 = {}
local __rt_2 = {20002, 20003}
local activity_interact_main = {
  [24001] = {side_story = 283974},
  [24002] = {activity_id = 24002, side_story = 283974},
  [24003] = {
    activity_id = 24003,
    addup_final_des = {20011, 20010},
    addup_mode = 392595,
    addup_prefab = "UI_MusicFes23Story",
    des_individual = {20004, 20005},
    heroHeadDic = {
      [1028] = 302805,
      [1039] = 303907,
      [1058] = 305804,
      [1061] = 306104
    },
    interact = "Music_Interactive",
    main_story = 39288,
    name_main_game = 424416,
    suggest_step = 4
  },
  [45001] = {
    activity_id = 45001,
    des_individual = __rt_1,
    interact = "SteinsGate_Interactive",
    main_story = "",
    name_main_game = "",
    suggest_step = 0
  }
}
local __default_values = {
  activity_id = 24001,
  addup_final_des = __rt_1,
  addup_mode = "",
  addup_prefab = "",
  des_individual = __rt_2,
  heroHeadDic = __rt_1,
  interact = "Spring_Interactive",
  main_story = 202194,
  name_main_game = 48640,
  side_story = "",
  suggest_step = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_interact_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_interact_main, {__index = __rawdata})
return activity_interact_main
