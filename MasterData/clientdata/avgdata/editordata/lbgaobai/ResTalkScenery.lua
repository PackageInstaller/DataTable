-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\AVGData\\EditorData\\LBgaobai\\ResTalkScenery.lua

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
	[41101] = {
		[1] = 41101
	},
	[41102] = {
		[1] = 41102
	},
	[41103] = {
		[1] = 41103
	},
	[41104] = {
		[1] = 41104
	},
	[41105] = {
		[1] = 41105
	},
	[41106] = {
		[1] = 41106
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
