-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\DOAYURE\\ResTalk.lua

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
	[2] = 1149
}
RTResTalkAction[2] = {
	1,
	1149,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[3] = {
	1,
	1149,
	nil,
	nil,
	0
}
RTResTalkAction[4] = {
	1,
	1149,
	nil,
	nil,
	3
}
RTResTalkAction[5] = {
	[1] = 2,
	[2] = 1150,
	[3] = {
		2
	}
}
RTResTalkAction[6] = {
	[1] = 3,
	[2] = 1149
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 1150
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 1149
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 1150,
	[3] = {
		3
	}
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 1150,
	[3] = {
		2
	}
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1151
}
RTResTalkAction[12] = {
	1,
	1151,
	{
		2
	},
	nil,
	3
}
RTResTalkAction[13] = {
	1,
	1151,
	nil,
	nil,
	4
}
RTResTalkAction[14] = {
	2,
	1151,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 1152,
	[3] = {
		1
	}
}
RTResTalkAction[16] = {
	[1] = 2,
	[2] = 1151
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 1152
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 1152
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 1151
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 1152
}
RTResTalkAction[21] = {
	2,
	1157,
	{
		2
	},
	nil,
	2
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 1157
}
RTResTalkAction[23] = {
	[1] = 1,
	[2] = 1152,
	[3] = {
		2
	}
}
RTResTalkAction[24] = {
	[1] = 1,
	[2] = 1153
}
RTResTalkAction[25] = {
	[1] = 1,
	[2] = 1154
}
RTResTalkAction[26] = {
	[1] = 0,
	[2] = 1153
}
RTResTalkAction[27] = {
	1,
	1158,
	nil,
	nil,
	2
}
RTResTalkAction[28] = {
	[1] = 0,
	[2] = 1154
}
RTResTalkAction[29] = {
	1,
	1158,
	nil,
	nil,
	0
}
RTResTalkAction[30] = {
	[1] = 1,
	[2] = 1158,
	[3] = {
		2
	}
}
RTResTalkAction[31] = {
	[1] = 0,
	[2] = 1158
}

local Data = {
	[34900001] = {
		34900001,
		0,
		Lang.get(89748),
		34900,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		34900,
		nil,
		nil,
		nil,
		nil,
		nil,
		34900
	},
	[34900002] = {
		34900002,
		0,
		Lang.get(89749),
		34900,
		2,
		107,
		nil,
		1,
		5
	},
	[34900003] = {
		34900003,
		0,
		Lang.get(89750),
		34900,
		3,
		244,
		nil,
		1,
		3
	},
	[34900004] = {
		34900004,
		0,
		Lang.get(89751),
		34900,
		4,
		107,
		nil,
		1,
		0
	},
	[34900005] = {
		34900005,
		0,
		Lang.get(89752),
		34900,
		5,
		107,
		nil,
		1
	},
	[34900006] = {
		34900006,
		0,
		Lang.get(89753),
		34900,
		6,
		107,
		nil,
		1,
		7,
		nil,
		nil,
		nil,
		34901,
		nil,
		nil,
		nil,
		nil,
		nil,
		34901
	},
	[34900007] = {
		34900007,
		0,
		Lang.get(89754),
		34900,
		7,
		1149,
		nil,
		1
	},
	[34900008] = {
		34900008,
		0,
		Lang.get(89755),
		34900,
		8,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		0,
		3
	},
	[34900009] = {
		34900009,
		0,
		Lang.get(89756),
		34900,
		9,
		1149,
		{
			RTResTalkAction[2]
		}
	},
	[34900010] = {
		34900010,
		0,
		Lang.get(89757),
		34900,
		10,
		1149,
		{
			RTResTalkAction[3]
		}
	},
	[34900011] = {
		34900011,
		0,
		Lang.get(89758),
		34900,
		11,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		6
	},
	[34900012] = {
		34900012,
		0,
		Lang.get(89759),
		34900,
		12,
		244,
		{
			RTResTalkAction[1]
		},
		1,
		3
	},
	[34900013] = {
		34900013,
		0,
		Lang.get(89760),
		34900,
		13,
		1149,
		{
			RTResTalkAction[3]
		}
	},
	[34900014] = {
		34900014,
		0,
		Lang.get(89761),
		34900,
		14,
		1149,
		{
			RTResTalkAction[4]
		}
	},
	[34900015] = {
		34900015,
		0,
		Lang.get(89762),
		34900,
		15,
		107,
		{
			RTResTalkAction[1]
		},
		1,
		5
	},
	[34900016] = {
		34900016,
		0,
		Lang.get(89763),
		34900,
		16,
		1150,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[34900017] = {
		34900017,
		0,
		Lang.get(89764),
		34900,
		17,
		1150,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		},
		1,
		0,
		nil,
		nil,
		nil,
		34902,
		1,
		1,
		nil,
		1,
		nil,
		34902
	},
	[34900018] = {
		34900018,
		0,
		Lang.get(89765),
		34900,
		18,
		1150,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[34900019] = {
		34900019,
		0,
		Lang.get(89766),
		34900,
		19,
		107,
		{
			RTResTalkAction[7]
		},
		1
	},
	[34900020] = {
		34900020,
		0,
		Lang.get(89767),
		34900,
		20,
		1150,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		nil,
		nil,
		158
	},
	[34900021] = {
		34900021,
		0,
		Lang.get(89768),
		34900,
		21,
		244,
		{
			RTResTalkAction[7]
		},
		1,
		2
	},
	[34900022] = {
		34900022,
		0,
		Lang.get(89769),
		34900,
		22,
		1150,
		{
			RTResTalkAction[10]
		}
	},
	[34901023] = {
		34901023,
		0,
		Lang.get(89770),
		34900,
		23,
		107,
		{
			RTResTalkAction[7]
		},
		1,
		1
	},
	[34901001] = {
		34901001,
		0,
		Lang.get(89771),
		34901,
		1,
		1151,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		34910,
		nil,
		nil,
		nil,
		nil,
		nil,
		34910
	},
	[34901002] = {
		34901002,
		0,
		Lang.get(89772),
		34901,
		2,
		1151,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[34901003] = {
		34901003,
		0,
		Lang.get(89773),
		34901,
		3,
		107,
		{
			RTResTalkAction[11]
		},
		1,
		6
	},
	[34901004] = {
		34901004,
		0,
		Lang.get(89774),
		34901,
		4,
		1151,
		{
			RTResTalkAction[11]
		}
	},
	[34901005] = {
		34901005,
		0,
		Lang.get(89775),
		34901,
		5,
		107,
		{
			RTResTalkAction[11]
		},
		1,
		2
	},
	[34901006] = {
		34901006,
		0,
		Lang.get(89776),
		34901,
		6,
		244,
		{
			RTResTalkAction[11]
		},
		1,
		0
	},
	[34901007] = {
		34901007,
		0,
		Lang.get(89777),
		34901,
		7,
		1151,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		60
	},
	[34901008] = {
		34901008,
		0,
		Lang.get(89778),
		34901,
		8,
		107,
		{
			RTResTalkAction[11]
		},
		1,
		1
	},
	[34901009] = {
		34901009,
		0,
		Lang.get(89779),
		34901,
		9,
		1151,
		{
			RTResTalkAction[13]
		}
	},
	[34901010] = {
		34901010,
		0,
		Lang.get(89780),
		34901,
		10,
		107,
		{
			RTResTalkAction[11]
		},
		1,
		1
	},
	[34901011] = {
		34901011,
		0,
		Lang.get(89781),
		34901,
		11,
		1152,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[34901012] = {
		34901012,
		0,
		Lang.get(89782),
		34901,
		12,
		1152,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		}
	},
	[34901013] = {
		34901013,
		0,
		Lang.get(89783),
		34901,
		13,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		1,
		0
	},
	[34901014] = {
		34901014,
		0,
		Lang.get(89784),
		34901,
		14,
		107,
		{
			RTResTalkAction[16],
			RTResTalkAction[17]
		},
		1
	},
	[34901015] = {
		34901015,
		0,
		Lang.get(89785),
		34901,
		15,
		1152,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		}
	},
	[34901016] = {
		34901016,
		0,
		Lang.get(89786),
		34901,
		16,
		1152,
		{
			RTResTalkAction[20]
		},
		1,
		0,
		nil,
		nil,
		59,
		34911,
		1,
		1,
		nil,
		1,
		nil,
		34911
	},
	[34901017] = {
		34901017,
		0,
		Lang.get(89787),
		34901,
		17,
		1152,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		3
	},
	[34901018] = {
		34901018,
		0,
		Lang.get(89788),
		34901,
		18,
		1152,
		{
			RTResTalkAction[18]
		}
	},
	[34901019] = {
		34901019,
		0,
		Lang.get(89789),
		34901,
		19,
		1152,
		{
			RTResTalkAction[18]
		}
	},
	[34901020] = {
		34901020,
		0,
		Lang.get(89790),
		34901,
		20,
		107,
		{
			RTResTalkAction[18]
		},
		1,
		8
	},
	[34901021] = {
		34901021,
		0,
		Lang.get(89791),
		34901,
		21,
		1152,
		{
			RTResTalkAction[18]
		}
	},
	[34901022] = {
		34901022,
		0,
		Lang.get(89792),
		34901,
		22,
		244,
		{
			RTResTalkAction[18]
		},
		1,
		3
	},
	[34901023] = {
		34901023,
		0,
		Lang.get(89793),
		34901,
		23,
		1157,
		{
			RTResTalkAction[18]
		},
		1,
		3,
		nil,
		nil,
		60
	},
	[34901024] = {
		34901024,
		0,
		Lang.get(89794),
		34901,
		24,
		1157,
		{
			RTResTalkAction[21],
			RTResTalkAction[17]
		}
	},
	[34901025] = {
		34901025,
		0,
		Lang.get(89795),
		34901,
		25,
		1157,
		{
			RTResTalkAction[18],
			RTResTalkAction[22]
		},
		1,
		3
	},
	[34901026] = {
		34901026,
		0,
		Lang.get(89796),
		34901,
		26,
		1152,
		{
			RTResTalkAction[23]
		}
	},
	[34902001] = {
		34902001,
		0,
		Lang.get(89797),
		34902,
		1,
		1153,
		{
			RTResTalkAction[24]
		},
		nil,
		nil,
		3,
		nil,
		62,
		34920,
		1,
		1,
		nil,
		1,
		nil,
		34920
	},
	[34902002] = {
		34902002,
		0,
		Lang.get(89798),
		34902,
		2,
		1154,
		{
			RTResTalkAction[25],
			RTResTalkAction[26]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		1,
		1,
		[17] = 1
	},
	[34902003] = {
		34902003,
		0,
		Lang.get(89799),
		34902,
		3,
		1158,
		{
			RTResTalkAction[27],
			RTResTalkAction[28]
		}
	},
	[34902004] = {
		34902004,
		0,
		Lang.get(89800),
		34902,
		4,
		1158,
		{
			RTResTalkAction[29]
		}
	},
	[34902005] = {
		34902005,
		0,
		Lang.get(89801),
		34902,
		5,
		1158,
		{
			RTResTalkAction[30]
		}
	},
	[34902006] = {
		34902006,
		3,
		Lang.get(89802),
		34902,
		6,
		605,
		{
			RTResTalkAction[31]
		},
		[22] = 1,
		[20] = 200
	},
	[34902007] = {
		34902007,
		0,
		Lang.get(89803),
		34902,
		7,
		300,
		nil,
		nil,
		nil,
		-1,
		nil,
		29,
		34921,
		nil,
		nil,
		nil,
		nil,
		nil,
		34921,
		0
	},
	[34902008] = {
		34902008,
		0,
		Lang.get(89804),
		34902,
		8,
		107,
		nil,
		1,
		0
	},
	[34902009] = {
		34902009,
		4,
		nil,
		34902,
		9,
		300,
		[29] = {
			{
				id = 34902010,
				branch_content = Lang.get(89805)
			},
			{
				id = 34902010,
				branch_content = Lang.get(89806)
			}
		}
	},
	[34902010] = {
		34902010,
		0,
		Lang.get(89807),
		34902,
		10,
		244,
		nil,
		1,
		3
	},
	[34902011] = {
		34902011,
		0,
		Lang.get(89808),
		34902,
		11,
		107,
		nil,
		1,
		5
	},
	[34902012] = {
		34902012,
		0,
		Lang.get(89809),
		34902,
		12,
		300
	},
	[34902013] = {
		34902013,
		0,
		Lang.get(89810),
		34902,
		13,
		107,
		nil,
		1,
		7
	},
	[34902014] = {
		34902014,
		0,
		Lang.get(89811),
		34902,
		14,
		300
	},
	[34902015] = {
		34902015,
		0,
		Lang.get(89812),
		34902,
		15,
		244,
		nil,
		1,
		3
	},
	[34902016] = {
		34902016,
		0,
		Lang.get(89813),
		34902,
		16,
		300
	},
	[34902017] = {
		34902017,
		0,
		Lang.get(89814),
		34902,
		17,
		107,
		nil,
		1,
		0
	},
	[34902018] = {
		34902018,
		0,
		Lang.get(89815),
		34902,
		18,
		1155,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		34922,
		1,
		nil,
		nil,
		nil,
		nil,
		34922
	},
	[34902019] = {
		34902019,
		0,
		Lang.get(89816),
		34902,
		19,
		300
	},
	[34902020] = {
		34902020,
		0,
		"……",
		34902,
		20,
		1156,
		nil,
		1,
		nil,
		nil,
		nil,
		63,
		34923,
		1,
		nil,
		nil,
		nil,
		nil,
		34923
	},
	[34902021] = {
		34902021,
		0,
		Lang.get(89817),
		34902,
		21,
		1156,
		nil,
		1,
		1
	},
	[34902022] = {
		34902022,
		0,
		Lang.get(21152),
		34902,
		22,
		1156,
		nil,
		1
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
