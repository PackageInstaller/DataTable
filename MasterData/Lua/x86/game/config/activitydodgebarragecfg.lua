return {
	{
		stage_id = 5200701,
		type = 1,
		unlock_condition = "",
		sub_activity_id = 293271,
		pre = 0,
		activity_id = 293261,
		id = 1,
		diff = 0,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200702,
		type = 1,
		unlock_condition = "",
		sub_activity_id = 293272,
		pre = 5200701,
		activity_id = 293261,
		id = 2,
		diff = 0,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200703,
		type = 1,
		unlock_condition = "",
		sub_activity_id = 293273,
		pre = 5200702,
		activity_id = 293261,
		id = 3,
		diff = 0,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200704,
		type = 1,
		unlock_condition = "",
		sub_activity_id = 293274,
		pre = 5200703,
		activity_id = 293261,
		id = 4,
		diff = 0,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200705,
		type = 1,
		unlock_condition = "",
		sub_activity_id = 293275,
		pre = 5200704,
		activity_id = 293261,
		id = 5,
		diff = 0,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200706,
		type = 2,
		unlock_condition = "",
		sub_activity_id = 293276,
		pre = 5200705,
		activity_id = 293261,
		id = 6,
		diff = 1,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200707,
		type = 2,
		unlock_condition = "",
		sub_activity_id = 293276,
		pre = 5200705,
		activity_id = 293261,
		id = 7,
		diff = 2,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	{
		stage_id = 5200708,
		type = 2,
		unlock_condition = "",
		sub_activity_id = 293276,
		pre = 5200705,
		activity_id = 293261,
		id = 8,
		diff = 3,
		targetScore = {
			1000,
			2000,
			3000
		}
	},
	get_id_list_by_stage_id = {
		[5200708] = {
			8
		},
		[5200707] = {
			7
		},
		[5200706] = {
			6
		},
		[5200705] = {
			5
		},
		[5200704] = {
			4
		},
		[5200703] = {
			3
		},
		[5200702] = {
			2
		},
		[5200701] = {
			1
		}
	},
	get_id_list_by_diff = {
		[3] = {
			8
		},
		[2] = {
			7
		},
		{
			6
		},
		[0] = {
			1,
			2,
			3,
			4,
			5
		}
	},
	all = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8
	}
}
