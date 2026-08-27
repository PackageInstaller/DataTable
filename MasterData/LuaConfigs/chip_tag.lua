local __rt_1 = {}
local chip_tag = {
  {
    chip_list = {
      10127,
      10141,
      10143,
      10246,
      15201
    },
    influence = 1,
    suit_max = 3,
    tag_name = 183261
  },
  {
    chip_list = {
      10022,
      10137,
      10280,
      10281,
      15200
    },
    id = 2,
    influence = 1,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_2",
    tag_name = 144047
  },
  {
    chip_list = {
      10136,
      10204,
      10218,
      10251,
      15202
    },
    id = 3,
    influence = 1,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_3",
    tag_name = 379924
  },
  {
    chip_list = {
      10206,
      10207,
      10221,
      10222,
      15208,
      15209
    },
    chip_max_count = 6,
    id = 4,
    influence = 3,
    tag_icon = "ICON_tag_buff_4",
    tag_name = 436523
  },
  {
    chip_list = {
      10015,
      10061,
      10120,
      10286,
      15204,
      15205
    },
    chip_max_count = 6,
    id = 5,
    influence = 3,
    tag_icon = "ICON_tag_buff_5",
    tag_name = 198709
  },
  {
    chip_list = {
      10128,
      10157,
      10220,
      10287,
      15206,
      15207
    },
    chip_max_count = 6,
    id = 6,
    influence = 3,
    tag_icon = "ICON_tag_buff_6",
    tag_name = 245094
  },
  {
    chip_list = {
      10147,
      10224,
      10225,
      10247,
      15214,
      15215
    },
    chip_max_count = 6,
    id = 7,
    influence = 2,
    tag_icon = "ICON_tag_buff_7",
    tag_name = 298311
  },
  {
    chip_list = {
      10209,
      10211,
      10226,
      10289,
      15216,
      15217
    },
    chip_max_count = 6,
    id = 8,
    influence = 2,
    tag_icon = "ICON_tag_buff_8"
  },
  {
    chip_list = {
      10074,
      10123,
      10223,
      10288,
      15212,
      15213
    },
    chip_max_count = 6,
    id = 9,
    influence = 2,
    tag_icon = "ICON_tag_buff_9",
    tag_name = 394586
  },
  {
    chip_list = {
      10066,
      10124,
      10138,
      10290,
      15220,
      15221
    },
    chip_max_count = 6,
    id = 10,
    influence = 4,
    tag_icon = "ICON_tag_buff_10",
    tag_name = 277757
  },
  {
    chip_list = {
      10149,
      10150,
      10151,
      10227,
      15222,
      15223
    },
    chip_max_count = 6,
    id = 11,
    influence = 4,
    tag_icon = "ICON_tag_buff_11",
    tag_name = 339375
  },
  {
    chip_list = {
      10135,
      10228,
      10230,
      10231,
      15224,
      15225
    },
    chip_max_count = 6,
    id = 12,
    influence = 4,
    tag_icon = "ICON_tag_buff_12",
    tag_name = 452851
  },
  {
    chip_list = {
      10234,
      10248,
      10250,
      10292,
      15230
    },
    id = 13,
    influence = 5,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_13",
    tag_name = 495344
  },
  {
    chip_list = {
      10139,
      10140,
      10232,
      10274,
      15228
    },
    id = 14,
    influence = 5,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_14",
    tag_name = 387502
  },
  {
    chip_list = {
      10152,
      10154,
      10254,
      10291,
      15229
    },
    id = 15,
    influence = 5,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_15",
    tag_name = 270389
  },
  {
    chip_list = {
      10215,
      10238,
      10239,
      10240,
      10279
    },
    id = 16,
    tag_icon = "ICON_tag_buff_16",
    tag_name = 362212
  },
  {
    chip_list = {
      10133,
      10165,
      10167,
      10293,
      10294
    },
    id = 17,
    tag_icon = "ICON_tag_buff_17",
    tag_name = 402578
  },
  {
    chip_list = {
      10076,
      10193,
      10212,
      10213,
      10295
    },
    id = 18,
    tag_icon = "ICON_tag_buff_18",
    tag_name = 387945
  },
  {
    chip_max_count = 0,
    id = 19,
    tag_icon = "ICON_tag_buff_19",
    tag_name = 441190
  },
  {
    chip_max_count = 0,
    id = 20,
    tag_icon = "ICON_tag_buff_20",
    tag_name = 299950
  },
  {
    chip_max_count = 0,
    id = 21,
    tag_icon = "ICON_tag_buff_21",
    tag_name = 469835
  },
  {
    chip_max_count = 0,
    id = 22,
    tag_icon = "ICON_tag_buff_22",
    tag_name = 449895
  },
  {
    chip_max_count = 0,
    id = 23,
    tag_icon = "ICON_tag_buff_23",
    tag_name = 484211
  },
  {
    chip_list = {10260, 10261},
    chip_max_count = 2,
    id = 24,
    influence = 2,
    suit_max = 2,
    tag_icon = "ICON_tag_buff_24",
    tag_name = 443022
  },
  {
    chip_list = {
      10262,
      10263,
      10264,
      10265,
      15210,
      15211
    },
    chip_max_count = 6,
    id = 25,
    influence = 3,
    tag_icon = "ICON_tag_buff_25",
    tag_name = 228407
  },
  {
    chip_list = {
      10266,
      10267,
      10268,
      10269,
      15218,
      15219
    },
    chip_max_count = 6,
    id = 26,
    influence = 2,
    tag_icon = "ICON_tag_buff_26",
    tag_name = 504819
  },
  {
    chip_list = {
      10270,
      10271,
      10272,
      10273,
      15226,
      15227
    },
    chip_max_count = 6,
    id = 27,
    influence = 4,
    tag_icon = "ICON_tag_buff_27",
    tag_name = 385230
  },
  {
    chip_list = {
      10275,
      10276,
      10277,
      10278,
      15231
    },
    id = 28,
    influence = 5,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_28",
    tag_name = 69431
  },
  {
    chip_list = {
      10282,
      10283,
      10284,
      10285,
      15203
    },
    id = 29,
    influence = 1,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_29",
    tag_name = 291360
  },
  {
    chip_list = {
      10296,
      10297,
      10298,
      10299,
      10300
    },
    id = 30,
    tag_icon = "ICON_tag_buff_30",
    tag_name = 364333
  },
  {
    chip_list = {
      10304,
      10305,
      10306,
      10307,
      10308
    },
    id = 31,
    tag_icon = "ICON_tag_buff_31",
    tag_name = 357062
  },
  {
    chip_list = {
      10311,
      10312,
      10313,
      10314
    },
    chip_max_count = 4,
    id = 32,
    influence = 4,
    tag_icon = "ICON_tag_buff_32",
    tag_name = 328030
  },
  {
    chip_list = {
      10315,
      10316,
      10317,
      10318,
      10319
    },
    id = 33,
    tag_icon = "ICON_tag_buff_33",
    tag_name = 263067
  },
  {
    chip_list = {
      10320,
      10321,
      10322,
      10323,
      15345,
      15346
    },
    chip_max_count = 6,
    id = 34,
    influence = 3,
    tag_icon = "ICON_tag_buff_34",
    tag_name = 339094
  },
  {
    chip_list = {
      10324,
      10325,
      10326,
      10327,
      10328
    },
    id = 35,
    influence = 3,
    suit_max = 5,
    tag_icon = "ICON_tag_buff_35",
    tag_name = 451621
  },
  {
    chip_list = {
      10329,
      10330,
      10331,
      10332
    },
    chip_max_count = 4,
    id = 36,
    influence = 3,
    tag_icon = "ICON_tag_buff_36",
    tag_name = 355818
  },
  {
    chip_list = {
      15090,
      15091,
      15092,
      15093
    },
    chip_max_count = 4,
    id = 37,
    tag_icon = "ICON_tag_buff_37",
    tag_name = 333450
  },
  [39] = {
    chip_list = {
      15340,
      15341,
      15342,
      15343,
      15344
    },
    id = 39,
    tag_icon = "ICON_tag_buff_39",
    tag_name = 49580
  },
  [40] = {
    chip_list = {
      17100,
      17101,
      17102,
      17103,
      17104
    },
    id = 40,
    tag_icon = "ICON_tag_buff_40",
    tag_name = 117495
  },
  [41] = {
    chip_list = {
      17105,
      17106,
      17107,
      17108,
      17109
    },
    id = 41,
    tag_icon = "ICON_tag_buff_41",
    tag_name = 320040
  },
  [101] = {
    chip_list = {
      17301,
      17302,
      17303,
      17304,
      17305,
      17306,
      17307,
      17308
    },
    chip_max_count = 8,
    id = 101,
    influence = 2,
    suit_max = 8,
    tag_icon = "ICON_tag_buff_101",
    tag_name = 161662
  },
  [102] = {
    chip_list = {
      17311,
      17312,
      17313,
      17314,
      17315,
      17316,
      17317,
      17319
    },
    chip_max_count = 8,
    id = 102,
    suit_max = 8,
    tag_icon = "ICON_tag_buff_102",
    tag_name = 328372
  },
  [103] = {
    chip_list = {
      17321,
      17322,
      17323,
      17324,
      17325,
      17326,
      17327,
      17328
    },
    chip_max_count = 8,
    id = 103,
    suit_max = 8,
    tag_icon = "ICON_tag_buff_103",
    tag_name = 121675
  },
  [991] = {
    chip_list = {
      9910127,
      9910141,
      9910143,
      9910246
    },
    chip_max_count = 4,
    id = 991,
    influence = 1,
    tag_name = 183261
  },
  [992] = {
    chip_list = {
      9910022,
      9910137,
      9910280,
      9910281
    },
    chip_max_count = 4,
    id = 992,
    influence = 1,
    tag_icon = "ICON_tag_buff_2",
    tag_name = 144047
  },
  [993] = {
    chip_list = {
      9910136,
      9910204,
      9910218,
      9910251
    },
    chip_max_count = 4,
    id = 993,
    influence = 1,
    tag_icon = "ICON_tag_buff_3",
    tag_name = 379924
  },
  [994] = {
    chip_list = {
      9910206,
      9910207,
      9910221,
      9910222
    },
    chip_max_count = 4,
    id = 994,
    influence = 3,
    tag_icon = "ICON_tag_buff_4",
    tag_name = 436523
  },
  [995] = {
    chip_list = {
      9910015,
      9910061,
      9910120,
      9910286
    },
    chip_max_count = 4,
    id = 995,
    influence = 3,
    tag_icon = "ICON_tag_buff_5",
    tag_name = 198709
  },
  [996] = {
    chip_list = {
      9910128,
      9910157,
      9910220,
      9910287
    },
    chip_max_count = 4,
    id = 996,
    influence = 3,
    tag_icon = "ICON_tag_buff_6",
    tag_name = 245094
  },
  [997] = {
    chip_list = {
      9910147,
      9910224,
      9910225,
      9910247
    },
    chip_max_count = 4,
    id = 997,
    influence = 2,
    tag_icon = "ICON_tag_buff_7",
    tag_name = 298311
  },
  [998] = {
    chip_list = {
      9910209,
      9910211,
      9910226,
      9910289
    },
    chip_max_count = 4,
    id = 998,
    influence = 2,
    tag_icon = "ICON_tag_buff_8"
  },
  [999] = {
    chip_list = {
      9910074,
      9910123,
      9910223,
      9910288
    },
    chip_max_count = 4,
    id = 999,
    influence = 2,
    tag_icon = "ICON_tag_buff_9",
    tag_name = 394586
  },
  [9910] = {
    chip_list = {
      9910066,
      9910124,
      9910138,
      9910290
    },
    chip_max_count = 4,
    id = 9910,
    influence = 4,
    tag_icon = "ICON_tag_buff_10",
    tag_name = 277757
  },
  [9911] = {
    chip_list = {
      9910149,
      9910150,
      9910151,
      9910227
    },
    chip_max_count = 4,
    id = 9911,
    influence = 4,
    tag_icon = "ICON_tag_buff_11",
    tag_name = 339375
  },
  [9912] = {
    chip_list = {
      9910135,
      9910228,
      9910230,
      9910231
    },
    chip_max_count = 4,
    id = 9912,
    influence = 4,
    tag_icon = "ICON_tag_buff_12",
    tag_name = 452851
  },
  [9913] = {
    chip_list = {
      9910234,
      9910248,
      9910250,
      9910292
    },
    chip_max_count = 4,
    id = 9913,
    influence = 5,
    tag_icon = "ICON_tag_buff_13",
    tag_name = 495344
  },
  [9914] = {
    chip_list = {
      9910139,
      9910140,
      9910232,
      9910274
    },
    chip_max_count = 4,
    id = 9914,
    influence = 5,
    tag_icon = "ICON_tag_buff_14",
    tag_name = 387502
  },
  [9915] = {
    chip_list = {
      9910152,
      9910154,
      9910254,
      9910291
    },
    chip_max_count = 4,
    id = 9915,
    influence = 5,
    tag_icon = "ICON_tag_buff_15",
    tag_name = 270389
  },
  [9916] = {
    chip_list = {
      9910215,
      9910238,
      9910239,
      9910240,
      9910279
    },
    id = 9916,
    tag_icon = "ICON_tag_buff_16",
    tag_name = 362212
  },
  [9917] = {
    chip_list = {
      9910133,
      9910165,
      9910167,
      9910293,
      9910294
    },
    id = 9917,
    tag_icon = "ICON_tag_buff_17",
    tag_name = 402578
  },
  [9918] = {
    chip_list = {
      9910076,
      9910193,
      9910212,
      9910213,
      9910295
    },
    id = 9918,
    tag_icon = "ICON_tag_buff_18",
    tag_name = 387945
  },
  [9919] = {
    chip_max_count = 0,
    id = 9919,
    tag_icon = "ICON_tag_buff_19",
    tag_name = 441190
  },
  [9920] = {
    chip_max_count = 0,
    id = 9920,
    tag_icon = "ICON_tag_buff_20",
    tag_name = 299950
  },
  [9921] = {
    chip_max_count = 0,
    id = 9921,
    tag_icon = "ICON_tag_buff_21",
    tag_name = 469835
  },
  [9922] = {
    chip_max_count = 0,
    id = 9922,
    tag_icon = "ICON_tag_buff_22",
    tag_name = 449895
  },
  [9923] = {
    chip_max_count = 0,
    id = 9923,
    tag_icon = "ICON_tag_buff_23",
    tag_name = 484211
  },
  [9924] = {
    chip_max_count = 0,
    id = 9924,
    influence = 2,
    suit_max = 2,
    tag_icon = "ICON_tag_buff_24",
    tag_name = 443022
  },
  [9925] = {
    chip_list = {
      9910262,
      9910263,
      9910264,
      9910265
    },
    chip_max_count = 4,
    id = 9925,
    influence = 3,
    tag_icon = "ICON_tag_buff_25",
    tag_name = 228407
  },
  [9926] = {
    chip_list = {
      9910266,
      9910267,
      9910268,
      9910269
    },
    chip_max_count = 4,
    id = 9926,
    influence = 2,
    tag_icon = "ICON_tag_buff_26",
    tag_name = 504819
  },
  [9927] = {
    chip_list = {
      9910270,
      9910271,
      9910272,
      9910273
    },
    chip_max_count = 4,
    id = 9927,
    influence = 4,
    tag_icon = "ICON_tag_buff_27",
    tag_name = 385230
  },
  [9928] = {
    chip_list = {
      9910275,
      9910276,
      9910277,
      9910278
    },
    chip_max_count = 4,
    id = 9928,
    influence = 5,
    tag_icon = "ICON_tag_buff_28",
    tag_name = 69431
  },
  [9929] = {
    chip_list = {
      9910282,
      9910283,
      9910284,
      9910285
    },
    chip_max_count = 4,
    id = 9929,
    influence = 1,
    tag_icon = "ICON_tag_buff_29",
    tag_name = 291360
  },
  [9930] = {
    chip_list = {
      9910296,
      9910297,
      9910298,
      9910299,
      9910300
    },
    id = 9930,
    tag_icon = "ICON_tag_buff_30",
    tag_name = 364333
  },
  [9931] = {
    chip_list = {
      9910304,
      9910305,
      9910306,
      9910307,
      9910308
    },
    id = 9931,
    tag_icon = "ICON_tag_buff_31",
    tag_name = 357062
  },
  [9932] = {
    chip_list = {
      9910311,
      9910312,
      9910313,
      9910314
    },
    chip_max_count = 4,
    id = 9932,
    influence = 4,
    tag_icon = "ICON_tag_buff_32",
    tag_name = 328030
  },
  [9933] = {
    chip_list = {
      9910315,
      9910316,
      9910317,
      9910318,
      9910319
    },
    id = 9933,
    tag_icon = "ICON_tag_buff_33",
    tag_name = 263067
  },
  [9934] = {
    chip_list = {
      9910320,
      9910321,
      9910322,
      9910323
    },
    chip_max_count = 4,
    id = 9934,
    influence = 3,
    tag_icon = "ICON_tag_buff_34",
    tag_name = 339094
  },
  [9935] = {
    chip_list = {
      15330,
      15331,
      15332,
      15333,
      15334
    },
    id = 9935,
    tag_icon = "ICON_tag_buff_38",
    tag_name = 259239
  },
  [9936] = {
    chip_list = {
      17110,
      17111,
      17112,
      17113,
      17114,
      17115
    },
    chip_max_count = 6,
    id = 9936,
    influence = 2,
    tag_icon = "ICON_tag_buff_42",
    tag_name = 481459
  },
  [9937] = {
    chip_list = {
      10333,
      10334,
      10335,
      10336,
      10337
    },
    id = 9937,
    tag_icon = "ICON_tag_buff_43",
    tag_name = 66793
  },
  [9938] = {
    chip_list = {
      10338,
      10339,
      10340,
      10341,
      10342
    },
    id = 9938,
    influence = 1,
    suit_max = 3,
    tag_icon = "ICON_tag_buff_44",
    tag_name = 475648
  }
}
local __default_values = {
  chip_list = __rt_1,
  chip_max_count = 5,
  id = 1,
  influence = 6,
  suit_max = 4,
  tag_icon = "ICON_tag_buff_1",
  tag_name = 135898
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(chip_tag) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  tag_suits = {
    {
      {chip_id = 30002, number = 2},
      {chip_id = 30003, number = 3}
    },
    {
      {chip_id = 30000, number = 2},
      {chip_id = 30001, number = 3}
    },
    {
      {chip_id = 30004, number = 2},
      {chip_id = 30005, number = 3}
    },
    {
      {chip_id = 30006, number = 2},
      {chip_id = 30007, number = 4}
    },
    {
      {chip_id = 30010, number = 2},
      {chip_id = 30011, number = 4}
    },
    {
      {chip_id = 30030, number = 2},
      {chip_id = 30031, number = 4}
    },
    {
      {chip_id = 30008, number = 2},
      {chip_id = 30009, number = 4}
    },
    {
      {chip_id = 30034, number = 2},
      {chip_id = 30035, number = 4}
    },
    {
      {chip_id = 30032, number = 2},
      {chip_id = 30033, number = 4}
    },
    {
      {chip_id = 30036, number = 2},
      {chip_id = 30037, number = 4}
    },
    {
      {chip_id = 30038, number = 2},
      {chip_id = 30039, number = 4}
    },
    {
      {chip_id = 30012, number = 2},
      {chip_id = 30013, number = 4}
    },
    {
      {chip_id = 30014, number = 2},
      {chip_id = 30015, number = 3}
    },
    {
      {chip_id = 30016, number = 2},
      {chip_id = 30017, number = 3}
    },
    {
      {chip_id = 30040, number = 2},
      {chip_id = 30041, number = 3}
    },
    {
      {chip_id = 30018, number = 2},
      {chip_id = 30019, number = 4}
    },
    {
      {chip_id = 30042, number = 2},
      {chip_id = 30043, number = 4}
    },
    {
      {chip_id = 30044, number = 2},
      {chip_id = 30045, number = 4}
    },
    {
      {chip_id = 15037, number = 2},
      {chip_id = 15038, number = 4}
    },
    {
      {chip_id = 15039, number = 2},
      {chip_id = 15040, number = 4}
    },
    {
      {chip_id = 15041, number = 2},
      {chip_id = 15042, number = 4}
    },
    {
      {chip_id = 15043, number = 2},
      {chip_id = 15044, number = 4}
    },
    {
      {chip_id = 15045, number = 2},
      {chip_id = 15046, number = 4}
    },
    {
      {chip_id = 15047, number = 2}
    },
    {
      {chip_id = 30022, number = 2},
      {chip_id = 30023, number = 4}
    },
    {
      {chip_id = 30025, number = 2},
      {chip_id = 30024, number = 4}
    },
    {
      {chip_id = 30026, number = 2},
      {chip_id = 30027, number = 4}
    },
    {
      {chip_id = 30028, number = 2},
      {chip_id = 30029, number = 3}
    },
    {
      {chip_id = 30020, number = 2},
      {chip_id = 30021, number = 3}
    },
    {
      {chip_id = 30046, number = 2},
      {chip_id = 30047, number = 4}
    },
    {
      {chip_id = 30048, number = 2},
      {chip_id = 30049, number = 4}
    },
    {
      {chip_id = 30050, number = 2},
      {chip_id = 30051, number = 4}
    },
    {
      {chip_id = 30052, number = 2},
      {chip_id = 30053, number = 4}
    },
    {
      {chip_id = 30056, number = 2},
      {chip_id = 30057, number = 4}
    },
    {
      {chip_id = 30058, number = 2},
      {chip_id = 30059, number = 5}
    },
    {
      {chip_id = 93029, number = 2},
      {chip_id = 93031, number = 4}
    },
    {
      {chip_id = 30060, number = 2},
      {chip_id = 30061, number = 4}
    },
    [39] = {
      {chip_id = 30064, number = 2},
      {chip_id = 30065, number = 4}
    },
    [40] = {
      {chip_id = 30066, number = 2},
      {chip_id = 30067, number = 4}
    },
    [41] = {
      {chip_id = 30068, number = 2},
      {chip_id = 30069, number = 4}
    },
    [101] = {
      {chip_id = 31001, number = 2},
      {chip_id = 31002, number = 4},
      {chip_id = 31003, number = 8}
    },
    [102] = {
      {chip_id = 31004, number = 2},
      {chip_id = 31005, number = 4},
      {chip_id = 31006, number = 8}
    },
    [103] = {
      {chip_id = 31007, number = 2},
      {chip_id = 31008, number = 4},
      {chip_id = 31009, number = 8}
    },
    [991] = {
      {chip_id = 30002, number = 2},
      {chip_id = 30003, number = 4}
    },
    [992] = {
      {chip_id = 30000, number = 2},
      {chip_id = 30001, number = 4}
    },
    [993] = {
      {chip_id = 30004, number = 2},
      {chip_id = 30005, number = 4}
    },
    [994] = {
      {chip_id = 30006, number = 2},
      {chip_id = 30007, number = 4}
    },
    [995] = {
      {chip_id = 30010, number = 2},
      {chip_id = 30011, number = 4}
    },
    [996] = {
      {chip_id = 30030, number = 2},
      {chip_id = 30031, number = 4}
    },
    [997] = {
      {chip_id = 30008, number = 2},
      {chip_id = 30009, number = 4}
    },
    [998] = {
      {chip_id = 30034, number = 2},
      {chip_id = 30035, number = 4}
    },
    [999] = {
      {chip_id = 30032, number = 2},
      {chip_id = 30033, number = 4}
    },
    [9910] = {
      {chip_id = 30036, number = 2},
      {chip_id = 30037, number = 4}
    },
    [9911] = {
      {chip_id = 30038, number = 2},
      {chip_id = 30039, number = 4}
    },
    [9912] = {
      {chip_id = 30012, number = 2},
      {chip_id = 30013, number = 4}
    },
    [9913] = {
      {chip_id = 30014, number = 2},
      {chip_id = 30015, number = 4}
    },
    [9914] = {
      {chip_id = 30016, number = 2},
      {chip_id = 30017, number = 4}
    },
    [9915] = {
      {chip_id = 30040, number = 2},
      {chip_id = 30041, number = 4}
    },
    [9916] = {
      {chip_id = 30018, number = 2},
      {chip_id = 30019, number = 4}
    },
    [9917] = {
      {chip_id = 30042, number = 2},
      {chip_id = 30043, number = 4}
    },
    [9918] = {
      {chip_id = 30044, number = 2},
      {chip_id = 30045, number = 4}
    },
    [9919] = {
      {chip_id = 15037, number = 2},
      {chip_id = 15038, number = 4}
    },
    [9920] = {
      {chip_id = 15039, number = 2},
      {chip_id = 15040, number = 4}
    },
    [9921] = {
      {chip_id = 15041, number = 2},
      {chip_id = 15042, number = 4}
    },
    [9922] = {
      {chip_id = 15043, number = 2},
      {chip_id = 15044, number = 4}
    },
    [9923] = {
      {chip_id = 15045, number = 2},
      {chip_id = 15046, number = 4}
    },
    [9924] = {
      {chip_id = 15047, number = 2}
    },
    [9925] = {
      {chip_id = 30022, number = 2},
      {chip_id = 30023, number = 4}
    },
    [9926] = {
      {chip_id = 30025, number = 2},
      {chip_id = 30024, number = 4}
    },
    [9927] = {
      {chip_id = 30026, number = 2},
      {chip_id = 30027, number = 4}
    },
    [9928] = {
      {chip_id = 30028, number = 2},
      {chip_id = 30029, number = 4}
    },
    [9929] = {
      {chip_id = 30020, number = 2},
      {chip_id = 30021, number = 4}
    },
    [9930] = {
      {chip_id = 30046, number = 2},
      {chip_id = 30047, number = 4}
    },
    [9931] = {
      {chip_id = 30048, number = 2},
      {chip_id = 30049, number = 4}
    },
    [9932] = {
      {chip_id = 30050, number = 2},
      {chip_id = 30051, number = 4}
    },
    [9933] = {
      {chip_id = 30052, number = 2},
      {chip_id = 30053, number = 4}
    },
    [9934] = {
      {chip_id = 30056, number = 2},
      {chip_id = 30057, number = 4}
    },
    [9935] = {
      {chip_id = 30062, number = 2},
      {chip_id = 30063, number = 4}
    },
    [9936] = {
      {chip_id = 30070, number = 2},
      {chip_id = 30071, number = 4}
    },
    [9937] = {
      {chip_id = 30072, number = 2},
      {chip_id = 30073, number = 4}
    },
    [9938] = {
      {chip_id = 30074, number = 2},
      {chip_id = 30075, number = 3}
    }
  }
}
setmetatable(chip_tag, {__index = __rawdata})
return chip_tag
