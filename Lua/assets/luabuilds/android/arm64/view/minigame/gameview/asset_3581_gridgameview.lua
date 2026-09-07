local GridGameView = class("GridGameView", import("..BaseMiniGameView"))
local var_0_1 = "battle-boss-4"
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_5 = 70
local var_0_12 = "event grid combo"
local var_0_13 = "event grid trigger"
local var_0_14 = "event move role"
local var_0_15 = "event add score"
local var_0_16 = "event role special"
local var_0_17 = "event special end"
local var_0_18 = "event camera in"
local var_0_19 = "event camedra out"
local var_0_20 = "event ignore time"
local var_0_21 = {
	power_grid = 0,
	grid_index = 0,
	special_time = false,
	special_complete = false
}
local var_0_22 = {
	{
		index = 1,
		name = "red",
		max = 800
	},
	{
		index = 2,
		name = "yellow",
		max = 800
	},
	{
		index = 3,
		name = "blue",
		max = 800
	}
}
local var_0_23 = 0.2
local var_0_24 = 50
local var_0_25 = 3
local var_0_26 = 150
local var_0_27 = 500
local var_0_28 = 300
local var_0_29 = 50
local var_0_30 = 4000
local var_0_31 = 1
local var_0_32 = 3
local var_0_33 = {
	1,
	2
}
local var_0_34 = {
	1,
	2,
	3
}
local var_0_35 = {
	{
		1,
		3
	},
	{
		2,
		3
	},
	{
		1,
		2
	},
	{
		2,
		1
	},
	{
		1,
		3
	},
	{
		2,
		3
	},
	{
		1,
		2
	}
}
local var_0_36 = Vector2(0, 0)
local var_0_37 = 0.07
local var_0_38 = 0.3
local var_0_39 = 0.5
local var_0_40 = 5
local var_0_44 = {
	c_Skill_1 = "c_Skill_1",
	n_Neutral = "n_Neutral",
	n_Combine = "n_Combine",
	n_Skill_2 = "n_Skill_2",
	n_MoveL = "n_MoveL",
	n_Atk = "n_Atk",
	c_MoveR = "c_MoveR",
	n_MoveR = "n_MoveR",
	c_Neutral = "c_Neutral",
	n_Skill_1 = "n_Skill_1",
	c_MoveL = "c_MoveL",
	c_Dmg = "c_Dmg",
	n_Skill_3 = "n_Skill_3",
	n_DMG = "n_DMG",
	c_Atk = "c_Atk"
}
local var_0_45 = {
	n_Move_R = {
		time = 0,
		anim_name = var_0_44.n_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_44.n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = var_0_44.n_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_44.n_Skill_1
	},
	n_Skill_2 = {
		sound_trigger = "guangjian",
		time = 0,
		anim_name = var_0_44.n_Skill_2,
		over_offset = Vector3(0, 0),
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(300, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Skill_3 = {
		sound_trigger = "baozha1",
		time = 0,
		anim_name = var_0_44.n_Skill_3
	},
	n_Combine = {
		camera = true,
		sound_start = "bianshen",
		time = 0,
		anim_name = var_0_44.n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = var_0_44.n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(-50, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = var_0_44.n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = var_0_44.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = var_0_44.n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_44.c_Atk,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(500, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Skill_1 = {
		camera = true,
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_44.c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = var_0_44.c_Dmg,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(-50, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = var_0_44.c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = var_0_44.c_MoveL,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = var_0_44.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = var_0_44.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = var_0_44.c_Neutral
	}
}
local var_0_46 = {
	c_Skill_1 = "c_Skill_1",
	n_Neutral = "n_Neutral",
	n_Combine = "n_Combine",
	n_Skill_2 = "n_Skill_2",
	n_MoveL = "n_MoveL",
	n_Atk = "n_Atk",
	c_MoveR = "c_MoveR",
	n_MoveR = "n_MoveR",
	c_Neutral = "c_Neutral",
	n_Skill_1 = "n_Skill_1",
	c_MoveL = "c_MoveL",
	c_Dmg = "c_DMG",
	n_Skill_3 = "n_Skill_3",
	n_DMG = "n_DMG",
	c_Atk = "c_ATK"
}
local var_0_47 = {
	n_Move_R = {
		time = 0,
		anim_name = var_0_46.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(500, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_46.n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = var_0_46.n_MoveL,
		move = {
			time = 0.4,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Skill_1 = {
		sound_trigger = "baozha1",
		time = 0,
		anim_name = var_0_46.n_Skill_1,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0)
		}
	},
	n_Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_46.n_Skill_2
	},
	n_Skill_3 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_46.n_Skill_3,
		over_offset = Vector3(247, 2),
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(350, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Combine = {
		camera = true,
		sound_start = "bianshen",
		time = 0,
		anim_name = var_0_46.n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = var_0_46.n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(-50, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = var_0_46.n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = var_0_46.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = var_0_46.n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_46.c_Atk,
		move = {
			time = 0.4,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Skill_1 = {
		camera = true,
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_46.c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = var_0_46.c_Dmg,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(-50, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = var_0_46.c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = var_0_46.c_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = var_0_46.c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = var_0_46.c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = var_0_46.c_Neutral
	}
}
local var_0_48 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_49 = {
	Move_R = {
		time = 0,
		anim_name = var_0_48.MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(500, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_48.Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Move_L = {
		time = 0,
		anim_name = var_0_48.MoveL,
		move = {
			time = 0.4,
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_48.Skill_1
	},
	Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_48.Skill_2,
		over_offset = Vector2(115, 0)
	},
	DMG = {
		time = 0,
		anim_name = var_0_48.DMG,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(-50, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_Back_R = {
		time = 0,
		anim_name = var_0_48.MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_S = {
		time = 0,
		anim_name = var_0_48.DMG
	},
	Neutral = {
		time = 0,
		anim_name = var_0_48.Neutral
	}
}
local var_0_50 = {
	{
		index = 1,
		name = "role1",
		skill = {
			{
				name = "normalAtk",
				power_index = 0,
				special_time = false,
				atk_index = 1,
				score = {
					100,
					100
				},
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.n_Atk,
					var_0_45.n_Move_L
				}
			},
			{
				name = "skill1",
				power_index = 1,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					1
				},
				actions = {
					var_0_45.n_Skill_1
				}
			},
			{
				name = "skill2",
				power_index = 2,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					2
				},
				actions = {
					var_0_45.n_Skill_2,
					var_0_45.n_Move_L
				}
			},
			{
				name = "skill3",
				power_index = 3,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					3
				},
				actions = {
					var_0_45.n_Skill_3
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.n_DMG,
					var_0_45.n_DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMGS",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.n_DMG_S
				}
			},
			{
				special_end = true,
				name = "special_end",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.n_DMG_Back_R
				}
			},
			{
				special_trigger = true,
				name = "Combine",
				power_index = 0,
				anim_bool = "special",
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.n_Combine
				}
			},
			{
				name = "AtkS",
				power_index = 0,
				special_time = true,
				atk_index = 1,
				score = {
					300,
					300
				},
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.c_Atk,
					var_0_45.c_MoveL
				}
			},
			{
				name = "Skill1S",
				power_index = 1,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					1
				},
				actions = {
					var_0_45.c_Skill_1
				}
			},
			{
				name = "Skill1S",
				power_index = 2,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					2
				},
				actions = {
					var_0_45.c_Skill_1
				}
			},
			{
				name = "Skill1S",
				power_index = 3,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					3
				},
				actions = {
					var_0_45.c_Skill_1
				}
			},
			{
				dmg_index = 2,
				name = "cDmg",
				power_index = 0,
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.c_Dmg,
					var_0_45.c_DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "cDmgS",
				power_index = 0,
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_45.c_Dmg_S
				}
			}
		},
		actions = var_0_45
	},
	{
		index = 2,
		name = "role2",
		skill = {
			{
				name = "normalAtk",
				power_index = 0,
				special_time = false,
				atk_index = 1,
				score = {
					100,
					100
				},
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.n_Atk,
					var_0_47.n_Move_L
				}
			},
			{
				name = "skill1",
				power_index = 1,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					1
				},
				actions = {
					var_0_47.n_Move_R,
					var_0_47.n_Skill_1,
					var_0_47.n_Move_L
				}
			},
			{
				name = "skill2",
				power_index = 2,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					2
				},
				actions = {
					var_0_47.n_Skill_2
				}
			},
			{
				name = "skill3",
				power_index = 3,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					3
				},
				actions = {
					var_0_47.n_Skill_3,
					var_0_47.n_Move_L
				}
			},
			{
				dmg_index = 2,
				name = "n_DMG",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.n_DMG,
					var_0_47.n_DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "n_DMGS",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.n_DMG_S
				}
			},
			{
				special_end = true,
				name = "special_end",
				power_index = 0,
				special_time = false,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.n_DMG_Back_R
				}
			},
			{
				special_trigger = true,
				name = "Combine",
				power_index = 0,
				anim_bool = "special",
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.n_Combine
				}
			},
			{
				name = "AtkS",
				power_index = 0,
				special_time = true,
				atk_index = 1,
				score = {
					200,
					200
				},
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.c_Atk,
					var_0_47.c_MoveL
				}
			},
			{
				name = "Skill1S",
				power_index = 1,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					1
				},
				actions = {
					var_0_47.c_Skill_1
				}
			},
			{
				name = "Skill1S",
				power_index = 2,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					2
				},
				actions = {
					var_0_47.c_Skill_1
				}
			},
			{
				name = "Skill1S",
				power_index = 3,
				special_time = true,
				atk_index = 2,
				score = {
					1000,
					1000
				},
				grid_index = {
					3
				},
				actions = {
					var_0_47.c_Skill_1
				}
			},
			{
				dmg_index = 2,
				name = "c_Dmg",
				power_index = 0,
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.c_Dmg,
					var_0_47.c_DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "c_DmgS",
				power_index = 0,
				special_time = true,
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_47.c_Dmg_S
				}
			}
		},
		actions = var_0_47
	},
	{
		index = 3,
		name = "enemy1",
		skill = {
			{
				name = "normalAtk",
				power_index = 0,
				special_time = false,
				atk_index = 1,
				score = {
					100,
					100
				},
				grid_index = {
					1,
					2,
					3
				},
				actions = {
					var_0_49.Atk,
					var_0_49.Move_L
				}
			},
			{
				name = "skill1",
				power_index = 1,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					1
				},
				actions = {
					var_0_49.Skill_1
				}
			},
			{
				name = "skill2",
				power_index = 2,
				special_time = false,
				atk_index = 2,
				score = {
					500,
					500
				},
				grid_index = {
					2,
					3
				},
				actions = {
					var_0_49.Move_R,
					var_0_49.Skill_2,
					var_0_49.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_49.DMG,
					var_0_49.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_49.DMG_S
				}
			}
		},
		actions = var_0_49
	}
}

