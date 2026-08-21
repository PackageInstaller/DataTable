-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuxian38\\ResTalk.lua

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
	[2] = 160
}
RTResTalkAction[2] = {
	[1] = 2,
	[2] = 160
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 287
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 160
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 151
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 287
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 151
}
RTResTalkAction[10] = {
	[1] = 3,
	[2] = 160
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 215
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 151
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 215
}
RTResTalkAction[14] = {
	[1] = 3,
	[2] = 215,
	[3] = {
		1
	}
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		1
	}
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 215
}
RTResTalkAction[19] = {
	3,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 220
}
RTResTalkAction[21] = {
	3,
	215,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 220
}
RTResTalkAction[23] = {
	[1] = 2,
	[2] = 220,
	[3] = {
		2
	}
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[25] = {
	1,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[26] = {
	2,
	220,
	nil,
	nil,
	2
}
RTResTalkAction[27] = {
	[1] = 1,
	[2] = 287
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1041
}
RTResTalkAction[29] = {
	[1] = 2,
	[2] = 1041
}
RTResTalkAction[30] = {
	[1] = 3,
	[2] = 1042
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 1041
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 1042
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 46
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 46
}
RTResTalkAction[35] = {
	[1] = 1,
	[2] = 1040
}
RTResTalkAction[36] = {
	[1] = 2,
	[2] = 1043
}
RTResTalkAction[37] = {
	[1] = 3,
	[2] = 1040
}
RTResTalkAction[38] = {
	[1] = 3,
	[2] = 1040,
	[3] = {
		3
	}
}
RTResTalkAction[39] = {
	[1] = 1,
	[2] = 46,
	[3] = {
		3
	}
}
RTResTalkAction[40] = {
	[1] = 0,
	[2] = 1043
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 1040
}
RTResTalkAction[42] = {
	[1] = 1,
	[2] = 1043
}
RTResTalkAction[43] = {
	[1] = 1,
	[2] = 20,
	[3] = {
		3
	}
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 27,
	[3] = {
		3
	}
}
RTResTalkAction[45] = {
	[1] = 0,
	[2] = 20
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 244
}
RTResTalkAction[47] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 20
}
RTResTalkAction[49] = {
	1,
	215,
	nil,
	nil,
	3
}
RTResTalkAction[50] = {
	[1] = 1,
	[2] = 1046
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 1046
}
RTResTalkAction[52] = {
	[1] = 2,
	[2] = 215
}
RTResTalkAction[53] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		2
	}
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 225
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 767,
	[3] = {
		3
	}
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 767
}
RTResTalkAction[57] = {
	[1] = 3,
	[2] = 188
}
RTResTalkAction[58] = {
	[1] = 3,
	[2] = 1039
}
RTResTalkAction[59] = {
	[1] = 0,
	[2] = 188
}
RTResTalkAction[60] = {
	[1] = 1,
	[2] = 767
}
RTResTalkAction[61] = {
	[1] = 0,
	[2] = 1039
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 188
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 767
}
RTResTalkAction[64] = {
	[1] = 1,
	[2] = 769
}
RTResTalkAction[65] = {
	[1] = 2,
	[2] = 769
}
RTResTalkAction[66] = {
	[1] = 3,
	[2] = 287
}
RTResTalkAction[67] = {
	[1] = 0,
	[2] = 769
}
RTResTalkAction[68] = {
	[1] = 1,
	[2] = 769,
	[3] = {
		1
	}
}
RTResTalkAction[69] = {
	[1] = 2,
	[2] = 225
}
RTResTalkAction[70] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[71] = {
	[1] = 2,
	[2] = 112
}
RTResTalkAction[72] = {
	[1] = 3,
	[2] = 1044
}
RTResTalkAction[73] = {
	[1] = 0,
	[2] = 1044
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 677
}
RTResTalkAction[75] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[76] = {
	[1] = 3,
	[2] = 677
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 677
}

