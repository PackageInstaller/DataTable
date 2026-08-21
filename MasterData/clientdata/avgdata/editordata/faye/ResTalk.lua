-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Faye\\ResTalk.lua

local indexMap = {
	id = 1,
	npc_id = 6,
	bg_blur = 10,
	play_delay = 14,
	scenery_id = 13,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 18,
	terminal_type = 27,
	extra_npc = 21,
	hide_name = 22,
	talk_in_ani = 24,
	terminal_effect = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 17,
	font_size = 23,
	terminal_bg = 26,
	bg_id = 19,
	mask_alpha = 20,
	special_effect = 28,
	talk = 3,
	branch_info = 29,
	switch_effect = 16,
	show_head = 8
}
local indexMapResTalkAction = {
	emoji = 5,
	pos = 1,
	action = 3,
	npc_id = 2,
	show = 4
}
local RTResTalkAction = {}

RTResTalkAction[1] = {
	[1] = 1,
	[2] = 1088
}
RTResTalkAction[2] = {
	1,
	1297,
	nil,
	nil,
	1
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1088
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1297
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1297
}
RTResTalkAction[6] = {
	1,
	1297,
	nil,
	nil,
	3
}
RTResTalkAction[7] = {
	1,
	1297,
	nil,
	nil,
	0
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 226
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 226
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 1297
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 226
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 143
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 905
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 896
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 905
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 896
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1297,
	[3] = {
		1
	}
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1214
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 1214
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 1214
}
RTResTalkAction[27] = {
	1,
	1297,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 1118
}
RTResTalkAction[32] = {
	[1] = 2,
	[2] = 1118
}
RTResTalkAction[33] = {
	[1] = 3,
	[2] = 1237
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 1237
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1237
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 895
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 895
}
RTResTalkAction[38] = {
	[1] = 3,
	[2] = 1142
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1142
}
RTResTalkAction[41] = {
	2,
	1297,
	nil,
	nil,
	1
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 1195
}
RTResTalkAction[43] = {
	[1] = 3,
	[2] = 273
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 273
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 1023
}
RTResTalkAction[46] = {
	[1] = 3,
	[2] = 1023
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 1023
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 1169
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 179
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 179
}
RTResTalkAction[53] = {
	[1] = 3,
	[2] = 179
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 904
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 904
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1276
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 1276
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 194
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 194
}

