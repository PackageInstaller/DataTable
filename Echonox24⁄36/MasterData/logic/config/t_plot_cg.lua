-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_plot_cg.lua

module("logic.config.t_plot_cg", package.seeall)

local title = {
	bgPath = 3,
	code = 1,
	name = 2
}
local dataList = {
	{
		1001,
		"罪与罚01",
		"bg_cg_45"
	},
	{
		1002,
		"罪与罚02",
		"bg_cg_46"
	},
	{
		1003,
		"罪与罚03",
		"bg_cg_47"
	},
	{
		1004,
		"罪与罚04",
		"bg_cg_48"
	},
	{
		1005,
		"罪与罚05",
		"bg_cg_49"
	},
	{
		1006,
		"跑团海边",
		"bg_cg_65"
	},
	{
		1007,
		"封锁带和列车",
		"bg_cg_54"
	},
	{
		1008,
		"封锁带和墙壁",
		"bg_cg_55"
	},
	{
		1009,
		"灵感和大厦1",
		"bg_cg_56"
	},
	{
		1010,
		"灵感和大厦2",
		"bg_cg_57"
	}
}
local t_plot_cg = {}

t_plot_cg.dataList = dataList

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
	t_plot_cg[v[1]] = v

	setmetatable(v, mt)
end

return t_plot_cg
