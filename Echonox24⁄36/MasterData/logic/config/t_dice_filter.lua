-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dice_filter.lua

module("logic.config.t_dice_filter", package.seeall)

local title = {
	id = 1
}
local dataList = {
	{
		1
	}
}
local t_dice_filter = {}

t_dice_filter.dataList = dataList

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
	t_dice_filter[v[1]] = v

	setmetatable(v, mt)
end

return t_dice_filter
