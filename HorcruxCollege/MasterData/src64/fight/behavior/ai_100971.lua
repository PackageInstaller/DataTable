return {
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
							operator = "%",
							method = "check_attackcount",
							param = {
								5,
								0
							}
						},
						{
							param = "attack2",
							yield = true,
							method = "useSkill"
						},
						type = "sequence"
					},
					{
						{
							param = "attack1",
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
