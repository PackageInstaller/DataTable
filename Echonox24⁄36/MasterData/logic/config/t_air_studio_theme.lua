-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_theme.lua

module("logic.config.t_air_studio_theme", package.seeall)

local title = {
	id = 1,
	name = 2,
	sceneList = 3
}
local dataList = {
	{
		1,
		"夜晚城市",
		{
			3100101,
			3100102,
			3100103
		}
	}
}
local t_air_studio_theme = {}

t_air_studio_theme.dataList = dataList

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
	t_air_studio_theme[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_theme
