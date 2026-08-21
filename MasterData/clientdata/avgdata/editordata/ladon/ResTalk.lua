-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Ladon\\ResTalk.lua

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
	[2] = 1299
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1299
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 926
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 925
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 926
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 925
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1306
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 1306
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1233
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1233
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 376
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 858
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 858
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 239
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 239
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 605
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 605
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 769
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 769
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 244
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 133
}

local Data = {
	[43200001] = {
		43200001,
		0,
		Lang.get(117476),
		43200,
		1,
		1299,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		43200,
		nil,
		1,
		nil,
		1,
		nil,
		43200
	},
	[43200002] = {
		43200002,
		0,
		Lang.get(117477),
		43200,
		2,
		1299,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[43200003] = {
		43200003,
		0,
		Lang.get(117478),
		43200,
		3,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[43200004] = {
		43200004,
		0,
		Lang.get(117479),
		43200,
		4,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[43200005] = {
		43200005,
		0,
		Lang.get(117480),
		43200,
		5,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[43200006] = {
		43200006,
		0,
		Lang.get(117481),
		43200,
		6,
		1299,
		{
			RTResTalkAction[1]
		}
	},
	[43200007] = {
		43200007,
		3,
		Lang.get(117482),
		43200,
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
		43201,
		nil,
		1,
		nil,
		1,
		nil,
		43201,
		nil,
		nil,
		1
	},
	[43200008] = {
		43200008,
		0,
		Lang.get(117483),
		43200,
		8,
		300,
		nil,
		nil,
		nil,
		3
	},
	[43200009] = {
		43200009,
		0,
		Lang.get(117484),
		43200,
		9,
		924,
		nil,
		1
	},
	[43200010] = {
		43200010,
		0,
		Lang.get(117485),
		43200,
		10,
		300
	},
	[43200011] = {
		43200011,
		0,
		Lang.get(117486),
		43200,
		11,
		924,
		nil,
		1
	},
	[43200012] = {
		43200012,
		0,
		Lang.get(117487),
		43200,
		12,
		300
	},
	[43200013] = {
		43200013,
		0,
		Lang.get(117488),
		43200,
		13,
		924,
		nil,
		1
	},
	[43200014] = {
		43200014,
		0,
		Lang.get(117489),
		43200,
		14,
		924,
		nil,
		1
	},
	[43201001] = {
		43201001,
		3,
		Lang.get(117490),
		43201,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43202,
		nil,
		1,
		nil,
		1,
		nil,
		43202,
		nil,
		nil,
		1
	},
	[43201002] = {
		43201002,
		0,
		Lang.get(117491),
		43201,
		2,
		926,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43201003] = {
		43201003,
		0,
		Lang.get(117492),
		43201,
		3,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43201004] = {
		43201004,
		0,
		Lang.get(117493),
		43201,
		4,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43201005] = {
		43201005,
		0,
		Lang.get(117494),
		43201,
		5,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43201006] = {
		43201006,
		0,
		Lang.get(117495),
		43201,
		6,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43201007] = {
		43201007,
		0,
		Lang.get(117496),
		43201,
		7,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43201008] = {
		43201008,
		3,
		Lang.get(117497),
		43201,
		8,
		605,
		{
			RTResTalkAction[6]
		},
		[22] = 1
	},
	[43201009] = {
		43201009,
		5,
		Lang.get(117498),
		43201,
		9,
		926,
		{
			RTResTalkAction[3]
		}
	},
	[43201010] = {
		43201010,
		0,
		Lang.get(117499),
		43201,
		10,
		925,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43203,
		nil,
		1,
		[19] = 43203,
		[17] = 1
	},
	[43201011] = {
		43201011,
		0,
		Lang.get(117500),
		43201,
		11,
		926,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43201012] = {
		43201012,
		0,
		Lang.get(117501),
		43201,
		12,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43201013] = {
		43201013,
		0,
		Lang.get(117502),
		43201,
		13,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43201014] = {
		43201014,
		3,
		Lang.get(117503),
		43201,
		14,
		605,
		{
			RTResTalkAction[5]
		},
		[22] = 1
	},
	[43201015] = {
		43201015,
		0,
		Lang.get(117504),
		43201,
		15,
		926,
		{
			RTResTalkAction[3]
		}
	},
	[43201016] = {
		43201016,
		3,
		Lang.get(117505),
		43201,
		16,
		605,
		{
			RTResTalkAction[5]
		},
		[22] = 1
	},
	[43201017] = {
		43201017,
		3,
		Lang.get(117506),
		43201,
		17,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		43204,
		nil,
		1,
		nil,
		1,
		nil,
		43204,
		nil,
		nil,
		1
	},
	[43201018] = {
		43201018,
		0,
		Lang.get(117507),
		43201,
		18,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[43202001] = {
		43202001,
		3,
		Lang.get(117508),
		43202,
		1,
		1306,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43205,
		nil,
		1,
		nil,
		1,
		nil,
		43205,
		nil,
		nil,
		1
	},
	[43202002] = {
		43202002,
		0,
		Lang.get(117509),
		43202,
		2,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[43202003] = {
		43202003,
		7,
		"129",
		43202,
		3,
		1306,
		{
			RTResTalkAction[8]
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
	[43202004] = {
		43202004,
		0,
		Lang.get(117510),
		43202,
		4,
		1306,
		{
			RTResTalkAction[7]
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
	[43202005] = {
		43202005,
		0,
		Lang.get(117511),
		43202,
		5,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43202006] = {
		43202006,
		3,
		Lang.get(117512),
		43202,
		6,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[43202007] = {
		43202007,
		0,
		Lang.get(117513),
		43202,
		7,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43202008] = {
		43202008,
		3,
		Lang.get(106209),
		43202,
		8,
		605,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		43206,
		nil,
		1,
		nil,
		1,
		nil,
		43206,
		nil,
		nil,
		1
	},
	[43202009] = {
		43202009,
		0,
		Lang.get(117514),
		43202,
		9,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[43202010] = {
		43202010,
		4,
		nil,
		43202,
		10,
		1118,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 43202011,
				branch_content = Lang.get(117515)
			},
			{
				id = 43202011,
				branch_content = Lang.get(117516)
			}
		}
	},
	[43202011] = {
		43202011,
		0,
		Lang.get(117517),
		43202,
		11,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43202012] = {
		43202012,
		0,
		Lang.get(117518),
		43202,
		12,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[43202013] = {
		43202013,
		0,
		Lang.get(117519),
		43202,
		13,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43202014] = {
		43202014,
		0,
		Lang.get(117520),
		43202,
		14,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[43202015] = {
		43202015,
		0,
		Lang.get(117521),
		43202,
		15,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43202016] = {
		43202016,
		0,
		Lang.get(117522),
		43202,
		16,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43203001] = {
		43203001,
		3,
		Lang.get(117523),
		43203,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		43207,
		nil,
		1,
		nil,
		1,
		nil,
		43207,
		nil,
		nil,
		1
	},
	[43203002] = {
		43203002,
		0,
		Lang.get(117524),
		43203,
		2,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[43203003] = {
		43203003,
		0,
		Lang.get(117525),
		43203,
		3,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43203004] = {
		43203004,
		0,
		Lang.get(117526),
		43203,
		4,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43203005] = {
		43203005,
		0,
		Lang.get(117527),
		43203,
		5,
		1233,
		{
			RTResTalkAction[11]
		}
	},
	[43203006] = {
		43203006,
		0,
		Lang.get(117528),
		43203,
		6,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43203007] = {
		43203007,
		0,
		Lang.get(117529),
		43203,
		7,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43203008] = {
		43203008,
		0,
		Lang.get(117530),
		43203,
		8,
		1233,
		{
			RTResTalkAction[11]
		}
	},
	[43203009] = {
		43203009,
		0,
		Lang.get(117531),
		43203,
		9,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43203010] = {
		43203010,
		0,
		Lang.get(117532),
		43203,
		10,
		1118,
		{
			RTResTalkAction[13],
			RTResTalkAction[10]
		},
		1,
		[27] = 2
	},
	[43203011] = {
		43203011,
		13,
		Lang.get(117533),
		43203,
		11,
		858,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		},
		[27] = 3
	},
	[43203012] = {
		43203012,
		13,
		Lang.get(117534),
		43203,
		12,
		1118,
		{
			RTResTalkAction[14]
		},
		1,
		[27] = 3
	},
	[43203013] = {
		43203013,
		13,
		Lang.get(117535),
		43203,
		13,
		858,
		{
			RTResTalkAction[14]
		},
		[27] = 3
	},
	[43203014] = {
		43203014,
		13,
		Lang.get(117536),
		43203,
		14,
		1118,
		{
			RTResTalkAction[14]
		},
		1,
		[27] = 3
	},
	[43203015] = {
		43203015,
		13,
		Lang.get(117537),
		43203,
		15,
		858,
		{
			RTResTalkAction[14]
		},
		[27] = 3
	},
	[43203016] = {
		43203016,
		13,
		Lang.get(117538),
		43203,
		16,
		1118,
		{
			RTResTalkAction[14]
		},
		1,
		[27] = 3
	},
	[43203017] = {
		43203017,
		0,
		Lang.get(117539),
		43203,
		17,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[16]
		}
	},
	[43203018] = {
		43203018,
		0,
		Lang.get(117540),
		43203,
		18,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43204001] = {
		43204001,
		3,
		Lang.get(117541),
		43204,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43208,
		nil,
		1,
		nil,
		1,
		nil,
		43208,
		nil,
		nil,
		1
	},
	[43204002] = {
		43204002,
		0,
		Lang.get(117542),
		43204,
		2,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[43204003] = {
		43204003,
		0,
		Lang.get(117543),
		43204,
		3,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43204004] = {
		43204004,
		0,
		Lang.get(117544),
		43204,
		4,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43204005] = {
		43204005,
		0,
		Lang.get(117545),
		43204,
		5,
		1306,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		43209,
		nil,
		1,
		nil,
		1,
		nil,
		43209
	},
	[43204006] = {
		43204006,
		0,
		Lang.get(117546),
		43204,
		6,
		926,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43204007] = {
		43204007,
		0,
		Lang.get(117547),
		43204,
		7,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43204008] = {
		43204008,
		0,
		Lang.get(117548),
		43204,
		8,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[43204009] = {
		43204009,
		0,
		Lang.get(117549),
		43204,
		9,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[43204010] = {
		43204010,
		0,
		Lang.get(117841),
		43204,
		10,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43204011] = {
		43204011,
		0,
		Lang.get(117551),
		43204,
		11,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[5]
		}
	},
	[43204012] = {
		43204012,
		0,
		Lang.get(117552),
		43204,
		12,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43205001] = {
		43205001,
		3,
		Lang.get(117553),
		43205,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		43210,
		nil,
		1,
		nil,
		1,
		nil,
		43210,
		nil,
		nil,
		1
	},
	[43205002] = {
		43205002,
		0,
		Lang.get(117554),
		43205,
		2,
		926,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[43205003] = {
		43205003,
		0,
		Lang.get(117555),
		43205,
		3,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43205004] = {
		43205004,
		0,
		Lang.get(117556),
		43205,
		4,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43205005] = {
		43205005,
		0,
		Lang.get(117557),
		43205,
		5,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43205006] = {
		43205006,
		0,
		Lang.get(117558),
		43205,
		6,
		1118,
		{
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		43211,
		nil,
		1,
		nil,
		1,
		nil,
		43211
	},
	[43205007] = {
		43205007,
		0,
		Lang.get(117559),
		43205,
		7,
		1233,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[43205008] = {
		43205008,
		3,
		Lang.get(117560),
		43205,
		8,
		605,
		{
			RTResTalkAction[12]
		},
		[22] = 1
	},
	[43205009] = {
		43205009,
		0,
		Lang.get(117561),
		43205,
		9,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43205010] = {
		43205010,
		0,
		Lang.get(117562),
		43205,
		10,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206001] = {
		43206001,
		0,
		Lang.get(117563),
		43206,
		1,
		1306,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		43212,
		nil,
		1,
		nil,
		1,
		nil,
		43212
	},
	[43206002] = {
		43206002,
		0,
		Lang.get(117564),
		43206,
		2,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[43206003] = {
		43206003,
		0,
		Lang.get(117565),
		43206,
		3,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206004] = {
		43206004,
		3,
		Lang.get(117566),
		43206,
		4,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[43206005] = {
		43206005,
		0,
		Lang.get(117567),
		43206,
		5,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206006] = {
		43206006,
		3,
		Lang.get(100843),
		43206,
		6,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[43206007] = {
		43206007,
		0,
		Lang.get(117568),
		43206,
		7,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206008] = {
		43206008,
		0,
		Lang.get(117569),
		43206,
		8,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206009] = {
		43206009,
		0,
		Lang.get(117570),
		43206,
		9,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206010] = {
		43206010,
		0,
		Lang.get(117571),
		43206,
		10,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206011] = {
		43206011,
		0,
		Lang.get(117572),
		43206,
		11,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206012] = {
		43206012,
		0,
		Lang.get(117573),
		43206,
		12,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43206013] = {
		43206013,
		0,
		Lang.get(117574),
		43206,
		13,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43207001] = {
		43207001,
		3,
		Lang.get(117575),
		43207,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		43213,
		nil,
		1,
		nil,
		1,
		nil,
		43213,
		nil,
		nil,
		1
	},
	[43207002] = {
		43207002,
		0,
		Lang.get(117576),
		43207,
		2,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[43207003] = {
		43207003,
		0,
		Lang.get(117577),
		43207,
		3,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43207004] = {
		43207004,
		0,
		Lang.get(117578),
		43207,
		4,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43207005] = {
		43207005,
		0,
		Lang.get(117579),
		43207,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43207006] = {
		43207006,
		0,
		Lang.get(117580),
		43207,
		6,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43207007] = {
		43207007,
		0,
		Lang.get(117581),
		43207,
		7,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43207008] = {
		43207008,
		0,
		Lang.get(117582),
		43207,
		8,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43207009] = {
		43207009,
		3,
		Lang.get(117583),
		43207,
		9,
		605,
		{
			RTResTalkAction[19],
			RTResTalkAction[18]
		},
		[22] = 1
	},
	[43207010] = {
		43207010,
		0,
		Lang.get(117584),
		43207,
		10,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[20]
		}
	},
	[43207011] = {
		43207011,
		0,
		Lang.get(117585),
		43207,
		11,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43207012] = {
		43207012,
		0,
		Lang.get(117586),
		43207,
		12,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43207013] = {
		43207013,
		0,
		Lang.get(117587),
		43207,
		13,
		239,
		{
			RTResTalkAction[17]
		}
	},
	[43207014] = {
		43207014,
		0,
		Lang.get(117588),
		43207,
		14,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43207015] = {
		43207015,
		0,
		Lang.get(117589),
		43207,
		15,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43207016] = {
		43207016,
		0,
		Lang.get(117590),
		43207,
		16,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43207017] = {
		43207017,
		0,
		Lang.get(117591),
		43207,
		17,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43207018] = {
		43207018,
		0,
		Lang.get(117592),
		43207,
		18,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43208001] = {
		43208001,
		0,
		Lang.get(117593),
		43208,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43214,
		nil,
		1,
		nil,
		1,
		nil,
		43214
	},
	[43208002] = {
		43208002,
		0,
		Lang.get(117594),
		43208,
		2,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43208003] = {
		43208003,
		0,
		Lang.get(117595),
		43208,
		3,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43208004] = {
		43208004,
		0,
		Lang.get(117596),
		43208,
		4,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43208005] = {
		43208005,
		0,
		Lang.get(117597),
		43208,
		5,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43208006] = {
		43208006,
		3,
		Lang.get(117598),
		43208,
		6,
		605,
		{
			RTResTalkAction[22]
		},
		[22] = 1
	},
	[43208007] = {
		43208007,
		0,
		Lang.get(117599),
		43208,
		7,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43208008] = {
		43208008,
		0,
		Lang.get(117600),
		43208,
		8,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43208009] = {
		43208009,
		0,
		Lang.get(117601),
		43208,
		9,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43208010] = {
		43208010,
		0,
		Lang.get(117602),
		43208,
		10,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43208011] = {
		43208011,
		0,
		Lang.get(117603),
		43208,
		11,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43208012] = {
		43208012,
		0,
		Lang.get(117604),
		43208,
		12,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43208013] = {
		43208013,
		0,
		Lang.get(117605),
		43208,
		13,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43208014] = {
		43208014,
		0,
		Lang.get(117606),
		43208,
		14,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43208015] = {
		43208015,
		0,
		Lang.get(117607),
		43208,
		15,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209001] = {
		43209001,
		3,
		Lang.get(117608),
		43209,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		43215,
		nil,
		1,
		nil,
		1,
		nil,
		43215,
		nil,
		nil,
		1
	},
	[43209002] = {
		43209002,
		0,
		Lang.get(117609),
		43209,
		2,
		769,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[43209003] = {
		43209003,
		0,
		Lang.get(117610),
		43209,
		3,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209004] = {
		43209004,
		0,
		Lang.get(117611),
		43209,
		4,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43209005] = {
		43209005,
		0,
		Lang.get(117612),
		43209,
		5,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43209006] = {
		43209006,
		0,
		Lang.get(117613),
		43209,
		6,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209007] = {
		43209007,
		0,
		Lang.get(117614),
		43209,
		7,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43209008] = {
		43209008,
		0,
		Lang.get(117615),
		43209,
		8,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43209009] = {
		43209009,
		0,
		Lang.get(117616),
		43209,
		9,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209010] = {
		43209010,
		0,
		Lang.get(117617),
		43209,
		10,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43209011] = {
		43209011,
		0,
		Lang.get(117618),
		43209,
		11,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209012] = {
		43209012,
		0,
		Lang.get(117619),
		43209,
		12,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43209013] = {
		43209013,
		0,
		Lang.get(117620),
		43209,
		13,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43209014] = {
		43209014,
		0,
		Lang.get(117621),
		43209,
		14,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43209015] = {
		43209015,
		0,
		Lang.get(117622),
		43209,
		15,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43210001] = {
		43210001,
		0,
		Lang.get(117623),
		43210,
		1,
		769,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43216,
		nil,
		1,
		nil,
		1,
		nil,
		43216
	},
	[43210002] = {
		43210002,
		0,
		Lang.get(117624),
		43210,
		2,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[22]
		}
	},
	[43210003] = {
		43210003,
		0,
		Lang.get(117625),
		43210,
		3,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[43210004] = {
		43210004,
		0,
		Lang.get(117626),
		43210,
		4,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[22]
		}
	},
	[43210005] = {
		43210005,
		0,
		Lang.get(117627),
		43210,
		5,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[6]
		}
	},
	[43210006] = {
		43210006,
		0,
		Lang.get(117628),
		43210,
		6,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[22]
		}
	},
	[43210007] = {
		43210007,
		0,
		Lang.get(117629),
		43210,
		7,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[43210008] = {
		43210008,
		0,
		Lang.get(117630),
		43210,
		8,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43210009] = {
		43210009,
		0,
		Lang.get(117631),
		43210,
		9,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43210010] = {
		43210010,
		0,
		Lang.get(117632),
		43210,
		10,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43210011] = {
		43210011,
		0,
		Lang.get(117633),
		43210,
		11,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43210012] = {
		43210012,
		0,
		Lang.get(117634),
		43210,
		12,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43210013] = {
		43210013,
		0,
		Lang.get(117635),
		43210,
		13,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43210014] = {
		43210014,
		0,
		Lang.get(117636),
		43210,
		14,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43210015] = {
		43210015,
		0,
		Lang.get(117637),
		43210,
		15,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43210016] = {
		43210016,
		0,
		Lang.get(117638),
		43210,
		16,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43210017] = {
		43210017,
		0,
		Lang.get(117639),
		43210,
		17,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43210018] = {
		43210018,
		0,
		Lang.get(117640),
		43210,
		18,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43211001] = {
		43211001,
		0,
		Lang.get(117641),
		43211,
		1,
		239,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		59,
		43217,
		nil,
		1,
		nil,
		1,
		nil,
		43217
	},
	[43211002] = {
		43211002,
		0,
		Lang.get(117642),
		43211,
		2,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43211003] = {
		43211003,
		0,
		Lang.get(117643),
		43211,
		3,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43211004] = {
		43211004,
		0,
		Lang.get(117644),
		43211,
		4,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43211005] = {
		43211005,
		0,
		Lang.get(117645),
		43211,
		5,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43211006] = {
		43211006,
		0,
		Lang.get(117646),
		43211,
		6,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43211007] = {
		43211007,
		0,
		Lang.get(117647),
		43211,
		7,
		239,
		{
			RTResTalkAction[17]
		}
	},
	[43211008] = {
		43211008,
		0,
		Lang.get(117648),
		43211,
		8,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43221001] = {
		43221001,
		3,
		Lang.get(117649),
		43221,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		43217,
		nil,
		1,
		nil,
		1,
		nil,
		43217,
		nil,
		nil,
		1
	},
	[43221002] = {
		43221002,
		0,
		Lang.get(117650),
		43221,
		2,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43221003] = {
		43221003,
		0,
		Lang.get(117651),
		43221,
		3,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43221004] = {
		43221004,
		0,
		Lang.get(117652),
		43221,
		4,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43221005] = {
		43221005,
		0,
		Lang.get(117653),
		43221,
		5,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43221006] = {
		43221006,
		0,
		Lang.get(117654),
		43221,
		6,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43221007] = {
		43221007,
		0,
		Lang.get(117655),
		43221,
		7,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43212001] = {
		43212001,
		0,
		Lang.get(117656),
		43212,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		59,
		43218,
		nil,
		1,
		nil,
		1,
		nil,
		43218
	},
	[43212002] = {
		43212002,
		0,
		Lang.get(117657),
		43212,
		2,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43212003] = {
		43212003,
		0,
		Lang.get(117658),
		43212,
		3,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43212004] = {
		43212004,
		0,
		Lang.get(117659),
		43212,
		4,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43212005] = {
		43212005,
		0,
		Lang.get(117660),
		43212,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43212006] = {
		43212006,
		0,
		Lang.get(117661),
		43212,
		6,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[8]
		}
	},
	[43212007] = {
		43212007,
		0,
		Lang.get(117662),
		43212,
		7,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[22]
		}
	},
	[43212008] = {
		43212008,
		0,
		Lang.get(117663),
		43212,
		8,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[43212009] = {
		43212009,
		0,
		Lang.get(117664),
		43212,
		9,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[6]
		}
	},
	[43212010] = {
		43212010,
		0,
		Lang.get(117665),
		43212,
		10,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43212011] = {
		43212011,
		0,
		Lang.get(117666),
		43212,
		11,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[22]
		}
	},
	[43212012] = {
		43212012,
		0,
		Lang.get(117667),
		43212,
		12,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[5]
		}
	},
	[43212013] = {
		43212013,
		0,
		Lang.get(117668),
		43212,
		13,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43212014] = {
		43212014,
		0,
		Lang.get(117669),
		43212,
		14,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43212015] = {
		43212015,
		0,
		Lang.get(117670),
		43212,
		15,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43212016] = {
		43212016,
		0,
		Lang.get(117671),
		43212,
		16,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43212017] = {
		43212017,
		0,
		Lang.get(117672),
		43212,
		17,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43212018] = {
		43212018,
		0,
		Lang.get(117673),
		43212,
		18,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43213001] = {
		43213001,
		0,
		Lang.get(117674),
		43213,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		62,
		43219,
		nil,
		1,
		nil,
		1,
		nil,
		43219
	},
	[43213002] = {
		43213002,
		0,
		Lang.get(117675),
		43213,
		2,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43213003] = {
		43213003,
		0,
		Lang.get(117676),
		43213,
		3,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43213004] = {
		43213004,
		0,
		Lang.get(117677),
		43213,
		4,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43213005] = {
		43213005,
		3,
		Lang.get(117678),
		43213,
		5,
		605,
		{
			RTResTalkAction[18]
		},
		[22] = 1
	},
	[43213006] = {
		43213006,
		0,
		Lang.get(117679),
		43213,
		6,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43213007] = {
		43213007,
		0,
		Lang.get(117680),
		43213,
		7,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43213008] = {
		43213008,
		0,
		Lang.get(117681),
		43213,
		8,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43213009] = {
		43213009,
		3,
		Lang.get(117682),
		43213,
		9,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
	},
	[43213010] = {
		43213010,
		0,
		Lang.get(117683),
		43213,
		10,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43213011] = {
		43213011,
		0,
		Lang.get(117684),
		43213,
		11,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43213012] = {
		43213012,
		0,
		Lang.get(117685),
		43213,
		12,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43213013] = {
		43213013,
		0,
		Lang.get(117686),
		43213,
		13,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43213014] = {
		43213014,
		0,
		Lang.get(117687),
		43213,
		14,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[18]
		}
	},
	[43213015] = {
		43213015,
		0,
		Lang.get(117688),
		43213,
		15,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43213016] = {
		43213016,
		0,
		Lang.get(117689),
		43213,
		16,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[22]
		}
	},
	[43214001] = {
		43214001,
		0,
		Lang.get(117690),
		43214,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43220,
		nil,
		1,
		nil,
		1,
		nil,
		43220
	},
	[43214002] = {
		43214002,
		0,
		Lang.get(117691),
		43214,
		2,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43214003] = {
		43214003,
		0,
		Lang.get(117692),
		43214,
		3,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43214004] = {
		43214004,
		0,
		Lang.get(117693),
		43214,
		4,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43214005] = {
		43214005,
		3,
		Lang.get(117694),
		43214,
		5,
		605,
		{
			RTResTalkAction[18]
		},
		[22] = 1
	},
	[43214006] = {
		43214006,
		0,
		Lang.get(117695),
		43214,
		6,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43214007] = {
		43214007,
		0,
		Lang.get(117696),
		43214,
		7,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43214008] = {
		43214008,
		0,
		Lang.get(117697),
		43214,
		8,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43214009] = {
		43214009,
		0,
		Lang.get(117698),
		43214,
		9,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43214010] = {
		43214010,
		0,
		Lang.get(117699),
		43214,
		10,
		925,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[43214011] = {
		43214011,
		0,
		Lang.get(117700),
		43214,
		11,
		926,
		{
			RTResTalkAction[3],
			RTResTalkAction[6]
		}
	},
	[43214012] = {
		43214012,
		0,
		Lang.get(117701),
		43214,
		12,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[43214013] = {
		43214013,
		0,
		Lang.get(117702),
		43214,
		13,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43222001] = {
		43222001,
		0,
		Lang.get(117703),
		43222,
		1,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43220,
		nil,
		1,
		nil,
		1,
		nil,
		43220
	},
	[43222002] = {
		43222002,
		0,
		Lang.get(117704),
		43222,
		2,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43222003] = {
		43222003,
		0,
		Lang.get(117705),
		43222,
		3,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43222004] = {
		43222004,
		0,
		Lang.get(117706),
		43222,
		4,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[43222005] = {
		43222005,
		0,
		Lang.get(117707),
		43222,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43222006] = {
		43222006,
		0,
		Lang.get(117708),
		43222,
		6,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43222007] = {
		43222007,
		0,
		Lang.get(117709),
		43222,
		7,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[43215001] = {
		43215001,
		0,
		Lang.get(114211),
		43215,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		63,
		43221,
		nil,
		1,
		nil,
		1,
		nil,
		43221
	},
	[43215002] = {
		43215002,
		0,
		Lang.get(117710),
		43215,
		2,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43215003] = {
		43215003,
		0,
		Lang.get(117711),
		43215,
		3,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[43215004] = {
		43215004,
		0,
		Lang.get(117712),
		43215,
		4,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[43215005] = {
		43215005,
		0,
		Lang.get(117713),
		43215,
		5,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43215006] = {
		43215006,
		0,
		Lang.get(117714),
		43215,
		6,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43215007] = {
		43215007,
		0,
		Lang.get(117715),
		43215,
		7,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43215008] = {
		43215008,
		0,
		Lang.get(117716),
		43215,
		8,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43215009] = {
		43215009,
		0,
		Lang.get(117717),
		43215,
		9,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43215010] = {
		43215010,
		0,
		Lang.get(117718),
		43215,
		10,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43215011] = {
		43215011,
		0,
		Lang.get(117719),
		43215,
		11,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43215012] = {
		43215012,
		0,
		Lang.get(117720),
		43215,
		12,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43215013] = {
		43215013,
		0,
		Lang.get(117721),
		43215,
		13,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43215014] = {
		43215014,
		0,
		Lang.get(117722),
		43215,
		14,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43215015] = {
		43215015,
		0,
		Lang.get(117723),
		43215,
		15,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[12]
		}
	},
	[43215016] = {
		43215016,
		0,
		Lang.get(117724),
		43215,
		16,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43216001] = {
		43216001,
		0,
		Lang.get(117725),
		43216,
		1,
		769,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		60,
		43222,
		nil,
		1,
		nil,
		1,
		nil,
		43222
	},
	[43216002] = {
		43216002,
		0,
		Lang.get(117726),
		43216,
		2,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43216003] = {
		43216003,
		0,
		Lang.get(117727),
		43216,
		3,
		769,
		{
			RTResTalkAction[21]
		}
	},
	[43216004] = {
		43216004,
		0,
		Lang.get(117728),
		43216,
		4,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[22]
		}
	},
	[43216005] = {
		43216005,
		0,
		Lang.get(117729),
		43216,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43216006] = {
		43216006,
		0,
		Lang.get(117730),
		43216,
		6,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43216007] = {
		43216007,
		0,
		Lang.get(117731),
		43216,
		7,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43216008] = {
		43216008,
		0,
		Lang.get(117732),
		43216,
		8,
		769,
		{
			RTResTalkAction[21],
			RTResTalkAction[12]
		}
	},
	[43223001] = {
		43223001,
		0,
		Lang.get(117733),
		43223,
		1,
		1306,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		60,
		43222,
		nil,
		1,
		nil,
		1,
		nil,
		43222
	},
	[43223002] = {
		43223002,
		0,
		Lang.get(117734),
		43223,
		2,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43223003] = {
		43223003,
		0,
		Lang.get(117735),
		43223,
		3,
		239,
		{
			RTResTalkAction[17]
		}
	},
	[43223004] = {
		43223004,
		0,
		Lang.get(117736),
		43223,
		4,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[43223005] = {
		43223005,
		0,
		Lang.get(117737),
		43223,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43223006] = {
		43223006,
		0,
		Lang.get(117738),
		43223,
		6,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[8]
		}
	},
	[43223007] = {
		43223007,
		0,
		Lang.get(117739),
		43223,
		7,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[18]
		}
	},
	[43223008] = {
		43223008,
		0,
		Lang.get(117740),
		43223,
		8,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43223009] = {
		43223009,
		0,
		Lang.get(117741),
		43223,
		9,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43223010] = {
		43223010,
		0,
		Lang.get(117742),
		43223,
		10,
		239,
		{
			RTResTalkAction[17],
			RTResTalkAction[12]
		}
	},
	[43217001] = {
		43217001,
		0,
		Lang.get(117743),
		43217,
		1,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		58,
		43223,
		nil,
		1,
		nil,
		1,
		nil,
		43223
	},
	[43217002] = {
		43217002,
		0,
		Lang.get(117744),
		43217,
		2,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43217003] = {
		43217003,
		4,
		nil,
		43217,
		3,
		1306,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 43217004,
				branch_content = Lang.get(117745)
			}
		}
	},
	[43217004] = {
		43217004,
		0,
		Lang.get(117842),
		43217,
		4,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43217005] = {
		43217005,
		0,
		Lang.get(117746),
		43217,
		5,
		300,
		{
			RTResTalkAction[8]
		}
	},
	[43217006] = {
		43217006,
		0,
		Lang.get(117747),
		43217,
		6,
		1306,
		{
			RTResTalkAction[7]
		}
	},
	[43217007] = {
		43217007,
		0,
		Lang.get(117748),
		43217,
		7,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[8]
		}
	},
	[43217008] = {
		43217008,
		0,
		Lang.get(117749),
		43217,
		8,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43217009] = {
		43217009,
		0,
		Lang.get(117750),
		43217,
		9,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[43217010] = {
		43217010,
		0,
		Lang.get(117751),
		43217,
		10,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43217011] = {
		43217011,
		0,
		Lang.get(117752),
		43217,
		11,
		927,
		{
			RTResTalkAction[10]
		}
	},
	[43217012] = {
		43217012,
		0,
		Lang.get(117753),
		43217,
		12,
		927
	},
	[43217013] = {
		43217013,
		4,
		nil,
		43217,
		13,
		927,
		[29] = {
			{
				id = 43217014,
				branch_content = Lang.get(117754)
			},
			{
				id = 43217014,
				branch_content = Lang.get(117755)
			}
		}
	},
	[43217014] = {
		43217014,
		0,
		Lang.get(117756),
		43217,
		14,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218001] = {
		43218001,
		0,
		Lang.get(117757),
		43218,
		1,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		58,
		43224,
		nil,
		1,
		nil,
		1,
		nil,
		43224
	},
	[43218002] = {
		43218002,
		0,
		Lang.get(117758),
		43218,
		2,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218003] = {
		43218003,
		4,
		nil,
		43218,
		3,
		1118,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 43218004,
				branch_content = Lang.get(117759)
			}
		}
	},
	[43218004] = {
		43218004,
		0,
		Lang.get(117760),
		43218,
		4,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218005] = {
		43218005,
		0,
		Lang.get(117761),
		43218,
		5,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218006] = {
		43218006,
		0,
		Lang.get(117762),
		43218,
		6,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218007] = {
		43218007,
		4,
		nil,
		43218,
		7,
		1118,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 43218008,
				branch_content = Lang.get(117763)
			}
		}
	},
	[43218008] = {
		43218008,
		0,
		Lang.get(117764),
		43218,
		8,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218009] = {
		43218009,
		4,
		nil,
		43218,
		9,
		1118,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 43218010,
				branch_content = Lang.get(117765)
			}
		}
	},
	[43218010] = {
		43218010,
		0,
		Lang.get(117766),
		43218,
		10,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218011] = {
		43218011,
		0,
		Lang.get(117767),
		43218,
		11,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[43218012] = {
		43218012,
		0,
		Lang.get(117768),
		43218,
		12,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218013] = {
		43218013,
		0,
		Lang.get(117769),
		43218,
		13,
		1118,
		{
			RTResTalkAction[9]
		}
	},
	[43218014] = {
		43218014,
		0,
		Lang.get(117770),
		43218,
		14,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[43219001] = {
		43219001,
		0,
		Lang.get(117771),
		43219,
		1,
		1118,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3,
		nil,
		58,
		43225,
		nil,
		1,
		nil,
		1,
		nil,
		43225
	},
	[43219002] = {
		43219002,
		0,
		Lang.get(117772),
		43219,
		2,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[43219003] = {
		43219003,
		0,
		Lang.get(117773),
		43219,
		3,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[43219004] = {
		43219004,
		0,
		Lang.get(117774),
		43219,
		4,
		244,
		{
			RTResTalkAction[25],
			RTResTalkAction[10]
		}
	},
	[43219005] = {
		43219005,
		4,
		nil,
		43219,
		5,
		244,
		{
			RTResTalkAction[25]
		},
		[29] = {
			{
				id = 43219006,
				branch_content = Lang.get(117775)
			},
			{
				id = 43219006,
				branch_content = Lang.get(117776)
			}
		}
	},
	[43219006] = {
		43219006,
		0,
		Lang.get(117777),
		43219,
		6,
		244,
		{
			RTResTalkAction[25]
		}
	},
	[43219007] = {
		43219007,
		0,
		Lang.get(117778),
		43219,
		7,
		244,
		{
			RTResTalkAction[25]
		}
	},
	[43219008] = {
		43219008,
		0,
		Lang.get(117779),
		43219,
		8,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[26]
		}
	},
	[43219009] = {
		43219009,
		0,
		Lang.get(117780),
		43219,
		9,
		244,
		{
			RTResTalkAction[25],
			RTResTalkAction[24]
		}
	},
	[43219010] = {
		43219010,
		0,
		Lang.get(117781),
		43219,
		10,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[26]
		}
	},
	[43219011] = {
		43219011,
		0,
		Lang.get(117782),
		43219,
		11,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[10]
		}
	},
	[43219012] = {
		43219012,
		0,
		Lang.get(117783),
		43219,
		12,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[43219013] = {
		43219013,
		0,
		Lang.get(117784),
		43219,
		13,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[43219014] = {
		43219014,
		0,
		Lang.get(117785),
		43219,
		14,
		300,
		{
			RTResTalkAction[23],
			RTResTalkAction[32]
		}
	},
	[43219015] = {
		43219015,
		0,
		Lang.get(117786),
		43219,
		15,
		1233,
		{
			RTResTalkAction[11],
			RTResTalkAction[24]
		}
	},
	[43219016] = {
		43219016,
		0,
		Lang.get(117787),
		43219,
		16,
		1233,
		{
			RTResTalkAction[11]
		}
	},
	[43219017] = {
		43219017,
		0,
		Lang.get(117788),
		43219,
		17,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[43220001] = {
		43220001,
		0,
		Lang.get(117789),
		43220,
		1,
		300,
		nil,
		nil,
		nil,
		3,
		nil,
		58,
		43226,
		nil,
		1,
		nil,
		1,
		nil,
		43226
	},
	[43220002] = {
		43220002,
		0,
		Lang.get(117790),
		43220,
		2,
		107,
		{
			RTResTalkAction[27]
		}
	},
	[43220003] = {
		43220003,
		0,
		Lang.get(117791),
		43220,
		3,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[43220004] = {
		43220004,
		0,
		Lang.get(117792),
		43220,
		4,
		1118,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[43220005] = {
		43220005,
		0,
		Lang.get(117793),
		43220,
		5,
		1306,
		{
			RTResTalkAction[7],
			RTResTalkAction[10]
		}
	},
	[43220006] = {
		43220006,
		0,
		Lang.get(117794),
		43220,
		6,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[8]
		}
	},
	[43220007] = {
		43220007,
		0,
		Lang.get(117795),
		43220,
		7,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[43220008] = {
		43220008,
		0,
		Lang.get(117796),
		43220,
		8,
		107,
		{
			RTResTalkAction[27]
		}
	},
	[43220009] = {
		43220009,
		0,
		Lang.get(117797),
		43220,
		9,
		107,
		{
			RTResTalkAction[27]
		}
	},
	[43220010] = {
		43220010,
		0,
		Lang.get(117798),
		43220,
		10,
		107,
		{
			RTResTalkAction[27]
		}
	},
	[43220011] = {
		43220011,
		0,
		Lang.get(117799),
		43220,
		11,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[43220012] = {
		43220012,
		4,
		nil,
		43220,
		12,
		141,
		{
			RTResTalkAction[28]
		},
		[29] = {
			{
				id = 43220013,
				branch_content = Lang.get(117800)
			}
		}
	},
	[43220013] = {
		43220013,
		0,
		Lang.get(117801),
		43220,
		13,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[31]
		}
	},
	[43220014] = {
		43220014,
		0,
		Lang.get(117802),
		43220,
		14,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[29]
		}
	},
	[43220015] = {
		43220015,
		0,
		Lang.get(117803),
		43220,
		15,
		107,
		{
			RTResTalkAction[27],
			RTResTalkAction[31]
		}
	},
	[43220016] = {
		43220016,
		0,
		Lang.get(117804),
		43220,
		16,
		133,
		{
			RTResTalkAction[30],
			RTResTalkAction[29]
		}
	},
	[43220017] = {
		43220017,
		0,
		Lang.get(117805),
		43220,
		17,
		300,
		{
			RTResTalkAction[32]
		}
	},
	[43220018] = {
		43220018,
		0,
		Lang.get(117806),
		43220,
		18,
		107,
		{
			RTResTalkAction[27]
		}
	},
	[43220019] = {
		43220019,
		4,
		nil,
		43220,
		19,
		107,
		{
			RTResTalkAction[27]
		},
		[29] = {
			{
				id = 43220020,
				branch_content = Lang.get(117807)
			},
			{
				id = 43220020,
				branch_content = Lang.get(117808)
			}
		}
	},
	[43220020] = {
		43220020,
		3,
		Lang.get(117809),
		43220,
		20,
		605,
		{
			RTResTalkAction[29]
		},
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
