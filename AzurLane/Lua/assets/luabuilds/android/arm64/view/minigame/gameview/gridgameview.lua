class = var_0_10000

local var_0_0 = "GridGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "battle-boss-4"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/niujiao"
local var_0_5 = "event:/ui/taosheng"
local var_0_6 = 70
local var_0_7 = "mini_game_time"
local var_0_8 = "mini_game_score"
local var_0_9 = "mini_game_leave"
local var_0_10 = "mini_game_pause"
local var_0_11 = "mini_game_cur_score"
local var_0_12 = "mini_game_high_score"
local var_0_13 = "event grid combo"
local var_0_14 = "event grid trigger"
local var_0_15 = "event move role"
local var_0_16 = "event add score"
local var_0_17 = "event role special"
local var_0_18 = "event special end"
local var_0_19 = "event camera in"
local var_0_20 = "event camedra out"
local var_0_21 = "event ignore time"
local var_0_22 = {
	power_grid = 0,
	grid_index = 0,
	special_time = false,
	special_complete = false
}
local var_0_23 = {
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
local var_0_24 = 0.2
local var_0_25 = 50
local var_0_26 = 3
local var_0_27 = 150
local var_0_28 = 500
local var_0_29 = 300
local var_0_30 = 50
local var_0_31 = 4000
local var_0_32 = 1
local var_0_33 = 3
local var_0_34 = {
	1,
	2
}
local var_0_35 = {
	1,
	2,
	3
}
local var_0_36 = {
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

Vector2 = var_36

local var_0_37 = var_36(0, 0)
local var_0_38 = 0.07
local var_0_39 = 0.3
local var_0_40 = 0.5
local var_0_41 = 5
local var_0_42 = "sound start"
local var_0_43 = "sound trigger"
local var_0_44 = "sound end"
local var_0_45 = {
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
local var_0_46 = {}
local var_0_47 = {
	time = 0,
	anim_name = var_0_45.n_MoveR
}
local var_0_48 = {
	time = 0.3
}

Vector2 = var_0_10048
var_0_48.start = var_0_10048(0, 0)
Vector3 = var_48
var_0_48.distance = var_48(650, 0, 0)
var_0_47.move = var_0_48
var_0_46.n_Move_R = var_0_47

local var_0_49 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_45.n_Atk
}
local var_0_50 = {
	time = 0.3
}

Vector2 = var_48
var_0_50.start = var_48(0, 0)
Vector3 = var_48
var_0_50.distance = var_48(650, 0, 0)
LeanTweenType = var_48
var_0_50.ease = var_48.easeOutCirc
var_0_49.move = var_0_50
var_0_46.n_Atk = var_0_49

local var_0_51 = {
	time = 0,
	anim_name = var_0_45.n_MoveL
}
local var_0_52 = {
	time = 0.3
}

Vector2 = var_48
var_0_52.start = var_48(0, 0)
Vector3 = var_48
var_0_52.distance = var_48(0, 0, 0)
var_0_51.move = var_0_52
var_0_46.n_Move_L = var_0_51
var_0_46.n_Skill_1 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_45.n_Skill_1
}

local var_0_53 = {
	sound_trigger = "guangjian",
	time = 0,
	anim_name = var_0_45.n_Skill_2
}

Vector3 = var_47
var_0_53.over_offset = var_47(0, 0)

local var_0_54 = {
	time = 0.2
}

Vector2 = var_48
var_0_54.start = var_48(0, 0)
Vector3 = var_48
var_0_54.distance = var_48(300, 0, 0)
LeanTweenType = var_48
var_0_54.ease = var_48.easeOutCirc
var_0_53.move = var_0_54
var_0_46.n_Skill_2 = var_0_53
var_0_46.n_Skill_3 = {
	sound_trigger = "baozha1",
	time = 0,
	anim_name = var_0_45.n_Skill_3
}
var_0_46.n_Combine = {
	camera = true,
	sound_start = "bianshen",
	time = 0,
	anim_name = var_0_45.n_Combine
}

local var_0_55 = {
	time = 0,
	anim_name = var_0_45.n_DMG
}
local var_0_56 = {
	time = 0.2
}

Vector2 = var_48
var_0_56.start = var_48(0, 0)
Vector3 = var_48
var_0_56.distance = var_48(-50, 0, 0)
LeanTweenType = var_48
var_0_56.ease = var_48.easeOutCirc
var_0_55.move = var_0_56
var_0_46.n_DMG = var_0_55
var_0_46.n_DMG_S = {
	time = 0,
	anim_name = var_0_45.n_DMG
}

local var_0_57 = {
	time = 0,
	anim_name = var_0_45.n_MoveR
}
local var_0_58 = {
	time = 0.2
}

Vector2 = var_48
var_0_58.start = var_48(0, 0)
Vector3 = var_48
var_0_58.distance = var_48(0, 0, 0)
var_0_57.move = var_0_58
var_0_46.n_DMG_Back_R = var_0_57
var_0_46.n_Neutral = {
	time = 0,
	anim_name = var_0_45.n_Neutral
}

local var_0_59 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_45.c_Atk
}
local var_0_60 = {
	time = 0.2
}

Vector2 = var_48
var_0_60.start = var_48(0, 0)
Vector3 = var_48
var_0_60.distance = var_48(500, 0, 0)
LeanTweenType = var_48
var_0_60.ease = var_48.easeOutCirc
var_0_59.move = var_0_60
var_0_46.c_Atk = var_0_59
var_0_46.c_Skill_1 = {
	camera = true,
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_45.c_Skill_1
}

local var_0_61 = {
	time = 0,
	anim_name = var_0_45.c_Dmg
}
local var_0_62 = {
	time = 0.2
}

Vector2 = var_48
var_0_62.start = var_48(0, 0)
Vector3 = var_48
var_0_62.distance = var_48(-50, 0, 0)
LeanTweenType = var_48
var_0_62.ease = var_48.easeOutCirc
var_0_61.move = var_0_62
var_0_46.c_Dmg = var_0_61
var_0_46.c_Dmg_S = {
	time = 0,
	anim_name = var_0_45.c_Dmg
}

local var_0_63 = {
	time = 0,
	anim_name = var_0_45.c_MoveL
}
local var_0_64 = {
	time = 0.2
}

Vector2 = var_48
var_0_64.start = var_48(0, 0)
Vector3 = var_48
var_0_64.distance = var_48(0, 0, 0)
var_0_63.move = var_0_64
var_0_46.c_MoveL = var_0_63

local var_0_65 = {
	time = 0,
	anim_name = var_0_45.c_MoveR
}
local var_0_66 = {
	time = 0.2
}

Vector2 = var_48
var_0_66.start = var_48(0, 0)
Vector3 = var_48
var_0_66.distance = var_48(650, 0, 0)
var_0_65.move = var_0_66
var_0_46.c_MoveR = var_0_65

local var_0_67 = {
	time = 0,
	anim_name = var_0_45.c_MoveR
}
local var_0_68 = {
	time = 0.2
}

Vector2 = var_48
var_0_68.start = var_48(0, 0)
Vector3 = var_48
var_0_68.distance = var_48(0, 0, 0)
var_0_67.move = var_0_68
var_0_46.c_DMG_Back_R = var_0_67
var_0_46.c_Neutral = {
	time = 0,
	anim_name = var_0_45.c_Neutral
}

local var_0_69 = {
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
			var_0_46.n_Atk,
			var_0_46.n_Move_L
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
			var_0_46.n_Skill_1
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
			var_0_46.n_Skill_2,
			var_0_46.n_Move_L
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
			var_0_46.n_Skill_3
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
			var_0_46.n_DMG,
			var_0_46.n_DMG_Back_R
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
			var_0_46.n_DMG_S
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
			var_0_46.n_DMG_Back_R
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
			var_0_46.n_Combine
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
			var_0_46.c_Atk,
			var_0_46.c_MoveL
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
			var_0_46.c_Skill_1
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
			var_0_46.c_Skill_1
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
			var_0_46.c_Skill_1
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
			var_0_46.c_Dmg,
			var_0_46.c_DMG_Back_R
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
			var_0_46.c_Dmg_S
		}
	}
}
local var_0_70 = {
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
local var_0_71 = {}
local var_0_72 = {
	time = 0,
	anim_name = var_0_70.n_MoveR
}
local var_0_73 = {
	time = 0.2
}

Vector2 = var_51
var_0_73.start = var_51(0, 0)
Vector3 = var_51
var_0_73.distance = var_51(500, 0, 0)
var_0_72.move = var_0_73
var_0_71.n_Move_R = var_0_72

local var_0_74 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_70.n_Atk
}
local var_0_75 = {
	time = 0.3
}

Vector2 = var_51
var_0_75.start = var_51(0, 0)
Vector3 = var_51
var_0_75.distance = var_51(600, 0, 0)
LeanTweenType = var_51
var_0_75.ease = var_51.easeOutCirc
var_0_74.move = var_0_75
var_0_71.n_Atk = var_0_74

local var_0_76 = {
	time = 0,
	anim_name = var_0_70.n_MoveL
}
local var_0_77 = {
	time = 0.4
}

Vector2 = var_51
var_0_77.start = var_51(0, 0)
Vector3 = var_51
var_0_77.distance = var_51(0, 0, 0)
LeanTweenType = var_51
var_0_77.ease = var_51.easeOutCirc
var_0_76.move = var_0_77
var_0_71.n_Move_L = var_0_76

local var_0_78 = {
	sound_trigger = "baozha1",
	time = 0,
	anim_name = var_0_70.n_Skill_1
}
local var_0_79 = {
	time = 0.2
}

Vector2 = var_51
var_0_79.start = var_51(0, 0)
Vector3 = var_51
var_0_79.distance = var_51(600, 0, 0)
var_0_78.move = var_0_79
var_0_71.n_Skill_1 = var_0_78
var_0_71.n_Skill_2 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_70.n_Skill_2
}

local var_0_80 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_70.n_Skill_3
}

Vector3 = var_50
var_0_80.over_offset = var_50(247, 2)

local var_0_81 = {
	time = 0.2
}

Vector2 = var_51
var_0_81.start = var_51(0, 0)
Vector3 = var_51
var_0_81.distance = var_51(350, 0, 0)
LeanTweenType = var_51
var_0_81.ease = var_51.easeOutCirc
var_0_80.move = var_0_81
var_0_71.n_Skill_3 = var_0_80
var_0_71.n_Combine = {
	camera = true,
	sound_start = "bianshen",
	time = 0,
	anim_name = var_0_70.n_Combine
}

local var_0_82 = {
	time = 0,
	anim_name = var_0_70.n_DMG
}
local var_0_83 = {
	time = 0.2
}

Vector2 = var_51
var_0_83.start = var_51(0, 0)
Vector3 = var_51
var_0_83.distance = var_51(-50, 0, 0)
LeanTweenType = var_51
var_0_83.ease = var_51.easeOutCirc
var_0_82.move = var_0_83
var_0_71.n_DMG = var_0_82
var_0_71.n_DMG_S = {
	time = 0,
	anim_name = var_0_70.n_DMG
}

local var_0_84 = {
	time = 0,
	anim_name = var_0_70.n_MoveR
}
local var_0_85 = {
	time = 0.2
}

Vector2 = var_51
var_0_85.start = var_51(0, 0)
Vector3 = var_51
var_0_85.distance = var_51(0, 0, 0)
var_0_84.move = var_0_85
var_0_71.n_DMG_Back_R = var_0_84
var_0_71.n_Neutral = {
	time = 0,
	anim_name = var_0_70.n_Neutral
}

local var_0_86 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_70.c_Atk
}
local var_0_87 = {
	time = 0.4
}

Vector2 = var_51
var_0_87.start = var_51(0, 0)
Vector3 = var_51
var_0_87.distance = var_51(600, 0, 0)
LeanTweenType = var_51
var_0_87.ease = var_51.easeOutCirc
var_0_86.move = var_0_87
var_0_71.c_Atk = var_0_86
var_0_71.c_Skill_1 = {
	camera = true,
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_70.c_Skill_1
}

local var_0_88 = {
	time = 0,
	anim_name = var_0_70.c_Dmg
}
local var_0_89 = {
	time = 0.3
}

Vector2 = var_51
var_0_89.start = var_51(0, 0)
Vector3 = var_51
var_0_89.distance = var_51(-50, 0, 0)
LeanTweenType = var_51
var_0_89.ease = var_51.easeOutCirc
var_0_88.move = var_0_89
var_0_71.c_Dmg = var_0_88
var_0_71.c_Dmg_S = {
	time = 0,
	anim_name = var_0_70.c_Dmg
}

local var_0_90 = {
	time = 0,
	anim_name = var_0_70.c_MoveL
}
local var_0_91 = {
	time = 0.3
}

