-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023summer\\ResTalk.lua

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
	1048,
	nil,
	nil,
	0
}
RTResTalkAction[2] = {
	1,
	1053,
	nil,
	nil,
	0
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 1048
}
RTResTalkAction[4] = {
	1,
	1054,
	nil,
	nil,
	0
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 1053
}
RTResTalkAction[6] = {
	1,
	1051,
	nil,
	nil,
	0
}
RTResTalkAction[7] = {
	[1] = 0,
	[2] = 1054
}
RTResTalkAction[8] = {
	1,
	1049,
	nil,
	nil,
	0
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 1051
}
RTResTalkAction[10] = {
	1,
	1256,
	nil,
	nil,
	0
}
RTResTalkAction[11] = {
	[1] = 0,
	[2] = 1049
}
RTResTalkAction[12] = {
	1,
	1256,
	{
		3
	},
	nil,
	0
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 1256
}
RTResTalkAction[14] = {
	1,
	1255,
	nil,
	nil,
	0
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 1255
}
RTResTalkAction[16] = {
	1,
	1254,
	nil,
	nil,
	0
}
RTResTalkAction[17] = {
	1,
	1254,
	{
		2
	},
	nil,
	0
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 1254
}

local Data = {
	[38001001] = {
		38001001,
		9,
		Lang.get(101755),
		38001,
		1,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		194,
		38001,
		nil,
		nil,
		nil,
		nil,
		nil,
		38001,
		255,
		nil,
		1
	},
	[38001002] = {
		38001002,
		0,
		Lang.get(101756),
		38001,
		2,
		1048,
		nil,
		1,
		0,
		nil,
		nil,
		195,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		-1
	},
	[38001003] = {
		38001003,
		0,
		Lang.get(101757),
		38001,
		3,
		1257,
		nil,
		1,
		0
	},
	[38001004] = {
		38001004,
		4,
		nil,
		38001,
		4,
		300,
		[29] = {
			{
				id = 38001005,
				branch_content = Lang.get(101758)
			},
			{
				id = 38001005,
				branch_content = Lang.get(101759)
			}
		}
	},
	[38001005] = {
		38001005,
		0,
		Lang.get(101760),
		38001,
		5,
		1048,
		nil,
		1,
		0
	},
	[38001006] = {
		38001006,
		4,
		nil,
		38001,
		6,
		300,
		[29] = {
			{
				id = 38001007,
				branch_content = "……"
			}
		}
	},
	[38001007] = {
		38001007,
		0,
		Lang.get(101761),
		38001,
		7,
		1048,
		nil,
		1,
		0
	},
	[38001008] = {
		38001008,
		4,
		nil,
		38001,
		8,
		300,
		[29] = {
			{
				id = 38001009,
				branch_content = Lang.get(101762)
			},
			{
				id = 38001009,
				branch_content = Lang.get(101763)
			}
		}
	},
	[38001009] = {
		38001009,
		0,
		Lang.get(101764),
		38001,
		9,
		1048,
		nil,
		1,
		0
	},
	[38001010] = {
		38001010,
		4,
		nil,
		38001,
		10,
		300,
		[29] = {
			{
				id = 38001011,
				branch_content = Lang.get(101765)
			},
			{
				id = 38001011,
				branch_content = Lang.get(101766)
			}
		}
	},
	[38001011] = {
		38001011,
		0,
		Lang.get(101767),
		38001,
		11,
		1048,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[38001012] = {
		38001012,
		0,
		Lang.get(101768),
		38001,
		12,
		1048,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		},
		1,
		0,
		3,
		nil,
		nil,
		38002,
		nil,
		1,
		nil,
		0,
		nil,
		38002
	},
	[38001013] = {
		38001013,
		0,
		Lang.get(101769),
		38001,
		13,
		1053,
		{
			RTResTalkAction[2]
		}
	},
	[38001014] = {
		38001014,
		0,
		Lang.get(101770),
		38001,
		14,
		1048,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		},
		1,
		0
	},
	[38001015] = {
		38001015,
		0,
		Lang.get(101771),
		38001,
		15,
		1054,
		{
			RTResTalkAction[4]
		}
	},
	[38001016] = {
		38001016,
		0,
		Lang.get(101772),
		38001,
		16,
		1048,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		},
		1,
		0
	},
	[38001017] = {
		38001017,
		0,
		Lang.get(101773),
		38001,
		17,
		1051,
		{
			RTResTalkAction[6]
		}
	},
	[38001018] = {
		38001018,
		0,
		Lang.get(101774),
		38001,
		18,
		1048,
		{
			RTResTalkAction[8],
			RTResTalkAction[9]
		},
		1,
		0
	},
	[38001019] = {
		38001019,
		0,
		Lang.get(101775),
		38001,
		19,
		1049,
		{
			RTResTalkAction[8]
		}
	},
	[38001020] = {
		38001020,
		0,
		Lang.get(101776),
		38001,
		20,
		1048,
		{
			RTResTalkAction[8]
		},
		1,
		2
	},
	[38001021] = {
		38001021,
		0,
		Lang.get(101777),
		38001,
		21,
		1048,
		{
			RTResTalkAction[10],
			RTResTalkAction[11]
		},
		1,
		0
	},
	[38001022] = {
		38001022,
		0,
		Lang.get(101778),
		38001,
		22,
		1256,
		{
			RTResTalkAction[12]
		}
	},
	[38001023] = {
		38001023,
		0,
		Lang.get(101779),
		38001,
		23,
		1048,
		{
			RTResTalkAction[1],
			RTResTalkAction[13]
		}
	},
	[38001024] = {
		38001024,
		0,
		Lang.get(101780),
		38001,
		24,
		1048,
		{
			RTResTalkAction[14],
			RTResTalkAction[3]
		},
		1,
		0,
		3,
		nil,
		nil,
		38003,
		1,
		1,
		nil,
		0,
		nil,
		38003
	},
	[38001025] = {
		38001025,
		0,
		Lang.get(101781),
		38001,
		25,
		1255,
		{
			RTResTalkAction[14]
		}
	},
	[38001026] = {
		38001026,
		0,
		Lang.get(101782),
		38001,
		26,
		1255,
		{
			RTResTalkAction[14]
		}
	},
	[38001027] = {
		38001027,
		0,
		Lang.get(101783),
		38001,
		27,
		1048,
		{
			RTResTalkAction[14]
		},
		1,
		2
	},
	[38001028] = {
		38001028,
		0,
		Lang.get(101784),
		38001,
		28,
		1257,
		{
			RTResTalkAction[14]
		},
		1,
		0
	},
	[38001029] = {
		38001029,
		4,
		nil,
		38001,
		29,
		300,
		{
			RTResTalkAction[14]
		},
		[29] = {
			{
				id = 38001030,
				branch_content = "……"
			}
		}
	},
	[38001030] = {
		38001030,
		0,
		Lang.get(101785),
		38001,
		30,
		1048,
		{
			RTResTalkAction[14]
		},
		1,
		2
	},
	[38001031] = {
		38001031,
		3,
		Lang.get(101786),
		38001,
		31,
		605,
		{
			RTResTalkAction[15]
		},
		nil,
		nil,
		nil,
		1227,
		197,
		38004,
		1,
		1,
		nil,
		0,
		nil,
		38004,
		nil,
		nil,
		1
	},
	[38001032] = {
		38001032,
		3,
		Lang.get(101787),
		38001,
		32,
		605,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		nil,
		1,
		[22] = 1
	},
	[38001033] = {
		38001033,
		0,
		Lang.get(101788),
		38001,
		33,
		1254,
		{
			RTResTalkAction[16]
		},
		1,
		0
	},
	[38001034] = {
		38001034,
		4,
		nil,
		38001,
		34,
		300,
		{
			RTResTalkAction[16]
		},
		[29] = {
			{
				id = 38001035,
				branch_content = Lang.get(101789)
			},
			{
				id = 38001035,
				branch_content = Lang.get(101790)
			}
		}
	},
	[38001035] = {
		38001035,
		0,
		Lang.get(101791),
		38001,
		35,
		1254,
		{
			RTResTalkAction[16]
		},
		nil,
		0,
		nil,
		nil,
		nil,
		nil,
		1
	},
	[38001036] = {
		38001036,
		0,
		Lang.get(101792),
		38001,
		36,
		1254,
		{
			RTResTalkAction[17]
		}
	},
	[38001037] = {
		38001037,
		3,
		Lang.get(101793),
		38001,
		37,
		605,
		{
			RTResTalkAction[18]
		},
		nil,
		nil,
		-1,
		nil,
		nil,
		38005,
		1,
		1,
		nil,
		0,
		nil,
		38005,
		nil,
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
