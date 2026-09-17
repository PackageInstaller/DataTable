local var_0_0 = {
	behavior = {}
}

var_0_0.behavior.xp = {
	{
		param = "xp",
		yield = true,
		method = "useSkill"
	},
	type = "sequence"
}
var_0_0.behavior.main = {
	{
		{
			{
				method = "can_xp_usable"
			},
			var_0_0.behavior.xp,
			type = "sequence"
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
				{
					{
						param = 300,
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
		type = "selector"
	},
	type = "selector"
}
var_0_0.action = {}

return var_0_0
