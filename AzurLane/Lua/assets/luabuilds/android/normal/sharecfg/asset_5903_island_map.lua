pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
rawget = var_0_10001
pg = var_0_10002

local var_0_2

if not var_0_10001(var_0_10002, "island_map") then
	setmetatable = var_0_2

	local var_0_1 = {
		__name = "island_map"
	}

	confNEO = var_3
	var_0_2 = var_0_2(var_0_1, var_3)
end

var_0.island_map = var_0_2
pg = var_0

local var_0_3 = var_0.island_map

var_0_3.all = {
	1001,
	1002,
	1003,
	1004,
	1005,
	1006,
	1007,
	1009,
	1010,
	1011
}
pg = var_0_3
pg = var_1

local var_0_4

if not var_1.base then
	var_0_4 = {}
end

var_0_3.base = var_0_4
pg = var_0_3
var_0_3.base.island_map = {}

;(function()
	pg = var_1_10000

	local var_1_0 = var_1_10000.base.island_map

	var_1_0[1001] = {
		minigame_id = 0,
		name = "晨露农场",
		time = "always",
		default_bgm = "story-richang-10",
		loading = 0,
		desc = "中央沃土，良田与牧场交织如锦。这丰饶的腹地是岛屿生生不息的食物之源。",
		sceneName = "Island/ScenesRes/Scenes/Ranch/map_xyd_ranch",
		save_transform = 1,
		id = 1001,
		born_object = 10010064,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_0

	local var_1_1 = var_1_0.base.island_map

	var_1_1[1002] = {
		minigame_id = 0,
		name = "港口",
		time = "always",
		default_bgm = "story-richang-2",
		loading = 0,
		desc = "南岸明珠，深水良港吞吐不息。繁忙码头与飘香咖啡馆比邻，高效的物流箱上晕染着温暖的人间烟火色。",
		sceneName = "Island/ScenesRes/Scenes/Fishery/map_xyd_fishery",
		save_transform = 1,
		id = 1002,
		born_object = 10020001,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_1

	local var_1_2 = var_1_1.base.island_map

	var_1_2[1003] = {
		minigame_id = 0,
		name = "集会岛 ",
		time = "always",
		default_bgm = "theme-myisland",
		loading = 1,
		desc = "主岛之外，一片封闭的空间特殊区域。仅在此处，海风将会带来远方的问候，并将问候的资讯传向远方。",
		sceneName = "Island/ScenesRes/Scenes/jhs_autumn/map_jhs_autumn",
		save_transform = 1,
		id = 1003,
		born_object = 10030001,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_2

	local var_1_3 = var_1_2.base.island_map

	var_1_3[1004] = {
		minigame_id = 0,
		name = "栖风原野",
		time = "always",
		default_bgm = "story-richang-10",
		loading = 0,
		desc = "西隅之境，蓊郁乔木掩映着沉睡的矿藏。长久以来，这片丰饶的野地一直以不竭的林木与矿石，为岛屿的发展注入最为澎湃的动力。",
		sceneName = "Island/ScenesRes/Scenes/Fell/map_xyd_fell",
		save_transform = 1,
		id = 1004,
		born_object = 10040024,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_3

	local var_1_4 = var_1_3.base.island_map

	var_1_4[1005] = {
		minigame_id = 0,
		name = "繁荫农圃",
		time = "always",
		default_bgm = "story-richang-10",
		loading = 0,
		desc = "北麓向阳，果园芬芳，苗圃葱绿。阳光眷顾处，自然的丰沛孕育着甜蜜果实与盎然生机。",
		sceneName = "Island/ScenesRes/Scenes/Orchard/map_xyd_orchard",
		save_transform = 1,
		id = 1005,
		born_object = 10050001,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_4

	local var_1_5 = var_1_4.base.island_map

	var_1_5[1006] = {
		minigame_id = 0,
		name = "港口商区 ",
		time = "always",
		default_bgm = "story-richang-6",
		loading = 0,
		desc = "重要商区，八方风味汇聚一堂。美食琳琅，烟火升腾，这里是岛屿最繁华热闹的休闲之所。",
		sceneName = "Island/ScenesRes/Scenes/Commercial/map_xyd_commercial",
		save_transform = 1,
		id = 1006,
		born_object = 10060001,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_5

	local var_1_6 = var_1_5.base.island_map

	var_1_6[1007] = {
		minigame_id = 0,
		name = "岛屿基地",
		time = "always",
		default_bgm = "story-richang-9",
		loading = 0,
		desc = "岛屿核心，工厂的轰鸣声与智慧的火花共舞，尖端科技研发在此进行，高效的产能与创新的活力相生相长——但，是秘密基地。",
		sceneName = "island/scenesres/scenes/factory/map_xyd_factory_01",
		save_transform = 1,
		id = 1007,
		born_object = 10070001,
		camera_zoom = {
			0.5,
			1,
			0.5
		}
	}
	pg = var_1_6

	local var_1_7 = var_1_6.base.island_map

	var_1_7[1009] = {
		minigame_id = 0,
		name = "啾咖啡",
		time = "always",
		default_bgm = "story-richang-4",
		loading = 0,
		desc = "",
		sceneName = "Island/ScenesRes/Scenes/CoffeeShop/map_coffeeshop_01",
		save_transform = 1,
		id = 1009,
		born_object = 10090001,
		camera_zoom = {
			0.3,
			0.8,
			0.5
		}
	}
	pg = var_1_7

	local var_1_8 = var_1_7.base.island_map

	var_1_8[1010] = {
		minigame_id = 1,
		name = "啾咖啡",
		time = "always",
		default_bgm = "story-battle-16bit-SFC",
		loading = 0,
		desc = "",
		sceneName = "Island/ScenesRes/Scenes/CoffeeShop/map_coffeeshop_01",
		save_transform = 0,
		id = 1010,
		born_object = 10100001,
		camera_zoom = {
			0.3,
			0.8,
			0.5
		}
	}
	pg = var_1_8
	var_1_8.base.island_map[1011] = {
		minigame_id = 0,
		name = "骗子酒馆",
		time = "always",
		default_bgm = "danmachi-az-story",
		loading = 0,
		desc = "",
		sceneName = "island/scenesres/scenes/bar/map_xyd_bar_01",
		save_transform = 0,
		id = 1011,
		born_object = 10100001,
		camera_zoom = {
			0.3,
			0.8,
			0.5
		}
	}

	return
end)()

return
