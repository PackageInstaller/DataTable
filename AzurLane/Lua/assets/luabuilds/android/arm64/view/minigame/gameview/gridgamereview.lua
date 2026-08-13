class = var_0_10000

local var_0_0 = "GridGameReView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = false
local var_0_3 = "battle-boss-4"
local var_0_4 = "event:/ui/ddldaoshu2"
local var_0_5 = "event:/ui/niujiao"
local var_0_6 = "event:/ui/taosheng"
local var_0_7 = "ui/minigameui/gridgameui_atlas"
local var_0_8 = 60
local var_0_9 = "mini_game_time"
local var_0_10 = "mini_game_score"
local var_0_11 = "mini_game_leave"
local var_0_12 = "mini_game_pause"
local var_0_13 = "mini_game_cur_score"
local var_0_14 = "mini_game_high_score"
local var_0_15 = "event grid combo"
local var_0_16 = "event grid trigger"
local var_0_17 = "event move role"
local var_0_18 = "event add score"
local var_0_19 = "event role special"
local var_0_20 = "event special end"
local var_0_21 = "event camera in"
local var_0_22 = "event camedra out"
local var_0_23 = "event ignore time"
local var_0_24 = {
	power_grid = 0,
	grid_index = 0,
	special_time = false,
	special_complete = false
}
local var_0_25 = 12
local var_0_26 = 0.3

Vector2 = var_0_10026

local var_0_27 = var_0_10026(138, 150)
local var_0_28 = 2500
local var_0_29 = 0
local var_0_30 = 100
local var_0_31 = 1
local var_0_32 = 2
local var_0_33 = 3
local var_0_34 = {
	{
		id = 1,
		name = "red",
		index = 1
	},
	{
		id = 2,
		name = "yellow",
		index = 2
	},
	{
		id = 3,
		name = "blue",
		index = 3
	},
	[999] = {
		id = 999,
		name = "color",
		index = 999
	}
}
local var_0_35 = {
	1,
	2,
	3
}
local var_0_36 = {
	{
		rule = var_0_31
	},
	{
		id = 999,
		rule = var_0_32
	},
	{
		rule = var_0_33
	}
}
local var_0_37 = {
	{
		index = 1,
		name = "red",
		max = 1000
	},
	{
		index = 2,
		name = "yellow",
		max = 1000
	},
	{
		index = 3,
		name = "blue",
		max = 1000
	}
}
local var_0_38 = 0.5
local var_0_39 = 50
local var_0_40 = 3
local var_0_41 = 150
local var_0_42 = 1.5
local var_0_43 = 500
local var_0_44 = 260
local var_0_45 = 50
local var_0_46 = 3400
local var_0_47 = 5
local var_0_48 = 4
local var_0_49 = {
	1,
	2,
	3,
	4,
	5
}
local var_0_50 = {
	{
		1,
		5
	}
}
local var_0_51 = {
	1,
	2,
	5
}
local var_0_52 = {
	1,
	2,
	5,
	3,
	4
}
local var_0_53 = {
	{
		5,
		4
	},
	{
		2,
		4
	},
	{
		5,
		3
	},
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		2,
		3
	},
	{
		5,
		4
	}
}
local var_0_54 = {
	2,
	1,
	1,
	2,
	2,
	1,
	2
}
local var_0_55 = {}
local var_0_56 = 7

Vector2 = var_0_10056

local var_0_57 = var_0_10056(0, 0)
local var_0_58 = 0.07
local var_0_59 = 0.3
local var_0_60 = 0.5
local var_0_61 = 5
local var_0_62 = "sound start"
local var_0_63 = "sound trigger"
local var_0_64 = "sound end"
local var_0_65 = {
	"bg00",
	"bg01",
	"bg02",
	"bg03",
	"bg04",
	"bg10",
	"bg11",
	"bg12",
	"bg13",
	"bg14"
}
local var_0_66 = {
	"bg00",
	"bg01",
	"bg02",
	"bg03",
	"bg04"
}
local var_0_67 = {
	"bg10",
	"bg11",
	"bg12",
	"bg13",
	"bg14"
}
local var_0_68 = 0
local var_0_69 = 1
local var_0_70 = 2
local var_0_71 = var_0_69
local var_0_72 = {
	{
		rate = 0.05,
		source = "scene_background/bg00",
		type = var_0_69
	},
	{
		rate = 0.1,
		source = "scene_background/bg01",
		type = var_0_69
	},
	{
		rate = 0.2,
		source = "scene_background/bg02",
		type = var_0_69
	},
	{
		rate = 0.8,
		source = "scene_background/bg03",
		type = var_0_69
	},
	{
		rate = 0.05,
		source = "scene_background/bg10",
		type = var_0_70
	},
	{
		rate = 0.1,
		source = "scene_background/bg11",
		type = var_0_70
	},
	{
		rate = 0.2,
		source = "scene_background/bg12",
		type = var_0_70
	},
	{
		rate = 0.8,
		source = "scene_background/bg13",
		type = var_0_70
	},
	{
		rate = 1.2,
		source = "scene_front/bg04",
		type = var_0_69
	},
	{
		rate = 1.2,
		source = "scene_front/bg14",
		type = var_0_70
	},
	{
		rate = 1,
		source = "scene/rolePos",
		type = var_0_68
	}
}
local var_0_73 = {
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
local var_0_74 = {}
local var_0_75 = {
	time = 0,
	anim_name = var_0_73.n_MoveR
}
local var_0_76 = {
	time = 0.3
}

Vector2 = var_0_10076
var_0_76.start = var_0_10076(0, 0)
Vector3 = var_76
var_0_76.distance = var_76(650, 0, 0)
var_0_75.move = var_0_76
var_0_74.n_Move_R = var_0_75

local var_0_77 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_73.n_Atk
}
local var_0_78 = {
	time = 0.3
}

Vector2 = var_76
var_0_78.start = var_76(0, 0)
Vector3 = var_76
var_0_78.distance = var_76(650, 0, 0)
LeanTweenType = var_76
var_0_78.ease = var_76.easeOutCirc
var_0_77.move = var_0_78
var_0_74.n_Atk = var_0_77

local var_0_79 = {
	time = 0,
	anim_name = var_0_73.n_MoveL
}
local var_0_80 = {
	time = 0.3
}

Vector2 = var_76
var_0_80.start = var_76(0, 0)
Vector3 = var_76
var_0_80.distance = var_76(0, 0, 0)
var_0_79.move = var_0_80
var_0_74.n_Move_L = var_0_79
var_0_74.n_Skill_1 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_73.n_Skill_1
}

local var_0_81 = {
	sound_trigger = "guangjian",
	time = 0,
	anim_name = var_0_73.n_Skill_2
}

Vector3 = var_75
var_0_81.over_offset = var_75(0, 0)

local var_0_82 = {
	time = 0.2
}

Vector2 = var_76
var_0_82.start = var_76(0, 0)
Vector3 = var_76
var_0_82.distance = var_76(300, 0, 0)
LeanTweenType = var_76
var_0_82.ease = var_76.easeOutCirc
var_0_81.move = var_0_82
var_0_74.n_Skill_2 = var_0_81
var_0_74.n_Skill_3 = {
	sound_trigger = "baozha1",
	time = 0,
	anim_name = var_0_73.n_Skill_3
}
var_0_74.n_Combine = {
	camera = true,
	sound_start = "bianshen",
	time = 0,
	anim_name = var_0_73.n_Combine
}

local var_0_83 = {
	time = 0,
	anim_name = var_0_73.n_DMG
}
local var_0_84 = {
	time = 0.2
}

Vector2 = var_76
var_0_84.start = var_76(0, 0)
Vector3 = var_76
var_0_84.distance_m = var_76(-150, 0, 0)
LeanTweenType = var_76
var_0_84.ease = var_76.easeOutCirc
var_0_83.move = var_0_84
var_0_74.n_DMG = var_0_83
var_0_74.n_DMG_S = {
	time = 0,
	anim_name = var_0_73.n_DMG
}

local var_0_85 = {
	time = 0,
	anim_name = var_0_73.n_MoveR
}
local var_0_86 = {
	time = 0.2
}

Vector2 = var_76
var_0_86.start = var_76(0, 0)
Vector3 = var_76
var_0_86.distance = var_76(0, 0, 0)
var_0_85.move = var_0_86
var_0_74.n_DMG_Back_R = var_0_85
var_0_74.n_Neutral = {
	time = 0,
	anim_name = var_0_73.n_Neutral
}

local var_0_87 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_73.c_Atk
}
local var_0_88 = {
	time = 0.2
}

Vector2 = var_76
var_0_88.start = var_76(0, 0)
Vector3 = var_76
var_0_88.distance = var_76(500, 0, 0)
LeanTweenType = var_76
var_0_88.ease = var_76.easeOutCirc
var_0_87.move = var_0_88
var_0_74.c_Atk = var_0_87
var_0_74.c_Skill_1 = {
	camera = true,
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_73.c_Skill_1
}

local var_0_89 = {
	time = 0,
	anim_name = var_0_73.c_Dmg
}
local var_0_90 = {
	time = 0.2
}

Vector2 = var_76
var_0_90.start = var_76(0, 0)
Vector3 = var_76
var_0_90.distance_m = var_76(-150, 0, 0)
LeanTweenType = var_76
var_0_90.ease = var_76.easeOutCirc
var_0_89.move = var_0_90
var_0_74.c_Dmg = var_0_89
var_0_74.c_Dmg_S = {
	time = 0,
	anim_name = var_0_73.c_Dmg
}

local var_0_91 = {
	time = 0,
	anim_name = var_0_73.c_MoveL
}
local var_0_92 = {
	time = 0.2
}

Vector2 = var_76
var_0_92.start = var_76(0, 0)
Vector3 = var_76
var_0_92.distance = var_76(0, 0, 0)
var_0_91.move = var_0_92
var_0_74.c_MoveL = var_0_91

local var_0_93 = {
	time = 0,
	anim_name = var_0_73.c_MoveR
}
local var_0_94 = {
	time = 0.2
}

Vector2 = var_76
var_0_94.start = var_76(0, 0)
Vector3 = var_76
var_0_94.distance = var_76(650, 0, 0)
var_0_93.move = var_0_94
var_0_74.c_MoveR = var_0_93

local var_0_95 = {
	time = 0,
	anim_name = var_0_73.c_MoveR
}
local var_0_96 = {
	time = 0.2
}

Vector2 = var_76
var_0_96.start = var_76(0, 0)
Vector3 = var_76
var_0_96.distance = var_76(0, 0, 0)
var_0_95.move = var_0_96
var_0_74.c_DMG_Back_R = var_0_95
var_0_74.c_Neutral = {
	time = 0,
	anim_name = var_0_73.c_Neutral
}

local var_0_97 = {
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
			var_0_74.n_Atk,
			var_0_74.n_Move_L
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
			var_0_74.n_Skill_1
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
			var_0_74.n_Skill_2,
			var_0_74.n_Move_L
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
			var_0_74.n_Skill_3
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
			var_0_74.n_DMG,
			var_0_74.n_DMG_Back_R
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
			var_0_74.n_DMG_S
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
			var_0_74.n_DMG_Back_R
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_74.n_DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_74.n_DMG_Back_R
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
			var_0_74.n_Combine
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
			var_0_74.c_Atk,
			var_0_74.c_MoveL
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
			var_0_74.c_Skill_1
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
			var_0_74.c_Skill_1
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
			var_0_74.c_Skill_1
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
			var_0_74.c_Dmg,
			var_0_74.c_DMG_Back_R
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
			var_0_74.c_Dmg_S
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_74.c_DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_74.c_DMG_Back_R
		}
	}
}
local var_0_98 = {
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
local var_0_99 = {}
local var_0_100 = {
	time = 0,
	anim_name = var_0_98.n_MoveR
}
local var_0_101 = {
	time = 0.2
}

Vector2 = var_79
var_0_101.start = var_79(0, 0)
Vector3 = var_79
var_0_101.distance = var_79(500, 0, 0)
var_0_100.move = var_0_101
var_0_99.n_Move_R = var_0_100

local var_0_102 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_98.n_Atk
}
local var_0_103 = {
	time = 0.3
}

Vector2 = var_79
var_0_103.start = var_79(0, 0)
Vector3 = var_79
var_0_103.distance = var_79(600, 0, 0)
LeanTweenType = var_79
var_0_103.ease = var_79.easeOutCirc
var_0_102.move = var_0_103
var_0_99.n_Atk = var_0_102

local var_0_104 = {
	time = 0,
	anim_name = var_0_98.n_MoveL
}
local var_0_105 = {
	time = 0.4
}

Vector2 = var_79
var_0_105.start = var_79(0, 0)
Vector3 = var_79
var_0_105.distance = var_79(0, 0, 0)
LeanTweenType = var_79
var_0_105.ease = var_79.easeOutCirc
var_0_104.move = var_0_105
var_0_99.n_Move_L = var_0_104

local var_0_106 = {
	sound_trigger = "baozha1",
	time = 0,
	anim_name = var_0_98.n_Skill_1
}
local var_0_107 = {
	time = 0.2
}

Vector2 = var_79
var_0_107.start = var_79(0, 0)
Vector3 = var_79
var_0_107.distance = var_79(600, 0, 0)
var_0_106.move = var_0_107
var_0_99.n_Skill_1 = var_0_106
var_0_99.n_Skill_2 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_98.n_Skill_2
}

local var_0_108 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_98.n_Skill_3
}

Vector3 = var_78
var_0_108.over_offset = var_78(247, 2)

local var_0_109 = {
	time = 0.2
}

Vector2 = var_79
var_0_109.start = var_79(0, 0)
Vector3 = var_79
var_0_109.distance = var_79(350, 0, 0)
LeanTweenType = var_79
var_0_109.ease = var_79.easeOutCirc
var_0_108.move = var_0_109
var_0_99.n_Skill_3 = var_0_108
var_0_99.n_Combine = {
	camera = true,
	sound_start = "bianshen",
	time = 0,
	anim_name = var_0_98.n_Combine
}

local var_0_110 = {
	time = 0,
	anim_name = var_0_98.n_DMG
}
local var_0_111 = {
	time = 0.2
}

Vector2 = var_79
var_0_111.start = var_79(0, 0)
Vector3 = var_79
var_0_111.distance_m = var_79(-150, 0, 0)
LeanTweenType = var_79
var_0_111.ease = var_79.easeOutCirc
var_0_110.move = var_0_111
var_0_99.n_DMG = var_0_110
var_0_99.n_DMG_S = {
	time = 0,
	anim_name = var_0_98.n_DMG
}

local var_0_112 = {
	time = 0,
	anim_name = var_0_98.n_MoveR
}
local var_0_113 = {
	time = 0.2
}

Vector2 = var_79
var_0_113.start = var_79(0, 0)
Vector3 = var_79
var_0_113.distance = var_79(0, 0, 0)
var_0_112.move = var_0_113
var_0_99.n_DMG_Back_R = var_0_112
var_0_99.n_Neutral = {
	time = 0,
	anim_name = var_0_98.n_Neutral
}

local var_0_114 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_98.c_Atk
}
local var_0_115 = {
	time = 0.4
}

Vector2 = var_79
var_0_115.start = var_79(0, 0)
Vector3 = var_79
var_0_115.distance = var_79(600, 0, 0)
LeanTweenType = var_79
var_0_115.ease = var_79.easeOutCirc
var_0_114.move = var_0_115
var_0_99.c_Atk = var_0_114
var_0_99.c_Skill_1 = {
	camera = true,
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_98.c_Skill_1
}

local var_0_116 = {
	time = 0,
	anim_name = var_0_98.c_Dmg
}
local var_0_117 = {
	time = 0.3
}

Vector2 = var_79
var_0_117.start = var_79(0, 0)
Vector3 = var_79
var_0_117.distance_m = var_79(-150, 0, 0)
LeanTweenType = var_79
var_0_117.ease = var_79.easeOutCirc
var_0_116.move = var_0_117
var_0_99.c_Dmg = var_0_116
var_0_99.c_Dmg_S = {
	time = 0,
	anim_name = var_0_98.c_Dmg
}

local var_0_118 = {
	time = 0,
	anim_name = var_0_98.c_MoveL
}
local var_0_119 = {
	time = 0.3
}

Vector2 = var_79
var_0_119.start = var_79(0, 0)
Vector3 = var_79
var_0_119.distance = var_79(0, 0, 0)
LeanTweenType = var_79
var_0_119.ease = var_79.easeOutCirc
var_0_118.move = var_0_119
var_0_99.c_MoveL = var_0_118

local var_0_120 = {
	time = 0,
	anim_name = var_0_98.c_MoveR
}
local var_0_121 = {
	time = 0.3
}

Vector2 = var_79
var_0_121.start = var_79(0, 0)
Vector3 = var_79
var_0_121.distance = var_79(650, 0, 0)
LeanTweenType = var_79
var_0_121.ease = var_79.easeOutCirc
var_0_120.move = var_0_121
var_0_99.c_MoveR = var_0_120

local var_0_122 = {
	time = 0,
	anim_name = var_0_98.c_MoveR
}
local var_0_123 = {
	time = 0.3
}

