-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_setting_frame.lua

module("logic.config.t_setting_frame", package.seeall)

local title = {
	typeString = 2,
	id = 1,
	typeLevel = 3
}
local dataList = {
	{
		1,
		"流畅",
		1
	},
	{
		2,
		"普通",
		2
	},
	{
		3,
		"均衡",
		3
	},
	{
		4,
		"最佳",
		4
	}
}
local t_setting_frame = {}

t_setting_frame.dataList = dataList

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
	t_setting_frame[v[1]] = v

	setmetatable(v, mt)
end

return t_setting_frame