local Data = {
	[32201001] = {
		32201001,
		0,
		Lang.get(70381),
		32201,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32201,
		nil,
		nil,
		nil,
		nil,
		nil,
		32201
	},
	[32201002] = {
		32201002,
		0,
		Lang.get(80408),
		32201,
		2,
		160,
		nil,
		1
	},
	[32201003] = {
		32201003,
		0,
		Lang.get(80409),
		32201,
		3,
		160,
		nil,
		1
	},
	[32201004] = {
		32201004,
		0,
		Lang.get(80410),
		32201,
		4,
		220,
		nil,
		1,
		2
	},
	[32201005] = {
		32201005,
		0,
		Lang.get(80411),
		32201,
		5,
		160,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[32201006] = {
		32201006,
		0,
		Lang.get(80412),
		32201,
		6,
		225,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[32201007] = {
		32201007,
		0,
		Lang.get(80413),
		32201,
		7,
		287,
		{
			RTResTalkAction[4],
			RTResTalkAction[3],
			RTResTalkAction[5]
		}
	},
	[32201008] = {
		32201008,
		0,
		Lang.get(80414),
		32201,
		8,
		151,
		{
			RTResTalkAction[6],
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[32201009] = {
		32201009,
		0,
		Lang.get(80415),
		32201,
		9,
		160,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[32201010] = {
		32201010,
		0,
		Lang.get(80416),
		32201,
		10,
		215,
		{
			RTResTalkAction[11],
			RTResTalkAction[12],
			RTResTalkAction[5]
		}
	},
	[32201011] = {
		32201011,
		0,
		Lang.get(80417),
		32201,
		11,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[32201012] = {
		32201012,
		0,
		Lang.get(80418),
		32201,
		12,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[32201013] = {
		32201013,
		0,
		Lang.get(80419),
		32201,
		13,
		160,
		{
			RTResTalkAction[1],
			RTResTalkAction[13]
		}
	},
	[32201014] = {
		32201014,
		4,
		nil,
		32201,
		14,
		160,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 32201015,
				branch_content = Lang.get(80420)
			},
			{
				id = 32201015,
				branch_content = Lang.get(80421)
			}
		}
	},
	[32201015] = {
		32201015,
		0,
		Lang.get(80422),
		32201,
		15,
		160,
		{
			RTResTalkAction[1]
		}
	},
	[32201016] = {
		32201016,
		0,
		Lang.get(80423),
		32201,
		16,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[32201017] = {
		32201017,
		0,
		Lang.get(80424),
		32201,
		17,
		160,
		{
			RTResTalkAction[1]
		}
	},
	[32201018] = {
		32201018,
		0,
		Lang.get(80425),
		32201,
		18,
		160,
		{
			RTResTalkAction[1]
		}
	},
	[32201019] = {
		32201019,
		0,
		Lang.get(80426),
		32201,
		19,
		160,
		{
			RTResTalkAction[1]
		}
	},
	[32202001] = {
		32202001,
		0,
		Lang.get(80427),
		32202,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		32202,
		nil,
		nil,
		nil,
		nil,
		nil,
		32202
	},
	[32202002] = {
		32202002,
		0,
		Lang.get(80428),
		32202,
		2,
		160,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[32202003] = {
		32202003,
		0,
		Lang.get(80429),
		32202,
		3,
		215,
		{
			RTResTalkAction[2],
			RTResTalkAction[14]
		}
	},
	[32202004] = {
		32202004,
		0,
		Lang.get(80430),
		32202,
		4,
		225,
		{
			RTResTalkAction[15],
			RTResTalkAction[5],
			RTResTalkAction[13]
		}
	},
	[32202005] = {
		32202005,
		0,
		Lang.get(80431),
		32202,
		5,
		257,
		{
			RTResTalkAction[8]
		},
		1,
		0,
		nil,
		nil,
		nil,
		32220,
		1,
		1,
		nil,
		1,
		nil,
		32220
	},
	[32202006] = {
		32202006,
		0,
		Lang.get(80432),
		32202,
		6,
		220,
		nil,
		1,
		2
	},
	[32202007] = {
		32202007,
		0,
		Lang.get(80433),
		32202,
		7,
		215,
		nil,
		1,
		0
	},
	[32202008] = {
		32202008,
		0,
		Lang.get(80434),
		32202,
		8,
		257,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[32202009] = {
		32202009,
		0,
		Lang.get(80435),
		32202,
		9,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[32202010] = {
		32202010,
		0,
		Lang.get(80436),
		32202,
		10,
		257,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[32202011] = {
		32202011,
		0,
		Lang.get(80437),
		32202,
		11,
		220,
		{
			RTResTalkAction[17],
			RTResTalkAction[19],
			RTResTalkAction[13]
		}
	},
	[32202012] = {
		32202012,
		0,
		Lang.get(80438),
		32202,
		12,
		257,
		{
			RTResTalkAction[17],
			RTResTalkAction[20]
		}
	},
	[32202013] = {
		32202013,
		0,
		Lang.get(80439),
		32202,
		13,
		215,
		{
			RTResTalkAction[17],
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[32202014] = {
		32202014,
		0,
		Lang.get(80440),
		32202,
		14,
		220,
		{
			RTResTalkAction[23],
			RTResTalkAction[21],
			RTResTalkAction[24]
		}
	},
	[32203001] = {
		32203001,
		0,
		Lang.get(80441),
		32203,
		1,
		220,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		32203,
		nil,
		nil,
		nil,
		nil,
		nil,
		32203
	},
	[32203002] = {
		32203002,
		0,
		Lang.get(80442),
		32203,
		2,
		257,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[32203003] = {
		32203003,
		0,
		Lang.get(80443),
		32203,
		3,
		257,
		{
			RTResTalkAction[16]
		}
	},
	[32203004] = {
		32203004,
		0,
		Lang.get(80444),
		32203,
		4,
		257,
		{
			RTResTalkAction[16]
		}
	},
	[32203005] = {
		32203005,
		0,
		Lang.get(80445),
		32203,
		5,
		220,
		{
			RTResTalkAction[24]
		},
		1,
		2,
		nil,
		nil,
		nil,
		32221,
		1,
		1,
		nil,
		1,
		nil,
		32221
	},
	[32203006] = {
		32203006,
		0,
		Lang.get(80446),
		32203,
		6,
		215,
		nil,
		1,
		2
	},
	[32203007] = {
		32203007,
		0,
		Lang.get(80447),
		32203,
		7,
		220,
		{
			RTResTalkAction[25]
		},
		nil,
		nil,
		3
	},
	[32203008] = {
		32203008,
		0,
		Lang.get(80448),
		32203,
		8,
		215,
		{
			RTResTalkAction[26],
			RTResTalkAction[18]
		}
	},
	[32203009] = {
		32203009,
		0,
		Lang.get(80449),
		32203,
		9,
		220,
		{
			RTResTalkAction[26],
			RTResTalkAction[18]
		}
	},
	[32203010] = {
		32203010,
		0,
		Lang.get(80450),
		32203,
		10,
		215,
		{
			RTResTalkAction[26],
			RTResTalkAction[18]
		}
	},
	[32203011] = {
		32203011,
		0,
		Lang.get(80451),
		32203,
		11,
		220,
		{
			RTResTalkAction[26],
			RTResTalkAction[18]
		}
	},
	[32203012] = {
		32203012,
		0,
		Lang.get(80452),
		32203,
		12,
		215,
		{
			RTResTalkAction[26],
			RTResTalkAction[18]
		}
	},
	[32204001] = {
		32204001,
		0,
		Lang.get(80453),
		32204,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32204,
		[19] = 32204
	},
	[32204002] = {
		32204002,
		0,
		Lang.get(80454),
		32204,
		2,
		225,
		nil,
		1
	},
	[32204003] = {
		32204003,
		0,
		Lang.get(80455),
		32204,
		3,
		225,
		nil,
		1
	},
	[32204004] = {
		32204004,
		0,
		Lang.get(80456),
		32204,
		4,
		287,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[32204005] = {
		32204005,
		0,
		Lang.get(80457),
		32204,
		5,
		287,
		{
			RTResTalkAction[27]
		}
	},
	[32204006] = {
		32204006,
		0,
		Lang.get(80458),
		32204,
		6,
		225,
		{
			RTResTalkAction[7]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32222,
		1,
		1,
		nil,
		0,
		nil,
		32222
	},
	[32204007] = {
		32204007,
		0,
		Lang.get(80459),
		32204,
		7,
		287,
		nil,
		1
	},
	[32204008] = {
		32204008,
		0,
		Lang.get(80460),
		32204,
		8,
		225,
		nil,
		1
	},
	[32204009] = {
		32204009,
		0,
		Lang.get(80461),
		32204,
		9,
		287,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[32204010] = {
		32204010,
		0,
		Lang.get(80462),
		32204,
		10,
		287,
		{
			RTResTalkAction[27]
		}
	},
	[32205001] = {
		32205001,
		0,
		Lang.get(80463),
		32205,
		1,
		1041,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32205,
		nil,
		nil,
		nil,
		nil,
		nil,
		32205
	},
	[32205002] = {
		32205002,
		0,
		Lang.get(80464),
		32205,
		2,
		1042,
		nil,
		1
	},
	[32205003] = {
		32205003,
		0,
		Lang.get(80465),
		32205,
		3,
		1041,
		{
			RTResTalkAction[28]
		},
		nil,
		nil,
		3
	},
	[32205004] = {
		32205004,
		0,
		Lang.get(80466),
		32205,
		4,
		1042,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[32205005] = {
		32205005,
		0,
		Lang.get(80467),
		32205,
		5,
		1041,
		{
			RTResTalkAction[29],
			RTResTalkAction[30]
		}
	},
	[32205006] = {
		32205006,
		0,
		Lang.get(80468),
		32205,
		6,
		1040,
		{
			RTResTalkAction[31],
			RTResTalkAction[32]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32223,
		1,
		1,
		nil,
		0,
		nil,
		32223
	},
	[32205007] = {
		32205007,
		0,
		Lang.get(80469),
		32205,
		7,
		1042,
		nil,
		1
	},
	[32205008] = {
		32205008,
		0,
		Lang.get(80470),
		32205,
		8,
		46,
		{
			RTResTalkAction[33]
		},
		nil,
		nil,
		3
	},
	[32205009] = {
		32205009,
		0,
		Lang.get(80471),
		32205,
		9,
		1042,
		{
			RTResTalkAction[34]
		},
		1
	},
	[32205010] = {
		32205010,
		0,
		Lang.get(80472),
		32205,
		10,
		1043,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32224,
		1,
		1,
		nil,
		1,
		nil,
		32224
	},
	[32205011] = {
		32205011,
		0,
		Lang.get(80473),
		32205,
		11,
		1043,
		nil,
		1
	},
	[32205012] = {
		32205012,
		0,
		Lang.get(80474),
		32205,
		12,
		1040,
		{
			RTResTalkAction[35]
		},
		nil,
		nil,
		3
	},
	[32205013] = {
		32205013,
		0,
		Lang.get(80475),
		32205,
		13,
		1043,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[32205014] = {
		32205014,
		0,
		Lang.get(80476),
		32205,
		14,
		1040,
		{
			RTResTalkAction[36],
			RTResTalkAction[38]
		}
	},
	[32205015] = {
		32205015,
		0,
		Lang.get(80477),
		32205,
		15,
		1043,
		{
			RTResTalkAction[36],
			RTResTalkAction[37]
		}
	},
	[32205016] = {
		32205016,
		0,
		Lang.get(80478),
		32205,
		16,
		46,
		{
			RTResTalkAction[39],
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[32205017] = {
		32205017,
		0,
		Lang.get(80479),
		32205,
		17,
		1043,
		{
			RTResTalkAction[42],
			RTResTalkAction[34]
		}
	},
	[32205018] = {
		32205018,
		0,
		Lang.get(80480),
		32205,
		18,
		1043,
		{
			RTResTalkAction[40]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32228,
		1,
		1,
		nil,
		1,
		nil,
		32228
	},
	[32205019] = {
		32205019,
		0,
		Lang.get(80481),
		32205,
		19,
		1043,
		nil,
		1
	},
	[32205020] = {
		32205020,
		0,
		Lang.get(80482),
		32205,
		20,
		20,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[32205021] = {
		32205021,
		0,
		Lang.get(80483),
		32205,
		21,
		27,
		{
			RTResTalkAction[44],
			RTResTalkAction[45]
		}
	},
	[32206001] = {
		32206001,
		0,
		Lang.get(80484),
		32206,
		1,
		215,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		32206,
		nil,
		nil,
		nil,
		nil,
		nil,
		32206
	},
	[32206002] = {
		32206002,
		0,
		Lang.get(80485),
		32206,
		2,
		287,
		nil,
		1
	},
	[32206003] = {
		32206003,
		0,
		Lang.get(80486),
		32206,
		3,
		215,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[32206004] = {
		32206004,
		0,
		Lang.get(80487),
		32206,
		4,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[13]
		}
	},
	[32206005] = {
		32206005,
		0,
		Lang.get(80488),
		32206,
		5,
		244,
		{
			RTResTalkAction[46],
			RTResTalkAction[22]
		}
	},
	[32206006] = {
		32206006,
		0,
		Lang.get(80489),
		32206,
		6,
		220,
		{
			RTResTalkAction[47]
		},
		1,
		2,
		nil,
		nil,
		57,
		32225,
		1,
		1,
		nil,
		1,
		nil,
		32225
	},
	[32206007] = {
		32206007,
		0,
		Lang.get(80490),
		32206,
		7,
		225,
		nil,
		1,
		0
	},
	[32206008] = {
		32206008,
		0,
		Lang.get(80491),
		32206,
		8,
		244,
		nil,
		1
	},
	[32206009] = {
		32206009,
		0,
		Lang.get(80492),
		32206,
		9,
		20,
		{
			RTResTalkAction[43]
		},
		nil,
		nil,
		3
	},
	[32206010] = {
		32206010,
		3,
		Lang.get(80493),
		32206,
		10,
		605,
		{
			RTResTalkAction[48]
		},
		[22] = 1
	},
	[32206011] = {
		32206011,
		0,
		Lang.get(80494),
		32206,
		11,
		220,
		{
			RTResTalkAction[25],
			RTResTalkAction[45]
		}
	},
	[32206012] = {
		32206012,
		0,
		Lang.get(80495),
		32206,
		12,
		215,
		{
			RTResTalkAction[49],
			RTResTalkAction[22]
		}
	},
	[32206013] = {
		32206013,
		0,
		Lang.get(80496),
		32206,
		13,
		244,
		{
			RTResTalkAction[46],
			RTResTalkAction[13]
		}
	},
	[32206014] = {
		32206014,
		0,
		Lang.get(80497),
		32206,
		14,
		1046,
		{
			RTResTalkAction[47]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32226,
		1,
		1,
		nil,
		1,
		nil,
		32226
	},
	[32206015] = {
		32206015,
		0,
		Lang.get(80498),
		32206,
		15,
		287,
		nil,
		1
	},
	[32206016] = {
		32206016,
		0,
		Lang.get(80499),
		32206,
		16,
		1046,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[32206017] = {
		32206017,
		0,
		Lang.get(80500),
		32206,
		17,
		1046,
		{
			RTResTalkAction[50]
		}
	},
	[32206018] = {
		32206018,
		0,
		Lang.get(80501),
		32206,
		18,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[51]
		}
	},
	[32206019] = {
		32206019,
		0,
		Lang.get(80502),
		32206,
		19,
		215,
		{
			RTResTalkAction[49],
			RTResTalkAction[7]
		}
	},
	[32206020] = {
		32206020,
		0,
		Lang.get(80503),
		32206,
		20,
		220,
		{
			RTResTalkAction[52],
			RTResTalkAction[19]
		}
	},
	[32206021] = {
		32206021,
		0,
		Lang.get(80504),
		32206,
		21,
		1046,
		{
			RTResTalkAction[50],
			RTResTalkAction[13],
			RTResTalkAction[22]
		}
	},
	[32206022] = {
		32206022,
		0,
		Lang.get(80505),
		32206,
		22,
		1046,
		{
			RTResTalkAction[50]
		}
	},
	[32207001] = {
		32207001,
		0,
		Lang.get(80506),
		32207,
		1,
		287,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32207,
		nil,
		nil,
		nil,
		nil,
		nil,
		32207
	},
	[32207002] = {
		32207002,
		0,
		Lang.get(80507),
		32207,
		2,
		225,
		nil,
		1
	},
	[32207003] = {
		32207003,
		0,
		Lang.get(80508),
		32207,
		3,
		225,
		{
			RTResTalkAction[53]
		},
		nil,
		nil,
		3
	},
	[32207004] = {
		32207004,
		0,
		Lang.get(80509),
		32207,
		4,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[8]
		}
	},
	[32207005] = {
		32207005,
		0,
		Lang.get(80510),
		32207,
		5,
		225,
		{
			RTResTalkAction[53],
			RTResTalkAction[7]
		}
	},
	[32207006] = {
		32207006,
		0,
		Lang.get(80511),
		32207,
		6,
		225,
		{
			RTResTalkAction[8]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		32227,
		1,
		1,
		nil,
		1,
		nil,
		32227
	},
	[32207007] = {
		32207007,
		0,
		Lang.get(80512),
		32207,
		7,
		287,
		nil,
		1
	},
	[32207008] = {
		32207008,
		0,
		Lang.get(80513),
		32207,
		8,
		287,
		nil,
		1
	},
	[32207009] = {
		32207009,
		0,
		Lang.get(80514),
		32207,
		9,
		225,
		{
			RTResTalkAction[54]
		},
		nil,
		nil,
		3
	},
	[32207010] = {
		32207010,
		0,
		Lang.get(80515),
		32207,
		10,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[8]
		}
	},
	[32207011] = {
		32207011,
		0,
		Lang.get(80516),
		32207,
		11,
		225,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[32208001] = {
		32208001,
		0,
		Lang.get(80517),
		32208,
		1,
		188,
		nil,
		1,
		nil,
		nil,
		nil,
		61,
		32208,
		nil,
		nil,
		nil,
		nil,
		nil,
		32208
	},
	[32208002] = {
		32208002,
		0,
		Lang.get(80518),
		32208,
		2,
		1039,
		nil,
		1
	},
	[32208003] = {
		32208003,
		0,
		Lang.get(80519),
		32208,
		3,
		188,
		nil,
		1
	},
	[32208004] = {
		32208004,
		0,
		Lang.get(80520),
		32208,
		4,
		1039,
		nil,
		1
	},
	[32208005] = {
		32208005,
		0,
		Lang.get(80521),
		32208,
		5,
		767,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		3
	},
	[32208006] = {
		32208006,
		0,
		Lang.get(80522),
		32208,
		6,
		188,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[32208007] = {
		32208007,
		0,
		Lang.get(80523),
		32208,
		7,
		767,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[32208008] = {
		32208008,
		0,
		Lang.get(80524),
		32208,
		8,
		1039,
		{
			RTResTalkAction[56],
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[32208009] = {
		32208009,
		0,
		Lang.get(80525),
		32208,
		9,
		767,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[32208010] = {
		32208010,
		0,
		Lang.get(80526),
		32208,
		10,
		767,
		{
			RTResTalkAction[60]
		}
	},
	[32208011] = {
		32208011,
		0,
		Lang.get(80527),
		32208,
		11,
		188,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[32208012] = {
		32208012,
		0,
		Lang.get(80528),
		32208,
		12,
		767,
		{
			RTResTalkAction[56],
			RTResTalkAction[57]
		}
	},
	[32208013] = {
		32208013,
		0,
		Lang.get(80529),
		32208,
		13,
		1039,
		{
			RTResTalkAction[56],
			RTResTalkAction[58],
			RTResTalkAction[59]
		}
	},
	[32208014] = {
		32208014,
		0,
		Lang.get(80530),
		32208,
		14,
		767,
		{
			RTResTalkAction[60],
			RTResTalkAction[61]
		}
	},
	[32209001] = {
		32209001,
		0,
		Lang.get(80531),
		32209,
		1,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32209,
		nil,
		nil,
		nil,
		nil,
		nil,
		32209
	},
	[32209002] = {
		32209002,
		0,
		Lang.get(80532),
		32209,
		2,
		287,
		nil,
		1
	},
	[32209003] = {
		32209003,
		0,
		Lang.get(80533),
		32209,
		3,
		769,
		nil,
		1
	},
	[32209004] = {
		32209004,
		0,
		Lang.get(80534),
		32209,
		4,
		769,
		nil,
		1
	},
	[32209005] = {
		32209005,
		0,
		Lang.get(80535),
		32209,
		5,
		287,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[32209006] = {
		32209006,
		0,
		Lang.get(80536),
		32209,
		6,
		769,
		{
			RTResTalkAction[64],
			RTResTalkAction[7]
		}
	},
	[32209007] = {
		32209007,
		0,
		Lang.get(80537),
		32209,
		7,
		225,
		{
			RTResTalkAction[65],
			RTResTalkAction[3]
		}
	},
	[32209008] = {
		32209008,
		0,
		Lang.get(80538),
		32209,
		8,
		287,
		{
			RTResTalkAction[65],
			RTResTalkAction[66],
			RTResTalkAction[8]
		}
	},
	[32209009] = {
		32209009,
		0,
		Lang.get(80539),
		32209,
		9,
		769,
		{
			RTResTalkAction[65],
			RTResTalkAction[66]
		}
	},
	[32209010] = {
		32209010,
		0,
		Lang.get(80540),
		32209,
		10,
		769,
		{
			RTResTalkAction[64],
			RTResTalkAction[7]
		}
	},
	[32209011] = {
		32209011,
		0,
		Lang.get(80541),
		32209,
		11,
		225,
		{
			RTResTalkAction[65],
			RTResTalkAction[3]
		}
	},
	[32209012] = {
		32209012,
		0,
		Lang.get(80542),
		32209,
		12,
		769,
		{
			RTResTalkAction[65],
			RTResTalkAction[3]
		}
	},
	[32209013] = {
		32209013,
		0,
		Lang.get(80543),
		32209,
		13,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[67],
			RTResTalkAction[8]
		}
	},
	[32209014] = {
		32209014,
		0,
		Lang.get(80544),
		32209,
		14,
		769,
		{
			RTResTalkAction[64],
			RTResTalkAction[7]
		}
	},
	[32209015] = {
		32209015,
		0,
		Lang.get(80545),
		32209,
		15,
		769,
		{
			RTResTalkAction[64]
		}
	},
	[32209016] = {
		32209016,
		0,
		Lang.get(80546),
		32209,
		16,
		769,
		{
			RTResTalkAction[64]
		}
	},
	[32209017] = {
		32209017,
		0,
		Lang.get(80547),
		32209,
		17,
		225,
		{
			RTResTalkAction[65],
			RTResTalkAction[3]
		}
	},
	[32209018] = {
		32209018,
		0,
		Lang.get(80548),
		32209,
		18,
		769,
		{
			RTResTalkAction[68],
			RTResTalkAction[8]
		}
	},
	[32209019] = {
		32209019,
		0,
		Lang.get(80549),
		32209,
		19,
		225,
		{
			RTResTalkAction[15],
			RTResTalkAction[67]
		}
	},
	[32209020] = {
		32209020,
		0,
		Lang.get(80550),
		32209,
		20,
		287,
		{
			RTResTalkAction[69],
			RTResTalkAction[66]
		}
	},
	[32210001] = {
		32210001,
		0,
		Lang.get(80551),
		32210,
		1,
		677,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		32210,
		nil,
		nil,
		nil,
		nil,
		nil,
		32210
	},
	[32210002] = {
		32210002,
		0,
		Lang.get(80552),
		32210,
		2,
		1044,
		nil,
		1
	},
	[32210003] = {
		32210003,
		0,
		Lang.get(80553),
		32210,
		3,
		112,
		nil,
		1
	},
	[32210004] = {
		32210004,
		0,
		Lang.get(80554),
		32210,
		4,
		1044,
		nil,
		1
	},
	[32210005] = {
		32210005,
		0,
		Lang.get(80555),
		32210,
		5,
		112,
		{
			RTResTalkAction[70]
		},
		nil,
		nil,
		3
	},
	[32210006] = {
		32210006,
		0,
		Lang.get(80556),
		32210,
		6,
		1044,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[32210007] = {
		32210007,
		0,
		Lang.get(80557),
		32210,
		7,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[32210008] = {
		32210008,
		0,
		Lang.get(80558),
		32210,
		8,
		1044,
		{
			RTResTalkAction[71],
			RTResTalkAction[72]
		}
	},
	[32210009] = {
		32210009,
		0,
		Lang.get(80559),
		32210,
		9,
		112,
		{
			RTResTalkAction[70],
			RTResTalkAction[73]
		}
	},
	[32210010] = {
		32210010,
		3,
		Lang.get(80560),
		32210,
		10,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[32210011] = {
		32210011,
		3,
		Lang.get(80561),
		32210,
		11,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[32210012] = {
		32210012,
		3,
		Lang.get(80562),
		32210,
		12,
		605,
		{
			RTResTalkAction[70]
		},
		[22] = 1
	},
	[32210013] = {
		32210013,
		0,
		Lang.get(22568),
		32210,
		13,
		677,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[32210014] = {
		32210014,
		0,
		Lang.get(80563),
		32210,
		14,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[76]
		}
	},
	[32210015] = {
		32210015,
		0,
		Lang.get(80564),
		32210,
		15,
		677,
		{
			RTResTalkAction[71],
			RTResTalkAction[76]
		}
	},
	[32210016] = {
		32210016,
		0,
		Lang.get(80565),
		32210,
		16,
		112,
		{
			RTResTalkAction[71],
			RTResTalkAction[76]
		}
	},
	[32210017] = {
		32210017,
		0,
		Lang.get(80566),
		32210,
		17,
		677,
		{
			RTResTalkAction[71],
			RTResTalkAction[76]
		}
	},
	[32210018] = {
		32210018,
		0,
		Lang.get(80567),
		32210,
		18,
		112,
		{
			RTResTalkAction[70],
			RTResTalkAction[77]
		}
	},
	[32211001] = {
		32211001,
		0,
		Lang.get(80568),
		32211,
		1,
		158,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		32211,
		nil,
		nil,
		nil,
		nil,
		nil,
		32211
	},
	[32211002] = {
		32211002,
		0,
		Lang.get(80569),
		32211,
		2,
		158,
		nil,
		1
	},
	[32211003] = {
		32211003,
		0,
		Lang.get(80570),
		32211,
		3,
		160,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[32211004] = {
		32211004,
		4,
		nil,
		32211,
		4,
		160,
		{
			RTResTalkAction[5]
		},
		[29] = {
			{
				id = 32211005,
				branch_content = Lang.get(80571)
			},
			{
				id = 32211005,
				branch_content = Lang.get(80572)
			}
		}
	},
	[32211005] = {
		32211005,
		0,
		Lang.get(80573),
		32211,
		5,
		225,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		32229,
		1,
		1,
		nil,
		1,
		nil,
		32229
	},
	[32211006] = {
		32211006,
		0,
		Lang.get(80574),
		32211,
		6,
		160,
		nil,
		1
	},
	[32211007] = {
		32211007,
		0,
		Lang.get(80575),
		32211,
		7,
		287,
		nil,
		1
	},
	[32211008] = {
		32211008,
		0,
		Lang.get(80576),
		32211,
		8,
		151,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[32211009] = {
		32211009,
		0,
		Lang.get(80577),
		32211,
		9,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[32211010] = {
		32211010,
		0,
		Lang.get(80578),
		32211,
		10,
		151,
		{
			RTResTalkAction[6]
		}
	},
	[32211011] = {
		32211011,
		0,
		Lang.get(80579),
		32211,
		11,
		1045,
		{
			RTResTalkAction[12]
		}
	},
	[32211012] = {
		32211012,
		0,
		Lang.get(80580),
		32211,
		12,
		300
	},
	[32211013] = {
		32211013,
		0,
		Lang.get(80581),
		32211,
		13,
		151,
		{
			RTResTalkAction[6]
		}
	},
	[32211014] = {
		32211014,
		0,
		Lang.get(80582),
		32211,
		14,
		225,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[32211015] = {
		32211015,
		0,
		Lang.get(16653),
		32211,
		15,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[12],
			RTResTalkAction[8]
		}
	},
	[32211016] = {
		32211016,
		0,
		Lang.get(80583),
		32211,
		16,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[32211017] = {
		32211017,
		0,
		Lang.get(80584),
		32211,
		17,
		225,
		{
			RTResTalkAction[54],
			RTResTalkAction[7]
		}
	},
	[32211018] = {
		32211018,
		0,
		Lang.get(80585),
		32211,
		18,
		225,
		{
			RTResTalkAction[54]
		}
	},
	[32211019] = {
		32211019,
		0,
		Lang.get(80586),
		32211,
		19,
		287,
		{
			RTResTalkAction[27],
			RTResTalkAction[8]
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
