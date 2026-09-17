return {
	xp = {
		{
			method = "can_skill_usable",
			param = "xp"
		},
		{
			{
				{
					method = "can_skill_usable",
					param = "xp"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
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
			{
				{
					method = "can_skill_usable",
					param = "xp"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 600,
						condition = "all"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp2"
					}
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 600,
				condition = "all"
			}
		},
		{
			{
				{
					param = 0.5,
					operator = "<=",
					method = "check_targetpool_hp_percent"
				},
				{
					param = "xp",
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
						id = "xp",
						cfg = "xp2"
					}
				},
				type = "sequence"
			},
			type = "selector"
		},
		type = "sequence"
	},
	skill1 = {
		{
			method = "can_skill_usable",
			param = "skill1"
		},
		{
			method = "can_skill_usable",
			param = "skill2"
		},
		{
			{
				{
					method = "can_skill_usable",
					param = "skill1"
				},
				{
					method = "lock_target_pool",
					param = "teammate"
				},
				{
					param = 0.3,
					operator = "<=",
					method = "check_targetpool_hp_percent"
				},
				{
					method = "lock_target_by_condition",
					param = "hp_percent_lowest"
				},
				{
					param = "skill2",
					yield = true,
					method = "useSkill"
				},
				type = "sequence"
			},
			{
				{
					method = "can_skill_usable",
					param = "skill1"
				},
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_attr",
					param = {
						area = 250,
						condition = "farest"
					}
				},
				{
					param = "skill1",
					yield = true,
					method = "useSkill"
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
								4,
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
							param = "attack",
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
