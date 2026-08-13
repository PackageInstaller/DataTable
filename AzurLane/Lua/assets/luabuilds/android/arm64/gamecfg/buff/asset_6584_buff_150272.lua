return {
	effect_list = {
		{
			type = "BattleBuffAura",
			trigger = {
				"onAttach"
			},
			arg_list = {
				friendly_fire = true,
				buff_id = 150273,
				cld_data = {
					box = {
						range = 16
					}
				}
			}
		},
		{
			id = 1,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 10,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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

					local var_1_1 = var_1_10004.sin(var_1_0) * 4
					local var_1_2 = 0.75

					math = var_6

					return var_1_10002(var_1_1, var_1_2, var_6.cos(var_1_0) * 4)
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
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 10,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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
					local var_3_0 = arg_3_0 * 3 + 2.512

					Vector3 = var_1_10002
					math = var_1_10004

					local var_3_1 = var_1_10004.sin(var_3_0) * 4
					local var_3_2 = 0.75

					math = var_6

					return var_1_10002(var_3_1, var_3_2, var_6.cos(var_3_0) * 4)
				end,
				rotationFun = function(arg_4_0)
					Vector3 = var_1_10001

					local var_4_0 = 0

					ys = var_1_10004

					return var_1_10001(var_4_0, arg_4_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST + 234, 0)
				end
			}
		},
		{
			id = 3,
			type = "BattleBuffDamageWall",
			trigger = {
				"onStack",
				"onUpdate"
			},
			arg_list = {
				damage = 10,
				effect = "shield06",
				count = 6,
				attack_attribute = 1,
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
					local var_5_0 = arg_5_0 * 3 - 2.512

					Vector3 = var_1_10002
					math = var_1_10004

					local var_5_1 = var_1_10004.sin(var_5_0) * 4
					local var_5_2 = 0.75

					math = var_6

					return var_1_10002(var_5_1, var_5_2, var_6.cos(var_5_0) * 4)
				end,
				rotationFun = function(arg_6_0)
					Vector3 = var_1_10001

					local var_6_0 = 0

					ys = var_1_10004

					return var_1_10001(var_6_0, arg_6_0 * var_1_10004.Battle.BattleConfig.SHIELD_ROTATE_CONST - 54, 0)
				end
			}
		},
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onUpdate"
			},
			arg_list = {
				minTargetNumber = 1,
				skill_id = 150273,
				quota = 1,
				target = "TargetSelf",
				check_target = {
					"TargetAllHelp",
					"TargetShipTag"
				},
				ship_tag_list = {
					"fagebujixiang1"
				}
			}
		},
		{
			type = "BattleBuffAddBuff",
			trigger = {
				"onRemove"
			},
			arg_list = {
				buff_id = 150274
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
	desc_get = "",
	name = "",
	init_effect = "",
	id = 150272,
	time = 15,
	picture = "",
	desc = "",
	stack = 1,
	color = "yellow",
	icon = 150270,
	last_effect = ""
}
