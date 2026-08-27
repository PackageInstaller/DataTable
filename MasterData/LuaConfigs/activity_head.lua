local __rt_1 = {
  74,
  110,
  230
}
local __rt_2 = {
  109,
  143,
  81
}
local __rt_3 = {
  71,
  46,
  165
}
local __rt_4 = {
  46,
  67,
  255
}
local __rt_5 = {
  187,
  8,
  0
}
local activity_head = {
  [24003] = {head_bar_color = __rt_1},
  [25001] = {
    activity_id = 25001,
    head_pic_path = "Winter23/UI_Winter23CommonTopBG"
  },
  [25003] = {
    activity_id = 25003,
    head_pic_path = "Winter23/UI_Winter23CommonTopBG"
  },
  [31001] = {
    activity_id = 31001,
    head_bar_color = {
      255,
      165,
      0
    },
    head_pic_path = "UI_Season23AprilCommonTopBG"
  },
  [33001] = {
    activity_id = 33001,
    head_bar_color = __rt_3,
    head_pic_path = "UI_Carnival23CommonTopBG"
  },
  [33002] = {
    activity_id = 33002,
    head_bar_color = __rt_3,
    head_pic_path = "UI_Carnival23CommonTopBG"
  },
  [33003] = {
    activity_id = 33003,
    head_bar_color = __rt_4,
    head_pic_path = "Summer23/UI_Summer23CommonTopBG"
  },
  [33004] = {
    activity_id = 33004,
    head_bar_color = __rt_4,
    head_pic_path = "Summer23/UI_Summer23CommonTopBG"
  },
  [33005] = {
    activity_id = 33005,
    head_bar_color = {
      89,
      67,
      223
    },
    head_pic_path = "Summer24/UI_Summer24CommonTopBG"
  },
  [40001] = {
    activity_id = 40001,
    head_bar_color = {
      204,
      69,
      101
    },
    head_pic_path = "Anniversary23/UI_Anniversary23CommonTopBG"
  },
  [40002] = {
    activity_id = 40002,
    head_bar_color = __rt_5,
    head_pic_path = "Winter24/UI_Winter24CommonTopBG"
  },
  [45001] = {activity_id = 45001, head_bar_color = __rt_1},
  [51001] = {
    activity_id = 51001,
    head_bar_color = __rt_5,
    head_pic_path = "Spring24/UI_Spring24CommonTopBG"
  },
  [56001] = {
    activity_id = 56001,
    head_bar_color = {
      67,
      67,
      162
    },
    head_pic_path = "Carnival24/UI_Carnival24CommonTopBG"
  },
  [58001] = {
    activity_id = 58001,
    head_bar_color = {
      72,
      187,
      216
    },
    head_pic_path = "Delivery/UI_DeliveryCommonTopBG"
  },
  [59001] = {
    activity_id = 59001,
    head_bar_color = {
      190,
      66,
      201
    },
    head_pic_path = "Anniversary24/UI_Anniversary24CommonTopBG"
  }
}
local __default_values = {
  activity_id = 24003,
  head_bar_color = __rt_2,
  head_pic_path = "MusicFes23/UI_MusicFes23CommonTopBG"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_head) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_head, {__index = __rawdata})
return activity_head
