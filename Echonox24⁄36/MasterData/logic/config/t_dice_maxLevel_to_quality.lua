-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dice_maxLevel_to_quality.lua

module("logic.config.t_dice_maxLevel_to_quality", package.seeall)

local title = {
	quality = 2,
	level = 1
}
local dataList = {
	{
		1,
		3
	},
	{
		2,
		3
	},
	{
		3,
		3
	},
	{
		4,
		4
	},
	{
		5,
		4
	},
	{
		6,
		5
	}
}
local t_dice_maxLevel_to_quality = {}

t_dice_maxLevel_to_quality.dataList = dataList

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
	t_dice_maxLevel_to_quality[v[1]] = v

	setmetatable(v, mt)
end

return t_dice_maxLevel_to_quality
