-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\disanshilzhang\\ResTalk.lua

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
	158,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[3] = {
	3,
	220,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[6] = {
	1,
	134,
	{
		10023
	},
	nil,
	3
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 42,
	[3] = {
		3
	}
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		2
	}
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 230,
	[3] = {
		2
	}
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 230
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 230
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 215,
	[3] = {
		2
	}
}
RTResTalkAction[18] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		2
	}
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[23] = {
	1,
	215,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 158
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		1
	}
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 220,
	[3] = {
		2
	}
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 365
}
RTResTalkAction[31] = {
	1,
	365,
	nil,
	nil,
	1
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 365
}
RTResTalkAction[33] = {
	1,
	365,
	nil,
	nil,
	3
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 134
}
RTResTalkAction[35] = {
	[1] = 2,
	[2] = 134
}
RTResTalkAction[36] = {
	2,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 42,
	[3] = {
		3
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 43
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[40] = {
	1,
	134,
	nil,
	nil,
	4
}
RTResTalkAction[41] = {
	1,
	220,
	nil,
	nil,
	1
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		100515
	}
}
RTResTalkAction[43] = {
	1,
	215,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[46] = {
	2,
	386,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	1,
	134,
	{
		2
	},
	nil,
	1
}

local Data = {
	[26500001] = {
		26500001,
		5,
		Lang.get(64903),
		26500,
		1,
		158,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		63,
		26500,
		nil,
		nil,
		nil,
		1,
		nil,
		26500
	},
	[26500002] = {
		26500002,
		0,
		Lang.get(64904),
		26500,
		2,
		220,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[26500003] = {
		26500003,
		0,
		Lang.get(64905),
		26500,
		3,
		158,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1,
		1,
		[19] = 26505
	},
	[26500004] = {
		26500004,
		0,
		Lang.get(64906),
		26500,
		4,
		220,
		nil,
		1,
		1
	},
	[26500005] = {
		26500005,
		0,
		Lang.get(64907),
		26500,
		5,
		215,
		nil,
		1
	},
	[26500006] = {
		26500006,
		0,
		Lang.get(64908),
		26500,
		6,
		158,
		nil,
		1,
		1
	},
	[26500007] = {
		26500007,
		0,
		Lang.get(64909),
		26500,
		7,
		215,
		nil,
		1,
		2
	},
	[26500008] = {
		26500008,
		0,
		Lang.get(64910),
		26500,
		8,
		220,
		nil,
		1,
		2
	},
	[26500009] = {
		26500009,
		0,
		Lang.get(64911),
		26500,
		9,
		158,
		nil,
		1
	},
	[26500010] = {
		26500010,
		0,
		Lang.get(64912),
		26500,
		10,
		230,
		nil,
		1
	},
	[26500011] = {
		26500011,
		0,
		Lang.get(64913),
		26500,
		11,
		220,
		nil,
		1,
		2
	},
	[26500012] = {
		26500012,
		0,
		Lang.get(64914),
		26500,
		12,
		158,
		nil,
		1,
		1
	},
	[26500013] = {
		26500013,
		0,
		Lang.get(64915),
		26500,
		13,
		215,
		nil,
		1,
		3
	},
	[26500014] = {
		26500014,
		0,
		Lang.get(64916),
		26500,
		14,
		158,
		nil,
		1,
		1
	},
	[26500015] = {
		26500015,
		0,
		Lang.get(64917),
		26500,
		15,
		230,
		nil,
		1
	},
	[26500016] = {
		26500016,
		4,
		nil,
		26500,
		16,
		300,
		[29] = {
			{
				id = 26500017,
				branch_content = Lang.get(64918)
			},
			{
				id = 26500017,
				branch_content = Lang.get(64919)
			}
		}
	},
	[26500017] = {
		26500017,
		0,
		Lang.get(64920),
		26500,
		17,
		158,
		nil,
		1
	},
	[26510001] = {
		26510001,
		0,
		Lang.get(64921),
		26510,
		1,
		158,
		nil,
		1,
		1,
		nil,
		nil,
		59,
		26510,
		nil,
		nil,
		nil,
		1,
		nil,
		26510
	},
	[26510002] = {
		26510002,
		0,
		Lang.get(64922),
		26510,
		2,
		215,
		nil,
		1,
		2
	},
	[26510003] = {
		26510003,
		0,
		Lang.get(64923),
		26510,
		3,
		220,
		nil,
		1,
		2
	},
	[26510004] = {
		26510004,
		4,
		nil,
		26510,
		4,
		300,
		[29] = {
			{
				id = 26510005,
				branch_content = Lang.get(23797)
			}
		}
	},
	[26510005] = {
		26510005,
		0,
		Lang.get(64924),
		26510,
		5,
		220,
		nil,
		1,
		1
	},
	[26510006] = {
		26510006,
		4,
		nil,
		26510,
		6,
		300,
		[29] = {
			{
				id = 26510007,
				branch_content = Lang.get(64925)
			}
		}
	},
	[26510007] = {
		26510007,
		0,
		Lang.get(64926),
		26510,
		7,
		220,
		nil,
		1,
		2
	},
	[26510008] = {
		26510008,
		0,
		Lang.get(64927),
		26510,
		8,
		300
	},
	[26510009] = {
		26510009,
		0,
		Lang.get(64928),
		26510,
		9,
		300
	},
	[26510010] = {
		26510010,
		0,
		Lang.get(64929),
		26510,
		10,
		300
	},
	[26510011] = {
		26510011,
		0,
		Lang.get(64930),
		26510,
		11,
		300
	},
	[26510012] = {
		26510012,
		0,
		Lang.get(64931),
		26510,
		12,
		300
	},
	[26510013] = {
		26510013,
		0,
		Lang.get(64932),
		26510,
		13,
		300
	},
	[26510014] = {
		26510014,
		0,
		Lang.get(64933),
		26510,
		14,
		158,
		nil,
		1
	},
	[26510015] = {
		26510015,
		0,
		Lang.get(64934),
		26510,
		15,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		26515
	},
	[26510016] = {
		26510016,
		4,
		nil,
		26510,
		16,
		300,
		[29] = {
			{
				id = 26510017,
				branch_content = Lang.get(64935)
			},
			{
				id = 26510017,
				branch_content = Lang.get(64936)
			}
		}
	},
	[26510017] = {
		26510017,
		0,
		Lang.get(64937),
		26510,
		17,
		215,
		nil,
		1,
		2
	},
	[26510018] = {
		26510018,
		0,
		Lang.get(64938),
		26510,
		18,
		215,
		nil,
		1,
		1
	},
	[26520001] = {
		26520001,
		0,
		Lang.get(64939),
		26520,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		26521,
		[19] = 26521
	},
	[26520002] = {
		26520002,
		0,
		Lang.get(22568),
		26520,
		2,
		134,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[26520003] = {
		26520003,
		3,
		Lang.get(64940),
		26520,
		3,
		605,
		{
			RTResTalkAction[7]
		},
		[18] = 1225,
		[22] = 1
	},
	[26520004] = {
		26520004,
		0,
		Lang.get(64941),
		26520,
		4,
		386,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		26525,
		nil,
		nil,
		nil,
		1,
		1225,
		26525
	},
	[26520005] = {
		26520005,
		0,
		Lang.get(64942),
		26520,
		5,
		158,
		nil,
		1,
		0,
		[18] = 1225
	},
	[26520006] = {
		26520006,
		0,
		Lang.get(64943),
		26520,
		6,
		134,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		26527,
		nil,
		nil,
		nil,
		1,
		1225,
		26527
	},
	[26520007] = {
		26520007,
		0,
		Lang.get(64944),
		26520,
		7,
		42,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3,
		[18] = 1225
	},
	[26520008] = {
		26520008,
		0,
		Lang.get(64945),
		26520,
		8,
		386,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		[18] = 1225
	},
	[26520009] = {
		26520009,
		4,
		nil,
		26520,
		9,
		300,
		{
			RTResTalkAction[11]
		},
		[18] = 1225,
		[29] = {
			{
				id = 26520010,
				branch_content = "……"
			},
			{
				id = 26520010,
				branch_content = Lang.get(64946)
			}
		}
	},
	[26520010] = {
		26520010,
		0,
		Lang.get(64947),
		26520,
		10,
		386,
		{
			RTResTalkAction[12]
		},
		[18] = 1225
	},
	[26520011] = {
		26520011,
		0,
		Lang.get(64948),
		26520,
		11,
		230,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		},
		[18] = 1225
	},
	[26520012] = {
		26520012,
		0,
		Lang.get(64949),
		26520,
		12,
		230,
		{
			RTResTalkAction[14]
		},
		[18] = 1225
	},
	[26520013] = {
		26520013,
		0,
		Lang.get(64950),
		26520,
		13,
		300,
		{
			RTResTalkAction[15]
		},
		[18] = 1225
	},
	[26520014] = {
		26520014,
		0,
		Lang.get(64951),
		26520,
		14,
		300,
		[18] = 1225
	},
	[26520015] = {
		26520015,
		0,
		Lang.get(64952),
		26520,
		15,
		386,
		{
			RTResTalkAction[12]
		}
	},
	[26520016] = {
		26520016,
		0,
		Lang.get(64953),
		26520,
		16,
		386,
		{
			RTResTalkAction[9]
		}
	},
	[26520017] = {
		26520017,
		0,
		Lang.get(64954),
		26520,
		17,
		158,
		{
			RTResTalkAction[16],
			RTResTalkAction[11]
		}
	},
	[26530001] = {
		26530001,
		0,
		Lang.get(64955),
		26530,
		1,
		215,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		26530,
		nil,
		nil,
		nil,
		nil,
		nil,
		26530
	},
	[26530002] = {
		26530002,
		0,
		Lang.get(64956),
		26530,
		2,
		158,
		nil,
		1
	},
	[26530003] = {
		26530003,
		0,
		Lang.get(64957),
		26530,
		3,
		300
	},
	[26530004] = {
		26530004,
		0,
		Lang.get(64958),
		26530,
		4,
		215,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[26530005] = {
		26530005,
		0,
		Lang.get(64959),
		26530,
		5,
		220,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[26530006] = {
		26530006,
		0,
		Lang.get(64960),
		26530,
		6,
		158,
		{
			RTResTalkAction[20],
			RTResTalkAction[5]
		}
	},
	[26530007] = {
		26530007,
		0,
		Lang.get(64961),
		26530,
		7,
		215,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[26530008] = {
		26530008,
		0,
		Lang.get(64962),
		26530,
		8,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[19]
		}
	},
	[26530009] = {
		26530009,
		0,
		Lang.get(64963),
		26530,
		9,
		220,
		{
			RTResTalkAction[22]
		}
	},
	[26530010] = {
		26530010,
		0,
		Lang.get(64964),
		26530,
		10,
		158,
		{
			RTResTalkAction[16],
			RTResTalkAction[5]
		}
	},
	[26530011] = {
		26530011,
		0,
		Lang.get(64965),
		26530,
		11,
		230,
		{
			RTResTalkAction[14],
			RTResTalkAction[4]
		}
	},
	[26530012] = {
		26530012,
		0,
		Lang.get(64966),
		26530,
		12,
		215,
		{
			RTResTalkAction[23],
			RTResTalkAction[15]
		}
	},
	[26540001] = {
		26540001,
		0,
		Lang.get(64967),
		26540,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		26540,
		nil,
		nil,
		nil,
		1,
		nil,
		26540
	},
	[26540002] = {
		26540002,
		0,
		Lang.get(64968),
		26540,
		2,
		42,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26541,
		[19] = 26541
	},
	[26540003] = {
		26540003,
		0,
		Lang.get(64969),
		26540,
		3,
		134,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		26542,
		nil,
		nil,
		nil,
		1,
		nil,
		26542
	},
	[26540004] = {
		26540004,
		0,
		Lang.get(64970),
		26540,
		4,
		42,
		nil,
		1
	},
	[26540005] = {
		26540005,
		0,
		Lang.get(64971),
		26540,
		5,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26543,
		[19] = 26543
	},
	[26540006] = {
		26540006,
		0,
		Lang.get(64972),
		26540,
		6,
		134,
		nil,
		1,
		2
	},
	[26540007] = {
		26540007,
		0,
		Lang.get(64973),
		26540,
		7,
		300
	},
	[26540008] = {
		26540008,
		0,
		Lang.get(64974),
		26540,
		8,
		215,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[26540009] = {
		26540009,
		0,
		Lang.get(64975),
		26540,
		9,
		158,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[26540010] = {
		26540010,
		0,
		Lang.get(64976),
		26540,
		10,
		42,
		{
			RTResTalkAction[8],
			RTResTalkAction[19],
			RTResTalkAction[4]
		}
	},
	[26540011] = {
		26540011,
		0,
		Lang.get(64977),
		26540,
		11,
		220,
		{
			RTResTalkAction[26],
			RTResTalkAction[10]
		}
	},
	[26540012] = {
		26540012,
		0,
		Lang.get(64978),
		26540,
		12,
		220,
		{
			RTResTalkAction[22]
		}
	},
	[26540013] = {
		26540013,
		0,
		Lang.get(64979),
		26540,
		13,
		220,
		{
			RTResTalkAction[27]
		}
	},
	[26540014] = {
		26540014,
		0,
		Lang.get(64980),
		26540,
		14,
		158,
		{
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[26540015] = {
		26540015,
		0,
		Lang.get(64981),
		26540,
		15,
		220,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[26540016] = {
		26540016,
		0,
		Lang.get(64982),
		26540,
		16,
		220,
		{
			RTResTalkAction[27]
		}
	},
	[26540017] = {
		26540017,
		5,
		Lang.get(64983),
		26540,
		17,
		134,
		{
			RTResTalkAction[22]
		},
		1,
		5
	},
	[26540018] = {
		26540018,
		0,
		Lang.get(64984),
		26540,
		18,
		158,
		{
			RTResTalkAction[20],
			RTResTalkAction[5]
		}
	},
	[26550001] = {
		26550001,
		0,
		Lang.get(64985),
		26550,
		1,
		220,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3,
		nil,
		63,
		26550,
		nil,
		nil,
		nil,
		nil,
		nil,
		26550
	},
	[26550002] = {
		26550002,
		0,
		Lang.get(64986),
		26550,
		2,
		158,
		{
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[26550003] = {
		26550003,
		0,
		Lang.get(64987),
		26550,
		3,
		220,
		{
			RTResTalkAction[22],
			RTResTalkAction[4]
		}
	},
	[26550004] = {
		26550004,
		4,
		nil,
		26550,
		4,
		300,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 26550005,
				branch_content = Lang.get(64988)
			},
			{
				id = 26550008,
				branch_content = Lang.get(64989)
			}
		}
	},
	[26550005] = {
		26550005,
		0,
		Lang.get(64990),
		26550,
		5,
		215,
		{
			RTResTalkAction[29]
		}
	},
	[26550006] = {
		26550006,
		0,
		Lang.get(64991),
		26550,
		6,
		158,
		{
			RTResTalkAction[16],
			RTResTalkAction[19]
		}
	},
	[26550007] = {
		26550007,
		0,
		Lang.get(64992),
		26550,
		7,
		220,
		{
			RTResTalkAction[4]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		26551,
		nil,
		nil,
		nil,
		nil,
		nil,
		26551
	},
	[26550008] = {
		26550008,
		0,
		Lang.get(64993),
		26550,
		8,
		220,
		nil,
		1
	},
	[26550009] = {
		26550009,
		11,
		"Videos/_lazy_/AVG_blackYuki_m.mp4",
		26550,
		9,
		220
	},
	[26550010] = {
		26550010,
		0,
		Lang.get(64994),
		26550,
		10,
		220,
		nil,
		1,
		3
	},
	[26550011] = {
		26550011,
		0,
		Lang.get(64995),
		26550,
		11,
		220,
		nil,
		1
	},
	[26550012] = {
		26550012,
		0,
		Lang.get(51829),
		26550,
		12,
		300
	},
	[26550013] = {
		26550013,
		0,
		Lang.get(64996),
		26550,
		13,
		220,
		nil,
		1
	},
	[26550014] = {
		26550014,
		4,
		nil,
		26550,
		14,
		300,
		[29] = {
			{
				id = 26550015,
				branch_content = Lang.get(64997)
			},
			{
				id = 26550016,
				branch_content = Lang.get(64998)
			}
		}
	},
	[26550015] = {
		26550015,
		0,
		Lang.get(64999),
		26550,
		15,
		215,
		nil,
		1
	},
	[26550016] = {
		26550016,
		0,
		Lang.get(65000),
		26550,
		16,
		300
	},
	[26560001] = {
		26560001,
		13,
		nil,
		26560,
		1,
		300,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		-1,
		nil,
		63,
		26560,
		nil,
		nil,
		nil,
		nil,
		nil,
		26560,
		220,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[26560002] = {
		26560002,
		13,
		Lang.get(65001),
		26560,
		2,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26560003] = {
		26560003,
		4,
		nil,
		26560,
		3,
		300,
		{
			RTResTalkAction[32]
		},
		[29] = {
			{
				id = 26560004,
				branch_content = "……"
			},
			{
				id = 26560004,
				branch_content = Lang.get(65002)
			}
		}
	},
	[26560004] = {
		26560004,
		13,
		Lang.get(65003),
		26560,
		4,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26560005] = {
		26560005,
		13,
		Lang.get(65004),
		26560,
		5,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26560006] = {
		26560006,
		4,
		nil,
		26560,
		6,
		300,
		{
			RTResTalkAction[32]
		},
		[29] = {
			{
				id = 26560007,
				branch_content = Lang.get(65005)
			},
			{
				id = 26560013,
				branch_content = Lang.get(18644)
			}
		}
	},
	[26560007] = {
		26560007,
		13,
		Lang.get(27595),
		26560,
		7,
		365,
		{
			RTResTalkAction[33]
		},
		[27] = 3
	},
	[26560008] = {
		26560008,
		13,
		Lang.get(65006),
		26560,
		8,
		365,
		{
			RTResTalkAction[30]
		},
		[27] = 3
	},
	[26560009] = {
		26560009,
		13,
		Lang.get(65007),
		26560,
		9,
		365,
		{
			RTResTalkAction[30]
		},
		[27] = 3
	},
	[26560010] = {
		26560010,
		0,
		Lang.get(65008),
		26560,
		10,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[26560011] = {
		26560011,
		0,
		Lang.get(54830),
		26560,
		11,
		215,
		nil,
		1,
		2,
		-1,
		nil,
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
	[26560012] = {
		26560012,
		0,
		Lang.get(65009),
		26560,
		12,
		215,
		nil,
		1,
		1
	},
	[26560013] = {
		26560013,
		0,
		Lang.get(65010),
		26560,
		13,
		215,
		nil,
		1,
		1
	},
	[26560014] = {
		26560014,
		4,
		nil,
		26560,
		14,
		300,
		[29] = {
			{
				id = 26560015,
				branch_content = "……"
			},
			{
				id = 26560015,
				branch_content = Lang.get(65011)
			}
		}
	},
	[26560015] = {
		26560015,
		0,
		Lang.get(65012),
		26560,
		15,
		215,
		{
			RTResTalkAction[29]
		},
		1,
		nil,
		3
	},
	[26570001] = {
		26570001,
		13,
		Lang.get(65013),
		26570,
		1,
		365,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		nil,
		122,
		26570,
		nil,
		nil,
		nil,
		nil,
		nil,
		26570,
		220,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3
	},
	[26570002] = {
		26570002,
		13,
		Lang.get(65014),
		26570,
		2,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570003] = {
		26570003,
		13,
		Lang.get(65015),
		26570,
		3,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570004] = {
		26570004,
		13,
		Lang.get(65016),
		26570,
		4,
		158,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		0,
		[27] = 3
	},
	[26570005] = {
		26570005,
		13,
		Lang.get(65017),
		26570,
		5,
		365,
		{
			RTResTalkAction[33]
		},
		[27] = 3
	},
	[26570006] = {
		26570006,
		13,
		Lang.get(65018),
		26570,
		6,
		386,
		{
			RTResTalkAction[30]
		},
		1,
		nil,
		0,
		[27] = 3
	},
	[26570007] = {
		26570007,
		13,
		Lang.get(65019),
		26570,
		7,
		158,
		{
			RTResTalkAction[30]
		},
		1,
		[27] = 3
	},
	[26570008] = {
		26570008,
		13,
		Lang.get(65020),
		26570,
		8,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570009] = {
		26570009,
		0,
		Lang.get(65021),
		26570,
		9,
		158,
		{
			RTResTalkAction[32]
		},
		1,
		nil,
		-1,
		nil,
		nil,
		26571,
		nil,
		nil,
		nil,
		1,
		nil,
		26571,
		1
	},
	[26570010] = {
		26570010,
		13,
		Lang.get(65022),
		26570,
		10,
		365,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		-1,
		[27] = 3,
		[20] = 220
	},
	[26570011] = {
		26570011,
		13,
		Lang.get(65023),
		26570,
		11,
		386,
		{
			RTResTalkAction[32]
		},
		1,
		[27] = 3
	},
	[26570012] = {
		26570012,
		13,
		Lang.get(65024),
		26570,
		12,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570013] = {
		26570013,
		13,
		Lang.get(65025),
		26570,
		13,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570014] = {
		26570014,
		13,
		Lang.get(65026),
		26570,
		14,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570015] = {
		26570015,
		4,
		nil,
		26570,
		15,
		300,
		{
			RTResTalkAction[32]
		},
		[29] = {
			{
				id = 26570016,
				branch_content = Lang.get(65027)
			}
		}
	},
	[26570016] = {
		26570016,
		13,
		Lang.get(65028),
		26570,
		16,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570017] = {
		26570017,
		13,
		Lang.get(65029),
		26570,
		17,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570018] = {
		26570018,
		13,
		Lang.get(65030),
		26570,
		18,
		365,
		{
			RTResTalkAction[31]
		},
		[27] = 3
	},
	[26570019] = {
		26570019,
		13,
		Lang.get(65031),
		26570,
		19,
		365,
		{
			RTResTalkAction[33]
		},
		[27] = 3
	},
	[26580001] = {
		26580001,
		0,
		Lang.get(65032),
		26580,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		26580,
		nil,
		nil,
		nil,
		nil,
		nil,
		26580
	},
	[26580002] = {
		26580002,
		0,
		Lang.get(65033),
		26580,
		2,
		215,
		nil,
		1,
		3
	},
	[26580003] = {
		26580003,
		0,
		Lang.get(67762),
		26580,
		3,
		215,
		nil,
		1,
		1
	},
	[26580004] = {
		26580004,
		0,
		Lang.get(65034),
		26580,
		4,
		158,
		nil,
		1
	},
	[26580005] = {
		26580005,
		0,
		Lang.get(65035),
		26580,
		5,
		134,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[26580006] = {
		26580006,
		0,
		Lang.get(65036),
		26580,
		6,
		215,
		{
			RTResTalkAction[35],
			RTResTalkAction[21]
		}
	},
	[26580007] = {
		26580007,
		0,
		Lang.get(65037),
		26580,
		7,
		134,
		{
			RTResTalkAction[34],
			RTResTalkAction[19]
		}
	},
	[26580008] = {
		26580008,
		0,
		Lang.get(65038),
		26580,
		8,
		42,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[26580009] = {
		26580009,
		0,
		Lang.get(65039),
		26580,
		9,
		43,
		{
			RTResTalkAction[38],
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[26580010] = {
		26580010,
		0,
		Lang.get(65040),
		26580,
		10,
		215,
		{
			RTResTalkAction[29],
			RTResTalkAction[39]
		}
	},
	[26580011] = {
		26580011,
		0,
		Lang.get(65041),
		26580,
		11,
		134,
		{
			RTResTalkAction[40],
			RTResTalkAction[19]
		}
	},
	[26580012] = {
		26580012,
		0,
		Lang.get(65042),
		26580,
		12,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[7]
		}
	},
	[26580013] = {
		26580013,
		0,
		Lang.get(65043),
		26580,
		13,
		158,
		{
			RTResTalkAction[42],
			RTResTalkAction[5]
		}
	},
	[26580014] = {
		26580014,
		0,
		Lang.get(65044),
		26580,
		14,
		215,
		{
			RTResTalkAction[43],
			RTResTalkAction[4]
		}
	},
	[26590001] = {
		26590001,
		0,
		Lang.get(65045),
		26590,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		26590,
		nil,
		nil,
		nil,
		1,
		nil,
		26590
	},
	[26590002] = {
		26590002,
		0,
		Lang.get(65046),
		26590,
		2,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26591,
		[19] = 26591,
		[17] = 1
	},
	[26590003] = {
		26590003,
		0,
		Lang.get(65047),
		26590,
		3,
		158,
		nil,
		1
	},
	[26590004] = {
		26590004,
		0,
		Lang.get(65048),
		26590,
		4,
		215,
		nil,
		1,
		3
	},
	[26590005] = {
		26590005,
		0,
		Lang.get(65049),
		26590,
		5,
		158,
		nil,
		1
	},
	[26590006] = {
		26590006,
		0,
		Lang.get(65050),
		26590,
		6,
		151,
		nil,
		1
	},
	[26590007] = {
		26590007,
		5,
		Lang.get(65051),
		26590,
		7,
		42,
		nil,
		1
	},
	[26590008] = {
		26590008,
		0,
		Lang.get(65052),
		26590,
		8,
		386,
		nil,
		1
	},
	[26590009] = {
		26590009,
		0,
		Lang.get(65053),
		26590,
		9,
		43,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26592,
		[19] = 26592,
		[17] = 1
	},
	[26590010] = {
		26590010,
		0,
		Lang.get(65054),
		26590,
		10,
		151,
		nil,
		1,
		5
	},
	[26590011] = {
		26590011,
		0,
		Lang.get(65055),
		26590,
		11,
		151,
		nil,
		1,
		4
	},
	[26590012] = {
		26590012,
		0,
		Lang.get(65056),
		26590,
		12,
		151,
		nil,
		1,
		4
	},
	[26590013] = {
		26590013,
		0,
		Lang.get(65057),
		26590,
		13,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26593,
		[19] = 26593,
		[17] = 1
	},
	[26590014] = {
		26590014,
		0,
		Lang.get(65058),
		26590,
		14,
		43,
		nil,
		1
	},
	[26590015] = {
		26590015,
		0,
		Lang.get(65059),
		26590,
		15,
		42,
		nil,
		1
	},
	[26590016] = {
		26590016,
		0,
		Lang.get(65060),
		26590,
		16,
		151,
		nil,
		1,
		4
	},
	[26590017] = {
		26590017,
		0,
		Lang.get(65061),
		26590,
		17,
		220,
		nil,
		1,
		3
	},
	[26600001] = {
		26600001,
		0,
		Lang.get(65062),
		26600,
		1,
		220,
		nil,
		1,
		1,
		nil,
		nil,
		158,
		26600,
		nil,
		nil,
		nil,
		nil,
		nil,
		26600
	},
	[26600002] = {
		26600002,
		0,
		Lang.get(65063),
		26600,
		2,
		215,
		nil,
		1,
		1
	},
	[26600003] = {
		26600003,
		4,
		nil,
		26600,
		3,
		300,
		[29] = {
			{
				id = 26600004,
				branch_content = Lang.get(65064)
			},
			{
				id = 26600004,
				branch_content = Lang.get(65065)
			}
		}
	},
	[26600004] = {
		26600004,
		0,
		Lang.get(65066),
		26600,
		4,
		158,
		nil,
		1
	},
	[26600005] = {
		26600005,
		0,
		Lang.get(65067),
		26600,
		5,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		26610,
		[19] = 26610,
		[17] = 1
	},
	[26600006] = {
		26600006,
		0,
		Lang.get(65068),
		26600,
		6,
		151,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[26600007] = {
		26600007,
		0,
		Lang.get(65069),
		26600,
		7,
		386,
		{
			RTResTalkAction[9],
			RTResTalkAction[45]
		}
	},
	[26600008] = {
		26600008,
		0,
		Lang.get(65070),
		26600,
		8,
		215,
		{
			RTResTalkAction[46],
			RTResTalkAction[21]
		}
	},
	[26600009] = {
		26600009,
		0,
		Lang.get(65071),
		26600,
		9,
		220,
		{
			RTResTalkAction[27],
			RTResTalkAction[11],
			RTResTalkAction[19]
		}
	},
	[26600010] = {
		26600010,
		0,
		Lang.get(65072),
		26600,
		10,
		151,
		{
			RTResTalkAction[44],
			RTResTalkAction[5]
		}
	},
	[26600011] = {
		26600011,
		0,
		Lang.get(65073),
		26600,
		11,
		134,
		{
			RTResTalkAction[47],
			RTResTalkAction[45]
		}
	},
	[26600012] = {
		26600012,
		0,
		Lang.get(65074),
		26600,
		12,
		215,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[26600013] = {
		26600013,
		0,
		Lang.get(65075),
		26600,
		13,
		220,
		{
			RTResTalkAction[27],
			RTResTalkAction[19]
		}
	},
	[26600014] = {
		26600014,
		4,
		nil,
		26600,
		14,
		300,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 26600015,
				branch_content = Lang.get(65076)
			},
			{
				id = 26600015,
				branch_content = Lang.get(65077)
			}
		}
	},
	[26600015] = {
		26600015,
		3,
		Lang.get(65078),
		26600,
		15,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		26630,
		nil,
		nil,
		nil,
		nil,
		nil,
		26630,
		255,
		nil,
		1
	},
	[26600016] = {
		26600016,
		0,
		Lang.get(65079),
		26600,
		16,
		220,
		nil,
		1,
		2
	},
	[26600017] = {
		26600017,
		0,
		Lang.get(65080),
		26600,
		17,
		215,
		nil,
		1,
		2
	},
	[26600018] = {
		26600018,
		0,
		Lang.get(65081),
		26600,
		18,
		220,
		nil,
		1,
		2
	},
	[26600019] = {
		26600019,
		0,
		Lang.get(65082),
		26600,
		19,
		215,
		nil,
		1,
		3
	},
	[26600020] = {
		26600020,
		0,
		Lang.get(65083),
		26600,
		20,
		215,
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
