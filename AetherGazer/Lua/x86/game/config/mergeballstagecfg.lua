return {
	[50101] = {
		name = "系统校准",
		victory_condition_type = 1,
		activity_id = 4243101,
		post_story = 0,
		pre_story = 940011001,
		desc = "初始化操作系统，开始采集模拟战场数据。",
		ult_progress = 1,
		unlock_vehicle = 50112,
		id = 50101,
		unlock_skill = 50121,
		victory_condition = {
			30
		},
		designated_buff = {
			{
				1,
				2003,
				2001
			},
			{
				2,
				1001,
				1002
			},
			{
				3,
				2004,
				1003
			}
		},
		designated_upgrade_count = {
			{
				1,
				3
			}
		},
		merge_progress = {
			4,
			10
		}
	},
	[50102] = {
		name = "清场效率",
		victory_condition_type = 3,
		activity_id = 4243101,
		post_story = 0,
		pre_story = 0,
		desc = "测试弹幕的覆盖范围，评估清场效率。\n*推荐选择<color=#E78300>密集弹幕</color>类武装。",
		ult_progress = 2,
		unlock_vehicle = 50113,
		id = 50102,
		unlock_skill = 50122,
		victory_condition = {
			10,
			301
		},
		designated_buff = {
			{
				1,
				2001,
				2002
			},
			{
				2,
				1002,
				2005
			},
			{
				3,
				1004,
				2004
			}
		},
		designated_upgrade_count = {},
		merge_progress = {
			10,
			15
		}
	},
	[50103] = {
		name = "功率输出",
		victory_condition_type = 3,
		activity_id = 4243101,
		post_story = 0,
		pre_story = 0,
		desc = "提升武器效能，测试最大输出功率。\n*推荐选择<color=#E78300>单点爆破</color>类武装。",
		ult_progress = 3,
		unlock_vehicle = 0,
		id = 50103,
		unlock_skill = 50123,
		victory_condition = {
			14,
			302
		},
		designated_buff = {
			{
				1,
				2003,
				2004
			},
			{
				2,
				1001,
				2005
			},
			{
				3,
				1002,
				2002
			}
		},
		designated_upgrade_count = {},
		merge_progress = {
			15
		}
	},
	[50104] = {
		name = "综合性能",
		victory_condition_type = 3,
		activity_id = 4243101,
		post_story = 940022001,
		pre_story = 0,
		desc = "全自由挂载模式启动，进行综合性能测试。",
		ult_progress = 0,
		unlock_vehicle = 0,
		id = 50104,
		unlock_skill = 0,
		victory_condition = {
			14,
			303
		},
		designated_buff = {},
		designated_upgrade_count = {},
		merge_progress = {
			15,
			20,
			25,
			30
		}
	},
	[50106] = {
		name = "综合性能",
		victory_condition_type = 1,
		activity_id = 0,
		post_story = 0,
		pre_story = 0,
		desc = "全自由挂载模式启动，进行综合性能测试。",
		ult_progress = 0,
		unlock_vehicle = 0,
		id = 50106,
		unlock_skill = 0,
		victory_condition = {
			26
		},
		designated_buff = {
			{
				1,
				1001,
				1003
			}
		},
		designated_upgrade_count = {},
		merge_progress = {
			5,
			6,
			7,
			8
		}
	},
	[50107] = {
		name = "综合性能",
		victory_condition_type = 1,
		activity_id = 0,
		post_story = 0,
		pre_story = 0,
		desc = "全自由挂载模式启动，进行综合性能测试。",
		ult_progress = 0,
		unlock_vehicle = 0,
		id = 50107,
		unlock_skill = 0,
		victory_condition = {
			100
		},
		designated_buff = {
			{
				1,
				1001,
				1003
			}
		},
		designated_upgrade_count = {},
		merge_progress = {
			100
		}
	},
	all = {
		50101,
		50102,
		50103,
		50104,
		50106,
		50107
	}
}
