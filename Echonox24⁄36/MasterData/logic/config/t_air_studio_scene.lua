-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_scene.lua

module("logic.config.t_air_studio_scene", package.seeall)

local title = {
	icon = 10,
	name = 9,
	effectBuildingLimit = 5,
	levelId = 2,
	entityLimit = 7,
	highBuildingLimit = 4,
	ambushEntityLimit = 8,
	availableBuildings = 3,
	id = 1,
	messageBuildingLimit = 6
}
local dataList = {
	{
		3100101,
		100101,
		nil,
		100,
		60,
		50,
		50,
		50,
		"休闲广场",
		"sx-s111_city_b_04-kqgf"
	},
	{
		3100102,
		100102,
		nil,
		50,
		40,
		50,
		50,
		50,
		"街心公园",
		"sx-s111_city_b_05-kqgf"
	},
	{
		3100103,
		100103,
		nil,
		60,
		50,
		50,
		50,
		50,
		"商业街区",
		"sx-s111_city_b_06-kqgf"
	}
}
local t_air_studio_scene = {}

t_air_studio_scene.dataList = dataList

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
	t_air_studio_scene[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_scene
