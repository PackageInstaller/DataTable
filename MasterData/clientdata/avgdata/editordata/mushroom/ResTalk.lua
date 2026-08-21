-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\mushroom\\ResTalk.lua

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
	[2] = 1023
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1027
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1023
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1027
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1028
}
RTResTalkAction[6] = {
	[1] = 1
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1028
}
RTResTalkAction[8] = {
	[1] = 0
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 257
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 261
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 257
}
RTResTalkAction[12] = {
	[1] = 1,
	[2] = 46
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 56
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 46
}
RTResTalkAction[15] = {
	[1] = 1,
	[2] = 55
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 56
}
RTResTalkAction[17] = {
	[1] = 0,
	[2] = 55
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 261
}
RTResTalkAction[19] = {
	[1] = 2,
	[2] = 1023
}
RTResTalkAction[20] = {
	[1] = 3,
	[2] = 261
}
RTResTalkAction[21] = {
	2,
	1023,
	nil,
	nil,
	2
}
RTResTalkAction[22] = {
	1,
	261,
	nil,
	nil,
	0
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 278
}
RTResTalkAction[24] = {
	1,
	244,
	nil,
	nil,
	1
}
RTResTalkAction[25] = {
	[1] = 0,
	[2] = 278
}
RTResTalkAction[26] = {
	1,
	278,
	nil,
	nil,
	0
}
RTResTalkAction[27] = {
	[1] = 0,
	[2] = 244
}
RTResTalkAction[28] = {
	1,
	244,
	nil,
	nil,
	0
}
RTResTalkAction[29] = {
	1,
	244,
	nil,
	nil,
	2
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 244
}
RTResTalkAction[31] = {
	[1] = 1,
	[2] = 347
}
RTResTalkAction[32] = {
	[1] = 0,
	[2] = 347
}
RTResTalkAction[33] = {
	[1] = 1,
	[2] = 300
}
RTResTalkAction[34] = {
	[1] = 0,
	[2] = 300
}
RTResTalkAction[35] = {
	1,
	1023,
	nil,
	nil,
	2
}
RTResTalkAction[36] = {
	1,
	1027,
	nil,
	nil,
	0
}
RTResTalkAction[37] = {
	1,
	1023,
	nil,
	nil,
	0
}
RTResTalkAction[38] = {
	[1] = 1,
	[2] = 1025
}
RTResTalkAction[39] = {
	[1] = 0,
	[2] = 1025
}
RTResTalkAction[40] = {
	[1] = 1,
	[2] = 1024
}
RTResTalkAction[41] = {
	[1] = 2,
	[2] = 1024
}
RTResTalkAction[42] = {
	[1] = 3,
	[2] = 1025
}
RTResTalkAction[43] = {
	[1] = 3,
	[2] = 1026
}
RTResTalkAction[44] = {
	[1] = 0,
	[2] = 1026
}
RTResTalkAction[45] = {
	[1] = 3,
	[2] = 1027
}
RTResTalkAction[46] = {
	[1] = 0,
	[2] = 1024
}
RTResTalkAction[47] = {
	[1] = 1,
	[2] = 1026
}
RTResTalkAction[48] = {
	[1] = 1,
	[2] = 386
}
RTResTalkAction[49] = {
	[1] = 1,
	[2] = 765
}
RTResTalkAction[50] = {
	[1] = 0,
	[2] = 386
}
RTResTalkAction[51] = {
	[1] = 0,
	[2] = 765
}
RTResTalkAction[52] = {
	[1] = 1,
	[2] = 230
}
RTResTalkAction[53] = {
	[1] = 0,
	[2] = 230
}
RTResTalkAction[54] = {
	[1] = 1,
	[2] = 419
}
RTResTalkAction[55] = {
	[1] = 1,
	[2] = 109
}
RTResTalkAction[56] = {
	[1] = 0,
	[2] = 109
}

