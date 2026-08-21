return {
	time = 20,
	name = "构建者护盾",
	init_effect = "",
	picture = "",
	desc = "构建者护盾",
	stack = 1,
	id = 8677,
	icon = 18100,
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
				count = 15,
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
					return Vector3(math.sin(arg_1_0 * 3) * 4, -0.5, math.cos(arg_1_0 * 3) * 4 + 5)
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
				count = 15,
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
					return Vector3(math.sin(arg_3_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST) * 4, -0.5, math.cos(arg_3_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST) * 4 + 5)
				end,
				rotationFun = function(arg_4_0)
					return Vector3(0, arg_4_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST - 90, 0)
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
				count = 15,
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
					return Vector3(math.cos(arg_5_0 * 3) * 6, -0.5, math.sin(arg_5_0 * 3) * 6 + 5)
				end,
				rotationFun = function(arg_6_0)
					return Vector3(0, -arg_6_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 180, 0)
				end
			}
		},
		{
			id = 4,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 15,
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
				centerPosFun = function(arg_7_0)
					return Vector3(math.cos(arg_7_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST) * 6, -0.5, math.sin(arg_7_0 * 3 + ys.Battle.BattleConfig.SHIELD_CENTER_CONST) * 6 + 5)
				end,
				rotationFun = function(arg_8_0)
					return Vector3(0, -arg_8_0 * ys.Battle.BattleConfig.SHIELD_ROTATE_CONST + 0, 0)
				end
			}
		}
	}
}
