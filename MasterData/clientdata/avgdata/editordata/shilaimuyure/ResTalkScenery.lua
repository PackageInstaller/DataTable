-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\shilaimuyure\\ResTalkScenery.lua

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
	281,
	0
}
RT[2] = {
	366.87,
	4219.432,
	119.48
}
RT[3] = {
	0,
	261,
	0
}

local Data = {
	[23350] = {
		[1] = 23350
	},
	[23351] = {
		[1] = 23351,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[23352] = {
		[1] = 23352,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle",
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			}
		}
	},
	[23353] = {
		[1] = 23353,
		[2] = {
			{
				npc_id = 20020,
				move_duration = 0,
				action = "Idle02",
				show = 0,
				rotation = RT[3],
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
