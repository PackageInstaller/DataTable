return {
	time = 10,
	name = "不破之盾 +",
	init_effect = "",
	picture = "",
	desc = "不破之盾",
	stack = 1,
	id = 1010392,
	icon = 10392,
	last_effect = "",
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
				count = 12,
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
					return Vector3(math.sin(arg_1_0 * 3) * 5, 0.75, math.cos(arg_1_0 * 3) * 5)
				end,
				rotationFun = function(arg_2_0)
					return Vector3(0, arg_2_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				count = 12,
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
					return Vector3(math.sin(arg_3_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 5, 0.75, math.cos(arg_3_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_2) * 5)
				end,
				rotationFun = function(arg_4_0)
					return Vector3(0, arg_4_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 210, 0)
				end
			}
		},
		{
			id = 3,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 12,
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
				centerPosFun = function(arg_5_0)
					return Vector3(math.sin(arg_5_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 5, 0.75, math.cos(arg_5_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST_4) * 5)
				end,
				rotationFun = function(arg_6_0)
					return Vector3(0, arg_6_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 20, 0)
				end
			}
		}
	}
}
