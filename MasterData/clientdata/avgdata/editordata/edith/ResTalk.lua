-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Edith\\ResTalk.lua

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
	[2] = 257
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 259
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 259
}
RTResTalkAction[5] = {
	3,
	112,
	nil,
	nil,
	0
}
RTResTalkAction[6] = {
	3,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 112
}
RTResTalkAction[8] = {
	3,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 259
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 259,
	[3] = {
		2
	}
}
RTResTalkAction[12] = {
	3,
	112,
	nil,
	nil,
	4
}
RTResTalkAction[13] = {
	3,
	112,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[14] = {
	1,
	112,
	nil,
	nil,
	1
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 260
}
RTResTalkAction[17] = {
	[1] = 2,
	[2] = 260
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 262
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 260
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 262
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 262
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 261
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 261
}
RTResTalkAction[24] = {
	[1] = 2,
	[2] = 261
}
RTResTalkAction[25] = {
	[1] = 3,
	[2] = 262,
	[3] = {
		3
	}
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 260,
	[3] = {
		1
	}
}
RTResTalkAction[27] = {
	[1] = 3,
	[2] = 257
}
RTResTalkAction[28] = {
	[1] = 3
}
RTResTalkAction[29] = {
	[1] = 0
}
RTResTalkAction[30] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[31] = {
	[1] = 3,
	[2] = 261
}
RTResTalkAction[32] = {
	3,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[33] = {
	3,
	112,
	{
		3
	},
	nil,
	4
}
RTResTalkAction[34] = {
	[1] = 3,
	[2] = 259
}
RTResTalkAction[35] = {
	[1] = 3,
	[2] = 259,
	[3] = {
		2
	}
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 337
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 337
}
RTResTalkAction[38] = {
	1,
	112,
	nil,
	nil,
	2
}
RTResTalkAction[39] = {
	1,
	107,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[40] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[41] = {
	3,
	134,
	nil,
	nil,
	3
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 134
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 134
}
RTResTalkAction[45] = {
	1,
	112,
	nil,
	nil,
	3
}
RTResTalkAction[46] = {
	[1] = 1,
	[2] = 258
}
RTResTalkAction[47] = {
	[1] = 2,
	[2] = 258
}
RTResTalkAction[48] = {
	[1] = 0,
	[2] = 258
}
RTResTalkAction[49] = {
	[1] = 3,
	[2] = 337
}
RTResTalkAction[50] = {
	[1] = 3,
	[2] = 66
}
RTResTalkAction[51] = {
	[1] = 3,
	[2] = 50
}
RTResTalkAction[52] = {
	[1] = 0,
	[2] = 66
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 50
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[55] = {
	3,
	134,
	nil,
	nil,
	5
}

local Data = {
	[23401001] = {
		23401001,
		0,
		Lang.get(59310),
		23401,
		1,
		391,
		nil,
		1,
		nil,
		nil,
		nil,
		4,
		[19] = 23401,
		[17] = 1
	},
	[23401002] = {
		23401002,
		0,
		Lang.get(59311),
		23401,
		2,
		392,
		nil,
		1
	},
	[23401003] = {
		23401003,
		0,
		Lang.get(59312),
		23401,
		3,
		391,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23401004] = {
		23401004,
		0,
		Lang.get(59313),
		23401,
		4,
		392,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23401005] = {
		23401005,
		0,
		Lang.get(59314),
		23401,
		5,
		391,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23401006] = {
		23401006,
		0,
		Lang.get(59315),
		23401,
		6,
		392,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23401007] = {
		23401007,
		0,
		Lang.get(59316),
		23401,
		7,
		391,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23401008] = {
		23401008,
		0,
		Lang.get(59317),
		23401,
		8,
		391,
		{
			RTResTalkAction[1]
		},
		1,
		[21] = 257
	},
	[23401009] = {
		23401009,
		0,
		Lang.get(59318),
		23401,
		9,
		391,
		{
			RTResTalkAction[1]
		},
		1,
		[21] = 257
	},
	[23401010] = {
		23401010,
		0,
		Lang.get(59319),
		23401,
		10,
		392,
		{
			RTResTalkAction[1]
		},
		1,
		[21] = 257
	},
	[23401011] = {
		23401011,
		0,
		Lang.get(59320),
		23401,
		11,
		259,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23402,
		nil,
		1,
		nil,
		1,
		nil,
		23402
	},
	[23401012] = {
		23401012,
		0,
		Lang.get(59321),
		23401,
		12,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23401013] = {
		23401013,
		0,
		Lang.get(59322),
		23401,
		13,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23401014] = {
		23401014,
		0,
		Lang.get(59323),
		23401,
		14,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23401015] = {
		23401015,
		0,
		Lang.get(59324),
		23401,
		15,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23402001] = {
		23402001,
		0,
		Lang.get(59325),
		23402,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		45,
		23405,
		nil,
		nil,
		nil,
		1,
		nil,
		23405
	},
	[23402002] = {
		23402002,
		0,
		Lang.get(59326),
		23402,
		2,
		112,
		nil,
		1,
		3
	},
	[23402003] = {
		23402003,
		0,
		Lang.get(59327),
		23402,
		3,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23402004] = {
		23402004,
		0,
		Lang.get(59328),
		23402,
		4,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23402005] = {
		23402005,
		0,
		Lang.get(59329),
		23402,
		5,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23402006] = {
		23402006,
		0,
		Lang.get(59330),
		23402,
		6,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[23402007] = {
		23402007,
		0,
		Lang.get(59331),
		23402,
		7,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402008] = {
		23402008,
		0,
		Lang.get(59332),
		23402,
		8,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402009] = {
		23402009,
		0,
		Lang.get(59333),
		23402,
		9,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[23402010] = {
		23402010,
		0,
		Lang.get(59334),
		23402,
		10,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402011] = {
		23402011,
		0,
		Lang.get(59335),
		23402,
		11,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402012] = {
		23402012,
		0,
		Lang.get(59336),
		23402,
		12,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402013] = {
		23402013,
		0,
		Lang.get(59337),
		23402,
		13,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402014] = {
		23402014,
		0,
		Lang.get(59338),
		23402,
		14,
		112,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23406,
		nil,
		1,
		nil,
		1,
		nil,
		23406
	},
	[23402015] = {
		23402015,
		0,
		Lang.get(59339),
		23402,
		15,
		259,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[23402016] = {
		23402016,
		0,
		Lang.get(59340),
		23402,
		16,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23402017] = {
		23402017,
		0,
		Lang.get(59341),
		23402,
		17,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402018] = {
		23402018,
		0,
		Lang.get(59342),
		23402,
		18,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402019] = {
		23402019,
		0,
		Lang.get(59343),
		23402,
		19,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[23402020] = {
		23402020,
		5,
		Lang.get(59344),
		23402,
		20,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23402021] = {
		23402021,
		0,
		Lang.get(59345),
		23402,
		21,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403001] = {
		23403001,
		0,
		Lang.get(59346),
		23403,
		1,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		45,
		23410,
		nil,
		nil,
		nil,
		1,
		nil,
		23410
	},
	[23403002] = {
		23403002,
		0,
		Lang.get(59347),
		23403,
		2,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[23403003] = {
		23403003,
		0,
		Lang.get(59348),
		23403,
		3,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403004] = {
		23403004,
		0,
		Lang.get(59349),
		23403,
		4,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403005] = {
		23403005,
		5,
		Lang.get(19561),
		23403,
		5,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[13]
		}
	},
	[23403006] = {
		23403006,
		0,
		Lang.get(59350),
		23403,
		6,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403007] = {
		23403007,
		0,
		Lang.get(59351),
		23403,
		7,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403008] = {
		23403008,
		0,
		Lang.get(59352),
		23403,
		8,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403009] = {
		23403009,
		0,
		Lang.get(59353),
		23403,
		9,
		259,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23403010] = {
		23403010,
		0,
		Lang.get(59354),
		23403,
		10,
		112,
		{
			RTResTalkAction[14],
			RTResTalkAction[9]
		}
	},
	[23403011] = {
		23403011,
		0,
		Lang.get(59355),
		23403,
		11,
		259,
		{
			RTResTalkAction[15]
		},
		1
	},
	[23403012] = {
		23403012,
		0,
		Lang.get(59356),
		23403,
		12,
		259,
		{
			RTResTalkAction[15]
		},
		1
	},
	[23403013] = {
		23403013,
		0,
		Lang.get(59357),
		23403,
		13,
		259,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		},
		1
	},
	[23403014] = {
		23403014,
		0,
		Lang.get(59358),
		23403,
		14,
		259,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23403015] = {
		23403015,
		5,
		Lang.get(59359),
		23403,
		15,
		112,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23411,
		nil,
		1,
		nil,
		1,
		nil,
		23411
	},
	[23403016] = {
		23403016,
		0,
		Lang.get(59360),
		23403,
		16,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23403017] = {
		23403017,
		0,
		Lang.get(59361),
		23403,
		17,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23403018] = {
		23403018,
		0,
		Lang.get(59362),
		23403,
		18,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23403019] = {
		23403019,
		0,
		Lang.get(59363),
		23403,
		19,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23403020] = {
		23403020,
		0,
		Lang.get(59364),
		23403,
		20,
		259,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		},
		1
	},
	[23403021] = {
		23403021,
		0,
		Lang.get(59365),
		23403,
		21,
		259,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23403022] = {
		23403022,
		0,
		Lang.get(59366),
		23403,
		22,
		112,
		{
			RTResTalkAction[1]
		},
		1,
		[21] = 257
	},
	[23403023] = {
		23403023,
		0,
		Lang.get(59367),
		23403,
		23,
		259,
		{
			RTResTalkAction[11],
			RTResTalkAction[2]
		}
	},
	[23403024] = {
		23403024,
		0,
		Lang.get(59368),
		23403,
		24,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23403025] = {
		23403025,
		0,
		Lang.get(59369),
		23403,
		25,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23403026] = {
		23403026,
		0,
		Lang.get(59370),
		23403,
		26,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23404001] = {
		23404001,
		0,
		Lang.get(59371),
		23404,
		1,
		262,
		nil,
		1,
		nil,
		nil,
		nil,
		57,
		23415,
		nil,
		nil,
		nil,
		1,
		nil,
		23415
	},
	[23404002] = {
		23404002,
		0,
		Lang.get(59372),
		23404,
		2,
		260,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[23404003] = {
		23404003,
		0,
		Lang.get(59373),
		23404,
		3,
		262,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[23404004] = {
		23404004,
		0,
		Lang.get(59374),
		23404,
		4,
		262,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[23404005] = {
		23404005,
		0,
		Lang.get(59375),
		23404,
		5,
		262,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[23404006] = {
		23404006,
		0,
		Lang.get(59376),
		23404,
		6,
		262,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[23404007] = {
		23404007,
		0,
		Lang.get(20200),
		23404,
		7,
		260,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[23404008] = {
		23404008,
		0,
		Lang.get(59377),
		23404,
		8,
		262,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23416,
		nil,
		1,
		nil,
		1,
		nil,
		23416
	},
	[23404009] = {
		23404009,
		0,
		Lang.get(59378),
		23404,
		9,
		259,
		nil,
		1
	},
	[23404010] = {
		23404010,
		0,
		Lang.get(59379),
		23404,
		10,
		262,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23417,
		[19] = 23417,
		[17] = 1
	},
	[23404011] = {
		23404011,
		0,
		Lang.get(59380),
		23404,
		11,
		260,
		{
			RTResTalkAction[21]
		},
		1
	},
	[23404012] = {
		23404012,
		5,
		Lang.get(59381),
		23404,
		12,
		262,
		{
			RTResTalkAction[21]
		}
	},
	[23404013] = {
		23404013,
		0,
		Lang.get(59382),
		23404,
		13,
		260,
		{
			RTResTalkAction[21]
		},
		1
	},
	[23404014] = {
		23404014,
		3,
		Lang.get(59383),
		23404,
		14,
		260,
		{
			RTResTalkAction[20]
		},
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
	[23404015] = {
		23404015,
		5,
		Lang.get(59384),
		23404,
		15,
		260,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23418,
		[19] = 23418,
		[17] = 1
	},
	[23404016] = {
		23404016,
		0,
		Lang.get(59385),
		23404,
		16,
		261,
		nil,
		1
	},
	[23404017] = {
		23404017,
		0,
		Lang.get(59386),
		23404,
		17,
		261,
		nil,
		1
	},
	[23404018] = {
		23404018,
		0,
		Lang.get(59387),
		23404,
		18,
		262,
		nil,
		1
	},
	[23404019] = {
		23404019,
		0,
		Lang.get(59388),
		23404,
		19,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23419,
		1,
		nil,
		nil,
		1,
		nil,
		23419
	},
	[23404020] = {
		23404020,
		7,
		"73",
		23404,
		20,
		257,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[23404021] = {
		23404021,
		0,
		Lang.get(59389),
		23404,
		21,
		261,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		0.5
	},
	[23404022] = {
		23404022,
		0,
		Lang.get(59390),
		23404,
		22,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[23]
		}
	},
	[23404023] = {
		23404023,
		0,
		Lang.get(59391),
		23404,
		23,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23404024] = {
		23404024,
		0,
		Lang.get(59392),
		23404,
		24,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23404025] = {
		23404025,
		0,
		Lang.get(19058),
		23404,
		25,
		261,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23405001] = {
		23405001,
		0,
		Lang.get(59393),
		23405,
		1,
		262,
		nil,
		1,
		nil,
		nil,
		nil,
		66,
		23420,
		nil,
		nil,
		nil,
		1,
		nil,
		23420
	},
	[23405002] = {
		23405002,
		0,
		Lang.get(59394),
		23405,
		2,
		261,
		nil,
		1
	},
	[23405003] = {
		23405003,
		0,
		Lang.get(59395),
		23405,
		3,
		261,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[23405004] = {
		23405004,
		0,
		Lang.get(59396),
		23405,
		4,
		262,
		{
			RTResTalkAction[24],
			RTResTalkAction[18]
		}
	},
	[23405005] = {
		23405005,
		0,
		Lang.get(59397),
		23405,
		5,
		261,
		{
			RTResTalkAction[24],
			RTResTalkAction[18]
		}
	},
	[23405006] = {
		23405006,
		0,
		Lang.get(59398),
		23405,
		6,
		260,
		{
			RTResTalkAction[24],
			RTResTalkAction[18]
		},
		1
	},
	[23405007] = {
		23405007,
		5,
		Lang.get(59399),
		23405,
		7,
		262,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[23405008] = {
		23405008,
		0,
		Lang.get(59400),
		23405,
		8,
		260,
		{
			RTResTalkAction[23],
			RTResTalkAction[20]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23421,
		nil,
		1,
		nil,
		1,
		nil,
		23421
	},
	[23405009] = {
		23405009,
		5,
		Lang.get(59401),
		23405,
		9,
		260,
		nil,
		1
	},
	[23406001] = {
		23406001,
		5,
		Lang.get(59402),
		23406,
		1,
		260,
		nil,
		1,
		nil,
		nil,
		nil,
		66,
		23425,
		nil,
		nil,
		nil,
		1,
		nil,
		23425
	},
	[23406002] = {
		23406002,
		5,
		Lang.get(59403),
		23406,
		2,
		260,
		nil,
		1
	},
	[23406003] = {
		23406003,
		0,
		Lang.get(59404),
		23406,
		3,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23406004] = {
		23406004,
		0,
		Lang.get(59405),
		23406,
		4,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23406005] = {
		23406005,
		0,
		Lang.get(59406),
		23406,
		5,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23406006] = {
		23406006,
		0,
		Lang.get(59407),
		23406,
		6,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23406007] = {
		23406007,
		0,
		Lang.get(59408),
		23406,
		7,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23406008] = {
		23406008,
		5,
		Lang.get(59409),
		23406,
		8,
		260,
		{
			RTResTalkAction[16],
			RTResTalkAction[2]
		}
	},
	[23406009] = {
		23406009,
		0,
		Lang.get(59410),
		23406,
		9,
		260,
		{
			RTResTalkAction[16]
		}
	},
	[23406010] = {
		23406010,
		0,
		Lang.get(59378),
		23406,
		10,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[19]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23426,
		nil,
		1,
		[19] = 23426,
		[17] = 1
	},
	[23406011] = {
		23406011,
		0,
		Lang.get(59411),
		23406,
		11,
		260,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23406012] = {
		23406012,
		5,
		Lang.get(59412),
		23406,
		12,
		260,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23406013] = {
		23406013,
		0,
		Lang.get(59413),
		23406,
		13,
		257,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23427,
		nil,
		1,
		nil,
		1,
		nil,
		23427
	},
	[23406014] = {
		23406014,
		5,
		Lang.get(59414),
		23406,
		14,
		260,
		{
			RTResTalkAction[26]
		},
		nil,
		nil,
		3
	},
	[23406015] = {
		23406015,
		0,
		Lang.get(59415),
		23406,
		15,
		261,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[23406016] = {
		23406016,
		0,
		Lang.get(59416),
		23406,
		16,
		257,
		{
			RTResTalkAction[24],
			RTResTalkAction[27]
		}
	},
	[23406017] = {
		23406017,
		0,
		Lang.get(59417),
		23406,
		17,
		257,
		{
			RTResTalkAction[24],
			RTResTalkAction[27]
		}
	},
	[23406018] = {
		23406018,
		5,
		Lang.get(59418),
		23406,
		18,
		260,
		{
			RTResTalkAction[23],
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23428,
		nil,
		1,
		nil,
		1,
		nil,
		23428
	},
	[23406019] = {
		23406019,
		5,
		Lang.get(59419),
		23406,
		19,
		260,
		nil,
		1
	},
	[23406020] = {
		23406020,
		0,
		Lang.get(59420),
		23406,
		20,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23406021] = {
		23406021,
		5,
		Lang.get(59421),
		23406,
		21,
		260,
		{
			RTResTalkAction[4],
			RTResTalkAction[28]
		},
		1
	},
	[23406022] = {
		23406022,
		0,
		Lang.get(59422),
		23406,
		22,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[29]
		}
	},
	[23406023] = {
		23406023,
		0,
		Lang.get(59423),
		23406,
		23,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23406024] = {
		23406024,
		0,
		Lang.get(59424),
		23406,
		24,
		259,
		{
			RTResTalkAction[11]
		}
	},
	[23407001] = {
		23407001,
		0,
		Lang.get(59425),
		23407,
		1,
		261,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		23430,
		nil,
		nil,
		nil,
		1,
		nil,
		23430
	},
	[23407002] = {
		23407002,
		0,
		Lang.get(59426),
		23407,
		2,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23407003] = {
		23407003,
		0,
		Lang.get(59427),
		23407,
		3,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23407004] = {
		23407004,
		0,
		Lang.get(59428),
		23407,
		4,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23407005] = {
		23407005,
		0,
		Lang.get(59429),
		23407,
		5,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23407006] = {
		23407006,
		0,
		Lang.get(59430),
		23407,
		6,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[23]
		}
	},
	[23407007] = {
		23407007,
		0,
		Lang.get(59431),
		23407,
		7,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23407008] = {
		23407008,
		0,
		Lang.get(59432),
		23407,
		8,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23407009] = {
		23407009,
		0,
		Lang.get(59433),
		23407,
		9,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23407010] = {
		23407010,
		0,
		Lang.get(59434),
		23407,
		10,
		263,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23407011] = {
		23407011,
		5,
		Lang.get(59435),
		23407,
		11,
		264,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23407012] = {
		23407012,
		0,
		Lang.get(59436),
		23407,
		12,
		261,
		{
			RTResTalkAction[1]
		},
		1
	},
	[23407013] = {
		23407013,
		0,
		Lang.get(59437),
		23407,
		13,
		263,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		57,
		23431,
		1,
		1,
		nil,
		3,
		nil,
		23431
	},
	[23407014] = {
		23407014,
		0,
		Lang.get(59438),
		23407,
		14,
		257,
		nil,
		1
	},
	[23407015] = {
		23407015,
		5,
		Lang.get(59419),
		23407,
		15,
		260,
		nil,
		1
	},
	[23407016] = {
		23407016,
		5,
		Lang.get(59439),
		23407,
		16,
		260,
		nil,
		1
	},
	[23407017] = {
		23407017,
		5,
		Lang.get(59440),
		23407,
		17,
		260,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23432
	},
	[23407018] = {
		23407018,
		0,
		Lang.get(59441),
		23407,
		18,
		263,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23433,
		[19] = 23433,
		[17] = 1
	},
	[23407019] = {
		23407019,
		0,
		Lang.get(59442),
		23407,
		19,
		264,
		nil,
		1
	},
	[23407020] = {
		23407020,
		0,
		Lang.get(59443),
		23407,
		20,
		261,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[23407021] = {
		23407021,
		0,
		Lang.get(59444),
		23407,
		21,
		261,
		{
			RTResTalkAction[22]
		}
	},
	[23407022] = {
		23407022,
		0,
		Lang.get(59445),
		23407,
		22,
		390,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23434,
		nil,
		1,
		[19] = 23434,
		[17] = 1
	},
	[23407023] = {
		23407023,
		0,
		Lang.get(59446),
		23407,
		23,
		390
	},
	[23407024] = {
		23407024,
		0,
		Lang.get(59447),
		23407,
		24,
		390,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23407025] = {
		23407025,
		0,
		Lang.get(59448),
		23407,
		25,
		263,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		},
		1
	},
	[23407026] = {
		23407026,
		0,
		Lang.get(59449),
		23407,
		26,
		261,
		{
			RTResTalkAction[2],
			RTResTalkAction[23]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23435,
		nil,
		1,
		nil,
		1,
		nil,
		23435
	},
	[23407027] = {
		23407027,
		0,
		Lang.get(59450),
		23407,
		27,
		268,
		nil,
		1
	},
	[23407028] = {
		23407028,
		0,
		Lang.get(59451),
		23407,
		28,
		261,
		nil,
		1
	},
	[23407029] = {
		23407029,
		0,
		Lang.get(59452),
		23407,
		29,
		257,
		nil,
		1
	},
	[23407030] = {
		23407030,
		0,
		Lang.get(20302),
		23407,
		30,
		261,
		nil,
		1
	},
	[23408001] = {
		23408001,
		0,
		Lang.get(59453),
		23408,
		1,
		112,
		nil,
		1,
		nil,
		nil,
		nil,
		164,
		23440,
		nil,
		nil,
		nil,
		1,
		nil,
		23440
	},
	[23408002] = {
		23408002,
		0,
		Lang.get(59454),
		23408,
		2,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23408003] = {
		23408003,
		0,
		Lang.get(59455),
		23408,
		3,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23408004] = {
		23408004,
		0,
		Lang.get(59456),
		23408,
		4,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408005] = {
		23408005,
		0,
		Lang.get(59457),
		23408,
		5,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408006] = {
		23408006,
		0,
		Lang.get(59458),
		23408,
		6,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408007] = {
		23408007,
		0,
		Lang.get(59459),
		23408,
		7,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408008] = {
		23408008,
		0,
		Lang.get(59460),
		23408,
		8,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408009] = {
		23408009,
		0,
		Lang.get(59461),
		23408,
		9,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408010] = {
		23408010,
		0,
		Lang.get(59462),
		23408,
		10,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408011] = {
		23408011,
		0,
		Lang.get(59463),
		23408,
		11,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408012] = {
		23408012,
		0,
		Lang.get(59464),
		23408,
		12,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[6]
		}
	},
	[23408013] = {
		23408013,
		0,
		Lang.get(59465),
		23408,
		13,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[32]
		}
	},
	[23408014] = {
		23408014,
		0,
		Lang.get(59466),
		23408,
		14,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408015] = {
		23408015,
		0,
		Lang.get(59467),
		23408,
		15,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408016] = {
		23408016,
		0,
		Lang.get(59468),
		23408,
		16,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408017] = {
		23408017,
		0,
		Lang.get(59469),
		23408,
		17,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[8]
		}
	},
	[23408018] = {
		23408018,
		0,
		Lang.get(26709),
		23408,
		18,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408019] = {
		23408019,
		0,
		Lang.get(59470),
		23408,
		19,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408020] = {
		23408020,
		0,
		Lang.get(59471),
		23408,
		20,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23408021] = {
		23408021,
		5,
		Lang.get(59472),
		23408,
		21,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[33]
		}
	},
	[23409001] = {
		23409001,
		0,
		Lang.get(59473),
		23409,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		164,
		23445,
		nil,
		nil,
		nil,
		1,
		nil,
		23445
	},
	[23409002] = {
		23409002,
		0,
		Lang.get(59474),
		23409,
		2,
		112,
		nil,
		1,
		1
	},
	[23409003] = {
		23409003,
		0,
		Lang.get(59475),
		23409,
		3,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23409004] = {
		23409004,
		0,
		Lang.get(59476),
		23409,
		4,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409005] = {
		23409005,
		0,
		Lang.get(59477),
		23409,
		5,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409006] = {
		23409006,
		0,
		Lang.get(59478),
		23409,
		6,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409007] = {
		23409007,
		0,
		Lang.get(59479),
		23409,
		7,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409008] = {
		23409008,
		0,
		Lang.get(59480),
		23409,
		8,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409009] = {
		23409009,
		0,
		Lang.get(59481),
		23409,
		9,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[8]
		}
	},
	[23409010] = {
		23409010,
		0,
		Lang.get(59482),
		23409,
		10,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409011] = {
		23409011,
		0,
		Lang.get(59483),
		23409,
		11,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409012] = {
		23409012,
		0,
		Lang.get(59484),
		23409,
		12,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[12]
		}
	},
	[23409013] = {
		23409013,
		0,
		Lang.get(59485),
		23409,
		13,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409014] = {
		23409014,
		0,
		Lang.get(59486),
		23409,
		14,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409015] = {
		23409015,
		0,
		Lang.get(59487),
		23409,
		15,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[6]
		}
	},
	[23409016] = {
		23409016,
		0,
		Lang.get(59488),
		23409,
		16,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409017] = {
		23409017,
		0,
		Lang.get(59489),
		23409,
		17,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409018] = {
		23409018,
		0,
		Lang.get(59490),
		23409,
		18,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[5]
		}
	},
	[23409019] = {
		23409019,
		0,
		Lang.get(59491),
		23409,
		19,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409020] = {
		23409020,
		0,
		Lang.get(59492),
		23409,
		20,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23409021] = {
		23409021,
		0,
		Lang.get(59493),
		23409,
		21,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23410001] = {
		23410001,
		5,
		Lang.get(59419),
		23410,
		1,
		260,
		nil,
		1,
		nil,
		nil,
		nil,
		4,
		23450,
		nil,
		nil,
		nil,
		1,
		nil,
		23450
	},
	[23410002] = {
		23410002,
		5,
		Lang.get(59439),
		23410,
		2,
		260,
		nil,
		1
	},
	[23410003] = {
		23410003,
		5,
		Lang.get(59440),
		23410,
		3,
		260,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23451
	},
	[23410004] = {
		23410004,
		0,
		Lang.get(59494),
		23410,
		4,
		107,
		nil,
		1,
		2,
		nil,
		nil,
		23,
		23452,
		nil,
		nil,
		nil,
		1,
		nil,
		23452
	},
	[23410005] = {
		23410005,
		0,
		Lang.get(59495),
		23410,
		5,
		107,
		nil,
		1,
		2
	},
	[23410006] = {
		23410006,
		0,
		Lang.get(59496),
		23410,
		6,
		107,
		nil,
		1,
		2
	},
	[23410007] = {
		23410007,
		0,
		Lang.get(59497),
		23410,
		7,
		107,
		nil,
		1,
		2
	},
	[23410008] = {
		23410008,
		0,
		Lang.get(59498),
		23410,
		8,
		134,
		nil,
		1,
		1
	},
	[23410009] = {
		23410009,
		0,
		Lang.get(59499),
		23410,
		9,
		107,
		nil,
		1,
		8
	},
	[23410010] = {
		23410010,
		0,
		Lang.get(59500),
		23410,
		10,
		134,
		nil,
		1,
		2
	},
	[23410011] = {
		23410011,
		5,
		Lang.get(59501),
		23410,
		11,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		23453,
		nil,
		nil,
		nil,
		1,
		nil,
		23453
	},
	[23410012] = {
		23410012,
		0,
		Lang.get(59502),
		23410,
		12,
		107,
		nil,
		1,
		1
	},
	[23410013] = {
		23410013,
		0,
		Lang.get(59503),
		23410,
		13,
		257,
		nil,
		1,
		0
	},
	[23410014] = {
		23410014,
		0,
		Lang.get(59504),
		23410,
		14,
		134,
		nil,
		1,
		4
	},
	[23410015] = {
		23410015,
		3,
		Lang.get(59505),
		23410,
		15,
		134,
		[22] = 1
	},
	[23410016] = {
		23410016,
		0,
		Lang.get(59506),
		23410,
		16,
		300
	},
	[23410017] = {
		23410017,
		0,
		Lang.get(59507),
		23410,
		17,
		257,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23454,
		nil,
		nil,
		nil,
		1,
		nil,
		23454
	},
	[23410018] = {
		23410018,
		0,
		Lang.get(59508),
		23410,
		18,
		257,
		nil,
		1
	},
	[23410019] = {
		23410019,
		0,
		Lang.get(59509),
		23410,
		19,
		257,
		nil,
		1
	},
	[23410020] = {
		23410020,
		0,
		Lang.get(59510),
		23410,
		20,
		300
	},
	[23410021] = {
		23410021,
		0,
		Lang.get(59511),
		23410,
		21,
		257,
		nil,
		1
	},
	[23410022] = {
		23410022,
		0,
		Lang.get(59512),
		23410,
		22,
		257,
		nil,
		1
	},
	[23410023] = {
		23410023,
		0,
		Lang.get(59513),
		23410,
		23,
		300
	},
	[23410024] = {
		23410024,
		0,
		Lang.get(59514),
		23410,
		24,
		257,
		nil,
		1
	},
	[23410025] = {
		23410025,
		0,
		Lang.get(59515),
		23410,
		25,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		23455,
		[19] = 23455,
		[17] = 1
	},
	[23410026] = {
		23410026,
		0,
		Lang.get(59516),
		23410,
		26,
		257,
		nil,
		1
	},
	[23410027] = {
		23410027,
		0,
		Lang.get(59517),
		23410,
		27,
		257,
		nil,
		1
	},
	[23410028] = {
		23410028,
		0,
		Lang.get(59518),
		23410,
		28,
		257,
		nil,
		1
	},
	[23410029] = {
		23410029,
		0,
		Lang.get(59519),
		23410,
		29,
		300
	},
	[23410030] = {
		23410030,
		0,
		Lang.get(59520),
		23410,
		30,
		257,
		nil,
		1
	},
	[23411001] = {
		23411001,
		0,
		Lang.get(59521),
		23411,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		23,
		23456,
		nil,
		nil,
		nil,
		1,
		nil,
		23456
	},
	[23411002] = {
		23411002,
		0,
		Lang.get(59522),
		23411,
		2,
		257,
		nil,
		1
	},
	[23411003] = {
		23411003,
		0,
		Lang.get(59523),
		23411,
		3,
		257,
		nil,
		1
	},
	[23411004] = {
		23411004,
		0,
		Lang.get(59524),
		23411,
		4,
		300
	},
	[23411005] = {
		23411005,
		0,
		Lang.get(59525),
		23411,
		5,
		257,
		nil,
		1
	},
	[23411006] = {
		23411006,
		0,
		Lang.get(59526),
		23411,
		6,
		257,
		nil,
		1
	},
	[23411007] = {
		23411007,
		0,
		Lang.get(59527),
		23411,
		7,
		300
	},
	[23411008] = {
		23411008,
		0,
		Lang.get(19902),
		23411,
		8,
		257,
		nil,
		1
	},
	[23411009] = {
		23411009,
		0,
		Lang.get(59528),
		23411,
		9,
		300
	},
	[23411010] = {
		23411010,
		0,
		Lang.get(59529),
		23411,
		10,
		300
	},
	[23411011] = {
		23411011,
		0,
		Lang.get(59530),
		23411,
		11,
		257,
		nil,
		1
	},
	[23411012] = {
		23411012,
		0,
		Lang.get(59531),
		23411,
		12,
		257,
		nil,
		1
	},
	[23411013] = {
		23411013,
		0,
		Lang.get(59532),
		23411,
		13,
		261,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23457,
		[19] = 23457,
		[17] = 1
	},
	[23411014] = {
		23411014,
		0,
		Lang.get(59533),
		23411,
		14,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23411015] = {
		23411015,
		0,
		Lang.get(59534),
		23411,
		15,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23411016] = {
		23411016,
		0,
		Lang.get(59535),
		23411,
		16,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411017] = {
		23411017,
		0,
		Lang.get(59536),
		23411,
		17,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411018] = {
		23411018,
		0,
		Lang.get(59537),
		23411,
		18,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411019] = {
		23411019,
		0,
		Lang.get(59538),
		23411,
		19,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411020] = {
		23411020,
		0,
		Lang.get(59539),
		23411,
		20,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411021] = {
		23411021,
		0,
		Lang.get(59540),
		23411,
		21,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411022] = {
		23411022,
		0,
		Lang.get(59541),
		23411,
		22,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411023] = {
		23411023,
		0,
		Lang.get(59542),
		23411,
		23,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411024] = {
		23411024,
		0,
		Lang.get(59543),
		23411,
		24,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411025] = {
		23411025,
		0,
		Lang.get(59544),
		23411,
		25,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411026] = {
		23411026,
		0,
		Lang.get(59545),
		23411,
		26,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411027] = {
		23411027,
		0,
		Lang.get(59546),
		23411,
		27,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411028] = {
		23411028,
		0,
		Lang.get(59547),
		23411,
		28,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411029] = {
		23411029,
		0,
		Lang.get(59548),
		23411,
		29,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411030] = {
		23411030,
		0,
		Lang.get(59549),
		23411,
		30,
		261,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411031] = {
		23411031,
		0,
		Lang.get(59550),
		23411,
		31,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411032] = {
		23411032,
		0,
		Lang.get(59551),
		23411,
		32,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[23411033] = {
		23411033,
		0,
		Lang.get(59552),
		23411,
		33,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[23]
		}
	},
	[23411034] = {
		23411034,
		0,
		Lang.get(59553),
		23411,
		34,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23412001] = {
		23412001,
		0,
		Lang.get(59554),
		23412,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		41,
		23460,
		[19] = 23460,
		[17] = 1
	},
	[23412002] = {
		23412002,
		0,
		Lang.get(59555),
		23412,
		2,
		263,
		nil,
		1
	},
	[23412003] = {
		23412003,
		0,
		Lang.get(59556),
		23412,
		3,
		263,
		nil,
		1
	},
	[23412004] = {
		23412004,
		0,
		Lang.get(59557),
		23412,
		4,
		263,
		nil,
		1
	},
	[23412005] = {
		23412005,
		0,
		Lang.get(59558),
		23412,
		5,
		264,
		nil,
		1
	},
	[23412006] = {
		23412006,
		0,
		Lang.get(59559),
		23412,
		6,
		300
	},
	[23412007] = {
		23412007,
		0,
		Lang.get(59560),
		23412,
		7,
		300
	},
	[23412008] = {
		23412008,
		0,
		Lang.get(59561),
		23412,
		8,
		300
	},
	[23412009] = {
		23412009,
		0,
		Lang.get(59562),
		23412,
		9,
		264,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23461
	},
	[23412010] = {
		23412010,
		0,
		Lang.get(59563),
		23412,
		10,
		264,
		nil,
		1
	},
	[23412011] = {
		23412011,
		0,
		Lang.get(59564),
		23412,
		11,
		263,
		nil,
		1
	},
	[23412012] = {
		23412012,
		0,
		Lang.get(59565),
		23412,
		12,
		263,
		nil,
		1
	},
	[23412013] = {
		23412013,
		0,
		Lang.get(59566),
		23412,
		13,
		300
	},
	[23412014] = {
		23412014,
		0,
		Lang.get(59567),
		23412,
		14,
		263,
		nil,
		1
	},
	[23412015] = {
		23412015,
		5,
		Lang.get(59568),
		23412,
		15,
		264,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23462,
		[19] = 23462,
		[17] = 1
	},
	[23412016] = {
		23412016,
		0,
		Lang.get(59569),
		23412,
		16,
		107,
		nil,
		1,
		0
	},
	[23412017] = {
		23412017,
		0,
		Lang.get(59570),
		23412,
		17,
		107,
		nil,
		1,
		5
	},
	[23412018] = {
		23412018,
		0,
		Lang.get(59571),
		23412,
		18,
		263,
		nil,
		1,
		0
	},
	[23412019] = {
		23412019,
		0,
		Lang.get(59572),
		23412,
		19,
		264,
		nil,
		1
	},
	[23412020] = {
		23412020,
		0,
		Lang.get(59573),
		23412,
		20,
		263,
		nil,
		1
	},
	[23413001] = {
		23413001,
		0,
		Lang.get(59574),
		23413,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		41,
		23465,
		nil,
		nil,
		nil,
		1,
		nil,
		23465
	},
	[23413002] = {
		23413002,
		0,
		Lang.get(59575),
		23413,
		2,
		257,
		nil,
		1
	},
	[23413003] = {
		23413003,
		0,
		Lang.get(59576),
		23413,
		3,
		257,
		nil,
		1
	},
	[23413004] = {
		23413004,
		0,
		Lang.get(59577),
		23413,
		4,
		257,
		nil,
		1
	},
	[23413005] = {
		23413005,
		0,
		Lang.get(59578),
		23413,
		5,
		257,
		nil,
		1
	},
	[23413006] = {
		23413006,
		0,
		Lang.get(59579),
		23413,
		6,
		259,
		nil,
		1
	},
	[23413007] = {
		23413007,
		5,
		Lang.get(59580),
		23413,
		7,
		263,
		nil,
		1
	},
	[23413008] = {
		23413008,
		0,
		Lang.get(59581),
		23413,
		8,
		259,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23466,
		[19] = 23466,
		[17] = 1
	},
	[23413009] = {
		23413009,
		0,
		Lang.get(59582),
		23413,
		9,
		259,
		nil,
		1
	},
	[23413010] = {
		23413010,
		0,
		Lang.get(59583),
		23413,
		10,
		300
	},
	[23413011] = {
		23413011,
		0,
		Lang.get(59584),
		23413,
		11,
		259,
		nil,
		1
	},
	[23413012] = {
		23413012,
		0,
		Lang.get(59585),
		23413,
		12,
		259,
		nil,
		1
	},
	[23413013] = {
		23413013,
		0,
		Lang.get(59586),
		23413,
		13,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23413014] = {
		23413014,
		0,
		Lang.get(59587),
		23413,
		14,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23413015] = {
		23413015,
		0,
		Lang.get(59588),
		23413,
		15,
		259,
		{
			RTResTalkAction[30],
			RTResTalkAction[34]
		}
	},
	[23413016] = {
		23413016,
		0,
		Lang.get(59589),
		23413,
		16,
		259,
		{
			RTResTalkAction[30],
			RTResTalkAction[34]
		}
	},
	[23413017] = {
		23413017,
		0,
		Lang.get(59590),
		23413,
		17,
		259,
		{
			RTResTalkAction[30],
			RTResTalkAction[35]
		}
	},
	[23414001] = {
		23414001,
		0,
		Lang.get(59591),
		23414,
		1,
		259,
		nil,
		1,
		nil,
		nil,
		nil,
		164,
		23470,
		nil,
		nil,
		nil,
		1,
		nil,
		23470
	},
	[23414002] = {
		23414002,
		0,
		Lang.get(59592),
		23414,
		2,
		259,
		nil,
		1
	},
	[23414003] = {
		23414003,
		0,
		Lang.get(59593),
		23414,
		3,
		259,
		nil,
		1
	},
	[23414004] = {
		23414004,
		0,
		Lang.get(59594),
		23414,
		4,
		259,
		nil,
		1
	},
	[23414005] = {
		23414005,
		0,
		Lang.get(59595),
		23414,
		5,
		259,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[23414006] = {
		23414006,
		0,
		Lang.get(59596),
		23414,
		6,
		259,
		{
			RTResTalkAction[11]
		}
	},
	[23414007] = {
		23414007,
		0,
		Lang.get(59597),
		23414,
		7,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414008] = {
		23414008,
		0,
		Lang.get(59598),
		23414,
		8,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414009] = {
		23414009,
		0,
		Lang.get(59599),
		23414,
		9,
		259,
		{
			RTResTalkAction[3]
		},
		[20] = 255
	},
	[23414010] = {
		23414010,
		0,
		Lang.get(59600),
		23414,
		10,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414011] = {
		23414011,
		0,
		Lang.get(59601),
		23414,
		11,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414012] = {
		23414012,
		0,
		Lang.get(59602),
		23414,
		12,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414013] = {
		23414013,
		0,
		Lang.get(59603),
		23414,
		13,
		259,
		{
			RTResTalkAction[11]
		},
		[20] = -1
	},
	[23414014] = {
		23414014,
		0,
		Lang.get(59604),
		23414,
		14,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414015] = {
		23414015,
		0,
		Lang.get(59605),
		23414,
		15,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414016] = {
		23414016,
		5,
		Lang.get(59606),
		23414,
		16,
		263,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23414017] = {
		23414017,
		5,
		Lang.get(59607),
		23414,
		17,
		264,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23414018] = {
		23414018,
		5,
		Lang.get(59608),
		23414,
		18,
		263,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23414019] = {
		23414019,
		0,
		Lang.get(59609),
		23414,
		19,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23414020] = {
		23414020,
		0,
		Lang.get(59610),
		23414,
		20,
		257,
		{
			RTResTalkAction[4],
			RTResTalkAction[27]
		}
	},
	[23415001] = {
		23415001,
		0,
		Lang.get(59611),
		23415,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		164,
		23475,
		nil,
		nil,
		nil,
		1,
		nil,
		23475
	},
	[23415002] = {
		23415002,
		0,
		Lang.get(59612),
		23415,
		2,
		257,
		nil,
		1
	},
	[23415003] = {
		23415003,
		0,
		Lang.get(59613),
		23415,
		3,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23415004] = {
		23415004,
		0,
		Lang.get(59614),
		23415,
		4,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23415005] = {
		23415005,
		0,
		Lang.get(59615),
		23415,
		5,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[23415006] = {
		23415006,
		0,
		Lang.get(59616),
		23415,
		6,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[23415007] = {
		23415007,
		0,
		Lang.get(59617),
		23415,
		7,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23415008] = {
		23415008,
		0,
		Lang.get(59618),
		23415,
		8,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23415009] = {
		23415009,
		0,
		Lang.get(59619),
		23415,
		9,
		257,
		{
			RTResTalkAction[36],
			RTResTalkAction[2]
		},
		1,
		[21] = 337
	},
	[23415010] = {
		23415010,
		0,
		Lang.get(59620),
		23415,
		10,
		263,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 337
	},
	[23415011] = {
		23415011,
		0,
		Lang.get(59621),
		23415,
		11,
		259,
		{
			RTResTalkAction[36]
		},
		1,
		[21] = 337
	},
	[23415012] = {
		23415012,
		0,
		Lang.get(59622),
		23415,
		12,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[37]
		}
	},
	[23415013] = {
		23415013,
		0,
		Lang.get(59623),
		23415,
		13,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23415014] = {
		23415014,
		0,
		Lang.get(59624),
		23415,
		14,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23415015] = {
		23415015,
		5,
		Lang.get(59418),
		23415,
		15,
		260,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23476,
		nil,
		1,
		nil,
		1,
		nil,
		23476
	},
	[23415016] = {
		23415016,
		0,
		Lang.get(59419),
		23415,
		16,
		260,
		nil,
		1
	},
	[23415017] = {
		23415017,
		0,
		Lang.get(59420),
		23415,
		17,
		259,
		nil,
		1
	},
	[23415018] = {
		23415018,
		5,
		Lang.get(59421),
		23415,
		18,
		260,
		nil,
		1
	},
	[23415019] = {
		23415019,
		0,
		Lang.get(59422),
		23415,
		19,
		259,
		nil,
		1
	},
	[23415020] = {
		23415020,
		0,
		Lang.get(59423),
		23415,
		20,
		259,
		nil,
		1
	},
	[23415021] = {
		23415021,
		0,
		Lang.get(59424),
		23415,
		21,
		259,
		nil,
		1
	},
	[23415022] = {
		23415022,
		5,
		"！！！！",
		23415,
		22,
		263,
		nil,
		1
	},
	[23415023] = {
		23415023,
		5,
		Lang.get(59625),
		23415,
		23,
		264,
		nil,
		1
	},
	[23415024] = {
		23415024,
		0,
		Lang.get(59626),
		23415,
		24,
		259,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23477,
		[19] = 23477,
		[17] = 1
	},
	[23415025] = {
		23415025,
		0,
		Lang.get(59627),
		23415,
		25,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23415026] = {
		23415026,
		0,
		Lang.get(59628),
		23415,
		26,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23415027] = {
		23415027,
		0,
		Lang.get(59629),
		23415,
		27,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23415028] = {
		23415028,
		0,
		Lang.get(59630),
		23415,
		28,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23415029] = {
		23415029,
		0,
		Lang.get(59631),
		23415,
		29,
		112,
		{
			RTResTalkAction[3]
		},
		1
	},
	[23415030] = {
		23415030,
		0,
		Lang.get(59632),
		23415,
		30,
		112,
		{
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23478,
		nil,
		1,
		nil,
		1,
		nil,
		23478
	},
	[23415031] = {
		23415031,
		0,
		Lang.get(59633),
		23415,
		31,
		112,
		nil,
		1,
		3
	},
	[23416001] = {
		23416001,
		0,
		Lang.get(59634),
		23416,
		1,
		259,
		nil,
		1,
		nil,
		nil,
		nil,
		50,
		23480,
		nil,
		nil,
		nil,
		1,
		nil,
		23480
	},
	[23416002] = {
		23416002,
		0,
		Lang.get(59635),
		23416,
		2,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23416003] = {
		23416003,
		0,
		Lang.get(59636),
		23416,
		3,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23416004] = {
		23416004,
		0,
		Lang.get(59637),
		23416,
		4,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[23416005] = {
		23416005,
		0,
		Lang.get(59638),
		23416,
		5,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[23416006] = {
		23416006,
		0,
		Lang.get(59639),
		23416,
		6,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23416007] = {
		23416007,
		0,
		Lang.get(59640),
		23416,
		7,
		112,
		{
			RTResTalkAction[4],
			RTResTalkAction[7]
		}
	},
	[23416008] = {
		23416008,
		0,
		Lang.get(59641),
		23416,
		8,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[10]
		}
	},
	[23416009] = {
		23416009,
		0,
		Lang.get(59642),
		23416,
		9,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23416010] = {
		23416010,
		0,
		Lang.get(59643),
		23416,
		10,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[9]
		}
	},
	[23416011] = {
		23416011,
		0,
		Lang.get(59644),
		23416,
		11,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23416012] = {
		23416012,
		0,
		Lang.get(59645),
		23416,
		12,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[23416013] = {
		23416013,
		0,
		Lang.get(59646),
		23416,
		13,
		259,
		{
			RTResTalkAction[3]
		}
	},
	[23416014] = {
		23416014,
		0,
		Lang.get(59647),
		23416,
		14,
		112,
		{
			RTResTalkAction[38],
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23481,
		nil,
		1,
		[19] = 23481,
		[17] = 1
	},
	[23416015] = {
		23416015,
		0,
		Lang.get(59648),
		23416,
		15,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[10]
		}
	},
	[23416016] = {
		23416016,
		0,
		Lang.get(59649),
		23416,
		16,
		134,
		{
			RTResTalkAction[40],
			RTResTalkAction[41]
		}
	},
	[23416017] = {
		23416017,
		0,
		Lang.get(59650),
		23416,
		17,
		300,
		{
			RTResTalkAction[40],
			RTResTalkAction[42]
		}
	},
	[23416018] = {
		23416018,
		0,
		Lang.get(59651),
		23416,
		18,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[43],
			RTResTalkAction[44]
		}
	},
	[23416019] = {
		23416019,
		3,
		Lang.get(43474),
		23416,
		19,
		259,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23482,
		nil,
		1,
		[19] = 23482,
		[22] = 1
	},
	[23416020] = {
		23416020,
		3,
		Lang.get(59652),
		23416,
		20,
		259,
		[22] = 1
	},
	[23417001] = {
		23417001,
		0,
		Lang.get(59653),
		23417,
		1,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		50,
		23485,
		nil,
		nil,
		nil,
		1,
		nil,
		23485
	},
	[23417002] = {
		23417002,
		0,
		Lang.get(59654),
		23417,
		2,
		112,
		nil,
		1,
		2
	},
	[23417003] = {
		23417003,
		0,
		Lang.get(59655),
		23417,
		3,
		268,
		nil,
		1,
		0
	},
	[23417004] = {
		23417004,
		0,
		Lang.get(59656),
		23417,
		4,
		112,
		nil,
		1,
		2
	},
	[23417005] = {
		23417005,
		0,
		Lang.get(59657),
		23417,
		5,
		268,
		nil,
		1,
		0
	},
	[23417006] = {
		23417006,
		0,
		Lang.get(59658),
		23417,
		6,
		268,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23486,
		nil,
		nil,
		nil,
		1,
		nil,
		23486
	},
	[23417007] = {
		23417007,
		3,
		Lang.get(59659),
		23417,
		7,
		268,
		[22] = 1
	},
	[23417008] = {
		23417008,
		5,
		Lang.get(59660),
		23417,
		8,
		393
	},
	[23417009] = {
		23417009,
		0,
		Lang.get(59661),
		23417,
		9,
		268,
		nil,
		1
	},
	[23417010] = {
		23417010,
		0,
		Lang.get(59662),
		23417,
		10,
		272,
		nil,
		1
	},
	[23417011] = {
		23417011,
		0,
		Lang.get(59663),
		23417,
		11,
		268,
		nil,
		1
	},
	[23417012] = {
		23417012,
		0,
		Lang.get(59664),
		23417,
		12,
		268,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23487,
		[19] = 23487,
		[17] = 1
	},
	[23417013] = {
		23417013,
		0,
		Lang.get(59665),
		23417,
		13,
		112,
		nil,
		1,
		1
	},
	[23417014] = {
		23417014,
		0,
		Lang.get(59666),
		23417,
		14,
		52,
		nil,
		1,
		0
	},
	[23417015] = {
		23417015,
		0,
		Lang.get(59667),
		23417,
		15,
		52,
		nil,
		1
	},
	[23417016] = {
		23417016,
		0,
		Lang.get(59668),
		23417,
		16,
		112,
		nil,
		1,
		2
	},
	[23417017] = {
		23417017,
		0,
		Lang.get(59669),
		23417,
		17,
		272,
		nil,
		1,
		0
	},
	[23417018] = {
		23417018,
		0,
		Lang.get(59670),
		23417,
		18,
		112,
		nil,
		1,
		1
	},
	[23417019] = {
		23417019,
		0,
		Lang.get(59671),
		23417,
		19,
		112,
		nil,
		1,
		1
	},
	[23417020] = {
		23417020,
		0,
		Lang.get(59672),
		23417,
		20,
		576,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23488,
		nil,
		nil,
		nil,
		1,
		nil,
		23488
	},
	[23417021] = {
		23417021,
		0,
		Lang.get(59673),
		23417,
		21,
		112,
		nil,
		1,
		3
	},
	[23417022] = {
		23417022,
		0,
		Lang.get(59674),
		23417,
		22,
		576,
		nil,
		1,
		0
	},
	[23417023] = {
		23417023,
		0,
		Lang.get(59675),
		23417,
		23,
		576,
		nil,
		1
	},
	[23417024] = {
		23417024,
		0,
		Lang.get(59676),
		23417,
		24,
		576,
		nil,
		1
	},
	[23417025] = {
		23417025,
		5,
		Lang.get(59677),
		23417,
		25,
		112,
		nil,
		1,
		2
	},
	[23417026] = {
		23417026,
		0,
		Lang.get(59678),
		23417,
		26,
		112,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		23489,
		nil,
		nil,
		nil,
		1,
		nil,
		23489
	},
	[23417027] = {
		23417027,
		0,
		Lang.get(59679),
		23417,
		27,
		112,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[23417028] = {
		23417028,
		0,
		Lang.get(59680),
		23417,
		28,
		258,
		{
			RTResTalkAction[46],
			RTResTalkAction[10]
		}
	},
	[23417029] = {
		23417029,
		0,
		Lang.get(59681),
		23417,
		29,
		258,
		{
			RTResTalkAction[46]
		}
	},
	[23417030] = {
		23417030,
		0,
		Lang.get(59682),
		23417,
		30,
		107,
		{
			RTResTalkAction[46]
		},
		1,
		10
	},
	[23417031] = {
		23417031,
		0,
		Lang.get(59683),
		23417,
		31,
		300,
		{
			RTResTalkAction[46]
		}
	},
	[23418001] = {
		23418001,
		0,
		Lang.get(59684),
		23418,
		1,
		576,
		nil,
		1,
		nil,
		nil,
		nil,
		66,
		23490,
		nil,
		nil,
		nil,
		1,
		nil,
		23490
	},
	[23418002] = {
		23418002,
		0,
		Lang.get(59685),
		23418,
		2,
		576,
		nil,
		1
	},
	[23418003] = {
		23418003,
		0,
		Lang.get(59686),
		23418,
		3,
		112,
		nil,
		1
	},
	[23418004] = {
		23418004,
		0,
		Lang.get(59687),
		23418,
		4,
		258,
		nil,
		1
	},
	[23418005] = {
		23418005,
		0,
		Lang.get(59688),
		23418,
		5,
		259,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		23491,
		[19] = 23491,
		[17] = 1
	},
	[23418006] = {
		23418006,
		0,
		Lang.get(59689),
		23418,
		6,
		258,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[23418007] = {
		23418007,
		0,
		Lang.get(59690),
		23418,
		7,
		258,
		{
			RTResTalkAction[46]
		}
	},
	[23418008] = {
		23418008,
		0,
		Lang.get(59691),
		23418,
		8,
		259,
		{
			RTResTalkAction[47],
			RTResTalkAction[34]
		}
	},
	[23418009] = {
		23418009,
		0,
		Lang.get(59692),
		23418,
		9,
		259,
		{
			RTResTalkAction[47],
			RTResTalkAction[34]
		}
	},
	[23418010] = {
		23418010,
		0,
		Lang.get(59693),
		23418,
		10,
		258,
		{
			RTResTalkAction[47],
			RTResTalkAction[34]
		}
	},
	[23418011] = {
		23418011,
		0,
		Lang.get(59694),
		23418,
		11,
		261,
		{
			RTResTalkAction[22],
			RTResTalkAction[48],
			RTResTalkAction[9]
		}
	},
	[23418012] = {
		23418012,
		0,
		Lang.get(59695),
		23418,
		12,
		259,
		{
			RTResTalkAction[3],
			RTResTalkAction[23]
		}
	},
	[23418013] = {
		23418013,
		0,
		Lang.get(59696),
		23418,
		13,
		258,
		{
			RTResTalkAction[46],
			RTResTalkAction[9]
		}
	},
	[23418014] = {
		23418014,
		0,
		Lang.get(59697),
		23418,
		14,
		258,
		{
			RTResTalkAction[46]
		}
	},
	[23418015] = {
		23418015,
		0,
		Lang.get(59698),
		23418,
		15,
		259,
		{
			RTResTalkAction[47],
			RTResTalkAction[34]
		}
	},
	[23418016] = {
		23418016,
		0,
		Lang.get(59699),
		23418,
		16,
		258,
		{
			RTResTalkAction[48],
			RTResTalkAction[9]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23492,
		nil,
		1,
		nil,
		1,
		nil,
		23492
	},
	[23418017] = {
		23418017,
		5,
		"！！！",
		23418,
		17,
		261,
		nil,
		1
	},
	[23418018] = {
		23418018,
		2,
		Lang.get(59700),
		23418,
		18,
		261,
		nil,
		1
	},
	[23418019] = {
		23418019,
		2,
		Lang.get(59701),
		23418,
		19,
		261,
		nil,
		1
	},
	[23418020] = {
		23418020,
		2,
		Lang.get(59702),
		23418,
		20,
		261,
		nil,
		1
	},
	[23418021] = {
		23418021,
		0,
		Lang.get(59703),
		23418,
		21,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		23493,
		[19] = 23493,
		[17] = 1
	},
	[23418022] = {
		23418022,
		0,
		Lang.get(59704),
		23418,
		22,
		112,
		nil,
		1
	},
	[23418023] = {
		23418023,
		0,
		Lang.get(59705),
		23418,
		23,
		258,
		{
			RTResTalkAction[46]
		},
		nil,
		nil,
		3
	},
	[23418024] = {
		23418024,
		0,
		Lang.get(59706),
		23418,
		24,
		337,
		{
			RTResTalkAction[47],
			RTResTalkAction[49]
		}
	},
	[23418025] = {
		23418025,
		0,
		Lang.get(59707),
		23418,
		25,
		258,
		{
			RTResTalkAction[47],
			RTResTalkAction[50],
			RTResTalkAction[37]
		}
	},
	[23418026] = {
		23418026,
		0,
		Lang.get(59708),
		23418,
		26,
		258,
		{
			RTResTalkAction[47],
			RTResTalkAction[50]
		}
	},
	[23418027] = {
		23418027,
		0,
		Lang.get(59709),
		23418,
		27,
		66,
		{
			RTResTalkAction[47],
			RTResTalkAction[50]
		}
	},
	[23418028] = {
		23418028,
		0,
		Lang.get(16710),
		23418,
		28,
		50,
		{
			RTResTalkAction[47],
			RTResTalkAction[51],
			RTResTalkAction[52]
		}
	},
	[23418029] = {
		23418029,
		0,
		Lang.get(59710),
		23418,
		29,
		258,
		{
			RTResTalkAction[46],
			RTResTalkAction[53]
		}
	},
	[23418030] = {
		23418030,
		0,
		Lang.get(59711),
		23418,
		30,
		258,
		{
			RTResTalkAction[46]
		}
	},
	[23419001] = {
		23419001,
		0,
		Lang.get(59712),
		23419,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		23495,
		nil,
		nil,
		nil,
		1,
		nil,
		23495
	},
	[23419002] = {
		23419002,
		0,
		Lang.get(59713),
		23419,
		2,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23419003] = {
		23419003,
		0,
		Lang.get(59714),
		23419,
		3,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23419004] = {
		23419004,
		0,
		Lang.get(59715),
		23419,
		4,
		257,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23419005] = {
		23419005,
		0,
		Lang.get(59716),
		23419,
		5,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23419006] = {
		23419006,
		0,
		Lang.get(59717),
		23419,
		6,
		112,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[23419007] = {
		23419007,
		0,
		Lang.get(59718),
		23419,
		7,
		268,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		},
		1
	},
	[23419008] = {
		23419008,
		0,
		Lang.get(59719),
		23419,
		8,
		300,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23496,
		nil,
		1,
		[19] = 23496,
		[17] = 1
	},
	[23419009] = {
		23419009,
		0,
		Lang.get(59720),
		23419,
		9,
		257,
		nil,
		1
	},
	[23419010] = {
		23419010,
		0,
		Lang.get(59721),
		23419,
		10,
		300
	},
	[23419011] = {
		23419011,
		0,
		Lang.get(59722),
		23419,
		11,
		257,
		nil,
		1
	},
	[23419012] = {
		23419012,
		0,
		Lang.get(59723),
		23419,
		12,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23419013] = {
		23419013,
		4,
		nil,
		23419,
		13,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23419014,
				branch_content = Lang.get(59724)
			}
		}
	},
	[23419014] = {
		23419014,
		0,
		Lang.get(59725),
		23419,
		14,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23419015] = {
		23419015,
		4,
		nil,
		23419,
		15,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23419016,
				branch_content = Lang.get(59726)
			}
		}
	},
	[23419016] = {
		23419016,
		0,
		Lang.get(59727),
		23419,
		16,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23419017] = {
		23419017,
		0,
		Lang.get(59728),
		23419,
		17,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23419018] = {
		23419018,
		0,
		Lang.get(59729),
		23419,
		18,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23419019] = {
		23419019,
		0,
		Lang.get(59730),
		23419,
		19,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		23497,
		nil,
		1,
		[19] = 23497,
		[17] = 1
	},
	[23419020] = {
		23419020,
		4,
		nil,
		23419,
		20,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23419021,
				branch_content = Lang.get(59731)
			}
		}
	},
	[23419021] = {
		23419021,
		0,
		Lang.get(59732),
		23419,
		21,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23419022] = {
		23419022,
		0,
		Lang.get(59733),
		23419,
		22,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420001] = {
		23420001,
		0,
		Lang.get(59734),
		23420,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		164,
		23500,
		[19] = 23500,
		[17] = 1
	},
	[23420002] = {
		23420002,
		0,
		Lang.get(59735),
		23420,
		2,
		257,
		nil,
		1
	},
	[23420003] = {
		23420003,
		0,
		Lang.get(59736),
		23420,
		3,
		257,
		nil,
		1
	},
	[23420004] = {
		23420004,
		0,
		Lang.get(59737),
		23420,
		4,
		257,
		nil,
		1
	},
	[23420005] = {
		23420005,
		0,
		Lang.get(59738),
		23420,
		5,
		300
	},
	[23420006] = {
		23420006,
		0,
		Lang.get(59739),
		23420,
		6,
		257,
		nil,
		1
	},
	[23420007] = {
		23420007,
		0,
		Lang.get(59740),
		23420,
		7,
		300
	},
	[23420008] = {
		23420008,
		0,
		Lang.get(59741),
		23420,
		8,
		257,
		nil,
		1
	},
	[23420009] = {
		23420009,
		0,
		Lang.get(59742),
		23420,
		9,
		300
	},
	[23420010] = {
		23420010,
		0,
		Lang.get(59743),
		23420,
		10,
		257,
		nil,
		1
	},
	[23420011] = {
		23420011,
		0,
		Lang.get(59744),
		23420,
		11,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23420012] = {
		23420012,
		4,
		nil,
		23420,
		12,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23420013,
				branch_content = Lang.get(59745)
			}
		}
	},
	[23420013] = {
		23420013,
		0,
		Lang.get(59746),
		23420,
		13,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420014] = {
		23420014,
		0,
		Lang.get(59747),
		23420,
		14,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23420015] = {
		23420015,
		0,
		Lang.get(59748),
		23420,
		15,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420016] = {
		23420016,
		0,
		Lang.get(59749),
		23420,
		16,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420017] = {
		23420017,
		0,
		Lang.get(59750),
		23420,
		17,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420018] = {
		23420018,
		4,
		nil,
		23420,
		18,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23420019,
				branch_content = Lang.get(59751)
			}
		}
	},
	[23420019] = {
		23420019,
		0,
		Lang.get(59752),
		23420,
		19,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420020] = {
		23420020,
		0,
		Lang.get(59753),
		23420,
		20,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420021] = {
		23420021,
		0,
		Lang.get(59754),
		23420,
		21,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420022] = {
		23420022,
		4,
		nil,
		23420,
		22,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23420023,
				branch_content = Lang.get(59755)
			}
		}
	},
	[23420023] = {
		23420023,
		0,
		Lang.get(59756),
		23420,
		23,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420024] = {
		23420024,
		0,
		Lang.get(59757),
		23420,
		24,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420025] = {
		23420025,
		0,
		Lang.get(59758),
		23420,
		25,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420026] = {
		23420026,
		0,
		Lang.get(59759),
		23420,
		26,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420027] = {
		23420027,
		0,
		Lang.get(59760),
		23420,
		27,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420028] = {
		23420028,
		4,
		nil,
		23420,
		28,
		257,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 23420029,
				branch_content = Lang.get(59761)
			}
		}
	},
	[23420029] = {
		23420029,
		0,
		Lang.get(59762),
		23420,
		29,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420030] = {
		23420030,
		0,
		Lang.get(59763),
		23420,
		30,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420031] = {
		23420031,
		0,
		Lang.get(59764),
		23420,
		31,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23420032] = {
		23420032,
		0,
		Lang.get(59765),
		23420,
		32,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23420033] = {
		23420033,
		0,
		"「|103|」|101|。",
		23420,
		33,
		257,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[23420034] = {
		23420034,
		0,
		Lang.get(59766),
		23420,
		34,
		257,
		nil,
		1
	},
	[23420035] = {
		23420035,
		5,
		Lang.get(59767),
		23420,
		35,
		263,
		nil,
		1
	},
	[23420036] = {
		23420036,
		0,
		Lang.get(59768),
		23420,
		36,
		300
	},
	[23421001] = {
		23421001,
		0,
		Lang.get(59769),
		23421,
		1,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		164,
		23505,
		nil,
		nil,
		nil,
		1,
		nil,
		23505
	},
	[23421002] = {
		23421002,
		0,
		Lang.get(59770),
		23421,
		2,
		107,
		nil,
		1,
		10
	},
	[23421003] = {
		23421003,
		0,
		Lang.get(59771),
		23421,
		3,
		134,
		nil,
		1,
		4
	},
	[23421004] = {
		23421004,
		0,
		Lang.get(59772),
		23421,
		4,
		134,
		nil,
		1,
		4
	},
	[23421005] = {
		23421005,
		0,
		Lang.get(59773),
		23421,
		5,
		300
	},
	[23421006] = {
		23421006,
		0,
		Lang.get(59774),
		23421,
		6,
		257,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		23506,
		nil,
		nil,
		nil,
		1,
		nil,
		23506
	},
	[23421007] = {
		23421007,
		0,
		Lang.get(59775),
		23421,
		7,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23421008] = {
		23421008,
		0,
		Lang.get(59776),
		23421,
		8,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421009] = {
		23421009,
		0,
		Lang.get(59777),
		23421,
		9,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421010] = {
		23421010,
		0,
		Lang.get(59778),
		23421,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23421011] = {
		23421011,
		0,
		Lang.get(59779),
		23421,
		11,
		107,
		{
			RTResTalkAction[54],
			RTResTalkAction[2]
		}
	},
	[23421012] = {
		23421012,
		0,
		Lang.get(59780),
		23421,
		12,
		134,
		{
			RTResTalkAction[40],
			RTResTalkAction[55]
		}
	},
	[23421013] = {
		23421013,
		0,
		Lang.get(59781),
		23421,
		13,
		263,
		{
			RTResTalkAction[43],
			RTResTalkAction[44]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23507,
		nil,
		1,
		nil,
		1,
		nil,
		23507
	},
	[23421014] = {
		23421014,
		0,
		Lang.get(59782),
		23421,
		14,
		263,
		nil,
		1
	},
	[23421015] = {
		23421015,
		0,
		Lang.get(59783),
		23421,
		15,
		257,
		nil,
		1
	},
	[23421016] = {
		23421016,
		5,
		Lang.get(59784),
		23421,
		16,
		264,
		nil,
		1
	},
	[23421017] = {
		23421017,
		0,
		Lang.get(59785),
		23421,
		17,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23421018] = {
		23421018,
		0,
		Lang.get(59786),
		23421,
		18,
		261,
		{
			RTResTalkAction[22],
			RTResTalkAction[2]
		}
	},
	[23421019] = {
		23421019,
		0,
		Lang.get(59787),
		23421,
		19,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[23]
		}
	},
	[23421020] = {
		23421020,
		0,
		Lang.get(59788),
		23421,
		20,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421021] = {
		23421021,
		0,
		Lang.get(59789),
		23421,
		21,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421022] = {
		23421022,
		0,
		Lang.get(59790),
		23421,
		22,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421023] = {
		23421023,
		0,
		Lang.get(59791),
		23421,
		23,
		257,
		{
			RTResTalkAction[1]
		}
	},
	[23421024] = {
		23421024,
		0,
		Lang.get(59792),
		23421,
		24,
		257,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		23508,
		nil,
		1,
		nil,
		1,
		nil,
		23508
	},
	[23421025] = {
		23421025,
		0,
		Lang.get(59793),
		23421,
		25,
		257,
		nil,
		1
	},
	[23421026] = {
		23421026,
		0,
		Lang.get(59794),
		23421,
		26,
		257,
		nil,
		1
	},
	[23421027] = {
		23421027,
		0,
		Lang.get(59795),
		23421,
		27,
		257,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[23421028] = {
		23421028,
		0,
		Lang.get(59796),
		23421,
		28,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23421029] = {
		23421029,
		0,
		Lang.get(59797),
		23421,
		29,
		257,
		{
			RTResTalkAction[1]
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
