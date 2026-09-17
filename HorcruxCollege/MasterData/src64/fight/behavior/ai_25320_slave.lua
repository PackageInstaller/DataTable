return {
	attack = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 300,
				condition = "nearest"
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
