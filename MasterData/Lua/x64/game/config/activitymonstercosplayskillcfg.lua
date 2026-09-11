return {
	[1001] = {
		skill_cd = "0",
		skill_new_icon = "6108216",
		skill_new_description = "单击发射导弹，长按发射子弹",
		skill_start_description = "挥动武器进行攻击，对敌人造成伤害",
		skill_start_icon = "6108101",
		affix_effect_skill_desc = "",
		id = 1001,
		skill_index = "普攻",
		skill_name = "断钢斩",
		affix_effect_skill_list = {}
	},
	[1002] = {
		skill_cd = "12",
		skill_new_icon = "6108214",
		skill_new_description = "向锁定的目标发射数道激光",
		skill_start_description = "使用机体的枪械进行三连射击，对敌人造成伤害",
		skill_start_icon = "6108104",
		affix_effect_skill_desc = "",
		id = 1002,
		skill_index = "一技能",
		skill_name = "三重贯通",
		affix_effect_skill_list = {}
	},
	[1003] = {
		skill_cd = "12",
		skill_new_icon = "6108215",
		skill_new_description = "开始滑翔，途中会射出多发子弹",
		skill_start_description = "启动加速引擎向前冲刺，落地后产生冲击波，对敌人造成伤害",
		skill_start_icon = "6108205",
		affix_effect_skill_desc = "",
		id = 1003,
		skill_index = "二技能",
		skill_name = "炽焰突袭",
		affix_effect_skill_list = {}
	},
	[1004] = {
		skill_cd = "12",
		skill_new_icon = "6108201",
		skill_new_description = "对锁定的目标进行斩击",
		skill_start_description = "飞到空中随后落地对敌人进行斩击，同时消耗所有怒气生成数道落雷，对敌人造成伤害",
		skill_start_icon = "6108212",
		affix_effect_skill_desc = "空中飞行时会持续消耗怒气，怒气消耗完后会自动施放空中斩击技能，结束飞空形态",
		id = 1004,
		skill_index = "三技能",
		skill_name = "苍色流星",
		affix_effect_skill_list = {
			1001,
			1002,
			1003,
			1004
		}
	},
	[1005] = {
		skill_cd = "0",
		skill_new_icon = "",
		skill_new_description = "",
		skill_start_description = "快速闪避敌人攻击\n使用非移动闪避进行格挡，格挡成功则获得怒气，免疫该伤害并眩晕敌人\n长按可以持续格挡，同时会持续消耗闪避值",
		skill_start_icon = "6108305",
		affix_effect_skill_desc = "",
		id = 1005,
		skill_index = "闪避",
		skill_name = "反应模式",
		affix_effect_skill_list = {}
	},
	[2001] = {
		skill_cd = "0",
		skill_new_icon = "",
		skill_new_description = "",
		skill_start_description = "挥动武器进行攻击，对敌人造成伤害",
		skill_start_icon = "6109101",
		affix_effect_skill_desc = "",
		id = 2001,
		skill_index = "普攻",
		skill_name = "巨力挥舞",
		affix_effect_skill_list = {}
	},
	[2002] = {
		skill_cd = "6",
		skill_new_icon = "6109201",
		skill_new_description = "向前方猛烈冲刺一段时间，对碰到的敌人造成伤害",
		skill_start_description = "对地面进行踩踏，对敌人造成伤害",
		skill_start_icon = "6109206",
		affix_effect_skill_desc = "",
		id = 2002,
		skill_index = "一技能",
		skill_name = "裂地波",
		affix_effect_skill_list = {}
	},
	[2003] = {
		skill_cd = "6",
		skill_new_icon = "6109261",
		skill_new_description = "旋转战戟，将一定范围内的敌人聚集到面前，同时召唤流弹攻击敌人，最后对其敌人重击伤害",
		skill_start_description = "原地跳起，在落地时对敌人造成伤害",
		skill_start_icon = "6109205",
		affix_effect_skill_desc = "",
		id = 2003,
		skill_index = "二技能",
		skill_name = "天穹巡行",
		affix_effect_skill_list = {}
	},
	[2004] = {
		skill_cd = "0",
		skill_new_icon = "",
		skill_new_description = "",
		skill_start_description = "长按该技能奔跑，在奔跑过程中发射导弹，导弹命中敌人造成伤害",
		skill_start_icon = "6109242",
		affix_effect_skill_desc = "通过奔跑积蓄怒气，积攒满怒气后进入暴走模式",
		id = 2004,
		skill_index = "三技能",
		skill_name = "赤红冲锋",
		affix_effect_skill_list = {
			2002,
			2003
		}
	},
	[2005] = {
		skill_cd = "0",
		skill_new_icon = "",
		skill_new_description = "",
		skill_start_description = "快速闪避敌人攻击",
		skill_start_icon = "6109305",
		affix_effect_skill_desc = "",
		id = 2005,
		skill_index = "闪避",
		skill_name = "碎步",
		affix_effect_skill_list = {}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		2001,
		2002,
		2003,
		2004,
		2005
	}
}
