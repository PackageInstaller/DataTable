-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_level.lua

module("logic.config.t_house_level", package.seeall)

local title = {
	reward = 4,
	houseLv = 1,
	exp = 3,
	icon = 2,
	desc = 5
}
local dataList = {
	{
		1,
		"build_101",
		250,
		0,
		""
	},
	{
		2,
		"build_101",
		1000,
		1420101,
		"解锁主管室升级上限至Lv2"
	},
	{
		3,
		"build_102",
		2500,
		1420102,
		"解锁主管室升级上限至Lv3"
	},
	{
		4,
		"build_102",
		4500,
		1420103,
		"解锁主管室升级上限至Lv4"
	},
	{
		5,
		"build_103",
		8000,
		1420104,
		"解锁主管室升级上限至Lv5"
	},
	{
		6,
		"build_103",
		12000,
		1420105,
		"解锁主管室升级上限至Lv6"
	},
	{
		7,
		"build_104",
		16000,
		1420106,
		"解锁主管室升级上限至Lv7"
	},
	{
		8,
		"build_104",
		22000,
		1420107,
		"解锁主管室升级上限至Lv8"
	},
	{
		9,
		"build_105",
		30000,
		1420108,
		"解锁主管室升级上限至Lv9"
	},
	{
		10,
		"build_105",
		0,
		1420109,
		"解锁主管室升级上限至Lv10"
	}
}
local t_house_level = {}

t_house_level.dataList = dataList

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
	t_house_level[v[1]] = v

	setmetatable(v, mt)
end

return t_house_level
