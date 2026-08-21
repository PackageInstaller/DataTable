return {
	[1001] = {
		icon = "1074",
		name = "",
		id = 1001,
		type = 1,
		desc = "船员跟随出航时<color=#5AB283>普通弹</color>的等级上限提升，命中敌人后产生爆炸范围伤害",
		icon_bullet = "QuanZhou_Navigation_editShell_0001",
		tag = "",
		task_id = 11104004,
		icon_show = "",
		affix_list = {
			9355,
			1,
			3
		}
	},
	[1002] = {
		icon = "1072",
		name = "",
		id = 1002,
		type = 1,
		desc = "船员跟随出航时<color=#62A2C7>激光弹</color>的等级上限提升，激光将锁定距离最近的敌人",
		icon_bullet = "QuanZhou_Navigation_editShell_0002",
		tag = "",
		task_id = 11106005,
		icon_show = "",
		affix_list = {
			9356,
			1,
			3
		}
	},
	[1003] = {
		icon = "1060",
		name = "",
		id = 1003,
		type = 1,
		desc = "船员跟随出航时<color=#D7893B>追踪弹</color>的等级上限提升，命中后分裂成数个追踪弹",
		icon_bullet = "QuanZhou_Navigation_editShell_0003",
		tag = "",
		task_id = 11108003,
		icon_show = "",
		affix_list = {
			9357,
			1,
			3
		}
	},
	[2001] = {
		icon = "QuanZhou_Navigation_skill_0001",
		name = "冲击梁",
		id = 2001,
		type = 2,
		desc = "船只加速向前冲刺，过程中无视伤害并对碰到敌人造成大量伤害，<color=#FF9500>可以撞飞爆桶</color>",
		icon_bullet = "",
		tag = "冲撞",
		task_id = 11103005,
		icon_show = "QuanZhou_Navigation_skillSet_0001",
		affix_list = {
			9358,
			1,
			3
		}
	},
	[2002] = {
		icon = "QuanZhou_Navigation_skill_0002",
		name = "船首炮",
		id = 2002,
		type = 2,
		desc = "保持长按进行蓄力，蓄力时移动速度降低，松开后根据蓄力进度发射<color=#FF9500>高伤害穿透激光</color>",
		icon_bullet = "",
		tag = "穿透",
		task_id = 11105005,
		icon_show = "QuanZhou_Navigation_skillSet_0002",
		affix_list = {
			9359,
			1,
			3
		}
	},
	[2003] = {
		icon = "QuanZhou_Navigation_skill_0003",
		name = "驭风台",
		id = 2003,
		type = 2,
		desc = "获得限时护盾，<color=#FF9500>格挡</color>持续期间受到的伤害造成<color=#FF9500>范围反伤</color>",
		icon_bullet = "",
		tag = "反伤",
		task_id = 11107009,
		icon_show = "QuanZhou_Navigation_skillSet_0003",
		affix_list = {
			9360,
			1,
			3
		}
	},
	get_id_list_by_type = {
		[2] = {
			2001,
			2002,
			2003
		},
		{
			1001,
			1002,
			1003
		}
	},
	all = {
		1001,
		1002,
		1003,
		2001,
		2002,
		2003
	}
}
