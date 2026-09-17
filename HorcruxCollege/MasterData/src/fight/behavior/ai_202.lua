return {
	xp_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
		},
		{
			param = "xp",
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
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 300,
				condition = "random"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "random"
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	xp1_manual = {
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
		},
		{
			param = "xp",
			yield = true,
			method = "useSkill"
		},
		type = "sequence"
	},
	xp1 = {
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
				area = 300,
				condition = "random"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 300,
				condition = "random"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 200,
				condition = "random"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 200,
				condition = "random"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_by_condition",
			param = "random"
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
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 200,
				condition = "nearest"
			}
		},
		{
			method = "lock_target_by_condition",
			param = "nearest"
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
				area = 100,
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
			param = "skill1"
		},
		{
			method = "lock_target_pool",
			param = "oponent"
		},
		{
			method = "lock_target_in_area",
			param = {
				area = 450,
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
	attack = {
		{
			method = "remove_invincible"
		},
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
			{
				{
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
						method = "move_forward",
						yield = true
					},
					type = "sequence"
				},
				type = "selector"
			},
			type = "sequence"
		},
		type = "sequence"
	}
}
