-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_echo_lottery_pool_detail.lua

module("logic.config.t_echo_lottery_pool_detail", package.seeall)

local title = {
	poolCode = 1,
	quality = 2,
	groupCode = 3
}
local dataList = {
	{
		2001,
		1,
		20001
	},
	{
		2001,
		2,
		20002
	},
	{
		2001,
		2,
		20003
	},
	{
		2001,
		2,
		20004
	},
	{
		2002,
		1,
		20001
	},
	{
		2002,
		1,
		20010
	},
	{
		2002,
		2,
		20002
	},
	{
		2002,
		2,
		20003
	},
	{
		2002,
		2,
		20004
	},
	{
		2003,
		1,
		20001
	},
	{
		2003,
		1,
		20020
	},
	{
		2003,
		2,
		20002
	},
	{
		2003,
		2,
		20003
	},
	{
		2003,
		2,
		20004
	}
}
local t_echo_lottery_pool_detail = {}

t_echo_lottery_pool_detail.dataList = dataList

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
	local parent1 = t_echo_lottery_pool_detail[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_echo_lottery_pool_detail[v[1]] = parent1
	end

	parent1[v[3]] = v

	setmetatable(v, mt)
end

return t_echo_lottery_pool_detail
