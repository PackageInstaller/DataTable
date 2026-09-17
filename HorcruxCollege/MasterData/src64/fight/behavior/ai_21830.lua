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
			param = 0.8,
			operator = "<=",
			method = "check_targetpool_hp_percent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 150,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
			param = "teammate"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
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
			param = "teammate"
		},
		{
			method = "lock_target_by_condition",
			param = "all"
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
			{
				{
					{
						method = "check_character_attribute",
						param = "self:buff223015004>0"
					},
					{
						method = "lock_target_pool",
						param = "teammate"
					},
					{
						method = "lock_target_by_condition",
						param = "all"
					},
					{
						param = "range",
						operator = "<=",
						method = "check_target_distance"
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
						param = 0.9,
						operator = "<=",
						method = "check_targetpool_hp_percent"
					},
					{
						method = "lock_target_by_condition",
						param = "hp_percent_lowest"
					},
					{
						param = "range",
						operator = "<=",
						method = "check_target_distance"
					},
					{
						param = "attack2",
						yield = true,
						method = "useSkill"
					},
					type = "sequence"
				},
				type = "selector"
			},
			{
				{
					method = "lock_target_pool",
					param = "oponent"
				},
				{
					method = "lock_target_by_condition",
					param = "nearest"
				},
				{
					param = "range",
					operator = "<=",
					method = "check_target_distance"
				},
				{
					param = "attack1",
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
