-- from 110 断章副本配置表.xlsx

local story_stage_data=

{
	[1001]={ name=2001, chapter=1, sort=1, pre_id={0}, next_id={1002}, type=1, mon={3001,3002}, formation_id=204, number="1-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="历经十一小时的飞行后，莱斯坦斯的链尉官与他的搭档艾丽西亚终于来到了任务地点黎苏根，然而……", first_award=10001, hero_exp=360, role_exp=60, cost=0, music_id=7, scene_id=130, point_line={{2,-30,120,1002}}, suggest_level={0,1}, suggest_ele={1,5}, pos_effect_id={}
},
	[1002]={ name=2002, chapter=1, sort=2, pre_id={1001}, next_id={1003}, type=2, mon={}, formation_id=0, number="1-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官与艾丽西亚的飞行器不幸坠落，并受到了异变体们的“欢迎”，此时，意外的支援来到了……", first_award=10002, hero_exp=400, role_exp=135, cost=15, music_id=7, scene_id=130, point_line={{2,30,120,1003}}, suggest_level={0,1}, suggest_ele={2,0}, pos_effect_id={}
},
	[1003]={ name=2003, chapter=1, sort=3, pre_id={1002}, next_id={1004}, type=3, mon={3011,3012,3013}, formation_id=312, number="1-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10003, hero_exp=440, role_exp=135, cost=15, music_id=7, scene_id=123, point_line={{2,-30,120,1004}}, suggest_level={0,2}, suggest_ele={2,0}, pos_effect_id={}
},
	[1004]={ name=2004, chapter=1, sort=4, pre_id={1003}, next_id={1005}, type=5, mon={3016,3017,3018}, formation_id=303, number="1-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10004, hero_exp=480, role_exp=135, cost=15, music_id=7, scene_id=124, point_line={{2,30,120,1005}}, suggest_level={0,3}, suggest_ele={2,0}, pos_effect_id={}
},
	[1005]={ name=2005, chapter=1, sort=5, pre_id={1004}, next_id={1006}, type=0, mon={3016,3017,3018}, formation_id=303, number="1-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="接应到链尉官后，一行人返回黎苏根，但在去分局报到前，茱莉亚似乎有一些事要处理……", first_award=10005, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1006}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1006]={ name=2006, chapter=1, sort=6, pre_id={1005}, next_id={1007}, type=0, mon={3021,3022,3023}, formation_id=301, number="1-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10006, hero_exp=520, role_exp=135, cost=15, music_id=11, scene_id=127, point_line={{2,30,120,1007}}, suggest_level={0,4}, suggest_ele={1,2}, pos_effect_id={}
},
	[1007]={ name=2007, chapter=1, sort=7, pre_id={1006}, next_id={1008}, type=0, mon={3016,3017,3018}, formation_id=303, number="1-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="终于到达分局报到，但分局长伊西丝似乎对链尉官和艾丽西亚的能力还有一些怀疑……", first_award=10007, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1008}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1008]={ name=2008, chapter=1, sort=8, pre_id={1007}, next_id={1009}, type=0, mon={3026,3027,3028,3029}, formation_id=403, number="1-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10008, hero_exp=560, role_exp=135, cost=15, music_id=11, scene_id=126, point_line={{2,30,120,1009}}, suggest_level={0,6}, suggest_ele={1,2}, pos_effect_id={}
},
	[1009]={ name=2009, chapter=1, sort=9, pre_id={1008}, next_id={1010}, type=0, mon={3016,3017,3018}, formation_id=303, number="1-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在可拉兹的带领下，行动小组来到了任务地点——启幕大楼……", first_award=10009, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1010}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1010]={ name=2010, chapter=1, sort=10, pre_id={1009}, next_id={1011}, type=0, mon={3031,3032,3033,3034}, formation_id=428, number="1-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="除开链尉官一行人外，启幕大楼里还混进了一些奇怪的家伙……", first_award=10010, hero_exp=600, role_exp=135, cost=15, music_id=9, scene_id=124, point_line={{2,30,120,1011}}, suggest_level={0,8}, suggest_ele={1,2}, pos_effect_id={}
},
	[1011]={ name=2011, chapter=1, sort=11, pre_id={1010}, next_id={1012}, type=0, mon={3036,3037,3038,3039}, formation_id=403, number="1-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="启幕大楼被不明人员占领了，必须搞清楚他们的身份和目的……", first_award=10011, hero_exp=720, role_exp=135, cost=15, music_id=9, scene_id=131, point_line={{2,-30,120,1012}}, suggest_level={0,8}, suggest_ele={1,2}, pos_effect_id={1011}
},
	[1012]={ name=2012, chapter=1, sort=12, pre_id={1011}, next_id={1013}, type=0, mon={3041,3042,3043,3044,3045}, formation_id=501, number="1-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="不明人员的目的难道是想要对启幕集团董事会进行劫财吗？怀抱着疑问，行动小组撞开了会议室的门……", first_award=10012, hero_exp=720, role_exp=135, cost=15, music_id=11, scene_id=131, point_line={{2,30,120,1013}}, suggest_level={0,11}, suggest_ele={1,2}, pos_effect_id={1012}
},
	[1013]={ name=2013, chapter=1, sort=13, pre_id={1012}, next_id={1014}, type=0, mon={3046,3047,3048,3049,3050}, formation_id=512, number="1-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="从七十层高楼直落到地下三十米，一定是十分刺激的体验，但现在不是回味的时候——", first_award=10013, hero_exp=720, role_exp=135, cost=15, music_id=11, scene_id=129, point_line={{2,-30,120,1014}}, suggest_level={0,14}, suggest_ele={4,0}, pos_effect_id={1013}
},
	[1014]={ name=2014, chapter=1, sort=14, pre_id={1013}, next_id={1015}, type=0, mon={3051}, formation_id=104, number="1-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="传说中的天灾，大喇喇的出现在了行动小组跟前……", first_award=10014, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=129, point_line={{2,30,120,1015}}, suggest_level={0,18}, suggest_ele={1,2}, pos_effect_id={1014}
},
	[1015]={ name=2015, chapter=1, sort=15, pre_id={1014}, next_id={0}, type=0, mon={3016,3017,3018}, formation_id=303, number="1-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官正在空中下坠——", first_award=10015, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1101]={ name=2016, chapter=2, sort=1, pre_id={0}, next_id={1102}, type=0, mon={3016,3017,3018}, formation_id=303, number="2-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="为了调查真相，约瑟伯格中央议会派出了一名特工前来协助……", first_award=10016, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,30,120,1102}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1102]={ name=2017, chapter=2, sort=2, pre_id={1101}, next_id={1103}, type=0, mon={3101,3102,3103,3104,3105}, formation_id=512, number="2-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组来到了启幕乐园，但这里有些东西……不太对劲……", first_award=10017, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=201, point_line={{2,-30,120,1103}}, suggest_level={0,18}, suggest_ele={1,2}, pos_effect_id={1102}
},
	[1103]={ name=2018, chapter=2, sort=3, pre_id={1102}, next_id={1104}, type=0, mon={3106,3107,3108,3109,3110}, formation_id=539, number="2-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10018, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=201, point_line={{2,30,120,1104}}, suggest_level={0,19}, suggest_ele={1,5}, pos_effect_id={1103}
},
	[1104]={ name=2019, chapter=2, sort=4, pre_id={1103}, next_id={1105}, type=0, mon={3111,3112,3113,3114,3115}, formation_id=509, number="2-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10019, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=201, point_line={{2,-30,120,1105}}, suggest_level={0,19}, suggest_ele={1,5}, pos_effect_id={1104}
},
	[1105]={ name=2020, chapter=2, sort=5, pre_id={1104}, next_id={1106}, type=0, mon={3116,3117,3118,3119,3120}, formation_id=519, number="2-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="面对启幕乐园已成孤岛的局势，卡兰丽莎的解决方案是……", first_award=10020, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=203, point_line={{2,30,120,1106}}, suggest_level={0,22}, suggest_ele={1,2}, pos_effect_id={1105}
},
	[1106]={ name=2021, chapter=2, sort=6, pre_id={1105}, next_id={1107}, type=0, mon={3121,3122,3123,3124,3125}, formation_id=540, number="2-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10021, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=203, point_line={{2,-30,120,1107}}, suggest_level={0,22}, suggest_ele={2,5}, pos_effect_id={1106}
},
	[1107]={ name=2022, chapter=2, sort=7, pre_id={1106}, next_id={1108}, type=0, mon={3126,3127,3128,3129,3130}, formation_id=539, number="2-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="诱敌战术成功了，但敌人也把行动小组包围起来，他们似乎在等待着什么……", first_award=10022, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=203, point_line={{2,30,120,1108}}, suggest_level={0,24}, suggest_ele={2,5}, pos_effect_id={1107}
},
	[1108]={ name=2051, chapter=2, sort=8, pre_id={1107}, next_id={1109}, type=0, mon={3131,3132,3133,3134,3135}, formation_id=509, number="2-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10023, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=203, point_line={{2,-30,120,1109}}, suggest_level={0,24}, suggest_ele={1,2}, pos_effect_id={1108}
},
	[1109]={ name=2052, chapter=2, sort=9, pre_id={1108}, next_id={1110}, type=0, mon={3136,3137,3138,3139,3140}, formation_id=555, number="2-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组遭遇了敌人的首领……", first_award=10024, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=204, point_line={{2,30,120,1110}}, suggest_level={0,28}, suggest_ele={1,5}, pos_effect_id={1109}
},
	[1110]={ name=2053, chapter=2, sort=10, pre_id={1109}, next_id={1111}, type=0, mon={3141,3142,3143,3144,3145}, formation_id=501, number="2-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10025, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=204, point_line={{2,-30,120,1111}}, suggest_level={0,28}, suggest_ele={1,5}, pos_effect_id={1110}
},
	[1111]={ name=2054, chapter=2, sort=11, pre_id={1110}, next_id={1112}, type=0, mon={3146,3147,3148,3149,3150}, formation_id=512, number="2-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="根据尼克的目击情报，链尉官和艾丽西亚来到了游乐园深处的剧场区域——", first_award=10026, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=205, point_line={{2,30,120,1112}}, suggest_level={0,29}, suggest_ele={3,1}, pos_effect_id={1111}
},
	[1112]={ name=2055, chapter=2, sort=12, pre_id={1111}, next_id={1113}, type=0, mon={3151,3152,3153,3154,3155}, formation_id=539, number="2-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10027, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=205, point_line={{2,-30,120,1113}}, suggest_level={0,30}, suggest_ele={3,1}, pos_effect_id={1112}
},
	[1113]={ name=2056, chapter=2, sort=13, pre_id={1112}, next_id={1114}, type=0, mon={3156,3157,3158,3159,3160}, formation_id=501, number="2-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官与艾丽西亚进入了剧场下的空洞区域，在这里，他们发现了……", first_award=10028, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=303, point_line={{2,30,120,1114}}, suggest_level={0,30}, suggest_ele={3,1}, pos_effect_id={1113}
},
	[1114]={ name=2057, chapter=2, sort=14, pre_id={1113}, next_id={1115}, type=0, mon={3161}, formation_id=104, number="2-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="蕾娜已经化为了非人的怪物，她是否能迎来自己的救赎……", first_award=10029, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=301, point_line={{2,-30,120,1115}}, suggest_level={0,30}, suggest_ele={1,0}, pos_effect_id={1114}
},
	[1115]={ name=2058, chapter=2, sort=15, pre_id={1114}, next_id={0}, type=0, mon={3016,3017,3018}, formation_id=303, number="2-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="因为袭击事件，启幕乐园内的苏生节庆典被迫中止，引起了一大波舆情……", first_award=10030, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1201]={ name=2059, chapter=3, sort=1, pre_id={0}, next_id={1202}, type=0, mon={3016,3017,3018}, formation_id=303, number="3-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="启幕乐园事件暴露出了启幕集团与危险组织勾结的事实，必须尽快找到他们的老板尤尔斯——", first_award=10031, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1202}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1202]={ name=2060, chapter=3, sort=2, pre_id={1201}, next_id={1203}, type=0, mon={3201,3202,3203,3204,3205}, formation_id=501, number="3-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="一行人来到了尤尔斯可能藏匿着的星彩源晶矿场，情报里显示这里已经被废弃，但是……真的是这样吗……", first_award=10032, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=306, point_line={{2,30,120,1203}}, suggest_level={0,28}, suggest_ele={2,5}, pos_effect_id={1202}
},
	[1203]={ name=2061, chapter=3, sort=3, pre_id={1202}, next_id={1204}, type=0, mon={3206,3207,3208,3209,3210}, formation_id=539, number="3-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官与艾丽西亚掉落到了废弃矿场的原作业区域中……", first_award=10033, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=501, point_line={{2,-30,120,1204}}, suggest_level={0,29}, suggest_ele={2,5}, pos_effect_id={1203}
},
	[1204]={ name=2062, chapter=3, sort=4, pre_id={1203}, next_id={1205}, type=0, mon={3211,3212,3213,3214,3215}, formation_id=540, number="3-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10034, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=501, point_line={{2,30,120,1205}}, suggest_level={0,30}, suggest_ele={2,5}, pos_effect_id={1204}
},
	[1205]={ name=2063, chapter=3, sort=5, pre_id={1204}, next_id={1206}, type=0, mon={3216,3217,3218,3219,3220}, formation_id=509, number="3-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="随着链尉官和艾丽西亚向设施内部深入，身边的环境也出现了一些变化……", first_award=10035, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=301, point_line={{2,-30,120,1206}}, suggest_level={0,32}, suggest_ele={4,0}, pos_effect_id={1205}
},
	[1206]={ name=2064, chapter=3, sort=6, pre_id={1205}, next_id={1207}, type=0, mon={3221,3222,3223,3224,3225}, formation_id=501, number="3-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10036, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=301, point_line={{2,30,120,1207}}, suggest_level={0,32}, suggest_ele={4,0}, pos_effect_id={1206}
},
	[1207]={ name=2065, chapter=3, sort=7, pre_id={1206}, next_id={1208}, type=0, mon={3226,3227,3228,3229,3230}, formation_id=512, number="3-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在设施深处的不明区域中，链尉官有了新的发现……", first_award=10037, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=303, point_line={{2,-30,120,1208}}, suggest_level={0,33}, suggest_ele={4,0}, pos_effect_id={1207}
},
	[1208]={ name=2066, chapter=3, sort=8, pre_id={1207}, next_id={1209}, type=0, mon={3231,3232,3233,3234,3235}, formation_id=539, number="3-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10038, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=502, point_line={{2,30,120,1209}}, suggest_level={0,35}, suggest_ele={4,0}, pos_effect_id={1208}
},
	[1209]={ name=2067, chapter=3, sort=9, pre_id={1208}, next_id={1210}, type=0, mon={3236,3237,3238,3239,3240}, formation_id=501, number="3-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="面对艾莉丝的猛攻，链尉官的选择是……", first_award=10039, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=303, point_line={{2,-30,120,1210}}, suggest_level={0,36}, suggest_ele={2,5}, pos_effect_id={1209}
},
	[1210]={ name=2068, chapter=3, sort=10, pre_id={1209}, next_id={1211}, type=0, mon={3241,3242,3243,3244,3245}, formation_id=539, number="3-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10040, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=502, point_line={{2,30,120,1211}}, suggest_level={0,37}, suggest_ele={1,2}, pos_effect_id={1210}
},
	[1211]={ name=2069, chapter=3, sort=11, pre_id={1210}, next_id={1212}, type=0, mon={3246,3247,3248,3249,3250}, formation_id=512, number="3-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="虽然还带着伤，但抓捕尤尔斯的行动还要继续……", first_award=10041, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=307, point_line={{2,-30,120,1212}}, suggest_level={0,38}, suggest_ele={0,2}, pos_effect_id={1211}
},
	[1212]={ name=2070, chapter=3, sort=12, pre_id={1211}, next_id={1213}, type=0, mon={3251,3252,3253,3254,3255}, formation_id=509, number="3-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10042, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=307, point_line={{2,30,120,1213}}, suggest_level={0,39}, suggest_ele={0,2}, pos_effect_id={1212}
},
	[1213]={ name=2071, chapter=3, sort=13, pre_id={1212}, next_id={1214}, type=0, mon={3256}, formation_id=104, number="3-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="跨过无数残垣断壁，一行人终于抵达了地下设施的最深处——", first_award=10043, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=304, point_line={{2,-30,120,1214}}, suggest_level={0,40}, suggest_ele={1,3}, pos_effect_id={1213}
},
	[1214]={ name=2072, chapter=3, sort=14, pre_id={1213}, next_id={1215}, type=0, mon={3261,3262,3263,3264,3265}, formation_id=509, number="3-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10044, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=304, point_line={{2,30,120,1215}}, suggest_level={0,40}, suggest_ele={1,5}, pos_effect_id={1214}
},
	[1215]={ name=2073, chapter=3, sort=15, pre_id={1214}, next_id={0}, type=0, mon={3266}, formation_id=104, number="3-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="“茧”苏醒了……", first_award=10045, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=304, point_line={}, suggest_level={0,42}, suggest_ele={1,3}, pos_effect_id={1215}
},
	[1301]={ name=2074, chapter=4, sort=1, pre_id={0}, next_id={1302}, type=0, mon={3016,3017,3018}, formation_id=303, number="4-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="二十小时后，链尉官终于醒了过来……", first_award=10046, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,30,120,1302}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1302]={ name=2075, chapter=4, sort=2, pre_id={1301}, next_id={1303}, type=0, mon={3301,3302,3303,3304,3305}, formation_id=512, number="4-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官与艾丽西亚来到了黎苏根地下城，迎接他们的是……", first_award=10047, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=407, point_line={{2,-30,120,1303}}, suggest_level={0,42}, suggest_ele={1,4}, pos_effect_id={1302}
},
	[1303]={ name=2076, chapter=4, sort=3, pre_id={1302}, next_id={1304}, type=0, mon={3306,3307,3308,3309,3310}, formation_id=544, number="4-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官和艾丽西亚带着两个女孩离开了械斗现场，却没想到……", first_award=10048, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=407, point_line={{2,30,120,1304}}, suggest_level={0,42}, suggest_ele={1,4}, pos_effect_id={1303}
},
	[1304]={ name=2077, chapter=4, sort=4, pre_id={1303}, next_id={1305}, type=0, mon={3311,3312,3313,3314,3315}, formation_id=501, number="4-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在艾丽西亚审问一个倒霉的蚁族成员，并把他塞进街边垃圾桶的同时，链尉官向玛丽安解释了刚才为什么会这么做……", first_award=10049, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=408, point_line={{2,-30,120,1305}}, suggest_level={0,43}, suggest_ele={1,2}, pos_effect_id={1304}
},
	[1305]={ name=2101, chapter=4, sort=5, pre_id={1304}, next_id={1306}, type=0, mon={3016,3017,3018}, formation_id=303, number="4-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="好不容易安静一会，这时候该是交换情报的时间了……", first_award=10050, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,30,120,1306}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1306]={ name=2102, chapter=4, sort=6, pre_id={1305}, next_id={1307}, type=0, mon={3316,3317,3318,3319,3320}, formation_id=540, number="4-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10051, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=408, point_line={{2,-30,120,1307}}, suggest_level={0,45}, suggest_ele={0,3}, pos_effect_id={1306}
},
	[1307]={ name=2103, chapter=4, sort=7, pre_id={1306}, next_id={1308}, type=0, mon={3321,3322,3323,3324,3325}, formation_id=545, number="4-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10052, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=408, point_line={{2,30,120,1308}}, suggest_level={0,45}, suggest_ele={0,3}, pos_effect_id={1307}
},
	[1308]={ name=2104, chapter=4, sort=8, pre_id={1307}, next_id={1309}, type=0, mon={3016,3017,3018}, formation_id=303, number="4-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="玛丽安在不经意之间，戳穿了一个残酷的真相……", first_award=10053, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1309}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1309]={ name=2105, chapter=4, sort=9, pre_id={1308}, next_id={1310}, type=0, mon={3326,3327,3328,3329,3330}, formation_id=546, number="4-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="暴熊想要将启幕集团的专家们当做人质，却没想到……", first_award=10054, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=408, point_line={{2,30,120,1310}}, suggest_level={0,46}, suggest_ele={4,0}, pos_effect_id={1309}
},
	[1310]={ name=2106, chapter=4, sort=10, pre_id={1309}, next_id={1311}, type=0, mon={3331,3332,3333,3334,3335}, formation_id=509, number="4-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="建筑工地里已经乱成了一锅粥……", first_award=10055, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=408, point_line={{2,-30,120,1311}}, suggest_level={0,47}, suggest_ele={0,3}, pos_effect_id={1310}
},
	[1311]={ name=2107, chapter=4, sort=11, pre_id={1310}, next_id={1312}, type=0, mon={3016,3017,3018}, formation_id=303, number="4-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="启幕集团建设工地中，一场临时会议正在进行……", first_award=10056, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,30,120,1312}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1312]={ name=2108, chapter=4, sort=12, pre_id={1311}, next_id={1313}, type=0, mon={3336,3337,3338,3339,3340}, formation_id=547, number="4-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="茱莉亚和露比斯从侧门闯入工地时，链尉官和暴熊正在指挥所有尚未被虚粒子感染的佣兵们紧急撤离……", first_award=10057, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=407, point_line={{2,-30,120,1313}}, suggest_level={0,48}, suggest_ele={3,1}, pos_effect_id={1312}
},
	[1313]={ name=2109, chapter=4, sort=13, pre_id={1312}, next_id={1314}, type=0, mon={3341,3342,3343,3344,3345}, formation_id=548, number="4-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="突围队伍杀进了地下城的排污管控制室，在这里，暴熊和玛丽安见到了一个人……", first_award=10058, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=406, point_line={{2,30,120,1314}}, suggest_level={0,50}, suggest_ele={3,1}, pos_effect_id={1313}
},
	[1314]={ name=2110, chapter=4, sort=14, pre_id={1313}, next_id={1315}, type=0, mon={3346,3347,3348,3349,3350}, formation_id=549, number="4-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="安德烈已经失去了理性，但仍有一样东西，能够将他从疯狂之中唤回——", first_award=10059, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=406, point_line={{2,-30,120,1315}}, suggest_level={0,52}, suggest_ele={1,2}, pos_effect_id={1314}
},
	[1315]={ name=2111, chapter=4, sort=15, pre_id={1314}, next_id={0}, type=0, mon={3351}, formation_id=104, number="4-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="头生犄角的高大男子走进了控制室——", first_award=10060, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=406, point_line={}, suggest_level={0,54}, suggest_ele={5,4}, pos_effect_id={1315}
},
	[1401]={ name=2112, chapter=5, sort=1, pre_id={0}, next_id={1402}, type=0, mon={3016,3017,3018}, formation_id=303, number="5-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="回到地面后，链尉官和艾丽西亚收到了卡兰丽莎发来的支援申请……", first_award=10061, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1402}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1402]={ name=2113, chapter=5, sort=2, pre_id={1401}, next_id={1403}, type=0, mon={3401,3402,3403,3404,3405}, formation_id=509, number="5-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组进入了档案馆，却没想到……", first_award=10062, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=124, point_line={{2,30,120,1403}}, suggest_level={0,54}, suggest_ele={3,1}, pos_effect_id={1402}
},
	[1403]={ name=2114, chapter=5, sort=3, pre_id={1402}, next_id={1404}, type=0, mon={3406,3407,3408,3409,3410}, formation_id=501, number="5-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10063, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=124, point_line={{2,-30,120,1404}}, suggest_level={0,55}, suggest_ele={3,1}, pos_effect_id={1403}
},
	[1404]={ name=2115, chapter=5, sort=4, pre_id={1403}, next_id={1405}, type=0, mon={3411,3412,3413,3414,3415}, formation_id=550, number="5-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="接到伊西丝的指令后，三人正在赶往会合地点的途中……", first_award=10064, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=123, point_line={{2,30,120,1405}}, suggest_level={0,55}, suggest_ele={4,0}, pos_effect_id={1404}
},
	[1405]={ name=2116, chapter=5, sort=5, pre_id={1404}, next_id={1406}, type=0, mon={3416,3417,3418,3419,3420}, formation_id=551, number="5-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10065, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=123, point_line={{2,-30,120,1406}}, suggest_level={0,58}, suggest_ele={2,5}, pos_effect_id={1405}
},
	[1406]={ name=2117, chapter=5, sort=6, pre_id={1405}, next_id={1407}, type=0, mon={3421,3422,3423,3424,3425}, formation_id=552, number="5-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组为黎苏根警卫队解决了一批异变体，但事情却还未结束……", first_award=10066, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=505, point_line={{2,30,120,1407}}, suggest_level={0,58}, suggest_ele={2,5}, pos_effect_id={1406}
},
	[1407]={ name=2118, chapter=5, sort=7, pre_id={1406}, next_id={1408}, type=0, mon={3426,3427,3428,3429,3430}, formation_id=539, number="5-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10067, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=505, point_line={{2,-30,120,1408}}, suggest_level={0,60}, suggest_ele={4,0}, pos_effect_id={1407}
},
	[1408]={ name=2119, chapter=5, sort=8, pre_id={1407}, next_id={1409}, type=0, mon={3431,3432,3433,3434,3435}, formation_id=553, number="5-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="短暂商量后，行动小组决定先行追踪那个煽动难民情绪的人——", first_award=10068, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=505, point_line={{2,30,120,1409}}, suggest_level={0,60}, suggest_ele={0,3}, pos_effect_id={1408}
},
	[1409]={ name=2120, chapter=5, sort=9, pre_id={1408}, next_id={1410}, type=0, mon={3436,3437,3438,3439,3440}, formation_id=501, number="5-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10069, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=505, point_line={{2,-30,120,1410}}, suggest_level={0,60}, suggest_ele={0,3}, pos_effect_id={1409}
},
	[1410]={ name=2121, chapter=5, sort=10, pre_id={1409}, next_id={1411}, type=0, mon={3441,3442,3443,3444,3445}, formation_id=501, number="5-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="九连显然打定主意，不想让行动小组从此地活着出去……", first_award=10070, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=505, point_line={{2,30,120,1411}}, suggest_level={0,62}, suggest_ele={2,5}, pos_effect_id={1410}
},
	[1411]={ name=2122, chapter=5, sort=11, pre_id={1410}, next_id={1412}, type=0, mon={3446,3447,3448,3449,3450}, formation_id=554, number="5-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10071, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=505, point_line={{2,-30,120,1412}}, suggest_level={0,63}, suggest_ele={3,1}, pos_effect_id={1411}
},
	[1412]={ name=2123, chapter=5, sort=12, pre_id={1411}, next_id={1413}, type=0, mon={3451,3452,3453,3454,3455}, formation_id=509, number="5-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组赶到会合地点时，飞鱼小队正在和异变体们战成一团——", first_award=10072, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=605, point_line={{2,30,120,1413}}, suggest_level={0,64}, suggest_ele={3,1}, pos_effect_id={1412}
},
	[1413]={ name=2124, chapter=5, sort=13, pre_id={1412}, next_id={1414}, type=0, mon={3456,3457,3458,3459,3460}, formation_id=546, number="5-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官三人从管道潜入了空天星链基站——", first_award=10073, hero_exp=720, role_exp=135, cost=15, music_id=7, scene_id=601, point_line={{2,-30,120,1414}}, suggest_level={0,65}, suggest_ele={1,2}, pos_effect_id={1413}
},
	[1414]={ name=2125, chapter=5, sort=14, pre_id={1413}, next_id={1415}, type=0, mon={3461}, formation_id=104, number="5-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="行动小组追着血迹，来到了基站的某个外部平台——", first_award=10074, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=603, point_line={{2,30,120,1415}}, suggest_level={0,65}, suggest_ele={0,5}, pos_effect_id={1414}
},
	[1415]={ name=2126, chapter=5, sort=15, pre_id={1414}, next_id={0}, type=0, mon={3016,3017,3018}, formation_id=303, number="5-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在一片火光中，两个身影出现了——", first_award=10075, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1501]={ name=2127, chapter=6, sort=1, pre_id={0}, next_id={1502}, type=0, mon={3501,3502,3503,3504,3505}, formation_id=544, number="6-1", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="面对着眼前的此情此景，卡兰丽莎的辩白是……", first_award=10076, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=605, point_line={{2,30,120,1502}}, suggest_level={0,65}, suggest_ele={3,1}, pos_effect_id={1501}
},
	[1502]={ name=2128, chapter=6, sort=2, pre_id={1501}, next_id={1503}, type=0, mon={3506,3507,3508,3509,3510}, formation_id=519, number="6-2", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="空中的黑云正在以肉眼可见的速度收缩，突然间——", first_award=10077, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=605, point_line={{2,-30,120,1503}}, suggest_level={0,66}, suggest_ele={3,1}, pos_effect_id={1502}
},
	[1503]={ name=2129, chapter=6, sort=3, pre_id={1502}, next_id={1504}, type=0, mon={3511,3512,3513,3514,3515}, formation_id=550, number="6-3", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10078, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=605, point_line={{2,30,120,1504}}, suggest_level={0,67}, suggest_ele={3,1}, pos_effect_id={1503}
},
	[1504]={ name=2130, chapter=6, sort=4, pre_id={1503}, next_id={1505}, type=0, mon={3016,3017,3018}, formation_id=303, number="6-4", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在链尉官迄今为止的所有战斗中，他从未感到如此棘手过——", first_award=10079, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1505}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1505]={ name=2131, chapter=6, sort=5, pre_id={1504}, next_id={1506}, type=0, mon={3516,3517,3518,3519,3520}, formation_id=501, number="6-5", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="空天星链基站内，某个人正在等待着链尉官一行——", first_award=10080, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=502, point_line={{2,30,120,1506}}, suggest_level={0,68}, suggest_ele={2,5}, pos_effect_id={1505}
},
	[1506]={ name=2132, chapter=6, sort=6, pre_id={1505}, next_id={1507}, type=0, mon={3521,3522,3523,3524,3525}, formation_id=539, number="6-6", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="终于，在瞬间的静寂后，“茧”绽放了——", first_award=10081, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=502, point_line={{2,-30,120,1507}}, suggest_level={0,69}, suggest_ele={2,5}, pos_effect_id={1506}
},
	[1507]={ name=2133, chapter=6, sort=7, pre_id={1506}, next_id={1508}, type=0, mon={3526}, formation_id=104, number="6-7", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="狂风在高塔的顶端呼啸，仿佛在为眼前的灾难而嚎哭——", first_award=10082, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=403, point_line={{2,30,120,1508}}, suggest_level={0,70}, suggest_ele={1,3}, pos_effect_id={1507}
},
	[1508]={ name=2134, chapter=6, sort=8, pre_id={1507}, next_id={1509}, type=0, mon={3531,3532,3533,3534,3535}, formation_id=512, number="6-8", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10083, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=403, point_line={{2,-30,120,1509}}, suggest_level={0,70}, suggest_ele={3,0}, pos_effect_id={1508}
},
	[1509]={ name=2135, chapter=6, sort=9, pre_id={1508}, next_id={1510}, type=0, mon={3536,3537,3538,3539,3540}, formation_id=501, number="6-9", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10084, hero_exp=720, role_exp=135, cost=15, music_id=22, scene_id=403, point_line={{2,30,120,1510}}, suggest_level={0,72}, suggest_ele={1,2}, pos_effect_id={1509}
},
	[1510]={ name=2136, chapter=6, sort=10, pre_id={1509}, next_id={1511}, type=0, mon={3016,3017,3018}, formation_id=303, number="6-10", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="链尉官和艾丽西亚正在狭窄的钢铁阶梯上快步向上攀登着——", first_award=10085, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={{2,-30,120,1511}}, suggest_level={}, suggest_ele={}, pos_effect_id={}
},
	[1511]={ name=2137, chapter=6, sort=11, pre_id={1510}, next_id={1512}, type=0, mon={3541,3542,3543,3544,3545}, formation_id=544, number="6-11", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10086, hero_exp=720, role_exp=135, cost=15, music_id=11, scene_id=403, point_line={{2,30,120,1512}}, suggest_level={0,73}, suggest_ele={1,2}, pos_effect_id={1511}
},
	[1512]={ name=2138, chapter=6, sort=12, pre_id={1511}, next_id={1513}, type=0, mon={3546,3547,3548,3549,3550}, formation_id=555, number="6-12", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="战斗不知何时就会到来，必须随时保持警惕……", first_award=10087, hero_exp=720, role_exp=135, cost=15, music_id=11, scene_id=403, point_line={{2,-30,120,1513}}, suggest_level={0,74}, suggest_ele={1,2}, pos_effect_id={1512}
},
	[1513]={ name=2139, chapter=6, sort=13, pre_id={1512}, next_id={1514}, type=0, mon={3551}, formation_id=104, number="6-13", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="七天之内，链尉官第二次踏入了锚点——", first_award=10088, hero_exp=720, role_exp=135, cost=15, music_id=11, scene_id=602, point_line={{2,30,120,1514}}, suggest_level={0,75}, suggest_ele={5,4}, pos_effect_id={1513}
},
	[1514]={ name=2140, chapter=6, sort=14, pre_id={1513}, next_id={1515}, type=0, mon={3556}, formation_id=104, number="6-14", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="在这一瞬间，链尉官成为了艾丽西亚和卡兰丽莎的眼、耳、脑、以及她们的——", first_award=10089, hero_exp=720, role_exp=135, cost=15, music_id=24, scene_id=602, point_line={{2,-30,120,1515}}, suggest_level={0,80}, suggest_ele={2,3}, pos_effect_id={1514}
},
	[1515]={ name=2141, chapter=6, sort=15, pre_id={1514}, next_id={0}, type=0, mon={3016,3017,3018}, formation_id=303, number="6-15", pic=0, story={{1,10001},{2,20001},{3,30001}}, describe="击退了斯科皮欧本体后，链尉官一行人只剩下了一分钟的逃出时间……", first_award=10090, hero_exp=0, role_exp=60, cost=0, music_id=0, scene_id=0, point_line={}, suggest_level={}, suggest_ele={}, pos_effect_id={}
}
}

return story_stage_data