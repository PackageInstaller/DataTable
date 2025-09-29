-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dungeon_first_entrance.lua

module("logic.config.t_dungeon_first_entrance", package.seeall)

local title = {
	precondition = 6,
	name = 2,
	entranceShowTime = 5,
	jumpEntranceIdList = 7,
	code = 1,
	sortOrder = 4,
	isShow = 3
}
local dataList = {}
local t_dungeon_first_entrance = {}

t_dungeon_first_entrance.dataList = dataList

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
	t_dungeon_first_entrance[v[1]] = v

	setmetatable(v, mt)
end

return t_dungeon_first_entrance
