-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_color_restrain.lua

module("logic.config.t_color_restrain", package.seeall)

local title = {
	attacker = 1,
	restrainedRatio = 3,
	defender = 2,
	beenRestrainedRatio = 4
}
local dataList = {
	{
		1,
		3,
		1.4,
		0.75
	},
	{
		2,
		1,
		1.4,
		0.75
	},
	{
		3,
		2,
		1.4,
		0.75
	}
}
local t_color_restrain = {}

t_color_restrain.dataList = dataList

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
	local parent1 = t_color_restrain[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_color_restrain[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_color_restrain
