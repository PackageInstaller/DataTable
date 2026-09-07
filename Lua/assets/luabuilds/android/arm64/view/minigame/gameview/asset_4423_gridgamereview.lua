local GridGameReView = class("GridGameReView", import("..BaseMiniGameView"))
local var_0_1 = false
local var_0_2 = "battle-boss-4"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_6 = "ui/minigameui/gridgameui_atlas"
local var_0_7 = 60
local var_0_14 = "event grid combo"
local var_0_15 = "event grid trigger"
local var_0_16 = "event move role"
local var_0_17 = "event add score"
local var_0_18 = "event role special"
local var_0_19 = "event special end"
local var_0_20 = "event camera in"
local var_0_21 = "event camedra out"
local var_0_22 = "event ignore time"
local var_0_23 = {
	power_grid = 0,
	grid_index = 0,
	special_time = false,
	special_complete = false
}
local var_0_24 = 12
local var_0_25 = 0.3
local var_0_26 = Vector2(138, 150)
local var_0_27 = 2500
local var_0_28 = 0
local var_0_29 = 100
local var_0_30 = 1
local var_0_31 = 2
local var_0_32 = 3
local var_0_33 = {
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
local var_0_34 = {
	1,
	2,
	3
}
local var_0_35 = {}
local var_0_36 = {}

var_0_36.rule = 1
var_0_35[1] = var_0_36
var_0_35[2] = {
	id = 999,
	rule = 2
}
var_0_35[3] = {
	rule = 3
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
local var_0_56 = 7
local var_0_57 = Vector2(0, 0)
local var_0_58 = 0.07
local var_0_59 = 0.3
local var_0_60 = 0.5
local var_0_61 = 5
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
local var_0_71 = 1
local var_0_72 = {}
local var_0_73 = {
	rate = 0.05,
	source = "scene_background/bg00"
}

var_0_73.type = 1
var_0_72[1] = var_0_73
var_0_72[2] = {
	rate = 0.1,
	source = "scene_background/bg01",
	type = 1
}
var_0_72[3] = {
	rate = 0.2,
	source = "scene_background/bg02",
	type = 1
}
var_0_72[4] = {
	rate = 0.8,
	source = "scene_background/bg03",
	type = 1
}
var_0_72[5] = {
	rate = 0.05,
	source = "scene_background/bg10",
	type = 2
}
var_0_72[6] = {
	rate = 0.1,
	source = "scene_background/bg11",
	type = 2
}
var_0_72[7] = {
	rate = 0.2,
	source = "scene_background/bg12",
	type = 2
}
var_0_72[8] = {
	rate = 0.8,
	source = "scene_background/bg13",
	type = 2
}
var_0_72[9] = {
	rate = 1.2,
	source = "scene_front/bg04",
	type = 1
}
var_0_72[10] = {
	rate = 1.2,
	source = "scene_front/bg14",
	type = 2
}
var_0_72[11] = {
	rate = 1,
	source = "scene/rolePos",
	type = 0
}

local var_0_74 = {
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
local var_0_75 = {
	n_Move_R = {
		time = 0,
		anim_name = var_0_74.n_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_74.n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = var_0_74.n_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_74.n_Skill_1
	},
	n_Skill_2 = {
		sound_trigger = "guangjian",
		time = 0,
		anim_name = var_0_74.n_Skill_2,
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
		anim_name = var_0_74.n_Skill_3
	},
	n_Combine = {
		camera = true,
		sound_start = "bianshen",
		time = 0,
		anim_name = var_0_74.n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = var_0_74.n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = var_0_74.n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = var_0_74.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = var_0_74.n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_74.c_Atk,
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
		anim_name = var_0_74.c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = var_0_74.c_Dmg,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = var_0_74.c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = var_0_74.c_MoveL,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = var_0_74.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = var_0_74.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = var_0_74.c_Neutral
	}
}
local var_0_76 = {
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
local var_0_77 = {
	n_Move_R = {
		time = 0,
		anim_name = var_0_76.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(500, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_76.n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = var_0_76.n_MoveL,
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
		anim_name = var_0_76.n_Skill_1,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0)
		}
	},
	n_Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_76.n_Skill_2
	},
	n_Skill_3 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_76.n_Skill_3,
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
		anim_name = var_0_76.n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = var_0_76.n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = var_0_76.n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = var_0_76.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = var_0_76.n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_76.c_Atk,
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
		anim_name = var_0_76.c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = var_0_76.c_Dmg,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = var_0_76.c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = var_0_76.c_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = var_0_76.c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = var_0_76.c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = var_0_76.c_Neutral
	}
}
local var_0_78 = {
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
local var_0_79 = {
	n_Move_R = {
		time = 0,
		anim_name = var_0_78.n_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_78.n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = var_0_78.n_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_78.n_Skill_1
	},
	n_Skill_2 = {
		sound_trigger = "guangjian",
		time = 0,
		anim_name = var_0_78.n_Skill_2,
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
		anim_name = var_0_78.n_Skill_3
	},
	n_Combine = {
		sound_start = "bianshen",
		time = 0,
		camera = true,
		anim_name = var_0_78.n_Combine,
		camera_pos = Vector2(0, 0)
	},
	n_DMG = {
		time = 0,
		anim_name = var_0_78.n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = var_0_78.n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = var_0_78.n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = var_0_78.n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = var_0_78.c_Atk,
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
		anim_name = var_0_78.c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = var_0_78.c_Dmg,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = var_0_78.c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = var_0_78.c_MoveL,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = var_0_78.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = var_0_78.c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = var_0_78.c_Neutral
	}
}
local var_0_80 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_81 = {
	Move_R = {
		time = 0,
		anim_name = var_0_80.MoveR,
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
		anim_name = var_0_80.Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Move_L = {
		time = 0,
		anim_name = var_0_80.MoveL,
		move = {
			time = 0.4,
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_80.Skill_1
	},
	Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_80.Skill_2,
		over_offset = Vector2(115, 0)
	},
	DMG = {
		time = 0,
		anim_name = var_0_80.DMG,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_Back_R = {
		time = 0,
		anim_name = var_0_80.MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_S = {
		time = 0,
		anim_name = var_0_80.DMG
	},
	Neutral = {
		time = 0,
		anim_name = var_0_80.Neutral
	}
}
local var_0_82 = {
	Neutral = "Neutral",
	MoveL = "MoveL",
	Skill_2 = "skill_2",
	Atk = "ATK",
	Skill_1 = "skill_1",
	DMG = "DMG",
	MoveR = "MoveR"
}
local var_0_83 = {
	Move_R = {
		time = 0,
		anim_name = var_0_82.MoveR,
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
		anim_name = var_0_82.Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Move_L = {
		time = 0,
		anim_name = var_0_82.MoveL,
		move = {
			time = 0.4,
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = var_0_82.Skill_1
	},
	Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = var_0_82.Skill_2,
		over_offset = Vector2(264, 0)
	},
	DMG = {
		time = 0,
		anim_name = var_0_82.DMG,
		move = {
			time = 0.3,
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_Back_R = {
		time = 0,
		anim_name = var_0_82.MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_S = {
		time = 0,
		anim_name = var_0_82.DMG
	},
	Neutral = {
		time = 0,
		anim_name = var_0_82.Neutral
	}
}
local var_0_84 = {
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
					var_0_75.n_Atk,
					var_0_75.n_Move_L
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
					var_0_75.n_Skill_1
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
					var_0_75.n_Skill_2,
					var_0_75.n_Move_L
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
					var_0_75.n_Skill_3
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
					var_0_75.n_DMG,
					var_0_75.n_DMG_Back_R
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
					var_0_75.n_DMG_S
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
					var_0_75.n_DMG_Back_R
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_75.n_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_75.n_DMG_Back_R
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
					var_0_75.n_Combine
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
					var_0_75.c_Atk,
					var_0_75.c_MoveL
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
					var_0_75.c_Skill_1
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
					var_0_75.c_Skill_1
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
					var_0_75.c_Skill_1
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
					var_0_75.c_Dmg,
					var_0_75.c_DMG_Back_R
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
					var_0_75.c_Dmg_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_75.c_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_75.c_DMG_Back_R
				}
			}
		},
		actions = var_0_75
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
					var_0_77.n_Atk,
					var_0_77.n_Move_L
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
					var_0_77.n_Move_R,
					var_0_77.n_Skill_1,
					var_0_77.n_Move_L
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
					var_0_77.n_Skill_2
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
					var_0_77.n_Skill_3,
					var_0_77.n_Move_L
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
					var_0_77.n_DMG,
					var_0_77.n_DMG_Back_R
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
					var_0_77.n_DMG_S
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
					var_0_77.n_DMG_Back_R
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_77.n_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_77.n_DMG_Back_R
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
					var_0_77.n_Combine
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
					var_0_77.c_Atk,
					var_0_77.c_MoveL
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
					var_0_77.c_Skill_1
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
					var_0_77.c_Skill_1
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
					var_0_77.c_Skill_1
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
					var_0_77.c_Dmg,
					var_0_77.c_DMG_Back_R
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
					var_0_77.c_Dmg_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_77.c_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_77.c_DMG_Back_R
				}
			}
		},
		actions = var_0_77
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
					var_0_81.Atk,
					var_0_81.Move_L
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
					var_0_81.Skill_1
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
					var_0_81.Move_R,
					var_0_81.Skill_2,
					var_0_81.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_81.DMG,
					var_0_81.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_81.DMG_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_81.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_81.DMG_Back_R
				}
			}
		},
		actions = var_0_81
	},
	{
		index = 4,
		name = "enemy2",
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
					var_0_83.Atk,
					var_0_83.Move_L
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
					var_0_83.Skill_1
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
					var_0_83.Skill_2,
					var_0_83.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_83.DMG,
					var_0_83.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_83.DMG_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_83.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_83.DMG_Back_R
				}
			}
		},
		actions = var_0_83
	},
	{
		name = "role3",
		index = 5,
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
					var_0_79.n_Atk,
					var_0_79.n_Move_L
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
					var_0_79.n_Skill_1
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
					var_0_79.n_Skill_2,
					var_0_79.n_Move_L
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
					var_0_79.n_Skill_3
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
					var_0_79.n_DMG,
					var_0_79.n_DMG_Back_R
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
					var_0_79.n_DMG_S
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
					var_0_79.n_DMG_Back_R
				},
				anim_init_pos = Vector2(586, 471)
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_79.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_79.DMG_Back_R
				}
			},
			{
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
					var_0_79.n_Combine
				},
				anim_trigger_pos = Vector2(-58, 350),
				anim_end_pos = Vector2(225, 471)
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
					var_0_79.c_Atk,
					var_0_79.c_MoveL
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
					var_0_79.c_Skill_1
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
					var_0_79.c_Skill_1
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
					var_0_79.c_Skill_1
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
					var_0_79.c_Dmg,
					var_0_79.c_DMG_Back_R
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
					var_0_79.c_Dmg_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_79.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_79.DMG_Back_R
				}
			}
		},
		actions = var_0_79,
		anim_init_pos = Vector2(586, 411)
	}
}

