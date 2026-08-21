-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\4to6\\ResTalk.lua

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
	1,
	107,
	{
		1,
		10021
	},
	nil,
	1
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[6] = {
	1,
	107,
	{
		3,
		10041
	},
	nil,
	3
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 511
}
RTResTalkAction[8] = {
	1,
	107,
	{
		10041
	},
	nil,
	4
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 511
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 664
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[13] = {
	1,
	107,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[16] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 508
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 508
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 508
}
RTResTalkAction[23] = {
	1,
	122,
	nil,
	nil,
	2
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 122
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 122
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 122
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		10021,
		1
	}
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 125
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 125
}
RTResTalkAction[31] = {
	[1] = 2,
	[2] = 123
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 125
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 164
}
RTResTalkAction[34] = {
	[1] = 2,
	[2] = 164
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 164
}
RTResTalkAction[36] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[37] = {
	1,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 124,
	[3] = {
		1
	}
}
RTResTalkAction[39] = {
	[1] = 2,
	[2] = 124
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 109
}
RTResTalkAction[41] = {
	2,
	107,
	{
		10041
	},
	nil,
	2
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 124
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 109
}
RTResTalkAction[44] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 109
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 360
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 360
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		10031
	}
}
RTResTalkAction[51] = {
	1,
	107,
	{
		10021
	},
	nil,
	0
}
RTResTalkAction[52] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[53] = {
	1,
	107,
	{
		10031,
		1
	},
	nil,
	5
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[55] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		10052
	}
}
RTResTalkAction[56] = {
	2,
	107,
	{
		10011
	},
	nil,
	1
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[58] = {
	2,
	107,
	{
		10031
	},
	nil,
	6
}
RTResTalkAction[59] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		0
	}
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 122,
	[3] = {
		10018
	}
}
RTResTalkAction[61] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[62] = {
	[1] = 2,
	[2] = 122
}
RTResTalkAction[63] = {
	3,
	143,
	nil,
	nil,
	4
}
RTResTalkAction[64] = {
	2,
	122,
	{
		10038
	},
	nil,
	2
}
RTResTalkAction[65] = {
	1,
	107,
	{
		10041
	},
	nil,
	1
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[67] = {
	2,
	107,
	{
		10031,
		1
	},
	nil,
	0
}
RTResTalkAction[68] = {
	[1] = 2,
	[2] = 143
}
RTResTalkAction[69] = {
	[1] = 3,
	[2] = 109,
	[3] = {
		1
	}
}
RTResTalkAction[70] = {
	1,
	143,
	{
		10027
	},
	nil,
	3
}
RTResTalkAction[71] = {
	2,
	143,
	nil,
	nil,
	0
}
RTResTalkAction[72] = {
	[1] = 2,
	[2] = 143,
	[3] = {
		10047
	}
}

local Data = {
	[2300001] = {
		2300001,
		0,
		Lang.get(38136),
		2300,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		2300,
		nil,
		nil,
		nil,
		1,
		nil,
		2300
	},
	[2300002] = {
		2300002,
		0,
		Lang.get(38137),
		2300,
		2,
		350,
		nil,
		1
	},
	[2300003] = {
		2300003,
		0,
		Lang.get(38138),
		2300,
		3,
		117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2301,
		[19] = 2301,
		[17] = 1
	},
	[2300004] = {
		2300004,
		0,
		Lang.get(38139),
		2300,
		4,
		302,
		nil,
		1
	},
	[2300005] = {
		2300005,
		0,
		Lang.get(38140),
		2300,
		5,
		117,
		nil,
		1
	},
	[2300006] = {
		2300006,
		0,
		Lang.get(38141),
		2300,
		6,
		148,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		2302,
		[19] = 2302,
		[17] = 1
	},
	[2300007] = {
		2300007,
		0,
		Lang.get(38142),
		2300,
		7,
		112,
		nil,
		1
	},
	[2300008] = {
		2300008,
		0,
		Lang.get(38143),
		2300,
		8,
		148,
		nil,
		1,
		nil,
		3
	},
	[2300009] = {
		2300009,
		0,
		Lang.get(38144),
		2300,
		9,
		352,
		nil,
		1
	},
	[2300010] = {
		2300010,
		0,
		Lang.get(38145),
		2300,
		10,
		112,
		nil,
		1
	},
	[2300011] = {
		2300011,
		0,
		Lang.get(38146),
		2300,
		11,
		352,
		nil,
		1
	},
	[2300012] = {
		2300012,
		0,
		Lang.get(38147),
		2300,
		12,
		353,
		nil,
		1
	},
	[2300013] = {
		2300013,
		0,
		Lang.get(38148),
		2300,
		13,
		352,
		nil,
		1
	},
	[2300014] = {
		2300014,
		0,
		Lang.get(38149),
		2300,
		14,
		356,
		nil,
		1
	},
	[2300015] = {
		2300015,
		0,
		Lang.get(46212),
		2300,
		15,
		148,
		nil,
		1
	},
	[2301001] = {
		2301001,
		0,
		Lang.get(38150),
		2301,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		54,
		2316,
		0.2,
		nil,
		nil,
		1,
		nil,
		2316
	},
	[2301002] = {
		2301002,
		0,
		Lang.get(38151),
		2301,
		2,
		141,
		nil,
		1
	},
	[2301003] = {
		2301003,
		5,
		Lang.get(17501),
		2301,
		3,
		508,
		nil,
		1,
		nil,
		nil,
		1013,
		63
	},
	[2301004] = {
		2301004,
		0,
		Lang.get(17502),
		2301,
		4,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[2301005] = {
		2301005,
		0,
		Lang.get(17503),
		2301,
		5,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[2301006] = {
		2301006,
		0,
		Lang.get(17504),
		2301,
		6,
		511,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2303,
		0.2,
		1,
		nil,
		nil,
		nil,
		2303
	},
	[2301007] = {
		2301007,
		0,
		Lang.get(17505),
		2301,
		7,
		511,
		nil,
		1
	},
	[2301008] = {
		2301008,
		5,
		Lang.get(17506),
		2301,
		8,
		508,
		nil,
		1
	},
	[2301009] = {
		2301009,
		5,
		Lang.get(17507),
		2301,
		9,
		107,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[2301010] = {
		2301010,
		0,
		Lang.get(38152),
		2301,
		10,
		511,
		{
			RTResTalkAction[7],
			RTResTalkAction[4]
		}
	},
	[2301011] = {
		2301011,
		0,
		Lang.get(17509),
		2301,
		11,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[2301012] = {
		2301012,
		0,
		Lang.get(38153),
		2301,
		12,
		123,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2304,
		0.2,
		1,
		nil,
		1,
		nil,
		2304
	},
	[2301013] = {
		2301013,
		0,
		Lang.get(38154),
		2301,
		13,
		107,
		nil,
		1
	},
	[2301014] = {
		2301014,
		0,
		Lang.get(38155),
		2301,
		14,
		123,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[2301015] = {
		2301015,
		0,
		Lang.get(38156),
		2301,
		15,
		664,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[2301016] = {
		2301016,
		0,
		Lang.get(38157),
		2301,
		16,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[2301017] = {
		2301017,
		0,
		Lang.get(38158),
		2301,
		17,
		664,
		{
			RTResTalkAction[11],
			RTResTalkAction[4]
		}
	},
	[2301018] = {
		2301018,
		0,
		Lang.get(38159),
		2301,
		18,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[2301019] = {
		2301019,
		0,
		Lang.get(38160),
		2301,
		19,
		141,
		{
			RTResTalkAction[15],
			RTResTalkAction[12]
		}
	},
	[2301020] = {
		2301020,
		0,
		Lang.get(38161),
		2301,
		20,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[5]
		}
	},
	[2301021] = {
		2301021,
		0,
		Lang.get(38162),
		2301,
		21,
		664,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[2301022] = {
		2301022,
		0,
		Lang.get(38163),
		2301,
		22,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[14]
		}
	},
	[2302001] = {
		2302001,
		0,
		Lang.get(38164),
		2302,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		2305,
		0.2,
		1,
		nil,
		1,
		nil,
		2305
	},
	[2302002] = {
		2302002,
		0,
		Lang.get(38165),
		2302,
		2,
		300
	},
	[2302003] = {
		2302003,
		2,
		Lang.get(38166),
		2302,
		3,
		508,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[2302004] = {
		2302004,
		0,
		Lang.get(38167),
		2302,
		4,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[2302005] = {
		2302005,
		2,
		Lang.get(38168),
		2302,
		5,
		107,
		{
			RTResTalkAction[18]
		}
	},
	[2302006] = {
		2302006,
		0,
		Lang.get(38169),
		2302,
		6,
		107,
		{
			RTResTalkAction[18]
		}
	},
	[2302007] = {
		2302007,
		0,
		Lang.get(38170),
		2302,
		7,
		151,
		{
			RTResTalkAction[20],
			RTResTalkAction[4]
		}
	},
	[2302008] = {
		2302008,
		0,
		Lang.get(38171),
		2302,
		8,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[2302009] = {
		2302009,
		0,
		Lang.get(38172),
		2302,
		9,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[2302010] = {
		2302010,
		0,
		Lang.get(38173),
		2302,
		10,
		508,
		{
			RTResTalkAction[17]
		}
	},
	[2302011] = {
		2302011,
		0,
		Lang.get(38174),
		2302,
		11,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[22]
		}
	},
	[2302012] = {
		2302012,
		7,
		"1",
		2302,
		12,
		122,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
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
	[2302013] = {
		2302013,
		0,
		Lang.get(17511),
		2302,
		13,
		122,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[2302014] = {
		2302014,
		0,
		Lang.get(38175),
		2302,
		14,
		122,
		{
			RTResTalkAction[24]
		}
	},
	[2302015] = {
		2302015,
		0,
		Lang.get(38176),
		2302,
		15,
		122,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[2302016] = {
		2302016,
		0,
		Lang.get(45327),
		2302,
		16,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[26]
		}
	},
	[2302017] = {
		2302017,
		0,
		Lang.get(45328),
		2302,
		17,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[2302018] = {
		2302018,
		0,
		Lang.get(45329),
		2302,
		18,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[5]
		}
	},
	[2302019] = {
		2302019,
		0,
		Lang.get(45330),
		2302,
		19,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[2302020] = {
		2302020,
		0,
		Lang.get(45331),
		2302,
		20,
		122,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[2302021] = {
		2302021,
		0,
		"……",
		2302,
		21,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3],
			RTResTalkAction[26]
		}
	},
	[2302022] = {
		2302022,
		0,
		Lang.get(38178),
		2302,
		22,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[27]
		}
	},
	[2302023] = {
		2302023,
		0,
		Lang.get(17518),
		2302,
		23,
		122,
		{
			RTResTalkAction[28],
			RTResTalkAction[25],
			RTResTalkAction[4]
		}
	},
	[2302024] = {
		2302024,
		0,
		Lang.get(17519),
		2302,
		24,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[2302025] = {
		2302025,
		0,
		Lang.get(38179),
		2302,
		25,
		664,
		{
			RTResTalkAction[5],
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2306,
		0.2,
		1,
		nil,
		1,
		nil,
		2306
	},
	[2302026] = {
		2302026,
		0,
		Lang.get(38180),
		2302,
		26,
		123,
		nil,
		1
	},
	[2302027] = {
		2302027,
		0,
		Lang.get(38181),
		2302,
		27,
		664,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[2302028] = {
		2302028,
		0,
		Lang.get(38182),
		2302,
		28,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[14]
		}
	},
	[2302029] = {
		2302029,
		0,
		Lang.get(38183),
		2302,
		29,
		125,
		{
			RTResTalkAction[29],
			RTResTalkAction[12]
		}
	},
	[2302030] = {
		2302030,
		0,
		Lang.get(38184),
		2302,
		30,
		123,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2307,
		0.2,
		1,
		nil,
		1,
		nil,
		2307
	},
	[2302031] = {
		2302031,
		0,
		Lang.get(38185),
		2302,
		31,
		125,
		nil,
		1
	},
	[2302032] = {
		2302032,
		0,
		Lang.get(38186),
		2302,
		32,
		123,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[2302033] = {
		2302033,
		0,
		Lang.get(38187),
		2302,
		33,
		125,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302034] = {
		2302034,
		0,
		Lang.get(38188),
		2302,
		34,
		123,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302035] = {
		2302035,
		0,
		Lang.get(38189),
		2302,
		35,
		125,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302036] = {
		2302036,
		0,
		Lang.get(38190),
		2302,
		36,
		664,
		{
			RTResTalkAction[11],
			RTResTalkAction[12],
			RTResTalkAction[30]
		}
	},
	[2302037] = {
		2302037,
		0,
		Lang.get(38191),
		2302,
		37,
		125,
		{
			RTResTalkAction[29],
			RTResTalkAction[14]
		}
	},
	[2302038] = {
		2302038,
		0,
		Lang.get(38192),
		2302,
		38,
		123,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302039] = {
		2302039,
		0,
		Lang.get(38193),
		2302,
		39,
		125,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302040] = {
		2302040,
		0,
		Lang.get(38194),
		2302,
		40,
		123,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[2302041] = {
		2302041,
		0,
		Lang.get(46213),
		2302,
		41,
		125,
		{
			RTResTalkAction[29],
			RTResTalkAction[12]
		}
	},
	[2302042] = {
		2302042,
		0,
		Lang.get(38195),
		2302,
		42,
		123,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2308,
		0.2,
		1,
		nil,
		1,
		nil,
		2308
	},
	[2302043] = {
		2302043,
		0,
		Lang.get(46214),
		2302,
		43,
		664,
		nil,
		1
	},
	[2303001] = {
		2303001,
		0,
		Lang.get(38196),
		2303,
		1,
		164,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		nil,
		0.2,
		1,
		nil,
		1,
		nil,
		2309
	},
	[2303002] = {
		2303002,
		0,
		Lang.get(38197),
		2303,
		2,
		125,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303003] = {
		2303003,
		0,
		Lang.get(38198),
		2303,
		3,
		164,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303004] = {
		2303004,
		0,
		Lang.get(38199),
		2303,
		4,
		125,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303005] = {
		2303005,
		0,
		Lang.get(38200),
		2303,
		5,
		164,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303006] = {
		2303006,
		0,
		Lang.get(38201),
		2303,
		6,
		125,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303007] = {
		2303007,
		0,
		Lang.get(38202),
		2303,
		7,
		164,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303008] = {
		2303008,
		0,
		Lang.get(38203),
		2303,
		8,
		164,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2303009] = {
		2303009,
		0,
		Lang.get(38204),
		2303,
		9,
		122,
		{
			RTResTalkAction[35],
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2310,
		0.2,
		1,
		nil,
		1,
		nil,
		2310
	},
	[2303010] = {
		2303010,
		0,
		Lang.get(38205),
		2303,
		10,
		143,
		nil,
		1
	},
	[2303011] = {
		2303011,
		0,
		Lang.get(38206),
		2303,
		11,
		122,
		nil,
		1,
		nil,
		3
	},
	[2303012] = {
		2303012,
		0,
		Lang.get(38207),
		2303,
		12,
		141,
		{
			RTResTalkAction[15]
		}
	},
	[2303013] = {
		2303013,
		0,
		Lang.get(46215),
		2303,
		13,
		107,
		{
			RTResTalkAction[36],
			RTResTalkAction[5]
		}
	},
	[2303014] = {
		2303014,
		0,
		Lang.get(38208),
		2303,
		14,
		141,
		{
			RTResTalkAction[15],
			RTResTalkAction[4]
		}
	},
	[2303015] = {
		2303015,
		0,
		Lang.get(38209),
		2303,
		15,
		107,
		{
			RTResTalkAction[37],
			RTResTalkAction[5]
		}
	},
	[2303016] = {
		2303016,
		0,
		Lang.get(38210),
		2303,
		16,
		164,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		2311,
		0.2,
		1,
		nil,
		1,
		nil,
		2311
	},
	[2304001] = {
		2304001,
		0,
		Lang.get(18284),
		2304,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		53,
		nil,
		0.2,
		1,
		nil,
		1,
		nil,
		2312
	},
	[2304002] = {
		2304002,
		0,
		Lang.get(18285),
		2304,
		2,
		509,
		nil,
		1
	},
	[2304003] = {
		2304003,
		0,
		Lang.get(18286),
		2304,
		3,
		124,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[2304004] = {
		2304004,
		0,
		Lang.get(18287),
		2304,
		4,
		109,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304005] = {
		2304005,
		0,
		Lang.get(18288),
		2304,
		5,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304006] = {
		2304006,
		0,
		Lang.get(18289),
		2304,
		6,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304007] = {
		2304007,
		0,
		Lang.get(18290),
		2304,
		7,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304008] = {
		2304008,
		0,
		Lang.get(18291),
		2304,
		8,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304009] = {
		2304009,
		0,
		Lang.get(18292),
		2304,
		9,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304010] = {
		2304010,
		0,
		Lang.get(18293),
		2304,
		10,
		124,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304011] = {
		2304011,
		0,
		"……",
		2304,
		11,
		109,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[2304012] = {
		2304012,
		0,
		Lang.get(18294),
		2304,
		12,
		107,
		{
			RTResTalkAction[41],
			RTResTalkAction[3],
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[2304013] = {
		2304013,
		0,
		Lang.get(18295),
		2304,
		13,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[2304014] = {
		2304014,
		0,
		Lang.get(38211),
		2304,
		14,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[2304015] = {
		2304015,
		0,
		Lang.get(18297),
		2304,
		15,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[3]
		}
	},
	[2304016] = {
		2304016,
		0,
		Lang.get(38212),
		2304,
		16,
		164,
		{
			RTResTalkAction[33],
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		0.2,
		1,
		nil,
		1,
		nil,
		2313
	},
	[2304017] = {
		2304017,
		0,
		Lang.get(38213),
		2304,
		17,
		125,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2304018] = {
		2304018,
		0,
		Lang.get(38214),
		2304,
		18,
		164,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2304019] = {
		2304019,
		0,
		Lang.get(38215),
		2304,
		19,
		125,
		{
			RTResTalkAction[34],
			RTResTalkAction[32]
		}
	},
	[2305001] = {
		2305001,
		0,
		Lang.get(38216),
		2305,
		1,
		164,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		2314,
		0.2,
		1,
		nil,
		1,
		nil,
		2314
	},
	[2305002] = {
		2305002,
		0,
		Lang.get(38217),
		2305,
		2,
		123,
		nil,
		1
	},
	[2305003] = {
		2305003,
		0,
		Lang.get(38218),
		2305,
		3,
		164,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[2305004] = {
		2305004,
		0,
		Lang.get(38219),
		2305,
		4,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[35]
		}
	},
	[2305005] = {
		2305005,
		0,
		Lang.get(38220),
		2305,
		5,
		164,
		{
			RTResTalkAction[33],
			RTResTalkAction[12]
		}
	},
	[2305006] = {
		2305006,
		0,
		Lang.get(38221),
		2305,
		6,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[35]
		}
	},
	[2305007] = {
		2305007,
		0,
		Lang.get(38222),
		2305,
		7,
		164,
		{
			RTResTalkAction[33],
			RTResTalkAction[12]
		}
	},
	[2305008] = {
		2305008,
		0,
		Lang.get(38223),
		2305,
		8,
		123,
		{
			RTResTalkAction[10],
			RTResTalkAction[35]
		}
	},
	[2305009] = {
		2305009,
		0,
		Lang.get(38224),
		2305,
		9,
		123,
		{
			RTResTalkAction[10]
		}
	},
	[2305010] = {
		2305010,
		0,
		Lang.get(38225),
		2305,
		10,
		164,
		{
			RTResTalkAction[33],
			RTResTalkAction[12]
		}
	},
	[2305011] = {
		2305011,
		0,
		Lang.get(38226),
		2305,
		11,
		164,
		{
			RTResTalkAction[33]
		}
	},
	[2305012] = {
		2305012,
		0,
		Lang.get(38227),
		2305,
		12,
		164,
		{
			RTResTalkAction[33]
		}
	},
	[2305013] = {
		2305013,
		0,
		Lang.get(38228),
		2305,
		13,
		107,
		{
			RTResTalkAction[35]
		},
		1,
		nil,
		nil,
		nil,
		62,
		2315,
		0.2,
		1,
		nil,
		1,
		nil,
		2315
	},
	[2305014] = {
		2305014,
		0,
		Lang.get(38229),
		2305,
		14,
		109,
		nil,
		1
	},
	[2305015] = {
		2305015,
		0,
		Lang.get(38230),
		2305,
		15,
		300,
		nil,
		nil,
		nil,
		3
	},
	[2305016] = {
		2305016,
		0,
		Lang.get(46216),
		2305,
		16,
		109,
		{
			RTResTalkAction[45]
		}
	},
	[2305017] = {
		2305017,
		0,
		Lang.get(38231),
		2305,
		17,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[2305018] = {
		2305018,
		0,
		Lang.get(38232),
		2305,
		18,
		109,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[2305019] = {
		2305019,
		0,
		Lang.get(38233),
		2305,
		19,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[43]
		}
	},
	[2305020] = {
		2305020,
		0,
		Lang.get(38234),
		2305,
		20,
		300
	},
	[2305021] = {
		2305021,
		0,
		Lang.get(38235),
		2305,
		21,
		109,
		{
			RTResTalkAction[45]
		}
	},
	[2305022] = {
		2305022,
		0,
		Lang.get(38236),
		2305,
		22,
		300,
		{
			RTResTalkAction[43]
		}
	},
	[2305023] = {
		2305023,
		0,
		Lang.get(38237),
		2305,
		23,
		109,
		{
			RTResTalkAction[45]
		}
	},
	[2305024] = {
		2305024,
		0,
		nil,
		2305,
		24,
		376,
		{
			RTResTalkAction[46],
			RTResTalkAction[43]
		},
		[27] = 1,
		[20] = 220
	},
	[2305025] = {
		2305025,
		13,
		Lang.get(38238),
		2305,
		25,
		360,
		{
			RTResTalkAction[47],
			RTResTalkAction[48]
		},
		[27] = 3
	},
	[2305026] = {
		2305026,
		4,
		nil,
		2305,
		26,
		360,
		{
			RTResTalkAction[47]
		},
		[27] = 3,
		[29] = {
			{
				id = 2305027,
				branch_content = Lang.get(8)
			}
		}
	},
	[2305027] = {
		2305027,
		13,
		Lang.get(38240),
		2305,
		27,
		360,
		{
			RTResTalkAction[47]
		},
		[27] = 3
	},
	[2305028] = {
		2305028,
		12,
		"4",
		2305,
		28,
		360,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[2305029] = {
		2305029,
		0,
		Lang.get(45301),
		2305,
		29,
		107,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = -1
	},
	[2305030] = {
		2305030,
		0,
		Lang.get(18186),
		2305,
		30,
		107,
		{
			RTResTalkAction[51]
		}
	},
	[2305031] = {
		2305031,
		0,
		Lang.get(18187),
		2305,
		31,
		134,
		{
			RTResTalkAction[2],
			RTResTalkAction[52]
		}
	},
	[2305032] = {
		2305032,
		0,
		Lang.get(18188),
		2305,
		32,
		107,
		{
			RTResTalkAction[53],
			RTResTalkAction[54]
		}
	},
	[2305033] = {
		2305033,
		0,
		Lang.get(18189),
		2305,
		33,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[55]
		}
	},
	[2305034] = {
		2305034,
		0,
		Lang.get(18190),
		2305,
		34,
		107,
		{
			RTResTalkAction[56],
			RTResTalkAction[3]
		}
	},
	[2305035] = {
		2305035,
		0,
		Lang.get(46217),
		2305,
		35,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[57]
		}
	},
	[2305036] = {
		2305036,
		0,
		Lang.get(18192),
		2305,
		36,
		107,
		{
			RTResTalkAction[58],
			RTResTalkAction[3]
		}
	},
	[2305037] = {
		2305037,
		0,
		Lang.get(18193),
		2305,
		37,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[59]
		}
	},
	[2305038] = {
		2305038,
		0,
		Lang.get(18194),
		2305,
		38,
		122,
		{
			RTResTalkAction[60],
			RTResTalkAction[61],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[2305039] = {
		2305039,
		0,
		Lang.get(18195),
		2305,
		39,
		143,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[2305040] = {
		2305040,
		0,
		Lang.get(18196),
		2305,
		40,
		122,
		{
			RTResTalkAction[64],
			RTResTalkAction[61]
		}
	},
	[2305041] = {
		2305041,
		0,
		Lang.get(18197),
		2305,
		41,
		107,
		{
			RTResTalkAction[65],
			RTResTalkAction[26],
			RTResTalkAction[66]
		}
	},
	[2305042] = {
		2305042,
		0,
		Lang.get(18198),
		2305,
		42,
		109,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[2305043] = {
		2305043,
		0,
		Lang.get(18199),
		2305,
		43,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[40]
		}
	},
	[2305044] = {
		2305044,
		0,
		Lang.get(18200),
		2305,
		44,
		143,
		{
			RTResTalkAction[68],
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[2305045] = {
		2305045,
		0,
		Lang.get(18201),
		2305,
		45,
		109,
		{
			RTResTalkAction[68],
			RTResTalkAction[40]
		}
	},
	[2305046] = {
		2305046,
		0,
		Lang.get(18202),
		2305,
		46,
		109,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		}
	},
	[2305047] = {
		2305047,
		5,
		Lang.get(18203),
		2305,
		47,
		122,
		{
			RTResTalkAction[66],
			RTResTalkAction[43]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		1,
		nil,
		2317
	},
	[2305048] = {
		2305048,
		0,
		Lang.get(18204),
		2305,
		48,
		109,
		nil,
		1
	},
	[2305049] = {
		2305049,
		0,
		Lang.get(18205),
		2305,
		49,
		122,
		nil,
		1
	},
	[2305050] = {
		2305050,
		0,
		Lang.get(18206),
		2305,
		50,
		109,
		nil,
		1
	},
	[2305051] = {
		2305051,
		0,
		Lang.get(18207),
		2305,
		51,
		143,
		{
			RTResTalkAction[70]
		}
	},
	[2305052] = {
		2305052,
		0,
		Lang.get(18208),
		2305,
		52,
		109,
		{
			RTResTalkAction[68],
			RTResTalkAction[40]
		}
	},
	[2305053] = {
		2305053,
		0,
		Lang.get(18209),
		2305,
		53,
		143,
		{
			RTResTalkAction[71],
			RTResTalkAction[40]
		}
	},
	[2305054] = {
		2305054,
		0,
		Lang.get(18210),
		2305,
		54,
		143,
		{
			RTResTalkAction[72],
			RTResTalkAction[40]
		}
	},
	[2305055] = {
		2305055,
		0,
		Lang.get(18211),
		2305,
		55,
		109,
		{
			RTResTalkAction[68],
			RTResTalkAction[40]
		}
	},
	[2305056] = {
		2305056,
		0,
		Lang.get(18212),
		2305,
		56,
		109,
		{
			RTResTalkAction[68],
			RTResTalkAction[40]
		}
	},
	[2305057] = {
		2305057,
		8,
		"1",
		2305,
		57,
		109,
		{
			RTResTalkAction[66],
			RTResTalkAction[43]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		1,
		nil,
		2318
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