Vector2 = var_51
var_0_91.start = var_51(0, 0)
Vector3 = var_51
var_0_91.distance = var_51(0, 0, 0)
LeanTweenType = var_51
var_0_91.ease = var_51.easeOutCirc
var_0_90.move = var_0_91
var_0_71.c_MoveL = var_0_90

local var_0_92 = {
	time = 0,
	anim_name = var_0_70.c_MoveR
}
local var_0_93 = {
	time = 0.3
}

Vector2 = var_51
var_0_93.start = var_51(0, 0)
Vector3 = var_51
var_0_93.distance = var_51(650, 0, 0)
LeanTweenType = var_51
var_0_93.ease = var_51.easeOutCirc
var_0_92.move = var_0_93
var_0_71.c_MoveR = var_0_92

local var_0_94 = {
	time = 0,
	anim_name = var_0_70.c_MoveR
}
local var_0_95 = {
	time = 0.3
}

Vector2 = var_51
var_0_95.start = var_51(0, 0)
Vector3 = var_51
var_0_95.distance = var_51(0, 0, 0)
LeanTweenType = var_51
var_0_95.ease = var_51.easeOutCirc
var_0_94.move = var_0_95
var_0_71.c_DMG_Back_R = var_0_94
var_0_71.c_Neutral = {
	time = 0,
	anim_name = var_0_70.c_Neutral
}

local var_0_96 = {
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
			var_0_71.n_Atk,
			var_0_71.n_Move_L
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
			var_0_71.n_Move_R,
			var_0_71.n_Skill_1,
			var_0_71.n_Move_L
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
			var_0_71.n_Skill_2
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
			var_0_71.n_Skill_3,
			var_0_71.n_Move_L
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
			var_0_71.n_DMG,
			var_0_71.n_DMG_Back_R
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
			var_0_71.n_DMG_S
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
			var_0_71.n_DMG_Back_R
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
			var_0_71.n_Combine
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
			var_0_71.c_Atk,
			var_0_71.c_MoveL
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
			var_0_71.c_Skill_1
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
			var_0_71.c_Skill_1
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
			var_0_71.c_Skill_1
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
			var_0_71.c_Dmg,
			var_0_71.c_DMG_Back_R
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
			var_0_71.c_Dmg_S
		}
	}
}
local var_0_97 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_98 = {}
local var_0_99 = {
	time = 0,
	anim_name = var_0_97.MoveR
}
local var_0_100 = {
	time = 0.3
}

Vector2 = var_54
var_0_100.start = var_54(0, 0)
Vector3 = var_54
var_0_100.distance = var_54(500, 0, 0)
LeanTweenType = var_54
var_0_100.ease = var_54.easeOutCirc
var_0_99.move = var_0_100
var_0_98.Move_R = var_0_99

local var_0_101 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_97.Atk
}
local var_0_102 = {
	time = 0.3
}

Vector2 = var_54
var_0_102.start = var_54(0, 0)
Vector3 = var_54
var_0_102.distance = var_54(600, 0, 0)
LeanTweenType = var_54
var_0_102.ease = var_54.easeOutCirc
var_0_101.move = var_0_102
var_0_98.Atk = var_0_101

local var_0_103 = {
	time = 0,
	anim_name = var_0_97.MoveL
}
local var_0_104 = {
	time = 0.4
}

Vector3 = var_54
var_0_104.distance = var_54(0, 0, 0)
LeanTweenType = var_54
var_0_104.ease = var_54.easeOutCirc
var_0_103.move = var_0_104
var_0_98.Move_L = var_0_103
var_0_98.Skill_1 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_97.Skill_1
}

local var_0_105 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_97.Skill_2
}

Vector2 = var_53
var_0_105.over_offset = var_53(115, 0)
var_0_98.Skill_2 = var_0_105

local var_0_106 = {
	time = 0,
	anim_name = var_0_97.DMG
}
local var_0_107 = {
	time = 0.3
}

Vector2 = var_54
var_0_107.start = var_54(0, 0)
Vector3 = var_54
var_0_107.distance = var_54(-50, 0, 0)
LeanTweenType = var_54
var_0_107.ease = var_54.easeOutCirc
var_0_106.move = var_0_107
var_0_98.DMG = var_0_106

local var_0_108 = {
	time = 0,
	anim_name = var_0_97.MoveR
}
local var_0_109 = {
	time = 0.3
}

Vector2 = var_54
var_0_109.start = var_54(0, 0)
Vector3 = var_54
var_0_109.distance = var_54(0, 0, 0)
LeanTweenType = var_54
var_0_109.ease = var_54.easeOutCirc
var_0_108.move = var_0_109
var_0_98.DMG_Back_R = var_0_108
var_0_98.DMG_S = {
	time = 0,
	anim_name = var_0_97.DMG
}
var_0_98.Neutral = {
	time = 0,
	anim_name = var_0_97.Neutral
}

local var_0_110 = {
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
			var_0_98.Atk,
			var_0_98.Move_L
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
			var_0_98.Skill_1
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
			var_0_98.Move_R,
			var_0_98.Skill_2,
			var_0_98.Move_L
		}
	},
	{
		dmg_index = 2,
		name = "DMG",
		special_time = false,
		actions = {
			var_0_98.DMG,
			var_0_98.DMG_Back_R
		}
	},
	{
		dmg_index = 1,
		name = "DMG_Stand",
		special_time = false,
		actions = {
			var_0_98.DMG_S
		}
	}
}
local var_0_111 = {
	{
		index = 1,
		name = "role1",
		skill = var_0_69,
		actions = var_0_46
	},
	{
		index = 2,
		name = "role2",
		skill = var_0_96,
		actions = var_0_71
	},
	{
		index = 3,
		name = "enemy1",
		skill = var_0_110,
		actions = var_0_98
	}
}

