-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\ResHookScript.lua

local RT = {}

RT[1] = {
	"Timeline_AVG_jiedao"
}
RT[2] = {
	0,
	0,
	0,
	10504022,
	0,
	10504022,
	0,
	10204021,
	0
}
RT[3] = {
	0,
	0,
	0,
	2,
	0,
	2,
	0,
	6,
	0
}
RT[4] = {
	10304012,
	10304011,
	10304012,
	0,
	0,
	0,
	10304012,
	0,
	10304012
}
RT[5] = {
	2,
	6,
	2,
	0,
	0,
	0,
	3,
	0,
	4
}
RT[6] = {
	0,
	10104031,
	0,
	0,
	0,
	0,
	10204032,
	0,
	10204032
}
RT[7] = {
	0,
	6,
	0,
	0,
	0,
	0,
	2,
	0,
	3
}
RT[8] = {
	213101,
	211003,
	212005,
	214006,
	213004,
	212002,
	212001,
	213001,
	213002,
	213003,
	214003,
	215002,
	215003,
	211101,
	214011
}
RT[9] = {
	"211003_1",
	"212005_1",
	"214006_1",
	"214003_1",
	"215003_1"
}
RT[10] = {
	211001,
	211003,
	211006,
	212001,
	212003,
	212005,
	213001,
	213003,
	213006,
	214002,
	214004,
	214005,
	215001,
	215004,
	215006
}

