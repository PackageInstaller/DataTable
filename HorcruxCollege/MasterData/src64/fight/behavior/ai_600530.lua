return {
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
			method = "lock_target_in_area",
			param = {
				area = 640,
				condition = "damage_highest"
			}
		},
		{
			param = "skill1",
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
					param = "range",
					operator = "<=",
					method = "check_target_distance"
				},
				{
					{
						{
							operator = ">=",
							method = "check_targetpool_in_area",
							param = {
								center = 0,
								count = 1,
								left = 120,
								right = 120
							}
						},
						{
							param = "attack_tui",
							yield = true,
							method = "useSkill"
						}
					},
					{
						{
							param = "attack",
							yield = true,
							method = "useSkill"
						}
					},
					type = "selector"
				}
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
