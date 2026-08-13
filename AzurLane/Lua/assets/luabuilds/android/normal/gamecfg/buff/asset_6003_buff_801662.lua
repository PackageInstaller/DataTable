return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
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
							0,
							0,
							0
						}
					}
				},
				centerPosFun = function(arg_1_0)
					Vector3 = var_1_10001

					return var_1_10001(3, -1.8, 0.5)
				end,
				rotationFun = function(arg_2_0)
					Vector3 = var_1_10001

					return var_1_10001(0, 192, 0)
				end
			}
		}
	},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	{},
	time = 10,
	name = "",
	init_effect = "",
	id = 801662,
	picture = "",
	desc = "",
	stack = 1,
	color = "blue",
	icon = 801660,
	last_effect = ""
}
