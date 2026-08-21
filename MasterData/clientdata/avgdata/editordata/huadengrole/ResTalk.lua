-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\huadengrole\\ResTalk.lua

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
	[2] = 107
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[3] = {
	1,
	150,
	nil,
	nil,
	4
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 150
}
RTResTalkAction[5] = {
	1,
	150,
	nil,
	nil,
	0
}
RTResTalkAction[6] = {
	[1] = 1,
	[2] = 150
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 163
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 163
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 269
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 269
}
RTResTalkAction[13] = {
	[1] = 1,
	[2] = 270
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 270
}

local Data = {
	[25700001] = {
		25700001,
		10,
		"41",
		25700,
		1,
		nil,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25700002] = {
		25700002,
		0,
		Lang.get(62759),
		25700,
		2,
		107,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25700,
		nil,
		1,
		nil,
		1,
		nil,
		25700
	},
	[25700003] = {
		25700003,
		0,
		Lang.get(62760),
		25700,
		3,
		107,
		nil,
		1
	},
	[25700004] = {
		25700004,
		0,
		Lang.get(60068),
		25700,
		4,
		107,
		nil,
		1
	},
	[25700005] = {
		25700005,
		4,
		nil,
		25700,
		5,
		107,
		nil,
		1,
		[29] = {
			{
				id = 25700006,
				branch_content = Lang.get(62761)
			}
		}
	},
	[25700006] = {
		25700006,
		0,
		Lang.get(62762),
		25700,
		6,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[25700007] = {
		25700007,
		0,
		Lang.get(62763),
		25700,
		7,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[25700008] = {
		25700008,
		0,
		Lang.get(60072),
		25700,
		8,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[25700009] = {
		25700009,
		4,
		nil,
		25700,
		9,
		107,
		{
			RTResTalkAction[2]
		},
		[29] = {
			{
				id = 25700010,
				branch_content = Lang.get(62764)
			}
		}
	},
	[25700010] = {
		25700010,
		0,
		Lang.get(67763),
		25700,
		10,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[25710001] = {
		25710001,
		10,
		"42",
		25710,
		1,
		107,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25710002] = {
		25710002,
		0,
		Lang.get(60075),
		25710,
		2,
		150,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25710,
		nil,
		1,
		nil,
		1,
		nil,
		25710
	},
	[25710003] = {
		25710003,
		0,
		Lang.get(62766),
		25710,
		3,
		150,
		nil,
		1
	},
	[25710004] = {
		25710004,
		4,
		nil,
		25710,
		4,
		150,
		nil,
		1,
		[29] = {
			{
				id = 25710005,
				branch_content = Lang.get(60077)
			}
		}
	},
	[25710005] = {
		25710005,
		0,
		Lang.get(60078),
		25710,
		5,
		150,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3
	},
	[25710006] = {
		25710006,
		4,
		nil,
		25710,
		6,
		150,
		{
			RTResTalkAction[4]
		},
		[29] = {
			{
				id = 25710007,
				branch_content = Lang.get(60079)
			}
		}
	},
	[25710007] = {
		25710007,
		0,
		Lang.get(62767),
		25710,
		7,
		150,
		{
			RTResTalkAction[5]
		}
	},
	[25710008] = {
		25710008,
		0,
		Lang.get(62768),
		25710,
		8,
		150,
		{
			RTResTalkAction[6]
		}
	},
	[25710009] = {
		25710009,
		0,
		Lang.get(62769),
		25710,
		9,
		150,
		{
			RTResTalkAction[6]
		}
	},
	[25710010] = {
		25710010,
		0,
		Lang.get(60083),
		25710,
		10,
		150,
		{
			RTResTalkAction[6]
		}
	},
	[25710011] = {
		25710011,
		0,
		Lang.get(62770),
		25710,
		11,
		300,
		{
			RTResTalkAction[4]
		}
	},
	[25720001] = {
		25720001,
		10,
		"43",
		25720,
		1,
		300,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25720002] = {
		25720002,
		0,
		Lang.get(60084),
		25720,
		2,
		133,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25720,
		nil,
		1,
		nil,
		1,
		nil,
		25720
	},
	[25720003] = {
		25720003,
		0,
		Lang.get(60085),
		25720,
		3,
		133,
		nil,
		1
	},
	[25720004] = {
		25720004,
		4,
		nil,
		25720,
		4,
		133,
		nil,
		1,
		[29] = {
			{
				id = 25720005,
				branch_content = Lang.get(60086)
			}
		}
	},
	[25720005] = {
		25720005,
		0,
		Lang.get(60087),
		25720,
		5,
		133,
		nil,
		1
	},
	[25720006] = {
		25720006,
		0,
		Lang.get(62771),
		25720,
		6,
		133,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[25720007] = {
		25720007,
		0,
		Lang.get(60090),
		25720,
		7,
		133,
		{
			RTResTalkAction[7]
		}
	},
	[25720008] = {
		25720008,
		4,
		nil,
		25720,
		8,
		133,
		{
			RTResTalkAction[8]
		},
		[29] = {
			{
				id = 25720009,
				branch_content = Lang.get(60091)
			}
		}
	},
	[25720009] = {
		25720009,
		0,
		Lang.get(62772),
		25720,
		9,
		133,
		{
			RTResTalkAction[7]
		}
	},
	[25730001] = {
		25730001,
		10,
		"44",
		25730,
		1,
		133,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25730002] = {
		25730002,
		0,
		Lang.get(60093),
		25730,
		2,
		163,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25730,
		nil,
		1,
		nil,
		1,
		nil,
		25730
	},
	[25730003] = {
		25730003,
		4,
		nil,
		25730,
		3,
		163,
		nil,
		1,
		[29] = {
			{
				id = 25730004,
				branch_content = Lang.get(60094)
			}
		}
	},
	[25730004] = {
		25730004,
		0,
		Lang.get(62773),
		25730,
		4,
		163,
		nil,
		1,
		4
	},
	[25730005] = {
		25730005,
		0,
		Lang.get(60096),
		25730,
		5,
		163,
		{
			RTResTalkAction[9]
		},
		nil,
		nil,
		3
	},
	[25730006] = {
		25730006,
		4,
		nil,
		25730,
		6,
		163,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 25730007,
				branch_content = Lang.get(60097)
			}
		}
	},
	[25730007] = {
		25730007,
		0,
		Lang.get(62774),
		25730,
		7,
		163,
		{
			RTResTalkAction[9]
		}
	},
	[25730008] = {
		25730008,
		0,
		Lang.get(60099),
		25730,
		8,
		163,
		{
			RTResTalkAction[9]
		}
	},
	[25730009] = {
		25730009,
		4,
		nil,
		25730,
		9,
		163,
		{
			RTResTalkAction[10]
		},
		[29] = {
			{
				id = 25730010,
				branch_content = Lang.get(60100)
			}
		}
	},
	[25730010] = {
		25730010,
		0,
		Lang.get(62775),
		25730,
		10,
		163,
		{
			RTResTalkAction[9]
		}
	},
	[25740001] = {
		25740001,
		10,
		"45",
		25740,
		1,
		163,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25740002] = {
		25740002,
		0,
		Lang.get(62776),
		25740,
		2,
		269,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25740,
		nil,
		1,
		nil,
		1,
		nil,
		25740
	},
	[25740003] = {
		25740003,
		4,
		nil,
		25740,
		3,
		269,
		nil,
		1,
		[29] = {
			{
				id = 25740004,
				branch_content = Lang.get(62777)
			}
		}
	},
	[25740004] = {
		25740004,
		0,
		Lang.get(62778),
		25740,
		4,
		269,
		{
			RTResTalkAction[11]
		},
		nil,
		nil,
		3
	},
	[25740005] = {
		25740005,
		0,
		Lang.get(62779),
		25740,
		5,
		269,
		{
			RTResTalkAction[11]
		}
	},
	[25740006] = {
		25740006,
		4,
		nil,
		25740,
		6,
		269,
		{
			RTResTalkAction[12]
		},
		[29] = {
			{
				id = 25740007,
				branch_content = Lang.get(22568)
			}
		}
	},
	[25740007] = {
		25740007,
		0,
		Lang.get(60106),
		25740,
		7,
		269,
		{
			RTResTalkAction[11]
		}
	},
	[25740008] = {
		25740008,
		0,
		Lang.get(62780),
		25740,
		8,
		269,
		{
			RTResTalkAction[11]
		}
	},
	[25740009] = {
		25740009,
		0,
		Lang.get(67764),
		25740,
		9,
		269,
		{
			RTResTalkAction[11]
		}
	},
	[25750001] = {
		25750001,
		10,
		"46",
		25750,
		1,
		269,
		nil,
		nil,
		nil,
		5,
		nil,
		171
	},
	[25750002] = {
		25750002,
		0,
		Lang.get(60109),
		25750,
		2,
		270,
		nil,
		1,
		nil,
		nil,
		nil,
		nil,
		25750,
		nil,
		1,
		nil,
		1,
		nil,
		25750
	},
	[25750003] = {
		25750003,
		4,
		nil,
		25750,
		3,
		270,
		nil,
		1,
		[29] = {
			{
				id = 25750004,
				branch_content = Lang.get(60110)
			}
		}
	},
	[25750004] = {
		25750004,
		0,
		Lang.get(60111),
		25750,
		4,
		270,
		{
			RTResTalkAction[13]
		},
		nil,
		nil,
		3
	},
	[25750005] = {
		25750005,
		0,
		Lang.get(62781),
		25750,
		5,
		270,
		{
			RTResTalkAction[13]
		}
	},
	[25750006] = {
		25750006,
		4,
		nil,
		25750,
		6,
		270,
		{
			RTResTalkAction[14]
		},
		[29] = {
			{
				id = 25750007,
				branch_content = Lang.get(60113)
			}
		}
	},
	[25750007] = {
		25750007,
		0,
		Lang.get(60114),
		25750,
		7,
		270,
		{
			RTResTalkAction[13]
		}
	},
	[25750008] = {
		25750008,
		0,
		Lang.get(60115),
		25750,
		8,
		270,
		{
			RTResTalkAction[13]
		}
	},
	[25750009] = {
		25750009,
		0,
		Lang.get(62782),
		25750,
		9,
		270,
		{
			RTResTalkAction[13]
		}
	},
	[25750010] = {
		25750010,
		0,
		Lang.get(62783),
		25750,
		10,
		270,
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
