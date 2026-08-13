return {
	effect_list = {
		{
			id = 1,
			type = "BattleBuffShieldWall",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				effect = "shield05",
				count = 5,
				do_when_hit = "intercept",
				bulletType = 3,
				cld_list = {
					{
						box = {
							3,
							3,
							7
						},
						offset = {
							0,
							0,
							-1.3
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
	desc_get = "鱼雷防御盾",
	name = "鱼雷防御盾",
	init_effect = "",
	id = 14364,
	time = 10,
	picture = "",
	desc = "鱼雷防御盾",
	stack = 1,
	color = "red",
	icon = 14360,
	last_effect = ""
}
