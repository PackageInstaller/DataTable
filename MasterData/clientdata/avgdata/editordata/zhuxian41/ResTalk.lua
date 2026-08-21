-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian41\\ResTalk.lua

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
	[2] = 767
}
RTResTalkAction[2] = {
	1,
	767,
	nil,
	nil,
	1
}
RTResTalkAction[3] = {
	1,
	767,
	nil,
	nil,
	3
}
RTResTalkAction[4] = {
	1,
	767,
	nil,
	nil,
	4
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 767
}
RTResTalkAction[6] = {
	1,
	767,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 767
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 1132
}
RTResTalkAction[9] = {
	2,
	767,
	nil,
	nil,
	1
}
RTResTalkAction[10] = {
	3,
	1132,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[11] = {
	2,
	767,
	nil,
	nil,
	4
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 767,
	[3] = {
		2
	}
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1132
}
RTResTalkAction[14] = {
	1,
	20,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	[1] = 2,
	[2] = 20
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 677
}
RTResTalkAction[17] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 677
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 770
}
RTResTalkAction[22] = {
	[1] = 2,
	[2] = 770
}
RTResTalkAction[23] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 770,
	[3] = {
		2
	}
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 1071,
	[3] = {
		1
	}
}
RTResTalkAction[26] = {
	[1] = 3,
	[2] = 1071,
	[3] = {
		2
	}
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 770,
	[3] = {
		1
	}
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[29] = {
	1,
	1071,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 770
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 257,
	[3] = {
		2
	}
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[35] = {
	1,
	1071,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[36] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[37] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[38] = {
	3,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[39] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[40] = {
	2,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[42] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[43] = {
	3,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[45] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[46] = {
	2,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[47] = {
	[1] = 2,
	[2] = 225
}
RTResTalkAction[48] = {
	2,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[50] = {
	1,
	112,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[51] = {
	1,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[52] = {
	2,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[53] = {
	[1] = 3,
	[2] = 194
}
RTResTalkAction[54] = {
	[1] = 2,
	[2] = 215,
	[3] = {
		2
	}
}
RTResTalkAction[55] = {
	2,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[56] = {
	[1] = 3,
	[2] = 194,
	[3] = {
		1
	}
}
RTResTalkAction[57] = {
	2,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[58] = {
	[1] = 2,
	[2] = 225,
	[3] = {
		2
	}
}
RTResTalkAction[59] = {
	1,
	194,
	nil,
	nil,
	1
}
RTResTalkAction[60] = {
	1,
	215,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[62] = {
	1,
	225,
	nil,
	nil,
	0
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		3
	}
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		3
	}
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 749,
	[3] = {
		2
	}
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 749
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[70] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[71] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[72] = {
	1,
	225,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 1132
}
RTResTalkAction[74] = {
	[1] = 2,
	[2] = 1132
}
RTResTalkAction[75] = {
	[1] = 3,
	[2] = 188,
	[3] = {
		2
	}
}
RTResTalkAction[76] = {
	[1] = 2,
	[2] = 1132,
	[3] = {
		1
	}
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 188
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[79] = {
	2,
	1132,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[80] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[81] = {
	3,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[82] = {
	2,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[83] = {
	3,
	220,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[85] = {
	1,
	215,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 194
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 3
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 3
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		2
	}
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 194,
	[3] = {
		2
	}
}
RTResTalkAction[91] = {
	1,
	194,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[92] = {
	1,
	158,
	{
		5
	},
	nil,
	5
}
RTResTalkAction[93] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[94] = {
	[1] = 3,
	[2] = 386
}
RTResTalkAction[95] = {
	[1] = 3,
	[2] = 386,
	[3] = {
		2
	}
}
RTResTalkAction[96] = {
	2,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[99] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[100] = {
	1,
	386,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[101] = {
	1,
	386,
	nil,
	nil,
	0
}
RTResTalkAction[102] = {
	1,
	158,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[103] = {
	1,
	230,
	nil,
	nil,
	0
}
RTResTalkAction[104] = {
	1,
	158,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[105] = {
	[1] = 0,
	[2] = 230
}
RTResTalkAction[106] = {
	1,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[107] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[108] = {
	1,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[109] = {
	1,
	188,
	nil,
	nil,
	0
}
RTResTalkAction[110] = {
	[1] = 2,
	[2] = 215,
	[3] = {
		3
	}
}
RTResTalkAction[111] = {
	3,
	1132,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[112] = {
	1,
	1132,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[113] = {
	2,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[114] = {
	2,
	215,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[115] = {
	3,
	1132,
	nil,
	nil,
	1
}
RTResTalkAction[116] = {
	1,
	107,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[117] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[118] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[119] = {
	2,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[120] = {
	3,
	141,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[121] = {
	1,
	133,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[122] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[123] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[124] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[125] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[126] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[127] = {
	[1] = 1,
	[2] = 107
}

local Data = {
	[36401001] = {
		36401001,
		0,
		Lang.get(97540),
		36401,
		1,
		767,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		164,
		36401,
		nil,
		nil,
		nil,
		nil,
		nil,
		36401,
		255
	},
	[36401002] = {
		36401002,
		0,
		Lang.get(97541),
		36401,
		2,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401003] = {
		36401003,
		0,
		Lang.get(97542),
		36401,
		3,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401004] = {
		36401004,
		0,
		Lang.get(97543),
		36401,
		4,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401005] = {
		36401005,
		0,
		Lang.get(97544),
		36401,
		5,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401006] = {
		36401006,
		0,
		Lang.get(97545),
		36401,
		6,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401007] = {
		36401007,
		0,
		Lang.get(97546),
		36401,
		7,
		767,
		{
			RTResTalkAction[2]
		},
		[20] = 255
	},
	[36401008] = {
		36401008,
		0,
		Lang.get(97547),
		36401,
		8,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401009] = {
		36401009,
		0,
		Lang.get(97548),
		36401,
		9,
		767,
		{
			RTResTalkAction[3]
		},
		[20] = 255
	},
	[36401010] = {
		36401010,
		0,
		Lang.get(97549),
		36401,
		10,
		767,
		{
			RTResTalkAction[1]
		},
		[20] = 255
	},
	[36401011] = {
		36401011,
		0,
		Lang.get(97550),
		36401,
		11,
		767,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = 255
	},
	[36401012] = {
		36401012,
		0,
		Lang.get(97551),
		36401,
		12,
		1132,
		{
			RTResTalkAction[5]
		},
		1,
		0,
		-1,
		nil,
		63,
		36402,
		1,
		1,
		nil,
		nil,
		nil,
		36402,
		0
	},
	[36401013] = {
		36401013,
		0,
		Lang.get(97552),
		36401,
		13,
		767,
		nil,
		1,
		1
	},
	[36401014] = {
		36401014,
		0,
		Lang.get(97553),
		36401,
		14,
		1132,
		nil,
		1
	},
	[36401015] = {
		36401015,
		0,
		Lang.get(97554),
		36401,
		15,
		767,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[36401016] = {
		36401016,
		0,
		Lang.get(97555),
		36401,
		16,
		767,
		{
			RTResTalkAction[1]
		}
	},
	[36401017] = {
		36401017,
		0,
		Lang.get(97556),
		36401,
		17,
		1132,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401018] = {
		36401018,
		0,
		Lang.get(97557),
		36401,
		18,
		767,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401019] = {
		36401019,
		0,
		Lang.get(97558),
		36401,
		19,
		1132,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401020] = {
		36401020,
		0,
		Lang.get(97559),
		36401,
		20,
		767,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401021] = {
		36401021,
		0,
		Lang.get(97560),
		36401,
		21,
		767,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401022] = {
		36401022,
		0,
		Lang.get(97561),
		36401,
		22,
		767,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[36401023] = {
		36401023,
		0,
		Lang.get(97562),
		36401,
		23,
		1132,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[36401024] = {
		36401024,
		0,
		Lang.get(97563),
		36401,
		24,
		767,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[36401025] = {
		36401025,
		0,
		Lang.get(97564),
		36401,
		25,
		767,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[36401026] = {
		36401026,
		0,
		"|101|……",
		36401,
		26,
		767,
		{
			RTResTalkAction[12],
			RTResTalkAction[8]
		}
	},
	[36401027] = {
		36401027,
		0,
		"|101|",
		36401,
		27,
		767,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		}
	},
	[36402001] = {
		36402001,
		0,
		Lang.get(97565),
		36402,
		1,
		220,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		36410,
		nil,
		nil,
		nil,
		nil,
		nil,
		36410
	},
	[36402002] = {
		36402002,
		0,
		Lang.get(97566),
		36402,
		2,
		215,
		nil,
		1,
		3
	},
	[36402003] = {
		36402003,
		0,
		Lang.get(97567),
		36402,
		3,
		677,
		nil,
		1,
		0
	},
	[36402004] = {
		36402004,
		0,
		Lang.get(97568),
		36402,
		4,
		112,
		nil,
		1,
		1
	},
	[36402005] = {
		36402005,
		0,
		Lang.get(97569),
		36402,
		5,
		20,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		36411,
		nil,
		nil,
		nil,
		nil,
		nil,
		36411
	},
	[36402006] = {
		36402006,
		0,
		Lang.get(97570),
		36402,
		6,
		215,
		nil,
		1,
		1
	},
	[36402007] = {
		36402007,
		0,
		Lang.get(97571),
		36402,
		7,
		112,
		nil,
		1,
		3
	},
	[36402008] = {
		36402008,
		0,
		Lang.get(97572),
		36402,
		8,
		20,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[36402009] = {
		36402009,
		0,
		Lang.get(97573),
		36402,
		9,
		677,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[36402010] = {
		36402010,
		0,
		Lang.get(97574),
		36402,
		10,
		20,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[36402011] = {
		36402011,
		0,
		Lang.get(97575),
		36402,
		11,
		20,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[36402012] = {
		36402012,
		0,
		Lang.get(97576),
		36402,
		12,
		112,
		{
			RTResTalkAction[17],
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[36402013] = {
		36402013,
		0,
		Lang.get(97577),
		36402,
		13,
		215,
		{
			RTResTalkAction[20]
		},
		1,
		3,
		-1,
		nil,
		59,
		36412,
		1,
		1,
		nil,
		1,
		nil,
		36412
	},
	[36402014] = {
		36402014,
		0,
		Lang.get(97578),
		36402,
		14,
		677,
		nil,
		1,
		0
	},
	[36402015] = {
		36402015,
		0,
		Lang.get(97579),
		36402,
		15,
		220,
		nil,
		1,
		0
	},
	[36402016] = {
		36402016,
		0,
		Lang.get(97580),
		36402,
		16,
		225,
		nil,
		1
	},
	[36402017] = {
		36402017,
		0,
		Lang.get(97581),
		36402,
		17,
		117,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36413,
		[19] = 36413
	},
	[36402018] = {
		36402018,
		0,
		Lang.get(97582),
		36402,
		18,
		677,
		nil,
		1
	},
	[36402019] = {
		36402019,
		0,
		Lang.get(97583),
		36402,
		19,
		117,
		nil,
		1
	},
	[36402020] = {
		36402020,
		0,
		Lang.get(97584),
		36402,
		20,
		215,
		nil,
		1,
		1
	},
	[36402021] = {
		36402021,
		0,
		Lang.get(97585),
		36402,
		21,
		117,
		nil,
		1,
		0
	},
	[36402022] = {
		36402022,
		0,
		Lang.get(97586),
		36402,
		22,
		117,
		nil,
		1
	},
	[36402023] = {
		36402023,
		0,
		Lang.get(97587),
		36402,
		23,
		117,
		nil,
		1
	},
	[36402024] = {
		36402024,
		0,
		Lang.get(97588),
		36402,
		24,
		117,
		nil,
		1
	},
	[36403001] = {
		36403001,
		0,
		Lang.get(97589),
		36403,
		1,
		1071,
		nil,
		1,
		0,
		nil,
		nil,
		190,
		36420,
		nil,
		nil,
		nil,
		nil,
		nil,
		36420
	},
	[36403002] = {
		36403002,
		0,
		Lang.get(97590),
		36403,
		2,
		1071,
		nil,
		1
	},
	[36403003] = {
		36403003,
		0,
		Lang.get(97591),
		36403,
		3,
		126,
		nil,
		1
	},
	[36403004] = {
		36403004,
		0,
		Lang.get(97592),
		36403,
		4,
		1071,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36421,
		[19] = 36421
	},
	[36403005] = {
		36403005,
		0,
		Lang.get(97593),
		36403,
		5,
		126,
		nil,
		1
	},
	[36403006] = {
		36403006,
		0,
		Lang.get(97594),
		36403,
		6,
		1071,
		nil,
		1
	},
	[36403007] = {
		36403007,
		0,
		Lang.get(97595),
		36403,
		7,
		770,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[36403008] = {
		36403008,
		0,
		Lang.get(97596),
		36403,
		8,
		770,
		{
			RTResTalkAction[21]
		}
	},
	[36403009] = {
		36403009,
		0,
		Lang.get(97597),
		36403,
		9,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403010] = {
		36403010,
		0,
		Lang.get(97598),
		36403,
		10,
		770,
		{
			RTResTalkAction[24],
			RTResTalkAction[23]
		}
	},
	[36403011] = {
		36403011,
		0,
		Lang.get(97599),
		36403,
		11,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403012] = {
		36403012,
		0,
		Lang.get(97600),
		36403,
		12,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403013] = {
		36403013,
		0,
		Lang.get(97601),
		36403,
		13,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403014] = {
		36403014,
		0,
		Lang.get(97602),
		36403,
		14,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[25]
		}
	},
	[36403015] = {
		36403015,
		0,
		Lang.get(97603),
		36403,
		15,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403016] = {
		36403016,
		0,
		Lang.get(97604),
		36403,
		16,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403017] = {
		36403017,
		0,
		Lang.get(97605),
		36403,
		17,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403018] = {
		36403018,
		0,
		Lang.get(97606),
		36403,
		18,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[26]
		}
	},
	[36403019] = {
		36403019,
		0,
		Lang.get(97607),
		36403,
		19,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403020] = {
		36403020,
		0,
		Lang.get(97608),
		36403,
		20,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403021] = {
		36403021,
		0,
		Lang.get(97609),
		36403,
		21,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403022] = {
		36403022,
		0,
		Lang.get(97610),
		36403,
		22,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403023] = {
		36403023,
		0,
		"……",
		36403,
		23,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[36403024] = {
		36403024,
		0,
		Lang.get(97611),
		36403,
		24,
		770,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[36403025] = {
		36403025,
		0,
		Lang.get(97612),
		36403,
		25,
		770,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[36403026] = {
		36403026,
		0,
		Lang.get(97613),
		36403,
		26,
		1071,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[36404001] = {
		36404001,
		0,
		Lang.get(97614),
		36404,
		1,
		20,
		nil,
		1,
		nil,
		nil,
		nil,
		8,
		36430,
		nil,
		nil,
		nil,
		nil,
		nil,
		36430
	},
	[36404002] = {
		36404002,
		0,
		Lang.get(97615),
		36404,
		2,
		112,
		nil,
		1,
		3
	},
	[36404003] = {
		36404003,
		0,
		Lang.get(97616),
		36404,
		3,
		112,
		nil,
		1,
		2
	},
	[36404004] = {
		36404004,
		0,
		Lang.get(97617),
		36404,
		4,
		20,
		nil,
		1,
		0
	},
	[36404005] = {
		36404005,
		0,
		Lang.get(97618),
		36404,
		5,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36431,
		nil,
		nil,
		nil,
		1,
		nil,
		36431,
		1
	},
	[36404006] = {
		36404006,
		0,
		Lang.get(97619),
		36404,
		6,
		112,
		nil,
		1,
		2,
		nil,
		nil,
		60
	},
	[36404007] = {
		36404007,
		3,
		Lang.get(97620),
		36404,
		7,
		605,
		[22] = 1
	},
	[36404008] = {
		36404008,
		13,
		Lang.get(97621),
		36404,
		8,
		257,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		[27] = 3
	},
	[36404009] = {
		36404009,
		0,
		Lang.get(97622),
		36404,
		9,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		3,
		[27] = 3
	},
	[36404010] = {
		36404010,
		13,
		Lang.get(97623),
		36404,
		10,
		257,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[36404011] = {
		36404011,
		0,
		Lang.get(97624),
		36404,
		11,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		3,
		[27] = 3
	},
	[36404012] = {
		36404012,
		13,
		Lang.get(97625),
		36404,
		12,
		257,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[36404013] = {
		36404013,
		0,
		Lang.get(97626),
		36404,
		13,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		1,
		[27] = 3
	},
	[36404014] = {
		36404014,
		0,
		Lang.get(97627),
		36404,
		14,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		[27] = 3
	},
	[36404015] = {
		36404015,
		0,
		Lang.get(97628),
		36404,
		15,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		3,
		[27] = 3
	},
	[36404016] = {
		36404016,
		13,
		Lang.get(97629),
		36404,
		16,
		257,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		[27] = 3
	},
	[36404017] = {
		36404017,
		0,
		Lang.get(25821),
		36404,
		17,
		112,
		{
			RTResTalkAction[31]
		},
		1,
		1,
		[27] = 3
	},
	[36404018] = {
		36404018,
		13,
		Lang.get(97630),
		36404,
		18,
		257,
		{
			RTResTalkAction[32]
		},
		[27] = 3
	},
	[36404019] = {
		36404019,
		0,
		Lang.get(97631),
		36404,
		19,
		261,
		{
			RTResTalkAction[33]
		},
		1,
		0,
		nil,
		nil,
		122,
		36432,
		nil,
		nil,
		nil,
		1,
		nil,
		36432,
		1
	},
	[36404020] = {
		36404020,
		0,
		Lang.get(97632),
		36404,
		20,
		1071,
		nil,
		1
	},
	[36404021] = {
		36404021,
		0,
		Lang.get(97633),
		36404,
		21,
		1071,
		nil,
		1
	},
	[36404022] = {
		36404022,
		0,
		Lang.get(97634),
		36404,
		22,
		261,
		nil,
		1
	},
	[36404023] = {
		36404023,
		0,
		Lang.get(97635),
		36404,
		23,
		1071,
		nil,
		1,
		1
	},
	[36404024] = {
		36404024,
		0,
		Lang.get(97636),
		36404,
		24,
		261,
		nil,
		1,
		0
	},
	[36404025] = {
		36404025,
		2,
		Lang.get(97637),
		36404,
		25,
		1071,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[36404026] = {
		36404026,
		2,
		Lang.get(97638),
		36404,
		26,
		1071,
		{
			RTResTalkAction[34]
		}
	},
	[36404027] = {
		36404027,
		0,
		Lang.get(97639),
		36404,
		27,
		1071,
		{
			RTResTalkAction[35]
		}
	},
	[36405001] = {
		36405001,
		0,
		Lang.get(97640),
		36405,
		1,
		29,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		36440,
		nil,
		nil,
		nil,
		nil,
		nil,
		36440
	},
	[36405002] = {
		36405002,
		0,
		Lang.get(97641),
		36405,
		2,
		1105,
		nil,
		1
	},
	[36405003] = {
		36405003,
		0,
		Lang.get(97642),
		36405,
		3,
		1127,
		nil,
		1
	},
	[36405004] = {
		36405004,
		0,
		Lang.get(97643),
		36405,
		4,
		215,
		nil,
		1,
		3
	},
	[36405005] = {
		36405005,
		0,
		Lang.get(97644),
		36405,
		5,
		220,
		nil,
		1,
		3
	},
	[36405006] = {
		36405006,
		0,
		Lang.get(97645),
		36405,
		6,
		225,
		nil,
		1,
		0
	},
	[36405007] = {
		36405007,
		0,
		Lang.get(97646),
		36405,
		7,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		36441,
		nil,
		nil,
		nil,
		nil,
		nil,
		36441
	},
	[36405008] = {
		36405008,
		0,
		Lang.get(97647),
		36405,
		8,
		112,
		nil,
		1,
		1
	},
	[36405009] = {
		36405009,
		0,
		Lang.get(97648),
		36405,
		9,
		215,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[36405010] = {
		36405010,
		0,
		Lang.get(97649),
		36405,
		10,
		112,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[36405011] = {
		36405011,
		0,
		Lang.get(97650),
		36405,
		11,
		215,
		{
			RTResTalkAction[37],
			RTResTalkAction[39]
		}
	},
	[36405012] = {
		36405012,
		0,
		Lang.get(97651),
		36405,
		12,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[36405013] = {
		36405013,
		0,
		Lang.get(97652),
		36405,
		13,
		112,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[36405014] = {
		36405014,
		0,
		Lang.get(97653),
		36405,
		14,
		112,
		{
			RTResTalkAction[42],
			RTResTalkAction[39]
		}
	},
	[36405015] = {
		36405015,
		0,
		Lang.get(97654),
		36405,
		15,
		215,
		{
			RTResTalkAction[37],
			RTResTalkAction[39],
			RTResTalkAction[44]
		}
	},
	[36405016] = {
		36405016,
		0,
		Lang.get(97655),
		36405,
		16,
		112,
		{
			RTResTalkAction[37],
			RTResTalkAction[45]
		}
	},
	[36405017] = {
		36405017,
		0,
		Lang.get(97656),
		36405,
		17,
		112,
		{
			RTResTalkAction[37],
			RTResTalkAction[39]
		}
	},
	[36405018] = {
		36405018,
		0,
		Lang.get(97657),
		36405,
		18,
		215,
		{
			RTResTalkAction[37],
			RTResTalkAction[39]
		}
	},
	[36405019] = {
		36405019,
		0,
		Lang.get(97658),
		36405,
		19,
		220,
		{
			RTResTalkAction[46],
			RTResTalkAction[39],
			RTResTalkAction[41]
		}
	},
	[36405020] = {
		36405020,
		0,
		Lang.get(97659),
		36405,
		20,
		112,
		{
			RTResTalkAction[40],
			RTResTalkAction[39]
		}
	},
	[36405021] = {
		36405021,
		0,
		Lang.get(97660),
		36405,
		21,
		225,
		{
			RTResTalkAction[47],
			RTResTalkAction[39],
			RTResTalkAction[44]
		}
	},
	[36405022] = {
		36405022,
		0,
		Lang.get(97661),
		36405,
		22,
		112,
		{
			RTResTalkAction[47],
			RTResTalkAction[39]
		}
	},
	[36405023] = {
		36405023,
		0,
		Lang.get(97662),
		36405,
		23,
		215,
		{
			RTResTalkAction[48],
			RTResTalkAction[39],
			RTResTalkAction[49]
		}
	},
	[36405024] = {
		36405024,
		0,
		Lang.get(97663),
		36405,
		24,
		112,
		{
			RTResTalkAction[37],
			RTResTalkAction[39]
		}
	},
	[36405025] = {
		36405025,
		0,
		Lang.get(97664),
		36405,
		25,
		112,
		{
			RTResTalkAction[50],
			RTResTalkAction[41]
		}
	},
	[36406001] = {
		36406001,
		0,
		Lang.get(97665),
		36406,
		1,
		215,
		nil,
		1,
		3,
		nil,
		nil,
		62,
		36450,
		nil,
		nil,
		nil,
		nil,
		nil,
		36450
	},
	[36406002] = {
		36406002,
		0,
		Lang.get(97666),
		36406,
		2,
		220,
		nil,
		1,
		0
	},
	[36406003] = {
		36406003,
		0,
		Lang.get(97667),
		36406,
		3,
		225,
		nil,
		1
	},
	[36406004] = {
		36406004,
		3,
		Lang.get(93196),
		36406,
		4,
		605,
		[22] = 1
	},
	[36406005] = {
		36406005,
		0,
		Lang.get(97668),
		36406,
		5,
		215,
		nil,
		1
	},
	[36406006] = {
		36406006,
		0,
		Lang.get(97669),
		36406,
		6,
		220,
		nil,
		1,
		1
	},
	[36406007] = {
		36406007,
		0,
		Lang.get(97670),
		36406,
		7,
		225,
		nil,
		1,
		0
	},
	[36406008] = {
		36406008,
		0,
		Lang.get(97671),
		36406,
		8,
		194,
		nil,
		1,
		1,
		nil,
		nil,
		122
	},
	[36406009] = {
		36406009,
		3,
		Lang.get(97672),
		36406,
		9,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36451,
		nil,
		nil,
		nil,
		1,
		nil,
		36451,
		nil,
		nil,
		1
	},
	[36406010] = {
		36406010,
		0,
		Lang.get(97673),
		36406,
		10,
		215,
		nil,
		1,
		0
	},
	[36406011] = {
		36406011,
		0,
		Lang.get(97674),
		36406,
		11,
		194,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[36406012] = {
		36406012,
		0,
		Lang.get(97675),
		36406,
		12,
		215,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[36406013] = {
		36406013,
		0,
		Lang.get(97676),
		36406,
		13,
		194,
		{
			RTResTalkAction[37],
			RTResTalkAction[53]
		}
	},
	[36406014] = {
		36406014,
		0,
		Lang.get(97677),
		36406,
		14,
		215,
		{
			RTResTalkAction[54],
			RTResTalkAction[53]
		}
	},
	[36406015] = {
		36406015,
		0,
		Lang.get(97678),
		36406,
		15,
		194,
		{
			RTResTalkAction[37],
			RTResTalkAction[53]
		}
	},
	[36406016] = {
		36406016,
		0,
		Lang.get(97679),
		36406,
		16,
		215,
		{
			RTResTalkAction[55],
			RTResTalkAction[53]
		}
	},
	[36406017] = {
		36406017,
		0,
		Lang.get(97680),
		36406,
		17,
		194,
		{
			RTResTalkAction[37],
			RTResTalkAction[56]
		}
	},
	[36406018] = {
		36406018,
		0,
		Lang.get(97681),
		36406,
		18,
		220,
		{
			RTResTalkAction[57],
			RTResTalkAction[53],
			RTResTalkAction[41]
		}
	},
	[36406019] = {
		36406019,
		0,
		Lang.get(97682),
		36406,
		19,
		194,
		{
			RTResTalkAction[42],
			RTResTalkAction[53]
		}
	},
	[36406020] = {
		36406020,
		0,
		Lang.get(97683),
		36406,
		20,
		220,
		{
			RTResTalkAction[40],
			RTResTalkAction[53]
		}
	},
	[36406021] = {
		36406021,
		3,
		Lang.get(75319),
		36406,
		21,
		605,
		{
			RTResTalkAction[42],
			RTResTalkAction[53]
		},
		nil,
		nil,
		nil,
		1230,
		[22] = 1
	},
	[36406022] = {
		36406022,
		0,
		Lang.get(97684),
		36406,
		22,
		225,
		{
			RTResTalkAction[58],
			RTResTalkAction[53],
			RTResTalkAction[44]
		}
	},
	[36406023] = {
		36406023,
		0,
		Lang.get(97685),
		36406,
		23,
		194,
		{
			RTResTalkAction[59],
			RTResTalkAction[49]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36406024] = {
		36406024,
		0,
		Lang.get(97686),
		36406,
		24,
		194,
		{
			RTResTalkAction[51]
		}
	},
	[36406025] = {
		36406025,
		0,
		Lang.get(97687),
		36406,
		25,
		215,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[36406026] = {
		36406026,
		0,
		Lang.get(97688),
		36406,
		26,
		225,
		{
			RTResTalkAction[62],
			RTResTalkAction[41]
		}
	},
	[36407001] = {
		36407001,
		5,
		Lang.get(67486),
		36407,
		1,
		749,
		nil,
		1,
		nil,
		nil,
		1231,
		60,
		36460,
		nil,
		nil,
		nil,
		nil,
		nil,
		36460
	},
	[36407002] = {
		36407002,
		0,
		Lang.get(97689),
		36407,
		2,
		215,
		nil,
		1
	},
	[36407003] = {
		36407003,
		0,
		Lang.get(97690),
		36407,
		3,
		220,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[36407004] = {
		36407004,
		5,
		Lang.get(97691),
		36407,
		4,
		225,
		{
			RTResTalkAction[64],
			RTResTalkAction[44]
		}
	},
	[36407005] = {
		36407005,
		5,
		Lang.get(97692),
		36407,
		5,
		220,
		{
			RTResTalkAction[65],
			RTResTalkAction[49]
		}
	},
	[36407006] = {
		36407006,
		0,
		Lang.get(97693),
		36407,
		6,
		225,
		{
			RTResTalkAction[64],
			RTResTalkAction[44]
		}
	},
	[36407007] = {
		36407007,
		0,
		Lang.get(42598),
		36407,
		7,
		749,
		{
			RTResTalkAction[66],
			RTResTalkAction[49]
		},
		nil,
		nil,
		nil,
		1231
	},
	[36407008] = {
		36407008,
		5,
		Lang.get(97694),
		36407,
		8,
		215,
		{
			RTResTalkAction[67],
			RTResTalkAction[68]
		}
	},
	[36407009] = {
		36407009,
		0,
		Lang.get(97695),
		36407,
		9,
		225,
		{
			RTResTalkAction[69],
			RTResTalkAction[41]
		}
	},
	[36407010] = {
		36407010,
		0,
		Lang.get(97696),
		36407,
		10,
		215,
		{
			RTResTalkAction[70],
			RTResTalkAction[49]
		}
	},
	[36407011] = {
		36407011,
		0,
		Lang.get(97697),
		36407,
		11,
		220,
		{
			RTResTalkAction[71],
			RTResTalkAction[41]
		}
	},
	[36407012] = {
		36407012,
		5,
		Lang.get(97698),
		36407,
		12,
		225,
		{
			RTResTalkAction[72],
			RTResTalkAction[44]
		}
	},
	[36407013] = {
		36407013,
		0,
		Lang.get(97699),
		36407,
		13,
		1132,
		{
			RTResTalkAction[49]
		},
		1,
		0,
		nil,
		nil,
		nil,
		36461,
		1,
		1,
		nil,
		1,
		nil,
		36461
	},
	[36407014] = {
		36407014,
		0,
		Lang.get(97700),
		36407,
		14,
		188,
		nil,
		1,
		0
	},
	[36407015] = {
		36407015,
		0,
		Lang.get(97701),
		36407,
		15,
		1132,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[36407016] = {
		36407016,
		0,
		Lang.get(97702),
		36407,
		16,
		1132,
		{
			RTResTalkAction[73]
		}
	},
	[36407017] = {
		36407017,
		0,
		Lang.get(97703),
		36407,
		17,
		188,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		},
		nil,
		nil,
		nil,
		nil,
		156
	},
	[36407018] = {
		36407018,
		0,
		Lang.get(97704),
		36407,
		18,
		1132,
		{
			RTResTalkAction[76],
			RTResTalkAction[77]
		}
	},
	[36407019] = {
		36407019,
		0,
		Lang.get(97705),
		36407,
		19,
		215,
		{
			RTResTalkAction[70],
			RTResTalkAction[13],
			RTResTalkAction[78]
		}
	},
	[36407020] = {
		36407020,
		0,
		Lang.get(97706),
		36407,
		20,
		1132,
		{
			RTResTalkAction[79],
			RTResTalkAction[80]
		}
	},
	[36407021] = {
		36407021,
		0,
		Lang.get(97707),
		36407,
		21,
		215,
		{
			RTResTalkAction[74],
			RTResTalkAction[81]
		}
	},
	[36407022] = {
		36407022,
		0,
		Lang.get(97708),
		36407,
		22,
		215,
		{
			RTResTalkAction[74],
			RTResTalkAction[80]
		}
	},
	[36407023] = {
		36407023,
		0,
		Lang.get(97709),
		36407,
		23,
		1132,
		{
			RTResTalkAction[82],
			RTResTalkAction[80]
		}
	},
	[36407024] = {
		36407024,
		0,
		Lang.get(97710),
		36407,
		24,
		188,
		{
			RTResTalkAction[74],
			RTResTalkAction[77],
			RTResTalkAction[41]
		}
	},
	[36407025] = {
		36407025,
		0,
		Lang.get(97711),
		36407,
		25,
		1132,
		{
			RTResTalkAction[73],
			RTResTalkAction[78]
		}
	},
	[36407026] = {
		36407026,
		0,
		Lang.get(97712),
		36407,
		26,
		220,
		{
			RTResTalkAction[74],
			RTResTalkAction[83]
		}
	},
	[36407027] = {
		36407027,
		0,
		Lang.get(97713),
		36407,
		27,
		1132,
		{
			RTResTalkAction[73],
			RTResTalkAction[44]
		}
	},
	[36407028] = {
		36407028,
		0,
		Lang.get(97714),
		36407,
		28,
		188,
		{
			RTResTalkAction[84],
			RTResTalkAction[13]
		}
	},
	[36407029] = {
		36407029,
		0,
		Lang.get(97715),
		36407,
		29,
		215,
		{
			RTResTalkAction[85],
			RTResTalkAction[78]
		}
	},
	[36408001] = {
		36408001,
		2,
		Lang.get(97716),
		36408,
		1,
		194,
		nil,
		1,
		0,
		nil,
		nil,
		122,
		36470,
		nil,
		nil,
		nil,
		nil,
		nil,
		36470
	},
	[36408002] = {
		36408002,
		2,
		Lang.get(97717),
		36408,
		2,
		194,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3
	},
	[36408003] = {
		36408003,
		0,
		Lang.get(97718),
		36408,
		3,
		3,
		{
			RTResTalkAction[87],
			RTResTalkAction[61]
		},
		nil,
		nil,
		nil,
		1231
	},
	[36408004] = {
		36408004,
		0,
		Lang.get(97719),
		36408,
		4,
		225,
		{
			RTResTalkAction[69],
			RTResTalkAction[88]
		}
	},
	[36408005] = {
		36408005,
		0,
		Lang.get(97720),
		36408,
		5,
		225,
		{
			RTResTalkAction[89]
		}
	},
	[36408006] = {
		36408006,
		2,
		Lang.get(97721),
		36408,
		6,
		194,
		{
			RTResTalkAction[86],
			RTResTalkAction[49]
		}
	},
	[36408007] = {
		36408007,
		2,
		Lang.get(97722),
		36408,
		7,
		194,
		{
			RTResTalkAction[86]
		}
	},
	[36408008] = {
		36408008,
		2,
		Lang.get(97723),
		36408,
		8,
		194,
		{
			RTResTalkAction[86]
		}
	},
	[36408009] = {
		36408009,
		2,
		Lang.get(97724),
		36408,
		9,
		194,
		{
			RTResTalkAction[86]
		}
	},
	[36408010] = {
		36408010,
		5,
		Lang.get(97725),
		36408,
		10,
		3,
		{
			RTResTalkAction[61]
		},
		1,
		nil,
		-1,
		1231,
		nil,
		36471,
		1,
		1,
		nil,
		1,
		nil,
		36471
	},
	[36408011] = {
		36408011,
		0,
		Lang.get(22255),
		36408,
		11,
		3,
		nil,
		1,
		nil,
		nil,
		1231
	},
	[36408012] = {
		36408012,
		2,
		Lang.get(97726),
		36408,
		12,
		194,
		nil,
		1,
		0
	},
	[36408013] = {
		36408013,
		2,
		Lang.get(97727),
		36408,
		13,
		194,
		nil,
		1
	},
	[36408014] = {
		36408014,
		2,
		Lang.get(97728),
		36408,
		14,
		194,
		{
			RTResTalkAction[90]
		},
		nil,
		nil,
		3,
		nil,
		63,
		36472,
		1,
		1,
		nil,
		1,
		nil,
		36472
	},
	[36408015] = {
		36408015,
		2,
		Lang.get(97729),
		36408,
		15,
		194,
		{
			RTResTalkAction[86]
		}
	},
	[36408016] = {
		36408016,
		2,
		Lang.get(97730),
		36408,
		16,
		194,
		{
			RTResTalkAction[86]
		}
	},
	[36408017] = {
		36408017,
		2,
		"……",
		36408,
		17,
		194,
		{
			RTResTalkAction[59]
		}
	},
	[36408018] = {
		36408018,
		2,
		Lang.get(97731),
		36408,
		18,
		194,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36409001] = {
		36409001,
		0,
		Lang.get(97732),
		36409,
		1,
		158,
		nil,
		1,
		6,
		nil,
		nil,
		14,
		36480,
		nil,
		nil,
		nil,
		nil,
		nil,
		36480
	},
	[36409002] = {
		36409002,
		0,
		Lang.get(97733),
		36409,
		2,
		386,
		nil,
		1
	},
	[36409003] = {
		36409003,
		0,
		Lang.get(97734),
		36409,
		3,
		158,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[36409004] = {
		36409004,
		0,
		Lang.get(97735),
		36409,
		4,
		386,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409005] = {
		36409005,
		0,
		Lang.get(97736),
		36409,
		5,
		158,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409006] = {
		36409006,
		0,
		Lang.get(97737),
		36409,
		6,
		386,
		{
			RTResTalkAction[93],
			RTResTalkAction[95]
		}
	},
	[36409007] = {
		36409007,
		0,
		Lang.get(97738),
		36409,
		7,
		158,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409008] = {
		36409008,
		0,
		Lang.get(97739),
		36409,
		8,
		386,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409009] = {
		36409009,
		0,
		Lang.get(97740),
		36409,
		9,
		158,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409010] = {
		36409010,
		0,
		Lang.get(97741),
		36409,
		10,
		386,
		{
			RTResTalkAction[93],
			RTResTalkAction[94]
		}
	},
	[36409011] = {
		36409011,
		0,
		Lang.get(97742),
		36409,
		11,
		386,
		{
			RTResTalkAction[93],
			RTResTalkAction[95]
		}
	},
	[36409012] = {
		36409012,
		0,
		Lang.get(97743),
		36409,
		12,
		158,
		{
			RTResTalkAction[96],
			RTResTalkAction[94]
		}
	},
	[36409013] = {
		36409013,
		0,
		Lang.get(97744),
		36409,
		13,
		158,
		{
			RTResTalkAction[97],
			RTResTalkAction[98]
		},
		1,
		5,
		-1,
		nil,
		nil,
		36481,
		1,
		1,
		nil,
		nil,
		nil,
		36481,
		1
	},
	[36409014] = {
		36409014,
		0,
		Lang.get(97745),
		36409,
		14,
		158,
		nil,
		1,
		5
	},
	[36409015] = {
		36409015,
		0,
		Lang.get(97746),
		36409,
		15,
		158,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3
	},
	[36409016] = {
		36409016,
		0,
		Lang.get(97747),
		36409,
		16,
		386,
		{
			RTResTalkAction[100],
			RTResTalkAction[97]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[36409017] = {
		36409017,
		0,
		Lang.get(97748),
		36409,
		17,
		158,
		{
			RTResTalkAction[99],
			RTResTalkAction[98]
		}
	},
	[36409018] = {
		36409018,
		0,
		Lang.get(97749),
		36409,
		18,
		386,
		{
			RTResTalkAction[101],
			RTResTalkAction[97]
		}
	},
	[36409019] = {
		36409019,
		0,
		Lang.get(97750),
		36409,
		19,
		158,
		{
			RTResTalkAction[102],
			RTResTalkAction[98]
		}
	},
	[36409020] = {
		36409020,
		0,
		Lang.get(97751),
		36409,
		20,
		230,
		{
			RTResTalkAction[103],
			RTResTalkAction[97]
		}
	},
	[36409021] = {
		36409021,
		0,
		Lang.get(18700),
		36409,
		21,
		158,
		{
			RTResTalkAction[104],
			RTResTalkAction[105]
		}
	},
	[36410001] = {
		36410001,
		0,
		Lang.get(97752),
		36410,
		1,
		1132,
		{
			RTResTalkAction[106]
		},
		nil,
		nil,
		3,
		nil,
		148,
		36490,
		nil,
		nil,
		nil,
		nil,
		nil,
		36490
	},
	[36410002] = {
		36410002,
		0,
		Lang.get(97753),
		36410,
		2,
		225,
		{
			RTResTalkAction[74],
			RTResTalkAction[107]
		}
	},
	[36410003] = {
		36410003,
		0,
		Lang.get(97754),
		36410,
		3,
		215,
		{
			RTResTalkAction[36],
			RTResTalkAction[13],
			RTResTalkAction[49]
		}
	},
	[36410004] = {
		36410004,
		0,
		Lang.get(97755),
		36410,
		4,
		220,
		{
			RTResTalkAction[108],
			RTResTalkAction[41]
		}
	},
	[36410005] = {
		36410005,
		0,
		Lang.get(97756),
		36410,
		5,
		188,
		{
			RTResTalkAction[109],
			RTResTalkAction[44]
		}
	},
	[36410006] = {
		36410006,
		0,
		Lang.get(97757),
		36410,
		6,
		1132,
		{
			RTResTalkAction[106],
			RTResTalkAction[78]
		}
	},
	[36410007] = {
		36410007,
		0,
		Lang.get(97758),
		36410,
		7,
		215,
		{
			RTResTalkAction[67],
			RTResTalkAction[13]
		}
	},
	[36410008] = {
		36410008,
		3,
		Lang.get(97759),
		36410,
		8,
		605,
		{
			RTResTalkAction[41]
		},
		[22] = 1
	},
	[36410009] = {
		36410009,
		0,
		Lang.get(97760),
		36410,
		9,
		1132,
		{
			RTResTalkAction[73]
		}
	},
	[36410010] = {
		36410010,
		5,
		Lang.get(97761),
		36410,
		10,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[8]
		}
	},
	[36410011] = {
		36410011,
		5,
		Lang.get(89501),
		36410,
		11,
		1132,
		{
			RTResTalkAction[37],
			RTResTalkAction[111]
		}
	},
	[36410012] = {
		36410012,
		3,
		Lang.get(97762),
		36410,
		12,
		605,
		{
			RTResTalkAction[41],
			RTResTalkAction[13]
		},
		[22] = 1
	},
	[36410013] = {
		36410013,
		9,
		Lang.get(97763),
		36410,
		13,
		605,
		nil,
		nil,
		nil,
		nil,
		1230,
		194,
		[22] = 1,
		[20] = 255
	},
	[36410014] = {
		36410014,
		3,
		Lang.get(97764),
		36410,
		14,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		36491,
		1,
		nil,
		nil,
		nil,
		nil,
		36491,
		-1,
		nil,
		1
	},
	[36410015] = {
		36410015,
		0,
		Lang.get(97765),
		36410,
		15,
		1132,
		{
			RTResTalkAction[112]
		},
		nil,
		nil,
		nil,
		nil,
		63
	},
	[36410016] = {
		36410016,
		0,
		Lang.get(97766),
		36410,
		16,
		215,
		{
			RTResTalkAction[113],
			RTResTalkAction[8]
		}
	},
	[36410017] = {
		36410017,
		0,
		Lang.get(97767),
		36410,
		17,
		215,
		{
			RTResTalkAction[37],
			RTResTalkAction[8]
		}
	},
	[36410018] = {
		36410018,
		0,
		Lang.get(97768),
		36410,
		18,
		1132,
		{
			RTResTalkAction[37],
			RTResTalkAction[8]
		}
	},
	[36410019] = {
		36410019,
		0,
		Lang.get(97769),
		36410,
		19,
		1132,
		{
			RTResTalkAction[37],
			RTResTalkAction[8]
		}
	},
	[36410020] = {
		36410020,
		0,
		Lang.get(97770),
		36410,
		20,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[8]
		}
	},
	[36410021] = {
		36410021,
		0,
		Lang.get(97771),
		36410,
		21,
		1132,
		{
			RTResTalkAction[37],
			RTResTalkAction[8]
		}
	},
	[36410022] = {
		36410022,
		0,
		Lang.get(66037),
		36410,
		22,
		215,
		{
			RTResTalkAction[114],
			RTResTalkAction[8]
		}
	},
	[36410023] = {
		36410023,
		3,
		Lang.get(97772),
		36410,
		23,
		605,
		{
			RTResTalkAction[37],
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[36410024] = {
		36410024,
		0,
		Lang.get(97773),
		36410,
		24,
		1132,
		{
			RTResTalkAction[37],
			RTResTalkAction[115]
		}
	},
	[36610001] = {
		36610001,
		13,
		Lang.get(97774),
		36610,
		1,
		257,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3,
		nil,
		8,
		36492,
		1,
		1,
		nil,
		1,
		nil,
		36492,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[36610002] = {
		36610002,
		4,
		nil,
		36610,
		2,
		300,
		{
			RTResTalkAction[31]
		},
		[27] = 3,
		[29] = {
			{
				id = 36610003,
				branch_content = Lang.get(97775)
			},
			{
				id = 36610003,
				branch_content = Lang.get(97776)
			}
		}
	},
	[36610003] = {
		36610003,
		13,
		Lang.get(97777),
		36610,
		3,
		257,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[36610004] = {
		36610004,
		4,
		nil,
		36610,
		4,
		300,
		{
			RTResTalkAction[31]
		},
		[27] = 3,
		[29] = {
			{
				id = 36610005,
				branch_content = Lang.get(97778)
			}
		}
	},
	[36610005] = {
		36610005,
		13,
		Lang.get(97779),
		36610,
		5,
		257,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[36610006] = {
		36610006,
		4,
		nil,
		36610,
		6,
		300,
		{
			RTResTalkAction[31]
		},
		[27] = 3,
		[29] = {
			{
				id = 36610007,
				branch_content = Lang.get(97780)
			},
			{
				id = 36610007,
				branch_content = Lang.get(97781)
			}
		}
	},
	[36610007] = {
		36610007,
		3,
		Lang.get(97782),
		36610,
		7,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1
	},
	[36610008] = {
		36610008,
		0,
		Lang.get(97783),
		36610,
		8,
		1223,
		nil,
		1,
		0,
		nil,
		nil,
		57
	},
	[36610009] = {
		36610009,
		0,
		Lang.get(19557),
		36610,
		9,
		300
	},
	[36610010] = {
		36610010,
		3,
		Lang.get(97784),
		36610,
		10,
		605,
		[22] = 1
	},
	[36610011] = {
		36610011,
		0,
		Lang.get(97785),
		36610,
		11,
		300,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		36493,
		[19] = 36493
	},
	[36610012] = {
		36610012,
		0,
		Lang.get(97786),
		36610,
		12,
		1223,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36610013] = {
		36610013,
		9,
		Lang.get(97787),
		36610,
		13,
		605,
		[22] = 1
	},
	[36411001] = {
		36411001,
		9,
		Lang.get(97788),
		36411,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		36500,
		[19] = 36500,
		[22] = 1
	},
	[36411002] = {
		36411002,
		0,
		"……",
		36411,
		2,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36411003] = {
		36411003,
		0,
		Lang.get(97789),
		36411,
		3,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36411004] = {
		36411004,
		0,
		Lang.get(97790),
		36411,
		4,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		36501,
		[19] = 36501
	},
	[36411005] = {
		36411005,
		0,
		Lang.get(97791),
		36411,
		5,
		300
	},
	[36411006] = {
		36411006,
		0,
		Lang.get(97792),
		36411,
		6,
		300
	},
	[36411007] = {
		36411007,
		0,
		Lang.get(97793),
		36411,
		7,
		107,
		nil,
		1,
		7
	},
	[36411008] = {
		36411008,
		0,
		Lang.get(97794),
		36411,
		8,
		300
	},
	[36411009] = {
		36411009,
		0,
		Lang.get(97795),
		36411,
		9,
		107,
		nil,
		1,
		5
	},
	[36411010] = {
		36411010,
		0,
		Lang.get(97796),
		36411,
		10,
		107,
		{
			RTResTalkAction[116]
		},
		nil,
		nil,
		3
	},
	[36411011] = {
		36411011,
		0,
		Lang.get(97797),
		36411,
		11,
		141,
		{
			RTResTalkAction[117],
			RTResTalkAction[118]
		}
	},
	[36411012] = {
		36411012,
		0,
		Lang.get(97798),
		36411,
		12,
		300,
		{
			RTResTalkAction[117],
			RTResTalkAction[118]
		}
	},
	[36411013] = {
		36411013,
		0,
		Lang.get(97799),
		36411,
		13,
		300,
		{
			RTResTalkAction[117],
			RTResTalkAction[118]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36411014] = {
		36411014,
		0,
		Lang.get(97800),
		36411,
		14,
		107,
		{
			RTResTalkAction[119],
			RTResTalkAction[118]
		}
	},
	[36411015] = {
		36411015,
		0,
		Lang.get(97801),
		36411,
		15,
		141,
		{
			RTResTalkAction[117],
			RTResTalkAction[120]
		}
	},
	[36411016] = {
		36411016,
		0,
		Lang.get(97802),
		36411,
		16,
		133,
		{
			RTResTalkAction[121],
			RTResTalkAction[122],
			RTResTalkAction[123]
		}
	},
	[36411017] = {
		36411017,
		0,
		Lang.get(97803),
		36411,
		17,
		133,
		{
			RTResTalkAction[124]
		}
	},
	[36411018] = {
		36411018,
		0,
		Lang.get(97804),
		36411,
		18,
		300,
		{
			RTResTalkAction[124]
		}
	},
	[36411019] = {
		36411019,
		0,
		Lang.get(97805),
		36411,
		19,
		107,
		{
			RTResTalkAction[125],
			RTResTalkAction[126]
		}
	},
	[36411020] = {
		36411020,
		0,
		Lang.get(97806),
		36411,
		20,
		300,
		{
			RTResTalkAction[127]
		}
	},
	[36411021] = {
		36411021,
		0,
		Lang.get(97807),
		36411,
		21,
		107,
		{
			RTResTalkAction[122]
		},
		1,
		0,
		-1,
		nil,
		nil,
		36502,
		1,
		1,
		nil,
		1,
		nil,
		36502
	},
	[36411022] = {
		36411022,
		4,
		nil,
		36411,
		22,
		107,
		[29] = {
			{
				id = 36411023,
				branch_content = Lang.get(97808)
			}
		}
	},
	[36411023] = {
		36411023,
		0,
		Lang.get(97809),
		36411,
		23,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		36503,
		1,
		nil,
		nil,
		nil,
		nil,
		36503
	},
	[36411024] = {
		36411024,
		0,
		Lang.get(97810),
		36411,
		24,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		nil,
		1
	},
	[36411025] = {
		36411025,
		0,
		Lang.get(97811),
		36411,
		25,
		300
	},
	[36411026] = {
		36411026,
		0,
		Lang.get(97812),
		36411,
		26,
		300
	},
	[36411027] = {
		36411027,
		0,
		Lang.get(97813),
		36411,
		27,
		107,
		nil,
		1,
		8
	},
	[36411028] = {
		36411028,
		0,
		Lang.get(97814),
		36411,
		28,
		300
	},
	[36411029] = {
		36411029,
		0,
		Lang.get(97815),
		36411,
		29,
		141,
		nil,
		1,
		1
	},
	[36411030] = {
		36411030,
		0,
		Lang.get(97816),
		36411,
		30,
		300
	},
	[36411031] = {
		36411031,
		0,
		Lang.get(97817),
		36411,
		31,
		107,
		nil,
		1,
		7
	},
	[36411032] = {
		36411032,
		0,
		Lang.get(97818),
		36411,
		32,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		36504
	},
	[36411033] = {
		36411033,
		0,
		"……",
		36411,
		33,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36411034] = {
		36411034,
		3,
		Lang.get(97819),
		36411,
		34,
		605,
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
	[36411035] = {
		36411035,
		4,
		nil,
		36411,
		35,
		605,
		[22] = 1,
		[29] = {
			{
				id = 36411036,
				branch_content = Lang.get(97820)
			}
		}
	},
	[36411036] = {
		36411036,
		0,
		Lang.get(97821),
		36411,
		36,
		767,
		nil,
		1,
		2
	},
	[36411037] = {
		36411037,
		0,
		Lang.get(97822),
		36411,
		37,
		767,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[36411038] = {
		36411038,
		0,
		Lang.get(97823),
		36411,
		38,
		767,
		nil,
		1,
		0
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
