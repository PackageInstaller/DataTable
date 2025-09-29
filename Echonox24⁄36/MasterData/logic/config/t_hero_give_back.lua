-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_hero_give_back.lua

module("logic.config.t_hero_give_back", package.seeall)

local title = {
	heros = 2,
	code = 1
}
local dataList = {
	{
		150001,
		{
			2000022
		}
	}
}
local t_hero_give_back = {}

t_hero_give_back.dataList = dataList

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
	t_hero_give_back[v[1]] = v

	setmetatable(v, mt)
end

return t_hero_give_back
