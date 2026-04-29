local key = {
  ID = 1,
  Tag = 2,
  Icon = 3,
  Desc = 4,
  LockCondition = 5,
  FlagItem = 6,
  LockHide = 7
}
local config = {
  [1000] = {
    1000,
    1,
    "head_deco_1000",
    "str_role_head_image_desc_frame_1000"
  },
  [2001] = {
    2001,
    1,
    "head_deco_1003",
    "str_role_head_image_desc_frame_2001",
    {2001}
  },
  [2002] = {
    2002,
    1,
    "head_deco_2002",
    "str_role_head_image_desc_frame_2002",
    {2002},
    nil,
    1
  },
  [3001] = {
    3001,
    1,
    "head_deco_3001",
    "str_role_head_image_desc_frame_3001",
    {3001}
  },
  [3002] = {
    3002,
    1,
    "head_deco_3002",
    "str_role_head_image_desc_frame_3002",
    {3002}
  },
  [3003] = {
    3003,
    1,
    "head_deco_3003",
    "str_role_head_image_desc_frame_3003",
    {3003}
  },
  [3004] = {
    3004,
    1,
    "head_deco_3004",
    "str_role_head_image_desc_frame_3004",
    {3004}
  },
  [3005] = {
    3005,
    1,
    "head_deco_3005",
    "str_role_head_image_desc_frame_3005",
    {3005}
  },
  [3006] = {
    3006,
    1,
    "head_deco_3006",
    "str_role_head_image_desc_frame_3006",
    {3006},
    nil,
    1
  },
  [3007] = {
    3007,
    1,
    "head_deco_3007",
    "str_role_head_image_desc_frame_3007",
    {3007}
  },
  [3008] = {
    3008,
    1,
    "head_deco_3008",
    "str_role_head_image_desc_frame_3008",
    {3008},
    nil,
    1
  },
  [3010] = {
    3010,
    1,
    "head_deco_3010",
    "str_role_head_image_desc_frame_3010",
    {3010}
  },
  [3011] = {
    3011,
    1,
    "head_deco_3011",
    "str_role_head_image_desc_frame_3011",
    {3011}
  },
  [3012] = {
    3012,
    1,
    "head_deco_3012",
    "str_role_head_image_desc_frame_3012",
    {3012},
    nil,
    1
  },
  [3013] = {
    3013,
    1,
    "head_deco_3013",
    "str_role_head_image_desc_frame_3013",
    {3013},
    nil,
    1
  },
  [3014] = {
    3014,
    1,
    "head_deco_3014",
    "str_role_head_image_desc_frame_3014",
    {3014}
  },
  [3015] = {
    3015,
    1,
    "head_deco_3015",
    "str_role_head_image_desc_frame_3015",
    {3015},
    nil,
    1
  },
  [3018] = {
    3018,
    1,
    "head_deco_3018",
    "str_role_head_image_desc_frame_3018",
    {3018},
    nil,
    1
  },
  [3019] = {
    3019,
    1,
    "head_deco_3019",
    "str_role_head_image_desc_frame_3019",
    {3019}
  },
  [3020] = {
    3020,
    1,
    "head_deco_3020",
    "str_role_head_image_desc_frame_3020",
    {3020},
    nil,
    1
  },
  [3021] = {
    3021,
    1,
    "head_deco_3030",
    "str_role_head_image_desc_frame_3021",
    {3021}
  },
  [3022] = {
    3022,
    1,
    "head_deco_3040",
    "str_role_head_image_desc_frame_3022",
    {3022}
  },
  [3023] = {
    3023,
    1,
    "head_deco_3031",
    "str_role_head_image_desc_frame_3023",
    {3023}
  },
  [3024] = {
    3024,
    1,
    "head_deco_3032",
    "str_role_head_image_desc_frame_3024",
    {3024}
  },
  [3025] = {
    3025,
    1,
    "head_deco_3033",
    "str_role_head_image_desc_frame_3025",
    {3025}
  },
  [3026] = {
    3026,
    1,
    "head_deco_3034",
    "str_role_head_image_desc_frame_3026",
    {3026}
  },
  [3027] = {
    3027,
    1,
    "head_deco_3035",
    "str_role_head_image_desc_frame_3027",
    {3027}
  },
  [3028] = {
    3028,
    1,
    "head_deco_3036",
    "str_role_head_image_desc_frame_3028",
    {3028}
  },
  [3029] = {
    3029,
    1,
    "head_deco_3037",
    "str_role_head_image_desc_frame_3029",
    {3029}
  },
  [3030] = {
    3030,
    1,
    "head_deco_3038",
    "str_role_head_image_desc_frame_3763029",
    {3030}
  },
  [3031] = {
    3031,
    1,
    "head_deco_3039",
    "str_role_head_image_desc_frame_3031",
    {3031}
  },
  [3041] = {
    3041,
    1,
    "head_deco_3041",
    "str_role_head_image_desc_frame_3041",
    {3041}
  },
  [3042] = {
    3042,
    1,
    "head_deco_3042",
    "str_role_head_image_desc_frame_3042",
    {3042}
  },
  [3043] = {
    3043,
    1,
    "head_deco_3043",
    "str_role_head_image_desc_frame_3043",
    {3043}
  },
  [3755025] = {
    3755025,
    1,
    "head_baihua_cn3",
    "str_role_head_image_desc_frame_3755025",
    {4001}
  },
  [3044] = {
    3044,
    1,
    "head_deco_3044",
    "str_role_head_image_desc_frame_3044",
    {3044}
  },
  [3045] = {
    3045,
    1,
    "head_deco_3045",
    "str_role_head_image_desc_frame_3045",
    {3045}
  },
  [3046] = {
    3046,
    1,
    "head_deco_3046",
    "str_role_head_image_desc_frame_3046",
    {3046}
  },
  [3047] = {
    3047,
    1,
    "head_deco_3048",
    "str_role_head_image_desc_frame_3047",
    {3047}
  },
  [3048] = {
    3048,
    1,
    "head_deco_3047",
    "str_role_head_image_desc_frame_3048",
    {3048}
  },
  [3049] = {
    3049,
    1,
    "head_deco_3049",
    "str_role_head_image_desc_frame_3049",
    {3049}
  },
  [3050] = {
    3050,
    1,
    "head_deco_3050",
    "str_role_head_image_desc_frame_3050",
    {3050},
    nil,
    1
  },
  [3051] = {
    3051,
    1,
    "head_deco_3051",
    "str_role_head_image_desc_frame_3051",
    {3051}
  },
  [3052] = {
    3052,
    1,
    "head_deco_3052",
    "str_role_head_image_desc_frame_3052",
    {3052}
  },
  [3053] = {
    3053,
    1,
    "head_deco_3763046",
    "str_role_head_image_desc_frame_3763046",
    {3053}
  },
  [3054] = {
    3054,
    1,
    "head_deco_3763047",
    "str_role_head_image_desc_frame_3763047",
    {3054}
  },
  [3055] = {
    3055,
    1,
    "head_deco_3763048",
    "str_role_head_image_desc_frame_3763048",
    {3055}
  },
  [3056] = {
    3056,
    1,
    "head_deco_3763049",
    "str_role_head_image_desc_frame_3763049",
    {3056}
  },
  [3057] = {
    3057,
    1,
    "head_deco_3763050",
    "str_role_head_image_desc_frame_3763050",
    {3057}
  },
  [3058] = {
    3058,
    1,
    "head_deco_3763051",
    "str_role_head_image_desc_frame_3763051",
    {3058}
  },
  [3059] = {
    3059,
    1,
    "head_deco_3053",
    "str_role_head_image_desc_frame_3763044",
    {3059},
    nil,
    1
  },
  [3060] = {
    3060,
    1,
    "head_deco_3054",
    "str_role_head_image_desc_frame_3763045",
    {3060}
  },
  [3061] = {
    3061,
    1,
    "head_deco_3763052",
    "str_role_head_image_desc_frame_3763052",
    {3061}
  },
  [3062] = {
    3062,
    1,
    "head_deco_3763053",
    "str_role_head_image_desc_frame_3763053",
    {3062}
  }
}
return config, "ID", key
