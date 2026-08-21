-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\FairyTale_yure\\ResTalk.lua

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
	[2] = 1302
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1302
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 107
}
RTResTalkAction[4] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[5] = {
	[1] = 1,
	[2] = 1023
}
RTResTalkAction[6] = {
	[1] = 0,
	[2] = 1023
}

local Data = {
	[42921001] = {
		42921001,
		0,
		Lang.get(115759),
		42921,
		1,
		1302,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42921,
		nil,
		nil,
		nil,
		nil,
		nil,
		42921
	},
	[42921002] = {
		42921002,
		0,
		Lang.get(115760),
		42921,
		2,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[42921003] = {
		42921003,
		0,
		Lang.get(115761),
		42921,
		3,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42921004] = {
		42921004,
		4,
		nil,
		42921,
		4,
		1302,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 42921005,
				branch_content = Lang.get(115762)
			},
			{
				id = 42921005,
				branch_content = Lang.get(115763)
			}
		}
	},
	[42921005] = {
		42921005,
		0,
		Lang.get(115764),
		42921,
		5,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42921006] = {
		42921006,
		0,
		Lang.get(115765),
		42921,
		6,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42921007] = {
		42921007,
		0,
		Lang.get(115766),
		42921,
		7,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42922001] = {
		42922001,
		0,
		Lang.get(115767),
		42922,
		1,
		1302,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		60,
		42922,
		nil,
		nil,
		nil,
		nil,
		nil,
		42922
	},
	[42922002] = {
		42922002,
		0,
		Lang.get(115768),
		42922,
		2,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42922003] = {
		42922003,
		0,
		Lang.get(115769),
		42922,
		3,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[42922004] = {
		42922004,
		0,
		Lang.get(115770),
		42922,
		4,
		1302,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42922005] = {
		42922005,
		0,
		Lang.get(115771),
		42922,
		5,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42922006] = {
		42922006,
		0,
		Lang.get(115772),
		42922,
		6,
		1023,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[42922007] = {
		42922007,
		0,
		Lang.get(115773),
		42922,
		7,
		1302,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[42922008] = {
		42922008,
		0,
		Lang.get(115774),
		42922,
		8,
		107,
		{
			RTResTalkAction[3],
			RTResTalkAction[2]
		}
	},
	[42923001] = {
		42923001,
		3,
		Lang.get(115775),
		42923,
		1,
		605,
		nil,
		nil,
		nil,
		3,
		nil,
		60,
		42923,
		nil,
		nil,
		nil,
		nil,
		nil,
		42923,
		nil,
		nil,
		1
	},
	[42923002] = {
		42923002,
		0,
		Lang.get(115776),
		42923,
		2,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[42923003] = {
		42923003,
		0,
		Lang.get(115777),
		42923,
		3,
		1302,
		{
			RTResTalkAction[1],
			RTResTalkAction[4]
		}
	},
	[42923004] = {
		42923004,
		0,
		Lang.get(115778),
		42923,
		4,
		1023,
		{
			RTResTalkAction[5],
			RTResTalkAction[2]
		}
	},
	[42923005] = {
		42923005,
		0,
		Lang.get(115779),
		42923,
		5,
		1302,
		{
			RTResTalkAction[1],
			RTResTalkAction[6]
		}
	},
	[42923006] = {
		42923006,
		4,
		nil,
		42923,
		6,
		1302,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 42923007,
				branch_content = Lang.get(115780)
			},
			{
				id = 42923007,
				branch_content = Lang.get(115781)
			}
		}
	},
	[42923007] = {
		42923007,
		0,
		Lang.get(115782),
		42923,
		7,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42923008] = {
		42923008,
		0,
		Lang.get(115783),
		42923,
		8,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42923009] = {
		42923009,
		0,
		Lang.get(115784),
		42923,
		9,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42923010] = {
		42923010,
		0,
		Lang.get(115785),
		42923,
		10,
		1302,
		{
			RTResTalkAction[1]
		}
	},
	[42923011] = {
		42923011,
		0,
		Lang.get(115786),
		42923,
		11,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[42923012] = {
		42923012,
		0,
		Lang.get(115787),
		42923,
		12,
		1302,
		{
			RTResTalkAction[1]
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