local Data = {
	[31655001] = {
		31655001,
		0,
		Lang.get(77404),
		31655,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31656,
		nil,
		nil,
		nil,
		nil,
		nil,
		31656
	},
	[31655002] = {
		31655002,
		7,
		"90",
		31655,
		2,
		1023
	},
	[31655003] = {
		31655003,
		0,
		Lang.get(77405),
		31655,
		3,
		1023,
		nil,
		1
	},
	[31655004] = {
		31655004,
		0,
		Lang.get(77406),
		31655,
		4,
		1023,
		nil,
		1
	},
	[31655005] = {
		31655005,
		3,
		Lang.get(77407),
		31655,
		5,
		[22] = 1
	},
	[31655006] = {
		31655006,
		0,
		Lang.get(77408),
		31655,
		6,
		1023,
		nil,
		1
	},
	[31655007] = {
		31655007,
		0,
		Lang.get(77409),
		31655,
		7,
		1023,
		nil,
		1
	},
	[31655008] = {
		31655008,
		3,
		Lang.get(77410),
		31655,
		8,
		[22] = 1
	},
	[31655009] = {
		31655009,
		0,
		Lang.get(77411),
		31655,
		9,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31655010] = {
		31655010,
		0,
		Lang.get(77412),
		31655,
		10,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31655011] = {
		31655011,
		0,
		Lang.get(77413),
		31655,
		11,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31655012] = {
		31655012,
		0,
		Lang.get(77414),
		31655,
		12,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31655013] = {
		31655013,
		0,
		Lang.get(77415),
		31655,
		13,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31655014] = {
		31655014,
		0,
		Lang.get(77416),
		31655,
		14,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31655015] = {
		31655015,
		0,
		Lang.get(77417),
		31655,
		15,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31655016] = {
		31655016,
		0,
		Lang.get(77418),
		31655,
		16,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31655017] = {
		31655017,
		0,
		Lang.get(77419),
		31655,
		17,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31655018] = {
		31655018,
		0,
		Lang.get(77420),
		31655,
		18,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31655019] = {
		31655019,
		0,
		Lang.get(77421),
		31655,
		19,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31655020] = {
		31655020,
		0,
		Lang.get(77422),
		31655,
		20,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31655021] = {
		31655021,
		0,
		Lang.get(77423),
		31655,
		21,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31655022] = {
		31655022,
		0,
		Lang.get(77424),
		31655,
		22,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31655023] = {
		31655023,
		0,
		Lang.get(77425),
		31655,
		23,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31655024] = {
		31655024,
		0,
		Lang.get(77426),
		31655,
		24,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[31655025] = {
		31655025,
		3,
		Lang.get(77407),
		31655,
		25,
		[22] = 1,
		[7] = {
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[31655026] = {
		31655026,
		0,
		Lang.get(77427),
		31655,
		26,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[8]
		}
	},
	[31655027] = {
		31655027,
		0,
		Lang.get(77428),
		31655,
		27,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31655028] = {
		31655028,
		0,
		Lang.get(77429),
		31655,
		28,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[31655029] = {
		31655029,
		0,
		Lang.get(77430),
		31655,
		29,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31655030] = {
		31655030,
		0,
		Lang.get(77431),
		31655,
		30,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[4]
		}
	},
	[31655031] = {
		31655031,
		0,
		Lang.get(77432),
		31655,
		31,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31656001] = {
		31656001,
		0,
		Lang.get(77433),
		31656,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31656,
		nil,
		nil,
		nil,
		nil,
		nil,
		31656
	},
	[31656002] = {
		31656002,
		0,
		Lang.get(77434),
		31656,
		2,
		1023,
		nil,
		1
	},
	[31656003] = {
		31656003,
		0,
		Lang.get(77435),
		31656,
		3,
		1027,
		nil,
		1
	},
	[31656004] = {
		31656004,
		0,
		Lang.get(77436),
		31656,
		4,
		1023,
		nil,
		1
	},
	[31656005] = {
		31656005,
		0,
		Lang.get(77437),
		31656,
		5,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31656006] = {
		31656006,
		0,
		Lang.get(77438),
		31656,
		6,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656007] = {
		31656007,
		0,
		Lang.get(77439),
		31656,
		7,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656008] = {
		31656008,
		0,
		Lang.get(77440),
		31656,
		8,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31656009] = {
		31656009,
		0,
		Lang.get(77441),
		31656,
		9,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656010] = {
		31656010,
		0,
		Lang.get(77442),
		31656,
		10,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656011] = {
		31656011,
		0,
		Lang.get(77443),
		31656,
		11,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656012] = {
		31656012,
		0,
		Lang.get(77444),
		31656,
		12,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656013] = {
		31656013,
		0,
		Lang.get(77445),
		31656,
		13,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31656014] = {
		31656014,
		0,
		Lang.get(77446),
		31656,
		14,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656015] = {
		31656015,
		0,
		Lang.get(77447),
		31656,
		15,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656016] = {
		31656016,
		0,
		Lang.get(77448),
		31656,
		16,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656017] = {
		31656017,
		0,
		Lang.get(77449),
		31656,
		17,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656018] = {
		31656018,
		0,
		Lang.get(77450),
		31656,
		18,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31656019] = {
		31656019,
		0,
		Lang.get(77451),
		31656,
		19,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31656020] = {
		31656020,
		0,
		Lang.get(77452),
		31656,
		20,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31657001] = {
		31657001,
		0,
		Lang.get(77453),
		31657,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31657,
		nil,
		nil,
		nil,
		nil,
		nil,
		31657
	},
	[31657002] = {
		31657002,
		0,
		Lang.get(77454),
		31657,
		2,
		261,
		nil,
		1
	},
	[31657003] = {
		31657003,
		0,
		Lang.get(77455),
		31657,
		3,
		257,
		nil,
		1
	},
	[31657004] = {
		31657004,
		0,
		Lang.get(77456),
		31657,
		4,
		261,
		nil,
		1
	},
	[31657005] = {
		31657005,
		0,
		Lang.get(77457),
		31657,
		5,
		257,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[31657006] = {
		31657006,
		0,
		Lang.get(77458),
		31657,
		6,
		257,
		{
			RTResTalkAction[9]
		}
	},
	[31657007] = {
		31657007,
		0,
		Lang.get(77459),
		31657,
		7,
		261,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[31658001] = {
		31658001,
		0,
		Lang.get(77460),
		31658,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31658,
		nil,
		nil,
		nil,
		nil,
		nil,
		31658
	},
	[31658002] = {
		31658002,
		0,
		Lang.get(77461),
		31658,
		2,
		1023,
		nil,
		1
	},
	[31658003] = {
		31658003,
		0,
		Lang.get(77462),
		31658,
		3,
		1023,
		nil,
		1
	},
	[31658004] = {
		31658004,
		0,
		Lang.get(77463),
		31658,
		4,
		1023,
		nil,
		1
	},
	[31658005] = {
		31658005,
		0,
		Lang.get(77464),
		31658,
		5,
		46,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		3
	},
	[31658006] = {
		31658006,
		0,
		Lang.get(77465),
		31658,
		6,
		56,
		{
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[31658007] = {
		31658007,
		0,
		Lang.get(77466),
		31658,
		7,
		55,
		{
			RTResTalkAction[15],
			RTResTalkAction[16]
		}
	},
	[31658008] = {
		31658008,
		0,
		Lang.get(77467),
		31658,
		8,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[17]
		}
	},
	[31658009] = {
		31658009,
		0,
		Lang.get(77468),
		31658,
		9,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31658010] = {
		31658010,
		0,
		Lang.get(77469),
		31658,
		10,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31658011] = {
		31658011,
		0,
		Lang.get(77470),
		31658,
		11,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31658012] = {
		31658012,
		0,
		Lang.get(77471),
		31658,
		12,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31658013] = {
		31658013,
		0,
		Lang.get(77472),
		31658,
		13,
		261,
		{
			RTResTalkAction[10],
			RTResTalkAction[3]
		}
	},
	[31658014] = {
		31658014,
		0,
		Lang.get(77473),
		31658,
		14,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[31659001] = {
		31659001,
		0,
		Lang.get(77474),
		31659,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31657,
		nil,
		nil,
		nil,
		nil,
		nil,
		31657
	},
	[31659002] = {
		31659002,
		0,
		Lang.get(77475),
		31659,
		2,
		261,
		nil,
		1
	},
	[31659003] = {
		31659003,
		0,
		Lang.get(78290),
		31659,
		3,
		257,
		nil,
		1
	},
	[31659004] = {
		31659004,
		0,
		Lang.get(19967),
		31659,
		4,
		261,
		nil,
		1
	},
	[31660001] = {
		31660001,
		0,
		Lang.get(77477),
		31660,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31660,
		nil,
		nil,
		nil,
		nil,
		nil,
		31660
	},
	[31660002] = {
		31660002,
		0,
		Lang.get(77478),
		31660,
		2,
		257,
		nil,
		1
	},
	[31660003] = {
		31660003,
		0,
		Lang.get(77479),
		31660,
		3,
		1023,
		nil,
		1
	},
	[31661001] = {
		31661001,
		0,
		Lang.get(77480),
		31661,
		1,
		1023,
		nil,
		1,
		2,
		nil,
		nil,
		nil,
		31660,
		nil,
		nil,
		nil,
		nil,
		nil,
		31660
	},
	[31661002] = {
		31661002,
		0,
		Lang.get(77481),
		31661,
		2,
		261,
		nil,
		1,
		0
	},
	[31661003] = {
		31661003,
		0,
		Lang.get(77482),
		31661,
		3,
		1023,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		},
		nil,
		nil,
		3
	},
	[31661004] = {
		31661004,
		0,
		Lang.get(77483),
		31661,
		4,
		261,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[31661005] = {
		31661005,
		0,
		Lang.get(77484),
		31661,
		5,
		1023,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[31661006] = {
		31661006,
		0,
		Lang.get(77485),
		31661,
		6,
		261,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[31661007] = {
		31661007,
		0,
		Lang.get(77486),
		31661,
		7,
		1023,
		{
			RTResTalkAction[21],
			RTResTalkAction[20]
		}
	},
	[31661008] = {
		31661008,
		0,
		Lang.get(79240),
		31661,
		8,
		261,
		{
			RTResTalkAction[22],
			RTResTalkAction[3]
		}
	},
	[31661009] = {
		31661009,
		0,
		Lang.get(77488),
		31661,
		9,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[31661010] = {
		31661010,
		0,
		Lang.get(77489),
		31661,
		10,
		261,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[31661011] = {
		31661011,
		0,
		Lang.get(77490),
		31661,
		11,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[31661012] = {
		31661012,
		0,
		Lang.get(77491),
		31661,
		12,
		261,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		}
	},
	[31661013] = {
		31661013,
		0,
		Lang.get(77492),
		31661,
		13,
		1023,
		{
			RTResTalkAction[18]
		},
		1,
		nil,
		nil,
		nil,
		62,
		31656,
		nil,
		nil,
		nil,
		nil,
		nil,
		31656
	},
	[31661014] = {
		31661014,
		0,
		Lang.get(77493),
		31661,
		14,
		1027,
		nil,
		1
	},
	[31661015] = {
		31661015,
		0,
		Lang.get(77494),
		31661,
		15,
		1023,
		nil,
		1
	},
	[31661016] = {
		31661016,
		0,
		Lang.get(77495),
		31661,
		16,
		1027,
		nil,
		1
	},
	[31661017] = {
		31661017,
		0,
		Lang.get(77496),
		31661,
		17,
		1023,
		nil,
		1
	},
	[31661018] = {
		31661018,
		0,
		Lang.get(77497),
		31661,
		18,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31661019] = {
		31661019,
		0,
		Lang.get(77498),
		31661,
		19,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31661020] = {
		31661020,
		0,
		Lang.get(77499),
		31661,
		20,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31661021] = {
		31661021,
		0,
		Lang.get(77500),
		31661,
		21,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31662001] = {
		31662001,
		0,
		Lang.get(77501),
		31662,
		1,
		278,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31662,
		nil,
		nil,
		nil,
		nil,
		nil,
		31662
	},
	[31662002] = {
		31662002,
		7,
		"91",
		31662,
		2,
		278
	},
	[31662003] = {
		31662003,
		0,
		Lang.get(77502),
		31662,
		3,
		244,
		nil,
		1
	},
	[31662004] = {
		31662004,
		0,
		Lang.get(77503),
		31662,
		4,
		278,
		nil,
		1
	},
	[31662005] = {
		31662005,
		0,
		Lang.get(77504),
		31662,
		5,
		278,
		nil,
		1
	},
	[31662006] = {
		31662006,
		0,
		Lang.get(77505),
		31662,
		6,
		278,
		nil,
		1
	},
	[31662007] = {
		31662007,
		0,
		Lang.get(77506),
		31662,
		7,
		244,
		nil,
		1
	},
	[31662008] = {
		31662008,
		0,
		Lang.get(77507),
		31662,
		8,
		278,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[31662009] = {
		31662009,
		0,
		Lang.get(77508),
		31662,
		9,
		278,
		{
			RTResTalkAction[23]
		}
	},
	[31662010] = {
		31662010,
		0,
		Lang.get(77509),
		31662,
		10,
		244,
		{
			RTResTalkAction[24],
			RTResTalkAction[25]
		}
	},
	[31662011] = {
		31662011,
		0,
		Lang.get(77510),
		31662,
		11,
		278,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[31662012] = {
		31662012,
		0,
		Lang.get(77511),
		31662,
		12,
		244,
		{
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[31662013] = {
		31662013,
		0,
		Lang.get(77512),
		31662,
		13,
		278,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[31662014] = {
		31662014,
		0,
		Lang.get(77513),
		31662,
		14,
		244,
		{
			RTResTalkAction[29],
			RTResTalkAction[25]
		}
	},
	[31662015] = {
		31662015,
		0,
		Lang.get(77514),
		31662,
		15,
		278,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[31662016] = {
		31662016,
		0,
		Lang.get(77515),
		31662,
		16,
		278,
		{
			RTResTalkAction[26]
		}
	},
	[31662017] = {
		31662017,
		0,
		Lang.get(77516),
		31662,
		17,
		743,
		{
			RTResTalkAction[25]
		}
	},
	[31662018] = {
		31662018,
		0,
		Lang.get(77517),
		31662,
		18,
		244,
		{
			RTResTalkAction[28]
		}
	},
	[31662019] = {
		31662019,
		0,
		Lang.get(77518),
		31662,
		19,
		278,
		{
			RTResTalkAction[26],
			RTResTalkAction[27]
		}
	},
	[31662020] = {
		31662020,
		0,
		Lang.get(77519),
		31662,
		20,
		244,
		{
			RTResTalkAction[28],
			RTResTalkAction[25]
		}
	},
	[31662021] = {
		31662021,
		0,
		Lang.get(77520),
		31662,
		21,
		743,
		{
			RTResTalkAction[27]
		}
	},
	[31662022] = {
		31662022,
		0,
		Lang.get(77521),
		31662,
		22,
		278,
		{
			RTResTalkAction[23]
		}
	},
	[31663001] = {
		31663001,
		0,
		Lang.get(77522),
		31663,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31663,
		nil,
		nil,
		nil,
		nil,
		nil,
		31663
	},
	[31663002] = {
		31663002,
		0,
		Lang.get(77523),
		31663,
		2,
		1023,
		nil,
		1
	},
	[31663003] = {
		31663003,
		0,
		Lang.get(77524),
		31663,
		3,
		743
	},
	[31663004] = {
		31663004,
		0,
		Lang.get(77525),
		31663,
		4,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31663005] = {
		31663005,
		0,
		Lang.get(77526),
		31663,
		5,
		743,
		{
			RTResTalkAction[3]
		}
	},
	[31664001] = {
		31664001,
		0,
		Lang.get(77527),
		31664,
		1,
		244,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31663,
		nil,
		nil,
		nil,
		nil,
		nil,
		31663
	},
	[31664002] = {
		31664002,
		0,
		Lang.get(77528),
		31664,
		2,
		278,
		nil,
		1
	},
	[31664003] = {
		31664003,
		0,
		Lang.get(77529),
		31664,
		3,
		1023,
		nil,
		1
	},
	[31664004] = {
		31664004,
		0,
		Lang.get(77530),
		31664,
		4,
		1023,
		nil,
		1
	},
	[31664005] = {
		31664005,
		0,
		Lang.get(77531),
		31664,
		5,
		244,
		nil,
		1
	},
	[31664006] = {
		31664006,
		0,
		Lang.get(77532),
		31664,
		6,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31664007] = {
		31664007,
		0,
		Lang.get(77533),
		31664,
		7,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[31664008] = {
		31664008,
		0,
		Lang.get(77534),
		31664,
		8,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[25]
		}
	},
	[31664009] = {
		31664009,
		0,
		Lang.get(77535),
		31664,
		9,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[31664010] = {
		31664010,
		0,
		Lang.get(77536),
		31664,
		10,
		278,
		{
			RTResTalkAction[23]
		}
	},
	[31664011] = {
		31664011,
		0,
		Lang.get(77537),
		31664,
		11,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[25]
		}
	},
	[31664012] = {
		31664012,
		0,
		Lang.get(77538),
		31664,
		12,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[3]
		}
	},
	[31664013] = {
		31664013,
		0,
		Lang.get(77539),
		31664,
		13,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[25]
		}
	},
	[31664014] = {
		31664014,
		0,
		Lang.get(77540),
		31664,
		14,
		743,
		{
			RTResTalkAction[3]
		}
	},
	[31665001] = {
		31665001,
		0,
		Lang.get(77541),
		31665,
		1,
		278,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31665,
		nil,
		nil,
		nil,
		nil,
		nil,
		31665
	},
	[31665002] = {
		31665002,
		0,
		Lang.get(77542),
		31665,
		2,
		244,
		nil,
		1
	},
	[31665003] = {
		31665003,
		0,
		Lang.get(77543),
		31665,
		3,
		278,
		nil,
		1
	},
	[31665004] = {
		31665004,
		0,
		Lang.get(77544),
		31665,
		4,
		244,
		nil,
		1
	},
	[31665005] = {
		31665005,
		0,
		Lang.get(77545),
		31665,
		5,
		278,
		{
			RTResTalkAction[23]
		},
		nil,
		nil,
		3
	},
	[31665006] = {
		31665006,
		0,
		Lang.get(77546),
		31665,
		6,
		244,
		{
			RTResTalkAction[30],
			RTResTalkAction[25]
		}
	},
	[31665007] = {
		31665007,
		0,
		Lang.get(77547),
		31665,
		7,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[31666001] = {
		31666001,
		3,
		Lang.get(77548),
		31666,
		1,
		278,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		31656,
		[19] = 31656,
		[22] = 1
	},
	[31666002] = {
		31666002,
		0,
		Lang.get(77549),
		31666,
		2,
		1027,
		nil,
		1
	},
	[31666003] = {
		31666003,
		0,
		Lang.get(77550),
		31666,
		3,
		1027,
		nil,
		1
	},
	[31666004] = {
		31666004,
		0,
		Lang.get(77551),
		31666,
		4,
		1023,
		nil,
		1
	},
	[31666005] = {
		31666005,
		0,
		Lang.get(77552),
		31666,
		5,
		1023,
		nil,
		1
	},
	[31666006] = {
		31666006,
		0,
		Lang.get(77553),
		31666,
		6,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31666007] = {
		31666007,
		0,
		Lang.get(77554),
		31666,
		7,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31666008] = {
		31666008,
		0,
		Lang.get(77555),
		31666,
		8,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31666009] = {
		31666009,
		0,
		Lang.get(77556),
		31666,
		9,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31666010] = {
		31666010,
		0,
		Lang.get(77557),
		31666,
		10,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[31666011] = {
		31666011,
		0,
		Lang.get(77558),
		31666,
		11,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31667001] = {
		31667001,
		0,
		Lang.get(77559),
		31667,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31667,
		nil,
		nil,
		nil,
		nil,
		nil,
		31667
	},
	[31667002] = {
		31667002,
		0,
		Lang.get(77560),
		31667,
		2,
		347,
		nil,
		1
	},
	[31667003] = {
		31667003,
		0,
		Lang.get(77561),
		31667,
		3,
		1023,
		nil,
		1,
		2
	},
	[31667004] = {
		31667004,
		0,
		Lang.get(77562),
		31667,
		4,
		347,
		nil,
		1,
		0
	},
	[31667005] = {
		31667005,
		0,
		Lang.get(77563),
		31667,
		5,
		1023,
		nil,
		1,
		0
	},
	[31667006] = {
		31667006,
		0,
		Lang.get(77564),
		31667,
		6,
		347,
		{
			RTResTalkAction[31]
		},
		nil,
		nil,
		3
	},
	[31667007] = {
		31667007,
		0,
		Lang.get(77565),
		31667,
		7,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[32]
		}
	},
	[31667008] = {
		31667008,
		0,
		Lang.get(77566),
		31667,
		8,
		347,
		{
			RTResTalkAction[31],
			RTResTalkAction[3]
		}
	},
	[31667009] = {
		31667009,
		0,
		Lang.get(77567),
		31667,
		9,
		347,
		{
			RTResTalkAction[31]
		}
	},
	[31668001] = {
		31668001,
		0,
		Lang.get(77568),
		31668,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31668,
		nil,
		nil,
		nil,
		nil,
		nil,
		31668
	},
	[31668002] = {
		31668002,
		4,
		nil,
		31668,
		2,
		257,
		nil,
		1,
		[29] = {
			{
				id = 31668003,
				branch_content = Lang.get(54166)
			},
			{
				id = 31668003,
				branch_content = Lang.get(77569)
			}
		}
	},
	[31668003] = {
		31668003,
		0,
		Lang.get(77570),
		31668,
		3,
		257,
		nil,
		1
	},
	[31668004] = {
		31668004,
		0,
		Lang.get(77571),
		31668,
		4,
		300
	},
	[31668005] = {
		31668005,
		0,
		Lang.get(77572),
		31668,
		5,
		257,
		nil,
		1
	},
	[31668006] = {
		31668006,
		3,
		Lang.get(60344),
		31668,
		6,
		605,
		[22] = 1
	},
	[31668007] = {
		31668007,
		0,
		Lang.get(77573),
		31668,
		7,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[31668008] = {
		31668008,
		0,
		Lang.get(26238),
		31668,
		8,
		244,
		{
			RTResTalkAction[30],
			RTResTalkAction[34]
		},
		nil,
		nil,
		3
	},
	[31668009] = {
		31668009,
		0,
		Lang.get(77574),
		31668,
		9,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[31668010] = {
		31668010,
		0,
		Lang.get(77575),
		31668,
		10,
		300,
		{
			RTResTalkAction[33],
			RTResTalkAction[25]
		}
	},
	[31668011] = {
		31668011,
		0,
		Lang.get(77576),
		31668,
		11,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[34]
		}
	},
	[31668012] = {
		31668012,
		0,
		Lang.get(77577),
		31668,
		12,
		244,
		{
			RTResTalkAction[30],
			RTResTalkAction[25]
		}
	},
	[31668013] = {
		31668013,
		0,
		Lang.get(77578),
		31668,
		13,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[27]
		}
	},
	[31668014] = {
		31668014,
		0,
		Lang.get(77579),
		31668,
		14,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[25]
		}
	},
	[31668015] = {
		31668015,
		0,
		Lang.get(77580),
		31668,
		15,
		300,
		{
			RTResTalkAction[33],
			RTResTalkAction[11]
		}
	},
	[31668016] = {
		31668016,
		3,
		Lang.get(77581),
		31668,
		16,
		300,
		{
			RTResTalkAction[34]
		},
		[22] = 1
	},
	[31668017] = {
		31668017,
		0,
		Lang.get(77582),
		31668,
		17,
		278,
		{
			RTResTalkAction[23]
		}
	},
	[31668018] = {
		31668018,
		0,
		Lang.get(77583),
		31668,
		18,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[25]
		}
	},
	[31668019] = {
		31668019,
		0,
		Lang.get(77584),
		31668,
		19,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[11]
		}
	},
	[31668020] = {
		31668020,
		0,
		Lang.get(77585),
		31668,
		20,
		244,
		{
			RTResTalkAction[30],
			RTResTalkAction[7]
		}
	},
	[31668021] = {
		31668021,
		0,
		Lang.get(77586),
		31668,
		21,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[27]
		}
	},
	[31668022] = {
		31668022,
		4,
		nil,
		31668,
		22,
		1027,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 31668023,
				branch_content = Lang.get(77587)
			},
			{
				id = 31668023,
				branch_content = Lang.get(77588)
			}
		}
	},
	[31668023] = {
		31668023,
		0,
		Lang.get(77589),
		31668,
		23,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[4]
		}
	},
	[31668024] = {
		31668024,
		0,
		Lang.get(77590),
		31668,
		24,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31668025] = {
		31668025,
		0,
		Lang.get(77591),
		31668,
		25,
		244,
		{
			RTResTalkAction[30],
			RTResTalkAction[4]
		}
	},
	[31668026] = {
		31668026,
		0,
		Lang.get(77592),
		31668,
		26,
		300,
		{
			RTResTalkAction[27]
		}
	},
	[31670001] = {
		31670001,
		0,
		Lang.get(77593),
		31670,
		1,
		1012,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31670,
		nil,
		nil,
		nil,
		nil,
		nil,
		31670
	},
	[31670002] = {
		31670002,
		0,
		Lang.get(77594),
		31670,
		2,
		1023,
		nil,
		1
	},
	[31670003] = {
		31670003,
		0,
		Lang.get(77595),
		31670,
		3,
		1012,
		nil,
		1
	},
	[31670004] = {
		31670004,
		0,
		Lang.get(77596),
		31670,
		4,
		1023,
		nil,
		1
	},
	[31670005] = {
		31670005,
		0,
		Lang.get(77597),
		31670,
		5,
		1023,
		nil,
		1
	},
	[31670006] = {
		31670006,
		0,
		Lang.get(77598),
		31670,
		6,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31670007] = {
		31670007,
		0,
		Lang.get(77599),
		31670,
		7,
		1023,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[31670008] = {
		31670008,
		0,
		Lang.get(77600),
		31670,
		8,
		1023,
		{
			RTResTalkAction[35]
		}
	},
	[31670009] = {
		31670009,
		0,
		Lang.get(77601),
		31670,
		9,
		1027,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[31670010] = {
		31670010,
		0,
		Lang.get(77602),
		31670,
		10,
		1023,
		{
			RTResTalkAction[35],
			RTResTalkAction[4]
		}
	},
	[31670011] = {
		31670011,
		0,
		Lang.get(77603),
		31670,
		11,
		1027,
		{
			RTResTalkAction[36],
			RTResTalkAction[3]
		}
	},
	[31670012] = {
		31670012,
		0,
		Lang.get(77604),
		31670,
		12,
		1023,
		{
			RTResTalkAction[37],
			RTResTalkAction[4]
		}
	},
	[31670013] = {
		31670013,
		0,
		Lang.get(77605),
		31670,
		13,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31670014] = {
		31670014,
		0,
		Lang.get(77606),
		31670,
		14,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31670015] = {
		31670015,
		0,
		Lang.get(77607),
		31670,
		15,
		1023,
		{
			RTResTalkAction[37],
			RTResTalkAction[4]
		}
	},
	[31670016] = {
		31670016,
		0,
		Lang.get(77608),
		31670,
		16,
		1023,
		{
			RTResTalkAction[1]
		}
	},
	[31670017] = {
		31670017,
		0,
		Lang.get(77609),
		31670,
		17,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31670018] = {
		31670018,
		0,
		Lang.get(77610),
		31670,
		18,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31670019] = {
		31670019,
		0,
		Lang.get(77611),
		31670,
		19,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31670020] = {
		31670020,
		0,
		Lang.get(77612),
		31670,
		20,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31671001] = {
		31671001,
		0,
		Lang.get(77613),
		31671,
		1,
		1027,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31671,
		nil,
		nil,
		nil,
		nil,
		nil,
		31671
	},
	[31671002] = {
		31671002,
		0,
		Lang.get(77614),
		31671,
		2,
		1023,
		nil,
		1
	},
	[31671003] = {
		31671003,
		0,
		Lang.get(77615),
		31671,
		3,
		1027,
		nil,
		1
	},
	[31671004] = {
		31671004,
		0,
		Lang.get(77616),
		31671,
		4,
		1023,
		nil,
		1
	},
	[31671005] = {
		31671005,
		0,
		Lang.get(77617),
		31671,
		5,
		1027,
		nil,
		1
	},
	[31671006] = {
		31671006,
		0,
		Lang.get(77618),
		31671,
		6,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31671007] = {
		31671007,
		0,
		Lang.get(77619),
		31671,
		7,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31671008] = {
		31671008,
		0,
		Lang.get(77620),
		31671,
		8,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31671009] = {
		31671009,
		0,
		Lang.get(77621),
		31671,
		9,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31671010] = {
		31671010,
		3,
		Lang.get(77622),
		31671,
		10,
		1027,
		{
			RTResTalkAction[4]
		},
		[22] = 1
	},
	[31671011] = {
		31671011,
		0,
		Lang.get(77623),
		31671,
		11,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31671012] = {
		31671012,
		0,
		Lang.get(77624),
		31671,
		12,
		1025,
		{
			RTResTalkAction[38],
			RTResTalkAction[4]
		}
	},
	[31671013] = {
		31671013,
		0,
		Lang.get(77625),
		31671,
		13,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[39]
		}
	},
	[31671014] = {
		31671014,
		0,
		Lang.get(77626),
		31671,
		14,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31671015] = {
		31671015,
		0,
		Lang.get(77627),
		31671,
		15,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31671016] = {
		31671016,
		0,
		Lang.get(77628),
		31671,
		16,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31671017] = {
		31671017,
		0,
		Lang.get(77629),
		31671,
		17,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31671018] = {
		31671018,
		0,
		Lang.get(77630),
		31671,
		18,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[31671019] = {
		31671019,
		0,
		Lang.get(77631),
		31671,
		19,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31672001] = {
		31672001,
		0,
		Lang.get(77632),
		31672,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31672,
		nil,
		nil,
		nil,
		nil,
		nil,
		31672
	},
	[31672002] = {
		31672002,
		0,
		Lang.get(77633),
		31672,
		2,
		1023,
		nil,
		1
	},
	[31672003] = {
		31672003,
		0,
		Lang.get(77634),
		31672,
		3,
		1023,
		nil,
		1
	},
	[31672004] = {
		31672004,
		0,
		Lang.get(77635),
		31672,
		4,
		1025,
		{
			RTResTalkAction[38]
		},
		nil,
		nil,
		3
	},
	[31672005] = {
		31672005,
		0,
		Lang.get(77636),
		31672,
		5,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[39]
		}
	},
	[31672006] = {
		31672006,
		0,
		Lang.get(77637),
		31672,
		6,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[31673001] = {
		31673001,
		0,
		Lang.get(77638),
		31673,
		1,
		1025,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31673,
		nil,
		nil,
		nil,
		nil,
		nil,
		31673
	},
	[31673002] = {
		31673002,
		0,
		Lang.get(77639),
		31673,
		2,
		1027,
		nil,
		1
	},
	[31673003] = {
		31673003,
		0,
		Lang.get(77640),
		31673,
		3,
		1024,
		nil,
		1
	},
	[31673004] = {
		31673004,
		0,
		Lang.get(77641),
		31673,
		4,
		1025,
		nil,
		1
	},
	[31673005] = {
		31673005,
		0,
		Lang.get(77642),
		31673,
		5,
		1024,
		nil,
		1
	},
	[31673006] = {
		31673006,
		0,
		Lang.get(77643),
		31673,
		6,
		1025,
		nil,
		1
	},
	[31673007] = {
		31673007,
		0,
		Lang.get(77644),
		31673,
		7,
		1026,
		nil,
		1
	},
	[31673008] = {
		31673008,
		0,
		Lang.get(77645),
		31673,
		8,
		1024,
		nil,
		1
	},
	[31673009] = {
		31673009,
		0,
		Lang.get(77646),
		31673,
		9,
		1026,
		nil,
		1
	},
	[31673010] = {
		31673010,
		0,
		Lang.get(77647),
		31673,
		10,
		1024,
		nil,
		1
	},
	[31673011] = {
		31673011,
		0,
		Lang.get(77648),
		31673,
		11,
		1026,
		nil,
		1
	},
	[31673012] = {
		31673012,
		0,
		Lang.get(77649),
		31673,
		12,
		1024,
		nil,
		1
	},
	[31673013] = {
		31673013,
		0,
		Lang.get(77650),
		31673,
		13,
		1026,
		nil,
		1
	},
	[31673014] = {
		31673014,
		0,
		Lang.get(77651),
		31673,
		14,
		1024,
		nil,
		1
	},
	[31673015] = {
		31673015,
		0,
		Lang.get(77652),
		31673,
		15,
		1026,
		nil,
		1
	},
	[31673016] = {
		31673016,
		0,
		Lang.get(77653),
		31673,
		16,
		1024,
		nil,
		1
	},
	[31673017] = {
		31673017,
		0,
		Lang.get(77654),
		31673,
		17,
		1026,
		nil,
		1
	},
	[31673018] = {
		31673018,
		0,
		Lang.get(77655),
		31673,
		18,
		1024,
		nil,
		1
	},
	[31673019] = {
		31673019,
		0,
		Lang.get(77656),
		31673,
		19,
		1026,
		nil,
		1
	},
	[31673020] = {
		31673020,
		0,
		Lang.get(77657),
		31673,
		20,
		1024,
		nil,
		1
	},
	[31673021] = {
		31673021,
		0,
		Lang.get(77658),
		31673,
		21,
		1026,
		nil,
		1
	},
	[31674001] = {
		31674001,
		0,
		Lang.get(77659),
		31674,
		1,
		1024,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31674,
		nil,
		nil,
		nil,
		nil,
		nil,
		31674
	},
	[31674002] = {
		31674002,
		0,
		Lang.get(77660),
		31674,
		2,
		1025,
		nil,
		1
	},
	[31674003] = {
		31674003,
		0,
		Lang.get(77661),
		31674,
		3,
		1026,
		nil,
		1
	},
	[31674004] = {
		31674004,
		0,
		Lang.get(77662),
		31674,
		4,
		1025,
		nil,
		1
	},
	[31674005] = {
		31674005,
		0,
		Lang.get(77663),
		31674,
		5,
		1025,
		nil,
		1
	},
	[31674006] = {
		31674006,
		0,
		Lang.get(77664),
		31674,
		6,
		1024,
		nil,
		1
	},
	[31674007] = {
		31674007,
		0,
		Lang.get(77665),
		31674,
		7,
		1026,
		nil,
		1
	},
	[31674008] = {
		31674008,
		0,
		Lang.get(77666),
		31674,
		8,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31674009] = {
		31674009,
		0,
		Lang.get(77667),
		31674,
		9,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31674010] = {
		31674010,
		0,
		Lang.get(77668),
		31674,
		10,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31674011] = {
		31674011,
		0,
		Lang.get(77669),
		31674,
		11,
		1026,
		{
			RTResTalkAction[41],
			RTResTalkAction[43],
			RTResTalkAction[39]
		}
	},
	[31674012] = {
		31674012,
		0,
		Lang.get(77670),
		31674,
		12,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42],
			RTResTalkAction[44]
		}
	},
	[31674013] = {
		31674013,
		0,
		Lang.get(77671),
		31674,
		13,
		1027,
		{
			RTResTalkAction[41],
			RTResTalkAction[45],
			RTResTalkAction[39]
		}
	},
	[31674014] = {
		31674014,
		0,
		Lang.get(77672),
		31674,
		14,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31674015] = {
		31674015,
		0,
		Lang.get(77673),
		31674,
		15,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31674016] = {
		31674016,
		0,
		Lang.get(77674),
		31674,
		16,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31674017] = {
		31674017,
		0,
		Lang.get(77675),
		31674,
		17,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31674018] = {
		31674018,
		0,
		Lang.get(77676),
		31674,
		18,
		1026,
		{
			RTResTalkAction[47],
			RTResTalkAction[46]
		}
	},
	[31674019] = {
		31674019,
		0,
		Lang.get(77677),
		31674,
		19,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[44]
		}
	},
	[31674020] = {
		31674020,
		0,
		Lang.get(77678),
		31674,
		20,
		1025,
		{
			RTResTalkAction[38],
			RTResTalkAction[46]
		}
	},
	[31675001] = {
		31675001,
		3,
		Lang.get(77679),
		31675,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		62,
		31675,
		[19] = 31675,
		[22] = 1
	},
	[31675002] = {
		31675002,
		0,
		Lang.get(77680),
		31675,
		2,
		1024,
		nil,
		1
	},
	[31675003] = {
		31675003,
		0,
		Lang.get(77681),
		31675,
		3,
		1025,
		nil,
		1
	},
	[31675004] = {
		31675004,
		0,
		Lang.get(77682),
		31675,
		4,
		1024,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[31675005] = {
		31675005,
		0,
		Lang.get(77683),
		31675,
		5,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31675006] = {
		31675006,
		0,
		Lang.get(77684),
		31675,
		6,
		1025,
		{
			RTResTalkAction[38],
			RTResTalkAction[46]
		}
	},
	[31675007] = {
		31675007,
		0,
		Lang.get(77685),
		31675,
		7,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[39]
		}
	},
	[31676001] = {
		31676001,
		0,
		Lang.get(77686),
		31676,
		1,
		1025,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31676,
		nil,
		nil,
		nil,
		nil,
		nil,
		31676
	},
	[31676002] = {
		31676002,
		0,
		Lang.get(77687),
		31676,
		2,
		1024,
		nil,
		1
	},
	[31676003] = {
		31676003,
		0,
		Lang.get(77688),
		31676,
		3,
		1024,
		nil,
		1
	},
	[31676004] = {
		31676004,
		0,
		Lang.get(77689),
		31676,
		4,
		1025,
		nil,
		1
	},
	[31676005] = {
		31676005,
		0,
		Lang.get(77690),
		31676,
		5,
		1025,
		nil,
		1
	},
	[31676006] = {
		31676006,
		0,
		Lang.get(77691),
		31676,
		6,
		1024,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[31676007] = {
		31676007,
		0,
		Lang.get(77692),
		31676,
		7,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31676008] = {
		31676008,
		0,
		Lang.get(77693),
		31676,
		8,
		386,
		{
			RTResTalkAction[48],
			RTResTalkAction[46]
		}
	},
	[31676009] = {
		31676009,
		0,
		Lang.get(77694),
		31676,
		9,
		765,
		{
			RTResTalkAction[49],
			RTResTalkAction[50]
		}
	},
	[31676010] = {
		31676010,
		0,
		Lang.get(77695),
		31676,
		10,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42],
			RTResTalkAction[51]
		}
	},
	[31676011] = {
		31676011,
		0,
		Lang.get(77696),
		31676,
		11,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31676012] = {
		31676012,
		0,
		Lang.get(77697),
		31676,
		12,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31676013] = {
		31676013,
		0,
		Lang.get(77698),
		31676,
		13,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31676014] = {
		31676014,
		0,
		Lang.get(77699),
		31676,
		14,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31676015] = {
		31676015,
		0,
		Lang.get(77700),
		31676,
		15,
		230,
		{
			RTResTalkAction[52],
			RTResTalkAction[46],
			RTResTalkAction[39]
		}
	},
	[31676016] = {
		31676016,
		0,
		Lang.get(77701),
		31676,
		16,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[53]
		}
	},
	[31677001] = {
		31677001,
		0,
		Lang.get(77702),
		31677,
		1,
		1025,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31675,
		nil,
		nil,
		nil,
		nil,
		nil,
		31675
	},
	[31677002] = {
		31677002,
		0,
		Lang.get(77703),
		31677,
		2,
		1024,
		nil,
		1
	},
	[31677003] = {
		31677003,
		0,
		Lang.get(77704),
		31677,
		3,
		1025,
		nil,
		1
	},
	[31677004] = {
		31677004,
		0,
		Lang.get(77705),
		31677,
		4,
		1024,
		nil,
		1
	},
	[31677005] = {
		31677005,
		0,
		Lang.get(77706),
		31677,
		5,
		1025,
		nil,
		1
	},
	[31677006] = {
		31677006,
		0,
		Lang.get(77707),
		31677,
		6,
		1024,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[31677007] = {
		31677007,
		0,
		Lang.get(77708),
		31677,
		7,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31677008] = {
		31677008,
		0,
		Lang.get(77709),
		31677,
		8,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31677009] = {
		31677009,
		0,
		Lang.get(77710),
		31677,
		9,
		1025,
		{
			RTResTalkAction[38],
			RTResTalkAction[46]
		}
	},
	[31678001] = {
		31678001,
		0,
		Lang.get(77711),
		31678,
		1,
		1024,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31675,
		nil,
		nil,
		nil,
		nil,
		nil,
		31675
	},
	[31678002] = {
		31678002,
		0,
		Lang.get(77712),
		31678,
		2,
		1024,
		nil,
		1
	},
	[31678003] = {
		31678003,
		0,
		Lang.get(77713),
		31678,
		3,
		1025,
		nil,
		1
	},
	[31678004] = {
		31678004,
		0,
		Lang.get(77714),
		31678,
		4,
		1024,
		nil,
		1
	},
	[31678005] = {
		31678005,
		0,
		Lang.get(77715),
		31678,
		5,
		1025,
		nil,
		1
	},
	[31678006] = {
		31678006,
		0,
		Lang.get(77716),
		31678,
		6,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[31678007] = {
		31678007,
		0,
		Lang.get(77717),
		31678,
		7,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678008] = {
		31678008,
		0,
		Lang.get(77718),
		31678,
		8,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678009] = {
		31678009,
		0,
		Lang.get(77719),
		31678,
		9,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678010] = {
		31678010,
		0,
		Lang.get(77720),
		31678,
		10,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678011] = {
		31678011,
		0,
		Lang.get(77721),
		31678,
		11,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678012] = {
		31678012,
		0,
		Lang.get(77722),
		31678,
		12,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678013] = {
		31678013,
		0,
		Lang.get(77723),
		31678,
		13,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678014] = {
		31678014,
		0,
		Lang.get(77724),
		31678,
		14,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31678015] = {
		31678015,
		0,
		Lang.get(77725),
		31678,
		15,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31680001] = {
		31680001,
		0,
		Lang.get(77726),
		31680,
		1,
		1024,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31680,
		nil,
		nil,
		nil,
		nil,
		nil,
		31680
	},
	[31680002] = {
		31680002,
		0,
		Lang.get(77727),
		31680,
		2,
		1025,
		nil,
		1
	},
	[31680003] = {
		31680003,
		0,
		Lang.get(77728),
		31680,
		3,
		1024,
		{
			RTResTalkAction[54]
		},
		1,
		nil,
		3,
		[21] = 419
	},
	[31680004] = {
		31680004,
		0,
		Lang.get(77729),
		31680,
		4,
		1025,
		{
			RTResTalkAction[54]
		},
		1,
		[21] = 419
	},
	[31680005] = {
		31680005,
		0,
		Lang.get(77730),
		31680,
		5,
		1024,
		{
			RTResTalkAction[54]
		},
		1,
		[21] = 419
	},
	[31681001] = {
		31681001,
		0,
		Lang.get(77731),
		31681,
		1,
		1025,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31681,
		nil,
		nil,
		nil,
		nil,
		nil,
		31681
	},
	[31681002] = {
		31681002,
		0,
		Lang.get(77732),
		31681,
		2,
		1024,
		nil,
		1
	},
	[31681003] = {
		31681003,
		0,
		Lang.get(77733),
		31681,
		3,
		1025,
		nil,
		1
	},
	[31681004] = {
		31681004,
		0,
		Lang.get(77734),
		31681,
		4,
		1024,
		nil,
		1
	},
	[31681005] = {
		31681005,
		0,
		Lang.get(77735),
		31681,
		5,
		1025,
		nil,
		1
	},
	[31681006] = {
		31681006,
		0,
		Lang.get(77736),
		31681,
		6,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		},
		nil,
		nil,
		3
	},
	[31681007] = {
		31681007,
		0,
		Lang.get(77737),
		31681,
		7,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681008] = {
		31681008,
		0,
		Lang.get(77738),
		31681,
		8,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681009] = {
		31681009,
		0,
		Lang.get(77739),
		31681,
		9,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681010] = {
		31681010,
		0,
		Lang.get(77740),
		31681,
		10,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681011] = {
		31681011,
		0,
		Lang.get(77741),
		31681,
		11,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681012] = {
		31681012,
		0,
		Lang.get(77742),
		31681,
		12,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681013] = {
		31681013,
		0,
		Lang.get(77743),
		31681,
		13,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681014] = {
		31681014,
		0,
		Lang.get(77744),
		31681,
		14,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681015] = {
		31681015,
		0,
		Lang.get(77745),
		31681,
		15,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681016] = {
		31681016,
		0,
		Lang.get(77746),
		31681,
		16,
		1025,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31681017] = {
		31681017,
		0,
		Lang.get(77747),
		31681,
		17,
		1024,
		{
			RTResTalkAction[41],
			RTResTalkAction[42]
		}
	},
	[31682001] = {
		31682001,
		0,
		Lang.get(77748),
		31682,
		1,
		1024,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		31682,
		nil,
		nil,
		nil,
		nil,
		nil,
		31682
	},
	[31682002] = {
		31682002,
		0,
		Lang.get(77749),
		31682,
		2,
		1027,
		nil,
		1
	},
	[31682003] = {
		31682003,
		0,
		Lang.get(77750),
		31682,
		3,
		1024,
		nil,
		1
	},
	[31682004] = {
		31682004,
		0,
		Lang.get(77751),
		31682,
		4,
		1024,
		nil,
		1
	},
	[31682005] = {
		31682005,
		0,
		Lang.get(77752),
		31682,
		5,
		1025,
		nil,
		1
	},
	[31682006] = {
		31682006,
		0,
		Lang.get(77753),
		31682,
		6,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31682007] = {
		31682007,
		0,
		Lang.get(77754),
		31682,
		7,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682008] = {
		31682008,
		0,
		Lang.get(77755),
		31682,
		8,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31682009] = {
		31682009,
		0,
		Lang.get(77756),
		31682,
		9,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682010] = {
		31682010,
		0,
		Lang.get(77757),
		31682,
		10,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31682011] = {
		31682011,
		0,
		Lang.get(77758),
		31682,
		11,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682012] = {
		31682012,
		0,
		Lang.get(77759),
		31682,
		12,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31682013] = {
		31682013,
		0,
		Lang.get(77760),
		31682,
		13,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31682014] = {
		31682014,
		0,
		Lang.get(77761),
		31682,
		14,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682015] = {
		31682015,
		0,
		Lang.get(77762),
		31682,
		15,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31682016] = {
		31682016,
		0,
		Lang.get(77763),
		31682,
		16,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682017] = {
		31682017,
		0,
		Lang.get(77764),
		31682,
		17,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31682018] = {
		31682018,
		0,
		Lang.get(77765),
		31682,
		18,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31682019] = {
		31682019,
		0,
		Lang.get(77766),
		31682,
		19,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31682020] = {
		31682020,
		0,
		Lang.get(77767),
		31682,
		20,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683001] = {
		31683001,
		3,
		"15:59:58——\n15:59:59——",
		31683,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		58,
		31682,
		nil,
		nil,
		nil,
		nil,
		nil,
		31682,
		nil,
		nil,
		1
	},
	[31683002] = {
		31683002,
		3,
		"16:00:00。",
		31683,
		2,
		605,
		[22] = 1
	},
	[31683003] = {
		31683003,
		0,
		Lang.get(77768),
		31683,
		3,
		1024,
		nil,
		1
	},
	[31683004] = {
		31683004,
		0,
		Lang.get(77769),
		31683,
		4,
		1024,
		nil,
		1
	},
	[31683005] = {
		31683005,
		0,
		Lang.get(77770),
		31683,
		5,
		1024,
		nil,
		1
	},
	[31683006] = {
		31683006,
		0,
		Lang.get(77771),
		31683,
		6,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31683007] = {
		31683007,
		0,
		Lang.get(77772),
		31683,
		7,
		1027,
		{
			RTResTalkAction[2]
		}
	},
	[31683008] = {
		31683008,
		0,
		Lang.get(77773),
		31683,
		8,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31683009] = {
		31683009,
		0,
		Lang.get(77774),
		31683,
		9,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683010] = {
		31683010,
		0,
		Lang.get(77775),
		31683,
		10,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683011] = {
		31683011,
		5,
		Lang.get(77776),
		31683,
		11,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683012] = {
		31683012,
		0,
		Lang.get(77777),
		31683,
		12,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31683013] = {
		31683013,
		0,
		Lang.get(77778),
		31683,
		13,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31683014] = {
		31683014,
		0,
		Lang.get(77779),
		31683,
		14,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31683015] = {
		31683015,
		0,
		Lang.get(77780),
		31683,
		15,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31683016] = {
		31683016,
		0,
		Lang.get(77781),
		31683,
		16,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683017] = {
		31683017,
		0,
		Lang.get(77782),
		31683,
		17,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683018] = {
		31683018,
		5,
		Lang.get(77783),
		31683,
		18,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683019] = {
		31683019,
		0,
		Lang.get(77784),
		31683,
		19,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31683020] = {
		31683020,
		0,
		Lang.get(77785),
		31683,
		20,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31684001] = {
		31684001,
		0,
		Lang.get(77786),
		31684,
		1,
		1028,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31682,
		nil,
		nil,
		nil,
		nil,
		nil,
		31682
	},
	[31684002] = {
		31684002,
		0,
		Lang.get(77787),
		31684,
		2,
		1024,
		nil,
		1
	},
	[31684003] = {
		31684003,
		0,
		Lang.get(77788),
		31684,
		3,
		1028,
		nil,
		1
	},
	[31684004] = {
		31684004,
		0,
		Lang.get(77789),
		31684,
		4,
		1028,
		nil,
		1
	},
	[31684005] = {
		31684005,
		0,
		Lang.get(77790),
		31684,
		5,
		1028,
		nil,
		1
	},
	[31684006] = {
		31684006,
		0,
		Lang.get(77791),
		31684,
		6,
		1024,
		{
			RTResTalkAction[40]
		},
		nil,
		nil,
		3
	},
	[31684007] = {
		31684007,
		0,
		Lang.get(77792),
		31684,
		7,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[46]
		}
	},
	[31684008] = {
		31684008,
		0,
		Lang.get(77793),
		31684,
		8,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31684009] = {
		31684009,
		0,
		Lang.get(77794),
		31684,
		9,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[4]
		}
	},
	[31684010] = {
		31684010,
		0,
		Lang.get(77795),
		31684,
		10,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[7]
		}
	},
	[31684011] = {
		31684011,
		0,
		Lang.get(77796),
		31684,
		11,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31684012] = {
		31684012,
		0,
		Lang.get(77797),
		31684,
		12,
		1028,
		{
			RTResTalkAction[5],
			RTResTalkAction[46]
		}
	},
	[31685001] = {
		31685001,
		0,
		Lang.get(77798),
		31685,
		1,
		257,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31685,
		nil,
		nil,
		nil,
		nil,
		nil,
		31685
	},
	[31685002] = {
		31685002,
		0,
		Lang.get(77799),
		31685,
		2,
		278,
		nil,
		1
	},
	[31685003] = {
		31685003,
		0,
		Lang.get(77800),
		31685,
		3,
		244,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[31685004] = {
		31685004,
		0,
		Lang.get(77801),
		31685,
		4,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[27]
		}
	},
	[31685005] = {
		31685005,
		0,
		Lang.get(77802),
		31685,
		5,
		1027,
		{
			RTResTalkAction[2],
			RTResTalkAction[46]
		}
	},
	[31686001] = {
		31686001,
		0,
		Lang.get(77803),
		31686,
		1,
		1024,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31685,
		nil,
		nil,
		nil,
		nil,
		nil,
		31685
	},
	[31686002] = {
		31686002,
		0,
		Lang.get(77804),
		31686,
		2,
		1024,
		nil,
		1
	},
	[31686003] = {
		31686003,
		0,
		Lang.get(77805),
		31686,
		3,
		244,
		nil,
		1
	},
	[31686004] = {
		31686004,
		0,
		Lang.get(77806),
		31686,
		4,
		244,
		{
			RTResTalkAction[30]
		},
		nil,
		nil,
		3
	},
	[31686005] = {
		31686005,
		0,
		Lang.get(77807),
		31686,
		5,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[27]
		}
	},
	[31686006] = {
		31686006,
		0,
		Lang.get(77808),
		31686,
		6,
		1024,
		{
			RTResTalkAction[46]
		},
		1,
		nil,
		nil,
		nil,
		62
	},
	[31686007] = {
		31686007,
		0,
		Lang.get(77809),
		31686,
		7,
		244,
		nil,
		1
	},
	[31686008] = {
		31686008,
		0,
		Lang.get(77810),
		31686,
		8,
		1024,
		nil,
		1
	},
	[31686009] = {
		31686009,
		0,
		Lang.get(77811),
		31686,
		9,
		1027,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[31686010] = {
		31686010,
		0,
		Lang.get(77812),
		31686,
		10,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[4]
		}
	},
	[31686011] = {
		31686011,
		0,
		Lang.get(77813),
		31686,
		11,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31686012] = {
		31686012,
		0,
		Lang.get(77814),
		31686,
		12,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[46]
		}
	},
	[31686013] = {
		31686013,
		0,
		Lang.get(77815),
		31686,
		13,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[25]
		}
	},
	[31686014] = {
		31686014,
		0,
		Lang.get(77816),
		31686,
		14,
		278,
		{
			RTResTalkAction[23],
			RTResTalkAction[46]
		}
	},
	[31686015] = {
		31686015,
		0,
		Lang.get(77817),
		31686,
		15,
		1024,
		{
			RTResTalkAction[40],
			RTResTalkAction[25]
		}
	},
	[31686016] = {
		31686016,
		0,
		Lang.get(77818),
		31686,
		16,
		1024,
		{
			RTResTalkAction[40]
		}
	},
	[31688001] = {
		31688001,
		0,
		Lang.get(77819),
		31688,
		1,
		244,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31688,
		nil,
		nil,
		nil,
		nil,
		nil,
		31688
	},
	[31688002] = {
		31688002,
		0,
		Lang.get(77820),
		31688,
		2,
		1027,
		nil,
		1
	},
	[31688003] = {
		31688003,
		0,
		Lang.get(77821),
		31688,
		3,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31688004] = {
		31688004,
		0,
		Lang.get(77822),
		31688,
		4,
		257,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[31689001] = {
		31689001,
		0,
		Lang.get(77823),
		31689,
		1,
		1023,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		31689,
		nil,
		nil,
		nil,
		nil,
		nil,
		31689
	},
	[31689002] = {
		31689002,
		0,
		Lang.get(77824),
		31689,
		2,
		1023,
		nil,
		1
	},
	[31689003] = {
		31689003,
		3,
		Lang.get(77825),
		31689,
		3,
		605,
		[22] = 1
	},
	[31689004] = {
		31689004,
		0,
		Lang.get(77826),
		31689,
		4,
		1023,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[31689005] = {
		31689005,
		0,
		Lang.get(77827),
		31689,
		5,
		109,
		{
			RTResTalkAction[55],
			RTResTalkAction[3]
		}
	},
	[31689006] = {
		31689006,
		0,
		Lang.get(77828),
		31689,
		6,
		1023,
		{
			RTResTalkAction[1],
			RTResTalkAction[56]
		}
	},
	[31689007] = {
		31689007,
		3,
		Lang.get(77829),
		31689,
		7,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[31689008] = {
		31689008,
		0,
		Lang.get(77830),
		31689,
		8,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[31689009] = {
		31689009,
		0,
		Lang.get(77831),
		31689,
		9,
		109,
		{
			RTResTalkAction[55],
			RTResTalkAction[34]
		}
	},
	[31689010] = {
		31689010,
		0,
		Lang.get(77832),
		31689,
		10,
		1023,
		{
			RTResTalkAction[35],
			RTResTalkAction[56]
		}
	},
	[31689011] = {
		31689011,
		0,
		Lang.get(77833),
		31689,
		11,
		300,
		{
			RTResTalkAction[35]
		}
	},
	[31689012] = {
		31689012,
		0,
		Lang.get(77834),
		31689,
		12,
		1023,
		{
			RTResTalkAction[35]
		}
	},
	[31689013] = {
		31689013,
		5,
		Lang.get(75319),
		31689,
		13,
		605,
		{
			RTResTalkAction[3]
		},
		[22] = 1
	},
	[31689014] = {
		31689014,
		0,
		Lang.get(77835),
		31689,
		14,
		300,
		{
			RTResTalkAction[33]
		}
	},
	[31689015] = {
		31689015,
		0,
		Lang.get(77836),
		31689,
		15,
		109,
		{
			RTResTalkAction[55],
			RTResTalkAction[34]
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
