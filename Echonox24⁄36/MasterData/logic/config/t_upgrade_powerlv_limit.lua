-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_upgrade_powerlv_limit.lua

module("logic.config.t_upgrade_powerlv_limit", package.seeall)

local title = {
	quaA = 3,
	quaB = 4,
	quaS = 2,
	quaC = 5,
	powerLv = 1
}
local dataList = {
	{
		1,
		10,
		10,
		10,
		10
	},
	{
		2,
		20,
		20,
		20,
		20
	},
	{
		3,
		30,
		30,
		30,
		30
	},
	{
		4,
		50,
		50,
		50,
		50
	},
	{
		5,
		70,
		70,
		70,
		70
	},
	{
		6,
		90,
		90,
		90,
		90
	}
}
local t_upgrade_powerlv_limit = {}

t_upgrade_powerlv_limit.dataList = dataList

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
	t_upgrade_powerlv_limit[v[1]] = v

	setmetatable(v, mt)
end

return t_upgrade_powerlv_limit
