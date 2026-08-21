-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Claire\\ResTalk.lua

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
	[2] = 298
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 298
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 299
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 413
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 413
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 1010
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 298,
	[3] = {
		1
	}
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 299
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 298
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 1010
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 298
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 299,
	[3] = {
		3
	}
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 299
}
RTResTalkAction[14] = {
	1,
	147,
	nil,
	nil,
	1
}
RTResTalkAction[15] = {
	1,
	147,
	nil,
	nil,
	2
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1010
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 147
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 147
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1010,
	[3] = {
		1003
	}
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1003
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 1003
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1010,
	[3] = {
		1002
	}
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1010,
	[3] = {
		3
	}
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1003,
	[3] = {
		1002
	}
}
RTResTalkAction[25] = {
	1,
	1010,
	nil,
	nil,
	2
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 297,
	[3] = {
		1002
	}
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 297
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 297
}
RTResTalkAction[29] = {
	1,
	1010,
	nil,
	nil,
	1
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[32] = {
	[1] = 1,
	[2] = 297,
	[3] = {
		1
	}
}
RTResTalkAction[33] = {
	1,
	1009,
	nil,
	nil,
	2
}
RTResTalkAction[34] = {
	1,
	1010,
	{
		1004
	},
	nil,
	2
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 1009
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		3
	}
}
RTResTalkAction[37] = {
	1,
	1010,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1002
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 1017
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 1002
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1017
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		1002
	}
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 1009
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 297,
	[3] = {
		3
	}
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 297
}
RTResTalkAction[46] = {
	[1] = 3,
	[2] = 1017
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 1010,
	[3] = {
		2
	}
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 273
}
RTResTalkAction[49] = {
	[1] = 0,
	[2] = 273
}
RTResTalkAction[50] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[51] = {
	1,
	133,
	nil,
	nil,
	1
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[53] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[55] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[57] = {
	[1] = 1,
	[2] = 1015
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 1015
}
RTResTalkAction[59] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[60] = {
	1,
	141,
	{
		1006
	},
	nil,
	2
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[64] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	1,
	1009,
	nil,
	nil,
	1
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		2
	}
}
RTResTalkAction[67] = {
	1,
	107,
	{
		1002
	},
	nil,
	8
}
RTResTalkAction[68] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		1
	}
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 1011
}
RTResTalkAction[71] = {
	[1] = 0,
	[2] = 1011
}
RTResTalkAction[72] = {
	[1] = 1,
	[2] = 1012
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 1012
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 1014,
	[3] = {
		1005
	}
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 1013
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 1013
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 1014
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 298,
	[3] = {
		1006
	}
}
RTResTalkAction[79] = {
	[1] = 0,
	[2] = 1014
}
RTResTalkAction[80] = {
	[1] = 1,
	[2] = 58,
	[3] = {
		1007
	}
}
RTResTalkAction[81] = {
	[1] = 1,
	[2] = 58,
	[3] = {
		1008
	}
}
RTResTalkAction[82] = {
	[1] = 0,
	[2] = 58
}
RTResTalkAction[83] = {
	[1] = 1,
	[2] = 1004
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 1005
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 1004
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 1012,
	[3] = {
		1002
	}
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 58
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1016
}
RTResTalkAction[89] = {
	[1] = 1,
	[2] = 239
}
RTResTalkAction[90] = {
	[1] = 0,
	[2] = 239
}
RTResTalkAction[91] = {
	[1] = 1,
	[2] = 239,
	[3] = {
		1006
	}
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 1019
}
RTResTalkAction[93] = {
	[1] = 0,
	[2] = 1019
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[95] = {
	1,
	1009,
	{
		1003
	},
	nil,
	1
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 1003,
	[3] = {
		1
	}
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 1009,
	[3] = {
		1003
	}
}

local Data = {
	[31000001] = {
		31000001,
		0,
		Lang.get(73880),
		31000,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		181,
		31000,
		nil,
		1,
		nil,
		1,
		nil,
		31000
	},
	[31000002] = {
		31000002,
		7,
		"88",
		31000,
		2,
		1010
	},
	[31000003] = {
		31000003,
		0,
		Lang.get(73881),
		31000,
		3,
		1010,
		nil,
		1
	},
	[31000004] = {
		31000004,
		0,
		Lang.get(73882),
		31000,
		4,
		298,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31000005] = {
		31000005,
		0,
		Lang.get(73883),
		31000,
		5,
		1007,
		{
			RTResTalkAction[2]
		},
		1
	},
	[31000006] = {
		31000006,
		0,
		Lang.get(73884),
		31000,
		6,
		299,
		{
			RTResTalkAction[3]
		}
	},
	[31001001] = {
		31001001,
		0,
		Lang.get(73885),
		31001,
		1,
		1010,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		31001,
		[19] = 31001,
		[21] = 413
	},
	[31001002] = {
		31001002,
		0,
		Lang.get(67976),
		31001,
		2,
		298,
		{
			RTResTalkAction[5]
		}
	},
	[31001003] = {
		31001003,
		0,
		Lang.get(73886),
		31001,
		3,
		1007,
		{
			RTResTalkAction[4]
		},
		1,
		[21] = 413
	},
	[31001004] = {
		31001004,
		0,
		Lang.get(73887),
		31001,
		4,
		298,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[31001005] = {
		31001005,
		0,
		Lang.get(73888),
		31001,
		5,
		1010,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[31001006] = {
		31001006,
		0,
		Lang.get(73889),
		31001,
		6,
		299,
		{
			RTResTalkAction[8],
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[31001007] = {
		31001007,
		0,
		Lang.get(73890),
		31001,
		7,
		298,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[31001008] = {
		31001008,
		0,
		Lang.get(73891),
		31001,
		8,
		1007,
		{
			RTResTalkAction[2],
			RTResTalkAction[13]
		},
		1
	},
	[31002001] = {
		31002001,
		0,
		Lang.get(73892),
		31002,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31002,
		[19] = 31002
	},
	[31002002] = {
		31002002,
		5,
		Lang.get(73893),
		31002,
		2,
		1010,
		nil,
		1
	},
	[31002003] = {
		31002003,
		0,
		Lang.get(73894),
		31002,
		3,
		1010,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3,
		[21] = 413
	},
	[31002004] = {
		31002004,
		0,
		Lang.get(73895),
		31002,
		4,
		147,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[31002005] = {
		31002005,
		0,
		Lang.get(73896),
		31002,
		5,
		147,
		{
			RTResTalkAction[15]
		}
	},
	[31002006] = {
		31002006,
		0,
		Lang.get(73897),
		31002,
		6,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[31002007] = {
		31002007,
		0,
		Lang.get(73898),
		31002,
		7,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31002008] = {
		31002008,
		0,
		Lang.get(73899),
		31002,
		8,
		1010,
		{
			RTResTalkAction[19],
			RTResTalkAction[17]
		}
	},
	[31002009] = {
		31002009,
		0,
		Lang.get(73900),
		31002,
		9,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[31003001] = {
		31003001,
		0,
		Lang.get(73901),
		31003,
		1,
		147,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31003,
		nil,
		nil,
		nil,
		nil,
		nil,
		31003
	},
	[31003002] = {
		31003002,
		0,
		Lang.get(73902),
		31003,
		2,
		1010,
		nil,
		1
	},
	[31003003] = {
		31003003,
		0,
		Lang.get(73903),
		31003,
		3,
		147,
		nil,
		1
	},
	[31003004] = {
		31003004,
		0,
		Lang.get(75492),
		31003,
		4,
		1010,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31003005] = {
		31003005,
		0,
		"ZZZZZZZZZZ……",
		31003,
		5,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[31003006] = {
		31003006,
		0,
		Lang.get(73905),
		31003,
		6,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[21]
		}
	},
	[31003007] = {
		31003007,
		0,
		Lang.get(73906),
		31003,
		7,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[31003008] = {
		31003008,
		0,
		Lang.get(73907),
		31003,
		8,
		1010,
		{
			RTResTalkAction[19],
			RTResTalkAction[21]
		}
	},
	[31003009] = {
		31003009,
		0,
		Lang.get(73908),
		31003,
		9,
		1010,
		{
			RTResTalkAction[22]
		}
	},
	[31004001] = {
		31004001,
		0,
		Lang.get(73909),
		31004,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31004,
		nil,
		nil,
		nil,
		nil,
		nil,
		31004
	},
	[31004002] = {
		31004002,
		0,
		Lang.get(73910),
		31004,
		2,
		1003,
		nil,
		1
	},
	[31004003] = {
		31004003,
		0,
		Lang.get(73911),
		31004,
		3,
		1010,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[31004004] = {
		31004004,
		0,
		Lang.get(73912),
		31004,
		4,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[31004005] = {
		31004005,
		0,
		Lang.get(73913),
		31004,
		5,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[31004006] = {
		31004006,
		0,
		Lang.get(75493),
		31004,
		6,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[17]
		}
	},
	[31004007] = {
		31004007,
		0,
		Lang.get(73915),
		31004,
		7,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[21]
		}
	},
	[31004008] = {
		31004008,
		0,
		Lang.get(75494),
		31004,
		8,
		1003,
		{
			RTResTalkAction[24],
			RTResTalkAction[10]
		}
	},
	[31004009] = {
		31004009,
		0,
		Lang.get(73917),
		31004,
		9,
		1010,
		{
			RTResTalkAction[25],
			RTResTalkAction[21]
		}
	},
	[31004010] = {
		31004010,
		0,
		Lang.get(73918),
		31004,
		10,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[31004011] = {
		31004011,
		0,
		Lang.get(73919),
		31004,
		11,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[31004012] = {
		31004012,
		0,
		Lang.get(73920),
		31004,
		12,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[17]
		}
	},
	[31004013] = {
		31004013,
		0,
		Lang.get(73921),
		31004,
		13,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[21]
		}
	},
	[31005001] = {
		31005001,
		0,
		Lang.get(73922),
		31005,
		1,
		297,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31005,
		[19] = 31005
	},
	[31005002] = {
		31005002,
		0,
		Lang.get(73923),
		31005,
		2,
		1010,
		nil,
		1
	},
	[31005003] = {
		31005003,
		0,
		Lang.get(73924),
		31005,
		3,
		297,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[31005004] = {
		31005004,
		0,
		Lang.get(73925),
		31005,
		4,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[27]
		}
	},
	[31005005] = {
		31005005,
		0,
		Lang.get(73926),
		31005,
		5,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[31005006] = {
		31005006,
		0,
		Lang.get(73927),
		31005,
		6,
		297,
		{
			RTResTalkAction[28]
		}
	},
	[31005007] = {
		31005007,
		0,
		Lang.get(73928),
		31005,
		7,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[27]
		}
	},
	[31005008] = {
		31005008,
		0,
		Lang.get(75495),
		31005,
		8,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31005009] = {
		31005009,
		0,
		Lang.get(75496),
		31005,
		9,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31005010] = {
		31005010,
		0,
		Lang.get(73931),
		31005,
		10,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31005011] = {
		31005011,
		0,
		Lang.get(73932),
		31005,
		11,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[31005012] = {
		31005012,
		0,
		Lang.get(73933),
		31005,
		12,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[27]
		}
	},
	[31005013] = {
		31005013,
		0,
		Lang.get(73934),
		31005,
		13,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[31005014] = {
		31005014,
		0,
		Lang.get(73935),
		31005,
		14,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[27]
		}
	},
	[31005015] = {
		31005015,
		0,
		Lang.get(75497),
		31005,
		15,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[31005016] = {
		31005016,
		0,
		Lang.get(73937),
		31005,
		16,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[27]
		}
	},
	[31005017] = {
		31005017,
		0,
		Lang.get(73938),
		31005,
		17,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[31005018] = {
		31005018,
		0,
		Lang.get(73939),
		31005,
		18,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[27]
		}
	},
	[31005019] = {
		31005019,
		0,
		Lang.get(73940),
		31005,
		19,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[31005020] = {
		31005020,
		0,
		Lang.get(73941),
		31005,
		20,
		1010,
		{
			RTResTalkAction[29],
			RTResTalkAction[27]
		},
		nil,
		nil,
		nil,
		nil,
		59
	},
	[31005021] = {
		31005021,
		0,
		Lang.get(73942),
		31005,
		21,
		147,
		{
			RTResTalkAction[14],
			RTResTalkAction[10]
		}
	},
	[31005022] = {
		31005022,
		0,
		Lang.get(75498),
		31005,
		22,
		1010,
		{
			RTResTalkAction[29],
			RTResTalkAction[17]
		}
	},
	[31005023] = {
		31005023,
		0,
		Lang.get(73944),
		31005,
		23,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31005024] = {
		31005024,
		0,
		Lang.get(73945),
		31005,
		24,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[17]
		}
	},
	[31006001] = {
		31006001,
		0,
		Lang.get(73946),
		31006,
		1,
		299,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		31006,
		nil,
		nil,
		nil,
		nil,
		nil,
		31006
	},
	[31006002] = {
		31006002,
		0,
		Lang.get(73947),
		31006,
		2,
		148,
		nil,
		1
	},
	[31006003] = {
		31006003,
		0,
		Lang.get(73948),
		31006,
		3,
		1010,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[31006004] = {
		31006004,
		0,
		Lang.get(73949),
		31006,
		4,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[31006005] = {
		31006005,
		0,
		Lang.get(73950),
		31006,
		5,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[13]
		}
	},
	[31006006] = {
		31006006,
		0,
		Lang.get(73951),
		31006,
		6,
		1010,
		{
			RTResTalkAction[22],
			RTResTalkAction[31]
		}
	},
	[31006007] = {
		31006007,
		0,
		Lang.get(75499),
		31006,
		7,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[31006008] = {
		31006008,
		0,
		Lang.get(73953),
		31006,
		8,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[31]
		}
	},
	[31006009] = {
		31006009,
		0,
		Lang.get(73954),
		31006,
		9,
		1003,
		{
			RTResTalkAction[20]
		}
	},
	[31006010] = {
		31006010,
		0,
		Lang.get(73955),
		31006,
		10,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[21]
		}
	},
	[31006011] = {
		31006011,
		0,
		Lang.get(73956),
		31006,
		11,
		148,
		{
			RTResTalkAction[30]
		}
	},
	[31006012] = {
		31006012,
		0,
		Lang.get(73957),
		31006,
		12,
		148,
		{
			RTResTalkAction[30]
		}
	},
	[31006013] = {
		31006013,
		0,
		Lang.get(73958),
		31006,
		13,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[31]
		}
	},
	[31006014] = {
		31006014,
		0,
		Lang.get(75500),
		31006,
		14,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[31007001] = {
		31007001,
		0,
		Lang.get(73960),
		31007,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		48,
		31007,
		nil,
		nil,
		nil,
		nil,
		nil,
		31007
	},
	[31007002] = {
		31007002,
		0,
		Lang.get(73961),
		31007,
		2,
		297,
		nil,
		1
	},
	[31007003] = {
		31007003,
		0,
		Lang.get(73962),
		31007,
		3,
		147,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[31007004] = {
		31007004,
		0,
		Lang.get(73963),
		31007,
		4,
		297,
		{
			RTResTalkAction[32],
			RTResTalkAction[17]
		}
	},
	[31007005] = {
		31007005,
		0,
		Lang.get(73964),
		31007,
		5,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[27]
		}
	},
	[31007006] = {
		31007006,
		0,
		Lang.get(73965),
		31007,
		6,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[31007007] = {
		31007007,
		0,
		Lang.get(73966),
		31007,
		7,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[27]
		}
	},
	[31007008] = {
		31007008,
		0,
		Lang.get(73967),
		31007,
		8,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[31]
		}
	},
	[31008001] = {
		31008001,
		0,
		Lang.get(75501),
		31008,
		1,
		297,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		31008,
		nil,
		nil,
		nil,
		nil,
		nil,
		31008
	},
	[31008002] = {
		31008002,
		0,
		Lang.get(73969),
		31008,
		2,
		1010,
		nil,
		1
	},
	[31008003] = {
		31008003,
		0,
		Lang.get(73970),
		31008,
		3,
		299,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[31008004] = {
		31008004,
		0,
		Lang.get(73971),
		31008,
		4,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[13]
		}
	},
	[31008005] = {
		31008005,
		0,
		Lang.get(73972),
		31008,
		5,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[27]
		}
	},
	[31008006] = {
		31008006,
		0,
		Lang.get(73973),
		31008,
		6,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[31]
		}
	},
	[31008007] = {
		31008007,
		0,
		Lang.get(73974),
		31008,
		7,
		1015,
		{
			RTResTalkAction[17]
		}
	},
	[31008008] = {
		31008008,
		7,
		"89",
		31008,
		8,
		1015
	},
	[31009001] = {
		31009001,
		0,
		Lang.get(73975),
		31009,
		1,
		1002,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31009,
		[19] = 31009
	},
	[31009002] = {
		31009002,
		0,
		Lang.get(73976),
		31009,
		2,
		1001
	},
	[31009003] = {
		31009003,
		0,
		Lang.get(73977),
		31009,
		3,
		1009,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[31009004] = {
		31009004,
		0,
		Lang.get(73978),
		31009,
		4,
		1010,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[31009005] = {
		31009005,
		0,
		Lang.get(73979),
		31009,
		5,
		1009,
		{
			RTResTalkAction[36],
			RTResTalkAction[10]
		}
	},
	[31009006] = {
		31009006,
		0,
		Lang.get(73980),
		31009,
		6,
		1009,
		{
			RTResTalkAction[33]
		}
	},
	[31009007] = {
		31009007,
		0,
		Lang.get(73981),
		31009,
		7,
		1010,
		{
			RTResTalkAction[37],
			RTResTalkAction[35]
		}
	},
	[31009008] = {
		31009008,
		0,
		Lang.get(73982),
		31009,
		8,
		1002,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		60,
		31010,
		nil,
		nil,
		nil,
		nil,
		nil,
		31010
	},
	[31009009] = {
		31009009,
		0,
		Lang.get(73983),
		31009,
		9,
		1017
	},
	[31009010] = {
		31009010,
		0,
		Lang.get(73984),
		31009,
		10,
		1010,
		nil,
		1
	},
	[31009011] = {
		31009011,
		0,
		Lang.get(73985),
		31009,
		11,
		1002,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[31009012] = {
		31009012,
		0,
		Lang.get(73986),
		31009,
		12,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		},
		[21] = 1017
	},
	[31009013] = {
		31009013,
		0,
		Lang.get(73987),
		31009,
		13,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[41]
		}
	},
	[31009014] = {
		31009014,
		0,
		Lang.get(73988),
		31009,
		14,
		1017,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		},
		[21] = 1017
	},
	[31011001] = {
		31011001,
		0,
		Lang.get(73989),
		31011,
		1,
		1009,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31011,
		[19] = 31011
	},
	[31011002] = {
		31011002,
		0,
		Lang.get(73990),
		31011,
		2,
		299,
		nil,
		1
	},
	[31011003] = {
		31011003,
		0,
		Lang.get(73991),
		31011,
		3,
		1009,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[31011004] = {
		31011004,
		0,
		Lang.get(73992),
		31011,
		4,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[35]
		}
	},
	[31011005] = {
		31011005,
		0,
		Lang.get(73993),
		31011,
		5,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[13]
		}
	},
	[31011006] = {
		31011006,
		0,
		Lang.get(73994),
		31011,
		6,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[35]
		}
	},
	[31011007] = {
		31011007,
		0,
		Lang.get(73995),
		31011,
		7,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[13]
		}
	},
	[31012001] = {
		31012001,
		0,
		Lang.get(73996),
		31012,
		1,
		1001,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		nil,
		nil,
		59,
		31012,
		[19] = 31012,
		[21] = 1017
	},
	[31012002] = {
		31012002,
		0,
		Lang.get(73997),
		31012,
		2,
		297,
		{
			RTResTalkAction[41]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		31013
	},
	[31012003] = {
		31012003,
		0,
		Lang.get(73998),
		31012,
		3,
		1010,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31012004] = {
		31012004,
		0,
		Lang.get(73999),
		31012,
		4,
		147,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[31012005] = {
		31012005,
		0,
		Lang.get(74000),
		31012,
		5,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[31012006] = {
		31012006,
		0,
		Lang.get(74001),
		31012,
		6,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[10]
		},
		[21] = 1017
	},
	[31012007] = {
		31012007,
		0,
		Lang.get(74002),
		31012,
		7,
		297,
		{
			RTResTalkAction[28],
			RTResTalkAction[41]
		}
	},
	[31012008] = {
		31012008,
		0,
		Lang.get(75502),
		31012,
		8,
		297,
		{
			RTResTalkAction[28]
		}
	},
	[31012009] = {
		31012009,
		0,
		Lang.get(74004),
		31012,
		9,
		297,
		{
			RTResTalkAction[44]
		}
	},
	[31013001] = {
		31013001,
		0,
		Lang.get(74005),
		31013,
		1,
		1001,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		31014,
		[19] = 31013
	},
	[31013002] = {
		31013002,
		0,
		Lang.get(74006),
		31013,
		2,
		297,
		nil,
		1
	},
	[31013003] = {
		31013003,
		0,
		Lang.get(75503),
		31013,
		3,
		1001,
		{
			RTResTalkAction[39]
		},
		nil,
		nil,
		3,
		[21] = 1017
	},
	[31013004] = {
		31013004,
		0,
		Lang.get(74008),
		31013,
		4,
		297,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[31013005] = {
		31013005,
		0,
		Lang.get(75504),
		31013,
		5,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[27]
		},
		[21] = 1017
	},
	[31013006] = {
		31013006,
		2,
		Lang.get(74010),
		31013,
		6,
		297,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[31014001] = {
		31014001,
		0,
		Lang.get(74011),
		31014,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		31015,
		nil,
		nil,
		nil,
		nil,
		nil,
		31014
	},
	[31014002] = {
		31014002,
		0,
		Lang.get(74012),
		31014,
		2,
		147,
		nil,
		1
	},
	[31014003] = {
		31014003,
		0,
		Lang.get(75505),
		31014,
		3,
		1010,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31014004] = {
		31014004,
		0,
		Lang.get(74014),
		31014,
		4,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31014005] = {
		31014005,
		0,
		Lang.get(74015),
		31014,
		5,
		1010,
		{
			RTResTalkAction[29],
			RTResTalkAction[17]
		}
	},
	[31014006] = {
		31014006,
		0,
		Lang.get(74016),
		31014,
		6,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31014007] = {
		31014007,
		0,
		Lang.get(74017),
		31014,
		7,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[31014008] = {
		31014008,
		0,
		Lang.get(74018),
		31014,
		8,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31014009] = {
		31014009,
		0,
		Lang.get(74019),
		31014,
		9,
		147,
		{
			RTResTalkAction[18]
		}
	},
	[31015001] = {
		31015001,
		0,
		Lang.get(74020),
		31015,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31016,
		[19] = 31015
	},
	[31015002] = {
		31015002,
		0,
		Lang.get(74021),
		31015,
		2,
		299,
		nil,
		1
	},
	[31015003] = {
		31015003,
		0,
		Lang.get(74022),
		31015,
		3,
		148,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[31015004] = {
		31015004,
		0,
		Lang.get(74023),
		31015,
		4,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[31]
		}
	},
	[31015005] = {
		31015005,
		0,
		Lang.get(74024),
		31015,
		5,
		299,
		{
			RTResTalkAction[3]
		}
	},
	[31015006] = {
		31015006,
		0,
		Lang.get(74025),
		31015,
		6,
		1010,
		{
			RTResTalkAction[47],
			RTResTalkAction[13]
		}
	},
	[31015007] = {
		31015007,
		0,
		Lang.get(74026),
		31015,
		7,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31015008] = {
		31015008,
		0,
		Lang.get(74027),
		31015,
		8,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[31015009] = {
		31015009,
		0,
		Lang.get(74028),
		31015,
		9,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31015010] = {
		31015010,
		0,
		Lang.get(74029),
		31015,
		10,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31015011] = {
		31015011,
		0,
		Lang.get(75506),
		31015,
		11,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[31015012] = {
		31015012,
		0,
		Lang.get(74031),
		31015,
		12,
		148,
		{
			RTResTalkAction[30],
			RTResTalkAction[13]
		}
	},
	[31015013] = {
		31015013,
		0,
		Lang.get(74032),
		31015,
		13,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[31]
		}
	},
	[31016001] = {
		31016001,
		0,
		Lang.get(74033),
		31016,
		1,
		273,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31017,
		nil,
		nil,
		nil,
		nil,
		nil,
		31016
	},
	[31016002] = {
		31016002,
		0,
		Lang.get(74034),
		31016,
		2,
		273,
		nil,
		1
	},
	[31016003] = {
		31016003,
		0,
		Lang.get(74035),
		31016,
		3,
		273,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		3
	},
	[31016004] = {
		31016004,
		0,
		Lang.get(74036),
		31016,
		4,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[49]
		}
	},
	[31016005] = {
		31016005,
		0,
		Lang.get(74037),
		31016,
		5,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31016006] = {
		31016006,
		0,
		Lang.get(74038),
		31016,
		6,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[10]
		}
	},
	[31016007] = {
		31016007,
		0,
		Lang.get(74039),
		31016,
		7,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[49]
		}
	},
	[31016008] = {
		31016008,
		0,
		Lang.get(74040),
		31016,
		8,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[31016009] = {
		31016009,
		0,
		Lang.get(74041),
		31016,
		9,
		273,
		{
			RTResTalkAction[48]
		}
	},
	[31016010] = {
		31016010,
		0,
		Lang.get(74042),
		31016,
		10,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[49]
		}
	},
	[31016011] = {
		31016011,
		0,
		Lang.get(74043),
		31016,
		11,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[31016012] = {
		31016012,
		0,
		Lang.get(74044),
		31016,
		12,
		273,
		{
			RTResTalkAction[48]
		}
	},
	[31016013] = {
		31016013,
		0,
		Lang.get(74045),
		31016,
		13,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[49]
		}
	},
	[31016014] = {
		31016014,
		0,
		Lang.get(74046),
		31016,
		14,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[31016015] = {
		31016015,
		0,
		Lang.get(74047),
		31016,
		15,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[49]
		}
	},
	[31016016] = {
		31016016,
		0,
		Lang.get(74048),
		31016,
		16,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[10]
		}
	},
	[31016017] = {
		31016017,
		0,
		Lang.get(74049),
		31016,
		17,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[49]
		}
	},
	[31016018] = {
		31016018,
		0,
		Lang.get(74050),
		31016,
		18,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[10]
		}
	},
	[31016019] = {
		31016019,
		0,
		Lang.get(75507),
		31016,
		19,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[17]
		}
	},
	[31016020] = {
		31016020,
		0,
		Lang.get(74052),
		31016,
		20,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[49]
		}
	},
	[31016021] = {
		31016021,
		0,
		Lang.get(74053),
		31016,
		21,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[31016022] = {
		31016022,
		0,
		Lang.get(74054),
		31016,
		22,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[31017001] = {
		31017001,
		0,
		Lang.get(74055),
		31017,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		3,
		31018,
		nil,
		nil,
		nil,
		nil,
		nil,
		31017
	},
	[31017002] = {
		31017002,
		0,
		Lang.get(74056),
		31017,
		2,
		273,
		nil,
		1
	},
	[31017003] = {
		31017003,
		0,
		Lang.get(74057),
		31017,
		3,
		107,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[31017004] = {
		31017004,
		0,
		Lang.get(74058),
		31017,
		4,
		133,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[31017005] = {
		31017005,
		0,
		Lang.get(74059),
		31017,
		5,
		107,
		{
			RTResTalkAction[53],
			RTResTalkAction[54]
		}
	},
	[31017006] = {
		31017006,
		0,
		Lang.get(74060),
		31017,
		6,
		141,
		{
			RTResTalkAction[55],
			RTResTalkAction[52]
		}
	},
	[31018001] = {
		31018001,
		0,
		Lang.get(11617),
		31018,
		1,
		273,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		31019,
		nil,
		nil,
		nil,
		nil,
		nil,
		31018
	},
	[31018002] = {
		31018002,
		0,
		Lang.get(74061),
		31018,
		2,
		107,
		nil,
		1
	},
	[31018003] = {
		31018003,
		0,
		Lang.get(74062),
		31018,
		3,
		1010,
		nil,
		1
	},
	[31018004] = {
		31018004,
		0,
		Lang.get(74063),
		31018,
		4,
		133,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[31018005] = {
		31018005,
		0,
		Lang.get(74064),
		31018,
		5,
		1015,
		{
			RTResTalkAction[57],
			RTResTalkAction[54]
		}
	},
	[31018006] = {
		31018006,
		0,
		Lang.get(74065),
		31018,
		6,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[58]
		}
	},
	[31018007] = {
		31018007,
		0,
		Lang.get(74066),
		31018,
		7,
		1015,
		{
			RTResTalkAction[57],
			RTResTalkAction[40]
		}
	},
	[31018008] = {
		31018008,
		0,
		Lang.get(74067),
		31018,
		8,
		107,
		{
			RTResTalkAction[59],
			RTResTalkAction[58]
		}
	},
	[31018009] = {
		31018009,
		0,
		Lang.get(74068),
		31018,
		9,
		147,
		{
			RTResTalkAction[18],
			RTResTalkAction[52]
		}
	},
	[31018010] = {
		31018010,
		0,
		Lang.get(75508),
		31018,
		10,
		133,
		{
			RTResTalkAction[56],
			RTResTalkAction[17]
		}
	},
	[31018011] = {
		31018011,
		0,
		Lang.get(74070),
		31018,
		11,
		141,
		{
			RTResTalkAction[60],
			RTResTalkAction[54]
		}
	},
	[31018012] = {
		31018012,
		0,
		Lang.get(74071),
		31018,
		12,
		1010,
		{
			RTResTalkAction[22],
			RTResTalkAction[61]
		}
	},
	[31018013] = {
		31018013,
		0,
		Lang.get(74072),
		31018,
		13,
		300,
		{
			RTResTalkAction[62],
			RTResTalkAction[10]
		}
	},
	[31018014] = {
		31018014,
		0,
		Lang.get(74073),
		31018,
		14,
		133,
		{
			RTResTalkAction[56],
			RTResTalkAction[63]
		}
	},
	[31018015] = {
		31018015,
		0,
		Lang.get(74074),
		31018,
		15,
		107,
		{
			RTResTalkAction[64],
			RTResTalkAction[54]
		}
	},
	[31018016] = {
		31018016,
		0,
		Lang.get(74075),
		31018,
		16,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[52]
		}
	},
	[31019001] = {
		31019001,
		0,
		Lang.get(74076),
		31019,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31020,
		[19] = 31019
	},
	[31019002] = {
		31019002,
		0,
		Lang.get(74077),
		31019,
		2,
		1002,
		nil,
		1
	},
	[31019003] = {
		31019003,
		0,
		Lang.get(74078),
		31019,
		3,
		147,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[31019004] = {
		31019004,
		0,
		Lang.get(74079),
		31019,
		4,
		1015,
		{
			RTResTalkAction[57],
			RTResTalkAction[17]
		}
	},
	[31019005] = {
		31019005,
		0,
		Lang.get(74080),
		31019,
		5,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[58]
		}
	},
	[31019006] = {
		31019006,
		0,
		Lang.get(74081),
		31019,
		6,
		1015,
		{
			RTResTalkAction[57],
			RTResTalkAction[40]
		}
	},
	[31019007] = {
		31019007,
		0,
		Lang.get(74082),
		31019,
		7,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[58]
		}
	},
	[31019008] = {
		31019008,
		0,
		Lang.get(74083),
		31019,
		8,
		1015,
		{
			RTResTalkAction[57],
			RTResTalkAction[40]
		}
	},
	[31020001] = {
		31020001,
		5,
		Lang.get(73994),
		31020,
		1,
		273,
		{
			RTResTalkAction[48]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		31021,
		[19] = 31020
	},
	[31020002] = {
		31020002,
		0,
		Lang.get(74084),
		31020,
		2,
		1009,
		{
			RTResTalkAction[49]
		},
		1,
		nil,
		nil,
		nil,
		60
	},
	[31020003] = {
		31020003,
		0,
		Lang.get(74085),
		31020,
		3,
		1009,
		nil,
		1
	},
	[31020004] = {
		31020004,
		0,
		Lang.get(74086),
		31020,
		4,
		1009,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[31020005] = {
		31020005,
		0,
		Lang.get(74087),
		31020,
		5,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[35]
		}
	},
	[31020006] = {
		31020006,
		0,
		Lang.get(74088),
		31020,
		6,
		1009,
		{
			RTResTalkAction[65],
			RTResTalkAction[49]
		}
	},
	[31020007] = {
		31020007,
		0,
		"……",
		31020,
		7,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31020008] = {
		31020008,
		0,
		Lang.get(20681),
		31020,
		8,
		147,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[31020009] = {
		31020009,
		0,
		Lang.get(74089),
		31020,
		9,
		300,
		{
			RTResTalkAction[62],
			RTResTalkAction[17]
		}
	},
	[31020010] = {
		31020010,
		0,
		Lang.get(74090),
		31020,
		10,
		1009,
		{
			RTResTalkAction[66],
			RTResTalkAction[63]
		}
	},
	[31020011] = {
		31020011,
		0,
		Lang.get(74091),
		31020,
		11,
		107,
		{
			RTResTalkAction[67],
			RTResTalkAction[35]
		}
	},
	[31020012] = {
		31020012,
		0,
		Lang.get(74092),
		31020,
		12,
		300,
		{
			RTResTalkAction[62],
			RTResTalkAction[52]
		}
	},
	[31020013] = {
		31020013,
		0,
		Lang.get(74093),
		31020,
		13,
		107,
		{
			RTResTalkAction[68],
			RTResTalkAction[63]
		}
	},
	[31020014] = {
		31020014,
		0,
		Lang.get(74094),
		31020,
		14,
		300,
		{
			RTResTalkAction[62],
			RTResTalkAction[52]
		}
	},
	[31021001] = {
		31021001,
		0,
		Lang.get(74095),
		31021,
		1,
		273,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31022,
		[19] = 31021
	},
	[31021002] = {
		31021002,
		0,
		Lang.get(74096),
		31021,
		2,
		1009,
		nil,
		1
	},
	[31021003] = {
		31021003,
		0,
		Lang.get(74097),
		31021,
		3,
		299,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[31021004] = {
		31021004,
		0,
		Lang.get(74098),
		31021,
		4,
		1009,
		{
			RTResTalkAction[65],
			RTResTalkAction[13]
		}
	},
	[31021005] = {
		31021005,
		0,
		Lang.get(74099),
		31021,
		5,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[35]
		}
	},
	[31021006] = {
		31021006,
		0,
		Lang.get(74100),
		31021,
		6,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[13]
		}
	},
	[31021007] = {
		31021007,
		0,
		Lang.get(74101),
		31021,
		7,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[49]
		}
	},
	[31021008] = {
		31021008,
		0,
		Lang.get(74102),
		31021,
		8,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31021009] = {
		31021009,
		0,
		Lang.get(74103),
		31021,
		9,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[10]
		}
	},
	[31021010] = {
		31021010,
		0,
		Lang.get(74104),
		31021,
		10,
		1009,
		{
			RTResTalkAction[65]
		}
	},
	[31021011] = {
		31021011,
		0,
		Lang.get(74105),
		31021,
		11,
		1009,
		{
			RTResTalkAction[65]
		}
	},
	[31021012] = {
		31021012,
		0,
		Lang.get(74106),
		31021,
		12,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[35]
		}
	},
	[31021013] = {
		31021013,
		0,
		Lang.get(74107),
		31021,
		13,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[13]
		}
	},
	[31021014] = {
		31021014,
		0,
		Lang.get(74108),
		31021,
		14,
		1009,
		{
			RTResTalkAction[33]
		}
	},
	[31021015] = {
		31021015,
		0,
		Lang.get(74109),
		31021,
		15,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[35]
		}
	},
	[31021016] = {
		31021016,
		0,
		Lang.get(74110),
		31021,
		16,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[13]
		}
	},
	[31021017] = {
		31021017,
		0,
		Lang.get(75509),
		31021,
		17,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31021018] = {
		31021018,
		0,
		Lang.get(74112),
		31021,
		18,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[35]
		}
	},
	[31021019] = {
		31021019,
		0,
		Lang.get(74113),
		31021,
		19,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[49]
		}
	},
	[31021020] = {
		31021020,
		0,
		Lang.get(74114),
		31021,
		20,
		1009,
		{
			RTResTalkAction[65]
		}
	},
	[31021021] = {
		31021021,
		0,
		Lang.get(74115),
		31021,
		21,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31021022] = {
		31021022,
		0,
		Lang.get(74116),
		31021,
		22,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[10]
		}
	},
	[31022001] = {
		31022001,
		0,
		Lang.get(74117),
		31022,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		31023,
		nil,
		nil,
		nil,
		nil,
		nil,
		31022
	},
	[31022002] = {
		31022002,
		0,
		Lang.get(74118),
		31022,
		2,
		1009,
		nil,
		1
	},
	[31022003] = {
		31022003,
		0,
		Lang.get(74119),
		31022,
		3,
		1010,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31022004] = {
		31022004,
		0,
		Lang.get(74120),
		31022,
		4,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[10]
		}
	},
	[31022005] = {
		31022005,
		0,
		Lang.get(74121),
		31022,
		5,
		1009,
		{
			RTResTalkAction[69]
		}
	},
	[31022006] = {
		31022006,
		4,
		nil,
		31022,
		6,
		1009,
		{
			RTResTalkAction[43]
		},
		[29] = {
			{
				id = 31022007,
				branch_content = Lang.get(75510)
			}
		}
	},
	[31022007] = {
		31022007,
		0,
		Lang.get(74123),
		31022,
		7,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31022008] = {
		31022008,
		4,
		nil,
		31022,
		8,
		1009,
		{
			RTResTalkAction[43]
		},
		[29] = {
			{
				id = 31022009,
				branch_content = Lang.get(74124)
			},
			{
				id = 31022009,
				branch_content = Lang.get(74125)
			}
		}
	},
	[31022009] = {
		31022009,
		0,
		Lang.get(74126),
		31022,
		9,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31022010] = {
		31022010,
		0,
		Lang.get(74127),
		31022,
		10,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31022011] = {
		31022011,
		0,
		Lang.get(74128),
		31022,
		11,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[35]
		}
	},
	[31022012] = {
		31022012,
		0,
		Lang.get(74129),
		31022,
		12,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[31022013] = {
		31022013,
		0,
		Lang.get(74130),
		31022,
		13,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[10]
		}
	},
	[31022014] = {
		31022014,
		0,
		Lang.get(74131),
		31022,
		14,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[40]
		}
	},
	[31022015] = {
		31022015,
		0,
		Lang.get(74132),
		31022,
		15,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[35]
		}
	},
	[31023001] = {
		31023001,
		0,
		Lang.get(74133),
		31023,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31024,
		[19] = 31023
	},
	[31023002] = {
		31023002,
		0,
		Lang.get(74134),
		31023,
		2,
		1002,
		nil,
		1
	},
	[31023003] = {
		31023003,
		0,
		Lang.get(75511),
		31023,
		3,
		1002,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[31023004] = {
		31023004,
		0,
		Lang.get(75512),
		31023,
		4,
		1002,
		{
			RTResTalkAction[38]
		}
	},
	[31023005] = {
		31023005,
		0,
		Lang.get(74137),
		31023,
		5,
		1002,
		{
			RTResTalkAction[38]
		}
	},
	[31023006] = {
		31023006,
		0,
		Lang.get(75513),
		31023,
		6,
		1002,
		{
			RTResTalkAction[38]
		}
	},
	[31024001] = {
		31024001,
		0,
		Lang.get(74139),
		31024,
		1,
		147,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31025,
		[19] = 31024
	},
	[31024002] = {
		31024002,
		0,
		Lang.get(74140),
		31024,
		2,
		1010,
		nil,
		1
	},
	[31024003] = {
		31024003,
		0,
		Lang.get(74141),
		31024,
		3,
		147,
		nil,
		1
	},
	[31024004] = {
		31024004,
		4,
		nil,
		31024,
		4,
		147,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 31024005,
				branch_content = Lang.get(74142)
			}
		}
	},
	[31024005] = {
		31024005,
		0,
		Lang.get(74143),
		31024,
		5,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[17]
		}
	},
	[31024006] = {
		31024006,
		0,
		Lang.get(74144),
		31024,
		6,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[40]
		}
	},
	[31024007] = {
		31024007,
		0,
		Lang.get(74145),
		31024,
		7,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31024008] = {
		31024008,
		0,
		Lang.get(74146),
		31024,
		8,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31024009] = {
		31024009,
		0,
		Lang.get(75514),
		31024,
		9,
		1009,
		{
			RTResTalkAction[65],
			RTResTalkAction[10]
		}
	},
	[31024010] = {
		31024010,
		0,
		Lang.get(74148),
		31024,
		10,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31024011] = {
		31024011,
		0,
		Lang.get(74149),
		31024,
		11,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[35]
		}
	},
	[31024012] = {
		31024012,
		0,
		Lang.get(74150),
		31024,
		12,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[49]
		}
	},
	[31024013] = {
		31024013,
		0,
		Lang.get(74151),
		31024,
		13,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[13]
		}
	},
	[31024014] = {
		31024014,
		0,
		Lang.get(74152),
		31024,
		14,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[40]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[31024015] = {
		31024015,
		0,
		Lang.get(74153),
		31024,
		15,
		1010,
		{
			RTResTalkAction[19],
			RTResTalkAction[35]
		}
	},
	[31024016] = {
		31024016,
		0,
		Lang.get(74154),
		31024,
		16,
		1009,
		{
			RTResTalkAction[33],
			RTResTalkAction[10]
		}
	},
	[31024017] = {
		31024017,
		0,
		Lang.get(75515),
		31024,
		17,
		1009,
		{
			RTResTalkAction[33]
		}
	},
	[31024018] = {
		31024018,
		0,
		Lang.get(74156),
		31024,
		18,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[35]
		}
	},
	[31024019] = {
		31024019,
		0,
		Lang.get(74157),
		31024,
		19,
		147,
		{
			RTResTalkAction[15],
			RTResTalkAction[49]
		}
	},
	[31024020] = {
		31024020,
		0,
		Lang.get(74158),
		31024,
		20,
		1009,
		{
			RTResTalkAction[33],
			RTResTalkAction[17]
		}
	},
	[31024021] = {
		31024021,
		0,
		Lang.get(74159),
		31024,
		21,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[35]
		}
	},
	[31024022] = {
		31024022,
		0,
		Lang.get(74160),
		31024,
		22,
		1009,
		{
			RTResTalkAction[33],
			RTResTalkAction[49]
		}
	},
	[31025001] = {
		31025001,
		0,
		Lang.get(74161),
		31025,
		1,
		1011,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31026,
		[19] = 31025
	},
	[31025002] = {
		31025002,
		0,
		Lang.get(74162),
		31025,
		2,
		1011,
		nil,
		1
	},
	[31025003] = {
		31025003,
		4,
		nil,
		31025,
		3,
		1011,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3,
		[29] = {
			{
				id = 31025004,
				branch_content = Lang.get(74163)
			}
		}
	},
	[31025004] = {
		31025004,
		0,
		Lang.get(74164),
		31025,
		4,
		1011,
		{
			RTResTalkAction[70]
		}
	},
	[31025005] = {
		31025005,
		0,
		Lang.get(74165),
		31025,
		5,
		1011,
		{
			RTResTalkAction[70]
		}
	},
	[31025006] = {
		31025006,
		0,
		Lang.get(74166),
		31025,
		6,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[71]
		}
	},
	[31025007] = {
		31025007,
		0,
		Lang.get(74167),
		31025,
		7,
		147,
		{
			RTResTalkAction[14],
			RTResTalkAction[10]
		}
	},
	[31025008] = {
		31025008,
		0,
		Lang.get(74168),
		31025,
		8,
		273,
		{
			RTResTalkAction[48],
			RTResTalkAction[17]
		}
	},
	[31026001] = {
		31026001,
		0,
		Lang.get(74169),
		31026,
		1,
		1011,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31027,
		[19] = 31026
	},
	[31026002] = {
		31026002,
		0,
		Lang.get(74170),
		31026,
		2,
		1013,
		nil,
		1
	},
	[31026003] = {
		31026003,
		0,
		Lang.get(74171),
		31026,
		3,
		1012,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[31026004] = {
		31026004,
		0,
		Lang.get(74172),
		31026,
		4,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[73]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[31026005] = {
		31026005,
		0,
		Lang.get(74173),
		31026,
		5,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[31026006] = {
		31026006,
		0,
		Lang.get(74174),
		31026,
		6,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[71]
		}
	},
	[31026007] = {
		31026007,
		0,
		Lang.get(74175),
		31026,
		7,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[31026008] = {
		31026008,
		0,
		Lang.get(74176),
		31026,
		8,
		299,
		{
			RTResTalkAction[3],
			RTResTalkAction[71]
		}
	},
	[31026009] = {
		31026009,
		0,
		Lang.get(74177),
		31026,
		9,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[13]
		}
	},
	[31026010] = {
		31026010,
		0,
		Lang.get(74178),
		31026,
		10,
		1014,
		{
			RTResTalkAction[74],
			RTResTalkAction[71]
		}
	},
	[31027001] = {
		31027001,
		0,
		Lang.get(74179),
		31027,
		1,
		1011,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		31028,
		nil,
		nil,
		nil,
		nil,
		nil,
		31027
	},
	[31027002] = {
		31027002,
		0,
		Lang.get(74180),
		31027,
		2,
		1006
	},
	[31027003] = {
		31027003,
		0,
		Lang.get(74181),
		31027,
		3,
		1013,
		nil,
		1
	},
	[31027004] = {
		31027004,
		0,
		Lang.get(74182),
		31027,
		4,
		1012,
		nil,
		1
	},
	[31028001] = {
		31028001,
		0,
		Lang.get(74183),
		31028,
		1,
		1012,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31029,
		[19] = 31028
	},
	[31028002] = {
		31028002,
		0,
		Lang.get(74184),
		31028,
		2,
		1007,
		nil,
		1
	},
	[31028003] = {
		31028003,
		0,
		Lang.get(74185),
		31028,
		3,
		298,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31028004] = {
		31028004,
		0,
		Lang.get(74186),
		31028,
		4,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[2]
		}
	},
	[31028005] = {
		31028005,
		0,
		Lang.get(75516),
		31028,
		5,
		298,
		{
			RTResTalkAction[1],
			RTResTalkAction[73]
		}
	},
	[31028006] = {
		31028006,
		0,
		Lang.get(74187),
		31028,
		6,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[2]
		}
	},
	[31028007] = {
		31028007,
		0,
		Lang.get(74188),
		31028,
		7,
		298,
		{
			RTResTalkAction[1],
			RTResTalkAction[73]
		}
	},
	[31028008] = {
		31028008,
		0,
		Lang.get(74189),
		31028,
		8,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[2]
		}
	},
	[31029001] = {
		31029001,
		0,
		Lang.get(74190),
		31029,
		1,
		298,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		31030,
		[19] = 31029
	},
	[31029002] = {
		31029002,
		0,
		Lang.get(74191),
		31029,
		2,
		1011,
		nil,
		1
	},
	[31029003] = {
		31029003,
		0,
		Lang.get(74192),
		31029,
		3,
		298,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31029004] = {
		31029004,
		0,
		Lang.get(74193),
		31029,
		4,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[2]
		}
	},
	[31029005] = {
		31029005,
		0,
		Lang.get(74194),
		31029,
		5,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[71]
		}
	},
	[31029006] = {
		31029006,
		0,
		Lang.get(74195),
		31029,
		6,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[76]
		}
	},
	[31029007] = {
		31029007,
		0,
		Lang.get(74196),
		31029,
		7,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[73]
		}
	},
	[31029008] = {
		31029008,
		0,
		Lang.get(74197),
		31029,
		8,
		1014,
		{
			RTResTalkAction[77]
		}
	},
	[31029009] = {
		31029009,
		0,
		Lang.get(74198),
		31029,
		9,
		298,
		{
			RTResTalkAction[78],
			RTResTalkAction[79]
		}
	},
	[31029010] = {
		31029010,
		0,
		Lang.get(74199),
		31029,
		10,
		58,
		{
			RTResTalkAction[80],
			RTResTalkAction[2]
		}
	},
	[31029011] = {
		31029011,
		0,
		Lang.get(74200),
		31029,
		11,
		58,
		{
			RTResTalkAction[81]
		}
	},
	[31029012] = {
		31029012,
		0,
		Lang.get(74201),
		31029,
		12,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[82]
		}
	},
	[31029013] = {
		31029013,
		0,
		Lang.get(74202),
		31029,
		13,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[76]
		}
	},
	[31030001] = {
		31030001,
		0,
		Lang.get(74203),
		31030,
		1,
		1018,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31031,
		[19] = 31030
	},
	[31030002] = {
		31030002,
		0,
		Lang.get(74204),
		31030,
		2,
		1011,
		nil,
		1
	},
	[31030003] = {
		31030003,
		0,
		Lang.get(75517),
		31030,
		3,
		1012,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[31031001] = {
		31031001,
		0,
		Lang.get(74206),
		31031,
		1,
		1004,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31032,
		nil,
		nil,
		nil,
		nil,
		nil,
		31031
	},
	[31031002] = {
		31031002,
		0,
		Lang.get(74207),
		31031,
		2,
		147,
		nil,
		1
	},
	[31031003] = {
		31031003,
		0,
		Lang.get(74208),
		31031,
		3,
		1011,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[31031004] = {
		31031004,
		0,
		Lang.get(74209),
		31031,
		4,
		1004,
		{
			RTResTalkAction[83],
			RTResTalkAction[71]
		}
	},
	[31031005] = {
		31031005,
		0,
		Lang.get(74210),
		31031,
		5,
		1005,
		{
			RTResTalkAction[84],
			RTResTalkAction[85]
		}
	},
	[31032001] = {
		31032001,
		0,
		Lang.get(74211),
		31032,
		1,
		1011,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31033,
		[19] = 31032
	},
	[31032002] = {
		31032002,
		0,
		Lang.get(74212),
		31032,
		2,
		1013,
		nil,
		1
	},
	[31032003] = {
		31032003,
		0,
		Lang.get(75518),
		31032,
		3,
		1004,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[31032004] = {
		31032004,
		0,
		Lang.get(74214),
		31032,
		4,
		298,
		{
			RTResTalkAction[1],
			RTResTalkAction[85]
		}
	},
	[31032005] = {
		31032005,
		0,
		"？？？",
		31032,
		5,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[2]
		}
	},
	[31032006] = {
		31032006,
		0,
		Lang.get(74215),
		31032,
		6,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[76]
		}
	},
	[31032007] = {
		31032007,
		0,
		Lang.get(74216),
		31032,
		7,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[71]
		}
	},
	[31032008] = {
		31032008,
		0,
		Lang.get(74217),
		31032,
		8,
		1004,
		{
			RTResTalkAction[83],
			RTResTalkAction[73]
		}
	},
	[31032009] = {
		31032009,
		0,
		Lang.get(74218),
		31032,
		9,
		298,
		{
			RTResTalkAction[1],
			RTResTalkAction[85]
		}
	},
	[31032010] = {
		31032010,
		0,
		Lang.get(74219),
		31032,
		10,
		1004,
		{
			RTResTalkAction[83],
			RTResTalkAction[2]
		}
	},
	[31032011] = {
		31032011,
		0,
		Lang.get(74220),
		31032,
		11,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[85]
		}
	},
	[31032012] = {
		31032012,
		0,
		Lang.get(74221),
		31032,
		12,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[71]
		}
	},
	[31032013] = {
		31032013,
		0,
		Lang.get(74222),
		31032,
		13,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[76]
		}
	},
	[31032014] = {
		31032014,
		0,
		Lang.get(74223),
		31032,
		14,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[71]
		}
	},
	[31032015] = {
		31032015,
		0,
		Lang.get(74224),
		31032,
		15,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[76]
		}
	},
	[31032016] = {
		31032016,
		0,
		Lang.get(74225),
		31032,
		16,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[73]
		}
	},
	[31032017] = {
		31032017,
		0,
		Lang.get(74226),
		31032,
		17,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[79]
		}
	},
	[31032018] = {
		31032018,
		0,
		Lang.get(74227),
		31032,
		18,
		1013,
		{
			RTResTalkAction[75],
			RTResTalkAction[71]
		}
	},
	[31033001] = {
		31033001,
		0,
		Lang.get(74228),
		31033,
		1,
		1002,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31034,
		[19] = 31033
	},
	[31033002] = {
		31033002,
		0,
		Lang.get(74229),
		31033,
		2,
		1001
	},
	[31033003] = {
		31033003,
		0,
		Lang.get(74230),
		31033,
		3,
		1012,
		nil,
		1
	},
	[31033004] = {
		31033004,
		0,
		Lang.get(75519),
		31033,
		4,
		1012,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[31033005] = {
		31033005,
		0,
		Lang.get(74232),
		31033,
		5,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[73]
		},
		[21] = 1017
	},
	[31033006] = {
		31033006,
		0,
		Lang.get(74233),
		31033,
		6,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[41]
		}
	},
	[31033007] = {
		31033007,
		0,
		Lang.get(74234),
		31033,
		7,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		},
		[21] = 1017
	},
	[31033008] = {
		31033008,
		0,
		Lang.get(74235),
		31033,
		8,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[41]
		}
	},
	[31033009] = {
		31033009,
		0,
		Lang.get(74236),
		31033,
		9,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[79]
		},
		[21] = 1017
	},
	[31033010] = {
		31033010,
		0,
		Lang.get(74237),
		31033,
		10,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[41]
		}
	},
	[31033011] = {
		31033011,
		0,
		Lang.get(74238),
		31033,
		11,
		1001,
		{
			RTResTalkAction[39],
			RTResTalkAction[73]
		},
		[21] = 1017
	},
	[31033012] = {
		31033012,
		0,
		Lang.get(74239),
		31033,
		12,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[41]
		}
	},
	[31033013] = {
		31033013,
		0,
		Lang.get(74240),
		31033,
		13,
		1012,
		{
			RTResTalkAction[86],
			RTResTalkAction[79]
		}
	},
	[31033014] = {
		31033014,
		0,
		Lang.get(74241),
		31033,
		14,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[73]
		}
	},
	[31034001] = {
		31034001,
		0,
		Lang.get(74242),
		31034,
		1,
		1012,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		31035,
		nil,
		nil,
		nil,
		nil,
		nil,
		31034
	},
	[31034002] = {
		31034002,
		0,
		Lang.get(74243),
		31034,
		2,
		1002,
		nil,
		1
	},
	[31034003] = {
		31034003,
		0,
		Lang.get(74244),
		31034,
		3,
		1008,
		nil,
		1
	},
	[31034004] = {
		31034004,
		0,
		Lang.get(74245),
		31034,
		4,
		1014,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		3
	},
	[31034005] = {
		31034005,
		0,
		Lang.get(75520),
		31034,
		5,
		1008,
		{
			RTResTalkAction[87],
			RTResTalkAction[79]
		}
	},
	[31034006] = {
		31034006,
		0,
		Lang.get(74247),
		31034,
		6,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[82]
		}
	},
	[31034007] = {
		31034007,
		0,
		Lang.get(74248),
		31034,
		7,
		1012,
		{
			RTResTalkAction[72]
		}
	},
	[31034008] = {
		31034008,
		0,
		Lang.get(74249),
		31034,
		8,
		1012,
		{
			RTResTalkAction[72]
		}
	},
	[31035001] = {
		31035001,
		0,
		Lang.get(74250),
		31035,
		1,
		1011,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		31036,
		nil,
		nil,
		nil,
		nil,
		nil,
		31035
	},
	[31035002] = {
		31035002,
		0,
		Lang.get(74251),
		31035,
		2,
		1014,
		nil,
		1
	},
	[31035003] = {
		31035003,
		0,
		Lang.get(74252),
		31035,
		3,
		1011,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[31035004] = {
		31035004,
		0,
		Lang.get(74253),
		31035,
		4,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[71]
		}
	},
	[31035005] = {
		31035005,
		0,
		Lang.get(74254),
		31035,
		5,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[73]
		}
	},
	[31035006] = {
		31035006,
		0,
		Lang.get(75521),
		31035,
		6,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[71]
		}
	},
	[31035007] = {
		31035007,
		0,
		Lang.get(74256),
		31035,
		7,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[79]
		}
	},
	[31035008] = {
		31035008,
		0,
		Lang.get(74257),
		31035,
		8,
		1008,
		{
			RTResTalkAction[87],
			RTResTalkAction[71]
		}
	},
	[31035009] = {
		31035009,
		0,
		Lang.get(74258),
		31035,
		9,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[82]
		}
	},
	[31036001] = {
		31036001,
		0,
		Lang.get(74259),
		31036,
		1,
		1017,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		31037,
		[19] = 31036
	},
	[31036002] = {
		31036002,
		0,
		Lang.get(74260),
		31036,
		2,
		1010,
		nil,
		1
	},
	[31036003] = {
		31036003,
		0,
		Lang.get(74261),
		31036,
		3,
		297,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[31036004] = {
		31036004,
		0,
		Lang.get(74262),
		31036,
		4,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[27]
		}
	},
	[31036005] = {
		31036005,
		0,
		Lang.get(74263),
		31036,
		5,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[71]
		}
	},
	[31036006] = {
		31036006,
		0,
		Lang.get(74264),
		31036,
		6,
		1012,
		{
			RTResTalkAction[72],
			RTResTalkAction[79]
		}
	},
	[31036007] = {
		31036007,
		0,
		Lang.get(74265),
		31036,
		7,
		1017,
		{
			RTResTalkAction[39],
			RTResTalkAction[73]
		},
		[21] = 1017
	},
	[31036008] = {
		31036008,
		0,
		Lang.get(74266),
		31036,
		8,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[41]
		}
	},
	[31037001] = {
		31037001,
		0,
		Lang.get(74267),
		31037,
		1,
		1012,
		nil,
		1,
		nil,
		nil,
		nil,
		182,
		31038,
		nil,
		nil,
		nil,
		nil,
		nil,
		31037
	},
	[31037002] = {
		31037002,
		0,
		Lang.get(74268),
		31037,
		2,
		1008,
		nil,
		1
	},
	[31037003] = {
		31037003,
		0,
		Lang.get(74269),
		31037,
		3,
		1012,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		3
	},
	[31037004] = {
		31037004,
		0,
		Lang.get(74270),
		31037,
		4,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[73]
		}
	},
	[31037005] = {
		31037005,
		0,
		Lang.get(74271),
		31037,
		5,
		1011,
		{
			RTResTalkAction[70],
			RTResTalkAction[79]
		}
	},
	[31038001] = {
		31038001,
		0,
		Lang.get(74272),
		31038,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31039,
		[19] = 31038
	},
	[31038002] = {
		31038002,
		0,
		Lang.get(74273),
		31038,
		2,
		1013,
		nil,
		1
	},
	[31038003] = {
		31038003,
		0,
		Lang.get(74274),
		31038,
		3,
		1011,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[31038004] = {
		31038004,
		0,
		Lang.get(74275),
		31038,
		4,
		1016,
		{
			RTResTalkAction[88],
			RTResTalkAction[71]
		}
	},
	[31039001] = {
		31039001,
		0,
		Lang.get(74276),
		31039,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31040,
		[19] = 31039
	},
	[31039002] = {
		31039002,
		0,
		Lang.get(74277),
		31039,
		2,
		239,
		nil,
		1
	},
	[31039003] = {
		31039003,
		0,
		Lang.get(74278),
		31039,
		3,
		239,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3
	},
	[31039004] = {
		31039004,
		0,
		Lang.get(74279),
		31039,
		4,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[90]
		}
	},
	[31039005] = {
		31039005,
		0,
		Lang.get(74280),
		31039,
		5,
		1010,
		{
			RTResTalkAction[16]
		}
	},
	[31039006] = {
		31039006,
		0,
		Lang.get(74281),
		31039,
		6,
		239,
		{
			RTResTalkAction[89],
			RTResTalkAction[10]
		}
	},
	[31040001] = {
		31040001,
		0,
		Lang.get(74282),
		31040,
		1,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31041,
		[19] = 31040
	},
	[31040002] = {
		31040002,
		0,
		Lang.get(74283),
		31040,
		2,
		1009,
		nil,
		1
	},
	[31040003] = {
		31040003,
		0,
		Lang.get(74284),
		31040,
		3,
		1010,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[31041001] = {
		31041001,
		0,
		Lang.get(74285),
		31041,
		1,
		239,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31042,
		[19] = 31041
	},
	[31041002] = {
		31041002,
		0,
		Lang.get(74286),
		31041,
		2,
		297,
		nil,
		1
	},
	[31041003] = {
		31041003,
		0,
		Lang.get(74287),
		31041,
		3,
		239,
		{
			RTResTalkAction[91]
		},
		nil,
		nil,
		3
	},
	[31042001] = {
		31042001,
		0,
		Lang.get(74288),
		31042,
		1,
		148,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31043,
		[19] = 31042
	},
	[31042002] = {
		31042002,
		0,
		Lang.get(74289),
		31042,
		2,
		239,
		nil,
		1
	},
	[31042003] = {
		31042003,
		0,
		Lang.get(74290),
		31042,
		3,
		148,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[31042004] = {
		31042004,
		0,
		Lang.get(74291),
		31042,
		4,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[31]
		}
	},
	[31042005] = {
		31042005,
		0,
		Lang.get(74292),
		31042,
		5,
		1014,
		{
			RTResTalkAction[77],
			RTResTalkAction[10]
		}
	},
	[31043001] = {
		31043001,
		0,
		Lang.get(74293),
		31043,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		181,
		31044,
		nil,
		nil,
		nil,
		nil,
		nil,
		31043
	},
	[31043002] = {
		31043002,
		0,
		Lang.get(74294),
		31043,
		2,
		1010,
		nil,
		1
	},
	[31043003] = {
		31043003,
		0,
		Lang.get(74295),
		31043,
		3,
		1002,
		nil,
		1
	},
	[31043004] = {
		31043004,
		0,
		Lang.get(74296),
		31043,
		4,
		1019,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		3
	},
	[31043005] = {
		31043005,
		0,
		Lang.get(74297),
		31043,
		5,
		1010,
		{
			RTResTalkAction[19],
			RTResTalkAction[93]
		}
	},
	[31043006] = {
		31043006,
		0,
		Lang.get(74298),
		31043,
		6,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[10]
		}
	},
	[31043007] = {
		31043007,
		0,
		Lang.get(74299),
		31043,
		7,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[40]
		}
	},
	[31044001] = {
		31044001,
		0,
		Lang.get(74300),
		31044,
		1,
		1010,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		31045,
		[19] = 31044
	},
	[31044002] = {
		31044002,
		0,
		Lang.get(74301),
		31044,
		2,
		107,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3
	},
	[31044003] = {
		31044003,
		0,
		Lang.get(74302),
		31044,
		3,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[52]
		}
	},
	[31044004] = {
		31044004,
		0,
		Lang.get(74303),
		31044,
		4,
		1002,
		{
			RTResTalkAction[38],
			RTResTalkAction[35]
		}
	},
	[31044005] = {
		31044005,
		0,
		Lang.get(74304),
		31044,
		5,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[40]
		}
	},
	[31044006] = {
		31044006,
		0,
		Lang.get(74305),
		31044,
		6,
		1009,
		{
			RTResTalkAction[95],
			RTResTalkAction[21]
		}
	},
	[31044007] = {
		31044007,
		0,
		Lang.get(74306),
		31044,
		7,
		1003,
		{
			RTResTalkAction[20],
			RTResTalkAction[35]
		}
	},
	[31044008] = {
		31044008,
		0,
		Lang.get(74307),
		31044,
		8,
		1009,
		{
			RTResTalkAction[43],
			RTResTalkAction[21]
		}
	},
	[31044009] = {
		31044009,
		0,
		Lang.get(74308),
		31044,
		9,
		1009,
		{
			RTResTalkAction[43]
		}
	},
	[31044010] = {
		31044010,
		0,
		Lang.get(74309),
		31044,
		10,
		1003,
		{
			RTResTalkAction[96],
			RTResTalkAction[35]
		}
	},
	[31044011] = {
		31044011,
		0,
		Lang.get(74310),
		31044,
		11,
		300,
		{
			RTResTalkAction[21]
		}
	},
	[31044012] = {
		31044012,
		0,
		Lang.get(74311),
		31044,
		12,
		1009,
		{
			RTResTalkAction[97]
		}
	},
	[31044013] = {
		31044013,
		0,
		Lang.get(74312),
		31044,
		13,
		1010,
		{
			RTResTalkAction[16],
			RTResTalkAction[35]
		}
	},
	[31044014] = {
		31044014,
		11,
		"Videos/_lazy_/AVG_Claire.mp4",
		31044,
		14,
		1010,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
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
