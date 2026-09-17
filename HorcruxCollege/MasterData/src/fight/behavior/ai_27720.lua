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
			operator = "=",
			method = "check_target_buffcount",
			param = {
				value = 0,
				target = "self",
				buff = 12772002
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
			{
				{
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 12772002
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_back"
					}
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 250,
						condition = "all"
					}
				},
				{
					param = "xp",
					yield = true,
					method = "useSkill"
				}
			},
			type = "selector"
		}
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
				area = 350,
				condition = "nearest"
			}
		},
		{
			{
				{
					operator = ">=",
					method = "check_target_buffcount",
					param = {
						value = 1,
						target = "self",
						buff = 12772002
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "skill1",
						cfg = "skill1_xp"
					}
				}
			},
			{
				param = "skill1",
				yield = true,
				method = "useSkill"
			},
			type = "selector"
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
							operator = "=",
							method = "check_target_buffcount",
							param = {
								value = 0,
								target = "self",
								buff = 12772002
							}
						},
						{
							{
								{
									operator = "%",
									method = "check_attackcount",
									param = {
										4,
										3
									}
								},
								{
									param = "attack2",
									yield = true,
									method = "useSkill"
								}
							},
							{
								{
									param = "attack1",
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
								operator = "%",
								method = "check_attackcount",
								param = {
									4,
									1
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
								operator = "%",
								method = "check_attackcount",
								param = {
									4,
									2
								}
							},
							{
								param = "attack5",
								yield = true,
								method = "useSkill"
							}
						},
						{
							{
								operator = "%",
								method = "check_attackcount",
								param = {
									4,
									3
								}
							},
							{
								param = "attack6",
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
