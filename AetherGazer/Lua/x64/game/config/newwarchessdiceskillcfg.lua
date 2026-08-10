return {
	{
		description = "将选中的骰子<color=#FF9500>重新投掷</color>",
		simple_description = "重掷骰子",
		name = "数据重置",
		use_limit = 10,
		id = 1,
		icon = "skill_1",
		dice_type = 7
	},
	{
		description = "将选中的骰子骰子点数<color=#FF9500>-1</color>",
		simple_description = "骰子点数-1",
		name = "余数递减",
		use_limit = 5,
		id = 2,
		icon = "skill_7",
		dice_type = 12
	},
	{
		description = "将2个骰子组合",
		simple_description = "将<color=#FF9500>2</color>个骰子组合",
		name = "扳手",
		use_limit = 5,
		id = 3,
		icon = "",
		dice_type = 8
	},
	{
		description = "将选中的骰子骰子点数<color=#FF9500>+1</color>",
		simple_description = "骰子点数+1",
		name = "可视增量",
		use_limit = 5,
		id = 4,
		icon = "skill_2",
		dice_type = 7
	},
	{
		description = "将选中的骰子进行<color=#FF9500>复制</color>，其点数必须<color=#FF9500>大于等于4</color>",
		simple_description = "复制骰子",
		name = "原型克隆",
		use_limit = 2,
		id = 5,
		icon = "skill_3",
		dice_type = 14
	},
	{
		description = "将选中的骰子骰子点数<color=#FF9500>翻倍</color>，其点数必须<color=#FF9500>小于等于3</color>",
		simple_description = "骰子点数<color=#FF9500>翻倍</color>",
		name = "量数倍增",
		use_limit = 8,
		id = 6,
		icon = "skill_6",
		dice_type = 23
	},
	{
		description = "将选中的骰子<color=#FF9500>拆分</color>成<color=#FF9500>2</color>个骰子，其点数必须<color=#FF9500>大于等于2</color>",
		simple_description = "拆分骰子",
		name = "数学拆分",
		use_limit = 3,
		id = 7,
		icon = "skill_4",
		dice_type = 12
	},
	{
		description = "重新投掷出一个点数更小的骰子",
		simple_description = "重新投掷出<color=#FF9500>1</color>个点数<color=#FF9500>更小</color>的骰子",
		name = "投掷（小）",
		use_limit = 5,
		id = 8,
		icon = "",
		dice_type = 7
	},
	{
		description = "投掷出3个1点骰子",
		simple_description = "投掷出<color=#FF9500>3</color>个<color=#FF9500>1</color>点骰子",
		name = "糟糕手气",
		use_limit = 0,
		id = 9,
		icon = "",
		dice_type = 0
	},
	{
		description = "将选中的骰子点数根据<color=#FF9500>1-6，2-5，3-4</color>进行翻转",
		simple_description = "骰子点数<color=#FF9500>翻转</color>",
		name = "对立翻转",
		use_limit = 7,
		id = 10,
		icon = "skill_5",
		dice_type = 7
	},
	{
		description = "将选中的骰子<color=#FF9500>拆分</color>成<color=#FF9500>2</color>个相等的骰子，其点数必须为<color=#FF9500>偶数</color>",
		simple_description = "等量<color=#FF9500>拆分</color>骰子",
		name = "因数分解",
		use_limit = 5,
		id = 11,
		icon = "skill_8",
		dice_type = 32
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9,
		10,
		11
	}
}
