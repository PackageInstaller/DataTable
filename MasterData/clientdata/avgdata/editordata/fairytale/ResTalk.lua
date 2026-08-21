-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\FairyTale\\ResTalk.lua

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
	107,
	nil,
	nil,
	7
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[6] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[7] = {
	1,
	1023,
	nil,
	nil,
	2
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1023
}
RTResTalkAction[10] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 1023
}
RTResTalkAction[12] = {
	3,
	1023,
	nil,
	nil,
	0
}
RTResTalkAction[13] = {
	2,
	107,
	nil,
	nil,
	0
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 1023
}
RTResTalkAction[15] = {
	1,
	1303,
	nil,
	nil,
	2
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 1303
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 1303
}
RTResTalkAction[18] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 923
}
RTResTalkAction[20] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 923
}
RTResTalkAction[22] = {
	1,
	1023,
	nil,
	nil,
	1
}
RTResTalkAction[23] = {
	[1] = 2,
	[2] = 1303
}
RTResTalkAction[24] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[25] = {
	1,
	1303,
	nil,
	nil,
	1
}
RTResTalkAction[26] = {
	1,
	921,
	nil,
	nil,
	1
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 921
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1276
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 1276
}
RTResTalkAction[30] = {
	1,
	1276,
	nil,
	nil,
	5
}
RTResTalkAction[31] = {
	1,
	1276,
	nil,
	nil,
	1
}
RTResTalkAction[32] = {
	1,
	1276,
	nil,
	nil,
	3
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 922
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 1305
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 922
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 1305
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 1304
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 1304
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 1302
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 1302
}
RTResTalkAction[41] = {
	1,
	1302,
	nil,
	nil,
	2
}
RTResTalkAction[42] = {
	1,
	1302,
	nil,
	nil,
	0
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 376
}

