-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Thetis\\ResTalk.lua

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
	10
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 773
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 772
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 773
}
RTResTalkAction[6] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 772
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1298
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 1298
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 907
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 907
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 908
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 908
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 909
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 909
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 1298
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[19] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 148
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 148
}
RTResTalkAction[25] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1299
}
RTResTalkAction[29] = {
	[1] = 0,
	[2] = 1299
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[32] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[33] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[34] = {
	[1] = 3,
	[2] = 1118
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 910
}
RTResTalkAction[37] = {
	[1] = 2,
	[2] = 910
}
RTResTalkAction[38] = {
	[1] = 3,
	[2] = 911
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 910
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 911
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 911
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 912
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 913
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 912
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 913
}
RTResTalkAction[46] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 1233
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 1233
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1199
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 1199
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 1300
}
RTResTalkAction[57] = {
	[1] = 0,
	[2] = 1300
}

local Data = {
	[42521001] = {
		42521001,
		9,
		Lang.get(114169),
		42521,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		42521,
		nil,
		1,
		nil,
		1,
		nil,
		42521,
		nil,
		nil,
		1
	},
	[42521002] = {
		42521002,
		9,
		Lang.get(114170),
		42521,
		2,
		605,
		[22] = 1
	},
	[42521003] = {
		42521003,
		0,
		Lang.get(114171),
		42521,
		3,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[42521004] = {
		42521004,
		0,
		Lang.get(114172),
		42521,
		4,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[42521005] = {
		42521005,
		0,
		Lang.get(114173),
		42521,
		5,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42521006] = {
		42521006,
		0,
		Lang.get(114174),
		42521,
		6,
		107,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[42521007] = {
		42521007,
		4,
		nil,
		42521,
		7,
		107,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 42521008,
				branch_content = Lang.get(114175)
			},
			{
				id = 42521008,
				branch_content = Lang.get(114176)
			}
		}
	},
	[42521008] = {
		42521008,
		0,
		Lang.get(114177),
		42521,
		8,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[42521009] = {
		42521009,
		9,
		Lang.get(114178),
		42521,
		9,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42522,
		nil,
		1,
		nil,
		1,
		nil,
		42522,
		nil,
		nil,
		1
	},
	[42521010] = {
		42521010,
		0,
		Lang.get(114179),
		42521,
		10,
		773,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[42521011] = {
		42521011,
		0,
		Lang.get(114180),
		42521,
		11,
		906,
		{
			RTResTalkAction[5]
		},
		1
	},
	[42521012] = {
		42521012,
		0,
		Lang.get(114181),
		42521,
		12,
		906,
		nil,
		1
	},
	[42521013] = {
		42521013,
		0,
		Lang.get(114182),
		42521,
		13,
		773,
		{
			RTResTalkAction[2]
		}
	},
	[42521014] = {
		42521014,
		0,
		Lang.get(114183),
		42521,
		14,
		906,
		{
			RTResTalkAction[5]
		},
		1
	},
	[42521015] = {
		42521015,
		9,
		Lang.get(114184),
		42521,
		15,
		605,
		[22] = 1
	},
	[42521016] = {
		42521016,
		0,
		Lang.get(114185),
		42521,
		16,
		772,
		{
			RTResTalkAction[4]
		}
	},
	[42521017] = {
		42521017,
		0,
		Lang.get(114186),
		42521,
		17,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[42521018] = {
		42521018,
		9,
		Lang.get(114187),
		42521,
		18,
		605,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42523,
		nil,
		1,
		nil,
		1,
		nil,
		42523,
		nil,
		nil,
		1
	},
	[42521019] = {
		42521019,
		0,
		Lang.get(114188),
		42521,
		19,
		772,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[42521020] = {
		42521020,
		0,
		Lang.get(114189),
		42521,
		20,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[42521021] = {
		42521021,
		0,
		Lang.get(114190),
		42521,
		21,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42521022] = {
		42521022,
		0,
		Lang.get(114191),
		42521,
		22,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[42521023] = {
		42521023,
		7,
		"124",
		42521,
		23,
		1298,
		{
			RTResTalkAction[10]
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
	[42521024] = {
		42521024,
		0,
		Lang.get(114192),
		42521,
		24,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42522001] = {
		42522001,
		9,
		Lang.get(114193),
		42522,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		40,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		42524,
		250,
		nil,
		1
	},
	[42522002] = {
		42522002,
		0,
		Lang.get(114194),
		42522,
		2,
		907,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[42522003] = {
		42522003,
		0,
		Lang.get(114195),
		42522,
		3,
		907,
		{
			RTResTalkAction[11]
		}
	},
	[42522004] = {
		42522004,
		0,
		Lang.get(114196),
		42522,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[42522005] = {
		42522005,
		0,
		Lang.get(114197),
		42522,
		5,
		107,
		{
			RTResTalkAction[10]
		},
		1
	},
	[42522006] = {
		42522006,
		0,
		Lang.get(114198),
		42522,
		6,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		194,
		42524,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[42522007] = {
		42522007,
		0,
		Lang.get(114199),
		42522,
		7,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42522008] = {
		42522008,
		4,
		nil,
		42522,
		8,
		1298,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 42522009,
				branch_content = Lang.get(114200)
			},
			{
				id = 42522009,
				branch_content = Lang.get(114201)
			}
		}
	},
	[42522009] = {
		42522009,
		0,
		Lang.get(114202),
		42522,
		9,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42545001] = {
		42545001,
		9,
		Lang.get(114203),
		42545,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42525,
		nil,
		1,
		nil,
		1,
		nil,
		42525,
		nil,
		nil,
		1
	},
	[42545002] = {
		42545002,
		0,
		Lang.get(114204),
		42545,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42545003] = {
		42545003,
		0,
		Lang.get(114205),
		42545,
		3,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[42545004] = {
		42545004,
		0,
		Lang.get(114206),
		42545,
		4,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[42545005] = {
		42545005,
		0,
		Lang.get(114207),
		42545,
		5,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42545006] = {
		42545006,
		0,
		Lang.get(114208),
		42545,
		6,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[42545007] = {
		42545007,
		0,
		Lang.get(114209),
		42545,
		7,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[42545008] = {
		42545008,
		0,
		Lang.get(114210),
		42545,
		8,
		772,
		{
			RTResTalkAction[4]
		}
	},
	[42523001] = {
		42523001,
		0,
		Lang.get(114211),
		42523,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		42526,
		nil,
		1,
		nil,
		1,
		nil,
		42526
	},
	[42523002] = {
		42523002,
		0,
		Lang.get(114212),
		42523,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42523003] = {
		42523003,
		0,
		Lang.get(114213),
		42523,
		3,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42523004] = {
		42523004,
		4,
		nil,
		42523,
		4,
		1298,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 42523005,
				branch_content = Lang.get(114214)
			},
			{
				id = 42523005,
				branch_content = Lang.get(114215)
			}
		}
	},
	[42523005] = {
		42523005,
		0,
		Lang.get(114216),
		42523,
		5,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42524001] = {
		42524001,
		9,
		Lang.get(114217),
		42524,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42527,
		nil,
		1,
		nil,
		1,
		nil,
		42527,
		nil,
		nil,
		1
	},
	[42524002] = {
		42524002,
		0,
		Lang.get(114218),
		42524,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42524003] = {
		42524003,
		0,
		Lang.get(114219),
		42524,
		3,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42524004] = {
		42524004,
		0,
		Lang.get(114220),
		42524,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42524005] = {
		42524005,
		0,
		Lang.get(114221),
		42524,
		5,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42524006] = {
		42524006,
		0,
		Lang.get(114222),
		42524,
		6,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42524007] = {
		42524007,
		0,
		Lang.get(114223),
		42524,
		7,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42524008] = {
		42524008,
		0,
		Lang.get(114224),
		42524,
		8,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42524009] = {
		42524009,
		9,
		Lang.get(114225),
		42524,
		9,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42528,
		nil,
		1,
		nil,
		1,
		nil,
		42528,
		nil,
		nil,
		1
	},
	[42524010] = {
		42524010,
		0,
		Lang.get(114226),
		42524,
		10,
		908,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[42524011] = {
		42524011,
		0,
		Lang.get(114227),
		42524,
		11,
		908,
		{
			RTResTalkAction[13]
		}
	},
	[42524012] = {
		42524012,
		0,
		Lang.get(114228),
		42524,
		12,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[14]
		}
	},
	[42524013] = {
		42524013,
		0,
		Lang.get(114229),
		42524,
		13,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42524014] = {
		42524014,
		0,
		Lang.get(114230),
		42524,
		14,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42524015] = {
		42524015,
		0,
		Lang.get(114231),
		42524,
		15,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42524016] = {
		42524016,
		0,
		Lang.get(114232),
		42524,
		16,
		908,
		{
			RTResTalkAction[13],
			RTResTalkAction[10]
		}
	},
	[42524017] = {
		42524017,
		0,
		Lang.get(114233),
		42524,
		17,
		908,
		{
			RTResTalkAction[13]
		}
	},
	[42524018] = {
		42524018,
		0,
		Lang.get(114234),
		42524,
		18,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[14]
		}
	},
	[42524019] = {
		42524019,
		0,
		Lang.get(114235),
		42524,
		19,
		909,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[42524020] = {
		42524020,
		0,
		Lang.get(114236),
		42524,
		20,
		909,
		{
			RTResTalkAction[15]
		}
	},
	[42524021] = {
		42524021,
		0,
		Lang.get(114237),
		42524,
		21,
		908,
		{
			RTResTalkAction[13],
			RTResTalkAction[16]
		}
	},
	[42524022] = {
		42524022,
		0,
		Lang.get(114238),
		42524,
		22,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[14]
		}
	},
	[42525001] = {
		42525001,
		9,
		Lang.get(114239),
		42525,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42529,
		nil,
		1,
		nil,
		1,
		nil,
		42529,
		nil,
		nil,
		1
	},
	[42525002] = {
		42525002,
		0,
		Lang.get(114240),
		42525,
		2,
		908,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[42525003] = {
		42525003,
		0,
		Lang.get(114241),
		42525,
		3,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[14]
		}
	},
	[42525004] = {
		42525004,
		0,
		Lang.get(114242),
		42525,
		4,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42525005] = {
		42525005,
		0,
		Lang.get(114243),
		42525,
		5,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42525006] = {
		42525006,
		0,
		Lang.get(114244),
		42525,
		6,
		908,
		{
			RTResTalkAction[13],
			RTResTalkAction[10]
		}
	},
	[42525007] = {
		42525007,
		0,
		Lang.get(114245),
		42525,
		7,
		909,
		{
			RTResTalkAction[15],
			RTResTalkAction[14]
		}
	},
	[42525008] = {
		42525008,
		0,
		Lang.get(114246),
		42525,
		8,
		908,
		{
			RTResTalkAction[13],
			RTResTalkAction[16]
		}
	},
	[42525009] = {
		42525009,
		0,
		Lang.get(114247),
		42525,
		9,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[14]
		}
	},
	[42525010] = {
		42525010,
		0,
		Lang.get(114248),
		42525,
		10,
		908,
		{
			RTResTalkAction[13],
			RTResTalkAction[10]
		}
	},
	[42525011] = {
		42525011,
		9,
		Lang.get(114249),
		42525,
		11,
		605,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42569,
		nil,
		1,
		nil,
		1,
		nil,
		42569,
		nil,
		nil,
		1
	},
	[42525012] = {
		42525012,
		0,
		Lang.get(114250),
		42525,
		12,
		908,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[42525013] = {
		42525013,
		0,
		Lang.get(114251),
		42525,
		13,
		908,
		{
			RTResTalkAction[13]
		}
	},
	[42525014] = {
		42525014,
		0,
		Lang.get(114252),
		42525,
		14,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[14]
		}
	},
	[42525015] = {
		42525015,
		0,
		Lang.get(114253),
		42525,
		15,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42525016] = {
		42525016,
		0,
		Lang.get(114254),
		42525,
		16,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[42525017] = {
		42525017,
		0,
		Lang.get(114255),
		42525,
		17,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[42525018] = {
		42525018,
		0,
		Lang.get(114256),
		42525,
		18,
		772,
		{
			RTResTalkAction[4]
		}
	},
	[42525019] = {
		42525019,
		0,
		Lang.get(114257),
		42525,
		19,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[42525020] = {
		42525020,
		0,
		Lang.get(114258),
		42525,
		20,
		909,
		{
			RTResTalkAction[15],
			RTResTalkAction[5]
		}
	},
	[42525021] = {
		42525021,
		0,
		Lang.get(114259),
		42525,
		21,
		909,
		{
			RTResTalkAction[15]
		}
	},
	[42525022] = {
		42525022,
		0,
		Lang.get(114260),
		42525,
		22,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[16]
		}
	},
	[42526001] = {
		42526001,
		0,
		Lang.get(114261),
		42526,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42530,
		nil,
		1,
		nil,
		1,
		nil,
		42530
	},
	[42526002] = {
		42526002,
		0,
		Lang.get(114262),
		42526,
		2,
		773,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[42526003] = {
		42526003,
		0,
		Lang.get(114263),
		42526,
		3,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42526004] = {
		42526004,
		0,
		Lang.get(114264),
		42526,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[42526005] = {
		42526005,
		0,
		Lang.get(114265),
		42526,
		5,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42526006] = {
		42526006,
		0,
		Lang.get(114266),
		42526,
		6,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42527001] = {
		42527001,
		9,
		Lang.get(114267),
		42527,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42531,
		nil,
		1,
		nil,
		1,
		nil,
		42531,
		nil,
		nil,
		1
	},
	[42527002] = {
		42527002,
		0,
		Lang.get(114268),
		42527,
		2,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42527003] = {
		42527003,
		0,
		Lang.get(114269),
		42527,
		3,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42527004] = {
		42527004,
		0,
		Lang.get(114270),
		42527,
		4,
		347,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		},
		1
	},
	[42527005] = {
		42527005,
		0,
		Lang.get(114271),
		42527,
		5,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42527006] = {
		42527006,
		9,
		Lang.get(114272),
		42527,
		6,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		2745,
		[22] = 1
	},
	[42527007] = {
		42527007,
		0,
		Lang.get(114273),
		42527,
		7,
		908,
		{
			RTResTalkAction[13]
		}
	},
	[42527008] = {
		42527008,
		0,
		Lang.get(114274),
		42527,
		8,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[14]
		}
	},
	[42527009] = {
		42527009,
		0,
		Lang.get(114275),
		42527,
		9,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42527010] = {
		42527010,
		0,
		Lang.get(114276),
		42527,
		10,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42527011] = {
		42527011,
		0,
		Lang.get(114277),
		42527,
		11,
		112,
		{
			RTResTalkAction[17],
			RTResTalkAction[20]
		}
	},
	[42527012] = {
		42527012,
		0,
		Lang.get(114278),
		42527,
		12,
		112,
		{
			RTResTalkAction[17],
			RTResTalkAction[20]
		}
	},
	[42527013] = {
		42527013,
		0,
		Lang.get(114279),
		42527,
		13,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[21]
		}
	},
	[42527014] = {
		42527014,
		0,
		Lang.get(114280),
		42527,
		14,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42527015] = {
		42527015,
		0,
		Lang.get(114281),
		42527,
		15,
		347,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		},
		1
	},
	[42527016] = {
		42527016,
		9,
		Lang.get(114217),
		42527,
		16,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		42532,
		nil,
		1,
		nil,
		1,
		nil,
		42532,
		nil,
		nil,
		1
	},
	[42527017] = {
		42527017,
		0,
		Lang.get(114282),
		42527,
		17,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42527018] = {
		42527018,
		0,
		Lang.get(114283),
		42527,
		18,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42527019] = {
		42527019,
		0,
		Lang.get(114284),
		42527,
		19,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42527020] = {
		42527020,
		0,
		Lang.get(114285),
		42527,
		20,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42527021] = {
		42527021,
		0,
		Lang.get(114286),
		42527,
		21,
		112,
		{
			RTResTalkAction[22],
			RTResTalkAction[10]
		}
	},
	[42527022] = {
		42527022,
		0,
		Lang.get(114287),
		42527,
		22,
		112,
		{
			RTResTalkAction[22]
		}
	},
	[42527023] = {
		42527023,
		0,
		Lang.get(114288),
		42527,
		23,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[42527024] = {
		42527024,
		0,
		Lang.get(114289),
		42527,
		24,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42528001] = {
		42528001,
		3,
		Lang.get(114290),
		42528,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42533,
		nil,
		1,
		nil,
		1,
		nil,
		42533,
		nil,
		nil,
		1
	},
	[42528002] = {
		42528002,
		0,
		Lang.get(114291),
		42528,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42528003] = {
		42528003,
		0,
		Lang.get(114292),
		42528,
		3,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42528004] = {
		42528004,
		0,
		Lang.get(114293),
		42528,
		4,
		112,
		{
			RTResTalkAction[22],
			RTResTalkAction[10]
		}
	},
	[42528005] = {
		42528005,
		0,
		Lang.get(114294),
		42528,
		5,
		112,
		{
			RTResTalkAction[22]
		}
	},
	[42528006] = {
		42528006,
		0,
		Lang.get(114295),
		42528,
		6,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[21]
		}
	},
	[42528007] = {
		42528007,
		0,
		Lang.get(114823),
		42528,
		7,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42528008] = {
		42528008,
		0,
		Lang.get(114297),
		42528,
		8,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42528009] = {
		42528009,
		0,
		Lang.get(114298),
		42528,
		9,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[10]
		}
	},
	[42528010] = {
		42528010,
		0,
		Lang.get(114299),
		42528,
		10,
		772,
		{
			RTResTalkAction[4]
		}
	},
	[42528011] = {
		42528011,
		0,
		Lang.get(114300),
		42528,
		11,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[42528012] = {
		42528012,
		0,
		Lang.get(114301),
		42528,
		12,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[42528013] = {
		42528013,
		0,
		Lang.get(114302),
		42528,
		13,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[42528014] = {
		42528014,
		3,
		Lang.get(114303),
		42528,
		14,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42534,
		nil,
		1,
		nil,
		1,
		nil,
		42534,
		nil,
		nil,
		1
	},
	[42528015] = {
		42528015,
		0,
		Lang.get(114304),
		42528,
		15,
		773,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[42528016] = {
		42528016,
		0,
		Lang.get(114305),
		42528,
		16,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[5]
		}
	},
	[42528017] = {
		42528017,
		0,
		Lang.get(114306),
		42528,
		17,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42528018] = {
		42528018,
		0,
		Lang.get(114307),
		42528,
		18,
		773,
		{
			RTResTalkAction[2]
		}
	},
	[42528019] = {
		42528019,
		0,
		Lang.get(114308),
		42528,
		19,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[5]
		}
	},
	[42528020] = {
		42528020,
		0,
		Lang.get(114309),
		42528,
		20,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[42528021] = {
		42528021,
		0,
		Lang.get(114310),
		42528,
		21,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42528022] = {
		42528022,
		0,
		Lang.get(114311),
		42528,
		22,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[5]
		}
	},
	[42528023] = {
		42528023,
		0,
		Lang.get(114824),
		42528,
		23,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[42529001] = {
		42529001,
		3,
		Lang.get(114313),
		42529,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42535,
		nil,
		1,
		nil,
		1,
		nil,
		42535,
		nil,
		nil,
		1
	},
	[42529002] = {
		42529002,
		0,
		Lang.get(114314),
		42529,
		2,
		148,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[42529003] = {
		42529003,
		0,
		Lang.get(114315),
		42529,
		3,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[24]
		}
	},
	[42529004] = {
		42529004,
		0,
		Lang.get(114316),
		42529,
		4,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[5]
		}
	},
	[42529005] = {
		42529005,
		0,
		Lang.get(114317),
		42529,
		5,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[42529006] = {
		42529006,
		0,
		Lang.get(114318),
		42529,
		6,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[42529007] = {
		42529007,
		0,
		Lang.get(114319),
		42529,
		7,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[42529008] = {
		42529008,
		0,
		Lang.get(114320),
		42529,
		8,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[42529009] = {
		42529009,
		0,
		Lang.get(114321),
		42529,
		9,
		107,
		{
			RTResTalkAction[25],
			RTResTalkAction[24]
		}
	},
	[42529010] = {
		42529010,
		0,
		Lang.get(114322),
		42529,
		10,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[42529011] = {
		42529011,
		0,
		Lang.get(114323),
		42529,
		11,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[42529012] = {
		42529012,
		3,
		Lang.get(114324),
		42529,
		12,
		605,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42536,
		nil,
		1,
		nil,
		1,
		nil,
		42536,
		nil,
		nil,
		1
	},
	[42529013] = {
		42529013,
		0,
		Lang.get(114325),
		42529,
		13,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42529014] = {
		42529014,
		0,
		Lang.get(114326),
		42529,
		14,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[42529015] = {
		42529015,
		0,
		Lang.get(114327),
		42529,
		15,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[42529016] = {
		42529016,
		0,
		Lang.get(114328),
		42529,
		16,
		112,
		{
			RTResTalkAction[22],
			RTResTalkAction[24]
		}
	},
	[42529017] = {
		42529017,
		0,
		Lang.get(114329),
		42529,
		17,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[21]
		}
	},
	[42529018] = {
		42529018,
		0,
		Lang.get(114330),
		42529,
		18,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[42529019] = {
		42529019,
		0,
		Lang.get(114331),
		42529,
		19,
		148,
		{
			RTResTalkAction[23]
		}
	},
	[42530001] = {
		42530001,
		3,
		Lang.get(114332),
		42530,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42537,
		nil,
		1,
		nil,
		1,
		nil,
		42537,
		nil,
		nil,
		1
	},
	[42530002] = {
		42530002,
		0,
		Lang.get(114333),
		42530,
		2,
		257,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[42530003] = {
		42530003,
		0,
		Lang.get(114334),
		42530,
		3,
		257,
		{
			RTResTalkAction[26]
		}
	},
	[42530004] = {
		42530004,
		0,
		Lang.get(114335),
		42530,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[27]
		}
	},
	[42530005] = {
		42530005,
		0,
		Lang.get(114336),
		42530,
		5,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42530006] = {
		42530006,
		0,
		Lang.get(114337),
		42530,
		6,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42530007] = {
		42530007,
		0,
		Lang.get(114338),
		42530,
		7,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[10]
		}
	},
	[42530008] = {
		42530008,
		0,
		Lang.get(114339),
		42530,
		8,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[42530009] = {
		42530009,
		0,
		Lang.get(114340),
		42530,
		9,
		148,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[42530010] = {
		42530010,
		0,
		Lang.get(114341),
		42530,
		10,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[24]
		}
	},
	[42530011] = {
		42530011,
		3,
		Lang.get(100843),
		42530,
		11,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42538,
		nil,
		1,
		nil,
		1,
		nil,
		42538,
		nil,
		nil,
		1
	},
	[42530012] = {
		42530012,
		0,
		Lang.get(114342),
		42530,
		12,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42530013] = {
		42530013,
		0,
		Lang.get(114343),
		42530,
		13,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[10]
		}
	},
	[42530014] = {
		42530014,
		0,
		Lang.get(114344),
		42530,
		14,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[27]
		}
	},
	[42530015] = {
		42530015,
		0,
		Lang.get(114345),
		42530,
		15,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42530016] = {
		42530016,
		0,
		Lang.get(114825),
		42530,
		16,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42530017] = {
		42530017,
		0,
		Lang.get(114347),
		42530,
		17,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[10]
		}
	},
	[42530018] = {
		42530018,
		0,
		Lang.get(114348),
		42530,
		18,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[27]
		}
	},
	[42530019] = {
		42530019,
		0,
		Lang.get(114349),
		42530,
		19,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42530020] = {
		42530020,
		0,
		Lang.get(114350),
		42530,
		20,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42531001] = {
		42531001,
		0,
		Lang.get(114351),
		42531,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42539,
		nil,
		1,
		nil,
		1,
		nil,
		42539
	},
	[42531002] = {
		42531002,
		0,
		Lang.get(114352),
		42531,
		2,
		257,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[42531003] = {
		42531003,
		0,
		Lang.get(114353),
		42531,
		3,
		257,
		{
			RTResTalkAction[26]
		}
	},
	[42531004] = {
		42531004,
		0,
		Lang.get(114354),
		42531,
		4,
		1299,
		{
			RTResTalkAction[27]
		},
		1
	},
	[42531005] = {
		42531005,
		0,
		Lang.get(114355),
		42531,
		5,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		42540,
		nil,
		1,
		nil,
		1,
		nil,
		42540
	},
	[42531006] = {
		42531006,
		0,
		Lang.get(114356),
		42531,
		6,
		1299,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42531007] = {
		42531007,
		7,
		"125",
		42531,
		7,
		1299,
		{
			RTResTalkAction[29]
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
	[42531008] = {
		42531008,
		0,
		Lang.get(114357),
		42531,
		8,
		1299,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42531009] = {
		42531009,
		0,
		Lang.get(114358),
		42531,
		9,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42531010] = {
		42531010,
		0,
		Lang.get(114359),
		42531,
		10,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[29]
		}
	},
	[42531011] = {
		42531011,
		0,
		Lang.get(114360),
		42531,
		11,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42531012] = {
		42531012,
		0,
		Lang.get(114361),
		42531,
		12,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42531013] = {
		42531013,
		0,
		Lang.get(114362),
		42531,
		13,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[42531014] = {
		42531014,
		0,
		Lang.get(114363),
		42531,
		14,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[27]
		}
	},
	[42531015] = {
		42531015,
		0,
		Lang.get(114364),
		42531,
		15,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[29]
		}
	},
	[42531016] = {
		42531016,
		0,
		Lang.get(114365),
		42531,
		16,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42532001] = {
		42532001,
		0,
		Lang.get(114366),
		42532,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42541,
		nil,
		1,
		nil,
		1,
		nil,
		42541
	},
	[42532002] = {
		42532002,
		0,
		Lang.get(114367),
		42532,
		2,
		1299,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42532003] = {
		42532003,
		0,
		Lang.get(114368),
		42532,
		3,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[29]
		}
	},
	[42532004] = {
		42532004,
		0,
		Lang.get(114369),
		42532,
		4,
		257,
		{
			RTResTalkAction[26]
		}
	},
	[42532005] = {
		42532005,
		0,
		Lang.get(114370),
		42532,
		5,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[27]
		}
	},
	[42532006] = {
		42532006,
		0,
		Lang.get(114371),
		42532,
		6,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[29]
		}
	},
	[42532007] = {
		42532007,
		0,
		Lang.get(114372),
		42532,
		7,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42532008] = {
		42532008,
		0,
		Lang.get(114373),
		42532,
		8,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[31]
		}
	},
	[42532009] = {
		42532009,
		0,
		Lang.get(114374),
		42532,
		9,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[27]
		}
	},
	[42532010] = {
		42532010,
		3,
		Lang.get(114375),
		42532,
		10,
		605,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42542,
		nil,
		1,
		nil,
		1,
		nil,
		42542,
		nil,
		nil,
		1
	},
	[42532011] = {
		42532011,
		0,
		Lang.get(114376),
		42532,
		11,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42532012] = {
		42532012,
		0,
		Lang.get(114377),
		42532,
		12,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42532013] = {
		42532013,
		0,
		Lang.get(114378),
		42532,
		13,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42532014] = {
		42532014,
		0,
		Lang.get(114379),
		42532,
		14,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42532015] = {
		42532015,
		0,
		Lang.get(114380),
		42532,
		15,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42532016] = {
		42532016,
		0,
		Lang.get(114381),
		42532,
		16,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42532017] = {
		42532017,
		0,
		Lang.get(114382),
		42532,
		17,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42532018] = {
		42532018,
		3,
		Lang.get(114383),
		42532,
		18,
		605,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42543,
		nil,
		1,
		nil,
		1,
		nil,
		42543,
		nil,
		nil,
		1
	},
	[42532019] = {
		42532019,
		0,
		Lang.get(114384),
		42532,
		19,
		257,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[42532020] = {
		42532020,
		0,
		Lang.get(114385),
		42532,
		20,
		1118,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[42532021] = {
		42532021,
		0,
		Lang.get(114386),
		42532,
		21,
		257,
		{
			RTResTalkAction[33],
			RTResTalkAction[34]
		}
	},
	[42532022] = {
		42532022,
		0,
		Lang.get(114387),
		42532,
		22,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[27]
		}
	},
	[42533001] = {
		42533001,
		3,
		Lang.get(114388),
		42533,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		42544,
		nil,
		1,
		nil,
		1,
		nil,
		42544,
		nil,
		nil,
		1
	},
	[42533002] = {
		42533002,
		0,
		Lang.get(114389),
		42533,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42533003] = {
		42533003,
		0,
		Lang.get(114390),
		42533,
		3,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42533004] = {
		42533004,
		0,
		Lang.get(114391),
		42533,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42533005] = {
		42533005,
		0,
		Lang.get(114392),
		42533,
		5,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42533006] = {
		42533006,
		0,
		Lang.get(114393),
		42533,
		6,
		107,
		{
			RTResTalkAction[31]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42545,
		nil,
		1,
		nil,
		1,
		nil,
		42545
	},
	[42533007] = {
		42533007,
		0,
		Lang.get(114394),
		42533,
		7,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42533008] = {
		42533008,
		0,
		Lang.get(114395),
		42533,
		8,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42533009] = {
		42533009,
		0,
		Lang.get(114396),
		42533,
		9,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42533010] = {
		42533010,
		0,
		Lang.get(114397),
		42533,
		10,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42533011] = {
		42533011,
		0,
		Lang.get(114398),
		42533,
		11,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[3]
		}
	},
	[42533012] = {
		42533012,
		0,
		Lang.get(114399),
		42533,
		12,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42533013] = {
		42533013,
		0,
		Lang.get(114400),
		42533,
		13,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42533014] = {
		42533014,
		0,
		Lang.get(114401),
		42533,
		14,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42533015] = {
		42533015,
		0,
		Lang.get(114402),
		42533,
		15,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42533016] = {
		42533016,
		0,
		Lang.get(114403),
		42533,
		16,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42533017] = {
		42533017,
		0,
		Lang.get(114404),
		42533,
		17,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[10]
		}
	},
	[42533018] = {
		42533018,
		0,
		Lang.get(114405),
		42533,
		18,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[3]
		}
	},
	[42533019] = {
		42533019,
		0,
		Lang.get(114406),
		42533,
		19,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42533020] = {
		42533020,
		0,
		Lang.get(114407),
		42533,
		20,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42533021] = {
		42533021,
		0,
		Lang.get(114235),
		42533,
		21,
		909,
		{
			RTResTalkAction[15],
			RTResTalkAction[10]
		}
	},
	[42533022] = {
		42533022,
		0,
		Lang.get(114408),
		42533,
		22,
		909,
		{
			RTResTalkAction[15]
		}
	},
	[42534001] = {
		42534001,
		3,
		Lang.get(114409),
		42534,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		42546,
		nil,
		1,
		nil,
		1,
		nil,
		42546,
		nil,
		nil,
		1
	},
	[42534002] = {
		42534002,
		0,
		Lang.get(114410),
		42534,
		2,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[42534003] = {
		42534003,
		0,
		Lang.get(114411),
		42534,
		3,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[42534004] = {
		42534004,
		0,
		Lang.get(114412),
		42534,
		4,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[3]
		}
	},
	[42534005] = {
		42534005,
		0,
		Lang.get(114413),
		42534,
		5,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42534006] = {
		42534006,
		0,
		Lang.get(114414),
		42534,
		6,
		220,
		{
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42547,
		nil,
		1,
		nil,
		1,
		nil,
		42547
	},
	[42534007] = {
		42534007,
		0,
		Lang.get(114415),
		42534,
		7,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42534008] = {
		42534008,
		0,
		Lang.get(114416),
		42534,
		8,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534009] = {
		42534009,
		0,
		Lang.get(114417),
		42534,
		9,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534010] = {
		42534010,
		0,
		Lang.get(114418),
		42534,
		10,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534011] = {
		42534011,
		0,
		Lang.get(114419),
		42534,
		11,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534012] = {
		42534012,
		0,
		Lang.get(114420),
		42534,
		12,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534013] = {
		42534013,
		0,
		Lang.get(114421),
		42534,
		13,
		1298,
		{
			RTResTalkAction[17],
			RTResTalkAction[32]
		}
	},
	[42534014] = {
		42534014,
		2,
		Lang.get(114422),
		42534,
		14,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42534015] = {
		42534015,
		5,
		Lang.get(114423),
		42534,
		15,
		107,
		{
			RTResTalkAction[31]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42548,
		nil,
		1,
		nil,
		1,
		nil,
		42548
	},
	[42534016] = {
		42534016,
		0,
		Lang.get(114424),
		42534,
		16,
		910,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3
	},
	[42534017] = {
		42534017,
		0,
		Lang.get(114425),
		42534,
		17,
		911,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[42534018] = {
		42534018,
		0,
		Lang.get(114426),
		42534,
		18,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[42534019] = {
		42534019,
		0,
		Lang.get(114427),
		42534,
		19,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[42534020] = {
		42534020,
		0,
		Lang.get(114428),
		42534,
		20,
		910,
		{
			RTResTalkAction[36]
		}
	},
	[42534021] = {
		42534021,
		0,
		Lang.get(114429),
		42534,
		21,
		911,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[42534022] = {
		42534022,
		0,
		Lang.get(114430),
		42534,
		22,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[42535001] = {
		42535001,
		0,
		Lang.get(114431),
		42535,
		1,
		911,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		42549,
		nil,
		1,
		nil,
		1,
		nil,
		42549
	},
	[42535002] = {
		42535002,
		0,
		Lang.get(114432),
		42535,
		2,
		911,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[42535003] = {
		42535003,
		0,
		Lang.get(114433),
		42535,
		3,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535004] = {
		42535004,
		0,
		Lang.get(114434),
		42535,
		4,
		910,
		{
			RTResTalkAction[36]
		}
	},
	[42535005] = {
		42535005,
		0,
		Lang.get(114435),
		42535,
		5,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535006] = {
		42535006,
		0,
		Lang.get(114436),
		42535,
		6,
		911,
		{
			RTResTalkAction[41]
		}
	},
	[42535007] = {
		42535007,
		0,
		Lang.get(114437),
		42535,
		7,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535008] = {
		42535008,
		0,
		Lang.get(114438),
		42535,
		8,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535009] = {
		42535009,
		0,
		Lang.get(114439),
		42535,
		9,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535010] = {
		42535010,
		0,
		Lang.get(114440),
		42535,
		10,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535011] = {
		42535011,
		3,
		Lang.get(114441),
		42535,
		11,
		605,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42550,
		nil,
		1,
		nil,
		1,
		nil,
		42550,
		nil,
		nil,
		1
	},
	[42535012] = {
		42535012,
		0,
		Lang.get(114442),
		42535,
		12,
		911,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[42535013] = {
		42535013,
		0,
		Lang.get(114443),
		42535,
		13,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535014] = {
		42535014,
		0,
		Lang.get(114444),
		42535,
		14,
		910,
		{
			RTResTalkAction[36]
		}
	},
	[42535015] = {
		42535015,
		0,
		Lang.get(114445),
		42535,
		15,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535016] = {
		42535016,
		0,
		Lang.get(114446),
		42535,
		16,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535017] = {
		42535017,
		0,
		Lang.get(114447),
		42535,
		17,
		910,
		{
			RTResTalkAction[36]
		}
	},
	[42535018] = {
		42535018,
		0,
		Lang.get(114448),
		42535,
		18,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535019] = {
		42535019,
		0,
		Lang.get(114449),
		42535,
		19,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[40]
		}
	},
	[42535020] = {
		42535020,
		0,
		Lang.get(114450),
		42535,
		20,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42535021] = {
		42535021,
		0,
		Lang.get(114451),
		42535,
		21,
		911,
		{
			RTResTalkAction[41]
		}
	},
	[42535022] = {
		42535022,
		0,
		Lang.get(114452),
		42535,
		22,
		912,
		{
			RTResTalkAction[42],
			RTResTalkAction[40]
		}
	},
	[42536001] = {
		42536001,
		3,
		Lang.get(112137),
		42536,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42570,
		nil,
		1,
		nil,
		nil,
		1,
		42570,
		nil,
		nil,
		1
	},
	[42536002] = {
		42536002,
		0,
		Lang.get(114453),
		42536,
		2,
		912,
		{
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[42536003] = {
		42536003,
		0,
		Lang.get(114454),
		42536,
		3,
		913,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[42536004] = {
		42536004,
		0,
		Lang.get(114455),
		42536,
		4,
		910,
		{
			RTResTalkAction[36],
			RTResTalkAction[45]
		}
	},
	[42536005] = {
		42536005,
		0,
		Lang.get(114456),
		42536,
		5,
		911,
		{
			RTResTalkAction[41],
			RTResTalkAction[39]
		}
	},
	[42537001] = {
		42537001,
		0,
		Lang.get(114457),
		42537,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42551,
		nil,
		1,
		nil,
		1,
		nil,
		42551
	},
	[42537002] = {
		42537002,
		0,
		Lang.get(114458),
		42537,
		2,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42537003] = {
		42537003,
		0,
		Lang.get(114459),
		42537,
		3,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42537004] = {
		42537004,
		3,
		Lang.get(114460),
		42537,
		4,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42552,
		nil,
		1,
		nil,
		1,
		nil,
		42552,
		nil,
		nil,
		1
	},
	[42537005] = {
		42537005,
		0,
		Lang.get(114461),
		42537,
		5,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42537006] = {
		42537006,
		0,
		Lang.get(114462),
		42537,
		6,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42537007] = {
		42537007,
		0,
		Lang.get(114463),
		42537,
		7,
		912,
		{
			RTResTalkAction[42],
			RTResTalkAction[10]
		}
	},
	[42537008] = {
		42537008,
		0,
		Lang.get(114464),
		42537,
		8,
		912,
		{
			RTResTalkAction[42]
		}
	},
	[42537009] = {
		42537009,
		0,
		Lang.get(114465),
		42537,
		9,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[44]
		}
	},
	[42537010] = {
		42537010,
		0,
		Lang.get(114466),
		42537,
		10,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42537011] = {
		42537011,
		0,
		Lang.get(114467),
		42537,
		11,
		913,
		{
			RTResTalkAction[43],
			RTResTalkAction[10]
		}
	},
	[42537012] = {
		42537012,
		0,
		Lang.get(114468),
		42537,
		12,
		220,
		{
			RTResTalkAction[46],
			RTResTalkAction[45]
		}
	},
	[42537013] = {
		42537013,
		3,
		Lang.get(114469),
		42537,
		13,
		605,
		{
			RTResTalkAction[31]
		},
		[22] = 1
	},
	[42537014] = {
		42537014,
		0,
		Lang.get(114470),
		42537,
		14,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		42553,
		nil,
		1,
		nil,
		1,
		nil,
		42553
	},
	[42537015] = {
		42537015,
		0,
		Lang.get(114471),
		42537,
		15,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42537016] = {
		42537016,
		0,
		Lang.get(114472),
		42537,
		16,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42537017] = {
		42537017,
		0,
		Lang.get(114473),
		42537,
		17,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42537018] = {
		42537018,
		0,
		Lang.get(114474),
		42537,
		18,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42538001] = {
		42538001,
		0,
		Lang.get(114475),
		42538,
		1,
		1298,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42554,
		nil,
		1,
		nil,
		1,
		nil,
		42554
	},
	[42538002] = {
		42538002,
		0,
		Lang.get(114476),
		42538,
		2,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42538003] = {
		42538003,
		0,
		Lang.get(114477),
		42538,
		3,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[31]
		}
	},
	[42538004] = {
		42538004,
		0,
		Lang.get(114478),
		42538,
		4,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42538005] = {
		42538005,
		0,
		Lang.get(114479),
		42538,
		5,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42538006] = {
		42538006,
		0,
		Lang.get(114480),
		42538,
		6,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42538007] = {
		42538007,
		3,
		Lang.get(114481),
		42538,
		7,
		605,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42555,
		nil,
		1,
		nil,
		1,
		nil,
		42555,
		nil,
		nil,
		1
	},
	[42538008] = {
		42538008,
		0,
		Lang.get(114482),
		42538,
		8,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42538009] = {
		42538009,
		0,
		Lang.get(114483),
		42538,
		9,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42538010] = {
		42538010,
		0,
		Lang.get(114484),
		42538,
		10,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42538011] = {
		42538011,
		0,
		Lang.get(114485),
		42538,
		11,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42538012] = {
		42538012,
		0,
		Lang.get(114486),
		42538,
		12,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42538013] = {
		42538013,
		0,
		Lang.get(114487),
		42538,
		13,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42538014] = {
		42538014,
		0,
		Lang.get(114488),
		42538,
		14,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42538015] = {
		42538015,
		0,
		Lang.get(114489),
		42538,
		15,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42538016] = {
		42538016,
		0,
		Lang.get(114490),
		42538,
		16,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[31]
		}
	},
	[42538017] = {
		42538017,
		0,
		Lang.get(114491),
		42538,
		17,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[42538018] = {
		42538018,
		0,
		Lang.get(114492),
		42538,
		18,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42538019] = {
		42538019,
		0,
		Lang.get(114493),
		42538,
		19,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42538020] = {
		42538020,
		0,
		Lang.get(114494),
		42538,
		20,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42538021] = {
		42538021,
		0,
		Lang.get(114495),
		42538,
		21,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42539001] = {
		42539001,
		3,
		Lang.get(114290),
		42539,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42556,
		nil,
		1,
		nil,
		1,
		nil,
		42556,
		nil,
		nil,
		1
	},
	[42539002] = {
		42539002,
		0,
		Lang.get(114496),
		42539,
		2,
		220,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[42539003] = {
		42539003,
		0,
		Lang.get(114497),
		42539,
		3,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42539004] = {
		42539004,
		0,
		Lang.get(114498),
		42539,
		4,
		257,
		{
			RTResTalkAction[26],
			RTResTalkAction[10]
		}
	},
	[42539005] = {
		42539005,
		0,
		Lang.get(114499),
		42539,
		5,
		257,
		{
			RTResTalkAction[26]
		}
	},
	[42539006] = {
		42539006,
		0,
		Lang.get(114500),
		42539,
		6,
		257,
		{
			RTResTalkAction[26]
		}
	},
	[42539007] = {
		42539007,
		0,
		Lang.get(114501),
		42539,
		7,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[27]
		}
	},
	[42539008] = {
		42539008,
		0,
		Lang.get(114502),
		42539,
		8,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42539009] = {
		42539009,
		0,
		Lang.get(114503),
		42539,
		9,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[42539010] = {
		42539010,
		3,
		Lang.get(114504),
		42539,
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
		42557,
		nil,
		1,
		nil,
		1,
		nil,
		42557,
		nil,
		nil,
		1
	},
	[42539011] = {
		42539011,
		0,
		Lang.get(114505),
		42539,
		11,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42539012] = {
		42539012,
		4,
		nil,
		42539,
		12,
		1298,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 42539013,
				branch_content = Lang.get(114506)
			},
			{
				id = 42539013,
				branch_content = Lang.get(114507)
			}
		}
	},
	[42539013] = {
		42539013,
		0,
		Lang.get(114508),
		42539,
		13,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[42539014] = {
		42539014,
		0,
		Lang.get(114509),
		42539,
		14,
		141,
		{
			RTResTalkAction[47],
			RTResTalkAction[3]
		}
	},
	[42539015] = {
		42539015,
		0,
		Lang.get(114510),
		42539,
		15,
		773,
		{
			RTResTalkAction[2],
			RTResTalkAction[48]
		}
	},
	[42539016] = {
		42539016,
		0,
		Lang.get(114511),
		42539,
		16,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42539017] = {
		42539017,
		0,
		Lang.get(114512),
		42539,
		17,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[7]
		}
	},
	[42539018] = {
		42539018,
		0,
		Lang.get(114513),
		42539,
		18,
		772,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[42539019] = {
		42539019,
		0,
		Lang.get(114514),
		42539,
		19,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[7]
		}
	},
	[42539020] = {
		42539020,
		0,
		Lang.get(114515),
		42539,
		20,
		133,
		{
			RTResTalkAction[49],
			RTResTalkAction[10]
		}
	},
	[42539021] = {
		42539021,
		0,
		Lang.get(114516),
		42539,
		21,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[50]
		}
	},
	[42539022] = {
		42539022,
		0,
		Lang.get(114517),
		42539,
		22,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42540001] = {
		42540001,
		3,
		Lang.get(114518),
		42540,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42558,
		nil,
		1,
		nil,
		1,
		nil,
		42558,
		nil,
		nil,
		1
	},
	[42540002] = {
		42540002,
		0,
		Lang.get(114519),
		42540,
		2,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42540003] = {
		42540003,
		0,
		Lang.get(114520),
		42540,
		3,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42540004] = {
		42540004,
		4,
		nil,
		42540,
		4,
		220,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 42540005,
				branch_content = Lang.get(114521)
			}
		}
	},
	[42540005] = {
		42540005,
		0,
		Lang.get(114522),
		42540,
		5,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42540006] = {
		42540006,
		0,
		Lang.get(114523),
		42540,
		6,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42540007] = {
		42540007,
		0,
		Lang.get(114524),
		42540,
		7,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42540008] = {
		42540008,
		0,
		Lang.get(114525),
		42540,
		8,
		1298,
		{
			RTResTalkAction[31]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42559,
		nil,
		1,
		nil,
		1,
		nil,
		42559
	},
	[42540009] = {
		42540009,
		0,
		Lang.get(114526),
		42540,
		9,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42540010] = {
		42540010,
		0,
		Lang.get(114527),
		42540,
		10,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42540011] = {
		42540011,
		4,
		nil,
		42540,
		11,
		220,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 42540012,
				branch_content = Lang.get(27995)
			},
			{
				id = 42540012,
				branch_content = Lang.get(114528)
			}
		}
	},
	[42540012] = {
		42540012,
		0,
		Lang.get(114529),
		42540,
		12,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42540013] = {
		42540013,
		0,
		Lang.get(114530),
		42540,
		13,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42540014] = {
		42540014,
		0,
		Lang.get(114531),
		42540,
		14,
		220,
		{
			RTResTalkAction[30],
			RTResTalkAction[10]
		}
	},
	[42540015] = {
		42540015,
		0,
		Lang.get(114826),
		42540,
		15,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42540016] = {
		42540016,
		4,
		nil,
		42540,
		16,
		220,
		{
			RTResTalkAction[30]
		},
		[29] = {
			{
				id = 42540017,
				branch_content = Lang.get(114533)
			},
			{
				id = 42540017,
				branch_content = Lang.get(114534)
			}
		}
	},
	[42540017] = {
		42540017,
		0,
		Lang.get(114535),
		42540,
		17,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42540018] = {
		42540018,
		0,
		Lang.get(114536),
		42540,
		18,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42540019] = {
		42540019,
		0,
		Lang.get(114537),
		42540,
		19,
		300,
		{
			RTResTalkAction[10]
		}
	},
	[42540020] = {
		42540020,
		0,
		Lang.get(114538),
		42540,
		20,
		220,
		{
			RTResTalkAction[30]
		}
	},
	[42540021] = {
		42540021,
		0,
		Lang.get(114539),
		42540,
		21,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[31]
		}
	},
	[42541001] = {
		42541001,
		3,
		Lang.get(114290),
		42541,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42560,
		nil,
		1,
		nil,
		1,
		nil,
		42560,
		nil,
		nil,
		1
	},
	[42541002] = {
		42541002,
		0,
		Lang.get(114540),
		42541,
		2,
		1118,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42541003] = {
		42541003,
		0,
		Lang.get(114541),
		42541,
		3,
		1118,
		{
			RTResTalkAction[35]
		}
	},
	[42541004] = {
		42541004,
		0,
		Lang.get(114542),
		42541,
		4,
		1233,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[42541005] = {
		42541005,
		0,
		Lang.get(114543),
		42541,
		5,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[53]
		}
	},
	[42541006] = {
		42541006,
		0,
		Lang.get(114544),
		42541,
		6,
		1233,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[42541007] = {
		42541007,
		0,
		Lang.get(114545),
		42541,
		7,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[53]
		}
	},
	[42541008] = {
		42541008,
		0,
		Lang.get(114546),
		42541,
		8,
		1118,
		{
			RTResTalkAction[35]
		}
	},
	[42541009] = {
		42541009,
		0,
		Lang.get(114547),
		42541,
		9,
		1118,
		{
			RTResTalkAction[35]
		}
	},
	[42541010] = {
		42541010,
		0,
		Lang.get(114548),
		42541,
		10,
		1233,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[42541011] = {
		42541011,
		0,
		Lang.get(114549),
		42541,
		11,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[53]
		}
	},
	[42541012] = {
		42541012,
		0,
		Lang.get(114550),
		42541,
		12,
		1118,
		{
			RTResTalkAction[52]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42561,
		nil,
		1,
		nil,
		1,
		nil,
		42561
	},
	[42541013] = {
		42541013,
		0,
		Lang.get(114551),
		42541,
		13,
		1118,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42541014] = {
		42541014,
		0,
		Lang.get(114552),
		42541,
		14,
		1233,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[42541015] = {
		42541015,
		0,
		Lang.get(114553),
		42541,
		15,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[53]
		}
	},
	[42541016] = {
		42541016,
		0,
		Lang.get(114554),
		42541,
		16,
		914,
		{
			RTResTalkAction[52]
		},
		1
	},
	[42541017] = {
		42541017,
		0,
		Lang.get(114555),
		42541,
		17,
		1118,
		{
			RTResTalkAction[35]
		}
	},
	[42541018] = {
		42541018,
		0,
		Lang.get(114556),
		42541,
		18,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[52]
		}
	},
	[42541019] = {
		42541019,
		0,
		Lang.get(114557),
		42541,
		19,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[29]
		}
	},
	[42541020] = {
		42541020,
		0,
		Lang.get(114558),
		42541,
		20,
		1299,
		{
			RTResTalkAction[52]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42562,
		nil,
		1,
		nil,
		1,
		nil,
		42562
	},
	[42541021] = {
		42541021,
		0,
		Lang.get(114559),
		42541,
		21,
		1118,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42541022] = {
		42541022,
		0,
		Lang.get(114560),
		42541,
		22,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[52]
		}
	},
	[42541023] = {
		42541023,
		0,
		Lang.get(114561),
		42541,
		23,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[29]
		}
	},
	[42541024] = {
		42541024,
		0,
		Lang.get(114562),
		42541,
		24,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[52]
		}
	},
	[42541025] = {
		42541025,
		0,
		Lang.get(114563),
		42541,
		25,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[29]
		}
	},
	[42541026] = {
		42541026,
		0,
		Lang.get(114564),
		42541,
		26,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[52]
		}
	},
	[42541027] = {
		42541027,
		0,
		Lang.get(114565),
		42541,
		27,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[29]
		}
	},
	[42541028] = {
		42541028,
		0,
		Lang.get(114566),
		42541,
		28,
		1118,
		{
			RTResTalkAction[52]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42563,
		nil,
		1,
		nil,
		1,
		nil,
		42563
	},
	[42541029] = {
		42541029,
		0,
		Lang.get(114567),
		42541,
		29,
		1118,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[42541030] = {
		42541030,
		0,
		Lang.get(114568),
		42541,
		30,
		1233,
		{
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[42541031] = {
		42541031,
		0,
		Lang.get(114569),
		42541,
		31,
		1233,
		{
			RTResTalkAction[51]
		}
	},
	[42542001] = {
		42542001,
		3,
		Lang.get(114570),
		42542,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42564,
		nil,
		1,
		nil,
		1,
		nil,
		42564,
		nil,
		nil,
		1
	},
	[42542002] = {
		42542002,
		3,
		Lang.get(91190),
		42542,
		2,
		605,
		[22] = 1
	},
	[42542003] = {
		42542003,
		0,
		Lang.get(114571),
		42542,
		3,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42542004] = {
		42542004,
		0,
		Lang.get(114572),
		42542,
		4,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42542005] = {
		42542005,
		0,
		Lang.get(114573),
		42542,
		5,
		1199,
		{
			RTResTalkAction[54],
			RTResTalkAction[10]
		}
	},
	[42542006] = {
		42542006,
		0,
		Lang.get(114574),
		42542,
		6,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[55]
		}
	},
	[42542007] = {
		42542007,
		0,
		Lang.get(114575),
		42542,
		7,
		1199,
		{
			RTResTalkAction[54],
			RTResTalkAction[10]
		}
	},
	[42542008] = {
		42542008,
		0,
		Lang.get(114576),
		42542,
		8,
		1300,
		{
			RTResTalkAction[56],
			RTResTalkAction[55]
		}
	},
	[42542009] = {
		42542009,
		0,
		Lang.get(114577),
		42542,
		9,
		1298,
		{
			RTResTalkAction[57]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		42565,
		nil,
		1,
		nil,
		1,
		nil,
		42565
	},
	[42542010] = {
		42542010,
		0,
		Lang.get(114578),
		42542,
		10,
		1300,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[42542011] = {
		42542011,
		0,
		Lang.get(114579),
		42542,
		11,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[57]
		}
	},
	[42542012] = {
		42542012,
		0,
		Lang.get(114580),
		42542,
		12,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42542013] = {
		42542013,
		0,
		Lang.get(114581),
		42542,
		13,
		1300,
		{
			RTResTalkAction[56],
			RTResTalkAction[10]
		}
	},
	[42542014] = {
		42542014,
		3,
		Lang.get(114582),
		42542,
		14,
		605,
		{
			RTResTalkAction[57]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42571,
		nil,
		1,
		nil,
		1,
		nil,
		42571,
		nil,
		nil,
		1
	},
	[42542015] = {
		42542015,
		0,
		Lang.get(114583),
		42542,
		15,
		1298,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[42542016] = {
		42542016,
		0,
		Lang.get(114584),
		42542,
		16,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[42542017] = {
		42542017,
		0,
		Lang.get(114585),
		42542,
		17,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[29]
		}
	},
	[42542018] = {
		42542018,
		0,
		Lang.get(114586),
		42542,
		18,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42542019] = {
		42542019,
		0,
		Lang.get(114587),
		42542,
		19,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[42542020] = {
		42542020,
		0,
		Lang.get(114588),
		42542,
		20,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[29]
		}
	},
	[42542021] = {
		42542021,
		0,
		Lang.get(114589),
		42542,
		21,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[42542022] = {
		42542022,
		0,
		Lang.get(114590),
		42542,
		22,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42542023] = {
		42542023,
		0,
		Lang.get(114591),
		42542,
		23,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42542024] = {
		42542024,
		0,
		Lang.get(114592),
		42542,
		24,
		1118,
		{
			RTResTalkAction[35],
			RTResTalkAction[29]
		}
	},
	[42542025] = {
		42542025,
		0,
		Lang.get(114593),
		42542,
		25,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[52]
		}
	},
	[42542026] = {
		42542026,
		0,
		Lang.get(114594),
		42542,
		26,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[42542027] = {
		42542027,
		0,
		Lang.get(114595),
		42542,
		27,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42542028] = {
		42542028,
		0,
		Lang.get(114596),
		42542,
		28,
		1298,
		{
			RTResTalkAction[9],
			RTResTalkAction[29]
		}
	},
	[42542029] = {
		42542029,
		0,
		Lang.get(114597),
		42542,
		29,
		1298,
		{
			RTResTalkAction[9]
		}
	},
	[42542030] = {
		42542030,
		0,
		Lang.get(114598),
		42542,
		30,
		1299,
		{
			RTResTalkAction[28],
			RTResTalkAction[10]
		}
	},
	[42543001] = {
		42543001,
		9,
		Lang.get(114599),
		42543,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		nil,
		nil,
		1,
		[19] = 42566,
		[22] = 1
	},
	[42543002] = {
		42543002,
		0,
		Lang.get(114600),
		42543,
		2,
		1299,
		nil,
		1
	},
	[42543003] = {
		42543003,
		0,
		Lang.get(114601),
		42543,
		3,
		1298,
		nil,
		1
	},
	[42543004] = {
		42543004,
		0,
		Lang.get(114602),
		42543,
		4,
		1299,
		nil,
		1
	},
	[42543005] = {
		42543005,
		0,
		Lang.get(114603),
		42543,
		5,
		1298,
		nil,
		1
	},
	[42543006] = {
		42543006,
		0,
		Lang.get(114604),
		42543,
		6,
		1299,
		nil,
		1
	},
	[42543007] = {
		42543007,
		9,
		Lang.get(89669),
		42543,
		7,
		605,
		nil,
		nil,
		nil,
		nil,
		1222,
		[22] = 1
	},
	[42543008] = {
		42543008,
		9,
		Lang.get(114605),
		42543,
		8,
		605,
		[22] = 1
	},
	[42544001] = {
		42544001,
		3,
		Lang.get(114606),
		42544,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42567,
		nil,
		1,
		nil,
		1,
		nil,
		42567,
		nil,
		nil,
		1
	},
	[42544002] = {
		42544002,
		0,
		Lang.get(114607),
		42544,
		2,
		915,
		nil,
		1
	},
	[42544003] = {
		42544003,
		0,
		Lang.get(114608),
		42544,
		3,
		915,
		nil,
		1
	},
	[42544004] = {
		42544004,
		0,
		Lang.get(114609),
		42544,
		4,
		1299,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42544005] = {
		42544005,
		0,
		Lang.get(114610),
		42544,
		5,
		915,
		{
			RTResTalkAction[29]
		},
		1
	},
	[42544006] = {
		42544006,
		0,
		Lang.get(114611),
		42544,
		6,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544007] = {
		42544007,
		0,
		Lang.get(114612),
		42544,
		7,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544008] = {
		42544008,
		0,
		Lang.get(114613),
		42544,
		8,
		915,
		{
			RTResTalkAction[29]
		},
		1
	},
	[42544009] = {
		42544009,
		0,
		Lang.get(114614),
		42544,
		9,
		605
	},
	[42544010] = {
		42544010,
		0,
		Lang.get(114615),
		42544,
		10,
		1299,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		42568,
		nil,
		1,
		nil,
		1,
		nil,
		42568
	},
	[42544011] = {
		42544011,
		3,
		Lang.get(114616),
		42544,
		11,
		605,
		[22] = 1
	},
	[42544012] = {
		42544012,
		0,
		Lang.get(114617),
		42544,
		12,
		1299,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[42544013] = {
		42544013,
		0,
		Lang.get(114618),
		42544,
		13,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544014] = {
		42544014,
		0,
		Lang.get(114619),
		42544,
		14,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544015] = {
		42544015,
		0,
		Lang.get(114620),
		42544,
		15,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544016] = {
		42544016,
		0,
		Lang.get(114621),
		42544,
		16,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544017] = {
		42544017,
		0,
		Lang.get(114622),
		42544,
		17,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544018] = {
		42544018,
		0,
		Lang.get(114623),
		42544,
		18,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544019] = {
		42544019,
		0,
		Lang.get(114624),
		42544,
		19,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544020] = {
		42544020,
		0,
		Lang.get(114625),
		42544,
		20,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544021] = {
		42544021,
		0,
		Lang.get(114626),
		42544,
		21,
		1299,
		{
			RTResTalkAction[28]
		}
	},
	[42544022] = {
		42544022,
		0,
		Lang.get(114627),
		42544,
		22,
		1299,
		{
			RTResTalkAction[28]
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
