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
			method = "lock_target_by_condition",
			param = "all"
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
			param = "teammate"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 150,
				condition = "hp_lowest"
			}
		},
		{
			param = "skill1",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	skill2 = {
		{
			method = "can_skill_usable",
			param = "skill2"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 500,
				condition = "all"
			}
		},
		{
			param = "skill2",
			yield = true,
			method = "useSkill"
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
					param = 0,
					operator = "=",
					method = "check_attackcount"
				},
				{
					{
						{
							param = "range",
							operator = "<=",
							method = "check_target_distance"
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
							method = "move_forward",
							yield = true
						},
						type = "sequence"
					},
					type = "selector"
				},
				type = "sequence"
			},
			{
				{
					{
						param = "max_range",
						operator = "<=",
						method = "check_target_distance"
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
						method = "move_forward",
						yield = true
					},
					type = "sequence"
				},
				type = "selector"
			},
			type = "selector"
		},
		type = "sequence"
	}
}
