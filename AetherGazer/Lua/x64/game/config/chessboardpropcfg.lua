return {
	[10001] = {
		cost = 10,
		name = "双倍骰子",
		type = 10006,
		id = 10001,
		icon = "prop_01",
		use_description = "可以投掷出两个骰子。",
		prop_description = "——呃……就是可以掷出两次的骰子。",
		params = {
			2,
			1
		}
	},
	[10002] = {
		cost = 12,
		name = "任意骰子",
		type = 10004,
		id = 10002,
		icon = "prop_02",
		use_description = "可以指定投掷出骰子中任意一个点数。",
		prop_description = "——可以完美掷出你想要的那一面。",
		params = {
			3
		}
	},
	[10003] = {
		cost = 5,
		name = "魔术师的礼帽",
		type = 10001,
		id = 10003,
		icon = "prop_03",
		use_description = "获得「吸金」状态，持续2回合。\n\n吸金：每移动一步，获得1枚鸭鸭币。",
		prop_description = "——广场上卖艺的魔术师通常会再身前放一顶礼帽，示意观赏者该意思一下了。",
		params = {
			10003
		}
	},
	[10004] = {
		cost = 10,
		name = "海洋之星门票",
		type = 10001,
		id = 10004,
		icon = "prop_04",
		use_description = "获得「无敌」状态，持续3回合。\n\n无敌：触碰小黄鸭会将其消灭，并获得5枚鸭鸭币。",
		prop_description = "——拥有这样东西，你就是这里的「上帝」。",
		params = {
			10004
		}
	},
	[10005] = {
		cost = 8,
		name = "鸭鸭捕猎枪",
		type = 10002,
		id = 10005,
		icon = "prop_05",
		use_description = "可以消灭棋盘上的任意一只鸭鸭。",
		prop_description = "——惩罚那些到处捣乱的鸭鸭最好用的工具。",
		params = {}
	},
	[10006] = {
		cost = 5,
		name = "神秘的控制器",
		type = 10003,
		id = 10006,
		icon = "prop_06",
		use_description = "可以选择棋盘上的一只鸭鸭交换位置。\n\n交换后不会触发当前地形效果。",
		prop_description = "——可以发出一段音频，使鸭鸭进入混乱状态。",
		params = {}
	},
	[10007] = {
		cost = 3,
		name = "注意防晒",
		type = 10001,
		id = 10007,
		icon = "prop_07",
		use_description = "获得「保护」状态。\n\n保护：触碰小黄鸭会将其消灭，生效后获得5枚鸭鸭币，同时失去该状态。",
		prop_description = "——海边游玩第一条准则：保护皮肤不被晒伤。",
		params = {
			10007
		}
	},
	[10008] = {
		cost = 5,
		name = "普通的路障",
		type = 10007,
		id = 10008,
		icon = "prop_08",
		use_description = "可以选择任意一处无道具和角色的地块放置一个路障。",
		prop_description = "——一个普通的路障，会挡住自己和别人的去路。",
		params = {
			2
		}
	},
	[10009] = {
		cost = 3,
		name = "炸弹气球",
		type = 10007,
		id = 10009,
		icon = "prop_09",
		use_description = "可以选择任意一处无道具和角色的地块放置一个气球炸弹。",
		prop_description = "——炸弹形状的气球，友情提示：不要用明火点燃拴住气球的线，它是真的会炸的哦！",
		params = {
			3
		}
	},
	[10010] = {
		cost = 3,
		name = "打工人的阵痛",
		type = 10010,
		id = 10010,
		icon = "prop_10",
		use_description = "可以指定任意一只鸭鸭或角色，每次只能投掷出1点，持续2回合。",
		prop_description = "——压在身上的是包的重量吗？不是，那是打工人的阵痛。连出门游玩也要时刻关注着工作。",
		params = {
			10010
		}
	},
	[10011] = {
		cost = 5,
		name = "维修专家",
		type = 10008,
		id = 10011,
		icon = "prop_11",
		use_description = "拆除场上指定道具或者消除身上的效果。",
		prop_description = "——「不拆开它我怎么修好它，诶呀放心，我心里有数。」",
		params = {}
	},
	[10012] = {
		cost = 8,
		name = "音控鸭鸭螺",
		type = 10009,
		id = 10012,
		icon = "prop_12",
		use_description = "地图内所有鸭鸭停止移动，持续3回合。",
		prop_description = "——听我说，全场目标向我看齐！321木头人，不许说话，不许动！",
		params = {
			3
		}
	},
	all = {
		10001,
		10002,
		10003,
		10004,
		10005,
		10006,
		10007,
		10008,
		10009,
		10010,
		10011,
		10012
	}
}
