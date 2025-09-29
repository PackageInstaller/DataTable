-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_heroPiece.lua

module("logic.config.t_heroPiece", package.seeall)

local title = {
	pieceNum = 2,
	qua = 1,
	reward = 3
}
local dataList = {
	{
		2,
		50,
		{
			{
				num = 5,
				code = 1100008
			}
		}
	},
	{
		3,
		50,
		{
			{
				num = 5,
				code = 1100008
			}
		}
	},
	{
		4,
		50,
		{
			{
				num = 2,
				code = 1100007
			}
		}
	},
	{
		5,
		50,
		{
			{
				num = 10,
				code = 1100007
			}
		}
	}
}
local t_heroPiece = {}

t_heroPiece.dataList = dataList

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
	t_heroPiece[v[1]] = v

	setmetatable(v, mt)
end

return t_heroPiece
