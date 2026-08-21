-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\xingluo\\ResTalk.lua

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
	[2] = 1199
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 1199
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 1210,
	[3] = {
		1
	}
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 1109,
	[3] = {
		1
	}
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1199
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1210
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 1109
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 1210
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 1109,
	[3] = {
		1
	}
}
RTResTalkAction[10] = {
	1,
	1198,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1109
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 1198
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 1210,
	[3] = {
		1
	}
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 1198
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 1212,
	[3] = {
		1
	}
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		3
	}
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 1212
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1212
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 1211
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1001
	}
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 1201
}
RTResTalkAction[22] = {
	2,
	1198,
	nil,
	nil,
	1
}
RTResTalkAction[23] = {
	[1] = 3,
	[2] = 1201
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 1201
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 1201,
	[3] = {
		1001
	}
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 811
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 811
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1003
	}
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1205
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 1204,
	[3] = {
		1005
	}
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 1205
}
RTResTalkAction[32] = {
	1,
	1195,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 1204
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 1205
}
RTResTalkAction[35] = {
	[1] = 2,
	[2] = 1205,
	[3] = {
		1002
	}
}
RTResTalkAction[36] = {
	[1] = 3,
	[2] = 1195
}
RTResTalkAction[37] = {
	[1] = 2,
	[2] = 1205
}
RTResTalkAction[38] = {
	3,
	1195,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 1206,
	[3] = {
		1
	}
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 1206
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 1206,
	[3] = {
		2
	}
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1205,
	[3] = {
		1001
	}
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 1206
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 1205,
	[3] = {
		1
	}
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 1199,
	[3] = {
		1001
	}
}
RTResTalkAction[46] = {
	[1] = 3,
	[2] = 1199
}
RTResTalkAction[47] = {
	1,
	1195,
	nil,
	nil,
	3
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 1204,
	[3] = {
		3
	}
}
RTResTalkAction[49] = {
	[1] = 2,
	[2] = 1204
}
RTResTalkAction[50] = {
	3,
	1195,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 1204,
	[3] = {
		1
	}
}
RTResTalkAction[52] = {
	[1] = 3,
	[2] = 1195,
	[3] = {
		1
	}
}
RTResTalkAction[53] = {
	3,
	1195,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[55] = {
	1,
	1195,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[56] = {
	1,
	1195,
	{
		1002
	},
	nil,
	3
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[58] = {
	1,
	1195,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1
	}
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 1211
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		2
	}
}
RTResTalkAction[62] = {
	1,
	1195,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[63] = {
	[1] = 2,
	[2] = 1211,
	[3] = {
		1004
	}
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1002
	}
}
RTResTalkAction[65] = {
	2,
	1195,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 1211
}
RTResTalkAction[67] = {
	[1] = 2,
	[2] = 1195
}
RTResTalkAction[68] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		1002
	}
}
RTResTalkAction[69] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		1
	}
}
RTResTalkAction[70] = {
	2,
	1195,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[71] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		1001
	}
}
RTResTalkAction[72] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		3
	}
}
RTResTalkAction[73] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		1004
	}
}
RTResTalkAction[74] = {
	[1] = 3,
	[2] = 1211,
	[3] = {
		1005
	}
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 740
}
RTResTalkAction[76] = {
	1,
	1195,
	nil,
	nil,
	1
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 740
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1004
	}
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1211,
	[3] = {
		1005
	}
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1001
	}
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 1058,
	[3] = {
		3
	}
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 1056
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 1058
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 812
}
RTResTalkAction[86] = {
	[1] = 0,
	[2] = 812
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1003
	}
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1
	}
}
RTResTalkAction[89] = {
	[1] = 2,
	[2] = 1195,
	[3] = {
		1
	}
}
RTResTalkAction[90] = {
	[1] = 2,
	[2] = 1211,
	[3] = {
		1002
	}
}
RTResTalkAction[91] = {
	[1] = 3,
	[2] = 812
}
RTResTalkAction[92] = {
	2,
	1195,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 1204
}
RTResTalkAction[94] = {
	[1] = 3,
	[2] = 1204
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 1026
}
RTResTalkAction[96] = {
	[1] = 3,
	[2] = 1026
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 1026
}
RTResTalkAction[98] = {
	1,
	1195,
	{
		1002
	},
	nil,
	2
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 1198
}
RTResTalkAction[100] = {
	1,
	1195,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 1198,
	[3] = {
		1
	}
}
RTResTalkAction[102] = {
	[1] = 2,
	[2] = 1198,
	[3] = {
		1
	}
}
RTResTalkAction[103] = {
	[1] = 2,
	[2] = 1211,
	[3] = {
		1003
	}
}
RTResTalkAction[104] = {
	[1] = 2,
	[2] = 1211
}
RTResTalkAction[105] = {
	3,
	1198,
	nil,
	nil,
	1
}
RTResTalkAction[106] = {
	[1] = 2,
	[2] = 1211,
	[3] = {
		1005
	}
}
RTResTalkAction[107] = {
	[1] = 3,
	[2] = 1198
}
RTResTalkAction[108] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		2
	}
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 1206,
	[3] = {
		3
	}
}
RTResTalkAction[110] = {
	[1] = 1,
	[2] = 1198,
	[3] = {
		2
	}
}
RTResTalkAction[111] = {
	[1] = 3,
	[2] = 1206,
	[3] = {
		1004
	}
}
RTResTalkAction[112] = {
	[1] = 1,
	[2] = 1207
}
RTResTalkAction[113] = {
	[1] = 0,
	[2] = 1207
}
RTResTalkAction[114] = {
	[1] = 1,
	[2] = 1206
}
RTResTalkAction[115] = {
	1,
	1195,
	nil,
	nil,
	2
}
RTResTalkAction[116] = {
	[1] = 1,
	[2] = 1206,
	[3] = {
		1004
	}
}
RTResTalkAction[117] = {
	[1] = 2,
	[2] = 1207
}
RTResTalkAction[118] = {
	[1] = 3,
	[2] = 1207
}
RTResTalkAction[119] = {
	[1] = 2,
	[2] = 1212,
	[3] = {
		1
	}
}
RTResTalkAction[120] = {
	[1] = 2,
	[2] = 1212
}
RTResTalkAction[121] = {
	[1] = 2,
	[2] = 1210
}
RTResTalkAction[122] = {
	[1] = 3,
	[2] = 1212
}
RTResTalkAction[123] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[124] = {
	[1] = 2,
	[2] = 677
}
RTResTalkAction[125] = {
	[1] = 3,
	[2] = 158
}
RTResTalkAction[126] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		1
	}
}
RTResTalkAction[127] = {
	[1] = 0,
	[2] = 677
}
RTResTalkAction[128] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[129] = {
	[1] = 1,
	[2] = 1109
}
RTResTalkAction[130] = {
	[1] = 1,
	[2] = 1202
}
RTResTalkAction[131] = {
	[1] = 1,
	[2] = 1210
}
RTResTalkAction[132] = {
	[1] = 0,
	[2] = 1202
}
RTResTalkAction[133] = {
	[1] = 1,
	[2] = 140
}
RTResTalkAction[134] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[135] = {
	[1] = 2,
	[2] = 1026
}

