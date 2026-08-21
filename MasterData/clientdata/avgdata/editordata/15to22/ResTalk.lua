-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\15to22\\ResTalk.lua

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
	[1] = 1,
	[2] = 133
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 360
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 360
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 125
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 164
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 125
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 164
}
RTResTalkAction[21] = {
	1,
	112,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 364
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 538
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 538
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 365
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 365
}
RTResTalkAction[29] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 354
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 354
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 354
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 108
}
RTResTalkAction[34] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 108
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 588
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 588
}
RTResTalkAction[38] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 589
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		3
	}
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 589
}
RTResTalkAction[42] = {
	1,
	107,
	{
		1
	},
	nil,
	5
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
	107,
	{
		1
	},
	nil,
	6
}
RTResTalkAction[45] = {
	[1] = 2,
	[2] = 108
}
RTResTalkAction[46] = {
	[1] = 3,
	[2] = 637
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 637
}
RTResTalkAction[48] = {
	2,
	170,
	nil,
	nil,
	8
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[50] = {
	2,
	170,
	nil,
	nil,
	3
}
RTResTalkAction[51] = {
	[1] = 2,
	[2] = 170
}
RTResTalkAction[52] = {
	2,
	170,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[53] = {
	2,
	170,
	nil,
	nil,
	0
}
RTResTalkAction[54] = {
	2,
	170,
	nil,
	nil,
	7
}
RTResTalkAction[55] = {
	2,
	170,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 599
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 170
}
RTResTalkAction[58] = {
	[1] = 0,
	[2] = 599
}
RTResTalkAction[59] = {
	2,
	170,
	{
		10011
	},
	nil,
	1
}

local Data = {
	[3200001] = {
		3200001,
		0,
		Lang.get(38008),
		3200,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		3200,
		0.5,
		1,
		1,
		nil,
		3200
	},
	[3200002] = {
		3200002,
		0,
		Lang.get(38009),
		3200,
		2,
		112,
		nil,
		1
	},
	[3200003] = {
		3200003,
		0,
		Lang.get(38010),
		3200,
		3,
		133,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[3200004] = {
		3200004,
		0,
		Lang.get(38011),
		3200,
		4,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[3200005] = {
		3200005,
		0,
		Lang.get(38012),
		3200,
		5,
		151,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[3200006] = {
		3200006,
		0,
		Lang.get(38013),
		3200,
		6,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[6]
		}
	},
	[3200007] = {
		3200007,
		0,
		Lang.get(38014),
		3200,
		7,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3200008] = {
		3200008,
		0,
		Lang.get(38015),
		3200,
		8,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3200009] = {
		3200009,
		0,
		Lang.get(38016),
		3200,
		9,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[3200010] = {
		3200010,
		0,
		Lang.get(38017),
		3200,
		10,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3200011] = {
		3200011,
		0,
		Lang.get(38018),
		3200,
		11,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3200012] = {
		3200012,
		0,
		Lang.get(38019),
		3200,
		12,
		141,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[3200013] = {
		3200013,
		0,
		Lang.get(38020),
		3200,
		13,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[3200014] = {
		3200014,
		0,
		Lang.get(38021),
		3200,
		14,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[3200015] = {
		3200015,
		0,
		Lang.get(38022),
		3200,
		15,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[3200016] = {
		3200016,
		0,
		Lang.get(38023),
		3200,
		16,
		151,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[3200017] = {
		3200017,
		0,
		Lang.get(38024),
		3200,
		17,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[6]
		}
	},
	[3200018] = {
		3200018,
		0,
		Lang.get(38025),
		3200,
		18,
		300,
		{
			RTResTalkAction[5]
		}
	},
	[3200019] = {
		3200019,
		0,
		Lang.get(38026),
		3200,
		19,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3200020] = {
		3200020,
		13,
		nil,
		3200,
		20,
		376,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		},
		[19] = 220,
		[26] = 2
	},
	[3200021] = {
		3200021,
		13,
		Lang.get(32506),
		3200,
		21,
		360,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		[26] = 3
	},
	[3200022] = {
		3200022,
		13,
		Lang.get(35623),
		3200,
		22,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3
	},
	[3200023] = {
		3200023,
		4,
		nil,
		3200,
		23,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3,
		[27] = {
			{
				id = 3200024,
				branch_content = Lang.get(42504)
			}
		}
	},
	[3200024] = {
		3200024,
		13,
		Lang.get(38028),
		3200,
		24,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3
	},
	[3200025] = {
		3200025,
		0,
		Lang.get(38029),
		3200,
		25,
		112,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		},
		[19] = -1
	},
	[3200026] = {
		3200026,
		0,
		Lang.get(38030),
		3200,
		26,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[5]
		}
	},
	[3200027] = {
		3200027,
		0,
		Lang.get(38031),
		3200,
		27,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[3200028] = {
		3200028,
		0,
		Lang.get(38032),
		3200,
		28,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3201001] = {
		3201001,
		0,
		Lang.get(38033),
		3201,
		1,
		164,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		3201,
		0.5,
		1,
		1,
		nil,
		3201
	},
	[3201002] = {
		3201002,
		0,
		Lang.get(38034),
		3201,
		2,
		123,
		nil,
		1
	},
	[3201003] = {
		3201003,
		0,
		Lang.get(38035),
		3201,
		3,
		125,
		nil,
		1,
		nil,
		3
	},
	[3201004] = {
		3201004,
		0,
		Lang.get(38036),
		3201,
		4,
		123,
		{
			RTResTalkAction[15]
		}
	},
	[3201005] = {
		3201005,
		0,
		Lang.get(38037),
		3201,
		5,
		125,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[3201006] = {
		3201006,
		0,
		Lang.get(38038),
		3201,
		6,
		164,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[3201007] = {
		3201007,
		0,
		Lang.get(46206),
		3201,
		7,
		123,
		{
			RTResTalkAction[15],
			RTResTalkAction[20]
		}
	},
	[3201008] = {
		3201008,
		0,
		Lang.get(38039),
		3201,
		8,
		164,
		{
			RTResTalkAction[18],
			RTResTalkAction[17]
		}
	},
	[3201009] = {
		3201009,
		0,
		Lang.get(38040),
		3201,
		9,
		164,
		{
			RTResTalkAction[18]
		}
	},
	[3201010] = {
		3201010,
		0,
		Lang.get(38041),
		3201,
		10,
		125,
		{
			RTResTalkAction[16],
			RTResTalkAction[20]
		}
	},
	[3203001] = {
		3203001,
		0,
		Lang.get(40568),
		3203,
		1,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		63,
		3204,
		0.5,
		1,
		1,
		nil,
		3204
	},
	[3203002] = {
		3203002,
		0,
		Lang.get(38047),
		3203,
		2,
		112,
		nil,
		1,
		3
	},
	[3203003] = {
		3203003,
		3,
		Lang.get(38048),
		3203,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		3205,
		0.5,
		1,
		1,
		nil,
		3205,
		nil,
		nil,
		1
	},
	[3203004] = {
		3203004,
		0,
		Lang.get(38049),
		3203,
		4,
		112,
		nil,
		1
	},
	[3203005] = {
		3203005,
		0,
		Lang.get(38050),
		3203,
		5,
		112,
		nil,
		1
	},
	[3203006] = {
		3203006,
		0,
		Lang.get(38051),
		3203,
		6,
		112,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[3203007] = {
		3203007,
		13,
		nil,
		3203,
		7,
		376,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		},
		[19] = 220,
		[26] = 2
	},
	[3203008] = {
		3203008,
		13,
		Lang.get(32506),
		3203,
		8,
		360,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		[26] = 3
	},
	[3203009] = {
		3203009,
		13,
		Lang.get(38052),
		3203,
		9,
		112,
		{
			RTResTalkAction[12]
		},
		1,
		[26] = 3
	},
	[3203010] = {
		3203010,
		4,
		nil,
		3203,
		10,
		112,
		nil,
		1,
		[26] = 3,
		[27] = {
			{
				id = 3203011,
				branch_content = Lang.get(42505)
			}
		}
	},
	[3203011] = {
		3203011,
		13,
		Lang.get(38054),
		3203,
		11,
		112,
		nil,
		1,
		[26] = 3
	},
	[3203012] = {
		3203012,
		13,
		Lang.get(38055),
		3203,
		12,
		364,
		{
			RTResTalkAction[22]
		},
		[26] = 3
	},
	[3204001] = {
		3204001,
		0,
		Lang.get(38056),
		3204,
		1,
		125,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		3206,
		0.5,
		1,
		1,
		nil,
		3206,
		-1
	},
	[3204002] = {
		3204002,
		0,
		Lang.get(38057),
		3204,
		2,
		354,
		nil,
		1
	},
	[3204003] = {
		3204003,
		0,
		Lang.get(38058),
		3204,
		3,
		125,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[3204004] = {
		3204004,
		0,
		"……",
		3204,
		4,
		354,
		{
			RTResTalkAction[19]
		},
		1
	},
	[3204005] = {
		3204005,
		0,
		Lang.get(38059),
		3204,
		5,
		125,
		{
			RTResTalkAction[16]
		}
	},
	[3204006] = {
		3204006,
		0,
		Lang.get(38060),
		3204,
		6,
		354,
		{
			RTResTalkAction[19]
		},
		1,
		nil,
		nil,
		nil,
		66,
		3207,
		0.5,
		1,
		1,
		nil,
		3207
	},
	[3204007] = {
		3204007,
		0,
		Lang.get(38061),
		3204,
		7,
		125,
		nil,
		1
	},
	[3204008] = {
		3204008,
		0,
		Lang.get(38062),
		3204,
		8,
		112,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[3204009] = {
		3204009,
		0,
		Lang.get(38063),
		3204,
		9,
		125,
		{
			RTResTalkAction[16],
			RTResTalkAction[5]
		}
	},
	[3205001] = {
		3205001,
		0,
		Lang.get(38064),
		3205,
		1,
		125,
		{
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		57,
		3208,
		0.5,
		1,
		1,
		nil,
		3208
	},
	[3205002] = {
		3205002,
		0,
		Lang.get(46207),
		3205,
		2,
		538,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[3205003] = {
		3205003,
		0,
		Lang.get(38065),
		3205,
		3,
		354,
		{
			RTResTalkAction[26]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		3209,
		0.5,
		1,
		1,
		nil,
		3209
	},
	[3205004] = {
		3205004,
		0,
		Lang.get(38066),
		3205,
		4,
		112,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[3205005] = {
		3205005,
		0,
		Lang.get(38067),
		3205,
		5,
		354,
		{
			RTResTalkAction[5]
		},
		1
	},
	[3205006] = {
		3205006,
		0,
		Lang.get(38068),
		3205,
		6,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3205007] = {
		3205007,
		0,
		Lang.get(38069),
		3205,
		7,
		354,
		{
			RTResTalkAction[5]
		},
		1
	},
	[3205008] = {
		3205008,
		0,
		Lang.get(38070),
		3205,
		8,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3205009] = {
		3205009,
		13,
		Lang.get(38071),
		3205,
		9,
		360,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		},
		[19] = 220,
		[26] = 1
	},
	[3205010] = {
		3205010,
		13,
		Lang.get(38072),
		3205,
		10,
		300,
		{
			RTResTalkAction[11]
		},
		[26] = 3
	},
	[3205011] = {
		3205011,
		13,
		Lang.get(38073),
		3205,
		11,
		365,
		{
			RTResTalkAction[27]
		},
		[26] = 3
	},
	[3205012] = {
		3205012,
		2,
		Lang.get(38074),
		3205,
		12,
		300,
		{
			RTResTalkAction[28]
		},
		[26] = 3
	},
	[3205013] = {
		3205013,
		13,
		Lang.get(38075),
		3205,
		13,
		300,
		[26] = 3
	},
	[3205014] = {
		3205014,
		0,
		Lang.get(38076),
		3205,
		14,
		112,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		3210,
		0.5,
		1,
		1,
		nil,
		3210,
		-1
	},
	[3205015] = {
		3205015,
		0,
		Lang.get(38077),
		3205,
		15,
		300
	},
	[3205016] = {
		3205016,
		0,
		Lang.get(38078),
		3205,
		16,
		354,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		3211,
		0.5,
		1,
		1,
		nil,
		3211
	},
	[3205017] = {
		3205017,
		0,
		Lang.get(38079),
		3205,
		17,
		112,
		nil,
		1
	},
	[3205018] = {
		3205018,
		0,
		Lang.get(38080),
		3205,
		18,
		354,
		nil,
		1
	},
	[3206001] = {
		3206001,
		0,
		Lang.get(38081),
		3206,
		1,
		354,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		3212,
		0.5,
		1,
		1,
		nil,
		3212
	},
	[3206002] = {
		3206002,
		0,
		Lang.get(38082),
		3206,
		2,
		112,
		nil,
		1,
		[18] = 3280
	},
	[3206003] = {
		3206003,
		0,
		Lang.get(38083),
		3206,
		3,
		112,
		nil,
		1,
		[18] = 3281
	},
	[3206004] = {
		3206004,
		0,
		Lang.get(38084),
		3206,
		4,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[3206005] = {
		3206005,
		0,
		Lang.get(38085),
		3206,
		5,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3206006] = {
		3206006,
		0,
		Lang.get(38086),
		3206,
		6,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3206007] = {
		3206007,
		0,
		Lang.get(38087),
		3206,
		7,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3206008] = {
		3206008,
		0,
		Lang.get(38088),
		3206,
		8,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3206009] = {
		3206009,
		0,
		Lang.get(38089),
		3206,
		9,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207001] = {
		3207001,
		0,
		Lang.get(38090),
		3207,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		3213,
		0.5,
		1,
		1,
		nil,
		3213
	},
	[3207002] = {
		3207002,
		0,
		Lang.get(38091),
		3207,
		2,
		354,
		nil,
		1
	},
	[3207003] = {
		3207003,
		0,
		Lang.get(38092),
		3207,
		3,
		354,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[3207004] = {
		3207004,
		0,
		Lang.get(38093),
		3207,
		4,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207005] = {
		3207005,
		0,
		Lang.get(38094),
		3207,
		5,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207006] = {
		3207006,
		0,
		Lang.get(38095),
		3207,
		6,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207007] = {
		3207007,
		4,
		nil,
		3207,
		7,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		},
		[27] = {
			{
				id = 3207008,
				branch_content = Lang.get(42506)
			}
		}
	},
	[3207008] = {
		3207008,
		0,
		Lang.get(38097),
		3207,
		8,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207009] = {
		3207009,
		0,
		Lang.get(38098),
		3207,
		9,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3207010] = {
		3207010,
		13,
		nil,
		3207,
		10,
		376,
		{
			RTResTalkAction[9],
			RTResTalkAction[5],
			RTResTalkAction[32]
		},
		[19] = 220,
		[26] = 1
	},
	[3207011] = {
		3207011,
		13,
		Lang.get(38099),
		3207,
		11,
		360,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		[26] = 3
	},
	[3207012] = {
		3207012,
		13,
		Lang.get(38100),
		3207,
		12,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3
	},
	[3207013] = {
		3207013,
		0,
		Lang.get(38101),
		3207,
		13,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30],
			RTResTalkAction[12]
		},
		[19] = -1
	},
	[3207014] = {
		3207014,
		0,
		Lang.get(38102),
		3207,
		14,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208001] = {
		3208001,
		0,
		Lang.get(38103),
		3208,
		1,
		354,
		nil,
		1,
		nil,
		nil,
		nil,
		59,
		3214,
		0.5,
		1,
		1,
		nil,
		3214
	},
	[3208002] = {
		3208002,
		0,
		Lang.get(38104),
		3208,
		2,
		354,
		nil,
		1
	},
	[3208003] = {
		3208003,
		0,
		Lang.get(38105),
		3208,
		3,
		112,
		nil,
		1
	},
	[3208004] = {
		3208004,
		0,
		Lang.get(38106),
		3208,
		4,
		354,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[3208005] = {
		3208005,
		0,
		Lang.get(47534),
		3208,
		5,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208006] = {
		3208006,
		0,
		Lang.get(47535),
		3208,
		6,
		112,
		{
			RTResTalkAction[5],
			RTResTalkAction[32]
		}
	},
	[3208007] = {
		3208007,
		0,
		Lang.get(38108),
		3208,
		7,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208008] = {
		3208008,
		0,
		Lang.get(38109),
		3208,
		8,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208009] = {
		3208009,
		0,
		Lang.get(38110),
		3208,
		9,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208010] = {
		3208010,
		0,
		Lang.get(38111),
		3208,
		10,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208011] = {
		3208011,
		0,
		Lang.get(38112),
		3208,
		11,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208012] = {
		3208012,
		0,
		Lang.get(38113),
		3208,
		12,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3208013] = {
		3208013,
		0,
		Lang.get(38114),
		3208,
		13,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[32]
		}
	},
	[3208014] = {
		3208014,
		0,
		Lang.get(38115),
		3208,
		14,
		112,
		{
			RTResTalkAction[2]
		}
	},
	[3208015] = {
		3208015,
		0,
		Lang.get(20536),
		3208,
		15,
		141,
		{
			RTResTalkAction[5]
		},
		1,
		nil,
		nil,
		nil,
		63,
		3215,
		0.5,
		1,
		1,
		nil,
		3215
	},
	[3208016] = {
		3208016,
		0,
		Lang.get(20537),
		3208,
		16,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		3216,
		[18] = 3216
	},
	[3208017] = {
		3208017,
		0,
		Lang.get(20538),
		3208,
		17,
		108,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[3208018] = {
		3208018,
		0,
		Lang.get(20539),
		3208,
		18,
		107,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[3208019] = {
		3208019,
		0,
		Lang.get(20540),
		3208,
		19,
		588,
		{
			RTResTalkAction[36],
			RTResTalkAction[14]
		}
	},
	[3208020] = {
		3208020,
		0,
		Lang.get(20541),
		3208,
		20,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[37]
		}
	},
	[3208021] = {
		3208021,
		0,
		Lang.get(20542),
		3208,
		21,
		107,
		{
			RTResTalkAction[38],
			RTResTalkAction[35]
		}
	},
	[3208022] = {
		3208022,
		0,
		Lang.get(20543),
		3208,
		22,
		588,
		{
			RTResTalkAction[36],
			RTResTalkAction[14]
		}
	},
	[3208023] = {
		3208023,
		0,
		Lang.get(20544),
		3208,
		23,
		588,
		{
			RTResTalkAction[36]
		}
	},
	[3208024] = {
		3208024,
		0,
		Lang.get(20545),
		3208,
		24,
		588,
		{
			RTResTalkAction[36]
		}
	},
	[3208025] = {
		3208025,
		0,
		Lang.get(46208),
		3208,
		25,
		589,
		{
			RTResTalkAction[39],
			RTResTalkAction[37]
		}
	},
	[3208026] = {
		3208026,
		0,
		Lang.get(20546),
		3208,
		26,
		141,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[3209001] = {
		3209001,
		0,
		Lang.get(20640),
		3209,
		1,
		108,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		59,
		3217,
		0.5,
		1,
		1,
		nil,
		3217
	},
	[3209002] = {
		3209002,
		0,
		Lang.get(20641),
		3209,
		2,
		108,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		3218,
		1,
		1,
		1,
		nil,
		3218
	},
	[3209003] = {
		3209003,
		0,
		Lang.get(20642),
		3209,
		3,
		107,
		{
			RTResTalkAction[42],
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[3209004] = {
		3209004,
		0,
		Lang.get(20643),
		3209,
		4,
		107,
		{
			RTResTalkAction[43]
		}
	},
	[3209005] = {
		3209005,
		0,
		Lang.get(20644),
		3209,
		5,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[14]
		}
	},
	[3209006] = {
		3209006,
		0,
		Lang.get(20645),
		3209,
		6,
		108,
		{
			RTResTalkAction[33]
		}
	},
	[3209007] = {
		3209007,
		0,
		Lang.get(20646),
		3209,
		7,
		108,
		{
			RTResTalkAction[33]
		}
	},
	[3209008] = {
		3209008,
		0,
		Lang.get(20647),
		3209,
		8,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[35]
		}
	},
	[3209009] = {
		3209009,
		0,
		Lang.get(20648),
		3209,
		9,
		107,
		{
			RTResTalkAction[38]
		}
	},
	[3209010] = {
		3209010,
		0,
		Lang.get(38116),
		3209,
		10,
		107,
		{
			RTResTalkAction[13]
		}
	},
	[3209011] = {
		3209011,
		0,
		Lang.get(38117),
		3209,
		11,
		141,
		{
			RTResTalkAction[7],
			RTResTalkAction[14]
		}
	},
	[3209012] = {
		3209012,
		0,
		Lang.get(20651),
		3209,
		12,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[8]
		}
	},
	[3209013] = {
		3209013,
		0,
		Lang.get(38118),
		3209,
		13,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[35]
		}
	},
	[3209014] = {
		3209014,
		0,
		Lang.get(20653),
		3209,
		14,
		107,
		{
			RTResTalkAction[13]
		}
	},
	[3209015] = {
		3209015,
		0,
		Lang.get(20654),
		3209,
		15,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[14]
		}
	},
	[3209016] = {
		3209016,
		0,
		Lang.get(38119),
		3209,
		16,
		142,
		{
			RTResTalkAction[23],
			RTResTalkAction[35]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		3219,
		nil,
		1,
		1,
		nil,
		3219
	},
	[3209017] = {
		3209017,
		0,
		Lang.get(38120),
		3209,
		17,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[3209018] = {
		3209018,
		0,
		Lang.get(38121),
		3209,
		18,
		637,
		{
			RTResTalkAction[45],
			RTResTalkAction[46]
		}
	},
	[3209019] = {
		3209019,
		0,
		Lang.get(38122),
		3209,
		19,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[47]
		}
	},
	[3209020] = {
		3209020,
		13,
		nil,
		3209,
		20,
		376,
		{
			RTResTalkAction[9],
			RTResTalkAction[35]
		},
		[19] = 220,
		[26] = 2
	},
	[3209021] = {
		3209021,
		13,
		Lang.get(38123),
		3209,
		21,
		360,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		[26] = 3
	},
	[3209022] = {
		3209022,
		4,
		nil,
		3209,
		22,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3,
		[27] = {
			{
				id = 3209023,
				branch_content = Lang.get(8)
			}
		}
	},
	[3209023] = {
		3209023,
		13,
		Lang.get(38125),
		3209,
		23,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3
	},
	[3209024] = {
		3209024,
		12,
		"5",
		3209,
		24,
		360,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		nil,
		1,
		nil,
		nil,
		nil,
		-1
	},
	[3209025] = {
		3209025,
		12,
		"6",
		3209,
		25,
		360
	},
	[3209026] = {
		3209026,
		12,
		"7",
		3209,
		26,
		360
	},
	[3209027] = {
		3209027,
		0,
		Lang.get(38126),
		3209,
		27,
		107,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[3209028] = {
		3209028,
		0,
		Lang.get(38127),
		3209,
		28,
		108,
		{
			RTResTalkAction[33],
			RTResTalkAction[14]
		}
	},
	[3210001] = {
		3210001,
		0,
		Lang.get(20697),
		3210,
		1,
		170,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		3220,
		nil,
		nil,
		1,
		nil,
		3220
	},
	[3210002] = {
		3210002,
		0,
		Lang.get(20698),
		3210,
		2,
		170,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[3210003] = {
		3210003,
		0,
		Lang.get(20699),
		3210,
		3,
		170,
		{
			RTResTalkAction[50],
			RTResTalkAction[49]
		}
	},
	[3210004] = {
		3210004,
		0,
		Lang.get(46209),
		3210,
		4,
		141,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210005] = {
		3210005,
		0,
		Lang.get(20700),
		3210,
		5,
		141,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210006] = {
		3210006,
		0,
		Lang.get(20701),
		3210,
		6,
		170,
		{
			RTResTalkAction[52],
			RTResTalkAction[49]
		}
	},
	[3210007] = {
		3210007,
		0,
		Lang.get(20702),
		3210,
		7,
		170,
		{
			RTResTalkAction[53],
			RTResTalkAction[49]
		}
	},
	[3210008] = {
		3210008,
		0,
		Lang.get(20703),
		3210,
		8,
		141,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210009] = {
		3210009,
		0,
		Lang.get(20704),
		3210,
		9,
		170,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210010] = {
		3210010,
		0,
		Lang.get(20705),
		3210,
		10,
		170,
		{
			RTResTalkAction[54],
			RTResTalkAction[49]
		}
	},
	[3210011] = {
		3210011,
		0,
		Lang.get(20706),
		3210,
		11,
		141,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210012] = {
		3210012,
		0,
		Lang.get(20707),
		3210,
		12,
		170,
		{
			RTResTalkAction[55],
			RTResTalkAction[49]
		}
	},
	[3210013] = {
		3210013,
		0,
		Lang.get(20708),
		3210,
		13,
		170,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210014] = {
		3210014,
		0,
		Lang.get(20709),
		3210,
		14,
		599,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[8]
		}
	},
	[3210015] = {
		3210015,
		0,
		Lang.get(20710),
		3210,
		15,
		170,
		{
			RTResTalkAction[51],
			RTResTalkAction[49],
			RTResTalkAction[58]
		}
	},
	[3210016] = {
		3210016,
		0,
		Lang.get(20711),
		3210,
		16,
		170,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210017] = {
		3210017,
		0,
		Lang.get(20712),
		3210,
		17,
		599,
		{
			RTResTalkAction[56],
			RTResTalkAction[57],
			RTResTalkAction[8]
		}
	},
	[3210018] = {
		3210018,
		5,
		Lang.get(46210),
		3210,
		18,
		599,
		{
			RTResTalkAction[58]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		3221,
		0.5,
		1,
		1,
		nil,
		3221
	},
	[3210019] = {
		3210019,
		0,
		"…………",
		3210,
		19,
		170,
		{
			RTResTalkAction[59],
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[3210020] = {
		3210020,
		0,
		Lang.get(46211),
		3210,
		20,
		170,
		{
			RTResTalkAction[50],
			RTResTalkAction[49]
		}
	},
	[3210021] = {
		3210021,
		3,
		Lang.get(20715),
		3210,
		21,
		[21] = 1,
		[7] = {
			RTResTalkAction[57],
			RTResTalkAction[8]
		}
	},
	[3210022] = {
		3210022,
		0,
		Lang.get(20716),
		3210,
		22,
		141,
		{
			RTResTalkAction[51],
			RTResTalkAction[49]
		}
	},
	[3210023] = {
		3210023,
		0,
		Lang.get(20717),
		3210,
		23,
		141,
		{
			RTResTalkAction[7],
			RTResTalkAction[57]
		}
	},
	[3210024] = {
		3210024,
		0,
		nil,
		3210,
		24,
		376,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		3222,
		0.5,
		1,
		1,
		nil,
		3222,
		220,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		2
	},
	[3210025] = {
		3210025,
		13,
		Lang.get(38128),
		3210,
		25,
		360,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		[26] = 3
	},
	[3210026] = {
		3210026,
		13,
		Lang.get(38129),
		3210,
		26,
		360,
		{
			RTResTalkAction[10]
		},
		[26] = 3
	},
	[3210027] = {
		3210027,
		0,
		Lang.get(38130),
		3210,
		27,
		354,
		{
			RTResTalkAction[31],
			RTResTalkAction[12]
		},
		nil,
		nil,
		3,
		[19] = -1
	},
	[3210028] = {
		3210028,
		0,
		Lang.get(38131),
		3210,
		28,
		112,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3210029] = {
		3210029,
		0,
		Lang.get(38132),
		3210,
		29,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3210030] = {
		3210030,
		0,
		Lang.get(38133),
		3210,
		30,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[3210031] = {
		3210031,
		0,
		Lang.get(38134),
		3210,
		31,
		300,
		{
			RTResTalkAction[5],
			RTResTalkAction[32]
		}
	},
	[3210032] = {
		3210032,
		0,
		Lang.get(38135),
		3210,
		32,
		354,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
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
