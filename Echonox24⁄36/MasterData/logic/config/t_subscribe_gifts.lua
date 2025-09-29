-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_subscribe_gifts.lua

module("logic.config.t_subscribe_gifts", package.seeall)

local title = {
	name = 2,
	code = 1,
	showReward = 3
}
local dataList = {
	{
		130001,
		"关注有礼",
		2700001
	}
}
local t_subscribe_gifts = {}

t_subscribe_gifts.dataList = dataList

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
	t_subscribe_gifts[v[1]] = v

	setmetatable(v, mt)
end

return t_subscribe_gifts
