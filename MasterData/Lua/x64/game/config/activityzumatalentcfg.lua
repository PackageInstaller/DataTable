return {
	[1001] = {
		name = "缓速领域",
		type = 1,
		desc = "\n轨道弹珠的运动速度降低20%",
		need = 600,
		activity_id = 242791,
		id = 1001,
		icon = "1007",
		pre_id_list = {
			0
		},
		effect_list = {
			1001
		}
	},
	[1002] = {
		name = "精确准星",
		type = 1,
		desc = "\n瞄准弹珠的持续时间增加100%\n\n\n\n\n<color=#FFAB00>瞄准弹珠：轨道上的弹珠有一定概率转化为瞄准弹珠，消除瞄准弹珠后，将在一定时间内获得瞄准线并提升弹珠发射后的速度。</color>",
		need = 800,
		activity_id = 242791,
		id = 1002,
		icon = "1001",
		pre_id_list = {
			1001
		},
		effect_list = {
			1002
		}
	},
	[1003] = {
		name = "色彩变转",
		type = 1,
		desc = "\n洛肯转化特殊弹珠（转色弹珠）所需的积分降低20%\n\n\n\n\n<color=#FFAB00>转色弹珠：累计获得一定数量积分后，洛肯发射的弹珠有一定概率转化为转色弹珠，转色弹珠命中后，将产生爆炸，并将爆炸范围内的所有弹珠变为转色弹珠的颜色。</color>",
		need = 1200,
		activity_id = 242791,
		id = 1003,
		icon = "1004",
		pre_id_list = {
			1002
		},
		effect_list = {
			1003
		}
	},
	[1004] = {
		name = "额外试剂",
		type = 1,
		desc = "\n实验增幅药剂的分数增加100%\n\n\n\n\n<color=#FFAB00>实验增幅药剂：每隔一段时间，将会在场地内出现实验增幅药剂，使用弹珠命中实验增幅药剂后，将获得额外积分。</color>",
		need = 1800,
		activity_id = 242791,
		id = 1004,
		icon = "1008",
		pre_id_list = {
			1003
		},
		effect_list = {
			1004
		}
	},
	[1005] = {
		name = "时空定格",
		type = 1,
		desc = "\n暂停弹珠的持续时间增加100%\n\n\n\n\n<color=#FFAB00>暂停弹珠：轨道上的弹珠有一定概率转化为暂停弹珠，消除暂停弹珠后，将使所有轨道上的弹珠停止前进一定时间。</color>",
		need = 800,
		activity_id = 242791,
		id = 1005,
		icon = "1002",
		pre_id_list = {
			1001
		},
		effect_list = {
			1005
		}
	},
	[1006] = {
		name = "引爆频发",
		type = 1,
		desc = "\n洛肯转化特殊弹珠（爆炸弹珠）所需的积分降低20%\n\n\n\n\n<color=#FFAB00>爆炸弹珠：累计获得一定数量积分后，洛肯发射的弹珠有一定概率转化为爆炸弹珠，爆炸弹珠命中后，将产生爆炸，并将爆炸范围内的所有弹珠消除。</color>",
		need = 1200,
		activity_id = 242791,
		id = 1006,
		icon = "1005",
		pre_id_list = {
			1005
		},
		effect_list = {
			1006
		}
	},
	[1007] = {
		name = "力量掠取",
		type = 1,
		desc = "\n消除积分的获取率提升10%",
		need = 1800,
		activity_id = 242791,
		id = 1007,
		icon = "1009",
		pre_id_list = {
			1006
		},
		effect_list = {
			1007
		}
	},
	[1008] = {
		name = "逆行增幅",
		type = 1,
		desc = "\n回退弹珠的回退距离增加100%\n\n\n\n\n<color=#FFAB00>回退弹珠：轨道上的弹珠有一定概率转化为回退弹珠，消除回退弹珠后，将使对应轨道上的弹珠回退一定距离。</color>",
		need = 800,
		activity_id = 242791,
		id = 1008,
		icon = "1003",
		pre_id_list = {
			1001
		},
		effect_list = {
			1008
		}
	},
	[1009] = {
		name = "万用化现",
		type = 1,
		desc = "\n洛肯转化特殊弹珠（万能弹珠）所需的积分降低20%\n\n\n\n\n<color=#FFAB00>万能弹珠：累计获得一定数量积分后，洛肯发射的弹珠有一定概率转化为万能弹珠，万能弹珠命中后，会根据命中弹珠的颜色，将对应轨道上所有同色弹珠消除。</color>",
		need = 1200,
		activity_id = 242791,
		id = 1009,
		icon = "1006",
		pre_id_list = {
			1008
		},
		effect_list = {
			1009
		}
	},
	[1010] = {
		name = "胜利渴望",
		type = 1,
		desc = "\n结算积分的获取率提升10%",
		need = 1800,
		activity_id = 242791,
		id = 1010,
		icon = "1010",
		pre_id_list = {
			1009
		},
		effect_list = {
			1010
		}
	},
	[2001] = {
		name = "大！杀！四！方！",
		type = 1,
		desc = "解除无限模式中所有主动技能的使用次数限制",
		need = 10,
		activity_id = 312791,
		id = 2001,
		icon = "2001",
		pre_id_list = {
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
			2016
		},
		effect_list = {
			2501
		}
	},
	[2002] = {
		name = "乌乌机关枪！",
		type = 1,
		desc = "技能开启后，一段时间内，玩家发射的弹珠变更为速度更快的子弹，子弹命中轨道上的弹珠后，将直接消除命中弹珠。\n需要充能：<color=#FFAB00>600</color>，使用次数：<color=#FFAB00>3</color>",
		need = 0,
		activity_id = 312791,
		id = 2002,
		icon = "2002",
		pre_id_list = {
			0
		},
		effect_list = {
			21010,
			21011,
			21012,
			21013,
			21014
		}
	},
	[2003] = {
		name = "超级突突",
		type = 1,
		desc = "增加技能期间子弹速度",
		need = 5,
		activity_id = 312791,
		id = 2003,
		icon = "2003",
		pre_id_list = {
			2002
		},
		effect_list = {
			2102
		}
	},
	[2004] = {
		name = "加时之术",
		type = 1,
		desc = "增加单次技能持续时间",
		need = 5,
		activity_id = 312791,
		id = 2004,
		icon = "2004",
		pre_id_list = {
			2002
		},
		effect_list = {
			2104
		}
	},
	[2005] = {
		name = "神力浩浩",
		type = 1,
		desc = "降低技能<color=#FFAB00>100</color>充能消耗",
		need = 5,
		activity_id = 312791,
		id = 2005,
		icon = "2005",
		pre_id_list = {
			2002
		},
		effect_list = {
			2105
		}
	},
	[2006] = {
		name = "意犹未尽",
		type = 1,
		desc = "单局内技能使用次数增加<color=#FFAB00>1</color>次",
		need = 5,
		activity_id = 312791,
		id = 2006,
		icon = "2006",
		pre_id_list = {
			2002
		},
		effect_list = {
			2103
		}
	},
	[2007] = {
		name = "天通裂地斩！",
		type = 1,
		desc = "技能开启后，将直接清除屏幕内轨道上的所有弹珠。\n需要充能：<color=#FFAB00>2000</color>，使用次数：<color=#FFAB00>1</color>",
		need = 5,
		activity_id = 312791,
		id = 2007,
		icon = "2007",
		pre_id_list = {
			0
		},
		effect_list = {
			22010,
			22011,
			22012
		}
	},
	[2008] = {
		name = "神力浩浩",
		type = 1,
		desc = "降低技能<color=#FFAB00>300</color>充能消耗",
		need = 5,
		activity_id = 312791,
		id = 2008,
		icon = "2008",
		pre_id_list = {
			2007
		},
		effect_list = {
			2202
		}
	},
	[2009] = {
		name = "意犹未尽",
		type = 1,
		desc = "单局内技能使用次数增加<color=#FFAB00>1</color>次",
		need = 5,
		activity_id = 312791,
		id = 2009,
		icon = "2009",
		pre_id_list = {
			2007
		},
		effect_list = {
			2203
		}
	},
	[2010] = {
		name = "来点甜头",
		type = 1,
		desc = "技能释放后，每消除1个小球返还<color=#FFAB00>30</color>充能",
		need = 5,
		activity_id = 312791,
		id = 2010,
		icon = "2010",
		pre_id_list = {
			2007
		},
		effect_list = {
			2204
		}
	},
	[2011] = {
		name = "还没尽兴",
		type = 1,
		desc = "单局内技能使用次数增加<color=#FFAB00>1</color>次",
		need = 5,
		activity_id = 312791,
		id = 2011,
		icon = "2011",
		pre_id_list = {
			2007
		},
		effect_list = {
			2205
		}
	},
	[2012] = {
		name = "虚空凝滞波！",
		type = 1,
		desc = "技能开启后，持续一定时间，持续时间内，所有弹珠停止前进。\n需要充能：<color=#FFAB00>1000</color>，使用次数：<color=#FFAB00>6</color>",
		need = 5,
		activity_id = 312791,
		id = 2012,
		icon = "2012",
		pre_id_list = {
			0
		},
		effect_list = {
			23010,
			23011,
			23012,
			23013
		}
	},
	[2013] = {
		name = "热力倍增",
		type = 1,
		desc = "技能持续时间内，消除小球会获得额外分数",
		need = 5,
		activity_id = 312791,
		id = 2013,
		icon = "2013",
		pre_id_list = {
			2012
		},
		effect_list = {
			2302
		}
	},
	[2014] = {
		name = "神力浩浩",
		type = 1,
		desc = "降低技能<color=#FFAB00>200</color>充能消耗",
		need = 5,
		activity_id = 312791,
		id = 2014,
		icon = "2014",
		pre_id_list = {
			2012
		},
		effect_list = {
			2303
		}
	},
	[2015] = {
		name = "加时之术",
		type = 1,
		desc = "增加技能持续时间",
		need = 5,
		activity_id = 312791,
		id = 2015,
		icon = "2015",
		pre_id_list = {
			2012
		},
		effect_list = {
			2304
		}
	},
	[2016] = {
		name = "意犹未尽",
		type = 1,
		desc = "单局内技能使用次数增加<color=#FFAB00>1</color>次",
		need = 5,
		activity_id = 312791,
		id = 2016,
		icon = "2016",
		pre_id_list = {
			2012
		},
		effect_list = {
			2305
		}
	},
	[3000] = {
		name = "无尽基础(界面上不显示，传无尽的基础参数)",
		type = 2,
		desc = "",
		need = 0,
		activity_id = 312791,
		id = 3000,
		icon = "",
		pre_id_list = {
			0
		},
		effect_list = {
			25080,
			2509
		}
	},
	[3001] = {
		name = "随机强化",
		type = 2,
		desc = "新增地图强化效果，每次开始后将从所有地图强化效果中随机抽取一个激活。\n其一：<color=#FFAB00>炮台上特殊小球不再出现转色球和万能球，爆炸球的爆炸范围增加</color>\n其二：<color=#FFAB00>炮台上特殊小球不再出现爆炸球和万能球，转色球的生效范围增加</color>\n其三：<color=#FFAB00>轨道上特殊小球不再出现瞄准球和回退球，暂停球的暂停时间增加</color>\n其四：<color=#FFAB00>轨道上特殊小球不再出现瞄准球和暂停球，回退球的回退距离增加</color>",
		need = 5000,
		activity_id = 312791,
		id = 3001,
		icon = "",
		pre_id_list = {
			3000
		},
		effect_list = {
			2503
		}
	},
	[3002] = {
		name = "初始充能",
		type = 2,
		desc = "游戏开始后，获得3次主动技能充能",
		need = 15000,
		activity_id = 312791,
		id = 3002,
		icon = "",
		pre_id_list = {
			3001
		},
		effect_list = {
			2502
		}
	},
	[3003] = {
		name = "强化技能",
		type = 2,
		desc = "主动技能获得强化：\n乌乌机关枪！：<color=#FFAB00>子弹变更为小型爆炸球，命中后将触发小范围爆炸效果</color>\n天通裂地斩！：<color=#FFAB00>主动使用后将在延时5s后重复释放1次</color>\n虚空凝滞波！：<color=#FFAB00>技能持续时间内，同时获得瞄准效果</color>",
		need = 30000,
		activity_id = 312791,
		id = 3003,
		icon = "",
		pre_id_list = {
			3002
		},
		effect_list = {
			2106,
			2206,
			2306
		}
	},
	[3004] = {
		name = "解锁新地图",
		type = 2,
		desc = "无限模式地图库中新增地图",
		need = 50000,
		activity_id = 312791,
		id = 3004,
		icon = "",
		pre_id_list = {
			3003
		},
		effect_list = {
			25081
		}
	},
	[3005] = {
		name = "强化：其一",
		type = 3,
		desc = "<color=#FFAB00>炮台上特殊小球不再出现转色球和万能球，爆炸球的爆炸范围增加</color>",
		need = 0,
		activity_id = 312791,
		id = 3005,
		icon = "",
		pre_id_list = {
			0
		},
		effect_list = {
			2504
		}
	},
	[3006] = {
		name = "强化：其二",
		type = 3,
		desc = "<color=#FFAB00>炮台上特殊小球不再出现爆炸球和万能球，转色球的生效范围增加</color>",
		need = 0,
		activity_id = 312791,
		id = 3006,
		icon = "",
		pre_id_list = {
			0
		},
		effect_list = {
			2505
		}
	},
	[3007] = {
		name = "强化：其三",
		type = 3,
		desc = "<color=#FFAB00>轨道上特殊小球不再出现瞄准球和回退球，暂停球的暂停时间增加</color>",
		need = 0,
		activity_id = 312791,
		id = 3007,
		icon = "",
		pre_id_list = {
			0
		},
		effect_list = {
			2506
		}
	},
	[3008] = {
		name = "强化：其四",
		type = 3,
		desc = "<color=#FFAB00>轨道上特殊小球不再出现瞄准球和暂停球，回退球的回退距离增加</color>",
		need = 0,
		activity_id = 312791,
		id = 3008,
		icon = "",
		pre_id_list = {
			0
		},
		effect_list = {
			2507
		}
	},
	get_id_list_by_activity_id = {
		[312791] = {
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
			3000,
			3001,
			3002,
			3003,
			3004,
			3005,
			3006,
			3007,
			3008
		},
		[242791] = {
			1001,
			1002,
			1003,
			1004,
			1005,
			1006,
			1007,
			1008,
			1009,
			1010
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
		3000,
		3001,
		3002,
		3003,
		3004,
		3005,
		3006,
		3007,
		3008
	}
}
