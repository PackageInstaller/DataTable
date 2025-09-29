-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_event_time.lua

module("logic.config.t_gallery_event_time", package.seeall)

local title = {
	id = 1,
	timetitile = 3,
	time = 2,
	sortType = 4
}
local dataList = {
	{
		1,
		"1960-01-01 00:00:00",
		"1\r\n6\r\n世\r\n纪",
		999
	},
	{
		2,
		"1980-01-01 00:00:00",
		"2\r\n0\r\n世\r\n纪",
		998
	},
	{
		3,
		"2020-01-01 00:00:00",
		"2\r\n0\r\n2\r\n0",
		997
	},
	{
		4,
		"2025-12-31 00:00:00",
		"2\r\n0\r\n2\r\n5",
		996
	},
	{
		5,
		"2030-01-01 00:00:00",
		"2\r\n0\r\n3\r\n0",
		995
	},
	{
		6,
		"2035-01-01 00:00:00",
		"2\r\n0\r\n3\r\n5",
		994
	}
}
local t_gallery_event_time = {}

t_gallery_event_time.dataList = dataList

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
	t_gallery_event_time[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_event_time
