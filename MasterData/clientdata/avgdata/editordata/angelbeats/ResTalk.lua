-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Angelbeats\\ResTalk.lua

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
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[2] = {
	1,
	1237,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[3] = {
	1,
	1240,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 1240
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 829
}
RTResTalkAction[6] = {
	2,
	1240,
	nil,
	nil,
	1
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 1240,
	[3] = {
		2
	}
}
RTResTalkAction[8] = {
	1,
	1240,
	nil,
	nil,
	2
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 829
}
RTResTalkAction[10] = {
	3,
	1238,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[11] = {
	2,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 1238
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 829
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 1240
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1238
}
RTResTalkAction[16] = {
	2,
	1240,
	nil,
	nil,
	2
}
RTResTalkAction[17] = {
	1,
	1240,
	nil,
	nil,
	0
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1240
}
RTResTalkAction[19] = {
	1,
	1240,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[20] = {
	1,
	1237,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[21] = {
	2,
	1240,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 1237
}
RTResTalkAction[23] = {
	3,
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[24] = {
	2,
	1240,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1237
}
RTResTalkAction[26] = {
	3,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[27] = {
	3,
	1237,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	3,
	1237,
	nil,
	nil,
	3
}
RTResTalkAction[29] = {
	[1] = 3,
	[2] = 1237,
	[3] = {
		1002
	}
}
RTResTalkAction[30] = {
	3,
	1237,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[32] = {
	[1] = 2,
	[2] = 1047
}
RTResTalkAction[33] = {
	[1] = 3,
	[2] = 257
}
RTResTalkAction[34] = {
	[1] = 2,
	[2] = 1047,
	[3] = {
		1
	}
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		2
	}
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 1047
}
RTResTalkAction[37] = {
	1,
	1142,
	nil,
	nil,
	0
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1142
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1142
}
RTResTalkAction[40] = {
	1,
	1240,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[41] = {
	2,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[42] = {
	3,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[43] = {
	1,
	1240,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[44] = {
	2,
	1237,
	nil,
	nil,
	3
}
RTResTalkAction[45] = {
	1,
	1240,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[46] = {
	2,
	1237,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	3,
	1240,
	nil,
	nil,
	1
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 1237
}
RTResTalkAction[49] = {
	3,
	1213,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[50] = {
	[1] = 3,
	[2] = 1213
}
RTResTalkAction[51] = {
	1,
	1213,
	nil,
	nil,
	1
}
RTResTalkAction[52] = {
	1,
	1213,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[53] = {
	1,
	1213,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[54] = {
	1,
	1237,
	{
		1001
	},
	nil,
	2
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 1213
}
RTResTalkAction[56] = {
	1,
	1247,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1247,
	[3] = {
		2
	}
}
RTResTalkAction[58] = {
	[1] = 2,
	[2] = 1247
}
RTResTalkAction[59] = {
	3,
	1252,
	nil,
	nil,
	0
}
RTResTalkAction[60] = {
	[1] = 3,
	[2] = 1245
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 1252
}
RTResTalkAction[62] = {
	2,
	1247,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[63] = {
	[1] = 2,
	[2] = 1247,
	[3] = {
		1002
	}
}
RTResTalkAction[64] = {
	[1] = 2,
	[2] = 1247,
	[3] = {
		1
	}
}
RTResTalkAction[65] = {
	3,
	1245,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 1245
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 1247
}
RTResTalkAction[68] = {
	2,
	1247,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[69] = {
	3,
	1245,
	nil,
	nil,
	2
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 1245
}
RTResTalkAction[71] = {
	1,
	287,
	nil,
	nil,
	0
}
RTResTalkAction[72] = {
	1,
	1237,
	nil,
	nil,
	0
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[74] = {
	1,
	1240,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[75] = {
	3,
	1237,
	{
		1002
	},
	nil,
	0
}
RTResTalkAction[76] = {
	1,
	1093,
	nil,
	nil,
	0
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 1093
}
RTResTalkAction[78] = {
	2,
	1240,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[79] = {
	3,
	1093,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[80] = {
	[1] = 3,
	[2] = 1093
}
RTResTalkAction[81] = {
	1,
	1240,
	nil,
	nil,
	1
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 1093
}
RTResTalkAction[83] = {
	1,
	1093,
	nil,
	nil,
	2
}
RTResTalkAction[84] = {
	2,
	1237,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[85] = {
	1,
	1093,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[86] = {
	2,
	1237,
	nil,
	nil,
	1
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 1205
}
RTResTalkAction[88] = {
	1,
	1240,
	nil,
	nil,
	3
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 1205
}
RTResTalkAction[90] = {
	1,
	1237,
	{
		1005
	},
	nil,
	0
}
RTResTalkAction[91] = {
	3,
	1237,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 426
}
RTResTalkAction[93] = {
	[1] = 0,
	[2] = 426
}
RTResTalkAction[94] = {
	2,
	1205,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[95] = {
	3,
	1093,
	nil,
	nil,
	0
}
RTResTalkAction[96] = {
	[1] = 2,
	[2] = 1205
}
RTResTalkAction[97] = {
	3,
	1093,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 1237
}
RTResTalkAction[99] = {
	1,
	1250,
	nil,
	nil,
	1
}
RTResTalkAction[100] = {
	1,
	1253,
	nil,
	nil,
	0
}
RTResTalkAction[101] = {
	[1] = 2,
	[2] = 1253
}
RTResTalkAction[102] = {
	3,
	1056,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[103] = {
	[1] = 3,
	[2] = 1056
}
RTResTalkAction[104] = {
	[1] = 2,
	[2] = 1056
}
RTResTalkAction[105] = {
	[1] = 3,
	[2] = 1057,
	[3] = {
		1
	}
}
RTResTalkAction[106] = {
	[1] = 0,
	[2] = 1253
}
RTResTalkAction[107] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 1057
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 1253
}
RTResTalkAction[110] = {
	3,
	1245,
	nil,
	nil,
	0
}
RTResTalkAction[111] = {
	[1] = 2,
	[2] = 1247,
	[3] = {
		2
	}
}
RTResTalkAction[112] = {
	1,
	1205,
	nil,
	nil,
	0
}
RTResTalkAction[113] = {
	[1] = 1,
	[2] = 831
}
RTResTalkAction[114] = {
	[1] = 2,
	[2] = 831
}
RTResTalkAction[115] = {
	[1] = 3,
	[2] = 832
}
RTResTalkAction[116] = {
	[1] = 4,
	[2] = 831
}
RTResTalkAction[117] = {
	[1] = 1,
	[2] = 833
}
RTResTalkAction[118] = {
	[1] = 5,
	[2] = 832
}
RTResTalkAction[119] = {
	[1] = 0,
	[2] = 831
}
RTResTalkAction[120] = {
	[1] = 0,
	[2] = 833
}
RTResTalkAction[121] = {
	[1] = 0,
	[2] = 832
}
RTResTalkAction[122] = {
	3,
	1213,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[123] = {
	1,
	1240,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[124] = {
	1,
	1237,
	nil,
	nil,
	2
}
RTResTalkAction[125] = {
	1,
	1237,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[126] = {
	1,
	1240,
	{
		1002
	},
	nil,
	1
}
RTResTalkAction[127] = {
	1,
	1240,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[128] = {
	3,
	1237,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[129] = {
	3,
	1237,
	{
		1005
	},
	nil,
	3
}
RTResTalkAction[130] = {
	3,
	1237,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[131] = {
	1,
	1213,
	nil,
	nil,
	0
}
RTResTalkAction[132] = {
	1,
	1237,
	{
		1005
	},
	nil,
	1
}
RTResTalkAction[133] = {
	1,
	1213,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[134] = {
	1,
	830,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[135] = {
	[1] = 1,
	[2] = 830,
	[3] = {
		1
	}
}
RTResTalkAction[136] = {
	[1] = 0,
	[2] = 830
}
RTResTalkAction[137] = {
	2,
	1240,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[138] = {
	1,
	1213,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[139] = {
	[1] = 1,
	[2] = 1213
}
RTResTalkAction[140] = {
	3,
	1213,
	nil,
	nil,
	0
}
RTResTalkAction[141] = {
	1,
	239,
	nil,
	nil,
	0
}
RTResTalkAction[142] = {
	[1] = 1,
	[2] = 239
}
RTResTalkAction[143] = {
	[1] = 2,
	[2] = 239
}
RTResTalkAction[144] = {
	3,
	1250,
	nil,
	nil,
	1
}
RTResTalkAction[145] = {
	2,
	239,
	nil,
	nil,
	1
}
RTResTalkAction[146] = {
	2,
	239,
	nil,
	nil,
	0
}
RTResTalkAction[147] = {
	[1] = 2,
	[2] = 239,
	[3] = {
		2
	}
}
RTResTalkAction[148] = {
	[1] = 0,
	[2] = 239
}
RTResTalkAction[149] = {
	1,
	1250,
	nil,
	nil,
	2
}
RTResTalkAction[150] = {
	[1] = 0,
	[2] = 1250
}
RTResTalkAction[151] = {
	2,
	1247,
	nil,
	nil,
	0
}
RTResTalkAction[152] = {
	[1] = 2,
	[2] = 1247,
	[3] = {
		3
	}
}
RTResTalkAction[153] = {
	[1] = 3,
	[2] = 1245,
	[3] = {
		2
	}
}
RTResTalkAction[154] = {
	[1] = 1,
	[2] = 1245,
	[3] = {
		2
	}
}
RTResTalkAction[155] = {
	[1] = 1,
	[2] = 1247,
	[3] = {
		3
	}
}
RTResTalkAction[156] = {
	1,
	749,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[157] = {
	[1] = 0,
	[2] = 749
}
RTResTalkAction[158] = {
	3,
	1213,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[159] = {
	1,
	1213,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[160] = {
	3,
	1237,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[161] = {
	2,
	1213,
	nil,
	nil,
	1
}
RTResTalkAction[162] = {
	3,
	1253,
	nil,
	nil,
	0
}
RTResTalkAction[163] = {
	2,
	1213,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[164] = {
	[1] = 3,
	[2] = 1253
}
RTResTalkAction[165] = {
	2,
	1213,
	nil,
	nil,
	0
}
RTResTalkAction[166] = {
	[1] = 2,
	[2] = 1213
}
RTResTalkAction[167] = {
	[1] = 2,
	[2] = 1213,
	[3] = {
		1
	}
}
RTResTalkAction[168] = {
	[1] = 1,
	[2] = 1213,
	[3] = {
		3
	}
}
RTResTalkAction[169] = {
	[1] = 3,
	[2] = 1250
}
RTResTalkAction[170] = {
	[1] = 2,
	[2] = 792,
	[3] = {
		1
	}
}
RTResTalkAction[171] = {
	[1] = 3,
	[2] = 32,
	[3] = {
		1
	}
}
RTResTalkAction[172] = {
	[1] = 0,
	[2] = 792
}
RTResTalkAction[173] = {
	[1] = 0,
	[2] = 32
}
RTResTalkAction[174] = {
	[1] = 1,
	[2] = 1253,
	[3] = {
		2
	}
}
RTResTalkAction[175] = {
	1,
	1253,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[176] = {
	1,
	1250,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[177] = {
	1,
	1250,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[178] = {
	1,
	1253,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[179] = {
	1,
	1250,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[180] = {
	[1] = 1,
	[2] = 1240,
	[3] = {
		3
	}
}
RTResTalkAction[181] = {
	2,
	1240,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[182] = {
	[1] = 1,
	[2] = 1247
}
RTResTalkAction[183] = {
	1,
	1247,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[184] = {
	3,
	1245,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[185] = {
	3,
	1245,
	nil,
	nil,
	1
}
RTResTalkAction[186] = {
	[1] = 2,
	[2] = 1240,
	[3] = {
		1
	}
}
RTResTalkAction[187] = {
	[1] = 1,
	[2] = 1240,
	[3] = {
		2
	}
}
RTResTalkAction[188] = {
	1,
	1245,
	nil,
	nil,
	0
}
RTResTalkAction[189] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[190] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[191] = {
	1,
	239,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[192] = {
	2,
	1118,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[193] = {
	[1] = 3,
	[2] = 239
}
RTResTalkAction[194] = {
	2,
	1118,
	nil,
	nil,
	1
}
RTResTalkAction[195] = {
	[1] = 2,
	[2] = 1118
}
RTResTalkAction[196] = {
	3,
	239,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[197] = {
	3,
	239,
	nil,
	nil,
	0
}
RTResTalkAction[198] = {
	2,
	1118,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[199] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[200] = {
	[1] = 1,
	[2] = 1207
}
RTResTalkAction[201] = {
	1,
	1118,
	nil,
	nil,
	0
}
RTResTalkAction[202] = {
	[1] = 0,
	[2] = 1207
}
RTResTalkAction[203] = {
	3,
	239,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[204] = {
	2,
	1118,
	nil,
	nil,
	3
}
RTResTalkAction[205] = {
	1,
	239,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[206] = {
	3,
	239,
	nil,
	nil,
	1
}
RTResTalkAction[207] = {
	3,
	239,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[208] = {
	2,
	1118,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[209] = {
	1,
	239,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[210] = {
	2,
	1118,
	nil,
	nil,
	2
}
RTResTalkAction[211] = {
	1,
	1247,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[212] = {
	1,
	1245,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[213] = {
	[1] = 2,
	[2] = 1245
}
RTResTalkAction[214] = {
	3,
	1250,
	nil,
	nil,
	2
}
RTResTalkAction[215] = {
	2,
	1245,
	nil,
	nil,
	2
}
RTResTalkAction[216] = {
	2,
	1245,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[217] = {
	2,
	1245,
	nil,
	nil,
	1
}
RTResTalkAction[218] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[219] = {
	1,
	1118,
	nil,
	nil,
	2
}
RTResTalkAction[220] = {
	3,
	1240,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[221] = {
	1,
	1245,
	nil,
	nil,
	2
}
RTResTalkAction[222] = {
	3,
	1240,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[223] = {
	3,
	1240,
	nil,
	nil,
	2
}
RTResTalkAction[224] = {
	1,
	1245,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[225] = {
	1,
	1245,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[226] = {
	2,
	1245,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[227] = {
	3,
	1250,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[228] = {
	2,
	1250,
	nil,
	nil,
	1
}
RTResTalkAction[229] = {
	1,
	239,
	nil,
	nil,
	1
}
RTResTalkAction[230] = {
	1,
	1245,
	nil,
	nil,
	1
}
RTResTalkAction[231] = {
	[1] = 2,
	[2] = 1250
}
RTResTalkAction[232] = {
	3,
	239,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[233] = {
	[1] = 1,
	[2] = 239,
	[3] = {
		1
	}
}
RTResTalkAction[234] = {
	1,
	1245,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[235] = {
	1,
	1245,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[236] = {
	[1] = 1,
	[2] = 1207,
	[3] = {
		3
	}
}
RTResTalkAction[237] = {
	1,
	1118,
	nil,
	nil,
	3
}
RTResTalkAction[238] = {
	1,
	1118,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[239] = {
	1,
	1207,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[240] = {
	1,
	1118,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[241] = {
	3,
	1247,
	nil,
	nil,
	0
}
RTResTalkAction[242] = {
	1,
	1245,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[243] = {
	[1] = 1,
	[2] = 1247,
	[3] = {
		1
	}
}
RTResTalkAction[244] = {
	3,
	1245,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[245] = {
	2,
	1240,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[246] = {
	3,
	1245,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[247] = {
	2,
	1240,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[248] = {
	1,
	1047,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[249] = {
	3,
	1238,
	{
		2
	},
	nil,
	3
}

local Data = {
	[37501001] = {
		37501001,
		3,
		Lang.get(87559),
		37501,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		37501,
		[19] = 37501,
		[22] = 1
	},
	[37501002] = {
		37501002,
		0,
		Lang.get(100758),
		37501,
		2,
		1237,
		nil,
		1,
		0,
		nil,
		nil,
		122,
		37502,
		1,
		nil,
		nil,
		nil,
		nil,
		37502
	},
	[37501003] = {
		37501003,
		0,
		Lang.get(100759),
		37501,
		3,
		1118,
		nil,
		1,
		2
	},
	[37501004] = {
		37501004,
		0,
		Lang.get(100760),
		37501,
		4,
		1118,
		nil,
		1,
		0
	},
	[37501005] = {
		37501005,
		0,
		Lang.get(100761),
		37501,
		5,
		1237,
		nil,
		1,
		0
	},
	[37501006] = {
		37501006,
		0,
		Lang.get(100762),
		37501,
		6,
		1118,
		nil,
		1,
		0
	},
	[37501007] = {
		37501007,
		0,
		"……",
		37501,
		7,
		1239,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		37503,
		1,
		nil,
		nil,
		1,
		nil,
		37503
	},
	[37501008] = {
		37501008,
		0,
		Lang.get(68038),
		37501,
		8,
		1118,
		nil,
		1,
		5
	},
	[37501009] = {
		37501009,
		0,
		Lang.get(100763),
		37501,
		9,
		1237,
		nil,
		1,
		2
	},
	[37501010] = {
		37501010,
		0,
		Lang.get(100764),
		37501,
		10,
		1118,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		37504,
		1,
		nil,
		nil,
		1,
		nil,
		37504
	},
	[37501011] = {
		37501011,
		0,
		Lang.get(100765),
		37501,
		11,
		1237,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[37501012] = {
		37501012,
		0,
		Lang.get(100766),
		37501,
		12,
		1237,
		{
			RTResTalkAction[2]
		}
	},
	[37531001] = {
		37531001,
		3,
		Lang.get(100767),
		37531,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		62,
		37505,
		nil,
		nil,
		nil,
		nil,
		nil,
		37505,
		nil,
		nil,
		1
	},
	[37531002] = {
		37531002,
		0,
		Lang.get(100768),
		37531,
		2,
		1240,
		nil,
		1,
		0
	},
	[37531003] = {
		37531003,
		7,
		"114",
		37531,
		3,
		1240
	},
	[37531004] = {
		37531004,
		0,
		Lang.get(100769),
		37531,
		4,
		1238,
		nil,
		1,
		3
	},
	[37531005] = {
		37531005,
		7,
		"113",
		37531,
		5,
		1238
	},
	[37531006] = {
		37531006,
		0,
		Lang.get(101552),
		37531,
		6,
		1240,
		nil,
		1,
		0
	},
	[37531007] = {
		37531007,
		0,
		Lang.get(100771),
		37531,
		7,
		1240,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		37506,
		nil,
		nil,
		nil,
		nil,
		nil,
		37506
	},
	[37531008] = {
		37531008,
		0,
		Lang.get(100772),
		37531,
		8,
		1240,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37531009] = {
		37531009,
		0,
		Lang.get(100773),
		37531,
		9,
		829,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37507,
		1,
		nil,
		nil,
		1,
		nil,
		37507
	},
	[37531010] = {
		37531010,
		0,
		Lang.get(100774),
		37531,
		10,
		1238,
		nil,
		1,
		0
	},
	[37531011] = {
		37531011,
		0,
		Lang.get(100775),
		37531,
		11,
		829,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		37508
	},
	[37531012] = {
		37531012,
		0,
		Lang.get(100776),
		37531,
		12,
		1240,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[37531013] = {
		37531013,
		0,
		Lang.get(100777),
		37531,
		13,
		829,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37531014] = {
		37531014,
		0,
		Lang.get(100778),
		37531,
		14,
		829,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37531015] = {
		37531015,
		0,
		Lang.get(100779),
		37531,
		15,
		1240,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[37531016] = {
		37531016,
		0,
		Lang.get(100780),
		37531,
		16,
		829,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37531017] = {
		37531017,
		0,
		Lang.get(32365),
		37531,
		17,
		1240,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[37531018] = {
		37531018,
		0,
		Lang.get(100781),
		37531,
		18,
		829,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[37531019] = {
		37531019,
		0,
		Lang.get(100782),
		37531,
		19,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[37531020] = {
		37531020,
		0,
		Lang.get(100783),
		37531,
		20,
		1238,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[37531021] = {
		37531021,
		0,
		Lang.get(100657),
		37531,
		21,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[37531022] = {
		37531022,
		0,
		Lang.get(100784),
		37531,
		22,
		1238,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[37531023] = {
		37531023,
		0,
		Lang.get(100785),
		37531,
		23,
		1238,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[37531024] = {
		37531024,
		0,
		Lang.get(100786),
		37531,
		24,
		829,
		{
			RTResTalkAction[13],
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[37531025] = {
		37531025,
		0,
		Lang.get(100787),
		37531,
		25,
		1238,
		{
			RTResTalkAction[4],
			RTResTalkAction[12],
			RTResTalkAction[9]
		}
	},
	[37531026] = {
		37531026,
		0,
		"……",
		37531,
		26,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[12]
		}
	},
	[37531027] = {
		37531027,
		0,
		Lang.get(100788),
		37531,
		27,
		829,
		{
			RTResTalkAction[13],
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[37531028] = {
		37531028,
		9,
		"……",
		37531,
		28,
		605,
		{
			RTResTalkAction[9]
		},
		[22] = 1,
		[20] = 255
	},
	[37531029] = {
		37531029,
		2,
		Lang.get(100789),
		37531,
		29,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		122,
		37509,
		nil,
		nil,
		nil,
		nil,
		nil,
		37509,
		0
	},
	[37531030] = {
		37531030,
		2,
		Lang.get(100790),
		37531,
		30,
		1240,
		{
			RTResTalkAction[18]
		}
	},
	[37531031] = {
		37531031,
		2,
		Lang.get(100791),
		37531,
		31,
		1240,
		{
			RTResTalkAction[19]
		}
	},
	[37502001] = {
		37502001,
		2,
		Lang.get(100792),
		37502,
		1,
		1240,
		nil,
		1,
		3,
		nil,
		nil,
		122,
		37510,
		nil,
		nil,
		nil,
		nil,
		nil,
		37510
	},
	[37502002] = {
		37502002,
		2,
		Lang.get(100793),
		37502,
		2,
		1240,
		nil,
		1,
		3
	},
	[37502003] = {
		37502003,
		3,
		Lang.get(100794),
		37502,
		3,
		605,
		[22] = 1
	},
	[37502004] = {
		37502004,
		2,
		Lang.get(100795),
		37502,
		4,
		1240,
		nil,
		1,
		2
	},
	[37502005] = {
		37502005,
		0,
		Lang.get(100796),
		37502,
		5,
		1240,
		nil,
		1,
		2,
		nil,
		1212,
		nil,
		37511,
		nil,
		nil,
		nil,
		1,
		nil,
		37511
	},
	[37502006] = {
		37502006,
		0,
		Lang.get(100797),
		37502,
		6,
		1237,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37512,
		nil,
		nil,
		nil,
		1,
		nil,
		37512
	},
	[37502007] = {
		37502007,
		0,
		Lang.get(100798),
		37502,
		7,
		1240,
		nil,
		1,
		2
	},
	[37502008] = {
		37502008,
		0,
		Lang.get(100799),
		37502,
		8,
		1237,
		{
			RTResTalkAction[20]
		}
	},
	[37502009] = {
		37502009,
		0,
		Lang.get(100800),
		37502,
		9,
		1240,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		},
		nil,
		nil,
		3,
		nil,
		60
	},
	[37502010] = {
		37502010,
		0,
		Lang.get(100801),
		37502,
		10,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[23]
		}
	},
	[37502011] = {
		37502011,
		0,
		Lang.get(100802),
		37502,
		11,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[22]
		}
	},
	[37502012] = {
		37502012,
		0,
		Lang.get(100803),
		37502,
		12,
		1237,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		1,
		0,
		3,
		nil,
		122,
		37513,
		1,
		1,
		nil,
		nil,
		nil,
		37513
	},
	[37502013] = {
		37502013,
		0,
		Lang.get(100804),
		37502,
		13,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[26]
		}
	},
	[37502014] = {
		37502014,
		0,
		Lang.get(100805),
		37502,
		14,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37502015] = {
		37502015,
		0,
		Lang.get(100806),
		37502,
		15,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37514,
		1,
		1,
		nil,
		nil,
		nil,
		37514
	},
	[37502016] = {
		37502016,
		0,
		Lang.get(100807),
		37502,
		16,
		1240,
		{
			RTResTalkAction[6],
			RTResTalkAction[22]
		}
	},
	[37502017] = {
		37502017,
		0,
		Lang.get(100808),
		37502,
		17,
		1240,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[37502018] = {
		37502018,
		0,
		Lang.get(100809),
		37502,
		18,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37502019] = {
		37502019,
		0,
		Lang.get(100810),
		37502,
		19,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		}
	},
	[37502020] = {
		37502020,
		0,
		Lang.get(100811),
		37502,
		20,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[27]
		}
	},
	[37502021] = {
		37502021,
		2,
		Lang.get(100812),
		37502,
		21,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		}
	},
	[37502022] = {
		37502022,
		2,
		Lang.get(100813),
		37502,
		22,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[37502023] = {
		37502023,
		0,
		Lang.get(100814),
		37502,
		23,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[22]
		}
	},
	[37502024] = {
		37502024,
		0,
		Lang.get(100815),
		37502,
		24,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[28]
		}
	},
	[37502025] = {
		37502025,
		0,
		Lang.get(100816),
		37502,
		25,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[22]
		}
	},
	[37502026] = {
		37502026,
		0,
		Lang.get(22381),
		37502,
		26,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[29]
		}
	},
	[37502027] = {
		37502027,
		0,
		Lang.get(100817),
		37502,
		27,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[26]
		}
	},
	[37502028] = {
		37502028,
		0,
		Lang.get(100818),
		37502,
		28,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[37502029] = {
		37502029,
		0,
		Lang.get(100819),
		37502,
		29,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37502030] = {
		37502030,
		5,
		Lang.get(100820),
		37502,
		30,
		1240,
		{
			RTResTalkAction[3],
			RTResTalkAction[25]
		}
	},
	[37502031] = {
		37502031,
		9,
		Lang.get(100821),
		37502,
		31,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		164,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37502032] = {
		37502032,
		0,
		Lang.get(100822),
		37502,
		32,
		257,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37515,
		1,
		nil,
		nil,
		nil,
		nil,
		37515,
		-1
	},
	[37502033] = {
		37502033,
		0,
		Lang.get(100823),
		37502,
		33,
		1047,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[37502034] = {
		37502034,
		0,
		Lang.get(100824),
		37502,
		34,
		257,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[37502035] = {
		37502035,
		0,
		Lang.get(100825),
		37502,
		35,
		1047,
		{
			RTResTalkAction[34],
			RTResTalkAction[33]
		}
	},
	[37502036] = {
		37502036,
		0,
		Lang.get(100826),
		37502,
		36,
		257,
		{
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[37502037] = {
		37502037,
		0,
		Lang.get(100827),
		37502,
		37,
		257,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[37503001] = {
		37503001,
		13,
		Lang.get(100828),
		37503,
		1,
		1142,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3,
		nil,
		122,
		37520,
		nil,
		nil,
		nil,
		nil,
		nil,
		37520,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[37503002] = {
		37503002,
		0,
		Lang.get(100829),
		37503,
		2,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		2,
		[27] = 3
	},
	[37503003] = {
		37503003,
		13,
		"……",
		37503,
		3,
		1142,
		{
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[37503004] = {
		37503004,
		0,
		Lang.get(100830),
		37503,
		4,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		[27] = 3
	},
	[37503005] = {
		37503005,
		0,
		Lang.get(100831),
		37503,
		5,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		[27] = 3
	},
	[37503006] = {
		37503006,
		13,
		Lang.get(100832),
		37503,
		6,
		1142,
		{
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[37503007] = {
		37503007,
		0,
		Lang.get(100833),
		37503,
		7,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		[27] = 3
	},
	[37503008] = {
		37503008,
		13,
		Lang.get(100834),
		37503,
		8,
		1142,
		{
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[37503009] = {
		37503009,
		0,
		Lang.get(100835),
		37503,
		9,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		[27] = 3
	},
	[37503010] = {
		37503010,
		13,
		Lang.get(100836),
		37503,
		10,
		1142,
		{
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[37503011] = {
		37503011,
		0,
		Lang.get(100837),
		37503,
		11,
		1237,
		{
			RTResTalkAction[38]
		},
		1,
		2,
		[27] = 3
	},
	[37503012] = {
		37503012,
		13,
		Lang.get(100838),
		37503,
		12,
		1142,
		{
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[37503013] = {
		37503013,
		0,
		Lang.get(93178),
		37503,
		13,
		1237,
		{
			RTResTalkAction[39]
		},
		1,
		1
	},
	[37503014] = {
		37503014,
		9,
		Lang.get(100839),
		37503,
		14,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37503015] = {
		37503015,
		0,
		Lang.get(100840),
		37503,
		15,
		1240,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37521,
		1,
		nil,
		nil,
		nil,
		nil,
		37521,
		-1
	},
	[37503016] = {
		37503016,
		0,
		Lang.get(100841),
		37503,
		16,
		1237,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		37522,
		1,
		nil,
		nil,
		nil,
		nil,
		37522
	},
	[37503017] = {
		37503017,
		0,
		Lang.get(100842),
		37503,
		17,
		1240,
		nil,
		1,
		0
	},
	[37503018] = {
		37503018,
		9,
		Lang.get(100843),
		37503,
		18,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37503019] = {
		37503019,
		0,
		Lang.get(100844),
		37503,
		19,
		1240,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3,
		[20] = -1
	},
	[37503020] = {
		37503020,
		0,
		Lang.get(100845),
		37503,
		20,
		1237,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[37503021] = {
		37503021,
		9,
		Lang.get(26415),
		37503,
		21,
		605,
		{
			RTResTalkAction[25],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37503022] = {
		37503022,
		0,
		Lang.get(100846),
		37503,
		22,
		1240,
		{
			RTResTalkAction[43]
		},
		[20] = -1
	},
	[37503023] = {
		37503023,
		0,
		Lang.get(100847),
		37503,
		23,
		1237,
		{
			RTResTalkAction[44],
			RTResTalkAction[42]
		}
	},
	[37503024] = {
		37503024,
		9,
		Lang.get(26562),
		37503,
		24,
		605,
		{
			RTResTalkAction[25],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37503025] = {
		37503025,
		0,
		Lang.get(100848),
		37503,
		25,
		1240,
		{
			RTResTalkAction[45]
		},
		[20] = -1
	},
	[37503026] = {
		37503026,
		0,
		Lang.get(100849),
		37503,
		26,
		1237,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[37503027] = {
		37503027,
		3,
		Lang.get(91958),
		37503,
		27,
		605,
		{
			RTResTalkAction[25],
			RTResTalkAction[14]
		},
		[22] = 1
	},
	[37503028] = {
		37503028,
		0,
		Lang.get(100850),
		37503,
		28,
		1213,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37523,
		nil,
		nil,
		nil,
		1,
		nil,
		37523
	},
	[37503029] = {
		37503029,
		0,
		Lang.get(100851),
		37503,
		29,
		1213,
		nil,
		1,
		1
	},
	[37503030] = {
		37503030,
		0,
		Lang.get(100852),
		37503,
		30,
		1240,
		nil,
		1,
		0
	},
	[37503031] = {
		37503031,
		0,
		Lang.get(100853),
		37503,
		31,
		1240,
		nil,
		1,
		0
	},
	[37503032] = {
		37503032,
		0,
		Lang.get(100854),
		37503,
		32,
		1237,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		37524,
		1,
		1,
		nil,
		1,
		nil,
		37524
	},
	[37503033] = {
		37503033,
		0,
		Lang.get(100855),
		37503,
		33,
		1213,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[37503034] = {
		37503034,
		2,
		Lang.get(100856),
		37503,
		34,
		1237,
		{
			RTResTalkAction[41],
			RTResTalkAction[50]
		}
	},
	[37503035] = {
		37503035,
		0,
		Lang.get(100857),
		37503,
		35,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[37503036] = {
		37503036,
		0,
		Lang.get(100858),
		37503,
		36,
		1213,
		{
			RTResTalkAction[51],
			RTResTalkAction[14]
		}
	},
	[37503037] = {
		37503037,
		2,
		Lang.get(100859),
		37503,
		37,
		1237,
		{
			RTResTalkAction[46],
			RTResTalkAction[50]
		}
	},
	[37503038] = {
		37503038,
		0,
		Lang.get(100860),
		37503,
		38,
		1237,
		{
			RTResTalkAction[44],
			RTResTalkAction[50]
		}
	},
	[37503039] = {
		37503039,
		0,
		Lang.get(100861),
		37503,
		39,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[37503040] = {
		37503040,
		0,
		Lang.get(100862),
		37503,
		40,
		1213,
		{
			RTResTalkAction[52],
			RTResTalkAction[14]
		}
	},
	[37503041] = {
		37503041,
		0,
		Lang.get(100863),
		37503,
		41,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37503042] = {
		37503042,
		5,
		Lang.get(35133),
		37503,
		42,
		1213,
		{
			RTResTalkAction[53],
			RTResTalkAction[14]
		}
	},
	[37503043] = {
		37503043,
		0,
		"……？",
		37503,
		43,
		1237,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[37504001] = {
		37504001,
		0,
		Lang.get(99296),
		37504,
		1,
		1247,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3,
		nil,
		8,
		37525,
		nil,
		nil,
		nil,
		nil,
		nil,
		37525
	},
	[37504002] = {
		37504002,
		0,
		Lang.get(99297),
		37504,
		2,
		1247,
		{
			RTResTalkAction[57]
		}
	},
	[37504003] = {
		37504003,
		0,
		Lang.get(100043),
		37504,
		3,
		1252,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[37504004] = {
		37504004,
		0,
		Lang.get(100864),
		37504,
		4,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[37504005] = {
		37504005,
		0,
		Lang.get(100865),
		37504,
		5,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[37504006] = {
		37504006,
		0,
		Lang.get(100866),
		37504,
		6,
		1247,
		{
			RTResTalkAction[62],
			RTResTalkAction[60]
		}
	},
	[37504007] = {
		37504007,
		0,
		Lang.get(100867),
		37504,
		7,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504008] = {
		37504008,
		0,
		Lang.get(100868),
		37504,
		8,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504009] = {
		37504009,
		0,
		Lang.get(100869),
		37504,
		9,
		1247,
		{
			RTResTalkAction[63],
			RTResTalkAction[60]
		}
	},
	[37504010] = {
		37504010,
		0,
		Lang.get(100870),
		37504,
		10,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504011] = {
		37504011,
		0,
		Lang.get(100871),
		37504,
		11,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504012] = {
		37504012,
		0,
		Lang.get(100872),
		37504,
		12,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504013] = {
		37504013,
		0,
		Lang.get(100873),
		37504,
		13,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504014] = {
		37504014,
		0,
		Lang.get(100874),
		37504,
		14,
		1247,
		{
			RTResTalkAction[64],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37504015] = {
		37504015,
		0,
		Lang.get(100875),
		37504,
		15,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37504016] = {
		37504016,
		0,
		Lang.get(100876),
		37504,
		16,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[65]
		}
	},
	[37504017] = {
		37504017,
		0,
		Lang.get(100877),
		37504,
		17,
		1245,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[37504018] = {
		37504018,
		0,
		Lang.get(100878),
		37504,
		18,
		1247,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		}
	},
	[37504019] = {
		37504019,
		9,
		Lang.get(100879),
		37504,
		19,
		605,
		{
			RTResTalkAction[67],
			RTResTalkAction[70]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37504020] = {
		37504020,
		0,
		Lang.get(100880),
		37504,
		20,
		287,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37526,
		1,
		1,
		nil,
		nil,
		nil,
		37526,
		-1
	},
	[37504021] = {
		37504021,
		0,
		Lang.get(100881),
		37504,
		21,
		287,
		{
			RTResTalkAction[71]
		}
	},
	[37504022] = {
		37504022,
		2,
		Lang.get(100882),
		37504,
		22,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[73]
		}
	},
	[37504023] = {
		37504023,
		0,
		Lang.get(100883),
		37504,
		23,
		1240,
		{
			RTResTalkAction[74],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37504024] = {
		37504024,
		0,
		Lang.get(100884),
		37504,
		24,
		1237,
		{
			RTResTalkAction[24],
			RTResTalkAction[75]
		}
	},
	[37504025] = {
		37504025,
		0,
		Lang.get(100885),
		37504,
		25,
		1240,
		{
			RTResTalkAction[17],
			RTResTalkAction[25]
		}
	},
	[37504026] = {
		37504026,
		0,
		Lang.get(100886),
		37504,
		26,
		1240,
		{
			RTResTalkAction[17]
		}
	},
	[37504027] = {
		37504027,
		0,
		Lang.get(100887),
		37504,
		27,
		1093,
		{
			RTResTalkAction[76],
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		192,
		37527,
		1,
		1,
		nil,
		1,
		nil,
		37527
	},
	[37504028] = {
		37504028,
		0,
		Lang.get(100888),
		37504,
		28,
		1093,
		{
			RTResTalkAction[77]
		}
	},
	[37504029] = {
		37504029,
		0,
		Lang.get(100889),
		37504,
		29,
		1093,
		{
			RTResTalkAction[77]
		}
	},
	[37504030] = {
		37504030,
		0,
		Lang.get(100890),
		37504,
		30,
		1240,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		}
	},
	[37504031] = {
		37504031,
		0,
		Lang.get(100891),
		37504,
		31,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[80]
		}
	},
	[37504032] = {
		37504032,
		0,
		Lang.get(100892),
		37504,
		32,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[80]
		}
	},
	[37504033] = {
		37504033,
		2,
		Lang.get(100893),
		37504,
		33,
		1240,
		{
			RTResTalkAction[81],
			RTResTalkAction[82]
		}
	},
	[37601001] = {
		37601001,
		0,
		Lang.get(100894),
		37601,
		1,
		1093,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3,
		nil,
		192,
		37528,
		nil,
		nil,
		nil,
		nil,
		nil,
		37528
	},
	[37601002] = {
		37601002,
		0,
		Lang.get(100895),
		37601,
		2,
		1237,
		{
			RTResTalkAction[84],
			RTResTalkAction[80]
		}
	},
	[37601003] = {
		37601003,
		0,
		Lang.get(100896),
		37601,
		3,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[80],
			RTResTalkAction[25]
		}
	},
	[37601004] = {
		37601004,
		0,
		Lang.get(100897),
		37601,
		4,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[80]
		}
	},
	[37601005] = {
		37601005,
		0,
		Lang.get(100898),
		37601,
		5,
		1093,
		{
			RTResTalkAction[85],
			RTResTalkAction[14]
		}
	},
	[37601006] = {
		37601006,
		2,
		Lang.get(100899),
		37601,
		6,
		1237,
		{
			RTResTalkAction[86],
			RTResTalkAction[80]
		}
	},
	[37601007] = {
		37601007,
		0,
		Lang.get(101553),
		37601,
		7,
		1205,
		{
			RTResTalkAction[87],
			RTResTalkAction[25],
			RTResTalkAction[82]
		},
		nil,
		nil,
		3,
		nil,
		150,
		37529,
		1,
		1,
		nil,
		1,
		nil,
		37529
	},
	[37601008] = {
		37601008,
		0,
		Lang.get(101554),
		37601,
		8,
		1205,
		{
			RTResTalkAction[87]
		}
	},
	[37601009] = {
		37601009,
		0,
		Lang.get(100902),
		37601,
		9,
		1240,
		{
			RTResTalkAction[88],
			RTResTalkAction[89]
		}
	},
	[37601010] = {
		37601010,
		0,
		Lang.get(101555),
		37601,
		10,
		1205,
		{
			RTResTalkAction[87],
			RTResTalkAction[14]
		}
	},
	[37601011] = {
		37601011,
		0,
		"……",
		37601,
		11,
		1237,
		{
			RTResTalkAction[90],
			RTResTalkAction[89]
		}
	},
	[37601012] = {
		37601012,
		0,
		Lang.get(100904),
		37601,
		12,
		1240,
		{
			RTResTalkAction[17],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37601013] = {
		37601013,
		0,
		Lang.get(100905),
		37601,
		13,
		1240,
		{
			RTResTalkAction[17]
		}
	},
	[37601014] = {
		37601014,
		0,
		Lang.get(100906),
		37601,
		14,
		1240,
		{
			RTResTalkAction[3]
		}
	},
	[37505001] = {
		37505001,
		9,
		Lang.get(100907),
		37505,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		37530,
		nil,
		1,
		nil,
		nil,
		nil,
		37530,
		255,
		nil,
		1
	},
	[37505002] = {
		37505002,
		0,
		Lang.get(100908),
		37505,
		2,
		1240,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37531,
		nil,
		nil,
		nil,
		nil,
		nil,
		37531,
		-1
	},
	[37505003] = {
		37505003,
		0,
		Lang.get(100909),
		37505,
		3,
		1240,
		nil,
		1,
		2
	},
	[37505004] = {
		37505004,
		0,
		Lang.get(100910),
		37505,
		4,
		1093,
		nil,
		1,
		0
	},
	[37505005] = {
		37505005,
		0,
		Lang.get(100911),
		37505,
		5,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[37505006] = {
		37505006,
		0,
		Lang.get(100912),
		37505,
		6,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[91]
		}
	},
	[37505007] = {
		37505007,
		0,
		Lang.get(100913),
		37505,
		7,
		1240,
		{
			RTResTalkAction[92],
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		1,
		2,
		[21] = 426
	},
	[37505008] = {
		37505008,
		0,
		Lang.get(100914),
		37505,
		8,
		1205,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505009] = {
		37505009,
		0,
		Lang.get(100915),
		37505,
		9,
		1237,
		{
			RTResTalkAction[92]
		},
		1,
		2,
		[21] = 426
	},
	[37505010] = {
		37505010,
		0,
		Lang.get(100916),
		37505,
		10,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		2,
		[21] = 426
	},
	[37505011] = {
		37505011,
		0,
		Lang.get(100917),
		37505,
		11,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505012] = {
		37505012,
		0,
		Lang.get(100918),
		37505,
		12,
		1213,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505013] = {
		37505013,
		0,
		Lang.get(100919),
		37505,
		13,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505014] = {
		37505014,
		0,
		Lang.get(100920),
		37505,
		14,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		2,
		nil,
		nil,
		158,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		426
	},
	[37505015] = {
		37505015,
		0,
		Lang.get(100921),
		37505,
		15,
		1093,
		{
			RTResTalkAction[92]
		},
		1,
		2,
		[21] = 426
	},
	[37505016] = {
		37505016,
		0,
		Lang.get(100922),
		37505,
		16,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505017] = {
		37505017,
		0,
		Lang.get(100923),
		37505,
		17,
		1093,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505018] = {
		37505018,
		0,
		Lang.get(100924),
		37505,
		18,
		1237,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505019] = {
		37505019,
		0,
		Lang.get(100925),
		37505,
		19,
		1240,
		{
			RTResTalkAction[92]
		},
		1,
		0,
		[21] = 426
	},
	[37505020] = {
		37505020,
		0,
		Lang.get(100926),
		37505,
		20,
		1240,
		{
			RTResTalkAction[74],
			RTResTalkAction[93]
		}
	},
	[37505021] = {
		37505021,
		0,
		Lang.get(100927),
		37505,
		21,
		1240,
		{
			RTResTalkAction[18]
		}
	},
	[37505022] = {
		37505022,
		0,
		Lang.get(100928),
		37505,
		22,
		1240,
		{
			RTResTalkAction[18]
		}
	},
	[37505023] = {
		37505023,
		0,
		Lang.get(101556),
		37505,
		23,
		1205,
		{
			RTResTalkAction[94],
			RTResTalkAction[95],
			RTResTalkAction[14]
		}
	},
	[37505024] = {
		37505024,
		0,
		Lang.get(100930),
		37505,
		24,
		1093,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[37505025] = {
		37505025,
		0,
		Lang.get(100931),
		37505,
		25,
		1240,
		{
			RTResTalkAction[17],
			RTResTalkAction[89],
			RTResTalkAction[82]
		}
	},
	[37505026] = {
		37505026,
		0,
		Lang.get(100932),
		37505,
		26,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37505027] = {
		37505027,
		0,
		Lang.get(100933),
		37505,
		27,
		1213,
		{
			RTResTalkAction[51],
			RTResTalkAction[14]
		}
	},
	[37505028] = {
		37505028,
		0,
		Lang.get(100934),
		37505,
		28,
		1237,
		{
			RTResTalkAction[98],
			RTResTalkAction[55]
		}
	},
	[37505029] = {
		37505029,
		9,
		Lang.get(100935),
		37505,
		29,
		605,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		-1,
		2751,
		63,
		37532,
		1,
		1,
		nil,
		nil,
		nil,
		37532,
		255,
		nil,
		1
	},
	[37505030] = {
		37505030,
		0,
		Lang.get(100936),
		37505,
		30,
		239,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[37505031] = {
		37505031,
		0,
		Lang.get(100937),
		37505,
		31,
		1239,
		nil,
		1,
		1
	},
	[37505032] = {
		37505032,
		0,
		Lang.get(100938),
		37505,
		32,
		239,
		nil,
		1,
		0
	},
	[37505033] = {
		37505033,
		0,
		Lang.get(100939),
		37505,
		33,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		37533,
		[19] = 37533
	},
	[37505034] = {
		37505034,
		0,
		Lang.get(100940),
		37505,
		34,
		1250,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[37505035] = {
		37505035,
		0,
		Lang.get(100941),
		37505,
		35,
		1250,
		{
			RTResTalkAction[99]
		}
	},
	[37506001] = {
		37506001,
		9,
		Lang.get(100942),
		37506,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		37535,
		nil,
		nil,
		nil,
		nil,
		nil,
		37535,
		255,
		nil,
		1
	},
	[37506002] = {
		37506002,
		0,
		Lang.get(100943),
		37506,
		2,
		1057,
		nil,
		1,
		0,
		[20] = -1
	},
	[37506003] = {
		37506003,
		0,
		Lang.get(100944),
		37506,
		3,
		1058,
		nil,
		1,
		0
	},
	[37506004] = {
		37506004,
		0,
		Lang.get(100945),
		37506,
		4,
		1056,
		nil,
		1,
		0
	},
	[37506005] = {
		37506005,
		0,
		Lang.get(100946),
		37506,
		5,
		1056,
		nil,
		1,
		0
	},
	[37506006] = {
		37506006,
		0,
		Lang.get(100947),
		37506,
		6,
		1251,
		nil,
		1,
		0
	},
	[37506007] = {
		37506007,
		0,
		Lang.get(100948),
		37506,
		7,
		1056,
		nil,
		1,
		0
	},
	[37506008] = {
		37506008,
		0,
		Lang.get(100949),
		37506,
		8,
		1251,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37536,
		nil,
		nil,
		nil,
		nil,
		nil,
		37536
	},
	[37506009] = {
		37506009,
		0,
		Lang.get(100950),
		37506,
		9,
		1058,
		nil,
		1,
		0,
		nil,
		nil,
		57
	},
	[37506010] = {
		37506010,
		0,
		Lang.get(100951),
		37506,
		10,
		1057,
		nil,
		1,
		0
	},
	[37506011] = {
		37506011,
		0,
		Lang.get(100952),
		37506,
		11,
		1253,
		{
			RTResTalkAction[100]
		},
		nil,
		nil,
		3
	},
	[37506012] = {
		37506012,
		5,
		Lang.get(100953),
		37506,
		12,
		1056,
		{
			RTResTalkAction[101],
			RTResTalkAction[102]
		}
	},
	[37506013] = {
		37506013,
		0,
		Lang.get(100954),
		37506,
		13,
		1253,
		{
			RTResTalkAction[101],
			RTResTalkAction[103]
		}
	},
	[37506014] = {
		37506014,
		0,
		Lang.get(100955),
		37506,
		14,
		1058,
		{
			RTResTalkAction[101],
			RTResTalkAction[103]
		}
	},
	[37506015] = {
		37506015,
		0,
		Lang.get(100956),
		37506,
		15,
		1056,
		{
			RTResTalkAction[101],
			RTResTalkAction[103]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37506016] = {
		37506016,
		0,
		Lang.get(100957),
		37506,
		16,
		1057,
		{
			RTResTalkAction[104],
			RTResTalkAction[105],
			RTResTalkAction[106]
		}
	},
	[37506017] = {
		37506017,
		3,
		Lang.get(100958),
		37506,
		17,
		605,
		{
			RTResTalkAction[107],
			RTResTalkAction[108]
		},
		nil,
		nil,
		nil,
		1225,
		[22] = 1
	},
	[37506018] = {
		37506018,
		0,
		Lang.get(100959),
		37506,
		18,
		1253,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		nil,
		194,
		nil,
		1
	},
	[37506019] = {
		37506019,
		0,
		Lang.get(100960),
		37506,
		19,
		1253,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37506020] = {
		37506020,
		3,
		Lang.get(100961),
		37506,
		20,
		605,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		nil,
		1226,
		[22] = 1
	},
	[37506021] = {
		37506021,
		0,
		Lang.get(100962),
		37506,
		21,
		1253,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		nil,
		8
	},
	[37506022] = {
		37506022,
		0,
		Lang.get(100963),
		37506,
		22,
		1253,
		{
			RTResTalkAction[109]
		}
	},
	[37506023] = {
		37506023,
		9,
		Lang.get(100964),
		37506,
		23,
		605,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37506024] = {
		37506024,
		0,
		Lang.get(100965),
		37506,
		24,
		1247,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37537,
		[19] = 37537,
		[20] = -1
	},
	[37506025] = {
		37506025,
		0,
		Lang.get(100966),
		37506,
		25,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[110]
		}
	},
	[37506026] = {
		37506026,
		0,
		Lang.get(100967),
		37506,
		26,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37506027] = {
		37506027,
		0,
		Lang.get(100968),
		37506,
		27,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37506028] = {
		37506028,
		0,
		Lang.get(100969),
		37506,
		28,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37506029] = {
		37506029,
		0,
		Lang.get(100970),
		37506,
		29,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37506030] = {
		37506030,
		0,
		Lang.get(100971),
		37506,
		30,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[37506031] = {
		37506031,
		0,
		Lang.get(100972),
		37506,
		31,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37506032] = {
		37506032,
		0,
		Lang.get(100973),
		37506,
		32,
		1247,
		{
			RTResTalkAction[111],
			RTResTalkAction[60]
		}
	},
	[37507001] = {
		37507001,
		0,
		Lang.get(100974),
		37507,
		1,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		69,
		37540,
		nil,
		nil,
		nil,
		nil,
		nil,
		37540
	},
	[37507002] = {
		37507002,
		0,
		Lang.get(100975),
		37507,
		2,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37507003] = {
		37507003,
		0,
		Lang.get(100976),
		37507,
		3,
		1237,
		{
			RTResTalkAction[98],
			RTResTalkAction[14]
		}
	},
	[37507004] = {
		37507004,
		0,
		Lang.get(100977),
		37507,
		4,
		1213,
		{
			RTResTalkAction[51],
			RTResTalkAction[25]
		}
	},
	[37507005] = {
		37507005,
		13,
		Lang.get(100978),
		37507,
		5,
		1205,
		{
			RTResTalkAction[112],
			RTResTalkAction[55]
		},
		[27] = 3
	},
	[37507006] = {
		37507006,
		13,
		Lang.get(100979),
		37507,
		6,
		1093,
		{
			RTResTalkAction[76],
			RTResTalkAction[89]
		},
		[27] = 3
	},
	[37507007] = {
		37507007,
		0,
		Lang.get(27728),
		37507,
		7,
		1240,
		{
			RTResTalkAction[17],
			RTResTalkAction[82]
		}
	},
	[37507008] = {
		37507008,
		0,
		Lang.get(100980),
		37507,
		8,
		1240,
		{
			RTResTalkAction[19]
		}
	},
	[37507009] = {
		37507009,
		0,
		Lang.get(100981),
		37507,
		9,
		831,
		{
			RTResTalkAction[113],
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		192,
		37541,
		1,
		1,
		nil,
		1,
		nil,
		37541
	},
	[37507010] = {
		37507010,
		0,
		Lang.get(100982),
		37507,
		10,
		832,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[37507011] = {
		37507011,
		0,
		Lang.get(100983),
		37507,
		11,
		831,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[37507012] = {
		37507012,
		0,
		Lang.get(100984),
		37507,
		12,
		833,
		{
			RTResTalkAction[116],
			RTResTalkAction[117],
			RTResTalkAction[118]
		}
	},
	[37507013] = {
		37507013,
		0,
		Lang.get(101557),
		37507,
		13,
		1205,
		{
			RTResTalkAction[112],
			RTResTalkAction[119],
			RTResTalkAction[120],
			RTResTalkAction[121]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37542,
		1,
		1,
		nil,
		nil,
		nil,
		37542
	},
	[37507014] = {
		37507014,
		0,
		Lang.get(100986),
		37507,
		14,
		1205,
		{
			RTResTalkAction[112]
		}
	},
	[37507015] = {
		37507015,
		0,
		Lang.get(101558),
		37507,
		15,
		1205,
		{
			RTResTalkAction[112]
		}
	},
	[37507016] = {
		37507016,
		0,
		Lang.get(100988),
		37507,
		16,
		1205,
		{
			RTResTalkAction[112]
		}
	},
	[37507017] = {
		37507017,
		2,
		Lang.get(100989),
		37507,
		17,
		1093,
		{
			RTResTalkAction[83],
			RTResTalkAction[89]
		}
	},
	[37507018] = {
		37507018,
		3,
		Lang.get(100990),
		37507,
		18,
		605,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		-1,
		2756,
		161,
		37543,
		1,
		1,
		nil,
		1,
		nil,
		37543,
		nil,
		nil,
		1
	},
	[37507019] = {
		37507019,
		0,
		Lang.get(100991),
		37507,
		19,
		1213,
		nil,
		1,
		1
	},
	[37507020] = {
		37507020,
		0,
		Lang.get(100992),
		37507,
		20,
		1240,
		nil,
		1,
		3
	},
	[37507021] = {
		37507021,
		0,
		Lang.get(100993),
		37507,
		21,
		1237,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37544,
		1,
		1,
		nil,
		nil,
		nil,
		37544
	},
	[37507022] = {
		37507022,
		0,
		Lang.get(100994),
		37507,
		22,
		1237,
		nil,
		1,
		2,
		nil,
		2756
	},
	[37507023] = {
		37507023,
		0,
		Lang.get(100995),
		37507,
		23,
		1240,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[37507024] = {
		37507024,
		0,
		Lang.get(100996),
		37507,
		24,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[91]
		}
	},
	[37507025] = {
		37507025,
		9,
		Lang.get(100997),
		37507,
		25,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37507026] = {
		37507026,
		9,
		Lang.get(21922),
		37507,
		26,
		605,
		nil,
		nil,
		nil,
		nil,
		2765,
		nil,
		nil,
		1,
		[22] = 1
	},
	[37507027] = {
		37507027,
		0,
		Lang.get(100998),
		37507,
		27,
		1240,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37545,
		nil,
		nil,
		nil,
		1,
		nil,
		37545,
		-1
	},
	[37507028] = {
		37507028,
		0,
		Lang.get(100999),
		37507,
		28,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[14]
		}
	},
	[37507029] = {
		37507029,
		0,
		Lang.get(101000),
		37507,
		29,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[25]
		}
	},
	[37507030] = {
		37507030,
		0,
		Lang.get(101001),
		37507,
		30,
		1213,
		{
			RTResTalkAction[16],
			RTResTalkAction[122]
		}
	},
	[37507031] = {
		37507031,
		0,
		"3……2……1！",
		37507,
		31,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[55]
		}
	},
	[37507032] = {
		37507032,
		5,
		Lang.get(101002),
		37507,
		32,
		1240,
		{
			RTResTalkAction[123]
		}
	},
	[37508001] = {
		37508001,
		0,
		Lang.get(101003),
		37508,
		1,
		1240,
		nil,
		1,
		0,
		nil,
		nil,
		122,
		37546,
		nil,
		nil,
		nil,
		nil,
		nil,
		37546
	},
	[37508002] = {
		37508002,
		0,
		Lang.get(101004),
		37508,
		2,
		1213,
		nil,
		1,
		1
	},
	[37508003] = {
		37508003,
		0,
		Lang.get(101005),
		37508,
		3,
		1237,
		nil,
		1,
		0
	},
	[37508004] = {
		37508004,
		2,
		Lang.get(101006),
		37508,
		4,
		1237,
		{
			RTResTalkAction[124]
		},
		nil,
		nil,
		3
	},
	[37508005] = {
		37508005,
		2,
		Lang.get(101007),
		37508,
		5,
		1237,
		{
			RTResTalkAction[98]
		}
	},
	[37508006] = {
		37508006,
		2,
		Lang.get(101008),
		37508,
		6,
		1237,
		{
			RTResTalkAction[125]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37547,
		1,
		1,
		nil,
		nil,
		nil,
		37547
	},
	[37508007] = {
		37508007,
		0,
		Lang.get(101009),
		37508,
		7,
		1237,
		{
			RTResTalkAction[98]
		}
	},
	[37508008] = {
		37508008,
		0,
		Lang.get(101010),
		37508,
		8,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[37508009] = {
		37508009,
		0,
		Lang.get(101011),
		37508,
		9,
		1237,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[37508010] = {
		37508010,
		3,
		Lang.get(21922),
		37508,
		10,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1
	},
	[37508011] = {
		37508011,
		0,
		Lang.get(101012),
		37508,
		11,
		1240,
		{
			RTResTalkAction[126]
		}
	},
	[37508012] = {
		37508012,
		0,
		Lang.get(101013),
		37508,
		12,
		1213,
		{
			RTResTalkAction[53],
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		60,
		37548,
		1,
		1,
		nil,
		1,
		nil,
		37548
	},
	[37508013] = {
		37508013,
		0,
		Lang.get(101559),
		37508,
		13,
		1240,
		{
			RTResTalkAction[127],
			RTResTalkAction[55]
		}
	},
	[37508014] = {
		37508014,
		0,
		Lang.get(100818),
		37508,
		14,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[128]
		}
	},
	[37508015] = {
		37508015,
		0,
		Lang.get(101015),
		37508,
		15,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		}
	},
	[37508016] = {
		37508016,
		0,
		Lang.get(101016),
		37508,
		16,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[129]
		}
	},
	[37508017] = {
		37508017,
		5,
		Lang.get(101017),
		37508,
		17,
		1213,
		{
			RTResTalkAction[53],
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[37508018] = {
		37508018,
		9,
		Lang.get(101018),
		37508,
		18,
		605,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37508019] = {
		37508019,
		0,
		Lang.get(101019),
		37508,
		19,
		1240,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		37549,
		nil,
		nil,
		nil,
		nil,
		nil,
		37549,
		-1
	},
	[37508020] = {
		37508020,
		0,
		Lang.get(101020),
		37508,
		20,
		1237,
		nil,
		1,
		1
	},
	[37508021] = {
		37508021,
		3,
		Lang.get(101021),
		37508,
		21,
		605,
		nil,
		nil,
		nil,
		nil,
		2760,
		[22] = 1
	},
	[37508022] = {
		37508022,
		0,
		Lang.get(101022),
		37508,
		22,
		1213,
		nil,
		1,
		1
	},
	[37508023] = {
		37508023,
		0,
		Lang.get(101023),
		37508,
		23,
		1240,
		nil,
		1,
		3
	},
	[37508024] = {
		37508024,
		0,
		Lang.get(101024),
		37508,
		24,
		1237,
		nil,
		1,
		2,
		nil,
		nil,
		57
	},
	[37508025] = {
		37508025,
		0,
		Lang.get(101025),
		37508,
		25,
		1240,
		nil,
		1,
		1
	},
	[37508026] = {
		37508026,
		0,
		Lang.get(101026),
		37508,
		26,
		1213,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		37550,
		nil,
		nil,
		nil,
		nil,
		nil,
		37550
	},
	[37508027] = {
		37508027,
		5,
		Lang.get(101027),
		37508,
		27,
		1240,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[37508028] = {
		37508028,
		0,
		Lang.get(101028),
		37508,
		28,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[130]
		}
	},
	[37508029] = {
		37508029,
		3,
		Lang.get(47266),
		37508,
		29,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		255,
		nil,
		1
	},
	[37508030] = {
		37508030,
		0,
		Lang.get(101029),
		37508,
		30,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[37508031] = {
		37508031,
		0,
		Lang.get(101030),
		37508,
		31,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[14]
		}
	},
	[37509001] = {
		37509001,
		0,
		Lang.get(101031),
		37509,
		1,
		1240,
		nil,
		1,
		3,
		nil,
		nil,
		122,
		37555,
		nil,
		nil,
		nil,
		nil,
		nil,
		37555
	},
	[37509002] = {
		37509002,
		0,
		Lang.get(101032),
		37509,
		2,
		1237,
		nil,
		1,
		0
	},
	[37509003] = {
		37509003,
		0,
		Lang.get(101033),
		37509,
		3,
		1240,
		nil,
		1,
		0
	},
	[37509004] = {
		37509004,
		0,
		Lang.get(101034),
		37509,
		4,
		1237,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[37509005] = {
		37509005,
		0,
		Lang.get(101035),
		37509,
		5,
		1213,
		{
			RTResTalkAction[131],
			RTResTalkAction[25]
		}
	},
	[37509006] = {
		37509006,
		0,
		Lang.get(101036),
		37509,
		6,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[55]
		}
	},
	[37509007] = {
		37509007,
		3,
		Lang.get(48342),
		37509,
		7,
		605,
		{
			RTResTalkAction[14]
		},
		[22] = 1
	},
	[37509008] = {
		37509008,
		0,
		Lang.get(101037),
		37509,
		8,
		1213,
		{
			RTResTalkAction[51]
		}
	},
	[37509009] = {
		37509009,
		0,
		Lang.get(101038),
		37509,
		9,
		1237,
		{
			RTResTalkAction[46],
			RTResTalkAction[50]
		}
	},
	[37509010] = {
		37509010,
		0,
		Lang.get(101039),
		37509,
		10,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[50],
			RTResTalkAction[25]
		}
	},
	[37509011] = {
		37509011,
		0,
		Lang.get(101040),
		37509,
		11,
		830,
		{
			RTResTalkAction[14],
			RTResTalkAction[55]
		},
		1,
		0,
		-1
	},
	[37509012] = {
		37509012,
		0,
		Lang.get(101041),
		37509,
		12,
		1213,
		nil,
		1,
		1,
		-1,
		nil,
		nil,
		37556,
		nil,
		nil,
		nil,
		nil,
		nil,
		37556
	},
	[37509013] = {
		37509013,
		0,
		Lang.get(101042),
		37509,
		13,
		830,
		nil,
		1,
		0
	},
	[37509014] = {
		37509014,
		0,
		Lang.get(101043),
		37509,
		14,
		1237,
		nil,
		1,
		2
	},
	[37509015] = {
		37509015,
		0,
		Lang.get(101044),
		37509,
		15,
		830,
		nil,
		1,
		0,
		nil,
		nil,
		60
	},
	[37509016] = {
		37509016,
		0,
		Lang.get(101045),
		37509,
		16,
		830,
		nil,
		1,
		0
	},
	[37509017] = {
		37509017,
		0,
		"……",
		37509,
		17,
		1237,
		{
			RTResTalkAction[132]
		},
		nil,
		nil,
		3
	},
	[37509018] = {
		37509018,
		0,
		Lang.get(101046),
		37509,
		18,
		1213,
		{
			RTResTalkAction[133],
			RTResTalkAction[25]
		}
	},
	[37509019] = {
		37509019,
		5,
		Lang.get(101047),
		37509,
		19,
		1240,
		{
			RTResTalkAction[45],
			RTResTalkAction[55]
		}
	},
	[37509020] = {
		37509020,
		0,
		Lang.get(101048),
		37509,
		20,
		830,
		{
			RTResTalkAction[134],
			RTResTalkAction[14]
		}
	},
	[37602001] = {
		37602001,
		0,
		Lang.get(101049),
		37602,
		1,
		830,
		{
			RTResTalkAction[135]
		},
		nil,
		nil,
		3,
		nil,
		148,
		37560,
		nil,
		nil,
		nil,
		nil,
		nil,
		37560
	},
	[37602002] = {
		37602002,
		0,
		Lang.get(101050),
		37602,
		2,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[136]
		}
	},
	[37602003] = {
		37602003,
		0,
		Lang.get(101051),
		37602,
		3,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[14]
		}
	},
	[37602004] = {
		37602004,
		0,
		Lang.get(101052),
		37602,
		4,
		1213,
		{
			RTResTalkAction[51],
			RTResTalkAction[25]
		}
	},
	[37602005] = {
		37602005,
		0,
		Lang.get(101053),
		37602,
		5,
		830,
		{
			RTResTalkAction[134],
			RTResTalkAction[55]
		}
	},
	[37602006] = {
		37602006,
		2,
		Lang.get(101054),
		37602,
		6,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[136]
		}
	},
	[37602007] = {
		37602007,
		2,
		Lang.get(101055),
		37602,
		7,
		1240,
		{
			RTResTalkAction[137],
			RTResTalkAction[22]
		}
	},
	[37602008] = {
		37602008,
		0,
		Lang.get(101056),
		37602,
		8,
		1213,
		{
			RTResTalkAction[138],
			RTResTalkAction[14],
			RTResTalkAction[25]
		}
	},
	[37602009] = {
		37602009,
		2,
		Lang.get(101057),
		37602,
		9,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[55]
		}
	},
	[37602010] = {
		37602010,
		2,
		Lang.get(101058),
		37602,
		10,
		1237,
		{
			RTResTalkAction[98]
		}
	},
	[37602011] = {
		37602011,
		0,
		Lang.get(101059),
		37602,
		11,
		1213,
		{
			RTResTalkAction[138],
			RTResTalkAction[25]
		}
	},
	[37602012] = {
		37602012,
		3,
		Lang.get(98619),
		37602,
		12,
		605,
		{
			RTResTalkAction[139]
		},
		nil,
		nil,
		nil,
		2750,
		[22] = 1
	},
	[37602013] = {
		37602013,
		0,
		Lang.get(101060),
		37602,
		13,
		1213,
		{
			RTResTalkAction[138]
		}
	},
	[37602014] = {
		37602014,
		2,
		Lang.get(101061),
		37602,
		14,
		1240,
		{
			RTResTalkAction[81],
			RTResTalkAction[55]
		}
	},
	[37602015] = {
		37602015,
		0,
		Lang.get(101062),
		37602,
		15,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[30]
		}
	},
	[37602016] = {
		37602016,
		0,
		Lang.get(21199),
		37602,
		16,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[37602017] = {
		37602017,
		9,
		Lang.get(98619),
		37602,
		17,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		2750,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37602018] = {
		37602018,
		9,
		Lang.get(35349),
		37602,
		18,
		605,
		nil,
		nil,
		nil,
		nil,
		2745,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37602019] = {
		37602019,
		9,
		Lang.get(98619),
		37602,
		19,
		605,
		nil,
		nil,
		nil,
		nil,
		2750,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37602020] = {
		37602020,
		9,
		Lang.get(101063),
		37602,
		20,
		605,
		[22] = 1
	},
	[37602021] = {
		37602021,
		5,
		Lang.get(101064),
		37602,
		21,
		1240,
		{
			RTResTalkAction[123]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37561,
		[19] = 37561,
		[20] = -1
	},
	[37602022] = {
		37602022,
		0,
		Lang.get(101065),
		37602,
		22,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37602023] = {
		37602023,
		0,
		Lang.get(101066),
		37602,
		23,
		830,
		{
			RTResTalkAction[135],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		2755
	},
	[37602024] = {
		37602024,
		0,
		Lang.get(101067),
		37602,
		24,
		1237,
		{
			RTResTalkAction[1],
			RTResTalkAction[136]
		},
		nil,
		nil,
		3,
		nil,
		59,
		37562,
		1,
		1,
		nil,
		1,
		nil,
		37562
	},
	[37602025] = {
		37602025,
		0,
		Lang.get(101068),
		37602,
		25,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37602026] = {
		37602026,
		0,
		Lang.get(101069),
		37602,
		26,
		1213,
		{
			RTResTalkAction[133],
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37602027] = {
		37602027,
		0,
		Lang.get(32365),
		37602,
		27,
		1240,
		{
			RTResTalkAction[6],
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[37602028] = {
		37602028,
		0,
		Lang.get(101070),
		37602,
		28,
		1213,
		{
			RTResTalkAction[6],
			RTResTalkAction[140]
		}
	},
	[37602029] = {
		37602029,
		0,
		Lang.get(101071),
		37602,
		29,
		1213,
		{
			RTResTalkAction[52],
			RTResTalkAction[14]
		}
	},
	[37510001] = {
		37510001,
		3,
		Lang.get(101072),
		37510,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		37565,
		[19] = 37565,
		[22] = 1
	},
	[37510002] = {
		37510002,
		0,
		Lang.get(101073),
		37510,
		2,
		239,
		{
			RTResTalkAction[141]
		},
		nil,
		nil,
		3
	},
	[37510003] = {
		37510003,
		0,
		Lang.get(101074),
		37510,
		3,
		239,
		{
			RTResTalkAction[142]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37510004] = {
		37510004,
		0,
		Lang.get(101075),
		37510,
		4,
		239,
		{
			RTResTalkAction[142]
		}
	},
	[37510005] = {
		37510005,
		0,
		Lang.get(101076),
		37510,
		5,
		1250,
		{
			RTResTalkAction[143],
			RTResTalkAction[144]
		}
	},
	[37510006] = {
		37510006,
		0,
		Lang.get(101077),
		37510,
		6,
		239,
		{
			RTResTalkAction[143],
			RTResTalkAction[144]
		}
	},
	[37510007] = {
		37510007,
		0,
		Lang.get(101078),
		37510,
		7,
		239,
		{
			RTResTalkAction[143],
			RTResTalkAction[144]
		}
	},
	[37510008] = {
		37510008,
		0,
		Lang.get(101079),
		37510,
		8,
		239,
		{
			RTResTalkAction[145],
			RTResTalkAction[144]
		}
	},
	[37510009] = {
		37510009,
		0,
		"……",
		37510,
		9,
		1250,
		{
			RTResTalkAction[143],
			RTResTalkAction[144]
		}
	},
	[37510010] = {
		37510010,
		0,
		Lang.get(101080),
		37510,
		10,
		239,
		{
			RTResTalkAction[146],
			RTResTalkAction[144]
		}
	},
	[37510011] = {
		37510011,
		0,
		Lang.get(101081),
		37510,
		11,
		239,
		{
			RTResTalkAction[147],
			RTResTalkAction[144]
		}
	},
	[37510012] = {
		37510012,
		0,
		Lang.get(101082),
		37510,
		12,
		239,
		{
			RTResTalkAction[146],
			RTResTalkAction[144]
		}
	},
	[37510013] = {
		37510013,
		0,
		Lang.get(101083),
		37510,
		13,
		1250,
		{
			RTResTalkAction[99],
			RTResTalkAction[148]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37566,
		1,
		1,
		nil,
		nil,
		nil,
		37566
	},
	[37510014] = {
		37510014,
		0,
		Lang.get(101084),
		37510,
		14,
		1250,
		{
			RTResTalkAction[149]
		}
	},
	[37510015] = {
		37510015,
		9,
		Lang.get(89492),
		37510,
		15,
		605,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37510016] = {
		37510016,
		0,
		Lang.get(101085),
		37510,
		16,
		1245,
		{
			RTResTalkAction[151],
			RTResTalkAction[69]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37567,
		[19] = 37567,
		[20] = -1
	},
	[37510017] = {
		37510017,
		0,
		Lang.get(101086),
		37510,
		17,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510018] = {
		37510018,
		0,
		Lang.get(101087),
		37510,
		18,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[110]
		}
	},
	[37510019] = {
		37510019,
		0,
		Lang.get(101088),
		37510,
		19,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510020] = {
		37510020,
		0,
		Lang.get(101089),
		37510,
		20,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510021] = {
		37510021,
		0,
		Lang.get(101090),
		37510,
		21,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510022] = {
		37510022,
		2,
		Lang.get(101091),
		37510,
		22,
		1247,
		{
			RTResTalkAction[152],
			RTResTalkAction[60]
		}
	},
	[37510023] = {
		37510023,
		0,
		Lang.get(101092),
		37510,
		23,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510024] = {
		37510024,
		0,
		Lang.get(101093),
		37510,
		24,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510025] = {
		37510025,
		0,
		Lang.get(101094),
		37510,
		25,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[153]
		}
	},
	[37510026] = {
		37510026,
		0,
		Lang.get(101095),
		37510,
		26,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510027] = {
		37510027,
		0,
		Lang.get(66037),
		37510,
		27,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510028] = {
		37510028,
		0,
		Lang.get(101096),
		37510,
		28,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[37510029] = {
		37510029,
		0,
		Lang.get(101097),
		37510,
		29,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510030] = {
		37510030,
		0,
		Lang.get(101098),
		37510,
		30,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37510031] = {
		37510031,
		0,
		Lang.get(101099),
		37510,
		31,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		2752
	},
	[37510032] = {
		37510032,
		3,
		Lang.get(101100),
		37510,
		32,
		605,
		{
			RTResTalkAction[154],
			RTResTalkAction[67]
		},
		[21] = 1245,
		[22] = 1
	},
	[37510033] = {
		37510033,
		0,
		Lang.get(101101),
		37510,
		33,
		1247,
		{
			RTResTalkAction[62],
			RTResTalkAction[60]
		}
	},
	[37510034] = {
		37510034,
		0,
		"「Version.3」。",
		37510,
		34,
		1245,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		2752
	},
	[37510035] = {
		37510035,
		0,
		Lang.get(101102),
		37510,
		35,
		1247,
		{
			RTResTalkAction[155],
			RTResTalkAction[70]
		}
	},
	[37511001] = {
		37511001,
		3,
		Lang.get(101103),
		37511,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		60,
		37570,
		nil,
		nil,
		nil,
		nil,
		nil,
		37570,
		nil,
		nil,
		1
	},
	[37511002] = {
		37511002,
		5,
		Lang.get(67486),
		37511,
		2,
		749,
		{
			RTResTalkAction[156]
		},
		nil,
		nil,
		nil,
		1231
	},
	[37511003] = {
		37511003,
		0,
		Lang.get(101104),
		37511,
		3,
		1240,
		{
			RTResTalkAction[45],
			RTResTalkAction[157]
		}
	},
	[37511004] = {
		37511004,
		0,
		Lang.get(101105),
		37511,
		4,
		1213,
		{
			RTResTalkAction[4],
			RTResTalkAction[158]
		}
	},
	[37511005] = {
		37511005,
		9,
		"……",
		37511,
		5,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[55]
		},
		[22] = 1,
		[20] = 255
	},
	[37511006] = {
		37511006,
		3,
		Lang.get(101106),
		37511,
		6,
		605,
		nil,
		nil,
		nil,
		3,
		1217,
		[22] = 1,
		[20] = -1
	},
	[37511007] = {
		37511007,
		0,
		Lang.get(101107),
		37511,
		7,
		1237,
		{
			RTResTalkAction[1]
		}
	},
	[37511008] = {
		37511008,
		0,
		Lang.get(101108),
		37511,
		8,
		1240,
		{
			RTResTalkAction[19],
			RTResTalkAction[25]
		}
	},
	[37511009] = {
		37511009,
		0,
		Lang.get(101109),
		37511,
		9,
		1213,
		{
			RTResTalkAction[133],
			RTResTalkAction[14]
		}
	},
	[37511010] = {
		37511010,
		9,
		Lang.get(21922),
		37511,
		10,
		605,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1,
		[20] = 255
	},
	[37511011] = {
		37511011,
		9,
		"……",
		37511,
		11,
		605,
		[22] = 1,
		[20] = 255
	},
	[37511012] = {
		37511012,
		3,
		"1，1，【？】，7，17，41，99……",
		37511,
		12,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		37571,
		nil,
		nil,
		nil,
		nil,
		nil,
		37571,
		-1,
		nil,
		1
	},
	[37511013] = {
		37511013,
		0,
		Lang.get(101110),
		37511,
		13,
		1240,
		{
			RTResTalkAction[88]
		}
	},
	[37511014] = {
		37511014,
		0,
		Lang.get(101111),
		37511,
		14,
		1240,
		{
			RTResTalkAction[45]
		}
	},
	[37511015] = {
		37511015,
		0,
		Lang.get(101112),
		37511,
		15,
		1213,
		{
			RTResTalkAction[159],
			RTResTalkAction[14]
		}
	},
	[37511016] = {
		37511016,
		0,
		Lang.get(101113),
		37511,
		16,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[55]
		}
	},
	[37511017] = {
		37511017,
		4,
		nil,
		37511,
		17,
		1237,
		{
			RTResTalkAction[25]
		},
		[29] = {
			{
				id = 37511018,
				branch_content = Lang.get(101114)
			},
			{
				id = 37511018,
				branch_content = Lang.get(101115)
			},
			{
				id = 37511018,
				branch_content = Lang.get(101116)
			}
		}
	},
	[37511018] = {
		37511018,
		9,
		"……",
		37511,
		18,
		605,
		[22] = 1,
		[20] = 255
	},
	[37511019] = {
		37511019,
		0,
		Lang.get(101117),
		37511,
		19,
		834,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37572,
		nil,
		nil,
		nil,
		nil,
		nil,
		37572,
		-1
	},
	[37511020] = {
		37511020,
		0,
		Lang.get(101118),
		37511,
		20,
		834,
		nil,
		1,
		0
	},
	[37511021] = {
		37511021,
		0,
		Lang.get(101119),
		37511,
		21,
		1240,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3,
		2749
	},
	[37511022] = {
		37511022,
		0,
		Lang.get(101120),
		37511,
		22,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[160]
		},
		nil,
		nil,
		nil,
		2765,
		nil,
		nil,
		1
	},
	[37511023] = {
		37511023,
		9,
		"……",
		37511,
		23,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[25]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37511024] = {
		37511024,
		0,
		Lang.get(101121),
		37511,
		24,
		1213,
		{
			RTResTalkAction[133]
		},
		nil,
		nil,
		3,
		2755
	},
	[37511025] = {
		37511025,
		0,
		Lang.get(101122),
		37511,
		25,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[55]
		}
	},
	[37512001] = {
		37512001,
		3,
		Lang.get(101123),
		37512,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		156,
		37575,
		[19] = 37575,
		[22] = 1
	},
	[37512002] = {
		37512002,
		0,
		Lang.get(101124),
		37512,
		2,
		1253,
		nil,
		1,
		0
	},
	[37512003] = {
		37512003,
		0,
		Lang.get(101125),
		37512,
		3,
		1240,
		nil,
		1,
		3
	},
	[37512004] = {
		37512004,
		2,
		Lang.get(101126),
		37512,
		4,
		1237,
		nil,
		1,
		1
	},
	[37512005] = {
		37512005,
		0,
		Lang.get(101127),
		37512,
		5,
		1237,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		3
	},
	[37512006] = {
		37512006,
		0,
		Lang.get(101128),
		37512,
		6,
		1213,
		{
			RTResTalkAction[52],
			RTResTalkAction[25]
		}
	},
	[37512007] = {
		37512007,
		0,
		Lang.get(101129),
		37512,
		7,
		1240,
		{
			RTResTalkAction[88],
			RTResTalkAction[55]
		}
	},
	[37512008] = {
		37512008,
		0,
		Lang.get(101130),
		37512,
		8,
		1253,
		{
			RTResTalkAction[161],
			RTResTalkAction[162],
			RTResTalkAction[14]
		}
	},
	[37512009] = {
		37512009,
		0,
		Lang.get(101131),
		37512,
		9,
		1213,
		{
			RTResTalkAction[163],
			RTResTalkAction[164]
		}
	},
	[37512010] = {
		37512010,
		2,
		Lang.get(101132),
		37512,
		10,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[55],
			RTResTalkAction[106]
		}
	},
	[37512011] = {
		37512011,
		0,
		Lang.get(101133),
		37512,
		11,
		1253,
		{
			RTResTalkAction[165],
			RTResTalkAction[162],
			RTResTalkAction[25]
		}
	},
	[37512012] = {
		37512012,
		0,
		Lang.get(101134),
		37512,
		12,
		1213,
		{
			RTResTalkAction[165],
			RTResTalkAction[164]
		}
	},
	[37512013] = {
		37512013,
		0,
		Lang.get(101135),
		37512,
		13,
		1253,
		{
			RTResTalkAction[166],
			RTResTalkAction[164]
		}
	},
	[37512014] = {
		37512014,
		0,
		Lang.get(101136),
		37512,
		14,
		1213,
		{
			RTResTalkAction[167],
			RTResTalkAction[164]
		}
	},
	[37512015] = {
		37512015,
		0,
		Lang.get(101137),
		37512,
		15,
		1253,
		{
			RTResTalkAction[166],
			RTResTalkAction[164]
		}
	},
	[37512016] = {
		37512016,
		2,
		Lang.get(101138),
		37512,
		16,
		1240,
		{
			RTResTalkAction[88],
			RTResTalkAction[55],
			RTResTalkAction[106]
		}
	},
	[37512017] = {
		37512017,
		2,
		Lang.get(101139),
		37512,
		17,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37512018] = {
		37512018,
		2,
		Lang.get(101140),
		37512,
		18,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[14]
		}
	},
	[37512019] = {
		37512019,
		0,
		Lang.get(101141),
		37512,
		19,
		1213,
		{
			RTResTalkAction[161],
			RTResTalkAction[162],
			RTResTalkAction[25]
		}
	},
	[37512020] = {
		37512020,
		2,
		Lang.get(101142),
		37512,
		20,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[55],
			RTResTalkAction[106]
		}
	},
	[37512021] = {
		37512021,
		2,
		"3……2……1！",
		37512,
		21,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37512022] = {
		37512022,
		3,
		Lang.get(21922),
		37512,
		22,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1
	},
	[37512023] = {
		37512023,
		0,
		Lang.get(101143),
		37512,
		23,
		1213,
		{
			RTResTalkAction[168]
		}
	},
	[37512024] = {
		37512024,
		0,
		Lang.get(101144),
		37512,
		24,
		1253,
		{
			RTResTalkAction[166],
			RTResTalkAction[162]
		}
	},
	[37512025] = {
		37512025,
		0,
		"……！",
		37512,
		25,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[55],
			RTResTalkAction[106]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37576,
		1,
		1,
		nil,
		1,
		nil,
		37576
	},
	[37512026] = {
		37512026,
		0,
		Lang.get(101145),
		37512,
		26,
		1240,
		{
			RTResTalkAction[127],
			RTResTalkAction[25]
		}
	},
	[37512027] = {
		37512027,
		0,
		Lang.get(101146),
		37512,
		27,
		1250,
		{
			RTResTalkAction[149],
			RTResTalkAction[14]
		}
	},
	[37513001] = {
		37513001,
		0,
		Lang.get(101147),
		37513,
		1,
		1240,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3,
		nil,
		57,
		37580,
		nil,
		nil,
		nil,
		nil,
		nil,
		37580
	},
	[37513002] = {
		37513002,
		2,
		Lang.get(101148),
		37513,
		2,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[14]
		}
	},
	[37513003] = {
		37513003,
		0,
		Lang.get(101149),
		37513,
		3,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[25]
		}
	},
	[37513004] = {
		37513004,
		0,
		Lang.get(101150),
		37513,
		4,
		1250,
		{
			RTResTalkAction[4],
			RTResTalkAction[144]
		}
	},
	[37513005] = {
		37513005,
		0,
		Lang.get(101151),
		37513,
		5,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[169]
		}
	},
	[37513006] = {
		37513006,
		3,
		Lang.get(101152),
		37513,
		6,
		605,
		{
			RTResTalkAction[170],
			RTResTalkAction[171],
			RTResTalkAction[14],
			RTResTalkAction[150]
		},
		[22] = 1
	},
	[37513007] = {
		37513007,
		0,
		Lang.get(101153),
		37513,
		7,
		1213,
		{
			RTResTalkAction[133],
			RTResTalkAction[172],
			RTResTalkAction[173]
		}
	},
	[37513008] = {
		37513008,
		0,
		Lang.get(101154),
		37513,
		8,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[55]
		}
	},
	[37513009] = {
		37513009,
		2,
		Lang.get(101155),
		37513,
		9,
		1237,
		{
			RTResTalkAction[1]
		}
	},
	[37513010] = {
		37513010,
		0,
		Lang.get(101156),
		37513,
		10,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[25]
		}
	},
	[37513011] = {
		37513011,
		0,
		Lang.get(101157),
		37513,
		11,
		1240,
		{
			RTResTalkAction[18]
		}
	},
	[37513012] = {
		37513012,
		5,
		Lang.get(101158),
		37513,
		12,
		1240,
		{
			RTResTalkAction[45]
		}
	},
	[37513013] = {
		37513013,
		0,
		Lang.get(101159),
		37513,
		13,
		1253,
		{
			RTResTalkAction[4],
			RTResTalkAction[162]
		}
	},
	[37513014] = {
		37513014,
		0,
		Lang.get(101160),
		37513,
		14,
		1253,
		{
			RTResTalkAction[4],
			RTResTalkAction[164]
		}
	},
	[37513015] = {
		37513015,
		0,
		Lang.get(101161),
		37513,
		15,
		1253,
		{
			RTResTalkAction[174],
			RTResTalkAction[14]
		}
	},
	[37513016] = {
		37513016,
		0,
		"……",
		37513,
		16,
		1250,
		{
			RTResTalkAction[99],
			RTResTalkAction[106]
		}
	},
	[37513017] = {
		37513017,
		9,
		Lang.get(101162),
		37513,
		17,
		605,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		nil,
		nil,
		148,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37513018] = {
		37513018,
		0,
		Lang.get(101163),
		37513,
		18,
		1253,
		{
			RTResTalkAction[175]
		},
		[20] = -1
	},
	[37513019] = {
		37513019,
		3,
		Lang.get(101164),
		37513,
		19,
		605,
		{
			RTResTalkAction[176],
			RTResTalkAction[106]
		},
		nil,
		nil,
		nil,
		2750,
		[22] = 1
	},
	[37513020] = {
		37513020,
		0,
		Lang.get(101165),
		37513,
		20,
		1213,
		{
			RTResTalkAction[131],
			RTResTalkAction[150]
		}
	},
	[37513021] = {
		37513021,
		0,
		Lang.get(101166),
		37513,
		21,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		2750
	},
	[37513022] = {
		37513022,
		0,
		Lang.get(101167),
		37513,
		22,
		1253,
		{
			RTResTalkAction[109],
			RTResTalkAction[14],
			RTResTalkAction[55]
		}
	},
	[37513023] = {
		37513023,
		0,
		Lang.get(101168),
		37513,
		23,
		1250,
		{
			RTResTalkAction[177],
			RTResTalkAction[106]
		}
	},
	[37513024] = {
		37513024,
		3,
		Lang.get(68437),
		37513,
		24,
		605,
		{
			RTResTalkAction[178],
			RTResTalkAction[150]
		},
		nil,
		nil,
		nil,
		2747,
		[21] = 1252,
		[22] = 1
	},
	[37513025] = {
		37513025,
		0,
		Lang.get(101169),
		37513,
		25,
		1253,
		{
			RTResTalkAction[109]
		}
	},
	[37603001] = {
		37603001,
		0,
		Lang.get(101170),
		37603,
		1,
		1253,
		{
			RTResTalkAction[175]
		},
		nil,
		nil,
		3,
		nil,
		148,
		37581,
		nil,
		nil,
		nil,
		nil,
		nil,
		37581
	},
	[37603002] = {
		37603002,
		0,
		Lang.get(101171),
		37603,
		2,
		1253,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		nil,
		2747
	},
	[37603003] = {
		37603003,
		0,
		Lang.get(101172),
		37603,
		3,
		1213,
		{
			RTResTalkAction[51],
			RTResTalkAction[106]
		}
	},
	[37603004] = {
		37603004,
		0,
		Lang.get(101173),
		37603,
		4,
		1237,
		{
			RTResTalkAction[72],
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		2750
	},
	[37603005] = {
		37603005,
		0,
		Lang.get(101174),
		37603,
		5,
		1240,
		{
			RTResTalkAction[88],
			RTResTalkAction[25]
		}
	},
	[37603006] = {
		37603006,
		5,
		Lang.get(101175),
		37603,
		6,
		1240,
		{
			RTResTalkAction[123]
		}
	},
	[37603007] = {
		37603007,
		0,
		Lang.get(101176),
		37603,
		7,
		1250,
		{
			RTResTalkAction[179],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		194
	},
	[37603008] = {
		37603008,
		9,
		"……",
		37603,
		8,
		605,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37603009] = {
		37603009,
		2,
		Lang.get(101177),
		37603,
		9,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37603010] = {
		37603010,
		2,
		Lang.get(101178),
		37603,
		10,
		1240,
		{
			RTResTalkAction[180]
		}
	},
	[37603011] = {
		37603011,
		0,
		Lang.get(101179),
		37603,
		11,
		1253,
		{
			RTResTalkAction[100],
			RTResTalkAction[14]
		}
	},
	[37603012] = {
		37603012,
		0,
		Lang.get(101180),
		37603,
		12,
		1213,
		{
			RTResTalkAction[138],
			RTResTalkAction[106]
		}
	},
	[37603013] = {
		37603013,
		0,
		Lang.get(101181),
		37603,
		13,
		1237,
		{
			RTResTalkAction[124],
			RTResTalkAction[55]
		}
	},
	[37603014] = {
		37603014,
		2,
		Lang.get(101182),
		37603,
		14,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[25]
		}
	},
	[37603015] = {
		37603015,
		2,
		Lang.get(101183),
		37603,
		15,
		1240,
		{
			RTResTalkAction[8]
		}
	},
	[37603016] = {
		37603016,
		9,
		Lang.get(35349),
		37603,
		16,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		2765,
		[22] = 1
	},
	[37603017] = {
		37603017,
		0,
		Lang.get(101184),
		37603,
		17,
		1240,
		nil,
		1,
		1,
		-1,
		nil,
		57,
		37582,
		1,
		1,
		nil,
		nil,
		nil,
		37582,
		-1
	},
	[37603018] = {
		37603018,
		0,
		Lang.get(101185),
		37603,
		18,
		1253,
		nil,
		1,
		0
	},
	[37603019] = {
		37603019,
		0,
		Lang.get(101186),
		37603,
		19,
		1213,
		nil,
		1,
		1
	},
	[37603020] = {
		37603020,
		0,
		Lang.get(101187),
		37603,
		20,
		1237,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		37583,
		nil,
		nil,
		nil,
		1,
		nil,
		37583
	},
	[37603021] = {
		37603021,
		0,
		Lang.get(101188),
		37603,
		21,
		1240,
		nil,
		1,
		2
	},
	[37603022] = {
		37603022,
		0,
		Lang.get(101560),
		37603,
		22,
		1240,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[37603023] = {
		37603023,
		0,
		Lang.get(101190),
		37603,
		23,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[91]
		}
	},
	[37603024] = {
		37603024,
		0,
		Lang.get(101191),
		37603,
		24,
		1240,
		{
			RTResTalkAction[181],
			RTResTalkAction[22]
		}
	},
	[37603025] = {
		37603025,
		0,
		Lang.get(101192),
		37603,
		25,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37603026] = {
		37603026,
		0,
		Lang.get(101193),
		37603,
		26,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37603027] = {
		37603027,
		0,
		Lang.get(101194),
		37603,
		27,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		163
	},
	[37603028] = {
		37603028,
		0,
		Lang.get(101195),
		37603,
		28,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37603029] = {
		37603029,
		0,
		Lang.get(101196),
		37603,
		29,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[130]
		}
	},
	[37603030] = {
		37603030,
		0,
		Lang.get(101197),
		37603,
		30,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37603031] = {
		37603031,
		0,
		Lang.get(101198),
		37603,
		31,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[27]
		}
	},
	[37603032] = {
		37603032,
		0,
		Lang.get(101199),
		37603,
		32,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37603033] = {
		37603033,
		0,
		Lang.get(101200),
		37603,
		33,
		1240,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[37603034] = {
		37603034,
		0,
		Lang.get(101201),
		37603,
		34,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37603035] = {
		37603035,
		0,
		Lang.get(101202),
		37603,
		35,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[22]
		}
	},
	[37603036] = {
		37603036,
		0,
		Lang.get(101203),
		37603,
		36,
		1237,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[37603037] = {
		37603037,
		0,
		Lang.get(101204),
		37603,
		37,
		1237,
		{
			RTResTalkAction[125],
			RTResTalkAction[14]
		}
	},
	[37514001] = {
		37514001,
		3,
		Lang.get(101205),
		37514,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		37585,
		[19] = 37585,
		[22] = 1
	},
	[37514002] = {
		37514002,
		0,
		Lang.get(101206),
		37514,
		2,
		1247,
		nil,
		1,
		0
	},
	[37514003] = {
		37514003,
		0,
		Lang.get(101207),
		37514,
		3,
		1245,
		nil,
		1,
		0
	},
	[37514004] = {
		37514004,
		0,
		Lang.get(101208),
		37514,
		4,
		1247,
		{
			RTResTalkAction[182]
		},
		nil,
		nil,
		3
	},
	[37514005] = {
		37514005,
		0,
		Lang.get(101209),
		37514,
		5,
		1250,
		{
			RTResTalkAction[99],
			RTResTalkAction[67]
		}
	},
	[37514006] = {
		37514006,
		0,
		Lang.get(101210),
		37514,
		6,
		1247,
		{
			RTResTalkAction[183],
			RTResTalkAction[150]
		}
	},
	[37514007] = {
		37514007,
		0,
		Lang.get(101211),
		37514,
		7,
		1245,
		{
			RTResTalkAction[58],
			RTResTalkAction[184]
		}
	},
	[37514008] = {
		37514008,
		0,
		Lang.get(101212),
		37514,
		8,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37514009] = {
		37514009,
		0,
		Lang.get(101213),
		37514,
		9,
		1247,
		{
			RTResTalkAction[58],
			RTResTalkAction[60]
		}
	},
	[37514010] = {
		37514010,
		0,
		Lang.get(68421),
		37514,
		10,
		1250,
		{
			RTResTalkAction[149],
			RTResTalkAction[67],
			RTResTalkAction[70]
		},
		nil,
		nil,
		nil,
		2752
	},
	[37514011] = {
		37514011,
		5,
		Lang.get(101214),
		37514,
		11,
		1240,
		{
			RTResTalkAction[123],
			RTResTalkAction[150]
		}
	},
	[37514012] = {
		37514012,
		9,
		Lang.get(21922),
		37514,
		12,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		2745,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37514013] = {
		37514013,
		0,
		Lang.get(101215),
		37514,
		13,
		1240,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		122,
		37586,
		1,
		nil,
		nil,
		nil,
		nil,
		37586,
		-1
	},
	[37514014] = {
		37514014,
		0,
		Lang.get(101216),
		37514,
		14,
		1245,
		{
			RTResTalkAction[24],
			RTResTalkAction[185]
		}
	},
	[37514015] = {
		37514015,
		0,
		Lang.get(101217),
		37514,
		15,
		1240,
		{
			RTResTalkAction[186],
			RTResTalkAction[60]
		}
	},
	[37514016] = {
		37514016,
		0,
		Lang.get(101218),
		37514,
		16,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[153]
		}
	},
	[37514017] = {
		37514017,
		0,
		Lang.get(101219),
		37514,
		17,
		1247,
		{
			RTResTalkAction[182],
			RTResTalkAction[14],
			RTResTalkAction[70]
		}
	},
	[37514018] = {
		37514018,
		0,
		Lang.get(101220),
		37514,
		18,
		1240,
		{
			RTResTalkAction[187],
			RTResTalkAction[67]
		}
	},
	[37514019] = {
		37514019,
		0,
		Lang.get(101221),
		37514,
		19,
		1247,
		{
			RTResTalkAction[182],
			RTResTalkAction[14]
		}
	},
	[37514020] = {
		37514020,
		9,
		Lang.get(101222),
		37514,
		20,
		605,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37514021] = {
		37514021,
		0,
		Lang.get(101223),
		37514,
		21,
		1240,
		{
			RTResTalkAction[8]
		},
		[20] = -1
	},
	[37514022] = {
		37514022,
		0,
		Lang.get(101224),
		37514,
		22,
		1247,
		{
			RTResTalkAction[56],
			RTResTalkAction[14]
		}
	},
	[37514023] = {
		37514023,
		0,
		Lang.get(101225),
		37514,
		23,
		1245,
		{
			RTResTalkAction[188],
			RTResTalkAction[67]
		}
	},
	[37514024] = {
		37514024,
		0,
		Lang.get(101226),
		37514,
		24,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[60]
		}
	},
	[37514025] = {
		37514025,
		0,
		Lang.get(101227),
		37514,
		25,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37514026] = {
		37514026,
		0,
		Lang.get(101228),
		37514,
		26,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37514027] = {
		37514027,
		0,
		Lang.get(101229),
		37514,
		27,
		1240,
		{
			RTResTalkAction[21],
			RTResTalkAction[60]
		}
	},
	[37514028] = {
		37514028,
		0,
		Lang.get(101230),
		37514,
		28,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[69]
		}
	},
	[37514029] = {
		37514029,
		0,
		Lang.get(101231),
		37514,
		29,
		1240,
		{
			RTResTalkAction[16],
			RTResTalkAction[60]
		}
	},
	[37514030] = {
		37514030,
		0,
		Lang.get(101561),
		37514,
		30,
		1240,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37514031] = {
		37514031,
		0,
		Lang.get(101233),
		37514,
		31,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[110]
		}
	},
	[37514032] = {
		37514032,
		0,
		Lang.get(101234),
		37514,
		32,
		1240,
		{
			RTResTalkAction[21],
			RTResTalkAction[60]
		}
	},
	[37515001] = {
		37515001,
		3,
		Lang.get(101235),
		37515,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		164,
		37590,
		1,
		nil,
		nil,
		nil,
		nil,
		37590,
		nil,
		nil,
		1
	},
	[37515002] = {
		37515002,
		0,
		Lang.get(101236),
		37515,
		2,
		257,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[37515003] = {
		37515003,
		0,
		Lang.get(101237),
		37515,
		3,
		257,
		{
			RTResTalkAction[31]
		}
	},
	[37515004] = {
		37515004,
		0,
		Lang.get(20200),
		37515,
		4,
		1245,
		{
			RTResTalkAction[189],
			RTResTalkAction[69]
		}
	},
	[37515005] = {
		37515005,
		0,
		Lang.get(101238),
		37515,
		5,
		257,
		{
			RTResTalkAction[189],
			RTResTalkAction[60]
		}
	},
	[37515006] = {
		37515006,
		0,
		Lang.get(101239),
		37515,
		6,
		257,
		{
			RTResTalkAction[189],
			RTResTalkAction[60]
		}
	},
	[37515007] = {
		37515007,
		0,
		"……「Angel Player」。",
		37515,
		7,
		1245,
		{
			RTResTalkAction[189],
			RTResTalkAction[110]
		}
	},
	[37515008] = {
		37515008,
		0,
		Lang.get(101240),
		37515,
		8,
		257,
		{
			RTResTalkAction[189],
			RTResTalkAction[60]
		}
	},
	[37515009] = {
		37515009,
		0,
		Lang.get(101241),
		37515,
		9,
		1245,
		{
			RTResTalkAction[189],
			RTResTalkAction[60]
		}
	},
	[37515010] = {
		37515010,
		0,
		Lang.get(101242),
		37515,
		10,
		257,
		{
			RTResTalkAction[189],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37515011] = {
		37515011,
		0,
		Lang.get(101243),
		37515,
		11,
		257,
		{
			RTResTalkAction[31],
			RTResTalkAction[70]
		}
	},
	[37515012] = {
		37515012,
		9,
		Lang.get(101244),
		37515,
		12,
		605,
		{
			RTResTalkAction[190]
		},
		nil,
		nil,
		nil,
		nil,
		193,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37515013] = {
		37515013,
		0,
		Lang.get(101245),
		37515,
		13,
		239,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		37591,
		nil,
		nil,
		nil,
		nil,
		nil,
		37591,
		-1
	},
	[37515014] = {
		37515014,
		0,
		Lang.get(101246),
		37515,
		14,
		239,
		nil,
		1,
		0
	},
	[37515015] = {
		37515015,
		0,
		Lang.get(87691),
		37515,
		15,
		239,
		nil,
		1,
		1
	},
	[37515016] = {
		37515016,
		0,
		Lang.get(101562),
		37515,
		16,
		1118,
		nil,
		1,
		1
	},
	[37515017] = {
		37515017,
		0,
		Lang.get(101248),
		37515,
		17,
		239,
		{
			RTResTalkAction[191]
		},
		nil,
		nil,
		3
	},
	[37515018] = {
		37515018,
		0,
		Lang.get(101249),
		37515,
		18,
		239,
		{
			RTResTalkAction[142]
		}
	},
	[37515019] = {
		37515019,
		0,
		Lang.get(101250),
		37515,
		19,
		1118,
		{
			RTResTalkAction[192],
			RTResTalkAction[193]
		}
	},
	[37515020] = {
		37515020,
		0,
		Lang.get(101251),
		37515,
		20,
		1118,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		}
	},
	[37515021] = {
		37515021,
		0,
		Lang.get(101252),
		37515,
		21,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[196]
		}
	},
	[37515022] = {
		37515022,
		0,
		Lang.get(101253),
		37515,
		22,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[197]
		}
	},
	[37515023] = {
		37515023,
		0,
		Lang.get(101254),
		37515,
		23,
		1118,
		{
			RTResTalkAction[198],
			RTResTalkAction[193]
		}
	},
	[37515024] = {
		37515024,
		9,
		Lang.get(101255),
		37515,
		24,
		605,
		{
			RTResTalkAction[199],
			RTResTalkAction[148]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37515025] = {
		37515025,
		0,
		Lang.get(101256),
		37515,
		25,
		1207,
		nil,
		1,
		0,
		-1,
		nil,
		nil,
		37592,
		1,
		nil,
		nil,
		1,
		nil,
		37592,
		-1
	},
	[37515026] = {
		37515026,
		0,
		Lang.get(101257),
		37515,
		26,
		239,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37515027] = {
		37515027,
		0,
		Lang.get(101258),
		37515,
		27,
		1207,
		{
			RTResTalkAction[200]
		},
		nil,
		nil,
		3
	},
	[37515028] = {
		37515028,
		0,
		Lang.get(101259),
		37515,
		28,
		1118,
		{
			RTResTalkAction[201],
			RTResTalkAction[202]
		}
	},
	[37515029] = {
		37515029,
		0,
		Lang.get(101260),
		37515,
		29,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[203]
		}
	},
	[37515030] = {
		37515030,
		0,
		Lang.get(101261),
		37515,
		30,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37515031] = {
		37515031,
		0,
		Lang.get(20587),
		37515,
		31,
		1118,
		{
			RTResTalkAction[204],
			RTResTalkAction[193]
		}
	},
	[37515032] = {
		37515032,
		0,
		Lang.get(101262),
		37515,
		32,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37515033] = {
		37515033,
		0,
		Lang.get(101263),
		37515,
		33,
		239,
		{
			RTResTalkAction[205],
			RTResTalkAction[199]
		}
	},
	[37516001] = {
		37516001,
		0,
		Lang.get(101563),
		37516,
		1,
		1118,
		nil,
		1,
		3,
		nil,
		nil,
		63,
		37595,
		nil,
		nil,
		nil,
		nil,
		nil,
		37595
	},
	[37516002] = {
		37516002,
		0,
		Lang.get(101265),
		37516,
		2,
		239,
		nil,
		1,
		1
	},
	[37516003] = {
		37516003,
		0,
		Lang.get(101266),
		37516,
		3,
		1118,
		{
			RTResTalkAction[201]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1
	},
	[37516004] = {
		37516004,
		0,
		Lang.get(101267),
		37516,
		4,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516005] = {
		37516005,
		0,
		Lang.get(101268),
		37516,
		5,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[206]
		}
	},
	[37516006] = {
		37516006,
		0,
		Lang.get(24723),
		37516,
		6,
		1118,
		{
			RTResTalkAction[198],
			RTResTalkAction[193]
		}
	},
	[37516007] = {
		37516007,
		2,
		Lang.get(101269),
		37516,
		7,
		1118,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		37596,
		[19] = 37596,
		[20] = 200
	},
	[37516008] = {
		37516008,
		0,
		Lang.get(101270),
		37516,
		8,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[203]
		}
	},
	[37516009] = {
		37516009,
		0,
		Lang.get(101271),
		37516,
		9,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		}
	},
	[37516010] = {
		37516010,
		9,
		Lang.get(101272),
		37516,
		10,
		1233,
		{
			RTResTalkAction[199],
			RTResTalkAction[148]
		},
		[22] = 1
	},
	[37516011] = {
		37516011,
		9,
		Lang.get(101273),
		37516,
		11,
		1233,
		[22] = 1
	},
	[37516012] = {
		37516012,
		0,
		Lang.get(101274),
		37516,
		12,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[207]
		}
	},
	[37516013] = {
		37516013,
		0,
		"……",
		37516,
		13,
		1118,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516014] = {
		37516014,
		0,
		Lang.get(101275),
		37516,
		14,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516015] = {
		37516015,
		0,
		Lang.get(101276),
		37516,
		15,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516016] = {
		37516016,
		0,
		Lang.get(101277),
		37516,
		16,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516017] = {
		37516017,
		0,
		Lang.get(101278),
		37516,
		17,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516018] = {
		37516018,
		9,
		Lang.get(101279),
		37516,
		18,
		1233,
		{
			RTResTalkAction[199],
			RTResTalkAction[148]
		},
		[22] = 1
	},
	[37516019] = {
		37516019,
		0,
		Lang.get(101280),
		37516,
		19,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516020] = {
		37516020,
		0,
		Lang.get(101281),
		37516,
		20,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516021] = {
		37516021,
		0,
		Lang.get(101282),
		37516,
		21,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[206]
		}
	},
	[37516022] = {
		37516022,
		0,
		Lang.get(18451),
		37516,
		22,
		1118,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		}
	},
	[37516023] = {
		37516023,
		0,
		Lang.get(101283),
		37516,
		23,
		1118,
		{
			RTResTalkAction[208],
			RTResTalkAction[193]
		}
	},
	[37516024] = {
		37516024,
		0,
		Lang.get(101284),
		37516,
		24,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[197]
		}
	},
	[37516025] = {
		37516025,
		9,
		Lang.get(101285),
		37516,
		25,
		1233,
		{
			RTResTalkAction[199],
			RTResTalkAction[148]
		},
		[22] = 1
	},
	[37516026] = {
		37516026,
		0,
		Lang.get(101286),
		37516,
		26,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		}
	},
	[37516027] = {
		37516027,
		0,
		Lang.get(101287),
		37516,
		27,
		239,
		{
			RTResTalkAction[194],
			RTResTalkAction[193]
		}
	},
	[37516028] = {
		37516028,
		0,
		Lang.get(101288),
		37516,
		28,
		239,
		{
			RTResTalkAction[195],
			RTResTalkAction[193]
		}
	},
	[37516029] = {
		37516029,
		3,
		Lang.get(101289),
		37516,
		29,
		1233,
		{
			RTResTalkAction[199],
			RTResTalkAction[148]
		},
		nil,
		nil,
		3,
		nil,
		158,
		37597,
		nil,
		nil,
		nil,
		nil,
		nil,
		37597,
		-1,
		nil,
		1
	},
	[37516030] = {
		37516030,
		0,
		Lang.get(101290),
		37516,
		30,
		239,
		{
			RTResTalkAction[209]
		}
	},
	[37516031] = {
		37516031,
		0,
		Lang.get(101291),
		37516,
		31,
		1118,
		{
			RTResTalkAction[210],
			RTResTalkAction[193]
		}
	},
	[37517001] = {
		37517001,
		3,
		Lang.get(101292),
		37517,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		176,
		37600,
		[19] = 37600,
		[22] = 1
	},
	[37517002] = {
		37517002,
		5,
		Lang.get(101293),
		37517,
		2,
		1247,
		{
			RTResTalkAction[211]
		},
		nil,
		nil,
		3
	},
	[37517003] = {
		37517003,
		0,
		Lang.get(101294),
		37517,
		3,
		1247,
		{
			RTResTalkAction[182]
		}
	},
	[37517004] = {
		37517004,
		0,
		Lang.get(101295),
		37517,
		4,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[67]
		}
	},
	[37517005] = {
		37517005,
		0,
		Lang.get(101296),
		37517,
		5,
		1245,
		{
			RTResTalkAction[188],
			RTResTalkAction[14]
		}
	},
	[37517006] = {
		37517006,
		3,
		Lang.get(35381),
		37517,
		6,
		605,
		{
			RTResTalkAction[212]
		},
		nil,
		nil,
		nil,
		2747,
		[21] = 1245,
		[22] = 1
	},
	[37517007] = {
		37517007,
		0,
		Lang.get(101297),
		37517,
		7,
		1250,
		{
			RTResTalkAction[213],
			RTResTalkAction[214]
		}
	},
	[37517008] = {
		37517008,
		0,
		Lang.get(101298),
		37517,
		8,
		1245,
		{
			RTResTalkAction[215],
			RTResTalkAction[144]
		}
	},
	[37517009] = {
		37517009,
		0,
		Lang.get(101299),
		37517,
		9,
		1245,
		{
			RTResTalkAction[216],
			RTResTalkAction[144]
		}
	},
	[37517010] = {
		37517010,
		0,
		Lang.get(101300),
		37517,
		10,
		1250,
		{
			RTResTalkAction[217],
			RTResTalkAction[144]
		}
	},
	[37517011] = {
		37517011,
		0,
		Lang.get(101301),
		37517,
		11,
		1250,
		{
			RTResTalkAction[217],
			RTResTalkAction[214]
		}
	},
	[37517012] = {
		37517012,
		5,
		Lang.get(101302),
		37517,
		12,
		1240,
		{
			RTResTalkAction[123],
			RTResTalkAction[70],
			RTResTalkAction[150]
		}
	},
	[37517013] = {
		37517013,
		0,
		Lang.get(101303),
		37517,
		13,
		1247,
		{
			RTResTalkAction[183],
			RTResTalkAction[14]
		}
	},
	[37604001] = {
		37604001,
		9,
		Lang.get(88039),
		37604,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		1225,
		186,
		37601,
		nil,
		1,
		nil,
		nil,
		nil,
		37601,
		255,
		nil,
		1
	},
	[37604002] = {
		37604002,
		0,
		"？",
		37604,
		2,
		1250,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37602,
		nil,
		nil,
		nil,
		nil,
		nil,
		37602,
		-1
	},
	[37604003] = {
		37604003,
		0,
		Lang.get(101304),
		37604,
		3,
		1240,
		{
			RTResTalkAction[43],
			RTResTalkAction[150]
		}
	},
	[37604004] = {
		37604004,
		3,
		Lang.get(97620),
		37604,
		4,
		605,
		{
			RTResTalkAction[14]
		},
		[22] = 1
	},
	[37604005] = {
		37604005,
		13,
		Lang.get(101305),
		37604,
		5,
		1118,
		{
			RTResTalkAction[201]
		},
		[27] = 3
	},
	[37604006] = {
		37604006,
		0,
		Lang.get(101306),
		37604,
		6,
		1240,
		{
			RTResTalkAction[218]
		},
		1,
		3,
		[27] = 3
	},
	[37604007] = {
		37604007,
		13,
		Lang.get(101307),
		37604,
		7,
		1118,
		{
			RTResTalkAction[219]
		},
		[27] = 3
	},
	[37604008] = {
		37604008,
		13,
		Lang.get(101308),
		37604,
		8,
		1118,
		{
			RTResTalkAction[218]
		},
		[27] = 3
	},
	[37604009] = {
		37604009,
		0,
		"！",
		37604,
		9,
		1250,
		{
			RTResTalkAction[176],
			RTResTalkAction[199]
		}
	},
	[37604010] = {
		37604010,
		0,
		Lang.get(101309),
		37604,
		10,
		1247,
		{
			RTResTalkAction[68],
			RTResTalkAction[169]
		},
		nil,
		nil,
		nil,
		2747
	},
	[37604011] = {
		37604011,
		0,
		Lang.get(101310),
		37604,
		11,
		1245,
		{
			RTResTalkAction[188],
			RTResTalkAction[67],
			RTResTalkAction[150]
		},
		nil,
		nil,
		nil,
		nil,
		113
	},
	[37604012] = {
		37604012,
		0,
		Lang.get(101311),
		37604,
		12,
		1240,
		{
			RTResTalkAction[213],
			RTResTalkAction[220]
		}
	},
	[37604013] = {
		37604013,
		0,
		Lang.get(101312),
		37604,
		13,
		1250,
		{
			RTResTalkAction[149],
			RTResTalkAction[70],
			RTResTalkAction[14]
		}
	},
	[37604014] = {
		37604014,
		0,
		Lang.get(101313),
		37604,
		14,
		1250,
		{
			RTResTalkAction[149]
		}
	},
	[37604015] = {
		37604015,
		0,
		Lang.get(101314),
		37604,
		15,
		1245,
		{
			RTResTalkAction[221],
			RTResTalkAction[150]
		}
	},
	[37604016] = {
		37604016,
		0,
		Lang.get(101315),
		37604,
		16,
		1245,
		{
			RTResTalkAction[188]
		}
	},
	[37604017] = {
		37604017,
		0,
		Lang.get(101316),
		37604,
		17,
		1240,
		{
			RTResTalkAction[213],
			RTResTalkAction[222]
		}
	},
	[37604018] = {
		37604018,
		0,
		Lang.get(101317),
		37604,
		18,
		1240,
		{
			RTResTalkAction[213],
			RTResTalkAction[223]
		}
	},
	[37604019] = {
		37604019,
		13,
		Lang.get(101318),
		37604,
		19,
		1118,
		{
			RTResTalkAction[201],
			RTResTalkAction[70],
			RTResTalkAction[14]
		},
		[27] = 3
	},
	[37604020] = {
		37604020,
		0,
		"「LIFEISBEAUTIFUL」……",
		37604,
		20,
		1245,
		{
			RTResTalkAction[221],
			RTResTalkAction[199]
		}
	},
	[37604021] = {
		37604021,
		0,
		Lang.get(101319),
		37604,
		21,
		1245,
		{
			RTResTalkAction[188]
		}
	},
	[37604022] = {
		37604022,
		0,
		Lang.get(101320),
		37604,
		22,
		1245,
		{
			RTResTalkAction[224]
		}
	},
	[37518001] = {
		37518001,
		13,
		Lang.get(101321),
		37518,
		1,
		1118,
		{
			RTResTalkAction[201]
		},
		nil,
		nil,
		3,
		nil,
		114,
		37605,
		nil,
		nil,
		nil,
		nil,
		nil,
		37605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[37518002] = {
		37518002,
		0,
		Lang.get(101322),
		37518,
		2,
		1240,
		{
			RTResTalkAction[8],
			RTResTalkAction[199]
		}
	},
	[37518003] = {
		37518003,
		0,
		Lang.get(101323),
		37518,
		3,
		1245,
		{
			RTResTalkAction[225],
			RTResTalkAction[14]
		}
	},
	[37518004] = {
		37518004,
		0,
		"……",
		37518,
		4,
		1250,
		{
			RTResTalkAction[213],
			RTResTalkAction[144]
		}
	},
	[37518005] = {
		37518005,
		0,
		Lang.get(101324),
		37518,
		5,
		1250,
		{
			RTResTalkAction[213],
			RTResTalkAction[214]
		}
	},
	[37518006] = {
		37518006,
		0,
		Lang.get(21533),
		37518,
		6,
		1245,
		{
			RTResTalkAction[226],
			RTResTalkAction[144]
		}
	},
	[37518007] = {
		37518007,
		0,
		Lang.get(101325),
		37518,
		7,
		1250,
		{
			RTResTalkAction[213],
			RTResTalkAction[227]
		}
	},
	[37518008] = {
		37518008,
		0,
		Lang.get(101326),
		37518,
		8,
		1245,
		{
			RTResTalkAction[213],
			RTResTalkAction[144]
		}
	},
	[37518009] = {
		37518009,
		0,
		Lang.get(100966),
		37518,
		9,
		1250,
		{
			RTResTalkAction[213],
			RTResTalkAction[144]
		}
	},
	[37518010] = {
		37518010,
		5,
		Lang.get(101327),
		37518,
		10,
		1245,
		{
			RTResTalkAction[212],
			RTResTalkAction[150]
		}
	},
	[37518011] = {
		37518011,
		5,
		Lang.get(101328),
		37518,
		11,
		1240,
		{
			RTResTalkAction[45],
			RTResTalkAction[70]
		}
	},
	[37518012] = {
		37518012,
		9,
		"……",
		37518,
		12,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 175
	},
	[37518013] = {
		37518013,
		9,
		"……",
		37518,
		13,
		605,
		[22] = 1,
		[20] = 200
	},
	[37518014] = {
		37518014,
		9,
		"……",
		37518,
		14,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		154,
		[22] = 1,
		[20] = 255
	},
	[37518015] = {
		37518015,
		0,
		Lang.get(101329),
		37518,
		15,
		239,
		{
			RTResTalkAction[141]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37606,
		[19] = 37606,
		[20] = -1
	},
	[37518016] = {
		37518016,
		0,
		Lang.get(101330),
		37518,
		16,
		1250,
		{
			RTResTalkAction[228],
			RTResTalkAction[193]
		}
	},
	[37518017] = {
		37518017,
		2,
		Lang.get(101331),
		37518,
		17,
		1245,
		{
			RTResTalkAction[188],
			RTResTalkAction[150],
			RTResTalkAction[148]
		}
	},
	[37518018] = {
		37518018,
		0,
		Lang.get(101332),
		37518,
		18,
		239,
		{
			RTResTalkAction[229],
			RTResTalkAction[70]
		}
	},
	[37518019] = {
		37518019,
		0,
		Lang.get(101333),
		37518,
		19,
		1250,
		{
			RTResTalkAction[228],
			RTResTalkAction[193]
		}
	},
	[37518020] = {
		37518020,
		0,
		Lang.get(101334),
		37518,
		20,
		239,
		{
			RTResTalkAction[228],
			RTResTalkAction[197]
		}
	},
	[37518021] = {
		37518021,
		0,
		Lang.get(101335),
		37518,
		21,
		239,
		{
			RTResTalkAction[228],
			RTResTalkAction[193]
		}
	},
	[37518022] = {
		37518022,
		2,
		Lang.get(101336),
		37518,
		22,
		1245,
		{
			RTResTalkAction[230],
			RTResTalkAction[150],
			RTResTalkAction[148]
		}
	},
	[37518023] = {
		37518023,
		0,
		Lang.get(18698),
		37518,
		23,
		1250,
		{
			RTResTalkAction[179],
			RTResTalkAction[70]
		}
	},
	[37518024] = {
		37518024,
		0,
		Lang.get(101337),
		37518,
		24,
		239,
		{
			RTResTalkAction[142],
			RTResTalkAction[150]
		}
	},
	[37518025] = {
		37518025,
		0,
		Lang.get(101338),
		37518,
		25,
		239,
		{
			RTResTalkAction[142]
		}
	},
	[37518026] = {
		37518026,
		0,
		"……",
		37518,
		26,
		1250,
		{
			RTResTalkAction[228],
			RTResTalkAction[193]
		}
	},
	[37518027] = {
		37518027,
		0,
		Lang.get(101339),
		37518,
		27,
		239,
		{
			RTResTalkAction[231],
			RTResTalkAction[232]
		}
	},
	[37518028] = {
		37518028,
		2,
		Lang.get(101340),
		37518,
		28,
		1245,
		{
			RTResTalkAction[221],
			RTResTalkAction[150],
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
	[37518029] = {
		37518029,
		0,
		Lang.get(101341),
		37518,
		29,
		239,
		{
			RTResTalkAction[141],
			RTResTalkAction[70]
		}
	},
	[37518030] = {
		37518030,
		0,
		Lang.get(101342),
		37518,
		30,
		239,
		{
			RTResTalkAction[141]
		}
	},
	[37518031] = {
		37518031,
		0,
		Lang.get(101343),
		37518,
		31,
		239,
		{
			RTResTalkAction[233]
		}
	},
	[37518032] = {
		37518032,
		2,
		"……！",
		37518,
		32,
		1245,
		{
			RTResTalkAction[234],
			RTResTalkAction[148]
		}
	},
	[37518033] = {
		37518033,
		0,
		Lang.get(101344),
		37518,
		33,
		239,
		{
			RTResTalkAction[141],
			RTResTalkAction[70]
		}
	},
	[37518034] = {
		37518034,
		9,
		Lang.get(101345),
		37518,
		34,
		835,
		{
			RTResTalkAction[148]
		},
		nil,
		nil,
		nil,
		nil,
		59,
		[22] = 1
	},
	[37518035] = {
		37518035,
		9,
		Lang.get(101346),
		37518,
		35,
		835,
		[22] = 1
	},
	[37518036] = {
		37518036,
		9,
		Lang.get(101347),
		37518,
		36,
		836,
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
	[37518037] = {
		37518037,
		9,
		Lang.get(101348),
		37518,
		37,
		837,
		[22] = 1
	},
	[37518038] = {
		37518038,
		0,
		Lang.get(101349),
		37518,
		38,
		239,
		{
			RTResTalkAction[141]
		}
	},
	[37518039] = {
		37518039,
		2,
		Lang.get(101350),
		37518,
		39,
		1245,
		{
			RTResTalkAction[235],
			RTResTalkAction[148]
		}
	},
	[37518040] = {
		37518040,
		0,
		Lang.get(101351),
		37518,
		40,
		1250,
		{
			RTResTalkAction[176],
			RTResTalkAction[70]
		}
	},
	[37518041] = {
		37518041,
		0,
		Lang.get(101352),
		37518,
		41,
		239,
		{
			RTResTalkAction[141],
			RTResTalkAction[150]
		}
	},
	[37518042] = {
		37518042,
		0,
		Lang.get(101353),
		37518,
		42,
		239,
		{
			RTResTalkAction[142]
		}
	},
	[37518043] = {
		37518043,
		0,
		Lang.get(101354),
		37518,
		43,
		239,
		{
			RTResTalkAction[142]
		}
	},
	[37518044] = {
		37518044,
		0,
		Lang.get(101355),
		37518,
		44,
		239,
		{
			RTResTalkAction[205]
		}
	},
	[37518045] = {
		37518045,
		9,
		"……",
		37518,
		45,
		605,
		{
			RTResTalkAction[148]
		},
		[22] = 1,
		[20] = 150
	},
	[37518046] = {
		37518046,
		0,
		Lang.get(101356),
		37518,
		46,
		1245,
		{
			RTResTalkAction[221]
		},
		[20] = 255
	},
	[37518047] = {
		37518047,
		0,
		Lang.get(101357),
		37518,
		47,
		1245,
		{
			RTResTalkAction[225]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37519001] = {
		37519001,
		0,
		Lang.get(101358),
		37519,
		1,
		239,
		{
			RTResTalkAction[141]
		},
		nil,
		nil,
		3,
		nil,
		122,
		37610,
		nil,
		nil,
		nil,
		nil,
		nil,
		37610
	},
	[37519002] = {
		37519002,
		0,
		Lang.get(101359),
		37519,
		2,
		239,
		{
			RTResTalkAction[233]
		}
	},
	[37519003] = {
		37519003,
		0,
		Lang.get(101360),
		37519,
		3,
		1207,
		{
			RTResTalkAction[236],
			RTResTalkAction[148]
		}
	},
	[37519004] = {
		37519004,
		0,
		Lang.get(101361),
		37519,
		4,
		239,
		{
			RTResTalkAction[141],
			RTResTalkAction[202]
		}
	},
	[37519005] = {
		37519005,
		2,
		Lang.get(101362),
		37519,
		5,
		1118,
		{
			RTResTalkAction[237],
			RTResTalkAction[148]
		}
	},
	[37519006] = {
		37519006,
		5,
		Lang.get(101363),
		37519,
		6,
		1118,
		{
			RTResTalkAction[238]
		}
	},
	[37519007] = {
		37519007,
		9,
		Lang.get(101364),
		37519,
		7,
		1233,
		{
			RTResTalkAction[218]
		},
		[22] = 1
	},
	[37519008] = {
		37519008,
		3,
		Lang.get(101365),
		37519,
		8,
		605,
		{
			RTResTalkAction[199]
		},
		[22] = 1
	},
	[37519009] = {
		37519009,
		0,
		Lang.get(101366),
		37519,
		9,
		239,
		{
			RTResTalkAction[191]
		}
	},
	[37519010] = {
		37519010,
		0,
		Lang.get(101367),
		37519,
		10,
		1118,
		{
			RTResTalkAction[219],
			RTResTalkAction[148]
		}
	},
	[37519011] = {
		37519011,
		0,
		Lang.get(101368),
		37519,
		11,
		1207,
		{
			RTResTalkAction[239],
			RTResTalkAction[199]
		}
	},
	[37519012] = {
		37519012,
		0,
		Lang.get(101369),
		37519,
		12,
		239,
		{
			RTResTalkAction[141],
			RTResTalkAction[202]
		}
	},
	[37519013] = {
		37519013,
		0,
		Lang.get(101370),
		37519,
		13,
		239,
		{
			RTResTalkAction[229]
		}
	},
	[37519014] = {
		37519014,
		0,
		Lang.get(101371),
		37519,
		14,
		1118,
		{
			RTResTalkAction[240],
			RTResTalkAction[148]
		}
	},
	[37519015] = {
		37519015,
		9,
		Lang.get(101372),
		37519,
		15,
		605,
		{
			RTResTalkAction[199]
		},
		nil,
		nil,
		nil,
		nil,
		114,
		nil,
		nil,
		1,
		[22] = 1,
		[20] = 255
	},
	[37519016] = {
		37519016,
		0,
		Lang.get(101373),
		37519,
		16,
		1247,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37611,
		[19] = 37611,
		[20] = -1
	},
	[37519017] = {
		37519017,
		0,
		Lang.get(101374),
		37519,
		17,
		1240,
		{
			RTResTalkAction[137],
			RTResTalkAction[241]
		}
	},
	[37519018] = {
		37519018,
		0,
		Lang.get(101375),
		37519,
		18,
		1247,
		{
			RTResTalkAction[4],
			RTResTalkAction[241]
		}
	},
	[37519019] = {
		37519019,
		0,
		Lang.get(101376),
		37519,
		19,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[241]
		}
	},
	[37519020] = {
		37519020,
		0,
		Lang.get(101377),
		37519,
		20,
		1240,
		{
			RTResTalkAction[11],
			RTResTalkAction[241]
		}
	},
	[37519021] = {
		37519021,
		0,
		Lang.get(101378),
		37519,
		21,
		1245,
		{
			RTResTalkAction[242],
			RTResTalkAction[14],
			RTResTalkAction[67]
		}
	},
	[37519022] = {
		37519022,
		0,
		Lang.get(101379),
		37519,
		22,
		1247,
		{
			RTResTalkAction[183],
			RTResTalkAction[70]
		}
	},
	[37519023] = {
		37519023,
		5,
		Lang.get(101380),
		37519,
		23,
		1240,
		{
			RTResTalkAction[45],
			RTResTalkAction[67]
		}
	},
	[37519024] = {
		37519024,
		0,
		Lang.get(101381),
		37519,
		24,
		1245,
		{
			RTResTalkAction[224],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[37519025] = {
		37519025,
		5,
		Lang.get(101382),
		37519,
		25,
		1247,
		{
			RTResTalkAction[243],
			RTResTalkAction[70]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37519026] = {
		37519026,
		5,
		Lang.get(101383),
		37519,
		26,
		1240,
		{
			RTResTalkAction[45],
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37519027] = {
		37519027,
		0,
		Lang.get(101384),
		37519,
		27,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[244]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[37519028] = {
		37519028,
		0,
		Lang.get(101385),
		37519,
		28,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37519029] = {
		37519029,
		0,
		Lang.get(101386),
		37519,
		29,
		1240,
		{
			RTResTalkAction[24],
			RTResTalkAction[60]
		}
	},
	[37519030] = {
		37519030,
		0,
		Lang.get(101387),
		37519,
		30,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37519031] = {
		37519031,
		0,
		Lang.get(101388),
		37519,
		31,
		1247,
		{
			RTResTalkAction[151],
			RTResTalkAction[60],
			RTResTalkAction[14]
		}
	},
	[37519032] = {
		37519032,
		0,
		Lang.get(101389),
		37519,
		32,
		1245,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[37519033] = {
		37519033,
		0,
		Lang.get(101390),
		37519,
		33,
		1240,
		{
			RTResTalkAction[245],
			RTResTalkAction[60]
		}
	},
	[37519034] = {
		37519034,
		0,
		Lang.get(101391),
		37519,
		34,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[246]
		}
	},
	[37519035] = {
		37519035,
		0,
		Lang.get(101392),
		37519,
		35,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37519036] = {
		37519036,
		0,
		Lang.get(101393),
		37519,
		36,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[60]
		}
	},
	[37519037] = {
		37519037,
		0,
		Lang.get(101394),
		37519,
		37,
		1245,
		{
			RTResTalkAction[4],
			RTResTalkAction[153]
		}
	},
	[37519038] = {
		37519038,
		0,
		Lang.get(101395),
		37519,
		38,
		1240,
		{
			RTResTalkAction[247],
			RTResTalkAction[60]
		}
	},
	[37520001] = {
		37520001,
		0,
		Lang.get(101396),
		37520,
		1,
		1246,
		nil,
		1,
		0,
		nil,
		nil,
		194,
		37615,
		nil,
		1,
		nil,
		nil,
		nil,
		37615,
		255
	},
	[37520002] = {
		37520002,
		0,
		Lang.get(101397),
		37520,
		2,
		1253,
		nil,
		1,
		0
	},
	[37520003] = {
		37520003,
		0,
		Lang.get(101398),
		37520,
		3,
		1246,
		nil,
		1,
		0
	},
	[37520004] = {
		37520004,
		0,
		Lang.get(101399),
		37520,
		4,
		1253,
		nil,
		1,
		0
	},
	[37520005] = {
		37520005,
		0,
		Lang.get(101400),
		37520,
		5,
		1253,
		nil,
		1,
		0
	},
	[37520006] = {
		37520006,
		0,
		Lang.get(101401),
		37520,
		6,
		1246,
		nil,
		1,
		0
	},
	[37520007] = {
		37520007,
		0,
		Lang.get(101402),
		37520,
		7,
		1253,
		nil,
		1,
		0
	},
	[37520008] = {
		37520008,
		0,
		Lang.get(101403),
		37520,
		8,
		1253,
		nil,
		1,
		0
	},
	[37520009] = {
		37520009,
		0,
		Lang.get(101404),
		37520,
		9,
		1246,
		nil,
		1,
		0
	},
	[37520010] = {
		37520010,
		0,
		Lang.get(101405),
		37520,
		10,
		1253,
		nil,
		1,
		0
	},
	[37520011] = {
		37520011,
		0,
		Lang.get(101406),
		37520,
		11,
		1246,
		nil,
		1,
		0
	},
	[37520012] = {
		37520012,
		9,
		Lang.get(101407),
		37520,
		12,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		203,
		[22] = 1
	},
	[37520013] = {
		37520013,
		0,
		Lang.get(101408),
		37520,
		13,
		1246,
		nil,
		1,
		0,
		[20] = -1
	},
	[37520014] = {
		37520014,
		0,
		Lang.get(101409),
		37520,
		14,
		1246,
		nil,
		1,
		0
	},
	[37520015] = {
		37520015,
		0,
		Lang.get(101410),
		37520,
		15,
		1246,
		nil,
		1,
		0
	},
	[37520016] = {
		37520016,
		0,
		Lang.get(101411),
		37520,
		16,
		1237,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37520017] = {
		37520017,
		0,
		Lang.get(101412),
		37520,
		17,
		1213,
		nil,
		1,
		1
	},
	[37520018] = {
		37520018,
		0,
		Lang.get(101413),
		37520,
		18,
		1246,
		nil,
		1,
		0
	},
	[37520019] = {
		37520019,
		0,
		Lang.get(101414),
		37520,
		19,
		1246,
		nil,
		1,
		0
	},
	[37520020] = {
		37520020,
		0,
		Lang.get(101415),
		37520,
		20,
		1246,
		nil,
		1,
		0
	},
	[37520021] = {
		37520021,
		0,
		Lang.get(101416),
		37520,
		21,
		1245,
		nil,
		1,
		1
	},
	[37520022] = {
		37520022,
		0,
		Lang.get(101417),
		37520,
		22,
		1246,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37520023] = {
		37520023,
		0,
		Lang.get(101418),
		37520,
		23,
		1246,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37520024] = {
		37520024,
		0,
		Lang.get(101419),
		37520,
		24,
		1246,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37520025] = {
		37520025,
		0,
		Lang.get(101420),
		37520,
		25,
		1246,
		nil,
		1,
		1
	},
	[37520026] = {
		37520026,
		0,
		Lang.get(101421),
		37520,
		26,
		1246,
		nil,
		1,
		1
	},
	[37520027] = {
		37520027,
		0,
		Lang.get(101422),
		37520,
		27,
		1246,
		nil,
		1,
		1
	},
	[37520028] = {
		37520028,
		0,
		Lang.get(101423),
		37520,
		28,
		1056,
		nil,
		1,
		0
	},
	[37520029] = {
		37520029,
		0,
		Lang.get(101424),
		37520,
		29,
		1058,
		nil,
		1,
		0
	},
	[37520030] = {
		37520030,
		0,
		Lang.get(101425),
		37520,
		30,
		1246,
		nil,
		1,
		0
	},
	[37520031] = {
		37520031,
		0,
		Lang.get(101426),
		37520,
		31,
		1246,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[37520032] = {
		37520032,
		0,
		Lang.get(101427),
		37520,
		32,
		1253,
		nil,
		1,
		0
	},
	[37520033] = {
		37520033,
		9,
		Lang.get(101428),
		37520,
		33,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		1,
		nil,
		nil,
		255,
		nil,
		1
	},
	[37520034] = {
		37520034,
		0,
		Lang.get(101429),
		37520,
		34,
		1047,
		{
			RTResTalkAction[248]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		37616,
		1,
		1,
		nil,
		nil,
		nil,
		37616,
		-1
	},
	[37520035] = {
		37520035,
		0,
		Lang.get(101430),
		37520,
		35,
		1240,
		{
			RTResTalkAction[17],
			RTResTalkAction[36]
		}
	},
	[37520036] = {
		37520036,
		0,
		Lang.get(101431),
		37520,
		36,
		1238,
		{
			RTResTalkAction[4],
			RTResTalkAction[249]
		}
	},
	[37520037] = {
		37520037,
		3,
		Lang.get(101432),
		37520,
		37,
		605,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		37617,
		1,
		1,
		nil,
		nil,
		nil,
		37617,
		nil,
		nil,
		1
	},
	[37530001] = {
		37530001,
		3,
		"……",
		37530,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		37620,
		[19] = 37620,
		[22] = 1
	},
	[37530002] = {
		37530002,
		3,
		"2。",
		37530,
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		37621,
		[19] = 37621,
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
