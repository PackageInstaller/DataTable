-- from 032 识域勘探配置表.xlsx

local climb_tower_dup_data=

{
	[2001]={ name=20001, describe=22501, pre_id=0, next_id=2002, mon={10001,10002,10003,10004,10005}, formation_id=502, support_skill={}, first_award=1101, recommend_force=0, music_id=0, scene_id=128, map_id=1, stage_name="1-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,20}, suggest_ele={1,5}, lock_formation=0, pos_effect_id={}, extra_hero={}, layer=1
},
	[2002]={ name=20002, describe=22502, pre_id=2001, next_id=2003, mon={10006,10007,10008,10009,10010}, formation_id=507, support_skill={}, first_award=1102, recommend_force=0, music_id=0, scene_id=129, map_id=1, stage_name="1-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,22}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3001}, extra_hero={}, layer=2
},
	[2003]={ name=20003, describe=22503, pre_id=2002, next_id=2004, mon={10011,10012,10013,10014,10015}, formation_id=503, support_skill={}, first_award=1105, recommend_force=0, music_id=0, scene_id=130, map_id=1, stage_name="1-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,24}, suggest_ele={1,5}, lock_formation=0, pos_effect_id={3001}, extra_hero={}, layer=3
},
	[2004]={ name=20004, describe=22504, pre_id=2003, next_id=2005, mon={10016,10017,10018,10019,10020}, formation_id=501, support_skill={}, first_award=1108, recommend_force=0, music_id=0, scene_id=131, map_id=1, stage_name="1-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,26}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3001}, extra_hero={}, layer=4
},
	[2005]={ name=20005, describe=22505, pre_id=2004, next_id=2006, mon={10021,10022,10023,10024,10025}, formation_id=506, support_skill={}, first_award=1109, recommend_force=0, music_id=0, scene_id=207, map_id=1, stage_name="1-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,28}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3001}, extra_hero={}, layer=5
},
	[2006]={ name=20006, describe=22506, pre_id=2005, next_id=2011, mon={10026,10027,10028,10029,10030}, formation_id=502, support_skill={}, first_award=1110, recommend_force=0, music_id=0, scene_id=307, map_id=1, stage_name="1-6", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,30}, suggest_ele={5,2}, lock_formation=0, pos_effect_id={3001,3061}, extra_hero={}, layer=6
},
	[2011]={ name=20001, describe=22511, pre_id=2006, next_id=2012, mon={10051,10052,10053,10054,10055}, formation_id=507, support_skill={}, first_award=1111, recommend_force=0, music_id=0, scene_id=407, map_id=2, stage_name="2-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,30}, suggest_ele={1,4}, lock_formation=0, pos_effect_id={3002}, extra_hero={}, layer=7
},
	[2012]={ name=20002, describe=22512, pre_id=2011, next_id=2013, mon={10056,10057,10058,10059,10060}, formation_id=502, support_skill={}, first_award=1112, recommend_force=0, music_id=0, scene_id=408, map_id=2, stage_name="2-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,32}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3002}, extra_hero={}, layer=8
},
	[2013]={ name=20003, describe=22513, pre_id=2012, next_id=2014, mon={10061,10062,10063,10064,10065}, formation_id=507, support_skill={}, first_award=1115, recommend_force=0, music_id=0, scene_id=501, map_id=2, stage_name="2-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,34}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3002}, extra_hero={}, layer=9
},
	[2014]={ name=20004, describe=22514, pre_id=2013, next_id=2015, mon={10066,10067,10068,10069,10070}, formation_id=505, support_skill={}, first_award=1118, recommend_force=0, music_id=0, scene_id=503, map_id=2, stage_name="2-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,36}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3002}, extra_hero={}, layer=10
},
	[2015]={ name=20005, describe=22515, pre_id=2014, next_id=2016, mon={10071,10072,10073,10074,10075}, formation_id=501, support_skill={}, first_award=1119, recommend_force=0, music_id=0, scene_id=504, map_id=2, stage_name="2-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,38}, suggest_ele={2,4}, lock_formation=0, pos_effect_id={3002}, extra_hero={}, layer=11
},
	[2016]={ name=20006, describe=22516, pre_id=2015, next_id=2021, mon={10076,10077,10078,10079,10080}, formation_id=501, support_skill={}, first_award=1120, recommend_force=0, music_id=0, scene_id=601, map_id=2, stage_name="2-6", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,40}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={3062}, extra_hero={}, layer=12
},
	[2021]={ name=20001, describe=22521, pre_id=2016, next_id=2022, mon={10101,10102,10103,10104,10105}, formation_id=506, support_skill={}, first_award=1101, recommend_force=0, music_id=0, scene_id=126, map_id=3, stage_name="3-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,40}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=13
},
	[2022]={ name=20002, describe=22522, pre_id=2021, next_id=2023, mon={10106,10107,10108,10109,10110}, formation_id=501, support_skill={}, first_award=1102, recommend_force=0, music_id=0, scene_id=203, map_id=3, stage_name="3-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,42}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=14
},
	[2023]={ name=20003, describe=22523, pre_id=2022, next_id=2024, mon={10111,10112,10113,10114,10115}, formation_id=505, support_skill={}, first_award=1103, recommend_force=0, music_id=0, scene_id=123, map_id=3, stage_name="3-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,44}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=15
},
	[2024]={ name=20004, describe=22524, pre_id=2023, next_id=2025, mon={10116,10117,10118,10119,10120}, formation_id=501, support_skill={}, first_award=1105, recommend_force=0, music_id=0, scene_id=124, map_id=3, stage_name="3-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,46}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=16
},
	[2025]={ name=20005, describe=22525, pre_id=2024, next_id=2026, mon={10121,10122,10123,10124,10125}, formation_id=507, support_skill={}, first_award=1107, recommend_force=0, music_id=0, scene_id=203, map_id=3, stage_name="3-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,47}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=17
},
	[2026]={ name=20006, describe=22526, pre_id=2025, next_id=2027, mon={10126,10127,10128,10129,10130}, formation_id=505, support_skill={}, first_award=1108, recommend_force=0, music_id=0, scene_id=304, map_id=3, stage_name="3-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,48}, suggest_ele={1,0}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=18
},
	[2027]={ name=20007, describe=22527, pre_id=2026, next_id=2028, mon={10131,10132,10133,10134,10135}, formation_id=507, support_skill={}, first_award=1109, recommend_force=0, music_id=0, scene_id=605, map_id=3, stage_name="3-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,49}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=19
},
	[2028]={ name=20008, describe=22528, pre_id=2027, next_id=2031, mon={10136,10137,10138,10139,10140}, formation_id=506, support_skill={}, first_award=1110, recommend_force=0, music_id=0, scene_id=205, map_id=3, stage_name="3-8", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,50}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3063}, extra_hero={}, layer=20
},
	[2031]={ name=20001, describe=22531, pre_id=2028, next_id=2032, mon={10151,10152,10153,10154,10155}, formation_id=503, support_skill={}, first_award=1111, recommend_force=0, music_id=0, scene_id=605, map_id=4, stage_name="4-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,50}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=21
},
	[2032]={ name=20002, describe=22532, pre_id=2031, next_id=2033, mon={10156,10157,10158,10159,10160}, formation_id=501, support_skill={}, first_award=1112, recommend_force=0, music_id=0, scene_id=304, map_id=4, stage_name="4-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,51}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=22
},
	[2033]={ name=20003, describe=22533, pre_id=2032, next_id=2034, mon={10161,10162,10163,10164,10165}, formation_id=502, support_skill={}, first_award=1113, recommend_force=0, music_id=0, scene_id=126, map_id=4, stage_name="4-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,52}, suggest_ele={5,2}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=23
},
	[2034]={ name=20004, describe=22534, pre_id=2033, next_id=2035, mon={10166,10167,10168,10169,10170}, formation_id=507, support_skill={}, first_award=1114, recommend_force=0, music_id=0, scene_id=127, map_id=4, stage_name="4-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,53}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=24
},
	[2035]={ name=20005, describe=22535, pre_id=2034, next_id=2036, mon={10171,10172,10173,10174,10175}, formation_id=503, support_skill={}, first_award=1115, recommend_force=0, music_id=0, scene_id=304, map_id=4, stage_name="4-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,54}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=25
},
	[2036]={ name=20006, describe=22536, pre_id=2035, next_id=2037, mon={10176,10177,10178,10179,10180}, formation_id=503, support_skill={}, first_award=1116, recommend_force=0, music_id=0, scene_id=205, map_id=4, stage_name="4-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,55}, suggest_ele={1,4}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=26
},
	[2037]={ name=20007, describe=22537, pre_id=2036, next_id=2038, mon={10181,10182,10183,10184,10185}, formation_id=503, support_skill={}, first_award=1117, recommend_force=0, music_id=0, scene_id=123, map_id=4, stage_name="4-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,56}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=27
},
	[2038]={ name=20008, describe=22538, pre_id=2037, next_id=2039, mon={10186,10187,10188,10189,10190}, formation_id=503, support_skill={}, first_award=1118, recommend_force=0, music_id=0, scene_id=205, map_id=4, stage_name="4-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,57}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=28
},
	[2039]={ name=20009, describe=22539, pre_id=2038, next_id=2040, mon={10191,10192,10193,10194,10195}, formation_id=507, support_skill={}, first_award=1119, recommend_force=0, music_id=0, scene_id=127, map_id=4, stage_name="4-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,58}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003}, extra_hero={}, layer=29
},
	[2040]={ name=20010, describe=22540, pre_id=2039, next_id=2041, mon={10196,10197,10198,10199,10200}, formation_id=502, support_skill={}, first_award=1120, recommend_force=0, music_id=0, scene_id=124, map_id=4, stage_name="4-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,60}, suggest_ele={5,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=30
},
	[2041]={ name=20001, describe=22541, pre_id=2040, next_id=2042, mon={10201,10202,10203,10204,10205}, formation_id=504, support_skill={}, first_award=1101, recommend_force=0, music_id=0, scene_id=304, map_id=5, stage_name="5-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,56}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=31
},
	[2042]={ name=20002, describe=22542, pre_id=2041, next_id=2043, mon={10206,10207,10208,10209,10210}, formation_id=506, support_skill={}, first_award=1102, recommend_force=0, music_id=0, scene_id=123, map_id=5, stage_name="5-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,57}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=32
},
	[2043]={ name=20003, describe=22543, pre_id=2042, next_id=2044, mon={10211,10212,10213,10214,10215}, formation_id=507, support_skill={}, first_award=1103, recommend_force=0, music_id=0, scene_id=203, map_id=5, stage_name="5-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,58}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=33
},
	[2044]={ name=20004, describe=22544, pre_id=2043, next_id=2045, mon={10216,10217,10218,10219,10220}, formation_id=506, support_skill={}, first_award=1104, recommend_force=0, music_id=0, scene_id=124, map_id=5, stage_name="5-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,59}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=34
},
	[2045]={ name=20005, describe=22545, pre_id=2044, next_id=2046, mon={10221,10222,10223,10224,10225}, formation_id=504, support_skill={}, first_award=1105, recommend_force=0, music_id=0, scene_id=201, map_id=5, stage_name="5-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,60}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=35
},
	[2046]={ name=20006, describe=22546, pre_id=2045, next_id=2047, mon={10226,10227,10228,10229,10230}, formation_id=505, support_skill={}, first_award=1106, recommend_force=0, music_id=0, scene_id=124, map_id=5, stage_name="5-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,61}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=36
},
	[2047]={ name=20007, describe=22547, pre_id=2046, next_id=2048, mon={10231,10232,10233,10234,10235}, formation_id=507, support_skill={}, first_award=1107, recommend_force=0, music_id=0, scene_id=201, map_id=5, stage_name="5-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,62}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=37
},
	[2048]={ name=20008, describe=22548, pre_id=2047, next_id=2049, mon={10236,10237,10238,10239,10240}, formation_id=507, support_skill={}, first_award=1108, recommend_force=0, music_id=0, scene_id=203, map_id=5, stage_name="5-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,63}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=38
},
	[2049]={ name=20009, describe=22549, pre_id=2048, next_id=2050, mon={10241,10242,10243,10244,10245}, formation_id=506, support_skill={}, first_award=1109, recommend_force=0, music_id=0, scene_id=304, map_id=5, stage_name="5-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,64}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3066}, extra_hero={}, layer=39
},
	[2050]={ name=20010, describe=22550, pre_id=2049, next_id=2051, mon={10246,10247,10248,10249,10250}, formation_id=507, support_skill={}, first_award=1110, recommend_force=0, music_id=0, scene_id=127, map_id=5, stage_name="5-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,65}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3065,3066}, extra_hero={}, layer=40
},
	[2051]={ name=20001, describe=22551, pre_id=2050, next_id=2052, mon={10251,10252,10253,10254,10255}, formation_id=505, support_skill={}, first_award=1111, recommend_force=0, music_id=0, scene_id=126, map_id=6, stage_name="6-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,60}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=41
},
	[2052]={ name=20002, describe=22552, pre_id=2051, next_id=2053, mon={10256,10257,10258,10259,10260}, formation_id=505, support_skill={}, first_award=1112, recommend_force=0, music_id=0, scene_id=203, map_id=6, stage_name="6-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,61}, suggest_ele={1,0}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=42
},
	[2053]={ name=20003, describe=22553, pre_id=2052, next_id=2054, mon={10261,10262,10263,10264,10265}, formation_id=503, support_skill={}, first_award=1113, recommend_force=0, music_id=0, scene_id=123, map_id=6, stage_name="6-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,62}, suggest_ele={1,0}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=43
},
	[2054]={ name=20004, describe=22554, pre_id=2053, next_id=2055, mon={10266,10267,10268,10269,10270}, formation_id=502, support_skill={}, first_award=1114, recommend_force=0, music_id=0, scene_id=124, map_id=6, stage_name="6-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,63}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=44
},
	[2055]={ name=20005, describe=22555, pre_id=2054, next_id=2056, mon={10271,10272,10273,10274,10275}, formation_id=501, support_skill={}, first_award=1115, recommend_force=0, music_id=0, scene_id=203, map_id=6, stage_name="6-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,64}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=45
},
	[2056]={ name=20006, describe=22556, pre_id=2055, next_id=2057, mon={10276,10277,10278,10279,10280}, formation_id=505, support_skill={}, first_award=1116, recommend_force=0, music_id=0, scene_id=304, map_id=6, stage_name="6-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,65}, suggest_ele={2,5}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=46
},
	[2057]={ name=20007, describe=22557, pre_id=2056, next_id=2058, mon={10281,10282,10283,10284,10285}, formation_id=502, support_skill={}, first_award=1117, recommend_force=0, music_id=0, scene_id=605, map_id=6, stage_name="6-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,66}, suggest_ele={3,1}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=47
},
	[2058]={ name=20008, describe=22558, pre_id=2057, next_id=2059, mon={10286,10287,10288,10289,10290}, formation_id=502, support_skill={}, first_award=1118, recommend_force=0, music_id=0, scene_id=205, map_id=6, stage_name="6-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,67}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=48
},
	[2059]={ name=20009, describe=22559, pre_id=2058, next_id=2060, mon={10291,10292,10293,10294,10295}, formation_id=501, support_skill={}, first_award=1119, recommend_force=0, music_id=0, scene_id=122, map_id=6, stage_name="6-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,68}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3068}, extra_hero={}, layer=49
},
	[2060]={ name=20010, describe=22560, pre_id=2059, next_id=2061, mon={10296,10297,10298,10299,10300}, formation_id=502, support_skill={}, first_award=1120, recommend_force=0, music_id=0, scene_id=205, map_id=6, stage_name="6-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,70}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3067,3068}, extra_hero={}, layer=50
},
	[2061]={ name=20001, describe=22561, pre_id=2060, next_id=2062, mon={10301,10302,10303,10304,10305}, formation_id=504, support_skill={}, first_award=1101, recommend_force=0, music_id=0, scene_id=605, map_id=7, stage_name="7-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,65}, suggest_ele={4,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=51
},
	[2062]={ name=20002, describe=22562, pre_id=2061, next_id=2063, mon={10306,10307,10308,10309,10310}, formation_id=502, support_skill={}, first_award=1102, recommend_force=0, music_id=0, scene_id=304, map_id=7, stage_name="7-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,66}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=52
},
	[2063]={ name=20003, describe=22563, pre_id=2062, next_id=2064, mon={10311,10312,10313,10314,10315}, formation_id=505, support_skill={}, first_award=1103, recommend_force=0, music_id=0, scene_id=126, map_id=7, stage_name="7-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,67}, suggest_ele={0,3}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=53
},
	[2064]={ name=20004, describe=22564, pre_id=2063, next_id=2065, mon={10316,10317,10318,10319,10320}, formation_id=507, support_skill={}, first_award=1104, recommend_force=0, music_id=0, scene_id=127, map_id=7, stage_name="7-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,68}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=54
},
	[2065]={ name=20005, describe=22565, pre_id=2064, next_id=2066, mon={10321,10322,10323,10324,10325}, formation_id=502, support_skill={}, first_award=1105, recommend_force=0, music_id=0, scene_id=304, map_id=7, stage_name="7-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,69}, suggest_ele={1,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=55
},
	[2066]={ name=20006, describe=22566, pre_id=2065, next_id=2067, mon={10326,10327,10328,10329,10330}, formation_id=501, support_skill={}, first_award=1106, recommend_force=0, music_id=0, scene_id=205, map_id=7, stage_name="7-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,70}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=56
},
	[2067]={ name=20007, describe=22567, pre_id=2066, next_id=2068, mon={10331,10332,10333,10334,10335}, formation_id=505, support_skill={}, first_award=1107, recommend_force=0, music_id=0, scene_id=123, map_id=7, stage_name="7-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,71}, suggest_ele={4,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=57
},
	[2068]={ name=20008, describe=22568, pre_id=2067, next_id=2069, mon={10336,10337,10338,10339,10340}, formation_id=507, support_skill={}, first_award=1108, recommend_force=0, music_id=0, scene_id=205, map_id=7, stage_name="7-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,72}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=58
},
	[2069]={ name=20009, describe=22569, pre_id=2068, next_id=2070, mon={10341,10342,10343,10344,10345}, formation_id=502, support_skill={}, first_award=1109, recommend_force=0, music_id=0, scene_id=127, map_id=7, stage_name="7-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,73}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=59
},
	[2070]={ name=20010, describe=22570, pre_id=2069, next_id=2071, mon={10346,10347,10348,10349,10350}, formation_id=503, support_skill={}, first_award=1110, recommend_force=0, music_id=0, scene_id=124, map_id=7, stage_name="7-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,75}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3065,3064}, extra_hero={}, layer=60
},
	[2071]={ name=20001, describe=22571, pre_id=2070, next_id=2072, mon={10351,10352,10353,10354,10355}, formation_id=504, support_skill={}, first_award=1111, recommend_force=0, music_id=0, scene_id=304, map_id=8, stage_name="8-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,70}, suggest_ele={4,0}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=61
},
	[2072]={ name=20002, describe=22572, pre_id=2071, next_id=2073, mon={10356,10357,10358,10359,10360}, formation_id=507, support_skill={}, first_award=1112, recommend_force=0, music_id=0, scene_id=123, map_id=8, stage_name="8-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,71}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=62
},
	[2073]={ name=20003, describe=22573, pre_id=2072, next_id=2074, mon={10361,10362,10363,10364,10365}, formation_id=506, support_skill={}, first_award=1113, recommend_force=0, music_id=0, scene_id=203, map_id=8, stage_name="8-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,72}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=63
},
	[2074]={ name=20004, describe=22574, pre_id=2073, next_id=2075, mon={10366,10367,10368,10369,10370}, formation_id=502, support_skill={}, first_award=1114, recommend_force=0, music_id=0, scene_id=124, map_id=8, stage_name="8-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,73}, suggest_ele={4,0}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=64
},
	[2075]={ name=20005, describe=22575, pre_id=2074, next_id=2076, mon={10371,10372,10373,10374,10375}, formation_id=505, support_skill={}, first_award=1115, recommend_force=0, music_id=0, scene_id=201, map_id=8, stage_name="8-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,74}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=65
},
	[2076]={ name=20006, describe=22576, pre_id=2075, next_id=2077, mon={10376,10377,10378,10379,10380}, formation_id=507, support_skill={}, first_award=1116, recommend_force=0, music_id=0, scene_id=124, map_id=8, stage_name="8-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,75}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=66
},
	[2077]={ name=20007, describe=22577, pre_id=2076, next_id=2078, mon={10381,10382,10383,10384,10385}, formation_id=507, support_skill={}, first_award=1117, recommend_force=0, music_id=0, scene_id=201, map_id=8, stage_name="8-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,76}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=67
},
	[2078]={ name=20008, describe=22578, pre_id=2077, next_id=2079, mon={10386,10387,10388,10389,10390}, formation_id=501, support_skill={}, first_award=1118, recommend_force=0, music_id=0, scene_id=203, map_id=8, stage_name="8-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,77}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=68
},
	[2079]={ name=20009, describe=22579, pre_id=2078, next_id=2080, mon={10391,10392,10393,10394,10395}, formation_id=502, support_skill={}, first_award=1119, recommend_force=0, music_id=0, scene_id=304, map_id=8, stage_name="8-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,78}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3049}, extra_hero={}, layer=69
},
	[2080]={ name=20010, describe=22580, pre_id=2079, next_id=2081, mon={10396,10397,10398,10399,10400}, formation_id=505, support_skill={}, first_award=1120, recommend_force=0, music_id=0, scene_id=127, map_id=8, stage_name="8-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,3}, lock_formation=0, pos_effect_id={3069,3049}, extra_hero={}, layer=70
},
	[2081]={ name=20001, describe=22581, pre_id=2080, next_id=2082, mon={10401,10402,10403,10404,10405}, formation_id=506, support_skill={}, first_award=1101, recommend_force=0, music_id=0, scene_id=126, map_id=9, stage_name="9-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,75}, suggest_ele={2,0,3}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=71
},
	[2082]={ name=20002, describe=22582, pre_id=2081, next_id=2083, mon={10406,10407,10408,10409,10410}, formation_id=504, support_skill={}, first_award=1102, recommend_force=0, music_id=0, scene_id=203, map_id=9, stage_name="9-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,76}, suggest_ele={3,0,1}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=72
},
	[2083]={ name=20003, describe=22583, pre_id=2082, next_id=2084, mon={10411,10412,10413,10414,10415}, formation_id=506, support_skill={}, first_award=1103, recommend_force=0, music_id=0, scene_id=123, map_id=9, stage_name="9-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,77}, suggest_ele={0,2,1}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=73
},
	[2084]={ name=20004, describe=22584, pre_id=2083, next_id=2085, mon={10416,10417,10418,10419,10420}, formation_id=506, support_skill={}, first_award=1104, recommend_force=0, music_id=0, scene_id=124, map_id=9, stage_name="9-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,78}, suggest_ele={2,0,3}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=74
},
	[2085]={ name=20005, describe=22585, pre_id=2084, next_id=2086, mon={10421,10422,10423,10424,10425}, formation_id=505, support_skill={}, first_award=1105, recommend_force=0, music_id=0, scene_id=203, map_id=9, stage_name="9-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,79}, suggest_ele={1,2,0}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=75
},
	[2086]={ name=20006, describe=22586, pre_id=2085, next_id=2087, mon={10426,10427,10428,10429,10430}, formation_id=503, support_skill={}, first_award=1106, recommend_force=0, music_id=0, scene_id=304, map_id=9, stage_name="9-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,3,0}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=76
},
	[2087]={ name=20007, describe=22587, pre_id=2086, next_id=2088, mon={10431,10432,10433,10434,10435}, formation_id=504, support_skill={}, first_award=1107, recommend_force=0, music_id=0, scene_id=605, map_id=9, stage_name="9-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1,2}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=77
},
	[2088]={ name=20008, describe=22588, pre_id=2087, next_id=2089, mon={10436,10437,10438,10439,10440}, formation_id=503, support_skill={}, first_award=1108, recommend_force=0, music_id=0, scene_id=205, map_id=9, stage_name="9-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,2,1}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=78
},
	[2089]={ name=20009, describe=22589, pre_id=2088, next_id=2090, mon={10441,10442,10443,10444,10445}, formation_id=505, support_skill={}, first_award=1109, recommend_force=0, music_id=0, scene_id=122, map_id=9, stage_name="9-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,0,1}, lock_formation=0, pos_effect_id={3003,3048}, extra_hero={}, layer=79
},
	[2090]={ name=20010, describe=22590, pre_id=2089, next_id=2091, mon={10446,10447,10448,10449,10450}, formation_id=503, support_skill={}, first_award=1110, recommend_force=0, music_id=0, scene_id=205, map_id=9, stage_name="9-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,0,2}, lock_formation=0, pos_effect_id={3004,3048}, extra_hero={}, layer=80
},
	[2091]={ name=20001, describe=22591, pre_id=2090, next_id=2092, mon={10451,10452,10453,10454,10455}, formation_id=501, support_skill={}, first_award=1111, recommend_force=0, music_id=0, scene_id=605, map_id=10, stage_name="10-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=81
},
	[2092]={ name=20002, describe=22592, pre_id=2091, next_id=2093, mon={10456,10457,10458,10459,10460}, formation_id=504, support_skill={}, first_award=1112, recommend_force=0, music_id=0, scene_id=304, map_id=10, stage_name="10-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=82
},
	[2093]={ name=20003, describe=22593, pre_id=2092, next_id=2094, mon={10461,10462,10463,10464,10465}, formation_id=504, support_skill={}, first_award=1113, recommend_force=0, music_id=0, scene_id=126, map_id=10, stage_name="10-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=83
},
	[2094]={ name=20004, describe=22594, pre_id=2093, next_id=2095, mon={10466,10467,10468,10469,10470}, formation_id=506, support_skill={}, first_award=1114, recommend_force=0, music_id=0, scene_id=127, map_id=10, stage_name="10-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=84
},
	[2095]={ name=20005, describe=22595, pre_id=2094, next_id=2096, mon={10471,10472,10473,10474,10475}, formation_id=506, support_skill={}, first_award=1115, recommend_force=0, music_id=0, scene_id=304, map_id=10, stage_name="10-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=85
},
	[2096]={ name=20006, describe=22596, pre_id=2095, next_id=2097, mon={10476,10477,10478,10479,10480}, formation_id=504, support_skill={}, first_award=1116, recommend_force=0, music_id=0, scene_id=205, map_id=10, stage_name="10-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=86
},
	[2097]={ name=20007, describe=22597, pre_id=2096, next_id=2098, mon={10481,10482,10483,10484,10485}, formation_id=503, support_skill={}, first_award=1117, recommend_force=0, music_id=0, scene_id=123, map_id=10, stage_name="10-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=87
},
	[2098]={ name=20008, describe=22598, pre_id=2097, next_id=2099, mon={10486,10487,10488,10489,10490}, formation_id=502, support_skill={}, first_award=1118, recommend_force=0, music_id=0, scene_id=205, map_id=10, stage_name="10-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=88
},
	[2099]={ name=20009, describe=22599, pre_id=2098, next_id=2100, mon={10491,10492,10493,10494,10495}, formation_id=506, support_skill={}, first_award=1119, recommend_force=0, music_id=0, scene_id=127, map_id=10, stage_name="10-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3003,3064}, extra_hero={}, layer=89
},
	[2100]={ name=20010, describe=22600, pre_id=2099, next_id=2101, mon={10496,10497,10498,10499,10500}, formation_id=504, support_skill={}, first_award=1120, recommend_force=0, music_id=0, scene_id=124, map_id=10, stage_name="10-10", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3005,3064}, extra_hero={}, layer=90
},
	[2101]={ name=24519, describe=24621, pre_id=2100, next_id=2102, mon={10501,10502,10503,10504,10505}, formation_id=505, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-1", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3070,3083}, extra_hero={}, layer=91
},
	[2102]={ name=24520, describe=24622, pre_id=2101, next_id=2103, mon={10506,10507,10508,10509,10510}, formation_id=502, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-2", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3070,3083}, extra_hero={}, layer=92
},
	[2103]={ name=24521, describe=24623, pre_id=2102, next_id=2104, mon={10511,10512,10513,10514,10515}, formation_id=504, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-3", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3070,3083}, extra_hero={}, layer=93
},
	[2104]={ name=24522, describe=24624, pre_id=2103, next_id=2105, mon={10516,10517,10518,10519,10520}, formation_id=507, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-4", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3070,3083}, extra_hero={}, layer=94
},
	[2105]={ name=24523, describe=24625, pre_id=2104, next_id=2106, mon={10521,10522,10523,10524,10525}, formation_id=501, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-5", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3070,3083}, extra_hero={}, layer=95
},
	[2106]={ name=24524, describe=24626, pre_id=2105, next_id=2107, mon={10526,10527,10528,10529,10530}, formation_id=503, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-6", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3071,3083}, extra_hero={}, layer=96
},
	[2107]={ name=24525, describe=24627, pre_id=2106, next_id=2108, mon={10531,10532,10533,10534,10535}, formation_id=508, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-7", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3071,3083}, extra_hero={}, layer=97
},
	[2108]={ name=24526, describe=24628, pre_id=2107, next_id=2109, mon={10536,10537,10538,10539,10540}, formation_id=509, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-8", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3071,3083}, extra_hero={}, layer=98
},
	[2109]={ name=24527, describe=24629, pre_id=2108, next_id=2110, mon={10541,10542,10543,10544,10545}, formation_id=507, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-9", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3071,3083}, extra_hero={}, layer=99
},
	[2110]={ name=24528, describe=24630, pre_id=2109, next_id=2111, mon={10546,10547,10548,10549,10550}, formation_id=509, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-10", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3072,3084}, extra_hero={}, layer=100
},
	[2111]={ name=24529, describe=24631, pre_id=2110, next_id=2112, mon={10551,10552,10553,10554,10555}, formation_id=509, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-11", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=101
},
	[2112]={ name=24530, describe=24632, pre_id=2111, next_id=2113, mon={10556,10557,10558,10559,10560}, formation_id=505, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-12", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=102
},
	[2113]={ name=24531, describe=24633, pre_id=2112, next_id=2114, mon={10561,10562,10563,10564,10565}, formation_id=504, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-13", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=103
},
	[2114]={ name=24532, describe=24634, pre_id=2113, next_id=2115, mon={10566,10567,10568,10569,10570}, formation_id=504, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-14", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=104
},
	[2115]={ name=24533, describe=24635, pre_id=2114, next_id=2116, mon={10571,10572,10573,10574,10575}, formation_id=506, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-15", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=105
},
	[2116]={ name=24534, describe=24636, pre_id=2115, next_id=2117, mon={10576,10577,10578,10579,10580}, formation_id=502, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-16", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=106
},
	[2117]={ name=24535, describe=24637, pre_id=2116, next_id=2118, mon={10581,10582,10583,10584,10585}, formation_id=501, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-17", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=107
},
	[2118]={ name=24536, describe=24638, pre_id=2117, next_id=2119, mon={10586,10587,10588,10589,10590}, formation_id=505, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-18", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=108
},
	[2119]={ name=24537, describe=24639, pre_id=2118, next_id=2120, mon={10591,10592,10593,10594,10595}, formation_id=506, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-19", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3073,3085}, extra_hero={}, layer=109
},
	[2120]={ name=24538, describe=24640, pre_id=2119, next_id=2121, mon={10596,10597,10598,10599,10600}, formation_id=503, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-20", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3074,3086}, extra_hero={}, layer=110
},
	[2121]={ name=24539, describe=24641, pre_id=2120, next_id=2122, mon={10601,10602,10603,10604,10605}, formation_id=508, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-21", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=111
},
	[2122]={ name=24540, describe=24642, pre_id=2121, next_id=2123, mon={10606,10607,10608,10609,10610}, formation_id=506, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-22", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=112
},
	[2123]={ name=24541, describe=24643, pre_id=2122, next_id=2124, mon={10611,10612,10613,10614,10615}, formation_id=506, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-23", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=113
},
	[2124]={ name=24542, describe=24644, pre_id=2123, next_id=2125, mon={10616,10617,10618,10619,10620}, formation_id=503, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-24", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=114
},
	[2125]={ name=24543, describe=24645, pre_id=2124, next_id=2126, mon={10621,10622,10623,10624,10625}, formation_id=506, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-25", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=115
},
	[2126]={ name=24544, describe=24646, pre_id=2125, next_id=2127, mon={10626,10627,10628,10629,10630}, formation_id=505, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-26", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=116
},
	[2127]={ name=24545, describe=24647, pre_id=2126, next_id=2128, mon={10631,10632,10633,10634,10635}, formation_id=507, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-27", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=117
},
	[2128]={ name=24546, describe=24648, pre_id=2127, next_id=2129, mon={10636,10637,10638,10639,10640}, formation_id=508, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-28", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=118
},
	[2129]={ name=24547, describe=24649, pre_id=2128, next_id=2130, mon={10641,10642,10643,10644,10645}, formation_id=507, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-29", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3075,3087}, extra_hero={}, layer=119
},
	[2130]={ name=24548, describe=24650, pre_id=2129, next_id=2131, mon={10646,10647,10648,10649,10650}, formation_id=502, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-30", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3076,3088}, extra_hero={}, layer=120
},
	[2131]={ name=24549, describe=24651, pre_id=2130, next_id=2132, mon={10651,10652,10653,10654,10655}, formation_id=503, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-31", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=121
},
	[2132]={ name=24550, describe=24652, pre_id=2131, next_id=2133, mon={10656,10657,10658,10659,10660}, formation_id=503, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-32", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=122
},
	[2133]={ name=24551, describe=24653, pre_id=2132, next_id=2134, mon={10661,10662,10663,10664,10665}, formation_id=504, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-33", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=123
},
	[2134]={ name=24552, describe=24654, pre_id=2133, next_id=2135, mon={10666,10667,10668,10669,10670}, formation_id=506, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-34", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=124
},
	[2135]={ name=24553, describe=24655, pre_id=2134, next_id=2136, mon={10671,10672,10673,10674,10675}, formation_id=506, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-35", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=125
},
	[2136]={ name=24554, describe=24656, pre_id=2135, next_id=2137, mon={10676,10677,10678,10679,10680}, formation_id=507, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-36", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=126
},
	[2137]={ name=24555, describe=24657, pre_id=2136, next_id=2138, mon={10681,10682,10683,10684,10685}, formation_id=501, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-37", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=127
},
	[2138]={ name=24556, describe=24658, pre_id=2137, next_id=2139, mon={10686,10687,10688,10689,10690}, formation_id=504, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-38", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=128
},
	[2139]={ name=24557, describe=24659, pre_id=2138, next_id=2140, mon={10691,10692,10693,10694,10695}, formation_id=504, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-39", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3077,3089}, extra_hero={}, layer=129
},
	[2140]={ name=24558, describe=24660, pre_id=2139, next_id=2141, mon={10696,10697,10698,10699,10700}, formation_id=501, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-40", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3078,3090}, extra_hero={}, layer=130
},
	[2141]={ name=24559, describe=24661, pre_id=2140, next_id=2142, mon={10701,10702,10703,10704,10705}, formation_id=501, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-41", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=131
},
	[2142]={ name=24560, describe=24662, pre_id=2141, next_id=2143, mon={10706,10707,10708,10709,10710}, formation_id=501, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-42", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=132
},
	[2143]={ name=24561, describe=24663, pre_id=2142, next_id=2144, mon={10711,10712,10713,10714,10715}, formation_id=502, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-43", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=133
},
	[2144]={ name=24562, describe=24664, pre_id=2143, next_id=2145, mon={10716,10717,10718,10719,10720}, formation_id=507, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-44", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=134
},
	[2145]={ name=24563, describe=24665, pre_id=2144, next_id=2146, mon={10721,10722,10723,10724,10725}, formation_id=503, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-45", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=135
},
	[2146]={ name=24564, describe=24666, pre_id=2145, next_id=2147, mon={10726,10727,10728,10729,10730}, formation_id=501, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-46", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=136
},
	[2147]={ name=24565, describe=24667, pre_id=2146, next_id=2148, mon={10731,10732,10733,10734,10735}, formation_id=503, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-47", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=137
},
	[2148]={ name=24566, describe=24668, pre_id=2147, next_id=2149, mon={10736,10737,10738,10739,10740}, formation_id=503, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-48", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=138
},
	[2149]={ name=24567, describe=24669, pre_id=2148, next_id=2150, mon={10741,10742,10743,10744,10745}, formation_id=503, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-49", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,5}, lock_formation=0, pos_effect_id={3079,3091}, extra_hero={}, layer=139
},
	[2150]={ name=24568, describe=24670, pre_id=2149, next_id=2151, mon={10746,10747,10748,10749,10750}, formation_id=508, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-50", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3080,3092}, extra_hero={}, layer=140
},
	[2151]={ name=24569, describe=24671, pre_id=2150, next_id=2152, mon={10751,10752,10753,10754,10755}, formation_id=505, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-51", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=141
},
	[2152]={ name=24570, describe=24672, pre_id=2151, next_id=2153, mon={10756,10757,10758,10759,10760}, formation_id=502, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-52", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,2}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=142
},
	[2153]={ name=24571, describe=24673, pre_id=2152, next_id=2154, mon={10761,10762,10763,10764,10765}, formation_id=505, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-53", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=143
},
	[2154]={ name=24572, describe=24674, pre_id=2153, next_id=2155, mon={10766,10767,10768,10769,10770}, formation_id=504, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-54", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=144
},
	[2155]={ name=24573, describe=24675, pre_id=2154, next_id=2156, mon={10771,10772,10773,10774,10775}, formation_id=508, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-55", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=145
},
	[2156]={ name=24574, describe=24676, pre_id=2155, next_id=2157, mon={10776,10777,10778,10779,10780}, formation_id=504, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-56", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=146
},
	[2157]={ name=24575, describe=24677, pre_id=2156, next_id=2158, mon={10781,10782,10783,10784,10785}, formation_id=504, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-57", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=147
},
	[2158]={ name=24576, describe=24678, pre_id=2157, next_id=2159, mon={10786,10787,10788,10789,10790}, formation_id=505, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-58", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=148
},
	[2159]={ name=24577, describe=24679, pre_id=2158, next_id=2160, mon={10791,10792,10793,10794,10795}, formation_id=508, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-59", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,3}, lock_formation=0, pos_effect_id={3081,3093}, extra_hero={}, layer=149
},
	[2160]={ name=24578, describe=24680, pre_id=2159, next_id=2161, mon={10796,10797,10798,10799,10800}, formation_id=505, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-60", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={3082,3094}, extra_hero={}, layer=150
},
	[2161]={ name=24579, describe=24921, pre_id=2160, next_id=2162, mon={10801,10802,10803,10804,10805}, formation_id=505, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-61", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=151
},
	[2162]={ name=24580, describe=24922, pre_id=2161, next_id=2163, mon={10806,10807,10808,10809,10810}, formation_id=509, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-62", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,1}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=152
},
	[2163]={ name=24581, describe=24923, pre_id=2162, next_id=2164, mon={10811,10812,10813,10814,10815}, formation_id=501, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-63", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,4}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=153
},
	[2164]={ name=24582, describe=24924, pre_id=2163, next_id=2165, mon={10816,10817,10818,10819,10820}, formation_id=503, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-64", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,3}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=154
},
	[2165]={ name=24583, describe=24925, pre_id=2164, next_id=2166, mon={10821,10822,10823,10824,10825}, formation_id=506, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-65", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=155
},
	[2166]={ name=24584, describe=24926, pre_id=2165, next_id=2167, mon={10826,10827,10828,10829,10830}, formation_id=501, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-66", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=156
},
	[2167]={ name=24585, describe=24927, pre_id=2166, next_id=2168, mon={10831,10832,10833,10834,10835}, formation_id=501, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-67", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,5}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=157
},
	[2168]={ name=24586, describe=24928, pre_id=2167, next_id=2169, mon={10836,10837,10838,10839,10840}, formation_id=501, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-68", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=158
},
	[2169]={ name=24587, describe=24929, pre_id=2168, next_id=2170, mon={10841,10842,10843,10844,10845}, formation_id=506, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-69", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30000,30008}, extra_hero={}, layer=159
},
	[2170]={ name=24588, describe=24930, pre_id=2169, next_id=2171, mon={10846,10847,10848,10849,10850}, formation_id=505, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-70", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,3}, lock_formation=0, pos_effect_id={30001,30009}, extra_hero={}, layer=160
},
	[2171]={ name=24589, describe=24931, pre_id=2170, next_id=2172, mon={10851,10852,10853,10854,10855}, formation_id=503, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-71", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=161
},
	[2172]={ name=24590, describe=24932, pre_id=2171, next_id=2173, mon={10856,10857,10858,10859,10860}, formation_id=503, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-72", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=162
},
	[2173]={ name=24591, describe=24933, pre_id=2172, next_id=2174, mon={10861,10862,10863,10864,10865}, formation_id=509, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-73", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=163
},
	[2174]={ name=24592, describe=24934, pre_id=2173, next_id=2175, mon={10866,10867,10868,10869,10870}, formation_id=505, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-74", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,1}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=164
},
	[2175]={ name=24593, describe=24935, pre_id=2174, next_id=2176, mon={10871,10872,10873,10874,10875}, formation_id=506, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-75", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,3}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=165
},
	[2176]={ name=24594, describe=24936, pre_id=2175, next_id=2177, mon={10876,10877,10878,10879,10880}, formation_id=505, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-76", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,4}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=166
},
	[2177]={ name=24595, describe=24937, pre_id=2176, next_id=2178, mon={10881,10882,10883,10884,10885}, formation_id=509, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-77", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=167
},
	[2178]={ name=24596, describe=24938, pre_id=2177, next_id=2179, mon={10886,10887,10888,10889,10890}, formation_id=506, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-78", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,5}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=168
},
	[2179]={ name=24597, describe=24939, pre_id=2178, next_id=2180, mon={10891,10892,10893,10894,10895}, formation_id=505, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-79", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,5}, lock_formation=0, pos_effect_id={30002,30010}, extra_hero={}, layer=169
},
	[2180]={ name=24598, describe=24940, pre_id=2179, next_id=2181, mon={10896,10897,10898,10899,10900}, formation_id=503, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-80", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30003,30011}, extra_hero={}, layer=170
},
	[2181]={ name=24599, describe=24941, pre_id=2180, next_id=2182, mon={10901,10902,10903,10904,10905}, formation_id=509, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-81", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,4}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=171
},
	[2182]={ name=24600, describe=24942, pre_id=2181, next_id=2183, mon={10906,10907,10908,10909,10910}, formation_id=509, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-82", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,4}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=172
},
	[2183]={ name=24601, describe=24943, pre_id=2182, next_id=2184, mon={10911,10912,10913,10914,10915}, formation_id=501, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-83", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,3}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=173
},
	[2184]={ name=24602, describe=24944, pre_id=2183, next_id=2185, mon={10916,10917,10918,10919,10920}, formation_id=501, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-84", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=174
},
	[2185]={ name=24603, describe=24945, pre_id=2184, next_id=2186, mon={10921,10922,10923,10924,10925}, formation_id=502, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-85", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=175
},
	[2186]={ name=24604, describe=24946, pre_id=2185, next_id=2187, mon={10926,10927,10928,10929,10930}, formation_id=507, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-86", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,3}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=176
},
	[2187]={ name=24605, describe=24947, pre_id=2186, next_id=2188, mon={10931,10932,10933,10934,10935}, formation_id=507, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-87", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,3}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=177
},
	[2188]={ name=24606, describe=24948, pre_id=2187, next_id=2189, mon={10936,10937,10938,10939,10940}, formation_id=501, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-88", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,2}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=178
},
	[2189]={ name=24607, describe=24949, pre_id=2188, next_id=2190, mon={10941,10942,10943,10944,10945}, formation_id=509, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-89", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,0}, lock_formation=0, pos_effect_id={30004,30012}, extra_hero={}, layer=179
},
	[2190]={ name=24608, describe=24950, pre_id=2189, next_id=2191, mon={10948,10946,10947,10949,10950}, formation_id=509, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-90", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,3}, lock_formation=0, pos_effect_id={30005,30013}, extra_hero={}, layer=180
},
	[2191]={ name=24609, describe=24951, pre_id=2190, next_id=2192, mon={10951,10952,10953,10954,10955}, formation_id=505, support_skill={}, first_award=1121, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-91", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,5}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=181
},
	[2192]={ name=24610, describe=24952, pre_id=2191, next_id=2193, mon={10956,10957,10958,10959,10960}, formation_id=507, support_skill={}, first_award=1122, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-92", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,1}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=182
},
	[2193]={ name=24611, describe=24953, pre_id=2192, next_id=2194, mon={10961,10962,10963,10964,10965}, formation_id=503, support_skill={}, first_award=1123, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-93", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,0}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=183
},
	[2194]={ name=24612, describe=24954, pre_id=2193, next_id=2195, mon={10966,10967,10968,10969,10970}, formation_id=507, support_skill={}, first_award=1124, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-94", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={0,1}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=184
},
	[2195]={ name=24613, describe=24955, pre_id=2194, next_id=2196, mon={10971,10972,10973,10974,10975}, formation_id=501, support_skill={}, first_award=1125, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-95", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,5}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=185
},
	[2196]={ name=24614, describe=24956, pre_id=2195, next_id=2197, mon={10976,10977,10978,10979,10980}, formation_id=502, support_skill={}, first_award=1126, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-96", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={5,2}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=186
},
	[2197]={ name=24615, describe=24957, pre_id=2196, next_id=2198, mon={10981,10982,10983,10984,10985}, formation_id=505, support_skill={}, first_award=1127, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-97", point_line=2, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=187
},
	[2198]={ name=24616, describe=24958, pre_id=2197, next_id=2199, mon={10986,10987,10988,10989,10990}, formation_id=507, support_skill={}, first_award=1128, recommend_force=0, music_id=0, scene_id=123, map_id=11, stage_name="EX-98", point_line=1, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={2,1}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=188
},
	[2199]={ name=24617, describe=24959, pre_id=2198, next_id=2200, mon={10991,10992,10993,10994,10995}, formation_id=507, support_skill={}, first_award=1129, recommend_force=0, music_id=0, scene_id=205, map_id=11, stage_name="EX-99", point_line=3, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={1,4}, lock_formation=0, pos_effect_id={30006,30014}, extra_hero={}, layer=189
},
	[2200]={ name=24618, describe=24960, pre_id=2199, next_id=0, mon={10996,10997,10998,10999,11000}, formation_id=506, support_skill={}, first_award=1130, recommend_force=0, music_id=0, scene_id=127, map_id=11, stage_name="EX-100", point_line=0, boss_id=0, boss_cha={}, suggest_level={0,80}, suggest_ele={3,4}, lock_formation=0, pos_effect_id={30007,30015}, extra_hero={}, layer=190
}
}

return climb_tower_dup_data