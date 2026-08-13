local var_0_0 = {
	time = 4,
	name = "崩姐",
	init_effect = "",
	picture = "",
	desc = "概率触发",
	stack = 1,
	id = 10132,
	icon = 10130,
	last_effect = ""
}
local var_0_1 = {}

SYSTEM_SCENARIO = var_0_10002
var_0_1[1] = var_0_10002
SYSTEM_ROUTINE = var_0_10002
var_0_1[2] = var_0_10002
SYSTEM_SHAM = var_0_10002
var_0_1[3] = var_0_10002
SYSTEM_CHALLENGE = var_0_10002
var_0_1[4] = var_0_10002
var_0_0.limit = var_0_1
var_0_0.effect_list = {
	{
		type = "BattleBuffCastSkill",
		trigger = {
			"onAttach"
		},
		arg_list = {
			rant = 3000,
			target = "TargetSelf",
			skill_id = 10130
		}
	}
}
var_0_0[1] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 3000,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[2] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 3330,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[3] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 3660,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[4] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 3990,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[5] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 4320,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[6] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 4650,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[7] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 4980,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[8] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 5310,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[9] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 5640,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}
var_0_0[10] = {
	effect_list = {
		{
			type = "BattleBuffCastSkill",
			trigger = {
				"onAttach"
			},
			arg_list = {
				rant = 6000,
				target = "TargetSelf",
				skill_id = 10130
			}
		}
	}
}

return var_0_0
