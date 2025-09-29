-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_roguelike_props_lib.lua

module("logic.config.t_roguelike_props_lib", package.seeall)

local title = {
	id = 1,
	propsIds = 2
}
local dataList = {
	{
		100001,
		{
			100,
			110,
			120
		}
	}
}
local t_roguelike_props_lib = {
	[100001] = dataList[1]
}

t_roguelike_props_lib.dataList = dataList

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

return t_roguelike_props_lib
