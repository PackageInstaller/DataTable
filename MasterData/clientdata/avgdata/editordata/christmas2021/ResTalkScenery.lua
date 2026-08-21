-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\Christmas2021\\ResTalkScenery.lua

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
	249,
	0
}
RT[2] = {
	391.08,
	4211.221,
	104.04
}
RT[3] = {
	0,
	99,
	0
}
RT[4] = {
	390.39,
	4211.328,
	102.492
}
RT[5] = {
	391.26,
	4211.221,
	104.02
}
RT[6] = {
	0,
	270,
	0
}
RT[7] = {
	390.595,
	4211.325,
	102.211
}
RT[8] = {
	0,
	280,
	0
}
RT[9] = {
	391.05,
	4211.32,
	101.85
}
RT[10] = {
	0,
	342,
	0
}
RT[11] = {
	383.09,
	4209.75,
	131.24
}
RT[12] = {
	0,
	84,
	0
}
RT[13] = {
	380.34,
	4209.81,
	135.26
}
RT[14] = {
	0,
	206,
	0
}
RT[15] = {
	385.8,
	4209.76,
	137.31
}
RT[16] = {
	0,
	310,
	0
}
RT[17] = {
	386.6,
	4209.89,
	133.65
}

local Data = {
	[25801] = {
		[1] = 25801,
		[2] = {
			{
				scale = 1.3,
				action = "shy",
				npc_id = 20020,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				scale = 1.4,
				npc_id = 29093,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[25802] = {
		[1] = 25802,
		[2] = {
			{
				scale = 1.3,
				action = "Wait 0",
				npc_id = 20020,
				show = 0,
				rotation = RT[1],
				pos = RT[5]
			},
			{
				scale = 1.3,
				action = "Idle",
				npc_id = 25054,
				show = 0,
				rotation = RT[6],
				pos = RT[7]
			},
			{
				scale = 1.5,
				npc_id = 29093,
				show = 0,
				rotation = RT[8],
				pos = RT[9]
			}
		}
	},
	[25800] = {
		[1] = 25800,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23027,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[10],
				pos = RT[11]
			},
			{
				move_duration = 0,
				npc_id = 23051,
				action = "Talk",
				scale = 1.8,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Idle02",
				scale = 1.8,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				move_duration = 0,
				npc_id = 20020,
				scale = 1.8,
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			}
		}
	},
	[25803] = {
		[1] = 25803
	},
	[25810] = {
		[1] = 25810,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23027,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[10],
				pos = RT[11]
			},
			{
				move_duration = 0,
				npc_id = 23051,
				action = "Talk",
				scale = 1.8,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Idle02",
				scale = 1.8,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				move_duration = 0,
				npc_id = 20020,
				scale = 1.8,
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			}
		}
	},
	[25811] = {
		[1] = 25811
	},
	[25820] = {
		[1] = 25820,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23027,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[10],
				pos = RT[11]
			},
			{
				move_duration = 0,
				npc_id = 23051,
				action = "Talk",
				scale = 1.8,
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Idle02",
				scale = 1.8,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				move_duration = 0,
				npc_id = 20020,
				scale = 1.8,
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			}
		}
	},
	[25821] = {
		[1] = 25821
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
