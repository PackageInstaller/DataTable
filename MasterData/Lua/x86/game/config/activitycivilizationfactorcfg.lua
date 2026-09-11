return {
	[1001] = {
		description = "使用技能「固有物资」的消耗-1",
		name = "固有物资",
		effect_type = 1,
		id = 1001,
		icon = "",
		gain_type = 3,
		associated_illustrations = 0,
		effect = {
			{
				1001
			},
			-1
		}
	},
	[1002] = {
		description = "当物资为0时，允许多操作3个回合",
		name = "低耗",
		effect_type = 2,
		id = 1002,
		icon = "combinegame_hero_skill_1",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			3
		}
	},
	[1003] = {
		description = "获取物资时，有30%的几率额外获取1个",
		name = "持续",
		effect_type = 3,
		id = 1003,
		icon = "combinegame_hero_skill_2",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			30,
			1
		}
	},
	[1004] = {
		description = "亚莉莎接下来3次使用技能不消耗人力",
		name = "轻量化",
		effect_type = 4,
		id = 1004,
		icon = "combinegame_hero_skill_3",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			3
		}
	},
	[1005] = {
		description = "获得等于现有人力数量的物资",
		name = "置换",
		effect_type = 5,
		id = 1005,
		icon = "combinegame_hero_skill_4",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			3,
			1
		}
	},
	[1006] = {
		description = "亚莉莎接下来6次使用技能不消耗人力",
		name = "强效化",
		effect_type = 4,
		id = 1006,
		icon = "combinegame_hero_skill_5",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			6
		}
	},
	[1007] = {
		description = "每拥有1座基站，获得20处理进程",
		name = "后援助力",
		effect_type = 6,
		id = 1007,
		icon = "combinegame_hero_skill_6",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			3,
			20
		}
	},
	[2001] = {
		description = "使用技能「初级交涉」的消耗-1",
		name = "初级交涉",
		effect_type = 1,
		id = 2001,
		icon = "",
		gain_type = 3,
		associated_illustrations = 0,
		effect = {
			{
				1002
			},
			-1
		}
	},
	[2002] = {
		description = "所有技能消耗-1",
		name = "趁势追击",
		effect_type = 15,
		id = 2002,
		icon = "combinegame_hero_skill_7",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			-1
		}
	},
	[2003] = {
		description = "使用技能「运输线路」与「空轨专线」将不再消耗人力",
		name = "运筹",
		effect_type = 8,
		id = 2003,
		icon = "combinegame_hero_skill_8",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			1003,
			1010
		}
	},
	[2004] = {
		description = "使用技能「运输线路」与「空轨专线」时，移动距离+1",
		name = "自我控制",
		effect_type = 9,
		id = 2004,
		icon = "combinegame_hero_skill_9",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			1
		}
	},
	[2005] = {
		description = "获得等于现有物资数量的人力",
		name = "服务之心",
		effect_type = 5,
		id = 2005,
		icon = "combinegame_hero_skill_10",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			1,
			3
		}
	},
	[2006] = {
		description = "解除「封锁区」，会额外多解除1个随机的「封锁区」",
		name = "枪弹研究",
		effect_type = 10,
		id = 2006,
		icon = "combinegame_hero_skill_11",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			1
		}
	},
	[2007] = {
		description = "雪儿接下来6次使用技能不消耗人力",
		name = "训练所赐",
		effect_type = 4,
		id = 2007,
		icon = "combinegame_hero_skill_12",
		gain_type = 1,
		associated_illustrations = 0,
		effect = {
			6
		}
	},
	[3001] = {
		description = "解锁技能「固有物资」\n\n<color=#F0C48F>固有物资：指定地点投放1级物资</color>",
		name = "固有物资",
		effect_type = 11,
		id = 3001,
		icon = "combinegame_factor_1",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1001
		}
	},
	[3002] = {
		description = "解锁技能「初级交涉」\n\n<color=#F0C48F>初级交涉：解除「交涉僵持」并获得2物资</color>",
		name = "初级交涉",
		effect_type = 11,
		id = 3002,
		icon = "combinegame_factor_2",
		gain_type = 2,
		associated_illustrations = 5,
		effect = {
			1002
		}
	},
	[3003] = {
		description = "解锁技能「运输线路」\n\n<color=#F0C48F>运输线路：指定一处单元格可移动4格</color>",
		name = "运输线路",
		effect_type = 11,
		id = 3003,
		icon = "combinegame_factor_5",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1003
		}
	},
	[3004] = {
		description = "解锁3级人力",
		name = "进阶调遣",
		effect_type = 12,
		id = 3004,
		icon = "combinegame_factor_6",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			3,
			3
		}
	},
	[3005] = {
		description = "解锁技能「基站」\n\n<color=#F0C48F>基站：指定空地建立「基站」，每回合提供1处理进程</color>",
		name = "基站",
		effect_type = 11,
		id = 3005,
		icon = "combinegame_factor_7",
		gain_type = 2,
		associated_illustrations = 4,
		effect = {
			1004
		}
	},
	[3006] = {
		description = "解锁技能「见机行事」\n\n<color=#F0C48F>见机行事：指定1级单元格提升至2级</color>",
		name = "见机行事",
		effect_type = 11,
		id = 3006,
		icon = "combinegame_factor_8",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1005
		}
	},
	[3007] = {
		description = "解锁技能「高效作战」\n\n<color=#F0C48F>高效作战：「视骸」持续时间缩短6回合</color>",
		name = "高效作战",
		effect_type = 11,
		id = 3007,
		icon = "combinegame_factor_9",
		gain_type = 2,
		associated_illustrations = 6,
		effect = {
			1006
		}
	},
	[3008] = {
		description = "解锁3级物资",
		name = "物资支援",
		effect_type = 12,
		id = 3008,
		icon = "combinegame_factor_10",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1,
			3
		}
	},
	[3009] = {
		description = "解锁3级研究",
		name = "投入实验",
		effect_type = 12,
		id = 3009,
		icon = "combinegame_factor_11",
		gain_type = 2,
		associated_illustrations = 3,
		effect = {
			2,
			3
		}
	},
	[3010] = {
		description = "不再自然生成1级人力",
		name = "人力资源改良",
		effect_type = 13,
		id = 3010,
		icon = "combinegame_factor_12",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			3,
			2
		}
	},
	[3011] = {
		description = "不再自然生成1级物资",
		name = "物资仓储",
		effect_type = 13,
		id = 3011,
		icon = "combinegame_factor_13",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1,
			2
		}
	},
	[3012] = {
		description = "不再自然生成1级研究",
		name = "卓有成效",
		effect_type = 13,
		id = 3012,
		icon = "combinegame_factor_14",
		gain_type = 2,
		associated_illustrations = 3,
		effect = {
			2,
			2
		}
	},
	[3013] = {
		description = "解锁技能「临机应变」并卸下技能「见机行事」\n\n<color=#F0C48F>临机应变：指定1、2级单元格提升至3级</color>",
		name = "临机应变",
		effect_type = 14,
		id = 3013,
		icon = "combinegame_factor_15",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1007,
			1005
		}
	},
	[3014] = {
		description = "解锁技能「物资整合」\n\n<color=#F0C48F>物资整合：直接获取3*3范围内物资并消除对应单元格</color>",
		name = "物资整合",
		effect_type = 11,
		id = 3014,
		icon = "combinegame_factor_16",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1008
		}
	},
	[3015] = {
		description = "解锁技能「据理力争」并卸下技能「初级交涉」\n\n<color=#F0C48F>据理力争：解除5*5范围全部「交涉僵持」，每解除1处获得2物资</color>",
		name = "据理力争",
		effect_type = 14,
		id = 3015,
		icon = "combinegame_factor_17",
		gain_type = 2,
		associated_illustrations = 5,
		effect = {
			1009,
			1002
		}
	},
	[3016] = {
		description = "所有技能消耗-3",
		name = "战术调整",
		effect_type = 15,
		id = 3016,
		icon = "combinegame_factor_18",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			-3
		}
	},
	[3017] = {
		description = "解锁4级人力",
		name = "加派调遣",
		effect_type = 12,
		id = 3017,
		icon = "combinegame_factor_19",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			3,
			4
		}
	},
	[3018] = {
		description = "解锁4级研究",
		name = "数据检验",
		effect_type = 12,
		id = 3018,
		icon = "combinegame_factor_20",
		gain_type = 2,
		associated_illustrations = 3,
		effect = {
			2,
			4
		}
	},
	[3019] = {
		description = "解锁4级物资",
		name = "物资调配",
		effect_type = 12,
		id = 3019,
		icon = "combinegame_factor_21",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1,
			4
		}
	},
	[3020] = {
		description = "解锁技能「空轨专线」并卸下技能「运输线路」\n\n<color=#F0C48F>空轨专线：指定一处单元格可移动6格</color>",
		name = "空轨专线",
		effect_type = 14,
		id = 3020,
		icon = "combinegame_factor_22",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1010,
			1003
		}
	},
	[3021] = {
		description = "不再发生「交涉僵持」，卸下「据理力争」",
		name = "通力协作",
		effect_type = 16,
		id = 3021,
		icon = "combinegame_factor_23",
		gain_type = 2,
		associated_illustrations = 5,
		effect = {}
	},
	[3022] = {
		description = "解锁技能「空投物资」并卸下技能「固有物资」\n\n<color=#F0C48F>空投物资：指定地点投放3级物资</color>",
		name = "空投物资",
		effect_type = 14,
		id = 3022,
		icon = "combinegame_factor_24",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1011,
			1001
		}
	},
	[3023] = {
		description = "不再自然生成2级人力",
		name = "人力资源优化",
		effect_type = 13,
		id = 3023,
		icon = "combinegame_factor_25",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			3,
			3
		}
	},
	[3024] = {
		description = "解锁技能「快速转移」\n\n<color=#F0C48F>快速转移：指定一处单元格可移动到任意位置</color>",
		name = "快速转移",
		effect_type = 11,
		id = 3024,
		icon = "combinegame_factor_26",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1012
		}
	},
	[3025] = {
		description = "不再自然生成2级研究",
		name = "效果显著",
		effect_type = 13,
		id = 3025,
		icon = "combinegame_factor_27",
		gain_type = 2,
		associated_illustrations = 3,
		effect = {
			2,
			3
		}
	},
	[3026] = {
		description = "解锁技能「运筹决策」并卸下技能「临机应变」\n\n<color=#F0C48F>运筹决策：指定单元格提升至4级</color>",
		name = "运筹决策",
		effect_type = 14,
		id = 3026,
		icon = "combinegame_factor_28",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1013,
			1007
		}
	},
	[3027] = {
		description = "解锁技能「战术部署」\n\n<color=#F0C48F>战术部署：直接获取3*3范围内人力并消除对应单元格</color>",
		name = "战术部署",
		effect_type = 11,
		id = 3027,
		icon = "combinegame_factor_29",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			1014
		}
	},
	[3029] = {
		description = "所有可移动单元格移动范围+1",
		name = "专属通道I",
		effect_type = 17,
		id = 3029,
		icon = "combinegame_factor_31",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1
		}
	},
	[3030] = {
		description = "不再自然生成2级物资",
		name = "物资集纳",
		effect_type = 13,
		id = 3030,
		icon = "combinegame_factor_32",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1,
			3
		}
	},
	[3032] = {
		description = "解锁技能「去危就安」\n\n<color=#F0C48F>去危就安：解锁一片「封锁区」</color>",
		name = "去危就安",
		effect_type = 11,
		id = 3032,
		icon = "combinegame_factor_34",
		gain_type = 2,
		associated_illustrations = 7,
		effect = {
			1015
		}
	},
	[3034] = {
		description = "解锁技能「锚点封锁」\n\n<color=#F0C48F>锚点封锁：指定空地接入封锁锚点并获得50处理进程</color>",
		name = "锚点封锁",
		effect_type = 11,
		id = 3034,
		icon = "combinegame_factor_36",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1016
		}
	},
	[3035] = {
		description = "所有可移动单元格移动范围额外+1",
		name = "专属通道II",
		effect_type = 17,
		id = 3035,
		icon = "combinegame_factor_31",
		gain_type = 2,
		associated_illustrations = 0,
		effect = {
			1
		}
	},
	[3036] = {
		description = "解锁技能「尘埃落定」\n\n<color=#F0C48F>尘埃落定：消灭「天父」，获得游戏胜利</color>",
		name = "尘埃落定",
		effect_type = 11,
		id = 3036,
		icon = "combinegame_factor_38",
		gain_type = 2,
		associated_illustrations = 8,
		effect = {
			1017
		}
	},
	[4001] = {
		description = "解锁2级物资",
		name = "基础物资",
		effect_type = 12,
		id = 4001,
		icon = "combinegame_factor_10",
		gain_type = 2,
		associated_illustrations = 1,
		effect = {
			1,
			2
		}
	},
	[4002] = {
		description = "解锁2级人力",
		name = "基础调遣",
		effect_type = 12,
		id = 4002,
		icon = "combinegame_factor_3",
		gain_type = 2,
		associated_illustrations = 2,
		effect = {
			3,
			2
		}
	},
	[4003] = {
		description = "解锁2级研究",
		name = "专题立项",
		effect_type = 12,
		id = 4003,
		icon = "combinegame_factor_4",
		gain_type = 2,
		associated_illustrations = 3,
		effect = {
			2,
			2
		}
	},
	get_id_list_by_effect_type = {
		[17] = {
			3029,
			3035
		},
		[16] = {
			3021
		},
		[14] = {
			3013,
			3015,
			3020,
			3022,
			3026
		},
		[13] = {
			3010,
			3011,
			3012,
			3023,
			3025,
			3030
		},
		[12] = {
			3004,
			3008,
			3009,
			3017,
			3018,
			3019,
			4001,
			4002,
			4003
		},
		[11] = {
			3001,
			3002,
			3003,
			3005,
			3006,
			3007,
			3014,
			3024,
			3027,
			3032,
			3034,
			3036
		},
		[10] = {
			2006
		},
		[9] = {
			2004
		},
		[8] = {
			2003
		},
		[15] = {
			2002,
			3016
		},
		[6] = {
			1007
		},
		[5] = {
			1005,
			2005
		},
		[4] = {
			1004,
			1006,
			2007
		},
		[3] = {
			1003
		},
		[2] = {
			1002
		},
		{
			1001,
			2001
		}
	},
	get_id_list_by_gain_type = {
		[2] = {
			3001,
			3002,
			3003,
			3004,
			3005,
			3006,
			3007,
			3008,
			3009,
			3010,
			3011,
			3012,
			3013,
			3014,
			3015,
			3016,
			3017,
			3018,
			3019,
			3020,
			3021,
			3022,
			3023,
			3024,
			3025,
			3026,
			3027,
			3029,
			3030,
			3032,
			3034,
			3035,
			3036,
			4001,
			4002,
			4003
		},
		{
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			2002,
			2003,
			2004,
			2005,
			2006,
			2007
		},
		[3] = {
			1001,
			2001
		}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1007,
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		3001,
		3002,
		3003,
		3004,
		3005,
		3006,
		3007,
		3008,
		3009,
		3010,
		3011,
		3012,
		3013,
		3014,
		3015,
		3016,
		3017,
		3018,
		3019,
		3020,
		3021,
		3022,
		3023,
		3024,
		3025,
		3026,
		3027,
		3029,
		3030,
		3032,
		3034,
		3035,
		3036,
		4001,
		4002,
		4003
	}
}