local Data = {
	[43000001] = {
		43000001,
		0,
		Lang.get(116693),
		43000,
		1,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		62,
		43000,
		nil,
		1,
		nil,
		1,
		nil,
		43000
	},
	[43000002] = {
		43000002,
		4,
		nil,
		43000,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3,
		[29] = {
			{
				id = 43000003,
				branch_content = Lang.get(116694)
			},
			{
				id = 43000003,
				branch_content = Lang.get(116695)
			}
		}
	},
	[43000003] = {
		43000003,
		0,
		Lang.get(116696),
		43000,
		3,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43000004] = {
		43000004,
		0,
		Lang.get(116697),
		43000,
		4,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[43000005] = {
		43000005,
		0,
		Lang.get(116698),
		43000,
		5,
		300
	},
	[43000006] = {
		43000006,
		0,
		Lang.get(116699),
		43000,
		6,
		300
	},
	[43000007] = {
		43000007,
		0,
		Lang.get(116700),
		43000,
		7,
		300
	},
	[43000008] = {
		43000008,
		0,
		Lang.get(116701),
		43000,
		8,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[43000009] = {
		43000009,
		0,
		Lang.get(116702),
		43000,
		9,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[43000010] = {
		43000010,
		0,
		Lang.get(116703),
		43000,
		10,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[43000011] = {
		43000011,
		3,
		Lang.get(116704),
		43000,
		11,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43001,
		nil,
		1,
		nil,
		1,
		nil,
		43001,
		nil,
		nil,
		1
	},
	[43000012] = {
		43000012,
		0,
		Lang.get(116705),
		43000,
		12,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[43000013] = {
		43000013,
		0,
		Lang.get(116706),
		43000,
		13,
		919,
		{
			RTResTalkAction[3]
		},
		1
	},
	[43000014] = {
		43000014,
		0,
		Lang.get(116707),
		43000,
		14,
		107,
		{
			RTResTalkAction[6]
		}
	},
	[43000015] = {
		43000015,
		0,
		Lang.get(116708),
		43000,
		15,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43000016] = {
		43000016,
		0,
		Lang.get(116709),
		43000,
		16,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[43001001] = {
		43001001,
		0,
		Lang.get(116710),
		43001,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		43002,
		nil,
		1,
		nil,
		1,
		nil,
		43002
	},
	[43001002] = {
		43001002,
		0,
		Lang.get(117004),
		43001,
		2,
		1023,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[43001003] = {
		43001003,
		0,
		Lang.get(116712),
		43001,
		3,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[43001004] = {
		43001004,
		0,
		Lang.get(116713),
		43001,
		4,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43001005] = {
		43001005,
		0,
		Lang.get(116714),
		43001,
		5,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001006] = {
		43001006,
		0,
		Lang.get(116715),
		43001,
		6,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001007] = {
		43001007,
		0,
		Lang.get(116716),
		43001,
		7,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001008] = {
		43001008,
		0,
		Lang.get(116717),
		43001,
		8,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001009] = {
		43001009,
		0,
		Lang.get(116718),
		43001,
		9,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001010] = {
		43001010,
		0,
		Lang.get(116719),
		43001,
		10,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001011] = {
		43001011,
		0,
		Lang.get(116720),
		43001,
		11,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001012] = {
		43001012,
		0,
		Lang.get(116721),
		43001,
		12,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001013] = {
		43001013,
		0,
		Lang.get(116722),
		43001,
		13,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43001014] = {
		43001014,
		0,
		Lang.get(116723),
		43001,
		14,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[12]
		}
	},
	[43001015] = {
		43001015,
		0,
		Lang.get(116724),
		43001,
		15,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[43001016] = {
		43001016,
		0,
		Lang.get(116725),
		43001,
		16,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43002001] = {
		43002001,
		3,
		Lang.get(116726),
		43002,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		43004,
		nil,
		1,
		nil,
		1,
		nil,
		43004,
		nil,
		nil,
		1
	},
	[43002002] = {
		43002002,
		0,
		Lang.get(116727),
		43002,
		2,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[43002003] = {
		43002003,
		0,
		Lang.get(116728),
		43002,
		3,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002004] = {
		43002004,
		0,
		Lang.get(116729),
		43002,
		4,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002005] = {
		43002005,
		0,
		Lang.get(116730),
		43002,
		5,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002006] = {
		43002006,
		0,
		Lang.get(116731),
		43002,
		6,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002007] = {
		43002007,
		0,
		Lang.get(116732),
		43002,
		7,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002008] = {
		43002008,
		0,
		Lang.get(116733),
		43002,
		8,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002009] = {
		43002009,
		0,
		Lang.get(116734),
		43002,
		9,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43002010] = {
		43002010,
		0,
		Lang.get(116735),
		43002,
		10,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[43002011] = {
		43002011,
		0,
		Lang.get(116736),
		43002,
		11,
		920,
		{
			RTResTalkAction[3]
		},
		1
	},
	[43002012] = {
		43002012,
		0,
		Lang.get(116737),
		43002,
		12,
		1023,
		{
			RTResTalkAction[14]
		}
	},
	[43002013] = {
		43002013,
		0,
		Lang.get(116738),
		43002,
		13,
		920,
		{
			RTResTalkAction[9]
		}
	},
	[43002014] = {
		43002014,
		0,
		Lang.get(116739),
		43002,
		14,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[43003001] = {
		43003001,
		3,
		Lang.get(116740),
		43003,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		63,
		43005,
		nil,
		1,
		nil,
		1,
		nil,
		43005,
		nil,
		nil,
		1
	},
	[43003002] = {
		43003002,
		0,
		Lang.get(116741),
		43003,
		2,
		1303,
		{
			RTResTalkAction[15]
		}
	},
	[43003003] = {
		43003003,
		0,
		Lang.get(116742),
		43003,
		3,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43003004] = {
		43003004,
		0,
		Lang.get(116743),
		43003,
		4,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[17]
		}
	},
	[43003005] = {
		43003005,
		0,
		Lang.get(116744),
		43003,
		5,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[11]
		}
	},
	[43003006] = {
		43003006,
		0,
		Lang.get(116745),
		43003,
		6,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43003007] = {
		43003007,
		0,
		Lang.get(116746),
		43003,
		7,
		923,
		{
			RTResTalkAction[19],
			RTResTalkAction[9]
		}
	},
	[43003008] = {
		43003008,
		0,
		Lang.get(116747),
		43003,
		8,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[43004001] = {
		43004001,
		0,
		Lang.get(116748),
		43004,
		1,
		1303,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		43006,
		nil,
		1,
		nil,
		1,
		nil,
		43006
	},
	[43004002] = {
		43004002,
		0,
		Lang.get(116749),
		43004,
		2,
		1303,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[43004003] = {
		43004003,
		7,
		"127",
		43004,
		3,
		1303,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[43004004] = {
		43004004,
		0,
		Lang.get(116750),
		43004,
		4,
		1023,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[43004005] = {
		43004005,
		0,
		Lang.get(116751),
		43004,
		5,
		1303,
		{
			RTResTalkAction[23],
			RTResTalkAction[11]
		}
	},
	[43004006] = {
		43004006,
		0,
		Lang.get(116752),
		43004,
		6,
		1023,
		{
			RTResTalkAction[23],
			RTResTalkAction[11]
		}
	},
	[43004007] = {
		43004007,
		2,
		Lang.get(116753),
		43004,
		7,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[17],
			RTResTalkAction[9]
		}
	},
	[43004008] = {
		43004008,
		0,
		Lang.get(116754),
		43004,
		8,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43005001] = {
		43005001,
		3,
		Lang.get(116755),
		43005,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43007,
		nil,
		1,
		nil,
		1,
		nil,
		43007,
		nil,
		nil,
		1
	},
	[43005002] = {
		43005002,
		0,
		Lang.get(116756),
		43005,
		2,
		1303,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[43005003] = {
		43005003,
		0,
		Lang.get(116757),
		43005,
		3,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43005004] = {
		43005004,
		0,
		Lang.get(116758),
		43005,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43005005] = {
		43005005,
		0,
		Lang.get(116759),
		43005,
		5,
		1023,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[43005006] = {
		43005006,
		0,
		Lang.get(116760),
		43005,
		6,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[43005007] = {
		43005007,
		0,
		Lang.get(116761),
		43005,
		7,
		1303,
		{
			RTResTalkAction[25],
			RTResTalkAction[3]
		}
	},
	[43005008] = {
		43005008,
		0,
		Lang.get(116762),
		43005,
		8,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43005009] = {
		43005009,
		0,
		Lang.get(116763),
		43005,
		9,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43005010] = {
		43005010,
		0,
		Lang.get(116764),
		43005,
		10,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43005011] = {
		43005011,
		0,
		Lang.get(116765),
		43005,
		11,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[17]
		}
	},
	[43005012] = {
		43005012,
		0,
		Lang.get(116766),
		43005,
		12,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43005013] = {
		43005013,
		0,
		Lang.get(116767),
		43005,
		13,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43005014] = {
		43005014,
		0,
		Lang.get(116768),
		43005,
		14,
		107,
		{
			RTResTalkAction[24],
			RTResTalkAction[17]
		}
	},
	[43006001] = {
		43006001,
		0,
		Lang.get(116769),
		43006,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43009,
		nil,
		1,
		nil,
		1,
		nil,
		43009
	},
	[43006002] = {
		43006002,
		0,
		Lang.get(116770),
		43006,
		2,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[43006003] = {
		43006003,
		0,
		Lang.get(116771),
		43006,
		3,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43006004] = {
		43006004,
		0,
		Lang.get(116772),
		43006,
		4,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43006005] = {
		43006005,
		0,
		Lang.get(116773),
		43006,
		5,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43006006] = {
		43006006,
		0,
		Lang.get(116774),
		43006,
		6,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43006007] = {
		43006007,
		0,
		Lang.get(116775),
		43006,
		7,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43006008] = {
		43006008,
		0,
		Lang.get(116776),
		43006,
		8,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[17]
		}
	},
	[43006009] = {
		43006009,
		0,
		Lang.get(116777),
		43006,
		9,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43006010] = {
		43006010,
		0,
		Lang.get(116778),
		43006,
		10,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43006011] = {
		43006011,
		0,
		Lang.get(116779),
		43006,
		11,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43006012] = {
		43006012,
		0,
		Lang.get(116780),
		43006,
		12,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43006013] = {
		43006013,
		0,
		Lang.get(116781),
		43006,
		13,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43006014] = {
		43006014,
		0,
		Lang.get(116782),
		43006,
		14,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43007001] = {
		43007001,
		3,
		Lang.get(116783),
		43007,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43011,
		nil,
		1,
		nil,
		1,
		nil,
		43011,
		nil,
		nil,
		1
	},
	[43007002] = {
		43007002,
		0,
		Lang.get(116784),
		43007,
		2,
		107,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[43007003] = {
		43007003,
		0,
		Lang.get(116785),
		43007,
		3,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43007004] = {
		43007004,
		0,
		Lang.get(116786),
		43007,
		4,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43007005] = {
		43007005,
		0,
		Lang.get(116787),
		43007,
		5,
		921,
		{
			RTResTalkAction[26],
			RTResTalkAction[17]
		}
	},
	[43007006] = {
		43007006,
		0,
		Lang.get(116788),
		43007,
		6,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[27]
		}
	},
	[43007007] = {
		43007007,
		0,
		Lang.get(116789),
		43007,
		7,
		1276,
		{
			RTResTalkAction[28],
			RTResTalkAction[3]
		}
	},
	[43007008] = {
		43007008,
		0,
		Lang.get(116790),
		43007,
		8,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[29]
		}
	},
	[43007009] = {
		43007009,
		0,
		Lang.get(116791),
		43007,
		9,
		1276,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		43012,
		nil,
		1,
		nil,
		1,
		nil,
		43012
	},
	[43007010] = {
		43007010,
		0,
		Lang.get(116792),
		43007,
		10,
		1276,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[43007011] = {
		43007011,
		3,
		Lang.get(21922),
		43007,
		11,
		605,
		{
			RTResTalkAction[29]
		},
		[22] = 1
	},
	[43007012] = {
		43007012,
		0,
		Lang.get(116793),
		43007,
		12,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43007013] = {
		43007013,
		0,
		Lang.get(116794),
		43007,
		13,
		1276,
		{
			RTResTalkAction[31],
			RTResTalkAction[3]
		}
	},
	[43007014] = {
		43007014,
		0,
		Lang.get(116795),
		43007,
		14,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[29]
		}
	},
	[43007015] = {
		43007015,
		0,
		Lang.get(116796),
		43007,
		15,
		1276,
		{
			RTResTalkAction[28],
			RTResTalkAction[9]
		}
	},
	[43007016] = {
		43007016,
		0,
		Lang.get(116797),
		43007,
		16,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[29]
		}
	},
	[43007017] = {
		43007017,
		0,
		Lang.get(116798),
		43007,
		17,
		1276,
		{
			RTResTalkAction[32],
			RTResTalkAction[3]
		}
	},
	[43008001] = {
		43008001,
		3,
		Lang.get(116799),
		43008,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		43013,
		nil,
		1,
		nil,
		1,
		nil,
		43013,
		nil,
		nil,
		1
	},
	[43008002] = {
		43008002,
		0,
		Lang.get(116800),
		43008,
		2,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[43008003] = {
		43008003,
		0,
		Lang.get(116801),
		43008,
		3,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008004] = {
		43008004,
		0,
		Lang.get(116802),
		43008,
		4,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008005] = {
		43008005,
		0,
		Lang.get(116803),
		43008,
		5,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008006] = {
		43008006,
		0,
		Lang.get(116804),
		43008,
		6,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008007] = {
		43008007,
		0,
		Lang.get(116805),
		43008,
		7,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008008] = {
		43008008,
		0,
		Lang.get(116806),
		43008,
		8,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008009] = {
		43008009,
		0,
		Lang.get(116807),
		43008,
		9,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008010] = {
		43008010,
		0,
		Lang.get(116808),
		43008,
		10,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008011] = {
		43008011,
		0,
		Lang.get(116809),
		43008,
		11,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008012] = {
		43008012,
		0,
		Lang.get(116810),
		43008,
		12,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008013] = {
		43008013,
		0,
		Lang.get(116811),
		43008,
		13,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008014] = {
		43008014,
		0,
		Lang.get(116812),
		43008,
		14,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43008015] = {
		43008015,
		0,
		Lang.get(116813),
		43008,
		15,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[43009001] = {
		43009001,
		0,
		Lang.get(116814),
		43009,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43015,
		nil,
		1,
		nil,
		1,
		nil,
		43015
	},
	[43009002] = {
		43009002,
		0,
		Lang.get(116815),
		43009,
		2,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[43009003] = {
		43009003,
		0,
		Lang.get(116816),
		43009,
		3,
		922,
		{
			RTResTalkAction[33],
			RTResTalkAction[9]
		}
	},
	[43009004] = {
		43009004,
		0,
		Lang.get(116817),
		43009,
		4,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[43009005] = {
		43009005,
		0,
		Lang.get(116818),
		43009,
		5,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43009006] = {
		43009006,
		0,
		Lang.get(116819),
		43009,
		6,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43009007] = {
		43009007,
		0,
		Lang.get(116820),
		43009,
		7,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[36]
		}
	},
	[43009008] = {
		43009008,
		0,
		Lang.get(116821),
		43009,
		8,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
		}
	},
	[43009009] = {
		43009009,
		0,
		Lang.get(116822),
		43009,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43009010] = {
		43009010,
		0,
		Lang.get(116823),
		43009,
		10,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43009011] = {
		43009011,
		0,
		Lang.get(116824),
		43009,
		11,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
		}
	},
	[43009012] = {
		43009012,
		0,
		Lang.get(116825),
		43009,
		12,
		107,
		{
			RTResTalkAction[20],
			RTResTalkAction[36]
		}
	},
	[43009013] = {
		43009013,
		0,
		Lang.get(116826),
		43009,
		13,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43009014] = {
		43009014,
		0,
		Lang.get(116827),
		43009,
		14,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
		}
	},
	[43010001] = {
		43010001,
		0,
		Lang.get(116828),
		43010,
		1,
		1304,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43017,
		nil,
		1,
		nil,
		1,
		nil,
		43017
	},
	[43010002] = {
		43010002,
		0,
		Lang.get(116829),
		43010,
		2,
		1304,
		{
			RTResTalkAction[37]
		},
		nil,
		nil,
		3
	},
	[43010003] = {
		43010003,
		0,
		Lang.get(116830),
		43010,
		3,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[43010004] = {
		43010004,
		0,
		Lang.get(116831),
		43010,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43010005] = {
		43010005,
		0,
		Lang.get(116832),
		43010,
		5,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43010006] = {
		43010006,
		0,
		Lang.get(116833),
		43010,
		6,
		1304,
		{
			RTResTalkAction[37],
			RTResTalkAction[9]
		}
	},
	[43010007] = {
		43010007,
		0,
		Lang.get(116834),
		43010,
		7,
		1304,
		{
			RTResTalkAction[37]
		}
	},
	[43010008] = {
		43010008,
		0,
		Lang.get(116835),
		43010,
		8,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[38]
		}
	},
	[43010009] = {
		43010009,
		0,
		Lang.get(116836),
		43010,
		9,
		1304,
		{
			RTResTalkAction[37],
			RTResTalkAction[36]
		}
	},
	[43010010] = {
		43010010,
		3,
		Lang.get(116837),
		43010,
		10,
		605,
		{
			RTResTalkAction[38]
		},
		[22] = 1
	},
	[43010011] = {
		43010011,
		0,
		Lang.get(116838),
		43010,
		11,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[43010012] = {
		43010012,
		0,
		Lang.get(116839),
		43010,
		12,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43010013] = {
		43010013,
		0,
		Lang.get(116840),
		43010,
		13,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43010014] = {
		43010014,
		0,
		Lang.get(116841),
		43010,
		14,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[9]
		}
	},
	[43010015] = {
		43010015,
		0,
		Lang.get(116842),
		43010,
		15,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43011001] = {
		43011001,
		0,
		Lang.get(116843),
		43011,
		1,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3,
		nil,
		59,
		43019,
		nil,
		1,
		nil,
		1,
		nil,
		43019
	},
	[43011002] = {
		43011002,
		0,
		Lang.get(116844),
		43011,
		2,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011003] = {
		43011003,
		0,
		Lang.get(116845),
		43011,
		3,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[43011004] = {
		43011004,
		0,
		Lang.get(116846),
		43011,
		4,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011005] = {
		43011005,
		0,
		Lang.get(116847),
		43011,
		5,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011006] = {
		43011006,
		0,
		Lang.get(116848),
		43011,
		6,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011007] = {
		43011007,
		0,
		Lang.get(116849),
		43011,
		7,
		1023,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011008] = {
		43011008,
		0,
		Lang.get(116850),
		43011,
		8,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3],
			RTResTalkAction[9]
		}
	},
	[43011009] = {
		43011009,
		0,
		Lang.get(116851),
		43011,
		9,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[36]
		}
	},
	[43011010] = {
		43011010,
		0,
		Lang.get(116852),
		43011,
		10,
		107,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[43011011] = {
		43011011,
		0,
		Lang.get(116853),
		43011,
		11,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3],
			RTResTalkAction[9]
		}
	},
	[43011012] = {
		43011012,
		0,
		Lang.get(116854),
		43011,
		12,
		1305,
		{
			RTResTalkAction[34]
		}
	},
	[43011013] = {
		43011013,
		0,
		Lang.get(116855),
		43011,
		13,
		1305,
		{
			RTResTalkAction[34]
		}
	},
	[43011014] = {
		43011014,
		0,
		Lang.get(116856),
		43011,
		14,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43011015] = {
		43011015,
		0,
		Lang.get(116857),
		43011,
		15,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43012001] = {
		43012001,
		0,
		Lang.get(116858),
		43012,
		1,
		1305,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3,
		nil,
		59,
		43021,
		nil,
		1,
		nil,
		1,
		nil,
		43021
	},
	[43012002] = {
		43012002,
		0,
		Lang.get(116859),
		43012,
		2,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[36]
		}
	},
	[43012003] = {
		43012003,
		0,
		Lang.get(116860),
		43012,
		3,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43012004] = {
		43012004,
		0,
		Lang.get(116861),
		43012,
		4,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[36]
		}
	},
	[43012005] = {
		43012005,
		0,
		Lang.get(116862),
		43012,
		5,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
		}
	},
	[43012006] = {
		43012006,
		0,
		Lang.get(116863),
		43012,
		6,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43012007] = {
		43012007,
		0,
		Lang.get(116864),
		43012,
		7,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43012008] = {
		43012008,
		0,
		Lang.get(116865),
		43012,
		8,
		1305,
		{
			RTResTalkAction[34]
		}
	},
	[43012009] = {
		43012009,
		0,
		Lang.get(116866),
		43012,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43012010] = {
		43012010,
		0,
		Lang.get(116867),
		43012,
		10,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[3]
		}
	},
	[43012011] = {
		43012011,
		0,
		Lang.get(116868),
		43012,
		11,
		1305,
		{
			RTResTalkAction[34]
		}
	},
	[43012012] = {
		43012012,
		0,
		Lang.get(116869),
		43012,
		12,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[36]
		}
	},
	[43012013] = {
		43012013,
		0,
		Lang.get(116870),
		43012,
		13,
		1305,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
		}
	},
	[43012014] = {
		43012014,
		0,
		Lang.get(116871),
		43012,
		14,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[36]
		}
	},
	[43013001] = {
		43013001,
		0,
		Lang.get(116872),
		43013,
		1,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		62,
		43023,
		nil,
		1,
		nil,
		1,
		nil,
		43023
	},
	[43013002] = {
		43013002,
		0,
		Lang.get(116873),
		43013,
		2,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43013003] = {
		43013003,
		7,
		"128",
		43013,
		3,
		1302,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		5,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[43013004] = {
		43013004,
		0,
		Lang.get(116874),
		43013,
		4,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[43013005] = {
		43013005,
		0,
		Lang.get(116875),
		43013,
		5,
		1302,
		{
			RTResTalkAction[41],
			RTResTalkAction[9]
		}
	},
	[43013006] = {
		43013006,
		0,
		Lang.get(116876),
		43013,
		6,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43013007] = {
		43013007,
		0,
		Lang.get(116877),
		43013,
		7,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43013008] = {
		43013008,
		0,
		Lang.get(116878),
		43013,
		8,
		107,
		{
			RTResTalkAction[40]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		43024,
		nil,
		1,
		nil,
		1,
		nil,
		43024
	},
	[43013009] = {
		43013009,
		0,
		Lang.get(116879),
		43013,
		9,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[43013010] = {
		43013010,
		0,
		Lang.get(116880),
		43013,
		10,
		1302,
		{
			RTResTalkAction[42],
			RTResTalkAction[9]
		}
	},
	[43013011] = {
		43013011,
		0,
		Lang.get(116881),
		43013,
		11,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43013012] = {
		43013012,
		0,
		Lang.get(116882),
		43013,
		12,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43013013] = {
		43013013,
		0,
		Lang.get(116883),
		43013,
		13,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43013014] = {
		43013014,
		0,
		Lang.get(116884),
		43013,
		14,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[43014001] = {
		43014001,
		0,
		Lang.get(116885),
		43014,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43025,
		nil,
		1,
		nil,
		1,
		nil,
		43025
	},
	[43014002] = {
		43014002,
		0,
		Lang.get(116886),
		43014,
		2,
		1023,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[43014003] = {
		43014003,
		0,
		Lang.get(116887),
		43014,
		3,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43014004] = {
		43014004,
		0,
		Lang.get(116888),
		43014,
		4,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43014005] = {
		43014005,
		0,
		Lang.get(116889),
		43014,
		5,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43014006] = {
		43014006,
		0,
		Lang.get(116890),
		43014,
		6,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43014007] = {
		43014007,
		0,
		Lang.get(116891),
		43014,
		7,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[40]
		}
	},
	[43014008] = {
		43014008,
		0,
		Lang.get(116892),
		43014,
		8,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43014009] = {
		43014009,
		0,
		Lang.get(116893),
		43014,
		9,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43014010] = {
		43014010,
		3,
		Lang.get(116894),
		43014,
		10,
		605,
		{
			RTResTalkAction[40]
		},
		[22] = 1
	},
	[43014011] = {
		43014011,
		0,
		Lang.get(116895),
		43014,
		11,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43014012] = {
		43014012,
		0,
		Lang.get(116896),
		43014,
		12,
		1303,
		{
			RTResTalkAction[15],
			RTResTalkAction[40]
		}
	},
	[43014013] = {
		43014013,
		0,
		Lang.get(116897),
		43014,
		13,
		1303,
		{
			RTResTalkAction[25]
		}
	},
	[43014014] = {
		43014014,
		0,
		Lang.get(116898),
		43014,
		14,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43014015] = {
		43014015,
		0,
		Lang.get(116899),
		43014,
		15,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[43014016] = {
		43014016,
		0,
		Lang.get(116900),
		43014,
		16,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43014017] = {
		43014017,
		0,
		Lang.get(116901),
		43014,
		17,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43014018] = {
		43014018,
		0,
		Lang.get(116902),
		43014,
		18,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43015001] = {
		43015001,
		0,
		Lang.get(116903),
		43015,
		1,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43027,
		nil,
		1,
		nil,
		1,
		nil,
		43027
	},
	[43015002] = {
		43015002,
		0,
		Lang.get(116904),
		43015,
		2,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43015003] = {
		43015003,
		0,
		Lang.get(116905),
		43015,
		3,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43015004] = {
		43015004,
		0,
		Lang.get(116906),
		43015,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43015005] = {
		43015005,
		0,
		Lang.get(116907),
		43015,
		5,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43015006] = {
		43015006,
		0,
		Lang.get(116908),
		43015,
		6,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43015007] = {
		43015007,
		0,
		Lang.get(116909),
		43015,
		7,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43015008] = {
		43015008,
		0,
		Lang.get(116910),
		43015,
		8,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43015009] = {
		43015009,
		0,
		Lang.get(116911),
		43015,
		9,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[9]
		}
	},
	[43015010] = {
		43015010,
		0,
		Lang.get(116912),
		43015,
		10,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[43015011] = {
		43015011,
		0,
		Lang.get(116913),
		43015,
		11,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43015012] = {
		43015012,
		0,
		Lang.get(116914),
		43015,
		12,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43015013] = {
		43015013,
		0,
		Lang.get(116915),
		43015,
		13,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[9]
		}
	},
	[43015014] = {
		43015014,
		0,
		Lang.get(116916),
		43015,
		14,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43016001] = {
		43016001,
		0,
		Lang.get(116917),
		43016,
		1,
		1303,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		60,
		43029,
		nil,
		1,
		nil,
		1,
		nil,
		43029
	},
	[43016002] = {
		43016002,
		0,
		Lang.get(116918),
		43016,
		2,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43016003] = {
		43016003,
		0,
		Lang.get(116919),
		43016,
		3,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43016004] = {
		43016004,
		0,
		Lang.get(116920),
		43016,
		4,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43016005] = {
		43016005,
		0,
		Lang.get(116921),
		43016,
		5,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43016006] = {
		43016006,
		0,
		Lang.get(116922),
		43016,
		6,
		605,
		{
			RTResTalkAction[43],
			RTResTalkAction[40]
		},
		[27] = 2
	},
	[43016007] = {
		43016007,
		13,
		Lang.get(116923),
		43016,
		7,
		107,
		{
			RTResTalkAction[43]
		},
		1,
		[27] = 3
	},
	[43016008] = {
		43016008,
		13,
		Lang.get(116924),
		43016,
		8,
		858,
		{
			RTResTalkAction[43]
		},
		[27] = 3
	},
	[43016009] = {
		43016009,
		13,
		Lang.get(116925),
		43016,
		9,
		107,
		{
			RTResTalkAction[43]
		},
		1,
		[27] = 3
	},
	[43016010] = {
		43016010,
		13,
		Lang.get(116926),
		43016,
		10,
		858,
		{
			RTResTalkAction[43]
		},
		[27] = 3
	},
	[43016011] = {
		43016011,
		13,
		Lang.get(116927),
		43016,
		11,
		107,
		{
			RTResTalkAction[43]
		},
		1,
		[27] = 3
	},
	[43016012] = {
		43016012,
		13,
		Lang.get(116928),
		43016,
		12,
		858,
		{
			RTResTalkAction[43]
		},
		[27] = 3
	},
	[43016013] = {
		43016013,
		13,
		Lang.get(116929),
		43016,
		13,
		107,
		{
			RTResTalkAction[43]
		},
		1,
		[27] = 3
	},
	[43017001] = {
		43017001,
		0,
		Lang.get(116930),
		43017,
		1,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		58,
		43031,
		nil,
		1,
		nil,
		1,
		nil,
		43031
	},
	[43017002] = {
		43017002,
		0,
		Lang.get(116931),
		43017,
		2,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43017003] = {
		43017003,
		0,
		Lang.get(116932),
		43017,
		3,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43017004] = {
		43017004,
		0,
		Lang.get(116933),
		43017,
		4,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[43017005] = {
		43017005,
		0,
		Lang.get(116934),
		43017,
		5,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43017006] = {
		43017006,
		0,
		Lang.get(116935),
		43017,
		6,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43017007] = {
		43017007,
		0,
		Lang.get(116936),
		43017,
		7,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[43017008] = {
		43017008,
		0,
		Lang.get(116937),
		43017,
		8,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43017009] = {
		43017009,
		0,
		Lang.get(116938),
		43017,
		9,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43017010] = {
		43017010,
		0,
		Lang.get(116939),
		43017,
		10,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43017011] = {
		43017011,
		0,
		Lang.get(116940),
		43017,
		11,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[43017012] = {
		43017012,
		0,
		Lang.get(116941),
		43017,
		12,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[17]
		}
	},
	[43017013] = {
		43017013,
		0,
		Lang.get(116942),
		43017,
		13,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43017014] = {
		43017014,
		0,
		Lang.get(116943),
		43017,
		14,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43017015] = {
		43017015,
		0,
		Lang.get(116944),
		43017,
		15,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43018001] = {
		43018001,
		3,
		Lang.get(116945),
		43018,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		58,
		43033,
		nil,
		1,
		nil,
		1,
		nil,
		43033,
		nil,
		nil,
		1
	},
	[43018002] = {
		43018002,
		0,
		Lang.get(116946),
		43018,
		2,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43018003] = {
		43018003,
		0,
		Lang.get(116947),
		43018,
		3,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43018004] = {
		43018004,
		0,
		Lang.get(116948),
		43018,
		4,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[40]
		}
	},
	[43018005] = {
		43018005,
		0,
		Lang.get(116949),
		43018,
		5,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43018006] = {
		43018006,
		0,
		Lang.get(116950),
		43018,
		6,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43018007] = {
		43018007,
		0,
		Lang.get(116951),
		43018,
		7,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43018008] = {
		43018008,
		0,
		Lang.get(116952),
		43018,
		8,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43018009] = {
		43018009,
		0,
		Lang.get(116953),
		43018,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43018010] = {
		43018010,
		0,
		Lang.get(116954),
		43018,
		10,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43018011] = {
		43018011,
		0,
		Lang.get(116955),
		43018,
		11,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43018012] = {
		43018012,
		0,
		Lang.get(116956),
		43018,
		12,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[3]
		}
	},
	[43018013] = {
		43018013,
		0,
		Lang.get(116957),
		43018,
		13,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[40]
		}
	},
	[43018014] = {
		43018014,
		0,
		Lang.get(116958),
		43018,
		14,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43019001] = {
		43019001,
		0,
		Lang.get(116959),
		43019,
		1,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		58,
		43035,
		nil,
		1,
		nil,
		1,
		nil,
		43035
	},
	[43019002] = {
		43019002,
		0,
		Lang.get(116960),
		43019,
		2,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[43019003] = {
		43019003,
		0,
		Lang.get(116961),
		43019,
		3,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		}
	},
	[43019004] = {
		43019004,
		0,
		Lang.get(116962),
		43019,
		4,
		1023,
		{
			RTResTalkAction[14]
		}
	},
	[43019005] = {
		43019005,
		0,
		Lang.get(116963),
		43019,
		5,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43019006] = {
		43019006,
		0,
		Lang.get(116964),
		43019,
		6,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43019007] = {
		43019007,
		0,
		Lang.get(116965),
		43019,
		7,
		1023,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[43019008] = {
		43019008,
		0,
		Lang.get(116966),
		43019,
		8,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[9]
		}
	},
	[43019009] = {
		43019009,
		0,
		Lang.get(116967),
		43019,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43019010] = {
		43019010,
		3,
		Lang.get(106209),
		43019,
		10,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43036,
		nil,
		1,
		nil,
		1,
		nil,
		43036,
		nil,
		nil,
		1
	},
	[43019011] = {
		43019011,
		0,
		Lang.get(116968),
		43019,
		11,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[43019012] = {
		43019012,
		0,
		Lang.get(116969),
		43019,
		12,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43019013] = {
		43019013,
		0,
		Lang.get(116970),
		43019,
		13,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[17]
		}
	},
	[43019014] = {
		43019014,
		0,
		Lang.get(116971),
		43019,
		14,
		1303,
		{
			RTResTalkAction[16],
			RTResTalkAction[3]
		}
	},
	[43019015] = {
		43019015,
		4,
		nil,
		43019,
		15,
		1303,
		{
			RTResTalkAction[16]
		},
		[29] = {
			{
				id = 43019016,
				branch_content = Lang.get(116972)
			},
			{
				id = 43019016,
				branch_content = Lang.get(116973)
			}
		}
	},
	[43019016] = {
		43019016,
		0,
		Lang.get(116974),
		43019,
		16,
		1303,
		{
			RTResTalkAction[16]
		}
	},
	[43019017] = {
		43019017,
		0,
		Lang.get(116975),
		43019,
		17,
		1302,
		{
			RTResTalkAction[39],
			RTResTalkAction[17]
		}
	},
	[43019018] = {
		43019018,
		4,
		nil,
		43019,
		18,
		1302,
		{
			RTResTalkAction[40]
		},
		[29] = {
			{
				id = 43019019,
				branch_content = Lang.get(116976)
			},
			{
				id = 43019019,
				branch_content = Lang.get(116977)
			}
		}
	},
	[43019019] = {
		43019019,
		0,
		Lang.get(116978),
		43019,
		19,
		1302,
		{
			RTResTalkAction[39]
		}
	},
	[43020001] = {
		43020001,
		0,
		Lang.get(116979),
		43020,
		1,
		1303,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		43037
	},
	[43020002] = {
		43020002,
		0,
		Lang.get(116980),
		43020,
		2,
		1303,
		nil,
		1
	},
	[43020003] = {
		43020003,
		0,
		Lang.get(116981),
		43020,
		3,
		1303,
		nil,
		1
	},
	[43020004] = {
		43020004,
		0,
		Lang.get(116982),
		43020,
		4,
		1303,
		nil,
		1
	},
	[43020005] = {
		43020005,
		0,
		Lang.get(116983),
		43020,
		5,
		1303,
		nil,
		1
	},
	[43020006] = {
		43020006,
		0,
		Lang.get(116984),
		43020,
		6,
		1303,
		nil,
		1
	},
	[43020007] = {
		43020007,
		0,
		Lang.get(116985),
		43020,
		7,
		1302,
		nil,
		1
	},
	[43020008] = {
		43020008,
		0,
		Lang.get(116986),
		43020,
		8,
		1302,
		nil,
		1
	},
	[43020009] = {
		43020009,
		4,
		nil,
		43020,
		9,
		1302,
		nil,
		1,
		[29] = {
			{
				id = 43020010,
				branch_content = Lang.get(116987)
			},
			{
				id = 43020010,
				branch_content = Lang.get(116988)
			}
		}
	},
	[43020010] = {
		43020010,
		0,
		Lang.get(116989),
		43020,
		10,
		1302,
		nil,
		1
	},
	[43020011] = {
		43020011,
		0,
		Lang.get(116990),
		43020,
		11,
		1302,
		nil,
		1
	},
	[43020012] = {
		43020012,
		0,
		Lang.get(116991),
		43020,
		12,
		1302,
		nil,
		1
	},
	[43020013] = {
		43020013,
		0,
		Lang.get(116992),
		43020,
		13,
		300,
		nil,
		1
	},
	[43020014] = {
		43020014,
		0,
		Lang.get(116993),
		43020,
		14,
		1302,
		nil,
		1
	},
	[43020015] = {
		43020015,
		0,
		Lang.get(116994),
		43020,
		15,
		1302,
		nil,
		1
	},
	[43020016] = {
		43020016,
		0,
		Lang.get(116995),
		43020,
		16,
		1302,
		nil,
		1
	},
	[43020017] = {
		43020017,
		0,
		Lang.get(116996),
		43020,
		17,
		1302,
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