local function var_0_85(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(self)
			self._boxTf = arg_1_0
			self._event = arg_1_1

			self._event:bind(var_0_15, function()
				if var_0_23.power_grid and var_0_23.power_grid > 0 and var_0_35[var_0_23.power_grid] then
					local var_3_0 = var_0_35[var_0_23.power_grid].rule

					table.insert(self.ruleGridList, {
						id = (var_0_35[var_0_23.power_grid].id or nil) and (var_0_35[var_0_23.power_grid].id or var_0_23.power_grid),
						rule = var_3_0
					})
				end

				return
			end)

			self._gridEffect = findTF(self._boxTf, "effectGrid")
			self._content = findTF(self._boxTf, "viewport/content")
			self.tplGrid = findTF(arg_1_0, "tplGrid")

			setActive(self.tplGrid, false)

			self.grids = {}
			self.effects = {}
			self.combo = 0
			self.ruleGridList = {}

			for iter_2_0 = 1, var_0_24 do
				local var_2_0 = tf(instantiate(self._gridEffect))

				setParent(var_2_0, self._content)
				setActive(var_2_0, false)

				var_2_0.anchoredPosition = Vector2(var_0_26.x * iter_2_0 - var_0_26.x / 2, var_0_26.y / 2)

				table.insert(self.effects, var_2_0)
			end

			return
		end,
		start = function(self)
			self.comboCheck = false

			self:initGrids(false)

			for iter_4_0 = 1, #self.effects do
				setActive(self.effects[iter_4_0], false)
			end

			return
		end,
		step = function(self)
			if self.takeAwayTime and self.takeAwayTime > 0 then
				self.takeAwayTime = self.takeAwayTime - Time.deltaTime

				return
			end

			self.gridCreateIndex = 1

			local var_5_0 = false

			for iter_5_0 = 1, #self.grids do
				local var_5_1 = iter_5_0

				if not self.grids[iter_5_0].moveAble then
					var_5_0 = var_5_0 or true

					local var_5_2 = (iter_5_0 - 1) * var_0_26.x

					if (iter_5_0 - 1) * var_0_26.x < self.grids[iter_5_0].tf.anchoredPosition.x then
						self.grids[iter_5_0].tf.anchoredPosition = Vector2(self.grids[iter_5_0].tf.anchoredPosition.x - self.grids[iter_5_0].speed * Time.deltaTime, 0)

						if self.grids[iter_5_0].speed < var_0_27 then
							self.grids[iter_5_0].speed = self.grids[iter_5_0].speed + var_0_29
						end
					end

					if var_5_2 >= self.grids[iter_5_0].tf.anchoredPosition.x then
						self.grids[iter_5_0].speed = 0
						self.grids[iter_5_0].moveAble = true

						if var_5_2 > self.grids[iter_5_0].tf.anchoredPosition.x then
							self.grids[iter_5_0].tf.anchoredPosition = Vector2(var_5_2, 0)
						end
					end
				end

				if not self.grids[iter_5_0].eventAble then
					GetComponent(self.grids[iter_5_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
						if self.comboCheck == false then
							local var_6_0, var_6_1 = self:triggerDownGrid(var_5_1)

							if #var_6_0 >= 2 then
								self.comboCheck = true

								local var_6_2 = self:getGridDouble(var_6_0)

								self:takeAwayGrid(var_6_0)
								self:insertGrids()

								for iter_6_0 = 1, #var_6_1 do
									self._event:emit(var_0_14, {
										series = var_6_1[iter_6_0].count,
										combo = self.combo,
										index = var_6_1[iter_6_0].index,
										double = var_6_2
									})
								end

								self.combo = self.combo + 1
							else
								self.comboCheck = true

								self:takeAwayGrid({
									var_5_1
								})
								self:insertGrids()
							end
						end

						return
					end)

					self.grids[iter_5_0].eventAble = true
				end
			end

			if not var_5_0 and self.comboCheck then
				local var_5_3 = self:getSeriesGrids()

				if #var_5_3 > 0 then
					local var_5_4 = {}

					for iter_5_1 = 1, #var_5_3 do
						for iter_5_2 = 1, #var_5_3[iter_5_1].series do
							table.insert(var_5_4, var_5_3[iter_5_1].series[iter_5_2])
						end

						self._event:emit(var_0_14, {
							series = #var_5_3[iter_5_1].series,
							combo = self.combo,
							index = var_5_3[iter_5_1].index,
							double = self:getGridDouble(var_5_3[iter_5_1].series)
						})
					end

					self:clearGridSeriesAble()
					self:takeAwayGrid(var_5_4)
					self:insertGrids()

					self.comboCheck = true
					self.combo = self.combo + 1
				else
					self.comboCheck = false
					self.combo = 0
				end
			end

			return
		end,
		getGridDouble = function(self, arg_7_1)
			for iter_7_0 = 1, #arg_7_1 do
				if self.grids[iter_7_0] and self.grids[iter_7_0].rule == var_0_32 then
					return true
				end
			end

			return false
		end,
		clear = function(self)
			for iter_8_0 = 1, #self.grids do
				if self.grids[iter_8_0].tf then
					destroy(self.grids[iter_8_0].tf)
				end
			end

			self.grids = {}
			self.gridCreateIndex = 1
			self.ruleGridList = {}

			return
		end,
		clearGridSeriesAble = function(self)
			for iter_9_0 = 1, #self.grids do
				if self.grids[iter_9_0].seriesAble then
					self.grids[iter_9_0].seriesAble = false
				end
			end

			return
		end,
		getSeriesGrids = function(self)
			local var_10_0 = {}
			local var_10_3 = {}
			local var_10_5
			local var_10_6 = 0

			for iter_10_0 = 1, #self.grids do
				if var_10_5 and var_10_5 == self.grids[iter_10_0].index then
					var_10_6 = var_10_6 + 1
				elseif self.grids[iter_10_0].rule == var_0_31 then
					var_10_6 = var_10_6 + 1
				else
					local var_10_7

					if false then
						var_10_5 = self.grids[iter_10_0].index
						var_10_7 = false
					else
						if var_10_6 >= 3 and self:checkGridComboFlag(var_10_3) then
							table.insert(var_10_0, {
								series = var_10_3,
								index = var_10_5
							})

							var_10_5 = self.grids[iter_10_0].index
							var_10_6 = 1
						end

						var_10_7 = self.grids[iter_10_0].rule == var_0_31
						var_10_3 = {}
					end
				end

				table.insert(var_10_3, iter_10_0)

				if iter_10_0 == #self.grids and #var_10_3 >= 3 and self:checkGridComboFlag(var_10_3) then
					table.insert(var_10_0, {
						series = var_10_3,
						index = var_10_5
					})

					var_10_3 = {}
				end
			end

			return var_10_0
		end,
		checkGridComboFlag = function(self, arg_11_1)
			for iter_11_0 = 1, #arg_11_1 do
				if self.grids[arg_11_1[iter_11_0]].seriesAble and iter_11_0 ~= #arg_11_1 then
					return true
				end
			end

			return false
		end,
		insertGrids = function(self)
			for iter_12_0 = 1, var_0_24 - #self.grids do
				table.insert(self.grids, (self:createGridData()))
			end

			if self:checkGridsMatchAble() then
				self:instiateGrids(true)
			else
				self:initGrids(true)
			end

			self:changeAbleGrids()

			return
		end,
		changeAbleGrids = function(self)
			for iter_13_0 = 1, #self.grids do
				self.grids[iter_13_0].moveAble = false
				self.grids[iter_13_0].eventAble = false
				self.grids[iter_13_0].speed = var_0_28
			end

			return
		end,
		takeAwayGrid = function(self, arg_14_1)
			table.sort(arg_14_1, function(arg_15_0, arg_15_1)
				return arg_15_0 <= arg_15_1
			end)

			self.takeAwayTime = var_0_25

			local var_14_0 = {}

			if arg_14_1[1] - 1 > 0 then
				self.grids[arg_14_1[1] - 1].seriesAble = true
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

			for iter_14_0 = #arg_14_1, 1, -1 do
				table.insert(var_14_0, table.remove(self.grids, arg_14_1[iter_14_0]))
				setActive(self.effects[arg_14_1[iter_14_0]], false)
				setActive(self.effects[arg_14_1[iter_14_0]], true)
			end

			for iter_14_1 = 1, #var_14_0 do
				destroy(var_14_0[iter_14_1].tf)

				var_14_0[iter_14_1] = 0
			end

			return
		end,
		triggerDownGrid = function(self, arg_16_1)
			local var_16_0
			local var_16_1 = {}
			local var_16_2 = {}

			if self.grids[arg_16_1].rule ~= var_0_31 then
				var_16_1 = {
					arg_16_1
				}
				var_16_0 = self.grids[arg_16_1].index
			end

			if not self.grids[arg_16_1] then
				return var_16_1, {}
			end

			if self.grids[arg_16_1].rule == var_0_31 then
				local var_16_3
				local var_16_4 = {}

				for iter_16_0 = arg_16_1 - 1, 1, -1 do
					if true then
						if self.grids[iter_16_0].rule == var_0_31 then
							table.insert(var_16_4, iter_16_0)
						elseif not var_16_3 then
							var_16_3 = self.grids[iter_16_0].index

							table.insert(var_16_4, iter_16_0)
						elseif var_16_3 == self.grids[iter_16_0].index then
							table.insert(var_16_4, iter_16_0)
						else
							-- block empty
						end
					end
				end

				local var_16_6
				local var_16_7 = true
				local var_16_8 = {}

				for iter_16_1 = arg_16_1 + 1, #self.grids do
					if var_16_7 then
						if self.grids[iter_16_1].rule == var_0_31 then
							table.insert(var_16_8, iter_16_1)
						elseif not var_16_6 then
							var_16_6 = self.grids[iter_16_1].index

							table.insert(var_16_8, iter_16_1)
						elseif var_16_6 == self.grids[iter_16_1].index then
							table.insert(var_16_8, iter_16_1)
						else
							var_16_7 = false
						end
					end
				end

				if var_16_3 == nil and var_16_6 == nil then
					for iter_16_2 = 1, #self.grids do
						table.insert(var_16_1, iter_16_2)
					end
				elseif var_16_3 == var_16_6 then
					for iter_16_3 = 1, #var_16_4 do
						table.insert(var_16_1, var_16_4[iter_16_3])
					end

					table.insert(var_16_1, arg_16_1)

					for iter_16_4 = 1, #var_16_8 do
						table.insert(var_16_1, var_16_8[iter_16_4])
					end

					var_16_0 = var_16_3
				else
					if #var_16_4 >= #var_16_8 then
						for iter_16_5 = 1, #var_16_4 do
							table.insert(var_16_1, var_16_4[iter_16_5])
						end

						var_16_0 = var_16_3
					else
						for iter_16_6 = 1, #var_16_8 do
							table.insert(var_16_1, var_16_8[iter_16_6])
						end

						var_16_0 = var_16_6
					end

					table.insert(var_16_1, arg_16_1)
				end

				table.insert(var_16_2, {
					index = var_16_0,
					count = #var_16_1
				})
			elseif self.grids[arg_16_1].rule == var_0_30 then
				local var_16_12
				local var_16_13 = true
				local var_16_14 = {}

				for iter_16_7 = arg_16_1 - 1, 1, -1 do
					if var_16_13 then
						if self.grids[iter_16_7].rule == var_0_31 then
							table.insert(var_16_14, iter_16_7)
						elseif not var_16_12 then
							var_16_12 = self.grids[iter_16_7].index

							table.insert(var_16_14, iter_16_7)
						elseif var_16_12 == self.grids[iter_16_7].index then
							table.insert(var_16_14, iter_16_7)
						else
							var_16_13 = false
						end
					end
				end

				local var_16_15
				local var_16_16 = {}

				for iter_16_8 = arg_16_1 + 1, #self.grids do
					if true then
						if self.grids[iter_16_8].rule == var_0_31 then
							table.insert(var_16_16, iter_16_8)
						elseif not var_16_15 then
							var_16_15 = self.grids[iter_16_8].index

							table.insert(var_16_16, iter_16_8)
						elseif var_16_15 == self.grids[iter_16_8].index then
							table.insert(var_16_16, iter_16_8)
						else
							-- block empty
						end
					end
				end

				table.insert(var_16_2, {
					index = var_16_12,
					count = #var_16_14 + 1
				})
				table.insert(var_16_2, {
					index = var_16_15,
					count = #var_16_16 + 1
				})

				for iter_16_9 = 1, #var_16_14 do
					table.insert(var_16_1, var_16_14[iter_16_9])
				end

				for iter_16_10 = 1, #var_16_16 do
					table.insert(var_16_1, var_16_16[iter_16_10])
				end
			else
				for iter_16_11 = arg_16_1 - 1, 1, -1 do
					if self:checkGridMatch(var_16_0, self.grids[iter_16_11]) then
						table.insert(var_16_1, iter_16_11)
					else
						break
					end
				end

				for iter_16_12 = arg_16_1 + 1, #self.grids do
					if self:checkGridMatch(var_16_0, self.grids[iter_16_12]) then
						table.insert(var_16_1, iter_16_12)
					else
						break
					end
				end

				table.insert(var_16_2, {
					index = var_16_0,
					count = #var_16_1
				})
			end

			table.sort(var_16_1, function(arg_17_0, arg_17_1)
				return arg_17_0 < arg_17_1
			end)

			return var_16_1, var_16_2
		end,
		checkGridMatch = function(arg_18_0, arg_18_1, arg_18_2)
			if arg_18_1 == arg_18_2.index then
				return true
			elseif arg_18_2.rule == var_0_31 then
				return true
			end

			return false
		end,
		initGrids = function(self, arg_19_1)
			self:clear()

			for iter_19_0 = 1, var_0_24 do
				table.insert(self.grids, (self:createGridData()))
			end

			if self:checkGridsMatchAble() then
				self:instiateGrids(arg_19_1)
			else
				self:initGrids(arg_19_1)
			end

			self.comboCheck = false

			return
		end,
		instiateGrids = function(self, arg_20_1)
			for iter_20_0 = 1, #self.grids do
				local var_20_0 = self.grids[iter_20_0]

				if not self.grids[iter_20_0].tf then
					local var_20_1 = tf(instantiate(self.tplGrid))

					SetParent(var_20_1, self._content)
					setActive(var_20_1, true)
					setActive(findTF(var_20_1, var_20_0.name), true)

					local var_20_2 = arg_20_1 and (var_0_24 + self.gridCreateIndex - 1) * var_0_26.x or (self.gridCreateIndex - 1) * var_0_26.x

					if var_20_0.rule == var_0_31 then
						-- block empty
					end

					if var_20_0.rule ~= var_0_31 then
						setActive(findTF(var_20_1, var_20_0.name .. "/boom"), var_20_0.rule == var_0_30)
						setActive(findTF(var_20_1, var_20_0.name .. "/thunder"), var_20_0.rule == var_0_32)
					end

					var_20_1.anchoredPosition = Vector2(var_20_2, 0)
					self.gridCreateIndex = self.gridCreateIndex + 1
					var_20_0.tf = var_20_1
				end
			end

			return
		end,
		createGridData = function(self)
			local var_21_0
			local var_21_3

			if #self.ruleGridList > 0 then
				local var_21_4 = table.remove(self.ruleGridList, 1)

				var_21_0 = var_21_4.id
				var_21_3 = var_21_4.rule
			end

			local var_21_5

			do
				var_21_0 = var_0_34[math.random(1, #var_0_34)]
				var_21_5 = {
					moveAble = false,
					eventAble = false,
					speed = var_0_28,
					index = var_0_33[var_21_0].index
				}
			end

			var_21_5.name = var_0_33[var_21_0].name
			var_21_5.rule = var_21_3

			return var_21_5
		end,
		checkGridsMatchAble = function(arg_22_0)
			return true
		end
	}

	var_1_0:ctor()

	return var_1_0
end

local var_0_86 = false

local function var_0_87(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = {
		ctor = function(self)
			self._specialTf = arg_23_0
			self._successTf = arg_23_1
			self._effectSuccess = findTF(self._successTf, "effectSuccess")
			self._event = arg_23_2

			self._event:bind(var_0_14, function(arg_25_0, arg_25_1, arg_25_2)
				self:addPowerAmount(arg_25_1.index, self:getPowerAmount(arg_25_1.series or 0, arg_25_1.combo, arg_25_1.double))

				return
			end)

			self.powers = {}

			for iter_24_0 = 1, #var_0_37 do
				local var_24_0 = findTF(self._specialTf, var_0_37[iter_24_0].name)
				local var_24_1 = findTF(self._specialTf, var_0_37[iter_24_0].name .. "/text")

				setActive(var_24_1, var_0_1)
				table.insert(self.powers, {
					active = false,
					tf = var_24_0,
					index = var_0_37[iter_24_0].index,
					max = var_0_37[iter_24_0].max,
					cur = var_0_37[iter_24_0].cur,
					text_tf = var_24_1
				})
			end

			self._event:bind(var_0_20, function(arg_26_0, arg_26_1, arg_26_2)
				self.inCameraFlag = true

				return
			end)
			self._event:bind(var_0_21, function(arg_27_0, arg_27_1, arg_27_2)
				self.inCameraFlag = false
				self.inCameraFadeTime = 200

				return
			end)

			self.successText = findTF(self._successTf, "box/text")

			setActive(self.successText, var_0_1)

			self.success = {
				cur = 0,
				slider = GetComponent(findTF(self._successTf, "box"), typeof(Slider)),
				max = var_0_46
			}

			return
		end,
		start = function(self)
			for iter_28_0 = 1, #self.powers do
				self.powers[iter_28_0].cur = 0
				self.powers[iter_28_0].active = false
			end

			self.inCameraFlag = false
			self.inCameraFadeTime = 0
			self.success.cur = 0
			self.success.active = false

			setActive(self._effectSuccess, false)
			self:resetSpecialData()
			self:step()

			return
		end,
		step = function(self)
			for iter_29_0 = 1, #self.powers do
				local var_29_0 = self.powers[iter_29_0]

				if self.powers[iter_29_0].active and var_29_0.cur > 0 then
					var_29_0.cur = var_29_0.cur - var_0_43 * Time.deltaTime

					if var_29_0.cur <= 0 then
						var_29_0.active = false
						var_29_0.cur = 0
					end
				end

				if var_29_0.cur > 0 then
					GetComponent(var_29_0.tf, typeof(Slider)).value = var_29_0.cur / var_29_0.max or 0
				end

				setText(var_29_0.text_tf, math.floor(var_29_0.cur))
			end

			setText(self.successText, math.floor(self.success.cur))

			if self.success.active and self.success.cur > 0 and var_0_23.special_complete and not self.inCameraFlag then
				if self.inCameraFadeTime > 0 then
					self.inCameraFadeTime = self.inCameraFadeTime - Time.deltaTime * 1000
				else
					self.success.cur = self.success.cur - var_0_44 * Time.deltaTime

					if self.success.cur <= 0 then
						self.success.active = false
						self.success.cur = 0

						self._event:emit(var_0_19)
					end
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

			var_0_23.special_time = self.success.active
			var_0_23.grid_index = 0

			if self.waitingSpecial then
				self:addPowerAmount(1, 0)
			end

			return
		end,
		clear = function(arg_30_0)
			return
		end,
		updateSpecialData = function(self, arg_31_1)
			var_0_23.special_time = self.success.active
			var_0_23.grid_index = arg_31_1
			var_0_23.power_grid = 0

			for iter_31_0 = 1, #self.powers do
				if self.powers[iter_31_0].index == arg_31_1 and self.powers[iter_31_0].cur == self.powers[iter_31_0].max then
					var_0_23.power_grid = self.powers[iter_31_0].index
				end
			end

			self._event:emit(var_0_15)

			return
		end,
		resetSpecialData = function(arg_32_0)
			var_0_23.special_complete = false

			return
		end,
		addPowerAmount = function(self, arg_33_1, arg_33_2)
			local var_33_0 = self:getPowerByIndex(arg_33_1)

			if self.success then
				if not self.success.active then
					self.success.cur = self.success.cur + arg_33_2

					if self.success.cur >= self.success.max then
						self.success.cur = self.success.max

						self._event:emit(var_0_18, {
							callback = function(arg_34_0)
								if arg_34_0 then
									if not isActive(self._effectSuccess) then
										setActive(self._effectSuccess, true)
									end

									self.success.active = true
									var_0_23.special_complete = false
									self.waitingSpecial = false
								else
									self.waitingSpecial = true
								end

								return
							end
						})
					end
				else
					self.success.cur = self.success.cur + arg_33_2 / 2

					if self.success.cur >= self.success.max then
						self.success.cur = self.success.max
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
				self:updateSpecialData(arg_33_1)
			end

			return
		end,
		getPowerByIndex = function(self, arg_35_1)
			for iter_35_0 = 1, #self.powers do
				if self.powers[iter_35_0].index == arg_35_1 then
					return self.powers[iter_35_0]
				end
			end

			return nil
		end,
		getPowerAmount = function(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
			if arg_36_1 <= 2 then
				print("分数: " .. var_0_45)

				return var_0_45
			end

			local var_36_0 = arg_36_3 and 2 or 1

			if (arg_36_3 and 2 or 1) == 2 then
				-- block empty
			end

			local var_36_1

			if var_0_23.special_time then
				var_36_1 = var_0_42 or 1
			end

			print("方块个数: " .. arg_36_1 .. ",combo次数: " .. arg_36_2 .. ", 加倍方块: " .. tostring(arg_36_3) .. "，变身倍率: " .. var_36_1)
			print("分数: " .. (var_0_41 + (arg_36_1 - var_0_40) * var_0_39) * (1 + arg_36_2 * var_0_38) * var_36_1)

			return (var_0_41 + (arg_36_1 - var_0_40) * var_0_39) * (1 + arg_36_2 * var_0_38) * var_36_0 * var_36_1
		end
	}

	var_23_0:ctor()

	return var_23_0
end

local function var_0_88(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {
		ctor = function(self)
			self._sceneTf = arg_37_0
			self._event = arg_37_2
			self.bgs = {}
			self._gameTf = arg_37_1
			self._box = findTF(self._gameTf, "box")
			self._specialPower = findTF(self._gameTf, "specialPower")
			self._successPower = findTF(self._gameTf, "successPower")
			self._top = findTF(self._gameTf, "top")

			for iter_38_0 = 1, #var_0_72 do
				table.insert(self.bgs, {
					tf = findTF(self._sceneTf, var_0_72[iter_38_0].source),
					rate = var_0_72[iter_38_0].rate,
					type = var_0_72[iter_38_0].type
				})
			end

			self._bgBackCanvas = GetComponent(findTF(self._sceneTf, "scene_background"), typeof(CanvasGroup))
			self._bgFrontCanvas = GetComponent(findTF(self._sceneTf, "scene_front"), typeof(CanvasGroup))
			self._bgBeamCanvas = GetComponent(findTF(self._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

			self._event:bind(var_0_16, function(arg_39_0, arg_39_1, arg_39_2)
				local var_39_0 = arg_39_1[2] and -1 or 1

				if not self.inCamera then
					self:setTargetFllow(Vector2(var_39_0 * arg_39_1[1].x / 10, var_39_0 * arg_39_1[1].y / 10), arg_39_1[3])
				end

				return
			end)
			self._event:bind(var_0_20, function(arg_40_0, arg_40_1, arg_40_2)
				self.inCamera = true

				local var_40_0 = Vector2(550, 100)

				self:setTargetFllow((arg_40_1 and arg_40_1.playingAction and arg_40_1.playingAction.camera_pos or nil) and arg_40_1.playingAction.camera_pos)
				self:setBeam(false)

				return
			end)
			self._event:bind(var_0_21, function(arg_41_0, arg_41_1, arg_41_2)
				self.followTf = nil
				self.followInit = nil

				self:setTargetFllow(Vector2(0, 0), function()
					return
				end, true)
				self:setBeam(true)

				self.inCamera = false

				return
			end)

			return
		end,
		start = function(self)
			self.targetVec = Vector2(var_0_57.x, var_0_57.y)
			self.currentVec = Vector2(var_0_57.x, var_0_57.y)

			for iter_43_0 = 1, #self.bgs do
				local var_43_0 = self.bgs[iter_43_0].tf
				local var_43_1 = self.bgs[iter_43_0].rate
				local var_43_2 = self.bgs[iter_43_0].type

				if self.bgs[iter_43_0].tf then
					setActive(var_43_0, var_43_2 == var_0_68 or var_43_2 == var_0_71)

					var_43_0.anchoredPosition = Vector2(self.currentVec.x * var_43_1, self.currentVec.y * var_43_1)
				end
			end

			self._bgBackCanvas.alpha = 1
			self._bgFrontCanvas.alpha = 1
			self._bgBeamCanvas.alpha = 0

			setActive(self._box, true)
			setActive(self._specialPower, true)
			setActive(self._successPower, true)
			setActive(self._top, true)

			return
		end,
		clear = function(self)
			if LeanTween.isTweening(go(self._sceneTf)) then
				LeanTween.cancel(go(self._sceneTf), false)
			end

			return
		end,
		step = function(self)
			local var_45_0 = {
				0,
				0
			}

			if self.followTf then
				var_45_0 = {
					self.followTf.anchoredPosition.x - self.followInit.x,
					self.followTf.anchoredPosition.y - self.followInit.y
				}
			end

			local var_45_1 = 0
			local var_45_2 = 0

			if self.targetVec.x - var_45_0[1] ~= self.currentVec.x then
				var_45_1 = (self.targetVec.x - var_45_0[1] - self.currentVec.x) * var_0_58

				if math.abs((self.targetVec.x - var_45_0[1] - self.currentVec.x) * var_0_58) < var_0_59 then
					var_45_1 = var_0_59 * math.sign(var_45_1)
				end

				self.currentVec.x = self.currentVec.x + var_45_1

				if math.abs(self.currentVec.x - (self.targetVec.x - var_45_0[1])) <= var_0_59 then
					self.currentVec.x = self.targetVec.x - var_45_0[1]
				end
			end

			if self.targetVec.y - var_45_0[2] ~= self.currentVec.y then
				var_45_2 = (self.targetVec.y - var_45_0[2] - self.currentVec.y) * var_0_58

				if math.abs((self.targetVec.y - var_45_0[2] - self.currentVec.y) * var_0_58) < var_0_59 then
					var_45_2 = var_0_59 * math.sign(var_45_2)
				end

				self.currentVec.y = self.currentVec.y + var_45_2

				if math.abs(self.currentVec.y - (self.targetVec.y - var_45_0[2])) <= var_0_59 then
					self.currentVec.y = self.targetVec.y - var_45_0[2]
				end
			end

			if var_45_1 ~= 0 or var_45_2 ~= 0 then
				self:moveTo(self.currentVec)
			end

			return
		end,
		moveTo = function(self, arg_46_1)
			for iter_46_0 = 1, #self.bgs do
				if self.bgs[iter_46_0].type == var_0_68 or self.bgs[iter_46_0].type == var_0_71 then
					self.bgs[iter_46_0].tf.anchoredPosition = Vector2(arg_46_1.x * self.bgs[iter_46_0].rate, arg_46_1.y * self.bgs[iter_46_0].rate)
				end
			end

			return
		end,
		setTargetFllow = function(self, arg_47_1, arg_47_2, arg_47_3)
			if not arg_47_3 then
				self.targetVec = arg_47_1
				self.moveCallback = arg_47_2
			else
				self.currentVec = arg_47_1
				self.targetVec = arg_47_1

				self:moveTo(arg_47_1)

				if arg_47_2 then
					arg_47_2()
				end
			end

			return
		end,
		setBeam = function(self, arg_48_1, arg_48_2)
			if LeanTween.isTweening(go(self._sceneTf)) then
				LeanTween.cancel(go(self._sceneTf), false)
			end

			if arg_48_1 then
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

			LeanTween.value(go(self._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_49_0)
				if arg_48_1 then
					self._bgBackCanvas.alpha = arg_49_0
					self._bgFrontCanvas.alpha = arg_49_0
					self._bgBeamCanvas.alpha = 1 - arg_49_0
				else
					self._bgBackCanvas.alpha = 1 - arg_49_0
					self._bgFrontCanvas.alpha = 1 - arg_49_0
					self._bgBeamCanvas.alpha = arg_49_0
				end

				return
			end)):setOnComplete(System.Action(function()
				if arg_48_2 then
					arg_48_2()
				end

				return
			end))

			return
		end
	}

	var_37_0:ctor()

	return var_37_0
end

local function var_0_89(arg_51_0, arg_51_1)
	local var_51_0 = {
		ctor = function(self)
			self._scene = arg_51_0
			self._tpl = findTF(self._scene, "tpl")
			self._leftRolePos = findTF(self._scene, "rolePos/leftRole")
			self._rightRolePos = findTF(self._scene, "rolePos/rightRole")
			self._event = arg_51_1

			self._event:bind(var_0_15, function()
				self:onGridTrigger()

				return
			end)
			self._event:bind(var_0_18, function(arg_54_0, arg_54_1, arg_54_2)
				local var_54_0 = false

				for iter_54_0, iter_54_1 in pairs(self.playingDatas) do
					if iter_54_1.inPlaying then
						var_54_0 = true
					end
				end

				if arg_54_1.callback then
					arg_54_1.callback(not var_54_0)
				end

				if not var_54_0 then
					self:onRoleSpecial(arg_54_1)
				end

				return
			end)
			self._event:bind(var_0_19, function()
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

			self.leftRole = self:createRole(var_0_47, true, self._leftRolePos)
			self.rightRole = self:createRole(var_0_48, false, self._rightRolePos)
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

			self._event:emit(var_0_16, {
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
				self.skillDeltaTime = var_0_60
			end

			self.skillDeltaTime = self.skillDeltaTime - Time.deltaTime

			if self.skillDeltaTime <= 0 then
				local var_58_0 = false

				for iter_58_0, iter_58_1 in pairs(self.playingDatas) do
					if iter_58_1.inPlaying then
						var_58_0 = true
					end
				end

				if not var_58_0 then
					for iter_58_2, iter_58_3 in pairs(self.playingDatas) do
						if #iter_58_3.skillDatas > 0 then
							self:applyOrAddSkillData(iter_58_3)

							break
						end
					end
				end
			end

			var_0_86 = false

			for iter_58_4, iter_58_5 in pairs(self.playingDatas) do
				if iter_58_5.inPlaying then
					var_0_86 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(self)
			if self.emptySkillTime and self.emptySkillTime <= 0 then
				self.emptySkillTime = var_0_61
			end

			self.emptySkillTime = self.emptySkillTime - Time.deltaTime

			if self.emptySkillTime <= 0 then
				local var_59_0 = false

				for iter_59_0, iter_59_1 in pairs(self.playingDatas) do
					if iter_59_1.inPlaying then
						var_59_0 = true
					end
				end

				if not var_59_0 then
					local var_59_1 = self:getRoleEmptySkill(self.rightRole)

					if var_59_1 then
						self:addRolePlaying(self.rightRole, var_59_1)
					end
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
				if tobool(arg_61_1.skill[iter_61_0].special_time) == arg_61_1.specialBody and arg_61_1.skill[iter_61_0].atk_index then
					table.insert(var_61_0, arg_61_1.skill[iter_61_0])
				end
			end

			if #var_61_0 > 0 then
				return Clone(var_61_0[math.random(1, #var_61_0)])
			end

			return nil
		end,
		onRoleSpecial = function(self, arg_62_1)
			self.leftRole.specialTime = true

			for iter_62_0 = 1, #self.leftRole.skill do
				if self.leftRole.skill[iter_62_0].special_trigger then
					self:addRolePlaying(self.leftRole, Clone(self.leftRole.skill[iter_62_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(self)
			self.leftRole.specialTime = false

			local var_63_0

			for iter_63_0 = 1, #self.leftRole.skill do
				if self.leftRole.skill[iter_63_0].special_time and self.leftRole.skill[iter_63_0].power_index == 1 and self.leftRole.skill[iter_63_0].atk_index > 0 then
					local var_63_1 = Clone(self.leftRole.skill[iter_63_0])
				end

				if not self.leftRole.skill[iter_63_0].special_trigger and self.leftRole.skill[iter_63_0].special_end then
					var_63_0 = Clone(self.leftRole.skill[iter_63_0])
				end
			end

			if nil then
				self:addRolePlaying(self.leftRole, nil)
			end

			if var_63_0 then
				self:addRolePlaying(self.leftRole, var_63_0)
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
			for iter_65_0 = 1, #self.leftRole.skill do
				if tobool(self.leftRole.skill[iter_65_0].special_time) == tobool(self.leftRole.specialTime) and self.leftRole.skill[iter_65_0].power_index == var_0_23.power_grid and table.contains(self.leftRole.skill[iter_65_0].grid_index, var_0_23.grid_index) and self.leftRole.skill[iter_65_0].atk_index then
					self:addRolePlaying(self.leftRole, Clone(self.leftRole.skill[iter_65_0]))
				end
			end

			return
		end,
		createRole = function(self, arg_66_1, arg_66_2, arg_66_3)
			local var_66_0 = self:getRoleData(arg_66_1)

			if not var_66_0 then
				return nil
			end

			local var_66_1 = {}
			local var_66_2 = tf(instantiate(findTF(self._tpl, var_66_0.name)))

			SetParent(var_66_2, arg_66_3)

			var_66_2.anchoredPosition = Vector2(0, 0)
			var_66_2.localScale = Vector3(1, 1, 1)

			setActive(var_66_2, true)

			if var_66_0.anim_init_pos then
				findTF(var_66_2, "body/anim").anchoredPosition = var_66_0.anim_init_pos
			end

			local var_66_3 = findTF(var_66_2, "body")
			local var_66_4 = findTF(var_66_3, "anim")
			local var_66_5 = GetComponent(var_66_4, typeof(DftAniEvent))

			var_66_5:SetStartEvent(function()
				if var_66_1.startCallback then
					var_66_1.startCallback()
				end

				return
			end)
			var_66_5:SetTriggerEvent(function()
				if var_66_1.triggerCallback then
					var_66_1.triggerCallback()
				end

				return
			end)
			var_66_5:SetEndEvent(function()
				if var_66_1.endCallback then
					var_66_1.endCallback()
				end

				return
			end)

			var_66_1.name = var_66_0.name
			var_66_1.tf = var_66_2
			var_66_1.canvasGroup = GetComponent(var_66_2, typeof(CanvasGroup))
			var_66_1.body = var_66_3
			var_66_1.animTf = var_66_4
			var_66_1.animator = GetComponent(var_66_4, typeof(Animator))
			var_66_1.dftEvent = var_66_5
			var_66_1.startCallback = nil
			var_66_1.triggerCallback = nil
			var_66_1.endCallback = nil
			var_66_1.skill = var_66_0.skill
			var_66_1.name = var_66_0.name
			var_66_1.index = var_66_0.index
			var_66_1.actions = var_66_0.actions

			return var_66_1
		end,
		getRoleData = function(arg_70_0, arg_70_1)
			for iter_70_0 = 1, #var_0_84 do
				if var_0_84[iter_70_0].index == arg_70_1 then
					return Clone(var_0_84[iter_70_0])
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
			arg_72_1.animator:Play(arg_72_2, -1, 0)

			return
		end,
		addRolePlaying = function(self, arg_73_1, arg_73_2, arg_73_3)
			for iter_73_0, iter_73_1 in pairs(self.playingDatas) do
				if iter_73_0 == arg_73_1.name then
					if arg_73_3 then
						self:applyOrAddSkillData(iter_73_1, arg_73_2)
					else
						table.insert(iter_73_1.skillDatas, arg_73_2)

						if arg_73_2.power_index > 0 and arg_73_2.atk_index > 1 or arg_73_2.special_trigger then
							for iter_73_2 = #iter_73_1.skillDatas - 1, 1, -1 do
								if iter_73_1.skillDatas[iter_73_2].power_index == 0 and iter_73_1.skillDatas[iter_73_2].atk_index == 1 then
									local var_73_0 = table.remove(iter_73_1.skillDatas, iter_73_2)

									if var_73_0.score then
										self.addScore = {
											self.addScore[1] + var_73_0.score[1],
											self.addScore[2] + var_73_0.score[2]
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
		applyOrAddSkillData = function(self, arg_74_1, arg_74_2)
			if arg_74_1.inPlaying then
				table.insert(arg_74_1.skillDatas, arg_74_2)

				return
			end

			arg_74_1.inPlaying = true

			local var_74_0 = arg_74_2 or table.remove(arg_74_1.skillDatas, 1)

			arg_74_1.currentSkill = var_74_0
			arg_74_1.actions = var_74_0.actions

			if var_74_0.anim_bool then
				arg_74_1.role.animator:SetBool(var_74_0.anim_bool, true)
			end

			if arg_74_1.role == self.leftRole and not var_74_0.dmg_index then
				self._leftRolePos:SetSiblingIndex(1)
			elseif arg_74_1.role == self.rightRole and not var_74_0.dmg_index then
				self._rightRolePos:SetSiblingIndex(1)
			end

			if var_74_0.anim_init_pos then
				findTF(arg_74_1.role.tf, "body/anim").anchoredPosition = var_74_0.anim_init_pos
			end

			if var_74_0.special_end then
				arg_74_1.role.specialBody = false
			elseif var_74_0.special_trigger then
				arg_74_1.role.specialBody = true
			end

			arg_74_1.actionIndex = 1

			self:checkAction(arg_74_1, function()
				arg_74_1.inPlaying = false

				self._event:emit(var_0_16, {
					Vector2(0, 0),
					false
				})

				return
			end)

			return
		end,
		checkAction = function(self, arg_76_1, arg_76_2)
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

				if arg_76_1.currentSkill.special_trigger or arg_76_1.currentSkill.special_time and arg_76_1.currentSkill.atk_index and arg_76_1.currentSkill.atk_index >= 2 then
					self._event:emit(var_0_22, true)
				end

				if var_76_1 and var_76_1 > 0 then
					-- block empty
				else
					self:setDftHandle(arg_76_1.role, function()
						if var_76_5 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_5)
						end

						if var_76_2 then
							self:moveRole(arg_76_1.role, var_76_2)
						end

						if var_76_4 then
							arg_76_1.role.targetRole.canvasGroup.alpha = 0

							self._event:emit(var_0_20, arg_76_1)
						end

						return
					end, function()
						if var_76_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_6)
						end

						if var_76_4 then
							var_76_4 = false
							arg_76_1.role.targetRole.canvasGroup.alpha = 1

							self._event:emit(var_0_21)
						else
							if arg_76_1.currentSkill.anim_trigger_pos then
								findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = arg_76_1.currentSkill.anim_trigger_pos
							end

							if arg_76_1.currentSkill.atk_index then
								local var_78_0 = self:getRoleDmgData(arg_76_1.role.targetRole, arg_76_1.currentSkill.atk_index)

								if var_78_0 then
									for iter_78_0, iter_78_1 in pairs(self.playingDatas) do
										if iter_78_0 == arg_76_1.role.targetRole.name then
											self:applyOrAddSkillData(iter_78_1, Clone(var_78_0), true)
										end
									end
								end

								local var_78_1 = arg_76_1.currentSkill.score

								if arg_76_1.currentSkill.score and arg_76_1.role == self.leftRole then
									self._event:emit(var_0_17, math.random(var_78_1[1] + self.addScore[1], var_78_1[2] + self.addScore[2]))

									self.addScore = {
										0,
										0
									}
								end
							end
						end

						return
					end, function()
						if var_76_7 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_7)
						end

						if LeanTween.isTweening(go(arg_76_1.role.tf)) then
							LeanTween.cancel(go(arg_76_1.role.tf))
						end

						if arg_76_1.currentSkill.anim_end_pos then
							findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = arg_76_1.currentSkill.anim_end_pos
						end

						self._event:emit(var_0_22, false)

						if var_76_3 then
							arg_76_1.role.tf.anchoredPosition = Vector2(arg_76_1.role.tf.anchoredPosition.x + var_76_3.x, arg_76_1.role.tf.anchoredPosition.y + var_76_3.y)
						end

						if arg_76_1.currentSkill.special_trigger and var_0_23.special_time and not var_0_23.special_complete then
							var_0_23.special_complete = true
						end

						arg_76_1.playingAction = nil

						self:setDftHandle(arg_76_1.role, nil, nil, nil)
						self:checkAction(arg_76_1, arg_76_2)

						return
					end)
					self:playAnimation(arg_76_1.role, var_76_0)
				end
			else
				if arg_76_1.currentSkill.atk_index == 3 then
					local var_76_8 = self:getRoleDmgBack(arg_76_1.role.targetRole, arg_76_1.currentSkill.atk_index)

					if var_76_8 then
						for iter_76_0, iter_76_1 in pairs(self.playingDatas) do
							if iter_76_0 == arg_76_1.role.targetRole.name then
								self:applyOrAddSkillData(iter_76_1, Clone(var_76_8))
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
		moveRole = function(self, arg_80_1, arg_80_2)
			if LeanTween.isTweening(go(arg_80_1.tf)) then
				LeanTween.cancel(go(arg_80_1.tf))
			end

			if arg_80_2.distance then
				self._event:emit(var_0_16, {
					arg_80_2.distance,
					arg_80_1 == self.leftRole
				})
				LeanTween.move(arg_80_1.tf, Vector3(arg_80_2.distance.x, arg_80_2.distance.y, 0), arg_80_2.time):setEase(arg_80_2.ease or LeanTweenType.linear)
			elseif arg_80_2.distance_m then
				local var_80_0 = Vector2(arg_80_1.tf.anchoredPosition.x + arg_80_2.distance_m.x, arg_80_1.tf.anchoredPosition.y + arg_80_2.distance_m.y)

				self._event:emit(var_0_16, {
					var_80_0,
					arg_80_1 == self.leftRole
				})
				LeanTween.move(arg_80_1.tf, Vector3(var_80_0.x, var_80_0.y, 0), arg_80_2.time):setEase(arg_80_2.ease or LeanTweenType.linear)
			end

			return
		end,
		getRoleDmgData = function(arg_81_0, arg_81_1, arg_81_2)
			for iter_81_0 = 1, #arg_81_1.skill do
				if arg_81_1.skill[iter_81_0].dmg_index == arg_81_2 and arg_81_1.skill[iter_81_0].special_time == tobool(arg_81_1.specialBody) then
					return arg_81_1.skill[iter_81_0]
				end
			end

			return nil
		end,
		getRoleDmgBack = function(arg_82_0, arg_82_1, arg_82_2)
			for iter_82_0 = 1, #arg_82_1.skill do
				if arg_82_1.skill[iter_82_0].dmg_back and arg_82_1.skill[iter_82_0].special_time == tobool(arg_82_1.specialBody) then
					return arg_82_1.skill[iter_82_0]
				end
			end

			return nil
		end
	}

	var_51_0:ctor()

	return var_51_0
end

function GridGameReView:getUIName()
	return "GridGameReUI"
end

function GridGameReView:didEnter()
	self:initEvent()
	self:initData()
	self:initUI()
	self:initGameUI()
	self:initController()
	self:updateMenuUI()
	self:openMenuUI()

	return
end

function GridGameReView:initEvent()
	self:bind(var_0_17, function(arg_86_0, arg_86_1, arg_86_2)
		self:addScore(arg_86_1)

		return
	end)
	self:bind(var_0_22, function(arg_87_0, arg_87_1, arg_87_2)
		self.ignoreTime = arg_87_1

		return
	end)

	return
end

function GridGameReView:onEventHandle(arg_88_1)
	return
end

function GridGameReView:initData()
	local var_89_0 = Application.targetFrameRate or 60

	if var_89_0 > 60 then
		var_89_0 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_89_0, -1)

	return
end

function GridGameReView:initUI()
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

	for iter_91_0 = 1, #var_0_51 do
		local var_91_0 = findTF(self.selectedUI, "ad/leftRole/role" .. var_0_51[iter_91_0])

		setActive(var_91_0, true)

		local var_91_1 = var_0_51[iter_91_0]

		onButton(self, var_91_0, function()
			var_0_47, var_0_48 = self:checkRoleId(var_91_1, var_0_48, var_0_52)

			self:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(self.leftSelectRole, {
			id = var_0_51[iter_91_0],
			tf = var_91_0
		})
	end

	onButton(self, findTF(self.selectedUI, "close"), function()
		setActive(self.selectedUI, false)

		return
	end, SFX_CANCEL)

	self.rightSelectRole = {}

	for iter_91_1 = 1, #var_0_52 do
		local var_91_2 = findTF(self.selectedUI, "ad/rightRole/role" .. var_0_52[iter_91_1])

		setActive(var_91_2, true)

		local var_91_3 = var_0_52[iter_91_1]

		onButton(self, var_91_2, function()
			var_0_48, var_0_47 = self:checkRoleId(var_91_3, var_0_47, var_0_51)

			self:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(self.rightSelectRole, {
			id = var_0_52[iter_91_1],
			tf = var_91_2
		})
	end

	onButton(self, findTF(self.selectedUI, "ad/btnOk"), function()
		setActive(self.selectedUI, false)
		setActive(self.menuUI, false)
		self:readyStart()

		return
	end, SFX_CONFIRM)

	self.btnDay = findTF(self.selectedUI, "ad/btnDay")
	self.btnNight = findTF(self.selectedUI, "ad/btnNight")

	local var_91_4 = self:getGameUsedTimes() or 0

	if var_0_54[var_91_4 + 1] then
		var_0_71 = var_0_54[var_91_4 + 1] or var_0_70
	end

	setActive(findTF(self.btnDay, "on"), var_0_71 == var_0_69)
	setActive(findTF(self.btnNight, "on"), var_0_71 == var_0_70)
	onButton(self, self.btnDay, function()
		var_0_71 = var_0_69

		setActive(findTF(self.btnDay, "on"), true)
		setActive(findTF(self.btnNight, "on"), false)
		self:updateMenuUI()

		return
	end, SFX_CONFIRM)
	onButton(self, self.btnNight, function()
		var_0_71 = var_0_70

		setActive(findTF(self.btnDay, "on"), false)
		setActive(findTF(self.btnNight, "on"), true)
		self:updateMenuUI()

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
		local var_108_0 = self:getGameUsedTimes() or 0
		local var_108_1 = self:getGameTimes() or 0

		if var_108_0 >= var_0_56 and self.selectedUI then
			self:updateSelectedUI()
			setActive(self.selectedUI, true)
		else
			if var_0_54[var_108_0 + 1] then
				var_0_71 = var_0_54[var_108_0 + 1] or 1
			end

			if var_108_2 > #var_0_53 then
				var_108_2 = #var_0_53
			end

			var_0_47 = var_0_53[var_108_2][1]
			var_0_48 = var_0_53[var_108_2][2]

			setActive(self.menuUI, false)
			self:readyStart()
		end

		return
	end, SFX_CONFIRM)

	local var_91_5 = findTF(self.menuUI, "tplBattleItem")

	self.battleItems = {}
	self.dropItems = {}

	for iter_91_2 = 1, 7 do
		local var_91_6 = tf(instantiate(var_91_5))

		var_91_6.name = "battleItem_" .. iter_91_2

		setParent(var_91_6, findTF(self.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync(var_0_6, "battleDesc" .. iter_91_2, function(arg_109_0)
			setImageSprite(findTF(var_91_6, "state_open/buttomDesc"), arg_109_0, true)
			setImageSprite(findTF(var_91_6, "state_clear/buttomDesc"), arg_109_0, true)
			setImageSprite(findTF(var_91_6, "state_current/buttomDesc"), arg_109_0, true)
			setImageSprite(findTF(var_91_6, "state_closed/buttomDesc"), arg_109_0, true)

			return
		end)
		setActive(var_91_6, true)
		table.insert(self.battleItems, var_91_6)
	end

	self.handle = self.handle or UpdateBeat:CreateListener(self.Update, self)

	UpdateBeat:AddListener(self.handle)

	return
end

function GridGameReView:checkRoleId(arg_110_1, arg_110_2, arg_110_3)
	if not self:matchRoleId(arg_110_1, arg_110_2) then
		for iter_110_0 = 1, #arg_110_3 do
			if self:matchRoleId(arg_110_1, arg_110_3[iter_110_0]) then
				return arg_110_1, arg_110_3[iter_110_0]
			end
		end
	end

	return arg_110_1, arg_110_2
end

function GridGameReView:matchRoleId(arg_111_1, arg_111_2)
	if arg_111_1 == arg_111_2 then
		return false
	end

	for iter_111_0 = 1, #var_0_50 do
		if table.contains(var_0_50[iter_111_0], arg_111_1) and table.contains(var_0_50[iter_111_0], arg_111_2) then
			return false
		end
	end

	return true
end

function GridGameReView:initGameUI()
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

function GridGameReView:initController()
	self.boxController = var_0_85(findTF(self.gameUI, "box"), self)
	self.specialController = var_0_87(findTF(self.gameUI, "specialPower"), findTF(self.gameUI, "successPower"), self)
	self.bgController = var_0_88(findTF(self._tf, "sceneContainer"), self.gameUI, self)
	self.roleController = var_0_89(findTF(self._tf, "sceneContainer/scene"), self)

	return
end

function GridGameReView:Update()
	self:AddDebugInput()

	return
end

function GridGameReView:AddDebugInput()
	if self.gameStop or self.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function GridGameReView:updateSelectedUI()
	for iter_118_0 = 1, #self.leftSelectRole do
		if var_0_47 == self.leftSelectRole[iter_118_0].id then
			setActive(findTF(self.leftSelectRole[iter_118_0].tf, "selected"), true)
			setActive(findTF(self.leftSelectRole[iter_118_0].tf, "unSelected"), false)
		else
			setActive(findTF(self.leftSelectRole[iter_118_0].tf, "selected"), false)
			setActive(findTF(self.leftSelectRole[iter_118_0].tf, "unSelected"), true)
		end
	end

	for iter_118_1 = 1, #self.rightSelectRole do
		setGray(self.rightSelectRole[iter_118_1].tf, not self:matchRoleId(var_0_47, self.rightSelectRole[iter_118_1].id), true)

		if var_0_48 == self.rightSelectRole[iter_118_1].id then
			setActive(findTF(self.rightSelectRole[iter_118_1].tf, "selected"), true)
			setActive(findTF(self.rightSelectRole[iter_118_1].tf, "unSelected"), false)
		else
			setActive(findTF(self.rightSelectRole[iter_118_1].tf, "selected"), false)
			setActive(findTF(self.rightSelectRole[iter_118_1].tf, "unSelected"), true)
		end
	end

	return
end

function GridGameReView:updateMenuUI()
	local var_119_0 = self:getGameUsedTimes()

	if var_119_0 and var_119_0 >= 7 then
		setActive(findTF(self.menuUI, "btnStart/free"), true)
	else
		setActive(findTF(self.menuUI, "btnStart/free"), false)
	end

	local var_119_1 = self:getGameTimes()

	for iter_119_0 = 1, #self.battleItems do
		setActive(findTF(self.battleItems[iter_119_0], "state_open"), false)
		setActive(findTF(self.battleItems[iter_119_0], "state_closed"), false)
		setActive(findTF(self.battleItems[iter_119_0], "state_clear"), false)
		setActive(findTF(self.battleItems[iter_119_0], "state_current"), false)

		if iter_119_0 <= var_119_0 then
			setActive(findTF(self.battleItems[iter_119_0], "state_clear"), true)
		elseif iter_119_0 == var_119_0 + 1 and var_119_1 >= 1 then
			setActive(findTF(self.battleItems[iter_119_0], "state_current"), true)
		elseif var_119_0 < iter_119_0 and iter_119_0 <= var_119_0 + var_119_1 then
			setActive(findTF(self.battleItems[iter_119_0], "state_open"), true)
		else
			setActive(findTF(self.battleItems[iter_119_0], "state_closed"), true)
		end
	end

	self.totalTimes = self:getGameTotalTime()

	local var_119_2 = 1 - (self:getGameUsedTimes() - 3 < 0 and 0 or self:getGameUsedTimes() - 3) / (self.totalTimes - 4)

	if var_119_2 > 1 then
		var_119_2 = 1
	end

	scrollTo(self.battleScrollRect, 0, var_119_2)
	setActive(findTF(self.menuUI, "btnStart/tip"), var_119_1 > 0)

	local var_119_3

	if var_0_71 == var_0_69 then
		var_119_3 = var_0_66
	elseif var_0_71 == var_0_70 then
		var_119_3 = var_0_67
	end

	for iter_119_1, iter_119_2 in ipairs(var_0_65) do
		setActive(findTF(self._tf, "bg/" .. iter_119_2), table.contains(var_119_3, iter_119_2))
	end

	setActive(findTF(self.menuUI, "bg/title_day"), var_0_71 == var_0_69)
	setActive(findTF(self.menuUI, "bg/title_night"), var_0_71 ~= var_0_69)
	self:CheckGet()

	return
end

function GridGameReView:CheckGet()
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

function GridGameReView:openMenuUI()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), false)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), false)
	setActive(findTF(self._tf, "sceneContainer/scene"), false)
	setActive(self.gameUI, false)
	setActive(self.menuUI, true)
	setActive(self.selectedUI, false)
	self:updateMenuUI()

	local var_121_0 = self:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

	if self.bgm ~= var_121_0 then
		self.bgm = var_121_0

		pg.BgmMgr.GetInstance():Push(self.__cname, var_121_0)
	end

	return
end

function GridGameReView:clearUI()
	setActive(self.sceneTf, false)
	setActive(self.settlementUI, false)
	setActive(self.countUI, false)
	setActive(self.menuUI, false)
	setActive(self.gameUI, false)
	setActive(self.selectedUI, false)

	return
end

function GridGameReView:readyStart()
	setActive(self.countUI, true)
	self.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

	if var_0_2 and self.bgm ~= var_0_2 then
		self.bgm = var_0_2

		pg.BgmMgr.GetInstance():Push(self.__cname, var_0_2)
	end

	return
end

function GridGameReView:gameStart()
	setActive(findTF(self._tf, "sceneContainer/scene_front"), true)
	setActive(findTF(self._tf, "sceneContainer/scene_background"), true)
	setActive(findTF(self._tf, "sceneContainer/scene"), true)
	setActive(self.scoreAnimTf, false)
	setActive(self.gameUI, true)

	self.gameStartFlag = true
	self.scoreNum = 0
	self.playerPosIndex = 2
	self.gameStepTime = 0
	self.gameTime = var_0_7
	self.ignoreTime = false

	self.boxController:start()
	self.specialController:start()
	self.bgController:start()
	self.roleController:start()
	self:updateGameUI()
	self:timerStart()

	return
end

function GridGameReView:getGameTimes()
	return self:GetMGHubData().count
end

function GridGameReView:getGameUsedTimes()
	return self:GetMGHubData().usedtime
end

function GridGameReView:getUltimate()
	return self:GetMGHubData().ultimate
end

function GridGameReView:getGameTotalTime()
	return (self:GetMGHubData():getConfig("reward_need"))
end

function GridGameReView:changeSpeed(arg_129_1)
	return
end

function GridGameReView:onTimer()
	self:gameStep()

	return
end

function GridGameReView:gameStep()
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

function GridGameReView:timerStart()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function GridGameReView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function GridGameReView:updateGameUI()
	setText(self.scoreTf, self.scoreNum)
	setText(self.gameTimeS, math.ceil(self.gameTime))

	return
end

function GridGameReView:addScore(arg_135_1)
	setActive(self.scoreAnimTf, false)
	setActive(self.scoreAnimTf, true)
	setText(self.scoreAnimTextTf, "+" .. tostring(arg_135_1))

	self.scoreNum = self.scoreNum + arg_135_1

	if self.scoreNum < 0 then
		self.scoreNum = 0
	end

	return
end

function GridGameReView:onGameOver()
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

function GridGameReView:showSettlement()
	setActive(self.settlementUI, true)
	GetComponent(findTF(self.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_138_0 = self:GetMGData():GetRuntimeData("elements")
	local var_138_1 = self.scoreNum
	local var_138_2

	if var_138_0 and #var_138_0 > 0 then
		var_138_2 = var_138_0[1] or 0
	end

	setActive(findTF(self.settlementUI, "ad/new"), var_138_2 < var_138_1)

	if var_138_2 <= var_138_1 then
		var_138_2 = var_138_1

		self:StoreDataToServer({
			var_138_1
		})
	end

	setText(findTF(self.settlementUI, "ad/highText"), var_138_2)
	setText(findTF(self.settlementUI, "ad/currentText"), var_138_1)

	if self:getGameTimes() and self:getGameTimes() > 0 then
		self.sendSuccessFlag = true

		self:SendSuccess(0)
	end

	return
end

function GridGameReView:resumeGame()
	self.gameStop = false

	setActive(self.leaveUI, false)
	self:changeSpeed(1)
	self:timerStart()

	return
end

function GridGameReView:stopGame()
	self.gameStop = true

	self:timerStop()
	self:changeSpeed(0)

	return
end

function GridGameReView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GridGameReView.ON_BACK_PRESSED)
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

function GridGameReView:willExit()
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

return GridGameReView
