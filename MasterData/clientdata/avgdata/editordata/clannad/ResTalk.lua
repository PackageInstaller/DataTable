-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\CLANNAD\\ResTalk.lua

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
	nil,
	nil,
	6
}
RTResTalkAction[2] = {
	2,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[5] = {
	1,
	159,
	nil,
	nil,
	4
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[8] = {
	2,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 159
}
RTResTalkAction[10] = {
	1,
	158,
	nil,
	nil,
	3
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[12] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[14] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 195
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 195
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 292
}
RTResTalkAction[25] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 292
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 428
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 428
}
RTResTalkAction[29] = {
	1,
	198,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 198
}
RTResTalkAction[31] = {
	[1] = 2,
	[2] = 198
}
RTResTalkAction[32] = {
	3,
	216,
	nil,
	nil,
	1
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 198
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 216
}
RTResTalkAction[35] = {
	1,
	292,
	nil,
	nil,
	1
}
RTResTalkAction[36] = {
	1,
	292,
	nil,
	nil,
	0
}
RTResTalkAction[37] = {
	1,
	1267,
	nil,
	nil,
	1
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1267
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1267
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1268
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1268
}
RTResTalkAction[42] = {
	2,
	1267,
	nil,
	nil,
	1
}
RTResTalkAction[43] = {
	[1] = 3,
	[2] = 1268
}
RTResTalkAction[44] = {
	[1] = 2,
	[2] = 1267
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 1028
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 1027
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 1028
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 1027
}
RTResTalkAction[49] = {
	1,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[50] = {
	1,
	1028,
	nil,
	nil,
	1
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 1028
}
RTResTalkAction[52] = {
	3,
	1268,
	nil,
	nil,
	2
}
RTResTalkAction[53] = {
	1,
	1267,
	nil,
	nil,
	2
}
RTResTalkAction[54] = {
	1,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 864
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 864
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 865
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 865
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 864
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 865
}
RTResTalkAction[61] = {
	[1] = 2,
	[2] = 866
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 866
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 866
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 868
}
RTResTalkAction[65] = {
	[1] = 2,
	[2] = 867
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 868
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 867
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 868
}
RTResTalkAction[69] = {
	[1] = 0,
	[2] = 867
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 869
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 869
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 869
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 429
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 429
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 870
}
RTResTalkAction[76] = {
	[1] = 2,
	[2] = 870
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 871
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 870
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 871
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 871
}
RTResTalkAction[81] = {
	[1] = 2,
	[2] = 869
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 872
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 872
}
RTResTalkAction[84] = {
	[1] = 3,
	[2] = 872
}
RTResTalkAction[85] = {
	[1] = 3,
	[2] = 870
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 1112
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 1026
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 1112
}
RTResTalkAction[89] = {
	[1] = 0,
	[2] = 1026
}
RTResTalkAction[90] = {
	3,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 874
}
RTResTalkAction[92] = {
	[1] = 2,
	[2] = 874
}
RTResTalkAction[93] = {
	[1] = 3,
	[2] = 875
}
RTResTalkAction[94] = {
	[1] = 0,
	[2] = 874
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 875
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 875
}
RTResTalkAction[97] = {
	1,
	1268,
	nil,
	nil,
	2
}
RTResTalkAction[98] = {
	[1] = 2,
	[2] = 1268
}
RTResTalkAction[99] = {
	[1] = 3,
	[2] = 292
}
RTResTalkAction[100] = {
	1,
	1266,
	nil,
	nil,
	1
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 1266,
	[3] = {
		1
	}
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 1266
}
RTResTalkAction[103] = {
	[1] = 2,
	[2] = 292
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 1266
}
RTResTalkAction[105] = {
	1,
	1195,
	nil,
	nil,
	2
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[107] = {
	1,
	1266,
	nil,
	nil,
	3
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[109] = {
	1,
	1195,
	nil,
	nil,
	1
}
RTResTalkAction[110] = {
	[1] = 1,
	[2] = 1266,
	[3] = {
		3
	}
}
RTResTalkAction[111] = {
	1,
	1195,
	nil,
	nil,
	3
}
RTResTalkAction[112] = {
	3,
	1268,
	nil,
	nil,
	0
}
RTResTalkAction[113] = {
	3,
	1266,
	nil,
	nil,
	3
}
RTResTalkAction[114] = {
	[1] = 2,
	[2] = 1195
}
RTResTalkAction[115] = {
	3,
	1266,
	nil,
	nil,
	2
}
RTResTalkAction[116] = {
	1,
	1268,
	nil,
	nil,
	0
}
RTResTalkAction[117] = {
	[1] = 2,
	[2] = 292,
	[3] = {
		1
	}
}
RTResTalkAction[118] = {
	1,
	1266,
	nil,
	nil,
	2
}
RTResTalkAction[119] = {
	[1] = 3,
	[2] = 1266
}
RTResTalkAction[120] = {
	1,
	292,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[121] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[122] = {
	3,
	1266,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[123] = {
	2,
	1268,
	nil,
	nil,
	1
}
RTResTalkAction[124] = {
	2,
	1267,
	nil,
	nil,
	2
}
RTResTalkAction[125] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[126] = {
	1,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[127] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[128] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[129] = {
	3,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[130] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[131] = {
	1,
	198,
	nil,
	nil,
	2
}
RTResTalkAction[132] = {
	3,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[133] = {
	2,
	198,
	nil,
	nil,
	2
}
RTResTalkAction[134] = {
	1,
	198,
	nil,
	nil,
	3
}
RTResTalkAction[135] = {
	1,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[136] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[137] = {
	1,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[138] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[139] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[140] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[141] = {
	[1] = 3,
	[2] = 1267
}
RTResTalkAction[142] = {
	3,
	292,
	nil,
	nil,
	2
}
RTResTalkAction[143] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[144] = {
	1,
	158,
	{
		1
	},
	nil,
	1
}

local Data = {
	[39901001] = {
		39901001,
		0,
		Lang.get(91190),
		39901,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39901,
		nil,
		1,
		nil,
		nil,
		nil,
		39901
	},
	[39901002] = {
		39901002,
		0,
		Lang.get(105890),
		39901,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[39901003] = {
		39901003,
		0,
		Lang.get(105891),
		39901,
		3,
		158,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[39901004] = {
		39901004,
		0,
		Lang.get(105892),
		39901,
		4,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[39901005] = {
		39901005,
		0,
		Lang.get(105893),
		39901,
		5,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[39901006] = {
		39901006,
		0,
		Lang.get(105894),
		39901,
		6,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[39901007] = {
		39901007,
		0,
		Lang.get(105895),
		39901,
		7,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[39901008] = {
		39901008,
		0,
		Lang.get(105896),
		39901,
		8,
		158,
		{
			RTResTalkAction[12]
		}
	},
	[39901009] = {
		39901009,
		0,
		Lang.get(105897),
		39901,
		9,
		158,
		{
			RTResTalkAction[13]
		}
	},
	[39901010] = {
		39901010,
		0,
		Lang.get(105898),
		39901,
		10,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[6]
		}
	},
	[39901011] = {
		39901011,
		0,
		Lang.get(105899),
		39901,
		11,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39901012] = {
		39901012,
		0,
		Lang.get(105900),
		39901,
		12,
		133,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[39901013] = {
		39901013,
		0,
		Lang.get(105901),
		39901,
		13,
		133,
		{
			RTResTalkAction[18],
			RTResTalkAction[7]
		}
	},
	[39901014] = {
		39901014,
		0,
		Lang.get(105902),
		39901,
		14,
		141,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[39901015] = {
		39901015,
		0,
		Lang.get(105903),
		39901,
		15,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[39901016] = {
		39901016,
		0,
		Lang.get(105904),
		39901,
		16,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39901017] = {
		39901017,
		0,
		Lang.get(105905),
		39901,
		17,
		158,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[39901018] = {
		39901018,
		0,
		Lang.get(105906),
		39901,
		18,
		196,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39902,
		nil,
		1,
		nil,
		1,
		nil,
		39902
	},
	[39901019] = {
		39901019,
		0,
		Lang.get(105907),
		39901,
		19,
		195,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[39901020] = {
		39901020,
		0,
		Lang.get(105908),
		39901,
		20,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39901021] = {
		39901021,
		0,
		Lang.get(105909),
		39901,
		21,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[23]
		}
	},
	[39901022] = {
		39901022,
		0,
		Lang.get(105910),
		39901,
		22,
		158,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[39901023] = {
		39901023,
		0,
		Lang.get(105911),
		39901,
		23,
		158,
		{
			RTResTalkAction[13]
		}
	},
	[39902001] = {
		39902001,
		0,
		Lang.get(105912),
		39902,
		1,
		198,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		39903,
		nil,
		1,
		nil,
		1,
		nil,
		39903,
		nil,
		428
	},
	[39902002] = {
		39902002,
		0,
		Lang.get(105913),
		39902,
		2,
		216,
		{
			RTResTalkAction[27]
		},
		1,
		1,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		428
	},
	[39902003] = {
		39902003,
		0,
		Lang.get(105914),
		39902,
		3,
		216,
		{
			RTResTalkAction[27]
		},
		1,
		[21] = 428
	},
	[39902004] = {
		39902004,
		0,
		Lang.get(105915),
		39902,
		4,
		198,
		{
			RTResTalkAction[27]
		},
		1,
		[21] = 428
	},
	[39902005] = {
		39902005,
		0,
		Lang.get(105916),
		39902,
		5,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[28]
		},
		nil,
		0
	},
	[39902006] = {
		39902006,
		0,
		Lang.get(105917),
		39902,
		6,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39902007] = {
		39902007,
		0,
		Lang.get(105918),
		39902,
		7,
		198,
		{
			RTResTalkAction[29],
			RTResTalkAction[26]
		}
	},
	[39902008] = {
		39902008,
		0,
		Lang.get(105919),
		39902,
		8,
		198,
		{
			RTResTalkAction[30]
		}
	},
	[39902009] = {
		39902009,
		0,
		Lang.get(105920),
		39902,
		9,
		216,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[39902010] = {
		39902010,
		0,
		Lang.get(105921),
		39902,
		10,
		860,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		},
		1
	},
	[39902011] = {
		39902011,
		0,
		Lang.get(105922),
		39902,
		11,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39902012] = {
		39902012,
		0,
		Lang.get(105923),
		39902,
		12,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39904,
		nil,
		1,
		[19] = 39904,
		[17] = 1
	},
	[39902013] = {
		39902013,
		0,
		Lang.get(105924),
		39902,
		13,
		195,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[39902014] = {
		39902014,
		0,
		Lang.get(105925),
		39902,
		14,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39902015] = {
		39902015,
		0,
		Lang.get(105926),
		39902,
		15,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39902016] = {
		39902016,
		0,
		Lang.get(105927),
		39902,
		16,
		292,
		{
			RTResTalkAction[35],
			RTResTalkAction[23]
		}
	},
	[39902017] = {
		39902017,
		0,
		Lang.get(105928),
		39902,
		17,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39902018] = {
		39902018,
		0,
		Lang.get(105929),
		39902,
		18,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[26]
		}
	},
	[39902019] = {
		39902019,
		0,
		Lang.get(105930),
		39902,
		19,
		292,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[39902020] = {
		39902020,
		0,
		Lang.get(105931),
		39902,
		20,
		198,
		{
			RTResTalkAction[29],
			RTResTalkAction[26]
		}
	},
	[39902021] = {
		39902021,
		0,
		Lang.get(105932),
		39902,
		21,
		216,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		}
	},
	[39903001] = {
		39903001,
		0,
		Lang.get(105933),
		39903,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39905,
		nil,
		1,
		nil,
		1,
		nil,
		39905
	},
	[39903002] = {
		39903002,
		0,
		Lang.get(105934),
		39903,
		2,
		861,
		nil,
		1,
		nil,
		3
	},
	[39903003] = {
		39903003,
		0,
		Lang.get(105935),
		39903,
		3,
		862,
		nil,
		1
	},
	[39903004] = {
		39903004,
		0,
		Lang.get(105936),
		39903,
		4,
		861,
		nil,
		1
	},
	[39903005] = {
		39903005,
		0,
		Lang.get(105937),
		39903,
		5,
		862,
		nil,
		1
	},
	[39903006] = {
		39903006,
		0,
		Lang.get(105938),
		39903,
		6,
		863,
		nil,
		1
	},
	[39903007] = {
		39903007,
		0,
		Lang.get(105939),
		39903,
		7,
		861,
		nil,
		1
	},
	[39903008] = {
		39903008,
		0,
		Lang.get(105940),
		39903,
		8,
		862,
		nil,
		1
	},
	[39903009] = {
		39903009,
		0,
		Lang.get(105941),
		39903,
		9,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		39906,
		nil,
		1,
		[19] = 39906,
		[17] = 1
	},
	[39903010] = {
		39903010,
		0,
		Lang.get(105942),
		39903,
		10,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[39903011] = {
		39903011,
		0,
		Lang.get(105943),
		39903,
		11,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39903012] = {
		39903012,
		0,
		Lang.get(105944),
		39903,
		12,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39903013] = {
		39903013,
		7,
		"117",
		39903,
		13,
		1267,
		{
			RTResTalkAction[39]
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
	[39903014] = {
		39903014,
		0,
		Lang.get(105945),
		39903,
		14,
		1268,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[39903015] = {
		39903015,
		0,
		Lang.get(105946),
		39903,
		15,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39903016] = {
		39903016,
		7,
		"118",
		39903,
		16,
		1268,
		{
			RTResTalkAction[41]
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
	[39903017] = {
		39903017,
		0,
		Lang.get(105947),
		39903,
		17,
		1268,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[39903018] = {
		39903018,
		0,
		Lang.get(105948),
		39903,
		18,
		1267,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[39903019] = {
		39903019,
		0,
		Lang.get(105949),
		39903,
		19,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39903020] = {
		39903020,
		0,
		Lang.get(105950),
		39903,
		20,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39903021] = {
		39903021,
		0,
		Lang.get(105951),
		39903,
		21,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39903022] = {
		39903022,
		0,
		Lang.get(105952),
		39903,
		22,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39904001] = {
		39904001,
		0,
		Lang.get(105953),
		39904,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		39907,
		nil,
		1,
		nil,
		1,
		nil,
		39907
	},
	[39904002] = {
		39904002,
		0,
		Lang.get(105954),
		39904,
		2,
		195,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[39904003] = {
		39904003,
		0,
		Lang.get(105955),
		39904,
		3,
		1028,
		{
			RTResTalkAction[45],
			RTResTalkAction[23]
		}
	},
	[39904004] = {
		39904004,
		0,
		Lang.get(105956),
		39904,
		4,
		1027,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[39904005] = {
		39904005,
		0,
		Lang.get(105957),
		39904,
		5,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[48]
		}
	},
	[39904006] = {
		39904006,
		0,
		Lang.get(105958),
		39904,
		6,
		1027,
		{
			RTResTalkAction[46],
			RTResTalkAction[23]
		}
	},
	[39904007] = {
		39904007,
		0,
		Lang.get(105959),
		39904,
		7,
		1028,
		{
			RTResTalkAction[45],
			RTResTalkAction[48]
		}
	},
	[39904008] = {
		39904008,
		0,
		Lang.get(105960),
		39904,
		8,
		292,
		{
			RTResTalkAction[35],
			RTResTalkAction[47]
		}
	},
	[39904009] = {
		39904009,
		0,
		Lang.get(105961),
		39904,
		9,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39908,
		nil,
		1,
		[19] = 39908,
		[17] = 1
	},
	[39904010] = {
		39904010,
		0,
		Lang.get(105962),
		39904,
		10,
		1268,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[39904011] = {
		39904011,
		0,
		Lang.get(105963),
		39904,
		11,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39904012] = {
		39904012,
		0,
		Lang.get(105964),
		39904,
		12,
		1027,
		{
			RTResTalkAction[46],
			RTResTalkAction[41]
		}
	},
	[39904013] = {
		39904013,
		0,
		Lang.get(105965),
		39904,
		13,
		1028,
		{
			RTResTalkAction[50],
			RTResTalkAction[48]
		}
	},
	[39904014] = {
		39904014,
		0,
		Lang.get(105966),
		39904,
		14,
		1027,
		{
			RTResTalkAction[46],
			RTResTalkAction[47]
		}
	},
	[39904015] = {
		39904015,
		0,
		Lang.get(105967),
		39904,
		15,
		1027,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39909,
		nil,
		1,
		[19] = 39909,
		[17] = 1
	},
	[39904016] = {
		39904016,
		0,
		Lang.get(105968),
		39904,
		16,
		1028,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[39904017] = {
		39904017,
		0,
		Lang.get(105969),
		39904,
		17,
		1028,
		{
			RTResTalkAction[45]
		}
	},
	[39904018] = {
		39904018,
		0,
		Lang.get(105970),
		39904,
		18,
		1268,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[39904019] = {
		39904019,
		0,
		Lang.get(105971),
		39904,
		19,
		1268,
		{
			RTResTalkAction[51],
			RTResTalkAction[43]
		}
	},
	[39904020] = {
		39904020,
		0,
		Lang.get(105972),
		39904,
		20,
		1028,
		{
			RTResTalkAction[45],
			RTResTalkAction[41]
		}
	},
	[39905001] = {
		39905001,
		0,
		Lang.get(105973),
		39905,
		1,
		1267,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		39910,
		nil,
		1,
		nil,
		1,
		nil,
		39910
	},
	[39905002] = {
		39905002,
		0,
		Lang.get(105974),
		39905,
		2,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		0,
		3
	},
	[39905003] = {
		39905003,
		0,
		Lang.get(105975),
		39905,
		3,
		1027,
		{
			RTResTalkAction[46],
			RTResTalkAction[39]
		}
	},
	[39905004] = {
		39905004,
		0,
		Lang.get(105976),
		39905,
		4,
		1027,
		{
			RTResTalkAction[46]
		}
	},
	[39905005] = {
		39905005,
		0,
		Lang.get(105977),
		39905,
		5,
		1028,
		{
			RTResTalkAction[45],
			RTResTalkAction[48]
		}
	},
	[39905006] = {
		39905006,
		0,
		"READY？ACTION！",
		39905,
		6,
		1028,
		{
			RTResTalkAction[45]
		}
	},
	[39905007] = {
		39905007,
		0,
		Lang.get(105978),
		39905,
		7,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[47]
		}
	},
	[39905008] = {
		39905008,
		0,
		Lang.get(105979),
		39905,
		8,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39905009] = {
		39905009,
		0,
		Lang.get(105980),
		39905,
		9,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39905010] = {
		39905010,
		0,
		Lang.get(105981),
		39905,
		10,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39905011] = {
		39905011,
		2,
		Lang.get(105982),
		39905,
		11,
		292,
		{
			RTResTalkAction[54]
		}
	},
	[39905012] = {
		39905012,
		0,
		Lang.get(105983),
		39905,
		12,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[26]
		}
	},
	[39905013] = {
		39905013,
		0,
		Lang.get(105984),
		39905,
		13,
		292,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39911,
		nil,
		1,
		nil,
		1,
		nil,
		39911
	},
	[39905014] = {
		39905014,
		0,
		Lang.get(105985),
		39905,
		14,
		1267,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[39905015] = {
		39905015,
		0,
		Lang.get(105986),
		39905,
		15,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39905016] = {
		39905016,
		0,
		Lang.get(105987),
		39905,
		16,
		300,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39905017] = {
		39905017,
		0,
		Lang.get(105988),
		39905,
		17,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39905018] = {
		39905018,
		0,
		Lang.get(105989),
		39905,
		18,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[23]
		}
	},
	[39905019] = {
		39905019,
		0,
		Lang.get(105990),
		39905,
		19,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39906001] = {
		39906001,
		0,
		Lang.get(105991),
		39906,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		132,
		39912,
		nil,
		1,
		nil,
		1,
		nil,
		39912
	},
	[39906002] = {
		39906002,
		0,
		Lang.get(105992),
		39906,
		2,
		864,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[39906003] = {
		39906003,
		0,
		Lang.get(105993),
		39906,
		3,
		864,
		{
			RTResTalkAction[55]
		}
	},
	[39906004] = {
		39906004,
		0,
		Lang.get(105994),
		39906,
		4,
		865,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[39906005] = {
		39906005,
		0,
		Lang.get(105995),
		39906,
		5,
		864,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[39906006] = {
		39906006,
		0,
		Lang.get(105996),
		39906,
		6,
		864,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[39906007] = {
		39906007,
		0,
		Lang.get(105997),
		39906,
		7,
		865,
		{
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[39906008] = {
		39906008,
		0,
		Lang.get(105998),
		39906,
		8,
		865,
		{
			RTResTalkAction[60]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39913,
		nil,
		1,
		nil,
		1,
		nil,
		39913
	},
	[39906009] = {
		39906009,
		0,
		Lang.get(105999),
		39906,
		9,
		865,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[39906010] = {
		39906010,
		0,
		Lang.get(106000),
		39906,
		10,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906011] = {
		39906011,
		0,
		Lang.get(106001),
		39906,
		11,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906012] = {
		39906012,
		0,
		Lang.get(106002),
		39906,
		12,
		865,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906013] = {
		39906013,
		0,
		Lang.get(106003),
		39906,
		13,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906014] = {
		39906014,
		0,
		Lang.get(106004),
		39906,
		14,
		865,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906015] = {
		39906015,
		0,
		Lang.get(106005),
		39906,
		15,
		865,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906016] = {
		39906016,
		0,
		Lang.get(106006),
		39906,
		16,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906017] = {
		39906017,
		0,
		Lang.get(106007),
		39906,
		17,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39906018] = {
		39906018,
		0,
		Lang.get(106008),
		39906,
		18,
		866,
		{
			RTResTalkAction[62],
			RTResTalkAction[60]
		}
	},
	[39906019] = {
		39906019,
		0,
		Lang.get(106009),
		39906,
		19,
		867,
		{
			RTResTalkAction[63]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39914,
		nil,
		1,
		nil,
		1,
		nil,
		39914
	},
	[39906020] = {
		39906020,
		0,
		Lang.get(106010),
		39906,
		20,
		868,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[39906021] = {
		39906021,
		0,
		Lang.get(106011),
		39906,
		21,
		868,
		{
			RTResTalkAction[64]
		}
	},
	[39906022] = {
		39906022,
		0,
		Lang.get(106012),
		39906,
		22,
		867,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		}
	},
	[39907001] = {
		39907001,
		0,
		Lang.get(106013),
		39907,
		1,
		867,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		39915,
		nil,
		1,
		nil,
		1,
		nil,
		39915
	},
	[39907002] = {
		39907002,
		0,
		Lang.get(106014),
		39907,
		2,
		868,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[39907003] = {
		39907003,
		0,
		Lang.get(106015),
		39907,
		3,
		868,
		{
			RTResTalkAction[64]
		}
	},
	[39907004] = {
		39907004,
		0,
		Lang.get(106016),
		39907,
		4,
		868,
		{
			RTResTalkAction[64]
		}
	},
	[39907005] = {
		39907005,
		0,
		Lang.get(106017),
		39907,
		5,
		868,
		{
			RTResTalkAction[64]
		}
	},
	[39907006] = {
		39907006,
		2,
		Lang.get(106018),
		39907,
		6,
		867,
		{
			RTResTalkAction[67],
			RTResTalkAction[68]
		}
	},
	[39907007] = {
		39907007,
		0,
		Lang.get(106019),
		39907,
		7,
		867,
		{
			RTResTalkAction[69]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39916,
		nil,
		1,
		nil,
		1,
		nil,
		39916
	},
	[39907008] = {
		39907008,
		0,
		Lang.get(106020),
		39907,
		8,
		867,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[39907009] = {
		39907009,
		0,
		Lang.get(106021),
		39907,
		9,
		869,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39907010] = {
		39907010,
		0,
		Lang.get(106022),
		39907,
		10,
		869,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39907011] = {
		39907011,
		0,
		Lang.get(106023),
		39907,
		11,
		869,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39907012] = {
		39907012,
		0,
		Lang.get(106024),
		39907,
		12,
		867,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39907013] = {
		39907013,
		0,
		Lang.get(106025),
		39907,
		13,
		869,
		{
			RTResTalkAction[71],
			RTResTalkAction[69]
		}
	},
	[39907014] = {
		39907014,
		0,
		Lang.get(106026),
		39907,
		14,
		605,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39964,
		nil,
		1,
		[19] = 39964,
		[17] = 1
	},
	[39907015] = {
		39907015,
		0,
		Lang.get(106027),
		39907,
		15,
		869,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[39907016] = {
		39907016,
		0,
		Lang.get(106028),
		39907,
		16,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39907017] = {
		39907017,
		0,
		Lang.get(106029),
		39907,
		17,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39907018] = {
		39907018,
		0,
		Lang.get(106030),
		39907,
		18,
		866,
		{
			RTResTalkAction[62],
			RTResTalkAction[72]
		}
	},
	[39907019] = {
		39907019,
		0,
		Lang.get(106031),
		39907,
		19,
		869,
		{
			RTResTalkAction[71],
			RTResTalkAction[63]
		}
	},
	[39907020] = {
		39907020,
		0,
		Lang.get(106032),
		39907,
		20,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39907021] = {
		39907021,
		0,
		Lang.get(106033),
		39907,
		21,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39907022] = {
		39907022,
		0,
		Lang.get(106034),
		39907,
		22,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39907023] = {
		39907023,
		0,
		Lang.get(106035),
		39907,
		23,
		869,
		{
			RTResTalkAction[73],
			RTResTalkAction[72]
		},
		1,
		[21] = 429
	},
	[39907024] = {
		39907024,
		0,
		Lang.get(106036),
		39907,
		24,
		866,
		{
			RTResTalkAction[62],
			RTResTalkAction[74]
		}
	},
	[39908001] = {
		39908001,
		0,
		Lang.get(106037),
		39908,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		132,
		39917,
		nil,
		1,
		nil,
		1,
		nil,
		39917
	},
	[39908002] = {
		39908002,
		0,
		Lang.get(106038),
		39908,
		2,
		870,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[39908003] = {
		39908003,
		0,
		Lang.get(106039),
		39908,
		3,
		870,
		{
			RTResTalkAction[75]
		}
	},
	[39908004] = {
		39908004,
		0,
		Lang.get(106040),
		39908,
		4,
		871,
		{
			RTResTalkAction[76],
			RTResTalkAction[77]
		}
	},
	[39908005] = {
		39908005,
		0,
		Lang.get(106041),
		39908,
		5,
		871,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39918,
		nil,
		1,
		nil,
		1,
		nil,
		39918
	},
	[39908006] = {
		39908006,
		0,
		Lang.get(106042),
		39908,
		6,
		871,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3
	},
	[39908007] = {
		39908007,
		0,
		Lang.get(106043),
		39908,
		7,
		869,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908008] = {
		39908008,
		0,
		Lang.get(106044),
		39908,
		8,
		871,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908009] = {
		39908009,
		0,
		Lang.get(106045),
		39908,
		9,
		869,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908010] = {
		39908010,
		0,
		Lang.get(106046),
		39908,
		10,
		871,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908011] = {
		39908011,
		0,
		Lang.get(106047),
		39908,
		11,
		871,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908012] = {
		39908012,
		0,
		Lang.get(106048),
		39908,
		12,
		869,
		{
			RTResTalkAction[81],
			RTResTalkAction[77]
		}
	},
	[39908013] = {
		39908013,
		0,
		Lang.get(106049),
		39908,
		13,
		869,
		{
			RTResTalkAction[71],
			RTResTalkAction[79]
		}
	},
	[39908014] = {
		39908014,
		0,
		Lang.get(106050),
		39908,
		14,
		605,
		{
			RTResTalkAction[72]
		}
	},
	[39908015] = {
		39908015,
		0,
		Lang.get(106051),
		39908,
		15,
		872,
		{
			RTResTalkAction[82]
		}
	},
	[39908016] = {
		39908016,
		0,
		Lang.get(106052),
		39908,
		16,
		872,
		{
			RTResTalkAction[83]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39919,
		nil,
		1,
		nil,
		1,
		nil,
		39919
	},
	[39908017] = {
		39908017,
		0,
		Lang.get(106053),
		39908,
		17,
		870,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[39909001] = {
		39909001,
		0,
		Lang.get(106054),
		39909,
		1,
		869,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		39920,
		nil,
		1,
		nil,
		1,
		nil,
		39920
	},
	[39909002] = {
		39909002,
		0,
		Lang.get(106055),
		39909,
		2,
		869,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[39909003] = {
		39909003,
		0,
		Lang.get(106056),
		39909,
		3,
		870,
		{
			RTResTalkAction[76],
			RTResTalkAction[70]
		}
	},
	[39909004] = {
		39909004,
		0,
		Lang.get(106057),
		39909,
		4,
		870,
		{
			RTResTalkAction[76],
			RTResTalkAction[70]
		}
	},
	[39909005] = {
		39909005,
		0,
		Lang.get(106058),
		39909,
		5,
		869,
		{
			RTResTalkAction[71],
			RTResTalkAction[78]
		}
	},
	[39909006] = {
		39909006,
		0,
		Lang.get(106059),
		39909,
		6,
		605,
		{
			RTResTalkAction[72]
		}
	},
	[39909007] = {
		39909007,
		0,
		Lang.get(106060),
		39909,
		7,
		870,
		{
			RTResTalkAction[73]
		},
		1,
		[21] = 429
	},
	[39909008] = {
		39909008,
		0,
		Lang.get(106061),
		39909,
		8,
		869,
		{
			RTResTalkAction[76],
			RTResTalkAction[70],
			RTResTalkAction[74]
		}
	},
	[39909009] = {
		39909009,
		0,
		Lang.get(106062),
		39909,
		9,
		872,
		{
			RTResTalkAction[78],
			RTResTalkAction[72]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39921,
		nil,
		1,
		nil,
		1,
		nil,
		39921
	},
	[39909010] = {
		39909010,
		0,
		Lang.get(106063),
		39909,
		10,
		870,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[39909011] = {
		39909011,
		0,
		Lang.get(106064),
		39909,
		11,
		872,
		{
			RTResTalkAction[76],
			RTResTalkAction[84]
		}
	},
	[39910001] = {
		39910001,
		0,
		Lang.get(106026),
		39910,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		132,
		39922,
		nil,
		1,
		nil,
		1,
		nil,
		39922
	},
	[39910002] = {
		39910002,
		0,
		Lang.get(106065),
		39910,
		2,
		865,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		3
	},
	[39910003] = {
		39910003,
		0,
		Lang.get(106066),
		39910,
		3,
		865,
		{
			RTResTalkAction[58]
		}
	},
	[39910004] = {
		39910004,
		0,
		Lang.get(106067),
		39910,
		4,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39910005] = {
		39910005,
		0,
		Lang.get(106068),
		39910,
		5,
		865,
		{
			RTResTalkAction[61],
			RTResTalkAction[57]
		}
	},
	[39910006] = {
		39910006,
		0,
		Lang.get(106069),
		39910,
		6,
		865,
		{
			RTResTalkAction[58],
			RTResTalkAction[63]
		}
	},
	[39910007] = {
		39910007,
		0,
		Lang.get(106070),
		39910,
		7,
		605,
		{
			RTResTalkAction[60]
		}
	},
	[39910008] = {
		39910008,
		0,
		Lang.get(106071),
		39910,
		8,
		872,
		{
			RTResTalkAction[82]
		}
	},
	[39910009] = {
		39910009,
		0,
		Lang.get(106072),
		39910,
		9,
		870,
		{
			RTResTalkAction[76],
			RTResTalkAction[84]
		}
	},
	[39910010] = {
		39910010,
		0,
		Lang.get(106073),
		39910,
		10,
		872,
		{
			RTResTalkAction[76],
			RTResTalkAction[84]
		}
	},
	[39910011] = {
		39910011,
		0,
		Lang.get(106074),
		39910,
		11,
		865,
		{
			RTResTalkAction[58],
			RTResTalkAction[78],
			RTResTalkAction[83]
		}
	},
	[39910012] = {
		39910012,
		0,
		Lang.get(106075),
		39910,
		12,
		872,
		{
			RTResTalkAction[82],
			RTResTalkAction[60]
		}
	},
	[39910013] = {
		39910013,
		0,
		Lang.get(106076),
		39910,
		13,
		866,
		{
			RTResTalkAction[62],
			RTResTalkAction[83]
		}
	},
	[39910014] = {
		39910014,
		0,
		Lang.get(106077),
		39910,
		14,
		866,
		{
			RTResTalkAction[62]
		}
	},
	[39910015] = {
		39910015,
		0,
		Lang.get(106078),
		39910,
		15,
		872,
		{
			RTResTalkAction[61],
			RTResTalkAction[84]
		}
	},
	[39910016] = {
		39910016,
		0,
		Lang.get(106079),
		39910,
		16,
		870,
		{
			RTResTalkAction[63],
			RTResTalkAction[83]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39923,
		nil,
		1,
		nil,
		1,
		nil,
		39923
	},
	[39910017] = {
		39910017,
		0,
		Lang.get(106080),
		39910,
		17,
		866,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39910018] = {
		39910018,
		0,
		Lang.get(106081),
		39910,
		18,
		872,
		{
			RTResTalkAction[61],
			RTResTalkAction[84]
		}
	},
	[39911001] = {
		39911001,
		0,
		Lang.get(106082),
		39911,
		1,
		872,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		39924,
		nil,
		1,
		nil,
		1,
		nil,
		39924
	},
	[39911002] = {
		39911002,
		0,
		Lang.get(106083),
		39911,
		2,
		866,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39911003] = {
		39911003,
		0,
		Lang.get(106084),
		39911,
		3,
		870,
		{
			RTResTalkAction[61],
			RTResTalkAction[85]
		}
	},
	[39911004] = {
		39911004,
		0,
		Lang.get(106085),
		39911,
		4,
		866,
		{
			RTResTalkAction[61],
			RTResTalkAction[85]
		}
	},
	[39911005] = {
		39911005,
		0,
		Lang.get(106086),
		39911,
		5,
		870,
		{
			RTResTalkAction[61],
			RTResTalkAction[85]
		}
	},
	[39911006] = {
		39911006,
		0,
		Lang.get(106087),
		39911,
		6,
		605,
		{
			RTResTalkAction[63],
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39925,
		nil,
		1,
		[19] = 39925,
		[17] = 1
	},
	[39912001] = {
		39912001,
		0,
		Lang.get(105991),
		39912,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		132,
		39926,
		nil,
		1,
		nil,
		1,
		nil,
		39926
	},
	[39912002] = {
		39912002,
		0,
		Lang.get(106088),
		39912,
		2,
		867,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3
	},
	[39912003] = {
		39912003,
		0,
		Lang.get(106089),
		39912,
		3,
		869,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39912004] = {
		39912004,
		0,
		Lang.get(106090),
		39912,
		4,
		867,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39912005] = {
		39912005,
		0,
		Lang.get(106091),
		39912,
		5,
		867,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39912006] = {
		39912006,
		0,
		Lang.get(106092),
		39912,
		6,
		869,
		{
			RTResTalkAction[65],
			RTResTalkAction[70]
		}
	},
	[39912007] = {
		39912007,
		2,
		Lang.get(106093),
		39912,
		7,
		869,
		{
			RTResTalkAction[71],
			RTResTalkAction[69]
		}
	},
	[39912008] = {
		39912008,
		0,
		Lang.get(106094),
		39912,
		8,
		869,
		{
			RTResTalkAction[72]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39927,
		nil,
		1,
		nil,
		1,
		nil,
		39927
	},
	[39912009] = {
		39912009,
		0,
		Lang.get(106095),
		39912,
		9,
		869,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[39912010] = {
		39912010,
		0,
		Lang.get(106096),
		39912,
		10,
		873,
		{
			RTResTalkAction[72]
		}
	},
	[39912011] = {
		39912011,
		0,
		Lang.get(106097),
		39912,
		11,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39912012] = {
		39912012,
		0,
		Lang.get(106098),
		39912,
		12,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39912013] = {
		39912013,
		0,
		Lang.get(106099),
		39912,
		13,
		873,
		{
			RTResTalkAction[72]
		}
	},
	[39912014] = {
		39912014,
		0,
		Lang.get(106100),
		39912,
		14,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39912015] = {
		39912015,
		0,
		Lang.get(106101),
		39912,
		15,
		869,
		{
			RTResTalkAction[72]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39928,
		nil,
		1,
		nil,
		1,
		nil,
		39928
	},
	[39912016] = {
		39912016,
		0,
		Lang.get(106102),
		39912,
		16,
		869,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[39912017] = {
		39912017,
		0,
		Lang.get(106103),
		39912,
		17,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39912018] = {
		39912018,
		0,
		Lang.get(106104),
		39912,
		18,
		869,
		{
			RTResTalkAction[71]
		}
	},
	[39912019] = {
		39912019,
		0,
		Lang.get(106105),
		39912,
		19,
		605,
		{
			RTResTalkAction[72]
		}
	},
	[39912020] = {
		39912020,
		0,
		Lang.get(106106),
		39912,
		20,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 39929,
		[17] = 1
	},
	[39912021] = {
		39912021,
		0,
		Lang.get(106107),
		39912,
		21,
		870,
		nil,
		1
	},
	[39912022] = {
		39912022,
		0,
		Lang.get(106108),
		39912,
		22,
		866,
		nil,
		1
	},
	[39912023] = {
		39912023,
		0,
		Lang.get(106109),
		39912,
		23,
		870,
		nil,
		1
	},
	[39912024] = {
		39912024,
		0,
		Lang.get(106110),
		39912,
		24,
		866,
		nil,
		1
	},
	[39912025] = {
		39912025,
		0,
		Lang.get(106111),
		39912,
		25,
		872,
		nil,
		1
	},
	[39912026] = {
		39912026,
		0,
		Lang.get(106112),
		39912,
		26,
		868,
		nil,
		1
	},
	[39912027] = {
		39912027,
		0,
		Lang.get(106113),
		39912,
		27,
		868,
		nil,
		1
	},
	[39913001] = {
		39913001,
		0,
		Lang.get(106114),
		39913,
		1,
		292,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		39930,
		nil,
		1,
		nil,
		1,
		nil,
		39930
	},
	[39913002] = {
		39913002,
		0,
		Lang.get(106115),
		39913,
		2,
		1112,
		{
			RTResTalkAction[86]
		},
		nil,
		0,
		3
	},
	[39913003] = {
		39913003,
		0,
		Lang.get(106116),
		39913,
		3,
		1026,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[39913004] = {
		39913004,
		0,
		Lang.get(106117),
		39913,
		4,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[89]
		}
	},
	[39913005] = {
		39913005,
		0,
		Lang.get(106118),
		39913,
		5,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[7]
		}
	},
	[39913006] = {
		39913006,
		0,
		Lang.get(106119),
		39913,
		6,
		158,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		}
	},
	[39913007] = {
		39913007,
		0,
		Lang.get(106120),
		39913,
		7,
		292,
		{
			RTResTalkAction[6]
		},
		1,
		2,
		nil,
		nil,
		nil,
		39931,
		nil,
		1,
		nil,
		1,
		nil,
		39931
	},
	[39913008] = {
		39913008,
		0,
		Lang.get(106121),
		39913,
		8,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		0,
		3
	},
	[39913009] = {
		39913009,
		0,
		Lang.get(106122),
		39913,
		9,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[90]
		}
	},
	[39913010] = {
		39913010,
		0,
		Lang.get(106123),
		39913,
		10,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39913011] = {
		39913011,
		0,
		Lang.get(106124),
		39913,
		11,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[26]
		}
	},
	[39913012] = {
		39913012,
		0,
		Lang.get(106125),
		39913,
		12,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39913013] = {
		39913013,
		0,
		Lang.get(106126),
		39913,
		13,
		874,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		},
		1,
		0,
		nil,
		nil,
		nil,
		39932,
		nil,
		1,
		nil,
		1,
		nil,
		39932
	},
	[39913014] = {
		39913014,
		0,
		Lang.get(106127),
		39913,
		14,
		874,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[39913015] = {
		39913015,
		0,
		Lang.get(106128),
		39913,
		15,
		875,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39913016] = {
		39913016,
		0,
		Lang.get(106129),
		39913,
		16,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[39913017] = {
		39913017,
		0,
		Lang.get(106130),
		39913,
		17,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[26]
		}
	},
	[39913018] = {
		39913018,
		0,
		Lang.get(106131),
		39913,
		18,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39913019] = {
		39913019,
		0,
		Lang.get(106132),
		39913,
		19,
		292,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[39913020] = {
		39913020,
		0,
		Lang.get(106133),
		39913,
		20,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39914001] = {
		39914001,
		0,
		Lang.get(106134),
		39914,
		1,
		292,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		39965,
		nil,
		1,
		nil,
		1,
		nil,
		39965
	},
	[39914002] = {
		39914002,
		0,
		Lang.get(106135),
		39914,
		2,
		874,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[39914003] = {
		39914003,
		0,
		Lang.get(106136),
		39914,
		3,
		875,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39914004] = {
		39914004,
		0,
		Lang.get(106137),
		39914,
		4,
		875,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39914005] = {
		39914005,
		0,
		Lang.get(106138),
		39914,
		5,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[39914006] = {
		39914006,
		0,
		Lang.get(106139),
		39914,
		6,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39914007] = {
		39914007,
		0,
		Lang.get(106140),
		39914,
		7,
		875,
		{
			RTResTalkAction[96],
			RTResTalkAction[26]
		}
	},
	[39914008] = {
		39914008,
		0,
		Lang.get(106141),
		39914,
		8,
		874,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39914009] = {
		39914009,
		0,
		Lang.get(106142),
		39914,
		9,
		605,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39933,
		nil,
		1,
		[19] = 39933,
		[17] = 1
	},
	[39914010] = {
		39914010,
		0,
		Lang.get(106143),
		39914,
		10,
		292,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[39914011] = {
		39914011,
		0,
		Lang.get(106144),
		39914,
		11,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39914012] = {
		39914012,
		0,
		Lang.get(106145),
		39914,
		12,
		874,
		{
			RTResTalkAction[91],
			RTResTalkAction[26]
		}
	},
	[39914013] = {
		39914013,
		0,
		Lang.get(106146),
		39914,
		13,
		874,
		{
			RTResTalkAction[91]
		}
	},
	[39914014] = {
		39914014,
		0,
		Lang.get(106147),
		39914,
		14,
		1268,
		{
			RTResTalkAction[94]
		},
		1,
		2,
		nil,
		nil,
		nil,
		39934,
		nil,
		1,
		nil,
		1,
		nil,
		39934
	},
	[39914015] = {
		39914015,
		0,
		Lang.get(106148),
		39914,
		15,
		1268,
		{
			RTResTalkAction[97]
		},
		nil,
		0,
		3
	},
	[39914016] = {
		39914016,
		0,
		Lang.get(106149),
		39914,
		16,
		292,
		{
			RTResTalkAction[98],
			RTResTalkAction[99]
		}
	},
	[39914017] = {
		39914017,
		0,
		Lang.get(106150),
		39914,
		17,
		874,
		{
			RTResTalkAction[91],
			RTResTalkAction[41],
			RTResTalkAction[26]
		}
	},
	[39914018] = {
		39914018,
		0,
		Lang.get(106151),
		39914,
		18,
		875,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39914019] = {
		39914019,
		2,
		Lang.get(106152),
		39914,
		19,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[39914020] = {
		39914020,
		2,
		Lang.get(106153),
		39914,
		20,
		1268,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[39915001] = {
		39915001,
		0,
		Lang.get(106154),
		39915,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		39935,
		nil,
		1,
		nil,
		1,
		nil,
		39935
	},
	[39915002] = {
		39915002,
		0,
		Lang.get(106155),
		39915,
		2,
		1268,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[39915003] = {
		39915003,
		0,
		Lang.get(106156),
		39915,
		3,
		1266,
		{
			RTResTalkAction[100],
			RTResTalkAction[41]
		}
	},
	[39915004] = {
		39915004,
		0,
		Lang.get(106157),
		39915,
		4,
		1266,
		{
			RTResTalkAction[101]
		}
	},
	[39915005] = {
		39915005,
		0,
		Lang.get(106158),
		39915,
		5,
		605,
		{
			RTResTalkAction[102]
		}
	},
	[39915006] = {
		39915006,
		0,
		Lang.get(106159),
		39915,
		6,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39915007] = {
		39915007,
		0,
		Lang.get(106160),
		39915,
		7,
		1268,
		{
			RTResTalkAction[103],
			RTResTalkAction[90]
		}
	},
	[39915008] = {
		39915008,
		0,
		Lang.get(106161),
		39915,
		8,
		1266,
		{
			RTResTalkAction[100],
			RTResTalkAction[26],
			RTResTalkAction[41]
		}
	},
	[39915009] = {
		39915009,
		0,
		Lang.get(106162),
		39915,
		9,
		1266,
		{
			RTResTalkAction[104]
		}
	},
	[39915010] = {
		39915010,
		0,
		Lang.get(106163),
		39915,
		10,
		1268,
		{
			RTResTalkAction[97],
			RTResTalkAction[102]
		}
	},
	[39915011] = {
		39915011,
		0,
		Lang.get(106164),
		39915,
		11,
		292,
		{
			RTResTalkAction[103],
			RTResTalkAction[43]
		}
	},
	[39915012] = {
		39915012,
		0,
		Lang.get(106165),
		39915,
		12,
		605,
		{
			RTResTalkAction[26],
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39936,
		nil,
		1,
		[19] = 39936,
		[17] = 1
	},
	[39915013] = {
		39915013,
		0,
		Lang.get(106166),
		39915,
		13,
		1195,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[39915014] = {
		39915014,
		0,
		Lang.get(106167),
		39915,
		14,
		1195,
		{
			RTResTalkAction[106]
		}
	},
	[39915015] = {
		39915015,
		0,
		Lang.get(106168),
		39915,
		15,
		1266,
		{
			RTResTalkAction[107],
			RTResTalkAction[108]
		}
	},
	[39915016] = {
		39915016,
		0,
		Lang.get(106169),
		39915,
		16,
		1195,
		{
			RTResTalkAction[109],
			RTResTalkAction[102]
		}
	},
	[39915017] = {
		39915017,
		0,
		Lang.get(106170),
		39915,
		17,
		1195,
		{
			RTResTalkAction[106]
		}
	},
	[39915018] = {
		39915018,
		0,
		Lang.get(106171),
		39915,
		18,
		1266,
		{
			RTResTalkAction[110],
			RTResTalkAction[108]
		}
	},
	[39915019] = {
		39915019,
		0,
		Lang.get(106172),
		39915,
		19,
		1195,
		{
			RTResTalkAction[111],
			RTResTalkAction[102]
		}
	},
	[39916001] = {
		39916001,
		0,
		Lang.get(106173),
		39916,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		39937,
		nil,
		1,
		nil,
		1,
		nil,
		39937
	},
	[39916002] = {
		39916002,
		0,
		Lang.get(106174),
		39916,
		2,
		1266,
		{
			RTResTalkAction[107]
		},
		nil,
		nil,
		3
	},
	[39916003] = {
		39916003,
		0,
		Lang.get(106162),
		39916,
		3,
		1266,
		{
			RTResTalkAction[104]
		}
	},
	[39916004] = {
		39916004,
		0,
		Lang.get(106175),
		39916,
		4,
		1195,
		{
			RTResTalkAction[105],
			RTResTalkAction[102]
		}
	},
	[39916005] = {
		39916005,
		0,
		Lang.get(106176),
		39916,
		5,
		1195,
		{
			RTResTalkAction[106]
		}
	},
	[39916006] = {
		39916006,
		0,
		Lang.get(106177),
		39916,
		6,
		1268,
		{
			RTResTalkAction[49],
			RTResTalkAction[108]
		}
	},
	[39916007] = {
		39916007,
		0,
		Lang.get(106178),
		39916,
		7,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39916008] = {
		39916008,
		0,
		Lang.get(106179),
		39916,
		8,
		605,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39938,
		nil,
		1,
		[19] = 39938,
		[17] = 1
	},
	[39916009] = {
		39916009,
		0,
		Lang.get(106180),
		39916,
		9,
		292,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[39916010] = {
		39916010,
		0,
		Lang.get(106181),
		39916,
		10,
		1268,
		{
			RTResTalkAction[103],
			RTResTalkAction[112]
		}
	},
	[39916011] = {
		39916011,
		0,
		Lang.get(106182),
		39916,
		11,
		1268,
		{
			RTResTalkAction[40],
			RTResTalkAction[26]
		}
	},
	[39916012] = {
		39916012,
		0,
		Lang.get(106183),
		39916,
		12,
		1266,
		{
			RTResTalkAction[98],
			RTResTalkAction[113]
		}
	},
	[39916013] = {
		39916013,
		0,
		Lang.get(106184),
		39916,
		13,
		605,
		{
			RTResTalkAction[41],
			RTResTalkAction[102]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39939,
		nil,
		1,
		[19] = 39939,
		[17] = 1
	},
	[39916014] = {
		39916014,
		0,
		Lang.get(106185),
		39916,
		14,
		1195,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3
	},
	[39916015] = {
		39916015,
		0,
		Lang.get(106186),
		39916,
		15,
		1266,
		{
			RTResTalkAction[114],
			RTResTalkAction[115]
		}
	},
	[39916016] = {
		39916016,
		0,
		Lang.get(106187),
		39916,
		16,
		1268,
		{
			RTResTalkAction[116],
			RTResTalkAction[108],
			RTResTalkAction[102]
		}
	},
	[39916017] = {
		39916017,
		0,
		Lang.get(106188),
		39916,
		17,
		292,
		{
			RTResTalkAction[103],
			RTResTalkAction[43]
		}
	},
	[39916018] = {
		39916018,
		0,
		Lang.get(106189),
		39916,
		18,
		1268,
		{
			RTResTalkAction[103],
			RTResTalkAction[43]
		}
	},
	[39916019] = {
		39916019,
		0,
		Lang.get(106190),
		39916,
		19,
		292,
		{
			RTResTalkAction[117],
			RTResTalkAction[43]
		}
	},
	[39916020] = {
		39916020,
		0,
		Lang.get(106186),
		39916,
		20,
		1266,
		{
			RTResTalkAction[118],
			RTResTalkAction[26],
			RTResTalkAction[41]
		}
	},
	[39917001] = {
		39917001,
		0,
		Lang.get(106191),
		39917,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		39940,
		nil,
		1,
		nil,
		1,
		nil,
		39940
	},
	[39917002] = {
		39917002,
		0,
		Lang.get(106192),
		39917,
		2,
		1266,
		{
			RTResTalkAction[118]
		},
		nil,
		nil,
		3
	},
	[39917003] = {
		39917003,
		0,
		Lang.get(106193),
		39917,
		3,
		1268,
		{
			RTResTalkAction[98],
			RTResTalkAction[119]
		}
	},
	[39917004] = {
		39917004,
		0,
		Lang.get(106194),
		39917,
		4,
		1268,
		{
			RTResTalkAction[98],
			RTResTalkAction[119]
		}
	},
	[39917005] = {
		39917005,
		0,
		Lang.get(106168),
		39917,
		5,
		1266,
		{
			RTResTalkAction[98],
			RTResTalkAction[119]
		}
	},
	[39917006] = {
		39917006,
		0,
		Lang.get(106195),
		39917,
		6,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[41],
			RTResTalkAction[102]
		}
	},
	[39917007] = {
		39917007,
		0,
		Lang.get(106196),
		39917,
		7,
		1266,
		{
			RTResTalkAction[104],
			RTResTalkAction[26]
		}
	},
	[39917008] = {
		39917008,
		0,
		Lang.get(106197),
		39917,
		8,
		1266,
		{
			RTResTalkAction[104]
		}
	},
	[39917009] = {
		39917009,
		0,
		Lang.get(106198),
		39917,
		9,
		292,
		{
			RTResTalkAction[120],
			RTResTalkAction[102]
		}
	},
	[39917010] = {
		39917010,
		0,
		Lang.get(106199),
		39917,
		10,
		1267,
		{
			RTResTalkAction[37],
			RTResTalkAction[26]
		}
	},
	[39917011] = {
		39917011,
		0,
		Lang.get(106200),
		39917,
		11,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39917012] = {
		39917012,
		0,
		Lang.get(106201),
		39917,
		12,
		292,
		{
			RTResTalkAction[39]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39941,
		nil,
		1,
		nil,
		1,
		nil,
		39941
	},
	[39917013] = {
		39917013,
		0,
		Lang.get(106202),
		39917,
		13,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[39917014] = {
		39917014,
		0,
		Lang.get(106203),
		39917,
		14,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39917015] = {
		39917015,
		0,
		Lang.get(106204),
		39917,
		15,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39917016] = {
		39917016,
		0,
		Lang.get(106205),
		39917,
		16,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39917017] = {
		39917017,
		0,
		Lang.get(106206),
		39917,
		17,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[52]
		}
	},
	[39917018] = {
		39917018,
		0,
		Lang.get(106207),
		39917,
		18,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39917019] = {
		39917019,
		0,
		Lang.get(106208),
		39917,
		19,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[26]
		}
	},
	[39918001] = {
		39918001,
		0,
		Lang.get(106209),
		39918,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		39942,
		nil,
		1,
		nil,
		1,
		nil,
		39942
	},
	[39918002] = {
		39918002,
		0,
		Lang.get(106210),
		39918,
		2,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[39918003] = {
		39918003,
		0,
		Lang.get(106211),
		39918,
		3,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39918004] = {
		39918004,
		0,
		Lang.get(106212),
		39918,
		4,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39918005] = {
		39918005,
		0,
		Lang.get(106213),
		39918,
		5,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[39]
		}
	},
	[39918006] = {
		39918006,
		0,
		Lang.get(106214),
		39918,
		6,
		300,
		{
			RTResTalkAction[26]
		}
	},
	[39918007] = {
		39918007,
		0,
		Lang.get(106215),
		39918,
		7,
		195,
		{
			RTResTalkAction[21]
		}
	},
	[39918008] = {
		39918008,
		0,
		Lang.get(106216),
		39918,
		8,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		}
	},
	[39918009] = {
		39918009,
		0,
		Lang.get(106217),
		39918,
		9,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[6]
		}
	},
	[39918010] = {
		39918010,
		0,
		Lang.get(106218),
		39918,
		10,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[52]
		}
	},
	[39918011] = {
		39918011,
		0,
		Lang.get(106219),
		39918,
		11,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		},
		1,
		11,
		nil,
		nil,
		nil,
		39943,
		nil,
		1,
		nil,
		1,
		nil,
		39943
	},
	[39918012] = {
		39918012,
		0,
		Lang.get(106220),
		39918,
		12,
		107,
		{
			RTResTalkAction[121]
		},
		nil,
		0,
		3
	},
	[39918013] = {
		39918013,
		0,
		Lang.get(106221),
		39918,
		13,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[99]
		}
	},
	[39918014] = {
		39918014,
		0,
		Lang.get(106222),
		39918,
		14,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[7]
		}
	},
	[39918015] = {
		39918015,
		0,
		Lang.get(106223),
		39918,
		15,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[26]
		}
	},
	[39918016] = {
		39918016,
		0,
		Lang.get(106224),
		39918,
		16,
		158,
		{
			RTResTalkAction[13]
		}
	},
	[39918017] = {
		39918017,
		0,
		Lang.get(106225),
		39918,
		17,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[6]
		}
	},
	[39918018] = {
		39918018,
		0,
		Lang.get(106226),
		39918,
		18,
		1267,
		{
			RTResTalkAction[37],
			RTResTalkAction[23]
		}
	},
	[39918019] = {
		39918019,
		0,
		Lang.get(106227),
		39918,
		19,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39919001] = {
		39919001,
		0,
		Lang.get(106228),
		39919,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		39944,
		nil,
		1,
		nil,
		1,
		nil,
		39944
	},
	[39919002] = {
		39919002,
		0,
		Lang.get(106229),
		39919,
		2,
		107,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		3
	},
	[39919003] = {
		39919003,
		0,
		Lang.get(106230),
		39919,
		3,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39919004] = {
		39919004,
		0,
		Lang.get(106231),
		39919,
		4,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[99]
		}
	},
	[39919005] = {
		39919005,
		0,
		Lang.get(106232),
		39919,
		5,
		874,
		{
			RTResTalkAction[91],
			RTResTalkAction[7],
			RTResTalkAction[26]
		}
	},
	[39919006] = {
		39919006,
		0,
		Lang.get(106233),
		39919,
		6,
		875,
		{
			RTResTalkAction[92],
			RTResTalkAction[93]
		}
	},
	[39919007] = {
		39919007,
		0,
		Lang.get(106234),
		39919,
		7,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[39919008] = {
		39919008,
		0,
		Lang.get(106235),
		39919,
		8,
		158,
		{
			RTResTalkAction[10],
			RTResTalkAction[26]
		}
	},
	[39919009] = {
		39919009,
		0,
		Lang.get(106236),
		39919,
		9,
		107,
		{
			RTResTalkAction[121],
			RTResTalkAction[6]
		}
	},
	[39919010] = {
		39919010,
		0,
		Lang.get(106237),
		39919,
		10,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39945,
		nil,
		1,
		[19] = 39945,
		[17] = 1
	},
	[39919011] = {
		39919011,
		0,
		Lang.get(106238),
		39919,
		11,
		1268,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[39919012] = {
		39919012,
		0,
		Lang.get(106239),
		39919,
		12,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39919013] = {
		39919013,
		0,
		Lang.get(106240),
		39919,
		13,
		1267,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[39919014] = {
		39919014,
		0,
		Lang.get(106241),
		39919,
		14,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39919015] = {
		39919015,
		0,
		Lang.get(106242),
		39919,
		15,
		1266,
		{
			RTResTalkAction[107],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39919016] = {
		39919016,
		0,
		Lang.get(106243),
		39919,
		16,
		1267,
		{
			RTResTalkAction[37],
			RTResTalkAction[102]
		}
	},
	[39919017] = {
		39919017,
		0,
		Lang.get(106244),
		39919,
		17,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[52]
		}
	},
	[39919018] = {
		39919018,
		0,
		Lang.get(106245),
		39919,
		18,
		1266,
		{
			RTResTalkAction[107],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39919019] = {
		39919019,
		0,
		Lang.get(106246),
		39919,
		19,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[102]
		}
	},
	[39919020] = {
		39919020,
		0,
		Lang.get(106247),
		39919,
		20,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39919021] = {
		39919021,
		0,
		Lang.get(106248),
		39919,
		21,
		1268,
		{
			RTResTalkAction[40],
			RTResTalkAction[39]
		}
	},
	[39920001] = {
		39920001,
		0,
		Lang.get(106249),
		39920,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		39946,
		nil,
		1,
		nil,
		1,
		nil,
		39946
	},
	[39920002] = {
		39920002,
		0,
		Lang.get(106250),
		39920,
		2,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[39920003] = {
		39920003,
		0,
		Lang.get(106186),
		39920,
		3,
		1266,
		{
			RTResTalkAction[44],
			RTResTalkAction[122]
		}
	},
	[39920004] = {
		39920004,
		0,
		Lang.get(106251),
		39920,
		4,
		1268,
		{
			RTResTalkAction[49],
			RTResTalkAction[39],
			RTResTalkAction[102]
		}
	},
	[39920005] = {
		39920005,
		0,
		Lang.get(106252),
		39920,
		5,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39920006] = {
		39920006,
		0,
		Lang.get(106253),
		39920,
		6,
		1266,
		{
			RTResTalkAction[98],
			RTResTalkAction[119]
		}
	},
	[39920007] = {
		39920007,
		0,
		Lang.get(106254),
		39920,
		7,
		1266,
		{
			RTResTalkAction[98],
			RTResTalkAction[119]
		}
	},
	[39920008] = {
		39920008,
		0,
		Lang.get(106255),
		39920,
		8,
		1268,
		{
			RTResTalkAction[123],
			RTResTalkAction[119]
		}
	},
	[39920009] = {
		39920009,
		0,
		Lang.get(106256),
		39920,
		9,
		1267,
		{
			RTResTalkAction[37],
			RTResTalkAction[41],
			RTResTalkAction[102]
		}
	},
	[39920010] = {
		39920010,
		0,
		Lang.get(106257),
		39920,
		10,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39920011] = {
		39920011,
		0,
		Lang.get(106258),
		39920,
		11,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[90]
		}
	},
	[39920012] = {
		39920012,
		0,
		Lang.get(106259),
		39920,
		12,
		107,
		{
			RTResTalkAction[121],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39920013] = {
		39920013,
		0,
		Lang.get(106260),
		39920,
		13,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39947,
		nil,
		1,
		[19] = 39947,
		[17] = 1
	},
	[39920014] = {
		39920014,
		0,
		Lang.get(106261),
		39920,
		14,
		1268,
		{
			RTResTalkAction[97]
		},
		nil,
		nil,
		3
	},
	[39920015] = {
		39920015,
		0,
		Lang.get(106262),
		39920,
		15,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39920016] = {
		39920016,
		0,
		Lang.get(106263),
		39920,
		16,
		1266,
		{
			RTResTalkAction[98],
			RTResTalkAction[113]
		}
	},
	[39920017] = {
		39920017,
		0,
		Lang.get(106264),
		39920,
		17,
		300,
		{
			RTResTalkAction[41],
			RTResTalkAction[102]
		}
	},
	[39920018] = {
		39920018,
		0,
		Lang.get(106265),
		39920,
		18,
		1268,
		{
			RTResTalkAction[97]
		}
	},
	[39920019] = {
		39920019,
		0,
		Lang.get(106266),
		39920,
		19,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39920020] = {
		39920020,
		0,
		Lang.get(106267),
		39920,
		20,
		300,
		{
			RTResTalkAction[41]
		}
	},
	[39920021] = {
		39920021,
		0,
		Lang.get(106268),
		39920,
		21,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39921001] = {
		39921001,
		0,
		Lang.get(106269),
		39921,
		1,
		1268,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		39948
	},
	[39921002] = {
		39921002,
		0,
		Lang.get(106270),
		39921,
		2,
		1267,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[39921003] = {
		39921003,
		0,
		Lang.get(106271),
		39921,
		3,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39921004] = {
		39921004,
		0,
		Lang.get(106272),
		39921,
		4,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921005] = {
		39921005,
		0,
		Lang.get(106273),
		39921,
		5,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921006] = {
		39921006,
		0,
		Lang.get(106274),
		39921,
		6,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921007] = {
		39921007,
		0,
		Lang.get(106275),
		39921,
		7,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921008] = {
		39921008,
		0,
		Lang.get(106276),
		39921,
		8,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921009] = {
		39921009,
		0,
		Lang.get(106277),
		39921,
		9,
		1267,
		{
			RTResTalkAction[124],
			RTResTalkAction[43]
		}
	},
	[39921010] = {
		39921010,
		0,
		Lang.get(106278),
		39921,
		10,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[41]
		}
	},
	[39921011] = {
		39921011,
		0,
		Lang.get(106279),
		39921,
		11,
		605,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 39949,
		[17] = 1
	},
	[39921012] = {
		39921012,
		0,
		Lang.get(106280),
		39921,
		12,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[39921013] = {
		39921013,
		0,
		Lang.get(106281),
		39921,
		13,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921014] = {
		39921014,
		0,
		Lang.get(106282),
		39921,
		14,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921015] = {
		39921015,
		0,
		Lang.get(106283),
		39921,
		15,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921016] = {
		39921016,
		0,
		Lang.get(106284),
		39921,
		16,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921017] = {
		39921017,
		0,
		Lang.get(106285),
		39921,
		17,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921018] = {
		39921018,
		0,
		Lang.get(106286),
		39921,
		18,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921019] = {
		39921019,
		0,
		Lang.get(106287),
		39921,
		19,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39921020] = {
		39921020,
		0,
		Lang.get(106288),
		39921,
		20,
		1268,
		{
			RTResTalkAction[40],
			RTResTalkAction[39]
		}
	},
	[39922001] = {
		39922001,
		0,
		Lang.get(106209),
		39922,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39950,
		nil,
		1,
		nil,
		1,
		nil,
		39950
	},
	[39922002] = {
		39922002,
		0,
		Lang.get(106289),
		39922,
		2,
		107,
		{
			RTResTalkAction[125]
		},
		nil,
		nil,
		3
	},
	[39922003] = {
		39922003,
		0,
		Lang.get(106290),
		39922,
		3,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39922004] = {
		39922004,
		0,
		Lang.get(106291),
		39922,
		4,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[39922005] = {
		39922005,
		0,
		Lang.get(106292),
		39922,
		5,
		300
	},
	[39922006] = {
		39922006,
		0,
		Lang.get(106293),
		39922,
		6,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39922007] = {
		39922007,
		0,
		Lang.get(106294),
		39922,
		7,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39922008] = {
		39922008,
		0,
		Lang.get(106295),
		39922,
		8,
		158,
		{
			RTResTalkAction[126],
			RTResTalkAction[26]
		}
	},
	[39922009] = {
		39922009,
		0,
		Lang.get(106296),
		39922,
		9,
		195,
		{
			RTResTalkAction[21],
			RTResTalkAction[6]
		}
	},
	[39922010] = {
		39922010,
		0,
		Lang.get(106297),
		39922,
		10,
		107,
		{
			RTResTalkAction[127],
			RTResTalkAction[23]
		}
	},
	[39922011] = {
		39922011,
		0,
		Lang.get(106298),
		39922,
		11,
		605,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39951,
		nil,
		1,
		[19] = 39951,
		[17] = 1
	},
	[39922012] = {
		39922012,
		0,
		Lang.get(106299),
		39922,
		12,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[39922013] = {
		39922013,
		0,
		Lang.get(106300),
		39922,
		13,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39922014] = {
		39922014,
		0,
		Lang.get(106301),
		39922,
		14,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39922015] = {
		39922015,
		0,
		Lang.get(106302),
		39922,
		15,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39922016] = {
		39922016,
		0,
		Lang.get(106303),
		39922,
		16,
		1267,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39922017] = {
		39922017,
		0,
		Lang.get(106304),
		39922,
		17,
		300,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39922018] = {
		39922018,
		0,
		Lang.get(106305),
		39922,
		18,
		107,
		{
			RTResTalkAction[14]
		}
	},
	[39922019] = {
		39922019,
		0,
		Lang.get(106306),
		39922,
		19,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[7]
		}
	},
	[39922020] = {
		39922020,
		2,
		Lang.get(106307),
		39922,
		20,
		107,
		{
			RTResTalkAction[128],
			RTResTalkAction[26]
		}
	},
	[39923001] = {
		39923001,
		0,
		Lang.get(106209),
		39923,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39952,
		nil,
		1,
		nil,
		1,
		nil,
		39952
	},
	[39923002] = {
		39923002,
		0,
		Lang.get(106308),
		39923,
		2,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[39923003] = {
		39923003,
		0,
		Lang.get(106309),
		39923,
		3,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[39923004] = {
		39923004,
		0,
		Lang.get(106310),
		39923,
		4,
		141,
		{
			RTResTalkAction[16],
			RTResTalkAction[129]
		}
	},
	[39923005] = {
		39923005,
		0,
		Lang.get(106311),
		39923,
		5,
		141,
		{
			RTResTalkAction[16],
			RTResTalkAction[130]
		}
	},
	[39923006] = {
		39923006,
		0,
		Lang.get(106312),
		39923,
		6,
		198,
		{
			RTResTalkAction[29],
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[39923007] = {
		39923007,
		0,
		Lang.get(106313),
		39923,
		7,
		198,
		{
			RTResTalkAction[131]
		}
	},
	[39923008] = {
		39923008,
		0,
		Lang.get(106314),
		39923,
		8,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[132]
		}
	},
	[39923009] = {
		39923009,
		0,
		Lang.get(106315),
		39923,
		9,
		107,
		{
			RTResTalkAction[31],
			RTResTalkAction[3]
		}
	},
	[39923010] = {
		39923010,
		0,
		Lang.get(106316),
		39923,
		10,
		198,
		{
			RTResTalkAction[133],
			RTResTalkAction[3]
		}
	},
	[39923011] = {
		39923011,
		0,
		Lang.get(106317),
		39923,
		11,
		198,
		{
			RTResTalkAction[134],
			RTResTalkAction[7]
		}
	},
	[39923012] = {
		39923012,
		0,
		Lang.get(106318),
		39923,
		12,
		1195,
		{
			RTResTalkAction[33]
		},
		1,
		2,
		nil,
		nil,
		nil,
		39953,
		nil,
		1,
		nil,
		1,
		nil,
		39953
	},
	[39923013] = {
		39923013,
		0,
		Lang.get(106319),
		39923,
		13,
		1195,
		{
			RTResTalkAction[105]
		},
		nil,
		0,
		3
	},
	[39923014] = {
		39923014,
		0,
		Lang.get(106320),
		39923,
		14,
		216,
		{
			RTResTalkAction[114],
			RTResTalkAction[32]
		}
	},
	[39923015] = {
		39923015,
		0,
		Lang.get(106321),
		39923,
		15,
		216,
		{
			RTResTalkAction[135],
			RTResTalkAction[108]
		}
	},
	[39923016] = {
		39923016,
		0,
		Lang.get(106253),
		39923,
		16,
		1266,
		{
			RTResTalkAction[100],
			RTResTalkAction[34]
		}
	},
	[39923017] = {
		39923017,
		0,
		Lang.get(106322),
		39923,
		17,
		1266,
		{
			RTResTalkAction[110]
		}
	},
	[39923018] = {
		39923018,
		0,
		Lang.get(106323),
		39923,
		18,
		1195,
		{
			RTResTalkAction[109],
			RTResTalkAction[102]
		}
	},
	[39923019] = {
		39923019,
		0,
		Lang.get(106324),
		39923,
		19,
		1268,
		{
			RTResTalkAction[49],
			RTResTalkAction[108]
		}
	},
	[39923020] = {
		39923020,
		0,
		Lang.get(106325),
		39923,
		20,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39924001] = {
		39924001,
		0,
		Lang.get(106326),
		39924,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39954,
		nil,
		1,
		nil,
		1,
		nil,
		39954
	},
	[39924002] = {
		39924002,
		0,
		Lang.get(106327),
		39924,
		2,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[39924003] = {
		39924003,
		0,
		Lang.get(106328),
		39924,
		3,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[39924004] = {
		39924004,
		0,
		Lang.get(106329),
		39924,
		4,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[7]
		}
	},
	[39924005] = {
		39924005,
		0,
		Lang.get(106330),
		39924,
		5,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39924006] = {
		39924006,
		0,
		Lang.get(106331),
		39924,
		6,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39924007] = {
		39924007,
		0,
		Lang.get(106332),
		39924,
		7,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39924008] = {
		39924008,
		0,
		Lang.get(106333),
		39924,
		8,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39924009] = {
		39924009,
		0,
		Lang.get(106334),
		39924,
		9,
		107,
		{
			RTResTalkAction[7]
		},
		1,
		7,
		nil,
		nil,
		nil,
		39955,
		nil,
		1,
		nil,
		1,
		nil,
		39955
	},
	[39924010] = {
		39924010,
		0,
		Lang.get(106335),
		39924,
		10,
		158,
		{
			RTResTalkAction[136]
		},
		nil,
		0,
		3
	},
	[39924011] = {
		39924011,
		0,
		Lang.get(106336),
		39924,
		11,
		1071,
		{
			RTResTalkAction[137],
			RTResTalkAction[6]
		}
	},
	[39924012] = {
		39924012,
		0,
		Lang.get(106337),
		39924,
		12,
		1071,
		{
			RTResTalkAction[138]
		}
	},
	[39924013] = {
		39924013,
		0,
		Lang.get(106338),
		39924,
		13,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[139]
		}
	},
	[39924014] = {
		39924014,
		0,
		Lang.get(106339),
		39924,
		14,
		605,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39956,
		nil,
		1,
		[19] = 39956,
		[17] = 1
	},
	[39924015] = {
		39924015,
		0,
		Lang.get(106340),
		39924,
		15,
		1267,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[39924016] = {
		39924016,
		0,
		Lang.get(106341),
		39924,
		16,
		107,
		{
			RTResTalkAction[140],
			RTResTalkAction[141]
		}
	},
	[39924017] = {
		39924017,
		0,
		Lang.get(106342),
		39924,
		17,
		605,
		{
			RTResTalkAction[7],
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39957,
		nil,
		1,
		[19] = 39957,
		[17] = 1
	},
	[39924018] = {
		39924018,
		0,
		Lang.get(106343),
		39924,
		18,
		158,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[39924019] = {
		39924019,
		0,
		Lang.get(106344),
		39924,
		19,
		158,
		{
			RTResTalkAction[13]
		}
	},
	[39924020] = {
		39924020,
		0,
		Lang.get(106345),
		39924,
		20,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[6]
		}
	},
	[39924021] = {
		39924021,
		0,
		Lang.get(106346),
		39924,
		21,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[39924022] = {
		39924022,
		0,
		Lang.get(106347),
		39924,
		22,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[99]
		}
	},
	[39925001] = {
		39925001,
		0,
		Lang.get(106348),
		39925,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		39958,
		nil,
		1,
		nil,
		1,
		nil,
		39958
	},
	[39925002] = {
		39925002,
		0,
		Lang.get(106349),
		39925,
		2,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[39925003] = {
		39925003,
		0,
		Lang.get(106350),
		39925,
		3,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[142]
		}
	},
	[39925004] = {
		39925004,
		0,
		Lang.get(106351),
		39925,
		4,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[7],
			RTResTalkAction[26]
		}
	},
	[39925005] = {
		39925005,
		0,
		Lang.get(106352),
		39925,
		5,
		107,
		{
			RTResTalkAction[128],
			RTResTalkAction[6]
		}
	},
	[39925006] = {
		39925006,
		0,
		Lang.get(106353),
		39925,
		6,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39925007] = {
		39925007,
		0,
		Lang.get(106354),
		39925,
		7,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[7]
		}
	},
	[39925008] = {
		39925008,
		0,
		Lang.get(106355),
		39925,
		8,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39925009] = {
		39925009,
		0,
		Lang.get(106356),
		39925,
		9,
		605,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39959,
		nil,
		1,
		[19] = 39959,
		[17] = 1
	},
	[39925010] = {
		39925010,
		0,
		Lang.get(106357),
		39925,
		10,
		292,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[39925011] = {
		39925011,
		0,
		Lang.get(106358),
		39925,
		11,
		292,
		{
			RTResTalkAction[24]
		}
	},
	[39925012] = {
		39925012,
		0,
		Lang.get(106359),
		39925,
		12,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[26]
		}
	},
	[39925013] = {
		39925013,
		0,
		Lang.get(106360),
		39925,
		13,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39925014] = {
		39925014,
		0,
		Lang.get(106361),
		39925,
		14,
		158,
		{
			RTResTalkAction[143],
			RTResTalkAction[7]
		}
	},
	[39925015] = {
		39925015,
		0,
		Lang.get(106362),
		39925,
		15,
		1267,
		{
			RTResTalkAction[38],
			RTResTalkAction[6]
		}
	},
	[39925016] = {
		39925016,
		0,
		Lang.get(106363),
		39925,
		16,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39925017] = {
		39925017,
		0,
		Lang.get(106364),
		39925,
		17,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39925018] = {
		39925018,
		0,
		Lang.get(106365),
		39925,
		18,
		300,
		{
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39925019] = {
		39925019,
		0,
		Lang.get(106366),
		39925,
		19,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[39926001] = {
		39926001,
		0,
		Lang.get(106367),
		39926,
		1,
		1267,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		39960,
		nil,
		1,
		nil,
		1,
		nil,
		39960
	},
	[39926002] = {
		39926002,
		0,
		Lang.get(106368),
		39926,
		2,
		1267,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[39926003] = {
		39926003,
		0,
		Lang.get(106369),
		39926,
		3,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39926004] = {
		39926004,
		0,
		Lang.get(106370),
		39926,
		4,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[39]
		}
	},
	[39926005] = {
		39926005,
		0,
		Lang.get(106371),
		39926,
		5,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39926006] = {
		39926006,
		0,
		Lang.get(106372),
		39926,
		6,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[39926007] = {
		39926007,
		0,
		Lang.get(106373),
		39926,
		7,
		158,
		{
			RTResTalkAction[126],
			RTResTalkAction[7]
		}
	},
	[39926008] = {
		39926008,
		0,
		Lang.get(106374),
		39926,
		8,
		1267,
		{
			RTResTalkAction[37],
			RTResTalkAction[6]
		}
	},
	[39926009] = {
		39926009,
		0,
		Lang.get(106375),
		39926,
		9,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[39926010] = {
		39926010,
		0,
		Lang.get(106376),
		39926,
		10,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39926011] = {
		39926011,
		0,
		Lang.get(106377),
		39926,
		11,
		1268,
		{
			RTResTalkAction[40],
			RTResTalkAction[39]
		}
	},
	[39926012] = {
		39926012,
		0,
		Lang.get(106378),
		39926,
		12,
		605,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39961,
		nil,
		1,
		[19] = 39961,
		[17] = 1
	},
	[39926013] = {
		39926013,
		0,
		Lang.get(106379),
		39926,
		13,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[39926014] = {
		39926014,
		0,
		Lang.get(106380),
		39926,
		14,
		300,
		{
			RTResTalkAction[7]
		}
	},
	[39926015] = {
		39926015,
		0,
		Lang.get(106381),
		39926,
		15,
		300
	},
	[39926016] = {
		39926016,
		0,
		Lang.get(106382),
		39926,
		16,
		300
	},
	[39926017] = {
		39926017,
		0,
		Lang.get(106383),
		39926,
		17,
		1267,
		{
			RTResTalkAction[53]
		}
	},
	[39926018] = {
		39926018,
		0,
		Lang.get(106384),
		39926,
		18,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[43]
		}
	},
	[39926019] = {
		39926019,
		0,
		Lang.get(106385),
		39926,
		19,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39926020] = {
		39926020,
		0,
		Lang.get(106386),
		39926,
		20,
		158,
		{
			RTResTalkAction[144],
			RTResTalkAction[26]
		}
	},
	[39927001] = {
		39927001,
		0,
		Lang.get(106387),
		39927,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		39962,
		nil,
		1,
		nil,
		1,
		nil,
		39962
	},
	[39927002] = {
		39927002,
		0,
		Lang.get(106388),
		39927,
		2,
		1268,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[39927003] = {
		39927003,
		0,
		Lang.get(106389),
		39927,
		3,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39927004] = {
		39927004,
		0,
		Lang.get(106390),
		39927,
		4,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39927005] = {
		39927005,
		0,
		Lang.get(106391),
		39927,
		5,
		1268,
		{
			RTResTalkAction[40]
		}
	},
	[39927006] = {
		39927006,
		0,
		Lang.get(106392),
		39927,
		6,
		1267,
		{
			RTResTalkAction[124],
			RTResTalkAction[43]
		}
	},
	[39927007] = {
		39927007,
		0,
		Lang.get(106393),
		39927,
		7,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[39927008] = {
		39927008,
		0,
		Lang.get(106394),
		39927,
		8,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[39927009] = {
		39927009,
		0,
		Lang.get(106395),
		39927,
		9,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[99]
		}
	},
	[39927010] = {
		39927010,
		0,
		Lang.get(106396),
		39927,
		10,
		292,
		{
			RTResTalkAction[54],
			RTResTalkAction[7]
		}
	},
	[39927011] = {
		39927011,
		0,
		Lang.get(106342),
		39927,
		11,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39963,
		nil,
		1,
		[19] = 39963,
		[17] = 1
	},
	[39927012] = {
		39927012,
		0,
		Lang.get(106397),
		39927,
		12,
		107,
		{
			RTResTalkAction[128]
		},
		nil,
		nil,
		3
	},
	[39927013] = {
		39927013,
		0,
		Lang.get(106398),
		39927,
		13,
		107,
		{
			RTResTalkAction[15]
		}
	},
	[39927014] = {
		39927014,
		0,
		Lang.get(106399),
		39927,
		14,
		292,
		{
			RTResTalkAction[16],
			RTResTalkAction[99]
		}
	},
	[39927015] = {
		39927015,
		0,
		Lang.get(106400),
		39927,
		15,
		292,
		{
			RTResTalkAction[24],
			RTResTalkAction[7]
		}
	},
	[39927016] = {
		39927016,
		0,
		Lang.get(106401),
		39927,
		16,
		1267,
		{
			RTResTalkAction[53],
			RTResTalkAction[26]
		}
	},
	[39927017] = {
		39927017,
		0,
		Lang.get(106402),
		39927,
		17,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39927018] = {
		39927018,
		0,
		Lang.get(106403),
		39927,
		18,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[39927019] = {
		39927019,
		0,
		Lang.get(106404),
		39927,
		19,
		1267,
		{
			RTResTalkAction[38]
		}
	},
	[39927020] = {
		39927020,
		0,
		Lang.get(106405),
		39927,
		20,
		1268,
		{
			RTResTalkAction[44],
			RTResTalkAction[112]
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
