-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\mudanzhu\\ResTalk.lua

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
	[1] = 2,
	[2] = 107
}
RTResTalkAction[3] = {
	[1] = 3,
	[2] = 141
}
RTResTalkAction[4] = {
	[1] = 1,
	[2] = 1195
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[7] = {
	[1] = 2,
	[2] = 1195
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 1195
}
RTResTalkAction[9] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[10] = {
	[1] = 1,
	[2] = 141
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 1266
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 1266
}

local Data = {
	[38500001] = {
		38500001,
		0,
		Lang.get(103095),
		38500,
		1,
		1195,
		nil,
		1,
		nil,
		nil,
		nil,
		60,
		38500,
		nil,
		nil,
		nil,
		1,
		nil,
		38500
	},
	[38500002] = {
		38500002,
		0,
		Lang.get(103096),
		38500,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[38500003] = {
		38500003,
		0,
		Lang.get(103097),
		38500,
		3,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[38500004] = {
		38500004,
		0,
		Lang.get(103098),
		38500,
		4,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500005] = {
		38500005,
		0,
		Lang.get(103099),
		38500,
		5,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500006] = {
		38500006,
		0,
		Lang.get(103100),
		38500,
		6,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[5],
			RTResTalkAction[6]
		}
	},
	[38500007] = {
		38500007,
		0,
		Lang.get(103101),
		38500,
		7,
		141,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[38500008] = {
		38500008,
		0,
		Lang.get(103102),
		38500,
		8,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[38500009] = {
		38500009,
		0,
		Lang.get(103103),
		38500,
		9,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[8],
			RTResTalkAction[6]
		}
	},
	[38500010] = {
		38500010,
		0,
		Lang.get(103104),
		38500,
		10,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500011] = {
		38500011,
		0,
		Lang.get(103105),
		38500,
		11,
		141,
		{
			RTResTalkAction[10],
			RTResTalkAction[8],
			RTResTalkAction[5]
		}
	},
	[38500012] = {
		38500012,
		0,
		Lang.get(103106),
		38500,
		12,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[38500013] = {
		38500013,
		0,
		Lang.get(103107),
		38500,
		13,
		107,
		{
			RTResTalkAction[8],
			RTResTalkAction[6]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		38501,
		nil,
		1,
		nil,
		1,
		nil,
		38501
	},
	[38500014] = {
		38500014,
		0,
		Lang.get(103108),
		38500,
		14,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[38500015] = {
		38500015,
		0,
		Lang.get(103109),
		38500,
		15,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500016] = {
		38500016,
		0,
		Lang.get(103110),
		38500,
		16,
		107,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500017] = {
		38500017,
		0,
		Lang.get(103111),
		38500,
		17,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500018] = {
		38500018,
		0,
		Lang.get(103112),
		38500,
		18,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500019] = {
		38500019,
		0,
		Lang.get(103113),
		38500,
		19,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[8]
		}
	},
	[38500020] = {
		38500020,
		0,
		Lang.get(103114),
		38500,
		20,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500021] = {
		38500021,
		0,
		Lang.get(103115),
		38500,
		21,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500022] = {
		38500022,
		0,
		Lang.get(103116),
		38500,
		22,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500023] = {
		38500023,
		0,
		Lang.get(103117),
		38500,
		23,
		107,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[38500024] = {
		38500024,
		0,
		Lang.get(103118),
		38500,
		24,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[38500025] = {
		38500025,
		0,
		Lang.get(103119),
		38500,
		25,
		1195,
		{
			RTResTalkAction[7],
			RTResTalkAction[9]
		}
	},
	[38500026] = {
		38500026,
		0,
		Lang.get(103120),
		38500,
		26,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[38500027] = {
		38500027,
		0,
		Lang.get(103121),
		38500,
		27,
		1195,
		{
			RTResTalkAction[8]
		},
		1,
		nil,
		nil,
		nil,
		nil,
		38502,
		nil,
		1,
		nil,
		1,
		nil,
		38502
	},
	[38500028] = {
		38500028,
		0,
		Lang.get(103122),
		38500,
		28,
		1195,
		{
			RTResTalkAction[4]
		},
		nil,
		nil,
		3
	},
	[38500029] = {
		38500029,
		0,
		Lang.get(103123),
		38500,
		29,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[38500030] = {
		38500030,
		0,
		Lang.get(103124),
		38500,
		30,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[38500031] = {
		38500031,
		0,
		Lang.get(70100),
		38500,
		31,
		1266,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[38500032] = {
		38500032,
		0,
		Lang.get(103125),
		38500,
		32,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[38500033] = {
		38500033,
		0,
		Lang.get(103126),
		38500,
		33,
		1195,
		{
			RTResTalkAction[4]
		}
	},
	[38500034] = {
		38500034,
		0,
		Lang.get(103127),
		38500,
		34,
		1266,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[38500035] = {
		38500035,
		0,
		Lang.get(103128),
		38500,
		35,
		1266,
		{
			RTResTalkAction[11]
		}
	},
	[38500036] = {
		38500036,
		0,
		Lang.get(103129),
		38500,
		36,
		1195,
		{
			RTResTalkAction[4],
			RTResTalkAction[12]
		}
	},
	[38500037] = {
		38500037,
		0,
		Lang.get(103130),
		38500,
		37,
		1266,
		{
			RTResTalkAction[11],
			RTResTalkAction[8]
		}
	},
	[38500038] = {
		38500038,
		0,
		Lang.get(103131),
		38500,
		38,
		605,
		{
			RTResTalkAction[12]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
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
