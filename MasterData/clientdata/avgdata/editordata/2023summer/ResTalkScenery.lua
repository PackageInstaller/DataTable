-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\2023summer\\ResTalkScenery.lua

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
	356,
	0
}
RT[2] = {
	-1161.881,
	4.309998,
	-122.5959
}
RT[3] = {
	0,
	30,
	0
}
RT[4] = {
	-1163.355,
	4.380005,
	-123.6747
}
RT[5] = {
	0,
	116,
	0
}
RT[6] = {
	-1157.242,
	4.309998,
	-125.1611
}
RT[7] = {
	0,
	328,
	0
}
RT[8] = {
	-1156.276,
	4.369995,
	-130.8383
}

local Data = {
	[38001] = {
		[1] = 38001,
		[2] = {
			{
				move_duration = 0,
				npc_id = 21076,
				action = "Idle",
				scale = 1.5,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 40004,
				action = "idle",
				scale = 1,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 29116,
				scale = 1.5,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				scale = 1.5,
				npc_id = 29115,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[38002] = {
		[1] = 38002
	},
	[38003] = {
		[1] = 38003
	},
	[38004] = {
		[1] = 38004
	},
	[38005] = {
		[1] = 38005
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
