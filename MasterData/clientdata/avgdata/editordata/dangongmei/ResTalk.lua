-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\dangongmei\\ResTalk.lua

local indexMap = {
	npc_id = 6,
	scenery_id = 13,
	bg_blur = 10,
	play_delay = 14,
	mask_alpha = 19,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 17,
	terminal_type = 26,
	hide_name = 21,
	terminal_effect = 24,
	talk_in_ani = 23,
	terminal_bg = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 16,
	font_size = 22,
	extra_npc = 20,
	bg_id = 18,
	talk = 3,
	branch_info = 27,
	id = 1,
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
	134,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 559
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 559
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 560
}
RTResTalkAction[6] = {
	1,
	134,
	nil,
	nil,
	1
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 559
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 560
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[13] = {
	2,
	107,
	{
		10011
	},
	nil,
	10
}
RTResTalkAction[14] = {
	2,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[15] = {
	2,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		10012
	}
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 141,
	[3] = {
		2
	}
}
RTResTalkAction[18] = {
	2,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[19] = {
	2,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	2,
	107,
	{
		10021
	},
	nil,
	3
}
RTResTalkAction[21] = {
	2,
	107,
	{
		2
	},
	nil,
	6
}
RTResTalkAction[22] = {
	3,
	141,
	nil,
	nil,
	0
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[25] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[26] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[27] = {
	1,
	134,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[30] = {
	1,
	107,
	{
		10021
	},
	nil,
	1
}
RTResTalkAction[31] = {
	1,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[32] = {
	1,
	216,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[33] = {
	1,
	216,
	nil,
	nil,
	1
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 216
}
RTResTalkAction[35] = {
	1,
	107,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 217
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 218
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 217
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 218
}
RTResTalkAction[40] = {
	1,
	107,
	{
		1
	},
	nil,
	4
}
RTResTalkAction[41] = {
	1,
	217,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[42] = {
	1,
	107,
	{
		3,
		10041
	},
	nil,
	1
}
RTResTalkAction[43] = {
	1,
	107,
	{
		10011
	},
	nil,
	6
}
RTResTalkAction[44] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[45] = {
	1,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[46] = {
	1,
	107,
	{
		10031
	},
	nil,
	5
}
RTResTalkAction[47] = {
	1,
	107,
	{
		3
	},
	0,
	1
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 134,
	[3] = {
		1
	}
}
RTResTalkAction[49] = {
	1,
	107,
	{
		10021
	},
	nil,
	6
}
RTResTalkAction[50] = {
	1,
	107,
	{
		1
	},
	nil,
	8
}
RTResTalkAction[51] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[52] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 216
}
RTResTalkAction[54] = {
	1,
	216,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	1,
	216,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[56] = {
	1,
	134,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[57] = {
	1,
	107,
	{
		2
	},
	nil,
	10
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 217,
	[3] = {
		100215
	}
}
RTResTalkAction[59] = {
	[1] = 1,
	[2] = 216,
	[3] = {
		3
	}
}
RTResTalkAction[60] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[61] = {
	1,
	107,
	{
		10011
	},
	nil,
	8
}
RTResTalkAction[62] = {
	1,
	134,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 217,
	[3] = {
		1
	}
}
RTResTalkAction[66] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[67] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[68] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[69] = {
	1,
	216,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[70] = {
	1,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[71] = {
	1,
	216,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[72] = {
	1,
	216,
	nil,
	nil,
	2
}
RTResTalkAction[73] = {
	1,
	216,
	nil,
	nil,
	0
}
RTResTalkAction[74] = {
	1,
	216,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[75] = {
	1,
	107,
	{
		10021
	},
	nil,
	8
}
RTResTalkAction[76] = {
	1,
	134,
	nil,
	nil,
	0
}
RTResTalkAction[77] = {
	1,
	107,
	{
		10021,
		1
	},
	nil,
	8
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 217,
	[3] = {
		3
	}
}
RTResTalkAction[80] = {
	1,
	217,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 559,
	[3] = {
		3
	}
}
RTResTalkAction[82] = {
	1,
	216,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 217,
	[3] = {
		2
	}
}
RTResTalkAction[84] = {
	1,
	134,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[85] = {
	[1] = 4,
	[2] = 107
}
RTResTalkAction[86] = {
	[1] = 5,
	[2] = 141
}
RTResTalkAction[87] = {
	1,
	216,
	{
		1002,
		1
	},
	nil,
	1
}
RTResTalkAction[88] = {
	1,
	216,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 216,
	[3] = {
		1
	}
}
RTResTalkAction[90] = {
	1,
	141,
	{
		10012
	},
	nil,
	0
}
RTResTalkAction[91] = {
	1,
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 134,
	[3] = {
		3
	}
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 20
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 561
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 561
}
RTResTalkAction[97] = {
	1,
	107,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 216,
	[3] = {
		2
	}
}
RTResTalkAction[99] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[100] = {
	1,
	217,
	{
		100215
	},
	nil,
	0
}
RTResTalkAction[101] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[102] = {
	1,
	134,
	nil,
	nil,
	2
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 214
}
RTResTalkAction[104] = {
	[1] = 0,
	[2] = 214
}
RTResTalkAction[105] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[106] = {
	1,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[107] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[108] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[109] = {
	1,
	107,
	{
		10021,
		1
	},
	nil,
	10
}
RTResTalkAction[110] = {
	1,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[111] = {
	1,
	215,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[112] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[113] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[114] = {
	[1] = 1,
	[2] = 215,
	[3] = {
		2
	}
}
RTResTalkAction[115] = {
	1,
	215,
	nil,
	nil,
	0
}
RTResTalkAction[116] = {
	1,
	107,
	{
		1,
		10031
	},
	nil,
	5
}
RTResTalkAction[117] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	7
}
RTResTalkAction[118] = {
	1,
	134,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[119] = {
	[1] = 1,
	[2] = 217,
	[3] = {
		10025,
		100215
	}
}
RTResTalkAction[120] = {
	[1] = 1,
	[2] = 214,
	[3] = {
		1
	}
}

local Data = {
	[7600001] = {
		7600001,
		0,
		Lang.get(34451),
		7600,
		1,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		67,
		7600,
		nil,
		nil,
		1,
		nil,
		7600
	},
	[7600002] = {
		7600002,
		0,
		Lang.get(36877),
		7600,
		2,
		559,
		nil,
		1,
		0
	},
	[7600003] = {
		7600003,
		0,
		Lang.get(34453),
		7600,
		3,
		560,
		nil,
		1
	},
	[7600004] = {
		7600004,
		0,
		Lang.get(34454),
		7600,
		4,
		559,
		nil,
		1
	},
	[7600005] = {
		7600005,
		0,
		Lang.get(34455),
		7600,
		5,
		134,
		nil,
		1
	},
	[7600006] = {
		7600006,
		0,
		Lang.get(34456),
		7600,
		6,
		559,
		nil,
		1
	},
	[7600007] = {
		7600007,
		0,
		Lang.get(34457),
		7600,
		7,
		134,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[7600008] = {
		7600008,
		0,
		Lang.get(36878),
		7600,
		8,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[7600009] = {
		7600009,
		0,
		"……",
		7600,
		9,
		560,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[7600010] = {
		7600010,
		0,
		Lang.get(34459),
		7600,
		10,
		134,
		{
			RTResTalkAction[6],
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[7600011] = {
		7600011,
		0,
		Lang.get(34460),
		7600,
		11,
		134,
		{
			RTResTalkAction[9]
		}
	},
	[7601001] = {
		7601001,
		0,
		Lang.get(36879),
		7601,
		1,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		7601,
		nil,
		nil,
		1,
		nil,
		7601
	},
	[7601002] = {
		7601002,
		0,
		Lang.get(36880),
		7601,
		2,
		141,
		nil,
		1,
		0
	},
	[7601003] = {
		7601003,
		0,
		Lang.get(36881),
		7601,
		3,
		107,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[7601004] = {
		7601004,
		0,
		Lang.get(36882),
		7601,
		4,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601005] = {
		7601005,
		0,
		Lang.get(34465),
		7601,
		5,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[7601006] = {
		7601006,
		0,
		Lang.get(36883),
		7601,
		6,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[12]
		}
	},
	[7601007] = {
		7601007,
		0,
		Lang.get(34467),
		7601,
		7,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601008] = {
		7601008,
		0,
		Lang.get(34468),
		7601,
		8,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[12]
		}
	},
	[7601009] = {
		7601009,
		0,
		Lang.get(34469),
		7601,
		9,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601010] = {
		7601010,
		0,
		"……",
		7601,
		10,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[16]
		}
	},
	[7601011] = {
		7601011,
		0,
		Lang.get(36884),
		7601,
		11,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[17]
		}
	},
	[7601012] = {
		7601012,
		0,
		Lang.get(34471),
		7601,
		12,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601013] = {
		7601013,
		0,
		Lang.get(37541),
		7601,
		13,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601014] = {
		7601014,
		0,
		Lang.get(34473),
		7601,
		14,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[12]
		}
	},
	[7601015] = {
		7601015,
		0,
		Lang.get(36885),
		7601,
		15,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601016] = {
		7601016,
		0,
		Lang.get(34475),
		7601,
		16,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601017] = {
		7601017,
		0,
		Lang.get(34476),
		7601,
		17,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[12]
		}
	},
	[7601018] = {
		7601018,
		0,
		Lang.get(34477),
		7601,
		18,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601019] = {
		7601019,
		0,
		Lang.get(36886),
		7601,
		19,
		107,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601020] = {
		7601020,
		0,
		Lang.get(36887),
		7601,
		20,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601021] = {
		7601021,
		0,
		Lang.get(36888),
		7601,
		21,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601022] = {
		7601022,
		0,
		Lang.get(34481),
		7601,
		22,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[12]
		}
	},
	[7601023] = {
		7601023,
		0,
		Lang.get(34482),
		7601,
		23,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601024] = {
		7601024,
		0,
		Lang.get(34483),
		7601,
		24,
		107,
		{
			RTResTalkAction[21],
			RTResTalkAction[12]
		}
	},
	[7601025] = {
		7601025,
		0,
		Lang.get(34484),
		7601,
		25,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[22]
		}
	},
	[7601026] = {
		7601026,
		0,
		Lang.get(34485),
		7601,
		26,
		134,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		},
		1,
		nil,
		nil,
		nil,
		62,
		7602,
		1,
		1,
		1,
		nil,
		7602
	},
	[7601027] = {
		7601027,
		0,
		Lang.get(34486),
		7601,
		27,
		107,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[7601028] = {
		7601028,
		0,
		Lang.get(34487),
		7601,
		28,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7601029] = {
		7601029,
		0,
		Lang.get(34488),
		7601,
		29,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[7601030] = {
		7601030,
		0,
		Lang.get(34489),
		7601,
		30,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[7601031] = {
		7601031,
		0,
		Lang.get(34490),
		7601,
		31,
		107,
		{
			RTResTalkAction[26]
		}
	},
	[7601032] = {
		7601032,
		0,
		Lang.get(34491),
		7601,
		32,
		134,
		{
			RTResTalkAction[27],
			RTResTalkAction[23]
		}
	},
	[7601033] = {
		7601033,
		0,
		Lang.get(34492),
		7601,
		33,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[7601034] = {
		7601034,
		0,
		Lang.get(34493),
		7601,
		34,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7601035] = {
		7601035,
		0,
		Lang.get(34494),
		7601,
		35,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[24]
		}
	},
	[7601036] = {
		7601036,
		0,
		Lang.get(34495),
		7601,
		36,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7603,
		1,
		1,
		1,
		nil,
		7603
	},
	[7601037] = {
		7601037,
		0,
		Lang.get(37542),
		7601,
		37,
		134,
		{
			RTResTalkAction[9]
		}
	},
	[7601038] = {
		7601038,
		0,
		Lang.get(34497),
		7601,
		38,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0
	},
	[7603001] = {
		7603001,
		0,
		Lang.get(34498),
		7603,
		1,
		216,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		7604,
		1,
		1,
		1,
		nil,
		7604
	},
	[7603002] = {
		7603002,
		0,
		Lang.get(36889),
		7603,
		2,
		216,
		nil,
		1,
		0
	},
	[7603003] = {
		7603003,
		0,
		Lang.get(34500),
		7603,
		3,
		216,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		3
	},
	[7603004] = {
		7603004,
		0,
		Lang.get(34501),
		7603,
		4,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7603005] = {
		7603005,
		0,
		Lang.get(36890),
		7603,
		5,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7610001] = {
		7610001,
		0,
		Lang.get(34503),
		7610,
		1,
		107,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		7610,
		1,
		1,
		1,
		nil,
		7610
	},
	[7610002] = {
		7610002,
		0,
		Lang.get(34504),
		7610,
		2,
		217,
		nil,
		1,
		0
	},
	[7610003] = {
		7610003,
		0,
		Lang.get(34505),
		7610,
		3,
		107,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[7610004] = {
		7610004,
		0,
		Lang.get(34506),
		7610,
		4,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7610005] = {
		7610005,
		0,
		"……",
		7610,
		5,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7610006] = {
		7610006,
		0,
		Lang.get(34507),
		7610,
		6,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[39]
		}
	},
	[7610007] = {
		7610007,
		0,
		Lang.get(34508),
		7610,
		7,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7610008] = {
		7610008,
		0,
		Lang.get(34509),
		7610,
		8,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[38]
		}
	},
	[7610009] = {
		7610009,
		0,
		Lang.get(34510),
		7610,
		9,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7610010] = {
		7610010,
		0,
		Lang.get(34511),
		7610,
		10,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7610011] = {
		7610011,
		0,
		Lang.get(34512),
		7610,
		11,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[7610012] = {
		7610012,
		0,
		Lang.get(34513),
		7610,
		12,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7610013] = {
		7610013,
		0,
		Lang.get(34514),
		7610,
		13,
		107,
		{
			RTResTalkAction[38]
		},
		1,
		3,
		nil,
		nil,
		nil,
		7611,
		1,
		1,
		1,
		nil,
		7611
	},
	[7610014] = {
		7610014,
		0,
		Lang.get(34515),
		7610,
		14,
		107,
		nil,
		1,
		0
	},
	[7610015] = {
		7610015,
		0,
		Lang.get(34516),
		7610,
		15,
		217,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[7610016] = {
		7610016,
		0,
		Lang.get(34517),
		7610,
		16,
		107,
		{
			RTResTalkAction[40],
			RTResTalkAction[38]
		}
	},
	[7610017] = {
		7610017,
		0,
		Lang.get(34518),
		7610,
		17,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7610018] = {
		7610018,
		0,
		Lang.get(34519),
		7610,
		18,
		217,
		{
			RTResTalkAction[41]
		}
	},
	[7610019] = {
		7610019,
		0,
		Lang.get(34520),
		7610,
		19,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7610020] = {
		7610020,
		0,
		Lang.get(34521),
		7610,
		20,
		107,
		{
			RTResTalkAction[42],
			RTResTalkAction[38]
		}
	},
	[7610021] = {
		7610021,
		0,
		Lang.get(34522),
		7610,
		21,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7610022] = {
		7610022,
		0,
		Lang.get(34523),
		7610,
		22,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[38]
		}
	},
	[7610023] = {
		7610023,
		0,
		Lang.get(36891),
		7610,
		23,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7610024] = {
		7610024,
		0,
		Lang.get(37543),
		7610,
		24,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7610025] = {
		7610025,
		0,
		Lang.get(36892),
		7610,
		25,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[7610026] = {
		7610026,
		0,
		Lang.get(34527),
		7610,
		26,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[24]
		}
	},
	[7610027] = {
		7610027,
		0,
		Lang.get(34528),
		7610,
		27,
		107,
		{
			RTResTalkAction[44]
		}
	},
	[7610028] = {
		7610028,
		0,
		Lang.get(34529),
		7610,
		28,
		134,
		{
			RTResTalkAction[27],
			RTResTalkAction[23]
		}
	},
	[7610029] = {
		7610029,
		0,
		Lang.get(34530),
		7610,
		29,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7610030] = {
		7610030,
		0,
		Lang.get(34531),
		7610,
		30,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[38]
		}
	},
	[7610031] = {
		7610031,
		0,
		Lang.get(34532),
		7610,
		31,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7610032] = {
		7610032,
		0,
		Lang.get(34533),
		7610,
		32,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7610033] = {
		7610033,
		0,
		Lang.get(34534),
		7610,
		33,
		107,
		{
			RTResTalkAction[45],
			RTResTalkAction[24]
		}
	},
	[7610034] = {
		7610034,
		0,
		Lang.get(34535),
		7610,
		34,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7610035] = {
		7610035,
		0,
		Lang.get(34536),
		7610,
		35,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7610036] = {
		7610036,
		0,
		Lang.get(34537),
		7610,
		36,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[7610037] = {
		7610037,
		0,
		Lang.get(34538),
		7610,
		37,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7610038] = {
		7610038,
		0,
		Lang.get(34539),
		7610,
		38,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[7610039] = {
		7610039,
		0,
		Lang.get(36893),
		7610,
		39,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[7610040] = {
		7610040,
		0,
		Lang.get(34541),
		7610,
		40,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[3]
		}
	},
	[7612001] = {
		7612001,
		0,
		Lang.get(37544),
		7612,
		1,
		217,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		7612,
		1,
		1,
		1,
		nil,
		7612
	},
	[7612002] = {
		7612002,
		0,
		Lang.get(34543),
		7612,
		2,
		217,
		nil,
		1
	},
	[7612003] = {
		7612003,
		0,
		Lang.get(34544),
		7612,
		3,
		217,
		nil,
		1
	},
	[7612004] = {
		7612004,
		0,
		Lang.get(34545),
		7612,
		4,
		107,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[7612005] = {
		7612005,
		0,
		Lang.get(36894),
		7612,
		5,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7612006] = {
		7612006,
		0,
		Lang.get(34547),
		7612,
		6,
		134,
		{
			RTResTalkAction[48],
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[7612007] = {
		7612007,
		0,
		Lang.get(34548),
		7612,
		7,
		107,
		{
			RTResTalkAction[49],
			RTResTalkAction[3]
		}
	},
	[7612008] = {
		7612008,
		0,
		Lang.get(34549),
		7612,
		8,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23]
		}
	},
	[7612009] = {
		7612009,
		0,
		Lang.get(34550),
		7612,
		9,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7612010] = {
		7612010,
		0,
		Lang.get(37545),
		7612,
		10,
		134,
		{
			RTResTalkAction[6],
			RTResTalkAction[24]
		}
	},
	[7612011] = {
		7612011,
		0,
		Lang.get(34552),
		7612,
		11,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7612012] = {
		7612012,
		3,
		Lang.get(36895),
		7612,
		12,
		605,
		{
			RTResTalkAction[38]
		},
		[21] = 1
	},
	[7612013] = {
		7612013,
		0,
		Lang.get(34554),
		7612,
		13,
		107,
		{
			RTResTalkAction[50]
		}
	},
	[7612014] = {
		7612014,
		0,
		Lang.get(34555),
		7612,
		14,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7612015] = {
		7612015,
		0,
		Lang.get(34556),
		7612,
		15,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[7612016] = {
		7612016,
		0,
		Lang.get(34557),
		7612,
		16,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		}
	},
	[7612017] = {
		7612017,
		0,
		Lang.get(34558),
		7612,
		17,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23]
		}
	},
	[7612018] = {
		7612018,
		0,
		Lang.get(34559),
		7612,
		18,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7612019] = {
		7612019,
		0,
		Lang.get(34560),
		7612,
		19,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[7612020] = {
		7612020,
		0,
		Lang.get(34561),
		7612,
		20,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7612021] = {
		7612021,
		0,
		Lang.get(22460),
		7612,
		21,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7612022] = {
		7612022,
		0,
		Lang.get(34562),
		7612,
		22,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[7612023] = {
		7612023,
		0,
		Lang.get(34511),
		7612,
		23,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7612024] = {
		7612024,
		0,
		"……",
		7612,
		24,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[7620001] = {
		7620001,
		0,
		Lang.get(34563),
		7620,
		1,
		559,
		nil,
		1,
		nil,
		nil,
		nil,
		133,
		nil,
		1,
		1,
		1,
		nil,
		7620
	},
	[7620002] = {
		7620002,
		0,
		Lang.get(34564),
		7620,
		2,
		560,
		nil,
		1
	},
	[7620003] = {
		7620003,
		0,
		Lang.get(34565),
		7620,
		3,
		559,
		nil,
		1
	},
	[7620004] = {
		7620004,
		0,
		Lang.get(34566),
		7620,
		4,
		560,
		nil,
		1
	},
	[7620005] = {
		7620005,
		0,
		Lang.get(34567),
		7620,
		5,
		560,
		nil,
		1
	},
	[7620006] = {
		7620006,
		0,
		Lang.get(37546),
		7620,
		6,
		216,
		nil,
		1
	},
	[7620007] = {
		7620007,
		0,
		Lang.get(34569),
		7620,
		7,
		559,
		nil,
		1
	},
	[7620008] = {
		7620008,
		0,
		Lang.get(34570),
		7620,
		8,
		134,
		nil,
		1
	},
	[7620009] = {
		7620009,
		0,
		Lang.get(34571),
		7620,
		9,
		559,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7621,
		1,
		1,
		1,
		nil,
		7621
	},
	[7620010] = {
		7620010,
		0,
		Lang.get(34572),
		7620,
		10,
		559,
		{
			RTResTalkAction[2]
		}
	},
	[7620011] = {
		7620011,
		0,
		Lang.get(34573),
		7620,
		11,
		107,
		{
			RTResTalkAction[51],
			RTResTalkAction[7]
		}
	},
	[7620012] = {
		7620012,
		0,
		Lang.get(36896),
		7620,
		12,
		134,
		{
			RTResTalkAction[52],
			RTResTalkAction[23]
		}
	},
	[7620013] = {
		7620013,
		0,
		Lang.get(34575),
		7620,
		13,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[3]
		}
	},
	[7620014] = {
		7620014,
		0,
		Lang.get(36897),
		7620,
		14,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7620015] = {
		7620015,
		0,
		Lang.get(36898),
		7620,
		15,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[7620016] = {
		7620016,
		0,
		Lang.get(34578),
		7620,
		16,
		559,
		{
			RTResTalkAction[2]
		}
	},
	[7620017] = {
		7620017,
		0,
		Lang.get(34579),
		7620,
		17,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[7620018] = {
		7620018,
		0,
		Lang.get(34899),
		7620,
		18,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7620019] = {
		7620019,
		0,
		Lang.get(34581),
		7620,
		19,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[24]
		}
	},
	[7620020] = {
		7620020,
		0,
		Lang.get(34582),
		7620,
		20,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[7620021] = {
		7620021,
		0,
		Lang.get(29050),
		7620,
		21,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[7]
		}
	},
	[7620022] = {
		7620022,
		0,
		Lang.get(34583),
		7620,
		22,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[53]
		}
	},
	[7620023] = {
		7620023,
		0,
		Lang.get(34584),
		7620,
		23,
		216,
		{
			RTResTalkAction[55],
			RTResTalkAction[3]
		}
	},
	[7620024] = {
		7620024,
		0,
		Lang.get(34585),
		7620,
		24,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[7620025] = {
		7620025,
		0,
		Lang.get(34586),
		7620,
		25,
		134,
		{
			RTResTalkAction[56],
			RTResTalkAction[7]
		}
	},
	[7620026] = {
		7620026,
		0,
		Lang.get(34587),
		7620,
		26,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[7620027] = {
		7620027,
		0,
		Lang.get(34588),
		7620,
		27,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[7620028] = {
		7620028,
		0,
		Lang.get(34589),
		7620,
		28,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[7]
		}
	},
	[7620029] = {
		7620029,
		0,
		Lang.get(34590),
		7620,
		29,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7620030] = {
		7620030,
		0,
		Lang.get(36899),
		7620,
		30,
		107,
		{
			RTResTalkAction[57],
			RTResTalkAction[53]
		}
	},
	[7620031] = {
		7620031,
		0,
		Lang.get(34592),
		7620,
		31,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7620032] = {
		7620032,
		0,
		Lang.get(34593),
		7620,
		32,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[24]
		}
	},
	[7620033] = {
		7620033,
		0,
		Lang.get(36900),
		7620,
		33,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7620034] = {
		7620034,
		0,
		Lang.get(34595),
		7620,
		34,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7620035] = {
		7620035,
		0,
		Lang.get(19756),
		7620,
		35,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[53]
		}
	},
	[7620036] = {
		7620036,
		0,
		Lang.get(36901),
		7620,
		36,
		107,
		{
			RTResTalkAction[42]
		}
	},
	[7620037] = {
		7620037,
		0,
		Lang.get(34597),
		7620,
		37,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7622001] = {
		7622001,
		0,
		Lang.get(34598),
		7622,
		1,
		217,
		nil,
		1,
		nil,
		nil,
		nil,
		133,
		7622,
		1,
		1,
		1,
		nil,
		7622
	},
	[7622002] = {
		7622002,
		0,
		Lang.get(34599),
		7622,
		2,
		107,
		nil,
		1,
		1
	},
	[7622003] = {
		7622003,
		0,
		Lang.get(34600),
		7622,
		3,
		217,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[7622004] = {
		7622004,
		0,
		Lang.get(34601),
		7622,
		4,
		217,
		{
			RTResTalkAction[58]
		}
	},
	[7622005] = {
		7622005,
		0,
		Lang.get(37547),
		7622,
		5,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[7622006] = {
		7622006,
		0,
		Lang.get(37548),
		7622,
		6,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[7622007] = {
		7622007,
		0,
		Lang.get(36902),
		7622,
		7,
		216,
		{
			RTResTalkAction[59],
			RTResTalkAction[38]
		}
	},
	[7622008] = {
		7622008,
		0,
		Lang.get(34604),
		7622,
		8,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7622009] = {
		7622009,
		0,
		Lang.get(34605),
		7622,
		9,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7630001] = {
		7630001,
		0,
		Lang.get(34606),
		7630,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		nil,
		7630,
		1,
		1,
		1,
		nil,
		7630
	},
	[7630002] = {
		7630002,
		0,
		Lang.get(34607),
		7630,
		2,
		107,
		nil,
		1,
		1
	},
	[7630003] = {
		7630003,
		0,
		Lang.get(34608),
		7630,
		3,
		141,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3
	},
	[7630004] = {
		7630004,
		0,
		Lang.get(34609),
		7630,
		4,
		134,
		{
			RTResTalkAction[1],
			RTResTalkAction[24]
		}
	},
	[7630005] = {
		7630005,
		0,
		Lang.get(34610),
		7630,
		5,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[7630006] = {
		7630006,
		0,
		Lang.get(37549),
		7630,
		6,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7630007] = {
		7630007,
		0,
		Lang.get(34612),
		7630,
		7,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7630008] = {
		7630008,
		0,
		Lang.get(34613),
		7630,
		8,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[53]
		}
	},
	[7631001] = {
		7631001,
		3,
		Lang.get(36903),
		7631,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		133,
		7631,
		1,
		1,
		0,
		nil,
		7631,
		nil,
		nil,
		1
	},
	[7631002] = {
		7631002,
		0,
		Lang.get(34583),
		7631,
		2,
		107,
		{
			RTResTalkAction[60]
		},
		nil,
		1,
		3
	},
	[7631003] = {
		7631003,
		0,
		"？？？？？？",
		7631,
		3,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7631004] = {
		7631004,
		0,
		Lang.get(34615),
		7631,
		4,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7631005] = {
		7631005,
		0,
		Lang.get(34616),
		7631,
		5,
		107,
		{
			RTResTalkAction[61]
		}
	},
	[7631006] = {
		7631006,
		0,
		Lang.get(34617),
		7631,
		6,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7631007] = {
		7631007,
		0,
		Lang.get(37550),
		7631,
		7,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7631008] = {
		7631008,
		0,
		Lang.get(36904),
		7631,
		8,
		134,
		{
			RTResTalkAction[62],
			RTResTalkAction[24]
		}
	},
	[7631009] = {
		7631009,
		0,
		Lang.get(34620),
		7631,
		9,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7631010] = {
		7631010,
		0,
		Lang.get(36905),
		7631,
		10,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[38]
		}
	},
	[7631011] = {
		7631011,
		0,
		Lang.get(36906),
		7631,
		11,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7631012] = {
		7631012,
		0,
		Lang.get(34623),
		7631,
		12,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7631013] = {
		7631013,
		0,
		Lang.get(34624),
		7631,
		13,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7631014] = {
		7631014,
		0,
		Lang.get(36907),
		7631,
		14,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631015] = {
		7631015,
		0,
		Lang.get(34626),
		7631,
		15,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7631016] = {
		7631016,
		0,
		Lang.get(34627),
		7631,
		16,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631017] = {
		7631017,
		0,
		Lang.get(34628),
		7631,
		17,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7631018] = {
		7631018,
		0,
		Lang.get(36908),
		7631,
		18,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		7632,
		1,
		1,
		1,
		nil,
		7632
	},
	[7631019] = {
		7631019,
		0,
		Lang.get(34630),
		7631,
		19,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7631020] = {
		7631020,
		0,
		Lang.get(34631),
		7631,
		20,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7631021] = {
		7631021,
		0,
		Lang.get(34632),
		7631,
		21,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631022] = {
		7631022,
		0,
		Lang.get(34633),
		7631,
		22,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7631023] = {
		7631023,
		0,
		Lang.get(34634),
		7631,
		23,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[7631024] = {
		7631024,
		0,
		Lang.get(34635),
		7631,
		24,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7631025] = {
		7631025,
		0,
		"！！！",
		7631,
		25,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631026] = {
		7631026,
		0,
		Lang.get(34636),
		7631,
		26,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631027] = {
		7631027,
		0,
		Lang.get(34637),
		7631,
		27,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631028] = {
		7631028,
		0,
		Lang.get(34638),
		7631,
		28,
		217,
		{
			RTResTalkAction[65]
		}
	},
	[7631029] = {
		7631029,
		0,
		Lang.get(34639),
		7631,
		29,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7631030] = {
		7631030,
		0,
		Lang.get(34640),
		7631,
		30,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7631031] = {
		7631031,
		0,
		Lang.get(36909),
		7631,
		31,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[38]
		}
	},
	[7631032] = {
		7631032,
		0,
		Lang.get(36910),
		7631,
		32,
		107,
		{
			RTResTalkAction[66]
		}
	},
	[7631033] = {
		7631033,
		0,
		Lang.get(37551),
		7631,
		33,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7631034] = {
		7631034,
		0,
		Lang.get(34644),
		7631,
		34,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[7631035] = {
		7631035,
		0,
		Lang.get(34645),
		7631,
		35,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[7631036] = {
		7631036,
		0,
		Lang.get(34646),
		7631,
		36,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7631037] = {
		7631037,
		0,
		Lang.get(34647),
		7631,
		37,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[12]
		}
	},
	[7631038] = {
		7631038,
		0,
		Lang.get(34648),
		7631,
		38,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7631039] = {
		7631039,
		0,
		"……",
		7631,
		39,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[24]
		}
	},
	[7631040] = {
		7631040,
		0,
		Lang.get(34649),
		7631,
		40,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7631041] = {
		7631041,
		0,
		Lang.get(34650),
		7631,
		41,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7631042] = {
		7631042,
		0,
		Lang.get(36912),
		7631,
		42,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7631043] = {
		7631043,
		0,
		Lang.get(34652),
		7631,
		43,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7631044] = {
		7631044,
		0,
		Lang.get(34653),
		7631,
		44,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[53]
		}
	},
	[7631045] = {
		7631045,
		3,
		Lang.get(37552),
		7631,
		45,
		605,
		{
			RTResTalkAction[23]
		},
		[21] = 1
	},
	[7640001] = {
		7640001,
		0,
		Lang.get(34655),
		7640,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		7640,
		1,
		1,
		1,
		nil,
		7640
	},
	[7640002] = {
		7640002,
		0,
		Lang.get(36914),
		7640,
		2,
		300,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		0.5
	},
	[7640003] = {
		7640003,
		0,
		Lang.get(34657),
		7640,
		3,
		216,
		{
			RTResTalkAction[69]
		}
	},
	[7640004] = {
		7640004,
		0,
		Lang.get(34658),
		7640,
		4,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7640005] = {
		7640005,
		0,
		Lang.get(34659),
		7640,
		5,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[38]
		}
	},
	[7640006] = {
		7640006,
		0,
		Lang.get(36915),
		7640,
		6,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7640007] = {
		7640007,
		0,
		Lang.get(34661),
		7640,
		7,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7640008] = {
		7640008,
		0,
		Lang.get(36916),
		7640,
		8,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[38]
		}
	},
	[7640009] = {
		7640009,
		0,
		Lang.get(36917),
		7640,
		9,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[3]
		}
	},
	[7640010] = {
		7640010,
		0,
		Lang.get(36918),
		7640,
		10,
		134,
		{
			RTResTalkAction[6],
			RTResTalkAction[23]
		}
	},
	[7640011] = {
		7640011,
		0,
		Lang.get(36919),
		7640,
		11,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[7640012] = {
		7640012,
		0,
		Lang.get(37553),
		7640,
		12,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7640013] = {
		7640013,
		0,
		Lang.get(37554),
		7640,
		13,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7640014] = {
		7640014,
		0,
		Lang.get(36921),
		7640,
		14,
		216,
		{
			RTResTalkAction[71]
		}
	},
	[7640015] = {
		7640015,
		0,
		Lang.get(34669),
		7640,
		15,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7640016] = {
		7640016,
		0,
		Lang.get(34670),
		7640,
		16,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7640017] = {
		7640017,
		0,
		Lang.get(34671),
		7640,
		17,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7640018] = {
		7640018,
		0,
		Lang.get(34672),
		7640,
		18,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7640019] = {
		7640019,
		0,
		Lang.get(34673),
		7640,
		19,
		216,
		{
			RTResTalkAction[73]
		}
	},
	[7640020] = {
		7640020,
		0,
		Lang.get(37555),
		7640,
		20,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7640021] = {
		7640021,
		0,
		Lang.get(34675),
		7640,
		21,
		216,
		{
			RTResTalkAction[74]
		}
	},
	[7640022] = {
		7640022,
		0,
		Lang.get(34676),
		7640,
		22,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7640023] = {
		7640023,
		0,
		Lang.get(34677),
		7640,
		23,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7640024] = {
		7640024,
		0,
		Lang.get(34678),
		7640,
		24,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[53]
		}
	},
	[7640025] = {
		7640025,
		0,
		Lang.get(34679),
		7640,
		25,
		134,
		{
			RTResTalkAction[56],
			RTResTalkAction[7]
		}
	},
	[7640026] = {
		7640026,
		0,
		Lang.get(34680),
		7640,
		26,
		134,
		{
			RTResTalkAction[6]
		}
	},
	[7640027] = {
		7640027,
		0,
		"？？？",
		7640,
		27,
		107,
		{
			RTResTalkAction[75],
			RTResTalkAction[3]
		}
	},
	[7640028] = {
		7640028,
		0,
		Lang.get(34681),
		7640,
		28,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7640029] = {
		7640029,
		0,
		Lang.get(37556),
		7640,
		29,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[24]
		}
	},
	[7640030] = {
		7640030,
		0,
		Lang.get(34683),
		7640,
		30,
		134,
		{
			RTResTalkAction[76],
			RTResTalkAction[23]
		}
	},
	[7640031] = {
		7640031,
		0,
		"？？？",
		7640,
		31,
		217,
		{
			RTResTalkAction[58],
			RTResTalkAction[3]
		}
	},
	[7640032] = {
		7640032,
		0,
		"？？？",
		7640,
		32,
		107,
		{
			RTResTalkAction[77],
			RTResTalkAction[38]
		}
	},
	[7640033] = {
		7640033,
		0,
		Lang.get(36924),
		7640,
		33,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7640034] = {
		7640034,
		0,
		Lang.get(34685),
		7640,
		34,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7640035] = {
		7640035,
		0,
		Lang.get(36925),
		7640,
		35,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7640036] = {
		7640036,
		0,
		Lang.get(37557),
		7640,
		36,
		141,
		{
			RTResTalkAction[78]
		}
	},
	[7640037] = {
		7640037,
		0,
		Lang.get(34688),
		7640,
		37,
		217,
		{
			RTResTalkAction[79],
			RTResTalkAction[24]
		}
	},
	[7640038] = {
		7640038,
		0,
		Lang.get(36927),
		7640,
		38,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7640039] = {
		7640039,
		0,
		Lang.get(34690),
		7640,
		39,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7640040] = {
		7640040,
		0,
		Lang.get(37558),
		7640,
		40,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[38]
		}
	},
	[7640041] = {
		7640041,
		0,
		Lang.get(36928),
		7640,
		41,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[7640042] = {
		7640042,
		0,
		Lang.get(34693),
		7640,
		42,
		217,
		{
			RTResTalkAction[80],
			RTResTalkAction[23]
		}
	},
	[7640043] = {
		7640043,
		0,
		Lang.get(34694),
		7640,
		43,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7640044] = {
		7640044,
		0,
		Lang.get(34695),
		7640,
		44,
		134,
		{
			RTResTalkAction[52],
			RTResTalkAction[38]
		}
	},
	[7640045] = {
		7640045,
		0,
		Lang.get(36929),
		7640,
		45,
		559,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[7640046] = {
		7640046,
		0,
		Lang.get(34697),
		7640,
		46,
		559,
		{
			RTResTalkAction[81]
		}
	},
	[7640047] = {
		7640047,
		0,
		Lang.get(36930),
		7640,
		47,
		559,
		{
			RTResTalkAction[2]
		}
	},
	[7640048] = {
		7640048,
		0,
		Lang.get(34699),
		7640,
		48,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[7640049] = {
		7640049,
		0,
		"……",
		7640,
		49,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7640050] = {
		7640050,
		0,
		Lang.get(34700),
		7640,
		50,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7640051] = {
		7640051,
		0,
		Lang.get(37559),
		7640,
		51,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7640052] = {
		7640052,
		0,
		Lang.get(37560),
		7640,
		52,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7640053] = {
		7640053,
		0,
		"！！！！",
		7640,
		53,
		216,
		{
			RTResTalkAction[82],
			RTResTalkAction[3]
		}
	},
	[7640054] = {
		7640054,
		0,
		Lang.get(34703),
		7640,
		54,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7640055] = {
		7640055,
		0,
		Lang.get(34704),
		7640,
		55,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7640056] = {
		7640056,
		2,
		Lang.get(36931),
		7640,
		56,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7640057] = {
		7640057,
		0,
		Lang.get(36932),
		7640,
		57,
		216,
		{
			RTResTalkAction[73]
		}
	},
	[7640058] = {
		7640058,
		0,
		Lang.get(34707),
		7640,
		58,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7640059] = {
		7640059,
		0,
		Lang.get(34708),
		7640,
		59,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7640060] = {
		7640060,
		0,
		Lang.get(36933),
		7640,
		60,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7641001] = {
		7641001,
		0,
		Lang.get(34710),
		7641,
		1,
		134,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3,
		nil,
		60,
		7641,
		1.5,
		1,
		1,
		nil,
		7641
	},
	[7641002] = {
		7641002,
		0,
		Lang.get(34711),
		7641,
		2,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7641003] = {
		7641003,
		0,
		Lang.get(34712),
		7641,
		3,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7641004] = {
		7641004,
		0,
		Lang.get(36934),
		7641,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7641005] = {
		7641005,
		0,
		Lang.get(36935),
		7641,
		5,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7641006] = {
		7641006,
		0,
		Lang.get(34715),
		7641,
		6,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7641007] = {
		7641007,
		0,
		Lang.get(29050),
		7641,
		7,
		216,
		{
			RTResTalkAction[72],
			RTResTalkAction[38]
		}
	},
	[7641008] = {
		7641008,
		0,
		Lang.get(34716),
		7641,
		8,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7641009] = {
		7641009,
		0,
		Lang.get(37561),
		7641,
		9,
		300,
		{
			RTResTalkAction[73],
			RTResTalkAction[38]
		}
	},
	[7641010] = {
		7641010,
		0,
		Lang.get(37562),
		7641,
		10,
		300,
		{
			RTResTalkAction[73]
		}
	},
	[7641011] = {
		7641011,
		0,
		Lang.get(34719),
		7641,
		11,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7641012] = {
		7641012,
		0,
		Lang.get(34720),
		7641,
		12,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7641013] = {
		7641013,
		0,
		Lang.get(36936),
		7641,
		13,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7641014] = {
		7641014,
		0,
		"？？？",
		7641,
		14,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7650001] = {
		7650001,
		0,
		Lang.get(34722),
		7650,
		1,
		216,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		60,
		7650,
		1,
		1,
		1,
		nil,
		7650
	},
	[7650002] = {
		7650002,
		0,
		Lang.get(34723),
		7650,
		2,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7650003] = {
		7650003,
		0,
		Lang.get(36937),
		7650,
		3,
		217,
		{
			RTResTalkAction[83],
			RTResTalkAction[53]
		}
	},
	[7650004] = {
		7650004,
		0,
		Lang.get(37563),
		7650,
		4,
		107,
		{
			RTResTalkAction[45],
			RTResTalkAction[38]
		}
	},
	[7650005] = {
		7650005,
		0,
		Lang.get(37564),
		7650,
		5,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7650006] = {
		7650006,
		0,
		Lang.get(34727),
		7650,
		6,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[23]
		}
	},
	[7650007] = {
		7650007,
		0,
		Lang.get(34728),
		7650,
		7,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7650008] = {
		7650008,
		0,
		Lang.get(34729),
		7650,
		8,
		217,
		{
			RTResTalkAction[79],
			RTResTalkAction[53]
		}
	},
	[7650009] = {
		7650009,
		0,
		Lang.get(34730),
		7650,
		9,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7650010] = {
		7650010,
		0,
		Lang.get(36939),
		7650,
		10,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7650011] = {
		7650011,
		0,
		Lang.get(37565),
		7650,
		11,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7650012] = {
		7650012,
		0,
		Lang.get(34733),
		7650,
		12,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7650013] = {
		7650013,
		0,
		Lang.get(36941),
		7650,
		13,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7650014] = {
		7650014,
		0,
		Lang.get(34735),
		7650,
		14,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7650015] = {
		7650015,
		0,
		Lang.get(34736),
		7650,
		15,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7650016] = {
		7650016,
		0,
		Lang.get(34737),
		7650,
		16,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[38]
		}
	},
	[7650017] = {
		7650017,
		0,
		Lang.get(34738),
		7650,
		17,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7650018] = {
		7650018,
		0,
		Lang.get(34739),
		7650,
		18,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[7650019] = {
		7650019,
		0,
		Lang.get(34740),
		7650,
		19,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7650020] = {
		7650020,
		0,
		Lang.get(34741),
		7650,
		20,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[7651001] = {
		7651001,
		3,
		Lang.get(37566),
		7651,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		7651,
		nil,
		nil,
		1,
		nil,
		7651,
		nil,
		nil,
		1
	},
	[7651002] = {
		7651002,
		0,
		Lang.get(37567),
		7651,
		2,
		300,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[7651003] = {
		7651003,
		0,
		Lang.get(37568),
		7651,
		3,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7651004] = {
		7651004,
		0,
		"……",
		7651,
		4,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7651005] = {
		7651005,
		0,
		Lang.get(37569),
		7651,
		5,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7651006] = {
		7651006,
		0,
		"……",
		7651,
		6,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7651007] = {
		7651007,
		0,
		Lang.get(34746),
		7651,
		7,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7651008] = {
		7651008,
		0,
		Lang.get(37570),
		7651,
		8,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[53]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7652,
		1,
		1,
		1,
		nil,
		7652
	},
	[7651009] = {
		7651009,
		0,
		Lang.get(34748),
		7651,
		9,
		216,
		{
			RTResTalkAction[72],
			RTResTalkAction[64]
		}
	},
	[7651010] = {
		7651010,
		0,
		Lang.get(34749),
		7651,
		10,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7651011] = {
		7651011,
		0,
		Lang.get(37571),
		7651,
		11,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7651012] = {
		7651012,
		0,
		Lang.get(19320),
		7651,
		12,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7651013] = {
		7651013,
		3,
		Lang.get(37572),
		7651,
		13,
		[21] = 1,
		[7] = {
			RTResTalkAction[53]
		}
	},
	[7651014] = {
		7651014,
		0,
		Lang.get(34753),
		7651,
		14,
		216,
		{
			RTResTalkAction[32]
		}
	},
	[7651015] = {
		7651015,
		0,
		Lang.get(36943),
		7651,
		15,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7651016] = {
		7651016,
		0,
		Lang.get(34755),
		7651,
		16,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7651017] = {
		7651017,
		0,
		Lang.get(37573),
		7651,
		17,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7651018] = {
		7651018,
		0,
		Lang.get(34757),
		7651,
		18,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7653001] = {
		7653001,
		0,
		Lang.get(34758),
		7653,
		1,
		217,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		67,
		7653,
		0.5,
		1,
		1,
		nil,
		7653
	},
	[7653002] = {
		7653002,
		0,
		Lang.get(34759),
		7653,
		2,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7653003] = {
		7653003,
		0,
		Lang.get(34760),
		7653,
		3,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7653004] = {
		7653004,
		0,
		Lang.get(37574),
		7653,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7653005] = {
		7653005,
		0,
		"！！！？？？？",
		7653,
		5,
		217,
		{
			RTResTalkAction[58]
		}
	},
	[7653006] = {
		7653006,
		0,
		Lang.get(34762),
		7653,
		6,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7653007] = {
		7653007,
		0,
		Lang.get(34763),
		7653,
		7,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7653008] = {
		7653008,
		0,
		Lang.get(37575),
		7653,
		8,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[38]
		}
	},
	[7653009] = {
		7653009,
		0,
		Lang.get(34765),
		7653,
		9,
		217,
		{
			RTResTalkAction[79],
			RTResTalkAction[53]
		}
	},
	[7653010] = {
		7653010,
		0,
		Lang.get(37576),
		7653,
		10,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7653011] = {
		7653011,
		0,
		Lang.get(34767),
		7653,
		11,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653012] = {
		7653012,
		0,
		Lang.get(34768),
		7653,
		12,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7653013] = {
		7653013,
		0,
		Lang.get(37577),
		7653,
		13,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7653014] = {
		7653014,
		0,
		Lang.get(37578),
		7653,
		14,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7653015] = {
		7653015,
		0,
		Lang.get(34771),
		7653,
		15,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653016] = {
		7653016,
		0,
		Lang.get(37579),
		7653,
		16,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7653017] = {
		7653017,
		0,
		Lang.get(34773),
		7653,
		17,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7653018] = {
		7653018,
		0,
		Lang.get(34774),
		7653,
		18,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7653019] = {
		7653019,
		0,
		Lang.get(36946),
		7653,
		19,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7653020] = {
		7653020,
		0,
		Lang.get(34776),
		7653,
		20,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653021] = {
		7653021,
		0,
		Lang.get(34777),
		7653,
		21,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[53]
		}
	},
	[7653022] = {
		7653022,
		0,
		Lang.get(34778),
		7653,
		22,
		217,
		{
			RTResTalkAction[79],
			RTResTalkAction[64]
		}
	},
	[7653023] = {
		7653023,
		3,
		Lang.get(37580),
		7653,
		23,
		nil,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		7654,
		1,
		1,
		1,
		nil,
		7654,
		nil,
		nil,
		1
	},
	[7653024] = {
		7653024,
		0,
		Lang.get(34780),
		7653,
		24,
		107,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[7653025] = {
		7653025,
		0,
		Lang.get(37581),
		7653,
		25,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7653026] = {
		7653026,
		0,
		Lang.get(34782),
		7653,
		26,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7653027] = {
		7653027,
		0,
		Lang.get(34783),
		7653,
		27,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[38]
		}
	},
	[7653028] = {
		7653028,
		0,
		Lang.get(34784),
		7653,
		28,
		134,
		{
			RTResTalkAction[9]
		}
	},
	[7653029] = {
		7653029,
		0,
		Lang.get(34785),
		7653,
		29,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[7653030] = {
		7653030,
		0,
		"……",
		7653,
		30,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7653031] = {
		7653031,
		0,
		Lang.get(34786),
		7653,
		31,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[24]
		}
	},
	[7653032] = {
		7653032,
		0,
		Lang.get(36948),
		7653,
		32,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653033] = {
		7653033,
		0,
		Lang.get(36949),
		7653,
		33,
		134,
		{
			RTResTalkAction[84],
			RTResTalkAction[53]
		}
	},
	[7653034] = {
		7653034,
		0,
		Lang.get(37582),
		7653,
		34,
		300,
		{
			RTResTalkAction[85],
			RTResTalkAction[9],
			RTResTalkAction[86]
		}
	},
	[7653035] = {
		7653035,
		0,
		Lang.get(36951),
		7653,
		35,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[7653036] = {
		7653036,
		0,
		Lang.get(34790),
		7653,
		36,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[3]
		}
	},
	[7653037] = {
		7653037,
		0,
		Lang.get(34791),
		7653,
		37,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7653038] = {
		7653038,
		0,
		Lang.get(34792),
		7653,
		38,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7653039] = {
		7653039,
		0,
		Lang.get(34793),
		7653,
		39,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[38]
		}
	},
	[7653040] = {
		7653040,
		0,
		Lang.get(34794),
		7653,
		40,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653041] = {
		7653041,
		0,
		Lang.get(34795),
		7653,
		41,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7653042] = {
		7653042,
		0,
		Lang.get(37583),
		7653,
		42,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7653043] = {
		7653043,
		0,
		Lang.get(34797),
		7653,
		43,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7653044] = {
		7653044,
		0,
		Lang.get(34798),
		7653,
		44,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7653045] = {
		7653045,
		0,
		Lang.get(34799),
		7653,
		45,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7653046] = {
		7653046,
		0,
		Lang.get(34800),
		7653,
		46,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[7653047] = {
		7653047,
		0,
		Lang.get(34801),
		7653,
		47,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7653048] = {
		7653048,
		0,
		"……",
		7653,
		48,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[7653049] = {
		7653049,
		0,
		Lang.get(34802),
		7653,
		49,
		300
	},
	[7660001] = {
		7660001,
		0,
		Lang.get(37584),
		7660,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		7660,
		1,
		1,
		1,
		nil,
		7660
	},
	[7660002] = {
		7660002,
		0,
		Lang.get(37585),
		7660,
		2,
		216,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[7660003] = {
		7660003,
		0,
		Lang.get(37586),
		7660,
		3,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7660004] = {
		7660004,
		0,
		Lang.get(34806),
		7660,
		4,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660005] = {
		7660005,
		0,
		Lang.get(37587),
		7660,
		5,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7660006] = {
		7660006,
		0,
		"……",
		7660,
		6,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660007] = {
		7660007,
		0,
		Lang.get(37588),
		7660,
		7,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660008] = {
		7660008,
		0,
		Lang.get(37589),
		7660,
		8,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660009] = {
		7660009,
		0,
		Lang.get(37590),
		7660,
		9,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660010] = {
		7660010,
		0,
		Lang.get(34811),
		7660,
		10,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660011] = {
		7660011,
		0,
		Lang.get(34812),
		7660,
		11,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660012] = {
		7660012,
		0,
		Lang.get(34813),
		7660,
		12,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660013] = {
		7660013,
		0,
		Lang.get(34814),
		7660,
		13,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7660014] = {
		7660014,
		0,
		Lang.get(34815),
		7660,
		14,
		216,
		{
			RTResTalkAction[87]
		}
	},
	[7660015] = {
		7660015,
		0,
		Lang.get(37591),
		7660,
		15,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7660016] = {
		7660016,
		0,
		Lang.get(34817),
		7660,
		16,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7660017] = {
		7660017,
		0,
		Lang.get(34818),
		7660,
		17,
		216,
		{
			RTResTalkAction[88]
		}
	},
	[7660018] = {
		7660018,
		0,
		Lang.get(34819),
		7660,
		18,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7660019] = {
		7660019,
		0,
		Lang.get(37592),
		7660,
		19,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7660020] = {
		7660020,
		0,
		Lang.get(37593),
		7660,
		20,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7660021] = {
		7660021,
		0,
		Lang.get(34822),
		7660,
		21,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7660022] = {
		7660022,
		0,
		Lang.get(36953),
		7660,
		22,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7660023] = {
		7660023,
		0,
		Lang.get(34824),
		7660,
		23,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7660024] = {
		7660024,
		0,
		Lang.get(34825),
		7660,
		24,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7660025] = {
		7660025,
		0,
		Lang.get(34826),
		7660,
		25,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7660026] = {
		7660026,
		0,
		Lang.get(36954),
		7660,
		26,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7660027] = {
		7660027,
		0,
		Lang.get(36955),
		7660,
		27,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7660028] = {
		7660028,
		0,
		Lang.get(36956),
		7660,
		28,
		217,
		{
			RTResTalkAction[41]
		}
	},
	[7660029] = {
		7660029,
		0,
		Lang.get(34830),
		7660,
		29,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7660030] = {
		7660030,
		0,
		Lang.get(34831),
		7660,
		30,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7660031] = {
		7660031,
		0,
		Lang.get(37594),
		7660,
		31,
		216,
		{
			RTResTalkAction[89],
			RTResTalkAction[38]
		}
	},
	[7660032] = {
		7660032,
		0,
		Lang.get(34833),
		7660,
		32,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7660033] = {
		7660033,
		0,
		Lang.get(37595),
		7660,
		33,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7660034] = {
		7660034,
		0,
		"……",
		7660,
		34,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7660035] = {
		7660035,
		0,
		Lang.get(34835),
		7660,
		35,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7660036] = {
		7660036,
		0,
		Lang.get(34836),
		7660,
		36,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7661001] = {
		7661001,
		3,
		Lang.get(34837),
		7661,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		48,
		7661,
		1,
		1,
		1,
		nil,
		7661,
		nil,
		nil,
		1
	},
	[7661002] = {
		7661002,
		0,
		Lang.get(37596),
		7661,
		2,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7661003] = {
		7661003,
		0,
		Lang.get(37597),
		7661,
		3,
		216,
		{
			RTResTalkAction[55],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7661004] = {
		7661004,
		0,
		Lang.get(34840),
		7661,
		4,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7661005] = {
		7661005,
		0,
		Lang.get(34841),
		7661,
		5,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7661006] = {
		7661006,
		0,
		Lang.get(34842),
		7661,
		6,
		134,
		{
			RTResTalkAction[1],
			RTResTalkAction[53]
		}
	},
	[7661007] = {
		7661007,
		0,
		Lang.get(34843),
		7661,
		7,
		107,
		{
			RTResTalkAction[66],
			RTResTalkAction[3]
		}
	},
	[7661008] = {
		7661008,
		0,
		Lang.get(34844),
		7661,
		8,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7661009] = {
		7661009,
		0,
		Lang.get(34845),
		7661,
		9,
		107,
		{
			RTResTalkAction[46]
		}
	},
	[7661010] = {
		7661010,
		0,
		Lang.get(34846),
		7661,
		10,
		107,
		{
			RTResTalkAction[68]
		}
	},
	[7661011] = {
		7661011,
		0,
		Lang.get(34847),
		7661,
		11,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7661012] = {
		7661012,
		0,
		Lang.get(34848),
		7661,
		12,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7661013] = {
		7661013,
		0,
		Lang.get(34849),
		7661,
		13,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7661014] = {
		7661014,
		0,
		"……",
		7661,
		14,
		141,
		{
			RTResTalkAction[90]
		}
	},
	[7661015] = {
		7661015,
		0,
		Lang.get(37598),
		7661,
		15,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[24]
		}
	},
	[7661016] = {
		7661016,
		0,
		Lang.get(37599),
		7661,
		16,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[23]
		}
	},
	[7661017] = {
		7661017,
		0,
		Lang.get(37600),
		7661,
		17,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[53]
		}
	},
	[7661018] = {
		7661018,
		0,
		Lang.get(34852),
		7661,
		18,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[64]
		}
	},
	[7661019] = {
		7661019,
		0,
		Lang.get(34853),
		7661,
		19,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[53]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		7662,
		1,
		1,
		1,
		nil,
		7662
	},
	[7661020] = {
		7661020,
		0,
		Lang.get(37601),
		7661,
		20,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7661021] = {
		7661021,
		0,
		Lang.get(34855),
		7661,
		21,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[64]
		},
		nil,
		1,
		3
	},
	[7661022] = {
		7661022,
		0,
		Lang.get(34856),
		7661,
		22,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		}
	},
	[7661023] = {
		7661023,
		0,
		Lang.get(26590),
		7661,
		23,
		107,
		{
			RTResTalkAction[64]
		},
		1,
		6,
		nil,
		nil,
		nil,
		7663,
		1,
		1,
		1,
		nil,
		7663
	},
	[7661024] = {
		7661024,
		0,
		Lang.get(36958),
		7661,
		24,
		134,
		nil,
		1,
		0,
		3
	},
	[7661025] = {
		7661025,
		0,
		Lang.get(37602),
		7661,
		25,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7661026] = {
		7661026,
		0,
		Lang.get(34859),
		7661,
		26,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7661027] = {
		7661027,
		0,
		Lang.get(34860),
		7661,
		27,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[24]
		}
	},
	[7661028] = {
		7661028,
		0,
		Lang.get(19320),
		7661,
		28,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7661029] = {
		7661029,
		0,
		Lang.get(37603),
		7661,
		29,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[23]
		}
	},
	[7661030] = {
		7661030,
		0,
		Lang.get(34862),
		7661,
		30,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7661031] = {
		7661031,
		0,
		Lang.get(37604),
		7661,
		31,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[53]
		}
	},
	[7661032] = {
		7661032,
		0,
		Lang.get(37605),
		7661,
		32,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7661033] = {
		7661033,
		0,
		Lang.get(37606),
		7661,
		33,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7661034] = {
		7661034,
		0,
		Lang.get(34866),
		7661,
		34,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7661035] = {
		7661035,
		0,
		Lang.get(37607),
		7661,
		35,
		107,
		{
			RTResTalkAction[66]
		}
	},
	[7661036] = {
		7661036,
		0,
		Lang.get(36960),
		7661,
		36,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7670001] = {
		7670001,
		0,
		Lang.get(34869),
		7670,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		7670,
		1,
		1,
		1,
		nil,
		7670
	},
	[7670002] = {
		7670002,
		0,
		Lang.get(37608),
		7670,
		2,
		300,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[7670003] = {
		7670003,
		0,
		Lang.get(37609),
		7670,
		3,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7670004] = {
		7670004,
		0,
		Lang.get(34872),
		7670,
		4,
		216,
		{
			RTResTalkAction[71]
		}
	},
	[7670005] = {
		7670005,
		0,
		Lang.get(34873),
		7670,
		5,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7670006] = {
		7670006,
		0,
		Lang.get(34874),
		7670,
		6,
		107,
		{
			RTResTalkAction[91],
			RTResTalkAction[38]
		}
	},
	[7670007] = {
		7670007,
		0,
		Lang.get(34875),
		7670,
		7,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[23]
		}
	},
	[7670008] = {
		7670008,
		0,
		Lang.get(37610),
		7670,
		8,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7670009] = {
		7670009,
		0,
		"……",
		7670,
		9,
		216,
		{
			RTResTalkAction[33],
			RTResTalkAction[64]
		}
	},
	[7670010] = {
		7670010,
		3,
		Lang.get(36961),
		7670,
		10,
		605,
		{
			RTResTalkAction[53]
		},
		[21] = 1
	},
	[7670011] = {
		7670011,
		0,
		Lang.get(37611),
		7670,
		11,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7670012] = {
		7670012,
		0,
		Lang.get(34879),
		7670,
		12,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7670013] = {
		7670013,
		0,
		Lang.get(34880),
		7670,
		13,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7670014] = {
		7670014,
		0,
		Lang.get(34881),
		7670,
		14,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7670015] = {
		7670015,
		0,
		Lang.get(34882),
		7670,
		15,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7670016] = {
		7670016,
		0,
		Lang.get(34883),
		7670,
		16,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7670017] = {
		7670017,
		0,
		Lang.get(34884),
		7670,
		17,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[7670018] = {
		7670018,
		0,
		Lang.get(34885),
		7670,
		18,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23]
		}
	},
	[7670019] = {
		7670019,
		0,
		Lang.get(34886),
		7670,
		19,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7670020] = {
		7670020,
		0,
		Lang.get(37612),
		7670,
		20,
		216,
		{
			RTResTalkAction[55],
			RTResTalkAction[24]
		}
	},
	[7670021] = {
		7670021,
		0,
		Lang.get(36962),
		7670,
		21,
		216,
		{
			RTResTalkAction[32]
		}
	},
	[7670022] = {
		7670022,
		0,
		Lang.get(34889),
		7670,
		22,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7670023] = {
		7670023,
		0,
		Lang.get(37613),
		7670,
		23,
		216,
		{
			RTResTalkAction[55]
		}
	},
	[7670024] = {
		7670024,
		0,
		Lang.get(34891),
		7670,
		24,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7670025] = {
		7670025,
		0,
		Lang.get(34892),
		7670,
		25,
		134,
		{
			RTResTalkAction[92],
			RTResTalkAction[38]
		}
	},
	[7670026] = {
		7670026,
		0,
		Lang.get(34893),
		7670,
		26,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[7670027] = {
		7670027,
		0,
		Lang.get(34894),
		7670,
		27,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[23]
		}
	},
	[7670028] = {
		7670028,
		3,
		Lang.get(36963),
		7670,
		28,
		605,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		3,
		nil,
		60,
		7671,
		1.2,
		1,
		1,
		nil,
		7671,
		nil,
		nil,
		1
	},
	[7670029] = {
		7670029,
		0,
		Lang.get(36964),
		7670,
		29,
		20,
		{
			RTResTalkAction[93]
		}
	},
	[7670030] = {
		7670030,
		0,
		Lang.get(34897),
		7670,
		30,
		561,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[7670031] = {
		7670031,
		0,
		Lang.get(34898),
		7670,
		31,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[96]
		}
	},
	[7670032] = {
		7670032,
		0,
		Lang.get(34899),
		7670,
		32,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7670033] = {
		7670033,
		0,
		Lang.get(34900),
		7670,
		33,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7670034] = {
		7670034,
		0,
		Lang.get(34901),
		7670,
		34,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[53]
		}
	},
	[7670035] = {
		7670035,
		0,
		Lang.get(34902),
		7670,
		35,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[24]
		}
	},
	[7670036] = {
		7670036,
		0,
		Lang.get(34903),
		7670,
		36,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7670037] = {
		7670037,
		0,
		Lang.get(34904),
		7670,
		37,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7670038] = {
		7670038,
		0,
		Lang.get(36965),
		7670,
		38,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7680001] = {
		7680001,
		0,
		Lang.get(37614),
		7680,
		1,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		62,
		7680,
		0.8,
		1,
		1,
		nil,
		7680
	},
	[7680002] = {
		7680002,
		0,
		Lang.get(34907),
		7680,
		2,
		216,
		nil,
		1,
		0,
		3
	},
	[7680003] = {
		7680003,
		0,
		Lang.get(34908),
		7680,
		3,
		107,
		{
			RTResTalkAction[97]
		}
	},
	[7680004] = {
		7680004,
		0,
		Lang.get(34909),
		7680,
		4,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7680005] = {
		7680005,
		0,
		Lang.get(36966),
		7680,
		5,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7680006] = {
		7680006,
		0,
		Lang.get(36967),
		7680,
		6,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7680007] = {
		7680007,
		0,
		Lang.get(37615),
		7680,
		7,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7680008] = {
		7680008,
		0,
		Lang.get(37616),
		7680,
		8,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7680009] = {
		7680009,
		0,
		Lang.get(37617),
		7680,
		9,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7680010] = {
		7680010,
		0,
		"……",
		7680,
		10,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7681001] = {
		7681001,
		0,
		Lang.get(36969),
		7681,
		1,
		107,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3,
		nil,
		62,
		7680,
		1,
		1,
		nil,
		nil,
		7680
	},
	[7681002] = {
		7681002,
		0,
		Lang.get(34916),
		7681,
		2,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7681003] = {
		7681003,
		0,
		Lang.get(34917),
		7681,
		3,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[7681004] = {
		7681004,
		0,
		Lang.get(34918),
		7681,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7681005] = {
		7681005,
		0,
		Lang.get(37618),
		7681,
		5,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7681006] = {
		7681006,
		0,
		Lang.get(36970),
		7681,
		6,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[38]
		}
	},
	[7681007] = {
		7681007,
		0,
		Lang.get(22381),
		7681,
		7,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7681008] = {
		7681008,
		0,
		Lang.get(36971),
		7681,
		8,
		134,
		{
			RTResTalkAction[76]
		}
	},
	[7681009] = {
		7681009,
		0,
		Lang.get(34922),
		7681,
		9,
		107,
		{
			RTResTalkAction[30],
			RTResTalkAction[3]
		}
	},
	[7681010] = {
		7681010,
		0,
		Lang.get(37619),
		7681,
		10,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7681011] = {
		7681011,
		0,
		"……",
		7681,
		11,
		216,
		{
			RTResTalkAction[73],
			RTResTalkAction[23]
		}
	},
	[7681012] = {
		7681012,
		0,
		Lang.get(37620),
		7681,
		12,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[53]
		}
	},
	[7681013] = {
		7681013,
		0,
		Lang.get(36972),
		7681,
		13,
		216,
		{
			RTResTalkAction[98],
			RTResTalkAction[24]
		}
	},
	[7681014] = {
		7681014,
		0,
		Lang.get(36973),
		7681,
		14,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7681015] = {
		7681015,
		0,
		Lang.get(34927),
		7681,
		15,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681016] = {
		7681016,
		0,
		Lang.get(34928),
		7681,
		16,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681017] = {
		7681017,
		0,
		Lang.get(34929),
		7681,
		17,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7681018] = {
		7681018,
		0,
		Lang.get(34930),
		7681,
		18,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7681019] = {
		7681019,
		0,
		Lang.get(37621),
		7681,
		19,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7681020] = {
		7681020,
		0,
		Lang.get(37622),
		7681,
		20,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[53]
		}
	},
	[7681021] = {
		7681021,
		0,
		Lang.get(36974),
		7681,
		21,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7681022] = {
		7681022,
		0,
		Lang.get(37623),
		7681,
		22,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7681023] = {
		7681023,
		0,
		Lang.get(36976),
		7681,
		23,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[7681024] = {
		7681024,
		3,
		Lang.get(36977),
		7681,
		24,
		605,
		{
			RTResTalkAction[38]
		},
		[21] = 1
	},
	[7681025] = {
		7681025,
		0,
		Lang.get(37624),
		7681,
		25,
		300,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		7681,
		1,
		1,
		1,
		nil,
		7681
	},
	[7681026] = {
		7681026,
		0,
		Lang.get(37625),
		7681,
		26,
		216,
		{
			RTResTalkAction[71],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7681027] = {
		7681027,
		0,
		Lang.get(34939),
		7681,
		27,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[53]
		}
	},
	[7681028] = {
		7681028,
		0,
		Lang.get(34940),
		7681,
		28,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7681029] = {
		7681029,
		0,
		Lang.get(37626),
		7681,
		29,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7681030] = {
		7681030,
		0,
		Lang.get(37627),
		7681,
		30,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681031] = {
		7681031,
		0,
		Lang.get(36978),
		7681,
		31,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7681032] = {
		7681032,
		0,
		Lang.get(37628),
		7681,
		32,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681033] = {
		7681033,
		0,
		Lang.get(34945),
		7681,
		33,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7681034] = {
		7681034,
		0,
		Lang.get(24009),
		7681,
		34,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681035] = {
		7681035,
		0,
		Lang.get(37629),
		7681,
		35,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681036] = {
		7681036,
		0,
		Lang.get(34947),
		7681,
		36,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7681037] = {
		7681037,
		0,
		Lang.get(34948),
		7681,
		37,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7681038] = {
		7681038,
		0,
		Lang.get(37630),
		7681,
		38,
		107,
		{
			RTResTalkAction[99],
			RTResTalkAction[53]
		}
	},
	[7681039] = {
		7681039,
		0,
		Lang.get(34950),
		7681,
		39,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7681040] = {
		7681040,
		0,
		Lang.get(37631),
		7681,
		40,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7681041] = {
		7681041,
		0,
		Lang.get(34952),
		7681,
		41,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7681042] = {
		7681042,
		0,
		Lang.get(34953),
		7681,
		42,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7681043] = {
		7681043,
		0,
		"？？？",
		7681,
		43,
		217,
		{
			RTResTalkAction[100]
		}
	},
	[7681044] = {
		7681044,
		0,
		Lang.get(34954),
		7681,
		44,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7681045] = {
		7681045,
		0,
		Lang.get(34955),
		7681,
		45,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7681046] = {
		7681046,
		0,
		Lang.get(34956),
		7681,
		46,
		107,
		{
			RTResTalkAction[101],
			RTResTalkAction[38]
		}
	},
	[7681047] = {
		7681047,
		0,
		Lang.get(37632),
		7681,
		47,
		141,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[7681048] = {
		7681048,
		0,
		Lang.get(37633),
		7681,
		48,
		134,
		{
			RTResTalkAction[102],
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[7681049] = {
		7681049,
		0,
		Lang.get(37634),
		7681,
		49,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7681050] = {
		7681050,
		0,
		Lang.get(34959),
		7681,
		50,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7682001] = {
		7682001,
		3,
		Lang.get(36979),
		7682,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		3,
		7682,
		1,
		1,
		1,
		nil,
		7682,
		nil,
		nil,
		1
	},
	[7682002] = {
		7682002,
		0,
		Lang.get(36980),
		7682,
		2,
		300
	},
	[7682003] = {
		7682003,
		0,
		Lang.get(34962),
		7682,
		3,
		300
	},
	[7682004] = {
		7682004,
		0,
		Lang.get(34963),
		7682,
		4,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7682005] = {
		7682005,
		0,
		Lang.get(34964),
		7682,
		5,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[7682006] = {
		7682006,
		0,
		"……",
		7682,
		6,
		216,
		nil,
		1,
		0
	},
	[7682007] = {
		7682007,
		0,
		Lang.get(34965),
		7682,
		7,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		7683,
		1,
		1,
		1,
		nil,
		7683
	},
	[7682008] = {
		7682008,
		0,
		Lang.get(34966),
		7682,
		8,
		214,
		{
			RTResTalkAction[103]
		},
		nil,
		nil,
		3
	},
	[7682009] = {
		7682009,
		0,
		Lang.get(34967),
		7682,
		9,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7682010] = {
		7682010,
		0,
		Lang.get(34968),
		7682,
		10,
		20,
		{
			RTResTalkAction[93],
			RTResTalkAction[104]
		}
	},
	[7683001] = {
		7683001,
		0,
		Lang.get(34969),
		7683,
		1,
		215,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7683,
		1,
		1,
		1,
		nil,
		7683
	},
	[7683002] = {
		7683002,
		0,
		Lang.get(34970),
		7683,
		2,
		215,
		{
			RTResTalkAction[106]
		}
	},
	[7683003] = {
		7683003,
		0,
		Lang.get(34971),
		7683,
		3,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7683004] = {
		7683004,
		0,
		"……",
		7683,
		4,
		214,
		{
			RTResTalkAction[103],
			RTResTalkAction[108]
		}
	},
	[7690001] = {
		7690001,
		0,
		Lang.get(34972),
		7690,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		7690,
		0.8,
		1,
		1,
		nil,
		7690
	},
	[7690002] = {
		7690002,
		0,
		Lang.get(34973),
		7690,
		2,
		300
	},
	[7690003] = {
		7690003,
		0,
		Lang.get(34974),
		7690,
		3,
		107,
		{
			RTResTalkAction[66]
		},
		nil,
		nil,
		3
	},
	[7690004] = {
		7690004,
		0,
		Lang.get(34975),
		7690,
		4,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7690005] = {
		7690005,
		0,
		Lang.get(34976),
		7690,
		5,
		107,
		{
			RTResTalkAction[101]
		}
	},
	[7690006] = {
		7690006,
		0,
		Lang.get(34977),
		7690,
		6,
		107,
		{
			RTResTalkAction[28]
		}
	},
	[7690007] = {
		7690007,
		0,
		Lang.get(34978),
		7690,
		7,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7690008] = {
		7690008,
		0,
		Lang.get(34979),
		7690,
		8,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7690009] = {
		7690009,
		0,
		Lang.get(37635),
		7690,
		9,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		}
	},
	[7690010] = {
		7690010,
		0,
		"……",
		7690,
		10,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[64]
		}
	},
	[7690011] = {
		7690011,
		0,
		Lang.get(37636),
		7690,
		11,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7690012] = {
		7690012,
		0,
		Lang.get(34982),
		7690,
		12,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7690013] = {
		7690013,
		2,
		Lang.get(34983),
		7690,
		13,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7690014] = {
		7690014,
		0,
		Lang.get(34984),
		7690,
		14,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7690015] = {
		7690015,
		0,
		Lang.get(34985),
		7690,
		15,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7690016] = {
		7690016,
		0,
		Lang.get(34986),
		7690,
		16,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[38]
		}
	},
	[7690017] = {
		7690017,
		0,
		Lang.get(34987),
		7690,
		17,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23]
		}
	},
	[7690018] = {
		7690018,
		0,
		Lang.get(34988),
		7690,
		18,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7690019] = {
		7690019,
		0,
		Lang.get(34989),
		7690,
		19,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[24]
		}
	},
	[7690020] = {
		7690020,
		0,
		Lang.get(34990),
		7690,
		20,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[64]
		}
	},
	[7690021] = {
		7690021,
		0,
		Lang.get(37637),
		7690,
		21,
		141,
		{
			RTResTalkAction[29]
		}
	},
	[7690022] = {
		7690022,
		0,
		Lang.get(37638),
		7690,
		22,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[24]
		}
	},
	[7690023] = {
		7690023,
		3,
		Lang.get(37639),
		7690,
		23,
		605,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		},
		[21] = 1
	},
	[7690024] = {
		7690024,
		0,
		Lang.get(34993),
		7690,
		24,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[64]
		}
	},
	[7690025] = {
		7690025,
		0,
		Lang.get(34994),
		7690,
		25,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7690026] = {
		7690026,
		0,
		Lang.get(37640),
		7690,
		26,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7690027] = {
		7690027,
		0,
		Lang.get(34996),
		7690,
		27,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[53]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7691,
		0.8,
		1,
		1,
		nil,
		7691
	},
	[7690028] = {
		7690028,
		0,
		Lang.get(34997),
		7690,
		28,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7690029] = {
		7690029,
		0,
		Lang.get(34998),
		7690,
		29,
		134,
		{
			RTResTalkAction[9]
		}
	},
	[7692001] = {
		7692001,
		0,
		Lang.get(34999),
		7692,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		133,
		nil,
		nil,
		nil,
		1,
		[18] = 7692
	},
	[7692002] = {
		7692002,
		0,
		Lang.get(36983),
		7692,
		2,
		300
	},
	[7692003] = {
		7692003,
		0,
		"！！！",
		7692,
		3,
		107,
		nil,
		1,
		6
	},
	[7692004] = {
		7692004,
		0,
		Lang.get(35001),
		7692,
		4,
		107,
		nil,
		1,
		0
	},
	[7692005] = {
		7692005,
		0,
		Lang.get(35002),
		7692,
		5,
		141,
		nil,
		1,
		0
	},
	[7692006] = {
		7692006,
		0,
		Lang.get(37641),
		7692,
		6,
		300
	},
	[7692007] = {
		7692007,
		0,
		Lang.get(34768),
		7692,
		7,
		216,
		nil,
		1,
		0
	},
	[7692008] = {
		7692008,
		0,
		Lang.get(35004),
		7692,
		8,
		216,
		nil,
		1,
		0
	},
	[7692009] = {
		7692009,
		0,
		Lang.get(37642),
		7692,
		9,
		300
	},
	[7692010] = {
		7692010,
		0,
		Lang.get(36986),
		7692,
		10,
		216,
		nil,
		1,
		1
	},
	[7692011] = {
		7692011,
		0,
		Lang.get(36987),
		7692,
		11,
		300
	},
	[7692012] = {
		7692012,
		0,
		Lang.get(36988),
		7692,
		12,
		107,
		nil,
		1,
		5
	},
	[7692013] = {
		7692013,
		0,
		Lang.get(36989),
		7692,
		13,
		217,
		nil,
		1,
		0
	},
	[7692014] = {
		7692014,
		0,
		Lang.get(37643),
		7692,
		14,
		300
	},
	[7692015] = {
		7692015,
		0,
		Lang.get(35011),
		7692,
		15,
		217,
		nil,
		1,
		0
	},
	[7692016] = {
		7692016,
		0,
		Lang.get(35012),
		7692,
		16,
		217,
		nil,
		1,
		0
	},
	[7692017] = {
		7692017,
		0,
		Lang.get(36990),
		7692,
		17,
		217,
		nil,
		1,
		0
	},
	[7692018] = {
		7692018,
		0,
		"……",
		7692,
		18,
		300
	},
	[7692019] = {
		7692019,
		0,
		Lang.get(36991),
		7692,
		19,
		300
	},
	[7700001] = {
		7700001,
		0,
		Lang.get(37644),
		7700,
		1,
		300,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3,
		nil,
		60,
		7700,
		1,
		1,
		1,
		nil,
		7700
	},
	[7700002] = {
		7700002,
		0,
		Lang.get(37645),
		7700,
		2,
		300,
		{
			RTResTalkAction[28],
			RTResTalkAction[64]
		}
	},
	[7700003] = {
		7700003,
		0,
		Lang.get(35017),
		7700,
		3,
		107,
		{
			RTResTalkAction[46]
		}
	},
	[7700004] = {
		7700004,
		0,
		Lang.get(36993),
		7700,
		4,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7700005] = {
		7700005,
		0,
		Lang.get(35019),
		7700,
		5,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7700006] = {
		7700006,
		0,
		Lang.get(35020),
		7700,
		6,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[38]
		}
	},
	[7700007] = {
		7700007,
		0,
		Lang.get(36994),
		7700,
		7,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[7700008] = {
		7700008,
		0,
		Lang.get(37646),
		7700,
		8,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7700009] = {
		7700009,
		0,
		Lang.get(37647),
		7700,
		9,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7700010] = {
		7700010,
		0,
		Lang.get(35024),
		7700,
		10,
		216,
		{
			RTResTalkAction[82]
		}
	},
	[7700011] = {
		7700011,
		0,
		Lang.get(35025),
		7700,
		11,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7700012] = {
		7700012,
		0,
		Lang.get(35026),
		7700,
		12,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[53]
		}
	},
	[7700013] = {
		7700013,
		0,
		Lang.get(35027),
		7700,
		13,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[38]
		}
	},
	[7700014] = {
		7700014,
		0,
		Lang.get(36995),
		7700,
		14,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7700015] = {
		7700015,
		0,
		Lang.get(37648),
		7700,
		15,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[7700016] = {
		7700016,
		0,
		Lang.get(35030),
		7700,
		16,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7700017] = {
		7700017,
		0,
		"……",
		7700,
		17,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7700018] = {
		7700018,
		0,
		Lang.get(37649),
		7700,
		18,
		107,
		{
			RTResTalkAction[109],
			RTResTalkAction[53]
		}
	},
	[7700019] = {
		7700019,
		0,
		Lang.get(37650),
		7700,
		19,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7700020] = {
		7700020,
		0,
		Lang.get(36997),
		7700,
		20,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7700021] = {
		7700021,
		0,
		Lang.get(35034),
		7700,
		21,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7700022] = {
		7700022,
		0,
		Lang.get(35035),
		7700,
		22,
		134,
		{
			RTResTalkAction[6],
			RTResTalkAction[38]
		}
	},
	[7701001] = {
		7701001,
		3,
		Lang.get(37651),
		7701,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		7701,
		nil,
		1,
		1,
		nil,
		7701,
		nil,
		nil,
		1
	},
	[7701002] = {
		7701002,
		0,
		Lang.get(37652),
		7701,
		2,
		300,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[7701003] = {
		7701003,
		0,
		Lang.get(35038),
		7701,
		3,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7701004] = {
		7701004,
		0,
		Lang.get(35039),
		7701,
		4,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7701005] = {
		7701005,
		0,
		Lang.get(35040),
		7701,
		5,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701006] = {
		7701006,
		0,
		Lang.get(35041),
		7701,
		6,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701007] = {
		7701007,
		0,
		Lang.get(35042),
		7701,
		7,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7701008] = {
		7701008,
		0,
		Lang.get(37653),
		7701,
		8,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701009] = {
		7701009,
		0,
		Lang.get(37654),
		7701,
		9,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7701010] = {
		7701010,
		0,
		Lang.get(35045),
		7701,
		10,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7701011] = {
		7701011,
		0,
		Lang.get(35046),
		7701,
		11,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701012] = {
		7701012,
		0,
		Lang.get(36998),
		7701,
		12,
		216,
		{
			RTResTalkAction[73]
		}
	},
	[7701013] = {
		7701013,
		0,
		Lang.get(35048),
		7701,
		13,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7701014] = {
		7701014,
		0,
		Lang.get(35049),
		7701,
		14,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701015] = {
		7701015,
		0,
		Lang.get(37655),
		7701,
		15,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701016] = {
		7701016,
		0,
		Lang.get(35051),
		7701,
		16,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7701017] = {
		7701017,
		0,
		Lang.get(35052),
		7701,
		17,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701018] = {
		7701018,
		0,
		Lang.get(35053),
		7701,
		18,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701019] = {
		7701019,
		0,
		Lang.get(35054),
		7701,
		19,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701020] = {
		7701020,
		0,
		Lang.get(35055),
		7701,
		20,
		212,
		{
			RTResTalkAction[53]
		}
	},
	[7701021] = {
		7701021,
		0,
		"！！！！！",
		7701,
		21,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7701022] = {
		7701022,
		0,
		Lang.get(37000),
		7701,
		22,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[7710001] = {
		7710001,
		0,
		Lang.get(37656),
		7710,
		1,
		215,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3,
		nil,
		57,
		7710,
		1,
		1,
		1,
		nil,
		7710
	},
	[7710002] = {
		7710002,
		0,
		Lang.get(35057),
		7710,
		2,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7710003] = {
		7710003,
		0,
		Lang.get(37657),
		7710,
		3,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7710004] = {
		7710004,
		0,
		Lang.get(37658),
		7710,
		4,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7710005] = {
		7710005,
		0,
		"……",
		7710,
		5,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[108]
		}
	},
	[7710006] = {
		7710006,
		0,
		Lang.get(37001),
		7710,
		6,
		215,
		{
			RTResTalkAction[110],
			RTResTalkAction[53]
		}
	},
	[7710007] = {
		7710007,
		0,
		Lang.get(35061),
		7710,
		7,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7710008] = {
		7710008,
		0,
		Lang.get(35062),
		7710,
		8,
		215,
		{
			RTResTalkAction[111]
		}
	},
	[7710009] = {
		7710009,
		0,
		Lang.get(35063),
		7710,
		9,
		216,
		{
			RTResTalkAction[74],
			RTResTalkAction[108]
		}
	},
	[7710010] = {
		7710010,
		0,
		Lang.get(35064),
		7710,
		10,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[53]
		}
	},
	[7710011] = {
		7710011,
		0,
		Lang.get(35065),
		7710,
		11,
		215,
		{
			RTResTalkAction[105]
		}
	},
	[7710012] = {
		7710012,
		0,
		Lang.get(35066),
		7710,
		12,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7710013] = {
		7710013,
		0,
		Lang.get(37659),
		7710,
		13,
		216,
		{
			RTResTalkAction[69],
			RTResTalkAction[108]
		}
	},
	[7710014] = {
		7710014,
		3,
		Lang.get(37660),
		7710,
		14,
		605,
		{
			RTResTalkAction[53]
		},
		[21] = 1
	},
	[7710015] = {
		7710015,
		0,
		Lang.get(19756),
		7710,
		15,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7710016] = {
		7710016,
		0,
		Lang.get(35069),
		7710,
		16,
		215,
		{
			RTResTalkAction[110]
		}
	},
	[7710017] = {
		7710017,
		0,
		Lang.get(37661),
		7710,
		17,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[108]
		}
	},
	[7710018] = {
		7710018,
		0,
		Lang.get(35071),
		7710,
		18,
		215,
		{
			RTResTalkAction[112],
			RTResTalkAction[64]
		}
	},
	[7710019] = {
		7710019,
		0,
		Lang.get(35072),
		7710,
		19,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[108]
		}
	},
	[7710020] = {
		7710020,
		0,
		Lang.get(35073),
		7710,
		20,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7710021] = {
		7710021,
		0,
		Lang.get(37662),
		7710,
		21,
		107,
		{
			RTResTalkAction[113],
			RTResTalkAction[38]
		}
	},
	[7710022] = {
		7710022,
		0,
		Lang.get(35075),
		7710,
		22,
		134,
		{
			RTResTalkAction[9],
			RTResTalkAction[23]
		}
	},
	[7710023] = {
		7710023,
		0,
		Lang.get(35076),
		7710,
		23,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7710024] = {
		7710024,
		0,
		Lang.get(35077),
		7710,
		24,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[24]
		}
	},
	[7710025] = {
		7710025,
		0,
		Lang.get(35078),
		7710,
		25,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[64]
		}
	},
	[7710026] = {
		7710026,
		0,
		Lang.get(35079),
		7710,
		26,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[108]
		}
	},
	[7710027] = {
		7710027,
		0,
		Lang.get(35080),
		7710,
		27,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7720001] = {
		7720001,
		0,
		Lang.get(35081),
		7720,
		1,
		217,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7720,
		1,
		1,
		1,
		nil,
		7720
	},
	[7720002] = {
		7720002,
		0,
		Lang.get(35082),
		7720,
		2,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7720003] = {
		7720003,
		0,
		"……",
		7720,
		3,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[38]
		}
	},
	[7720004] = {
		7720004,
		0,
		Lang.get(35083),
		7720,
		4,
		215,
		{
			RTResTalkAction[106]
		}
	},
	[7720005] = {
		7720005,
		0,
		Lang.get(37003),
		7720,
		5,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7720006] = {
		7720006,
		0,
		Lang.get(37004),
		7720,
		6,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[108]
		}
	},
	[7720007] = {
		7720007,
		0,
		Lang.get(35086),
		7720,
		7,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7720008] = {
		7720008,
		0,
		Lang.get(35087),
		7720,
		8,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7722001] = {
		7722001,
		0,
		Lang.get(37005),
		7722,
		1,
		215,
		{
			RTResTalkAction[105]
		},
		nil,
		nil,
		3,
		nil,
		62,
		7720,
		1,
		1,
		1,
		nil,
		7720
	},
	[7722002] = {
		7722002,
		0,
		Lang.get(35089),
		7722,
		2,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7722003] = {
		7722003,
		0,
		Lang.get(35090),
		7722,
		3,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7722004] = {
		7722004,
		0,
		Lang.get(35091),
		7722,
		4,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722005] = {
		7722005,
		0,
		Lang.get(35092),
		7722,
		5,
		215,
		{
			RTResTalkAction[112]
		}
	},
	[7722006] = {
		7722006,
		0,
		"……",
		7722,
		6,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7722007] = {
		7722007,
		0,
		Lang.get(35093),
		7722,
		7,
		215,
		{
			RTResTalkAction[105]
		}
	},
	[7722008] = {
		7722008,
		0,
		Lang.get(35094),
		7722,
		8,
		216,
		{
			RTResTalkAction[74],
			RTResTalkAction[108]
		}
	},
	[7722009] = {
		7722009,
		0,
		"……",
		7722,
		9,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7722010] = {
		7722010,
		0,
		Lang.get(35095),
		7722,
		10,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722011] = {
		7722011,
		2,
		Lang.get(35096),
		7722,
		11,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722012] = {
		7722012,
		0,
		Lang.get(37663),
		7722,
		12,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[53]
		}
	},
	[7722013] = {
		7722013,
		0,
		Lang.get(35098),
		7722,
		13,
		216,
		{
			RTResTalkAction[89],
			RTResTalkAction[108]
		}
	},
	[7722014] = {
		7722014,
		0,
		Lang.get(35099),
		7722,
		14,
		215,
		{
			RTResTalkAction[114],
			RTResTalkAction[53]
		}
	},
	[7722015] = {
		7722015,
		0,
		Lang.get(37664),
		7722,
		15,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722016] = {
		7722016,
		0,
		Lang.get(37665),
		7722,
		16,
		215,
		{
			RTResTalkAction[106]
		}
	},
	[7722017] = {
		7722017,
		0,
		"……",
		7722,
		17,
		216,
		{
			RTResTalkAction[54],
			RTResTalkAction[108]
		}
	},
	[7722018] = {
		7722018,
		0,
		Lang.get(35102),
		7722,
		18,
		215,
		{
			RTResTalkAction[111],
			RTResTalkAction[53]
		}
	},
	[7722019] = {
		7722019,
		0,
		Lang.get(35103),
		7722,
		19,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722020] = {
		7722020,
		0,
		"……",
		7722,
		20,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[108]
		}
	},
	[7722021] = {
		7722021,
		0,
		Lang.get(37006),
		7722,
		21,
		215,
		{
			RTResTalkAction[107],
			RTResTalkAction[64]
		}
	},
	[7722022] = {
		7722022,
		0,
		Lang.get(37666),
		7722,
		22,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722023] = {
		7722023,
		0,
		Lang.get(35106),
		7722,
		23,
		215,
		{
			RTResTalkAction[112]
		}
	},
	[7722024] = {
		7722024,
		0,
		"……！",
		7722,
		24,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[108]
		}
	},
	[7722025] = {
		7722025,
		0,
		Lang.get(35107),
		7722,
		25,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[53]
		}
	},
	[7722026] = {
		7722026,
		0,
		Lang.get(37667),
		7722,
		26,
		215,
		{
			RTResTalkAction[115]
		}
	},
	[7722027] = {
		7722027,
		0,
		Lang.get(37668),
		7722,
		27,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722028] = {
		7722028,
		0,
		Lang.get(35110),
		7722,
		28,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722029] = {
		7722029,
		0,
		Lang.get(37009),
		7722,
		29,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722030] = {
		7722030,
		0,
		Lang.get(35112),
		7722,
		30,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[108]
		}
	},
	[7722031] = {
		7722031,
		0,
		Lang.get(35113),
		7722,
		31,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722032] = {
		7722032,
		0,
		Lang.get(35114),
		7722,
		32,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722033] = {
		7722033,
		0,
		Lang.get(35115),
		7722,
		33,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722034] = {
		7722034,
		0,
		Lang.get(35116),
		7722,
		34,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7722035] = {
		7722035,
		0,
		Lang.get(37669),
		7722,
		35,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7722036] = {
		7722036,
		0,
		Lang.get(37670),
		7722,
		36,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7722037] = {
		7722037,
		0,
		Lang.get(19320),
		7722,
		37,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722038] = {
		7722038,
		2,
		Lang.get(35119),
		7722,
		38,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722039] = {
		7722039,
		0,
		Lang.get(35120),
		7722,
		39,
		216,
		{
			RTResTalkAction[89]
		}
	},
	[7722040] = {
		7722040,
		0,
		Lang.get(35121),
		7722,
		40,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722041] = {
		7722041,
		0,
		Lang.get(35122),
		7722,
		41,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7722042] = {
		7722042,
		0,
		Lang.get(35123),
		7722,
		42,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7722043] = {
		7722043,
		0,
		Lang.get(37671),
		7722,
		43,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7722044] = {
		7722044,
		0,
		Lang.get(37010),
		7722,
		44,
		215,
		{
			RTResTalkAction[114],
			RTResTalkAction[53]
		}
	},
	[7722045] = {
		7722045,
		0,
		Lang.get(35126),
		7722,
		45,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7722046] = {
		7722046,
		0,
		Lang.get(37011),
		7722,
		46,
		300,
		{
			RTResTalkAction[34],
			RTResTalkAction[108]
		}
	},
	[7722047] = {
		7722047,
		0,
		Lang.get(35128),
		7722,
		47,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722048] = {
		7722048,
		0,
		Lang.get(37012),
		7722,
		48,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722049] = {
		7722049,
		0,
		Lang.get(37013),
		7722,
		49,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722050] = {
		7722050,
		0,
		Lang.get(35131),
		7722,
		50,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722051] = {
		7722051,
		0,
		Lang.get(35132),
		7722,
		51,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7722052] = {
		7722052,
		0,
		Lang.get(35133),
		7722,
		52,
		107,
		{
			RTResTalkAction[116],
			RTResTalkAction[53]
		}
	},
	[7722053] = {
		7722053,
		0,
		Lang.get(37014),
		7722,
		53,
		107,
		{
			RTResTalkAction[101]
		}
	},
	[7722054] = {
		7722054,
		0,
		Lang.get(37015),
		7722,
		54,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7722055] = {
		7722055,
		0,
		Lang.get(37016),
		7722,
		55,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[24]
		}
	},
	[7722056] = {
		7722056,
		0,
		Lang.get(37017),
		7722,
		56,
		134,
		{
			RTResTalkAction[6],
			RTResTalkAction[23]
		}
	},
	[7722057] = {
		7722057,
		0,
		Lang.get(35137),
		7722,
		57,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[3]
		}
	},
	[7722058] = {
		7722058,
		0,
		Lang.get(35138),
		7722,
		58,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[24]
		}
	},
	[7722059] = {
		7722059,
		0,
		Lang.get(35139),
		7722,
		59,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[53]
		}
	},
	[7721001] = {
		7721001,
		0,
		Lang.get(29174),
		7721,
		1,
		217,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		62,
		7721,
		1,
		1,
		1,
		nil,
		7721
	},
	[7721002] = {
		7721002,
		0,
		Lang.get(37018),
		7721,
		2,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721003] = {
		7721003,
		0,
		Lang.get(35141),
		7721,
		3,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721004] = {
		7721004,
		0,
		Lang.get(22568),
		7721,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721005] = {
		7721005,
		0,
		Lang.get(37019),
		7721,
		5,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721006] = {
		7721006,
		0,
		"……",
		7721,
		6,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721007] = {
		7721007,
		0,
		Lang.get(37672),
		7721,
		7,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721008] = {
		7721008,
		0,
		Lang.get(35145),
		7721,
		8,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721009] = {
		7721009,
		0,
		Lang.get(37021),
		7721,
		9,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721010] = {
		7721010,
		0,
		Lang.get(35147),
		7721,
		10,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721011] = {
		7721011,
		0,
		Lang.get(35148),
		7721,
		11,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7721012] = {
		7721012,
		0,
		"……",
		7721,
		12,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721013] = {
		7721013,
		0,
		Lang.get(35149),
		7721,
		13,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721014] = {
		7721014,
		0,
		Lang.get(35150),
		7721,
		14,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7721015] = {
		7721015,
		0,
		Lang.get(37673),
		7721,
		15,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730001] = {
		7730001,
		0,
		Lang.get(35152),
		7730,
		1,
		300,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		7730,
		nil,
		nil,
		1,
		nil,
		7730
	},
	[7730002] = {
		7730002,
		0,
		Lang.get(35153),
		7730,
		2,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7730003] = {
		7730003,
		0,
		Lang.get(37022),
		7730,
		3,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730004] = {
		7730004,
		0,
		Lang.get(35155),
		7730,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730005] = {
		7730005,
		0,
		Lang.get(37023),
		7730,
		5,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730006] = {
		7730006,
		0,
		Lang.get(37024),
		7730,
		6,
		217,
		{
			RTResTalkAction[83]
		}
	},
	[7730007] = {
		7730007,
		0,
		Lang.get(37025),
		7730,
		7,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730008] = {
		7730008,
		0,
		Lang.get(37026),
		7730,
		8,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730009] = {
		7730009,
		0,
		Lang.get(37027),
		7730,
		9,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730010] = {
		7730010,
		0,
		Lang.get(37674),
		7730,
		10,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730011] = {
		7730011,
		0,
		Lang.get(35162),
		7730,
		11,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730012] = {
		7730012,
		0,
		Lang.get(35163),
		7730,
		12,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730013] = {
		7730013,
		0,
		Lang.get(37029),
		7730,
		13,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730014] = {
		7730014,
		0,
		Lang.get(35165),
		7730,
		14,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730015] = {
		7730015,
		0,
		Lang.get(35166),
		7730,
		15,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[38]
		}
	},
	[7730016] = {
		7730016,
		0,
		Lang.get(35167),
		7730,
		16,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7730017] = {
		7730017,
		0,
		Lang.get(35168),
		7730,
		17,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7730018] = {
		7730018,
		0,
		"……",
		7730,
		18,
		215,
		{
			RTResTalkAction[107],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7731,
		0.5,
		1,
		nil,
		nil,
		7731
	},
	[7730019] = {
		7730019,
		0,
		Lang.get(37675),
		7730,
		19,
		300,
		{
			RTResTalkAction[63],
			RTResTalkAction[108]
		}
	},
	[7730020] = {
		7730020,
		3,
		Lang.get(37676),
		7730,
		20,
		605,
		{
			RTResTalkAction[64]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[21] = 1
	},
	[7730021] = {
		7730021,
		0,
		Lang.get(35171),
		7730,
		21,
		215,
		{
			RTResTalkAction[112]
		}
	},
	[7730022] = {
		7730022,
		0,
		Lang.get(35172),
		7730,
		22,
		215,
		{
			RTResTalkAction[110]
		}
	},
	[7730023] = {
		7730023,
		0,
		Lang.get(35173),
		7730,
		23,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730024] = {
		7730024,
		0,
		Lang.get(35174),
		7730,
		24,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730025] = {
		7730025,
		0,
		Lang.get(35175),
		7730,
		25,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730026] = {
		7730026,
		0,
		Lang.get(35176),
		7730,
		26,
		215,
		{
			RTResTalkAction[105]
		}
	},
	[7730027] = {
		7730027,
		0,
		Lang.get(35177),
		7730,
		27,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730028] = {
		7730028,
		0,
		Lang.get(37030),
		7730,
		28,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730029] = {
		7730029,
		0,
		Lang.get(35179),
		7730,
		29,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730030] = {
		7730030,
		0,
		Lang.get(35180),
		7730,
		30,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730031] = {
		7730031,
		0,
		"……",
		7730,
		31,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730032] = {
		7730032,
		0,
		Lang.get(35181),
		7730,
		32,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730033] = {
		7730033,
		0,
		Lang.get(37031),
		7730,
		33,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730034] = {
		7730034,
		0,
		Lang.get(37032),
		7730,
		34,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730035] = {
		7730035,
		0,
		Lang.get(35184),
		7730,
		35,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730036] = {
		7730036,
		0,
		Lang.get(37677),
		7730,
		36,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730037] = {
		7730037,
		0,
		Lang.get(37034),
		7730,
		37,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730038] = {
		7730038,
		0,
		Lang.get(35187),
		7730,
		38,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730039] = {
		7730039,
		0,
		Lang.get(35188),
		7730,
		39,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730040] = {
		7730040,
		0,
		"……",
		7730,
		40,
		215,
		{
			RTResTalkAction[115]
		}
	},
	[7730041] = {
		7730041,
		0,
		Lang.get(37678),
		7730,
		41,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730042] = {
		7730042,
		0,
		Lang.get(37036),
		7730,
		42,
		215,
		{
			RTResTalkAction[105]
		}
	},
	[7730043] = {
		7730043,
		0,
		Lang.get(37037),
		7730,
		43,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730044] = {
		7730044,
		0,
		Lang.get(35192),
		7730,
		44,
		215,
		{
			RTResTalkAction[106]
		}
	},
	[7730045] = {
		7730045,
		0,
		Lang.get(35193),
		7730,
		45,
		215,
		{
			RTResTalkAction[105]
		}
	},
	[7730046] = {
		7730046,
		0,
		Lang.get(37038),
		7730,
		46,
		300,
		{
			RTResTalkAction[107]
		}
	},
	[7730047] = {
		7730047,
		0,
		Lang.get(37039),
		7730,
		47,
		215,
		{
			RTResTalkAction[106]
		}
	},
	[7730048] = {
		7730048,
		0,
		Lang.get(37040),
		7730,
		48,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730049] = {
		7730049,
		0,
		Lang.get(35197),
		7730,
		49,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730050] = {
		7730050,
		0,
		Lang.get(35198),
		7730,
		50,
		300,
		{
			RTResTalkAction[36],
			RTResTalkAction[108]
		}
	},
	[7730051] = {
		7730051,
		0,
		Lang.get(35199),
		7730,
		51,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730052] = {
		7730052,
		0,
		Lang.get(35200),
		7730,
		52,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730053] = {
		7730053,
		0,
		Lang.get(37041),
		7730,
		53,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7730054] = {
		7730054,
		0,
		Lang.get(35202),
		7730,
		54,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730055] = {
		7730055,
		0,
		Lang.get(35203),
		7730,
		55,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7730056] = {
		7730056,
		0,
		"……",
		7730,
		56,
		215,
		{
			RTResTalkAction[105],
			RTResTalkAction[38]
		}
	},
	[7730057] = {
		7730057,
		0,
		Lang.get(35204),
		7730,
		57,
		215,
		{
			RTResTalkAction[107]
		}
	},
	[7730058] = {
		7730058,
		3,
		Lang.get(35205),
		7730,
		58,
		605,
		{
			RTResTalkAction[108]
		},
		[21] = 1
	},
	[7732001] = {
		7732001,
		0,
		"……",
		7732,
		1,
		216,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3,
		nil,
		133,
		7732,
		1,
		1,
		1,
		nil,
		7732
	},
	[7732002] = {
		7732002,
		0,
		Lang.get(35206),
		7732,
		2,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7732003] = {
		7732003,
		0,
		Lang.get(37042),
		7732,
		3,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7732004] = {
		7732004,
		0,
		Lang.get(35208),
		7732,
		4,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7732005] = {
		7732005,
		0,
		Lang.get(37679),
		7732,
		5,
		216,
		{
			RTResTalkAction[72]
		}
	},
	[7732006] = {
		7732006,
		0,
		Lang.get(35210),
		7732,
		6,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7732007] = {
		7732007,
		0,
		Lang.get(35211),
		7732,
		7,
		216,
		{
			RTResTalkAction[54]
		}
	},
	[7732008] = {
		7732008,
		3,
		Lang.get(35212),
		7732,
		8,
		605,
		{
			RTResTalkAction[53]
		},
		[21] = 1
	},
	[7732009] = {
		7732009,
		3,
		Lang.get(35213),
		7732,
		9,
		605,
		[21] = 1
	},
	[7732010] = {
		7732010,
		0,
		Lang.get(35214),
		7732,
		10,
		216,
		{
			RTResTalkAction[73]
		}
	},
	[7732011] = {
		7732011,
		0,
		Lang.get(35215),
		7732,
		11,
		216,
		{
			RTResTalkAction[33]
		}
	},
	[7750001] = {
		7750001,
		0,
		Lang.get(26508),
		7750,
		1,
		300,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3,
		nil,
		62,
		7750,
		1,
		1,
		1,
		nil,
		7750
	},
	[7750002] = {
		7750002,
		0,
		Lang.get(35216),
		7750,
		2,
		107,
		{
			RTResTalkAction[117]
		}
	},
	[7750003] = {
		7750003,
		0,
		Lang.get(35217),
		7750,
		3,
		300,
		{
			RTResTalkAction[28]
		}
	},
	[7750004] = {
		7750004,
		0,
		Lang.get(35218),
		7750,
		4,
		134,
		{
			RTResTalkAction[118],
			RTResTalkAction[23]
		}
	},
	[7750005] = {
		7750005,
		0,
		Lang.get(35219),
		7750,
		5,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[7750006] = {
		7750006,
		0,
		Lang.get(35220),
		7750,
		6,
		134,
		{
			RTResTalkAction[102],
			RTResTalkAction[38]
		}
	},
	[7750007] = {
		7750007,
		0,
		"？？？",
		7750,
		7,
		217,
		{
			RTResTalkAction[119],
			RTResTalkAction[3]
		}
	},
	[7750008] = {
		7750008,
		0,
		Lang.get(20587),
		7750,
		8,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7750009] = {
		7750009,
		0,
		Lang.get(37043),
		7750,
		9,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[7750010] = {
		7750010,
		0,
		Lang.get(37044),
		7750,
		10,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[38]
		}
	},
	[7750011] = {
		7750011,
		0,
		Lang.get(37045),
		7750,
		11,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7750012] = {
		7750012,
		0,
		Lang.get(35224),
		7750,
		12,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7750013] = {
		7750013,
		0,
		Lang.get(22182),
		7750,
		13,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[24]
		}
	},
	[7750014] = {
		7750014,
		0,
		Lang.get(35225),
		7750,
		14,
		134,
		{
			RTResTalkAction[76],
			RTResTalkAction[23]
		}
	},
	[7750015] = {
		7750015,
		0,
		Lang.get(35226),
		7750,
		15,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7750016] = {
		7750016,
		3,
		Lang.get(35227),
		7750,
		16,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		7751,
		nil,
		1,
		1,
		nil,
		7751,
		nil,
		nil,
		1
	},
	[7750017] = {
		7750017,
		0,
		Lang.get(35228),
		7750,
		17,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7750018] = {
		7750018,
		0,
		Lang.get(35229),
		7750,
		18,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7750019] = {
		7750019,
		0,
		Lang.get(35230),
		7750,
		19,
		141,
		{
			RTResTalkAction[29],
			RTResTalkAction[23]
		}
	},
	[7750020] = {
		7750020,
		0,
		Lang.get(35231),
		7750,
		20,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7750021] = {
		7750021,
		0,
		Lang.get(35232),
		7750,
		21,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7750022] = {
		7750022,
		0,
		Lang.get(35233),
		7750,
		22,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7750023] = {
		7750023,
		0,
		Lang.get(35234),
		7750,
		23,
		300,
		{
			RTResTalkAction[29]
		}
	},
	[7750024] = {
		7750024,
		0,
		Lang.get(37680),
		7750,
		24,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[24]
		}
	},
	[7750025] = {
		7750025,
		0,
		Lang.get(35236),
		7750,
		25,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[23]
		}
	},
	[7750026] = {
		7750026,
		0,
		Lang.get(22460),
		7750,
		26,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7750027] = {
		7750027,
		0,
		Lang.get(35237),
		7750,
		27,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[7750028] = {
		7750028,
		0,
		Lang.get(35238),
		7750,
		28,
		217,
		{
			RTResTalkAction[36]
		}
	},
	[7750029] = {
		7750029,
		0,
		Lang.get(23717),
		7750,
		29,
		218,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[7750030] = {
		7750030,
		0,
		Lang.get(35239),
		7750,
		30,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[39]
		}
	},
	[7750031] = {
		7750031,
		0,
		Lang.get(35240),
		7750,
		31,
		214,
		{
			RTResTalkAction[103],
			RTResTalkAction[38]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		7752,
		0.8,
		1,
		1,
		nil,
		7752
	},
	[7750032] = {
		7750032,
		0,
		Lang.get(35241),
		7750,
		32,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[7750033] = {
		7750033,
		3,
		Lang.get(37681),
		7750,
		33,
		605,
		{
			RTResTalkAction[104]
		},
		[21] = 1
	},
	[7750034] = {
		7750034,
		0,
		Lang.get(37046),
		7750,
		34,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750035] = {
		7750035,
		0,
		Lang.get(37047),
		7750,
		35,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[7750036] = {
		7750036,
		0,
		"……",
		7750,
		36,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750037] = {
		7750037,
		0,
		Lang.get(37048),
		7750,
		37,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750038] = {
		7750038,
		0,
		Lang.get(37049),
		7750,
		38,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750039] = {
		7750039,
		0,
		Lang.get(37050),
		7750,
		39,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750040] = {
		7750040,
		0,
		Lang.get(35248),
		7750,
		40,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[7750041] = {
		7750041,
		0,
		Lang.get(37051),
		7750,
		41,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750042] = {
		7750042,
		0,
		Lang.get(37052),
		7750,
		42,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[7750043] = {
		7750043,
		0,
		Lang.get(37053),
		7750,
		43,
		214,
		{
			RTResTalkAction[103]
		}
	},
	[7750044] = {
		7750044,
		0,
		Lang.get(37054),
		7750,
		44,
		217,
		{
			RTResTalkAction[36],
			RTResTalkAction[104]
		}
	},
	[7750045] = {
		7750045,
		0,
		Lang.get(35253),
		7750,
		45,
		214,
		{
			RTResTalkAction[120],
			RTResTalkAction[38]
		}
	},
	[7753001] = {
		7753001,
		3,
		Lang.get(35254),
		7753,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		133,
		7753,
		1,
		1,
		nil,
		nil,
		7753,
		nil,
		nil,
		1
	},
	[7753002] = {
		7753002,
		0,
		Lang.get(35255),
		7753,
		2,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7753003] = {
		7753003,
		0,
		Lang.get(37055),
		7753,
		3,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7753004] = {
		7753004,
		0,
		Lang.get(37056),
		7753,
		4,
		217,
		{
			RTResTalkAction[83],
			RTResTalkAction[64]
		}
	},
	[7753005] = {
		7753005,
		0,
		Lang.get(37682),
		7753,
		5,
		134,
		{
			RTResTalkAction[31],
			RTResTalkAction[38]
		}
	},
	[7753006] = {
		7753006,
		0,
		Lang.get(35259),
		7753,
		6,
		300,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0
	},
	[7753007] = {
		7753007,
		0,
		Lang.get(35260),
		7753,
		7,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[7753008] = {
		7753008,
		3,
		Lang.get(37058),
		7753,
		8,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		133,
		7754,
		nil,
		1,
		1,
		nil,
		7754,
		nil,
		nil,
		1
	},
	[7753009] = {
		7753009,
		0,
		Lang.get(35262),
		7753,
		9,
		300,
		{
			RTResTalkAction[63]
		}
	},
	[7753010] = {
		7753010,
		0,
		Lang.get(35263),
		7753,
		10,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[64]
		},
		nil,
		nil,
		3
	},
	[7753011] = {
		7753011,
		0,
		Lang.get(37059),
		7753,
		11,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753012] = {
		7753012,
		0,
		Lang.get(35265),
		7753,
		12,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753013] = {
		7753013,
		0,
		Lang.get(35266),
		7753,
		13,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753014] = {
		7753014,
		0,
		Lang.get(37060),
		7753,
		14,
		107,
		{
			RTResTalkAction[28],
			RTResTalkAction[53]
		}
	},
	[7753015] = {
		7753015,
		0,
		Lang.get(35268),
		7753,
		15,
		216,
		{
			RTResTalkAction[34],
			RTResTalkAction[23]
		}
	},
	[7753016] = {
		7753016,
		0,
		Lang.get(35269),
		7753,
		16,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753017] = {
		7753017,
		0,
		Lang.get(35270),
		7753,
		17,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753018] = {
		7753018,
		3,
		Lang.get(35271),
		7753,
		18,
		605,
		{
			RTResTalkAction[53]
		},
		[21] = 1
	},
	[7753019] = {
		7753019,
		0,
		Lang.get(35272),
		7753,
		19,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753020] = {
		7753020,
		0,
		Lang.get(35273),
		7753,
		20,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753021] = {
		7753021,
		0,
		Lang.get(80825),
		7753,
		21,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753022] = {
		7753022,
		0,
		"……！",
		7753,
		22,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753023] = {
		7753023,
		0,
		Lang.get(34583),
		7753,
		23,
		216,
		{
			RTResTalkAction[34]
		}
	},
	[7753024] = {
		7753024,
		0,
		Lang.get(37061),
		7753,
		24,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753025] = {
		7753025,
		0,
		Lang.get(35275),
		7753,
		25,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753026] = {
		7753026,
		0,
		Lang.get(35276),
		7753,
		26,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753027] = {
		7753027,
		0,
		Lang.get(37062),
		7753,
		27,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753028] = {
		7753028,
		0,
		Lang.get(37063),
		7753,
		28,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753029] = {
		7753029,
		0,
		Lang.get(35279),
		7753,
		29,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[7753030] = {
		7753030,
		0,
		"！！！",
		7753,
		30,
		216,
		{
			RTResTalkAction[53]
		},
		1,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		nil,
		7755
	},
	[7753031] = {
		7753031,
		0,
		Lang.get(37683),
		7753,
		31,
		300
	},
	[7753032] = {
		7753032,
		0,
		Lang.get(35281),
		7753,
		32,
		300
	},
	[7753033] = {
		7753033,
		0,
		Lang.get(35282),
		7753,
		33,
		216,
		nil,
		1,
		0
	},
	[7753034] = {
		7753034,
		0,
		Lang.get(35283),
		7753,
		34,
		300
	},
	[7753035] = {
		7753035,
		0,
		Lang.get(37684),
		7753,
		35,
		216,
		nil,
		1,
		1
	},
	[7753036] = {
		7753036,
		0,
		Lang.get(35285),
		7753,
		36,
		300
	},
	[7753037] = {
		7753037,
		0,
		Lang.get(35286),
		7753,
		37,
		217,
		nil,
		1,
		0
	},
	[7753038] = {
		7753038,
		0,
		Lang.get(35287),
		7753,
		38,
		217,
		nil,
		1,
		0
	},
	[7753039] = {
		7753039,
		0,
		Lang.get(35288),
		7753,
		39,
		300
	},
	[7753040] = {
		7753040,
		0,
		Lang.get(35289),
		7753,
		40,
		300
	},
	[7753041] = {
		7753041,
		0,
		Lang.get(37685),
		7753,
		41,
		300
	},
	[7753042] = {
		7753042,
		0,
		Lang.get(35291),
		7753,
		42,
		216,
		nil,
		1,
		3
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
