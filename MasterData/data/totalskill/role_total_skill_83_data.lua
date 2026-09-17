return {
	[2025000] = {
		description = "每秒对所有敌人施加1层[冷光]",
		name = "冷艳",
		skill1 = 202500010,
		id = 2025000,
		icon = "2025000"
	},
	[2025100] = {
		id = 2025100,
		name = "普攻",
		skill1 = 202510010
	},
	[2025200] = {
		description = "对正面600码内攻击最高的敌人造成【攻击*420%】的能量伤害并施加4层[冷光]",
		skill2 = 202520011,
		cd = 5,
		name = "高照",
		ainame = "skill1",
		cfgname = "skill1",
		skill1 = 202520010,
		max_distance = 620,
		id = 2025200,
		icon = "2025200",
		need_attack_count = 4
	},
	[2025300] = {
		description = "反物质与物质融合，物质球被巨大能量撑开；对场上所有敌人造成【攻击*600%】的能量伤害，击飞所有敌人并施加3层[冷光]",
		skill2 = 202530011,
		cd = 12,
		name = "湮灭",
		ainame = "xp",
		cfgname = "xp",
		skill1 = 202530010,
		max_distance = 640,
		id = 2025300,
		icon = "2025300"
	},
	[20255010] = {
		id = 20255010,
		name = "充分反应",
		skill1 = 2025501010,
		description = "能量伤害提高15%"
	},
	[20255020] = {
		id = 20255020,
		name = "充分反应",
		skill1 = 2025502010,
		description = "能量伤害提高30%"
	},
	[20255030] = {
		id = 20255030,
		name = "充分反应",
		skill1 = 2025503010,
		description = "能量伤害提高45%"
	},
	[20256010] = {
		description = "能量伤害提高15%，入场时对敌方全体施加10层[冷光]",
		name = "冷光四溢",
		skill1 = 2025601010,
		skill2 = 2025601011,
		id = 20256010,
		icon = "20256010"
	}
}
