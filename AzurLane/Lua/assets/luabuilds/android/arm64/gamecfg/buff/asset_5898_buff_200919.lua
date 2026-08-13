return {
	time = 0,
	name = "2024阿尔萨斯活动 重巡护盾",
	init_effect = "",
	id = 200919,
	picture = "",
	desc = "",
	stack = 1,
	color = "yellow",
	icon = 200919,
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
				count = 8,
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
					Vector3 = var_1_10001

					return var_1_10001(3, 0.75, 4.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 140, 0)
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
				count = 8,
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
					Vector3 = var_1_10001

					return var_1_10001(3, 0.75, -0.5)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					return var_1_10001(0, -140, 0)
				end
			}
		}
	}
}
