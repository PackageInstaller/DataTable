-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_negative_san_effect.lua

module("logic.config.t_roguelike_negative_san_effect", package.seeall)

local title = {
	value = 1,
	effects = 2
}
local dataList = {
	{
		-1
	},
	{
		-2
	},
	{
		-3
	},
	{
		-4
	}
}
local t_roguelike_negative_san_effect = {}

t_roguelike_negative_san_effect.dataList = dataList

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
	t_roguelike_negative_san_effect[v[1]] = v

	setmetatable(v, mt)
end

return t_roguelike_negative_san_effect
