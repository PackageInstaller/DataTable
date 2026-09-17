return {
	[1001000] = {
		description = "格里菲斯的身体经过半机械改造，击退能力大幅提高，并有50%概率免疫负面状态；攻击有概率施加[击碎]：护甲值降低100点，最多叠加3层",
		name = "机械改造",
		skill1 = 1001001,
		id = 1001000,
		icon = "1001000"
	},
	[1001100] = {
		description = "含有三种出拳，循环使用，击退能力不同",
		name = "出拳",
		skill1 = 1001101,
		skill2 = 1001111,
		id = 1001100,
		icon = "1001100"
	},
	[1001200] = {
		description = "格里菲斯猛锤地面产生爆炸，击飞200码范围内的所有目标200码，造成【攻击*300】的伤害",
		ainame = "skill1",
		cd = 6,
		name = "裂地猛击",
		fight_talk = "尝尝这招！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1001201,
		id = 1001200,
		icon = "1001200"
	},
	[1001210] = {
		description = "当格里菲斯300码范围内存在4个敌人时，格里菲斯发射火箭拳，全体敌人推开，飞拳本体造成【攻击*200%】的伤害，随后飞拳爆炸，造成【攻击*200】的伤害",
		ainame = "skill2",
		cd = 10,
		name = "火箭飞拳",
		fight_talk = "就是你了！",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 1001211,
		id = 1001210,
		icon = "1001210"
	},
	[1001220] = {
		description = "格里菲斯使用激光眼扫描地面，对400码内目标造成【攻击*100】的伤害并击退，随后地面产生火柱，第一段火柱造成【攻击*400%】伤害，随后每个火柱伤害依次下降【攻击*100%】",
		ainame = "skill3",
		cd = 8,
		name = "激光义眼",
		fight_talk = "没想到吧！",
		skill2 = 1001222,
		section_count = 1,
		skill3 = 1001223,
		cfgname = "skill3",
		skill4 = 1001224,
		skill1 = 1001221,
		id = 1001220,
		icon = "1001220"
	},
	[1001300] = {
		description = "格里菲斯将双拳发射升空，瞄准地面，随后从天而降2个巨大拳头，每个造成【攻击*100】的伤害并且击倒目标，1.5秒后拳头爆炸，造成【攻击*300%】的伤害，并击飞所有目标",
		ainame = "xp",
		cd = 6,
		name = "导弹飞拳",
		fight_talk = "结束了！",
		skill2 = 1001302,
		section_count = 1,
		cfgname = "xp",
		skill1 = 1001301,
		id = 1001300,
		icon = "1001300"
	},
	[1002000] = {
		description = "迪丽莎所有攻击有25%概率叠加一层【玛伽】，当玛伽数叠加到8层时，会控制这个单位，持续5秒",
		name = "致幻攻击",
		skill1 = 1002101,
		id = 1002000,
		icon = "1002000"
	},
	[1002100] = {
		description = "两种挥鞭，循环",
		name = "挥鞭",
		skill1 = 1002111,
		id = 1002100,
		icon = "1002100"
	},
	[1002200] = {
		description = "迪丽莎飞到空中，免疫所有近战伤害，并且攻击随机的敌人，持续3秒",
		ainame = "skill1",
		cd = 6,
		name = "飞行姿态",
		fight_talk = "起飞！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1002201,
		id = 1002200,
		icon = "1002200"
	},
	[1002210] = {
		description = "迪丽莎给自己注射玛伽，所有攻击叠加【玛伽】的概率提升为50%,持续3秒",
		ainame = "skill2",
		cd = 4,
		name = "自我强化",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 1002211,
		id = 1002210,
		icon = "1002210"
	},
	[1002220] = {
		description = "迪丽莎召唤机器人助阵，施放技能时无敌，对800码内所有敌人造成【攻击*300%】伤害",
		ainame = "skill3",
		cd = 16,
		name = "机械大军",
		fight_talk = "保护我！",
		section_count = 1,
		cfgname = "skill3",
		skill1 = 1002221,
		id = 1002220,
		icon = "1002220"
	},
	[1002300] = {
		description = "迪丽莎猛的挥鞭攻击地面，将所有人震飞到空中，随后连续鞭笞空中的敌人，造成10次总计【攻击*500%】伤害，同时给所有目标叠加5层【玛伽】",
		ainame = "xp",
		cd = 6,
		name = "荆棘鞭笞",
		fight_talk = "互相伤害吧！",
		section_count = 1,
		cfgname = "xp",
		skill1 = 1002301,
		id = 1002300,
		icon = "1002300"
	},
	[1004000] = {
		description = "芬里尔成员经过改造，击退能力提升",
		name = "机械改造",
		skill1 = 1004001,
		id = 1004000,
		icon = "1001000",
		section_count = 1
	},
	[1004100] = {
		description = "出拳攻击",
		name = "出拳",
		skill1 = 1004101,
		id = 1004100,
		icon = "1001100",
		section_count = 1
	},
	[1004200] = {
		description = "芬里尔战士跳起重击，对150码内所有敌人造成【攻击*150%】伤害，并击晕0.5秒",
		ainame = "skill1",
		cd = 4,
		name = "裂地猛击",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1004201,
		id = 1004200,
		icon = "1001200"
	},
	[1004210] = {
		description = "义眼发射出高温射线，对150码内所有敌人造成【攻击*200%】伤害，并造成【减疗】：减疗20%，可叠3层，持续3秒",
		ainame = "skill1",
		cd = 6,
		name = "激光义眼",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1004211,
		id = 1004210,
		icon = "1001220"
	},
	[1005000] = {
		description = "荆棘鸟成员的所有攻击有25%概率叠加一层【玛伽】，当玛伽数叠加到8层时，会控制这个单位，持续5秒",
		name = "致幻攻击",
		skill1 = 1005001,
		id = 1005000,
		icon = "1002000",
		section_count = 1
	},
	[1005100] = {
		description = "挥棒攻击",
		name = "挥鞭",
		skill1 = 1005101,
		skill2 = 1005102,
		id = 1005100,
		skill4 = 1005104,
		section_count = 1,
		skill3 = 1005103
	},
	[1005200] = {
		description = "荆棘鸟帮众注射玛伽，快速攻击4次，所有攻击叠加【玛伽】的概率提升为50%",
		ainame = "skill1",
		cd = 6,
		name = "自我强化",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1005201,
		id = 1005200,
		icon = "1002210"
	},
	[1005300] = {
		description = "对400码内随机敌人发射一发子弹，造成【攻击*200%】伤害，并控制目标3秒",
		ainame = "skill1",
		cd = 6,
		name = "暗枪伤人",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1005211,
		id = 1005300,
		icon = "1002230"
	},
	[1001101] = {
		description = "格里菲斯的身体经过半机械改造，击退能力大幅提高，并有50%概率免疫负面状态；攻击有概率施加[击碎]：护甲值降低100点，最多叠加3层",
		name = "机械改造",
		skill1 = 1001001,
		id = 1001101,
		icon = "1001000"
	},
	[1001102] = {
		description = "含有三种出拳，循环使用，击退能力不同",
		name = "出拳",
		skill1 = 1001112,
		skill2 = 1001113,
		id = 1001102,
		icon = "1001100"
	},
	[1001103] = {
		description = "格里菲斯猛锤地面产生爆炸，击飞200码范围内的所有目标200码，造成【攻击*300】的伤害",
		ainame = "skill1",
		cd = 6,
		name = "裂地猛击",
		fight_talk = "尝尝这招！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 1001201,
		id = 1001103,
		icon = "1001200"
	},
	[1001104] = {
		description = "当格里菲斯300码范围内存在4个敌人时，格里菲斯发射火箭拳，全体敌人推开，飞拳本体造成【攻击*200%】的伤害，随后飞拳爆炸，造成【攻击*200】的伤害",
		ainame = "skill2",
		cd = 10,
		name = "火箭飞拳",
		fight_talk = "就是你了！",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 1001211,
		id = 1001104,
		icon = "1001210"
	},
	[1001105] = {
		description = "格里菲斯使用激光眼扫描地面，对400码内目标造成【攻击*100】的伤害并击退，随后地面产生火柱，第一段火柱造成【攻击*400%】伤害，随后每个火柱伤害依次下降【攻击*100%】",
		ainame = "skill3",
		cd = 8,
		name = "激光义眼",
		fight_talk = "没想到吧！",
		skill2 = 1001222,
		section_count = 1,
		skill3 = 1001223,
		cfgname = "skill3",
		skill4 = 1001224,
		skill1 = 1001221,
		id = 1001105,
		icon = "1001220"
	},
	[1001106] = {
		description = "格里菲斯将双拳发射升空，瞄准地面，随后从天而降2个巨大拳头，每个造成【攻击*100】的伤害并且击倒目标，1.5秒后拳头爆炸，造成【攻击*300%】的伤害，并击飞所有目标",
		ainame = "skill4",
		cd = 6,
		name = "导弹飞拳",
		fight_talk = "结束了！",
		skill2 = 1001302,
		section_count = 1,
		cfgname = "skill4",
		skill1 = 1001301,
		id = 1001106,
		icon = "1001300"
	},
	[1001107] = {
		description = "格里菲斯将双拳发射升空，瞄准地面，随后从天而降2个巨大拳头，消灭所有角色",
		ainame = "xp",
		cd = 6,
		name = "导弹飞拳·真",
		fight_talk = "结束了！",
		skill2 = 1001402,
		section_count = 1,
		cfgname = "xp",
		skill1 = 1001401,
		id = 1001107,
		icon = "1001300",
		not_use_rage = 0
	}
}
