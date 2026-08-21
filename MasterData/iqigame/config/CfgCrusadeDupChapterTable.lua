-- chunkname: @IQIGame\\Config\\CfgCrusadeDupChapterTable.lua

local CfgCrusadeDupChapterTable = {
	[101] = {
		Id = 101,
		Type = 18
	},
	[102] = {
		Id = 102,
		Type = 18
	},
	[103] = {
		Id = 103,
		Type = 18
	},
	[104] = {
		Id = 104,
		Type = 18
	},
	[105] = {
		Id = 105,
		Type = 18
	},
	[106] = {
		Id = 106,
		Type = 18
	}
}

setmetatable(CfgCrusadeDupChapterTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgCrusadeDupChapterTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Type = 0
	}
}

for i, data in pairs(CfgCrusadeDupChapterTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgCrusadeDupChapterTable
