-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_yaoye\\ResTalk.lua

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
	[2] = 1169,
	[3] = {
		1
	}
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1169
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1169,
	[3] = {
		3
	}
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1169
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1169,
	[3] = {
		1003
	}
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 1172
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1172
}
RTResTalkAction[8] = {
	1,
	1214,
	nil,
	nil,
	1
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1214
}
RTResTalkAction[10] = {
	1,
	1214,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1214
}
RTResTalkAction[12] = {
	1,
	1214,
	nil,
	nil,
	2
}
RTResTalkAction[13] = {
	1,
	1214,
	{
		1
	},
	nil,
	3
}
RTResTalkAction[14] = {
	1,
	1214,
	nil,
	nil,
	3
}
RTResTalkAction[15] = {
	1,
	1214,
	nil,
	nil,
	4
}
RTResTalkAction[16] = {
	1,
	1028,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 1027
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1028
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 1028
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 1027
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 1027,
	[3] = {
		1
	}
}
RTResTalkAction[22] = {
	[1] = 1,
	[2] = 1028,
	[3] = {
		1
	}
}

local Data = {
	[35301001] = {
		35301001,
		0,
		Lang.get(90379),
		35301,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		198,
		35301,
		[19] = 35301
	},
	[35301002] = {
		35301002,
		0,
		Lang.get(90380),
		35301,
		2,
		1169,
		nil,
		1
	},
	[35301003] = {
		35301003,
		0,
		Lang.get(90381),
		35301,
		3,
		300
	},
	[35301004] = {
		35301004,
		0,
		Lang.get(90382),
		35301,
		4,
		1169,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35301005] = {
		35301005,
		0,
		Lang.get(90383),
		35301,
		5,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35301006] = {
		35301006,
		0,
		Lang.get(90384),
		35301,
		6,
		1169,
		{
			RTResTalkAction[3]
		}
	},
	[35301007] = {
		35301007,
		0,
		Lang.get(90385),
		35301,
		7,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35301008] = {
		35301008,
		0,
		Lang.get(90386),
		35301,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35301009] = {
		35301009,
		0,
		Lang.get(90387),
		35301,
		9,
		1169,
		{
			RTResTalkAction[1]
		}
	},
	[35301010] = {
		35301010,
		0,
		Lang.get(90388),
		35301,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35301011] = {
		35301011,
		0,
		Lang.get(90389),
		35301,
		11,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35301012] = {
		35301012,
		0,
		Lang.get(90390),
		35301,
		12,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35301013] = {
		35301013,
		0,
		Lang.get(90391),
		35301,
		13,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35301014] = {
		35301014,
		0,
		Lang.get(90392),
		35301,
		14,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35302001] = {
		35302001,
		0,
		Lang.get(90393),
		35302,
		1,
		1169,
		nil,
		1,
		nil,
		nil,
		nil,
		23,
		35302,
		nil,
		nil,
		nil,
		nil,
		nil,
		35302
	},
	[35302002] = {
		35302002,
		0,
		Lang.get(90394),
		35302,
		2,
		300
	},
	[35302003] = {
		35302003,
		0,
		Lang.get(90395),
		35302,
		3,
		1169,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35302004] = {
		35302004,
		0,
		Lang.get(90396),
		35302,
		4,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[35302005] = {
		35302005,
		4,
		nil,
		35302,
		5,
		1169,
		[29] = {
			{
				id = 35302006,
				branch_content = Lang.get(90397)
			},
			{
				id = 35302006,
				branch_content = Lang.get(90398)
			}
		}
	},
	[35302006] = {
		35302006,
		0,
		Lang.get(90399),
		35302,
		6,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35302007] = {
		35302007,
		0,
		Lang.get(90400),
		35302,
		7,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35302008] = {
		35302008,
		0,
		Lang.get(90401),
		35302,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35302009] = {
		35302009,
		0,
		Lang.get(90402),
		35302,
		9,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35302010] = {
		35302010,
		0,
		Lang.get(90403),
		35302,
		10,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35302011] = {
		35302011,
		0,
		Lang.get(90404),
		35302,
		11,
		1169,
		{
			RTResTalkAction[5]
		}
	},
	[35302012] = {
		35302012,
		0,
		Lang.get(90405),
		35302,
		12,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35303001] = {
		35303001,
		0,
		Lang.get(90406),
		35303,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		198,
		35303,
		[19] = 35303
	},
	[35303002] = {
		35303002,
		0,
		Lang.get(90407),
		35303,
		2,
		1169,
		nil,
		1
	},
	[35303003] = {
		35303003,
		0,
		Lang.get(90408),
		35303,
		3,
		1169,
		nil,
		1
	},
	[35303004] = {
		35303004,
		0,
		Lang.get(90409),
		35303,
		4,
		300
	},
	[35303005] = {
		35303005,
		0,
		Lang.get(90410),
		35303,
		5,
		300
	},
	[35303006] = {
		35303006,
		0,
		Lang.get(90411),
		35303,
		6,
		1169,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[35303007] = {
		35303007,
		0,
		Lang.get(90412),
		35303,
		7,
		1169,
		{
			RTResTalkAction[1]
		}
	},
	[35303008] = {
		35303008,
		0,
		Lang.get(90413),
		35303,
		8,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35303009] = {
		35303009,
		0,
		Lang.get(90414),
		35303,
		9,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35303010] = {
		35303010,
		0,
		Lang.get(90415),
		35303,
		10,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35303011] = {
		35303011,
		0,
		Lang.get(90416),
		35303,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[35303012] = {
		35303012,
		0,
		Lang.get(90417),
		35303,
		12,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35303013] = {
		35303013,
		0,
		Lang.get(90418),
		35303,
		13,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35303014] = {
		35303014,
		0,
		Lang.get(90419),
		35303,
		14,
		1169,
		{
			RTResTalkAction[2]
		}
	},
	[35310001] = {
		35310001,
		0,
		Lang.get(92435),
		35310,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		114,
		35310,
		[19] = 35310
	},
	[35310002] = {
		35310002,
		0,
		Lang.get(92436),
		35310,
		2,
		1172,
		nil,
		1
	},
	[35310003] = {
		35310003,
		0,
		Lang.get(92437),
		35310,
		3,
		300,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[35310004] = {
		35310004,
		0,
		Lang.get(92438),
		35310,
		4,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[35310005] = {
		35310005,
		0,
		Lang.get(92439),
		35310,
		5,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35310006] = {
		35310006,
		0,
		Lang.get(92440),
		35310,
		6,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35310007] = {
		35310007,
		0,
		Lang.get(92441),
		35310,
		7,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[35310008] = {
		35310008,
		0,
		Lang.get(92442),
		35310,
		8,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35310009] = {
		35310009,
		4,
		nil,
		35310,
		9,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35310010,
				branch_content = Lang.get(92443)
			},
			{
				id = 35310010,
				branch_content = Lang.get(92444)
			}
		}
	},
	[35310010] = {
		35310010,
		0,
		Lang.get(92445),
		35310,
		10,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35310011] = {
		35310011,
		0,
		Lang.get(92446),
		35310,
		11,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35310012] = {
		35310012,
		4,
		nil,
		35310,
		12,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35310013,
				branch_content = Lang.get(92447)
			}
		}
	},
	[35310013] = {
		35310013,
		0,
		Lang.get(92448),
		35310,
		13,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311001] = {
		35311001,
		0,
		Lang.get(92449),
		35311,
		1,
		1172,
		nil,
		1,
		nil,
		nil,
		nil,
		72,
		35311,
		nil,
		nil,
		nil,
		nil,
		nil,
		35311
	},
	[35311002] = {
		35311002,
		0,
		Lang.get(92450),
		35311,
		2,
		300
	},
	[35311003] = {
		35311003,
		0,
		Lang.get(92451),
		35311,
		3,
		1172,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[35311004] = {
		35311004,
		0,
		Lang.get(92452),
		35311,
		4,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[35311005] = {
		35311005,
		0,
		Lang.get(92453),
		35311,
		5,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311006] = {
		35311006,
		4,
		nil,
		35311,
		6,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35311007,
				branch_content = Lang.get(92454)
			},
			{
				id = 35311007,
				branch_content = Lang.get(92455)
			}
		}
	},
	[35311007] = {
		35311007,
		0,
		Lang.get(92456),
		35311,
		7,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311008] = {
		35311008,
		0,
		Lang.get(92457),
		35311,
		8,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311009] = {
		35311009,
		4,
		nil,
		35311,
		9,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35311010,
				branch_content = Lang.get(92458)
			}
		}
	},
	[35311010] = {
		35311010,
		0,
		Lang.get(92459),
		35311,
		10,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311011] = {
		35311011,
		0,
		Lang.get(92460),
		35311,
		11,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35311012] = {
		35311012,
		0,
		Lang.get(92461),
		35311,
		12,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312001] = {
		35312001,
		0,
		Lang.get(92462),
		35312,
		1,
		1172,
		nil,
		1,
		nil,
		nil,
		nil,
		73,
		35312,
		nil,
		nil,
		nil,
		nil,
		nil,
		35312
	},
	[35312002] = {
		35312002,
		0,
		Lang.get(92463),
		35312,
		2,
		1172,
		nil,
		1
	},
	[35312003] = {
		35312003,
		0,
		Lang.get(92464),
		35312,
		3,
		300,
		{
			RTResTalkAction[6]
		},
		nil,
		nil,
		3
	},
	[35312004] = {
		35312004,
		0,
		Lang.get(92465),
		35312,
		4,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[35312005] = {
		35312005,
		0,
		Lang.get(92466),
		35312,
		5,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312006] = {
		35312006,
		0,
		Lang.get(92467),
		35312,
		6,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312007] = {
		35312007,
		0,
		Lang.get(92468),
		35312,
		7,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312008] = {
		35312008,
		4,
		nil,
		35312,
		8,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35312009,
				branch_content = Lang.get(92469)
			}
		}
	},
	[35312009] = {
		35312009,
		0,
		Lang.get(92470),
		35312,
		9,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312010] = {
		35312010,
		0,
		Lang.get(92471),
		35312,
		10,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312011] = {
		35312011,
		4,
		nil,
		35312,
		11,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35312012,
				branch_content = Lang.get(92472)
			}
		}
	},
	[35312012] = {
		35312012,
		0,
		Lang.get(92473),
		35312,
		12,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35312013] = {
		35312013,
		4,
		nil,
		35312,
		13,
		300,
		{
			RTResTalkAction[7]
		},
		[29] = {
			{
				id = 35312014,
				branch_content = Lang.get(92474)
			}
		}
	},
	[35312014] = {
		35312014,
		0,
		Lang.get(92475),
		35312,
		14,
		1172,
		{
			RTResTalkAction[6]
		}
	},
	[35313001] = {
		35313001,
		0,
		Lang.get(97456),
		35313,
		1,
		1214,
		nil,
		1,
		4,
		nil,
		nil,
		201,
		35313,
		nil,
		1,
		nil,
		nil,
		nil,
		35313
	},
	[35313002] = {
		35313002,
		0,
		Lang.get(97457),
		35313,
		2,
		300
	},
	[35313003] = {
		35313003,
		0,
		Lang.get(97458),
		35313,
		3,
		1214,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[35313004] = {
		35313004,
		4,
		nil,
		35313,
		4,
		300,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		-1,
		[29] = {
			{
				id = 35313005,
				branch_content = Lang.get(97459)
			},
			{
				id = 35313005,
				branch_content = Lang.get(97460)
			}
		}
	},
	[35313005] = {
		35313005,
		0,
		Lang.get(97461),
		35313,
		5,
		1214,
		nil,
		1,
		3
	},
	[35313006] = {
		35313006,
		0,
		Lang.get(97462),
		35313,
		6,
		1214,
		{
			RTResTalkAction[10]
		},
		nil,
		nil,
		3
	},
	[35313007] = {
		35313007,
		0,
		Lang.get(97463),
		35313,
		7,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35313008] = {
		35313008,
		0,
		Lang.get(97464),
		35313,
		8,
		1214,
		{
			RTResTalkAction[12]
		}
	},
	[35313009] = {
		35313009,
		0,
		Lang.get(97465),
		35313,
		9,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35313010] = {
		35313010,
		0,
		Lang.get(97466),
		35313,
		10,
		1214,
		{
			RTResTalkAction[8]
		}
	},
	[35313011] = {
		35313011,
		0,
		Lang.get(97467),
		35313,
		11,
		1214,
		{
			RTResTalkAction[8]
		}
	},
	[35313012] = {
		35313012,
		0,
		Lang.get(97468),
		35313,
		12,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35313013] = {
		35313013,
		0,
		Lang.get(97469),
		35313,
		13,
		1214,
		{
			RTResTalkAction[8]
		}
	},
	[35314001] = {
		35314001,
		0,
		Lang.get(97470),
		35314,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		201,
		35314,
		nil,
		1,
		nil,
		nil,
		nil,
		35314
	},
	[35314002] = {
		35314002,
		0,
		Lang.get(97471),
		35314,
		2,
		1214,
		nil,
		1,
		1
	},
	[35314003] = {
		35314003,
		0,
		Lang.get(97472),
		35314,
		3,
		1214,
		nil,
		1,
		2
	},
	[35314004] = {
		35314004,
		0,
		Lang.get(97473),
		35314,
		4,
		300
	},
	[35314005] = {
		35314005,
		0,
		Lang.get(97474),
		35314,
		5,
		1214,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[35314006] = {
		35314006,
		0,
		Lang.get(97475),
		35314,
		6,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35314007] = {
		35314007,
		0,
		Lang.get(97476),
		35314,
		7,
		1214,
		{
			RTResTalkAction[14]
		}
	},
	[35314008] = {
		35314008,
		0,
		Lang.get(97477),
		35314,
		8,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35314009] = {
		35314009,
		0,
		Lang.get(97478),
		35314,
		9,
		1214,
		{
			RTResTalkAction[8]
		}
	},
	[35314010] = {
		35314010,
		0,
		Lang.get(97479),
		35314,
		10,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35314011] = {
		35314011,
		0,
		Lang.get(97480),
		35314,
		11,
		1214,
		{
			RTResTalkAction[15]
		}
	},
	[35314012] = {
		35314012,
		4,
		nil,
		35314,
		12,
		300,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 35314013,
				branch_content = Lang.get(97481)
			},
			{
				id = 35314013,
				branch_content = Lang.get(87656)
			}
		}
	},
	[35314013] = {
		35314013,
		0,
		Lang.get(97482),
		35314,
		13,
		1214,
		{
			RTResTalkAction[8]
		}
	},
	[35315001] = {
		35315001,
		0,
		Lang.get(97483),
		35315,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		201,
		35315,
		nil,
		1,
		nil,
		nil,
		nil,
		35315
	},
	[35315002] = {
		35315002,
		0,
		Lang.get(97484),
		35315,
		2,
		1214,
		nil,
		1,
		1
	},
	[35315003] = {
		35315003,
		0,
		Lang.get(97485),
		35315,
		3,
		300
	},
	[35315004] = {
		35315004,
		0,
		Lang.get(97486),
		35315,
		4,
		300
	},
	[35315005] = {
		35315005,
		0,
		Lang.get(97487),
		35315,
		5,
		1214,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[35315006] = {
		35315006,
		0,
		Lang.get(97488),
		35315,
		6,
		1214,
		{
			RTResTalkAction[11]
		}
	},
	[35315007] = {
		35315007,
		0,
		Lang.get(97489),
		35315,
		7,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[35315008] = {
		35315008,
		0,
		Lang.get(97490),
		35315,
		8,
		1214,
		{
			RTResTalkAction[11]
		}
	},
	[35315009] = {
		35315009,
		0,
		Lang.get(97491),
		35315,
		9,
		1214,
		{
			RTResTalkAction[11]
		}
	},
	[35315010] = {
		35315010,
		0,
		Lang.get(27581),
		35315,
		10,
		300,
		{
			RTResTalkAction[9]
		}
	},
	[35315011] = {
		35315011,
		0,
		Lang.get(97492),
		35315,
		11,
		1214,
		{
			RTResTalkAction[11]
		}
	},
	[35315012] = {
		35315012,
		0,
		Lang.get(97493),
		35315,
		12,
		300,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		-1
	},
	[35315013] = {
		35315013,
		4,
		nil,
		35315,
		13,
		300,
		[29] = {
			{
				id = 35315014,
				branch_content = Lang.get(97494)
			},
			{
				id = 35315015,
				branch_content = Lang.get(97495)
			}
		}
	},
	[35315014] = {
		35315014,
		0,
		Lang.get(97496),
		35315,
		14,
		1214,
		nil,
		1,
		1
	},
	[35315015] = {
		35315015,
		0,
		Lang.get(97497),
		35315,
		15,
		1214,
		nil,
		1,
		2
	},
	[35316001] = {
		35316001,
		0,
		Lang.get(97498),
		35316,
		1,
		1028,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35316,
		nil,
		1,
		nil,
		nil,
		nil,
		35316
	},
	[35316002] = {
		35316002,
		0,
		Lang.get(97499),
		35316,
		2,
		1027,
		nil,
		1
	},
	[35316003] = {
		35316003,
		0,
		Lang.get(97500),
		35316,
		3,
		300
	},
	[35316004] = {
		35316004,
		5,
		Lang.get(97501),
		35316,
		4,
		1028,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3
	},
	[35316005] = {
		35316005,
		0,
		Lang.get(97502),
		35316,
		5,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35316006] = {
		35316006,
		0,
		Lang.get(97503),
		35316,
		6,
		300,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[35316007] = {
		35316007,
		0,
		Lang.get(97504),
		35316,
		7,
		1028,
		{
			RTResTalkAction[19]
		}
	},
	[35316008] = {
		35316008,
		4,
		nil,
		35316,
		8,
		300,
		{
			RTResTalkAction[19]
		},
		[29] = {
			{
				id = 35316009,
				branch_content = Lang.get(97505)
			}
		}
	},
	[35316009] = {
		35316009,
		0,
		Lang.get(97506),
		35316,
		9,
		1027,
		{
			RTResTalkAction[21],
			RTResTalkAction[18]
		}
	},
	[35316010] = {
		35316010,
		0,
		Lang.get(97507),
		35316,
		10,
		300,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[35316011] = {
		35316011,
		0,
		Lang.get(97508),
		35316,
		11,
		1028,
		{
			RTResTalkAction[22]
		}
	},
	[35316012] = {
		35316012,
		4,
		nil,
		35316,
		12,
		300,
		{
			RTResTalkAction[19]
		},
		[29] = {
			{
				id = 35316013,
				branch_content = Lang.get(97509)
			}
		}
	},
	[35316013] = {
		35316013,
		0,
		Lang.get(97510),
		35316,
		13,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35317001] = {
		35317001,
		0,
		Lang.get(97511),
		35317,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		35317,
		nil,
		1,
		[19] = 35317
	},
	[35317002] = {
		35317002,
		0,
		Lang.get(97512),
		35317,
		2,
		1028,
		nil,
		1
	},
	[35317003] = {
		35317003,
		0,
		Lang.get(97513),
		35317,
		3,
		1027,
		nil,
		1
	},
	[35317004] = {
		35317004,
		0,
		Lang.get(97514),
		35317,
		4,
		300,
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
	[35317005] = {
		35317005,
		0,
		Lang.get(97515),
		35317,
		5,
		1028,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[35317006] = {
		35317006,
		0,
		Lang.get(97516),
		35317,
		6,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35317007] = {
		35317007,
		0,
		Lang.get(97517),
		35317,
		7,
		300,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[35317008] = {
		35317008,
		0,
		Lang.get(97518),
		35317,
		8,
		1028,
		{
			RTResTalkAction[19]
		}
	},
	[35317009] = {
		35317009,
		0,
		Lang.get(97519),
		35317,
		9,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35317010] = {
		35317010,
		0,
		Lang.get(97520),
		35317,
		10,
		300,
		{
			RTResTalkAction[20]
		},
		nil,
		nil,
		-1
	},
	[35317011] = {
		35317011,
		0,
		Lang.get(97521),
		35317,
		11,
		300
	},
	[35317012] = {
		35317012,
		0,
		Lang.get(97522),
		35317,
		12,
		1028,
		nil,
		1
	},
	[35317013] = {
		35317013,
		0,
		Lang.get(97523),
		35317,
		13,
		1028,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[35317014] = {
		35317014,
		0,
		Lang.get(97524),
		35317,
		14,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35318001] = {
		35318001,
		0,
		Lang.get(97525),
		35318,
		1,
		1027,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		35318,
		nil,
		1,
		nil,
		nil,
		nil,
		35318
	},
	[35318002] = {
		35318002,
		0,
		Lang.get(97526),
		35318,
		2,
		1027,
		nil,
		1
	},
	[35318003] = {
		35318003,
		0,
		Lang.get(97527),
		35318,
		3,
		300
	},
	[35318004] = {
		35318004,
		0,
		Lang.get(97528),
		35318,
		4,
		300
	},
	[35318005] = {
		35318005,
		0,
		Lang.get(97529),
		35318,
		5,
		1028,
		{
			RTResTalkAction[19]
		},
		nil,
		nil,
		3
	},
	[35318006] = {
		35318006,
		0,
		Lang.get(97530),
		35318,
		6,
		1028,
		{
			RTResTalkAction[19]
		}
	},
	[35318007] = {
		35318007,
		0,
		Lang.get(97531),
		35318,
		7,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35318008] = {
		35318008,
		0,
		Lang.get(97532),
		35318,
		8,
		1028,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[35318009] = {
		35318009,
		0,
		Lang.get(97533),
		35318,
		9,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[35318010] = {
		35318010,
		0,
		Lang.get(97534),
		35318,
		10,
		1028,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[35318011] = {
		35318011,
		0,
		Lang.get(97535),
		35318,
		11,
		300,
		{
			RTResTalkAction[19]
		}
	},
	[35318012] = {
		35318012,
		0,
		Lang.get(97536),
		35318,
		12,
		1028,
		{
			RTResTalkAction[19]
		}
	},
	[35318013] = {
		35318013,
		4,
		nil,
		35318,
		13,
		300,
		{
			RTResTalkAction[19]
		},
		[29] = {
			{
				id = 35318014,
				branch_content = Lang.get(97537)
			},
			{
				id = 35318014,
				branch_content = Lang.get(97538)
			}
		}
	},
	[35318014] = {
		35318014,
		0,
		Lang.get(97539),
		35318,
		14,
		1027,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
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
