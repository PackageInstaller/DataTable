return {
	{
		itemid = 201912005,
		name = "加速",
		cd = 0,
		type = 1,
		num = 1,
		target = 1,
		desc = "10倍加速中",
		diamond = 50,
		id = 1,
		param1 = {
			seconds = 600
		}
	},
	[15] = {
		name = "减防御",
		cd = 21600,
		type = 2,
		id = 15,
		param2 = -10,
		target = 2,
		desc = "此节点防御下降中",
		param1 = {
			round = 3
		}
	},
	[26] = {
		name = "暂停破译",
		cd = 21600,
		type = 2,
		id = 26,
		target = 1,
		desc = "正在阻碍研究中心的破译",
		param1 = {
			round = 3
		}
	},
	[25] = {
		name = "蛰伏",
		cd = 21600,
		type = 2,
		id = 25,
		target = 2,
		desc = "繁殖不入侵",
		param1 = {
			round = 3
		}
	},
	[35] = {
		param1 = 10,
		name = "炸弹",
		cd = 21600,
		type = 2,
		id = 35,
		target = 2,
		desc = "立刻削减目标已侵入的节点最大生命值10%（最多不超过当前节点病毒的侵入力之和*3）"
	},
	{
		name = "临时防御",
		cd = 0,
		type = 2,
		id = 2,
		target = 2,
		desc = "此节点由于科研中心出现，临时防御已提高",
		param1 = {
			round = 10
		}
	}
}
