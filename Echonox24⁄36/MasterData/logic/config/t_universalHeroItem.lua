-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_universalHeroItem.lua

module("logic.config.t_universalHeroItem", package.seeall)

local title = {
	pieceNum = 2,
	universalAnchorId = 4,
	universalPieceId = 3,
	qua = 1
}
local dataList = {
	{
		4,
		50,
		1404002,
		1403002
	},
	{
		5,
		50,
		1404001,
		1403001
	}
}
local t_universalHeroItem = {}

t_universalHeroItem.dataList = dataList

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
	t_universalHeroItem[v[1]] = v

	setmetatable(v, mt)
end

return t_universalHeroItem
