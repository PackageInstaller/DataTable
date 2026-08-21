-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_guozheng\\ResTalk.lua

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
	[2] = 1093
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 1093,
	[3] = {
		1
	}
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 1093,
	[3] = {
		1003
	}
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 1093
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1
	}
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		2
	}
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1002
	}
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1001
	}
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1195,
	[3] = {
		1003
	}
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1237
}

local Data = {
	[33401001] = {
		33401001,
		0,
		Lang.get(85684),
		33401,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33401,
		nil,
		nil,
		nil,
		nil,
		nil,
		33401
	},
	[33401002] = {
		33401002,
		4,
		nil,
		33401,
		2,
		1093,
		nil,
		1,
		[29] = {
			{
				id = 33401003,
				branch_content = Lang.get(85685)
			},
			{
				id = 33401003,
				branch_content = Lang.get(85686)
			}
		}
	},
	[33401003] = {
		33401003,
		0,
		Lang.get(85687),
		33401,
		3,
		1093,
		nil,
		1
	},
	[33401004] = {
		33401004,
		0,
		Lang.get(85688),
		33401,
		4,
		300
	},
	[33401005] = {
		33401005,
		0,
		Lang.get(85689),
		33401,
		5,
		1093,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33401006] = {
		33401006,
		0,
		Lang.get(85690),
		33401,
		6,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33401007] = {
		33401007,
		0,
		Lang.get(85691),
		33401,
		7,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33401008] = {
		33401008,
		0,
		Lang.get(85692),
		33401,
		8,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33401009] = {
		33401009,
		0,
		Lang.get(85693),
		33401,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33401010] = {
		33401010,
		0,
		Lang.get(85694),
		33401,
		10,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33401011] = {
		33401011,
		0,
		Lang.get(68061),
		33401,
		11,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33401012] = {
		33401012,
		0,
		Lang.get(85695),
		33401,
		12,
		1093,
		{
			RTResTalkAction[2]
		}
	},
	[33401013] = {
		33401013,
		0,
		Lang.get(85696),
		33401,
		13,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33401014] = {
		33401014,
		0,
		Lang.get(85697),
		33401,
		14,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33402001] = {
		33402001,
		0,
		Lang.get(85698),
		33402,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		8,
		33402,
		nil,
		nil,
		nil,
		nil,
		nil,
		33402
	},
	[33402002] = {
		33402002,
		4,
		nil,
		33402,
		2,
		1093,
		nil,
		1,
		[29] = {
			{
				id = 33402003,
				branch_content = Lang.get(85699)
			},
			{
				id = 33402003,
				branch_content = Lang.get(85700)
			}
		}
	},
	[33402003] = {
		33402003,
		0,
		Lang.get(85701),
		33402,
		3,
		1093,
		nil,
		1
	},
	[33402004] = {
		33402004,
		0,
		Lang.get(85702),
		33402,
		4,
		1093,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33402005] = {
		33402005,
		0,
		Lang.get(85703),
		33402,
		5,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33402006] = {
		33402006,
		0,
		Lang.get(85704),
		33402,
		6,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33402007] = {
		33402007,
		0,
		Lang.get(85705),
		33402,
		7,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33402008] = {
		33402008,
		0,
		Lang.get(85706),
		33402,
		8,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33402009] = {
		33402009,
		0,
		Lang.get(85707),
		33402,
		9,
		1093,
		{
			RTResTalkAction[2]
		}
	},
	[33402010] = {
		33402010,
		0,
		Lang.get(85708),
		33402,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33402011] = {
		33402011,
		0,
		Lang.get(85709),
		33402,
		11,
		1093,
		{
			RTResTalkAction[3]
		}
	},
	[33402012] = {
		33402012,
		3,
		Lang.get(85710),
		33402,
		12,
		605,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		nil,
		nil,
		8,
		33502,
		nil,
		nil,
		nil,
		1,
		nil,
		33502,
		nil,
		nil,
		1
	},
	[33402013] = {
		33402013,
		0,
		Lang.get(85711),
		33402,
		13,
		1093,
		nil,
		1
	},
	[33402014] = {
		33402014,
		0,
		Lang.get(85712),
		33402,
		14,
		1093,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[33402015] = {
		33402015,
		0,
		Lang.get(85713),
		33402,
		15,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33402016] = {
		33402016,
		0,
		Lang.get(85714),
		33402,
		16,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33403001] = {
		33403001,
		0,
		Lang.get(85715),
		33403,
		1,
		1093,
		nil,
		1,
		nil,
		nil,
		nil,
		162,
		33403,
		nil,
		nil,
		nil,
		nil,
		nil,
		33403
	},
	[33403002] = {
		33403002,
		4,
		nil,
		33403,
		2,
		1093,
		nil,
		1,
		[29] = {
			{
				id = 33403003,
				branch_content = Lang.get(27515)
			},
			{
				id = 33403003,
				branch_content = Lang.get(85716)
			}
		}
	},
	[33403003] = {
		33403003,
		0,
		Lang.get(85717),
		33403,
		3,
		1093,
		nil,
		1
	},
	[33403004] = {
		33403004,
		0,
		Lang.get(85718),
		33403,
		4,
		1093,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[33403005] = {
		33403005,
		0,
		Lang.get(85719),
		33403,
		5,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33403006] = {
		33403006,
		0,
		Lang.get(85720),
		33403,
		6,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33403007] = {
		33403007,
		0,
		Lang.get(85721),
		33403,
		7,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33403008] = {
		33403008,
		0,
		Lang.get(85722),
		33403,
		8,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33403009] = {
		33403009,
		0,
		Lang.get(85723),
		33403,
		9,
		1093,
		{
			RTResTalkAction[3]
		}
	},
	[33403010] = {
		33403010,
		0,
		Lang.get(85724),
		33403,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[33403011] = {
		33403011,
		0,
		Lang.get(85725),
		33403,
		11,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33403012] = {
		33403012,
		0,
		Lang.get(85726),
		33403,
		12,
		1093,
		{
			RTResTalkAction[1]
		}
	},
	[33404001] = {
		33404001,
		0,
		Lang.get(93706),
		33404,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		200,
		33404,
		[19] = 33404
	},
	[33404002] = {
		33404002,
		0,
		Lang.get(93707),
		33404,
		2,
		300
	},
	[33404003] = {
		33404003,
		0,
		Lang.get(93708),
		33404,
		3,
		1195,
		nil,
		1
	},
	[33404004] = {
		33404004,
		0,
		Lang.get(93709),
		33404,
		4,
		300
	},
	[33404005] = {
		33404005,
		0,
		Lang.get(93710),
		33404,
		5,
		1195,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[33404006] = {
		33404006,
		0,
		Lang.get(93711),
		33404,
		6,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33404007] = {
		33404007,
		3,
		Lang.get(93712),
		33404,
		7,
		605,
		{
			RTResTalkAction[6]
		},
		[22] = 1
	},
	[33404008] = {
		33404008,
		0,
		Lang.get(93713),
		33404,
		8,
		1195,
		{
			RTResTalkAction[7]
		}
	},
	[33404009] = {
		33404009,
		0,
		Lang.get(93714),
		33404,
		9,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33404010] = {
		33404010,
		0,
		Lang.get(93715),
		33404,
		10,
		1195,
		{
			RTResTalkAction[8]
		}
	},
	[33404011] = {
		33404011,
		0,
		Lang.get(93716),
		33404,
		11,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33404012] = {
		33404012,
		0,
		Lang.get(93717),
		33404,
		12,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33404013] = {
		33404013,
		0,
		Lang.get(93718),
		33404,
		13,
		1195,
		{
			RTResTalkAction[9]
		}
	},
	[33404014] = {
		33404014,
		4,
		nil,
		33404,
		14,
		1195,
		{
			RTResTalkAction[6]
		},
		[29] = {
			{
				id = 33404015,
				branch_content = Lang.get(23847)
			},
			{
				id = 33404015,
				branch_content = Lang.get(93719)
			}
		}
	},
	[33404015] = {
		33404015,
		0,
		Lang.get(93720),
		33404,
		15,
		1195,
		{
			RTResTalkAction[5]
		}
	},
	[33405001] = {
		33405001,
		0,
		Lang.get(93721),
		33405,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		33405,
		[19] = 33405
	},
	[33405002] = {
		33405002,
		0,
		Lang.get(93722),
		33405,
		2,
		1195,
		nil,
		1
	},
	[33405003] = {
		33405003,
		4,
		nil,
		33405,
		3,
		1195,
		nil,
		1,
		[29] = {
			{
				id = 33405004,
				branch_content = Lang.get(93723)
			},
			{
				id = 33405004,
				branch_content = Lang.get(93724)
			}
		}
	},
	[33405004] = {
		33405004,
		0,
		Lang.get(93725),
		33405,
		4,
		1195,
		nil,
		1
	},
	[33405005] = {
		33405005,
		0,
		Lang.get(93726),
		33405,
		5,
		300
	},
	[33405006] = {
		33405006,
		0,
		Lang.get(93727),
		33405,
		6,
		1195,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[33405007] = {
		33405007,
		4,
		nil,
		33405,
		7,
		1195,
		{
			RTResTalkAction[6]
		},
		[29] = {
			{
				id = 33405008,
				branch_content = Lang.get(93728)
			},
			{
				id = 33405008,
				branch_content = Lang.get(93729)
			}
		}
	},
	[33405008] = {
		33405008,
		0,
		Lang.get(93730),
		33405,
		8,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33405009] = {
		33405009,
		0,
		Lang.get(93731),
		33405,
		9,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33405010] = {
		33405010,
		0,
		Lang.get(93732),
		33405,
		10,
		1195,
		{
			RTResTalkAction[7]
		}
	},
	[33405011] = {
		33405011,
		0,
		Lang.get(93733),
		33405,
		11,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33405012] = {
		33405012,
		0,
		Lang.get(93734),
		33405,
		12,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33405013] = {
		33405013,
		0,
		Lang.get(93735),
		33405,
		13,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33405014] = {
		33405014,
		0,
		Lang.get(93736),
		33405,
		14,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33405015] = {
		33405015,
		0,
		Lang.get(93737),
		33405,
		15,
		1195,
		{
			RTResTalkAction[10]
		}
	},
	[33406001] = {
		33406001,
		0,
		Lang.get(93738),
		33406,
		1,
		1195,
		nil,
		1,
		nil,
		nil,
		nil,
		162,
		33406,
		nil,
		nil,
		nil,
		nil,
		nil,
		33406
	},
	[33406002] = {
		33406002,
		0,
		Lang.get(93739),
		33406,
		2,
		1195,
		nil,
		1
	},
	[33406003] = {
		33406003,
		0,
		Lang.get(93740),
		33406,
		3,
		300
	},
	[33406004] = {
		33406004,
		0,
		Lang.get(93741),
		33406,
		4,
		1195,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[33406005] = {
		33406005,
		0,
		Lang.get(93742),
		33406,
		5,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33406006] = {
		33406006,
		0,
		Lang.get(93743),
		33406,
		6,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33406007] = {
		33406007,
		0,
		Lang.get(93744),
		33406,
		7,
		1195,
		{
			RTResTalkAction[10]
		}
	},
	[33406008] = {
		33406008,
		0,
		Lang.get(93745),
		33406,
		8,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[33406009] = {
		33406009,
		0,
		Lang.get(93746),
		33406,
		9,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33406010] = {
		33406010,
		4,
		nil,
		33406,
		10,
		1195,
		{
			RTResTalkAction[6]
		},
		[29] = {
			{
				id = 33406011,
				branch_content = Lang.get(93747)
			},
			{
				id = 33406011,
				branch_content = Lang.get(93748)
			}
		}
	},
	[33406011] = {
		33406011,
		0,
		Lang.get(93749),
		33406,
		11,
		1195,
		{
			RTResTalkAction[5]
		}
	},
	[33406012] = {
		33406012,
		0,
		Lang.get(93750),
		33406,
		12,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33406013] = {
		33406013,
		0,
		Lang.get(93751),
		33406,
		13,
		1195,
		{
			RTResTalkAction[6]
		}
	},
	[33407001] = {
		33407001,
		0,
		Lang.get(99365),
		33407,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		33407,
		nil,
		nil,
		nil,
		nil,
		nil,
		33407
	},
	[33407002] = {
		33407002,
		0,
		Lang.get(99366),
		33407,
		2,
		300
	},
	[33407003] = {
		33407003,
		0,
		Lang.get(99367),
		33407,
		3,
		1237,
		nil,
		1
	},
	[33407004] = {
		33407004,
		0,
		Lang.get(99368),
		33407,
		4,
		300
	},
	[33407005] = {
		33407005,
		0,
		Lang.get(99369),
		33407,
		5,
		1237,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[33407006] = {
		33407006,
		0,
		Lang.get(99370),
		33407,
		6,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33407007] = {
		33407007,
		4,
		nil,
		33407,
		7,
		1237,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 33407008,
				branch_content = Lang.get(99371)
			},
			{
				id = 33407008,
				branch_content = Lang.get(99372)
			}
		}
	},
	[33407008] = {
		33407008,
		0,
		Lang.get(99373),
		33407,
		8,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33407009] = {
		33407009,
		4,
		nil,
		33407,
		9,
		1237,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 33407010,
				branch_content = Lang.get(99374)
			},
			{
				id = 33407010,
				branch_content = Lang.get(99375)
			}
		}
	},
	[33407010] = {
		33407010,
		0,
		Lang.get(99376),
		33407,
		10,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33407011] = {
		33407011,
		0,
		Lang.get(99377),
		33407,
		11,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33408001] = {
		33408001,
		0,
		Lang.get(99378),
		33408,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		8,
		33408,
		[19] = 33408
	},
	[33408002] = {
		33408002,
		0,
		Lang.get(99379),
		33408,
		2,
		1237,
		nil,
		1
	},
	[33408003] = {
		33408003,
		4,
		nil,
		33408,
		3,
		1237,
		nil,
		1,
		[29] = {
			{
				id = 33408004,
				branch_content = Lang.get(99380)
			},
			{
				id = 33408004,
				branch_content = Lang.get(99381)
			}
		}
	},
	[33408004] = {
		33408004,
		0,
		Lang.get(99382),
		33408,
		4,
		1237,
		nil,
		1
	},
	[33408005] = {
		33408005,
		0,
		Lang.get(99383),
		33408,
		5,
		300
	},
	[33408006] = {
		33408006,
		0,
		Lang.get(99384),
		33408,
		6,
		1237,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[33408007] = {
		33408007,
		4,
		nil,
		33408,
		7,
		1237,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 33408008,
				branch_content = Lang.get(99385)
			},
			{
				id = 33408008,
				branch_content = Lang.get(99386)
			}
		}
	},
	[33408008] = {
		33408008,
		0,
		Lang.get(99387),
		33408,
		8,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33408009] = {
		33408009,
		4,
		nil,
		33408,
		9,
		1237,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 33408010,
				branch_content = Lang.get(99388)
			},
			{
				id = 33408010,
				branch_content = Lang.get(99389)
			}
		}
	},
	[33408010] = {
		33408010,
		0,
		Lang.get(99390),
		33408,
		10,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409001] = {
		33409001,
		0,
		Lang.get(99391),
		33409,
		1,
		1237,
		nil,
		1,
		nil,
		nil,
		nil,
		162,
		33409,
		nil,
		nil,
		nil,
		nil,
		nil,
		33409
	},
	[33409002] = {
		33409002,
		4,
		nil,
		33409,
		2,
		1237,
		nil,
		1,
		[29] = {
			{
				id = 33409003,
				branch_content = Lang.get(99392)
			},
			{
				id = 33409003,
				branch_content = Lang.get(99393)
			}
		}
	},
	[33409003] = {
		33409003,
		0,
		Lang.get(99394),
		33409,
		3,
		1237,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[33409004] = {
		33409004,
		0,
		Lang.get(99395),
		33409,
		4,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[33409005] = {
		33409005,
		0,
		Lang.get(99396),
		33409,
		5,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[33409006] = {
		33409006,
		0,
		Lang.get(99397),
		33409,
		6,
		300,
		{
			RTResTalkAction[11]
		}
	},
	[33409007] = {
		33409007,
		0,
		Lang.get(99398),
		33409,
		7,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409008] = {
		33409008,
		4,
		nil,
		33409,
		8,
		1237,
		{
			RTResTalkAction[11]
		},
		[29] = {
			{
				id = 33409009,
				branch_content = Lang.get(62777)
			},
			{
				id = 33409009,
				branch_content = Lang.get(99399)
			}
		}
	},
	[33409009] = {
		33409009,
		0,
		Lang.get(99400),
		33409,
		9,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409010] = {
		33409010,
		0,
		Lang.get(99401),
		33409,
		10,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409011] = {
		33409011,
		0,
		Lang.get(99402),
		33409,
		11,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409012] = {
		33409012,
		0,
		Lang.get(99403),
		33409,
		12,
		1237,
		{
			RTResTalkAction[11]
		}
	},
	[33409013] = {
		33409013,
		0,
		Lang.get(99404),
		33409,
		13,
		1237,
		{
			RTResTalkAction[11]
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