local Data = {
	[42000001] = {
		42000001,
		9,
		Lang.get(113036),
		42000,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		42000,
		nil,
		1,
		nil,
		nil,
		nil,
		42000,
		255,
		nil,
		1
	},
	[42000002] = {
		42000002,
		9,
		Lang.get(113037),
		42000,
		2,
		605,
		[22] = 1
	},
	[42000003] = {
		42000003,
		3,
		Lang.get(113038),
		42000,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		[22] = 1,
		[20] = -1
	},
	[42000004] = {
		42000004,
		0,
		Lang.get(113039),
		42000,
		4,
		1088,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[42000005] = {
		42000005,
		0,
		Lang.get(113040),
		42000,
		5,
		1088,
		{
			RTResTalkAction[1]
		}
	},
	[42000006] = {
		42000006,
		0,
		Lang.get(113041),
		42000,
		6,
		1297,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[42000007] = {
		42000007,
		7,
		"123",
		42000,
		7,
		1297,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[42000008] = {
		42000008,
		0,
		"……",
		42000,
		8,
		1088,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[42000009] = {
		42000009,
		0,
		Lang.get(113042),
		42000,
		9,
		1088,
		{
			RTResTalkAction[1]
		}
	},
	[42000010] = {
		42000010,
		0,
		Lang.get(113043),
		42000,
		10,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[42000011] = {
		42000011,
		0,
		Lang.get(113044),
		42000,
		11,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42000012] = {
		42000012,
		0,
		Lang.get(113045),
		42000,
		12,
		1088,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42000013] = {
		42000013,
		0,
		Lang.get(113046),
		42000,
		13,
		1297,
		{
			RTResTalkAction[6],
			RTResTalkAction[3]
		}
	},
	[42000014] = {
		42000014,
		0,
		Lang.get(113047),
		42000,
		14,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42000015] = {
		42000015,
		0,
		Lang.get(113048),
		42000,
		15,
		1088,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42000016] = {
		42000016,
		0,
		Lang.get(113049),
		42000,
		16,
		1088,
		{
			RTResTalkAction[1]
		}
	},
	[42000017] = {
		42000017,
		0,
		"……",
		42000,
		17,
		1297,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42000018] = {
		42000018,
		0,
		Lang.get(113050),
		42000,
		18,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42000019] = {
		42000019,
		0,
		Lang.get(113051),
		42000,
		19,
		1088,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42000020] = {
		42000020,
		0,
		Lang.get(113052),
		42000,
		20,
		1088,
		{
			RTResTalkAction[1]
		}
	},
	[42000021] = {
		42000021,
		0,
		Lang.get(113053),
		42000,
		21,
		1088,
		{
			RTResTalkAction[1]
		}
	},
	[42000022] = {
		42000022,
		0,
		Lang.get(113054),
		42000,
		22,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[42000023] = {
		42000023,
		0,
		Lang.get(113055),
		42000,
		23,
		1088,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42000024] = {
		42000024,
		0,
		"……",
		42000,
		24,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[42000025] = {
		42000025,
		0,
		Lang.get(113056),
		42000,
		25,
		1088,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42000026] = {
		42000026,
		0,
		Lang.get(113057),
		42000,
		26,
		605,
		{
			RTResTalkAction[3]
		}
	},
	[42000027] = {
		42000027,
		0,
		Lang.get(113058),
		42000,
		27,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		42001,
		nil,
		1,
		[19] = 42001,
		[17] = 1
	},
	[42000028] = {
		42000028,
		0,
		Lang.get(113059),
		42000,
		28,
		226,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42000029] = {
		42000029,
		0,
		Lang.get(113060),
		42000,
		29,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42000030] = {
		42000030,
		0,
		Lang.get(113061),
		42000,
		30,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42000031] = {
		42000031,
		0,
		Lang.get(113062),
		42000,
		31,
		605,
		{
			RTResTalkAction[9]
		}
	},
	[42000032] = {
		42000032,
		0,
		Lang.get(113063),
		42000,
		32,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42000033] = {
		42000033,
		0,
		Lang.get(113064),
		42000,
		33,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42000034] = {
		42000034,
		0,
		Lang.get(113065),
		42000,
		34,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000035] = {
		42000035,
		0,
		"？",
		42000,
		35,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000036] = {
		42000036,
		0,
		Lang.get(113066),
		42000,
		36,
		605,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000037] = {
		42000037,
		0,
		Lang.get(113067),
		42000,
		37,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000038] = {
		42000038,
		0,
		Lang.get(113068),
		42000,
		38,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000039] = {
		42000039,
		0,
		Lang.get(113069),
		42000,
		39,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000040] = {
		42000040,
		0,
		Lang.get(113070),
		42000,
		40,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000041] = {
		42000041,
		0,
		Lang.get(113071),
		42000,
		41,
		605,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000042] = {
		42000042,
		0,
		Lang.get(113072),
		42000,
		42,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000043] = {
		42000043,
		0,
		Lang.get(113073),
		42000,
		43,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000044] = {
		42000044,
		0,
		Lang.get(113074),
		42000,
		44,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000045] = {
		42000045,
		0,
		Lang.get(113075),
		42000,
		45,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000046] = {
		42000046,
		0,
		Lang.get(113076),
		42000,
		46,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000047] = {
		42000047,
		0,
		Lang.get(113077),
		42000,
		47,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000048] = {
		42000048,
		0,
		Lang.get(113078),
		42000,
		48,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000049] = {
		42000049,
		0,
		Lang.get(113079),
		42000,
		49,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000050] = {
		42000050,
		0,
		"……",
		42000,
		50,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000051] = {
		42000051,
		0,
		Lang.get(113080),
		42000,
		51,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000052] = {
		42000052,
		0,
		Lang.get(113081),
		42000,
		52,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000053] = {
		42000053,
		0,
		Lang.get(113082),
		42000,
		53,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42000054] = {
		42000054,
		0,
		Lang.get(113083),
		42000,
		54,
		1297,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[42001001] = {
		42001001,
		3,
		Lang.get(113084),
		42001,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42002,
		nil,
		1,
		nil,
		1,
		nil,
		42002,
		nil,
		nil,
		1
	},
	[42001002] = {
		42001002,
		0,
		Lang.get(113085),
		42001,
		2,
		506,
		nil,
		1
	},
	[42001003] = {
		42001003,
		3,
		Lang.get(113086),
		42001,
		3,
		605,
		[22] = 1
	},
	[42001004] = {
		42001004,
		0,
		"……",
		42001,
		4,
		1297,
		nil,
		1
	},
	[42001005] = {
		42001005,
		3,
		Lang.get(113087),
		42001,
		5,
		605,
		[22] = 1
	},
	[42001006] = {
		42001006,
		3,
		Lang.get(113088),
		42001,
		6,
		605,
		[22] = 1
	},
	[42001007] = {
		42001007,
		0,
		Lang.get(113089),
		42001,
		7,
		143,
		nil,
		1
	},
	[42001008] = {
		42001008,
		3,
		Lang.get(113090),
		42001,
		8,
		605,
		[22] = 1
	},
	[42001009] = {
		42001009,
		0,
		Lang.get(113091),
		42001,
		9,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42001010] = {
		42001010,
		0,
		Lang.get(113092),
		42001,
		10,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42001011] = {
		42001011,
		0,
		Lang.get(113093),
		42001,
		11,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001012] = {
		42001012,
		0,
		Lang.get(113094),
		42001,
		12,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001013] = {
		42001013,
		0,
		Lang.get(113095),
		42001,
		13,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001014] = {
		42001014,
		0,
		Lang.get(113096),
		42001,
		14,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001015] = {
		42001015,
		0,
		Lang.get(113097),
		42001,
		15,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001016] = {
		42001016,
		0,
		Lang.get(113098),
		42001,
		16,
		1297,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[42001017] = {
		42001017,
		3,
		Lang.get(113099),
		42001,
		17,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42001018] = {
		42001018,
		0,
		Lang.get(113100),
		42001,
		18,
		143,
		{
			RTResTalkAction[14]
		}
	},
	[42001019] = {
		42001019,
		0,
		Lang.get(113101),
		42001,
		19,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001020] = {
		42001020,
		0,
		Lang.get(113102),
		42001,
		20,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001021] = {
		42001021,
		0,
		Lang.get(113103),
		42001,
		21,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[4]
		}
	},
	[42001022] = {
		42001022,
		3,
		Lang.get(92217),
		42001,
		22,
		605,
		{
			RTResTalkAction[13]
		},
		[22] = 1
	},
	[42001023] = {
		42001023,
		0,
		Lang.get(113104),
		42001,
		23,
		143,
		{
			RTResTalkAction[14]
		}
	},
	[42001024] = {
		42001024,
		0,
		Lang.get(113105),
		42001,
		24,
		143,
		{
			RTResTalkAction[14]
		}
	},
	[42001025] = {
		42001025,
		0,
		Lang.get(113106),
		42001,
		25,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001026] = {
		42001026,
		0,
		Lang.get(113107),
		42001,
		26,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001027] = {
		42001027,
		0,
		Lang.get(113108),
		42001,
		27,
		143,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[42001028] = {
		42001028,
		0,
		Lang.get(113109),
		42001,
		28,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[13]
		}
	},
	[42001029] = {
		42001029,
		3,
		Lang.get(113110),
		42001,
		29,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42001030] = {
		42001030,
		0,
		"……",
		42001,
		30,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42001031] = {
		42001031,
		0,
		Lang.get(113111),
		42001,
		31,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001032] = {
		42001032,
		0,
		Lang.get(113112),
		42001,
		32,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001033] = {
		42001033,
		0,
		Lang.get(113113),
		42001,
		33,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001034] = {
		42001034,
		0,
		Lang.get(113114),
		42001,
		34,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001035] = {
		42001035,
		0,
		Lang.get(113115),
		42001,
		35,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001036] = {
		42001036,
		0,
		Lang.get(113116),
		42001,
		36,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001037] = {
		42001037,
		0,
		Lang.get(113117),
		42001,
		37,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001038] = {
		42001038,
		0,
		Lang.get(113118),
		42001,
		38,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001039] = {
		42001039,
		0,
		Lang.get(113119),
		42001,
		39,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001040] = {
		42001040,
		0,
		Lang.get(113120),
		42001,
		40,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001041] = {
		42001041,
		0,
		Lang.get(113121),
		42001,
		41,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001042] = {
		42001042,
		0,
		Lang.get(113122),
		42001,
		42,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001043] = {
		42001043,
		0,
		Lang.get(113123),
		42001,
		43,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001044] = {
		42001044,
		0,
		Lang.get(113124),
		42001,
		44,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001045] = {
		42001045,
		0,
		Lang.get(113125),
		42001,
		45,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001046] = {
		42001046,
		0,
		Lang.get(113126),
		42001,
		46,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42001047] = {
		42001047,
		0,
		Lang.get(113127),
		42001,
		47,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[42001048] = {
		42001048,
		3,
		Lang.get(113128),
		42001,
		48,
		605,
		{
			RTResTalkAction[9]
		},
		[22] = 1
	},
	[42002001] = {
		42002001,
		3,
		Lang.get(113129),
		42002,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42004,
		nil,
		1,
		nil,
		1,
		nil,
		42004,
		nil,
		nil,
		1
	},
	[42002002] = {
		42002002,
		0,
		Lang.get(113130),
		42002,
		2,
		1297,
		{
			RTResTalkAction[15]
		},
		1,
		nil,
		3,
		[21] = 905
	},
	[42002003] = {
		42002003,
		0,
		Lang.get(113131),
		42002,
		3,
		1297,
		{
			RTResTalkAction[15]
		},
		1,
		[21] = 905
	},
	[42002004] = {
		42002004,
		0,
		Lang.get(113132),
		42002,
		4,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[42002005] = {
		42002005,
		0,
		Lang.get(113133),
		42002,
		5,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[18]
		}
	},
	[42002006] = {
		42002006,
		0,
		Lang.get(113134),
		42002,
		6,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[42002007] = {
		42002007,
		0,
		Lang.get(113135),
		42002,
		7,
		896,
		{
			RTResTalkAction[16]
		}
	},
	[42002008] = {
		42002008,
		0,
		Lang.get(113136),
		42002,
		8,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[18]
		}
	},
	[42002009] = {
		42002009,
		0,
		Lang.get(113137),
		42002,
		9,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42002010] = {
		42002010,
		0,
		Lang.get(113138),
		42002,
		10,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[42002011] = {
		42002011,
		0,
		Lang.get(113139),
		42002,
		11,
		897,
		{
			RTResTalkAction[18]
		},
		1
	},
	[42002012] = {
		42002012,
		0,
		Lang.get(113140),
		42002,
		12,
		897,
		nil,
		1
	},
	[42002013] = {
		42002013,
		0,
		Lang.get(113141),
		42002,
		13,
		897,
		nil,
		1
	},
	[42002014] = {
		42002014,
		0,
		Lang.get(113142),
		42002,
		14,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42002015] = {
		42002015,
		3,
		Lang.get(113143),
		42002,
		15,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42002016] = {
		42002016,
		0,
		Lang.get(113144),
		42002,
		16,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42002017] = {
		42002017,
		0,
		Lang.get(113145),
		42002,
		17,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42002018] = {
		42002018,
		0,
		Lang.get(113146),
		42002,
		18,
		897,
		{
			RTResTalkAction[4]
		},
		1
	},
	[42002019] = {
		42002019,
		0,
		Lang.get(113147),
		42002,
		19,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42002020] = {
		42002020,
		0,
		Lang.get(113148),
		42002,
		20,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[42002021] = {
		42002021,
		0,
		Lang.get(113149),
		42002,
		21,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[18]
		}
	},
	[42002022] = {
		42002022,
		0,
		Lang.get(113150),
		42002,
		22,
		1297,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[42003001] = {
		42003001,
		0,
		Lang.get(113151),
		42003,
		1,
		1297,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42005,
		nil,
		1,
		nil,
		1,
		nil,
		42005
	},
	[42003002] = {
		42003002,
		0,
		Lang.get(113152),
		42003,
		2,
		1195,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[42003003] = {
		42003003,
		0,
		Lang.get(113153),
		42003,
		3,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[21]
		}
	},
	[42003004] = {
		42003004,
		0,
		"……",
		42003,
		4,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[18]
		}
	},
	[42003005] = {
		42003005,
		0,
		Lang.get(113154),
		42003,
		5,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42003006] = {
		42003006,
		0,
		Lang.get(113155),
		42003,
		6,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[42003007] = {
		42003007,
		0,
		Lang.get(113156),
		42003,
		7,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42003008] = {
		42003008,
		0,
		Lang.get(113157),
		42003,
		8,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42003009] = {
		42003009,
		0,
		Lang.get(113158),
		42003,
		9,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42003010] = {
		42003010,
		0,
		Lang.get(113159),
		42003,
		10,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42003011] = {
		42003011,
		0,
		Lang.get(113160),
		42003,
		11,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[21]
		}
	},
	[42003012] = {
		42003012,
		0,
		Lang.get(113161),
		42003,
		12,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42003013] = {
		42003013,
		0,
		Lang.get(113162),
		42003,
		13,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42003014] = {
		42003014,
		0,
		Lang.get(113163),
		42003,
		14,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[42003015] = {
		42003015,
		0,
		Lang.get(113164),
		42003,
		15,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[23]
		}
	},
	[42003016] = {
		42003016,
		0,
		Lang.get(113165),
		42003,
		16,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42003017] = {
		42003017,
		0,
		Lang.get(113166),
		42003,
		17,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42003018] = {
		42003018,
		0,
		Lang.get(113167),
		42003,
		18,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42003019] = {
		42003019,
		0,
		Lang.get(113168),
		42003,
		19,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42003020] = {
		42003020,
		0,
		Lang.get(113169),
		42003,
		20,
		1297,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42004001] = {
		42004001,
		3,
		Lang.get(113170),
		42004,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42006,
		nil,
		1,
		nil,
		1,
		nil,
		42006,
		nil,
		nil,
		1
	},
	[42004002] = {
		42004002,
		0,
		Lang.get(113171),
		42004,
		2,
		522,
		nil,
		1
	},
	[42004003] = {
		42004003,
		0,
		Lang.get(113172),
		42004,
		3,
		523,
		nil,
		1
	},
	[42004004] = {
		42004004,
		0,
		Lang.get(113173),
		42004,
		4,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42004005] = {
		42004005,
		3,
		Lang.get(98619),
		42004,
		5,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42004006] = {
		42004006,
		0,
		Lang.get(113174),
		42004,
		6,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004007] = {
		42004007,
		0,
		Lang.get(113175),
		42004,
		7,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004008] = {
		42004008,
		0,
		Lang.get(113176),
		42004,
		8,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004009] = {
		42004009,
		0,
		Lang.get(113177),
		42004,
		9,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004010] = {
		42004010,
		0,
		Lang.get(113178),
		42004,
		10,
		894,
		{
			RTResTalkAction[4],
			RTResTalkAction[26]
		},
		1
	},
	[42004011] = {
		42004011,
		3,
		Lang.get(113179),
		42004,
		11,
		605,
		[22] = 1
	},
	[42004012] = {
		42004012,
		0,
		Lang.get(113180),
		42004,
		12,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004013] = {
		42004013,
		0,
		Lang.get(113181),
		42004,
		13,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004014] = {
		42004014,
		0,
		Lang.get(113182),
		42004,
		14,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004015] = {
		42004015,
		0,
		Lang.get(113183),
		42004,
		15,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004016] = {
		42004016,
		0,
		Lang.get(113184),
		42004,
		16,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004017] = {
		42004017,
		0,
		Lang.get(113185),
		42004,
		17,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004018] = {
		42004018,
		0,
		Lang.get(113186),
		42004,
		18,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004019] = {
		42004019,
		0,
		Lang.get(113187),
		42004,
		19,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004020] = {
		42004020,
		0,
		Lang.get(113188),
		42004,
		20,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004021] = {
		42004021,
		0,
		Lang.get(113189),
		42004,
		21,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004022] = {
		42004022,
		0,
		Lang.get(113190),
		42004,
		22,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004023] = {
		42004023,
		0,
		Lang.get(113191),
		42004,
		23,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004024] = {
		42004024,
		0,
		Lang.get(113192),
		42004,
		24,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[26]
		}
	},
	[42004025] = {
		42004025,
		3,
		Lang.get(113193),
		42004,
		25,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42004026] = {
		42004026,
		0,
		Lang.get(113194),
		42004,
		26,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004027] = {
		42004027,
		0,
		Lang.get(113195),
		42004,
		27,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004028] = {
		42004028,
		0,
		Lang.get(113196),
		42004,
		28,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004029] = {
		42004029,
		0,
		Lang.get(113197),
		42004,
		29,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004030] = {
		42004030,
		0,
		Lang.get(113198),
		42004,
		30,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004031] = {
		42004031,
		0,
		Lang.get(113199),
		42004,
		31,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004032] = {
		42004032,
		0,
		Lang.get(113200),
		42004,
		32,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004033] = {
		42004033,
		0,
		Lang.get(113201),
		42004,
		33,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004034] = {
		42004034,
		0,
		Lang.get(113202),
		42004,
		34,
		1214,
		{
			RTResTalkAction[24],
			RTResTalkAction[4]
		}
	},
	[42004035] = {
		42004035,
		3,
		Lang.get(113203),
		42004,
		35,
		605,
		{
			RTResTalkAction[26]
		},
		[22] = 1
	},
	[42004036] = {
		42004036,
		0,
		Lang.get(113204),
		42004,
		36,
		1214,
		{
			RTResTalkAction[24]
		}
	},
	[42004037] = {
		42004037,
		3,
		Lang.get(113205),
		42004,
		37,
		605,
		{
			RTResTalkAction[26]
		},
		[22] = 1
	},
	[42004038] = {
		42004038,
		0,
		Lang.get(113206),
		42004,
		38,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42004039] = {
		42004039,
		0,
		Lang.get(113207),
		42004,
		39,
		1214,
		{
			RTResTalkAction[10],
			RTResTalkAction[25]
		}
	},
	[42004040] = {
		42004040,
		0,
		Lang.get(19521),
		42004,
		40,
		1297,
		{
			RTResTalkAction[27],
			RTResTalkAction[26]
		}
	},
	[42005001] = {
		42005001,
		3,
		Lang.get(113208),
		42005,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		42007,
		nil,
		1,
		nil,
		1,
		nil,
		42007,
		nil,
		nil,
		1
	},
	[42005002] = {
		42005002,
		3,
		Lang.get(113209),
		42005,
		2,
		605,
		[22] = 1
	},
	[42005003] = {
		42005003,
		0,
		Lang.get(113210),
		42005,
		3,
		1071,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42005004] = {
		42005004,
		0,
		Lang.get(113211),
		42005,
		4,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42005005] = {
		42005005,
		0,
		Lang.get(113212),
		42005,
		5,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42005006] = {
		42005006,
		0,
		Lang.get(113213),
		42005,
		6,
		899,
		{
			RTResTalkAction[29]
		},
		1
	},
	[42005007] = {
		42005007,
		0,
		Lang.get(113214),
		42005,
		7,
		900,
		nil,
		1
	},
	[42005008] = {
		42005008,
		0,
		Lang.get(113215),
		42005,
		8,
		900,
		nil,
		1
	},
	[42005009] = {
		42005009,
		0,
		Lang.get(113216),
		42005,
		9,
		900,
		nil,
		1
	},
	[42005010] = {
		42005010,
		0,
		Lang.get(113217),
		42005,
		10,
		899,
		nil,
		1
	},
	[42005011] = {
		42005011,
		0,
		Lang.get(113218),
		42005,
		11,
		900,
		nil,
		1
	},
	[42005012] = {
		42005012,
		0,
		Lang.get(113219),
		42005,
		12,
		899,
		nil,
		1
	},
	[42005013] = {
		42005013,
		0,
		Lang.get(113220),
		42005,
		13,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42005014] = {
		42005014,
		0,
		Lang.get(113221),
		42005,
		14,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42005015] = {
		42005015,
		3,
		Lang.get(113222),
		42005,
		15,
		605,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42008,
		nil,
		1,
		nil,
		1,
		nil,
		42008,
		nil,
		nil,
		1
	},
	[42005016] = {
		42005016,
		0,
		Lang.get(113223),
		42005,
		16,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42005017] = {
		42005017,
		0,
		Lang.get(113224),
		42005,
		17,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42005018] = {
		42005018,
		0,
		Lang.get(113225),
		42005,
		18,
		1071,
		{
			RTResTalkAction[28],
			RTResTalkAction[4]
		}
	},
	[42005019] = {
		42005019,
		3,
		Lang.get(113226),
		42005,
		19,
		605,
		{
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[42005020] = {
		42005020,
		0,
		Lang.get(113227),
		42005,
		20,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42005021] = {
		42005021,
		0,
		Lang.get(113228),
		42005,
		21,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42005022] = {
		42005022,
		2,
		Lang.get(113229),
		42005,
		22,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005023] = {
		42005023,
		2,
		Lang.get(113230),
		42005,
		23,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005024] = {
		42005024,
		0,
		Lang.get(113231),
		42005,
		24,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005025] = {
		42005025,
		0,
		Lang.get(113232),
		42005,
		25,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005026] = {
		42005026,
		0,
		Lang.get(113233),
		42005,
		26,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005027] = {
		42005027,
		0,
		Lang.get(113234),
		42005,
		27,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005028] = {
		42005028,
		0,
		Lang.get(113235),
		42005,
		28,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005029] = {
		42005029,
		0,
		Lang.get(113236),
		42005,
		29,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005030] = {
		42005030,
		0,
		Lang.get(113237),
		42005,
		30,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005031] = {
		42005031,
		0,
		Lang.get(113238),
		42005,
		31,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005032] = {
		42005032,
		0,
		"……",
		42005,
		32,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005033] = {
		42005033,
		0,
		Lang.get(113239),
		42005,
		33,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005034] = {
		42005034,
		0,
		Lang.get(113240),
		42005,
		34,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005035] = {
		42005035,
		0,
		Lang.get(113241),
		42005,
		35,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005036] = {
		42005036,
		0,
		Lang.get(113242),
		42005,
		36,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005037] = {
		42005037,
		2,
		Lang.get(113243),
		42005,
		37,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005038] = {
		42005038,
		0,
		Lang.get(113244),
		42005,
		38,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005039] = {
		42005039,
		0,
		Lang.get(113245),
		42005,
		39,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005040] = {
		42005040,
		0,
		Lang.get(113246),
		42005,
		40,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42005041] = {
		42005041,
		3,
		Lang.get(113247),
		42005,
		41,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[42005042] = {
		42005042,
		0,
		Lang.get(113248),
		42005,
		42,
		1297,
		{
			RTResTalkAction[2]
		}
	},
	[42005043] = {
		42005043,
		0,
		Lang.get(113249),
		42005,
		43,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42005044] = {
		42005044,
		0,
		Lang.get(113250),
		42005,
		44,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42006001] = {
		42006001,
		3,
		Lang.get(113251),
		42006,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42009,
		nil,
		1,
		nil,
		1,
		nil,
		42009,
		nil,
		nil,
		1
	},
	[42006002] = {
		42006002,
		0,
		Lang.get(113252),
		42006,
		2,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42006003] = {
		42006003,
		0,
		Lang.get(113253),
		42006,
		3,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006004] = {
		42006004,
		0,
		Lang.get(113254),
		42006,
		4,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006005] = {
		42006005,
		0,
		Lang.get(113255),
		42006,
		5,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006006] = {
		42006006,
		0,
		Lang.get(113256),
		42006,
		6,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006007] = {
		42006007,
		0,
		Lang.get(113257),
		42006,
		7,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006008] = {
		42006008,
		0,
		Lang.get(113258),
		42006,
		8,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006009] = {
		42006009,
		0,
		Lang.get(113259),
		42006,
		9,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006010] = {
		42006010,
		0,
		Lang.get(113260),
		42006,
		10,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[29]
		}
	},
	[42006011] = {
		42006011,
		0,
		Lang.get(113261),
		42006,
		11,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42006012] = {
		42006012,
		0,
		Lang.get(113262),
		42006,
		12,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006013] = {
		42006013,
		0,
		Lang.get(113263),
		42006,
		13,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42006014] = {
		42006014,
		0,
		Lang.get(113264),
		42006,
		14,
		1297,
		{
			RTResTalkAction[27],
			RTResTalkAction[29]
		}
	},
	[42006015] = {
		42006015,
		3,
		Lang.get(113265),
		42006,
		15,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42006016] = {
		42006016,
		3,
		Lang.get(113266),
		42006,
		16,
		605,
		[22] = 1
	},
	[42006017] = {
		42006017,
		0,
		Lang.get(113267),
		42006,
		17,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006018] = {
		42006018,
		0,
		Lang.get(113268),
		42006,
		18,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006019] = {
		42006019,
		0,
		Lang.get(113269),
		42006,
		19,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006020] = {
		42006020,
		0,
		Lang.get(113270),
		42006,
		20,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42006021] = {
		42006021,
		3,
		Lang.get(113271),
		42006,
		21,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42006022] = {
		42006022,
		0,
		Lang.get(113272),
		42006,
		22,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006023] = {
		42006023,
		0,
		Lang.get(113273),
		42006,
		23,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006024] = {
		42006024,
		0,
		Lang.get(113274),
		42006,
		24,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006025] = {
		42006025,
		0,
		Lang.get(113275),
		42006,
		25,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006026] = {
		42006026,
		9,
		Lang.get(113276),
		42006,
		26,
		[22] = 1,
		[7] = {
			RTResTalkAction[4],
			RTResTalkAction[23]
		}
	},
	[42006027] = {
		42006027,
		9,
		Lang.get(113277),
		42006,
		27,
		[22] = 1
	},
	[42006028] = {
		42006028,
		0,
		Lang.get(113278),
		42006,
		28,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006029] = {
		42006029,
		0,
		Lang.get(113279),
		42006,
		29,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006030] = {
		42006030,
		0,
		Lang.get(113280),
		42006,
		30,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006031] = {
		42006031,
		0,
		Lang.get(113281),
		42006,
		31,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006032] = {
		42006032,
		0,
		Lang.get(113282),
		42006,
		32,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006033] = {
		42006033,
		0,
		Lang.get(113283),
		42006,
		33,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006034] = {
		42006034,
		0,
		"……",
		42006,
		34,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006035] = {
		42006035,
		0,
		Lang.get(21987),
		42006,
		35,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006036] = {
		42006036,
		0,
		Lang.get(113284),
		42006,
		36,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006037] = {
		42006037,
		0,
		Lang.get(113285),
		42006,
		37,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006038] = {
		42006038,
		0,
		Lang.get(113286),
		42006,
		38,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006039] = {
		42006039,
		3,
		Lang.get(113287),
		42006,
		39,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[23]
		},
		[22] = 1
	},
	[42006040] = {
		42006040,
		9,
		Lang.get(113288),
		42006,
		40,
		[22] = 1
	},
	[42006041] = {
		42006041,
		9,
		Lang.get(113289),
		42006,
		41,
		[22] = 1
	},
	[42006042] = {
		42006042,
		0,
		Lang.get(113290),
		42006,
		42,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006043] = {
		42006043,
		3,
		Lang.get(113291),
		42006,
		43,
		605,
		{
			RTResTalkAction[23]
		},
		[22] = 1
	},
	[42006044] = {
		42006044,
		0,
		Lang.get(113292),
		42006,
		44,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42006045] = {
		42006045,
		0,
		Lang.get(113293),
		42006,
		45,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006046] = {
		42006046,
		0,
		Lang.get(113294),
		42006,
		46,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006047] = {
		42006047,
		0,
		Lang.get(18271),
		42006,
		47,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006048] = {
		42006048,
		0,
		Lang.get(113295),
		42006,
		48,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006049] = {
		42006049,
		0,
		Lang.get(113296),
		42006,
		49,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[42006050] = {
		42006050,
		0,
		Lang.get(113297),
		42006,
		50,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[23]
		}
	},
	[42006051] = {
		42006051,
		0,
		Lang.get(113298),
		42006,
		51,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[13]
		}
	},
	[42006052] = {
		42006052,
		0,
		Lang.get(113299),
		42006,
		52,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42006053] = {
		42006053,
		0,
		"！",
		42006,
		53,
		1297,
		{
			RTResTalkAction[2]
		}
	},
	[42006054] = {
		42006054,
		0,
		Lang.get(113300),
		42006,
		54,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42006055] = {
		42006055,
		0,
		Lang.get(113301),
		42006,
		55,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42006056] = {
		42006056,
		0,
		Lang.get(113302),
		42006,
		56,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42007001] = {
		42007001,
		3,
		Lang.get(113303),
		42007,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42010,
		nil,
		1,
		nil,
		1,
		nil,
		42010,
		nil,
		nil,
		1
	},
	[42007002] = {
		42007002,
		0,
		Lang.get(113304),
		42007,
		2,
		1118,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[42007003] = {
		42007003,
		0,
		Lang.get(113305),
		42007,
		3,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007004] = {
		42007004,
		0,
		Lang.get(113306),
		42007,
		4,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007005] = {
		42007005,
		0,
		Lang.get(113307),
		42007,
		5,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007006] = {
		42007006,
		0,
		Lang.get(113308),
		42007,
		6,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007007] = {
		42007007,
		0,
		Lang.get(113309),
		42007,
		7,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007008] = {
		42007008,
		0,
		Lang.get(113310),
		42007,
		8,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007009] = {
		42007009,
		0,
		Lang.get(113311),
		42007,
		9,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007010] = {
		42007010,
		0,
		Lang.get(113312),
		42007,
		10,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007011] = {
		42007011,
		0,
		Lang.get(113313),
		42007,
		11,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007012] = {
		42007012,
		0,
		Lang.get(113314),
		42007,
		12,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42007013] = {
		42007013,
		0,
		Lang.get(113315),
		42007,
		13,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[42007014] = {
		42007014,
		3,
		Lang.get(113316),
		42007,
		14,
		605,
		{
			RTResTalkAction[23]
		},
		[22] = 1
	},
	[42007015] = {
		42007015,
		0,
		Lang.get(113317),
		42007,
		15,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42007016] = {
		42007016,
		3,
		Lang.get(113318),
		42007,
		16,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42007017] = {
		42007017,
		0,
		Lang.get(113319),
		42007,
		17,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42007018] = {
		42007018,
		0,
		Lang.get(113320),
		42007,
		18,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42007019] = {
		42007019,
		0,
		Lang.get(113321),
		42007,
		19,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007020] = {
		42007020,
		0,
		Lang.get(113322),
		42007,
		20,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007021] = {
		42007021,
		0,
		Lang.get(113323),
		42007,
		21,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007022] = {
		42007022,
		0,
		Lang.get(113324),
		42007,
		22,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007023] = {
		42007023,
		0,
		Lang.get(113325),
		42007,
		23,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007024] = {
		42007024,
		0,
		"……",
		42007,
		24,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007025] = {
		42007025,
		0,
		Lang.get(113326),
		42007,
		25,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007026] = {
		42007026,
		0,
		Lang.get(113327),
		42007,
		26,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007027] = {
		42007027,
		3,
		Lang.get(113328),
		42007,
		27,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[42007028] = {
		42007028,
		0,
		Lang.get(23995),
		42007,
		28,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007029] = {
		42007029,
		0,
		Lang.get(113329),
		42007,
		29,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007030] = {
		42007030,
		0,
		Lang.get(113330),
		42007,
		30,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007031] = {
		42007031,
		0,
		Lang.get(113331),
		42007,
		31,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007032] = {
		42007032,
		0,
		Lang.get(113332),
		42007,
		32,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007033] = {
		42007033,
		0,
		Lang.get(113333),
		42007,
		33,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007034] = {
		42007034,
		0,
		Lang.get(113334),
		42007,
		34,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007035] = {
		42007035,
		0,
		Lang.get(113335),
		42007,
		35,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007036] = {
		42007036,
		0,
		Lang.get(113336),
		42007,
		36,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42007037] = {
		42007037,
		0,
		Lang.get(113337),
		42007,
		37,
		1071,
		{
			RTResTalkAction[28],
			RTResTalkAction[4]
		}
	},
	[42008001] = {
		42008001,
		3,
		Lang.get(113338),
		42008,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42011,
		nil,
		1,
		nil,
		1,
		nil,
		42011,
		nil,
		nil,
		1
	},
	[42008002] = {
		42008002,
		0,
		Lang.get(113339),
		42008,
		2,
		1118,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[42008003] = {
		42008003,
		0,
		Lang.get(113340),
		42008,
		3,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008004] = {
		42008004,
		0,
		Lang.get(113341),
		42008,
		4,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008005] = {
		42008005,
		0,
		Lang.get(113342),
		42008,
		5,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008006] = {
		42008006,
		0,
		Lang.get(113343),
		42008,
		6,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008007] = {
		42008007,
		0,
		Lang.get(113344),
		42008,
		7,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[42008008] = {
		42008008,
		3,
		Lang.get(113345),
		42008,
		8,
		605,
		{
			RTResTalkAction[23]
		},
		[22] = 1
	},
	[42008009] = {
		42008009,
		0,
		Lang.get(113346),
		42008,
		9,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42008010] = {
		42008010,
		0,
		Lang.get(113347),
		42008,
		10,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42008011] = {
		42008011,
		0,
		Lang.get(113348),
		42008,
		11,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42008012] = {
		42008012,
		0,
		Lang.get(113349),
		42008,
		12,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42008013] = {
		42008013,
		0,
		"……",
		42008,
		13,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42008014] = {
		42008014,
		0,
		Lang.get(113350),
		42008,
		14,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42008015] = {
		42008015,
		0,
		Lang.get(25457),
		42008,
		15,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008016] = {
		42008016,
		3,
		Lang.get(113351),
		42008,
		16,
		605,
		{
			RTResTalkAction[23],
			RTResTalkAction[34]
		},
		[22] = 1
	},
	[42008017] = {
		42008017,
		0,
		Lang.get(113352),
		42008,
		17,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42008018] = {
		42008018,
		0,
		Lang.get(113353),
		42008,
		18,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008019] = {
		42008019,
		0,
		Lang.get(113354),
		42008,
		19,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[42008020] = {
		42008020,
		0,
		Lang.get(113355),
		42008,
		20,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42008021] = {
		42008021,
		0,
		Lang.get(113356),
		42008,
		21,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42008022] = {
		42008022,
		0,
		Lang.get(113357),
		42008,
		22,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008023] = {
		42008023,
		0,
		Lang.get(113358),
		42008,
		23,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[42008024] = {
		42008024,
		0,
		Lang.get(113359),
		42008,
		24,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42008025] = {
		42008025,
		0,
		Lang.get(113360),
		42008,
		25,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42008026] = {
		42008026,
		0,
		Lang.get(113361),
		42008,
		26,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42008027] = {
		42008027,
		0,
		Lang.get(113362),
		42008,
		27,
		1297,
		{
			RTResTalkAction[27],
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[42008028] = {
		42008028,
		0,
		Lang.get(113363),
		42008,
		28,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42008029] = {
		42008029,
		0,
		Lang.get(113364),
		42008,
		29,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42008030] = {
		42008030,
		0,
		Lang.get(113365),
		42008,
		30,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42008031] = {
		42008031,
		0,
		Lang.get(113366),
		42008,
		31,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42009001] = {
		42009001,
		3,
		Lang.get(113367),
		42009,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42012,
		nil,
		1,
		nil,
		1,
		nil,
		42012,
		nil,
		nil,
		1
	},
	[42009002] = {
		42009002,
		0,
		Lang.get(113368),
		42009,
		2,
		1237,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42009003] = {
		42009003,
		0,
		Lang.get(113369),
		42009,
		3,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009004] = {
		42009004,
		0,
		Lang.get(113370),
		42009,
		4,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[42009005] = {
		42009005,
		0,
		Lang.get(113371),
		42009,
		5,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42009006] = {
		42009006,
		0,
		Lang.get(113372),
		42009,
		6,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42009007] = {
		42009007,
		0,
		Lang.get(113373),
		42009,
		7,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42009008] = {
		42009008,
		0,
		Lang.get(113374),
		42009,
		8,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[34]
		}
	},
	[42009009] = {
		42009009,
		0,
		Lang.get(113375),
		42009,
		9,
		895,
		{
			RTResTalkAction[36]
		}
	},
	[42009010] = {
		42009010,
		0,
		Lang.get(113376),
		42009,
		10,
		895,
		{
			RTResTalkAction[36]
		}
	},
	[42009011] = {
		42009011,
		3,
		Lang.get(113377),
		42009,
		11,
		605,
		{
			RTResTalkAction[37]
		},
		[22] = 1
	},
	[42009012] = {
		42009012,
		0,
		Lang.get(113378),
		42009,
		12,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42009013] = {
		42009013,
		0,
		Lang.get(68231),
		42009,
		13,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[4]
		}
	},
	[42009014] = {
		42009014,
		0,
		Lang.get(113379),
		42009,
		14,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[37]
		}
	},
	[42009015] = {
		42009015,
		0,
		Lang.get(113380),
		42009,
		15,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009016] = {
		42009016,
		0,
		Lang.get(113381),
		42009,
		16,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009017] = {
		42009017,
		0,
		Lang.get(113382),
		42009,
		17,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009018] = {
		42009018,
		0,
		Lang.get(113383),
		42009,
		18,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009019] = {
		42009019,
		0,
		Lang.get(113384),
		42009,
		19,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009020] = {
		42009020,
		0,
		Lang.get(113385),
		42009,
		20,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009021] = {
		42009021,
		0,
		"……",
		42009,
		21,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42009022] = {
		42009022,
		0,
		"……",
		42009,
		22,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[42009023] = {
		42009023,
		0,
		"……",
		42009,
		23,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42009024] = {
		42009024,
		0,
		Lang.get(113386),
		42009,
		24,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42009025] = {
		42009025,
		0,
		Lang.get(113387),
		42009,
		25,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42009026] = {
		42009026,
		0,
		Lang.get(113388),
		42009,
		26,
		1297,
		{
			RTResTalkAction[27],
			RTResTalkAction[34]
		}
	},
	[42009027] = {
		42009027,
		0,
		Lang.get(113389),
		42009,
		27,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33],
			RTResTalkAction[4]
		}
	},
	[42010001] = {
		42010001,
		3,
		Lang.get(113390),
		42010,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42013,
		nil,
		1,
		nil,
		1,
		nil,
		42013,
		nil,
		nil,
		1
	},
	[42010002] = {
		42010002,
		0,
		Lang.get(113391),
		42010,
		2,
		1118,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[42010003] = {
		42010003,
		0,
		Lang.get(113392),
		42010,
		3,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42010004] = {
		42010004,
		0,
		Lang.get(113393),
		42010,
		4,
		605,
		{
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[42010005] = {
		42010005,
		0,
		Lang.get(113394),
		42010,
		5,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42010006] = {
		42010006,
		0,
		Lang.get(113395),
		42010,
		6,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42010007] = {
		42010007,
		0,
		Lang.get(113396),
		42010,
		7,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42010008] = {
		42010008,
		0,
		Lang.get(113397),
		42010,
		8,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[42010009] = {
		42010009,
		0,
		Lang.get(113398),
		42010,
		9,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42010010] = {
		42010010,
		0,
		Lang.get(113399),
		42010,
		10,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4],
			RTResTalkAction[34]
		}
	},
	[42010011] = {
		42010011,
		0,
		Lang.get(113400),
		42010,
		11,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42010012] = {
		42010012,
		0,
		Lang.get(113401),
		42010,
		12,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42010013] = {
		42010013,
		0,
		Lang.get(113402),
		42010,
		13,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42010014] = {
		42010014,
		0,
		Lang.get(113403),
		42010,
		14,
		1142,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010015] = {
		42010015,
		0,
		Lang.get(113404),
		42010,
		15,
		1142,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010016] = {
		42010016,
		0,
		Lang.get(113405),
		42010,
		16,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010017] = {
		42010017,
		0,
		Lang.get(113406),
		42010,
		17,
		1142,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010018] = {
		42010018,
		0,
		Lang.get(113407),
		42010,
		18,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010019] = {
		42010019,
		0,
		Lang.get(113408),
		42010,
		19,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010020] = {
		42010020,
		0,
		Lang.get(113409),
		42010,
		20,
		1142,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[42010021] = {
		42010021,
		0,
		Lang.get(113410),
		42010,
		21,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4],
			RTResTalkAction[39]
		}
	},
	[42010022] = {
		42010022,
		0,
		Lang.get(113411),
		42010,
		22,
		605,
		{
			RTResTalkAction[21]
		}
	},
	[42010023] = {
		42010023,
		0,
		Lang.get(113412),
		42010,
		23,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42010024] = {
		42010024,
		0,
		Lang.get(113413),
		42010,
		24,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42010025] = {
		42010025,
		0,
		Lang.get(113414),
		42010,
		25,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42010026] = {
		42010026,
		0,
		Lang.get(113415),
		42010,
		26,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42010027] = {
		42010027,
		0,
		Lang.get(113416),
		42010,
		27,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[42010028] = {
		42010028,
		0,
		Lang.get(113417),
		42010,
		28,
		605,
		{
			RTResTalkAction[4]
		}
	},
	[42010029] = {
		42010029,
		0,
		Lang.get(113418),
		42010,
		29,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42010030] = {
		42010030,
		0,
		Lang.get(113419),
		42010,
		30,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42010031] = {
		42010031,
		0,
		Lang.get(113420),
		42010,
		31,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[42010032] = {
		42010032,
		0,
		Lang.get(113421),
		42010,
		32,
		1142,
		{
			RTResTalkAction[40],
			RTResTalkAction[9]
		}
	},
	[42011001] = {
		42011001,
		3,
		Lang.get(113422),
		42011,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42014,
		nil,
		1,
		nil,
		1,
		nil,
		42014,
		nil,
		nil,
		1
	},
	[42011002] = {
		42011002,
		0,
		Lang.get(113423),
		42011,
		2,
		1237,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42011003] = {
		42011003,
		0,
		Lang.get(113424),
		42011,
		3,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42011004] = {
		42011004,
		0,
		Lang.get(113425),
		42011,
		4,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42011005] = {
		42011005,
		0,
		Lang.get(113426),
		42011,
		5,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[42011006] = {
		42011006,
		0,
		Lang.get(113427),
		42011,
		6,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011007] = {
		42011007,
		0,
		Lang.get(113428),
		42011,
		7,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011008] = {
		42011008,
		0,
		Lang.get(113429),
		42011,
		8,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011009] = {
		42011009,
		0,
		Lang.get(113430),
		42011,
		9,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011010] = {
		42011010,
		0,
		Lang.get(113431),
		42011,
		10,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011011] = {
		42011011,
		0,
		"？",
		42011,
		11,
		1297,
		{
			RTResTalkAction[41],
			RTResTalkAction[33]
		}
	},
	[42011012] = {
		42011012,
		0,
		Lang.get(113432),
		42011,
		12,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42011013] = {
		42011013,
		0,
		Lang.get(113433),
		42011,
		13,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42011014] = {
		42011014,
		0,
		Lang.get(113434),
		42011,
		14,
		605,
		{
			RTResTalkAction[4]
		}
	},
	[42011015] = {
		42011015,
		0,
		Lang.get(113435),
		42011,
		15,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011016] = {
		42011016,
		0,
		Lang.get(113436),
		42011,
		16,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011017] = {
		42011017,
		0,
		Lang.get(113437),
		42011,
		17,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011018] = {
		42011018,
		0,
		Lang.get(113438),
		42011,
		18,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[42011019] = {
		42011019,
		0,
		Lang.get(113439),
		42011,
		19,
		896,
		{
			RTResTalkAction[16]
		}
	},
	[42011020] = {
		42011020,
		0,
		Lang.get(113440),
		42011,
		20,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[18]
		}
	},
	[42011021] = {
		42011021,
		0,
		Lang.get(113441),
		42011,
		21,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[4]
		}
	},
	[42011022] = {
		42011022,
		0,
		Lang.get(113442),
		42011,
		22,
		605,
		{
			RTResTalkAction[18]
		}
	},
	[42011023] = {
		42011023,
		0,
		Lang.get(113443),
		42011,
		23,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011024] = {
		42011024,
		0,
		Lang.get(113444),
		42011,
		24,
		605,
		{
			RTResTalkAction[4]
		}
	},
	[42011025] = {
		42011025,
		0,
		Lang.get(113445),
		42011,
		25,
		895,
		{
			RTResTalkAction[36]
		}
	},
	[42011026] = {
		42011026,
		0,
		Lang.get(113446),
		42011,
		26,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[37]
		}
	},
	[42011027] = {
		42011027,
		0,
		"……",
		42011,
		27,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[18]
		}
	},
	[42011028] = {
		42011028,
		0,
		Lang.get(113447),
		42011,
		28,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[4]
		}
	},
	[42011029] = {
		42011029,
		0,
		Lang.get(113448),
		42011,
		29,
		896,
		{
			RTResTalkAction[16],
			RTResTalkAction[37]
		}
	},
	[42011030] = {
		42011030,
		0,
		Lang.get(113449),
		42011,
		30,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[18]
		}
	},
	[42011031] = {
		42011031,
		0,
		Lang.get(113450),
		42011,
		31,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[37]
		}
	},
	[42011032] = {
		42011032,
		0,
		Lang.get(113451),
		42011,
		32,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011033] = {
		42011033,
		0,
		Lang.get(113452),
		42011,
		33,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[4]
		}
	},
	[42011034] = {
		42011034,
		0,
		Lang.get(113453),
		42011,
		34,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[37]
		}
	},
	[42011035] = {
		42011035,
		0,
		Lang.get(113454),
		42011,
		35,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42011036] = {
		42011036,
		0,
		Lang.get(113455),
		42011,
		36,
		895,
		{
			RTResTalkAction[36],
			RTResTalkAction[4]
		}
	},
	[42012001] = {
		42012001,
		3,
		Lang.get(113456),
		42012,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		42015,
		nil,
		1,
		nil,
		1,
		nil,
		42015,
		nil,
		nil,
		1
	},
	[42012002] = {
		42012002,
		0,
		Lang.get(113457),
		42012,
		2,
		1071,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42012003] = {
		42012003,
		3,
		Lang.get(113458),
		42012,
		3,
		605,
		{
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[42012004] = {
		42012004,
		0,
		Lang.get(113459),
		42012,
		4,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42012005] = {
		42012005,
		0,
		Lang.get(113460),
		42012,
		5,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42012006] = {
		42012006,
		0,
		Lang.get(113461),
		42012,
		6,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42012007] = {
		42012007,
		0,
		Lang.get(113462),
		42012,
		7,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42012008] = {
		42012008,
		3,
		Lang.get(113463),
		42012,
		8,
		605,
		{
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[42012009] = {
		42012009,
		3,
		Lang.get(113464),
		42012,
		9,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		42016,
		nil,
		1,
		nil,
		1,
		nil,
		42016,
		nil,
		nil,
		1
	},
	[42012010] = {
		42012010,
		0,
		Lang.get(113465),
		42012,
		10,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42012011] = {
		42012011,
		0,
		Lang.get(113466),
		42012,
		11,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42012012] = {
		42012012,
		0,
		Lang.get(113467),
		42012,
		12,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42012013] = {
		42012013,
		3,
		Lang.get(113468),
		42012,
		13,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42012014] = {
		42012014,
		0,
		Lang.get(113469),
		42012,
		14,
		226,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42012015] = {
		42012015,
		0,
		Lang.get(113470),
		42012,
		15,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42012016] = {
		42012016,
		0,
		Lang.get(113471),
		42012,
		16,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42012017] = {
		42012017,
		0,
		Lang.get(113472),
		42012,
		17,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42012018] = {
		42012018,
		0,
		Lang.get(113473),
		42012,
		18,
		226,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42012019] = {
		42012019,
		0,
		Lang.get(113474),
		42012,
		19,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[42012020] = {
		42012020,
		0,
		Lang.get(113475),
		42012,
		20,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[42012021] = {
		42012021,
		0,
		Lang.get(113476),
		42012,
		21,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42012022] = {
		42012022,
		3,
		Lang.get(113477),
		42012,
		22,
		605,
		{
			RTResTalkAction[9]
		},
		[22] = 1
	},
	[42012023] = {
		42012023,
		0,
		Lang.get(113478),
		42012,
		23,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42012024] = {
		42012024,
		0,
		Lang.get(113479),
		42012,
		24,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42012025] = {
		42012025,
		0,
		Lang.get(113480),
		42012,
		25,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013001] = {
		42013001,
		0,
		Lang.get(113481),
		42013,
		1,
		1297,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42017,
		nil,
		1,
		nil,
		1,
		nil,
		42017
	},
	[42013002] = {
		42013002,
		0,
		Lang.get(113482),
		42013,
		2,
		901,
		nil,
		1
	},
	[42013003] = {
		42013003,
		0,
		"？",
		42013,
		3,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42013004] = {
		42013004,
		0,
		Lang.get(113483),
		42013,
		4,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013005] = {
		42013005,
		0,
		Lang.get(113484),
		42013,
		5,
		902,
		{
			RTResTalkAction[4]
		},
		1
	},
	[42013006] = {
		42013006,
		0,
		Lang.get(113485),
		42013,
		6,
		903,
		nil,
		1
	},
	[42013007] = {
		42013007,
		0,
		Lang.get(113486),
		42013,
		7,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013008] = {
		42013008,
		0,
		Lang.get(113487),
		42013,
		8,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013009] = {
		42013009,
		0,
		Lang.get(113488),
		42013,
		9,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013010] = {
		42013010,
		3,
		Lang.get(113489),
		42013,
		10,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42013011] = {
		42013011,
		0,
		Lang.get(113490),
		42013,
		11,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013012] = {
		42013012,
		0,
		Lang.get(113491),
		42013,
		12,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013013] = {
		42013013,
		0,
		Lang.get(113492),
		42013,
		13,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42013014] = {
		42013014,
		3,
		Lang.get(113493),
		42013,
		14,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42013015] = {
		42013015,
		0,
		Lang.get(113494),
		42013,
		15,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42013016] = {
		42013016,
		0,
		Lang.get(113495),
		42013,
		16,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42013017] = {
		42013017,
		3,
		Lang.get(113496),
		42013,
		17,
		605,
		{
			RTResTalkAction[34]
		},
		[22] = 1
	},
	[42013018] = {
		42013018,
		0,
		Lang.get(113497),
		42013,
		18,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42013019] = {
		42013019,
		0,
		Lang.get(113498),
		42013,
		19,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013020] = {
		42013020,
		0,
		Lang.get(113499),
		42013,
		20,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013021] = {
		42013021,
		0,
		Lang.get(113500),
		42013,
		21,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013022] = {
		42013022,
		0,
		Lang.get(113501),
		42013,
		22,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013023] = {
		42013023,
		0,
		Lang.get(22381),
		42013,
		23,
		1118,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013024] = {
		42013024,
		0,
		Lang.get(113502),
		42013,
		24,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013025] = {
		42013025,
		0,
		Lang.get(113503),
		42013,
		25,
		1237,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[42013026] = {
		42013026,
		0,
		Lang.get(100726),
		42013,
		26,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[42014001] = {
		42014001,
		3,
		Lang.get(113504),
		42014,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42018,
		nil,
		1,
		nil,
		1,
		nil,
		42018,
		nil,
		nil,
		1
	},
	[42014002] = {
		42014002,
		0,
		Lang.get(113505),
		42014,
		2,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42014003] = {
		42014003,
		0,
		Lang.get(113506),
		42014,
		3,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42014004] = {
		42014004,
		0,
		Lang.get(113507),
		42014,
		4,
		1195,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014005] = {
		42014005,
		0,
		Lang.get(113508),
		42014,
		5,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014006] = {
		42014006,
		0,
		Lang.get(113509),
		42014,
		6,
		1195,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014007] = {
		42014007,
		0,
		Lang.get(113510),
		42014,
		7,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014008] = {
		42014008,
		0,
		Lang.get(113511),
		42014,
		8,
		1195,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014009] = {
		42014009,
		0,
		Lang.get(113512),
		42014,
		9,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014010] = {
		42014010,
		0,
		Lang.get(113513),
		42014,
		10,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014011] = {
		42014011,
		0,
		Lang.get(113514),
		42014,
		11,
		1195,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014012] = {
		42014012,
		0,
		Lang.get(113515),
		42014,
		12,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014013] = {
		42014013,
		0,
		Lang.get(113516),
		42014,
		13,
		1195,
		{
			RTResTalkAction[10],
			RTResTalkAction[42]
		}
	},
	[42014014] = {
		42014014,
		0,
		Lang.get(113517),
		42014,
		14,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42014015] = {
		42014015,
		0,
		Lang.get(113518),
		42014,
		15,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42014016] = {
		42014016,
		0,
		Lang.get(37527),
		42014,
		16,
		605,
		{
			RTResTalkAction[4]
		}
	},
	[42014017] = {
		42014017,
		0,
		Lang.get(113519),
		42014,
		17,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42014018] = {
		42014018,
		0,
		Lang.get(113520),
		42014,
		18,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42014019] = {
		42014019,
		0,
		Lang.get(113521),
		42014,
		19,
		273,
		{
			RTResTalkAction[10],
			RTResTalkAction[43]
		}
	},
	[42014020] = {
		42014020,
		0,
		Lang.get(113522),
		42014,
		20,
		273,
		{
			RTResTalkAction[10],
			RTResTalkAction[43]
		}
	},
	[42014021] = {
		42014021,
		0,
		"……",
		42014,
		21,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[44]
		}
	},
	[42014022] = {
		42014022,
		0,
		Lang.get(113523),
		42014,
		22,
		1023,
		{
			RTResTalkAction[45],
			RTResTalkAction[4]
		}
	},
	[42014023] = {
		42014023,
		0,
		Lang.get(113524),
		42014,
		23,
		1023,
		{
			RTResTalkAction[45]
		}
	},
	[42014024] = {
		42014024,
		0,
		"……",
		42014,
		24,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[46]
		}
	},
	[42014025] = {
		42014025,
		0,
		Lang.get(113525),
		42014,
		25,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[47]
		}
	},
	[42015001] = {
		42015001,
		3,
		Lang.get(108747),
		42015,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42019,
		nil,
		1,
		nil,
		1,
		nil,
		42019,
		nil,
		nil,
		1
	},
	[42015002] = {
		42015002,
		0,
		Lang.get(113526),
		42015,
		2,
		1169,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[42015003] = {
		42015003,
		2,
		Lang.get(113527),
		42015,
		3,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42015004] = {
		42015004,
		0,
		Lang.get(113528),
		42015,
		4,
		1169,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42015005] = {
		42015005,
		0,
		Lang.get(113529),
		42015,
		5,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42015006] = {
		42015006,
		0,
		Lang.get(113530),
		42015,
		6,
		1169,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42015007] = {
		42015007,
		2,
		Lang.get(113531),
		42015,
		7,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42015008] = {
		42015008,
		0,
		Lang.get(26760),
		42015,
		8,
		1169,
		{
			RTResTalkAction[48],
			RTResTalkAction[4]
		}
	},
	[42016001] = {
		42016001,
		3,
		Lang.get(113532),
		42016,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42020,
		nil,
		1,
		nil,
		1,
		nil,
		42020,
		nil,
		nil,
		1
	},
	[42016002] = {
		42016002,
		0,
		Lang.get(113533),
		42016,
		2,
		1297,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42016003] = {
		42016003,
		0,
		Lang.get(113534),
		42016,
		3,
		1169,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42016004] = {
		42016004,
		0,
		Lang.get(113535),
		42016,
		4,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42016005] = {
		42016005,
		0,
		Lang.get(113402),
		42016,
		5,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[49]
		}
	},
	[42016006] = {
		42016006,
		0,
		Lang.get(113536),
		42016,
		6,
		179,
		{
			RTResTalkAction[50],
			RTResTalkAction[4],
			RTResTalkAction[51]
		}
	},
	[42016007] = {
		42016007,
		0,
		Lang.get(113537),
		42016,
		7,
		179,
		{
			RTResTalkAction[50]
		}
	},
	[42016008] = {
		42016008,
		3,
		Lang.get(113538),
		42016,
		8,
		605,
		{
			RTResTalkAction[52]
		},
		[22] = 1
	},
	[42016009] = {
		42016009,
		0,
		Lang.get(113539),
		42016,
		9,
		179,
		{
			RTResTalkAction[50]
		}
	},
	[42016010] = {
		42016010,
		0,
		Lang.get(113540),
		42016,
		10,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016011] = {
		42016011,
		0,
		Lang.get(113541),
		42016,
		11,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016012] = {
		42016012,
		0,
		Lang.get(113542),
		42016,
		12,
		179,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016013] = {
		42016013,
		0,
		Lang.get(113543),
		42016,
		13,
		179,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016014] = {
		42016014,
		0,
		Lang.get(113544),
		42016,
		14,
		179,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016015] = {
		42016015,
		0,
		Lang.get(113545),
		42016,
		15,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016016] = {
		42016016,
		0,
		Lang.get(113546),
		42016,
		16,
		179,
		{
			RTResTalkAction[10],
			RTResTalkAction[53]
		}
	},
	[42016017] = {
		42016017,
		0,
		Lang.get(113547),
		42016,
		17,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[52]
		}
	},
	[42017001] = {
		42017001,
		3,
		Lang.get(113548),
		42017,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42021,
		nil,
		1,
		nil,
		1,
		nil,
		42021,
		nil,
		nil,
		1
	},
	[42017002] = {
		42017002,
		3,
		Lang.get(39489),
		42017,
		2,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[42017003] = {
		42017003,
		0,
		Lang.get(113549),
		42017,
		3,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42017004] = {
		42017004,
		0,
		Lang.get(113550),
		42017,
		4,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42017005] = {
		42017005,
		0,
		Lang.get(113551),
		42017,
		5,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42017006] = {
		42017006,
		0,
		"！",
		42017,
		6,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42017007] = {
		42017007,
		3,
		Lang.get(113552),
		42017,
		7,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42017008] = {
		42017008,
		0,
		Lang.get(113553),
		42017,
		8,
		904,
		{
			RTResTalkAction[54]
		}
	},
	[42017009] = {
		42017009,
		0,
		Lang.get(113554),
		42017,
		9,
		904,
		{
			RTResTalkAction[54]
		}
	},
	[42017010] = {
		42017010,
		0,
		Lang.get(113555),
		42017,
		10,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[42017011] = {
		42017011,
		0,
		Lang.get(113556),
		42017,
		11,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42017012] = {
		42017012,
		3,
		Lang.get(113496),
		42017,
		12,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42017013] = {
		42017013,
		0,
		Lang.get(113557),
		42017,
		13,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42017014] = {
		42017014,
		0,
		Lang.get(113558),
		42017,
		14,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[42017015] = {
		42017015,
		0,
		Lang.get(113559),
		42017,
		15,
		1276,
		{
			RTResTalkAction[56],
			RTResTalkAction[23]
		}
	},
	[42017016] = {
		42017016,
		0,
		Lang.get(113560),
		42017,
		16,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[57]
		}
	},
	[42017017] = {
		42017017,
		0,
		Lang.get(113561),
		42017,
		17,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42017018] = {
		42017018,
		0,
		Lang.get(113562),
		42017,
		18,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42017019] = {
		42017019,
		0,
		Lang.get(113563),
		42017,
		19,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42017020] = {
		42017020,
		0,
		Lang.get(113564),
		42017,
		20,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42017021] = {
		42017021,
		0,
		Lang.get(113565),
		42017,
		21,
		1118,
		{
			RTResTalkAction[10],
			RTResTalkAction[31]
		}
	},
	[42017022] = {
		42017022,
		0,
		Lang.get(113566),
		42017,
		22,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42017023] = {
		42017023,
		0,
		Lang.get(113567),
		42017,
		23,
		1237,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42017024] = {
		42017024,
		0,
		Lang.get(113568),
		42017,
		24,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[33]
		}
	},
	[42017025] = {
		42017025,
		0,
		Lang.get(113569),
		42017,
		25,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42018001] = {
		42018001,
		3,
		Lang.get(113570),
		42018,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42022,
		nil,
		1,
		nil,
		1,
		nil,
		42022,
		nil,
		nil,
		1
	},
	[42018002] = {
		42018002,
		0,
		Lang.get(113571),
		42018,
		2,
		1118,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[42018003] = {
		42018003,
		0,
		Lang.get(113572),
		42018,
		3,
		1118,
		{
			RTResTalkAction[22]
		}
	},
	[42018004] = {
		42018004,
		0,
		Lang.get(113573),
		42018,
		4,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[23]
		}
	},
	[42018005] = {
		42018005,
		0,
		Lang.get(113574),
		42018,
		5,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42018006] = {
		42018006,
		0,
		Lang.get(113575),
		42018,
		6,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42018007] = {
		42018007,
		0,
		Lang.get(113576),
		42018,
		7,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42018008] = {
		42018008,
		0,
		Lang.get(113577),
		42018,
		8,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42018009] = {
		42018009,
		0,
		Lang.get(113578),
		42018,
		9,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42018010] = {
		42018010,
		0,
		Lang.get(113579),
		42018,
		10,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42018011] = {
		42018011,
		0,
		Lang.get(113580),
		42018,
		11,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[42018012] = {
		42018012,
		0,
		Lang.get(113581),
		42018,
		12,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[23]
		}
	},
	[42018013] = {
		42018013,
		0,
		Lang.get(113582),
		42018,
		13,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42018014] = {
		42018014,
		0,
		Lang.get(113583),
		42018,
		14,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[34]
		}
	},
	[42018015] = {
		42018015,
		0,
		Lang.get(113584),
		42018,
		15,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[42018016] = {
		42018016,
		0,
		Lang.get(113585),
		42018,
		16,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[42018017] = {
		42018017,
		0,
		Lang.get(113586),
		42018,
		17,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42018018] = {
		42018018,
		0,
		Lang.get(113587),
		42018,
		18,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[42018019] = {
		42018019,
		0,
		Lang.get(113588),
		42018,
		19,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[42018020] = {
		42018020,
		0,
		Lang.get(113589),
		42018,
		20,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[42018021] = {
		42018021,
		0,
		Lang.get(113590),
		42018,
		21,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42018022] = {
		42018022,
		0,
		Lang.get(113591),
		42018,
		22,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42018023] = {
		42018023,
		0,
		Lang.get(113592),
		42018,
		23,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42018024] = {
		42018024,
		0,
		Lang.get(113593),
		42018,
		24,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42018025] = {
		42018025,
		0,
		Lang.get(113594),
		42018,
		25,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42018026] = {
		42018026,
		0,
		Lang.get(113595),
		42018,
		26,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42018027] = {
		42018027,
		0,
		Lang.get(113596),
		42018,
		27,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[42018028] = {
		42018028,
		0,
		Lang.get(113597),
		42018,
		28,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42018029] = {
		42018029,
		0,
		Lang.get(32735),
		42018,
		29,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[9]
		}
	},
	[42019001] = {
		42019001,
		0,
		Lang.get(113598),
		42019,
		1,
		226,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42023,
		nil,
		1,
		nil,
		1,
		nil,
		42023
	},
	[42019002] = {
		42019002,
		0,
		Lang.get(113599),
		42019,
		2,
		226,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42019003] = {
		42019003,
		0,
		Lang.get(113600),
		42019,
		3,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[9]
		}
	},
	[42019004] = {
		42019004,
		0,
		Lang.get(113601),
		42019,
		4,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[23]
		}
	},
	[42019005] = {
		42019005,
		0,
		Lang.get(18140),
		42019,
		5,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[9]
		}
	},
	[42019006] = {
		42019006,
		0,
		Lang.get(113602),
		42019,
		6,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42019007] = {
		42019007,
		0,
		Lang.get(113603),
		42019,
		7,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42019008] = {
		42019008,
		0,
		Lang.get(35435),
		42019,
		8,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42019009] = {
		42019009,
		0,
		Lang.get(113604),
		42019,
		9,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42019010] = {
		42019010,
		0,
		Lang.get(113605),
		42019,
		10,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42019011] = {
		42019011,
		0,
		Lang.get(113606),
		42019,
		11,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42019012] = {
		42019012,
		0,
		Lang.get(113607),
		42019,
		12,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42019013] = {
		42019013,
		0,
		Lang.get(113608),
		42019,
		13,
		1237,
		{
			RTResTalkAction[35]
		}
	},
	[42019014] = {
		42019014,
		0,
		Lang.get(113609),
		42019,
		14,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42019015] = {
		42019015,
		0,
		Lang.get(34907),
		42019,
		15,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[42019016] = {
		42019016,
		0,
		Lang.get(113610),
		42019,
		16,
		605,
		{
			RTResTalkAction[21]
		}
	},
	[42019017] = {
		42019017,
		0,
		Lang.get(113611),
		42019,
		17,
		226,
		{
			RTResTalkAction[8]
		}
	},
	[42019018] = {
		42019018,
		0,
		Lang.get(113612),
		42019,
		18,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[9]
		}
	},
	[42019019] = {
		42019019,
		0,
		Lang.get(113613),
		42019,
		19,
		226,
		{
			RTResTalkAction[8],
			RTResTalkAction[23]
		}
	},
	[42019020] = {
		42019020,
		0,
		Lang.get(113614),
		42019,
		20,
		605,
		{
			RTResTalkAction[9]
		}
	},
	[42019021] = {
		42019021,
		0,
		Lang.get(113615),
		42019,
		21,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42019022] = {
		42019022,
		0,
		Lang.get(113616),
		42019,
		22,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42019023] = {
		42019023,
		0,
		Lang.get(113617),
		42019,
		23,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[34]
		}
	},
	[42019024] = {
		42019024,
		0,
		Lang.get(113618),
		42019,
		24,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[42019025] = {
		42019025,
		0,
		Lang.get(113619),
		42019,
		25,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[34]
		}
	},
	[42019026] = {
		42019026,
		0,
		Lang.get(113620),
		42019,
		26,
		605,
		{
			RTResTalkAction[21]
		}
	},
	[42019027] = {
		42019027,
		0,
		Lang.get(113621),
		42019,
		27,
		1195,
		{
			RTResTalkAction[19]
		}
	},
	[42019028] = {
		42019028,
		0,
		Lang.get(113622),
		42019,
		28,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[21]
		}
	},
	[42019029] = {
		42019029,
		0,
		Lang.get(113623),
		42019,
		29,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[13]
		}
	},
	[42019030] = {
		42019030,
		0,
		Lang.get(113624),
		42019,
		30,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[4]
		}
	},
	[42019031] = {
		42019031,
		0,
		Lang.get(113625),
		42019,
		31,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[13]
		}
	},
	[42019032] = {
		42019032,
		0,
		Lang.get(113626),
		42019,
		32,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[4]
		}
	},
	[42019033] = {
		42019033,
		0,
		Lang.get(113627),
		42019,
		33,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[42019034] = {
		42019034,
		0,
		Lang.get(113628),
		42019,
		34,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[23]
		}
	},
	[42019035] = {
		42019035,
		0,
		Lang.get(113629),
		42019,
		35,
		143,
		{
			RTResTalkAction[14]
		}
	},
	[42019036] = {
		42019036,
		0,
		Lang.get(113630),
		42019,
		36,
		143,
		{
			RTResTalkAction[14]
		}
	},
	[42019037] = {
		42019037,
		0,
		Lang.get(113631),
		42019,
		37,
		1195,
		{
			RTResTalkAction[19],
			RTResTalkAction[13]
		}
	},
	[42019038] = {
		42019038,
		0,
		Lang.get(113632),
		42019,
		38,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[42019039] = {
		42019039,
		0,
		Lang.get(113633),
		42019,
		39,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42019040] = {
		42019040,
		0,
		Lang.get(113634),
		42019,
		40,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42019041] = {
		42019041,
		0,
		Lang.get(113635),
		42019,
		41,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42019042] = {
		42019042,
		0,
		Lang.get(113636),
		42019,
		42,
		1118,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[42019043] = {
		42019043,
		0,
		Lang.get(113637),
		42019,
		43,
		1237,
		{
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[42020001] = {
		42020001,
		3,
		Lang.get(113638),
		42020,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		212,
		42024,
		nil,
		1,
		nil,
		1,
		nil,
		42024,
		nil,
		nil,
		1
	},
	[42020002] = {
		42020002,
		0,
		Lang.get(113639),
		42020,
		2,
		904,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[42020003] = {
		42020003,
		0,
		Lang.get(113640),
		42020,
		3,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[42020004] = {
		42020004,
		0,
		Lang.get(113641),
		42020,
		4,
		904,
		{
			RTResTalkAction[54],
			RTResTalkAction[4]
		}
	},
	[42020005] = {
		42020005,
		0,
		Lang.get(113642),
		42020,
		5,
		904,
		{
			RTResTalkAction[54]
		}
	},
	[42020006] = {
		42020006,
		0,
		Lang.get(113643),
		42020,
		6,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[42020007] = {
		42020007,
		3,
		Lang.get(113644),
		42020,
		7,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42020008] = {
		42020008,
		0,
		Lang.get(113645),
		42020,
		8,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42020009] = {
		42020009,
		0,
		Lang.get(113646),
		42020,
		9,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020010] = {
		42020010,
		0,
		"？！",
		42020,
		10,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020011] = {
		42020011,
		0,
		Lang.get(113647),
		42020,
		11,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020012] = {
		42020012,
		0,
		Lang.get(113648),
		42020,
		12,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020013] = {
		42020013,
		0,
		Lang.get(113649),
		42020,
		13,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020014] = {
		42020014,
		0,
		Lang.get(113650),
		42020,
		14,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020015] = {
		42020015,
		0,
		Lang.get(113651),
		42020,
		15,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020016] = {
		42020016,
		0,
		Lang.get(113652),
		42020,
		16,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020017] = {
		42020017,
		0,
		Lang.get(113653),
		42020,
		17,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020018] = {
		42020018,
		0,
		Lang.get(113654),
		42020,
		18,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020019] = {
		42020019,
		0,
		Lang.get(113655),
		42020,
		19,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020020] = {
		42020020,
		0,
		Lang.get(113656),
		42020,
		20,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[29]
		}
	},
	[42020021] = {
		42020021,
		0,
		Lang.get(113657),
		42020,
		21,
		1297,
		{
			RTResTalkAction[5]
		}
	},
	[42020022] = {
		42020022,
		0,
		Lang.get(113658),
		42020,
		22,
		904,
		{
			RTResTalkAction[54],
			RTResTalkAction[4]
		}
	},
	[42020023] = {
		42020023,
		0,
		Lang.get(113659),
		42020,
		23,
		904,
		{
			RTResTalkAction[54]
		}
	},
	[42020024] = {
		42020024,
		0,
		Lang.get(113660),
		42020,
		24,
		904,
		{
			RTResTalkAction[54]
		}
	},
	[42020025] = {
		42020025,
		0,
		"！",
		42020,
		25,
		1071,
		{
			RTResTalkAction[28],
			RTResTalkAction[55]
		}
	},
	[42020026] = {
		42020026,
		0,
		Lang.get(113661),
		42020,
		26,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[29]
		}
	},
	[42020027] = {
		42020027,
		0,
		Lang.get(18140),
		42020,
		27,
		1071,
		{
			RTResTalkAction[28],
			RTResTalkAction[4]
		}
	},
	[42020028] = {
		42020028,
		0,
		Lang.get(113662),
		42020,
		28,
		904,
		{
			RTResTalkAction[54],
			RTResTalkAction[29]
		}
	},
	[42020029] = {
		42020029,
		0,
		Lang.get(21029),
		42020,
		29,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[55]
		}
	},
	[42020030] = {
		42020030,
		3,
		Lang.get(113663),
		42020,
		30,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42020031] = {
		42020031,
		0,
		Lang.get(113664),
		42020,
		31,
		1071,
		{
			RTResTalkAction[28]
		}
	},
	[42020032] = {
		42020032,
		0,
		Lang.get(113665),
		42020,
		32,
		1297,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020033] = {
		42020033,
		0,
		Lang.get(113666),
		42020,
		33,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020034] = {
		42020034,
		0,
		Lang.get(113667),
		42020,
		34,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020035] = {
		42020035,
		0,
		Lang.get(113668),
		42020,
		35,
		1071,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		}
	},
	[42020036] = {
		42020036,
		0,
		Lang.get(113669),
		42020,
		36,
		1297,
		{
			RTResTalkAction[5],
			RTResTalkAction[29]
		}
	},
	[42020037] = {
		42020037,
		3,
		Lang.get(113670),
		42020,
		37,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[42021001] = {
		42021001,
		3,
		Lang.get(113671),
		42021,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		212,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		42025,
		nil,
		nil,
		1
	},
	[42021002] = {
		42021002,
		0,
		Lang.get(113672),
		42021,
		2,
		1297,
		nil,
		1
	},
	[42021003] = {
		42021003,
		0,
		Lang.get(113673),
		42021,
		3,
		nil,
		nil,
		1
	},
	[42021004] = {
		42021004,
		0,
		"！",
		42021,
		4,
		1297,
		nil,
		1
	},
	[42021005] = {
		42021005,
		3,
		Lang.get(113674),
		42021,
		5,
		605,
		[22] = 1
	},
	[42021006] = {
		42021006,
		0,
		Lang.get(113675),
		42021,
		6,
		1297,
		nil,
		1
	},
	[42021007] = {
		42021007,
		0,
		Lang.get(113676),
		42021,
		7,
		898,
		nil,
		1
	},
	[42021008] = {
		42021008,
		0,
		Lang.get(113677),
		42021,
		8,
		1297,
		nil,
		1
	},
	[42021009] = {
		42021009,
		0,
		Lang.get(113678),
		42021,
		9,
		1297,
		nil,
		1
	},
	[42021010] = {
		42021010,
		0,
		Lang.get(113679),
		42021,
		10,
		1297,
		nil,
		1
	},
	[42021011] = {
		42021011,
		0,
		Lang.get(113680),
		42021,
		11,
		898,
		nil,
		1
	},
	[42021012] = {
		42021012,
		0,
		"……",
		42021,
		12,
		1297,
		nil,
		1
	},
	[42021013] = {
		42021013,
		0,
		Lang.get(113681),
		42021,
		13,
		898,
		nil,
		1
	},
	[42021014] = {
		42021014,
		0,
		Lang.get(113682),
		42021,
		14,
		898,
		nil,
		1
	},
	[42021015] = {
		42021015,
		0,
		Lang.get(113683),
		42021,
		15,
		898,
		nil,
		1
	},
	[42021016] = {
		42021016,
		0,
		Lang.get(113684),
		42021,
		16,
		1297,
		nil,
		1
	},
	[42021017] = {
		42021017,
		0,
		Lang.get(113685),
		42021,
		17,
		898,
		nil,
		1
	},
	[42021018] = {
		42021018,
		3,
		Lang.get(113686),
		42021,
		18,
		605,
		[22] = 1
	},
	[42021019] = {
		42021019,
		0,
		Lang.get(113687),
		42021,
		19,
		898,
		nil,
		1
	},
	[42021020] = {
		42021020,
		0,
		Lang.get(32285),
		42021,
		20,
		1297,
		nil,
		1
	},
	[42021021] = {
		42021021,
		3,
		Lang.get(113688),
		42021,
		21,
		605,
		[22] = 1
	},
	[42021022] = {
		42021022,
		0,
		Lang.get(113689),
		42021,
		22,
		1118,
		nil,
		1
	},
	[42021023] = {
		42021023,
		0,
		Lang.get(113690),
		42021,
		23,
		1237,
		nil,
		1
	},
	[42021024] = {
		42021024,
		0,
		Lang.get(113691),
		42021,
		24,
		1195,
		nil,
		1
	},
	[42021025] = {
		42021025,
		0,
		Lang.get(113692),
		42021,
		25,
		1297,
		nil,
		1
	},
	[42021026] = {
		42021026,
		3,
		Lang.get(113693),
		42021,
		26,
		605,
		[22] = 1
	},
	[42021027] = {
		42021027,
		3,
		Lang.get(113694),
		42021,
		27,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		42026,
		nil,
		1,
		nil,
		1,
		nil,
		42026,
		nil,
		nil,
		1
	},
	[42021028] = {
		42021028,
		0,
		Lang.get(113695),
		42021,
		28,
		1071,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42021029] = {
		42021029,
		0,
		Lang.get(113696),
		42021,
		29,
		194,
		{
			RTResTalkAction[58],
			RTResTalkAction[29]
		}
	},
	[42021030] = {
		42021030,
		0,
		Lang.get(113697),
		42021,
		30,
		1071,
		{
			RTResTalkAction[28],
			RTResTalkAction[59]
		}
	},
	[42021031] = {
		42021031,
		0,
		Lang.get(113698),
		42021,
		31,
		194,
		{
			RTResTalkAction[58],
			RTResTalkAction[29]
		}
	}
}
local metaTableResTalkAction = {
	__index = function(table, key)
		local keyIndexRT = indexMapResTalkAction[key]

		if not keyIndexRT then
			return nil
		end

		return table[keyIndexRT]
	end
}

for k, v in pairs(RTResTalkAction) do
	setmetatable(v, metaTableResTalkAction)
end

local metaTable = {
	__index = function(table, key)
		local keyIndex = indexMap[key]

		if not keyIndex then
			return nil
		end

		return table[keyIndex]
	end
}

for k, v in pairs(Data) do
	setmetatable(v, metaTable)
end

return Data
