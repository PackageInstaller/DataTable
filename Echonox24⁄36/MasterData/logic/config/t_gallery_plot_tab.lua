-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_plot_tab.lua

module("logic.config.t_gallery_plot_tab", package.seeall)

local title = {
	id = 1,
	name = 3,
	plots = 6,
	unlockTips = 7,
	tabRes = 4,
	bgRes = 5,
	page = 2
}
local dataList = {
	{
		1,
		1,
		"序章",
		"",
		"plot/bg_scene_21",
		{
			1000101
		},
		""
	},
	{
		1,
		2,
		"第一章",
		"",
		"plot/bg_scene_22",
		{
			1010101,
			1010201,
			1010211,
			1010301,
			1010401,
			1010411,
			1010501,
			1010601,
			1010701,
			1010801,
			1010901,
			1011001,
			1011101,
			1011201,
			1011211
		},
		"通关主线1.12-1解锁"
	},
	{
		2,
		1,
		"断章魔女教团",
		"",
		"plot/bg_scene_23",
		{
			2010101,
			2010201,
			2010301,
			2010401,
			2010501,
			2010601,
			2010701
		},
		"通关1.12-4解锁"
	},
	{
		3,
		1,
		"夏季狂欢",
		"",
		"plot/bg_scene_24",
		{
			3010101,
			3010201,
			3010301,
			3010401,
			3010501
		},
		"通关夏季狂欢解锁"
	}
}
local t_gallery_plot_tab = {}

t_gallery_plot_tab.dataList = dataList

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
	local parent1 = t_gallery_plot_tab[v[1]]

	if parent1 == nil then
		parent1 = {}
		t_gallery_plot_tab[v[1]] = parent1
	end

	parent1[v[2]] = v

	setmetatable(v, mt)
end

return t_gallery_plot_tab
