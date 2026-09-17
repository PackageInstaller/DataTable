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
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
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
	xp2 = {
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
	xp2 = {
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
	xp2_manual = {
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
	xp3 = {
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
	xp3_manual = {
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
	xp4 = {
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
	xp4_manual = {
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
	xp5 = {
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
	xp5_manual = {
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
	xp6 = {
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
	xp6_manual = {
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
	xp7 = {
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
	xp7_manual = {
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
	xp8 = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "teammate"
		},
		{
			param = 0.7,
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
	xp8_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
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
	xp9 = {
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
	xp9_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
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
	xp10 = {
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
	xp10_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
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
	xp11 = {
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
	xp11_manual = {
		{
			method = "lock_target_pool",
			param = "teammate"
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
			param = 0.8,
			operator = "<=",
			method = "check_targetpool_hp_percent"
		},
		{
			method = "lock_target_by_condition",
			param = "hp_percent_lowest"
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
			method = "lock_target_by_condition",
			param = "all"
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
