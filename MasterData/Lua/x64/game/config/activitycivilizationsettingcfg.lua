return {
	[101] = {
		id = 101,
		desc = "模拟环境异常，开始出现<color=#E78300>「交涉僵持」</color>，请合理使用技能解决问题。",
		each_turn_num = 144,
		type = 1,
		hex = 0,
		day = 1,
		begin_time = 0,
		map_bigger = 0,
		note = "第一天",
		food_cost = 0,
		cells_list = {
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[102] = {
		id = 102,
		desc = "模拟环境异常，开始出现<color=#E78300>「视骸」</color>，请合理使用技能解决问题。",
		each_turn_num = 120,
		type = 1,
		hex = 1,
		day = 2,
		begin_time = 1440,
		map_bigger = 0,
		note = "第二天",
		food_cost = 0,
		cells_list = {
			0,
			0,
			0,
			1,
			0,
			0,
			0
		}
	},
	[103] = {
		id = 103,
		desc = "模拟环境正常，<color=#E78300>模拟场地扩大</color>，请继续提升研究进度。",
		each_turn_num = 96,
		type = 1,
		hex = 0,
		day = 3,
		begin_time = 2880,
		map_bigger = 0,
		note = "第三天",
		food_cost = 0,
		cells_list = {
			3,
			3,
			3,
			0,
			1,
			0,
			0
		}
	},
	[104] = {
		id = 104,
		desc = "模拟环境异常，<color=#E78300>资源消耗量增加</color>，请关注物资数量。",
		each_turn_num = 80,
		type = 1,
		hex = 1,
		day = 4,
		begin_time = 4320,
		map_bigger = 1,
		note = "第四天",
		food_cost = 0,
		cells_list = {
			3,
			0,
			0,
			1,
			0,
			0,
			0
		}
	},
	[105] = {
		id = 105,
		desc = "模拟环境正常，监测到<color=#E78300>「天父」痕迹</color>，请提升研究进度，提前做好应对。",
		each_turn_num = 69,
		type = 1,
		hex = 0,
		day = 5,
		begin_time = 5760,
		map_bigger = 0,
		note = "第五天",
		food_cost = 1,
		cells_list = {
			3,
			3,
			3,
			-1,
			1,
			0,
			0
		}
	},
	[106] = {
		id = 106,
		desc = "模拟环境异常，开始出现<color=#E78300>「封锁区」</color>，请合理使用技能解决问题。",
		each_turn_num = 58,
		type = 1,
		hex = 0,
		day = 6,
		begin_time = 7200,
		map_bigger = 0,
		note = "第六天",
		food_cost = 0,
		cells_list = {
			0,
			3,
			3,
			0,
			0,
			0,
			0
		}
	},
	[107] = {
		id = 107,
		desc = "模拟环境异常，<color=#E78300>「天父」即将出现</color>，请做好应对准备！",
		each_turn_num = 51,
		type = 1,
		hex = 1,
		day = 7,
		begin_time = 8640,
		map_bigger = 0,
		note = "第七天",
		food_cost = 1,
		cells_list = {
			3,
			3,
			3,
			0,
			-1,
			1,
			0
		}
	},
	[108] = {
		id = 108,
		desc = "模拟环境异常，模拟即将超时，<color=#E78300>请尽快消灭「天父」</color>！",
		each_turn_num = 46,
		type = 1,
		hex = 0,
		day = 8,
		begin_time = 10080,
		map_bigger = 0,
		note = "第八天",
		food_cost = 0,
		cells_list = {
			3,
			0,
			3,
			-1,
			-1,
			0,
			20
		}
	},
	[109] = {
		id = 109,
		desc = "",
		each_turn_num = 46,
		type = 1,
		hex = 0,
		day = 9,
		begin_time = 11520,
		map_bigger = 0,
		note = "第九天",
		food_cost = 0,
		cells_list = {
			3,
			4,
			6,
			0,
			0,
			-1,
			0
		}
	},
	[201] = {
		id = 201,
		desc = "模拟环境正常，请继续提升研究进度。",
		each_turn_num = 360,
		type = 2,
		hex = 0,
		day = 1,
		begin_time = 0,
		map_bigger = 0,
		note = "第一天",
		food_cost = 0,
		cells_list = {
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[202] = {
		id = 202,
		desc = "模拟环境异常，「天父」即将出现，请做好应对准备！",
		each_turn_num = 360,
		type = 2,
		hex = 1,
		day = 2,
		begin_time = 1440,
		map_bigger = 0,
		note = "第二天",
		food_cost = 0,
		cells_list = {
			0,
			0,
			0,
			0,
			0,
			0,
			0
		}
	},
	[203] = {
		id = 203,
		desc = "",
		each_turn_num = 360,
		type = 2,
		hex = 1,
		day = 3,
		begin_time = 2880,
		map_bigger = 1,
		note = "第三天",
		food_cost = 1,
		cells_list = {
			0,
			0,
			0,
			0,
			0,
			0,
			1
		}
	},
	get_id_list_by_type = {
		[2] = {
			201,
			202,
			203
		},
		{
			101,
			102,
			103,
			104,
			105,
			106,
			107,
			108,
			109
		}
	},
	all = {
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108,
		109,
		201,
		202,
		203
	}
}
