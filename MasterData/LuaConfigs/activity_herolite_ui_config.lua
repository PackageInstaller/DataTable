local activity_herolite_ui_config = {
  {
    main_color = {
      255,
      181,
      28
    },
    reward_skin_pos = {98, -294},
    reward_skin_scale = {
      3.48,
      3.48,
      3.48
    },
    story_review_bg = "shale_p3"
  },
  {
    home_background_point = {0.45, 0.42},
    home_background_skin = 308502,
    home_skin = 308501,
    id = 2,
    quest_skin = 308500,
    reward_skin = 308502,
    reward_skin_pos = {-7, 120},
    reward_skin_scale = {
      1855,
      1855,
      1855
    }
  },
  {
    home_background_point = {0.26, 0.39},
    home_background_skin = 308602,
    home_skin = 308601,
    id = 3,
    main_color = {
      159,
      16,
      50
    },
    quest_skin = 308600,
    reward_skin = 308602,
    reward_skin_pos = {-40, 96},
    reward_skin_scale = {
      2208,
      2208,
      2208
    },
    story_review_bg = "lewis_p3"
  },
  {
    home_background_point = {0.32, 0.556},
    home_background_skin = 308702,
    home_skin = 308701,
    id = 4,
    main_color = {
      223,
      196,
      136
    },
    quest_skin = 308700,
    reward_skin = 308702,
    reward_skin_scale = {
      1925,
      1925,
      1925
    },
    story_review_bg = "olivia_p3"
  },
  {
    home_background_point = {0.5, 0.64},
    home_background_skin = 309202,
    home_skin = 309201,
    id = 5,
    main_color = {
      140,
      105,
      221
    },
    quest_skin = 309200,
    reward_skin = 309202,
    reward_skin_pos = {206, 120},
    story_review_bg = "inola_p3"
  },
  {
    home_background_point = {0.25, 0.54},
    home_background_skin = 309302,
    home_skin = 309301,
    id = 6,
    main_color = {
      82,
      151,
      246
    },
    quest_skin = 309300,
    reward_skin = 309302,
    reward_skin_pos = {246, 111},
    reward_skin_scale = {
      1955,
      1955,
      1955
    },
    story_review_bg = "eniac_p3"
  }
}
local __default_values = {
  challenge_icon = "UI_Icon2",
  challenge_name = 258541,
  home_background_point = {0.22, 0.5378},
  home_background_skin = 308302,
  home_skin = 308301,
  id = 1,
  main_color = {
    115,
    90,
    229
  },
  normal_icon = "UI_Icon1",
  normal_name = 272326,
  quest_skin = 308300,
  quest_skin_type = 1,
  rebrush_icon = "UI_Icon3",
  rebrush_name = 32994,
  reward_skin = 308302,
  reward_skin_pos = {-40, 159},
  reward_skin_scale = {
    1515,
    1515,
    1515
  },
  reward_skin_type = 1,
  skin_type = 2,
  story_review_bg = "belladonna_p3"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_herolite_ui_config) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_herolite_ui_config, {__index = __rawdata})
return activity_herolite_ui_config