local function var_0_112(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = 12
	local var_1_2 = 0.3

	Vector2 = var_1_10005

	local var_1_3 = var_1_10005(138, 150)
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

	function var_1_0.ctor(arg_2_0)
		arg_2_0._boxTf = arg_1_0
		arg_2_0._event = arg_1_1
		findTF = var_1
		arg_2_0._gridEffect = var_1(arg_2_0._boxTf, "effectGrid")
		findTF = var_1
		arg_2_0._content = var_1(arg_2_0._boxTf, "viewport/content")
		findTF = var_1
		arg_2_0.tplGrid = var_1(arg_1_0, "tplGrid")
		setActive = var_1

		var_1(arg_2_0.tplGrid, false)

		arg_2_0.grids = {}
		arg_2_0.effects = {}
		arg_2_0.combo = 0

		for iter_2_0 = 1, var_1_1 do
			tf = var_2_10005
			instantiate = var_2_10007
			var_2_10005 = var_2_10005(var_2_10007(arg_2_0._gridEffect))
			setParent = var_2_10006

			var_2_10006(var_2_10005, arg_2_0._content)

			setActive = var_2_10006

			var_2_10006(var_2_10005, false)

			Vector2 = var_2_10006
			var_2_10005.anchoredPosition = var_2_10006(var_1_3.x * iter_2_0 - var_1_3.x / 2, var_1_3.y / 2)
			table = var_2_10006

			var_2_10006.insert(arg_2_0.effects, var_2_10005)
		end

		return
	end

	function var_1_0.start(arg_3_0)
		arg_3_0.nextCheck = false

		arg_3_0:initGrids(false)

		for iter_3_0 = 1, #arg_3_0.effects do
			setActive = var_2_10005

			var_2_10005(arg_3_0.effects[iter_3_0], false)
		end

		return
	end

	function var_1_0.step(arg_4_0)
		if arg_4_0.takeAwayTime then
			local var_4_0 = arg_4_0.takeAwayTime

			if 0 < var_4_0 then
				local var_4_1 = arg_4_0.takeAwayTime

				Time = var_2
				arg_4_0.takeAwayTime = var_4_1 - var_2.deltaTime

				return
			end
		end

		arg_4_0.gridCreateIndex = 1

		local var_4_2 = false

		for iter_4_0 = 1, #arg_4_0.grids do
			local var_4_3 = arg_4_0.grids[iter_4_0]
			local var_4_4 = iter_4_0

			if not var_4_3.checkAble then
				var_4_2 = var_4_2 or true

				if (iter_4_0 - 1) * var_1_3.x < var_4_3.tf.anchoredPosition.x then
					local var_4_5 = var_4_3.tf

					Vector2 = var_2_10010

					local var_4_6 = var_4_3.tf.anchoredPosition.x

					var_2_10013 = var_4_3.speed
					Time = var_2_10014
					var_4_5.anchoredPosition = var_2_10010(var_4_6 - var_2_10013 * var_2_10014.deltaTime, 0)

					if var_4_3.speed < var_1_4 then
						var_4_3.speed = var_4_3.speed + var_1_6
					end
				end

				if var_8 >= var_4_3.tf.anchoredPosition.x then
					var_4_3.speed = 0
					var_4_3.checkAble = true

					if var_8 > var_4_3.tf.anchoredPosition.x then
						local var_4_7 = var_4_3.tf

						Vector2 = var_2_10010
						var_4_7.anchoredPosition = var_2_10010(var_8, 0)
					end
				end
			end

			if not var_4_3.eventAble then
				GetComponent = var_8
				var_2_10010 = var_4_3.tf
				typeof = var_2_10011
				EventTriggerListener = var_2_10013
				var_2_10011 = var_8(var_2_10010, var_2_10011(var_2_10013))

				var_8.AddPointDownFunc(var_2_10011, function()
					if arg_4_0.nextCheck == false then
						local var_5_0 = arg_4_0
						local var_5_1, var_5_2 = var_0.triggerDownGrid(var_5_0, var_4_4)

						if #var_5_1 >= 2 then
							arg_4_0.nextCheck = true

							local var_5_3 = arg_4_0

							var_2.takeAwayGrid(var_5_3, var_5_1)

							local var_5_4 = arg_4_0

							var_2.insertGrids(var_5_4)

							local var_5_5 = arg_4_0._event

							var_2.emit(var_5_5, var_0_13, {
								series = #var_5_1,
								combo = arg_4_0.combo,
								index = var_5_2
							})

							arg_4_0.combo = arg_4_0.combo + 1
						else
							arg_4_0.nextCheck = true

							local var_5_6 = arg_4_0

							var_2.takeAwayGrid(var_5_6, {
								var_4_4
							})

							local var_5_7 = arg_4_0

							var_2.insertGrids(var_5_7)
						end
					end

					return
				end)

				var_4_3.eventAble = true
			end
		end

		if not var_4_2 and arg_4_0.nextCheck then
			if #arg_4_0:getSeriesGrids() > 0 then
				local var_4_8 = {}

				for iter_4_1 = 1, #var_2 do
					local var_4_9 = var_2[iter_4_1].series
					local var_4_10 = var_2[iter_4_1].gridIndex

					for iter_4_2 = 1, #var_4_9 do
						table = var_2_10014

						var_2_10014.insert(var_4_8, var_4_9[iter_4_2])
					end

					local var_4_11 = arg_4_0._event

					var_10.emit(var_4_11, var_0_13, {
						series = #var_4_9,
						combo = arg_4_0.combo,
						index = var_4_10
					})
				end

				arg_4_0:clearGridSeriesAble()
				arg_4_0:takeAwayGrid(var_4_8)
				arg_4_0:insertGrids()

				arg_4_0.nextCheck = true
				arg_4_0.combo = arg_4_0.combo + 1
			else
				arg_4_0.nextCheck = false

				if not var_0_22.special_time then
					arg_4_0.combo = 0
				end
			end
		end

		return
	end

	function var_1_0.clear(arg_6_0)
		for iter_6_0 = 1, #arg_6_0.grids do
			if arg_6_0.grids[iter_6_0].tf then
				destroy = var_5

				var_5(arg_6_0.grids[iter_6_0].tf)
			end
		end

		arg_6_0.grids = {}
		arg_6_0.gridCreateIndex = 1

		return
	end

	function var_1_0.clearGridSeriesAble(arg_7_0)
		for iter_7_0 = 1, #arg_7_0.grids do
			if arg_7_0.grids[iter_7_0].seriesAble then
				arg_7_0.grids[iter_7_0].seriesAble = false
			end
		end

		return
	end

	function var_1_0.getSeriesGrids(arg_8_0)
		local var_8_0 = {}
		local var_8_1
		local var_8_2 = {}

		for iter_8_0 = 1, #arg_8_0.grids do
			local var_8_3 = arg_8_0.grids[iter_8_0]

			if not var_8_1 then
				var_8_1 = var_8_3.index
				table = var_2_10009

				var_2_10009.insert(var_8_2, iter_8_0)
			elseif var_8_1 == var_8_3.index then
				table = var_2_10009

				var_2_10009.insert(var_8_2, iter_8_0)

				if #var_8_2 >= 3 and iter_8_0 == #arg_8_0.grids and arg_8_0:checkSeriesAble(var_8_2) then
					table = var_2_10009

					var_2_10009.insert(var_8_0, {
						series = var_8_2,
						gridIndex = var_8_1
					})
				end
			elseif var_8_1 ~= var_8_3.index then
				if #var_8_2 >= 3 and arg_8_0:checkSeriesAble(var_8_2) then
					table = var_2_10009

					var_2_10009.insert(var_8_0, {
						series = var_8_2,
						gridIndex = var_8_1
					})
				end

				var_8_2 = {}
				var_8_1 = var_8_3.index
				table = var_2_10009

				var_2_10009.insert(var_8_2, iter_8_0)
			end
		end

		return var_8_0
	end

	function var_1_0.checkSeriesAble(arg_9_0, arg_9_1)
		for iter_9_0 = 1, #arg_9_1 do
			if arg_9_0.grids[arg_9_1[iter_9_0]].seriesAble then
				return true
			end
		end

		return false
	end

	function var_1_0.insertGrids(arg_10_0)
		local var_10_0 = var_1_1 - #arg_10_0.grids

		for iter_10_0 = 1, var_10_0 do
			local var_10_1 = arg_10_0:createGridData()

			table = var_2_10007

			var_2_10007.insert(arg_10_0.grids, var_10_1)
		end

		if arg_10_0:checkGridsSeries() then
			arg_10_0:instiateGrids(true)
		else
			arg_10_0:initGrids(true)
		end

		arg_10_0:changeAbleGrids()

		return
	end

	function var_1_0.changeAbleGrids(arg_11_0)
		for iter_11_0 = 1, #arg_11_0.grids do
			arg_11_0.grids[iter_11_0].checkAble = false
			arg_11_0.grids[iter_11_0].eventAble = false
			arg_11_0.grids[iter_11_0].speed = var_1_5
		end

		return
	end

	function var_1_0.takeAwayGrid(arg_12_0, arg_12_1)
		table = var_2_10002

		var_2_10002.sort(arg_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0 <= arg_13_1
		end)

		arg_12_0.takeAwayTime = var_1_2

		local var_12_0 = {}
		local var_12_1

		if arg_12_1[1] - 1 > 0 then
			var_12_1 = arg_12_0.grids[arg_12_1[1] - 1]
			var_12_1.seriesAble = true
		end

		pg = var_12_1

		local var_12_2 = var_12_1.CriMgr.GetInstance()

		var_3.PlaySoundEffect_V3(var_12_2, "event:/ui/" .. "xiaochu")

		for iter_12_0 = #arg_12_1, 1, -1 do
			table = var_12_3

			local var_12_3 = var_12_3.insert
			local var_12_4 = var_12_0

			table = var_2_10010

			var_12_3(var_12_4, var_2_10010.remove(arg_12_0.grids, arg_12_1[iter_12_0]))

			setActive = var_12_3

			var_12_3(arg_12_0.effects[arg_12_1[iter_12_0]], false)

			setActive = var_12_3

			var_12_3(arg_12_0.effects[arg_12_1[iter_12_0]], true)
		end

		for iter_12_1 = 1, #var_12_0 do
			destroy = var_12_3

			var_12_3(var_12_0[iter_12_1].tf)

			var_12_0[iter_12_1] = 0
		end

		local var_12_5 = {}

		return
	end

	function var_1_0.triggerDownGrid(arg_14_0, arg_14_1)
		local var_14_0 = arg_14_0.grids[arg_14_1]
		local var_14_1 = {
			arg_14_1
		}

		if not var_14_0 then
			return var_14_1, 0
		end

		for iter_14_0 = arg_14_1 - 1, 1, -1 do
			local var_14_2 = arg_14_0.grids[iter_14_0]

			if var_14_0.index == var_14_2.index then
				table = var_9

				var_9.insert(var_14_1, iter_14_0)
			else
				break
			end
		end

		for iter_14_1 = arg_14_1 + 1, #arg_14_0.grids do
			local var_14_3 = arg_14_0.grids[iter_14_1]

			if var_14_0.index == var_14_3.index then
				table = var_9

				var_9.insert(var_14_1, iter_14_1)
			else
				break
			end
		end

		table = var_4

		var_4.sort(var_14_1, function(arg_15_0, arg_15_1)
			return arg_15_0 <= arg_15_1
		end)

		return var_14_1, var_14_0.index
	end

	function var_1_0.initGrids(arg_16_0, arg_16_1)
		arg_16_0:clear()

		for iter_16_0 = 1, var_1_1 do
			local var_16_0 = arg_16_0:createGridData()

			table = var_2_10007

			var_2_10007.insert(arg_16_0.grids, var_16_0)
		end

		if arg_16_0:checkGridsSeries() then
			arg_16_0:instiateGrids(arg_16_1)
		else
			arg_16_0:initGrids(arg_16_1)
		end

		arg_16_0.nextCheck = false

		return
	end

	function var_1_0.instiateGrids(arg_17_0, arg_17_1)
		for iter_17_0 = 1, #arg_17_0.grids do
			if not arg_17_0.grids[iter_17_0].tf then
				tf = var_7
				instantiate = var_2_10009

				local var_17_0 = var_7(var_2_10009(arg_17_0.tplGrid))

				SetParent = var_2_10008

				var_2_10008(var_17_0, arg_17_0._content)

				setActive = var_2_10008

				var_2_10008(var_17_0, true)

				setActive = var_2_10008
				findTF = var_10

				var_2_10008(var_10(var_17_0, var_6.name), true)

				var_2_10008 = nil

				if arg_17_1 then
					var_2_10008 = (var_1_1 + arg_17_0.gridCreateIndex - 1) * var_1_3.x
				else
					var_2_10008 = (arg_17_0.gridCreateIndex - 1) * var_1_3.x
				end

				Vector2 = var_2_10009
				var_17_0.anchoredPosition = var_2_10009(var_2_10008, 0)
				arg_17_0.gridCreateIndex = arg_17_0.gridCreateIndex + 1
				var_6.tf = var_17_0
			end
		end

		return
	end

	function var_1_0.createGridData(arg_18_0, arg_18_1)
		local var_18_0

		if arg_18_1 then
			Clone = var_2_10003
			var_18_0 = var_2_10003(var_1_7[arg_18_1])
		else
			Clone = var_2_10003

			local var_18_1 = var_1_7

			math = var_2_10006
			var_18_0 = var_2_10003(var_18_1[var_2_10006.random(1, #var_1_7)])
		end

		local var_18_2 = var_18_0.index
		local var_18_3 = var_18_0.name

		return {
			checkAble = false,
			eventAble = false,
			speed = var_1_5,
			index = var_18_2,
			name = var_18_3
		}
	end

	function var_1_0.checkGridsSeries(arg_19_0)
		return true
	end

	var_1_0:ctor()

	return var_1_0
end

local var_0_113 = false

local function var_0_114(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {
		ctor = function(arg_21_0)
			arg_21_0._specialTf = arg_20_0
			arg_21_0._successTf = arg_20_1
			findTF = var_1
			arg_21_0._effectSuccess = var_1(arg_21_0._successTf, "effectSuccess")
			arg_21_0._event = arg_20_2

			local var_21_0 = arg_21_0._event

			var_1.bind(var_21_0, var_0_13, function(arg_22_0, arg_22_1, arg_22_2)
				local var_22_0 = arg_22_1.series
				local var_22_1 = arg_22_1.combo
				local var_22_2 = arg_22_1.index
				local var_22_3 = arg_21_0
				local var_22_4 = var_6.addPowerAmount
				local var_22_5 = var_22_2
				local var_22_6 = arg_21_0

				var_22_4(var_22_3, var_22_5, var_10.getPowerAmount(var_22_6, var_22_0, var_22_1))

				return
			end)

			arg_21_0.powers = {}

			for iter_21_0 = 1, #var_0_23 do
				findTF = var_21_1

				local var_21_1 = var_21_1(arg_21_0._specialTf, var_0_23[iter_21_0].name)
				local var_21_2 = var_0_23[iter_21_0].index
				local var_21_3 = var_0_23[iter_21_0].max
				local var_21_4 = var_0_23[iter_21_0].cur
				local var_21_5 = {
					active = false,
					tf = var_21_1,
					index = var_21_2,
					max = var_21_3,
					cur = var_21_4
				}

				table = var_2_10010

				var_2_10010.insert(arg_21_0.powers, var_21_5)
			end

			local var_21_6 = {
				cur = 0
			}

			GetComponent = var_2
			findTF = iter_21_0

			local var_21_7 = iter_21_0(arg_21_0._successTf, "box")

			typeof = var_21_1
			Slider = var_7
			var_21_6.slider = var_2(var_21_7, var_21_1(var_7))
			var_21_6.max = var_0_31
			arg_21_0.success = var_21_6

			return
		end,
		start = function(arg_23_0)
			for iter_23_0 = 1, #arg_23_0.powers do
				local var_23_0 = arg_23_0.powers[iter_23_0]

				var_23_0.cur = 0
				var_23_0.active = false
			end

			arg_23_0.success.cur = 0

			local var_23_1 = arg_23_0.success

			var_23_1.active = false
			setActive = var_23_1

			var_23_1(arg_23_0._effectSuccess, false)
			arg_23_0:resetSpecialData()
			arg_23_0:step()

			return
		end,
		step = function(arg_24_0)
			for iter_24_0 = 1, #arg_24_0.powers do
				local var_24_0

				if arg_24_0.powers[iter_24_0].active and var_5.cur > 0 then
					var_24_0 = var_5.cur

					local var_24_1 = var_0_28

					Time = var_2_10008
					var_5.cur = var_24_0 - var_24_1 * var_2_10008.deltaTime

					if var_5.cur <= 0 then
						var_5.active = false
						var_5.cur = 0
					end
				end

				GetComponent = var_24_0
				var_2_10008 = var_5.tf
				typeof = var_2_10009
				Slider = var_2_10011

				local var_24_2 = var_24_0(var_2_10008, var_2_10009(var_2_10011))
				local var_24_3 = var_5.cur
				local var_24_4

				if not (0 < var_24_3) or not (var_5.cur / var_5.max) then
					var_24_4 = 0
				end

				var_24_2.value = var_24_4
			end

			if arg_24_0.success.active and arg_24_0.success.cur > 0 and var_0_22.special_complete then
				local var_24_5 = arg_24_0.success
				local var_24_6 = arg_24_0.success.cur
				local var_24_7 = var_0_29

				Time = iter_24_0
				var_24_5.cur = var_24_6 - var_24_7 * iter_24_0.deltaTime

				if arg_24_0.success.cur <= 0 then
					arg_24_0.success.active = false
					arg_24_0.success.cur = 0

					local var_24_8 = arg_24_0._event

					var_1.emit(var_24_8, var_0_18)
				end
			end

			if arg_24_0.success.cur >= arg_24_0.success.max or arg_24_0.success.active then
				setActive = var_1

				var_1(arg_24_0._effectSuccess, true)
			else
				setActive = var_1

				var_1(arg_24_0._effectSuccess, false)
			end

			local var_24_9 = arg_24_0.success.slider
			local var_24_10

			if not (arg_24_0.success.cur > 0) or not (arg_24_0.success.cur / arg_24_0.success.max) then
				var_24_10 = 0
			end

			var_24_9.value = var_24_10
			var_0_22.special_time = arg_24_0.success.active
			var_0_22.grid_index = 0

			return
		end,
		clear = function(arg_25_0)
			return
		end,
		updateSpecialData = function(arg_26_0, arg_26_1)
			var_0_22.special_time = arg_26_0.success.active
			var_0_22.grid_index = arg_26_1
			var_0_22.power_grid = 0

			for iter_26_0 = 1, #arg_26_0.powers do
				if arg_26_0.powers[iter_26_0].index == arg_26_1 and arg_26_0.powers[iter_26_0].cur == arg_26_0.powers[iter_26_0].max then
					var_0_22.power_grid = arg_26_0.powers[iter_26_0].index
				end
			end

			local var_26_0 = arg_26_0._event

			var_2.emit(var_26_0, var_0_14)

			return
		end,
		resetSpecialData = function(arg_27_0)
			var_0_22.special_complete = false

			return
		end,
		addPowerAmount = function(arg_28_0, arg_28_1, arg_28_2)
			local var_28_0 = arg_28_0:getPowerByIndex(arg_28_1)

			if arg_28_0.success and not arg_28_0.success.active then
				arg_28_0.success.cur = arg_28_0.success.cur + arg_28_2

				if arg_28_0.success.cur >= arg_28_0.success.max then
					local var_28_1 = arg_28_0.success

					var_28_1.cur = arg_28_0.success.max
					isActive = var_28_1

					if not var_28_1(arg_28_0._effectSuccess) then
						setActive = var_4

						var_4(arg_28_0._effectSuccess, true)
					end

					arg_28_0.success.active = true
					var_0_22.special_complete = false

					local var_28_2 = arg_28_0._event

					var_4.emit(var_28_2, var_0_17)
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
				arg_28_0:updateSpecialData(arg_28_1)
			end

			return
		end,
		getPowerByIndex = function(arg_29_0, arg_29_1)
			for iter_29_0 = 1, #arg_29_0.powers do
				if arg_29_0.powers[iter_29_0].index == arg_29_1 then
					return arg_29_0.powers[iter_29_0]
				end
			end

			return nil
		end,
		getPowerAmount = function(arg_30_0, arg_30_1, arg_30_2)
			if arg_30_1 <= 2 then
				return var_0_30
			end

			return (var_0_27 + (arg_30_1 - var_0_26) * var_0_25) * (1 + arg_30_2 * var_0_24)
		end
	}

	var_3.ctor(var_20_0)

	return var_3
end

local function var_0_115(arg_31_0, arg_31_1, arg_31_2)
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

	function var_31_0.ctor(arg_32_0)
		arg_32_0._sceneTf = arg_31_0
		arg_32_0._event = arg_31_2
		arg_32_0.bgs = {}
		arg_32_0._gameTf = arg_31_1
		findTF = var_1
		arg_32_0._box = var_1(arg_32_0._gameTf, "box")
		findTF = var_1
		arg_32_0._specialPower = var_1(arg_32_0._gameTf, "specialPower")
		findTF = var_1
		arg_32_0._successPower = var_1(arg_32_0._gameTf, "successPower")
		findTF = var_1
		arg_32_0._top = var_1(arg_32_0._gameTf, "top")

		for iter_32_0 = 1, #var_31_1 do
			local var_32_0 = var_31_1[iter_32_0]

			findTF = var_2_10006
			var_2_10006 = var_2_10006(arg_32_0._sceneTf, var_31_1[iter_32_0].source)

			local var_32_1 = var_31_1[iter_32_0].rate

			table = var_8

			var_8.insert(arg_32_0.bgs, {
				tf = var_2_10006,
				rate = var_32_1
			})
		end

		GetComponent = var_1
		findTF = var_3

		local var_32_2 = var_3(arg_32_0._sceneTf, "scene_background")

		typeof = iter_32_0
		CanvasGroup = var_6
		arg_32_0._bgBackCanvas = var_1(var_32_2, iter_32_0(var_6))
		GetComponent = var_1
		findTF = var_32_2

		local var_32_3 = var_32_2(arg_32_0._sceneTf, "scene_front")

		typeof = var_4
		CanvasGroup = var_6
		arg_32_0._bgFrontCanvas = var_1(var_32_3, var_4(var_6))
		GetComponent = var_1
		findTF = var_32_3

		local var_32_4 = var_32_3(arg_32_0._sceneTf, "scene/bgBeam")

		typeof = var_4
		CanvasGroup = var_6
		arg_32_0._bgBeamCanvas = var_1(var_32_4, var_4(var_6))

		local var_32_5 = arg_32_0._event

		var_1.bind(var_32_5, var_0_15, function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_1[1]
			local var_33_1 = arg_33_1[2] and -1 or 1
			local var_33_2 = arg_33_1[3]

			if not arg_32_0.inCamera then
				local var_33_3 = arg_32_0
				local var_33_4 = var_6.setTargetFllow

				Vector2 = var_3_10009

				var_33_4(var_33_3, var_3_10009(var_33_1 * var_33_0.x / 10, var_33_1 * var_33_0.y / 10), var_33_2)
			end

			return
		end)

		local var_32_6 = arg_32_0._event

		var_1.bind(var_32_6, var_0_19, function(arg_34_0, arg_34_1, arg_34_2)
			arg_32_0.inCamera = true

			local var_34_0 = arg_32_0
			local var_34_1 = var_3.setTargetFllow

			Vector2 = var_3_10006

			var_34_1(var_34_0, var_3_10006(550, 100))

			local var_34_2 = arg_32_0

			var_3.setBeam(var_34_2, false)

			return
		end)

		local var_32_7 = arg_32_0._event

		var_1.bind(var_32_7, var_0_20, function(arg_35_0, arg_35_1, arg_35_2)
			local var_35_0 = arg_32_0
			local var_35_1 = var_3.setTargetFllow

			Vector2 = var_3_10006

			var_35_1(var_35_0, var_3_10006(0, 0), function()
				return
			end, true)

			local var_35_2 = arg_32_0

			var_3.setBeam(var_35_2, true)

			arg_32_0.inCamera = false

			return
		end)

		return
	end

	function var_31_0.start(arg_37_0)
		Vector2 = var_2_10001
		arg_37_0.targetVec = var_2_10001(var_0_37.x, var_0_37.y)
		Vector2 = var_1
		arg_37_0.currentVec = var_1(var_0_37.x, var_0_37.y)

		for iter_37_0 = 1, #arg_37_0.bgs do
			local var_37_0 = arg_37_0.bgs[iter_37_0].tf
			local var_37_1 = arg_37_0.bgs[iter_37_0].rate

			Vector2 = var_2_10007
			var_37_0.anchoredPosition = var_2_10007(arg_37_0.currentVec.x * var_37_1, arg_37_0.currentVec.y * var_37_1)
		end

		arg_37_0._bgBackCanvas.alpha = 1
		arg_37_0._bgFrontCanvas.alpha = 1

		local var_37_2 = arg_37_0._bgBeamCanvas

		var_37_2.alpha = 0
		setActive = var_37_2

		var_37_2(arg_37_0._box, true)

		setActive = var_37_2

		var_37_2(arg_37_0._specialPower, true)

		setActive = var_37_2

		var_37_2(arg_37_0._successPower, true)

		setActive = var_37_2

		var_37_2(arg_37_0._top, true)

		return
	end

	function var_31_0.clear(arg_38_0)
		LeanTween = var_2_10001

		local var_38_0 = var_2_10001.isTweening

		go = var_2_10003

		if var_38_0(var_2_10003(arg_38_0._sceneTf)) then
			LeanTween = var_1

			local var_38_1 = var_1.cancel

			go = var_3

			var_38_1(var_3(arg_38_0._sceneTf), false)
		end

		return
	end

	function var_31_0.step(arg_39_0)
		local var_39_0 = 0
		local var_39_1 = 0

		if arg_39_0.targetVec.x ~= arg_39_0.currentVec.x then
			var_39_0 = (arg_39_0.targetVec.x - arg_39_0.currentVec.x) * var_0_38
			math = var_3

			if var_3.abs(var_39_0) < var_0_39 then
				local var_39_2 = var_0_39

				math = var_4
				var_39_0 = var_39_2 * var_4.sign(var_39_0)
			end

			local var_39_3 = arg_39_0.currentVec

			var_39_3.x = arg_39_0.currentVec.x + var_39_0
			math = var_39_3

			if var_39_3.abs(arg_39_0.currentVec.x - arg_39_0.targetVec.x) <= var_0_39 then
				arg_39_0.currentVec.x = arg_39_0.targetVec.x
			end
		end

		if arg_39_0.targetVec.y ~= arg_39_0.currentVec.y then
			var_39_1 = (arg_39_0.targetVec.y - arg_39_0.currentVec.y) * var_0_38
			math = var_3

			if var_3.abs(var_39_1) < var_0_39 then
				local var_39_4 = var_0_39

				math = var_4
				var_39_1 = var_39_4 * var_4.sign(var_39_1)
			end

			local var_39_5 = arg_39_0.currentVec

			var_39_5.y = arg_39_0.currentVec.y + var_39_1
			math = var_39_5

			if var_39_5.abs(arg_39_0.currentVec.y - arg_39_0.targetVec.y) <= var_0_39 then
				arg_39_0.currentVec.y = arg_39_0.targetVec.y
			end
		end

		if var_39_0 ~= 0 or var_39_1 ~= 0 then
			arg_39_0:moveTo(arg_39_0.currentVec)
		end

		return
	end

	function var_31_0.moveTo(arg_40_0, arg_40_1)
		for iter_40_0 = 1, #arg_40_0.bgs do
			local var_40_0 = arg_40_0.bgs[iter_40_0].tf
			local var_40_1 = arg_40_0.bgs[iter_40_0].rate

			Vector2 = var_2_10008
			var_40_0.anchoredPosition = var_2_10008(arg_40_1.x * var_40_1, arg_40_1.y * var_40_1)
		end

		return
	end

	function var_31_0.setTargetFllow(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
		if not arg_41_3 then
			arg_41_0.targetVec = arg_41_1
			arg_41_0.moveCallback = arg_41_2
		else
			arg_41_0.currentVec = arg_41_1
			arg_41_0.targetVec = arg_41_1

			arg_41_0:moveTo(arg_41_1)

			if arg_41_2 then
				arg_41_2()
			end
		end

		return
	end

	function var_31_0.setBeam(arg_42_0, arg_42_1, arg_42_2)
		LeanTween = var_2_10003

		local var_42_0 = var_2_10003.isTweening

		go = var_2_10005

		local var_42_1

		if var_42_0(var_2_10005(arg_42_0._sceneTf)) then
			LeanTween = var_42_1
			var_42_1 = var_42_1.cancel
			go = var_5

			var_42_1(var_5(arg_42_0._sceneTf), false)
		end

		if arg_42_1 then
			setActive = var_42_1

			var_42_1(arg_42_0._box, true)

			setActive = var_42_1

			var_42_1(arg_42_0._specialPower, true)

			setActive = var_42_1

			var_42_1(arg_42_0._successPower, true)

			setActive = var_42_1

			var_42_1(arg_42_0._top, true)
		else
			setActive = var_42_1

			var_42_1(arg_42_0._box, false)

			setActive = var_42_1

			var_42_1(arg_42_0._specialPower, false)

			setActive = var_42_1

			var_42_1(arg_42_0._successPower, false)

			setActive = var_42_1

			var_42_1(arg_42_0._top, false)
		end

		LeanTween = var_42_1

		local var_42_2 = var_42_1.value

		go = var_5

		local var_42_3 = var_42_2(var_5(arg_42_0._sceneTf), 0, 1, 0.2)
		local var_42_4 = var_3.setOnUpdate

		System = var_6

		local var_42_5 = var_42_4(var_42_3, var_6.Action_float(function(arg_43_0)
			if arg_42_1 then
				arg_42_0._bgBackCanvas.alpha = arg_43_0
				arg_42_0._bgFrontCanvas.alpha = arg_43_0
				arg_42_0._bgBeamCanvas.alpha = 1 - arg_43_0
			else
				arg_42_0._bgBackCanvas.alpha = 1 - arg_43_0
				arg_42_0._bgFrontCanvas.alpha = 1 - arg_43_0
				arg_42_0._bgBeamCanvas.alpha = arg_43_0
			end

			return
		end))
		local var_42_6 = var_3.setOnComplete

		System = var_6

		var_42_6(var_42_5, var_6.Action(function()
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

local function var_0_116(arg_45_0, arg_45_1)
	local var_45_0 = {
		ctor = function(arg_46_0)
			arg_46_0._scene = arg_45_0
			findTF = var_1
			arg_46_0._tpl = var_1(arg_46_0._scene, "tpl")
			findTF = var_1
			arg_46_0._leftRolePos = var_1(arg_46_0._scene, "rolePos/leftRole")
			findTF = var_1
			arg_46_0._rightRolePos = var_1(arg_46_0._scene, "rolePos/rightRole")
			arg_46_0._event = arg_45_1

			local var_46_0 = arg_46_0._event

			var_1.bind(var_46_0, var_0_14, function()
				local var_47_0 = arg_46_0

				var_0.onGridTrigger(var_47_0)

				return
			end)

			local var_46_1 = arg_46_0._event

			var_1.bind(var_46_1, var_0_17, function()
				local var_48_0 = arg_46_0

				var_0.onRoleSpecial(var_48_0)

				return
			end)

			local var_46_2 = arg_46_0._event

			var_1.bind(var_46_2, var_0_18, function()
				local var_49_0 = arg_46_0

				var_0.onRoleSpecialEnd(var_49_0)

				return
			end)

			return
		end,
		start = function(arg_50_0)
			if arg_50_0.leftRole then
				destroy = var_1

				var_1(arg_50_0.leftRole.tf)

				arg_50_0.leftRole = nil
			end

			if arg_50_0.rightRole then
				destroy = var_1

				var_1(arg_50_0.rightRole.tf)

				arg_50_0.rightRole = nil
			end

			arg_50_0.leftRole = arg_50_0:createRole(var_0_32, true, arg_50_0._leftRolePos)
			arg_50_0.rightRole = arg_50_0:createRole(var_0_33, false, arg_50_0._rightRolePos)
			arg_50_0.leftRole.targetRole = arg_50_0.rightRole
			arg_50_0.rightRole.targetRole = arg_50_0.leftRole

			local var_50_0 = arg_50_0.leftRole.animator

			var_1.SetTrigger(var_50_0, "idle")

			local var_50_1 = arg_50_0.leftRole.animator

			var_1.SetBool(var_50_1, "special", false)

			local var_50_2 = arg_50_0.rightRole.animator

			var_1.SetTrigger(var_50_2, "idle")

			local var_50_3 = arg_50_0.rightRole.animator

			var_1.SetBool(var_50_3, "special", false)

			arg_50_0.leftRole.specialBody = false
			arg_50_0.rightRole.specialBody = false

			local var_50_4 = arg_50_0.leftRole

			Vector2 = var_2
			var_50_4.anchoredPosition = var_2(0, 0)

			local var_50_5 = arg_50_0.rightRole

			Vector2 = var_2
			var_50_5.anchoredPosition = var_2(0, 0)
			arg_50_0.leftRole.specialTime = false
			arg_50_0.rightRole.specialTime = false
			arg_50_0.playingDatas = {}
			arg_50_0.playingDatas[arg_50_0.leftRole.name] = {
				role = arg_50_0.leftRole
			}
			arg_50_0.playingDatas[arg_50_0.leftRole.name].skillDatas = {}
			arg_50_0.playingDatas[arg_50_0.rightRole.name] = {
				role = arg_50_0.rightRole
			}
			arg_50_0.playingDatas[arg_50_0.rightRole.name].skillDatas = {}
			arg_50_0.skillDeltaTime = 0
			math = var_1
			arg_50_0.emptySkillTime = var_1.random(1, 2)
			arg_50_0.addScore = {
				0,
				0
			}

			local var_50_6 = arg_50_0._event
			local var_50_7 = var_1.emit
			local var_50_8 = var_0_15
			local var_50_9 = {
				nil,
				false
			}

			Vector2 = var_6
			var_50_9[1] = var_6(0, 0)

			var_50_7(var_50_6, var_50_8, var_50_9)

			return
		end,
		step = function(arg_51_0)
			arg_51_0:checkSkillDeltaTime()
			arg_51_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_52_0)
			if arg_52_0.skillDeltaTime and arg_52_0.skillDeltaTime <= 0 then
				arg_52_0.skillDeltaTime = var_0_40
			end

			local var_52_0 = arg_52_0.skillDeltaTime

			Time = var_2_10002
			arg_52_0.skillDeltaTime = var_52_0 - var_2_10002.deltaTime

			local var_52_1

			if arg_52_0.skillDeltaTime <= 0 then
				var_52_1 = false
				pairs = var_2

				for iter_52_0, iter_52_1 in var_2(arg_52_0.playingDatas) do
					if iter_52_1.inPlaying then
						var_52_1 = true
					end
				end

				if not var_52_1 then
					pairs = var_2

					for iter_52_2, iter_52_3 in var_2(arg_52_0.playingDatas) do
						if #iter_52_3.skillDatas > 0 then
							if iter_52_3.role == arg_52_0.leftRole then
								print = var_7

								var_7("开始执行角色攻击")
							end

							arg_52_0:applySkillData(iter_52_3)

							break
						end
					end
				end
			end

			var_0_113 = false
			pairs = var_52_1

			for iter_52_4, iter_52_5 in var_52_1(arg_52_0.playingDatas) do
				if iter_52_5.inPlaying then
					var_0_113 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_53_0)
			if arg_53_0.emptySkillTime and arg_53_0.emptySkillTime <= 0 then
				arg_53_0.emptySkillTime = var_0_41
			end

			local var_53_0 = arg_53_0.emptySkillTime

			Time = var_2_10002
			arg_53_0.emptySkillTime = var_53_0 - var_2_10002.deltaTime

			if arg_53_0.emptySkillTime <= 0 then
				local var_53_1 = false

				pairs = var_2

				for iter_53_0, iter_53_1 in var_2(arg_53_0.playingDatas) do
					if iter_53_1.inPlaying then
						var_53_1 = true
					end
				end

				if not var_53_1 and arg_53_0:getRoleEmptySkill(arg_53_0.rightRole) then
					arg_53_0:addRolePlaying(arg_53_0.rightRole, var_2)
				end
			end

			return
		end,
		getRoleEmptySkill = function(arg_54_0, arg_54_1)
			local var_54_0 = {}

			for iter_54_0 = 1, #arg_54_1.skill do
				local var_54_1 = arg_54_1.skill[iter_54_0]

				tobool = var_2_10008

				if var_2_10008(var_54_1.special_time) == arg_54_1.specialBody and var_54_1.atk_index then
					table = var_2_10008

					var_2_10008.insert(var_54_0, var_54_1)
				end
			end

			if #var_54_0 > 0 then
				Clone = var_3
				math = var_5

				return var_3(var_54_0[var_5.random(1, #var_54_0)])
			end

			return nil
		end,
		onRoleSpecial = function(arg_55_0)
			arg_55_0.leftRole.specialTime = true

			for iter_55_0 = 1, #arg_55_0.leftRole.skill do
				if arg_55_0.leftRole.skill[iter_55_0].special_trigger then
					local var_55_0 = arg_55_0
					local var_55_1 = arg_55_0.addRolePlaying
					local var_55_2 = arg_55_0.leftRole

					Clone = var_2_10010

					var_55_1(var_55_0, var_55_2, var_2_10010(var_5))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_56_0)
			arg_56_0.leftRole.specialTime = false

			for iter_56_0 = 1, #arg_56_0.leftRole.skill do
				if not arg_56_0.leftRole.skill[iter_56_0].special_trigger and var_5.special_end then
					local var_56_0 = arg_56_0
					local var_56_1 = arg_56_0.addRolePlaying
					local var_56_2 = arg_56_0.leftRole

					Clone = var_2_10010

					var_56_1(var_56_0, var_56_2, var_2_10010(var_5))
				end
			end

			return
		end,
		clear = function(arg_57_0)
			LeanTween = var_2_10001

			local var_57_0 = var_2_10001.isTweening

			go = var_2_10003

			local var_57_1

			if var_57_0(var_2_10003(arg_57_0._leftRolePos)) then
				LeanTween = var_57_1
				var_57_1 = var_57_1.cancel
				go = var_3

				var_57_1(var_3(arg_57_0._leftRolePos))
			end

			LeanTween = var_57_1

			local var_57_2 = var_57_1.isTweening

			go = var_3

			local var_57_3

			if var_57_2(var_3(arg_57_0._rightRolePos)) then
				LeanTween = var_57_3
				var_57_3 = var_57_3.cancel
				go = var_3

				var_57_3(var_3(arg_57_0._rightRolePos))
			end

			LeanTween = var_57_3

			local var_57_4 = var_57_3.isTweening

			go = var_3

			local var_57_5

			if var_57_4(var_3(arg_57_0.rightRole.tf)) then
				LeanTween = var_57_5
				var_57_5 = var_57_5.cancel
				go = var_3

				var_57_5(var_3(arg_57_0.rightRole.tf))
			end

			LeanTween = var_57_5

			local var_57_6 = var_57_5.isTweening

			go = var_3

			if var_57_6(var_3(arg_57_0.leftRole.tf)) then
				LeanTween = var_1

				local var_57_7 = var_1.cancel

				go = var_3

				var_57_7(var_3(arg_57_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_58_0)
			local var_58_0 = var_0_22.grid_index
			local var_58_1 = var_0_22.power_grid
			local var_58_2 = var_0_22.special_time

			for iter_58_0 = 1, #arg_58_0.leftRole.skill do
				local var_58_3 = arg_58_0.leftRole.skill[iter_58_0]

				tobool = var_2_10009
				var_2_10009 = var_2_10009(var_58_3.special_time)
				tobool = var_2_10010

				if var_2_10009 == var_2_10010(arg_58_0.leftRole.specialTime) and var_58_3.power_index == var_58_1 then
					table = var_2_10009

					if var_2_10009.contains(var_58_3.grid_index, var_58_0) and var_58_3.atk_index then
						local var_58_4 = arg_58_0

						var_2_10009 = arg_58_0.addRolePlaying

						local var_58_5 = arg_58_0.leftRole

						Clone = var_2_10013

						var_2_10009(var_58_4, var_58_5, var_2_10013(var_58_3))
					end
				end
			end

			return
		end,
		createRole = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
			local var_59_0 = arg_59_0

			if not arg_59_0.getRoleData(var_59_0, arg_59_1) then
				return nil
			end

			local var_59_1 = {}

			tf = var_59_0
			instantiate = var_2_10008
			findTF = var_2_10010

			local var_59_2 = var_59_0(var_2_10008(var_2_10010(arg_59_0._tpl, var_4.name)))

			SetParent = var_7

			var_7(var_59_2, arg_59_3)

			Vector2 = var_7
			var_59_2.anchoredPosition = var_7(0, 0)
			Vector3 = var_7
			var_59_2.localScale = var_7(1, 1, 1)
			setActive = var_7

			var_7(var_59_2, true)

			findTF = var_7

			local var_59_3 = var_7(var_59_2, "body")

			findTF = var_8

			local var_59_4 = var_8(var_59_3, "anim")

			GetComponent = var_9

			local var_59_5 = var_59_4

			typeof = var_12
			Animator = var_2_10014

			local var_59_6 = var_9(var_59_5, var_12(var_2_10014))

			GetComponent = var_10

			local var_59_7 = var_59_4

			typeof = var_13
			DftAniEvent = var_2_10015

			local var_59_8 = var_10(var_59_7, var_13(var_2_10015))

			var_10.SetStartEvent(var_59_8, function()
				if var_59_1.startCallback then
					var_59_1.startCallback()
				end

				return
			end)
			var_10:SetTriggerEvent(function()
				if var_59_1.triggerCallback then
					var_59_1.triggerCallback()
				end

				return
			end)
			var_10:SetEndEvent(function()
				if var_59_1.endCallback then
					var_59_1.endCallback()
				end

				return
			end)

			var_59_1.name = var_4.name
			var_59_1.tf = var_59_2
			GetComponent = var_11

			local var_59_9 = var_59_2

			typeof = var_14
			CanvasGroup = var_2_10016
			var_59_1.canvasGroup = var_11(var_59_9, var_14(var_2_10016))
			var_59_1.body = var_59_3
			var_59_1.animTf = var_59_4
			var_59_1.animator = var_59_6
			var_59_1.dftEvent = var_10
			var_59_1.startCallback = nil
			var_59_1.triggerCallback = nil
			var_59_1.endCallback = nil
			var_59_1.skill = var_4.skill
			var_59_1.name = var_4.name
			var_59_1.index = var_4.index
			var_59_1.actions = var_4.actions

			return var_59_1
		end,
		getRoleData = function(arg_63_0, arg_63_1)
			for iter_63_0 = 1, #var_0_111 do
				if var_0_111[iter_63_0].index == arg_63_1 then
					Clone = var_6

					return var_6(var_0_111[iter_63_0])
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
			print = var_2_10003

			local var_65_0 = arg_65_1.name
			local var_65_1 = " 执行动画 ："
			local var_65_2 = arg_65_2
			local var_65_3 = "  active:"

			tostring = var_2_10009

			local var_65_4 = var_2_10009(arg_65_1.animator.isActiveAndEnabled)

			tostring = var_2_10010
			Time = var_2_10012

			var_2_10003(var_65_0 .. var_65_1 .. var_65_2 .. var_65_3 .. var_65_4 .. var_2_10010(var_2_10012.GetTimestamp()))

			local var_65_5 = arg_65_1.animator

			var_3.Play(var_65_5, "emptyAnimation", -1, 0)

			local var_65_6 = arg_65_1.animator

			var_3.Play(var_65_6, arg_65_2, -1, 0)

			return
		end,
		addRolePlaying = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			pairs = var_2_10004

			for iter_66_0, iter_66_1 in var_2_10004(arg_66_0.playingDatas) do
				if iter_66_0 == arg_66_1.name then
					if arg_66_3 then
						arg_66_0:applySkillData(iter_66_1, arg_66_2)
					else
						table = var_9

						var_9.insert(iter_66_1.skillDatas, arg_66_2)

						if arg_66_2.power_index > 0 and arg_66_2.atk_index > 1 or arg_66_2.special_trigger then
							for iter_66_2 = #iter_66_1.skillDatas - 1, 1, -1 do
								if iter_66_1.skillDatas[iter_66_2].power_index == 0 and var_13.atk_index == 1 then
									table = var_14

									if var_14.remove(iter_66_1.skillDatas, iter_66_2).score then
										arg_66_0.addScore = {
											arg_66_0.addScore[1] + var_14.score[1],
											arg_66_0.addScore[2] + var_14.score[2]
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
		applySkillData = function(arg_67_0, arg_67_1, arg_67_2)
			arg_67_1.inPlaying = true

			local var_67_0 = arg_67_1.role
			local var_67_1

			if not arg_67_2 then
				table = var_2_10005
				var_67_1 = var_2_10005.remove(arg_67_1.skillDatas, 1)
			end

			arg_67_1.currentSkill = var_67_1
			arg_67_1.actions = var_67_1.actions

			if var_67_1.anim_bool then
				local var_67_2 = var_67_0.animator

				var_6.SetBool(var_67_2, var_5, true)
			end

			if var_67_0 == arg_67_0.leftRole and not var_67_1.dmg_index then
				local var_67_3 = arg_67_0._leftRolePos

				var_6.SetSiblingIndex(var_67_3, 1)
			elseif var_67_0 == arg_67_0.rightRole and not var_67_1.dmg_index then
				local var_67_4 = arg_67_0._rightRolePos

				var_6.SetSiblingIndex(var_67_4, 1)
			end

			if var_67_1.special_end then
				arg_67_1.role.specialBody = false
			elseif var_67_1.special_trigger then
				arg_67_1.role.specialBody = true
			end

			arg_67_1.actionIndex = 1

			arg_67_0:checkAction(arg_67_1, function()
				local var_68_0 = arg_67_1

				var_68_0.inPlaying = false
				print = var_68_0

				var_68_0(arg_67_1.role.name .. "动画播放完毕")

				return
			end)

			return
		end,
		checkAction = function(arg_69_0, arg_69_1, arg_69_2)
			if arg_69_1.actions and arg_69_1.actionIndex <= #arg_69_1.actions then
				print = var_3

				local var_69_0 = "准备执行"
				local var_69_1 = arg_69_1.actions[arg_69_1.actionIndex].anim_name
				local var_69_2 = "上一个动作:"

				tostring = var_2_10008

				local var_69_3

				if arg_69_1.playingAction then
					var_69_3 = arg_69_1.playingAction.anim_name
				end

				var_3(var_69_0 .. var_69_1 .. var_69_2 .. var_2_10008(var_69_3))

				arg_69_1.playingAction = arg_69_1.actions[arg_69_1.actionIndex]
				arg_69_1.actionIndex = arg_69_1.actionIndex + 1

				local var_69_4 = arg_69_1.playingAction.anim_name
				local var_69_5 = arg_69_1.playingAction.time
				local var_69_6 = arg_69_1.playingAction.move
				local var_69_7 = arg_69_1.playingAction.over_offset
				local var_69_8 = arg_69_1.playingAction.camera
				local var_69_9 = arg_69_1.playingAction.sound_start
				local var_69_10 = arg_69_1.playingAction.sound_trigger
				local var_69_11 = arg_69_1.playingAction.sound_end
				local var_69_12 = arg_69_1.currentSkill.special_trigger
				local var_69_13 = arg_69_1.currentSkill.special_time
				local var_69_14 = arg_69_1.currentSkill.atk_index

				if var_69_12 or var_69_13 and var_69_14 and var_69_14 >= 2 then
					local var_69_15 = arg_69_0._event

					var_14.emit(var_69_15, var_0_21, true)
				end

				if var_69_5 and var_69_5 > 0 then
					-- block empty
				else
					local function var_69_16()
						if var_69_9 then
							pg = var_0

							local var_70_0 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_70_0, "event:/ui/" .. var_69_9)
						end

						if var_69_6 then
							local var_70_1 = arg_69_0

							var_0.moveRole(var_70_1, arg_69_1.role, var_69_6)
						end

						if var_69_8 then
							arg_69_1.role.targetRole.canvasGroup.alpha = 0

							local var_70_2 = arg_69_0._event

							var_0.emit(var_70_2, var_0_19)
						end

						return
					end

					local function var_69_17()
						if var_69_10 then
							pg = var_0

							local var_71_0 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_71_0, "event:/ui/" .. var_69_10)
						end

						if var_69_8 then
							var_69_8 = false
							arg_69_1.role.targetRole.canvasGroup.alpha = 1

							local var_71_1 = arg_69_0._event

							var_0.emit(var_71_1, var_0_20)
						elseif arg_69_1.currentSkill.atk_index then
							local var_71_2 = arg_69_0

							if var_1.getRoleDmgData(var_71_2, arg_69_1.role.targetRole, var_0) then
								local var_71_3 = arg_69_0
								local var_71_4 = var_2.addRolePlaying
								local var_71_5 = arg_69_1.role.targetRole

								Clone = var_3_10006

								var_71_4(var_71_3, var_71_5, var_3_10006(var_1), true)
							end

							if arg_69_1.currentSkill.score and arg_69_1.role == arg_69_0.leftRole then
								local var_71_6 = arg_69_0._event
								local var_71_7 = var_3.emit
								local var_71_8 = var_0_16

								math = var_3_10007

								var_71_7(var_71_6, var_71_8, var_3_10007.random(var_2[1] + arg_69_0.addScore[1], var_2[2] + arg_69_0.addScore[2]))

								arg_69_0.addScore = {
									0,
									0
								}
							end
						end

						return
					end

					local function var_69_18()
						if var_69_11 then
							pg = var_0
							var_3_10002 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_3_10002, "event:/ui/" .. var_69_11)
						end

						LeanTween = var_0

						local var_72_0 = var_0.isTweening

						go = var_3_10002

						if var_72_0(var_3_10002(arg_69_1.role.tf)) then
							LeanTween = var_0

							local var_72_1 = var_0.cancel

							go = var_2

							var_72_1(var_2(arg_69_1.role.tf))
						end

						local var_72_2 = arg_69_0._event

						var_0.emit(var_72_2, var_0_21, false)

						if var_69_7 then
							local var_72_3 = arg_69_1.role.tf

							Vector2 = var_3_10001
							var_72_3.anchoredPosition = var_3_10001(arg_69_1.role.tf.anchoredPosition.x + var_69_7.x, arg_69_1.role.tf.anchoredPosition.y + var_69_7.y)
						end

						if arg_69_1.currentSkill.special_trigger and var_0_22.special_time and not var_0_22.special_complete then
							var_0_22.special_complete = true
						end

						arg_69_1.playingAction = nil

						local var_72_4 = arg_69_0

						var_0.setDftHandle(var_72_4, arg_69_1.role, nil, nil, nil)

						print = var_0

						var_0(arg_69_1.role.name .. "执行 " .. var_69_4 .. "结束")

						local var_72_5 = arg_69_0

						var_0.checkAction(var_72_5, arg_69_1, arg_69_2)

						return
					end

					arg_69_0:setDftHandle(arg_69_1.role, var_69_16, var_69_17, var_69_18)
					arg_69_0:playAnimation(arg_69_1.role, var_69_4)
				end
			else
				if arg_69_1.role == arg_69_0.leftRole then
					print = var_3

					var_3(arg_69_1.role.name .. "队列结束")
				end

				if arg_69_2 then
					arg_69_2()
				end
			end

			return
		end,
		moveRole = function(arg_73_0, arg_73_1, arg_73_2)
			LeanTween = var_2_10003

			local var_73_0 = var_2_10003.isTweening

			go = var_2_10005

			if var_73_0(var_2_10005(arg_73_1.tf)) then
				LeanTween = var_3

				local var_73_1 = var_3.cancel

				go = var_5

				var_73_1(var_5(arg_73_1.tf))
			end

			local var_73_2 = arg_73_0._event

			var_3.emit(var_73_2, var_0_15, {
				arg_73_2.distance,
				arg_73_1 == arg_73_0.leftRole
			})

			LeanTween = var_3

			local var_73_3 = var_3.move
			local var_73_4 = arg_73_1.tf

			Vector3 = var_6

			local var_73_5 = var_73_3(var_73_4, var_6(arg_73_2.distance.x, arg_73_2.distance.y, 0), arg_73_2.time)
			local var_73_6 = var_3.setEase
			local var_73_7

			if not arg_73_2.ease then
				LeanTweenType = var_73_7
				var_73_7 = var_73_7.linear
			end

			var_73_6(var_73_5, var_73_7)

			return
		end,
		getRoleDmgData = function(arg_74_0, arg_74_1, arg_74_2)
			local var_74_0 = arg_74_1.skill

			for iter_74_0 = 1, #var_74_0 do
				if var_74_0[iter_74_0].dmg_index == arg_74_2 then
					local var_74_1 = var_8.special_time

					tobool = var_2_10010

					if var_74_1 == var_2_10010(arg_74_1.specialBody) then
						return var_8
					end
				end
			end

			return nil
		end
	}

	var_2.ctor(var_45_0)

	return var_2
end

function var_0_1.getUIName(arg_75_0)
	return "GridGameUI"
end

function var_0_1.didEnter(arg_76_0)
	arg_76_0:initEvent()
	arg_76_0:initData()
	arg_76_0:initUI()
	arg_76_0:initGameUI()
	arg_76_0:initController()
	arg_76_0:updateMenuUI()
	arg_76_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_77_0)
	arg_77_0:bind(var_0_16, function(arg_78_0, arg_78_1, arg_78_2)
		local var_78_0 = arg_77_0

		var_3.addScore(var_78_0, arg_78_1)

		return
	end)
	arg_77_0:bind(var_0_21, function(arg_79_0, arg_79_1, arg_79_2)
		arg_77_0.ignoreTime = arg_79_1

		return
	end)

	return
end

function var_0_1.onEventHandle(arg_80_0, arg_80_1)
	return
end

function var_0_1.initData(arg_81_0)
	Application = var_1_10001

	local var_81_0

	if not var_1_10001.targetFrameRate then
		var_81_0 = 60
	end

	if 60 < var_81_0 then
		var_81_0 = 60
	end

	Timer = var_2
	arg_81_0.timer = var_2.New(function()
		local var_82_0 = arg_81_0

		var_0.onTimer(var_82_0)

		return
	end, 1 / var_81_0, -1)

	return
end

function var_0_1.initUI(arg_83_0)
	findTF = var_1_10001
	arg_83_0.backSceneTf = var_1_10001(arg_83_0._tf, "scene_background")
	findTF = var_1
	arg_83_0.sceneTf = var_1(arg_83_0._tf, "scene")
	findTF = var_1
	arg_83_0.clickMask = var_1(arg_83_0._tf, "clickMask")
	setText = var_1
	findTF = var_3

	local var_83_0 = var_3(arg_83_0._tf, "ui/gameUI/top/time")

	i18n = var_4

	var_1(var_83_0, var_4("mini_game_time"))

	setText = var_1
	findTF = var_83_0

	local var_83_1 = var_83_0(arg_83_0._tf, "ui/gameUI/top/scoreDesc")

	i18n = var_4

	var_1(var_83_1, var_4("mini_game_score"))

	setText = var_1
	findTF = var_83_1

	local var_83_2 = var_83_1(arg_83_0._tf, "pop/LeaveUI/ad/desc")

	i18n = var_4

	var_1(var_83_2, var_4("mini_game_leave"))

	setText = var_1
	findTF = var_83_2

	local var_83_3 = var_83_2(arg_83_0._tf, "pop/pauseUI/ad/desc")

	i18n = var_4

	var_1(var_83_3, var_4("mini_game_pause"))

	setText = var_1
	findTF = var_83_3

	local var_83_4 = var_83_3(arg_83_0._tf, "pop/SettleMentUI/ad/currentTextDesc")

	i18n = var_4

	var_1(var_83_4, var_4("mini_game_cur_score"))

	setText = var_1
	findTF = var_83_4

	local var_83_5 = var_83_4(arg_83_0._tf, "pop/SettleMentUI/ad/highTextDesc")

	i18n = var_4

	var_1(var_83_5, var_4("mini_game_high_score"))

	findTF = var_1
	arg_83_0.countUI = var_1(arg_83_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_83_6 = var_3(arg_83_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_83_0.countAnimator = var_1(var_83_6, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_83_6

	local var_83_7 = var_83_6(arg_83_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_83_0.countDft = var_1(var_83_7, var_4(var_6))

	local var_83_8 = arg_83_0.countDft

	var_1.SetTriggerEvent(var_83_8, function()
		return
	end)

	local var_83_9 = arg_83_0.countDft

	var_1.SetEndEvent(var_83_9, function()
		setActive = var_2_10000

		var_2_10000(arg_83_0.countUI, false)

		local var_85_0 = arg_83_0

		var_0.gameStart(var_85_0)

		return
	end)

	findTF = var_1
	arg_83_0.leaveUI = var_1(arg_83_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_83_10 = arg_83_0

	findTF = var_4

	local var_83_11 = var_4(arg_83_0.leaveUI, "ad/btnOk")

	local function var_83_12()
		local var_86_0 = arg_83_0

		var_0.resumeGame(var_86_0)

		local var_86_1 = arg_83_0

		var_0.onGameOver(var_86_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_83_10, var_83_11, var_83_12, var_6)

	onButton = var_1

	local var_83_13 = arg_83_0

	findTF = var_83_11

	local var_83_14 = var_83_11(arg_83_0.leaveUI, "ad/btnCancel")

	local function var_83_15()
		local var_87_0 = arg_83_0

		var_0.resumeGame(var_87_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_83_13, var_83_14, var_83_15, var_6)

	findTF = var_1
	arg_83_0.pauseUI = var_1(arg_83_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_83_16 = arg_83_0

	findTF = var_4

	local var_83_17 = var_4(arg_83_0.pauseUI, "ad/btnOk")

	local function var_83_18()
		setActive = var_2_10000

		var_2_10000(arg_83_0.pauseUI, false)

		local var_88_0 = arg_83_0

		var_0.resumeGame(var_88_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_83_16, var_83_17, var_83_18, var_6)

	findTF = var_1
	arg_83_0.settlementUI = var_1(arg_83_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_83_19 = arg_83_0

	findTF = var_4

	local var_83_20 = var_4(arg_83_0.settlementUI, "ad/btnOver")

	local function var_83_21()
		setActive = var_2_10000

		var_2_10000(arg_83_0.settlementUI, false)

		local var_89_0 = arg_83_0

		var_0.openMenuUI(var_89_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_83_19, var_83_20, var_83_21, var_6)

	findTF = var_1
	arg_83_0.selectedUI = var_1(arg_83_0._tf, "pop/selectedUI")
	arg_83_0.leftSelectRole = {}

	for iter_83_0 = 1, #var_0_34 do
		findTF = var_83_21
		var_83_21 = var_83_21(arg_83_0.selectedUI, "ad/leftRole/role" .. var_0_34[iter_83_0])

		local var_83_22 = var_0_34[iter_83_0]

		onButton = var_7
		var_1_10009 = arg_83_0

		local var_83_23 = var_83_21

		local function var_83_24()
			if var_0_33 == var_83_22 then
				var_0_33 = var_0_32
			end

			var_0_32 = var_83_22

			local var_90_0 = arg_83_0

			var_0.updateSelectedUI(var_90_0)

			return
		end

		SFX_CONFIRM = var_1_10012

		var_7(var_1_10009, var_83_23, var_83_24, var_1_10012)

		table = var_7

		var_7.insert(arg_83_0.leftSelectRole, {
			id = var_83_22,
			tf = var_83_21
		})
	end

	onButton = var_1

	local var_83_25 = arg_83_0

	findTF = iter_83_0

	local var_83_26 = iter_83_0(arg_83_0.selectedUI, "close")

	local function var_83_27()
		setActive = var_2_10000

		var_2_10000(arg_83_0.selectedUI, false)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_83_25, var_83_26, var_83_27, var_6)

	arg_83_0.rightSelectRole = {}

	for iter_83_1 = 1, #var_0_35 do
		findTF = var_83_27
		var_83_27 = var_83_27(arg_83_0.selectedUI, "ad/rightRole/role" .. var_0_35[iter_83_1])

		local var_83_28 = var_0_35[iter_83_1]

		onButton = var_7
		var_1_10009 = arg_83_0

		local var_83_29 = var_83_27

		local function var_83_30()
			if var_0_32 == var_83_28 then
				var_0_32 = var_0_33
				table = var_0

				if not var_0.contains(var_0_34, var_0_32) then
					ipairs = var_0

					for iter_92_0, iter_92_1 in var_0(var_0_34) do
						if iter_92_1 ~= var_83_28 then
							var_0_32 = iter_92_1
						end
					end
				end
			end

			var_0_33 = var_83_28

			local var_92_0 = arg_83_0

			var_0.updateSelectedUI(var_92_0)

			return
		end

		SFX_CONFIRM = var_1_10012

		var_7(var_1_10009, var_83_29, var_83_30, var_1_10012)

		table = var_7

		var_7.insert(arg_83_0.rightSelectRole, {
			id = var_83_28,
			tf = var_83_27
		})
	end

	onButton = var_1

	local var_83_31 = arg_83_0

	findTF = iter_83_1

	local var_83_32 = iter_83_1(arg_83_0.selectedUI, "ad/btnOk")

	local function var_83_33()
		setActive = var_2_10000

		var_2_10000(arg_83_0.selectedUI, false)

		setActive = var_2_10000

		var_2_10000(arg_83_0.menuUI, false)

		local var_93_0 = arg_83_0

		var_0.readyStart(var_93_0)

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_83_31, var_83_32, var_83_33, var_6)

	setActive = var_1

	var_1(arg_83_0.selectedUI, false)

	findTF = var_1
	arg_83_0.menuUI = var_1(arg_83_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_3

	local var_83_34 = var_3(arg_83_0.menuUI, "battList")

	typeof = var_4
	ScrollRect = var_6
	arg_83_0.battleScrollRect = var_1(var_83_34, var_4(var_6))
	arg_83_0.totalTimes = arg_83_0:getGameTotalTime()

	local var_83_35 = arg_83_0:getGameUsedTimes() - 4 < 0 and 0 or arg_83_0:getGameUsedTimes() - 4

	scrollTo = var_2

	var_2(arg_83_0.battleScrollRect, 0, 1 - var_83_35 / (arg_83_0.totalTimes - 4))

	onButton = var_2

	local var_83_36 = arg_83_0

	findTF = var_5

	local var_83_37 = var_5(arg_83_0.menuUI, "rightPanelBg/arrowUp")

	local function var_83_38()
		local var_94_0 = arg_83_0.battleScrollRect.normalizedPosition.y + 1 / (arg_83_0.totalTimes - 4)

		if 1 < var_94_0 then
			var_94_0 = 1
		end

		scrollTo = var_1

		var_1(arg_83_0.battleScrollRect, 0, var_94_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_83_36, var_83_37, var_83_38, var_7)

	onButton = var_2

	local var_83_39 = arg_83_0

	findTF = var_83_37

	local var_83_40 = var_83_37(arg_83_0.menuUI, "rightPanelBg/arrowDown")

	local function var_83_41()
		local var_95_0

		if arg_83_0.battleScrollRect.normalizedPosition.y - 1 / (arg_83_0.totalTimes - 4) < 0 then
			var_95_0 = 0
		end

		scrollTo = var_1

		var_1(arg_83_0.battleScrollRect, 0, var_95_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_83_39, var_83_40, var_83_41, var_7)

	onButton = var_2

	local var_83_42 = arg_83_0

	findTF = var_83_40

	local var_83_43 = var_83_40(arg_83_0.menuUI, "btnBack")

	local function var_83_44()
		local var_96_0 = arg_83_0

		var_0.closeView(var_96_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_83_42, var_83_43, var_83_44, var_7)

	onButton = var_2

	local var_83_45 = arg_83_0

	findTF = var_83_43

	local var_83_46 = var_83_43(arg_83_0.menuUI, "btnRule")

	local function var_83_47()
		pg = var_2_10000

		local var_97_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_97_1 = var_0.ShowMsgBox
		local var_97_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_97_2.type = var_2_10004
		pg = var_2_10004
		var_97_2.helps = var_2_10004.gametip.ssss_game_tip.tip

		var_97_1(var_97_0, var_97_2)

		return
	end

	SFX_CONFIRM = var_7

	var_2(var_83_45, var_83_46, var_83_47, var_7)

	onButton = var_2

	local var_83_48 = arg_83_0

	findTF = var_83_46

	local var_83_49 = var_83_46(arg_83_0.menuUI, "btnStart")

	local function var_83_50()
		local var_98_0 = arg_83_0
		local var_98_1

		if not var_0.getGameUsedTimes(var_98_0) then
			var_98_1 = 0
		end

		local var_98_2 = arg_83_0
		local var_98_3

		if not var_1.getGameTimes(var_98_2) then
			var_98_3 = 0
		end

		if var_98_1 >= #var_0_36 and arg_83_0.selectedUI then
			local var_98_4 = arg_83_0

			var_2.updateSelectedUI(var_98_4)

			setActive = var_2

			var_2(arg_83_0.selectedUI, true)
		else
			local var_98_5
			local var_98_6

			if (var_98_1 == 0 and 1 or var_98_3 > 0 and var_98_1 + 1 or var_98_1) > #var_0_36 then
				var_98_6 = #var_0_36
			end

			var_0_32 = var_0_36[var_98_6][1]
			var_0_33 = var_3[2]
			setActive = var_4

			var_4(arg_83_0.menuUI, false)

			local var_98_7 = arg_83_0

			var_4.readyStart(var_98_7)
		end

		return
	end

	SFX_CONFIRM = var_83_52

	var_2(var_83_48, var_83_49, var_83_50, var_83_52)

	findTF = var_2

	local var_83_51 = var_2(arg_83_0.menuUI, "tplBattleItem")

	arg_83_0.battleItems = {}
	arg_83_0.dropItems = {}

	for iter_83_2 = 1, 7 do
		tf = var_83_52
		instantiate = var_1_10009

		local var_83_52 = var_83_52(var_1_10009(var_83_51))

		var_83_52.name = "battleItem_" .. iter_83_2
		setParent = var_8

		local var_83_53 = var_83_52

		findTF = var_11

		var_8(var_83_53, var_11(arg_83_0.menuUI, "battList/Viewport/Content"))

		local var_83_54 = iter_83_2

		GetSpriteFromAtlasAsync = var_1_10009

		var_1_10009("ui/gridgameui_atlas", "battleDesc" .. var_83_54, function(arg_99_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_83_52, "state_open/buttomDesc"), arg_99_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_83_52, "state_clear/buttomDesc"), arg_99_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_83_52, "state_current/buttomDesc"), arg_99_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_83_52, "state_closed/buttomDesc"), arg_99_0, true)

			return
		end)

		setActive = var_1_10009

		var_1_10009(var_83_52, true)

		table = var_1_10009

		var_1_10009.insert(arg_83_0.battleItems, var_83_52)
	end

	if not arg_83_0.handle then
		UpdateBeat = var_3
		arg_83_0.handle = var_3:CreateListener(arg_83_0.Update, arg_83_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_83_0.handle)

	return
end

function var_0_1.initGameUI(arg_100_0)
	findTF = var_1_10001
	arg_100_0.gameUI = var_1_10001(arg_100_0._tf, "ui/gameUI")
	onButton = var_1

	local var_100_0 = arg_100_0

	findTF = var_4

	var_1(var_100_0, var_4(arg_100_0.gameUI, "topRight/btnStop"), function()
		local var_101_0 = arg_100_0

		var_0.stopGame(var_101_0)

		setActive = var_0

		var_0(arg_100_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_100_1 = arg_100_0

	findTF = var_4

	var_1(var_100_1, var_4(arg_100_0.gameUI, "btnLeave"), function()
		local var_102_0 = arg_100_0

		var_0.stopGame(var_102_0)

		setActive = var_0

		var_0(arg_100_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_100_0.gameTimeS = var_1(arg_100_0.gameUI, "top/time/s")
	findTF = var_1
	arg_100_0.scoreTf = var_1(arg_100_0.gameUI, "top/score")
	findTF = var_1
	arg_100_0.scoreAnimTf = var_1(arg_100_0._tf, "sceneContainer/scene_front/scoreAnim")
	findTF = var_1
	arg_100_0.scoreAnimTextTf = var_1(arg_100_0._tf, "sceneContainer/scene_front/scoreAnim/text")
	setActive = var_1

	var_1(arg_100_0.scoreAnimTf, false)

	return
end

function var_0_1.initController(arg_103_0)
	findTF = var_1_10001

	local var_103_0 = var_1_10001(arg_103_0.gameUI, "box")

	arg_103_0.boxController = var_0_112(var_103_0, arg_103_0)
	findTF = var_2

	local var_103_1 = var_2(arg_103_0.gameUI, "specialPower")

	findTF = var_3

	local var_103_2 = var_3(arg_103_0.gameUI, "successPower")

	arg_103_0.specialController = var_0_114(var_103_1, var_103_2, arg_103_0)
	findTF = var_4

	local var_103_3 = var_4(arg_103_0._tf, "sceneContainer")

	arg_103_0.bgController = var_0_115(var_103_3, arg_103_0.gameUI, arg_103_0)
	findTF = var_5

	local var_103_4 = var_5(arg_103_0._tf, "sceneContainer/scene")

	arg_103_0.roleController = var_0_116(var_103_4, arg_103_0)

	return
end

function var_0_1.Update(arg_104_0)
	arg_104_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_105_0)
	if arg_105_0.gameStop or arg_105_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateSelectedUI(arg_106_0)
	for iter_106_0 = 1, #arg_106_0.leftSelectRole do
		local var_106_0 = arg_106_0.leftSelectRole[iter_106_0]

		if var_0_32 == var_106_0.id then
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_0.tf, "selected"), true)

			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_0.tf, "unSelected"), false)
		else
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_0.tf, "selected"), false)

			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_0.tf, "unSelected"), true)
		end
	end

	for iter_106_1 = 1, #arg_106_0.rightSelectRole do
		local var_106_1 = arg_106_0.rightSelectRole[iter_106_1]

		if var_0_33 == var_106_1.id then
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_1.tf, "selected"), true)

			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_1.tf, "unSelected"), false)
		else
			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_1.tf, "selected"), false)

			setActive = var_6
			findTF = var_1_10008

			var_6(var_1_10008(var_106_1.tf, "unSelected"), true)
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_107_0)
	if arg_107_0:getGameUsedTimes() and 7 <= var_1 then
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_107_0.menuUI, "btnStart/free"), true)
	else
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_107_0.menuUI, "btnStart/free"), false)
	end

	local var_107_0 = arg_107_0:getGameTimes()

	for iter_107_0 = 1, #arg_107_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_current"), false)

		if iter_107_0 <= var_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_clear"), true)
		elseif iter_107_0 == var_1 + 1 and 1 <= var_107_0 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_current"), true)
		elseif var_1 < iter_107_0 and iter_107_0 <= var_1 + var_107_0 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_107_0.battleItems[iter_107_0], "state_closed"), true)
		end
	end

	arg_107_0.totalTimes = arg_107_0:getGameTotalTime()

	local var_107_1 = 1 - (arg_107_0:getGameUsedTimes() - 3 < 0 and 0 or arg_107_0:getGameUsedTimes() - 3) / (arg_107_0.totalTimes - 4)

	if 1 < var_107_1 then
		var_107_1 = 1
	end

	scrollTo = var_5

	var_5(arg_107_0.battleScrollRect, 0, var_107_1)

	setActive = var_5
	findTF = var_7

	var_5(var_7(arg_107_0.menuUI, "btnStart/tip"), var_107_0 > 0)
	arg_107_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_108_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_108_0.menuUI, "got"), false)

	if arg_108_0:getUltimate() then
		local var_108_0 = arg_108_0

		if arg_108_0.getUltimate(var_108_0) ~= 0 then
			setActive = var_1
			findTF = var_108_0

			var_1(var_108_0(arg_108_0.menuUI, "got"), true)
		end
	end

	if arg_108_0:getUltimate() == 0 then
		local var_108_1 = arg_108_0

		if arg_108_0.getGameTotalTime(var_108_1) > arg_108_0:getGameUsedTimes() then
			return
		end

		pg = var_108_1

		local var_108_2 = var_108_1.m02
		local var_108_3 = var_3.sendNotification

		GAME = var_6

		local var_108_4 = var_6.SEND_MINI_GAME_OP
		local var_108_5 = {
			hubid = arg_108_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_108_5.cmd = var_8.CMD_ULTIMATE
		var_108_5.args1 = {}

		var_108_3(var_108_2, var_108_4, var_108_5)

		setActive = var_108_3
		findTF = var_108_2

		var_108_3(var_108_2(arg_108_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_109_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_109_0._tf, "sceneContainer/scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_109_0._tf, "sceneContainer/scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_109_0._tf, "sceneContainer/scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_109_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_109_0.menuUI, true)

	setActive = var_1_10001

	var_1_10001(arg_109_0.selectedUI, false)
	arg_109_0:updateMenuUI()

	local var_109_1

	if not arg_109_0:getBGM() then
		pg = var_1_10002

		local var_109_0 = var_1_10002.CriMgr.GetInstance()

		if var_2.IsDefaultBGM(var_109_0) then
			pg = var_2
			var_109_1 = var_2.voice_bgm.NewMainScene.default_bgm
		else
			pg = var_2
			var_109_1 = var_2.voice_bgm.NewMainScene.bgm
		end
	end

	if arg_109_0.bgm ~= var_109_1 then
		arg_109_0.bgm = var_109_1
		pg = var_2

		local var_109_2 = var_2.BgmMgr.GetInstance()

		var_2.Push(var_109_2, arg_109_0.__cname, var_109_1)
	end

	return
end

function var_0_1.clearUI(arg_110_0)
	setActive = var_1_10001

	var_1_10001(arg_110_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_110_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_110_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_110_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_110_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_110_0.selectedUI, false)

	return
end

function var_0_1.readyStart(arg_111_0)
	setActive = var_1_10001

	var_1_10001(arg_111_0.countUI, true)

	local var_111_0 = arg_111_0.countAnimator

	var_1.Play(var_111_0, "count")

	pg = var_1

	local var_111_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_111_1, var_0_3)

	if var_0_2 and arg_111_0.bgm ~= var_0_2 then
		arg_111_0.bgm = var_0_2
		pg = var_1

		local var_111_2 = var_1.BgmMgr.GetInstance()

		var_1.Push(var_111_2, arg_111_0.__cname, var_0_2)
	end

	return
end

function var_0_1.gameStart(arg_112_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_112_0._tf, "sceneContainer/scene_front"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_112_0._tf, "sceneContainer/scene_background"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_112_0._tf, "sceneContainer/scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_112_0.scoreAnimTf, false)

	setActive = var_1_10001

	var_1_10001(arg_112_0.gameUI, true)

	arg_112_0.gameStartFlag = true
	arg_112_0.scoreNum = 0
	arg_112_0.playerPosIndex = 2
	arg_112_0.gameStepTime = 0
	arg_112_0.gameTime = var_0_6
	arg_112_0.ignoreTime = false

	local var_112_0 = arg_112_0.boxController

	var_1.start(var_112_0)

	local var_112_1 = arg_112_0.specialController

	var_1.start(var_112_1)

	local var_112_2 = arg_112_0.bgController

	var_1.start(var_112_2)

	local var_112_3 = arg_112_0.roleController

	var_1.start(var_112_3)
	arg_112_0:updateGameUI()
	arg_112_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_113_0)
	return arg_113_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_114_0)
	return arg_114_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_115_0)
	return arg_115_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_116_0)
	local var_116_0 = arg_116_0:GetMGHubData()

	return (var_1.getConfig(var_116_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_117_0, arg_117_1)
	return
end

function var_0_1.onTimer(arg_118_0)
	arg_118_0:gameStep()

	return
end

function var_0_1.gameStep(arg_119_0)
	if not arg_119_0.ignoreTime then
		local var_119_0 = arg_119_0.gameTime

		Time = var_1_10002
		arg_119_0.gameTime = var_119_0 - var_1_10002.deltaTime

		if arg_119_0.gameTime < 0 then
			arg_119_0.gameTime = 0
		end

		local var_119_1 = arg_119_0.gameStepTime

		Time = var_2
		arg_119_0.gameStepTime = var_119_1 + var_2.deltaTime
	end

	local var_119_2 = arg_119_0.boxController

	var_1.step(var_119_2)

	local var_119_3 = arg_119_0.specialController

	var_1.step(var_119_3)

	local var_119_4 = arg_119_0.bgController

	var_1.step(var_119_4)

	local var_119_5 = arg_119_0.roleController

	var_1.step(var_119_5)
	arg_119_0:updateGameUI()

	if arg_119_0.gameTime <= 0 then
		arg_119_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_120_0)
	if not arg_120_0.timer.running then
		local var_120_0 = arg_120_0.timer

		var_1.Start(var_120_0)
	end

	return