Vector2 = var_79
var_0_123.start = var_79(0, 0)
Vector3 = var_79
var_0_123.distance = var_79(0, 0, 0)
LeanTweenType = var_79
var_0_123.ease = var_79.easeOutCirc
var_0_122.move = var_0_123
var_0_99.c_DMG_Back_R = var_0_122
var_0_99.c_Neutral = {
	time = 0,
	anim_name = var_0_98.c_Neutral
}

local var_0_124 = {
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
			var_0_99.n_Atk,
			var_0_99.n_Move_L
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
			var_0_99.n_Move_R,
			var_0_99.n_Skill_1,
			var_0_99.n_Move_L
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
			var_0_99.n_Skill_2
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
			var_0_99.n_Skill_3,
			var_0_99.n_Move_L
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
			var_0_99.n_DMG,
			var_0_99.n_DMG_Back_R
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
			var_0_99.n_DMG_S
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
			var_0_99.n_DMG_Back_R
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_99.n_DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_99.n_DMG_Back_R
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
			var_0_99.n_Combine
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
			var_0_99.c_Atk,
			var_0_99.c_MoveL
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
			var_0_99.c_Skill_1
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
			var_0_99.c_Skill_1
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
			var_0_99.c_Skill_1
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
			var_0_99.c_Dmg,
			var_0_99.c_DMG_Back_R
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
			var_0_99.c_Dmg_S
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_99.c_DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_99.c_DMG_Back_R
		}
	}
}
local var_0_125 = {
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
local var_0_126 = {}
local var_0_127 = {
	time = 0,
	anim_name = var_0_125.n_MoveR
}
local var_0_128 = {
	time = 0.3
}

Vector2 = var_82
var_0_128.start = var_82(0, 0)
Vector3 = var_82
var_0_128.distance = var_82(650, 0, 0)
var_0_127.move = var_0_128
var_0_126.n_Move_R = var_0_127

local var_0_129 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_125.n_Atk
}
local var_0_130 = {
	time = 0.3
}

Vector2 = var_82
var_0_130.start = var_82(0, 0)
Vector3 = var_82
var_0_130.distance = var_82(650, 0, 0)
LeanTweenType = var_82
var_0_130.ease = var_82.easeOutCirc
var_0_129.move = var_0_130
var_0_126.n_Atk = var_0_129

local var_0_131 = {
	time = 0,
	anim_name = var_0_125.n_MoveL
}
local var_0_132 = {
	time = 0.3
}

Vector2 = var_82
var_0_132.start = var_82(0, 0)
Vector3 = var_82
var_0_132.distance = var_82(0, 0, 0)
var_0_131.move = var_0_132
var_0_126.n_Move_L = var_0_131
var_0_126.n_Skill_1 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_125.n_Skill_1
}

local var_0_133 = {
	sound_trigger = "guangjian",
	time = 0,
	anim_name = var_0_125.n_Skill_2
}

Vector3 = var_81
var_0_133.over_offset = var_81(0, 0)

local var_0_134 = {
	time = 0.2
}

Vector2 = var_82
var_0_134.start = var_82(0, 0)
Vector3 = var_82
var_0_134.distance = var_82(300, 0, 0)
LeanTweenType = var_82
var_0_134.ease = var_82.easeOutCirc
var_0_133.move = var_0_134
var_0_126.n_Skill_2 = var_0_133
var_0_126.n_Skill_3 = {
	sound_trigger = "baozha1",
	time = 0,
	anim_name = var_0_125.n_Skill_3
}

local var_0_135 = {
	sound_start = "bianshen",
	time = 0,
	camera = true,
	anim_name = var_0_125.n_Combine
}

Vector2 = var_81

local var_0_136 = var_81(0, 0)

var_0_135.camera_pos = var_0_136
var_0_126.n_Combine = var_0_135

local var_0_137 = {
	time = 0,
	anim_name = var_0_125.n_DMG
}
local var_0_138 = {
	time = 0.2
}

Vector2 = var_82
var_0_138.start = var_82(0, 0)
Vector3 = var_82
var_0_138.distance_m = var_82(-150, 0, 0)
LeanTweenType = var_82
var_0_138.ease = var_82.easeOutCirc
var_0_137.move = var_0_138
var_0_126.n_DMG = var_0_137
var_0_126.n_DMG_S = {
	time = 0,
	anim_name = var_0_125.n_DMG
}

local var_0_139 = {
	time = 0,
	anim_name = var_0_125.n_MoveR
}
local var_0_140 = {
	time = 0.2
}

Vector2 = var_82
var_0_140.start = var_82(0, 0)
Vector3 = var_82
var_0_140.distance = var_82(0, 0, 0)
var_0_139.move = var_0_140
var_0_126.n_DMG_Back_R = var_0_139
var_0_126.n_Neutral = {
	time = 0,
	anim_name = var_0_125.n_Neutral
}

local var_0_141 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_125.c_Atk
}
local var_0_142 = {
	time = 0.2
}

Vector2 = var_82
var_0_142.start = var_82(0, 0)
Vector3 = var_82
var_0_142.distance = var_82(500, 0, 0)
LeanTweenType = var_82
var_0_142.ease = var_82.easeOutCirc
var_0_141.move = var_0_142
var_0_126.c_Atk = var_0_141
var_0_126.c_Skill_1 = {
	camera = true,
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_125.c_Skill_1
}

local var_0_143 = {
	time = 0,
	anim_name = var_0_125.c_Dmg
}
local var_0_144 = {
	time = 0.2
}

Vector2 = var_82
var_0_144.start = var_82(0, 0)
Vector3 = var_82
var_0_144.distance_m = var_82(-150, 0, 0)
LeanTweenType = var_82
var_0_144.ease = var_82.easeOutCirc
var_0_143.move = var_0_144
var_0_126.c_Dmg = var_0_143
var_0_126.c_Dmg_S = {
	time = 0,
	anim_name = var_0_125.c_Dmg
}

local var_0_145 = {
	time = 0,
	anim_name = var_0_125.c_MoveL
}
local var_0_146 = {
	time = 0.2
}

Vector2 = var_82
var_0_146.start = var_82(0, 0)
Vector3 = var_82
var_0_146.distance = var_82(0, 0, 0)
var_0_145.move = var_0_146
var_0_126.c_MoveL = var_0_145

local var_0_147 = {
	time = 0,
	anim_name = var_0_125.c_MoveR
}
local var_0_148 = {
	time = 0.2
}

Vector2 = var_82
var_0_148.start = var_82(0, 0)
Vector3 = var_82
var_0_148.distance = var_82(650, 0, 0)
var_0_147.move = var_0_148
var_0_126.c_MoveR = var_0_147

local var_0_149 = {
	time = 0,
	anim_name = var_0_125.c_MoveR
}
local var_0_150 = {
	time = 0.2
}

Vector2 = var_82
var_0_150.start = var_82(0, 0)
Vector3 = var_82
var_0_150.distance = var_82(0, 0, 0)
var_0_149.move = var_0_150
var_0_126.c_DMG_Back_R = var_0_149
var_0_126.c_Neutral = {
	time = 0,
	anim_name = var_0_125.c_Neutral
}

local var_0_151 = {
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
			var_0_126.n_Atk,
			var_0_126.n_Move_L
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
			var_0_126.n_Skill_1
		}
	},
	{
		name = "skill2",
		power_index = 2,
		special_time = false,
		atk_index = 3,
		score = {
			500,
			500
		},
		grid_index = {
			2
		},
		actions = {
			var_0_126.n_Skill_2,
			var_0_126.n_Move_L
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
			var_0_126.n_Skill_3
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
			var_0_126.n_DMG,
			var_0_126.n_DMG_Back_R
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
			var_0_126.n_DMG_S
		}
	}
}
local var_0_152 = {
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
		var_0_126.n_DMG_Back_R
	}
}

Vector2 = var_82

local var_0_153 = var_82(586, 471)

var_0_152.anim_init_pos = var_0_153
var_0_151[7] = var_0_152
var_0_151[8] = {
	dmg_index = 3,
	name = "DMGN",
	special_time = false,
	actions = {
		var_0_126.DMG
	}
}
var_0_151[9] = {
	name = "DMG_BACK",
	special_time = false,
	dmg_back = true,
	actions = {
		var_0_126.DMG_Back_R
	}
}

local var_0_154 = {
	power_index = 0,
	name = "Combine",
	special_trigger = true,
	anim_bool = "special",
	special_time = true,
	grid_index = {
		1,
		2,
		3
	},
	actions = {
		var_0_126.n_Combine
	}
}

Vector2 = var_82

local var_0_155 = var_82(-58, 350)

var_0_154.anim_trigger_pos = var_0_155
Vector2 = var_0_155

local var_0_156 = var_0_155(225, 471)

var_0_154.anim_end_pos = var_0_156
var_0_151[10] = var_0_154
var_0_151[11] = {
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
		var_0_126.c_Atk,
		var_0_126.c_MoveL
	}
}
var_0_151[12] = {
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
		var_0_126.c_Skill_1
	}
}
var_0_151[13] = {
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
		var_0_126.c_Skill_1
	}
}
var_0_151[14] = {
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
		var_0_126.c_Skill_1
	}
}
var_0_151[15] = {
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
		var_0_126.c_Dmg,
		var_0_126.c_DMG_Back_R
	}
}
var_0_151[16] = {
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
		var_0_126.c_Dmg_S
	}
}
var_0_151[17] = {
	dmg_index = 3,
	name = "DMGN",
	special_time = false,
	actions = {
		var_0_126.DMG
	}
}
var_0_151[18] = {
	name = "DMG_BACK",
	special_time = false,
	dmg_back = true,
	actions = {
		var_0_126.DMG_Back_R
	}
}

local var_0_157 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_158 = {}
local var_0_159 = {
	time = 0,
	anim_name = var_0_157.MoveR
}
local var_0_160 = {
	time = 0.3
}

Vector2 = var_85
var_0_160.start = var_85(0, 0)
Vector3 = var_85
var_0_160.distance = var_85(500, 0, 0)
LeanTweenType = var_85
var_0_160.ease = var_85.easeOutCirc
var_0_159.move = var_0_160
var_0_158.Move_R = var_0_159

local var_0_161 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_157.Atk
}
local var_0_162 = {
	time = 0.3
}

Vector2 = var_85
var_0_162.start = var_85(0, 0)
Vector3 = var_85
var_0_162.distance = var_85(600, 0, 0)
LeanTweenType = var_85
var_0_162.ease = var_85.easeOutCirc
var_0_161.move = var_0_162
var_0_158.Atk = var_0_161

local var_0_163 = {
	time = 0,
	anim_name = var_0_157.MoveL
}
local var_0_164 = {
	time = 0.4
}

Vector3 = var_85
var_0_164.distance = var_85(0, 0, 0)
LeanTweenType = var_85
var_0_164.ease = var_85.easeOutCirc
var_0_163.move = var_0_164
var_0_158.Move_L = var_0_163

local var_0_165 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_157.Skill_1
}

var_0_158.Skill_1 = var_0_165

local var_0_166 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_157.Skill_2
}

Vector2 = var_84
var_0_166.over_offset = var_84(115, 0)
var_0_158.Skill_2 = var_0_166

local var_0_167 = {
	time = 0,
	anim_name = var_0_157.DMG
}
local var_0_168 = {
	time = 0.3
}

Vector2 = var_85
var_0_168.start = var_85(0, 0)
Vector3 = var_85
var_0_168.distance_m = var_85(-150, 0, 0)
LeanTweenType = var_85
var_0_168.ease = var_85.easeOutCirc
var_0_167.move = var_0_168
var_0_158.DMG = var_0_167

local var_0_169 = {
	time = 0,
	anim_name = var_0_157.MoveR
}
local var_0_170 = {
	time = 0.3
}

Vector2 = var_85
var_0_170.start = var_85(0, 0)
Vector3 = var_85
var_0_170.distance = var_85(0, 0, 0)
LeanTweenType = var_85
var_0_170.ease = var_85.easeOutCirc
var_0_169.move = var_0_170
var_0_158.DMG_Back_R = var_0_169

local var_0_171 = {
	time = 0,
	anim_name = var_0_157.DMG
}

var_0_158.DMG_S = var_0_171

local var_0_172 = {
	time = 0,
	anim_name = var_0_157.Neutral
}

var_0_158.Neutral = var_0_172

local var_0_173 = {
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
			var_0_158.Atk,
			var_0_158.Move_L
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
			var_0_158.Skill_1
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
			var_0_158.Move_R,
			var_0_158.Skill_2,
			var_0_158.Move_L
		}
	},
	{
		dmg_index = 2,
		name = "DMG",
		special_time = false,
		actions = {
			var_0_158.DMG,
			var_0_158.DMG_Back_R
		}
	},
	{
		dmg_index = 1,
		name = "DMG_Stand",
		special_time = false,
		actions = {
			var_0_158.DMG_S
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_158.DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_158.DMG_Back_R
		}
	}
}
local var_0_174 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_175 = {}
local var_0_176 = {
	time = 0,
	anim_name = var_0_174.MoveR
}
local var_0_177 = {
	time = 0.3
}

Vector2 = var_88
var_0_177.start = var_88(0, 0)
Vector3 = var_88
var_0_177.distance = var_88(500, 0, 0)
LeanTweenType = var_88
var_0_177.ease = var_88.easeOutCirc
var_0_176.move = var_0_177
var_0_175.Move_R = var_0_176

local var_0_178 = {
	sound_trigger = "taosheng",
	time = 0,
	anim_name = var_0_174.Atk
}
local var_0_179 = {
	time = 0.3
}

Vector2 = var_88
var_0_179.start = var_88(0, 0)
Vector3 = var_88
var_0_179.distance = var_88(600, 0, 0)
LeanTweenType = var_88
var_0_179.ease = var_88.easeOutCirc
var_0_178.move = var_0_179
var_0_175.Atk = var_0_178

local var_0_180 = {
	time = 0,
	anim_name = var_0_174.MoveL
}
local var_0_181 = {
	time = 0.4
}

Vector3 = var_88
var_0_181.distance = var_88(0, 0, 0)
LeanTweenType = var_88
var_0_181.ease = var_88.easeOutCirc
var_0_180.move = var_0_181
var_0_175.Move_L = var_0_180

local var_0_182 = {
	sound_trigger = "jiguang",
	time = 0,
	anim_name = var_0_174.Skill_1
}

var_0_175.Skill_1 = var_0_182

local var_0_183 = {
	sound_trigger = "baozha2",
	time = 0,
	anim_name = var_0_174.Skill_2
}

Vector2 = var_87
var_0_183.over_offset = var_87(264, 0)
var_0_175.Skill_2 = var_0_183

local var_0_184 = {
	time = 0,
	anim_name = var_0_174.DMG
}
local var_0_185 = {
	time = 0.3
}

Vector3 = var_88
var_0_185.distance_m = var_88(-150, 0, 0)
LeanTweenType = var_88
var_0_185.ease = var_88.easeOutCirc
var_0_184.move = var_0_185
var_0_175.DMG = var_0_184

local var_0_186 = {
	time = 0,
	anim_name = var_0_174.MoveR
}
local var_0_187 = {
	time = 0.3
}

Vector2 = var_88
var_0_187.start = var_88(0, 0)
Vector3 = var_88
var_0_187.distance = var_88(0, 0, 0)
LeanTweenType = var_88
var_0_187.ease = var_88.easeOutCirc
var_0_186.move = var_0_187
var_0_175.DMG_Back_R = var_0_186

local var_0_188 = {
	time = 0,
	anim_name = var_0_174.DMG
}

var_0_175.DMG_S = var_0_188

local var_0_189 = {
	time = 0,
	anim_name = var_0_174.Neutral
}

var_0_175.Neutral = var_0_189

local var_0_190 = {
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
			var_0_175.Atk,
			var_0_175.Move_L
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
			var_0_175.Skill_1
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
			var_0_175.Skill_2,
			var_0_175.Move_L
		}
	},
	{
		dmg_index = 2,
		name = "DMG",
		special_time = false,
		actions = {
			var_0_175.DMG,
			var_0_175.DMG_Back_R
		}
	},
	{
		dmg_index = 1,
		name = "DMG_Stand",
		special_time = false,
		actions = {
			var_0_175.DMG_S
		}
	},
	{
		dmg_index = 3,
		name = "DMGN",
		special_time = false,
		actions = {
			var_0_175.DMG
		}
	},
	{
		name = "DMG_BACK",
		special_time = false,
		dmg_back = true,
		actions = {
			var_0_175.DMG_Back_R
		}
	}
}
local var_0_191 = {
	{
		index = 1,
		name = "role1",
		skill = var_0_97,
		actions = var_0_74
	},
	{
		index = 2,
		name = "role2",
		skill = var_0_124,
		actions = var_0_99
	},
	{
		index = 3,
		name = "enemy1",
		skill = var_0_173,
		actions = var_0_158
	},
	{
		index = 4,
		name = "enemy2",
		skill = var_0_190,
		actions = var_0_175
	}
}
local var_0_192 = {
	name = "role3",
	index = 5,
	skill = var_0_151,
	actions = var_0_126
}

Vector2 = var_89

local var_0_193 = var_89(586, 411)

