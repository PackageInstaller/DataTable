-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_perform_const.lua

module("logic.config.t_main_perform_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"BgFormulaRefreshTime",
		600,
		0,
		""
	},
	{
		"DefualtShowElement",
		0,
		0,
		"0,10001#1,102#2,203#3,301"
	},
	{
		"NotCheckExistPoints",
		0,
		0,
		"",
		{
			0,
			1,
			2,
			3
		}
	},
	{
		"DefaultDisplayHero",
		2000012,
		0,
		""
	},
	{
		"DisplayHeroSelect",
		0,
		0,
		"",
		{
			2000012,
			2000022
		}
	},
	{
		"DefaultFallBackAdjutant",
		2000012,
		0,
		""
	}
}
local t_main_perform_const = {}

t_main_perform_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_main_perform_const[v[1]] = v

	setmetatable(v, mt)
end

return t_main_perform_const
