return {
	[1101101] = {
		id = 1101101,
		name = "重装坦克",
		icon = "1101101",
		description = "该单位抗击退能力大幅提升，防御力大幅提升"
	},
	[1101102] = {
		id = 1101102,
		name = "日地重拳",
		skill1 = 11011021,
		icon = "1101102"
	},
	[1101103] = {
		description = "聚能后发射激光，对正面所有敌人造成中等的量子伤害",
		ainame = "skill1",
		cd = 6,
		name = "主炮射击",
		fight_talk = "锁定！",
		section_count = 3,
		cfgname = "skill1",
		skill1 = 11011031,
		id = 1101103,
		icon = "1101103"
	},
	[1101105] = {
		description = "短暂的延迟后，机甲强制击退正面范围内所有敌人，并造成大量伤害",
		ainame = "xp",
		cd = 10,
		name = "舍身冲撞",
		fight_talk = "冲锋！",
		section_count = 1,
		cfgname = "xp",
		skill1 = 11011051,
		id = 1101105,
		icon = "61220"
	},
	[1101401] = {
		description = "侦察者用机枪压制对手，使目标的攻击有一定概率被致盲",
		name = "三联机枪",
		skill1 = 11014011,
		skill2 = 11014012,
		id = 1101401,
		icon = "1101401"
	},
	[1101402] = {
		id = 1101402,
		name = "平A",
		skill1 = 11014021,
		icon = "1101402"
	},
	[1101403] = {
		description = "侦察者锁定一个友方敌人，笼罩在其上方，持续期间该单位攻击力大幅提升，并且获得【稳固】",
		ainame = "skill1",
		cd = 17,
		name = "强化引导",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11014031,
		id = 1101403,
		icon = "1101403"
	},
	[1101404] = {
		description = "侦察者锁定一个敌人，笼罩在其上方，使其【眩晕】，持续期间双方获得【稳固】",
		ainame = "skill2",
		cd = 13,
		name = "干扰引导",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11014041,
		id = 1101404,
		icon = "1101404"
	},
	[1101405] = {
		description = "侦察者在死亡后爆炸，对小范围内所有单位造成大量伤害（不论敌我）",
		name = "自毁开关",
		cd = 8,
		skill1 = 11014051,
		id = 1101405,
		icon = "1101405",
		section_count = 1,
		skill2 = 11014052
	},
	[1101501] = {
		description = "拉弥亚使用先进的力场科技使自身浮空，击退抗性，闪避率大幅提升",
		name = "磁悬浮",
		skill1 = 11015011,
		id = 1101501,
		icon = "1101501"
	},
	[1101502] = {
		id = 1101502,
		name = "平A",
		skill1 = 11015021,
		icon = "1101502"
	},
	[1101503] = {
		description = "拉弥亚锁定一个友方敌人，给于能量屏障，该单位获得额外血量",
		ainame = "skill1",
		cd = 4,
		name = "能量屏障",
		fight_talk = "护盾！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11015031,
		id = 1101503,
		icon = "1101503"
	},
	[1101504] = {
		description = "拉弥亚聚集物质，将正面所有的敌人推开，并造成中等伤害",
		ainame = "skill2",
		cd = 6,
		name = "动能推进",
		fight_talk = "太近了！",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11015041,
		id = 1101504,
		icon = "1101504"
	},
	[1101505] = {
		description = "拉弥亚吸引反物质聚集，短暂的延迟后投下重力炸弹，对全场的敌人造成大量伤害",
		ainame = "xp",
		cd = 8,
		name = "势能爆破",
		fight_talk = "升起吧！",
		skill2 = 11015052,
		section_count = 1,
		cfgname = "xp",
		skill1 = 11015051,
		id = 1101505,
		icon = "1101505"
	},
	[1101201] = {
		description = "发射器会瞄准正面300码内随机敌人",
		name = "仰角射击",
		skill1 = 11012011,
		id = 1101201,
		icon = "9002112"
	},
	[1101202] = {
		id = 1101202,
		name = "平A",
		skill1 = 11012021,
		icon = "412100"
	},
	[1101203] = {
		description = "发射器迅速的发射两枚穿甲弹，对300码距离内随机敌人造成【攻击*150%】伤害，且附带[减防]",
		ainame = "skill1",
		cd = 8,
		name = "穿甲弹",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11012031,
		id = 1101203,
		icon = "1002230"
	},
	[1101205] = {
		description = "锁定400码内血量最低敌人，发射制导火箭炮，短暂的延迟后火箭弹落地，对目标150码范围内敌人造成【攻击*200%】伤害",
		ainame = "skill2",
		cd = 8,
		name = "末端制导",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11012051,
		id = 1101205,
		icon = "601220"
	},
	[1101301] = {
		description = "支援者每隔6秒，给血量最低的队友添加[能量屏障]",
		name = "能量屏障",
		skill1 = 11013011,
		id = 1101301,
		icon = "1101101"
	},
	[1101302] = {
		id = 1101302,
		name = "平A",
		skill1 = 11013021,
		icon = "412100"
	},
	[1101303] = {
		description = "支援者锁定400码内攻击力最高的敌人，束缚其行动3秒",
		ainame = "skill1",
		cd = 8,
		name = "屏障阻隔",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11013031,
		id = 1101303,
		icon = "9002221"
	},
	[1101305] = {
		description = "为全体队友添加[能量屏障]",
		ainame = "skill2",
		cd = 8,
		name = "能量灯塔",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11013051,
		id = 1101305,
		icon = "9002081"
	},
	[1101304] = {
		description = "支援者每隔6秒，给血量最低的队友[能量屏障]",
		ainame = "skill3",
		cd = 6,
		name = "能量屏障",
		section_count = 1,
		cfgname = "skill3",
		skill1 = 11013041,
		id = 1101304,
		icon = "1101101"
	},
	[1101601] = {
		description = "觉醒拉弥亚无视恐惧和眩晕，并使自身浮空，闪避率大幅提升；每次闪避攻击，自身获得一层【动能】：攻击力提升1%，最多叠加50层",
		name = "动能俘获",
		skill1 = 11016011,
		skill2 = 11016012,
		id = 1101601,
		icon = "1101501",
		skill3 = 11016013
	},
	[1101602] = {
		id = 1101602,
		name = "平A",
		skill1 = 11016021,
		icon = "1101502"
	},
	[1101603] = {
		description = "拉弥亚锁定一个队友，给于能量屏障，该单位获得额外血量，并且护甲少量提升",
		ainame = "skill1",
		cd = 7,
		name = "能量坚壁",
		fight_talk = "坚不可摧！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11016031,
		id = 1101603,
		icon = "1101503"
	},
	[1101604] = {
		description = "拉弥亚聚集物质，击倒近距离的敌人，并推开远处的敌人，同时造成大量伤害",
		ainame = "skill2",
		cd = 8,
		name = "动能推进",
		fight_talk = "退下！",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11016041,
		id = 1101604,
		icon = "1101504"
	},
	[1101605] = {
		description = "拉弥亚使重力颠倒，将全体敌人升起并造成少量伤害，随后将全体敌人降下，造成目标15%最大生命值的真实伤害，同时眩晕1秒",
		ainame = "skill3",
		cd = 11,
		name = "重力颠倒",
		fight_talk = "掌控！",
		skill2 = 11016052,
		section_count = 1,
		cfgname = "skill3",
		skill1 = 11016051,
		id = 1101605,
		icon = "1101502"
	},
	[1101606] = {
		description = "拉弥亚吸引反物质聚集，将全体敌人升起并造成少量伤害，随后将黑暗物质球砸下，造成目标30%最大生命值的真实伤害，同时眩晕1秒",
		ainame = "xp",
		cd = 8,
		name = "黑暗太阳",
		fight_talk = "黑暗太阳！",
		skill2 = 11016062,
		section_count = 1,
		cfgname = "xp",
		skill1 = 11016061,
		id = 1101606,
		icon = "1101505"
	},
	[1101701] = {
		description = "梦魇拉弥亚无视恐惧和眩晕，并使自身浮空，闪避率大幅提升；所有技能都有50%的概率造成【失重】：该目标移动速度降低90%",
		name = "重力掌控",
		skill1 = 11017011,
		skill2 = 11017012,
		id = 1101701,
		icon = "1101501",
		skill3 = 11017013
	},
	[1101702] = {
		id = 1101702,
		name = "平A",
		skill1 = 11017021,
		icon = "1101502"
	},
	[1101703] = {
		description = "拉弥亚锁定一个队友，给于能量屏障，该单位获得大量的额外血量，同时护甲大幅提升",
		ainame = "skill1",
		cd = 9,
		name = "能量坚壁",
		fight_talk = "保护！",
		section_count = 1,
		cfgname = "skill1",
		skill1 = 11017031,
		id = 1101703,
		icon = "1101503"
	},
	[1101704] = {
		description = "拉弥亚聚集物质，击倒近距离的敌人，并推开远处的敌人，同时造成大量伤害",
		ainame = "skill2",
		cd = 10,
		name = "动能推进",
		fight_talk = "飒！",
		section_count = 1,
		cfgname = "skill2",
		skill1 = 11017041,
		id = 1101704,
		icon = "1101504"
	},
	[1101705] = {
		description = "拉弥亚使重力颠倒，将全体敌人升起并造成少量伤害，随后将全体敌人降下，造成目标15%最大生命值的真实伤害，同时眩晕1秒",
		ainame = "skill3",
		cd = 14,
		name = "重力颠倒",
		fight_talk = "升起！",
		skill2 = 11017052,
		section_count = 1,
		cfgname = "skill3",
		skill1 = 11017051,
		id = 1101705,
		icon = "1101502"
	},
	[1101706] = {
		description = "短暂的延迟后，拉弥亚吸引反物质聚集，将全体敌人升起并造成少量伤害，随后将黑暗物质球砸下，造成目标30%最大生命值的真实伤害，同时眩晕1秒",
		ainame = "xp",
		cd = 8,
		name = "黑暗太阳",
		fight_talk = "终结之日！",
		skill2 = 11017062,
		section_count = 1,
		cfgname = "xp",
		skill1 = 11017061,
		id = 1101706,
		icon = "1101505"
	}
}