var_0_192.anim_init_pos = var_0_193
var_0_191[5] = var_0_192

local function var_0_194(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._boxTf = arg_1_0
			arg_2_0._event = arg_1_1

			local var_2_0 = arg_2_0._event

			var_1.bind(var_2_0, var_0_16, function()
				if var_0_24.power_grid and var_0 > 0 and var_0_36[var_0] then
					local var_3_0 = var_0_36[var_0].rule
					local var_3_1

					if not var_1.id or not var_1.id then
						var_3_1 = var_0
					end

					table = var_3_10004

					var_3_10004.insert(arg_2_0.ruleGridList, {
						id = var_3_1,
						rule = var_3_0
					})
				end

				return
			end)

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
			arg_2_0.ruleGridList = {}

			for iter_2_0 = 1, var_0_25 do
				tf = var_2_1
				instantiate = var_2_10007

				local var_2_1 = var_2_1(var_2_10007(arg_2_0._gridEffect))

				setParent = var_2_10006

				var_2_10006(var_2_1, arg_2_0._content)

				setActive = var_2_10006

				var_2_10006(var_2_1, false)

				Vector2 = var_2_10006
				var_2_1.anchoredPosition = var_2_10006(var_0_27.x * iter_2_0 - var_0_27.x / 2, var_0_27.y / 2)
				table = var_2_10006

				var_2_10006.insert(arg_2_0.effects, var_2_1)
			end

			return
		end,
		start = function(arg_4_0)
			arg_4_0.comboCheck = false

			arg_4_0:initGrids(false)

			for iter_4_0 = 1, #arg_4_0.effects do
				setActive = var_2_10005

				var_2_10005(arg_4_0.effects[iter_4_0], false)
			end

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.takeAwayTime then
				local var_5_0 = arg_5_0.takeAwayTime

				if 0 < var_5_0 then
					local var_5_1 = arg_5_0.takeAwayTime

					Time = var_2
					arg_5_0.takeAwayTime = var_5_1 - var_2.deltaTime

					return
				end
			end

			arg_5_0.gridCreateIndex = 1

			local var_5_2 = false

			for iter_5_0 = 1, #arg_5_0.grids do
				local var_5_3 = arg_5_0.grids[iter_5_0]
				local var_5_4 = iter_5_0

				if not var_5_3.moveAble then
					var_5_2 = var_5_2 or true

					if (iter_5_0 - 1) * var_0_27.x < var_5_3.tf.anchoredPosition.x then
						local var_5_5 = var_5_3.tf

						Vector2 = var_2_10010

						local var_5_6 = var_5_3.tf.anchoredPosition.x

						var_2_10013 = var_5_3.speed
						Time = var_2_10014
						var_5_5.anchoredPosition = var_2_10010(var_5_6 - var_2_10013 * var_2_10014.deltaTime, 0)

						if var_5_3.speed < var_0_28 then
							var_5_3.speed = var_5_3.speed + var_0_30
						end
					end

					if var_8 >= var_5_3.tf.anchoredPosition.x then
						var_5_3.speed = 0
						var_5_3.moveAble = true

						if var_8 > var_5_3.tf.anchoredPosition.x then
							local var_5_7 = var_5_3.tf

							Vector2 = var_2_10010
							var_5_7.anchoredPosition = var_2_10010(var_8, 0)
						end
					end
				end

				if not var_5_3.eventAble then
					GetComponent = var_8
					var_2_10010 = var_5_3.tf
					typeof = var_2_10011
					EventTriggerListener = var_2_10013
					var_2_10011 = var_8(var_2_10010, var_2_10011(var_2_10013))

					var_8.AddPointDownFunc(var_2_10011, function()
						if arg_5_0.comboCheck == false then
							local var_6_0 = arg_5_0
							local var_6_1, var_6_2 = var_0.triggerDownGrid(var_6_0, var_5_4)

							if #var_6_1 >= 2 then
								arg_5_0.comboCheck = true

								local var_6_3 = arg_5_0
								local var_6_4 = var_2.getGridDouble(var_6_3, var_6_1)
								local var_6_5 = arg_5_0

								var_3.takeAwayGrid(var_6_5, var_6_1)

								local var_6_6 = arg_5_0

								var_3.insertGrids(var_6_6)

								for iter_6_0 = 1, #var_6_2 do
									local var_6_7 = var_6_2[iter_6_0].index
									local var_6_8 = var_6_2[iter_6_0].count
									local var_6_9 = arg_5_0._event

									var_9.emit(var_6_9, var_0_15, {
										series = var_6_8,
										combo = arg_5_0.combo,
										index = var_6_7,
										double = var_6_4
									})
								end

								arg_5_0.combo = arg_5_0.combo + 1
							else
								arg_5_0.comboCheck = true

								local var_6_10 = arg_5_0

								var_2.takeAwayGrid(var_6_10, {
									var_5_4
								})

								local var_6_11 = arg_5_0

								var_2.insertGrids(var_6_11)
							end
						end

						return
					end)

					var_5_3.eventAble = true
				end
			end

			if not var_5_2 and arg_5_0.comboCheck then
				if #arg_5_0:getSeriesGrids() > 0 then
					local var_5_8 = {}

					for iter_5_1 = 1, #var_2 do
						local var_5_9 = var_2[iter_5_1].series
						local var_5_10 = var_2[iter_5_1].index
						local var_5_11 = var_2[iter_5_1].double

						for iter_5_2 = 1, #var_5_9 do
							table = var_2_10015

							var_2_10015.insert(var_5_8, var_5_9[iter_5_2])
						end

						local var_5_12 = arg_5_0:getGridDouble(var_5_9)
						local var_5_13 = arg_5_0._event

						var_12.emit(var_5_13, var_0_15, {
							series = #var_5_9,
							combo = arg_5_0.combo,
							index = var_5_10,
							double = var_5_12
						})
					end

					arg_5_0:clearGridSeriesAble()
					arg_5_0:takeAwayGrid(var_5_8)
					arg_5_0:insertGrids()

					arg_5_0.comboCheck = true
					arg_5_0.combo = arg_5_0.combo + 1
				else
					arg_5_0.comboCheck = false
					arg_5_0.combo = 0
				end
			end

			return
		end,
		getGridDouble = function(arg_7_0, arg_7_1)
			for iter_7_0 = 1, #arg_7_1 do
				if arg_7_0.grids[iter_7_0] and arg_7_0.grids[iter_7_0].rule == var_0_33 then
					return true
				end
			end

			return false
		end,
		clear = function(arg_8_0)
			for iter_8_0 = 1, #arg_8_0.grids do
				if arg_8_0.grids[iter_8_0].tf then
					destroy = var_5

					var_5(arg_8_0.grids[iter_8_0].tf)
				end
			end

			arg_8_0.grids = {}
			arg_8_0.gridCreateIndex = 1
			arg_8_0.ruleGridList = {}

			return
		end,
		clearGridSeriesAble = function(arg_9_0)
			for iter_9_0 = 1, #arg_9_0.grids do
				if arg_9_0.grids[iter_9_0].seriesAble then
					arg_9_0.grids[iter_9_0].seriesAble = false
				end
			end

			return
		end,
		getSeriesGrids = function(arg_10_0)
			local var_10_0 = {}
			local var_10_1
			local var_10_2 = {}
			local var_10_3 = {}
			local var_10_4
			local var_10_5
			local var_10_6 = 0
			local var_10_7 = false

			for iter_10_0 = 1, #arg_10_0.grids do
				if var_10_5 and var_10_5 == arg_10_0.grids[iter_10_0].index then
					var_10_6 = var_10_6 + 1
				elseif arg_10_0.grids[iter_10_0].rule == var_0_32 then
					var_10_6 = var_10_6 + 1
				elseif var_10_7 then
					var_10_5 = arg_10_0.grids[iter_10_0].index
					var_10_7 = false
				else
					if 3 <= var_10_6 and arg_10_0:checkGridComboFlag(var_10_3) then
						table = var_2_10013

						var_2_10013.insert(var_10_0, {
							series = var_10_3,
							index = var_10_5
						})
					end

					var_10_5 = arg_10_0.grids[iter_10_0].index
					var_10_6 = 1
					var_10_7 = var_5.rule == var_0_32
					var_10_3 = {}
				end

				table = var_2_10013

				var_2_10013.insert(var_10_3, iter_10_0)

				if iter_10_0 == #arg_10_0.grids and #var_10_3 >= 3 and arg_10_0:checkGridComboFlag(var_10_3) then
					table = var_2_10013

					var_2_10013.insert(var_10_0, {
						series = var_10_3,
						index = var_10_5
					})

					var_10_3 = {}
				end
			end

			return var_10_0
		end,
		checkGridComboFlag = function(arg_11_0, arg_11_1)
			for iter_11_0 = 1, #arg_11_1 do
				if arg_11_0.grids[arg_11_1[iter_11_0]].seriesAble and iter_11_0 ~= #arg_11_1 then
					return true
				end
			end

			return false
		end,
		insertGrids = function(arg_12_0)
			local var_12_0 = var_0_25 - #arg_12_0.grids

			for iter_12_0 = 1, var_12_0 do
				local var_12_1 = arg_12_0:createGridData()

				table = var_2_10007

				var_2_10007.insert(arg_12_0.grids, var_12_1)
			end

			if arg_12_0:checkGridsMatchAble() then
				arg_12_0:instiateGrids(true)
			else
				arg_12_0:initGrids(true)
			end

			arg_12_0:changeAbleGrids()

			return
		end,
		changeAbleGrids = function(arg_13_0)
			for iter_13_0 = 1, #arg_13_0.grids do
				arg_13_0.grids[iter_13_0].moveAble = false
				arg_13_0.grids[iter_13_0].eventAble = false
				arg_13_0.grids[iter_13_0].speed = var_0_29
			end

			return
		end,
		takeAwayGrid = function(arg_14_0, arg_14_1)
			table = var_2_10002

			var_2_10002.sort(arg_14_1, function(arg_15_0, arg_15_1)
				return arg_15_0 <= arg_15_1
			end)

			arg_14_0.takeAwayTime = var_0_26

			local var_14_0 = {}
			local var_14_1 = arg_14_1[1] - 1
			local var_14_2

			if 0 < var_14_1 then
				var_14_2 = arg_14_0.grids[var_14_1]
				var_14_2.seriesAble = true
			end

			pg = var_14_2

			local var_14_3 = var_14_2.CriMgr.GetInstance()

			var_4.PlaySoundEffect_V3(var_14_3, "event:/ui/" .. "xiaochu")

			for iter_14_0 = #arg_14_1, 1, -1 do
				table = var_14_4

				local var_14_4 = var_14_4.insert
				local var_14_5 = var_14_0

				table = var_2_10011

				var_14_4(var_14_5, var_2_10011.remove(arg_14_0.grids, arg_14_1[iter_14_0]))

				setActive = var_14_4

				var_14_4(arg_14_0.effects[arg_14_1[iter_14_0]], false)

				setActive = var_14_4

				var_14_4(arg_14_0.effects[arg_14_1[iter_14_0]], true)
			end

			for iter_14_1 = 1, #var_14_0 do
				destroy = var_14_4

				var_14_4(var_14_0[iter_14_1].tf)

				var_14_0[iter_14_1] = 0
			end

			local var_14_6 = {}

			return
		end,
		triggerDownGrid = function(arg_16_0, arg_16_1)
			local var_16_0 = arg_16_0.grids[arg_16_1]
			local var_16_1
			local var_16_2 = var_16_0.rule
			local var_16_3 = {}
			local var_16_4 = {}

			if var_16_2 ~= var_0_32 then
				var_16_3 = {
					arg_16_1
				}
				var_16_1 = var_16_0.index
			end

			if not var_16_0 then
				return var_16_3, {}
			end

			local var_16_5

			if var_16_2 == var_0_32 then
				var_16_5 = nil

				local var_16_6 = true
				local var_16_7 = {}

				for iter_16_0 = arg_16_1 - 1, 1, -1 do
					if var_16_6 then
						if arg_16_0.grids[iter_16_0].rule == var_0_32 then
							table = var_14

							var_14.insert(var_16_7, iter_16_0)
						elseif not var_16_5 then
							var_16_5 = arg_16_0.grids[iter_16_0].index
							table = var_14

							var_14.insert(var_16_7, iter_16_0)
						elseif var_16_5 == arg_16_0.grids[iter_16_0].index then
							table = var_14

							var_14.insert(var_16_7, iter_16_0)
						else
							var_16_6 = false
						end
					end
				end

				local var_16_8
				local var_16_9 = true
				local var_16_10 = {}

				for iter_16_1 = arg_16_1 + 1, #arg_16_0.grids do
					if var_16_9 then
						if arg_16_0.grids[iter_16_1].rule == var_0_32 then
							table = var_2_10017

							var_2_10017.insert(var_16_10, iter_16_1)
						elseif not var_16_8 then
							var_16_8 = arg_16_0.grids[iter_16_1].index
							table = var_2_10017

							var_2_10017.insert(var_16_10, iter_16_1)
						elseif var_16_8 == arg_16_0.grids[iter_16_1].index then
							table = var_2_10017

							var_2_10017.insert(var_16_10, iter_16_1)
						else
							var_16_9 = false
						end
					end
				end

				if var_16_5 == nil and var_16_8 == nil then
					for iter_16_2 = 1, #arg_16_0.grids do
						table = var_2_10017

						var_2_10017.insert(var_16_3, iter_16_2)
					end
				elseif var_16_5 == var_16_8 then
					for iter_16_3 = 1, #var_16_7 do
						table = var_2_10017

						var_2_10017.insert(var_16_3, var_16_7[iter_16_3])
					end

					table = var_13

					var_13.insert(var_16_3, arg_16_1)

					for iter_16_4 = 1, #var_16_10 do
						table = var_2_10017

						var_2_10017.insert(var_16_3, var_16_10[iter_16_4])
					end

					var_16_1 = var_16_5
				else
					if #var_16_7 >= #var_16_10 then
						for iter_16_5 = 1, #var_16_7 do
							table = var_2_10017

							var_2_10017.insert(var_16_3, var_16_7[iter_16_5])
						end

						var_16_1 = var_16_5
					else
						for iter_16_6 = 1, #var_16_10 do
							table = var_2_10017

							var_2_10017.insert(var_16_3, var_16_10[iter_16_6])
						end

						var_16_1 = var_16_8
					end

					table = var_13

					var_13.insert(var_16_3, arg_16_1)
				end

				table = var_13

				var_13.insert(var_16_4, {
					index = var_16_1,
					count = #var_16_3
				})
			elseif var_16_0.rule == var_0_31 then
				var_16_5 = nil

				local var_16_11
				local var_16_12 = var_16_0.index
				local var_16_13
				local var_16_14 = true
				local var_16_15 = {}

				for iter_16_7 = arg_16_1 - 1, 1, -1 do
					if var_16_14 then
						if arg_16_0.grids[iter_16_7].rule == var_0_32 then
							table = var_17

							var_17.insert(var_16_15, iter_16_7)
						elseif not var_16_13 then
							var_16_13 = arg_16_0.grids[iter_16_7].index
							table = var_17

							var_17.insert(var_16_15, iter_16_7)
						elseif var_16_13 == arg_16_0.grids[iter_16_7].index then
							table = var_17

							var_17.insert(var_16_15, iter_16_7)
						else
							var_16_14 = false
						end
					end
				end

				local var_16_16
				local var_16_17 = true
				local var_16_18 = {}

				for iter_16_8 = arg_16_1 + 1, #arg_16_0.grids do
					if var_16_17 then
						if arg_16_0.grids[iter_16_8].rule == var_0_32 then
							table = var_20

							var_20.insert(var_16_18, iter_16_8)
						elseif not var_16_16 then
							var_16_16 = arg_16_0.grids[iter_16_8].index
							table = var_20

							var_20.insert(var_16_18, iter_16_8)
						elseif var_16_16 == arg_16_0.grids[iter_16_8].index then
							table = var_20

							var_20.insert(var_16_18, iter_16_8)
						else
							var_16_17 = false
						end
					end
				end

				table = var_16

				var_16.insert(var_16_4, {
					index = var_16_13,
					count = #var_16_15 + 1
				})

				table = var_16

				var_16.insert(var_16_4, {
					index = var_16_16,
					count = #var_16_18 + 1
				})

				for iter_16_9 = 1, #var_16_15 do
					table = var_20

					var_20.insert(var_16_3, var_16_15[iter_16_9])
				end

				for iter_16_10 = 1, #var_16_18 do
					table = var_20

					var_20.insert(var_16_3, var_16_18[iter_16_10])
				end
			else
				for iter_16_11 = arg_16_1 - 1, 1, -1 do
					if arg_16_0:checkGridMatch(var_16_1, arg_16_0.grids[iter_16_11]) then
						table = var_11

						var_11.insert(var_16_3, iter_16_11)
					else
						break
					end
				end

				for iter_16_12 = arg_16_1 + 1, #arg_16_0.grids do
					if arg_16_0:checkGridMatch(var_16_1, arg_16_0.grids[iter_16_12]) then
						table = var_11

						var_11.insert(var_16_3, iter_16_12)
					else
						break
					end
				end

				table = var_16_5

				var_16_5.insert(var_16_4, {
					index = var_16_1,
					count = #var_16_3
				})
			end

			table = var_16_5

			var_16_5.sort(var_16_3, function(arg_17_0, arg_17_1)
				return arg_17_0 < arg_17_1
			end)

			return var_16_3, var_16_4
		end,
		checkGridMatch = function(arg_18_0, arg_18_1, arg_18_2)
			if arg_18_1 == arg_18_2.index then
				return true
			elseif arg_18_2.rule == var_0_32 then
				return true
			end

			return false
		end,
		initGrids = function(arg_19_0, arg_19_1)
			arg_19_0:clear()

			for iter_19_0 = 1, var_0_25 do
				local var_19_0 = arg_19_0:createGridData()

				table = var_2_10007

				var_2_10007.insert(arg_19_0.grids, var_19_0)
			end

			if arg_19_0:checkGridsMatchAble() then
				arg_19_0:instiateGrids(arg_19_1)
			else
				arg_19_0:initGrids(arg_19_1)
			end

			arg_19_0.comboCheck = false

			return
		end,
		instiateGrids = function(arg_20_0, arg_20_1)
			for iter_20_0 = 1, #arg_20_0.grids do
				if not arg_20_0.grids[iter_20_0].tf then
					tf = var_7
					instantiate = var_2_10009

					local var_20_0 = var_7(var_2_10009(arg_20_0.tplGrid))

					SetParent = var_2_10008

					var_2_10008(var_20_0, arg_20_0._content)

					setActive = var_2_10008

					var_2_10008(var_20_0, true)

					setActive = var_2_10008
					findTF = var_10

					var_2_10008(var_10(var_20_0, var_6.name), true)

					var_2_10008 = nil

					if arg_20_1 then
						var_2_10008 = (var_0_25 + arg_20_0.gridCreateIndex - 1) * var_0_27.x
					else
						var_2_10008 = (arg_20_0.gridCreateIndex - 1) * var_0_27.x
					end

					if var_6.rule == var_0_32 then
						-- block empty
					end

					if var_6.rule ~= var_0_32 then
						setActive = var_2_10009
						findTF = var_11

						var_2_10009(var_11(var_20_0, var_6.name .. "/boom"), var_6.rule == var_0_31)

						setActive = var_2_10009
						findTF = var_11

						var_2_10009(var_11(var_20_0, var_6.name .. "/thunder"), var_6.rule == var_0_33)
					end

					Vector2 = var_2_10009
					var_20_0.anchoredPosition = var_2_10009(var_2_10008, 0)
					arg_20_0.gridCreateIndex = arg_20_0.gridCreateIndex + 1
					var_6.tf = var_20_0
				end
			end

			return
		end,
		createGridData = function(arg_21_0)
			local var_21_0
			local var_21_1
			local var_21_2
			local var_21_3
			local var_21_4 = #arg_21_0.ruleGridList

			if 0 < var_21_4 then
				table = var_21_4
				var_21_0 = var_21_4.remove(arg_21_0.ruleGridList, 1).id
				var_21_3 = var_5.rule
			else
				local var_21_5 = var_0_35

				math = var_6
				var_21_0 = var_21_5[var_6.random(1, #var_0_35)]
			end

			local var_21_6 = var_0_34[var_21_0].name
			local var_21_7 = var_0_34[var_21_0].index

			return {
				moveAble = false,
				eventAble = false,
				speed = var_0_29,
				index = var_21_7,
				name = var_21_6,
				rule = var_21_3
			}
		end,
		checkGridsMatchAble = function(arg_22_0)
			return true
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

local var_0_195 = false

local function var_0_196(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		ctor = function(arg_24_0)
			arg_24_0._specialTf = arg_23_0
			arg_24_0._successTf = arg_23_1
			findTF = var_1
			arg_24_0._effectSuccess = var_1(arg_24_0._successTf, "effectSuccess")
			arg_24_0._event = arg_23_2

			local var_24_0 = arg_24_0._event

			var_1.bind(var_24_0, var_0_15, function(arg_25_0, arg_25_1, arg_25_2)
				local var_25_0

				if not arg_25_1.series then
					var_25_0 = 0
				end

				local var_25_1 = arg_25_1.combo
				local var_25_2 = arg_25_1.index
				local var_25_3 = arg_25_1.double
				local var_25_4 = arg_24_0
				local var_25_5 = var_7.addPowerAmount
				local var_25_6 = var_25_2
				local var_25_7 = arg_24_0

				var_25_5(var_25_4, var_25_6, var_11.getPowerAmount(var_25_7, var_25_0, var_25_1, var_25_3))

				return
			end)

			arg_24_0.powers = {}

			for iter_24_0 = 1, #var_0_37 do
				findTF = var_24_1

				local var_24_1 = var_24_1(arg_24_0._specialTf, var_0_37[iter_24_0].name)
				local var_24_2 = var_0_37[iter_24_0].index
				local var_24_3 = var_0_37[iter_24_0].max
				local var_24_4 = var_0_37[iter_24_0].cur

				findTF = var_2_10009
				var_2_10009 = var_2_10009(arg_24_0._specialTf, var_0_37[iter_24_0].name .. "/text")
				setActive = var_2_10010

				var_2_10010(var_2_10009, var_0_2)

				var_2_10010 = {
					active = false,
					tf = var_24_1,
					index = var_24_2,
					max = var_24_3,
					cur = var_24_4,
					text_tf = var_2_10009
				}
				table = var_11

				var_11.insert(arg_24_0.powers, var_2_10010)
			end

			local var_24_5 = arg_24_0._event

			var_1.bind(var_24_5, var_0_21, function(arg_26_0, arg_26_1, arg_26_2)
				arg_24_0.inCameraFlag = true

				return
			end)

			local var_24_6 = arg_24_0._event

			var_1.bind(var_24_6, var_0_22, function(arg_27_0, arg_27_1, arg_27_2)
				arg_24_0.inCameraFlag = false
				arg_24_0.inCameraFadeTime = 200

				return
			end)

			findTF = var_1
			arg_24_0.successText = var_1(arg_24_0._successTf, "box/text")
			setActive = var_1

			var_1(arg_24_0.successText, var_0_2)

			local var_24_7 = {
				cur = 0
			}

			GetComponent = var_2
			findTF = var_4

			local var_24_8 = var_4(arg_24_0._successTf, "box")

			typeof = var_5
			Slider = var_7
			var_24_7.slider = var_2(var_24_8, var_5(var_7))
			var_24_7.max = var_0_46
			arg_24_0.success = var_24_7

			return
		end,
		start = function(arg_28_0)
			for iter_28_0 = 1, #arg_28_0.powers do
				local var_28_0 = arg_28_0.powers[iter_28_0]

				var_28_0.cur = 0
				var_28_0.active = false
			end

			arg_28_0.inCameraFlag = false
			arg_28_0.inCameraFadeTime = 0
			arg_28_0.success.cur = 0

			local var_28_1 = arg_28_0.success

			var_28_1.active = false
			setActive = var_28_1

			var_28_1(arg_28_0._effectSuccess, false)
			arg_28_0:resetSpecialData()
			arg_28_0:step()

			return
		end,
		step = function(arg_29_0)
			for iter_29_0 = 1, #arg_29_0.powers do
				local var_29_0

				if arg_29_0.powers[iter_29_0].active and var_5.cur > 0 then
					var_29_0 = var_5.cur

					local var_29_1 = var_0_43

					Time = var_2_10008
					var_5.cur = var_29_0 - var_29_1 * var_2_10008.deltaTime

					if var_5.cur <= 0 then
						var_5.active = false
						var_5.cur = 0
					end
				end

				GetComponent = var_29_0
				var_2_10008 = var_5.tf
				typeof = var_2_10009
				Slider = var_2_10011

				local var_29_2 = var_29_0(var_2_10008, var_2_10009(var_2_10011))
				local var_29_3 = var_5.cur
				local var_29_4

				if not (0 < var_29_3) or not (var_5.cur / var_5.max) then
					var_29_4 = 0
				end

				var_29_2.value = var_29_4
				setText = var_29_2
				var_2_10008 = var_5.text_tf
				math = var_2_10009

				var_29_2(var_2_10008, var_2_10009.floor(var_5.cur))
			end

			setText = var_1

			local var_29_5 = arg_29_0.successText

			math = iter_29_0

			var_1(var_29_5, iter_29_0.floor(arg_29_0.success.cur))

			if arg_29_0.success.active and arg_29_0.success.cur > 0 and var_0_24.special_complete and not arg_29_0.inCameraFlag then
				local var_29_6 = arg_29_0.inCameraFadeTime

				if 0 < var_29_6 then
					local var_29_7 = arg_29_0.inCameraFadeTime

					Time = var_2
					arg_29_0.inCameraFadeTime = var_29_7 - var_2.deltaTime * 1000
				else
					local var_29_8 = arg_29_0.success
					local var_29_9 = arg_29_0.success.cur
					local var_29_10 = var_0_44

					Time = var_4
					var_29_8.cur = var_29_9 - var_29_10 * var_4.deltaTime

					if arg_29_0.success.cur <= 0 then
						arg_29_0.success.active = false
						arg_29_0.success.cur = 0

						local var_29_11 = arg_29_0._event

						var_1.emit(var_29_11, var_0_20)
					end
				end
			end

			if arg_29_0.success.cur >= arg_29_0.success.max or arg_29_0.success.active then
				setActive = var_1

				var_1(arg_29_0._effectSuccess, true)
			else
				setActive = var_1

				var_1(arg_29_0._effectSuccess, false)
			end

			local var_29_12 = arg_29_0.success.slider
			local var_29_13

			if not (arg_29_0.success.cur > 0) or not (arg_29_0.success.cur / arg_29_0.success.max) then
				var_29_13 = 0
			end

			var_29_12.value = var_29_13
			var_0_24.special_time = arg_29_0.success.active
			var_0_24.grid_index = 0

			if arg_29_0.waitingSpecial then
				arg_29_0:addPowerAmount(1, 0)
			end

			return
		end,
		clear = function(arg_30_0)
			return
		end,
		updateSpecialData = function(arg_31_0, arg_31_1)
			var_0_24.special_time = arg_31_0.success.active
			var_0_24.grid_index = arg_31_1
			var_0_24.power_grid = 0

			for iter_31_0 = 1, #arg_31_0.powers do
				if arg_31_0.powers[iter_31_0].index == arg_31_1 and arg_31_0.powers[iter_31_0].cur == arg_31_0.powers[iter_31_0].max then
					var_0_24.power_grid = arg_31_0.powers[iter_31_0].index
				end
			end

			local var_31_0 = arg_31_0._event

			var_2.emit(var_31_0, var_0_16)

			return
		end,
		resetSpecialData = function(arg_32_0)
			var_0_24.special_complete = false

			return
		end,
		addPowerAmount = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_0:getPowerByIndex(arg_33_1)

			if arg_33_0.success then
				if not arg_33_0.success.active then
					arg_33_0.success.cur = arg_33_0.success.cur + arg_33_2

					if arg_33_0.success.cur >= arg_33_0.success.max then
						arg_33_0.success.cur = arg_33_0.success.max

						local var_33_1 = arg_33_0._event

						var_4.emit(var_33_1, var_0_19, {
							callback = function(arg_34_0)
								if arg_34_0 then
									isActive = var_3_10001

									if not var_3_10001(arg_33_0._effectSuccess) then
										setActive = var_1

										var_1(arg_33_0._effectSuccess, true)
									end

									arg_33_0.success.active = true
									var_0_24.special_complete = false
									arg_33_0.waitingSpecial = false
								else
									arg_33_0.waitingSpecial = true
								end

								return
							end
						})
					end
				else
					arg_33_0.success.cur = arg_33_0.success.cur + arg_33_2 / 2

					if arg_33_0.success.cur >= arg_33_0.success.max then
						arg_33_0.success.cur = arg_33_0.success.max
					end
				end
			end

			if var_33_0 and not var_33_0.active then
				var_33_0.cur = var_33_0.cur + arg_33_2

				if var_33_0.cur >= var_33_0.max then
					var_33_0.cur = var_33_0.max
					var_33_0.active = true
				end
			end

			if arg_33_2 > 0 then
				arg_33_0:updateSpecialData(arg_33_1)
			end

			return
		end,
		getPowerByIndex = function(arg_35_0, arg_35_1)
			for iter_35_0 = 1, #arg_35_0.powers do
				if arg_35_0.powers[iter_35_0].index == arg_35_1 then
					return arg_35_0.powers[iter_35_0]
				end
			end

			return nil
		end,
		getPowerAmount = function(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
			if arg_36_1 <= 2 then
				print = var_4

				var_4("分数: " .. var_0_45)

				return var_0_45
			end

			if (arg_36_3 and 2 or 1) == 2 then
				-- block empty
			end

			local var_36_0

			if not var_0_24.special_time or not var_0_42 then
				var_36_0 = 1
			end

			print = var_2_10006

			local var_36_1 = "方块个数: "
			local var_36_2 = arg_36_1
			local var_36_3 = ",combo次数: "
			local var_36_4 = arg_36_2
			local var_36_5 = ", 加倍方块: "

			tostring = var_2_10013

			var_2_10006(var_36_1 .. var_36_2 .. var_36_3 .. var_36_4 .. var_36_5 .. var_2_10013(arg_36_3) .. "，变身倍率: " .. var_36_0)

			print = var_2_10006

			var_2_10006("分数: " .. (var_0_41 + (arg_36_1 - var_0_40) * var_0_39) * (1 + arg_36_2 * var_0_38) * var_36_0)

			return (var_0_41 + (arg_36_1 - var_0_40) * var_0_39) * (1 + arg_36_2 * var_0_38) * var_4 * var_36_0
		end
	}

	var_3.ctor(var_23_0)

	return var_3
end

local function var_0_197(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {
		ctor = function(arg_38_0)
			arg_38_0._sceneTf = arg_37_0
			arg_38_0._event = arg_37_2
			arg_38_0.bgs = {}
			arg_38_0._gameTf = arg_37_1
			findTF = var_1
			arg_38_0._box = var_1(arg_38_0._gameTf, "box")
			findTF = var_1
			arg_38_0._specialPower = var_1(arg_38_0._gameTf, "specialPower")
			findTF = var_1
			arg_38_0._successPower = var_1(arg_38_0._gameTf, "successPower")
			findTF = var_1
			arg_38_0._top = var_1(arg_38_0._gameTf, "top")

			for iter_38_0 = 1, #var_0_72 do
				local var_38_0 = var_0_72[iter_38_0]

				findTF = var_2_10006
				var_2_10006 = var_2_10006(arg_38_0._sceneTf, var_0_72[iter_38_0].source)

				local var_38_1 = var_0_72[iter_38_0].rate

				table = var_8

				var_8.insert(arg_38_0.bgs, {
					tf = var_2_10006,
					rate = var_38_1,
					type = var_0_72[iter_38_0].type
				})
			end

			GetComponent = var_1
			findTF = var_3

			local var_38_2 = var_3(arg_38_0._sceneTf, "scene_background")

			typeof = iter_38_0
			CanvasGroup = var_6
			arg_38_0._bgBackCanvas = var_1(var_38_2, iter_38_0(var_6))
			GetComponent = var_1
			findTF = var_38_2

			local var_38_3 = var_38_2(arg_38_0._sceneTf, "scene_front")

			typeof = var_4
			CanvasGroup = var_6
			arg_38_0._bgFrontCanvas = var_1(var_38_3, var_4(var_6))
			GetComponent = var_1
			findTF = var_38_3

			local var_38_4 = var_38_3(arg_38_0._sceneTf, "scene/bgBeam")

			typeof = var_4
			CanvasGroup = var_6
			arg_38_0._bgBeamCanvas = var_1(var_38_4, var_4(var_6))

			local var_38_5 = arg_38_0._event

			var_1.bind(var_38_5, var_0_17, function(arg_39_0, arg_39_1, arg_39_2)
				local var_39_0 = arg_39_1[1]
				local var_39_1 = arg_39_1[2] and -1 or 1
				local var_39_2 = arg_39_1[3]

				if not arg_38_0.inCamera then
					local var_39_3 = arg_38_0
					local var_39_4 = var_6.setTargetFllow

					Vector2 = var_3_10009

					var_39_4(var_39_3, var_3_10009(var_39_1 * var_39_0.x / 10, var_39_1 * var_39_0.y / 10), var_39_2)
				end

				return
			end)

			local var_38_6 = arg_38_0._event

			var_1.bind(var_38_6, var_0_21, function(arg_40_0, arg_40_1, arg_40_2)
				local var_40_0 = arg_38_0

				var_40_0.inCamera = true
				Vector2 = var_40_0

				local var_40_1 = var_40_0(550, 100)

				if arg_40_1 and arg_40_1.playingAction and arg_40_1.playingAction.camera_pos then
					var_40_1 = arg_40_1.playingAction.camera_pos
				end

				local var_40_2 = arg_38_0

				var_4.setTargetFllow(var_40_2, var_40_1)

				local var_40_3 = arg_38_0

				var_4.setBeam(var_40_3, false)

				return
			end)

			local var_38_7 = arg_38_0._event

			var_1.bind(var_38_7, var_0_22, function(arg_41_0, arg_41_1, arg_41_2)
				arg_38_0.followTf = nil
				arg_38_0.followInit = nil

				local var_41_0 = arg_38_0
				local var_41_1 = var_3.setTargetFllow

				Vector2 = var_3_10006

				var_41_1(var_41_0, var_3_10006(0, 0), function()
					return
				end, true)

				local var_41_2 = arg_38_0

				var_3.setBeam(var_41_2, true)

				arg_38_0.inCamera = false

				return
			end)

			return
		end,
		start = function(arg_43_0)
			Vector2 = var_2_10001
			arg_43_0.targetVec = var_2_10001(var_0_57.x, var_0_57.y)
			Vector2 = var_1
			arg_43_0.currentVec = var_1(var_0_57.x, var_0_57.y)

			for iter_43_0 = 1, #arg_43_0.bgs do
				local var_43_0 = arg_43_0.bgs[iter_43_0].tf
				local var_43_1 = arg_43_0.bgs[iter_43_0].rate
				local var_43_2 = arg_43_0.bgs[iter_43_0].type

				if var_43_0 then
					setActive = var_2_10008

					var_2_10008(var_43_0, var_43_2 == var_0_68 or var_43_2 == var_0_71)

					Vector2 = var_2_10008
					var_43_0.anchoredPosition = var_2_10008(arg_43_0.currentVec.x * var_43_1, arg_43_0.currentVec.y * var_43_1)
				end
			end

			arg_43_0._bgBackCanvas.alpha = 1
			arg_43_0._bgFrontCanvas.alpha = 1

			local var_43_3 = arg_43_0._bgBeamCanvas

			var_43_3.alpha = 0
			setActive = var_43_3

			var_43_3(arg_43_0._box, true)

			setActive = var_43_3

			var_43_3(arg_43_0._specialPower, true)

			setActive = var_43_3

			var_43_3(arg_43_0._successPower, true)

			setActive = var_43_3

			var_43_3(arg_43_0._top, true)

			return
		end,
		clear = function(arg_44_0)
			LeanTween = var_2_10001

			local var_44_0 = var_2_10001.isTweening

			go = var_2_10003

			if var_44_0(var_2_10003(arg_44_0._sceneTf)) then
				LeanTween = var_1

				local var_44_1 = var_1.cancel

				go = var_3

				var_44_1(var_3(arg_44_0._sceneTf), false)
			end

			return
		end,
		step = function(arg_45_0)
			local var_45_0 = {
				0,
				0
			}

			if arg_45_0.followTf then
				var_45_0 = {
					arg_45_0.followTf.anchoredPosition.x - arg_45_0.followInit.x,
					arg_45_0.followTf.anchoredPosition.y - arg_45_0.followInit.y
				}
			end

			local var_45_1 = 0
			local var_45_2 = 0
			local var_45_3 = arg_45_0.targetVec.x - var_45_0[1]
			local var_45_4 = arg_45_0.targetVec.y - var_45_0[2]

			if var_45_3 ~= arg_45_0.currentVec.x then
				var_45_1 = (var_45_3 - arg_45_0.currentVec.x) * var_0_58
				math = var_6

				if var_6.abs(var_45_1) < var_0_59 then
					local var_45_5 = var_0_59

					math = var_7
					var_45_1 = var_45_5 * var_7.sign(var_45_1)
				end

				local var_45_6 = arg_45_0.currentVec

				var_45_6.x = arg_45_0.currentVec.x + var_45_1
				math = var_45_6

				if var_45_6.abs(arg_45_0.currentVec.x - var_45_3) <= var_0_59 then
					arg_45_0.currentVec.x = var_45_3
				end
			end

			if var_45_4 ~= arg_45_0.currentVec.y then
				var_45_2 = (var_45_4 - arg_45_0.currentVec.y) * var_0_58
				math = var_6

				if var_6.abs(var_45_2) < var_0_59 then
					local var_45_7 = var_0_59

					math = var_7
					var_45_2 = var_45_7 * var_7.sign(var_45_2)
				end

				local var_45_8 = arg_45_0.currentVec

				var_45_8.y = arg_45_0.currentVec.y + var_45_2
				math = var_45_8

				if var_45_8.abs(arg_45_0.currentVec.y - var_45_4) <= var_0_59 then
					arg_45_0.currentVec.y = var_45_4
				end
			end

			if var_45_1 ~= 0 or var_45_2 ~= 0 then
				arg_45_0:moveTo(arg_45_0.currentVec)
			end

			return
		end,
		moveTo = function(arg_46_0, arg_46_1)
			for iter_46_0 = 1, #arg_46_0.bgs do
				local var_46_0 = arg_46_0.bgs[iter_46_0].tf
				local var_46_1 = arg_46_0.bgs[iter_46_0].rate

				if arg_46_0.bgs[iter_46_0].type == var_0_68 or var_8 == var_0_71 then
					Vector2 = var_9
					var_46_0.anchoredPosition = var_9(arg_46_1.x * var_46_1, arg_46_1.y * var_46_1)
				end
			end

			return
		end,
		setTargetFllow = function(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
			if not arg_47_3 then
				arg_47_0.targetVec = arg_47_1
				arg_47_0.moveCallback = arg_47_2
			else
				arg_47_0.currentVec = arg_47_1
				arg_47_0.targetVec = arg_47_1

				arg_47_0:moveTo(arg_47_1)

				if arg_47_2 then
					arg_47_2()
				end
			end

			return
		end,
		setBeam = function(arg_48_0, arg_48_1, arg_48_2)
			LeanTween = var_2_10003

			local var_48_0 = var_2_10003.isTweening

			go = var_2_10005

			local var_48_1

			if var_48_0(var_2_10005(arg_48_0._sceneTf)) then
				LeanTween = var_48_1
				var_48_1 = var_48_1.cancel
				go = var_5

				var_48_1(var_5(arg_48_0._sceneTf), false)
			end

			if arg_48_1 then
				setActive = var_48_1

				var_48_1(arg_48_0._box, true)

				setActive = var_48_1

				var_48_1(arg_48_0._specialPower, true)

				setActive = var_48_1

				var_48_1(arg_48_0._successPower, true)

				setActive = var_48_1

				var_48_1(arg_48_0._top, true)
			else
				setActive = var_48_1

				var_48_1(arg_48_0._box, false)

				setActive = var_48_1

				var_48_1(arg_48_0._specialPower, false)

				setActive = var_48_1

				var_48_1(arg_48_0._successPower, false)

				setActive = var_48_1

				var_48_1(arg_48_0._top, false)
			end

			LeanTween = var_48_1

			local var_48_2 = var_48_1.value

			go = var_5

			local var_48_3 = var_48_2(var_5(arg_48_0._sceneTf), 0, 1, 0.2)
			local var_48_4 = var_3.setOnUpdate

			System = var_6

			local var_48_5 = var_48_4(var_48_3, var_6.Action_float(function(arg_49_0)
				if arg_48_1 then
					arg_48_0._bgBackCanvas.alpha = arg_49_0
					arg_48_0._bgFrontCanvas.alpha = arg_49_0
					arg_48_0._bgBeamCanvas.alpha = 1 - arg_49_0
				else
					arg_48_0._bgBackCanvas.alpha = 1 - arg_49_0
					arg_48_0._bgFrontCanvas.alpha = 1 - arg_49_0
					arg_48_0._bgBeamCanvas.alpha = arg_49_0
				end

				return
			end))
			local var_48_6 = var_3.setOnComplete

			System = var_6

			var_48_6(var_48_5, var_6.Action(function()
				if arg_48_2 then
					arg_48_2()
				end

				return
			end))

			return
		end
	}

	var_3.ctor(var_37_0)

	return var_3
end

local function var_0_198(arg_51_0, arg_51_1)
	local var_51_0 = {
		ctor = function(arg_52_0)
			arg_52_0._scene = arg_51_0
			findTF = var_1
			arg_52_0._tpl = var_1(arg_52_0._scene, "tpl")
			findTF = var_1
			arg_52_0._leftRolePos = var_1(arg_52_0._scene, "rolePos/leftRole")
			findTF = var_1
			arg_52_0._rightRolePos = var_1(arg_52_0._scene, "rolePos/rightRole")
			arg_52_0._event = arg_51_1

			local var_52_0 = arg_52_0._event

			var_1.bind(var_52_0, var_0_16, function()
				local var_53_0 = arg_52_0

				var_0.onGridTrigger(var_53_0)

				return
			end)

			local var_52_1 = arg_52_0._event

			var_1.bind(var_52_1, var_0_19, function(arg_54_0, arg_54_1, arg_54_2)
				local var_54_0 = false

				pairs = var_3_10004

				for iter_54_0, iter_54_1 in var_3_10004(arg_52_0.playingDatas) do
					if iter_54_1.inPlaying then
						var_54_0 = true
					end
				end

				if arg_54_1.callback then
					arg_54_1.callback(not var_54_0)
				end

				if not var_54_0 then
					local var_54_1 = arg_52_0

					var_4.onRoleSpecial(var_54_1, arg_54_1)
				end

				return
			end)

			local var_52_2 = arg_52_0._event

			var_1.bind(var_52_2, var_0_20, function()
				local var_55_0 = arg_52_0

				var_0.onRoleSpecialEnd(var_55_0)

				return
			end)

			return
		end,
		start = function(arg_56_0)
			if arg_56_0.leftRole then
				destroy = var_1

				var_1(arg_56_0.leftRole.tf)

				arg_56_0.leftRole = nil
			end

			if arg_56_0.rightRole then
				destroy = var_1

				var_1(arg_56_0.rightRole.tf)

				arg_56_0.rightRole = nil
			end

			arg_56_0.leftRole = arg_56_0:createRole(var_0_47, true, arg_56_0._leftRolePos)
			arg_56_0.rightRole = arg_56_0:createRole(var_0_48, false, arg_56_0._rightRolePos)
			arg_56_0.leftRole.targetRole = arg_56_0.rightRole
			arg_56_0.rightRole.targetRole = arg_56_0.leftRole

			local var_56_0 = arg_56_0.leftRole.animator

			var_1.SetTrigger(var_56_0, "idle")

			local var_56_1 = arg_56_0.leftRole.animator

			var_1.SetBool(var_56_1, "special", false)

			local var_56_2 = arg_56_0.rightRole.animator

			var_1.SetTrigger(var_56_2, "idle")

			local var_56_3 = arg_56_0.rightRole.animator

			var_1.SetBool(var_56_3, "special", false)

			arg_56_0.leftRole.specialBody = false
			arg_56_0.rightRole.specialBody = false

			local var_56_4 = arg_56_0.leftRole

			Vector2 = var_2
			var_56_4.anchoredPosition = var_2(0, 0)

			local var_56_5 = arg_56_0.rightRole

			Vector2 = var_2
			var_56_5.anchoredPosition = var_2(0, 0)
			arg_56_0.leftRole.specialTime = false
			arg_56_0.rightRole.specialTime = false
			arg_56_0.playingDatas = {}
			arg_56_0.playingDatas[arg_56_0.leftRole.name] = {
				role = arg_56_0.leftRole
			}
			arg_56_0.playingDatas[arg_56_0.leftRole.name].skillDatas = {}
			arg_56_0.playingDatas[arg_56_0.rightRole.name] = {
				role = arg_56_0.rightRole
			}
			arg_56_0.playingDatas[arg_56_0.rightRole.name].skillDatas = {}
			arg_56_0.skillDeltaTime = 0
			math = var_1
			arg_56_0.emptySkillTime = var_1.random(1, 2)
			arg_56_0.addScore = {
				0,
				0
			}

			local var_56_6 = arg_56_0._event
			local var_56_7 = var_1.emit
			local var_56_8 = var_0_17
			local var_56_9 = {
				nil,
				false
			}

			Vector2 = var_6
			var_56_9[1] = var_6(0, 0)

			var_56_7(var_56_6, var_56_8, var_56_9)

			return
		end,
		step = function(arg_57_0)
			arg_57_0:checkSkillDeltaTime()
			arg_57_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_58_0)
			if arg_58_0.skillDeltaTime and arg_58_0.skillDeltaTime <= 0 then
				arg_58_0.skillDeltaTime = var_0_60
			end

			local var_58_0 = arg_58_0.skillDeltaTime

			Time = var_2_10002
			arg_58_0.skillDeltaTime = var_58_0 - var_2_10002.deltaTime

			local var_58_1

			if arg_58_0.skillDeltaTime <= 0 then
				var_58_1 = false
				pairs = var_2

				for iter_58_0, iter_58_1 in var_2(arg_58_0.playingDatas) do
					if iter_58_1.inPlaying then
						var_58_1 = true
					end
				end

				if not var_58_1 then
					pairs = var_2

					for iter_58_2, iter_58_3 in var_2(arg_58_0.playingDatas) do
						if #iter_58_3.skillDatas > 0 then
							arg_58_0:applyOrAddSkillData(iter_58_3)

							break
						end
					end
				end
			end

			var_0_195 = false
			pairs = var_58_1

			for iter_58_4, iter_58_5 in var_58_1(arg_58_0.playingDatas) do
				if iter_58_5.inPlaying then
					var_0_195 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_59_0)
			if arg_59_0.emptySkillTime and arg_59_0.emptySkillTime <= 0 then
				arg_59_0.emptySkillTime = var_0_61
			end

			local var_59_0 = arg_59_0.emptySkillTime

			Time = var_2_10002
			arg_59_0.emptySkillTime = var_59_0 - var_2_10002.deltaTime

			if arg_59_0.emptySkillTime <= 0 then
				local var_59_1 = false

				pairs = var_2

				for iter_59_0, iter_59_1 in var_2(arg_59_0.playingDatas) do
					if iter_59_1.inPlaying then
						var_59_1 = true
					end
				end

				if not var_59_1 and arg_59_0:getRoleEmptySkill(arg_59_0.rightRole) then
					arg_59_0:addRolePlaying(arg_59_0.rightRole, var_2)
				end
			end

			return
		end,
		getRoleTestSkill = function(arg_60_0, arg_60_1)
			return arg_60_1.skill[10]
		end,
		getRoleEmptySkill = function(arg_61_0, arg_61_1)
			local var_61_0 = {}

			for iter_61_0 = 1, #arg_61_1.skill do
				local var_61_1 = arg_61_1.skill[iter_61_0]

				tobool = var_2_10008

				if var_2_10008(var_61_1.special_time) == arg_61_1.specialBody and var_61_1.atk_index then
					table = var_2_10008

					var_2_10008.insert(var_61_0, var_61_1)
				end
			end

			if #var_61_0 > 0 then
				Clone = var_3
				math = var_5

				return var_3(var_61_0[var_5.random(1, #var_61_0)])
			end

			return nil
		end,
		onRoleSpecial = function(arg_62_0, arg_62_1)
			arg_62_0.leftRole.specialTime = true

			for iter_62_0 = 1, #arg_62_0.leftRole.skill do
				if arg_62_0.leftRole.skill[iter_62_0].special_trigger then
					local var_62_0 = arg_62_0
					local var_62_1 = arg_62_0.addRolePlaying
					local var_62_2 = arg_62_0.leftRole

					Clone = var_2_10011

					var_62_1(var_62_0, var_62_2, var_2_10011(var_6))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_63_0)
			arg_63_0.leftRole.specialTime = false

			local var_63_0
			local var_63_1

			for iter_63_0 = 1, #arg_63_0.leftRole.skill do
				if arg_63_0.leftRole.skill[iter_63_0].special_time and var_7.power_index == 1 and var_7.atk_index > 0 then
					Clone = var_8
					var_63_1 = var_8(var_7)
				end

				if not var_7.special_trigger and var_7.special_end then
					Clone = var_8
					var_63_0 = var_8(var_7)
				end
			end

			if var_63_1 then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, var_63_1)
			end

			if var_63_0 then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, var_63_0)
			end

			return
		end,
		clear = function(arg_64_0)
			LeanTween = var_2_10001

			local var_64_0 = var_2_10001.isTweening

			go = var_2_10003

			local var_64_1

			if var_64_0(var_2_10003(arg_64_0._leftRolePos)) then
				LeanTween = var_64_1
				var_64_1 = var_64_1.cancel
				go = var_3

				var_64_1(var_3(arg_64_0._leftRolePos))
			end

			LeanTween = var_64_1

			local var_64_2 = var_64_1.isTweening

			go = var_3

			local var_64_3

			if var_64_2(var_3(arg_64_0._rightRolePos)) then
				LeanTween = var_64_3
				var_64_3 = var_64_3.cancel
				go = var_3

				var_64_3(var_3(arg_64_0._rightRolePos))
			end

			LeanTween = var_64_3

			local var_64_4 = var_64_3.isTweening

			go = var_3

			local var_64_5

			if var_64_4(var_3(arg_64_0.rightRole.tf)) then
				LeanTween = var_64_5
				var_64_5 = var_64_5.cancel
				go = var_3

				var_64_5(var_3(arg_64_0.rightRole.tf))
			end

			LeanTween = var_64_5

			local var_64_6 = var_64_5.isTweening

			go = var_3

			if var_64_6(var_3(arg_64_0.leftRole.tf)) then
				LeanTween = var_1

				local var_64_7 = var_1.cancel

				go = var_3

				var_64_7(var_3(arg_64_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_65_0)
			local var_65_0 = var_0_24.grid_index
			local var_65_1 = var_0_24.power_grid
			local var_65_2 = var_0_24.special_time

			for iter_65_0 = 1, #arg_65_0.leftRole.skill do
				local var_65_3 = arg_65_0.leftRole.skill[iter_65_0]

				tobool = var_2_10009
				var_2_10009 = var_2_10009(var_65_3.special_time)
				tobool = var_2_10010

				if var_2_10009 == var_2_10010(arg_65_0.leftRole.specialTime) and var_65_3.power_index == var_65_1 then
					table = var_2_10009

					if var_2_10009.contains(var_65_3.grid_index, var_65_0) and var_65_3.atk_index then
						local var_65_4 = arg_65_0

						var_2_10009 = arg_65_0.addRolePlaying

						local var_65_5 = arg_65_0.leftRole

						Clone = var_2_10013

						var_2_10009(var_65_4, var_65_5, var_2_10013(var_65_3))
					end
				end
			end

			return
		end,
		createRole = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			local var_66_0 = arg_66_0

			if not arg_66_0.getRoleData(var_66_0, arg_66_1) then
				return nil
			end

			local var_66_1 = {}

			tf = var_66_0
			instantiate = var_2_10008
			findTF = var_2_10010

			local var_66_2 = var_66_0(var_2_10008(var_2_10010(arg_66_0._tpl, var_4.name)))

			SetParent = var_7

			var_7(var_66_2, arg_66_3)

			Vector2 = var_7
			var_66_2.anchoredPosition = var_7(0, 0)
			Vector3 = var_7
			var_66_2.localScale = var_7(1, 1, 1)
			setActive = var_7

			var_7(var_66_2, true)

			local var_66_3

			if var_4.anim_init_pos then
				findTF = var_66_3
				var_66_3 = var_66_3(var_66_2, "body/anim")
				var_66_3.anchoredPosition = var_4.anim_init_pos
			end

			findTF = var_66_3

			local var_66_4 = var_66_3(var_66_2, "body")

			findTF = var_8

			local var_66_5 = var_8(var_66_4, "anim")

			GetComponent = var_9

			local var_66_6 = var_66_5

			typeof = var_12
			Animator = var_2_10014

			local var_66_7 = var_9(var_66_6, var_12(var_2_10014))

			GetComponent = var_10

			local var_66_8 = var_66_5

			typeof = var_13
			DftAniEvent = var_2_10015

			local var_66_9 = var_10(var_66_8, var_13(var_2_10015))

			var_10.SetStartEvent(var_66_9, function()
				if var_66_1.startCallback then
					var_66_1.startCallback()
				end

				return
			end)
			var_10:SetTriggerEvent(function()
				if var_66_1.triggerCallback then
					var_66_1.triggerCallback()
				end

				return
			end)
			var_10:SetEndEvent(function()
				if var_66_1.endCallback then
					var_66_1.endCallback()
				end

				return
			end)

			var_66_1.name = var_4.name
			var_66_1.tf = var_66_2
			GetComponent = var_11

			local var_66_10 = var_66_2

			typeof = var_14
			CanvasGroup = var_2_10016
			var_66_1.canvasGroup = var_11(var_66_10, var_14(var_2_10016))
			var_66_1.body = var_66_4
			var_66_1.animTf = var_66_5
			var_66_1.animator = var_66_7
			var_66_1.dftEvent = var_10
			var_66_1.startCallback = nil
			var_66_1.triggerCallback = nil
			var_66_1.endCallback = nil
			var_66_1.skill = var_4.skill
			var_66_1.name = var_4.name
			var_66_1.index = var_4.index
			var_66_1.actions = var_4.actions

			return var_66_1
		end,
		getRoleData = function(arg_70_0, arg_70_1)
			for iter_70_0 = 1, #var_0_191 do
				if var_0_191[iter_70_0].index == arg_70_1 then
					Clone = var_6

					return var_6(var_0_191[iter_70_0])
				end
			end

			return nil
		end,
		setDftHandle = function(arg_71_0, arg_71_1, arg_71_2, arg_71_3, arg_71_4)
			arg_71_1.startCallback = arg_71_2
			arg_71_1.triggerCallback = arg_71_3
			arg_71_1.endCallback = arg_71_4

			return
		end,
		playAnimation = function(arg_72_0, arg_72_1, arg_72_2)
			local var_72_0 = arg_72_1.animator

			var_3.Play(var_72_0, arg_72_2, -1, 0)

			return
		end,
		addRolePlaying = function(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
			pairs = var_2_10004

			for iter_73_0, iter_73_1 in var_2_10004(arg_73_0.playingDatas) do
				if iter_73_0 == arg_73_1.name then
					if arg_73_3 then
						arg_73_0:applyOrAddSkillData(iter_73_1, arg_73_2)
					else
						table = var_9

						var_9.insert(iter_73_1.skillDatas, arg_73_2)

						if arg_73_2.power_index > 0 and arg_73_2.atk_index > 1 or arg_73_2.special_trigger then
							for iter_73_2 = #iter_73_1.skillDatas - 1, 1, -1 do
								if iter_73_1.skillDatas[iter_73_2].power_index == 0 and var_13.atk_index == 1 then
									table = var_14

									if var_14.remove(iter_73_1.skillDatas, iter_73_2).score then
										arg_73_0.addScore = {
											arg_73_0.addScore[1] + var_14.score[1],
											arg_73_0.addScore[2] + var_14.score[2]
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
		applyOrAddSkillData = function(arg_74_0, arg_74_1, arg_74_2)
			if arg_74_1.inPlaying then
				table = var_3

				var_3.insert(arg_74_1.skillDatas, arg_74_2)

				return
			end

			arg_74_1.inPlaying = true

			local var_74_0 = arg_74_1.role
			local var_74_1

			if not arg_74_2 then
				table = var_2_10005
				var_74_1 = var_2_10005.remove(arg_74_1.skillDatas, 1)
			end

			arg_74_1.currentSkill = var_74_1
			arg_74_1.actions = var_74_1.actions

			if var_74_1.anim_bool then
				local var_74_2 = var_74_0.animator

				var_6.SetBool(var_74_2, var_5, true)
			end

			if var_74_0 == arg_74_0.leftRole and not var_74_1.dmg_index then
				local var_74_3 = arg_74_0._leftRolePos

				var_6.SetSiblingIndex(var_74_3, 1)
			elseif var_74_0 == arg_74_0.rightRole and not var_74_1.dmg_index then
				local var_74_4 = arg_74_0._rightRolePos

				var_6.SetSiblingIndex(var_74_4, 1)
			end

			if var_74_1.anim_init_pos then
				findTF = var_2_10007
				var_2_10007(arg_74_1.role.tf, "body/anim").anchoredPosition = var_6
			end

			if var_74_1.special_end then
				arg_74_1.role.specialBody = false
			elseif var_74_1.special_trigger then
				arg_74_1.role.specialBody = true
			end

			arg_74_1.actionIndex = 1

			arg_74_0:checkAction(arg_74_1, function()
				arg_74_1.inPlaying = false

				local var_75_0 = arg_74_0._event
				local var_75_1 = var_0.emit
				local var_75_2 = var_0_17
				local var_75_3 = {
					nil,
					false
				}

				Vector2 = var_3_10005
				var_75_3[1] = var_3_10005(0, 0)

				var_75_1(var_75_0, var_75_2, var_75_3)

				return
			end)

			return
		end,
		checkAction = function(arg_76_0, arg_76_1, arg_76_2)
			if arg_76_1.actions and arg_76_1.actionIndex <= #arg_76_1.actions then
				arg_76_1.playingAction = arg_76_1.actions[arg_76_1.actionIndex]
				arg_76_1.actionIndex = arg_76_1.actionIndex + 1

				local var_76_0 = arg_76_1.playingAction.anim_name
				local var_76_1 = arg_76_1.playingAction.time
				local var_76_2 = arg_76_1.playingAction.move
				local var_76_3 = arg_76_1.playingAction.over_offset
				local var_76_4 = arg_76_1.playingAction.camera
				local var_76_5 = arg_76_1.playingAction.sound_start
				local var_76_6 = arg_76_1.playingAction.sound_trigger
				local var_76_7 = arg_76_1.playingAction.sound_end
				local var_76_8 = arg_76_1.currentSkill.special_trigger
				local var_76_9 = arg_76_1.currentSkill.special_time
				local var_76_10 = arg_76_1.currentSkill.atk_index

				if var_76_8 or var_76_9 and var_76_10 and var_76_10 >= 2 then
					local var_76_11 = arg_76_0._event

					var_14.emit(var_76_11, var_0_23, true)
				end

				if var_76_1 and var_76_1 > 0 then
					-- block empty
				else
					local function var_76_12()
						if var_76_5 then
							pg = var_0

							local var_77_0 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_77_0, "event:/ui/" .. var_76_5)
						end

						if var_76_2 then
							local var_77_1 = arg_76_0

							var_0.moveRole(var_77_1, arg_76_1.role, var_76_2)
						end

						if var_76_4 then
							arg_76_1.role.targetRole.canvasGroup.alpha = 0

							local var_77_2 = arg_76_0._event

							var_0.emit(var_77_2, var_0_21, arg_76_1)
						end

						return
					end

					function var_2_10015()
						if var_76_6 then
							pg = var_0

							local var_78_0 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_78_0, "event:/ui/" .. var_76_6)
						end

						if var_76_4 then
							var_76_4 = false
							arg_76_1.role.targetRole.canvasGroup.alpha = 1

							local var_78_1 = arg_76_0._event

							var_0.emit(var_78_1, var_0_22)
						else
							if arg_76_1.currentSkill.anim_trigger_pos then
								findTF = var_3_10001
								var_3_10001(arg_76_1.role.tf, "body/anim").anchoredPosition = var_0
							end

							if arg_76_1.currentSkill.atk_index then
								local var_78_2 = arg_76_0
								local var_78_3 = var_2.getRoleDmgData(var_78_2, arg_76_1.role.targetRole, var_1)
								local var_78_4 = arg_76_1.role.targetRole.name

								if var_78_3 then
									pairs = var_78_2

									for iter_78_0, iter_78_1 in var_78_2(arg_76_0.playingDatas) do
										if iter_78_0 == var_78_4 then
											local var_78_5 = arg_76_0

											var_3_10009 = var_3_10009.applyOrAddSkillData

											local var_78_6 = iter_78_1

											Clone = var_3_10013

											var_3_10009(var_78_5, var_78_6, var_3_10013(var_78_3), true)
										end
									end
								end

								if arg_76_1.currentSkill.score and arg_76_1.role == arg_76_0.leftRole then
									local var_78_7 = arg_76_0._event
									local var_78_8 = var_5.emit
									local var_78_9 = var_0_18

									math = var_3_10009

									var_78_8(var_78_7, var_78_9, var_3_10009.random(var_4[1] + arg_76_0.addScore[1], var_4[2] + arg_76_0.addScore[2]))

									arg_76_0.addScore = {
										0,
										0
									}
								end
							end
						end

						return
					end

					local function var_76_13()
						if var_76_7 then
							pg = var_0
							var_3_10002 = var_0.CriMgr.GetInstance()

							var_0.PlaySoundEffect_V3(var_3_10002, "event:/ui/" .. var_76_7)
						end

						LeanTween = var_0

						local var_79_0 = var_0.isTweening

						go = var_3_10002

						if var_79_0(var_3_10002(arg_76_1.role.tf)) then
							LeanTween = var_0

							local var_79_1 = var_0.cancel

							go = var_2

							var_79_1(var_2(arg_76_1.role.tf))
						end

						if arg_76_1.currentSkill.anim_end_pos then
							findTF = var_3_10001
							var_3_10001(arg_76_1.role.tf, "body/anim").anchoredPosition = var_0
						end

						local var_79_2 = arg_76_0._event

						var_1.emit(var_79_2, var_0_23, false)

						if var_76_3 then
							local var_79_3 = arg_76_1.role.tf

							Vector2 = var_2
							var_79_3.anchoredPosition = var_2(arg_76_1.role.tf.anchoredPosition.x + var_76_3.x, arg_76_1.role.tf.anchoredPosition.y + var_76_3.y)
						end

						if arg_76_1.currentSkill.special_trigger and var_0_24.special_time and not var_0_24.special_complete then
							var_0_24.special_complete = true
						end

						arg_76_1.playingAction = nil

						local var_79_4 = arg_76_0

						var_1.setDftHandle(var_79_4, arg_76_1.role, nil, nil, nil)

						local var_79_5 = arg_76_0

						var_1.checkAction(var_79_5, arg_76_1, arg_76_2)

						return
					end

					arg_76_0:setDftHandle(arg_76_1.role, var_76_12, var_2_10015, var_76_13)
					arg_76_0:playAnimation(arg_76_1.role, var_76_0)
				end
			else
				if arg_76_1.currentSkill.atk_index == 3 then
					local var_76_14 = arg_76_0
					local var_76_15 = arg_76_0.getRoleDmgBack(var_76_14, arg_76_1.role.targetRole, var_3)
					local var_76_16 = arg_76_1.role.targetRole.name

					if var_76_15 then
						pairs = var_76_14

						for iter_76_0, iter_76_1 in var_76_14(arg_76_0.playingDatas) do
							if iter_76_0 == var_76_16 then
								local var_76_17 = arg_76_0
								local var_76_18 = arg_76_0.applyOrAddSkillData
								local var_76_19 = iter_76_1

								Clone = var_2_10015

								var_76_18(var_76_17, var_76_19, var_2_10015(var_76_15))
							end
						end
					end
				end

				if arg_76_2 then
					arg_76_2()
				end
			end

			return
		end,
		moveRole = function(arg_80_0, arg_80_1, arg_80_2)
			LeanTween = var_2_10003

			local var_80_0 = var_2_10003.isTweening

			go = var_2_10005

			if var_80_0(var_2_10005(arg_80_1.tf)) then
				LeanTween = var_3

				local var_80_1 = var_3.cancel

				go = var_5

				var_80_1(var_5(arg_80_1.tf))
			end

			if arg_80_2.distance then
				local var_80_2 = arg_80_0._event

				var_3.emit(var_80_2, var_0_17, {
					arg_80_2.distance,
					arg_80_1 == arg_80_0.leftRole
				})

				LeanTween = var_3

				local var_80_3 = var_3.move
				local var_80_4 = arg_80_1.tf

				Vector3 = var_6

				local var_80_5 = var_80_3(var_80_4, var_6(arg_80_2.distance.x, arg_80_2.distance.y, 0), arg_80_2.time)
				local var_80_6 = var_3.setEase
				local var_80_7

				if not arg_80_2.ease then
					LeanTweenType = var_80_7
					var_80_7 = var_80_7.linear
				end

				var_80_6(var_80_5, var_80_7)
			elseif arg_80_2.distance_m then
				Vector2 = var_3

				local var_80_8 = var_3(arg_80_1.tf.anchoredPosition.x + arg_80_2.distance_m.x, arg_80_1.tf.anchoredPosition.y + arg_80_2.distance_m.y)
				local var_80_9 = arg_80_0._event

				var_4.emit(var_80_9, var_0_17, {
					var_80_8,
					arg_80_1 == arg_80_0.leftRole
				})

				LeanTween = var_4

				local var_80_10 = var_4.move
				local var_80_11 = arg_80_1.tf

				Vector3 = var_7

				local var_80_12 = var_80_10(var_80_11, var_7(var_80_8.x, var_80_8.y, 0), arg_80_2.time)
				local var_80_13 = var_4.setEase
				local var_80_14

				if not arg_80_2.ease then
					LeanTweenType = var_80_14
					var_80_14 = var_80_14.linear
				end

				var_80_13(var_80_12, var_80_14)
			end

			return
		end,
		getRoleDmgData = function(arg_81_0, arg_81_1, arg_81_2)
			local var_81_0 = arg_81_1.skill

			for iter_81_0 = 1, #var_81_0 do
				if var_81_0[iter_81_0].dmg_index == arg_81_2 then
					local var_81_1 = var_8.special_time

					tobool = var_2_10010

					if var_81_1 == var_2_10010(arg_81_1.specialBody) then
						return var_8
					end
				end
			end

			return nil
		end,
		getRoleDmgBack = function(arg_82_0, arg_82_1, arg_82_2)
			local var_82_0 = arg_82_1.skill

			for iter_82_0 = 1, #var_82_0 do
				if var_82_0[iter_82_0].dmg_back then
					local var_82_1 = var_8.special_time

					tobool = var_2_10010

					if var_82_1 == var_2_10010(arg_82_1.specialBody) then
						return var_8
					end
				end
			end

			return nil
		end
	}

	var_2.ctor(var_51_0)

	return var_2
end

function var_0_1.getUIName(arg_83_0)
	return "GridGameReUI"
end

function var_0_1.didEnter(arg_84_0)
	arg_84_0:initEvent()
	arg_84_0:initData()
	arg_84_0:initUI()
	arg_84_0:initGameUI()
	arg_84_0:initController()
	arg_84_0:updateMenuUI()
	arg_84_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_85_0)
	arg_85_0:bind(var_0_18, function(arg_86_0, arg_86_1, arg_86_2)
		local var_86_0 = arg_85_0

		var_3.addScore(var_86_0, arg_86_1)

		return
	end)
	arg_85_0:bind(var_0_23, function(arg_87_0, arg_87_1, arg_87_2)
		arg_85_0.ignoreTime = arg_87_1

		return
	end)

	return
end

function var_0_1.onEventHandle(arg_88_0, arg_88_1)
	return
end

function var_0_1.initData(arg_89_0)
	Application = var_1_10001

	local var_89_0

	if not var_1_10001.targetFrameRate then
		var_89_0 = 60
	end

	if 60 < var_89_0 then
		var_89_0 = 60
	end

	Timer = var_2
	arg_89_0.timer = var_2.New(function()
		local var_90_0 = arg_89_0

		var_0.onTimer(var_90_0)

		return
	end, 1 / var_89_0, -1)

	return
end

function var_0_1.initUI(arg_91_0)
	findTF = var_1_10001
	arg_91_0.backSceneTf = var_1_10001(arg_91_0._tf, "scene_background")
	findTF = var_1
	arg_91_0.sceneTf = var_1(arg_91_0._tf, "scene")
	findTF = var_1
	arg_91_0.clickMask = var_1(arg_91_0._tf, "clickMask")
	setText = var_1
	findTF = var_3

	local var_91_0 = var_3(arg_91_0._tf, "ui/gameUI/top/time")

	i18n = var_4

	var_1(var_91_0, var_4("mini_game_time"))

	setText = var_1
	findTF = var_91_0

	local var_91_1 = var_91_0(arg_91_0._tf, "ui/gameUI/top/scoreDesc")

	i18n = var_4

	var_1(var_91_1, var_4("mini_game_score"))

	setText = var_1
	findTF = var_91_1

	local var_91_2 = var_91_1(arg_91_0._tf, "pop/LeaveUI/ad/desc")

	i18n = var_4

	var_1(var_91_2, var_4("mini_game_leave"))

	setText = var_1
	findTF = var_91_2

	local var_91_3 = var_91_2(arg_91_0._tf, "pop/pauseUI/ad/desc")

	i18n = var_4

	var_1(var_91_3, var_4("mini_game_pause"))

	setText = var_1
	findTF = var_91_3

	local var_91_4 = var_91_3(arg_91_0._tf, "pop/SettleMentUI/ad/currentTextDesc")

	i18n = var_4

	var_1(var_91_4, var_4("mini_game_cur_score"))

	setText = var_1
	findTF = var_91_4

	local var_91_5 = var_91_4(arg_91_0._tf, "pop/SettleMentUI/ad/highTextDesc")

	i18n = var_4

	var_1(var_91_5, var_4("mini_game_high_score"))

	findTF = var_1
	arg_91_0.countUI = var_1(arg_91_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_91_6 = var_3(arg_91_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_91_0.countAnimator = var_1(var_91_6, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_91_6

	local var_91_7 = var_91_6(arg_91_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_91_0.countDft = var_1(var_91_7, var_4(var_6))

	local var_91_8 = arg_91_0.countDft

	var_1.SetTriggerEvent(var_91_8, function()
		return
	end)

	local var_91_9 = arg_91_0.countDft

	var_1.SetEndEvent(var_91_9, function()
		setActive = var_2_10000

		var_2_10000(arg_91_0.countUI, false)

		local var_93_0 = arg_91_0

		var_0.gameStart(var_93_0)

		return
	end)

	findTF = var_1
	arg_91_0.leaveUI = var_1(arg_91_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_91_10 = arg_91_0

	findTF = var_4

	local var_91_11 = var_4(arg_91_0.leaveUI, "ad/btnOk")

	local function var_91_12()
		local var_94_0 = arg_91_0

		var_0.resumeGame(var_94_0)

		local var_94_1 = arg_91_0

		var_0.onGameOver(var_94_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_91_10, var_91_11, var_91_12, var_6)

	onButton = var_1

	local var_91_13 = arg_91_0

	findTF = var_91_11

	local var_91_14 = var_91_11(arg_91_0.leaveUI, "ad/btnCancel")

	local function var_91_15()
		local var_95_0 = arg_91_0

		var_0.resumeGame(var_95_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_91_13, var_91_14, var_91_15, var_6)

	findTF = var_1
	arg_91_0.pauseUI = var_1(arg_91_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_91_16 = arg_91_0

	findTF = var_4

	local var_91_17 = var_4(arg_91_0.pauseUI, "ad/btnOk")

	local function var_91_18()
		setActive = var_2_10000

		var_2_10000(arg_91_0.pauseUI, false)

		local var_96_0 = arg_91_0

		var_0.resumeGame(var_96_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_91_16, var_91_17, var_91_18, var_6)

	findTF = var_1
	arg_91_0.settlementUI = var_1(arg_91_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_91_19 = arg_91_0

	findTF = var_4

	local var_91_20 = var_4(arg_91_0.settlementUI, "ad/btnOver")

	local function var_91_21()
		setActive = var_2_10000

		var_2_10000(arg_91_0.settlementUI, false)

		local var_97_0 = arg_91_0

		var_0.openMenuUI(var_97_0)

		return
	end

	SFX_CANCEL = var_91_22

	var_1(var_91_19, var_91_20, var_91_21, var_91_22)

	findTF = var_1
	arg_91_0.selectedUI = var_1(arg_91_0._tf, "pop/selectedUI")
	arg_91_0.leftSelectRole = {}

	for iter_91_0 = 1, #var_0_51 do
		findTF = var_91_21
		var_91_21 = var_91_21(arg_91_0.selectedUI, "ad/leftRole/role" .. var_0_51[iter_91_0])
		setActive = var_91_22

		var_91_22(var_91_21, true)

		local var_91_22 = var_0_51[iter_91_0]

		onButton = var_7

		local var_91_23 = arg_91_0

		var_1_10010 = var_91_21

		local function var_91_24()
			local var_98_0 = arg_91_0

			var_0_47, var_0_48 = var_0.checkRoleId(var_98_0, var_91_22, var_0_48, var_0_52)

			local var_98_1 = arg_91_0

			var_0.updateSelectedUI(var_98_1)

			return
		end

		SFX_CONFIRM = var_1_10012

		var_7(var_91_23, var_1_10010, var_91_24, var_1_10012)

		table = var_7

		var_7.insert(arg_91_0.leftSelectRole, {
			id = var_91_22,
			tf = var_91_21
		})
	end

	onButton = var_1

	local var_91_25 = arg_91_0

	findTF = iter_91_0

	local var_91_26 = iter_91_0(arg_91_0.selectedUI, "close")

	local function var_91_27()
		setActive = var_2_10000

		var_2_10000(arg_91_0.selectedUI, false)

		return
	end

	SFX_CANCEL = var_91_28

	var_1(var_91_25, var_91_26, var_91_27, var_91_28)

	arg_91_0.rightSelectRole = {}

	for iter_91_1 = 1, #var_0_52 do
		findTF = var_91_27
		var_91_27 = var_91_27(arg_91_0.selectedUI, "ad/rightRole/role" .. var_0_52[iter_91_1])
		setActive = var_91_28

		var_91_28(var_91_27, true)

		local var_91_28 = var_0_52[iter_91_1]

		onButton = var_7

		local var_91_29 = arg_91_0

		var_1_10010 = var_91_27

		local function var_91_30()
			local var_100_0 = arg_91_0

			var_0_48, var_0_47 = var_0.checkRoleId(var_100_0, var_91_28, var_0_47, var_0_51)

			local var_100_1 = arg_91_0

			var_0.updateSelectedUI(var_100_1)

			return
		end

		SFX_CONFIRM = var_1_10012

		var_7(var_91_29, var_1_10010, var_91_30, var_1_10012)

		table = var_7

		var_7.insert(arg_91_0.rightSelectRole, {
			id = var_91_28,
			tf = var_91_27
		})
	end

	onButton = var_1

	local var_91_31 = arg_91_0

	findTF = iter_91_1

	local var_91_32 = iter_91_1(arg_91_0.selectedUI, "ad/btnOk")

	local function var_91_33()
		setActive = var_2_10000

		var_2_10000(arg_91_0.selectedUI, false)

		setActive = var_2_10000

		var_2_10000(arg_91_0.menuUI, false)

		local var_101_0 = arg_91_0

		var_0.readyStart(var_101_0)

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_91_31, var_91_32, var_91_33, var_6)

	findTF = var_1
	arg_91_0.btnDay = var_1(arg_91_0.selectedUI, "ad/btnDay")
	findTF = var_1
	arg_91_0.btnNight = var_1(arg_91_0.selectedUI, "ad/btnNight")

	local var_91_34

	if not arg_91_0:getGameUsedTimes() then
		var_91_34 = 0
	end

	local var_91_35

	if not var_0_54[var_91_34 + 1] or not var_0_54[var_91_34 + 1] then
		var_91_35 = var_0_70
	end

	var_0_71 = var_91_35
	setActive = var_91_35
	findTF = var_4

	var_91_35(var_4(arg_91_0.btnDay, "on"), var_0_71 == var_0_69)

	setActive = var_91_35
	findTF = var_4

	var_91_35(var_4(arg_91_0.btnNight, "on"), var_0_71 == var_0_70)

	onButton = var_91_35

	local var_91_36 = arg_91_0
	local var_91_37 = arg_91_0.btnDay

	local function var_91_38()
		var_0_71 = var_0_69
		setActive = var_0
		findTF = var_2_10002

		var_0(var_2_10002(arg_91_0.btnDay, "on"), true)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_91_0.btnNight, "on"), false)

		local var_102_0 = arg_91_0

		var_0.updateMenuUI(var_102_0)

		return
	end

	SFX_CONFIRM = var_7

	var_91_35(var_91_36, var_91_37, var_91_38, var_7)

	onButton = var_91_35

	local var_91_39 = arg_91_0
	local var_91_40 = arg_91_0.btnNight

	local function var_91_41()
		var_0_71 = var_0_70
		setActive = var_0
		findTF = var_2_10002

		var_0(var_2_10002(arg_91_0.btnDay, "on"), false)

		setActive = var_0
		findTF = var_2

		var_0(var_2(arg_91_0.btnNight, "on"), true)

		local var_103_0 = arg_91_0

		var_0.updateMenuUI(var_103_0)

		return
	end

	SFX_CONFIRM = var_7

	var_91_35(var_91_39, var_91_40, var_91_41, var_7)

	setActive = var_91_35

	var_91_35(arg_91_0.selectedUI, false)

	findTF = var_91_35
	arg_91_0.menuUI = var_91_35(arg_91_0._tf, "pop/menuUI")
	GetComponent = var_2
	findTF = var_4

	local var_91_42 = var_4(arg_91_0.menuUI, "battList")

	typeof = var_5
	ScrollRect = var_7
	arg_91_0.battleScrollRect = var_2(var_91_42, var_5(var_7))
	arg_91_0.totalTimes = arg_91_0:getGameTotalTime()

	local var_91_43 = arg_91_0:getGameUsedTimes() - 4 < 0 and 0 or arg_91_0:getGameUsedTimes() - 4

	scrollTo = var_3

	var_3(arg_91_0.battleScrollRect, 0, 1 - var_91_43 / (arg_91_0.totalTimes - 4))

	onButton = var_3

	local var_91_44 = arg_91_0

	findTF = var_6

	local var_91_45 = var_6(arg_91_0.menuUI, "rightPanelBg/arrowUp")

	local function var_91_46()
		local var_104_0 = arg_91_0.battleScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4)

		if 1 < var_104_0 then
			var_104_0 = 1
		end

		scrollTo = var_1

		var_1(arg_91_0.battleScrollRect, 0, var_104_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_91_44, var_91_45, var_91_46, var_8)

	onButton = var_3

	local var_91_47 = arg_91_0

	findTF = var_91_45

	local var_91_48 = var_91_45(arg_91_0.menuUI, "rightPanelBg/arrowDown")

	local function var_91_49()
		local var_105_0

		if arg_91_0.battleScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4) < 0 then
			var_105_0 = 0
		end

		scrollTo = var_1

		var_1(arg_91_0.battleScrollRect, 0, var_105_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_91_47, var_91_48, var_91_49, var_8)

	onButton = var_3

	local var_91_50 = arg_91_0

	findTF = var_91_48

	local var_91_51 = var_91_48(arg_91_0.menuUI, "btnBack")

	local function var_91_52()
		local var_106_0 = arg_91_0

		var_0.closeView(var_106_0)

		return
	end

	SFX_CANCEL = var_8

	var_3(var_91_50, var_91_51, var_91_52, var_8)

	onButton = var_3

	local var_91_53 = arg_91_0

	findTF = var_91_51

	local var_91_54 = var_91_51(arg_91_0.menuUI, "btnRule")

	local function var_91_55()
		pg = var_2_10000

		local var_107_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_107_1 = var_0.ShowMsgBox
		local var_107_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_107_2.type = var_2_10004
		pg = var_2_10004
		var_107_2.helps = var_2_10004.gametip.ssss_game_tip.tip

		var_107_1(var_107_0, var_107_2)

		return
	end

	SFX_CONFIRM = var_8

	var_3(var_91_53, var_91_54, var_91_55, var_8)

	onButton = var_3

	local var_91_56 = arg_91_0

	findTF = var_91_54

	local var_91_57 = var_91_54(arg_91_0.menuUI, "btnStart")

	local function var_91_58()
		local var_108_0 = arg_91_0
		local var_108_1

		if not var_0.getGameUsedTimes(var_108_0) then
			var_108_1 = 0
		end

		local var_108_2 = arg_91_0
		local var_108_3

		if not var_1.getGameTimes(var_108_2) then
			var_108_3 = 0
		end

		if var_108_1 >= var_0_56 and arg_91_0.selectedUI then
			local var_108_4 = arg_91_0

			var_2.updateSelectedUI(var_108_4)

			setActive = var_2

			var_2(arg_91_0.selectedUI, true)
		else
			local var_108_5
			local var_108_6 = var_108_1 == 0 and 1 or var_108_3 > 0 and var_108_1 + 1 or var_108_1
			local var_108_7

			if not var_0_54[var_108_1 + 1] or not var_0_54[var_108_1 + 1] then
				var_108_7 = 1
			end

			var_0_71 = var_108_7

			if var_108_6 > #var_0_53 then
				var_108_6 = #var_0_53
			end

			var_0_47 = var_0_53[var_108_6][1]
			var_0_48 = var_3[2]
			setActive = var_4

			var_4(arg_91_0.menuUI, false)

			local var_108_8 = arg_91_0

			var_4.readyStart(var_108_8)
		end

		return
	end

	SFX_CONFIRM = var_91_60

	var_3(var_91_56, var_91_57, var_91_58, var_91_60)

	findTF = var_3

	local var_91_59 = var_3(arg_91_0.menuUI, "tplBattleItem")

	arg_91_0.battleItems = {}
	arg_91_0.dropItems = {}

	for iter_91_2 = 1, 7 do
		tf = var_91_60
		instantiate = var_1_10010

		local var_91_60 = var_91_60(var_1_10010(var_91_59))

		var_91_60.name = "battleItem_" .. iter_91_2
		setParent = var_9

		local var_91_61 = var_91_60

		findTF = var_12

		var_9(var_91_61, var_12(arg_91_0.menuUI, "battList/Viewport/Content"))

		local var_91_62 = iter_91_2

		GetSpriteFromAtlasAsync = var_1_10010

		var_1_10010(var_0_7, "battleDesc" .. var_91_62, function(arg_109_0)
			setImageSprite = var_2_10001
			findTF = var_2_10003

			var_2_10001(var_2_10003(var_91_60, "state_open/buttomDesc"), arg_109_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_91_60, "state_clear/buttomDesc"), arg_109_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_91_60, "state_current/buttomDesc"), arg_109_0, true)

			setImageSprite = var_2_10001
			findTF = var_3

			var_2_10001(var_3(var_91_60, "state_closed/buttomDesc"), arg_109_0, true)

			return
		end)

		setActive = var_1_10010

		var_1_10010(var_91_60, true)

		table = var_1_10010

		var_1_10010.insert(arg_91_0.battleItems, var_91_60)
	end

	if not arg_91_0.handle then
		UpdateBeat = var_4
		arg_91_0.handle = var_4:CreateListener(arg_91_0.Update, arg_91_0)
	end

	UpdateBeat = var_4

	var_4:AddListener(arg_91_0.handle)

	return
end

function var_0_1.checkRoleId(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	local var_110_0 = arg_110_0:matchRoleId(arg_110_1, arg_110_2)
	local var_110_1 = arg_110_2

	if not var_110_0 then
		for iter_110_0 = 1, #arg_110_3 do
			local var_110_2 = arg_110_3[iter_110_0]

			if arg_110_0:matchRoleId(arg_110_1, var_110_2) then
				return arg_110_1, var_110_2
			end
		end
	end

	return arg_110_1, arg_110_2
end

function var_0_1.matchRoleId(arg_111_0, arg_111_1, arg_111_2)
	if arg_111_1 == arg_111_2 then
		return false
	end

	for iter_111_0 = 1, #var_0_50 do
		local var_111_0 = var_0_50[iter_111_0]

		table = var_1_10008

		if var_1_10008.contains(var_111_0, arg_111_1) then
			table = var_1_10008

			if var_1_10008.contains(var_111_0, arg_111_2) then
				return false
			end
		end
	end

	return true
end

function var_0_1.initGameUI(arg_112_0)
	findTF = var_1_10001
	arg_112_0.gameUI = var_1_10001(arg_112_0._tf, "ui/gameUI")
	onButton = var_1

	local var_112_0 = arg_112_0

	findTF = var_4

	var_1(var_112_0, var_4(arg_112_0.gameUI, "topRight/btnStop"), function()
		local var_113_0 = arg_112_0

		var_0.stopGame(var_113_0)

		setActive = var_0

		var_0(arg_112_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_112_1 = arg_112_0

	findTF = var_4

	var_1(var_112_1, var_4(arg_112_0.gameUI, "btnLeave"), function()
		local var_114_0 = arg_112_0

		var_0.stopGame(var_114_0)

		setActive = var_0

		var_0(arg_112_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_112_0.gameTimeS = var_1(arg_112_0.gameUI, "top/time/s")
	findTF = var_1
	arg_112_0.scoreTf = var_1(arg_112_0.gameUI, "top/score")
	findTF = var_1
	arg_112_0.scoreAnimTf = var_1(arg_112_0._tf, "sceneContainer/scene_front/scoreAnim")
	findTF = var_1
	arg_112_0.scoreAnimTextTf = var_1(arg_112_0._tf, "sceneContainer/scene_front/scoreAnim/text")
	setActive = var_1

	var_1(arg_112_0.scoreAnimTf, false)

	return
end

function var_0_1.initController(arg_115_0)
	findTF = var_1_10001

	local var_115_0 = var_1_10001(arg_115_0.gameUI, "box")

	arg_115_0.boxController = var_0_194(var_115_0, arg_115_0)
	findTF = var_2

	local var_115_1 = var_2(arg_115_0.gameUI, "specialPower")

	findTF = var_3

	local var_115_2 = var_3(arg_115_0.gameUI, "successPower")

	arg_115_0.specialController = var_0_196(var_115_1, var_115_2, arg_115_0)
	findTF = var_4

	local var_115_3 = var_4(arg_115_0._tf, "sceneContainer")

	arg_115_0.bgController = var_0_197(var_115_3, arg_115_0.gameUI, arg_115_0)
	findTF = var_5

	local var_115_4 = var_5(arg_115_0._tf, "sceneContainer/scene")

	arg_115_0.roleController = var_0_198(var_115_4, arg_115_0)

	return
end

function var_0_1.Update(arg_116_0)
	arg_116_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_117_0)
	if arg_117_0.gameStop or arg_117_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateSelectedUI(arg_118_0)
	for iter_118_0 = 1, #arg_118_0.leftSelectRole do
		local var_118_0 = arg_118_0.leftSelectRole[iter_118_0]

		if var_0_47 == var_118_0.id then
			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_118_0.tf, "selected"), true)

			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_118_0.tf, "unSelected"), false)
		else
			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_118_0.tf, "selected"), false)

			setActive = var_1_10006
			findTF = var_1_10008

			var_1_10006(var_1_10008(var_118_0.tf, "unSelected"), true)
		end
	end

	for iter_118_1 = 1, #arg_118_0.rightSelectRole do
		local var_118_1 = arg_118_0.rightSelectRole[iter_118_1]

		setGray = var_1_10006

		var_1_10006(var_118_1.tf, not arg_118_0:matchRoleId(var_0_47, var_118_1.id), true)

		if var_0_48 == var_118_1.id then
			setActive = var_1_10006
			findTF = var_8

			var_1_10006(var_8(var_118_1.tf, "selected"), true)

			setActive = var_1_10006
			findTF = var_8

			var_1_10006(var_8(var_118_1.tf, "unSelected"), false)
		else
			setActive = var_1_10006
			findTF = var_8

			var_1_10006(var_8(var_118_1.tf, "selected"), false)

			setActive = var_1_10006
			findTF = var_8

			var_1_10006(var_8(var_118_1.tf, "unSelected"), true)
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_119_0)
	if arg_119_0:getGameUsedTimes() and 7 <= var_1 then
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_119_0.menuUI, "btnStart/free"), true)
	else
		setActive = var_1_10002
		findTF = var_1_10004

		var_1_10002(var_1_10004(arg_119_0.menuUI, "btnStart/free"), false)
	end

	local var_119_0 = arg_119_0:getGameTimes()

	for iter_119_0 = 1, #arg_119_0.battleItems do
		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_open"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_closed"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_clear"), false)

		setActive = var_1_10007
		findTF = var_1_10009

		var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_current"), false)

		if iter_119_0 <= var_1 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_clear"), true)
		elseif iter_119_0 == var_1 + 1 and 1 <= var_119_0 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_current"), true)
		elseif var_1 < iter_119_0 and iter_119_0 <= var_1 + var_119_0 then
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_open"), true)
		else
			setActive = var_1_10007
			findTF = var_1_10009

			var_1_10007(var_1_10009(arg_119_0.battleItems[iter_119_0], "state_closed"), true)
		end
	end

	arg_119_0.totalTimes = arg_119_0:getGameTotalTime()

	local var_119_1 = 1 - (arg_119_0:getGameUsedTimes() - 3 < 0 and 0 or arg_119_0:getGameUsedTimes() - 3) / (arg_119_0.totalTimes - 4)

	if 1 < var_119_1 then
		var_119_1 = 1
	end

	scrollTo = var_5

	var_5(arg_119_0.battleScrollRect, 0, var_119_1)

	setActive = var_5
	findTF = var_7

	var_5(var_7(arg_119_0.menuUI, "btnStart/tip"), var_119_0 > 0)

	local var_119_2

	if var_0_71 == var_0_69 then
		var_119_2 = var_0_66
	elseif var_0_71 == var_0_70 then
		var_119_2 = var_0_67
	end

	ipairs = var_6

	for iter_119_1, iter_119_2 in var_6(var_0_65) do
		findTF = var_1_10011
		var_1_10011 = var_1_10011(arg_119_0._tf, "bg/" .. iter_119_2)
		setActive = var_1_10012

		local var_119_3 = var_1_10011

		table = var_15

		var_1_10012(var_119_3, var_15.contains(var_119_2, iter_119_2))
	end

	setActive = var_6
	findTF = var_8

	var_6(var_8(arg_119_0.menuUI, "bg/title_day"), var_0_71 == var_0_69)

	setActive = var_6
	findTF = var_8

	var_6(var_8(arg_119_0.menuUI, "bg/title_night"), var_0_71 ~= var_0_69)
	arg_119_0:CheckGet()

	return
