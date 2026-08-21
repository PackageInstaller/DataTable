-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\paojie-P3\\ResTalkScenery.lua

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
	358,
	0
}
RT[2] = {
	249.4869,
	179.228,
	2.608939
}

local Data = {
	[30600] = {
		[1] = 30600,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23056,
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30601] = {
		[1] = 30601,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23056,
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30602] = {
		[1] = 30602,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23056,
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30603] = {
		[1] = 30603,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23058,
				action = "run",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30604] = {
		[1] = 30604,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23058,
				action = "idle1",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30605] = {
		[1] = 30605,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23058,
				action = "idle1",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[30606] = {
		[1] = 30606,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23058,
				action = "die",
				scale = 2.7,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
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
