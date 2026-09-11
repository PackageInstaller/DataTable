return {
	[10101] = {
		cost = 3,
		name = "生命强化·Ⅰ",
		template_id = 1,
		description = "最大生命值提高10%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_3",
		show_temp = 1,
		show_desc = "最大生命值增加",
		id = 10101,
		line_type = 0,
		level = 1,
		effect = {
			101011
		},
		pre_node = {},
		show_value = {
			1,
			10
		}
	},
	[10102] = {
		cost = 3,
		name = "减伤强化·Ⅰ",
		template_id = 1,
		description = "受到伤害降低4%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_2",
		show_temp = 2,
		show_desc = "伤害减免增加",
		id = 10102,
		line_type = 0,
		level = 1,
		effect = {
			101021
		},
		pre_node = {},
		show_value = {
			1,
			4
		}
	},
	[10103] = {
		cost = 3,
		name = "伤害强化·Ⅰ",
		template_id = 1,
		description = "造成伤害提高8%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_1",
		show_temp = 3,
		show_desc = "造成伤害增加",
		id = 10103,
		line_type = 0,
		level = 1,
		effect = {
			101031
		},
		pre_node = {},
		show_value = {
			1,
			8
		}
	},
	[10201] = {
		cost = 3,
		name = "回复强化·Ⅰ",
		template_id = 1,
		description = "战斗胜利后，生命值恢复量提高2%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_7",
		show_temp = 4,
		show_desc = "战斗胜利后恢复生命值增加",
		id = 10201,
		line_type = 0,
		level = 2,
		effect = {
			102011
		},
		pre_node = {
			10101
		},
		show_value = {
			1,
			2
		}
	},
	[10202] = {
		cost = 3,
		name = "初始资源·Ⅰ",
		template_id = 1,
		description = "初始持有的微光晶砾增加80",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_6",
		show_temp = 5,
		show_desc = "初始持有的微光晶砾增加",
		id = 10202,
		line_type = 0,
		level = 2,
		effect = {
			102021
		},
		pre_node = {
			10102
		},
		show_value = {
			0,
			80
		}
	},
	[10203] = {
		cost = 3,
		name = "重置点数·Ⅰ",
		template_id = 1,
		description = "初始持有的重置点数增加2个",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_5",
		show_temp = 7,
		show_desc = "初始持有的重置点数增加",
		id = 10203,
		line_type = 0,
		level = 2,
		effect = {
			102031
		},
		pre_node = {
			10103
		},
		show_value = {
			0,
			2
		}
	},
	[10399] = {
		cost = 6,
		name = "额外外接程序",
		template_id = 1,
		description = "每局游戏的前2次战斗胜利后，额外获得1个外接程序",
		node_type = 1,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_8",
		show_temp = 0,
		show_desc = "",
		id = 10399,
		line_type = 0,
		level = 3,
		effect = {
			103991
		},
		pre_node = {
			10201,
			10202,
			10203
		},
		show_value = {}
	},
	[10401] = {
		cost = 8,
		name = "生命强化·Ⅱ",
		template_id = 1,
		description = "最大生命值提高10%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_3",
		show_temp = 1,
		show_desc = "最大生命值增加",
		id = 10401,
		line_type = 0,
		level = 4,
		effect = {
			104011
		},
		pre_node = {
			10399
		},
		show_value = {
			1,
			10
		}
	},
	[10402] = {
		cost = 8,
		name = "减伤强化·Ⅱ",
		template_id = 1,
		description = "受到伤害降低4%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_2",
		show_temp = 2,
		show_desc = "伤害减免增加",
		id = 10402,
		line_type = 0,
		level = 4,
		effect = {
			104021
		},
		pre_node = {
			10399
		},
		show_value = {
			1,
			4
		}
	},
	[10403] = {
		cost = 8,
		name = "伤害强化·Ⅱ",
		template_id = 1,
		description = "造成伤害提高8%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_1",
		show_temp = 3,
		show_desc = "造成伤害增加",
		id = 10403,
		line_type = 0,
		level = 4,
		effect = {
			104031
		},
		pre_node = {
			10399
		},
		show_value = {
			1,
			8
		}
	},
	[10501] = {
		cost = 8,
		name = "回复强化·Ⅱ",
		template_id = 1,
		description = "战斗胜利后，生命值恢复量提高2%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_7",
		show_temp = 4,
		show_desc = "战斗胜利后恢复生命值增加",
		id = 10501,
		line_type = 0,
		level = 5,
		effect = {
			105011
		},
		pre_node = {
			10401
		},
		show_value = {
			1,
			2
		}
	},
	[10502] = {
		cost = 8,
		name = "初始资源·Ⅱ",
		template_id = 1,
		description = "初始持有的微光晶砾增加80",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_6",
		show_temp = 5,
		show_desc = "初始持有的微光晶砾增加",
		id = 10502,
		line_type = 0,
		level = 5,
		effect = {
			105021
		},
		pre_node = {
			10402
		},
		show_value = {
			0,
			80
		}
	},
	[10503] = {
		cost = 8,
		name = "游商扩容·Ⅰ",
		template_id = 1,
		description = "游商房间中增加2个外接程序售卖栏位",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_9",
		show_temp = 9,
		show_desc = "游商房间中外接程序售卖栏位增加",
		id = 10503,
		line_type = 0,
		level = 5,
		effect = {
			105031
		},
		pre_node = {
			10403
		},
		show_value = {
			0,
			2
		}
	},
	[10699] = {
		cost = 12,
		name = "启程支援",
		template_id = 1,
		description = "每局游戏的前2个战斗类房间可以直接胜利通过",
		node_type = 1,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_10",
		show_temp = 0,
		show_desc = "",
		id = 10699,
		line_type = 0,
		level = 6,
		effect = {
			106991
		},
		pre_node = {
			10501,
			10502,
			10503
		},
		show_value = {}
	},
	[10701] = {
		cost = 8,
		name = "生命强化·Ⅲ",
		template_id = 1,
		description = "最大生命值提高10%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_3",
		show_temp = 1,
		show_desc = "最大生命值增加",
		id = 10701,
		line_type = 0,
		level = 7,
		effect = {
			107011
		},
		pre_node = {
			10699
		},
		show_value = {
			1,
			10
		}
	},
	[10702] = {
		cost = 8,
		name = "减伤强化·Ⅲ",
		template_id = 1,
		description = "受到伤害降低4%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_2",
		show_temp = 2,
		show_desc = "伤害减免增加",
		id = 10702,
		line_type = 0,
		level = 7,
		effect = {
			107021
		},
		pre_node = {
			10699
		},
		show_value = {
			1,
			4
		}
	},
	[10703] = {
		cost = 8,
		name = "伤害强化·Ⅲ",
		template_id = 1,
		description = "造成伤害提高8%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_1",
		show_temp = 3,
		show_desc = "造成伤害增加",
		id = 10703,
		line_type = 0,
		level = 7,
		effect = {
			107031
		},
		pre_node = {
			10699
		},
		show_value = {
			1,
			8
		}
	},
	[10801] = {
		cost = 8,
		name = "回复强化·Ⅲ",
		template_id = 1,
		description = "战斗胜利后，生命值恢复量提高2%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_7",
		show_temp = 4,
		show_desc = "战斗胜利后恢复生命值增加",
		id = 10801,
		line_type = 0,
		level = 8,
		effect = {
			108011
		},
		pre_node = {
			10701
		},
		show_value = {
			1,
			2
		}
	},
	[10802] = {
		cost = 8,
		name = "初始资源·Ⅲ",
		template_id = 1,
		description = "初始持有的微光晶砾增加80",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_6",
		show_temp = 5,
		show_desc = "初始持有的微光晶砾增加",
		id = 10802,
		line_type = 0,
		level = 8,
		effect = {
			108021
		},
		pre_node = {
			10702
		},
		show_value = {
			0,
			80
		}
	},
	[10803] = {
		cost = 8,
		name = "游商扩容·Ⅱ",
		template_id = 1,
		description = "游商房间中增加2个收集品售卖栏位",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_9",
		show_temp = 10,
		show_desc = "游商房间中收集品售卖栏位增加",
		id = 10803,
		line_type = 0,
		level = 8,
		effect = {
			108031
		},
		pre_node = {
			10703
		},
		show_value = {
			0,
			2
		}
	},
	[10999] = {
		cost = 12,
		name = "备用密钥·Ⅰ",
		template_id = 1,
		description = "重置密钥上限增加1点",
		node_type = 1,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_4",
		show_temp = 0,
		show_desc = "",
		id = 10999,
		line_type = 0,
		level = 9,
		effect = {
			109991,
			109992
		},
		pre_node = {
			10801,
			10802,
			10803
		},
		show_value = {}
	},
	[11001] = {
		cost = 8,
		name = "生命强化·Ⅳ",
		template_id = 1,
		description = "最大生命值提高10%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_3",
		show_temp = 1,
		show_desc = "最大生命值增加",
		id = 11001,
		line_type = 0,
		level = 10,
		effect = {
			110011
		},
		pre_node = {
			10999
		},
		show_value = {
			1,
			10
		}
	},
	[11002] = {
		cost = 8,
		name = "减伤强化·Ⅳ",
		template_id = 1,
		description = "受到伤害降低4%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_2",
		show_temp = 2,
		show_desc = "伤害减免增加",
		id = 11002,
		line_type = 0,
		level = 10,
		effect = {
			110021
		},
		pre_node = {
			10999
		},
		show_value = {
			1,
			4
		}
	},
	[11003] = {
		cost = 8,
		name = "伤害强化·Ⅳ",
		template_id = 1,
		description = "造成伤害提高8%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_1",
		show_temp = 3,
		show_desc = "造成伤害增加",
		id = 11003,
		line_type = 0,
		level = 10,
		effect = {
			110031
		},
		pre_node = {
			10999
		},
		show_value = {
			1,
			8
		}
	},
	[11101] = {
		cost = 8,
		name = "回复强化·Ⅳ",
		template_id = 1,
		description = "战斗胜利后，生命值恢复量提高2%",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_7",
		show_temp = 4,
		show_desc = "战斗胜利后恢复生命值增加",
		id = 11101,
		line_type = 0,
		level = 11,
		effect = {
			111011
		},
		pre_node = {
			11001
		},
		show_value = {
			1,
			2
		}
	},
	[11102] = {
		cost = 8,
		name = "初始资源·Ⅳ",
		template_id = 1,
		description = "初始持有的微光晶砾增加80",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_6",
		show_temp = 5,
		show_desc = "初始持有的微光晶砾增加",
		id = 11102,
		line_type = 0,
		level = 11,
		effect = {
			111021
		},
		pre_node = {
			11002
		},
		show_value = {
			0,
			80
		}
	},
	[11103] = {
		cost = 8,
		name = "周期强化",
		template_id = 1,
		description = "每经过5个房间，为1个随机外接程序提升1级稀有度",
		node_type = 0,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_8",
		show_temp = 6,
		show_desc = "每经过5个房间，为X个随机外接程序提升1级稀有度",
		id = 11103,
		line_type = 0,
		level = 11,
		effect = {
			111031
		},
		pre_node = {
			11003
		},
		show_value = {
			0,
			1
		}
	},
	[11299] = {
		cost = 12,
		name = "高级程序拓展",
		template_id = 1,
		description = "少量提高史诗和传说外接程序的获取概率",
		node_type = 1,
		icon = "TextureConfig/Activity_Roulike/Roulike_Technology/Roulike_technology_point_8",
		show_temp = 0,
		show_desc = "",
		id = 11299,
		line_type = 0,
		level = 12,
		effect = {
			112991,
			112992
		},
		pre_node = {
			11101,
			11102,
			11103
		},
		show_value = {}
	},
	get_id_list_by_template_id = {
		{
			10101,
			10102,
			10103,
			10201,
			10202,
			10203,
			10399,
			10401,
			10402,
			10403,
			10501,
			10502,
			10503,
			10699,
			10701,
			10702,
			10703,
			10801,
			10802,
			10803,
			10999,
			11001,
			11002,
			11003,
			11101,
			11102,
			11103,
			11299
		}
	},
	get_id_list_by_level = {
		[12] = {
			11299
		},
		[11] = {
			11101,
			11102,
			11103
		},
		[10] = {
			11001,
			11002,
			11003
		},
		[9] = {
			10999
		},
		[8] = {
			10801,
			10802,
			10803
		},
		[7] = {
			10701,
			10702,
			10703
		},
		[6] = {
			10699
		},
		[5] = {
			10501,
			10502,
			10503
		},
		[4] = {
			10401,
			10402,
			10403
		},
		[3] = {
			10399
		},
		[2] = {
			10201,
			10202,
			10203
		},
		{
			10101,
			10102,
			10103
		}
	},
	get_id_list_by_show_temp = {
		[6] = {
			11103
		},
		[10] = {
			10803
		},
		[9] = {
			10503
		},
		[0] = {
			10399,
			10699,
			10999,
			11299
		},
		[7] = {
			10203
		},
		[5] = {
			10202,
			10502,
			10802,
			11102
		},
		[4] = {
			10201,
			10501,
			10801,
			11101
		},
		[3] = {
			10103,
			10403,
			10703,
			11003
		},
		[2] = {
			10102,
			10402,
			10702,
			11002
		},
		{
			10101,
			10401,
			10701,
			11001
		}
	},
	all = {
		10101,
		10102,
		10103,
		10201,
		10202,
		10203,
		10399,
		10401,
		10402,
		10403,
		10501,
		10502,
		10503,
		10699,
		10701,
		10702,
		10703,
		10801,
		10802,
		10803,
		10999,
		11001,
		11002,
		11003,
		11101,
		11102,
		11103,
		11299
	}
}
