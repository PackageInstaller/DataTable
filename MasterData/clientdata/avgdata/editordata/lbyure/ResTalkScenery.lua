-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LByure\\ResTalkScenery.lua

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
	302,
	0
}
RT[2] = {
	365.21,
	4219.29,
	121.05
}
RT[3] = {
	0,
	0,
	0
}
RT[4] = {
	363.45,
	4219.3,
	119.82
}
RT[5] = {
	270,
	262,
	0
}
RT[6] = {
	359.435,
	4215.969,
	121.953
}
RT[7] = {
	0,
	305,
	0
}
RT[8] = {
	362.8,
	4215.77,
	121.94
}
RT[9] = {
	0,
	11,
	0
}
RT[10] = {
	392.13,
	4231.15,
	100.89
}
RT[11] = {
	356,
	51,
	1
}
RT[12] = {
	360.26,
	4215.79,
	121.953
}
RT[13] = {
	0,
	7,
	0
}
RT[14] = {
	361.22,
	4215.77,
	121.56
}
RT[15] = {
	0,
	307,
	0
}
RT[16] = {
	362.53,
	4215.74,
	122.1
}
RT[17] = {
	0,
	282,
	0
}
RT[18] = {
	390.16,
	4209.76,
	114.81
}
RT[19] = {
	0,
	332,
	0
}
RT[20] = {
	389.14,
	4209.87,
	113.68
}
RT[21] = {
	0,
	47,
	0
}
RT[22] = {
	386.4,
	4209.89,
	115.39
}
RT[23] = {
	387.985,
	4210.48,
	116.049
}

local Data = {
	[41000] = {
		[1] = 41000,
		[2] = {
			{
				npc_id = 22102,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				npc_id = 22100,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			}
		}
	},
	[41001] = {
		[1] = 41001,
		[2] = {
			{
				npc_id = 22102,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				npc_id = 22100,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[41002] = {
		[1] = 41002,
		[2] = {
			{
				npc_id = 25066,
				move_duration = 0,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			}
		}
	},
	[41003] = {
		[1] = 41003,
		[2] = {
			{
				npc_id = 22102,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			},
			{
				npc_id = 22100,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[13],
				pos = RT[14]
			},
			{
				npc_id = 25066,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			}
		}
	},
	[41004] = {
		[1] = 41004,
		[2] = {
			{
				npc_id = 22102,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			},
			{
				npc_id = 22100,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[13],
				pos = RT[14]
			},
			{
				npc_id = 25066,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			}
		}
	},
	[41005] = {
		[1] = 41005,
		[2] = {
			{
				npc_id = 25066,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[17],
				pos = RT[18]
			},
			{
				npc_id = 22102,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[19],
				pos = RT[20]
			},
			{
				npc_id = 22100,
				move_duration = 0,
				action = "idle001",
				show = 0,
				rotation = RT[21],
				pos = RT[22]
			},
			{
				npc_id = 29180,
				show = 0,
				rotation = RT[3],
				pos = RT[23]
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
