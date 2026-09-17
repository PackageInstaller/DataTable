return {
	attack = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 200,
				condition = "all"
			}
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
					method = "wait",
					yield = true
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	}
}
