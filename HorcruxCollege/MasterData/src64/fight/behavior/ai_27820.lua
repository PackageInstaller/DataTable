return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_by_condition",
			param = "hp_percent_lowest"
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
			param = "teammate"
		},
		{
			method = "lock_target_by_condition",
			param = "hp_percent_lowest"
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
			method = "lock_target_in_area",
			param = {
				area = 380,
				condition = "all"
			}
		},
		{
			{
				{
					method = "check_unit_order",
					param = 0
				},
				{
					param = "skill1",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_fly"
					}
				},
				type = "sequence"
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
						{
							{
								method = "lock_target_pool",
								param = "teammate"
							},
							{
								param = 0.8,
								operator = "<=",
								method = "check_targetpool_hp_percent"
							},
							{
								{
									{
										method = "check_unit_order",
										param = 0
									},
									{
										method = "lock_target_pool",
										param = "teammate"
									},
									{
										method = "lock_target_by_condition",
										param = "hp_percent_lowest"
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
										method = "lock_target_pool",
										param = "teammate"
									},
									{
										method = "lock_target_by_condition",
										param = "hp_percent_lowest"
									},
									{
										param = "attack2-fly",
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
								method = "lock_target_pool",
								param = "oponent"
							},
							{
								{
									{
										method = "check_unit_order",
										param = 0
									},
									{
										method = "lock_target_pool",
										param = "oponent"
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
										method = "lock_target_pool",
										param = "oponent"
									},
									{
										param = "attack-fly",
										yield = true,
										method = "useSkill"
									},
									type = "sequence"
								},
								type = "selector"
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
			type = "selector"
		},
		type = "sequence"
	}
}
