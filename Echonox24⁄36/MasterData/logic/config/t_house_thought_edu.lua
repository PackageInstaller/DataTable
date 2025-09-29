-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_thought_edu.lua

module("logic.config.t_house_thought_edu", package.seeall)

local title = {
	cost = 4,
	canEdu = 2,
	plot = 5,
	textList = 6,
	id = 1,
	tacitLv = 3
}
local dataList = {
	{
		201,
		0,
		0,
		nil,
		0,
		"不能进驻小屋"
	},
	{
		101,
		1,
		1,
		{
			{
				id = 1702001,
				num = 5
			},
			{
				id = 1100003,
				num = 1000
			}
		},
		3020101,
		""
	}
}
local t_house_thought_edu = {}

t_house_thought_edu.dataList = dataList

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
	t_house_thought_edu[v[1]] = v

	setmetatable(v, mt)
end

return t_house_thought_edu
