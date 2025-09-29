-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_season_label.lua

module("logic.config.t_season_label", package.seeall)

local title = {
	id = 1,
	taskLimit = 2
}
local dataList = {
	{
		100031,
		10
	},
	{
		100032,
		20
	},
	{
		100033,
		20
	},
	{
		100039,
		7
	}
}
local t_season_label = {}

t_season_label.dataList = dataList

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
	t_season_label[v[1]] = v

	setmetatable(v, mt)
end

return t_season_label
