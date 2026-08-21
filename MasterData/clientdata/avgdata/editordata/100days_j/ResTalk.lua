-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\100days_J\\ResTalk.lua

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
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 133
}
RTResTalkAction[5] = {
	[1] = 2,
	[2] = 141
}
RTResTalkAction[6] = {
	[1] = 3,
	[2] = 133
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 133
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 159
}
RTResTalkAction[11] = {
	[1] = 2,
	[2] = 158,
	[3] = {
		1
	}
}
RTResTalkAction[12] = {
	[1] = 3,
	[2] = 159
}
RTResTalkAction[13] = {
	[1] = 2,
	[2] = 158
}
RTResTalkAction[14] = {
	[1] = 0,
	[2] = 158
}
RTResTalkAction[15] = {
	[1] = 0,
	[2] = 159
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 158
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 109
}
RTResTalkAction[18] = {
	[1] = 1,
	[2] = 329
}
RTResTalkAction[19] = {
	[1] = 0,
	[2] = 109
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 329
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 237
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 237
}

local Data = {
	[22500001] = {
		22500001,
		0,
		Lang.get(52194),
		22500,
		1,
		107,
		nil,
		1,
		5,
		nil,
		nil,
		60,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22500
	},
	[22500002] = {
		22500002,
		4,
		nil,
		22500,
		2,
		107,
		[29] = {
			{
				id = 22500003,
				branch_content = Lang.get(52195)
			}
		}
	},
	[22500003] = {
		22500003,
		0,
		Lang.get(52196),
		22500,
		3,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		0,
		3
	},
	[22500004] = {
		22500004,
		0,
		Lang.get(52197),
		22500,
		4,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[22500005] = {
		22500005,
		5,
		Lang.get(52198),
		22500,
		5,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[22500006] = {
		22500006,
		4,
		nil,
		22500,
		6,
		107,
		{
			RTResTalkAction[3]
		},
		[29] = {
			{
				id = 22500007,
				branch_content = Lang.get(52199)
			}
		}
	},
	[22500007] = {
		22500007,
		2,
		Lang.get(52200),
		22500,
		7,
		300
	},
	[22500008] = {
		22500008,
		0,
		Lang.get(52201),
		22500,
		8,
		141,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22501,
		nil,
		nil,
		nil,
		1,
		nil,
		22501
	},
	[22500009] = {
		22500009,
		4,
		nil,
		22500,
		9,
		141,
		[29] = {
			{
				id = 22500010,
				branch_content = Lang.get(52202)
			}
		}
	},
	[22500010] = {
		22500010,
		0,
		Lang.get(52203),
		22500,
		10,
		133,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[22500011] = {
		22500011,
		0,
		Lang.get(52204),
		22500,
		11,
		141,
		{
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[22500012] = {
		22500012,
		0,
		Lang.get(52205),
		22500,
		12,
		141,
		{
			RTResTalkAction[7],
			RTResTalkAction[8]
		}
	},
	[22500013] = {
		22500013,
		4,
		nil,
		22500,
		13,
		141,
		{
			RTResTalkAction[9]
		},
		[29] = {
			{
				id = 22500014,
				branch_content = Lang.get(20302)
			}
		}
	},
	[22500014] = {
		22500014,
		0,
		Lang.get(52206),
		22500,
		14,
		158,
		nil,
		1,
		0,
		nil,
		nil,
		nil,
		22502,
		nil,
		nil,
		nil,
		1,
		nil,
		22502
	},
	[22500015] = {
		22500015,
		0,
		Lang.get(52207),
		22500,
		15,
		159,
		{
			RTResTalkAction[10]
		},
		nil,
		0,
		3
	},
	[22500016] = {
		22500016,
		0,
		Lang.get(52208),
		22500,
		16,
		159,
		{
			RTResTalkAction[10]
		}
	},
	[22500017] = {
		22500017,
		0,
		Lang.get(52209),
		22500,
		17,
		158,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[22500018] = {
		22500018,
		0,
		Lang.get(52210),
		22500,
		18,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[22500019] = {
		22500019,
		4,
		nil,
		22500,
		19,
		158,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		},
		[29] = {
			{
				id = 22500020,
				branch_content = Lang.get(52211)
			}
		}
	},
	[22500020] = {
		22500020,
		0,
		Lang.get(52212),
		22500,
		20,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[22500021] = {
		22500021,
		0,
		Lang.get(52213),
		22500,
		21,
		159,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[22500022] = {
		22500022,
		0,
		Lang.get(52214),
		22500,
		22,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[22500023] = {
		22500023,
		0,
		Lang.get(52215),
		22500,
		23,
		158,
		{
			RTResTalkAction[16],
			RTResTalkAction[15]
		}
	},
	[22500024] = {
		22500024,
		2,
		Lang.get(52216),
		22500,
		24,
		300,
		{
			RTResTalkAction[14]
		}
	},
	[22500025] = {
		22500025,
		9,
		Lang.get(52217),
		22500,
		25,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22503,
		nil,
		nil,
		nil,
		1,
		nil,
		22503,
		nil,
		nil,
		1
	},
	[22500026] = {
		22500026,
		0,
		Lang.get(52218),
		22500,
		26,
		109,
		nil,
		1,
		0
	},
	[22500027] = {
		22500027,
		4,
		nil,
		22500,
		27,
		109,
		[29] = {
			{
				id = 22500028,
				branch_content = Lang.get(52219)
			}
		}
	},
	[22500028] = {
		22500028,
		0,
		Lang.get(52220),
		22500,
		28,
		109,
		{
			RTResTalkAction[17]
		},
		nil,
		nil,
		3
	},
	[22500029] = {
		22500029,
		0,
		Lang.get(52221),
		22500,
		29,
		109,
		{
			RTResTalkAction[17]
		}
	},
	[22500030] = {
		22500030,
		4,
		nil,
		22500,
		30,
		109,
		{
			RTResTalkAction[17]
		},
		[29] = {
			{
				id = 22500031,
				branch_content = Lang.get(52222)
			}
		}
	},
	[22500031] = {
		22500031,
		0,
		Lang.get(52223),
		22500,
		31,
		109,
		{
			RTResTalkAction[17]
		}
	},
	[22500032] = {
		22500032,
		2,
		Lang.get(52224),
		22500,
		32,
		300,
		{
			RTResTalkAction[18],
			RTResTalkAction[19]
		},
		[21] = 329
	},
	[22500033] = {
		22500033,
		0,
		Lang.get(52225),
		22500,
		33,
		109,
		{
			RTResTalkAction[18]
		},
		1,
		0,
		[21] = 329
	},
	[22500034] = {
		22500034,
		4,
		nil,
		22500,
		34,
		109,
		{
			RTResTalkAction[20]
		},
		[29] = {
			{
				id = 22500035,
				branch_content = Lang.get(52226)
			}
		}
	},
	[22500035] = {
		22500035,
		9,
		Lang.get(52227),
		22500,
		35,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22504,
		nil,
		nil,
		nil,
		1,
		nil,
		22504,
		nil,
		nil,
		1
	},
	[22500036] = {
		22500036,
		0,
		Lang.get(52228),
		22500,
		36,
		237,
		{
			RTResTalkAction[21]
		},
		nil,
		nil,
		3
	},
	[22500037] = {
		22500037,
		0,
		Lang.get(52229),
		22500,
		37,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[22500038] = {
		22500038,
		0,
		Lang.get(52230),
		22500,
		38,
		237,
		{
			RTResTalkAction[21]
		}
	},
	[22500039] = {
		22500039,
		2,
		Lang.get(52231),
		22500,
		39,
		237,
		{
			RTResTalkAction[21]
		}
	},
	[22500040] = {
		22500040,
		2,
		Lang.get(52232),
		22500,
		40,
		237,
		{
			RTResTalkAction[21]
		}
	},
	[22500041] = {
		22500041,
		0,
		Lang.get(52233),
		22500,
		41,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[22500042] = {
		22500042,
		0,
		Lang.get(52234),
		22500,
		42,
		237,
		{
			RTResTalkAction[21]
		}
	},
	[22500043] = {
		22500043,
		0,
		Lang.get(52235),
		22500,
		43,
		237,
		{
			RTResTalkAction[21]
		}
	},
	[22500044] = {
		22500044,
		5,
		Lang.get(52236),
		22500,
		44,
		300,
		{
			RTResTalkAction[22]
		}
	},
	[22500045] = {
		22500045,
		0,
		Lang.get(52237),
		22500,
		45,
		605,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		22505,
		[19] = 22505,
		[17] = 1
	},
	[22500046] = {
		22500046,
		0,
		Lang.get(52238),
		22500,
		46,
		300
	},
	[22500047] = {
		22500047,
		0,
		Lang.get(52239),
		22500,
		47,
		141,
		{
			RTResTalkAction[7]
		},
		nil,
		nil,
		3
	},
	[22500048] = {
		22500048,
		0,
		Lang.get(52240),
		22500,
		48,
		237,
		{
			RTResTalkAction[21],
			RTResTalkAction[9]
		}
	},
	[22500049] = {
		22500049,
		0,
		Lang.get(52241),
		22500,
		49,
		158,
		{
			RTResTalkAction[13],
			RTResTalkAction[12],
			RTResTalkAction[22]
		}
	},
	[22500050] = {
		22500050,
		0,
		Lang.get(52242),
		22500,
		50,
		159,
		{
			RTResTalkAction[13],
			RTResTalkAction[12]
		}
	},
	[22500051] = {
		22500051,
		0,
		Lang.get(52243),
		22500,
		51,
		109,
		{
			RTResTalkAction[17],
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[22500052] = {
		22500052,
		0,
		Lang.get(52244),
		22500,
		52,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[19]
		}
	},
	[22500053] = {
		22500053,
		0,
		Lang.get(52245),
		22500,
		53,
		300,
		{
			RTResTalkAction[3]
		}
	},
	[22500054] = {
		22500054,
		0,
		Lang.get(52246),
		22500,
		54,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[22500055] = {
		22500055,
		0,
		Lang.get(52247),
		22500,
		55,
		300,
		{
			RTResTalkAction[3]
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
