return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							9
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_1_0)
					local var_1_0 = arg_1_0 * 3

					Vector3 = var_1_10002
					math = var_1_10003

					local var_1_1 = var_1_10003.sin(var_1_0) * 3.5
					local var_1_2 = 0.75

					math = var_1_10005

					return var_1_10002(var_1_1, var_1_2, var_1_10005.cos(var_1_0) * 3.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					local var_2_0 = 0

					ys = var_1_10003

					return var_1_10001(var_2_0, arg_2_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
				end
			}
		},
		{
			id = 2,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 6,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							9
						},
						offset = {
							1.02,
							0,
							1.22
						}
					}
				},
				centerPosFun = function(arg_3_0)
					local var_3_0 = arg_3_0 * 3

					ys = var_1_10002

					local var_3_1 = var_3_0 + var_1_10002.Battle.BattleConfig.SHIELD_CENTER_CONST

					Vector3 = var_2
					math = var_1_10003

					local var_3_2 = var_1_10003.sin(var_3_1) * 3.5
					local var_3_3 = 0.75

					math = var_1_10005

					return var_2(var_3_2, var_3_3, var_1_10005.cos(var_3_1) * 3.5)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10003

					return var_1_10001(var_4_0, arg_4_0 * var_1_10003.Battle.BattleConfig.SHIELD_ROTATE_CONST - 90, 0)
				end
			}
		},
		{
			type = "BattleBuffCleanse",
			trigger = {
				"onRemove"
			},
			arg_list = {
				target = "TargetSelf",
				buff_id_list = {
					801542
				}
			}
		}
	},
	{
		time = 5
	},
	{
		time = 6
	},
	{
		time = 7
	},
	{
		time = 8
	},
	{
		time = 9
	},
	{
		time = 10
	},
	{
		time = 11
	},
	{
		time = 12
	},
	{
		time = 13
	},
	{
		time = 15
	},
	time = 5,
	name = "守卫之盾",
	init_effect = "",
	picture = "",
	desc = "守卫之盾",
	stack = 1,
	id = 801541,
	icon = 801540,
	last_effect = ""
}
