-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\mudanzhu\\ResTalkScenery.lua

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
	61,
	0
}
RT[2] = {
	18.1,
	-6.886993,
	131.6
}
RT[3] = {
	0,
	311,
	0
}
RT[4] = {
	20.14,
	-6.904999,
	127.99
}
RT[5] = {
	359,
	292,
	0
}
RT[6] = {
	19.396,
	-6.876007,
	131.828
}
RT[7] = {
	0,
	324,
	0
}
RT[8] = {
	20.52,
	-6.886993,
	131.14
}
RT[9] = {
	0,
	357,
	0
}
RT[10] = {
	-10059.78,
	-10021.57,
	-10054.42
}
RT[11] = {
	0,
	302,
	0
}
RT[12] = {
	-10057.11,
	-10021.57,
	-10053.31
}
RT[13] = {
	0,
	282,
	0
}
RT[14] = {
	-10058.3,
	-10021.57,
	-10053.75
}
RT[15] = {
	357,
	350,
	358
}
RT[16] = {
	-10036,
	-10021.52,
	-10061.04
}
RT[17] = {
	358,
	30,
	356
}
RT[18] = {
	-10037.65,
	-10021.34,
	-10058.4
}

local Data = {
	[38500] = {
		[1] = 38500,
		[2] = {
			{
				move_duration = 0,
				npc_id = 8000,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 7605,
				scale = 1,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			},
			{
				move_duration = 0,
				npc_id = 20025,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[38501] = {
		[1] = 38501,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
			},
			{
				move_duration = 0,
				npc_id = 20025,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[11],
				pos = RT[12]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[13],
				pos = RT[14]
			}
		}
	},
	[38502] = {
		[1] = 38502,
		[2] = {
			{
				move_duration = 0,
				npc_id = 40506,
				scale = 1,
				show = 0,
				rotation = RT[15],
				pos = RT[16]
			},
			{
				move_duration = 0,
				npc_id = 26538,
				action = "Idle",
				scale = 1,
				show = 0,
				rotation = RT[17],
				pos = RT[18]
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
