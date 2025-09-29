-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_pass_percent.lua

module("logic.config.t_air_studio_pass_percent", package.seeall)

local title = {
	point = 2,
	rankPercent = 1
}
local dataList = {
	{
		10,
		500
	},
	{
		60,
		1000
	},
	{
		80,
		1200
	},
	{
		100,
		1500
	}
}
local t_air_studio_pass_percent = {}

t_air_studio_pass_percent.dataList = dataList

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
	t_air_studio_pass_percent[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_pass_percent
