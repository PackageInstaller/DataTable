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
			{
				{
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 10,
						target = "self",
						buff = 120232003
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
						condition = "all"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_zhimang"
					}
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
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
					operator = "=",
					method = "check_target_buffcount",
					param = {
						value = 10,
						target = "self",
						buff = 120232003
					}
				},
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
						condition = "all"
					}
				},
				{
					yield = true,
					method = "useSkill",
					param = {
						id = "xp",
						cfg = "xp_zhimang"
					}
				}
			},
			{
				{
					method = "lock_target_in_area",
					param = {
						area = 500,
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
			method = "lock_target_by_condition",
			param = {
				area = 640,
				condition = "nearest"
			}
		},
		{
			{
				{
					operator = "=",
					method = "check_targetpool_in_area",
					param = {
						center = 0,
						count = 1,
						left = 320,
						right = 640
					}
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
				}
			},
			{
				{
					{
						operator = "=",
						method = "check_target_buffcount",
						param = {
							value = 1,
							target = "target",
							buff = 120232001
						}
					},
					{
						param = "skill1",
						yield = true,
						method = "useSkill"
					}
				},
				{
					{
						yield = true,
						method = "useSkill",
						param = {
							id = "skill1",
							cfg = "skill2"
						}
					}
				},
				type = "selector"
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
								value = 10,
								target = "self",
								buff = 120232003
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
							param = "attack",
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
