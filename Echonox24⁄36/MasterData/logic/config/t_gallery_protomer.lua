-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_protomer.lua

module("logic.config.t_gallery_protomer", package.seeall)

local title = {
	id = 1,
	sortType = 2
}
local dataList = {
	{
		1901001,
		999
	},
	{
		1901002,
		998
	},
	{
		1901003,
		997
	},
	{
		1901004,
		996
	},
	{
		1901005,
		995
	},
	{
		1901006,
		994
	},
	{
		1901007,
		993
	}
}
local t_gallery_protomer = {}

t_gallery_protomer.dataList = dataList

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
	t_gallery_protomer[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_protomer
