-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023Mifia\\ResTalk.lua

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
	[2] = 765
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 765
}
RTResTalkAction[3] = {
	1,
	765,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 765,
	[3] = {
		3
	}
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1056,
	[3] = {
		2
	}
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1056
}
RTResTalkAction[8] = {
	1,
	1183,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1183
}
RTResTalkAction[10] = {
	1,
	1169,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 1169
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 1056
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[14] = {
	1,
	1169,
	nil,
	nil,
	1
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 1190,
	[3] = {
		1
	}
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 1190
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1191,
	[3] = {
		1
	}
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1191
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1192,
	[3] = {
		1
	}
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 1192
}
RTResTalkAction[21] = {
	1,
	1169,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	1,
	223,
	nil,
	nil,
	1
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 223
}
RTResTalkAction[24] = {
	1,
	179,
	nil,
	nil,
	3
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 179
}
RTResTalkAction[26] = {
	[1] = 2,
	[2] = 223
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 179
}
RTResTalkAction[28] = {
	1,
	179,
	nil,
	nil,
	2
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 177
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 177
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 1009
}
RTResTalkAction[32] = {
	1,
	143,
	nil,
	nil,
	1
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 177
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 1009
}
RTResTalkAction[35] = {
	1,
	1009,
	nil,
	nil,
	2
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[37] = {
	1,
	134,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[39] = {
	1,
	143,
	nil,
	nil,
	2
}
RTResTalkAction[40] = {
	[1] = 2,
	[2] = 143
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 177
}
RTResTalkAction[42] = {
	1,
	1009,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[43] = {
	1,
	143,
	nil,
	nil,
	5
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 209
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 209
}
RTResTalkAction[46] = {
	1,
	1169,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[47] = {
	[1] = 2,
	[2] = 1009
}
RTResTalkAction[48] = {
	[1] = 3,
	[2] = 1169
}
RTResTalkAction[49] = {
	2,
	1009,
	nil,
	nil,
	2
}
RTResTalkAction[50] = {
	1,
	1009,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 200
}
RTResTalkAction[52] = {
	[1] = 2,
	[2] = 200
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 200
}
RTResTalkAction[54] = {
	[1] = 3,
	[2] = 200
}
RTResTalkAction[55] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[56] = {
	1,
	1009,
	nil,
	nil,
	3
}
RTResTalkAction[57] = {
	2,
	1169,
	nil,
	nil,
	1
}
RTResTalkAction[58] = {
	2,
	1169,
	nil,
	nil,
	2
}
RTResTalkAction[59] = {
	[1] = 3,
	[2] = 273
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 273
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 273
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 273
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[64] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[66] = {
	1,
	768,
	nil,
	nil,
	3
}
RTResTalkAction[67] = {
	[1] = 2,
	[2] = 768
}
RTResTalkAction[68] = {
	1,
	768,
	nil,
	nil,
	1
}
RTResTalkAction[69] = {
	1,
	768,
	nil,
	nil,
	2
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 768
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 275
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 275
}
RTResTalkAction[73] = {
	1,
	177,
	nil,
	nil,
	0
}
RTResTalkAction[74] = {
	[1] = 3,
	[2] = 223
}
RTResTalkAction[75] = {
	1,
	1009,
	nil,
	nil,
	1
}
RTResTalkAction[76] = {
	[1] = 1,
	[2] = 179
}
RTResTalkAction[77] = {
	1,
	179,
	nil,
	nil,
	1
}
RTResTalkAction[78] = {
	1,
	1178,
	nil,
	nil,
	0
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1179
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 1178
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 1179
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 1178
}
RTResTalkAction[83] = {
	1,
	1069,
	nil,
	nil,
	2
}
RTResTalkAction[84] = {
	1,
	1069,
	nil,
	nil,
	1
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 1069
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 1172
}
RTResTalkAction[87] = {
	1,
	1169,
	nil,
	nil,
	3
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 1172
}
RTResTalkAction[89] = {
	1,
	1172,
	nil,
	nil,
	0
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 1058
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 1058
}
RTResTalkAction[92] = {
	1,
	1169,
	nil,
	nil,
	4
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 1057
}
RTResTalkAction[94] = {
	[1] = 0,
	[2] = 1057
}
RTResTalkAction[95] = {
	1,
	1058,
	nil,
	nil,
	0
}
RTResTalkAction[96] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[97] = {
	2,
	1169,
	nil,
	nil,
	3
}
RTResTalkAction[98] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[99] = {
	1,
	1169,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 207
}
RTResTalkAction[101] = {
	[1] = 0,
	[2] = 207
}
RTResTalkAction[102] = {
	[1] = 2,
	[2] = 1172
}
RTResTalkAction[103] = {
	[1] = 4,
	[2] = 1172
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[105] = {
	[1] = 5,
	[2] = 207,
	[3] = {
		1
	}
}
RTResTalkAction[106] = {
	[1] = 3,
	[2] = 207
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 1182
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 1182
}
RTResTalkAction[109] = {
	[1] = 2,
	[2] = 207
}
RTResTalkAction[110] = {
	[1] = 3,
	[2] = 1057
}
RTResTalkAction[111] = {
	[1] = 1,
	[2] = 223
}
RTResTalkAction[112] = {
	2,
	223,
	nil,
	nil,
	1
}
RTResTalkAction[113] = {
	[1] = 3,
	[2] = 226
}
RTResTalkAction[114] = {
	1,
	226,
	nil,
	nil,
	1
}
RTResTalkAction[115] = {
	[1] = 1,
	[2] = 1173
}
RTResTalkAction[116] = {
	1,
	1169,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[117] = {
	[1] = 0,
	[2] = 1173
}
RTResTalkAction[118] = {
	[1] = 1,
	[2] = 1180
}
RTResTalkAction[119] = {
	[1] = 0,
	[2] = 1180
}
RTResTalkAction[120] = {
	1,
	1169,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[121] = {
	[1] = 1,
	[2] = 1193
}
RTResTalkAction[122] = {
	1,
	1009,
	nil,
	nil,
	0
}
RTResTalkAction[123] = {
	[1] = 0,
	[2] = 1193
}
RTResTalkAction[124] = {
	[1] = 1,
	[2] = 1186
}
RTResTalkAction[125] = {
	[1] = 1,
	[2] = 1175
}
RTResTalkAction[126] = {
	[1] = 0,
	[2] = 1186
}
RTResTalkAction[127] = {
	[1] = 0,
	[2] = 1175
}
RTResTalkAction[128] = {
	[1] = 1,
	[2] = 1185
}
RTResTalkAction[129] = {
	[1] = 0,
	[2] = 1185
}
RTResTalkAction[130] = {
	[1] = 1,
	[2] = 1187
}
RTResTalkAction[131] = {
	[1] = 0,
	[2] = 1187
}
RTResTalkAction[132] = {
	[1] = 1,
	[2] = 1189
}
RTResTalkAction[133] = {
	[1] = 0,
	[2] = 1189
}
RTResTalkAction[134] = {
	[1] = 1,
	[2] = 1188
}
RTResTalkAction[135] = {
	[1] = 0,
	[2] = 1188
}
RTResTalkAction[136] = {
	[1] = 1,
	[2] = 1009
}
RTResTalkAction[137] = {
	1,
	1009,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[138] = {
	1,
	143,
	nil,
	nil,
	4
}
RTResTalkAction[139] = {
	1,
	143,
	nil,
	nil,
	3
}
RTResTalkAction[140] = {
	1,
	1169,
	{
		1
	},
	nil,
	1
}

local Data = {
	[35501001] = {
		35501001,
		3,
		Lang.get(91823),
		35501,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		1227,
		31,
		35501,
		nil,
		nil,
		nil,
		nil,
		nil,
		35501,
		255,
		nil,
		1
	},
	[35501002] = {
		35501002,
		0,
		Lang.get(91824),
		35501,
		2,
		765,
		nil,
		1,
		nil,
		nil,
		1816,
		[20] = -1
	},
	[35501003] = {
		35501003,
		0,
		Lang.get(91825),
		35501,
		3,
		765,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[35501004] = {
		35501004,
		0,
		Lang.get(91826),
		35501,
		4,
		765,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		24
	},
	[35501005] = {
		35501005,
		0,
		Lang.get(91827),
		35501,
		5,
		1183,
		{
			RTResTalkAction[2]
		},
		1,
		1,
		-1
	},
	[35501006] = {
		35501006,
		0,
		Lang.get(91828),
		35501,
		6,
		1183,
		nil,
		1,
		4
	},
	[35501007] = {
		35501007,
		0,
		Lang.get(91829),
		35501,
		7,
		765,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[35501008] = {
		35501008,
		0,
		Lang.get(91830),
		35501,
		8,
		1183,
		{
			RTResTalkAction[2]
		},
		1,
		1,
		-1
	},
	[35501009] = {
		35501009,
		0,
		Lang.get(91831),
		35501,
		9,
		765,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		35502,
		nil,
		1,
		nil,
		nil,
		nil,
		35502
	},
	[35501010] = {
		35501010,
		0,
		Lang.get(91832),
		35501,
		10,
		1183,
		nil,
		1,
		1
	},
	[35501011] = {
		35501011,
		0,
		Lang.get(91833),
		35501,
		11,
		765,
		{
			RTResTalkAction[4]
		},
		nil,
		0,
		3,
		1549,
		-1
	},
	[35501012] = {
		35501012,
		0,
		Lang.get(91834),
		35501,
		12,
		1056,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		-1,
		nil,
		57,
		35503,
		nil,
		1,
		nil,
		2,
		nil,
		35503
	},
	[35501013] = {
		35501013,
		0,
		Lang.get(91835),
		35501,
		13,
		1057,
		nil,
		1
	},
	[35501014] = {
		35501014,
		0,
		Lang.get(91836),
		35501,
		14,
		1058,
		nil,
		1
	},
	[35501015] = {
		35501015,
		0,
		Lang.get(49553),
		35501,
		15,
		3,
		nil,
		nil,
		nil,
		nil,
		1070,
		nil,
		35504,
		nil,
		1,
		nil,
		nil,
		nil,
		35504
	},
	[35501016] = {
		35501016,
		0,
		Lang.get(91837),
		35501,
		16,
		1056,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[35501017] = {
		35501017,
		3,
		Lang.get(91838),
		35501,
		17,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[35501018] = {
		35501018,
		0,
		Lang.get(91839),
		35501,
		18,
		1183,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		35505,
		nil,
		1,
		[19] = 35505
	},
	[35501019] = {
		35501019,
		0,
		Lang.get(91840),
		35501,
		19,
		1183
	},
	[35501020] = {
		35501020,
		3,
		Lang.get(91841),
		35501,
		20,
		605,
		nil,
		nil,
		nil,
		-1,
		1222,
		nil,
		35600,
		nil,
		1,
		nil,
		nil,
		nil,
		35600,
		nil,
		nil,
		1
	},
	[35501021] = {
		35501021,
		0,
		Lang.get(91842),
		35501,
		21,
		1056,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		35601,
		nil,
		1,
		nil,
		nil,
		nil,
		35601
	},
	[35501022] = {
		35501022,
		0,
		Lang.get(91843),
		35501,
		22,
		1183,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[35501023] = {
		35501023,
		7,
		"101",
		35501,
		23,
		1169,
		{
			RTResTalkAction[9]
		}
	},
	[35502001] = {
		35502001,
		0,
		Lang.get(22255),
		35502,
		1,
		3,
		nil,
		nil,
		nil,
		-1,
		1231,
		198,
		35506,
		nil,
		1,
		nil,
		1,
		nil,
		35506
	},
	[35502002] = {
		35502002,
		0,
		Lang.get(91844),
		35502,
		2,
		1169,
		nil,
		1,
		1
	},
	[35502003] = {
		35502003,
		0,
		Lang.get(91845),
		35502,
		3,
		1058,
		nil,
		1
	},
	[35502004] = {
		35502004,
		0,
		Lang.get(91846),
		35502,
		4,
		1056,
		nil,
		1
	},
	[35502005] = {
		35502005,
		0,
		Lang.get(91847),
		35502,
		5,
		1169,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[35502006] = {
		35502006,
		0,
		Lang.get(91848),
		35502,
		6,
		1056,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[35502007] = {
		35502007,
		3,
		Lang.get(75334),
		35502,
		7,
		605,
		{
			RTResTalkAction[13],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		1232,
		nil,
		35507,
		nil,
		1,
		nil,
		nil,
		nil,
		35507,
		255,
		nil,
		1
	},
	[35502008] = {
		35502008,
		0,
		Lang.get(91849),
		35502,
		8,
		1169,
		nil,
		1,
		3,
		-1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[35502009] = {
		35502009,
		0,
		Lang.get(91850),
		35502,
		9,
		3,
		nil,
		nil,
		nil,
		nil,
		1231
	},
	[35502010] = {
		35502010,
		0,
		Lang.get(91851),
		35502,
		10,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		0,
		3
	},
	[35503001] = {
		35503001,
		0,
		Lang.get(91852),
		35503,
		1,
		1169,
		nil,
		1,
		1,
		-1,
		nil,
		198,
		35508,
		nil,
		1,
		nil,
		nil,
		nil,
		35508
	},
	[35503002] = {
		35503002,
		0,
		Lang.get(91853),
		35503,
		2,
		1169,
		nil,
		1,
		2
	},
	[35503003] = {
		35503003,
		0,
		Lang.get(91854),
		35503,
		3,
		1190,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		3,
		1231
	},
	[35503004] = {
		35503004,
		0,
		Lang.get(91855),
		35503,
		4,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[16]
		}
	},
	[35503005] = {
		35503005,
		0,
		Lang.get(91856),
		35503,
		5,
		1191,
		{
			RTResTalkAction[17],
			RTResTalkAction[13]
		}
	},
	[35503006] = {
		35503006,
		0,
		Lang.get(91857),
		35503,
		6,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[18]
		}
	},
	[35503007] = {
		35503007,
		0,
		Lang.get(91858),
		35503,
		7,
		1169,
		{
			RTResTalkAction[14]
		}
	},
	[35503008] = {
		35503008,
		0,
		Lang.get(91859),
		35503,
		8,
		1192,
		{
			RTResTalkAction[19],
			RTResTalkAction[13]
		}
	},
	[35503009] = {
		35503009,
		0,
		Lang.get(91860),
		35503,
		9,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[20]
		}
	},
	[35503010] = {
		35503010,
		0,
		Lang.get(91861),
		35503,
		10,
		1169,
		{
			RTResTalkAction[21]
		}
	},
	[35503011] = {
		35503011,
		0,
		Lang.get(91862),
		35503,
		11,
		1169,
		{
			RTResTalkAction[14]
		}
	},
	[35503012] = {
		35503012,
		0,
		Lang.get(91863),
		35503,
		12,
		1169,
		{
			RTResTalkAction[13]
		},
		1,
		1,
		-1,
		nil,
		nil,
		35509,
		nil,
		1,
		nil,
		nil,
		nil,
		35509
	},
	[35503013] = {
		35503013,
		0,
		Lang.get(22255),
		35503,
		13,
		565,
		nil,
		nil,
		nil,
		nil,
		1070
	},
	[35503014] = {
		35503014,
		0,
		Lang.get(91864),
		35503,
		14,
		1169,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[35504001] = {
		35504001,
		3,
		Lang.get(91865),
		35504,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		132,
		35510,
		nil,
		1,
		nil,
		0,
		nil,
		35510,
		nil,
		nil,
		1
	},
	[35504002] = {
		35504002,
		0,
		Lang.get(91866),
		35504,
		2,
		1169,
		nil,
		1,
		2
	},
	[35504003] = {
		35504003,
		0,
		Lang.get(91867),
		35504,
		3,
		223,
		nil,
		1,
		1,
		-1,
		nil,
		nil,
		35511,
		nil,
		1,
		nil,
		nil,
		nil,
		35511
	},
	[35504004] = {
		35504004,
		0,
		Lang.get(91868),
		35504,
		4,
		179,
		nil,
		1,
		2
	},
	[35504005] = {
		35504005,
		3,
		Lang.get(91869),
		35504,
		5,
		605,
		nil,
		nil,
		nil,
		nil,
		1237,
		[22] = 1
	},
	[35504006] = {
		35504006,
		0,
		Lang.get(91870),
		35504,
		6,
		223,
		{
			RTResTalkAction[22]
		}
	},
	[35504007] = {
		35504007,
		0,
		Lang.get(91871),
		35504,
		7,
		1169,
		{
			RTResTalkAction[23]
		},
		1,
		4,
		-1,
		nil,
		nil,
		35602,
		nil,
		1,
		nil,
		nil,
		nil,
		35602
	},
	[35504008] = {
		35504008,
		0,
		Lang.get(91872),
		35504,
		8,
		223,
		nil,
		1,
		1
	},
	[35504009] = {
		35504009,
		0,
		Lang.get(91873),
		35504,
		9,
		1169,
		nil,
		1,
		1
	},
	[35504010] = {
		35504010,
		0,
		Lang.get(91874),
		35504,
		10,
		223,
		nil,
		1,
		1
	},
	[35504011] = {
		35504011,
		0,
		Lang.get(91875),
		35504,
		11,
		1169,
		nil,
		1,
		2
	},
	[35504012] = {
		35504012,
		0,
		Lang.get(91876),
		35504,
		12,
		223,
		nil,
		1,
		1
	},
	[35504013] = {
		35504013,
		0,
		Lang.get(91877),
		35504,
		13,
		1169,
		nil,
		1,
		1
	},
	[35504014] = {
		35504014,
		3,
		Lang.get(91878),
		35504,
		14,
		605,
		nil,
		nil,
		nil,
		-1,
		1230,
		nil,
		35512,
		nil,
		1,
		nil,
		nil,
		nil,
		35512,
		255,
		nil,
		1
	},
	[35504015] = {
		35504015,
		0,
		Lang.get(91879),
		35504,
		15,
		179,
		nil,
		1,
		2,
		[20] = -1
	},
	[35504016] = {
		35504016,
		0,
		Lang.get(91880),
		35504,
		16,
		1169,
		nil,
		1,
		3
	},
	[35504017] = {
		35504017,
		0,
		Lang.get(91881),
		35504,
		17,
		179,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		35513,
		nil,
		1,
		nil,
		nil,
		nil,
		35513
	},
	[35504018] = {
		35504018,
		0,
		Lang.get(91882),
		35504,
		18,
		223,
		nil,
		1,
		1
	},
	[35504019] = {
		35504019,
		0,
		Lang.get(91883),
		35504,
		19,
		179,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[35504020] = {
		35504020,
		0,
		Lang.get(91884),
		35504,
		20,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[25]
		}
	},
	[35504021] = {
		35504021,
		3,
		Lang.get(91869),
		35504,
		21,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		},
		nil,
		nil,
		nil,
		1230,
		[22] = 1
	},
	[35504022] = {
		35504022,
		0,
		Lang.get(91885),
		35504,
		22,
		179,
		{
			RTResTalkAction[28],
			RTResTalkAction[23]
		}
	},
	[35504023] = {
		35504023,
		0,
		Lang.get(91886),
		35504,
		23,
		200,
		{
			RTResTalkAction[25]
		},
		1,
		0,
		-1,
		nil,
		nil,
		35514,
		nil,
		1,
		nil,
		nil,
		nil,
		35514
	},
	[35505001] = {
		35505001,
		0,
		Lang.get(91887),
		35505,
		1,
		177,
		nil,
		1,
		nil,
		-1,
		nil,
		62,
		35515,
		nil,
		1,
		nil,
		1,
		nil,
		35515
	},
	[35505002] = {
		35505002,
		0,
		Lang.get(91888),
		35505,
		2,
		1009,
		nil,
		1,
		2
	},
	[35505003] = {
		35505003,
		0,
		Lang.get(91889),
		35505,
		3,
		177,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[35505004] = {
		35505004,
		0,
		Lang.get(91890),
		35505,
		4,
		1009,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[35505005] = {
		35505005,
		0,
		Lang.get(91891),
		35505,
		5,
		177,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[35505006] = {
		35505006,
		0,
		Lang.get(91892),
		35505,
		6,
		177,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[35505007] = {
		35505007,
		0,
		Lang.get(91893),
		35505,
		7,
		1009,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[35505008] = {
		35505008,
		0,
		Lang.get(91894),
		35505,
		8,
		143,
		{
			RTResTalkAction[32],
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[35505009] = {
		35505009,
		0,
		Lang.get(91895),
		35505,
		9,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[35505010] = {
		35505010,
		0,
		Lang.get(91896),
		35505,
		10,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[34]
		}
	},
	[35505011] = {
		35505011,
		3,
		Lang.get(91897),
		35505,
		11,
		605,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		1230,
		nil,
		35516,
		nil,
		1,
		nil,
		nil,
		nil,
		35516,
		nil,
		nil,
		1
	},
	[35505012] = {
		35505012,
		0,
		Lang.get(91898),
		35505,
		12,
		134,
		nil,
		1,
		2
	},
	[35505013] = {
		35505013,
		0,
		Lang.get(91899),
		35505,
		13,
		42,
		nil,
		1,
		1
	},
	[35505014] = {
		35505014,
		0,
		Lang.get(91900),
		35505,
		14,
		134,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[35505015] = {
		35505015,
		0,
		Lang.get(91901),
		35505,
		15,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[35505016] = {
		35505016,
		0,
		Lang.get(91902),
		35505,
		16,
		1009,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[35505017] = {
		35505017,
		0,
		Lang.get(91903),
		35505,
		17,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[34]
		}
	},
	[35505018] = {
		35505018,
		0,
		Lang.get(91904),
		35505,
		18,
		1009,
		{
			RTResTalkAction[33]
		},
		1,
		0,
		-1,
		nil,
		nil,
		35517,
		nil,
		1,
		nil,
		nil,
		nil,
		35517
	},
	[35505019] = {
		35505019,
		0,
		Lang.get(91905),
		35505,
		19,
		1009,
		nil,
		1,
		0
	},
	[35505020] = {
		35505020,
		0,
		Lang.get(91906),
		35505,
		20,
		143,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3
	},
	[35505021] = {
		35505021,
		0,
		Lang.get(91907),
		35505,
		21,
		177,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[35505022] = {
		35505022,
		0,
		Lang.get(91908),
		35505,
		22,
		1009,
		{
			RTResTalkAction[42],
			RTResTalkAction[36],
			RTResTalkAction[33]
		}
	},
	[35505023] = {
		35505023,
		0,
		Lang.get(91909),
		35505,
		23,
		143,
		{
			RTResTalkAction[43],
			RTResTalkAction[34]
		}
	},
	[35505024] = {
		35505024,
		0,
		Lang.get(91910),
		35505,
		24,
		1169,
		{
			RTResTalkAction[36]
		},
		1,
		1,
		-1,
		nil,
		24,
		35518,
		nil,
		1,
		nil,
		nil,
		nil,
		35518
	},
	[35505025] = {
		35505025,
		0,
		Lang.get(91911),
		35505,
		25,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35505026] = {
		35505026,
		0,
		Lang.get(91912),
		35505,
		26,
		1169,
		{
			RTResTalkAction[21]
		}
	},
	[35505027] = {
		35505027,
		0,
		Lang.get(22255),
		35505,
		27,
		565,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		1070
	},
	[35506001] = {
		35506001,
		3,
		Lang.get(91913),
		35506,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		1237,
		198,
		35519,
		nil,
		1,
		nil,
		nil,
		nil,
		35519,
		nil,
		nil,
		1
	},
	[35506002] = {
		35506002,
		0,
		Lang.get(91914),
		35506,
		2,
		1009,
		nil,
		1,
		2
	},
	[35506003] = {
		35506003,
		0,
		Lang.get(91915),
		35506,
		3,
		134,
		nil,
		1,
		2
	},
	[35506004] = {
		35506004,
		0,
		Lang.get(91916),
		35506,
		4,
		1009,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[35506005] = {
		35506005,
		0,
		Lang.get(91917),
		35506,
		5,
		565,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		nil,
		nil,
		24,
		35520,
		nil,
		1,
		nil,
		nil,
		nil,
		35520
	},
	[35506006] = {
		35506006,
		0,
		Lang.get(91918),
		35506,
		6,
		565
	},
	[35506007] = {
		35506007,
		0,
		Lang.get(91919),
		35506,
		7,
		143,
		nil,
		1,
		5
	},
	[35506008] = {
		35506008,
		0,
		Lang.get(91920),
		35506,
		8,
		565
	},
	[35506009] = {
		35506009,
		0,
		Lang.get(91921),
		35506,
		9,
		177,
		nil,
		1
	},
	[35506010] = {
		35506010,
		0,
		Lang.get(91922),
		35506,
		10,
		565
	},
	[35506011] = {
		35506011,
		0,
		Lang.get(91923),
		35506,
		11,
		177,
		nil,
		1
	},
	[35506012] = {
		35506012,
		0,
		Lang.get(91924),
		35506,
		12,
		1009,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		35521,
		nil,
		1,
		nil,
		nil,
		nil,
		35521
	},
	[35506013] = {
		35506013,
		0,
		Lang.get(91925),
		35506,
		13,
		177,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[35506014] = {
		35506014,
		0,
		Lang.get(91926),
		35506,
		14,
		565,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1
	},
	[35506015] = {
		35506015,
		0,
		Lang.get(91927),
		35506,
		15,
		1009,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[35506016] = {
		35506016,
		0,
		Lang.get(91928),
		35506,
		16,
		209,
		{
			RTResTalkAction[44],
			RTResTalkAction[34]
		}
	},
	[35506017] = {
		35506017,
		0,
		Lang.get(49553),
		35506,
		17,
		565,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		nil,
		1070,
		nil,
		35522,
		nil,
		1,
		nil,
		nil,
		nil,
		35522
	},
	[35506018] = {
		35506018,
		0,
		Lang.get(91929),
		35506,
		18,
		1169,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		35523,
		nil,
		1,
		nil,
		nil,
		nil,
		35523
	},
	[35506019] = {
		35506019,
		0,
		Lang.get(91930),
		35506,
		19,
		177,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35524,
		nil,
		1,
		nil,
		nil,
		nil,
		35524
	},
	[35506020] = {
		35506020,
		0,
		Lang.get(91931),
		35506,
		20,
		1009,
		nil,
		1,
		2
	},
	[35506021] = {
		35506021,
		0,
		Lang.get(91932),
		35506,
		21,
		1169,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		35523,
		nil,
		1,
		nil,
		nil,
		nil,
		35523
	},
	[35506022] = {
		35506022,
		0,
		Lang.get(91933),
		35506,
		22,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35506023] = {
		35506023,
		3,
		Lang.get(91934),
		35506,
		23,
		605,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		1222,
		[22] = 1
	},
	[35506024] = {
		35506024,
		0,
		Lang.get(67486),
		35506,
		24,
		565,
		nil,
		nil,
		nil,
		nil,
		1070,
		nil,
		35524,
		nil,
		1,
		nil,
		nil,
		nil,
		35524
	},
	[35506025] = {
		35506025,
		0,
		Lang.get(91935),
		35506,
		25,
		1169,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[35506026] = {
		35506026,
		0,
		Lang.get(91936),
		35506,
		26,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[13]
		}
	},
	[35506027] = {
		35506027,
		0,
		Lang.get(91937),
		35506,
		27,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[33]
		}
	},
	[35506028] = {
		35506028,
		0,
		Lang.get(91938),
		35506,
		28,
		1009,
		{
			RTResTalkAction[35]
		}
	},
	[35506029] = {
		35506029,
		0,
		Lang.get(91939),
		35506,
		29,
		1169,
		{
			RTResTalkAction[47],
			RTResTalkAction[48]
		}
	},
	[35506030] = {
		35506030,
		0,
		Lang.get(91940),
		35506,
		30,
		1009,
		{
			RTResTalkAction[49],
			RTResTalkAction[48]
		}
	},
	[35506031] = {
		35506031,
		0,
		Lang.get(91941),
		35506,
		31,
		1169,
		{
			RTResTalkAction[47],
			RTResTalkAction[48]
		}
	},
	[35506032] = {
		35506032,
		0,
		Lang.get(91942),
		35506,
		32,
		143,
		{
			RTResTalkAction[39],
			RTResTalkAction[34],
			RTResTalkAction[13]
		}
	},
	[35506033] = {
		35506033,
		0,
		Lang.get(91943),
		35506,
		33,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[36]
		}
	},
	[35506034] = {
		35506034,
		0,
		Lang.get(91944),
		35506,
		34,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[33]
		}
	},
	[35506035] = {
		35506035,
		0,
		Lang.get(91945),
		35506,
		35,
		200,
		{
			RTResTalkAction[34]
		},
		1,
		nil,
		-1,
		nil,
		122,
		35525,
		nil,
		1,
		nil,
		1,
		nil,
		35525
	},
	[35506036] = {
		35506036,
		0,
		Lang.get(91946),
		35506,
		36,
		177,
		nil,
		1
	},
	[35507001] = {
		35507001,
		0,
		Lang.get(91947),
		35507,
		1,
		1009,
		nil,
		1,
		2,
		-1,
		nil,
		nil,
		35526,
		nil,
		1,
		nil,
		nil,
		nil,
		35526
	},
	[35507002] = {
		35507002,
		0,
		Lang.get(91948),
		35507,
		2,
		1169,
		nil,
		1,
		1
	},
	[35507003] = {
		35507003,
		0,
		Lang.get(91949),
		35507,
		3,
		1009,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[35507004] = {
		35507004,
		0,
		Lang.get(91950),
		35507,
		4,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[34]
		}
	},
	[35507005] = {
		35507005,
		0,
		Lang.get(91951),
		35507,
		5,
		177,
		{
			RTResTalkAction[52],
			RTResTalkAction[41]
		}
	},
	[35507006] = {
		35507006,
		0,
		Lang.get(91952),
		35507,
		6,
		1009,
		{
			RTResTalkAction[52],
			RTResTalkAction[31],
			RTResTalkAction[33]
		}
	},
	[35507007] = {
		35507007,
		0,
		Lang.get(91953),
		35507,
		7,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[34]
		}
	},
	[35507008] = {
		35507008,
		0,
		Lang.get(91954),
		35507,
		8,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[53]
		}
	},
	[35507009] = {
		35507009,
		0,
		Lang.get(91955),
		35507,
		9,
		1009,
		{
			RTResTalkAction[42],
			RTResTalkAction[13]
		}
	},
	[35507010] = {
		35507010,
		0,
		Lang.get(91956),
		35507,
		10,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[34]
		}
	},
	[35507011] = {
		35507011,
		0,
		Lang.get(91957),
		35507,
		11,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[53]
		}
	},
	[35507012] = {
		35507012,
		5,
		Lang.get(91958),
		35507,
		12,
		605,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		-1,
		1230,
		198,
		35527,
		nil,
		1,
		nil,
		nil,
		nil,
		35527,
		nil,
		nil,
		1
	},
	[35507013] = {
		35507013,
		0,
		Lang.get(91959),
		35507,
		13,
		143,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[35507014] = {
		35507014,
		0,
		Lang.get(91960),
		35507,
		14,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[36]
		}
	},
	[35507015] = {
		35507015,
		0,
		Lang.get(91961),
		35507,
		15,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[13]
		}
	},
	[35507016] = {
		35507016,
		0,
		Lang.get(91962),
		35507,
		16,
		200,
		{
			RTResTalkAction[30],
			RTResTalkAction[54]
		}
	},
	[35507017] = {
		35507017,
		0,
		Lang.get(18644),
		35507,
		17,
		177,
		{
			RTResTalkAction[30],
			RTResTalkAction[54]
		}
	},
	[35507018] = {
		35507018,
		0,
		Lang.get(91963),
		35507,
		18,
		200,
		{
			RTResTalkAction[30],
			RTResTalkAction[54]
		}
	},
	[35507019] = {
		35507019,
		0,
		Lang.get(91964),
		35507,
		19,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[33],
			RTResTalkAction[53]
		}
	},
	[35507020] = {
		35507020,
		0,
		Lang.get(91965),
		35507,
		20,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35507021] = {
		35507021,
		0,
		Lang.get(91966),
		35507,
		21,
		200,
		{
			RTResTalkAction[11],
			RTResTalkAction[54],
			RTResTalkAction[33]
		}
	},
	[35507022] = {
		35507022,
		0,
		Lang.get(91967),
		35507,
		22,
		134,
		{
			RTResTalkAction[55],
			RTResTalkAction[13],
			RTResTalkAction[53]
		}
	},
	[35507023] = {
		35507023,
		0,
		Lang.get(91968),
		35507,
		23,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[38]
		}
	},
	[35507024] = {
		35507024,
		0,
		Lang.get(91969),
		35507,
		24,
		1009,
		{
			RTResTalkAction[13]
		},
		1,
		2,
		-1,
		nil,
		nil,
		35528,
		nil,
		1,
		nil,
		nil,
		nil,
		35528
	},
	[35507025] = {
		35507025,
		0,
		Lang.get(91970),
		35507,
		25,
		1009,
		nil,
		1,
		2
	},
	[35507026] = {
		35507026,
		0,
		Lang.get(91971),
		35507,
		26,
		1009,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[35507027] = {
		35507027,
		0,
		Lang.get(91972),
		35507,
		27,
		1009,
		{
			RTResTalkAction[56]
		}
	},
	[35507028] = {
		35507028,
		0,
		Lang.get(91973),
		35507,
		28,
		1009,
		{
			RTResTalkAction[35]
		}
	},
	[35508001] = {
		35508001,
		0,
		Lang.get(91974),
		35508,
		1,
		1184,
		nil,
		1,
		nil,
		-1,
		nil,
		177,
		35529,
		nil,
		1,
		nil,
		1,
		nil,
		35529
	},
	[35508002] = {
		35508002,
		0,
		Lang.get(91975),
		35508,
		2,
		247,
		nil,
		1
	},
	[35508003] = {
		35508003,
		0,
		Lang.get(91976),
		35508,
		3,
		1169,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[35508004] = {
		35508004,
		0,
		Lang.get(91977),
		35508,
		4,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35508005] = {
		35508005,
		0,
		Lang.get(91978),
		35508,
		5,
		1169,
		{
			RTResTalkAction[57],
			RTResTalkAction[41]
		}
	},
	[35508006] = {
		35508006,
		0,
		Lang.get(91979),
		35508,
		6,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35508007] = {
		35508007,
		0,
		Lang.get(91980),
		35508,
		7,
		1169,
		{
			RTResTalkAction[57],
			RTResTalkAction[41]
		}
	},
	[35508008] = {
		35508008,
		0,
		Lang.get(91981),
		35508,
		8,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35508009] = {
		35508009,
		0,
		Lang.get(91982),
		35508,
		9,
		1169,
		{
			RTResTalkAction[58],
			RTResTalkAction[41]
		}
	},
	[35508010] = {
		35508010,
		0,
		Lang.get(91983),
		35508,
		10,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35508011] = {
		35508011,
		0,
		Lang.get(91984),
		35508,
		11,
		1169,
		{
			RTResTalkAction[57],
			RTResTalkAction[41]
		}
	},
	[35508012] = {
		35508012,
		0,
		Lang.get(91985),
		35508,
		12,
		177,
		{
			RTResTalkAction[11],
			RTResTalkAction[41]
		}
	},
	[35508013] = {
		35508013,
		4,
		nil,
		35508,
		13,
		300,
		{
			RTResTalkAction[13],
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		nil,
		44,
		35530,
		nil,
		1,
		nil,
		nil,
		nil,
		35530,
		[29] = {
			{
				id = 35508014,
				branch_content = Lang.get(91986)
			}
		}
	},
	[35508014] = {
		35508014,
		0,
		Lang.get(91987),
		35508,
		14,
		200,
		nil,
		1
	},
	[35508015] = {
		35508015,
		3,
		Lang.get(91988),
		35508,
		15,
		605,
		[22] = 1
	},
	[35508016] = {
		35508016,
		0,
		Lang.get(91989),
		35508,
		16,
		300
	},
	[35508017] = {
		35508017,
		0,
		Lang.get(91990),
		35508,
		17,
		200,
		nil,
		1
	},
	[35508018] = {
		35508018,
		4,
		nil,
		35508,
		18,
		300,
		[29] = {
			{
				id = 35508019,
				branch_content = Lang.get(91991)
			},
			{
				id = 35508019,
				branch_content = Lang.get(91992)
			}
		}
	},
	[35508019] = {
		35508019,
		0,
		Lang.get(91993),
		35508,
		19,
		200,
		nil,
		1
	},
	[35508020] = {
		35508020,
		0,
		Lang.get(91994),
		35508,
		20,
		300
	},
	[35508021] = {
		35508021,
		0,
		Lang.get(91995),
		35508,
		21,
		200,
		nil,
		1
	},
	[35508022] = {
		35508022,
		0,
		Lang.get(91996),
		35508,
		22,
		300
	},
	[35508023] = {
		35508023,
		0,
		Lang.get(91997),
		35508,
		23,
		200,
		nil,
		1
	},
	[35508024] = {
		35508024,
		0,
		Lang.get(91998),
		35508,
		24,
		300
	},
	[35508025] = {
		35508025,
		0,
		Lang.get(91999),
		35508,
		25,
		200,
		nil,
		1
	},
	[35508026] = {
		35508026,
		0,
		Lang.get(92000),
		35508,
		26,
		300
	},
	[35508027] = {
		35508027,
		0,
		Lang.get(92001),
		35508,
		27,
		200,
		nil,
		1
	},
	[35508028] = {
		35508028,
		0,
		Lang.get(92002),
		35508,
		28,
		300
	},
	[35508029] = {
		35508029,
		3,
		Lang.get(91988),
		35508,
		29,
		605,
		nil,
		nil,
		nil,
		nil,
		1217,
		57,
		35531,
		nil,
		1,
		nil,
		nil,
		nil,
		35531,
		255,
		nil,
		1
	},
	[35508030] = {
		35508030,
		0,
		Lang.get(92003),
		35508,
		30,
		200,
		nil,
		1,
		[20] = -1
	},
	[35508031] = {
		35508031,
		0,
		Lang.get(92004),
		35508,
		31,
		300
	},
	[35508032] = {
		35508032,
		0,
		Lang.get(92005),
		35508,
		32,
		200,
		nil,
		1
	},
	[35508033] = {
		35508033,
		4,
		nil,
		35508,
		33,
		300,
		[29] = {
			{
				id = 35508034,
				branch_content = Lang.get(92006)
			}
		}
	},
	[35508034] = {
		35508034,
		0,
		Lang.get(92007),
		35508,
		34,
		200,
		nil,
		1
	},
	[35509001] = {
		35509001,
		0,
		Lang.get(92008),
		35509,
		1,
		200,
		nil,
		1,
		nil,
		-1,
		nil,
		177,
		35532,
		nil,
		1,
		nil,
		nil,
		nil,
		35532
	},
	[35509002] = {
		35509002,
		0,
		Lang.get(92009),
		35509,
		2,
		177,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[35509003] = {
		35509003,
		0,
		Lang.get(92010),
		35509,
		3,
		1169,
		{
			RTResTalkAction[30],
			RTResTalkAction[48]
		}
	},
	[35509004] = {
		35509004,
		0,
		Lang.get(92011),
		35509,
		4,
		273,
		{
			RTResTalkAction[33],
			RTResTalkAction[13]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		35533,
		nil,
		1,
		nil,
		nil,
		nil,
		35533
	},
	[35509005] = {
		35509005,
		0,
		Lang.get(92012),
		35509,
		5,
		273,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35534,
		nil,
		1,
		nil,
		nil,
		nil,
		35534
	},
	[35509006] = {
		35509006,
		0,
		Lang.get(92013),
		35509,
		6,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35509007] = {
		35509007,
		0,
		Lang.get(92014),
		35509,
		7,
		273,
		{
			RTResTalkAction[11],
			RTResTalkAction[59]
		}
	},
	[35509008] = {
		35509008,
		0,
		Lang.get(92015),
		35509,
		8,
		177,
		{
			RTResTalkAction[60],
			RTResTalkAction[41],
			RTResTalkAction[13]
		}
	},
	[35509009] = {
		35509009,
		0,
		Lang.get(92016),
		35509,
		9,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[61],
			RTResTalkAction[33]
		}
	},
	[35509010] = {
		35509010,
		0,
		Lang.get(92017),
		35509,
		10,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[13]
		}
	},
	[35509011] = {
		35509011,
		0,
		Lang.get(92018),
		35509,
		11,
		177,
		{
			RTResTalkAction[60],
			RTResTalkAction[41]
		}
	},
	[35509012] = {
		35509012,
		0,
		Lang.get(92019),
		35509,
		12,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[61],
			RTResTalkAction[33]
		}
	},
	[35509013] = {
		35509013,
		0,
		Lang.get(92020),
		35509,
		13,
		200,
		{
			RTResTalkAction[11],
			RTResTalkAction[54]
		}
	},
	[35509014] = {
		35509014,
		0,
		Lang.get(92021),
		35509,
		14,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[53]
		}
	},
	[35510001] = {
		35510001,
		0,
		Lang.get(92022),
		35510,
		1,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		50,
		35535,
		nil,
		1,
		nil,
		nil,
		nil,
		35535
	},
	[35510002] = {
		35510002,
		0,
		Lang.get(92023),
		35510,
		2,
		559,
		nil,
		1,
		1
	},
	[35510003] = {
		35510003,
		0,
		Lang.get(92024),
		35510,
		3,
		1071,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[35510004] = {
		35510004,
		0,
		Lang.get(92025),
		35510,
		4,
		134,
		{
			RTResTalkAction[64],
			RTResTalkAction[65]
		}
	},
	[35510005] = {
		35510005,
		0,
		Lang.get(92026),
		35510,
		5,
		1071,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		}
	},
	[35510006] = {
		35510006,
		0,
		Lang.get(92027),
		35510,
		6,
		560,
		{
			RTResTalkAction[65]
		},
		1,
		1
	},
	[35510007] = {
		35510007,
		3,
		Lang.get(92028),
		35510,
		7,
		605,
		[22] = 1
	},
	[35511001] = {
		35511001,
		0,
		Lang.get(92029),
		35511,
		1,
		177,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		35536,
		nil,
		1,
		nil,
		nil,
		nil,
		35536
	},
	[35511002] = {
		35511002,
		0,
		Lang.get(92030),
		35511,
		2,
		143,
		nil,
		1,
		1
	},
	[35511003] = {
		35511003,
		0,
		Lang.get(92031),
		35511,
		3,
		275,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		35537,
		nil,
		1,
		nil,
		nil,
		nil,
		35537
	},
	[35511004] = {
		35511004,
		0,
		Lang.get(92032),
		35511,
		4,
		177,
		nil,
		1
	},
	[35511005] = {
		35511005,
		0,
		Lang.get(92033),
		35511,
		5,
		768,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3,
		nil,
		60
	},
	[35511006] = {
		35511006,
		0,
		Lang.get(92034),
		35511,
		6,
		177,
		{
			RTResTalkAction[67],
			RTResTalkAction[41]
		}
	},
	[35511007] = {
		35511007,
		0,
		Lang.get(92035),
		35511,
		7,
		768,
		{
			RTResTalkAction[68],
			RTResTalkAction[33]
		}
	},
	[35511008] = {
		35511008,
		0,
		Lang.get(92036),
		35511,
		8,
		177,
		{
			RTResTalkAction[67],
			RTResTalkAction[41]
		}
	},
	[35511009] = {
		35511009,
		0,
		Lang.get(92037),
		35511,
		9,
		768,
		{
			RTResTalkAction[69],
			RTResTalkAction[33]
		}
	},
	[35511010] = {
		35511010,
		0,
		Lang.get(92038),
		35511,
		10,
		177,
		{
			RTResTalkAction[70]
		},
		1,
		0,
		-1,
		nil,
		nil,
		35538,
		nil,
		1,
		nil,
		nil,
		nil,
		35538
	},
	[35511011] = {
		35511011,
		0,
		Lang.get(92039),
		35511,
		11,
		143,
		nil,
		1,
		4
	},
	[35511012] = {
		35511012,
		0,
		Lang.get(92040),
		35511,
		12,
		275,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[35511013] = {
		35511013,
		0,
		Lang.get(92041),
		35511,
		13,
		768,
		{
			RTResTalkAction[66],
			RTResTalkAction[72]
		}
	},
	[35511014] = {
		35511014,
		0,
		Lang.get(92042),
		35511,
		14,
		177,
		{
			RTResTalkAction[73],
			RTResTalkAction[70]
		}
	},
	[35511015] = {
		35511015,
		0,
		Lang.get(92043),
		35511,
		15,
		177,
		{
			RTResTalkAction[29]
		}
	},
	[35512001] = {
		35512001,
		0,
		Lang.get(92044),
		35512,
		1,
		223,
		nil,
		1,
		1,
		-1,
		nil,
		132,
		35539,
		nil,
		1,
		nil,
		nil,
		nil,
		35539
	},
	[35512002] = {
		35512002,
		0,
		Lang.get(92045),
		35512,
		2,
		177,
		nil,
		1
	},
	[35512003] = {
		35512003,
		0,
		Lang.get(92046),
		35512,
		3,
		200,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[35512004] = {
		35512004,
		0,
		Lang.get(92047),
		35512,
		4,
		223,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512005] = {
		35512005,
		0,
		Lang.get(92048),
		35512,
		5,
		200,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512006] = {
		35512006,
		0,
		Lang.get(92049),
		35512,
		6,
		223,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512007] = {
		35512007,
		0,
		Lang.get(92050),
		35512,
		7,
		200,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512008] = {
		35512008,
		0,
		Lang.get(92051),
		35512,
		8,
		223,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512009] = {
		35512009,
		0,
		Lang.get(92052),
		35512,
		9,
		200,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512010] = {
		35512010,
		0,
		Lang.get(92053),
		35512,
		10,
		223,
		{
			RTResTalkAction[52],
			RTResTalkAction[74]
		}
	},
	[35512011] = {
		35512011,
		3,
		Lang.get(92054),
		35512,
		11,
		605,
		{
			RTResTalkAction[53],
			RTResTalkAction[23]
		},
		nil,
		nil,
		-1,
		1232,
		nil,
		35540,
		nil,
		1,
		nil,
		nil,
		nil,
		35540,
		nil,
		nil,
		1
	},
	[35512012] = {
		35512012,
		0,
		Lang.get(92055),
		35512,
		12,
		177,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[35512013] = {
		35512013,
		0,
		Lang.get(92056),
		35512,
		13,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[35512014] = {
		35512014,
		0,
		Lang.get(92057),
		35512,
		14,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[23]
		}
	},
	[35512015] = {
		35512015,
		0,
		Lang.get(92058),
		35512,
		15,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[53]
		}
	},
	[35512016] = {
		35512016,
		0,
		Lang.get(92059),
		35512,
		16,
		223,
		{
			RTResTalkAction[23]
		},
		1,
		1,
		-1,
		nil,
		177,
		35541,
		nil,
		1,
		nil,
		nil,
		nil,
		35541
	},
	[35512017] = {
		35512017,
		3,
		Lang.get(92060),
		35512,
		17,
		605,
		nil,
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[35512018] = {
		35512018,
		0,
		Lang.get(92061),
		35512,
		18,
		179,
		nil,
		1,
		0
	},
	[35512019] = {
		35512019,
		0,
		Lang.get(92062),
		35512,
		19,
		1009,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[35512020] = {
		35512020,
		0,
		Lang.get(92063),
		35512,
		20,
		1009,
		{
			RTResTalkAction[75]
		}
	},
	[35512021] = {
		35512021,
		0,
		Lang.get(92064),
		35512,
		21,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[35512022] = {
		35512022,
		3,
		Lang.get(91869),
		35512,
		22,
		605,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		-1,
		1230,
		nil,
		35542,
		nil,
		1,
		nil,
		nil,
		nil,
		35542,
		nil,
		nil,
		1
	},
	[35512023] = {
		35512023,
		0,
		Lang.get(92065),
		35512,
		23,
		223,
		nil,
		1,
		0
	},
	[35512024] = {
		35512024,
		0,
		Lang.get(92066),
		35512,
		24,
		1009,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[35512025] = {
		35512025,
		0,
		Lang.get(92067),
		35512,
		25,
		179,
		{
			RTResTalkAction[76],
			RTResTalkAction[34]
		}
	},
	[35512026] = {
		35512026,
		0,
		Lang.get(92068),
		35512,
		26,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[35512027] = {
		35512027,
		0,
		Lang.get(92069),
		35512,
		27,
		179,
		{
			RTResTalkAction[77]
		}
	},
	[35512028] = {
		35512028,
		0,
		Lang.get(92070),
		35512,
		28,
		300,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		-1,
		nil,
		60,
		35543,
		nil,
		1,
		nil,
		2,
		nil,
		35543
	},
	[35512029] = {
		35512029,
		0,
		Lang.get(92071),
		35512,
		29,
		1009,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[35512030] = {
		35512030,
		0,
		Lang.get(92072),
		35512,
		30,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[35512031] = {
		35512031,
		0,
		Lang.get(92073),
		35512,
		31,
		179,
		{
			RTResTalkAction[76],
			RTResTalkAction[23]
		}
	},
	[35512032] = {
		35512032,
		0,
		Lang.get(92074),
		35512,
		32,
		223,
		{
			RTResTalkAction[22],
			RTResTalkAction[25]
		}
	},
	[35512033] = {
		35512033,
		0,
		Lang.get(92075),
		35512,
		33,
		1009,
		{
			RTResTalkAction[75],
			RTResTalkAction[23]
		}
	},
	[35512034] = {
		35512034,
		4,
		nil,
		35512,
		34,
		300,
		{
			RTResTalkAction[47],
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 35512035,
				branch_content = Lang.get(92076)
			}
		}
	},
	[35512035] = {
		35512035,
		0,
		Lang.get(92077),
		35512,
		35,
		179,
		{
			RTResTalkAction[76],
			RTResTalkAction[34]
		}
	},
	[35513001] = {
		35513001,
		0,
		Lang.get(92078),
		35513,
		1,
		1169,
		nil,
		1,
		3,
		nil,
		nil,
		45,
		35544,
		nil,
		1,
		nil,
		nil,
		nil,
		35544
	},
	[35513002] = {
		35513002,
		0,
		Lang.get(92079),
		35513,
		2,
		1169,
		nil,
		1,
		2
	},
	[35513003] = {
		35513003,
		0,
		Lang.get(22255),
		35513,
		3,
		565,
		nil,
		nil,
		nil,
		nil,
		1231,
		nil,
		35545,
		nil,
		1,
		nil,
		1,
		nil,
		35545
	},
	[35513004] = {
		35513004,
		0,
		Lang.get(92080),
		35513,
		4,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35513005] = {
		35513005,
		0,
		Lang.get(92081),
		35513,
		5,
		1178,
		{
			RTResTalkAction[78],
			RTResTalkAction[13]
		}
	},
	[35513006] = {
		35513006,
		0,
		Lang.get(92082),
		35513,
		6,
		1179,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[35513007] = {
		35513007,
		2,
		Lang.get(92083),
		35513,
		7,
		1169,
		{
			RTResTalkAction[81]
		},
		1,
		2,
		-1,
		nil,
		176,
		35546,
		nil,
		1,
		nil,
		1,
		nil,
		35546
	},
	[35513008] = {
		35513008,
		0,
		Lang.get(92084),
		35513,
		8,
		1169,
		nil,
		1,
		3
	},
	[35513009] = {
		35513009,
		0,
		Lang.get(92085),
		35513,
		9,
		1178,
		{
			RTResTalkAction[82]
		}
	},
	[35513010] = {
		35513010,
		0,
		Lang.get(92086),
		35513,
		10,
		1179,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[35513011] = {
		35513011,
		0,
		Lang.get(92087),
		35513,
		11,
		1178,
		{
			RTResTalkAction[82],
			RTResTalkAction[81]
		}
	},
	[35513012] = {
		35513012,
		0,
		Lang.get(92088),
		35513,
		12,
		1178,
		{
			RTResTalkAction[82]
		}
	},
	[35513013] = {
		35513013,
		0,
		Lang.get(92089),
		35513,
		13,
		1179,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[35513014] = {
		35513014,
		0,
		Lang.get(92090),
		35513,
		14,
		1179,
		{
			RTResTalkAction[79]
		}
	},
	[35513015] = {
		35513015,
		0,
		Lang.get(92091),
		35513,
		15,
		1069,
		{
			RTResTalkAction[81]
		},
		1,
		1,
		nil,
		nil,
		nil,
		35547,
		nil,
		1,
		nil,
		nil,
		nil,
		35547
	},
	[35513016] = {
		35513016,
		0,
		Lang.get(92092),
		35513,
		16,
		1069,
		nil,
		1,
		1
	},
	[35513017] = {
		35513017,
		0,
		Lang.get(92093),
		35513,
		17,
		1069,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[35513018] = {
		35513018,
		0,
		Lang.get(92094),
		35513,
		18,
		1069,
		{
			RTResTalkAction[84]
		}
	},
	[35513019] = {
		35513019,
		0,
		Lang.get(92095),
		35513,
		19,
		1172,
		{
			RTResTalkAction[85]
		},
		1,
		0,
		-1,
		nil,
		63,
		35548,
		nil,
		1,
		nil,
		nil,
		nil,
		35548
	},
	[35513020] = {
		35513020,
		7,
		"102",
		35513,
		20,
		1172
	},
	[35513021] = {
		35513021,
		0,
		Lang.get(92096),
		35513,
		21,
		1172,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[35513022] = {
		35513022,
		2,
		Lang.get(92097),
		35513,
		22,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[35513023] = {
		35513023,
		2,
		Lang.get(92098),
		35513,
		23,
		1169,
		{
			RTResTalkAction[87]
		}
	},
	[35513024] = {
		35513024,
		2,
		Lang.get(92099),
		35513,
		24,
		1169,
		{
			RTResTalkAction[87]
		}
	},
	[35513025] = {
		35513025,
		0,
		Lang.get(92100),
		35513,
		25,
		1169,
		{
			RTResTalkAction[13]
		},
		1,
		4,
		-1,
		nil,
		nil,
		35549,
		nil,
		1,
		nil,
		nil,
		nil,
		35549
	},
	[35513026] = {
		35513026,
		0,
		Lang.get(22255),
		35513,
		26,
		565,
		nil,
		nil,
		nil,
		nil,
		1231
	},
	[35513027] = {
		35513027,
		0,
		Lang.get(92101),
		35513,
		27,
		1172,
		nil,
		1,
		nil,
		nil,
		nil,
		45,
		35550,
		nil,
		1,
		nil,
		nil,
		nil,
		35550
	},
	[35514001] = {
		35514001,
		0,
		Lang.get(92102),
		35514,
		1,
		1069,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		35551,
		nil,
		1,
		nil,
		nil,
		nil,
		35551
	},
	[35514002] = {
		35514002,
		0,
		Lang.get(92103),
		35514,
		2,
		1069,
		nil,
		1,
		2
	},
	[35514003] = {
		35514003,
		0,
		Lang.get(92104),
		35514,
		3,
		1069,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[35514004] = {
		35514004,
		0,
		Lang.get(92105),
		35514,
		4,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[85]
		}
	},
	[35514005] = {
		35514005,
		0,
		Lang.get(92106),
		35514,
		5,
		1172,
		{
			RTResTalkAction[86]
		}
	},
	[35514006] = {
		35514006,
		0,
		Lang.get(92107),
		35514,
		6,
		1069,
		{
			RTResTalkAction[83],
			RTResTalkAction[88]
		}
	},
	[35514007] = {
		35514007,
		0,
		Lang.get(92108),
		35514,
		7,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[85]
		}
	},
	[35514008] = {
		35514008,
		0,
		Lang.get(92109),
		35514,
		8,
		1172,
		{
			RTResTalkAction[86]
		}
	},
	[35514009] = {
		35514009,
		0,
		Lang.get(92110),
		35514,
		9,
		1069,
		{
			RTResTalkAction[84],
			RTResTalkAction[88]
		}
	},
	[35514010] = {
		35514010,
		0,
		Lang.get(92111),
		35514,
		10,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[85]
		}
	},
	[35514011] = {
		35514011,
		0,
		Lang.get(92112),
		35514,
		11,
		1172,
		{
			RTResTalkAction[86]
		}
	},
	[35514012] = {
		35514012,
		0,
		Lang.get(92113),
		35514,
		12,
		1069,
		{
			RTResTalkAction[84],
			RTResTalkAction[88]
		}
	},
	[35514013] = {
		35514013,
		0,
		Lang.get(92114),
		35514,
		13,
		1069,
		{
			RTResTalkAction[84]
		}
	},
	[35514014] = {
		35514014,
		0,
		Lang.get(92115),
		35514,
		14,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[85]
		}
	},
	[35514015] = {
		35514015,
		0,
		Lang.get(92116),
		35514,
		15,
		1172,
		{
			RTResTalkAction[88]
		},
		1,
		nil,
		-1,
		nil,
		176,
		35552,
		nil,
		1,
		nil,
		nil,
		nil,
		35552
	},
	[35514016] = {
		35514016,
		0,
		Lang.get(92117),
		35514,
		16,
		1172,
		nil,
		1
	},
	[35514017] = {
		35514017,
		2,
		Lang.get(92118),
		35514,
		17,
		1169,
		nil,
		1,
		3
	},
	[35514018] = {
		35514018,
		0,
		Lang.get(92119),
		35514,
		18,
		1056,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		35553,
		nil,
		1,
		nil,
		nil,
		nil,
		35553
	},
	[35514019] = {
		35514019,
		0,
		Lang.get(92120),
		35514,
		19,
		1057,
		nil,
		1
	},
	[35514020] = {
		35514020,
		0,
		Lang.get(92121),
		35514,
		20,
		1058,
		{
			RTResTalkAction[90]
		},
		nil,
		nil,
		3
	},
	[35514021] = {
		35514021,
		0,
		Lang.get(92122),
		35514,
		21,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[91]
		}
	},
	[35514022] = {
		35514022,
		0,
		Lang.get(92123),
		35514,
		22,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[35514023] = {
		35514023,
		3,
		Lang.get(35349),
		35514,
		23,
		605,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		35554,
		nil,
		1,
		nil,
		nil,
		nil,
		35554,
		nil,
		nil,
		1
	},
	[35514024] = {
		35514024,
		0,
		Lang.get(92124),
		35514,
		24,
		1169,
		nil,
		1,
		1
	},
	[35514025] = {
		35514025,
		0,
		Lang.get(92125),
		35514,
		25,
		1172,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[35514026] = {
		35514026,
		0,
		Lang.get(92126),
		35514,
		26,
		1057,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[35514027] = {
		35514027,
		0,
		Lang.get(92127),
		35514,
		27,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[94]
		}
	},
	[35514028] = {
		35514028,
		0,
		Lang.get(92128),
		35514,
		28,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[13]
		}
	},
	[35515001] = {
		35515001,
		0,
		Lang.get(92129),
		35515,
		1,
		1172,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		35555,
		nil,
		1,
		nil,
		nil,
		nil,
		35555
	},
	[35515002] = {
		35515002,
		0,
		Lang.get(92130),
		35515,
		2,
		1056,
		nil,
		1
	},
	[35515003] = {
		35515003,
		0,
		Lang.get(92131),
		35515,
		3,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35515004] = {
		35515004,
		0,
		Lang.get(92132),
		35515,
		4,
		1058,
		{
			RTResTalkAction[95],
			RTResTalkAction[13]
		}
	},
	[35515005] = {
		35515005,
		0,
		Lang.get(92133),
		35515,
		5,
		1057,
		{
			RTResTalkAction[93],
			RTResTalkAction[91]
		}
	},
	[35515006] = {
		35515006,
		0,
		Lang.get(92134),
		35515,
		6,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[94]
		}
	},
	[35515007] = {
		35515007,
		0,
		Lang.get(92135),
		35515,
		7,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35515008] = {
		35515008,
		0,
		Lang.get(92136),
		35515,
		8,
		1057,
		{
			RTResTalkAction[93],
			RTResTalkAction[88]
		}
	},
	[35515009] = {
		35515009,
		0,
		Lang.get(92137),
		35515,
		9,
		1056,
		{
			RTResTalkAction[7],
			RTResTalkAction[94]
		}
	},
	[35515010] = {
		35515010,
		0,
		Lang.get(92138),
		35515,
		10,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[6]
		}
	},
	[35515011] = {
		35515011,
		0,
		Lang.get(92139),
		35515,
		11,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[35515012] = {
		35515012,
		0,
		Lang.get(92140),
		35515,
		12,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35515013] = {
		35515013,
		3,
		Lang.get(92141),
		35515,
		13,
		605,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[35515014] = {
		35515014,
		5,
		Lang.get(92142),
		35515,
		14,
		134,
		{
			RTResTalkAction[88]
		},
		1,
		5,
		-1,
		nil,
		20,
		35557,
		nil,
		nil,
		nil,
		nil,
		nil,
		35557
	},
	[35515015] = {
		35515015,
		5,
		Lang.get(75334),
		35515,
		15,
		605,
		nil,
		nil,
		nil,
		nil,
		1232
	},
	[35515016] = {
		35515016,
		0,
		Lang.get(92143),
		35515,
		16,
		1169,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		3
	},
	[35515017] = {
		35515017,
		0,
		Lang.get(92144),
		35515,
		17,
		134,
		{
			RTResTalkAction[55],
			RTResTalkAction[13]
		}
	},
	[35515018] = {
		35515018,
		0,
		Lang.get(92145),
		35515,
		18,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[38]
		}
	},
	[35515019] = {
		35515019,
		0,
		Lang.get(92146),
		35515,
		19,
		134,
		{
			RTResTalkAction[55],
			RTResTalkAction[13]
		}
	},
	[35515020] = {
		35515020,
		0,
		Lang.get(92147),
		35515,
		20,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[38]
		}
	},
	[35515021] = {
		35515021,
		0,
		Lang.get(92148),
		35515,
		21,
		134,
		{
			RTResTalkAction[96],
			RTResTalkAction[88]
		}
	},
	[35515022] = {
		35515022,
		0,
		Lang.get(92149),
		35515,
		22,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[38]
		}
	},
	[35515023] = {
		35515023,
		0,
		Lang.get(92150),
		35515,
		23,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[13]
		}
	},
	[35515024] = {
		35515024,
		3,
		Lang.get(92151),
		35515,
		24,
		605,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[35515025] = {
		35515025,
		0,
		Lang.get(92152),
		35515,
		25,
		1169,
		{
			RTResTalkAction[88]
		},
		1,
		3,
		-1,
		nil,
		nil,
		35559,
		nil,
		nil,
		nil,
		nil,
		nil,
		35559
	},
	[35515026] = {
		35515026,
		3,
		Lang.get(92153),
		35515,
		26,
		605,
		[22] = 1
	},
	[35515027] = {
		35515027,
		0,
		Lang.get(92154),
		35515,
		27,
		134,
		nil,
		1,
		4,
		-1,
		nil,
		nil,
		35560,
		nil,
		1,
		nil,
		nil,
		nil,
		35560
	},
	[35515028] = {
		35515028,
		0,
		Lang.get(92155),
		35515,
		28,
		1172,
		nil,
		1,
		0
	},
	[35515029] = {
		35515029,
		0,
		Lang.get(92156),
		35515,
		29,
		134,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[35516001] = {
		35516001,
		0,
		Lang.get(92157),
		35516,
		1,
		1172,
		nil,
		1,
		0,
		-1,
		nil,
		177,
		35561,
		nil,
		1,
		nil,
		nil,
		nil,
		35561
	},
	[35516002] = {
		35516002,
		0,
		Lang.get(92158),
		35516,
		2,
		134,
		nil,
		1,
		3
	},
	[35516003] = {
		35516003,
		0,
		Lang.get(92159),
		35516,
		3,
		1169,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		3
	},
	[35516004] = {
		35516004,
		0,
		Lang.get(92160),
		35516,
		4,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[13]
		}
	},
	[35516005] = {
		35516005,
		0,
		Lang.get(92161),
		35516,
		5,
		134,
		{
			RTResTalkAction[55],
			RTResTalkAction[88]
		}
	},
	[35516006] = {
		35516006,
		0,
		Lang.get(92162),
		35516,
		6,
		134,
		{
			RTResTalkAction[55]
		}
	},
	[35516007] = {
		35516007,
		0,
		Lang.get(92163),
		35516,
		7,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[38]
		}
	},
	[35516008] = {
		35516008,
		0,
		Lang.get(92164),
		35516,
		8,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35516009] = {
		35516009,
		0,
		Lang.get(92165),
		35516,
		9,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[88]
		}
	},
	[35516010] = {
		35516010,
		0,
		Lang.get(92166),
		35516,
		10,
		1169,
		{
			RTResTalkAction[92]
		}
	},
	[35516011] = {
		35516011,
		0,
		Lang.get(92167),
		35516,
		11,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35516012] = {
		35516012,
		0,
		Lang.get(92168),
		35516,
		12,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[88]
		}
	},
	[35516013] = {
		35516013,
		0,
		Lang.get(92169),
		35516,
		13,
		134,
		{
			RTResTalkAction[97],
			RTResTalkAction[98]
		}
	},
	[35516014] = {
		35516014,
		0,
		Lang.get(92170),
		35516,
		14,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[38]
		}
	},
	[35516015] = {
		35516015,
		0,
		Lang.get(92171),
		35516,
		15,
		134,
		{
			RTResTalkAction[13]
		},
		1,
		2,
		-1,
		nil,
		nil,
		35562,
		nil,
		1,
		nil,
		nil,
		nil,
		35562
	},
	[35516016] = {
		35516016,
		0,
		Lang.get(92172),
		35516,
		16,
		1169,
		nil,
		1,
		1
	},
	[35516017] = {
		35516017,
		0,
		Lang.get(92173),
		35516,
		17,
		1172,
		{
			RTResTalkAction[89]
		}
	},
	[35516018] = {
		35516018,
		5,
		Lang.get(92174),
		35516,
		18,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[35516019] = {
		35516019,
		0,
		Lang.get(92175),
		35516,
		19,
		1172,
		{
			RTResTalkAction[13]
		},
		1,
		0,
		-1,
		nil,
		45,
		35558,
		nil,
		1,
		nil,
		nil,
		nil,
		35558
	},
	[35516020] = {
		35516020,
		0,
		Lang.get(92176),
		35516,
		20,
		1169,
		nil,
		1,
		4
	},
	[35516021] = {
		35516021,
		0,
		Lang.get(92177),
		35516,
		21,
		1172,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[35516022] = {
		35516022,
		0,
		Lang.get(92178),
		35516,
		22,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[35516023] = {
		35516023,
		0,
		Lang.get(92179),
		35516,
		23,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35516024] = {
		35516024,
		0,
		Lang.get(92180),
		35516,
		24,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[88]
		}
	},
	[35516025] = {
		35516025,
		0,
		Lang.get(92181),
		35516,
		25,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35516026] = {
		35516026,
		0,
		Lang.get(92182),
		35516,
		26,
		1169,
		{
			RTResTalkAction[99],
			RTResTalkAction[88]
		}
	},
	[35516027] = {
		35516027,
		0,
		Lang.get(92183),
		35516,
		27,
		1172,
		{
			RTResTalkAction[89],
			RTResTalkAction[13]
		}
	},
	[35516028] = {
		35516028,
		5,
		Lang.get(92184),
		35516,
		28,
		605,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		1222
	},
	[35516029] = {
		35516029,
		0,
		Lang.get(92185),
		35516,
		29,
		1169,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[35516030] = {
		35516030,
		0,
		Lang.get(92186),
		35516,
		30,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[13]
		}
	},
	[35517001] = {
		35517001,
		0,
		Lang.get(92187),
		35517,
		1,
		273,
		nil,
		1,
		nil,
		-1,
		nil,
		25,
		35604,
		nil,
		1,
		nil,
		nil,
		nil,
		35604
	},
	[35517002] = {
		35517002,
		0,
		Lang.get(92188),
		35517,
		2,
		177,
		{
			RTResTalkAction[29]
		}
	},
	[35517003] = {
		35517003,
		0,
		Lang.get(92189),
		35517,
		3,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[33]
		}
	},
	[35517004] = {
		35517004,
		0,
		Lang.get(92190),
		35517,
		4,
		1169,
		{
			RTResTalkAction[101]
		},
		1,
		3,
		-1,
		nil,
		nil,
		35563,
		nil,
		1,
		nil,
		nil,
		nil,
		35563
	},
	[35517005] = {
		35517005,
		0,
		Lang.get(92191),
		35517,
		5,
		1169,
		nil,
		1,
		3
	},
	[35517006] = {
		35517006,
		0,
		Lang.get(92192),
		35517,
		6,
		1172,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[35517007] = {
		35517007,
		0,
		Lang.get(92193),
		35517,
		7,
		1169,
		{
			RTResTalkAction[102],
			RTResTalkAction[48]
		}
	},
	[35517008] = {
		35517008,
		0,
		Lang.get(92194),
		35517,
		8,
		207,
		{
			RTResTalkAction[103],
			RTResTalkAction[104],
			RTResTalkAction[105]
		}
	},
	[35517009] = {
		35517009,
		0,
		Lang.get(92195),
		35517,
		9,
		1169,
		{
			RTResTalkAction[57],
			RTResTalkAction[106],
			RTResTalkAction[88]
		}
	},
	[35517010] = {
		35517010,
		0,
		Lang.get(92196),
		35517,
		10,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[13],
			RTResTalkAction[101]
		}
	},
	[35517011] = {
		35517011,
		0,
		Lang.get(92197),
		35517,
		11,
		1180,
		{
			RTResTalkAction[88]
		},
		1,
		nil,
		-1,
		nil,
		168,
		35564,
		nil,
		1,
		nil,
		nil,
		nil,
		35564
	},
	[35517012] = {
		35517012,
		0,
		Lang.get(92198),
		35517,
		12,
		1180,
		nil,
		1
	},
	[35517013] = {
		35517013,
		0,
		Lang.get(92199),
		35517,
		13,
		207,
		nil,
		1
	},
	[35517014] = {
		35517014,
		0,
		Lang.get(92200),
		35517,
		14,
		1169,
		nil,
		1,
		2
	},
	[35517015] = {
		35517015,
		0,
		Lang.get(92201),
		35517,
		15,
		207,
		nil,
		1
	},
	[35517016] = {
		35517016,
		0,
		Lang.get(92202),
		35517,
		16,
		207,
		nil,
		1
	},
	[35517017] = {
		35517017,
		0,
		Lang.get(92203),
		35517,
		17,
		1169,
		nil,
		1,
		1
	},
	[35517018] = {
		35517018,
		0,
		Lang.get(92204),
		35517,
		18,
		1180,
		nil,
		1
	},
	[35517019] = {
		35517019,
		0,
		Lang.get(17874),
		35517,
		19,
		207,
		nil,
		1
	},
	[35517020] = {
		35517020,
		0,
		Lang.get(92205),
		35517,
		20,
		1169,
		nil,
		1,
		2
	},
	[35517021] = {
		35517021,
		0,
		Lang.get(92206),
		35517,
		21,
		1180,
		nil,
		1
	},
	[35517022] = {
		35517022,
		0,
		Lang.get(92207),
		35517,
		22,
		1180,
		nil,
		1
	},
	[35517023] = {
		35517023,
		0,
		Lang.get(92208),
		35517,
		23,
		1180,
		nil,
		1
	},
	[35517024] = {
		35517024,
		0,
		Lang.get(92209),
		35517,
		24,
		1169,
		nil,
		1,
		4
	},
	[35517025] = {
		35517025,
		0,
		Lang.get(92210),
		35517,
		25,
		1172,
		nil,
		1
	},
	[35517026] = {
		35517026,
		0,
		Lang.get(92211),
		35517,
		26,
		1169,
		nil,
		1,
		2
	},
	[35520001] = {
		35520001,
		0,
		Lang.get(92212),
		35520,
		1,
		1180,
		nil,
		1,
		nil,
		-1,
		nil,
		168,
		35565,
		nil,
		1,
		nil,
		nil,
		nil,
		35565
	},
	[35520002] = {
		35520002,
		0,
		Lang.get(92213),
		35520,
		2,
		273,
		nil,
		1
	},
	[35520003] = {
		35520003,
		0,
		Lang.get(92214),
		35520,
		3,
		273,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[35520004] = {
		35520004,
		0,
		Lang.get(92215),
		35520,
		4,
		1172,
		{
			RTResTalkAction[86],
			RTResTalkAction[61]
		}
	},
	[35520005] = {
		35520005,
		0,
		Lang.get(92216),
		35520,
		5,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[88]
		}
	},
	[35520006] = {
		35520006,
		0,
		Lang.get(92217),
		35520,
		6,
		1182,
		{
			RTResTalkAction[107],
			RTResTalkAction[101]
		}
	},
	[35520007] = {
		35520007,
		0,
		Lang.get(92218),
		35520,
		7,
		1169,
		{
			RTResTalkAction[21],
			RTResTalkAction[108]
		}
	},
	[35520008] = {
		35520008,
		0,
		Lang.get(92219),
		35520,
		8,
		1169,
		{
			RTResTalkAction[14]
		}
	},
	[35521001] = {
		35521001,
		0,
		Lang.get(92220),
		35521,
		1,
		177,
		{
			RTResTalkAction[107]
		},
		1,
		nil,
		-1,
		nil,
		51,
		35566,
		nil,
		1,
		nil,
		1,
		nil,
		35566
	},
	[35521002] = {
		35521002,
		0,
		Lang.get(92221),
		35521,
		2,
		1169,
		{
			RTResTalkAction[107]
		},
		1,
		1
	},
	[35521003] = {
		35521003,
		0,
		Lang.get(92222),
		35521,
		3,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[108]
		},
		nil,
		nil,
		3
	},
	[35521004] = {
		35521004,
		0,
		Lang.get(92223),
		35521,
		4,
		1169,
		{
			RTResTalkAction[60],
			RTResTalkAction[48]
		}
	},
	[35521005] = {
		35521005,
		0,
		Lang.get(92224),
		35521,
		5,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[13]
		}
	},
	[35521006] = {
		35521006,
		0,
		Lang.get(92225),
		35521,
		6,
		273,
		{
			RTResTalkAction[62]
		}
	},
	[35521007] = {
		35521007,
		0,
		Lang.get(18514),
		35521,
		7,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[61]
		}
	},
	[35521008] = {
		35521008,
		0,
		Lang.get(92226),
		35521,
		8,
		177,
		{
			RTResTalkAction[109],
			RTResTalkAction[41]
		}
	},
	[35521009] = {
		35521009,
		0,
		Lang.get(92227),
		35521,
		9,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[33]
		}
	},
	[35521010] = {
		35521010,
		0,
		Lang.get(92228),
		35521,
		10,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[101]
		}
	},
	[35521011] = {
		35521011,
		0,
		Lang.get(92229),
		35521,
		11,
		1169,
		{
			RTResTalkAction[21],
			RTResTalkAction[61]
		}
	},
	[35521012] = {
		35521012,
		0,
		Lang.get(92230),
		35521,
		12,
		207,
		{
			RTResTalkAction[57],
			RTResTalkAction[106]
		}
	},
	[35521013] = {
		35521013,
		0,
		Lang.get(92231),
		35521,
		13,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[101]
		}
	},
	[35521014] = {
		35521014,
		0,
		Lang.get(92232),
		35521,
		14,
		273,
		{
			RTResTalkAction[11],
			RTResTalkAction[59]
		}
	},
	[35521015] = {
		35521015,
		0,
		Lang.get(92233),
		35521,
		15,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[13],
			RTResTalkAction[61]
		}
	},
	[35521016] = {
		35521016,
		0,
		Lang.get(92234),
		35521,
		16,
		273,
		{
			RTResTalkAction[109],
			RTResTalkAction[59]
		}
	},
	[35521017] = {
		35521017,
		0,
		Lang.get(92235),
		35521,
		17,
		177,
		{
			RTResTalkAction[109],
			RTResTalkAction[41],
			RTResTalkAction[61]
		}
	},
	[35521018] = {
		35521018,
		0,
		Lang.get(92236),
		35521,
		18,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[33]
		}
	},
	[35521019] = {
		35521019,
		0,
		Lang.get(92237),
		35521,
		19,
		273,
		{
			RTResTalkAction[109],
			RTResTalkAction[59]
		}
	},
	[35521020] = {
		35521020,
		0,
		Lang.get(92238),
		35521,
		20,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[61]
		}
	},
	[35521021] = {
		35521021,
		0,
		Lang.get(92239),
		35521,
		21,
		273,
		{
			RTResTalkAction[109],
			RTResTalkAction[59]
		}
	},
	[35521022] = {
		35521022,
		0,
		Lang.get(92240),
		35521,
		22,
		207,
		{
			RTResTalkAction[100],
			RTResTalkAction[61]
		}
	},
	[35521023] = {
		35521023,
		5,
		Lang.get(92241),
		35521,
		23,
		177,
		{
			RTResTalkAction[101]
		},
		nil,
		nil,
		-1,
		nil,
		50,
		35567,
		nil,
		1,
		nil,
		nil,
		nil,
		35567
	},
	[35521024] = {
		35521024,
		0,
		Lang.get(92242),
		35521,
		24,
		207,
		nil,
		1
	},
	[35521025] = {
		35521025,
		0,
		Lang.get(92243),
		35521,
		25,
		1169,
		nil,
		1,
		4,
		-1,
		nil,
		198,
		35568,
		nil,
		1,
		nil,
		nil,
		nil,
		35568
	},
	[35521026] = {
		35521026,
		0,
		Lang.get(92244),
		35521,
		26,
		1056,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[35521027] = {
		35521027,
		0,
		Lang.get(92245),
		35521,
		27,
		1169,
		{
			RTResTalkAction[92],
			RTResTalkAction[6]
		}
	},
	[35521028] = {
		35521028,
		0,
		Lang.get(92246),
		35521,
		28,
		1057,
		{
			RTResTalkAction[11],
			RTResTalkAction[110]
		}
	},
	[35521029] = {
		35521029,
		0,
		Lang.get(92247),
		35521,
		29,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[94]
		}
	},
	[35521030] = {
		35521030,
		0,
		Lang.get(92248),
		35521,
		30,
		1056,
		{
			RTResTalkAction[7],
			RTResTalkAction[13]
		}
	},
	[35521031] = {
		35521031,
		0,
		Lang.get(92249),
		35521,
		31,
		1058,
		{
			RTResTalkAction[90],
			RTResTalkAction[6]
		}
	},
	[35521032] = {
		35521032,
		0,
		Lang.get(92250),
		35521,
		32,
		1169,
		{
			RTResTalkAction[21],
			RTResTalkAction[91]
		}
	},
	[35522001] = {
		35522001,
		0,
		Lang.get(92251),
		35522,
		1,
		226,
		nil,
		1,
		1,
		-1,
		nil,
		134,
		35569,
		nil,
		1,
		nil,
		nil,
		nil,
		35569,
		255
	},
	[35522002] = {
		35522002,
		0,
		Lang.get(92252),
		35522,
		2,
		226,
		nil,
		1,
		1,
		[20] = 255
	},
	[35522003] = {
		35522003,
		0,
		Lang.get(92253),
		35522,
		3,
		226,
		nil,
		1,
		2,
		[20] = 255
	},
	[35522004] = {
		35522004,
		0,
		Lang.get(92254),
		35522,
		4,
		226,
		nil,
		1,
		2,
		[20] = -1
	},
	[35522005] = {
		35522005,
		0,
		Lang.get(92255),
		35522,
		5,
		226,
		nil,
		1,
		1
	},
	[35522006] = {
		35522006,
		0,
		Lang.get(44609),
		35522,
		6,
		223,
		nil,
		1,
		1
	},
	[35522007] = {
		35522007,
		0,
		Lang.get(92256),
		35522,
		7,
		223,
		{
			RTResTalkAction[111]
		},
		[20] = 3
	},
	[35522008] = {
		35522008,
		0,
		Lang.get(92257),
		35522,
		8,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522009] = {
		35522009,
		0,
		Lang.get(92258),
		35522,
		9,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522010] = {
		35522010,
		0,
		Lang.get(92259),
		35522,
		10,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522011] = {
		35522011,
		0,
		Lang.get(92260),
		35522,
		11,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522012] = {
		35522012,
		0,
		Lang.get(92261),
		35522,
		12,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522013] = {
		35522013,
		0,
		Lang.get(92262),
		35522,
		13,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522014] = {
		35522014,
		0,
		Lang.get(92263),
		35522,
		14,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522015] = {
		35522015,
		0,
		Lang.get(92264),
		35522,
		15,
		223,
		{
			RTResTalkAction[26],
			RTResTalkAction[113]
		}
	},
	[35522016] = {
		35522016,
		0,
		Lang.get(92265),
		35522,
		16,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522017] = {
		35522017,
		0,
		Lang.get(92266),
		35522,
		17,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522018] = {
		35522018,
		0,
		Lang.get(92267),
		35522,
		18,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522019] = {
		35522019,
		0,
		Lang.get(92268),
		35522,
		19,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522020] = {
		35522020,
		0,
		Lang.get(92269),
		35522,
		20,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522021] = {
		35522021,
		0,
		Lang.get(92270),
		35522,
		21,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522022] = {
		35522022,
		0,
		Lang.get(92271),
		35522,
		22,
		226,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522023] = {
		35522023,
		0,
		Lang.get(92272),
		35522,
		23,
		223,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35522024] = {
		35522024,
		0,
		Lang.get(92273),
		35522,
		24,
		226,
		{
			RTResTalkAction[114],
			RTResTalkAction[23]
		}
	},
	[35523001] = {
		35523001,
		0,
		Lang.get(92274),
		35523,
		1,
		1056,
		nil,
		1,
		nil,
		-1,
		nil,
		136,
		35570,
		nil,
		1,
		nil,
		nil,
		nil,
		35570
	},
	[35523002] = {
		35523002,
		0,
		Lang.get(92275),
		35523,
		2,
		1173,
		nil,
		1
	},
	[35523003] = {
		35523003,
		0,
		Lang.get(92276),
		35523,
		3,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35523004] = {
		35523004,
		0,
		Lang.get(92277),
		35523,
		4,
		1173,
		{
			RTResTalkAction[115],
			RTResTalkAction[13]
		}
	},
	[35523005] = {
		35523005,
		0,
		Lang.get(92278),
		35523,
		5,
		1169,
		{
			RTResTalkAction[116],
			RTResTalkAction[117]
		}
	},
	[35524001] = {
		35524001,
		0,
		Lang.get(92279),
		35524,
		1,
		1169,
		nil,
		1,
		2,
		-1,
		nil,
		198,
		35571,
		nil,
		1,
		nil,
		1,
		nil,
		35571,
		255
	},
	[35524002] = {
		35524002,
		0,
		Lang.get(92280),
		35524,
		2,
		1169,
		nil,
		1,
		1,
		[20] = 255
	},
	[35524003] = {
		35524003,
		3,
		Lang.get(92281),
		35524,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		1067,
		[22] = 1,
		[20] = -1
	},
	[35524004] = {
		35524004,
		0,
		Lang.get(92282),
		35524,
		4,
		1169,
		nil,
		1,
		3
	},
	[35524005] = {
		35524005,
		0,
		Lang.get(92283),
		35524,
		5,
		134
	},
	[35524006] = {
		35524006,
		0,
		Lang.get(92284),
		35524,
		6,
		1009
	},
	[35524007] = {
		35524007,
		0,
		Lang.get(92285),
		35524,
		7,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35524008] = {
		35524008,
		3,
		Lang.get(92286),
		35524,
		8,
		605,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		1068,
		168,
		35572,
		nil,
		1,
		nil,
		1,
		nil,
		35572,
		255,
		nil,
		1
	},
	[35524009] = {
		35524009,
		0,
		Lang.get(92287),
		35524,
		9,
		1169,
		nil,
		1,
		2,
		[20] = -1
	},
	[35524010] = {
		35524010,
		0,
		Lang.get(92288),
		35524,
		10,
		1180,
		nil,
		1
	},
	[35524011] = {
		35524011,
		0,
		Lang.get(92289),
		35524,
		11,
		1169,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[35524012] = {
		35524012,
		0,
		Lang.get(92290),
		35524,
		12,
		1169,
		{
			RTResTalkAction[14]
		}
	},
	[35524013] = {
		35524013,
		0,
		Lang.get(92291),
		35524,
		13,
		1180,
		{
			RTResTalkAction[118],
			RTResTalkAction[13]
		}
	},
	[35524014] = {
		35524014,
		0,
		Lang.get(92292),
		35524,
		14,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[119]
		}
	},
	[35524015] = {
		35524015,
		0,
		Lang.get(92293),
		35524,
		15,
		1180,
		{
			RTResTalkAction[118],
			RTResTalkAction[13]
		}
	},
	[35524016] = {
		35524016,
		0,
		Lang.get(92294),
		35524,
		16,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[119]
		}
	},
	[35524017] = {
		35524017,
		0,
		Lang.get(92295),
		35524,
		17,
		1180,
		{
			RTResTalkAction[118],
			RTResTalkAction[13]
		}
	},
	[35524018] = {
		35524018,
		0,
		Lang.get(92296),
		35524,
		18,
		1169,
		{
			RTResTalkAction[46],
			RTResTalkAction[119]
		}
	},
	[35524019] = {
		35524019,
		0,
		Lang.get(92297),
		35524,
		19,
		1180,
		{
			RTResTalkAction[118],
			RTResTalkAction[13]
		}
	},
	[35524020] = {
		35524020,
		0,
		Lang.get(92298),
		35524,
		20,
		1169,
		{
			RTResTalkAction[120],
			RTResTalkAction[119]
		}
	},
	[35525001] = {
		35525001,
		0,
		Lang.get(92299),
		35525,
		1,
		1193,
		nil,
		1,
		nil,
		-1,
		nil,
		168,
		35573,
		nil,
		1,
		nil,
		1,
		nil,
		35573
	},
	[35525002] = {
		35525002,
		0,
		Lang.get(92300),
		35525,
		2,
		1009,
		nil,
		1,
		3
	},
	[35525003] = {
		35525003,
		0,
		Lang.get(92301),
		35525,
		3,
		1193,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[35525004] = {
		35525004,
		0,
		Lang.get(92302),
		35525,
		4,
		1009,
		{
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[35525005] = {
		35525005,
		0,
		Lang.get(92303),
		35525,
		5,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35526001] = {
		35526001,
		0,
		Lang.get(92304),
		35526,
		1,
		565,
		nil,
		nil,
		nil,
		-1,
		nil,
		20,
		35574,
		nil,
		1,
		nil,
		nil,
		nil,
		35574
	},
	[35526002] = {
		35526002,
		0,
		Lang.get(92305),
		35526,
		2,
		1174,
		nil,
		1
	},
	[35526003] = {
		35526003,
		0,
		Lang.get(92306),
		35526,
		3,
		1186,
		{
			RTResTalkAction[124]
		},
		nil,
		nil,
		3
	},
	[35526004] = {
		35526004,
		0,
		Lang.get(92307),
		35526,
		4,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[35526005] = {
		35526005,
		0,
		Lang.get(92308),
		35526,
		5,
		1175,
		{
			RTResTalkAction[125]
		}
	},
	[35526006] = {
		35526006,
		0,
		Lang.get(92309),
		35526,
		6,
		1186,
		{
			RTResTalkAction[124],
			RTResTalkAction[127]
		}
	},
	[35526007] = {
		35526007,
		0,
		Lang.get(92310),
		35526,
		7,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[35526008] = {
		35526008,
		0,
		Lang.get(92311),
		35526,
		8,
		1186,
		{
			RTResTalkAction[124],
			RTResTalkAction[127]
		}
	},
	[35526009] = {
		35526009,
		0,
		Lang.get(92312),
		35526,
		9,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[35526010] = {
		35526010,
		0,
		Lang.get(92313),
		35526,
		10,
		1175,
		{
			RTResTalkAction[125]
		}
	},
	[35526011] = {
		35526011,
		0,
		Lang.get(92314),
		35526,
		11,
		1185,
		{
			RTResTalkAction[127]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		35575,
		nil,
		1,
		nil,
		nil,
		nil,
		35575
	},
	[35526012] = {
		35526012,
		0,
		Lang.get(92315),
		35526,
		12,
		1185,
		nil,
		1
	},
	[35526013] = {
		35526013,
		0,
		Lang.get(92316),
		35526,
		13,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526014] = {
		35526014,
		0,
		Lang.get(92317),
		35526,
		14,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526015] = {
		35526015,
		0,
		Lang.get(92318),
		35526,
		15,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526016] = {
		35526016,
		3,
		Lang.get(92319),
		35526,
		16,
		605,
		{
			RTResTalkAction[128]
		},
		[22] = 1
	},
	[35526017] = {
		35526017,
		5,
		Lang.get(92320),
		35526,
		17,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526018] = {
		35526018,
		5,
		Lang.get(67486),
		35526,
		18,
		605,
		{
			RTResTalkAction[129]
		}
	},
	[35526019] = {
		35526019,
		0,
		Lang.get(92321),
		35526,
		19,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526020] = {
		35526020,
		0,
		Lang.get(92322),
		35526,
		20,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35526021] = {
		35526021,
		0,
		Lang.get(92323),
		35526,
		21,
		1185,
		{
			RTResTalkAction[128]
		}
	},
	[35527001] = {
		35527001,
		0,
		Lang.get(92324),
		35527,
		1,
		1187,
		nil,
		1,
		nil,
		nil,
		nil,
		71,
		35576,
		nil,
		1,
		nil,
		nil,
		nil,
		35576
	},
	[35527002] = {
		35527002,
		0,
		Lang.get(92325),
		35527,
		2,
		1188,
		nil,
		1
	},
	[35527003] = {
		35527003,
		0,
		Lang.get(92326),
		35527,
		3,
		1187,
		{
			RTResTalkAction[130]
		},
		nil,
		nil,
		3
	},
	[35527004] = {
		35527004,
		0,
		Lang.get(92327),
		35527,
		4,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[131]
		}
	},
	[35527005] = {
		35527005,
		0,
		Lang.get(92328),
		35527,
		5,
		1187,
		{
			RTResTalkAction[130],
			RTResTalkAction[127]
		}
	},
	[35527006] = {
		35527006,
		0,
		Lang.get(92329),
		35527,
		6,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[131]
		}
	},
	[35527007] = {
		35527007,
		0,
		Lang.get(92330),
		35527,
		7,
		1189,
		{
			RTResTalkAction[132],
			RTResTalkAction[127]
		}
	},
	[35527008] = {
		35527008,
		0,
		Lang.get(92331),
		35527,
		8,
		1187,
		{
			RTResTalkAction[130],
			RTResTalkAction[133]
		}
	},
	[35527009] = {
		35527009,
		0,
		Lang.get(92332),
		35527,
		9,
		1189,
		{
			RTResTalkAction[132],
			RTResTalkAction[131]
		}
	},
	[35527010] = {
		35527010,
		0,
		Lang.get(92333),
		35527,
		10,
		1187,
		{
			RTResTalkAction[130],
			RTResTalkAction[133]
		}
	},
	[35527011] = {
		35527011,
		0,
		Lang.get(92334),
		35527,
		11,
		1188,
		{
			RTResTalkAction[134],
			RTResTalkAction[131]
		}
	},
	[35527012] = {
		35527012,
		0,
		Lang.get(92335),
		35527,
		12,
		1187,
		{
			RTResTalkAction[130],
			RTResTalkAction[135]
		}
	},
	[35527013] = {
		35527013,
		0,
		Lang.get(92336),
		35527,
		13,
		1175,
		{
			RTResTalkAction[125],
			RTResTalkAction[131]
		}
	},
	[35528001] = {
		35528001,
		0,
		Lang.get(92336),
		35528,
		1,
		1169,
		nil,
		nil,
		nil,
		nil,
		nil,
		168,
		35577,
		nil,
		1,
		nil,
		0,
		nil,
		35577
	},
	[35528002] = {
		35528002,
		0,
		Lang.get(92337),
		35528,
		2,
		1009,
		nil,
		1,
		3
	},
	[35528003] = {
		35528003,
		0,
		Lang.get(92338),
		35528,
		3,
		1193,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[35528004] = {
		35528004,
		0,
		Lang.get(92339),
		35528,
		4,
		1009,
		{
			RTResTalkAction[56],
			RTResTalkAction[123]
		}
	},
	[35528005] = {
		35528005,
		0,
		Lang.get(92340),
		35528,
		5,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528006] = {
		35528006,
		0,
		Lang.get(92341),
		35528,
		6,
		1009,
		{
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[35528007] = {
		35528007,
		0,
		Lang.get(92342),
		35528,
		7,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528008] = {
		35528008,
		0,
		Lang.get(92343),
		35528,
		8,
		1009,
		{
			RTResTalkAction[136],
			RTResTalkAction[123]
		}
	},
	[35528009] = {
		35528009,
		0,
		Lang.get(92344),
		35528,
		9,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528010] = {
		35528010,
		0,
		Lang.get(92345),
		35528,
		10,
		1009,
		{
			RTResTalkAction[75],
			RTResTalkAction[123]
		}
	},
	[35528011] = {
		35528011,
		0,
		Lang.get(92346),
		35528,
		11,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528012] = {
		35528012,
		0,
		Lang.get(92347),
		35528,
		12,
		1009,
		{
			RTResTalkAction[137],
			RTResTalkAction[123]
		},
		nil,
		nil,
		nil,
		nil,
		177
	},
	[35528013] = {
		35528013,
		0,
		Lang.get(92348),
		35528,
		13,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528014] = {
		35528014,
		0,
		Lang.get(92349),
		35528,
		14,
		1009,
		{
			RTResTalkAction[75],
			RTResTalkAction[123]
		}
	},
	[35528015] = {
		35528015,
		0,
		Lang.get(92350),
		35528,
		15,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528016] = {
		35528016,
		0,
		Lang.get(92351),
		35528,
		16,
		1009,
		{
			RTResTalkAction[75],
			RTResTalkAction[123]
		}
	},
	[35528017] = {
		35528017,
		0,
		Lang.get(92352),
		35528,
		17,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528018] = {
		35528018,
		0,
		Lang.get(92353),
		35528,
		18,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[123]
		}
	},
	[35528019] = {
		35528019,
		0,
		Lang.get(92354),
		35528,
		19,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[34]
		}
	},
	[35528020] = {
		35528020,
		3,
		Lang.get(77829),
		35528,
		20,
		605,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		nil,
		1068,
		45,
		35578,
		nil,
		1,
		nil,
		1,
		nil,
		35578,
		nil,
		nil,
		1
	},
	[35528021] = {
		35528021,
		0,
		Lang.get(92355),
		35528,
		21,
		1056,
		nil,
		1
	},
	[35528022] = {
		35528022,
		0,
		Lang.get(92356),
		35528,
		22,
		1057,
		nil,
		1
	},
	[35528023] = {
		35528023,
		0,
		Lang.get(92357),
		35528,
		23,
		1173,
		{
			RTResTalkAction[115]
		},
		nil,
		nil,
		3
	},
	[35528024] = {
		35528024,
		3,
		Lang.get(92358),
		35528,
		24,
		605,
		{
			RTResTalkAction[115]
		},
		[22] = 1
	},
	[35528025] = {
		35528025,
		0,
		Lang.get(92359),
		35528,
		25,
		1193,
		{
			RTResTalkAction[121],
			RTResTalkAction[117]
		}
	},
	[35529001] = {
		35529001,
		0,
		Lang.get(92360),
		35529,
		1,
		1173,
		nil,
		1,
		nil,
		-1,
		nil,
		63,
		35579,
		nil,
		1,
		nil,
		nil,
		nil,
		35579
	},
	[35529002] = {
		35529002,
		0,
		Lang.get(92361),
		35529,
		2,
		1193,
		nil,
		1
	},
	[35529003] = {
		35529003,
		0,
		Lang.get(92362),
		35529,
		3,
		1173,
		nil,
		1
	},
	[35529004] = {
		35529004,
		0,
		Lang.get(92363),
		35529,
		4,
		1058,
		nil,
		1
	},
	[35529005] = {
		35529005,
		3,
		Lang.get(92364),
		35529,
		5,
		605,
		nil,
		nil,
		nil,
		-1,
		1070,
		60,
		35580,
		nil,
		1,
		nil,
		nil,
		nil,
		35580,
		nil,
		nil,
		1
	},
	[35529006] = {
		35529006,
		0,
		Lang.get(92365),
		35529,
		6,
		1056,
		nil,
		1
	},
	[35529007] = {
		35529007,
		0,
		Lang.get(92366),
		35529,
		7,
		1193,
		nil,
		1,
		nil,
		-1,
		nil,
		nil,
		35581,
		nil,
		1,
		nil,
		nil,
		nil,
		35581
	},
	[35530001] = {
		35530001,
		3,
		Lang.get(92367),
		35530,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		54,
		35582,
		nil,
		1,
		nil,
		1,
		nil,
		35582,
		255,
		nil,
		1
	},
	[35530002] = {
		35530002,
		0,
		Lang.get(92368),
		35530,
		2,
		1009,
		nil,
		1,
		2,
		[20] = -1
	},
	[35530003] = {
		35530003,
		2,
		Lang.get(92369),
		35530,
		3,
		1169
	},
	[35530004] = {
		35530004,
		0,
		Lang.get(92370),
		35530,
		4,
		1009,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[35530005] = {
		35530005,
		2,
		Lang.get(92371),
		35530,
		5,
		1169,
		{
			RTResTalkAction[34]
		}
	},
	[35530006] = {
		35530006,
		0,
		Lang.get(92372),
		35530,
		6,
		1009,
		{
			RTResTalkAction[56]
		}
	},
	[35530007] = {
		35530007,
		3,
		Lang.get(92367),
		35530,
		7,
		605,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		-1,
		nil,
		60,
		35583,
		nil,
		1,
		nil,
		2,
		nil,
		35583,
		nil,
		nil,
		1
	},
	[35530008] = {
		35530008,
		0,
		Lang.get(92373),
		35530,
		8,
		1009,
		nil,
		1,
		3
	},
	[35530009] = {
		35530009,
		0,
		Lang.get(22255),
		35530,
		9,
		1169,
		nil,
		1,
		1,
		nil,
		1231
	},
	[35531001] = {
		35531001,
		3,
		Lang.get(92374),
		35531,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		1230,
		44,
		35584,
		nil,
		1,
		nil,
		nil,
		nil,
		35584,
		nil,
		nil,
		1
	},
	[35531002] = {
		35531002,
		0,
		Lang.get(92375),
		35531,
		2,
		177,
		nil,
		1
	},
	[35531003] = {
		35531003,
		0,
		Lang.get(92376),
		35531,
		3,
		200,
		nil,
		1,
		nil,
		3
	},
	[35531004] = {
		35531004,
		0,
		Lang.get(92377),
		35531,
		4,
		177,
		{
			RTResTalkAction[29]
		}
	},
	[35531005] = {
		35531005,
		0,
		Lang.get(92378),
		35531,
		5,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[33]
		}
	},
	[35531006] = {
		35531006,
		0,
		Lang.get(92379),
		35531,
		6,
		143,
		{
			RTResTalkAction[138],
			RTResTalkAction[61]
		}
	},
	[35531007] = {
		35531007,
		0,
		Lang.get(92380),
		35531,
		7,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[36]
		}
	},
	[35531008] = {
		35531008,
		0,
		Lang.get(92381),
		35531,
		8,
		1009,
		{
			RTResTalkAction[53]
		},
		1,
		3,
		-1,
		nil,
		177,
		35585,
		nil,
		1,
		nil,
		nil,
		nil,
		35585
	},
	[35531009] = {
		35531009,
		0,
		Lang.get(92382),
		35531,
		9,
		273,
		nil,
		1
	},
	[35531010] = {
		35531010,
		0,
		Lang.get(92383),
		35531,
		10,
		177,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[35531011] = {
		35531011,
		0,
		Lang.get(92384),
		35531,
		11,
		1009,
		{
			RTResTalkAction[56],
			RTResTalkAction[33]
		}
	},
	[35531012] = {
		35531012,
		0,
		Lang.get(92385),
		35531,
		12,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[34]
		}
	},
	[35531013] = {
		35531013,
		0,
		Lang.get(92386),
		35531,
		13,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[61]
		}
	},
	[35531014] = {
		35531014,
		0,
		Lang.get(92387),
		35531,
		14,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[53]
		}
	},
	[35531015] = {
		35531015,
		0,
		Lang.get(92388),
		35531,
		15,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[33]
		}
	},
	[35531016] = {
		35531016,
		0,
		Lang.get(92389),
		35531,
		16,
		1009,
		{
			RTResTalkAction[56],
			RTResTalkAction[61]
		}
	},
	[35531017] = {
		35531017,
		3,
		Lang.get(92390),
		35531,
		17,
		605,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		-1,
		nil,
		49,
		35586,
		nil,
		1,
		nil,
		1,
		nil,
		35586,
		nil,
		nil,
		1
	},
	[35531018] = {
		35531018,
		0,
		Lang.get(92391),
		35531,
		18,
		177,
		nil,
		1
	},
	[35531019] = {
		35531019,
		0,
		Lang.get(92392),
		35531,
		19,
		1009,
		nil,
		1,
		3
	},
	[35531020] = {
		35531020,
		0,
		Lang.get(92393),
		35531,
		20,
		273,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[35531021] = {
		35531021,
		0,
		Lang.get(92394),
		35531,
		21,
		143,
		{
			RTResTalkAction[139],
			RTResTalkAction[61]
		}
	},
	[35531022] = {
		35531022,
		0,
		Lang.get(92395),
		35531,
		22,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[36]
		}
	},
	[35531023] = {
		35531023,
		0,
		Lang.get(92396),
		35531,
		23,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[33]
		}
	},
	[35531024] = {
		35531024,
		0,
		Lang.get(92397),
		35531,
		24,
		273,
		{
			RTResTalkAction[62],
			RTResTalkAction[53]
		}
	},
	[35531025] = {
		35531025,
		0,
		Lang.get(92398),
		35531,
		25,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[61]
		}
	},
	[35531026] = {
		35531026,
		0,
		Lang.get(92399),
		35531,
		26,
		200,
		{
			RTResTalkAction[51],
			RTResTalkAction[34]
		}
	},
	[35531027] = {
		35531027,
		3,
		Lang.get(92400),
		35531,
		27,
		605,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		35587,
		nil,
		1,
		nil,
		nil,
		nil,
		35587,
		nil,
		nil,
		1
	},
	[35531028] = {
		35531028,
		0,
		Lang.get(92401),
		35531,
		28,
		177,
		nil,
		1
	},
	[35532001] = {
		35532001,
		3,
		Lang.get(92402),
		35532,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		1232,
		198,
		35591,
		nil,
		1,
		nil,
		nil,
		nil,
		35591,
		nil,
		nil,
		1
	},
	[35532002] = {
		35532002,
		0,
		Lang.get(92403),
		35532,
		2,
		143,
		nil,
		1,
		5
	},
	[35532003] = {
		35532003,
		0,
		Lang.get(92404),
		35532,
		3,
		177,
		nil,
		1
	},
	[35532004] = {
		35532004,
		0,
		Lang.get(92405),
		35532,
		4,
		1169,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[35532005] = {
		35532005,
		0,
		Lang.get(92406),
		35532,
		5,
		134,
		{
			RTResTalkAction[55],
			RTResTalkAction[13]
		}
	},
	[35532006] = {
		35532006,
		0,
		Lang.get(92407),
		35532,
		6,
		177,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[35532007] = {
		35532007,
		0,
		Lang.get(92408),
		35532,
		7,
		1169,
		{
			RTResTalkAction[14],
			RTResTalkAction[33]
		}
	},
	[35532008] = {
		35532008,
		0,
		Lang.get(92409),
		35532,
		8,
		1169,
		{
			RTResTalkAction[10]
		}
	},
	[35532009] = {
		35532009,
		0,
		Lang.get(92410),
		35532,
		9,
		1009,
		{
			RTResTalkAction[35],
			RTResTalkAction[13]
		}
	},
	[35532010] = {
		35532010,
		0,
		Lang.get(92411),
		35532,
		10,
		200,
		{
			RTResTalkAction[34]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		35525,
		nil,
		1,
		nil,
		nil,
		nil,
		35525
	},
	[35532011] = {
		35532011,
		2,
		Lang.get(92412),
		35532,
		11,
		1169,
		nil,
		1,
		1
	},
	[35532012] = {
		35532012,
		2,
		Lang.get(92413),
		35532,
		12,
		1169,
		nil,
		1,
		2
	},
	[35532013] = {
		35532013,
		0,
		Lang.get(92414),
		35532,
		13,
		200,
		nil,
		1
	},
	[35532014] = {
		35532014,
		0,
		Lang.get(92415),
		35532,
		14,
		1169,
		nil,
		1,
		1
	},
	[35533001] = {
		35533001,
		0,
		Lang.get(92416),
		35533,
		1,
		1169,
		nil,
		1,
		2,
		-1,
		nil,
		49,
		35588,
		nil,
		1,
		nil,
		nil,
		nil,
		35588
	},
	[35533002] = {
		35533002,
		0,
		Lang.get(92417),
		35533,
		2,
		1009,
		nil,
		1,
		2
	},
	[35533003] = {
		35533003,
		0,
		Lang.get(92418),
		35533,
		3,
		223,
		nil,
		1,
		1
	},
	[35533004] = {
		35533004,
		0,
		Lang.get(92419),
		35533,
		4,
		1009,
		nil,
		1,
		3
	},
	[35533005] = {
		35533005,
		0,
		Lang.get(92420),
		35533,
		5,
		223,
		nil,
		1,
		1
	},
	[35533006] = {
		35533006,
		0,
		Lang.get(92421),
		35533,
		6,
		1009,
		nil,
		1,
		3
	},
	[35533007] = {
		35533007,
		0,
		Lang.get(92422),
		35533,
		7,
		1009,
		nil,
		1,
		3
	},
	[35533008] = {
		35533008,
		0,
		Lang.get(92423),
		35533,
		8,
		1009,
		nil,
		1,
		2
	},
	[35533009] = {
		35533009,
		0,
		Lang.get(92424),
		35533,
		9,
		1169,
		nil,
		1,
		1,
		-1,
		nil,
		198,
		35589,
		nil,
		1,
		nil,
		nil,
		nil,
		35589
	},
	[35533010] = {
		35533010,
		0,
		Lang.get(92425),
		35533,
		10,
		1009,
		nil,
		1,
		2
	},
	[35533011] = {
		35533011,
		0,
		Lang.get(92426),
		35533,
		11,
		1169,
		{
			RTResTalkAction[14]
		}
	},
	[35533012] = {
		35533012,
		0,
		Lang.get(92427),
		35533,
		12,
		1009,
		{
			RTResTalkAction[42],
			RTResTalkAction[13]
		}
	},
	[35533013] = {
		35533013,
		0,
		Lang.get(92428),
		35533,
		13,
		1169,
		{
			RTResTalkAction[140],
			RTResTalkAction[34]
		}
	},
	[35533014] = {
		35533014,
		0,
		Lang.get(92429),
		35533,
		14,
		300,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		-1,
		nil,
		134,
		35590,
		nil,
		1,
		nil,
		nil,
		nil,
		35590
	},
	[35533015] = {
		35533015,
		0,
		Lang.get(92430),
		35533,
		15,
		200,
		nil,
		1
	},
	[35533016] = {
		35533016,
		0,
		Lang.get(92431),
		35533,
		16,
		300
	},
	[35533017] = {
		35533017,
		0,
		Lang.get(92432),
		35533,
		17,
		200,
		nil,
		1
	},
	[35533018] = {
		35533018,
		0,
		Lang.get(92433),
		35533,
		18,
		300
	},
	[35533019] = {
		35533019,
		0,
		Lang.get(92434),
		35533,
		19,
		200,
		nil,
		1
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
