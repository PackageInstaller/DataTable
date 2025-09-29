-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_furniture_theme.lua

module("logic.config.t_house_furniture_theme", package.seeall)

local title = {
	name = 2,
	effect = 3,
	count = 4,
	skill = 5,
	id = 1
}
local dataList = {
	{
		1,
		"测试-主题1",
		"{2:100,3:100,5:100,7:100}",
		10,
		1
	},
	{
		2,
		"测试-主题2",
		"{2:100,3:100,5:100,7:100}",
		10,
		2
	},
	{
		3,
		"测试-主题2",
		"{2:100,3:100,5:100,7:100}",
		10,
		3
	},
	{
		101,
		"初始单人间套装",
		"{3:30}",
		0,
		0
	},
	{
		201,
		"温馨家居套装",
		"{3:40,5:60,7:80}",
		0,
		0
	},
	{
		202,
		"简约家居套装",
		"{3:50}",
		0,
		0
	},
	{
		301,
		"雅致家居套装",
		"{5:80,10:100,15:120}",
		0,
		0
	}
}
local t_house_furniture_theme = {}

t_house_furniture_theme.dataList = dataList

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
	t_house_furniture_theme[v[1]] = v

	setmetatable(v, mt)
end

return t_house_furniture_theme
