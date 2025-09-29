-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_perform_formula.lua

module("logic.config.t_main_perform_formula", package.seeall)

local title = {
	id = 1,
	forceSet = 4,
	weight = 3,
	interactPoints = 2
}
local dataList = {
	{
		1,
		{
			1,
			2,
			3
		},
		40,
		""
	}
}
local t_main_perform_formula = {}

t_main_perform_formula.dataList = dataList

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
	t_main_perform_formula[v[1]] = v

	setmetatable(v, mt)
end

return t_main_perform_formula
