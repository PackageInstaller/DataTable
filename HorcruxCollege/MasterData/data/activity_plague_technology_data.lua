return {
	[11] = {
		name = "破译提升",
		row = 1,
		desc1 = "[被动]所有病毒侵入力+10%",
		desc3 = "[被动]所有病毒侵入力+30%",
		column = 1,
		cost = 1,
		passive = 1,
		desc2 = "[被动]所有病毒侵入力+20%",
		id = 11,
		level = 3,
		param = {
			att = 10
		}
	},
	[12] = {
		name = "靶向进化",
		row = 2,
		prerow_level = 3,
		desc1 = "[被动]信息、交通、金融病毒对靶向节点造成效果+10%",
		column = 1,
		desc3 = "[被动]信息、交通、金融病毒对靶向节点造成效果+30%",
		cost = 1,
		passive = 1,
		desc2 = "[被动]信息、交通、金融病毒对靶向节点造成效果+20%",
		id = 12,
		level = 3,
		param = {
			breed_same = 10,
			att_same = 10
		}
	},
	[13] = {
		name = "靶向链接",
		row = 3,
		prerow_level = 3,
		column = 1,
		desc1 = "[被动]信息、交通、金融病毒在非对应节点时，侵入力降低5%，但繁殖力增加10%",
		desc3 = "[被动]信息、交通、金融病毒在非对应节点时，侵入力降低15%，但繁殖力增加30%",
		passive = 1,
		desc2 = "[被动]信息、交通、金融病毒在非对应节点时，侵入力降低10%，但繁殖力增加20%",
		cost = 2,
		id = 13,
		level = 3,
		preid = {
			{
				id = 12,
				level = 1
			}
		},
		param = {
			att_diff = -5,
			breed_diff = 10
		}
	},
	[14] = {
		name = "病毒爆发",
		row = 4,
		prerow_level = 3,
		desc1 = "[被动]节点被完全侵占时，会一次性向相连节点侵入当前节点3%的病毒",
		column = 1,
		desc3 = "[被动]节点被完全侵占时，会一次性向相连节点侵入当前节点9%的病毒",
		cost = 2,
		passive = 1,
		desc2 = "[被动]节点被完全侵占时，会一次性向相连节点侵入当前节点6%的病毒",
		id = 14,
		level = 3,
		param = {
			overflow_invade = 3
		}
	},
	[15] = {
		cost = 3,
		name = "致命",
		desc1 = "[主动]目标节点当前防御力下降10%，持续3次繁殖的时间",
		prerow_level = 3,
		desc3 = "[主动]目标节点当前防御力下降10%，持续3次繁殖的时间",
		column = 1,
		row = 5,
		desc2 = "[主动]目标节点当前防御力下降10%，持续3次繁殖的时间",
		skillid = 15,
		id = 15,
		level = 1,
		preid = {
			{
				id = 14,
				level = 1
			}
		}
	},
	[21] = {
		name = "自我复制",
		row = 1,
		desc1 = "[被动]所有病毒繁殖力+10%",
		desc3 = "[被动]所有病毒繁殖力+30%",
		column = 2,
		cost = 1,
		passive = 1,
		desc2 = "[被动]所有病毒繁殖力+20%",
		id = 21,
		level = 3,
		param = {
			breed = 10
		}
	},
	[22] = {
		name = "侵入复制",
		row = 2,
		prerow_level = 3,
		column = 2,
		desc1 = "[被动]所有病毒在侵入到相邻节点时，数量额外增加10%",
		desc3 = "[被动]所有病毒在侵入到相邻节点时，数量额外增加30%",
		passive = 1,
		desc2 = "[被动]所有病毒在侵入到相邻节点时，数量额外增加20%",
		cost = 1,
		id = 22,
		level = 3,
		preid = {
			{
				id = 21,
				level = 1
			}
		},
		param = {
			invade_breed_extra = 10
		}
	},
	[23] = {
		name = "击穿防御",
		row = 3,
		prerow_level = 3,
		column = 2,
		desc1 = "[被动]所有病毒在侵入到相邻节点时判定侵入力+15%",
		desc3 = "[被动]所有病毒在侵入到相邻节点时判定侵入力+45%",
		passive = 1,
		desc2 = "[被动]所有病毒在侵入到相邻节点时判定侵入力+30%",
		cost = 2,
		id = 23,
		level = 3,
		preid = {
			{
				id = 22,
				level = 1
			}
		},
		param = {
			invade_att = 15
		}
	},
	[24] = {
		name = "内存优化",
		row = 4,
		prerow_level = 3,
		desc1 = "[被动]所有节点可容纳病毒上限增加10%",
		column = 2,
		desc3 = "[被动]所有节点可容纳病毒上限增加30%",
		cost = 2,
		passive = 1,
		desc2 = "[被动]所有节点可容纳病毒上限增加20%",
		id = 24,
		level = 3,
		param = {
			node_cap = 10
		}
	},
	[25] = {
		cost = 3,
		name = "隐匿",
		desc1 = "[主动]目标节点病毒进入蛰伏状态3次繁殖，不会进行侵入",
		prerow_level = 3,
		desc3 = "[主动]目标节点病毒进入蛰伏状态3次繁殖，不会进行侵入",
		column = 2,
		row = 5,
		desc2 = "[主动]目标节点病毒进入蛰伏状态3次繁殖，不会进行侵入",
		skillid = 25,
		id = 25,
		level = 1,
		preid = {
			{
				id = 24,
				level = 1
			}
		}
	},
	[26] = {
		cost = 5,
		name = "混淆",
		desc3 = "[主动]立刻提升病毒代码复杂度，中断科研中心破译，持续3次病毒繁殖时间",
		desc1 = "[主动]立刻提升病毒代码复杂度，中断科研中心破译，持续3次病毒繁殖时间",
		prerow_level = 1,
		column = 2,
		row = 6,
		desc2 = "[主动]立刻提升病毒代码复杂度，中断科研中心破译，持续3次病毒繁殖时间",
		skillid = 26,
		id = 26,
		level = 1
	},
	[31] = {
		name = "内核优化",
		row = 1,
		desc1 = "[被动]所有主动技能冷却减少5%",
		desc3 = "[被动]所有主动技能冷却减少15%",
		column = 3,
		cost = 1,
		passive = 1,
		desc2 = "[被动]所有主动技能冷却减少10%",
		id = 31,
		level = 3,
		param = {
			reduce_skill_cd = 5
		}
	},
	[32] = {
		name = "时光之力",
		row = 2,
		prerow_level = 3,
		desc1 = "[被动]如果处于加速状态，则所有病毒侵入力额外提升5%",
		column = 3,
		desc3 = "[被动]如果处于加速状态，则所有病毒侵入力额外提升15%",
		cost = 1,
		passive = 1,
		desc2 = "[被动]如果处于加速状态，则所有病毒侵入力额外提升10%",
		id = 32,
		level = 3,
		param = {
			speedup_att_extra = 5
		}
	},
	[33] = {
		name = "加速狂暴",
		row = 3,
		prerow_level = 3,
		column = 3,
		desc1 = "[被动]如果处于加速状态，每次侵入造成额外10%伤害值",
		desc3 = "[被动]如果处于加速状态，每次侵入造成额外30%伤害值",
		passive = 1,
		desc2 = "[被动]如果处于加速状态，每次侵入造成额外20%伤害值",
		cost = 2,
		id = 33,
		level = 3,
		preid = {
			{
				id = 32,
				level = 1
			}
		},
		param = {
			speedup_damage_extra = 10
		}
	},
	[34] = {
		name = "量子科技",
		row = 4,
		prerow_level = 3,
		desc1 = "[被动]【加速组件】的加速时间延长3分钟",
		column = 3,
		desc3 = "[被动]【加速组件】的加速时间延长9分钟",
		cost = 2,
		passive = 1,
		desc2 = "[被动]【加速组件】的加速时间延长6分钟",
		id = 34,
		level = 3,
		param = {
			speedup_buff_extra_time = 180
		}
	},
	[35] = {
		cost = 3,
		name = "炸弹",
		desc3 = "[主动]立刻削减目标已侵入的节点最大生命值10%（最多不超过当前节点病毒的侵入力之和*3）",
		desc1 = "[主动]立刻削减目标已侵入的节点最大生命值10%（最多不超过当前节点病毒的侵入力之和*3）",
		prerow_level = 3,
		column = 3,
		row = 5,
		desc2 = "[主动]立刻削减目标已侵入的节点最大生命值10%（最多不超过当前节点病毒的侵入力之和*3）",
		skillid = 35,
		id = 35,
		level = 1
	}
}
