-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Link\\ResTalk.lua

local indexMap = {
	npc_id = 6,
	scenery_id = 13,
	bg_blur = 10,
	play_delay = 14,
	mask_alpha = 19,
	section = 4,
	clear_role = 15,
	bgm = 12,
	vocal = 11,
	bg_voice = 17,
	terminal_type = 26,
	hide_name = 21,
	terminal_effect = 24,
	talk_in_ani = 23,
	terminal_bg = 25,
	page = 5,
	talk_type = 2,
	head_emoji = 9,
	action = 7,
	switch_show = 16,
	font_size = 22,
	extra_npc = 20,
	bg_id = 18,
	talk = 3,
	branch_info = 27,
	id = 1,
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
	[2] = 107,
	[3] = {
		1
	}
}
RTResTalkAction[5] = {
	[1] = 0,
	[2] = 141
}
RTResTalkAction[6] = {
	[1] = 2,
	[2] = 119
}
RTResTalkAction[7] = {
	[1] = 3,
	[2] = 107
}
RTResTalkAction[8] = {
	[1] = 1,
	[2] = 216
}
RTResTalkAction[9] = {
	[1] = 0,
	[2] = 119
}
RTResTalkAction[10] = {
	[1] = 0,
	[2] = 107
}
RTResTalkAction[11] = {
	[1] = 1,
	[2] = 225,
	[3] = {
		3
	}
}
RTResTalkAction[12] = {
	[1] = 0,
	[2] = 216
}
RTResTalkAction[13] = {
	[1] = 0,
	[2] = 225
}
RTResTalkAction[14] = {
	[1] = 2,
	[2] = 216
}
RTResTalkAction[15] = {
	[1] = 3,
	[2] = 225
}
RTResTalkAction[16] = {
	[1] = 1,
	[2] = 231,
	[3] = {
		1
	}
}
RTResTalkAction[17] = {
	[1] = 1,
	[2] = 232,
	[3] = {
		1
	}
}
RTResTalkAction[18] = {
	[1] = 0,
	[2] = 231
}
RTResTalkAction[19] = {
	[1] = 1,
	[2] = 233,
	[3] = {
		1
	}
}
RTResTalkAction[20] = {
	[1] = 0,
	[2] = 232
}
RTResTalkAction[21] = {
	[1] = 1,
	[2] = 234
}
RTResTalkAction[22] = {
	[1] = 0,
	[2] = 233
}
RTResTalkAction[23] = {
	[1] = 0,
	[2] = 234
}

local Data = {
	[190001] = {
		190001,
		9,
		Lang.get(50518),
		190,
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		6,
		[18] = 190,
		[21] = 1
	},
	[190002] = {
		190002,
		9,
		Lang.get(50519),
		190,
		2,
		[21] = 1
	},
	[190003] = {
		190003,
		0,
		Lang.get(50520),
		190,
		3,
		107,
		{
			RTResTalkAction[1]
		},
		nil,
		nil,
		3
	},
	[190004] = {
		190004,
		0,
		Lang.get(50521),
		190,
		4,
		141,
		{
			RTResTalkAction[2],
			RTResTalkAction[3]
		}
	},
	[190005] = {
		190005,
		0,
		Lang.get(50522),
		190,
		5,
		107,
		{
			RTResTalkAction[4],
			RTResTalkAction[5]
		}
	},
	[190006] = {
		190006,
		0,
		Lang.get(50523),
		190,
		6,
		119,
		{
			RTResTalkAction[6],
			RTResTalkAction[7]
		}
	},
	[190007] = {
		190007,
		0,
		Lang.get(50524),
		190,
		7,
		216,
		{
			RTResTalkAction[8],
			RTResTalkAction[9],
			RTResTalkAction[10]
		}
	},
	[190008] = {
		190008,
		5,
		Lang.get(50525),
		190,
		8,
		225,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[190009] = {
		190009,
		0,
		Lang.get(50526),
		190,
		9,
		216,
		{
			RTResTalkAction[8],
			RTResTalkAction[13]
		}
	},
	[190010] = {
		190010,
		5,
		Lang.get(50527),
		190,
		10,
		225,
		{
			RTResTalkAction[11],
			RTResTalkAction[12]
		}
	},
	[190011] = {
		190011,
		0,
		Lang.get(50528),
		190,
		11,
		216,
		{
			RTResTalkAction[14],
			RTResTalkAction[15]
		}
	},
	[190012] = {
		190012,
		0,
		Lang.get(50529),
		190,
		12,
		107,
		{
			RTResTalkAction[1],
			RTResTalkAction[12],
			RTResTalkAction[13]
		}
	},
	[190013] = {
		190013,
		0,
		Lang.get(50530),
		190,
		13,
		216,
		{
			RTResTalkAction[8],
			RTResTalkAction[10]
		}
	},
	[191001] = {
		191001,
		0,
		Lang.get(50531),
		191,
		1,
		231,
		{
			RTResTalkAction[16]
		},
		nil,
		nil,
		nil,
		nil,
		122,
		[18] = 191
	},
	[191002] = {
		191002,
		0,
		Lang.get(50532),
		191,
		2,
		232,
		{
			RTResTalkAction[17],
			RTResTalkAction[18]
		}
	},
	[191003] = {
		191003,
		0,
		Lang.get(50533),
		191,
		3,
		233,
		{
			RTResTalkAction[19],
			RTResTalkAction[20]
		}
	},
	[191004] = {
		191004,
		0,
		Lang.get(50534),
		191,
		4,
		234,
		{
			RTResTalkAction[21],
			RTResTalkAction[22]
		}
	},
	[191005] = {
		191005,
		0,
		Lang.get(50535),
		191,
		5,
		234,
		{
			RTResTalkAction[21]
		}
	},
	[191006] = {
		191006,
		0,
		Lang.get(50536),
		191,
		6,
		234,
		{
			RTResTalkAction[21]
		}
	},
	[191007] = {
		191007,
		0,
		Lang.get(50537),
		191,
		7,
		234,
		{
			RTResTalkAction[21]
		}
	},
	[191008] = {
		191008,
		0,
		Lang.get(50538),
		191,
		8,
		216,
		{
			RTResTalkAction[23]
		},
		1
	},
	[191009] = {
		191009,
		0,
		Lang.get(50539),
		191,
		9,
		234,
		{
			RTResTalkAction[21]
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
