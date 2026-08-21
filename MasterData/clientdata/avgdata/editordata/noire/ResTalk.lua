-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\noire\\ResTalk.lua

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
	1278,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1278
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1278
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 192
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 192
}
RTResTalkAction[6] = {
	1,
	1279,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1279
}
RTResTalkAction[8] = {
	1,
	192,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1279
}
RTResTalkAction[10] = {
	1,
	1279,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1276
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1276
}
RTResTalkAction[13] = {
	1,
	1276,
	nil,
	nil,
	1
}
RTResTalkAction[14] = {
	1,
	1276,
	nil,
	nil,
	2
}
RTResTalkAction[15] = {
	1,
	1276,
	nil,
	nil,
	0
}
RTResTalkAction[16] = {
	1,
	1276,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 432
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1278,
	[3] = {
		3
	}
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 432
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1276,
	[3] = {
		2
	}
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 1278
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 1276
}
RTResTalkAction[23] = {
	3,
	1276,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	3,
	1276,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	3,
	1276,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[26] = {
	3,
	1276,
	nil,
	nil,
	3
}
RTResTalkAction[27] = {
	1,
	1276,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1281
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 1281
}
RTResTalkAction[30] = {
	1,
	1286,
	nil,
	nil,
	0
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 1286
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 1287
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 1286
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 1287
}
RTResTalkAction[35] = {
	3,
	1276,
	nil,
	nil,
	2
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 1280
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 1280
}
RTResTalkAction[38] = {
	[1] = 2,
	[2] = 1281
}
RTResTalkAction[39] = {
	[1] = 3,
	[2] = 1287
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 1286
}
RTResTalkAction[41] = {
	1,
	1276,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[42] = {
	1,
	1276,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[43] = {
	2,
	1278,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 677
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 677
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 677
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 1088
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 1088
}
RTResTalkAction[49] = {
	[1] = 2,
	[2] = 1284
}
RTResTalkAction[50] = {
	[1] = 3,
	[2] = 1285
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1284
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 1285
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 1284
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1285
}
RTResTalkAction[55] = {
	3,
	1276,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1276,
	[3] = {
		1
	}
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1278,
	[3] = {
		1
	}
}
RTResTalkAction[58] = {
	[1] = 4,
	[2] = 20
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 39
}
RTResTalkAction[60] = {
	[1] = 5,
	[2] = 48
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 829
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 39
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 48
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 829
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[68] = {
	[1] = 4,
	[2] = 254
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 1002
}
RTResTalkAction[70] = {
	[1] = 5,
	[2] = 1060
}
RTResTalkAction[71] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 254
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 1002
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 1060
}
RTResTalkAction[75] = {
	1,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[76] = {
	1,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[77] = {
	1,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[78] = {
	1,
	1122,
	nil,
	nil,
	0
}
RTResTalkAction[79] = {
	[1] = 2,
	[2] = 1122
}
RTResTalkAction[80] = {
	3,
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[81] = {
	[1] = 3,
	[2] = 1237
}
RTResTalkAction[82] = {
	3,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 431
}
RTResTalkAction[84] = {
	[1] = 0,
	[2] = 1122
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 1237
}
RTResTalkAction[86] = {
	1,
	226,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[87] = {
	[1] = 0,
	[2] = 226
}
RTResTalkAction[88] = {
	1,
	226,
	nil,
	nil,
	0
}
RTResTalkAction[89] = {
	1,
	226,
	nil,
	nil,
	1
}
RTResTalkAction[90] = {
	[1] = 2,
	[2] = 226
}
RTResTalkAction[91] = {
	2,
	226,
	nil,
	nil,
	0
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 226
}
RTResTalkAction[93] = {
	1,
	1276,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[94] = {
	1,
	226,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 1282
}
RTResTalkAction[96] = {
	[1] = 2,
	[2] = 1282
}
RTResTalkAction[97] = {
	[1] = 3,
	[2] = 126
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 126
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 1282
}
RTResTalkAction[100] = {
	2,
	1278,
	nil,
	nil,
	0
}
RTResTalkAction[101] = {
	3,
	1276,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[102] = {
	1,
	127,
	nil,
	nil,
	0
}
RTResTalkAction[103] = {
	[1] = 0,
	[2] = 127
}
RTResTalkAction[104] = {
	1,
	1276,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[106] = {
	1,
	1195,
	nil,
	nil,
	3
}
RTResTalkAction[107] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[108] = {
	1,
	1118,
	nil,
	nil,
	0
}
RTResTalkAction[109] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[110] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[111] = {
	1,
	1118,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[112] = {
	1,
	167,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[113] = {
	[1] = 0,
	[2] = 167
}
RTResTalkAction[114] = {
	1,
	1118,
	nil,
	nil,
	5
}
RTResTalkAction[115] = {
	1,
	167,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[116] = {
	2,
	1118,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[117] = {
	1,
	1195,
	nil,
	nil,
	2
}
RTResTalkAction[118] = {
	1,
	1118,
	nil,
	nil,
	3
}
RTResTalkAction[119] = {
	2,
	1118,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[120] = {
	1,
	1195,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[121] = {
	1,
	1118,
	nil,
	nil,
	2
}
RTResTalkAction[122] = {
	1,
	1278,
	nil,
	nil,
	0
}
RTResTalkAction[123] = {
	[1] = 1,
	[2] = 770
}
RTResTalkAction[124] = {
	[1] = 0,
	[2] = 770
}
RTResTalkAction[125] = {
	[1] = 2,
	[2] = 1276
}
RTResTalkAction[126] = {
	3,
	770,
	nil,
	nil,
	1
}
RTResTalkAction[127] = {
	[1] = 3,
	[2] = 770
}
RTResTalkAction[128] = {
	3,
	770,
	nil,
	nil,
	0
}
RTResTalkAction[129] = {
	2,
	1276,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[130] = {
	[1] = 3,
	[2] = 770,
	[3] = {
		1
	}
}
RTResTalkAction[131] = {
	2,
	1276,
	nil,
	nil,
	0
}
RTResTalkAction[132] = {
	[1] = 2,
	[2] = 1276,
	[3] = {
		3
	}
}
RTResTalkAction[133] = {
	2,
	1276,
	nil,
	nil,
	2
}
RTResTalkAction[134] = {
	2,
	1276,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[135] = {
	1,
	1118,
	nil,
	nil,
	1
}
RTResTalkAction[136] = {
	1,
	677,
	nil,
	nil,
	0
}
RTResTalkAction[137] = {
	[1] = 1,
	[2] = 677,
	[3] = {
		2
	}
}
RTResTalkAction[138] = {
	1,
	1281,
	nil,
	nil,
	0
}
RTResTalkAction[139] = {
	1,
	1278,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[140] = {
	[1] = 1,
	[2] = 1118,
	[3] = {
		2
	}
}
RTResTalkAction[141] = {
	[1] = 3,
	[2] = 1118
}
RTResTalkAction[142] = {
	3,
	1118,
	nil,
	nil,
	3
}
RTResTalkAction[143] = {
	3,
	770,
	{
		0
	},
	nil,
	1
}
RTResTalkAction[144] = {
	2,
	1276,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[145] = {
	3,
	770,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[146] = {
	1,
	1276,
	nil,
	nil,
	5
}
RTResTalkAction[147] = {
	1,
	770,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[148] = {
	1,
	1276,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[149] = {
	2,
	1276,
	nil,
	nil,
	5
}
RTResTalkAction[150] = {
	1,
	770,
	nil,
	nil,
	1
}
RTResTalkAction[151] = {
	1,
	770,
	nil,
	nil,
	0
}
RTResTalkAction[152] = {
	1,
	1276,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[153] = {
	[1] = 1,
	[2] = 770,
	[3] = {
		3
	}
}
RTResTalkAction[154] = {
	1,
	1276,
	nil,
	nil,
	4
}
RTResTalkAction[155] = {
	[1] = 1,
	[2] = 770,
	[3] = {
		2
	}
}
RTResTalkAction[156] = {
	1,
	770,
	{
		0
	},
	nil,
	1
}
RTResTalkAction[157] = {
	1,
	770,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[158] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[159] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[160] = {
	1,
	158,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[161] = {
	[1] = 0,
	[2] = 158
}

local Data = {
	[40601001] = {
		40601001,
		9,
		Lang.get(108338),
		40601,
		1,
		605,
		nil,
		nil,
		3,
		nil,
		nil,
		194,
		40601,
		nil,
		nil,
		nil,
		nil,
		nil,
		40601,
		255,
		nil,
		1
	},
	[40601002] = {
		40601002,
		9,
		Lang.get(108339),
		40601,
		2,
		605,
		[22] = 1
	},
	[40601003] = {
		40601003,
		5,
		Lang.get(108340),
		40601,
		3,
		1278,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		57,
		[20] = -1
	},
	[40601004] = {
		40601004,
		3,
		Lang.get(108341),
		40601,
		4,
		605,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		1230,
		[22] = 1
	},
	[40601005] = {
		40601005,
		0,
		Lang.get(108342),
		40601,
		5,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40601006] = {
		40601006,
		0,
		Lang.get(108343),
		40601,
		6,
		192,
		{
			RTResTalkAction[4],
			RTResTalkAction[2]
		}
	},
	[40601007] = {
		40601007,
		4,
		nil,
		40601,
		7,
		1278,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 40601008,
				branch_content = Lang.get(108344)
			},
			{
				id = 40601008,
				branch_content = Lang.get(108345)
			}
		}
	},
	[40601008] = {
		40601008,
		0,
		Lang.get(108346),
		40601,
		8,
		192,
		{
			RTResTalkAction[4]
		}
	},
	[40601009] = {
		40601009,
		4,
		nil,
		40601,
		9,
		1278,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 40601010,
				branch_content = Lang.get(108347)
			},
			{
				id = 40601010,
				branch_content = Lang.get(108348)
			}
		}
	},
	[40601010] = {
		40601010,
		0,
		Lang.get(108349),
		40601,
		10,
		192,
		{
			RTResTalkAction[4]
		}
	},
	[40601011] = {
		40601011,
		0,
		Lang.get(108350),
		40601,
		11,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[40601012] = {
		40601012,
		3,
		Lang.get(108351),
		40601,
		12,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1,
		[20] = 255
	},
	[40601013] = {
		40601013,
		5,
		Lang.get(108352),
		40601,
		13,
		605,
		nil,
		nil,
		nil,
		nil,
		2747,
		158,
		[22] = 1
	},
	[40601014] = {
		40601014,
		5,
		"！！！",
		40601,
		14,
		192,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		40602,
		1,
		1,
		nil,
		nil,
		nil,
		40602,
		-1
	},
	[40601015] = {
		40601015,
		0,
		Lang.get(108353),
		40601,
		15,
		1279,
		nil,
		1,
		1,
		-1,
		nil,
		nil,
		nil,
		1
	},
	[40601016] = {
		40601016,
		3,
		Lang.get(108354),
		40601,
		16,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40604,
		1,
		nil,
		nil,
		1,
		nil,
		40604,
		nil,
		nil,
		1
	},
	[40601017] = {
		40601017,
		0,
		Lang.get(108355),
		40601,
		17,
		1278,
		nil,
		1,
		0
	},
	[40601018] = {
		40601018,
		0,
		Lang.get(108356),
		40601,
		18,
		192,
		nil,
		1,
		0
	},
	[40601019] = {
		40601019,
		0,
		Lang.get(24723),
		40601,
		19,
		1279,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[40601020] = {
		40601020,
		0,
		Lang.get(108357),
		40601,
		20,
		1279,
		{
			RTResTalkAction[7]
		}
	},
	[40601021] = {
		40601021,
		0,
		Lang.get(108358),
		40601,
		21,
		192,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[40800001] = {
		40800001,
		3,
		Lang.get(108359),
		40800,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		40603,
		[19] = 40603,
		[22] = 1
	},
	[40800002] = {
		40800002,
		0,
		Lang.get(108360),
		40800,
		2,
		1279,
		nil,
		1,
		0
	},
	[40800003] = {
		40800003,
		3,
		Lang.get(108361),
		40800,
		3,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3,
		[21] = 1279,
		[22] = 1
	},
	[40800004] = {
		40800004,
		0,
		Lang.get(108362),
		40800,
		4,
		1278,
		{
			RTResTalkAction[9]
		},
		1,
		0
	},
	[40800005] = {
		40800005,
		0,
		Lang.get(60207),
		40800,
		5,
		1279,
		{
			RTResTalkAction[7]
		}
	},
	[40800006] = {
		40800006,
		0,
		Lang.get(108363),
		40800,
		6,
		1278,
		{
			RTResTalkAction[7]
		},
		1,
		0
	},
	[40800007] = {
		40800007,
		0,
		Lang.get(108364),
		40800,
		7,
		1279,
		{
			RTResTalkAction[7]
		}
	},
	[40800008] = {
		40800008,
		0,
		Lang.get(108365),
		40800,
		8,
		1278,
		{
			RTResTalkAction[7]
		},
		1,
		0
	},
	[40800009] = {
		40800009,
		0,
		Lang.get(108366),
		40800,
		9,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[9]
		}
	},
	[40800010] = {
		40800010,
		7,
		"119",
		40800,
		10,
		1276,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[40800011] = {
		40800011,
		4,
		nil,
		40800,
		11,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40800012,
				branch_content = Lang.get(108367)
			},
			{
				id = 40800012,
				branch_content = Lang.get(108368)
			}
		}
	},
	[40800012] = {
		40800012,
		0,
		Lang.get(108369),
		40800,
		12,
		1276,
		{
			RTResTalkAction[13]
		}
	},
	[40800013] = {
		40800013,
		0,
		Lang.get(18451),
		40800,
		13,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[40800014] = {
		40800014,
		0,
		Lang.get(108370),
		40800,
		14,
		1276,
		{
			RTResTalkAction[14]
		}
	},
	[40800015] = {
		40800015,
		0,
		Lang.get(108371),
		40800,
		15,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[40800016] = {
		40800016,
		0,
		Lang.get(108372),
		40800,
		16,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40800017] = {
		40800017,
		0,
		Lang.get(108373),
		40800,
		17,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[40800018] = {
		40800018,
		0,
		Lang.get(108374),
		40800,
		18,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40800019] = {
		40800019,
		0,
		Lang.get(108375),
		40800,
		19,
		1276,
		{
			RTResTalkAction[16]
		}
	},
	[40800020] = {
		40800020,
		4,
		nil,
		40800,
		20,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40800021,
				branch_content = Lang.get(108376)
			},
			{
				id = 40800021,
				branch_content = Lang.get(108377)
			}
		}
	},
	[40800021] = {
		40800021,
		0,
		Lang.get(108378),
		40800,
		21,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40800022] = {
		40800022,
		0,
		Lang.get(108379),
		40800,
		22,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40800023] = {
		40800023,
		4,
		nil,
		40800,
		23,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40800024,
				branch_content = Lang.get(24462)
			},
			{
				id = 40800024,
				branch_content = Lang.get(108380)
			}
		}
	},
	[40800024] = {
		40800024,
		0,
		Lang.get(108381),
		40800,
		24,
		1276,
		{
			RTResTalkAction[13]
		}
	},
	[40800025] = {
		40800025,
		3,
		Lang.get(108382),
		40800,
		25,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1,
		[20] = 200
	},
	[40602001] = {
		40602001,
		3,
		Lang.get(108383),
		40602,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		14,
		40605,
		[19] = 40605,
		[22] = 1
	},
	[40602002] = {
		40602002,
		0,
		"……",
		40602,
		2,
		1276,
		nil,
		1,
		0
	},
	[40602003] = {
		40602003,
		3,
		Lang.get(108384),
		40602,
		3,
		605,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		2762,
		[21] = 432,
		[22] = 1
	},
	[40602004] = {
		40602004,
		0,
		Lang.get(108385),
		40602,
		4,
		1278,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40602005] = {
		40602005,
		3,
		Lang.get(108386),
		40602,
		5,
		605,
		{
			RTResTalkAction[17]
		},
		[21] = 432,
		[22] = 1
	},
	[40602006] = {
		40602006,
		0,
		Lang.get(108387),
		40602,
		6,
		1278,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40602007] = {
		40602007,
		0,
		Lang.get(108388),
		40602,
		7,
		1278,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40602008] = {
		40602008,
		0,
		Lang.get(22477),
		40602,
		8,
		1276,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40602009] = {
		40602009,
		5,
		Lang.get(108389),
		40602,
		9,
		1278,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[40602010] = {
		40602010,
		3,
		Lang.get(108390),
		40602,
		10,
		605,
		{
			RTResTalkAction[20],
			RTResTalkAction[2]
		},
		[21] = 1279,
		[22] = 1
	},
	[40602011] = {
		40602011,
		0,
		Lang.get(108391),
		40602,
		11,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602012] = {
		40602012,
		0,
		Lang.get(108392),
		40602,
		12,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40602013] = {
		40602013,
		0,
		Lang.get(108393),
		40602,
		13,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40602014] = {
		40602014,
		0,
		Lang.get(108394),
		40602,
		14,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		5004
	},
	[40602015] = {
		40602015,
		0,
		Lang.get(108395),
		40602,
		15,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602016] = {
		40602016,
		0,
		Lang.get(108396),
		40602,
		16,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602017] = {
		40602017,
		0,
		Lang.get(108397),
		40602,
		17,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602018] = {
		40602018,
		0,
		Lang.get(108398),
		40602,
		18,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		}
	},
	[40602019] = {
		40602019,
		0,
		Lang.get(108399),
		40602,
		19,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602020] = {
		40602020,
		3,
		Lang.get(108400),
		40602,
		20,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40602021] = {
		40602021,
		0,
		Lang.get(108401),
		40602,
		21,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40602022] = {
		40602022,
		0,
		Lang.get(108402),
		40602,
		22,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		}
	},
	[40602023] = {
		40602023,
		0,
		Lang.get(108403),
		40602,
		23,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602024] = {
		40602024,
		0,
		Lang.get(108404),
		40602,
		24,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40602025] = {
		40602025,
		0,
		Lang.get(108405),
		40602,
		25,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602026] = {
		40602026,
		0,
		Lang.get(66037),
		40602,
		26,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[25]
		}
	},
	[40602027] = {
		40602027,
		0,
		Lang.get(108406),
		40602,
		27,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602028] = {
		40602028,
		0,
		Lang.get(108407),
		40602,
		28,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[26]
		}
	},
	[40602029] = {
		40602029,
		0,
		Lang.get(108408),
		40602,
		29,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40602030] = {
		40602030,
		3,
		Lang.get(108409),
		40602,
		30,
		605,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[40602031] = {
		40602031,
		0,
		Lang.get(108410),
		40602,
		31,
		1276,
		{
			RTResTalkAction[27],
			RTResTalkAction[2]
		}
	},
	[40602032] = {
		40602032,
		4,
		nil,
		40602,
		32,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40602033,
				branch_content = Lang.get(108411)
			},
			{
				id = 40602033,
				branch_content = Lang.get(108412)
			}
		}
	},
	[40602033] = {
		40602033,
		0,
		Lang.get(108413),
		40602,
		33,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602034] = {
		40602034,
		0,
		Lang.get(108414),
		40602,
		34,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602035] = {
		40602035,
		0,
		Lang.get(108415),
		40602,
		35,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602036] = {
		40602036,
		4,
		nil,
		40602,
		36,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40602037,
				branch_content = Lang.get(108416)
			},
			{
				id = 40602037,
				branch_content = Lang.get(108417)
			}
		}
	},
	[40602037] = {
		40602037,
		0,
		Lang.get(108418),
		40602,
		37,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602038] = {
		40602038,
		0,
		Lang.get(108419),
		40602,
		38,
		1276,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[40602039] = {
		40602039,
		0,
		Lang.get(108420),
		40602,
		39,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[40602040] = {
		40602040,
		0,
		Lang.get(108421),
		40602,
		40,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40602041] = {
		40602041,
		0,
		Lang.get(108422),
		40602,
		41,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[40602042] = {
		40602042,
		0,
		Lang.get(108423),
		40602,
		42,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40602043] = {
		40602043,
		3,
		Lang.get(108424),
		40602,
		43,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1,
		[20] = 200
	},
	[40603001] = {
		40603001,
		3,
		Lang.get(108425),
		40603,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		40610,
		[19] = 40610,
		[22] = 1
	},
	[40603002] = {
		40603002,
		0,
		Lang.get(108426),
		40603,
		2,
		1276,
		nil,
		1,
		0
	},
	[40603003] = {
		40603003,
		4,
		nil,
		40603,
		3,
		1278,
		nil,
		1,
		[29] = {
			{
				id = 40603004,
				branch_content = Lang.get(108427)
			},
			{
				id = 40603004,
				branch_content = Lang.get(108428)
			}
		}
	},
	[40603004] = {
		40603004,
		0,
		Lang.get(108429),
		40603,
		4,
		1276,
		nil,
		1,
		0
	},
	[40603005] = {
		40603005,
		0,
		Lang.get(108430),
		40603,
		5,
		1278,
		nil,
		1
	},
	[40603006] = {
		40603006,
		0,
		Lang.get(108431),
		40603,
		6,
		1276,
		nil,
		1
	},
	[40603007] = {
		40603007,
		3,
		Lang.get(108432),
		40603,
		7,
		605,
		[22] = 1
	},
	[40603008] = {
		40603008,
		0,
		Lang.get(108433),
		40603,
		8,
		1278,
		nil,
		1
	},
	[40603009] = {
		40603009,
		0,
		Lang.get(108434),
		40603,
		9,
		1276,
		nil,
		1
	},
	[40603010] = {
		40603010,
		0,
		Lang.get(108435),
		40603,
		10,
		1278,
		nil,
		1
	},
	[40603011] = {
		40603011,
		0,
		Lang.get(108436),
		40603,
		11,
		1276,
		nil,
		1,
		0
	},
	[40603012] = {
		40603012,
		0,
		Lang.get(108437),
		40603,
		12,
		1278,
		nil,
		1
	},
	[40603013] = {
		40603013,
		0,
		Lang.get(108438),
		40603,
		13,
		1276,
		nil,
		1,
		1
	},
	[40603014] = {
		40603014,
		0,
		Lang.get(108439),
		40603,
		14,
		1276,
		nil,
		1,
		0
	},
	[40603015] = {
		40603015,
		3,
		Lang.get(108440),
		40603,
		15,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		40611,
		[19] = 40611,
		[22] = 1
	},
	[40603016] = {
		40603016,
		0,
		Lang.get(108441),
		40603,
		16,
		1276,
		nil,
		1,
		0
	},
	[40603017] = {
		40603017,
		0,
		Lang.get(108442),
		40603,
		17,
		1278,
		nil,
		1,
		0
	},
	[40603018] = {
		40603018,
		0,
		Lang.get(108443),
		40603,
		18,
		1276,
		nil,
		1,
		0
	},
	[40603019] = {
		40603019,
		0,
		Lang.get(108444),
		40603,
		19,
		1278,
		nil,
		1,
		0
	},
	[40603020] = {
		40603020,
		0,
		Lang.get(108445),
		40603,
		20,
		1276,
		nil,
		1,
		0
	},
	[40603021] = {
		40603021,
		4,
		nil,
		40603,
		21,
		1278,
		nil,
		1,
		0,
		[29] = {
			{
				id = 40603022,
				branch_content = Lang.get(108446)
			},
			{
				id = 40603022,
				branch_content = Lang.get(108447)
			}
		}
	},
	[40603022] = {
		40603022,
		0,
		Lang.get(108448),
		40603,
		22,
		1276,
		nil,
		1,
		0
	},
	[40603023] = {
		40603023,
		0,
		Lang.get(108449),
		40603,
		23,
		1278,
		nil,
		1,
		0
	},
	[40603024] = {
		40603024,
		3,
		Lang.get(89585),
		40603,
		24,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40612,
		1,
		1,
		nil,
		1,
		nil,
		40612,
		nil,
		nil,
		1
	},
	[40603025] = {
		40603025,
		0,
		Lang.get(108450),
		40603,
		25,
		1278,
		nil,
		1,
		0
	},
	[40603026] = {
		40603026,
		0,
		Lang.get(108451),
		40603,
		26,
		1276,
		nil,
		1
	},
	[40603027] = {
		40603027,
		0,
		Lang.get(108452),
		40603,
		27,
		1278,
		nil,
		1
	},
	[40603028] = {
		40603028,
		0,
		Lang.get(108453),
		40603,
		28,
		1276,
		nil,
		1
	},
	[40603029] = {
		40603029,
		0,
		Lang.get(108454),
		40603,
		29,
		1278,
		nil,
		1
	},
	[40603030] = {
		40603030,
		0,
		Lang.get(108455),
		40603,
		30,
		1281,
		nil,
		1,
		0
	},
	[40603031] = {
		40603031,
		0,
		Lang.get(108456),
		40603,
		31,
		1286,
		nil,
		1,
		0
	},
	[40603032] = {
		40603032,
		0,
		Lang.get(108457),
		40603,
		32,
		1281,
		nil,
		1,
		0
	},
	[40603033] = {
		40603033,
		0,
		Lang.get(108458),
		40603,
		33,
		1278,
		nil,
		1
	},
	[40603034] = {
		40603034,
		0,
		Lang.get(108459),
		40603,
		34,
		1276,
		nil,
		1,
		0
	},
	[40604001] = {
		40604001,
		3,
		Lang.get(93196),
		40604,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		183,
		40615,
		[19] = 40615,
		[22] = 1
	},
	[40604002] = {
		40604002,
		3,
		Lang.get(108460),
		40604,
		2,
		605,
		[22] = 1
	},
	[40604003] = {
		40604003,
		0,
		Lang.get(108461),
		40604,
		3,
		1281,
		nil,
		1,
		0
	},
	[40604004] = {
		40604004,
		0,
		Lang.get(108462),
		40604,
		4,
		1281,
		nil,
		1,
		0
	},
	[40604005] = {
		40604005,
		0,
		Lang.get(108463),
		40604,
		5,
		1281,
		nil,
		1,
		0
	},
	[40604006] = {
		40604006,
		0,
		Lang.get(108464),
		40604,
		6,
		1281,
		nil,
		1,
		0
	},
	[40604007] = {
		40604007,
		0,
		Lang.get(108465),
		40604,
		7,
		1278,
		nil,
		1,
		0
	},
	[40604008] = {
		40604008,
		0,
		Lang.get(108466),
		40604,
		8,
		1276,
		nil,
		1,
		0
	},
	[40604009] = {
		40604009,
		0,
		Lang.get(108467),
		40604,
		9,
		1281,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[40604010] = {
		40604010,
		0,
		Lang.get(108468),
		40604,
		10,
		1281,
		{
			RTResTalkAction[28]
		}
	},
	[40604011] = {
		40604011,
		0,
		Lang.get(108469),
		40604,
		11,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[29]
		}
	},
	[40604012] = {
		40604012,
		4,
		nil,
		40604,
		12,
		1278,
		{
			RTResTalkAction[12]
		},
		[29] = {
			{
				id = 40604013,
				branch_content = Lang.get(108470)
			},
			{
				id = 40604013,
				branch_content = Lang.get(108471)
			}
		}
	},
	[40604013] = {
		40604013,
		0,
		Lang.get(108472),
		40604,
		13,
		1286,
		{
			RTResTalkAction[30]
		}
	},
	[40604014] = {
		40604014,
		0,
		Lang.get(108473),
		40604,
		14,
		1286,
		{
			RTResTalkAction[31]
		}
	},
	[40604015] = {
		40604015,
		0,
		Lang.get(108474),
		40604,
		15,
		1287,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[40604016] = {
		40604016,
		0,
		Lang.get(108475),
		40604,
		16,
		1287,
		{
			RTResTalkAction[32]
		}
	},
	[40604017] = {
		40604017,
		0,
		Lang.get(108476),
		40604,
		17,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[34]
		}
	},
	[40604018] = {
		40604018,
		0,
		Lang.get(108477),
		40604,
		18,
		1287,
		{
			RTResTalkAction[32],
			RTResTalkAction[12]
		}
	},
	[40604019] = {
		40604019,
		0,
		Lang.get(108478),
		40604,
		19,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[34]
		}
	},
	[40604020] = {
		40604020,
		0,
		Lang.get(108479),
		40604,
		20,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[35]
		}
	},
	[40604021] = {
		40604021,
		0,
		Lang.get(108480),
		40604,
		21,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40604022] = {
		40604022,
		0,
		Lang.get(108481),
		40604,
		22,
		1281,
		{
			RTResTalkAction[28],
			RTResTalkAction[2],
			RTResTalkAction[12]
		}
	},
	[40604023] = {
		40604023,
		0,
		Lang.get(108482),
		40604,
		23,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[29]
		}
	},
	[40604024] = {
		40604024,
		3,
		Lang.get(108483),
		40604,
		24,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		2751,
		[22] = 1
	},
	[40604025] = {
		40604025,
		0,
		Lang.get(108484),
		40604,
		25,
		1280,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[40604026] = {
		40604026,
		3,
		Lang.get(108485),
		40604,
		26,
		605,
		{
			RTResTalkAction[36]
		},
		[22] = 1
	},
	[40604027] = {
		40604027,
		0,
		Lang.get(108486),
		40604,
		27,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[37]
		}
	},
	[40604028] = {
		40604028,
		0,
		Lang.get(108487),
		40604,
		28,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40604029] = {
		40604029,
		3,
		Lang.get(108488),
		40604,
		29,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40604030] = {
		40604030,
		0,
		Lang.get(108489),
		40604,
		30,
		1281,
		{
			RTResTalkAction[28]
		}
	},
	[40604031] = {
		40604031,
		0,
		Lang.get(108490),
		40604,
		31,
		1280,
		{
			RTResTalkAction[36],
			RTResTalkAction[29]
		}
	},
	[40604032] = {
		40604032,
		5,
		"！！！",
		40604,
		32,
		1278,
		{
			RTResTalkAction[18],
			RTResTalkAction[37]
		}
	},
	[40604033] = {
		40604033,
		3,
		Lang.get(108491),
		40604,
		33,
		605,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		},
		[21] = 1279,
		[22] = 1
	},
	[40604034] = {
		40604034,
		0,
		Lang.get(108492),
		40604,
		34,
		1280,
		{
			RTResTalkAction[36],
			RTResTalkAction[12]
		}
	},
	[40604035] = {
		40604035,
		0,
		Lang.get(108493),
		40604,
		35,
		1280,
		{
			RTResTalkAction[36]
		}
	},
	[40604036] = {
		40604036,
		0,
		Lang.get(108494),
		40604,
		36,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[37]
		}
	},
	[40604037] = {
		40604037,
		0,
		Lang.get(108495),
		40604,
		37,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40604038] = {
		40604038,
		0,
		Lang.get(108496),
		40604,
		38,
		1281,
		{
			RTResTalkAction[28],
			RTResTalkAction[2],
			RTResTalkAction[12]
		}
	},
	[40604039] = {
		40604039,
		0,
		Lang.get(108497),
		40604,
		39,
		1281,
		{
			RTResTalkAction[28]
		}
	},
	[40604040] = {
		40604040,
		0,
		Lang.get(108498),
		40604,
		40,
		1278,
		{
			RTResTalkAction[29]
		},
		1
	},
	[40604041] = {
		40604041,
		4,
		nil,
		40604,
		41,
		1278,
		[29] = {
			{
				id = 40604042,
				branch_content = Lang.get(108499)
			},
			{
				id = 40604042,
				branch_content = Lang.get(108500)
			}
		}
	},
	[40604042] = {
		40604042,
		0,
		Lang.get(108501),
		40604,
		42,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40604043] = {
		40604043,
		0,
		Lang.get(107830),
		40604,
		43,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40604044] = {
		40604044,
		0,
		Lang.get(108502),
		40604,
		44,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40604045] = {
		40604045,
		3,
		Lang.get(108503),
		40604,
		45,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40605001] = {
		40605001,
		3,
		Lang.get(108504),
		40605,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		122,
		40620,
		nil,
		nil,
		nil,
		nil,
		nil,
		40620,
		nil,
		nil,
		1
	},
	[40605002] = {
		40605002,
		0,
		Lang.get(108505),
		40605,
		2,
		1287,
		{
			RTResTalkAction[32]
		}
	},
	[40605003] = {
		40605003,
		0,
		Lang.get(108506),
		40605,
		3,
		1281,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		}
	},
	[40605004] = {
		40605004,
		3,
		Lang.get(108507),
		40605,
		4,
		605,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		},
		[22] = 1
	},
	[40605005] = {
		40605005,
		0,
		Lang.get(108508),
		40605,
		5,
		1287,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		}
	},
	[40605006] = {
		40605006,
		0,
		Lang.get(108509),
		40605,
		6,
		1281,
		{
			RTResTalkAction[28],
			RTResTalkAction[34]
		}
	},
	[40605007] = {
		40605007,
		0,
		Lang.get(108510),
		40605,
		7,
		1286,
		{
			RTResTalkAction[38],
			RTResTalkAction[40]
		}
	},
	[40605008] = {
		40605008,
		0,
		Lang.get(108511),
		40605,
		8,
		1281,
		{
			RTResTalkAction[38],
			RTResTalkAction[40]
		}
	},
	[40605009] = {
		40605009,
		0,
		Lang.get(108512),
		40605,
		9,
		1286,
		{
			RTResTalkAction[38],
			RTResTalkAction[40]
		}
	},
	[40605010] = {
		40605010,
		0,
		Lang.get(108513),
		40605,
		10,
		1281,
		{
			RTResTalkAction[38],
			RTResTalkAction[40]
		}
	},
	[40605011] = {
		40605011,
		0,
		Lang.get(108514),
		40605,
		11,
		1286,
		{
			RTResTalkAction[38],
			RTResTalkAction[40]
		}
	},
	[40605012] = {
		40605012,
		0,
		Lang.get(108515),
		40605,
		12,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[29],
			RTResTalkAction[33]
		}
	},
	[40605013] = {
		40605013,
		0,
		Lang.get(108516),
		40605,
		13,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40605014] = {
		40605014,
		3,
		Lang.get(108517),
		40605,
		14,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40605015] = {
		40605015,
		0,
		Lang.get(108518),
		40605,
		15,
		1280,
		{
			RTResTalkAction[36]
		}
	},
	[40605016] = {
		40605016,
		0,
		"！",
		40605,
		16,
		1276,
		{
			RTResTalkAction[41],
			RTResTalkAction[37]
		}
	},
	[40605017] = {
		40605017,
		0,
		Lang.get(108519),
		40605,
		17,
		1281,
		{
			RTResTalkAction[28],
			RTResTalkAction[12]
		}
	},
	[40605018] = {
		40605018,
		0,
		Lang.get(108520),
		40605,
		18,
		1286,
		{
			RTResTalkAction[31],
			RTResTalkAction[29]
		}
	},
	[40605019] = {
		40605019,
		0,
		Lang.get(108521),
		40605,
		19,
		1280,
		{
			RTResTalkAction[36],
			RTResTalkAction[33]
		}
	},
	[40605020] = {
		40605020,
		3,
		Lang.get(108522),
		40605,
		20,
		605,
		{
			RTResTalkAction[37]
		},
		[22] = 1
	},
	[40605021] = {
		40605021,
		5,
		Lang.get(108523),
		40605,
		21,
		1276,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[40605022] = {
		40605022,
		0,
		Lang.get(108524),
		40605,
		22,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[35]
		}
	},
	[40605023] = {
		40605023,
		3,
		Lang.get(108525),
		40605,
		23,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		5001,
		[22] = 1
	},
	[40605024] = {
		40605024,
		3,
		Lang.get(108526),
		40605,
		24,
		605,
		[22] = 1
	},
	[40605025] = {
		40605025,
		5,
		Lang.get(108527),
		40605,
		25,
		1281,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40621,
		[19] = 40621,
		[17] = 1
	},
	[40605026] = {
		40605026,
		0,
		Lang.get(108528),
		40605,
		26,
		1286,
		{
			RTResTalkAction[31],
			RTResTalkAction[29]
		}
	},
	[40605027] = {
		40605027,
		0,
		Lang.get(108529),
		40605,
		27,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[33]
		}
	},
	[40605028] = {
		40605028,
		3,
		Lang.get(108530),
		40605,
		28,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40605029] = {
		40605029,
		0,
		Lang.get(108531),
		40605,
		29,
		1287,
		{
			RTResTalkAction[32]
		}
	},
	[40605030] = {
		40605030,
		0,
		Lang.get(108532),
		40605,
		30,
		1278,
		{
			RTResTalkAction[43],
			RTResTalkAction[39]
		}
	},
	[40605031] = {
		40605031,
		0,
		Lang.get(108533),
		40605,
		31,
		1287,
		{
			RTResTalkAction[21],
			RTResTalkAction[39]
		}
	},
	[40605032] = {
		40605032,
		3,
		Lang.get(108534),
		40605,
		32,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[34]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1
	},
	[40605033] = {
		40605033,
		3,
		Lang.get(108535),
		40605,
		33,
		605,
		[22] = 1
	},
	[40605034] = {
		40605034,
		0,
		Lang.get(108536),
		40605,
		34,
		1281,
		{
			RTResTalkAction[28]
		}
	},
	[40605035] = {
		40605035,
		0,
		Lang.get(108537),
		40605,
		35,
		1286,
		{
			RTResTalkAction[31],
			RTResTalkAction[29]
		}
	},
	[40605036] = {
		40605036,
		3,
		Lang.get(108538),
		40605,
		36,
		605,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		nil,
		57,
		40622,
		1,
		1,
		nil,
		1,
		nil,
		40622,
		nil,
		nil,
		1
	},
	[40605037] = {
		40605037,
		0,
		"……",
		40605,
		37,
		1276,
		nil,
		1,
		0
	},
	[40605038] = {
		40605038,
		3,
		Lang.get(108539),
		40605,
		38,
		605,
		[22] = 1
	},
	[40605039] = {
		40605039,
		3,
		Lang.get(108540),
		40605,
		39,
		605,
		[22] = 1
	},
	[40605040] = {
		40605040,
		0,
		Lang.get(108541),
		40605,
		40,
		1281,
		nil,
		1,
		0
	},
	[40605041] = {
		40605041,
		0,
		Lang.get(108542),
		40605,
		41,
		1278,
		nil,
		1,
		0
	},
	[40605042] = {
		40605042,
		3,
		Lang.get(108543),
		40605,
		42,
		605,
		[22] = 1
	},
	[40605043] = {
		40605043,
		3,
		Lang.get(108544),
		40605,
		43,
		605,
		[22] = 1
	},
	[40605044] = {
		40605044,
		0,
		Lang.get(108545),
		40605,
		44,
		1286,
		nil,
		1,
		0
	},
	[40605045] = {
		40605045,
		0,
		Lang.get(108546),
		40605,
		45,
		1287,
		nil,
		1,
		0
	},
	[40605046] = {
		40605046,
		9,
		Lang.get(108547),
		40605,
		46,
		605,
		[22] = 1,
		[20] = 200
	},
	[40606001] = {
		40606001,
		3,
		Lang.get(108548),
		40606,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		204,
		40625,
		[19] = 40625,
		[22] = 1
	},
	[40606002] = {
		40606002,
		0,
		Lang.get(108549),
		40606,
		2,
		1286,
		nil,
		1,
		0
	},
	[40606003] = {
		40606003,
		0,
		Lang.get(108550),
		40606,
		3,
		1286,
		nil,
		1,
		0
	},
	[40606004] = {
		40606004,
		3,
		Lang.get(108551),
		40606,
		4,
		605,
		[22] = 1
	},
	[40606005] = {
		40606005,
		0,
		Lang.get(108552),
		40606,
		5,
		677,
		nil,
		1,
		0
	},
	[40606006] = {
		40606006,
		0,
		Lang.get(108553),
		40606,
		6,
		1286,
		nil,
		1,
		0
	},
	[40606007] = {
		40606007,
		0,
		Lang.get(108554),
		40606,
		7,
		677,
		nil,
		1,
		0
	},
	[40606008] = {
		40606008,
		3,
		Lang.get(108555),
		40606,
		8,
		605,
		[22] = 1
	},
	[40606009] = {
		40606009,
		0,
		Lang.get(108556),
		40606,
		9,
		1286,
		nil,
		1,
		0
	},
	[40606010] = {
		40606010,
		0,
		Lang.get(108557),
		40606,
		10,
		1286,
		nil,
		1,
		0
	},
	[40606011] = {
		40606011,
		0,
		Lang.get(108558),
		40606,
		11,
		677,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[40606012] = {
		40606012,
		0,
		Lang.get(108559),
		40606,
		12,
		1286,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606013] = {
		40606013,
		0,
		Lang.get(108560),
		40606,
		13,
		677,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606014] = {
		40606014,
		0,
		Lang.get(108561),
		40606,
		14,
		1286,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606015] = {
		40606015,
		0,
		Lang.get(108562),
		40606,
		15,
		677,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606016] = {
		40606016,
		0,
		Lang.get(108563),
		40606,
		16,
		1286,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606017] = {
		40606017,
		3,
		Lang.get(108564),
		40606,
		17,
		605,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		},
		[22] = 1
	},
	[40606018] = {
		40606018,
		0,
		Lang.get(108565),
		40606,
		18,
		677,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606019] = {
		40606019,
		0,
		Lang.get(108566),
		40606,
		19,
		1286,
		{
			RTResTalkAction[45],
			RTResTalkAction[40]
		}
	},
	[40606020] = {
		40606020,
		3,
		Lang.get(108567),
		40606,
		20,
		605,
		{
			RTResTalkAction[46],
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		5001,
		[22] = 1
	},
	[40606021] = {
		40606021,
		5,
		Lang.get(108568),
		40606,
		21,
		1088,
		{
			RTResTalkAction[47]
		}
	},
	[40606022] = {
		40606022,
		0,
		Lang.get(108569),
		40606,
		22,
		677,
		{
			RTResTalkAction[44],
			RTResTalkAction[48]
		}
	},
	[40606023] = {
		40606023,
		0,
		Lang.get(108570),
		40606,
		23,
		1088,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[40606024] = {
		40606024,
		0,
		Lang.get(108571),
		40606,
		24,
		1286,
		{
			RTResTalkAction[31],
			RTResTalkAction[48]
		}
	},
	[40606025] = {
		40606025,
		3,
		Lang.get(108572),
		40606,
		25,
		605,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		nil,
		122,
		40626,
		1,
		1,
		nil,
		1,
		nil,
		40626,
		nil,
		nil,
		1
	},
	[40606026] = {
		40606026,
		0,
		Lang.get(108573),
		40606,
		26,
		1278,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[40606027] = {
		40606027,
		0,
		Lang.get(108574),
		40606,
		27,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606028] = {
		40606028,
		0,
		Lang.get(108575),
		40606,
		28,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606029] = {
		40606029,
		0,
		Lang.get(108576),
		40606,
		29,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606030] = {
		40606030,
		0,
		Lang.get(108577),
		40606,
		30,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606031] = {
		40606031,
		4,
		nil,
		40606,
		31,
		1278,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 40606032,
				branch_content = Lang.get(108578)
			},
			{
				id = 40606032,
				branch_content = Lang.get(108579)
			}
		}
	},
	[40606032] = {
		40606032,
		5,
		Lang.get(108580),
		40606,
		32,
		1276,
		{
			RTResTalkAction[14]
		}
	},
	[40606033] = {
		40606033,
		0,
		Lang.get(108581),
		40606,
		33,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40606034] = {
		40606034,
		0,
		Lang.get(108582),
		40606,
		34,
		1276,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		}
	},
	[40606035] = {
		40606035,
		4,
		nil,
		40606,
		35,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40606036,
				branch_content = Lang.get(108583)
			},
			{
				id = 40606036,
				branch_content = Lang.get(108584)
			}
		}
	},
	[40606036] = {
		40606036,
		0,
		Lang.get(108585),
		40606,
		36,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40606037] = {
		40606037,
		0,
		Lang.get(108586),
		40606,
		37,
		1284,
		{
			RTResTalkAction[49],
			RTResTalkAction[22]
		}
	},
	[40606038] = {
		40606038,
		0,
		Lang.get(108587),
		40606,
		38,
		1285,
		{
			RTResTalkAction[49],
			RTResTalkAction[50],
			RTResTalkAction[12]
		}
	},
	[40606039] = {
		40606039,
		0,
		Lang.get(108588),
		40606,
		39,
		1284,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[40606040] = {
		40606040,
		3,
		Lang.get(108589),
		40606,
		40,
		605,
		{
			RTResTalkAction[15],
			RTResTalkAction[51],
			RTResTalkAction[52]
		},
		[21] = 1276,
		[22] = 1
	},
	[40606041] = {
		40606041,
		0,
		Lang.get(108590),
		40606,
		41,
		1284,
		{
			RTResTalkAction[53],
			RTResTalkAction[12]
		}
	},
	[40606042] = {
		40606042,
		0,
		Lang.get(18271),
		40606,
		42,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[51]
		}
	},
	[40606043] = {
		40606043,
		0,
		Lang.get(108591),
		40606,
		43,
		1285,
		{
			RTResTalkAction[54],
			RTResTalkAction[12]
		}
	},
	[40606044] = {
		40606044,
		0,
		Lang.get(108592),
		40606,
		44,
		1284,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[40606045] = {
		40606045,
		3,
		Lang.get(108593),
		40606,
		45,
		605,
		{
			RTResTalkAction[53],
			RTResTalkAction[52]
		},
		[21] = 1284,
		[22] = 1
	},
	[40606046] = {
		40606046,
		0,
		Lang.get(108594),
		40606,
		46,
		1276,
		{
			RTResTalkAction[41],
			RTResTalkAction[51]
		}
	},
	[40606047] = {
		40606047,
		0,
		Lang.get(108595),
		40606,
		47,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606048] = {
		40606048,
		0,
		Lang.get(108596),
		40606,
		48,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606049] = {
		40606049,
		0,
		"？",
		40606,
		49,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606050] = {
		40606050,
		0,
		Lang.get(108597),
		40606,
		50,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		}
	},
	[40606051] = {
		40606051,
		0,
		Lang.get(108598),
		40606,
		51,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40606052] = {
		40606052,
		0,
		Lang.get(108599),
		40606,
		52,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[55]
		}
	},
	[40607001] = {
		40607001,
		3,
		Lang.get(108600),
		40607,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		122,
		40630,
		[19] = 40630,
		[22] = 1
	},
	[40607002] = {
		40607002,
		0,
		Lang.get(108601),
		40607,
		2,
		127,
		nil,
		1,
		1
	},
	[40607003] = {
		40607003,
		0,
		Lang.get(108602),
		40607,
		3,
		117,
		nil,
		1,
		0
	},
	[40607004] = {
		40607004,
		0,
		Lang.get(108603),
		40607,
		4,
		127,
		nil,
		1,
		0
	},
	[40607005] = {
		40607005,
		0,
		Lang.get(108604),
		40607,
		5,
		1278,
		nil,
		1,
		0
	},
	[40607006] = {
		40607006,
		0,
		Lang.get(108605),
		40607,
		6,
		1276,
		nil,
		1
	},
	[40607007] = {
		40607007,
		0,
		Lang.get(108606),
		40607,
		7,
		1278,
		nil,
		1
	},
	[40607008] = {
		40607008,
		0,
		Lang.get(108607),
		40607,
		8,
		1276,
		nil,
		1
	},
	[40607009] = {
		40607009,
		4,
		nil,
		40607,
		9,
		1278,
		[29] = {
			{
				id = 40607010,
				branch_content = Lang.get(108608)
			},
			{
				id = 40607010,
				branch_content = Lang.get(108609)
			}
		}
	},
	[40607010] = {
		40607010,
		0,
		Lang.get(108610),
		40607,
		10,
		1276,
		nil,
		1,
		0
	},
	[40607011] = {
		40607011,
		3,
		Lang.get(108611),
		40607,
		11,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		40631,
		nil,
		nil,
		nil,
		nil,
		nil,
		40631,
		0,
		nil,
		1
	},
	[40607012] = {
		40607012,
		0,
		Lang.get(108612),
		40607,
		12,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40607013] = {
		40607013,
		0,
		Lang.get(108613),
		40607,
		13,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40607014] = {
		40607014,
		3,
		Lang.get(108614),
		40607,
		14,
		605,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		},
		[21] = 1276,
		[22] = 1
	},
	[40607015] = {
		40607015,
		0,
		Lang.get(108615),
		40607,
		15,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40607016] = {
		40607016,
		3,
		Lang.get(108616),
		40607,
		16,
		605,
		{
			RTResTalkAction[16]
		},
		[21] = 1276,
		[22] = 1
	},
	[40607017] = {
		40607017,
		0,
		Lang.get(108617),
		40607,
		17,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40607018] = {
		40607018,
		3,
		Lang.get(108618),
		40607,
		18,
		605,
		{
			RTResTalkAction[56]
		},
		[21] = 1276,
		[22] = 1
	},
	[40607019] = {
		40607019,
		0,
		Lang.get(108619),
		40607,
		19,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40607020] = {
		40607020,
		0,
		Lang.get(108620),
		40607,
		20,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40607021] = {
		40607021,
		0,
		Lang.get(108621),
		40607,
		21,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40607022] = {
		40607022,
		0,
		Lang.get(108622),
		40607,
		22,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40607023] = {
		40607023,
		0,
		Lang.get(108623),
		40607,
		23,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40607024] = {
		40607024,
		3,
		Lang.get(108624),
		40607,
		24,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40607025] = {
		40607025,
		0,
		Lang.get(108625),
		40607,
		25,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40607026] = {
		40607026,
		0,
		Lang.get(67675),
		40607,
		26,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40607027] = {
		40607027,
		3,
		Lang.get(108626),
		40607,
		27,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40607028] = {
		40607028,
		0,
		Lang.get(108627),
		40607,
		28,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40607029] = {
		40607029,
		0,
		Lang.get(108628),
		40607,
		29,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[2]
		}
	},
	[40607030] = {
		40607030,
		3,
		Lang.get(108629),
		40607,
		30,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40607031] = {
		40607031,
		0,
		Lang.get(108630),
		40607,
		31,
		1276,
		{
			RTResTalkAction[14]
		}
	},
	[40607032] = {
		40607032,
		0,
		Lang.get(108631),
		40607,
		32,
		1278,
		{
			RTResTalkAction[57],
			RTResTalkAction[12]
		}
	},
	[40607033] = {
		40607033,
		3,
		Lang.get(108632),
		40607,
		33,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40607034] = {
		40607034,
		3,
		Lang.get(108633),
		40607,
		34,
		605,
		[22] = 1
	},
	[40607035] = {
		40607035,
		9,
		Lang.get(108634),
		40607,
		35,
		605,
		nil,
		nil,
		nil,
		nil,
		2755,
		[22] = 1
	},
	[40607036] = {
		40607036,
		5,
		Lang.get(108635),
		40607,
		36,
		1276,
		{
			RTResTalkAction[41]
		}
	},
	[40607037] = {
		40607037,
		0,
		Lang.get(108636),
		40607,
		37,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40607038] = {
		40607038,
		0,
		Lang.get(108637),
		40607,
		38,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40607039] = {
		40607039,
		0,
		Lang.get(108638),
		40607,
		39,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[40607040] = {
		40607040,
		0,
		"……",
		40607,
		40,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		2764,
		nil,
		nil,
		1
	},
	[40607041] = {
		40607041,
		0,
		Lang.get(108639),
		40607,
		41,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40607042] = {
		40607042,
		3,
		Lang.get(108640),
		40607,
		42,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40608001] = {
		40608001,
		3,
		Lang.get(108641),
		40608,
		1,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		204,
		40635,
		nil,
		nil,
		nil,
		nil,
		nil,
		40635,
		nil,
		1276,
		1
	},
	[40608002] = {
		40608002,
		0,
		Lang.get(64810),
		40608,
		2,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40608003] = {
		40608003,
		0,
		Lang.get(108642),
		40608,
		3,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40608004] = {
		40608004,
		0,
		Lang.get(108643),
		40608,
		4,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40608005] = {
		40608005,
		0,
		Lang.get(108644),
		40608,
		5,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40608006] = {
		40608006,
		9,
		Lang.get(108645),
		40608,
		6,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		40636,
		1,
		1,
		nil,
		1,
		nil,
		40636,
		nil,
		nil,
		1
	},
	[40608007] = {
		40608007,
		0,
		Lang.get(108646),
		40608,
		7,
		1276,
		nil,
		1,
		0
	},
	[40608008] = {
		40608008,
		0,
		Lang.get(108647),
		40608,
		8,
		1278,
		nil,
		1,
		0
	},
	[40608009] = {
		40608009,
		0,
		Lang.get(108648),
		40608,
		9,
		1276,
		nil,
		1,
		0
	},
	[40608010] = {
		40608010,
		0,
		Lang.get(108649),
		40608,
		10,
		1278,
		nil,
		1,
		0
	},
	[40608011] = {
		40608011,
		0,
		Lang.get(108650),
		40608,
		11,
		1276,
		nil,
		1,
		0
	},
	[40608012] = {
		40608012,
		0,
		Lang.get(108651),
		40608,
		12,
		1276,
		nil,
		1,
		0
	},
	[40608013] = {
		40608013,
		0,
		Lang.get(108652),
		40608,
		13,
		1278,
		nil,
		1,
		0
	},
	[40608014] = {
		40608014,
		0,
		Lang.get(108653),
		40608,
		14,
		1276
	},
	[40608015] = {
		40608015,
		9,
		Lang.get(108654),
		40608,
		15,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40637,
		1,
		1,
		nil,
		1,
		nil,
		40637,
		nil,
		nil,
		1
	},
	[40608016] = {
		40608016,
		0,
		Lang.get(108655),
		40608,
		16,
		1276,
		nil,
		1,
		0
	},
	[40608017] = {
		40608017,
		0,
		Lang.get(108656),
		40608,
		17,
		1278,
		nil,
		1,
		0
	},
	[40608018] = {
		40608018,
		0,
		Lang.get(108657),
		40608,
		18,
		1276,
		nil,
		1,
		0
	},
	[40608019] = {
		40608019,
		0,
		Lang.get(23797),
		40608,
		19,
		1278,
		nil,
		1,
		0
	},
	[40608020] = {
		40608020,
		0,
		Lang.get(108658),
		40608,
		20,
		1276,
		nil,
		1,
		0
	},
	[40608021] = {
		40608021,
		3,
		Lang.get(108659),
		40608,
		21,
		605,
		[22] = 1
	},
	[40608022] = {
		40608022,
		0,
		Lang.get(108660),
		40608,
		22,
		1276,
		nil,
		1,
		0
	},
	[40608023] = {
		40608023,
		0,
		Lang.get(108661),
		40608,
		23,
		1278,
		nil,
		1,
		0
	},
	[40608024] = {
		40608024,
		0,
		Lang.get(108662),
		40608,
		24,
		1276,
		nil,
		1,
		0
	},
	[40608025] = {
		40608025,
		0,
		Lang.get(108663),
		40608,
		25,
		1276,
		nil,
		1,
		0
	},
	[40608026] = {
		40608026,
		3,
		Lang.get(108664),
		40608,
		26,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1,
		[20] = 255
	},
	[40608027] = {
		40608027,
		3,
		Lang.get(108665),
		40608,
		27,
		605,
		{
			RTResTalkAction[58],
			RTResTalkAction[59],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		5001,
		[22] = 1
	},
	[40608028] = {
		40608028,
		0,
		Lang.get(108666),
		40608,
		28,
		829,
		{
			RTResTalkAction[61],
			RTResTalkAction[62],
			RTResTalkAction[63],
			RTResTalkAction[64]
		}
	},
	[40608029] = {
		40608029,
		0,
		Lang.get(108667),
		40608,
		29,
		677,
		{
			RTResTalkAction[44],
			RTResTalkAction[65]
		}
	},
	[40608030] = {
		40608030,
		0,
		Lang.get(108668),
		40608,
		30,
		677,
		{
			RTResTalkAction[44]
		}
	},
	[40609001] = {
		40609001,
		9,
		Lang.get(108669),
		40609,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		40640,
		[19] = 40640,
		[22] = 1
	},
	[40609002] = {
		40609002,
		0,
		Lang.get(108670),
		40609,
		2,
		1276,
		nil,
		1,
		0
	},
	[40609003] = {
		40609003,
		0,
		Lang.get(108671),
		40609,
		3,
		1276,
		nil,
		1,
		0
	},
	[40609004] = {
		40609004,
		0,
		Lang.get(108672),
		40609,
		4,
		1278,
		nil,
		1,
		0
	},
	[40609005] = {
		40609005,
		0,
		Lang.get(108673),
		40609,
		5,
		1276,
		nil,
		1,
		0
	},
	[40609006] = {
		40609006,
		0,
		Lang.get(108674),
		40609,
		6,
		1278,
		nil,
		1,
		0
	},
	[40609007] = {
		40609007,
		3,
		Lang.get(108675),
		40609,
		7,
		605,
		[22] = 1
	},
	[40609008] = {
		40609008,
		0,
		Lang.get(108676),
		40609,
		8,
		1276,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40641,
		1,
		1,
		nil,
		1,
		nil,
		40641
	},
	[40609009] = {
		40609009,
		0,
		Lang.get(108677),
		40609,
		9,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609010] = {
		40609010,
		0,
		Lang.get(108678),
		40609,
		10,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609011] = {
		40609011,
		3,
		Lang.get(108679),
		40609,
		11,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40609012] = {
		40609012,
		0,
		Lang.get(108680),
		40609,
		12,
		1276,
		{
			RTResTalkAction[20]
		}
	},
	[40609013] = {
		40609013,
		3,
		Lang.get(108681),
		40609,
		13,
		605,
		{
			RTResTalkAction[11]
		},
		[21] = 1276,
		[22] = 1
	},
	[40609014] = {
		40609014,
		0,
		"……",
		40609,
		14,
		1278,
		{
			RTResTalkAction[12]
		},
		1,
		0
	},
	[40609015] = {
		40609015,
		4,
		nil,
		40609,
		15,
		1278,
		[29] = {
			{
				id = 40609016,
				branch_content = Lang.get(108682)
			},
			{
				id = 40609016,
				branch_content = Lang.get(108683)
			}
		}
	},
	[40609016] = {
		40609016,
		0,
		Lang.get(108684),
		40609,
		16,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609017] = {
		40609017,
		0,
		Lang.get(108685),
		40609,
		17,
		1278,
		{
			RTResTalkAction[11]
		},
		1
	},
	[40609018] = {
		40609018,
		0,
		Lang.get(108686),
		40609,
		18,
		1278,
		{
			RTResTalkAction[11]
		},
		1,
		nil,
		nil,
		nil,
		58
	},
	[40609019] = {
		40609019,
		0,
		Lang.get(23797),
		40609,
		19,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609020] = {
		40609020,
		0,
		Lang.get(108687),
		40609,
		20,
		1278,
		{
			RTResTalkAction[11]
		},
		1
	},
	[40609021] = {
		40609021,
		0,
		Lang.get(108688),
		40609,
		21,
		1276,
		{
			RTResTalkAction[13]
		}
	},
	[40609022] = {
		40609022,
		0,
		Lang.get(108689),
		40609,
		22,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609023] = {
		40609023,
		0,
		Lang.get(108690),
		40609,
		23,
		1276,
		{
			RTResTalkAction[20]
		}
	},
	[40609024] = {
		40609024,
		4,
		nil,
		40609,
		24,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40609025,
				branch_content = Lang.get(108691)
			},
			{
				id = 40609025,
				branch_content = Lang.get(108692)
			}
		}
	},
	[40609025] = {
		40609025,
		0,
		Lang.get(108693),
		40609,
		25,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609026] = {
		40609026,
		0,
		Lang.get(108694),
		40609,
		26,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40609027] = {
		40609027,
		3,
		Lang.get(108695),
		40609,
		27,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[22] = 1,
		[20] = 255
	},
	[40609028] = {
		40609028,
		5,
		Lang.get(108696),
		40609,
		28,
		677,
		{
			RTResTalkAction[44]
		}
	},
	[40609029] = {
		40609029,
		0,
		Lang.get(19967),
		40609,
		29,
		829,
		{
			RTResTalkAction[61],
			RTResTalkAction[46]
		}
	},
	[40609030] = {
		40609030,
		3,
		Lang.get(108697),
		40609,
		30,
		605,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		nil,
		5002,
		[22] = 1,
		[20] = 100
	},
	[40609031] = {
		40609031,
		3,
		Lang.get(108698),
		40609,
		31,
		605,
		[22] = 1
	},
	[40609032] = {
		40609032,
		5,
		Lang.get(108699),
		40609,
		32,
		677,
		{
			RTResTalkAction[44]
		}
	},
	[40610001] = {
		40610001,
		3,
		Lang.get(108700),
		40610,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		122,
		40645,
		nil,
		nil,
		nil,
		nil,
		nil,
		40645,
		nil,
		nil,
		1
	},
	[40610002] = {
		40610002,
		0,
		Lang.get(108701),
		40610,
		2,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40610003] = {
		40610003,
		0,
		Lang.get(108702),
		40610,
		3,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40610004] = {
		40610004,
		0,
		Lang.get(108703),
		40610,
		4,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40610005] = {
		40610005,
		3,
		Lang.get(108704),
		40610,
		5,
		605,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[40610006] = {
		40610006,
		0,
		Lang.get(108705),
		40610,
		6,
		112,
		{
			RTResTalkAction[66],
			RTResTalkAction[2],
			RTResTalkAction[12]
		}
	},
	[40610007] = {
		40610007,
		0,
		Lang.get(108706),
		40610,
		7,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[67]
		}
	},
	[40610008] = {
		40610008,
		3,
		Lang.get(108707),
		40610,
		8,
		605,
		{
			RTResTalkAction[68],
			RTResTalkAction[69],
			RTResTalkAction[70],
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		5001,
		[22] = 1
	},
	[40610009] = {
		40610009,
		0,
		Lang.get(108708),
		40610,
		9,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[72],
			RTResTalkAction[73],
			RTResTalkAction[74]
		}
	},
	[40610010] = {
		40610010,
		0,
		Lang.get(108709),
		40610,
		10,
		112,
		{
			RTResTalkAction[75]
		}
	},
	[40610011] = {
		40610011,
		3,
		Lang.get(108710),
		40610,
		11,
		605,
		{
			RTResTalkAction[41],
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[21] = 1276,
		[22] = 1
	},
	[40610012] = {
		40610012,
		0,
		Lang.get(20587),
		40610,
		12,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40610013] = {
		40610013,
		0,
		Lang.get(108711),
		40610,
		13,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[12]
		}
	},
	[40610014] = {
		40610014,
		0,
		Lang.get(108712),
		40610,
		14,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[67]
		}
	},
	[40610015] = {
		40610015,
		3,
		Lang.get(108713),
		40610,
		15,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40610016] = {
		40610016,
		0,
		Lang.get(108714),
		40610,
		16,
		112,
		{
			RTResTalkAction[71]
		}
	},
	[40610017] = {
		40610017,
		0,
		Lang.get(108715),
		40610,
		17,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[67]
		}
	},
	[40610018] = {
		40610018,
		0,
		Lang.get(108716),
		40610,
		18,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40610019] = {
		40610019,
		0,
		Lang.get(108717),
		40610,
		19,
		112,
		{
			RTResTalkAction[76],
			RTResTalkAction[12]
		}
	},
	[40610020] = {
		40610020,
		5,
		Lang.get(108718),
		40610,
		20,
		1276,
		{
			RTResTalkAction[42],
			RTResTalkAction[67]
		}
	},
	[40610021] = {
		40610021,
		0,
		Lang.get(108719),
		40610,
		21,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[12]
		}
	},
	[40610022] = {
		40610022,
		0,
		Lang.get(108720),
		40610,
		22,
		112,
		{
			RTResTalkAction[76]
		}
	},
	[40610023] = {
		40610023,
		0,
		Lang.get(108721),
		40610,
		23,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[67]
		}
	},
	[40610024] = {
		40610024,
		0,
		Lang.get(108722),
		40610,
		24,
		112,
		{
			RTResTalkAction[77],
			RTResTalkAction[12]
		}
	},
	[40610025] = {
		40610025,
		0,
		"……！",
		40610,
		25,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[67]
		}
	},
	[40610026] = {
		40610026,
		3,
		Lang.get(108723),
		40610,
		26,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40610027] = {
		40610027,
		0,
		Lang.get(108724),
		40610,
		27,
		112,
		{
			RTResTalkAction[76]
		}
	},
	[40610028] = {
		40610028,
		0,
		Lang.get(108725),
		40610,
		28,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[67]
		}
	},
	[40610029] = {
		40610029,
		0,
		Lang.get(108726),
		40610,
		29,
		112,
		{
			RTResTalkAction[76],
			RTResTalkAction[12]
		}
	},
	[40610030] = {
		40610030,
		0,
		Lang.get(108727),
		40610,
		30,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[67]
		}
	},
	[40610031] = {
		40610031,
		3,
		Lang.get(108728),
		40610,
		31,
		605,
		{
			RTResTalkAction[20]
		},
		[21] = 1276,
		[22] = 1
	},
	[40610032] = {
		40610032,
		0,
		Lang.get(108729),
		40610,
		32,
		112,
		{
			RTResTalkAction[76],
			RTResTalkAction[12]
		}
	},
	[40610033] = {
		40610033,
		5,
		Lang.get(108730),
		40610,
		33,
		1276,
		{
			RTResTalkAction[42],
			RTResTalkAction[67]
		}
	},
	[40801001] = {
		40801001,
		3,
		Lang.get(87559),
		40801,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		8,
		40650,
		1,
		1,
		nil,
		nil,
		nil,
		40650,
		nil,
		nil,
		1
	},
	[40801002] = {
		40801002,
		0,
		Lang.get(108731),
		40801,
		2,
		1195,
		nil,
		1,
		0,
		[17] = 0
	},
	[40801003] = {
		40801003,
		0,
		Lang.get(108732),
		40801,
		3,
		1122,
		nil,
		1,
		2
	},
	[40801004] = {
		40801004,
		0,
		Lang.get(108733),
		40801,
		4,
		1134,
		nil,
		1,
		0
	},
	[40801005] = {
		40801005,
		0,
		Lang.get(108734),
		40801,
		5,
		1122,
		nil,
		1,
		0
	},
	[40801006] = {
		40801006,
		3,
		Lang.get(108735),
		40801,
		6,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40651,
		[19] = 40651,
		[22] = 1
	},
	[40801007] = {
		40801007,
		0,
		Lang.get(108736),
		40801,
		7,
		1237,
		nil,
		1,
		1
	},
	[40801008] = {
		40801008,
		0,
		Lang.get(108737),
		40801,
		8,
		1122,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[40801009] = {
		40801009,
		0,
		Lang.get(108738),
		40801,
		9,
		1237,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[40801010] = {
		40801010,
		0,
		Lang.get(108739),
		40801,
		10,
		1122,
		{
			RTResTalkAction[79],
			RTResTalkAction[81]
		}
	},
	[40801011] = {
		40801011,
		0,
		Lang.get(108740),
		40801,
		11,
		1237,
		{
			RTResTalkAction[79],
			RTResTalkAction[82]
		}
	},
	[40801012] = {
		40801012,
		0,
		Lang.get(108741),
		40801,
		12,
		1122,
		{
			RTResTalkAction[83],
			RTResTalkAction[84],
			RTResTalkAction[85]
		},
		1,
		0,
		[21] = 431
	},
	[40801013] = {
		40801013,
		0,
		Lang.get(108742),
		40801,
		13,
		1237,
		{
			RTResTalkAction[83]
		},
		1,
		[21] = 431
	},
	[40801014] = {
		40801014,
		0,
		Lang.get(108743),
		40801,
		14,
		1122,
		{
			RTResTalkAction[83]
		},
		1,
		0,
		[21] = 431
	},
	[40801015] = {
		40801015,
		0,
		Lang.get(108744),
		40801,
		15,
		1237,
		{
			RTResTalkAction[83]
		},
		1,
		[21] = 431
	},
	[40801016] = {
		40801016,
		0,
		Lang.get(66037),
		40801,
		16,
		1122,
		{
			RTResTalkAction[83]
		},
		1,
		3,
		[21] = 431
	},
	[40801017] = {
		40801017,
		0,
		Lang.get(108745),
		40801,
		17,
		1237,
		{
			RTResTalkAction[83]
		},
		1,
		0,
		[21] = 431
	},
	[40801018] = {
		40801018,
		0,
		Lang.get(108746),
		40801,
		18,
		1237,
		{
			RTResTalkAction[83]
		},
		1,
		3,
		[21] = 431
	},
	[40611001] = {
		40611001,
		3,
		Lang.get(108747),
		40611,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		122,
		40655,
		[19] = 40655,
		[22] = 1
	},
	[40611002] = {
		40611002,
		0,
		Lang.get(108748),
		40611,
		2,
		1283,
		nil,
		1,
		0
	},
	[40611003] = {
		40611003,
		0,
		Lang.get(108749),
		40611,
		3,
		1115,
		nil,
		1,
		0
	},
	[40611004] = {
		40611004,
		0,
		Lang.get(108750),
		40611,
		4,
		1278,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[40611005] = {
		40611005,
		0,
		Lang.get(108751),
		40611,
		5,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40611006] = {
		40611006,
		0,
		Lang.get(108752),
		40611,
		6,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40611007] = {
		40611007,
		4,
		nil,
		40611,
		7,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40611008,
				branch_content = Lang.get(108753)
			},
			{
				id = 40611008,
				branch_content = Lang.get(108754)
			}
		}
	},
	[40611008] = {
		40611008,
		0,
		Lang.get(108755),
		40611,
		8,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40611009] = {
		40611009,
		0,
		Lang.get(108756),
		40611,
		9,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40611010] = {
		40611010,
		0,
		Lang.get(108757),
		40611,
		10,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40611011] = {
		40611011,
		0,
		Lang.get(108758),
		40611,
		11,
		1288,
		{
			RTResTalkAction[12]
		},
		1,
		1,
		nil,
		nil,
		138
	},
	[40611012] = {
		40611012,
		3,
		Lang.get(108759),
		40611,
		12,
		605,
		[22] = 1
	},
	[40611013] = {
		40611013,
		0,
		Lang.get(44811),
		40611,
		13,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40611014] = {
		40611014,
		0,
		Lang.get(108760),
		40611,
		14,
		226,
		{
			RTResTalkAction[86],
			RTResTalkAction[12]
		}
	},
	[40611015] = {
		40611015,
		0,
		Lang.get(108761),
		40611,
		15,
		1276,
		{
			RTResTalkAction[87]
		},
		1,
		0,
		nil,
		nil,
		nil,
		40656,
		1,
		1,
		nil,
		1,
		nil,
		40656
	},
	[40611016] = {
		40611016,
		0,
		Lang.get(108762),
		40611,
		16,
		226,
		nil,
		1
	},
	[40611017] = {
		40611017,
		0,
		Lang.get(108763),
		40611,
		17,
		1276,
		nil,
		1,
		0
	},
	[40611018] = {
		40611018,
		0,
		Lang.get(108764),
		40611,
		18,
		226,
		{
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[40611019] = {
		40611019,
		0,
		Lang.get(108765),
		40611,
		19,
		226,
		{
			RTResTalkAction[89]
		}
	},
	[40611020] = {
		40611020,
		0,
		Lang.get(108766),
		40611,
		20,
		1276,
		{
			RTResTalkAction[90],
			RTResTalkAction[24]
		}
	},
	[40611021] = {
		40611021,
		0,
		Lang.get(108767),
		40611,
		21,
		226,
		{
			RTResTalkAction[91],
			RTResTalkAction[22]
		}
	},
	[40611022] = {
		40611022,
		3,
		Lang.get(108768),
		40611,
		22,
		605,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40611023] = {
		40611023,
		3,
		Lang.get(108769),
		40611,
		23,
		605,
		{
			RTResTalkAction[92]
		},
		[22] = 1
	},
	[40611024] = {
		40611024,
		4,
		nil,
		40611,
		24,
		1278,
		{
			RTResTalkAction[87]
		},
		[29] = {
			{
				id = 40611025,
				branch_content = Lang.get(108770)
			},
			{
				id = 40611025,
				branch_content = Lang.get(108771)
			}
		}
	},
	[40611025] = {
		40611025,
		0,
		Lang.get(108772),
		40611,
		25,
		1276,
		{
			RTResTalkAction[14]
		}
	},
	[40611026] = {
		40611026,
		0,
		Lang.get(108773),
		40611,
		26,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40611027] = {
		40611027,
		0,
		Lang.get(108774),
		40611,
		27,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40611028] = {
		40611028,
		0,
		Lang.get(108775),
		40611,
		28,
		1276,
		{
			RTResTalkAction[90],
			RTResTalkAction[22]
		}
	},
	[40611029] = {
		40611029,
		0,
		Lang.get(108776),
		40611,
		29,
		226,
		{
			RTResTalkAction[90],
			RTResTalkAction[22]
		}
	},
	[40611030] = {
		40611030,
		0,
		Lang.get(108777),
		40611,
		30,
		1276,
		{
			RTResTalkAction[90],
			RTResTalkAction[22]
		}
	},
	[40611031] = {
		40611031,
		0,
		Lang.get(108778),
		40611,
		31,
		226,
		{
			RTResTalkAction[89],
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		204
	},
	[40611032] = {
		40611032,
		0,
		Lang.get(108779),
		40611,
		32,
		226,
		{
			RTResTalkAction[88]
		}
	},
	[40611033] = {
		40611033,
		0,
		Lang.get(108780),
		40611,
		33,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40611034] = {
		40611034,
		0,
		Lang.get(108781),
		40611,
		34,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40611035] = {
		40611035,
		0,
		Lang.get(108782),
		40611,
		35,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40611036] = {
		40611036,
		0,
		Lang.get(108783),
		40611,
		36,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40611037] = {
		40611037,
		0,
		Lang.get(108784),
		40611,
		37,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40611038] = {
		40611038,
		0,
		Lang.get(108785),
		40611,
		38,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40611039] = {
		40611039,
		0,
		Lang.get(108786),
		40611,
		39,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40611040] = {
		40611040,
		0,
		Lang.get(108787),
		40611,
		40,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40611041] = {
		40611041,
		0,
		Lang.get(108788),
		40611,
		41,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40611042] = {
		40611042,
		0,
		Lang.get(108789),
		40611,
		42,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40611043] = {
		40611043,
		0,
		Lang.get(108790),
		40611,
		43,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40611044] = {
		40611044,
		3,
		Lang.get(108791),
		40611,
		44,
		605,
		{
			RTResTalkAction[20],
			RTResTalkAction[87]
		},
		[21] = 1276,
		[22] = 1
	},
	[40611045] = {
		40611045,
		0,
		Lang.get(108792),
		40611,
		45,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40611046] = {
		40611046,
		0,
		Lang.get(108793),
		40611,
		46,
		226,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		nil,
		nil,
		193
	},
	[40611047] = {
		40611047,
		5,
		"……！！！",
		40611,
		47,
		1278,
		{
			RTResTalkAction[1],
			RTResTalkAction[87]
		}
	},
	[40611048] = {
		40611048,
		5,
		Lang.get(108794),
		40611,
		48,
		1276,
		{
			RTResTalkAction[93],
			RTResTalkAction[2]
		}
	},
	[40611049] = {
		40611049,
		0,
		Lang.get(91104),
		40611,
		49,
		226,
		{
			RTResTalkAction[90],
			RTResTalkAction[22]
		}
	},
	[40611050] = {
		40611050,
		0,
		Lang.get(108795),
		40611,
		50,
		1276,
		{
			RTResTalkAction[90],
			RTResTalkAction[22]
		}
	},
	[40611051] = {
		40611051,
		3,
		Lang.get(108796),
		40611,
		51,
		605,
		{
			RTResTalkAction[87],
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40611052] = {
		40611052,
		3,
		Lang.get(108797),
		40611,
		52,
		605,
		[22] = 1
	},
	[40611053] = {
		40611053,
		3,
		Lang.get(108798),
		40611,
		53,
		605,
		[22] = 1
	},
	[40611054] = {
		40611054,
		0,
		"……",
		40611,
		54,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40611055] = {
		40611055,
		4,
		nil,
		40611,
		55,
		1278,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 40611056,
				branch_content = Lang.get(108799)
			}
		}
	},
	[40611056] = {
		40611056,
		3,
		Lang.get(108800),
		40611,
		56,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40611057] = {
		40611057,
		3,
		Lang.get(108801),
		40611,
		57,
		605,
		[22] = 1
	},
	[40611058] = {
		40611058,
		0,
		Lang.get(108802),
		40611,
		58,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40611059] = {
		40611059,
		0,
		Lang.get(108803),
		40611,
		59,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[2]
		}
	},
	[40612001] = {
		40612001,
		0,
		Lang.get(108804),
		40612,
		1,
		226,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		nil,
		nil,
		204,
		40660,
		[19] = 40660
	},
	[40612002] = {
		40612002,
		0,
		Lang.get(108805),
		40612,
		2,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40612003] = {
		40612003,
		0,
		Lang.get(108806),
		40612,
		3,
		226,
		{
			RTResTalkAction[89]
		}
	},
	[40612004] = {
		40612004,
		0,
		Lang.get(107830),
		40612,
		4,
		226,
		{
			RTResTalkAction[86]
		}
	},
	[40612005] = {
		40612005,
		0,
		Lang.get(108807),
		40612,
		5,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40612006] = {
		40612006,
		0,
		Lang.get(108808),
		40612,
		6,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40612007] = {
		40612007,
		0,
		Lang.get(108809),
		40612,
		7,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40612008] = {
		40612008,
		0,
		Lang.get(108810),
		40612,
		8,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40612009] = {
		40612009,
		0,
		Lang.get(108811),
		40612,
		9,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40612010] = {
		40612010,
		0,
		Lang.get(108812),
		40612,
		10,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40612011] = {
		40612011,
		3,
		Lang.get(108813),
		40612,
		11,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40612012] = {
		40612012,
		0,
		Lang.get(108814),
		40612,
		12,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40612013] = {
		40612013,
		3,
		Lang.get(108815),
		40612,
		13,
		605,
		{
			RTResTalkAction[87]
		},
		[22] = 1
	},
	[40612014] = {
		40612014,
		4,
		nil,
		40612,
		14,
		1278,
		[29] = {
			{
				id = 40612015,
				branch_content = Lang.get(108816)
			},
			{
				id = 40612015,
				branch_content = Lang.get(108817)
			}
		}
	},
	[40612015] = {
		40612015,
		0,
		Lang.get(108818),
		40612,
		15,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40612016] = {
		40612016,
		0,
		Lang.get(108819),
		40612,
		16,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40612017] = {
		40612017,
		0,
		Lang.get(108820),
		40612,
		17,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40612018] = {
		40612018,
		0,
		Lang.get(32365),
		40612,
		18,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[87]
		}
	},
	[40612019] = {
		40612019,
		0,
		Lang.get(108821),
		40612,
		19,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[12]
		}
	},
	[40612020] = {
		40612020,
		0,
		Lang.get(108822),
		40612,
		20,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40612021] = {
		40612021,
		0,
		Lang.get(108823),
		40612,
		21,
		226,
		{
			RTResTalkAction[89]
		}
	},
	[40612022] = {
		40612022,
		0,
		Lang.get(108824),
		40612,
		22,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[87]
		}
	},
	[40612023] = {
		40612023,
		0,
		Lang.get(108825),
		40612,
		23,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40612024] = {
		40612024,
		0,
		Lang.get(108826),
		40612,
		24,
		226,
		{
			RTResTalkAction[88],
			RTResTalkAction[12]
		}
	},
	[40612025] = {
		40612025,
		0,
		Lang.get(108827),
		40612,
		25,
		1276,
		{
			RTResTalkAction[41],
			RTResTalkAction[87]
		}
	},
	[40612026] = {
		40612026,
		0,
		Lang.get(108828),
		40612,
		26,
		226,
		{
			RTResTalkAction[89],
			RTResTalkAction[12]
		}
	},
	[40612027] = {
		40612027,
		0,
		Lang.get(108829),
		40612,
		27,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[87]
		}
	},
	[40612028] = {
		40612028,
		0,
		Lang.get(108830),
		40612,
		28,
		226,
		{
			RTResTalkAction[88],
			RTResTalkAction[12]
		}
	},
	[40612029] = {
		40612029,
		0,
		Lang.get(108831),
		40612,
		29,
		226,
		{
			RTResTalkAction[92]
		}
	},
	[40612030] = {
		40612030,
		3,
		Lang.get(108832),
		40612,
		30,
		605,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		[22] = 1
	},
	[40612031] = {
		40612031,
		0,
		Lang.get(103722),
		40612,
		31,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40612032] = {
		40612032,
		0,
		Lang.get(108833),
		40612,
		32,
		226,
		{
			RTResTalkAction[92],
			RTResTalkAction[2]
		}
	},
	[40612033] = {
		40612033,
		0,
		Lang.get(22568),
		40612,
		33,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[87]
		}
	},
	[40612034] = {
		40612034,
		0,
		Lang.get(108834),
		40612,
		34,
		226,
		{
			RTResTalkAction[94],
			RTResTalkAction[2]
		}
	},
	[40613001] = {
		40613001,
		0,
		Lang.get(108835),
		40613,
		1,
		1276,
		nil,
		1,
		0,
		nil,
		nil,
		209,
		40665,
		nil,
		nil,
		nil,
		nil,
		nil,
		40665
	},
	[40613002] = {
		40613002,
		0,
		Lang.get(108836),
		40613,
		2,
		1278,
		nil,
		1,
		0
	},
	[40613003] = {
		40613003,
		0,
		Lang.get(108837),
		40613,
		3,
		1276,
		nil,
		1,
		0
	},
	[40613004] = {
		40613004,
		0,
		Lang.get(108838),
		40613,
		4,
		1276,
		nil,
		1,
		0
	},
	[40613005] = {
		40613005,
		3,
		Lang.get(108839),
		40613,
		5,
		605,
		[22] = 1
	},
	[40613006] = {
		40613006,
		0,
		Lang.get(108840),
		40613,
		6,
		1278,
		nil,
		1,
		0
	},
	[40613007] = {
		40613007,
		3,
		Lang.get(108841),
		40613,
		7,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40666,
		[19] = 40666,
		[22] = 1
	},
	[40613008] = {
		40613008,
		0,
		Lang.get(108842),
		40613,
		8,
		1276,
		nil,
		1,
		0
	},
	[40613009] = {
		40613009,
		0,
		Lang.get(108843),
		40613,
		9,
		1276,
		nil,
		1
	},
	[40613010] = {
		40613010,
		0,
		Lang.get(108844),
		40613,
		10,
		1278,
		nil,
		1
	},
	[40613011] = {
		40613011,
		0,
		Lang.get(108845),
		40613,
		11,
		1276,
		nil,
		1
	},
	[40613012] = {
		40613012,
		0,
		Lang.get(66037),
		40613,
		12,
		1278,
		nil,
		1
	},
	[40613013] = {
		40613013,
		0,
		Lang.get(108846),
		40613,
		13,
		1276,
		nil,
		1
	},
	[40613014] = {
		40613014,
		0,
		Lang.get(108847),
		40613,
		14,
		1278,
		nil,
		1
	},
	[40613015] = {
		40613015,
		3,
		Lang.get(108848),
		40613,
		15,
		605,
		[22] = 1
	},
	[40613016] = {
		40613016,
		0,
		Lang.get(108849),
		40613,
		16,
		1276,
		nil,
		1
	},
	[40613017] = {
		40613017,
		0,
		Lang.get(108850),
		40613,
		17,
		1278,
		nil,
		1
	},
	[40613018] = {
		40613018,
		0,
		Lang.get(108851),
		40613,
		18,
		1276,
		nil,
		1
	},
	[40613019] = {
		40613019,
		4,
		nil,
		40613,
		19,
		1278,
		[29] = {
			{
				id = 40613020,
				branch_content = Lang.get(108852)
			},
			{
				id = 40613020,
				branch_content = Lang.get(108853)
			}
		}
	},
	[40613020] = {
		40613020,
		0,
		Lang.get(108854),
		40613,
		20,
		1276,
		nil,
		1
	},
	[40613021] = {
		40613021,
		0,
		Lang.get(108855),
		40613,
		21,
		1278,
		nil,
		1
	},
	[40613022] = {
		40613022,
		0,
		Lang.get(108856),
		40613,
		22,
		1276,
		nil,
		1
	},
	[40613023] = {
		40613023,
		0,
		Lang.get(108857),
		40613,
		23,
		1276,
		nil,
		1
	},
	[40613024] = {
		40613024,
		0,
		Lang.get(108858),
		40613,
		24,
		1276,
		nil,
		1
	},
	[40613025] = {
		40613025,
		0,
		Lang.get(108859),
		40613,
		25,
		1276,
		nil,
		1
	},
	[40613026] = {
		40613026,
		0,
		Lang.get(108860),
		40613,
		26,
		1278,
		nil,
		1
	},
	[40613027] = {
		40613027,
		0,
		Lang.get(108861),
		40613,
		27,
		1276,
		nil,
		1
	},
	[40613028] = {
		40613028,
		0,
		Lang.get(108862),
		40613,
		28,
		1276,
		nil,
		1
	},
	[40613029] = {
		40613029,
		0,
		Lang.get(108863),
		40613,
		29,
		1276,
		nil,
		1
	},
	[40613030] = {
		40613030,
		3,
		Lang.get(108864),
		40613,
		30,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		[22] = 1
	},
	[40613031] = {
		40613031,
		0,
		Lang.get(108865),
		40613,
		31,
		1276,
		{
			RTResTalkAction[95]
		},
		1,
		0,
		3,
		nil,
		nil,
		40667,
		nil,
		nil,
		nil,
		nil,
		nil,
		40667,
		220
	},
	[40613032] = {
		40613032,
		0,
		Lang.get(108866),
		40613,
		32,
		1276,
		{
			RTResTalkAction[95]
		},
		1,
		0
	},
	[40613033] = {
		40613033,
		0,
		Lang.get(108867),
		40613,
		33,
		1276,
		{
			RTResTalkAction[95]
		},
		1,
		0
	},
	[40613034] = {
		40613034,
		0,
		Lang.get(108868),
		40613,
		34,
		1278,
		{
			RTResTalkAction[95]
		},
		1,
		0
	},
	[40613035] = {
		40613035,
		0,
		Lang.get(108869),
		40613,
		35,
		1276,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		},
		1,
		0
	},
	[40613036] = {
		40613036,
		0,
		Lang.get(108870),
		40613,
		36,
		1276,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		},
		1,
		0
	},
	[40613037] = {
		40613037,
		0,
		Lang.get(108871),
		40613,
		37,
		1276,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		},
		1,
		0
	},
	[40613038] = {
		40613038,
		0,
		Lang.get(108872),
		40613,
		38,
		1276,
		{
			RTResTalkAction[95],
			RTResTalkAction[98]
		},
		1,
		0,
		nil,
		nil,
		nil,
		40668,
		nil,
		nil,
		nil,
		nil,
		nil,
		40668
	},
	[40613039] = {
		40613039,
		0,
		Lang.get(108873),
		40613,
		39,
		1276,
		{
			RTResTalkAction[99]
		},
		1,
		0,
		[20] = -1
	},
	[40613040] = {
		40613040,
		3,
		Lang.get(108874),
		40613,
		40,
		605,
		[22] = 1
	},
	[40613041] = {
		40613041,
		0,
		Lang.get(108875),
		40613,
		41,
		1276,
		nil,
		1
	},
	[40613042] = {
		40613042,
		0,
		Lang.get(108876),
		40613,
		42,
		1276,
		nil,
		1
	},
	[40613043] = {
		40613043,
		0,
		Lang.get(108877),
		40613,
		43,
		1276,
		nil,
		1
	},
	[40613044] = {
		40613044,
		3,
		Lang.get(108878),
		40613,
		44,
		605,
		[22] = 1
	},
	[40613045] = {
		40613045,
		0,
		Lang.get(108879),
		40613,
		45,
		1278,
		nil,
		1
	},
	[40613046] = {
		40613046,
		0,
		Lang.get(108880),
		40613,
		46,
		1276,
		nil,
		1
	},
	[40613047] = {
		40613047,
		0,
		Lang.get(108881),
		40613,
		47,
		1278,
		nil,
		1,
		nil,
		nil,
		nil,
		114
	},
	[40613048] = {
		40613048,
		0,
		Lang.get(108882),
		40613,
		48,
		1276,
		nil,
		1
	},
	[40613049] = {
		40613049,
		0,
		Lang.get(108883),
		40613,
		49,
		1278,
		nil,
		1
	},
	[40613050] = {
		40613050,
		0,
		Lang.get(108884),
		40613,
		50,
		1278,
		nil,
		1
	},
	[40613051] = {
		40613051,
		0,
		Lang.get(108885),
		40613,
		51,
		1276,
		nil,
		1
	},
	[40613052] = {
		40613052,
		0,
		Lang.get(108886),
		40613,
		52,
		1276,
		nil,
		1,
		0
	},
	[40613053] = {
		40613053,
		4,
		nil,
		40613,
		53,
		1278,
		[29] = {
			{
				id = 40613054,
				branch_content = Lang.get(108887)
			},
			{
				id = 40613054,
				branch_content = Lang.get(108888)
			}
		}
	},
	[40613054] = {
		40613054,
		0,
		Lang.get(108889),
		40613,
		54,
		1276,
		nil,
		1,
		3
	},
	[40613055] = {
		40613055,
		3,
		Lang.get(108890),
		40613,
		55,
		605,
		[22] = 1
	},
	[40613056] = {
		40613056,
		0,
		Lang.get(108891),
		40613,
		56,
		1276,
		nil,
		1,
		3
	},
	[40613057] = {
		40613057,
		3,
		Lang.get(108892),
		40613,
		57,
		605,
		[22] = 1
	},
	[40614001] = {
		40614001,
		0,
		Lang.get(108893),
		40614,
		1,
		1276,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		40670,
		nil,
		nil,
		nil,
		nil,
		nil,
		40670,
		255
	},
	[40614002] = {
		40614002,
		0,
		Lang.get(108894),
		40614,
		2,
		1276,
		nil,
		1,
		0
	},
	[40614003] = {
		40614003,
		3,
		Lang.get(108895),
		40614,
		3,
		605,
		{
			RTResTalkAction[11]
		},
		[20] = -1,
		[21] = 1276,
		[22] = 1
	},
	[40614004] = {
		40614004,
		0,
		Lang.get(108896),
		40614,
		4,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40614005] = {
		40614005,
		3,
		Lang.get(108897),
		40614,
		5,
		605,
		{
			RTResTalkAction[16]
		},
		[21] = 1276,
		[22] = 1
	},
	[40614006] = {
		40614006,
		0,
		Lang.get(108898),
		40614,
		6,
		1278,
		{
			RTResTalkAction[100],
			RTResTalkAction[22]
		}
	},
	[40614007] = {
		40614007,
		0,
		Lang.get(108899),
		40614,
		7,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614008] = {
		40614008,
		0,
		Lang.get(108900),
		40614,
		8,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[23]
		}
	},
	[40614009] = {
		40614009,
		0,
		Lang.get(108901),
		40614,
		9,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614010] = {
		40614010,
		0,
		Lang.get(20681),
		40614,
		10,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614011] = {
		40614011,
		0,
		Lang.get(108902),
		40614,
		11,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614012] = {
		40614012,
		0,
		Lang.get(108903),
		40614,
		12,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614013] = {
		40614013,
		0,
		Lang.get(108904),
		40614,
		13,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[101]
		}
	},
	[40614014] = {
		40614014,
		0,
		Lang.get(108905),
		40614,
		14,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614015] = {
		40614015,
		0,
		Lang.get(108906),
		40614,
		15,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40614016] = {
		40614016,
		0,
		Lang.get(108907),
		40614,
		16,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[40614017] = {
		40614017,
		4,
		nil,
		40614,
		17,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40614018,
				branch_content = Lang.get(108908)
			},
			{
				id = 40614018,
				branch_content = Lang.get(108909)
			}
		}
	},
	[40614018] = {
		40614018,
		0,
		Lang.get(108910),
		40614,
		18,
		1276,
		{
			RTResTalkAction[13]
		}
	},
	[40614019] = {
		40614019,
		3,
		Lang.get(108911),
		40614,
		19,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3,
		nil,
		122,
		40671,
		1,
		1,
		nil,
		1,
		nil,
		40671,
		nil,
		nil,
		1
	},
	[40614020] = {
		40614020,
		0,
		Lang.get(108912),
		40614,
		20,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40614021] = {
		40614021,
		0,
		Lang.get(21987),
		40614,
		21,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614022] = {
		40614022,
		0,
		Lang.get(108913),
		40614,
		22,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614023] = {
		40614023,
		0,
		Lang.get(108914),
		40614,
		23,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614024] = {
		40614024,
		0,
		Lang.get(108915),
		40614,
		24,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614025] = {
		40614025,
		3,
		Lang.get(108916),
		40614,
		25,
		605,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[40614026] = {
		40614026,
		0,
		Lang.get(108917),
		40614,
		26,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614027] = {
		40614027,
		0,
		Lang.get(108918),
		40614,
		27,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614028] = {
		40614028,
		0,
		Lang.get(108919),
		40614,
		28,
		1276,
		{
			RTResTalkAction[27],
			RTResTalkAction[2]
		}
	},
	[40614029] = {
		40614029,
		0,
		Lang.get(108920),
		40614,
		29,
		127,
		{
			RTResTalkAction[102],
			RTResTalkAction[12]
		}
	},
	[40614030] = {
		40614030,
		3,
		Lang.get(108921),
		40614,
		30,
		605,
		{
			RTResTalkAction[103]
		},
		[22] = 1
	},
	[40614031] = {
		40614031,
		0,
		Lang.get(108922),
		40614,
		31,
		1276,
		{
			RTResTalkAction[104]
		}
	},
	[40614032] = {
		40614032,
		0,
		Lang.get(108923),
		40614,
		32,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[40614033] = {
		40614033,
		0,
		Lang.get(108924),
		40614,
		33,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[35]
		}
	},
	[40614034] = {
		40614034,
		0,
		Lang.get(19557),
		40614,
		34,
		1276,
		{
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[40614035] = {
		40614035,
		3,
		Lang.get(108925),
		40614,
		35,
		605,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		},
		[21] = 1276,
		[22] = 1
	},
	[40614036] = {
		40614036,
		0,
		Lang.get(108926),
		40614,
		36,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40614037] = {
		40614037,
		0,
		Lang.get(108927),
		40614,
		37,
		1195,
		{
			RTResTalkAction[105],
			RTResTalkAction[12]
		}
	},
	[40614038] = {
		40614038,
		0,
		Lang.get(108928),
		40614,
		38,
		1195,
		{
			RTResTalkAction[106]
		}
	},
	[40614039] = {
		40614039,
		0,
		Lang.get(108929),
		40614,
		39,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[107]
		}
	},
	[40614040] = {
		40614040,
		0,
		Lang.get(108930),
		40614,
		40,
		1118,
		{
			RTResTalkAction[108],
			RTResTalkAction[12]
		}
	},
	[40614041] = {
		40614041,
		0,
		Lang.get(11617),
		40614,
		41,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[109]
		}
	},
	[40614042] = {
		40614042,
		0,
		Lang.get(108931),
		40614,
		42,
		1118,
		{
			RTResTalkAction[110],
			RTResTalkAction[12]
		}
	},
	[40614043] = {
		40614043,
		0,
		Lang.get(108932),
		40614,
		43,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[109]
		}
	},
	[40614044] = {
		40614044,
		5,
		Lang.get(17492),
		40614,
		44,
		1118,
		{
			RTResTalkAction[111],
			RTResTalkAction[12]
		}
	},
	[40614045] = {
		40614045,
		3,
		Lang.get(108933),
		40614,
		45,
		605,
		{
			RTResTalkAction[56],
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[21] = 1276,
		[22] = 1
	},
	[40614046] = {
		40614046,
		5,
		Lang.get(108934),
		40614,
		46,
		167,
		{
			RTResTalkAction[112],
			RTResTalkAction[12]
		}
	},
	[40614047] = {
		40614047,
		0,
		"……！",
		40614,
		47,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[113]
		}
	},
	[40614048] = {
		40614048,
		0,
		Lang.get(108935),
		40614,
		48,
		1195,
		{
			RTResTalkAction[106],
			RTResTalkAction[12]
		}
	},
	[40614049] = {
		40614049,
		0,
		Lang.get(108936),
		40614,
		49,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[107]
		}
	},
	[40614050] = {
		40614050,
		3,
		Lang.get(108937),
		40614,
		50,
		605,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		5001,
		[22] = 1
	},
	[40614051] = {
		40614051,
		0,
		Lang.get(108938),
		40614,
		51,
		1118,
		{
			RTResTalkAction[114]
		}
	},
	[40614052] = {
		40614052,
		0,
		Lang.get(108939),
		40614,
		52,
		167,
		{
			RTResTalkAction[115],
			RTResTalkAction[109]
		}
	},
	[40614053] = {
		40614053,
		0,
		Lang.get(108940),
		40614,
		53,
		1276,
		{
			RTResTalkAction[14],
			RTResTalkAction[113]
		}
	},
	[40614054] = {
		40614054,
		0,
		Lang.get(108941),
		40614,
		54,
		1118,
		{
			RTResTalkAction[116],
			RTResTalkAction[22]
		}
	},
	[40615001] = {
		40615001,
		3,
		Lang.get(108747),
		40615,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		193,
		40675,
		[19] = 40675,
		[22] = 1
	},
	[40615002] = {
		40615002,
		0,
		Lang.get(108942),
		40615,
		2,
		167,
		nil,
		1,
		0
	},
	[40615003] = {
		40615003,
		0,
		Lang.get(108943),
		40615,
		3,
		1195,
		nil,
		1,
		2
	},
	[40615004] = {
		40615004,
		0,
		Lang.get(108944),
		40615,
		4,
		1118,
		nil,
		1,
		1
	},
	[40615005] = {
		40615005,
		3,
		Lang.get(108945),
		40615,
		5,
		605,
		[22] = 1
	},
	[40615006] = {
		40615006,
		4,
		nil,
		40615,
		6,
		1278,
		[29] = {
			{
				id = 40615007,
				branch_content = Lang.get(108946)
			},
			{
				id = 40615007,
				branch_content = Lang.get(108947)
			}
		}
	},
	[40615007] = {
		40615007,
		3,
		Lang.get(108948),
		40615,
		7,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1
	},
	[40615008] = {
		40615008,
		0,
		Lang.get(108949),
		40615,
		8,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40615009] = {
		40615009,
		0,
		Lang.get(108950),
		40615,
		9,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40615010] = {
		40615010,
		0,
		Lang.get(108951),
		40615,
		10,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40615011] = {
		40615011,
		0,
		Lang.get(108952),
		40615,
		11,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40615012] = {
		40615012,
		3,
		Lang.get(108953),
		40615,
		12,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40615013] = {
		40615013,
		0,
		Lang.get(108954),
		40615,
		13,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40615014] = {
		40615014,
		0,
		Lang.get(108955),
		40615,
		14,
		1195,
		{
			RTResTalkAction[117],
			RTResTalkAction[12]
		}
	},
	[40615015] = {
		40615015,
		0,
		Lang.get(108956),
		40615,
		15,
		1276,
		{
			RTResTalkAction[14],
			RTResTalkAction[107]
		}
	},
	[40615016] = {
		40615016,
		0,
		Lang.get(108957),
		40615,
		16,
		1118,
		{
			RTResTalkAction[108],
			RTResTalkAction[12]
		}
	},
	[40615017] = {
		40615017,
		0,
		Lang.get(108958),
		40615,
		17,
		1276,
		{
			RTResTalkAction[15],
			RTResTalkAction[109]
		}
	},
	[40615018] = {
		40615018,
		0,
		Lang.get(108959),
		40615,
		18,
		1276,
		{
			RTResTalkAction[20]
		}
	},
	[40615019] = {
		40615019,
		3,
		Lang.get(108960),
		40615,
		19,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3,
		2756,
		nil,
		40676,
		1,
		1,
		nil,
		1,
		nil,
		40676,
		nil,
		nil,
		1
	},
	[40615020] = {
		40615020,
		0,
		Lang.get(108961),
		40615,
		20,
		1233,
		nil,
		1,
		0
	},
	[40615021] = {
		40615021,
		0,
		Lang.get(108962),
		40615,
		21,
		1278,
		nil,
		1,
		0
	},
	[40615022] = {
		40615022,
		0,
		Lang.get(108963),
		40615,
		22,
		1233,
		nil,
		1,
		0
	},
	[40615023] = {
		40615023,
		0,
		Lang.get(108964),
		40615,
		23,
		1118,
		nil,
		1,
		1
	},
	[40615024] = {
		40615024,
		0,
		Lang.get(108965),
		40615,
		24,
		1276,
		nil,
		1,
		0
	},
	[40615025] = {
		40615025,
		3,
		Lang.get(108966),
		40615,
		25,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		63,
		40677,
		1,
		1,
		nil,
		1,
		nil,
		40677,
		240,
		nil,
		1
	},
	[40615026] = {
		40615026,
		9,
		Lang.get(108967),
		40615,
		26,
		605,
		nil,
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40615027] = {
		40615027,
		9,
		Lang.get(108968),
		40615,
		27,
		605,
		[22] = 1
	},
	[40615028] = {
		40615028,
		9,
		Lang.get(108969),
		40615,
		28,
		605,
		[22] = 1
	},
	[40615029] = {
		40615029,
		9,
		Lang.get(108970),
		40615,
		29,
		605,
		[22] = 1
	},
	[40616001] = {
		40616001,
		9,
		Lang.get(108971),
		40616,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		5003,
		63,
		40680,
		nil,
		nil,
		nil,
		nil,
		nil,
		40680,
		nil,
		nil,
		1
	},
	[40616002] = {
		40616002,
		9,
		Lang.get(108972),
		40616,
		2,
		605,
		[22] = 1
	},
	[40616003] = {
		40616003,
		0,
		Lang.get(108973),
		40616,
		3,
		1118,
		nil,
		1,
		3
	},
	[40616004] = {
		40616004,
		0,
		Lang.get(108974),
		40616,
		4,
		1195,
		nil,
		1,
		3
	},
	[40616005] = {
		40616005,
		0,
		Lang.get(108975),
		40616,
		5,
		1276,
		nil,
		1,
		0
	},
	[40616006] = {
		40616006,
		0,
		Lang.get(108976),
		40616,
		6,
		1276,
		nil,
		1,
		0
	},
	[40616007] = {
		40616007,
		0,
		Lang.get(108977),
		40616,
		7,
		1278,
		nil,
		1,
		0
	},
	[40616008] = {
		40616008,
		0,
		Lang.get(108978),
		40616,
		8,
		1118,
		{
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[40616009] = {
		40616009,
		0,
		Lang.get(108979),
		40616,
		9,
		1118,
		{
			RTResTalkAction[110]
		}
	},
	[40616010] = {
		40616010,
		0,
		Lang.get(108980),
		40616,
		10,
		1276,
		{
			RTResTalkAction[11],
			RTResTalkAction[109]
		}
	},
	[40616011] = {
		40616011,
		0,
		Lang.get(108981),
		40616,
		11,
		1118,
		{
			RTResTalkAction[118],
			RTResTalkAction[12]
		}
	},
	[40616012] = {
		40616012,
		4,
		nil,
		40616,
		12,
		1278,
		{
			RTResTalkAction[109]
		},
		[29] = {
			{
				id = 40616013,
				branch_content = Lang.get(108982)
			},
			{
				id = 40616013,
				branch_content = Lang.get(108983)
			}
		}
	},
	[40616013] = {
		40616013,
		0,
		Lang.get(108984),
		40616,
		13,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40616014] = {
		40616014,
		3,
		Lang.get(108985),
		40616,
		14,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40616015] = {
		40616015,
		0,
		Lang.get(108986),
		40616,
		15,
		1276,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		163
	},
	[40616016] = {
		40616016,
		0,
		Lang.get(108987),
		40616,
		16,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40616017] = {
		40616017,
		0,
		Lang.get(108988),
		40616,
		17,
		1118,
		{
			RTResTalkAction[119],
			RTResTalkAction[22]
		}
	},
	[40616018] = {
		40616018,
		0,
		Lang.get(108989),
		40616,
		18,
		1118,
		{
			RTResTalkAction[110],
			RTResTalkAction[12]
		}
	},
	[40616019] = {
		40616019,
		0,
		Lang.get(108990),
		40616,
		19,
		1195,
		{
			RTResTalkAction[120],
			RTResTalkAction[109]
		}
	},
	[40616020] = {
		40616020,
		0,
		Lang.get(108991),
		40616,
		20,
		1118,
		{
			RTResTalkAction[121],
			RTResTalkAction[107]
		}
	},
	[40616021] = {
		40616021,
		0,
		Lang.get(108868),
		40616,
		21,
		1278,
		{
			RTResTalkAction[122],
			RTResTalkAction[109]
		}
	},
	[40616022] = {
		40616022,
		0,
		Lang.get(108992),
		40616,
		22,
		1276,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		}
	},
	[40616023] = {
		40616023,
		0,
		Lang.get(108993),
		40616,
		23,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40616024] = {
		40616024,
		4,
		nil,
		40616,
		24,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		},
		[29] = {
			{
				id = 40616025,
				branch_content = Lang.get(108994)
			}
		}
	},
	[40616025] = {
		40616025,
		0,
		Lang.get(108995),
		40616,
		25,
		1276,
		{
			RTResTalkAction[20],
			RTResTalkAction[2]
		}
	},
	[40616026] = {
		40616026,
		3,
		Lang.get(108996),
		40616,
		26,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40617001] = {
		40617001,
		3,
		Lang.get(108997),
		40617,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		2751,
		nil,
		40685,
		nil,
		nil,
		nil,
		nil,
		nil,
		40685,
		240,
		nil,
		1
	},
	[40617002] = {
		40617002,
		0,
		Lang.get(108998),
		40617,
		2,
		770,
		nil,
		1,
		0,
		nil,
		nil,
		189,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[40617003] = {
		40617003,
		0,
		Lang.get(108999),
		40617,
		3,
		1276,
		nil,
		1,
		0
	},
	[40617004] = {
		40617004,
		9,
		Lang.get(109000),
		40617,
		4,
		605,
		nil,
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40617005] = {
		40617005,
		3,
		Lang.get(109001),
		40617,
		5,
		605,
		[22] = 1
	},
	[40617006] = {
		40617006,
		0,
		Lang.get(19561),
		40617,
		6,
		1276,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[40617007] = {
		40617007,
		3,
		Lang.get(109002),
		40617,
		7,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40617008] = {
		40617008,
		0,
		Lang.get(109003),
		40617,
		8,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40617009] = {
		40617009,
		0,
		Lang.get(109004),
		40617,
		9,
		770,
		{
			RTResTalkAction[123],
			RTResTalkAction[12]
		}
	},
	[40617010] = {
		40617010,
		0,
		Lang.get(90249),
		40617,
		10,
		770,
		{
			RTResTalkAction[124]
		},
		1,
		0,
		-1,
		nil,
		nil,
		40686,
		1,
		1,
		nil,
		nil,
		nil,
		40686,
		100
	},
	[40617011] = {
		40617011,
		3,
		Lang.get(109005),
		40617,
		11,
		605,
		[22] = 1
	},
	[40617012] = {
		40617012,
		0,
		Lang.get(109006),
		40617,
		12,
		1276,
		nil,
		1,
		0
	},
	[40617013] = {
		40617013,
		0,
		Lang.get(109007),
		40617,
		13,
		770,
		nil,
		1,
		0
	},
	[40617014] = {
		40617014,
		0,
		Lang.get(109008),
		40617,
		14,
		770,
		nil,
		1,
		0
	},
	[40617015] = {
		40617015,
		0,
		Lang.get(109009),
		40617,
		15,
		1276,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40687,
		nil,
		nil,
		nil,
		1,
		nil,
		40687,
		-1
	},
	[40617016] = {
		40617016,
		0,
		Lang.get(109010),
		40617,
		16,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[40617017] = {
		40617017,
		0,
		"……",
		40617,
		17,
		1276,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40617018] = {
		40617018,
		0,
		Lang.get(109011),
		40617,
		18,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[128]
		}
	},
	[40617019] = {
		40617019,
		0,
		Lang.get(109012),
		40617,
		19,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40617020] = {
		40617020,
		0,
		Lang.get(109013),
		40617,
		20,
		1276,
		{
			RTResTalkAction[129],
			RTResTalkAction[127]
		}
	},
	[40617021] = {
		40617021,
		0,
		Lang.get(109014),
		40617,
		21,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[130]
		}
	},
	[40617022] = {
		40617022,
		3,
		Lang.get(109015),
		40617,
		22,
		605,
		{
			RTResTalkAction[123],
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		2763,
		148,
		[22] = 1
	},
	[40617023] = {
		40617023,
		3,
		Lang.get(109016),
		40617,
		23,
		605,
		{
			RTResTalkAction[131],
			RTResTalkAction[127]
		},
		[22] = 1
	},
	[40617024] = {
		40617024,
		3,
		Lang.get(109017),
		40617,
		24,
		605,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		},
		[22] = 1
	},
	[40617025] = {
		40617025,
		3,
		Lang.get(109018),
		40617,
		25,
		605,
		{
			RTResTalkAction[132],
			RTResTalkAction[130]
		},
		nil,
		nil,
		nil,
		2747,
		[22] = 1
	},
	[40617026] = {
		40617026,
		0,
		Lang.get(109019),
		40617,
		26,
		1276,
		{
			RTResTalkAction[14],
			RTResTalkAction[124]
		}
	},
	[40617027] = {
		40617027,
		0,
		Lang.get(109020),
		40617,
		27,
		770,
		{
			RTResTalkAction[133],
			RTResTalkAction[130]
		}
	},
	[40617028] = {
		40617028,
		5,
		Lang.get(68486),
		40617,
		28,
		1276,
		{
			RTResTalkAction[134],
			RTResTalkAction[127]
		}
	},
	[40803001] = {
		40803001,
		3,
		Lang.get(109021),
		40803,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		40688,
		[19] = 40688,
		[22] = 1
	},
	[40803002] = {
		40803002,
		0,
		Lang.get(109022),
		40803,
		2,
		1195,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3
	},
	[40803003] = {
		40803003,
		0,
		Lang.get(109023),
		40803,
		3,
		1233,
		{
			RTResTalkAction[107]
		},
		1,
		0
	},
	[40803004] = {
		40803004,
		0,
		Lang.get(109024),
		40803,
		4,
		1118,
		{
			RTResTalkAction[135]
		}
	},
	[40803005] = {
		40803005,
		0,
		Lang.get(109025),
		40803,
		5,
		677,
		{
			RTResTalkAction[136],
			RTResTalkAction[109]
		}
	},
	[40803006] = {
		40803006,
		3,
		Lang.get(109026),
		40803,
		6,
		605,
		{
			RTResTalkAction[137]
		},
		[21] = 677,
		[22] = 1
	},
	[40803007] = {
		40803007,
		0,
		Lang.get(109027),
		40803,
		7,
		677,
		{
			RTResTalkAction[44]
		}
	},
	[40803008] = {
		40803008,
		4,
		nil,
		40803,
		8,
		1278,
		{
			RTResTalkAction[44]
		},
		[29] = {
			{
				id = 40803009,
				branch_content = Lang.get(109028)
			},
			{
				id = 40803009,
				branch_content = Lang.get(109029)
			}
		}
	},
	[40803009] = {
		40803009,
		3,
		Lang.get(109030),
		40803,
		9,
		605,
		{
			RTResTalkAction[46]
		},
		[22] = 1
	},
	[40803010] = {
		40803010,
		0,
		Lang.get(109031),
		40803,
		10,
		1195,
		{
			RTResTalkAction[117]
		}
	},
	[40803011] = {
		40803011,
		0,
		Lang.get(109032),
		40803,
		11,
		1281,
		{
			RTResTalkAction[138],
			RTResTalkAction[107]
		},
		nil,
		nil,
		nil,
		nil,
		204
	},
	[40803012] = {
		40803012,
		0,
		"？",
		40803,
		12,
		1278,
		{
			RTResTalkAction[122],
			RTResTalkAction[29]
		}
	},
	[40803013] = {
		40803013,
		0,
		Lang.get(109033),
		40803,
		13,
		1281,
		{
			RTResTalkAction[17],
			RTResTalkAction[2]
		},
		1,
		0,
		[21] = 432
	},
	[40803014] = {
		40803014,
		0,
		Lang.get(109034),
		40803,
		14,
		1281,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40803015] = {
		40803015,
		0,
		Lang.get(109035),
		40803,
		15,
		1278,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40803016] = {
		40803016,
		0,
		Lang.get(109036),
		40803,
		16,
		1278,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40803017] = {
		40803017,
		0,
		Lang.get(109037),
		40803,
		17,
		1281,
		{
			RTResTalkAction[17]
		},
		1,
		0,
		[21] = 432
	},
	[40803018] = {
		40803018,
		3,
		Lang.get(109038),
		40803,
		18,
		605,
		{
			RTResTalkAction[19]
		},
		[22] = 1
	},
	[40803019] = {
		40803019,
		0,
		Lang.get(109039),
		40803,
		19,
		1118,
		{
			RTResTalkAction[108]
		}
	},
	[40803020] = {
		40803020,
		0,
		Lang.get(109040),
		40803,
		20,
		1118,
		{
			RTResTalkAction[110]
		}
	},
	[40803021] = {
		40803021,
		3,
		Lang.get(109041),
		40803,
		21,
		605,
		{
			RTResTalkAction[109]
		},
		[22] = 1
	},
	[40803022] = {
		40803022,
		0,
		"……！",
		40803,
		22,
		1278,
		{
			RTResTalkAction[139]
		}
	},
	[40803023] = {
		40803023,
		4,
		nil,
		40803,
		23,
		1278,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 40803024,
				branch_content = Lang.get(109042)
			}
		}
	},
	[40803024] = {
		40803024,
		0,
		Lang.get(109043),
		40803,
		24,
		1118,
		{
			RTResTalkAction[140],
			RTResTalkAction[2]
		}
	},
	[40803025] = {
		40803025,
		0,
		Lang.get(109044),
		40803,
		25,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[40803026] = {
		40803026,
		3,
		Lang.get(109045),
		40803,
		26,
		605,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		},
		[22] = 1
	},
	[40803027] = {
		40803027,
		0,
		Lang.get(109046),
		40803,
		27,
		1278,
		{
			RTResTalkAction[21],
			RTResTalkAction[141]
		}
	},
	[40803028] = {
		40803028,
		0,
		Lang.get(22381),
		40803,
		28,
		1118,
		{
			RTResTalkAction[21],
			RTResTalkAction[142]
		}
	},
	[40803029] = {
		40803029,
		3,
		Lang.get(109047),
		40803,
		29,
		605,
		{
			RTResTalkAction[2],
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		5004,
		[22] = 1,
		[20] = 200
	},
	[40618001] = {
		40618001,
		3,
		Lang.get(109048),
		40618,
		1,
		605,
		{
			RTResTalkAction[133],
			RTResTalkAction[127]
		},
		nil,
		nil,
		3,
		nil,
		57,
		40690,
		nil,
		nil,
		nil,
		nil,
		nil,
		40690,
		nil,
		770,
		1
	},
	[40618002] = {
		40618002,
		0,
		Lang.get(109049),
		40618,
		2,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40618003] = {
		40618003,
		0,
		Lang.get(109050),
		40618,
		3,
		1276,
		{
			RTResTalkAction[134],
			RTResTalkAction[127]
		}
	},
	[40618004] = {
		40618004,
		0,
		Lang.get(109051),
		40618,
		4,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40618005] = {
		40618005,
		0,
		Lang.get(109052),
		40618,
		5,
		1276,
		{
			RTResTalkAction[133],
			RTResTalkAction[127]
		}
	},
	[40618006] = {
		40618006,
		0,
		Lang.get(109053),
		40618,
		6,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40618007] = {
		40618007,
		0,
		Lang.get(109054),
		40618,
		7,
		1276,
		{
			RTResTalkAction[133],
			RTResTalkAction[127]
		}
	},
	[40618008] = {
		40618008,
		0,
		Lang.get(109055),
		40618,
		8,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[143]
		}
	},
	[40618009] = {
		40618009,
		3,
		Lang.get(109056),
		40618,
		9,
		605,
		{
			RTResTalkAction[132],
			RTResTalkAction[127]
		},
		[22] = 1
	},
	[40618010] = {
		40618010,
		0,
		Lang.get(109057),
		40618,
		10,
		1276,
		{
			RTResTalkAction[144],
			RTResTalkAction[127]
		}
	},
	[40618011] = {
		40618011,
		0,
		Lang.get(109058),
		40618,
		11,
		1276,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40618012] = {
		40618012,
		0,
		Lang.get(109059),
		40618,
		12,
		1276,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40618013] = {
		40618013,
		9,
		Lang.get(109060),
		40618,
		13,
		605,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		},
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40618014] = {
		40618014,
		0,
		Lang.get(109061),
		40618,
		14,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[145]
		}
	},
	[40618015] = {
		40618015,
		3,
		Lang.get(109062),
		40618,
		15,
		605,
		{
			RTResTalkAction[12],
			RTResTalkAction[124]
		},
		nil,
		nil,
		nil,
		2763,
		[22] = 1
	},
	[40618016] = {
		40618016,
		5,
		"……！！！",
		40618,
		16,
		1276,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		194
	},
	[40618017] = {
		40618017,
		3,
		Lang.get(109063),
		40618,
		17,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		40691,
		1,
		1,
		nil,
		1,
		nil,
		40691,
		nil,
		nil,
		1
	},
	[40618018] = {
		40618018,
		0,
		Lang.get(109064),
		40618,
		18,
		1278,
		nil,
		1,
		0
	},
	[40618019] = {
		40618019,
		3,
		Lang.get(109065),
		40618,
		19,
		605,
		[22] = 1
	},
	[40618020] = {
		40618020,
		0,
		Lang.get(20681),
		40618,
		20,
		1276,
		{
			RTResTalkAction[15]
		},
		1,
		0
	},
	[40618021] = {
		40618021,
		0,
		"……",
		40618,
		21,
		1278,
		{
			RTResTalkAction[3],
			RTResTalkAction[12]
		}
	},
	[40618022] = {
		40618022,
		3,
		Lang.get(109066),
		40618,
		22,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[40618023] = {
		40618023,
		0,
		Lang.get(109067),
		40618,
		23,
		770,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40692,
		1,
		1,
		nil,
		1,
		nil,
		40692
	},
	[40618024] = {
		40618024,
		3,
		Lang.get(109068),
		40618,
		24,
		605,
		{
			RTResTalkAction[11],
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40618025] = {
		40618025,
		3,
		Lang.get(109069),
		40618,
		25,
		605,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		114,
		[22] = 1
	},
	[40618026] = {
		40618026,
		3,
		Lang.get(109070),
		40618,
		26,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40618027] = {
		40618027,
		0,
		Lang.get(109071),
		40618,
		27,
		1276,
		{
			RTResTalkAction[146]
		}
	},
	[40618028] = {
		40618028,
		0,
		Lang.get(109072),
		40618,
		28,
		770,
		{
			RTResTalkAction[147],
			RTResTalkAction[12]
		}
	},
	[40618029] = {
		40618029,
		3,
		Lang.get(109073),
		40618,
		29,
		605,
		{
			RTResTalkAction[124]
		},
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40618030] = {
		40618030,
		3,
		Lang.get(109074),
		40618,
		30,
		605,
		[22] = 1
	},
	[40618031] = {
		40618031,
		0,
		Lang.get(109075),
		40618,
		31,
		1276,
		{
			RTResTalkAction[146]
		}
	},
	[40618032] = {
		40618032,
		3,
		Lang.get(109076),
		40618,
		32,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40618033] = {
		40618033,
		9,
		Lang.get(109077),
		40618,
		33,
		605,
		nil,
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40618034] = {
		40618034,
		0,
		Lang.get(89578),
		40618,
		34,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40618035] = {
		40618035,
		3,
		Lang.get(109078),
		40618,
		35,
		605,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		nil,
		2763,
		[22] = 1
	},
	[40618036] = {
		40618036,
		3,
		Lang.get(109079),
		40618,
		36,
		605,
		{
			RTResTalkAction[123]
		},
		[22] = 1
	},
	[40618037] = {
		40618037,
		0,
		Lang.get(109080),
		40618,
		37,
		1276,
		{
			RTResTalkAction[148],
			RTResTalkAction[124]
		}
	},
	[40618038] = {
		40618038,
		3,
		Lang.get(109081),
		40618,
		38,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40802001] = {
		40802001,
		3,
		Lang.get(109082),
		40802,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		206,
		40695,
		nil,
		nil,
		nil,
		nil,
		nil,
		40695,
		nil,
		nil,
		1
	},
	[40802002] = {
		40802002,
		0,
		Lang.get(109083),
		40802,
		2,
		770,
		{
			RTResTalkAction[149],
			RTResTalkAction[127]
		}
	},
	[40802003] = {
		40802003,
		0,
		Lang.get(109084),
		40802,
		3,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40802004] = {
		40802004,
		9,
		Lang.get(109085),
		40802,
		4,
		605,
		{
			RTResTalkAction[12],
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40802005] = {
		40802005,
		0,
		Lang.get(109086),
		40802,
		5,
		1276,
		{
			RTResTalkAction[146]
		}
	},
	[40802006] = {
		40802006,
		3,
		Lang.get(109087),
		40802,
		6,
		605,
		{
			RTResTalkAction[20]
		},
		[21] = 1276,
		[22] = 1
	},
	[40802007] = {
		40802007,
		4,
		nil,
		40802,
		7,
		1278,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40802008,
				branch_content = Lang.get(109088)
			}
		}
	},
	[40802008] = {
		40802008,
		3,
		Lang.get(109089),
		40802,
		8,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40802009] = {
		40802009,
		0,
		Lang.get(109090),
		40802,
		9,
		1278,
		{
			RTResTalkAction[122]
		}
	},
	[40802010] = {
		40802010,
		0,
		Lang.get(109091),
		40802,
		10,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40802011] = {
		40802011,
		0,
		Lang.get(18271),
		40802,
		11,
		1276,
		{
			RTResTalkAction[148],
			RTResTalkAction[2]
		}
	},
	[40802012] = {
		40802012,
		0,
		Lang.get(109092),
		40802,
		12,
		1278,
		{
			RTResTalkAction[122],
			RTResTalkAction[12]
		}
	},
	[40802013] = {
		40802013,
		0,
		"……",
		40802,
		13,
		770,
		{
			RTResTalkAction[150],
			RTResTalkAction[2]
		}
	},
	[40802014] = {
		40802014,
		3,
		Lang.get(109093),
		40802,
		14,
		605,
		{
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40802015] = {
		40802015,
		3,
		Lang.get(109094),
		40802,
		15,
		605,
		[22] = 1
	},
	[40802016] = {
		40802016,
		0,
		Lang.get(109095),
		40802,
		16,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40802017] = {
		40802017,
		0,
		Lang.get(109096),
		40802,
		17,
		1278,
		{
			RTResTalkAction[3]
		}
	},
	[40802018] = {
		40802018,
		0,
		Lang.get(109097),
		40802,
		18,
		770,
		{
			RTResTalkAction[151],
			RTResTalkAction[2]
		}
	},
	[40802019] = {
		40802019,
		0,
		Lang.get(109098),
		40802,
		19,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40802020] = {
		40802020,
		0,
		Lang.get(109099),
		40802,
		20,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40802021] = {
		40802021,
		0,
		"……！",
		40802,
		21,
		1276,
		{
			RTResTalkAction[152],
			RTResTalkAction[124]
		}
	},
	[40802022] = {
		40802022,
		5,
		Lang.get(109100),
		40802,
		22,
		770,
		{
			RTResTalkAction[153],
			RTResTalkAction[12]
		}
	},
	[40619001] = {
		40619001,
		0,
		Lang.get(109101),
		40619,
		1,
		770,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		3,
		nil,
		206,
		40700,
		nil,
		nil,
		nil,
		nil,
		nil,
		40700,
		255
	},
	[40619002] = {
		40619002,
		9,
		Lang.get(109102),
		40619,
		2,
		605,
		{
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40619003] = {
		40619003,
		9,
		Lang.get(109103),
		40619,
		3,
		605,
		[22] = 1
	},
	[40619004] = {
		40619004,
		0,
		Lang.get(109104),
		40619,
		4,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40619005] = {
		40619005,
		0,
		Lang.get(109105),
		40619,
		5,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40619006] = {
		40619006,
		3,
		Lang.get(109106),
		40619,
		6,
		605,
		{
			RTResTalkAction[124]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		40701,
		nil,
		nil,
		nil,
		nil,
		nil,
		40701,
		-1,
		nil,
		1
	},
	[40619007] = {
		40619007,
		9,
		Lang.get(109107),
		40619,
		7,
		605,
		[22] = 1
	},
	[40619008] = {
		40619008,
		0,
		Lang.get(109108),
		40619,
		8,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40619009] = {
		40619009,
		0,
		Lang.get(109109),
		40619,
		9,
		770,
		{
			RTResTalkAction[153]
		}
	},
	[40619010] = {
		40619010,
		0,
		Lang.get(108487),
		40619,
		10,
		1276,
		{
			RTResTalkAction[146],
			RTResTalkAction[124]
		}
	},
	[40619011] = {
		40619011,
		0,
		Lang.get(109110),
		40619,
		11,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40619012] = {
		40619012,
		3,
		Lang.get(109111),
		40619,
		12,
		605,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		},
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40619013] = {
		40619013,
		0,
		Lang.get(109112),
		40619,
		13,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[40619014] = {
		40619014,
		0,
		Lang.get(109113),
		40619,
		14,
		1276,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40619015] = {
		40619015,
		3,
		Lang.get(109114),
		40619,
		15,
		605,
		{
			RTResTalkAction[20],
			RTResTalkAction[124]
		},
		[21] = 1276,
		[22] = 1
	},
	[40619016] = {
		40619016,
		9,
		Lang.get(109115),
		40619,
		16,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		5003,
		[22] = 1
	},
	[40619017] = {
		40619017,
		3,
		Lang.get(109116),
		40619,
		17,
		605,
		[22] = 1,
		[20] = 245
	},
	[40619018] = {
		40619018,
		3,
		Lang.get(109117),
		40619,
		18,
		605,
		[22] = 1
	},
	[40619019] = {
		40619019,
		0,
		Lang.get(109118),
		40619,
		19,
		1276,
		{
			RTResTalkAction[148]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[40619020] = {
		40619020,
		3,
		Lang.get(109119),
		40619,
		20,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		5005,
		[22] = 1,
		[20] = -1
	},
	[40619021] = {
		40619021,
		9,
		Lang.get(109120),
		40619,
		21,
		605,
		[22] = 1
	},
	[40619022] = {
		40619022,
		9,
		Lang.get(109121),
		40619,
		22,
		605,
		[22] = 1
	},
	[40619023] = {
		40619023,
		9,
		"……",
		40619,
		23,
		605,
		[22] = 1
	},
	[40619024] = {
		40619024,
		3,
		Lang.get(109122),
		40619,
		24,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		40702,
		nil,
		nil,
		nil,
		nil,
		nil,
		40702,
		-1,
		nil,
		1
	},
	[40619025] = {
		40619025,
		0,
		Lang.get(109123),
		40619,
		25,
		1276,
		{
			RTResTalkAction[15]
		}
	},
	[40619026] = {
		40619026,
		0,
		Lang.get(18698),
		40619,
		26,
		770,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		}
	},
	[40619027] = {
		40619027,
		3,
		Lang.get(109124),
		40619,
		27,
		605,
		{
			RTResTalkAction[125],
			RTResTalkAction[127]
		},
		[22] = 1
	},
	[40619028] = {
		40619028,
		0,
		Lang.get(109125),
		40619,
		28,
		1276,
		{
			RTResTalkAction[144],
			RTResTalkAction[127]
		}
	},
	[40619029] = {
		40619029,
		3,
		"……",
		40619,
		29,
		605,
		{
			RTResTalkAction[12],
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40619030] = {
		40619030,
		3,
		Lang.get(109126),
		40619,
		30,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		40703,
		nil,
		nil,
		nil,
		nil,
		nil,
		40703,
		200,
		nil,
		1
	},
	[40619031] = {
		40619031,
		3,
		Lang.get(109127),
		40619,
		31,
		605,
		[22] = 1
	},
	[40619032] = {
		40619032,
		3,
		Lang.get(109128),
		40619,
		32,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		154,
		[22] = 1,
		[20] = -1
	},
	[40619033] = {
		40619033,
		0,
		Lang.get(109129),
		40619,
		33,
		1278,
		nil,
		1,
		0
	},
	[40619034] = {
		40619034,
		4,
		nil,
		40619,
		34,
		1278,
		[29] = {
			{
				id = 40619035,
				branch_content = Lang.get(109130)
			},
			{
				id = 40619035,
				branch_content = Lang.get(109131)
			}
		}
	},
	[40619035] = {
		40619035,
		0,
		Lang.get(109132),
		40619,
		35,
		1276,
		nil,
		1,
		4
	},
	[40619036] = {
		40619036,
		0,
		Lang.get(109133),
		40619,
		36,
		1276,
		nil,
		1,
		4
	},
	[40619037] = {
		40619037,
		3,
		Lang.get(109134),
		40619,
		37,
		605,
		[22] = 1
	},
	[40619038] = {
		40619038,
		3,
		Lang.get(109135),
		40619,
		38,
		605,
		[22] = 1
	},
	[40619039] = {
		40619039,
		0,
		Lang.get(109136),
		40619,
		39,
		1276,
		nil,
		1,
		4
	},
	[40619040] = {
		40619040,
		0,
		Lang.get(109137),
		40619,
		40,
		1278,
		nil,
		1,
		0
	},
	[40619041] = {
		40619041,
		0,
		Lang.get(109138),
		40619,
		41,
		1278,
		nil,
		1,
		0
	},
	[40619042] = {
		40619042,
		0,
		Lang.get(109139),
		40619,
		42,
		1276,
		{
			RTResTalkAction[154]
		},
		nil,
		nil,
		3
	},
	[40619043] = {
		40619043,
		0,
		Lang.get(109140),
		40619,
		43,
		1276,
		{
			RTResTalkAction[154]
		}
	},
	[40619044] = {
		40619044,
		3,
		Lang.get(109141),
		40619,
		44,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[40619045] = {
		40619045,
		0,
		Lang.get(109142),
		40619,
		45,
		1278,
		nil,
		1,
		0
	},
	[40619046] = {
		40619046,
		0,
		"|101|。",
		40619,
		46,
		1278
	},
	[40619047] = {
		40619047,
		0,
		Lang.get(109143),
		40619,
		47,
		1276,
		{
			RTResTalkAction[154]
		}
	},
	[40619048] = {
		40619048,
		0,
		Lang.get(109144),
		40619,
		48,
		1276,
		{
			RTResTalkAction[11]
		}
	},
	[40619049] = {
		40619049,
		3,
		Lang.get(109145),
		40619,
		49,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1,
		[20] = 200
	},
	[40620001] = {
		40620001,
		3,
		Lang.get(109146),
		40620,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		113,
		40705,
		nil,
		nil,
		nil,
		nil,
		nil,
		40705,
		200,
		nil,
		1
	},
	[40620002] = {
		40620002,
		0,
		Lang.get(109147),
		40620,
		2,
		770,
		{
			RTResTalkAction[123]
		},
		[20] = 100
	},
	[40620003] = {
		40620003,
		0,
		Lang.get(109148),
		40620,
		3,
		1072,
		{
			RTResTalkAction[123]
		},
		1,
		0
	},
	[40620004] = {
		40620004,
		9,
		Lang.get(109149),
		40620,
		4,
		605,
		{
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40620005] = {
		40620005,
		0,
		Lang.get(109150),
		40620,
		5,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40620006] = {
		40620006,
		0,
		Lang.get(109151),
		40620,
		6,
		1071,
		{
			RTResTalkAction[123]
		},
		1,
		0
	},
	[40620007] = {
		40620007,
		0,
		Lang.get(109152),
		40620,
		7,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40620008] = {
		40620008,
		0,
		Lang.get(109153),
		40620,
		8,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40620009] = {
		40620009,
		0,
		Lang.get(109154),
		40620,
		9,
		1071,
		{
			RTResTalkAction[123]
		},
		1,
		0
	},
	[40620010] = {
		40620010,
		0,
		Lang.get(109155),
		40620,
		10,
		770,
		{
			RTResTalkAction[123]
		}
	},
	[40620011] = {
		40620011,
		9,
		Lang.get(109156),
		40620,
		11,
		605,
		{
			RTResTalkAction[124]
		},
		[22] = 1
	},
	[40620012] = {
		40620012,
		0,
		Lang.get(109157),
		40620,
		12,
		1071,
		nil,
		1,
		0
	},
	[40620013] = {
		40620013,
		0,
		Lang.get(109158),
		40620,
		13,
		1071,
		nil,
		1
	},
	[40620014] = {
		40620014,
		9,
		Lang.get(109159),
		40620,
		14,
		605,
		{
			RTResTalkAction[155]
		},
		[21] = 770,
		[22] = 1
	},
	[40620015] = {
		40620015,
		0,
		Lang.get(109160),
		40620,
		15,
		770,
		{
			RTResTalkAction[156]
		}
	},
	[40620016] = {
		40620016,
		0,
		Lang.get(109161),
		40620,
		16,
		1071,
		{
			RTResTalkAction[123]
		},
		1,
		1
	},
	[40620017] = {
		40620017,
		0,
		Lang.get(109162),
		40620,
		17,
		770,
		{
			RTResTalkAction[150]
		}
	},
	[40620018] = {
		40620018,
		0,
		Lang.get(109163),
		40620,
		18,
		770,
		{
			RTResTalkAction[157]
		}
	},
	[40620019] = {
		40620019,
		3,
		Lang.get(109164),
		40620,
		19,
		605,
		{
			RTResTalkAction[124]
		},
		nil,
		nil,
		nil,
		nil,
		8,
		40706,
		1,
		1,
		nil,
		1,
		nil,
		40706,
		nil,
		nil,
		1
	},
	[40620020] = {
		40620020,
		0,
		Lang.get(109165),
		40620,
		20,
		158,
		{
			RTResTalkAction[158]
		}
	},
	[40620021] = {
		40620021,
		4,
		nil,
		40620,
		21,
		158,
		{
			RTResTalkAction[159]
		},
		[29] = {
			{
				id = 40620022,
				branch_content = Lang.get(109166)
			},
			{
				id = 40620022,
				branch_content = Lang.get(109167)
			}
		}
	},
	[40620022] = {
		40620022,
		0,
		Lang.get(109168),
		40620,
		22,
		158,
		{
			RTResTalkAction[160]
		}
	},
	[40620023] = {
		40620023,
		3,
		Lang.get(109169),
		40620,
		23,
		605,
		{
			RTResTalkAction[161]
		},
		nil,
		nil,
		nil,
		2758,
		[22] = 1
	},
	[40620024] = {
		40620024,
		0,
		Lang.get(29085),
		40620,
		24,
		300
	},
	[40620025] = {
		40620025,
		3,
		Lang.get(109170),
		40620,
		25,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		208,
		40707,
		1,
		1,
		nil,
		1,
		nil,
		40707,
		nil,
		nil,
		1
	},
	[40620026] = {
		40620026,
		0,
		Lang.get(109171),
		40620,
		26,
		1276,
		nil,
		1,
		0
	},
	[40620027] = {
		40620027,
		3,
		Lang.get(109172),
		40620,
		27,
		605,
		[22] = 1
	},
	[40620028] = {
		40620028,
		0,
		Lang.get(109173),
		40620,
		28,
		300
	},
	[40620029] = {
		40620029,
		0,
		Lang.get(109174),
		40620,
		29,
		1276,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[40620030] = {
		40620030,
		3,
		Lang.get(109175),
		40620,
		30,
		605,
		{
			RTResTalkAction[11]
		},
		[22] = 1
	},
	[40620031] = {
		40620031,
		4,
		nil,
		40620,
		31,
		300,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 40620032,
				branch_content = Lang.get(109176)
			},
			{
				id = 40620032,
				branch_content = Lang.get(109177)
			}
		}
	},
	[40620032] = {
		40620032,
		3,
		Lang.get(109178),
		40620,
		32,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1,
		[20] = 100
	},
	[40620033] = {
		40620033,
		3,
		Lang.get(109179),
		40620,
		33,
		605,
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
