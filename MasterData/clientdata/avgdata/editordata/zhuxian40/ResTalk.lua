-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian40\\ResTalk.lua

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
	[2] = 1194
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1194
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[6] = {
	2,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[7] = {
	3,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[8] = {
	3,
	220,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[9] = {
	2,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[10] = {
	3,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	2,
	215,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		2
	}
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 194
}
RTResTalkAction[17] = {
	1,
	194,
	nil,
	nil,
	1
}
RTResTalkAction[18] = {
	1,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[21] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[22] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		1
	}
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 261
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 261
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 1071,
	[3] = {
		2
	}
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 1071,
	[3] = {
		1
	}
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 261
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 117,
	[3] = {
		1
	}
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 117
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 117,
	[3] = {
		2
	}
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 117
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 57
}
RTResTalkAction[37] = {
	1,
	57,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 57
}
RTResTalkAction[40] = {
	1,
	112,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 57,
	[3] = {
		3
	}
}
RTResTalkAction[43] = {
	[1] = 2,
	[2] = 57
}
RTResTalkAction[44] = {
	3,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[46] = {
	3,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[48] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[49] = {
	1,
	148,
	nil,
	nil,
	0
}
RTResTalkAction[50] = {
	[1] = 3,
	[2] = 148
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 57,
	[3] = {
		3
	}
}
RTResTalkAction[52] = {
	[1] = 2,
	[2] = 57,
	[3] = {
		2
	}
}
RTResTalkAction[53] = {
	1,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 61
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 48
}
RTResTalkAction[56] = {
	[1] = 0,
	[2] = 61
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 48
}
RTResTalkAction[58] = {
	1,
	112,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[59] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[60] = {
	2,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[61] = {
	2,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[62] = {
	[1] = 2,
	[2] = 112,
	[3] = {
		2
	}
}
RTResTalkAction[63] = {
	2,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[64] = {
	2,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 148,
	[3] = {
		2
	}
}
RTResTalkAction[66] = {
	1,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[67] = {
	2,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[68] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[69] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[70] = {
	1,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[71] = {
	3,
	220,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[72] = {
	1,
	194,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[73] = {
	1,
	1132,
	nil,
	nil,
	1
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 1132,
	[3] = {
		2
	}
}
RTResTalkAction[75] = {
	[1] = 2,
	[2] = 1132
}
RTResTalkAction[76] = {
	3,
	188,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[77] = {
	2,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[78] = {
	[1] = 3,
	[2] = 188
}
RTResTalkAction[79] = {
	2,
	1132,
	nil,
	nil,
	1
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 1132
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[82] = {
	1,
	194,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 1132
}
RTResTalkAction[84] = {
	3,
	188,
	nil,
	nil,
	4
}
RTResTalkAction[85] = {
	1,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 749,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	1,
	1132,
	nil,
	nil,
	2
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 749
}
RTResTalkAction[89] = {
	1,
	1132,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[90] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[92] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[93] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[94] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[95] = {
	3,
	112,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 1056
}
RTResTalkAction[97] = {
	[1] = 2,
	[2] = 1056
}
RTResTalkAction[98] = {
	[1] = 3,
	[2] = 1057
}
RTResTalkAction[99] = {
	[1] = 0,
	[2] = 1056
}
RTResTalkAction[100] = {
	[1] = 0,
	[2] = 1057
}
RTResTalkAction[101] = {
	3,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[102] = {
	[1] = 2,
	[2] = 1056,
	[3] = {
		3
	}
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 1058,
	[3] = {
		1
	}
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 1058
}
RTResTalkAction[105] = {
	[1] = 1,
	[2] = 1071,
	[3] = {
		3
	}
}
RTResTalkAction[106] = {
	1,
	1071,
	nil,
	nil,
	0
}
RTResTalkAction[107] = {
	1,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[108] = {
	1,
	1071,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[109] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[110] = {
	3,
	148,
	nil,
	nil,
	0
}
RTResTalkAction[111] = {
	1,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[112] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[113] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[114] = {
	1,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[115] = {
	1,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[116] = {
	1,
	261,
	nil,
	nil,
	0
}

local Data = {
	[35701001] = {
		35701001,
		0,
		Lang.get(93044),
		35701,
		1,
		58,
		nil,
		1,
		0,
		nil,
		nil,
		57,
		35701,
		nil,
		nil,
		nil,
		nil,
		nil,
		35701
	},
	[35701002] = {
		35701002,
		0,
		Lang.get(93045),
		35701,
		2,
		49,
		nil,
		1,
		0
	},
	[35701003] = {
		35701003,
		0,
		Lang.get(93046),
		35701,
		3,
		1194,
		nil,
		1,
		0
	},
	[35701004] = {
		35701004,
		0,
		Lang.get(93047),
		35701,
		4,
		1194,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1
	},
	[35701005] = {
		35701005,
		4,
		nil,
		35701,
		5,
		1194,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		35702,
		1,
		nil,
		nil,
		nil,
		nil,
		35702,
		[29] = {
			{
				id = 35701006,
				branch_content = Lang.get(93048)
			},
			{
				id = 35701006,
				branch_content = Lang.get(93049)
			}
		}
	},
	[35701006] = {
		35701006,
		0,
		Lang.get(27986),
		35701,
		6,
		1194,
		{
			RTResTalkAction[1]
		}
	},
	[35701007] = {
		35701007,
		4,
		nil,
		35701,
		7,
		1194,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 35701008,
				branch_content = Lang.get(93050)
			}
		}
	},
	[35701008] = {
		35701008,
		0,
		Lang.get(93051),
		35701,
		8,
		215,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		-1,
		nil,
		122,
		35703,
		1,
		1,
		nil,
		1,
		nil,
		35703
	},
	[35701009] = {
		35701009,
		0,
		Lang.get(93052),
		35701,
		9,
		220,
		nil,
		1
	},
	[35701010] = {
		35701010,
		0,
		Lang.get(93053),
		35701,
		10,
		225,
		nil,
		1
	},
	[35701011] = {
		35701011,
		0,
		Lang.get(93054),
		35701,
		11,
		215,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[35701012] = {
		35701012,
		0,
		Lang.get(93055),
		35701,
		12,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[35701013] = {
		35701013,
		0,
		Lang.get(93056),
		35701,
		13,
		215,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[35701014] = {
		35701014,
		0,
		Lang.get(93057),
		35701,
		14,
		215,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[35701015] = {
		35701015,
		0,
		Lang.get(93058),
		35701,
		15,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[35701016] = {
		35701016,
		0,
		Lang.get(93059),
		35701,
		16,
		215,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[35701017] = {
		35701017,
		0,
		Lang.get(93060),
		35701,
		17,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[35701018] = {
		35701018,
		0,
		Lang.get(93061),
		35701,
		18,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[35701019] = {
		35701019,
		0,
		Lang.get(93062),
		35701,
		19,
		215,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[35701020] = {
		35701020,
		0,
		Lang.get(93063),
		35701,
		20,
		215,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[35701021] = {
		35701021,
		0,
		Lang.get(93064),
		35701,
		21,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[35701022] = {
		35701022,
		0,
		Lang.get(93065),
		35701,
		22,
		215,
		{
			RTResTalkAction[11],
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35701023] = {
		35701023,
		0,
		Lang.get(93066),
		35701,
		23,
		225,
		{
			RTResTalkAction[12],
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[35701024] = {
		35701024,
		0,
		Lang.get(93067),
		35701,
		24,
		225,
		{
			RTResTalkAction[15]
		}
	},
	[35702001] = {
		35702001,
		0,
		Lang.get(93068),
		35702,
		1,
		257,
		{
			RTResTalkAction[16]
		},
		1,
		nil,
		3,
		nil,
		122,
		35705,
		nil,
		nil,
		nil,
		nil,
		nil,
		35705,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[35702002] = {
		35702002,
		13,
		Lang.get(93069),
		35702,
		2,
		194,
		{
			RTResTalkAction[16]
		},
		[27] = 3
	},
	[35702003] = {
		35702003,
		0,
		Lang.get(93070),
		35702,
		3,
		257,
		{
			RTResTalkAction[16]
		},
		1,
		[27] = 3
	},
	[35702004] = {
		35702004,
		13,
		Lang.get(93071),
		35702,
		4,
		194,
		{
			RTResTalkAction[17]
		},
		[27] = 3
	},
	[35702005] = {
		35702005,
		13,
		Lang.get(93072),
		35702,
		5,
		194,
		{
			RTResTalkAction[18]
		},
		[27] = 3
	},
	[35702006] = {
		35702006,
		0,
		Lang.get(93073),
		35702,
		6,
		257,
		{
			RTResTalkAction[16]
		},
		1,
		[27] = 3
	},
	[35702007] = {
		35702007,
		0,
		Lang.get(93074),
		35702,
		7,
		1071,
		{
			RTResTalkAction[19]
		},
		1,
		0,
		nil,
		nil,
		190,
		35706,
		1,
		1,
		nil,
		1,
		nil,
		35706
	},
	[35702008] = {
		35702008,
		0,
		Lang.get(93075),
		35702,
		8,
		1071,
		nil,
		1,
		0
	},
	[35702009] = {
		35702009,
		0,
		Lang.get(93076),
		35702,
		9,
		257,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[35702010] = {
		35702010,
		0,
		Lang.get(93077),
		35702,
		10,
		1071,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[35702011] = {
		35702011,
		0,
		Lang.get(93078),
		35702,
		11,
		257,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[35702012] = {
		35702012,
		0,
		Lang.get(93079),
		35702,
		12,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35702013] = {
		35702013,
		0,
		Lang.get(93080),
		35702,
		13,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35702014] = {
		35702014,
		0,
		Lang.get(93081),
		35702,
		14,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35702015] = {
		35702015,
		0,
		Lang.get(93082),
		35702,
		15,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35702016] = {
		35702016,
		0,
		Lang.get(93083),
		35702,
		16,
		257,
		{
			RTResTalkAction[20]
		}
	},
	[35702017] = {
		35702017,
		0,
		Lang.get(24138),
		35702,
		17,
		261,
		{
			RTResTalkAction[27],
			RTResTalkAction[26]
		}
	},
	[35702018] = {
		35702018,
		0,
		Lang.get(93084),
		35702,
		18,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[28]
		}
	},
	[35702019] = {
		35702019,
		0,
		Lang.get(93085),
		35702,
		19,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35702020] = {
		35702020,
		0,
		Lang.get(93086),
		35702,
		20,
		257,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[35702021] = {
		35702021,
		0,
		Lang.get(93087),
		35702,
		21,
		1071,
		{
			RTResTalkAction[29],
			RTResTalkAction[26]
		}
	},
	[35702022] = {
		35702022,
		0,
		Lang.get(93088),
		35702,
		22,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703001] = {
		35703001,
		0,
		Lang.get(93089),
		35703,
		1,
		1071,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3,
		nil,
		113,
		35710,
		nil,
		nil,
		nil,
		nil,
		nil,
		35710
	},
	[35703002] = {
		35703002,
		0,
		Lang.get(93090),
		35703,
		2,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703003] = {
		35703003,
		0,
		Lang.get(93091),
		35703,
		3,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703004] = {
		35703004,
		0,
		Lang.get(93092),
		35703,
		4,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703005] = {
		35703005,
		0,
		Lang.get(93093),
		35703,
		5,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703006] = {
		35703006,
		0,
		Lang.get(93094),
		35703,
		6,
		1071,
		{
			RTResTalkAction[30]
		}
	},
	[35703007] = {
		35703007,
		0,
		Lang.get(93095),
		35703,
		7,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35703008] = {
		35703008,
		0,
		Lang.get(93096),
		35703,
		8,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35703009] = {
		35703009,
		0,
		"……",
		35703,
		9,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35703010] = {
		35703010,
		0,
		Lang.get(93097),
		35703,
		10,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		59
	},
	[35703011] = {
		35703011,
		0,
		Lang.get(93098),
		35703,
		11,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703012] = {
		35703012,
		0,
		Lang.get(93099),
		35703,
		12,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35703013] = {
		35703013,
		0,
		Lang.get(93100),
		35703,
		13,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35703014] = {
		35703014,
		0,
		Lang.get(93101),
		35703,
		14,
		1071,
		{
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
	[35703015] = {
		35703015,
		0,
		Lang.get(93102),
		35703,
		15,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35703016] = {
		35703016,
		0,
		Lang.get(93103),
		35703,
		16,
		1071,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		}
	},
	[35703017] = {
		35703017,
		0,
		Lang.get(93104),
		35703,
		17,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703018] = {
		35703018,
		0,
		Lang.get(93105),
		35703,
		18,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703019] = {
		35703019,
		0,
		Lang.get(93106),
		35703,
		19,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35703020] = {
		35703020,
		0,
		Lang.get(93107),
		35703,
		20,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35703021] = {
		35703021,
		0,
		Lang.get(93108),
		35703,
		21,
		1071,
		{
			RTResTalkAction[29],
			RTResTalkAction[26]
		}
	},
	[35703022] = {
		35703022,
		3,
		Lang.get(93109),
		35703,
		22,
		605,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		1226,
		176,
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
	[35703023] = {
		35703023,
		0,
		"……",
		35703,
		23,
		257,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		35711,
		nil,
		nil,
		nil,
		nil,
		nil,
		35711,
		-1
	},
	[35703024] = {
		35703024,
		0,
		Lang.get(93110),
		35703,
		24,
		257,
		{
			RTResTalkAction[20]
		}
	},
	[35703025] = {
		35703025,
		3,
		Lang.get(93109),
		35703,
		25,
		605,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3,
		1226,
		nil,
		35712,
		1,
		1,
		nil,
		1,
		nil,
		35712,
		nil,
		nil,
		1
	},
	[35703026] = {
		35703026,
		0,
		Lang.get(93111),
		35703,
		26,
		261,
		{
			RTResTalkAction[21],
			RTResTalkAction[31]
		}
	},
	[35703027] = {
		35703027,
		0,
		"……",
		35703,
		27,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[28]
		}
	},
	[35703028] = {
		35703028,
		0,
		Lang.get(93112),
		35703,
		28,
		257,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35703029] = {
		35703029,
		0,
		Lang.get(93113),
		35703,
		29,
		257,
		{
			RTResTalkAction[20]
		}
	},
	[35704001] = {
		35704001,
		0,
		Lang.get(93114),
		35704,
		1,
		1071,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		35715,
		nil,
		nil,
		nil,
		nil,
		nil,
		35715
	},
	[35704002] = {
		35704002,
		0,
		Lang.get(93115),
		35704,
		2,
		1071,
		nil,
		1,
		0
	},
	[35704003] = {
		35704003,
		0,
		Lang.get(93116),
		35704,
		3,
		257,
		nil,
		1,
		0
	},
	[35704004] = {
		35704004,
		0,
		Lang.get(93117),
		35704,
		4,
		1071,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[35704005] = {
		35704005,
		0,
		Lang.get(93118),
		35704,
		5,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35704006] = {
		35704006,
		0,
		Lang.get(93119),
		35704,
		6,
		257,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[35704007] = {
		35704007,
		0,
		Lang.get(88039),
		35704,
		7,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		1225
	},
	[35704008] = {
		35704008,
		0,
		Lang.get(93120),
		35704,
		8,
		257,
		{
			RTResTalkAction[20]
		}
	},
	[35704009] = {
		35704009,
		13,
		Lang.get(93121),
		35704,
		9,
		605,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		1232,
		57,
		[27] = 3,
		[22] = 1
	},
	[35704010] = {
		35704010,
		13,
		Lang.get(93122),
		35704,
		10,
		117,
		{
			RTResTalkAction[32]
		},
		[27] = 3
	},
	[35704011] = {
		35704011,
		0,
		Lang.get(93123),
		35704,
		11,
		257,
		{
			RTResTalkAction[33]
		},
		1,
		0,
		[27] = 3
	},
	[35704012] = {
		35704012,
		13,
		Lang.get(93124),
		35704,
		12,
		117,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		1232,
		[27] = 3
	},
	[35704013] = {
		35704013,
		13,
		Lang.get(93125),
		35704,
		13,
		117,
		{
			RTResTalkAction[33]
		},
		[27] = 3
	},
	[35704014] = {
		35704014,
		0,
		Lang.get(93126),
		35704,
		14,
		257,
		{
			RTResTalkAction[33]
		},
		1,
		0,
		[27] = 3
	},
	[35704015] = {
		35704015,
		13,
		Lang.get(82673),
		35704,
		15,
		117,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		1233,
		[27] = 3
	},
	[35704016] = {
		35704016,
		13,
		Lang.get(93127),
		35704,
		16,
		117,
		{
			RTResTalkAction[34]
		},
		[27] = 3
	},
	[35704017] = {
		35704017,
		3,
		Lang.get(93109),
		35704,
		17,
		605,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		nil,
		1226,
		[22] = 1
	},
	[35704018] = {
		35704018,
		0,
		Lang.get(93128),
		35704,
		18,
		257,
		{
			RTResTalkAction[23]
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
	[35704019] = {
		35704019,
		0,
		Lang.get(93129),
		35704,
		19,
		1071,
		{
			RTResTalkAction[26]
		},
		1,
		0,
		nil,
		nil,
		nil,
		35716,
		nil,
		nil,
		nil,
		nil,
		nil,
		35716
	},
	[35704020] = {
		35704020,
		0,
		Lang.get(93130),
		35704,
		20,
		1071,
		nil,
		1,
		0
	},
	[35704021] = {
		35704021,
		0,
		Lang.get(93131),
		35704,
		21,
		257,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35704022] = {
		35704022,
		3,
		Lang.get(93132),
		35704,
		22,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		103,
		[22] = 1,
		[20] = 255
	},
	[35704023] = {
		35704023,
		0,
		Lang.get(93133),
		35704,
		23,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		35717,
		1,
		nil,
		nil,
		nil,
		nil,
		35717,
		-1
	},
	[35704024] = {
		35704024,
		0,
		Lang.get(93134),
		35704,
		24,
		148,
		nil,
		1,
		0
	},
	[35704025] = {
		35704025,
		0,
		Lang.get(93135),
		35704,
		25,
		57,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[35704026] = {
		35704026,
		0,
		Lang.get(93136),
		35704,
		26,
		57,
		{
			RTResTalkAction[37]
		}
	},
	[35704027] = {
		35704027,
		0,
		Lang.get(93137),
		35704,
		27,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35704028] = {
		35704028,
		0,
		Lang.get(93138),
		35704,
		28,
		112,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[35705001] = {
		35705001,
		0,
		Lang.get(93139),
		35705,
		1,
		57,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		60,
		35720,
		nil,
		nil,
		nil,
		nil,
		nil,
		35720
	},
	[35705002] = {
		35705002,
		0,
		Lang.get(93140),
		35705,
		2,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[39]
		}
	},
	[35705003] = {
		35705003,
		5,
		Lang.get(93141),
		35705,
		3,
		57,
		{
			RTResTalkAction[42],
			RTResTalkAction[41]
		}
	},
	[35705004] = {
		35705004,
		0,
		Lang.get(93142),
		35705,
		4,
		112,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[35705005] = {
		35705005,
		0,
		Lang.get(93143),
		35705,
		5,
		57,
		{
			RTResTalkAction[43],
			RTResTalkAction[45]
		}
	},
	[35705006] = {
		35705006,
		0,
		Lang.get(93144),
		35705,
		6,
		112,
		{
			RTResTalkAction[43],
			RTResTalkAction[46]
		}
	},
	[35705007] = {
		35705007,
		0,
		Lang.get(93145),
		35705,
		7,
		57,
		{
			RTResTalkAction[43],
			RTResTalkAction[45]
		}
	},
	[35705008] = {
		35705008,
		0,
		Lang.get(93146),
		35705,
		8,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[39],
			RTResTalkAction[47]
		}
	},
	[35705009] = {
		35705009,
		0,
		Lang.get(93147),
		35705,
		9,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[41]
		}
	},
	[35705010] = {
		35705010,
		0,
		Lang.get(93148),
		35705,
		10,
		148,
		{
			RTResTalkAction[49],
			RTResTalkAction[47]
		}
	},
	[35705011] = {
		35705011,
		0,
		Lang.get(93149),
		35705,
		11,
		57,
		{
			RTResTalkAction[43],
			RTResTalkAction[50]
		}
	},
	[35705012] = {
		35705012,
		0,
		Lang.get(93150),
		35705,
		12,
		57,
		{
			RTResTalkAction[51],
			RTResTalkAction[50]
		}
	},
	[35705013] = {
		35705013,
		0,
		Lang.get(93151),
		35705,
		13,
		148,
		{
			RTResTalkAction[52],
			RTResTalkAction[50]
		}
	},
	[35705014] = {
		35705014,
		0,
		Lang.get(93152),
		35705,
		14,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[35705015] = {
		35705015,
		0,
		Lang.get(93153),
		35705,
		15,
		57,
		{
			RTResTalkAction[36],
			RTResTalkAction[47]
		}
	},
	[35705016] = {
		35705016,
		0,
		Lang.get(93154),
		35705,
		16,
		112,
		{
			RTResTalkAction[53],
			RTResTalkAction[39]
		}
	},
	[35705017] = {
		35705017,
		3,
		Lang.get(93155),
		35705,
		17,
		605,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[22] = 1
	},
	[35705018] = {
		35705018,
		0,
		Lang.get(93156),
		35705,
		18,
		61,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		35721,
		1,
		nil,
		nil,
		nil,
		nil,
		35721
	},
	[35705019] = {
		35705019,
		5,
		Lang.get(93157),
		35705,
		19,
		61,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[35705020] = {
		35705020,
		5,
		Lang.get(93157),
		35705,
		20,
		48,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[35705021] = {
		35705021,
		0,
		Lang.get(93158),
		35705,
		21,
		57,
		{
			RTResTalkAction[42],
			RTResTalkAction[57]
		}
	},
	[35705022] = {
		35705022,
		0,
		Lang.get(93159),
		35705,
		22,
		112,
		{
			RTResTalkAction[58],
			RTResTalkAction[39]
		}
	},
	[35705023] = {
		35705023,
		0,
		Lang.get(93160),
		35705,
		23,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35705024] = {
		35705024,
		0,
		Lang.get(93161),
		35705,
		24,
		112,
		{
			RTResTalkAction[60],
			RTResTalkAction[50]
		}
	},
	[35705025] = {
		35705025,
		0,
		Lang.get(93162),
		35705,
		25,
		61,
		{
			RTResTalkAction[54],
			RTResTalkAction[47],
			RTResTalkAction[41]
		}
	},
	[35706001] = {
		35706001,
		0,
		Lang.get(93163),
		35706,
		1,
		112,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3,
		nil,
		57,
		35725,
		1,
		1,
		nil,
		nil,
		nil,
		35725
	},
	[35706002] = {
		35706002,
		0,
		Lang.get(93164),
		35706,
		2,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35706003] = {
		35706003,
		0,
		Lang.get(93165),
		35706,
		3,
		112,
		{
			RTResTalkAction[60],
			RTResTalkAction[50]
		}
	},
	[35706004] = {
		35706004,
		0,
		Lang.get(93166),
		35706,
		4,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35706005] = {
		35706005,
		0,
		Lang.get(93167),
		35706,
		5,
		112,
		{
			RTResTalkAction[61],
			RTResTalkAction[50]
		}
	},
	[35706006] = {
		35706006,
		3,
		Lang.get(24404),
		35706,
		6,
		605,
		{
			RTResTalkAction[47],
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		1232,
		[22] = 1
	},
	[35706007] = {
		35706007,
		0,
		Lang.get(93168),
		35706,
		7,
		148,
		{
			RTResTalkAction[38]
		}
	},
	[35706008] = {
		35706008,
		0,
		Lang.get(93169),
		35706,
		8,
		112,
		{
			RTResTalkAction[61],
			RTResTalkAction[50]
		}
	},
	[35706009] = {
		35706009,
		0,
		Lang.get(93170),
		35706,
		9,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35706010] = {
		35706010,
		0,
		Lang.get(93171),
		35706,
		10,
		112,
		{
			RTResTalkAction[62],
			RTResTalkAction[50]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35706011] = {
		35706011,
		0,
		Lang.get(93172),
		35706,
		11,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35706012] = {
		35706012,
		0,
		Lang.get(93173),
		35706,
		12,
		112,
		{
			RTResTalkAction[63],
			RTResTalkAction[50]
		}
	},
	[35706013] = {
		35706013,
		0,
		Lang.get(93174),
		35706,
		13,
		112,
		{
			RTResTalkAction[64],
			RTResTalkAction[50]
		}
	},
	[35706014] = {
		35706014,
		0,
		Lang.get(93175),
		35706,
		14,
		148,
		{
			RTResTalkAction[65],
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35706015] = {
		35706015,
		3,
		Lang.get(93176),
		35706,
		15,
		605,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		1233,
		[22] = 1
	},
	[35706016] = {
		35706016,
		0,
		Lang.get(93177),
		35706,
		16,
		112,
		{
			RTResTalkAction[66]
		}
	},
	[35706017] = {
		35706017,
		0,
		Lang.get(93178),
		35706,
		17,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[47]
		}
	},
	[35706018] = {
		35706018,
		0,
		Lang.get(93179),
		35706,
		18,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[41]
		}
	},
	[35706019] = {
		35706019,
		0,
		Lang.get(93180),
		35706,
		19,
		215,
		{
			RTResTalkAction[47]
		},
		1,
		0,
		-1,
		nil,
		158,
		35726,
		1,
		1,
		nil,
		nil,
		nil,
		35726
	},
	[35706020] = {
		35706020,
		0,
		Lang.get(93181),
		35706,
		20,
		225,
		nil,
		1
	},
	[35706021] = {
		35706021,
		0,
		Lang.get(93182),
		35706,
		21,
		220,
		nil,
		1,
		3
	},
	[35706022] = {
		35706022,
		0,
		Lang.get(93183),
		35706,
		22,
		112,
		{
			RTResTalkAction[63],
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[35706023] = {
		35706023,
		0,
		Lang.get(93184),
		35706,
		23,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[50]
		}
	},
	[35706024] = {
		35706024,
		0,
		Lang.get(93185),
		35706,
		24,
		112,
		{
			RTResTalkAction[67],
			RTResTalkAction[50]
		}
	},
	[35706025] = {
		35706025,
		0,
		Lang.get(93186),
		35706,
		25,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[47]
		}
	},
	[35706026] = {
		35706026,
		0,
		Lang.get(93187),
		35706,
		26,
		215,
		{
			RTResTalkAction[68],
			RTResTalkAction[41]
		}
	},
	[35706027] = {
		35706027,
		0,
		Lang.get(93188),
		35706,
		27,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[35706028] = {
		35706028,
		0,
		Lang.get(93189),
		35706,
		28,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[47]
		}
	},
	[35706029] = {
		35706029,
		0,
		Lang.get(93190),
		35706,
		29,
		215,
		{
			RTResTalkAction[70]
		}
	},
	[35706030] = {
		35706030,
		0,
		Lang.get(93191),
		35706,
		30,
		220,
		{
			RTResTalkAction[4],
			RTResTalkAction[71]
		}
	},
	[35706031] = {
		35706031,
		0,
		Lang.get(93192),
		35706,
		31,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[35706032] = {
		35706032,
		0,
		Lang.get(93193),
		35706,
		32,
		112,
		{
			RTResTalkAction[48]
		}
	},
	[35707001] = {
		35707001,
		2,
		Lang.get(93194),
		35707,
		1,
		194,
		nil,
		1,
		1,
		nil,
		nil,
		194,
		35730,
		nil,
		nil,
		nil,
		nil,
		nil,
		35730
	},
	[35707002] = {
		35707002,
		2,
		Lang.get(93195),
		35707,
		2,
		194,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[35707003] = {
		35707003,
		3,
		Lang.get(93196),
		35707,
		3,
		605,
		{
			RTResTalkAction[16]
		},
		[22] = 1
	},
	[35707004] = {
		35707004,
		2,
		Lang.get(93197),
		35707,
		4,
		194,
		{
			RTResTalkAction[16]
		}
	},
	[35707005] = {
		35707005,
		2,
		Lang.get(23908),
		35707,
		5,
		194,
		{
			RTResTalkAction[72]
		}
	},
	[35707006] = {
		35707006,
		0,
		Lang.get(93198),
		35707,
		6,
		1132,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		-1,
		nil,
		156,
		35731,
		1,
		1,
		nil,
		nil,
		nil,
		35731
	},
	[35707007] = {
		35707007,
		0,
		Lang.get(93199),
		35707,
		7,
		188,
		nil,
		1,
		2
	},
	[35707008] = {
		35707008,
		0,
		Lang.get(93200),
		35707,
		8,
		1132,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[35707009] = {
		35707009,
		0,
		Lang.get(93201),
		35707,
		9,
		1132,
		{
			RTResTalkAction[74]
		}
	},
	[35707010] = {
		35707010,
		0,
		Lang.get(93202),
		35707,
		10,
		188,
		{
			RTResTalkAction[75],
			RTResTalkAction[76]
		}
	},
	[35707011] = {
		35707011,
		0,
		Lang.get(93203),
		35707,
		11,
		1132,
		{
			RTResTalkAction[77],
			RTResTalkAction[78]
		}
	},
	[35707012] = {
		35707012,
		0,
		Lang.get(93204),
		35707,
		12,
		1132,
		{
			RTResTalkAction[75],
			RTResTalkAction[78]
		}
	},
	[35707013] = {
		35707013,
		0,
		Lang.get(93205),
		35707,
		13,
		188,
		{
			RTResTalkAction[75],
			RTResTalkAction[78]
		}
	},
	[35707014] = {
		35707014,
		0,
		Lang.get(93206),
		35707,
		14,
		188,
		{
			RTResTalkAction[75],
			RTResTalkAction[78]
		}
	},
	[35707015] = {
		35707015,
		0,
		Lang.get(93207),
		35707,
		15,
		1132,
		{
			RTResTalkAction[75],
			RTResTalkAction[78]
		}
	},
	[35707016] = {
		35707016,
		0,
		Lang.get(93208),
		35707,
		16,
		1132,
		{
			RTResTalkAction[79],
			RTResTalkAction[78]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35707017] = {
		35707017,
		2,
		Lang.get(93209),
		35707,
		17,
		194,
		{
			RTResTalkAction[17],
			RTResTalkAction[80],
			RTResTalkAction[81]
		}
	},
	[35707018] = {
		35707018,
		2,
		Lang.get(93210),
		35707,
		18,
		194,
		{
			RTResTalkAction[82]
		}
	},
	[35708001] = {
		35708001,
		0,
		Lang.get(93211),
		35708,
		1,
		1132,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		35735,
		nil,
		nil,
		nil,
		nil,
		nil,
		35735
	},
	[35708002] = {
		35708002,
		0,
		Lang.get(93212),
		35708,
		2,
		188,
		nil,
		1,
		0
	},
	[35708003] = {
		35708003,
		0,
		Lang.get(93213),
		35708,
		3,
		1132,
		nil,
		1,
		1
	},
	[35708004] = {
		35708004,
		0,
		Lang.get(93214),
		35708,
		4,
		1132,
		nil,
		1,
		0
	},
	[35708005] = {
		35708005,
		2,
		Lang.get(93215),
		35708,
		5,
		194,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[35708006] = {
		35708006,
		2,
		Lang.get(93216),
		35708,
		6,
		194,
		{
			RTResTalkAction[16]
		}
	},
	[35708007] = {
		35708007,
		2,
		Lang.get(93217),
		35708,
		7,
		194,
		{
			RTResTalkAction[16]
		}
	},
	[35708008] = {
		35708008,
		3,
		Lang.get(93218),
		35708,
		8,
		605,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		1230,
		[22] = 1
	},
	[35708009] = {
		35708009,
		2,
		Lang.get(93219),
		35708,
		9,
		194,
		{
			RTResTalkAction[16]
		}
	},
	[35708010] = {
		35708010,
		0,
		Lang.get(19557),
		35708,
		10,
		1132,
		{
			RTResTalkAction[83],
			RTResTalkAction[19]
		}
	},
	[35708011] = {
		35708011,
		0,
		Lang.get(93220),
		35708,
		11,
		188,
		{
			RTResTalkAction[75],
			RTResTalkAction[84]
		}
	},
	[35708012] = {
		35708012,
		0,
		Lang.get(93221),
		35708,
		12,
		1132,
		{
			RTResTalkAction[77],
			RTResTalkAction[78]
		}
	},
	[35708013] = {
		35708013,
		0,
		Lang.get(93222),
		35708,
		13,
		1132,
		{
			RTResTalkAction[80],
			RTResTalkAction[81]
		},
		1,
		1,
		-1,
		nil,
		nil,
		35736,
		1,
		1,
		nil,
		nil,
		nil,
		35736
	},
	[35708014] = {
		35708014,
		0,
		Lang.get(93223),
		35708,
		14,
		1132,
		nil,
		1,
		0
	},
	[35708015] = {
		35708015,
		0,
		Lang.get(93224),
		35708,
		15,
		188,
		nil,
		1,
		2,
		3
	},
	[35708016] = {
		35708016,
		0,
		Lang.get(93225),
		35708,
		16,
		1132,
		{
			RTResTalkAction[74]
		}
	},
	[35708017] = {
		35708017,
		0,
		"……",
		35708,
		17,
		194,
		{
			RTResTalkAction[17],
			RTResTalkAction[80]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35708018] = {
		35708018,
		0,
		Lang.get(92319),
		35708,
		18,
		194,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		nil,
		1231
	},
	[35708019] = {
		35708019,
		0,
		Lang.get(93226),
		35708,
		19,
		1132,
		{
			RTResTalkAction[73],
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35708020] = {
		35708020,
		0,
		Lang.get(93227),
		35708,
		20,
		1132,
		{
			RTResTalkAction[85]
		}
	},
	[35708021] = {
		35708021,
		0,
		Lang.get(49278),
		35708,
		21,
		749,
		{
			RTResTalkAction[86],
			RTResTalkAction[80]
		},
		nil,
		nil,
		nil,
		1231,
		60
	},
	[35708022] = {
		35708022,
		0,
		"？",
		35708,
		22,
		1132,
		{
			RTResTalkAction[87],
			RTResTalkAction[88]
		}
	},
	[35708023] = {
		35708023,
		0,
		Lang.get(93228),
		35708,
		23,
		1132,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35709001] = {
		35709001,
		0,
		Lang.get(93229),
		35709,
		1,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		193,
		35740,
		nil,
		nil,
		nil,
		nil,
		nil,
		35740
	},
	[35709002] = {
		35709002,
		0,
		Lang.get(93230),
		35709,
		2,
		112,
		nil,
		1,
		2
	},
	[35709003] = {
		35709003,
		0,
		Lang.get(93231),
		35709,
		3,
		215,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[35709004] = {
		35709004,
		0,
		Lang.get(93232),
		35709,
		4,
		215,
		{
			RTResTalkAction[3]
		}
	},
	[35709005] = {
		35709005,
		0,
		Lang.get(93233),
		35709,
		5,
		225,
		{
			RTResTalkAction[4],
			RTResTalkAction[90]
		}
	},
	[35709006] = {
		35709006,
		0,
		Lang.get(93234),
		35709,
		6,
		225,
		{
			RTResTalkAction[4],
			RTResTalkAction[90]
		}
	},
	[35709007] = {
		35709007,
		0,
		Lang.get(93235),
		35709,
		7,
		112,
		{
			RTResTalkAction[40],
			RTResTalkAction[13],
			RTResTalkAction[91]
		}
	},
	[35709008] = {
		35709008,
		0,
		Lang.get(93236),
		35709,
		8,
		220,
		{
			RTResTalkAction[92],
			RTResTalkAction[47]
		}
	},
	[35709009] = {
		35709009,
		0,
		Lang.get(93237),
		35709,
		9,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[14]
		}
	},
	[35709010] = {
		35709010,
		0,
		Lang.get(93238),
		35709,
		10,
		112,
		{
			RTResTalkAction[48]
		}
	},
	[35709011] = {
		35709011,
		0,
		Lang.get(93239),
		35709,
		11,
		148,
		{
			RTResTalkAction[38],
			RTResTalkAction[47]
		}
	},
	[35709012] = {
		35709012,
		0,
		Lang.get(93240),
		35709,
		12,
		215,
		{
			RTResTalkAction[69],
			RTResTalkAction[41]
		}
	},
	[35709013] = {
		35709013,
		0,
		Lang.get(93241),
		35709,
		13,
		215,
		{
			RTResTalkAction[3]
		}
	},
	[35709014] = {
		35709014,
		0,
		Lang.get(37991),
		35709,
		14,
		215,
		{
			RTResTalkAction[93]
		}
	},
	[35709015] = {
		35709015,
		0,
		Lang.get(93242),
		35709,
		15,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[94]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35709016] = {
		35709016,
		0,
		Lang.get(93243),
		35709,
		16,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[45]
		}
	},
	[35709017] = {
		35709017,
		0,
		Lang.get(93244),
		35709,
		17,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[45]
		}
	},
	[35709018] = {
		35709018,
		0,
		Lang.get(93245),
		35709,
		18,
		215,
		{
			RTResTalkAction[9],
			RTResTalkAction[45]
		}
	},
	[35709019] = {
		35709019,
		0,
		Lang.get(25131),
		35709,
		19,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[95]
		}
	},
	[35709020] = {
		35709020,
		0,
		Lang.get(93246),
		35709,
		20,
		215,
		{
			RTResTalkAction[70],
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35710001] = {
		35710001,
		0,
		Lang.get(93247),
		35710,
		1,
		1056,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		35745,
		nil,
		nil,
		nil,
		nil,
		nil,
		35745
	},
	[35710002] = {
		35710002,
		0,
		Lang.get(93248),
		35710,
		2,
		1058,
		nil,
		1,
		0
	},
	[35710003] = {
		35710003,
		0,
		Lang.get(93249),
		35710,
		3,
		1056,
		{
			RTResTalkAction[96]
		},
		nil,
		nil,
		3
	},
	[35710004] = {
		35710004,
		0,
		Lang.get(93250),
		35710,
		4,
		1057,
		{
			RTResTalkAction[97],
			RTResTalkAction[98]
		}
	},
	[35710005] = {
		35710005,
		0,
		Lang.get(93251),
		35710,
		5,
		1071,
		{
			RTResTalkAction[29],
			RTResTalkAction[99],
			RTResTalkAction[100]
		},
		nil,
		nil,
		nil,
		nil,
		190
	},
	[35710006] = {
		35710006,
		0,
		Lang.get(93252),
		35710,
		6,
		1056,
		{
			RTResTalkAction[97],
			RTResTalkAction[22]
		}
	},
	[35710007] = {
		35710007,
		0,
		Lang.get(93253),
		35710,
		7,
		1071,
		{
			RTResTalkAction[97],
			RTResTalkAction[101]
		}
	},
	[35710008] = {
		35710008,
		0,
		Lang.get(93254),
		35710,
		8,
		1056,
		{
			RTResTalkAction[102],
			RTResTalkAction[101]
		}
	},
	[35710009] = {
		35710009,
		0,
		Lang.get(93255),
		35710,
		9,
		1056,
		{
			RTResTalkAction[96],
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35710010] = {
		35710010,
		0,
		Lang.get(93256),
		35710,
		10,
		1058,
		{
			RTResTalkAction[103],
			RTResTalkAction[99]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35710011] = {
		35710011,
		0,
		Lang.get(93257),
		35710,
		11,
		300,
		{
			RTResTalkAction[104]
		}
	},
	[35710012] = {
		35710012,
		0,
		"！？",
		35710,
		12,
		1071,
		{
			RTResTalkAction[105]
		}
	},
	[35710013] = {
		35710013,
		0,
		Lang.get(93258),
		35710,
		13,
		300,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		-1,
		nil,
		58,
		35746,
		1,
		1,
		nil,
		1,
		nil,
		35746
	},
	[35710014] = {
		35710014,
		0,
		Lang.get(93259),
		35710,
		14,
		1071,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35710015] = {
		35710015,
		4,
		nil,
		35710,
		15,
		1071,
		nil,
		1,
		0,
		[29] = {
			{
				id = 35710016,
				branch_content = Lang.get(93260)
			},
			{
				id = 35710016,
				branch_content = Lang.get(93261)
			}
		}
	},
	[35710016] = {
		35710016,
		0,
		Lang.get(93262),
		35710,
		16,
		1071,
		nil,
		1,
		0
	},
	[35710017] = {
		35710017,
		0,
		Lang.get(93263),
		35710,
		17,
		1071,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3
	},
	[35710018] = {
		35710018,
		0,
		Lang.get(27581),
		35710,
		18,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[35710019] = {
		35710019,
		0,
		Lang.get(93264),
		35710,
		19,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35710020] = {
		35710020,
		0,
		Lang.get(93265),
		35710,
		20,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[35710021] = {
		35710021,
		0,
		Lang.get(93266),
		35710,
		21,
		300,
		{
			RTResTalkAction[25]
		}
	},
	[35710022] = {
		35710022,
		0,
		Lang.get(93267),
		35710,
		22,
		1071,
		{
			RTResTalkAction[25]
		}
	},
	[35710023] = {
		35710023,
		0,
		Lang.get(93268),
		35710,
		23,
		1071,
		{
			RTResTalkAction[107]
		}
	},
	[35710024] = {
		35710024,
		0,
		Lang.get(93269),
		35710,
		24,
		1071,
		{
			RTResTalkAction[108]
		}
	},
	[35711001] = {
		35711001,
		0,
		Lang.get(93270),
		35711,
		1,
		215,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		122,
		35750,
		nil,
		nil,
		nil,
		nil,
		nil,
		35750
	},
	[35711002] = {
		35711002,
		0,
		Lang.get(93271),
		35711,
		2,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[35711003] = {
		35711003,
		0,
		Lang.get(93272),
		35711,
		3,
		112,
		{
			RTResTalkAction[109]
		}
	},
	[35711004] = {
		35711004,
		0,
		Lang.get(93273),
		35711,
		4,
		148,
		{
			RTResTalkAction[59],
			RTResTalkAction[110]
		}
	},
	[35711005] = {
		35711005,
		0,
		Lang.get(93274),
		35711,
		5,
		112,
		{
			RTResTalkAction[111],
			RTResTalkAction[41]
		}
	},
	[35711006] = {
		35711006,
		0,
		Lang.get(93275),
		35711,
		6,
		220,
		{
			RTResTalkAction[92],
			RTResTalkAction[47]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[35711007] = {
		35711007,
		0,
		Lang.get(93276),
		35711,
		7,
		215,
		{
			RTResTalkAction[112],
			RTResTalkAction[113]
		}
	},
	[35711008] = {
		35711008,
		0,
		Lang.get(93277),
		35711,
		8,
		112,
		{
			RTResTalkAction[48],
			RTResTalkAction[14],
			RTResTalkAction[13]
		},
		nil,
		nil,
		nil,
		nil,
		194
	},
	[35711009] = {
		35711009,
		0,
		Lang.get(93278),
		35711,
		9,
		225,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		}
	},
	[35711010] = {
		35711010,
		0,
		Lang.get(93279),
		35711,
		10,
		220,
		{
			RTResTalkAction[114],
			RTResTalkAction[91]
		}
	},
	[35711011] = {
		35711011,
		0,
		Lang.get(93280),
		35711,
		11,
		215,
		{
			RTResTalkAction[115],
			RTResTalkAction[14]
		}
	},
	[35711012] = {
		35711012,
		0,
		Lang.get(93281),
		35711,
		12,
		257,
		{
			RTResTalkAction[116],
			RTResTalkAction[13]
		},
		1,
		0,
		3,
		nil,
		nil,
		35751,
		1,
		1,
		nil,
		1,
		nil,
		35751,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[35711013] = {
		35711013,
		0,
		Lang.get(93282),
		35711,
		13,
		257,
		{
			RTResTalkAction[27]
		},
		1,
		0,
		[27] = 3
	},
	[35711014] = {
		35711014,
		13,
		Lang.get(77459),
		35711,
		14,
		261,
		{
			RTResTalkAction[27]
		},
		[27] = 3
	},
	[35711015] = {
		35711015,
		9,
		Lang.get(93283),
		35711,
		15,
		605,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		nil,
		1226,
		[22] = 1
	},
	[35711016] = {
		35711016,
		9,
		"……",
		35711,
		16,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		164,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		255,
		nil,
		1
	},
	[35711017] = {
		35711017,
		9,
		Lang.get(93284),
		35711,
		17,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		nil,
		35752,
		1,
		nil,
		nil,
		nil,
		nil,
		35752,
		0,
		nil,
		1
	},
	[35711018] = {
		35711018,
		0,
		Lang.get(93285),
		35711,
		18,
		257,
		nil,
		1
	},
	[35711019] = {
		35711019,
		0,
		Lang.get(93286),
		35711,
		19,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
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
