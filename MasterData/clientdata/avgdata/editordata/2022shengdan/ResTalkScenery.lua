-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2022shengdan\\ResTalkScenery.lua

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
	344,
	0
}
RT[2] = {
	389.42,
	4211.28,
	101.48
}
RT[3] = {
	0,
	300,
	0
}
RT[4] = {
	391.201,
	4211.24,
	102.795
}
RT[5] = {
	0,
	80,
	0
}
RT[6] = {
	386.96,
	4211.26,
	102.8
}
RT[7] = {
	0,
	0,
	0
}
RT[8] = {
	395.2,
	4212,
	99
}
RT[9] = {
	0,
	60,
	0
}
RT[10] = {
	389.69,
	4211.28,
	100.53
}
RT[11] = {
	0,
	90,
	0
}
RT[12] = {
	387.64,
	4211.24,
	101.55
}
RT[13] = {
	387.73,
	4211.208,
	103.11
}
RT[14] = {
	0,
	290,
	0
}
RT[15] = {
	392.3,
	4211.3,
	101.4
}
RT[16] = {
	394.837,
	4211.208,
	105.239
}

local Data = {
	[34601] = {
		[1] = 34601,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 20025,
				action = "Idle",
				scale = 1.6,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Sit",
				scale = 1.8,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[34602] = {
		[1] = 34602,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 20025,
				action = "Idle",
				scale = 1.6,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Sit",
				scale = 1.8,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 23086,
				action = "Idle",
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[34603] = {
		[1] = 34603,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 1.8,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			},
			{
				move_duration = 0,
				npc_id = 20025,
				action = "Idle",
				scale = 1.7,
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			},
			{
				move_duration = 0,
				npc_id = 20030,
				action = "Click02",
				scale = 1.8,
				show = 0,
				rotation = RT[5],
				pos = RT[13]
			},
			{
				scale = 1.8,
				action = "Idle",
				npc_id = 23086,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			}
		}
	},
	[34604] = {
		[1] = 34604,
		[2] = {
			{
				scale = 1.8,
				action = "Idle",
				npc_id = 23086,
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			},
			{
				npc_id = 22085,
				action = "Idle",
				show = 0,
				rotation = RT[14],
				pos = RT[16]
			}
		}
	},
	[34605] = {
		[1] = 34605
	},
	[34606] = {
		[1] = 34606
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
