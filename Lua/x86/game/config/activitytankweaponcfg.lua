return {
	[101] = {
		energy_cost = 4,
		name = "机枪",
		damage = 5,
		id = 101,
		cost = 3,
		skill_group = 1,
		effect_type = 1,
		desc = "<color=#E78300>机枪命中赛车后将使赛车减速。</color>\n有了它，对面就会像饿了三天三夜一样没力气啦~",
		sort = 1,
		asset_name = "MachineGun",
		rof = 2,
		item_type = 1,
		icon = "101",
		is_unlocked = 1,
		effect_params = {
			1,
			2,
			15
		}
	},
	[102] = {
		energy_cost = 2,
		name = "激光炮",
		damage = 100,
		id = 102,
		cost = 5,
		skill_group = 2,
		effect_type = 2,
		desc = "<color=#E78300>激光炮充能一段时间后会向前发射，将穿透的前方所有赛车并造成灼烧伤害。</color>\n放心，尼娅测试过了，只会感觉热热的而已。",
		sort = 2,
		asset_name = "LaserCannon",
		rof = 0.3,
		item_type = 1,
		icon = "102",
		is_unlocked = 1,
		effect_params = {
			10,
			3,
			2
		}
	},
	[103] = {
		energy_cost = 2,
		name = "火箭炮",
		damage = 25,
		id = 103,
		cost = 2,
		skill_group = 3,
		effect_type = 3,
		desc = "<color=#E78300>火箭炮命中赛车后会产生爆炸。</color>\n这么大的气浪……也许能把车炸到天上去？",
		sort = 3,
		asset_name = "RocketLauncher",
		rof = 1,
		item_type = 1,
		icon = "103",
		is_unlocked = 1,
		effect_params = {
			2,
			1,
			12
		}
	},
	[104] = {
		energy_cost = 3,
		name = "回旋镖",
		damage = 80,
		id = 104,
		cost = 4,
		skill_group = 4,
		effect_type = 4,
		desc = "<color=#E78300>回旋镖向前飞一段距离后会飞回。</color>\n两次不同方向的撞击，或许能产生奇妙的效果？",
		sort = 4,
		asset_name = "Boomerang",
		rof = 1.7,
		item_type = 1,
		icon = "104",
		is_unlocked = 1,
		effect_params = {
			4,
			2,
			8
		}
	},
	[105] = {
		energy_cost = 3,
		name = "散射炮",
		damage = 5,
		id = 105,
		cost = 4,
		skill_group = 5,
		effect_type = 5,
		desc = "<color=#E78300>散射炮命中赛车后会造成一定程度的击退效果。</color>\n这可是尼娅亲自挑选的，保准有力气。",
		sort = 5,
		asset_name = "ScatterShell",
		rof = 0.7,
		item_type = 1,
		icon = "105",
		is_unlocked = 1,
		effect_params = {
			12,
			10,
			8
		}
	},
	[106] = {
		energy_cost = 4,
		name = "钻头",
		damage = 8,
		id = 106,
		cost = 3,
		skill_group = 6,
		effect_type = 6,
		desc = "<color=#E78300>钻头会持续攻击接触到的赛车。</color>\n要是一直旋转下去的话，这个钻头一定可以突破天际！",
		sort = 6,
		asset_name = "Drill",
		rof = 1.7,
		item_type = 1,
		icon = "106",
		is_unlocked = 0,
		effect_params = {
			3,
			1,
			2
		}
	},
	[107] = {
		energy_cost = 3,
		name = "旋转圆锯",
		damage = 8,
		id = 107,
		cost = 4,
		skill_group = 7,
		effect_type = 7,
		desc = "<color=#E78300>旋转圆锯会持续转动，每次与赛车接触时将造成伤害。</color>\n带上链锯的车……或许可以叫做链锯车？",
		sort = 7,
		asset_name = "RotatingSaw",
		rof = 1,
		item_type = 1,
		icon = "107",
		is_unlocked = 1,
		effect_params = {
			0.8
		}
	},
	[108] = {
		energy_cost = 2,
		name = "铲斗",
		damage = 0,
		id = 108,
		cost = 3,
		skill_group = 8,
		effect_type = 8,
		desc = "<color=#E78300>铲斗将持续转动，每次与赛车接触时将产生物理碰撞。</color>\n就是现在！掀翻它们！",
		sort = 8,
		asset_name = "Shovel",
		rof = 0.7,
		item_type = 1,
		icon = "108",
		is_unlocked = 1,
		effect_params = {
			0,
			1,
			3
		}
	},
	[201] = {
		energy_cost = 4,
		name = "护盾发生器",
		damage = 0,
		id = 201,
		cost = 3,
		skill_group = 11,
		effect_type = 101,
		desc = "<color=#E78300>触发护盾发生器后2秒内不会受到任何伤害。</color>\n这可不算作弊哦！",
		sort = 9,
		asset_name = "ShieldGenerator",
		rof = 0,
		item_type = 2,
		icon = "201",
		is_unlocked = 1,
		effect_params = {
			1,
			2,
			6
		}
	},
	[202] = {
		energy_cost = 1,
		name = "钩锁",
		damage = 0,
		id = 202,
		cost = 2,
		skill_group = 12,
		effect_type = 102,
		desc = "<color=#E78300>触发后钩锁可以将自己与敌人拉近。</color>\n之前的距离我不挑你的理，但现在该叫我什么？",
		sort = 10,
		asset_name = "Hook",
		rof = 0,
		item_type = 2,
		icon = "202",
		is_unlocked = 1,
		effect_params = {
			10,
			1,
			5
		}
	},
	[203] = {
		energy_cost = 3,
		name = "拳击手套",
		damage = 0,
		id = 203,
		cost = 2,
		skill_group = 13,
		effect_type = 103,
		desc = "<color=#E78300>触发拳击手套后将弹开拳击手套接触的赛车。</color>\n对它们使用出拳吧！",
		sort = 11,
		asset_name = "BoxingGlove",
		rof = 0,
		item_type = 2,
		icon = "203",
		is_unlocked = 1,
		effect_params = {
			8,
			2,
			3
		}
	},
	[204] = {
		energy_cost = 2,
		name = "推进器",
		damage = 0,
		id = 204,
		cost = 1,
		skill_group = 14,
		effect_type = 104,
		desc = "<color=#E78300>触发推进器后将向前加速。</color>\n或许我们可以成为超越光的光！",
		sort = 12,
		asset_name = "Thruster",
		rof = 0,
		item_type = 2,
		icon = "204",
		is_unlocked = 1,
		effect_params = {
			2,
			1,
			3
		}
	},
	[205] = {
		energy_cost = 4,
		name = "干扰器",
		damage = 0,
		id = 205,
		cost = 3,
		skill_group = 15,
		effect_type = 105,
		desc = "<color=#E78300>触发后干扰器将使对方赛车武装瘫痪一定时间。</color>\n最好的获胜方法是……除你武器！",
		sort = 13,
		asset_name = "ElectricNet",
		rof = 0,
		item_type = 2,
		icon = "205",
		is_unlocked = 1,
		effect_params = {
			1,
			3,
			3
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
		201,
		202,
		203,
		204,
		205
	}
}
