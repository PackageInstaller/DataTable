-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\disanzhang\\ResTalk.lua

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
	1,
	107,
	{
		2
	},
	nil,
	8
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 128
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[8] = {
	[1] = 2,
	[2] = 128
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 119
}
RTResTalkAction[10] = {
	1,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 128
}
RTResTalkAction[12] = {
	1,
	107,
	{
		3,
		10041
	},
	nil,
	3
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 140
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 140
}
RTResTalkAction[16] = {
	1,
	107,
	{
		10041
	},
	nil,
	3
}
RTResTalkAction[17] = {
	1,
	107,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		1
	}
}
RTResTalkAction[19] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[20] = {
	1,
	107,
	{
		2,
		10021
	},
	nil,
	10
}
RTResTalkAction[21] = {
	1,
	107,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[22] = {
	1,
	107,
	nil,
	nil,
	6
}
RTResTalkAction[23] = {
	1,
	133,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[24] = {
	1,
	133,
	nil,
	nil,
	0
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 133,
	[3] = {
		1
	}
}
RTResTalkAction[26] = {
	1,
	107,
	nil,
	nil,
	4
}
RTResTalkAction[27] = {
	1,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		2
	}
}
RTResTalkAction[29] = {
	[1] = 1,
	[2] = 673
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 674
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 673
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 674
}
RTResTalkAction[33] = {
	1,
	107,
	nil,
	nil,
	7
}
RTResTalkAction[34] = {
	1,
	119,
	nil,
	nil,
	7
}
RTResTalkAction[35] = {
	1,
	107,
	{
		10011
	},
	nil,
	5
}
RTResTalkAction[36] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	7
}
RTResTalkAction[37] = {
	1,
	119,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[38] = {
	1,
	107,
	{
		10011
	},
	nil,
	6
}
RTResTalkAction[39] = {
	1,
	107,
	{
		2
	},
	nil,
	1
}
RTResTalkAction[40] = {
	1,
	107,
	{
		1
	},
	nil,
	7
}
RTResTalkAction[41] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[42] = {
	1,
	119,
	nil,
	nil,
	5
}
RTResTalkAction[43] = {
	1,
	107,
	{
		10011
	},
	nil,
	4
}
RTResTalkAction[44] = {
	[1] = 1,
	[2] = 140,
	[3] = {
		3
	}
}
RTResTalkAction[45] = {
	1,
	119,
	{
		3
	},
	nil,
	7
}
RTResTalkAction[46] = {
	1,
	128,
	nil,
	nil,
	0
}
RTResTalkAction[47] = {
	[1] = 2,
	[2] = 674
}
RTResTalkAction[48] = {
	[1] = 3,
	[2] = 673
}
RTResTalkAction[49] = {
	1,
	119,
	{
		2
	},
	nil,
	5
}
RTResTalkAction[50] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[51] = {
	[1] = 3,
	[2] = 128
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 141,
	[3] = {
		3
	}
}
RTResTalkAction[53] = {
	1,
	107,
	{
		1
	},
	nil,
	5
}
RTResTalkAction[54] = {
	[1] = 2,
	[2] = 140
}
RTResTalkAction[55] = {
	[1] = 3,
	[2] = 150
}
RTResTalkAction[56] = {
	[1] = 2,
	[2] = 140,
	[3] = {
		1
	}
}
RTResTalkAction[57] = {
	3,
	150,
	nil,
	nil,
	2
}
RTResTalkAction[58] = {
	3,
	150,
	nil,
	nil,
	1
}
RTResTalkAction[59] = {
	3,
	150,
	{
		3
	},
	nil,
	2
}
RTResTalkAction[60] = {
	[1] = 0,
	[2] = 150
}
RTResTalkAction[61] = {
	[1] = 1,
	[2] = 678
}
RTResTalkAction[62] = {
	[1] = 1,
	[2] = 679
}
RTResTalkAction[63] = {
	[1] = 0,
	[2] = 678
}
RTResTalkAction[64] = {
	[1] = 0,
	[2] = 679
}
RTResTalkAction[65] = {
	3,
	150,
	nil,
	nil,
	4
}
RTResTalkAction[66] = {
	[1] = 1,
	[2] = 678,
	[3] = {
		2
	}
}
RTResTalkAction[67] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[68] = {
	3,
	150,
	nil,
	nil,
	3
}
RTResTalkAction[69] = {
	[1] = 1,
	[2] = 311
}
RTResTalkAction[70] = {
	1,
	107,
	{
		1,
		10021
	},
	nil,
	1
}
RTResTalkAction[71] = {
	[1] = 0,
	[2] = 311
}
RTResTalkAction[72] = {
	1,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[73] = {
	1,
	119,
	{
		3
	},
	nil,
	1
}
RTResTalkAction[74] = {
	[1] = 1,
	[2] = 119,
	[3] = {
		1
	}
}
RTResTalkAction[75] = {
	[1] = 1,
	[2] = 112
}
RTResTalkAction[76] = {
	[1] = 0,
	[2] = 112
}
RTResTalkAction[77] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[78] = {
	[1] = 1,
	[2] = 119
}
RTResTalkAction[79] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[80] = {
	1,
	119,
	{
		3,
		10045
	},
	nil,
	4
}
RTResTalkAction[81] = {
	1,
	119,
	{
		3
	},
	nil,
	6
}
RTResTalkAction[82] = {
	1,
	119,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[83] = {
	1,
	119,
	{
		3
	},
	nil,
	3
}
RTResTalkAction[84] = {
	2,
	119,
	nil,
	nil,
	2
}
RTResTalkAction[85] = {
	2,
	119,
	{
		10025
	},
	nil,
	0
}
RTResTalkAction[86] = {
	2,
	119,
	nil,
	nil,
	1
}
RTResTalkAction[87] = {
	2,
	119,
	nil,
	nil,
	6
}
RTResTalkAction[88] = {
	2,
	119,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[89] = {
	3,
	150,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[90] = {
	2,
	119,
	nil,
	nil,
	3
}
RTResTalkAction[91] = {
	3,
	150,
	nil,
	nil,
	5
}
RTResTalkAction[92] = {
	[1] = 1,
	[2] = 150,
	[3] = {
		1
	}
}
RTResTalkAction[93] = {
	[1] = 1,
	[2] = 675
}
RTResTalkAction[94] = {
	[1] = 1,
	[2] = 627
}
RTResTalkAction[95] = {
	[1] = 0,
	[2] = 675
}
RTResTalkAction[96] = {
	[1] = 0,
	[2] = 627
}
RTResTalkAction[97] = {
	[1] = 1,
	[2] = 664
}
RTResTalkAction[98] = {
	[1] = 0,
	[2] = 664
}
RTResTalkAction[99] = {
	[1] = 1,
	[2] = 680
}
RTResTalkAction[100] = {
	[1] = 0,
	[2] = 680
}
RTResTalkAction[101] = {
	[1] = 1,
	[2] = 123
}
RTResTalkAction[102] = {
	[1] = 0,
	[2] = 123
}
RTResTalkAction[103] = {
	[1] = 2,
	[2] = 664
}
RTResTalkAction[104] = {
	[1] = 3,
	[2] = 675
}

local Data = {
	[9300001] = {
		9300001,
		9,
		Lang.get(35292),
		9300,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		61,
		nil,
		1,
		nil,
		1,
		[18] = 9300,
		[21] = 1
	},
	[9300002] = {
		9300002,
		9,
		Lang.get(35293),
		9300,
		2,
		[21] = 1
	},
	[9300003] = {
		9300003,
		0,
		Lang.get(35294),
		9300,
		3,
		133,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9301,
		1,
		nil,
		1,
		nil,
		9301
	},
	[9300004] = {
		9300004,
		0,
		Lang.get(37993),
		9300,
		4,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[9300005] = {
		9300005,
		0,
		Lang.get(35296),
		9300,
		5,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[9300006] = {
		9300006,
		0,
		Lang.get(35297),
		9300,
		6,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[9300007] = {
		9300007,
		0,
		Lang.get(35298),
		9300,
		7,
		119,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[9300008] = {
		9300008,
		0,
		Lang.get(35299),
		9300,
		8,
		128,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		}
	},
	[9300009] = {
		9300009,
		0,
		Lang.get(35300),
		9300,
		9,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[9300010] = {
		9300010,
		0,
		Lang.get(35301),
		9300,
		10,
		107,
		{
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[9300011] = {
		9300011,
		0,
		Lang.get(35302),
		9300,
		11,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[9300012] = {
		9300012,
		3,
		Lang.get(35303),
		9300,
		12,
		[21] = 1,
		[7] = {
			RTResTalkAction[15]
		}
	},
	[9300013] = {
		9300013,
		0,
		Lang.get(37994),
		9300,
		13,
		107,
		nil,
		1,
		1,
		nil,
		nil,
		nil,
		9302,
		0.8,
		1,
		nil,
		nil,
		9302
	},
	[9300014] = {
		9300014,
		4,
		nil,
		9300,
		14,
		107,
		nil,
		1,
		1,
		[27] = {
			{
				id = 9300015,
				branch_content = "……"
			}
		}
	},
	[9300015] = {
		9300015,
		0,
		Lang.get(35306),
		9300,
		15,
		107,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[9300016] = {
		9300016,
		0,
		Lang.get(35307),
		9300,
		16,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9300017] = {
		9300017,
		0,
		Lang.get(35308),
		9300,
		17,
		107,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[9300018] = {
		9300018,
		0,
		Lang.get(35309),
		9300,
		18,
		119,
		{
			RTResTalkAction[5]
		},
		1,
		7
	},
	[9300019] = {
		9300019,
		0,
		Lang.get(35310),
		9300,
		19,
		140,
		nil,
		1,
		0
	},
	[9300020] = {
		9300020,
		0,
		Lang.get(35311),
		9300,
		20,
		128,
		nil,
		1,
		0
	},
	[9300021] = {
		9300021,
		0,
		Lang.get(35312),
		9300,
		21,
		119,
		nil,
		1,
		3
	},
	[9300022] = {
		9300022,
		0,
		Lang.get(46244),
		9300,
		22,
		141,
		{
			RTResTalkAction[18]
		}
	},
	[9300023] = {
		9300023,
		0,
		Lang.get(35313),
		9300,
		23,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[7]
		}
	},
	[9300024] = {
		9300024,
		0,
		Lang.get(35314),
		9300,
		24,
		119,
		{
			RTResTalkAction[5]
		},
		1,
		3
	},
	[9300025] = {
		9300025,
		0,
		"？？？？？？",
		9300,
		25,
		107,
		{
			RTResTalkAction[20]
		}
	},
	[9300026] = {
		9300026,
		0,
		Lang.get(35315),
		9300,
		26,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9300027] = {
		9300027,
		0,
		Lang.get(35316),
		9300,
		27,
		107,
		{
			RTResTalkAction[21],
			RTResTalkAction[3]
		}
	},
	[9300028] = {
		9300028,
		0,
		Lang.get(35317),
		9300,
		28,
		141,
		{
			RTResTalkAction[5]
		},
		1,
		0,
		-1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		9300
	},
	[9300029] = {
		9300029,
		5,
		Lang.get(35318),
		9300,
		29,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		9303,
		1,
		1,
		1,
		nil,
		9302
	},
	[9300030] = {
		9300030,
		0,
		Lang.get(35319),
		9300,
		30,
		107,
		{
			RTResTalkAction[22]
		},
		nil,
		nil,
		3
	},
	[9300031] = {
		9300031,
		0,
		Lang.get(35320),
		9300,
		31,
		133,
		{
			RTResTalkAction[23],
			RTResTalkAction[5]
		}
	},
	[9310001] = {
		9310001,
		0,
		Lang.get(35321),
		9310,
		1,
		133,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3,
		nil,
		63,
		9310,
		1,
		nil,
		1,
		nil,
		9310
	},
	[9310002] = {
		9310002,
		0,
		Lang.get(46245),
		9310,
		2,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[3]
		}
	},
	[9310003] = {
		9310003,
		0,
		Lang.get(35322),
		9310,
		3,
		128,
		{
			RTResTalkAction[5]
		},
		1,
		0
	},
	[9310004] = {
		9310004,
		0,
		Lang.get(35323),
		9310,
		4,
		140,
		nil,
		1,
		0
	},
	[9310005] = {
		9310005,
		0,
		Lang.get(35324),
		9310,
		5,
		119,
		nil,
		1,
		5
	},
	[9310006] = {
		9310006,
		0,
		Lang.get(35325),
		9310,
		6,
		128,
		nil,
		1,
		0
	},
	[9310007] = {
		9310007,
		0,
		Lang.get(35326),
		9310,
		7,
		119,
		nil,
		1,
		3
	},
	[9310008] = {
		9310008,
		0,
		Lang.get(35327),
		9310,
		8,
		133,
		{
			RTResTalkAction[25]
		}
	},
	[9310009] = {
		9310009,
		0,
		Lang.get(35328),
		9310,
		9,
		107,
		{
			RTResTalkAction[26],
			RTResTalkAction[3]
		}
	},
	[9310010] = {
		9310010,
		0,
		Lang.get(35329),
		9310,
		10,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9310011] = {
		9310011,
		0,
		Lang.get(35330),
		9310,
		11,
		673,
		{
			RTResTalkAction[3]
		},
		1,
		0
	},
	[9310012] = {
		9310012,
		0,
		Lang.get(35331),
		9310,
		12,
		674,
		nil,
		1,
		0
	},
	[9310013] = {
		9310013,
		0,
		Lang.get(35332),
		9310,
		13,
		119,
		{
			RTResTalkAction[27]
		}
	},
	[9310014] = {
		9310014,
		0,
		Lang.get(35333),
		9310,
		14,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[13]
		}
	},
	[9310015] = {
		9310015,
		0,
		Lang.get(35334),
		9310,
		15,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[9310016] = {
		9310016,
		0,
		Lang.get(35335),
		9310,
		16,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[5]
		}
	},
	[9310017] = {
		9310017,
		3,
		Lang.get(35336),
		9310,
		17,
		[21] = 1,
		[7] = {
			RTResTalkAction[7]
		}
	},
	[9310018] = {
		9310018,
		0,
		Lang.get(35337),
		9310,
		18,
		128,
		nil,
		1,
		0
	},
	[9310019] = {
		9310019,
		0,
		Lang.get(35338),
		9310,
		19,
		119,
		nil,
		1,
		2
	},
	[9310020] = {
		9310020,
		0,
		Lang.get(46246),
		9310,
		20,
		128,
		nil,
		1,
		0
	},
	[9310021] = {
		9310021,
		0,
		Lang.get(35339),
		9310,
		21,
		119,
		nil,
		1,
		3
	},
	[9310022] = {
		9310022,
		0,
		Lang.get(35340),
		9310,
		22,
		128,
		nil,
		1,
		0
	},
	[9310023] = {
		9310023,
		0,
		Lang.get(35341),
		9310,
		23,
		119,
		nil,
		1,
		3
	},
	[9310024] = {
		9310024,
		0,
		Lang.get(35342),
		9310,
		24,
		128,
		nil,
		1,
		0
	},
	[9310025] = {
		9310025,
		0,
		Lang.get(35343),
		9310,
		25,
		119,
		nil,
		1,
		3
	},
	[9310026] = {
		9310026,
		0,
		Lang.get(35344),
		9310,
		26,
		128,
		nil,
		1,
		0
	},
	[9310027] = {
		9310027,
		0,
		Lang.get(35345),
		9310,
		27,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[9310028] = {
		9310028,
		0,
		Lang.get(35346),
		9310,
		28,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9310029] = {
		9310029,
		0,
		Lang.get(35347),
		9310,
		29,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[9310030] = {
		9310030,
		0,
		Lang.get(35348),
		9310,
		30,
		107,
		{
			RTResTalkAction[21],
			RTResTalkAction[7]
		}
	},
	[9310031] = {
		9310031,
		3,
		Lang.get(35349),
		9310,
		31,
		[18] = 9311,
		[21] = 1,
		[7] = {
			RTResTalkAction[5]
		}
	},
	[9320001] = {
		9320001,
		0,
		Lang.get(35350),
		9320,
		1,
		673,
		{
			RTResTalkAction[29]
		},
		nil,
		nil,
		3,
		nil,
		63,
		9320,
		1,
		1,
		1,
		nil,
		9320
	},
	[9320002] = {
		9320002,
		0,
		Lang.get(35351),
		9320,
		2,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[9320003] = {
		9320003,
		0,
		Lang.get(35352),
		9320,
		3,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[32]
		}
	},
	[9320004] = {
		9320004,
		0,
		Lang.get(35353),
		9320,
		4,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[3]
		}
	},
	[9320005] = {
		9320005,
		0,
		Lang.get(35354),
		9320,
		5,
		119,
		{
			RTResTalkAction[34],
			RTResTalkAction[5]
		}
	},
	[9320006] = {
		9320006,
		0,
		Lang.get(35355),
		9320,
		6,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[9320007] = {
		9320007,
		0,
		Lang.get(35356),
		9320,
		7,
		107,
		{
			RTResTalkAction[35],
			RTResTalkAction[13]
		}
	},
	[9330001] = {
		9330001,
		0,
		Lang.get(35357),
		9330,
		1,
		107,
		{
			RTResTalkAction[36]
		},
		nil,
		nil,
		3,
		nil,
		60,
		9330,
		1,
		1,
		1,
		nil,
		9330
	},
	[9330002] = {
		9330002,
		0,
		Lang.get(35358),
		9330,
		2,
		119,
		{
			RTResTalkAction[27],
			RTResTalkAction[5]
		}
	},
	[9330003] = {
		9330003,
		0,
		Lang.get(35359),
		9330,
		3,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[13]
		}
	},
	[9330004] = {
		9330004,
		0,
		Lang.get(35360),
		9330,
		4,
		119,
		{
			RTResTalkAction[37],
			RTResTalkAction[5]
		}
	},
	[9330005] = {
		9330005,
		0,
		"……",
		9330,
		5,
		107,
		{
			RTResTalkAction[38],
			RTResTalkAction[13]
		}
	},
	[9330006] = {
		9330006,
		0,
		Lang.get(35361),
		9330,
		6,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9330007] = {
		9330007,
		0,
		Lang.get(35362),
		9330,
		7,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[3]
		}
	},
	[9330008] = {
		9330008,
		0,
		Lang.get(35363),
		9330,
		8,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[9330009] = {
		9330009,
		0,
		Lang.get(35364),
		9330,
		9,
		107,
		{
			RTResTalkAction[39],
			RTResTalkAction[11]
		}
	},
	[9330010] = {
		9330010,
		0,
		Lang.get(35365),
		9330,
		10,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[9330011] = {
		9330011,
		0,
		Lang.get(35366),
		9330,
		11,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9330012] = {
		9330012,
		0,
		Lang.get(35367),
		9330,
		12,
		107,
		{
			RTResTalkAction[40],
			RTResTalkAction[15]
		}
	},
	[9330013] = {
		9330013,
		0,
		Lang.get(35368),
		9330,
		13,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[9330014] = {
		9330014,
		0,
		Lang.get(46247),
		9330,
		14,
		107,
		{
			RTResTalkAction[41],
			RTResTalkAction[11]
		}
	},
	[9330015] = {
		9330015,
		0,
		Lang.get(37996),
		9330,
		15,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[5]
		}
	},
	[9330016] = {
		9330016,
		0,
		Lang.get(35370),
		9330,
		16,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[9330017] = {
		9330017,
		0,
		Lang.get(35371),
		9330,
		17,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[11]
		}
	},
	[9330018] = {
		9330018,
		0,
		Lang.get(37997),
		9330,
		18,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[7]
		}
	},
	[9330019] = {
		9330019,
		0,
		Lang.get(37998),
		9330,
		19,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[13]
		}
	},
	[9330020] = {
		9330020,
		0,
		Lang.get(35374),
		9330,
		20,
		119,
		{
			RTResTalkAction[42],
			RTResTalkAction[11]
		}
	},
	[9330021] = {
		9330021,
		0,
		Lang.get(35375),
		9330,
		21,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[13]
		}
	},
	[9330022] = {
		9330022,
		0,
		Lang.get(35376),
		9330,
		22,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[11]
		}
	},
	[9330023] = {
		9330023,
		0,
		Lang.get(35377),
		9330,
		23,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[32]
		}
	},
	[9330024] = {
		9330024,
		0,
		Lang.get(35378),
		9330,
		24,
		107,
		{
			RTResTalkAction[43],
			RTResTalkAction[31]
		}
	},
	[9330025] = {
		9330025,
		0,
		Lang.get(35379),
		9330,
		25,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[5]
		}
	},
	[9330026] = {
		9330026,
		0,
		Lang.get(35380),
		9330,
		26,
		140,
		{
			RTResTalkAction[44]
		}
	},
	[9330027] = {
		9330027,
		3,
		Lang.get(35381),
		9330,
		27,
		nil,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9331,
		1,
		1,
		0,
		nil,
		9331,
		nil,
		nil,
		1
	},
	[9330028] = {
		9330028,
		0,
		Lang.get(35382),
		9330,
		28,
		119,
		{
			RTResTalkAction[45]
		},
		nil,
		nil,
		3
	},
	[9330029] = {
		9330029,
		0,
		Lang.get(35383),
		9330,
		29,
		133,
		{
			RTResTalkAction[24],
			RTResTalkAction[13]
		}
	},
	[9330030] = {
		9330030,
		0,
		Lang.get(35384),
		9330,
		30,
		128,
		{
			RTResTalkAction[46],
			RTResTalkAction[3]
		}
	},
	[9340001] = {
		9340001,
		0,
		Lang.get(35385),
		9340,
		1,
		674,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3,
		nil,
		61,
		9340,
		0.8,
		1,
		1,
		nil,
		9340
	},
	[9340002] = {
		9340002,
		0,
		Lang.get(35386),
		9340,
		2,
		673,
		{
			RTResTalkAction[47],
			RTResTalkAction[48]
		}
	},
	[9340003] = {
		9340003,
		0,
		Lang.get(35387),
		9340,
		3,
		119,
		{
			RTResTalkAction[49],
			RTResTalkAction[32],
			RTResTalkAction[31]
		}
	},
	[9340004] = {
		9340004,
		0,
		Lang.get(35388),
		9340,
		4,
		128,
		{
			RTResTalkAction[50],
			RTResTalkAction[51]
		}
	},
	[9340005] = {
		9340005,
		0,
		Lang.get(35389),
		9340,
		5,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[9340006] = {
		9340006,
		0,
		Lang.get(35390),
		9340,
		6,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[13]
		}
	},
	[9340007] = {
		9340007,
		0,
		Lang.get(35391),
		9340,
		7,
		141,
		{
			RTResTalkAction[28],
			RTResTalkAction[32]
		}
	},
	[9340008] = {
		9340008,
		0,
		Lang.get(35392),
		9340,
		8,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9340009] = {
		9340009,
		0,
		Lang.get(46248),
		9340,
		9,
		141,
		{
			RTResTalkAction[52],
			RTResTalkAction[31]
		}
	},
	[9340010] = {
		9340010,
		0,
		Lang.get(35393),
		9340,
		10,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9340011] = {
		9340011,
		0,
		Lang.get(35394),
		9340,
		11,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[31]
		}
	},
	[9340012] = {
		9340012,
		0,
		Lang.get(46249),
		9340,
		12,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9340013] = {
		9340013,
		0,
		"………",
		9340,
		13,
		673,
		{
			RTResTalkAction[29]
		}
	},
	[9340014] = {
		9340014,
		0,
		Lang.get(35396),
		9340,
		14,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[31]
		}
	},
	[9340015] = {
		9340015,
		0,
		Lang.get(37999),
		9340,
		15,
		141,
		{
			RTResTalkAction[4]
		}
	},
	[9340016] = {
		9340016,
		0,
		Lang.get(35398),
		9340,
		16,
		141,
		{
			RTResTalkAction[18]
		}
	},
	[9340017] = {
		9340017,
		0,
		Lang.get(46250),
		9340,
		17,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9340018] = {
		9340018,
		0,
		Lang.get(35399),
		9340,
		18,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[31]
		}
	},
	[9340019] = {
		9340019,
		0,
		Lang.get(35400),
		9340,
		19,
		141,
		{
			RTResTalkAction[4]
		}
	},
	[9340020] = {
		9340020,
		0,
		Lang.get(35401),
		9340,
		20,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[9340021] = {
		9340021,
		0,
		Lang.get(38000),
		9340,
		21,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[11]
		}
	},
	[9340022] = {
		9340022,
		0,
		Lang.get(35403),
		9340,
		22,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9340023] = {
		9340023,
		0,
		Lang.get(35404),
		9340,
		23,
		107,
		{
			RTResTalkAction[53],
			RTResTalkAction[31]
		}
	},
	[9350001] = {
		9350001,
		3,
		Lang.get(35405),
		9350,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		57,
		nil,
		1,
		1,
		1,
		nil,
		9350,
		nil,
		nil,
		1
	},
	[9350002] = {
		9350002,
		0,
		Lang.get(35406),
		9350,
		2,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9350003] = {
		9350003,
		0,
		Lang.get(35407),
		9350,
		3,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9350004] = {
		9350004,
		0,
		Lang.get(35408),
		9350,
		4,
		140,
		{
			RTResTalkAction[56],
			RTResTalkAction[55]
		}
	},
	[9350005] = {
		9350005,
		0,
		Lang.get(35409),
		9350,
		5,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9350006] = {
		9350006,
		0,
		Lang.get(35410),
		9350,
		6,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9350007] = {
		9350007,
		0,
		Lang.get(35411),
		9350,
		7,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9350008] = {
		9350008,
		0,
		Lang.get(35412),
		9350,
		8,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[58]
		}
	},
	[9350009] = {
		9350009,
		0,
		Lang.get(35413),
		9350,
		9,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9350010] = {
		9350010,
		0,
		Lang.get(35414),
		9350,
		10,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[59]
		}
	},
	[9350011] = {
		9350011,
		0,
		Lang.get(35415),
		9350,
		11,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9350012] = {
		9350012,
		0,
		Lang.get(35416),
		9350,
		12,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9350013] = {
		9350013,
		0,
		Lang.get(46251),
		9350,
		13,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[60]
		}
	},
	[9350014] = {
		9350014,
		0,
		Lang.get(35418),
		9350,
		14,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9360001] = {
		9360001,
		0,
		Lang.get(35419),
		9360,
		1,
		678,
		{
			RTResTalkAction[61]
		},
		nil,
		nil,
		nil,
		nil,
		57,
		nil,
		1,
		1,
		1,
		nil,
		9360
	},
	[9360002] = {
		9360002,
		0,
		Lang.get(35420),
		9360,
		2,
		679,
		{
			RTResTalkAction[62],
			RTResTalkAction[63]
		}
	},
	[9360003] = {
		9360003,
		0,
		Lang.get(35421),
		9360,
		3,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[64]
		}
	},
	[9360004] = {
		9360004,
		0,
		Lang.get(35422),
		9360,
		4,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9360005] = {
		9360005,
		0,
		Lang.get(35423),
		9360,
		5,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9360006] = {
		9360006,
		0,
		Lang.get(35424),
		9360,
		6,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9360007] = {
		9360007,
		0,
		Lang.get(35425),
		9360,
		7,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[65]
		}
	},
	[9360008] = {
		9360008,
		0,
		Lang.get(35426),
		9360,
		8,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9360009] = {
		9360009,
		0,
		Lang.get(35427),
		9360,
		9,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9360010] = {
		9360010,
		0,
		Lang.get(35428),
		9360,
		10,
		678,
		{
			RTResTalkAction[66],
			RTResTalkAction[15],
			RTResTalkAction[60]
		}
	},
	[9370001] = {
		9370001,
		0,
		Lang.get(35429),
		9370,
		1,
		150,
		{
			RTResTalkAction[67]
		},
		nil,
		nil,
		3,
		nil,
		62,
		9370,
		1,
		1,
		1,
		nil,
		9370
	},
	[9370002] = {
		9370002,
		0,
		Lang.get(35430),
		9370,
		2,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370003] = {
		9370003,
		0,
		Lang.get(35431),
		9370,
		3,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[68]
		}
	},
	[9370004] = {
		9370004,
		0,
		Lang.get(35432),
		9370,
		4,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9370005] = {
		9370005,
		0,
		Lang.get(46252),
		9370,
		5,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370006] = {
		9370006,
		0,
		Lang.get(35433),
		9370,
		6,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370007] = {
		9370007,
		0,
		Lang.get(35434),
		9370,
		7,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[58]
		}
	},
	[9370008] = {
		9370008,
		0,
		Lang.get(35435),
		9370,
		8,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370009] = {
		9370009,
		0,
		Lang.get(35436),
		9370,
		9,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9370010] = {
		9370010,
		0,
		Lang.get(35437),
		9370,
		10,
		140,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370011] = {
		9370011,
		0,
		Lang.get(35438),
		9370,
		11,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[57]
		}
	},
	[9370012] = {
		9370012,
		0,
		Lang.get(35439),
		9370,
		12,
		150,
		{
			RTResTalkAction[54],
			RTResTalkAction[55]
		}
	},
	[9370013] = {
		9370013,
		0,
		Lang.get(35440),
		9370,
		13,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[60]
		}
	},
	[9370014] = {
		9370014,
		0,
		Lang.get(35441),
		9370,
		14,
		150,
		{
			RTResTalkAction[67],
			RTResTalkAction[15]
		}
	},
	[9370015] = {
		9370015,
		0,
		Lang.get(35442),
		9370,
		15,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9371
	},
	[9370016] = {
		9370016,
		0,
		Lang.get(35443),
		9370,
		16,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[31]
		}
	},
	[9370017] = {
		9370017,
		0,
		Lang.get(35444),
		9370,
		17,
		150,
		{
			RTResTalkAction[67],
			RTResTalkAction[15]
		}
	},
	[9370018] = {
		9370018,
		0,
		Lang.get(35445),
		9370,
		18,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9372
	},
	[9370019] = {
		9370019,
		0,
		Lang.get(35446),
		9370,
		19,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[32]
		}
	},
	[9370020] = {
		9370020,
		0,
		Lang.get(35447),
		9370,
		20,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9370021] = {
		9370021,
		0,
		Lang.get(35448),
		9370,
		21,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9370022] = {
		9370022,
		0,
		Lang.get(35449),
		9370,
		22,
		150,
		{
			RTResTalkAction[67],
			RTResTalkAction[15]
		}
	},
	[9370023] = {
		9370023,
		0,
		Lang.get(35450),
		9370,
		23,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[60]
		}
	},
	[9380001] = {
		9380001,
		3,
		Lang.get(35451),
		9380,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		61,
		nil,
		nil,
		nil,
		1,
		[18] = 9380,
		[21] = 1
	},
	[9380002] = {
		9380002,
		3,
		Lang.get(35452),
		9380,
		2,
		311,
		{
			RTResTalkAction[69]
		},
		nil,
		nil,
		4,
		[21] = 1,
		[20] = 2009
	},
	[9380003] = {
		9380003,
		3,
		Lang.get(35453),
		9380,
		3,
		311,
		{
			RTResTalkAction[69]
		},
		[21] = 1,
		[20] = 2009
	},
	[9380004] = {
		9380004,
		0,
		Lang.get(35454),
		9380,
		4,
		107,
		{
			RTResTalkAction[70],
			RTResTalkAction[71]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		9381,
		1,
		1,
		1,
		nil,
		9381
	},
	[9380005] = {
		9380005,
		0,
		Lang.get(46253),
		9380,
		5,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[9380006] = {
		9380006,
		0,
		Lang.get(35455),
		9380,
		6,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[7]
		}
	},
	[9380007] = {
		9380007,
		0,
		Lang.get(35456),
		9380,
		7,
		107,
		{
			RTResTalkAction[33],
			RTResTalkAction[3]
		}
	},
	[9380008] = {
		9380008,
		0,
		Lang.get(35457),
		9380,
		8,
		119,
		{
			RTResTalkAction[45],
			RTResTalkAction[5]
		}
	},
	[9380009] = {
		9380009,
		0,
		Lang.get(35458),
		9380,
		9,
		119,
		{
			RTResTalkAction[72]
		}
	},
	[9380010] = {
		9380010,
		0,
		Lang.get(35459),
		9380,
		10,
		119,
		{
			RTResTalkAction[42]
		}
	},
	[9380011] = {
		9380011,
		0,
		Lang.get(35460),
		9380,
		11,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[13]
		}
	},
	[9380012] = {
		9380012,
		0,
		Lang.get(35461),
		9380,
		12,
		119,
		{
			RTResTalkAction[73],
			RTResTalkAction[31]
		}
	},
	[9380013] = {
		9380013,
		0,
		Lang.get(35462),
		9380,
		13,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[13]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		9382,
		1,
		1,
		1,
		nil,
		9382
	},
	[9380014] = {
		9380014,
		0,
		Lang.get(35463),
		9380,
		14,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[9380015] = {
		9380015,
		0,
		Lang.get(35464),
		9380,
		15,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[15]
		}
	},
	[9380016] = {
		9380016,
		0,
		Lang.get(35465),
		9380,
		16,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[9380017] = {
		9380017,
		0,
		Lang.get(35466),
		9380,
		17,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[15]
		}
	},
	[9380018] = {
		9380018,
		0,
		Lang.get(46254),
		9380,
		18,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[9380019] = {
		9380019,
		0,
		Lang.get(35467),
		9380,
		19,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[15]
		}
	},
	[9380020] = {
		9380020,
		0,
		Lang.get(35468),
		9380,
		20,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[9380021] = {
		9380021,
		0,
		Lang.get(35469),
		9380,
		21,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[15]
		}
	},
	[9380022] = {
		9380022,
		0,
		Lang.get(35470),
		9380,
		22,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[11]
		}
	},
	[9380023] = {
		9380023,
		0,
		Lang.get(35471),
		9380,
		23,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[15]
		}
	},
	[9380024] = {
		9380024,
		0,
		Lang.get(35472),
		9380,
		24,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[9390001] = {
		9390001,
		0,
		Lang.get(35473),
		9390,
		1,
		107,
		{
			RTResTalkAction[41]
		},
		nil,
		nil,
		3,
		nil,
		60,
		9390,
		1,
		1,
		1,
		nil,
		9390
	},
	[9390002] = {
		9390002,
		0,
		Lang.get(35474),
		9390,
		2,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[5]
		}
	},
	[9390003] = {
		9390003,
		0,
		Lang.get(35475),
		9390,
		3,
		107,
		{
			RTResTalkAction[19],
			RTResTalkAction[3]
		}
	},
	[9390004] = {
		9390004,
		0,
		Lang.get(35476),
		9390,
		4,
		119,
		{
			RTResTalkAction[74],
			RTResTalkAction[5]
		}
	},
	[9390005] = {
		9390005,
		0,
		Lang.get(35477),
		9390,
		5,
		107,
		{
			RTResTalkAction[22],
			RTResTalkAction[13]
		}
	},
	[9390006] = {
		9390006,
		3,
		Lang.get(35478),
		9390,
		6,
		[21] = 1,
		[7] = {
			RTResTalkAction[5]
		}
	},
	[9390007] = {
		9390007,
		0,
		Lang.get(35479),
		9390,
		7,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[9390008] = {
		9390008,
		3,
		Lang.get(35480),
		9390,
		8,
		[21] = 1,
		[7] = {
			RTResTalkAction[11]
		}
	},
	[9390009] = {
		9390009,
		0,
		Lang.get(35481),
		9390,
		9,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9390010] = {
		9390010,
		3,
		Lang.get(35482),
		9390,
		10,
		[21] = 1,
		[7] = {
			RTResTalkAction[15]
		}
	},
	[9390011] = {
		9390011,
		0,
		Lang.get(35483),
		9390,
		11,
		128,
		{
			RTResTalkAction[6]
		}
	},
	[9390012] = {
		9390012,
		3,
		Lang.get(35484),
		9390,
		12,
		[21] = 1,
		[7] = {
			RTResTalkAction[11]
		}
	},
	[9390013] = {
		9390013,
		0,
		Lang.get(35485),
		9390,
		13,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9390014] = {
		9390014,
		0,
		Lang.get(38001),
		9390,
		14,
		112,
		{
			RTResTalkAction[75],
			RTResTalkAction[15]
		}
	},
	[9390015] = {
		9390015,
		0,
		Lang.get(35487),
		9390,
		15,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[76]
		}
	},
	[9390016] = {
		9390016,
		3,
		Lang.get(35488),
		9390,
		16,
		nil,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9391,
		1,
		1,
		1,
		nil,
		9391,
		nil,
		nil,
		1
	},
	[9390017] = {
		9390017,
		0,
		Lang.get(35489),
		9390,
		17,
		141,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[9390018] = {
		9390018,
		0,
		Lang.get(35490),
		9390,
		18,
		112,
		{
			RTResTalkAction[75],
			RTResTalkAction[7]
		}
	},
	[9390019] = {
		9390019,
		0,
		Lang.get(35491),
		9390,
		19,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[76]
		}
	},
	[9390020] = {
		9390020,
		0,
		Lang.get(35492),
		9390,
		20,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[11]
		}
	},
	[9390021] = {
		9390021,
		3,
		Lang.get(35493),
		9390,
		21,
		nil,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		9392,
		1,
		1,
		1,
		nil,
		9392,
		nil,
		nil,
		1
	},
	[9390022] = {
		9390022,
		0,
		Lang.get(35494),
		9390,
		22,
		112,
		{
			RTResTalkAction[75]
		},
		nil,
		nil,
		3
	},
	[9390023] = {
		9390023,
		0,
		Lang.get(35495),
		9390,
		23,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[76]
		}
	},
	[9390024] = {
		9390024,
		0,
		Lang.get(35496),
		9390,
		24,
		112,
		{
			RTResTalkAction[75],
			RTResTalkAction[11]
		}
	},
	[9390025] = {
		9390025,
		0,
		Lang.get(35497),
		9390,
		25,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[76]
		}
	},
	[9390026] = {
		9390026,
		0,
		Lang.get(35498),
		9390,
		26,
		140,
		{
			RTResTalkAction[14]
		}
	},
	[9390027] = {
		9390027,
		0,
		Lang.get(38002),
		9390,
		27,
		107,
		{
			RTResTalkAction[77],
			RTResTalkAction[15]
		}
	},
	[9390028] = {
		9390028,
		0,
		Lang.get(35500),
		9390,
		28,
		119,
		{
			RTResTalkAction[78],
			RTResTalkAction[5]
		}
	},
	[9390029] = {
		9390029,
		0,
		Lang.get(35501),
		9390,
		29,
		112,
		{
			RTResTalkAction[75],
			RTResTalkAction[13]
		}
	},
	[9390030] = {
		9390030,
		0,
		Lang.get(35502),
		9390,
		30,
		112,
		{
			RTResTalkAction[75]
		}
	},
	[9390031] = {
		9390031,
		0,
		Lang.get(35503),
		9390,
		31,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[76]
		}
	},
	[9390032] = {
		9390032,
		0,
		Lang.get(35504),
		9390,
		32,
		112,
		{
			RTResTalkAction[75],
			RTResTalkAction[7]
		}
	},
	[9390033] = {
		9390033,
		0,
		Lang.get(38003),
		9390,
		33,
		112,
		{
			RTResTalkAction[75]
		}
	},
	[9390034] = {
		9390034,
		0,
		Lang.get(35506),
		9390,
		34,
		107,
		{
			RTResTalkAction[77],
			RTResTalkAction[76]
		}
	},
	[9390035] = {
		9390035,
		0,
		Lang.get(35507),
		9390,
		35,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[5]
		}
	},
	[9390036] = {
		9390036,
		0,
		Lang.get(35508),
		9390,
		36,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[9390037] = {
		9390037,
		0,
		Lang.get(35509),
		9390,
		37,
		119,
		{
			RTResTalkAction[10],
			RTResTalkAction[32]
		}
	},
	[9390038] = {
		9390038,
		0,
		Lang.get(35510),
		9390,
		38,
		107,
		{
			RTResTalkAction[79],
			RTResTalkAction[13]
		}
	},
	[9390039] = {
		9390039,
		0,
		Lang.get(35511),
		9390,
		39,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[9400001] = {
		9400001,
		0,
		Lang.get(35512),
		9400,
		1,
		119,
		{
			RTResTalkAction[80]
		},
		nil,
		nil,
		3,
		nil,
		59,
		nil,
		1,
		1,
		1,
		nil,
		9400
	},
	[9400002] = {
		9400002,
		0,
		Lang.get(38004),
		9400,
		2,
		119,
		{
			RTResTalkAction[10]
		}
	},
	[9400003] = {
		9400003,
		0,
		Lang.get(35514),
		9400,
		3,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400004] = {
		9400004,
		0,
		Lang.get(35515),
		9400,
		4,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400005] = {
		9400005,
		0,
		Lang.get(35516),
		9400,
		5,
		119,
		{
			RTResTalkAction[81]
		}
	},
	[9400006] = {
		9400006,
		3,
		Lang.get(35517),
		9400,
		6,
		605,
		{
			RTResTalkAction[13]
		},
		[21] = 1
	},
	[9400007] = {
		9400007,
		3,
		Lang.get(35518),
		9400,
		7,
		605,
		[21] = 1
	},
	[9400008] = {
		9400008,
		3,
		Lang.get(35519),
		9400,
		8,
		605,
		[21] = 1
	},
	[9400009] = {
		9400009,
		0,
		Lang.get(35520),
		9400,
		9,
		119,
		{
			RTResTalkAction[82]
		}
	},
	[9400010] = {
		9400010,
		0,
		Lang.get(46255),
		9400,
		10,
		157,
		{
			RTResTalkAction[78]
		}
	},
	[9400011] = {
		9400011,
		0,
		Lang.get(35522),
		9400,
		11,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400012] = {
		9400012,
		0,
		Lang.get(35523),
		9400,
		12,
		157,
		{
			RTResTalkAction[78]
		}
	},
	[9400013] = {
		9400013,
		0,
		Lang.get(35524),
		9400,
		13,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400014] = {
		9400014,
		0,
		Lang.get(46256),
		9400,
		14,
		157,
		{
			RTResTalkAction[78]
		}
	},
	[9400015] = {
		9400015,
		0,
		Lang.get(35525),
		9400,
		15,
		119,
		{
			RTResTalkAction[72]
		}
	},
	[9400016] = {
		9400016,
		0,
		Lang.get(35526),
		9400,
		16,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400017] = {
		9400017,
		0,
		Lang.get(35527),
		9400,
		17,
		119,
		{
			RTResTalkAction[78]
		}
	},
	[9400018] = {
		9400018,
		3,
		Lang.get(35480),
		9400,
		18,
		[21] = 1,
		[7] = {
			RTResTalkAction[13]
		}
	},
	[9400019] = {
		9400019,
		0,
		"……",
		9400,
		19,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		1,
		nil,
		9401
	},
	[9400020] = {
		9400020,
		0,
		Lang.get(35528),
		9400,
		20,
		119,
		nil,
		1,
		7
	},
	[9400021] = {
		9400021,
		0,
		Lang.get(35529),
		9400,
		21,
		150,
		nil,
		1,
		1
	},
	[9400022] = {
		9400022,
		0,
		Lang.get(35530),
		9400,
		22,
		119,
		nil,
		1,
		3
	},
	[9400023] = {
		9400023,
		0,
		Lang.get(35531),
		9400,
		23,
		150,
		nil,
		1,
		2
	},
	[9400024] = {
		9400024,
		0,
		Lang.get(35532),
		9400,
		24,
		119,
		nil,
		1,
		3
	},
	[9400025] = {
		9400025,
		0,
		Lang.get(35533),
		9400,
		25,
		150,
		nil,
		1,
		2
	},
	[9400026] = {
		9400026,
		0,
		Lang.get(35534),
		9400,
		26,
		119,
		nil,
		1,
		4
	},
	[9400027] = {
		9400027,
		0,
		Lang.get(35535),
		9400,
		27,
		150,
		nil,
		1,
		0
	},
	[9400028] = {
		9400028,
		0,
		Lang.get(35536),
		9400,
		28,
		119,
		nil,
		1,
		6
	},
	[9400029] = {
		9400029,
		0,
		Lang.get(35537),
		9400,
		29,
		150,
		nil,
		1,
		0
	},
	[9400030] = {
		9400030,
		0,
		Lang.get(35538),
		9400,
		30,
		119,
		nil,
		1,
		7
	},
	[9410001] = {
		9410001,
		0,
		Lang.get(35539),
		9410,
		1,
		119,
		nil,
		1,
		2,
		nil,
		nil,
		61,
		9410,
		1,
		1,
		1,
		nil,
		9410
	},
	[9410002] = {
		9410002,
		0,
		Lang.get(35540),
		9410,
		2,
		150,
		nil,
		1,
		1
	},
	[9410003] = {
		9410003,
		0,
		Lang.get(35541),
		9410,
		3,
		119,
		{
			RTResTalkAction[83]
		},
		nil,
		nil,
		3
	},
	[9410004] = {
		9410004,
		0,
		Lang.get(35542),
		9410,
		4,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[57]
		}
	},
	[9410005] = {
		9410005,
		0,
		Lang.get(35543),
		9410,
		5,
		119,
		{
			RTResTalkAction[84],
			RTResTalkAction[55]
		}
	},
	[9410006] = {
		9410006,
		0,
		Lang.get(35544),
		9410,
		6,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[58]
		}
	},
	[9410007] = {
		9410007,
		0,
		Lang.get(35545),
		9410,
		7,
		119,
		{
			RTResTalkAction[85],
			RTResTalkAction[55]
		}
	},
	[9410008] = {
		9410008,
		0,
		Lang.get(35546),
		9410,
		8,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[9410009] = {
		9410009,
		0,
		Lang.get(35547),
		9410,
		9,
		119,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[9410010] = {
		9410010,
		0,
		Lang.get(35548),
		9410,
		10,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[58]
		}
	},
	[9410011] = {
		9410011,
		0,
		Lang.get(35549),
		9410,
		11,
		119,
		{
			RTResTalkAction[86],
			RTResTalkAction[55]
		}
	},
	[9410012] = {
		9410012,
		0,
		Lang.get(35550),
		9410,
		12,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[9410013] = {
		9410013,
		0,
		Lang.get(35551),
		9410,
		13,
		119,
		{
			RTResTalkAction[87],
			RTResTalkAction[55]
		}
	},
	[9410014] = {
		9410014,
		0,
		Lang.get(35552),
		9410,
		14,
		119,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[9410015] = {
		9410015,
		0,
		Lang.get(35553),
		9410,
		15,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[57]
		}
	},
	[9410016] = {
		9410016,
		0,
		Lang.get(35554),
		9410,
		16,
		119,
		{
			RTResTalkAction[88],
			RTResTalkAction[55]
		}
	},
	[9410017] = {
		9410017,
		0,
		Lang.get(46257),
		9410,
		17,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[89]
		}
	},
	[9410018] = {
		9410018,
		0,
		Lang.get(35555),
		9410,
		18,
		119,
		{
			RTResTalkAction[90],
			RTResTalkAction[55]
		}
	},
	[9410019] = {
		9410019,
		0,
		Lang.get(35556),
		9410,
		19,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[55]
		}
	},
	[9410020] = {
		9410020,
		0,
		Lang.get(35557),
		9410,
		20,
		119,
		{
			RTResTalkAction[90],
			RTResTalkAction[55]
		}
	},
	[9410021] = {
		9410021,
		0,
		Lang.get(35558),
		9410,
		21,
		150,
		{
			RTResTalkAction[50],
			RTResTalkAction[91]
		}
	},
	[9410022] = {
		9410022,
		0,
		Lang.get(35559),
		9410,
		22,
		119,
		{
			RTResTalkAction[84],
			RTResTalkAction[55]
		}
	},
	[9410023] = {
		9410023,
		0,
		Lang.get(35560),
		9410,
		23,
		150,
		{
			RTResTalkAction[92],
			RTResTalkAction[13]
		}
	},
	[9410024] = {
		9410024,
		3,
		Lang.get(35561),
		9410,
		24,
		nil,
		{
			RTResTalkAction[60]
		},
		nil,
		nil,
		nil,
		nil,
		6,
		9411,
		1,
		1,
		1,
		nil,
		9411,
		nil,
		nil,
		1
	},
	[9410025] = {
		9410025,
		0,
		Lang.get(35562),
		9410,
		25,
		119,
		{
			RTResTalkAction[27]
		},
		nil,
		nil,
		3
	},
	[9410026] = {
		9410026,
		0,
		Lang.get(35563),
		9410,
		26,
		107,
		{
			RTResTalkAction[79],
			RTResTalkAction[13]
		}
	},
	[9410027] = {
		9410027,
		0,
		Lang.get(35564),
		9410,
		27,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[5]
		}
	},
	[9410028] = {
		9410028,
		0,
		Lang.get(38005),
		9410,
		28,
		150,
		{
			RTResTalkAction[67],
			RTResTalkAction[31]
		}
	},
	[9410029] = {
		9410029,
		0,
		Lang.get(35566),
		9410,
		29,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[60]
		}
	},
	[9410030] = {
		9410030,
		0,
		Lang.get(35567),
		9410,
		30,
		140,
		{
			RTResTalkAction[14],
			RTResTalkAction[32]
		}
	},
	[9410031] = {
		9410031,
		0,
		Lang.get(35568),
		9410,
		31,
		133,
		{
			RTResTalkAction[1],
			RTResTalkAction[15]
		}
	},
	[9410032] = {
		9410032,
		0,
		Lang.get(35569),
		9410,
		32,
		141,
		{
			RTResTalkAction[4],
			RTResTalkAction[3]
		}
	},
	[9410033] = {
		9410033,
		0,
		Lang.get(35570),
		9410,
		33,
		673,
		{
			RTResTalkAction[29],
			RTResTalkAction[7]
		}
	},
	[9410034] = {
		9410034,
		0,
		Lang.get(35571),
		9410,
		34,
		674,
		{
			RTResTalkAction[30],
			RTResTalkAction[31]
		}
	},
	[9410035] = {
		9410035,
		0,
		Lang.get(35572),
		9410,
		35,
		128,
		{
			RTResTalkAction[6],
			RTResTalkAction[32]
		}
	},
	[9410036] = {
		9410036,
		0,
		Lang.get(35573),
		9410,
		36,
		112,
		{
			RTResTalkAction[11]
		},
		1,
		3,
		nil,
		nil,
		nil,
		9412,
		1,
		1,
		1,
		nil,
		9412
	},
	[9410037] = {
		9410037,
		0,
		Lang.get(35574),
		9410,
		37,
		107,
		nil,
		1,
		6
	},
	[9410038] = {
		9410038,
		0,
		Lang.get(35575),
		9410,
		38,
		112,
		nil,
		1,
		3
	},
	[9410039] = {
		9410039,
		4,
		nil,
		9410,
		39,
		112,
		nil,
		1,
		3,
		[27] = {
			{
				id = 9410040,
				branch_content = Lang.get(25724)
			}
		}
	},
	[9410040] = {
		9410040,
		0,
		Lang.get(35577),
		9410,
		40,
		119,
		{
			RTResTalkAction[78]
		},
		nil,
		nil,
		3
	},
	[9410041] = {
		9410041,
		0,
		Lang.get(35578),
		9410,
		41,
		150,
		{
			RTResTalkAction[67],
			RTResTalkAction[13]
		}
	},
	[9410042] = {
		9410042,
		3,
		Lang.get(35579),
		9410,
		42,
		[21] = 1,
		[7] = {
			RTResTalkAction[60]
		}
	},
	[9410043] = {
		9410043,
		3,
		Lang.get(35580),
		9410,
		43,
		[21] = 1
	},
	[9420001] = {
		9420001,
		3,
		Lang.get(35581),
		9420,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		61,
		9420,
		1,
		1,
		1,
		nil,
		9420,
		nil,
		nil,
		1
	},
	[9420002] = {
		9420002,
		3,
		Lang.get(35582),
		9420,
		2,
		[21] = 1
	},
	[9420003] = {
		9420003,
		0,
		Lang.get(35583),
		9420,
		3,
		675,
		{
			RTResTalkAction[93]
		},
		nil,
		nil,
		3
	},
	[9420004] = {
		9420004,
		0,
		Lang.get(35584),
		9420,
		4,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[9420005] = {
		9420005,
		0,
		Lang.get(35585),
		9420,
		5,
		675,
		{
			RTResTalkAction[93],
			RTResTalkAction[96]
		}
	},
	[9420006] = {
		9420006,
		0,
		Lang.get(35586),
		9420,
		6,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[9420007] = {
		9420007,
		0,
		Lang.get(35587),
		9420,
		7,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[96]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		9422,
		1,
		1,
		1,
		nil,
		9422
	},
	[9420008] = {
		9420008,
		0,
		Lang.get(35588),
		9420,
		8,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[98]
		}
	},
	[9420009] = {
		9420009,
		0,
		Lang.get(35589),
		9420,
		9,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[96]
		}
	},
	[9420010] = {
		9420010,
		0,
		Lang.get(35590),
		9420,
		10,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[98]
		}
	},
	[9420011] = {
		9420011,
		0,
		Lang.get(35591),
		9420,
		11,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[96]
		}
	},
	[9420012] = {
		9420012,
		0,
		Lang.get(35592),
		9420,
		12,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[98]
		}
	},
	[9420013] = {
		9420013,
		3,
		Lang.get(35593),
		9420,
		13,
		[21] = 1,
		[7] = {
			RTResTalkAction[96]
		}
	},
	[9420014] = {
		9420014,
		0,
		Lang.get(35594),
		9420,
		14,
		664,
		{
			RTResTalkAction[97]
		}
	},
	[9420015] = {
		9420015,
		11,
		"Videos/AVG_shouliezhe_box.mp4",
		9420,
		15,
		nil,
		{
			RTResTalkAction[98]
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
	[9420016] = {
		9420016,
		0,
		Lang.get(35595),
		9420,
		16,
		680,
		{
			RTResTalkAction[99]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		9421,
		1,
		1,
		1,
		nil,
		9421
	},
	[9420017] = {
		9420017,
		0,
		Lang.get(35596),
		9420,
		17,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[100]
		}
	},
	[9420018] = {
		9420018,
		0,
		Lang.get(35597),
		9420,
		18,
		675,
		{
			RTResTalkAction[93],
			RTResTalkAction[98]
		}
	},
	[9420019] = {
		9420019,
		0,
		Lang.get(35598),
		9420,
		19,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[95]
		}
	},
	[9420020] = {
		9420020,
		0,
		Lang.get(35599),
		9420,
		20,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[102]
		}
	},
	[9420021] = {
		9420021,
		0,
		Lang.get(35600),
		9420,
		21,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[96]
		}
	},
	[9420022] = {
		9420022,
		0,
		Lang.get(35601),
		9420,
		22,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[102]
		}
	},
	[9420023] = {
		9420023,
		0,
		Lang.get(46258),
		9420,
		23,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[98]
		}
	},
	[9420024] = {
		9420024,
		0,
		Lang.get(35603),
		9420,
		24,
		123,
		{
			RTResTalkAction[101]
		}
	},
	[9420025] = {
		9420025,
		0,
		Lang.get(35604),
		9420,
		25,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[102]
		}
	},
	[9420026] = {
		9420026,
		0,
		Lang.get(35605),
		9420,
		26,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[96]
		}
	},
	[9420027] = {
		9420027,
		0,
		Lang.get(46259),
		9420,
		27,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[98]
		}
	},
	[9420028] = {
		9420028,
		0,
		Lang.get(38006),
		9420,
		28,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[102]
		}
	},
	[9420029] = {
		9420029,
		0,
		Lang.get(35607),
		9420,
		29,
		627,
		{
			RTResTalkAction[94]
		}
	},
	[9420030] = {
		9420030,
		0,
		Lang.get(35608),
		9420,
		30,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[96]
		}
	},
	[9420031] = {
		9420031,
		0,
		Lang.get(35609),
		9420,
		31,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[102]
		}
	},
	[9420032] = {
		9420032,
		0,
		Lang.get(35610),
		9420,
		32,
		675,
		{
			RTResTalkAction[93],
			RTResTalkAction[96]
		}
	},
	[9420033] = {
		9420033,
		0,
		Lang.get(35611),
		9420,
		33,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[95]
		}
	},
	[9420034] = {
		9420034,
		0,
		Lang.get(35612),
		9420,
		34,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[96]
		}
	},
	[9420035] = {
		9420035,
		0,
		Lang.get(35613),
		9420,
		35,
		664,
		{
			RTResTalkAction[97],
			RTResTalkAction[102]
		}
	},
	[9420036] = {
		9420036,
		0,
		Lang.get(35614),
		9420,
		36,
		675,
		{
			RTResTalkAction[103],
			RTResTalkAction[104]
		}
	},
	[9420037] = {
		9420037,
		0,
		Lang.get(35615),
		9420,
		37,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[98],
			RTResTalkAction[95]
		}
	},
	[9420038] = {
		9420038,
		0,
		Lang.get(46260),
		9420,
		38,
		627,
		{
			RTResTalkAction[94],
			RTResTalkAction[102]
		}
	},
	[9420039] = {
		9420039,
		0,
		Lang.get(35616),
		9420,
		39,
		123,
		{
			RTResTalkAction[101],
			RTResTalkAction[96]
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
