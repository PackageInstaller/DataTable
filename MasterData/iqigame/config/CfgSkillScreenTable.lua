-- chunkname: @IQIGame\\Config\\CfgSkillScreenTable.lua

local CfgSkillScreenTable = {
	{
		Id = 1,
		Type = 1,
		Value = 1,
		Icon = "none",
		Content = getI18NValue(180050404)
	},
	{
		Id = 2,
		Type = 1,
		Value = 2,
		Icon = "none",
		Content = getI18NValue(180050405)
	},
	[7] = {
		Id = 7,
		Type = 2,
		Value = 3,
		Icon = "none",
		Content = getI18NValue(180050406)
	},
	[8] = {
		Id = 8,
		Type = 2,
		Value = 4,
		Icon = "none",
		Content = getI18NValue(180050407)
	},
	[9] = {
		Id = 9,
		Type = 2,
		Value = 5,
		Icon = "none",
		Content = getI18NValue(180050408)
	},
	[10] = {
		Id = 10,
		Type = 3,
		Value = 1,
		Icon = "05_Images/Icon/Attribute/element_wind.png",
		Content = getI18NValue(180050409)
	},
	[11] = {
		Id = 11,
		Type = 3,
		Value = 2,
		Icon = "05_Images/Icon/Attribute/element_fire.png",
		Content = getI18NValue(180050410)
	},
	[12] = {
		Id = 12,
		Type = 3,
		Value = 3,
		Icon = "05_Images/Icon/Attribute/element_bolt.png",
		Content = getI18NValue(180050411)
	},
	[13] = {
		Id = 13,
		Type = 3,
		Value = 4,
		Icon = "05_Images/Icon/Attribute/element_water.png",
		Content = getI18NValue(180050412)
	},
	[14] = {
		Id = 14,
		Icon = "05_Images/Icon/Attribute/element_ice.png",
		Type = 3,
		Content = getI18NValue(180050413)
	},
	[15] = {
		Id = 15,
		Type = 5,
		Value = 1,
		Icon = "none",
		Content = getI18NValue(180050414)
	},
	[16] = {
		Id = 16,
		Type = 5,
		Value = 2,
		Icon = "none",
		Content = getI18NValue(180050415)
	},
	[17] = {
		Id = 17,
		Type = 5,
		Value = 3,
		Icon = "none",
		Content = getI18NValue(180050416)
	},
	[18] = {
		Id = 18,
		Type = 5,
		Value = 4,
		Icon = "none",
		Content = getI18NValue(180050417)
	},
	[19] = {
		Id = 19,
		Type = 5,
		Value = 5,
		Icon = "none",
		Content = getI18NValue(180050418)
	}
}

setmetatable(CfgSkillScreenTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgSkillScreenTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Value = 0,
		Icon = "",
		Content = "",
		Type = 0
	}
}

for i, data in pairs(CfgSkillScreenTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgSkillScreenTable
