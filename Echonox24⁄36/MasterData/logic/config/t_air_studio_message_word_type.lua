-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_message_word_type.lua

module("logic.config.t_air_studio_message_word_type", package.seeall)

local title = {
	id = 1,
	typName = 2
}
local dataList = {
	{
		1,
		"人物"
	},
	{
		2,
		"怪物"
	},
	{
		3,
		"事物"
	},
	{
		4,
		"战斗用语"
	},
	{
		5,
		"场景用语"
	},
	{
		6,
		"世界观"
	},
	{
		7,
		"情绪"
	},
	{
		8,
		"其他"
	}
}
local t_air_studio_message_word_type = {}

t_air_studio_message_word_type.dataList = dataList

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
	t_air_studio_message_word_type[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_message_word_type
