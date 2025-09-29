-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_newbie_task_constant.lua

module("logic.config.t_newbie_task_constant", package.seeall)

local title = {
	numValue = 2,
	key = 1,
	jsonObjects = 5,
	strValue = 3,
	numValues = 4
}
local dataList = {
	{
		"StepPointAddNum",
		1,
		""
	},
	{
		"DisplayHero",
		2000055,
		""
	},
	{
		"DisplayHeroSkin",
		1505501,
		""
	}
}
local t_newbie_task_constant = {}

t_newbie_task_constant.dataList = dataList

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
	t_newbie_task_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_newbie_task_constant
