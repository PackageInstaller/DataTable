-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\tu2ye_yure\\ResTalk.lua

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
	[2] = 809
}
RTResTalkAction[2] = {
	[1] = 1,
	[2] = 424
}
RTResTalkAction[3] = {
	[1] = 0,
	[2] = 809
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 424
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1071
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1071
}
RTResTalkAction[7] = {
	[1] = 1,
	[2] = 195
}
RTResTalkAction[8] = {
	[1] = 0,
	[2] = 195
}
RTResTalkAction[9] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 107
}

local Data = {
	[35026001] = {
		35026001,
		0,
		Lang.get(91179),
		35026,
		1,
		809,
		nil,
		1,
		nil,
		nil,
		nil,
		62,
		35027,
		nil,
		1,
		nil,
		1,
		nil,
		35027
	},
	[35026002] = {
		35026002,
		0,
		Lang.get(91180),
		35026,
		2,
		809,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[35026003] = {
		35026003,
		0,
		Lang.get(91181),
		35026,
		3,
		809,
		{
			RTResTalkAction[1]
		}
	},
	[35026004] = {
		35026004,
		0,
		Lang.get(91182),
		35026,
		4,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026005] = {
		35026005,
		0,
		Lang.get(91183),
		35026,
		5,
		424,
		{
			RTResTalkAction[2]
		}
	},
	[35026006] = {
		35026006,
		0,
		Lang.get(91184),
		35026,
		6,
		424,
		{
			RTResTalkAction[2]
		}
	},
	[35026007] = {
		35026007,
		0,
		Lang.get(91185),
		35026,
		7,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026008] = {
		35026008,
		0,
		Lang.get(91186),
		35026,
		8,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026009] = {
		35026009,
		0,
		Lang.get(91187),
		35026,
		9,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026010] = {
		35026010,
		0,
		Lang.get(91188),
		35026,
		10,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026011] = {
		35026011,
		0,
		Lang.get(91189),
		35026,
		11,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026012] = {
		35026012,
		3,
		Lang.get(91190),
		35026,
		12,
		605,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		nil,
		nil,
		nil,
		35028,
		nil,
		1,
		nil,
		1,
		nil,
		35028,
		nil,
		nil,
		1
	},
	[35026013] = {
		35026013,
		0,
		Lang.get(91191),
		35026,
		13,
		1071,
		{
			RTResTalkAction[5]
		},
		nil,
		nil,
		3
	},
	[35026014] = {
		35026014,
		0,
		Lang.get(91192),
		35026,
		14,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[35026015] = {
		35026015,
		0,
		Lang.get(91193),
		35026,
		15,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026016] = {
		35026016,
		0,
		Lang.get(91194),
		35026,
		16,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026017] = {
		35026017,
		0,
		Lang.get(91195),
		35026,
		17,
		1071,
		{
			RTResTalkAction[5],
			RTResTalkAction[3]
		}
	},
	[35026018] = {
		35026018,
		0,
		Lang.get(91196),
		35026,
		18,
		195,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[35026019] = {
		35026019,
		0,
		Lang.get(91197),
		35026,
		19,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[8]
		}
	},
	[35026020] = {
		35026020,
		0,
		Lang.get(91198),
		35026,
		20,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026021] = {
		35026021,
		0,
		Lang.get(91199),
		35026,
		21,
		195,
		{
			RTResTalkAction[7],
			RTResTalkAction[4]
		}
	},
	[35026022] = {
		35026022,
		0,
		Lang.get(91200),
		35026,
		22,
		195,
		{
			RTResTalkAction[7]
		}
	},
	[35026023] = {
		35026023,
		0,
		Lang.get(93484),
		35026,
		23,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[8]
		}
	},
	[35026024] = {
		35026024,
		0,
		Lang.get(91202),
		35026,
		24,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026025] = {
		35026025,
		0,
		Lang.get(91203),
		35026,
		25,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026026] = {
		35026026,
		0,
		Lang.get(91204),
		35026,
		26,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026027] = {
		35026027,
		0,
		Lang.get(91205),
		35026,
		27,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026028] = {
		35026028,
		0,
		Lang.get(91206),
		35026,
		28,
		195,
		{
			RTResTalkAction[7],
			RTResTalkAction[3]
		}
	},
	[35026029] = {
		35026029,
		0,
		Lang.get(91207),
		35026,
		29,
		1071,
		{
			RTResTalkAction[5],
			RTResTalkAction[8]
		}
	},
	[35026030] = {
		35026030,
		0,
		Lang.get(91208),
		35026,
		30,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[35026031] = {
		35026031,
		0,
		Lang.get(91209),
		35026,
		31,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[35026032] = {
		35026032,
		0,
		Lang.get(91210),
		35026,
		32,
		424,
		{
			RTResTalkAction[2]
		}
	},
	[35026033] = {
		35026033,
		0,
		Lang.get(91211),
		35026,
		33,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[35026034] = {
		35026034,
		0,
		Lang.get(91212),
		35026,
		34,
		107,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[35026035] = {
		35026035,
		0,
		Lang.get(91213),
		35026,
		35,
		809,
		{
			RTResTalkAction[1],
			RTResTalkAction[10]
		}
	},
	[35026036] = {
		35026036,
		0,
		Lang.get(91214),
		35026,
		36,
		107,
		{
			RTResTalkAction[9],
			RTResTalkAction[3]
		}
	},
	[35026037] = {
		35026037,
		0,
		Lang.get(91215),
		35026,
		37,
		1071,
		{
			RTResTalkAction[5],
			RTResTalkAction[10]
		}
	},
	[35026038] = {
		35026038,
		0,
		Lang.get(91216),
		35026,
		38,
		195,
		{
			RTResTalkAction[7],
			RTResTalkAction[6]
		}
	},
	[35026039] = {
		35026039,
		0,
		Lang.get(91217),
		35026,
		39,
		424,
		{
			RTResTalkAction[2],
			RTResTalkAction[8]
		}
	},
	[35026040] = {
		35026040,
		0,
		Lang.get(91218),
		35026,
		40,
		195,
		{
			RTResTalkAction[7],
			RTResTalkAction[4]
		}
	},
	[35026041] = {
		35026041,
		3,
		Lang.get(91219),
		35026,
		41,
		605,
		{
			RTResTalkAction[8]
		},
		[22] = 1
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
