-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_second_entrance.lua

module("logic.config.t_dungeon_second_entrance", package.seeall)

local title = {
	bgName = 6,
	name = 2,
	entranceShowTime = 8,
	precondition = 9,
	sortOrder = 5,
	entranceType = 4,
	weekDays = 7,
	code = 1,
	jumpChapterId = 10,
	isShow = 3
}
local dataList = {}
local t_dungeon_second_entrance = {}

t_dungeon_second_entrance.dataList = dataList

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
	t_dungeon_second_entrance[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_second_entrance
