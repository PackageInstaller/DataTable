-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_character_unlock.lua

module("logic.config.t_character_unlock", package.seeall)

local title = {
	unlockArray = 2,
	code = 1
}
local dataList = {
	{
		100011,
		{
			10001101,
			10001102,
			10001103,
			10001104,
			1000105,
			10001106,
			10001107,
			10001108,
			10001109,
			1000110,
			10001111,
			10001112,
			10001113,
			10001114,
			10001115,
			10001116,
			10001117,
			10001118,
			10001119,
			10001120,
			10001121,
			10001122,
			10001123,
			10001124,
			10001125
		}
	}
}
local t_character_unlock = {
	[100011] = {
		[{
			10001101,
			10001102,
			10001103,
			10001104,
			1000105,
			10001106,
			10001107,
			10001108,
			10001109,
			1000110,
			10001111,
			10001112,
			10001113,
			10001114,
			10001115,
			10001116,
			10001117,
			10001118,
			10001119,
			10001120,
			10001121,
			10001122,
			10001123,
			10001124,
			10001125
		}] = dataList[1]
	}
}

t_character_unlock.dataList = dataList

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
	setmetatable(v, mt)
end

return t_character_unlock
