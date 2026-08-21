local key = {
  ID = 1,
  ConditionParam = 2,
  LockDesc = 3
}
local config = {
  [101] = {
    101,
    "1,30",
    "str_role_head_image_frame_lock_condition_101"
  },
  [102] = {
    102,
    "1,50",
    "str_role_head_image_frame_lock_condition_102"
  },
  [103] = {
    103,
    "2,1,4002120",
    "str_role_head_image_frame_lock_condition_103"
  },
  [104] = {
    104,
    "501,1000000,3000002",
    "str_role_head_image_frame_lock_condition_104"
  },
  [201] = {
    201,
    "501,1,3770001",
    "str_role_head_image_frame_lock_condition_201"
  },
  [202] = {
    202,
    "501,1,3770002",
    "str_role_head_image_frame_lock_condition_202"
  },
  [203] = {
    203,
    "501,1,3770003",
    "str_role_head_image_frame_lock_condition_203"
  },
  [204] = {
    204,
    "302,5,10",
    "str_role_head_image_frame_lock_condition_204"
  },
  [2001] = {
    2001,
    "501,1,3762001",
    "str_role_head_image_frame_lock_condition_2001"
  },
  [2002] = {
    2002,
    "501,1,3762002",
    "str_role_head_image_frame_lock_condition_2002"
  },
  [3001] = {
    3001,
    "501,1,3763001",
    "str_role_head_image_frame_lock_condition_3001"
  },
  [3002] = {
    3002,
    "501,1,3763002",
    "str_role_head_image_frame_lock_condition_3002"
  },
  [3003] = {
    3003,
    "501,1,3763003",
    "str_role_head_image_frame_lock_condition_3003"
  },
  [3004] = {
    3004,
    "501,1,3763004",
    "str_role_head_image_frame_lock_condition_3004"
  },
  [3005] = {
    3005,
    "501,1,3763005",
    "str_role_head_image_frame_lock_condition_3005"
  },
  [3006] = {
    3006,
    "501,1,3763006",
    "str_role_head_image_frame_lock_condition_3006"
  },
  [3007] = {
    3007,
    "501,1,3763007",
    "str_role_head_image_frame_lock_condition_3007"
  },
  [3008] = {
    3008,
    "501,1,3763008",
    "str_role_head_image_frame_lock_condition_3008"
  },
  [3010] = {
    3010,
    "501,1,3763010",
    "str_role_head_image_frame_lock_condition_3010"
  },
  [3011] = {
    3011,
    "501,1,3763011",
    "str_role_head_image_frame_lock_condition_3011"
  },
  [3012] = {
    3012,
    "501,1,3763012",
    "str_role_head_image_frame_lock_condition_3012"
  },
  [3013] = {
    3013,
    "501,1,3763013",
    "str_role_head_image_frame_lock_condition_3013"
  },
  [3014] = {
    3014,
    "501,1,3763014",
    "str_role_head_image_frame_lock_condition_3014"
  },
  [3015] = {
    3015,
    "501,1,3763015",
    "str_role_head_image_frame_lock_condition_3015"
  },
  [3018] = {
    3018,
    "501,1,3763018",
    "str_role_head_image_frame_lock_condition_3018"
  },
  [3019] = {
    3019,
    "501,1,3763019",
    "str_role_head_image_frame_lock_condition_3019"
  },
  [3020] = {
    3020,
    "501,1,3763020",
    "str_role_head_image_frame_lock_condition_3020"
  },
  [3021] = {
    3021,
    "501,1,3763016",
    "str_role_head_image_frame_lock_condition_3021"
  },
  [3022] = {
    3022,
    "501,1,3763017",
    "str_role_head_image_frame_lock_condition_3022"
  },
  [3023] = {
    3023,
    "501,1,3763021",
    "str_role_head_image_frame_lock_condition_3023"
  },
  [3024] = {
    3024,
    "501,1,3763023",
    "str_role_head_image_frame_lock_condition_3024"
  },
  [3025] = {
    3025,
    "501,1,3763024",
    "str_role_head_image_frame_lock_condition_3025"
  },
  [3026] = {
    3026,
    "501,1,3763025",
    "str_role_head_image_frame_lock_condition_3026"
  },
  [3027] = {
    3027,
    "501,1,3763026",
    "str_role_head_image_frame_lock_condition_3027"
  },
  [3028] = {
    3028,
    "501,1,3763027",
    "str_role_head_image_frame_lock_condition_3028"
  },
  [3029] = {
    3029,
    "501,1,3763028",
    "str_role_head_image_frame_lock_condition_3029"
  },
  [3030] = {
    3030,
    "501,1,3763029",
    "str_role_head_image_frame_lock_condition_3763029"
  },
  [3031] = {
    3031,
    "501,1,3763031",
    "str_role_head_image_frame_lock_condition_3031"
  },
  [3041] = {
    3041,
    "501,1,3763032",
    "str_role_head_image_frame_lock_condition_3041"
  },
  [3042] = {
    3042,
    "501,1,3763033",
    "str_role_head_image_frame_lock_condition_3042"
  },
  [3043] = {
    3043,
    "501,1,3763034",
    "str_role_head_image_frame_lock_condition_3043"
  },
  [3044] = {
    3044,
    "501,1,3763035",
    "str_role_head_image_frame_lock_condition_3044"
  },
  [4001] = {
    4001,
    "501,1,3755025",
    "str_role_head_image_frame_lock_condition_3755025"
  },
  [3045] = {
    3045,
    "501,1,3763036",
    "str_role_head_image_frame_lock_condition_3045"
  },
  [3046] = {
    3046,
    "501,1,3763037",
    "str_role_head_image_frame_lock_condition_3046"
  },
  [3047] = {
    3047,
    "501,1,3763039",
    "str_role_head_image_frame_lock_condition_3047"
  },
  [3048] = {
    3048,
    "501,1,3763038",
    "str_role_head_image_frame_lock_condition_3048"
  },
  [3049] = {
    3049,
    "501,1,3763040",
    "str_role_head_image_frame_lock_condition_3049"
  },
  [3050] = {
    3050,
    "501,1,3763041",
    "str_role_head_image_frame_lock_condition_3050"
  },
  [3051] = {
    3051,
    "501,1,3763042",
    "str_role_head_image_frame_lock_condition_3051"
  },
  [3052] = {
    3052,
    "501,1,3763043",
    "str_role_head_image_frame_lock_condition_3052"
  },
  [3053] = {
    3053,
    "501,1,3763046",
    "str_role_head_image_frame_lock_condition_3763046"
  },
  [3054] = {
    3054,
    "501,1,3763047",
    "str_role_head_image_frame_lock_condition_3763047"
  },
  [3055] = {
    3055,
    "501,1,3763048",
    "str_role_head_image_frame_lock_condition_3763048"
  },
  [3056] = {
    3056,
    "501,1,3763049",
    "str_role_head_image_frame_lock_condition_3763049"
  },
  [3057] = {
    3057,
    "501,1,3763050",
    "str_role_head_image_frame_lock_condition_3763050"
  },
  [3058] = {
    3058,
    "501,1,3763051",
    "str_role_head_image_frame_lock_condition_3763051"
  },
  [3059] = {
    3059,
    "501,1,3763044",
    "str_role_head_image_frame_lock_condition_3763044"
  },
  [3060] = {
    3060,
    "501,1,3763045",
    "str_role_head_image_frame_lock_condition_3763045"
  },
  [3061] = {
    3061,
    "501,1,3763052",
    "str_role_head_image_frame_lock_condition_3763052"
  },
  [3062] = {
    3062,
    "501,1,3763053",
    "str_role_head_image_frame_lock_condition_3763053"
  }
}
return config, "ID", key
