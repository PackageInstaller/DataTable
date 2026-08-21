-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\longnianqiandao\\ResTalkScenery.lua

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
	256,
	0
}
RT[2] = {
	15.56,
	0.410004,
	17.43
}
RT[3] = {
	0,
	18,
	0
}
RT[4] = {
	16.83,
	0.410004,
	15.79
}
RT[5] = {
	0,
	66,
	0
}
RT[6] = {
	12.13,
	0.459992,
	17.27
}
RT[7] = {
	356,
	3,
	0
}
RT[8] = {
	-203.9277,
	141.5803,
	1534.492
}
RT[9] = {
	0,
	295,
	0
}
RT[10] = {
	-331.33,
	4203.81,
	98.81
}

local Data = {
	[42501] = {
		[1] = 42501,
		[2] = {
			{
				move_duration = 0,
				npc_id = 20020,
				action = "Idle",
				scale = 1.5,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				move_duration = 0,
				npc_id = 23112,
				action = "idle01",
				scale = 1.5,
				show = 0,
				rotation = RT[3],
				pos = RT[4]
			},
			{
				move_duration = 0,
				npc_id = 23111,
				action = "idle01",
				scale = 1.51,
				show = 0,
				rotation = RT[5],
				pos = RT[6]
			}
		}
	},
	[42502] = {
		[1] = 42502,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23111,
				action = "idle01",
				scale = 1.5,
				show = 0,
				rotation = RT[7],
				pos = RT[8]
			}
		}
	},
	[42503] = {
		[1] = 42503,
		[2] = {
			{
				move_duration = 0,
				npc_id = 23110,
				action = "idle01",
				scale = 1.2,
				show = 0,
				rotation = RT[9],
				pos = RT[10]
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
