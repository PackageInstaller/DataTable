-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_gallery_cg.lua

module("logic.config.t_gallery_cg", package.seeall)

local title = {
	typ = 2,
	name = 3,
	res = 5,
	sortType = 6,
	id = 1,
	icon = 4
}
local dataList = {
	{
		1001,
		1,
		"剧情CG-1",
		"bg_cg_17",
		"plot/bg_cg_3",
		999
	},
	{
		1002,
		1,
		"剧情CG-2",
		"bg_cg_17",
		"plot/bg_cg_8",
		998
	},
	{
		1003,
		1,
		"剧情CG-3",
		"bg_cg_17",
		"plot/bg_cg_9",
		997
	},
	{
		1004,
		1,
		"剧情CG-3",
		"bg_cg_17",
		"plot/bg_cg_10",
		996
	},
	{
		1005,
		1,
		"剧情CG-4",
		"bg_cg_17",
		"plot/bg_cg_11",
		995
	},
	{
		1006,
		1,
		"剧情CG-5",
		"bg_cg_17",
		"plot/bg_cg_12",
		994
	},
	{
		1007,
		1,
		"剧情CG-6",
		"bg_cg_17",
		"plot/bg_cg_13",
		993
	},
	{
		1008,
		1,
		"剧情CG-7",
		"bg_cg_17",
		"plot/bg_cg_14",
		992
	},
	{
		1009,
		1,
		"剧情CG-8",
		"bg_cg_17",
		"plot/bg_cg_15",
		991
	},
	{
		1010,
		1,
		"剧情CG-9",
		"bg_cg_17",
		"plot/bg_cg_16",
		990
	},
	{
		1011,
		1,
		"剧情CG-10",
		"bg_cg_17",
		"plot/bg_cg_17",
		989
	},
	{
		1012,
		1,
		"剧情CG-11",
		"bg_cg_17",
		"plot/bg_cg_18",
		988
	},
	{
		1013,
		1,
		"剧情CG-12",
		"bg_cg_17",
		"plot/bg_cg_19",
		987
	},
	{
		1014,
		1,
		"剧情CG-13",
		"bg_cg_17",
		"plot/bg_cg_20",
		986
	},
	{
		1015,
		1,
		"剧情CG-14",
		"bg_cg_17",
		"plot/bg_cg_21",
		985
	},
	{
		1016,
		1,
		"剧情CG-15",
		"bg_cg_17",
		"plot/bg_cg_22",
		984
	},
	{
		1017,
		1,
		"剧情CG-16",
		"bg_cg_17",
		"plot/bg_cg_23",
		983
	},
	{
		1018,
		1,
		"剧情CG-17",
		"bg_cg_17",
		"plot/bg_cg_24",
		982
	},
	{
		1019,
		1,
		"剧情CG-18",
		"bg_cg_17",
		"plot/bg_cg_25",
		981
	},
	{
		1020,
		1,
		"剧情CG-19",
		"bg_cg_17",
		"plot/bg_cg_26",
		980
	},
	{
		1021,
		1,
		"剧情CG-20",
		"bg_cg_17",
		"plot/bg_cg_27",
		979
	},
	{
		1022,
		1,
		"剧情CG-21",
		"bg_cg_17",
		"plot/bg_cg_32",
		978
	},
	{
		1023,
		1,
		"剧情CG-22",
		"bg_cg_17",
		"plot/bg_cg_33",
		977
	},
	{
		1024,
		1,
		"剧情CG-23",
		"bg_cg_17",
		"plot/bg_cg_34",
		976
	},
	{
		1025,
		1,
		"剧情CG-20",
		"bg_cg_17",
		"plot/bg_cg_35",
		975
	},
	{
		2001,
		2,
		"过场CG-1",
		"bg_cg_17",
		"loading/loading_bg",
		999
	},
	{
		2002,
		2,
		"过场CG-1",
		"bg_cg_17",
		"loading/loading_bg3",
		998
	},
	{
		2003,
		2,
		"过场CG-2",
		"bg_cg_17",
		"loading/loading_bg4",
		997
	},
	{
		3001,
		3,
		"活动CG-2",
		"bg_cg_17",
		"plot/bg_scene_2",
		999
	},
	{
		3002,
		3,
		"活动CG-2",
		"bg_cg_17",
		"plot/bg_scene_3",
		998
	},
	{
		3003,
		3,
		"活动CG-2",
		"bg_cg_17",
		"plot/bg_scene_4",
		997
	}
}
local t_gallery_cg = {}

t_gallery_cg.dataList = dataList

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
	t_gallery_cg[v[1]] = v

	setmetatable(v, mt)
end

return t_gallery_cg
