-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuangbeita\\ResTalk.lua

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
	[2] = 1022
}
RTResTalkAction[2] = {
	[1] = 0,
	[2] = 1022
}

local Data = {
	[31650001] = {
		31650001,
		0,
		Lang.get(75736),
		31650,
		1,
		300,
		nil,
		nil,
		nil,
		nil,
		nil,
		60,
		31650,
		[19] = 31650
	},
	[31650002] = {
		31650002,
		0,
		Lang.get(75737),
		31650,
		2,
		300
	},
	[31650003] = {
		31650003,
		4,
		nil,
		31650,
		3,
		300,
		[29] = {
			{
				id = 31650004,
				branch_content = Lang.get(75738)
			},
			{
				id = 31650004,
				branch_content = Lang.get(75739)
			}
		}
	},
	[31650004] = {
		31650004,
		0,
		Lang.get(75740),
		31650,
		4,
		1022,
		nil,
		1
	},
	[31650005] = {
		31650005,
		4,
		nil,
		31650,
		5,
		1022,
		nil,
		1,
		[29] = {
			{
				id = 31650006,
				branch_content = Lang.get(75741)
			},
			{
				id = 31650006,
				branch_content = Lang.get(75742)
			}
		}
	},
	[31650006] = {
		31650006,
		0,
		Lang.get(75743),
		31650,
		6,
		1022,
		nil,
		1
	},
	[31650007] = {
		31650007,
		0,
		Lang.get(75744),
		31650,
		7,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650008] = {
		31650008,
		0,
		Lang.get(75745),
		31650,
		8,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650009] = {
		31650009,
		0,
		Lang.get(75746),
		31650,
		9,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650010] = {
		31650010,
		0,
		Lang.get(75747),
		31650,
		10,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650011] = {
		31650011,
		0,
		Lang.get(75748),
		31650,
		11,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650012] = {
		31650012,
		0,
		Lang.get(75749),
		31650,
		12,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650013] = {
		31650013,
		4,
		nil,
		31650,
		13,
		1022,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 31650014,
				branch_content = Lang.get(22182)
			},
			{
				id = 31650019,
				branch_content = Lang.get(75750)
			}
		}
	},
	[31650014] = {
		31650014,
		0,
		Lang.get(75751),
		31650,
		14,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650015] = {
		31650015,
		0,
		Lang.get(75752),
		31650,
		15,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650016] = {
		31650016,
		0,
		Lang.get(75753),
		31650,
		16,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650017] = {
		31650017,
		0,
		Lang.get(75754),
		31650,
		17,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650018] = {
		31650018,
		4,
		nil,
		31650,
		18,
		1022,
		{
			RTResTalkAction[1]
		},
		[29] = {
			{
				id = 31650026,
				branch_content = Lang.get(75755)
			}
		}
	},
	[31650019] = {
		31650019,
		0,
		Lang.get(75756),
		31650,
		19,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650020] = {
		31650020,
		0,
		Lang.get(75757),
		31650,
		20,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650021] = {
		31650021,
		0,
		Lang.get(25821),
		31650,
		21,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650022] = {
		31650022,
		0,
		Lang.get(75758),
		31650,
		22,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650023] = {
		31650023,
		0,
		Lang.get(75759),
		31650,
		23,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650024] = {
		31650024,
		0,
		Lang.get(75760),
		31650,
		24,
		300,
		{
			RTResTalkAction[2]
		}
	},
	[31650025] = {
		31650025,
		0,
		Lang.get(75761),
		31650,
		25,
		1022,
		{
			RTResTalkAction[1]
		}
	},
	[31650026] = {
		31650026,
		0,
		Lang.get(75762),
		31650,
		26,
		1022,
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