end

function var_0_1.CheckGet(arg_120_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_120_0.menuUI, "got"), false)

	if arg_120_0:getUltimate() then
		local var_120_0 = arg_120_0

		if arg_120_0.getUltimate(var_120_0) ~= 0 then
			setActive = var_1
			findTF = var_120_0

			var_1(var_120_0(arg_120_0.menuUI, "got"), true)
		end
	end

	if arg_120_0:getUltimate() == 0 then
		local var_120_1 = arg_120_0

		if arg_120_0.getGameTotalTime(var_120_1) > arg_120_0:getGameUsedTimes() then
			return
		end

		pg = var_120_1

		local var_120_2 = var_120_1.m02
		local var_120_3 = var_3.sendNotification

		GAME = var_6

		local var_120_4 = var_6.SEND_MINI_GAME_OP
		local var_120_5 = {
			hubid = arg_120_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_120_5.cmd = var_8.CMD_ULTIMATE
		var_120_5.args1 = {}

		var_120_3(var_120_2, var_120_4, var_120_5)

		setActive = var_120_3
		findTF = var_120_2

		var_120_3(var_120_2(arg_120_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_121_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_121_0._tf, "sceneContainer/scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_121_0._tf, "sceneContainer/scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_121_0._tf, "sceneContainer/scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_121_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_121_0.menuUI, true)

	setActive = var_1_10001

	var_1_10001(arg_121_0.selectedUI, false)
	arg_121_0:updateMenuUI()

	local var_121_1

	if not arg_121_0:getBGM() then
		pg = var_1_10002

		local var_121_0 = var_1_10002.CriMgr.GetInstance()

		if var_2.IsDefaultBGM(var_121_0) then
			pg = var_2
			var_121_1 = var_2.voice_bgm.NewMainScene.default_bgm
		else
			pg = var_2
			var_121_1 = var_2.voice_bgm.NewMainScene.bgm
		end
	end

	if arg_121_0.bgm ~= var_121_1 then
		arg_121_0.bgm = var_121_1
		pg = var_2

		local var_121_2 = var_2.BgmMgr.GetInstance()

		var_2.Push(var_121_2, arg_121_0.__cname, var_121_1)
	end

	return
end

function var_0_1.clearUI(arg_122_0)
	setActive = var_1_10001

	var_1_10001(arg_122_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_122_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_122_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_122_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_122_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_122_0.selectedUI, false)

	return
end

function var_0_1.readyStart(arg_123_0)
	setActive = var_1_10001

	var_1_10001(arg_123_0.countUI, true)

	local var_123_0 = arg_123_0.countAnimator

	var_1.Play(var_123_0, "count")

	pg = var_1

	local var_123_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_123_1, var_0_4)

	if var_0_3 and arg_123_0.bgm ~= var_0_3 then
		arg_123_0.bgm = var_0_3
		pg = var_1

		local var_123_2 = var_1.BgmMgr.GetInstance()

		var_1.Push(var_123_2, arg_123_0.__cname, var_0_3)
	end

	return
end

function var_0_1.gameStart(arg_124_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_124_0._tf, "sceneContainer/scene_front"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_124_0._tf, "sceneContainer/scene_background"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_124_0._tf, "sceneContainer/scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_124_0.scoreAnimTf, false)

	setActive = var_1_10001

	var_1_10001(arg_124_0.gameUI, true)

	arg_124_0.gameStartFlag = true
	arg_124_0.scoreNum = 0
	arg_124_0.playerPosIndex = 2
	arg_124_0.gameStepTime = 0
	arg_124_0.gameTime = var_0_8
	arg_124_0.ignoreTime = false

	local var_124_0 = arg_124_0.boxController

	var_1.start(var_124_0)

	local var_124_1 = arg_124_0.specialController

	var_1.start(var_124_1)

	local var_124_2 = arg_124_0.bgController

	var_1.start(var_124_2)

	local var_124_3 = arg_124_0.roleController

	var_1.start(var_124_3)
	arg_124_0:updateGameUI()
	arg_124_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_125_0)
	return arg_125_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_126_0)
	return arg_126_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_127_0)
	return arg_127_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_128_0)
	local var_128_0 = arg_128_0:GetMGHubData()

	return (var_1.getConfig(var_128_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_129_0, arg_129_1)
	return
end

function var_0_1.onTimer(arg_130_0)
	arg_130_0:gameStep()

	return
end

function var_0_1.gameStep(arg_131_0)
	if not arg_131_0.ignoreTime then
		local var_131_0 = arg_131_0.gameTime

		Time = var_1_10002
		arg_131_0.gameTime = var_131_0 - var_1_10002.deltaTime

		if arg_131_0.gameTime < 0 then
			arg_131_0.gameTime = 0
		end

		local var_131_1 = arg_131_0.gameStepTime

		Time = var_2
		arg_131_0.gameStepTime = var_131_1 + var_2.deltaTime
	end

	local var_131_2 = arg_131_0.boxController

	var_1.step(var_131_2)

	local var_131_3 = arg_131_0.specialController

	var_1.step(var_131_3)

	local var_131_4 = arg_131_0.bgController

	var_1.step(var_131_4)

	local var_131_5 = arg_131_0.roleController

	var_1.step(var_131_5)
	arg_131_0:updateGameUI()

	if arg_131_0.gameTime <= 0 then
		arg_131_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_132_0)
	if not arg_132_0.timer.running then
		local var_132_0 = arg_132_0.timer

		var_1.Start(var_132_0)
	end

	return
