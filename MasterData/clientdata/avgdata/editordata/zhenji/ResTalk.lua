-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhenji\\ResTalk.lua

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
	1301,
	nil,
	nil,
	1
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1301
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1301
}
RTResTalkAction[4] = {
	[1] = 2,
	[2] = 1093
}
RTResTalkAction[5] = {
	[1] = 3,
	[2] = 1301
}
RTResTalkAction[6] = {
	3,
	1301,
	nil,
	nil,
	3
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1093
}
RTResTalkAction[8] = {
	3,
	1301,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	3,
	1301,
	nil,
	nil,
	2
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 1093
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 705
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 705
}
RTResTalkAction[13] = {
	1,
	1301,
	nil,
	nil,
	3
}
RTResTalkAction[14] = {
	[1] = 1,
	[2] = 1028
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 1027
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 1028
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1027
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[20] = {
	[1] = 1,
	[2] = 1258
}
RTResTalkAction[21] = {
	[1] = 0,
	[2] = 1258
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 768
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[24] = {
	[1] = 0,
	[2] = 768
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[26] = {
	[1] = 1,
	[2] = 677
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 677
}
RTResTalkAction[28] = {
	[1] = 1,
	[2] = 1052
}

local Data = {
	[42721001] = {
		42721001,
		3,
		Lang.get(115386),
		42721,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		169,
		42721,
		nil,
		1,
		nil,
		1,
		nil,
		42721,
		255,
		nil,
		1
	},
	[42721002] = {
		42721002,
		3,
		Lang.get(115387),
		42721,
		2,
		605,
		[22] = 1
	},
	[42721003] = {
		42721003,
		0,
		Lang.get(115388),
		42721,
		3,
		1093,
		nil,
		1,
		[20] = -1
	},
	[42721004] = {
		42721004,
		0,
		Lang.get(115389),
		42721,
		4,
		1301,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[42721005] = {
		42721005,
		0,
		Lang.get(115390),
		42721,
		5,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42721006] = {
		42721006,
		7,
		"126",
		42721,
		6,
		1301,
		{
			RTResTalkAction[3]
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
	[42721007] = {
		42721007,
		0,
		Lang.get(115391),
		42721,
		7,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[42721008] = {
		42721008,
		0,
		Lang.get(115392),
		42721,
		8,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721009] = {
		42721009,
		0,
		Lang.get(115393),
		42721,
		9,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[42721010] = {
		42721010,
		0,
		Lang.get(115394),
		42721,
		10,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42722,
		nil,
		1,
		nil,
		1,
		nil,
		42722
	},
	[42721011] = {
		42721011,
		0,
		Lang.get(115395),
		42721,
		11,
		1093,
		{
			RTResTalkAction[7]
		}
	},
	[42721012] = {
		42721012,
		0,
		Lang.get(115396),
		42721,
		12,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721013] = {
		42721013,
		0,
		Lang.get(115397),
		42721,
		13,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721014] = {
		42721014,
		0,
		Lang.get(115398),
		42721,
		14,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721015] = {
		42721015,
		0,
		Lang.get(115399),
		42721,
		15,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721016] = {
		42721016,
		0,
		Lang.get(115400),
		42721,
		16,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42721017] = {
		42721017,
		0,
		Lang.get(115401),
		42721,
		17,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[8]
		}
	},
	[42721018] = {
		42721018,
		0,
		Lang.get(115402),
		42721,
		18,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722001] = {
		42722001,
		3,
		Lang.get(115403),
		42722,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		42723,
		nil,
		1,
		nil,
		1,
		nil,
		42723,
		nil,
		nil,
		1
	},
	[42722002] = {
		42722002,
		0,
		Lang.get(115404),
		42722,
		2,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[42722003] = {
		42722003,
		0,
		Lang.get(115405),
		42722,
		3,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722004] = {
		42722004,
		0,
		Lang.get(115406),
		42722,
		4,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[42722005] = {
		42722005,
		0,
		Lang.get(115407),
		42722,
		5,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722006] = {
		42722006,
		0,
		Lang.get(115408),
		42722,
		6,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722007] = {
		42722007,
		0,
		Lang.get(115409),
		42722,
		7,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722008] = {
		42722008,
		0,
		Lang.get(115410),
		42722,
		8,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42722009] = {
		42722009,
		0,
		Lang.get(115411),
		42722,
		9,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[9]
		}
	},
	[42722010] = {
		42722010,
		3,
		Lang.get(115412),
		42722,
		10,
		605,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		42724,
		nil,
		1,
		nil,
		1,
		nil,
		42724,
		nil,
		nil,
		1
	},
	[42722011] = {
		42722011,
		0,
		Lang.get(115413),
		42722,
		11,
		1301,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[42722012] = {
		42722012,
		0,
		Lang.get(115414),
		42722,
		12,
		705,
		{
			RTResTalkAction[11],
			RTResTalkAction[3]
		}
	},
	[42722013] = {
		42722013,
		0,
		Lang.get(115415),
		42722,
		13,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[12]
		}
	},
	[42722014] = {
		42722014,
		0,
		Lang.get(115416),
		42722,
		14,
		705,
		{
			RTResTalkAction[11],
			RTResTalkAction[10]
		}
	},
	[42722015] = {
		42722015,
		0,
		Lang.get(115417),
		42722,
		15,
		705,
		{
			RTResTalkAction[11]
		}
	},
	[42722016] = {
		42722016,
		0,
		Lang.get(115418),
		42722,
		16,
		705,
		{
			RTResTalkAction[11]
		}
	},
	[42722017] = {
		42722017,
		0,
		Lang.get(115419),
		42722,
		17,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[12]
		}
	},
	[42722018] = {
		42722018,
		0,
		Lang.get(115420),
		42722,
		18,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42723001] = {
		42723001,
		3,
		Lang.get(115421),
		42723,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		63,
		42725,
		nil,
		1,
		nil,
		1,
		nil,
		42725,
		nil,
		nil,
		1
	},
	[42723002] = {
		42723002,
		0,
		Lang.get(115422),
		42723,
		2,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[42723003] = {
		42723003,
		0,
		Lang.get(115706),
		42723,
		3,
		916,
		{
			RTResTalkAction[10]
		},
		1
	},
	[42723004] = {
		42723004,
		0,
		Lang.get(115424),
		42723,
		4,
		1301,
		{
			RTResTalkAction[13]
		}
	},
	[42723005] = {
		42723005,
		0,
		Lang.get(115425),
		42723,
		5,
		916,
		{
			RTResTalkAction[3]
		},
		1
	},
	[42723006] = {
		42723006,
		0,
		Lang.get(115426),
		42723,
		6,
		1093,
		{
			RTResTalkAction[7]
		}
	},
	[42723007] = {
		42723007,
		0,
		Lang.get(115427),
		42723,
		7,
		916,
		{
			RTResTalkAction[10]
		},
		1
	},
	[42723008] = {
		42723008,
		0,
		Lang.get(115428),
		42723,
		8,
		1301,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		42726,
		nil,
		1,
		nil,
		1,
		nil,
		42726
	},
	[42723009] = {
		42723009,
		0,
		Lang.get(115429),
		42723,
		9,
		916,
		nil,
		1,
		0,
		3
	},
	[42723010] = {
		42723010,
		0,
		Lang.get(115430),
		42723,
		10,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42723011] = {
		42723011,
		0,
		Lang.get(115431),
		42723,
		11,
		916,
		{
			RTResTalkAction[3]
		},
		1
	},
	[42723012] = {
		42723012,
		0,
		Lang.get(115432),
		42723,
		12,
		1301,
		{
			RTResTalkAction[13]
		}
	},
	[42723013] = {
		42723013,
		0,
		Lang.get(115433),
		42723,
		13,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42723014] = {
		42723014,
		0,
		Lang.get(115434),
		42723,
		14,
		1301,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[42724001] = {
		42724001,
		0,
		Lang.get(115435),
		42724,
		1,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		63,
		42727,
		nil,
		1,
		nil,
		1,
		nil,
		42727
	},
	[42724002] = {
		42724002,
		0,
		Lang.get(115436),
		42724,
		2,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42724003] = {
		42724003,
		0,
		Lang.get(115437),
		42724,
		3,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[42724004] = {
		42724004,
		0,
		Lang.get(115438),
		42724,
		4,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724005] = {
		42724005,
		0,
		Lang.get(115439),
		42724,
		5,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724006] = {
		42724006,
		0,
		Lang.get(115440),
		42724,
		6,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724007] = {
		42724007,
		0,
		Lang.get(115441),
		42724,
		7,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724008] = {
		42724008,
		0,
		Lang.get(115442),
		42724,
		8,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42724009] = {
		42724009,
		0,
		Lang.get(115443),
		42724,
		9,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42728,
		nil,
		1,
		nil,
		1,
		nil,
		42728
	},
	[42724010] = {
		42724010,
		0,
		Lang.get(115444),
		42724,
		10,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42724011] = {
		42724011,
		0,
		Lang.get(115445),
		42724,
		11,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724012] = {
		42724012,
		0,
		Lang.get(115446),
		42724,
		12,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724013] = {
		42724013,
		0,
		Lang.get(115447),
		42724,
		13,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724014] = {
		42724014,
		0,
		Lang.get(115448),
		42724,
		14,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42724015] = {
		42724015,
		0,
		Lang.get(115449),
		42724,
		15,
		1301,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[42725001] = {
		42725001,
		0,
		Lang.get(115450),
		42725,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		42729,
		nil,
		1,
		nil,
		1,
		nil,
		42729
	},
	[42725002] = {
		42725002,
		0,
		Lang.get(115707),
		42725,
		2,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[42725003] = {
		42725003,
		0,
		Lang.get(115452),
		42725,
		3,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42725004] = {
		42725004,
		0,
		Lang.get(115453),
		42725,
		4,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42725005] = {
		42725005,
		0,
		Lang.get(115454),
		42725,
		5,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42725006] = {
		42725006,
		0,
		Lang.get(115455),
		42725,
		6,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42725007] = {
		42725007,
		0,
		Lang.get(115456),
		42725,
		7,
		1301,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		},
		1,
		3,
		nil,
		nil,
		nil,
		42730,
		nil,
		1,
		nil,
		1,
		nil,
		42730
	},
	[42725008] = {
		42725008,
		0,
		Lang.get(115457),
		42725,
		8,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		0,
		3
	},
	[42725009] = {
		42725009,
		0,
		Lang.get(115458),
		42725,
		9,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42725010] = {
		42725010,
		3,
		Lang.get(115459),
		42725,
		10,
		605,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[42725011] = {
		42725011,
		0,
		Lang.get(115460),
		42725,
		11,
		1093,
		{
			RTResTalkAction[7]
		}
	},
	[42725012] = {
		42725012,
		0,
		Lang.get(115461),
		42725,
		12,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[6]
		}
	},
	[42725013] = {
		42725013,
		0,
		Lang.get(115462),
		42725,
		13,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726001] = {
		42726001,
		0,
		Lang.get(115463),
		42726,
		1,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		63,
		42731,
		nil,
		1,
		nil,
		1,
		nil,
		42731
	},
	[42726002] = {
		42726002,
		0,
		Lang.get(115464),
		42726,
		2,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726003] = {
		42726003,
		0,
		Lang.get(115465),
		42726,
		3,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726004] = {
		42726004,
		0,
		Lang.get(115466),
		42726,
		4,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726005] = {
		42726005,
		0,
		Lang.get(115467),
		42726,
		5,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726006] = {
		42726006,
		0,
		Lang.get(115468),
		42726,
		6,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42732,
		nil,
		1,
		nil,
		1,
		nil,
		42732
	},
	[42726007] = {
		42726007,
		0,
		Lang.get(115469),
		42726,
		7,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726008] = {
		42726008,
		0,
		Lang.get(115470),
		42726,
		8,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726009] = {
		42726009,
		0,
		Lang.get(115471),
		42726,
		9,
		1093,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726010] = {
		42726010,
		0,
		Lang.get(115472),
		42726,
		10,
		1301,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[42726011] = {
		42726011,
		0,
		Lang.get(115473),
		42726,
		11,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42727001] = {
		42727001,
		3,
		Lang.get(115474),
		42727,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		190,
		nil,
		nil,
		1,
		nil,
		1,
		nil,
		42733,
		nil,
		nil,
		1
	},
	[42727002] = {
		42727002,
		0,
		Lang.get(115475),
		42727,
		2,
		1093,
		nil,
		1
	},
	[42727003] = {
		42727003,
		0,
		Lang.get(115476),
		42727,
		3,
		1301,
		nil,
		1
	},
	[42727004] = {
		42727004,
		0,
		Lang.get(115477),
		42727,
		4,
		1093,
		nil,
		1
	},
	[42727005] = {
		42727005,
		0,
		Lang.get(115478),
		42727,
		5,
		1301,
		nil,
		1
	},
	[42727006] = {
		42727006,
		0,
		Lang.get(115479),
		42727,
		6,
		1071,
		nil,
		1
	},
	[42727007] = {
		42727007,
		0,
		Lang.get(115480),
		42727,
		7,
		1093,
		nil,
		1
	},
	[42727008] = {
		42727008,
		0,
		Lang.get(115481),
		42727,
		8,
		1301,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[42727009] = {
		42727009,
		0,
		Lang.get(115482),
		42727,
		9,
		1071,
		nil,
		1
	},
	[42727010] = {
		42727010,
		0,
		Lang.get(115483),
		42727,
		10,
		1071,
		nil,
		1
	},
	[42727011] = {
		42727011,
		0,
		Lang.get(115484),
		42727,
		11,
		1071,
		nil,
		1
	},
	[42727012] = {
		42727012,
		0,
		Lang.get(115485),
		42727,
		12,
		1093,
		nil,
		1
	},
	[42727013] = {
		42727013,
		0,
		Lang.get(115486),
		42727,
		13,
		1301,
		nil,
		1
	},
	[42727014] = {
		42727014,
		0,
		Lang.get(115487),
		42727,
		14,
		1071,
		nil,
		1
	},
	[42727015] = {
		42727015,
		0,
		Lang.get(115488),
		42727,
		15,
		1071,
		nil,
		1
	},
	[42727016] = {
		42727016,
		3,
		Lang.get(115489),
		42727,
		16,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		[22] = 1
	},
	[42727017] = {
		42727017,
		0,
		Lang.get(115490),
		42727,
		17,
		1093,
		nil,
		1
	},
	[42727018] = {
		42727018,
		0,
		Lang.get(115491),
		42727,
		18,
		1301,
		nil,
		1
	},
	[42727019] = {
		42727019,
		0,
		Lang.get(115492),
		42727,
		19,
		1028,
		{
			RTResTalkAction[14]
		},
		nil,
		nil,
		3
	},
	[42727020] = {
		42727020,
		0,
		Lang.get(115493),
		42727,
		20,
		1027,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[42727021] = {
		42727021,
		0,
		Lang.get(115494),
		42727,
		21,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[42727022] = {
		42727022,
		0,
		Lang.get(115495),
		42727,
		22,
		1028,
		{
			RTResTalkAction[14],
			RTResTalkAction[19]
		}
	},
	[42727023] = {
		42727023,
		0,
		Lang.get(115496),
		42727,
		23,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[16]
		}
	},
	[42727024] = {
		42727024,
		0,
		Lang.get(115497),
		42727,
		24,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42727025] = {
		42727025,
		0,
		Lang.get(115498),
		42727,
		25,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42728001] = {
		42728001,
		0,
		Lang.get(115499),
		42728,
		1,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42734,
		nil,
		1,
		nil,
		1,
		nil,
		42734
	},
	[42728002] = {
		42728002,
		0,
		Lang.get(115500),
		42728,
		2,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42728003] = {
		42728003,
		0,
		Lang.get(115501),
		42728,
		3,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42728004] = {
		42728004,
		0,
		Lang.get(115502),
		42728,
		4,
		1258,
		{
			RTResTalkAction[20]
		}
	},
	[42728005] = {
		42728005,
		0,
		Lang.get(115503),
		42728,
		5,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42735,
		nil,
		1,
		nil,
		1,
		nil,
		42735
	},
	[42728006] = {
		42728006,
		0,
		Lang.get(115504),
		42728,
		6,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42728007] = {
		42728007,
		0,
		Lang.get(115505),
		42728,
		7,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[21]
		}
	},
	[42728008] = {
		42728008,
		0,
		Lang.get(115506),
		42728,
		8,
		1028,
		{
			RTResTalkAction[14],
			RTResTalkAction[19]
		}
	},
	[42728009] = {
		42728009,
		0,
		Lang.get(115507),
		42728,
		9,
		1027,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[42728010] = {
		42728010,
		0,
		Lang.get(115508),
		42728,
		10,
		1028,
		{
			RTResTalkAction[14],
			RTResTalkAction[18]
		}
	},
	[42728011] = {
		42728011,
		0,
		Lang.get(115708),
		42728,
		11,
		1028,
		{
			RTResTalkAction[14]
		}
	},
	[42728012] = {
		42728012,
		0,
		Lang.get(115510),
		42728,
		12,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[16]
		}
	},
	[42728013] = {
		42728013,
		0,
		Lang.get(115511),
		42728,
		13,
		1028,
		{
			RTResTalkAction[14],
			RTResTalkAction[21]
		}
	},
	[42728014] = {
		42728014,
		0,
		Lang.get(115512),
		42728,
		14,
		1028,
		{
			RTResTalkAction[14]
		}
	},
	[42728015] = {
		42728015,
		0,
		Lang.get(115513),
		42728,
		15,
		1027,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[42729001] = {
		42729001,
		0,
		Lang.get(115514),
		42729,
		1,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		63,
		42736,
		nil,
		1,
		nil,
		1,
		nil,
		42736
	},
	[42729002] = {
		42729002,
		0,
		Lang.get(115515),
		42729,
		2,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42729003] = {
		42729003,
		0,
		Lang.get(115516),
		42729,
		3,
		1258,
		{
			RTResTalkAction[20]
		}
	},
	[42729004] = {
		42729004,
		0,
		Lang.get(115517),
		42729,
		4,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[21]
		}
	},
	[42729005] = {
		42729005,
		0,
		Lang.get(115518),
		42729,
		5,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42729006] = {
		42729006,
		0,
		Lang.get(115519),
		42729,
		6,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[42729007] = {
		42729007,
		0,
		Lang.get(115520),
		42729,
		7,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42729008] = {
		42729008,
		3,
		Lang.get(112137),
		42729,
		8,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42737,
		nil,
		1,
		nil,
		1,
		nil,
		42737,
		nil,
		nil,
		1
	},
	[42729009] = {
		42729009,
		0,
		Lang.get(115521),
		42729,
		9,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42729010] = {
		42729010,
		0,
		Lang.get(115522),
		42729,
		10,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42729011] = {
		42729011,
		0,
		Lang.get(115523),
		42729,
		11,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42729012] = {
		42729012,
		0,
		Lang.get(115524),
		42729,
		12,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42729013] = {
		42729013,
		0,
		Lang.get(115525),
		42729,
		13,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42729014] = {
		42729014,
		0,
		Lang.get(115526),
		42729,
		14,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42729015] = {
		42729015,
		0,
		Lang.get(115527),
		42729,
		15,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[42730001] = {
		42730001,
		0,
		Lang.get(115528),
		42730,
		1,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		63,
		42738,
		nil,
		1,
		nil,
		1,
		nil,
		42738
	},
	[42730002] = {
		42730002,
		0,
		Lang.get(115529),
		42730,
		2,
		1093,
		{
			RTResTalkAction[7]
		}
	},
	[42730003] = {
		42730003,
		0,
		Lang.get(115530),
		42730,
		3,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42730004] = {
		42730004,
		0,
		Lang.get(115531),
		42730,
		4,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42730005] = {
		42730005,
		0,
		Lang.get(115532),
		42730,
		5,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[21]
		}
	},
	[42730006] = {
		42730006,
		0,
		Lang.get(115533),
		42730,
		6,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42730007] = {
		42730007,
		0,
		Lang.get(115534),
		42730,
		7,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42730008] = {
		42730008,
		0,
		Lang.get(115535),
		42730,
		8,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42730009] = {
		42730009,
		0,
		Lang.get(115536),
		42730,
		9,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42730010] = {
		42730010,
		0,
		Lang.get(115537),
		42730,
		10,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[42730011] = {
		42730011,
		3,
		Lang.get(115538),
		42730,
		11,
		605,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42739,
		nil,
		1,
		nil,
		1,
		nil,
		42739,
		nil,
		nil,
		1
	},
	[42730012] = {
		42730012,
		0,
		Lang.get(115539),
		42730,
		12,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42730013] = {
		42730013,
		0,
		Lang.get(115540),
		42730,
		13,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42730014] = {
		42730014,
		0,
		Lang.get(115541),
		42730,
		14,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42730015] = {
		42730015,
		0,
		Lang.get(115542),
		42730,
		15,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42730016] = {
		42730016,
		0,
		Lang.get(115543),
		42730,
		16,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42730017] = {
		42730017,
		0,
		Lang.get(115544),
		42730,
		17,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42730018] = {
		42730018,
		0,
		Lang.get(115545),
		42730,
		18,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42731001] = {
		42731001,
		0,
		Lang.get(115546),
		42731,
		1,
		1195,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42740,
		nil,
		1,
		nil,
		1,
		nil,
		42740
	},
	[42731002] = {
		42731002,
		0,
		Lang.get(115547),
		42731,
		2,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42731003] = {
		42731003,
		0,
		Lang.get(115548),
		42731,
		3,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42731004] = {
		42731004,
		0,
		Lang.get(115549),
		42731,
		4,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42731005] = {
		42731005,
		0,
		Lang.get(115550),
		42731,
		5,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42731006] = {
		42731006,
		0,
		Lang.get(115551),
		42731,
		6,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42731007] = {
		42731007,
		0,
		Lang.get(115709),
		42731,
		7,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42731008] = {
		42731008,
		0,
		Lang.get(115553),
		42731,
		8,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42731009] = {
		42731009,
		3,
		Lang.get(115554),
		42731,
		9,
		605,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42741,
		nil,
		1,
		nil,
		1,
		nil,
		42741,
		nil,
		nil,
		1
	},
	[42731010] = {
		42731010,
		0,
		Lang.get(115555),
		42731,
		10,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42731011] = {
		42731011,
		0,
		Lang.get(115556),
		42731,
		11,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42731012] = {
		42731012,
		0,
		Lang.get(115557),
		42731,
		12,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[42731013] = {
		42731013,
		0,
		Lang.get(115558),
		42731,
		13,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42731014] = {
		42731014,
		0,
		Lang.get(115559),
		42731,
		14,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42731015] = {
		42731015,
		0,
		Lang.get(115560),
		42731,
		15,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42732001] = {
		42732001,
		0,
		Lang.get(115561),
		42732,
		1,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42742,
		nil,
		1,
		nil,
		1,
		nil,
		42742
	},
	[42732002] = {
		42732002,
		0,
		Lang.get(115562),
		42732,
		2,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42732003] = {
		42732003,
		0,
		Lang.get(115563),
		42732,
		3,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[42732004] = {
		42732004,
		0,
		Lang.get(115564),
		42732,
		4,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42732005] = {
		42732005,
		0,
		Lang.get(115565),
		42732,
		5,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42732006] = {
		42732006,
		3,
		Lang.get(115566),
		42732,
		6,
		605,
		{
			RTResTalkAction[21]
		},
		[22] = 1
	},
	[42732007] = {
		42732007,
		0,
		Lang.get(115567),
		42732,
		7,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42732008] = {
		42732008,
		0,
		Lang.get(115568),
		42732,
		8,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42732009] = {
		42732009,
		0,
		Lang.get(115569),
		42732,
		9,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42743,
		nil,
		1,
		nil,
		1,
		nil,
		42743
	},
	[42732010] = {
		42732010,
		0,
		Lang.get(115570),
		42732,
		10,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42732011] = {
		42732011,
		0,
		Lang.get(115571),
		42732,
		11,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[42732012] = {
		42732012,
		0,
		Lang.get(115572),
		42732,
		12,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42732013] = {
		42732013,
		0,
		Lang.get(115573),
		42732,
		13,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42733001] = {
		42733001,
		0,
		Lang.get(115574),
		42733,
		1,
		1195,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42744,
		nil,
		1,
		nil,
		1,
		nil,
		42744
	},
	[42733002] = {
		42733002,
		0,
		Lang.get(115575),
		42733,
		2,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42733003] = {
		42733003,
		0,
		Lang.get(115576),
		42733,
		3,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42733004] = {
		42733004,
		0,
		Lang.get(115577),
		42733,
		4,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42733005] = {
		42733005,
		0,
		Lang.get(115578),
		42733,
		5,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42733006] = {
		42733006,
		0,
		Lang.get(115579),
		42733,
		6,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42733007] = {
		42733007,
		0,
		Lang.get(115580),
		42733,
		7,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42733008] = {
		42733008,
		0,
		Lang.get(115581),
		42733,
		8,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42733009] = {
		42733009,
		0,
		Lang.get(115582),
		42733,
		9,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42733010] = {
		42733010,
		0,
		Lang.get(115583),
		42733,
		10,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42745,
		nil,
		1,
		nil,
		1,
		nil,
		42745
	},
	[42733011] = {
		42733011,
		0,
		Lang.get(115584),
		42733,
		11,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42733012] = {
		42733012,
		0,
		Lang.get(115585),
		42733,
		12,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42733013] = {
		42733013,
		0,
		Lang.get(115586),
		42733,
		13,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42733014] = {
		42733014,
		0,
		Lang.get(115587),
		42733,
		14,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42733015] = {
		42733015,
		0,
		Lang.get(115588),
		42733,
		15,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42733016] = {
		42733016,
		0,
		Lang.get(115589),
		42733,
		16,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42734001] = {
		42734001,
		0,
		Lang.get(115590),
		42734,
		1,
		1093,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42746,
		nil,
		1,
		nil,
		1,
		nil,
		42746
	},
	[42734002] = {
		42734002,
		0,
		Lang.get(115591),
		42734,
		2,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42734003] = {
		42734003,
		0,
		Lang.get(115592),
		42734,
		3,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42734004] = {
		42734004,
		0,
		Lang.get(115593),
		42734,
		4,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42734005] = {
		42734005,
		0,
		Lang.get(115594),
		42734,
		5,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42734006] = {
		42734006,
		0,
		Lang.get(115595),
		42734,
		6,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42734007] = {
		42734007,
		0,
		Lang.get(115596),
		42734,
		7,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42734008] = {
		42734008,
		0,
		Lang.get(115597),
		42734,
		8,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42734009] = {
		42734009,
		0,
		Lang.get(115598),
		42734,
		9,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42747,
		nil,
		1,
		nil,
		1,
		nil,
		42747
	},
	[42734010] = {
		42734010,
		0,
		Lang.get(115599),
		42734,
		10,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42734011] = {
		42734011,
		0,
		Lang.get(115600),
		42734,
		11,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42734012] = {
		42734012,
		0,
		Lang.get(115601),
		42734,
		12,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42734013] = {
		42734013,
		0,
		Lang.get(115602),
		42734,
		13,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42734014] = {
		42734014,
		0,
		Lang.get(115603),
		42734,
		14,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[21]
		}
	},
	[42735001] = {
		42735001,
		0,
		Lang.get(115604),
		42735,
		1,
		1195,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		63,
		42748,
		nil,
		1,
		nil,
		1,
		nil,
		42748
	},
	[42735002] = {
		42735002,
		0,
		Lang.get(115605),
		42735,
		2,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42735003] = {
		42735003,
		0,
		Lang.get(115606),
		42735,
		3,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42735004] = {
		42735004,
		0,
		Lang.get(115607),
		42735,
		4,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[21]
		}
	},
	[42735005] = {
		42735005,
		0,
		Lang.get(115608),
		42735,
		5,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[10]
		}
	},
	[42735006] = {
		42735006,
		0,
		Lang.get(115609),
		42735,
		6,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42735007] = {
		42735007,
		0,
		Lang.get(115610),
		42735,
		7,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42735008] = {
		42735008,
		0,
		Lang.get(115611),
		42735,
		8,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42735009] = {
		42735009,
		3,
		Lang.get(115612),
		42735,
		9,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42749,
		nil,
		1,
		nil,
		1,
		nil,
		42749,
		nil,
		nil,
		1
	},
	[42735010] = {
		42735010,
		0,
		Lang.get(115613),
		42735,
		10,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42735011] = {
		42735011,
		0,
		Lang.get(115614),
		42735,
		11,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[19]
		}
	},
	[42735012] = {
		42735012,
		0,
		Lang.get(115615),
		42735,
		12,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42735013] = {
		42735013,
		0,
		Lang.get(115616),
		42735,
		13,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42735014] = {
		42735014,
		0,
		Lang.get(115617),
		42735,
		14,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42735015] = {
		42735015,
		0,
		Lang.get(115618),
		42735,
		15,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42735016] = {
		42735016,
		0,
		Lang.get(115619),
		42735,
		16,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42736001] = {
		42736001,
		3,
		Lang.get(115620),
		42736,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		60,
		42750,
		nil,
		1,
		nil,
		1,
		nil,
		42750,
		nil,
		nil,
		1
	},
	[42736002] = {
		42736002,
		0,
		Lang.get(115621),
		42736,
		2,
		768,
		nil,
		1
	},
	[42736003] = {
		42736003,
		0,
		Lang.get(115622),
		42736,
		3,
		1169,
		nil,
		1
	},
	[42736004] = {
		42736004,
		0,
		Lang.get(115623),
		42736,
		4,
		1195,
		{
			RTResTalkAction[17]
		}
	},
	[42736005] = {
		42736005,
		0,
		Lang.get(115624),
		42736,
		5,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[19]
		}
	},
	[42736006] = {
		42736006,
		0,
		Lang.get(115625),
		42736,
		6,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42736007] = {
		42736007,
		0,
		Lang.get(115626),
		42736,
		7,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[42736008] = {
		42736008,
		0,
		Lang.get(115627),
		42736,
		8,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42736009] = {
		42736009,
		0,
		Lang.get(115628),
		42736,
		9,
		1169,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42751,
		nil,
		1,
		nil,
		1,
		nil,
		42751
	},
	[42736010] = {
		42736010,
		0,
		Lang.get(115629),
		42736,
		10,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[25]
		}
	},
	[42736011] = {
		42736011,
		0,
		Lang.get(115630),
		42736,
		11,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[24]
		}
	},
	[42736012] = {
		42736012,
		0,
		Lang.get(115631),
		42736,
		12,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[21]
		}
	},
	[42736013] = {
		42736013,
		0,
		Lang.get(115632),
		42736,
		13,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42736014] = {
		42736014,
		0,
		Lang.get(115633),
		42736,
		14,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[42736015] = {
		42736015,
		0,
		Lang.get(115634),
		42736,
		15,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[42736016] = {
		42736016,
		0,
		Lang.get(115635),
		42736,
		16,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[24]
		}
	},
	[42737001] = {
		42737001,
		0,
		Lang.get(115636),
		42737,
		1,
		1195,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42752,
		nil,
		1,
		nil,
		1,
		nil,
		42752
	},
	[42737002] = {
		42737002,
		0,
		Lang.get(115637),
		42737,
		2,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[42737003] = {
		42737003,
		0,
		Lang.get(115638),
		42737,
		3,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[24]
		}
	},
	[42737004] = {
		42737004,
		0,
		Lang.get(115639),
		42737,
		4,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[19]
		}
	},
	[42737005] = {
		42737005,
		0,
		Lang.get(115640),
		42737,
		5,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[25]
		}
	},
	[42737006] = {
		42737006,
		0,
		Lang.get(115641),
		42737,
		6,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[21]
		}
	},
	[42737007] = {
		42737007,
		0,
		Lang.get(115642),
		42737,
		7,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42737008] = {
		42737008,
		0,
		Lang.get(115643),
		42737,
		8,
		1301,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42753,
		nil,
		1,
		nil,
		1,
		nil,
		42753
	},
	[42737009] = {
		42737009,
		0,
		Lang.get(115644),
		42737,
		9,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[42737010] = {
		42737010,
		0,
		Lang.get(115645),
		42737,
		10,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42737011] = {
		42737011,
		0,
		Lang.get(115646),
		42737,
		11,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[25]
		}
	},
	[42737012] = {
		42737012,
		0,
		Lang.get(115647),
		42737,
		12,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42737013] = {
		42737013,
		0,
		Lang.get(115648),
		42737,
		13,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[3]
		}
	},
	[42737014] = {
		42737014,
		5,
		Lang.get(115649),
		42737,
		14,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		}
	},
	[42738001] = {
		42738001,
		3,
		Lang.get(114290),
		42738,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		42754,
		nil,
		1,
		nil,
		1,
		nil,
		42754,
		nil,
		nil,
		1
	},
	[42738002] = {
		42738002,
		0,
		Lang.get(115650),
		42738,
		2,
		677,
		{
			RTResTalkAction[26]
		}
	},
	[42738003] = {
		42738003,
		0,
		Lang.get(115651),
		42738,
		3,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[42738004] = {
		42738004,
		0,
		Lang.get(115652),
		42738,
		4,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42738005] = {
		42738005,
		0,
		Lang.get(115653),
		42738,
		5,
		677,
		{
			RTResTalkAction[26],
			RTResTalkAction[25]
		}
	},
	[42738006] = {
		42738006,
		0,
		Lang.get(115654),
		42738,
		6,
		677,
		{
			RTResTalkAction[26]
		}
	},
	[42738007] = {
		42738007,
		0,
		Lang.get(115710),
		42738,
		7,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[42738008] = {
		42738008,
		0,
		Lang.get(115656),
		42738,
		8,
		677,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42755,
		nil,
		1,
		nil,
		1,
		nil,
		42755
	},
	[42738009] = {
		42738009,
		0,
		Lang.get(115657),
		42738,
		9,
		677,
		{
			RTResTalkAction[26]
		}
	},
	[42738010] = {
		42738010,
		0,
		Lang.get(115658),
		42738,
		10,
		677,
		{
			RTResTalkAction[26]
		}
	},
	[42738011] = {
		42738011,
		0,
		Lang.get(115659),
		42738,
		11,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[27]
		}
	},
	[42738012] = {
		42738012,
		0,
		Lang.get(115711),
		42738,
		12,
		677,
		{
			RTResTalkAction[26],
			RTResTalkAction[24]
		}
	},
	[42738013] = {
		42738013,
		0,
		Lang.get(115661),
		42738,
		13,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[42738014] = {
		42738014,
		0,
		Lang.get(115662),
		42738,
		14,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[42738015] = {
		42738015,
		0,
		Lang.get(115663),
		42738,
		15,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42738016] = {
		42738016,
		0,
		Lang.get(115664),
		42738,
		16,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42739001] = {
		42739001,
		3,
		Lang.get(115665),
		42739,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		42756,
		nil,
		1,
		nil,
		1,
		nil,
		42756,
		nil,
		nil,
		1
	},
	[42739002] = {
		42739002,
		0,
		Lang.get(115666),
		42739,
		2,
		1301,
		{
			RTResTalkAction[2]
		}
	},
	[42739003] = {
		42739003,
		0,
		Lang.get(115667),
		42739,
		3,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42739004] = {
		42739004,
		0,
		Lang.get(115668),
		42739,
		4,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[10]
		}
	},
	[42739005] = {
		42739005,
		0,
		Lang.get(115669),
		42739,
		5,
		768,
		{
			RTResTalkAction[22]
		}
	},
	[42739006] = {
		42739006,
		0,
		Lang.get(115670),
		42739,
		6,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42739007] = {
		42739007,
		0,
		Lang.get(115671),
		42739,
		7,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[25]
		}
	},
	[42739008] = {
		42739008,
		0,
		Lang.get(115672),
		42739,
		8,
		768,
		{
			RTResTalkAction[22],
			RTResTalkAction[19]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42757,
		nil,
		1,
		nil,
		1,
		nil,
		42757
	},
	[42739009] = {
		42739009,
		0,
		Lang.get(115673),
		42739,
		9,
		768,
		{
			RTResTalkAction[22]
		}
	},
	[42739010] = {
		42739010,
		0,
		Lang.get(115674),
		42739,
		10,
		1169,
		{
			RTResTalkAction[23],
			RTResTalkAction[24]
		}
	},
	[42739011] = {
		42739011,
		0,
		Lang.get(115675),
		42739,
		11,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[25]
		}
	},
	[42739012] = {
		42739012,
		0,
		Lang.get(115676),
		42739,
		12,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[42739013] = {
		42739013,
		0,
		Lang.get(115677),
		42739,
		13,
		1195,
		{
			RTResTalkAction[17],
			RTResTalkAction[10]
		}
	},
	[42739014] = {
		42739014,
		0,
		Lang.get(115678),
		42739,
		14,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[19]
		}
	},
	[42740001] = {
		42740001,
		3,
		Lang.get(115679),
		42740,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		62,
		42758,
		nil,
		1,
		nil,
		1,
		nil,
		42758,
		nil,
		nil,
		1
	},
	[42740002] = {
		42740002,
		0,
		Lang.get(115680),
		42740,
		2,
		677,
		{
			RTResTalkAction[26]
		}
	},
	[42740003] = {
		42740003,
		0,
		Lang.get(115681),
		42740,
		3,
		917,
		{
			RTResTalkAction[27]
		},
		1
	},
	[42740004] = {
		42740004,
		0,
		Lang.get(115682),
		42740,
		4,
		918,
		nil,
		1
	},
	[42740005] = {
		42740005,
		0,
		Lang.get(115683),
		42740,
		5,
		1093,
		{
			RTResTalkAction[7]
		}
	},
	[42740006] = {
		42740006,
		0,
		Lang.get(115684),
		42740,
		6,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42740007] = {
		42740007,
		0,
		Lang.get(115685),
		42740,
		7,
		1258,
		{
			RTResTalkAction[20],
			RTResTalkAction[3]
		}
	},
	[42740008] = {
		42740008,
		0,
		Lang.get(115686),
		42740,
		8,
		1093,
		{
			RTResTalkAction[7],
			RTResTalkAction[21]
		}
	},
	[42740009] = {
		42740009,
		0,
		Lang.get(115687),
		42740,
		9,
		1301,
		{
			RTResTalkAction[2],
			RTResTalkAction[10]
		}
	},
	[42740010] = {
		42740010,
		3,
		Lang.get(115688),
		42740,
		10,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		42759,
		nil,
		1,
		nil,
		1,
		nil,
		42759,
		nil,
		nil,
		1
	},
	[42740011] = {
		42740011,
		0,
		Lang.get(115689),
		42740,
		11,
		1052,
		{
			RTResTalkAction[28]
		}
	},
	[42740012] = {
		42740012,
		0,
		Lang.get(115690),
		42740,
		12,
		1052,
		{
			RTResTalkAction[28]
		}
	},
	[42740013] = {
		42740013,
		0,
		Lang.get(115691),
		42740,
		13,
		1052,
		{
			RTResTalkAction[28]
		}
	},
	[42740014] = {
		42740014,
		0,
		Lang.get(115692),
		42740,
		14,
		1052,
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
