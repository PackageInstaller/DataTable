-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\signin-springfestival\\ResTalk.lua

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
	[2] = 269
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 269
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 270
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 270
}
RTResTalkAction[5] = {
	[1] = 2,
	[2] = 269
}
RTResTalkAction[6] = {
	[1] = 3,
	[2] = 270
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 149
}
RTResTalkAction[9] = {
	[1] = 2,
	[2] = 149
}
RTResTalkAction[10] = {
	3,
	179,
	nil,
	nil,
	1
}
RTResTalkAction[11] = {
	[1] = 3,
	[2] = 179
}
RTResTalkAction[12] = {
	3,
	179,
	nil,
	nil,
	0
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 149
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 179
}
RTResTalkAction[15] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[16] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[17] = {
	[1] = 3,
	[2] = 149
}
RTResTalkAction[18] = {
	[1] = 3,
	[2] = 167
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 167
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 167
}

local Data = {
	[25600001] = {
		25600001,
		0,
		Lang.get(62835),
		25600,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		169,
		25600,
		nil,
		1,
		nil,
		1,
		nil,
		25600
	},
	[25600002] = {
		25600002,
		0,
		Lang.get(60655),
		25600,
		2,
		269,
		nil,
		1
	},
	[25600003] = {
		25600003,
		0,
		Lang.get(60656),
		25600,
		3,
		269,
		nil,
		1
	},
	[25600004] = {
		25600004,
		4,
		nil,
		25600,
		4,
		269,
		nil,
		1,
		[29] = {
			{
				id = 25600005,
				branch_content = Lang.get(60657)
			},
			{
				id = 25600005,
				branch_content = Lang.get(60658)
			}
		}
	},
	[25600005] = {
		25600005,
		0,
		Lang.get(60659),
		25600,
		5,
		269,
		nil,
		1
	},
	[25600006] = {
		25600006,
		0,
		Lang.get(60660),
		25600,
		6,
		269,
		nil,
		1
	},
	[25600007] = {
		25600007,
		0,
		Lang.get(60661),
		25600,
		7,
		269,
		nil,
		1
	},
	[25600008] = {
		25600008,
		0,
		Lang.get(62836),
		25600,
		8,
		269,
		nil,
		1
	},
	[25600009] = {
		25600009,
		4,
		nil,
		25600,
		9,
		269,
		nil,
		1,
		[29] = {
			{
				id = 25600010,
				branch_content = Lang.get(60663)
			}
		}
	},
	[25600010] = {
		25600010,
		0,
		Lang.get(60664),
		25600,
		10,
		269,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25600011] = {
		25600011,
		0,
		Lang.get(60665),
		25600,
		11,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25600012] = {
		25600012,
		0,
		Lang.get(60666),
		25600,
		12,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25600013] = {
		25600013,
		4,
		nil,
		25600,
		13,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 25600014,
				branch_content = Lang.get(21953)
			}
		}
	},
	[25600014] = {
		25600014,
		0,
		Lang.get(60667),
		25600,
		14,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25600015] = {
		25600015,
		0,
		Lang.get(60668),
		25600,
		15,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[25600016] = {
		25600016,
		0,
		Lang.get(60669),
		25600,
		16,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25600017] = {
		25600017,
		0,
		Lang.get(62837),
		25600,
		17,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25610001] = {
		25610001,
		0,
		Lang.get(60671),
		25610,
		1,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		171,
		25610,
		nil,
		1,
		nil,
		1,
		nil,
		25610
	},
	[25610002] = {
		25610002,
		0,
		Lang.get(62838),
		25610,
		2,
		133,
		nil,
		1
	},
	[25610003] = {
		25610003,
		0,
		Lang.get(60673),
		25610,
		3,
		141,
		nil,
		1
	},
	[25610004] = {
		25610004,
		0,
		Lang.get(62839),
		25610,
		4,
		269,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25610005] = {
		25610005,
		0,
		Lang.get(60675),
		25610,
		5,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25610006] = {
		25610006,
		0,
		Lang.get(62840),
		25610,
		6,
		270,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[25610007] = {
		25610007,
		0,
		Lang.get(60678),
		25610,
		7,
		269,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[25610008] = {
		25610008,
		0,
		Lang.get(60679),
		25610,
		8,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25610009] = {
		25610009,
		0,
		Lang.get(62841),
		25610,
		9,
		270,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[25610010] = {
		25610010,
		0,
		Lang.get(62842),
		25610,
		10,
		269,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[25610011] = {
		25610011,
		0,
		Lang.get(60682),
		25610,
		11,
		730,
		{
			RTResTalkAction[2]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25611,
		nil,
		1,
		nil,
		1,
		nil,
		25611
	},
	[25610012] = {
		25610012,
		0,
		Lang.get(62843),
		25610,
		12,
		269,
		nil,
		1
	},
	[25610013] = {
		25610013,
		0,
		Lang.get(60684),
		25610,
		13,
		730,
		nil,
		1
	},
	[25610014] = {
		25610014,
		0,
		Lang.get(60685),
		25610,
		14,
		269,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25610015] = {
		25610015,
		0,
		Lang.get(66387),
		25610,
		15,
		270,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[25610016] = {
		25610016,
		0,
		Lang.get(66388),
		25610,
		16,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[4]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		25612,
		nil,
		1,
		nil,
		1,
		nil,
		25612
	},
	[25610017] = {
		25610017,
		0,
		Lang.get(60689),
		25610,
		17,
		300,
		nil,
		nil,
		nil,
		3
	},
	[25610018] = {
		25610018,
		0,
		Lang.get(60690),
		25610,
		18,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[25620001] = {
		25620001,
		9,
		Lang.get(60691),
		25620,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		123,
		25620,
		nil,
		1,
		nil,
		1,
		nil,
		25620,
		nil,
		nil,
		1
	},
	[25620002] = {
		25620002,
		0,
		Lang.get(62844),
		25620,
		2,
		107,
		nil,
		1
	},
	[25620003] = {
		25620003,
		0,
		Lang.get(60693),
		25620,
		3,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25621,
		[19] = 25621,
		[17] = 1
	},
	[25620004] = {
		25620004,
		0,
		Lang.get(62845),
		25620,
		4,
		107,
		nil,
		1,
		10
	},
	[25620005] = {
		25620005,
		0,
		Lang.get(60695),
		25620,
		5,
		269,
		nil,
		1,
		0
	},
	[25620006] = {
		25620006,
		0,
		Lang.get(60696),
		25620,
		6,
		149,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25622,
		[19] = 25622,
		[17] = 1
	},
	[25620007] = {
		25620007,
		0,
		Lang.get(60697),
		25620,
		7,
		179,
		nil,
		1
	},
	[25620008] = {
		25620008,
		0,
		Lang.get(62846),
		25620,
		8,
		149,
		{
			RTResTalkAction[8]
		},
		nil,
		nil,
		3
	},
	[25620009] = {
		25620009,
		0,
		Lang.get(62847),
		25620,
		9,
		179,
		{
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[25620010] = {
		25620010,
		0,
		Lang.get(62848),
		25620,
		10,
		149,
		{
			RTResTalkAction[9],
			RTResTalkAction[11]
		}
	},
	[25620011] = {
		25620011,
		0,
		Lang.get(62849),
		25620,
		11,
		179,
		{
			RTResTalkAction[9],
			RTResTalkAction[12]
		}
	},
	[25620012] = {
		25620012,
		0,
		Lang.get(60702),
		25620,
		12,
		269,
		{
			RTResTalkAction[1],
			RTResTalkAction[13],
			RTResTalkAction[14]
		}
	},
	[25620013] = {
		25620013,
		0,
		Lang.get(60703),
		25620,
		13,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25620014] = {
		25620014,
		0,
		Lang.get(60704),
		25620,
		14,
		107,
		{
			RTResTalkAction[15],
			RTResTalkAction[2]
		}
	},
	[25620015] = {
		25620015,
		0,
		Lang.get(60705),
		25620,
		15,
		300,
		{
			RTResTalkAction[16]
		}
	},
	[25620016] = {
		25620016,
		0,
		Lang.get(60706),
		25620,
		16,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25620017] = {
		25620017,
		0,
		Lang.get(62850),
		25620,
		17,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[25620018] = {
		25620018,
		11,
		"Videos/AVG_spring_2022.mp4",
		25620,
		18,
		300
	},
	[25630001] = {
		25630001,
		0,
		Lang.get(62851),
		25630,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		109,
		25630,
		nil,
		1,
		nil,
		1,
		nil,
		25630
	},
	[25630002] = {
		25630002,
		0,
		Lang.get(62852),
		25630,
		2,
		149,
		nil,
		1
	},
	[25630003] = {
		25630003,
		0,
		Lang.get(60709),
		25630,
		3,
		149,
		nil,
		1
	},
	[25630004] = {
		25630004,
		5,
		Lang.get(60710),
		25630,
		4,
		167,
		nil,
		1
	},
	[25630005] = {
		25630005,
		0,
		Lang.get(60711),
		25630,
		5,
		149,
		nil,
		1
	},
	[25630006] = {
		25630006,
		4,
		nil,
		25630,
		6,
		149,
		nil,
		1,
		nil,
		3,
		[29] = {
			{
				id = 25630007,
				branch_content = Lang.get(60712)
			}
		}
	},
	[25630007] = {
		25630007,
		0,
		Lang.get(60713),
		25630,
		7,
		149,
		{
			RTResTalkAction[8]
		}
	},
	[25630008] = {
		25630008,
		0,
		Lang.get(62853),
		25630,
		8,
		149,
		{
			RTResTalkAction[8]
		}
	},
	[25630009] = {
		25630009,
		0,
		Lang.get(60715),
		25630,
		9,
		269,
		{
			RTResTalkAction[5],
			RTResTalkAction[17]
		}
	},
	[25630010] = {
		25630010,
		0,
		Lang.get(62854),
		25630,
		10,
		149,
		{
			RTResTalkAction[8],
			RTResTalkAction[2]
		}
	},
	[25630011] = {
		25630011,
		0,
		Lang.get(60717),
		25630,
		11,
		270,
		{
			RTResTalkAction[9],
			RTResTalkAction[6]
		}
	},
	[25630012] = {
		25630012,
		0,
		Lang.get(62855),
		25630,
		12,
		149,
		{
			RTResTalkAction[8],
			RTResTalkAction[4]
		}
	},
	[25630013] = {
		25630013,
		0,
		Lang.get(62856),
		25630,
		13,
		149,
		{
			RTResTalkAction[8]
		}
	},
	[25630014] = {
		25630014,
		0,
		Lang.get(60720),
		25630,
		14,
		167,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[25630015] = {
		25630015,
		0,
		Lang.get(60721),
		25630,
		15,
		149,
		{
			RTResTalkAction[9],
			RTResTalkAction[18]
		}
	},
	[25630016] = {
		25630016,
		0,
		Lang.get(60722),
		25630,
		16,
		167,
		{
			RTResTalkAction[19],
			RTResTalkAction[13]
		}
	},
	[25630017] = {
		25630017,
		0,
		Lang.get(62857),
		25630,
		17,
		149,
		{
			RTResTalkAction[8],
			RTResTalkAction[20]
		}
	},
	[25630018] = {
		25630018,
		0,
		Lang.get(60724),
		25630,
		18,
		167,
		{
			RTResTalkAction[19],
			RTResTalkAction[13]
		}
	},
	[25630019] = {
		25630019,
		0,
		Lang.get(60725),
		25630,
		19,
		269,
		{
			RTResTalkAction[1],
			RTResTalkAction[20]
		}
	},
	[25630020] = {
		25630020,
		0,
		Lang.get(60726),
		25630,
		20,
		270,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[25630021] = {
		25630021,
		4,
		nil,
		25630,
		21,
		270,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 25630022,
				branch_content = Lang.get(60727)
			}
		}
	},
	[25630022] = {
		25630022,
		0,
		Lang.get(62858),
		25630,
		22,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640001] = {
		25640001,
		0,
		Lang.get(60729),
		25640,
		1,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		58,
		25640,
		nil,
		1,
		nil,
		1,
		nil,
		25640
	},
	[25640002] = {
		25640002,
		0,
		Lang.get(60730),
		25640,
		2,
		269,
		nil,
		1
	},
	[25640003] = {
		25640003,
		4,
		nil,
		25640,
		3,
		269,
		nil,
		1,
		nil,
		3,
		[29] = {
			{
				id = 25640004,
				branch_content = Lang.get(60731)
			}
		}
	},
	[25640004] = {
		25640004,
		0,
		Lang.get(60732),
		25640,
		4,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640005] = {
		25640005,
		0,
		Lang.get(60733),
		25640,
		5,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640006] = {
		25640006,
		0,
		Lang.get(60734),
		25640,
		6,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640007] = {
		25640007,
		4,
		nil,
		25640,
		7,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 25640008,
				branch_content = Lang.get(60735)
			}
		}
	},
	[25640008] = {
		25640008,
		0,
		Lang.get(60736),
		25640,
		8,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640009] = {
		25640009,
		0,
		Lang.get(60737),
		25640,
		9,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640010] = {
		25640010,
		0,
		Lang.get(60738),
		25640,
		10,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640011] = {
		25640011,
		4,
		nil,
		25640,
		11,
		269,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 25640012,
				branch_content = Lang.get(60739)
			}
		}
	},
	[25640012] = {
		25640012,
		0,
		Lang.get(60740),
		25640,
		12,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640013] = {
		25640013,
		0,
		Lang.get(62859),
		25640,
		13,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640014] = {
		25640014,
		0,
		Lang.get(60742),
		25640,
		14,
		269,
		{
			RTResTalkAction[1]
		}
	},
	[25640015] = {
		25640015,
		0,
		Lang.get(62860),
		25640,
		15,
		300,
		{
			RTResTalkAction[2]
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
