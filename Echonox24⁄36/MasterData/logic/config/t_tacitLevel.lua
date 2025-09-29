-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_tacitLevel.lua

module("logic.config.t_tacitLevel", package.seeall)

local title = {
	id = 1,
	exp = 2
}
local dataList = {
	{
		0,
		0
	},
	{
		1,
		50
	},
	{
		2,
		100
	},
	{
		3,
		160
	},
	{
		4,
		240
	},
	{
		5,
		1000
	}
}
local t_tacitLevel = {}

t_tacitLevel.dataList = dataList

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
	t_tacitLevel[v[1]] = v

	setmetatable(v, mt)
end

return t_tacitLevel
