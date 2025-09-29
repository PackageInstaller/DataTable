-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_play_count.lua

module("logic.config.t_air_studio_play_count", package.seeall)

local title = {
	defenceCapacityFactor = 3,
	count = 1,
	playCountFactor = 2
}
local dataList = {
	{
		0,
		0.3,
		1
	},
	{
		30,
		0.5,
		0.8
	},
	{
		100,
		0.7,
		0.7
	},
	{
		300,
		0.85,
		0.6
	}
}
local t_air_studio_play_count = {}

t_air_studio_play_count.dataList = dataList

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
	t_air_studio_play_count[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_play_count
