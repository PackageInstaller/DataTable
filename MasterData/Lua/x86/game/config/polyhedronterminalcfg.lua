return {
	[1001] = {
		cost = 3,
		name = "强化锻炼",
		hinge = 0,
		need_level = 1,
		desc = "修正者最大生命值上限提高<color=#FF9500>5%</color>。",
		classify = 1,
		id = 1001,
		icon = "terminal_26",
		effect_id = 1001,
		pre_id_list = {
			0,
			1002,
			1003
		}
	},
	[1002] = {
		cost = 3,
		name = "全力以赴",
		hinge = 0,
		need_level = 1,
		desc = "修正者攻击力提高<color=#FF9500>3%</color>。",
		classify = 1,
		id = 1002,
		icon = "terminal_24",
		effect_id = 1002,
		pre_id_list = {
			1001,
			1004,
			1018
		}
	},
	[1003] = {
		cost = 3,
		name = "防御特训",
		hinge = 0,
		need_level = 1,
		desc = "修正者防御力提高<color=#FF9500>5%</color>。",
		classify = 1,
		id = 1003,
		icon = "terminal_25",
		effect_id = 1003,
		pre_id_list = {
			1001,
			1007,
			1018,
			9002
		}
	},
	[1004] = {
		cost = 3,
		name = "极限修正",
		hinge = 0,
		need_level = 1,
		desc = "修正者修正系数提高<color=#FF9500>30%</color>。",
		classify = 1,
		id = 1004,
		icon = "terminal_10",
		effect_id = 1004,
		pre_id_list = {
			1002,
			1005,
			1008,
			1101,
			9001
		}
	},
	[1005] = {
		cost = 3,
		name = "防御特训",
		hinge = 0,
		need_level = 1,
		desc = "修正者防御力提高<color=#FF9500>5%</color>。",
		classify = 1,
		id = 1005,
		icon = "terminal_25",
		effect_id = 1005,
		pre_id_list = {
			1004,
			1101,
			1006
		}
	},
	[1006] = {
		cost = 3,
		name = "迅捷动量",
		hinge = 0,
		need_level = 1,
		desc = "修正者闪避能量恢复速度提高<color=#FF9500>10%</color>。",
		classify = 1,
		id = 1006,
		icon = "terminal_35",
		effect_id = 1006,
		pre_id_list = {
			1005,
			1010,
			1018
		}
	},
	[1007] = {
		cost = 3,
		name = "生存本能",
		hinge = 0,
		need_level = 1,
		desc = "每存在一个敌人，修正者防御力提高<color=#FF9500>2%</color>（上限20%）。",
		classify = 1,
		id = 1007,
		icon = "terminal_25",
		effect_id = 1007,
		pre_id_list = {
			1003,
			1102,
			1010
		}
	},
	[1008] = {
		cost = 3,
		name = "斗争本能",
		hinge = 0,
		need_level = 1,
		desc = "每存在一个敌人，修正者攻击力提高<color=#FF9500>1%</color>（上限10%）。",
		classify = 1,
		id = 1008,
		icon = "terminal_24",
		effect_id = 1008,
		pre_id_list = {
			1004,
			1009,
			1015
		}
	},
	[1009] = {
		cost = 3,
		name = "战斗专注",
		hinge = 0,
		need_level = 1,
		desc = "修正者会心率提高<color=#FF9500>5%</color>。",
		classify = 1,
		id = 1009,
		icon = "terminal_24",
		effect_id = 1009,
		pre_id_list = {
			1008,
			1016
		}
	},
	[1010] = {
		cost = 3,
		name = "强化锻炼",
		hinge = 0,
		need_level = 1,
		desc = "修正者最大生命值上限提高<color=#FF9500>5%</color>。",
		classify = 1,
		id = 1010,
		icon = "terminal_26",
		effect_id = 1010,
		pre_id_list = {
			1006,
			1007,
			1013,
			1015,
			1101
		}
	},
	[1011] = {
		cost = 3,
		name = "对敌策略",
		hinge = 0,
		need_level = 1,
		desc = "修正者攻击满生命值的敌人时，该次伤害提高<color=#FF9500>40%</color>。",
		classify = 1,
		id = 1011,
		icon = "terminal_24",
		effect_id = 1011,
		pre_id_list = {
			1012,
			1013,
			1102
		}
	},
	[1012] = {
		cost = 3,
		name = "瞬时满载",
		hinge = 0,
		need_level = 1,
		desc = "处于修正模式时，修正者造成的伤害提高<color=#FF9500>15%</color>。",
		classify = 1,
		id = 1012,
		icon = "terminal_10",
		effect_id = 1012,
		pre_id_list = {
			1011,
			1017
		}
	},
	[1013] = {
		cost = 3,
		name = "全力以赴",
		hinge = 0,
		need_level = 1,
		desc = "修正者攻击力提高<color=#FF9500>3%</color>。",
		classify = 1,
		id = 1013,
		icon = "terminal_24",
		effect_id = 1013,
		pre_id_list = {
			1010,
			1011,
			1017
		}
	},
	[1014] = {
		cost = 3,
		name = "潜能爆发",
		hinge = 0,
		need_level = 1,
		desc = "修正者会心伤害提高<color=#FF9500>20%</color>。",
		classify = 1,
		id = 1014,
		icon = "terminal_24",
		effect_id = 1014,
		pre_id_list = {
			1015,
			1017,
			1016,
			1103
		}
	},
	[1015] = {
		cost = 3,
		name = "背向奇袭",
		hinge = 0,
		need_level = 1,
		desc = "从背面攻击怪物时伤害提高<color=#FF9500>10%</color>。",
		classify = 1,
		id = 1015,
		icon = "terminal_24",
		effect_id = 1015,
		pre_id_list = {
			1008,
			1010,
			1014
		}
	},
	[1016] = {
		cost = 3,
		name = "强袭决策",
		hinge = 0,
		need_level = 1,
		desc = "当前生命值大于<color=#FF9500>80%</color>时，伤害提高<color=#FF9500>10%</color>。",
		classify = 1,
		id = 1016,
		icon = "terminal_24",
		effect_id = 1016,
		pre_id_list = {
			1009,
			1014,
			1103
		}
	},
	[1017] = {
		cost = 3,
		name = "守势决策",
		hinge = 0,
		need_level = 1,
		desc = "当前生命值小于<color=#FF9500>40%</color>时，受到的伤害降低<color=#FF9500>10%</color>。",
		classify = 1,
		id = 1017,
		icon = "terminal_25",
		effect_id = 1017,
		pre_id_list = {
			1012,
			1013,
			1014,
			1103
		}
	},
	[1018] = {
		cost = 3,
		name = "灵巧身法",
		hinge = 0,
		need_level = 1,
		desc = "修正者闪避能量上限提高<color=#FF9500>40%</color>。",
		classify = 1,
		id = 1018,
		icon = "terminal_35",
		effect_id = 1018,
		pre_id_list = {
			1002,
			1006,
			1003
		}
	},
	[1101] = {
		cost = 9,
		name = "后备防线",
		hinge = 1,
		need_level = 1,
		desc = "每次开局时，额外获得<color=#FF9500>1</color>点复活点数。",
		classify = 1,
		id = 1101,
		icon = "terminal_101",
		effect_id = 1101,
		pre_id_list = {
			1004,
			1005,
			1010
		}
	},
	[1102] = {
		cost = 9,
		name = "体质强化",
		hinge = 1,
		need_level = 1,
		desc = "复活后保留的血量提升<color=#FF9500>30%</color>。",
		classify = 1,
		id = 1102,
		icon = "terminal_102",
		effect_id = 1102,
		pre_id_list = {
			1007,
			1011
		}
	},
	[1103] = {
		cost = 9,
		name = "战局分析",
		hinge = 1,
		need_level = 1,
		desc = "修正者每击杀一个敌人，该修正者攻击提高<color=#FF9500>1%</color>（上限10%）。",
		classify = 1,
		id = 1103,
		icon = "terminal_103",
		effect_id = 1103,
		pre_id_list = {
			1014,
			1016,
			1017
		}
	},
	[9001] = {
		cost = 9,
		name = "脉络节点",
		hinge = 1,
		need_level = 1,
		desc = "修正者每拥有一个记忆珍宝，最大生命值上限提高<color=#FF9500>0.4%</color>，攻击力提高<color=#FF9500>0.4%</color>，防御力提高<color=#FF9500>0.4%</color>。",
		classify = 1,
		id = 9001,
		icon = "terminal_30",
		effect_id = 9001,
		pre_id_list = {
			1004,
			3010
		}
	},
	[2001] = {
		cost = 3,
		name = "额外储蓄",
		hinge = 0,
		need_level = 1,
		desc = "每次开局时，额外获得<color=#FF9500>100</color>枚喵喵宝藏币。",
		classify = 2,
		id = 2001,
		icon = "terminal_29",
		effect_id = 2001,
		pre_id_list = {
			0,
			2002,
			2003,
			2004
		}
	},
	[2002] = {
		cost = 3,
		name = "不确定性",
		hinge = 0,
		need_level = 1,
		desc = "时空裂隙的出现概率提升<color=#FF9500>10%</color>。",
		classify = 2,
		id = 2002,
		icon = "terminal_28",
		effect_id = 2002,
		pre_id_list = {
			2001,
			2005
		}
	},
	[2003] = {
		cost = 3,
		name = "医疗保障",
		hinge = 0,
		need_level = 1,
		desc = "每关结束时，修正者恢复自身<color=#FF9500>3%</color>的血量。",
		classify = 2,
		id = 2003,
		icon = "terminal_34",
		effect_id = 2003,
		pre_id_list = {
			2001,
			2006
		}
	},
	[2004] = {
		cost = 3,
		name = "有舍有得",
		hinge = 0,
		need_level = 1,
		desc = "选择放弃选项时所获得的喵喵宝藏币数量增加<color=#FF9500>80</color>枚。",
		classify = 2,
		id = 2004,
		icon = "terminal_28",
		effect_id = 2004,
		pre_id_list = {
			2001,
			2009,
			2016,
			9002
		}
	},
	[2005] = {
		cost = 3,
		name = "持筹握算",
		hinge = 0,
		need_level = 1,
		desc = "每关结束时，额外获得<color=#FF9500>20</color>枚喵喵宝藏币。",
		classify = 2,
		id = 2005,
		icon = "terminal_29",
		effect_id = 2005,
		pre_id_list = {
			2002,
			9003,
			2007,
			2006
		}
	},
	[2006] = {
		cost = 3,
		name = "物流传动",
		hinge = 0,
		need_level = 1,
		desc = "多维商店刷新次数提升<color=#FF9500>3</color>次。",
		classify = 2,
		id = 2006,
		icon = "terminal_29",
		effect_id = 2006,
		pre_id_list = {
			2003,
			2005,
			2101
		}
	},
	[2007] = {
		cost = 3,
		name = "未知可能",
		hinge = 0,
		need_level = 1,
		desc = "「兔兔打字机」的属性提升效果提高至<color=#FF9500>10%</color>。",
		classify = 2,
		id = 2007,
		icon = "terminal_28",
		effect_id = 2007,
		pre_id_list = {
			2005,
			2008
		}
	},
	[2008] = {
		cost = 3,
		name = "迅捷支援",
		hinge = 0,
		need_level = 1,
		desc = "队友复活所需的关卡减少<color=#FF9500>1</color>个。",
		classify = 2,
		id = 2008,
		icon = "terminal_34",
		effect_id = 2008,
		pre_id_list = {
			2007,
			2012,
			2101
		}
	},
	[2009] = {
		cost = 3,
		name = "会员折扣",
		hinge = 0,
		need_level = 1,
		desc = "多维商店第一个商品降价<color=#FF9500>50%</color>。",
		classify = 2,
		id = 2009,
		icon = "terminal_29",
		effect_id = 2009,
		pre_id_list = {
			2004,
			2010
		}
	},
	[2010] = {
		cost = 3,
		name = "商业口才",
		hinge = 0,
		need_level = 1,
		desc = "多维商店额外获得<color=#FF9500>1</color>次免费刷新机会。",
		classify = 2,
		id = 2010,
		icon = "terminal_29",
		effect_id = 2010,
		pre_id_list = {
			2009,
			2101,
			2011
		}
	},
	[2011] = {
		cost = 3,
		name = "医疗保障",
		hinge = 0,
		need_level = 1,
		desc = "每关结束时，修正者恢复自身<color=#FF9500>3%</color>的血量。",
		classify = 2,
		id = 2011,
		icon = "terminal_34",
		effect_id = 2011,
		pre_id_list = {
			2010,
			2012,
			2103,
			2013
		}
	},
	[2012] = {
		cost = 3,
		name = "应敌战略",
		hinge = 0,
		need_level = 1,
		desc = "免疫BOSS造成的首次伤害。",
		classify = 2,
		id = 2012,
		icon = "terminal_28",
		effect_id = 2012,
		pre_id_list = {
			2008,
			2011,
			2103
		}
	},
	[2013] = {
		cost = 3,
		name = "迅捷支援",
		hinge = 0,
		need_level = 1,
		desc = "队友复活所需的关卡减少<color=#FF9500>1</color>个。",
		classify = 2,
		id = 2013,
		icon = "terminal_34",
		effect_id = 2013,
		pre_id_list = {
			2017,
			2102,
			2015,
			2011,
			2014
		}
	},
	[2014] = {
		cost = 3,
		name = "高机动性",
		hinge = 0,
		need_level = 1,
		desc = "修正者移动速度提高<color=#FF9500>15%</color>。",
		classify = 2,
		id = 2014,
		icon = "terminal_27",
		effect_id = 2014,
		pre_id_list = {
			2013,
			2103
		}
	},
	[2015] = {
		cost = 3,
		name = "通商技巧",
		hinge = 0,
		need_level = 1,
		desc = "金币关卡额外获得<color=#FF9500>100</color>枚喵喵宝藏币。",
		classify = 2,
		id = 2015,
		icon = "terminal_29",
		effect_id = 2015,
		pre_id_list = {
			2016,
			2013
		}
	},
	[2016] = {
		cost = 3,
		name = "深层合作",
		hinge = 0,
		need_level = 1,
		desc = "多维商店的商品选项增加<color=#FF9500>1</color>个。",
		classify = 2,
		id = 2016,
		icon = "terminal_29",
		effect_id = 2016,
		pre_id_list = {
			2004,
			2015,
			2102,
			2017
		}
	},
	[2017] = {
		cost = 3,
		name = "持筹握算",
		hinge = 0,
		need_level = 1,
		desc = "每关结束时，额外获得<color=#FF9500>10</color>枚喵喵宝藏币。",
		classify = 2,
		id = 2017,
		icon = "terminal_29",
		effect_id = 2017,
		pre_id_list = {
			2016,
			2013
		}
	},
	[2101] = {
		cost = 9,
		name = "生息续存",
		hinge = 1,
		need_level = 1,
		desc = "多维商店提供一次免费的回血机会。",
		classify = 2,
		id = 2101,
		icon = "terminal_104",
		effect_id = 2101,
		pre_id_list = {
			2006,
			2008,
			2010
		}
	},
	[2102] = {
		cost = 9,
		name = "战后休整",
		hinge = 1,
		need_level = 1,
		desc = "战胜BOSS后，额外补充<color=#FF9500>1</color>点复活点数。",
		classify = 2,
		id = 2102,
		icon = "terminal_105",
		effect_id = 2102,
		pre_id_list = {
			2016,
			2013
		}
	},
	[2103] = {
		cost = 9,
		name = "额外收获",
		hinge = 1,
		need_level = 1,
		desc = "战胜BOSS后，将携带的喵喵宝藏币增值<color=#FF9500>10%</color>。",
		classify = 2,
		id = 2103,
		icon = "terminal_106",
		effect_id = 2103,
		pre_id_list = {
			2011,
			2012,
			2014
		}
	},
	[9002] = {
		cost = 9,
		name = "脉络节点",
		hinge = 1,
		need_level = 1,
		desc = "每关结束时，随机提升修正者一项属性。",
		classify = 2,
		id = 9002,
		icon = "terminal_31",
		effect_id = 9002,
		pre_id_list = {
			1003,
			2004
		}
	},
	[3001] = {
		cost = 3,
		name = "资源调度",
		hinge = 0,
		need_level = 1,
		desc = "信标可携带数+1。",
		classify = 3,
		id = 3001,
		icon = "terminal_36",
		effect_id = 3001,
		pre_id_list = {
			0,
			3002,
			3009
		}
	},
	[3002] = {
		cost = 3,
		name = "战场清扫",
		hinge = 0,
		need_level = 1,
		desc = "战胜BOSS后，随机提升<color=#FF9500>1</color>个记忆珍宝的等级。",
		classify = 3,
		id = 3002,
		icon = "terminal_33",
		effect_id = 3002,
		pre_id_list = {
			3001,
			3003
		}
	},
	[3003] = {
		cost = 3,
		name = "命运牵引",
		hinge = 0,
		need_level = 1,
		desc = "每局游戏中，记忆珍宝奖励可额外重置<color=#FF9500>1</color>次。",
		classify = 3,
		id = 3003,
		icon = "terminal_37",
		effect_id = 3003,
		pre_id_list = {
			3002,
			3102,
			3004
		}
	},
	[3004] = {
		cost = 3,
		name = "好运常临",
		hinge = 0,
		need_level = 1,
		desc = "获得记忆珍宝时，有<color=#FF9500>10%</color>概率提升1个等级。",
		classify = 3,
		id = 3004,
		icon = "terminal_33",
		effect_id = 3004,
		pre_id_list = {
			3003,
			3005,
			9003
		}
	},
	[3005] = {
		cost = 3,
		name = "资源调度",
		hinge = 0,
		need_level = 1,
		desc = "信标可携带数+1。",
		classify = 3,
		id = 3005,
		icon = "terminal_36",
		effect_id = 3005,
		pre_id_list = {
			3006,
			3004,
			3102
		}
	},
	[3006] = {
		cost = 3,
		name = "命运牵引",
		hinge = 0,
		need_level = 1,
		desc = "每局游戏中，记忆珍宝奖励可额外重置<color=#FF9500>1</color>次。",
		classify = 3,
		id = 3006,
		icon = "terminal_37",
		effect_id = 3006,
		pre_id_list = {
			3103,
			3007,
			3005
		}
	},
	[3007] = {
		cost = 3,
		name = "不确定性",
		hinge = 0,
		need_level = 1,
		desc = "时空裂隙的出现概率提升<color=#FF9500>10%</color>。",
		classify = 3,
		id = 3007,
		icon = "terminal_33",
		effect_id = 3007,
		pre_id_list = {
			3006,
			3008
		}
	},
	[3008] = {
		cost = 3,
		name = "大鉴赏家",
		hinge = 0,
		need_level = 1,
		desc = "可升级的记忆珍宝提升<color=#FF9500>1</color>个等级上限。",
		classify = 3,
		id = 3008,
		icon = "terminal_37",
		effect_id = 3008,
		pre_id_list = {
			3007,
			3102,
			3001
		}
	},
	[3009] = {
		cost = 3,
		name = "运筹帷幄",
		hinge = 0,
		need_level = 1,
		desc = "精英关卡的出现概率提升<color=#FF9500>10%</color>。",
		classify = 3,
		id = 3009,
		icon = "terminal_33",
		effect_id = 3009,
		pre_id_list = {
			3012,
			3010,
			3001
		}
	},
	[3010] = {
		cost = 3,
		name = "好运常临",
		hinge = 0,
		need_level = 1,
		desc = "获得记忆珍宝时，有<color=#FF9500>10%</color>概率提升1个等级。",
		classify = 3,
		id = 3010,
		icon = "terminal_33",
		effect_id = 3010,
		pre_id_list = {
			3009,
			3011,
			9001
		}
	},
	[3011] = {
		cost = 3,
		name = "资源调度",
		hinge = 0,
		need_level = 1,
		desc = "信标可携带数+1。",
		classify = 3,
		id = 3011,
		icon = "terminal_36",
		effect_id = 3011,
		pre_id_list = {
			3010,
			3012,
			3101,
			3014,
			3016
		}
	},
	[3012] = {
		cost = 3,
		name = "命运牵引",
		hinge = 0,
		need_level = 1,
		desc = "每局游戏中，记忆珍宝奖励可额外重置<color=#FF9500>1</color>次。",
		classify = 3,
		id = 3012,
		icon = "terminal_37",
		effect_id = 3012,
		pre_id_list = {
			3009,
			3013,
			3101,
			3011
		}
	},
	[3013] = {
		cost = 3,
		name = "大鉴赏家",
		hinge = 0,
		need_level = 1,
		desc = "可升级的记忆珍宝提升<color=#FF9500>1</color>个等级上限。",
		classify = 3,
		id = 3013,
		icon = "terminal_37",
		effect_id = 3013,
		pre_id_list = {
			3012,
			3101,
			3014
		}
	},
	[3014] = {
		cost = 3,
		name = "运筹帷幄",
		hinge = 0,
		need_level = 1,
		desc = "精英关卡的出现概率提升<color=#FF9500>10%</color>。",
		classify = 3,
		id = 3014,
		icon = "terminal_33",
		effect_id = 3014,
		pre_id_list = {
			3015,
			3011,
			3101,
			3013
		}
	},
	[3015] = {
		cost = 3,
		name = "命运牵引",
		hinge = 0,
		need_level = 1,
		desc = "每局游戏中，记忆珍宝奖励可额外重置<color=#FF9500>1</color>次。",
		classify = 3,
		id = 3015,
		icon = "terminal_37",
		effect_id = 3015,
		pre_id_list = {
			3014,
			3103
		}
	},
	[3016] = {
		cost = 3,
		name = "命运牵引",
		hinge = 0,
		need_level = 1,
		desc = "每局游戏中，记忆珍宝奖励可额外重置<color=#FF9500>1</color>次。",
		classify = 3,
		id = 3016,
		icon = "terminal_37",
		effect_id = 3016,
		pre_id_list = {
			3011,
			3103
		}
	},
	[3101] = {
		cost = 9,
		name = "战前整备",
		hinge = 1,
		need_level = 1,
		desc = "首关的关卡奖励改为获得一个专属记忆珍宝。",
		classify = 3,
		id = 3101,
		icon = "terminal_107",
		effect_id = 3101,
		pre_id_list = {
			3011,
			3012,
			3013,
			3014
		}
	},
	[3102] = {
		cost = 9,
		name = "既定馈赠",
		hinge = 1,
		need_level = 1,
		desc = "战胜BOSS后，可额外选择<color=#FF9500>1</color>次记忆珍宝奖励。",
		classify = 3,
		id = 3102,
		icon = "terminal_108",
		effect_id = 3102,
		pre_id_list = {
			3003,
			3008,
			3005
		}
	},
	[3103] = {
		cost = 9,
		name = "开拓精神",
		hinge = 1,
		need_level = 1,
		desc = "可以在游戏中选择「万象寓于」流派的记忆珍宝。",
		classify = 3,
		id = 3103,
		icon = "terminal_109",
		effect_id = 3103,
		pre_id_list = {
			3016,
			3015,
			3006
		}
	},
	[9003] = {
		cost = 9,
		name = "脉络节点",
		hinge = 1,
		need_level = 1,
		desc = "每经过<color=#FF9500>6</color>关，随机提升一个记忆珍宝的等级。",
		classify = 3,
		id = 9003,
		icon = "terminal_32",
		effect_id = 9003,
		pre_id_list = {
			2005,
			3004
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
		1008,
		1009,
		1010,
		1011,
		1012,
		1013,
		1014,
		1015,
		1016,
		1017,
		1018,
		1101,
		1102,
		1103,
		9001,
		2001,
		2002,
		2003,
		2004,
		2005,
		2006,
		2007,
		2008,
		2009,
		2010,
		2011,
		2012,
		2013,
		2014,
		2015,
		2016,
		2017,
		2101,
		2102,
		2103,
		9002,
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
		3101,
		3102,
		3103,
		9003
	}
}
