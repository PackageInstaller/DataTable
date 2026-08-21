-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\aoteman\\ResTalk.lua

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
	[2] = 101
}
RTResTalkAction[2] = {
	1,
	101,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[3] = {
	1,
	101,
	nil,
	nil,
	2
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 101
}
RTResTalkAction[5] = {
	1,
	101,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[6] = {
	1,
	101,
	nil,
	nil,
	1
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 101
}
RTResTalkAction[8] = {
	[1] = 3,
	[2] = 16
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 16
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 29
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 16
}
RTResTalkAction[12] = {
	[1] = 2,
	[2] = 29
}
RTResTalkAction[13] = {
	[1] = 3,
	[2] = 20
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 20
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 29
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[17] = {
	1,
	101,
	nil,
	nil,
	0
}
RTResTalkAction[18] = {
	1,
	101,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[19] = {
	1,
	101,
	nil,
	nil,
	3
}
RTResTalkAction[20] = {
	1,
	101,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		3
	}
}
RTResTalkAction[22] = {
	1,
	134,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[24] = {
	2,
	134,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 43,
	[3] = {
		3
	}
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 42,
	[3] = {
		3
	}
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 43
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 42,
	[3] = {
		2
	}
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 42
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		2
	}
}
RTResTalkAction[34] = {
	1,
	141,
	nil,
	nil,
	1
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 42
}
RTResTalkAction[37] = {
	3,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[38] = {
	3,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[39] = {
	3,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[40] = {
	[1] = 2,
	[2] = 42,
	[3] = {
		3
	}
}
RTResTalkAction[41] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[42] = {
	3,
	134,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[43] = {
	1,
	134,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[44] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 42
}
RTResTalkAction[46] = {
	2,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	[1] = 3,
	[2] = 42,
	[3] = {
		2
	}
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 719
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 719
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[52] = {
	1,
	158,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[53] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[54] = {
	1,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[55] = {
	1,
	158,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[56] = {
	1,
	158,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[58] = {
	[1] = 3,
	[2] = 159
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 576
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 576
}
RTResTalkAction[63] = {
	[1] = 3,
	[2] = 386
}
RTResTalkAction[64] = {
	2,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	[1] = 3,
	[2] = 386,
	[3] = {
		2
	}
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[67] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[68] = {
	1,
	107,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[69] = {
	1,
	107,
	{
		3
	},
	nil,
	5
}
RTResTalkAction[70] = {
	[1] = 3,
	[2] = 43
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 101,
	[3] = {
		3
	}
}
RTResTalkAction[72] = {
	1,
	158,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		3
	}
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[75] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[76] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[77] = {
	[1] = 3,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[78] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[79] = {
	[1] = 3,
	[2] = 158
}
RTResTalkAction[80] = {
	3,
	158,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[81] = {
	2,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[82] = {
	3,
	158,
	nil,
	nil,
	3
}
RTResTalkAction[83] = {
	1,
	158,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[84] = {
	[1] = 3,
	[2] = 719
}
RTResTalkAction[85] = {
	[1] = 2,
	[2] = 101,
	[3] = {
		2
	}
}
RTResTalkAction[86] = {
	2,
	101,
	nil,
	nil,
	3
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 101,
	[3] = {
		1
	}
}
RTResTalkAction[88] = {
	2,
	101,
	nil,
	nil,
	2
}
RTResTalkAction[89] = {
	2,
	101,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[90] = {
	2,
	101,
	nil,
	nil,
	0
}
RTResTalkAction[91] = {
	[1] = 2,
	[2] = 719
}
RTResTalkAction[92] = {
	3,
	101,
	nil,
	nil,
	0
}
RTResTalkAction[93] = {
	3,
	101,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[94] = {
	[1] = 3,
	[2] = 101
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 3
}
RTResTalkAction[96] = {
	1,
	101,
	{
		2
	},
	nil,
	0
}

local Data = {
	[27000001] = {
		27000001,
		0,
		Lang.get(67188),
		27000,
		1,
		20,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		27000,
		nil,
		nil,
		nil,
		nil,
		nil,
		27000
	},
	[27000002] = {
		27000002,
		0,
		Lang.get(49557),
		27000,
		2,
		29,
		nil,
		1
	},
	[27000003] = {
		27000003,
		0,
		Lang.get(67189),
		27000,
		3,
		16,
		nil,
		1
	},
	[27000004] = {
		27000004,
		0,
		Lang.get(67190),
		27000,
		4,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27001,
		[19] = 27001,
		[17] = 1
	},
	[27000005] = {
		27000005,
		0,
		Lang.get(67191),
		27000,
		5,
		101,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[27000006] = {
		27000006,
		0,
		Lang.get(67192),
		27000,
		6,
		101,
		{
			RTResTalkAction[2]
		}
	},
	[27000007] = {
		27000007,
		0,
		Lang.get(67193),
		27000,
		7,
		101,
		{
			RTResTalkAction[3]
		}
	},
	[27000008] = {
		27000008,
		0,
		Lang.get(27491),
		27000,
		8,
		16,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		27002,
		1,
		1,
		nil,
		1,
		nil,
		27002
	},
	[27000009] = {
		27000009,
		0,
		Lang.get(67194),
		27000,
		9,
		29,
		nil,
		1
	},
	[27000010] = {
		27000010,
		0,
		Lang.get(67195),
		27000,
		10,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27003,
		[19] = 27003,
		[17] = 1
	},
	[27000011] = {
		27000011,
		0,
		Lang.get(67196),
		27000,
		11,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27004,
		[19] = 27004,
		[17] = 1
	},
	[27000012] = {
		27000012,
		0,
		Lang.get(67197),
		27000,
		12,
		16,
		nil,
		1,
		nil,
		nil,
		nil,
		60
	},
	[27000013] = {
		27000013,
		0,
		Lang.get(67198),
		27000,
		13,
		16,
		nil,
		1
	},
	[27000014] = {
		27000014,
		0,
		Lang.get(67199),
		27000,
		14,
		29,
		nil,
		1
	},
	[27000015] = {
		27000015,
		0,
		"？？？",
		27000,
		15,
		101,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[27000016] = {
		27000016,
		0,
		Lang.get(67200),
		27000,
		16,
		101,
		{
			RTResTalkAction[6]
		}
	},
	[27000017] = {
		27000017,
		0,
		Lang.get(67201),
		27000,
		17,
		16,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[27000018] = {
		27000018,
		0,
		Lang.get(67202),
		27000,
		18,
		16,
		{
			RTResTalkAction[9],
			RTResTalkAction[4]
		}
	},
	[27000019] = {
		27000019,
		0,
		Lang.get(67203),
		27000,
		19,
		29,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[27000020] = {
		27000020,
		0,
		Lang.get(67204),
		27000,
		20,
		20,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[27000021] = {
		27000021,
		0,
		Lang.get(67205),
		27000,
		21,
		29,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[27000022] = {
		27000022,
		0,
		Lang.get(67206),
		27000,
		22,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[27000023] = {
		27000023,
		0,
		Lang.get(67207),
		27000,
		23,
		16,
		{
			RTResTalkAction[9],
			RTResTalkAction[16]
		}
	},
	[27000024] = {
		27000024,
		0,
		Lang.get(67208),
		27000,
		24,
		101,
		{
			RTResTalkAction[6],
			RTResTalkAction[11]
		}
	},
	[27001001] = {
		27001001,
		0,
		Lang.get(67209),
		27001,
		1,
		101,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		27005,
		nil,
		nil,
		nil,
		nil,
		nil,
		27005
	},
	[27001002] = {
		27001002,
		0,
		Lang.get(67210),
		27001,
		2,
		101,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[27001003] = {
		27001003,
		0,
		Lang.get(67211),
		27001,
		3,
		101,
		{
			RTResTalkAction[17]
		}
	},
	[27001004] = {
		27001004,
		0,
		Lang.get(67212),
		27001,
		4,
		101,
		{
			RTResTalkAction[18]
		}
	},
	[27001005] = {
		27001005,
		0,
		Lang.get(42598),
		27001,
		5,
		3,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		1070,
		nil,
		27006,
		1,
		1,
		nil,
		1,
		nil,
		27006
	},
	[27001006] = {
		27001006,
		0,
		Lang.get(67213),
		27001,
		6,
		101,
		nil,
		1,
		0
	},
	[27001007] = {
		27001007,
		0,
		Lang.get(67214),
		27001,
		7,
		101,
		nil,
		1,
		0
	},
	[27001008] = {
		27001008,
		0,
		Lang.get(67215),
		27001,
		8,
		101,
		nil,
		1,
		0
	},
	[27001009] = {
		27001009,
		0,
		Lang.get(67216),
		27001,
		9,
		101,
		nil,
		1,
		3
	},
	[27001010] = {
		27001010,
		0,
		Lang.get(49118),
		27001,
		10,
		3,
		nil,
		1,
		nil,
		nil,
		1070
	},
	[27001011] = {
		27001011,
		0,
		Lang.get(67217),
		27001,
		11,
		101,
		nil,
		1,
		3
	},
	[27001012] = {
		27001012,
		0,
		Lang.get(67218),
		27001,
		12,
		721,
		nil,
		1,
		nil,
		nil,
		1231,
		57,
		27007,
		nil,
		nil,
		nil,
		1,
		nil,
		27007
	},
	[27001013] = {
		27001013,
		5,
		Lang.get(67219),
		27001,
		13,
		101,
		nil,
		1,
		1
	},
	[27001014] = {
		27001014,
		0,
		Lang.get(67220),
		27001,
		14,
		101,
		nil,
		1,
		0
	},
	[27001015] = {
		27001015,
		0,
		Lang.get(49118),
		27001,
		15,
		721,
		nil,
		1,
		nil,
		nil,
		1070
	},
	[27001016] = {
		27001016,
		0,
		Lang.get(67221),
		27001,
		16,
		101,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		27008,
		nil,
		nil,
		nil,
		1,
		nil,
		27008
	},
	[27001017] = {
		27001017,
		0,
		Lang.get(67222),
		27001,
		17,
		101,
		nil,
		1,
		0
	},
	[27020001] = {
		27020001,
		0,
		Lang.get(66146),
		27020,
		1,
		774,
		nil,
		1,
		0,
		nil,
		2322,
		158,
		27009,
		1,
		1,
		nil,
		1,
		nil,
		27009
	},
	[27020002] = {
		27020002,
		5,
		Lang.get(67223),
		27020,
		2,
		101,
		nil,
		1,
		1
	},
	[27002001] = {
		27002001,
		0,
		Lang.get(69538),
		27002,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		27015,
		nil,
		nil,
		nil,
		nil,
		nil,
		27015
	},
	[27002002] = {
		27002002,
		0,
		Lang.get(67225),
		27002,
		2,
		101,
		nil,
		1,
		0
	},
	[27002003] = {
		27002003,
		0,
		Lang.get(67226),
		27002,
		3,
		774,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27002004] = {
		27002004,
		0,
		Lang.get(67227),
		27002,
		4,
		101,
		nil,
		1,
		1
	},
	[27002005] = {
		27002005,
		0,
		Lang.get(67228),
		27002,
		5,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27002006] = {
		27002006,
		0,
		Lang.get(67229),
		27002,
		6,
		101,
		nil,
		1,
		3
	},
	[27002007] = {
		27002007,
		0,
		Lang.get(67230),
		27002,
		7,
		101,
		nil,
		1,
		1
	},
	[27002008] = {
		27002008,
		0,
		Lang.get(67231),
		27002,
		8,
		101,
		nil,
		1,
		0
	},
	[27002009] = {
		27002009,
		0,
		Lang.get(69539),
		27002,
		9,
		101,
		nil,
		1,
		0
	},
	[27002010] = {
		27002010,
		0,
		Lang.get(66146),
		27002,
		10,
		774,
		nil,
		1,
		nil,
		nil,
		2328,
		nil,
		27016,
		nil,
		nil,
		nil,
		nil,
		nil,
		27016
	},
	[27002011] = {
		27002011,
		0,
		Lang.get(67233),
		27002,
		11,
		101,
		nil,
		1,
		1
	},
	[27002012] = {
		27002012,
		0,
		Lang.get(67234),
		27002,
		12,
		101,
		nil,
		1,
		3
	},
	[27002013] = {
		27002013,
		0,
		Lang.get(67235),
		27002,
		13,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27002014] = {
		27002014,
		0,
		Lang.get(67236),
		27002,
		14,
		101,
		nil,
		1,
		0
	},
	[27002015] = {
		27002015,
		0,
		Lang.get(67237),
		27002,
		15,
		101,
		nil,
		1,
		3
	},
	[27002016] = {
		27002016,
		0,
		Lang.get(67238),
		27002,
		16,
		101,
		nil,
		1,
		0
	},
	[27002017] = {
		27002017,
		0,
		Lang.get(67239),
		27002,
		17,
		101,
		nil,
		1,
		3
	},
	[27002018] = {
		27002018,
		0,
		Lang.get(67240),
		27002,
		18,
		101,
		nil,
		1,
		2
	},
	[27002019] = {
		27002019,
		0,
		Lang.get(67241),
		27002,
		19,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27002020] = {
		27002020,
		0,
		Lang.get(67242),
		27002,
		20,
		101,
		nil,
		1,
		0
	},
	[27003001] = {
		27003001,
		0,
		Lang.get(67243),
		27003,
		1,
		101,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		27020,
		nil,
		nil,
		nil,
		nil,
		nil,
		27020
	},
	[27003002] = {
		27003002,
		0,
		Lang.get(67244),
		27003,
		2,
		101,
		nil,
		1,
		1
	},
	[27003003] = {
		27003003,
		0,
		Lang.get(66146),
		27003,
		3,
		774,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27003004] = {
		27003004,
		0,
		Lang.get(67245),
		27003,
		4,
		101,
		nil,
		1,
		0
	},
	[27003005] = {
		27003005,
		0,
		Lang.get(67246),
		27003,
		5,
		101,
		nil,
		1,
		1
	},
	[27003006] = {
		27003006,
		0,
		Lang.get(67247),
		27003,
		6,
		101,
		nil,
		1,
		0
	},
	[27003007] = {
		27003007,
		0,
		Lang.get(67241),
		27003,
		7,
		774,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27003008] = {
		27003008,
		0,
		Lang.get(67248),
		27003,
		8,
		101,
		nil,
		1,
		3,
		nil,
		nil,
		122,
		27021,
		nil,
		nil,
		nil,
		nil,
		nil,
		27021
	},
	[27003009] = {
		27003009,
		0,
		Lang.get(67249),
		27003,
		9,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27003010] = {
		27003010,
		0,
		Lang.get(67250),
		27003,
		10,
		101,
		nil,
		1,
		3
	},
	[27003011] = {
		27003011,
		0,
		Lang.get(67251),
		27003,
		11,
		101,
		nil,
		1,
		2
	},
	[27003012] = {
		27003012,
		0,
		Lang.get(67252),
		27003,
		12,
		101,
		nil,
		1,
		2
	},
	[27003013] = {
		27003013,
		0,
		Lang.get(67241),
		27003,
		13,
		774,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27003014] = {
		27003014,
		0,
		Lang.get(67253),
		27003,
		14,
		101,
		nil,
		1,
		0
	},
	[27003015] = {
		27003015,
		0,
		Lang.get(67254),
		27003,
		15,
		101,
		nil,
		1,
		2
	},
	[27003016] = {
		27003016,
		0,
		Lang.get(67255),
		27003,
		16,
		101,
		nil,
		1,
		2
	},
	[27003017] = {
		27003017,
		0,
		Lang.get(66146),
		27003,
		17,
		774,
		nil,
		1,
		nil,
		nil,
		2322
	},
	[27003018] = {
		27003018,
		0,
		Lang.get(67256),
		27003,
		18,
		101,
		nil,
		1,
		3
	},
	[27003019] = {
		27003019,
		0,
		Lang.get(67257),
		27003,
		19,
		101,
		nil,
		1,
		2
	},
	[27003020] = {
		27003020,
		0,
		Lang.get(66146),
		27003,
		20,
		774,
		nil,
		1,
		nil,
		nil,
		2322
	},
	[27004001] = {
		27004001,
		0,
		Lang.get(67258),
		27004,
		1,
		101,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		27025,
		nil,
		nil,
		nil,
		nil,
		nil,
		27025
	},
	[27004002] = {
		27004002,
		0,
		Lang.get(67259),
		27004,
		2,
		101,
		nil,
		1,
		3
	},
	[27004003] = {
		27004003,
		0,
		Lang.get(67260),
		27004,
		3,
		101,
		nil,
		1
	},
	[27004004] = {
		27004004,
		0,
		Lang.get(67261),
		27004,
		4,
		101,
		nil,
		1,
		2
	},
	[27004005] = {
		27004005,
		0,
		Lang.get(67262),
		27004,
		5,
		101,
		nil,
		1
	},
	[27004006] = {
		27004006,
		0,
		Lang.get(67263),
		27004,
		6,
		101,
		nil,
		1
	},
	[27004007] = {
		27004007,
		0,
		Lang.get(67241),
		27004,
		7,
		774,
		nil,
		nil,
		nil,
		nil,
		2328
	},
	[27004008] = {
		27004008,
		0,
		Lang.get(67264),
		27004,
		8,
		101,
		nil,
		1,
		0
	},
	[27004009] = {
		27004009,
		0,
		Lang.get(67265),
		27004,
		9,
		101,
		nil,
		1,
		2
	},
	[27004010] = {
		27004010,
		0,
		Lang.get(67266),
		27004,
		10,
		101,
		nil,
		1,
		0
	},
	[27004011] = {
		27004011,
		0,
		Lang.get(67267),
		27004,
		11,
		101,
		nil,
		1,
		2
	},
	[27004012] = {
		27004012,
		0,
		Lang.get(67268),
		27004,
		12,
		101,
		nil,
		1,
		2
	},
	[27004013] = {
		27004013,
		0,
		Lang.get(69540),
		27004,
		13,
		101,
		nil,
		1,
		2
	},
	[27004014] = {
		27004014,
		0,
		Lang.get(67228),
		27004,
		14,
		774,
		nil,
		nil,
		nil,
		nil,
		2329
	},
	[27004015] = {
		27004015,
		0,
		Lang.get(67270),
		27004,
		15,
		101,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[27004016] = {
		27004016,
		0,
		Lang.get(67271),
		27004,
		16,
		101,
		{
			RTResTalkAction[2]
		}
	},
	[27004017] = {
		27004017,
		0,
		Lang.get(67272),
		27004,
		17,
		101,
		{
			RTResTalkAction[3]
		}
	},
	[27004018] = {
		27004018,
		0,
		Lang.get(67273),
		27004,
		18,
		101,
		{
			RTResTalkAction[20]
		}
	},
	[27005001] = {
		27005001,
		0,
		Lang.get(67274),
		27005,
		1,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		27030,
		nil,
		nil,
		nil,
		nil,
		nil,
		27030
	},
	[27005002] = {
		27005002,
		0,
		Lang.get(67275),
		27005,
		2,
		107,
		nil,
		1,
		2
	},
	[27005003] = {
		27005003,
		0,
		Lang.get(67276),
		27005,
		3,
		101,
		nil,
		1,
		3
	},
	[27005004] = {
		27005004,
		0,
		Lang.get(67277),
		27005,
		4,
		134,
		nil,
		1,
		4
	},
	[27005005] = {
		27005005,
		0,
		Lang.get(67278),
		27005,
		5,
		134,
		nil,
		1,
		1
	},
	[27005006] = {
		27005006,
		0,
		Lang.get(67279),
		27005,
		6,
		107,
		nil,
		1,
		2
	},
	[27005007] = {
		27005007,
		0,
		Lang.get(67280),
		27005,
		7,
		141,
		nil,
		1,
		2
	},
	[27005008] = {
		27005008,
		0,
		Lang.get(67281),
		27005,
		8,
		141,
		nil,
		1,
		3
	},
	[27005009] = {
		27005009,
		0,
		Lang.get(67282),
		27005,
		9,
		101,
		nil,
		1,
		2
	},
	[27005010] = {
		27005010,
		0,
		Lang.get(67283),
		27005,
		10,
		107,
		nil,
		1,
		2
	},
	[27005011] = {
		27005011,
		0,
		Lang.get(67284),
		27005,
		11,
		101,
		nil,
		1,
		3
	},
	[27005012] = {
		27005012,
		0,
		Lang.get(67285),
		27005,
		12,
		141,
		nil,
		1,
		2
	},
	[27005013] = {
		27005013,
		0,
		Lang.get(67286),
		27005,
		13,
		107,
		nil,
		1,
		7
	},
	[27005014] = {
		27005014,
		0,
		Lang.get(67287),
		27005,
		14,
		101,
		nil,
		1,
		1
	},
	[27005015] = {
		27005015,
		0,
		Lang.get(67288),
		27005,
		15,
		107,
		nil,
		1,
		6
	},
	[27005016] = {
		27005016,
		0,
		Lang.get(67289),
		27005,
		16,
		107,
		nil,
		1,
		5
	},
	[27005017] = {
		27005017,
		0,
		Lang.get(67290),
		27005,
		17,
		101,
		nil,
		1,
		0
	},
	[27005018] = {
		27005018,
		0,
		Lang.get(67291),
		27005,
		18,
		101,
		nil,
		1,
		2
	},
	[27005019] = {
		27005019,
		0,
		Lang.get(66146),
		27005,
		19,
		774,
		nil,
		1,
		nil,
		nil,
		2328,
		nil,
		27031,
		1,
		nil,
		nil,
		1,
		nil,
		27031
	},
	[27005020] = {
		27005020,
		5,
		Lang.get(67292),
		27005,
		20,
		107,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[27005021] = {
		27005021,
		5,
		Lang.get(67293),
		27005,
		21,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[23]
		}
	},
	[27005022] = {
		27005022,
		5,
		Lang.get(67294),
		27005,
		22,
		43,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[27005023] = {
		27005023,
		5,
		Lang.get(67295),
		27005,
		23,
		42,
		{
			RTResTalkAction[26],
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[27006001] = {
		27006001,
		0,
		Lang.get(69541),
		27006,
		1,
		43,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		27035,
		1,
		nil,
		nil,
		nil,
		nil,
		27035
	},
	[27006002] = {
		27006002,
		0,
		Lang.get(69542),
		27006,
		2,
		42,
		nil,
		1
	},
	[27006003] = {
		27006003,
		0,
		Lang.get(67298),
		27006,
		3,
		43,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[27006004] = {
		27006004,
		0,
		Lang.get(67299),
		27006,
		4,
		42,
		{
			RTResTalkAction[30],
			RTResTalkAction[28]
		}
	},
	[27006005] = {
		27006005,
		0,
		Lang.get(67300),
		27006,
		5,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27006006] = {
		27006006,
		0,
		Lang.get(67301),
		27006,
		6,
		42,
		{
			RTResTalkAction[26]
		}
	},
	[27006007] = {
		27006007,
		0,
		Lang.get(66146),
		27006,
		7,
		774,
		{
			RTResTalkAction[32]
		},
		1,
		nil,
		nil,
		2328,
		nil,
		27036,
		1,
		1,
		nil,
		1,
		nil,
		27036
	},
	[27006008] = {
		27006008,
		0,
		Lang.get(67302),
		27006,
		8,
		101,
		nil,
		1,
		1
	},
	[27006009] = {
		27006009,
		0,
		Lang.get(67303),
		27006,
		9,
		300,
		[19] = 27037,
		[17] = 1
	},
	[27006010] = {
		27006010,
		5,
		Lang.get(67304),
		27006,
		10,
		42,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[27006011] = {
		27006011,
		0,
		Lang.get(67305),
		27006,
		11,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27006012] = {
		27006012,
		0,
		Lang.get(67306),
		27006,
		12,
		42,
		{
			RTResTalkAction[30]
		}
	},
	[27006013] = {
		27006013,
		0,
		Lang.get(67307),
		27006,
		13,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[27006014] = {
		27006014,
		0,
		Lang.get(27060),
		27006,
		14,
		300
	},
	[27006015] = {
		27006015,
		0,
		Lang.get(67308),
		27006,
		15,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27006016] = {
		27006016,
		0,
		Lang.get(67309),
		27006,
		16,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[27006017] = {
		27006017,
		0,
		Lang.get(67310),
		27006,
		17,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27038,
		1,
		nil,
		nil,
		1,
		nil,
		27038
	},
	[27006018] = {
		27006018,
		0,
		Lang.get(67311),
		27006,
		18,
		300
	},
	[27006019] = {
		27006019,
		0,
		Lang.get(67312),
		27006,
		19,
		300
	},
	[27006020] = {
		27006020,
		0,
		Lang.get(67241),
		27006,
		20,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27006021] = {
		27006021,
		0,
		Lang.get(69543),
		27006,
		21,
		141,
		nil,
		1
	},
	[27006022] = {
		27006022,
		0,
		Lang.get(67314),
		27006,
		22,
		141,
		nil,
		1
	},
	[27007001] = {
		27007001,
		0,
		Lang.get(67315),
		27007,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		27040,
		[19] = 27040
	},
	[27007002] = {
		27007002,
		0,
		Lang.get(67316),
		27007,
		2,
		300,
		nil,
		1
	},
	[27007003] = {
		27007003,
		0,
		Lang.get(67317),
		27007,
		3,
		42,
		nil,
		1
	},
	[27007004] = {
		27007004,
		0,
		Lang.get(67318),
		27007,
		4,
		42,
		nil,
		1
	},
	[27007005] = {
		27007005,
		0,
		Lang.get(67241),
		27007,
		5,
		774,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27007006] = {
		27007006,
		0,
		Lang.get(67319),
		27007,
		6,
		300
	},
	[27007007] = {
		27007007,
		0,
		Lang.get(67320),
		27007,
		7,
		107,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[27007008] = {
		27007008,
		0,
		Lang.get(67321),
		27007,
		8,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[27007009] = {
		27007009,
		0,
		Lang.get(67322),
		27007,
		9,
		141,
		{
			RTResTalkAction[34]
		}
	},
	[27007010] = {
		27007010,
		0,
		Lang.get(69544),
		27007,
		10,
		101,
		{
			RTResTalkAction[1],
			RTResTalkAction[35]
		}
	},
	[27007011] = {
		27007011,
		0,
		Lang.get(67324),
		27007,
		11,
		101,
		{
			RTResTalkAction[20]
		}
	},
	[27007012] = {
		27007012,
		0,
		Lang.get(67325),
		27007,
		12,
		42,
		{
			RTResTalkAction[26],
			RTResTalkAction[4]
		}
	},
	[27007013] = {
		27007013,
		0,
		Lang.get(67326),
		27007,
		13,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27007014] = {
		27007014,
		0,
		Lang.get(70080),
		27007,
		14,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27007015] = {
		27007015,
		0,
		Lang.get(67328),
		27007,
		15,
		107,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[27008001] = {
		27008001,
		0,
		Lang.get(70081),
		27008,
		1,
		42,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3,
		nil,
		60,
		27045,
		nil,
		nil,
		nil,
		nil,
		nil,
		27045
	},
	[27008002] = {
		27008002,
		0,
		Lang.get(67330),
		27008,
		2,
		134,
		{
			RTResTalkAction[36],
			RTResTalkAction[38]
		}
	},
	[27008003] = {
		27008003,
		0,
		Lang.get(67331),
		27008,
		3,
		134,
		{
			RTResTalkAction[36],
			RTResTalkAction[38]
		}
	},
	[27008004] = {
		27008004,
		0,
		Lang.get(70082),
		27008,
		4,
		134,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[27008005] = {
		27008005,
		5,
		Lang.get(67333),
		27008,
		5,
		42,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[27008006] = {
		27008006,
		0,
		Lang.get(67334),
		27008,
		6,
		134,
		{
			RTResTalkAction[36],
			RTResTalkAction[42]
		}
	},
	[27008007] = {
		27008007,
		0,
		Lang.get(67241),
		27008,
		7,
		774,
		{
			RTResTalkAction[32],
			RTResTalkAction[27]
		},
		1,
		nil,
		nil,
		2322,
		nil,
		27046,
		1,
		1,
		nil,
		nil,
		nil,
		27046
	},
	[27008008] = {
		27008008,
		0,
		Lang.get(67335),
		27008,
		8,
		42,
		nil,
		1
	},
	[27008009] = {
		27008009,
		0,
		Lang.get(67336),
		27008,
		9,
		107,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		27047,
		1,
		nil,
		nil,
		1,
		nil,
		27047
	},
	[27008010] = {
		27008010,
		0,
		Lang.get(67337),
		27008,
		10,
		107,
		nil,
		1,
		3
	},
	[27008011] = {
		27008011,
		0,
		Lang.get(67338),
		27008,
		11,
		134,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[27008012] = {
		27008012,
		0,
		Lang.get(67339),
		27008,
		12,
		42,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[27008013] = {
		27008013,
		0,
		Lang.get(67340),
		27008,
		13,
		134,
		{
			RTResTalkAction[46],
			RTResTalkAction[45]
		}
	},
	[27008014] = {
		27008014,
		0,
		"……",
		27008,
		14,
		42,
		{
			RTResTalkAction[44],
			RTResTalkAction[47]
		}
	},
	[27021001] = {
		27021001,
		0,
		Lang.get(70083),
		27021,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		27048,
		[19] = 27048,
		[20] = 255
	},
	[27021002] = {
		27021002,
		0,
		Lang.get(70084),
		27021,
		2,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27049,
		1,
		[19] = 27049,
		[20] = -1
	},
	[27021003] = {
		27021003,
		0,
		Lang.get(67343),
		27021,
		3,
		300
	},
	[27021004] = {
		27021004,
		0,
		Lang.get(66146),
		27021,
		4,
		719,
		nil,
		1,
		nil,
		nil,
		2322,
		nil,
		27050,
		nil,
		nil,
		nil,
		nil,
		nil,
		27050
	},
	[27021005] = {
		27021005,
		0,
		Lang.get(67344),
		27021,
		5,
		300
	},
	[27021006] = {
		27021006,
		0,
		Lang.get(67345),
		27021,
		6,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27051,
		[19] = 27051
	},
	[27021007] = {
		27021007,
		0,
		Lang.get(70085),
		27021,
		7,
		300
	},
	[27021008] = {
		27021008,
		0,
		Lang.get(67347),
		27021,
		8,
		141,
		nil,
		1
	},
	[27021009] = {
		27021009,
		0,
		Lang.get(67348),
		27021,
		9,
		300
	},
	[27021010] = {
		27021010,
		0,
		Lang.get(67349),
		27021,
		10,
		101,
		nil,
		1
	},
	[27021011] = {
		27021011,
		0,
		Lang.get(67350),
		27021,
		11,
		300
	},
	[27009001] = {
		27009001,
		0,
		Lang.get(67351),
		27009,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		27055,
		nil,
		nil,
		nil,
		nil,
		nil,
		27055
	},
	[27009002] = {
		27009002,
		0,
		Lang.get(67352),
		27009,
		2,
		300
	},
	[27009003] = {
		27009003,
		0,
		Lang.get(67353),
		27009,
		3,
		300
	},
	[27009004] = {
		27009004,
		0,
		Lang.get(67354),
		27009,
		4,
		722,
		nil,
		1
	},
	[27009005] = {
		27009005,
		0,
		Lang.get(67355),
		27009,
		5,
		723,
		nil,
		1
	},
	[27009006] = {
		27009006,
		0,
		Lang.get(67356),
		27009,
		6,
		724,
		nil,
		1
	},
	[27009007] = {
		27009007,
		0,
		Lang.get(67357),
		27009,
		7,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27056,
		[19] = 27056,
		[17] = 1
	},
	[27009008] = {
		27009008,
		0,
		Lang.get(67358),
		27009,
		8,
		722,
		nil,
		1
	},
	[27009009] = {
		27009009,
		0,
		Lang.get(67359),
		27009,
		9,
		158,
		nil,
		1
	},
	[27009010] = {
		27009010,
		3,
		Lang.get(67360),
		27009,
		10,
		605,
		nil,
		nil,
		nil,
		3,
		[22] = 1,
		[20] = 255
	},
	[27009011] = {
		27009011,
		0,
		Lang.get(67361),
		27009,
		11,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		27057,
		nil,
		nil,
		nil,
		1,
		nil,
		27057,
		-1
	},
	[27009012] = {
		27009012,
		0,
		Lang.get(67241),
		27009,
		12,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3,
		2328
	},
	[27009013] = {
		27009013,
		0,
		Lang.get(67362),
		27009,
		13,
		158,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[27009014] = {
		27009014,
		0,
		Lang.get(67363),
		27009,
		14,
		300,
		{
			RTResTalkAction[51]
		}
	},
	[27009015] = {
		27009015,
		0,
		Lang.get(67364),
		27009,
		15,
		158,
		{
			RTResTalkAction[52]
		}
	},
	[27009016] = {
		27009016,
		0,
		Lang.get(67365),
		27009,
		16,
		158,
		{
			RTResTalkAction[53]
		}
	},
	[27009017] = {
		27009017,
		0,
		Lang.get(67241),
		27009,
		17,
		719,
		{
			RTResTalkAction[48],
			RTResTalkAction[51]
		},
		nil,
		nil,
		nil,
		2329
	},
	[27009018] = {
		27009018,
		0,
		Lang.get(67366),
		27009,
		18,
		158,
		{
			RTResTalkAction[54],
			RTResTalkAction[50]
		}
	},
	[27009019] = {
		27009019,
		0,
		Lang.get(67241),
		27009,
		19,
		719,
		{
			RTResTalkAction[48],
			RTResTalkAction[51]
		},
		nil,
		nil,
		nil,
		2328
	},
	[27009020] = {
		27009020,
		0,
		Lang.get(67367),
		27009,
		20,
		300,
		{
			RTResTalkAction[50]
		}
	},
	[27009021] = {
		27009021,
		0,
		Lang.get(67368),
		27009,
		21,
		158,
		{
			RTResTalkAction[54]
		}
	},
	[27009022] = {
		27009022,
		0,
		Lang.get(67369),
		27009,
		22,
		158,
		{
			RTResTalkAction[54]
		}
	},
	[27009023] = {
		27009023,
		0,
		Lang.get(67370),
		27009,
		23,
		158,
		{
			RTResTalkAction[55]
		}
	},
	[27010001] = {
		27010001,
		0,
		Lang.get(67371),
		27010,
		1,
		158,
		nil,
		1,
		0,
		nil,
		nil,
		60,
		27060,
		nil,
		nil,
		nil,
		nil,
		nil,
		27060
	},
	[27010002] = {
		27010002,
		0,
		Lang.get(67372),
		27010,
		2,
		159,
		nil,
		1,
		0
	},
	[27010003] = {
		27010003,
		0,
		Lang.get(67373),
		27010,
		3,
		158,
		{
			RTResTalkAction[56]
		}
	},
	[27010004] = {
		27010004,
		0,
		Lang.get(67374),
		27010,
		4,
		158,
		{
			RTResTalkAction[53]
		}
	},
	[27010005] = {
		27010005,
		0,
		Lang.get(67375),
		27010,
		5,
		158,
		{
			RTResTalkAction[54]
		}
	},
	[27010006] = {
		27010006,
		0,
		Lang.get(67376),
		27010,
		6,
		159,
		{
			RTResTalkAction[57],
			RTResTalkAction[58]
		}
	},
	[27010007] = {
		27010007,
		0,
		Lang.get(67377),
		27010,
		7,
		576,
		{
			RTResTalkAction[59],
			RTResTalkAction[51],
			RTResTalkAction[60]
		}
	},
	[27010008] = {
		27010008,
		0,
		Lang.get(67378),
		27010,
		8,
		158,
		{
			RTResTalkAction[61],
			RTResTalkAction[62]
		}
	},
	[27010009] = {
		27010009,
		0,
		Lang.get(69545),
		27010,
		9,
		386,
		{
			RTResTalkAction[57],
			RTResTalkAction[63]
		}
	},
	[27010010] = {
		27010010,
		0,
		Lang.get(67380),
		27010,
		10,
		158,
		{
			RTResTalkAction[64],
			RTResTalkAction[63]
		}
	},
	[27010011] = {
		27010011,
		0,
		Lang.get(67381),
		27010,
		11,
		386,
		{
			RTResTalkAction[57],
			RTResTalkAction[65]
		}
	},
	[27010012] = {
		27010012,
		3,
		Lang.get(69546),
		27010,
		12,
		605,
		{
			RTResTalkAction[51],
			RTResTalkAction[66]
		},
		nil,
		nil,
		3,
		nil,
		62,
		27061,
		nil,
		nil,
		nil,
		nil,
		nil,
		27061,
		255,
		nil,
		1
	},
	[27010013] = {
		27010013,
		0,
		Lang.get(67383),
		27010,
		13,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27062,
		[19] = 27062,
		[20] = -1
	},
	[27010014] = {
		27010014,
		0,
		Lang.get(67384),
		27010,
		14,
		386,
		nil,
		1
	},
	[27010015] = {
		27010015,
		0,
		Lang.get(67385),
		27010,
		15,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27063,
		1,
		nil,
		nil,
		1,
		nil,
		27063
	},
	[27010016] = {
		27010016,
		0,
		Lang.get(67386),
		27010,
		16,
		386,
		nil,
		1
	},
	[27010017] = {
		27010017,
		0,
		Lang.get(67387),
		27010,
		17,
		386,
		nil,
		1
	},
	[27010018] = {
		27010018,
		0,
		Lang.get(67388),
		27010,
		18,
		386,
		nil,
		1
	},
	[27010019] = {
		27010019,
		0,
		Lang.get(67389),
		27010,
		19,
		386,
		nil,
		1
	},
	[27010020] = {
		27010020,
		0,
		Lang.get(67390),
		27010,
		20,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		27064,
		[19] = 27064,
		[17] = 1
	},
	[27010021] = {
		27010021,
		0,
		Lang.get(67391),
		27010,
		21,
		386,
		nil,
		1
	},
	[27010022] = {
		27010022,
		0,
		Lang.get(67392),
		27010,
		22,
		386,
		nil,
		1
	},
	[27010023] = {
		27010023,
		0,
		Lang.get(67393),
		27010,
		23,
		386,
		nil,
		1
	},
	[27010024] = {
		27010024,
		0,
		Lang.get(67394),
		27010,
		24,
		158,
		nil,
		1
	},
	[27011001] = {
		27011001,
		3,
		Lang.get(67395),
		27011,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		27070,
		[19] = 27070,
		[22] = 1
	},
	[27011002] = {
		27011002,
		0,
		Lang.get(67396),
		27011,
		2,
		158,
		nil,
		1
	},
	[27011003] = {
		27011003,
		0,
		Lang.get(67397),
		27011,
		3,
		280,
		nil,
		1
	},
	[27011004] = {
		27011004,
		0,
		Lang.get(16581),
		27011,
		4,
		281,
		nil,
		1
	},
	[27011005] = {
		27011005,
		0,
		Lang.get(67398),
		27011,
		5,
		158,
		nil,
		1
	},
	[27011006] = {
		27011006,
		0,
		Lang.get(67399),
		27011,
		6,
		158,
		nil,
		1
	},
	[27011007] = {
		27011007,
		0,
		Lang.get(66146),
		27011,
		7,
		719,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27011008] = {
		27011008,
		0,
		Lang.get(67400),
		27011,
		8,
		300
	},
	[27011009] = {
		27011009,
		0,
		Lang.get(67401),
		27011,
		9,
		300
	},
	[27011010] = {
		27011010,
		0,
		Lang.get(67402),
		27011,
		10,
		300
	},
	[27011011] = {
		27011011,
		0,
		Lang.get(67403),
		27011,
		11,
		158,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[27011012] = {
		27011012,
		0,
		Lang.get(67404),
		27011,
		12,
		300,
		{
			RTResTalkAction[51]
		}
	},
	[27011013] = {
		27011013,
		0,
		Lang.get(67405),
		27011,
		13,
		158,
		{
			RTResTalkAction[67]
		}
	},
	[27011014] = {
		27011014,
		0,
		Lang.get(67406),
		27011,
		14,
		300,
		{
			RTResTalkAction[51]
		}
	},
	[27011015] = {
		27011015,
		0,
		Lang.get(67407),
		27011,
		15,
		158,
		{
			RTResTalkAction[56]
		}
	},
	[27011016] = {
		27011016,
		0,
		Lang.get(67408),
		27011,
		16,
		158,
		{
			RTResTalkAction[54]
		}
	},
	[27011017] = {
		27011017,
		0,
		Lang.get(67409),
		27011,
		17,
		158,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		27071,
		1,
		1,
		nil,
		1,
		nil,
		27071
	},
	[27011018] = {
		27011018,
		0,
		Lang.get(69547),
		27011,
		18,
		158,
		nil,
		1
	},
	[27011019] = {
		27011019,
		0,
		Lang.get(66146),
		27011,
		19,
		719,
		nil,
		1
	},
	[27011020] = {
		27011020,
		0,
		Lang.get(67411),
		27011,
		20,
		101,
		nil,
		1,
		3
	},
	[27012001] = {
		27012001,
		0,
		Lang.get(67412),
		27012,
		1,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		57,
		27075,
		nil,
		nil,
		nil,
		nil,
		nil,
		27075
	},
	[27012002] = {
		27012002,
		0,
		Lang.get(67413),
		27012,
		2,
		107,
		nil,
		1,
		3
	},
	[27012003] = {
		27012003,
		0,
		Lang.get(66146),
		27012,
		3,
		719,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27012004] = {
		27012004,
		0,
		Lang.get(67414),
		27012,
		4,
		101,
		nil,
		1,
		1
	},
	[27012005] = {
		27012005,
		0,
		Lang.get(67415),
		27012,
		5,
		101,
		nil,
		1,
		1
	},
	[27012006] = {
		27012006,
		0,
		Lang.get(67416),
		27012,
		6,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		nil,
		27076,
		1,
		nil,
		nil,
		nil,
		nil,
		27076
	},
	[27012007] = {
		27012007,
		0,
		Lang.get(66146),
		27012,
		7,
		719,
		nil,
		1,
		nil,
		nil,
		2322,
		nil,
		27077,
		1,
		nil,
		nil,
		1,
		nil,
		27077
	},
	[27012008] = {
		27012008,
		0,
		Lang.get(67417),
		27012,
		8,
		107,
		nil,
		1,
		3
	},
	[27012009] = {
		27012009,
		0,
		Lang.get(66146),
		27012,
		9,
		719,
		nil,
		1
	},
	[27012010] = {
		27012010,
		0,
		Lang.get(67418),
		27012,
		10,
		42,
		nil,
		1
	},
	[27012011] = {
		27012011,
		0,
		Lang.get(67419),
		27012,
		11,
		43,
		nil,
		1
	},
	[27012012] = {
		27012012,
		0,
		Lang.get(67420),
		27012,
		12,
		719,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27022001] = {
		27022001,
		0,
		Lang.get(67421),
		27022,
		1,
		158,
		nil,
		1,
		1,
		nil,
		nil,
		60,
		27084,
		nil,
		nil,
		nil,
		nil,
		nil,
		27084
	},
	[27022002] = {
		27022002,
		0,
		Lang.get(67422),
		27022,
		2,
		107,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1
	},
	[27022003] = {
		27022003,
		5,
		Lang.get(67423),
		27022,
		3,
		107,
		{
			RTResTalkAction[69]
		}
	},
	[27022004] = {
		27022004,
		0,
		Lang.get(67424),
		27022,
		4,
		42,
		{
			RTResTalkAction[26],
			RTResTalkAction[23]
		}
	},
	[27022005] = {
		27022005,
		0,
		Lang.get(67425),
		27022,
		5,
		42,
		{
			RTResTalkAction[31]
		}
	},
	[27022006] = {
		27022006,
		0,
		Lang.get(67426),
		27022,
		6,
		43,
		{
			RTResTalkAction[36],
			RTResTalkAction[70]
		}
	},
	[27022007] = {
		27022007,
		0,
		Lang.get(67427),
		27022,
		7,
		101,
		{
			RTResTalkAction[1],
			RTResTalkAction[32],
			RTResTalkAction[28]
		}
	},
	[27022008] = {
		27022008,
		0,
		Lang.get(67428),
		27022,
		8,
		42,
		{
			RTResTalkAction[31],
			RTResTalkAction[4]
		}
	},
	[27022009] = {
		27022009,
		5,
		Lang.get(67429),
		27022,
		9,
		101,
		{
			RTResTalkAction[71],
			RTResTalkAction[32]
		}
	},
	[27022010] = {
		27022010,
		0,
		Lang.get(67430),
		27022,
		10,
		42,
		{
			RTResTalkAction[31],
			RTResTalkAction[4]
		}
	},
	[27022011] = {
		27022011,
		0,
		Lang.get(67431),
		27022,
		11,
		158,
		{
			RTResTalkAction[72],
			RTResTalkAction[32]
		}
	},
	[27022012] = {
		27022012,
		0,
		Lang.get(67432),
		27022,
		12,
		386,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		27078,
		1,
		1,
		nil,
		1,
		nil,
		27078
	},
	[27022013] = {
		27022013,
		0,
		Lang.get(67433),
		27022,
		13,
		158,
		nil,
		1
	},
	[27013001] = {
		27013001,
		0,
		Lang.get(67434),
		27013,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		27080,
		[19] = 27080
	},
	[27013002] = {
		27013002,
		0,
		Lang.get(67435),
		27013,
		2,
		158,
		nil,
		1
	},
	[27013003] = {
		27013003,
		0,
		Lang.get(67034),
		27013,
		3,
		386,
		nil,
		1,
		nil,
		nil,
		2335,
		nil,
		27081,
		nil,
		nil,
		nil,
		1,
		nil,
		27081
	},
	[27013004] = {
		27013004,
		0,
		Lang.get(66146),
		27013,
		4,
		719,
		nil,
		1,
		nil,
		nil,
		2322
	},
	[27013005] = {
		27013005,
		0,
		Lang.get(67436),
		27013,
		5,
		386,
		nil,
		1
	},
	[27013006] = {
		27013006,
		0,
		Lang.get(67437),
		27013,
		6,
		386,
		nil,
		1
	},
	[27013007] = {
		27013007,
		0,
		Lang.get(66146),
		27013,
		7,
		719,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27013008] = {
		27013008,
		0,
		Lang.get(67438),
		27013,
		8,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		27082,
		1,
		nil,
		nil,
		1,
		nil,
		27082
	},
	[27013009] = {
		27013009,
		0,
		Lang.get(67439),
		27013,
		9,
		300,
		nil,
		1
	},
	[27013010] = {
		27013010,
		0,
		Lang.get(67440),
		27013,
		10,
		719,
		nil,
		1,
		nil,
		nil,
		2329,
		nil,
		27083,
		nil,
		nil,
		nil,
		1,
		nil,
		27083
	},
	[27013011] = {
		27013011,
		0,
		Lang.get(67441),
		27013,
		11,
		386,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3,
		nil,
		122
	},
	[27013012] = {
		27013012,
		0,
		Lang.get(67442),
		27013,
		12,
		386,
		{
			RTResTalkAction[74]
		}
	},
	[27013013] = {
		27013013,
		0,
		Lang.get(67443),
		27013,
		13,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[27013014] = {
		27013014,
		0,
		Lang.get(67444),
		27013,
		14,
		107,
		{
			RTResTalkAction[75]
		}
	},
	[27013015] = {
		27013015,
		0,
		Lang.get(67445),
		27013,
		15,
		158,
		{
			RTResTalkAction[76],
			RTResTalkAction[77]
		}
	},
	[27013016] = {
		27013016,
		0,
		Lang.get(67446),
		27013,
		16,
		107,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		}
	},
	[27013017] = {
		27013017,
		0,
		Lang.get(67447),
		27013,
		17,
		158,
		{
			RTResTalkAction[76],
			RTResTalkAction[80]
		}
	},
	[27013018] = {
		27013018,
		0,
		Lang.get(67448),
		27013,
		18,
		107,
		{
			RTResTalkAction[81],
			RTResTalkAction[79]
		}
	},
	[27013019] = {
		27013019,
		0,
		Lang.get(67449),
		27013,
		19,
		158,
		{
			RTResTalkAction[76],
			RTResTalkAction[82]
		}
	},
	[27013020] = {
		27013020,
		0,
		Lang.get(67450),
		27013,
		20,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[51]
		}
	},
	[27013021] = {
		27013021,
		0,
		Lang.get(67241),
		27013,
		21,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		nil,
		2329
	},
	[27013022] = {
		27013022,
		0,
		Lang.get(67451),
		27013,
		22,
		158,
		{
			RTResTalkAction[83],
			RTResTalkAction[50]
		}
	},
	[27013023] = {
		27013023,
		3,
		Lang.get(67452),
		27013,
		23,
		605,
		{
			RTResTalkAction[51]
		},
		[22] = 1,
		[20] = 220
	},
	[27014001] = {
		27014001,
		0,
		Lang.get(67453),
		27014,
		1,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		27085,
		nil,
		nil,
		nil,
		nil,
		nil,
		27085
	},
	[27014002] = {
		27014002,
		0,
		Lang.get(67241),
		27014,
		2,
		719,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27014003] = {
		27014003,
		0,
		Lang.get(67454),
		27014,
		3,
		101,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[27014004] = {
		27014004,
		0,
		Lang.get(67455),
		27014,
		4,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014005] = {
		27014005,
		0,
		Lang.get(67241),
		27014,
		5,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2329
	},
	[27014006] = {
		27014006,
		0,
		Lang.get(67456),
		27014,
		6,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014007] = {
		27014007,
		0,
		Lang.get(67457),
		27014,
		7,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014008] = {
		27014008,
		0,
		Lang.get(67458),
		27014,
		8,
		101,
		{
			RTResTalkAction[85],
			RTResTalkAction[84]
		}
	},
	[27014009] = {
		27014009,
		0,
		Lang.get(67459),
		27014,
		9,
		101,
		{
			RTResTalkAction[86],
			RTResTalkAction[84]
		}
	},
	[27014010] = {
		27014010,
		0,
		Lang.get(67241),
		27014,
		10,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2328
	},
	[27014011] = {
		27014011,
		0,
		Lang.get(67460),
		27014,
		11,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014012] = {
		27014012,
		0,
		Lang.get(67461),
		27014,
		12,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014013] = {
		27014013,
		0,
		Lang.get(66146),
		27014,
		13,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2322
	},
	[27014014] = {
		27014014,
		0,
		Lang.get(67462),
		27014,
		14,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014015] = {
		27014015,
		0,
		Lang.get(67463),
		27014,
		15,
		101,
		{
			RTResTalkAction[85],
			RTResTalkAction[84]
		}
	},
	[27014016] = {
		27014016,
		0,
		Lang.get(67464),
		27014,
		16,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27014017] = {
		27014017,
		0,
		Lang.get(67465),
		27014,
		17,
		725,
		{
			RTResTalkAction[4],
			RTResTalkAction[50]
		}
	},
	[27014018] = {
		27014018,
		0,
		Lang.get(67466),
		27014,
		18,
		101,
		{
			RTResTalkAction[1]
		}
	},
	[27014019] = {
		27014019,
		0,
		Lang.get(69548),
		27014,
		19,
		101,
		{
			RTResTalkAction[1]
		}
	},
	[27015001] = {
		27015001,
		0,
		Lang.get(67468),
		27015,
		1,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		27090,
		nil,
		nil,
		nil,
		nil,
		nil,
		27090
	},
	[27015002] = {
		27015002,
		0,
		Lang.get(67469),
		27015,
		2,
		101,
		nil,
		1
	},
	[27015003] = {
		27015003,
		0,
		Lang.get(67470),
		27015,
		3,
		101,
		nil,
		1
	},
	[27015004] = {
		27015004,
		0,
		Lang.get(66176),
		27015,
		4,
		719,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27015005] = {
		27015005,
		0,
		Lang.get(67471),
		27015,
		5,
		101,
		{
			RTResTalkAction[87]
		},
		nil,
		nil,
		3
	},
	[27015006] = {
		27015006,
		0,
		Lang.get(67472),
		27015,
		6,
		101,
		{
			RTResTalkAction[1]
		}
	},
	[27015007] = {
		27015007,
		0,
		Lang.get(67473),
		27015,
		7,
		101,
		{
			RTResTalkAction[1]
		}
	},
	[27015008] = {
		27015008,
		0,
		Lang.get(66146),
		27015,
		8,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2322
	},
	[27015009] = {
		27015009,
		0,
		Lang.get(67474),
		27015,
		9,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27015010] = {
		27015010,
		0,
		Lang.get(67475),
		27015,
		10,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27015011] = {
		27015011,
		0,
		Lang.get(67476),
		27015,
		11,
		101,
		{
			RTResTalkAction[85],
			RTResTalkAction[84]
		}
	},
	[27015012] = {
		27015012,
		0,
		Lang.get(67241),
		27015,
		12,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2328
	},
	[27015013] = {
		27015013,
		0,
		Lang.get(67477),
		27015,
		13,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27015014] = {
		27015014,
		0,
		Lang.get(67478),
		27015,
		14,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27015015] = {
		27015015,
		0,
		Lang.get(66146),
		27015,
		15,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2322
	},
	[27015016] = {
		27015016,
		0,
		Lang.get(67479),
		27015,
		16,
		101,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27015017] = {
		27015017,
		0,
		Lang.get(67480),
		27015,
		17,
		101,
		{
			RTResTalkAction[88],
			RTResTalkAction[84]
		}
	},
	[27015018] = {
		27015018,
		0,
		Lang.get(67228),
		27015,
		18,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2329
	},
	[27015019] = {
		27015019,
		0,
		Lang.get(67481),
		27015,
		19,
		101,
		{
			RTResTalkAction[86],
			RTResTalkAction[84]
		}
	},
	[27015020] = {
		27015020,
		0,
		Lang.get(67482),
		27015,
		20,
		101,
		{
			RTResTalkAction[89],
			RTResTalkAction[84]
		}
	},
	[27015021] = {
		27015021,
		0,
		Lang.get(67241),
		27015,
		21,
		719,
		{
			RTResTalkAction[90],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2328
	},
	[27015022] = {
		27015022,
		0,
		Lang.get(67483),
		27015,
		22,
		101,
		{
			RTResTalkAction[86],
			RTResTalkAction[84]
		}
	},
	[27015023] = {
		27015023,
		0,
		Lang.get(67484),
		27015,
		23,
		101,
		{
			RTResTalkAction[90],
			RTResTalkAction[84]
		}
	},
	[27016001] = {
		27016001,
		0,
		Lang.get(67485),
		27016,
		1,
		101,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		27095,
		1,
		nil,
		nil,
		nil,
		nil,
		27095
	},
	[27016002] = {
		27016002,
		0,
		Lang.get(67486),
		27016,
		2,
		721,
		nil,
		1,
		nil,
		nil,
		1070,
		nil,
		27096,
		1,
		nil,
		nil,
		1,
		nil,
		27096
	},
	[27016003] = {
		27016003,
		0,
		Lang.get(67487),
		27016,
		3,
		101,
		nil,
		1
	},
	[27016004] = {
		27016004,
		0,
		Lang.get(67488),
		27016,
		4,
		101,
		nil,
		1,
		[21] = 3
	},
	[27016005] = {
		27016005,
		0,
		Lang.get(67241),
		27016,
		5,
		719,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27016006] = {
		27016006,
		0,
		Lang.get(49118),
		27016,
		6,
		721,
		nil,
		1,
		nil,
		nil,
		1231
	},
	[27016007] = {
		27016007,
		2,
		Lang.get(67489),
		27016,
		7,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		27097,
		1,
		nil,
		nil,
		nil,
		nil,
		27097
	},
	[27016008] = {
		27016008,
		2,
		Lang.get(67490),
		27016,
		8,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27016009] = {
		27016009,
		2,
		Lang.get(22273),
		27016,
		9,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27016010] = {
		27016010,
		0,
		Lang.get(66146),
		27016,
		10,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		nil,
		2322
	},
	[27016011] = {
		27016011,
		0,
		Lang.get(67491),
		27016,
		11,
		101,
		{
			RTResTalkAction[50]
		},
		1,
		nil,
		nil,
		nil,
		57,
		27098,
		1,
		1,
		nil,
		1,
		nil,
		27098,
		nil,
		1
	},
	[27016012] = {
		27016012,
		0,
		Lang.get(67492),
		27016,
		12,
		101,
		nil,
		1,
		[21] = 0
	},
	[27016013] = {
		27016013,
		0,
		Lang.get(67493),
		27016,
		13,
		101,
		nil,
		1,
		[21] = 0
	},
	[27016014] = {
		27016014,
		0,
		Lang.get(22021),
		27016,
		14,
		101,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3
	},
	[27016015] = {
		27016015,
		0,
		Lang.get(67494),
		27016,
		15,
		101,
		{
			RTResTalkAction[1]
		}
	},
	[27016016] = {
		27016016,
		0,
		Lang.get(66146),
		27016,
		16,
		719,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		2322,
		58,
		27099,
		1,
		1,
		nil,
		1,
		nil,
		27099
	},
	[27016017] = {
		27016017,
		0,
		Lang.get(67495),
		27016,
		17,
		101,
		nil,
		1,
		[21] = 1
	},
	[27016018] = {
		27016018,
		0,
		Lang.get(67496),
		27016,
		18,
		101,
		nil,
		1,
		[21] = 0
	},
	[27016019] = {
		27016019,
		0,
		Lang.get(67241),
		27016,
		19,
		719,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27016020] = {
		27016020,
		0,
		Lang.get(67497),
		27016,
		20,
		101,
		nil,
		1,
		[21] = 0
	},
	[27016021] = {
		27016021,
		0,
		Lang.get(67498),
		27016,
		21,
		101,
		nil,
		1,
		[21] = 0
	},
	[27016022] = {
		27016022,
		0,
		Lang.get(67241),
		27016,
		22,
		719,
		nil,
		1,
		nil,
		nil,
		2328
	},
	[27017001] = {
		27017001,
		0,
		Lang.get(67499),
		27017,
		1,
		101,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		58,
		27105,
		1,
		nil,
		nil,
		nil,
		nil,
		27105
	},
	[27017002] = {
		27017002,
		0,
		Lang.get(67241),
		27017,
		2,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2328
	},
	[27017003] = {
		27017003,
		2,
		Lang.get(67500),
		27017,
		3,
		719,
		{
			RTResTalkAction[48],
			RTResTalkAction[4]
		}
	},
	[27017004] = {
		27017004,
		2,
		Lang.get(67501),
		27017,
		4,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017005] = {
		27017005,
		2,
		Lang.get(67502),
		27017,
		5,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017006] = {
		27017006,
		2,
		Lang.get(67503),
		27017,
		6,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017007] = {
		27017007,
		2,
		Lang.get(67504),
		27017,
		7,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017008] = {
		27017008,
		2,
		Lang.get(67505),
		27017,
		8,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017009] = {
		27017009,
		2,
		Lang.get(67506),
		27017,
		9,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017010] = {
		27017010,
		2,
		Lang.get(67507),
		27017,
		10,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017011] = {
		27017011,
		2,
		Lang.get(68709),
		27017,
		11,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017012] = {
		27017012,
		2,
		Lang.get(67509),
		27017,
		12,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017013] = {
		27017013,
		2,
		Lang.get(67510),
		27017,
		13,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27017014] = {
		27017014,
		0,
		Lang.get(67511),
		27017,
		14,
		101,
		{
			RTResTalkAction[50]
		},
		1,
		1,
		nil,
		nil,
		nil,
		27106,
		nil,
		nil,
		nil,
		nil,
		nil,
		27106
	},
	[27017015] = {
		27017015,
		0,
		Lang.get(67512),
		27017,
		15,
		101,
		nil,
		1,
		1
	},
	[27017016] = {
		27017016,
		0,
		Lang.get(67513),
		27017,
		16,
		101,
		nil,
		1,
		1
	},
	[27017017] = {
		27017017,
		0,
		Lang.get(66176),
		27017,
		17,
		719,
		nil,
		1,
		nil,
		nil,
		2329
	},
	[27017018] = {
		27017018,
		2,
		Lang.get(67514),
		27017,
		18,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[27017019] = {
		27017019,
		0,
		Lang.get(67515),
		27017,
		19,
		101,
		{
			RTResTalkAction[91],
			RTResTalkAction[92]
		}
	},
	[27017020] = {
		27017020,
		0,
		Lang.get(67516),
		27017,
		20,
		101,
		{
			RTResTalkAction[91],
			RTResTalkAction[93]
		}
	},
	[27017021] = {
		27017021,
		2,
		Lang.get(67517),
		27017,
		21,
		719,
		{
			RTResTalkAction[91],
			RTResTalkAction[94]
		}
	},
	[27017022] = {
		27017022,
		0,
		Lang.get(66146),
		27017,
		22,
		719,
		{
			RTResTalkAction[48],
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		2322
	},
	[27023001] = {
		27023001,
		0,
		Lang.get(67486),
		27023,
		1,
		721,
		{
			RTResTalkAction[95]
		},
		nil,
		nil,
		nil,
		1070,
		nil,
		27200,
		[19] = 27200
	},
	[27018001] = {
		27018001,
		0,
		Lang.get(67518),
		27018,
		1,
		101,
		nil,
		1,
		1,
		nil,
		nil,
		58,
		27110,
		nil,
		nil,
		nil,
		nil,
		nil,
		27110
	},
	[27018002] = {
		27018002,
		0,
		Lang.get(67519),
		27018,
		2,
		101,
		nil,
		1,
		1
	},
	[27018003] = {
		27018003,
		0,
		Lang.get(67520),
		27018,
		3,
		101,
		nil,
		1,
		2
	},
	[27018004] = {
		27018004,
		2,
		Lang.get(67521),
		27018,
		4,
		719,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[27018005] = {
		27018005,
		2,
		Lang.get(67522),
		27018,
		5,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27018006] = {
		27018006,
		2,
		Lang.get(67523),
		27018,
		6,
		719,
		{
			RTResTalkAction[48]
		}
	},
	[27018007] = {
		27018007,
		0,
		Lang.get(67524),
		27018,
		7,
		101,
		{
			RTResTalkAction[96],
			RTResTalkAction[50]
		}
	},
	[27018008] = {
		27018008,
		0,
		Lang.get(67525),
		27018,
		8,
		101,
		{
			RTResTalkAction[3]
		}
	},
	[27018009] = {
		27018009,
		2,
		Lang.get(67526),
		27018,
		9,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		}
	},
	[27018010] = {
		27018010,
		0,
		Lang.get(67527),
		27018,
		10,
		101,
		{
			RTResTalkAction[88],
			RTResTalkAction[84]
		}
	},
	[27018011] = {
		27018011,
		0,
		Lang.get(67528),
		27018,
		11,
		101,
		{
			RTResTalkAction[86],
			RTResTalkAction[84]
		}
	},
	[27018012] = {
		27018012,
		0,
		Lang.get(67529),
		27018,
		12,
		101,
		{
			RTResTalkAction[89],
			RTResTalkAction[84]
		}
	},
	[27018013] = {
		27018013,
		0,
		Lang.get(66176),
		27018,
		13,
		719,
		{
			RTResTalkAction[7],
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		2329
	},
	[27018014] = {
		27018014,
		0,
		Lang.get(67530),
		27018,
		14,
		101,
		{
			RTResTalkAction[90],
			RTResTalkAction[84]
		}
	},
	[27018015] = {
		27018015,
		0,
		Lang.get(67531),
		27018,
		15,
		101,
		{
			RTResTalkAction[88],
			RTResTalkAction[84]
		}
	},
	[27019001] = {
		27019001,
		0,
		Lang.get(67532),
		27019,
		1,
		725,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		27115,
		[19] = 27115
	},
	[27019002] = {
		27019002,
		0,
		Lang.get(67533),
		27019,
		2,
		725
	},
	[27019003] = {
		27019003,
		0,
		Lang.get(67534),
		27019,
		3,
		725
	},
	[27019004] = {
		27019004,
		0,
		Lang.get(19557),
		27019,
		4,
		725
	},
	[27019005] = {
		27019005,
		0,
		Lang.get(34583),
		27019,
		5,
		725
	},
	[27019006] = {
		27019006,
		0,
		Lang.get(67535),
		27019,
		6,
		725
	},
	[27019007] = {
		27019007,
		0,
		Lang.get(67536),
		27019,
		7,
		725
	},
	[27019008] = {
		27019008,
		0,
		Lang.get(67537),
		27019,
		8,
		725
	},
	[27019009] = {
		27019009,
		0,
		Lang.get(67538),
		27019,
		9,
		725
	},
	[27019010] = {
		27019010,
		0,
		Lang.get(67539),
		27019,
		10,
		725
	},
	[27019011] = {
		27019011,
		0,
		Lang.get(67540),
		27019,
		11,
		725
	},
	[27019012] = {
		27019012,
		3,
		Lang.get(67541),
		27019,
		12,
		605,
		[22] = 1
	},
	[27019013] = {
		27019013,
		0,
		Lang.get(67542),
		27019,
		13,
		725
	},
	[27019014] = {
		27019014,
		0,
		Lang.get(67543),
		27019,
		14,
		726
	},
	[27019015] = {
		27019015,
		0,
		Lang.get(67544),
		27019,
		15,
		726
	},
	[27019016] = {
		27019016,
		0,
		Lang.get(67545),
		27019,
		16,
		725
	},
	[27019017] = {
		27019017,
		0,
		Lang.get(67546),
		27019,
		17,
		726
	},
	[27019018] = {
		27019018,
		0,
		Lang.get(67547),
		27019,
		18,
		726
	},
	[27019019] = {
		27019019,
		0,
		Lang.get(67548),
		27019,
		19,
		725
	},
	[27019020] = {
		27019020,
		3,
		Lang.get(67549),
		27019,
		20,
		605,
		[22] = 1,
		[20] = 200
	},
	[27019021] = {
		27019021,
		3,
		Lang.get(67550),
		27019,
		21,
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
