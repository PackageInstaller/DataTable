-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_achievement_label.lua

module("logic.config.t_achievement_label", package.seeall)

local title = {
	id = 1,
	name = 2,
	bg = 3,
	achievements = 4
}
local dataList = {
	{
		1,
		"作战分页",
		"resources_tab1",
		{
			11000001,
			11000002,
			11000003
		}
	},
	{
		2,
		"员工分页",
		"resources_tab2",
		{
			12000001,
			12000002,
			12000003,
			12000004
		}
	},
	{
		3,
		"基地分页",
		"resources_tab3",
		{
			13000001,
			13000002
		}
	},
	{
		4,
		"梦境分页",
		"resources_tab4",
		{
			14000001,
			14000002
		}
	},
	{
		5,
		"其他分页",
		"resources_tab5",
		{
			15000001,
			15000002,
			15000003
		}
	}
}
local t_achievement_label = {}

t_achievement_label.dataList = dataList

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
	t_achievement_label[v[1]] = v

	setmetatable(v, mt)
end

return t_achievement_label
