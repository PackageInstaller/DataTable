-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tanxianjia\\ResTalk.lua

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
	[2] = 375
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 366
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 375
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 366
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[8] = {
	2,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 42,
	[3] = {
		1
	}
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 42
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 43
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 3
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 3
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		10012
	}
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[21] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[24] = {
	2,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[25] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[27] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[28] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[29] = {
	1,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[30] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[31] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 42
}
RTResTalkAction[33] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 370
}
RTResTalkAction[35] = {
	1,
	107,
	{
		2,
		10021
	},
	nil,
	8
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 370
}
RTResTalkAction[37] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		1,
		1003
	}
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[41] = {
	1,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[42] = {
	3,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[43] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[44] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[46] = {
	2,
	107,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[47] = {
	2,
	107,
	{
		10021
	},
	nil,
	7
}
RTResTalkAction[48] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[49] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[50] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[51] = {
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[52] = {
	1,
	107,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[53] = {
	1,
	220,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[54] = {
	1,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[55] = {
	1,
	682,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[56] = {
	1,
	107,
	{
		3
	},
	nil,
	8
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 682
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 683
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 684
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 683
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 684
}
RTResTalkAction[62] = {
	1,
	107,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[63] = {
	[1] = 3,
	[2] = 302
}
RTResTalkAction[64] = {
	2,
	107,
	{
		10011
	},
	nil,
	4
}
RTResTalkAction[65] = {
	[1] = 0,
	[2] = 302
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 302
}
RTResTalkAction[67] = {
	2,
	107,
	{
		10021,
		2
	},
	nil,
	7
}
RTResTalkAction[68] = {
	1,
	302,
	nil,
	nil,
	0
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		10031
	}
}
RTResTalkAction[71] = {
	3,
	220,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 682
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2,
		10021
	}
}
RTResTalkAction[74] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 682,
	[3] = {
		1
	}
}
RTResTalkAction[76] = {
	[1] = 5,
	[2] = 220
}
RTResTalkAction[77] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[78] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[79] = {
	1,
	220,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[80] = {
	1,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[81] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 359
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 359
}
RTResTalkAction[84] = {
	1,
	222,
	nil,
	nil,
	1
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 222
}
RTResTalkAction[86] = {
	3,
	222,
	nil,
	nil,
	0
}
RTResTalkAction[87] = {
	2,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[88] = {
	[1] = 3,
	[2] = 222
}
RTResTalkAction[89] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 222
}
RTResTalkAction[91] = {
	1,
	220,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[92] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[93] = {
	3,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[94] = {
	1,
	107,
	{
		10021
	},
	nil,
	7
}
RTResTalkAction[95] = {
	1,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 371
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 371
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		1
	}
}
RTResTalkAction[99] = {
	3,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[100] = {
	[1] = 1,
	[2] = 302,
	[3] = {
		2
	}
}
RTResTalkAction[101] = {
	1,
	107,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[102] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[103] = {
	3,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[104] = {
	2,
	107,
	{
		1,
		10031
	},
	nil,
	5
}
RTResTalkAction[105] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[106] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[107] = {
	3,
	215,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[110] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[111] = {
	3,
	220,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[112] = {
	1,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[113] = {
	1,
	215,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[114] = {
	1,
	107,
	{
		10021
	},
	nil,
	5
}
RTResTalkAction[115] = {
	1,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[116] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[117] = {
	3,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[118] = {
	1,
	107,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[119] = {
	[1] = 2,
	[2] = 220,
	[3] = {
		1
	}
}
RTResTalkAction[120] = {
	3,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[121] = {
	3,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[122] = {
	2,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[123] = {
	[1] = 3,
	[2] = 215,
	[3] = {
		1
	}
}
RTResTalkAction[124] = {
	2,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[125] = {
	2,
	220,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[126] = {
	2,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[127] = {
	3,
	215,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[128] = {
	1,
	220,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[129] = {
	1,
	220,
	{
		1,
		1002
	},
	nil,
	3
}
RTResTalkAction[130] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[131] = {
	[1] = 1,
	[2] = 302,
	[3] = {
		1
	}
}
RTResTalkAction[132] = {
	3,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[133] = {
	[1] = 3,
	[2] = 302,
	[3] = {
		2
	}
}
RTResTalkAction[134] = {
	1,
	220,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[135] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[136] = {
	[1] = 3,
	[2] = 689
}
RTResTalkAction[137] = {
	[1] = 1,
	[2] = 689
}
RTResTalkAction[138] = {
	[1] = 0,
	[2] = 689
}
RTResTalkAction[139] = {
	[1] = 3,
	[2] = 690
}
RTResTalkAction[140] = {
	[1] = 0,
	[2] = 690
}
RTResTalkAction[141] = {
	[1] = 3,
	[2] = 691
}
RTResTalkAction[142] = {
	[1] = 2,
	[2] = 220,
	[3] = {
		2
	}
}
RTResTalkAction[143] = {
	[1] = 0,
	[2] = 691
}
RTResTalkAction[144] = {
	[1] = 1,
	[2] = 690
}
RTResTalkAction[145] = {
	[1] = 3,
	[2] = 691,
	[3] = {
		3
	}
}
RTResTalkAction[146] = {
	[1] = 1,
	[2] = 688
}
RTResTalkAction[147] = {
	[1] = 0,
	[2] = 688
}
RTResTalkAction[148] = {
	[1] = 3,
	[2] = 688
}
RTResTalkAction[149] = {
	2,
	220,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[150] = {
	[1] = 1,
	[2] = 367,
	[3] = {
		1
	}
}
RTResTalkAction[151] = {
	[1] = 2,
	[2] = 367
}
RTResTalkAction[152] = {
	3,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[153] = {
	[1] = 2,
	[2] = 367,
	[3] = {
		1
	}
}
RTResTalkAction[154] = {
	3,
	220,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[155] = {
	[1] = 0,
	[2] = 367
}
RTResTalkAction[156] = {
	[1] = 1,
	[2] = 367
}
RTResTalkAction[157] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		2
	}
}
RTResTalkAction[158] = {
	[1] = 1,
	[2] = 367,
	[3] = {
		2
	}
}
RTResTalkAction[159] = {
	[1] = 1,
	[2] = 373
}
RTResTalkAction[160] = {
	[1] = 2,
	[2] = 373
}
RTResTalkAction[161] = {
	[1] = 3,
	[2] = 374
}
RTResTalkAction[162] = {
	[1] = 1,
	[2] = 374
}
RTResTalkAction[163] = {
	[1] = 0,
	[2] = 373
}
RTResTalkAction[164] = {
	[1] = 0,
	[2] = 374
}
RTResTalkAction[165] = {
	[1] = 1,
	[2] = 357
}
RTResTalkAction[166] = {
	[1] = 2,
	[2] = 357
}
RTResTalkAction[167] = {
	[1] = 3,
	[2] = 358
}
RTResTalkAction[168] = {
	[1] = 0,
	[2] = 357
}
RTResTalkAction[169] = {
	[1] = 0,
	[2] = 358
}
RTResTalkAction[170] = {
	[1] = 1,
	[2] = 59
}
RTResTalkAction[171] = {
	[1] = 0,
	[2] = 59
}
RTResTalkAction[172] = {
	[1] = 1,
	[2] = 60
}
RTResTalkAction[173] = {
	[1] = 0,
	[2] = 60
}
RTResTalkAction[174] = {
	[1] = 1,
	[2] = 60,
	[3] = {
		1
	}
}
RTResTalkAction[175] = {
	[1] = 2,
	[2] = 60
}
RTResTalkAction[176] = {
	[1] = 3,
	[2] = 685
}
RTResTalkAction[177] = {
	[1] = 2,
	[2] = 60,
	[3] = {
		2
	}
}
RTResTalkAction[178] = {
	[1] = 2,
	[2] = 60,
	[3] = {
		3
	}
}
RTResTalkAction[179] = {
	[1] = 1,
	[2] = 685
}
RTResTalkAction[180] = {
	[1] = 2,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[181] = {
	1,
	107,
	{
		10021
	},
	nil,
	10
}
RTResTalkAction[182] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[183] = {
	[1] = 0,
	[2] = 300
}

local Data = {
	[20000001] = {
		20000001,
		9,
		Lang.get(39403),
		20000,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		20000,
		0.5,
		1,
		nil,
		1,
		nil,
		20000,
		nil,
		nil,
		1
	},
	[20000002] = {
		20000002,
		0,
		Lang.get(39404),
		20000,
		2,
		686,
		nil,
		1
	},
	[20000003] = {
		20000003,
		0,
		Lang.get(41370),
		20000,
		3,
		687,
		nil,
		1
	},
	[20000004] = {
		20000004,
		13,
		nil,
		20000,
		4,
		687,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		1225,
		[27] = 2,
		[20] = 220
	},
	[20000005] = {
		20000005,
		13,
		Lang.get(39407),
		20000,
		5,
		366,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		[27] = 3
	},
	[20000006] = {
		20000006,
		0,
		Lang.get(39408),
		20000,
		6,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = 3
	},
	[20000007] = {
		20000007,
		13,
		Lang.get(39409),
		20000,
		7,
		366,
		{
			RTResTalkAction[2]
		},
		[27] = 3
	},
	[20000008] = {
		20000008,
		4,
		nil,
		20000,
		8,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = 3,
		[29] = {
			{
				id = 20000009,
				branch_content = Lang.get(42563)
			},
			{
				id = 20000009,
				branch_content = Lang.get(42564)
			}
		}
	},
	[20000009] = {
		20000009,
		13,
		Lang.get(39411),
		20000,
		9,
		366,
		{
			RTResTalkAction[2]
		},
		[27] = 3
	},
	[20000010] = {
		20000010,
		0,
		Lang.get(39412),
		20000,
		10,
		107,
		{
			RTResTalkAction[2]
		},
		1,
		8,
		[27] = 3
	},
	[20000011] = {
		20000011,
		0,
		Lang.get(39413),
		20000,
		11,
		300,
		{
			RTResTalkAction[2]
		},
		[27] = 3
	},
	[20000012] = {
		20000012,
		9,
		Lang.get(39414),
		20000,
		12,
		605,
		{
			RTResTalkAction[4]
		},
		[22] = 1,
		[20] = -1
	},
	[20000013] = {
		20000013,
		0,
		Lang.get(39415),
		20000,
		13,
		300
	},
	[20000014] = {
		20000014,
		0,
		Lang.get(39416),
		20000,
		14,
		300
	},
	[20000015] = {
		20000015,
		0,
		Lang.get(39417),
		20000,
		15,
		685,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20001,
		0.5,
		1,
		nil,
		1,
		nil,
		20001
	},
	[20000016] = {
		20000016,
		2,
		Lang.get(41371),
		20000,
		16,
		300
	},
	[20000017] = {
		20000017,
		0,
		Lang.get(39419),
		20000,
		17,
		300
	},
	[20001001] = {
		20001001,
		0,
		Lang.get(39420),
		20001,
		1,
		685,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		20002,
		0.5,
		1,
		nil,
		1,
		nil,
		20002
	},
	[20001002] = {
		20001002,
		0,
		Lang.get(39421),
		20001,
		2,
		685,
		nil,
		1,
		0
	},
	[20001003] = {
		20001003,
		0,
		Lang.get(39422),
		20001,
		3,
		685,
		nil,
		1,
		0
	},
	[20001004] = {
		20001004,
		2,
		Lang.get(41372),
		20001,
		4,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		20003,
		0.5,
		1,
		nil,
		1,
		nil,
		20003
	},
	[20001005] = {
		20001005,
		0,
		Lang.get(39424),
		20001,
		5,
		685,
		nil,
		1,
		0
	},
	[20001006] = {
		20001006,
		0,
		Lang.get(41373),
		20001,
		6,
		685,
		nil,
		1,
		0
	},
	[20001007] = {
		20001007,
		0,
		Lang.get(41374),
		20001,
		7,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20004,
		nil,
		1,
		nil,
		nil,
		nil,
		20004
	},
	[20001008] = {
		20001008,
		0,
		Lang.get(41375),
		20001,
		8,
		300
	},
	[20001009] = {
		20001009,
		0,
		Lang.get(39426),
		20001,
		9,
		300
	},
	[20001010] = {
		20001010,
		0,
		Lang.get(41376),
		20001,
		10,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[20001011] = {
		20001011,
		0,
		Lang.get(41377),
		20001,
		11,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[20001012] = {
		20001012,
		0,
		Lang.get(41378),
		20001,
		12,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20001013] = {
		20001013,
		0,
		Lang.get(41379),
		20001,
		13,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20001014] = {
		20001014,
		0,
		Lang.get(41380),
		20001,
		14,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20001015] = {
		20001015,
		0,
		Lang.get(41381),
		20001,
		15,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[20002001] = {
		20002001,
		0,
		Lang.get(41382),
		20002,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		20005,
		0.5,
		1,
		nil,
		1,
		nil,
		20005
	},
	[20002002] = {
		20002002,
		0,
		Lang.get(41383),
		20002,
		2,
		107,
		nil,
		1,
		0
	},
	[20002003] = {
		20002003,
		0,
		Lang.get(39427),
		20002,
		3,
		107,
		nil,
		1,
		8
	},
	[20002004] = {
		20002004,
		0,
		Lang.get(39428),
		20002,
		4,
		134,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20160,
		nil,
		nil,
		nil,
		nil,
		nil,
		20160
	},
	[20002005] = {
		20002005,
		0,
		Lang.get(39429),
		20002,
		5,
		42,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[20002006] = {
		20002006,
		0,
		Lang.get(39430),
		20002,
		6,
		43,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[20002007] = {
		20002007,
		0,
		Lang.get(39433),
		20002,
		7,
		134,
		{
			RTResTalkAction[12],
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[20002008] = {
		20002008,
		0,
		Lang.get(39434),
		20002,
		8,
		3,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		1070
	},
	[20002009] = {
		20002009,
		0,
		Lang.get(39435),
		20002,
		9,
		133,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[20002010] = {
		20002010,
		0,
		"……",
		20002,
		10,
		141,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[20002011] = {
		20002011,
		0,
		Lang.get(41384),
		20002,
		11,
		133,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[20002012] = {
		20002012,
		0,
		Lang.get(41385),
		20002,
		12,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[20]
		}
	},
	[20002013] = {
		20002013,
		0,
		Lang.get(41386),
		20002,
		13,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[7]
		}
	},
	[20002014] = {
		20002014,
		0,
		Lang.get(41387),
		20002,
		14,
		141,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[20002015] = {
		20002015,
		0,
		Lang.get(41388),
		20002,
		15,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[22]
		}
	},
	[20002016] = {
		20002016,
		0,
		Lang.get(39438),
		20002,
		16,
		107,
		{
			RTResTalkAction[26]
		},
		1,
		8,
		nil,
		nil,
		nil,
		20006,
		0.5,
		1,
		nil,
		1,
		nil,
		20006
	},
	[20002017] = {
		20002017,
		0,
		Lang.get(39439),
		20002,
		17,
		141,
		nil,
		1,
		0
	},
	[20002018] = {
		20002018,
		0,
		Lang.get(39440),
		20002,
		18,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		20007,
		0.5,
		1,
		nil,
		1,
		nil,
		20007
	},
	[20002019] = {
		20002019,
		0,
		Lang.get(39441),
		20002,
		19,
		42,
		nil,
		1,
		0
	},
	[20002020] = {
		20002020,
		0,
		Lang.get(39442),
		20002,
		20,
		134,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[20002021] = {
		20002021,
		0,
		Lang.get(39443),
		20002,
		21,
		42,
		{
			RTResTalkAction[10],
			RTResTalkAction[11],
			RTResTalkAction[16]
		}
	},
	[20002022] = {
		20002022,
		0,
		Lang.get(39444),
		20002,
		22,
		43,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[20002023] = {
		20002023,
		0,
		Lang.get(41389),
		20002,
		23,
		133,
		{
			RTResTalkAction[17],
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[20002024] = {
		20002024,
		0,
		Lang.get(39446),
		20002,
		24,
		107,
		{
			RTResTalkAction[20]
		},
		1,
		3,
		nil,
		nil,
		nil,
		20008,
		nil,
		1,
		nil,
		1,
		nil,
		20008
	},
	[20002025] = {
		20002025,
		0,
		Lang.get(39447),
		20002,
		25,
		133,
		nil,
		1,
		0
	},
	[20002026] = {
		20002026,
		0,
		Lang.get(39448),
		20002,
		26,
		42,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[20002027] = {
		20002027,
		0,
		Lang.get(39449),
		20002,
		27,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[13]
		}
	},
	[20002028] = {
		20002028,
		0,
		Lang.get(41390),
		20002,
		28,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20002029] = {
		20002029,
		0,
		Lang.get(41391),
		20002,
		29,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[22]
		}
	},
	[20002030] = {
		20002030,
		0,
		Lang.get(41392),
		20002,
		30,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[26]
		}
	},
	[20002031] = {
		20002031,
		0,
		Lang.get(39450),
		20002,
		31,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[20]
		}
	},
	[20002032] = {
		20002032,
		0,
		Lang.get(39451),
		20002,
		32,
		42,
		{
			RTResTalkAction[32],
			RTResTalkAction[16]
		}
	},
	[20002033] = {
		20002033,
		0,
		Lang.get(39452),
		20002,
		33,
		134,
		{
			RTResTalkAction[33],
			RTResTalkAction[13]
		}
	},
	[20003001] = {
		20003001,
		0,
		Lang.get(39453),
		20003,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		21,
		nil,
		0.5,
		1,
		nil,
		1,
		nil,
		20009
	},
	[20003002] = {
		20003002,
		0,
		Lang.get(39454),
		20003,
		2,
		300
	},
	[20003003] = {
		20003003,
		0,
		Lang.get(39455),
		20003,
		3,
		300
	},
	[20003004] = {
		20003004,
		0,
		Lang.get(39456),
		20003,
		4,
		300
	},
	[20003005] = {
		20003005,
		0,
		Lang.get(39457),
		20003,
		5,
		300
	},
	[20003006] = {
		20003006,
		0,
		Lang.get(39458),
		20003,
		6,
		133,
		nil,
		1,
		0
	},
	[20003007] = {
		20003007,
		0,
		Lang.get(39459),
		20003,
		7,
		107,
		nil,
		1,
		5
	},
	[20003008] = {
		20003008,
		4,
		nil,
		20003,
		8,
		107,
		nil,
		1,
		5,
		[29] = {
			{
				id = 20003009,
				branch_content = Lang.get(42565)
			}
		}
	},
	[20003009] = {
		20003009,
		0,
		Lang.get(39461),
		20003,
		9,
		107,
		nil,
		1,
		1
	},
	[20003010] = {
		20003010,
		0,
		Lang.get(39462),
		20003,
		10,
		141,
		nil,
		1,
		0
	},
	[20003011] = {
		20003011,
		0,
		Lang.get(39463),
		20003,
		11,
		134,
		nil,
		1,
		1
	},
	[20003012] = {
		20003012,
		0,
		Lang.get(39464),
		20003,
		12,
		107,
		nil,
		1,
		3
	},
	[20003013] = {
		20003013,
		0,
		Lang.get(39465),
		20003,
		13,
		133,
		nil,
		1,
		0
	},
	[20003014] = {
		20003014,
		0,
		Lang.get(39466),
		20003,
		14,
		107,
		nil,
		1,
		6
	},
	[20003015] = {
		20003015,
		0,
		Lang.get(39467),
		20003,
		15,
		141,
		nil,
		1,
		0
	},
	[20003016] = {
		20003016,
		0,
		Lang.get(39468),
		20003,
		16,
		107,
		nil,
		1,
		5
	},
	[20003017] = {
		20003017,
		0,
		Lang.get(39469),
		20003,
		17,
		42,
		nil,
		1,
		0
	},
	[20003018] = {
		20003018,
		0,
		Lang.get(39470),
		20003,
		18,
		134,
		nil,
		1,
		1
	},
	[20003019] = {
		20003019,
		0,
		Lang.get(39471),
		20003,
		19,
		133,
		nil,
		1,
		0
	},
	[20003020] = {
		20003020,
		0,
		Lang.get(39472),
		20003,
		20,
		107,
		nil,
		1,
		6
	},
	[20003021] = {
		20003021,
		4,
		nil,
		20003,
		21,
		107,
		nil,
		1,
		6,
		[29] = {
			{
				id = 20003022,
				branch_content = Lang.get(42566)
			}
		}
	},
	[20003022] = {
		20003022,
		0,
		Lang.get(39474),
		20003,
		22,
		300,
		nil,
		1,
		0
	},
	[20003023] = {
		20003023,
		0,
		Lang.get(39475),
		20003,
		23,
		300,
		nil,
		1,
		0
	},
	[20003024] = {
		20003024,
		0,
		Lang.get(39476),
		20003,
		24,
		107,
		nil,
		1,
		5
	},
	[20003025] = {
		20003025,
		4,
		nil,
		20003,
		25,
		107,
		nil,
		1,
		5,
		[29] = {
			{
				id = 20003026,
				branch_content = Lang.get(42567)
			}
		}
	},
	[20003026] = {
		20003026,
		0,
		Lang.get(41393),
		20003,
		26,
		221,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20010,
		0.5,
		1,
		nil,
		1,
		nil,
		20010
	},
	[20003027] = {
		20003027,
		0,
		Lang.get(41394),
		20003,
		27,
		221,
		nil,
		1,
		0
	},
	[20004001] = {
		20004001,
		0,
		Lang.get(39480),
		20004,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		20011,
		0.5,
		nil,
		nil,
		nil,
		nil,
		20011
	},
	[20004002] = {
		20004002,
		0,
		Lang.get(39481),
		20004,
		2,
		134,
		nil,
		1,
		3
	},
	[20004003] = {
		20004003,
		0,
		Lang.get(41395),
		20004,
		3,
		133,
		{
			RTResTalkAction[34]
		},
		1,
		0,
		3,
		nil,
		nil,
		20012,
		0.5,
		nil,
		nil,
		1,
		nil,
		20012,
		nil,
		370
	},
	[20004004] = {
		20004004,
		0,
		Lang.get(41396),
		20004,
		4,
		141,
		{
			RTResTalkAction[34]
		},
		1,
		0,
		[21] = 370
	},
	[20004005] = {
		20004005,
		0,
		Lang.get(41397),
		20004,
		5,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[36]
		}
	},
	[20004006] = {
		20004006,
		0,
		Lang.get(41398),
		20004,
		6,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20004007] = {
		20004007,
		9,
		Lang.get(41399),
		20004,
		7,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[20004008] = {
		20004008,
		0,
		Lang.get(41400),
		20004,
		8,
		107,
		nil,
		1,
		0
	},
	[20004009] = {
		20004009,
		0,
		Lang.get(41401),
		20004,
		9,
		107,
		nil,
		1,
		0
	},
	[20004010] = {
		20004010,
		0,
		Lang.get(39484),
		20004,
		10,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20013,
		0.5,
		1,
		nil,
		1,
		nil,
		20013
	},
	[20004011] = {
		20004011,
		0,
		Lang.get(39485),
		20004,
		11,
		107,
		nil,
		1,
		6
	},
	[20004012] = {
		20004012,
		0,
		Lang.get(39486),
		20004,
		12,
		133,
		nil,
		1,
		1
	},
	[20004013] = {
		20004013,
		0,
		Lang.get(39487),
		20004,
		13,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		nil,
		20014,
		nil,
		1,
		nil,
		nil,
		nil,
		20014
	},
	[20004014] = {
		20004014,
		0,
		Lang.get(39488),
		20004,
		14,
		107,
		nil,
		1,
		0
	},
	[20004015] = {
		20004015,
		3,
		Lang.get(23517),
		20004,
		15,
		605,
		[22] = 1
	},
	[20004016] = {
		20004016,
		0,
		Lang.get(39489),
		20004,
		16,
		221,
		nil,
		1,
		0,
		[19] = 20015
	},
	[20004017] = {
		20004017,
		0,
		Lang.get(39490),
		20004,
		17,
		107,
		nil,
		1,
		3
	},
	[20004018] = {
		20004018,
		0,
		Lang.get(39491),
		20004,
		18,
		133,
		nil,
		1,
		1
	},
	[20004019] = {
		20004019,
		0,
		Lang.get(39492),
		20004,
		19,
		134,
		nil,
		1,
		3
	},
	[20004020] = {
		20004020,
		0,
		Lang.get(39493),
		20004,
		20,
		221,
		nil,
		1,
		0
	},
	[20004021] = {
		20004021,
		0,
		Lang.get(39494),
		20004,
		21,
		107,
		nil,
		1,
		7
	},
	[20004022] = {
		20004022,
		0,
		Lang.get(39495),
		20004,
		22,
		221,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20016,
		nil,
		1,
		nil,
		1,
		nil,
		20016
	},
	[20004023] = {
		20004023,
		0,
		Lang.get(39496),
		20004,
		23,
		42,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20140,
		nil,
		nil,
		nil,
		nil,
		nil,
		20140
	},
	[20004024] = {
		20004024,
		0,
		Lang.get(39497),
		20004,
		24,
		134,
		nil,
		1,
		2
	},
	[20004025] = {
		20004025,
		0,
		Lang.get(39498),
		20004,
		25,
		133,
		nil,
		1,
		1
	},
	[20004026] = {
		20004026,
		0,
		Lang.get(39499),
		20004,
		26,
		107,
		nil,
		1,
		8
	},
	[20004027] = {
		20004027,
		0,
		Lang.get(39500),
		20004,
		27,
		221,
		nil,
		1,
		0
	},
	[20004028] = {
		20004028,
		0,
		Lang.get(39501),
		20004,
		28,
		133,
		nil,
		1,
		0
	},
	[20004029] = {
		20004029,
		0,
		Lang.get(39502),
		20004,
		29,
		42,
		nil,
		1,
		0
	},
	[20004030] = {
		20004030,
		0,
		Lang.get(39503),
		20004,
		30,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20150
	},
	[20005001] = {
		20005001,
		0,
		Lang.get(39504),
		20005,
		1,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		20017,
		0.8,
		1,
		nil,
		1,
		nil,
		20017
	},
	[20005002] = {
		20005002,
		0,
		Lang.get(39505),
		20005,
		2,
		221,
		nil,
		1,
		0
	},
	[20005003] = {
		20005003,
		0,
		Lang.get(39506),
		20005,
		3,
		42,
		nil,
		1,
		0
	},
	[20005004] = {
		20005004,
		3,
		Lang.get(39507),
		20005,
		4,
		605,
		[22] = 1
	},
	[20005005] = {
		20005005,
		0,
		Lang.get(39508),
		20005,
		5,
		134,
		nil,
		1,
		0
	},
	[20005006] = {
		20005006,
		0,
		Lang.get(39509),
		20005,
		6,
		221,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20151
	},
	[20005007] = {
		20005007,
		0,
		Lang.get(39510),
		20005,
		7,
		107,
		nil,
		1,
		1
	},
	[20005008] = {
		20005008,
		0,
		Lang.get(41402),
		20005,
		8,
		133,
		nil,
		1,
		0
	},
	[20005009] = {
		20005009,
		0,
		Lang.get(39512),
		20005,
		9,
		107,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[20005010] = {
		20005010,
		0,
		Lang.get(40550),
		20005,
		10,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		135
	},
	[20005011] = {
		20005011,
		7,
		"55",
		20005,
		11,
		220,
		{
			RTResTalkAction[38]
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
	[20005012] = {
		20005012,
		0,
		Lang.get(41403),
		20005,
		12,
		300,
		nil,
		nil,
		nil,
		3
	},
	[20005013] = {
		20005013,
		0,
		Lang.get(39515),
		20005,
		13,
		220,
		{
			RTResTalkAction[39]
		}
	},
	[20005014] = {
		20005014,
		4,
		nil,
		20005,
		14,
		220,
		{
			RTResTalkAction[40]
		},
		[29] = {
			{
				id = 20005015,
				branch_content = Lang.get(42568)
			}
		}
	},
	[20005015] = {
		20005015,
		0,
		Lang.get(40552),
		20005,
		15,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20005016] = {
		20005016,
		0,
		Lang.get(39518),
		20005,
		16,
		300,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20018,
		nil,
		1,
		[19] = 20018,
		[17] = 1
	},
	[20005017] = {
		20005017,
		0,
		Lang.get(39519),
		20005,
		17,
		220,
		nil,
		1,
		1
	},
	[20005018] = {
		20005018,
		0,
		Lang.get(39520),
		20005,
		18,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		20100,
		nil,
		nil,
		nil,
		nil,
		nil,
		20100
	},
	[20005019] = {
		20005019,
		0,
		Lang.get(39521),
		20005,
		19,
		220,
		nil,
		1,
		3
	},
	[20005020] = {
		20005020,
		0,
		Lang.get(39522),
		20005,
		20,
		107,
		nil,
		1,
		5
	},
	[20005021] = {
		20005021,
		0,
		Lang.get(39523),
		20005,
		21,
		220,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		20019,
		nil,
		nil,
		nil,
		nil,
		nil,
		20019
	},
	[20005022] = {
		20005022,
		0,
		Lang.get(39524),
		20005,
		22,
		133,
		nil,
		1,
		1
	},
	[20005023] = {
		20005023,
		0,
		Lang.get(39525),
		20005,
		23,
		107,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[20005024] = {
		20005024,
		0,
		Lang.get(39526),
		20005,
		24,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[42]
		}
	},
	[20005025] = {
		20005025,
		0,
		Lang.get(39527),
		20005,
		25,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[20005026] = {
		20005026,
		0,
		Lang.get(39528),
		20005,
		26,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[26]
		}
	},
	[20006001] = {
		20006001,
		0,
		Lang.get(41405),
		20006,
		1,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		14,
		20020,
		nil,
		1,
		nil,
		nil,
		nil,
		20020
	},
	[20006002] = {
		20006002,
		0,
		Lang.get(41406),
		20006,
		2,
		107,
		nil,
		1,
		5
	},
	[20006003] = {
		20006003,
		0,
		Lang.get(41407),
		20006,
		3,
		141,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[20006004] = {
		20006004,
		0,
		Lang.get(41408),
		20006,
		4,
		141,
		{
			RTResTalkAction[23]
		}
	},
	[20006005] = {
		20006005,
		0,
		Lang.get(41409),
		20006,
		5,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[7]
		}
	},
	[20006006] = {
		20006006,
		0,
		Lang.get(39534),
		20006,
		6,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[7]
		}
	},
	[20006007] = {
		20006007,
		0,
		Lang.get(41410),
		20006,
		7,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[20006008] = {
		20006008,
		0,
		Lang.get(41411),
		20006,
		8,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20006009] = {
		20006009,
		0,
		Lang.get(41412),
		20006,
		9,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20006010] = {
		20006010,
		0,
		Lang.get(41413),
		20006,
		10,
		220,
		{
			RTResTalkAction[37]
		}
	},
	[20006011] = {
		20006011,
		0,
		Lang.get(41414),
		20006,
		11,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[38]
		}
	},
	[20006012] = {
		20006012,
		0,
		Lang.get(41415),
		20006,
		12,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[44]
		}
	},
	[20006013] = {
		20006013,
		0,
		Lang.get(41416),
		20006,
		13,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[44]
		}
	},
	[20006014] = {
		20006014,
		0,
		Lang.get(41417),
		20006,
		14,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[20006015] = {
		20006015,
		0,
		Lang.get(41418),
		20006,
		15,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[20006016] = {
		20006016,
		0,
		Lang.get(41419),
		20006,
		16,
		141,
		{
			RTResTalkAction[49],
			RTResTalkAction[7]
		}
	},
	[20006017] = {
		20006017,
		0,
		Lang.get(39553),
		20006,
		17,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[20006018] = {
		20006018,
		0,
		Lang.get(39554),
		20006,
		18,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20006019] = {
		20006019,
		0,
		Lang.get(41420),
		20006,
		19,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[38]
		}
	},
	[20006020] = {
		20006020,
		0,
		Lang.get(41421),
		20006,
		20,
		107,
		{
			RTResTalkAction[50]
		}
	},
	[20006021] = {
		20006021,
		0,
		Lang.get(41422),
		20006,
		21,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[20006022] = {
		20006022,
		9,
		Lang.get(39559),
		20006,
		22,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		20021,
		0.5,
		1,
		nil,
		1,
		nil,
		20021,
		nil,
		nil,
		1
	},
	[20006023] = {
		20006023,
		0,
		Lang.get(41423),
		20006,
		23,
		107,
		nil,
		1,
		5
	},
	[20006024] = {
		20006024,
		0,
		Lang.get(41424),
		20006,
		24,
		141,
		nil,
		1,
		0
	},
	[20007001] = {
		20007001,
		0,
		Lang.get(41425),
		20007,
		1,
		220,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		20022,
		0.8,
		1,
		nil,
		1,
		nil,
		20022
	},
	[20007002] = {
		20007002,
		0,
		Lang.get(41426),
		20007,
		2,
		107,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[20007003] = {
		20007003,
		0,
		Lang.get(41427),
		20007,
		3,
		221,
		{
			RTResTalkAction[26]
		}
	},
	[20007004] = {
		20007004,
		0,
		Lang.get(41428),
		20007,
		4,
		221
	},
	[20007005] = {
		20007005,
		0,
		Lang.get(41429),
		20007,
		5,
		107,
		{
			RTResTalkAction[52]
		}
	},
	[20007006] = {
		20007006,
		0,
		Lang.get(41430),
		20007,
		6,
		220,
		{
			RTResTalkAction[53],
			RTResTalkAction[26]
		}
	},
	[20007007] = {
		20007007,
		0,
		Lang.get(41431),
		20007,
		7,
		107,
		{
			RTResTalkAction[54],
			RTResTalkAction[38]
		}
	},
	[20008001] = {
		20008001,
		0,
		Lang.get(41432),
		20008,
		1,
		682,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		20023,
		0.8,
		1,
		nil,
		1,
		nil,
		20023
	},
	[20008002] = {
		20008002,
		0,
		Lang.get(39583),
		20008,
		2,
		683,
		nil,
		1,
		0
	},
	[20008003] = {
		20008003,
		0,
		Lang.get(41433),
		20008,
		3,
		684,
		nil,
		1
	},
	[20008004] = {
		20008004,
		3,
		Lang.get(39586),
		20008,
		4,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		20101,
		0.8,
		nil,
		nil,
		1,
		nil,
		20101,
		nil,
		nil,
		1
	},
	[20008005] = {
		20008005,
		0,
		Lang.get(41434),
		20008,
		5,
		107,
		nil,
		1,
		5
	},
	[20008006] = {
		20008006,
		0,
		Lang.get(39588),
		20008,
		6,
		682,
		nil,
		1,
		0
	},
	[20008007] = {
		20008007,
		0,
		Lang.get(41435),
		20008,
		7,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[20008008] = {
		20008008,
		0,
		Lang.get(41436),
		20008,
		8,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[26]
		}
	},
	[20008009] = {
		20008009,
		0,
		Lang.get(41437),
		20008,
		9,
		682,
		{
			RTResTalkAction[55],
			RTResTalkAction[38]
		}
	},
	[20008010] = {
		20008010,
		0,
		Lang.get(41438),
		20008,
		10,
		107,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[20008011] = {
		20008011,
		0,
		Lang.get(41439),
		20008,
		11,
		683,
		{
			RTResTalkAction[58],
			RTResTalkAction[26]
		}
	},
	[20008012] = {
		20008012,
		0,
		Lang.get(39600),
		20008,
		12,
		683,
		{
			RTResTalkAction[58]
		}
	},
	[20008013] = {
		20008013,
		0,
		Lang.get(39601),
		20008,
		13,
		684,
		{
			RTResTalkAction[59],
			RTResTalkAction[60]
		}
	},
	[20008014] = {
		20008014,
		0,
		Lang.get(39602),
		20008,
		14,
		684,
		{
			RTResTalkAction[59]
		}
	},
	[20008015] = {
		20008015,
		0,
		Lang.get(39603),
		20008,
		15,
		220,
		{
			RTResTalkAction[61]
		},
		1,
		1,
		nil,
		nil,
		nil,
		20110,
		0.8,
		1,
		nil,
		1,
		nil,
		20110
	},
	[20008016] = {
		20008016,
		0,
		Lang.get(39604),
		20008,
		16,
		302,
		nil,
		1,
		0
	},
	[20008017] = {
		20008017,
		0,
		Lang.get(39605),
		20008,
		17,
		107,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[20008018] = {
		20008018,
		0,
		Lang.get(41440),
		20008,
		18,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008019] = {
		20008019,
		0,
		Lang.get(41441),
		20008,
		19,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[63]
		}
	},
	[20008020] = {
		20008020,
		0,
		Lang.get(41442),
		20008,
		20,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008021] = {
		20008021,
		0,
		Lang.get(41443),
		20008,
		21,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[63]
		}
	},
	[20008022] = {
		20008022,
		0,
		Lang.get(41444),
		20008,
		22,
		302,
		{
			RTResTalkAction[26],
			RTResTalkAction[65]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20111,
		0.8,
		1,
		nil,
		1,
		nil,
		20111
	},
	[20008023] = {
		20008023,
		0,
		Lang.get(39612),
		20008,
		23,
		302,
		nil,
		1
	},
	[20008024] = {
		20008024,
		0,
		Lang.get(41445),
		20008,
		24,
		220,
		nil,
		1
	},
	[20008025] = {
		20008025,
		0,
		Lang.get(41446),
		20008,
		25,
		220,
		nil,
		1
	},
	[20008026] = {
		20008026,
		0,
		Lang.get(41447),
		20008,
		26,
		220,
		nil,
		1
	},
	[20008027] = {
		20008027,
		0,
		Lang.get(41448),
		20008,
		27,
		107,
		nil,
		1
	},
	[20008028] = {
		20008028,
		0,
		Lang.get(41449),
		20008,
		28,
		220,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[20008029] = {
		20008029,
		0,
		Lang.get(41450),
		20008,
		29,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20008030] = {
		20008030,
		0,
		Lang.get(41451),
		20008,
		30,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[38]
		}
	},
	[20008031] = {
		20008031,
		0,
		Lang.get(41452),
		20008,
		31,
		302,
		{
			RTResTalkAction[66]
		}
	},
	[20008032] = {
		20008032,
		0,
		Lang.get(39624),
		20008,
		32,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[63]
		}
	},
	[20008033] = {
		20008033,
		0,
		Lang.get(41453),
		20008,
		33,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008034] = {
		20008034,
		0,
		Lang.get(41454),
		20008,
		34,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008035] = {
		20008035,
		0,
		Lang.get(41455),
		20008,
		35,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008036] = {
		20008036,
		0,
		Lang.get(41456),
		20008,
		36,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008037] = {
		20008037,
		0,
		Lang.get(41457),
		20008,
		37,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008038] = {
		20008038,
		0,
		Lang.get(41458),
		20008,
		38,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[63]
		}
	},
	[20008039] = {
		20008039,
		0,
		Lang.get(41459),
		20008,
		39,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20008040] = {
		20008040,
		0,
		Lang.get(41460),
		20008,
		40,
		302,
		{
			RTResTalkAction[68],
			RTResTalkAction[26]
		}
	},
	[20008041] = {
		20008041,
		0,
		Lang.get(39632),
		20008,
		41,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20008042] = {
		20008042,
		0,
		Lang.get(41461),
		20008,
		42,
		302,
		{
			RTResTalkAction[38],
			RTResTalkAction[65]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20024,
		0.5,
		1,
		nil,
		1,
		nil,
		20024
	},
	[20008043] = {
		20008043,
		0,
		Lang.get(41462),
		20008,
		43,
		220,
		nil,
		1,
		0
	},
	[20008044] = {
		20008044,
		0,
		Lang.get(41463),
		20008,
		44,
		107,
		nil,
		1,
		5
	},
	[20008045] = {
		20008045,
		0,
		Lang.get(41464),
		20008,
		45,
		302,
		nil,
		1,
		0
	},
	[20008046] = {
		20008046,
		0,
		Lang.get(41465),
		20008,
		46,
		220,
		nil,
		1,
		3
	},
	[20008047] = {
		20008047,
		0,
		Lang.get(41466),
		20008,
		47,
		302,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		20025,
		0.5,
		1,
		nil,
		nil,
		nil,
		20025
	},
	[20009001] = {
		20009001,
		0,
		Lang.get(41467),
		20009,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		20026,
		0.5,
		1,
		nil,
		1,
		nil,
		20026
	},
	[20009002] = {
		20009002,
		0,
		Lang.get(41468),
		20009,
		2,
		107,
		nil,
		1,
		3
	},
	[20009003] = {
		20009003,
		0,
		Lang.get(41469),
		20009,
		3,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		20027,
		nil,
		1,
		nil,
		1,
		nil,
		20027
	},
	[20009004] = {
		20009004,
		0,
		Lang.get(39646),
		20009,
		4,
		302,
		nil,
		1,
		0
	},
	[20009005] = {
		20009005,
		0,
		Lang.get(39647),
		20009,
		5,
		682,
		nil,
		1,
		0
	},
	[20009006] = {
		20009006,
		0,
		Lang.get(39648),
		20009,
		6,
		220,
		nil,
		1,
		0
	},
	[20009007] = {
		20009007,
		0,
		Lang.get(41470),
		20009,
		7,
		302,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[20009008] = {
		20009008,
		0,
		Lang.get(41471),
		20009,
		8,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[65]
		}
	},
	[20009009] = {
		20009009,
		0,
		Lang.get(41472),
		20009,
		9,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[71]
		}
	},
	[20009010] = {
		20009010,
		9,
		Lang.get(41473),
		20009,
		10,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20113,
		0.5,
		1,
		nil,
		1,
		nil,
		20113,
		nil,
		nil,
		1
	},
	[20009011] = {
		20009011,
		0,
		Lang.get(41474),
		20009,
		11,
		220,
		nil,
		1,
		0
	},
	[20009012] = {
		20009012,
		0,
		Lang.get(41475),
		20009,
		12,
		220,
		nil,
		1,
		0
	},
	[20009013] = {
		20009013,
		0,
		Lang.get(41476),
		20009,
		13,
		220,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		20028,
		nil,
		nil,
		nil,
		1,
		nil,
		20028
	},
	[20009014] = {
		20009014,
		0,
		Lang.get(41477),
		20009,
		14,
		220,
		nil,
		1,
		0,
		nil,
		nil,
		134,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		20029
	},
	[20009015] = {
		20009015,
		0,
		Lang.get(41478),
		20009,
		15,
		220,
		nil,
		1,
		3
	},
	[20009016] = {
		20009016,
		0,
		Lang.get(41479),
		20009,
		16,
		223,
		nil,
		1,
		1
	},
	[20009017] = {
		20009017,
		7,
		"58",
		20009,
		17,
		223,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[20009018] = {
		20009018,
		0,
		Lang.get(41480),
		20009,
		18,
		692,
		nil,
		1,
		nil,
		-1
	},
	[20009019] = {
		20009019,
		0,
		Lang.get(41481),
		20009,
		19,
		223,
		nil,
		1,
		0
	},
	[20009020] = {
		20009020,
		0,
		Lang.get(41482),
		20009,
		20,
		693,
		nil,
		1
	},
	[20009021] = {
		20009021,
		0,
		Lang.get(41483),
		20009,
		21,
		223,
		nil,
		1
	},
	[20009022] = {
		20009022,
		0,
		Lang.get(41484),
		20009,
		22,
		693,
		nil,
		1
	},
	[20009023] = {
		20009023,
		0,
		Lang.get(41485),
		20009,
		23,
		694,
		nil,
		1
	},
	[20009024] = {
		20009024,
		0,
		Lang.get(41486),
		20009,
		24,
		223,
		nil,
		1,
		1
	},
	[20009025] = {
		20009025,
		0,
		Lang.get(41487),
		20009,
		25,
		220,
		nil,
		1,
		3
	},
	[20009026] = {
		20009026,
		0,
		Lang.get(41488),
		20009,
		26,
		220,
		nil,
		1,
		0
	},
	[20009027] = {
		20009027,
		9,
		Lang.get(41489),
		20009,
		27,
		605,
		[22] = 1,
		[20] = 255
	},
	[20009028] = {
		20009028,
		0,
		Lang.get(41490),
		20009,
		28,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		20030,
		0.8,
		1,
		nil,
		1,
		nil,
		20030,
		-1
	},
	[20009029] = {
		20009029,
		0,
		Lang.get(41491),
		20009,
		29,
		220,
		nil,
		1,
		2
	},
	[20009030] = {
		20009030,
		0,
		Lang.get(41492),
		20009,
		30,
		220,
		nil,
		1,
		0
	},
	[20009031] = {
		20009031,
		9,
		Lang.get(41493),
		20009,
		31,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		20031,
		[19] = 20031,
		[22] = 1
	},
	[20009032] = {
		20009032,
		0,
		Lang.get(39671),
		20009,
		32,
		682,
		nil,
		1,
		0,
		nil,
		nil,
		62
	},
	[20009033] = {
		20009033,
		0,
		Lang.get(41494),
		20009,
		33,
		683,
		nil,
		1,
		0
	},
	[20009034] = {
		20009034,
		0,
		Lang.get(39673),
		20009,
		34,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20009035] = {
		20009035,
		0,
		Lang.get(41495),
		20009,
		35,
		682,
		{
			RTResTalkAction[72],
			RTResTalkAction[38]
		}
	},
	[20009036] = {
		20009036,
		0,
		Lang.get(41496),
		20009,
		36,
		107,
		{
			RTResTalkAction[73],
			RTResTalkAction[57]
		}
	},
	[20009037] = {
		20009037,
		0,
		Lang.get(41497),
		20009,
		37,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[44]
		}
	},
	[20009038] = {
		20009038,
		0,
		Lang.get(41498),
		20009,
		38,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[44]
		}
	},
	[20009039] = {
		20009039,
		0,
		Lang.get(39676),
		20009,
		39,
		682,
		{
			RTResTalkAction[74],
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[20010001] = {
		20010001,
		2,
		Lang.get(41499),
		20010,
		1,
		220,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		20032,
		0.8,
		1,
		nil,
		1,
		nil,
		20032
	},
	[20010002] = {
		20010002,
		0,
		Lang.get(41500),
		20010,
		2,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		20114,
		nil,
		nil,
		nil,
		nil,
		nil,
		20114
	},
	[20010003] = {
		20010003,
		0,
		Lang.get(41501),
		20010,
		3,
		220,
		nil,
		1,
		3
	},
	[20010004] = {
		20010004,
		0,
		Lang.get(41502),
		20010,
		4,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20010005] = {
		20010005,
		0,
		Lang.get(41503),
		20010,
		5,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[20010006] = {
		20010006,
		0,
		Lang.get(39683),
		20010,
		6,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[26]
		}
	},
	[20010007] = {
		20010007,
		0,
		Lang.get(41504),
		20010,
		7,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[65]
		}
	},
	[20010008] = {
		20010008,
		0,
		Lang.get(41505),
		20010,
		8,
		107,
		{
			RTResTalkAction[77],
			RTResTalkAction[38]
		}
	},
	[20010009] = {
		20010009,
		0,
		Lang.get(41506),
		20010,
		9,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[26]
		}
	},
	[20010010] = {
		20010010,
		0,
		Lang.get(39693),
		20010,
		10,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[65]
		}
	},
	[20010011] = {
		20010011,
		0,
		Lang.get(39694),
		20010,
		11,
		220,
		{
			RTResTalkAction[78]
		}
	},
	[20010012] = {
		20010012,
		0,
		Lang.get(39695),
		20010,
		12,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20010013] = {
		20010013,
		9,
		Lang.get(41507),
		20010,
		13,
		605,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20033,
		0.5,
		1,
		nil,
		1,
		nil,
		20033,
		nil,
		nil,
		1
	},
	[20010014] = {
		20010014,
		9,
		Lang.get(39697),
		20010,
		14,
		605,
		[22] = 1
	},
	[20010015] = {
		20010015,
		0,
		Lang.get(39699),
		20010,
		15,
		220,
		nil,
		1,
		0
	},
	[20010016] = {
		20010016,
		0,
		Lang.get(41508),
		20010,
		16,
		220,
		nil,
		1,
		1
	},
	[20010017] = {
		20010017,
		0,
		Lang.get(41509),
		20010,
		17,
		107,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[20010018] = {
		20010018,
		0,
		Lang.get(39703),
		20010,
		18,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[44]
		}
	},
	[20010019] = {
		20010019,
		0,
		Lang.get(41510),
		20010,
		19,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[44]
		}
	},
	[20010020] = {
		20010020,
		0,
		Lang.get(39706),
		20010,
		20,
		220,
		{
			RTResTalkAction[26],
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20034,
		0.5,
		1,
		nil,
		nil,
		nil,
		20034
	},
	[20010021] = {
		20010021,
		0,
		Lang.get(41511),
		20010,
		21,
		107,
		nil,
		1,
		5
	},
	[20010022] = {
		20010022,
		0,
		Lang.get(39708),
		20010,
		22,
		220,
		{
			RTResTalkAction[79]
		},
		nil,
		nil,
		3
	},
	[20010023] = {
		20010023,
		0,
		Lang.get(39709),
		20010,
		23,
		302,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20010024] = {
		20010024,
		0,
		Lang.get(39711),
		20010,
		24,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20010025] = {
		20010025,
		0,
		Lang.get(41512),
		20010,
		25,
		302,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20010026] = {
		20010026,
		0,
		Lang.get(41513),
		20010,
		26,
		302,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20010027] = {
		20010027,
		0,
		Lang.get(41514),
		20010,
		27,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20010028] = {
		20010028,
		2,
		Lang.get(41515),
		20010,
		28,
		220,
		{
			RTResTalkAction[80],
			RTResTalkAction[65]
		}
	},
	[20010029] = {
		20010029,
		0,
		Lang.get(39720),
		20010,
		29,
		107,
		{
			RTResTalkAction[38]
		},
		1,
		8,
		nil,
		nil,
		nil,
		20035,
		nil,
		1,
		nil,
		1,
		nil,
		20035
	},
	[20010030] = {
		20010030,
		0,
		Lang.get(41516),
		20010,
		30,
		220,
		nil,
		1,
		1
	},
	[20010031] = {
		20010031,
		2,
		Lang.get(41517),
		20010,
		31,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20010032] = {
		20010032,
		0,
		Lang.get(41518),
		20010,
		32,
		107,
		{
			RTResTalkAction[81],
			RTResTalkAction[38]
		}
	},
	[20011001] = {
		20011001,
		0,
		Lang.get(41519),
		20011,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		62,
		20036,
		0.5,
		1,
		nil,
		1,
		nil,
		20036
	},
	[20011002] = {
		20011002,
		0,
		Lang.get(41520),
		20011,
		2,
		141,
		nil,
		1,
		0
	},
	[20011003] = {
		20011003,
		0,
		Lang.get(41521),
		20011,
		3,
		220,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[20011004] = {
		20011004,
		0,
		Lang.get(39733),
		20011,
		4,
		359,
		{
			RTResTalkAction[82],
			RTResTalkAction[38]
		}
	},
	[20011005] = {
		20011005,
		0,
		Lang.get(41522),
		20011,
		5,
		107,
		{
			RTResTalkAction[51],
			RTResTalkAction[83]
		}
	},
	[20011006] = {
		20011006,
		0,
		Lang.get(41523),
		20011,
		6,
		141,
		{
			RTResTalkAction[26]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20037,
		0.8,
		1,
		nil,
		1,
		nil,
		20037
	},
	[20011007] = {
		20011007,
		0,
		Lang.get(41524),
		20011,
		7,
		141,
		nil,
		1,
		1
	},
	[20011008] = {
		20011008,
		0,
		Lang.get(41525),
		20011,
		8,
		222,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[20011009] = {
		20011009,
		0,
		Lang.get(41526),
		20011,
		9,
		107,
		{
			RTResTalkAction[48],
			RTResTalkAction[85]
		}
	},
	[20011010] = {
		20011010,
		0,
		Lang.get(41527),
		20011,
		10,
		222,
		{
			RTResTalkAction[6],
			RTResTalkAction[86]
		}
	},
	[20011011] = {
		20011011,
		7,
		"56",
		20011,
		11,
		222,
		{
			RTResTalkAction[26],
			RTResTalkAction[85]
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
	[20011012] = {
		20011012,
		0,
		Lang.get(41528),
		20011,
		12,
		107,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		},
		nil,
		nil,
		3
	},
	[20011013] = {
		20011013,
		0,
		Lang.get(41529),
		20011,
		13,
		222,
		{
			RTResTalkAction[6],
			RTResTalkAction[88]
		}
	},
	[20011014] = {
		20011014,
		0,
		Lang.get(41530),
		20011,
		14,
		107,
		{
			RTResTalkAction[89],
			RTResTalkAction[85]
		}
	},
	[20011015] = {
		20011015,
		0,
		Lang.get(41531),
		20011,
		15,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20011016] = {
		20011016,
		0,
		Lang.get(41532),
		20011,
		16,
		222,
		{
			RTResTalkAction[90],
			RTResTalkAction[38]
		}
	},
	[20011017] = {
		20011017,
		0,
		Lang.get(41533),
		20011,
		17,
		220,
		{
			RTResTalkAction[91],
			RTResTalkAction[85]
		}
	},
	[20011018] = {
		20011018,
		0,
		Lang.get(41534),
		20011,
		18,
		107,
		{
			RTResTalkAction[77],
			RTResTalkAction[38]
		}
	},
	[20011019] = {
		20011019,
		9,
		Lang.get(41535),
		20011,
		19,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20038,
		[19] = 20038,
		[22] = 1
	},
	[20011020] = {
		20011020,
		0,
		Lang.get(41536),
		20011,
		20,
		107,
		nil,
		1,
		8
	},
	[20011021] = {
		20011021,
		0,
		Lang.get(41537),
		20011,
		21,
		220,
		nil,
		1,
		3
	},
	[20011022] = {
		20011022,
		0,
		Lang.get(41538),
		20011,
		22,
		107,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[20011023] = {
		20011023,
		0,
		Lang.get(41539),
		20011,
		23,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[93]
		}
	},
	[20011024] = {
		20011024,
		0,
		Lang.get(41540),
		20011,
		24,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[42]
		}
	},
	[20011025] = {
		20011025,
		0,
		Lang.get(41541),
		20011,
		25,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[44]
		}
	},
	[20012001] = {
		20012001,
		0,
		Lang.get(41542),
		20012,
		1,
		220,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		20039,
		0.8,
		1,
		nil,
		1,
		nil,
		20039
	},
	[20012002] = {
		20012002,
		0,
		Lang.get(41543),
		20012,
		2,
		302,
		nil,
		1,
		0
	},
	[20012003] = {
		20012003,
		0,
		Lang.get(41544),
		20012,
		3,
		107,
		{
			RTResTalkAction[81]
		},
		nil,
		nil,
		3
	},
	[20012004] = {
		20012004,
		0,
		Lang.get(41545),
		20012,
		4,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20012005] = {
		20012005,
		0,
		Lang.get(39768),
		20012,
		5,
		107,
		{
			RTResTalkAction[94],
			RTResTalkAction[65]
		}
	},
	[20012006] = {
		20012006,
		0,
		Lang.get(39769),
		20012,
		6,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20012007] = {
		20012007,
		0,
		Lang.get(41546),
		20012,
		7,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63],
			RTResTalkAction[22]
		}
	},
	[20012008] = {
		20012008,
		0,
		Lang.get(41547),
		20012,
		8,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20012009] = {
		20012009,
		0,
		Lang.get(39772),
		20012,
		9,
		107,
		{
			RTResTalkAction[50],
			RTResTalkAction[65]
		}
	},
	[20012010] = {
		20012010,
		0,
		Lang.get(41548),
		20012,
		10,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20012011] = {
		20012011,
		0,
		Lang.get(41549),
		20012,
		11,
		107,
		{
			RTResTalkAction[95],
			RTResTalkAction[38]
		}
	},
	[20012012] = {
		20012012,
		0,
		Lang.get(39775),
		20012,
		12,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[26]
		}
	},
	[20012013] = {
		20012013,
		0,
		Lang.get(41550),
		20012,
		13,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[22]
		}
	},
	[20012014] = {
		20012014,
		0,
		Lang.get(41551),
		20012,
		14,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[65]
		}
	},
	[20012015] = {
		20012015,
		0,
		Lang.get(41552),
		20012,
		15,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[26]
		}
	},
	[20012016] = {
		20012016,
		0,
		Lang.get(41553),
		20012,
		16,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[22]
		}
	},
	[20012017] = {
		20012017,
		0,
		Lang.get(41554),
		20012,
		17,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[20012018] = {
		20012018,
		0,
		Lang.get(41555),
		20012,
		18,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[20012019] = {
		20012019,
		0,
		Lang.get(41556),
		20012,
		19,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20013001] = {
		20013001,
		0,
		Lang.get(41557),
		20013,
		1,
		222,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		20040,
		0.5,
		1,
		nil,
		1,
		nil,
		20040
	},
	[20013002] = {
		20013002,
		0,
		Lang.get(41558),
		20013,
		2,
		107,
		{
			RTResTalkAction[96]
		},
		1,
		5,
		3,
		nil,
		nil,
		20120,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		371
	},
	[20013003] = {
		20013003,
		0,
		Lang.get(41559),
		20013,
		3,
		222,
		{
			RTResTalkAction[97]
		},
		1,
		1,
		-1
	},
	[20013004] = {
		20013004,
		0,
		Lang.get(41560),
		20013,
		4,
		141,
		nil,
		1,
		0
	},
	[20013005] = {
		20013005,
		0,
		Lang.get(41561),
		20013,
		5,
		220,
		nil,
		1,
		3
	},
	[20013006] = {
		20013006,
		0,
		Lang.get(39787),
		20013,
		6,
		222,
		nil,
		1,
		0
	},
	[20013007] = {
		20013007,
		0,
		Lang.get(41562),
		20013,
		7,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		nil,
		20105,
		nil,
		nil,
		nil,
		1,
		nil,
		20105
	},
	[20013008] = {
		20013008,
		0,
		Lang.get(41563),
		20013,
		8,
		302,
		nil,
		1,
		0
	},
	[20013009] = {
		20013009,
		5,
		Lang.get(39790),
		20013,
		9,
		562
	},
	[20013010] = {
		20013010,
		0,
		Lang.get(41564),
		20013,
		10,
		220,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		3
	},
	[20013011] = {
		20013011,
		0,
		Lang.get(41565),
		20013,
		11,
		107,
		{
			RTResTalkAction[69],
			RTResTalkAction[99]
		}
	},
	[20013012] = {
		20013012,
		0,
		Lang.get(41566),
		20013,
		12,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[26]
		}
	},
	[20013013] = {
		20013013,
		0,
		Lang.get(39794),
		20013,
		13,
		220,
		{
			RTResTalkAction[38]
		},
		1,
		3,
		nil,
		nil,
		nil,
		20041,
		0.8,
		1,
		nil,
		1,
		nil,
		20041
	},
	[20013014] = {
		20013014,
		0,
		Lang.get(41567),
		20013,
		14,
		107,
		nil,
		1,
		1
	},
	[20013015] = {
		20013015,
		0,
		Lang.get(41568),
		20013,
		15,
		220,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[20013016] = {
		20013016,
		0,
		Lang.get(39797),
		20013,
		16,
		302,
		{
			RTResTalkAction[100],
			RTResTalkAction[38]
		}
	},
	[20013017] = {
		20013017,
		0,
		Lang.get(41569),
		20013,
		17,
		220,
		{
			RTResTalkAction[78],
			RTResTalkAction[65]
		}
	},
	[20013018] = {
		20013018,
		0,
		Lang.get(41570),
		20013,
		18,
		302,
		{
			RTResTalkAction[69],
			RTResTalkAction[63]
		}
	},
	[20013019] = {
		20013019,
		0,
		Lang.get(41571),
		20013,
		19,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[38],
			RTResTalkAction[65]
		}
	},
	[20013020] = {
		20013020,
		0,
		Lang.get(41572),
		20013,
		20,
		220,
		{
			RTResTalkAction[74],
			RTResTalkAction[40],
			RTResTalkAction[102]
		}
	},
	[20013021] = {
		20013021,
		3,
		Lang.get(39802),
		20013,
		21,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[38],
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20042,
		0.5,
		1,
		nil,
		1,
		nil,
		20042,
		nil,
		nil,
		1
	},
	[20013022] = {
		20013022,
		0,
		Lang.get(39803),
		20013,
		22,
		107,
		nil,
		1,
		7
	},
	[20013023] = {
		20013023,
		0,
		Lang.get(41573),
		20013,
		23,
		215,
		nil,
		1,
		1
	},
	[20013024] = {
		20013024,
		7,
		"57",
		20013,
		24,
		215,
		nil,
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[20013025] = {
		20013025,
		0,
		Lang.get(39805),
		20013,
		25,
		107,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[20013026] = {
		20013026,
		0,
		Lang.get(39806),
		20013,
		26,
		215,
		{
			RTResTalkAction[6],
			RTResTalkAction[103]
		}
	},
	[20013027] = {
		20013027,
		0,
		Lang.get(39807),
		20013,
		27,
		107,
		{
			RTResTalkAction[104],
			RTResTalkAction[105]
		}
	},
	[20013028] = {
		20013028,
		0,
		Lang.get(41574),
		20013,
		28,
		107,
		{
			RTResTalkAction[106],
			RTResTalkAction[105]
		}
	},
	[20013029] = {
		20013029,
		0,
		Lang.get(39809),
		20013,
		29,
		215,
		{
			RTResTalkAction[6],
			RTResTalkAction[105]
		}
	},
	[20013030] = {
		20013030,
		0,
		Lang.get(39810),
		20013,
		30,
		215,
		{
			RTResTalkAction[6],
			RTResTalkAction[107]
		}
	},
	[20013031] = {
		20013031,
		0,
		Lang.get(39811),
		20013,
		31,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[26],
			RTResTalkAction[108]
		}
	},
	[20013032] = {
		20013032,
		0,
		Lang.get(39812),
		20013,
		32,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[38]
		}
	},
	[20013033] = {
		20013033,
		0,
		Lang.get(39813),
		20013,
		33,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[108]
		}
	},
	[20013034] = {
		20013034,
		0,
		Lang.get(39814),
		20013,
		34,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20013035] = {
		20013035,
		0,
		Lang.get(41575),
		20013,
		35,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[38]
		}
	},
	[20014001] = {
		20014001,
		0,
		Lang.get(41576),
		20014,
		1,
		302,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		20043,
		0.8,
		1,
		nil,
		1,
		nil,
		20043
	},
	[20014002] = {
		20014002,
		0,
		Lang.get(41577),
		20014,
		2,
		215,
		nil,
		1
	},
	[20014003] = {
		20014003,
		0,
		Lang.get(41578),
		20014,
		3,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		20102,
		nil,
		nil,
		nil,
		1,
		nil,
		20102
	},
	[20014004] = {
		20014004,
		0,
		Lang.get(41579),
		20014,
		4,
		302,
		nil,
		1,
		0
	},
	[20014005] = {
		20014005,
		0,
		Lang.get(41580),
		20014,
		5,
		215,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[20014006] = {
		20014006,
		0,
		Lang.get(39824),
		20014,
		6,
		220,
		{
			RTResTalkAction[110],
			RTResTalkAction[44]
		}
	},
	[20014007] = {
		20014007,
		0,
		Lang.get(39825),
		20014,
		7,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[44]
		}
	},
	[20014008] = {
		20014008,
		0,
		Lang.get(39826),
		20014,
		8,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[108]
		}
	},
	[20014009] = {
		20014009,
		0,
		Lang.get(39827),
		20014,
		9,
		107,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[20014010] = {
		20014010,
		0,
		Lang.get(39828),
		20014,
		10,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20014011] = {
		20014011,
		0,
		Lang.get(39829),
		20014,
		11,
		220,
		{
			RTResTalkAction[98],
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[20014012] = {
		20014012,
		0,
		Lang.get(39830),
		20014,
		12,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[38]
		}
	},
	[20014013] = {
		20014013,
		0,
		Lang.get(54601),
		20014,
		13,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[111]
		}
	},
	[20014014] = {
		20014014,
		0,
		Lang.get(39831),
		20014,
		14,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[38]
		}
	},
	[20014015] = {
		20014015,
		0,
		Lang.get(39832),
		20014,
		15,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[26]
		}
	},
	[20014016] = {
		20014016,
		0,
		Lang.get(39833),
		20014,
		16,
		215,
		{
			RTResTalkAction[112],
			RTResTalkAction[65]
		}
	},
	[20014017] = {
		20014017,
		0,
		Lang.get(39834),
		20014,
		17,
		220,
		{
			RTResTalkAction[98],
			RTResTalkAction[108]
		}
	},
	[20014018] = {
		20014018,
		0,
		Lang.get(39835),
		20014,
		18,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[38]
		}
	},
	[20014019] = {
		20014019,
		0,
		Lang.get(41581),
		20014,
		19,
		215,
		{
			RTResTalkAction[113],
			RTResTalkAction[65]
		}
	},
	[20014020] = {
		20014020,
		0,
		Lang.get(41582),
		20014,
		20,
		107,
		{
			RTResTalkAction[114],
			RTResTalkAction[108]
		}
	},
	[20014021] = {
		20014021,
		0,
		Lang.get(41583),
		20014,
		21,
		302,
		{
			RTResTalkAction[6],
			RTResTalkAction[63]
		}
	},
	[20014022] = {
		20014022,
		0,
		Lang.get(41584),
		20014,
		22,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[26]
		}
	},
	[20014023] = {
		20014023,
		0,
		Lang.get(39840),
		20014,
		23,
		215,
		{
			RTResTalkAction[115],
			RTResTalkAction[65]
		}
	},
	[20014024] = {
		20014024,
		0,
		Lang.get(41585),
		20014,
		24,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014025] = {
		20014025,
		0,
		Lang.get(41586),
		20014,
		25,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014026] = {
		20014026,
		0,
		Lang.get(41587),
		20014,
		26,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014027] = {
		20014027,
		0,
		Lang.get(41588),
		20014,
		27,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014028] = {
		20014028,
		0,
		Lang.get(41589),
		20014,
		28,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014029] = {
		20014029,
		9,
		Lang.get(41590),
		20014,
		29,
		605,
		{
			RTResTalkAction[108],
			RTResTalkAction[65]
		},
		[22] = 1
	},
	[20014030] = {
		20014030,
		0,
		Lang.get(41591),
		20014,
		30,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014031] = {
		20014031,
		0,
		Lang.get(41592),
		20014,
		31,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20014032] = {
		20014032,
		0,
		Lang.get(54602),
		20014,
		32,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[65]
		}
	},
	[20014033] = {
		20014033,
		0,
		Lang.get(39841),
		20014,
		33,
		302,
		{
			RTResTalkAction[108]
		},
		1,
		0,
		nil,
		nil,
		62,
		20044,
		0.8,
		1,
		nil,
		1,
		nil,
		20044
	},
	[20014034] = {
		20014034,
		0,
		Lang.get(41593),
		20014,
		34,
		107,
		nil,
		1,
		3
	},
	[20014035] = {
		20014035,
		0,
		Lang.get(41594),
		20014,
		35,
		215,
		{
			RTResTalkAction[116]
		},
		nil,
		nil,
		3
	},
	[20014036] = {
		20014036,
		0,
		Lang.get(41595),
		20014,
		36,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[108]
		}
	},
	[20014037] = {
		20014037,
		0,
		Lang.get(39845),
		20014,
		37,
		215,
		{
			RTResTalkAction[113],
			RTResTalkAction[22]
		}
	},
	[20014038] = {
		20014038,
		0,
		Lang.get(39846),
		20014,
		38,
		107,
		{
			RTResTalkAction[5],
			RTResTalkAction[108]
		}
	},
	[20014039] = {
		20014039,
		0,
		Lang.get(39847),
		20014,
		39,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[26]
		}
	},
	[20014040] = {
		20014040,
		0,
		Lang.get(39848),
		20014,
		40,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20014041] = {
		20014041,
		0,
		Lang.get(39849),
		20014,
		41,
		107,
		{
			RTResTalkAction[92],
			RTResTalkAction[38]
		}
	},
	[20014042] = {
		20014042,
		0,
		Lang.get(39850),
		20014,
		42,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20014043] = {
		20014043,
		0,
		Lang.get(39851),
		20014,
		43,
		107,
		{
			RTResTalkAction[50],
			RTResTalkAction[38]
		}
	},
	[20014044] = {
		20014044,
		0,
		Lang.get(39852),
		20014,
		44,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[20014045] = {
		20014045,
		0,
		Lang.get(39853),
		20014,
		45,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[7]
		}
	},
	[20014046] = {
		20014046,
		0,
		Lang.get(39854),
		20014,
		46,
		141,
		{
			RTResTalkAction[6],
			RTResTalkAction[117]
		}
	},
	[20014047] = {
		20014047,
		0,
		Lang.get(41596),
		20014,
		47,
		107,
		{
			RTResTalkAction[118],
			RTResTalkAction[22]
		}
	},
	[20014048] = {
		20014048,
		0,
		Lang.get(41597),
		20014,
		48,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[20014049] = {
		20014049,
		0,
		Lang.get(41598),
		20014,
		49,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014050] = {
		20014050,
		0,
		Lang.get(39858),
		20014,
		50,
		220,
		{
			RTResTalkAction[119],
			RTResTalkAction[105]
		}
	},
	[20014051] = {
		20014051,
		0,
		Lang.get(39859),
		20014,
		51,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[120]
		}
	},
	[20014052] = {
		20014052,
		0,
		Lang.get(41599),
		20014,
		52,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[108]
		}
	},
	[20014053] = {
		20014053,
		0,
		Lang.get(39861),
		20014,
		53,
		220,
		{
			RTResTalkAction[37]
		}
	},
	[20014054] = {
		20014054,
		0,
		Lang.get(41600),
		20014,
		54,
		215,
		{
			RTResTalkAction[38]
		},
		1,
		1,
		nil,
		nil,
		40,
		20045,
		0.5,
		1,
		nil,
		1,
		nil,
		20045
	},
	[20014055] = {
		20014055,
		0,
		Lang.get(41601),
		20014,
		55,
		215,
		nil,
		1
	},
	[20014056] = {
		20014056,
		0,
		Lang.get(41602),
		20014,
		56,
		220,
		nil,
		1,
		1
	},
	[20014057] = {
		20014057,
		0,
		Lang.get(41603),
		20014,
		57,
		215,
		nil,
		1,
		3
	},
	[20014058] = {
		20014058,
		0,
		Lang.get(39869),
		20014,
		58,
		220,
		nil,
		1,
		0
	},
	[20014059] = {
		20014059,
		0,
		Lang.get(41604),
		20014,
		59,
		215,
		nil,
		1
	},
	[20014060] = {
		20014060,
		0,
		Lang.get(39871),
		20014,
		60,
		220,
		nil,
		1
	},
	[20014061] = {
		20014061,
		0,
		Lang.get(39872),
		20014,
		61,
		220,
		nil,
		1
	},
	[20014062] = {
		20014062,
		0,
		Lang.get(39873),
		20014,
		62,
		220,
		nil,
		1
	},
	[20014063] = {
		20014063,
		0,
		Lang.get(39874),
		20014,
		63,
		215,
		nil,
		1
	},
	[20014064] = {
		20014064,
		0,
		Lang.get(39875),
		20014,
		64,
		215,
		nil,
		1
	},
	[20014065] = {
		20014065,
		0,
		Lang.get(41605),
		20014,
		65,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		20046,
		[19] = 20046,
		[17] = 1
	},
	[20014066] = {
		20014066,
		0,
		Lang.get(39877),
		20014,
		66,
		220,
		nil,
		1
	},
	[20014067] = {
		20014067,
		0,
		Lang.get(39878),
		20014,
		67,
		215,
		nil,
		1,
		3
	},
	[20014068] = {
		20014068,
		0,
		Lang.get(39879),
		20014,
		68,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20014069] = {
		20014069,
		0,
		Lang.get(39880),
		20014,
		69,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[121]
		}
	},
	[20014070] = {
		20014070,
		0,
		Lang.get(39881),
		20014,
		70,
		220,
		{
			RTResTalkAction[122],
			RTResTalkAction[105]
		}
	},
	[20014071] = {
		20014071,
		0,
		Lang.get(41606),
		20014,
		71,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014072] = {
		20014072,
		0,
		Lang.get(39883),
		20014,
		72,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014073] = {
		20014073,
		0,
		Lang.get(39884),
		20014,
		73,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[123]
		}
	},
	[20014074] = {
		20014074,
		0,
		Lang.get(39885),
		20014,
		74,
		220,
		{
			RTResTalkAction[124],
			RTResTalkAction[105]
		}
	},
	[20014075] = {
		20014075,
		0,
		Lang.get(39886),
		20014,
		75,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014076] = {
		20014076,
		0,
		Lang.get(41607),
		20014,
		76,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014077] = {
		20014077,
		0,
		Lang.get(41608),
		20014,
		77,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20014078] = {
		20014078,
		0,
		Lang.get(39889),
		20014,
		78,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[103]
		}
	},
	[20014079] = {
		20014079,
		0,
		Lang.get(41609),
		20014,
		79,
		220,
		{
			RTResTalkAction[125],
			RTResTalkAction[105]
		}
	},
	[20014080] = {
		20014080,
		0,
		Lang.get(39891),
		20014,
		80,
		220,
		{
			RTResTalkAction[126],
			RTResTalkAction[105]
		}
	},
	[20014081] = {
		20014081,
		0,
		Lang.get(39892),
		20014,
		81,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[127]
		}
	},
	[20014082] = {
		20014082,
		0,
		Lang.get(41610),
		20014,
		82,
		220,
		{
			RTResTalkAction[124],
			RTResTalkAction[105]
		}
	},
	[20014083] = {
		20014083,
		0,
		Lang.get(41611),
		20014,
		83,
		220,
		{
			RTResTalkAction[128],
			RTResTalkAction[108]
		}
	},
	[20015001] = {
		20015001,
		0,
		Lang.get(39895),
		20015,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		134,
		nil,
		0.8,
		1,
		nil,
		1,
		nil,
		20047
	},
	[20015002] = {
		20015002,
		0,
		Lang.get(41612),
		20015,
		2,
		302,
		nil,
		1
	},
	[20015003] = {
		20015003,
		0,
		Lang.get(41613),
		20015,
		3,
		302,
		nil,
		1
	},
	[20015004] = {
		20015004,
		0,
		Lang.get(39898),
		20015,
		4,
		220,
		nil,
		1,
		3
	},
	[20015005] = {
		20015005,
		0,
		Lang.get(41614),
		20015,
		5,
		215,
		nil,
		1,
		0
	},
	[20015006] = {
		20015006,
		0,
		Lang.get(39900),
		20015,
		6,
		215,
		nil,
		1,
		3
	},
	[20016001] = {
		20016001,
		0,
		Lang.get(39901),
		20016,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		134,
		20048,
		0.8,
		1,
		nil,
		1,
		nil,
		20048
	},
	[20016002] = {
		20016002,
		0,
		Lang.get(39902),
		20016,
		2,
		215,
		nil,
		1
	},
	[20016003] = {
		20016003,
		0,
		Lang.get(39903),
		20016,
		3,
		220,
		{
			RTResTalkAction[129]
		},
		nil,
		nil,
		3
	},
	[20016004] = {
		20016004,
		0,
		Lang.get(39904),
		20016,
		4,
		215,
		{
			RTResTalkAction[122],
			RTResTalkAction[120]
		}
	},
	[20016005] = {
		20016005,
		0,
		Lang.get(39905),
		20016,
		5,
		215,
		{
			RTResTalkAction[130],
			RTResTalkAction[38]
		}
	},
	[20016006] = {
		20016006,
		0,
		Lang.get(39906),
		20016,
		6,
		215,
		{
			RTResTalkAction[108]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20049,
		0.8,
		1,
		nil,
		1,
		nil,
		20049
	},
	[20016007] = {
		20016007,
		0,
		Lang.get(39907),
		20016,
		7,
		302,
		nil,
		1
	},
	[20016008] = {
		20016008,
		0,
		Lang.get(41615),
		20016,
		8,
		215,
		{
			RTResTalkAction[109]
		},
		nil,
		nil,
		3
	},
	[20016009] = {
		20016009,
		0,
		Lang.get(39909),
		20016,
		9,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[108]
		}
	},
	[20016010] = {
		20016010,
		0,
		Lang.get(39910),
		20016,
		10,
		302,
		{
			RTResTalkAction[131],
			RTResTalkAction[38]
		}
	},
	[20016011] = {
		20016011,
		0,
		Lang.get(39911),
		20016,
		11,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[65]
		}
	},
	[20016012] = {
		20016012,
		0,
		Lang.get(39912),
		20016,
		12,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[132]
		}
	},
	[20016013] = {
		20016013,
		0,
		Lang.get(39913),
		20016,
		13,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20016014] = {
		20016014,
		0,
		Lang.get(39914),
		20016,
		14,
		220,
		{
			RTResTalkAction[124],
			RTResTalkAction[105]
		}
	},
	[20016015] = {
		20016015,
		0,
		Lang.get(39915),
		20016,
		15,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20016016] = {
		20016016,
		0,
		Lang.get(39916),
		20016,
		16,
		220,
		{
			RTResTalkAction[125],
			RTResTalkAction[105]
		}
	},
	[20016017] = {
		20016017,
		0,
		Lang.get(41616),
		20016,
		17,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[105]
		}
	},
	[20016018] = {
		20016018,
		0,
		Lang.get(39918),
		20016,
		18,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[38]
		}
	},
	[20016019] = {
		20016019,
		0,
		Lang.get(39919),
		20016,
		19,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20016020] = {
		20016020,
		0,
		Lang.get(39920),
		20016,
		20,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20016021] = {
		20016021,
		0,
		Lang.get(39921),
		20016,
		21,
		302,
		{
			RTResTalkAction[110],
			RTResTalkAction[133]
		}
	},
	[20016022] = {
		20016022,
		0,
		Lang.get(39922),
		20016,
		22,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[63]
		}
	},
	[20016023] = {
		20016023,
		0,
		Lang.get(39923),
		20016,
		23,
		302,
		{
			RTResTalkAction[66],
			RTResTalkAction[108]
		}
	},
	[20016024] = {
		20016024,
		0,
		Lang.get(39924),
		20016,
		24,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[65]
		}
	},
	[20016025] = {
		20016025,
		0,
		Lang.get(39925),
		20016,
		25,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[38]
		}
	},
	[20026001] = {
		20026001,
		0,
		Lang.get(41617),
		20026,
		1,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		62,
		20050,
		0.5,
		1,
		nil,
		1,
		nil,
		20050
	},
	[20026002] = {
		20026002,
		0,
		Lang.get(39927),
		20026,
		2,
		215,
		nil,
		1,
		0
	},
	[20026003] = {
		20026003,
		0,
		Lang.get(39928),
		20026,
		3,
		141,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[20026004] = {
		20026004,
		0,
		Lang.get(41618),
		20026,
		4,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[22]
		}
	},
	[20026005] = {
		20026005,
		0,
		Lang.get(39930),
		20026,
		5,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[38]
		}
	},
	[20026006] = {
		20026006,
		0,
		Lang.get(39931),
		20026,
		6,
		220,
		{
			RTResTalkAction[134],
			RTResTalkAction[108]
		}
	},
	[20026007] = {
		20026007,
		0,
		Lang.get(54603),
		20026,
		7,
		107,
		{
			RTResTalkAction[50],
			RTResTalkAction[38]
		}
	},
	[20026008] = {
		20026008,
		0,
		Lang.get(41619),
		20026,
		8,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[20026009] = {
		20026009,
		0,
		Lang.get(39933),
		20026,
		9,
		141,
		{
			RTResTalkAction[23],
			RTResTalkAction[26]
		}
	},
	[20026010] = {
		20026010,
		0,
		Lang.get(39934),
		20026,
		10,
		107,
		{
			RTResTalkAction[135],
			RTResTalkAction[22]
		}
	},
	[20026011] = {
		20026011,
		0,
		Lang.get(54604),
		20026,
		11,
		215,
		{
			RTResTalkAction[109],
			RTResTalkAction[26]
		}
	},
	[20017001] = {
		20017001,
		0,
		Lang.get(39935),
		20017,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		20051,
		0.5,
		1,
		nil,
		1,
		nil,
		20051
	},
	[20017002] = {
		20017002,
		0,
		Lang.get(39936),
		20017,
		2,
		220,
		nil,
		1
	},
	[20017003] = {
		20017003,
		0,
		Lang.get(39937),
		20017,
		3,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20017004] = {
		20017004,
		0,
		Lang.get(39938),
		20017,
		4,
		689,
		{
			RTResTalkAction[69],
			RTResTalkAction[136]
		}
	},
	[20017005] = {
		20017005,
		0,
		Lang.get(39939),
		20017,
		5,
		220,
		{
			RTResTalkAction[124],
			RTResTalkAction[136]
		}
	},
	[20017006] = {
		20017006,
		0,
		Lang.get(39940),
		20017,
		6,
		689,
		{
			RTResTalkAction[137],
			RTResTalkAction[38]
		}
	},
	[20017007] = {
		20017007,
		0,
		Lang.get(39941),
		20017,
		7,
		220,
		{
			RTResTalkAction[138]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		20052,
		0.5,
		1,
		nil,
		1,
		nil,
		20052
	},
	[20017008] = {
		20017008,
		0,
		Lang.get(39942),
		20017,
		8,
		220,
		nil,
		1,
		3
	},
	[20017009] = {
		20017009,
		0,
		Lang.get(39943),
		20017,
		9,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20017010] = {
		20017010,
		0,
		Lang.get(41620),
		20017,
		10,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20017011] = {
		20017011,
		0,
		Lang.get(39945),
		20017,
		11,
		220,
		{
			RTResTalkAction[37]
		}
	},
	[20017012] = {
		20017012,
		0,
		Lang.get(39946),
		20017,
		12,
		690,
		{
			RTResTalkAction[69],
			RTResTalkAction[139]
		}
	},
	[20017013] = {
		20017013,
		0,
		Lang.get(39947),
		20017,
		13,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[140]
		}
	},
	[20017014] = {
		20017014,
		0,
		Lang.get(39948),
		20017,
		14,
		691,
		{
			RTResTalkAction[69],
			RTResTalkAction[141]
		}
	},
	[20017015] = {
		20017015,
		0,
		Lang.get(23797),
		20017,
		15,
		220,
		{
			RTResTalkAction[142],
			RTResTalkAction[141]
		}
	},
	[20017016] = {
		20017016,
		0,
		Lang.get(41621),
		20017,
		16,
		691,
		{
			RTResTalkAction[69],
			RTResTalkAction[141]
		}
	},
	[20017017] = {
		20017017,
		0,
		Lang.get(39951),
		20017,
		17,
		691,
		{
			RTResTalkAction[69],
			RTResTalkAction[141]
		}
	},
	[20017018] = {
		20017018,
		0,
		Lang.get(54605),
		20017,
		18,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[143]
		}
	},
	[20017019] = {
		20017019,
		0,
		Lang.get(39952),
		20017,
		19,
		690,
		{
			RTResTalkAction[144],
			RTResTalkAction[38]
		}
	},
	[20017020] = {
		20017020,
		0,
		Lang.get(39953),
		20017,
		20,
		220,
		{
			RTResTalkAction[78],
			RTResTalkAction[140]
		}
	},
	[20017021] = {
		20017021,
		0,
		Lang.get(39954),
		20017,
		21,
		691,
		{
			RTResTalkAction[69],
			RTResTalkAction[141]
		}
	},
	[20017022] = {
		20017022,
		0,
		Lang.get(41622),
		20017,
		22,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[141]
		}
	},
	[20017023] = {
		20017023,
		0,
		Lang.get(41623),
		20017,
		23,
		691,
		{
			RTResTalkAction[69],
			RTResTalkAction[145]
		}
	},
	[20017024] = {
		20017024,
		0,
		Lang.get(39957),
		20017,
		24,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[143]
		}
	},
	[20017025] = {
		20017025,
		0,
		Lang.get(39958),
		20017,
		25,
		690,
		{
			RTResTalkAction[69],
			RTResTalkAction[139]
		}
	},
	[20017026] = {
		20017026,
		0,
		Lang.get(39959),
		20017,
		26,
		220,
		{
			RTResTalkAction[124],
			RTResTalkAction[139]
		}
	},
	[20017027] = {
		20017027,
		0,
		Lang.get(41624),
		20017,
		27,
		690,
		{
			RTResTalkAction[69],
			RTResTalkAction[139]
		}
	},
	[20017028] = {
		20017028,
		0,
		Lang.get(39961),
		20017,
		28,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[140]
		}
	},
	[20017029] = {
		20017029,
		0,
		Lang.get(39962),
		20017,
		29,
		688,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		nil,
		20053,
		0.5,
		1,
		nil,
		1,
		nil,
		20053
	},
	[20017030] = {
		20017030,
		0,
		Lang.get(39963),
		20017,
		30,
		220,
		nil,
		1,
		3
	},
	[20017031] = {
		20017031,
		0,
		Lang.get(39964),
		20017,
		31,
		688,
		{
			RTResTalkAction[146]
		},
		nil,
		nil,
		3
	},
	[20017032] = {
		20017032,
		0,
		Lang.get(39965),
		20017,
		32,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[147]
		}
	},
	[20017033] = {
		20017033,
		0,
		Lang.get(39966),
		20017,
		33,
		688,
		{
			RTResTalkAction[146],
			RTResTalkAction[38]
		}
	},
	[20017034] = {
		20017034,
		0,
		Lang.get(39967),
		20017,
		34,
		688,
		{
			RTResTalkAction[146]
		}
	},
	[20017035] = {
		20017035,
		0,
		Lang.get(39968),
		20017,
		35,
		688,
		{
			RTResTalkAction[146]
		}
	},
	[20018001] = {
		20018001,
		0,
		Lang.get(39969),
		20018,
		1,
		688,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		20054,
		0.8,
		1,
		nil,
		1,
		nil,
		20054
	},
	[20018002] = {
		20018002,
		0,
		Lang.get(39970),
		20018,
		2,
		688,
		nil,
		1
	},
	[20018003] = {
		20018003,
		0,
		Lang.get(39971),
		20018,
		3,
		220,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		20055,
		nil,
		nil,
		nil,
		nil,
		nil,
		20055
	},
	[20018004] = {
		20018004,
		0,
		Lang.get(39972),
		20018,
		4,
		688,
		nil,
		1,
		0
	},
	[20018005] = {
		20018005,
		0,
		Lang.get(39973),
		20018,
		5,
		220,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[20018006] = {
		20018006,
		0,
		Lang.get(39974),
		20018,
		6,
		688,
		{
			RTResTalkAction[69],
			RTResTalkAction[148]
		}
	},
	[20018007] = {
		20018007,
		0,
		Lang.get(39975),
		20018,
		7,
		220,
		{
			RTResTalkAction[149],
			RTResTalkAction[148]
		}
	},
	[20018008] = {
		20018008,
		0,
		Lang.get(39976),
		20018,
		8,
		688,
		{
			RTResTalkAction[146],
			RTResTalkAction[38]
		}
	},
	[20018009] = {
		20018009,
		0,
		Lang.get(39977),
		20018,
		9,
		688,
		{
			RTResTalkAction[146]
		}
	},
	[20019001] = {
		20019001,
		0,
		Lang.get(39978),
		20019,
		1,
		372,
		nil,
		1,
		nil,
		nil,
		nil,
		136,
		20056,
		0.5,
		1,
		nil,
		1,
		nil,
		20056
	},
	[20019002] = {
		20019002,
		0,
		Lang.get(41625),
		20019,
		2,
		220,
		nil,
		1,
		1
	},
	[20019003] = {
		20019003,
		0,
		Lang.get(39980),
		20019,
		3,
		367,
		{
			RTResTalkAction[150]
		},
		nil,
		nil,
		3
	},
	[20019004] = {
		20019004,
		0,
		Lang.get(39981),
		20019,
		4,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019005] = {
		20019005,
		0,
		Lang.get(39982),
		20019,
		5,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019006] = {
		20019006,
		0,
		Lang.get(39983),
		20019,
		6,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[111]
		}
	},
	[20019007] = {
		20019007,
		0,
		Lang.get(39984),
		20019,
		7,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019008] = {
		20019008,
		2,
		Lang.get(39985),
		20019,
		8,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[152]
		}
	},
	[20019009] = {
		20019009,
		0,
		Lang.get(39986),
		20019,
		9,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[93]
		}
	},
	[20019010] = {
		20019010,
		0,
		Lang.get(39987),
		20019,
		10,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019011] = {
		20019011,
		0,
		Lang.get(39988),
		20019,
		11,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[42]
		}
	},
	[20019012] = {
		20019012,
		0,
		Lang.get(39989),
		20019,
		12,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019013] = {
		20019013,
		0,
		Lang.get(39990),
		20019,
		13,
		367,
		{
			RTResTalkAction[153],
			RTResTalkAction[44]
		}
	},
	[20019014] = {
		20019014,
		0,
		Lang.get(41626),
		20019,
		14,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019015] = {
		20019015,
		2,
		Lang.get(39992),
		20019,
		15,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[152]
		}
	},
	[20019016] = {
		20019016,
		0,
		Lang.get(39993),
		20019,
		16,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[42]
		}
	},
	[20019017] = {
		20019017,
		0,
		Lang.get(39994),
		20019,
		17,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019018] = {
		20019018,
		0,
		Lang.get(39995),
		20019,
		18,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[152]
		}
	},
	[20019019] = {
		20019019,
		0,
		Lang.get(41627),
		20019,
		19,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019020] = {
		20019020,
		0,
		Lang.get(41628),
		20019,
		20,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019021] = {
		20019021,
		0,
		Lang.get(41629),
		20019,
		21,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019022] = {
		20019022,
		0,
		Lang.get(41630),
		20019,
		22,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019023] = {
		20019023,
		0,
		Lang.get(41631),
		20019,
		23,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[154]
		}
	},
	[20019024] = {
		20019024,
		0,
		Lang.get(41632),
		20019,
		24,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019025] = {
		20019025,
		0,
		Lang.get(41633),
		20019,
		25,
		220,
		{
			RTResTalkAction[151],
			RTResTalkAction[93]
		}
	},
	[20019026] = {
		20019026,
		0,
		Lang.get(41634),
		20019,
		26,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019027] = {
		20019027,
		0,
		Lang.get(41635),
		20019,
		27,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019028] = {
		20019028,
		0,
		Lang.get(39998),
		20019,
		28,
		367,
		{
			RTResTalkAction[151],
			RTResTalkAction[44]
		}
	},
	[20019029] = {
		20019029,
		0,
		Lang.get(41636),
		20019,
		29,
		220,
		{
			RTResTalkAction[80],
			RTResTalkAction[155]
		}
	},
	[20020001] = {
		20020001,
		0,
		Lang.get(40000),
		20020,
		1,
		220,
		nil,
		1,
		1,
		nil,
		nil,
		136,
		20057,
		0.5,
		1,
		nil,
		1,
		nil,
		20057
	},
	[20020002] = {
		20020002,
		0,
		Lang.get(40001),
		20020,
		2,
		367,
		nil,
		1,
		0
	},
	[20020003] = {
		20020003,
		0,
		Lang.get(40002),
		20020,
		3,
		220,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[20020004] = {
		20020004,
		0,
		Lang.get(40003),
		20020,
		4,
		367,
		{
			RTResTalkAction[156],
			RTResTalkAction[38]
		}
	},
	[20020005] = {
		20020005,
		0,
		Lang.get(40004),
		20020,
		5,
		220,
		{
			RTResTalkAction[157],
			RTResTalkAction[155]
		}
	},
	[20020006] = {
		20020006,
		0,
		Lang.get(40005),
		20020,
		6,
		367,
		{
			RTResTalkAction[156],
			RTResTalkAction[38]
		}
	},
	[20020007] = {
		20020007,
		0,
		Lang.get(40006),
		20020,
		7,
		367,
		{
			RTResTalkAction[156]
		}
	},
	[20020008] = {
		20020008,
		0,
		Lang.get(40007),
		20020,
		8,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[155]
		}
	},
	[20020009] = {
		20020009,
		0,
		Lang.get(40008),
		20020,
		9,
		367,
		{
			RTResTalkAction[156],
			RTResTalkAction[38]
		}
	},
	[20020010] = {
		20020010,
		2,
		Lang.get(41637),
		20020,
		10,
		220,
		{
			RTResTalkAction[78],
			RTResTalkAction[155]
		}
	},
	[20020011] = {
		20020011,
		0,
		Lang.get(41638),
		20020,
		11,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20020012] = {
		20020012,
		0,
		Lang.get(40011),
		20020,
		12,
		367,
		{
			RTResTalkAction[158],
			RTResTalkAction[38]
		}
	},
	[20020013] = {
		20020013,
		2,
		Lang.get(41639),
		20020,
		13,
		220,
		{
			RTResTalkAction[78],
			RTResTalkAction[155]
		}
	},
	[20021001] = {
		20021001,
		0,
		Lang.get(40013),
		20021,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		136,
		20058,
		nil,
		1,
		nil,
		1,
		nil,
		20058
	},
	[20021002] = {
		20021002,
		0,
		Lang.get(40014),
		20021,
		2,
		373,
		{
			RTResTalkAction[159]
		},
		nil,
		nil,
		3
	},
	[20021003] = {
		20021003,
		0,
		Lang.get(40015),
		20021,
		3,
		374,
		{
			RTResTalkAction[160],
			RTResTalkAction[161]
		}
	},
	[20021004] = {
		20021004,
		0,
		Lang.get(40016),
		20021,
		4,
		373,
		{
			RTResTalkAction[160],
			RTResTalkAction[161]
		}
	},
	[20021005] = {
		20021005,
		0,
		"……",
		20021,
		5,
		374,
		{
			RTResTalkAction[162],
			RTResTalkAction[163]
		}
	},
	[20021006] = {
		20021006,
		0,
		Lang.get(54606),
		20021,
		6,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[164]
		}
	},
	[20021007] = {
		20021007,
		0,
		Lang.get(41640),
		20021,
		7,
		357,
		{
			RTResTalkAction[165],
			RTResTalkAction[38]
		}
	},
	[20021008] = {
		20021008,
		0,
		Lang.get(40018),
		20021,
		8,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021009] = {
		20021009,
		0,
		Lang.get(40019),
		20021,
		9,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021010] = {
		20021010,
		0,
		Lang.get(41641),
		20021,
		10,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021011] = {
		20021011,
		9,
		Lang.get(40021),
		20021,
		11,
		605,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20059,
		0.5,
		1,
		nil,
		1,
		nil,
		20059,
		nil,
		nil,
		1
	},
	[20021012] = {
		20021012,
		2,
		Lang.get(41642),
		20021,
		12,
		220,
		nil,
		1,
		2
	},
	[20021013] = {
		20021013,
		0,
		Lang.get(40023),
		20021,
		13,
		357,
		{
			RTResTalkAction[165]
		},
		nil,
		nil,
		3
	},
	[20021014] = {
		20021014,
		0,
		Lang.get(40024),
		20021,
		14,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021015] = {
		20021015,
		0,
		Lang.get(40025),
		20021,
		15,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021016] = {
		20021016,
		0,
		Lang.get(41643),
		20021,
		16,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20021017] = {
		20021017,
		0,
		Lang.get(40027),
		20021,
		17,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021018] = {
		20021018,
		9,
		Lang.get(40028),
		20021,
		18,
		605,
		{
			RTResTalkAction[168],
			RTResTalkAction[169]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20060,
		0.5,
		1,
		nil,
		1,
		nil,
		20060,
		nil,
		nil,
		1
	},
	[20021019] = {
		20021019,
		2,
		Lang.get(40029),
		20021,
		19,
		220,
		nil,
		1,
		1
	},
	[20021020] = {
		20021020,
		0,
		Lang.get(40030),
		20021,
		20,
		357,
		{
			RTResTalkAction[165]
		},
		nil,
		nil,
		3
	},
	[20021021] = {
		20021021,
		0,
		Lang.get(40031),
		20021,
		21,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021022] = {
		20021022,
		0,
		Lang.get(40032),
		20021,
		22,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021023] = {
		20021023,
		0,
		Lang.get(40033),
		20021,
		23,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20021024] = {
		20021024,
		0,
		Lang.get(40034),
		20021,
		24,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021025] = {
		20021025,
		0,
		Lang.get(40035),
		20021,
		25,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021026] = {
		20021026,
		0,
		Lang.get(40036),
		20021,
		26,
		220,
		{
			RTResTalkAction[78]
		}
	},
	[20021027] = {
		20021027,
		0,
		Lang.get(41644),
		20021,
		27,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20021028] = {
		20021028,
		0,
		Lang.get(40038),
		20021,
		28,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021029] = {
		20021029,
		0,
		Lang.get(40039),
		20021,
		29,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20021030] = {
		20021030,
		0,
		Lang.get(40040),
		20021,
		30,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021031] = {
		20021031,
		0,
		Lang.get(41645),
		20021,
		31,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021032] = {
		20021032,
		0,
		Lang.get(41646),
		20021,
		32,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021033] = {
		20021033,
		0,
		Lang.get(41647),
		20021,
		33,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20021034] = {
		20021034,
		0,
		Lang.get(40044),
		20021,
		34,
		220,
		{
			RTResTalkAction[80],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20021035] = {
		20021035,
		0,
		Lang.get(41648),
		20021,
		35,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20022001] = {
		20022001,
		0,
		Lang.get(40046),
		20022,
		1,
		358,
		nil,
		1,
		0,
		nil,
		nil,
		136,
		20061,
		0.5,
		1,
		nil,
		1,
		nil,
		20061
	},
	[20022002] = {
		20022002,
		0,
		Lang.get(40047),
		20022,
		2,
		357,
		nil,
		1,
		0
	},
	[20022003] = {
		20022003,
		0,
		Lang.get(40048),
		20022,
		3,
		357,
		{
			RTResTalkAction[165]
		},
		nil,
		nil,
		3
	},
	[20022004] = {
		20022004,
		0,
		Lang.get(40049),
		20022,
		4,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[168]
		}
	},
	[20022005] = {
		20022005,
		0,
		Lang.get(40050),
		20022,
		5,
		358,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20022006] = {
		20022006,
		0,
		Lang.get(40051),
		20022,
		6,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20022007] = {
		20022007,
		0,
		Lang.get(40052),
		20022,
		7,
		220,
		{
			RTResTalkAction[134],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20022008] = {
		20022008,
		0,
		Lang.get(40053),
		20022,
		8,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20022009] = {
		20022009,
		0,
		Lang.get(40054),
		20022,
		9,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20022010] = {
		20022010,
		0,
		Lang.get(40055),
		20022,
		10,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167]
		}
	},
	[20022011] = {
		20022011,
		2,
		Lang.get(40056),
		20022,
		11,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20022012] = {
		20022012,
		0,
		Lang.get(41649),
		20022,
		12,
		220,
		{
			RTResTalkAction[41]
		}
	},
	[20022013] = {
		20022013,
		0,
		Lang.get(40058),
		20022,
		13,
		220,
		{
			RTResTalkAction[79]
		}
	},
	[20022014] = {
		20022014,
		0,
		Lang.get(40059),
		20022,
		14,
		357,
		{
			RTResTalkAction[166],
			RTResTalkAction[167],
			RTResTalkAction[38]
		}
	},
	[20022015] = {
		20022015,
		0,
		Lang.get(40060),
		20022,
		15,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[168],
			RTResTalkAction[169]
		}
	},
	[20022016] = {
		20022016,
		9,
		Lang.get(40061),
		20022,
		16,
		605,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		135,
		20062,
		0.5,
		1,
		nil,
		1,
		nil,
		20062,
		nil,
		nil,
		1
	},
	[20022017] = {
		20022017,
		9,
		Lang.get(40062),
		20022,
		17,
		605,
		[22] = 1
	},
	[20022018] = {
		20022018,
		9,
		Lang.get(40063),
		20022,
		18,
		605,
		[22] = 1
	},
	[20022019] = {
		20022019,
		2,
		Lang.get(40064),
		20022,
		19,
		220,
		nil,
		1,
		1
	},
	[20022020] = {
		20022020,
		2,
		Lang.get(40065),
		20022,
		20,
		220,
		nil,
		1,
		0
	},
	[20022021] = {
		20022021,
		2,
		Lang.get(41650),
		20022,
		21,
		220,
		nil,
		1,
		3
	},
	[20022022] = {
		20022022,
		2,
		Lang.get(40067),
		20022,
		22,
		220,
		nil,
		1,
		0
	},
	[20022023] = {
		20022023,
		2,
		Lang.get(40068),
		20022,
		23,
		220,
		nil,
		1,
		0
	},
	[20022024] = {
		20022024,
		0,
		Lang.get(40069),
		20022,
		24,
		220,
		nil,
		1,
		0
	},
	[20022025] = {
		20022025,
		0,
		Lang.get(40070),
		20022,
		25,
		220,
		nil,
		1,
		3
	},
	[20022026] = {
		20022026,
		0,
		Lang.get(40071),
		20022,
		26,
		220,
		nil,
		1,
		3
	},
	[20023001] = {
		20023001,
		0,
		Lang.get(40072),
		20023,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		20063,
		0.5,
		1,
		nil,
		1,
		nil,
		20063
	},
	[20023002] = {
		20023002,
		0,
		Lang.get(40073),
		20023,
		2,
		220,
		nil,
		1
	},
	[20023003] = {
		20023003,
		0,
		Lang.get(40074),
		20023,
		3,
		59,
		nil,
		1,
		0
	},
	[20023004] = {
		20023004,
		0,
		Lang.get(40075),
		20023,
		4,
		220,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[20023005] = {
		20023005,
		0,
		Lang.get(40076),
		20023,
		5,
		59,
		{
			RTResTalkAction[170],
			RTResTalkAction[38]
		}
	},
	[20023006] = {
		20023006,
		0,
		Lang.get(41651),
		20023,
		6,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[171]
		}
	},
	[20023007] = {
		20023007,
		0,
		Lang.get(40078),
		20023,
		7,
		59,
		{
			RTResTalkAction[170],
			RTResTalkAction[38]
		}
	},
	[20023008] = {
		20023008,
		0,
		Lang.get(41652),
		20023,
		8,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[171]
		}
	},
	[20023009] = {
		20023009,
		0,
		Lang.get(40080),
		20023,
		9,
		59,
		{
			RTResTalkAction[170],
			RTResTalkAction[38]
		}
	},
	[20023010] = {
		20023010,
		0,
		Lang.get(40081),
		20023,
		10,
		220,
		{
			RTResTalkAction[80],
			RTResTalkAction[171]
		}
	},
	[20023011] = {
		20023011,
		0,
		Lang.get(40082),
		20023,
		11,
		59,
		{
			RTResTalkAction[170],
			RTResTalkAction[38]
		}
	},
	[20023012] = {
		20023012,
		0,
		Lang.get(40083),
		20023,
		12,
		59,
		{
			RTResTalkAction[170]
		}
	},
	[20023013] = {
		20023013,
		0,
		Lang.get(41653),
		20023,
		13,
		59,
		{
			RTResTalkAction[170]
		}
	},
	[20023014] = {
		20023014,
		0,
		Lang.get(40085),
		20023,
		14,
		220,
		{
			RTResTalkAction[171]
		},
		1,
		0,
		nil,
		nil,
		59,
		20064,
		0.5,
		1,
		nil,
		1,
		nil,
		20064
	},
	[20023015] = {
		20023015,
		0,
		Lang.get(40086),
		20023,
		15,
		60,
		nil,
		1,
		0
	},
	[20023016] = {
		20023016,
		0,
		Lang.get(40087),
		20023,
		16,
		220,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[20023017] = {
		20023017,
		0,
		Lang.get(40088),
		20023,
		17,
		220,
		{
			RTResTalkAction[98]
		}
	},
	[20023018] = {
		20023018,
		0,
		Lang.get(40089),
		20023,
		18,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023019] = {
		20023019,
		0,
		Lang.get(40090),
		20023,
		19,
		60,
		{
			RTResTalkAction[172]
		}
	},
	[20023020] = {
		20023020,
		0,
		Lang.get(40091),
		20023,
		20,
		60,
		{
			RTResTalkAction[172]
		}
	},
	[20023021] = {
		20023021,
		0,
		Lang.get(40092),
		20023,
		21,
		220,
		{
			RTResTalkAction[98],
			RTResTalkAction[173]
		}
	},
	[20023022] = {
		20023022,
		0,
		Lang.get(41654),
		20023,
		22,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023023] = {
		20023023,
		0,
		Lang.get(40094),
		20023,
		23,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[173]
		}
	},
	[20023024] = {
		20023024,
		0,
		Lang.get(40095),
		20023,
		24,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023025] = {
		20023025,
		0,
		Lang.get(40096),
		20023,
		25,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[173]
		}
	},
	[20023026] = {
		20023026,
		0,
		Lang.get(40097),
		20023,
		26,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023027] = {
		20023027,
		0,
		Lang.get(40098),
		20023,
		27,
		220,
		{
			RTResTalkAction[78],
			RTResTalkAction[173]
		}
	},
	[20023028] = {
		20023028,
		0,
		Lang.get(41655),
		20023,
		28,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023029] = {
		20023029,
		0,
		Lang.get(40101),
		20023,
		29,
		60,
		{
			RTResTalkAction[172]
		}
	},
	[20023030] = {
		20023030,
		0,
		Lang.get(40102),
		20023,
		30,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[173]
		}
	},
	[20023031] = {
		20023031,
		0,
		Lang.get(40103),
		20023,
		31,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023032] = {
		20023032,
		0,
		Lang.get(41656),
		20023,
		32,
		60,
		{
			RTResTalkAction[172]
		}
	},
	[20023033] = {
		20023033,
		0,
		Lang.get(40106),
		20023,
		33,
		220,
		{
			RTResTalkAction[79],
			RTResTalkAction[173]
		}
	},
	[20023034] = {
		20023034,
		0,
		Lang.get(54607),
		20023,
		34,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20023035] = {
		20023035,
		0,
		Lang.get(40107),
		20023,
		35,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[173]
		}
	},
	[20024001] = {
		20024001,
		0,
		Lang.get(40108),
		20024,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		136,
		20065,
		0.5,
		1,
		nil,
		1,
		nil,
		20065
	},
	[20024002] = {
		20024002,
		0,
		Lang.get(41657),
		20024,
		2,
		60,
		nil,
		1
	},
	[20024003] = {
		20024003,
		0,
		Lang.get(40111),
		20024,
		3,
		220,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[20024004] = {
		20024004,
		0,
		Lang.get(41658),
		20024,
		4,
		60,
		{
			RTResTalkAction[174],
			RTResTalkAction[38]
		}
	},
	[20024005] = {
		20024005,
		0,
		Lang.get(40114),
		20024,
		5,
		60,
		{
			RTResTalkAction[173]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		20066,
		0.5,
		1,
		nil,
		1,
		nil,
		20066
	},
	[20024006] = {
		20024006,
		0,
		Lang.get(40115),
		20024,
		6,
		220,
		nil,
		1
	},
	[20024007] = {
		20024007,
		0,
		Lang.get(40116),
		20024,
		7,
		60,
		{
			RTResTalkAction[172]
		},
		nil,
		nil,
		3
	},
	[20024008] = {
		20024008,
		0,
		Lang.get(40117),
		20024,
		8,
		220,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024009] = {
		20024009,
		0,
		Lang.get(40118),
		20024,
		9,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024010] = {
		20024010,
		0,
		Lang.get(40119),
		20024,
		10,
		220,
		{
			RTResTalkAction[175],
			RTResTalkAction[93]
		}
	},
	[20024011] = {
		20024011,
		0,
		Lang.get(40120),
		20024,
		11,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024012] = {
		20024012,
		0,
		Lang.get(40121),
		20024,
		12,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024013] = {
		20024013,
		0,
		Lang.get(40122),
		20024,
		13,
		220,
		{
			RTResTalkAction[175],
			RTResTalkAction[42]
		}
	},
	[20024014] = {
		20024014,
		0,
		Lang.get(41659),
		20024,
		14,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024015] = {
		20024015,
		0,
		Lang.get(40124),
		20024,
		15,
		220,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024016] = {
		20024016,
		0,
		Lang.get(40125),
		20024,
		16,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[44]
		}
	},
	[20024017] = {
		20024017,
		0,
		Lang.get(40126),
		20024,
		17,
		220,
		{
			RTResTalkAction[175],
			RTResTalkAction[152]
		}
	},
	[20024018] = {
		20024018,
		0,
		Lang.get(41660),
		20024,
		18,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[38]
		}
	},
	[20024019] = {
		20024019,
		0,
		Lang.get(40129),
		20024,
		19,
		357,
		{
			RTResTalkAction[165],
			RTResTalkAction[173]
		}
	},
	[20024020] = {
		20024020,
		0,
		Lang.get(40130),
		20024,
		20,
		60,
		{
			RTResTalkAction[172],
			RTResTalkAction[168]
		}
	},
	[20024021] = {
		20024021,
		0,
		Lang.get(40131),
		20024,
		21,
		357,
		{
			RTResTalkAction[165],
			RTResTalkAction[173]
		}
	},
	[20024022] = {
		20024022,
		0,
		Lang.get(40132),
		20024,
		22,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[168]
		}
	},
	[20024023] = {
		20024023,
		0,
		Lang.get(41661),
		20024,
		23,
		220,
		{
			RTResTalkAction[40]
		}
	},
	[20024024] = {
		20024024,
		0,
		Lang.get(40135),
		20024,
		24,
		60,
		{
			RTResTalkAction[38]
		},
		1,
		nil,
		nil,
		nil,
		63,
		20067,
		0.8,
		1,
		nil,
		1,
		nil,
		20067
	},
	[20024025] = {
		20024025,
		0,
		Lang.get(40136),
		20024,
		25,
		685,
		nil,
		1
	},
	[20024026] = {
		20024026,
		0,
		Lang.get(40137),
		20024,
		26,
		60,
		{
			RTResTalkAction[174]
		},
		nil,
		nil,
		3
	},
	[20024027] = {
		20024027,
		0,
		Lang.get(41662),
		20024,
		27,
		685,
		{
			RTResTalkAction[175],
			RTResTalkAction[176]
		}
	},
	[20024028] = {
		20024028,
		0,
		Lang.get(54608),
		20024,
		28,
		60,
		{
			RTResTalkAction[177],
			RTResTalkAction[176]
		}
	},
	[20024029] = {
		20024029,
		0,
		Lang.get(40139),
		20024,
		29,
		685,
		{
			RTResTalkAction[175],
			RTResTalkAction[176]
		}
	},
	[20024030] = {
		20024030,
		0,
		Lang.get(40140),
		20024,
		30,
		60,
		{
			RTResTalkAction[178],
			RTResTalkAction[176]
		}
	},
	[20024031] = {
		20024031,
		0,
		Lang.get(40141),
		20024,
		31,
		685,
		{
			RTResTalkAction[175],
			RTResTalkAction[176]
		}
	},
	[20024032] = {
		20024032,
		0,
		"……",
		20024,
		32,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[176]
		}
	},
	[20024033] = {
		20024033,
		0,
		Lang.get(40142),
		20024,
		33,
		60,
		{
			RTResTalkAction[175],
			RTResTalkAction[176]
		}
	},
	[20024034] = {
		20024034,
		0,
		Lang.get(40143),
		20024,
		34,
		685,
		{
			RTResTalkAction[179],
			RTResTalkAction[173]
		}
	},
	[20025001] = {
		20025001,
		0,
		Lang.get(40144),
		20025,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		62,
		20068,
		0.8,
		1,
		nil,
		1,
		nil,
		20068
	},
	[20025002] = {
		20025002,
		0,
		Lang.get(40145),
		20025,
		2,
		300
	},
	[20025003] = {
		20025003,
		0,
		Lang.get(40146),
		20025,
		3,
		107,
		nil,
		1,
		3
	},
	[20025004] = {
		20025004,
		0,
		Lang.get(40147),
		20025,
		4,
		133,
		nil,
		1,
		0
	},
	[20025005] = {
		20025005,
		0,
		Lang.get(40148),
		20025,
		5,
		300
	},
	[20025006] = {
		20025006,
		0,
		Lang.get(40149),
		20025,
		6,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20025007] = {
		20025007,
		0,
		Lang.get(40150),
		20025,
		7,
		107,
		{
			RTResTalkAction[180],
			RTResTalkAction[44]
		}
	},
	[20025008] = {
		20025008,
		0,
		Lang.get(40151),
		20025,
		8,
		141,
		{
			RTResTalkAction[74],
			RTResTalkAction[40],
			RTResTalkAction[102]
		}
	},
	[20025009] = {
		20025009,
		0,
		Lang.get(40152),
		20025,
		9,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[26],
			RTResTalkAction[22]
		}
	},
	[20025010] = {
		20025010,
		0,
		Lang.get(40153),
		20025,
		10,
		107,
		{
			RTResTalkAction[50],
			RTResTalkAction[38]
		}
	},
	[20025011] = {
		20025011,
		9,
		Lang.get(40154),
		20025,
		11,
		605,
		{
			RTResTalkAction[26]
		},
		[22] = 1
	},
	[20025012] = {
		20025012,
		0,
		Lang.get(40155),
		20025,
		12,
		107,
		{
			RTResTalkAction[77]
		}
	},
	[20025013] = {
		20025013,
		0,
		Lang.get(41663),
		20025,
		13,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[26]
		}
	},
	[20025014] = {
		20025014,
		0,
		Lang.get(40158),
		20025,
		14,
		107,
		{
			RTResTalkAction[181],
			RTResTalkAction[38]
		}
	},
	[20025015] = {
		20025015,
		0,
		Lang.get(40159),
		20025,
		15,
		220,
		{
			RTResTalkAction[37],
			RTResTalkAction[26]
		}
	},
	[20025016] = {
		20025016,
		0,
		Lang.get(40160),
		20025,
		16,
		107,
		{
			RTResTalkAction[135],
			RTResTalkAction[38]
		}
	},
	[20025017] = {
		20025017,
		0,
		Lang.get(40161),
		20025,
		17,
		300,
		{
			RTResTalkAction[182],
			RTResTalkAction[26]
		}
	},
	[20025018] = {
		20025018,
		0,
		Lang.get(40162),
		20025,
		18,
		220,
		{
			RTResTalkAction[98],
			RTResTalkAction[183]
		}
	},
	[20025019] = {
		20025019,
		9,
		Lang.get(40163),
		20025,
		19,
		605,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		20069,
		0.5,
		1,
		nil,
		1,
		nil,
		20069,
		nil,
		nil,
		1
	},
	[20025020] = {
		20025020,
		2,
		Lang.get(41664),
		20025,
		20,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		20070,
		nil,
		nil,
		nil,
		nil,
		nil,
		20070
	},
	[20025021] = {
		20025021,
		0,
		Lang.get(41665),
		20025,
		21,
		220,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[20025022] = {
		20025022,
		0,
		Lang.get(41666),
		20025,
		22,
		220,
		{
			RTResTalkAction[38]
		},
		1,
		0,
		nil,
		nil,
		135,
		nil,
		0.5,
		1,
		nil,
		1,
		nil,
		20071
	},
	[20025023] = {
		20025023,
		0,
		Lang.get(40169),
		20025,
		23,
		220,
		nil,
		1,
		3
	},
	[20025024] = {
		20025024,
		0,
		Lang.get(40170),
		20025,
		24,
		220,
		nil,
		1
	},
	[20025025] = {
		20025025,
		0,
		Lang.get(40171),
		20025,
		25,
		220,
		nil,
		1,
		0
	},
	[20025026] = {
		20025026,
		9,
		Lang.get(41667),
		20025,
		26,
		605,
		[22] = 1
	},
	[20025027] = {
		20025027,
		9,
		Lang.get(41668),
		20025,
		27,
		605,
		[22] = 1
	},
	[20025028] = {
		20025028,
		9,
		Lang.get(41669),
		20025,
		28,
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
