return {
	time = 0,
	name = "正面装甲",
	init_effect = "",
	picture = "",
	desc = "正面装甲",
	stack = 1,
	id = 8048,
	icon = 8048,
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
				count = 30,
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
							0,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					Vector3 = var_1_10001

					return var_1_10001(4, 1.15, 0.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 192, 0)
				end
			}
		}
	}
}
