return {
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
			method = "lock_target_by_attr",
			param = {
				area = 150,
				condition = "nearest"
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
				area = 1000,
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
	skill3 = {
		{
			method = "can_skill_usable",
			param = "skill3"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_attr",
			param = {
				area = 100,
				condition = "nearest"
			}
		},
		{
			param = "skill3",
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
