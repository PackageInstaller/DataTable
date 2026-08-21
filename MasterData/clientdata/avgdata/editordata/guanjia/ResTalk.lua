-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\guanjia\\ResTalk.lua

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
	[2] = 376
}
RTResTalkAction[2] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 376
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[7] = {
	1,
	107,
	nil,
	nil,
	11
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[9] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[10] = {
	1,
	1269,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1269
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1269
}
RTResTalkAction[13] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 107
}
RTResTalkAction[15] = {
	3,
	1269,
	nil,
	nil,
	2
}
RTResTalkAction[16] = {
	[1] = 3,
	[2] = 1269
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1270
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1270
}
RTResTalkAction[19] = {
	[1] = 2,
	[2] = 1270
}
RTResTalkAction[20] = {
	3,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[21] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[22] = {
	3,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[23] = {
	1,
	1269,
	nil,
	nil,
	2
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 842
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 842
}
RTResTalkAction[26] = {
	[1] = 3,
	[2] = 842
}
RTResTalkAction[27] = {
	1,
	1269,
	nil,
	nil,
	0
}
RTResTalkAction[28] = {
	[1] = 2,
	[2] = 1269
}
RTResTalkAction[29] = {
	1,
	856,
	nil,
	nil,
	2
}
RTResTalkAction[30] = {
	1,
	856,
	nil,
	nil,
	1
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 856
}
RTResTalkAction[32] = {
	1,
	856,
	nil,
	nil,
	0
}
RTResTalkAction[33] = {
	1,
	856,
	nil,
	nil,
	4
}
RTResTalkAction[34] = {
	[1] = 1,
	[2] = 258
}
RTResTalkAction[35] = {
	[1] = 0,
	[2] = 258
}
RTResTalkAction[36] = {
	[1] = 1,
	[2] = 857
}
RTResTalkAction[37] = {
	[1] = 0,
	[2] = 857
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[39] = {
	2,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[40] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[41] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 845
}
RTResTalkAction[43] = {
	[1] = 0,
	[2] = 845
}
RTResTalkAction[44] = {
	1,
	107,
	{
		1
	},
	nil,
	10
}
RTResTalkAction[45] = {
	3,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[46] = {
	2,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[47] = {
	1,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[48] = {
	3,
	141,
	nil,
	nil,
	3
}
RTResTalkAction[49] = {
	1,
	107,
	{
		2
	},
	nil,
	10
}
RTResTalkAction[50] = {
	1,
	141,
	nil,
	nil,
	2
}
RTResTalkAction[51] = {
	2,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 846
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 846
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 1269,
	[3] = {
		1
	}
}
RTResTalkAction[55] = {
	[1] = 0,
	[2] = 856
}
RTResTalkAction[56] = {
	1,
	856,
	nil,
	nil,
	3
}
RTResTalkAction[57] = {
	[1] = 2,
	[2] = 856
}
RTResTalkAction[58] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[59] = {
	2,
	856,
	nil,
	nil,
	3
}
RTResTalkAction[60] = {
	2,
	856,
	nil,
	nil,
	4
}
RTResTalkAction[61] = {
	2,
	856,
	nil,
	nil,
	1
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[64] = {
	1,
	257,
	nil,
	nil,
	1
}
RTResTalkAction[65] = {
	1,
	257,
	nil,
	nil,
	0
}
RTResTalkAction[66] = {
	2,
	257,
	nil,
	nil,
	1
}
RTResTalkAction[67] = {
	[1] = 3,
	[2] = 856
}
RTResTalkAction[68] = {
	[1] = 2,
	[2] = 257
}
RTResTalkAction[69] = {
	3,
	856,
	nil,
	nil,
	1
}
RTResTalkAction[70] = {
	3,
	856,
	nil,
	nil,
	3
}
RTResTalkAction[71] = {
	3,
	856,
	nil,
	nil,
	4
}
RTResTalkAction[72] = {
	3,
	856,
	nil,
	nil,
	2
}
RTResTalkAction[73] = {
	[1] = 1,
	[2] = 851
}
RTResTalkAction[74] = {
	[1] = 2,
	[2] = 850
}
RTResTalkAction[75] = {
	[1] = 3,
	[2] = 851
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 850
}
RTResTalkAction[77] = {
	[1] = 0,
	[2] = 851
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 850
}
RTResTalkAction[79] = {
	3,
	1269,
	nil,
	nil,
	1
}
RTResTalkAction[80] = {
	3,
	1269,
	nil,
	nil,
	3
}
RTResTalkAction[81] = {
	[1] = 1
}
RTResTalkAction[82] = {
	[1] = 0
}

local Data = {
	[39401001] = {
		39401001,
		0,
		Lang.get(104856),
		39401,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		207,
		nil,
		nil,
		1,
		[20] = 255
	},
	[39401002] = {
		39401002,
		0,
		Lang.get(104857),
		39401,
		2,
		605
	},
	[39401003] = {
		39401003,
		0,
		Lang.get(104858),
		39401,
		3,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		39401,
		nil,
		1,
		nil,
		1,
		nil,
		39401,
		-1
	},
	[39401004] = {
		39401004,
		0,
		Lang.get(104859),
		39401,
		4,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		nil,
		3,
		[27] = 2
	},
	[39401005] = {
		39401005,
		13,
		Lang.get(104860),
		39401,
		5,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		10,
		[27] = 3
	},
	[39401006] = {
		39401006,
		13,
		Lang.get(104861),
		39401,
		6,
		858,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		[27] = 3
	},
	[39401007] = {
		39401007,
		13,
		Lang.get(104862),
		39401,
		7,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		8,
		[27] = 3
	},
	[39401008] = {
		39401008,
		13,
		Lang.get(104863),
		39401,
		8,
		858,
		{
			RTResTalkAction[1]
		},
		[27] = 3
	},
	[39401009] = {
		39401009,
		0,
		Lang.get(104864),
		39401,
		9,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[39401010] = {
		39401010,
		2,
		Lang.get(104865),
		39401,
		10,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[39401011] = {
		39401011,
		2,
		Lang.get(104866),
		39401,
		11,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[39401012] = {
		39401012,
		2,
		Lang.get(104867),
		39401,
		12,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[39401013] = {
		39401013,
		0,
		Lang.get(104868),
		39401,
		13,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[39401014] = {
		39401014,
		0,
		Lang.get(104869),
		39401,
		14,
		107,
		{
			RTResTalkAction[6]
		},
		1,
		8,
		nil,
		nil,
		nil,
		39402,
		nil,
		1,
		nil,
		1,
		nil,
		39402
	},
	[39401015] = {
		39401015,
		0,
		Lang.get(104870),
		39401,
		15,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[39401016] = {
		39401016,
		0,
		Lang.get(104871),
		39401,
		16,
		840,
		{
			RTResTalkAction[6]
		},
		1,
		1
	},
	[39401017] = {
		39401017,
		0,
		Lang.get(104872),
		39401,
		17,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[39401018] = {
		39401018,
		2,
		Lang.get(104873),
		39401,
		18,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[39401019] = {
		39401019,
		0,
		Lang.get(104874),
		39401,
		19,
		107,
		{
			RTResTalkAction[9]
		}
	},
	[39401020] = {
		39401020,
		0,
		Lang.get(104875),
		39401,
		20,
		1269,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		}
	},
	[39401021] = {
		39401021,
		0,
		Lang.get(104876),
		39401,
		21,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39401022] = {
		39401022,
		0,
		Lang.get(104877),
		39401,
		22,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39401023] = {
		39401023,
		7,
		"116",
		39401,
		23,
		1269,
		{
			RTResTalkAction[12]
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
	[39401024] = {
		39401024,
		0,
		Lang.get(104878),
		39401,
		24,
		1269,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[39401025] = {
		39401025,
		0,
		Lang.get(104879),
		39401,
		25,
		107,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[39401026] = {
		39401026,
		0,
		Lang.get(104880),
		39401,
		26,
		1269,
		{
			RTResTalkAction[10],
			RTResTalkAction[6]
		}
	},
	[39401027] = {
		39401027,
		0,
		Lang.get(104881),
		39401,
		27,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		[19] = 39403,
		[17] = 1
	},
	[39401028] = {
		39401028,
		0,
		Lang.get(104882),
		39401,
		28,
		1269,
		nil,
		1,
		1
	},
	[39401029] = {
		39401029,
		0,
		Lang.get(104883),
		39401,
		29,
		1269,
		nil,
		1,
		1
	},
	[39401030] = {
		39401030,
		0,
		Lang.get(104884),
		39401,
		30,
		1269,
		nil,
		1,
		1
	},
	[39401031] = {
		39401031,
		0,
		Lang.get(104885),
		39401,
		31,
		107,
		nil,
		1,
		6
	},
	[39401032] = {
		39401032,
		0,
		Lang.get(104886),
		39401,
		32,
		107,
		nil,
		1,
		5
	},
	[39402001] = {
		39402001,
		0,
		Lang.get(104887),
		39402,
		1,
		107,
		nil,
		1,
		8,
		nil,
		nil,
		62,
		39404,
		nil,
		1,
		nil,
		1,
		nil,
		39404
	},
	[39402002] = {
		39402002,
		0,
		Lang.get(104888),
		39402,
		2,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		0,
		3
	},
	[39402003] = {
		39402003,
		0,
		Lang.get(104889),
		39402,
		3,
		1269,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[39402004] = {
		39402004,
		0,
		Lang.get(104890),
		39402,
		4,
		1269,
		{
			RTResTalkAction[14],
			RTResTalkAction[16]
		}
	},
	[39402005] = {
		39402005,
		0,
		Lang.get(104891),
		39402,
		5,
		1270,
		{
			RTResTalkAction[17],
			RTResTalkAction[6],
			RTResTalkAction[12]
		}
	},
	[39402006] = {
		39402006,
		0,
		Lang.get(104892),
		39402,
		6,
		1270,
		{
			RTResTalkAction[17]
		}
	},
	[39402007] = {
		39402007,
		0,
		Lang.get(104893),
		39402,
		7,
		107,
		{
			RTResTalkAction[18]
		},
		1,
		5,
		nil,
		nil,
		nil,
		39405,
		nil,
		1,
		nil,
		1,
		nil,
		39405
	},
	[39402008] = {
		39402008,
		0,
		Lang.get(104894),
		39402,
		8,
		1270,
		{
			RTResTalkAction[17]
		},
		nil,
		0,
		3
	},
	[39402009] = {
		39402009,
		0,
		Lang.get(104895),
		39402,
		9,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[39402010] = {
		39402010,
		0,
		Lang.get(104896),
		39402,
		10,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[21]
		}
	},
	[39402011] = {
		39402011,
		0,
		Lang.get(104897),
		39402,
		11,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[22]
		}
	},
	[39402012] = {
		39402012,
		0,
		Lang.get(104898),
		39402,
		12,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[21]
		}
	},
	[39402013] = {
		39402013,
		0,
		Lang.get(104899),
		39402,
		13,
		1270,
		{
			RTResTalkAction[17],
			RTResTalkAction[6]
		}
	},
	[39402014] = {
		39402014,
		0,
		Lang.get(104900),
		39402,
		14,
		1269,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39402015] = {
		39402015,
		0,
		Lang.get(104901),
		39402,
		15,
		107,
		{
			RTResTalkAction[18],
			RTResTalkAction[12]
		},
		1,
		5,
		nil,
		nil,
		nil,
		39406,
		nil,
		1,
		nil,
		1,
		nil,
		39406
	},
	[39402016] = {
		39402016,
		0,
		Lang.get(104902),
		39402,
		16,
		107,
		{
			RTResTalkAction[9]
		},
		nil,
		0,
		3
	},
	[39402017] = {
		39402017,
		0,
		Lang.get(104903),
		39402,
		17,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[39402018] = {
		39402018,
		0,
		Lang.get(104904),
		39402,
		18,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[21]
		}
	},
	[39402019] = {
		39402019,
		0,
		Lang.get(104905),
		39402,
		19,
		841,
		{
			RTResTalkAction[18],
			RTResTalkAction[6]
		},
		1
	},
	[39402020] = {
		39402020,
		0,
		Lang.get(104906),
		39402,
		20,
		1270,
		{
			RTResTalkAction[17]
		}
	},
	[39402021] = {
		39402021,
		0,
		Lang.get(104907),
		39402,
		21,
		841,
		{
			RTResTalkAction[18]
		},
		1
	},
	[39402022] = {
		39402022,
		0,
		Lang.get(104908),
		39402,
		22,
		1270,
		{
			RTResTalkAction[17]
		}
	},
	[39402023] = {
		39402023,
		0,
		Lang.get(104909),
		39402,
		23,
		841,
		{
			RTResTalkAction[17]
		},
		1
	},
	[39402024] = {
		39402024,
		0,
		Lang.get(104910),
		39402,
		24,
		1269,
		{
			RTResTalkAction[23],
			RTResTalkAction[18]
		}
	},
	[39403001] = {
		39403001,
		0,
		Lang.get(104911),
		39403,
		1,
		1270,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		39407,
		nil,
		1,
		nil,
		1,
		nil,
		39407
	},
	[39403002] = {
		39403002,
		0,
		Lang.get(104912),
		39403,
		2,
		1270,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[39403003] = {
		39403003,
		0,
		Lang.get(104913),
		39403,
		3,
		1269,
		{
			RTResTalkAction[19],
			RTResTalkAction[15]
		}
	},
	[39403004] = {
		39403004,
		0,
		Lang.get(104914),
		39403,
		4,
		842,
		{
			RTResTalkAction[24],
			RTResTalkAction[18],
			RTResTalkAction[12]
		}
	},
	[39403005] = {
		39403005,
		0,
		Lang.get(104915),
		39403,
		5,
		1270,
		{
			RTResTalkAction[17],
			RTResTalkAction[25]
		}
	},
	[39403006] = {
		39403006,
		0,
		Lang.get(104916),
		39403,
		6,
		1270,
		{
			RTResTalkAction[17]
		}
	},
	[39403007] = {
		39403007,
		0,
		Lang.get(104917),
		39403,
		7,
		842,
		{
			RTResTalkAction[19],
			RTResTalkAction[26]
		}
	},
	[39403008] = {
		39403008,
		0,
		Lang.get(104918),
		39403,
		8,
		842,
		{
			RTResTalkAction[19],
			RTResTalkAction[26]
		}
	},
	[39403009] = {
		39403009,
		0,
		Lang.get(104919),
		39403,
		9,
		1269,
		{
			RTResTalkAction[18],
			RTResTalkAction[25]
		},
		1,
		0,
		nil,
		nil,
		nil,
		39408,
		nil,
		1,
		nil,
		1,
		nil,
		39408
	},
	[39403010] = {
		39403010,
		0,
		Lang.get(104920),
		39403,
		10,
		1270,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[39403011] = {
		39403011,
		0,
		Lang.get(104921),
		39403,
		11,
		1269,
		{
			RTResTalkAction[19],
			RTResTalkAction[15]
		}
	},
	[39403012] = {
		39403012,
		0,
		Lang.get(104922),
		39403,
		12,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39403013] = {
		39403013,
		0,
		Lang.get(104923),
		39403,
		13,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39403014] = {
		39403014,
		0,
		Lang.get(104924),
		39403,
		14,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39403015] = {
		39403015,
		0,
		Lang.get(104925),
		39403,
		15,
		1270,
		{
			RTResTalkAction[19],
			RTResTalkAction[16]
		}
	},
	[39403016] = {
		39403016,
		0,
		Lang.get(104926),
		39403,
		16,
		1269,
		{
			RTResTalkAction[27],
			RTResTalkAction[18]
		}
	},
	[39403017] = {
		39403017,
		0,
		Lang.get(104927),
		39403,
		17,
		842,
		{
			RTResTalkAction[24],
			RTResTalkAction[12]
		}
	},
	[39403018] = {
		39403018,
		0,
		Lang.get(104928),
		39403,
		18,
		1269,
		{
			RTResTalkAction[23],
			RTResTalkAction[25]
		}
	},
	[39403019] = {
		39403019,
		0,
		Lang.get(104929),
		39403,
		19,
		1270,
		{
			RTResTalkAction[17],
			RTResTalkAction[12]
		}
	},
	[39403020] = {
		39403020,
		0,
		Lang.get(104930),
		39403,
		20,
		843,
		{
			RTResTalkAction[18]
		},
		1
	},
	[39403021] = {
		39403021,
		0,
		Lang.get(104931),
		39403,
		21,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[39404001] = {
		39404001,
		0,
		Lang.get(104932),
		39404,
		1,
		1269,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		39409,
		nil,
		1,
		nil,
		1,
		nil,
		39409
	},
	[39404002] = {
		39404002,
		0,
		Lang.get(104933),
		39404,
		2,
		1269,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[39404003] = {
		39404003,
		0,
		Lang.get(104934),
		39404,
		3,
		842,
		{
			RTResTalkAction[28],
			RTResTalkAction[26]
		}
	},
	[39404004] = {
		39404004,
		0,
		Lang.get(104935),
		39404,
		4,
		842,
		{
			RTResTalkAction[28],
			RTResTalkAction[26]
		}
	},
	[39404005] = {
		39404005,
		0,
		Lang.get(104936),
		39404,
		5,
		1269,
		{
			RTResTalkAction[28],
			RTResTalkAction[26]
		}
	},
	[39404006] = {
		39404006,
		0,
		Lang.get(104937),
		39404,
		6,
		1269,
		{
			RTResTalkAction[28],
			RTResTalkAction[26]
		}
	},
	[39404007] = {
		39404007,
		0,
		Lang.get(104938),
		39404,
		7,
		842,
		{
			RTResTalkAction[24],
			RTResTalkAction[12]
		}
	},
	[39404008] = {
		39404008,
		0,
		Lang.get(104939),
		39404,
		8,
		605,
		{
			RTResTalkAction[25]
		}
	},
	[39404009] = {
		39404009,
		0,
		Lang.get(104940),
		39404,
		9,
		842,
		{
			RTResTalkAction[24]
		}
	},
	[39404010] = {
		39404010,
		0,
		Lang.get(104941),
		39404,
		10,
		842,
		{
			RTResTalkAction[24]
		}
	},
	[39404011] = {
		39404011,
		0,
		Lang.get(104942),
		39404,
		11,
		856,
		{
			RTResTalkAction[25]
		},
		1,
		2
	},
	[39404012] = {
		39404012,
		0,
		Lang.get(104943),
		39404,
		12,
		844,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		39410,
		nil,
		1,
		nil,
		1,
		nil,
		39410
	},
	[39404013] = {
		39404013,
		0,
		Lang.get(104944),
		39404,
		13,
		844,
		nil,
		1,
		nil,
		3
	},
	[39404014] = {
		39404014,
		0,
		Lang.get(104945),
		39404,
		14,
		844,
		nil,
		1
	},
	[39404015] = {
		39404015,
		0,
		Lang.get(104946),
		39404,
		15,
		856,
		{
			RTResTalkAction[29]
		}
	},
	[39404016] = {
		39404016,
		0,
		Lang.get(104947),
		39404,
		16,
		856,
		{
			RTResTalkAction[30]
		}
	},
	[39404017] = {
		39404017,
		0,
		Lang.get(104948),
		39404,
		17,
		856,
		{
			RTResTalkAction[31]
		}
	},
	[39404018] = {
		39404018,
		0,
		Lang.get(104949),
		39404,
		18,
		856,
		{
			RTResTalkAction[32]
		}
	},
	[39404019] = {
		39404019,
		0,
		Lang.get(104950),
		39404,
		19,
		844,
		{
			RTResTalkAction[31]
		},
		1
	},
	[39404020] = {
		39404020,
		0,
		Lang.get(104951),
		39404,
		20,
		856,
		{
			RTResTalkAction[33]
		}
	},
	[39404021] = {
		39404021,
		0,
		Lang.get(104952),
		39404,
		21,
		856,
		{
			RTResTalkAction[31]
		}
	},
	[39404022] = {
		39404022,
		0,
		Lang.get(104953),
		39404,
		22,
		844,
		{
			RTResTalkAction[31]
		},
		1
	},
	[39404023] = {
		39404023,
		0,
		Lang.get(104954),
		39404,
		23,
		856,
		{
			RTResTalkAction[30]
		}
	},
	[39404024] = {
		39404024,
		0,
		Lang.get(104955),
		39404,
		24,
		856,
		{
			RTResTalkAction[32]
		}
	},
	[39405001] = {
		39405001,
		0,
		Lang.get(104956),
		39405,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		39411,
		nil,
		1,
		nil,
		1,
		nil,
		39411
	},
	[39405002] = {
		39405002,
		0,
		Lang.get(104957),
		39405,
		2,
		258,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[39405003] = {
		39405003,
		0,
		Lang.get(104958),
		39405,
		3,
		258,
		{
			RTResTalkAction[34]
		}
	},
	[39405004] = {
		39405004,
		0,
		Lang.get(104959),
		39405,
		4,
		258,
		{
			RTResTalkAction[34]
		}
	},
	[39405005] = {
		39405005,
		0,
		Lang.get(104960),
		39405,
		5,
		847,
		{
			RTResTalkAction[35]
		}
	},
	[39405006] = {
		39405006,
		0,
		Lang.get(104961),
		39405,
		6,
		848
	},
	[39405007] = {
		39405007,
		0,
		Lang.get(104962),
		39405,
		7,
		848
	},
	[39405008] = {
		39405008,
		0,
		Lang.get(104963),
		39405,
		8,
		847
	},
	[39405009] = {
		39405009,
		0,
		Lang.get(104964),
		39405,
		9,
		848
	},
	[39405010] = {
		39405010,
		0,
		Lang.get(104965),
		39405,
		10,
		847
	},
	[39405011] = {
		39405011,
		0,
		Lang.get(104966),
		39405,
		11,
		848
	},
	[39405012] = {
		39405012,
		0,
		Lang.get(104967),
		39405,
		12,
		848
	},
	[39405013] = {
		39405013,
		0,
		Lang.get(104968),
		39405,
		13,
		258,
		{
			RTResTalkAction[34]
		}
	},
	[39405014] = {
		39405014,
		0,
		Lang.get(104969),
		39405,
		14,
		848,
		{
			RTResTalkAction[35]
		}
	},
	[39405015] = {
		39405015,
		0,
		Lang.get(104970),
		39405,
		15,
		258,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		39412,
		nil,
		1,
		nil,
		1,
		nil,
		39412
	},
	[39405016] = {
		39405016,
		0,
		Lang.get(104971),
		39405,
		16,
		258,
		{
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[39405017] = {
		39405017,
		0,
		Lang.get(104972),
		39405,
		17,
		848,
		{
			RTResTalkAction[35]
		}
	},
	[39405018] = {
		39405018,
		0,
		Lang.get(104973),
		39405,
		18,
		848
	},
	[39405019] = {
		39405019,
		0,
		Lang.get(104974),
		39405,
		19,
		848
	},
	[39405020] = {
		39405020,
		0,
		Lang.get(104975),
		39405,
		20,
		258,
		{
			RTResTalkAction[34]
		}
	},
	[39405021] = {
		39405021,
		0,
		Lang.get(104976),
		39405,
		21,
		848,
		{
			RTResTalkAction[35]
		}
	},
	[39405022] = {
		39405022,
		0,
		Lang.get(104977),
		39405,
		22,
		848
	},
	[39405023] = {
		39405023,
		0,
		Lang.get(104978),
		39405,
		23,
		847
	},
	[39405024] = {
		39405024,
		2,
		Lang.get(104979),
		39405,
		24,
		258,
		{
			RTResTalkAction[34]
		}
	},
	[39406001] = {
		39406001,
		0,
		Lang.get(104980),
		39406,
		1,
		107,
		nil,
		1,
		6,
		nil,
		nil,
		63,
		39413,
		nil,
		1,
		nil,
		1,
		nil,
		39413
	},
	[39406002] = {
		39406002,
		0,
		Lang.get(104981),
		39406,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		0,
		3,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
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
	[39406003] = {
		39406003,
		13,
		Lang.get(104982),
		39406,
		3,
		857,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		},
		nil,
		0,
		[27] = 3
	},
	[39406004] = {
		39406004,
		0,
		Lang.get(104983),
		39406,
		4,
		107,
		{
			RTResTalkAction[36]
		},
		1,
		7,
		[27] = 3
	},
	[39406005] = {
		39406005,
		13,
		Lang.get(104984),
		39406,
		5,
		857,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		[27] = 3
	},
	[39406006] = {
		39406006,
		13,
		Lang.get(104985),
		39406,
		6,
		857,
		{
			RTResTalkAction[36]
		},
		[27] = 3
	},
	[39406007] = {
		39406007,
		0,
		Lang.get(104986),
		39406,
		7,
		107,
		{
			RTResTalkAction[36]
		},
		1,
		8,
		[27] = 3
	},
	[39406008] = {
		39406008,
		13,
		Lang.get(104987),
		39406,
		8,
		857,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		[27] = 3
	},
	[39406009] = {
		39406009,
		0,
		Lang.get(104988),
		39406,
		9,
		107,
		{
			RTResTalkAction[36]
		},
		1,
		10,
		[27] = 3
	},
	[39406010] = {
		39406010,
		13,
		Lang.get(104989),
		39406,
		10,
		857,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		[27] = 3
	},
	[39406011] = {
		39406011,
		0,
		Lang.get(104990),
		39406,
		11,
		107,
		{
			RTResTalkAction[36]
		},
		1,
		8,
		[27] = 3
	},
	[39406012] = {
		39406012,
		13,
		Lang.get(104991),
		39406,
		12,
		857,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		[27] = 3
	},
	[39406013] = {
		39406013,
		0,
		Lang.get(104992),
		39406,
		13,
		605,
		{
			RTResTalkAction[37]
		}
	},
	[39406014] = {
		39406014,
		0,
		Lang.get(104993),
		39406,
		14,
		141,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		39414,
		nil,
		1,
		nil,
		1,
		nil,
		39414
	},
	[39406015] = {
		39406015,
		0,
		Lang.get(104994),
		39406,
		15,
		141,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[39406016] = {
		39406016,
		0,
		Lang.get(104995),
		39406,
		16,
		141,
		{
			RTResTalkAction[38]
		}
	},
	[39406017] = {
		39406017,
		0,
		Lang.get(104996),
		39406,
		17,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[40]
		}
	},
	[39406018] = {
		39406018,
		0,
		Lang.get(104997),
		39406,
		18,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[41]
		}
	},
	[39406019] = {
		39406019,
		0,
		Lang.get(104998),
		39406,
		19,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39415,
		nil,
		1,
		[19] = 39415,
		[17] = 1
	},
	[39406020] = {
		39406020,
		0,
		Lang.get(104999),
		39406,
		20,
		141,
		nil,
		1,
		2,
		3
	},
	[39407001] = {
		39407001,
		0,
		Lang.get(105000),
		39407,
		1,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		63,
		39416,
		nil,
		1,
		nil,
		1,
		nil,
		39416
	},
	[39407002] = {
		39407002,
		0,
		Lang.get(105001),
		39407,
		2,
		107,
		nil,
		1,
		nil,
		3
	},
	[39407003] = {
		39407003,
		0,
		Lang.get(105002),
		39407,
		3,
		141,
		nil,
		1,
		2
	},
	[39407004] = {
		39407004,
		0,
		Lang.get(105003),
		39407,
		4,
		845,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		39417,
		nil,
		1,
		nil,
		1,
		nil,
		39417
	},
	[39407005] = {
		39407005,
		0,
		Lang.get(105004),
		39407,
		5,
		1269,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[39407006] = {
		39407006,
		0,
		Lang.get(105005),
		39407,
		6,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39407007] = {
		39407007,
		0,
		Lang.get(105006),
		39407,
		7,
		845,
		{
			RTResTalkAction[28],
			RTResTalkAction[42]
		}
	},
	[39407008] = {
		39407008,
		0,
		Lang.get(105007),
		39407,
		8,
		845,
		{
			RTResTalkAction[28],
			RTResTalkAction[42]
		}
	},
	[39407009] = {
		39407009,
		0,
		Lang.get(105008),
		39407,
		9,
		1269,
		{
			RTResTalkAction[11],
			RTResTalkAction[43]
		}
	},
	[39407010] = {
		39407010,
		2,
		Lang.get(105009),
		39407,
		10,
		107,
		{
			RTResTalkAction[44],
			RTResTalkAction[12]
		}
	},
	[39407011] = {
		39407011,
		0,
		Lang.get(105010),
		39407,
		11,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39418,
		nil,
		1,
		[19] = 39418,
		[17] = 1
	},
	[39407012] = {
		39407012,
		0,
		Lang.get(105011),
		39407,
		12,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[39407013] = {
		39407013,
		0,
		Lang.get(105012),
		39407,
		13,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[45]
		}
	},
	[39407014] = {
		39407014,
		0,
		Lang.get(105013),
		39407,
		14,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39407015] = {
		39407015,
		0,
		Lang.get(105014),
		39407,
		15,
		107,
		{
			RTResTalkAction[46],
			RTResTalkAction[40]
		}
	},
	[39407016] = {
		39407016,
		0,
		Lang.get(105015),
		39407,
		16,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39407017] = {
		39407017,
		0,
		Lang.get(105675),
		39407,
		17,
		141,
		{
			RTResTalkAction[38],
			RTResTalkAction[6]
		}
	},
	[39407018] = {
		39407018,
		0,
		Lang.get(105017),
		39407,
		18,
		141,
		{
			RTResTalkAction[47]
		}
	},
	[39408001] = {
		39408001,
		0,
		Lang.get(105018),
		39408,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		39419,
		nil,
		1,
		nil,
		1,
		nil,
		39419
	},
	[39408002] = {
		39408002,
		0,
		Lang.get(105019),
		39408,
		2,
		107,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[39408003] = {
		39408003,
		0,
		Lang.get(105020),
		39408,
		3,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[48]
		}
	},
	[39408004] = {
		39408004,
		2,
		Lang.get(105021),
		39408,
		4,
		1269,
		{
			RTResTalkAction[27],
			RTResTalkAction[6],
			RTResTalkAction[41]
		}
	},
	[39408005] = {
		39408005,
		2,
		Lang.get(105022),
		39408,
		5,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39408006] = {
		39408006,
		2,
		Lang.get(105023),
		39408,
		6,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39408007] = {
		39408007,
		0,
		Lang.get(105024),
		39408,
		7,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39420,
		nil,
		1,
		[19] = 39420,
		[17] = 1
	},
	[39408008] = {
		39408008,
		0,
		Lang.get(105025),
		39408,
		8,
		107,
		{
			RTResTalkAction[49]
		},
		nil,
		nil,
		3
	},
	[39408009] = {
		39408009,
		0,
		Lang.get(105026),
		39408,
		9,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[45]
		}
	},
	[39408010] = {
		39408010,
		0,
		Lang.get(105027),
		39408,
		10,
		141,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39408011] = {
		39408011,
		0,
		Lang.get(105028),
		39408,
		11,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39408012] = {
		39408012,
		0,
		Lang.get(105029),
		39408,
		12,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39408013] = {
		39408013,
		0,
		Lang.get(105030),
		39408,
		13,
		107,
		{
			RTResTalkAction[14],
			RTResTalkAction[40]
		}
	},
	[39408014] = {
		39408014,
		0,
		Lang.get(105031),
		39408,
		14,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[41]
		}
	},
	[39408015] = {
		39408015,
		0,
		Lang.get(105032),
		39408,
		15,
		605,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39421,
		nil,
		1,
		[19] = 39421,
		[17] = 1
	},
	[39408016] = {
		39408016,
		0,
		Lang.get(105033),
		39408,
		16,
		107,
		nil,
		1,
		10,
		3
	},
	[39408017] = {
		39408017,
		0,
		Lang.get(105034),
		39408,
		17,
		141,
		nil,
		1,
		2
	},
	[39408018] = {
		39408018,
		0,
		Lang.get(105035),
		39408,
		18,
		141,
		nil,
		1,
		3
	},
	[39409001] = {
		39409001,
		0,
		Lang.get(105036),
		39409,
		1,
		107,
		nil,
		1,
		10,
		nil,
		nil,
		63,
		39422,
		nil,
		1,
		nil,
		1,
		nil,
		39422
	},
	[39409002] = {
		39409002,
		0,
		Lang.get(105037),
		39409,
		2,
		141,
		{
			RTResTalkAction[50]
		},
		nil,
		nil,
		3
	},
	[39409003] = {
		39409003,
		0,
		Lang.get(105038),
		39409,
		3,
		107,
		{
			RTResTalkAction[51],
			RTResTalkAction[40]
		}
	},
	[39409004] = {
		39409004,
		0,
		Lang.get(105039),
		39409,
		4,
		605,
		{
			RTResTalkAction[6],
			RTResTalkAction[41]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39423,
		nil,
		1,
		[19] = 39423,
		[17] = 1
	},
	[39409005] = {
		39409005,
		0,
		Lang.get(105040),
		39409,
		5,
		107,
		nil,
		1,
		10,
		3
	},
	[39409006] = {
		39409006,
		0,
		Lang.get(105041),
		39409,
		6,
		141,
		nil,
		1,
		3
	},
	[39409007] = {
		39409007,
		0,
		Lang.get(105042),
		39409,
		7,
		846,
		{
			RTResTalkAction[52]
		}
	},
	[39409008] = {
		39409008,
		0,
		Lang.get(105043),
		39409,
		8,
		1269,
		{
			RTResTalkAction[11],
			RTResTalkAction[53]
		}
	},
	[39409009] = {
		39409009,
		0,
		Lang.get(105044),
		39409,
		9,
		846,
		{
			RTResTalkAction[52],
			RTResTalkAction[12]
		}
	},
	[39409010] = {
		39409010,
		0,
		Lang.get(105045),
		39409,
		10,
		1269,
		{
			RTResTalkAction[11],
			RTResTalkAction[53]
		}
	},
	[39409011] = {
		39409011,
		0,
		Lang.get(105046),
		39409,
		11,
		846,
		{
			RTResTalkAction[52],
			RTResTalkAction[12]
		}
	},
	[39409012] = {
		39409012,
		0,
		Lang.get(105047),
		39409,
		12,
		1269,
		{
			RTResTalkAction[11],
			RTResTalkAction[53]
		}
	},
	[39409013] = {
		39409013,
		0,
		Lang.get(105048),
		39409,
		13,
		846,
		{
			RTResTalkAction[52],
			RTResTalkAction[12]
		}
	},
	[39409014] = {
		39409014,
		0,
		Lang.get(105049),
		39409,
		14,
		846,
		{
			RTResTalkAction[52]
		}
	},
	[39409015] = {
		39409015,
		0,
		Lang.get(105050),
		39409,
		15,
		846,
		{
			RTResTalkAction[52]
		}
	},
	[39409016] = {
		39409016,
		0,
		"？！",
		39409,
		16,
		1269,
		{
			RTResTalkAction[54],
			RTResTalkAction[53]
		}
	},
	[39409017] = {
		39409017,
		0,
		Lang.get(105051),
		39409,
		17,
		1269,
		{
			RTResTalkAction[11]
		}
	},
	[39409018] = {
		39409018,
		0,
		Lang.get(105052),
		39409,
		18,
		856,
		{
			RTResTalkAction[30],
			RTResTalkAction[12]
		}
	},
	[39409019] = {
		39409019,
		2,
		Lang.get(105053),
		39409,
		19,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[55]
		}
	},
	[39409020] = {
		39409020,
		2,
		Lang.get(105054),
		39409,
		20,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[39410001] = {
		39410001,
		0,
		Lang.get(105055),
		39410,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		39424,
		nil,
		1,
		nil,
		1,
		nil,
		39424
	},
	[39410002] = {
		39410002,
		0,
		Lang.get(105056),
		39410,
		2,
		856,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[39410003] = {
		39410003,
		0,
		Lang.get(105057),
		39410,
		3,
		856,
		{
			RTResTalkAction[56]
		}
	},
	[39410004] = {
		39410004,
		0,
		Lang.get(105058),
		39410,
		4,
		856,
		{
			RTResTalkAction[32]
		}
	},
	[39410005] = {
		39410005,
		0,
		Lang.get(105059),
		39410,
		5,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[16]
		}
	},
	[39410006] = {
		39410006,
		0,
		Lang.get(105060),
		39410,
		6,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[16]
		}
	},
	[39410007] = {
		39410007,
		0,
		Lang.get(105061),
		39410,
		7,
		856,
		{
			RTResTalkAction[33],
			RTResTalkAction[12]
		}
	},
	[39410008] = {
		39410008,
		0,
		Lang.get(105062),
		39410,
		8,
		856,
		{
			RTResTalkAction[30]
		}
	},
	[39410009] = {
		39410009,
		2,
		Lang.get(105063),
		39410,
		9,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[55]
		}
	},
	[39410010] = {
		39410010,
		2,
		Lang.get(105064),
		39410,
		10,
		107,
		{
			RTResTalkAction[58]
		}
	},
	[39410011] = {
		39410011,
		0,
		Lang.get(105065),
		39410,
		11,
		856,
		{
			RTResTalkAction[6]
		},
		1,
		1,
		nil,
		nil,
		nil,
		39425,
		nil,
		1,
		nil,
		1,
		nil,
		39425
	},
	[39410012] = {
		39410012,
		0,
		Lang.get(105066),
		39410,
		12,
		1269,
		{
			RTResTalkAction[11]
		},
		nil,
		0,
		3
	},
	[39410013] = {
		39410013,
		0,
		Lang.get(105067),
		39410,
		13,
		856,
		{
			RTResTalkAction[59],
			RTResTalkAction[16]
		}
	},
	[39410014] = {
		39410014,
		0,
		Lang.get(105068),
		39410,
		14,
		856,
		{
			RTResTalkAction[60],
			RTResTalkAction[16]
		}
	},
	[39410015] = {
		39410015,
		0,
		Lang.get(105069),
		39410,
		15,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[16]
		}
	},
	[39410016] = {
		39410016,
		0,
		Lang.get(105070),
		39410,
		16,
		856,
		{
			RTResTalkAction[61],
			RTResTalkAction[16]
		}
	},
	[39410017] = {
		39410017,
		0,
		Lang.get(105071),
		39410,
		17,
		856,
		{
			RTResTalkAction[60],
			RTResTalkAction[16]
		}
	},
	[39410018] = {
		39410018,
		0,
		Lang.get(105072),
		39410,
		18,
		1269,
		{
			RTResTalkAction[57],
			RTResTalkAction[16]
		}
	},
	[39410019] = {
		39410019,
		0,
		Lang.get(105073),
		39410,
		19,
		856,
		{
			RTResTalkAction[33],
			RTResTalkAction[12]
		}
	},
	[39410020] = {
		39410020,
		0,
		Lang.get(105074),
		39410,
		20,
		605,
		{
			RTResTalkAction[55]
		}
	},
	[39410021] = {
		39410021,
		0,
		Lang.get(105075),
		39410,
		21,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		39426,
		nil,
		1,
		[19] = 39426,
		[17] = 1
	},
	[39410022] = {
		39410022,
		0,
		Lang.get(105076),
		39410,
		22,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		nil,
		3,
		[27] = 2
	},
	[39410023] = {
		39410023,
		13,
		Lang.get(105077),
		39410,
		23,
		857,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		},
		[27] = 3
	},
	[39410024] = {
		39410024,
		0,
		Lang.get(105078),
		39410,
		24,
		1269,
		{
			RTResTalkAction[36]
		},
		1,
		2,
		[27] = 3
	},
	[39410025] = {
		39410025,
		13,
		Lang.get(105079),
		39410,
		25,
		857,
		{
			RTResTalkAction[36]
		},
		nil,
		0,
		[27] = 3
	},
	[39410026] = {
		39410026,
		13,
		Lang.get(105080),
		39410,
		26,
		857,
		{
			RTResTalkAction[36]
		},
		[27] = 3
	},
	[39410027] = {
		39410027,
		0,
		Lang.get(105081),
		39410,
		27,
		856,
		{
			RTResTalkAction[30],
			RTResTalkAction[37]
		}
	},
	[39410028] = {
		39410028,
		0,
		Lang.get(105082),
		39410,
		28,
		1269,
		{
			RTResTalkAction[23],
			RTResTalkAction[55]
		}
	},
	[39411001] = {
		39411001,
		0,
		Lang.get(105083),
		39411,
		1,
		847,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		39427,
		nil,
		1,
		nil,
		1,
		nil,
		39427
	},
	[39411002] = {
		39411002,
		0,
		Lang.get(105084),
		39411,
		2,
		848,
		nil,
		nil,
		nil,
		3
	},
	[39411003] = {
		39411003,
		0,
		Lang.get(105085),
		39411,
		3,
		847
	},
	[39411004] = {
		39411004,
		0,
		Lang.get(105086),
		39411,
		4,
		848
	},
	[39411005] = {
		39411005,
		0,
		Lang.get(105087),
		39411,
		5,
		848
	},
	[39411006] = {
		39411006,
		0,
		Lang.get(105088),
		39411,
		6,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		39428,
		nil,
		1,
		[19] = 39428,
		[17] = 1
	},
	[39411007] = {
		39411007,
		0,
		Lang.get(105089),
		39411,
		7,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39411008] = {
		39411008,
		0,
		Lang.get(105090),
		39411,
		8,
		843,
		{
			RTResTalkAction[63]
		},
		1
	},
	[39411009] = {
		39411009,
		0,
		Lang.get(105091),
		39411,
		9,
		843,
		nil,
		1
	},
	[39411010] = {
		39411010,
		0,
		Lang.get(105092),
		39411,
		10,
		843,
		nil,
		1
	},
	[39411011] = {
		39411011,
		0,
		Lang.get(105093),
		39411,
		11,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39411012] = {
		39411012,
		0,
		Lang.get(105094),
		39411,
		12,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39411013] = {
		39411013,
		0,
		Lang.get(105095),
		39411,
		13,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39411014] = {
		39411014,
		0,
		Lang.get(105096),
		39411,
		14,
		843,
		{
			RTResTalkAction[63]
		},
		1
	},
	[39411015] = {
		39411015,
		0,
		Lang.get(105097),
		39411,
		15,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39411016] = {
		39411016,
		0,
		Lang.get(105098),
		39411,
		16,
		843,
		{
			RTResTalkAction[63]
		},
		1
	},
	[39411017] = {
		39411017,
		0,
		Lang.get(105099),
		39411,
		17,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39411018] = {
		39411018,
		0,
		Lang.get(105100),
		39411,
		18,
		257,
		{
			RTResTalkAction[64]
		}
	},
	[39411019] = {
		39411019,
		0,
		Lang.get(105101),
		39411,
		19,
		843,
		{
			RTResTalkAction[63]
		},
		1
	},
	[39412001] = {
		39412001,
		0,
		Lang.get(105102),
		39412,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		nil,
		nil,
		1,
		[20] = 255
	},
	[39412002] = {
		39412002,
		0,
		Lang.get(105103),
		39412,
		2,
		257,
		{
			RTResTalkAction[64]
		}
	},
	[39412003] = {
		39412003,
		0,
		Lang.get(105104),
		39412,
		3,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39412004] = {
		39412004,
		0,
		Lang.get(105105),
		39412,
		4,
		257,
		{
			RTResTalkAction[63]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39430,
		nil,
		1,
		nil,
		1,
		nil,
		39430,
		-1
	},
	[39412005] = {
		39412005,
		0,
		Lang.get(105106),
		39412,
		5,
		849,
		nil,
		nil,
		nil,
		3
	},
	[39412006] = {
		39412006,
		0,
		Lang.get(105107),
		39412,
		6,
		257,
		{
			RTResTalkAction[65]
		}
	},
	[39412007] = {
		39412007,
		0,
		Lang.get(105108),
		39412,
		7,
		849,
		{
			RTResTalkAction[63]
		}
	},
	[39412008] = {
		39412008,
		0,
		Lang.get(105109),
		39412,
		8,
		605
	},
	[39412009] = {
		39412009,
		0,
		"…………",
		39412,
		9,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39412010] = {
		39412010,
		0,
		Lang.get(105110),
		39412,
		10,
		849,
		{
			RTResTalkAction[63]
		}
	},
	[39412011] = {
		39412011,
		0,
		Lang.get(105111),
		39412,
		11,
		257,
		{
			RTResTalkAction[65]
		}
	},
	[39412012] = {
		39412012,
		0,
		Lang.get(105112),
		39412,
		12,
		605,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39449,
		nil,
		1,
		[19] = 39449,
		[17] = 1
	},
	[39412013] = {
		39412013,
		2,
		Lang.get(105113),
		39412,
		13,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39412014] = {
		39412014,
		2,
		Lang.get(105114),
		39412,
		14,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39412015] = {
		39412015,
		2,
		Lang.get(105115),
		39412,
		15,
		257,
		{
			RTResTalkAction[64]
		}
	},
	[39412016] = {
		39412016,
		0,
		Lang.get(105116),
		39412,
		16,
		847,
		{
			RTResTalkAction[63]
		}
	},
	[39412017] = {
		39412017,
		0,
		Lang.get(24221),
		39412,
		17,
		257,
		{
			RTResTalkAction[65]
		}
	},
	[39412018] = {
		39412018,
		0,
		Lang.get(105117),
		39412,
		18,
		847,
		{
			RTResTalkAction[63]
		}
	},
	[39412019] = {
		39412019,
		0,
		Lang.get(105118),
		39412,
		19,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39412020] = {
		39412020,
		0,
		Lang.get(105119),
		39412,
		20,
		847,
		{
			RTResTalkAction[63]
		}
	},
	[39412021] = {
		39412021,
		0,
		Lang.get(105120),
		39412,
		21,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39413001] = {
		39413001,
		0,
		Lang.get(105121),
		39413,
		1,
		849,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		39431,
		nil,
		1,
		nil,
		1,
		nil,
		39431
	},
	[39413002] = {
		39413002,
		0,
		Lang.get(105122),
		39413,
		2,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39413003] = {
		39413003,
		2,
		Lang.get(105123),
		39413,
		3,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39413004] = {
		39413004,
		0,
		Lang.get(105124),
		39413,
		4,
		849,
		{
			RTResTalkAction[63]
		}
	},
	[39413005] = {
		39413005,
		0,
		Lang.get(105125),
		39413,
		5,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39413006] = {
		39413006,
		0,
		Lang.get(105126),
		39413,
		6,
		849,
		{
			RTResTalkAction[63]
		}
	},
	[39413007] = {
		39413007,
		0,
		Lang.get(105127),
		39413,
		7,
		257,
		{
			RTResTalkAction[64]
		}
	},
	[39413008] = {
		39413008,
		0,
		Lang.get(105128),
		39413,
		8,
		605,
		{
			RTResTalkAction[63]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39432,
		nil,
		1,
		[19] = 39432,
		[17] = 1
	},
	[39413009] = {
		39413009,
		0,
		Lang.get(105129),
		39413,
		9,
		856,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[39413010] = {
		39413010,
		0,
		Lang.get(105130),
		39413,
		10,
		856,
		{
			RTResTalkAction[33]
		}
	},
	[39413011] = {
		39413011,
		0,
		Lang.get(105131),
		39413,
		11,
		257,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[39413012] = {
		39413012,
		0,
		Lang.get(105132),
		39413,
		12,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		}
	},
	[39413013] = {
		39413013,
		0,
		Lang.get(105133),
		39413,
		13,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[70]
		}
	},
	[39413014] = {
		39413014,
		0,
		Lang.get(105134),
		39413,
		14,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[67]
		}
	},
	[39413015] = {
		39413015,
		0,
		Lang.get(105135),
		39413,
		15,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[71]
		}
	},
	[39413016] = {
		39413016,
		0,
		Lang.get(105136),
		39413,
		16,
		257,
		{
			RTResTalkAction[68],
			RTResTalkAction[67]
		}
	},
	[39413017] = {
		39413017,
		0,
		Lang.get(105137),
		39413,
		17,
		257,
		{
			RTResTalkAction[68],
			RTResTalkAction[67]
		}
	},
	[39413018] = {
		39413018,
		0,
		Lang.get(105138),
		39413,
		18,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[69]
		}
	},
	[39413019] = {
		39413019,
		0,
		Lang.get(105139),
		39413,
		19,
		257,
		{
			RTResTalkAction[62],
			RTResTalkAction[55]
		}
	},
	[39421001] = {
		39421001,
		0,
		Lang.get(68573),
		39421,
		1,
		856,
		nil,
		1,
		3,
		nil,
		nil,
		63,
		39450,
		nil,
		1,
		nil,
		1,
		nil,
		39450
	},
	[39421002] = {
		39421002,
		0,
		Lang.get(105140),
		39421,
		2,
		856,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[39421003] = {
		39421003,
		0,
		Lang.get(105141),
		39421,
		3,
		856,
		{
			RTResTalkAction[56]
		}
	},
	[39421004] = {
		39421004,
		0,
		Lang.get(105142),
		39421,
		4,
		856,
		{
			RTResTalkAction[33]
		}
	},
	[39421005] = {
		39421005,
		0,
		Lang.get(105143),
		39421,
		5,
		257,
		{
			RTResTalkAction[66],
			RTResTalkAction[67]
		}
	},
	[39421006] = {
		39421006,
		0,
		Lang.get(105144),
		39421,
		6,
		856,
		{
			RTResTalkAction[68],
			RTResTalkAction[72]
		}
	},
	[39421007] = {
		39421007,
		0,
		Lang.get(105145),
		39421,
		7,
		856,
		{
			RTResTalkAction[30],
			RTResTalkAction[63]
		}
	},
	[39414001] = {
		39414001,
		0,
		Lang.get(105146),
		39414,
		1,
		856,
		nil,
		1,
		2,
		nil,
		nil,
		63,
		39433,
		nil,
		1,
		nil,
		1,
		nil,
		39433
	},
	[39414002] = {
		39414002,
		0,
		Lang.get(105147),
		39414,
		2,
		856,
		{
			RTResTalkAction[30]
		},
		nil,
		0,
		3
	},
	[39414003] = {
		39414003,
		0,
		Lang.get(105148),
		39414,
		3,
		856,
		{
			RTResTalkAction[33]
		}
	},
	[39414004] = {
		39414004,
		0,
		Lang.get(105149),
		39414,
		4,
		605,
		{
			RTResTalkAction[55]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39434,
		nil,
		1,
		[19] = 39434,
		[17] = 1
	},
	[39414005] = {
		39414005,
		2,
		Lang.get(105150),
		39414,
		5,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39414006] = {
		39414006,
		0,
		Lang.get(105151),
		39414,
		6,
		257,
		{
			RTResTalkAction[1],
			RTResTalkAction[63]
		},
		1,
		[27] = 2
	},
	[39414007] = {
		39414007,
		13,
		Lang.get(105152),
		39414,
		7,
		849,
		{
			RTResTalkAction[1]
		},
		[27] = 3
	},
	[39414008] = {
		39414008,
		13,
		Lang.get(105153),
		39414,
		8,
		849,
		{
			RTResTalkAction[1]
		},
		[27] = 3
	},
	[39414009] = {
		39414009,
		13,
		Lang.get(105154),
		39414,
		9,
		257,
		{
			RTResTalkAction[1]
		},
		1,
		1,
		[27] = 3
	},
	[39414010] = {
		39414010,
		13,
		Lang.get(105155),
		39414,
		10,
		257,
		{
			RTResTalkAction[1]
		},
		1,
		[27] = 3
	},
	[39414011] = {
		39414011,
		2,
		Lang.get(105156),
		39414,
		11,
		257,
		{
			RTResTalkAction[62],
			RTResTalkAction[3]
		},
		nil,
		0
	},
	[39414012] = {
		39414012,
		2,
		Lang.get(105157),
		39414,
		12,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39414013] = {
		39414013,
		2,
		Lang.get(105158),
		39414,
		13,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39414014] = {
		39414014,
		0,
		Lang.get(105159),
		39414,
		14,
		605,
		{
			RTResTalkAction[63]
		}
	},
	[39415001] = {
		39415001,
		0,
		Lang.get(105160),
		39415,
		1,
		850,
		nil,
		1,
		nil,
		nil,
		nil,
		207,
		39435,
		nil,
		1,
		nil,
		1,
		nil,
		39435,
		100
	},
	[39415002] = {
		39415002,
		0,
		Lang.get(105161),
		39415,
		2,
		851,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[39415003] = {
		39415003,
		0,
		Lang.get(105162),
		39415,
		3,
		851,
		{
			RTResTalkAction[73]
		}
	},
	[39415004] = {
		39415004,
		0,
		Lang.get(105163),
		39415,
		4,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415005] = {
		39415005,
		0,
		Lang.get(105164),
		39415,
		5,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415006] = {
		39415006,
		0,
		Lang.get(105165),
		39415,
		6,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415007] = {
		39415007,
		0,
		Lang.get(105166),
		39415,
		7,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415008] = {
		39415008,
		2,
		Lang.get(105167),
		39415,
		8,
		851,
		{
			RTResTalkAction[73],
			RTResTalkAction[76]
		}
	},
	[39415009] = {
		39415009,
		0,
		Lang.get(105168),
		39415,
		9,
		605,
		{
			RTResTalkAction[77]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39436,
		nil,
		1,
		nil,
		1,
		nil,
		39436,
		100
	},
	[39415010] = {
		39415010,
		0,
		Lang.get(105169),
		39415,
		10,
		851,
		{
			RTResTalkAction[73]
		},
		nil,
		nil,
		3
	},
	[39415011] = {
		39415011,
		0,
		Lang.get(105170),
		39415,
		11,
		851,
		{
			RTResTalkAction[73]
		}
	},
	[39415012] = {
		39415012,
		0,
		Lang.get(105171),
		39415,
		12,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415013] = {
		39415013,
		0,
		Lang.get(105172),
		39415,
		13,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415014] = {
		39415014,
		0,
		Lang.get(105173),
		39415,
		14,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415015] = {
		39415015,
		0,
		Lang.get(105174),
		39415,
		15,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415016] = {
		39415016,
		0,
		Lang.get(105175),
		39415,
		16,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415017] = {
		39415017,
		0,
		Lang.get(105176),
		39415,
		17,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415018] = {
		39415018,
		0,
		Lang.get(105177),
		39415,
		18,
		851,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415019] = {
		39415019,
		0,
		Lang.get(105178),
		39415,
		19,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415020] = {
		39415020,
		0,
		Lang.get(105179),
		39415,
		20,
		850,
		{
			RTResTalkAction[74],
			RTResTalkAction[75]
		}
	},
	[39415021] = {
		39415021,
		0,
		Lang.get(105180),
		39415,
		21,
		851,
		{
			RTResTalkAction[73],
			RTResTalkAction[76]
		}
	},
	[39416001] = {
		39416001,
		0,
		Lang.get(105181),
		39416,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		39437,
		nil,
		1,
		nil,
		1,
		nil,
		39437
	},
	[39416002] = {
		39416002,
		0,
		Lang.get(105182),
		39416,
		2,
		852,
		nil,
		nil,
		nil,
		3
	},
	[39416003] = {
		39416003,
		0,
		Lang.get(105183),
		39416,
		3,
		852
	},
	[39416004] = {
		39416004,
		0,
		Lang.get(105184),
		39416,
		4,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416005] = {
		39416005,
		0,
		Lang.get(105185),
		39416,
		5,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416006] = {
		39416006,
		0,
		Lang.get(105186),
		39416,
		6,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39416007] = {
		39416007,
		0,
		Lang.get(105187),
		39416,
		7,
		852
	},
	[39416008] = {
		39416008,
		0,
		Lang.get(105188),
		39416,
		8,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416009] = {
		39416009,
		0,
		Lang.get(105189),
		39416,
		9,
		850,
		{
			RTResTalkAction[78],
			RTResTalkAction[63]
		}
	},
	[39416010] = {
		39416010,
		0,
		Lang.get(105190),
		39416,
		10,
		850,
		{
			RTResTalkAction[78]
		}
	},
	[39416011] = {
		39416011,
		0,
		Lang.get(105191),
		39416,
		11,
		852,
		{
			RTResTalkAction[76]
		}
	},
	[39416012] = {
		39416012,
		0,
		Lang.get(105192),
		39416,
		12,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416013] = {
		39416013,
		0,
		Lang.get(105193),
		39416,
		13,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39416014] = {
		39416014,
		0,
		Lang.get(105194),
		39416,
		14,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416015] = {
		39416015,
		0,
		Lang.get(105195),
		39416,
		15,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39416016] = {
		39416016,
		0,
		Lang.get(105196),
		39416,
		16,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416017] = {
		39416017,
		0,
		Lang.get(105197),
		39416,
		17,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39416018] = {
		39416018,
		0,
		Lang.get(105198),
		39416,
		18,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39417001] = {
		39417001,
		0,
		Lang.get(105199),
		39417,
		1,
		852,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		39438,
		nil,
		1,
		nil,
		1,
		nil,
		39438
	},
	[39417002] = {
		39417002,
		0,
		Lang.get(105200),
		39417,
		2,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39417003] = {
		39417003,
		0,
		Lang.get(105201),
		39417,
		3,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39417004] = {
		39417004,
		0,
		Lang.get(105202),
		39417,
		4,
		852
	},
	[39417005] = {
		39417005,
		0,
		Lang.get(105203),
		39417,
		5,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39417006] = {
		39417006,
		0,
		Lang.get(105204),
		39417,
		6,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39417007] = {
		39417007,
		0,
		Lang.get(105205),
		39417,
		7,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39417008] = {
		39417008,
		0,
		Lang.get(105206),
		39417,
		8,
		852,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		39439,
		nil,
		1,
		nil,
		1,
		nil,
		39439
	},
	[39417009] = {
		39417009,
		0,
		Lang.get(105207),
		39417,
		9,
		852
	},
	[39417010] = {
		39417010,
		0,
		Lang.get(105208),
		39417,
		10,
		852
	},
	[39417011] = {
		39417011,
		0,
		Lang.get(105209),
		39417,
		11,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39417012] = {
		39417012,
		0,
		Lang.get(105210),
		39417,
		12,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39417013] = {
		39417013,
		0,
		Lang.get(105211),
		39417,
		13,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39417014] = {
		39417014,
		0,
		Lang.get(105212),
		39417,
		14,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39417015] = {
		39417015,
		0,
		Lang.get(105213),
		39417,
		15,
		852,
		{
			RTResTalkAction[63]
		}
	},
	[39417016] = {
		39417016,
		0,
		Lang.get(105214),
		39417,
		16,
		852,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		39440,
		nil,
		1,
		nil,
		1,
		nil,
		39440
	},
	[39417017] = {
		39417017,
		0,
		Lang.get(105215),
		39417,
		17,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39417018] = {
		39417018,
		0,
		Lang.get(105216),
		39417,
		18,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[16]
		}
	},
	[39418001] = {
		39418001,
		0,
		Lang.get(105217),
		39418,
		1,
		853,
		nil,
		nil,
		nil,
		nil,
		nil,
		207,
		39441,
		nil,
		1,
		nil,
		1,
		nil,
		39441
	},
	[39418002] = {
		39418002,
		0,
		Lang.get(105218),
		39418,
		2,
		854,
		nil,
		nil,
		nil,
		3
	},
	[39418003] = {
		39418003,
		0,
		Lang.get(105219),
		39418,
		3,
		855
	},
	[39418004] = {
		39418004,
		0,
		Lang.get(105220),
		39418,
		4,
		852
	},
	[39418005] = {
		39418005,
		0,
		Lang.get(105221),
		39418,
		5,
		853
	},
	[39418006] = {
		39418006,
		0,
		Lang.get(105222),
		39418,
		6,
		852
	},
	[39418007] = {
		39418007,
		0,
		Lang.get(105223),
		39418,
		7,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39418008] = {
		39418008,
		0,
		Lang.get(105224),
		39418,
		8,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39418009] = {
		39418009,
		0,
		Lang.get(105225),
		39418,
		9,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[15]
		}
	},
	[39418010] = {
		39418010,
		0,
		Lang.get(105226),
		39418,
		10,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[16]
		}
	},
	[39418011] = {
		39418011,
		0,
		Lang.get(105227),
		39418,
		11,
		257,
		{
			RTResTalkAction[68],
			RTResTalkAction[16]
		}
	},
	[39418012] = {
		39418012,
		0,
		Lang.get(105228),
		39418,
		12,
		257,
		{
			RTResTalkAction[62],
			RTResTalkAction[12]
		}
	},
	[39418013] = {
		39418013,
		0,
		Lang.get(105229),
		39418,
		13,
		1269,
		{
			RTResTalkAction[63]
		},
		1,
		1,
		nil,
		nil,
		nil,
		39442,
		nil,
		1,
		nil,
		1,
		nil,
		39442
	},
	[39418014] = {
		39418014,
		0,
		Lang.get(105230),
		39418,
		14,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		0,
		3
	},
	[39418015] = {
		39418015,
		0,
		Lang.get(105231),
		39418,
		15,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39418016] = {
		39418016,
		0,
		Lang.get(105232),
		39418,
		16,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39418017] = {
		39418017,
		0,
		Lang.get(105233),
		39418,
		17,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[79]
		}
	},
	[39418018] = {
		39418018,
		0,
		Lang.get(105234),
		39418,
		18,
		257,
		{
			RTResTalkAction[66],
			RTResTalkAction[16]
		}
	},
	[39418019] = {
		39418019,
		0,
		Lang.get(105235),
		39418,
		19,
		257,
		{
			RTResTalkAction[62],
			RTResTalkAction[12]
		}
	},
	[39418020] = {
		39418020,
		0,
		Lang.get(105236),
		39418,
		20,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39419001] = {
		39419001,
		0,
		Lang.get(105237),
		39419,
		1,
		1269,
		nil,
		1,
		1,
		nil,
		nil,
		207,
		39443,
		nil,
		1,
		nil,
		1,
		nil,
		39443
	},
	[39419002] = {
		39419002,
		0,
		Lang.get(105238),
		39419,
		2,
		1269,
		{
			RTResTalkAction[23]
		},
		nil,
		0,
		3
	},
	[39419003] = {
		39419003,
		0,
		Lang.get(105239),
		39419,
		3,
		257,
		{
			RTResTalkAction[68],
			RTResTalkAction[16]
		}
	},
	[39419004] = {
		39419004,
		0,
		Lang.get(105240),
		39419,
		4,
		257,
		{
			RTResTalkAction[68],
			RTResTalkAction[16]
		}
	},
	[39419005] = {
		39419005,
		0,
		Lang.get(105241),
		39419,
		5,
		1269,
		{
			RTResTalkAction[10],
			RTResTalkAction[63]
		}
	},
	[39419006] = {
		39419006,
		0,
		Lang.get(105242),
		39419,
		6,
		257,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39444,
		nil,
		1,
		nil,
		1,
		nil,
		39444
	},
	[39419007] = {
		39419007,
		0,
		Lang.get(105243),
		39419,
		7,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39419008] = {
		39419008,
		0,
		Lang.get(105676),
		39419,
		8,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39419009] = {
		39419009,
		0,
		Lang.get(105245),
		39419,
		9,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[79]
		}
	},
	[39419010] = {
		39419010,
		0,
		Lang.get(105246),
		39419,
		10,
		1269,
		{
			RTResTalkAction[11],
			RTResTalkAction[63]
		}
	},
	[39419011] = {
		39419011,
		0,
		Lang.get(105247),
		39419,
		11,
		852,
		{
			RTResTalkAction[12]
		}
	},
	[39419012] = {
		39419012,
		0,
		Lang.get(105248),
		39419,
		12,
		852
	},
	[39419013] = {
		39419013,
		0,
		Lang.get(105249),
		39419,
		13,
		853
	},
	[39419014] = {
		39419014,
		0,
		Lang.get(105250),
		39419,
		14,
		854
	},
	[39419015] = {
		39419015,
		0,
		Lang.get(105251),
		39419,
		15,
		855
	},
	[39419016] = {
		39419016,
		2,
		Lang.get(105252),
		39419,
		16,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39420001] = {
		39420001,
		0,
		Lang.get(105253),
		39420,
		1,
		1269,
		nil,
		1,
		1,
		nil,
		nil,
		207,
		39445,
		nil,
		1,
		nil,
		1,
		nil,
		39445
	},
	[39420002] = {
		39420002,
		0,
		Lang.get(105254),
		39420,
		2,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		0,
		3
	},
	[39420003] = {
		39420003,
		0,
		Lang.get(105255),
		39420,
		3,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39420004] = {
		39420004,
		0,
		Lang.get(105256),
		39420,
		4,
		1269,
		{
			RTResTalkAction[68],
			RTResTalkAction[80]
		}
	},
	[39420005] = {
		39420005,
		0,
		Lang.get(105257),
		39420,
		5,
		257,
		{
			RTResTalkAction[62],
			RTResTalkAction[12]
		}
	},
	[39420006] = {
		39420006,
		0,
		Lang.get(105258),
		39420,
		6,
		257,
		{
			RTResTalkAction[63]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39446,
		nil,
		1,
		nil,
		1,
		nil,
		39446
	},
	[39420007] = {
		39420007,
		0,
		Lang.get(105259),
		39420,
		7,
		257,
		{
			RTResTalkAction[62]
		},
		nil,
		nil,
		3
	},
	[39420008] = {
		39420008,
		0,
		Lang.get(105260),
		39420,
		8,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39420009] = {
		39420009,
		0,
		Lang.get(105261),
		39420,
		9,
		257,
		{
			RTResTalkAction[62]
		}
	},
	[39420010] = {
		39420010,
		0,
		Lang.get(105262),
		39420,
		10,
		1269,
		{
			RTResTalkAction[10],
			RTResTalkAction[63]
		}
	},
	[39420011] = {
		39420011,
		0,
		Lang.get(105263),
		39420,
		11,
		257,
		{
			RTResTalkAction[12]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		39447,
		nil,
		1,
		nil,
		1,
		nil,
		39447
	},
	[39420012] = {
		39420012,
		0,
		Lang.get(105264),
		39420,
		12,
		257,
		{
			RTResTalkAction[81]
		},
		1,
		nil,
		3,
		[21] = 427
	},
	[39420013] = {
		39420013,
		0,
		Lang.get(105265),
		39420,
		13,
		356,
		{
			RTResTalkAction[81]
		},
		[21] = 427
	},
	[39420014] = {
		39420014,
		0,
		Lang.get(105266),
		39420,
		14,
		353,
		{
			RTResTalkAction[81]
		},
		[21] = 427
	},
	[39420015] = {
		39420015,
		0,
		Lang.get(105267),
		39420,
		15,
		257,
		{
			RTResTalkAction[81]
		},
		1,
		[21] = 427
	},
	[39420016] = {
		39420016,
		0,
		Lang.get(105268),
		39420,
		16,
		1269,
		{
			RTResTalkAction[81]
		},
		1,
		[21] = 427
	},
	[39420017] = {
		39420017,
		0,
		Lang.get(105269),
		39420,
		17,
		605,
		{
			RTResTalkAction[82]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		39448,
		nil,
		1,
		[19] = 39448,
		[17] = 1
	},
	[39420018] = {
		39420018,
		0,
		Lang.get(105270),
		39420,
		18,
		107,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[39420019] = {
		39420019,
		0,
		Lang.get(105271),
		39420,
		19,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[39420020] = {
		39420020,
		0,
		Lang.get(105272),
		39420,
		20,
		107,
		{
			RTResTalkAction[9]
		}
	},
	[39420021] = {
		39420021,
		0,
		Lang.get(105273),
		39420,
		21,
		107,
		{
			RTResTalkAction[13]
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
