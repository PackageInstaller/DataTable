return {
	[2028000] = {
		description = "每次受到攻击时，有15%概率为所有队友添加1层[蛋卷]护盾",
		name = "衬托",
		skill1 = 202800010,
		id = 2028000,
		icon = "2028000"
	},
	[2028100] = {
		id = 2028100,
		name = "普攻",
		skill1 = 202810010
	},
	[2028200] = {
		description = "梦境变换，将敌人从梦中惊醒；对所有敌人造成【攻击*150%】的能量伤害，击退所有敌人；并对血量低于70%的敌人施加1层[心动]",
		name = "如梦初醒",
		cd = 5,
		skill2 = 202820011,
		ainame = "skill1",
		cfgname = "skill1",
		skill1 = 202820010,
		max_distance = 640,
		id = 2028200,
		icon = "2028200",
		need_attack_count = 4
	},
	[2028300] = {
		description = "使用梦境守护，令所有队友获[美梦]，持续时间3秒",
		ainame = "xp",
		cd = 12,
		name = "软绵梦境",
		cfgname = "xp",
		skill1 = 202830010,
		max_distance = 640,
		id = 2028300,
		icon = "2028300"
	},
	[20285010] = {
		id = 20285010,
		name = "好梦连连",
		skill1 = 2028501010,
		description = "[美梦]持续时间增加1秒"
	},
	[20285020] = {
		id = 20285020,
		name = "好梦连连",
		skill1 = 2028502010,
		description = "[美梦]持续时间增加2秒"
	},
	[20285030] = {
		id = 20285030,
		name = "好梦连连",
		skill1 = 2028503010,
		description = "[美梦]持续时间增加3秒"
	}
}
