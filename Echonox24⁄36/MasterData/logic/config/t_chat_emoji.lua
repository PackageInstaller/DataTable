-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_chat_emoji.lua

module("logic.config.t_chat_emoji", package.seeall)

local title = {
	id = 1,
	name = 2,
	icon = 3
}
local dataList = {
	{
		101,
		"恭喜发财",
		"chat_emoji_1001"
	},
	{
		102,
		"红包拿来",
		"chat_emoji_1002"
	},
	{
		103,
		"大佬？！",
		"chat_emoji_1003"
	}
}
local t_chat_emoji = {}

t_chat_emoji.dataList = dataList

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
	t_chat_emoji[v[1]] = v

	setmetatable(v, mt)
end

return t_chat_emoji
