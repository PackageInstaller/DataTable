return {
	[6005001] = {
		description = "裂法狮能量上限为150点，裂法狮每次攻击吸取目标5点能量转化为自己的能量。但每次被击退时会失去1.5点能量，尽力减缓裂法狮的能量获取。同时裂法狮有70的击退抵抗",
		skill2 = 60050012,
		skill1 = 60050011,
		name = "燃烧 ",
		id = 6005001,
		icon = "9003021"
	},
	[6005002] = {
		id = 6005002,
		icon = "1007012",
		skill1 = 60050021
	},
	[6005003] = {
		description = "裂法狮能量伤害提高40%",
		ainame = "skill1",
		cd = 9,
		group_change = 1,
		damage_ratio = 2,
		name = "狂怒",
		section_count = 1,
		fight_talk = "狂怒",
		cfgname = "skill1",
		skill1 = 60050031,
		effect_factor = 0,
		id = 6005003,
		icon = "400210"
	},
	[6005004] = {
		description = "裂法狮锁定攻击最高的角色，造成【攻击*125%】的能量伤害，吸取其30点能量",
		ainame = "skill2",
		cd = 7,
		group_change = 1,
		damage_ratio = 2,
		name = "狂暴汲取",
		section_count = 1,
		fight_talk = "汲取",
		cfgname = "skill2",
		skill1 = 60050041,
		effect_factor = 0,
		id = 6005004,
		icon = "246000"
	},
	[6005006] = {
		description = "裂法狮因摄取的能量过多而发狂，奔现攻击最高的角色身后200码，造成【攻击*2000%】的能量伤害。奔跑期间免疫击倒，但可被打断",
		ainame = "xp",
		cd = 4,
		group_change = 1,
		damage_ratio = 2,
		name = "暗影狂暴",
		section_count = 1,
		fight_talk = "死亡降临！",
		cfgname = "xp",
		skill1 = 60050061,
		effect_factor = 0,
		id = 6005006,
		icon = "25121"
	},
	[6005101] = {
		description = "每次施放技能会获得1层【暗灭】。当【暗灭】叠加至3层时，每次普攻会附带【攻击*100%】的真实伤害",
		skill2 = 60051012,
		skill1 = 60051011,
		name = "暗灭",
		id = 6005101,
		icon = "20423"
	},
	[6005102] = {
		id = 6005102,
		skill1 = 60051021
	},
	[6005103] = {
		cfgname = "skill1",
		name = "机枪扫射",
		skill1 = 60051031,
		ainame = "skill1",
		id = 6005103,
		icon = "61350",
		cd = 4,
		description = "暗灭巨象使用机枪攻击最近的敌人，对其造成【攻击*150%】的机械伤害，并使自身攻速提高30%"
	},
	[6005104] = {
		cfgname = "skill2",
		name = "等离子电磁炮",
		skill1 = 60051041,
		ainame = "skill2",
		id = 6005104,
		icon = "61250",
		cd = 7,
		description = "暗灭巨象发射出一束电磁炮扫射地面，将所有目标击退至300码外，并对其造成【攻击*75%】的能量伤害"
	},
	[6005105] = {
		cfgname = "skill3",
		name = "甩击",
		skill1 = 60051051,
		ainame = "skill3",
		id = 6005105,
		icon = "274200",
		cd = 10,
		description = "暗灭巨像用长鼻抓起最近的敌人，然后甩向巨象身后300码，同时造成【攻击*100%】的机械伤害"
	},
	[6005106] = {
		description = "暗灭巨像使用枪炮对敌人狂轰乱炸，对所有敌人造成3次【攻击*75%】的机械伤害，当有3层暗灭时，将对所有敌人造成3次【攻击*75%】的真实伤害",
		name = "枪炮狂欢",
		cd = 4,
		skill2 = 60051062,
		ainame = "xp",
		cfgname = "xp",
		skill1 = 60051061,
		id = 6005106,
		icon = "422200"
	},
	[6005201] = {
		description = "攻击时【减甲】70点，最多叠加3层",
		name = "荒漠撕咬",
		skill1 = 60052011,
		id = 6005201,
		icon = "1001220"
	},
	[6005202] = {
		id = 6005202,
		icon = "351300",
		skill1 = 60052021
	},
	[6005203] = {
		description = "对最近的敌人发射两发飞弹，每发造成【攻击*75%】的机械伤害，如果目标身上【破甲】层数大于1层，则每发造成【攻击*150%】的机械伤害",
		ainame = "skill1",
		cd = 4,
		name = "双向飞弹",
		fight_talk = "炮火封锁",
		cfgname = "skill1",
		skill1 = 60052031,
		id = 6005203,
		icon = "703220"
	},
	[6005204] = {
		description = "鳄鱼投弹手穿过敌人左右重装敌人，对所有敌人造成两次【攻击*60%】的机械伤害，如果目标身上【破甲】层数大于1层，则每次额外造成【攻击*60%】的机械伤害",
		ainame = "skill2",
		cd = 7,
		name = "横冲直撞",
		fight_talk = "嘿嘿，笨蛋",
		cfgname = "skill2",
		skill1 = 60052041,
		id = 6005204,
		icon = "603220"
	},
	[6005206] = {
		description = "鳄鱼投弹手左右摆动尾巴，对附近200码的敌人造成两次【攻击*100%】的机械伤害，每次附带1层【减甲】，并使【减甲】上限提高1层",
		name = "夺命回摆",
		cd = 4,
		skill2 = 60052062,
		ainame = "xp",
		fight_talk = "吃我一鞭",
		cfgname = "xp",
		skill1 = 60052061,
		id = 6005206,
		icon = "289200"
	},
	[6005301] = {
		description = "当附近100码敌人有敌人时，每次攻击后都会向后退100码。闪避率提高30%",
		name = "灵巧闪避",
		skill1 = 60053011,
		fight_talk = "呲",
		id = 6005301,
		icon = "9002031"
	},
	[6005302] = {
		id = 6005302,
		icon = "351300",
		skill1 = 60053021
	},
	[6005303] = {
		description = "使自身和攻击最高的队友攻击速度和普攻击退效果提高50%，持续3秒。",
		ainame = "skill1",
		cd = 5,
		name = "急速狂化",
		fight_talk = "呲呲呲",
		cfgname = "skill1",
		skill1 = 60053031,
		id = 6005303,
		icon = "20423"
	},
	[6005401] = {
		description = "机械鸟的普攻将造成两次【攻击*50%】的机械伤害。如果机械鸟的伤害被闪避则造成的伤害提高100%，持续3秒",
		name = "叽叽喳喳",
		skill1 = 60054011,
		id = 6005401,
		icon = "9110036"
	},
	[6005402] = {
		id = 6005402,
		icon = "351300",
		skill1 = 60054021
	},
	[6005403] = {
		description = "机械鸟飞向天空，随后快速落下，利用鸟喙对最近的敌人造成【攻击*140%】的机械伤害，该伤害无法被闪避",
		ainame = "skill1",
		cd = 4,
		name = "锋利铁喙",
		fight_talk = "尝尝我的铁喙吧",
		cfgname = "skill1",
		skill1 = 60054031,
		id = 6005403,
		icon = "2756010"
	},
	[6005501] = {
		description = "每10秒获得【总血量*5%】的护盾，护盾存在期间，受到的能量伤害减少50%",
		skill2 = 60055012,
		skill1 = 60055011,
		name = "能量屏障",
		id = 6005501,
		icon = "2025000"
	},
	[6005502] = {
		id = 6005502,
		icon = "351300",
		skill1 = 60055021
	},
	[6005503] = {
		description = "魔法恶犬发出吼叫，使我方所有队友受到的能量伤害降低25%，持续3秒",
		ainame = "skill1",
		cd = 4,
		name = "能量克星",
		fight_talk = "啊呜",
		cfgname = "skill1",
		skill1 = 60055031,
		id = 6005503,
		icon = "2024200"
	},
	[6005504] = {
		description = "魔法恶犬向前跳跃125码，造成【攻击*150%】的能量伤害，并使其恐惧1秒",
		ainame = "skill2",
		cd = 7,
		name = "魔法跃迁",
		fight_talk = "汪！汪汪！",
		cfgname = "skill2",
		skill1 = 60055041,
		id = 6005504,
		icon = "9010037"
	},
	[6005601] = {
		description = "重箭鱼鹰施放技能时受到的伤害降低50%，未施放技能时受到的伤害提高100%",
		skill2 = 60056012,
		skill1 = 60056011,
		name = "翱翔天空",
		id = 6005601,
		icon = "9006002"
	},
	[6005602] = {
		id = 6005602,
		icon = "60056021",
		skill1 = 60056021
	},
	[6005603] = {
		description = "重箭鱼鹰转动脚下的转轮，向前飞行600码后停下，对途径所有敌人造成【攻击*50%】的机械伤害，并使其减速50%，持续2秒",
		ainame = "skill1",
		cd = 4,
		name = "飞翔转轮",
		fight_talk = "芜湖，起飞！",
		cfgname = "skill1",
		skill1 = 60056031,
		id = 6005603,
		icon = "9002201"
	},
	[6005604] = {
		description = "重箭鱼鹰发射出两发炮弹，锁定当前血量百分比最高的单位，对其造成【攻击*75%】，并击晕1秒",
		ainame = "skill2",
		cd = 7,
		name = "双肩火炮",
		fight_talk = "鱼鹰导弹",
		cfgname = "skill2",
		skill1 = 60056041,
		id = 6005604,
		icon = "1006016"
	},
	[6005606] = {
		description = "重箭鱼鹰煽动翅膀，扬起飞尘，对所有敌人造成【攻击*150%】的机械伤害，并使其暴击率降低40%，持续3秒",
		ainame = "xp",
		cd = 4,
		name = "钢铁飓风",
		fight_talk = "安静",
		cfgname = "xp",
		skill1 = 60056061,
		id = 6005606,
		icon = "6123113"
	},
	[6005701] = {
		id = 6005701,
		name = "暗灭",
		icon = "20423",
		description = "防御塔"
	},
	[6005702] = {
		id = 6005702,
		skill1 = 60057021
	},
	[6005703] = {
		cfgname = "skill1",
		name = "甩击",
		skill1 = 60057031,
		ainame = "skill1",
		id = 6005703,
		icon = "274200",
		cd = 10,
		description = "暗灭巨像用长鼻抓起最近的敌人，然后甩向巨象身后300码，同时造成【攻击*100%】的机械伤害"
	}
}