end

function var_0_1.timerStop(arg_133_0)
	if arg_133_0.timer.running then
		local var_133_0 = arg_133_0.timer

		var_1.Stop(var_133_0)
	end

	return
end

function var_0_1.updateGameUI(arg_134_0)
	setText = var_1_10001

	var_1_10001(arg_134_0.scoreTf, arg_134_0.scoreNum)

	setText = var_1_10001

	local var_134_0 = arg_134_0.gameTimeS

	math = var_4

	var_1_10001(var_134_0, var_4.ceil(arg_134_0.gameTime))

	return
end

function var_0_1.addScore(arg_135_0, arg_135_1)
	setActive = var_1_10002

	var_1_10002(arg_135_0.scoreAnimTf, false)

	setActive = var_1_10002

	var_1_10002(arg_135_0.scoreAnimTf, true)

	setText = var_1_10002

	local var_135_0 = arg_135_0.scoreAnimTextTf
	local var_135_1 = "+"

	tostring = var_1_10006

	var_1_10002(var_135_0, var_135_1 .. var_1_10006(arg_135_1))

	arg_135_0.scoreNum = arg_135_0.scoreNum + arg_135_1

	if arg_135_0.scoreNum < 0 then
		arg_135_0.scoreNum = 0
	end

	return
end

