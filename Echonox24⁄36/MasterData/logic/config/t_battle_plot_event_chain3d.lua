-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_battle_plot_event_chain3d.lua

module("logic.config.t_battle_plot_event_chain3d", package.seeall)

local title = {
	id = 1,
	event = 4,
	resPath = 3,
	sort = 2
}
local dataList = {
	{
		110102001,
		1,
		"plot_performance_110102_1",
		""
	},
	{
		110102002,
		1,
		"plot_performance_110102_2",
		"2#102"
	},
	{
		110104001,
		1,
		"plot_performance_110104_1",
		"2#104"
	},
	{
		110104002,
		1,
		"plot_performance_110104_2",
		"2#103"
	},
	{
		110104002,
		2,
		"plot_performance_110104_2",
		"1#11010408"
	},
	{
		110104003,
		1,
		"plot_performance_110104_0",
		"1#11010409"
	},
	{
		110104003,
		2,
		"plot_performance_110104_0",
		"2#101"
	},
	{
		110104003,
		3,
		"plot_performance_110104_0",
		"2#102"
	},
	{
		110209001,
		1,
		"plot_performance_110104_2",
		"2#103"
	},
	{
		110209001,
		2,
		"plot_performance_110104_2",
		"1#11020901#11020902#11020906#11020907"
	}
}
local t_battle_plot_event_chain3d = {}

t_battle_plot_event_chain3d.dataList = dataList

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
	local parent1 = t_battle_plot_event_chain3d[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_battle_plot_event_chain3d[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_battle_plot_event_chain3d
