-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_echo_upgrade.lua

module("logic.config.t_echo_upgrade", package.seeall)

local title = {
	need = 2,
	quality = 1,
	unlockLevel = 3
}
local dataList = {
	{
		5,
		{
			1,
			1,
			2,
			2,
			3
		},
		2
	},
	{
		4,
		{
			1,
			2,
			3,
			4,
			5
		},
		2
	},
	{
		3,
		{
			2,
			2,
			4,
			6,
			8
		},
		2
	},
	{
		2,
		{
			3,
			6,
			9,
			12,
			15
		},
		1
	}
}
local t_echo_upgrade = {}

t_echo_upgrade.dataList = dataList

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
	t_echo_upgrade[v[1]] = v

	setmetatable(v, mt)
end

return t_echo_upgrade
