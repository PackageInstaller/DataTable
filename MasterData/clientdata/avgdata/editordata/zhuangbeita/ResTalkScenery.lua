-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\zhuangbeita\\ResTalkScenery.lua

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
	0,
	0
}
RT[2] = {
	-1300,
	44.60001,
	-209
}
RT[3] = {
	-1310,
	0,
	-350
}
RT[4] = {
	-1270,
	15.60001,
	-200
}

local Data = {
	[31650] = {
		[1] = 31650,
		[2] = {
			{
				scale = 4.8,
				npc_id = 4184,
				show = 0,
				rotation = RT[1],
				pos = RT[2]
			},
			{
				scale = 300,
				npc_id = 29094,
				show = 0,
				rotation = RT[1],
				pos = RT[3]
			},
			{
				scale = 2,
				npc_id = 8066,
				show = 0,
				rotation = RT[1],
				pos = RT[4]
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