end

function var_0_1.timerStop(arg_121_0)
	if arg_121_0.timer.running then
		local var_121_0 = arg_121_0.timer

		var_1.Stop(var_121_0)
	end

	return
end

function var_0_1.updateGameUI(arg_122_0)
	setText = var_1_10001

	var_1_10001(arg_122_0.scoreTf, arg_122_0.scoreNum)

	setText = var_1_10001

	local var_122_0 = arg_122_0.gameTimeS

	math = var_4

	var_1_10001(var_122_0, var_4.ceil(arg_122_0.gameTime))

	return
end

function var_0_1.addScore(arg_123_0, arg_123_1)
	setActive = var_1_10002

	var_1_10002(arg_123_0.scoreAnimTf, false)

	setActive = var_1_10002

	var_1_10002(arg_123_0.scoreAnimTf, true)

	setText = var_1_10002

	local var_123_0 = arg_123_0.scoreAnimTextTf
	local var_123_1 = "+"

	tostring = var_1_10006

	var_1_10002(var_123_0, var_123_1 .. var_1_10006(arg_123_1))

	arg_123_0.scoreNum = arg_123_0.scoreNum + arg_123_1

	if arg_123_0.scoreNum < 0 then
		arg_123_0.scoreNum = 0
	end

	return
end

