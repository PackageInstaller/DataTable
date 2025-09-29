-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_hold_touch.lua

module("logic.config.t_house_hold_touch", package.seeall)

local title = {
	code = 1
}
local dataList = {
	{
		101
	},
	{
		102
	},
	{
		103
	}
}
local t_house_hold_touch = {}

t_house_hold_touch.dataList = dataList

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
	t_house_hold_touch[v[1]] = v

	setmetatable(v, mt)
end

return t_house_hold_touch