local Data = {
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 5,
		id = 1,
		scene_id = 6,
		camera = "StagePerformCamera1000.anim",
		timeline_node = RT[1]
	},
	{
		id = 2,
		delay_time = 0,
		dynamic_path = "battle_jiedao_001/zhaopai_chunk_3.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 6,
		camera = "StagePerformCamera1002.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 3,
		end_node = "StopPoint_2",
		monsters = RT[2],
		no_die_time = RT[3]
	},
	{
		id = 3,
		delay_time = 0,
		dynamic_path = "battle_jiedao_001/yangtai_chunk_1.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 6,
		camera = "StagePerformCamera1003.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 211,
		end_node = "StopPoint_3",
		monsters = RT[4],
		no_die_time = RT[5]
	},
	{
		id = 4,
		delay_time = 0,
		dynamic_path = "battle_jiedao_001/chongwufanwan_chunk_2.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 6,
		camera = "StagePerformCamera1004.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 5,
		end_node = "StopPoint_1",
		monsters = RT[6],
		no_die_time = RT[7]
	},
	{
		next_script = 2,
		delay_time = 0,
		scene_id = 6,
		camera = "StagePerformCameraguaji1001.anim",
		shadow_dist = 25,
		id = 5,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_jiedao",
			"Timeline_egg_jiedao_apple",
			"Timeline_egg_jiedao_Cans",
			"Timeline_egg_jiedao_football",
			"Timeline_egg_jiedao_soccer",
			"Timeline_egg_jiedao_tennis",
			"Timeline_egg_jiedao_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 20,
		next_script = 10,
		id = 6,
		scene_id = 5,
		camera = "StagePerformCamera2000.anim",
		timeline_node = {
			"Timeline_AVG_youleyuan"
		}
	},
	{
		id = 7,
		delay_time = 0,
		dynamic_path = "battle_youleyuan_001/huatan_chunk_2.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 5,
		camera = "StagePerformCamera2002.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 8,
		end_node = "StopPoint_2",
		monsters = {
			0,
			10104051,
			0,
			0,
			10304052,
			0,
			10304052,
			10304052,
			10304052
		},
		no_die_time = {
			0,
			6,
			0,
			0,
			1,
			0,
			2,
			4,
			3
		}
	},
	{
		id = 8,
		delay_time = 0,
		dynamic_path = "battle_youleyuan_001/qinshuitai_chunk_3.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 5,
		camera = "StagePerformCamera2003.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 221,
		end_node = "StopPoint_3",
		monsters = {
			0,
			10204061,
			0,
			0,
			10504062,
			0,
			10504062,
			10504062,
			10504062
		},
		no_die_time = {
			0,
			6,
			0,
			0,
			2,
			0,
			3,
			4,
			3
		}
	},
	{
		id = 9,
		delay_time = 0,
		dynamic_path = "battle_youleyuan_001/taiyangsan_chunk_1.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 5,
		camera = "StagePerformCamera2004.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 10,
		end_node = "StopPoint_1",
		monsters = {
			0,
			10504041,
			0,
			0,
			0,
			0,
			10504042,
			10504042,
			10504042
		},
		no_die_time = {
			0,
			6,
			0,
			0,
			0,
			0,
			2,
			3,
			4
		}
	},
	{
		next_script = 7,
		delay_time = 0,
		scene_id = 5,
		camera = "StagePerformCameraguaji1002.anim",
		shadow_dist = 25,
		id = 10,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_youleyuan",
			"Timeline_egg_youleyuan_apple",
			"Timeline_egg_youleyuan_Cans",
			"Timeline_egg_youleyuan_football",
			"Timeline_egg_youleyuan_soccer",
			"Timeline_egg_youleyuan_tennis",
			"Timeline_egg_youleyuan_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 20,
		next_script = 15,
		id = 11,
		scene_id = 1,
		camera = "StagePerformCamera3000.anim",
		timeline_node = {
			"Timeline_AVG_dachangjing"
		}
	},
	{
		id = 12,
		delay_time = 0,
		dynamic_path = "battle_dachangjing_01/malujinggai_chunk_1.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 1,
		camera = "StagePerformCamera3002.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 13,
		end_node = "StopPoint_2",
		monsters = {
			10204082,
			10204082,
			10204082,
			10304081,
			0,
			10304081,
			0,
			0,
			0
		},
		no_die_time = {
			1,
			1,
			1,
			6,
			0,
			7,
			0,
			0,
			0
		}
	},
	{
		id = 13,
		delay_time = 0,
		dynamic_path = "battle_dachangjing_01/malujinggai_chunk_1.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 1,
		camera = "StagePerformCamera3003.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 231,
		end_node = "StopPoint_3",
		monsters = {
			10504092,
			0,
			10504092,
			0,
			10304091,
			0,
			10504092,
			0,
			10504092
		},
		no_die_time = {
			1,
			0,
			1,
			0,
			6,
			0,
			3,
			0,
			3
		}
	},
	{
		id = 14,
		delay_time = 0,
		dynamic_path = "battle_dachangjing_01/malujinggai_chunk_1.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 1,
		camera = "StagePerformCamera3004.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 15,
		end_node = "StopPoint_1",
		monsters = {
			10204071,
			0,
			10204071,
			0,
			0,
			0,
			10504072,
			10504072,
			10504072
		},
		no_die_time = {
			6,
			0,
			6,
			0,
			0,
			0,
			2,
			3,
			4
		}
	},
	{
		next_script = 12,
		delay_time = 0,
		scene_id = 1,
		camera = "StagePerformCameraguaji1003.anim",
		shadow_dist = 25,
		id = 15,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_dachangjing",
			"Timeline_egg_dachangjing_apple",
			"Timeline_egg_dachangjing_Cans",
			"Timeline_egg_dachangjing_football",
			"Timeline_egg_dachangjing_soccer",
			"Timeline_egg_dachangjing_tennis",
			"Timeline_egg_dachangjing_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 20,
		next_script = 20,
		id = 16,
		scene_id = 9,
		camera = "StagePerformCamera4000.anim",
		timeline_node = {
			"Timeline_AVG_feiting"
		}
	},
	{
		id = 17,
		delay_time = 0,
		dynamic_path = "battle_feiting_01/bridge_chunk_1.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 9,
		camera = "StagePerformCamera4002.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 21,
		end_node = "StopPoint_2",
		monsters = {
			10404111,
			0,
			10404111,
			0,
			0,
			0,
			10504112,
			10504112,
			10504112
		},
		no_die_time = {
			6,
			0,
			6,
			0,
			0,
			0,
			3,
			3,
			3
		}
	},
	{
		id = 18,
		delay_time = 0,
		dynamic_path = "battle_feiting_01/caozuoxiang_chunk_3.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 9,
		camera = "StagePerformCamera4003.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 19,
		end_node = "StopPoint_3",
		monsters = {
			10204122,
			0,
			10204122,
			0,
			10404121,
			0,
			10204122,
			0,
			10204122
		},
		no_die_time = {
			2,
			0,
			2,
			0,
			6,
			0,
			3,
			0,
			3
		}
	},
	{
		id = 19,
		delay_time = 0,
		dynamic_path = "battle_feiting_01/weixiuche_chunk_4.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 9,
		camera = "StagePerformCamera4004.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 20,
		end_node = "StopPoint_1",
		monsters = {
			10304102,
			10304101,
			10304102,
			0,
			0,
			0,
			10304102,
			0,
			10304102
		},
		no_die_time = RT[5]
	},
	{
		next_script = 17,
		delay_time = 0,
		scene_id = 9,
		camera = "StagePerformCameraguaji1004.anim",
		shadow_dist = 25,
		id = 20,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_feiting_part01",
			"Timeline_egg_feiting_part01_apple",
			"Timeline_egg_feiting_part01_Cans",
			"Timeline_egg_feiting_part01_football",
			"Timeline_egg_feiting_part01_soccer",
			"Timeline_egg_feiting_part01_tennis",
			"Timeline_egg_feiting_part01_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		next_script = 18,
		delay_time = 0,
		scene_id = 9,
		camera = "StagePerformCameraguaji1004_02.anim",
		shadow_dist = 25,
		id = 21,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_feiting_part02",
			"Timeline_egg_feiting_part02_apple",
			"Timeline_egg_feiting_part02_Cans",
			"Timeline_egg_feiting_part02_football",
			"Timeline_egg_feiting_part02_soccer",
			"Timeline_egg_feiting_part02_tennis",
			"Timeline_egg_feiting_part02_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 20,
		next_script = 31,
		id = 22,
		scene_id = 10,
		camera = "StagePerformCamera5005.anim"
	},
	{
		id = 23,
		delay_time = 0,
		dynamic_path = "battle_feiqifactory_01/youtong_chunk_3.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 10,
		camera = "StagePerformCamera5002.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 32,
		end_node = "StopPoint_2",
		monsters = {
			10504141,
			10504142,
			10504141,
			0,
			0,
			0,
			10504142,
			10504141,
			10504142
		},
		no_die_time = {
			4,
			1,
			5,
			2,
			2,
			2,
			6,
			3,
			7
		}
	},
	{
		id = 24,
		delay_time = 0,
		dynamic_path = "battle_feiqifactory_01/lupai_chunk_4.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 10,
		camera = "StagePerformCamera5003.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 25,
		end_node = "StopPoint_3",
		monsters = {
			10604152,
			10304151,
			10604152,
			0,
			0,
			0,
			10604152,
			0,
			10604152
		},
		no_die_time = {
			2,
			6,
			2,
			0,
			0,
			0,
			4,
			0,
			3
		}
	},
	{
		id = 25,
		delay_time = 0,
		dynamic_path = "battle_feiqifactory_01/fadianji_chunk_1.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 10,
		camera = "StagePerformCamera5004.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 31,
		end_node = "StopPoint_1",
		monsters = {
			10404131,
			10404131,
			10404131,
			0,
			0,
			0,
			10304132,
			10304132,
			10304132
		},
		no_die_time = {
			5,
			6,
			7,
			0,
			0,
			0,
			2,
			3,
			4
		}
	},
	{
		is_init = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 30,
		id = 26,
		scene_id = 11,
		camera = "StagePerformCamera1100.anim",
		timeline_node = RT[1]
	},
	{
		id = 27,
		delay_time = 0,
		dynamic_path = "battle_jiedao_yj_002/yj_zhaopai_chunk_3.prefab",
		battle_node = "BattlePoint_2",
		scene_id = 11,
		camera = "StagePerformCamera1102.anim",
		start_node = "StartPoint_2",
		shadow_dist = 20,
		next_script = 28,
		end_node = "StopPoint_2",
		monsters = RT[2],
		no_die_time = RT[3]
	},
	{
		id = 28,
		delay_time = 0,
		dynamic_path = "battle_jiedao_yj_002/yj_yangtai_chunk_1.prefab",
		battle_node = "BattlePoint_3",
		scene_id = 11,
		camera = "StagePerformCamera1103.anim",
		start_node = "StartPoint_3",
		shadow_dist = 20,
		next_script = 29,
		end_node = "StopPoint_3",
		monsters = RT[4],
		no_die_time = RT[5]
	},
	{
		id = 29,
		delay_time = 0,
		dynamic_path = "battle_jiedao_yj_002/yj_chongwufanwan_chunk_2.prefab",
		battle_node = "BattlePoint_1",
		scene_id = 11,
		camera = "StagePerformCamera1104.anim",
		start_node = "StartPoint_1",
		shadow_dist = 20,
		next_script = 30,
		end_node = "StopPoint_1",
		monsters = RT[6],
		no_die_time = RT[7]
	},
	{
		next_script = 27,
		delay_time = 0,
		scene_id = 11,
		camera = "StagePerformCameraguaji1101.anim",
		shadow_dist = 25,
		id = 30,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_jiedao"
		},
		timeline_skins = RT[9]
	},
	{
		next_script = 23,
		delay_time = 0,
		scene_id = 10,
		camera = "StagePerformCameraguaji1005.anim",
		shadow_dist = 25,
		id = 31,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_feiqi",
			"Timeline_egg_feiqi_Part01_apple",
			"Timeline_egg_feiqi_Part01_Cans",
			"Timeline_egg_feiqi_Part01_football",
			"Timeline_egg_feiqi_Part01_soccer",
			"Timeline_egg_feiqi_Part01_tennis",
			"Timeline_egg_feiqi_Part01_volleyball"
		},
		timeline_skins = RT[9]
	},
	{
		next_script = 24,
		delay_time = 0,
		scene_id = 10,
		camera = "StagePerformCameraguaji1005_02.anim",
		shadow_dist = 25,
		id = 32,
		timeline_heros = RT[8],
		timeline_node = {
			"Timeline_egg_feiqi_Part02",
			"Timeline_egg_feiqi_Part02_apple",
			"Timeline_egg_feiqi_Part02_Cans",
			"Timeline_egg_feiqi_Part02_football",
			"Timeline_egg_feiqi_Part02_soccer",
			"Timeline_egg_feiqi_Part02_tennis",
			"Timeline_egg_feiqi_Part02_volleyball"
		},
		timeline_skins = RT[9]
	},
	[100] = {
		is_init = 1,
		shadow_dist = 20,
		id = 100,
		camera = "StagePerformCamera1000.anim",
		timeline_node = RT[1]
	},
	[101] = {
		scene_id = 6,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 2,
		id = 101,
		story_avg = 617,
		is_init = 2
	},
	[102] = {
		scene_id = 5,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 7,
		id = 102,
		story_avg = 9840,
		is_init = 2
	},
	[103] = {
		scene_id = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 12,
		id = 103,
		story_avg = 2300,
		is_init = 2
	},
	[105] = {
		scene_id = 9,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 18,
		id = 105,
		story_avg = 170,
		is_init = 2
	},
	[211] = {
		delay_time = 0,
		shadow_dist = 25,
		next_script = 4,
		id = 211,
		camera = "StagePerformCameraguaji2012.anim",
		timeline_heros = RT[10],
		timeline_node = {
			"Timeline_w_jiedao02"
		}
	},
	[221] = {
		scene_id = 5,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 9,
		id = 221,
		camera = "StagePerformCameraguaji2021.anim",
		timeline_heros = RT[10],
		timeline_node = {
			"Timeline_w_youleyuan01"
		}
	},
	[231] = {
		scene_id = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 14,
		id = 231,
		camera = "StagePerformCameraguaji2000.anim",
		timeline_heros = {
			211001,
			211003,
			211005,
			211006,
			212001,
			212002,
			212003,
			212004,
			212005,
			212007,
			213001,
			213002,
			213003,
			213004,
			213006,
			213101,
			214002,
			214004,
			214005,
			214006,
			214101,
			215001,
			215002,
			215101
		},
		timeline_node = {
			"Timeline_w_dachangjing"
		}
	},
	[1011] = {
		scene_id = 6,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 2,
		id = 1011,
		story_avg = 2203,
		is_init = 2
	},
	[1021] = {
		scene_id = 5,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 7,
		id = 1021,
		story_avg = 460,
		is_init = 2
	},
	[1022] = {
		scene_id = 5,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 7,
		id = 1022,
		is_init = 2
	},
	[1023] = {
		scene_id = 5,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 7,
		id = 1023,
		story_avg = 3200,
		is_init = 2
	},
	[1031] = {
		scene_id = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 12,
		id = 1031,
		story_avg = 632,
		is_init = 2
	},
	[1032] = {
		scene_id = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 12,
		id = 1032,
		story_avg = 901,
		is_init = 2
	},
	[1033] = {
		scene_id = 1,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 12,
		id = 1033,
		story_avg = 3124,
		is_init = 2
	},
	[1051] = {
		scene_id = 10,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 31,
		id = 1051,
		story_avg = 2200,
		is_init = 2
	},
	[1052] = {
		scene_id = 9,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 18,
		id = 1052,
		story_avg = 2207,
		is_init = 2
	},
	[1053] = {
		scene_id = 10,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 31,
		id = 1053,
		story_avg = 3112,
		is_init = 2
	},
	[1054] = {
		scene_id = 10,
		delay_time = 0,
		shadow_dist = 25,
		next_script = 32,
		id = 1054,
		story_avg = 3208,
		is_init = 2
	}
}

return Data
