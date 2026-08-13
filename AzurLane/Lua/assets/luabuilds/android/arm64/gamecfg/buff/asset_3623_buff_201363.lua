return {
	init_effect = "",
	name = "2025荷兰活动 扬起郁金之旗",
	time = 10,
	stack = 1,
	id = 201363,
	picture = "",
	last_effect = "",
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				minTargetNumber = 1,
				skill_id = 201364,
				nationality = 11,
				check_target = {
					"TargetSelf",
					"TargetNationalityFriendly"
				}
			}
		},
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 3,
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
					math = var_1_10004

					local var_1_1 = var_1_10004.sin(var_1_0) * 3
					local var_1_2 = 0.75

					math = var_6

					return var_1_10002(var_1_1, var_1_2, var_6.cos(var_1_0) * 3)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					local var_2_0 = 0

					ys = var_1_10004

					return var_1_10001(var_2_0, arg_2_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 90, 0)
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
				count = 3,
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
					local var_3_0 = arg_3_0 * 3 + 3.14

					Vector3 = var_1_10002
					math = var_1_10004

					local var_3_1 = var_1_10004.sin(var_3_0) * 3
					local var_3_2 = 0.75

					math = var_6

					return var_1_10002(var_3_1, var_3_2, var_6.cos(var_3_0) * 3)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10004

					return var_1_10001(var_4_0, arg_4_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 14, 0)
				end
			}
		}
	}
}
