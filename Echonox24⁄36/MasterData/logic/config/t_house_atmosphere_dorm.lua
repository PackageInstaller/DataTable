-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_atmosphere_dorm.lua

module("logic.config.t_house_atmosphere_dorm", package.seeall)

local title = {
	moodRecover = 3,
	rankNum = 2,
	level = 1
}
local dataList = {
	{
		1,
		0,
		0
	},
	{
		2,
		150,
		0.0083
	},
	{
		3,
		300,
		0.015
	},
	{
		4,
		500,
		0.0217
	},
	{
		5,
		750,
		0.0275
	},
	{
		6,
		1000,
		0.0333
	},
	{
		7,
		1150,
		0.0383
	},
	{
		8,
		1300,
		0.0433
	},
	{
		9,
		1450,
		0.0467
	},
	{
		10,
		1600,
		0.05
	}
}
local t_house_atmosphere_dorm = {}

t_house_atmosphere_dorm.dataList = dataList

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
	t_house_atmosphere_dorm[v[1]] = v

	setmetatable(v, mt)
end

return t_house_atmosphere_dorm