local function var_0_51(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = 12
	local var_1_2 = 0.3
	local var_1_3 = Vector2(138, 150)
	local var_1_4 = 2500
	local var_1_5 = 0
	local var_1_6 = 100
	local var_1_7 = {
		{
			index = 1,
			name = "red"
		},
		{
			index = 2,
			name = "yellow"
		},
		{
			index = 3,
			name = "blue"
		}
	}

	function var_1_0:ctor()
		self._boxTf = arg_1_0
		self._event = arg_1_1
		self._gridEffect = findTF(self._boxTf, "effectGrid")
		self._content = findTF(self._boxTf, "viewport/content")
		self.tplGrid = findTF(arg_1_0, "tplGrid")

		setActive(self.tplGrid, false)

		self.grids = {}
		self.effects = {}
		self.combo = 0

		for iter_2_0 = 1, var_1_1 do
			local var_2_0 = tf(instantiate(self._gridEffect))

			setParent(var_2_0, self._content)
			setActive(var_2_0, false)

			var_2_0.anchoredPosition = Vector2(var_1_3.x * iter_2_0 - var_1_3.x / 2, var_1_3.y / 2)

			table.insert(self.effects, var_2_0)
		end

		return
	end

	function var_1_0:start()
		self.nextCheck = false

		self:initGrids(false)

		for iter_3_0 = 1, #self.effects do
			setActive(self.effects[iter_3_0], false)
		end

		return
	end

	function var_1_0:step()
		if self.takeAwayTime and self.takeAwayTime > 0 then
			self.takeAwayTime = self.takeAwayTime - Time.deltaTime

			return
		end

		self.gridCreateIndex = 1

		local var_4_0 = false

		for iter_4_0 = 1, #self.grids do
			local var_4_1 = iter_4_0

			if not self.grids[iter_4_0].checkAble then
				var_4_0 = var_4_0 or true

				local var_4_2 = (iter_4_0 - 1) * var_1_3.x

				if (iter_4_0 - 1) * var_1_3.x < self.grids[iter_4_0].tf.anchoredPosition.x then
					self.grids[iter_4_0].tf.anchoredPosition = Vector2(self.grids[iter_4_0].tf.anchoredPosition.x - self.grids[iter_4_0].speed * Time.deltaTime, 0)

					if self.grids[iter_4_0].speed < var_1_4 then
						self.grids[iter_4_0].speed = self.grids[iter_4_0].speed + var_1_6
					end
				end

				if var_4_2 >= self.grids[iter_4_0].tf.anchoredPosition.x then
					self.grids[iter_4_0].speed = 0
					self.grids[iter_4_0].checkAble = true

					if var_4_2 > self.grids[iter_4_0].tf.anchoredPosition.x then
						self.grids[iter_4_0].tf.anchoredPosition = Vector2(var_4_2, 0)
					end
				end
			end

			if not self.grids[iter_4_0].eventAble then
				GetComponent(self.grids[iter_4_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
					if self.nextCheck == false then
						local var_5_0, var_5_1 = self:triggerDownGrid(var_4_1)

						if #var_5_0 >= 2 then
							self.nextCheck = true

							self:takeAwayGrid(var_5_0)
							self:insertGrids()
							self._event:emit(var_0_12, {
								series = #var_5_0,
								combo = self.combo,
								index = var_5_1
							})

							self.combo = self.combo + 1
						else
							self.nextCheck = true

							self:takeAwayGrid({
								var_4_1
							})
							self:insertGrids()
						end
					end

					return
				end)

				self.grids[iter_4_0].eventAble = true
			end
		end

		if not var_4_0 and self.nextCheck then
			local var_4_3 = self:getSeriesGrids()

			if #var_4_3 > 0 then
				local var_4_4 = {}

				for iter_4_1 = 1, #var_4_3 do
					for iter_4_2 = 1, #var_4_3[iter_4_1].series do
						table.insert(var_4_4, var_4_3[iter_4_1].series[iter_4_2])
					end

					self._event:emit(var_0_12, {
						series = #var_4_3[iter_4_1].series,
						combo = self.combo,
						index = var_4_3[iter_4_1].gridIndex
					})
				end

				self:clearGridSeriesAble()
				self:takeAwayGrid(var_4_4)
				self:insertGrids()

				self.nextCheck = true
				self.combo = self.combo + 1
			else
				self.nextCheck = false

				if not var_0_21.special_time then
					self.combo = 0
				end
			end
		end

		return
	end

	function var_1_0:clear()
		for iter_6_0 = 1, #self.grids do
			if self.grids[iter_6_0].tf then
				destroy(self.grids[iter_6_0].tf)
			end
		end

		self.grids = {}
		self.gridCreateIndex = 1

		return
	end

	function var_1_0:clearGridSeriesAble()
		for iter_7_0 = 1, #self.grids do
			if self.grids[iter_7_0].seriesAble then
				self.grids[iter_7_0].seriesAble = false
			end
		end

		return
	end

	function var_1_0:getSeriesGrids()
		local var_8_0 = {}
		local var_8_1
		local var_8_2 = {}

		for iter_8_0 = 1, #self.grids do
			if not var_8_1 then
				var_8_1 = self.grids[iter_8_0].index

				table.insert(var_8_2, iter_8_0)
			elseif var_8_1 == self.grids[iter_8_0].index then
				table.insert(var_8_2, iter_8_0)

				if #var_8_2 >= 3 and iter_8_0 == #self.grids and self:checkSeriesAble(var_8_2) then
					table.insert(var_8_0, {
						series = var_8_2,
						gridIndex = var_8_1
					})
				end
			elseif var_8_1 ~= self.grids[iter_8_0].index then
				if #var_8_2 >= 3 and self:checkSeriesAble(var_8_2) then
					table.insert(var_8_0, {
						series = var_8_2,
						gridIndex = var_8_1
					})
				end

				var_8_2 = {}
				var_8_1 = self.grids[iter_8_0].index

				table.insert(var_8_2, iter_8_0)
			end
		end

		return var_8_0
	end

	function var_1_0:checkSeriesAble(arg_9_1)
		for iter_9_0 = 1, #arg_9_1 do
			if self.grids[arg_9_1[iter_9_0]].seriesAble then
				return true
			end
		end

		return false
	end

	function var_1_0:insertGrids()
		for iter_10_0 = 1, var_1_1 - #self.grids do
			table.insert(self.grids, (self:createGridData()))
		end

		if self:checkGridsSeries() then
			self:instiateGrids(true)
		else
			self:initGrids(true)
		end

		self:changeAbleGrids()

		return
	end

	function var_1_0:changeAbleGrids()
		for iter_11_0 = 1, #self.grids do
			self.grids[iter_11_0].checkAble = false
			self.grids[iter_11_0].eventAble = false
			self.grids[iter_11_0].speed = var_1_5
		end

		return
	end

	function var_1_0:takeAwayGrid(arg_12_1)
		table.sort(arg_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0 <= arg_13_1
		end)

		self.takeAwayTime = var_1_2

		local var_12_0 = {}

		if arg_12_1[1] - 1 > 0 then
			self.grids[arg_12_1[1] - 1].seriesAble = true
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

		for iter_12_0 = #arg_12_1, 1, -1 do
			table.insert(var_12_0, table.remove(self.grids, arg_12_1[iter_12_0]))
			setActive(self.effects[arg_12_1[iter_12_0]], false)
			setActive(self.effects[arg_12_1[iter_12_0]], true)
		end

		for iter_12_1 = 1, #var_12_0 do
			destroy(var_12_0[iter_12_1].tf)

			var_12_0[iter_12_1] = 0
		end

		return
	end

	function var_1_0:triggerDownGrid(arg_14_1)
		local var_14_0 = {
			arg_14_1
		}

		if not self.grids[arg_14_1] then
			return var_14_0, 0
		end

		for iter_14_0 = arg_14_1 - 1, 1, -1 do
			if self.grids[arg_14_1].index == self.grids[iter_14_0].index then
				table.insert(var_14_0, iter_14_0)
			else
				break
			end
		end

		for iter_14_1 = arg_14_1 + 1, #self.grids do
			if self.grids[arg_14_1].index == self.grids[iter_14_1].index then
				table.insert(var_14_0, iter_14_1)
			else
				break
			end
		end

		table.sort(var_14_0, function(arg_15_0, arg_15_1)
			return arg_15_0 <= arg_15_1
		end)

		return var_14_0, self.grids[arg_14_1].index
	end

	function var_1_0:initGrids(arg_16_1)
		self:clear()

		for iter_16_0 = 1, var_1_1 do
			table.insert(self.grids, (self:createGridData()))
		end

		if self:checkGridsSeries() then
			self:instiateGrids(arg_16_1)
		else
			self:initGrids(arg_16_1)
		end

		self.nextCheck = false

		return
	end

	function var_1_0:instiateGrids(arg_17_1)
		for iter_17_0 = 1, #self.grids do
			local var_17_0 = self.grids[iter_17_0]

			if not self.grids[iter_17_0].tf then
				local var_17_1 = tf(instantiate(self.tplGrid))

				SetParent(var_17_1, self._content)
				setActive(var_17_1, true)
				setActive(findTF(var_17_1, var_17_0.name), true)

				var_17_1.anchoredPosition = Vector2(arg_17_1 and (var_1_1 + self.gridCreateIndex - 1) * var_1_3.x or (self.gridCreateIndex - 1) * var_1_3.x, 0)
				self.gridCreateIndex = self.gridCreateIndex + 1
				var_17_0.tf = var_17_1
			end
		end

		return
	end

	function var_1_0.createGridData(arg_18_0, arg_18_1)
		local var_18_0

		if arg_18_1 then
			var_18_0 = Clone(var_1_7[arg_18_1])
		end

		local var_18_1

		do
			var_18_0 = Clone(var_1_7[math.random(1, #var_1_7)])
			var_18_1 = {
				checkAble = false,
				eventAble = false,
				speed = var_1_5
			}
		end

		var_18_1.index = var_18_0.index
		var_18_1.name = var_18_0.name

		return var_18_1
	end

	function var_1_0.checkGridsSeries(arg_19_0)
		return true
	end

	var_1_0:ctor()

	return var_1_0
end

local var_0_52 = false

local function var_0_53(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {
		ctor = function(self)
			self._specialTf = arg_20_0
			self._successTf = arg_20_1
			self._effectSuccess = findTF(self._successTf, "effectSuccess")
			self._event = arg_20_2

			self._event:bind(var_0_12, function(arg_22_0, arg_22_1, arg_22_2)
				self:addPowerAmount(arg_22_1.index, self:getPowerAmount(arg_22_1.series, arg_22_1.combo))

				return
			end)

			self.powers = {}

			for iter_21_0 = 1, #var_0_22 do
				table.insert(self.powers, {
					active = false,
					tf = findTF(self._specialTf, var_0_22[iter_21_0].name),
					index = var_0_22[iter_21_0].index,
					max = var_0_22[iter_21_0].max,
					cur = var_0_22[iter_21_0].cur
				})
			end

			self.success = {
				cur = 0,
				slider = GetComponent(findTF(self._successTf, "box"), typeof(Slider)),
				max = var_0_30
			}

			return
		end,
		start = function(self)
			for iter_23_0 = 1, #self.powers do
				self.powers[iter_23_0].cur = 0
				self.powers[iter_23_0].active = false
			end

			self.success.cur = 0
			self.success.active = false

			setActive(self._effectSuccess, false)
			self:resetSpecialData()
			self:step()

			return
		end,
		step = function(self)
			for iter_24_0 = 1, #self.powers do
				if self.powers[iter_24_0].active and self.powers[iter_24_0].cur > 0 then
					self.powers[iter_24_0].cur = self.powers[iter_24_0].cur - var_0_27 * Time.deltaTime

					if self.powers[iter_24_0].cur <= 0 then
						self.powers[iter_24_0].active = false
						self.powers[iter_24_0].cur = 0
					end
				end

				if self.powers[iter_24_0].cur > 0 then
					GetComponent(self.powers[iter_24_0].tf, typeof(Slider)).value = self.powers[iter_24_0].cur / self.powers[iter_24_0].max or 0
				end
			end

			if self.success.active and self.success.cur > 0 and var_0_21.special_complete then
				self.success.cur = self.success.cur - var_0_28 * Time.deltaTime

				if self.success.cur <= 0 then
					self.success.active = false
					self.success.cur = 0

					self._event:emit(var_0_17)
				end
			end

			if self.success.cur >= self.success.max or self.success.active then
				setActive(self._effectSuccess, true)
			else
				setActive(self._effectSuccess, false)
			end

			if self.success.cur > 0 then
				self.success.slider.value = self.success.cur / self.success.max or 0
			end

			var_0_21.special_time = self.success.active
			var_0_21.grid_index = 0

			return
		end,
		clear = function(arg_25_0)
			return
		end,
		updateSpecialData = function(self, arg_26_1)
			var_0_21.special_time = self.success.active
			var_0_21.grid_index = arg_26_1
			var_0_21.power_grid = 0

			for iter_26_0 = 1, #self.powers do
				if self.powers[iter_26_0].index == arg_26_1 and self.powers[iter_26_0].cur == self.powers[iter_26_0].max then
					var_0_21.power_grid = self.powers[iter_26_0].index
				end
			end

			self._event:emit(var_0_13)

			return
		end,
		resetSpecialData = function(arg_27_0)
			var_0_21.special_complete = false

			return
		end,
		addPowerAmount = function(self, arg_28_1, arg_28_2)
			local var_28_0 = self:getPowerByIndex(arg_28_1)

			if self.success and not self.success.active then
				self.success.cur = self.success.cur + arg_28_2

				if self.success.cur >= self.success.max then
					self.success.cur = self.success.max

					if not isActive(self._effectSuccess) then
						setActive(self._effectSuccess, true)
					end

					self.success.active = true
					var_0_21.special_complete = false

					self._event:emit(var_0_16)
				end
			end

			if var_28_0 and not var_28_0.active then
				var_28_0.cur = var_28_0.cur + arg_28_2

				if var_28_0.cur >= var_28_0.max then
					var_28_0.cur = var_28_0.max
					var_28_0.active = true
				end
			end

			if arg_28_2 > 0 then
				self:updateSpecialData(arg_28_1)
			end

			return
		end,
		getPowerByIndex = function(self, arg_29_1)
			for iter_29_0 = 1, #self.powers do
				if self.powers[iter_29_0].index == arg_29_1 then
					return self.powers[iter_29_0]
				end
			end

			return nil
		end,
		getPowerAmount = function(arg_30_0, arg_30_1, arg_30_2)
			if arg_30_1 <= 2 then
				return var_0_29
			end

			return (var_0_26 + (arg_30_1 - var_0_25) * var_0_24) * (1 + arg_30_2 * var_0_23)
		end
	}

	var_20_0:ctor()

	return var_20_0
end

local function var_0_54(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {}
	local var_31_1 = {
		{
			rate = 0.05,
			source = "scene_background/bg01"
		},
		{
			rate = 0.1,
			source = "scene_background/bg02"
		},
		{
			rate = 0.2,
			source = "scene_background/bg03"
		},
		{
			rate = 0.8,
			source = "scene_background/bg04"
		},
		{
			rate = 1.2,
			source = "scene_front/bg05"
		},
		{
			rate = 1,
			source = "scene/rolePos"
		}
	}

	function var_31_0:ctor()
		self._sceneTf = arg_31_0
		self._event = arg_31_2
		self.bgs = {}
		self._gameTf = arg_31_1
		self._box = findTF(self._gameTf, "box")
		self._specialPower = findTF(self._gameTf, "specialPower")
		self._successPower = findTF(self._gameTf, "successPower")
		self._top = findTF(self._gameTf, "top")

		for iter_32_0 = 1, #var_31_1 do
			table.insert(self.bgs, {
				tf = findTF(self._sceneTf, var_31_1[iter_32_0].source),
				rate = var_31_1[iter_32_0].rate
			})
		end

		self._bgBackCanvas = GetComponent(findTF(self._sceneTf, "scene_background"), typeof(CanvasGroup))
		self._bgFrontCanvas = GetComponent(findTF(self._sceneTf, "scene_front"), typeof(CanvasGroup))
		self._bgBeamCanvas = GetComponent(findTF(self._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

		self._event:bind(var_0_14, function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_1[2] and -1 or 1

			if not self.inCamera then
				self:setTargetFllow(Vector2(var_33_0 * arg_33_1[1].x / 10, var_33_0 * arg_33_1[1].y / 10), arg_33_1[3])
			end

			return
		end)
		self._event:bind(var_0_18, function(arg_34_0, arg_34_1, arg_34_2)
			self.inCamera = true

			self:setTargetFllow(Vector2(550, 100))
			self:setBeam(false)

			return
		end)
		self._event:bind(var_0_19, function(arg_35_0, arg_35_1, arg_35_2)
			self:setTargetFllow(Vector2(0, 0), function()
				return
			end, true)
			self:setBeam(true)

			self.inCamera = false

			return
		end)

		return
	end

	function var_31_0:start()
		self.targetVec = Vector2(var_0_36.x, var_0_36.y)
		self.currentVec = Vector2(var_0_36.x, var_0_36.y)

		for iter_37_0 = 1, #self.bgs do
			self.bgs[iter_37_0].tf.anchoredPosition = Vector2(self.currentVec.x * self.bgs[iter_37_0].rate, self.currentVec.y * self.bgs[iter_37_0].rate)
		end

		self._bgBackCanvas.alpha = 1
		self._bgFrontCanvas.alpha = 1
		self._bgBeamCanvas.alpha = 0

		setActive(self._box, true)
		setActive(self._specialPower, true)
		setActive(self._successPower, true)
		setActive(self._top, true)

		return
	end

	function var_31_0:clear()
		if LeanTween.isTweening(go(self._sceneTf)) then
			LeanTween.cancel(go(self._sceneTf), false)
		end

		return
	end

	function var_31_0:step()
		local var_39_0 = 0
		local var_39_1 = 0

		if self.targetVec.x ~= self.currentVec.x then
			var_39_0 = (self.targetVec.x - self.currentVec.x) * var_0_37

			if math.abs((self.targetVec.x - self.currentVec.x) * var_0_37) < var_0_38 then
				var_39_0 = var_0_38 * math.sign(var_39_0)
			end

			self.currentVec.x = self.currentVec.x + var_39_0

			if math.abs(self.currentVec.x - self.targetVec.x) <= var_0_38 then
				self.currentVec.x = self.targetVec.x
			end
		end

		if self.targetVec.y ~= self.currentVec.y then
			var_39_1 = (self.targetVec.y - self.currentVec.y) * var_0_37

			if math.abs((self.targetVec.y - self.currentVec.y) * var_0_37) < var_0_38 then
				var_39_1 = var_0_38 * math.sign(var_39_1)
			end

			self.currentVec.y = self.currentVec.y + var_39_1

			if math.abs(self.currentVec.y - self.targetVec.y) <= var_0_38 then
				self.currentVec.y = self.targetVec.y
			end
		end

		if var_39_0 ~= 0 or var_39_1 ~= 0 then
			self:moveTo(self.currentVec)
		end

		return
	end

	function var_31_0:moveTo(arg_40_1)
		for iter_40_0 = 1, #self.bgs do
			self.bgs[iter_40_0].tf.anchoredPosition = Vector2(arg_40_1.x * self.bgs[iter_40_0].rate, arg_40_1.y * self.bgs[iter_40_0].rate)
		end

		return
	end

	function var_31_0:setTargetFllow(arg_41_1, arg_41_2, arg_41_3)
		if not arg_41_3 then
			self.targetVec = arg_41_1
			self.moveCallback = arg_41_2
		else
			self.currentVec = arg_41_1
			self.targetVec = arg_41_1

			self:moveTo(arg_41_1)

			if arg_41_2 then
				arg_41_2()
			end
		end

		return
	end

	function var_31_0:setBeam(arg_42_1, arg_42_2)
		if LeanTween.isTweening(go(self._sceneTf)) then
			LeanTween.cancel(go(self._sceneTf), false)
		end

		if arg_42_1 then
			setActive(self._box, true)
			setActive(self._specialPower, true)
			setActive(self._successPower, true)
			setActive(self._top, true)
		else
			setActive(self._box, false)
			setActive(self._specialPower, false)
			setActive(self._successPower, false)
			setActive(self._top, false)
		end

		LeanTween.value(go(self._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_43_0)
			if arg_42_1 then
				self._bgBackCanvas.alpha = arg_43_0
				self._bgFrontCanvas.alpha = arg_43_0
				self._bgBeamCanvas.alpha = 1 - arg_43_0
			else
				self._bgBackCanvas.alpha = 1 - arg_43_0
				self._bgFrontCanvas.alpha = 1 - arg_43_0
				self._bgBeamCanvas.alpha = arg_43_0
			end

			return
		end)):setOnComplete(System.Action(function()
			if arg_42_2 then
				arg_42_2()
			end

			return
		end))

		return
	end

	var_31_0:ctor()

	return var_31_0
end

local function var_0_55(arg_45_0, arg_45_1)
	local var_45_0 = {
		ctor = function(self)
			self._scene = arg_45_0
			self._tpl = findTF(self._scene, "tpl")
			self._leftRolePos = findTF(self._scene, "rolePos/leftRole")
			self._rightRolePos = findTF(self._scene, "rolePos/rightRole")
			self._event = arg_45_1

			self._event:bind(var_0_13, function()
				self:onGridTrigger()

				return
			end)
			self._event:bind(var_0_16, function()
				self:onRoleSpecial()

				return
			end)
			self._event:bind(var_0_17, function()
				self:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(self)
			if self.leftRole then
				destroy(self.leftRole.tf)

				self.leftRole = nil
			end

			if self.rightRole then
				destroy(self.rightRole.tf)

				self.rightRole = nil
			end

			self.leftRole = self:createRole(var_0_31, true, self._leftRolePos)
			self.rightRole = self:createRole(var_0_32, false, self._rightRolePos)
			self.leftRole.targetRole = self.rightRole
			self.rightRole.targetRole = self.leftRole

			self.leftRole.animator:SetTrigger("idle")
			self.leftRole.animator:SetBool("special", false)
			self.rightRole.animator:SetTrigger("idle")
			self.rightRole.animator:SetBool("special", false)

			self.leftRole.specialBody = false
			self.rightRole.specialBody = false
			self.leftRole.anchoredPosition = Vector2(0, 0)
			self.rightRole.anchoredPosition = Vector2(0, 0)
			self.leftRole.specialTime = false
			self.rightRole.specialTime = false
			self.playingDatas = {}
			self.playingDatas[self.leftRole.name] = {
				role = self.leftRole
			}
			self.playingDatas[self.leftRole.name].skillDatas = {}
			self.playingDatas[self.rightRole.name] = {
				role = self.rightRole
			}
			self.playingDatas[self.rightRole.name].skillDatas = {}
			self.skillDeltaTime = 0
			self.emptySkillTime = math.random(1, 2)
			self.addScore = {
				0,
				0
			}

			self._event:emit(var_0_14, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(self)
			self:checkSkillDeltaTime()
			self:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(self)
			if self.skillDeltaTime and self.skillDeltaTime <= 0 then
				self.skillDeltaTime = var_0_39
			end

			self.skillDeltaTime = self.skillDeltaTime - Time.deltaTime

			if self.skillDeltaTime <= 0 then
				local var_52_0 = false

				for iter_52_0, iter_52_1 in pairs(self.playingDatas) do
					if iter_52_1.inPlaying then
						var_52_0 = true
					end
				end

				if not var_52_0 then
					for iter_52_2, iter_52_3 in pairs(self.playingDatas) do
						if #iter_52_3.skillDatas > 0 then
							if iter_52_3.role == self.leftRole then
								print("开始执行角色攻击")
							end

							self:applySkillData(iter_52_3)

							break
						end
					end
				end
			end

			var_0_52 = false

			for iter_52_4, iter_52_5 in pairs(self.playingDatas) do
				if iter_52_5.inPlaying then
					var_0_52 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(self)
			if self.emptySkillTime and self.emptySkillTime <= 0 then
				self.emptySkillTime = var_0_40
			end

			self.emptySkillTime = self.emptySkillTime - Time.deltaTime

			if self.emptySkillTime <= 0 then
				local var_53_0 = false

				for iter_53_0, iter_53_1 in pairs(self.playingDatas) do
					if iter_53_1.inPlaying then
						var_53_0 = true
					end
				end

				if not var_53_0 then
					local var_53_1 = self:getRoleEmptySkill(self.rightRole)

					if var_53_1 then
						self:addRolePlaying(self.rightRole, var_53_1)
					end
				end
			end

			return
		end,
		getRoleEmptySkill = function(arg_54_0, arg_54_1)
			local var_54_0 = {}

			for iter_54_0 = 1, #arg_54_1.skill do
				if tobool(arg_54_1.skill[iter_54_0].special_time) == arg_54_1.specialBody and arg_54_1.skill[iter_54_0].atk_index then
					table.insert(var_54_0, arg_54_1.skill[iter_54_0])
				end
			end

			if #var_54_0 > 0 then
				return Clone(var_54_0[math.random(1, #var_54_0)])
			end

			return nil
		end,
		onRoleSpecial = function(self)
			self.leftRole.specialTime = true

			for iter_55_0 = 1, #self.leftRole.skill do
				if self.leftRole.skill[iter_55_0].special_trigger then
					self:addRolePlaying(self.leftRole, Clone(self.leftRole.skill[iter_55_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(self)
			self.leftRole.specialTime = false

			for iter_56_0 = 1, #self.leftRole.skill do
				if not self.leftRole.skill[iter_56_0].special_trigger and self.leftRole.skill[iter_56_0].special_end then
					self:addRolePlaying(self.leftRole, Clone(self.leftRole.skill[iter_56_0]))
				end
			end

			return
		end,
		clear = function(self)
			if LeanTween.isTweening(go(self._leftRolePos)) then
				LeanTween.cancel(go(self._leftRolePos))
			end

			if LeanTween.isTweening(go(self._rightRolePos)) then
				LeanTween.cancel(go(self._rightRolePos))
			end

			if LeanTween.isTweening(go(self.rightRole.tf)) then
				LeanTween.cancel(go(self.rightRole.tf))
			end

			if LeanTween.isTweening(go(self.leftRole.tf)) then
				LeanTween.cancel(go(self.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(self)
			for iter_58_0 = 1, #self.leftRole.skill do
				if tobool(self.leftRole.skill[iter_58_0].special_time) == tobool(self.leftRole.specialTime) and self.leftRole.skill[iter_58_0].power_index == var_0_21.power_grid and table.contains(self.leftRole.skill[iter_58_0].grid_index, var_0_21.grid_index) and self.leftRole.skill[iter_58_0].atk_index then
					self:addRolePlaying(self.leftRole, Clone(self.leftRole.skill[iter_58_0]))
				end
			end

			return
		end,
		createRole = function(self, arg_59_1, arg_59_2, arg_59_3)
			local var_59_0 = self:getRoleData(arg_59_1)

			if not var_59_0 then
				return nil
			end

			local var_59_1 = {}
			local var_59_2 = tf(instantiate(findTF(self._tpl, var_59_0.name)))

			SetParent(var_59_2, arg_59_3)

			var_59_2.anchoredPosition = Vector2(0, 0)
			var_59_2.localScale = Vector3(1, 1, 1)

			setActive(var_59_2, true)

			local var_59_3 = findTF(var_59_2, "body")
			local var_59_4 = findTF(var_59_3, "anim")
			local var_59_5 = GetComponent(var_59_4, typeof(DftAniEvent))

			var_59_5:SetStartEvent(function()
				if var_59_1.startCallback then
					var_59_1.startCallback()
				end

				return
			end)
			var_59_5:SetTriggerEvent(function()
				if var_59_1.triggerCallback then
					var_59_1.triggerCallback()
				end

				return
			end)
			var_59_5:SetEndEvent(function()
				if var_59_1.endCallback then
					var_59_1.endCallback()
				end

				return
			end)

			var_59_1.name = var_59_0.name
			var_59_1.tf = var_59_2
			var_59_1.canvasGroup = GetComponent(var_59_2, typeof(CanvasGroup))
			var_59_1.body = var_59_3
			var_59_1.animTf = var_59_4
			var_59_1.animator = GetComponent(var_59_4, typeof(Animator))
			var_59_1.dftEvent = var_59_5
			var_59_1.startCallback = nil
			var_59_1.triggerCallback = nil
			var_59_1.endCallback = nil
			var_59_1.skill = var_59_0.skill
			var_59_1.name = var_59_0.name
			var_59_1.index = var_59_0.index
			var_59_1.actions = var_59_0.actions

			return var_59_1
		end,
		getRoleData = function(arg_63_0, arg_63_1)
			for iter_63_0 = 1, #var_0_50 do
				if var_0_50[iter_63_0].index == arg_63_1 then
					return Clone(var_0_50[iter_63_0])
				end
			end

			return nil
		end,
		setDftHandle = function(arg_64_0, arg_64_1, arg_64_2, arg_64_3, arg_64_4)
			arg_64_1.startCallback = arg_64_2
			arg_64_1.triggerCallback = arg_64_3
			arg_64_1.endCallback = arg_64_4

			return
		end,
		playAnimation = function(arg_65_0, arg_65_1, arg_65_2)
			print(arg_65_1.name .. " 执行动画 ：" .. arg_65_2 .. "  active:" .. tostring(arg_65_1.animator.isActiveAndEnabled) .. tostring(Time.GetTimestamp()))
			arg_65_1.animator:Play("emptyAnimation", -1, 0)
			arg_65_1.animator:Play(arg_65_2, -1, 0)

			return
		end,
		addRolePlaying = function(self, arg_66_1, arg_66_2, arg_66_3)
			for iter_66_0, iter_66_1 in pairs(self.playingDatas) do
				if iter_66_0 == arg_66_1.name then
					if arg_66_3 then
						self:applySkillData(iter_66_1, arg_66_2)
					else
						table.insert(iter_66_1.skillDatas, arg_66_2)

						if arg_66_2.power_index > 0 and arg_66_2.atk_index > 1 or arg_66_2.special_trigger then
							for iter_66_2 = #iter_66_1.skillDatas - 1, 1, -1 do
								if iter_66_1.skillDatas[iter_66_2].power_index == 0 and iter_66_1.skillDatas[iter_66_2].atk_index == 1 then
									local var_66_0 = table.remove(iter_66_1.skillDatas, iter_66_2)

									if var_66_0.score then
										self.addScore = {
											self.addScore[1] + var_66_0.score[1],
											self.addScore[2] + var_66_0.score[2]
										}
									end
								end
							end
						end
					end
				end
			end

			return
		end,
		applySkillData = function(self, arg_67_1, arg_67_2)
			arg_67_1.inPlaying = true

			local var_67_0 = arg_67_2 or table.remove(arg_67_1.skillDatas, 1)

			arg_67_1.currentSkill = var_67_0
			arg_67_1.actions = var_67_0.actions

			if var_67_0.anim_bool then
				arg_67_1.role.animator:SetBool(var_67_0.anim_bool, true)
			end

			if arg_67_1.role == self.leftRole and not var_67_0.dmg_index then
				self._leftRolePos:SetSiblingIndex(1)
			elseif arg_67_1.role == self.rightRole and not var_67_0.dmg_index then
				self._rightRolePos:SetSiblingIndex(1)
			end

			if var_67_0.special_end then
				arg_67_1.role.specialBody = false
			elseif var_67_0.special_trigger then
				arg_67_1.role.specialBody = true
			end

			arg_67_1.actionIndex = 1

			self:checkAction(arg_67_1, function()
				arg_67_1.inPlaying = false

				print(arg_67_1.role.name .. "动画播放完毕")

				return
			end)

			return
		end,
		checkAction = function(self, arg_69_1, arg_69_2)
			if arg_69_1.actions and arg_69_1.actionIndex <= #arg_69_1.actions then
				print("准备执行" .. arg_69_1.actions[arg_69_1.actionIndex].anim_name .. "上一个动作:" .. tostring(arg_69_1.playingAction and arg_69_1.playingAction.anim_name))

				arg_69_1.playingAction = arg_69_1.actions[arg_69_1.actionIndex]
				arg_69_1.actionIndex = arg_69_1.actionIndex + 1

				local var_69_1 = arg_69_1.playingAction.anim_name
				local var_69_2 = arg_69_1.playingAction.time
				local var_69_3 = arg_69_1.playingAction.move
				local var_69_4 = arg_69_1.playingAction.over_offset
				local var_69_5 = arg_69_1.playingAction.camera
				local var_69_6 = arg_69_1.playingAction.sound_start
				local var_69_7 = arg_69_1.playingAction.sound_trigger
				local var_69_8 = arg_69_1.playingAction.sound_end

				if arg_69_1.currentSkill.special_trigger or arg_69_1.currentSkill.special_time and arg_69_1.currentSkill.atk_index and arg_69_1.currentSkill.atk_index >= 2 then
					self._event:emit(var_0_20, true)
				end

				if var_69_2 and var_69_2 > 0 then
					-- block empty
				else
					self:setDftHandle(arg_69_1.role, function()
						if var_69_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_6)
						end

						if var_69_3 then
							self:moveRole(arg_69_1.role, var_69_3)
						end

						if var_69_5 then
							arg_69_1.role.targetRole.canvasGroup.alpha = 0

							self._event:emit(var_0_18)
						end

						return
					end, function()
						if var_69_7 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_7)
						end

						if var_69_5 then
							var_69_5 = false
							arg_69_1.role.targetRole.canvasGroup.alpha = 1

							self._event:emit(var_0_19)
						elseif arg_69_1.currentSkill.atk_index then
							local var_71_0 = self:getRoleDmgData(arg_69_1.role.targetRole, arg_69_1.currentSkill.atk_index)

							if var_71_0 then
								self:addRolePlaying(arg_69_1.role.targetRole, Clone(var_71_0), true)
							end

							local var_71_1 = arg_69_1.currentSkill.score

							if arg_69_1.currentSkill.score and arg_69_1.role == self.leftRole then
								self._event:emit(var_0_15, math.random(var_71_1[1] + self.addScore[1], var_71_1[2] + self.addScore[2]))

								self.addScore = {
									0,
									0
								}
							end
						end

						return
					end, function()
						if var_69_8 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_8)
						end

						if LeanTween.isTweening(go(arg_69_1.role.tf)) then
							LeanTween.cancel(go(arg_69_1.role.tf))
						end

						self._event:emit(var_0_20, false)

						if var_69_4 then
							arg_69_1.role.tf.anchoredPosition = Vector2(arg_69_1.role.tf.anchoredPosition.x + var_69_4.x, arg_69_1.role.tf.anchoredPosition.y + var_69_4.y)
						end

						if arg_69_1.currentSkill.special_trigger and var_0_21.special_time and not var_0_21.special_complete then
							var_0_21.special_complete = true
						end

						arg_69_1.playingAction = nil

						self:setDftHandle(arg_69_1.role, nil, nil, nil)
						print(arg_69_1.role.name .. "执行 " .. var_69_1 .. "结束")
						self:checkAction(arg_69_1, arg_69_2)

						return
					end)
					self:playAnimation(arg_69_1.role, var_69_1)
				end
			else
				if arg_69_1.role == self.leftRole then
					print(arg_69_1.role.name .. "队列结束")
				end

				if arg_69_2 then
					arg_69_2()
				end
			end

			return
		end,
		moveRole = function(self, arg_73_1, arg_73_2)
			if LeanTween.isTweening(go(arg_73_1.tf)) then
				LeanTween.cancel(go(arg_73_1.tf))
			end

			self._event:emit(var_0_14, {
				arg_73_2.distance,
				arg_73_1 == self.leftRole
			})
			LeanTween.move(arg_73_1.tf, Vector3(arg_73_2.distance.x, arg_73_2.distance.y, 0), arg_73_2.time):setEase(arg_73_2.ease or LeanTweenType.linear)

			return
		end,
		getRoleDmgData = function(arg_74_0, arg_74_1, arg_74_2)
			for iter_74_0 = 1, #arg_74_1.skill do
				if arg_74_1.skill[iter_74_0].dmg_index == arg_74_2 and arg_74_1.skill[iter_74_0].special_time == tobool(arg_74_1.specialBody) then
					return arg_74_1.skill[iter_74_0]
				end
			end

			return nil
		end
	}

	var_45_0:ctor()

	return var_45_0
end

function GridGameView:getUIName()
	return "GridGameUI"
end

function GridGameView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function GridGameView:initEvent()
	self:bind(var_0_15, function(arg_78_0, arg_78_1, arg_78_2)
		self:addScore(arg_78_1)

		return
	end)
	self:bind(var_0_20, function(arg_79_0, arg_79_1, arg_79_2)
		self.ignoreTime = arg_79_1

		return
	end)

	return
end

function GridGameView:onEventHandle(arg_80_1)
	return
end

function GridGameView:initData()
	local var_81_0 = Application.targetFrameRate or 60

	if var_81_0 > 60 then
		var_81_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_81_0, -1)

	return
end

function GridGameView:initUI()
	self.backSceneTf = findTF(self._tf, "scene_background")
	self.sceneTf = findTF(self._tf, "scene")
	self.clickMask = findTF(self._tf, "clickMask")

	setText(findTF(self._tf, "ui/gameUI/top/time"), i18n("mini_game_time"))
	setText(findTF(self._tf, "ui/gameUI/top/scoreDesc"), i18n("mini_game_score"))
	setText(findTF(self._tf, "pop/LeaveUI/ad/desc"), i18n("mini_game_leave"))
	setText(findTF(self._tf, "pop/pauseUI/ad/desc"), i18n("mini_game_pause"))
	setText(findTF(self._tf, "pop/SettleMentUI/ad/currentTextDesc"), i18n("mini_game_cur_score"))
	setText(findTF(self._tf, "pop/SettleMentUI/ad/highTextDesc"), i18n("mini_game_high_score"))

	self.countUI = findTF(self._tf, "pop/CountUI")
	self.countAnimator = GetComponent(findTF(self.countUI, "count"), typeof(Animator))
	self.countDft = GetOrAddComponent(findTF(self.countUI, "count"), typeof(DftAniEvent))

	self.countDft:SetTriggerEvent(function()
		return
	end)
	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:gameStart()

		return
	end)

	self.leaveUI = findTF(self._tf, "pop/LeaveUI")

	onButton(self, findTF(self.leaveUI, "ad/btnOk"), function()
		self:resumeGame()
		self:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.leaveUI, "ad/btnCancel"), function()
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.pauseUI = findTF(self._tf, "pop/pauseUI")

	onButton(self, findTF(self.pauseUI, "ad/btnOk"), function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_CANCEL)

	self.settlementUI = findTF(self._tf, "pop/SettleMentUI")

	onButton(self, findTF(self.settlementUI, "ad/btnOver"), function()
		setActive(self.settlementUI, false)
		self:openMenuUI()

		return
	end, SFX_CANCEL)

	self.selectedUI = findTF(self._tf, "pop/selectedUI")
	self.leftSelectRole = {}

	for iter_83_0 = 1, #var_0_33 do
		local var_83_0 = findTF(self.selectedUI, "ad/leftRole/role" .. var_0_33[iter_83_0])
		local var_83_1 = var_0_33[iter_83_0]

		onButton(self, var_83_0, function()
			if var_0_32 == var_83_1 then
				var_0_32 = var_0_31
			end

			var_0_31 = var_83_1

			self:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(self.leftSelectRole, {
			id = var_0_33[iter_83_0],
			tf = var_83_0
		})
	end

	onButton(self, findTF(self.selectedUI, "close"), function()
		setActive(self.selectedUI, false)

		return
	end, SFX_CANCEL)

	self.rightSelectRole = {}

	for iter_83_1 = 1, #var_0_34 do
		local var_83_2 = findTF(self.selectedUI, "ad/rightRole/role" .. var_0_34[iter_83_1])
		local var_83_3 = var_0_34[iter_83_1]

		onButton(self, var_83_2, function()
			if var_0_31 == var_83_3 then
				var_0_31 = var_0_32

				if not table.contains(var_0_33, var_0_31) then
					for iter_92_0, iter_92_1 in ipairs(var_0_33) do
						if iter_92_1 ~= var_83_3 then
							var_0_31 = iter_92_1
						end
					end
				end
			end

			var_0_32 = var_83_3

			self:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(self.rightSelectRole, {
			id = var_0_34[iter_83_1],
			tf = var_83_2
		})
	end

	onButton(self, findTF(self.selectedUI, "ad/btnOk"), function()
		setActive(self.selectedUI, false)
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CONFIRM)
	setActive(self.selectedUI, false)

	self.menuUI = findTF(self._tf, "pop/menuUI")
	self.battleScrollRect = GetComponent(findTF(self.menuUI, "battList"), typeof(ScrollRect))
	self.totalTimes = self:getGameTotalTime()

	scrollTo(self.battleScrollRect, 0, 1 - (self:getGameUsedTimes() - 4 < 0 and 0 or self:getGameUsedTimes() - 4) / (self.totalTimes - 4))
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowUp"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y + 1 / (self.totalTimes - 4) > 1 or nil) and 1)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "rightPanelBg/arrowDown"), function()
		scrollTo(self.battleScrollRect, 0, (self.battleScrollRect.normalizedPosition.y - 1 / (self.totalTimes - 4) < 0 or nil) and 0)

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnBack"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, findTF(self.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ssss_game_tip.tip
		})

		return
	end, SFX_CONFIRM)
	onButton(self, findTF(self.menuUI, "btnStart"), function()
		local var_98_0 = self:getGameUsedTimes() or 0
		local var_98_1 = self:getGameTimes() or 0

		if var_98_0 >= #var_0_35 and self.selectedUI then
			self:updateSelectedUI()
			setActive(self.selectedUI, true)
		else
			var_0_31 = var_0_35[((var_98_0 == 0 and 1 or var_98_1 > 0 and var_98_0 + 1 or var_98_0) > #var_0_35 or nil) and #var_0_35][1]
			var_0_32 = var_0_35[((var_98_0 == 0 and 1 or var_98_1 > 0 and var_98_0 + 1 or var_98_0) > #var_0_35 or nil) and #var_0_35][2]

			setActive(self.menuUI, false)
			self:readyStart()
		end

		return
	end, SFX_CONFIRM)

	local var_83_4 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}
	self.dropItems = {}

	for iter_83_2 = 1, 7 do
		local var_83_5 = tf(instantiate(var_83_4))

		var_83_5.name = "battleItem_" .. iter_83_2

		setParent(var_83_5, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/gridgameui_atlas", "battleDesc" .. iter_83_2, function(arg_99_0)
			setImageSprite(findTF(var_83_5, "state_open/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_clear/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_current/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_closed/buttomDesc"), arg_99_0, true)

			return
		end)
		setActive(var_83_5, true)
		table.insert(self.battleItems, var_83_5)
	end

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function GridGameView:initGameUI()
	self.gameUI = findTF(self._tf, "ui/gameUI")

	onButton(self, findTF(self.gameUI, "topRight/btnStop"), function()
		self:stopGame()
		setActive(self.pauseUI, true)

		return
	end)
	onButton(self, findTF(self.gameUI, "btnLeave"), function()
		self:stopGame()
		setActive(self.leaveUI, true)

		return
	end)

	self.gameTimeS = findTF(self.gameUI, "top/time/s")
	self.scoreTf = findTF(self.gameUI, "top/score")
	self.scoreAnimTf = findTF(self._tf, "sceneContainer/scene_front/scoreAnim")
	self.scoreAnimTextTf = findTF(self._tf, "sceneContainer/scene_front/scoreAnim/text")

	setActive(self.scoreAnimTf, false)

	return
end

function GridGameView:initController()
	self.boxController = var_0_51(findTF(self.gameUI, "box"), self)
	self.specialController = var_0_53(findTF(self.gameUI, "specialPower"), findTF(self.gameUI, "successPower"), self)
	self.bgController = var_0_54(findTF(self._tf, "sceneContainer"), self.gameUI, self)
	self.roleController = var_0_55(findTF(self._tf, "sceneContainer/scene"), self)

	return
end

function GridGameView:Update()
	self:AddDebugInput()

	return
end

function GridGameView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function GridGameView:updateSelectedUI()
	for iter_106_0 = 1, #self.leftSelectRole do
		if var_0_31 == self.leftSelectRole[iter_106_0].id then
			setActive(findTF(self.leftSelectRole[iter_106_0].tf, "selected"), true)
			setActive(findTF(self.leftSelectRole[iter_106_0].tf, "unSelected"), false)
		else
			setActive(findTF(self.leftSelectRole[iter_106_0].tf, "selected"), false)
			setActive(findTF(self.leftSelectRole[iter_106_0].tf, "unSelected"), true)
		end
	end

	for iter_106_1 = 1, #self.rightSelectRole do
		if var_0_32 == self.rightSelectRole[iter_106_1].id then
			setActive(findTF(self.rightSelectRole[iter_106_1].tf, "selected"), true)
			setActive(findTF(self.rightSelectRole[iter_106_1].tf, "unSelected"), false)
		else
			setActive(findTF(self.rightSelectRole[iter_106_1].tf, "selected"), false)
			setActive(findTF(self.rightSelectRole[iter_106_1].tf, "unSelected"), true)
		end
	end

	return
end

function GridGameView:updateMenuUI()
	local var_107_0 = self:getGameUsedTimes()

	if var_107_0 and var_107_0 >= 7 then
		setActive(findTF(self.menuUI, "btnStart/free"), true)
	else
		setActive(findTF(self.menuUI, "btnStart/free"), false)
	end

	local var_107_1 = self:getGameTimes()

	for iter_107_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_107_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_107_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_107_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_107_0], "state_current"), false)

		if iter_107_0 <= var_107_0 then
			setActive(findTF(self.battleItems[iter_107_0], "state_clear"), true)
		elseif iter_107_0 == var_107_0 + 1 and var_107_1 >= 1 then
			setActive(findTF(self.battleItems[iter_107_0], "state_current"), true)
		elseif var_107_0 < iter_107_0 and iter_107_0 <= var_107_0 + var_107_1 then
			setActive(findTF(self.battleItems[iter_107_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_107_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_107_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_107_2 > 1 then
		var_107_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_107_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_107_1 > 0)
	self:CheckGet()

	return
end

function GridGameView:CheckGet()
	setActive(findTF(self.menuUI, "got"), false)

	if self:getUltimate() and self:getUltimate() ~= 0 then
		setActive(findTF(self.menuUI, "got"), true)
	end

	if self:getUltimate() == 0 then
		if self:getGameTotalTime() > self:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = self:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(self.menuUI, "got"), true)
	end

	return
end

function GridGameView:openMenuUI()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), false)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), false)
	setActive(findTF(self._tf, "sceneContainer/scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	setActive(self.selectedUI, false)
	self:updateMenuUI()

	local var_109_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

	if self.bgm ~= var_109_0 then
		self.bgm = var_109_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_109_0)
	end

	return
end

function GridGameView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)
	setActive(self.selectedUI, false)

	return
end

function GridGameView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	if var_0_1 and self.bgm ~= var_0_1 then
		self.bgm = var_0_1

		pg.BgmMgr.GetInstance():Push(self.__cname, var_0_1)
	end

	return
end

function GridGameView:gameStart()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), true)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), true)
	setActive(findTF(self._tf, "sceneContainer/scene"), true)
	setActive(self.scoreAnimTf, false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.gameTime = var_0_5
	self.ignoreTime = false

	self.boxController:start()
	self.specialController:start()
	self.bgController:start()
	self.roleController:start()
	self:updateGameUI()
	self:timerStart()

	return
end

function GridGameView:getGameTimes()
	return self:GetMGHubData().count
end

function GridGameView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GridGameView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GridGameView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GridGameView:changeSpeed(arg_117_1)
	return
end

function GridGameView:onTimer()
	self:gameStep()

	return
end

function GridGameView:gameStep()
	if not self.ignoreTime then
		self.gameTime = self.gameTime - Time.deltaTime

		if self.gameTime < 0 then
			self.gameTime = 0
		end

		self.gameStepTime = self.gameStepTime + Time.deltaTime
	end

	self.boxController:step()
	self.specialController:step()
	self.bgController:step()
	self.roleController:step()
	self:updateGameUI()

	if self.gameTime <= 0 then
		self:onGameOver()

		return
	end

	return
end

function GridGameView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GridGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GridGameView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function GridGameView:addScore(arg_123_1)
	setActive(self.scoreAnimTf, false)
	setActive(self.scoreAnimTf, true)
	setText(self.scoreAnimTextTf, "+" .. tostring(arg_123_1))

	self.scoreNum = self.scoreNum + arg_123_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	return
end

function GridGameView:onGameOver()
	if self.settlementFlag then
		return
	end

	self:timerStop()

	self.settlementFlag = true

	setActive(self.clickMask, true)

	if self.roleController then
		self.roleController:clear()
	end

	if self.bgController then
		self.bgController:clear()
	end

	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.settlementFlag = false
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:showSettlement()

		return
	end))

	return
end

function GridGameView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_126_0 = self:GetMGData():GetRuntimeData("elements")
	local var_126_1 = self.scoreNum
	local var_126_2

	if var_126_0 and #var_126_0 > 0 then
		var_126_2 = var_126_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_126_2 < var_126_1)

	if var_126_2 <= var_126_1 then
		var_126_2 = var_126_1

		self:StoreDataToServer({
			var_126_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_126_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_126_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(0)
	end

	return
end

function GridGameView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function GridGameView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function GridGameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GridGameView.ON_BACK_PRESSED)
	else
		if self.settlementFlag then
			return
		end

		if isActive(self.pauseUI) then
			setActive(self.pauseUI, false)
		end

		self:stopGame()
		setActive(self.leaveUI, true)
	end

	return
end

function GridGameView:willExit()
	if self.handle then
		UpdateBeat:RemoveListener(self.handle)
	end

	if self._tf and LeanTween.isTweening(go(self._tf)) then
		LeanTween.cancel(go(self._tf))
	end

	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	Time.timeScale = 1
	self.timer = nil

	return
end

return GridGameView
