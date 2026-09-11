return {
	{
		name = "同花顺",
		id = 1,
		desc = "3张点数连续，且花色相同的牌（A 2 3、9 10 A 也视为顺子）",
		base_value = {
			100,
			6
		},
		grow_value = {
			50,
			3
		},
		example = {
			{
				1,
				6
			},
			{
				1,
				7
			},
			{
				1,
				8
			}
		}
	},
	{
		name = "三条",
		id = 2,
		desc = "3张点数相同的牌",
		base_value = {
			60,
			6
		},
		grow_value = {
			30,
			3
		},
		example = {
			{
				2,
				7
			},
			{
				3,
				7
			},
			{
				1,
				7
			}
		}
	},
	{
		name = "同花",
		id = 3,
		desc = "3张花色相同的牌",
		base_value = {
			35,
			4
		},
		grow_value = {
			15,
			2
		},
		example = {
			{
				3,
				3
			},
			{
				3,
				5
			},
			{
				3,
				10
			}
		}
	},
	{
		name = "顺子",
		id = 4,
		desc = "3张点数连续的牌（A 2 3、9 10 A 也视为顺子）",
		base_value = {
			30,
			4
		},
		grow_value = {
			15,
			2
		},
		example = {
			{
				3,
				5
			},
			{
				1,
				6
			},
			{
				4,
				7
			}
		}
	},
	{
		name = "对子",
		id = 5,
		desc = "2-3张包含2张点数相同的牌",
		base_value = {
			20,
			2
		},
		grow_value = {
			10,
			1
		},
		example = {
			{
				4,
				8
			},
			{
				3,
				8
			},
			{
				4,
				3
			}
		}
	},
	{
		name = "高牌",
		id = 6,
		desc = "1-3张不构成上述牌型的牌",
		base_value = {
			10,
			2
		},
		grow_value = {
			10,
			1
		},
		example = {
			{
				4,
				11
			},
			{
				2,
				2
			},
			{
				3,
				8
			}
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6
	}
}
