-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_jiacheng\\ResTalk.lua

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
	768,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 768
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 768
}
RTResTalkAction[4] = {
	1,
	768,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[5] = {
	1,
	768,
	nil,
	nil,
	3
}
RTResTalkAction[6] = {
	1,
	768,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	1,
	768,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[8] = {
	1,
	768,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[9] = {
	1,
	768,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[10] = {
	1,
	768,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 768,
	[3] = {
		2
	}
}
RTResTalkAction[12] = {
	1,
	768,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[13] = {
	1,
	768,
	nil,
	nil,
	2
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 179
}
RTResTalkAction[15] = {
	1,
	179,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 179
}
RTResTalkAction[17] = {
	1,
	179,
	nil,
	nil,
	0
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 179,
	[3] = {
		2
	}
}
RTResTalkAction[19] = {
	1,
	179,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[20] = {
	1,
	179,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[21] = {
	1,
	179,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[22] = {
	1,
	769,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 769
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 769
}
RTResTalkAction[25] = {
	1,
	769,
	nil,
	nil,
	4
}
RTResTalkAction[26] = {
	1,
	769,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[27] = {
	1,
	769,
	nil,
	nil,
	7
}
RTResTalkAction[28] = {
	1,
	769,
	nil,
	nil,
	1
}
RTResTalkAction[29] = {
	1,
	769,
	{
		2
	},
	nil,
	7
}
RTResTalkAction[30] = {
	1,
	769,
	nil,
	nil,
	2
}
RTResTalkAction[31] = {
	1,
	769,
	nil,
	nil,
	0
}
RTResTalkAction[32] = {
	1,
	769,
	nil,
	nil,
	6
}
RTResTalkAction[33] = {
	1,
	769,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[34] = {
	1,
	769,
	nil,
	nil,
	3
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 770
}
RTResTalkAction[36] = {
	[1] = 0,
	[2] = 770
}
RTResTalkAction[37] = {
	[1] = 1,
	[2] = 770,
	[3] = {
		1
	}
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 770,
	[3] = {
		2
	}
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 771,
	[3] = {
		2
	}
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 771
}
RTResTalkAction[41] = {
	[1] = 1,
	[2] = 771
}
RTResTalkAction[42] = {
	1,
	771,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[43] = {
	1,
	771,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 771,
	[3] = {
		3
	}
}
RTResTalkAction[45] = {
	1,
	771,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[46] = {
	1,
	771,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 772
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 772
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 772,
	[3] = {
		2
	}
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 772,
	[3] = {
		3
	}
}
RTResTalkAction[51] = {
	[1] = 1,
	[2] = 149
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 149
}
RTResTalkAction[54] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 149,
	[3] = {
		1
	}
}
RTResTalkAction[56] = {
	[1] = 1,
	[2] = 149,
	[3] = {
		2
	}
}
RTResTalkAction[57] = {
	1,
	149,
	nil,
	nil,
	1
}
RTResTalkAction[58] = {
	1,
	149,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[59] = {
	1,
	149,
	nil,
	nil,
	0
}
RTResTalkAction[60] = {
	1,
	149,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 127
}
RTResTalkAction[62] = {
	[1] = 0,
	[2] = 127
}
RTResTalkAction[63] = {
	[1] = 1,
	[2] = 773
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 773
}
RTResTalkAction[65] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		1
	}
}
RTResTalkAction[66] = {
	[1] = 0,
	[2] = 1047
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 1047
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		2
	}
}
RTResTalkAction[69] = {
	1,
	1047,
	nil,
	nil,
	1
}
RTResTalkAction[70] = {
	1,
	1047,
	nil,
	nil,
	0
}
RTResTalkAction[71] = {
	[1] = 1,
	[2] = 1047,
	[3] = {
		3
	}
}
RTResTalkAction[72] = {
	1,
	1047,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[73] = {
	1,
	1047,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[74] = {
	1,
	1047,
	nil,
	nil,
	3
}
RTResTalkAction[75] = {
	1,
	1047,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[76] = {
	1,
	1118,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[77] = {
	[1] = 1,
	[2] = 1118
}
RTResTalkAction[78] = {
	[1] = 0,
	[2] = 1118
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 1118,
	[3] = {
		1
	}
}
RTResTalkAction[80] = {
	1,
	1118,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[81] = {
	1,
	1118,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[82] = {
	1,
	1118,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[83] = {
	1,
	1118,
	{
		2
	},
	nil,
	4
}
RTResTalkAction[84] = {
	[1] = 1,
	[2] = 1144
}
RTResTalkAction[85] = {
	[1] = 0,
	[2] = 1144
}
RTResTalkAction[86] = {
	[1] = 1,
	[2] = 1144,
	[3] = {
		1
	}
}
RTResTalkAction[87] = {
	[1] = 1,
	[2] = 1144,
	[3] = {
		2
	}
}
RTResTalkAction[88] = {
	[1] = 1,
	[2] = 1144,
	[3] = {
		3
	}
}
RTResTalkAction[89] = {
	1,
	1146,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[90] = {
	[1] = 1,
	[2] = 1146
}
RTResTalkAction[91] = {
	1,
	1146,
	nil,
	nil,
	0
}
RTResTalkAction[92] = {
	1,
	1146,
	nil,
	nil,
	1
}
RTResTalkAction[93] = {
	1,
	1146,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 1145
}
RTResTalkAction[95] = {
	[1] = 1,
	[2] = 1145,
	[3] = {
		2
	}
}
RTResTalkAction[96] = {
	[1] = 1,
	[2] = 1145,
	[3] = {
		3
	}
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 1145,
	[3] = {
		1
	}
}
RTResTalkAction[98] = {
	[1] = 1,
	[2] = 1147
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 1147,
	[3] = {
		2
	}
}
RTResTalkAction[100] = {
	1,
	1147,
	nil,
	nil,
	2
}
RTResTalkAction[101] = {
	1,
	1147,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[102] = {
	1,
	1276,
	nil,
	nil,
	0
}
RTResTalkAction[103] = {
	[1] = 1,
	[2] = 1276
}
RTResTalkAction[104] = {
	[1] = 1,
	[2] = 1276,
	[3] = {
		2
	}
}
RTResTalkAction[105] = {
	1,
	1276,
	nil,
	nil,
	2
}
RTResTalkAction[106] = {
	[1] = 0,
	[2] = 1276
}
RTResTalkAction[107] = {
	1,
	1276,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[108] = {
	1,
	1276,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[109] = {
	1,
	1276,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[110] = {
	1,
	1276,
	nil,
	nil,
	1
}
RTResTalkAction[111] = {
	1,
	1276,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[112] = {
	1,
	1276,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[113] = {
	1,
	1276,
	{
		2
	},
	nil,
	1
}

local Data = {
	[29300001] = {
		29300001,
		0,
		Lang.get(69594),
		29300,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		29300,
		[19] = 29300
	},
	[29300002] = {
		29300002,
		0,
		Lang.get(69595),
		29300,
		2,
		768,
		nil,
		1
	},
	[29300003] = {
		29300003,
		0,
		Lang.get(69596),
		29300,
		3,
		300
	},
	[29300004] = {
		29300004,
		5,
		Lang.get(69597),
		29300,
		4,
		768,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[29300005] = {
		29300005,
		0,
		Lang.get(69598),
		29300,
		5,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29300006] = {
		29300006,
		0,
		Lang.get(69599),
		29300,
		6,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29300007] = {
		29300007,
		0,
		Lang.get(69600),
		29300,
		7,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29300008] = {
		29300008,
		0,
		Lang.get(69601),
		29300,
		8,
		768,
		{
			RTResTalkAction[4]
		}
	},
	[29300009] = {
		29300009,
		0,
		Lang.get(69602),
		29300,
		9,
		768,
		{
			RTResTalkAction[5]
		}
	},
	[29300010] = {
		29300010,
		0,
		Lang.get(69603),
		29300,
		10,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29300011] = {
		29300011,
		0,
		Lang.get(69604),
		29300,
		11,
		768,
		{
			RTResTalkAction[6]
		}
	},
	[29300012] = {
		29300012,
		0,
		Lang.get(69605),
		29300,
		12,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29300013] = {
		29300013,
		0,
		Lang.get(69606),
		29300,
		13,
		768,
		{
			RTResTalkAction[1]
		}
	},
	[29300014] = {
		29300014,
		0,
		Lang.get(69607),
		29300,
		14,
		768,
		{
			RTResTalkAction[7]
		}
	},
	[29300015] = {
		29300015,
		0,
		Lang.get(69608),
		29300,
		15,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301001] = {
		29301001,
		0,
		Lang.get(69609),
		29301,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		29301,
		[19] = 29301
	},
	[29301002] = {
		29301002,
		0,
		Lang.get(69610),
		29301,
		2,
		768,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[29301003] = {
		29301003,
		0,
		Lang.get(69611),
		29301,
		3,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29301004] = {
		29301004,
		0,
		Lang.get(69612),
		29301,
		4,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301005] = {
		29301005,
		0,
		Lang.get(69613),
		29301,
		5,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29301006] = {
		29301006,
		0,
		Lang.get(69614),
		29301,
		6,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301007] = {
		29301007,
		0,
		Lang.get(69615),
		29301,
		7,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29301008] = {
		29301008,
		0,
		Lang.get(69616),
		29301,
		8,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301009] = {
		29301009,
		0,
		Lang.get(69617),
		29301,
		9,
		768,
		{
			RTResTalkAction[9]
		}
	},
	[29301010] = {
		29301010,
		0,
		Lang.get(69618),
		29301,
		10,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301011] = {
		29301011,
		0,
		Lang.get(69619),
		29301,
		11,
		768,
		{
			RTResTalkAction[10]
		}
	},
	[29301012] = {
		29301012,
		0,
		Lang.get(69620),
		29301,
		12,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29301013] = {
		29301013,
		0,
		Lang.get(69621),
		29301,
		13,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29301014] = {
		29301014,
		0,
		Lang.get(69622),
		29301,
		14,
		768,
		{
			RTResTalkAction[9]
		}
	},
	[29301015] = {
		29301015,
		0,
		Lang.get(69623),
		29301,
		15,
		768,
		{
			RTResTalkAction[6]
		}
	},
	[29302001] = {
		29302001,
		0,
		Lang.get(69624),
		29302,
		1,
		768,
		nil,
		1,
		1,
		nil,
		nil,
		62,
		29302,
		nil,
		nil,
		nil,
		nil,
		nil,
		29302
	},
	[29302002] = {
		29302002,
		0,
		Lang.get(69625),
		29302,
		2,
		300
	},
	[29302003] = {
		29302003,
		0,
		Lang.get(69626),
		29302,
		3,
		768,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[29302004] = {
		29302004,
		0,
		Lang.get(69627),
		29302,
		4,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29302005] = {
		29302005,
		0,
		Lang.get(69628),
		29302,
		5,
		768,
		{
			RTResTalkAction[11]
		}
	},
	[29302006] = {
		29302006,
		0,
		Lang.get(69629),
		29302,
		6,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29302007] = {
		29302007,
		0,
		Lang.get(69630),
		29302,
		7,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29302008] = {
		29302008,
		0,
		Lang.get(69631),
		29302,
		8,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29302009] = {
		29302009,
		0,
		Lang.get(69632),
		29302,
		9,
		768,
		{
			RTResTalkAction[11]
		}
	},
	[29302010] = {
		29302010,
		0,
		Lang.get(62777),
		29302,
		10,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29302011] = {
		29302011,
		0,
		Lang.get(69633),
		29302,
		11,
		768,
		{
			RTResTalkAction[2]
		}
	},
	[29302012] = {
		29302012,
		0,
		Lang.get(69634),
		29302,
		12,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[29302013] = {
		29302013,
		0,
		Lang.get(69635),
		29302,
		13,
		768,
		{
			RTResTalkAction[12]
		}
	},
	[29302014] = {
		29302014,
		0,
		Lang.get(69636),
		29302,
		14,
		768,
		{
			RTResTalkAction[13]
		}
	},
	[29302015] = {
		29302015,
		0,
		Lang.get(69637),
		29302,
		15,
		768,
		{
			RTResTalkAction[13]
		}
	},
	[29303001] = {
		29303001,
		0,
		Lang.get(67674),
		29303,
		1,
		179,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29303,
		nil,
		nil,
		nil,
		nil,
		nil,
		29303
	},
	[29303002] = {
		29303002,
		0,
		Lang.get(67675),
		29303,
		2,
		300
	},
	[29303003] = {
		29303003,
		0,
		Lang.get(67676),
		29303,
		3,
		179,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[29303004] = {
		29303004,
		0,
		Lang.get(67677),
		29303,
		4,
		179,
		{
			RTResTalkAction[15]
		}
	},
	[29303005] = {
		29303005,
		4,
		nil,
		29303,
		5,
		300,
		{
			RTResTalkAction[16]
		},
		[29] = {
			{
				id = 29303006,
				branch_content = Lang.get(67678)
			},
			{
				id = 29303006,
				branch_content = Lang.get(67679)
			}
		}
	},
	[29303006] = {
		29303006,
		0,
		Lang.get(67680),
		29303,
		6,
		179,
		{
			RTResTalkAction[17]
		}
	},
	[29303007] = {
		29303007,
		0,
		"……",
		29303,
		7,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29303008] = {
		29303008,
		0,
		Lang.get(67681),
		29303,
		8,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29303009] = {
		29303009,
		0,
		Lang.get(67682),
		29303,
		9,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29303010] = {
		29303010,
		0,
		Lang.get(67683),
		29303,
		10,
		179,
		{
			RTResTalkAction[18]
		}
	},
	[29303011] = {
		29303011,
		0,
		Lang.get(67684),
		29303,
		11,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29303012] = {
		29303012,
		0,
		Lang.get(67685),
		29303,
		12,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29303013] = {
		29303013,
		0,
		Lang.get(67686),
		29303,
		13,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29303014] = {
		29303014,
		0,
		Lang.get(67687),
		29303,
		14,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29303015] = {
		29303015,
		0,
		Lang.get(67688),
		29303,
		15,
		179,
		{
			RTResTalkAction[19]
		}
	},
	[29304001] = {
		29304001,
		0,
		Lang.get(67689),
		29304,
		1,
		179,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29304,
		nil,
		nil,
		nil,
		nil,
		nil,
		29304
	},
	[29304002] = {
		29304002,
		0,
		Lang.get(67675),
		29304,
		2,
		300
	},
	[29304003] = {
		29304003,
		0,
		Lang.get(67690),
		29304,
		3,
		179,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[29304004] = {
		29304004,
		0,
		Lang.get(67691),
		29304,
		4,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29304005] = {
		29304005,
		0,
		Lang.get(67692),
		29304,
		5,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304006] = {
		29304006,
		0,
		Lang.get(67693),
		29304,
		6,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29304007] = {
		29304007,
		0,
		Lang.get(67694),
		29304,
		7,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304008] = {
		29304008,
		0,
		Lang.get(67695),
		29304,
		8,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304009] = {
		29304009,
		0,
		Lang.get(67696),
		29304,
		9,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304010] = {
		29304010,
		0,
		Lang.get(67697),
		29304,
		10,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29304011] = {
		29304011,
		0,
		Lang.get(67698),
		29304,
		11,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304012] = {
		29304012,
		0,
		Lang.get(67699),
		29304,
		12,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304013] = {
		29304013,
		0,
		Lang.get(67700),
		29304,
		13,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29304014] = {
		29304014,
		0,
		Lang.get(67701),
		29304,
		14,
		179,
		{
			RTResTalkAction[15]
		}
	},
	[29304015] = {
		29304015,
		0,
		"……",
		29304,
		15,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29305001] = {
		29305001,
		0,
		Lang.get(67702),
		29305,
		1,
		179,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29305,
		nil,
		nil,
		nil,
		nil,
		nil,
		29305
	},
	[29305002] = {
		29305002,
		0,
		Lang.get(67703),
		29305,
		2,
		300
	},
	[29305003] = {
		29305003,
		0,
		Lang.get(67704),
		29305,
		3,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29305004] = {
		29305004,
		0,
		Lang.get(67705),
		29305,
		4,
		300
	},
	[29305005] = {
		29305005,
		0,
		Lang.get(67706),
		29305,
		5,
		179,
		{
			RTResTalkAction[21]
		}
	},
	[29305006] = {
		29305006,
		0,
		Lang.get(67707),
		29305,
		6,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29305007] = {
		29305007,
		0,
		Lang.get(67708),
		29305,
		7,
		179,
		{
			RTResTalkAction[17]
		}
	},
	[29305008] = {
		29305008,
		0,
		Lang.get(67709),
		29305,
		8,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29305009] = {
		29305009,
		0,
		Lang.get(67710),
		29305,
		9,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29305010] = {
		29305010,
		0,
		Lang.get(67711),
		29305,
		10,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29305011] = {
		29305011,
		0,
		Lang.get(67712),
		29305,
		11,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29305012] = {
		29305012,
		0,
		Lang.get(67713),
		29305,
		12,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[29305013] = {
		29305013,
		0,
		Lang.get(67714),
		29305,
		13,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29305014] = {
		29305014,
		0,
		Lang.get(67715),
		29305,
		14,
		179,
		{
			RTResTalkAction[14]
		}
	},
	[29305015] = {
		29305015,
		0,
		Lang.get(67716),
		29305,
		15,
		179,
		{
			RTResTalkAction[18]
		}
	},
	[29306001] = {
		29306001,
		0,
		Lang.get(69638),
		29306,
		1,
		769,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29306,
		nil,
		nil,
		nil,
		nil,
		nil,
		29306
	},
	[29306002] = {
		29306002,
		0,
		Lang.get(75522),
		29306,
		2,
		769,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[29306003] = {
		29306003,
		0,
		Lang.get(69640),
		29306,
		3,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29306004] = {
		29306004,
		0,
		Lang.get(69641),
		29306,
		4,
		769,
		{
			RTResTalkAction[24]
		}
	},
	[29306005] = {
		29306005,
		0,
		Lang.get(69642),
		29306,
		5,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29306006] = {
		29306006,
		0,
		Lang.get(69643),
		29306,
		6,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29306007] = {
		29306007,
		0,
		Lang.get(69644),
		29306,
		7,
		769,
		{
			RTResTalkAction[26]
		}
	},
	[29306008] = {
		29306008,
		0,
		Lang.get(69645),
		29306,
		8,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29306009] = {
		29306009,
		0,
		Lang.get(69646),
		29306,
		9,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29306010] = {
		29306010,
		0,
		Lang.get(69647),
		29306,
		10,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29306011] = {
		29306011,
		0,
		Lang.get(69648),
		29306,
		11,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29306012] = {
		29306012,
		0,
		Lang.get(69649),
		29306,
		12,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29306013] = {
		29306013,
		0,
		Lang.get(34703),
		29306,
		13,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29306014] = {
		29306014,
		0,
		Lang.get(69650),
		29306,
		14,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29306015] = {
		29306015,
		0,
		Lang.get(69651),
		29306,
		15,
		769,
		{
			RTResTalkAction[29]
		}
	},
	[29306016] = {
		29306016,
		0,
		Lang.get(69652),
		29306,
		16,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29306017] = {
		29306017,
		0,
		Lang.get(69653),
		29306,
		17,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29306018] = {
		29306018,
		0,
		Lang.get(69654),
		29306,
		18,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29307001] = {
		29307001,
		0,
		Lang.get(69655),
		29307,
		1,
		769,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29307,
		nil,
		nil,
		nil,
		nil,
		nil,
		29307
	},
	[29307002] = {
		29307002,
		0,
		Lang.get(69656),
		29307,
		2,
		769,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[29307003] = {
		29307003,
		0,
		Lang.get(69657),
		29307,
		3,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29307004] = {
		29307004,
		0,
		Lang.get(69658),
		29307,
		4,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29307005] = {
		29307005,
		0,
		Lang.get(69659),
		29307,
		5,
		769,
		{
			RTResTalkAction[31]
		}
	},
	[29307006] = {
		29307006,
		0,
		Lang.get(69660),
		29307,
		6,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29307007] = {
		29307007,
		0,
		Lang.get(69661),
		29307,
		7,
		769,
		{
			RTResTalkAction[26]
		}
	},
	[29307008] = {
		29307008,
		0,
		Lang.get(69662),
		29307,
		8,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29307009] = {
		29307009,
		0,
		Lang.get(69663),
		29307,
		9,
		300
	},
	[29307010] = {
		29307010,
		0,
		Lang.get(69664),
		29307,
		10,
		769,
		{
			RTResTalkAction[30]
		}
	},
	[29307011] = {
		29307011,
		0,
		Lang.get(69665),
		29307,
		11,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29307012] = {
		29307012,
		0,
		Lang.get(69666),
		29307,
		12,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29307013] = {
		29307013,
		0,
		Lang.get(69667),
		29307,
		13,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29307014] = {
		29307014,
		0,
		Lang.get(69668),
		29307,
		14,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29307015] = {
		29307015,
		0,
		Lang.get(69669),
		29307,
		15,
		769,
		{
			RTResTalkAction[29]
		}
	},
	[29308001] = {
		29308001,
		0,
		Lang.get(69670),
		29308,
		1,
		769,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29308,
		nil,
		nil,
		nil,
		nil,
		nil,
		29308
	},
	[29308002] = {
		29308002,
		0,
		Lang.get(69671),
		29308,
		2,
		769,
		{
			RTResTalkAction[32]
		}
	},
	[29308003] = {
		29308003,
		0,
		Lang.get(69672),
		29308,
		3,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29308004] = {
		29308004,
		0,
		Lang.get(69673),
		29308,
		4,
		769,
		{
			RTResTalkAction[33]
		}
	},
	[29308005] = {
		29308005,
		0,
		Lang.get(69674),
		29308,
		5,
		769,
		{
			RTResTalkAction[28]
		}
	},
	[29308006] = {
		29308006,
		0,
		Lang.get(69675),
		29308,
		6,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29308007] = {
		29308007,
		0,
		Lang.get(69676),
		29308,
		7,
		769,
		{
			RTResTalkAction[25]
		}
	},
	[29308008] = {
		29308008,
		0,
		Lang.get(69677),
		29308,
		8,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308009] = {
		29308009,
		0,
		Lang.get(69678),
		29308,
		9,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29308010] = {
		29308010,
		0,
		Lang.get(69679),
		29308,
		10,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308011] = {
		29308011,
		0,
		Lang.get(69680),
		29308,
		11,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308012] = {
		29308012,
		0,
		Lang.get(69681),
		29308,
		12,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308013] = {
		29308013,
		0,
		Lang.get(69682),
		29308,
		13,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308014] = {
		29308014,
		0,
		Lang.get(69683),
		29308,
		14,
		769,
		{
			RTResTalkAction[27]
		}
	},
	[29308015] = {
		29308015,
		0,
		Lang.get(69684),
		29308,
		15,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29308016] = {
		29308016,
		0,
		Lang.get(69685),
		29308,
		16,
		769,
		{
			RTResTalkAction[34]
		}
	},
	[29308017] = {
		29308017,
		0,
		Lang.get(69686),
		29308,
		17,
		300,
		{
			RTResTalkAction[23]
		}
	},
	[29308018] = {
		29308018,
		0,
		Lang.get(69687),
		29308,
		18,
		769,
		{
			RTResTalkAction[29]
		}
	},
	[29309001] = {
		29309001,
		0,
		Lang.get(69688),
		29309,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29309,
		[19] = 29309
	},
	[29309002] = {
		29309002,
		0,
		"……",
		29309,
		2,
		770,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[29309003] = {
		29309003,
		0,
		Lang.get(69689),
		29309,
		3,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29309004] = {
		29309004,
		0,
		"……",
		29309,
		4,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309005] = {
		29309005,
		0,
		Lang.get(69690),
		29309,
		5,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29309006] = {
		29309006,
		0,
		Lang.get(69691),
		29309,
		6,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309007] = {
		29309007,
		0,
		Lang.get(67797),
		29309,
		7,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29309008] = {
		29309008,
		0,
		Lang.get(69692),
		29309,
		8,
		770,
		{
			RTResTalkAction[37]
		}
	},
	[29309009] = {
		29309009,
		0,
		Lang.get(69693),
		29309,
		9,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309010] = {
		29309010,
		0,
		Lang.get(69694),
		29309,
		10,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309011] = {
		29309011,
		0,
		Lang.get(69695),
		29309,
		11,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29309012] = {
		29309012,
		0,
		Lang.get(69696),
		29309,
		12,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309013] = {
		29309013,
		0,
		Lang.get(69697),
		29309,
		13,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29309014] = {
		29309014,
		0,
		Lang.get(66037),
		29309,
		14,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29309015] = {
		29309015,
		0,
		Lang.get(69698),
		29309,
		15,
		770,
		{
			RTResTalkAction[38]
		}
	},
	[29310001] = {
		29310001,
		0,
		Lang.get(69699),
		29310,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29310,
		[19] = 29310
	},
	[29310002] = {
		29310002,
		0,
		Lang.get(69700),
		29310,
		2,
		770,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[29310003] = {
		29310003,
		0,
		Lang.get(69701),
		29310,
		3,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29310004] = {
		29310004,
		0,
		Lang.get(69702),
		29310,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29310005] = {
		29310005,
		0,
		Lang.get(69703),
		29310,
		5,
		300
	},
	[29310006] = {
		29310006,
		0,
		Lang.get(69704),
		29310,
		6,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29310007] = {
		29310007,
		0,
		Lang.get(69705),
		29310,
		7,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29310008] = {
		29310008,
		0,
		Lang.get(69706),
		29310,
		8,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29310009] = {
		29310009,
		0,
		Lang.get(69707),
		29310,
		9,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29310010] = {
		29310010,
		0,
		Lang.get(69708),
		29310,
		10,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29310011] = {
		29310011,
		0,
		Lang.get(69709),
		29310,
		11,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29310012] = {
		29310012,
		0,
		Lang.get(69710),
		29310,
		12,
		770,
		{
			RTResTalkAction[38]
		}
	},
	[29311001] = {
		29311001,
		0,
		Lang.get(22568),
		29311,
		1,
		770,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		29311,
		[19] = 29311
	},
	[29311002] = {
		29311002,
		0,
		Lang.get(69711),
		29311,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29311003] = {
		29311003,
		0,
		Lang.get(69712),
		29311,
		3,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29311004] = {
		29311004,
		0,
		Lang.get(69713),
		29311,
		4,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29311005] = {
		29311005,
		0,
		Lang.get(69714),
		29311,
		5,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29311006] = {
		29311006,
		0,
		Lang.get(69715),
		29311,
		6,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29311007] = {
		29311007,
		0,
		Lang.get(69716),
		29311,
		7,
		300,
		{
			RTResTalkAction[36]
		}
	},
	[29311008] = {
		29311008,
		0,
		Lang.get(69717),
		29311,
		8,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29311009] = {
		29311009,
		0,
		Lang.get(69718),
		29311,
		9,
		770,
		{
			RTResTalkAction[38]
		}
	},
	[29311010] = {
		29311010,
		0,
		Lang.get(69719),
		29311,
		10,
		770,
		{
			RTResTalkAction[35]
		}
	},
	[29312001] = {
		29312001,
		5,
		Lang.get(69720),
		29312,
		1,
		771,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29312,
		nil,
		nil,
		nil,
		nil,
		nil,
		29312
	},
	[29312002] = {
		29312002,
		0,
		Lang.get(69721),
		29312,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29312003] = {
		29312003,
		0,
		Lang.get(69722),
		29312,
		3,
		771,
		{
			RTResTalkAction[39]
		}
	},
	[29312004] = {
		29312004,
		0,
		Lang.get(22381),
		29312,
		4,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29312005] = {
		29312005,
		0,
		Lang.get(69723),
		29312,
		5,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29312006] = {
		29312006,
		0,
		Lang.get(69724),
		29312,
		6,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29312007] = {
		29312007,
		0,
		Lang.get(69725),
		29312,
		7,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29312008] = {
		29312008,
		0,
		Lang.get(69726),
		29312,
		8,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29312009] = {
		29312009,
		4,
		nil,
		29312,
		9,
		300,
		[29] = {
			{
				id = 29312010,
				branch_content = Lang.get(69727)
			},
			{
				id = 29312010,
				branch_content = Lang.get(69728)
			}
		}
	},
	[29312010] = {
		29312010,
		0,
		Lang.get(69729),
		29312,
		10,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29312011] = {
		29312011,
		0,
		Lang.get(69730),
		29312,
		11,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29312012] = {
		29312012,
		0,
		"！",
		29312,
		12,
		771,
		{
			RTResTalkAction[42]
		}
	},
	[29312013] = {
		29312013,
		0,
		Lang.get(21987),
		29312,
		13,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29312014] = {
		29312014,
		0,
		Lang.get(69731),
		29312,
		14,
		771,
		{
			RTResTalkAction[43]
		}
	},
	[29312015] = {
		29312015,
		0,
		Lang.get(69732),
		29312,
		15,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313001] = {
		29313001,
		2,
		Lang.get(69733),
		29313,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29313,
		[19] = 29313
	},
	[29313002] = {
		29313002,
		0,
		Lang.get(69734),
		29313,
		2,
		771,
		{
			RTResTalkAction[44]
		},
		nil,
		nil,
		3
	},
	[29313003] = {
		29313003,
		0,
		Lang.get(69735),
		29313,
		3,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313004] = {
		29313004,
		0,
		Lang.get(69736),
		29313,
		4,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29313005] = {
		29313005,
		0,
		Lang.get(69737),
		29313,
		5,
		300
	},
	[29313006] = {
		29313006,
		0,
		Lang.get(69738),
		29313,
		6,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313007] = {
		29313007,
		0,
		Lang.get(69739),
		29313,
		7,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313008] = {
		29313008,
		0,
		Lang.get(69740),
		29313,
		8,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313009] = {
		29313009,
		4,
		nil,
		29313,
		9,
		300,
		{
			RTResTalkAction[40]
		},
		[29] = {
			{
				id = 29313010,
				branch_content = Lang.get(69741)
			},
			{
				id = 29313010,
				branch_content = Lang.get(69742)
			}
		}
	},
	[29313010] = {
		29313010,
		0,
		Lang.get(69743),
		29313,
		10,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29313011] = {
		29313011,
		0,
		Lang.get(69744),
		29313,
		11,
		771,
		{
			RTResTalkAction[39]
		}
	},
	[29313012] = {
		29313012,
		0,
		Lang.get(69745),
		29313,
		12,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29313013] = {
		29313013,
		0,
		Lang.get(69746),
		29313,
		13,
		771,
		{
			RTResTalkAction[44]
		}
	},
	[29313014] = {
		29313014,
		0,
		Lang.get(69747),
		29313,
		14,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29313015] = {
		29313015,
		0,
		Lang.get(69748),
		29313,
		15,
		300
	},
	[29313016] = {
		29313016,
		0,
		Lang.get(69749),
		29313,
		16,
		771,
		{
			RTResTalkAction[39]
		}
	},
	[29314001] = {
		29314001,
		0,
		Lang.get(69750),
		29314,
		1,
		771,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29314,
		nil,
		nil,
		nil,
		nil,
		nil,
		29314
	},
	[29314002] = {
		29314002,
		0,
		Lang.get(69751),
		29314,
		2,
		771,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[29314003] = {
		29314003,
		0,
		Lang.get(69752),
		29314,
		3,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29314004] = {
		29314004,
		0,
		Lang.get(69753),
		29314,
		4,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29314005] = {
		29314005,
		0,
		Lang.get(69754),
		29314,
		5,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29314006] = {
		29314006,
		0,
		Lang.get(69755),
		29314,
		6,
		300
	},
	[29314007] = {
		29314007,
		0,
		Lang.get(69756),
		29314,
		7,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29314008] = {
		29314008,
		0,
		Lang.get(69757),
		29314,
		8,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29314009] = {
		29314009,
		0,
		Lang.get(69758),
		29314,
		9,
		771,
		{
			RTResTalkAction[39]
		}
	},
	[29314010] = {
		29314010,
		0,
		Lang.get(69759),
		29314,
		10,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29314011] = {
		29314011,
		0,
		Lang.get(69760),
		29314,
		11,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29314012] = {
		29314012,
		0,
		Lang.get(69761),
		29314,
		12,
		771,
		{
			RTResTalkAction[41]
		}
	},
	[29314013] = {
		29314013,
		0,
		Lang.get(69762),
		29314,
		13,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29314014] = {
		29314014,
		5,
		Lang.get(69763),
		29314,
		14,
		771,
		{
			RTResTalkAction[46]
		}
	},
	[29314015] = {
		29314015,
		0,
		Lang.get(69764),
		29314,
		15,
		300,
		{
			RTResTalkAction[40]
		}
	},
	[29315001] = {
		29315001,
		0,
		Lang.get(70089),
		29315,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		29315,
		[19] = 29315
	},
	[29315002] = {
		29315002,
		0,
		Lang.get(70090),
		29315,
		2,
		772,
		{
			RTResTalkAction[47]
		},
		nil,
		nil,
		3
	},
	[29315003] = {
		29315003,
		0,
		Lang.get(70091),
		29315,
		3,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29315004] = {
		29315004,
		0,
		Lang.get(70092),
		29315,
		4,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29315005] = {
		29315005,
		0,
		Lang.get(70093),
		29315,
		5,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29315006] = {
		29315006,
		0,
		Lang.get(70094),
		29315,
		6,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29315007] = {
		29315007,
		0,
		Lang.get(70095),
		29315,
		7,
		300
	},
	[29315008] = {
		29315008,
		0,
		Lang.get(70096),
		29315,
		8,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29315009] = {
		29315009,
		0,
		Lang.get(70097),
		29315,
		9,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29315010] = {
		29315010,
		0,
		Lang.get(70098),
		29315,
		10,
		300
	},
	[29315011] = {
		29315011,
		0,
		Lang.get(70099),
		29315,
		11,
		772,
		{
			RTResTalkAction[49]
		}
	},
	[29315012] = {
		29315012,
		5,
		Lang.get(70100),
		29315,
		12,
		772,
		{
			RTResTalkAction[50]
		}
	},
	[29315013] = {
		29315013,
		0,
		Lang.get(70101),
		29315,
		13,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29316001] = {
		29316001,
		0,
		Lang.get(70102),
		29316,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		29316,
		[19] = 29316
	},
	[29316002] = {
		29316002,
		0,
		Lang.get(70103),
		29316,
		2,
		300
	},
	[29316003] = {
		29316003,
		0,
		Lang.get(70104),
		29316,
		3,
		300
	},
	[29316004] = {
		29316004,
		3,
		Lang.get(70105),
		29316,
		4,
		605,
		[22] = 1
	},
	[29316005] = {
		29316005,
		0,
		"……",
		29316,
		5,
		772,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[29316006] = {
		29316006,
		0,
		Lang.get(70106),
		29316,
		6,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29316007] = {
		29316007,
		0,
		"……",
		29316,
		7,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29316008] = {
		29316008,
		0,
		Lang.get(70107),
		29316,
		8,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29316009] = {
		29316009,
		0,
		Lang.get(70108),
		29316,
		9,
		300
	},
	[29316010] = {
		29316010,
		0,
		Lang.get(70109),
		29316,
		10,
		300
	},
	[29316011] = {
		29316011,
		0,
		Lang.get(70110),
		29316,
		11,
		772,
		{
			RTResTalkAction[49]
		}
	},
	[29316012] = {
		29316012,
		0,
		Lang.get(70111),
		29316,
		12,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29316013] = {
		29316013,
		0,
		Lang.get(70112),
		29316,
		13,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29316014] = {
		29316014,
		0,
		"……",
		29316,
		14,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29317001] = {
		29317001,
		0,
		Lang.get(70113),
		29317,
		1,
		772,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29317,
		nil,
		nil,
		nil,
		nil,
		nil,
		29317
	},
	[29317002] = {
		29317002,
		0,
		Lang.get(70114),
		29317,
		2,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29317003] = {
		29317003,
		0,
		Lang.get(70115),
		29317,
		3,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29317004] = {
		29317004,
		0,
		Lang.get(70116),
		29317,
		4,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29317005] = {
		29317005,
		0,
		"……",
		29317,
		5,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29317006] = {
		29317006,
		0,
		Lang.get(70117),
		29317,
		6,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29317007] = {
		29317007,
		0,
		Lang.get(70118),
		29317,
		7,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29317008] = {
		29317008,
		0,
		Lang.get(70119),
		29317,
		8,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29317009] = {
		29317009,
		0,
		Lang.get(28565),
		29317,
		9,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29317010] = {
		29317010,
		0,
		Lang.get(70120),
		29317,
		10,
		772,
		{
			RTResTalkAction[47]
		}
	},
	[29317011] = {
		29317011,
		0,
		Lang.get(66037),
		29317,
		11,
		300,
		{
			RTResTalkAction[48]
		}
	},
	[29317012] = {
		29317012,
		0,
		Lang.get(71074),
		29317,
		12,
		772,
		{
			RTResTalkAction[49]
		}
	},
	[29318001] = {
		29318001,
		0,
		Lang.get(70122),
		29318,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29318,
		nil,
		nil,
		nil,
		nil,
		nil,
		29318
	},
	[29318002] = {
		29318002,
		0,
		Lang.get(70123),
		29318,
		2,
		300
	},
	[29318003] = {
		29318003,
		0,
		Lang.get(70124),
		29318,
		3,
		149,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[29318004] = {
		29318004,
		0,
		Lang.get(70125),
		29318,
		4,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29318005] = {
		29318005,
		0,
		Lang.get(70126),
		29318,
		5,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29318006] = {
		29318006,
		0,
		Lang.get(70127),
		29318,
		6,
		300,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[29318007] = {
		29318007,
		0,
		Lang.get(70128),
		29318,
		7,
		149,
		{
			RTResTalkAction[51],
			RTResTalkAction[54]
		}
	},
	[29318008] = {
		29318008,
		4,
		nil,
		29318,
		8,
		300,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 29318009,
				branch_content = Lang.get(70129)
			},
			{
				id = 29318009,
				branch_content = Lang.get(70130)
			}
		}
	},
	[29318009] = {
		29318009,
		0,
		Lang.get(70131),
		29318,
		9,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29318010] = {
		29318010,
		0,
		Lang.get(70132),
		29318,
		10,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29318011] = {
		29318011,
		0,
		Lang.get(70133),
		29318,
		11,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29318012] = {
		29318012,
		0,
		Lang.get(70134),
		29318,
		12,
		300,
		{
			RTResTalkAction[52],
			RTResTalkAction[53]
		}
	},
	[29318013] = {
		29318013,
		0,
		Lang.get(70135),
		29318,
		13,
		149,
		{
			RTResTalkAction[55],
			RTResTalkAction[54]
		}
	},
	[29319001] = {
		29319001,
		0,
		Lang.get(70136),
		29319,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29319,
		nil,
		nil,
		nil,
		nil,
		nil,
		29319
	},
	[29319002] = {
		29319002,
		0,
		Lang.get(70137),
		29319,
		2,
		300
	},
	[29319003] = {
		29319003,
		0,
		Lang.get(70138),
		29319,
		3,
		149,
		{
			RTResTalkAction[56]
		},
		nil,
		nil,
		3
	},
	[29319004] = {
		29319004,
		4,
		nil,
		29319,
		4,
		300,
		{
			RTResTalkAction[53]
		},
		[29] = {
			{
				id = 29319005,
				branch_content = Lang.get(70139)
			},
			{
				id = 29319005,
				branch_content = Lang.get(70140)
			}
		}
	},
	[29319005] = {
		29319005,
		0,
		Lang.get(70141),
		29319,
		5,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29319006] = {
		29319006,
		0,
		Lang.get(70142),
		29319,
		6,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29319007] = {
		29319007,
		0,
		Lang.get(70143),
		29319,
		7,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29319008] = {
		29319008,
		0,
		Lang.get(70144),
		29319,
		8,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29319009] = {
		29319009,
		0,
		Lang.get(70145),
		29319,
		9,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29319010] = {
		29319010,
		0,
		Lang.get(70146),
		29319,
		10,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29319011] = {
		29319011,
		0,
		Lang.get(70147),
		29319,
		11,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29319012] = {
		29319012,
		0,
		Lang.get(70148),
		29319,
		12,
		149,
		{
			RTResTalkAction[57]
		}
	},
	[29319013] = {
		29319013,
		0,
		Lang.get(70149),
		29319,
		13,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29319014] = {
		29319014,
		0,
		Lang.get(70150),
		29319,
		14,
		149,
		{
			RTResTalkAction[58]
		}
	},
	[29320001] = {
		29320001,
		0,
		Lang.get(70151),
		29320,
		1,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		29320,
		nil,
		nil,
		nil,
		nil,
		nil,
		29320
	},
	[29320002] = {
		29320002,
		0,
		Lang.get(70152),
		29320,
		2,
		149,
		{
			RTResTalkAction[51]
		},
		nil,
		nil,
		3
	},
	[29320003] = {
		29320003,
		0,
		Lang.get(70153),
		29320,
		3,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29320004] = {
		29320004,
		0,
		Lang.get(70154),
		29320,
		4,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29320005] = {
		29320005,
		0,
		Lang.get(70155),
		29320,
		5,
		149,
		{
			RTResTalkAction[58]
		}
	},
	[29320006] = {
		29320006,
		0,
		Lang.get(70156),
		29320,
		6,
		149,
		{
			RTResTalkAction[59]
		}
	},
	[29320007] = {
		29320007,
		0,
		Lang.get(70157),
		29320,
		7,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29320008] = {
		29320008,
		0,
		Lang.get(70158),
		29320,
		8,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29320009] = {
		29320009,
		0,
		Lang.get(70159),
		29320,
		9,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29320010] = {
		29320010,
		0,
		Lang.get(70160),
		29320,
		10,
		149,
		{
			RTResTalkAction[51]
		}
	},
	[29320011] = {
		29320011,
		0,
		Lang.get(70161),
		29320,
		11,
		300,
		{
			RTResTalkAction[53]
		}
	},
	[29320012] = {
		29320012,
		0,
		Lang.get(70162),
		29320,
		12,
		149,
		{
			RTResTalkAction[60]
		}
	},
	[29321001] = {
		29321001,
		0,
		Lang.get(70163),
		29321,
		1,
		127,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29321,
		nil,
		nil,
		nil,
		nil,
		nil,
		29321
	},
	[29321002] = {
		29321002,
		0,
		Lang.get(70164),
		29321,
		2,
		127,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[29321003] = {
		29321003,
		0,
		Lang.get(70165),
		29321,
		3,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321004] = {
		29321004,
		0,
		Lang.get(70166),
		29321,
		4,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29321005] = {
		29321005,
		0,
		Lang.get(70167),
		29321,
		5,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321006] = {
		29321006,
		0,
		Lang.get(70168),
		29321,
		6,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321007] = {
		29321007,
		0,
		Lang.get(70169),
		29321,
		7,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321008] = {
		29321008,
		0,
		Lang.get(70170),
		29321,
		8,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29321009] = {
		29321009,
		0,
		Lang.get(70171),
		29321,
		9,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321010] = {
		29321010,
		0,
		Lang.get(70172),
		29321,
		10,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29321011] = {
		29321011,
		0,
		Lang.get(70173),
		29321,
		11,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321012] = {
		29321012,
		0,
		Lang.get(70174),
		29321,
		12,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29321013] = {
		29321013,
		0,
		Lang.get(70175),
		29321,
		13,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29321014] = {
		29321014,
		0,
		Lang.get(70176),
		29321,
		14,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322001] = {
		29322001,
		0,
		Lang.get(70177),
		29322,
		1,
		127,
		{
			RTResTalkAction[61]
		},
		1,
		nil,
		nil,
		nil,
		60,
		29322,
		nil,
		nil,
		nil,
		nil,
		nil,
		29322
	},
	[29322002] = {
		29322002,
		0,
		Lang.get(70178),
		29322,
		2,
		127,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[29322003] = {
		29322003,
		0,
		Lang.get(70179),
		29322,
		3,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29322004] = {
		29322004,
		0,
		Lang.get(70180),
		29322,
		4,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322005] = {
		29322005,
		0,
		Lang.get(70181),
		29322,
		5,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322006] = {
		29322006,
		0,
		Lang.get(70182),
		29322,
		6,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322007] = {
		29322007,
		0,
		Lang.get(70183),
		29322,
		7,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29322008] = {
		29322008,
		0,
		Lang.get(70184),
		29322,
		8,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322009] = {
		29322009,
		0,
		Lang.get(70185),
		29322,
		9,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322010] = {
		29322010,
		4,
		nil,
		29322,
		10,
		300,
		{
			RTResTalkAction[62]
		},
		[29] = {
			{
				id = 29322011,
				branch_content = Lang.get(18444)
			},
			{
				id = 29322011,
				branch_content = Lang.get(70186)
			}
		}
	},
	[29322011] = {
		29322011,
		0,
		Lang.get(70187),
		29322,
		11,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322012] = {
		29322012,
		0,
		Lang.get(70188),
		29322,
		12,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29322013] = {
		29322013,
		0,
		Lang.get(70189),
		29322,
		13,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322014] = {
		29322014,
		0,
		Lang.get(70190),
		29322,
		14,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29322015] = {
		29322015,
		0,
		Lang.get(70191),
		29322,
		15,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323001] = {
		29323001,
		0,
		Lang.get(70192),
		29323,
		1,
		127,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		29323,
		nil,
		nil,
		nil,
		nil,
		nil,
		29323
	},
	[29323002] = {
		29323002,
		0,
		Lang.get(70193),
		29323,
		2,
		127,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		3
	},
	[29323003] = {
		29323003,
		0,
		Lang.get(70194),
		29323,
		3,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323004] = {
		29323004,
		4,
		nil,
		29323,
		4,
		300,
		{
			RTResTalkAction[62]
		},
		[29] = {
			{
				id = 29323005,
				branch_content = Lang.get(70195)
			},
			{
				id = 29323005,
				branch_content = Lang.get(70196)
			}
		}
	},
	[29323005] = {
		29323005,
		0,
		Lang.get(70197),
		29323,
		5,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323006] = {
		29323006,
		0,
		Lang.get(70198),
		29323,
		6,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323007] = {
		29323007,
		0,
		Lang.get(70199),
		29323,
		7,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323008] = {
		29323008,
		0,
		Lang.get(70200),
		29323,
		8,
		300,
		{
			RTResTalkAction[62]
		}
	},
	[29323009] = {
		29323009,
		0,
		Lang.get(70201),
		29323,
		9,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323010] = {
		29323010,
		0,
		Lang.get(70202),
		29323,
		10,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323011] = {
		29323011,
		0,
		Lang.get(70203),
		29323,
		11,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29323012] = {
		29323012,
		0,
		Lang.get(70204),
		29323,
		12,
		127,
		{
			RTResTalkAction[61]
		}
	},
	[29324001] = {
		29324001,
		0,
		Lang.get(70205),
		29324,
		1,
		773,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29324,
		nil,
		nil,
		nil,
		nil,
		nil,
		29324
	},
	[29324002] = {
		29324002,
		0,
		Lang.get(70206),
		29324,
		2,
		773,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[29324003] = {
		29324003,
		0,
		Lang.get(70207),
		29324,
		3,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29324004] = {
		29324004,
		0,
		Lang.get(70208),
		29324,
		4,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29324005] = {
		29324005,
		0,
		Lang.get(70209),
		29324,
		5,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29324006] = {
		29324006,
		0,
		"............",
		29324,
		6,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29324007] = {
		29324007,
		0,
		Lang.get(70210),
		29324,
		7,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29324008] = {
		29324008,
		0,
		Lang.get(70211),
		29324,
		8,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29324009] = {
		29324009,
		0,
		Lang.get(70212),
		29324,
		9,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325001] = {
		29325001,
		0,
		Lang.get(70213),
		29325,
		1,
		773,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29325,
		nil,
		nil,
		nil,
		nil,
		nil,
		29325
	},
	[29325002] = {
		29325002,
		0,
		Lang.get(70214),
		29325,
		2,
		773,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[29325003] = {
		29325003,
		0,
		Lang.get(70215),
		29325,
		3,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29325004] = {
		29325004,
		0,
		Lang.get(70216),
		29325,
		4,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325005] = {
		29325005,
		0,
		Lang.get(70217),
		29325,
		5,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29325006] = {
		29325006,
		0,
		"............",
		29325,
		6,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325007] = {
		29325007,
		0,
		Lang.get(70218),
		29325,
		7,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29325008] = {
		29325008,
		0,
		Lang.get(70219),
		29325,
		8,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325009] = {
		29325009,
		0,
		Lang.get(70220),
		29325,
		9,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325010] = {
		29325010,
		0,
		Lang.get(70221),
		29325,
		10,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29325011] = {
		29325011,
		0,
		Lang.get(70222),
		29325,
		11,
		300,
		{
			RTResTalkAction[52],
			RTResTalkAction[64]
		},
		[29] = {
			{
				id = 29325012,
				branch_content = Lang.get(70222)
			},
			{
				id = 29325012,
				branch_content = Lang.get(70223)
			}
		}
	},
	[29325012] = {
		29325012,
		0,
		Lang.get(70224),
		29325,
		12,
		773,
		{
			RTResTalkAction[63],
			RTResTalkAction[54]
		}
	},
	[29326001] = {
		29326001,
		0,
		Lang.get(70225),
		29326,
		1,
		773,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		29326,
		nil,
		nil,
		nil,
		nil,
		nil,
		29326
	},
	[29326002] = {
		29326002,
		0,
		Lang.get(70226),
		29326,
		2,
		300
	},
	[29326003] = {
		29326003,
		0,
		Lang.get(70227),
		29326,
		3,
		773,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		3
	},
	[29326004] = {
		29326004,
		0,
		Lang.get(70228),
		29326,
		4,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29326005] = {
		29326005,
		0,
		Lang.get(70229),
		29326,
		5,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326006] = {
		29326006,
		0,
		Lang.get(70230),
		29326,
		6,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326007] = {
		29326007,
		0,
		Lang.get(70231),
		29326,
		7,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29326008] = {
		29326008,
		0,
		Lang.get(70232),
		29326,
		8,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326009] = {
		29326009,
		0,
		Lang.get(70233),
		29326,
		9,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326010] = {
		29326010,
		0,
		Lang.get(70234),
		29326,
		10,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326011] = {
		29326011,
		0,
		Lang.get(22711),
		29326,
		11,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29326012] = {
		29326012,
		0,
		Lang.get(70235),
		29326,
		12,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29326013] = {
		29326013,
		0,
		Lang.get(70236),
		29326,
		13,
		300,
		{
			RTResTalkAction[64]
		}
	},
	[29326014] = {
		29326014,
		0,
		Lang.get(70237),
		29326,
		14,
		773,
		{
			RTResTalkAction[63]
		}
	},
	[29327001] = {
		29327001,
		0,
		Lang.get(82804),
		29327,
		1,
		1047,
		{
			RTResTalkAction[65]
		},
		nil,
		nil,
		3,
		nil,
		60,
		29327,
		1,
		nil,
		nil,
		nil,
		nil,
		29327
	},
	[29327002] = {
		29327002,
		0,
		Lang.get(82805),
		29327,
		2,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327003] = {
		29327003,
		0,
		Lang.get(82806),
		29327,
		3,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29327004] = {
		29327004,
		0,
		Lang.get(82807),
		29327,
		4,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29327005] = {
		29327005,
		0,
		Lang.get(82808),
		29327,
		5,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327006] = {
		29327006,
		0,
		Lang.get(82809),
		29327,
		6,
		300
	},
	[29327007] = {
		29327007,
		0,
		Lang.get(82810),
		29327,
		7,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29327008] = {
		29327008,
		0,
		Lang.get(82811),
		29327,
		8,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327009] = {
		29327009,
		0,
		Lang.get(82812),
		29327,
		9,
		1047,
		{
			RTResTalkAction[69]
		}
	},
	[29327010] = {
		29327010,
		0,
		Lang.get(82813),
		29327,
		10,
		1047,
		{
			RTResTalkAction[70]
		}
	},
	[29327011] = {
		29327011,
		0,
		Lang.get(82814),
		29327,
		11,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327012] = {
		29327012,
		0,
		Lang.get(82815),
		29327,
		12,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29327013] = {
		29327013,
		0,
		Lang.get(82816),
		29327,
		13,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327014] = {
		29327014,
		0,
		Lang.get(82817),
		29327,
		14,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29327015] = {
		29327015,
		0,
		Lang.get(82818),
		29327,
		15,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29327016] = {
		29327016,
		0,
		Lang.get(82819),
		29327,
		16,
		300
	},
	[29327017] = {
		29327017,
		0,
		Lang.get(82820),
		29327,
		17,
		1047,
		{
			RTResTalkAction[65]
		}
	},
	[29327018] = {
		29327018,
		0,
		Lang.get(82821),
		29327,
		18,
		605,
		{
			RTResTalkAction[66]
		},
		[20] = 200
	},
	[29327019] = {
		29327019,
		2,
		Lang.get(82822),
		29327,
		19,
		300,
		[20] = 0
	},
	[29328001] = {
		29328001,
		0,
		Lang.get(82823),
		29328,
		1,
		1047,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3,
		nil,
		158,
		29328,
		1,
		nil,
		nil,
		nil,
		nil,
		29328
	},
	[29328002] = {
		29328002,
		5,
		Lang.get(82824),
		29328,
		2,
		1047,
		{
			RTResTalkAction[71]
		}
	},
	[29328003] = {
		29328003,
		0,
		Lang.get(82825),
		29328,
		3,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328004] = {
		29328004,
		5,
		Lang.get(82826),
		29328,
		4,
		1047,
		{
			RTResTalkAction[72]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[29328005] = {
		29328005,
		0,
		Lang.get(82827),
		29328,
		5,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328006] = {
		29328006,
		0,
		Lang.get(82828),
		29328,
		6,
		1047,
		{
			RTResTalkAction[73]
		}
	},
	[29328007] = {
		29328007,
		0,
		Lang.get(82829),
		29328,
		7,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328008] = {
		29328008,
		0,
		Lang.get(82830),
		29328,
		8,
		300
	},
	[29328009] = {
		29328009,
		0,
		Lang.get(82831),
		29328,
		9,
		1047,
		{
			RTResTalkAction[70]
		}
	},
	[29328010] = {
		29328010,
		0,
		Lang.get(82832),
		29328,
		10,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29328011] = {
		29328011,
		0,
		Lang.get(82833),
		29328,
		11,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328012] = {
		29328012,
		3,
		Lang.get(82834),
		29328,
		12,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		[22] = 1
	},
	[29328013] = {
		29328013,
		0,
		Lang.get(82835),
		29328,
		13,
		1047,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29328014] = {
		29328014,
		0,
		Lang.get(82836),
		29328,
		14,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29328015] = {
		29328015,
		0,
		Lang.get(82837),
		29328,
		15,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29328016] = {
		29328016,
		0,
		Lang.get(26755),
		29328,
		16,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328017] = {
		29328017,
		0,
		Lang.get(82838),
		29328,
		17,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29328018] = {
		29328018,
		0,
		Lang.get(82839),
		29328,
		18,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29328019] = {
		29328019,
		0,
		Lang.get(82840),
		29328,
		19,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328020] = {
		29328020,
		0,
		Lang.get(82841),
		29328,
		20,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29328021] = {
		29328021,
		0,
		Lang.get(82842),
		29328,
		21,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29328022] = {
		29328022,
		0,
		Lang.get(82843),
		29328,
		22,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29328023] = {
		29328023,
		0,
		Lang.get(82844),
		29328,
		23,
		1047,
		{
			RTResTalkAction[73]
		}
	},
	[29328024] = {
		29328024,
		0,
		Lang.get(82845),
		29328,
		24,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329001] = {
		29329001,
		0,
		Lang.get(82846),
		29329,
		1,
		1047,
		{
			RTResTalkAction[68]
		},
		nil,
		nil,
		3,
		nil,
		62,
		29329,
		1,
		nil,
		nil,
		nil,
		nil,
		29329
	},
	[29329002] = {
		29329002,
		0,
		Lang.get(82847),
		29329,
		2,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329003] = {
		29329003,
		0,
		Lang.get(82848),
		29329,
		3,
		300
	},
	[29329004] = {
		29329004,
		0,
		Lang.get(82849),
		29329,
		4,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29329005] = {
		29329005,
		0,
		Lang.get(82850),
		29329,
		5,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329006] = {
		29329006,
		0,
		Lang.get(82851),
		29329,
		6,
		1047,
		{
			RTResTalkAction[74]
		}
	},
	[29329007] = {
		29329007,
		0,
		Lang.get(82852),
		29329,
		7,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29329008] = {
		29329008,
		0,
		Lang.get(82853),
		29329,
		8,
		1047,
		{
			RTResTalkAction[73]
		}
	},
	[29329009] = {
		29329009,
		0,
		Lang.get(82854),
		29329,
		9,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329010] = {
		29329010,
		0,
		Lang.get(82855),
		29329,
		10,
		1047,
		{
			RTResTalkAction[69]
		}
	},
	[29329011] = {
		29329011,
		0,
		Lang.get(82856),
		29329,
		11,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329012] = {
		29329012,
		0,
		Lang.get(82857),
		29329,
		12,
		1047,
		{
			RTResTalkAction[69]
		}
	},
	[29329013] = {
		29329013,
		0,
		Lang.get(82858),
		29329,
		13,
		1047,
		{
			RTResTalkAction[75]
		}
	},
	[29329014] = {
		29329014,
		0,
		Lang.get(82859),
		29329,
		14,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29329015] = {
		29329015,
		0,
		Lang.get(82860),
		29329,
		15,
		1047,
		{
			RTResTalkAction[68]
		}
	},
	[29329016] = {
		29329016,
		3,
		Lang.get(82861),
		29329,
		16,
		605,
		{
			RTResTalkAction[66]
		},
		[22] = 1
	},
	[29329017] = {
		29329017,
		0,
		Lang.get(82862),
		29329,
		17,
		300
	},
	[29329018] = {
		29329018,
		0,
		Lang.get(82863),
		29329,
		18,
		1047,
		{
			RTResTalkAction[67]
		}
	},
	[29329019] = {
		29329019,
		0,
		Lang.get(82864),
		29329,
		19,
		300,
		{
			RTResTalkAction[66]
		}
	},
	[29330001] = {
		29330001,
		0,
		Lang.get(87454),
		29330,
		1,
		1118,
		nil,
		1,
		3,
		nil,
		nil,
		60,
		29330,
		nil,
		nil,
		nil,
		nil,
		nil,
		29330
	},
	[29330002] = {
		29330002,
		0,
		Lang.get(87455),
		29330,
		2,
		300
	},
	[29330003] = {
		29330003,
		0,
		Lang.get(87456),
		29330,
		3,
		1118,
		{
			RTResTalkAction[76]
		},
		nil,
		nil,
		3
	},
	[29330004] = {
		29330004,
		0,
		Lang.get(87457),
		29330,
		4,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29330005] = {
		29330005,
		0,
		Lang.get(87458),
		29330,
		5,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29330006] = {
		29330006,
		0,
		Lang.get(87459),
		29330,
		6,
		300
	},
	[29330007] = {
		29330007,
		0,
		Lang.get(87460),
		29330,
		7,
		1118,
		{
			RTResTalkAction[79]
		}
	},
	[29330008] = {
		29330008,
		0,
		Lang.get(87461),
		29330,
		8,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29330009] = {
		29330009,
		3,
		Lang.get(87462),
		29330,
		9,
		605,
		nil,
		nil,
		nil,
		255,
		[22] = 1
	},
	[29330010] = {
		29330010,
		0,
		Lang.get(87463),
		29330,
		10,
		1118,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		1,
		[17] = 1
	},
	[29330011] = {
		29330011,
		0,
		Lang.get(87464),
		29330,
		11,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29330012] = {
		29330012,
		0,
		Lang.get(87465),
		29330,
		12,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29330013] = {
		29330013,
		0,
		Lang.get(87466),
		29330,
		13,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29330014] = {
		29330014,
		0,
		Lang.get(87467),
		29330,
		14,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29330015] = {
		29330015,
		4,
		nil,
		29330,
		15,
		300,
		[29] = {
			{
				id = 29330016,
				branch_content = Lang.get(87468)
			},
			{
				id = 29330016,
				branch_content = Lang.get(87469)
			}
		}
	},
	[29330016] = {
		29330016,
		0,
		Lang.get(87470),
		29330,
		16,
		1118,
		{
			RTResTalkAction[80]
		}
	},
	[29330017] = {
		29330017,
		3,
		Lang.get(87471),
		29330,
		17,
		605,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		255,
		[22] = 1
	},
	[29330018] = {
		29330018,
		0,
		Lang.get(87472),
		29330,
		18,
		300,
		nil,
		nil,
		nil,
		-1,
		nil,
		nil,
		nil,
		1,
		[17] = 1
	},
	[29331001] = {
		29331001,
		0,
		Lang.get(87473),
		29331,
		1,
		1118,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		29331,
		[19] = 29331
	},
	[29331002] = {
		29331002,
		0,
		Lang.get(87474),
		29331,
		2,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29331003] = {
		29331003,
		0,
		Lang.get(87475),
		29331,
		3,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29331004] = {
		29331004,
		0,
		Lang.get(87476),
		29331,
		4,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29331005] = {
		29331005,
		3,
		Lang.get(87477),
		29331,
		5,
		605,
		[22] = 1
	},
	[29331006] = {
		29331006,
		0,
		Lang.get(87478),
		29331,
		6,
		300
	},
	[29331007] = {
		29331007,
		0,
		Lang.get(87479),
		29331,
		7,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29331008] = {
		29331008,
		4,
		nil,
		29331,
		8,
		300,
		{
			RTResTalkAction[78]
		},
		[29] = {
			{
				id = 29331009,
				branch_content = Lang.get(87480)
			},
			{
				id = 29331009,
				branch_content = Lang.get(87481)
			}
		}
	},
	[29331009] = {
		29331009,
		0,
		Lang.get(87482),
		29331,
		9,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29331010] = {
		29331010,
		0,
		Lang.get(87483),
		29331,
		10,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29331011] = {
		29331011,
		0,
		"？",
		29331,
		11,
		1118,
		{
			RTResTalkAction[81]
		}
	},
	[29331012] = {
		29331012,
		0,
		Lang.get(87484),
		29331,
		12,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29331013] = {
		29331013,
		0,
		Lang.get(87485),
		29331,
		13,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29331014] = {
		29331014,
		0,
		Lang.get(87486),
		29331,
		14,
		300
	},
	[29331015] = {
		29331015,
		0,
		Lang.get(87487),
		29331,
		15,
		1118,
		{
			RTResTalkAction[82]
		}
	},
	[29331016] = {
		29331016,
		0,
		Lang.get(87488),
		29331,
		16,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29331017] = {
		29331017,
		0,
		Lang.get(87489),
		29331,
		17,
		1118,
		{
			RTResTalkAction[83]
		}
	},
	[29331018] = {
		29331018,
		0,
		Lang.get(87490),
		29331,
		18,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29332001] = {
		29332001,
		0,
		Lang.get(87491),
		29332,
		1,
		1118,
		nil,
		1,
		3,
		nil,
		nil,
		58,
		29332,
		nil,
		nil,
		nil,
		nil,
		nil,
		29332
	},
	[29332002] = {
		29332002,
		0,
		Lang.get(87492),
		29332,
		2,
		300
	},
	[29332003] = {
		29332003,
		0,
		Lang.get(87493),
		29332,
		3,
		300
	},
	[29332004] = {
		29332004,
		0,
		Lang.get(87494),
		29332,
		4,
		1118,
		nil,
		1,
		0
	},
	[29332005] = {
		29332005,
		0,
		Lang.get(87495),
		29332,
		5,
		1118,
		nil,
		1
	},
	[29332006] = {
		29332006,
		0,
		Lang.get(87496),
		29332,
		6,
		300
	},
	[29332007] = {
		29332007,
		0,
		Lang.get(87497),
		29332,
		7,
		1118,
		nil,
		1,
		4
	},
	[29332008] = {
		29332008,
		0,
		Lang.get(87498),
		29332,
		8,
		300
	},
	[29332009] = {
		29332009,
		0,
		Lang.get(87499),
		29332,
		9,
		300
	},
	[29332010] = {
		29332010,
		0,
		Lang.get(87500),
		29332,
		10,
		1118,
		nil,
		1,
		0
	},
	[29332011] = {
		29332011,
		0,
		Lang.get(87501),
		29332,
		11,
		1118,
		nil,
		1
	},
	[29332012] = {
		29332012,
		0,
		Lang.get(87502),
		29332,
		12,
		300
	},
	[29332013] = {
		29332013,
		4,
		nil,
		29332,
		13,
		300,
		[29] = {
			{
				id = 29332014,
				branch_content = Lang.get(87503)
			},
			{
				id = 29332014,
				branch_content = Lang.get(87504)
			}
		}
	},
	[29332014] = {
		29332014,
		0,
		Lang.get(87505),
		29332,
		14,
		1118,
		nil,
		1
	},
	[29332015] = {
		29332015,
		0,
		Lang.get(87506),
		29332,
		15,
		300,
		nil,
		nil,
		nil,
		3
	},
	[29332016] = {
		29332016,
		0,
		Lang.get(87507),
		29332,
		16,
		300
	},
	[29332017] = {
		29332017,
		0,
		Lang.get(87508),
		29332,
		17,
		1118,
		{
			RTResTalkAction[80]
		}
	},
	[29332018] = {
		29332018,
		0,
		Lang.get(87509),
		29332,
		18,
		1118,
		{
			RTResTalkAction[77]
		}
	},
	[29332019] = {
		29332019,
		0,
		Lang.get(87510),
		29332,
		19,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29332020] = {
		29332020,
		0,
		Lang.get(87511),
		29332,
		20,
		1118,
		{
			RTResTalkAction[83]
		}
	},
	[29332021] = {
		29332021,
		0,
		Lang.get(87512),
		29332,
		21,
		300,
		{
			RTResTalkAction[78]
		}
	},
	[29333001] = {
		29333001,
		0,
		Lang.get(90178),
		29333,
		1,
		1144,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3,
		nil,
		63,
		29333,
		nil,
		nil,
		nil,
		nil,
		nil,
		29333,
		200
	},
	[29333002] = {
		29333002,
		0,
		"……！",
		29333,
		2,
		300,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = 200
	},
	[29333003] = {
		29333003,
		3,
		Lang.get(90179),
		29333,
		3,
		605,
		{
			RTResTalkAction[85]
		},
		[22] = 1,
		[20] = 200
	},
	[29333004] = {
		29333004,
		0,
		Lang.get(90180),
		29333,
		4,
		1144,
		{
			RTResTalkAction[84]
		},
		[20] = 200
	},
	[29333005] = {
		29333005,
		0,
		Lang.get(90181),
		29333,
		5,
		1144,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[20] = 200
	},
	[29333006] = {
		29333006,
		3,
		Lang.get(89446),
		29333,
		6,
		605,
		{
			RTResTalkAction[85]
		},
		[22] = 1,
		[20] = 255
	},
	[29333007] = {
		29333007,
		0,
		Lang.get(90182),
		29333,
		7,
		1144,
		{
			RTResTalkAction[86]
		},
		nil,
		nil,
		nil,
		nil,
		62,
		[20] = -1
	},
	[29333008] = {
		29333008,
		4,
		nil,
		29333,
		8,
		300,
		{
			RTResTalkAction[84]
		},
		[29] = {
			{
				id = 29333009,
				branch_content = Lang.get(90183)
			},
			{
				id = 29333009,
				branch_content = Lang.get(90184)
			}
		}
	},
	[29333009] = {
		29333009,
		0,
		Lang.get(90185),
		29333,
		9,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29333010] = {
		29333010,
		0,
		Lang.get(90186),
		29333,
		10,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29333011] = {
		29333011,
		0,
		Lang.get(90187),
		29333,
		11,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29333012] = {
		29333012,
		4,
		nil,
		29333,
		12,
		300,
		{
			RTResTalkAction[84]
		},
		[29] = {
			{
				id = 29333013,
				branch_content = Lang.get(22391)
			},
			{
				id = 29333013,
				branch_content = Lang.get(26933)
			}
		}
	},
	[29333013] = {
		29333013,
		0,
		Lang.get(90188),
		29333,
		13,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29333014] = {
		29333014,
		0,
		Lang.get(90170),
		29333,
		14,
		1144,
		{
			RTResTalkAction[87]
		}
	},
	[29334001] = {
		29334001,
		0,
		Lang.get(90189),
		29334,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		29334,
		[19] = 29334
	},
	[29334002] = {
		29334002,
		0,
		Lang.get(90190),
		29334,
		2,
		300
	},
	[29334003] = {
		29334003,
		0,
		Lang.get(90191),
		29334,
		3,
		1144,
		{
			RTResTalkAction[84]
		},
		nil,
		nil,
		3
	},
	[29334004] = {
		29334004,
		0,
		Lang.get(90192),
		29334,
		4,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29334005] = {
		29334005,
		0,
		Lang.get(90193),
		29334,
		5,
		1144,
		{
			RTResTalkAction[87]
		}
	},
	[29334006] = {
		29334006,
		0,
		Lang.get(90194),
		29334,
		6,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334007] = {
		29334007,
		0,
		Lang.get(90195),
		29334,
		7,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29334008] = {
		29334008,
		0,
		Lang.get(90196),
		29334,
		8,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334009] = {
		29334009,
		4,
		nil,
		29334,
		9,
		300,
		{
			RTResTalkAction[84]
		},
		[29] = {
			{
				id = 29334010,
				branch_content = Lang.get(19533)
			},
			{
				id = 29334010,
				branch_content = Lang.get(90197)
			}
		}
	},
	[29334010] = {
		29334010,
		0,
		Lang.get(90198),
		29334,
		10,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334011] = {
		29334011,
		0,
		Lang.get(90199),
		29334,
		11,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334012] = {
		29334012,
		0,
		Lang.get(90200),
		29334,
		12,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29334013] = {
		29334013,
		0,
		Lang.get(90201),
		29334,
		13,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334014] = {
		29334014,
		0,
		Lang.get(90202),
		29334,
		14,
		1144,
		{
			RTResTalkAction[84]
		}
	},
	[29334015] = {
		29334015,
		0,
		Lang.get(90203),
		29334,
		15,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29334016] = {
		29334016,
		0,
		Lang.get(90204),
		29334,
		16,
		1144,
		{
			RTResTalkAction[88]
		}
	},
	[29334017] = {
		29334017,
		0,
		Lang.get(90205),
		29334,
		17,
		300,
		{
			RTResTalkAction[84]
		}
	},
	[29334018] = {
		29334018,
		0,
		Lang.get(90206),
		29334,
		18,
		1144,
		{
			RTResTalkAction[87]
		}
	},
	[29335001] = {
		29335001,
		0,
		Lang.get(90207),
		29335,
		1,
		1146,
		{
			RTResTalkAction[89]
		},
		nil,
		nil,
		3,
		nil,
		58,
		29335,
		nil,
		nil,
		nil,
		nil,
		nil,
		29335
	},
	[29335002] = {
		29335002,
		0,
		Lang.get(90208),
		29335,
		2,
		1146,
		{
			RTResTalkAction[90]
		}
	},
	[29335003] = {
		29335003,
		0,
		Lang.get(90209),
		29335,
		3,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335004] = {
		29335004,
		0,
		Lang.get(90210),
		29335,
		4,
		1146,
		{
			RTResTalkAction[91]
		}
	},
	[29335005] = {
		29335005,
		0,
		Lang.get(90211),
		29335,
		5,
		1146,
		{
			RTResTalkAction[92]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29335006] = {
		29335006,
		0,
		Lang.get(25843),
		29335,
		6,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335007] = {
		29335007,
		0,
		Lang.get(90212),
		29335,
		7,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335008] = {
		29335008,
		0,
		Lang.get(90213),
		29335,
		8,
		1146,
		{
			RTResTalkAction[92]
		}
	},
	[29335009] = {
		29335009,
		0,
		Lang.get(90214),
		29335,
		9,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335010] = {
		29335010,
		0,
		Lang.get(90215),
		29335,
		10,
		1146,
		{
			RTResTalkAction[93]
		}
	},
	[29335011] = {
		29335011,
		0,
		Lang.get(42716),
		29335,
		11,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335012] = {
		29335012,
		0,
		Lang.get(90216),
		29335,
		12,
		1146,
		{
			RTResTalkAction[90]
		}
	},
	[29335013] = {
		29335013,
		0,
		Lang.get(90217),
		29335,
		13,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29335014] = {
		29335014,
		0,
		Lang.get(90218),
		29335,
		14,
		1146,
		{
			RTResTalkAction[90]
		}
	},
	[29335015] = {
		29335015,
		0,
		"……",
		29335,
		15,
		1146,
		{
			RTResTalkAction[90]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29335016] = {
		29335016,
		0,
		Lang.get(90219),
		29335,
		16,
		300,
		{
			RTResTalkAction[90]
		}
	},
	[29336001] = {
		29336001,
		0,
		Lang.get(90220),
		29336,
		1,
		1145,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3,
		nil,
		62,
		29336,
		1,
		nil,
		nil,
		nil,
		nil,
		29336
	},
	[29336002] = {
		29336002,
		0,
		Lang.get(90221),
		29336,
		2,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29336003] = {
		29336003,
		0,
		Lang.get(90222),
		29336,
		3,
		1145,
		{
			RTResTalkAction[95]
		}
	},
	[29336004] = {
		29336004,
		0,
		Lang.get(90223),
		29336,
		4,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29336005] = {
		29336005,
		0,
		Lang.get(90224),
		29336,
		5,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29336006] = {
		29336006,
		0,
		Lang.get(90225),
		29336,
		6,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29336007] = {
		29336007,
		0,
		Lang.get(90226),
		29336,
		7,
		1145,
		{
			RTResTalkAction[96]
		}
	},
	[29336008] = {
		29336008,
		0,
		Lang.get(90227),
		29336,
		8,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29336009] = {
		29336009,
		0,
		Lang.get(90228),
		29336,
		9,
		1145,
		{
			RTResTalkAction[96]
		}
	},
	[29336010] = {
		29336010,
		0,
		Lang.get(90229),
		29336,
		10,
		300,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29336011] = {
		29336011,
		0,
		Lang.get(90230),
		29336,
		11,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29336012] = {
		29336012,
		0,
		Lang.get(90231),
		29336,
		12,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29336013] = {
		29336013,
		0,
		Lang.get(90232),
		29336,
		13,
		1145,
		{
			RTResTalkAction[97]
		}
	},
	[29337001] = {
		29337001,
		0,
		Lang.get(90233),
		29337,
		1,
		1145,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		3,
		nil,
		29,
		29337,
		1,
		nil,
		nil,
		nil,
		nil,
		29337
	},
	[29337002] = {
		29337002,
		0,
		Lang.get(90234),
		29337,
		2,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337003] = {
		29337003,
		0,
		Lang.get(90235),
		29337,
		3,
		1145,
		{
			RTResTalkAction[95]
		}
	},
	[29337004] = {
		29337004,
		0,
		Lang.get(19320),
		29337,
		4,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337005] = {
		29337005,
		0,
		Lang.get(90236),
		29337,
		5,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29337006] = {
		29337006,
		0,
		Lang.get(90237),
		29337,
		6,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337007] = {
		29337007,
		0,
		Lang.get(90238),
		29337,
		7,
		1145,
		{
			RTResTalkAction[94]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[29337008] = {
		29337008,
		0,
		Lang.get(90239),
		29337,
		8,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29337009] = {
		29337009,
		0,
		Lang.get(90240),
		29337,
		9,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337010] = {
		29337010,
		0,
		Lang.get(90241),
		29337,
		10,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29337011] = {
		29337011,
		0,
		Lang.get(90242),
		29337,
		11,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337012] = {
		29337012,
		0,
		Lang.get(90243),
		29337,
		12,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29337013] = {
		29337013,
		0,
		Lang.get(90244),
		29337,
		13,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337014] = {
		29337014,
		0,
		Lang.get(90245),
		29337,
		14,
		300,
		{
			RTResTalkAction[94]
		}
	},
	[29337015] = {
		29337015,
		0,
		Lang.get(90246),
		29337,
		15,
		1145,
		{
			RTResTalkAction[97]
		}
	},
	[29337016] = {
		29337016,
		0,
		Lang.get(90247),
		29337,
		16,
		1145,
		{
			RTResTalkAction[94]
		}
	},
	[29338001] = {
		29338001,
		0,
		Lang.get(90248),
		29338,
		1,
		1147,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		3,
		nil,
		58,
		29338,
		nil,
		nil,
		nil,
		nil,
		nil,
		29338
	},
	[29338002] = {
		29338002,
		0,
		Lang.get(90249),
		29338,
		2,
		300,
		{
			RTResTalkAction[98]
		}
	},
	[29338003] = {
		29338003,
		0,
		Lang.get(90250),
		29338,
		3,
		1147,
		{
			RTResTalkAction[99]
		}
	},
	[29338004] = {
		29338004,
		0,
		Lang.get(90251),
		29338,
		4,
		1147,
		{
			RTResTalkAction[98]
		}
	},
	[29338005] = {
		29338005,
		0,
		Lang.get(90252),
		29338,
		5,
		300,
		{
			RTResTalkAction[98]
		}
	},
	[29338006] = {
		29338006,
		0,
		Lang.get(90253),
		29338,
		6,
		1147,
		{
			RTResTalkAction[98]
		}
	},
	[29338007] = {
		29338007,
		0,
		Lang.get(90254),
		29338,
		7,
		300,
		{
			RTResTalkAction[98]
		}
	},
	[29338008] = {
		29338008,
		0,
		Lang.get(90255),
		29338,
		8,
		1147,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29338009] = {
		29338009,
		0,
		Lang.get(90256),
		29338,
		9,
		1147,
		{
			RTResTalkAction[100]
		}
	},
	[29338010] = {
		29338010,
		0,
		Lang.get(90257),
		29338,
		10,
		300,
		{
			RTResTalkAction[98]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29338011] = {
		29338011,
		0,
		Lang.get(90258),
		29338,
		11,
		1147,
		{
			RTResTalkAction[101]
		}
	},
	[29338012] = {
		29338012,
		0,
		Lang.get(90259),
		29338,
		12,
		300,
		{
			RTResTalkAction[98]
		}
	},
	[29338013] = {
		29338013,
		0,
		Lang.get(90260),
		29338,
		13,
		1147,
		{
			RTResTalkAction[98]
		}
	},
	[29338014] = {
		29338014,
		0,
		Lang.get(90261),
		29338,
		14,
		1147,
		{
			RTResTalkAction[98]
		}
	},
	[29339001] = {
		29339001,
		0,
		Lang.get(107829),
		29339,
		1,
		300,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		29339,
		nil,
		nil,
		nil,
		nil,
		nil,
		29339
	},
	[29339002] = {
		29339002,
		0,
		Lang.get(107830),
		29339,
		2,
		300
	},
	[29339003] = {
		29339003,
		3,
		Lang.get(107831),
		29339,
		3,
		605,
		[22] = 1
	},
	[29339004] = {
		29339004,
		0,
		Lang.get(107832),
		29339,
		4,
		300
	},
	[29339005] = {
		29339005,
		3,
		Lang.get(107833),
		29339,
		5,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		nil,
		29340,
		1,
		1,
		nil,
		1,
		nil,
		29340,
		nil,
		nil,
		1
	},
	[29339006] = {
		29339006,
		0,
		Lang.get(107834),
		29339,
		6,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29339007] = {
		29339007,
		4,
		nil,
		29339,
		7,
		300,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29339008,
				branch_content = Lang.get(21987)
			},
			{
				id = 29339008,
				branch_content = Lang.get(107835)
			}
		}
	},
	[29339008] = {
		29339008,
		0,
		Lang.get(107836),
		29339,
		8,
		1276,
		{
			RTResTalkAction[104]
		}
	},
	[29339009] = {
		29339009,
		0,
		Lang.get(107837),
		29339,
		9,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29339010] = {
		29339010,
		0,
		Lang.get(107838),
		29339,
		10,
		1276,
		{
			RTResTalkAction[105]
		}
	},
	[29339011] = {
		29339011,
		3,
		Lang.get(107839),
		29339,
		11,
		605,
		{
			RTResTalkAction[106]
		},
		[22] = 1,
		[20] = 200
	},
	[29339012] = {
		29339012,
		3,
		Lang.get(107840),
		29339,
		12,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		59,
		[22] = 1
	},
	[29339013] = {
		29339013,
		9,
		Lang.get(107841),
		29339,
		13,
		[22] = 1
	},
	[29339014] = {
		29339014,
		9,
		Lang.get(107842),
		29339,
		14,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[29339015] = {
		29339015,
		0,
		Lang.get(99296),
		29339,
		15,
		1276,
		nil,
		1,
		0
	},
	[29339016] = {
		29339016,
		3,
		Lang.get(107843),
		29339,
		16,
		605,
		[22] = 1
	},
	[29339017] = {
		29339017,
		0,
		Lang.get(107844),
		29339,
		17,
		300
	},
	[29339018] = {
		29339018,
		5,
		Lang.get(107845),
		29339,
		18,
		1276,
		{
			RTResTalkAction[107]
		}
	},
	[29339019] = {
		29339019,
		0,
		Lang.get(107846),
		29339,
		19,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29339020] = {
		29339020,
		0,
		Lang.get(107847),
		29339,
		20,
		1276,
		{
			RTResTalkAction[108]
		}
	},
	[29339021] = {
		29339021,
		3,
		Lang.get(107848),
		29339,
		21,
		605,
		{
			RTResTalkAction[106]
		},
		[22] = 1
	},
	[29340001] = {
		29340001,
		0,
		Lang.get(107849),
		29340,
		1,
		1276,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		3,
		nil,
		209,
		29341,
		nil,
		nil,
		nil,
		nil,
		nil,
		29341
	},
	[29340002] = {
		29340002,
		0,
		Lang.get(107850),
		29340,
		2,
		1276,
		{
			RTResTalkAction[103]
		}
	},
	[29340003] = {
		29340003,
		4,
		nil,
		29340,
		3,
		300,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29340004,
				branch_content = Lang.get(107851)
			},
			{
				id = 29340004,
				branch_content = Lang.get(107852)
			}
		}
	},
	[29340004] = {
		29340004,
		0,
		Lang.get(107853),
		29340,
		4,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340005] = {
		29340005,
		4,
		nil,
		29340,
		5,
		300,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29340006,
				branch_content = Lang.get(107854)
			},
			{
				id = 29340006,
				branch_content = Lang.get(107855)
			}
		}
	},
	[29340006] = {
		29340006,
		0,
		Lang.get(107856),
		29340,
		6,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340007] = {
		29340007,
		0,
		Lang.get(107857),
		29340,
		7,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340008] = {
		29340008,
		0,
		Lang.get(107858),
		29340,
		8,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29340009] = {
		29340009,
		0,
		Lang.get(107859),
		29340,
		9,
		1276,
		{
			RTResTalkAction[109]
		}
	},
	[29340010] = {
		29340010,
		0,
		Lang.get(107860),
		29340,
		10,
		1276,
		{
			RTResTalkAction[103]
		}
	},
	[29340011] = {
		29340011,
		0,
		Lang.get(107861),
		29340,
		11,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29340012] = {
		29340012,
		0,
		Lang.get(107862),
		29340,
		12,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340013] = {
		29340013,
		0,
		Lang.get(107863),
		29340,
		13,
		1276,
		{
			RTResTalkAction[105]
		}
	},
	[29340014] = {
		29340014,
		4,
		nil,
		29340,
		14,
		1276,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29340015,
				branch_content = Lang.get(107864)
			},
			{
				id = 29340015,
				branch_content = Lang.get(107865)
			}
		}
	},
	[29340015] = {
		29340015,
		0,
		Lang.get(107866),
		29340,
		15,
		1276,
		{
			RTResTalkAction[105]
		}
	},
	[29340016] = {
		29340016,
		0,
		Lang.get(107867),
		29340,
		16,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340017] = {
		29340017,
		0,
		Lang.get(107868),
		29340,
		17,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29340018] = {
		29340018,
		0,
		Lang.get(107869),
		29340,
		18,
		1276,
		{
			RTResTalkAction[105]
		}
	},
	[29340019] = {
		29340019,
		0,
		Lang.get(107870),
		29340,
		19,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29340020] = {
		29340020,
		0,
		"……",
		29340,
		20,
		1276,
		{
			RTResTalkAction[102]
		}
	},
	[29340021] = {
		29340021,
		0,
		Lang.get(107871),
		29340,
		21,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29340022] = {
		29340022,
		0,
		Lang.get(107872),
		29340,
		22,
		1276,
		{
			RTResTalkAction[110]
		}
	},
	[29341001] = {
		29341001,
		0,
		Lang.get(107873),
		29341,
		1,
		300,
		nil,
		nil,
		nil,
		3,
		2751,
		208,
		29342,
		nil,
		nil,
		nil,
		nil,
		nil,
		29342
	},
	[29341002] = {
		29341002,
		5,
		Lang.get(107874),
		29341,
		2,
		1276,
		{
			RTResTalkAction[111]
		}
	},
	[29341003] = {
		29341003,
		0,
		Lang.get(107875),
		29341,
		3,
		1276,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29341004] = {
		29341004,
		0,
		Lang.get(107876),
		29341,
		4,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29341005] = {
		29341005,
		5,
		Lang.get(107877),
		29341,
		5,
		1276,
		{
			RTResTalkAction[107]
		}
	},
	[29341006] = {
		29341006,
		0,
		Lang.get(85716),
		29341,
		6,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29341007] = {
		29341007,
		0,
		Lang.get(107878),
		29341,
		7,
		1276,
		{
			RTResTalkAction[112]
		}
	},
	[29341008] = {
		29341008,
		0,
		Lang.get(107879),
		29341,
		8,
		1276,
		{
			RTResTalkAction[103]
		}
	},
	[29341009] = {
		29341009,
		4,
		nil,
		29341,
		9,
		300,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29341010,
				branch_content = Lang.get(107880)
			},
			{
				id = 29341010,
				branch_content = Lang.get(107881)
			}
		}
	},
	[29341010] = {
		29341010,
		0,
		Lang.get(107882),
		29341,
		10,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29341011] = {
		29341011,
		0,
		Lang.get(107883),
		29341,
		11,
		1276,
		{
			RTResTalkAction[108]
		}
	},
	[29341012] = {
		29341012,
		0,
		Lang.get(107884),
		29341,
		12,
		1276,
		{
			RTResTalkAction[103]
		}
	},
	[29341013] = {
		29341013,
		4,
		nil,
		29341,
		13,
		1276,
		{
			RTResTalkAction[103]
		},
		[29] = {
			{
				id = 29341014,
				branch_content = Lang.get(107885)
			},
			{
				id = 29341014,
				branch_content = Lang.get(107886)
			}
		}
	},
	[29341014] = {
		29341014,
		0,
		Lang.get(107887),
		29341,
		14,
		1276,
		{
			RTResTalkAction[102]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[29341015] = {
		29341015,
		0,
		Lang.get(107888),
		29341,
		15,
		300,
		{
			RTResTalkAction[103]
		}
	},
	[29341016] = {
		29341016,
		3,
		Lang.get(107889),
		29341,
		16,
		605,
		{
			RTResTalkAction[113]
		},
		[21] = 1276,
		[22] = 1
	},
	[29341017] = {
		29341017,
		0,
		Lang.get(107890),
		29341,
		17,
		1276,
		{
			RTResTalkAction[110]
		}
	},
	[29341018] = {
		29341018,
		0,
		Lang.get(107891),
		29341,
		18,
		1276,
		{
			RTResTalkAction[103]
		}
	},
	[29341019] = {
		29341019,
		0,
		Lang.get(107892),
		29341,
		19,
		300,
		{
			RTResTalkAction[103]
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
