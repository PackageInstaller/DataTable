return {
	time = 999,
	name = "肉鸽引导1 平射护盾",
	init_effect = "",
	picture = "",
	desc = "",
	stack = 1,
	id = 999981,
	icon = 999980,
	last_effect = "",
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 9999,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							15
						},
						offset = {
							2,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					Vector3 = var_1_10001

					return var_1_10001(2, -1.8, 5.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 120, 0)
				end
			}
		},
		{
			id = 2,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 9999,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							15
						},
						offset = {
							2,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_3_0)
					Vector3 = var_1_10001

					return var_1_10001(3.5, -1.8, 0.5)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 192, 0)
				end
			}
		},
		{
			id = 3,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				effect = "shield02",
				count = 9999,
				do_when_hit = "intercept",
				bulletType = 1,
				cld_list = {
					{
						box = {
							4,
							6,
							15
						},
						offset = {
							2,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_5_0)
					Vector3 = var_1_10001

					return var_1_10001(1.5, -1.8, -4.5)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 238, 0)
				end
			}
		}
	}
}
