-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\P3_guozheng\\ResTalkScenery.lua

local indexMap = {
	timeline_clear = 8,
	model_stage_pos = 3,
	clear_all_npc = 4,
	timeline_path = 5,
	id = 1,
	timeline_config = 7,
	timeline_config_str = 6,
	action = 2
}
local RT = {}

RT[1] = {
	0,
	285,
	0
}
RT[2] = {
	39.69,
	0.420013,
	9.72
}
RT[3] = {
	0,
	150,
	0
}
RT[4] = {
	-128.98,
	241.59,
	1631.7
}
RT[5] = {
	0,
	180,
	0
}
RT[6] = {
	-158.532,
	142.83,
	1509.177
}
RT[7] = {
	0,
	250,
	0
}
RT[8] = {
	365.51,
	4219.29,
	120.95
}
RT[9] = {
	0,
	296,
	0
}
RT[10] = {
	20.2,
	-7.200012,
	127.6
}
RT[11] = {
	0,
	295,
	0
}
RT[12] = {
	20.54,
	-5.876007,
	124.55
}
RT[13] = {
	295,
	214,
	320
}
RT[14] = {
	19.942,
	-5.274994,
	127.04
}
RT[15] = {
	0,
	168,
	0
}
RT[16] = {
	19.41,
	-5.839996,
	124.13
}
RT[17] = {
	0,
	311,
	0
}
RT[18] = {
	20.25,
	-6.929993,
	127.9
}
RT[19] = {
	19.56928,
	-6.886993,
	131.2865
}
RT[20] = {
	0,
	324,
	0
}
RT[21] = {
	17.815,
	-6.886993,
	129.83
}
RT[22] = {
	0,
	280,
	0
}
RT[23] = {
	373.22,
	4223.296,
	118.94
}
RT[24] = {
	0,
	356,
	0
}
RT[25] = {
	-62.76,
	-15.03,
	140.67
}
RT[26] = {
	357,
	39,
	358
}
RT[27] = {
	-203.93,
	141.54,
	1534.49
}
RT[28] = {
	0,
	307,
	0
}
RT[29] = {
	373.3476,
	4223.289,
	118.6609
}

local Data = {
	[33401] = {
		[1] = 33401,
		[2] = {
			{
				move_duration = 0,
				npc_id = 24076,
				action = "Idle",
				scale = 1.2,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[33402] = {
		[1] = 33402,
		[2] = {
			{
				npc_id = 24076,
				move_duration = 0,
				action = "talk",
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[33502] = {
		[1] = 33502,
		[2] = {
			{
				npc_id = 24076,
				action = "music",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[33403] = {
		[1] = 33403,
		[2] = {
			{
				npc_id = 24076,
				move_duration = 0,
				action = "talk",
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[33404] = {
		[1] = 33404,
		[2] = {
			{
				npc_id = 7605,
				move_duration = 0,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			},
			{
				npc_id = 26538,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			},
			{
				move_duration = 0,
				npc_id = 29038,
				scale = 0.6,
				show = 0,
				rotation = RT[13],
				pos = RT[14]
			},
			{
				npc_id = 29041,
				move_duration = 0,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			}
		}
	},
	[33405] = {
		[1] = 33405,
		[2] = {
			{
				move_duration = 0,
				npc_id = 7605,
				scale = 1,
				show = 0,
				rotation = RT[17],
				pos = RT[18]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[1],
				pos = RT[19]
			},
			{
				npc_id = 29041,
				show = 0,
				rotation = RT[20],
				pos = RT[21]
			}
		}
	},
	[33406] = {
		[1] = 33406,
		[2] = {
			{
				npc_id = 26538,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[22],
				pos = RT[23]
			}
		}
	},
	[33407] = {
		[1] = 33407,
		[2] = {
			{
				scale = 2.7,
				action = "Idle",
				npc_id = 24081,
				show = 0,
				rotation = RT[24],
				pos = RT[25]
			}
		}
	},
	[33408] = {
		[1] = 33408,
		[2] = {
			{
				move_duration = 0,
				npc_id = 24081,
				action = "Idle",
				scale = 1.5,
				show = 0,
				rotation = RT[26],
				pos = RT[27]
			}
		}
	},
	[33409] = {
		[1] = 33409,
		[2] = {
			{
				npc_id = 24081,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[28],
				pos = RT[29]
			}
		}
	}
}
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
