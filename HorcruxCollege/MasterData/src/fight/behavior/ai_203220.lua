return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 500,
				condition = "all"
			}
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 500,
				condition = "all"
			}
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill1 = {
		{
			method = "can_skill_usable",
			param = "skill1"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			{
				{
					operator = ">=",
					method = "check_targetpool_in_area",
					param = {
						center = 0,
						count = 2,
						left = 0,
						right = 500
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
						count = 2,
						condition = "farest"
					}
				},
				{
					param = "skill1",
					yield = true,
					method = "useSkill"
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
						condition = "farest"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_dan"
					}
				}
			},
			type = "selector"
		},
		type = "sequence"
	},
	attack = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "nearest"
		},
		{
			{
				{
					param = "range",
					operator = "<=",
					method = "check_target_distance"
				},
				{
					{
						{
							operator = "=",
							method = "check_target_buffcount",
							param = {
								value = 0,
								target = "target",
								buff = 112012729
							}
						},
						{
							param = "attack",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					{
						{
							param = "attack2",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					type = "selector"
				},
				type = "sequence"
			},
			{
				{
					method = "move_forward",
					yield = true
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	}
}
