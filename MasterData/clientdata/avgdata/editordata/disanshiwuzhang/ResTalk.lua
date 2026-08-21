-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\disanshiwuzhang\\ResTalk.lua

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
	[2] = 236
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 236
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 230,
	[3] = {
		1
	}
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 230
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 42,
	[3] = {
		2
	}
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 230
}
RTResTalkAction[7] = {
	1,
	134,
	{
		1,
		1002
	},
	nil,
	1
}
RTResTalkAction[8] = {
	1,
	716,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[10] = {
	1,
	236,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 716
}
RTResTalkAction[12] = {
	1,
	386,
	nil,
	nil,
	3
}
RTResTalkAction[13] = {
	1,
	134,
	{
		1002
	},
	nil,
	1
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[15] = {
	1,
	43,
	nil,
	nil,
	1
}
RTResTalkAction[16] = {
	1,
	42,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 43
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 42
}
RTResTalkAction[19] = {
	1,
	42,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[20] = {
	1,
	134,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[21] = {
	1,
	386,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[22] = {
	1,
	134,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[23] = {
	1,
	42,
	{
		1,
		1002
	},
	nil,
	1
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		2
	}
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 386,
	[3] = {
		3
	}
}
RTResTalkAction[26] = {
	1,
	236,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[27] = {
	1,
	386,
	{
		2,
		1002
	},
	nil,
	3
}
RTResTalkAction[28] = {
	1,
	172,
	{
		1
	},
	nil,
	8
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 172
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 717,
	[3] = {
		3
	}
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 172
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 717
}
RTResTalkAction[33] = {
	1,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 158,
	[3] = {
		1
	}
}
RTResTalkAction[37] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[38] = {
	3,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[40] = {
	1,
	134,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 230,
	[3] = {
		1,
		1002
	}
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 230,
	[3] = {
		2
	}
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 230,
	[3] = {
		2,
		1002
	}
}
RTResTalkAction[44] = {
	1,
	716,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[45] = {
	1,
	42,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 42
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 43
}
RTResTalkAction[48] = {
	[1] = 2,
	[2] = 43
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 42
}
RTResTalkAction[50] = {
	[1] = 1,
	[3] = {
		2
	}
}
RTResTalkAction[51] = {
	[1] = 0
}
RTResTalkAction[52] = {
	1,
	230,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[53] = {
	[1] = 2,
	[2] = 230
}
RTResTalkAction[54] = {
	3,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 67
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 67
}
RTResTalkAction[58] = {
	1,
	66,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 67
}
RTResTalkAction[60] = {
	1,
	220,
	nil,
	nil,
	3
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 66
}
RTResTalkAction[62] = {
	[1] = 2,
	[2] = 220
}
RTResTalkAction[63] = {
	3,
	215,
	nil,
	nil,
	1
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 66
}
RTResTalkAction[65] = {
	1,
	220,
	{
		1,
		1002
	},
	nil,
	2
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 220
}
RTResTalkAction[67] = {
	1,
	67,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[68] = {
	[1] = 3,
	[2] = 66,
	[3] = {
		1
	}
}
RTResTalkAction[69] = {
	1,
	220,
	{
		1001
	},
	nil,
	1
}
RTResTalkAction[70] = {
	1,
	66,
	nil,
	nil,
	0
}
RTResTalkAction[71] = {
	[1] = 2,
	[2] = 66
}
RTResTalkAction[72] = {
	[1] = 3,
	[2] = 67
}
RTResTalkAction[73] = {
	1,
	220,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[74] = {
	1,
	220,
	nil,
	nil,
	0
}
RTResTalkAction[75] = {
	1,
	215,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[76] = {
	1,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[78] = {
	1,
	215,
	{
		1
	},
	nil,
	0
}
RTResTalkAction[79] = {
	1,
	215,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[80] = {
	1,
	215,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[81] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[82] = {
	3,
	158,
	nil,
	nil,
	1
}
RTResTalkAction[83] = {
	1,
	215,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[84] = {
	1,
	158,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[85] = {
	1,
	158,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[86] = {
	1,
	220,
	{
		1
	},
	nil,
	3
}

local Data = {
	[22200001] = {
		22200001,
		0,
		"「|101|」，「|101|」……",
		22200,
		1,
		236,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		[19] = 22200,
		[17] = 1
	},
	[22200002] = {
		22200002,
		0,
		Lang.get(51675),
		22200,
		2,
		236,
		{
			RTResTalkAction[1]
		}
	},
	[22200003] = {
		22200003,
		0,
		Lang.get(51676),
		22200,
		3,
		386,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		48,
		22201,
		nil,
		1,
		nil,
		1,
		nil,
		22201
	},
	[22200004] = {
		22200004,
		0,
		Lang.get(51677),
		22200,
		4,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22202,
		[19] = 22202
	},
	[22200005] = {
		22200005,
		0,
		Lang.get(51678),
		22200,
		5,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22300
	},
	[22200006] = {
		22200006,
		0,
		Lang.get(51679),
		22200,
		6,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22202,
		[19] = 22300
	},
	[22200007] = {
		22200007,
		0,
		Lang.get(51680),
		22200,
		7,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22301,
		[19] = 22301,
		[17] = 2
	},
	[22200008] = {
		22200008,
		0,
		Lang.get(51681),
		22200,
		8,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22203,
		nil,
		nil,
		nil,
		nil,
		nil,
		22203
	},
	[22200009] = {
		22200009,
		0,
		Lang.get(51682),
		22200,
		9,
		42,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22204,
		nil,
		nil,
		nil,
		nil,
		nil,
		22204
	},
	[22200010] = {
		22200010,
		0,
		Lang.get(51683),
		22200,
		10,
		43,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22271
	},
	[22200011] = {
		22200011,
		0,
		Lang.get(51684),
		22200,
		11,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22270,
		[19] = 22270
	},
	[22200012] = {
		22200012,
		0,
		Lang.get(51685),
		22200,
		12,
		230,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[22200013] = {
		22200013,
		0,
		Lang.get(51686),
		22200,
		13,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22200014] = {
		22200014,
		0,
		Lang.get(51687),
		22200,
		14,
		42,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[22201001] = {
		22201001,
		0,
		Lang.get(51688),
		22201,
		1,
		42,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		22205,
		nil,
		nil,
		nil,
		1,
		nil,
		22205
	},
	[22201002] = {
		22201002,
		0,
		Lang.get(51689),
		22201,
		2,
		43,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22206,
		[19] = 22206
	},
	[22201003] = {
		22201003,
		0,
		Lang.get(51690),
		22201,
		3,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22207,
		[19] = 22207
	},
	[22201004] = {
		22201004,
		0,
		Lang.get(51691),
		22201,
		4,
		386,
		nil,
		1
	},
	[22201005] = {
		22201005,
		0,
		Lang.get(51692),
		22201,
		5,
		386,
		nil,
		1
	},
	[22201006] = {
		22201006,
		0,
		Lang.get(51693),
		22201,
		6,
		42,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22208,
		[19] = 22205
	},
	[22201007] = {
		22201007,
		4,
		nil,
		22201,
		7,
		300,
		[29] = {
			{
				id = 22201008,
				branch_content = Lang.get(51694)
			}
		}
	},
	[22201008] = {
		22201008,
		0,
		Lang.get(51695),
		22201,
		8,
		43,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22303,
		[19] = 22206
	},
	[22201009] = {
		22201009,
		4,
		nil,
		22201,
		9,
		300,
		[29] = {
			{
				id = 22201010,
				branch_content = Lang.get(51696)
			}
		}
	},
	[22201010] = {
		22201010,
		0,
		Lang.get(51697),
		22201,
		10,
		134,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22209,
		nil,
		nil,
		nil,
		nil,
		nil,
		22209
	},
	[22201011] = {
		22201011,
		4,
		nil,
		22201,
		11,
		300,
		nil,
		nil,
		nil,
		nil,
		1234,
		[29] = {
			{
				id = 22201012,
				branch_content = Lang.get(51698)
			}
		}
	},
	[22201012] = {
		22201012,
		0,
		Lang.get(51699),
		22201,
		12,
		230,
		nil,
		1,
		0,
		[19] = 22210
	},
	[22201013] = {
		22201013,
		0,
		Lang.get(51700),
		22201,
		13,
		107,
		nil,
		1,
		4,
		nil,
		nil,
		nil,
		22211,
		nil,
		nil,
		nil,
		nil,
		nil,
		22211
	},
	[22201014] = {
		22201014,
		0,
		Lang.get(51701),
		22201,
		14,
		107,
		nil,
		1,
		6
	},
	[22201015] = {
		22201015,
		0,
		Lang.get(51702),
		22201,
		15,
		107,
		nil,
		1,
		1
	},
	[22201016] = {
		22201016,
		0,
		Lang.get(51703),
		22201,
		16,
		386,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22213
	},
	[22201017] = {
		22201017,
		0,
		Lang.get(51704),
		22201,
		17,
		42,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22214
	},
	[22201018] = {
		22201018,
		0,
		Lang.get(51705),
		22201,
		18,
		43,
		nil,
		1
	},
	[22201019] = {
		22201019,
		0,
		Lang.get(51706),
		22201,
		19,
		134,
		nil,
		1,
		3,
		nil,
		nil,
		nil,
		22212,
		nil,
		nil,
		nil,
		nil,
		nil,
		22212
	},
	[22201020] = {
		22201020,
		0,
		Lang.get(51707),
		22201,
		20,
		134,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[22201021] = {
		22201021,
		0,
		Lang.get(51708),
		22201,
		21,
		716,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[22201022] = {
		22201022,
		0,
		Lang.get(51675),
		22201,
		22,
		236,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		nil,
		nil,
		1,
		[19] = 22214,
		[17] = 1
	},
	[22202001] = {
		22202001,
		0,
		Lang.get(51709),
		22202,
		1,
		386,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3,
		nil,
		61,
		22215,
		1.2,
		nil,
		nil,
		1,
		nil,
		22215
	},
	[22202002] = {
		22202002,
		0,
		Lang.get(51710),
		22202,
		2,
		134,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[22202003] = {
		22202003,
		0,
		Lang.get(51711),
		22202,
		3,
		43,
		{
			RTResTalkAction[15],
			RTResTalkAction[9]
		}
	},
	[22202004] = {
		22202004,
		0,
		Lang.get(51712),
		22202,
		4,
		42,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[22202005] = {
		22202005,
		0,
		Lang.get(51713),
		22202,
		5,
		43,
		{
			RTResTalkAction[15],
			RTResTalkAction[18]
		}
	},
	[22202006] = {
		22202006,
		0,
		Lang.get(51714),
		22202,
		6,
		42,
		{
			RTResTalkAction[19],
			RTResTalkAction[17]
		}
	},
	[22202007] = {
		22202007,
		0,
		Lang.get(51715),
		22202,
		7,
		134,
		{
			RTResTalkAction[20],
			RTResTalkAction[18]
		}
	},
	[22202008] = {
		22202008,
		0,
		Lang.get(51716),
		22202,
		8,
		386,
		{
			RTResTalkAction[21],
			RTResTalkAction[9]
		}
	},
	[22202009] = {
		22202009,
		0,
		Lang.get(51717),
		22202,
		9,
		134,
		{
			RTResTalkAction[22],
			RTResTalkAction[14]
		}
	},
	[22202010] = {
		22202010,
		0,
		Lang.get(51718),
		22202,
		10,
		42,
		{
			RTResTalkAction[23],
			RTResTalkAction[9]
		}
	},
	[22202011] = {
		22202011,
		0,
		Lang.get(51719),
		22202,
		11,
		386,
		{
			RTResTalkAction[12],
			RTResTalkAction[18]
		}
	},
	[22202012] = {
		22202012,
		0,
		Lang.get(51720),
		22202,
		12,
		386,
		{
			RTResTalkAction[24]
		}
	},
	[22202013] = {
		22202013,
		0,
		Lang.get(51721),
		22202,
		13,
		386,
		{
			RTResTalkAction[25]
		},
		[19] = 22216,
		[17] = 1
	},
	[22202014] = {
		22202014,
		0,
		Lang.get(51675),
		22202,
		14,
		236,
		{
			RTResTalkAction[26],
			RTResTalkAction[14]
		}
	},
	[22203001] = {
		22203001,
		0,
		Lang.get(51719),
		22203,
		1,
		386,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		nil,
		nil,
		61,
		22217,
		[19] = 22217,
		[17] = 1
	},
	[22203002] = {
		22203002,
		0,
		Lang.get(51720),
		22203,
		2,
		386,
		{
			RTResTalkAction[24]
		}
	},
	[22203003] = {
		22203003,
		0,
		Lang.get(51721),
		22203,
		3,
		386,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[22203004] = {
		22203004,
		0,
		Lang.get(51675),
		22203,
		4,
		236,
		{
			RTResTalkAction[1],
			RTResTalkAction[14]
		},
		nil,
		nil,
		nil,
		nil,
		58
	},
	[22203005] = {
		22203005,
		0,
		Lang.get(45059),
		22203,
		5,
		172,
		{
			RTResTalkAction[28],
			RTResTalkAction[2]
		}
	},
	[22203006] = {
		22203006,
		0,
		Lang.get(45060),
		22203,
		6,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203007] = {
		22203007,
		0,
		Lang.get(45061),
		22203,
		7,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203008] = {
		22203008,
		0,
		Lang.get(45062),
		22203,
		8,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203009] = {
		22203009,
		0,
		"……",
		22203,
		9,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203010] = {
		22203010,
		0,
		Lang.get(45063),
		22203,
		10,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203011] = {
		22203011,
		0,
		Lang.get(20764),
		22203,
		11,
		172,
		{
			RTResTalkAction[29]
		}
	},
	[22203012] = {
		22203012,
		0,
		Lang.get(51722),
		22203,
		12,
		717,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[22203013] = {
		22203013,
		0,
		Lang.get(51723),
		22203,
		13,
		300,
		{
			RTResTalkAction[32]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		22222,
		nil,
		1,
		nil,
		1,
		nil,
		22222
	},
	[22203014] = {
		22203014,
		0,
		Lang.get(51724),
		22203,
		14,
		215,
		nil,
		1,
		0
	},
	[22203015] = {
		22203015,
		0,
		Lang.get(51690),
		22203,
		15,
		386,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		22223,
		nil,
		nil,
		nil,
		nil,
		nil,
		22223
	},
	[22203016] = {
		22203016,
		0,
		Lang.get(51725),
		22203,
		16,
		386,
		nil,
		1
	},
	[22203017] = {
		22203017,
		0,
		Lang.get(51726),
		22203,
		17,
		386,
		nil,
		1
	},
	[22203018] = {
		22203018,
		4,
		nil,
		22203,
		18,
		300,
		[29] = {
			{
				id = 22203019,
				branch_content = Lang.get(51727)
			},
			{
				id = 22203019,
				branch_content = Lang.get(45893)
			},
			{
				id = 22203019,
				branch_content = Lang.get(51728)
			}
		}
	},
	[22203019] = {
		22203019,
		0,
		Lang.get(51729),
		22203,
		19,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22224,
		[19] = 22224
	},
	[22204001] = {
		22204001,
		0,
		Lang.get(51730),
		22204,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		1235,
		59,
		[19] = 22225,
		[17] = 1
	},
	[22204002] = {
		22204002,
		3,
		Lang.get(55370),
		22204,
		2,
		300,
		[22] = 1
	},
	[22204003] = {
		22204003,
		0,
		Lang.get(51731),
		22204,
		3,
		230,
		nil,
		1,
		0,
		nil,
		nil,
		122,
		22226,
		nil,
		nil,
		nil,
		1,
		nil,
		22226
	},
	[22204004] = {
		22204004,
		0,
		Lang.get(51732),
		22204,
		4,
		158,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22227,
		nil,
		nil,
		nil,
		nil,
		nil,
		22213
	},
	[22204005] = {
		22204005,
		0,
		Lang.get(51733),
		22204,
		5,
		215,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[22204006] = {
		22204006,
		0,
		Lang.get(51734),
		22204,
		6,
		158,
		{
			RTResTalkAction[34],
			RTResTalkAction[35]
		}
	},
	[22204007] = {
		22204007,
		0,
		Lang.get(51735),
		22204,
		7,
		158,
		{
			RTResTalkAction[36]
		}
	},
	[22204008] = {
		22204008,
		0,
		Lang.get(51736),
		22204,
		8,
		215,
		{
			RTResTalkAction[37],
			RTResTalkAction[38]
		}
	},
	[22204009] = {
		22204009,
		0,
		Lang.get(51737),
		22204,
		9,
		386,
		{
			RTResTalkAction[39],
			RTResTalkAction[35]
		},
		1,
		0,
		-1,
		nil,
		nil,
		22228,
		nil,
		nil,
		nil,
		nil,
		nil,
		22228
	},
	[22204010] = {
		22204010,
		0,
		Lang.get(51738),
		22204,
		10,
		134,
		{
			RTResTalkAction[20]
		},
		1,
		2,
		3,
		nil,
		11
	},
	[22204011] = {
		22204011,
		0,
		Lang.get(51739),
		22204,
		11,
		134,
		{
			RTResTalkAction[40]
		},
		1,
		4
	},
	[22204012] = {
		22204012,
		0,
		Lang.get(51740),
		22204,
		12,
		42,
		{
			RTResTalkAction[5],
			RTResTalkAction[9]
		}
	},
	[22204013] = {
		22204013,
		0,
		Lang.get(51741),
		22204,
		13,
		230,
		{
			RTResTalkAction[18]
		},
		1,
		nil,
		-1
	},
	[22204014] = {
		22204014,
		0,
		Lang.get(51742),
		22204,
		14,
		230,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3
	},
	[22204015] = {
		22204015,
		4,
		nil,
		22204,
		15,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204016,
				branch_content = Lang.get(51743)
			}
		}
	},
	[22204016] = {
		22204016,
		0,
		Lang.get(51744),
		22204,
		16,
		230,
		{
			RTResTalkAction[42]
		}
	},
	[22204017] = {
		22204017,
		4,
		nil,
		22204,
		17,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204018,
				branch_content = Lang.get(51745)
			}
		}
	},
	[22204018] = {
		22204018,
		0,
		Lang.get(51746),
		22204,
		18,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22204019] = {
		22204019,
		4,
		nil,
		22204,
		19,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204020,
				branch_content = Lang.get(51747)
			}
		}
	},
	[22204020] = {
		22204020,
		0,
		Lang.get(51748),
		22204,
		20,
		230,
		{
			RTResTalkAction[41]
		}
	},
	[22204021] = {
		22204021,
		4,
		nil,
		22204,
		21,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204022,
				branch_content = Lang.get(51749)
			}
		}
	},
	[22204022] = {
		22204022,
		0,
		Lang.get(51750),
		22204,
		22,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22204023] = {
		22204023,
		4,
		nil,
		22204,
		23,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204024,
				branch_content = Lang.get(51751)
			}
		}
	},
	[22204024] = {
		22204024,
		0,
		Lang.get(28698),
		22204,
		24,
		230,
		{
			RTResTalkAction[43]
		}
	},
	[22204025] = {
		22204025,
		4,
		nil,
		22204,
		25,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22204026,
				branch_content = Lang.get(51752)
			}
		}
	},
	[22204026] = {
		22204026,
		0,
		Lang.get(51753),
		22204,
		26,
		716,
		{
			RTResTalkAction[44],
			RTResTalkAction[6]
		}
	},
	[22204027] = {
		22204027,
		0,
		Lang.get(51754),
		22204,
		27,
		42,
		{
			RTResTalkAction[45],
			RTResTalkAction[11]
		}
	},
	[22204028] = {
		22204028,
		4,
		nil,
		22204,
		28,
		300,
		{
			RTResTalkAction[46]
		},
		[29] = {
			{
				id = 22204029,
				branch_content = Lang.get(51755)
			}
		}
	},
	[22204029] = {
		22204029,
		0,
		Lang.get(51756),
		22204,
		29,
		230,
		{
			RTResTalkAction[4],
			RTResTalkAction[18]
		}
	},
	[22205001] = {
		22205001,
		0,
		Lang.get(51757),
		22205,
		1,
		230,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		22230,
		nil,
		nil,
		nil,
		1,
		nil,
		22230
	},
	[22205002] = {
		22205002,
		4,
		nil,
		22205,
		2,
		300,
		[29] = {
			{
				id = 22205003,
				branch_content = Lang.get(51758)
			}
		}
	},
	[22205003] = {
		22205003,
		0,
		Lang.get(51759),
		22205,
		3,
		230,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[22205004] = {
		22205004,
		4,
		nil,
		22205,
		4,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22205005,
				branch_content = Lang.get(51760)
			}
		}
	},
	[22205005] = {
		22205005,
		0,
		Lang.get(51761),
		22205,
		5,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22205006] = {
		22205006,
		0,
		Lang.get(51762),
		22205,
		6,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[22205007] = {
		22205007,
		0,
		Lang.get(51763),
		22205,
		7,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22205008] = {
		22205008,
		4,
		nil,
		22205,
		8,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22205009,
				branch_content = Lang.get(51764)
			}
		}
	},
	[22205009] = {
		22205009,
		0,
		Lang.get(51765),
		22205,
		9,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22205010] = {
		22205010,
		4,
		nil,
		22205,
		10,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22205011,
				branch_content = Lang.get(18685)
			}
		}
	},
	[22205011] = {
		22205011,
		0,
		Lang.get(51766),
		22205,
		11,
		43,
		{
			RTResTalkAction[47],
			RTResTalkAction[6]
		}
	},
	[22205012] = {
		22205012,
		0,
		Lang.get(51767),
		22205,
		12,
		42,
		{
			RTResTalkAction[48],
			RTResTalkAction[49]
		}
	},
	[22205013] = {
		22205013,
		0,
		Lang.get(51768),
		22205,
		13,
		215,
		{
			RTResTalkAction[50],
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[22205014] = {
		22205014,
		0,
		Lang.get(51769),
		22205,
		14,
		134,
		{
			RTResTalkAction[51]
		},
		1,
		nil,
		-1,
		[19] = 22234
	},
	[22205015] = {
		22205015,
		0,
		Lang.get(51770),
		22205,
		15,
		158,
		nil,
		1
	},
	[22205016] = {
		22205016,
		0,
		Lang.get(51771),
		22205,
		16,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22235,
		[19] = 22235
	},
	[22205017] = {
		22205017,
		0,
		Lang.get(51772),
		22205,
		17,
		386,
		nil,
		1
	},
	[22205018] = {
		22205018,
		4,
		nil,
		22205,
		18,
		300,
		nil,
		1,
		[29] = {
			{
				id = 22205019,
				branch_content = Lang.get(51773)
			}
		}
	},
	[22205019] = {
		22205019,
		0,
		Lang.get(51774),
		22205,
		19,
		43,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22236,
		nil,
		nil,
		nil,
		nil,
		nil,
		22236
	},
	[22205020] = {
		22205020,
		0,
		Lang.get(51775),
		22205,
		20,
		42,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22262,
		[19] = 22262
	},
	[22206001] = {
		22206001,
		0,
		Lang.get(51776),
		22206,
		1,
		158,
		nil,
		1,
		1,
		nil,
		nil,
		143,
		22237,
		nil,
		nil,
		nil,
		1,
		nil,
		22237
	},
	[22206002] = {
		22206002,
		0,
		Lang.get(51777),
		22206,
		2,
		220,
		nil,
		1,
		3
	},
	[22206003] = {
		22206003,
		0,
		Lang.get(51778),
		22206,
		3,
		158,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22306,
		nil,
		nil,
		nil,
		nil,
		nil,
		22306
	},
	[22206004] = {
		22206004,
		4,
		nil,
		22206,
		4,
		300,
		[29] = {
			{
				id = 22206005,
				branch_content = Lang.get(51779)
			}
		}
	},
	[22206005] = {
		22206005,
		0,
		Lang.get(51780),
		22206,
		5,
		158,
		nil,
		1
	},
	[22206006] = {
		22206006,
		0,
		Lang.get(51781),
		22206,
		6,
		158,
		nil,
		1
	},
	[22206007] = {
		22206007,
		0,
		Lang.get(51782),
		22206,
		7,
		215,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22238,
		nil,
		nil,
		nil,
		nil,
		nil,
		22238
	},
	[22206008] = {
		22206008,
		0,
		Lang.get(51783),
		22206,
		8,
		220,
		nil,
		1,
		3
	},
	[22206009] = {
		22206009,
		0,
		Lang.get(51784),
		22206,
		9,
		158,
		nil,
		1,
		5
	},
	[22206010] = {
		22206010,
		0,
		Lang.get(51785),
		22206,
		10,
		230,
		{
			RTResTalkAction[52]
		}
	},
	[22206011] = {
		22206011,
		4,
		nil,
		22206,
		11,
		300,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 22206012,
				branch_content = Lang.get(51786)
			}
		}
	},
	[22206012] = {
		22206012,
		0,
		Lang.get(51787),
		22206,
		12,
		230,
		{
			RTResTalkAction[4]
		}
	},
	[22206013] = {
		22206013,
		0,
		Lang.get(51788),
		22206,
		13,
		230,
		{
			RTResTalkAction[53],
			RTResTalkAction[54]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		22307,
		[19] = 22307
	},
	[22206014] = {
		22206014,
		0,
		Lang.get(51789),
		22206,
		14,
		220,
		{
			RTResTalkAction[6],
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		22309,
		[19] = 22309
	},
	[22207001] = {
		22207001,
		0,
		Lang.get(51790),
		22207,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		62,
		22240,
		nil,
		nil,
		nil,
		1,
		nil,
		22240
	},
	[22207002] = {
		22207002,
		9,
		Lang.get(51791),
		22207,
		2,
		220,
		[19] = 22308,
		[22] = 1,
		[17] = 2
	},
	[22207003] = {
		22207003,
		3,
		Lang.get(51792),
		22207,
		3,
		220,
		nil,
		1,
		0,
		nil,
		nil,
		61,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[22207004] = {
		22207004,
		3,
		Lang.get(51793),
		22207,
		4,
		220,
		nil,
		1,
		nil,
		nil,
		1232,
		[19] = 22241,
		[22] = 1
	},
	[22207005] = {
		22207005,
		3,
		Lang.get(51794),
		22207,
		5,
		220,
		nil,
		1,
		nil,
		nil,
		1233,
		nil,
		22243,
		nil,
		nil,
		nil,
		nil,
		nil,
		22243,
		nil,
		nil,
		1
	},
	[22207006] = {
		22207006,
		3,
		Lang.get(51795),
		22207,
		6,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22244,
		[19] = 22244,
		[22] = 1
	},
	[22207007] = {
		22207007,
		0,
		Lang.get(51796),
		22207,
		7,
		66,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22245,
		nil,
		nil,
		nil,
		1,
		nil,
		22245,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		2
	},
	[22207008] = {
		22207008,
		0,
		Lang.get(51797),
		22207,
		8,
		67,
		nil,
		1
	},
	[22207009] = {
		22207009,
		0,
		Lang.get(51798),
		22207,
		9,
		66,
		nil,
		1
	},
	[22207010] = {
		22207010,
		0,
		Lang.get(51799),
		22207,
		10,
		300
	},
	[22207011] = {
		22207011,
		0,
		Lang.get(51800),
		22207,
		11,
		300
	},
	[22207012] = {
		22207012,
		0,
		Lang.get(51801),
		22207,
		12,
		300
	},
	[22207013] = {
		22207013,
		0,
		Lang.get(51802),
		22207,
		13,
		67,
		nil,
		1
	},
	[22207014] = {
		22207014,
		0,
		Lang.get(51803),
		22207,
		14,
		66,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		22242
	},
	[22207015] = {
		22207015,
		0,
		Lang.get(51804),
		22207,
		15,
		220,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22246,
		nil,
		nil,
		nil,
		nil,
		nil,
		22246
	},
	[22208001] = {
		22208001,
		0,
		Lang.get(52248),
		22208,
		1,
		215,
		nil,
		1,
		0,
		nil,
		nil,
		122,
		22247,
		nil,
		nil,
		nil,
		1,
		nil,
		22247
	},
	[22208002] = {
		22208002,
		0,
		Lang.get(51806),
		22208,
		2,
		220,
		nil,
		1,
		2
	},
	[22208003] = {
		22208003,
		0,
		Lang.get(51807),
		22208,
		3,
		67,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		22248,
		[19] = 22248
	},
	[22208004] = {
		22208004,
		0,
		Lang.get(51808),
		22208,
		4,
		215,
		{
			RTResTalkAction[57],
			RTResTalkAction[38]
		}
	},
	[22208005] = {
		22208005,
		0,
		Lang.get(51809),
		22208,
		5,
		66,
		{
			RTResTalkAction[58],
			RTResTalkAction[59],
			RTResTalkAction[35]
		}
	},
	[22208006] = {
		22208006,
		0,
		Lang.get(51810),
		22208,
		6,
		220,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[22208007] = {
		22208007,
		0,
		Lang.get(51811),
		22208,
		7,
		215,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[22208008] = {
		22208008,
		0,
		Lang.get(51812),
		22208,
		8,
		66,
		{
			RTResTalkAction[64],
			RTResTalkAction[55],
			RTResTalkAction[35]
		},
		1,
		0
	},
	[22208009] = {
		22208009,
		0,
		Lang.get(51813),
		22208,
		9,
		215,
		{
			RTResTalkAction[61]
		},
		1,
		3,
		-1,
		nil,
		nil,
		22249,
		nil,
		nil,
		nil,
		1,
		nil,
		22249
	},
	[22208010] = {
		22208010,
		0,
		Lang.get(51814),
		22208,
		10,
		220,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3
	},
	[22208011] = {
		22208011,
		4,
		nil,
		22208,
		11,
		300,
		{
			RTResTalkAction[66]
		},
		[29] = {
			{
				id = 22208012,
				branch_content = Lang.get(51815)
			}
		}
	},
	[22208012] = {
		22208012,
		0,
		Lang.get(51816),
		22208,
		12,
		67,
		{
			RTResTalkAction[67],
			RTResTalkAction[55]
		}
	},
	[22208013] = {
		22208013,
		0,
		Lang.get(51817),
		22208,
		13,
		66,
		{
			RTResTalkAction[57],
			RTResTalkAction[68]
		}
	},
	[22208014] = {
		22208014,
		0,
		Lang.get(51818),
		22208,
		14,
		220,
		{
			RTResTalkAction[69],
			RTResTalkAction[59],
			RTResTalkAction[61]
		}
	},
	[22208015] = {
		22208015,
		4,
		nil,
		22208,
		15,
		300,
		{
			RTResTalkAction[66]
		},
		[29] = {
			{
				id = 22208016,
				branch_content = Lang.get(51819)
			}
		}
	},
	[22208016] = {
		22208016,
		0,
		Lang.get(51820),
		22208,
		16,
		215,
		{
			RTResTalkAction[33],
			RTResTalkAction[55]
		}
	},
	[22208017] = {
		22208017,
		0,
		Lang.get(51821),
		22208,
		17,
		66,
		{
			RTResTalkAction[70],
			RTResTalkAction[35]
		}
	},
	[22208018] = {
		22208018,
		0,
		Lang.get(51822),
		22208,
		18,
		67,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[22209001] = {
		22209001,
		0,
		Lang.get(51823),
		22209,
		1,
		215,
		nil,
		1,
		1,
		nil,
		nil,
		59,
		22250,
		nil,
		nil,
		nil,
		1,
		nil,
		22250
	},
	[22209002] = {
		22209002,
		4,
		nil,
		22209,
		2,
		300,
		[19] = 22251,
		[29] = {
			{
				id = 22209003,
				branch_content = Lang.get(51824)
			}
		}
	},
	[22209003] = {
		22209003,
		0,
		Lang.get(51825),
		22209,
		3,
		220,
		nil,
		1,
		1,
		[19] = 22252
	},
	[22209004] = {
		22209004,
		4,
		nil,
		22209,
		4,
		300,
		[29] = {
			{
				id = 22209005,
				branch_content = Lang.get(51826)
			}
		}
	},
	[22209005] = {
		22209005,
		0,
		Lang.get(51827),
		22209,
		5,
		220,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3,
		nil,
		158
	},
	[22209006] = {
		22209006,
		0,
		Lang.get(51828),
		22209,
		6,
		220,
		{
			RTResTalkAction[60]
		}
	},
	[22209007] = {
		22209007,
		4,
		nil,
		22209,
		7,
		300,
		{
			RTResTalkAction[74]
		},
		[29] = {
			{
				id = 22209008,
				branch_content = Lang.get(51829)
			}
		}
	},
	[22209008] = {
		22209008,
		0,
		Lang.get(51830),
		22209,
		8,
		215,
		{
			RTResTalkAction[75],
			RTResTalkAction[55]
		}
	},
	[22209009] = {
		22209009,
		0,
		Lang.get(51831),
		22209,
		9,
		215,
		{
			RTResTalkAction[76]
		}
	},
	[22209010] = {
		22209010,
		4,
		nil,
		22209,
		10,
		300,
		{
			RTResTalkAction[77]
		},
		[29] = {
			{
				id = 22209011,
				branch_content = Lang.get(51832)
			}
		}
	},
	[22209011] = {
		22209011,
		0,
		Lang.get(51833),
		22209,
		11,
		215,
		{
			RTResTalkAction[78]
		}
	},
	[22209012] = {
		22209012,
		0,
		Lang.get(51834),
		22209,
		12,
		220,
		{
			RTResTalkAction[60],
			RTResTalkAction[35]
		}
	},
	[22209013] = {
		22209013,
		4,
		nil,
		22209,
		13,
		300,
		{
			RTResTalkAction[66]
		},
		[29] = {
			{
				id = 22209014,
				branch_content = Lang.get(51835)
			}
		}
	},
	[22209014] = {
		22209014,
		0,
		Lang.get(51836),
		22209,
		14,
		215,
		{
			RTResTalkAction[79],
			RTResTalkAction[55]
		}
	},
	[22209015] = {
		22209015,
		0,
		Lang.get(51837),
		22209,
		15,
		220,
		{
			RTResTalkAction[66],
			RTResTalkAction[35]
		}
	},
	[22209016] = {
		22209016,
		0,
		Lang.get(51838),
		22209,
		16,
		215,
		{
			RTResTalkAction[80],
			RTResTalkAction[55]
		}
	},
	[22210001] = {
		22210001,
		3,
		Lang.get(51839),
		22210,
		1,
		220,
		nil,
		1,
		nil,
		nil,
		nil,
		122,
		22309,
		nil,
		nil,
		nil,
		1,
		nil,
		22309,
		nil,
		nil,
		1
	},
	[22210002] = {
		22210002,
		0,
		Lang.get(51840),
		22210,
		2,
		158,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		22257,
		nil,
		nil,
		nil,
		nil,
		nil,
		22257
	},
	[22210003] = {
		22210003,
		0,
		Lang.get(51841),
		22210,
		3,
		215,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[22210004] = {
		22210004,
		0,
		Lang.get(51842),
		22210,
		4,
		158,
		{
			RTResTalkAction[81],
			RTResTalkAction[82]
		}
	},
	[22210005] = {
		22210005,
		0,
		Lang.get(51843),
		22210,
		5,
		158,
		{
			RTResTalkAction[35],
			RTResTalkAction[39]
		},
		1,
		3,
		-1
	},
	[22210006] = {
		22210006,
		4,
		nil,
		22210,
		6,
		300,
		[29] = {
			{
				id = 22210007,
				branch_content = Lang.get(19613)
			}
		}
	},
	[22210007] = {
		22210007,
		0,
		Lang.get(51844),
		22210,
		7,
		158,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		22259,
		nil,
		nil,
		nil,
		nil,
		nil,
		22259
	},
	[22210008] = {
		22210008,
		4,
		nil,
		22210,
		8,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22261,
		[19] = 22261,
		[29] = {
			{
				id = 22210009,
				branch_content = Lang.get(51845)
			}
		}
	},
	[22210009] = {
		22210009,
		2,
		Lang.get(51846),
		22210,
		9,
		300
	},
	[22210010] = {
		22210010,
		0,
		Lang.get(51847),
		22210,
		10,
		215,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[22210011] = {
		22210011,
		0,
		Lang.get(51848),
		22210,
		11,
		158,
		{
			RTResTalkAction[84],
			RTResTalkAction[35]
		}
	},
	[22210012] = {
		22210012,
		0,
		Lang.get(51849),
		22210,
		12,
		300,
		{
			RTResTalkAction[34]
		}
	},
	[22210013] = {
		22210013,
		0,
		Lang.get(51850),
		22210,
		13,
		215,
		{
			RTResTalkAction[33],
			RTResTalkAction[39]
		}
	},
	[22210014] = {
		22210014,
		0,
		Lang.get(51851),
		22210,
		14,
		215,
		{
			RTResTalkAction[80]
		}
	},
	[22210015] = {
		22210015,
		0,
		Lang.get(51852),
		22210,
		15,
		158,
		{
			RTResTalkAction[85],
			RTResTalkAction[35]
		}
	},
	[22210016] = {
		22210016,
		0,
		Lang.get(51853),
		22210,
		16,
		220,
		{
			RTResTalkAction[86],
			RTResTalkAction[39]
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
