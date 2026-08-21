-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\xiaoqiao\\ResTalk.lua

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
	[2] = 1118
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 1237
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 1118
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1237
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 1237,
	[3] = {
		1003
	}
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1003,
	[3] = {
		1
	}
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 1003
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 1237,
	[3] = {
		1001
	}
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1017,
	[3] = {
		1
	}
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1003
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 1091,
	[3] = {
		3
	}
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1017
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 1237
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1091
}
RTResTalkAction[16] = {
	1,
	1237,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[17] = {
	1,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 1003,
	[3] = {
		3
	}
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1142
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 1142
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 1142,
	[3] = {
		1001
	}
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1237,
	[3] = {
		1
	}
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1091,
	[3] = {
		2
	}
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1112,
	[3] = {
		1
	}
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1112
}
RTResTalkAction[26] = {
	[1] = 3,
	[2] = 1112
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 1112,
	[3] = {
		1004
	}
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1117
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1003
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 1117
}
RTResTalkAction[31] = {
	[1] = 2,
	[2] = 1003
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 1017
}
RTResTalkAction[33] = {
	[1] = 2,
	[2] = 1091
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1002
	}
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1112,
	[3] = {
		1004
	}
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 1112
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 1109
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1004
	}
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1109
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 1002
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 1002,
	[3] = {
		3
	}
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1118,
	[3] = {
		1005
	}
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 1002
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 1142,
	[3] = {
		1005
	}
}
RTResTalkAction[45] = {
	1,
	1237,
	{
		1001
	},
	nil,
	1
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[47] = {
	2,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 1237,
	[3] = {
		2
	}
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 1117
}
RTResTalkAction[50] = {
	[1] = 2,
	[2] = 1237,
	[3] = {
		1002
	}
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 1002
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 1002,
	[3] = {
		1003
	}
}
RTResTalkAction[53] = {
	1,
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1
	}
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 1237,
	[3] = {
		3
	}
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 140,
	[3] = {
		1006
	}
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 1117
}
RTResTalkAction[58] = {
	[1] = 3,
	[2] = 140,
	[3] = {
		1006
	}
}
RTResTalkAction[59] = {
	[1] = 2,
	[2] = 1117,
	[3] = {
		1
	}
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 1117,
	[3] = {
		1001
	}
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 1242,
	[3] = {
		1
	}
}
RTResTalkAction[62] = {
	[1] = 3,
	[2] = 1242,
	[3] = {
		1006
	}
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 1242
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 1017,
	[3] = {
		1006
	}
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 1002,
	[3] = {
		1006
	}
}
RTResTalkAction[66] = {
	[1] = 2,
	[2] = 1117,
	[3] = {
		1004
	}
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 1242,
	[3] = {
		1
	}
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 1242,
	[3] = {
		1003
	}
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 1237,
	[3] = {
		1
	}
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 1242,
	[3] = {
		1002
	}
}
RTResTalkAction[71] = {
	[1] = 3,
	[2] = 1117,
	[3] = {
		1001
	}
}
RTResTalkAction[72] = {
	2,
	1237,
	{
		1003
	},
	nil,
	3
}
RTResTalkAction[73] = {
	2,
	1237,
	nil,
	nil,
	3
}
RTResTalkAction[74] = {
	[1] = 3,
	[2] = 1117,
	[3] = {
		1
	}
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 1242,
	[3] = {
		1006
	}
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 1242
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 1242,
	[3] = {
		1001
	}
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 1200,
	[3] = {
		1004
	}
}
RTResTalkAction[79] = {
	[1] = 3,
	[2] = 1200
}
RTResTalkAction[80] = {
	[1] = 2,
	[2] = 1242,
	[3] = {
		1006
	}
}
RTResTalkAction[81] = {
	2,
	1237,
	nil,
	nil,
	2
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 1200,
	[3] = {
		1
	}
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 1200
}
RTResTalkAction[85] = {
	[1] = 1,
	[2] = 1200
}
RTResTalkAction[86] = {
	[1] = 2,
	[2] = 1200
}
RTResTalkAction[87] = {
	[1] = 3,
	[2] = 140
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1112,
	[3] = {
		1006
	}
}
RTResTalkAction[89] = {
	[1] = 3,
	[2] = 1112,
	[3] = {
		1006
	}
}
RTResTalkAction[90] = {
	[1] = 2,
	[2] = 1200,
	[3] = {
		1004
	}
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 1200,
	[3] = {
		1002
	}
}
RTResTalkAction[92] = {
	[1] = 2,
	[2] = 1112,
	[3] = {
		1006
	}
}
RTResTalkAction[93] = {
	[1] = 3,
	[2] = 1200,
	[3] = {
		1004
	}
}
RTResTalkAction[94] = {
	[1] = 3,
	[2] = 1112,
	[3] = {
		1
	}
}
RTResTalkAction[95] = {
	[1] = 3,
	[2] = 1112,
	[3] = {
		2
	}
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 1237,
	[3] = {
		1003
	}
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 1242
}
RTResTalkAction[98] = {
	[1] = 2,
	[2] = 1244
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 1244
}
RTResTalkAction[100] = {
	2,
	1200,
	nil,
	nil,
	0
}
RTResTalkAction[101] = {
	[1] = 3,
	[2] = 1200,
	[3] = {
		1002
	}
}
RTResTalkAction[102] = {
	[1] = 3,
	[2] = 1200,
	[3] = {
		2
	}
}
RTResTalkAction[103] = {
	[1] = 3,
	[2] = 1002,
	[3] = {
		1006
	}
}
RTResTalkAction[104] = {
	1,
	1237,
	{
		1002
	},
	nil,
	1
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 1073,
	[3] = {
		1006
	}
}
RTResTalkAction[106] = {
	[1] = 0,
	[2] = 1073
}
RTResTalkAction[107] = {
	2,
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[108] = {
	[1] = 3,
	[2] = 1073,
	[3] = {
		1006
	}
}
RTResTalkAction[109] = {
	2,
	1200,
	{
		1004
	},
	nil,
	0
}
RTResTalkAction[110] = {
	[1] = 1,
	[2] = 1200,
	[3] = {
		3
	}
}
RTResTalkAction[111] = {
	[1] = 1,
	[2] = 1073,
	[3] = {
		1001
	}
}
RTResTalkAction[112] = {
	1,
	1112,
	{
		1005
	},
	nil,
	0
}
RTResTalkAction[113] = {
	[1] = 3,
	[2] = 1142
}

local Data = {
	[37001001] = {
		37001001,
		3,
		Lang.get(87559),
		37001,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		202,
		37010,
		[19] = 37010,
		[22] = 1
	},
	[37001002] = {
		37001002,
		0,
		Lang.get(99670),
		37001,
		2,
		1118,
		nil,
		1
	},
	[37001003] = {
		37001003,
		0,
		Lang.get(99671),
		37001,
		3,
		1118,
		nil,
		1
	},
	[37001004] = {
		37001004,
		0,
		Lang.get(99672),
		37001,
		4,
		1118,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[37001005] = {
		37001005,
		0,
		Lang.get(99673),
		37001,
		5,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[37001006] = {
		37001006,
		7,
		"112",
		37001,
		6,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37001007] = {
		37001007,
		0,
		Lang.get(99674),
		37001,
		7,
		1118,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[37001008] = {
		37001008,
		0,
		Lang.get(99675),
		37001,
		8,
		1237,
		{
			RTResTalkAction[6],
			RTResTalkAction[3]
		}
	},
	[37001009] = {
		37001009,
		0,
		Lang.get(99676),
		37001,
		9,
		1118,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[37001010] = {
		37001010,
		0,
		Lang.get(99677),
		37001,
		10,
		1118,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[37001011] = {
		37001011,
		0,
		Lang.get(99678),
		37001,
		11,
		1003,
		{
			RTResTalkAction[7],
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37001012] = {
		37001012,
		0,
		Lang.get(99679),
		37001,
		12,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[37001013] = {
		37001013,
		0,
		Lang.get(99680),
		37001,
		13,
		1003,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[37001014] = {
		37001014,
		0,
		Lang.get(99681),
		37001,
		14,
		1237,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[37001015] = {
		37001015,
		0,
		Lang.get(99682),
		37001,
		15,
		1017,
		{
			RTResTalkAction[10],
			RTResTalkAction[4],
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		2751
	},
	[37001016] = {
		37001016,
		0,
		Lang.get(99683),
		37001,
		16,
		1091,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		2759
	},
	[37001017] = {
		37001017,
		0,
		Lang.get(99684),
		37001,
		17,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[37001018] = {
		37001018,
		2,
		Lang.get(99685),
		37001,
		18,
		1237,
		{
			RTResTalkAction[16]
		}
	},
	[37001019] = {
		37001019,
		0,
		Lang.get(99686),
		37001,
		19,
		1237,
		{
			RTResTalkAction[17]
		}
	},
	[37001020] = {
		37001020,
		0,
		Lang.get(99687),
		37001,
		20,
		1003,
		{
			RTResTalkAction[2],
			RTResTalkAction[18]
		}
	},
	[37001021] = {
		37001021,
		0,
		Lang.get(99688),
		37001,
		21,
		1118,
		{
			RTResTalkAction[4],
			RTResTalkAction[11]
		},
		1,
		nil,
		nil,
		nil,
		198,
		37011,
		nil,
		nil,
		nil,
		nil,
		nil,
		37011
	},
	[37001022] = {
		37001022,
		0,
		Lang.get(99689),
		37001,
		22,
		1142,
		nil,
		1
	},
	[37001023] = {
		37001023,
		0,
		Lang.get(99690),
		37001,
		23,
		1142,
		{
			RTResTalkAction[19]
		}
	},
	[37001024] = {
		37001024,
		0,
		Lang.get(99691),
		37001,
		24,
		1118,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[37001025] = {
		37001025,
		0,
		Lang.get(99692),
		37001,
		25,
		1142,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[37002001] = {
		37002001,
		0,
		Lang.get(99693),
		37002,
		1,
		1237,
		nil,
		1,
		2,
		nil,
		nil,
		198,
		37020,
		nil,
		nil,
		nil,
		nil,
		nil,
		37020
	},
	[37002002] = {
		37002002,
		0,
		Lang.get(99694),
		37002,
		2,
		1091,
		nil,
		1,
		0
	},
	[37002003] = {
		37002003,
		0,
		Lang.get(99695),
		37002,
		3,
		1237,
		nil,
		1,
		2
	},
	[37002004] = {
		37002004,
		0,
		Lang.get(99696),
		37002,
		4,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37002005] = {
		37002005,
		0,
		Lang.get(99697),
		37002,
		5,
		1237,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		2765
	},
	[37002006] = {
		37002006,
		0,
		Lang.get(99698),
		37002,
		6,
		1091,
		{
			RTResTalkAction[23],
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		2766
	},
	[37002007] = {
		37002007,
		0,
		Lang.get(99699),
		37002,
		7,
		1237,
		{
			RTResTalkAction[15]
		},
		1,
		0,
		nil,
		nil,
		198,
		37021,
		nil,
		nil,
		nil,
		nil,
		nil,
		37021
	},
	[37002008] = {
		37002008,
		0,
		Lang.get(99700),
		37002,
		8,
		1142,
		nil,
		1
	},
	[37002009] = {
		37002009,
		0,
		Lang.get(99701),
		37002,
		9,
		1237,
		nil,
		1
	},
	[37002010] = {
		37002010,
		0,
		Lang.get(99702),
		37002,
		10,
		1142,
		nil,
		1
	},
	[37002011] = {
		37002011,
		0,
		Lang.get(99703),
		37002,
		11,
		1142,
		nil,
		1,
		nil,
		nil,
		2758,
		62,
		37022,
		nil,
		nil,
		nil,
		nil,
		nil,
		37022
	},
	[37002012] = {
		37002012,
		0,
		Lang.get(99704),
		37002,
		12,
		1109,
		nil,
		1
	},
	[37002013] = {
		37002013,
		0,
		Lang.get(99705),
		37002,
		13,
		1112,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[37002014] = {
		37002014,
		0,
		Lang.get(99706),
		37002,
		14,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[37002015] = {
		37002015,
		0,
		Lang.get(99707),
		37002,
		15,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[26]
		}
	},
	[37002016] = {
		37002016,
		0,
		Lang.get(99708),
		37002,
		16,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[27]
		}
	},
	[37002017] = {
		37002017,
		0,
		Lang.get(99709),
		37002,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[26]
		}
	},
	[37002018] = {
		37002018,
		0,
		Lang.get(99710),
		37002,
		18,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[26]
		}
	},
	[37023001] = {
		37023001,
		0,
		Lang.get(99711),
		37023,
		1,
		1242,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		37023,
		nil,
		nil,
		nil,
		nil,
		nil,
		37023
	},
	[37023002] = {
		37023002,
		0,
		Lang.get(99712),
		37023,
		2,
		1112,
		nil,
		1
	},
	[37024001] = {
		37024001,
		0,
		Lang.get(99713),
		37024,
		1,
		1112,
		nil,
		1,
		nil,
		nil,
		2763,
		62,
		37024,
		nil,
		nil,
		nil,
		nil,
		nil,
		37024
	},
	[37024002] = {
		37024002,
		0,
		Lang.get(99714),
		37024,
		2,
		1117,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[37024003] = {
		37024003,
		0,
		Lang.get(99715),
		37024,
		3,
		1003,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[37024004] = {
		37024004,
		0,
		Lang.get(99716),
		37024,
		4,
		1017,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[37024005] = {
		37024005,
		0,
		Lang.get(99717),
		37024,
		5,
		1091,
		{
			RTResTalkAction[33],
			RTResTalkAction[32],
			RTResTalkAction[11]
		}
	},
	[37024006] = {
		37024006,
		2,
		Lang.get(99718),
		37024,
		6,
		1117,
		{
			RTResTalkAction[34],
			RTResTalkAction[15],
			RTResTalkAction[13]
		}
	},
	[37024007] = {
		37024007,
		0,
		Lang.get(99719),
		37024,
		7,
		1112,
		{
			RTResTalkAction[35],
			RTResTalkAction[30]
		}
	},
	[37024008] = {
		37024008,
		0,
		Lang.get(99720),
		37024,
		8,
		1109,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[37024009] = {
		37024009,
		2,
		Lang.get(99721),
		37024,
		9,
		1117,
		{
			RTResTalkAction[38],
			RTResTalkAction[25],
			RTResTalkAction[39]
		}
	},
	[37003001] = {
		37003001,
		0,
		Lang.get(99722),
		37003,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		2758,
		60,
		37030,
		nil,
		nil,
		nil,
		nil,
		nil,
		37030
	},
	[37003002] = {
		37003002,
		0,
		Lang.get(99723),
		37003,
		2,
		1237,
		nil,
		1
	},
	[37003003] = {
		37003003,
		0,
		Lang.get(99724),
		37003,
		3,
		1002,
		nil,
		1
	},
	[37003004] = {
		37003004,
		0,
		Lang.get(99725),
		37003,
		4,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37003005] = {
		37003005,
		0,
		Lang.get(99726),
		37003,
		5,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37003006] = {
		37003006,
		0,
		Lang.get(99727),
		37003,
		6,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37003007] = {
		37003007,
		0,
		Lang.get(99728),
		37003,
		7,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[41]
		}
	},
	[37003008] = {
		37003008,
		0,
		"……",
		37003,
		8,
		1118,
		{
			RTResTalkAction[42],
			RTResTalkAction[4],
			RTResTalkAction[43]
		},
		nil,
		nil,
		nil,
		2764
	},
	[37003009] = {
		37003009,
		0,
		"……",
		37003,
		9,
		1142,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		}
	},
	[37003010] = {
		37003010,
		0,
		Lang.get(99729),
		37003,
		10,
		1237,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[37003011] = {
		37003011,
		0,
		Lang.get(99730),
		37003,
		11,
		1002,
		{
			RTResTalkAction[47],
			RTResTalkAction[41]
		}
	},
	[37003012] = {
		37003012,
		0,
		Lang.get(99731),
		37003,
		12,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37003013] = {
		37003013,
		0,
		Lang.get(99732),
		37003,
		13,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37003014] = {
		37003014,
		0,
		Lang.get(99733),
		37003,
		14,
		1117,
		{
			RTResTalkAction[38],
			RTResTalkAction[4],
			RTResTalkAction[43]
		}
	},
	[37003015] = {
		37003015,
		0,
		Lang.get(99734),
		37003,
		15,
		1237,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		}
	},
	[37003016] = {
		37003016,
		0,
		Lang.get(99735),
		37003,
		16,
		1117,
		{
			RTResTalkAction[50],
			RTResTalkAction[49]
		}
	},
	[37003017] = {
		37003017,
		0,
		Lang.get(99736),
		37003,
		17,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37003018] = {
		37003018,
		0,
		Lang.get(99737),
		37003,
		18,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37003019] = {
		37003019,
		0,
		Lang.get(99738),
		37003,
		19,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37003020] = {
		37003020,
		0,
		Lang.get(99739),
		37003,
		20,
		1002,
		{
			RTResTalkAction[51],
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[37003021] = {
		37003021,
		0,
		Lang.get(99740),
		37003,
		21,
		1117,
		{
			RTResTalkAction[28],
			RTResTalkAction[43]
		}
	},
	[37003022] = {
		37003022,
		0,
		Lang.get(99741),
		37003,
		22,
		1002,
		{
			RTResTalkAction[52],
			RTResTalkAction[30]
		},
		nil,
		nil,
		nil,
		2755
	},
	[37003023] = {
		37003023,
		0,
		Lang.get(99742),
		37003,
		23,
		1237,
		{
			RTResTalkAction[53],
			RTResTalkAction[43]
		}
	},
	[37004001] = {
		37004001,
		0,
		Lang.get(99743),
		37004,
		1,
		1237,
		nil,
		1,
		1,
		nil,
		nil,
		113,
		37040,
		nil,
		nil,
		nil,
		nil,
		nil,
		37040
	},
	[37004002] = {
		37004002,
		0,
		Lang.get(99744),
		37004,
		2,
		1117,
		nil,
		1,
		0
	},
	[37004003] = {
		37004003,
		0,
		Lang.get(99745),
		37004,
		3,
		1117,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[37004004] = {
		37004004,
		0,
		Lang.get(99746),
		37004,
		4,
		1117,
		{
			RTResTalkAction[28]
		}
	},
	[37004005] = {
		37004005,
		0,
		Lang.get(99747),
		37004,
		5,
		1117,
		{
			RTResTalkAction[28]
		}
	},
	[37004006] = {
		37004006,
		2,
		"！",
		37004,
		6,
		1237,
		{
			RTResTalkAction[55],
			RTResTalkAction[30]
		}
	},
	[37004007] = {
		37004007,
		0,
		"……",
		37004,
		7,
		1142,
		{
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[37004008] = {
		37004008,
		0,
		Lang.get(99748),
		37004,
		8,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[46]
		}
	},
	[37004009] = {
		37004009,
		0,
		Lang.get(99749),
		37004,
		9,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37004010] = {
		37004010,
		0,
		Lang.get(99750),
		37004,
		10,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37005001] = {
		37005001,
		0,
		Lang.get(99751),
		37005,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		nil,
		198,
		37050,
		nil,
		nil,
		nil,
		nil,
		nil,
		37050
	},
	[37005002] = {
		37005002,
		0,
		Lang.get(99752),
		37005,
		2,
		1117,
		nil,
		1
	},
	[37005003] = {
		37005003,
		0,
		Lang.get(99753),
		37005,
		3,
		1118,
		nil,
		1
	},
	[37005004] = {
		37005004,
		0,
		Lang.get(99754),
		37005,
		4,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37005005] = {
		37005005,
		0,
		Lang.get(99755),
		37005,
		5,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37005006] = {
		37005006,
		0,
		Lang.get(99756),
		37005,
		6,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37005007] = {
		37005007,
		3,
		Lang.get(92028),
		37005,
		7,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		},
		[22] = 1
	},
	[37005008] = {
		37005008,
		0,
		Lang.get(99757),
		37005,
		8,
		1073,
		nil,
		1,
		nil,
		nil,
		2756,
		63,
		37051,
		nil,
		nil,
		nil,
		nil,
		nil,
		37051
	},
	[37006001] = {
		37006001,
		3,
		Lang.get(99758),
		37006,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		37060,
		[19] = 37060,
		[22] = 1
	},
	[37006002] = {
		37006002,
		0,
		Lang.get(99759),
		37006,
		2,
		1117,
		nil,
		1
	},
	[37006003] = {
		37006003,
		0,
		Lang.get(99760),
		37006,
		3,
		1117,
		nil,
		1
	},
	[37061001] = {
		37061001,
		0,
		Lang.get(99761),
		37061,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		37061,
		nil,
		nil,
		nil,
		nil,
		nil,
		37061
	},
	[37061002] = {
		37061002,
		0,
		Lang.get(99762),
		37061,
		2,
		1117,
		nil,
		1
	},
	[37061003] = {
		37061003,
		0,
		Lang.get(99763),
		37061,
		3,
		140,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[37061004] = {
		37061004,
		0,
		Lang.get(99764),
		37061,
		4,
		1117,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[37061005] = {
		37061005,
		0,
		Lang.get(99765),
		37061,
		5,
		140,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[37061006] = {
		37061006,
		0,
		Lang.get(99766),
		37061,
		6,
		1117,
		{
			RTResTalkAction[59],
			RTResTalkAction[58]
		}
	},
	[37062001] = {
		37062001,
		0,
		Lang.get(99767),
		37062,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		2759,
		63,
		37062,
		nil,
		nil,
		nil,
		nil,
		nil,
		37062
	},
	[37062002] = {
		37062002,
		0,
		Lang.get(99768),
		37062,
		2,
		140,
		nil,
		1
	},
	[37062003] = {
		37062003,
		2,
		Lang.get(99769),
		37062,
		3,
		1117,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		3
	},
	[37062004] = {
		37062004,
		0,
		Lang.get(99770),
		37062,
		4,
		1117,
		{
			RTResTalkAction[28]
		}
	},
	[37062005] = {
		37062005,
		0,
		Lang.get(99771),
		37062,
		5,
		1242,
		{
			RTResTalkAction[61],
			RTResTalkAction[30]
		}
	},
	[37062006] = {
		37062006,
		0,
		Lang.get(99772),
		37062,
		6,
		1117,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37062007] = {
		37062007,
		0,
		Lang.get(99773),
		37062,
		7,
		1242,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37062008] = {
		37062008,
		0,
		Lang.get(99774),
		37062,
		8,
		1117,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37062009] = {
		37062009,
		2,
		Lang.get(99775),
		37062,
		9,
		1117,
		{
			RTResTalkAction[28],
			RTResTalkAction[63]
		}
	},
	[37007001] = {
		37007001,
		2,
		Lang.get(99776),
		37007,
		1,
		1117,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		37070,
		nil,
		nil,
		nil,
		nil,
		nil,
		37070
	},
	[37007002] = {
		37007002,
		2,
		Lang.get(99777),
		37007,
		2,
		1117,
		nil,
		1
	},
	[37007003] = {
		37007003,
		0,
		Lang.get(99778),
		37007,
		3,
		1017,
		{
			RTResTalkAction[64]
		}
	},
	[37007004] = {
		37007004,
		0,
		Lang.get(99779),
		37007,
		4,
		1002,
		{
			RTResTalkAction[65],
			RTResTalkAction[13]
		}
	},
	[37007005] = {
		37007005,
		2,
		Lang.get(99780),
		37007,
		5,
		1117,
		{
			RTResTalkAction[60],
			RTResTalkAction[43]
		}
	},
	[37007006] = {
		37007006,
		0,
		Lang.get(99781),
		37007,
		6,
		1242,
		{
			RTResTalkAction[61],
			RTResTalkAction[30]
		}
	},
	[37007007] = {
		37007007,
		0,
		Lang.get(99782),
		37007,
		7,
		1117,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37007008] = {
		37007008,
		0,
		Lang.get(99783),
		37007,
		8,
		1242,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37007009] = {
		37007009,
		0,
		Lang.get(99784),
		37007,
		9,
		1242,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37007010] = {
		37007010,
		0,
		Lang.get(99785),
		37007,
		10,
		1117,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37007011] = {
		37007011,
		0,
		Lang.get(99786),
		37007,
		11,
		1117,
		{
			RTResTalkAction[66],
			RTResTalkAction[62]
		}
	},
	[37007012] = {
		37007012,
		0,
		Lang.get(99787),
		37007,
		12,
		1242,
		{
			RTResTalkAction[57],
			RTResTalkAction[67]
		}
	},
	[37008001] = {
		37008001,
		0,
		Lang.get(99788),
		37008,
		1,
		1242,
		nil,
		1,
		nil,
		nil,
		2747,
		60,
		37080,
		nil,
		nil,
		nil,
		nil,
		nil,
		37080
	},
	[37008002] = {
		37008002,
		0,
		Lang.get(99789),
		37008,
		2,
		1117,
		nil,
		1
	},
	[37008003] = {
		37008003,
		0,
		Lang.get(99790),
		37008,
		3,
		1242,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3
	},
	[37008004] = {
		37008004,
		0,
		Lang.get(99791),
		37008,
		4,
		1117,
		{
			RTResTalkAction[66],
			RTResTalkAction[62]
		}
	},
	[37008005] = {
		37008005,
		0,
		Lang.get(99792),
		37008,
		5,
		1242,
		{
			RTResTalkAction[57],
			RTResTalkAction[62]
		}
	},
	[37008006] = {
		37008006,
		0,
		Lang.get(99793),
		37008,
		6,
		1237,
		{
			RTResTalkAction[69],
			RTResTalkAction[62],
			RTResTalkAction[30]
		}
	},
	[37008007] = {
		37008007,
		0,
		Lang.get(99794),
		37008,
		7,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49],
			RTResTalkAction[63]
		}
	},
	[37008008] = {
		37008008,
		0,
		Lang.get(99795),
		37008,
		8,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37008009] = {
		37008009,
		0,
		Lang.get(99796),
		37008,
		9,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[62],
			RTResTalkAction[30]
		}
	},
	[37008010] = {
		37008010,
		0,
		Lang.get(99797),
		37008,
		10,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37008011] = {
		37008011,
		0,
		Lang.get(99798),
		37008,
		11,
		1237,
		{
			RTResTalkAction[69],
			RTResTalkAction[62]
		}
	},
	[37008012] = {
		37008012,
		0,
		Lang.get(99799),
		37008,
		12,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[70]
		}
	},
	[37008013] = {
		37008013,
		0,
		Lang.get(99800),
		37008,
		13,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37008014] = {
		37008014,
		0,
		Lang.get(99801),
		37008,
		14,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37008015] = {
		37008015,
		0,
		Lang.get(99802),
		37008,
		15,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37008016] = {
		37008016,
		0,
		Lang.get(99803),
		37008,
		16,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[70]
		}
	},
	[37008017] = {
		37008017,
		0,
		Lang.get(99804),
		37008,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49],
			RTResTalkAction[63]
		}
	},
	[37008018] = {
		37008018,
		0,
		Lang.get(99805),
		37008,
		18,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009001] = {
		37009001,
		0,
		Lang.get(99806),
		37009,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		2746,
		177,
		37090,
		nil,
		nil,
		nil,
		nil,
		nil,
		37090
	},
	[37009002] = {
		37009002,
		0,
		Lang.get(99807),
		37009,
		2,
		1117,
		nil,
		1
	},
	[37009003] = {
		37009003,
		0,
		Lang.get(99808),
		37009,
		3,
		1237,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[37009004] = {
		37009004,
		0,
		Lang.get(99809),
		37009,
		4,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009005] = {
		37009005,
		0,
		Lang.get(99810),
		37009,
		5,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009006] = {
		37009006,
		0,
		Lang.get(99811),
		37009,
		6,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009007] = {
		37009007,
		0,
		Lang.get(99812),
		37009,
		7,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009008] = {
		37009008,
		0,
		Lang.get(99813),
		37009,
		8,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009009] = {
		37009009,
		0,
		Lang.get(99814),
		37009,
		9,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009010] = {
		37009010,
		0,
		Lang.get(99815),
		37009,
		10,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009011] = {
		37009011,
		0,
		Lang.get(99816),
		37009,
		11,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009012] = {
		37009012,
		0,
		Lang.get(99817),
		37009,
		12,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009013] = {
		37009013,
		0,
		Lang.get(99818),
		37009,
		13,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009014] = {
		37009014,
		0,
		Lang.get(99819),
		37009,
		14,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009015] = {
		37009015,
		0,
		Lang.get(99820),
		37009,
		15,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009016] = {
		37009016,
		0,
		Lang.get(99821),
		37009,
		16,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009017] = {
		37009017,
		0,
		Lang.get(99822),
		37009,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009018] = {
		37009018,
		0,
		Lang.get(99823),
		37009,
		18,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009019] = {
		37009019,
		0,
		Lang.get(99824),
		37009,
		19,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37009020] = {
		37009020,
		0,
		"…………………………",
		37009,
		20,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[71]
		}
	},
	[37009021] = {
		37009021,
		0,
		Lang.get(99825),
		37009,
		21,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[49]
		}
	},
	[37009022] = {
		37009022,
		0,
		Lang.get(19819),
		37009,
		22,
		1117,
		{
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[37009023] = {
		37009023,
		0,
		Lang.get(99826),
		37009,
		23,
		1237,
		{
			RTResTalkAction[73],
			RTResTalkAction[49]
		}
	},
	[37009024] = {
		37009024,
		0,
		Lang.get(99827),
		37009,
		24,
		1117,
		{
			RTResTalkAction[73],
			RTResTalkAction[49]
		}
	},
	[37009025] = {
		37009025,
		0,
		Lang.get(99828),
		37009,
		25,
		1237,
		{
			RTResTalkAction[47],
			RTResTalkAction[49]
		}
	},
	[37010001] = {
		37010001,
		0,
		Lang.get(99829),
		37010,
		1,
		1242,
		nil,
		1,
		nil,
		nil,
		nil,
		177,
		37100,
		nil,
		nil,
		nil,
		nil,
		nil,
		37100
	},
	[37010002] = {
		37010002,
		0,
		Lang.get(99830),
		37010,
		2,
		1237,
		nil,
		1
	},
	[37010003] = {
		37010003,
		0,
		Lang.get(99831),
		37010,
		3,
		1237,
		nil,
		1
	},
	[37010004] = {
		37010004,
		0,
		Lang.get(99832),
		37010,
		4,
		1242,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[37010005] = {
		37010005,
		0,
		Lang.get(99833),
		37010,
		5,
		1242,
		{
			RTResTalkAction[75]
		}
	},
	[37010006] = {
		37010006,
		0,
		Lang.get(99834),
		37010,
		6,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[76]
		}
	},
	[37010007] = {
		37010007,
		0,
		"………………",
		37010,
		7,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[77]
		}
	},
	[37010008] = {
		37010008,
		0,
		Lang.get(99835),
		37010,
		8,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37010009] = {
		37010009,
		0,
		Lang.get(99836),
		37010,
		9,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37010010] = {
		37010010,
		0,
		Lang.get(99837),
		37010,
		10,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37010011] = {
		37010011,
		0,
		Lang.get(99838),
		37010,
		11,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49],
			RTResTalkAction[63]
		}
	},
	[37010012] = {
		37010012,
		0,
		Lang.get(99839),
		37010,
		12,
		1237,
		{
			RTResTalkAction[69],
			RTResTalkAction[49]
		}
	},
	[37010013] = {
		37010013,
		0,
		Lang.get(99840),
		37010,
		13,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37010014] = {
		37010014,
		3,
		Lang.get(85710),
		37010,
		14,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		},
		[22] = 1
	},
	[37010015] = {
		37010015,
		0,
		Lang.get(99841),
		37010,
		15,
		1200,
		{
			RTResTalkAction[78],
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[37010016] = {
		37010016,
		0,
		Lang.get(99842),
		37010,
		16,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37010017] = {
		37010017,
		0,
		Lang.get(99843),
		37010,
		17,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37010018] = {
		37010018,
		0,
		Lang.get(99844),
		37010,
		18,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37010019] = {
		37010019,
		0,
		Lang.get(99845),
		37010,
		19,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37010020] = {
		37010020,
		0,
		Lang.get(99846),
		37010,
		20,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37010021] = {
		37010021,
		0,
		Lang.get(99847),
		37010,
		21,
		1242,
		{
			RTResTalkAction[80],
			RTResTalkAction[79],
			RTResTalkAction[4]
		}
	},
	[37010022] = {
		37010022,
		0,
		Lang.get(19819),
		37010,
		22,
		1200,
		{
			RTResTalkAction[80],
			RTResTalkAction[79]
		}
	},
	[37010023] = {
		37010023,
		0,
		Lang.get(99848),
		37010,
		23,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79],
			RTResTalkAction[63]
		}
	},
	[37010024] = {
		37010024,
		0,
		Lang.get(99849),
		37010,
		24,
		1237,
		{
			RTResTalkAction[81],
			RTResTalkAction[79]
		}
	},
	[37010025] = {
		37010025,
		0,
		Lang.get(99850),
		37010,
		25,
		1200,
		{
			RTResTalkAction[47],
			RTResTalkAction[79]
		}
	},
	[37011001] = {
		37011001,
		3,
		Lang.get(85710),
		37011,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		177,
		37110,
		[19] = 37110,
		[22] = 1
	},
	[37011002] = {
		37011002,
		0,
		Lang.get(99851),
		37011,
		2,
		1200,
		nil,
		1
	},
	[37011003] = {
		37011003,
		0,
		Lang.get(99852),
		37011,
		3,
		1237,
		nil,
		1
	},
	[37011004] = {
		37011004,
		0,
		Lang.get(19819),
		37011,
		4,
		1200,
		nil,
		1
	},
	[37011005] = {
		37011005,
		0,
		Lang.get(99853),
		37011,
		5,
		140,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[37011006] = {
		37011006,
		0,
		Lang.get(99854),
		37011,
		6,
		1200,
		{
			RTResTalkAction[82],
			RTResTalkAction[83]
		}
	},
	[37011007] = {
		37011007,
		0,
		Lang.get(99855),
		37011,
		7,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011008] = {
		37011008,
		0,
		Lang.get(99856),
		37011,
		8,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011009] = {
		37011009,
		0,
		Lang.get(99857),
		37011,
		9,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011010] = {
		37011010,
		0,
		Lang.get(99858),
		37011,
		10,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011011] = {
		37011011,
		0,
		Lang.get(99859),
		37011,
		11,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011012] = {
		37011012,
		0,
		Lang.get(99860),
		37011,
		12,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011013] = {
		37011013,
		0,
		Lang.get(99861),
		37011,
		13,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37011014] = {
		37011014,
		0,
		Lang.get(99862),
		37011,
		14,
		1200,
		{
			RTResTalkAction[4],
			RTResTalkAction[84]
		},
		1,
		nil,
		nil,
		nil,
		60,
		37111,
		nil,
		nil,
		nil,
		nil,
		nil,
		37111
	},
	[37011015] = {
		37011015,
		0,
		"……？！",
		37011,
		15,
		140,
		nil,
		1
	},
	[37011016] = {
		37011016,
		0,
		Lang.get(99863),
		37011,
		16,
		1200,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[37011017] = {
		37011017,
		0,
		Lang.get(99864),
		37011,
		17,
		140,
		{
			RTResTalkAction[86],
			RTResTalkAction[58]
		}
	},
	[37011018] = {
		37011018,
		0,
		Lang.get(99865),
		37011,
		18,
		1200,
		{
			RTResTalkAction[86],
			RTResTalkAction[58]
		}
	},
	[37011019] = {
		37011019,
		0,
		Lang.get(99866),
		37011,
		19,
		140,
		{
			RTResTalkAction[86],
			RTResTalkAction[87]
		}
	},
	[37011020] = {
		37011020,
		0,
		Lang.get(99867),
		37011,
		20,
		1200,
		{
			RTResTalkAction[86],
			RTResTalkAction[87]
		}
	},
	[37011021] = {
		37011021,
		0,
		Lang.get(99868),
		37011,
		21,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79],
			RTResTalkAction[83]
		}
	},
	[37011022] = {
		37011022,
		0,
		Lang.get(99869),
		37011,
		22,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37012001] = {
		37012001,
		0,
		Lang.get(99870),
		37012,
		1,
		1200,
		nil,
		1,
		nil,
		nil,
		nil,
		198,
		37120,
		nil,
		nil,
		nil,
		nil,
		nil,
		37120
	},
	[37012002] = {
		37012002,
		0,
		Lang.get(99871),
		37012,
		2,
		1237,
		nil,
		1
	},
	[37012003] = {
		37012003,
		0,
		Lang.get(99872),
		37012,
		3,
		1237,
		nil,
		1
	},
	[37012004] = {
		37012004,
		0,
		Lang.get(99873),
		37012,
		4,
		1002,
		nil,
		1,
		nil,
		nil,
		nil,
		198,
		37121,
		nil,
		nil,
		nil,
		nil,
		nil,
		37121
	},
	[37012005] = {
		37012005,
		0,
		Lang.get(99874),
		37012,
		5,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37012006] = {
		37012006,
		0,
		Lang.get(99875),
		37012,
		6,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37012007] = {
		37012007,
		0,
		Lang.get(99876),
		37012,
		7,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[37012008] = {
		37012008,
		0,
		Lang.get(99877),
		37012,
		8,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79],
			RTResTalkAction[43]
		}
	},
	[37012009] = {
		37012009,
		0,
		Lang.get(99878),
		37012,
		9,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37012010] = {
		37012010,
		0,
		Lang.get(99879),
		37012,
		10,
		1112,
		{
			RTResTalkAction[88],
			RTResTalkAction[4],
			RTResTalkAction[84]
		}
	},
	[37012011] = {
		37012011,
		0,
		Lang.get(99880),
		37012,
		11,
		1112,
		{
			RTResTalkAction[88]
		}
	},
	[37012012] = {
		37012012,
		0,
		Lang.get(99881),
		37012,
		12,
		1237,
		{
			RTResTalkAction[69],
			RTResTalkAction[89]
		}
	},
	[37012013] = {
		37012013,
		0,
		Lang.get(99882),
		37012,
		13,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37012014] = {
		37012014,
		0,
		Lang.get(99883),
		37012,
		14,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37012015] = {
		37012015,
		0,
		Lang.get(99884),
		37012,
		15,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[27]
		}
	},
	[37012016] = {
		37012016,
		0,
		Lang.get(99885),
		37012,
		16,
		1200,
		{
			RTResTalkAction[90],
			RTResTalkAction[89],
			RTResTalkAction[4]
		}
	},
	[37012017] = {
		37012017,
		0,
		Lang.get(99886),
		37012,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[26],
			RTResTalkAction[84]
		}
	},
	[37012018] = {
		37012018,
		0,
		Lang.get(99887),
		37012,
		18,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[26]
		}
	},
	[37013001] = {
		37013001,
		0,
		Lang.get(99888),
		37013,
		1,
		1200,
		nil,
		1,
		nil,
		nil,
		nil,
		198,
		37130,
		nil,
		nil,
		nil,
		nil,
		nil,
		37130
	},
	[37013002] = {
		37013002,
		0,
		Lang.get(99889),
		37013,
		2,
		1237,
		nil,
		1
	},
	[37013003] = {
		37013003,
		0,
		Lang.get(99890),
		37013,
		3,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37013004] = {
		37013004,
		0,
		Lang.get(99891),
		37013,
		4,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37013005] = {
		37013005,
		0,
		Lang.get(99892),
		37013,
		5,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37131001] = {
		37131001,
		0,
		Lang.get(99893),
		37131,
		1,
		1200,
		{
			RTResTalkAction[91]
		},
		1,
		nil,
		nil,
		nil,
		60,
		37131,
		nil,
		nil,
		nil,
		nil,
		nil,
		37131
	},
	[37131002] = {
		37131002,
		0,
		Lang.get(99894),
		37131,
		2,
		1237,
		{
			RTResTalkAction[84]
		},
		1
	},
	[37131003] = {
		37131003,
		0,
		Lang.get(99895),
		37131,
		3,
		1200,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		3
	},
	[37131004] = {
		37131004,
		0,
		Lang.get(99896),
		37131,
		4,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131005] = {
		37131005,
		0,
		Lang.get(99897),
		37131,
		5,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131006] = {
		37131006,
		0,
		Lang.get(99898),
		37131,
		6,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131007] = {
		37131007,
		0,
		Lang.get(99899),
		37131,
		7,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131008] = {
		37131008,
		0,
		Lang.get(99900),
		37131,
		8,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131009] = {
		37131009,
		0,
		Lang.get(99901),
		37131,
		9,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37131010] = {
		37131010,
		0,
		Lang.get(99902),
		37131,
		10,
		1112,
		{
			RTResTalkAction[92],
			RTResTalkAction[79],
			RTResTalkAction[4]
		}
	},
	[37131011] = {
		37131011,
		0,
		Lang.get(99903),
		37131,
		11,
		1112,
		{
			RTResTalkAction[92],
			RTResTalkAction[79]
		}
	},
	[37014001] = {
		37014001,
		3,
		Lang.get(99904),
		37014,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		37140,
		[19] = 37140,
		[22] = 1
	},
	[37014002] = {
		37014002,
		0,
		Lang.get(99905),
		37014,
		2,
		1112,
		nil,
		1
	},
	[37014003] = {
		37014003,
		0,
		Lang.get(99906),
		37014,
		3,
		1200,
		nil,
		1
	},
	[37014004] = {
		37014004,
		0,
		Lang.get(99907),
		37014,
		4,
		1112,
		nil,
		1
	},
	[37014005] = {
		37014005,
		0,
		"……",
		37014,
		5,
		1200,
		nil,
		1
	},
	[37014006] = {
		37014006,
		0,
		Lang.get(99908),
		37014,
		6,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37014007] = {
		37014007,
		0,
		Lang.get(99909),
		37014,
		7,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[93]
		}
	},
	[37014008] = {
		37014008,
		0,
		Lang.get(99910),
		37014,
		8,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37014009] = {
		37014009,
		0,
		Lang.get(99911),
		37014,
		9,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37014010] = {
		37014010,
		3,
		Lang.get(99912),
		37014,
		10,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		nil,
		60,
		37141,
		[19] = 37141,
		[22] = 1
	},
	[37014011] = {
		37014011,
		0,
		Lang.get(99913),
		37014,
		11,
		1112,
		nil,
		1
	},
	[37014012] = {
		37014012,
		0,
		Lang.get(99914),
		37014,
		12,
		1112,
		nil,
		1,
		nil,
		3
	},
	[37014013] = {
		37014013,
		0,
		Lang.get(99915),
		37014,
		13,
		1200,
		{
			RTResTalkAction[85]
		}
	},
	[37014014] = {
		37014014,
		0,
		Lang.get(99916),
		37014,
		14,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[84]
		}
	},
	[37014015] = {
		37014015,
		0,
		Lang.get(99917),
		37014,
		15,
		1237,
		{
			RTResTalkAction[53]
		}
	},
	[37014016] = {
		37014016,
		0,
		Lang.get(99918),
		37014,
		16,
		1237,
		{
			RTResTalkAction[53]
		}
	},
	[37014017] = {
		37014017,
		0,
		Lang.get(99919),
		37014,
		17,
		1237,
		{
			RTResTalkAction[17]
		}
	},
	[37014018] = {
		37014018,
		0,
		Lang.get(99920),
		37014,
		18,
		1237,
		{
			RTResTalkAction[22]
		}
	},
	[37014019] = {
		37014019,
		0,
		Lang.get(99921),
		37014,
		19,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37014020] = {
		37014020,
		0,
		Lang.get(99922),
		37014,
		20,
		1112,
		{
			RTResTalkAction[86],
			RTResTalkAction[94],
			RTResTalkAction[4]
		}
	},
	[37014021] = {
		37014021,
		0,
		Lang.get(99923),
		37014,
		21,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[89],
			RTResTalkAction[84]
		}
	},
	[37014022] = {
		37014022,
		0,
		Lang.get(99924),
		37014,
		22,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[95]
		}
	},
	[37014023] = {
		37014023,
		0,
		Lang.get(99925),
		37014,
		23,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37014024] = {
		37014024,
		0,
		Lang.get(99926),
		37014,
		24,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37015001] = {
		37015001,
		0,
		Lang.get(99927),
		37015,
		1,
		1112,
		nil,
		1,
		nil,
		nil,
		nil,
		159,
		37150,
		nil,
		nil,
		nil,
		nil,
		nil,
		37150
	},
	[37015002] = {
		37015002,
		0,
		Lang.get(99928),
		37015,
		2,
		1237,
		nil,
		1
	},
	[37015003] = {
		37015003,
		0,
		Lang.get(99929),
		37015,
		3,
		1112,
		nil,
		1
	},
	[37015004] = {
		37015004,
		0,
		Lang.get(99930),
		37015,
		4,
		1237,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[37015005] = {
		37015005,
		0,
		Lang.get(99931),
		37015,
		5,
		1237,
		{
			RTResTalkAction[14]
		}
	},
	[37015006] = {
		37015006,
		0,
		Lang.get(99932),
		37015,
		6,
		1112,
		{
			RTResTalkAction[2],
			RTResTalkAction[89]
		}
	},
	[37015007] = {
		37015007,
		0,
		Lang.get(99933),
		37015,
		7,
		1237,
		{
			RTResTalkAction[96],
			RTResTalkAction[25]
		}
	},
	[37015008] = {
		37015008,
		0,
		Lang.get(99934),
		37015,
		8,
		1237,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		159,
		37151,
		nil,
		nil,
		nil,
		nil,
		nil,
		37151
	},
	[37015009] = {
		37015009,
		0,
		Lang.get(99935),
		37015,
		9,
		1237,
		nil,
		1
	},
	[37015010] = {
		37015010,
		0,
		Lang.get(99936),
		37015,
		10,
		1242,
		{
			RTResTalkAction[75]
		}
	},
	[37015011] = {
		37015011,
		0,
		Lang.get(99937),
		37015,
		11,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37015012] = {
		37015012,
		0,
		Lang.get(99938),
		37015,
		12,
		1242,
		{
			RTResTalkAction[2],
			RTResTalkAction[62]
		}
	},
	[37152001] = {
		37152001,
		0,
		Lang.get(99939),
		37152,
		1,
		1242,
		nil,
		1,
		nil,
		nil,
		nil,
		159,
		37152,
		nil,
		nil,
		nil,
		nil,
		nil,
		37152
	},
	[37152002] = {
		37152002,
		0,
		Lang.get(99940),
		37152,
		2,
		1112,
		nil,
		1
	},
	[37152003] = {
		37152003,
		0,
		Lang.get(99941),
		37152,
		3,
		1200,
		nil,
		1
	},
	[37152004] = {
		37152004,
		0,
		Lang.get(99942),
		37152,
		4,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37152005] = {
		37152005,
		0,
		Lang.get(99943),
		37152,
		5,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37152006] = {
		37152006,
		0,
		Lang.get(99944),
		37152,
		6,
		1242,
		{
			RTResTalkAction[97],
			RTResTalkAction[4],
			RTResTalkAction[84]
		}
	},
	[37152007] = {
		37152007,
		0,
		Lang.get(99945),
		37152,
		7,
		1244,
		{
			RTResTalkAction[98],
			RTResTalkAction[76]
		}
	},
	[37152008] = {
		37152008,
		0,
		Lang.get(99946),
		37152,
		8,
		1242,
		{
			RTResTalkAction[97],
			RTResTalkAction[99]
		}
	},
	[37016001] = {
		37016001,
		3,
		Lang.get(99947),
		37016,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		177,
		37160,
		[19] = 37160,
		[22] = 1
	},
	[37016002] = {
		37016002,
		0,
		Lang.get(99948),
		37016,
		2,
		1242,
		nil,
		1
	},
	[37016003] = {
		37016003,
		0,
		Lang.get(99949),
		37016,
		3,
		1237,
		nil,
		1
	},
	[37016004] = {
		37016004,
		0,
		Lang.get(99950),
		37016,
		4,
		1242,
		nil,
		1
	},
	[37016005] = {
		37016005,
		0,
		Lang.get(99951),
		37016,
		5,
		1237,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[37016006] = {
		37016006,
		0,
		Lang.get(99952),
		37016,
		6,
		1242,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[37016007] = {
		37016007,
		0,
		Lang.get(99953),
		37016,
		7,
		1200,
		{
			RTResTalkAction[100],
			RTResTalkAction[62],
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		2765
	},
	[37016008] = {
		37016008,
		0,
		Lang.get(99954),
		37016,
		8,
		1242,
		{
			RTResTalkAction[86],
			RTResTalkAction[62]
		}
	},
	[37016009] = {
		37016009,
		0,
		Lang.get(19819),
		37016,
		9,
		1200,
		{
			RTResTalkAction[90],
			RTResTalkAction[62]
		}
	},
	[37016010] = {
		37016010,
		0,
		Lang.get(99955),
		37016,
		10,
		1242,
		{
			RTResTalkAction[86],
			RTResTalkAction[62]
		}
	},
	[37016011] = {
		37016011,
		0,
		Lang.get(99956),
		37016,
		11,
		1200,
		{
			RTResTalkAction[84],
			RTResTalkAction[63]
		},
		1,
		nil,
		nil,
		2759,
		159,
		37161,
		nil,
		nil,
		nil,
		nil,
		nil,
		37161
	},
	[37016012] = {
		37016012,
		0,
		Lang.get(99957),
		37016,
		12,
		1200,
		nil,
		1
	},
	[37016013] = {
		37016013,
		0,
		Lang.get(99958),
		37016,
		13,
		1237,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[37016014] = {
		37016014,
		0,
		Lang.get(99959),
		37016,
		14,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[93]
		}
	},
	[37016015] = {
		37016015,
		0,
		Lang.get(99960),
		37016,
		15,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37016016] = {
		37016016,
		0,
		Lang.get(99961),
		37016,
		16,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37016017] = {
		37016017,
		0,
		Lang.get(99962),
		37016,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37016018] = {
		37016018,
		0,
		Lang.get(99963),
		37016,
		18,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37016019] = {
		37016019,
		0,
		Lang.get(99964),
		37016,
		19,
		1237,
		{
			RTResTalkAction[73],
			RTResTalkAction[79]
		}
	},
	[37016020] = {
		37016020,
		0,
		Lang.get(99965),
		37016,
		20,
		1200,
		{
			RTResTalkAction[73],
			RTResTalkAction[79]
		}
	},
	[37016021] = {
		37016021,
		0,
		Lang.get(99966),
		37016,
		21,
		1237,
		{
			RTResTalkAction[73],
			RTResTalkAction[79]
		}
	},
	[37017001] = {
		37017001,
		0,
		Lang.get(99967),
		37017,
		1,
		1200,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		37170,
		nil,
		nil,
		nil,
		nil,
		nil,
		37170
	},
	[37017002] = {
		37017002,
		0,
		Lang.get(99968),
		37017,
		2,
		1237,
		nil,
		1
	},
	[37017003] = {
		37017003,
		0,
		Lang.get(99969),
		37017,
		3,
		1237,
		nil,
		1
	},
	[37017004] = {
		37017004,
		0,
		Lang.get(99970),
		37017,
		4,
		1200,
		{
			RTResTalkAction[85]
		},
		nil,
		nil,
		3
	},
	[37017005] = {
		37017005,
		0,
		Lang.get(99971),
		37017,
		5,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37017006] = {
		37017006,
		0,
		Lang.get(99972),
		37017,
		6,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37017007] = {
		37017007,
		0,
		Lang.get(64810),
		37017,
		7,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37017008] = {
		37017008,
		0,
		Lang.get(99973),
		37017,
		8,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[101]
		},
		nil,
		nil,
		nil,
		2756
	},
	[37017009] = {
		37017009,
		0,
		Lang.get(99974),
		37017,
		9,
		1237,
		{
			RTResTalkAction[50],
			RTResTalkAction[79]
		}
	},
	[37017010] = {
		37017010,
		3,
		Lang.get(99975),
		37017,
		10,
		605,
		{
			RTResTalkAction[4],
			RTResTalkAction[84]
		},
		[22] = 1
	},
	[37017011] = {
		37017011,
		0,
		Lang.get(99976),
		37017,
		11,
		1237,
		{
			RTResTalkAction[14]
		}
	},
	[37017012] = {
		37017012,
		0,
		Lang.get(99977),
		37017,
		12,
		1200,
		{
			RTResTalkAction[2],
			RTResTalkAction[79]
		}
	},
	[37017013] = {
		37017013,
		0,
		Lang.get(99978),
		37017,
		13,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[79]
		}
	},
	[37017014] = {
		37017014,
		0,
		Lang.get(99979),
		37017,
		14,
		1200,
		{
			RTResTalkAction[73],
			RTResTalkAction[102]
		}
	},
	[37017015] = {
		37017015,
		0,
		Lang.get(99980),
		37017,
		15,
		1237,
		{
			RTResTalkAction[81],
			RTResTalkAction[103],
			RTResTalkAction[84]
		}
	},
	[37017016] = {
		37017016,
		0,
		Lang.get(99981),
		37017,
		16,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017017] = {
		37017017,
		0,
		Lang.get(99982),
		37017,
		17,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017018] = {
		37017018,
		0,
		Lang.get(99983),
		37017,
		18,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017019] = {
		37017019,
		0,
		Lang.get(99984),
		37017,
		19,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017020] = {
		37017020,
		0,
		Lang.get(99985),
		37017,
		20,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017021] = {
		37017021,
		0,
		Lang.get(99986),
		37017,
		21,
		1002,
		{
			RTResTalkAction[2],
			RTResTalkAction[103]
		}
	},
	[37017022] = {
		37017022,
		0,
		Lang.get(99987),
		37017,
		22,
		1237,
		{
			RTResTalkAction[104],
			RTResTalkAction[43]
		}
	},
	[37018001] = {
		37018001,
		0,
		Lang.get(99988),
		37018,
		1,
		1002,
		nil,
		1,
		nil,
		nil,
		2767,
		63,
		37180,
		nil,
		nil,
		nil,
		nil,
		nil,
		37180
	},
	[37018002] = {
		37018002,
		0,
		Lang.get(99989),
		37018,
		2,
		1200,
		nil,
		1
	},
	[37018003] = {
		37018003,
		3,
		Lang.get(99990),
		37018,
		3,
		605,
		[22] = 1
	},
	[37018004] = {
		37018004,
		0,
		Lang.get(99991),
		37018,
		4,
		1200,
		nil,
		1
	},
	[37018005] = {
		37018005,
		0,
		Lang.get(99992),
		37018,
		5,
		1200,
		nil,
		1
	},
	[37018006] = {
		37018006,
		0,
		Lang.get(99993),
		37018,
		6,
		1200,
		nil,
		1,
		nil,
		nil,
		2767
	},
	[37018007] = {
		37018007,
		0,
		Lang.get(99994),
		37018,
		7,
		1200,
		nil,
		1
	},
	[37018008] = {
		37018008,
		0,
		Lang.get(99995),
		37018,
		8,
		1237,
		nil,
		1,
		1
	},
	[37018009] = {
		37018009,
		0,
		Lang.get(99996),
		37018,
		9,
		1200,
		nil,
		1,
		0
	},
	[37018010] = {
		37018010,
		0,
		Lang.get(99997),
		37018,
		10,
		1237,
		nil,
		1,
		1,
		nil,
		2767
	},
	[37018011] = {
		37018011,
		0,
		Lang.get(99998),
		37018,
		11,
		1200,
		nil,
		1,
		0
	},
	[37018012] = {
		37018012,
		0,
		Lang.get(99999),
		37018,
		12,
		1237,
		nil,
		1,
		1
	},
	[37018013] = {
		37018013,
		0,
		Lang.get(100000),
		37018,
		13,
		1161,
		nil,
		1,
		0
	},
	[37018014] = {
		37018014,
		0,
		Lang.get(100001),
		37018,
		14,
		1200,
		nil,
		1
	},
	[37018015] = {
		37018015,
		0,
		Lang.get(100002),
		37018,
		15,
		1073,
		nil,
		1,
		nil,
		nil,
		2767
	},
	[37019001] = {
		37019001,
		0,
		Lang.get(100003),
		37019,
		1,
		1200,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		37190,
		nil,
		nil,
		nil,
		nil,
		nil,
		37190
	},
	[37019002] = {
		37019002,
		0,
		Lang.get(100004),
		37019,
		2,
		1073,
		nil,
		1
	},
	[37019003] = {
		37019003,
		0,
		Lang.get(100005),
		37019,
		3,
		1073,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[37019004] = {
		37019004,
		0,
		Lang.get(100006),
		37019,
		4,
		1200,
		{
			RTResTalkAction[78],
			RTResTalkAction[106]
		},
		nil,
		nil,
		nil,
		2747
	},
	[37191001] = {
		37191001,
		0,
		Lang.get(100007),
		37191,
		1,
		1200,
		nil,
		1,
		nil,
		nil,
		2763,
		164,
		37191,
		nil,
		nil,
		nil,
		nil,
		nil,
		37191
	},
	[37191002] = {
		37191002,
		0,
		Lang.get(100008),
		37191,
		2,
		1073,
		nil,
		1
	},
	[37191003] = {
		37191003,
		0,
		Lang.get(100009),
		37191,
		3,
		1073,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[37191004] = {
		37191004,
		0,
		Lang.get(100010),
		37191,
		4,
		1073,
		{
			RTResTalkAction[105]
		}
	},
	[37191005] = {
		37191005,
		0,
		Lang.get(100011),
		37191,
		5,
		1073,
		{
			RTResTalkAction[105]
		}
	},
	[37191006] = {
		37191006,
		0,
		Lang.get(100012),
		37191,
		6,
		1073,
		{
			RTResTalkAction[105]
		}
	},
	[37191007] = {
		37191007,
		0,
		Lang.get(100013),
		37191,
		7,
		1073,
		{
			RTResTalkAction[105]
		}
	},
	[37191008] = {
		37191008,
		0,
		Lang.get(100014),
		37191,
		8,
		1073,
		{
			RTResTalkAction[105]
		}
	},
	[37191009] = {
		37191009,
		0,
		Lang.get(18514),
		37191,
		9,
		1237,
		{
			RTResTalkAction[53],
			RTResTalkAction[106]
		}
	},
	[37191010] = {
		37191010,
		0,
		Lang.get(100015),
		37191,
		10,
		1200,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191011] = {
		37191011,
		0,
		Lang.get(100016),
		37191,
		11,
		1237,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191012] = {
		37191012,
		0,
		Lang.get(100017),
		37191,
		12,
		1200,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191013] = {
		37191013,
		0,
		Lang.get(100018),
		37191,
		13,
		1200,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191014] = {
		37191014,
		0,
		Lang.get(100019),
		37191,
		14,
		1200,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191015] = {
		37191015,
		0,
		Lang.get(18514),
		37191,
		15,
		1237,
		{
			RTResTalkAction[107],
			RTResTalkAction[79]
		}
	},
	[37191016] = {
		37191016,
		0,
		Lang.get(100020),
		37191,
		16,
		1073,
		{
			RTResTalkAction[107],
			RTResTalkAction[108],
			RTResTalkAction[84]
		}
	},
	[37191017] = {
		37191017,
		0,
		Lang.get(100021),
		37191,
		17,
		1200,
		{
			RTResTalkAction[109],
			RTResTalkAction[108],
			RTResTalkAction[4]
		}
	},
	[37191018] = {
		37191018,
		0,
		Lang.get(100022),
		37191,
		18,
		1237,
		{
			RTResTalkAction[9],
			RTResTalkAction[79],
			RTResTalkAction[106]
		}
	},
	[37191019] = {
		37191019,
		0,
		Lang.get(100023),
		37191,
		19,
		1073,
		{
			RTResTalkAction[2],
			RTResTalkAction[108],
			RTResTalkAction[84]
		}
	},
	[37191020] = {
		37191020,
		0,
		Lang.get(100024),
		37191,
		20,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[108]
		}
	},
	[37191021] = {
		37191021,
		0,
		Lang.get(100025),
		37191,
		21,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[108]
		}
	},
	[37191022] = {
		37191022,
		0,
		Lang.get(100026),
		37191,
		22,
		1237,
		{
			RTResTalkAction[69],
			RTResTalkAction[108]
		}
	},
	[37191023] = {
		37191023,
		0,
		Lang.get(100027),
		37191,
		23,
		1200,
		{
			RTResTalkAction[110],
			RTResTalkAction[4],
			RTResTalkAction[106]
		}
	},
	[37191024] = {
		37191024,
		0,
		Lang.get(100028),
		37191,
		24,
		1073,
		{
			RTResTalkAction[111],
			RTResTalkAction[84]
		}
	},
	[37020001] = {
		37020001,
		0,
		Lang.get(100029),
		37020,
		1,
		1237,
		nil,
		1,
		1,
		nil,
		nil,
		113,
		37200,
		nil,
		nil,
		nil,
		nil,
		nil,
		37200
	},
	[37020002] = {
		37020002,
		0,
		Lang.get(100030),
		37020,
		2,
		1243,
		nil,
		1,
		0
	},
	[37020003] = {
		37020003,
		0,
		Lang.get(100031),
		37020,
		3,
		1237,
		nil,
		1,
		1
	},
	[37020004] = {
		37020004,
		0,
		Lang.get(100032),
		37020,
		4,
		1243,
		nil,
		1,
		0
	},
	[37020005] = {
		37020005,
		0,
		Lang.get(100033),
		37020,
		5,
		1237,
		nil,
		1,
		1
	},
	[37020006] = {
		37020006,
		0,
		Lang.get(100034),
		37020,
		6,
		1237,
		nil,
		1,
		1
	},
	[37020007] = {
		37020007,
		0,
		Lang.get(100035),
		37020,
		7,
		1237,
		nil,
		1,
		1
	},
	[37020008] = {
		37020008,
		0,
		Lang.get(100036),
		37020,
		8,
		1243,
		nil,
		1,
		0
	},
	[37020009] = {
		37020009,
		0,
		Lang.get(100037),
		37020,
		9,
		1237,
		nil,
		1,
		1
	},
	[37020010] = {
		37020010,
		0,
		Lang.get(100038),
		37020,
		10,
		1237,
		nil,
		1,
		1
	},
	[37020011] = {
		37020011,
		0,
		Lang.get(100039),
		37020,
		11,
		1243,
		nil,
		1,
		0
	},
	[37020012] = {
		37020012,
		0,
		Lang.get(100040),
		37020,
		12,
		1243,
		nil,
		1
	},
	[37020013] = {
		37020013,
		0,
		Lang.get(100041),
		37020,
		13,
		1243,
		nil,
		1
	},
	[37201001] = {
		37201001,
		0,
		Lang.get(100042),
		37201,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		37201,
		nil,
		nil,
		nil,
		nil,
		nil,
		37201
	},
	[37201002] = {
		37201002,
		0,
		Lang.get(100043),
		37201,
		2,
		1142,
		nil,
		1
	},
	[37201003] = {
		37201003,
		0,
		Lang.get(100044),
		37201,
		3,
		1237,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[37201004] = {
		37201004,
		0,
		Lang.get(100045),
		37201,
		4,
		1117,
		{
			RTResTalkAction[81],
			RTResTalkAction[74]
		}
	},
	[37201005] = {
		37201005,
		0,
		Lang.get(100046),
		37201,
		5,
		1237,
		{
			RTResTalkAction[73],
			RTResTalkAction[49]
		}
	},
	[37201006] = {
		37201006,
		0,
		Lang.get(100047),
		37201,
		6,
		1112,
		{
			RTResTalkAction[112],
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[37201007] = {
		37201007,
		0,
		Lang.get(100048),
		37201,
		7,
		1242,
		{
			RTResTalkAction[61],
			RTResTalkAction[25]
		}
	},
	[37201008] = {
		37201008,
		0,
		Lang.get(100049),
		37201,
		8,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[63]
		}
	},
	[37201009] = {
		37201009,
		0,
		Lang.get(100050),
		37201,
		9,
		1117,
		{
			RTResTalkAction[2],
			RTResTalkAction[49]
		}
	},
	[37202001] = {
		37202001,
		3,
		Lang.get(85710),
		37202,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		37202,
		[19] = 37202,
		[22] = 1
	},
	[37202002] = {
		37202002,
		0,
		Lang.get(100051),
		37202,
		2,
		1237,
		nil,
		1
	},
	[37202003] = {
		37202003,
		0,
		Lang.get(100052),
		37202,
		3,
		1142,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[37202004] = {
		37202004,
		0,
		Lang.get(100053),
		37202,
		4,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[113]
		}
	},
	[37202005] = {
		37202005,
		0,
		Lang.get(38114),
		37202,
		5,
		1142,
		{
			RTResTalkAction[2],
			RTResTalkAction[113]
		}
	},
	[37202006] = {
		37202006,
		0,
		Lang.get(100054),
		37202,
		6,
		1237,
		{
			RTResTalkAction[2],
			RTResTalkAction[113]
		}
	},
	[37202007] = {
		37202007,
		0,
		Lang.get(100055),
		37202,
		7,
		1142,
		{
			RTResTalkAction[2],
			RTResTalkAction[113]
		}
	},
	[37202008] = {
		37202008,
		0,
		Lang.get(100056),
		37202,
		8,
		1237,
		{
			RTResTalkAction[73],
			RTResTalkAction[113]
		}
	},
	[37202009] = {
		37202009,
		0,
		Lang.get(100057),
		37202,
		9,
		1142,
		{
			RTResTalkAction[73],
			RTResTalkAction[113]
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
