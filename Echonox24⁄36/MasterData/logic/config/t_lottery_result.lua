-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_result.lua

module("logic.config.t_lottery_result", package.seeall)

local title = {
	param = 2,
	code = 1,
	sortOrder = 3
}
local dataList = {
	{
		1,
		{
			"5,0,2"
		},
		4
	},
	{
		2,
		{
			"5,0,1"
		},
		3
	},
	{
		3,
		{
			"4,0,2"
		},
		2
	},
	{
		4,
		{
			"1,0,1"
		},
		1
	},
	{
		5,
		{
			"5,6,1"
		},
		5
	},
	{
		6,
		{
			"5,7,1"
		},
		6
	}
}
local t_lottery_result = {}

t_lottery_result.dataList = dataList

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
	t_lottery_result[v[1]] = v

	setmetatable(v, mt)
end

return t_lottery_result
