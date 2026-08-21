-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\shilaimuyure\\ResTalk.lua

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
	7
}
RTResTalkAction[3] = {
	[1] = 1,
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[4] = {
	1,
	107,
	nil,
	nil,
	10
}
RTResTalkAction[5] = {
	1,
	107,
	nil,
	nil,
	5
}
RTResTalkAction[6] = {
	1,
	107,
	nil,
	nil,
	2
}
RTResTalkAction[7] = {
	1,
	107,
	{
		1
	},
	nil,
	2
}
RTResTalkAction[8] = {
	1,
	107,
	nil,
	nil,
	8
}
RTResTalkAction[9] = {
	1,
	107,
	nil,
	nil,
	1
}
RTResTalkAction[10] = {
	1,
	107,
	nil,
	nil,
	3
}
RTResTalkAction[11] = {
	1,
	107,
	{
		1
	},
	nil,
	1
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 107
}

local Data = {
	[23350001] = {
		23350001,
		0,
		Lang.get(56151),
		23350,
		1,
		605,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23350,
		[19] = 23350
	},
	[23350002] = {
		23350002,
		0,
		Lang.get(56152),
		23350,
		2,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		-1
	},
	[23350003] = {
		23350003,
		0,
		Lang.get(56153),
		23350,
		3,
		107,
		{
			RTResTalkAction[2]
		},
		nil,
		nil,
		3
	},
	[23350004] = {
		23350004,
		0,
		Lang.get(56154),
		23350,
		4,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350005] = {
		23350005,
		0,
		Lang.get(56155),
		23350,
		5,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[23350006] = {
		23350006,
		0,
		Lang.get(56156),
		23350,
		6,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350007] = {
		23350007,
		0,
		Lang.get(56157),
		23350,
		7,
		107,
		{
			RTResTalkAction[2]
		}
	},
	[23350008] = {
		23350008,
		0,
		Lang.get(56158),
		23350,
		8,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350009] = {
		23350009,
		0,
		Lang.get(18191),
		23350,
		9,
		107,
		{
			RTResTalkAction[4]
		}
	},
	[23350010] = {
		23350010,
		0,
		Lang.get(56159),
		23350,
		10,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350011] = {
		23350011,
		0,
		Lang.get(56160),
		23350,
		11,
		107,
		{
			RTResTalkAction[5]
		}
	},
	[23350012] = {
		23350012,
		0,
		Lang.get(56161),
		23350,
		12,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[23350013] = {
		23350013,
		0,
		"？？？？？",
		23350,
		13,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[23350014] = {
		23350014,
		0,
		Lang.get(56162),
		23350,
		14,
		107,
		{
			RTResTalkAction[7]
		}
	},
	[23350015] = {
		23350015,
		0,
		Lang.get(56163),
		23350,
		15,
		300,
		{
			RTResTalkAction[6]
		}
	},
	[23350016] = {
		23350016,
		0,
		Lang.get(56164),
		23350,
		16,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[23350017] = {
		23350017,
		0,
		Lang.get(56165),
		23350,
		17,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350018] = {
		23350018,
		0,
		Lang.get(56166),
		23350,
		18,
		107,
		{
			RTResTalkAction[9]
		}
	},
	[23350019] = {
		23350019,
		0,
		Lang.get(56167),
		23350,
		19,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350020] = {
		23350020,
		0,
		Lang.get(56168),
		23350,
		20,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[23350021] = {
		23350021,
		0,
		Lang.get(56169),
		23350,
		21,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350022] = {
		23350022,
		0,
		"？？？？？",
		23350,
		22,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[23350023] = {
		23350023,
		0,
		Lang.get(56170),
		23350,
		23,
		107,
		{
			RTResTalkAction[8]
		}
	},
	[23350024] = {
		23350024,
		0,
		Lang.get(56171),
		23350,
		24,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23350025] = {
		23350025,
		0,
		Lang.get(56172),
		23350,
		25,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[23351001] = {
		23351001,
		0,
		Lang.get(56173),
		23351,
		1,
		300,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23352,
		[19] = 23352
	},
	[23351002] = {
		23351002,
		0,
		Lang.get(56174),
		23351,
		2,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23351003] = {
		23351003,
		0,
		Lang.get(56175),
		23351,
		3,
		107,
		{
			RTResTalkAction[11]
		}
	},
	[23351004] = {
		23351004,
		0,
		Lang.get(56176),
		23351,
		4,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[23351005] = {
		23351005,
		0,
		Lang.get(56177),
		23351,
		5,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23351006] = {
		23351006,
		0,
		Lang.get(56178),
		23351,
		6,
		107,
		{
			RTResTalkAction[10]
		}
	},
	[23351007] = {
		23351007,
		0,
		Lang.get(56179),
		23351,
		7,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23351008] = {
		23351008,
		0,
		Lang.get(56180),
		23351,
		8,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[23352001] = {
		23352001,
		0,
		Lang.get(56181),
		23352,
		1,
		107,
		{
			RTResTalkAction[3]
		},
		nil,
		nil,
		3,
		nil,
		nil,
		23353,
		[19] = 23353
	},
	[23352002] = {
		23352002,
		0,
		Lang.get(56182),
		23352,
		2,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[23352003] = {
		23352003,
		0,
		Lang.get(56183),
		23352,
		3,
		107,
		{
			RTResTalkAction[1]
		}
	},
	[23352004] = {
		23352004,
		0,
		Lang.get(56184),
		23352,
		4,
		107,
		{
			RTResTalkAction[3]
		}
	},
	[23352005] = {
		23352005,
		0,
		Lang.get(56185),
		23352,
		5,
		107,
		{
			RTResTalkAction[12]
		}
	},
	[23352006] = {
		23352006,
		0,
		Lang.get(56186),
		23352,
		6,
		300,
		{
			RTResTalkAction[1]
		}
	},
	[23352007] = {
		23352007,
		0,
		Lang.get(56187),
		23352,
		7,
		107,
		{
			RTResTalkAction[6]
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
