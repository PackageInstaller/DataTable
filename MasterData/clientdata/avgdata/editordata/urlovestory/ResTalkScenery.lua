-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\URlovestory\\ResTalkScenery.lua

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
local Data = {
	[43801] = {
		[1] = 43801
	},
	[43802] = {
		[1] = 43802
	},
	[43805] = {
		[1] = 43805
	},
	[43810] = {
		[1] = 43810
	},
	[43803] = {
		[1] = 43803
	},
	[43811] = {
		[1] = 43811
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
