-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_airtight_room_const.lua

module("logic.config.t_airtight_room_const", package.seeall)

local title = {
	numValue = 2,
	strValues = 5,
	jsonObject = 6,
	strValue = 3,
	keyName = 1,
	numValues = 4
}
local dataList = {
	{
		"AirtightTimeGuideId",
		50034,
		""
	},
	{
		"NormalTimeDungeon",
		1101171,
		""
	},
	{
		"ReturnNormalTimerGuideId",
		50007,
		""
	}
}
local t_airtight_room_const = {}

t_airtight_room_const.dataList = dataList

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
	t_airtight_room_const[v[1]] = v

	setmetatable(v, mt)
end

return t_airtight_room_const