function var_0_1.onGameOver(arg_136_0)
	if arg_136_0.settlementFlag then
		return
	end

	arg_136_0:timerStop()

	arg_136_0.settlementFlag = true
	setActive = var_1

	var_1(arg_136_0.clickMask, true)

	local var_136_0

	if arg_136_0.roleController then
		var_136_0 = arg_136_0.roleController

		var_1.clear(var_136_0)
	end

	if arg_136_0.bgController then
		var_136_0 = arg_136_0.bgController

		var_1.clear(var_136_0)
	end

	LeanTween = var_1

	local var_136_1 = var_1.delayedCall

	go = var_136_0

	local var_136_2 = var_136_0(arg_136_0._tf)
	local var_136_3 = 0.1

	System = var_5

	var_136_1(var_136_2, var_136_3, var_5.Action(function()
		arg_136_0.settlementFlag = false

		local var_137_0 = arg_136_0

		var_137_0.gameStartFlag = false
		setActive = var_137_0

		var_137_0(arg_136_0.clickMask, false)

		local var_137_1 = arg_136_0

		var_0.showSettlement(var_137_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_138_0)
	setActive = var_1_10001

	var_1_10001(arg_138_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_138_0 = var_3(arg_138_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_138_1 = var_1_10001(var_138_0, var_4(var_6))

	var_1.Play(var_138_1, "settlement", -1, 0)

	local var_138_2 = arg_138_0:GetMGData()
	local var_138_3 = var_2.GetRuntimeData(var_138_2, "elements")
	local var_138_4 = arg_138_0.scoreNum

	if var_138_3 then
		local var_138_5 = #var_138_3
		local var_138_6

		if not (0 < var_138_5) or not var_138_3[1] then
			var_138_6 = 0
		end

		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_138_0.settlementUI, "ad/new"), var_138_6 < var_138_4)

		if var_138_6 <= var_138_4 then
			var_138_6 = var_138_4

			arg_138_0:StoreDataToServer({
				var_138_6
			})
		end

		findTF = var_5

		local var_138_7 = var_5(arg_138_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_138_8 = var_6(arg_138_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_138_7, var_138_6)

		setText = var_7

		var_7(var_138_8, var_138_4)

		if arg_138_0:getGameTimes() and arg_138_0:getGameTimes() > 0 then
			arg_138_0.sendSuccessFlag = true

			arg_138_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.resumeGame(arg_139_0)
	arg_139_0.gameStop = false
	setActive = var_1

	var_1(arg_139_0.leaveUI, false)
	arg_139_0:changeSpeed(1)
	arg_139_0:timerStart()

	return
end

function var_0_1.stopGame(arg_140_0)
	arg_140_0.gameStop = true

	arg_140_0:timerStop()
	arg_140_0:changeSpeed(0)

	return
end

function var_0_1.onBackPressed(arg_141_0)
	if not arg_141_0.gameStartFlag then
		arg_141_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_141_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_141_0.pauseUI) then
			setActive = var_1

			var_1(arg_141_0.pauseUI, false)
		end

		arg_141_0:stopGame()

		setActive = var_1

		var_1(arg_141_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_142_0)
	if arg_142_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_142_0.handle)
	end

	if arg_142_0._tf then
		LeanTween = var_1

		local var_142_0 = var_1.isTweening

		go = var_1_10003

		if var_142_0(var_1_10003(arg_142_0._tf)) then
			LeanTween = var_1

			local var_142_1 = var_1.cancel

			go = var_3

			var_142_1(var_3(arg_142_0._tf))
		end
	end

	if arg_142_0.timer and arg_142_0.timer.running then
		local var_142_2 = arg_142_0.timer

		var_1.Stop(var_142_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_142_0.timer = nil

	return
end

return var_0_1