local Data = {
	[36001001] = {
		36001001,
		0,
		Lang.get(94192),
		36001,
		1,
		1210,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36001,
		nil,
		nil,
		nil,
		nil,
		nil,
		36001
	},
	[36001002] = {
		36001002,
		0,
		Lang.get(94193),
		36001,
		2,
		1210,
		nil,
		1
	},
	[36001003] = {
		36001003,
		0,
		Lang.get(94194),
		36001,
		3,
		1198,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36002,
		[19] = 36002
	},
	[36001004] = {
		36001004,
		0,
		Lang.get(94195),
		36001,
		4,
		1210,
		nil,
		1
	},
	[36001005] = {
		36001005,
		0,
		Lang.get(94196),
		36001,
		5,
		1211,
		nil,
		1
	},
	[36001006] = {
		36001006,
		0,
		Lang.get(94197),
		36001,
		6,
		1199,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36001007] = {
		36001007,
		0,
		Lang.get(94198),
		36001,
		7,
		1210,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[36001008] = {
		36001008,
		0,
		Lang.get(94199),
		36001,
		8,
		1109,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[36001009] = {
		36001009,
		0,
		Lang.get(94200),
		36001,
		9,
		1210,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36001010] = {
		36001010,
		0,
		Lang.get(94201),
		36001,
		10,
		1109,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[36001011] = {
		36001011,
		0,
		Lang.get(94202),
		36001,
		11,
		1198,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[6]
		}
	},
	[36001012] = {
		36001012,
		0,
		Lang.get(94203),
		36001,
		12,
		1210,
		{
			RTResTalkAction[12],
			RTResTalkAction[3]
		}
	},
	[36001013] = {
		36001013,
		0,
		Lang.get(94204),
		36001,
		13,
		1210,
		{
			RTResTalkAction[12],
			RTResTalkAction[8]
		}
	},
	[36001014] = {
		36001014,
		0,
		Lang.get(94205),
		36001,
		14,
		1210,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[36001015] = {
		36001015,
		0,
		Lang.get(94206),
		36001,
		15,
		270,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		63,
		36004,
		1,
		1,
		nil,
		nil,
		nil,
		36004
	},
	[36001016] = {
		36001016,
		0,
		Lang.get(94207),
		36001,
		16,
		269,
		nil,
		1
	},
	[36001017] = {
		36001017,
		0,
		Lang.get(94208),
		36001,
		17,
		1212,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36005,
		[19] = 36005
	},
	[36001018] = {
		36001018,
		0,
		Lang.get(94209),
		36001,
		18,
		1210,
		nil,
		1
	},
	[36001019] = {
		36001019,
		0,
		Lang.get(94210),
		36001,
		19,
		1212,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3
	},
	[36001020] = {
		36001020,
		0,
		Lang.get(94211),
		36001,
		20,
		1211,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[36001021] = {
		36001021,
		0,
		Lang.get(94212),
		36001,
		21,
		1212,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36001022] = {
		36001022,
		0,
		Lang.get(94213),
		36001,
		22,
		1198,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[36001023] = {
		36001023,
		0,
		Lang.get(94214),
		36001,
		23,
		1211,
		{
			RTResTalkAction[20],
			RTResTalkAction[14]
		}
	},
	[36030001] = {
		36030001,
		3,
		Lang.get(85710),
		36030,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		36007,
		1,
		1,
		nil,
		nil,
		nil,
		36007,
		nil,
		nil,
		1
	},
	[36030002] = {
		36030002,
		0,
		Lang.get(94215),
		36030,
		2,
		1199,
		nil,
		1,
		1
	},
	[36030003] = {
		36030003,
		0,
		Lang.get(94216),
		36030,
		3,
		1198,
		nil,
		1,
		1
	},
	[36002001] = {
		36002001,
		0,
		Lang.get(94217),
		36002,
		1,
		677,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		36020,
		nil,
		nil,
		nil,
		nil,
		nil,
		36020
	},
	[36002002] = {
		36002002,
		0,
		Lang.get(94218),
		36002,
		2,
		1199,
		nil,
		1
	},
	[36002003] = {
		36002003,
		0,
		Lang.get(94219),
		36002,
		3,
		1201,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[36002004] = {
		36002004,
		0,
		Lang.get(94220),
		36002,
		4,
		1198,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36002005] = {
		36002005,
		0,
		Lang.get(94221),
		36002,
		5,
		1201,
		{
			RTResTalkAction[14],
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36021,
		1,
		1,
		nil,
		nil,
		nil,
		36021
	},
	[36002006] = {
		36002006,
		0,
		Lang.get(94222),
		36002,
		6,
		1209,
		nil,
		1
	},
	[36002007] = {
		36002007,
		3,
		Lang.get(85710),
		36002,
		7,
		605,
		[22] = 1
	},
	[36002008] = {
		36002008,
		0,
		Lang.get(94223),
		36002,
		8,
		1201,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36022,
		[19] = 36022
	},
	[36002009] = {
		36002009,
		0,
		Lang.get(94224),
		36002,
		9,
		1209,
		nil,
		1
	},
	[36002010] = {
		36002010,
		0,
		Lang.get(94225),
		36002,
		10,
		1201,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[36002011] = {
		36002011,
		3,
		Lang.get(94226),
		36002,
		11,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		},
		[21] = 811,
		[22] = 1
	},
	[36204001] = {
		36204001,
		0,
		Lang.get(94227),
		36204,
		1,
		1201,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		36023,
		1,
		1,
		nil,
		nil,
		nil,
		36023
	},
	[36204002] = {
		36204002,
		0,
		Lang.get(94228),
		36204,
		2,
		1199,
		{
			RTResTalkAction[26]
		},
		1,
		[21] = 811
	},
	[36204003] = {
		36204003,
		0,
		Lang.get(94229),
		36204,
		3,
		1198,
		{
			RTResTalkAction[10],
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[36204004] = {
		36204004,
		0,
		Lang.get(94230),
		36204,
		4,
		1203,
		{
			RTResTalkAction[14]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36024,
		1,
		1,
		nil,
		nil,
		nil,
		36024
	},
	[36204005] = {
		36204005,
		2,
		Lang.get(94231),
		36204,
		5,
		1211,
		nil,
		1
	},
	[36204006] = {
		36204006,
		2,
		Lang.get(94232),
		36204,
		6,
		1211,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[36003001] = {
		36003001,
		0,
		Lang.get(94233),
		36003,
		1,
		1204,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		36030,
		1,
		1,
		nil,
		nil,
		nil,
		36030
	},
	[36003002] = {
		36003002,
		0,
		Lang.get(94234),
		36003,
		2,
		1205,
		nil,
		1
	},
	[36003003] = {
		36003003,
		0,
		Lang.get(94235),
		36003,
		3,
		1205,
		nil,
		1
	},
	[36003004] = {
		36003004,
		0,
		Lang.get(94236),
		36003,
		4,
		1195,
		nil,
		1
	},
	[36003005] = {
		36003005,
		7,
		"103",
		36003,
		5,
		1195
	},
	[36003006] = {
		36003006,
		0,
		Lang.get(94237),
		36003,
		6,
		1205,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[36003007] = {
		36003007,
		0,
		Lang.get(94238),
		36003,
		7,
		1205,
		{
			RTResTalkAction[29]
		}
	},
	[36003008] = {
		36003008,
		0,
		Lang.get(94239),
		36003,
		8,
		1204,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[36003009] = {
		36003009,
		0,
		Lang.get(94240),
		36003,
		9,
		1195,
		{
			RTResTalkAction[32],
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[36003010] = {
		36003010,
		0,
		Lang.get(94241),
		36003,
		10,
		1205,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[36003011] = {
		36003011,
		0,
		Lang.get(94242),
		36003,
		11,
		1195,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[36021001] = {
		36021001,
		0,
		Lang.get(94243),
		36021,
		1,
		1195,
		nil,
		1,
		1,
		nil,
		nil,
		60,
		36210,
		1,
		1,
		nil,
		nil,
		nil,
		36210
	},
	[36021002] = {
		36021002,
		0,
		Lang.get(94244),
		36021,
		2,
		1205,
		nil,
		1,
		0
	},
	[36021003] = {
		36021003,
		9,
		Lang.get(94245),
		36021,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36211,
		[19] = 36211,
		[22] = 1
	},
	[36021004] = {
		36021004,
		0,
		Lang.get(94246),
		36021,
		4,
		1199,
		nil,
		1
	},
	[36021005] = {
		36021005,
		9,
		Lang.get(94247),
		36021,
		5,
		[22] = 1
	},
	[36021006] = {
		36021006,
		0,
		Lang.get(94248),
		36021,
		6,
		1206,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[36021007] = {
		36021007,
		0,
		Lang.get(94249),
		36021,
		7,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[40]
		}
	},
	[36021008] = {
		36021008,
		0,
		Lang.get(94250),
		36021,
		8,
		1206,
		{
			RTResTalkAction[12],
			RTResTalkAction[41]
		}
	},
	[36021009] = {
		36021009,
		0,
		Lang.get(94251),
		36021,
		9,
		1205,
		{
			RTResTalkAction[42],
			RTResTalkAction[14],
			RTResTalkAction[43]
		}
	},
	[36004001] = {
		36004001,
		0,
		Lang.get(94252),
		36004,
		1,
		1205,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		36040,
		1,
		1,
		nil,
		nil,
		nil,
		36040
	},
	[36004002] = {
		36004002,
		0,
		Lang.get(94253),
		36004,
		2,
		1198,
		nil,
		1,
		1
	},
	[36004003] = {
		36004003,
		0,
		Lang.get(94254),
		36004,
		3,
		1205,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[36004004] = {
		36004004,
		0,
		Lang.get(94255),
		36004,
		4,
		1206,
		{
			RTResTalkAction[39],
			RTResTalkAction[34]
		}
	},
	[36004005] = {
		36004005,
		0,
		Lang.get(94256),
		36004,
		5,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[40]
		}
	},
	[36004006] = {
		36004006,
		9,
		Lang.get(94257),
		36004,
		6,
		[22] = 1,
		[7] = {
			RTResTalkAction[14],
			RTResTalkAction[43]
		}
	},
	[36004007] = {
		36004007,
		0,
		Lang.get(94258),
		36004,
		7,
		1199,
		{
			RTResTalkAction[45]
		}
	},
	[36004008] = {
		36004008,
		0,
		Lang.get(94259),
		36004,
		8,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		}
	},
	[36004009] = {
		36004009,
		0,
		Lang.get(94260),
		36004,
		9,
		1199,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		}
	},
	[36004010] = {
		36004010,
		0,
		Lang.get(94261),
		36004,
		10,
		1195,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		},
		1,
		1,
		nil,
		nil,
		60,
		36041,
		1,
		1,
		nil,
		nil,
		nil,
		36041
	},
	[36004011] = {
		36004011,
		0,
		Lang.get(94262),
		36004,
		11,
		1204,
		nil,
		1
	},
	[36004012] = {
		36004012,
		0,
		Lang.get(94263),
		36004,
		12,
		1195,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[36004013] = {
		36004013,
		0,
		Lang.get(94264),
		36004,
		13,
		1204,
		{
			RTResTalkAction[48],
			RTResTalkAction[36]
		}
	},
	[36004014] = {
		36004014,
		0,
		Lang.get(94265),
		36004,
		14,
		1195,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[36004015] = {
		36004015,
		0,
		Lang.get(94266),
		36004,
		15,
		1204,
		{
			RTResTalkAction[30],
			RTResTalkAction[36]
		}
	},
	[36004016] = {
		36004016,
		3,
		Lang.get(85710),
		36004,
		16,
		605,
		{
			RTResTalkAction[49],
			RTResTalkAction[36]
		},
		[22] = 1
	},
	[36004017] = {
		36004017,
		0,
		Lang.get(94267),
		36004,
		17,
		1204,
		{
			RTResTalkAction[51],
			RTResTalkAction[36]
		}
	},
	[36004018] = {
		36004018,
		0,
		Lang.get(94268),
		36004,
		18,
		1195,
		{
			RTResTalkAction[49],
			RTResTalkAction[52]
		}
	},
	[36004019] = {
		36004019,
		0,
		Lang.get(94269),
		36004,
		19,
		1195,
		{
			RTResTalkAction[49],
			RTResTalkAction[53]
		}
	},
	[36004020] = {
		36004020,
		0,
		Lang.get(94270),
		36004,
		20,
		740,
		{
			RTResTalkAction[33],
			RTResTalkAction[54]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36042,
		1,
		1,
		nil,
		nil,
		nil,
		36042
	},
	[36004021] = {
		36004021,
		0,
		Lang.get(94271),
		36004,
		21,
		1204,
		nil,
		1
	},
	[36004022] = {
		36004022,
		0,
		Lang.get(94272),
		36004,
		22,
		1195,
		{
			RTResTalkAction[55]
		}
	},
	[36005001] = {
		36005001,
		0,
		Lang.get(94273),
		36005,
		1,
		1195,
		nil,
		1,
		3,
		nil,
		nil,
		177,
		36050,
		nil,
		nil,
		nil,
		nil,
		nil,
		36050
	},
	[36005002] = {
		36005002,
		4,
		nil,
		36005,
		2,
		1195,
		nil,
		1,
		3,
		[29] = {
			{
				id = 36005003,
				branch_content = Lang.get(94274)
			},
			{
				id = 36005003,
				branch_content = Lang.get(94275)
			}
		}
	},
	[36005003] = {
		36005003,
		0,
		Lang.get(94276),
		36005,
		3,
		1195,
		{
			RTResTalkAction[56]
		},
		nil,
		0,
		3
	},
	[36005004] = {
		36005004,
		0,
		Lang.get(94277),
		36005,
		4,
		300,
		{
			RTResTalkAction[57]
		}
	},
	[36005005] = {
		36005005,
		0,
		Lang.get(94278),
		36005,
		5,
		1195,
		{
			RTResTalkAction[32]
		}
	},
	[36005006] = {
		36005006,
		4,
		nil,
		36005,
		6,
		1195,
		{
			RTResTalkAction[32]
		},
		[29] = {
			{
				id = 36005007,
				branch_content = Lang.get(94279)
			},
			{
				id = 36005007,
				branch_content = Lang.get(94280)
			}
		}
	},
	[36005007] = {
		36005007,
		0,
		Lang.get(94281),
		36005,
		7,
		1195,
		{
			RTResTalkAction[58]
		}
	},
	[36005008] = {
		36005008,
		0,
		Lang.get(94282),
		36005,
		8,
		1211,
		{
			RTResTalkAction[54]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36051,
		1,
		1,
		nil,
		1,
		nil,
		36051
	},
	[36005009] = {
		36005009,
		0,
		Lang.get(94283),
		36005,
		9,
		300
	},
	[36005010] = {
		36005010,
		0,
		Lang.get(94284),
		36005,
		10,
		1211,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[36005011] = {
		36005011,
		4,
		nil,
		36005,
		11,
		1211,
		{
			RTResTalkAction[60]
		},
		[29] = {
			{
				id = 36005012,
				branch_content = Lang.get(94285)
			},
			{
				id = 36005012,
				branch_content = Lang.get(94286)
			}
		}
	},
	[36005012] = {
		36005012,
		0,
		Lang.get(94287),
		36005,
		12,
		1211,
		{
			RTResTalkAction[61]
		}
	},
	[36005013] = {
		36005013,
		0,
		Lang.get(94288),
		36005,
		13,
		1195,
		{
			RTResTalkAction[62],
			RTResTalkAction[19]
		}
	},
	[36005014] = {
		36005014,
		0,
		Lang.get(94289),
		36005,
		14,
		1195,
		{
			RTResTalkAction[58]
		}
	},
	[36005015] = {
		36005015,
		0,
		Lang.get(94290),
		36005,
		15,
		1211,
		{
			RTResTalkAction[63],
			RTResTalkAction[36]
		}
	},
	[36022001] = {
		36022001,
		0,
		Lang.get(94291),
		36022,
		1,
		1211,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36220,
		1,
		1,
		nil,
		nil,
		nil,
		36220
	},
	[36022002] = {
		36022002,
		0,
		Lang.get(94292),
		36022,
		2,
		1195,
		nil,
		1,
		3
	},
	[36022003] = {
		36022003,
		0,
		Lang.get(94293),
		36022,
		3,
		1195,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[36022004] = {
		36022004,
		0,
		Lang.get(94294),
		36022,
		4,
		1211,
		{
			RTResTalkAction[64],
			RTResTalkAction[54]
		}
	},
	[36022005] = {
		36022005,
		0,
		Lang.get(94295),
		36022,
		5,
		1195,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		}
	},
	[36022006] = {
		36022006,
		0,
		Lang.get(94296),
		36022,
		6,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[68]
		}
	},
	[36022007] = {
		36022007,
		0,
		Lang.get(94297),
		36022,
		7,
		1195,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		}
	},
	[36022008] = {
		36022008,
		0,
		Lang.get(94298),
		36022,
		8,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[69]
		}
	},
	[36022009] = {
		36022009,
		0,
		Lang.get(94299),
		36022,
		9,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36022010] = {
		36022010,
		0,
		Lang.get(94300),
		36022,
		10,
		1195,
		{
			RTResTalkAction[70],
			RTResTalkAction[66]
		}
	},
	[36022011] = {
		36022011,
		0,
		Lang.get(94301),
		36022,
		11,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36022012] = {
		36022012,
		0,
		Lang.get(94302),
		36022,
		12,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36022013] = {
		36022013,
		0,
		Lang.get(94303),
		36022,
		13,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36022014] = {
		36022014,
		2,
		Lang.get(94304),
		36022,
		14,
		1211,
		{
			RTResTalkAction[64],
			RTResTalkAction[54]
		}
	},
	[36006001] = {
		36006001,
		0,
		Lang.get(94305),
		36006,
		1,
		1211,
		nil,
		1,
		nil,
		nil,
		nil,
		177,
		36060,
		1,
		1,
		nil,
		nil,
		nil,
		36060
	},
	[36006002] = {
		36006002,
		0,
		Lang.get(94306),
		36006,
		2,
		1195,
		nil,
		1
	},
	[36006003] = {
		36006003,
		0,
		Lang.get(94307),
		36006,
		3,
		1211,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[36006004] = {
		36006004,
		0,
		Lang.get(94308),
		36006,
		4,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36006005] = {
		36006005,
		0,
		Lang.get(94309),
		36006,
		5,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[19]
		}
	},
	[36006006] = {
		36006006,
		0,
		Lang.get(94310),
		36006,
		6,
		1211,
		{
			RTResTalkAction[54]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36061,
		1,
		1,
		nil,
		nil,
		nil,
		36061
	},
	[36006007] = {
		36006007,
		0,
		Lang.get(94311),
		36006,
		7,
		1195,
		nil,
		1
	},
	[36006008] = {
		36006008,
		0,
		Lang.get(94312),
		36006,
		8,
		1211,
		{
			RTResTalkAction[59]
		},
		nil,
		nil,
		3
	},
	[36006009] = {
		36006009,
		0,
		Lang.get(94313),
		36006,
		9,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006010] = {
		36006010,
		0,
		Lang.get(94314),
		36006,
		10,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006011] = {
		36006011,
		0,
		Lang.get(94315),
		36006,
		11,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[71]
		}
	},
	[36006012] = {
		36006012,
		0,
		Lang.get(94316),
		36006,
		12,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006013] = {
		36006013,
		0,
		Lang.get(94317),
		36006,
		13,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[72]
		}
	},
	[36006014] = {
		36006014,
		3,
		Lang.get(47266),
		36006,
		14,
		605,
		{
			RTResTalkAction[54],
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[36006015] = {
		36006015,
		0,
		Lang.get(94318),
		36006,
		15,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36006016] = {
		36006016,
		0,
		Lang.get(94319),
		36006,
		16,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006017] = {
		36006017,
		0,
		Lang.get(94320),
		36006,
		17,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[73]
		}
	},
	[36006018] = {
		36006018,
		0,
		Lang.get(94321),
		36006,
		18,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006019] = {
		36006019,
		0,
		Lang.get(94322),
		36006,
		19,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[74]
		}
	},
	[36006020] = {
		36006020,
		0,
		Lang.get(94323),
		36006,
		20,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006021] = {
		36006021,
		3,
		Lang.get(86156),
		36006,
		21,
		605,
		{
			RTResTalkAction[54],
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[36006022] = {
		36006022,
		0,
		Lang.get(94324),
		36006,
		22,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36006023] = {
		36006023,
		0,
		Lang.get(94325),
		36006,
		23,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006024] = {
		36006024,
		0,
		Lang.get(94326),
		36006,
		24,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36006025] = {
		36006025,
		0,
		Lang.get(94327),
		36006,
		25,
		740,
		{
			RTResTalkAction[75],
			RTResTalkAction[54],
			RTResTalkAction[19]
		}
	},
	[36006026] = {
		36006026,
		0,
		Lang.get(94328),
		36006,
		26,
		1195,
		{
			RTResTalkAction[76],
			RTResTalkAction[77]
		}
	},
	[36006027] = {
		36006027,
		0,
		Lang.get(94329),
		36006,
		27,
		1211,
		{
			RTResTalkAction[78],
			RTResTalkAction[54]
		}
	},
	[36007001] = {
		36007001,
		0,
		Lang.get(94330),
		36007,
		1,
		1195,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36070,
		1,
		1,
		nil,
		nil,
		nil,
		36070
	},
	[36007002] = {
		36007002,
		0,
		Lang.get(94331),
		36007,
		2,
		1211,
		nil,
		1
	},
	[36007003] = {
		36007003,
		0,
		Lang.get(94332),
		36007,
		3,
		1195,
		nil,
		1
	},
	[36007004] = {
		36007004,
		0,
		Lang.get(94333),
		36007,
		4,
		1211,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[36007005] = {
		36007005,
		0,
		Lang.get(94334),
		36007,
		5,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36007006] = {
		36007006,
		0,
		Lang.get(94335),
		36007,
		6,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36007007] = {
		36007007,
		0,
		Lang.get(94336),
		36007,
		7,
		1195,
		{
			RTResTalkAction[80],
			RTResTalkAction[19]
		}
	},
	[36007008] = {
		36007008,
		0,
		Lang.get(94337),
		36007,
		8,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[36007009] = {
		36007009,
		2,
		Lang.get(94338),
		36007,
		9,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36007010] = {
		36007010,
		0,
		Lang.get(94339),
		36007,
		10,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36007011] = {
		36007011,
		0,
		Lang.get(94340),
		36007,
		11,
		1195,
		{
			RTResTalkAction[76],
			RTResTalkAction[19]
		}
	},
	[36007012] = {
		36007012,
		0,
		Lang.get(94341),
		36007,
		12,
		1057,
		{
			RTResTalkAction[54]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36071,
		1,
		1,
		nil,
		nil,
		nil,
		36071
	},
	[36023001] = {
		36023001,
		3,
		Lang.get(94342),
		36023,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36230,
		nil,
		nil,
		nil,
		nil,
		nil,
		36230,
		255,
		nil,
		1
	},
	[36023002] = {
		36023002,
		0,
		Lang.get(94343),
		36023,
		2,
		1058,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[36023003] = {
		36023003,
		0,
		Lang.get(94344),
		36023,
		3,
		1056,
		{
			RTResTalkAction[82],
			RTResTalkAction[83]
		}
	},
	[36023004] = {
		36023004,
		0,
		Lang.get(94345),
		36023,
		4,
		1195,
		{
			RTResTalkAction[84]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36231,
		1,
		1,
		nil,
		nil,
		nil,
		36231
	},
	[36023005] = {
		36023005,
		0,
		Lang.get(94346),
		36023,
		5,
		1195,
		{
			RTResTalkAction[85]
		},
		1,
		[21] = 812
	},
	[36023006] = {
		36023006,
		0,
		Lang.get(94347),
		36023,
		6,
		1056,
		{
			RTResTalkAction[82],
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[36023007] = {
		36023007,
		0,
		Lang.get(94348),
		36023,
		7,
		1195,
		{
			RTResTalkAction[87],
			RTResTalkAction[84]
		}
	},
	[36008001] = {
		36008001,
		2,
		Lang.get(94349),
		36008,
		1,
		1211,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36080,
		1,
		1,
		nil,
		nil,
		nil,
		36080
	},
	[36008002] = {
		36008002,
		2,
		Lang.get(94350),
		36008,
		2,
		1211,
		nil,
		1
	},
	[36008003] = {
		36008003,
		0,
		Lang.get(94351),
		36008,
		3,
		1195,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36008004] = {
		36008004,
		2,
		Lang.get(94352),
		36008,
		4,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[36008005] = {
		36008005,
		0,
		Lang.get(94353),
		36008,
		5,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[19]
		}
	},
	[36008006] = {
		36008006,
		0,
		Lang.get(94354),
		36008,
		6,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[36008007] = {
		36008007,
		0,
		Lang.get(94355),
		36008,
		7,
		1211,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36081,
		1,
		1,
		nil,
		nil,
		nil,
		36081
	},
	[36008008] = {
		36008008,
		0,
		Lang.get(94356),
		36008,
		8,
		1195,
		nil,
		1
	},
	[36008009] = {
		36008009,
		0,
		Lang.get(94357),
		36008,
		9,
		1211,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[36008010] = {
		36008010,
		0,
		Lang.get(94358),
		36008,
		10,
		1195,
		{
			RTResTalkAction[89],
			RTResTalkAction[66]
		}
	},
	[36008011] = {
		36008011,
		0,
		Lang.get(94359),
		36008,
		11,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[73]
		}
	},
	[36008012] = {
		36008012,
		0,
		Lang.get(94360),
		36008,
		12,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36008013] = {
		36008013,
		0,
		Lang.get(94361),
		36008,
		13,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36008014] = {
		36008014,
		0,
		Lang.get(94362),
		36008,
		14,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36008015] = {
		36008015,
		0,
		Lang.get(94363),
		36008,
		15,
		1211,
		{
			RTResTalkAction[90],
			RTResTalkAction[91],
			RTResTalkAction[54]
		}
	},
	[36008016] = {
		36008016,
		0,
		Lang.get(94364),
		36008,
		16,
		1195,
		{
			RTResTalkAction[92],
			RTResTalkAction[66],
			RTResTalkAction[86]
		}
	},
	[36008017] = {
		36008017,
		0,
		Lang.get(94365),
		36008,
		17,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[73]
		}
	},
	[36008018] = {
		36008018,
		0,
		Lang.get(94366),
		36008,
		18,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36008019] = {
		36008019,
		0,
		Lang.get(94367),
		36008,
		19,
		1198,
		{
			RTResTalkAction[54],
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36082,
		1,
		1,
		nil,
		nil,
		nil,
		36082
	},
	[36009001] = {
		36009001,
		3,
		Lang.get(94368),
		36009,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36090,
		[19] = 36090,
		[22] = 1
	},
	[36009002] = {
		36009002,
		0,
		Lang.get(94369),
		36009,
		2,
		1198,
		nil,
		1,
		1
	},
	[36009003] = {
		36009003,
		0,
		Lang.get(94370),
		36009,
		3,
		1212,
		nil,
		1,
		0
	},
	[36009004] = {
		36009004,
		0,
		Lang.get(94371),
		36009,
		4,
		1212,
		nil,
		1,
		0
	},
	[36009005] = {
		36009005,
		0,
		Lang.get(94372),
		36009,
		5,
		1199,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36009006] = {
		36009006,
		0,
		Lang.get(94373),
		36009,
		6,
		1212,
		{
			RTResTalkAction[15],
			RTResTalkAction[5]
		}
	},
	[36009007] = {
		36009007,
		0,
		Lang.get(94374),
		36009,
		7,
		1198,
		{
			RTResTalkAction[10],
			RTResTalkAction[17]
		}
	},
	[36009008] = {
		36009008,
		0,
		Lang.get(94375),
		36009,
		8,
		1204,
		{
			RTResTalkAction[14]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36091,
		1,
		1,
		nil,
		1,
		nil,
		36091
	},
	[36009009] = {
		36009009,
		0,
		Lang.get(94376),
		36009,
		9,
		1212,
		{
			RTResTalkAction[15]
		}
	},
	[36009010] = {
		36009010,
		0,
		Lang.get(94377),
		36009,
		10,
		1204,
		{
			RTResTalkAction[93],
			RTResTalkAction[17]
		}
	},
	[36009011] = {
		36009011,
		0,
		Lang.get(94378),
		36009,
		11,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[94]
		}
	},
	[36009012] = {
		36009012,
		0,
		Lang.get(94379),
		36009,
		12,
		1204,
		{
			RTResTalkAction[14],
			RTResTalkAction[33]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36092,
		1,
		1,
		nil,
		1,
		nil,
		36092
	},
	[36009013] = {
		36009013,
		0,
		Lang.get(94380),
		36009,
		13,
		1198,
		nil,
		1
	},
	[36009014] = {
		36009014,
		0,
		Lang.get(94381),
		36009,
		14,
		1204,
		nil,
		1
	},
	[36009015] = {
		36009015,
		0,
		Lang.get(94382),
		36009,
		15,
		1204,
		nil,
		1
	},
	[36009016] = {
		36009016,
		0,
		Lang.get(94383),
		36009,
		16,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		198,
		36093,
		nil,
		nil,
		nil,
		nil,
		nil,
		36093
	},
	[36009017] = {
		36009017,
		0,
		Lang.get(94384),
		36009,
		17,
		158,
		nil,
		1
	},
	[36009018] = {
		36009018,
		0,
		Lang.get(94385),
		36009,
		18,
		1198,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[36009019] = {
		36009019,
		0,
		Lang.get(94386),
		36009,
		19,
		1026,
		{
			RTResTalkAction[95],
			RTResTalkAction[14]
		}
	},
	[36009020] = {
		36009020,
		0,
		Lang.get(94387),
		36009,
		20,
		1026,
		{
			RTResTalkAction[95]
		}
	},
	[36009021] = {
		36009021,
		0,
		Lang.get(94388),
		36009,
		21,
		1026,
		{
			RTResTalkAction[95]
		}
	},
	[36009022] = {
		36009022,
		0,
		Lang.get(94389),
		36009,
		22,
		1026,
		{
			RTResTalkAction[95]
		}
	},
	[36009023] = {
		36009023,
		0,
		Lang.get(94390),
		36009,
		23,
		1198,
		{
			RTResTalkAction[22],
			RTResTalkAction[96]
		}
	},
	[36009024] = {
		36009024,
		0,
		Lang.get(94391),
		36009,
		24,
		1026,
		{
			RTResTalkAction[22],
			RTResTalkAction[96]
		}
	},
	[36009025] = {
		36009025,
		0,
		Lang.get(94392),
		36009,
		25,
		1026,
		{
			RTResTalkAction[22],
			RTResTalkAction[96]
		}
	},
	[36009026] = {
		36009026,
		0,
		Lang.get(94393),
		36009,
		26,
		1199,
		{
			RTResTalkAction[1],
			RTResTalkAction[14],
			RTResTalkAction[97]
		}
	},
	[36010001] = {
		36010001,
		3,
		Lang.get(94394),
		36010,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36100,
		1,
		1,
		nil,
		nil,
		nil,
		36100,
		nil,
		nil,
		1
	},
	[36010002] = {
		36010002,
		0,
		Lang.get(94395),
		36010,
		2,
		1195,
		nil,
		1,
		3
	},
	[36024001] = {
		36024001,
		0,
		Lang.get(94396),
		36024,
		1,
		1195,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		36240,
		nil,
		nil,
		nil,
		nil,
		nil,
		36240
	},
	[36024002] = {
		36024002,
		0,
		Lang.get(94397),
		36024,
		2,
		1198,
		nil,
		1,
		0
	},
	[36024003] = {
		36024003,
		0,
		Lang.get(94398),
		36024,
		3,
		1195,
		nil,
		1
	},
	[36024004] = {
		36024004,
		0,
		Lang.get(94399),
		36024,
		4,
		1195,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		3
	},
	[36024005] = {
		36024005,
		0,
		Lang.get(94400),
		36024,
		5,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[36024006] = {
		36024006,
		0,
		Lang.get(94401),
		36024,
		6,
		1198,
		{
			RTResTalkAction[99],
			RTResTalkAction[19]
		}
	},
	[36024007] = {
		36024007,
		0,
		Lang.get(94402),
		36024,
		7,
		1211,
		{
			RTResTalkAction[12],
			RTResTalkAction[74]
		}
	},
	[36024008] = {
		36024008,
		0,
		Lang.get(94403),
		36024,
		8,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[66]
		}
	},
	[36024009] = {
		36024009,
		0,
		Lang.get(94404),
		36024,
		9,
		1211,
		{
			RTResTalkAction[12],
			RTResTalkAction[71]
		}
	},
	[36024010] = {
		36024010,
		0,
		Lang.get(94405),
		36024,
		10,
		1195,
		{
			RTResTalkAction[100],
			RTResTalkAction[14],
			RTResTalkAction[19]
		}
	},
	[36024011] = {
		36024011,
		0,
		Lang.get(94406),
		36024,
		11,
		1199,
		{
			RTResTalkAction[1],
			RTResTalkAction[54]
		}
	},
	[36011001] = {
		36011001,
		9,
		Lang.get(94407),
		36011,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36110,
		1,
		1,
		nil,
		nil,
		nil,
		36110,
		nil,
		nil,
		1
	},
	[36011002] = {
		36011002,
		0,
		Lang.get(94408),
		36011,
		2,
		1198,
		nil,
		1
	},
	[36011003] = {
		36011003,
		0,
		Lang.get(94409),
		36011,
		3,
		1211,
		nil,
		1
	},
	[36011004] = {
		36011004,
		0,
		Lang.get(94410),
		36011,
		4,
		1199,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36011005] = {
		36011005,
		0,
		Lang.get(94411),
		36011,
		5,
		1198,
		{
			RTResTalkAction[99],
			RTResTalkAction[5]
		}
	},
	[36011006] = {
		36011006,
		2,
		Lang.get(94412),
		36011,
		6,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[14]
		}
	},
	[36011007] = {
		36011007,
		0,
		Lang.get(94413),
		36011,
		7,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36011008] = {
		36011008,
		0,
		Lang.get(94414),
		36011,
		8,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[66]
		}
	},
	[36011009] = {
		36011009,
		0,
		Lang.get(94415),
		36011,
		9,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[66]
		}
	},
	[36011010] = {
		36011010,
		0,
		Lang.get(94416),
		36011,
		10,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[66]
		}
	},
	[36011011] = {
		36011011,
		0,
		Lang.get(94417),
		36011,
		11,
		1195,
		{
			RTResTalkAction[12],
			RTResTalkAction[52],
			RTResTalkAction[19]
		}
	},
	[36011012] = {
		36011012,
		0,
		Lang.get(94418),
		36011,
		12,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[71],
			RTResTalkAction[14]
		}
	},
	[36011013] = {
		36011013,
		2,
		Lang.get(94419),
		36011,
		13,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[36011014] = {
		36011014,
		0,
		Lang.get(94420),
		36011,
		14,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36011015] = {
		36011015,
		0,
		Lang.get(94421),
		36011,
		15,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36011016] = {
		36011016,
		0,
		Lang.get(94422),
		36011,
		16,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36011017] = {
		36011017,
		0,
		Lang.get(94423),
		36011,
		17,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36012001] = {
		36012001,
		3,
		Lang.get(47266),
		36012,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		36120,
		1,
		1,
		nil,
		nil,
		nil,
		36120,
		nil,
		nil,
		1
	},
	[36012002] = {
		36012002,
		0,
		Lang.get(94424),
		36012,
		2,
		1195,
		nil,
		1,
		1
	},
	[36012003] = {
		36012003,
		4,
		nil,
		36012,
		3,
		1195,
		nil,
		1,
		1,
		[29] = {
			{
				id = 36012004,
				branch_content = Lang.get(94425)
			},
			{
				id = 36012004,
				branch_content = Lang.get(94426)
			}
		}
	},
	[36012004] = {
		36012004,
		0,
		Lang.get(94427),
		36012,
		4,
		1195,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36012005] = {
		36012005,
		0,
		Lang.get(94428),
		36012,
		5,
		1198,
		{
			RTResTalkAction[101],
			RTResTalkAction[54]
		}
	},
	[36012006] = {
		36012006,
		0,
		Lang.get(94429),
		36012,
		6,
		1199,
		{
			RTResTalkAction[102],
			RTResTalkAction[46]
		}
	},
	[36012007] = {
		36012007,
		0,
		Lang.get(94430),
		36012,
		7,
		1211,
		{
			RTResTalkAction[103],
			RTResTalkAction[46],
			RTResTalkAction[14]
		}
	},
	[36012008] = {
		36012008,
		0,
		Lang.get(94431),
		36012,
		8,
		1198,
		{
			RTResTalkAction[104],
			RTResTalkAction[105],
			RTResTalkAction[5]
		}
	},
	[36012009] = {
		36012009,
		0,
		Lang.get(94432),
		36012,
		9,
		1198,
		{
			RTResTalkAction[104],
			RTResTalkAction[105]
		}
	},
	[36012010] = {
		36012010,
		0,
		Lang.get(94433),
		36012,
		10,
		1211,
		{
			RTResTalkAction[59],
			RTResTalkAction[14]
		}
	},
	[36012011] = {
		36012011,
		3,
		Lang.get(94434),
		36012,
		11,
		605,
		{
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[36012012] = {
		36012012,
		0,
		Lang.get(94435),
		36012,
		12,
		1211,
		{
			RTResTalkAction[60]
		}
	},
	[36012013] = {
		36012013,
		4,
		nil,
		36012,
		13,
		1211,
		{
			RTResTalkAction[60]
		},
		[29] = {
			{
				id = 36012014,
				branch_content = Lang.get(94436)
			},
			{
				id = 36012014,
				branch_content = Lang.get(94437)
			}
		}
	},
	[36012014] = {
		36012014,
		0,
		Lang.get(94438),
		36012,
		14,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[19]
		}
	},
	[36012015] = {
		36012015,
		0,
		Lang.get(94439),
		36012,
		15,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[74]
		}
	},
	[36012016] = {
		36012016,
		0,
		Lang.get(94440),
		36012,
		16,
		740,
		{
			RTResTalkAction[54],
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36121,
		1,
		1,
		nil,
		nil,
		nil,
		36121
	},
	[36012017] = {
		36012017,
		0,
		Lang.get(94441),
		36012,
		17,
		1195,
		nil,
		1,
		2
	},
	[36012018] = {
		36012018,
		9,
		Lang.get(94442),
		36012,
		18,
		nil,
		nil,
		nil,
		0,
		[22] = 1
	},
	[36012019] = {
		36012019,
		0,
		Lang.get(94443),
		36012,
		19,
		1198,
		{
			RTResTalkAction[99]
		},
		nil,
		0,
		3
	},
	[36012020] = {
		36012020,
		0,
		Lang.get(94444),
		36012,
		20,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[14]
		}
	},
	[36012021] = {
		36012021,
		0,
		Lang.get(94445),
		36012,
		21,
		740,
		{
			RTResTalkAction[75],
			RTResTalkAction[54]
		}
	},
	[36012022] = {
		36012022,
		0,
		Lang.get(94446),
		36012,
		22,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[77]
		}
	},
	[36012023] = {
		36012023,
		2,
		Lang.get(94447),
		36012,
		23,
		1211,
		{
			RTResTalkAction[20],
			RTResTalkAction[54]
		}
	},
	[36013001] = {
		36013001,
		0,
		Lang.get(94448),
		36013,
		1,
		1195,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36130,
		1,
		1,
		nil,
		nil,
		nil,
		36130
	},
	[36013002] = {
		36013002,
		0,
		Lang.get(94449),
		36013,
		2,
		1195,
		nil,
		1
	},
	[36013003] = {
		36013003,
		0,
		Lang.get(94450),
		36013,
		3,
		1195,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36013004] = {
		36013004,
		0,
		Lang.get(94451),
		36013,
		4,
		1195,
		{
			RTResTalkAction[57]
		}
	},
	[36013005] = {
		36013005,
		0,
		Lang.get(94452),
		36013,
		5,
		1195,
		{
			RTResTalkAction[57]
		}
	},
	[36013006] = {
		36013006,
		0,
		Lang.get(94453),
		36013,
		6,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36013007] = {
		36013007,
		0,
		Lang.get(94454),
		36013,
		7,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36013008] = {
		36013008,
		0,
		Lang.get(94455),
		36013,
		8,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[19]
		}
	},
	[36013009] = {
		36013009,
		0,
		Lang.get(94456),
		36013,
		9,
		1195,
		{
			RTResTalkAction[88]
		}
	},
	[36013010] = {
		36013010,
		0,
		Lang.get(94457),
		36013,
		10,
		1199,
		{
			RTResTalkAction[54]
		},
		1,
		1,
		nil,
		nil,
		nil,
		36131,
		1,
		1,
		nil,
		nil,
		nil,
		36131
	},
	[36013011] = {
		36013011,
		0,
		Lang.get(94458),
		36013,
		11,
		1195,
		nil,
		1,
		0
	},
	[36013012] = {
		36013012,
		0,
		Lang.get(94459),
		36013,
		12,
		1199,
		nil,
		1,
		1
	},
	[36013013] = {
		36013013,
		0,
		Lang.get(94460),
		36013,
		13,
		1198,
		nil,
		1,
		0
	},
	[36013014] = {
		36013014,
		0,
		Lang.get(94461),
		36013,
		14,
		1195,
		{
			RTResTalkAction[87]
		}
	},
	[36013015] = {
		36013015,
		0,
		Lang.get(94462),
		36013,
		15,
		1211,
		{
			RTResTalkAction[106],
			RTResTalkAction[107],
			RTResTalkAction[54]
		}
	},
	[36013016] = {
		36013016,
		0,
		Lang.get(94463),
		36013,
		16,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[19],
			RTResTalkAction[14]
		}
	},
	[36013017] = {
		36013017,
		0,
		Lang.get(94464),
		36013,
		17,
		1211,
		{
			RTResTalkAction[104],
			RTResTalkAction[107],
			RTResTalkAction[54]
		}
	},
	[36013018] = {
		36013018,
		0,
		Lang.get(94465),
		36013,
		18,
		1195,
		{
			RTResTalkAction[108],
			RTResTalkAction[19],
			RTResTalkAction[14]
		}
	},
	[36013019] = {
		36013019,
		0,
		Lang.get(94466),
		36013,
		19,
		1206,
		{
			RTResTalkAction[54]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36132,
		1,
		1,
		nil,
		nil,
		nil,
		36132
	},
	[36013020] = {
		36013020,
		0,
		Lang.get(94467),
		36013,
		20,
		1195,
		nil,
		1
	},
	[36013021] = {
		36013021,
		0,
		Lang.get(94468),
		36013,
		21,
		1206,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[36014001] = {
		36014001,
		0,
		Lang.get(94469),
		36014,
		1,
		1198,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36140,
		1,
		1,
		nil,
		nil,
		nil,
		36140
	},
	[36014002] = {
		36014002,
		0,
		Lang.get(94470),
		36014,
		2,
		1206,
		nil,
		1
	},
	[36014003] = {
		36014003,
		0,
		Lang.get(94471),
		36014,
		3,
		1199,
		nil,
		1
	},
	[36014004] = {
		36014004,
		0,
		Lang.get(94472),
		36014,
		4,
		1206,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[36014005] = {
		36014005,
		0,
		Lang.get(94473),
		36014,
		5,
		1198,
		{
			RTResTalkAction[110],
			RTResTalkAction[43]
		}
	},
	[36014006] = {
		36014006,
		0,
		Lang.get(94474),
		36014,
		6,
		1206,
		{
			RTResTalkAction[12],
			RTResTalkAction[40]
		}
	},
	[36014007] = {
		36014007,
		0,
		Lang.get(94475),
		36014,
		7,
		1206,
		{
			RTResTalkAction[12],
			RTResTalkAction[40]
		}
	},
	[36014008] = {
		36014008,
		0,
		Lang.get(94476),
		36014,
		8,
		1211,
		{
			RTResTalkAction[104],
			RTResTalkAction[40],
			RTResTalkAction[14]
		}
	},
	[36014009] = {
		36014009,
		0,
		Lang.get(94477),
		36014,
		9,
		1206,
		{
			RTResTalkAction[104],
			RTResTalkAction[40]
		}
	},
	[36014010] = {
		36014010,
		0,
		Lang.get(94478),
		36014,
		10,
		1206,
		{
			RTResTalkAction[104],
			RTResTalkAction[40]
		}
	},
	[36014011] = {
		36014011,
		0,
		Lang.get(94479),
		36014,
		11,
		1206,
		{
			RTResTalkAction[104],
			RTResTalkAction[40]
		}
	},
	[36014012] = {
		36014012,
		0,
		Lang.get(94480),
		36014,
		12,
		1206,
		{
			RTResTalkAction[104],
			RTResTalkAction[111]
		}
	},
	[36014013] = {
		36014013,
		0,
		Lang.get(94481),
		36014,
		13,
		1211,
		{
			RTResTalkAction[104],
			RTResTalkAction[40]
		}
	},
	[36014014] = {
		36014014,
		0,
		Lang.get(94482),
		36014,
		14,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[19],
			RTResTalkAction[43]
		}
	},
	[36014015] = {
		36014015,
		0,
		Lang.get(94483),
		36014,
		15,
		1195,
		{
			RTResTalkAction[57]
		}
	},
	[36014016] = {
		36014016,
		3,
		Lang.get(85710),
		36014,
		16,
		605,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36141,
		1,
		1,
		nil,
		nil,
		nil,
		36141,
		nil,
		nil,
		1
	},
	[36014017] = {
		36014017,
		0,
		Lang.get(94484),
		36014,
		17,
		1211,
		nil,
		1
	},
	[36014018] = {
		36014018,
		0,
		Lang.get(94485),
		36014,
		18,
		1198,
		nil,
		1
	},
	[36014019] = {
		36014019,
		0,
		Lang.get(94486),
		36014,
		19,
		1195,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36014020] = {
		36014020,
		0,
		"……",
		36014,
		20,
		1198,
		{
			RTResTalkAction[67],
			RTResTalkAction[107]
		}
	},
	[36014021] = {
		36014021,
		0,
		Lang.get(94487),
		36014,
		21,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[107]
		}
	},
	[36014022] = {
		36014022,
		0,
		Lang.get(94488),
		36014,
		22,
		1206,
		{
			RTResTalkAction[67],
			RTResTalkAction[40],
			RTResTalkAction[14]
		}
	},
	[36014023] = {
		36014023,
		0,
		Lang.get(94489),
		36014,
		23,
		1211,
		{
			RTResTalkAction[104],
			RTResTalkAction[40],
			RTResTalkAction[54]
		}
	},
	[36014024] = {
		36014024,
		0,
		Lang.get(94490),
		36014,
		24,
		1198,
		{
			RTResTalkAction[99],
			RTResTalkAction[19],
			RTResTalkAction[43]
		}
	},
	[36014025] = {
		36014025,
		2,
		Lang.get(94491),
		36014,
		25,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[14]
		}
	},
	[36015001] = {
		36015001,
		9,
		Lang.get(94492),
		36015,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		200,
		36150,
		nil,
		nil,
		nil,
		nil,
		nil,
		36150,
		255,
		nil,
		1
	},
	[36015002] = {
		36015002,
		9,
		Lang.get(94493),
		36015,
		2,
		[22] = 1,
		[20] = 255
	},
	[36015003] = {
		36015003,
		9,
		Lang.get(94494),
		36015,
		3,
		[22] = 1,
		[20] = 255
	},
	[36015004] = {
		36015004,
		0,
		Lang.get(94495),
		36015,
		4,
		1195,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		36151,
		nil,
		nil,
		nil,
		nil,
		nil,
		36151,
		-1
	},
	[36015005] = {
		36015005,
		0,
		Lang.get(94496),
		36015,
		5,
		1207,
		nil,
		1,
		0
	},
	[36015006] = {
		36015006,
		0,
		Lang.get(94497),
		36015,
		6,
		1195,
		nil,
		1
	},
	[36015007] = {
		36015007,
		0,
		Lang.get(94498),
		36015,
		7,
		1207,
		nil,
		1
	},
	[36015008] = {
		36015008,
		0,
		Lang.get(94499),
		36015,
		8,
		1195,
		nil,
		1,
		1
	},
	[36015009] = {
		36015009,
		0,
		Lang.get(94500),
		36015,
		9,
		1207,
		nil,
		1,
		0
	},
	[36015010] = {
		36015010,
		0,
		Lang.get(94501),
		36015,
		10,
		1211,
		nil,
		1
	},
	[36015011] = {
		36015011,
		0,
		Lang.get(94502),
		36015,
		11,
		1195,
		nil,
		1,
		3
	},
	[36015012] = {
		36015012,
		0,
		Lang.get(94503),
		36015,
		12,
		1207,
		nil,
		1,
		0
	},
	[36025001] = {
		36025001,
		0,
		Lang.get(94504),
		36025,
		1,
		1195,
		nil,
		1,
		3,
		nil,
		nil,
		200,
		36250,
		nil,
		nil,
		nil,
		nil,
		nil,
		36250
	},
	[36025002] = {
		36025002,
		0,
		Lang.get(94505),
		36025,
		2,
		1207,
		nil,
		1,
		0
	},
	[36025003] = {
		36025003,
		0,
		Lang.get(94506),
		36025,
		3,
		1207,
		nil,
		1
	},
	[36025004] = {
		36025004,
		0,
		Lang.get(94507),
		36025,
		4,
		1206,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[36025005] = {
		36025005,
		0,
		Lang.get(94508),
		36025,
		5,
		1207,
		{
			RTResTalkAction[112],
			RTResTalkAction[43]
		}
	},
	[36025006] = {
		36025006,
		0,
		Lang.get(94509),
		36025,
		6,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36025007] = {
		36025007,
		0,
		Lang.get(94510),
		36025,
		7,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36025008] = {
		36025008,
		0,
		Lang.get(94511),
		36025,
		8,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36025009] = {
		36025009,
		0,
		Lang.get(94512),
		36025,
		9,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36025010] = {
		36025010,
		0,
		Lang.get(94513),
		36025,
		10,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36025011] = {
		36025011,
		0,
		Lang.get(94514),
		36025,
		11,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[113]
		}
	},
	[36025012] = {
		36025012,
		0,
		Lang.get(94515),
		36025,
		12,
		1206,
		{
			RTResTalkAction[114],
			RTResTalkAction[54]
		}
	},
	[36025013] = {
		36025013,
		0,
		Lang.get(94516),
		36025,
		13,
		1198,
		{
			RTResTalkAction[10],
			RTResTalkAction[43]
		}
	},
	[36025014] = {
		36025014,
		0,
		Lang.get(94517),
		36025,
		14,
		1198,
		{
			RTResTalkAction[10]
		}
	},
	[36025015] = {
		36025015,
		3,
		Lang.get(94518),
		36025,
		15,
		605,
		{
			RTResTalkAction[14]
		},
		[22] = 1,
		[20] = 255
	},
	[36016001] = {
		36016001,
		0,
		Lang.get(94519),
		36016,
		1,
		1207,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36160,
		1.2,
		1,
		nil,
		nil,
		nil,
		36160,
		255
	},
	[36016002] = {
		36016002,
		0,
		Lang.get(94520),
		36016,
		2,
		1206,
		nil,
		1,
		[20] = 255
	},
	[36016003] = {
		36016003,
		0,
		Lang.get(94521),
		36016,
		3,
		1206,
		nil,
		1,
		[20] = 255
	},
	[36016004] = {
		36016004,
		0,
		Lang.get(94522),
		36016,
		4,
		1198,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3,
		[20] = 255
	},
	[36016005] = {
		36016005,
		0,
		Lang.get(94523),
		36016,
		5,
		1198,
		{
			RTResTalkAction[99]
		},
		[20] = 255
	},
	[36016006] = {
		36016006,
		0,
		Lang.get(94524),
		36016,
		6,
		1198,
		{
			RTResTalkAction[99]
		},
		[20] = 255
	},
	[36016007] = {
		36016007,
		0,
		Lang.get(94525),
		36016,
		7,
		1199,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		},
		[20] = 255
	},
	[36016008] = {
		36016008,
		0,
		Lang.get(94526),
		36016,
		8,
		1198,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		},
		[20] = 255
	},
	[36016009] = {
		36016009,
		0,
		Lang.get(94527),
		36016,
		9,
		1195,
		{
			RTResTalkAction[115],
			RTResTalkAction[14],
			RTResTalkAction[5]
		},
		[20] = 255
	},
	[36016010] = {
		36016010,
		0,
		Lang.get(94528),
		36016,
		10,
		1206,
		{
			RTResTalkAction[116],
			RTResTalkAction[54]
		},
		[20] = 255
	},
	[36016011] = {
		36016011,
		0,
		"……zzz",
		36016,
		11,
		1195,
		{
			RTResTalkAction[115],
			RTResTalkAction[43]
		},
		[20] = 255
	},
	[36016012] = {
		36016012,
		0,
		Lang.get(94529),
		36016,
		12,
		1207,
		{
			RTResTalkAction[112],
			RTResTalkAction[54]
		},
		[20] = 255
	},
	[36016013] = {
		36016013,
		0,
		Lang.get(94530),
		36016,
		13,
		1206,
		{
			RTResTalkAction[116],
			RTResTalkAction[113]
		},
		[20] = 255
	},
	[36016014] = {
		36016014,
		3,
		Lang.get(94531),
		36016,
		14,
		605,
		{
			RTResTalkAction[43]
		},
		[22] = 1,
		[20] = 255
	},
	[36016015] = {
		36016015,
		0,
		Lang.get(94532),
		36016,
		15,
		1199,
		nil,
		1,
		[20] = 255
	},
	[36016016] = {
		36016016,
		0,
		Lang.get(94533),
		36016,
		16,
		1198,
		nil,
		1,
		[20] = 255
	},
	[36016017] = {
		36016017,
		0,
		Lang.get(94534),
		36016,
		17,
		1195,
		{
			RTResTalkAction[88]
		},
		[20] = 255
	},
	[36016018] = {
		36016018,
		0,
		Lang.get(94535),
		36016,
		18,
		1206,
		{
			RTResTalkAction[67],
			RTResTalkAction[111]
		},
		[20] = 255
	},
	[36016019] = {
		36016019,
		0,
		Lang.get(94536),
		36016,
		19,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[43]
		},
		[20] = 255
	},
	[36017001] = {
		36017001,
		0,
		Lang.get(94537),
		36017,
		1,
		1206,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36170,
		nil,
		nil,
		nil,
		nil,
		nil,
		36170,
		255
	},
	[36017002] = {
		36017002,
		0,
		Lang.get(94538),
		36017,
		2,
		1195,
		nil,
		1,
		[20] = 255
	},
	[36017003] = {
		36017003,
		0,
		Lang.get(94539),
		36017,
		3,
		1199,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		[20] = 255
	},
	[36017004] = {
		36017004,
		0,
		Lang.get(94540),
		36017,
		4,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[46]
		},
		[20] = 255
	},
	[36017005] = {
		36017005,
		0,
		Lang.get(94541),
		36017,
		5,
		1199,
		{
			RTResTalkAction[67],
			RTResTalkAction[46]
		},
		[20] = 255
	},
	[36017006] = {
		36017006,
		0,
		Lang.get(94542),
		36017,
		6,
		1199,
		{
			RTResTalkAction[67],
			RTResTalkAction[46]
		},
		[20] = 255
	},
	[36017007] = {
		36017007,
		0,
		Lang.get(94543),
		36017,
		7,
		1207,
		{
			RTResTalkAction[117],
			RTResTalkAction[46],
			RTResTalkAction[54]
		},
		[20] = 255
	},
	[36017008] = {
		36017008,
		0,
		Lang.get(94544),
		36017,
		8,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[46],
			RTResTalkAction[113]
		},
		[20] = 255
	},
	[36017009] = {
		36017009,
		0,
		Lang.get(94545),
		36017,
		9,
		1206,
		{
			RTResTalkAction[67],
			RTResTalkAction[40],
			RTResTalkAction[5]
		},
		[20] = 255
	},
	[36017010] = {
		36017010,
		0,
		Lang.get(94546),
		36017,
		10,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[40]
		},
		[20] = 255
	},
	[36017011] = {
		36017011,
		0,
		Lang.get(94547),
		36017,
		11,
		1195,
		{
			RTResTalkAction[89],
			RTResTalkAction[118],
			RTResTalkAction[43]
		},
		[20] = 255
	},
	[36017012] = {
		36017012,
		0,
		Lang.get(94548),
		36017,
		12,
		1207,
		{
			RTResTalkAction[67],
			RTResTalkAction[118]
		},
		[20] = 255
	},
	[36017013] = {
		36017013,
		0,
		Lang.get(94549),
		36017,
		13,
		1199,
		{
			RTResTalkAction[67],
			RTResTalkAction[46],
			RTResTalkAction[113]
		},
		[20] = 255
	},
	[36017014] = {
		36017014,
		0,
		Lang.get(94550),
		36017,
		14,
		1198,
		{
			RTResTalkAction[67],
			RTResTalkAction[105],
			RTResTalkAction[5]
		},
		[20] = 255
	},
	[36017015] = {
		36017015,
		0,
		Lang.get(94551),
		36017,
		15,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[118],
			RTResTalkAction[14]
		},
		[20] = 255
	},
	[36017016] = {
		36017016,
		0,
		Lang.get(94552),
		36017,
		16,
		1207,
		{
			RTResTalkAction[67],
			RTResTalkAction[118]
		},
		[20] = 255
	},
	[36017017] = {
		36017017,
		3,
		Lang.get(94553),
		36017,
		17,
		605,
		{
			RTResTalkAction[54],
			RTResTalkAction[113]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		36171,
		1,
		1,
		nil,
		nil,
		nil,
		36171,
		-1,
		nil,
		1
	},
	[36017018] = {
		36017018,
		0,
		Lang.get(94554),
		36017,
		18,
		1206,
		nil,
		1
	},
	[36017019] = {
		36017019,
		0,
		Lang.get(94555),
		36017,
		19,
		1198,
		nil,
		1
	},
	[36017020] = {
		36017020,
		0,
		Lang.get(94556),
		36017,
		20,
		1207,
		{
			RTResTalkAction[112]
		},
		nil,
		nil,
		3
	},
	[36017021] = {
		36017021,
		0,
		Lang.get(94557),
		36017,
		21,
		1207,
		{
			RTResTalkAction[112]
		}
	},
	[36017022] = {
		36017022,
		0,
		Lang.get(94558),
		36017,
		22,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[113]
		}
	},
	[36018001] = {
		36018001,
		0,
		Lang.get(94559),
		36018,
		1,
		1212,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36180,
		1,
		1,
		nil,
		nil,
		nil,
		36180
	},
	[36018002] = {
		36018002,
		0,
		Lang.get(94560),
		36018,
		2,
		1210,
		nil,
		1
	},
	[36018003] = {
		36018003,
		0,
		Lang.get(94561),
		36018,
		3,
		1212,
		nil,
		1
	},
	[36018004] = {
		36018004,
		0,
		Lang.get(94562),
		36018,
		4,
		1211,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[36018005] = {
		36018005,
		0,
		Lang.get(94563),
		36018,
		5,
		1212,
		{
			RTResTalkAction[119],
			RTResTalkAction[66]
		}
	},
	[36018006] = {
		36018006,
		0,
		Lang.get(94564),
		36018,
		6,
		1211,
		{
			RTResTalkAction[120],
			RTResTalkAction[66]
		}
	},
	[36018007] = {
		36018007,
		0,
		Lang.get(94565),
		36018,
		7,
		1211,
		{
			RTResTalkAction[120],
			RTResTalkAction[66]
		}
	},
	[36018008] = {
		36018008,
		0,
		Lang.get(94566),
		36018,
		8,
		1210,
		{
			RTResTalkAction[121],
			RTResTalkAction[66],
			RTResTalkAction[17]
		}
	},
	[36018009] = {
		36018009,
		0,
		Lang.get(94567),
		36018,
		9,
		1211,
		{
			RTResTalkAction[121],
			RTResTalkAction[69]
		}
	},
	[36018010] = {
		36018010,
		0,
		Lang.get(94568),
		36018,
		10,
		1212,
		{
			RTResTalkAction[120],
			RTResTalkAction[66],
			RTResTalkAction[6]
		}
	},
	[36018011] = {
		36018011,
		0,
		Lang.get(94569),
		36018,
		11,
		1211,
		{
			RTResTalkAction[120],
			RTResTalkAction[66]
		}
	},
	[36018012] = {
		36018012,
		0,
		Lang.get(94570),
		36018,
		12,
		1212,
		{
			RTResTalkAction[120],
			RTResTalkAction[66]
		}
	},
	[36018013] = {
		36018013,
		2,
		Lang.get(94571),
		36018,
		13,
		1211,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[36018014] = {
		36018014,
		0,
		Lang.get(94572),
		36018,
		14,
		1198,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36181,
		1,
		1,
		nil,
		nil,
		nil,
		36181
	},
	[36018015] = {
		36018015,
		0,
		Lang.get(94573),
		36018,
		15,
		1212,
		nil,
		1
	},
	[36018016] = {
		36018016,
		0,
		Lang.get(94574),
		36018,
		16,
		1199,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[36018017] = {
		36018017,
		0,
		Lang.get(94575),
		36018,
		17,
		1212,
		{
			RTResTalkAction[2],
			RTResTalkAction[122]
		}
	},
	[36018018] = {
		36018018,
		0,
		Lang.get(94576),
		36018,
		18,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[122],
			RTResTalkAction[5]
		}
	},
	[36018019] = {
		36018019,
		2,
		Lang.get(94577),
		36018,
		19,
		1211,
		{
			RTResTalkAction[54],
			RTResTalkAction[17]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36182,
		1,
		1,
		nil,
		nil,
		nil,
		36182
	},
	[36018020] = {
		36018020,
		0,
		Lang.get(94578),
		36018,
		20,
		1195,
		nil,
		1
	},
	[36018021] = {
		36018021,
		0,
		Lang.get(94579),
		36018,
		21,
		1211,
		nil,
		1
	},
	[36018022] = {
		36018022,
		0,
		Lang.get(94580),
		36018,
		22,
		1201,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36183,
		[19] = 36183
	},
	[36018023] = {
		36018023,
		0,
		Lang.get(94581),
		36018,
		23,
		1211,
		nil,
		1
	},
	[36018024] = {
		36018024,
		0,
		Lang.get(94582),
		36018,
		24,
		1201,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[36019001] = {
		36019001,
		0,
		Lang.get(94583),
		36019,
		1,
		1195,
		nil,
		1,
		nil,
		nil,
		nil,
		200,
		36190,
		1,
		1,
		nil,
		nil,
		nil,
		36190
	},
	[36019002] = {
		36019002,
		0,
		Lang.get(94584),
		36019,
		2,
		1199,
		nil,
		1
	},
	[36019003] = {
		36019003,
		0,
		Lang.get(94585),
		36019,
		3,
		1210,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36191,
		[19] = 36191
	},
	[36019004] = {
		36019004,
		0,
		Lang.get(94586),
		36019,
		4,
		1026,
		nil,
		1
	},
	[36019005] = {
		36019005,
		0,
		Lang.get(94587),
		36019,
		5,
		1026,
		nil,
		1
	},
	[36019006] = {
		36019006,
		0,
		Lang.get(94588),
		36019,
		6,
		1195,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[36019007] = {
		36019007,
		0,
		Lang.get(94589),
		36019,
		7,
		1212,
		{
			RTResTalkAction[120],
			RTResTalkAction[36]
		}
	},
	[36019008] = {
		36019008,
		0,
		Lang.get(94590),
		36019,
		8,
		1212,
		{
			RTResTalkAction[120],
			RTResTalkAction[36]
		}
	},
	[36019009] = {
		36019009,
		0,
		Lang.get(94591),
		36019,
		9,
		1207,
		{
			RTResTalkAction[112],
			RTResTalkAction[17],
			RTResTalkAction[54]
		}
	},
	[36019010] = {
		36019010,
		0,
		Lang.get(94592),
		36019,
		10,
		1026,
		{
			RTResTalkAction[117],
			RTResTalkAction[96]
		}
	},
	[36019011] = {
		36019011,
		0,
		Lang.get(94593),
		36019,
		11,
		1109,
		{
			RTResTalkAction[113],
			RTResTalkAction[97]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36192,
		1,
		1,
		nil,
		nil,
		nil,
		36192
	},
	[36019012] = {
		36019012,
		0,
		Lang.get(94594),
		36019,
		12,
		1112,
		nil,
		1
	},
	[36019013] = {
		36019013,
		0,
		Lang.get(94595),
		36019,
		13,
		1207,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36193,
		[19] = 36193
	},
	[36019014] = {
		36019014,
		0,
		Lang.get(94596),
		36019,
		14,
		1195,
		nil,
		1
	},
	[36019015] = {
		36019015,
		0,
		Lang.get(94597),
		36019,
		15,
		1212,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36195,
		[19] = 36195
	},
	[36019016] = {
		36019016,
		0,
		Lang.get(94598),
		36019,
		16,
		1047,
		nil,
		1
	},
	[36019017] = {
		36019017,
		0,
		Lang.get(94599),
		36019,
		17,
		1205,
		nil,
		1
	},
	[36019018] = {
		36019018,
		0,
		Lang.get(94600),
		36019,
		18,
		1112,
		nil,
		1
	},
	[36019019] = {
		36019019,
		0,
		Lang.get(94601),
		36019,
		19,
		1109,
		nil,
		1
	},
	[36019020] = {
		36019020,
		3,
		Lang.get(85710),
		36019,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36194,
		1,
		1,
		nil,
		nil,
		nil,
		36194,
		nil,
		nil,
		1
	},
	[36019021] = {
		36019021,
		0,
		Lang.get(94369),
		36019,
		21,
		1198,
		nil,
		1
	},
	[36019022] = {
		36019022,
		0,
		Lang.get(94602),
		36019,
		22,
		1026,
		nil,
		1
	},
	[36019023] = {
		36019023,
		0,
		Lang.get(94603),
		36019,
		23,
		1212,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[36019024] = {
		36019024,
		0,
		Lang.get(94604),
		36019,
		24,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[17]
		}
	},
	[36019025] = {
		36019025,
		0,
		Lang.get(94605),
		36019,
		25,
		1195,
		{
			RTResTalkAction[100]
		}
	},
	[36020001] = {
		36020001,
		0,
		Lang.get(94606),
		36020,
		1,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36200,
		1,
		1,
		nil,
		nil,
		nil,
		36200
	},
	[36020002] = {
		36020002,
		0,
		Lang.get(94607),
		36020,
		2,
		386,
		nil,
		1
	},
	[36020003] = {
		36020003,
		0,
		Lang.get(94608),
		36020,
		3,
		158,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		3
	},
	[36020004] = {
		36020004,
		0,
		Lang.get(94609),
		36020,
		4,
		677,
		{
			RTResTalkAction[124],
			RTResTalkAction[125]
		}
	},
	[36020005] = {
		36020005,
		0,
		Lang.get(94610),
		36020,
		5,
		386,
		{
			RTResTalkAction[126],
			RTResTalkAction[127],
			RTResTalkAction[128]
		}
	},
	[36205001] = {
		36205001,
		0,
		Lang.get(94611),
		36205,
		1,
		1208,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		36201,
		1,
		1,
		nil,
		nil,
		nil,
		36201
	},
	[36205002] = {
		36205002,
		0,
		Lang.get(94612),
		36205,
		2,
		1109,
		{
			RTResTalkAction[129]
		},
		nil,
		nil,
		3
	},
	[36205003] = {
		36205003,
		0,
		Lang.get(94613),
		36205,
		3,
		1204,
		{
			RTResTalkAction[93],
			RTResTalkAction[11]
		}
	},
	[36205004] = {
		36205004,
		0,
		Lang.get(94614),
		36205,
		4,
		1205,
		{
			RTResTalkAction[29],
			RTResTalkAction[33]
		}
	},
	[36205005] = {
		36205005,
		0,
		Lang.get(94615),
		36205,
		5,
		140,
		{
			RTResTalkAction[34]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		36202,
		1,
		1,
		nil,
		nil,
		nil,
		36202
	},
	[36205006] = {
		36205006,
		0,
		Lang.get(94616),
		36205,
		6,
		1211,
		nil,
		1
	},
	[36203001] = {
		36203001,
		0,
		Lang.get(94617),
		36203,
		1,
		1199,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		36203,
		nil,
		nil,
		nil,
		nil,
		nil,
		36203
	},
	[36203002] = {
		36203002,
		0,
		Lang.get(94618),
		36203,
		2,
		1198,
		nil,
		1
	},
	[36203003] = {
		36203003,
		0,
		Lang.get(94619),
		36203,
		3,
		1202,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		3
	},
	[36203004] = {
		36203004,
		0,
		Lang.get(94620),
		36203,
		4,
		1210,
		{
			RTResTalkAction[131],
			RTResTalkAction[132]
		}
	},
	[36203005] = {
		36203005,
		0,
		Lang.get(94621),
		36203,
		5,
		1195,
		{
			RTResTalkAction[57],
			RTResTalkAction[6]
		}
	},
	[36203006] = {
		36203006,
		0,
		Lang.get(94622),
		36203,
		6,
		1207,
		{
			RTResTalkAction[67],
			RTResTalkAction[118]
		}
	},
	[36203007] = {
		36203007,
		0,
		Lang.get(94623),
		36203,
		7,
		1195,
		{
			RTResTalkAction[89],
			RTResTalkAction[118]
		}
	},
	[36203008] = {
		36203008,
		0,
		Lang.get(94624),
		36203,
		8,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[54],
			RTResTalkAction[113]
		}
	},
	[36203009] = {
		36203009,
		0,
		Lang.get(94625),
		36203,
		9,
		140,
		{
			RTResTalkAction[133],
			RTResTalkAction[19]
		}
	},
	[36203010] = {
		36203010,
		0,
		Lang.get(94626),
		36203,
		10,
		1201,
		{
			RTResTalkAction[21],
			RTResTalkAction[134]
		}
	},
	[36203011] = {
		36203011,
		0,
		Lang.get(94627),
		36203,
		11,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[24]
		}
	},
	[36203012] = {
		36203012,
		0,
		Lang.get(94628),
		36203,
		12,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36203013] = {
		36203013,
		0,
		Lang.get(94629),
		36203,
		13,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36203014] = {
		36203014,
		0,
		Lang.get(94630),
		36203,
		14,
		1195,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36203015] = {
		36203015,
		0,
		Lang.get(94631),
		36203,
		15,
		1211,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[36203016] = {
		36203016,
		0,
		Lang.get(94632),
		36203,
		16,
		1026,
		{
			RTResTalkAction[135],
			RTResTalkAction[66],
			RTResTalkAction[54]
		}
	},
	[36203017] = {
		36203017,
		0,
		Lang.get(94633),
		36203,
		17,
		1211,
		{
			RTResTalkAction[60],
			RTResTalkAction[97]
		}
	},
	[36203018] = {
		36203018,
		0,
		Lang.get(94634),
		36203,
		18,
		1195,
		{
			RTResTalkAction[88],
			RTResTalkAction[19]
		}
	},
	[36203019] = {
		36203019,
		3,
		Lang.get(94635),
		36203,
		19,
		605,
		{
			RTResTalkAction[54]
		},
		[22] = 1
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
