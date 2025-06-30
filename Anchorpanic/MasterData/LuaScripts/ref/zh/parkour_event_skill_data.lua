-- from 1002 跑酷玩法配置表.xlsx

local parkour_event_skill_data=

{
	[1101]={ type=2, buff_id={10001}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[1201]={ type=3, buff_id={100103,100302}, param={}, decide_time={}, damage_cd=500, range_type=0, range_subtype={}, is_show_range=0
},
	[2001]={ type=101, buff_id={100103,100301}, param={}, decide_time={3000,3100}, damage_cd=0, range_type=1, range_subtype={150}, is_show_range=1
},
	[2002]={ type=102, buff_id={10801}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2003]={ type=102, buff_id={10701}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2004]={ type=103, buff_id={10104}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2005]={ type=103, buff_id={10101}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2006]={ type=104, buff_id={10202}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2007]={ type=105, buff_id={10501}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[2008]={ type=104, buff_id={10201}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[3001]={ type=1001, buff_id={}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[3002]={ type=1002, buff_id={}, param={}, decide_time={}, damage_cd=0, range_type=2, range_subtype={98,98}, is_show_range=0
},
	[1208]={ type=201, buff_id={}, param={1210}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[1209]={ type=202, buff_id={}, param={{1210,4445845,485555,555452},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[1210]={ type=203, buff_id={}, param={0,1000,5}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10000]={ type=206, buff_id={}, param={1}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10001]={ type=201, buff_id={}, param={{1,{10000,10000}}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10101]={ type=204, buff_id={}, param={106,{0.610000014,0.0955837965,-1.01683211}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10102]={ type=204, buff_id={}, param={106,{0.610000014,0.0955837965,-1.01683211}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10103]={ type=204, buff_id={}, param={106,{-6.13000011,0.015583992,5.6}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10104]={ type=204, buff_id={}, param={106,{6.34000015,0.015583992,5.6}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10105]={ type=202, buff_id={}, param={{{2,{10101,10107}},{2,{10103,10109}},{2,{10102,10113}},{2,{10104,10115}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10106]={ type=202, buff_id={}, param={{{2,{10102,10108}},{2,{10104,10110}},{2,{10101,10112}},{2,{10103,10114}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10107]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10108]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10109]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10110]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10112]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10113]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10114]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10115]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10116]={ type=208, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10301]={ type=204, buff_id={}, param={106,{-8.09000015,0,-3.25}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10302]={ type=204, buff_id={}, param={106,{-3.74000001,0,3.88000011}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10303]={ type=204, buff_id={}, param={106,{7.88999987,0,3.21000004}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10304]={ type=204, buff_id={}, param={106,{3.13000011,0,-3.25}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10305]={ type=204, buff_id={}, param={106,{5.88999987,0,-2.05999994}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10306]={ type=204, buff_id={}, param={106,{8.13000011,0,-3.25}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10307]={ type=202, buff_id={}, param={{{2,{10309,10108}},{2,{10308,10110}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10308]={ type=204, buff_id={}, param={106,{0.0900000036,2,-0.589999974}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10309]={ type=204, buff_id={}, param={106,{-8.82999992,0,3.88000011}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10310]={ type=203, buff_id={}, param={1,800,1}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10311]={ type=201, buff_id={}, param={{2,{10310,10310}}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10401]={ type=202, buff_id={}, param={{{2,{10401,10107}},{2,{10403,10109}},{2,{10402,10113}},{2,{10404,10115}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10402]={ type=202, buff_id={}, param={{{2,{10402,10108}},{2,{10404,10110}},{2,{10401,10112}},{2,{10403,10114}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10403]={ type=204, buff_id={}, param={106,{-6.36999989,2,2.97199988}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10404]={ type=204, buff_id={}, param={106,{-6.36999989,2,2.97199988}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10405]={ type=204, buff_id={}, param={106,{-4.57000017,0,-1}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10406]={ type=204, buff_id={}, param={106,{5.38000011,0,-1.52999997}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10501]={ type=204, buff_id={}, param={106,{-4.88000011,2,-2.36999989}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10502]={ type=204, buff_id={}, param={106,{1.54999995,0,1.94000006}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10503]={ type=202, buff_id={}, param={{{2,{10501,10108}},{2,{10502,10110}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10601]={ type=202, buff_id={}, param={{{2,{10601,10107}},{2,{10603,10109}},{2,{10602,10113}},{2,{10604,10115}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10602]={ type=202, buff_id={}, param={{{2,{10602,10108}},{2,{10604,10110}},{2,{10601,10112}},{2,{10603,10114}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10603]={ type=204, buff_id={}, param={106,{-3.50999999,0,-1.77999997}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10604]={ type=204, buff_id={}, param={106,{-3.50999999,0,-1.77999997}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10605]={ type=204, buff_id={}, param={106,{-4.25,0,1.77999997}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10606]={ type=204, buff_id={}, param={106,{-8.14000034,2,4.66461039}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10701]={ type=202, buff_id={}, param={{{2,{10701,10107}},{2,{10703,10109}},{2,{10702,10113}},{2,{10704,10115}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10702]={ type=202, buff_id={}, param={{{2,{10702,10108}},{2,{10704,10110}},{2,{10701,10112}},{2,{10703,10114}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10703]={ type=204, buff_id={}, param={106,{4.57000017,2,-1.86000001}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10704]={ type=204, buff_id={}, param={106,{4.57000017,2,-1.86000001}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10705]={ type=204, buff_id={}, param={106,{3.25,2,4.17}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10706]={ type=204, buff_id={}, param={106,{8.5,2,4.3}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10707]={ type=204, buff_id={}, param={0,{-2.26999998,2,2.69000006}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10708]={ type=204, buff_id={}, param={106,{5.52,0,2.48}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10710]={ type=204, buff_id={}, param={0,{5.8,0,3.75}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10711]={ type=204, buff_id={}, param={106,{9.4,2,1.5}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10713]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10714]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10715]={ type=203, buff_id={}, param={1,800,2}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10716]={ type=201, buff_id={}, param={{2,{10713,10715}}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10712]={ type=202, buff_id={}, param={{{2,{10710,10714}},{2,{10711,10718}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10709]={ type=202, buff_id={}, param={{{2,{10707,10713}},{2,{10708,10717}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10717]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10718]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10801]={ type=202, buff_id={}, param={{{2,{10801,10107}},{2,{10802,10109}},{2,{10804,10113}},{2,{10803,10115}},{2,{10805,10812}},{2,{10806,10813}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10802]={ type=202, buff_id={}, param={{{2,{10804,10108}},{2,{10803,10110}},{2,{10801,10112}},{2,{10802,10114}},{2,{10805,10812}},{2,{10806,10813}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10803]={ type=202, buff_id={}, param={{{2,{10801,10112}},{2,{10802,10114}},{2,{10804,10113}},{2,{10803,10115}},{2,{10805,10810}},{2,{10806,10811}}},90541}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10804]={ type=204, buff_id={}, param={106,{-6.38999987,4,-1.59000003}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10805]={ type=204, buff_id={}, param={106,{0.493664086,2.08611536,-1.92700303}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10806]={ type=204, buff_id={}, param={106,{-6.38999987,4,-1.59000003}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10807]={ type=204, buff_id={}, param={106,{7.59000015,4,3.58999991}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10808]={ type=204, buff_id={}, param={106,{-6.38999987,4,-1.59000003}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10809]={ type=204, buff_id={}, param={106,{-0.109999999,0,5.69000006}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10810]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10811]={ type=206, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10812]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10813]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10200]={ type=207, buff_id={}, param={1}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10201]={ type=208, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10202]={ type=209, buff_id={}, param={}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10203]={ type=210, buff_id={}, param={{1,90,90}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10204]={ type=210, buff_id={}, param={{0,45,45}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10205]={ type=207, buff_id={}, param={1}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[10206]={ type=207, buff_id={}, param={0}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13100]={ type=213, buff_id={}, param={{13101,13102,13103,13104,13105,13106,13107},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13200]={ type=213, buff_id={}, param={{13201,13202,13203,13204,13205,13206,13207,13208,13209,13210,13211,13212,13213,13214,13215,13216,13217,13218,13219},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13300]={ type=213, buff_id={}, param={{13301,13302,13303,13304,13305,13306,13307,13308,13309,13310,13311,13312,13313,13314,13315,13316,13317,13318,13319,13320,13321,13322,13323,13324,13325,13326,13327,13328,13329,13330,13331,13332,13333,13334,13335,13336,13337,13338,13339},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13400]={ type=213, buff_id={}, param={{13401,13402,13403,13404,13405,13406,13407,13408,13409,13410,13411,13412},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13500]={ type=213, buff_id={}, param={{13501,13502,13503,13504,13505,13506,13507,13508,13509,13510,13511,13512,13513,13514,13515,13516,13517,13518,13519,13520,13521,13522},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13600]={ type=213, buff_id={}, param={{13601,13602,13603,13604,13605,13606,13607,13608,13609,13610,13611,13612,13613,13614,13615,13616,13617,13618,13619,13620,13621,13622,13623,13624,13625,13626,13627,13628,13629,13630,13631,13632,13633,13634,13635,13636,13637,13638,13639,13640},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13700]={ type=213, buff_id={}, param={{13701,13702,13703,13704,13705,13706},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13701]={ type=204, buff_id={}, param={0,{0.510999978,0,2.53699994}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13702]={ type=204, buff_id={}, param={0,{-1.41400003,0,3.546}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13800]={ type=213, buff_id={}, param={{13801,13802,13803,13804,13805,13806,13807,13808,13809,13810,13811,13812,13813,13814,13815,13816},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13801]={ type=204, buff_id={}, param={0,{1.25999999,0,1.63999999}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13802]={ type=204, buff_id={}, param={0,{-2.76999998,0,1.63999999}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13900]={ type=213, buff_id={}, param={{13901,13902,13903,13904,13905,13906,13907,13908,13909,13910,13911,13912,13913,13914,13915},{12005,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13901]={ type=204, buff_id={}, param={0,{1.44700003,0,1.70700002}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[13902]={ type=204, buff_id={}, param={0,{-1.50999999,0,3.71000004}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[14000]={ type=213, buff_id={}, param={{14001,14002,14003,14004,14005,14006,14007,14008,14009,14010,14011,14012,14013,14014},{14015,10206}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[14001]={ type=204, buff_id={}, param={0,{1.88999999,0,4.13000011}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
},
	[14002]={ type=204, buff_id={}, param={0,{-3.08999991,0,1.23699999}}, decide_time={}, damage_cd=0, range_type=0, range_subtype={}, is_show_range=0
}
}

return parkour_event_skill_data