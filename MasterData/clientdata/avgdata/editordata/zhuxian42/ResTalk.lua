-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian42\\ResTalk.lua

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
	[1] = 2,
	[2] = 215,
	[3] = {
		1
	}
}
RTResTalkAction[2] = {
	3,
	1132,
	nil,
	nil,
	0
}
RTResTalkAction[3] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[4] = {
	[1] = 3,
	[2] = 1132
}
RTResTalkAction[5] = {
	3,
	1132,
	nil,
	nil,
	1
}
RTResTalkAction[6] = {
	2,
	215,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[7] = {
	3,
	1132,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[8] = {
	1,
	225,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 1132
}
RTResTalkAction[11] = {
	1,
	188,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[13] = {
	1,
	220,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 1132
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[17] = {
	1,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[18] = {
	1,
	225,
	nil,
	nil,
	0
}
RTResTalkAction[19] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	3,
	194,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[21] = {
	2,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[22] = {
	3,
	194,
	nil,
	nil,
	1
}
RTResTalkAction[23] = {
	3,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[24] = {
	2,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[25] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 194
}
RTResTalkAction[27] = {
	1,
	194,
	nil,
	nil,
	0
}
RTResTalkAction[28] = {
	2,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[30] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	1,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[32] = {
	1,
	767,
	nil,
	nil,
	0
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 767
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 767,
	[3] = {
		2
	}
}
RTResTalkAction[35] = {
	1,
	767,
	nil,
	nil,
	4
}
RTResTalkAction[36] = {
	1,
	767,
	nil,
	nil,
	3
}
RTResTalkAction[37] = {
	1,
	767,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[38] = {
	1,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[39] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[40] = {
	3,
	386,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[42] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[44] = {
	1,
	158,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[45] = {
	3,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[47] = {
	1,
	230,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[48] = {
	1,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 230
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 230
}
RTResTalkAction[51] = {
	1,
	230,
	nil,
	nil,
	0
}
RTResTalkAction[52] = {
	1,
	158,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[53] = {
	1,
	158,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[54] = {
	1,
	257,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[55] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[56] = {
	3,
	1071,
	nil,
	nil,
	0
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 1071
}
RTResTalkAction[58] = {
	3,
	1071,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[59] = {
	3,
	1071,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[60] = {
	1,
	767,
	nil,
	nil,
	1
}
RTResTalkAction[61] = {
	1,
	767,
	nil,
	nil,
	2
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 767
}
RTResTalkAction[63] = {
	3,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[64] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[65] = {
	1,
	386,
	nil,
	nil,
	0
}
RTResTalkAction[66] = {
	2,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 386
}
RTResTalkAction[68] = {
	2,
	158,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[69] = {
	[1] = 3,
	[2] = 386,
	[3] = {
		1
	}
}
RTResTalkAction[70] = {
	2,
	158,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[71] = {
	1,
	1263,
	nil,
	nil,
	0
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 1263,
	[3] = {
		2
	}
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 1263
}
RTResTalkAction[74] = {
	1,
	767,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[75] = {
	1,
	767,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[76] = {
	1,
	767,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[77] = {
	2,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[78] = {
	[1] = 3,
	[2] = 1263
}
RTResTalkAction[79] = {
	2,
	215,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[80] = {
	[1] = 0,
	[2] = 1263
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[82] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[83] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[84] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[85] = {
	3,
	386,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[86] = {
	1,
	1071,
	nil,
	nil,
	0
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 1071,
	[3] = {
		2
	}
}
RTResTalkAction[88] = {
	1,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[89] = {
	3,
	220,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 241
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 241
}
RTResTalkAction[92] = {
	1,
	241,
	nil,
	nil,
	0
}

local Data = {
	[38100001] = {
		38100001,
		9,
		Lang.get(101959),
		38100,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		57,
		38100,
		nil,
		nil,
		nil,
		nil,
		nil,
		38100,
		200,
		nil,
		1
	},
	[38100002] = {
		38100002,
		9,
		Lang.get(101960),
		38100,
		2,
		605,
		[22] = 1,
		[20] = 200
	},
	[38100003] = {
		38100003,
		0,
		Lang.get(101961),
		38100,
		3,
		215,
		{
			RTResTalkAction[1],
			RTResTalkAction[2]
		},
		[20] = -1
	},
	[38100004] = {
		38100004,
		0,
		Lang.get(101962),
		38100,
		4,
		1132,
		{
			RTResTalkAction[3],
			RTResTalkAction[4]
		}
	},
	[38100005] = {
		38100005,
		0,
		Lang.get(101963),
		38100,
		5,
		1132,
		{
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[38100006] = {
		38100006,
		5,
		Lang.get(18700),
		38100,
		6,
		215,
		{
			RTResTalkAction[6],
			RTResTalkAction[4]
		}
	},
	[38100007] = {
		38100007,
		0,
		Lang.get(101964),
		38100,
		7,
		1132,
		{
			RTResTalkAction[3],
			RTResTalkAction[7]
		}
	},
	[38100008] = {
		38100008,
		0,
		Lang.get(101965),
		38100,
		8,
		225,
		{
			RTResTalkAction[8],
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[38100009] = {
		38100009,
		0,
		Lang.get(101966),
		38100,
		9,
		188,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[38100010] = {
		38100010,
		5,
		Lang.get(101967),
		38100,
		10,
		220,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[38100011] = {
		38100011,
		0,
		Lang.get(101968),
		38100,
		11,
		1132,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[38100012] = {
		38100012,
		9,
		Lang.get(21922),
		38100,
		12,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		2745,
		194,
		[22] = 1,
		[20] = 255
	},
	[38100013] = {
		38100013,
		9,
		Lang.get(101969),
		38100,
		13,
		605,
		[22] = 1,
		[20] = 255
	},
	[38100014] = {
		38100014,
		9,
		"……",
		38100,
		14,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		38101,
		nil,
		nil,
		nil,
		nil,
		nil,
		38101,
		200,
		nil,
		1
	},
	[38100015] = {
		38100015,
		0,
		Lang.get(101970),
		38100,
		15,
		220,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		[20] = -1
	},
	[38100016] = {
		38100016,
		0,
		Lang.get(101971),
		38100,
		16,
		225,
		{
			RTResTalkAction[18],
			RTResTalkAction[16]
		}
	},
	[38100017] = {
		38100017,
		0,
		Lang.get(101972),
		38100,
		17,
		215,
		{
			RTResTalkAction[19],
			RTResTalkAction[12]
		}
	},
	[38100018] = {
		38100018,
		0,
		Lang.get(101973),
		38100,
		18,
		194,
		{
			RTResTalkAction[3],
			RTResTalkAction[20]
		}
	},
	[38100019] = {
		38100019,
		0,
		Lang.get(101974),
		38100,
		19,
		215,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[38100020] = {
		38100020,
		0,
		Lang.get(101975),
		38100,
		20,
		194,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		}
	},
	[38100021] = {
		38100021,
		0,
		Lang.get(101976),
		38100,
		21,
		194,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		}
	},
	[38100022] = {
		38100022,
		0,
		Lang.get(101977),
		38100,
		22,
		215,
		{
			RTResTalkAction[24],
			RTResTalkAction[23]
		}
	},
	[38100023] = {
		38100023,
		0,
		Lang.get(101978),
		38100,
		23,
		194,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		}
	},
	[38100024] = {
		38100024,
		0,
		Lang.get(101979),
		38100,
		24,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[9],
			RTResTalkAction[26]
		}
	},
	[38100025] = {
		38100025,
		0,
		Lang.get(101980),
		38100,
		25,
		215,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[38100026] = {
		38100026,
		0,
		Lang.get(101981),
		38100,
		26,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[38100027] = {
		38100027,
		0,
		Lang.get(101982),
		38100,
		27,
		194,
		{
			RTResTalkAction[27],
			RTResTalkAction[16]
		}
	},
	[38100028] = {
		38100028,
		0,
		Lang.get(101983),
		38100,
		28,
		215,
		{
			RTResTalkAction[28],
			RTResTalkAction[23]
		}
	},
	[38100029] = {
		38100029,
		0,
		Lang.get(101984),
		38100,
		29,
		194,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		}
	},
	[38100030] = {
		38100030,
		0,
		Lang.get(101985),
		38100,
		30,
		215,
		{
			RTResTalkAction[24],
			RTResTalkAction[23]
		}
	},
	[38100031] = {
		38100031,
		0,
		Lang.get(101986),
		38100,
		31,
		225,
		{
			RTResTalkAction[29],
			RTResTalkAction[9],
			RTResTalkAction[26]
		}
	},
	[38100032] = {
		38100032,
		0,
		Lang.get(101987),
		38100,
		32,
		225,
		{
			RTResTalkAction[29]
		}
	},
	[38100033] = {
		38100033,
		0,
		Lang.get(101988),
		38100,
		33,
		215,
		{
			RTResTalkAction[30],
			RTResTalkAction[12]
		}
	},
	[38100034] = {
		38100034,
		0,
		Lang.get(101989),
		38100,
		34,
		215,
		{
			RTResTalkAction[31]
		}
	},
	[38101001] = {
		38101001,
		0,
		Lang.get(18514),
		38101,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		38105,
		[19] = 38105
	},
	[38101002] = {
		38101002,
		0,
		Lang.get(101990),
		38101,
		2,
		300
	},
	[38101003] = {
		38101003,
		4,
		nil,
		38101,
		3,
		300,
		[29] = {
			{
				id = 38101004,
				branch_content = Lang.get(101991)
			},
			{
				id = 38101004,
				branch_content = Lang.get(101992)
			}
		}
	},
	[38101004] = {
		38101004,
		3,
		Lang.get(101993),
		38101,
		4,
		605,
		[22] = 1
	},
	[38101005] = {
		38101005,
		0,
		Lang.get(101994),
		38101,
		5,
		767,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		38106,
		1,
		nil,
		nil,
		1,
		nil,
		38106
	},
	[38101006] = {
		38101006,
		0,
		Lang.get(25449),
		38101,
		6,
		300
	},
	[38101007] = {
		38101007,
		4,
		nil,
		38101,
		7,
		300,
		[29] = {
			{
				id = 38101008,
				branch_content = Lang.get(101995)
			},
			{
				id = 38101008,
				branch_content = Lang.get(101996)
			}
		}
	},
	[38101008] = {
		38101008,
		4,
		nil,
		38101,
		8,
		300,
		[29] = {
			{
				id = 38101009,
				branch_content = Lang.get(25131)
			},
			{
				id = 38101009,
				branch_content = Lang.get(101997)
			}
		}
	},
	[38101009] = {
		38101009,
		0,
		Lang.get(101998),
		38101,
		9,
		767,
		nil,
		1,
		3
	},
	[38101010] = {
		38101010,
		0,
		Lang.get(101999),
		38101,
		10,
		300
	},
	[38101011] = {
		38101011,
		0,
		Lang.get(102000),
		38101,
		11,
		767,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[38101012] = {
		38101012,
		0,
		Lang.get(102001),
		38101,
		12,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38101013] = {
		38101013,
		3,
		Lang.get(102002),
		38101,
		13,
		605,
		{
			RTResTalkAction[34]
		},
		[22] = 1
	},
	[38101014] = {
		38101014,
		0,
		Lang.get(102003),
		38101,
		14,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38101015] = {
		38101015,
		0,
		Lang.get(102004),
		38101,
		15,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38101016] = {
		38101016,
		0,
		Lang.get(102005),
		38101,
		16,
		767,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		nil,
		57
	},
	[38101017] = {
		38101017,
		4,
		nil,
		38101,
		17,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38101018,
				branch_content = "……！"
			},
			{
				id = 38101018,
				branch_content = "……"
			}
		}
	},
	[38101018] = {
		38101018,
		0,
		Lang.get(102006),
		38101,
		18,
		767,
		{
			RTResTalkAction[35]
		}
	},
	[38101019] = {
		38101019,
		0,
		Lang.get(102007),
		38101,
		19,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38101020] = {
		38101020,
		0,
		Lang.get(25449),
		38101,
		20,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38101021] = {
		38101021,
		0,
		Lang.get(102008),
		38101,
		21,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38101022] = {
		38101022,
		0,
		Lang.get(102009),
		38101,
		22,
		767,
		{
			RTResTalkAction[36]
		}
	},
	[38101023] = {
		38101023,
		0,
		Lang.get(88117),
		38101,
		23,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38101024] = {
		38101024,
		0,
		Lang.get(102010),
		38101,
		24,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38101025] = {
		38101025,
		0,
		Lang.get(102011),
		38101,
		25,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38101026] = {
		38101026,
		3,
		Lang.get(102012),
		38101,
		26,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1
	},
	[38101027] = {
		38101027,
		3,
		Lang.get(102013),
		38101,
		27,
		605,
		{
			RTResTalkAction[37]
		},
		[22] = 1
	},
	[38102001] = {
		38102001,
		0,
		Lang.get(102014),
		38102,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		122,
		38110,
		nil,
		nil,
		nil,
		nil,
		nil,
		38110
	},
	[38102002] = {
		38102002,
		0,
		Lang.get(102015),
		38102,
		2,
		220,
		nil,
		1,
		2
	},
	[38102003] = {
		38102003,
		0,
		Lang.get(102016),
		38102,
		3,
		215,
		nil,
		1,
		2
	},
	[38102004] = {
		38102004,
		0,
		Lang.get(102017),
		38102,
		4,
		20,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		38111,
		1,
		1,
		nil,
		nil,
		nil,
		38111
	},
	[38102005] = {
		38102005,
		0,
		Lang.get(102018),
		38102,
		5,
		215,
		nil,
		1,
		1
	},
	[38102006] = {
		38102006,
		0,
		Lang.get(102019),
		38102,
		6,
		20,
		nil,
		1,
		0
	},
	[38102007] = {
		38102007,
		0,
		Lang.get(102020),
		38102,
		7,
		215,
		nil,
		1,
		1
	},
	[38102008] = {
		38102008,
		0,
		Lang.get(102021),
		38102,
		8,
		20,
		nil,
		1,
		0
	},
	[38102009] = {
		38102009,
		0,
		Lang.get(102022),
		38102,
		9,
		158,
		nil,
		1,
		0,
		nil,
		nil,
		59,
		38112,
		1,
		1,
		nil,
		1,
		nil,
		38112
	},
	[38102010] = {
		38102010,
		0,
		Lang.get(102023),
		38102,
		10,
		158,
		nil,
		1,
		0
	},
	[38102011] = {
		38102011,
		0,
		Lang.get(102024),
		38102,
		11,
		158,
		nil,
		1,
		3
	},
	[38102012] = {
		38102012,
		0,
		Lang.get(102025),
		38102,
		12,
		386,
		nil,
		1,
		0
	},
	[38102013] = {
		38102013,
		0,
		Lang.get(102026),
		38102,
		13,
		158,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[38102014] = {
		38102014,
		0,
		Lang.get(102027),
		38102,
		14,
		386,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[38102015] = {
		38102015,
		0,
		Lang.get(102028),
		38102,
		15,
		215,
		{
			RTResTalkAction[41],
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[38102016] = {
		38102016,
		0,
		Lang.get(102029),
		38102,
		16,
		158,
		{
			RTResTalkAction[44],
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		38113,
		1,
		1,
		nil,
		1,
		nil,
		38113
	},
	[38102017] = {
		38102017,
		0,
		Lang.get(102030),
		38102,
		17,
		215,
		{
			RTResTalkAction[24],
			RTResTalkAction[45]
		}
	},
	[38102018] = {
		38102018,
		0,
		Lang.get(102031),
		38102,
		18,
		158,
		{
			RTResTalkAction[46],
			RTResTalkAction[9]
		}
	},
	[38102019] = {
		38102019,
		0,
		Lang.get(102032),
		38102,
		19,
		230,
		{
			RTResTalkAction[47],
			RTResTalkAction[42]
		},
		nil,
		nil,
		nil,
		nil,
		204
	},
	[38102020] = {
		38102020,
		0,
		Lang.get(102033),
		38102,
		20,
		215,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		}
	},
	[38102021] = {
		38102021,
		0,
		Lang.get(102034),
		38102,
		21,
		230,
		{
			RTResTalkAction[50],
			RTResTalkAction[9]
		}
	},
	[38102022] = {
		38102022,
		0,
		Lang.get(102035),
		38102,
		22,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[49]
		}
	},
	[38102023] = {
		38102023,
		0,
		Lang.get(102036),
		38102,
		23,
		158,
		{
			RTResTalkAction[46]
		}
	},
	[38102024] = {
		38102024,
		0,
		Lang.get(102037),
		38102,
		24,
		230,
		{
			RTResTalkAction[51],
			RTResTalkAction[42]
		}
	},
	[38102025] = {
		38102025,
		0,
		Lang.get(102038),
		38102,
		25,
		230,
		{
			RTResTalkAction[50]
		}
	},
	[38102026] = {
		38102026,
		0,
		Lang.get(102039),
		38102,
		26,
		158,
		{
			RTResTalkAction[52],
			RTResTalkAction[49]
		}
	},
	[38102027] = {
		38102027,
		0,
		Lang.get(102040),
		38102,
		27,
		230,
		{
			RTResTalkAction[51],
			RTResTalkAction[42]
		}
	},
	[38102028] = {
		38102028,
		0,
		"——！",
		38102,
		28,
		158,
		{
			RTResTalkAction[53],
			RTResTalkAction[49]
		}
	},
	[38102029] = {
		38102029,
		0,
		Lang.get(102041),
		38102,
		29,
		230,
		{
			RTResTalkAction[47],
			RTResTalkAction[42]
		}
	},
	[38103001] = {
		38103001,
		3,
		Lang.get(102042),
		38103,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		113,
		38115,
		[19] = 38115,
		[22] = 1
	},
	[38103002] = {
		38103002,
		4,
		nil,
		38103,
		2,
		300,
		[29] = {
			{
				id = 38103003,
				branch_content = Lang.get(32377)
			}
		}
	},
	[38103003] = {
		38103003,
		4,
		nil,
		38103,
		3,
		300,
		[29] = {
			{
				id = 38103004,
				branch_content = Lang.get(102043)
			}
		}
	},
	[38103004] = {
		38103004,
		0,
		Lang.get(102044),
		38103,
		4,
		767,
		nil,
		1,
		4
	},
	[38103005] = {
		38103005,
		0,
		Lang.get(102045),
		38103,
		5,
		767,
		nil,
		1,
		4
	},
	[38103006] = {
		38103006,
		4,
		nil,
		38103,
		6,
		767,
		nil,
		1,
		4,
		[29] = {
			{
				id = 38103007,
				branch_content = Lang.get(102046)
			},
			{
				id = 38103007,
				branch_content = Lang.get(102047)
			}
		}
	},
	[38103007] = {
		38103007,
		4,
		nil,
		38103,
		7,
		300,
		[29] = {
			{
				id = 38103008,
				branch_content = Lang.get(102048)
			},
			{
				id = 38103008,
				branch_content = Lang.get(102049)
			}
		}
	},
	[38103008] = {
		38103008,
		0,
		Lang.get(102050),
		38103,
		8,
		767,
		nil,
		1,
		2
	},
	[38103009] = {
		38103009,
		0,
		Lang.get(102051),
		38103,
		9,
		767,
		nil,
		1,
		4
	},
	[38103010] = {
		38103010,
		3,
		Lang.get(102052),
		38103,
		10,
		605,
		[22] = 1
	},
	[38103011] = {
		38103011,
		0,
		Lang.get(102053),
		38103,
		11,
		767,
		nil,
		1,
		1
	},
	[38103012] = {
		38103012,
		4,
		nil,
		38103,
		12,
		767,
		nil,
		1,
		1,
		[29] = {
			{
				id = 38103013,
				branch_content = "！！！"
			}
		}
	},
	[38103013] = {
		38103013,
		0,
		Lang.get(102054),
		38103,
		13,
		767,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		38116,
		nil,
		nil,
		nil,
		2,
		nil,
		38116
	},
	[38103014] = {
		38103014,
		0,
		Lang.get(102055),
		38103,
		14,
		767,
		nil,
		1,
		4
	},
	[38103015] = {
		38103015,
		0,
		Lang.get(102056),
		38103,
		15,
		300
	},
	[38103016] = {
		38103016,
		0,
		Lang.get(102057),
		38103,
		16,
		767,
		nil,
		1,
		2
	},
	[38103017] = {
		38103017,
		0,
		Lang.get(102058),
		38103,
		17,
		767,
		nil,
		1,
		4
	},
	[38103018] = {
		38103018,
		0,
		Lang.get(102059),
		38103,
		18,
		300
	},
	[38103019] = {
		38103019,
		0,
		Lang.get(19557),
		38103,
		19,
		767,
		nil,
		1,
		2
	},
	[38103020] = {
		38103020,
		0,
		Lang.get(102060),
		38103,
		20,
		300
	},
	[38103021] = {
		38103021,
		0,
		Lang.get(102061),
		38103,
		21,
		767,
		nil,
		1,
		0
	},
	[38103022] = {
		38103022,
		0,
		Lang.get(102062),
		38103,
		22,
		767,
		nil,
		1
	},
	[38103023] = {
		38103023,
		4,
		nil,
		38103,
		23,
		300,
		[29] = {
			{
				id = 38103024,
				branch_content = Lang.get(102063)
			},
			{
				id = 38103024,
				branch_content = Lang.get(19613)
			}
		}
	},
	[38103024] = {
		38103024,
		0,
		Lang.get(102064),
		38103,
		24,
		767,
		nil,
		1,
		4
	},
	[38103025] = {
		38103025,
		0,
		Lang.get(102065),
		38103,
		25,
		767,
		nil,
		1,
		4
	},
	[38103026] = {
		38103026,
		4,
		nil,
		38103,
		26,
		767,
		nil,
		1,
		4,
		[29] = {
			{
				id = 38103027,
				branch_content = Lang.get(102066)
			},
			{
				id = 38103027,
				branch_content = Lang.get(102067)
			}
		}
	},
	[38103027] = {
		38103027,
		0,
		Lang.get(102068),
		38103,
		27,
		767,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		38117,
		1,
		1,
		nil,
		2,
		nil,
		38117
	},
	[38103028] = {
		38103028,
		0,
		Lang.get(102069),
		38103,
		28,
		767,
		nil,
		1
	},
	[38103029] = {
		38103029,
		0,
		Lang.get(102070),
		38103,
		29,
		767,
		nil,
		1,
		1
	},
	[38103030] = {
		38103030,
		3,
		Lang.get(102071),
		38103,
		30,
		605,
		[22] = 1
	},
	[38103031] = {
		38103031,
		4,
		nil,
		38103,
		31,
		300,
		[29] = {
			{
				id = 38103032,
				branch_content = "……"
			}
		}
	},
	[38103032] = {
		38103032,
		0,
		Lang.get(102072),
		38103,
		32,
		767,
		nil,
		1,
		2
	},
	[38103033] = {
		38103033,
		0,
		Lang.get(102073),
		38103,
		33,
		767,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		38118,
		nil,
		nil,
		nil,
		nil,
		nil,
		38118
	},
	[38103034] = {
		38103034,
		0,
		Lang.get(21152),
		38103,
		34,
		767,
		nil,
		1,
		4
	},
	[38104001] = {
		38104001,
		9,
		Lang.get(102074),
		38104,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		164,
		38120,
		[19] = 38120,
		[22] = 1
	},
	[38104002] = {
		38104002,
		0,
		Lang.get(102075),
		38104,
		2,
		1071,
		nil,
		1,
		0
	},
	[38104003] = {
		38104003,
		0,
		Lang.get(102076),
		38104,
		3,
		1071,
		nil,
		1,
		0
	},
	[38104004] = {
		38104004,
		0,
		Lang.get(102077),
		38104,
		4,
		257,
		nil,
		1,
		0
	},
	[38104005] = {
		38104005,
		0,
		Lang.get(102078),
		38104,
		5,
		1071,
		nil,
		1,
		0
	},
	[38104006] = {
		38104006,
		0,
		Lang.get(102079),
		38104,
		6,
		257,
		nil,
		1,
		0
	},
	[38104007] = {
		38104007,
		0,
		Lang.get(102080),
		38104,
		7,
		257,
		nil,
		1,
		0
	},
	[38104008] = {
		38104008,
		0,
		Lang.get(102081),
		38104,
		8,
		1071,
		nil,
		1,
		0
	},
	[38104009] = {
		38104009,
		0,
		Lang.get(102082),
		38104,
		9,
		257,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[38104010] = {
		38104010,
		0,
		Lang.get(102083),
		38104,
		10,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[38104011] = {
		38104011,
		0,
		Lang.get(102084),
		38104,
		11,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104012] = {
		38104012,
		0,
		Lang.get(102085),
		38104,
		12,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104013] = {
		38104013,
		0,
		Lang.get(102086),
		38104,
		13,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104014] = {
		38104014,
		0,
		Lang.get(102087),
		38104,
		14,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104015] = {
		38104015,
		0,
		Lang.get(102088),
		38104,
		15,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104016] = {
		38104016,
		0,
		Lang.get(102089),
		38104,
		16,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104017] = {
		38104017,
		0,
		Lang.get(102090),
		38104,
		17,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104018] = {
		38104018,
		0,
		"……",
		38104,
		18,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104019] = {
		38104019,
		0,
		Lang.get(102091),
		38104,
		19,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104020] = {
		38104020,
		0,
		Lang.get(102092),
		38104,
		20,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104021] = {
		38104021,
		0,
		Lang.get(102093),
		38104,
		21,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[58]
		},
		nil,
		nil,
		nil,
		nil,
		59
	},
	[38104022] = {
		38104022,
		0,
		Lang.get(102094),
		38104,
		22,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104023] = {
		38104023,
		0,
		Lang.get(102095),
		38104,
		23,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104024] = {
		38104024,
		0,
		"……",
		38104,
		24,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104025] = {
		38104025,
		0,
		Lang.get(102096),
		38104,
		25,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[56]
		}
	},
	[38104026] = {
		38104026,
		0,
		Lang.get(102097),
		38104,
		26,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104027] = {
		38104027,
		0,
		Lang.get(102098),
		38104,
		27,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[38104028] = {
		38104028,
		0,
		Lang.get(102099),
		38104,
		28,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104029] = {
		38104029,
		0,
		Lang.get(102100),
		38104,
		29,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104030] = {
		38104030,
		0,
		Lang.get(102101),
		38104,
		30,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104031] = {
		38104031,
		0,
		Lang.get(102102),
		38104,
		31,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104032] = {
		38104032,
		0,
		Lang.get(21821),
		38104,
		32,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104033] = {
		38104033,
		0,
		Lang.get(102103),
		38104,
		33,
		257,
		{
			RTResTalkAction[55],
			RTResTalkAction[57]
		}
	},
	[38104034] = {
		38104034,
		0,
		Lang.get(102104),
		38104,
		34,
		1071,
		{
			RTResTalkAction[55],
			RTResTalkAction[59]
		}
	},
	[38105001] = {
		38105001,
		9,
		"……",
		38105,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		2751,
		113,
		38125,
		nil,
		nil,
		nil,
		nil,
		nil,
		38125,
		255,
		nil,
		1
	},
	[38105002] = {
		38105002,
		0,
		Lang.get(102105),
		38105,
		2,
		767,
		nil,
		1,
		0
	},
	[38105003] = {
		38105003,
		9,
		Lang.get(102106),
		38105,
		3,
		605,
		[22] = 1
	},
	[38105004] = {
		38105004,
		4,
		nil,
		38105,
		4,
		300,
		[29] = {
			{
				id = 38105005,
				branch_content = Lang.get(102107)
			},
			{
				id = 38105005,
				branch_content = Lang.get(102108)
			}
		}
	},
	[38105005] = {
		38105005,
		9,
		Lang.get(102109),
		38105,
		5,
		605,
		[22] = 1
	},
	[38105006] = {
		38105006,
		0,
		Lang.get(102110),
		38105,
		6,
		767,
		nil,
		1,
		2
	},
	[38105007] = {
		38105007,
		0,
		Lang.get(102111),
		38105,
		7,
		767,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		38126,
		1,
		nil,
		nil,
		nil,
		nil,
		38126,
		-1
	},
	[38105008] = {
		38105008,
		4,
		nil,
		38105,
		8,
		767,
		nil,
		1,
		4,
		[29] = {
			{
				id = 38105009,
				branch_content = Lang.get(102112)
			},
			{
				id = 38105009,
				branch_content = Lang.get(102113)
			}
		}
	},
	[38105009] = {
		38105009,
		0,
		Lang.get(102114),
		38105,
		9,
		767,
		nil,
		1,
		3
	},
	[38105010] = {
		38105010,
		0,
		Lang.get(102589),
		38105,
		10,
		300
	},
	[38105011] = {
		38105011,
		0,
		Lang.get(102116),
		38105,
		11,
		767,
		nil,
		1,
		3
	},
	[38105012] = {
		38105012,
		4,
		nil,
		38105,
		12,
		767,
		nil,
		1,
		3,
		[29] = {
			{
				id = 38105013,
				branch_content = Lang.get(102117)
			},
			{
				id = 38105013,
				branch_content = Lang.get(102118)
			}
		}
	},
	[38105013] = {
		38105013,
		0,
		Lang.get(102119),
		38105,
		13,
		767,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[38105014] = {
		38105014,
		0,
		Lang.get(102120),
		38105,
		14,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38105015] = {
		38105015,
		4,
		nil,
		38105,
		15,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38105016,
				branch_content = "……"
			}
		}
	},
	[38105016] = {
		38105016,
		0,
		Lang.get(102121),
		38105,
		16,
		767,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		nil,
		nil,
		154
	},
	[38105017] = {
		38105017,
		0,
		Lang.get(102122),
		38105,
		17,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38105018] = {
		38105018,
		0,
		Lang.get(102123),
		38105,
		18,
		767,
		{
			RTResTalkAction[34]
		}
	},
	[38105019] = {
		38105019,
		0,
		Lang.get(102124),
		38105,
		19,
		767,
		{
			RTResTalkAction[35]
		}
	},
	[38105020] = {
		38105020,
		0,
		Lang.get(102125),
		38105,
		20,
		767,
		{
			RTResTalkAction[60]
		}
	},
	[38105021] = {
		38105021,
		3,
		Lang.get(102126),
		38105,
		21,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1
	},
	[38105022] = {
		38105022,
		4,
		nil,
		38105,
		22,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38105023,
				branch_content = Lang.get(102127)
			},
			{
				id = 38105023,
				branch_content = Lang.get(102128)
			}
		}
	},
	[38105023] = {
		38105023,
		0,
		Lang.get(102129),
		38105,
		23,
		767,
		{
			RTResTalkAction[61]
		}
	},
	[38105024] = {
		38105024,
		0,
		Lang.get(102130),
		38105,
		24,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38105025] = {
		38105025,
		0,
		Lang.get(102131),
		38105,
		25,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38105026] = {
		38105026,
		0,
		Lang.get(102132),
		38105,
		26,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38105027] = {
		38105027,
		0,
		Lang.get(102133),
		38105,
		27,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38105028] = {
		38105028,
		0,
		Lang.get(102134),
		38105,
		28,
		767,
		{
			RTResTalkAction[60]
		}
	},
	[38105029] = {
		38105029,
		4,
		nil,
		38105,
		29,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38105030,
				branch_content = Lang.get(102135)
			},
			{
				id = 38105030,
				branch_content = Lang.get(102136)
			}
		}
	},
	[38105030] = {
		38105030,
		0,
		Lang.get(102137),
		38105,
		30,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38105031] = {
		38105031,
		0,
		Lang.get(102138),
		38105,
		31,
		767,
		{
			RTResTalkAction[62]
		},
		1,
		4,
		[20] = 255
	},
	[38105032] = {
		38105032,
		9,
		Lang.get(102139),
		38105,
		32,
		605,
		[22] = 1
	},
	[38106001] = {
		38106001,
		0,
		Lang.get(102140),
		38106,
		1,
		158,
		nil,
		1,
		3,
		nil,
		nil,
		122,
		38130,
		nil,
		nil,
		nil,
		nil,
		nil,
		38130
	},
	[38106002] = {
		38106002,
		0,
		Lang.get(102141),
		38106,
		2,
		215,
		nil,
		1,
		0
	},
	[38106003] = {
		38106003,
		0,
		Lang.get(102142),
		38106,
		3,
		220,
		nil,
		1,
		1
	},
	[38106004] = {
		38106004,
		0,
		Lang.get(102143),
		38106,
		4,
		215,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[38106005] = {
		38106005,
		0,
		Lang.get(102144),
		38106,
		5,
		220,
		{
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[38106006] = {
		38106006,
		0,
		Lang.get(102145),
		38106,
		6,
		215,
		{
			RTResTalkAction[3],
			RTResTalkAction[64]
		}
	},
	[38106007] = {
		38106007,
		0,
		Lang.get(102146),
		38106,
		7,
		220,
		{
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[38106008] = {
		38106008,
		0,
		Lang.get(102147),
		38106,
		8,
		215,
		{
			RTResTalkAction[3],
			RTResTalkAction[64]
		}
	},
	[38106009] = {
		38106009,
		0,
		Lang.get(102148),
		38106,
		9,
		386,
		{
			RTResTalkAction[65],
			RTResTalkAction[9],
			RTResTalkAction[16]
		}
	},
	[38106010] = {
		38106010,
		0,
		Lang.get(102149),
		38106,
		10,
		158,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[38106011] = {
		38106011,
		0,
		Lang.get(102150),
		38106,
		11,
		158,
		{
			RTResTalkAction[68],
			RTResTalkAction[67]
		}
	},
	[38106012] = {
		38106012,
		0,
		Lang.get(102151),
		38106,
		12,
		386,
		{
			RTResTalkAction[39],
			RTResTalkAction[69]
		}
	},
	[38106013] = {
		38106013,
		5,
		Lang.get(102152),
		38106,
		13,
		158,
		{
			RTResTalkAction[70],
			RTResTalkAction[40]
		}
	},
	[38106014] = {
		38106014,
		0,
		Lang.get(102153),
		38106,
		14,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[38106015] = {
		38106015,
		0,
		Lang.get(102154),
		38106,
		15,
		215,
		{
			RTResTalkAction[30],
			RTResTalkAction[16]
		}
	},
	[38106016] = {
		38106016,
		0,
		Lang.get(102155),
		38106,
		16,
		215,
		{
			RTResTalkAction[31]
		}
	},
	[38106017] = {
		38106017,
		3,
		Lang.get(23446),
		38106,
		17,
		605,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		1237,
		[22] = 1
	},
	[38106018] = {
		38106018,
		0,
		Lang.get(102156),
		38106,
		18,
		158,
		{
			RTResTalkAction[38]
		}
	},
	[38106019] = {
		38106019,
		0,
		Lang.get(102157),
		38106,
		19,
		386,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[38106020] = {
		38106020,
		3,
		Lang.get(102158),
		38106,
		20,
		605,
		{
			RTResTalkAction[42],
			RTResTalkAction[43]
		},
		nil,
		nil,
		3,
		nil,
		164,
		38131,
		1,
		1,
		nil,
		1,
		nil,
		38131,
		nil,
		nil,
		1
	},
	[38106021] = {
		38106021,
		0,
		Lang.get(102159),
		38106,
		21,
		1263,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		nil,
		2751
	},
	[38106022] = {
		38106022,
		0,
		Lang.get(102160),
		38106,
		22,
		1263,
		{
			RTResTalkAction[72]
		}
	},
	[38106023] = {
		38106023,
		0,
		Lang.get(102590),
		38106,
		23,
		1263,
		{
			RTResTalkAction[73]
		}
	},
	[38107001] = {
		38107001,
		9,
		"……",
		38107,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		38135,
		nil,
		nil,
		nil,
		nil,
		nil,
		38135,
		255,
		nil,
		1
	},
	[38107002] = {
		38107002,
		4,
		nil,
		38107,
		2,
		300,
		[29] = {
			{
				id = 38107003,
				branch_content = Lang.get(102162)
			}
		}
	},
	[38107003] = {
		38107003,
		4,
		nil,
		38107,
		3,
		300,
		[29] = {
			{
				id = 38107004,
				branch_content = Lang.get(102163)
			}
		}
	},
	[38107004] = {
		38107004,
		4,
		nil,
		38107,
		4,
		300,
		[29] = {
			{
				id = 38107005,
				branch_content = Lang.get(102163)
			}
		}
	},
	[38107005] = {
		38107005,
		9,
		"……",
		38107,
		5,
		605,
		[22] = 1
	},
	[38107006] = {
		38107006,
		9,
		Lang.get(102164),
		38107,
		6,
		605,
		[22] = 1
	},
	[38107007] = {
		38107007,
		4,
		nil,
		38107,
		7,
		300,
		[29] = {
			{
				id = 38107008,
				branch_content = Lang.get(102165)
			}
		}
	},
	[38107008] = {
		38107008,
		4,
		nil,
		38107,
		8,
		300,
		[20] = -1,
		[29] = {
			{
				id = 38107009,
				branch_content = "……"
			}
		}
	},
	[38107009] = {
		38107009,
		4,
		nil,
		38107,
		9,
		300,
		[29] = {
			{
				id = 38107010,
				branch_content = Lang.get(102166)
			}
		}
	},
	[38107010] = {
		38107010,
		3,
		Lang.get(102167),
		38107,
		10,
		605,
		[22] = 1
	},
	[38107011] = {
		38107011,
		0,
		Lang.get(102168),
		38107,
		11,
		767,
		nil,
		1,
		0
	},
	[38107012] = {
		38107012,
		0,
		Lang.get(103601),
		38107,
		12,
		300
	},
	[38107013] = {
		38107013,
		4,
		nil,
		38107,
		13,
		300,
		[29] = {
			{
				id = 38107014,
				branch_content = Lang.get(60967)
			}
		}
	},
	[38107014] = {
		38107014,
		3,
		Lang.get(102170),
		38107,
		14,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		38136,
		1,
		nil,
		nil,
		1,
		nil,
		38136,
		nil,
		nil,
		1
	},
	[38107015] = {
		38107015,
		0,
		Lang.get(102171),
		38107,
		15,
		300
	},
	[38107016] = {
		38107016,
		0,
		Lang.get(102172),
		38107,
		16,
		767,
		nil,
		1,
		4
	},
	[38107017] = {
		38107017,
		0,
		Lang.get(102173),
		38107,
		17,
		300
	},
	[38107018] = {
		38107018,
		0,
		Lang.get(102174),
		38107,
		18,
		767,
		{
			RTResTalkAction[74]
		},
		nil,
		nil,
		3,
		nil,
		57
	},
	[38107019] = {
		38107019,
		0,
		Lang.get(102175),
		38107,
		19,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38107020] = {
		38107020,
		0,
		Lang.get(102176),
		38107,
		20,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38107021] = {
		38107021,
		0,
		Lang.get(102177),
		38107,
		21,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38107022] = {
		38107022,
		0,
		Lang.get(102178),
		38107,
		22,
		767,
		{
			RTResTalkAction[75]
		}
	},
	[38107023] = {
		38107023,
		0,
		Lang.get(102179),
		38107,
		23,
		767,
		{
			RTResTalkAction[33]
		}
	},
	[38107024] = {
		38107024,
		0,
		Lang.get(20681),
		38107,
		24,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[38107025] = {
		38107025,
		4,
		nil,
		38107,
		25,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38107026,
				branch_content = Lang.get(102180)
			},
			{
				id = 38107026,
				branch_content = Lang.get(102180)
			},
			{
				id = 38107026,
				branch_content = Lang.get(102180)
			}
		}
	},
	[38107026] = {
		38107026,
		0,
		Lang.get(102181),
		38107,
		26,
		767,
		{
			RTResTalkAction[76]
		}
	},
	[38107027] = {
		38107027,
		0,
		Lang.get(102182),
		38107,
		27,
		767,
		{
			RTResTalkAction[60]
		}
	},
	[38107028] = {
		38107028,
		4,
		nil,
		38107,
		28,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38107029,
				branch_content = Lang.get(59677)
			}
		}
	},
	[38107029] = {
		38107029,
		3,
		Lang.get(102183),
		38107,
		29,
		605,
		{
			RTResTalkAction[33]
		},
		[22] = 1
	},
	[38107030] = {
		38107030,
		0,
		Lang.get(102184),
		38107,
		30,
		767,
		{
			RTResTalkAction[35]
		}
	},
	[38107031] = {
		38107031,
		0,
		Lang.get(102185),
		38107,
		31,
		767,
		{
			RTResTalkAction[60]
		}
	},
	[38108001] = {
		38108001,
		0,
		Lang.get(102186),
		38108,
		1,
		1263,
		{
			RTResTalkAction[71]
		},
		nil,
		nil,
		3,
		nil,
		122,
		38140,
		nil,
		nil,
		nil,
		nil,
		nil,
		38140
	},
	[38108002] = {
		38108002,
		0,
		Lang.get(102187),
		38108,
		2,
		215,
		{
			RTResTalkAction[77],
			RTResTalkAction[78]
		}
	},
	[38108003] = {
		38108003,
		0,
		Lang.get(102188),
		38108,
		3,
		1263,
		{
			RTResTalkAction[3],
			RTResTalkAction[78]
		}
	},
	[38108004] = {
		38108004,
		0,
		Lang.get(102189),
		38108,
		4,
		215,
		{
			RTResTalkAction[79],
			RTResTalkAction[78]
		}
	},
	[38108005] = {
		38108005,
		0,
		Lang.get(102190),
		38108,
		5,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[9],
			RTResTalkAction[80]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		38141,
		1,
		1,
		nil,
		1,
		nil,
		38141
	},
	[38108006] = {
		38108006,
		0,
		Lang.get(102191),
		38108,
		6,
		1071,
		{
			RTResTalkAction[81],
			RTResTalkAction[42]
		}
	},
	[38108007] = {
		38108007,
		0,
		Lang.get(102192),
		38108,
		7,
		386,
		{
			RTResTalkAction[82],
			RTResTalkAction[83]
		}
	},
	[38108008] = {
		38108008,
		0,
		Lang.get(102193),
		38108,
		8,
		215,
		{
			RTResTalkAction[84],
			RTResTalkAction[43]
		}
	},
	[38108009] = {
		38108009,
		0,
		Lang.get(102194),
		38108,
		9,
		1071,
		{
			RTResTalkAction[3],
			RTResTalkAction[56]
		}
	},
	[38108010] = {
		38108010,
		0,
		Lang.get(102195),
		38108,
		10,
		1071,
		{
			RTResTalkAction[3],
			RTResTalkAction[56]
		}
	},
	[38108011] = {
		38108011,
		0,
		Lang.get(102196),
		38108,
		11,
		215,
		{
			RTResTalkAction[24],
			RTResTalkAction[56]
		}
	},
	[38108012] = {
		38108012,
		0,
		Lang.get(102197),
		38108,
		12,
		1071,
		{
			RTResTalkAction[3],
			RTResTalkAction[56]
		}
	},
	[38108013] = {
		38108013,
		0,
		Lang.get(102198),
		38108,
		13,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[9],
			RTResTalkAction[83]
		}
	},
	[38108014] = {
		38108014,
		0,
		Lang.get(102199),
		38108,
		14,
		158,
		{
			RTResTalkAction[53],
			RTResTalkAction[16]
		}
	},
	[38108015] = {
		38108015,
		0,
		Lang.get(102200),
		38108,
		15,
		386,
		{
			RTResTalkAction[39],
			RTResTalkAction[85]
		}
	},
	[38108016] = {
		38108016,
		0,
		Lang.get(102201),
		38108,
		16,
		1071,
		{
			RTResTalkAction[86],
			RTResTalkAction[42],
			RTResTalkAction[43]
		}
	},
	[38108017] = {
		38108017,
		0,
		Lang.get(102202),
		38108,
		17,
		215,
		{
			RTResTalkAction[28],
			RTResTalkAction[57]
		}
	},
	[38108018] = {
		38108018,
		3,
		Lang.get(102203),
		38108,
		18,
		605,
		{
			RTResTalkAction[87],
			RTResTalkAction[9]
		},
		[22] = 1
	},
	[38108019] = {
		38108019,
		0,
		Lang.get(102204),
		38108,
		19,
		1071,
		{
			RTResTalkAction[81]
		}
	},
	[38108020] = {
		38108020,
		0,
		Lang.get(102205),
		38108,
		20,
		1071,
		{
			RTResTalkAction[81]
		}
	},
	[38108021] = {
		38108021,
		0,
		Lang.get(102206),
		38108,
		21,
		1071,
		{
			RTResTalkAction[81]
		}
	},
	[38108022] = {
		38108022,
		0,
		Lang.get(102207),
		38108,
		22,
		215,
		{
			RTResTalkAction[48],
			RTResTalkAction[83]
		}
	},
	[38108023] = {
		38108023,
		0,
		Lang.get(102208),
		38108,
		23,
		1071,
		{
			RTResTalkAction[87],
			RTResTalkAction[9]
		}
	},
	[38109001] = {
		38109001,
		0,
		Lang.get(83925),
		38109,
		1,
		1071,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		3,
		nil,
		190,
		38145,
		nil,
		nil,
		nil,
		nil,
		nil,
		38145
	},
	[38109002] = {
		38109002,
		0,
		Lang.get(102209),
		38109,
		2,
		386,
		{
			RTResTalkAction[65],
			RTResTalkAction[83]
		}
	},
	[38109003] = {
		38109003,
		0,
		Lang.get(102210),
		38109,
		3,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[43]
		}
	},
	[38109004] = {
		38109004,
		0,
		Lang.get(102211),
		38109,
		4,
		158,
		{
			RTResTalkAction[38]
		}
	},
	[38109005] = {
		38109005,
		0,
		Lang.get(102212),
		38109,
		5,
		220,
		{
			RTResTalkAction[88],
			RTResTalkAction[42]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		38146,
		1,
		1,
		nil,
		1,
		nil,
		38146
	},
	[38109006] = {
		38109006,
		0,
		Lang.get(102213),
		38109,
		6,
		220,
		{
			RTResTalkAction[3],
			RTResTalkAction[64]
		}
	},
	[38109007] = {
		38109007,
		0,
		"……",
		38109,
		7,
		215,
		{
			RTResTalkAction[3],
			RTResTalkAction[64]
		}
	},
	[38109008] = {
		38109008,
		0,
		Lang.get(102214),
		38109,
		8,
		220,
		{
			RTResTalkAction[3],
			RTResTalkAction[63]
		}
	},
	[38109009] = {
		38109009,
		0,
		Lang.get(102215),
		38109,
		9,
		215,
		{
			RTResTalkAction[21],
			RTResTalkAction[64]
		}
	},
	[38109010] = {
		38109010,
		0,
		Lang.get(102216),
		38109,
		10,
		215,
		{
			RTResTalkAction[77],
			RTResTalkAction[64]
		}
	},
	[38109011] = {
		38109011,
		0,
		Lang.get(102217),
		38109,
		11,
		220,
		{
			RTResTalkAction[3],
			RTResTalkAction[89]
		}
	},
	[38109012] = {
		38109012,
		0,
		Lang.get(102218),
		38109,
		12,
		215,
		{
			RTResTalkAction[3],
			RTResTalkAction[64]
		}
	},
	[38109013] = {
		38109013,
		0,
		Lang.get(102219),
		38109,
		13,
		215,
		{
			RTResTalkAction[28],
			RTResTalkAction[64]
		}
	},
	[38109014] = {
		38109014,
		0,
		Lang.get(102220),
		38109,
		14,
		215,
		{
			RTResTalkAction[31],
			RTResTalkAction[16]
		}
	},
	[38109015] = {
		38109015,
		3,
		Lang.get(102221),
		38109,
		15,
		605,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		2756,
		186,
		38147,
		1,
		1,
		nil,
		1,
		nil,
		38147,
		nil,
		nil,
		1
	},
	[38109016] = {
		38109016,
		3,
		Lang.get(102222),
		38109,
		16,
		605,
		{
			RTResTalkAction[90]
		},
		[22] = 1
	},
	[38109017] = {
		38109017,
		0,
		Lang.get(102223),
		38109,
		17,
		838,
		{
			RTResTalkAction[91]
		},
		1,
		0
	},
	[38109018] = {
		38109018,
		0,
		Lang.get(102224),
		38109,
		18,
		839,
		nil,
		1,
		0
	},
	[38109019] = {
		38109019,
		3,
		Lang.get(102225),
		38109,
		19,
		605,
		[22] = 1
	},
	[38109020] = {
		38109020,
		0,
		Lang.get(102226),
		38109,
		20,
		241,
		{
			RTResTalkAction[92]
		}
	},
	[38109021] = {
		38109021,
		0,
		Lang.get(102227),
		38109,
		21,
		241,
		{
			RTResTalkAction[92]
		}
	},
	[38110001] = {
		38110001,
		9,
		"……",
		38110,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		38150,
		nil,
		nil,
		nil,
		nil,
		nil,
		38150,
		255,
		nil,
		1
	},
	[38110002] = {
		38110002,
		9,
		Lang.get(102228),
		38110,
		2,
		605,
		[22] = 1
	},
	[38110003] = {
		38110003,
		9,
		Lang.get(102229),
		38110,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		[22] = 1
	},
	[38110004] = {
		38110004,
		9,
		Lang.get(102230),
		38110,
		4,
		605,
		nil,
		nil,
		nil,
		nil,
		2767,
		[22] = 1
	},
	[38110005] = {
		38110005,
		0,
		Lang.get(102231),
		38110,
		5,
		1072,
		nil,
		1,
		0
	},
	[38110006] = {
		38110006,
		0,
		Lang.get(98435),
		38110,
		6,
		300
	},
	[38110007] = {
		38110007,
		4,
		nil,
		38110,
		7,
		300,
		[29] = {
			{
				id = 38110008,
				branch_content = Lang.get(89266)
			}
		}
	},
	[38110008] = {
		38110008,
		0,
		Lang.get(102232),
		38110,
		8,
		1071,
		nil,
		1,
		0,
		nil,
		2767
	},
	[38110009] = {
		38110009,
		0,
		Lang.get(93262),
		38110,
		9,
		300
	},
	[38110010] = {
		38110010,
		0,
		Lang.get(102233),
		38110,
		10,
		1071,
		nil,
		1,
		0
	},
	[38110011] = {
		38110011,
		0,
		Lang.get(102234),
		38110,
		11,
		1071,
		nil,
		1,
		0
	},
	[38110012] = {
		38110012,
		4,
		nil,
		38110,
		12,
		300,
		[29] = {
			{
				id = 38110013,
				branch_content = "……！"
			},
			{
				id = 38110013,
				branch_content = Lang.get(102235)
			}
		}
	},
	[38110013] = {
		38110013,
		0,
		Lang.get(102236),
		38110,
		13,
		1071,
		nil,
		1,
		0
	},
	[38110014] = {
		38110014,
		4,
		nil,
		38110,
		14,
		300,
		[29] = {
			{
				id = 38110015,
				branch_content = Lang.get(102237)
			},
			{
				id = 38110015,
				branch_content = Lang.get(102238)
			}
		}
	},
	[38110015] = {
		38110015,
		0,
		Lang.get(102239),
		38110,
		15,
		1071,
		nil,
		1,
		0
	},
	[38110016] = {
		38110016,
		0,
		Lang.get(102240),
		38110,
		16,
		1071,
		nil,
		1,
		0
	},
	[38110017] = {
		38110017,
		9,
		"……",
		38110,
		17,
		605,
		[22] = 1
	},
	[38110018] = {
		38110018,
		3,
		Lang.get(102241),
		38110,
		18,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		38151,
		nil,
		nil,
		nil,
		nil,
		nil,
		38151,
		-1,
		nil,
		1
	},
	[38110019] = {
		38110019,
		4,
		nil,
		38110,
		19,
		300,
		[29] = {
			{
				id = 38110020,
				branch_content = Lang.get(102242)
			}
		}
	},
	[38110020] = {
		38110020,
		0,
		Lang.get(102243),
		38110,
		20,
		767,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[38110021] = {
		38110021,
		0,
		Lang.get(102244),
		38110,
		21,
		767,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[38110022] = {
		38110022,
		4,
		nil,
		38110,
		22,
		300,
		{
			RTResTalkAction[33]
		},
		[29] = {
			{
				id = 38110023,
				branch_content = Lang.get(102245)
			},
			{
				id = 38110023,
				branch_content = Lang.get(102246)
			}
		}
	},
	[38110023] = {
		38110023,
		0,
		Lang.get(102247),
		38110,
		23,
		767,
		{
			RTResTalkAction[32]
		}
	},
	[38110024] = {
		38110024,
		0,
		Lang.get(102248),
		38110,
		24,
		767,
		{
			RTResTalkAction[75]
		}
	},
	[38110025] = {
		38110025,
		0,
		Lang.get(102249),
		38110,
		25,
		1071,
		{
			RTResTalkAction[86],
			RTResTalkAction[62]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		38152,
		1,
		1,
		nil,
		1,
		nil,
		38152
	},
	[38110026] = {
		38110026,
		0,
		Lang.get(102250),
		38110,
		26,
		215,
		{
			RTResTalkAction[30],
			RTResTalkAction[83]
		}
	},
	[38110027] = {
		38110027,
		0,
		Lang.get(102251),
		38110,
		27,
		215,
		{
			RTResTalkAction[31]
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
