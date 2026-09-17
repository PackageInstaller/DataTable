return {
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
			operator = ">=",
			method = "check_targetpool_in_area",
			param = {
				center = 100,
				count = 3,
				left = 200,
				right = 400
			}
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 300,
				condition = "farest"
			}
		},
		{
			param = "skill3",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "add_anti_hitdown"
		},
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
			method = "lock_target_by_condition",
			param = "all"
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		{
			method = "remove_anti_hitdown"
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
				area = 640,
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
			method = "lock_target_in_area",
			param = {
				area = 450,
				condition = "nearest"
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