function var_0_1.onGameOver(arg_124_0)
	if arg_124_0.settlementFlag then
		return
	end

	arg_124_0:timerStop()

	arg_124_0.settlementFlag = true
	setActive = var_1

	var_1(arg_124_0.clickMask, true)

	local var_124_0

	if arg_124_0.roleController then
		var_124_0 = arg_124_0.roleController

		var_1.clear(var_124_0)
	end

	if arg_124_0.bgController then
		var_124_0 = arg_124_0.bgController

		var_1.clear(var_124_0)
	end

	LeanTween = var_1

	local var_124_1 = var_1.delayedCall

	go = var_124_0

	local var_124_2 = var_124_0(arg_124_0._tf)
	local var_124_3 = 0.1

	System = var_5

	var_124_1(var_124_2, var_124_3, var_5.Action(function()
		arg_124_0.settlementFlag = false

		local var_125_0 = arg_124_0

		var_125_0.gameStartFlag = false
		setActive = var_125_0

		var_125_0(arg_124_0.clickMask, false)

		local var_125_1 = arg_124_0

		var_0.showSettlement(var_125_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_126_0)
	setActive = var_1_10001

	var_1_10001(arg_126_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_126_0 = var_3(arg_126_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_126_1 = var_1_10001(var_126_0, var_4(var_6))

	var_1.Play(var_126_1, "settlement", -1, 0)

	local var_126_2 = arg_126_0:GetMGData()
	local var_126_3 = var_2.GetRuntimeData(var_126_2, "elements")
	local var_126_4 = arg_126_0.scoreNum

	if var_126_3 then
		local var_126_5 = #var_126_3
		local var_126_6

		if not (0 < var_126_5) or not var_126_3[1] then
			var_126_6 = 0
		end

		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_126_0.settlementUI, "ad/new"), var_126_6 < var_126_4)

		if var_126_6 <= var_126_4 then
			var_126_6 = var_126_4

			arg_126_0:StoreDataToServer({
				var_126_6
			})
		end

		findTF = var_5

		local var_126_7 = var_5(arg_126_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_126_8 = var_6(arg_126_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_126_7, var_126_6)

		setText = var_7

		var_7(var_126_8, var_126_4)

		if arg_126_0:getGameTimes() and arg_126_0:getGameTimes() > 0 then
			arg_126_0.sendSuccessFlag = true

			arg_126_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_127_0)
	arg_127_0.gameStop = false
	setActive = var_1

	var_1(arg_127_0.leaveUI, false)
	arg_127_0:changeSpeed(1)
	arg_127_0:timerStart()

	return
end

function var_0_1.stopGame(arg_128_0)
	arg_128_0.gameStop = true

	arg_128_0:timerStop()
	arg_128_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_129_0)
	if not arg_129_0.gameStartFlag then
		arg_129_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_129_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_129_0.pauseUI) then
			setActive = var_1

			var_1(arg_129_0.pauseUI, false)
		end

		arg_129_0:stopGame()

		setActive = var_1

		var_1(arg_129_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_130_0)
	if arg_130_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_130_0.handle)
	end

	if arg_130_0._tf then
		LeanTween = var_1

		local var_130_0 = var_1.isTweening

		go = var_1_10003

		if var_130_0(var_1_10003(arg_130_0._tf)) then
			LeanTween = var_1

			local var_130_1 = var_1.cancel

			go = var_3

			var_130_1(var_3(arg_130_0._tf))
		end
	end

	if arg_130_0.timer and arg_130_0.timer.running then
		local var_130_2 = arg_130_0.timer

		var_1.Stop(var_130_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_130_0.timer = nil

	return
end

return var_0_1
