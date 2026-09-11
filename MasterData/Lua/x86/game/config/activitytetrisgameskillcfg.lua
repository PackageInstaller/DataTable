return {
	[1001] = {
		name = "无限旋转",
		type = 3,
		desc = "点击待选区方块，使选中方块<color=#F48800>顺时针旋转90°</color>。",
		skill_id = 1001,
		exclusion = {},
		unlock_stage_id = {
			2
		},
		params_1 = {},
		params_2 = {},
		Params_3 = {}
	},
	[1002] = {
		name = "更替重置",
		type = 1,
		desc = "每回合放置一个方块后，将<color=#F48800>直接进入下一个回合</color>。",
		skill_id = 1002,
		exclusion = {},
		unlock_stage_id = {
			40804
		},
		params_1 = {},
		params_2 = {},
		Params_3 = {}
	},
	[1003] = {
		name = "幸运回合",
		type = 1,
		desc = "每三个回合后，将生成<color=#F48800>单格及三格的特殊方块</color>，放置任一方块结束该回合。",
		skill_id = 1003,
		exclusion = {},
		unlock_stage_id = {
			4
		},
		params_1 = {
			3
		},
		params_2 = {
			0,
			1,
			2
		},
		Params_3 = {}
	},
	[1004] = {
		name = "以时换率",
		type = 1,
		desc = "总时间减少<color=#F48800>50</color>秒，<color=#F48800>消除得分和放置得分</color>倍率大幅度增加。",
		skill_id = 1004,
		exclusion = {},
		unlock_stage_id = {
			4
		},
		params_1 = {
			50,
			1
		},
		params_2 = {},
		Params_3 = {}
	},
	[1005] = {
		name = "厚积薄发",
		type = 3,
		desc = "每当方块放入盘面中且未触发消除时，将<color=#F48800>积累蓄力进度</color>；\n当触发消除时，将<color=#F48800>清空蓄力进度</color>，并按照蓄力进度倍率比例提升获得消除得分。",
		skill_id = 1005,
		exclusion = {
			1006
		},
		unlock_stage_id = {
			5
		},
		params_1 = {
			{
				1,
				0
			},
			{
				2,
				2
			},
			{
				3,
				5
			},
			{
				4,
				9
			},
			{
				5,
				11
			},
			{
				6,
				14
			},
			{
				7,
				17
			},
			{
				8,
				19
			},
			{
				9,
				24
			},
			{
				10,
				24
			},
			{
				11,
				24
			},
			{
				12,
				24
			},
			{
				13,
				24
			}
		},
		params_2 = {},
		Params_3 = {
			7
		}
	},
	[1006] = {
		name = "连频整合",
		type = 1,
		desc = "每当触发消除时倍率增加，并将<color=#F48800>倒计时持续时间刷新至10秒</color>，倒计时结束后倍率恢复；\n当触发消除时，按照倍率比例提升获得消除得分。",
		skill_id = 1006,
		exclusion = {
			1005
		},
		unlock_stage_id = {
			6
		},
		params_1 = {
			{
				1,
				0
			},
			{
				2,
				1
			},
			{
				3,
				2
			},
			{
				4,
				3
			},
			{
				5,
				4
			}
		},
		params_2 = {
			10
		},
		Params_3 = {
			10
		}
	},
	[1009] = {
		name = "锁定投放",
		type = 1,
		desc = "每三个回合后可以<color=#F48800>锁定</color>一个方块，此后三回合内右侧将<color=#F48800>仅生成选定的方块</color>。\n使用能力后刷新计数。",
		skill_id = 1009,
		exclusion = {},
		unlock_stage_id = {
			40805
		},
		params_1 = {
			3,
			999,
			3
		},
		params_2 = {},
		Params_3 = {}
	},
	[1010] = {
		name = "数据填充",
		type = 1,
		desc = "每三个回合<color=#F48800>没有触发消除</color>时，生成2*3的<color=#F48800>彩色</color>（彩色可以替代任意颜色）方块，可以<color=#F48800>放置到任意位置</color>。",
		skill_id = 1010,
		exclusion = {},
		unlock_stage_id = {
			40806
		},
		params_1 = {
			3
		},
		params_2 = {
			4,
			1,
			17
		},
		Params_3 = {}
	},
	[1011] = {
		name = "同色相消",
		type = 1,
		desc = "当消除一行<color=#F48800>同色方块</color>时，该颜色的其他方块<color=#F48800>连同所在行的所有方块</color>一起消除（列同理）。",
		skill_id = 1011,
		exclusion = {},
		unlock_stage_id = {
			40808
		},
		params_1 = {},
		params_2 = {},
		Params_3 = {}
	},
	[1012] = {
		name = "奖励时间！",
		type = 2,
		desc = "奥义开启后，积分倍率直接增长到<color=#F48800>25</color>，并提高生成规则形状方块的概率。\n完成一次消除后奥义结束。",
		skill_id = 1012,
		exclusion = {},
		unlock_stage_id = {
			40803
		},
		params_1 = {
			1,
			2,
			3
		},
		params_2 = {
			20,
			5
		},
		Params_3 = {}
	},
	all = {
		1001,
		1002,
		1003,
		1004,
		1005,
		1006,
		1009,
		1010,
		1011,
		1012
	}
}
