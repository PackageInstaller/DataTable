-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian39\\ResTalk.lua

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
	[2] = 287
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 287
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[7] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[8] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[10] = {
	1,
	225,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 225
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 287
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 183
}
RTResTalkAction[18] = {
	[1] = 2,
	[2] = 183
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 183
}
RTResTalkAction[20] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 1088
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[23] = {
	[1] = 2,
	[2] = 1071
}
RTResTalkAction[24] = {
	[1] = 3,
	[2] = 1091
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 1091
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 1088
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 1088
}
RTResTalkAction[29] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[30] = {
	3,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 1091
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 1088
}
RTResTalkAction[33] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[34] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 365
}
RTResTalkAction[38] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 365
}
RTResTalkAction[40] = {
	1,
	365,
	nil,
	nil,
	0
}
RTResTalkAction[41] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 1092
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 1092
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 1092
}
RTResTalkAction[47] = {
	1,
	158,
	nil,
	nil,
	0
}
RTResTalkAction[48] = {
	1,
	215,
	nil,
	nil,
	0
}

local Data = {
	[33201001] = {
		33201001,
		0,
		Lang.get(84330),
		33201,
		1,
		151,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33201,
		nil,
		nil,
		nil,
		nil,
		nil,
		33201
	},
	[33201002] = {
		33201002,
		0,
		Lang.get(84331),
		33201,
		2,
		287,
		nil,
		1
	},
	[33201003] = {
		33201003,
		0,
		Lang.get(84332),
		33201,
		3,
		151,
		nil,
		1
	},
	[33201004] = {
		33201004,
		0,
		Lang.get(84333),
		33201,
		4,
		225,
		nil,
		1
	},
	[33201005] = {
		33201005,
		0,
		Lang.get(84334),
		33201,
		5,
		225,
		nil,
		1
	},
	[33201006] = {
		33201006,
		0,
		Lang.get(84335),
		33201,
		6,
		151,
		nil,
		1
	},
	[33201007] = {
		33201007,
		0,
		Lang.get(84336),
		33201,
		7,
		287,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33201008] = {
		33201008,
		0,
		Lang.get(84337),
		33201,
		8,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33201009] = {
		33201009,
		0,
		Lang.get(85410),
		33201,
		9,
		287,
		{
			RTResTalkAction[1]
		}
	},
	[33201010] = {
		33201010,
		0,
		Lang.get(84339),
		33201,
		10,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33201011] = {
		33201011,
		0,
		Lang.get(84340),
		33201,
		11,
		287,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33201012] = {
		33201012,
		0,
		Lang.get(84341),
		33201,
		12,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33201013] = {
		33201013,
		0,
		Lang.get(84342),
		33201,
		13,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33201014] = {
		33201014,
		0,
		Lang.get(84343),
		33201,
		14,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202001] = {
		33202001,
		0,
		Lang.get(84344),
		33202,
		1,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33202,
		nil,
		nil,
		nil,
		nil,
		nil,
		33202
	},
	[33202002] = {
		33202002,
		0,
		Lang.get(84345),
		33202,
		2,
		225,
		nil,
		1
	},
	[33202003] = {
		33202003,
		0,
		Lang.get(84346),
		33202,
		3,
		287,
		nil,
		1
	},
	[33202004] = {
		33202004,
		0,
		Lang.get(84347),
		33202,
		4,
		225,
		nil,
		1
	},
	[33202005] = {
		33202005,
		0,
		Lang.get(84348),
		33202,
		5,
		287,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33202006] = {
		33202006,
		0,
		Lang.get(84349),
		33202,
		6,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202007] = {
		33202007,
		0,
		Lang.get(84350),
		33202,
		7,
		287,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202008] = {
		33202008,
		0,
		Lang.get(84351),
		33202,
		8,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202009] = {
		33202009,
		0,
		Lang.get(84352),
		33202,
		9,
		287,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202010] = {
		33202010,
		0,
		Lang.get(84353),
		33202,
		10,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[33202011] = {
		33202011,
		0,
		Lang.get(84354),
		33202,
		11,
		300,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[33202012] = {
		33202012,
		0,
		Lang.get(84355),
		33202,
		12,
		151,
		{
			RTResTalkAction[6]
		}
	},
	[33202013] = {
		33202013,
		0,
		Lang.get(84356),
		33202,
		13,
		151,
		{
			RTResTalkAction[6]
		}
	},
	[33203001] = {
		33203001,
		0,
		Lang.get(84357),
		33203,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33203,
		nil,
		nil,
		nil,
		nil,
		nil,
		33203
	},
	[33203002] = {
		33203002,
		0,
		Lang.get(84358),
		33203,
		2,
		287,
		nil,
		1
	},
	[33203003] = {
		33203003,
		0,
		Lang.get(84359),
		33203,
		3,
		220,
		nil,
		1,
		1
	},
	[33203004] = {
		33203004,
		0,
		Lang.get(84360),
		33203,
		4,
		225,
		nil,
		1,
		0
	},
	[33203005] = {
		33203005,
		4,
		nil,
		33203,
		5,
		225,
		nil,
		1,
		[29] = {
			{
				id = 33203006,
				branch_content = Lang.get(84361)
			}
		}
	},
	[33203006] = {
		33203006,
		0,
		Lang.get(84362),
		33203,
		6,
		215,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[33203007] = {
		33203007,
		0,
		Lang.get(84363),
		33203,
		7,
		220,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[33203008] = {
		33203008,
		0,
		Lang.get(84364),
		33203,
		8,
		225,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[33203009] = {
		33203009,
		0,
		Lang.get(84365),
		33203,
		9,
		287,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[33203010] = {
		33203010,
		0,
		Lang.get(84366),
		33203,
		10,
		220,
		{
			RTResTalkAction[12],
			RTResTalkAction[4]
		}
	},
	[33203011] = {
		33203011,
		0,
		Lang.get(84367),
		33203,
		11,
		225,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[33203012] = {
		33203012,
		0,
		Lang.get(84368),
		33203,
		12,
		225,
		{
			RTResTalkAction[13]
		}
	},
	[33203013] = {
		33203013,
		0,
		Lang.get(84369),
		33203,
		13,
		287,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33203014] = {
		33203014,
		0,
		Lang.get(84370),
		33203,
		14,
		287,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33203015] = {
		33203015,
		0,
		Lang.get(84371),
		33203,
		15,
		225,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33203016] = {
		33203016,
		0,
		Lang.get(84372),
		33203,
		16,
		287,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[33203017] = {
		33203017,
		0,
		Lang.get(84373),
		33203,
		17,
		215,
		{
			RTResTalkAction[16],
			RTResTalkAction[5],
			RTResTalkAction[4]
		}
	},
	[33203018] = {
		33203018,
		0,
		Lang.get(84374),
		33203,
		18,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[33204001] = {
		33204001,
		0,
		Lang.get(84375),
		33204,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33204,
		nil,
		nil,
		nil,
		nil,
		nil,
		33204
	},
	[33204002] = {
		33204002,
		0,
		Lang.get(84376),
		33204,
		2,
		225,
		nil,
		1
	},
	[33204003] = {
		33204003,
		0,
		Lang.get(84377),
		33204,
		3,
		220,
		nil,
		1
	},
	[33204004] = {
		33204004,
		0,
		Lang.get(84378),
		33204,
		4,
		225,
		nil,
		1
	},
	[33205001] = {
		33205001,
		0,
		Lang.get(84379),
		33205,
		1,
		183,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33205,
		nil,
		nil,
		nil,
		nil,
		nil,
		33205
	},
	[33205002] = {
		33205002,
		0,
		Lang.get(84380),
		33205,
		2,
		287,
		nil,
		1
	},
	[33205003] = {
		33205003,
		0,
		Lang.get(84381),
		33205,
		3,
		183,
		nil,
		1
	},
	[33205004] = {
		33205004,
		0,
		Lang.get(84382),
		33205,
		4,
		287,
		nil,
		1
	},
	[33205005] = {
		33205005,
		0,
		Lang.get(84383),
		33205,
		5,
		183,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[33205006] = {
		33205006,
		0,
		Lang.get(84384),
		33205,
		6,
		183,
		{
			RTResTalkAction[17]
		}
	},
	[33205007] = {
		33205007,
		0,
		Lang.get(84385),
		33205,
		7,
		287,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205008] = {
		33205008,
		0,
		Lang.get(84386),
		33205,
		8,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205009] = {
		33205009,
		0,
		Lang.get(84387),
		33205,
		9,
		287,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205010] = {
		33205010,
		0,
		Lang.get(84388),
		33205,
		10,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205011] = {
		33205011,
		0,
		Lang.get(84389),
		33205,
		11,
		287,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205012] = {
		33205012,
		0,
		Lang.get(84390),
		33205,
		12,
		287,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205013] = {
		33205013,
		0,
		Lang.get(84391),
		33205,
		13,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205014] = {
		33205014,
		0,
		Lang.get(84392),
		33205,
		14,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205015] = {
		33205015,
		0,
		Lang.get(84393),
		33205,
		15,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205016] = {
		33205016,
		0,
		Lang.get(84394),
		33205,
		16,
		287,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205017] = {
		33205017,
		0,
		Lang.get(84395),
		33205,
		17,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205018] = {
		33205018,
		0,
		Lang.get(84396),
		33205,
		18,
		183,
		{
			RTResTalkAction[18],
			RTResTalkAction[15]
		}
	},
	[33205019] = {
		33205019,
		0,
		Lang.get(84397),
		33205,
		19,
		287,
		{
			RTResTalkAction[1],
			RTResTalkAction[19]
		}
	},
	[33206001] = {
		33206001,
		0,
		Lang.get(84398),
		33206,
		1,
		1088,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33206,
		nil,
		nil,
		nil,
		nil,
		nil,
		33206
	},
	[33206002] = {
		33206002,
		0,
		Lang.get(84399),
		33206,
		2,
		112,
		nil,
		1,
		1
	},
	[33206003] = {
		33206003,
		0,
		Lang.get(84400),
		33206,
		3,
		1088,
		nil,
		1,
		0
	},
	[33206004] = {
		33206004,
		0,
		Lang.get(84401),
		33206,
		4,
		112,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[33206005] = {
		33206005,
		0,
		Lang.get(84402),
		33206,
		5,
		1088,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[33206006] = {
		33206006,
		0,
		Lang.get(84403),
		33206,
		6,
		112,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[33206007] = {
		33206007,
		0,
		Lang.get(84404),
		33206,
		7,
		1088,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[33206008] = {
		33206008,
		0,
		Lang.get(84405),
		33206,
		8,
		112,
		{
			RTResTalkAction[20],
			RTResTalkAction[21]
		}
	},
	[33207001] = {
		33207001,
		0,
		Lang.get(84406),
		33207,
		1,
		1091,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33207,
		nil,
		nil,
		nil,
		nil,
		nil,
		33207
	},
	[33207002] = {
		33207002,
		0,
		Lang.get(84407),
		33207,
		2,
		1071,
		nil,
		1
	},
	[33207003] = {
		33207003,
		0,
		Lang.get(84408),
		33207,
		3,
		1091,
		nil,
		1
	},
	[33207004] = {
		33207004,
		0,
		Lang.get(84409),
		33207,
		4,
		1071,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[33207005] = {
		33207005,
		0,
		Lang.get(84410),
		33207,
		5,
		1091,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[33207006] = {
		33207006,
		0,
		Lang.get(84411),
		33207,
		6,
		1071,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[33207007] = {
		33207007,
		0,
		Lang.get(84412),
		33207,
		7,
		1091,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[33207008] = {
		33207008,
		0,
		Lang.get(84413),
		33207,
		8,
		112,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		60,
		33208,
		nil,
		nil,
		nil,
		nil,
		nil,
		33208
	},
	[33207009] = {
		33207009,
		0,
		Lang.get(84414),
		33207,
		9,
		1071,
		nil,
		1
	},
	[33207010] = {
		33207010,
		0,
		Lang.get(84415),
		33207,
		10,
		1091,
		nil,
		1
	},
	[33207011] = {
		33207011,
		0,
		Lang.get(84416),
		33207,
		11,
		1088,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33207012] = {
		33207012,
		0,
		Lang.get(84417),
		33207,
		12,
		112,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[33209001] = {
		33209001,
		0,
		Lang.get(84418),
		33209,
		1,
		1091,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		33208,
		nil,
		nil,
		nil,
		nil,
		nil,
		33208
	},
	[33209002] = {
		33209002,
		0,
		Lang.get(84419),
		33209,
		2,
		1091,
		nil,
		1
	},
	[33209003] = {
		33209003,
		5,
		Lang.get(84420),
		33209,
		3,
		1091,
		nil,
		1
	},
	[33209004] = {
		33209004,
		0,
		Lang.get(84421),
		33209,
		4,
		1088,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[33209005] = {
		33209005,
		0,
		Lang.get(84422),
		33209,
		5,
		112,
		{
			RTResTalkAction[28],
			RTResTalkAction[30]
		}
	},
	[33209006] = {
		33209006,
		5,
		Lang.get(84423),
		33209,
		6,
		1091,
		{
			RTResTalkAction[31],
			RTResTalkAction[32],
			RTResTalkAction[33]
		}
	},
	[33209007] = {
		33209007,
		5,
		Lang.get(84424),
		33209,
		7,
		1091,
		{
			RTResTalkAction[31]
		}
	},
	[33209008] = {
		33209008,
		0,
		Lang.get(84425),
		33209,
		8,
		112,
		{
			RTResTalkAction[34],
			RTResTalkAction[26]
		}
	},
	[33209009] = {
		33209009,
		0,
		Lang.get(84426),
		33209,
		9,
		112,
		{
			RTResTalkAction[34]
		}
	},
	[33210001] = {
		33210001,
		0,
		Lang.get(84427),
		33210,
		1,
		1091,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33210,
		nil,
		nil,
		nil,
		nil,
		nil,
		33210
	},
	[33210002] = {
		33210002,
		0,
		Lang.get(84428),
		33210,
		2,
		1088,
		nil,
		1
	},
	[33210003] = {
		33210003,
		5,
		Lang.get(84429),
		33210,
		3,
		1091,
		nil,
		1
	},
	[33210004] = {
		33210004,
		0,
		Lang.get(84430),
		33210,
		4,
		112,
		nil,
		1,
		1
	},
	[33210005] = {
		33210005,
		0,
		Lang.get(84431),
		33210,
		5,
		1071,
		{
			RTResTalkAction[22]
		},
		nil,
		0,
		3
	},
	[33210006] = {
		33210006,
		0,
		Lang.get(84432),
		33210,
		6,
		1071,
		{
			RTResTalkAction[22]
		}
	},
	[33210007] = {
		33210007,
		0,
		Lang.get(84433),
		33210,
		7,
		112,
		{
			RTResTalkAction[23],
			RTResTalkAction[29]
		}
	},
	[33210008] = {
		33210008,
		0,
		Lang.get(84434),
		33210,
		8,
		1071,
		{
			RTResTalkAction[23],
			RTResTalkAction[29]
		}
	},
	[33210009] = {
		33210009,
		0,
		Lang.get(84435),
		33210,
		9,
		112,
		{
			RTResTalkAction[23],
			RTResTalkAction[29]
		}
	},
	[33210010] = {
		33210010,
		0,
		Lang.get(84436),
		33210,
		10,
		112,
		{
			RTResTalkAction[23],
			RTResTalkAction[29]
		}
	},
	[33210011] = {
		33210011,
		0,
		Lang.get(84437),
		33210,
		11,
		1088,
		{
			RTResTalkAction[27],
			RTResTalkAction[25],
			RTResTalkAction[33]
		}
	},
	[33210012] = {
		33210012,
		0,
		Lang.get(84438),
		33210,
		12,
		112,
		{
			RTResTalkAction[35],
			RTResTalkAction[32]
		}
	},
	[33210013] = {
		33210013,
		0,
		Lang.get(84439),
		33210,
		13,
		1071,
		{
			RTResTalkAction[22],
			RTResTalkAction[33]
		}
	},
	[33210014] = {
		33210014,
		0,
		Lang.get(84440),
		33210,
		14,
		112,
		{
			RTResTalkAction[35],
			RTResTalkAction[25]
		}
	},
	[33211001] = {
		33211001,
		0,
		Lang.get(84441),
		33211,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		33211,
		nil,
		nil,
		nil,
		nil,
		nil,
		33211
	},
	[33211002] = {
		33211002,
		0,
		Lang.get(84442),
		33211,
		2,
		215,
		nil,
		1,
		2
	},
	[33211003] = {
		33211003,
		0,
		Lang.get(84443),
		33211,
		3,
		225,
		{
			RTResTalkAction[13]
		},
		nil,
		0,
		3
	},
	[33211004] = {
		33211004,
		0,
		Lang.get(84444),
		33211,
		4,
		220,
		{
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[33211005] = {
		33211005,
		0,
		Lang.get(85411),
		33211,
		5,
		225,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[33211006] = {
		33211006,
		0,
		nil,
		33211,
		6,
		376,
		{
			RTResTalkAction[36],
			RTResTalkAction[5]
		},
		[27] = 2
	},
	[33211007] = {
		33211007,
		13,
		Lang.get(84446),
		33211,
		7,
		365,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		},
		[27] = 3
	},
	[33211008] = {
		33211008,
		0,
		Lang.get(84447),
		33211,
		8,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[33211009] = {
		33211009,
		0,
		Lang.get(84448),
		33211,
		9,
		225,
		{
			RTResTalkAction[13]
		}
	},
	[33211010] = {
		33211010,
		13,
		Lang.get(84449),
		33211,
		10,
		365,
		{
			RTResTalkAction[37],
			RTResTalkAction[5]
		},
		[27] = 3
	},
	[33211011] = {
		33211011,
		0,
		Lang.get(84450),
		33211,
		11,
		220,
		{
			RTResTalkAction[8],
			RTResTalkAction[39]
		}
	},
	[33211012] = {
		33211012,
		13,
		Lang.get(84451),
		33211,
		12,
		365,
		{
			RTResTalkAction[40],
			RTResTalkAction[11]
		},
		[27] = 3
	},
	[33211013] = {
		33211013,
		0,
		Lang.get(85412),
		33211,
		13,
		300,
		{
			RTResTalkAction[39]
		}
	},
	[33211014] = {
		33211014,
		4,
		nil,
		33211,
		14,
		300,
		[29] = {
			{
				id = 33211015,
				branch_content = Lang.get(84452)
			},
			{
				id = 33211015,
				branch_content = Lang.get(85413)
			}
		}
	},
	[33211015] = {
		33211015,
		0,
		Lang.get(84454),
		33211,
		15,
		225,
		{
			RTResTalkAction[13]
		}
	},
	[33213001] = {
		33213001,
		0,
		Lang.get(84455),
		33213,
		1,
		225,
		nil,
		1,
		0,
		nil,
		nil,
		62,
		33213,
		nil,
		nil,
		nil,
		nil,
		nil,
		33213
	},
	[33213002] = {
		33213002,
		0,
		Lang.get(84456),
		33213,
		2,
		1091,
		nil,
		1,
		0
	},
	[33213003] = {
		33213003,
		0,
		Lang.get(84457),
		33213,
		3,
		220,
		{
			RTResTalkAction[41],
			RTResTalkAction[24]
		},
		nil,
		nil,
		3
	},
	[33213004] = {
		33213004,
		0,
		Lang.get(84458),
		33213,
		4,
		1091,
		{
			RTResTalkAction[41],
			RTResTalkAction[24]
		}
	},
	[33213005] = {
		33213005,
		0,
		Lang.get(84459),
		33213,
		5,
		225,
		{
			RTResTalkAction[14],
			RTResTalkAction[24],
			RTResTalkAction[11]
		}
	},
	[33214001] = {
		33214001,
		0,
		Lang.get(84460),
		33214,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33214,
		nil,
		nil,
		nil,
		nil,
		nil,
		33214
	},
	[33214002] = {
		33214002,
		0,
		Lang.get(84461),
		33214,
		2,
		1091,
		nil,
		1
	},
	[33214003] = {
		33214003,
		0,
		Lang.get(84462),
		33214,
		3,
		158,
		nil,
		1
	},
	[33214004] = {
		33214004,
		0,
		Lang.get(84463),
		33214,
		4,
		1091,
		nil,
		1
	},
	[33214005] = {
		33214005,
		0,
		Lang.get(84464),
		33214,
		5,
		225,
		nil,
		1
	},
	[33214006] = {
		33214006,
		0,
		Lang.get(84465),
		33214,
		6,
		1091,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[33214007] = {
		33214007,
		0,
		Lang.get(84466),
		33214,
		7,
		1091,
		{
			RTResTalkAction[31]
		}
	},
	[33214008] = {
		33214008,
		0,
		Lang.get(84467),
		33214,
		8,
		220,
		{
			RTResTalkAction[12],
			RTResTalkAction[26]
		}
	},
	[33214009] = {
		33214009,
		0,
		Lang.get(84468),
		33214,
		9,
		1091,
		{
			RTResTalkAction[31],
			RTResTalkAction[11]
		}
	},
	[33214010] = {
		33214010,
		0,
		Lang.get(84469),
		33214,
		10,
		1091,
		{
			RTResTalkAction[31]
		}
	},
	[33214011] = {
		33214011,
		0,
		Lang.get(84470),
		33214,
		11,
		1091,
		{
			RTResTalkAction[31]
		}
	},
	[33214012] = {
		33214012,
		0,
		Lang.get(84471),
		33214,
		12,
		158,
		{
			RTResTalkAction[42],
			RTResTalkAction[26]
		}
	},
	[33214013] = {
		33214013,
		0,
		Lang.get(84472),
		33214,
		13,
		1091,
		{
			RTResTalkAction[31],
			RTResTalkAction[43]
		}
	},
	[33214014] = {
		33214014,
		0,
		Lang.get(84473),
		33214,
		14,
		1091,
		{
			RTResTalkAction[31]
		}
	},
	[33215001] = {
		33215001,
		0,
		Lang.get(84474),
		33215,
		1,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33215,
		nil,
		nil,
		nil,
		nil,
		nil,
		33215
	},
	[33215002] = {
		33215002,
		0,
		Lang.get(84475),
		33215,
		2,
		158,
		nil,
		1
	},
	[33215003] = {
		33215003,
		0,
		Lang.get(84476),
		33215,
		3,
		215,
		nil,
		1
	},
	[33215004] = {
		33215004,
		5,
		Lang.get(84429),
		33215,
		4,
		1092,
		nil,
		1
	},
	[33215005] = {
		33215005,
		0,
		Lang.get(84477),
		33215,
		5,
		220,
		nil,
		1
	},
	[33215006] = {
		33215006,
		0,
		Lang.get(84478),
		33215,
		6,
		215,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[33215007] = {
		33215007,
		0,
		Lang.get(84479),
		33215,
		7,
		1092,
		{
			RTResTalkAction[44],
			RTResTalkAction[9]
		}
	},
	[33215008] = {
		33215008,
		0,
		Lang.get(84480),
		33215,
		8,
		1092,
		{
			RTResTalkAction[44]
		}
	},
	[33215009] = {
		33215009,
		0,
		Lang.get(85414),
		33215,
		9,
		1092,
		{
			RTResTalkAction[44]
		}
	},
	[33215010] = {
		33215010,
		5,
		Lang.get(85415),
		33215,
		10,
		1091,
		{
			RTResTalkAction[45],
			RTResTalkAction[24]
		}
	},
	[33215011] = {
		33215011,
		0,
		Lang.get(84483),
		33215,
		11,
		1092,
		{
			RTResTalkAction[45],
			RTResTalkAction[24]
		}
	},
	[33215012] = {
		33215012,
		0,
		Lang.get(84484),
		33215,
		12,
		225,
		{
			RTResTalkAction[13],
			RTResTalkAction[46],
			RTResTalkAction[26]
		}
	},
	[33215013] = {
		33215013,
		0,
		Lang.get(84485),
		33215,
		13,
		158,
		{
			RTResTalkAction[42],
			RTResTalkAction[5]
		}
	},
	[33216001] = {
		33216001,
		0,
		Lang.get(84486),
		33216,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33216,
		nil,
		nil,
		nil,
		nil,
		nil,
		33216
	},
	[33216002] = {
		33216002,
		0,
		Lang.get(84487),
		33216,
		2,
		158,
		nil,
		1
	},
	[33216003] = {
		33216003,
		0,
		Lang.get(84488),
		33216,
		3,
		220,
		nil,
		1,
		1
	},
	[33216004] = {
		33216004,
		0,
		Lang.get(84489),
		33216,
		4,
		112,
		nil,
		1,
		1
	},
	[33216005] = {
		33216005,
		0,
		Lang.get(84490),
		33216,
		5,
		112,
		nil,
		1,
		1
	},
	[33216006] = {
		33216006,
		0,
		Lang.get(84491),
		33216,
		6,
		225,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[33216007] = {
		33216007,
		0,
		Lang.get(84492),
		33216,
		7,
		112,
		{
			RTResTalkAction[35],
			RTResTalkAction[5]
		}
	},
	[33216008] = {
		33216008,
		0,
		Lang.get(84493),
		33216,
		8,
		220,
		{
			RTResTalkAction[12],
			RTResTalkAction[33]
		}
	},
	[33216009] = {
		33216009,
		0,
		Lang.get(84494),
		33216,
		9,
		225,
		{
			RTResTalkAction[13],
			RTResTalkAction[11]
		}
	},
	[33217001] = {
		33217001,
		0,
		Lang.get(84495),
		33217,
		1,
		158,
		nil,
		1,
		0,
		nil,
		nil,
		63,
		33217,
		nil,
		nil,
		nil,
		nil,
		nil,
		33217
	},
	[33217002] = {
		33217002,
		0,
		Lang.get(84496),
		33217,
		2,
		215,
		nil,
		1,
		2
	},
	[33217003] = {
		33217003,
		0,
		Lang.get(84497),
		33217,
		3,
		220,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[33217004] = {
		33217004,
		0,
		Lang.get(84498),
		33217,
		4,
		158,
		{
			RTResTalkAction[42],
			RTResTalkAction[11]
		}
	},
	[33217005] = {
		33217005,
		0,
		Lang.get(84499),
		33217,
		5,
		158,
		{
			RTResTalkAction[42]
		}
	},
	[33218001] = {
		33218001,
		0,
		Lang.get(84500),
		33218,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33217,
		nil,
		nil,
		nil,
		nil,
		nil,
		33217
	},
	[33218002] = {
		33218002,
		0,
		Lang.get(84501),
		33218,
		2,
		215,
		nil,
		1
	},
	[33218003] = {
		33218003,
		0,
		Lang.get(84502),
		33218,
		3,
		220,
		nil,
		1
	},
	[33219001] = {
		33219001,
		0,
		Lang.get(84503),
		33219,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		33218,
		nil,
		nil,
		nil,
		nil,
		nil,
		33216
	},
	[33219002] = {
		33219002,
		0,
		Lang.get(84504),
		33219,
		2,
		220,
		nil,
		1
	},
	[33219003] = {
		33219003,
		0,
		Lang.get(84505),
		33219,
		3,
		112,
		nil,
		1
	},
	[33219004] = {
		33219004,
		0,
		Lang.get(84506),
		33219,
		4,
		112,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[33219005] = {
		33219005,
		0,
		Lang.get(84507),
		33219,
		5,
		158,
		{
			RTResTalkAction[47],
			RTResTalkAction[33]
		}
	},
	[33219006] = {
		33219006,
		0,
		Lang.get(84508),
		33219,
		6,
		112,
		{
			RTResTalkAction[34],
			RTResTalkAction[43]
		}
	},
	[33219007] = {
		33219007,
		0,
		Lang.get(84509),
		33219,
		7,
		215,
		{
			RTResTalkAction[48],
			RTResTalkAction[33]
		}
	},
	[33219008] = {
		33219008,
		0,
		Lang.get(84510),
		33219,
		8,
		112,
		{
			RTResTalkAction[34],
			RTResTalkAction[9]
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
