-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2ndspecial\\ResTalk.lua

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
	[2] = 1089
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 286
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1089
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 122
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 286
}
RTResTalkAction[6] = {
	[1] = 4,
	[2] = 143
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 122
}
RTResTalkAction[8] = {
	[1] = 5,
	[2] = 286
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 143
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 122
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 286
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 1089
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 143
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 143
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 122
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1090
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[18] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[23] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[26] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[28] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 29
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[32] = {
	2,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[33] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 29
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 29
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 183
}
RTResTalkAction[37] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[38] = {
	3,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 183
}
RTResTalkAction[40] = {
	1,
	183,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 4,
	[2] = 133
}
RTResTalkAction[42] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[43] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[44] = {
	1,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[45] = {
	1,
	134,
	nil,
	nil,
	0
}
RTResTalkAction[46] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[47] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[48] = {
	2,
	1010,
	nil,
	nil,
	0
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 147
}
RTResTalkAction[50] = {
	[1] = 2,
	[2] = 1010
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1010
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 147
}
RTResTalkAction[53] = {
	[1] = 3,
	[2] = 101
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 101
}
RTResTalkAction[55] = {
	2,
	105,
	nil,
	nil,
	0
}
RTResTalkAction[56] = {
	[1] = 3,
	[2] = 103
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 105
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 105
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 103
}
RTResTalkAction[60] = {
	1,
	103,
	nil,
	nil,
	0
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 135
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 135
}
RTResTalkAction[63] = {
	1,
	135,
	nil,
	nil,
	0
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 105
}
RTResTalkAction[65] = {
	2,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 196
}
RTResTalkAction[67] = {
	2,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[68] = {
	3,
	196,
	nil,
	nil,
	1
}
RTResTalkAction[69] = {
	3,
	196,
	nil,
	nil,
	0
}
RTResTalkAction[70] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[71] = {
	[1] = 0,
	[2] = 196
}

local Data = {
	[33301001] = {
		33301001,
		0,
		Lang.get(85233),
		33301,
		1,
		122,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33301,
		nil,
		nil,
		nil,
		nil,
		nil,
		33301
	},
	[33301002] = {
		33301002,
		0,
		Lang.get(85234),
		33301,
		2,
		143,
		nil,
		1
	},
	[33301003] = {
		33301003,
		0,
		Lang.get(85235),
		33301,
		3,
		286,
		nil,
		1
	},
	[33301004] = {
		33301004,
		0,
		Lang.get(85236),
		33301,
		4,
		122,
		nil,
		1
	},
	[33301005] = {
		33301005,
		0,
		Lang.get(85237),
		33301,
		5,
		143,
		nil,
		1
	},
	[33301006] = {
		33301006,
		0,
		Lang.get(85238),
		33301,
		6,
		1089,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33301007] = {
		33301007,
		0,
		Lang.get(85239),
		33301,
		7,
		286,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33301008] = {
		33301008,
		0,
		Lang.get(85240),
		33301,
		8,
		122,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[33301009] = {
		33301009,
		0,
		Lang.get(85241),
		33301,
		9,
		143,
		{
			RTResTalkAction[6],
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[33301010] = {
		33301010,
		0,
		Lang.get(85242),
		33301,
		10,
		1089,
		{
			RTResTalkAction[1],
			RTResTalkAction[9],
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[33301011] = {
		33301011,
		0,
		Lang.get(85243),
		33301,
		11,
		286,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33301012] = {
		33301012,
		0,
		Lang.get(85244),
		33301,
		12,
		143,
		{
			RTResTalkAction[12],
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[33301013] = {
		33301013,
		0,
		Lang.get(85245),
		33301,
		13,
		122,
		{
			RTResTalkAction[14],
			RTResTalkAction[15],
			RTResTalkAction[3]
		}
	},
	[33301014] = {
		33301014,
		0,
		Lang.get(85246),
		33301,
		14,
		143,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33301015] = {
		33301015,
		0,
		Lang.get(85247),
		33301,
		15,
		122,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33301016] = {
		33301016,
		0,
		Lang.get(85238),
		33301,
		16,
		1089,
		{
			RTResTalkAction[1],
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[33301017] = {
		33301017,
		0,
		Lang.get(85248),
		33301,
		17,
		286,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33301018] = {
		33301018,
		0,
		Lang.get(85249),
		33301,
		18,
		1089,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[33301019] = {
		33301019,
		0,
		Lang.get(85250),
		33301,
		19,
		286,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[33301020] = {
		33301020,
		0,
		Lang.get(85251),
		33301,
		20,
		122,
		{
			RTResTalkAction[7],
			RTResTalkAction[3],
			RTResTalkAction[11]
		}
	},
	[33301021] = {
		33301021,
		0,
		Lang.get(85252),
		33301,
		21,
		286,
		{
			RTResTalkAction[12],
			RTResTalkAction[5],
			RTResTalkAction[10]
		}
	},
	[33301022] = {
		33301022,
		0,
		Lang.get(85253),
		33301,
		22,
		122,
		{
			RTResTalkAction[7],
			RTResTalkAction[3],
			RTResTalkAction[11]
		}
	},
	[33301023] = {
		33301023,
		0,
		Lang.get(85254),
		33301,
		23,
		143,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		62,
		33303,
		nil,
		nil,
		nil,
		nil,
		nil,
		33303
	},
	[33301024] = {
		33301024,
		0,
		Lang.get(85255),
		33301,
		24,
		286,
		nil,
		1
	},
	[33301025] = {
		33301025,
		3,
		Lang.get(85256),
		33301,
		25,
		286,
		[22] = 1
	},
	[33301026] = {
		33301026,
		0,
		Lang.get(85257),
		33301,
		26,
		122,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[33301027] = {
		33301027,
		0,
		Lang.get(85258),
		33301,
		27,
		286,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[33301028] = {
		33301028,
		0,
		Lang.get(85259),
		33301,
		28,
		122,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[33301029] = {
		33301029,
		0,
		Lang.get(85260),
		33301,
		29,
		1090,
		{
			RTResTalkAction[16],
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[33302001] = {
		33302001,
		10,
		"62",
		33302,
		1,
		1090,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		33302,
		nil,
		nil,
		nil,
		nil,
		nil,
		33302
	},
	[33302002] = {
		33302002,
		0,
		Lang.get(85261),
		33302,
		2,
		133,
		nil,
		1
	},
	[33302003] = {
		33302003,
		0,
		Lang.get(85262),
		33302,
		3,
		107,
		nil,
		1
	},
	[33302004] = {
		33302004,
		0,
		Lang.get(85263),
		33302,
		4,
		141,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33302005] = {
		33302005,
		0,
		Lang.get(85264),
		33302,
		5,
		134,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[33302006] = {
		33302006,
		0,
		Lang.get(85265),
		33302,
		6,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[33302007] = {
		33302007,
		0,
		Lang.get(85266),
		33302,
		7,
		133,
		{
			RTResTalkAction[22]
		},
		1,
		nil,
		nil,
		nil,
		62,
		33311,
		nil,
		nil,
		nil,
		nil,
		nil,
		33311
	},
	[33302008] = {
		33302008,
		0,
		Lang.get(85267),
		33302,
		8,
		141,
		nil,
		1
	},
	[33302009] = {
		33302009,
		0,
		Lang.get(85268),
		33302,
		9,
		107,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[33302010] = {
		33302010,
		0,
		Lang.get(85269),
		33302,
		10,
		134,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[33302011] = {
		33302011,
		0,
		Lang.get(85270),
		33302,
		11,
		141,
		{
			RTResTalkAction[26],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[33302012] = {
		33302012,
		0,
		Lang.get(85271),
		33302,
		12,
		107,
		{
			RTResTalkAction[26],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[33303001] = {
		33303001,
		0,
		Lang.get(85272),
		33303,
		1,
		134,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33313,
		nil,
		nil,
		nil,
		nil,
		nil,
		33313
	},
	[33303002] = {
		33303002,
		0,
		Lang.get(85273),
		33303,
		2,
		107,
		nil,
		1
	},
	[33303003] = {
		33303003,
		0,
		Lang.get(85274),
		33303,
		3,
		141,
		nil,
		1
	},
	[33303004] = {
		33303004,
		0,
		Lang.get(85275),
		33303,
		4,
		134,
		nil,
		1
	},
	[33303005] = {
		33303005,
		0,
		Lang.get(85276),
		33303,
		5,
		133,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[33303006] = {
		33303006,
		0,
		Lang.get(85277),
		33303,
		6,
		133,
		{
			RTResTalkAction[29]
		}
	},
	[33303007] = {
		33303007,
		0,
		Lang.get(85278),
		33303,
		7,
		29,
		{
			RTResTalkAction[24],
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[33303008] = {
		33303008,
		0,
		Lang.get(85279),
		33303,
		8,
		107,
		{
			RTResTalkAction[32],
			RTResTalkAction[30]
		}
	},
	[33303009] = {
		33303009,
		0,
		Lang.get(85280),
		33303,
		9,
		29,
		{
			RTResTalkAction[33],
			RTResTalkAction[30]
		}
	},
	[33303010] = {
		33303010,
		0,
		Lang.get(85281),
		33303,
		10,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[30]
		}
	},
	[33303011] = {
		33303011,
		0,
		Lang.get(85282),
		33303,
		11,
		29,
		{
			RTResTalkAction[24],
			RTResTalkAction[30]
		}
	},
	[33303012] = {
		33303012,
		0,
		Lang.get(85283),
		33303,
		12,
		134,
		{
			RTResTalkAction[18],
			RTResTalkAction[22],
			RTResTalkAction[34]
		}
	},
	[33303013] = {
		33303013,
		0,
		Lang.get(85284),
		33303,
		13,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[21]
		}
	},
	[33303014] = {
		33303014,
		0,
		Lang.get(85285),
		33303,
		14,
		29,
		{
			RTResTalkAction[35],
			RTResTalkAction[19]
		}
	},
	[33303015] = {
		33303015,
		0,
		Lang.get(85286),
		33303,
		15,
		29,
		{
			RTResTalkAction[35]
		}
	},
	[33304001] = {
		33304001,
		0,
		Lang.get(85287),
		33304,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		33304,
		nil,
		nil,
		nil,
		nil,
		nil,
		33304
	},
	[33304002] = {
		33304002,
		0,
		Lang.get(85288),
		33304,
		2,
		133,
		nil,
		1,
		0
	},
	[33304003] = {
		33304003,
		0,
		Lang.get(85289),
		33304,
		3,
		141,
		nil,
		1,
		0
	},
	[33304004] = {
		33304004,
		0,
		Lang.get(85290),
		33304,
		4,
		107,
		nil,
		1,
		8
	},
	[33304005] = {
		33304005,
		0,
		Lang.get(85291),
		33304,
		5,
		133,
		{
			RTResTalkAction[29]
		}
	},
	[33304006] = {
		33304006,
		0,
		Lang.get(85292),
		33304,
		6,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[31]
		}
	},
	[33304007] = {
		33304007,
		0,
		Lang.get(85293),
		33304,
		7,
		141,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		62,
		33312,
		nil,
		nil,
		nil,
		nil,
		nil,
		33312
	},
	[33304008] = {
		33304008,
		0,
		Lang.get(85294),
		33304,
		8,
		134,
		nil,
		1
	},
	[33304009] = {
		33304009,
		0,
		Lang.get(85295),
		33304,
		9,
		133,
		nil,
		1
	},
	[33304010] = {
		33304010,
		0,
		Lang.get(85296),
		33304,
		10,
		141,
		nil,
		1
	},
	[33304011] = {
		33304011,
		0,
		Lang.get(85297),
		33304,
		11,
		183,
		{
			RTResTalkAction[36]
		}
	},
	[33304012] = {
		33304012,
		0,
		Lang.get(85298),
		33304,
		12,
		107,
		{
			RTResTalkAction[37],
			RTResTalkAction[38],
			RTResTalkAction[39]
		}
	},
	[33304013] = {
		33304013,
		0,
		Lang.get(85299),
		33304,
		13,
		141,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[33304014] = {
		33304014,
		0,
		Lang.get(85300),
		33304,
		14,
		107,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[33304015] = {
		33304015,
		0,
		Lang.get(85301),
		33304,
		15,
		183,
		{
			RTResTalkAction[40],
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[33304016] = {
		33304016,
		0,
		Lang.get(85302),
		33304,
		16,
		183,
		{
			RTResTalkAction[36]
		}
	},
	[33304017] = {
		33304017,
		0,
		Lang.get(85303),
		33304,
		17,
		141,
		{
			RTResTalkAction[17],
			RTResTalkAction[39]
		}
	},
	[33305001] = {
		33305001,
		0,
		Lang.get(85304),
		33305,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		33305,
		nil,
		nil,
		nil,
		nil,
		nil,
		33305
	},
	[33305002] = {
		33305002,
		0,
		Lang.get(85305),
		33305,
		2,
		183,
		nil,
		1,
		0
	},
	[33305003] = {
		33305003,
		0,
		Lang.get(85306),
		33305,
		3,
		183,
		nil,
		1,
		0
	},
	[33305004] = {
		33305004,
		0,
		Lang.get(85307),
		33305,
		4,
		107,
		nil,
		1,
		2
	},
	[33305005] = {
		33305005,
		0,
		Lang.get(85308),
		33305,
		5,
		134,
		nil,
		1,
		4
	},
	[33305006] = {
		33305006,
		0,
		Lang.get(85309),
		33305,
		6,
		133,
		{
			RTResTalkAction[41],
			RTResTalkAction[27],
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[33305007] = {
		33305007,
		0,
		Lang.get(85310),
		33305,
		7,
		134,
		{
			RTResTalkAction[41],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[33305008] = {
		33305008,
		0,
		Lang.get(85311),
		33305,
		8,
		141,
		{
			RTResTalkAction[41],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[33305009] = {
		33305009,
		0,
		Lang.get(85312),
		33305,
		9,
		133,
		{
			RTResTalkAction[41],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[33305010] = {
		33305010,
		0,
		Lang.get(85313),
		33305,
		10,
		134,
		{
			RTResTalkAction[41],
			RTResTalkAction[42],
			RTResTalkAction[28]
		}
	},
	[33305011] = {
		33305011,
		0,
		Lang.get(85314),
		33305,
		11,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[31],
			RTResTalkAction[21],
			RTResTalkAction[19]
		}
	},
	[33305012] = {
		33305012,
		0,
		Lang.get(85315),
		33305,
		12,
		141,
		{
			RTResTalkAction[44],
			RTResTalkAction[22]
		}
	},
	[33305013] = {
		33305013,
		0,
		Lang.get(85316),
		33305,
		13,
		134,
		{
			RTResTalkAction[45],
			RTResTalkAction[19]
		}
	},
	[33305014] = {
		33305014,
		0,
		Lang.get(85317),
		33305,
		14,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[21]
		}
	},
	[33306001] = {
		33306001,
		0,
		Lang.get(85318),
		33306,
		1,
		147,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		33306,
		nil,
		nil,
		nil,
		nil,
		nil,
		33306
	},
	[33306002] = {
		33306002,
		0,
		Lang.get(85319),
		33306,
		2,
		147,
		nil,
		1
	},
	[33306003] = {
		33306003,
		0,
		Lang.get(85320),
		33306,
		3,
		1010,
		nil,
		1
	},
	[33306004] = {
		33306004,
		0,
		Lang.get(85321),
		33306,
		4,
		107,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[33306005] = {
		33306005,
		0,
		Lang.get(85322),
		33306,
		5,
		107,
		{
			RTResTalkAction[47]
		}
	},
	[33306006] = {
		33306006,
		0,
		Lang.get(85323),
		33306,
		6,
		1010,
		{
			RTResTalkAction[48],
			RTResTalkAction[49],
			RTResTalkAction[22]
		}
	},
	[33306007] = {
		33306007,
		0,
		Lang.get(85324),
		33306,
		7,
		147,
		{
			RTResTalkAction[50],
			RTResTalkAction[49]
		}
	},
	[33306008] = {
		33306008,
		0,
		Lang.get(85325),
		33306,
		8,
		101,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		},
		1,
		nil,
		nil,
		nil,
		62,
		33310,
		nil,
		nil,
		nil,
		nil,
		nil,
		33310
	},
	[33306009] = {
		33306009,
		0,
		Lang.get(85326),
		33306,
		9,
		107,
		nil,
		1
	},
	[33306010] = {
		33306010,
		0,
		Lang.get(85327),
		33306,
		10,
		1010,
		nil,
		1
	},
	[33306011] = {
		33306011,
		0,
		Lang.get(85328),
		33306,
		11,
		101,
		{
			RTResTalkAction[50],
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[33306012] = {
		33306012,
		0,
		Lang.get(85329),
		33306,
		12,
		1010,
		{
			RTResTalkAction[50],
			RTResTalkAction[53]
		}
	},
	[33306013] = {
		33306013,
		0,
		Lang.get(85330),
		33306,
		13,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[51],
			RTResTalkAction[54]
		}
	},
	[33306014] = {
		33306014,
		0,
		Lang.get(85331),
		33306,
		14,
		147,
		{
			RTResTalkAction[33],
			RTResTalkAction[49]
		}
	},
	[33306015] = {
		33306015,
		0,
		Lang.get(85332),
		33306,
		15,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[49]
		}
	},
	[33307001] = {
		33307001,
		0,
		Lang.get(85333),
		33307,
		1,
		105,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33307,
		nil,
		nil,
		nil,
		nil,
		nil,
		33307
	},
	[33307002] = {
		33307002,
		0,
		Lang.get(85334),
		33307,
		2,
		103,
		nil,
		1
	},
	[33307003] = {
		33307003,
		0,
		Lang.get(85335),
		33307,
		3,
		135,
		nil,
		1
	},
	[33307004] = {
		33307004,
		0,
		Lang.get(85336),
		33307,
		4,
		103,
		nil,
		1
	},
	[33307005] = {
		33307005,
		0,
		Lang.get(85337),
		33307,
		5,
		107,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[33307006] = {
		33307006,
		0,
		Lang.get(85338),
		33307,
		6,
		105,
		{
			RTResTalkAction[55],
			RTResTalkAction[56],
			RTResTalkAction[22]
		}
	},
	[33307007] = {
		33307007,
		0,
		Lang.get(85339),
		33307,
		7,
		103,
		{
			RTResTalkAction[57],
			RTResTalkAction[56]
		}
	},
	[33307008] = {
		33307008,
		0,
		Lang.get(85340),
		33307,
		8,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[33307009] = {
		33307009,
		0,
		Lang.get(85341),
		33307,
		9,
		103,
		{
			RTResTalkAction[60],
			RTResTalkAction[22]
		}
	},
	[33307010] = {
		33307010,
		0,
		Lang.get(85342),
		33307,
		10,
		135,
		{
			RTResTalkAction[61],
			RTResTalkAction[59]
		}
	},
	[33307011] = {
		33307011,
		3,
		Lang.get(85343),
		33307,
		11,
		135,
		{
			RTResTalkAction[62]
		},
		[22] = 1
	},
	[33307012] = {
		33307012,
		0,
		Lang.get(85344),
		33307,
		12,
		107,
		{
			RTResTalkAction[43]
		}
	},
	[33307013] = {
		33307013,
		0,
		Lang.get(85345),
		33307,
		13,
		135,
		{
			RTResTalkAction[63],
			RTResTalkAction[22]
		}
	},
	[33307014] = {
		33307014,
		0,
		Lang.get(85346),
		33307,
		14,
		105,
		{
			RTResTalkAction[64],
			RTResTalkAction[62]
		}
	},
	[33307015] = {
		33307015,
		0,
		Lang.get(85347),
		33307,
		15,
		135,
		{
			RTResTalkAction[61],
			RTResTalkAction[58]
		}
	},
	[33307016] = {
		33307016,
		0,
		Lang.get(85348),
		33307,
		16,
		107,
		{
			RTResTalkAction[47],
			RTResTalkAction[62]
		}
	},
	[33308001] = {
		33308001,
		0,
		Lang.get(85349),
		33308,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		62,
		33308,
		nil,
		nil,
		nil,
		nil,
		nil,
		33308
	},
	[33308002] = {
		33308002,
		0,
		Lang.get(85350),
		33308,
		2,
		196,
		nil,
		1,
		1
	},
	[33308003] = {
		33308003,
		0,
		Lang.get(85351),
		33308,
		3,
		107,
		nil,
		1,
		8
	},
	[33308004] = {
		33308004,
		0,
		Lang.get(85352),
		33308,
		4,
		196,
		nil,
		1,
		0
	},
	[33308005] = {
		33308005,
		0,
		Lang.get(85353),
		33308,
		5,
		107,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[33308006] = {
		33308006,
		0,
		Lang.get(85354),
		33308,
		6,
		196,
		{
			RTResTalkAction[24],
			RTResTalkAction[66]
		}
	},
	[33308007] = {
		33308007,
		0,
		Lang.get(85355),
		33308,
		7,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[66]
		}
	},
	[33308008] = {
		33308008,
		0,
		Lang.get(85356),
		33308,
		8,
		196,
		{
			RTResTalkAction[24],
			RTResTalkAction[68]
		}
	},
	[33308009] = {
		33308009,
		0,
		Lang.get(85357),
		33308,
		9,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[69]
		}
	},
	[33308010] = {
		33308010,
		0,
		Lang.get(85358),
		33308,
		10,
		196,
		{
			RTResTalkAction[24],
			RTResTalkAction[69]
		}
	},
	[33308011] = {
		33308011,
		0,
		Lang.get(85359),
		33308,
		11,
		196,
		{
			RTResTalkAction[24],
			RTResTalkAction[68]
		}
	},
	[33308012] = {
		33308012,
		0,
		Lang.get(85360),
		33308,
		12,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[33308013] = {
		33308013,
		0,
		Lang.get(85361),
		33308,
		13,
		107,
		{
			RTResTalkAction[22]
		},
		1,
		6,
		nil,
		nil,
		62,
		33309,
		nil,
		nil,
		nil,
		nil,
		nil,
		33309
	},
	[33308014] = {
		33308014,
		0,
		Lang.get(85362),
		33308,
		14,
		107,
		nil,
		1,
		6
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
