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
				area = 500,
				condition = "farest"
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
				area = 500,
				condition = "farest"
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
			method = "lock_target_by_attr",
			param = {
				area = 200,
				condition = "nearest"
			}
		},
		{
			{
				{
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 0,
						target = "self",
						buff = 112012732
					}
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
						cfg = "skill2"
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
					param = "range",
					operator = "<=",
					method = "check_target_distance"
				},
				{
					{
						{
							operator = "=",
							method = "check_target_buffcount",
							param = {
								value = 0,
								target = "self",
								buff = 112012732
							}
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
							param = "attack2",
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
