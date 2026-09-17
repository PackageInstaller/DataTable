return {
	xp = {
		{
			method = "can_xp_usable"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
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
			param = "oponent"
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 640,
				count = 2,
				condition = "damage_highest"
			}
		},
		{
			param = "skill1",
			yield = true,
			method = "useSkill"
		}
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
								count = 2,
								left = 0,
								right = 400
							}
						},
						{
							method = "lock_target_in_area",
							param = {
								area = 400,
								count = 2,
								condition = "nearest"
							}
						},
						{
							param = "attack",
							yield = true,
							method = "useSkill"
						}
					},
					{
						{
							method = "lock_target_in_area",
							param = {
								area = 400,
								condition = "nearest"
							}
						},
						{
							param = "attack2",
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
				}
			},
			type = "selector"
		},
		type = "sequence"
	}
}
