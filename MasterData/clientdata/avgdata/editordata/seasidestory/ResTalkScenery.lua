-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\seasidestory\\ResTalkScenery.lua

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
	130,
	0
}
RT[2] = {
	-1144.323,
	4.329987,
	-121.46
}
RT[3] = {
	0,
	323,
	0
}
RT[4] = {
	-1142.31,
	4.309998,
	-123.34
}
RT[5] = {
	0,
	265,
	0
}
RT[6] = {
	-1133.29,
	4.279999,
	-115.58
}
RT[7] = {
	0,
	120,
	0
}
RT[8] = {
	0,
	308,
	0
}
RT[9] = {
	-1142.472,
	4.32901,
	-123.3898
}
RT[10] = {
	0,
	97,
	0
}
RT[11] = {
	-1144.458,
	4.328003,
	-121.519
}
RT[12] = {
	0,
	351,
	0
}
RT[13] = {
	-1142.62,
	4.32901,
	-124.03
}
RT[14] = {
	0,
	180,
	0
}
RT[15] = {
	-1141.097,
	4.307007,
	-120.246
}
RT[16] = {
	0,
	108,
	0
}
RT[17] = {
	-1144.66,
	4.309998,
	-122.2
}
RT[18] = {
	0,
	356,
	0
}
RT[19] = {
	-1142.47,
	4.32901,
	-124.16
}
RT[20] = {
	0,
	218,
	0
}
RT[21] = {
	-1140.132,
	4.334015,
	-122.039
}

local Data = {
	[31701] = {
		[1] = 31701,
		[2] = {
			{
				npc_id = 23070,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				npc_id = 22078,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				npc_id = 26520,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[31702] = {
		[1] = 31702,
		[2] = {
			{
				npc_id = 23070,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[7],
				pos = RT[2]
			},
			{
				npc_id = 22078,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[8],
				pos = RT[9]
			},
			{
				npc_id = 26520,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[31703] = {
		[1] = 31703,
		[2] = {
			{
				npc_id = 23070,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[10],
				pos = RT[11]
			},
			{
				npc_id = 22078,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[12],
				pos = RT[13]
			},
			{
				npc_id = 26520,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[14],
				pos = RT[15]
			}
		}
	},
	[31704] = {
		[1] = 31704,
		[2] = {
			{
				npc_id = 23070,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[16],
				pos = RT[17]
			},
			{
				npc_id = 22078,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[18],
				pos = RT[19]
			},
			{
				npc_id = 26520,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[20],
				pos = RT[21]
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
