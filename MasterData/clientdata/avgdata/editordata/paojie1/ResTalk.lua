-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojie1\\ResTalk.lua

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
	[2] = 752
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 752
}
RTResTalkAction[3] = {
	[1] = 2,
	[2] = 751
}
RTResTalkAction[4] = {
	[1] = 3,
	[2] = 753
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 751
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 753
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 578
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 538
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 578
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 751
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 538
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 753
}
RTResTalkAction[13] = {
	1,
	753,
	nil,
	nil,
	1
}
RTResTalkAction[14] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[16] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[17] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[18] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[20] = {
	1,
	753,
	nil,
	nil,
	2
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[22] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[24] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 766
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 766
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 584
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 584
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 53
}
RTResTalkAction[30] = {
	[1] = 0,
	[2] = 53
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 584,
	[3] = {
		1
	}
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 53,
	[3] = {
		1
	}
}
RTResTalkAction[33] = {
	2,
	751,
	nil,
	nil,
	2
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 129
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 129
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 138
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 138
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 756
}
RTResTalkAction[39] = {
	1,
	751,
	nil,
	nil,
	3
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 756
}
RTResTalkAction[41] = {
	2,
	751,
	nil,
	nil,
	3
}
RTResTalkAction[42] = {
	3,
	753,
	nil,
	nil,
	1
}
RTResTalkAction[43] = {
	2,
	751,
	nil,
	nil,
	1
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 764
}
RTResTalkAction[45] = {
	[1] = 1,
	[2] = 55
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 764
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 55
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 764,
	[3] = {
		1
	}
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[51] = {
	1,
	751,
	nil,
	nil,
	2
}
RTResTalkAction[52] = {
	1,
	751,
	nil,
	nil,
	1
}
RTResTalkAction[53] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[54] = {
	1,
	751,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 760,
	[3] = {
		1
	}
}
RTResTalkAction[56] = {
	[1] = 0,
	[2] = 760
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 760
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 763
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 763
}
RTResTalkAction[60] = {
	[1] = 2,
	[2] = 763
}
RTResTalkAction[61] = {
	[1] = 3,
	[2] = 762
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 762
}
RTResTalkAction[63] = {
	[1] = 3,
	[2] = 764
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 763,
	[3] = {
		3
	}
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 751,
	[3] = {
		3
	}
}
RTResTalkAction[66] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 13
}
RTResTalkAction[68] = {
	1,
	753,
	nil,
	nil,
	0
}
RTResTalkAction[69] = {
	[1] = 0,
	[2] = 13
}
RTResTalkAction[70] = {
	[1] = 0,
	[2] = 762
}
RTResTalkAction[71] = {
	[1] = 2,
	[2] = 762
}
RTResTalkAction[72] = {
	3,
	753,
	nil,
	nil,
	3
}
RTResTalkAction[73] = {
	[1] = 2,
	[2] = 13
}
RTResTalkAction[74] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[75] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[76] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		3
	}
}

