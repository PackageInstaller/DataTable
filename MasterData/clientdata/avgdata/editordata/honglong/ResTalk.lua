-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\honglong\\ResTalk.lua

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
	[2] = 158,
	[3] = {
		100215
	}
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		1
	}
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 159
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		100515
	}
}
RTResTalkAction[8] = {
	1,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[10] = {
	1,
	158,
	{
		100515
	},
	nil,
	0
}
RTResTalkAction[11] = {
	1,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[12] = {
	1,
	158,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[13] = {
	1,
	159,
	nil,
	nil,
	1
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 20
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 27
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 27
}
RTResTalkAction[18] = {
	1,
	158,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 160
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 162
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 160
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 162
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 163,
	[3] = {
		1007
	}
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 163
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		1002
	}
}
RTResTalkAction[26] = {
	1,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[27] = {
	1,
	158,
	{
		100215
	},
	nil,
	0
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		2
	}
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		1004
	}
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		3
	}
}
RTResTalkAction[31] = {
	1,
	158,
	{
		100515
	},
	nil,
	4
}
RTResTalkAction[32] = {
	1,
	158,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 160,
	[3] = {
		1005
	}
}
RTResTalkAction[34] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 160
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 160,
	[3] = {
		2
	}
}
RTResTalkAction[38] = {
	2,
	158,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[39] = {
	[1] = 2,
	[2] = 158,
	[3] = {
		100215
	}
}
RTResTalkAction[40] = {
	2,
	158,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[41] = {
	2,
	158,
	nil,
	nil,
	4
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 160,
	[3] = {
		1003
	}
}
RTResTalkAction[43] = {
	1,
	163,
	{
		1007
	},
	nil,
	2
}
RTResTalkAction[44] = {
	1,
	163,
	{
		1007
	},
	nil,
	5
}
RTResTalkAction[45] = {
	1,
	159,
	nil,
	nil,
	2
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 606
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 606
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 607
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 607
}
RTResTalkAction[50] = {
	1,
	159,
	nil,
	nil,
	5
}
RTResTalkAction[51] = {
	1,
	163,
	{
		1007
	},
	nil,
	6
}
RTResTalkAction[52] = {
	1,
	163,
	{
		1007
	},
	nil,
	4
}
RTResTalkAction[53] = {
	1,
	159,
	nil,
	nil,
	3
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 573
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 573
}
RTResTalkAction[56] = {
	1,
	158,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 611
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 611
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 163
}
RTResTalkAction[60] = {
	1,
	159,
	nil,
	nil,
	4
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 52
}
RTResTalkAction[62] = {
	1,
	159,
	nil,
	nil,
	6
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 52
}
RTResTalkAction[64] = {
	1,
	158,
	nil,
	nil,
	5
}
RTResTalkAction[65] = {
	1,
	158,
	nil,
	nil,
	6
}
RTResTalkAction[66] = {
	1,
	158,
	nil,
	nil,
	2
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 575
}
RTResTalkAction[68] = {
	[1] = 0,
	[2] = 575
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 612
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 613
}
RTResTalkAction[71] = {
	[1] = 0,
	[2] = 612
}
RTResTalkAction[72] = {
	[1] = 0,
	[2] = 613
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 48
}
RTResTalkAction[74] = {
	[1] = 0,
	[2] = 48
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 576
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 576
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 578
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 578
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 616
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 615
}
RTResTalkAction[81] = {
	[1] = 0,
	[2] = 616
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 615
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 579
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 582
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 579
}
RTResTalkAction[86] = {
	[1] = 0,
	[2] = 582
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 16
}
RTResTalkAction[88] = {
	[1] = 0,
	[2] = 16
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 617
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 618
}
RTResTalkAction[91] = {
	[1] = 0,
	[2] = 617
}
RTResTalkAction[92] = {
	[1] = 0,
	[2] = 618
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 583
}
RTResTalkAction[94] = {
	[1] = 0,
	[2] = 583
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 621
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 620
}
RTResTalkAction[97] = {
	[1] = 0,
	[2] = 621
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 620
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 8
}
RTResTalkAction[100] = {
	[1] = 0,
	[2] = 8
}
RTResTalkAction[101] = {
	1,
	158,
	nil,
	nil,
	3
}
RTResTalkAction[102] = {
	[1] = 1,
	[2] = 619
}
RTResTalkAction[103] = {
	[1] = 0,
	[2] = 619
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 29
}
RTResTalkAction[105] = {
	[1] = 0,
	[2] = 29
}
RTResTalkAction[106] = {
	[1] = 1,
	[2] = 15
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 53
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 15
}
RTResTalkAction[109] = {
	1,
	158,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[110] = {
	[1] = 0,
	[2] = 53
}
RTResTalkAction[111] = {
	1,
	159,
	nil,
	nil,
	0
}
RTResTalkAction[112] = {
	[1] = 1,
	[2] = 10
}
RTResTalkAction[113] = {
	[1] = 0,
	[2] = 10
}
RTResTalkAction[114] = {
	[1] = 1,
	[2] = 41
}
RTResTalkAction[115] = {
	[1] = 0,
	[2] = 41
}
RTResTalkAction[116] = {
	[1] = 1,
	[2] = 55
}
RTResTalkAction[117] = {
	[1] = 0,
	[2] = 55
}
RTResTalkAction[118] = {
	1,
	158,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[119] = {
	[1] = 1,
	[2] = 30
}
RTResTalkAction[120] = {
	[1] = 0,
	[2] = 30
}
RTResTalkAction[121] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[122] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[123] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[124] = {
	[1] = 0,
	[2] = 133
}

local Data = {
	[4360001] = {
		4360001,
		3,
		Lang.get(23466),
		4360,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		111,
		4360,
		nil,
		nil,
		nil,
		1,
		nil,
		4360,
		nil,
		nil,
		1
	},
	[4360002] = {
		4360002,
		3,
		Lang.get(23467),
		4360,
		2,
		605,
		[22] = 1
	},
	[4360003] = {
		4360003,
		0,
		Lang.get(23468),
		4360,
		3,
		158,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		4
	},
	[4360004] = {
		4360004,
		7,
		"29",
		4360,
		4,
		158,
		{
			RTResTalkAction[2]
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
	[4360005] = {
		4360005,
		0,
		Lang.get(23469),
		4360,
		5,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.7
	},
	[4360006] = {
		4360006,
		0,
		Lang.get(23470),
		4360,
		6,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4360007] = {
		4360007,
		3,
		Lang.get(23471),
		4360,
		7,
		605,
		{
			RTResTalkAction[2]
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
		[17] = 1
	},
	[4360008] = {
		4360008,
		0,
		Lang.get(23472),
		4360,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4360009] = {
		4360009,
		0,
		Lang.get(23473),
		4360,
		9,
		158,
		{
			RTResTalkAction[4]
		}
	},
	[4360010] = {
		4360010,
		0,
		Lang.get(23474),
		4360,
		10,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4360011] = {
		4360011,
		0,
		Lang.get(23475),
		4360,
		11,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4360012] = {
		4360012,
		7,
		"30",
		4360,
		12,
		159,
		{
			RTResTalkAction[6]
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
	[4360013] = {
		4360013,
		0,
		Lang.get(23476),
		4360,
		13,
		158,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.7
	},
	[4360014] = {
		4360014,
		0,
		Lang.get(23477),
		4360,
		14,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4360015] = {
		4360015,
		0,
		Lang.get(23478),
		4360,
		15,
		158,
		{
			RTResTalkAction[9]
		}
	},
	[4360016] = {
		4360016,
		0,
		Lang.get(23479),
		4360,
		16,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4360017] = {
		4360017,
		0,
		Lang.get(23480),
		4360,
		17,
		158,
		{
			RTResTalkAction[10]
		}
	},
	[4360018] = {
		4360018,
		0,
		Lang.get(23481),
		4360,
		18,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4360019] = {
		4360019,
		0,
		Lang.get(23482),
		4360,
		19,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4360020] = {
		4360020,
		0,
		Lang.get(23483),
		4360,
		20,
		158,
		{
			RTResTalkAction[12]
		}
	},
	[4360021] = {
		4360021,
		0,
		Lang.get(23484),
		4360,
		21,
		159,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		}
	},
	[4360022] = {
		4360022,
		0,
		Lang.get(23485),
		4360,
		22,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4360023] = {
		4360023,
		0,
		Lang.get(23486),
		4360,
		23,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[2]
		}
	},
	[4360024] = {
		4360024,
		0,
		Lang.get(23487),
		4360,
		24,
		27,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[4360025] = {
		4360025,
		0,
		Lang.get(23488),
		4360,
		25,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[17]
		}
	},
	[4360026] = {
		4360026,
		0,
		Lang.get(23489),
		4360,
		26,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[16]
		}
	},
	[4360027] = {
		4360027,
		0,
		"……",
		4360,
		27,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4360028] = {
		4360028,
		0,
		Lang.get(23490),
		4360,
		28,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4360029] = {
		4360029,
		0,
		Lang.get(23491),
		4360,
		29,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4360030] = {
		4360030,
		0,
		Lang.get(23492),
		4360,
		30,
		158,
		{
			RTResTalkAction[18],
			RTResTalkAction[6]
		}
	},
	[4360031] = {
		4360031,
		0,
		Lang.get(23493),
		4360,
		31,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4360032] = {
		4360032,
		0,
		Lang.get(23494),
		4360,
		32,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4360033] = {
		4360033,
		3,
		Lang.get(21734),
		4360,
		33,
		605,
		{
			RTResTalkAction[2]
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
	[4360034] = {
		4360034,
		0,
		Lang.get(55743),
		4360,
		34,
		20,
		{
			RTResTalkAction[14]
		}
	},
	[4360035] = {
		4360035,
		0,
		Lang.get(23495),
		4360,
		35,
		27,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[4160001] = {
		4160001,
		9,
		Lang.get(22419),
		4160,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		9,
		nil,
		1,
		[19] = 4405,
		[22] = 1
	},
	[4160002] = {
		4160002,
		9,
		Lang.get(22420),
		4160,
		2,
		605,
		[22] = 1
	},
	[4160003] = {
		4160003,
		9,
		Lang.get(22421),
		4160,
		3,
		605,
		[19] = 4166,
		[22] = 1,
		[17] = 1
	},
	[4160004] = {
		4160004,
		9,
		Lang.get(22422),
		4160,
		4,
		605,
		[22] = 1
	},
	[4160005] = {
		4160005,
		9,
		Lang.get(22423),
		4160,
		5,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		4397,
		1.5,
		nil,
		nil,
		1,
		nil,
		4397,
		nil,
		nil,
		1
	},
	[4160006] = {
		4160006,
		3,
		Lang.get(22424),
		4160,
		6,
		162,
		nil,
		1,
		nil,
		nil,
		nil,
		14,
		4160,
		2.5,
		nil,
		nil,
		0,
		nil,
		4160,
		nil,
		nil,
		1
	},
	[4160007] = {
		4160007,
		7,
		"28",
		4160,
		7,
		162
	},
	[4160008] = {
		4160008,
		0,
		Lang.get(22425),
		4160,
		8,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		0.5
	},
	[4160009] = {
		4160009,
		2,
		Lang.get(22426),
		4160,
		9,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4160010] = {
		4160010,
		0,
		Lang.get(22427),
		4160,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4160011] = {
		4160011,
		2,
		Lang.get(22428),
		4160,
		11,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4160012] = {
		4160012,
		0,
		Lang.get(22429),
		4160,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4160013] = {
		4160013,
		2,
		Lang.get(22430),
		4160,
		13,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4160014] = {
		4160014,
		0,
		Lang.get(22431),
		4160,
		14,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4160015] = {
		4160015,
		2,
		Lang.get(22432),
		4160,
		15,
		162,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		4167,
		1,
		1,
		nil,
		0,
		nil,
		4167
	},
	[4160016] = {
		4160016,
		0,
		Lang.get(22433),
		4160,
		16,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4
	},
	[4160017] = {
		4160017,
		2,
		Lang.get(22434),
		4160,
		17,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4160018] = {
		4160018,
		0,
		Lang.get(22435),
		4160,
		18,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4161001] = {
		4161001,
		0,
		Lang.get(22436),
		4161,
		1,
		160,
		nil,
		nil,
		nil,
		nil,
		nil,
		67,
		4169,
		1,
		nil,
		nil,
		1,
		nil,
		4169
	},
	[4161002] = {
		4161002,
		0,
		Lang.get(22437),
		4161,
		2,
		160
	},
	[4161003] = {
		4161003,
		2,
		Lang.get(22438),
		4161,
		3,
		162
	},
	[4161004] = {
		4161004,
		0,
		Lang.get(22439),
		4161,
		4,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4401,
		1,
		nil,
		nil,
		1,
		nil,
		4401
	},
	[4161005] = {
		4161005,
		2,
		Lang.get(22440),
		4161,
		5,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4161006] = {
		4161006,
		0,
		Lang.get(22441),
		4161,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4161007] = {
		4161007,
		0,
		Lang.get(22442),
		4161,
		7,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4161,
		1.5,
		1,
		nil,
		nil,
		nil,
		4161
	},
	[4161008] = {
		4161008,
		0,
		Lang.get(22443),
		4161,
		8,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161009] = {
		4161009,
		0,
		Lang.get(22444),
		4161,
		9,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161010] = {
		4161010,
		0,
		Lang.get(22445),
		4161,
		10,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161011] = {
		4161011,
		2,
		Lang.get(22446),
		4161,
		11,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4161012] = {
		4161012,
		0,
		Lang.get(22447),
		4161,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4161013] = {
		4161013,
		2,
		Lang.get(22448),
		4161,
		13,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4161014] = {
		4161014,
		0,
		Lang.get(22449),
		4161,
		14,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4161015] = {
		4161015,
		0,
		Lang.get(22450),
		4161,
		15,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161016] = {
		4161016,
		0,
		Lang.get(22451),
		4161,
		16,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4391,
		1.5,
		1
	},
	[4161017] = {
		4161017,
		0,
		Lang.get(22452),
		4161,
		17,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161018] = {
		4161018,
		0,
		Lang.get(22453),
		4161,
		18,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4161019] = {
		4161019,
		0,
		Lang.get(22454),
		4161,
		19,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4162001] = {
		4162001,
		0,
		Lang.get(22455),
		4162,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4412,
		1,
		nil,
		nil,
		0,
		nil,
		4412
	},
	[4162002] = {
		4162002,
		0,
		Lang.get(22456),
		4162,
		2,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4162003] = {
		4162003,
		0,
		Lang.get(22457),
		4162,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4162004] = {
		4162004,
		0,
		Lang.get(22458),
		4162,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4162005] = {
		4162005,
		0,
		Lang.get(22459),
		4162,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4162006] = {
		4162006,
		0,
		Lang.get(55744),
		4162,
		6,
		622,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		4398,
		1.5,
		1
	},
	[4162007] = {
		4162007,
		0,
		Lang.get(22461),
		4162,
		7,
		163,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		4
	},
	[4162008] = {
		4162008,
		0,
		Lang.get(22462),
		4162,
		8,
		163,
		{
			RTResTalkAction[23]
		}
	},
	[4162009] = {
		4162009,
		0,
		Lang.get(22463),
		4162,
		9,
		160,
		{
			RTResTalkAction[24]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		4413,
		2,
		1,
		nil,
		1,
		nil,
		4413
	},
	[4162010] = {
		4162010,
		0,
		Lang.get(22464),
		4162,
		10,
		158,
		nil,
		1
	},
	[4162011] = {
		4162011,
		0,
		Lang.get(22465),
		4162,
		11,
		160,
		nil,
		1
	},
	[4162012] = {
		4162012,
		0,
		Lang.get(22466),
		4162,
		12,
		158,
		nil,
		1
	},
	[4162013] = {
		4162013,
		0,
		Lang.get(22467),
		4162,
		13,
		158,
		nil,
		1
	},
	[4162014] = {
		4162014,
		0,
		Lang.get(22468),
		4162,
		14,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4
	},
	[4162015] = {
		4162015,
		2,
		Lang.get(22469),
		4162,
		15,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4162016] = {
		4162016,
		2,
		Lang.get(22470),
		4162,
		16,
		162,
		{
			RTResTalkAction[20]
		}
	},
	[4162017] = {
		4162017,
		0,
		Lang.get(22471),
		4162,
		17,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4162018] = {
		4162018,
		2,
		"……",
		4162,
		18,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4163001] = {
		4163001,
		0,
		Lang.get(22472),
		4163,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4168,
		1,
		1,
		nil,
		1,
		nil,
		4168
	},
	[4163002] = {
		4163002,
		2,
		Lang.get(22473),
		4163,
		2,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4163003] = {
		4163003,
		0,
		Lang.get(22474),
		4163,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4163004] = {
		4163004,
		2,
		Lang.get(22475),
		4163,
		4,
		162,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[4163005] = {
		4163005,
		0,
		Lang.get(22476),
		4163,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[4163006] = {
		4163006,
		0,
		Lang.get(55745),
		4163,
		6,
		160,
		{
			RTResTalkAction[25]
		}
	},
	[4164001] = {
		4164001,
		2,
		Lang.get(22478),
		4164,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4399,
		1,
		nil,
		nil,
		0,
		nil,
		4399
	},
	[4164002] = {
		4164002,
		0,
		Lang.get(22479),
		4164,
		2,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4164003] = {
		4164003,
		0,
		Lang.get(22480),
		4164,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164004] = {
		4164004,
		0,
		Lang.get(22481),
		4164,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164005] = {
		4164005,
		0,
		Lang.get(22482),
		4164,
		5,
		158,
		{
			RTResTalkAction[26],
			RTResTalkAction[21]
		}
	},
	[4164006] = {
		4164006,
		0,
		Lang.get(22483),
		4164,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164007] = {
		4164007,
		0,
		Lang.get(22484),
		4164,
		7,
		158,
		{
			RTResTalkAction[27],
			RTResTalkAction[21]
		}
	},
	[4164008] = {
		4164008,
		0,
		Lang.get(22485),
		4164,
		8,
		160,
		{
			RTResTalkAction[28],
			RTResTalkAction[2]
		}
	},
	[4164009] = {
		4164009,
		0,
		Lang.get(22486),
		4164,
		9,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164010] = {
		4164010,
		0,
		Lang.get(22487),
		4164,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164011] = {
		4164011,
		0,
		Lang.get(22488),
		4164,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164012] = {
		4164012,
		0,
		Lang.get(22489),
		4164,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164013] = {
		4164013,
		0,
		Lang.get(22490),
		4164,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164014] = {
		4164014,
		0,
		Lang.get(22491),
		4164,
		14,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164015] = {
		4164015,
		0,
		Lang.get(22492),
		4164,
		15,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4164016] = {
		4164016,
		0,
		Lang.get(22493),
		4164,
		16,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4164017] = {
		4164017,
		0,
		Lang.get(22494),
		4164,
		17,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164018] = {
		4164018,
		0,
		Lang.get(22495),
		4164,
		18,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164019] = {
		4164019,
		5,
		Lang.get(22496),
		4164,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4164020] = {
		4164020,
		0,
		Lang.get(22497),
		4164,
		20,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4164021] = {
		4164021,
		0,
		Lang.get(22498),
		4164,
		21,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4164022] = {
		4164022,
		0,
		Lang.get(22499),
		4164,
		22,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4164023] = {
		4164023,
		5,
		Lang.get(22500),
		4164,
		23,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4165001] = {
		4165001,
		0,
		Lang.get(22501),
		4165,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		111,
		4165,
		1.5,
		nil,
		nil,
		1,
		nil,
		4165
	},
	[4165002] = {
		4165002,
		0,
		Lang.get(22502),
		4165,
		2,
		160,
		{
			RTResTalkAction[29]
		}
	},
	[4165003] = {
		4165003,
		0,
		Lang.get(22503),
		4165,
		3,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4165004] = {
		4165004,
		0,
		Lang.get(22504),
		4165,
		4,
		158,
		{
			RTResTalkAction[9],
			RTResTalkAction[21]
		}
	},
	[4165005] = {
		4165005,
		0,
		Lang.get(22505),
		4165,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4165006] = {
		4165006,
		5,
		Lang.get(22506),
		4165,
		6,
		160,
		{
			RTResTalkAction[30]
		}
	},
	[4165007] = {
		4165007,
		0,
		"……",
		4165,
		7,
		158,
		{
			RTResTalkAction[1],
			RTResTalkAction[21]
		}
	},
	[4170001] = {
		4170001,
		0,
		Lang.get(22507),
		4170,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		4,
		nil,
		111,
		4177,
		1.5,
		nil,
		nil,
		1,
		nil,
		4170
	},
	[4170002] = {
		4170002,
		0,
		Lang.get(22508),
		4170,
		2,
		158,
		{
			RTResTalkAction[1],
			RTResTalkAction[21]
		}
	},
	[4170003] = {
		4170003,
		0,
		Lang.get(22509),
		4170,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4170004] = {
		4170004,
		0,
		Lang.get(22510),
		4170,
		4,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4170005] = {
		4170005,
		0,
		Lang.get(22511),
		4170,
		5,
		160,
		{
			RTResTalkAction[28],
			RTResTalkAction[2]
		}
	},
	[4170006] = {
		4170006,
		0,
		Lang.get(22512),
		4170,
		6,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4170007] = {
		4170007,
		0,
		Lang.get(22513),
		4170,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4170008] = {
		4170008,
		0,
		Lang.get(22514),
		4170,
		8,
		158,
		{
			RTResTalkAction[31],
			RTResTalkAction[21]
		}
	},
	[4170009] = {
		4170009,
		0,
		Lang.get(22515),
		4170,
		9,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4170010] = {
		4170010,
		0,
		Lang.get(22516),
		4170,
		10,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4170011] = {
		4170011,
		0,
		Lang.get(22517),
		4170,
		11,
		158,
		{
			RTResTalkAction[32],
			RTResTalkAction[21]
		}
	},
	[4170012] = {
		4170012,
		0,
		Lang.get(22518),
		4170,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4170013] = {
		4170013,
		0,
		Lang.get(22519),
		4170,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4170014] = {
		4170014,
		0,
		Lang.get(22520),
		4170,
		14,
		160,
		{
			RTResTalkAction[28],
			RTResTalkAction[2]
		}
	},
	[4171001] = {
		4171001,
		2,
		Lang.get(22521),
		4171,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		67,
		4171,
		1,
		nil,
		nil,
		1,
		nil,
		4171
	},
	[4171002] = {
		4171002,
		2,
		Lang.get(55746),
		4171,
		2,
		158,
		nil,
		1
	},
	[4171003] = {
		4171003,
		0,
		Lang.get(55747),
		4171,
		3,
		158,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4176,
		1,
		nil,
		nil,
		1,
		nil,
		4176
	},
	[4171004] = {
		4171004,
		0,
		Lang.get(22523),
		4171,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4171005] = {
		4171005,
		0,
		Lang.get(22524),
		4171,
		5,
		158,
		{
			RTResTalkAction[1],
			RTResTalkAction[21]
		}
	},
	[4171006] = {
		4171006,
		0,
		Lang.get(22525),
		4171,
		6,
		160,
		{
			RTResTalkAction[33],
			RTResTalkAction[2]
		}
	},
	[4171007] = {
		4171007,
		0,
		Lang.get(22526),
		4171,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4171008] = {
		4171008,
		0,
		Lang.get(22527),
		4171,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4171009] = {
		4171009,
		0,
		Lang.get(22528),
		4171,
		9,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4171010] = {
		4171010,
		0,
		Lang.get(22529),
		4171,
		10,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171011] = {
		4171011,
		0,
		Lang.get(22530),
		4171,
		11,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171012] = {
		4171012,
		0,
		"……",
		4171,
		12,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171013] = {
		4171013,
		0,
		Lang.get(22531),
		4171,
		13,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171014] = {
		4171014,
		0,
		Lang.get(22532),
		4171,
		14,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171015] = {
		4171015,
		0,
		Lang.get(22533),
		4171,
		15,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171016] = {
		4171016,
		0,
		"……",
		4171,
		16,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171017] = {
		4171017,
		0,
		Lang.get(22534),
		4171,
		17,
		158,
		{
			RTResTalkAction[36],
			RTResTalkAction[35]
		}
	},
	[4171018] = {
		4171018,
		0,
		Lang.get(22535),
		4171,
		18,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171019] = {
		4171019,
		0,
		Lang.get(22536),
		4171,
		19,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171020] = {
		4171020,
		0,
		Lang.get(22537),
		4171,
		20,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171021] = {
		4171021,
		0,
		Lang.get(22538),
		4171,
		21,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171022] = {
		4171022,
		0,
		Lang.get(22539),
		4171,
		22,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[37]
		}
	},
	[4171023] = {
		4171023,
		0,
		Lang.get(22540),
		4171,
		23,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171024] = {
		4171024,
		0,
		Lang.get(22541),
		4171,
		24,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171025] = {
		4171025,
		0,
		Lang.get(22542),
		4171,
		25,
		158,
		{
			RTResTalkAction[38],
			RTResTalkAction[35]
		}
	},
	[4171026] = {
		4171026,
		0,
		Lang.get(22543),
		4171,
		26,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171027] = {
		4171027,
		0,
		Lang.get(22544),
		4171,
		27,
		158,
		{
			RTResTalkAction[39],
			RTResTalkAction[35]
		}
	},
	[4171028] = {
		4171028,
		0,
		Lang.get(22545),
		4171,
		28,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171029] = {
		4171029,
		0,
		Lang.get(22546),
		4171,
		29,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[37]
		}
	},
	[4171030] = {
		4171030,
		0,
		Lang.get(22547),
		4171,
		30,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171031] = {
		4171031,
		0,
		Lang.get(22548),
		4171,
		31,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171032] = {
		4171032,
		0,
		Lang.get(22549),
		4171,
		32,
		158,
		{
			RTResTalkAction[40],
			RTResTalkAction[35]
		}
	},
	[4171033] = {
		4171033,
		0,
		Lang.get(22550),
		4171,
		33,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171034] = {
		4171034,
		0,
		Lang.get(22551),
		4171,
		34,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171035] = {
		4171035,
		0,
		Lang.get(22552),
		4171,
		35,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171036] = {
		4171036,
		0,
		Lang.get(22553),
		4171,
		36,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171037] = {
		4171037,
		0,
		Lang.get(22554),
		4171,
		37,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171038] = {
		4171038,
		0,
		Lang.get(22555),
		4171,
		38,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[4171039] = {
		4171039,
		0,
		"……",
		4171,
		39,
		158,
		{
			RTResTalkAction[41],
			RTResTalkAction[35]
		}
	},
	[4171040] = {
		4171040,
		0,
		Lang.get(22556),
		4171,
		40,
		160,
		{
			RTResTalkAction[34],
			RTResTalkAction[42]
		}
	},
	[4172001] = {
		4172001,
		0,
		Lang.get(22557),
		4172,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		67,
		4172,
		2,
		nil,
		nil,
		nil,
		nil,
		4172
	},
	[4172002] = {
		4172002,
		3,
		Lang.get(22558),
		4172,
		2,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172003] = {
		4172003,
		0,
		Lang.get(22559),
		4172,
		3,
		606,
		nil,
		1,
		[18] = 1079
	},
	[4172004] = {
		4172004,
		0,
		Lang.get(22560),
		4172,
		4,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4384
	},
	[4172005] = {
		4172005,
		0,
		Lang.get(22561),
		4172,
		5,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4384
	},
	[4172006] = {
		4172006,
		0,
		Lang.get(22562),
		4172,
		6,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4384
	},
	[4172007] = {
		4172007,
		0,
		Lang.get(22563),
		4172,
		7,
		606,
		nil,
		1,
		[18] = 1079
	},
	[4172008] = {
		4172008,
		0,
		Lang.get(22564),
		4172,
		8,
		158,
		nil,
		1
	},
	[4172009] = {
		4172009,
		0,
		Lang.get(22565),
		4172,
		9,
		606,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4387,
		[18] = 1079
	},
	[4172010] = {
		4172010,
		0,
		Lang.get(22566),
		4172,
		10,
		158,
		nil,
		1
	},
	[4172011] = {
		4172011,
		0,
		Lang.get(22567),
		4172,
		11,
		606,
		nil,
		1,
		[18] = 1079
	},
	[4172012] = {
		4172012,
		0,
		Lang.get(55748),
		4172,
		12,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4390
	},
	[4172013] = {
		4172013,
		0,
		Lang.get(22569),
		4172,
		13,
		606,
		nil,
		1,
		[18] = 1079
	},
	[4172014] = {
		4172014,
		3,
		Lang.get(22570),
		4172,
		14,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172015] = {
		4172015,
		0,
		"？？？？",
		4172,
		15,
		158,
		nil,
		1
	},
	[4172016] = {
		4172016,
		0,
		Lang.get(22571),
		4172,
		16,
		607,
		nil,
		1,
		[18] = 1079
	},
	[4172017] = {
		4172017,
		0,
		Lang.get(22572),
		4172,
		17,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4388
	},
	[4172018] = {
		4172018,
		3,
		Lang.get(22570),
		4172,
		18,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172019] = {
		4172019,
		0,
		Lang.get(22573),
		4172,
		19,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4389
	},
	[4172020] = {
		4172020,
		0,
		Lang.get(22574),
		4172,
		20,
		608,
		nil,
		1,
		[18] = 1079
	},
	[4172021] = {
		4172021,
		0,
		Lang.get(22575),
		4172,
		21,
		158,
		nil,
		1
	},
	[4172022] = {
		4172022,
		0,
		Lang.get(22576),
		4172,
		22,
		608,
		nil,
		1,
		[18] = 1079
	},
	[4172023] = {
		4172023,
		3,
		Lang.get(22577),
		4172,
		23,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172024] = {
		4172024,
		3,
		Lang.get(22578),
		4172,
		24,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172025] = {
		4172025,
		0,
		"……",
		4172,
		25,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4388
	},
	[4172026] = {
		4172026,
		0,
		Lang.get(22579),
		4172,
		26,
		609,
		nil,
		1,
		[18] = 1079
	},
	[4172027] = {
		4172027,
		0,
		Lang.get(22580),
		4172,
		27,
		158,
		nil,
		1
	},
	[4172028] = {
		4172028,
		0,
		Lang.get(22581),
		4172,
		28,
		609,
		nil,
		1,
		[18] = 1079
	},
	[4172029] = {
		4172029,
		0,
		Lang.get(22582),
		4172,
		29,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4389
	},
	[4172030] = {
		4172030,
		0,
		Lang.get(22583),
		4172,
		30,
		609,
		nil,
		1,
		[18] = 1079
	},
	[4172031] = {
		4172031,
		0,
		Lang.get(22584),
		4172,
		31,
		158,
		nil,
		1
	},
	[4172032] = {
		4172032,
		0,
		Lang.get(22585),
		4172,
		32,
		609,
		nil,
		1,
		[18] = 1079
	},
	[4172033] = {
		4172033,
		0,
		Lang.get(22586),
		4172,
		33,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4387
	},
	[4172034] = {
		4172034,
		3,
		Lang.get(22587),
		4172,
		34,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4172035] = {
		4172035,
		0,
		"……",
		4172,
		35,
		158,
		nil,
		1
	},
	[4172036] = {
		4172036,
		0,
		Lang.get(22588),
		4172,
		36,
		610,
		nil,
		1,
		[18] = 1079
	},
	[4172037] = {
		4172037,
		0,
		Lang.get(22589),
		4172,
		37,
		158,
		nil,
		1
	},
	[4172038] = {
		4172038,
		0,
		Lang.get(22590),
		4172,
		38,
		610,
		nil,
		1,
		[18] = 1079
	},
	[4172039] = {
		4172039,
		0,
		Lang.get(22591),
		4172,
		39,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4386
	},
	[4172040] = {
		4172040,
		0,
		Lang.get(22592),
		4172,
		40,
		610,
		nil,
		1,
		[18] = 1079
	},
	[4172041] = {
		4172041,
		0,
		Lang.get(22593),
		4172,
		41,
		158,
		nil,
		1
	},
	[4172042] = {
		4172042,
		0,
		Lang.get(22594),
		4172,
		42,
		610,
		nil,
		1,
		[18] = 1079
	},
	[4172043] = {
		4172043,
		0,
		Lang.get(22595),
		4172,
		43,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4390
	},
	[4172044] = {
		4172044,
		3,
		Lang.get(22587),
		4172,
		44,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4173001] = {
		4173001,
		0,
		Lang.get(22596),
		4173,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		60,
		4173,
		1,
		nil,
		nil,
		0,
		nil,
		4173
	},
	[4173002] = {
		4173002,
		0,
		Lang.get(22597),
		4173,
		2,
		158,
		{
			RTResTalkAction[12],
			RTResTalkAction[21]
		}
	},
	[4173003] = {
		4173003,
		0,
		"？？？",
		4173,
		3,
		160,
		{
			RTResTalkAction[25],
			RTResTalkAction[2]
		}
	},
	[4173004] = {
		4173004,
		3,
		Lang.get(22598),
		4173,
		4,
		605,
		{
			RTResTalkAction[21]
		},
		[18] = 1079,
		[22] = 1
	},
	[4173005] = {
		4173005,
		5,
		Lang.get(22599),
		4173,
		5,
		160,
		{
			RTResTalkAction[30]
		}
	},
	[4180001] = {
		4180001,
		0,
		Lang.get(22600),
		4180,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4180,
		1,
		nil,
		nil,
		nil,
		nil,
		4180
	},
	[4180002] = {
		4180002,
		0,
		Lang.get(22601),
		4180,
		2,
		163,
		{
			RTResTalkAction[43],
			RTResTalkAction[21]
		}
	},
	[4180003] = {
		4180003,
		0,
		Lang.get(22602),
		4180,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4180004] = {
		4180004,
		0,
		Lang.get(22603),
		4180,
		4,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[21]
		}
	},
	[4180005] = {
		4180005,
		0,
		Lang.get(22604),
		4180,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4180006] = {
		4180006,
		0,
		Lang.get(22605),
		4180,
		6,
		159,
		{
			RTResTalkAction[45],
			RTResTalkAction[21]
		}
	},
	[4180007] = {
		4180007,
		0,
		Lang.get(22606),
		4180,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4180008] = {
		4180008,
		0,
		Lang.get(22607),
		4180,
		8,
		163,
		{
			RTResTalkAction[43],
			RTResTalkAction[21]
		}
	},
	[4180009] = {
		4180009,
		0,
		Lang.get(22608),
		4180,
		9,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4180010] = {
		4180010,
		0,
		Lang.get(22609),
		4180,
		10,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[21]
		}
	},
	[4180011] = {
		4180011,
		0,
		Lang.get(22610),
		4180,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4180012] = {
		4180012,
		0,
		Lang.get(22611),
		4180,
		12,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4180013] = {
		4180013,
		0,
		Lang.get(22612),
		4180,
		13,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4180014] = {
		4180014,
		0,
		Lang.get(22613),
		4180,
		14,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[21]
		}
	},
	[4180015] = {
		4180015,
		0,
		Lang.get(22614),
		4180,
		15,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4180016] = {
		4180016,
		0,
		Lang.get(22615),
		4180,
		16,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4180017] = {
		4180017,
		0,
		Lang.get(22616),
		4180,
		17,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[21]
		}
	},
	[4180018] = {
		4180018,
		0,
		Lang.get(22617),
		4180,
		18,
		606,
		{
			RTResTalkAction[46],
			RTResTalkAction[24]
		}
	},
	[4180019] = {
		4180019,
		0,
		Lang.get(22618),
		4180,
		19,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[47]
		}
	},
	[4180020] = {
		4180020,
		0,
		Lang.get(22619),
		4180,
		20,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4180021] = {
		4180021,
		3,
		Lang.get(22620),
		4180,
		21,
		605,
		{
			RTResTalkAction[21]
		},
		[18] = 1079,
		[22] = 1
	},
	[4180022] = {
		4180022,
		0,
		Lang.get(55749),
		4180,
		22,
		163,
		{
			RTResTalkAction[23]
		}
	},
	[4180023] = {
		4180023,
		0,
		Lang.get(22621),
		4180,
		23,
		607,
		{
			RTResTalkAction[48],
			RTResTalkAction[24]
		}
	},
	[4180024] = {
		4180024,
		3,
		Lang.get(22620),
		4180,
		24,
		605,
		{
			RTResTalkAction[49]
		},
		[18] = 1079,
		[22] = 1
	},
	[4181001] = {
		4181001,
		0,
		Lang.get(22622),
		4181,
		1,
		163,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4181,
		1,
		nil,
		nil,
		nil,
		nil,
		4181
	},
	[4181002] = {
		4181002,
		0,
		Lang.get(55750),
		4181,
		2,
		163,
		{
			RTResTalkAction[44]
		}
	},
	[4181003] = {
		4181003,
		3,
		Lang.get(22624),
		4181,
		3,
		605,
		{
			RTResTalkAction[24]
		},
		[18] = 1079,
		[22] = 1
	},
	[4181004] = {
		4181004,
		3,
		Lang.get(22620),
		4181,
		4,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4181005] = {
		4181005,
		0,
		Lang.get(22622),
		4181,
		5,
		163,
		{
			RTResTalkAction[44]
		}
	},
	[4181006] = {
		4181006,
		0,
		Lang.get(22622),
		4181,
		6,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[24]
		}
	},
	[4181007] = {
		4181007,
		3,
		Lang.get(22624),
		4181,
		7,
		605,
		{
			RTResTalkAction[6]
		},
		[18] = 1079,
		[22] = 1
	},
	[4181008] = {
		4181008,
		3,
		Lang.get(22624),
		4181,
		8,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4181009] = {
		4181009,
		0,
		Lang.get(22625),
		4181,
		9,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4182001] = {
		4182001,
		0,
		Lang.get(22626),
		4182,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4182,
		1,
		nil,
		nil,
		nil,
		nil,
		4182
	},
	[4182002] = {
		4182002,
		0,
		Lang.get(22627),
		4182,
		2,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[21]
		}
	},
	[4182003] = {
		4182003,
		0,
		Lang.get(22628),
		4182,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4182004] = {
		4182004,
		0,
		Lang.get(22629),
		4182,
		4,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4182005] = {
		4182005,
		0,
		Lang.get(22630),
		4182,
		5,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[21]
		}
	},
	[4182006] = {
		4182006,
		0,
		Lang.get(22631),
		4182,
		6,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[24]
		}
	},
	[4182007] = {
		4182007,
		0,
		Lang.get(22632),
		4182,
		7,
		163,
		{
			RTResTalkAction[43],
			RTResTalkAction[6]
		}
	},
	[4182008] = {
		4182008,
		0,
		Lang.get(22633),
		4182,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4182009] = {
		4182009,
		3,
		Lang.get(22620),
		4182,
		9,
		605,
		{
			RTResTalkAction[21]
		},
		[18] = 1079,
		[22] = 1
	},
	[4183001] = {
		4183001,
		0,
		"……",
		4183,
		1,
		163,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4183,
		1,
		nil,
		nil,
		nil,
		nil,
		4183
	},
	[4183002] = {
		4183002,
		0,
		Lang.get(55751),
		4183,
		2,
		163,
		{
			RTResTalkAction[44]
		}
	},
	[4183003] = {
		4183003,
		3,
		Lang.get(22634),
		4183,
		3,
		605,
		{
			RTResTalkAction[24]
		},
		[18] = 1079,
		[22] = 1
	},
	[4183004] = {
		4183004,
		0,
		"……",
		4183,
		4,
		163,
		{
			RTResTalkAction[51]
		}
	},
	[4183005] = {
		4183005,
		0,
		"……",
		4183,
		5,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[24]
		}
	},
	[4183006] = {
		4183006,
		0,
		Lang.get(22635),
		4183,
		6,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[6]
		}
	},
	[4183007] = {
		4183007,
		3,
		Lang.get(22636),
		4183,
		7,
		605,
		{
			RTResTalkAction[24]
		},
		[18] = 1079,
		[22] = 1
	},
	[4183008] = {
		4183008,
		3,
		Lang.get(22636),
		4183,
		8,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4183009] = {
		4183009,
		3,
		Lang.get(22636),
		4183,
		9,
		605,
		[18] = 1079,
		[22] = 1
	},
	[4183010] = {
		4183010,
		0,
		Lang.get(22637),
		4183,
		10,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4183011] = {
		4183011,
		0,
		Lang.get(22638),
		4183,
		11,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[21]
		}
	},
	[4183012] = {
		4183012,
		0,
		Lang.get(22639),
		4183,
		12,
		163,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		nil,
		2,
		1,
		nil,
		nil,
		4390
	},
	[4183013] = {
		4183013,
		0,
		Lang.get(22640),
		4183,
		13,
		163,
		{
			RTResTalkAction[44]
		}
	},
	[4183014] = {
		4183014,
		0,
		Lang.get(22641),
		4183,
		14,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[24]
		}
	},
	[4183015] = {
		4183015,
		0,
		Lang.get(22642),
		4183,
		15,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4183016] = {
		4183016,
		0,
		Lang.get(22643),
		4183,
		16,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[21]
		}
	},
	[4183017] = {
		4183017,
		0,
		Lang.get(22644),
		4183,
		17,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[24]
		}
	},
	[4183018] = {
		4183018,
		0,
		Lang.get(22645),
		4183,
		18,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[6]
		}
	},
	[4183019] = {
		4183019,
		0,
		Lang.get(22646),
		4183,
		19,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[24]
		}
	},
	[4183020] = {
		4183020,
		0,
		Lang.get(22647),
		4183,
		20,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[6]
		}
	},
	[4184001] = {
		4184001,
		0,
		Lang.get(22648),
		4184,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4184,
		1,
		nil,
		nil,
		nil,
		nil,
		4184
	},
	[4184002] = {
		4184002,
		0,
		Lang.get(22649),
		4184,
		2,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4184003] = {
		4184003,
		0,
		Lang.get(22650),
		4184,
		3,
		163,
		{
			RTResTalkAction[52],
			RTResTalkAction[21]
		}
	},
	[4184004] = {
		4184004,
		0,
		Lang.get(22651),
		4184,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4184005] = {
		4184005,
		0,
		Lang.get(22652),
		4184,
		5,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[21]
		}
	},
	[4184006] = {
		4184006,
		0,
		Lang.get(22653),
		4184,
		6,
		163,
		{
			RTResTalkAction[44]
		}
	},
	[4184007] = {
		4184007,
		0,
		Lang.get(55752),
		4184,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4184008] = {
		4184008,
		0,
		Lang.get(22654),
		4184,
		8,
		159,
		{
			RTResTalkAction[53],
			RTResTalkAction[21]
		}
	},
	[4184009] = {
		4184009,
		0,
		Lang.get(22655),
		4184,
		9,
		573,
		{
			RTResTalkAction[54],
			RTResTalkAction[6]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4185,
		2,
		1
	},
	[4184010] = {
		4184010,
		0,
		Lang.get(22656),
		4184,
		10,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[55]
		}
	},
	[4184011] = {
		4184011,
		0,
		Lang.get(22657),
		4184,
		11,
		573,
		{
			RTResTalkAction[54],
			RTResTalkAction[24]
		}
	},
	[4184012] = {
		4184012,
		0,
		Lang.get(22658),
		4184,
		12,
		573,
		{
			RTResTalkAction[54]
		}
	},
	[4184013] = {
		4184013,
		0,
		Lang.get(22659),
		4184,
		13,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[55]
		}
	},
	[4184014] = {
		4184014,
		0,
		Lang.get(22660),
		4184,
		14,
		159,
		{
			RTResTalkAction[53],
			RTResTalkAction[24]
		}
	},
	[4184015] = {
		4184015,
		0,
		Lang.get(22661),
		4184,
		15,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[6]
		}
	},
	[4184016] = {
		4184016,
		0,
		Lang.get(22662),
		4184,
		16,
		159,
		{
			RTResTalkAction[45],
			RTResTalkAction[24]
		}
	},
	[4184017] = {
		4184017,
		0,
		Lang.get(22663),
		4184,
		17,
		573,
		{
			RTResTalkAction[54],
			RTResTalkAction[6]
		}
	},
	[4184018] = {
		4184018,
		0,
		Lang.get(22664),
		4184,
		18,
		159,
		{
			RTResTalkAction[53],
			RTResTalkAction[55]
		}
	},
	[4184019] = {
		4184019,
		0,
		Lang.get(22665),
		4184,
		19,
		573,
		{
			RTResTalkAction[54],
			RTResTalkAction[6]
		}
	},
	[4184020] = {
		4184020,
		0,
		Lang.get(22666),
		4184,
		20,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[4190001] = {
		4190001,
		0,
		Lang.get(22667),
		4190,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4190,
		1,
		nil,
		nil,
		nil,
		nil,
		4190
	},
	[4190002] = {
		4190002,
		0,
		Lang.get(22668),
		4190,
		2,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190003] = {
		4190003,
		0,
		Lang.get(22669),
		4190,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190004] = {
		4190004,
		0,
		Lang.get(22670),
		4190,
		4,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4190005] = {
		4190005,
		0,
		Lang.get(22671),
		4190,
		5,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190006] = {
		4190006,
		0,
		Lang.get(22672),
		4190,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190007] = {
		4190007,
		0,
		Lang.get(22673),
		4190,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190008] = {
		4190008,
		0,
		Lang.get(22674),
		4190,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190009] = {
		4190009,
		0,
		Lang.get(22675),
		4190,
		9,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190010] = {
		4190010,
		0,
		Lang.get(22676),
		4190,
		10,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4190011] = {
		4190011,
		0,
		Lang.get(22677),
		4190,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190012] = {
		4190012,
		0,
		Lang.get(22678),
		4190,
		12,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190013] = {
		4190013,
		0,
		Lang.get(22679),
		4190,
		13,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190014] = {
		4190014,
		0,
		Lang.get(22680),
		4190,
		14,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4190015] = {
		4190015,
		0,
		Lang.get(22681),
		4190,
		15,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4190016] = {
		4190016,
		0,
		Lang.get(22682),
		4190,
		16,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4190017] = {
		4190017,
		0,
		Lang.get(22683),
		4190,
		17,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4190018] = {
		4190018,
		0,
		Lang.get(22684),
		4190,
		18,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4190019] = {
		4190019,
		0,
		Lang.get(22685),
		4190,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4190020] = {
		4190020,
		0,
		"！？",
		4190,
		20,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4190021] = {
		4190021,
		0,
		Lang.get(22686),
		4190,
		21,
		158,
		{
			RTResTalkAction[56]
		}
	},
	[4191001] = {
		4191001,
		0,
		Lang.get(22687),
		4191,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4191,
		2,
		nil,
		nil,
		1,
		nil,
		4191
	},
	[4191002] = {
		4191002,
		0,
		Lang.get(22688),
		4191,
		2,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4191003] = {
		4191003,
		0,
		Lang.get(22689),
		4191,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4191004] = {
		4191004,
		0,
		Lang.get(22690),
		4191,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4191005] = {
		4191005,
		0,
		Lang.get(22691),
		4191,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4191006] = {
		4191006,
		0,
		Lang.get(22692),
		4191,
		6,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4191007] = {
		4191007,
		0,
		Lang.get(22693),
		4191,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4191008] = {
		4191008,
		0,
		Lang.get(22694),
		4191,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4191009] = {
		4191009,
		0,
		Lang.get(22695),
		4191,
		9,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4191010] = {
		4191010,
		0,
		Lang.get(22696),
		4191,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4191011] = {
		4191011,
		0,
		Lang.get(22697),
		4191,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4191012] = {
		4191012,
		0,
		Lang.get(22698),
		4191,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4191013] = {
		4191013,
		0,
		Lang.get(22699),
		4191,
		13,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4200001] = {
		4200001,
		0,
		Lang.get(22700),
		4200,
		1,
		611,
		nil,
		1,
		nil,
		nil,
		nil,
		67,
		4200,
		3,
		nil,
		nil,
		1,
		nil,
		4200
	},
	[4200002] = {
		4200002,
		0,
		Lang.get(22701),
		4200,
		2,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4201,
		1.5
	},
	[4200003] = {
		4200003,
		0,
		Lang.get(22702),
		4200,
		3,
		611,
		nil,
		1
	},
	[4200004] = {
		4200004,
		0,
		Lang.get(22703),
		4200,
		4,
		159,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4404,
		1.5
	},
	[4200005] = {
		4200005,
		0,
		Lang.get(22704),
		4200,
		5,
		611,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		4
	},
	[4200006] = {
		4200006,
		0,
		Lang.get(22705),
		4200,
		6,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200007] = {
		4200007,
		0,
		Lang.get(22706),
		4200,
		7,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200008] = {
		4200008,
		0,
		Lang.get(22707),
		4200,
		8,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200009] = {
		4200009,
		0,
		Lang.get(22708),
		4200,
		9,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200010] = {
		4200010,
		0,
		Lang.get(22709),
		4200,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		}
	},
	[4200011] = {
		4200011,
		0,
		Lang.get(22710),
		4200,
		11,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200012] = {
		4200012,
		0,
		Lang.get(22711),
		4200,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		}
	},
	[4200013] = {
		4200013,
		0,
		Lang.get(22712),
		4200,
		13,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200014] = {
		4200014,
		0,
		Lang.get(22713),
		4200,
		14,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4390,
		1.5,
		1
	},
	[4200015] = {
		4200015,
		0,
		Lang.get(22714),
		4200,
		15,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200016] = {
		4200016,
		0,
		Lang.get(22715),
		4200,
		16,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		}
	},
	[4200017] = {
		4200017,
		0,
		Lang.get(22716),
		4200,
		17,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200018] = {
		4200018,
		0,
		Lang.get(22717),
		4200,
		18,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200019] = {
		4200019,
		0,
		Lang.get(22718),
		4200,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4388,
		1.5,
		1
	},
	[4200020] = {
		4200020,
		0,
		Lang.get(22719),
		4200,
		20,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200021] = {
		4200021,
		0,
		Lang.get(22720),
		4200,
		21,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		}
	},
	[4200022] = {
		4200022,
		0,
		Lang.get(22721),
		4200,
		22,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4200023] = {
		4200023,
		0,
		Lang.get(22722),
		4200,
		23,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[6]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4392,
		1.5,
		1
	},
	[4200024] = {
		4200024,
		0,
		Lang.get(22723),
		4200,
		24,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200025] = {
		4200025,
		0,
		Lang.get(22724),
		4200,
		25,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200026] = {
		4200026,
		0,
		"FULI。",
		4200,
		26,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200027] = {
		4200027,
		0,
		Lang.get(22725),
		4200,
		27,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200028] = {
		4200028,
		0,
		Lang.get(22726),
		4200,
		28,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200029] = {
		4200029,
		0,
		Lang.get(22727),
		4200,
		29,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200030] = {
		4200030,
		0,
		Lang.get(22728),
		4200,
		30,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200031] = {
		4200031,
		0,
		Lang.get(22729),
		4200,
		31,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200032] = {
		4200032,
		0,
		Lang.get(22730),
		4200,
		32,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[58]
		}
	},
	[4200033] = {
		4200033,
		0,
		Lang.get(22731),
		4200,
		33,
		611,
		{
			RTResTalkAction[57],
			RTResTalkAction[2]
		}
	},
	[4200034] = {
		4200034,
		0,
		Lang.get(22732),
		4200,
		34,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200035] = {
		4200035,
		0,
		Lang.get(22733),
		4200,
		35,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4200036] = {
		4200036,
		0,
		Lang.get(22734),
		4200,
		36,
		611,
		{
			RTResTalkAction[57]
		}
	},
	[4201001] = {
		4201001,
		0,
		Lang.get(22735),
		4201,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		9,
		4201,
		2,
		nil,
		nil,
		0,
		nil,
		4201
	},
	[4201002] = {
		4201002,
		0,
		Lang.get(22736),
		4201,
		2,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4201003] = {
		4201003,
		0,
		Lang.get(22737),
		4201,
		3,
		163,
		{
			RTResTalkAction[59],
			RTResTalkAction[21]
		}
	},
	[4201004] = {
		4201004,
		0,
		Lang.get(22738),
		4201,
		4,
		163,
		{
			RTResTalkAction[43]
		}
	},
	[4201005] = {
		4201005,
		0,
		Lang.get(22739),
		4201,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4201006] = {
		4201006,
		0,
		Lang.get(22740),
		4201,
		6,
		163,
		{
			RTResTalkAction[43],
			RTResTalkAction[21]
		}
	},
	[4201007] = {
		4201007,
		0,
		Lang.get(22741),
		4201,
		7,
		163,
		{
			RTResTalkAction[43]
		}
	},
	[4201008] = {
		4201008,
		0,
		Lang.get(22742),
		4201,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4201009] = {
		4201009,
		0,
		Lang.get(22743),
		4201,
		9,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[21]
		}
	},
	[4201010] = {
		4201010,
		0,
		Lang.get(22744),
		4201,
		10,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		}
	},
	[4201011] = {
		4201011,
		0,
		Lang.get(22745),
		4201,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4201012] = {
		4201012,
		0,
		Lang.get(22746),
		4201,
		12,
		52,
		{
			RTResTalkAction[61],
			RTResTalkAction[21]
		}
	},
	[4201013] = {
		4201013,
		0,
		Lang.get(22747),
		4201,
		13,
		159,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[4201014] = {
		4201014,
		0,
		Lang.get(22748),
		4201,
		14,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[6]
		}
	},
	[4201015] = {
		4201015,
		0,
		Lang.get(22749),
		4201,
		15,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[24]
		}
	},
	[4202001] = {
		4202001,
		0,
		Lang.get(22750),
		4202,
		1,
		52,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		4,
		nil,
		9,
		[19] = 4201
	},
	[4202002] = {
		4202002,
		0,
		Lang.get(22751),
		4202,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[63]
		}
	},
	[4202003] = {
		4202003,
		0,
		Lang.get(22752),
		4202,
		3,
		163,
		{
			RTResTalkAction[44],
			RTResTalkAction[21]
		}
	},
	[4202004] = {
		4202004,
		0,
		Lang.get(55753),
		4202,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4210001] = {
		4210001,
		0,
		Lang.get(22753),
		4210,
		1,
		158,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4415,
		1.5,
		nil,
		nil,
		1,
		nil,
		4415
	},
	[4210002] = {
		4210002,
		0,
		Lang.get(22754),
		4210,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4210003] = {
		4210003,
		0,
		Lang.get(22755),
		4210,
		3,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4210004] = {
		4210004,
		0,
		Lang.get(22756),
		4210,
		4,
		158,
		{
			RTResTalkAction[65],
			RTResTalkAction[21]
		}
	},
	[4210005] = {
		4210005,
		0,
		Lang.get(22757),
		4210,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4210006] = {
		4210006,
		0,
		Lang.get(22758),
		4210,
		6,
		158,
		{
			RTResTalkAction[64],
			RTResTalkAction[21]
		}
	},
	[4210007] = {
		4210007,
		0,
		Lang.get(22759),
		4210,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4210008] = {
		4210008,
		0,
		Lang.get(22760),
		4210,
		8,
		158,
		{
			RTResTalkAction[66],
			RTResTalkAction[21]
		}
	},
	[4210009] = {
		4210009,
		0,
		Lang.get(22761),
		4210,
		9,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4210010] = {
		4210010,
		0,
		Lang.get(22762),
		4210,
		10,
		158,
		{
			RTResTalkAction[65],
			RTResTalkAction[21]
		}
	},
	[4210011] = {
		4210011,
		0,
		Lang.get(22763),
		4210,
		11,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4210012] = {
		4210012,
		0,
		Lang.get(22764),
		4210,
		12,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4210013] = {
		4210013,
		0,
		Lang.get(22765),
		4210,
		13,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4369,
		1,
		1,
		nil,
		0,
		nil,
		4216
	},
	[4210014] = {
		4210014,
		0,
		Lang.get(22766),
		4210,
		14,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4210015] = {
		4210015,
		0,
		Lang.get(22767),
		4210,
		15,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4210016] = {
		4210016,
		0,
		Lang.get(22768),
		4210,
		16,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4210017] = {
		4210017,
		0,
		Lang.get(22769),
		4210,
		17,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4210018] = {
		4210018,
		0,
		Lang.get(22770),
		4210,
		18,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4210019] = {
		4210019,
		0,
		Lang.get(22771),
		4210,
		19,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4210020] = {
		4210020,
		0,
		Lang.get(22772),
		4210,
		20,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4210021] = {
		4210021,
		0,
		Lang.get(22773),
		4210,
		21,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4210022] = {
		4210022,
		0,
		Lang.get(22774),
		4210,
		22,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4210023] = {
		4210023,
		0,
		Lang.get(55754),
		4210,
		23,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[21]
		}
	},
	[4210024] = {
		4210024,
		0,
		Lang.get(22776),
		4210,
		24,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4217,
		1,
		1,
		nil,
		0,
		nil,
		4217
	},
	[4210025] = {
		4210025,
		0,
		Lang.get(22777),
		4210,
		25,
		158,
		{
			RTResTalkAction[65],
			RTResTalkAction[21]
		}
	},
	[4210026] = {
		4210026,
		0,
		Lang.get(22778),
		4210,
		26,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[4210027] = {
		4210027,
		0,
		Lang.get(22779),
		4210,
		27,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4210028] = {
		4210028,
		0,
		Lang.get(22780),
		4210,
		28,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4218,
		1,
		1,
		nil,
		0,
		nil,
		4218
	},
	[4210029] = {
		4210029,
		0,
		Lang.get(55755),
		4210,
		29,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4210030] = {
		4210030,
		0,
		Lang.get(22782),
		4210,
		30,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4210031] = {
		4210031,
		0,
		"……",
		4210,
		31,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4211001] = {
		4211001,
		0,
		Lang.get(22783),
		4211,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4211,
		2,
		nil,
		nil,
		nil,
		nil,
		4211
	},
	[4211002] = {
		4211002,
		0,
		Lang.get(22784),
		4211,
		2,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4211003] = {
		4211003,
		0,
		Lang.get(22785),
		4211,
		3,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[21]
		}
	},
	[4211004] = {
		4211004,
		0,
		Lang.get(22786),
		4211,
		4,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[24]
		}
	},
	[4212001] = {
		4212001,
		0,
		Lang.get(22787),
		4212,
		1,
		612,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4212,
		1,
		nil,
		nil,
		nil,
		nil,
		4212
	},
	[4212002] = {
		4212002,
		0,
		Lang.get(22788),
		4212,
		2,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212003] = {
		4212003,
		0,
		Lang.get(22789),
		4212,
		3,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[72]
		}
	},
	[4212004] = {
		4212004,
		0,
		Lang.get(22790),
		4212,
		4,
		612,
		{
			RTResTalkAction[69]
		}
	},
	[4212005] = {
		4212005,
		0,
		Lang.get(22791),
		4212,
		5,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212006] = {
		4212006,
		0,
		Lang.get(22792),
		4212,
		6,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[72]
		}
	},
	[4212007] = {
		4212007,
		0,
		Lang.get(22793),
		4212,
		7,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212008] = {
		4212008,
		0,
		Lang.get(22794),
		4212,
		8,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[72]
		}
	},
	[4212009] = {
		4212009,
		0,
		Lang.get(22795),
		4212,
		9,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[21]
		}
	},
	[4212010] = {
		4212010,
		0,
		Lang.get(22796),
		4212,
		10,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212011] = {
		4212011,
		0,
		Lang.get(22797),
		4212,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[72]
		}
	},
	[4212012] = {
		4212012,
		0,
		Lang.get(22798),
		4212,
		12,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[21]
		}
	},
	[4212013] = {
		4212013,
		0,
		Lang.get(22799),
		4212,
		13,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212014] = {
		4212014,
		0,
		Lang.get(22800),
		4212,
		14,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[72]
		}
	},
	[4212015] = {
		4212015,
		0,
		Lang.get(22801),
		4212,
		15,
		613,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		}
	},
	[4212016] = {
		4212016,
		0,
		Lang.get(22802),
		4212,
		16,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[72]
		}
	},
	[4212017] = {
		4212017,
		0,
		Lang.get(22803),
		4212,
		17,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[21]
		}
	},
	[4212018] = {
		4212018,
		0,
		Lang.get(22804),
		4212,
		18,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[24]
		}
	},
	[4212019] = {
		4212019,
		0,
		Lang.get(22805),
		4212,
		19,
		163,
		{
			RTResTalkAction[51],
			RTResTalkAction[6]
		}
	},
	[4212020] = {
		4212020,
		0,
		Lang.get(22806),
		4212,
		20,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4212021] = {
		4212021,
		0,
		"……",
		4212,
		21,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[21]
		}
	},
	[4212022] = {
		4212022,
		0,
		Lang.get(22807),
		4212,
		22,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4212023] = {
		4212023,
		0,
		Lang.get(22808),
		4212,
		23,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4212024] = {
		4212024,
		0,
		Lang.get(22809),
		4212,
		24,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4213001] = {
		4213001,
		0,
		Lang.get(22810),
		4213,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4213,
		1,
		nil,
		nil,
		1,
		nil,
		4213
	},
	[4213002] = {
		4213002,
		0,
		Lang.get(22811),
		4213,
		2,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4213003] = {
		4213003,
		0,
		Lang.get(22812),
		4213,
		3,
		163,
		{
			RTResTalkAction[43],
			RTResTalkAction[68]
		}
	},
	[4213004] = {
		4213004,
		0,
		Lang.get(22813),
		4213,
		4,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[24]
		}
	},
	[4213005] = {
		4213005,
		0,
		"……",
		4213,
		5,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[68]
		}
	},
	[4213006] = {
		4213006,
		0,
		"……",
		4213,
		6,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[24]
		}
	},
	[4213007] = {
		4213007,
		0,
		"……",
		4213,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4213008] = {
		4213008,
		0,
		Lang.get(22814),
		4213,
		8,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4213009] = {
		4213009,
		0,
		Lang.get(22815),
		4213,
		9,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[68]
		}
	},
	[4213010] = {
		4213010,
		0,
		Lang.get(22816),
		4213,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[24]
		}
	},
	[4213011] = {
		4213011,
		0,
		Lang.get(22817),
		4213,
		11,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4213012] = {
		4213012,
		0,
		Lang.get(22818),
		4213,
		12,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4213013] = {
		4213013,
		0,
		Lang.get(22819),
		4213,
		13,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4213014] = {
		4213014,
		0,
		Lang.get(22820),
		4213,
		14,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4213015] = {
		4213015,
		0,
		Lang.get(22821),
		4213,
		15,
		163,
		{
			RTResTalkAction[23],
			RTResTalkAction[68]
		}
	},
	[4214001] = {
		4214001,
		0,
		Lang.get(22822),
		4214,
		1,
		48,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4214,
		1.5,
		nil,
		nil,
		0,
		nil,
		4214
	},
	[4214002] = {
		4214002,
		0,
		Lang.get(22823),
		4214,
		2,
		48,
		{
			RTResTalkAction[73]
		}
	},
	[4214003] = {
		4214003,
		0,
		Lang.get(22824),
		4214,
		3,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[74]
		}
	},
	[4214004] = {
		4214004,
		0,
		Lang.get(22825),
		4214,
		4,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4214005] = {
		4214005,
		0,
		Lang.get(22826),
		4214,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4215001] = {
		4215001,
		0,
		Lang.get(22827),
		4215,
		1,
		48,
		nil,
		1,
		nil,
		nil,
		nil,
		14,
		4215,
		nil,
		nil,
		nil,
		nil,
		nil,
		4215
	},
	[4215002] = {
		4215002,
		0,
		Lang.get(22828),
		4215,
		2,
		614,
		nil,
		1
	},
	[4215003] = {
		4215003,
		0,
		Lang.get(22829),
		4215,
		3,
		48,
		nil,
		1
	},
	[4215004] = {
		4215004,
		0,
		Lang.get(22830),
		4215,
		4,
		614,
		nil,
		1
	},
	[4215005] = {
		4215005,
		0,
		Lang.get(22831),
		4215,
		5,
		48,
		nil,
		1
	},
	[4215006] = {
		4215006,
		0,
		Lang.get(22832),
		4215,
		6,
		614,
		nil,
		1
	},
	[4220001] = {
		4220001,
		0,
		Lang.get(22833),
		4220,
		1,
		575,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		4220,
		nil,
		nil,
		nil,
		nil,
		nil,
		4220
	},
	[4220002] = {
		4220002,
		0,
		Lang.get(22834),
		4220,
		2,
		576,
		nil,
		1
	},
	[4220003] = {
		4220003,
		0,
		Lang.get(22835),
		4220,
		3,
		575,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4224,
		1,
		nil,
		nil,
		nil,
		nil,
		4224
	},
	[4220004] = {
		4220004,
		0,
		Lang.get(22836),
		4220,
		4,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4220005] = {
		4220005,
		0,
		Lang.get(22837),
		4220,
		5,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4220006] = {
		4220006,
		0,
		Lang.get(22838),
		4220,
		6,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4220007] = {
		4220007,
		0,
		Lang.get(22839),
		4220,
		7,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4220008] = {
		4220008,
		0,
		Lang.get(22840),
		4220,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4220009] = {
		4220009,
		0,
		Lang.get(22841),
		4220,
		9,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4220010] = {
		4220010,
		0,
		Lang.get(22842),
		4220,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4220011] = {
		4220011,
		0,
		Lang.get(22843),
		4220,
		11,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4220012] = {
		4220012,
		0,
		Lang.get(22844),
		4220,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4220013] = {
		4220013,
		0,
		Lang.get(22845),
		4220,
		13,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4220014] = {
		4220014,
		0,
		Lang.get(22846),
		4220,
		14,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4220015] = {
		4220015,
		0,
		Lang.get(22847),
		4220,
		15,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4220016] = {
		4220016,
		0,
		Lang.get(22848),
		4220,
		16,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4220017] = {
		4220017,
		0,
		Lang.get(22849),
		4220,
		17,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4221001] = {
		4221001,
		0,
		Lang.get(22850),
		4221,
		1,
		576,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4221,
		1,
		nil,
		nil,
		nil,
		nil,
		4221
	},
	[4221002] = {
		4221002,
		0,
		Lang.get(22851),
		4221,
		2,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4221003] = {
		4221003,
		0,
		Lang.get(22852),
		4221,
		3,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4221004] = {
		4221004,
		0,
		Lang.get(22853),
		4221,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4221005] = {
		4221005,
		0,
		Lang.get(22854),
		4221,
		5,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4221006] = {
		4221006,
		0,
		Lang.get(22855),
		4221,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4221007] = {
		4221007,
		0,
		Lang.get(22856),
		4221,
		7,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4221008] = {
		4221008,
		0,
		Lang.get(22857),
		4221,
		8,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4221009] = {
		4221009,
		0,
		Lang.get(22858),
		4221,
		9,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4221010] = {
		4221010,
		0,
		Lang.get(22859),
		4221,
		10,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4221011] = {
		4221011,
		0,
		Lang.get(22860),
		4221,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4221012] = {
		4221012,
		0,
		Lang.get(22861),
		4221,
		12,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4221013] = {
		4221013,
		0,
		Lang.get(22862),
		4221,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4221014] = {
		4221014,
		0,
		Lang.get(22863),
		4221,
		14,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4221015] = {
		4221015,
		0,
		Lang.get(22864),
		4221,
		15,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4221016] = {
		4221016,
		0,
		Lang.get(22865),
		4221,
		16,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4221017] = {
		4221017,
		0,
		Lang.get(22866),
		4221,
		17,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[76]
		}
	},
	[4221018] = {
		4221018,
		0,
		Lang.get(22867),
		4221,
		18,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[6]
		}
	},
	[4221019] = {
		4221019,
		0,
		Lang.get(22868),
		4221,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4221020] = {
		4221020,
		0,
		Lang.get(22869),
		4221,
		20,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4221021] = {
		4221021,
		0,
		Lang.get(22870),
		4221,
		21,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4221022] = {
		4221022,
		0,
		Lang.get(22871),
		4221,
		22,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[4221023] = {
		4221023,
		0,
		Lang.get(22872),
		4221,
		23,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4221024] = {
		4221024,
		0,
		Lang.get(22873),
		4221,
		24,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4221025] = {
		4221025,
		0,
		Lang.get(22874),
		4221,
		25,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4221026] = {
		4221026,
		0,
		Lang.get(22875),
		4221,
		26,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4221027] = {
		4221027,
		0,
		Lang.get(22876),
		4221,
		27,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4221028] = {
		4221028,
		0,
		Lang.get(22877),
		4221,
		28,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4221029] = {
		4221029,
		0,
		Lang.get(22878),
		4221,
		29,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4221030] = {
		4221030,
		0,
		Lang.get(22879),
		4221,
		30,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4221031] = {
		4221031,
		0,
		Lang.get(22880),
		4221,
		31,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4221032] = {
		4221032,
		0,
		Lang.get(22881),
		4221,
		32,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4221033] = {
		4221033,
		0,
		Lang.get(22882),
		4221,
		33,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4221034] = {
		4221034,
		0,
		Lang.get(55756),
		4221,
		34,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[68]
		}
	},
	[4221035] = {
		4221035,
		0,
		Lang.get(22883),
		4221,
		35,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4221036] = {
		4221036,
		0,
		Lang.get(22884),
		4221,
		36,
		158,
		{
			RTResTalkAction[11],
			RTResTalkAction[68]
		}
	},
	[4221037] = {
		4221037,
		0,
		Lang.get(22885),
		4221,
		37,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4221038] = {
		4221038,
		0,
		Lang.get(22886),
		4221,
		38,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4221039] = {
		4221039,
		0,
		Lang.get(22887),
		4221,
		39,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4221040] = {
		4221040,
		0,
		Lang.get(22888),
		4221,
		40,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4221041] = {
		4221041,
		0,
		Lang.get(22889),
		4221,
		41,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4222001] = {
		4222001,
		0,
		Lang.get(22890),
		4222,
		1,
		48,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4222,
		1,
		nil,
		nil,
		nil,
		nil,
		4222
	},
	[4222002] = {
		4222002,
		0,
		Lang.get(22891),
		4222,
		2,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[74]
		}
	},
	[4222003] = {
		4222003,
		0,
		Lang.get(22892),
		4222,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[78]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4367,
		1,
		1,
		nil,
		nil,
		nil,
		4367
	},
	[4222004] = {
		4222004,
		0,
		Lang.get(22893),
		4222,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4222005] = {
		4222005,
		0,
		Lang.get(22894),
		4222,
		5,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4222006] = {
		4222006,
		0,
		Lang.get(22895),
		4222,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4222007] = {
		4222007,
		0,
		Lang.get(22896),
		4222,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4222008] = {
		4222008,
		0,
		Lang.get(22897),
		4222,
		8,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[2]
		}
	},
	[4222009] = {
		4222009,
		0,
		Lang.get(22898),
		4222,
		9,
		48,
		{
			RTResTalkAction[73],
			RTResTalkAction[78]
		}
	},
	[4222010] = {
		4222010,
		0,
		Lang.get(22899),
		4222,
		10,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[74]
		}
	},
	[4222011] = {
		4222011,
		0,
		Lang.get(22900),
		4222,
		11,
		48,
		{
			RTResTalkAction[73],
			RTResTalkAction[78]
		}
	},
	[4223001] = {
		4223001,
		0,
		Lang.get(22901),
		4223,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		14,
		4211,
		[19] = 4211,
		[20] = 150
	},
	[4223002] = {
		4223002,
		0,
		Lang.get(22902),
		4223,
		2,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4223003] = {
		4223003,
		0,
		Lang.get(55757),
		4223,
		3,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4230001] = {
		4230001,
		0,
		Lang.get(22903),
		4230,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		59,
		4230,
		1,
		nil,
		nil,
		nil,
		nil,
		4230
	},
	[4230002] = {
		4230002,
		0,
		Lang.get(22904),
		4230,
		2,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[2]
		}
	},
	[4230003] = {
		4230003,
		0,
		Lang.get(22905),
		4230,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[78]
		}
	},
	[4230004] = {
		4230004,
		0,
		Lang.get(22906),
		4230,
		4,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[2]
		}
	},
	[4231001] = {
		4231001,
		2,
		Lang.get(22907),
		4231,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		59,
		4231,
		1,
		nil,
		nil,
		1,
		nil,
		4231
	},
	[4231002] = {
		4231002,
		0,
		Lang.get(22908),
		4231,
		2,
		616,
		{
			RTResTalkAction[79],
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		4234
	},
	[4231003] = {
		4231003,
		0,
		Lang.get(22909),
		4231,
		3,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[81]
		}
	},
	[4231004] = {
		4231004,
		0,
		Lang.get(22910),
		4231,
		4,
		616,
		{
			RTResTalkAction[79],
			RTResTalkAction[82]
		}
	},
	[4231005] = {
		4231005,
		0,
		Lang.get(22911),
		4231,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[81]
		}
	},
	[4231006] = {
		4231006,
		0,
		Lang.get(22912),
		4231,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4231007] = {
		4231007,
		2,
		Lang.get(22913),
		4231,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4231008] = {
		4231008,
		0,
		Lang.get(55758),
		4231,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4231009] = {
		4231009,
		0,
		Lang.get(22914),
		4231,
		9,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[2]
		}
	},
	[4231010] = {
		4231010,
		0,
		Lang.get(22915),
		4231,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[78]
		}
	},
	[4231011] = {
		4231011,
		0,
		Lang.get(22916),
		4231,
		11,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[4231012] = {
		4231012,
		0,
		Lang.get(22917),
		4231,
		12,
		616,
		{
			RTResTalkAction[79],
			RTResTalkAction[82]
		}
	},
	[4231013] = {
		4231013,
		0,
		Lang.get(22918),
		4231,
		13,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[81]
		}
	},
	[4231014] = {
		4231014,
		0,
		Lang.get(22919),
		4231,
		14,
		578,
		{
			RTResTalkAction[77]
		}
	},
	[4231015] = {
		4231015,
		0,
		Lang.get(22920),
		4231,
		15,
		578,
		{
			RTResTalkAction[77]
		}
	},
	[4231016] = {
		4231016,
		0,
		Lang.get(22921),
		4231,
		16,
		578,
		{
			RTResTalkAction[77]
		}
	},
	[4232001] = {
		4232001,
		0,
		Lang.get(55759),
		4232,
		1,
		575,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		nil,
		59,
		4232,
		1,
		nil,
		nil,
		nil,
		nil,
		4232
	},
	[4232002] = {
		4232002,
		0,
		Lang.get(22923),
		4232,
		2,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4232003] = {
		4232003,
		0,
		Lang.get(22924),
		4232,
		3,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4232004] = {
		4232004,
		0,
		Lang.get(22925),
		4232,
		4,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4232005] = {
		4232005,
		0,
		Lang.get(22926),
		4232,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4232006] = {
		4232006,
		0,
		Lang.get(22927),
		4232,
		6,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4390,
		1.5,
		2
	},
	[4232007] = {
		4232007,
		0,
		Lang.get(22928),
		4232,
		7,
		158,
		{
			RTResTalkAction[32]
		}
	},
	[4232008] = {
		4232008,
		0,
		Lang.get(22929),
		4232,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4232009] = {
		4232009,
		0,
		Lang.get(22930),
		4232,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4232010] = {
		4232010,
		0,
		Lang.get(22931),
		4232,
		10,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4232011] = {
		4232011,
		0,
		Lang.get(22932),
		4232,
		11,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4233001] = {
		4233001,
		0,
		Lang.get(22933),
		4233,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		59,
		4233,
		1,
		nil,
		nil,
		nil,
		nil,
		4233
	},
	[4233002] = {
		4233002,
		0,
		Lang.get(22934),
		4233,
		2,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4233003] = {
		4233003,
		0,
		Lang.get(22935),
		4233,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4233004] = {
		4233004,
		0,
		Lang.get(22936),
		4233,
		4,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[21]
		}
	},
	[4233005] = {
		4233005,
		0,
		Lang.get(22937),
		4233,
		5,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4233006] = {
		4233006,
		0,
		Lang.get(22938),
		4233,
		6,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4233007] = {
		4233007,
		0,
		Lang.get(22939),
		4233,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4233008] = {
		4233008,
		0,
		Lang.get(22940),
		4233,
		8,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4240001] = {
		4240001,
		0,
		Lang.get(22941),
		4240,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		59,
		4245,
		1,
		nil,
		nil,
		1,
		nil,
		4245
	},
	[4240002] = {
		4240002,
		0,
		Lang.get(22942),
		4240,
		2,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4240003] = {
		4240003,
		0,
		Lang.get(22943),
		4240,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4240004] = {
		4240004,
		0,
		Lang.get(22944),
		4240,
		4,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4240005] = {
		4240005,
		0,
		Lang.get(22945),
		4240,
		5,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4241001] = {
		4241001,
		0,
		Lang.get(22946),
		4241,
		1,
		579,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4241,
		1,
		nil,
		nil,
		1,
		nil,
		4241
	},
	[4241002] = {
		4241002,
		0,
		Lang.get(22947),
		4241,
		2,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[4241003] = {
		4241003,
		0,
		Lang.get(22948),
		4241,
		3,
		579,
		{
			RTResTalkAction[83],
			RTResTalkAction[86]
		}
	},
	[4241004] = {
		4241004,
		0,
		Lang.get(22949),
		4241,
		4,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[4241005] = {
		4241005,
		0,
		Lang.get(22950),
		4241,
		5,
		579,
		{
			RTResTalkAction[83],
			RTResTalkAction[86]
		}
	},
	[4241006] = {
		4241006,
		0,
		Lang.get(22951),
		4241,
		6,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[4241007] = {
		4241007,
		2,
		Lang.get(22952),
		4241,
		7,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241008] = {
		4241008,
		0,
		Lang.get(22953),
		4241,
		8,
		579,
		{
			RTResTalkAction[83],
			RTResTalkAction[86]
		}
	},
	[4241009] = {
		4241009,
		0,
		Lang.get(22954),
		4241,
		9,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[85]
		}
	},
	[4241010] = {
		4241010,
		0,
		Lang.get(22955),
		4241,
		10,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[78]
		}
	},
	[4241011] = {
		4241011,
		0,
		Lang.get(22956),
		4241,
		11,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[86]
		}
	},
	[4241012] = {
		4241012,
		0,
		Lang.get(22957),
		4241,
		12,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[78]
		}
	},
	[4241013] = {
		4241013,
		0,
		Lang.get(22958),
		4241,
		13,
		578,
		{
			RTResTalkAction[77],
			RTResTalkAction[86]
		}
	},
	[4241014] = {
		4241014,
		0,
		Lang.get(22959),
		4241,
		14,
		578,
		{
			RTResTalkAction[77]
		}
	},
	[4241015] = {
		4241015,
		0,
		Lang.get(22960),
		4241,
		15,
		579,
		{
			RTResTalkAction[83],
			RTResTalkAction[78]
		}
	},
	[4241016] = {
		4241016,
		0,
		Lang.get(22961),
		4241,
		16,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[4241017] = {
		4241017,
		0,
		Lang.get(22962),
		4241,
		17,
		16,
		{
			RTResTalkAction[87],
			RTResTalkAction[86]
		}
	},
	[4241018] = {
		4241018,
		0,
		Lang.get(22963),
		4241,
		18,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[88]
		}
	},
	[4241019] = {
		4241019,
		0,
		Lang.get(22964),
		4241,
		19,
		16,
		{
			RTResTalkAction[87],
			RTResTalkAction[86]
		}
	},
	[4241020] = {
		4241020,
		0,
		Lang.get(22965),
		4241,
		20,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[88]
		}
	},
	[4241021] = {
		4241021,
		0,
		Lang.get(22966),
		4241,
		21,
		158,
		{
			RTResTalkAction[86]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		4246,
		1,
		1
	},
	[4241022] = {
		4241022,
		0,
		Lang.get(22967),
		4241,
		22,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4
	},
	[4241023] = {
		4241023,
		0,
		Lang.get(22968),
		4241,
		23,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4241024] = {
		4241024,
		0,
		Lang.get(22969),
		4241,
		24,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241025] = {
		4241025,
		0,
		Lang.get(22970),
		4241,
		25,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241026] = {
		4241026,
		0,
		Lang.get(22971),
		4241,
		26,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4241027] = {
		4241027,
		0,
		Lang.get(22972),
		4241,
		27,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4241028] = {
		4241028,
		0,
		Lang.get(22973),
		4241,
		28,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241029] = {
		4241029,
		0,
		Lang.get(22974),
		4241,
		29,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241030] = {
		4241030,
		0,
		Lang.get(22975),
		4241,
		30,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4241031] = {
		4241031,
		0,
		Lang.get(22976),
		4241,
		31,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4242001] = {
		4242001,
		3,
		Lang.get(22977),
		4242,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		4242,
		nil,
		nil,
		nil,
		1,
		nil,
		4242,
		nil,
		nil,
		1
	},
	[4242002] = {
		4242002,
		0,
		Lang.get(22978),
		4242,
		2,
		617,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		4
	},
	[4242003] = {
		4242003,
		0,
		Lang.get(22979),
		4242,
		3,
		617,
		{
			RTResTalkAction[89]
		}
	},
	[4242004] = {
		4242004,
		0,
		Lang.get(22980),
		4242,
		4,
		618,
		{
			RTResTalkAction[90],
			RTResTalkAction[91]
		}
	},
	[4242005] = {
		4242005,
		0,
		Lang.get(22981),
		4242,
		5,
		617,
		{
			RTResTalkAction[89],
			RTResTalkAction[92]
		}
	},
	[4242006] = {
		4242006,
		0,
		Lang.get(22982),
		4242,
		6,
		618,
		{
			RTResTalkAction[90],
			RTResTalkAction[91]
		}
	},
	[4242007] = {
		4242007,
		0,
		"……",
		4242,
		7,
		617,
		{
			RTResTalkAction[89],
			RTResTalkAction[92]
		}
	},
	[4242008] = {
		4242008,
		0,
		Lang.get(22983),
		4242,
		8,
		582,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		4247,
		[17] = 1
	},
	[4242009] = {
		4242009,
		0,
		Lang.get(22984),
		4242,
		9,
		582,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		4386
	},
	[4242010] = {
		4242010,
		0,
		Lang.get(22985),
		4242,
		10,
		582
	},
	[4242011] = {
		4242011,
		0,
		Lang.get(22986),
		4242,
		11,
		582,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		4390
	},
	[4242012] = {
		4242012,
		0,
		Lang.get(22987),
		4242,
		12,
		582
	},
	[4243001] = {
		4243001,
		0,
		Lang.get(22988),
		4243,
		1,
		582,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4243,
		1,
		nil,
		nil,
		1,
		nil,
		4243
	},
	[4243002] = {
		4243002,
		0,
		Lang.get(22989),
		4243,
		2,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[86]
		}
	},
	[4243003] = {
		4243003,
		0,
		Lang.get(22990),
		4243,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243004] = {
		4243004,
		0,
		Lang.get(22991),
		4243,
		4,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243005] = {
		4243005,
		0,
		Lang.get(22992),
		4243,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243006] = {
		4243006,
		0,
		Lang.get(22993),
		4243,
		6,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243007] = {
		4243007,
		0,
		Lang.get(22994),
		4243,
		7,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243008] = {
		4243008,
		0,
		Lang.get(22995),
		4243,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243009] = {
		4243009,
		0,
		Lang.get(22996),
		4243,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243010] = {
		4243010,
		0,
		Lang.get(22997),
		4243,
		10,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243011] = {
		4243011,
		0,
		Lang.get(22998),
		4243,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243012] = {
		4243012,
		0,
		Lang.get(22999),
		4243,
		12,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243013] = {
		4243013,
		0,
		Lang.get(23000),
		4243,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243014] = {
		4243014,
		0,
		Lang.get(23001),
		4243,
		14,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243015] = {
		4243015,
		0,
		Lang.get(23002),
		4243,
		15,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243016] = {
		4243016,
		0,
		Lang.get(23003),
		4243,
		16,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243017] = {
		4243017,
		0,
		Lang.get(23004),
		4243,
		17,
		158,
		{
			RTResTalkAction[11],
			RTResTalkAction[86]
		}
	},
	[4243018] = {
		4243018,
		0,
		Lang.get(23005),
		4243,
		18,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243019] = {
		4243019,
		0,
		Lang.get(23006),
		4243,
		19,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[86]
		}
	},
	[4243020] = {
		4243020,
		0,
		Lang.get(23007),
		4243,
		20,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243021] = {
		4243021,
		0,
		Lang.get(23008),
		4243,
		21,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243022] = {
		4243022,
		0,
		Lang.get(23009),
		4243,
		22,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243023] = {
		4243023,
		0,
		Lang.get(23010),
		4243,
		23,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243024] = {
		4243024,
		0,
		Lang.get(23011),
		4243,
		24,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243025] = {
		4243025,
		0,
		Lang.get(23012),
		4243,
		25,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243026] = {
		4243026,
		0,
		Lang.get(23013),
		4243,
		26,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243027] = {
		4243027,
		0,
		Lang.get(23014),
		4243,
		27,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243028] = {
		4243028,
		0,
		Lang.get(23015),
		4243,
		28,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243029] = {
		4243029,
		0,
		Lang.get(23016),
		4243,
		29,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243030] = {
		4243030,
		0,
		Lang.get(23017),
		4243,
		30,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243031] = {
		4243031,
		0,
		Lang.get(23018),
		4243,
		31,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243032] = {
		4243032,
		0,
		Lang.get(23019),
		4243,
		32,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243033] = {
		4243033,
		0,
		Lang.get(55760),
		4243,
		33,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243034] = {
		4243034,
		0,
		Lang.get(23021),
		4243,
		34,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4243035] = {
		4243035,
		0,
		Lang.get(23022),
		4243,
		35,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4243036] = {
		4243036,
		0,
		Lang.get(23023),
		4243,
		36,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4243037] = {
		4243037,
		0,
		Lang.get(23024),
		4243,
		37,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243038] = {
		4243038,
		0,
		Lang.get(23025),
		4243,
		38,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4243039] = {
		4243039,
		0,
		Lang.get(23026),
		4243,
		39,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4244001] = {
		4244001,
		0,
		Lang.get(23027),
		4244,
		1,
		159,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4244,
		1,
		nil,
		nil,
		1,
		nil,
		4244
	},
	[4244002] = {
		4244002,
		0,
		Lang.get(23028),
		4244,
		2,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4244003] = {
		4244003,
		0,
		Lang.get(55761),
		4244,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4250001] = {
		4250001,
		0,
		Lang.get(23029),
		4250,
		1,
		582,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4243,
		1,
		nil,
		nil,
		1,
		nil,
		4243
	},
	[4250002] = {
		4250002,
		0,
		Lang.get(23030),
		4250,
		2,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4250003] = {
		4250003,
		0,
		Lang.get(23031),
		4250,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250004] = {
		4250004,
		0,
		Lang.get(23032),
		4250,
		4,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250005] = {
		4250005,
		2,
		Lang.get(23033),
		4250,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250006] = {
		4250006,
		2,
		Lang.get(23034),
		4250,
		6,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4250007] = {
		4250007,
		0,
		Lang.get(23035),
		4250,
		7,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250008] = {
		4250008,
		2,
		Lang.get(23036),
		4250,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250009] = {
		4250009,
		0,
		Lang.get(23037),
		4250,
		9,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250010] = {
		4250010,
		0,
		Lang.get(23038),
		4250,
		10,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4250011] = {
		4250011,
		0,
		Lang.get(55762),
		4250,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250012] = {
		4250012,
		0,
		Lang.get(23039),
		4250,
		12,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4250013] = {
		4250013,
		0,
		Lang.get(23040),
		4250,
		13,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250014] = {
		4250014,
		0,
		Lang.get(23041),
		4250,
		14,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4250015] = {
		4250015,
		0,
		Lang.get(23042),
		4250,
		15,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250016] = {
		4250016,
		2,
		Lang.get(23043),
		4250,
		16,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4250017] = {
		4250017,
		0,
		Lang.get(23044),
		4250,
		17,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250018] = {
		4250018,
		0,
		Lang.get(23045),
		4250,
		18,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4250019] = {
		4250019,
		0,
		Lang.get(23046),
		4250,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4250020] = {
		4250020,
		0,
		Lang.get(23047),
		4250,
		20,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4250021] = {
		4250021,
		0,
		Lang.get(23048),
		4250,
		21,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4251001] = {
		4251001,
		0,
		Lang.get(23049),
		4251,
		1,
		159,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4251,
		1,
		nil,
		nil,
		1,
		nil,
		4251
	},
	[4251002] = {
		4251002,
		0,
		Lang.get(23050),
		4251,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4251003] = {
		4251003,
		0,
		Lang.get(23051),
		4251,
		3,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[4251004] = {
		4251004,
		0,
		Lang.get(23052),
		4251,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4251005] = {
		4251005,
		0,
		Lang.get(23053),
		4251,
		5,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[4251006] = {
		4251006,
		0,
		Lang.get(23054),
		4251,
		6,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4251007] = {
		4251007,
		0,
		Lang.get(23055),
		4251,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4253001] = {
		4253001,
		0,
		Lang.get(23056),
		4253,
		1,
		578,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4253,
		1,
		nil,
		nil,
		1,
		nil,
		4253
	},
	[4253002] = {
		4253002,
		0,
		Lang.get(23057),
		4253,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[78]
		}
	},
	[4253003] = {
		4253003,
		0,
		Lang.get(23058),
		4253,
		3,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4253004] = {
		4253004,
		0,
		Lang.get(23059),
		4253,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4253005] = {
		4253005,
		0,
		Lang.get(23060),
		4253,
		5,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4253006] = {
		4253006,
		0,
		Lang.get(23061),
		4253,
		6,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[4253007] = {
		4253007,
		0,
		Lang.get(23062),
		4253,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4253008] = {
		4253008,
		0,
		Lang.get(23063),
		4253,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4253009] = {
		4253009,
		0,
		Lang.get(23064),
		4253,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4253010] = {
		4253010,
		0,
		Lang.get(23065),
		4253,
		10,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4253011] = {
		4253011,
		0,
		Lang.get(23066),
		4253,
		11,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4253012] = {
		4253012,
		2,
		Lang.get(23067),
		4253,
		12,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4260001] = {
		4260001,
		0,
		Lang.get(23068),
		4260,
		1,
		159,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4260,
		1,
		nil,
		nil,
		1,
		nil,
		4260
	},
	[4260002] = {
		4260002,
		0,
		Lang.get(23069),
		4260,
		2,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[6]
		}
	},
	[4260003] = {
		4260003,
		0,
		Lang.get(23070),
		4260,
		3,
		605,
		{
			RTResTalkAction[94]
		}
	},
	[4260004] = {
		4260004,
		0,
		Lang.get(55763),
		4260,
		4,
		583,
		{
			RTResTalkAction[93]
		}
	},
	[4260005] = {
		4260005,
		0,
		Lang.get(23071),
		4260,
		5,
		160,
		{
			RTResTalkAction[94]
		},
		1
	},
	[4260006] = {
		4260006,
		0,
		Lang.get(23072),
		4260,
		6,
		583,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4264,
		1,
		nil,
		nil,
		0
	},
	[4260007] = {
		4260007,
		0,
		Lang.get(23073),
		4260,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[94]
		}
	},
	[4260008] = {
		4260008,
		0,
		Lang.get(23074),
		4260,
		8,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[21]
		}
	},
	[4260009] = {
		4260009,
		0,
		Lang.get(23075),
		4260,
		9,
		159,
		{
			RTResTalkAction[13],
			RTResTalkAction[94]
		}
	},
	[4260010] = {
		4260010,
		0,
		Lang.get(23076),
		4260,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4260011] = {
		4260011,
		2,
		Lang.get(23077),
		4260,
		11,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4261001] = {
		4261001,
		3,
		Lang.get(22977),
		4261,
		1,
		605,
		nil,
		nil,
		nil,
		-1,
		nil,
		59,
		4261,
		1,
		nil,
		nil,
		0,
		nil,
		4261,
		nil,
		nil,
		1
	},
	[4261002] = {
		4261002,
		0,
		Lang.get(23078),
		4261,
		2,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[4261003] = {
		4261003,
		0,
		Lang.get(23079),
		4261,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4261004] = {
		4261004,
		0,
		Lang.get(23080),
		4261,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261005] = {
		4261005,
		0,
		Lang.get(23081),
		4261,
		5,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4261006] = {
		4261006,
		0,
		Lang.get(23082),
		4261,
		6,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261007] = {
		4261007,
		0,
		Lang.get(23083),
		4261,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261008] = {
		4261008,
		0,
		Lang.get(23084),
		4261,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261009] = {
		4261009,
		0,
		Lang.get(23085),
		4261,
		9,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261010] = {
		4261010,
		0,
		Lang.get(23086),
		4261,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261011] = {
		4261011,
		0,
		Lang.get(23087),
		4261,
		11,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261012] = {
		4261012,
		0,
		Lang.get(55764),
		4261,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261013] = {
		4261013,
		0,
		Lang.get(23088),
		4261,
		13,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261014] = {
		4261014,
		0,
		Lang.get(23089),
		4261,
		14,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261015] = {
		4261015,
		0,
		Lang.get(23090),
		4261,
		15,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261016] = {
		4261016,
		0,
		Lang.get(23091),
		4261,
		16,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261017] = {
		4261017,
		0,
		Lang.get(23092),
		4261,
		17,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4261018] = {
		4261018,
		0,
		Lang.get(23093),
		4261,
		18,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261019] = {
		4261019,
		0,
		Lang.get(23094),
		4261,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261020] = {
		4261020,
		0,
		Lang.get(23095),
		4261,
		20,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4261021] = {
		4261021,
		0,
		Lang.get(23096),
		4261,
		21,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261022] = {
		4261022,
		0,
		Lang.get(23097),
		4261,
		22,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261023] = {
		4261023,
		0,
		"……",
		4261,
		23,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261024] = {
		4261024,
		0,
		Lang.get(23098),
		4261,
		24,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4261025] = {
		4261025,
		0,
		Lang.get(23099),
		4261,
		25,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261026] = {
		4261026,
		0,
		Lang.get(23100),
		4261,
		26,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4261027] = {
		4261027,
		0,
		Lang.get(23101),
		4261,
		27,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261028] = {
		4261028,
		0,
		Lang.get(23102),
		4261,
		28,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4261029] = {
		4261029,
		0,
		Lang.get(23103),
		4261,
		29,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4261030] = {
		4261030,
		0,
		Lang.get(23104),
		4261,
		30,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4262001] = {
		4262001,
		2,
		Lang.get(23105),
		4262,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4262,
		1,
		nil,
		nil,
		0,
		nil,
		4262
	},
	[4262002] = {
		4262002,
		0,
		Lang.get(23106),
		4262,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4262003] = {
		4262003,
		0,
		Lang.get(23107),
		4262,
		3,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4262004] = {
		4262004,
		0,
		"……",
		4262,
		4,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4262005] = {
		4262005,
		3,
		Lang.get(23108),
		4262,
		5,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4262006] = {
		4262006,
		0,
		Lang.get(23109),
		4262,
		6,
		583,
		{
			RTResTalkAction[93]
		}
	},
	[4262007] = {
		4262007,
		0,
		Lang.get(23110),
		4262,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[94]
		}
	},
	[4262008] = {
		4262008,
		0,
		Lang.get(23111),
		4262,
		8,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[6]
		}
	},
	[4262009] = {
		4262009,
		0,
		Lang.get(23112),
		4262,
		9,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[94]
		}
	},
	[4262010] = {
		4262010,
		0,
		Lang.get(55765),
		4262,
		10,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[21]
		}
	},
	[4262011] = {
		4262011,
		0,
		Lang.get(23113),
		4262,
		11,
		583,
		{
			RTResTalkAction[93]
		}
	},
	[4262012] = {
		4262012,
		0,
		Lang.get(23114),
		4262,
		12,
		583,
		{
			RTResTalkAction[93]
		}
	},
	[4262013] = {
		4262013,
		0,
		Lang.get(55766),
		4262,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[94]
		}
	},
	[4262014] = {
		4262014,
		0,
		Lang.get(23115),
		4262,
		14,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[2]
		}
	},
	[4262015] = {
		4262015,
		0,
		Lang.get(23116),
		4262,
		15,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[94]
		}
	},
	[4262016] = {
		4262016,
		0,
		Lang.get(23117),
		4262,
		16,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[2]
		}
	},
	[4262017] = {
		4262017,
		0,
		Lang.get(23118),
		4262,
		17,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[94]
		}
	},
	[4262018] = {
		4262018,
		0,
		Lang.get(23119),
		4262,
		18,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[2]
		}
	},
	[4262019] = {
		4262019,
		3,
		Lang.get(23120),
		4262,
		19,
		605,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.5,
		[22] = 1
	},
	[4262020] = {
		4262020,
		0,
		Lang.get(23121),
		4262,
		20,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4263001] = {
		4263001,
		0,
		Lang.get(23122),
		4263,
		1,
		159,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4263,
		1,
		nil,
		nil,
		1,
		nil,
		4260
	},
	[4263002] = {
		4263002,
		0,
		Lang.get(23123),
		4263,
		2,
		583,
		{
			RTResTalkAction[93],
			RTResTalkAction[6]
		}
	},
	[4263003] = {
		4263003,
		0,
		Lang.get(23124),
		4263,
		3,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[94]
		}
	},
	[4263004] = {
		4263004,
		0,
		Lang.get(23125),
		4263,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4270001] = {
		4270001,
		0,
		Lang.get(23126),
		4270,
		1,
		48,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4270,
		1,
		nil,
		nil,
		1,
		nil,
		4270
	},
	[4270002] = {
		4270002,
		0,
		Lang.get(23127),
		4270,
		2,
		621,
		{
			RTResTalkAction[95],
			RTResTalkAction[74]
		}
	},
	[4270003] = {
		4270003,
		0,
		Lang.get(23128),
		4270,
		3,
		620,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[4270004] = {
		4270004,
		0,
		Lang.get(23129),
		4270,
		4,
		621,
		{
			RTResTalkAction[95],
			RTResTalkAction[98]
		}
	},
	[4270005] = {
		4270005,
		0,
		Lang.get(23130),
		4270,
		5,
		48,
		{
			RTResTalkAction[73],
			RTResTalkAction[97]
		}
	},
	[4270006] = {
		4270006,
		0,
		Lang.get(23131),
		4270,
		6,
		48,
		{
			RTResTalkAction[73]
		}
	},
	[4270007] = {
		4270007,
		0,
		Lang.get(23132),
		4270,
		7,
		8,
		{
			RTResTalkAction[99],
			RTResTalkAction[74]
		}
	},
	[4270008] = {
		4270008,
		0,
		Lang.get(23133),
		4270,
		8,
		48,
		{
			RTResTalkAction[73],
			RTResTalkAction[100]
		}
	},
	[4270009] = {
		4270009,
		0,
		Lang.get(23134),
		4270,
		9,
		621,
		{
			RTResTalkAction[95],
			RTResTalkAction[74]
		}
	},
	[4270010] = {
		4270010,
		0,
		Lang.get(23135),
		4270,
		10,
		620,
		{
			RTResTalkAction[96],
			RTResTalkAction[97]
		}
	},
	[4270011] = {
		4270011,
		0,
		Lang.get(55767),
		4270,
		11,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[98]
		}
	},
	[4270012] = {
		4270012,
		0,
		Lang.get(23136),
		4270,
		12,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4271001] = {
		4271001,
		0,
		Lang.get(23137),
		4271,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		4,
		nil,
		14,
		4271,
		1,
		nil,
		nil,
		1,
		nil,
		4271
	},
	[4271002] = {
		4271002,
		0,
		Lang.get(23138),
		4271,
		2,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4271003] = {
		4271003,
		0,
		Lang.get(23139),
		4271,
		3,
		575,
		{
			RTResTalkAction[67]
		}
	},
	[4271004] = {
		4271004,
		0,
		Lang.get(23140),
		4271,
		4,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[68]
		}
	},
	[4271005] = {
		4271005,
		0,
		Lang.get(55768),
		4271,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4271006] = {
		4271006,
		0,
		Lang.get(23142),
		4271,
		6,
		621,
		{
			RTResTalkAction[95],
			RTResTalkAction[2]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4373,
		1,
		1,
		nil,
		nil,
		nil,
		4369
	},
	[4271007] = {
		4271007,
		0,
		Lang.get(23143),
		4271,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[97]
		}
	},
	[4271008] = {
		4271008,
		0,
		Lang.get(23144),
		4271,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4271009] = {
		4271009,
		0,
		Lang.get(23145),
		4271,
		9,
		621,
		{
			RTResTalkAction[95],
			RTResTalkAction[2]
		}
	},
	[4271010] = {
		4271010,
		0,
		Lang.get(23146),
		4271,
		10,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[97]
		}
	},
	[4271011] = {
		4271011,
		0,
		Lang.get(23147),
		4271,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4271012] = {
		4271012,
		0,
		Lang.get(23148),
		4271,
		12,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[2]
		}
	},
	[4271013] = {
		4271013,
		0,
		Lang.get(23149),
		4271,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[68]
		}
	},
	[4271014] = {
		4271014,
		0,
		Lang.get(23150),
		4271,
		14,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4271015] = {
		4271015,
		0,
		Lang.get(23151),
		4271,
		15,
		48,
		{
			RTResTalkAction[73],
			RTResTalkAction[76]
		}
	},
	[4271016] = {
		4271016,
		0,
		Lang.get(23152),
		4271,
		16,
		48,
		{
			RTResTalkAction[73]
		}
	},
	[4271017] = {
		4271017,
		0,
		Lang.get(23153),
		4271,
		17,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[74]
		}
	},
	[4272001] = {
		4272001,
		0,
		Lang.get(55769),
		4272,
		1,
		159,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		4,
		nil,
		59,
		4272,
		nil,
		1,
		nil,
		1,
		nil,
		4272
	},
	[4272002] = {
		4272002,
		0,
		Lang.get(23155),
		4272,
		2,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[4272003] = {
		4272003,
		0,
		Lang.get(23156),
		4272,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4272004] = {
		4272004,
		0,
		Lang.get(23157),
		4272,
		4,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4272005] = {
		4272005,
		0,
		Lang.get(55770),
		4272,
		5,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4272006] = {
		4272006,
		0,
		Lang.get(23158),
		4272,
		6,
		158,
		{
			RTResTalkAction[11],
			RTResTalkAction[21]
		}
	},
	[4272007] = {
		4272007,
		0,
		Lang.get(23159),
		4272,
		7,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4272008] = {
		4272008,
		0,
		Lang.get(23160),
		4272,
		8,
		160,
		{
			RTResTalkAction[19]
		}
	},
	[4280001] = {
		4280001,
		0,
		Lang.get(23161),
		4280,
		1,
		158,
		nil,
		1,
		3,
		nil,
		nil,
		59,
		4280,
		1,
		nil,
		nil,
		nil,
		nil,
		4280
	},
	[4280002] = {
		4280002,
		2,
		Lang.get(23162),
		4280,
		2,
		158,
		nil,
		1
	},
	[4280003] = {
		4280003,
		2,
		Lang.get(23163),
		4280,
		3,
		158,
		nil,
		1,
		[19] = 4281
	},
	[4280004] = {
		4280004,
		2,
		Lang.get(23164),
		4280,
		4,
		158,
		nil,
		1,
		0
	},
	[4280005] = {
		4280005,
		0,
		"……",
		4280,
		5,
		158,
		nil,
		1,
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
		4282
	},
	[4280006] = {
		4280006,
		2,
		Lang.get(23165),
		4280,
		6,
		158,
		nil,
		1
	},
	[4280007] = {
		4280007,
		2,
		Lang.get(23166),
		4280,
		7,
		158,
		nil,
		1
	},
	[4280008] = {
		4280008,
		0,
		Lang.get(23167),
		4280,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280009] = {
		4280009,
		3,
		Lang.get(23168),
		4280,
		9,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4280010] = {
		4280010,
		4,
		nil,
		4280,
		10,
		605,
		[29] = {
			{
				id = 4280011,
				branch_content = Lang.get(42603)
			}
		}
	},
	[4280011] = {
		4280011,
		3,
		Lang.get(23170),
		4280,
		11,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		4282,
		[19] = 4282,
		[22] = 1
	},
	[4280012] = {
		4280012,
		0,
		Lang.get(23171),
		4280,
		12,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280013] = {
		4280013,
		4,
		nil,
		4280,
		13,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280014,
				branch_content = Lang.get(42604)
			}
		}
	},
	[4280014] = {
		4280014,
		3,
		Lang.get(23173),
		4280,
		14,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4280015] = {
		4280015,
		3,
		Lang.get(23174),
		4280,
		15,
		605,
		[22] = 1
	},
	[4280016] = {
		4280016,
		3,
		Lang.get(23175),
		4280,
		16,
		605,
		[22] = 1
	},
	[4280017] = {
		4280017,
		3,
		Lang.get(23176),
		4280,
		17,
		605,
		[22] = 1
	},
	[4280018] = {
		4280018,
		4,
		nil,
		4280,
		18,
		605,
		[29] = {
			{
				id = 4280022,
				branch_content = Lang.get(42605)
			},
			{
				id = 4280019,
				branch_content = Lang.get(42606)
			}
		}
	},
	[4280019] = {
		4280019,
		0,
		Lang.get(55771),
		4280,
		19,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280020] = {
		4280020,
		3,
		Lang.get(23179),
		4280,
		20,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4280021] = {
		4280021,
		0,
		Lang.get(23180),
		4280,
		21,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280022] = {
		4280022,
		0,
		Lang.get(55772),
		4280,
		22,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280023] = {
		4280023,
		4,
		nil,
		4280,
		23,
		158,
		{
			RTResTalkAction[3]
		},
		[19] = 4282,
		[29] = {
			{
				id = 4280024,
				branch_content = Lang.get(42607)
			}
		}
	},
	[4280024] = {
		4280024,
		0,
		Lang.get(23182),
		4280,
		24,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280025] = {
		4280025,
		4,
		nil,
		4280,
		25,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280026,
				branch_content = Lang.get(42608)
			},
			{
				id = 4280028,
				branch_content = Lang.get(42609)
			}
		}
	},
	[4280026] = {
		4280026,
		0,
		Lang.get(23184),
		4280,
		26,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280027] = {
		4280027,
		4,
		nil,
		4280,
		27,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280029,
				branch_content = "……"
			}
		}
	},
	[4280028] = {
		4280028,
		0,
		Lang.get(23186),
		4280,
		28,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4280029] = {
		4280029,
		0,
		Lang.get(23187),
		4280,
		29,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280030] = {
		4280030,
		0,
		Lang.get(23188),
		4280,
		30,
		158,
		{
			RTResTalkAction[101]
		}
	},
	[4280031] = {
		4280031,
		0,
		Lang.get(23189),
		4280,
		31,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280032] = {
		4280032,
		4,
		nil,
		4280,
		32,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280033,
				branch_content = Lang.get(42610)
			}
		}
	},
	[4280033] = {
		4280033,
		0,
		Lang.get(23191),
		4280,
		33,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280034] = {
		4280034,
		0,
		"……",
		4280,
		34,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280035] = {
		4280035,
		0,
		Lang.get(23192),
		4280,
		35,
		158,
		{
			RTResTalkAction[32]
		}
	},
	[4280036] = {
		4280036,
		4,
		nil,
		4280,
		36,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280037,
				branch_content = Lang.get(42611)
			}
		}
	},
	[4280037] = {
		4280037,
		0,
		Lang.get(23194),
		4280,
		37,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280038] = {
		4280038,
		0,
		Lang.get(55773),
		4280,
		38,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280039] = {
		4280039,
		4,
		nil,
		4280,
		39,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280040,
				branch_content = Lang.get(42612)
			}
		}
	},
	[4280040] = {
		4280040,
		0,
		Lang.get(23196),
		4280,
		40,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280041] = {
		4280041,
		4,
		nil,
		4280,
		41,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280042,
				branch_content = Lang.get(42613)
			}
		}
	},
	[4280042] = {
		4280042,
		0,
		Lang.get(23198),
		4280,
		42,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280043] = {
		4280043,
		0,
		Lang.get(23199),
		4280,
		43,
		158,
		{
			RTResTalkAction[101]
		}
	},
	[4280044] = {
		4280044,
		4,
		nil,
		4280,
		44,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280045,
				branch_content = Lang.get(42614)
			},
			{
				id = 4280047,
				branch_content = Lang.get(42615)
			}
		}
	},
	[4280045] = {
		4280045,
		0,
		Lang.get(23201),
		4280,
		45,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280046] = {
		4280046,
		4,
		nil,
		4280,
		46,
		158,
		{
			RTResTalkAction[26]
		},
		[29] = {
			{
				id = 4280048,
				branch_content = "……"
			}
		}
	},
	[4280047] = {
		4280047,
		0,
		Lang.get(23203),
		4280,
		47,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280048] = {
		4280048,
		2,
		Lang.get(23204),
		4280,
		48,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280049] = {
		4280049,
		2,
		Lang.get(23205),
		4280,
		49,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280050] = {
		4280050,
		4,
		nil,
		4280,
		50,
		300,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280051,
				branch_content = Lang.get(42616)
			},
			{
				id = 4280055,
				branch_content = Lang.get(42617)
			}
		}
	},
	[4280051] = {
		4280051,
		0,
		Lang.get(23207),
		4280,
		51,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4280052] = {
		4280052,
		0,
		Lang.get(23208),
		4280,
		52,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280053] = {
		4280053,
		0,
		Lang.get(23209),
		4280,
		53,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280054] = {
		4280054,
		4,
		nil,
		4280,
		54,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280058,
				branch_content = "……"
			}
		}
	},
	[4280055] = {
		4280055,
		0,
		Lang.get(23211),
		4280,
		55,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280056] = {
		4280056,
		0,
		Lang.get(23212),
		4280,
		56,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4280057] = {
		4280057,
		0,
		Lang.get(23213),
		4280,
		57,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280058] = {
		4280058,
		0,
		Lang.get(23214),
		4280,
		58,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280059] = {
		4280059,
		0,
		Lang.get(23215),
		4280,
		59,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280060] = {
		4280060,
		0,
		Lang.get(23216),
		4280,
		60,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280061] = {
		4280061,
		0,
		Lang.get(23217),
		4280,
		61,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280062] = {
		4280062,
		0,
		Lang.get(23218),
		4280,
		62,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280063] = {
		4280063,
		0,
		Lang.get(23219),
		4280,
		63,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280064] = {
		4280064,
		2,
		Lang.get(23220),
		4280,
		64,
		158,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[4280065] = {
		4280065,
		2,
		Lang.get(23221),
		4280,
		65,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280066] = {
		4280066,
		0,
		Lang.get(23222),
		4280,
		66,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4280067] = {
		4280067,
		0,
		Lang.get(23223),
		4280,
		67,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4280068] = {
		4280068,
		0,
		Lang.get(23224),
		4280,
		68,
		158,
		{
			RTResTalkAction[101]
		}
	},
	[4280069] = {
		4280069,
		4,
		nil,
		4280,
		69,
		158,
		{
			RTResTalkAction[101]
		},
		[29] = {
			{
				id = 4280070,
				branch_content = Lang.get(42618)
			},
			{
				id = 4280073,
				branch_content = Lang.get(42619)
			}
		}
	},
	[4280070] = {
		4280070,
		0,
		Lang.get(23226),
		4280,
		70,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4280071] = {
		4280071,
		0,
		Lang.get(23227),
		4280,
		71,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280072] = {
		4280072,
		4,
		nil,
		4280,
		72,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280076,
				branch_content = "……"
			}
		}
	},
	[4280073] = {
		4280073,
		0,
		Lang.get(23229),
		4280,
		73,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4280074] = {
		4280074,
		0,
		Lang.get(23230),
		4280,
		74,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280075] = {
		4280075,
		0,
		Lang.get(23231),
		4280,
		75,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280076] = {
		4280076,
		0,
		Lang.get(23232),
		4280,
		76,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280077] = {
		4280077,
		0,
		Lang.get(55774),
		4280,
		77,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[4280078] = {
		4280078,
		0,
		Lang.get(23234),
		4280,
		78,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280079] = {
		4280079,
		0,
		"……",
		4280,
		79,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280080] = {
		4280080,
		0,
		"……",
		4280,
		80,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280081] = {
		4280081,
		0,
		Lang.get(23235),
		4280,
		81,
		158,
		{
			RTResTalkAction[26]
		}
	},
	[4280082] = {
		4280082,
		4,
		nil,
		4280,
		82,
		158,
		{
			RTResTalkAction[26]
		},
		[29] = {
			{
				id = 4280083,
				branch_content = Lang.get(42620)
			}
		}
	},
	[4280083] = {
		4280083,
		0,
		Lang.get(23237),
		4280,
		83,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4280084] = {
		4280084,
		4,
		nil,
		4280,
		84,
		158,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 4280085,
				branch_content = Lang.get(42621)
			}
		}
	},
	[4280085] = {
		4280085,
		0,
		"……",
		4280,
		85,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280086] = {
		4280086,
		4,
		nil,
		4280,
		86,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280087,
				branch_content = Lang.get(42622)
			}
		}
	},
	[4280087] = {
		4280087,
		0,
		"……",
		4280,
		87,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4280088] = {
		4280088,
		4,
		nil,
		4280,
		88,
		158,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 4280089,
				branch_content = Lang.get(42623)
			}
		}
	},
	[4280089] = {
		4280089,
		0,
		Lang.get(23241),
		4280,
		89,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4280090] = {
		4280090,
		4,
		nil,
		4280,
		90,
		158,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 4280091,
				branch_content = Lang.get(42624)
			}
		}
	},
	[4280091] = {
		4280091,
		0,
		"……",
		4280,
		91,
		158,
		{
			RTResTalkAction[26]
		},
		[24] = 1
	},
	[4280092] = {
		4280092,
		0,
		Lang.get(23243),
		4280,
		92,
		158,
		{
			RTResTalkAction[8]
		}
	},
	[4280093] = {
		4280093,
		4,
		nil,
		4280,
		93,
		158,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 4280094,
				branch_content = Lang.get(42625)
			},
			{
				id = 4280094,
				branch_content = Lang.get(42626)
			}
		}
	},
	[4280094] = {
		4280094,
		0,
		"……",
		4280,
		94,
		158,
		{
			RTResTalkAction[11]
		}
	},
	[4290001] = {
		4290001,
		3,
		Lang.get(23245),
		4290,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		4408,
		[19] = 4242,
		[22] = 1
	},
	[4290002] = {
		4290002,
		3,
		Lang.get(23246),
		4290,
		2,
		605,
		[22] = 1
	},
	[4290003] = {
		4290003,
		3,
		Lang.get(23247),
		4290,
		3,
		605,
		[22] = 1
	},
	[4290004] = {
		4290004,
		0,
		Lang.get(23248),
		4290,
		4,
		619,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1
	},
	[4290005] = {
		4290005,
		0,
		Lang.get(23249),
		4290,
		5,
		619,
		{
			RTResTalkAction[102]
		}
	},
	[4290006] = {
		4290006,
		0,
		Lang.get(23250),
		4290,
		6,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[103]
		}
	},
	[4290007] = {
		4290007,
		0,
		Lang.get(23251),
		4290,
		7,
		619,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[4290008] = {
		4290008,
		0,
		Lang.get(23252),
		4290,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[103]
		}
	},
	[4290009] = {
		4290009,
		0,
		Lang.get(23253),
		4290,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4290010] = {
		4290010,
		0,
		Lang.get(23254),
		4290,
		10,
		619,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[4290011] = {
		4290011,
		0,
		Lang.get(23255),
		4290,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[103]
		}
	},
	[4290012] = {
		4290012,
		0,
		Lang.get(23256),
		4290,
		12,
		619,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[4290013] = {
		4290013,
		0,
		Lang.get(23257),
		4290,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[103]
		}
	},
	[4290014] = {
		4290014,
		0,
		Lang.get(23258),
		4290,
		14,
		619,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[4290015] = {
		4290015,
		0,
		Lang.get(23259),
		4290,
		15,
		619,
		{
			RTResTalkAction[102]
		}
	},
	[4290016] = {
		4290016,
		0,
		Lang.get(23260),
		4290,
		16,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[103]
		}
	},
	[4290017] = {
		4290017,
		0,
		Lang.get(23261),
		4290,
		17,
		619,
		{
			RTResTalkAction[102],
			RTResTalkAction[2]
		}
	},
	[4290018] = {
		4290018,
		3,
		Lang.get(23262),
		4290,
		18,
		605,
		{
			RTResTalkAction[103]
		},
		[22] = 1
	},
	[4291001] = {
		4291001,
		0,
		Lang.get(23263),
		4291,
		1,
		20,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		4,
		nil,
		58,
		4383,
		1,
		nil,
		nil,
		0,
		nil,
		4372
	},
	[4291002] = {
		4291002,
		0,
		Lang.get(23264),
		4291,
		2,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[16]
		}
	},
	[4291003] = {
		4291003,
		0,
		Lang.get(23265),
		4291,
		3,
		575,
		{
			RTResTalkAction[67],
			RTResTalkAction[105]
		}
	},
	[4291004] = {
		4291004,
		0,
		Lang.get(23266),
		4291,
		4,
		15,
		{
			RTResTalkAction[106],
			RTResTalkAction[68]
		}
	},
	[4291005] = {
		4291005,
		0,
		Lang.get(23267),
		4291,
		5,
		53,
		{
			RTResTalkAction[107],
			RTResTalkAction[108]
		}
	},
	[4291006] = {
		4291006,
		0,
		Lang.get(23268),
		4291,
		6,
		158,
		{
			RTResTalkAction[109],
			RTResTalkAction[110]
		}
	},
	[4291007] = {
		4291007,
		3,
		Lang.get(23269),
		4291,
		7,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4291008] = {
		4291008,
		3,
		Lang.get(23270),
		4291,
		8,
		605,
		[22] = 1
	},
	[4292001] = {
		4292001,
		2,
		Lang.get(23271),
		4292,
		1,
		158,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		58,
		nil,
		1,
		[19] = 4403,
		[17] = 0
	},
	[4292002] = {
		4292002,
		2,
		Lang.get(23272),
		4292,
		2,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292003] = {
		4292003,
		2,
		Lang.get(23273),
		4292,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292004] = {
		4292004,
		2,
		Lang.get(23274),
		4292,
		4,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292005] = {
		4292005,
		0,
		"……",
		4292,
		5,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292006] = {
		4292006,
		0,
		Lang.get(23275),
		4292,
		6,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292007] = {
		4292007,
		3,
		Lang.get(23276),
		4292,
		7,
		605,
		{
			RTResTalkAction[2]
		},
		[22] = 1
	},
	[4292008] = {
		4292008,
		0,
		Lang.get(23277),
		4292,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292009] = {
		4292009,
		0,
		"……",
		4292,
		9,
		159,
		{
			RTResTalkAction[13],
			RTResTalkAction[2]
		}
	},
	[4292010] = {
		4292010,
		0,
		Lang.get(23278),
		4292,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4292011] = {
		4292011,
		0,
		Lang.get(23279),
		4292,
		11,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292012] = {
		4292012,
		0,
		Lang.get(23280),
		4292,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4292013] = {
		4292013,
		0,
		Lang.get(23281),
		4292,
		13,
		159,
		{
			RTResTalkAction[111],
			RTResTalkAction[2]
		}
	},
	[4292014] = {
		4292014,
		0,
		Lang.get(23282),
		4292,
		14,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4292015] = {
		4292015,
		0,
		Lang.get(23283),
		4292,
		15,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292016] = {
		4292016,
		0,
		Lang.get(23284),
		4292,
		16,
		158,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[4292017] = {
		4292017,
		0,
		Lang.get(23285),
		4292,
		17,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292018] = {
		4292018,
		0,
		Lang.get(23286),
		4292,
		18,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4292019] = {
		4292019,
		0,
		Lang.get(23287),
		4292,
		19,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292020] = {
		4292020,
		0,
		Lang.get(23288),
		4292,
		20,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292021] = {
		4292021,
		0,
		Lang.get(23289),
		4292,
		21,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4292022] = {
		4292022,
		0,
		Lang.get(23290),
		4292,
		22,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292023] = {
		4292023,
		0,
		Lang.get(23291),
		4292,
		23,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292024] = {
		4292024,
		3,
		Lang.get(23292),
		4292,
		24,
		159,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		0,
		nil,
		4410,
		nil,
		605,
		1
	},
	[4292025] = {
		4292025,
		2,
		Lang.get(55775),
		4292,
		25,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 4411,
		[17] = 0
	},
	[4292026] = {
		4292026,
		0,
		Lang.get(23293),
		4292,
		26,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4292027] = {
		4292027,
		0,
		Lang.get(23294),
		4292,
		27,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4292028] = {
		4292028,
		0,
		Lang.get(23295),
		4292,
		28,
		20,
		{
			RTResTalkAction[6]
		},
		1
	},
	[4292029] = {
		4292029,
		0,
		Lang.get(23296),
		4292,
		29,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4294001] = {
		4294001,
		0,
		Lang.get(23297),
		4294,
		1,
		20,
		{
			RTResTalkAction[14]
		},
		1,
		nil,
		4,
		nil,
		69,
		4294,
		1,
		nil,
		nil,
		0,
		nil,
		4294
	},
	[4294002] = {
		4294002,
		0,
		Lang.get(23298),
		4294,
		2,
		10,
		{
			RTResTalkAction[112],
			RTResTalkAction[16]
		}
	},
	[4294003] = {
		4294003,
		0,
		Lang.get(23299),
		4294,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[113]
		}
	},
	[4294004] = {
		4294004,
		0,
		Lang.get(23300),
		4294,
		4,
		8,
		{
			RTResTalkAction[99],
			RTResTalkAction[2]
		}
	},
	[4294005] = {
		4294005,
		0,
		Lang.get(23301),
		4294,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[100]
		}
	},
	[4294006] = {
		4294006,
		0,
		Lang.get(23302),
		4294,
		6,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4295001] = {
		4295001,
		0,
		Lang.get(23303),
		4295,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		69,
		4295,
		1,
		nil,
		nil,
		0,
		nil,
		4295
	},
	[4295002] = {
		4295002,
		0,
		Lang.get(23304),
		4295,
		2,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4295003] = {
		4295003,
		0,
		Lang.get(23305),
		4295,
		3,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4295004] = {
		4295004,
		0,
		Lang.get(23306),
		4295,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4300001] = {
		4300001,
		0,
		Lang.get(23307),
		4300,
		1,
		20,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4300,
		1,
		nil,
		nil,
		nil,
		nil,
		4300
	},
	[4300002] = {
		4300002,
		0,
		Lang.get(23308),
		4300,
		2,
		41,
		{
			RTResTalkAction[114],
			RTResTalkAction[16]
		}
	},
	[4300003] = {
		4300003,
		0,
		Lang.get(23309),
		4300,
		3,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[115]
		}
	},
	[4300004] = {
		4300004,
		0,
		Lang.get(23310),
		4300,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[71]
		}
	},
	[4300005] = {
		4300005,
		0,
		Lang.get(23311),
		4300,
		5,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[21]
		}
	},
	[4300006] = {
		4300006,
		0,
		Lang.get(23312),
		4300,
		6,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[16]
		}
	},
	[4300007] = {
		4300007,
		0,
		Lang.get(23313),
		4300,
		7,
		612,
		{
			RTResTalkAction[69]
		}
	},
	[4300008] = {
		4300008,
		0,
		Lang.get(23314),
		4300,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[71]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4380,
		1,
		1,
		nil,
		nil,
		nil,
		4380
	},
	[4300009] = {
		4300009,
		0,
		Lang.get(23315),
		4300,
		9,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[2]
		}
	},
	[4300010] = {
		4300010,
		0,
		Lang.get(23316),
		4300,
		10,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[16]
		}
	},
	[4300011] = {
		4300011,
		0,
		Lang.get(23317),
		4300,
		11,
		41,
		{
			RTResTalkAction[114],
			RTResTalkAction[71]
		}
	},
	[4300012] = {
		4300012,
		2,
		Lang.get(23318),
		4300,
		12,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[115]
		}
	},
	[4300013] = {
		4300013,
		2,
		Lang.get(23319),
		4300,
		13,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4300014] = {
		4300014,
		0,
		Lang.get(23320),
		4300,
		14,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4300015] = {
		4300015,
		0,
		Lang.get(23321),
		4300,
		15,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4300016] = {
		4300016,
		0,
		Lang.get(23322),
		4300,
		16,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[2]
		}
	},
	[4300017] = {
		4300017,
		0,
		Lang.get(23323),
		4300,
		17,
		41,
		{
			RTResTalkAction[114],
			RTResTalkAction[16]
		}
	},
	[4300018] = {
		4300018,
		0,
		Lang.get(23324),
		4300,
		18,
		612,
		{
			RTResTalkAction[69],
			RTResTalkAction[115]
		}
	},
	[4300019] = {
		4300019,
		2,
		Lang.get(23325),
		4300,
		19,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[71]
		}
	},
	[4300020] = {
		4300020,
		0,
		Lang.get(23326),
		4300,
		20,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4300021] = {
		4300021,
		0,
		Lang.get(23327),
		4300,
		21,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[76]
		}
	},
	[4300022] = {
		4300022,
		0,
		Lang.get(23328),
		4300,
		22,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[4300023] = {
		4300023,
		0,
		"……",
		4300,
		23,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4300024] = {
		4300024,
		0,
		"……",
		4300,
		24,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4301001] = {
		4301001,
		0,
		Lang.get(23329),
		4301,
		1,
		576,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4301,
		1,
		nil,
		nil,
		nil,
		nil,
		4301
	},
	[4301002] = {
		4301002,
		0,
		"……",
		4301,
		2,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4301003] = {
		4301003,
		0,
		Lang.get(23330),
		4301,
		3,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301004] = {
		4301004,
		0,
		Lang.get(23331),
		4301,
		4,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4301005] = {
		4301005,
		0,
		Lang.get(23332),
		4301,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4301006] = {
		4301006,
		0,
		Lang.get(23333),
		4301,
		6,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4301007] = {
		4301007,
		0,
		Lang.get(23334),
		4301,
		7,
		41,
		{
			RTResTalkAction[114],
			RTResTalkAction[76]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4375,
		1,
		1,
		nil,
		nil,
		nil,
		4371
	},
	[4301008] = {
		4301008,
		0,
		Lang.get(23335),
		4301,
		8,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[115]
		}
	},
	[4301009] = {
		4301009,
		0,
		Lang.get(23336),
		4301,
		9,
		55,
		{
			RTResTalkAction[116],
			RTResTalkAction[82]
		}
	},
	[4301010] = {
		4301010,
		0,
		Lang.get(23337),
		4301,
		10,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[117]
		}
	},
	[4301011] = {
		4301011,
		0,
		Lang.get(23338),
		4301,
		11,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[4301012] = {
		4301012,
		0,
		Lang.get(23339),
		4301,
		12,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4301013] = {
		4301013,
		0,
		Lang.get(23340),
		4301,
		13,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[76]
		}
	},
	[4301014] = {
		4301014,
		0,
		Lang.get(23341),
		4301,
		14,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301015] = {
		4301015,
		0,
		Lang.get(23342),
		4301,
		15,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301016] = {
		4301016,
		0,
		Lang.get(23343),
		4301,
		16,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301017] = {
		4301017,
		0,
		Lang.get(23344),
		4301,
		17,
		55,
		{
			RTResTalkAction[116],
			RTResTalkAction[2]
		}
	},
	[4301018] = {
		4301018,
		0,
		Lang.get(23345),
		4301,
		18,
		55,
		{
			RTResTalkAction[116]
		}
	},
	[4301019] = {
		4301019,
		0,
		Lang.get(23346),
		4301,
		19,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[117]
		}
	},
	[4301020] = {
		4301020,
		0,
		Lang.get(23347),
		4301,
		20,
		615,
		{
			RTResTalkAction[80]
		}
	},
	[4301021] = {
		4301021,
		0,
		Lang.get(22701),
		4301,
		21,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[82]
		}
	},
	[4301022] = {
		4301022,
		0,
		Lang.get(23348),
		4301,
		22,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[4301023] = {
		4301023,
		0,
		Lang.get(23349),
		4301,
		23,
		41,
		{
			RTResTalkAction[114],
			RTResTalkAction[82]
		}
	},
	[4301024] = {
		4301024,
		0,
		Lang.get(23350),
		4301,
		24,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[115]
		}
	},
	[4301025] = {
		4301025,
		0,
		Lang.get(23351),
		4301,
		25,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[16]
		}
	},
	[4301026] = {
		4301026,
		0,
		Lang.get(23352),
		4301,
		26,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[82]
		}
	},
	[4301027] = {
		4301027,
		0,
		Lang.get(22701),
		4301,
		27,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301028] = {
		4301028,
		0,
		Lang.get(22701),
		4301,
		28,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4301029] = {
		4301029,
		0,
		Lang.get(23353),
		4301,
		29,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[4301030] = {
		4301030,
		0,
		Lang.get(23354),
		4301,
		30,
		20,
		{
			RTResTalkAction[14],
			RTResTalkAction[82]
		}
	},
	[4301031] = {
		4301031,
		0,
		Lang.get(23355),
		4301,
		31,
		55,
		{
			RTResTalkAction[116],
			RTResTalkAction[16]
		}
	},
	[4301032] = {
		4301032,
		0,
		Lang.get(23356),
		4301,
		32,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[117]
		},
		nil,
		nil,
		4,
		nil,
		nil,
		4302,
		1,
		1,
		nil,
		nil,
		nil,
		4302
	},
	[4301033] = {
		4301033,
		0,
		Lang.get(23357),
		4301,
		33,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4303001] = {
		4303001,
		0,
		Lang.get(23358),
		4303,
		1,
		160,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4303,
		1,
		nil,
		nil,
		nil,
		nil,
		4303
	},
	[4303002] = {
		4303002,
		0,
		Lang.get(23359),
		4303,
		2,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4303003] = {
		4303003,
		0,
		Lang.get(23360),
		4303,
		3,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[6]
		}
	},
	[4303004] = {
		4303004,
		0,
		Lang.get(23361),
		4303,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[76]
		}
	},
	[4303005] = {
		4303005,
		0,
		Lang.get(23362),
		4303,
		5,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[21]
		}
	},
	[4303006] = {
		4303006,
		0,
		Lang.get(23363),
		4303,
		6,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4303007] = {
		4303007,
		0,
		Lang.get(23364),
		4303,
		7,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4303008] = {
		4303008,
		0,
		Lang.get(23365),
		4303,
		8,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4303009] = {
		4303009,
		0,
		Lang.get(23366),
		4303,
		9,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4303010] = {
		4303010,
		0,
		Lang.get(23367),
		4303,
		10,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4304001] = {
		4304001,
		0,
		Lang.get(23368),
		4304,
		1,
		55,
		{
			RTResTalkAction[116]
		},
		nil,
		nil,
		4,
		nil,
		62,
		4303,
		1,
		nil,
		nil,
		nil,
		nil,
		4303
	},
	[4304002] = {
		4304002,
		0,
		Lang.get(23369),
		4304,
		2,
		615,
		{
			RTResTalkAction[80],
			RTResTalkAction[117]
		}
	},
	[4304003] = {
		4304003,
		0,
		Lang.get(23370),
		4304,
		3,
		158,
		{
			RTResTalkAction[26],
			RTResTalkAction[82]
		}
	},
	[4304004] = {
		4304004,
		0,
		Lang.get(23371),
		4304,
		4,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4304005] = {
		4304005,
		0,
		Lang.get(23372),
		4304,
		5,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4304006] = {
		4304006,
		0,
		Lang.get(23373),
		4304,
		6,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4304007] = {
		4304007,
		0,
		Lang.get(23374),
		4304,
		7,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[21]
		}
	},
	[4304008] = {
		4304008,
		0,
		Lang.get(23375),
		4304,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4304009] = {
		4304009,
		0,
		Lang.get(23376),
		4304,
		9,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4304010] = {
		4304010,
		0,
		Lang.get(23377),
		4304,
		10,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[6]
		}
	},
	[4304011] = {
		4304011,
		0,
		Lang.get(23378),
		4304,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4304012] = {
		4304012,
		0,
		Lang.get(23379),
		4304,
		12,
		159,
		{
			RTResTalkAction[45],
			RTResTalkAction[2]
		}
	},
	[4304013] = {
		4304013,
		5,
		Lang.get(23380),
		4304,
		13,
		158,
		{
			RTResTalkAction[118],
			RTResTalkAction[6]
		}
	},
	[4310001] = {
		4310001,
		0,
		Lang.get(23381),
		4310,
		1,
		159,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		4,
		nil,
		60,
		4407,
		1,
		nil,
		nil,
		1,
		nil,
		4407
	},
	[4310002] = {
		4310002,
		0,
		Lang.get(23382),
		4310,
		2,
		158,
		{
			RTResTalkAction[64],
			RTResTalkAction[6]
		}
	},
	[4310003] = {
		4310003,
		0,
		Lang.get(23383),
		4310,
		3,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4310004] = {
		4310004,
		0,
		"9",
		4310,
		4,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[6]
		}
	},
	[4310005] = {
		4310005,
		0,
		"10",
		4310,
		5,
		30,
		{
			RTResTalkAction[119],
			RTResTalkAction[105]
		}
	},
	[4310006] = {
		4310006,
		0,
		"J",
		4310,
		6,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[120]
		}
	},
	[4310007] = {
		4310007,
		0,
		"Q",
		4310,
		7,
		30,
		{
			RTResTalkAction[119],
			RTResTalkAction[105]
		}
	},
	[4310008] = {
		4310008,
		0,
		Lang.get(23384),
		4310,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[120]
		}
	},
	[4310009] = {
		4310009,
		0,
		Lang.get(23385),
		4310,
		9,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[2]
		}
	},
	[4310010] = {
		4310010,
		0,
		Lang.get(23386),
		4310,
		10,
		30,
		{
			RTResTalkAction[119],
			RTResTalkAction[105]
		}
	},
	[4310011] = {
		4310011,
		0,
		Lang.get(23387),
		4310,
		11,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[120]
		}
	},
	[4310012] = {
		4310012,
		0,
		Lang.get(23388),
		4310,
		12,
		30,
		{
			RTResTalkAction[119],
			RTResTalkAction[105]
		}
	},
	[4310013] = {
		4310013,
		0,
		Lang.get(23389),
		4310,
		13,
		29,
		{
			RTResTalkAction[104],
			RTResTalkAction[120]
		}
	},
	[4320001] = {
		4320001,
		0,
		Lang.get(23390),
		4320,
		1,
		158,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		4,
		nil,
		69,
		4320,
		1,
		nil,
		nil,
		1,
		nil,
		4320
	},
	[4320002] = {
		4320002,
		0,
		Lang.get(23391),
		4320,
		2,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[2]
		}
	},
	[4320003] = {
		4320003,
		0,
		Lang.get(23392),
		4320,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4320004] = {
		4320004,
		0,
		Lang.get(23393),
		4320,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4330001] = {
		4330001,
		0,
		Lang.get(23394),
		4330,
		1,
		578,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4330,
		1,
		nil,
		nil,
		1,
		nil,
		4330
	},
	[4330002] = {
		4330002,
		0,
		Lang.get(23395),
		4330,
		2,
		159,
		{
			RTResTalkAction[53],
			RTResTalkAction[78]
		}
	},
	[4330003] = {
		4330003,
		0,
		Lang.get(23396),
		4330,
		3,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[6]
		}
	},
	[4330004] = {
		4330004,
		0,
		Lang.get(23397),
		4330,
		4,
		582,
		{
			RTResTalkAction[84]
		}
	},
	[4330005] = {
		4330005,
		0,
		Lang.get(23398),
		4330,
		5,
		158,
		{
			RTResTalkAction[65],
			RTResTalkAction[86]
		}
	},
	[4330006] = {
		4330006,
		0,
		Lang.get(23399),
		4330,
		6,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4330007] = {
		4330007,
		0,
		Lang.get(23400),
		4330,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4331001] = {
		4331001,
		0,
		Lang.get(23401),
		4331,
		1,
		158,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		4,
		nil,
		65,
		4331,
		1,
		nil,
		nil,
		1,
		nil,
		4331
	},
	[4331002] = {
		4331002,
		0,
		Lang.get(23402),
		4331,
		2,
		582,
		{
			RTResTalkAction[84],
			RTResTalkAction[2]
		}
	},
	[4331003] = {
		4331003,
		0,
		Lang.get(23403),
		4331,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[86]
		}
	},
	[4331004] = {
		4331004,
		0,
		Lang.get(23404),
		4331,
		4,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4331005] = {
		4331005,
		0,
		Lang.get(23405),
		4331,
		5,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4331006] = {
		4331006,
		0,
		Lang.get(23406),
		4331,
		6,
		159,
		{
			RTResTalkAction[50],
			RTResTalkAction[2]
		}
	},
	[4331007] = {
		4331007,
		0,
		Lang.get(23407),
		4331,
		7,
		159,
		{
			RTResTalkAction[5]
		}
	},
	[4331008] = {
		4331008,
		0,
		"！！！",
		4331,
		8,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4331009] = {
		4331009,
		0,
		Lang.get(23408),
		4331,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4331010] = {
		4331010,
		0,
		Lang.get(23409),
		4331,
		10,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4331011] = {
		4331011,
		0,
		Lang.get(23410),
		4331,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4340001] = {
		4340001,
		0,
		Lang.get(23411),
		4340,
		1,
		158,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		4,
		nil,
		69,
		4340,
		1,
		nil,
		nil,
		1,
		nil,
		4340
	},
	[4340002] = {
		4340002,
		0,
		Lang.get(22701),
		4340,
		2,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340003] = {
		4340003,
		0,
		Lang.get(55776),
		4340,
		3,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[4340004] = {
		4340004,
		0,
		Lang.get(23412),
		4340,
		4,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4340005] = {
		4340005,
		0,
		Lang.get(23413),
		4340,
		5,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340006] = {
		4340006,
		0,
		Lang.get(23414),
		4340,
		6,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4340007] = {
		4340007,
		0,
		Lang.get(23415),
		4340,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4340008] = {
		4340008,
		0,
		Lang.get(23416),
		4340,
		8,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340009] = {
		4340009,
		0,
		Lang.get(23417),
		4340,
		9,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340010] = {
		4340010,
		0,
		Lang.get(23418),
		4340,
		10,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4340011] = {
		4340011,
		0,
		Lang.get(23419),
		4340,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4340012] = {
		4340012,
		0,
		Lang.get(23420),
		4340,
		12,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340013] = {
		4340013,
		0,
		Lang.get(23421),
		4340,
		13,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340014] = {
		4340014,
		0,
		Lang.get(23422),
		4340,
		14,
		158,
		{
			RTResTalkAction[3]
		}
	},
	[4340015] = {
		4340015,
		0,
		Lang.get(23423),
		4340,
		15,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4341001] = {
		4341001,
		0,
		Lang.get(23424),
		4341,
		1,
		158,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		4,
		nil,
		69,
		4341,
		1,
		nil,
		nil,
		1,
		nil,
		4341
	},
	[4341002] = {
		4341002,
		0,
		Lang.get(23425),
		4341,
		2,
		159,
		{
			RTResTalkAction[60],
			RTResTalkAction[2]
		}
	},
	[4341003] = {
		4341003,
		0,
		Lang.get(23426),
		4341,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4341004] = {
		4341004,
		0,
		Lang.get(55777),
		4341,
		4,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4341005] = {
		4341005,
		0,
		"？",
		4341,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4341006] = {
		4341006,
		0,
		Lang.get(23428),
		4341,
		6,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4341007] = {
		4341007,
		0,
		Lang.get(23429),
		4341,
		7,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4341008] = {
		4341008,
		0,
		Lang.get(23430),
		4341,
		8,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4341009] = {
		4341009,
		0,
		Lang.get(23431),
		4341,
		9,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4341010] = {
		4341010,
		0,
		Lang.get(23432),
		4341,
		10,
		159,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[4341011] = {
		4341011,
		0,
		Lang.get(55778),
		4341,
		11,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[4350001] = {
		4350001,
		0,
		Lang.get(23433),
		4350,
		1,
		158,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		4,
		nil,
		67,
		4177,
		1.5,
		nil,
		nil,
		1,
		nil,
		4170
	},
	[4350002] = {
		4350002,
		0,
		Lang.get(23434),
		4350,
		2,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4350003] = {
		4350003,
		0,
		Lang.get(23435),
		4350,
		3,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4350004] = {
		4350004,
		0,
		Lang.get(23436),
		4350,
		4,
		160,
		{
			RTResTalkAction[19],
			RTResTalkAction[2]
		}
	},
	[4350005] = {
		4350005,
		0,
		Lang.get(23437),
		4350,
		5,
		158,
		{
			RTResTalkAction[3],
			RTResTalkAction[21]
		}
	},
	[4351001] = {
		4351001,
		0,
		Lang.get(23438),
		4351,
		1,
		160,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		4351,
		1.5,
		nil,
		nil,
		0,
		nil,
		4351
	},
	[4351002] = {
		4351002,
		0,
		Lang.get(23439),
		4351,
		2,
		160,
		nil,
		1
	},
	[4351003] = {
		4351003,
		0,
		Lang.get(23440),
		4351,
		3,
		158,
		nil,
		1,
		1
	},
	[4351004] = {
		4351004,
		0,
		Lang.get(23441),
		4351,
		4,
		160,
		nil,
		1
	},
	[4351005] = {
		4351005,
		0,
		Lang.get(23442),
		4351,
		5,
		160,
		nil,
		1
	},
	[4351006] = {
		4351006,
		0,
		Lang.get(23443),
		4351,
		6,
		158,
		nil,
		1,
		4
	},
	[4351007] = {
		4351007,
		0,
		Lang.get(23444),
		4351,
		7,
		160,
		nil,
		1
	},
	[4351008] = {
		4351008,
		0,
		Lang.get(23445),
		4351,
		8,
		158,
		nil,
		1,
		1
	},
	[4352001] = {
		4352001,
		3,
		Lang.get(23446),
		4352,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		67,
		4409,
		1.5,
		nil,
		nil,
		0,
		nil,
		4409,
		nil,
		nil,
		1
	},
	[4352002] = {
		4352002,
		0,
		Lang.get(23447),
		4352,
		2,
		107,
		{
			RTResTalkAction[121]
		},
		nil,
		nil,
		4
	},
	[4352003] = {
		4352003,
		0,
		Lang.get(23448),
		4352,
		3,
		107,
		{
			RTResTalkAction[121]
		}
	},
	[4352004] = {
		4352004,
		4,
		nil,
		4352,
		4,
		107,
		{
			RTResTalkAction[121]
		},
		[29] = {
			{
				id = 4352005,
				branch_content = Lang.get(42627)
			}
		}
	},
	[4352005] = {
		4352005,
		0,
		Lang.get(23450),
		4352,
		5,
		576,
		{
			RTResTalkAction[75],
			RTResTalkAction[122]
		}
	},
	[4352006] = {
		4352006,
		0,
		Lang.get(23451),
		4352,
		6,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352007] = {
		4352007,
		4,
		nil,
		4352,
		7,
		576,
		{
			RTResTalkAction[75]
		},
		[29] = {
			{
				id = 4352008,
				branch_content = Lang.get(42628)
			}
		}
	},
	[4352008] = {
		4352008,
		0,
		Lang.get(23453),
		4352,
		8,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352009] = {
		4352009,
		0,
		Lang.get(23454),
		4352,
		9,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352010] = {
		4352010,
		0,
		Lang.get(23455),
		4352,
		10,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352011] = {
		4352011,
		0,
		Lang.get(23456),
		4352,
		11,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352012] = {
		4352012,
		0,
		Lang.get(23457),
		4352,
		12,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352013] = {
		4352013,
		0,
		Lang.get(23458),
		4352,
		13,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352014] = {
		4352014,
		4,
		nil,
		4352,
		14,
		576,
		{
			RTResTalkAction[75]
		},
		[29] = {
			{
				id = 4352015,
				branch_content = Lang.get(42629)
			}
		}
	},
	[4352015] = {
		4352015,
		0,
		Lang.get(23460),
		4352,
		15,
		576,
		{
			RTResTalkAction[75]
		}
	},
	[4352016] = {
		4352016,
		0,
		Lang.get(23461),
		4352,
		16,
		107,
		{
			RTResTalkAction[121],
			RTResTalkAction[76]
		}
	},
	[4352017] = {
		4352017,
		0,
		Lang.get(23462),
		4352,
		17,
		133,
		{
			RTResTalkAction[123],
			RTResTalkAction[122]
		}
	},
	[4352018] = {
		4352018,
		4,
		nil,
		4352,
		18,
		133,
		{
			RTResTalkAction[123]
		},
		[29] = {
			{
				id = 4352019,
				branch_content = Lang.get(42630)
			},
			{
				id = 4352019,
				branch_content = Lang.get(42631)
			}
		}
	},
	[4352019] = {
		4352019,
		0,
		Lang.get(23464),
		4352,
		19,
		107,
		{
			RTResTalkAction[121],
			RTResTalkAction[124]
		}
	},
	[4352020] = {
		4352020,
		0,
		Lang.get(23465),
		4352,
		20,
		107,
		{
			RTResTalkAction[121]
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
