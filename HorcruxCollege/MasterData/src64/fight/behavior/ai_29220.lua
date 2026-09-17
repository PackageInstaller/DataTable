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
			param = "oponent"
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
			param = "oponent"
		},
		{
			{
				{
					operator = ">=",
					method = "check_targetpool_in_area",
					param = {
						center = 0,
						count = 1,
						left = 0,
						right = 150
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 400,
						condition = "nearest"
					}
				},
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
			{
				{
					{
						operator = ">=",
						method = "check_targetpool_in_area",
						param = {
							center = 0,
							count = 3,
							left = 0,
							right = 300
						}
					},
					{
						method = "lock_target_in_area",
						param = {
							area = 300,
							condition = "middle"
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
						method = "lock_target_by_condition",
						param = "damage_highest"
					},
					{
						yield = true,
						method = "useSkill",
						param = {
							id = "skill1",
							cfg = "skill3"
						}
					},
					type = "sequence"
				},
				type = "selector"
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
						}
					},
					{
						{
							method = "move_forward",
							yield = true
						}
					},
					type = "selector"
				}
			},
			{
				{
					{
						method = "lock_target_by_condition",
						param = "nearest"
					},
					{
						param = "max_range",
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
									left = 150,
									right = 150
								}
							},
							{
								{
									{
										operator = ">",
										method = "random",
										param = {
											num = 5,
											range = 10
										}
									},
									{
										param = "attack3",
										yield = true,
										method = "useSkill"
									}
								},
								{
									{
										param = "attack4",
										yield = true,
										method = "useSkill"
									}
								},
								type = "selector"
							}
						},
						{
							{
								{
									operator = ">",
									method = "random",
									param = {
										num = 5,
										range = 10
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
									param = "attack2",
									yield = true,
									method = "useSkill"
								}
							},
							type = "selector"
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
			type = "selector"
		},
		type = "sequence"
	}
}
