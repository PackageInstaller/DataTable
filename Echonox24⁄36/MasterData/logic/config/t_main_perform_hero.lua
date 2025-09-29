-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_main_perform_hero.lua

module("logic.config.t_main_perform_hero", package.seeall)

local title = {
	id = 1,
	heroId = 2,
	weight = 3
}
local dataList = {
	{
		101,
		2000013,
		0
	},
	{
		101,
		2000021,
		0
	},
	{
		101,
		2000036,
		0
	},
	{
		102,
		2000012,
		0
	},
	{
		102,
		2000011,
		0
	},
	{
		102,
		2000041,
		0
	},
	{
		201,
		2000019,
		0
	},
	{
		201,
		2000039,
		0
	},
	{
		202,
		2000020,
		0
	},
	{
		203,
		2000016,
		0
	},
	{
		203,
		2000053,
		0
	},
	{
		203,
		2000056,
		0
	},
	{
		301,
		2000022,
		0
	},
	{
		301,
		2000057,
		0
	},
	{
		302,
		2000005,
		0
	},
	{
		10004,
		2000059,
		0
	}
}
local t_main_perform_hero = {}

t_main_perform_hero.dataList = dataList

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
	local parent1 = t_main_perform_hero[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_main_perform_hero[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_main_perform_hero