local Data = {
	[24401001] = {
		24401001,
		0,
		Lang.get(68185),
		24401,
		1,
		750,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		24401,
		nil,
		1,
		nil,
		nil,
		nil,
		24401
	},
	[24401002] = {
		24401002,
		7,
		"81",
		24401,
		2,
		750
	},
	[24401003] = {
		24401003,
		0,
		Lang.get(68186),
		24401,
		3,
		750,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		24431,
		nil,
		1,
		nil,
		nil,
		nil,
		24431
	},
	[24401004] = {
		24401004,
		0,
		Lang.get(68187),
		24401,
		4,
		752,
		nil,
		1
	},
	[24401005] = {
		24401005,
		0,
		Lang.get(68188),
		24401,
		5,
		752,
		nil,
		1,
		[20] = -1
	},
	[24401006] = {
		24401006,
		7,
		"82",
		24401,
		6,
		752
	},
	[24401007] = {
		24401007,
		0,
		Lang.get(68189),
		24401,
		7,
		750,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		24432,
		nil,
		1,
		nil,
		nil,
		nil,
		24432
	},
	[24401008] = {
		24401008,
		0,
		Lang.get(68190),
		24401,
		8,
		752,
		nil,
		1
	},
	[24401009] = {
		24401009,
		0,
		Lang.get(68191),
		24401,
		9,
		750,
		nil,
		1
	},
	[24401010] = {
		24401010,
		0,
		Lang.get(68192),
		24401,
		10,
		752,
		nil,
		1
	},
	[24401011] = {
		24401011,
		0,
		Lang.get(68193),
		24401,
		11,
		750,
		nil,
		1
	},
	[24401012] = {
		24401012,
		0,
		Lang.get(68194),
		24401,
		12,
		750,
		nil,
		1
	},
	[24401013] = {
		24401013,
		0,
		Lang.get(68195),
		24401,
		13,
		752,
		nil,
		1
	},
	[24401014] = {
		24401014,
		0,
		Lang.get(68196),
		24401,
		14,
		750,
		nil,
		1
	},
	[24401015] = {
		24401015,
		2,
		Lang.get(68197),
		24401,
		15,
		752,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24428,
		nil,
		1,
		nil,
		nil,
		nil,
		24428
	},
	[24401016] = {
		24401016,
		2,
		Lang.get(70754),
		24401,
		16,
		752,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5
	},
	[24401017] = {
		24401017,
		2,
		Lang.get(68199),
		24401,
		17,
		752,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		5
	},
	[24401018] = {
		24401018,
		0,
		Lang.get(68200),
		24401,
		18,
		750,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		-1
	},
	[24401019] = {
		24401019,
		0,
		Lang.get(68201),
		24401,
		19,
		752,
		nil,
		1
	},
	[24410001] = {
		24410001,
		0,
		Lang.get(68202),
		24410,
		1,
		751,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		3,
		24427,
		nil,
		1,
		nil,
		nil,
		nil,
		24427
	},
	[24410002] = {
		24410002,
		0,
		Lang.get(68203),
		24410,
		2,
		751,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24410003] = {
		24410003,
		0,
		Lang.get(68204),
		24410,
		3,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24410004] = {
		24410004,
		0,
		Lang.get(22381),
		24410,
		4,
		751,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		3,
		-1
	},
	[24410005] = {
		24410005,
		0,
		Lang.get(68205),
		24410,
		5,
		753,
		nil,
		1
	},
	[24410006] = {
		24410006,
		0,
		Lang.get(68206),
		24410,
		6,
		751,
		nil,
		1
	},
	[24410007] = {
		24410007,
		0,
		Lang.get(68207),
		24410,
		7,
		578,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		5
	},
	[24410008] = {
		24410008,
		0,
		Lang.get(68208),
		24410,
		8,
		538,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		nil,
		nil,
		5
	},
	[24410009] = {
		24410009,
		0,
		Lang.get(68209),
		24410,
		9,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		nil,
		nil,
		5
	},
	[24410010] = {
		24410010,
		0,
		Lang.get(68210),
		24410,
		10,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24410011] = {
		24410011,
		0,
		Lang.get(68211),
		24410,
		11,
		753,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		24433,
		nil,
		1,
		nil,
		nil,
		nil,
		24433
	},
	[24410012] = {
		24410012,
		0,
		"……",
		24410,
		12,
		753,
		nil,
		1
	},
	[24420001] = {
		24420001,
		0,
		Lang.get(68212),
		24420,
		1,
		753,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		5,
		nil,
		62,
		24403,
		nil,
		1,
		nil,
		nil,
		nil,
		24403
	},
	[24420002] = {
		24420002,
		0,
		Lang.get(68213),
		24420,
		2,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24420003] = {
		24420003,
		0,
		Lang.get(68214),
		24420,
		3,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24420004] = {
		24420004,
		0,
		Lang.get(68215),
		24420,
		4,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24420005] = {
		24420005,
		0,
		Lang.get(68216),
		24420,
		5,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24420006] = {
		24420006,
		0,
		Lang.get(68217),
		24420,
		6,
		133,
		{
			RTResTalkAction[17],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24420007] = {
		24420007,
		0,
		Lang.get(68218),
		24420,
		7,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24420008] = {
		24420008,
		0,
		Lang.get(68219),
		24420,
		8,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24420009] = {
		24420009,
		0,
		Lang.get(68220),
		24420,
		9,
		107,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		-1
	},
	[24420010] = {
		24420010,
		0,
		Lang.get(68221),
		24420,
		10,
		107,
		nil,
		1
	},
	[24420011] = {
		24420011,
		0,
		Lang.get(68222),
		24420,
		11,
		107,
		nil,
		1
	},
	[24420012] = {
		24420012,
		0,
		Lang.get(68223),
		24420,
		12,
		751,
		nil,
		1,
		1
	},
	[24420013] = {
		24420013,
		0,
		Lang.get(68224),
		24420,
		13,
		107,
		nil,
		1
	},
	[24420014] = {
		24420014,
		0,
		Lang.get(68225),
		24420,
		14,
		107,
		nil,
		1,
		5
	},
	[24420015] = {
		24420015,
		0,
		Lang.get(68226),
		24420,
		15,
		753,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5
	},
	[24420016] = {
		24420016,
		0,
		Lang.get(68227),
		24420,
		16,
		753,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		5
	},
	[24420017] = {
		24420017,
		0,
		Lang.get(68228),
		24420,
		17,
		141,
		{
			RTResTalkAction[21],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24420018] = {
		24420018,
		0,
		Lang.get(68229),
		24420,
		18,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		},
		nil,
		2,
		5
	},
	[24420019] = {
		24420019,
		0,
		Lang.get(68230),
		24420,
		19,
		753,
		{
			RTResTalkAction[20],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24420020] = {
		24420020,
		0,
		Lang.get(68231),
		24420,
		20,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[6]
		},
		nil,
		1,
		5
	},
	[24430001] = {
		24430001,
		0,
		Lang.get(68232),
		24430,
		1,
		751,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		60,
		24404,
		nil,
		1,
		nil,
		nil,
		nil,
		24404
	},
	[24430002] = {
		24430002,
		0,
		Lang.get(68233),
		24430,
		2,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24430003] = {
		24430003,
		2,
		Lang.get(68234),
		24430,
		3,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24430004] = {
		24430004,
		0,
		Lang.get(68235),
		24430,
		4,
		751,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		1,
		-1
	},
	[24430005] = {
		24430005,
		0,
		Lang.get(68236),
		24430,
		5,
		766,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		5
	},
	[24430006] = {
		24430006,
		0,
		Lang.get(68237),
		24430,
		6,
		766,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		5
	},
	[24430007] = {
		24430007,
		0,
		Lang.get(68238),
		24430,
		7,
		584,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		24434,
		nil,
		1,
		nil,
		nil,
		nil,
		24434
	},
	[24430008] = {
		24430008,
		0,
		Lang.get(68239),
		24430,
		8,
		584,
		nil,
		1
	},
	[24430009] = {
		24430009,
		0,
		Lang.get(68240),
		24430,
		9,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24430010] = {
		24430010,
		0,
		Lang.get(68241),
		24430,
		10,
		584,
		{
			RTResTalkAction[27],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24430011] = {
		24430011,
		0,
		Lang.get(68242),
		24430,
		11,
		584,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5
	},
	[24430012] = {
		24430012,
		0,
		Lang.get(68243),
		24430,
		12,
		584,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5
	},
	[24430013] = {
		24430013,
		0,
		Lang.get(68244),
		24430,
		13,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[28]
		},
		nil,
		nil,
		5
	},
	[24430014] = {
		24430014,
		0,
		Lang.get(68245),
		24430,
		14,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24430015] = {
		24430015,
		0,
		Lang.get(68246),
		24430,
		15,
		55,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		24435,
		nil,
		1,
		nil,
		nil,
		nil,
		24435
	},
	[24430016] = {
		24430016,
		0,
		Lang.get(68247),
		24430,
		16,
		53,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		5
	},
	[24430017] = {
		24430017,
		5,
		Lang.get(68248),
		24430,
		17,
		584,
		{
			RTResTalkAction[31],
			RTResTalkAction[30]
		},
		nil,
		nil,
		5
	},
	[24430018] = {
		24430018,
		0,
		Lang.get(68249),
		24430,
		18,
		53,
		{
			RTResTalkAction[32],
			RTResTalkAction[28]
		},
		nil,
		nil,
		5
	},
	[24430019] = {
		24430019,
		0,
		"……",
		24430,
		19,
		761,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		-1
	},
	[24430020] = {
		24430020,
		0,
		Lang.get(68250),
		24430,
		20,
		753,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5
	},
	[24430021] = {
		24430021,
		0,
		Lang.get(68251),
		24430,
		21,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24440001] = {
		24440001,
		0,
		Lang.get(68252),
		24440,
		1,
		584,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5,
		nil,
		137,
		24405,
		nil,
		1,
		nil,
		nil,
		nil,
		24405
	},
	[24440002] = {
		24440002,
		0,
		Lang.get(68253),
		24440,
		2,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[28]
		},
		nil,
		nil,
		5
	},
	[24440003] = {
		24440003,
		0,
		Lang.get(68254),
		24440,
		3,
		584,
		{
			RTResTalkAction[27],
			RTResTalkAction[30]
		},
		nil,
		nil,
		5
	},
	[24440004] = {
		24440004,
		0,
		Lang.get(68255),
		24440,
		4,
		584,
		{
			RTResTalkAction[28]
		},
		1,
		nil,
		-1
	},
	[24440005] = {
		24440005,
		0,
		Lang.get(68256),
		24440,
		5,
		53,
		nil,
		1
	},
	[24440006] = {
		24440006,
		0,
		Lang.get(68257),
		24440,
		6,
		129,
		nil,
		1
	},
	[24440007] = {
		24440007,
		0,
		Lang.get(68258),
		24440,
		7,
		53,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		5
	},
	[24440008] = {
		24440008,
		0,
		Lang.get(70755),
		24440,
		8,
		753,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		24436,
		nil,
		1,
		nil,
		nil,
		nil,
		24436
	},
	[24440009] = {
		24440009,
		0,
		Lang.get(68260),
		24440,
		9,
		751,
		nil,
		1
	},
	[24440010] = {
		24440010,
		0,
		Lang.get(68261),
		24440,
		10,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24437,
		nil,
		1,
		nil,
		nil,
		nil,
		24437
	},
	[24440011] = {
		24440011,
		0,
		Lang.get(68262),
		24440,
		11,
		751,
		{
			RTResTalkAction[33],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24440012] = {
		24440012,
		3,
		"……",
		24440,
		12,
		605,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24440013] = {
		24440013,
		0,
		Lang.get(68263),
		24440,
		13,
		138,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		24438,
		nil,
		1,
		nil,
		nil,
		nil,
		24438
	},
	[24440014] = {
		24440014,
		0,
		Lang.get(68264),
		24440,
		14,
		129,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		5
	},
	[24440015] = {
		24440015,
		0,
		Lang.get(70756),
		24440,
		15,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[35]
		},
		nil,
		nil,
		5
	},
	[24440016] = {
		24440016,
		0,
		Lang.get(23196),
		24440,
		16,
		138,
		{
			RTResTalkAction[36],
			RTResTalkAction[30]
		},
		nil,
		nil,
		5
	},
	[24440017] = {
		24440017,
		0,
		Lang.get(68266),
		24440,
		17,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[37]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24439,
		nil,
		1,
		nil,
		nil,
		nil,
		24439
	},
	[24440018] = {
		24440018,
		5,
		Lang.get(68267),
		24440,
		18,
		755,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		-1
	},
	[24440019] = {
		24440019,
		0,
		Lang.get(68268),
		24440,
		19,
		756,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		5
	},
	[24440020] = {
		24440020,
		0,
		Lang.get(68269),
		24440,
		20,
		751,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		},
		nil,
		nil,
		5
	},
	[24440021] = {
		24440021,
		5,
		Lang.get(68270),
		24440,
		21,
		605,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24440022] = {
		24440022,
		2,
		Lang.get(68271),
		24440,
		22,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24450001] = {
		24450001,
		0,
		Lang.get(68272),
		24450,
		1,
		756,
		nil,
		1,
		nil,
		-1,
		nil,
		60,
		24406,
		nil,
		1,
		nil,
		nil,
		nil,
		24406
	},
	[24450002] = {
		24450002,
		0,
		Lang.get(68273),
		24450,
		2,
		55,
		nil,
		1
	},
	[24450003] = {
		24450003,
		2,
		Lang.get(68274),
		24450,
		3,
		751,
		{
			RTResTalkAction[41],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24450004] = {
		24450004,
		0,
		Lang.get(68275),
		24450,
		4,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[42]
		},
		nil,
		nil,
		5
	},
	[24450005] = {
		24450005,
		0,
		Lang.get(68276),
		24450,
		5,
		751,
		{
			RTResTalkAction[43],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24450006] = {
		24450006,
		0,
		Lang.get(68277),
		24450,
		6,
		753,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24450007] = {
		24450007,
		0,
		Lang.get(68278),
		24450,
		7,
		55,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		},
		1,
		nil,
		-1
	},
	[24450008] = {
		24450008,
		0,
		Lang.get(68279),
		24450,
		8,
		764,
		nil,
		1
	},
	[24450009] = {
		24450009,
		0,
		Lang.get(68280),
		24450,
		9,
		751,
		nil,
		1
	},
	[24450010] = {
		24450010,
		0,
		Lang.get(68281),
		24450,
		10,
		764,
		nil,
		1
	},
	[24450011] = {
		24450011,
		0,
		Lang.get(68282),
		24450,
		11,
		751,
		nil,
		1
	},
	[24450012] = {
		24450012,
		0,
		Lang.get(68283),
		24450,
		12,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24450013] = {
		24450013,
		0,
		Lang.get(70757),
		24450,
		13,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24450014] = {
		24450014,
		0,
		Lang.get(68285),
		24450,
		14,
		55,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24450015] = {
		24450015,
		0,
		Lang.get(68286),
		24450,
		15,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		},
		nil,
		nil,
		5
	},
	[24450016] = {
		24450016,
		0,
		Lang.get(68287),
		24450,
		16,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24450017] = {
		24450017,
		0,
		Lang.get(68288),
		24450,
		17,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24450018] = {
		24450018,
		0,
		Lang.get(68289),
		24450,
		18,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24450019] = {
		24450019,
		0,
		Lang.get(68290),
		24450,
		19,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24450020] = {
		24450020,
		0,
		Lang.get(68291),
		24450,
		20,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24460001] = {
		24460001,
		0,
		Lang.get(68292),
		24460,
		1,
		55,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		24407,
		nil,
		1,
		nil,
		nil,
		nil,
		24407
	},
	[24460002] = {
		24460002,
		0,
		Lang.get(68293),
		24460,
		2,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24460003] = {
		24460003,
		0,
		Lang.get(68294),
		24460,
		3,
		55,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24460004] = {
		24460004,
		0,
		Lang.get(70758),
		24460,
		4,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[47]
		},
		nil,
		nil,
		5
	},
	[24460005] = {
		24460005,
		0,
		Lang.get(68296),
		24460,
		5,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24460006] = {
		24460006,
		0,
		Lang.get(68297),
		24460,
		6,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24460007] = {
		24460007,
		0,
		Lang.get(68298),
		24460,
		7,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24460008] = {
		24460008,
		0,
		Lang.get(68299),
		24460,
		8,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24460009] = {
		24460009,
		0,
		Lang.get(68300),
		24460,
		9,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24460010] = {
		24460010,
		0,
		Lang.get(68301),
		24460,
		10,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24460011] = {
		24460011,
		0,
		Lang.get(68302),
		24460,
		11,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24460012] = {
		24460012,
		0,
		Lang.get(68303),
		24460,
		12,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24460013] = {
		24460013,
		0,
		Lang.get(68304),
		24460,
		13,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24460014] = {
		24460014,
		0,
		Lang.get(68305),
		24460,
		14,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24460015] = {
		24460015,
		0,
		Lang.get(68306),
		24460,
		15,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24460016] = {
		24460016,
		5,
		Lang.get(68307),
		24460,
		16,
		764,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		5
	},
	[24470001] = {
		24470001,
		3,
		Lang.get(68308),
		24470,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		24408,
		nil,
		1,
		nil,
		nil,
		nil,
		24408,
		nil,
		nil,
		1
	},
	[24470002] = {
		24470002,
		0,
		Lang.get(68309),
		24470,
		2,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24470003] = {
		24470003,
		0,
		Lang.get(68310),
		24470,
		3,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24470004] = {
		24470004,
		0,
		Lang.get(68311),
		24470,
		4,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24470005] = {
		24470005,
		0,
		Lang.get(70759),
		24470,
		5,
		753,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5
	},
	[24470006] = {
		24470006,
		0,
		Lang.get(68313),
		24470,
		6,
		107,
		{
			RTResTalkAction[6]
		},
		1,
		5,
		nil,
		nil,
		nil,
		24440,
		nil,
		1,
		nil,
		0,
		nil,
		24440
	},
	[24470007] = {
		24470007,
		0,
		Lang.get(68314),
		24470,
		7,
		751,
		nil,
		1,
		0
	},
	[24470008] = {
		24470008,
		0,
		Lang.get(68315),
		24470,
		8,
		753,
		nil,
		1,
		0
	},
	[24470009] = {
		24470009,
		0,
		Lang.get(68316),
		24470,
		9,
		107,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		5
	},
	[24470010] = {
		24470010,
		0,
		Lang.get(68317),
		24470,
		10,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24470011] = {
		24470011,
		0,
		Lang.get(68318),
		24470,
		11,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24470012] = {
		24470012,
		0,
		Lang.get(68319),
		24470,
		12,
		107,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		5
	},
	[24470013] = {
		24470013,
		0,
		Lang.get(68320),
		24470,
		13,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24470014] = {
		24470014,
		0,
		Lang.get(70760),
		24470,
		14,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24470015] = {
		24470015,
		0,
		Lang.get(68322),
		24470,
		15,
		751,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		5
	},
	[24470016] = {
		24470016,
		0,
		Lang.get(68323),
		24470,
		16,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24480001] = {
		24480001,
		0,
		Lang.get(68324),
		24480,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		24409,
		nil,
		1,
		nil,
		nil,
		nil,
		24409
	},
	[24480002] = {
		24480002,
		0,
		Lang.get(68325),
		24480,
		2,
		753,
		nil,
		1
	},
	[24480003] = {
		24480003,
		0,
		Lang.get(68326),
		24480,
		3,
		753,
		nil,
		1
	},
	[24480004] = {
		24480004,
		0,
		Lang.get(68327),
		24480,
		4,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24480005] = {
		24480005,
		0,
		Lang.get(68328),
		24480,
		5,
		141,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24480006] = {
		24480006,
		0,
		Lang.get(68329),
		24480,
		6,
		751,
		{
			RTResTalkAction[52],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24480007] = {
		24480007,
		0,
		Lang.get(68330),
		24480,
		7,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24480008] = {
		24480008,
		0,
		Lang.get(68331),
		24480,
		8,
		107,
		{
			RTResTalkAction[53],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24480009] = {
		24480009,
		5,
		Lang.get(68332),
		24480,
		9,
		55,
		{
			RTResTalkAction[45],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5,
		nil,
		20
	},
	[24480010] = {
		24480010,
		0,
		Lang.get(68333),
		24480,
		10,
		751,
		{
			RTResTalkAction[39],
			RTResTalkAction[47]
		},
		nil,
		nil,
		5
	},
	[24490001] = {
		24490001,
		0,
		Lang.get(68334),
		24490,
		1,
		751,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		24425,
		nil,
		1,
		nil,
		1,
		nil,
		24425
	},
	[24490002] = {
		24490002,
		0,
		Lang.get(68335),
		24490,
		2,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24490003] = {
		24490003,
		0,
		Lang.get(42599),
		24490,
		3,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24500001] = {
		24500001,
		0,
		Lang.get(68336),
		24500,
		1,
		584,
		nil,
		1,
		nil,
		nil,
		nil,
		137,
		24410,
		nil,
		1,
		nil,
		nil,
		nil,
		24410
	},
	[24500002] = {
		24500002,
		0,
		Lang.get(68337),
		24500,
		2,
		129,
		nil,
		1
	},
	[24500003] = {
		24500003,
		0,
		Lang.get(68338),
		24500,
		3,
		138,
		nil,
		1
	},
	[24500004] = {
		24500004,
		0,
		Lang.get(68339),
		24500,
		4,
		751,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		5
	},
	[24500005] = {
		24500005,
		0,
		Lang.get(68340),
		24500,
		5,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24500006] = {
		24500006,
		0,
		Lang.get(68341),
		24500,
		6,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24500007] = {
		24500007,
		0,
		Lang.get(68342),
		24500,
		7,
		760,
		{
			RTResTalkAction[55],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24500008] = {
		24500008,
		0,
		Lang.get(68343),
		24500,
		8,
		751,
		{
			RTResTalkAction[39],
			RTResTalkAction[56]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24441,
		[19] = 24441
	},
	[24510001] = {
		24510001,
		0,
		Lang.get(68344),
		24510,
		1,
		751,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		24411,
		nil,
		1,
		nil,
		nil,
		nil,
		24411
	},
	[24510002] = {
		24510002,
		0,
		Lang.get(68345),
		24510,
		2,
		107,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		5
	},
	[24510003] = {
		24510003,
		0,
		Lang.get(68346),
		24510,
		3,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24510004] = {
		24510004,
		0,
		Lang.get(68347),
		24510,
		4,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24510005] = {
		24510005,
		0,
		Lang.get(68348),
		24510,
		5,
		760,
		{
			RTResTalkAction[57],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510006] = {
		24510006,
		0,
		Lang.get(68349),
		24510,
		6,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[56]
		},
		nil,
		nil,
		5
	},
	[24510007] = {
		24510007,
		0,
		Lang.get(69940),
		24510,
		7,
		760,
		{
			RTResTalkAction[57],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510008] = {
		24510008,
		0,
		Lang.get(69941),
		24510,
		8,
		760,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		5
	},
	[24510009] = {
		24510009,
		0,
		Lang.get(68352),
		24510,
		9,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[56]
		},
		nil,
		nil,
		5
	},
	[24510010] = {
		24510010,
		0,
		Lang.get(68353),
		24510,
		10,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24510011] = {
		24510011,
		0,
		Lang.get(68354),
		24510,
		11,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510012] = {
		24510012,
		0,
		Lang.get(69942),
		24510,
		12,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24510013] = {
		24510013,
		0,
		Lang.get(68356),
		24510,
		13,
		751,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		5
	},
	[24510014] = {
		24510014,
		0,
		Lang.get(68328),
		24510,
		14,
		141,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510015] = {
		24510015,
		0,
		Lang.get(68357),
		24510,
		15,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24510016] = {
		24510016,
		0,
		Lang.get(69943),
		24510,
		16,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510017] = {
		24510017,
		0,
		Lang.get(69944),
		24510,
		17,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24510018] = {
		24510018,
		0,
		Lang.get(68360),
		24510,
		18,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510019] = {
		24510019,
		0,
		Lang.get(68361),
		24510,
		19,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24510020] = {
		24510020,
		0,
		Lang.get(69945),
		24510,
		20,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24510021] = {
		24510021,
		0,
		Lang.get(68363),
		24510,
		21,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24520001] = {
		24520001,
		0,
		Lang.get(68364),
		24520,
		1,
		764,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		24412,
		nil,
		1,
		nil,
		nil,
		nil,
		24412
	},
	[24520002] = {
		24520002,
		0,
		Lang.get(68365),
		24520,
		2,
		763,
		nil,
		1
	},
	[24520003] = {
		24520003,
		0,
		Lang.get(68366),
		24520,
		3,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24520004] = {
		24520004,
		0,
		Lang.get(68367),
		24520,
		4,
		763,
		{
			RTResTalkAction[58],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24520005] = {
		24520005,
		0,
		Lang.get(68368),
		24520,
		5,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24520006] = {
		24520006,
		0,
		"……",
		24520,
		6,
		763,
		{
			RTResTalkAction[58],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24530001] = {
		24530001,
		3,
		Lang.get(68369),
		24530,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		24402,
		nil,
		1,
		nil,
		nil,
		nil,
		24402,
		nil,
		nil,
		1
	},
	[24530002] = {
		24530002,
		0,
		Lang.get(68370),
		24530,
		2,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24530003] = {
		24530003,
		0,
		Lang.get(68371),
		24530,
		3,
		762,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		5
	},
	[24530004] = {
		24530004,
		0,
		Lang.get(70761),
		24530,
		4,
		762,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		5
	},
	[24530005] = {
		24530005,
		0,
		Lang.get(70762),
		24530,
		5,
		762,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		5
	},
	[24530006] = {
		24530006,
		0,
		Lang.get(68374),
		24530,
		6,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		5
	},
	[24530007] = {
		24530007,
		0,
		Lang.get(68375),
		24530,
		7,
		762,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		},
		nil,
		nil,
		5
	},
	[24530008] = {
		24530008,
		0,
		Lang.get(68376),
		24530,
		8,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24540001] = {
		24540001,
		3,
		Lang.get(68377),
		24540,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		24426,
		nil,
		1,
		nil,
		nil,
		nil,
		24426,
		nil,
		nil,
		1
	},
	[24540002] = {
		24540002,
		0,
		"……",
		24540,
		2,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24540003] = {
		24540003,
		2,
		Lang.get(69946),
		24540,
		3,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24540004] = {
		24540004,
		2,
		Lang.get(68379),
		24540,
		4,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24550001] = {
		24550001,
		0,
		Lang.get(68380),
		24550,
		1,
		763,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		24413,
		nil,
		1,
		nil,
		nil,
		nil,
		24413
	},
	[24550002] = {
		24550002,
		0,
		Lang.get(68381),
		24550,
		2,
		763,
		nil,
		1
	},
	[24550003] = {
		24550003,
		0,
		Lang.get(68382),
		24550,
		3,
		764,
		nil,
		1
	},
	[24550004] = {
		24550004,
		0,
		"……",
		24550,
		4,
		763,
		nil,
		1
	},
	[24550005] = {
		24550005,
		0,
		Lang.get(68383),
		24550,
		5,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550006] = {
		24550006,
		0,
		Lang.get(68384),
		24550,
		6,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550007] = {
		24550007,
		0,
		Lang.get(68385),
		24550,
		7,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550008] = {
		24550008,
		0,
		Lang.get(68386),
		24550,
		8,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550009] = {
		24550009,
		0,
		Lang.get(68387),
		24550,
		9,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550010] = {
		24550010,
		0,
		Lang.get(68388),
		24550,
		10,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550011] = {
		24550011,
		0,
		"……",
		24550,
		11,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550012] = {
		24550012,
		0,
		Lang.get(68389),
		24550,
		12,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550013] = {
		24550013,
		0,
		Lang.get(68390),
		24550,
		13,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550014] = {
		24550014,
		0,
		Lang.get(68391),
		24550,
		14,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550015] = {
		24550015,
		0,
		Lang.get(68392),
		24550,
		15,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550016] = {
		24550016,
		0,
		Lang.get(70763),
		24550,
		16,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24550017] = {
		24550017,
		5,
		Lang.get(68394),
		24550,
		17,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560001] = {
		24560001,
		0,
		Lang.get(68395),
		24560,
		1,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5,
		nil,
		60,
		24414,
		nil,
		1,
		nil,
		nil,
		nil,
		24414
	},
	[24560002] = {
		24560002,
		0,
		Lang.get(68396),
		24560,
		2,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560003] = {
		24560003,
		0,
		Lang.get(68397),
		24560,
		3,
		763,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560004] = {
		24560004,
		0,
		Lang.get(68398),
		24560,
		4,
		764,
		{
			RTResTalkAction[59],
			RTResTalkAction[46]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		24451,
		nil,
		1,
		nil,
		nil,
		nil,
		24451
	},
	[24560005] = {
		24560005,
		0,
		Lang.get(68399),
		24560,
		5,
		764,
		nil,
		1
	},
	[24560006] = {
		24560006,
		0,
		Lang.get(68400),
		24560,
		6,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24450,
		nil,
		1,
		nil,
		nil,
		nil,
		24450
	},
	[24560007] = {
		24560007,
		0,
		"……",
		24560,
		7,
		763,
		{
			RTResTalkAction[59],
			RTResTalkAction[46]
		},
		1,
		nil,
		-1
	},
	[24560008] = {
		24560008,
		0,
		Lang.get(68401),
		24560,
		8,
		763,
		nil,
		1
	},
	[24560009] = {
		24560009,
		0,
		Lang.get(68402),
		24560,
		9,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560010] = {
		24560010,
		0,
		Lang.get(68403),
		24560,
		10,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560011] = {
		24560011,
		0,
		Lang.get(68404),
		24560,
		11,
		764,
		{
			RTResTalkAction[60],
			RTResTalkAction[63]
		},
		nil,
		nil,
		5
	},
	[24560012] = {
		24560012,
		5,
		Lang.get(68405),
		24560,
		12,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24570001] = {
		24570001,
		0,
		Lang.get(68406),
		24570,
		1,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5,
		nil,
		137,
		24601,
		1,
		1,
		nil,
		1,
		nil,
		24601
	},
	[24570002] = {
		24570002,
		0,
		Lang.get(68407),
		24570,
		2,
		763,
		{
			RTResTalkAction[58],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24570003] = {
		24570003,
		0,
		Lang.get(68408),
		24570,
		3,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24570004] = {
		24570004,
		0,
		Lang.get(70764),
		24570,
		4,
		751,
		{
			RTResTalkAction[39],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24602,
		1,
		1,
		nil,
		1,
		nil,
		24602
	},
	[24570005] = {
		24570005,
		0,
		Lang.get(68410),
		24570,
		5,
		751,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		5
	},
	[24570006] = {
		24570006,
		0,
		Lang.get(68411),
		24570,
		6,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24570007] = {
		24570007,
		0,
		Lang.get(68412),
		24570,
		7,
		763,
		{
			RTResTalkAction[58],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24570008] = {
		24570008,
		0,
		Lang.get(68413),
		24570,
		8,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24570009] = {
		24570009,
		0,
		Lang.get(68414),
		24570,
		9,
		751,
		{
			RTResTalkAction[51],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24570010] = {
		24570010,
		5,
		Lang.get(68415),
		24570,
		10,
		763,
		{
			RTResTalkAction[64],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24570011] = {
		24570011,
		0,
		Lang.get(68416),
		24570,
		11,
		751,
		{
			RTResTalkAction[51],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24580001] = {
		24580001,
		0,
		Lang.get(68417),
		24580,
		1,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5,
		nil,
		173,
		24415,
		nil,
		1,
		nil,
		1,
		nil,
		24415
	},
	[24580002] = {
		24580002,
		2,
		Lang.get(68418),
		24580,
		2,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5
	},
	[24580003] = {
		24580003,
		0,
		Lang.get(68419),
		24580,
		3,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24580004] = {
		24580004,
		0,
		Lang.get(68420),
		24580,
		4,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24580005] = {
		24580005,
		0,
		Lang.get(68421),
		24580,
		5,
		763,
		{
			RTResTalkAction[58],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24580006] = {
		24580006,
		0,
		Lang.get(68422),
		24580,
		6,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24580007] = {
		24580007,
		0,
		Lang.get(68423),
		24580,
		7,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24580008] = {
		24580008,
		0,
		Lang.get(68424),
		24580,
		8,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24580009] = {
		24580009,
		5,
		Lang.get(68425),
		24580,
		9,
		751,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		5
	},
	[24580010] = {
		24580010,
		0,
		Lang.get(68426),
		24580,
		10,
		763,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		24442,
		[19] = 24442
	},
	[24580011] = {
		24580011,
		0,
		Lang.get(68427),
		24580,
		11,
		764,
		nil,
		1
	},
	[24580012] = {
		24580012,
		0,
		Lang.get(68428),
		24580,
		12,
		751,
		nil,
		1,
		1,
		nil,
		nil,
		57
	},
	[24580013] = {
		24580013,
		0,
		Lang.get(68429),
		24580,
		13,
		751,
		nil,
		1,
		0
	},
	[24580014] = {
		24580014,
		0,
		Lang.get(68430),
		24580,
		14,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24580015] = {
		24580015,
		0,
		Lang.get(70765),
		24580,
		15,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24580016] = {
		24580016,
		0,
		Lang.get(68432),
		24580,
		16,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24606,
		nil,
		1,
		nil,
		1,
		nil,
		24606
	},
	[24580017] = {
		24580017,
		0,
		Lang.get(68433),
		24580,
		17,
		764,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		-1
	},
	[24580018] = {
		24580018,
		0,
		Lang.get(68434),
		24580,
		18,
		751,
		nil,
		1
	},
	[24580019] = {
		24580019,
		0,
		Lang.get(68435),
		24580,
		19,
		764,
		nil,
		1
	},
	[24580020] = {
		24580020,
		5,
		Lang.get(68436),
		24580,
		20,
		763,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		5
	},
	[24590001] = {
		24590001,
		5,
		Lang.get(68437),
		24590,
		1,
		605,
		nil,
		nil,
		nil,
		5,
		nil,
		137,
		24607,
		nil,
		1,
		nil,
		1,
		nil,
		24607,
		nil,
		nil,
		1
	},
	[24590002] = {
		24590002,
		0,
		Lang.get(68438),
		24590,
		2,
		107,
		nil,
		1
	},
	[24590003] = {
		24590003,
		0,
		Lang.get(68439),
		24590,
		3,
		763,
		nil,
		1
	},
	[24590004] = {
		24590004,
		0,
		Lang.get(68440),
		24590,
		4,
		133,
		nil,
		1
	},
	[24600001] = {
		24600001,
		0,
		Lang.get(68441),
		24600,
		1,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		60,
		24416,
		nil,
		1,
		nil,
		nil,
		nil,
		24416
	},
	[24600002] = {
		24600002,
		0,
		Lang.get(68442),
		24600,
		2,
		751,
		nil,
		1
	},
	[24600003] = {
		24600003,
		0,
		Lang.get(68443),
		24600,
		3,
		107,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		5
	},
	[24600004] = {
		24600004,
		0,
		Lang.get(68444),
		24600,
		4,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24600005] = {
		24600005,
		0,
		Lang.get(68445),
		24600,
		5,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24600006] = {
		24600006,
		0,
		Lang.get(68446),
		24600,
		6,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24610,
		nil,
		1,
		nil,
		1,
		nil,
		24610
	},
	[24600007] = {
		24600007,
		2,
		Lang.get(68447),
		24600,
		7,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24600008] = {
		24600008,
		2,
		Lang.get(68448),
		24600,
		8,
		764,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		5
	},
	[24600009] = {
		24600009,
		0,
		Lang.get(68449),
		24600,
		9,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[46]
		},
		nil,
		nil,
		5
	},
	[24600010] = {
		24600010,
		0,
		Lang.get(68450),
		24600,
		10,
		764,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24600011] = {
		24600011,
		5,
		Lang.get(67541),
		24600,
		11,
		605,
		{
			RTResTalkAction[46]
		},
		[22] = 1,
		[20] = 200
	},
	[24600012] = {
		24600012,
		0,
		Lang.get(68451),
		24600,
		12,
		107,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		5
	},
	[24600013] = {
		24600013,
		0,
		Lang.get(68452),
		24600,
		13,
		764,
		{
			RTResTalkAction[15]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		24611,
		nil,
		1,
		nil,
		nil,
		nil,
		24611,
		-1
	},
	[24600014] = {
		24600014,
		0,
		"……",
		24600,
		14,
		755,
		nil,
		1
	},
	[24600015] = {
		24600015,
		0,
		Lang.get(68453),
		24600,
		15,
		141,
		nil,
		1
	},
	[24600016] = {
		24600016,
		0,
		Lang.get(68454),
		24600,
		16,
		751,
		nil,
		1
	},
	[24610001] = {
		24610001,
		0,
		Lang.get(70766),
		24610,
		1,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5,
		nil,
		57,
		24612,
		nil,
		1,
		nil,
		nil,
		nil,
		24612
	},
	[24610002] = {
		24610002,
		0,
		Lang.get(68456),
		24610,
		2,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24610003] = {
		24610003,
		0,
		Lang.get(68457),
		24610,
		3,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24610004] = {
		24610004,
		0,
		Lang.get(68458),
		24610,
		4,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24610005] = {
		24610005,
		0,
		Lang.get(68459),
		24610,
		5,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24610006] = {
		24610006,
		0,
		Lang.get(68460),
		24610,
		6,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24620001] = {
		24620001,
		0,
		Lang.get(68461),
		24620,
		1,
		753,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		5,
		nil,
		62,
		24417,
		nil,
		1,
		nil,
		nil,
		nil,
		24417
	},
	[24620002] = {
		24620002,
		0,
		Lang.get(68462),
		24620,
		2,
		13,
		{
			RTResTalkAction[67],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24620003] = {
		24620003,
		0,
		Lang.get(68463),
		24620,
		3,
		753,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		},
		nil,
		nil,
		5
	},
	[24620004] = {
		24620004,
		0,
		Lang.get(68464),
		24620,
		4,
		13,
		{
			RTResTalkAction[67],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24620005] = {
		24620005,
		0,
		Lang.get(68465),
		24620,
		5,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[69]
		},
		nil,
		nil,
		5
	},
	[24620006] = {
		24620006,
		2,
		Lang.get(68466),
		24620,
		6,
		753,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5
	},
	[24620007] = {
		24620007,
		0,
		Lang.get(68467),
		24620,
		7,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24620008] = {
		24620008,
		0,
		Lang.get(68468),
		24620,
		8,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[70]
		},
		nil,
		nil,
		5,
		nil,
		57,
		24615,
		1,
		1,
		nil,
		nil,
		nil,
		24615
	},
	[24620009] = {
		24620009,
		2,
		Lang.get(68469),
		24620,
		9,
		753,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		5
	},
	[24620010] = {
		24620010,
		0,
		Lang.get(70767),
		24620,
		10,
		762,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		-1
	},
	[24620011] = {
		24620011,
		0,
		Lang.get(68471),
		24620,
		11,
		762,
		nil,
		1
	},
	[24620012] = {
		24620012,
		0,
		Lang.get(68472),
		24620,
		12,
		753,
		nil,
		1
	},
	[24620013] = {
		24620013,
		0,
		Lang.get(68473),
		24620,
		13,
		753,
		nil,
		1
	},
	[24620014] = {
		24620014,
		0,
		Lang.get(68474),
		24620,
		14,
		762,
		nil,
		1
	},
	[24620015] = {
		24620015,
		0,
		Lang.get(68475),
		24620,
		15,
		753,
		nil,
		1
	},
	[24620016] = {
		24620016,
		0,
		Lang.get(68476),
		24620,
		16,
		762,
		nil,
		1
	},
	[24620017] = {
		24620017,
		0,
		Lang.get(68477),
		24620,
		17,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24620018] = {
		24620018,
		0,
		Lang.get(68478),
		24620,
		18,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		},
		nil,
		nil,
		5
	},
	[24620019] = {
		24620019,
		0,
		Lang.get(68479),
		24620,
		19,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24620020] = {
		24620020,
		0,
		Lang.get(68480),
		24620,
		20,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		},
		nil,
		nil,
		5
	},
	[24620021] = {
		24620021,
		0,
		Lang.get(68481),
		24620,
		21,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630001] = {
		24630001,
		0,
		Lang.get(68482),
		24630,
		1,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5,
		nil,
		69,
		24418,
		nil,
		1,
		nil,
		nil,
		nil,
		24418
	},
	[24630002] = {
		24630002,
		0,
		Lang.get(68483),
		24630,
		2,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630003] = {
		24630003,
		0,
		Lang.get(68484),
		24630,
		3,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630004] = {
		24630004,
		0,
		Lang.get(18698),
		24630,
		4,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630005] = {
		24630005,
		0,
		Lang.get(68485),
		24630,
		5,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630006] = {
		24630006,
		0,
		Lang.get(68486),
		24630,
		6,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630007] = {
		24630007,
		0,
		Lang.get(68487),
		24630,
		7,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630008] = {
		24630008,
		0,
		Lang.get(68488),
		24630,
		8,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630009] = {
		24630009,
		0,
		Lang.get(68489),
		24630,
		9,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630010] = {
		24630010,
		0,
		Lang.get(68490),
		24630,
		10,
		13,
		{
			RTResTalkAction[67],
			RTResTalkAction[70],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24630011] = {
		24630011,
		0,
		Lang.get(68491),
		24630,
		11,
		762,
		{
			RTResTalkAction[69]
		},
		1,
		nil,
		-1
	},
	[24630012] = {
		24630012,
		0,
		Lang.get(68492),
		24630,
		12,
		762,
		nil,
		1
	},
	[24630013] = {
		24630013,
		0,
		Lang.get(68493),
		24630,
		13,
		753,
		nil,
		1
	},
	[24630014] = {
		24630014,
		0,
		Lang.get(68494),
		24630,
		14,
		762,
		nil,
		1
	},
	[24630015] = {
		24630015,
		0,
		Lang.get(68495),
		24630,
		15,
		762,
		nil,
		1
	},
	[24630016] = {
		24630016,
		0,
		Lang.get(68496),
		24630,
		16,
		762,
		nil,
		1
	},
	[24630017] = {
		24630017,
		0,
		Lang.get(68497),
		24630,
		17,
		762,
		nil,
		1
	},
	[24630018] = {
		24630018,
		0,
		Lang.get(68498),
		24630,
		18,
		753,
		nil,
		1,
		1
	},
	[24630019] = {
		24630019,
		0,
		Lang.get(68499),
		24630,
		19,
		13,
		nil,
		1
	},
	[24630020] = {
		24630020,
		0,
		Lang.get(68500),
		24630,
		20,
		762,
		nil,
		1
	},
	[24630021] = {
		24630021,
		0,
		Lang.get(68501),
		24630,
		21,
		753,
		nil,
		1,
		0
	},
	[24630022] = {
		24630022,
		5,
		Lang.get(68502),
		24630,
		22,
		762,
		nil,
		1
	},
	[24630023] = {
		24630023,
		0,
		Lang.get(68503),
		24630,
		23,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630024] = {
		24630024,
		0,
		Lang.get(68504),
		24630,
		24,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630025] = {
		24630025,
		0,
		Lang.get(68505),
		24630,
		25,
		13,
		{
			RTResTalkAction[73],
			RTResTalkAction[4],
			RTResTalkAction[70]
		},
		nil,
		nil,
		5
	},
	[24630026] = {
		24630026,
		0,
		Lang.get(68506),
		24630,
		26,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4],
			RTResTalkAction[69]
		},
		nil,
		nil,
		5
	},
	[24630027] = {
		24630027,
		0,
		Lang.get(21405),
		24630,
		27,
		753,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630028] = {
		24630028,
		0,
		Lang.get(70768),
		24630,
		28,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630029] = {
		24630029,
		0,
		Lang.get(68508),
		24630,
		29,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630030] = {
		24630030,
		0,
		Lang.get(68509),
		24630,
		30,
		762,
		{
			RTResTalkAction[71],
			RTResTalkAction[4]
		},
		nil,
		nil,
		5
	},
	[24630031] = {
		24630031,
		0,
		Lang.get(17580),
		24630,
		31,
		751,
		{
			RTResTalkAction[51],
			RTResTalkAction[70],
			RTResTalkAction[6]
		},
		nil,
		nil,
		-1
	},
	[24630032] = {
		24630032,
		0,
		Lang.get(68510),
		24630,
		32,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[5]
		}
	},
	[24640001] = {
		24640001,
		0,
		Lang.get(68511),
		24640,
		1,
		107,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		5,
		nil,
		137,
		24419,
		nil,
		1,
		nil,
		nil,
		nil,
		24419
	},
	[24640002] = {
		24640002,
		0,
		Lang.get(68512),
		24640,
		2,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5
	},
	[24640003] = {
		24640003,
		0,
		Lang.get(68513),
		24640,
		3,
		141,
		{
			RTResTalkAction[74],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24640004] = {
		24640004,
		0,
		Lang.get(68514),
		24640,
		4,
		753,
		{
			RTResTalkAction[12],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24640005] = {
		24640005,
		0,
		Lang.get(68515),
		24640,
		5,
		753,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		5
	},
	[24640006] = {
		24640006,
		0,
		Lang.get(68516),
		24640,
		6,
		751,
		{
			RTResTalkAction[52],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24640007] = {
		24640007,
		0,
		Lang.get(68517),
		24640,
		7,
		584,
		{
			RTResTalkAction[27],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5,
		nil,
		57,
		24700,
		1,
		1,
		nil,
		1,
		nil,
		24700
	},
	[24640008] = {
		24640008,
		0,
		Lang.get(68518),
		24640,
		8,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[28]
		},
		nil,
		nil,
		5
	},
	[24640009] = {
		24640009,
		0,
		Lang.get(68519),
		24640,
		9,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[35]
		},
		nil,
		nil,
		5
	},
	[24640010] = {
		24640010,
		0,
		Lang.get(68520),
		24640,
		10,
		762,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		-1
	},
	[24640011] = {
		24640011,
		0,
		Lang.get(68521),
		24640,
		11,
		762,
		nil,
		1
	},
	[24640012] = {
		24640012,
		0,
		Lang.get(68522),
		24640,
		12,
		762,
		nil,
		1
	},
	[24640013] = {
		24640013,
		0,
		Lang.get(68523),
		24640,
		13,
		584,
		nil,
		1
	},
	[24640014] = {
		24640014,
		0,
		Lang.get(68524),
		24640,
		14,
		762,
		nil,
		1
	},
	[24640015] = {
		24640015,
		0,
		Lang.get(68525),
		24640,
		15,
		762,
		nil,
		1
	},
	[24640016] = {
		24640016,
		0,
		Lang.get(70769),
		24640,
		16,
		762,
		nil,
		1
	},
	[24640017] = {
		24640017,
		0,
		Lang.get(68527),
		24640,
		17,
		762,
		nil,
		1
	},
	[24640018] = {
		24640018,
		0,
		Lang.get(68528),
		24640,
		18,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5
	},
	[24640019] = {
		24640019,
		0,
		Lang.get(68529),
		24640,
		19,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24640020] = {
		24640020,
		2,
		Lang.get(68530),
		24640,
		20,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[70]
		},
		nil,
		nil,
		5
	},
	[24640021] = {
		24640021,
		5,
		Lang.get(69947),
		24640,
		21,
		107,
		{
			RTResTalkAction[75],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24640022] = {
		24640022,
		0,
		Lang.get(69948),
		24640,
		22,
		751,
		{
			RTResTalkAction[39],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24650001] = {
		24650001,
		0,
		Lang.get(68531),
		24650,
		1,
		584,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5,
		nil,
		57,
		24420,
		1,
		1,
		nil,
		nil,
		nil,
		24420
	},
	[24650002] = {
		24650002,
		0,
		Lang.get(68532),
		24650,
		2,
		584,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		5
	},
	[24650003] = {
		24650003,
		0,
		Lang.get(68533),
		24650,
		3,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[28]
		},
		nil,
		nil,
		5
	},
	[24650004] = {
		24650004,
		0,
		Lang.get(68534),
		24650,
		4,
		141,
		{
			RTResTalkAction[21],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24650005] = {
		24650005,
		0,
		Lang.get(68535),
		24650,
		5,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24650006] = {
		24650006,
		0,
		Lang.get(68536),
		24650,
		6,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24650007] = {
		24650007,
		0,
		Lang.get(68537),
		24650,
		7,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24650008] = {
		24650008,
		2,
		Lang.get(68538),
		24650,
		8,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24650009] = {
		24650009,
		2,
		Lang.get(68539),
		24650,
		9,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24650010] = {
		24650010,
		0,
		Lang.get(68540),
		24650,
		10,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24650011] = {
		24650011,
		5,
		Lang.get(68541),
		24650,
		11,
		107,
		{
			RTResTalkAction[35]
		},
		1,
		2,
		-1
	},
	[24650012] = {
		24650012,
		0,
		Lang.get(68542),
		24650,
		12,
		107,
		nil,
		1,
		2
	},
	[24650013] = {
		24650013,
		0,
		Lang.get(68543),
		24650,
		13,
		751,
		nil,
		1,
		1
	},
	[24660001] = {
		24660001,
		0,
		Lang.get(68544),
		24660,
		1,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5,
		nil,
		57,
		24421,
		nil,
		1,
		nil,
		nil,
		nil,
		24421
	},
	[24660002] = {
		24660002,
		0,
		Lang.get(68545),
		24660,
		2,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24660003] = {
		24660003,
		0,
		Lang.get(68546),
		24660,
		3,
		751,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		24710,
		nil,
		1,
		nil,
		nil,
		nil,
		24710
	},
	[24660004] = {
		24660004,
		0,
		Lang.get(68547),
		24660,
		4,
		751,
		nil,
		1
	},
	[24660005] = {
		24660005,
		0,
		Lang.get(68548),
		24660,
		5,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5
	},
	[24660006] = {
		24660006,
		0,
		"……",
		24660,
		6,
		755,
		{
			RTResTalkAction[15]
		}
	},
	[24660007] = {
		24660007,
		0,
		Lang.get(68549),
		24660,
		7,
		133,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		5
	},
	[24660008] = {
		24660008,
		0,
		Lang.get(68550),
		24660,
		8,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24660009] = {
		24660009,
		0,
		Lang.get(68551),
		24660,
		9,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		},
		nil,
		nil,
		5
	},
	[24660010] = {
		24660010,
		0,
		Lang.get(68552),
		24660,
		10,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24660011] = {
		24660011,
		0,
		Lang.get(68553),
		24660,
		11,
		129,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		5
	},
	[24660012] = {
		24660012,
		0,
		Lang.get(68554),
		24660,
		12,
		129,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		5
	},
	[24660013] = {
		24660013,
		0,
		Lang.get(68555),
		24660,
		13,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[35]
		},
		nil,
		nil,
		5
	},
	[24660014] = {
		24660014,
		0,
		Lang.get(68556),
		24660,
		14,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		},
		nil,
		nil,
		5,
		nil,
		173,
		24711,
		1,
		1,
		nil,
		nil,
		nil,
		24711
	},
	[24660015] = {
		24660015,
		0,
		Lang.get(68557),
		24660,
		15,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24660016] = {
		24660016,
		0,
		Lang.get(68558),
		24660,
		16,
		760,
		{
			RTResTalkAction[57],
			RTResTalkAction[70]
		},
		nil,
		nil,
		5
	},
	[24660017] = {
		24660017,
		0,
		Lang.get(68559),
		24660,
		17,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[56]
		},
		nil,
		nil,
		5
	},
	[24660018] = {
		24660018,
		0,
		Lang.get(68560),
		24660,
		18,
		760,
		{
			RTResTalkAction[57],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24660019] = {
		24660019,
		0,
		Lang.get(68561),
		24660,
		19,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[56]
		},
		nil,
		nil,
		5
	},
	[24660020] = {
		24660020,
		0,
		Lang.get(68562),
		24660,
		20,
		762,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		5
	},
	[24660021] = {
		24660021,
		0,
		Lang.get(68563),
		24660,
		21,
		755,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		-1
	},
	[24660022] = {
		24660022,
		5,
		Lang.get(68564),
		24660,
		22,
		762,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		5
	},
	[24660023] = {
		24660023,
		0,
		Lang.get(68565),
		24660,
		23,
		751,
		{
			RTResTalkAction[70]
		},
		1,
		nil,
		-1
	},
	[24660024] = {
		24660024,
		0,
		Lang.get(68566),
		24660,
		24,
		762,
		nil,
		1
	},
	[24660025] = {
		24660025,
		0,
		Lang.get(68567),
		24660,
		25,
		751,
		nil,
		1
	},
	[24660026] = {
		24660026,
		0,
		Lang.get(68568),
		24660,
		26,
		751,
		nil,
		1
	},
	[24660027] = {
		24660027,
		0,
		Lang.get(68569),
		24660,
		27,
		751,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		24721,
		[19] = 24721
	},
	[24670001] = {
		24670001,
		0,
		Lang.get(68570),
		24670,
		1,
		53,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		24715,
		1,
		1,
		nil,
		nil,
		nil,
		24715
	},
	[24670002] = {
		24670002,
		0,
		Lang.get(68571),
		24670,
		2,
		129,
		nil,
		1
	},
	[24670003] = {
		24670003,
		0,
		Lang.get(68572),
		24670,
		3,
		762,
		nil,
		1
	},
	[24670004] = {
		24670004,
		0,
		Lang.get(68573),
		24670,
		4,
		762,
		nil,
		1
	},
	[24670005] = {
		24670005,
		0,
		Lang.get(68574),
		24670,
		5,
		762,
		nil,
		1
	},
	[24670006] = {
		24670006,
		0,
		Lang.get(68575),
		24670,
		6,
		762,
		nil,
		1
	},
	[24670007] = {
		24670007,
		0,
		"……",
		24670,
		7,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24670008] = {
		24670008,
		0,
		Lang.get(68576),
		24670,
		8,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24670009] = {
		24670009,
		0,
		Lang.get(68577),
		24670,
		9,
		141,
		{
			RTResTalkAction[74],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24670010] = {
		24670010,
		0,
		Lang.get(68578),
		24670,
		10,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24670011] = {
		24670011,
		0,
		Lang.get(68579),
		24670,
		11,
		141,
		{
			RTResTalkAction[76],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24670012] = {
		24670012,
		0,
		Lang.get(68580),
		24670,
		12,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24670013] = {
		24670013,
		0,
		Lang.get(68581),
		24670,
		13,
		762,
		{
			RTResTalkAction[62],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24670014] = {
		24670014,
		0,
		"……",
		24670,
		14,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[70]
		},
		nil,
		nil,
		5
	},
	[24670015] = {
		24670015,
		0,
		Lang.get(68582),
		24670,
		15,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24670016] = {
		24670016,
		5,
		Lang.get(68583),
		24670,
		16,
		605,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		-1,
		[22] = 1
	},
	[24680001] = {
		24680001,
		0,
		Lang.get(68584),
		24680,
		1,
		763,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		5,
		nil,
		20,
		24716,
		1,
		1,
		nil,
		nil,
		nil,
		24716
	},
	[24680002] = {
		24680002,
		0,
		Lang.get(68585),
		24680,
		2,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[59]
		},
		nil,
		nil,
		5
	},
	[24680003] = {
		24680003,
		0,
		Lang.get(68586),
		24680,
		3,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5
	},
	[24680004] = {
		24680004,
		3,
		"……",
		24680,
		4,
		605,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		5,
		[22] = 1
	},
	[24680005] = {
		24680005,
		0,
		Lang.get(68587),
		24680,
		5,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		24717,
		1,
		1,
		nil,
		nil,
		nil,
		24717,
		-1
	},
	[24680006] = {
		24680006,
		5,
		Lang.get(68588),
		24680,
		6,
		133,
		{
			RTResTalkAction[77],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24690001] = {
		24690001,
		0,
		Lang.get(68589),
		24690,
		1,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		5,
		nil,
		58,
		24423,
		1,
		1,
		nil,
		nil,
		nil,
		24423
	},
	[24690002] = {
		24690002,
		0,
		Lang.get(68590),
		24690,
		2,
		141,
		{
			RTResTalkAction[21],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24690003] = {
		24690003,
		0,
		Lang.get(68591),
		24690,
		3,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[23]
		},
		nil,
		nil,
		5
	},
	[24690004] = {
		24690004,
		0,
		Lang.get(68592),
		24690,
		4,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5
	},
	[24690005] = {
		24690005,
		0,
		Lang.get(68593),
		24690,
		5,
		133,
		{
			RTResTalkAction[50],
			RTResTalkAction[15]
		},
		nil,
		nil,
		5
	},
	[24690006] = {
		24690006,
		0,
		Lang.get(68594),
		24690,
		6,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[19]
		},
		nil,
		nil,
		5,
		nil,
		58,
		24720,
		1,
		1,
		nil,
		nil,
		nil,
		24720
	},
	[24690007] = {
		24690007,
		0,
		Lang.get(68595),
		24690,
		7,
		53,
		{
			RTResTalkAction[29],
			RTResTalkAction[35]
		},
		nil,
		nil,
		5
	},
	[24690008] = {
		24690008,
		0,
		Lang.get(68596),
		24690,
		8,
		53,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		5
	},
	[24690009] = {
		24690009,
		0,
		Lang.get(70770),
		24690,
		9,
		53,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		5
	},
	[24690010] = {
		24690010,
		0,
		"……",
		24690,
		10,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[30]
		},
		nil,
		nil,
		5
	},
	[24690011] = {
		24690011,
		0,
		Lang.get(68598),
		24690,
		11,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24690012] = {
		24690012,
		0,
		Lang.get(68599),
		24690,
		12,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24690013] = {
		24690013,
		0,
		Lang.get(68600),
		24690,
		13,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24690014] = {
		24690014,
		0,
		Lang.get(68601),
		24690,
		14,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24690015] = {
		24690015,
		0,
		Lang.get(68602),
		24690,
		15,
		129,
		{
			RTResTalkAction[34],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24690016] = {
		24690016,
		0,
		Lang.get(68603),
		24690,
		16,
		755,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		-1
	},
	[24690017] = {
		24690017,
		0,
		Lang.get(68604),
		24690,
		17,
		751,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		5
	},
	[24690018] = {
		24690018,
		0,
		Lang.get(68605),
		24690,
		18,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24690019] = {
		24690019,
		0,
		Lang.get(68606),
		24690,
		19,
		751,
		{
			RTResTalkAction[15]
		},
		1,
		4,
		-1
	},
	[24690020] = {
		24690020,
		3,
		"……",
		24690,
		20,
		605,
		[22] = 1
	},
	[24700001] = {
		24700001,
		0,
		Lang.get(68607),
		24700,
		1,
		751,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		5,
		nil,
		58,
		24424,
		nil,
		1,
		nil,
		nil,
		nil,
		24424,
		-1
	},
	[24700002] = {
		24700002,
		0,
		Lang.get(68608),
		24700,
		2,
		751,
		{
			RTResTalkAction[52]
		},
		nil,
		nil,
		5
	},
	[24700003] = {
		24700003,
		0,
		Lang.get(68609),
		24700,
		3,
		753,
		{
			RTResTalkAction[13],
			RTResTalkAction[5]
		},
		nil,
		nil,
		5
	},
	[24700004] = {
		24700004,
		0,
		Lang.get(68610),
		24700,
		4,
		753,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		5
	},
	[24700005] = {
		24700005,
		0,
		Lang.get(68611),
		24700,
		5,
		753,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		5
	},
	[24700006] = {
		24700006,
		0,
		Lang.get(68612),
		24700,
		6,
		751,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		},
		nil,
		nil,
		5
	},
	[24700007] = {
		24700007,
		0,
		Lang.get(68613),
		24700,
		7,
		751,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		-1
	},
	[24700008] = {
		24700008,
		0,
		Lang.get(68614),
		24700,
		8,
		753,
		nil,
		1,
		1,
		nil,
		nil,
		60
	},
	[24700009] = {
		24700009,
		0,
		Lang.get(68615),
		24700,
		9,
		753,
		nil,
		1,
		2
	},
	[24700010] = {
		24700010,
		0,
		Lang.get(68616),
		24700,
		10,
		753,
		nil,
		1,
		3
	},
	[24700011] = {
		24700011,
		0,
		"……",
		24700,
		11,
		751,
		nil,
		1,
		4
	},
	[24700012] = {
		24700012,
		0,
		Lang.get(68617),
		24700,
		12,
		751,
		nil,
		1,
		1
	},
	[24700013] = {
		24700013,
		3,
		Lang.get(68618),
		24700,
		13,
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
