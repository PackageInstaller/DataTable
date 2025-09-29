-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_login_pop_ups.lua

module("logic.config.t_login_pop_ups", package.seeall)

local title = {
	winType = 3,
	code = 1,
	sortIndex = 2
}
local dataList = {
	{
		100001,
		1,
		1
	},
	{
		100002,
		2,
		1
	},
	{
		100003,
		3,
		1
	},
	{
		100004,
		999,
		0
	},
	{
		100005,
		4,
		1
	},
	{
		100006,
		6,
		0
	},
	{
		200000,
		5,
		0
	}
}
local t_login_pop_ups = {}

t_login_pop_ups.dataList = dataList

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
	t_login_pop_ups[v[1]] = v

	setmetatable(v, mt)
end

return t_login_pop_ups
