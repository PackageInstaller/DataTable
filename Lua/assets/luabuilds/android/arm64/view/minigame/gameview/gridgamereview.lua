local var_0_0 = class("GridGameReView", import("..BaseMiniGameView"))
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
local var_0_30 = 2
local var_0_31 = 3
local var_0_32 = {
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
local var_0_33 = {
	1,
	2,
	3
}
local var_0_34 = {}

;({}).rule = 1
;({})[1] = {}
;({})[2] = {
	id = 999,
	rule = 2
}
;({})[3] = {
	rule = 3
}

local var_0_35 = {
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
local var_0_36 = 0.5
local var_0_37 = 50
local var_0_38 = 3
local var_0_39 = 150
local var_0_40 = 1.5
local var_0_41 = 500
local var_0_42 = 260
local var_0_43 = 50
local var_0_44 = 3400
local var_0_45 = 5
local var_0_46 = 4
local var_0_48 = {
	{
		1,
		5
	}
}
local var_0_49 = {
	1,
	2,
	5
}
local var_0_50 = {
	1,
	2,
	5,
	3,
	4
}
local var_0_51 = {
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
local var_0_52 = {
	2,
	1,
	1,
	2,
	2,
	1,
	2
}
local var_0_54 = 7
local var_0_55 = Vector2(0, 0)
local var_0_56 = 0.07
local var_0_57 = 0.3
local var_0_58 = 0.5
local var_0_59 = 5
local var_0_63 = {
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
local var_0_64 = {
	"bg00",
	"bg01",
	"bg02",
	"bg03",
	"bg04"
}
local var_0_65 = {
	"bg10",
	"bg11",
	"bg12",
	"bg13",
	"bg14"
}
local var_0_66 = 0
local var_0_67 = 1
local var_0_68 = 2
local var_0_69 = 1
local var_0_70 = {}

;({
	rate = 0.05,
	source = "scene_background/bg00"
}).type = 1
;({})[1] = {
	rate = 0.05,
	source = "scene_background/bg00"
}
;({})[2] = {
	rate = 0.1,
	source = "scene_background/bg01",
	type = 1
}
;({})[3] = {
	rate = 0.2,
	source = "scene_background/bg02",
	type = 1
}
;({})[4] = {
	rate = 0.8,
	source = "scene_background/bg03",
	type = 1
}
;({})[5] = {
	rate = 0.05,
	source = "scene_background/bg10",
	type = 2
}
;({})[6] = {
	rate = 0.1,
	source = "scene_background/bg11",
	type = 2
}
;({})[7] = {
	rate = 0.2,
	source = "scene_background/bg12",
	type = 2
}
;({})[8] = {
	rate = 0.8,
	source = "scene_background/bg13",
	type = 2
}
;({})[9] = {
	rate = 1.2,
	source = "scene_front/bg04",
	type = 1
}
;({})[10] = {
	rate = 1.2,
	source = "scene_front/bg14",
	type = 2
}
;({})[11] = {
	rate = 1,
	source = "scene/rolePos",
	type = 0
}

local var_0_71 = {
	n_Move_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = ({
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
		}).n_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = ({
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
		}).n_Skill_1
	},
	n_Skill_2 = {
		sound_trigger = "guangjian",
		time = 0,
		anim_name = ({
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
		}).n_Skill_2,
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
		anim_name = ({
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
		}).n_Skill_3
	},
	n_Combine = {
		camera = true,
		sound_start = "bianshen",
		time = 0,
		anim_name = ({
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
		}).n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = ({
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
		}).n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = ({
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
		}).n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = ({
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
		}).n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).c_Atk,
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
		anim_name = ({
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
		}).c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = ({
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
		}).c_MoveL,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = ({
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
		}).c_Neutral
	}
}
local var_0_72 = {
	n_Move_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(500, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = ({
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
		}).n_MoveL,
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
		anim_name = ({
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
		}).n_Skill_1,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0)
		}
	},
	n_Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = ({
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
		}).n_Skill_2
	},
	n_Skill_3 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = ({
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
		}).n_Skill_3,
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
		anim_name = ({
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
		}).n_Combine
	},
	n_DMG = {
		time = 0,
		anim_name = ({
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
		}).n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = ({
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
		}).n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = ({
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
		}).n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).c_Atk,
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
		anim_name = ({
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
		}).c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = ({
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
		}).c_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = ({
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
		}).c_Neutral
	}
}
local var_0_73 = {
	n_Move_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	n_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).n_Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_Move_L = {
		time = 0,
		anim_name = ({
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
		}).n_MoveL,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = ({
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
		}).n_Skill_1
	},
	n_Skill_2 = {
		sound_trigger = "guangjian",
		time = 0,
		anim_name = ({
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
		}).n_Skill_2,
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
		anim_name = ({
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
		}).n_Skill_3
	},
	n_Combine = {
		sound_start = "bianshen",
		time = 0,
		camera = true,
		anim_name = ({
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
		}).n_Combine,
		camera_pos = Vector2(0, 0)
	},
	n_DMG = {
		time = 0,
		anim_name = ({
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
		}).n_DMG,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	n_DMG_S = {
		time = 0,
		anim_name = ({
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
		}).n_DMG
	},
	n_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).n_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	n_Neutral = {
		time = 0,
		anim_name = ({
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
		}).n_Neutral
	},
	c_Atk = {
		sound_trigger = "taosheng",
		time = 0,
		anim_name = ({
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
		}).c_Atk,
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
		anim_name = ({
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
		}).c_Skill_1
	},
	c_Dmg = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	c_Dmg_S = {
		time = 0,
		anim_name = ({
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
		}).c_Dmg
	},
	c_MoveL = {
		time = 0,
		anim_name = ({
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
		}).c_MoveL,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_MoveR = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(650, 0, 0)
		}
	},
	c_DMG_Back_R = {
		time = 0,
		anim_name = ({
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
		}).c_MoveR,
		move = {
			time = 0.2,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0)
		}
	},
	c_Neutral = {
		time = 0,
		anim_name = ({
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
		}).c_Neutral
	}
}
local var_0_74 = {
	Move_R = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveR,
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
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Move_L = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveL,
		move = {
			time = 0.4,
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Skill_1
	},
	Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Skill_2,
		over_offset = Vector2(115, 0)
	},
	DMG = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).DMG,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_Back_R = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_S = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).DMG
	},
	Neutral = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Neutral
	}
}
local var_0_75 = {
	Move_R = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveR,
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
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Atk,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(600, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Move_L = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveL,
		move = {
			time = 0.4,
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	Skill_1 = {
		sound_trigger = "jiguang",
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Skill_1
	},
	Skill_2 = {
		sound_trigger = "baozha2",
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Skill_2,
		over_offset = Vector2(264, 0)
	},
	DMG = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).DMG,
		move = {
			time = 0.3,
			distance_m = Vector3(-150, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_Back_R = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).MoveR,
		move = {
			time = 0.3,
			start = Vector2(0, 0),
			distance = Vector3(0, 0, 0),
			ease = LeanTweenType.easeOutCirc
		}
	},
	DMG_S = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).DMG
	},
	Neutral = {
		time = 0,
		anim_name = ({
			Neutral = "Neutral",
			MoveL = "MoveL",
			Skill_2 = "skill_2",
			Atk = "ATK",
			Skill_1 = "skill_1",
			DMG = "DMG",
			MoveR = "MoveR"
		}).Neutral
	}
}
local var_0_76 = {
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
					var_0_71.n_Skill_1
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
					var_0_71.n_Skill_2,
					var_0_71.n_Move_L
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
					var_0_71.n_Skill_3
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
					var_0_71.n_DMG,
					var_0_71.n_DMG_Back_R
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
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_71.n_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
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
					300,
					300
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
				name = "cDmg",
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
				name = "cDmgS",
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
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_71.c_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_71.c_DMG_Back_R
				}
			}
		},
		actions = var_0_71
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
					var_0_72.n_Atk,
					var_0_72.n_Move_L
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
					var_0_72.n_Move_R,
					var_0_72.n_Skill_1,
					var_0_72.n_Move_L
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
					var_0_72.n_Skill_2
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
					var_0_72.n_Skill_3,
					var_0_72.n_Move_L
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
					var_0_72.n_DMG,
					var_0_72.n_DMG_Back_R
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
					var_0_72.n_DMG_S
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
					var_0_72.n_DMG_Back_R
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_72.n_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_72.n_DMG_Back_R
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
					var_0_72.n_Combine
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
					var_0_72.c_Atk,
					var_0_72.c_MoveL
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
					var_0_72.c_Skill_1
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
					var_0_72.c_Skill_1
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
					var_0_72.c_Skill_1
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
					var_0_72.c_Dmg,
					var_0_72.c_DMG_Back_R
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
					var_0_72.c_Dmg_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_72.c_DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_72.c_DMG_Back_R
				}
			}
		},
		actions = var_0_72
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
					var_0_74.Atk,
					var_0_74.Move_L
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
					var_0_74.Skill_1
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
					var_0_74.Move_R,
					var_0_74.Skill_2,
					var_0_74.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_74.DMG,
					var_0_74.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_74.DMG_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_74.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_74.DMG_Back_R
				}
			}
		},
		actions = var_0_74
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
					var_0_75.Atk,
					var_0_75.Move_L
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
					var_0_75.Skill_1
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
					var_0_75.Skill_2,
					var_0_75.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_75.DMG,
					var_0_75.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_75.DMG_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_75.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_75.DMG_Back_R
				}
			}
		},
		actions = var_0_75
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
					var_0_73.n_Atk,
					var_0_73.n_Move_L
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
					var_0_73.n_Skill_1
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
					var_0_73.n_Skill_2,
					var_0_73.n_Move_L
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
					var_0_73.n_Skill_3
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
					var_0_73.n_DMG,
					var_0_73.n_DMG_Back_R
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
					var_0_73.n_DMG_S
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
					var_0_73.n_DMG_Back_R
				},
				anim_init_pos = Vector2(586, 471)
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_73.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_73.DMG_Back_R
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
					var_0_73.n_Combine
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
					var_0_73.c_Atk,
					var_0_73.c_MoveL
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
					var_0_73.c_Skill_1
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
					var_0_73.c_Skill_1
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
					var_0_73.c_Skill_1
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
					var_0_73.c_Dmg,
					var_0_73.c_DMG_Back_R
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
					var_0_73.c_Dmg_S
				}
			},
			{
				dmg_index = 3,
				name = "DMGN",
				special_time = false,
				actions = {
					var_0_73.DMG
				}
			},
			{
				name = "DMG_BACK",
				special_time = false,
				dmg_back = true,
				actions = {
					var_0_73.DMG_Back_R
				}
			}
		},
		actions = var_0_73,
		anim_init_pos = Vector2(586, 411)
	}
}

local function var_0_77(arg_1_0, arg_1_1)
	({
		ctor = function(arg_2_0)
			arg_2_0._boxTf = arg_1_0
			arg_2_0._event = arg_1_1

			arg_2_0._event:bind(var_0_15, function()
				if var_0_23.power_grid and var_0_23.power_grid > 0 and var_0_34[var_0_23.power_grid] then
					local var_3_0 = var_0_34[var_0_23.power_grid].rule

					if var_0_34[var_0_23.power_grid].id then
						local var_3_1 = var_0_34[var_0_23.power_grid].id or var_0_23.power_grid

						table.insert(arg_2_0.ruleGridList, {
							id = var_3_1,
							rule = var_3_0
						})

						return
					end
				end
			end)

			arg_2_0._gridEffect = findTF(arg_2_0._boxTf, "effectGrid")
			arg_2_0._content = findTF(arg_2_0._boxTf, "viewport/content")
			arg_2_0.tplGrid = findTF(arg_1_0, "tplGrid")

			setActive(arg_2_0.tplGrid, false)

			arg_2_0.grids = {}
			arg_2_0.effects = {}
			arg_2_0.combo = 0
			arg_2_0.ruleGridList = {}

			for iter_2_0 = 1, var_0_24 do
				local var_2_0 = tf(instantiate(arg_2_0._gridEffect))

				setParent(var_2_0, arg_2_0._content)
				setActive(var_2_0, false)

				var_2_0.anchoredPosition = Vector2(var_0_26.x * iter_2_0 - var_0_26.x / 2, var_0_26.y / 2)

				table.insert(arg_2_0.effects, var_2_0)
			end

			return
		end,
		start = function(arg_4_0)
			arg_4_0.comboCheck = false

			arg_4_0:initGrids(false)

			for iter_4_0 = 1, #arg_4_0.effects do
				setActive(arg_4_0.effects[iter_4_0], false)
			end

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.takeAwayTime and arg_5_0.takeAwayTime > 0 then
				arg_5_0.takeAwayTime = arg_5_0.takeAwayTime - Time.deltaTime

				return
			end

			arg_5_0.gridCreateIndex = 1

			local var_5_0 = false

			for iter_5_0 = 1, #arg_5_0.grids do
				local var_5_1 = iter_5_0

				if not arg_5_0.grids[iter_5_0].moveAble then
					var_5_0 = var_5_0 or true

					local var_5_2 = (iter_5_0 - 1) * var_0_26.x

					if (iter_5_0 - 1) * var_0_26.x < arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(arg_5_0.grids[iter_5_0].tf.anchoredPosition.x - arg_5_0.grids[iter_5_0].speed * Time.deltaTime, 0)

						if arg_5_0.grids[iter_5_0].speed < var_0_27 then
							arg_5_0.grids[iter_5_0].speed = arg_5_0.grids[iter_5_0].speed + var_0_29
						end
					end

					if var_5_2 >= arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].speed = 0
						arg_5_0.grids[iter_5_0].moveAble = true

						if var_5_2 > arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
							arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(var_5_2, 0)
						end
					end
				end

				if not arg_5_0.grids[iter_5_0].eventAble then
					GetComponent(arg_5_0.grids[iter_5_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
						if arg_5_0.comboCheck == false then
							local var_6_0, var_6_1 = arg_5_0:triggerDownGrid(var_5_1)

							if #var_6_0 >= 2 then
								arg_5_0.comboCheck = true

								local var_6_2 = arg_5_0:getGridDouble(var_6_0)

								arg_5_0:takeAwayGrid(var_6_0)
								arg_5_0:insertGrids()

								for iter_6_0 = 1, #var_6_1 do
									arg_5_0._event:emit(var_0_14, {
										series = var_6_1[iter_6_0].count,
										combo = arg_5_0.combo,
										index = var_6_1[iter_6_0].index,
										double = var_6_2
									})
								end

								arg_5_0.combo = arg_5_0.combo + 1
							else
								arg_5_0.comboCheck = true

								arg_5_0:takeAwayGrid({
									var_5_1
								})
								arg_5_0:insertGrids()
							end
						end

						return
					end)

					arg_5_0.grids[iter_5_0].eventAble = true
				end
			end

			if not var_5_0 and arg_5_0.comboCheck then
				local var_5_3 = arg_5_0:getSeriesGrids()

				if #var_5_3 > 0 then
					for iter_5_1 = 1, #var_5_3 do
						for iter_5_2 = 1, #var_5_3[iter_5_1].series do
							table.insert({}, var_5_3[iter_5_1].series[iter_5_2])
						end

						arg_5_0._event:emit(var_0_14, {
							series = #var_5_3[iter_5_1].series,
							combo = arg_5_0.combo,
							index = var_5_3[iter_5_1].index,
							double = arg_5_0:getGridDouble(var_5_3[iter_5_1].series)
						})
					end

					arg_5_0:clearGridSeriesAble()
					arg_5_0:takeAwayGrid({})
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
				if arg_7_0.grids[iter_7_0] and arg_7_0.grids[iter_7_0].rule == var_0_31 then
					return true
				end
			end

			return false
		end,
		clear = function(arg_8_0)
			for iter_8_0 = 1, #arg_8_0.grids do
				if arg_8_0.grids[iter_8_0].tf then
					destroy(arg_8_0.grids[iter_8_0].tf)
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
			local var_10_2 = {}
			local var_10_4
			local var_10_5 = 0

			for iter_10_0 = 1, #arg_10_0.grids do
				local var_10_6

				if var_10_4 and var_10_4 == arg_10_0.grids[iter_10_0].index then
					var_10_5 = var_10_5 + 1
				elseif arg_10_0.grids[iter_10_0].rule == var_0_30 then
					var_10_5 = var_10_5 + 1
				elseif false then
					var_10_4 = arg_10_0.grids[iter_10_0].index
					var_10_6 = false
				else
					if var_10_5 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
						table.insert({}, {
							series = var_10_2,
							index = var_10_4
						})

						var_10_4 = arg_10_0.grids[iter_10_0].index
						var_10_5 = 1
					end

					var_10_6 = arg_10_0.grids[iter_10_0].rule == var_0_30
					var_10_2 = {}
				end

				table.insert(var_10_2, iter_10_0)

				if iter_10_0 == #arg_10_0.grids and #var_10_2 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
					table.insert({}, {
						series = var_10_2,
						index = var_10_4
					})

					var_10_2 = {}
				end
			end

			return {}
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
			for iter_12_0 = 1, var_0_24 - #arg_12_0.grids do
				table.insert(arg_12_0.grids, (arg_12_0:createGridData()))
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
				arg_13_0.grids[iter_13_0].speed = var_0_28
			end

			return
		end,
		takeAwayGrid = function(arg_14_0, arg_14_1)
			table.sort(arg_14_1, function(arg_15_0, arg_15_1)
				return arg_15_0 <= arg_15_1
			end)

			arg_14_0.takeAwayTime = var_0_25

			if arg_14_1[1] - 1 > 0 then
				arg_14_0.grids[arg_14_1[1] - 1].seriesAble = true
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

			for iter_14_0 = #arg_14_1, 1, -1 do
				table.insert({}, table.remove(arg_14_0.grids, arg_14_1[iter_14_0]))
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], false)
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], true)
			end

			for iter_14_1 = 1, #{} do
				destroy(({})[iter_14_1].tf)

				;({})[iter_14_1] = 0
			end

			return
		end,
		triggerDownGrid = function(arg_16_0, arg_16_1)
			local var_16_0
			local var_16_1 = {}
			local var_16_2 = {}

			if arg_16_0.grids[arg_16_1].rule ~= var_0_30 then
				var_16_1 = {
					arg_16_1
				}
				var_16_0 = arg_16_0.grids[arg_16_1].index
			end

			if not arg_16_0.grids[arg_16_1] then
				return var_16_1, {}
			end

			if arg_16_0.grids[arg_16_1].rule == var_0_30 then
				local var_16_3

				for iter_16_0 = arg_16_1 - 1, 1, -1 do
					local var_16_4

					if true then
						if arg_16_0.grids[iter_16_0].rule == var_0_30 then
							table.insert({}, iter_16_0)
						elseif not var_16_3 then
							var_16_3 = arg_16_0.grids[iter_16_0].index

							table.insert({}, iter_16_0)
						elseif var_16_3 == arg_16_0.grids[iter_16_0].index then
							table.insert({}, iter_16_0)
						else
							var_16_4 = false
						end
					end
				end

				local var_16_5
				local var_16_6 = true

				for iter_16_1 = arg_16_1 + 1, #arg_16_0.grids do
					if var_16_6 then
						if arg_16_0.grids[iter_16_1].rule == var_0_30 then
							table.insert({}, iter_16_1)
						elseif not var_16_5 then
							var_16_5 = arg_16_0.grids[iter_16_1].index

							table.insert({}, iter_16_1)
						elseif var_16_5 == arg_16_0.grids[iter_16_1].index then
							table.insert({}, iter_16_1)
						else
							var_16_6 = false
						end
					end
				end

				if var_16_3 == nil and var_16_5 == nil then
					for iter_16_2 = 1, #arg_16_0.grids do
						table.insert(var_16_1, iter_16_2)
					end
				elseif var_16_3 == var_16_5 then
					for iter_16_3 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_3])
					end

					table.insert(var_16_1, arg_16_1)

					for iter_16_4 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_4])
					end

					var_16_0 = var_16_3
				else
					if #{} >= #{} then
						for iter_16_5 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_5])
						end

						var_16_0 = var_16_3
					else
						for iter_16_6 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_6])
						end

						var_16_0 = var_16_5
					end

					table.insert(var_16_1, arg_16_1)
				end

				table.insert(var_16_2, {
					index = var_16_0,
					count = #var_16_1
				})
			elseif arg_16_0.grids[arg_16_1].rule == var_0 then
				local var_16_10
				local var_16_11 = true

				for iter_16_7 = arg_16_1 - 1, 1, -1 do
					if var_16_11 then
						if arg_16_0.grids[iter_16_7].rule == var_0_30 then
							table.insert({}, iter_16_7)
						elseif not var_16_10 then
							var_16_10 = arg_16_0.grids[iter_16_7].index

							table.insert({}, iter_16_7)
						elseif var_16_10 == arg_16_0.grids[iter_16_7].index then
							table.insert({}, iter_16_7)
						else
							var_16_11 = false
						end
					end
				end

				local var_16_12

				for iter_16_8 = arg_16_1 + 1, #arg_16_0.grids do
					local var_16_13

					if true then
						if arg_16_0.grids[iter_16_8].rule == var_0_30 then
							table.insert({}, iter_16_8)
						elseif not var_16_12 then
							var_16_12 = arg_16_0.grids[iter_16_8].index

							table.insert({}, iter_16_8)
						elseif var_16_12 == arg_16_0.grids[iter_16_8].index then
							table.insert({}, iter_16_8)
						else
							var_16_13 = false
						end
					end
				end

				table.insert(var_16_2, {
					index = var_16_10,
					count = #{} + 1
				})
				table.insert(var_16_2, {
					index = var_16_12,
					count = #{} + 1
				})

				for iter_16_9 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_9])
				end

				for iter_16_10 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_10])
				end
			else
				for iter_16_11 = arg_16_1 - 1, 1, -1 do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_11]) then
						table.insert(var_16_1, iter_16_11)
					else
						break
					end
				end

				for iter_16_12 = arg_16_1 + 1, #arg_16_0.grids do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_12]) then
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
			elseif arg_18_2.rule == var_0_30 then
				return true
			end

			return false
		end,
		initGrids = function(arg_19_0, arg_19_1)
			arg_19_0:clear()

			for iter_19_0 = 1, var_0_24 do
				table.insert(arg_19_0.grids, (arg_19_0:createGridData()))
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
				local var_20_0 = arg_20_0.grids[iter_20_0]

				if not arg_20_0.grids[iter_20_0].tf then
					local var_20_1 = tf(instantiate(arg_20_0.tplGrid))

					SetParent(var_20_1, arg_20_0._content)
					setActive(var_20_1, true)
					setActive(findTF(var_20_1, var_20_0.name), true)

					local var_20_2 = arg_20_1 and (var_0_24 + arg_20_0.gridCreateIndex - 1) * var_0_26.x or (arg_20_0.gridCreateIndex - 1) * var_0_26.x

					if var_20_0.rule == var_0_30 then
						-- block empty
					end

					if var_20_0.rule ~= var_0_30 then
						setActive(findTF(var_20_1, var_20_0.name .. "/boom"), var_20_0.rule == var_0)
						setActive(findTF(var_20_1, var_20_0.name .. "/thunder"), var_20_0.rule == var_0_31)
					end

					var_20_1.anchoredPosition = Vector2(var_20_2, 0)
					arg_20_0.gridCreateIndex = arg_20_0.gridCreateIndex + 1
					var_20_0.tf = var_20_1
				end
			end

			return
		end,
		createGridData = function(arg_21_0)
			local var_21_0
			local var_21_3

			if #arg_21_0.ruleGridList > 0 then
				local var_21_4 = table.remove(arg_21_0.ruleGridList, 1)

				var_21_0 = var_21_4.id
				var_21_3 = var_21_4.rule
			else
				var_21_0 = var_0_33[math.random(1, #var_0_33)]
			end

			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).name = var_0_32[var_21_0].name
			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).rule = var_21_3

			return {
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}
		end,
		checkGridsMatchAble = function(arg_22_0)
			return true
		end
	}).ctor({
		ctor = function(arg_2_0)
			arg_2_0._boxTf = arg_1_0
			arg_2_0._event = arg_1_1

			arg_2_0._event:bind(var_0_15, function()
				if var_0_23.power_grid and var_0_23.power_grid > 0 and var_0_34[var_0_23.power_grid] then
					local var_3_0 = var_0_34[var_0_23.power_grid].rule

					if var_0_34[var_0_23.power_grid].id then
						local var_3_1 = var_0_34[var_0_23.power_grid].id or var_0_23.power_grid

						table.insert(arg_2_0.ruleGridList, {
							id = var_3_1,
							rule = var_3_0
						})

						return
					end
				end
			end)

			arg_2_0._gridEffect = findTF(arg_2_0._boxTf, "effectGrid")
			arg_2_0._content = findTF(arg_2_0._boxTf, "viewport/content")
			arg_2_0.tplGrid = findTF(arg_1_0, "tplGrid")

			setActive(arg_2_0.tplGrid, false)

			arg_2_0.grids = {}
			arg_2_0.effects = {}
			arg_2_0.combo = 0
			arg_2_0.ruleGridList = {}

			for iter_2_0 = 1, var_0_24 do
				local var_2_0 = tf(instantiate(arg_2_0._gridEffect))

				setParent(var_2_0, arg_2_0._content)
				setActive(var_2_0, false)

				var_2_0.anchoredPosition = Vector2(var_0_26.x * iter_2_0 - var_0_26.x / 2, var_0_26.y / 2)

				table.insert(arg_2_0.effects, var_2_0)
			end

			return
		end,
		start = function(arg_4_0)
			arg_4_0.comboCheck = false

			arg_4_0:initGrids(false)

			for iter_4_0 = 1, #arg_4_0.effects do
				setActive(arg_4_0.effects[iter_4_0], false)
			end

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.takeAwayTime and arg_5_0.takeAwayTime > 0 then
				arg_5_0.takeAwayTime = arg_5_0.takeAwayTime - Time.deltaTime

				return
			end

			arg_5_0.gridCreateIndex = 1

			local var_5_0 = false

			for iter_5_0 = 1, #arg_5_0.grids do
				local var_5_1 = iter_5_0

				if not arg_5_0.grids[iter_5_0].moveAble then
					var_5_0 = var_5_0 or true

					local var_5_2 = (iter_5_0 - 1) * var_0_26.x

					if (iter_5_0 - 1) * var_0_26.x < arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(arg_5_0.grids[iter_5_0].tf.anchoredPosition.x - arg_5_0.grids[iter_5_0].speed * Time.deltaTime, 0)

						if arg_5_0.grids[iter_5_0].speed < var_0_27 then
							arg_5_0.grids[iter_5_0].speed = arg_5_0.grids[iter_5_0].speed + var_0_29
						end
					end

					if var_5_2 >= arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].speed = 0
						arg_5_0.grids[iter_5_0].moveAble = true

						if var_5_2 > arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
							arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(var_5_2, 0)
						end
					end
				end

				if not arg_5_0.grids[iter_5_0].eventAble then
					GetComponent(arg_5_0.grids[iter_5_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
						if arg_5_0.comboCheck == false then
							local var_6_0, var_6_1 = arg_5_0:triggerDownGrid(var_5_1)

							if #var_6_0 >= 2 then
								arg_5_0.comboCheck = true

								local var_6_2 = arg_5_0:getGridDouble(var_6_0)

								arg_5_0:takeAwayGrid(var_6_0)
								arg_5_0:insertGrids()

								for iter_6_0 = 1, #var_6_1 do
									arg_5_0._event:emit(var_0_14, {
										series = var_6_1[iter_6_0].count,
										combo = arg_5_0.combo,
										index = var_6_1[iter_6_0].index,
										double = var_6_2
									})
								end

								arg_5_0.combo = arg_5_0.combo + 1
							else
								arg_5_0.comboCheck = true

								arg_5_0:takeAwayGrid({
									var_5_1
								})
								arg_5_0:insertGrids()
							end
						end

						return
					end)

					arg_5_0.grids[iter_5_0].eventAble = true
				end
			end

			if not var_5_0 and arg_5_0.comboCheck then
				local var_5_3 = arg_5_0:getSeriesGrids()

				if #var_5_3 > 0 then
					for iter_5_1 = 1, #var_5_3 do
						for iter_5_2 = 1, #var_5_3[iter_5_1].series do
							table.insert({}, var_5_3[iter_5_1].series[iter_5_2])
						end

						arg_5_0._event:emit(var_0_14, {
							series = #var_5_3[iter_5_1].series,
							combo = arg_5_0.combo,
							index = var_5_3[iter_5_1].index,
							double = arg_5_0:getGridDouble(var_5_3[iter_5_1].series)
						})
					end

					arg_5_0:clearGridSeriesAble()
					arg_5_0:takeAwayGrid({})
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
				if arg_7_0.grids[iter_7_0] and arg_7_0.grids[iter_7_0].rule == var_0_31 then
					return true
				end
			end

			return false
		end,
		clear = function(arg_8_0)
			for iter_8_0 = 1, #arg_8_0.grids do
				if arg_8_0.grids[iter_8_0].tf then
					destroy(arg_8_0.grids[iter_8_0].tf)
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
			local var_10_2 = {}
			local var_10_4
			local var_10_5 = 0

			for iter_10_0 = 1, #arg_10_0.grids do
				local var_10_6

				if var_10_4 and var_10_4 == arg_10_0.grids[iter_10_0].index then
					var_10_5 = var_10_5 + 1
				elseif arg_10_0.grids[iter_10_0].rule == var_0_30 then
					var_10_5 = var_10_5 + 1
				elseif false then
					var_10_4 = arg_10_0.grids[iter_10_0].index
					var_10_6 = false
				else
					if var_10_5 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
						table.insert({}, {
							series = var_10_2,
							index = var_10_4
						})

						var_10_4 = arg_10_0.grids[iter_10_0].index
						var_10_5 = 1
					end

					var_10_6 = arg_10_0.grids[iter_10_0].rule == var_0_30
					var_10_2 = {}
				end

				table.insert(var_10_2, iter_10_0)

				if iter_10_0 == #arg_10_0.grids and #var_10_2 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
					table.insert({}, {
						series = var_10_2,
						index = var_10_4
					})

					var_10_2 = {}
				end
			end

			return {}
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
			for iter_12_0 = 1, var_0_24 - #arg_12_0.grids do
				table.insert(arg_12_0.grids, (arg_12_0:createGridData()))
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
				arg_13_0.grids[iter_13_0].speed = var_0_28
			end

			return
		end,
		takeAwayGrid = function(arg_14_0, arg_14_1)
			table.sort(arg_14_1, function(arg_15_0, arg_15_1)
				return arg_15_0 <= arg_15_1
			end)

			arg_14_0.takeAwayTime = var_0_25

			if arg_14_1[1] - 1 > 0 then
				arg_14_0.grids[arg_14_1[1] - 1].seriesAble = true
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

			for iter_14_0 = #arg_14_1, 1, -1 do
				table.insert({}, table.remove(arg_14_0.grids, arg_14_1[iter_14_0]))
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], false)
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], true)
			end

			for iter_14_1 = 1, #{} do
				destroy(({})[iter_14_1].tf)

				;({})[iter_14_1] = 0
			end

			return
		end,
		triggerDownGrid = function(arg_16_0, arg_16_1)
			local var_16_0
			local var_16_1 = {}
			local var_16_2 = {}

			if arg_16_0.grids[arg_16_1].rule ~= var_0_30 then
				var_16_1 = {
					arg_16_1
				}
				var_16_0 = arg_16_0.grids[arg_16_1].index
			end

			if not arg_16_0.grids[arg_16_1] then
				return var_16_1, {}
			end

			if arg_16_0.grids[arg_16_1].rule == var_0_30 then
				local var_16_3

				for iter_16_0 = arg_16_1 - 1, 1, -1 do
					local var_16_4

					if true then
						if arg_16_0.grids[iter_16_0].rule == var_0_30 then
							table.insert({}, iter_16_0)
						elseif not var_16_3 then
							var_16_3 = arg_16_0.grids[iter_16_0].index

							table.insert({}, iter_16_0)
						elseif var_16_3 == arg_16_0.grids[iter_16_0].index then
							table.insert({}, iter_16_0)
						else
							var_16_4 = false
						end
					end
				end

				local var_16_5
				local var_16_6 = true

				for iter_16_1 = arg_16_1 + 1, #arg_16_0.grids do
					if var_16_6 then
						if arg_16_0.grids[iter_16_1].rule == var_0_30 then
							table.insert({}, iter_16_1)
						elseif not var_16_5 then
							var_16_5 = arg_16_0.grids[iter_16_1].index

							table.insert({}, iter_16_1)
						elseif var_16_5 == arg_16_0.grids[iter_16_1].index then
							table.insert({}, iter_16_1)
						else
							var_16_6 = false
						end
					end
				end

				if var_16_3 == nil and var_16_5 == nil then
					for iter_16_2 = 1, #arg_16_0.grids do
						table.insert(var_16_1, iter_16_2)
					end
				elseif var_16_3 == var_16_5 then
					for iter_16_3 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_3])
					end

					table.insert(var_16_1, arg_16_1)

					for iter_16_4 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_4])
					end

					var_16_0 = var_16_3
				else
					if #{} >= #{} then
						for iter_16_5 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_5])
						end

						var_16_0 = var_16_3
					else
						for iter_16_6 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_6])
						end

						var_16_0 = var_16_5
					end

					table.insert(var_16_1, arg_16_1)
				end

				table.insert(var_16_2, {
					index = var_16_0,
					count = #var_16_1
				})
			elseif arg_16_0.grids[arg_16_1].rule == var_0 then
				local var_16_10
				local var_16_11 = true

				for iter_16_7 = arg_16_1 - 1, 1, -1 do
					if var_16_11 then
						if arg_16_0.grids[iter_16_7].rule == var_0_30 then
							table.insert({}, iter_16_7)
						elseif not var_16_10 then
							var_16_10 = arg_16_0.grids[iter_16_7].index

							table.insert({}, iter_16_7)
						elseif var_16_10 == arg_16_0.grids[iter_16_7].index then
							table.insert({}, iter_16_7)
						else
							var_16_11 = false
						end
					end
				end

				local var_16_12

				for iter_16_8 = arg_16_1 + 1, #arg_16_0.grids do
					local var_16_13

					if true then
						if arg_16_0.grids[iter_16_8].rule == var_0_30 then
							table.insert({}, iter_16_8)
						elseif not var_16_12 then
							var_16_12 = arg_16_0.grids[iter_16_8].index

							table.insert({}, iter_16_8)
						elseif var_16_12 == arg_16_0.grids[iter_16_8].index then
							table.insert({}, iter_16_8)
						else
							var_16_13 = false
						end
					end
				end

				table.insert(var_16_2, {
					index = var_16_10,
					count = #{} + 1
				})
				table.insert(var_16_2, {
					index = var_16_12,
					count = #{} + 1
				})

				for iter_16_9 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_9])
				end

				for iter_16_10 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_10])
				end
			else
				for iter_16_11 = arg_16_1 - 1, 1, -1 do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_11]) then
						table.insert(var_16_1, iter_16_11)
					else
						break
					end
				end

				for iter_16_12 = arg_16_1 + 1, #arg_16_0.grids do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_12]) then
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
			elseif arg_18_2.rule == var_0_30 then
				return true
			end

			return false
		end,
		initGrids = function(arg_19_0, arg_19_1)
			arg_19_0:clear()

			for iter_19_0 = 1, var_0_24 do
				table.insert(arg_19_0.grids, (arg_19_0:createGridData()))
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
				local var_20_0 = arg_20_0.grids[iter_20_0]

				if not arg_20_0.grids[iter_20_0].tf then
					local var_20_1 = tf(instantiate(arg_20_0.tplGrid))

					SetParent(var_20_1, arg_20_0._content)
					setActive(var_20_1, true)
					setActive(findTF(var_20_1, var_20_0.name), true)

					local var_20_2 = arg_20_1 and (var_0_24 + arg_20_0.gridCreateIndex - 1) * var_0_26.x or (arg_20_0.gridCreateIndex - 1) * var_0_26.x

					if var_20_0.rule == var_0_30 then
						-- block empty
					end

					if var_20_0.rule ~= var_0_30 then
						setActive(findTF(var_20_1, var_20_0.name .. "/boom"), var_20_0.rule == var_0)
						setActive(findTF(var_20_1, var_20_0.name .. "/thunder"), var_20_0.rule == var_0_31)
					end

					var_20_1.anchoredPosition = Vector2(var_20_2, 0)
					arg_20_0.gridCreateIndex = arg_20_0.gridCreateIndex + 1
					var_20_0.tf = var_20_1
				end
			end

			return
		end,
		createGridData = function(arg_21_0)
			local var_21_0
			local var_21_3

			if #arg_21_0.ruleGridList > 0 then
				local var_21_4 = table.remove(arg_21_0.ruleGridList, 1)

				var_21_0 = var_21_4.id
				var_21_3 = var_21_4.rule
			else
				var_21_0 = var_0_33[math.random(1, #var_0_33)]
			end

			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).name = var_0_32[var_21_0].name
			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).rule = var_21_3

			return {
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}
		end,
		checkGridsMatchAble = function(arg_22_0)
			return true
		end
	})

	return {
		ctor = function(arg_2_0)
			arg_2_0._boxTf = arg_1_0
			arg_2_0._event = arg_1_1

			arg_2_0._event:bind(var_0_15, function()
				if var_0_23.power_grid and var_0_23.power_grid > 0 and var_0_34[var_0_23.power_grid] then
					local var_3_0 = var_0_34[var_0_23.power_grid].rule

					if var_0_34[var_0_23.power_grid].id then
						local var_3_1 = var_0_34[var_0_23.power_grid].id or var_0_23.power_grid

						table.insert(arg_2_0.ruleGridList, {
							id = var_3_1,
							rule = var_3_0
						})

						return
					end
				end
			end)

			arg_2_0._gridEffect = findTF(arg_2_0._boxTf, "effectGrid")
			arg_2_0._content = findTF(arg_2_0._boxTf, "viewport/content")
			arg_2_0.tplGrid = findTF(arg_1_0, "tplGrid")

			setActive(arg_2_0.tplGrid, false)

			arg_2_0.grids = {}
			arg_2_0.effects = {}
			arg_2_0.combo = 0
			arg_2_0.ruleGridList = {}

			for iter_2_0 = 1, var_0_24 do
				local var_2_0 = tf(instantiate(arg_2_0._gridEffect))

				setParent(var_2_0, arg_2_0._content)
				setActive(var_2_0, false)

				var_2_0.anchoredPosition = Vector2(var_0_26.x * iter_2_0 - var_0_26.x / 2, var_0_26.y / 2)

				table.insert(arg_2_0.effects, var_2_0)
			end

			return
		end,
		start = function(arg_4_0)
			arg_4_0.comboCheck = false

			arg_4_0:initGrids(false)

			for iter_4_0 = 1, #arg_4_0.effects do
				setActive(arg_4_0.effects[iter_4_0], false)
			end

			return
		end,
		step = function(arg_5_0)
			if arg_5_0.takeAwayTime and arg_5_0.takeAwayTime > 0 then
				arg_5_0.takeAwayTime = arg_5_0.takeAwayTime - Time.deltaTime

				return
			end

			arg_5_0.gridCreateIndex = 1

			local var_5_0 = false

			for iter_5_0 = 1, #arg_5_0.grids do
				local var_5_1 = iter_5_0

				if not arg_5_0.grids[iter_5_0].moveAble then
					var_5_0 = var_5_0 or true

					local var_5_2 = (iter_5_0 - 1) * var_0_26.x

					if (iter_5_0 - 1) * var_0_26.x < arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(arg_5_0.grids[iter_5_0].tf.anchoredPosition.x - arg_5_0.grids[iter_5_0].speed * Time.deltaTime, 0)

						if arg_5_0.grids[iter_5_0].speed < var_0_27 then
							arg_5_0.grids[iter_5_0].speed = arg_5_0.grids[iter_5_0].speed + var_0_29
						end
					end

					if var_5_2 >= arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
						arg_5_0.grids[iter_5_0].speed = 0
						arg_5_0.grids[iter_5_0].moveAble = true

						if var_5_2 > arg_5_0.grids[iter_5_0].tf.anchoredPosition.x then
							arg_5_0.grids[iter_5_0].tf.anchoredPosition = Vector2(var_5_2, 0)
						end
					end
				end

				if not arg_5_0.grids[iter_5_0].eventAble then
					GetComponent(arg_5_0.grids[iter_5_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
						if arg_5_0.comboCheck == false then
							local var_6_0, var_6_1 = arg_5_0:triggerDownGrid(var_5_1)

							if #var_6_0 >= 2 then
								arg_5_0.comboCheck = true

								local var_6_2 = arg_5_0:getGridDouble(var_6_0)

								arg_5_0:takeAwayGrid(var_6_0)
								arg_5_0:insertGrids()

								for iter_6_0 = 1, #var_6_1 do
									arg_5_0._event:emit(var_0_14, {
										series = var_6_1[iter_6_0].count,
										combo = arg_5_0.combo,
										index = var_6_1[iter_6_0].index,
										double = var_6_2
									})
								end

								arg_5_0.combo = arg_5_0.combo + 1
							else
								arg_5_0.comboCheck = true

								arg_5_0:takeAwayGrid({
									var_5_1
								})
								arg_5_0:insertGrids()
							end
						end

						return
					end)

					arg_5_0.grids[iter_5_0].eventAble = true
				end
			end

			if not var_5_0 and arg_5_0.comboCheck then
				local var_5_3 = arg_5_0:getSeriesGrids()

				if #var_5_3 > 0 then
					for iter_5_1 = 1, #var_5_3 do
						for iter_5_2 = 1, #var_5_3[iter_5_1].series do
							table.insert({}, var_5_3[iter_5_1].series[iter_5_2])
						end

						arg_5_0._event:emit(var_0_14, {
							series = #var_5_3[iter_5_1].series,
							combo = arg_5_0.combo,
							index = var_5_3[iter_5_1].index,
							double = arg_5_0:getGridDouble(var_5_3[iter_5_1].series)
						})
					end

					arg_5_0:clearGridSeriesAble()
					arg_5_0:takeAwayGrid({})
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
				if arg_7_0.grids[iter_7_0] and arg_7_0.grids[iter_7_0].rule == var_0_31 then
					return true
				end
			end

			return false
		end,
		clear = function(arg_8_0)
			for iter_8_0 = 1, #arg_8_0.grids do
				if arg_8_0.grids[iter_8_0].tf then
					destroy(arg_8_0.grids[iter_8_0].tf)
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
			local var_10_2 = {}
			local var_10_4
			local var_10_5 = 0

			for iter_10_0 = 1, #arg_10_0.grids do
				local var_10_6

				if var_10_4 and var_10_4 == arg_10_0.grids[iter_10_0].index then
					var_10_5 = var_10_5 + 1
				elseif arg_10_0.grids[iter_10_0].rule == var_0_30 then
					var_10_5 = var_10_5 + 1
				elseif false then
					var_10_4 = arg_10_0.grids[iter_10_0].index
					var_10_6 = false
				else
					if var_10_5 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
						table.insert({}, {
							series = var_10_2,
							index = var_10_4
						})

						var_10_4 = arg_10_0.grids[iter_10_0].index
						var_10_5 = 1
					end

					var_10_6 = arg_10_0.grids[iter_10_0].rule == var_0_30
					var_10_2 = {}
				end

				table.insert(var_10_2, iter_10_0)

				if iter_10_0 == #arg_10_0.grids and #var_10_2 >= 3 and arg_10_0:checkGridComboFlag(var_10_2) then
					table.insert({}, {
						series = var_10_2,
						index = var_10_4
					})

					var_10_2 = {}
				end
			end

			return {}
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
			for iter_12_0 = 1, var_0_24 - #arg_12_0.grids do
				table.insert(arg_12_0.grids, (arg_12_0:createGridData()))
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
				arg_13_0.grids[iter_13_0].speed = var_0_28
			end

			return
		end,
		takeAwayGrid = function(arg_14_0, arg_14_1)
			table.sort(arg_14_1, function(arg_15_0, arg_15_1)
				return arg_15_0 <= arg_15_1
			end)

			arg_14_0.takeAwayTime = var_0_25

			if arg_14_1[1] - 1 > 0 then
				arg_14_0.grids[arg_14_1[1] - 1].seriesAble = true
			end

			pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

			for iter_14_0 = #arg_14_1, 1, -1 do
				table.insert({}, table.remove(arg_14_0.grids, arg_14_1[iter_14_0]))
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], false)
				setActive(arg_14_0.effects[arg_14_1[iter_14_0]], true)
			end

			for iter_14_1 = 1, #{} do
				destroy(({})[iter_14_1].tf)

				;({})[iter_14_1] = 0
			end

			return
		end,
		triggerDownGrid = function(arg_16_0, arg_16_1)
			local var_16_0
			local var_16_1 = {}
			local var_16_2 = {}

			if arg_16_0.grids[arg_16_1].rule ~= var_0_30 then
				var_16_1 = {
					arg_16_1
				}
				var_16_0 = arg_16_0.grids[arg_16_1].index
			end

			if not arg_16_0.grids[arg_16_1] then
				return var_16_1, {}
			end

			if arg_16_0.grids[arg_16_1].rule == var_0_30 then
				local var_16_3

				for iter_16_0 = arg_16_1 - 1, 1, -1 do
					local var_16_4

					if true then
						if arg_16_0.grids[iter_16_0].rule == var_0_30 then
							table.insert({}, iter_16_0)
						elseif not var_16_3 then
							var_16_3 = arg_16_0.grids[iter_16_0].index

							table.insert({}, iter_16_0)
						elseif var_16_3 == arg_16_0.grids[iter_16_0].index then
							table.insert({}, iter_16_0)
						else
							var_16_4 = false
						end
					end
				end

				local var_16_5
				local var_16_6 = true

				for iter_16_1 = arg_16_1 + 1, #arg_16_0.grids do
					if var_16_6 then
						if arg_16_0.grids[iter_16_1].rule == var_0_30 then
							table.insert({}, iter_16_1)
						elseif not var_16_5 then
							var_16_5 = arg_16_0.grids[iter_16_1].index

							table.insert({}, iter_16_1)
						elseif var_16_5 == arg_16_0.grids[iter_16_1].index then
							table.insert({}, iter_16_1)
						else
							var_16_6 = false
						end
					end
				end

				if var_16_3 == nil and var_16_5 == nil then
					for iter_16_2 = 1, #arg_16_0.grids do
						table.insert(var_16_1, iter_16_2)
					end
				elseif var_16_3 == var_16_5 then
					for iter_16_3 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_3])
					end

					table.insert(var_16_1, arg_16_1)

					for iter_16_4 = 1, #{} do
						table.insert(var_16_1, ({})[iter_16_4])
					end

					var_16_0 = var_16_3
				else
					if #{} >= #{} then
						for iter_16_5 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_5])
						end

						var_16_0 = var_16_3
					else
						for iter_16_6 = 1, #{} do
							table.insert(var_16_1, ({})[iter_16_6])
						end

						var_16_0 = var_16_5
					end

					table.insert(var_16_1, arg_16_1)
				end

				table.insert(var_16_2, {
					index = var_16_0,
					count = #var_16_1
				})
			elseif arg_16_0.grids[arg_16_1].rule == var_0 then
				local var_16_10
				local var_16_11 = true

				for iter_16_7 = arg_16_1 - 1, 1, -1 do
					if var_16_11 then
						if arg_16_0.grids[iter_16_7].rule == var_0_30 then
							table.insert({}, iter_16_7)
						elseif not var_16_10 then
							var_16_10 = arg_16_0.grids[iter_16_7].index

							table.insert({}, iter_16_7)
						elseif var_16_10 == arg_16_0.grids[iter_16_7].index then
							table.insert({}, iter_16_7)
						else
							var_16_11 = false
						end
					end
				end

				local var_16_12

				for iter_16_8 = arg_16_1 + 1, #arg_16_0.grids do
					local var_16_13

					if true then
						if arg_16_0.grids[iter_16_8].rule == var_0_30 then
							table.insert({}, iter_16_8)
						elseif not var_16_12 then
							var_16_12 = arg_16_0.grids[iter_16_8].index

							table.insert({}, iter_16_8)
						elseif var_16_12 == arg_16_0.grids[iter_16_8].index then
							table.insert({}, iter_16_8)
						else
							var_16_13 = false
						end
					end
				end

				table.insert(var_16_2, {
					index = var_16_10,
					count = #{} + 1
				})
				table.insert(var_16_2, {
					index = var_16_12,
					count = #{} + 1
				})

				for iter_16_9 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_9])
				end

				for iter_16_10 = 1, #{} do
					table.insert(var_16_1, ({})[iter_16_10])
				end
			else
				for iter_16_11 = arg_16_1 - 1, 1, -1 do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_11]) then
						table.insert(var_16_1, iter_16_11)
					else
						break
					end
				end

				for iter_16_12 = arg_16_1 + 1, #arg_16_0.grids do
					if arg_16_0:checkGridMatch(var_16_0, arg_16_0.grids[iter_16_12]) then
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
			elseif arg_18_2.rule == var_0_30 then
				return true
			end

			return false
		end,
		initGrids = function(arg_19_0, arg_19_1)
			arg_19_0:clear()

			for iter_19_0 = 1, var_0_24 do
				table.insert(arg_19_0.grids, (arg_19_0:createGridData()))
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
				local var_20_0 = arg_20_0.grids[iter_20_0]

				if not arg_20_0.grids[iter_20_0].tf then
					local var_20_1 = tf(instantiate(arg_20_0.tplGrid))

					SetParent(var_20_1, arg_20_0._content)
					setActive(var_20_1, true)
					setActive(findTF(var_20_1, var_20_0.name), true)

					local var_20_2 = arg_20_1 and (var_0_24 + arg_20_0.gridCreateIndex - 1) * var_0_26.x or (arg_20_0.gridCreateIndex - 1) * var_0_26.x

					if var_20_0.rule == var_0_30 then
						-- block empty
					end

					if var_20_0.rule ~= var_0_30 then
						setActive(findTF(var_20_1, var_20_0.name .. "/boom"), var_20_0.rule == var_0)
						setActive(findTF(var_20_1, var_20_0.name .. "/thunder"), var_20_0.rule == var_0_31)
					end

					var_20_1.anchoredPosition = Vector2(var_20_2, 0)
					arg_20_0.gridCreateIndex = arg_20_0.gridCreateIndex + 1
					var_20_0.tf = var_20_1
				end
			end

			return
		end,
		createGridData = function(arg_21_0)
			local var_21_0
			local var_21_3

			if #arg_21_0.ruleGridList > 0 then
				local var_21_4 = table.remove(arg_21_0.ruleGridList, 1)

				var_21_0 = var_21_4.id
				var_21_3 = var_21_4.rule
			else
				var_21_0 = var_0_33[math.random(1, #var_0_33)]
			end

			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).name = var_0_32[var_21_0].name
			;({
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}).rule = var_21_3

			return {
				moveAble = false,
				eventAble = false,
				speed = var_0_28,
				index = var_0_32[var_21_0].index
			}
		end,
		checkGridsMatchAble = function(arg_22_0)
			return true
		end
	}
end

local var_0_78 = false

local function var_0_79(arg_23_0, arg_23_1, arg_23_2)
	({
		ctor = function(arg_24_0)
			arg_24_0._specialTf = arg_23_0
			arg_24_0._successTf = arg_23_1
			arg_24_0._effectSuccess = findTF(arg_24_0._successTf, "effectSuccess")
			arg_24_0._event = arg_23_2

			arg_24_0._event:bind(var_0_14, function(arg_25_0, arg_25_1, arg_25_2)
				arg_24_0:addPowerAmount(arg_25_1.index, arg_24_0:getPowerAmount(var_25_0, arg_25_1.combo, arg_25_1.double))

				return
			end)

			arg_24_0.powers = {}

			for iter_24_0 = 1, #var_0_35 do
				local var_24_0 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name)
				local var_24_1 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name .. "/text")

				setActive(var_24_1, var_0_1)
				table.insert(arg_24_0.powers, {
					active = false,
					tf = var_24_0,
					index = var_0_35[iter_24_0].index,
					max = var_0_35[iter_24_0].max,
					cur = var_0_35[iter_24_0].cur,
					text_tf = var_24_1
				})
			end

			arg_24_0._event:bind(var_0_20, function(arg_26_0, arg_26_1, arg_26_2)
				arg_24_0.inCameraFlag = true

				return
			end)
			arg_24_0._event:bind(var_0_21, function(arg_27_0, arg_27_1, arg_27_2)
				arg_24_0.inCameraFlag = false
				arg_24_0.inCameraFadeTime = 200

				return
			end)

			arg_24_0.successText = findTF(arg_24_0._successTf, "box/text")

			setActive(arg_24_0.successText, var_0_1)

			arg_24_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_24_0._successTf, "box"), typeof(Slider)),
				max = var_0_44
			}

			return
		end,
		start = function(arg_28_0)
			for iter_28_0 = 1, #arg_28_0.powers do
				arg_28_0.powers[iter_28_0].cur = 0
				arg_28_0.powers[iter_28_0].active = false
			end

			arg_28_0.inCameraFlag = false
			arg_28_0.inCameraFadeTime = 0
			arg_28_0.success.cur = 0
			arg_28_0.success.active = false

			setActive(arg_28_0._effectSuccess, false)
			arg_28_0:resetSpecialData()
			arg_28_0:step()

			return
		end,
		step = function(arg_29_0)
			for iter_29_0 = 1, #arg_29_0.powers do
				local var_29_0 = arg_29_0.powers[iter_29_0]

				if arg_29_0.powers[iter_29_0].active and var_29_0.cur > 0 then
					var_29_0.cur = var_29_0.cur - var_0_41 * Time.deltaTime

					if var_29_0.cur <= 0 then
						var_29_0.active = false
						var_29_0.cur = 0
					end
				end

				local var_29_1 = GetComponent(var_29_0.tf, typeof(Slider))

				if var_29_0.cur > 0 then
					var_29_1.value = var_29_0.cur / var_29_0.max or 0

					setText(var_29_0.text_tf, math.floor(var_29_0.cur))
				end
			end

			setText(arg_29_0.successText, math.floor(arg_29_0.success.cur))

			if arg_29_0.success.active and arg_29_0.success.cur > 0 and var_0_23.special_complete and not arg_29_0.inCameraFlag then
				if arg_29_0.inCameraFadeTime > 0 then
					arg_29_0.inCameraFadeTime = arg_29_0.inCameraFadeTime - Time.deltaTime * 1000
				else
					arg_29_0.success.cur = arg_29_0.success.cur - var_0_42 * Time.deltaTime

					if arg_29_0.success.cur <= 0 then
						arg_29_0.success.active = false
						arg_29_0.success.cur = 0

						arg_29_0._event:emit(var_0_19)
					end
				end
			end

			if arg_29_0.success.cur >= arg_29_0.success.max or arg_29_0.success.active then
				setActive(arg_29_0._effectSuccess, true)
			else
				setActive(arg_29_0._effectSuccess, false)
			end

			local var_29_2 = arg_29_0.success.slider

			if arg_29_0.success.cur > 0 then
				var_29_2.value = arg_29_0.success.cur / arg_29_0.success.max or 0
				var_0_23.special_time = arg_29_0.success.active
				var_0_23.grid_index = 0

				if arg_29_0.waitingSpecial then
					arg_29_0:addPowerAmount(1, 0)
				end

				return
			end
		end,
		clear = function(arg_30_0)
			return
		end,
		updateSpecialData = function(arg_31_0, arg_31_1)
			var_0_23.special_time = arg_31_0.success.active
			var_0_23.grid_index = arg_31_1
			var_0_23.power_grid = 0

			for iter_31_0 = 1, #arg_31_0.powers do
				if arg_31_0.powers[iter_31_0].index == arg_31_1 and arg_31_0.powers[iter_31_0].cur == arg_31_0.powers[iter_31_0].max then
					var_0_23.power_grid = arg_31_0.powers[iter_31_0].index
				end
			end

			arg_31_0._event:emit(var_0_15)

			return
		end,
		resetSpecialData = function(arg_32_0)
			var_0_23.special_complete = false

			return
		end,
		addPowerAmount = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_0:getPowerByIndex(arg_33_1)

			if arg_33_0.success then
				if not arg_33_0.success.active then
					arg_33_0.success.cur = arg_33_0.success.cur + arg_33_2

					if arg_33_0.success.cur >= arg_33_0.success.max then
						arg_33_0.success.cur = arg_33_0.success.max

						arg_33_0._event:emit(var_0_18, {
							callback = function(arg_34_0)
								if arg_34_0 then
									if not isActive(arg_33_0._effectSuccess) then
										setActive(arg_33_0._effectSuccess, true)
									end

									arg_33_0.success.active = true
									var_0_23.special_complete = false
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
				print("分数: " .. var_0_43)

				return var_0_43
			end

			local var_36_0 = arg_36_3 and 2 or 1

			if (arg_36_3 and 2 or 1) == 2 then
				-- block empty
			end

			if var_0_23.special_time then
				local var_36_1 = var_0_40 or 1

				print("方块个数: " .. arg_36_1 .. ",combo次数: " .. arg_36_2 .. ", 加倍方块: " .. tostring(arg_36_3) .. "，变身倍率: " .. var_36_1)
				print("分数: " .. (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_1)

				return (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_0 * var_36_1
			end
		end
	}).ctor({
		ctor = function(arg_24_0)
			arg_24_0._specialTf = arg_23_0
			arg_24_0._successTf = arg_23_1
			arg_24_0._effectSuccess = findTF(arg_24_0._successTf, "effectSuccess")
			arg_24_0._event = arg_23_2

			arg_24_0._event:bind(var_0_14, function(arg_25_0, arg_25_1, arg_25_2)
				arg_24_0:addPowerAmount(arg_25_1.index, arg_24_0:getPowerAmount(var_25_0, arg_25_1.combo, arg_25_1.double))

				return
			end)

			arg_24_0.powers = {}

			for iter_24_0 = 1, #var_0_35 do
				local var_24_0 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name)
				local var_24_1 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name .. "/text")

				setActive(var_24_1, var_0_1)
				table.insert(arg_24_0.powers, {
					active = false,
					tf = var_24_0,
					index = var_0_35[iter_24_0].index,
					max = var_0_35[iter_24_0].max,
					cur = var_0_35[iter_24_0].cur,
					text_tf = var_24_1
				})
			end

			arg_24_0._event:bind(var_0_20, function(arg_26_0, arg_26_1, arg_26_2)
				arg_24_0.inCameraFlag = true

				return
			end)
			arg_24_0._event:bind(var_0_21, function(arg_27_0, arg_27_1, arg_27_2)
				arg_24_0.inCameraFlag = false
				arg_24_0.inCameraFadeTime = 200

				return
			end)

			arg_24_0.successText = findTF(arg_24_0._successTf, "box/text")

			setActive(arg_24_0.successText, var_0_1)

			arg_24_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_24_0._successTf, "box"), typeof(Slider)),
				max = var_0_44
			}

			return
		end,
		start = function(arg_28_0)
			for iter_28_0 = 1, #arg_28_0.powers do
				arg_28_0.powers[iter_28_0].cur = 0
				arg_28_0.powers[iter_28_0].active = false
			end

			arg_28_0.inCameraFlag = false
			arg_28_0.inCameraFadeTime = 0
			arg_28_0.success.cur = 0
			arg_28_0.success.active = false

			setActive(arg_28_0._effectSuccess, false)
			arg_28_0:resetSpecialData()
			arg_28_0:step()

			return
		end,
		step = function(arg_29_0)
			for iter_29_0 = 1, #arg_29_0.powers do
				local var_29_0 = arg_29_0.powers[iter_29_0]

				if arg_29_0.powers[iter_29_0].active and var_29_0.cur > 0 then
					var_29_0.cur = var_29_0.cur - var_0_41 * Time.deltaTime

					if var_29_0.cur <= 0 then
						var_29_0.active = false
						var_29_0.cur = 0
					end
				end

				local var_29_1 = GetComponent(var_29_0.tf, typeof(Slider))

				if var_29_0.cur > 0 then
					var_29_1.value = var_29_0.cur / var_29_0.max or 0

					setText(var_29_0.text_tf, math.floor(var_29_0.cur))
				end
			end

			setText(arg_29_0.successText, math.floor(arg_29_0.success.cur))

			if arg_29_0.success.active and arg_29_0.success.cur > 0 and var_0_23.special_complete and not arg_29_0.inCameraFlag then
				if arg_29_0.inCameraFadeTime > 0 then
					arg_29_0.inCameraFadeTime = arg_29_0.inCameraFadeTime - Time.deltaTime * 1000
				else
					arg_29_0.success.cur = arg_29_0.success.cur - var_0_42 * Time.deltaTime

					if arg_29_0.success.cur <= 0 then
						arg_29_0.success.active = false
						arg_29_0.success.cur = 0

						arg_29_0._event:emit(var_0_19)
					end
				end
			end

			if arg_29_0.success.cur >= arg_29_0.success.max or arg_29_0.success.active then
				setActive(arg_29_0._effectSuccess, true)
			else
				setActive(arg_29_0._effectSuccess, false)
			end

			local var_29_2 = arg_29_0.success.slider

			if arg_29_0.success.cur > 0 then
				var_29_2.value = arg_29_0.success.cur / arg_29_0.success.max or 0
				var_0_23.special_time = arg_29_0.success.active
				var_0_23.grid_index = 0

				if arg_29_0.waitingSpecial then
					arg_29_0:addPowerAmount(1, 0)
				end

				return
			end
		end,
		clear = function(arg_30_0)
			return
		end,
		updateSpecialData = function(arg_31_0, arg_31_1)
			var_0_23.special_time = arg_31_0.success.active
			var_0_23.grid_index = arg_31_1
			var_0_23.power_grid = 0

			for iter_31_0 = 1, #arg_31_0.powers do
				if arg_31_0.powers[iter_31_0].index == arg_31_1 and arg_31_0.powers[iter_31_0].cur == arg_31_0.powers[iter_31_0].max then
					var_0_23.power_grid = arg_31_0.powers[iter_31_0].index
				end
			end

			arg_31_0._event:emit(var_0_15)

			return
		end,
		resetSpecialData = function(arg_32_0)
			var_0_23.special_complete = false

			return
		end,
		addPowerAmount = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_0:getPowerByIndex(arg_33_1)

			if arg_33_0.success then
				if not arg_33_0.success.active then
					arg_33_0.success.cur = arg_33_0.success.cur + arg_33_2

					if arg_33_0.success.cur >= arg_33_0.success.max then
						arg_33_0.success.cur = arg_33_0.success.max

						arg_33_0._event:emit(var_0_18, {
							callback = function(arg_34_0)
								if arg_34_0 then
									if not isActive(arg_33_0._effectSuccess) then
										setActive(arg_33_0._effectSuccess, true)
									end

									arg_33_0.success.active = true
									var_0_23.special_complete = false
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
				print("分数: " .. var_0_43)

				return var_0_43
			end

			local var_36_0 = arg_36_3 and 2 or 1

			if (arg_36_3 and 2 or 1) == 2 then
				-- block empty
			end

			if var_0_23.special_time then
				local var_36_1 = var_0_40 or 1

				print("方块个数: " .. arg_36_1 .. ",combo次数: " .. arg_36_2 .. ", 加倍方块: " .. tostring(arg_36_3) .. "，变身倍率: " .. var_36_1)
				print("分数: " .. (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_1)

				return (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_0 * var_36_1
			end
		end
	})

	return {
		ctor = function(arg_24_0)
			arg_24_0._specialTf = arg_23_0
			arg_24_0._successTf = arg_23_1
			arg_24_0._effectSuccess = findTF(arg_24_0._successTf, "effectSuccess")
			arg_24_0._event = arg_23_2

			arg_24_0._event:bind(var_0_14, function(arg_25_0, arg_25_1, arg_25_2)
				arg_24_0:addPowerAmount(arg_25_1.index, arg_24_0:getPowerAmount(var_25_0, arg_25_1.combo, arg_25_1.double))

				return
			end)

			arg_24_0.powers = {}

			for iter_24_0 = 1, #var_0_35 do
				local var_24_0 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name)
				local var_24_1 = findTF(arg_24_0._specialTf, var_0_35[iter_24_0].name .. "/text")

				setActive(var_24_1, var_0_1)
				table.insert(arg_24_0.powers, {
					active = false,
					tf = var_24_0,
					index = var_0_35[iter_24_0].index,
					max = var_0_35[iter_24_0].max,
					cur = var_0_35[iter_24_0].cur,
					text_tf = var_24_1
				})
			end

			arg_24_0._event:bind(var_0_20, function(arg_26_0, arg_26_1, arg_26_2)
				arg_24_0.inCameraFlag = true

				return
			end)
			arg_24_0._event:bind(var_0_21, function(arg_27_0, arg_27_1, arg_27_2)
				arg_24_0.inCameraFlag = false
				arg_24_0.inCameraFadeTime = 200

				return
			end)

			arg_24_0.successText = findTF(arg_24_0._successTf, "box/text")

			setActive(arg_24_0.successText, var_0_1)

			arg_24_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_24_0._successTf, "box"), typeof(Slider)),
				max = var_0_44
			}

			return
		end,
		start = function(arg_28_0)
			for iter_28_0 = 1, #arg_28_0.powers do
				arg_28_0.powers[iter_28_0].cur = 0
				arg_28_0.powers[iter_28_0].active = false
			end

			arg_28_0.inCameraFlag = false
			arg_28_0.inCameraFadeTime = 0
			arg_28_0.success.cur = 0
			arg_28_0.success.active = false

			setActive(arg_28_0._effectSuccess, false)
			arg_28_0:resetSpecialData()
			arg_28_0:step()

			return
		end,
		step = function(arg_29_0)
			for iter_29_0 = 1, #arg_29_0.powers do
				local var_29_0 = arg_29_0.powers[iter_29_0]

				if arg_29_0.powers[iter_29_0].active and var_29_0.cur > 0 then
					var_29_0.cur = var_29_0.cur - var_0_41 * Time.deltaTime

					if var_29_0.cur <= 0 then
						var_29_0.active = false
						var_29_0.cur = 0
					end
				end

				local var_29_1 = GetComponent(var_29_0.tf, typeof(Slider))

				if var_29_0.cur > 0 then
					var_29_1.value = var_29_0.cur / var_29_0.max or 0

					setText(var_29_0.text_tf, math.floor(var_29_0.cur))
				end
			end

			setText(arg_29_0.successText, math.floor(arg_29_0.success.cur))

			if arg_29_0.success.active and arg_29_0.success.cur > 0 and var_0_23.special_complete and not arg_29_0.inCameraFlag then
				if arg_29_0.inCameraFadeTime > 0 then
					arg_29_0.inCameraFadeTime = arg_29_0.inCameraFadeTime - Time.deltaTime * 1000
				else
					arg_29_0.success.cur = arg_29_0.success.cur - var_0_42 * Time.deltaTime

					if arg_29_0.success.cur <= 0 then
						arg_29_0.success.active = false
						arg_29_0.success.cur = 0

						arg_29_0._event:emit(var_0_19)
					end
				end
			end

			if arg_29_0.success.cur >= arg_29_0.success.max or arg_29_0.success.active then
				setActive(arg_29_0._effectSuccess, true)
			else
				setActive(arg_29_0._effectSuccess, false)
			end

			local var_29_2 = arg_29_0.success.slider

			if arg_29_0.success.cur > 0 then
				var_29_2.value = arg_29_0.success.cur / arg_29_0.success.max or 0
				var_0_23.special_time = arg_29_0.success.active
				var_0_23.grid_index = 0

				if arg_29_0.waitingSpecial then
					arg_29_0:addPowerAmount(1, 0)
				end

				return
			end
		end,
		clear = function(arg_30_0)
			return
		end,
		updateSpecialData = function(arg_31_0, arg_31_1)
			var_0_23.special_time = arg_31_0.success.active
			var_0_23.grid_index = arg_31_1
			var_0_23.power_grid = 0

			for iter_31_0 = 1, #arg_31_0.powers do
				if arg_31_0.powers[iter_31_0].index == arg_31_1 and arg_31_0.powers[iter_31_0].cur == arg_31_0.powers[iter_31_0].max then
					var_0_23.power_grid = arg_31_0.powers[iter_31_0].index
				end
			end

			arg_31_0._event:emit(var_0_15)

			return
		end,
		resetSpecialData = function(arg_32_0)
			var_0_23.special_complete = false

			return
		end,
		addPowerAmount = function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_0:getPowerByIndex(arg_33_1)

			if arg_33_0.success then
				if not arg_33_0.success.active then
					arg_33_0.success.cur = arg_33_0.success.cur + arg_33_2

					if arg_33_0.success.cur >= arg_33_0.success.max then
						arg_33_0.success.cur = arg_33_0.success.max

						arg_33_0._event:emit(var_0_18, {
							callback = function(arg_34_0)
								if arg_34_0 then
									if not isActive(arg_33_0._effectSuccess) then
										setActive(arg_33_0._effectSuccess, true)
									end

									arg_33_0.success.active = true
									var_0_23.special_complete = false
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
				print("分数: " .. var_0_43)

				return var_0_43
			end

			local var_36_0 = arg_36_3 and 2 or 1

			if (arg_36_3 and 2 or 1) == 2 then
				-- block empty
			end

			if var_0_23.special_time then
				local var_36_1 = var_0_40 or 1

				print("方块个数: " .. arg_36_1 .. ",combo次数: " .. arg_36_2 .. ", 加倍方块: " .. tostring(arg_36_3) .. "，变身倍率: " .. var_36_1)
				print("分数: " .. (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_1)

				return (var_0_39 + (arg_36_1 - var_0_38) * var_0_37) * (1 + arg_36_2 * var_0_36) * var_36_0 * var_36_1
			end
		end
	}
end

local function var_0_80(arg_37_0, arg_37_1, arg_37_2)
	({
		ctor = function(arg_38_0)
			arg_38_0._sceneTf = arg_37_0
			arg_38_0._event = arg_37_2
			arg_38_0.bgs = {}
			arg_38_0._gameTf = arg_37_1
			arg_38_0._box = findTF(arg_38_0._gameTf, "box")
			arg_38_0._specialPower = findTF(arg_38_0._gameTf, "specialPower")
			arg_38_0._successPower = findTF(arg_38_0._gameTf, "successPower")
			arg_38_0._top = findTF(arg_38_0._gameTf, "top")

			for iter_38_0 = 1, #var_0_70 do
				table.insert(arg_38_0.bgs, {
					tf = findTF(arg_38_0._sceneTf, var_0_70[iter_38_0].source),
					rate = var_0_70[iter_38_0].rate,
					type = var_0_70[iter_38_0].type
				})
			end

			arg_38_0._bgBackCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_background"), typeof(CanvasGroup))
			arg_38_0._bgFrontCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_front"), typeof(CanvasGroup))
			arg_38_0._bgBeamCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

			arg_38_0._event:bind(var_0_16, function(arg_39_0, arg_39_1, arg_39_2)
				local var_39_0 = arg_39_1[2] and -1 or 1
				local var_39_1 = arg_39_1[3]

				if not arg_38_0.inCamera then
					arg_38_0:setTargetFllow(Vector2(var_39_0 * arg_39_1[1].x / 10, var_39_0 * arg_39_1[1].y / 10), var_39_1)
				end

				return
			end)
			arg_38_0._event:bind(var_0_20, function(arg_40_0, arg_40_1, arg_40_2)
				arg_38_0.inCamera = true

				local var_40_0 = Vector2(550, 100)

				if arg_40_1 and arg_40_1.playingAction and arg_40_1.playingAction.camera_pos then
					var_40_0 = arg_40_1.playingAction.camera_pos
				end

				arg_38_0:setTargetFllow(var_40_0)
				arg_38_0:setBeam(false)

				return
			end)
			arg_38_0._event:bind(var_0_21, function(arg_41_0, arg_41_1, arg_41_2)
				arg_38_0.followTf = nil
				arg_38_0.followInit = nil

				arg_38_0:setTargetFllow(Vector2(0, 0), function()
					return
				end, true)
				arg_38_0:setBeam(true)

				arg_38_0.inCamera = false

				return
			end)

			return
		end,
		start = function(arg_43_0)
			arg_43_0.targetVec = Vector2(var_0_55.x, var_0_55.y)
			arg_43_0.currentVec = Vector2(var_0_55.x, var_0_55.y)

			for iter_43_0 = 1, #arg_43_0.bgs do
				local var_43_0 = arg_43_0.bgs[iter_43_0].tf
				local var_43_1 = arg_43_0.bgs[iter_43_0].rate
				local var_43_2 = arg_43_0.bgs[iter_43_0].type

				if arg_43_0.bgs[iter_43_0].tf then
					setActive(var_43_0, var_43_2 == var_0_66 or var_43_2 == var_0_69)

					var_43_0.anchoredPosition = Vector2(arg_43_0.currentVec.x * var_43_1, arg_43_0.currentVec.y * var_43_1)
				end
			end

			arg_43_0._bgBackCanvas.alpha = 1
			arg_43_0._bgFrontCanvas.alpha = 1
			arg_43_0._bgBeamCanvas.alpha = 0

			setActive(arg_43_0._box, true)
			setActive(arg_43_0._specialPower, true)
			setActive(arg_43_0._successPower, true)
			setActive(arg_43_0._top, true)

			return
		end,
		clear = function(arg_44_0)
			if LeanTween.isTweening(go(arg_44_0._sceneTf)) then
				LeanTween.cancel(go(arg_44_0._sceneTf), false)
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

			if arg_45_0.targetVec.x - var_45_0[1] ~= arg_45_0.currentVec.x then
				var_45_1 = (arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56

				if math.abs((arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56) < var_0_57 then
					var_45_1 = var_0_57 * math.sign(var_45_1)
				end

				arg_45_0.currentVec.x = arg_45_0.currentVec.x + var_45_1

				if math.abs(arg_45_0.currentVec.x - (arg_45_0.targetVec.x - var_45_0[1])) <= var_0_57 then
					arg_45_0.currentVec.x = arg_45_0.targetVec.x - var_45_0[1]
				end
			end

			if arg_45_0.targetVec.y - var_45_0[2] ~= arg_45_0.currentVec.y then
				var_45_2 = (arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56

				if math.abs((arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56) < var_0_57 then
					var_45_2 = var_0_57 * math.sign(var_45_2)
				end

				arg_45_0.currentVec.y = arg_45_0.currentVec.y + var_45_2

				if math.abs(arg_45_0.currentVec.y - (arg_45_0.targetVec.y - var_45_0[2])) <= var_0_57 then
					arg_45_0.currentVec.y = arg_45_0.targetVec.y - var_45_0[2]
				end
			end

			if var_45_1 ~= 0 or var_45_2 ~= 0 then
				arg_45_0:moveTo(arg_45_0.currentVec)
			end

			return
		end,
		moveTo = function(arg_46_0, arg_46_1)
			for iter_46_0 = 1, #arg_46_0.bgs do
				if arg_46_0.bgs[iter_46_0].type == var_0_66 or arg_46_0.bgs[iter_46_0].type == var_0_69 then
					arg_46_0.bgs[iter_46_0].tf.anchoredPosition = Vector2(arg_46_1.x * arg_46_0.bgs[iter_46_0].rate, arg_46_1.y * arg_46_0.bgs[iter_46_0].rate)
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
			if LeanTween.isTweening(go(arg_48_0._sceneTf)) then
				LeanTween.cancel(go(arg_48_0._sceneTf), false)
			end

			if arg_48_1 then
				setActive(arg_48_0._box, true)
				setActive(arg_48_0._specialPower, true)
				setActive(arg_48_0._successPower, true)
				setActive(arg_48_0._top, true)
			else
				setActive(arg_48_0._box, false)
				setActive(arg_48_0._specialPower, false)
				setActive(arg_48_0._successPower, false)
				setActive(arg_48_0._top, false)
			end

			LeanTween.value(go(arg_48_0._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_49_0)
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
			end)):setOnComplete(System.Action(function()
				if arg_48_2 then
					arg_48_2()
				end

				return
			end))

			return
		end
	}).ctor({
		ctor = function(arg_38_0)
			arg_38_0._sceneTf = arg_37_0
			arg_38_0._event = arg_37_2
			arg_38_0.bgs = {}
			arg_38_0._gameTf = arg_37_1
			arg_38_0._box = findTF(arg_38_0._gameTf, "box")
			arg_38_0._specialPower = findTF(arg_38_0._gameTf, "specialPower")
			arg_38_0._successPower = findTF(arg_38_0._gameTf, "successPower")
			arg_38_0._top = findTF(arg_38_0._gameTf, "top")

			for iter_38_0 = 1, #var_0_70 do
				table.insert(arg_38_0.bgs, {
					tf = findTF(arg_38_0._sceneTf, var_0_70[iter_38_0].source),
					rate = var_0_70[iter_38_0].rate,
					type = var_0_70[iter_38_0].type
				})
			end

			arg_38_0._bgBackCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_background"), typeof(CanvasGroup))
			arg_38_0._bgFrontCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_front"), typeof(CanvasGroup))
			arg_38_0._bgBeamCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

			arg_38_0._event:bind(var_0_16, function(arg_39_0, arg_39_1, arg_39_2)
				local var_39_0 = arg_39_1[2] and -1 or 1
				local var_39_1 = arg_39_1[3]

				if not arg_38_0.inCamera then
					arg_38_0:setTargetFllow(Vector2(var_39_0 * arg_39_1[1].x / 10, var_39_0 * arg_39_1[1].y / 10), var_39_1)
				end

				return
			end)
			arg_38_0._event:bind(var_0_20, function(arg_40_0, arg_40_1, arg_40_2)
				arg_38_0.inCamera = true

				local var_40_0 = Vector2(550, 100)

				if arg_40_1 and arg_40_1.playingAction and arg_40_1.playingAction.camera_pos then
					var_40_0 = arg_40_1.playingAction.camera_pos
				end

				arg_38_0:setTargetFllow(var_40_0)
				arg_38_0:setBeam(false)

				return
			end)
			arg_38_0._event:bind(var_0_21, function(arg_41_0, arg_41_1, arg_41_2)
				arg_38_0.followTf = nil
				arg_38_0.followInit = nil

				arg_38_0:setTargetFllow(Vector2(0, 0), function()
					return
				end, true)
				arg_38_0:setBeam(true)

				arg_38_0.inCamera = false

				return
			end)

			return
		end,
		start = function(arg_43_0)
			arg_43_0.targetVec = Vector2(var_0_55.x, var_0_55.y)
			arg_43_0.currentVec = Vector2(var_0_55.x, var_0_55.y)

			for iter_43_0 = 1, #arg_43_0.bgs do
				local var_43_0 = arg_43_0.bgs[iter_43_0].tf
				local var_43_1 = arg_43_0.bgs[iter_43_0].rate
				local var_43_2 = arg_43_0.bgs[iter_43_0].type

				if arg_43_0.bgs[iter_43_0].tf then
					setActive(var_43_0, var_43_2 == var_0_66 or var_43_2 == var_0_69)

					var_43_0.anchoredPosition = Vector2(arg_43_0.currentVec.x * var_43_1, arg_43_0.currentVec.y * var_43_1)
				end
			end

			arg_43_0._bgBackCanvas.alpha = 1
			arg_43_0._bgFrontCanvas.alpha = 1
			arg_43_0._bgBeamCanvas.alpha = 0

			setActive(arg_43_0._box, true)
			setActive(arg_43_0._specialPower, true)
			setActive(arg_43_0._successPower, true)
			setActive(arg_43_0._top, true)

			return
		end,
		clear = function(arg_44_0)
			if LeanTween.isTweening(go(arg_44_0._sceneTf)) then
				LeanTween.cancel(go(arg_44_0._sceneTf), false)
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

			if arg_45_0.targetVec.x - var_45_0[1] ~= arg_45_0.currentVec.x then
				var_45_1 = (arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56

				if math.abs((arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56) < var_0_57 then
					var_45_1 = var_0_57 * math.sign(var_45_1)
				end

				arg_45_0.currentVec.x = arg_45_0.currentVec.x + var_45_1

				if math.abs(arg_45_0.currentVec.x - (arg_45_0.targetVec.x - var_45_0[1])) <= var_0_57 then
					arg_45_0.currentVec.x = arg_45_0.targetVec.x - var_45_0[1]
				end
			end

			if arg_45_0.targetVec.y - var_45_0[2] ~= arg_45_0.currentVec.y then
				var_45_2 = (arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56

				if math.abs((arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56) < var_0_57 then
					var_45_2 = var_0_57 * math.sign(var_45_2)
				end

				arg_45_0.currentVec.y = arg_45_0.currentVec.y + var_45_2

				if math.abs(arg_45_0.currentVec.y - (arg_45_0.targetVec.y - var_45_0[2])) <= var_0_57 then
					arg_45_0.currentVec.y = arg_45_0.targetVec.y - var_45_0[2]
				end
			end

			if var_45_1 ~= 0 or var_45_2 ~= 0 then
				arg_45_0:moveTo(arg_45_0.currentVec)
			end

			return
		end,
		moveTo = function(arg_46_0, arg_46_1)
			for iter_46_0 = 1, #arg_46_0.bgs do
				if arg_46_0.bgs[iter_46_0].type == var_0_66 or arg_46_0.bgs[iter_46_0].type == var_0_69 then
					arg_46_0.bgs[iter_46_0].tf.anchoredPosition = Vector2(arg_46_1.x * arg_46_0.bgs[iter_46_0].rate, arg_46_1.y * arg_46_0.bgs[iter_46_0].rate)
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
			if LeanTween.isTweening(go(arg_48_0._sceneTf)) then
				LeanTween.cancel(go(arg_48_0._sceneTf), false)
			end

			if arg_48_1 then
				setActive(arg_48_0._box, true)
				setActive(arg_48_0._specialPower, true)
				setActive(arg_48_0._successPower, true)
				setActive(arg_48_0._top, true)
			else
				setActive(arg_48_0._box, false)
				setActive(arg_48_0._specialPower, false)
				setActive(arg_48_0._successPower, false)
				setActive(arg_48_0._top, false)
			end

			LeanTween.value(go(arg_48_0._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_49_0)
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
			end)):setOnComplete(System.Action(function()
				if arg_48_2 then
					arg_48_2()
				end

				return
			end))

			return
		end
	})

	return {
		ctor = function(arg_38_0)
			arg_38_0._sceneTf = arg_37_0
			arg_38_0._event = arg_37_2
			arg_38_0.bgs = {}
			arg_38_0._gameTf = arg_37_1
			arg_38_0._box = findTF(arg_38_0._gameTf, "box")
			arg_38_0._specialPower = findTF(arg_38_0._gameTf, "specialPower")
			arg_38_0._successPower = findTF(arg_38_0._gameTf, "successPower")
			arg_38_0._top = findTF(arg_38_0._gameTf, "top")

			for iter_38_0 = 1, #var_0_70 do
				table.insert(arg_38_0.bgs, {
					tf = findTF(arg_38_0._sceneTf, var_0_70[iter_38_0].source),
					rate = var_0_70[iter_38_0].rate,
					type = var_0_70[iter_38_0].type
				})
			end

			arg_38_0._bgBackCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_background"), typeof(CanvasGroup))
			arg_38_0._bgFrontCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene_front"), typeof(CanvasGroup))
			arg_38_0._bgBeamCanvas = GetComponent(findTF(arg_38_0._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

			arg_38_0._event:bind(var_0_16, function(arg_39_0, arg_39_1, arg_39_2)
				local var_39_0 = arg_39_1[2] and -1 or 1
				local var_39_1 = arg_39_1[3]

				if not arg_38_0.inCamera then
					arg_38_0:setTargetFllow(Vector2(var_39_0 * arg_39_1[1].x / 10, var_39_0 * arg_39_1[1].y / 10), var_39_1)
				end

				return
			end)
			arg_38_0._event:bind(var_0_20, function(arg_40_0, arg_40_1, arg_40_2)
				arg_38_0.inCamera = true

				local var_40_0 = Vector2(550, 100)

				if arg_40_1 and arg_40_1.playingAction and arg_40_1.playingAction.camera_pos then
					var_40_0 = arg_40_1.playingAction.camera_pos
				end

				arg_38_0:setTargetFllow(var_40_0)
				arg_38_0:setBeam(false)

				return
			end)
			arg_38_0._event:bind(var_0_21, function(arg_41_0, arg_41_1, arg_41_2)
				arg_38_0.followTf = nil
				arg_38_0.followInit = nil

				arg_38_0:setTargetFllow(Vector2(0, 0), function()
					return
				end, true)
				arg_38_0:setBeam(true)

				arg_38_0.inCamera = false

				return
			end)

			return
		end,
		start = function(arg_43_0)
			arg_43_0.targetVec = Vector2(var_0_55.x, var_0_55.y)
			arg_43_0.currentVec = Vector2(var_0_55.x, var_0_55.y)

			for iter_43_0 = 1, #arg_43_0.bgs do
				local var_43_0 = arg_43_0.bgs[iter_43_0].tf
				local var_43_1 = arg_43_0.bgs[iter_43_0].rate
				local var_43_2 = arg_43_0.bgs[iter_43_0].type

				if arg_43_0.bgs[iter_43_0].tf then
					setActive(var_43_0, var_43_2 == var_0_66 or var_43_2 == var_0_69)

					var_43_0.anchoredPosition = Vector2(arg_43_0.currentVec.x * var_43_1, arg_43_0.currentVec.y * var_43_1)
				end
			end

			arg_43_0._bgBackCanvas.alpha = 1
			arg_43_0._bgFrontCanvas.alpha = 1
			arg_43_0._bgBeamCanvas.alpha = 0

			setActive(arg_43_0._box, true)
			setActive(arg_43_0._specialPower, true)
			setActive(arg_43_0._successPower, true)
			setActive(arg_43_0._top, true)

			return
		end,
		clear = function(arg_44_0)
			if LeanTween.isTweening(go(arg_44_0._sceneTf)) then
				LeanTween.cancel(go(arg_44_0._sceneTf), false)
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

			if arg_45_0.targetVec.x - var_45_0[1] ~= arg_45_0.currentVec.x then
				var_45_1 = (arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56

				if math.abs((arg_45_0.targetVec.x - var_45_0[1] - arg_45_0.currentVec.x) * var_0_56) < var_0_57 then
					var_45_1 = var_0_57 * math.sign(var_45_1)
				end

				arg_45_0.currentVec.x = arg_45_0.currentVec.x + var_45_1

				if math.abs(arg_45_0.currentVec.x - (arg_45_0.targetVec.x - var_45_0[1])) <= var_0_57 then
					arg_45_0.currentVec.x = arg_45_0.targetVec.x - var_45_0[1]
				end
			end

			if arg_45_0.targetVec.y - var_45_0[2] ~= arg_45_0.currentVec.y then
				var_45_2 = (arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56

				if math.abs((arg_45_0.targetVec.y - var_45_0[2] - arg_45_0.currentVec.y) * var_0_56) < var_0_57 then
					var_45_2 = var_0_57 * math.sign(var_45_2)
				end

				arg_45_0.currentVec.y = arg_45_0.currentVec.y + var_45_2

				if math.abs(arg_45_0.currentVec.y - (arg_45_0.targetVec.y - var_45_0[2])) <= var_0_57 then
					arg_45_0.currentVec.y = arg_45_0.targetVec.y - var_45_0[2]
				end
			end

			if var_45_1 ~= 0 or var_45_2 ~= 0 then
				arg_45_0:moveTo(arg_45_0.currentVec)
			end

			return
		end,
		moveTo = function(arg_46_0, arg_46_1)
			for iter_46_0 = 1, #arg_46_0.bgs do
				if arg_46_0.bgs[iter_46_0].type == var_0_66 or arg_46_0.bgs[iter_46_0].type == var_0_69 then
					arg_46_0.bgs[iter_46_0].tf.anchoredPosition = Vector2(arg_46_1.x * arg_46_0.bgs[iter_46_0].rate, arg_46_1.y * arg_46_0.bgs[iter_46_0].rate)
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
			if LeanTween.isTweening(go(arg_48_0._sceneTf)) then
				LeanTween.cancel(go(arg_48_0._sceneTf), false)
			end

			if arg_48_1 then
				setActive(arg_48_0._box, true)
				setActive(arg_48_0._specialPower, true)
				setActive(arg_48_0._successPower, true)
				setActive(arg_48_0._top, true)
			else
				setActive(arg_48_0._box, false)
				setActive(arg_48_0._specialPower, false)
				setActive(arg_48_0._successPower, false)
				setActive(arg_48_0._top, false)
			end

			LeanTween.value(go(arg_48_0._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_49_0)
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
			end)):setOnComplete(System.Action(function()
				if arg_48_2 then
					arg_48_2()
				end

				return
			end))

			return
		end
	}
end

local function var_0_81(arg_51_0, arg_51_1)
	({
		ctor = function(arg_52_0)
			arg_52_0._scene = arg_51_0
			arg_52_0._tpl = findTF(arg_52_0._scene, "tpl")
			arg_52_0._leftRolePos = findTF(arg_52_0._scene, "rolePos/leftRole")
			arg_52_0._rightRolePos = findTF(arg_52_0._scene, "rolePos/rightRole")
			arg_52_0._event = arg_51_1

			arg_52_0._event:bind(var_0_15, function()
				arg_52_0:onGridTrigger()

				return
			end)
			arg_52_0._event:bind(var_0_18, function(arg_54_0, arg_54_1, arg_54_2)
				local var_54_0 = false

				for iter_54_0, iter_54_1 in pairs(arg_52_0.playingDatas) do
					if iter_54_1.inPlaying then
						var_54_0 = true
					end
				end

				if arg_54_1.callback then
					arg_54_1.callback(not var_54_0)
				end

				if not var_54_0 then
					arg_52_0:onRoleSpecial(arg_54_1)
				end

				return
			end)
			arg_52_0._event:bind(var_0_19, function()
				arg_52_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_56_0)
			if arg_56_0.leftRole then
				destroy(arg_56_0.leftRole.tf)

				arg_56_0.leftRole = nil
			end

			if arg_56_0.rightRole then
				destroy(arg_56_0.rightRole.tf)

				arg_56_0.rightRole = nil
			end

			arg_56_0.leftRole = arg_56_0:createRole(var_0_45, true, arg_56_0._leftRolePos)
			arg_56_0.rightRole = arg_56_0:createRole(var_0_46, false, arg_56_0._rightRolePos)
			arg_56_0.leftRole.targetRole = arg_56_0.rightRole
			arg_56_0.rightRole.targetRole = arg_56_0.leftRole

			arg_56_0.leftRole.animator:SetTrigger("idle")
			arg_56_0.leftRole.animator:SetBool("special", false)
			arg_56_0.rightRole.animator:SetTrigger("idle")
			arg_56_0.rightRole.animator:SetBool("special", false)

			arg_56_0.leftRole.specialBody = false
			arg_56_0.rightRole.specialBody = false
			arg_56_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_56_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_56_0.emptySkillTime = math.random(1, 2)
			arg_56_0.addScore = {
				0,
				0
			}

			arg_56_0._event:emit(var_0_16, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_57_0)
			arg_57_0:checkSkillDeltaTime()
			arg_57_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_58_0)
			if arg_58_0.skillDeltaTime and arg_58_0.skillDeltaTime <= 0 then
				arg_58_0.skillDeltaTime = var_0_58
			end

			arg_58_0.skillDeltaTime = arg_58_0.skillDeltaTime - Time.deltaTime

			if arg_58_0.skillDeltaTime <= 0 then
				local var_58_0 = false

				for iter_58_0, iter_58_1 in pairs(arg_58_0.playingDatas) do
					if iter_58_1.inPlaying then
						var_58_0 = true
					end
				end

				if not var_58_0 then
					for iter_58_2, iter_58_3 in pairs(arg_58_0.playingDatas) do
						if #iter_58_3.skillDatas > 0 then
							arg_58_0:applyOrAddSkillData(iter_58_3)

							break
						end
					end
				end
			end

			var_0_78 = false

			for iter_58_4, iter_58_5 in pairs(arg_58_0.playingDatas) do
				if iter_58_5.inPlaying then
					var_0_78 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_59_0)
			if arg_59_0.emptySkillTime and arg_59_0.emptySkillTime <= 0 then
				arg_59_0.emptySkillTime = var_0_59
			end

			arg_59_0.emptySkillTime = arg_59_0.emptySkillTime - Time.deltaTime

			if arg_59_0.emptySkillTime <= 0 then
				local var_59_0 = false

				for iter_59_0, iter_59_1 in pairs(arg_59_0.playingDatas) do
					if iter_59_1.inPlaying then
						var_59_0 = true
					end
				end

				if not var_59_0 then
					local var_59_1 = arg_59_0:getRoleEmptySkill(arg_59_0.rightRole)

					if var_59_1 then
						arg_59_0:addRolePlaying(arg_59_0.rightRole, var_59_1)
					end
				end
			end

			return
		end,
		getRoleTestSkill = function(arg_60_0, arg_60_1)
			return arg_60_1.skill[10]
		end,
		getRoleEmptySkill = function(arg_61_0, arg_61_1)
			for iter_61_0 = 1, #arg_61_1.skill do
				if tobool(arg_61_1.skill[iter_61_0].special_time) == arg_61_1.specialBody and arg_61_1.skill[iter_61_0].atk_index then
					table.insert({}, arg_61_1.skill[iter_61_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_62_0, arg_62_1)
			arg_62_0.leftRole.specialTime = true

			for iter_62_0 = 1, #arg_62_0.leftRole.skill do
				if arg_62_0.leftRole.skill[iter_62_0].special_trigger then
					arg_62_0:addRolePlaying(arg_62_0.leftRole, Clone(arg_62_0.leftRole.skill[iter_62_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_63_0)
			arg_63_0.leftRole.specialTime = false

			local var_63_0

			for iter_63_0 = 1, #arg_63_0.leftRole.skill do
				local var_63_1

				if arg_63_0.leftRole.skill[iter_63_0].special_time and arg_63_0.leftRole.skill[iter_63_0].power_index == 1 and arg_63_0.leftRole.skill[iter_63_0].atk_index > 0 then
					var_63_1 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end

				if not arg_63_0.leftRole.skill[iter_63_0].special_trigger and arg_63_0.leftRole.skill[iter_63_0].special_end then
					var_63_0 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end
			end

			if nil then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, nil)
			end

			if var_63_0 then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, var_63_0)
			end

			return
		end,
		clear = function(arg_64_0)
			if LeanTween.isTweening(go(arg_64_0._leftRolePos)) then
				LeanTween.cancel(go(arg_64_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0._rightRolePos)) then
				LeanTween.cancel(go(arg_64_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_64_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_64_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_64_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_65_0)
			for iter_65_0 = 1, #arg_65_0.leftRole.skill do
				if tobool(arg_65_0.leftRole.skill[iter_65_0].special_time) == tobool(arg_65_0.leftRole.specialTime) and arg_65_0.leftRole.skill[iter_65_0].power_index == var_0_23.power_grid and table.contains(arg_65_0.leftRole.skill[iter_65_0].grid_index, var_0_23.grid_index) and arg_65_0.leftRole.skill[iter_65_0].atk_index then
					arg_65_0:addRolePlaying(arg_65_0.leftRole, Clone(arg_65_0.leftRole.skill[iter_65_0]))
				end
			end

			return
		end,
		createRole = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			local var_66_0 = arg_66_0:getRoleData(arg_66_1)

			if not var_66_0 then
				return nil
			end

			local var_66_1 = {}
			local var_66_2 = tf(instantiate(findTF(arg_66_0._tpl, var_66_0.name)))

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
			for iter_70_0 = 1, #var_0_76 do
				if var_0_76[iter_70_0].index == arg_70_1 then
					return Clone(var_0_76[iter_70_0])
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
		addRolePlaying = function(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
			for iter_73_0, iter_73_1 in pairs(arg_73_0.playingDatas) do
				if iter_73_0 == arg_73_1.name then
					if arg_73_3 then
						arg_73_0:applyOrAddSkillData(iter_73_1, arg_73_2)
					else
						table.insert(iter_73_1.skillDatas, arg_73_2)

						if arg_73_2.power_index > 0 and arg_73_2.atk_index > 1 or arg_73_2.special_trigger then
							for iter_73_2 = #iter_73_1.skillDatas - 1, 1, -1 do
								if iter_73_1.skillDatas[iter_73_2].power_index == 0 and iter_73_1.skillDatas[iter_73_2].atk_index == 1 then
									local var_73_0 = table.remove(iter_73_1.skillDatas, iter_73_2)

									if var_73_0.score then
										arg_73_0.addScore = {
											arg_73_0.addScore[1] + var_73_0.score[1],
											arg_73_0.addScore[2] + var_73_0.score[2]
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

			if arg_74_1.role == arg_74_0.leftRole and not var_74_0.dmg_index then
				arg_74_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_74_1.role == arg_74_0.rightRole and not var_74_0.dmg_index then
				arg_74_0._rightRolePos:SetSiblingIndex(1)
			end

			local var_74_1 = var_74_0.anim_init_pos

			if var_74_0.anim_init_pos then
				findTF(arg_74_1.role.tf, "body/anim").anchoredPosition = var_74_1
			end

			if var_74_0.special_end then
				arg_74_1.role.specialBody = false
			elseif var_74_0.special_trigger then
				arg_74_1.role.specialBody = true
			end

			arg_74_1.actionIndex = 1

			arg_74_0:checkAction(arg_74_1, function()
				arg_74_1.inPlaying = false

				arg_74_0._event:emit(var_0_16, {
					Vector2(0, 0),
					false
				})

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

				if arg_76_1.currentSkill.special_trigger or arg_76_1.currentSkill.special_time and arg_76_1.currentSkill.atk_index and arg_76_1.currentSkill.atk_index >= 2 then
					arg_76_0._event:emit(var_0_22, true)
				end

				if var_76_1 and var_76_1 > 0 then
					-- block empty
				else
					arg_76_0:setDftHandle(arg_76_1.role, function()
						if var_76_5 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_5)
						end

						if var_76_2 then
							arg_76_0:moveRole(arg_76_1.role, var_76_2)
						end

						if var_76_4 then
							arg_76_1.role.targetRole.canvasGroup.alpha = 0

							arg_76_0._event:emit(var_0_20, arg_76_1)
						end

						return
					end, function()
						if var_76_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_6)
						end

						if var_76_4 then
							var_76_4 = false
							arg_76_1.role.targetRole.canvasGroup.alpha = 1

							arg_76_0._event:emit(var_0_21)
						else
							local var_78_0 = arg_76_1.currentSkill.anim_trigger_pos

							if arg_76_1.currentSkill.anim_trigger_pos then
								findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_78_0
							end

							local var_78_1 = arg_76_1.currentSkill.atk_index

							if arg_76_1.currentSkill.atk_index then
								local var_78_2 = arg_76_0:getRoleDmgData(arg_76_1.role.targetRole, var_78_1)

								if var_78_2 then
									for iter_78_0, iter_78_1 in pairs(arg_76_0.playingDatas) do
										if iter_78_0 == arg_76_1.role.targetRole.name then
											arg_76_0:applyOrAddSkillData(iter_78_1, Clone(var_78_2), true)
										end
									end
								end

								if arg_76_1.currentSkill.score and arg_76_1.role == arg_76_0.leftRole then
									arg_76_0._event:emit(var_0_17, math.random(var_78_3[1] + arg_76_0.addScore[1], var_78_3[2] + arg_76_0.addScore[2]))

									arg_76_0.addScore = {
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

						local var_79_0 = arg_76_1.currentSkill.anim_end_pos

						if arg_76_1.currentSkill.anim_end_pos then
							findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_79_0
						end

						arg_76_0._event:emit(var_0_22, false)

						if var_76_3 then
							arg_76_1.role.tf.anchoredPosition = Vector2(arg_76_1.role.tf.anchoredPosition.x + var_76_3.x, arg_76_1.role.tf.anchoredPosition.y + var_76_3.y)
						end

						if arg_76_1.currentSkill.special_trigger and var_0_23.special_time and not var_0_23.special_complete then
							var_0_23.special_complete = true
						end

						arg_76_1.playingAction = nil

						arg_76_0:setDftHandle(arg_76_1.role, nil, nil, nil)
						arg_76_0:checkAction(arg_76_1, arg_76_2)

						return
					end)
					arg_76_0:playAnimation(arg_76_1.role, var_76_0)
				end
			else
				local var_76_8 = arg_76_1.currentSkill.atk_index

				if arg_76_1.currentSkill.atk_index == 3 then
					local var_76_9 = arg_76_0:getRoleDmgBack(arg_76_1.role.targetRole, var_76_8)

					if var_76_9 then
						for iter_76_0, iter_76_1 in pairs(arg_76_0.playingDatas) do
							if iter_76_0 == arg_76_1.role.targetRole.name then
								arg_76_0:applyOrAddSkillData(iter_76_1, Clone(var_76_9))
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
			if LeanTween.isTweening(go(arg_80_1.tf)) then
				LeanTween.cancel(go(arg_80_1.tf))
			end

			if arg_80_2.distance then
				arg_80_0._event:emit(var_0_16, {
					arg_80_2.distance,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_0 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(arg_80_2.distance.x, arg_80_2.distance.y, 0), arg_80_2.time):setEase(var_80_0)
			elseif arg_80_2.distance_m then
				local var_80_1 = Vector2(arg_80_1.tf.anchoredPosition.x + arg_80_2.distance_m.x, arg_80_1.tf.anchoredPosition.y + arg_80_2.distance_m.y)

				arg_80_0._event:emit(var_0_16, {
					var_80_1,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_2 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(var_80_1.x, var_80_1.y, 0), arg_80_2.time):setEase(var_80_2)
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
	}).ctor({
		ctor = function(arg_52_0)
			arg_52_0._scene = arg_51_0
			arg_52_0._tpl = findTF(arg_52_0._scene, "tpl")
			arg_52_0._leftRolePos = findTF(arg_52_0._scene, "rolePos/leftRole")
			arg_52_0._rightRolePos = findTF(arg_52_0._scene, "rolePos/rightRole")
			arg_52_0._event = arg_51_1

			arg_52_0._event:bind(var_0_15, function()
				arg_52_0:onGridTrigger()

				return
			end)
			arg_52_0._event:bind(var_0_18, function(arg_54_0, arg_54_1, arg_54_2)
				local var_54_0 = false

				for iter_54_0, iter_54_1 in pairs(arg_52_0.playingDatas) do
					if iter_54_1.inPlaying then
						var_54_0 = true
					end
				end

				if arg_54_1.callback then
					arg_54_1.callback(not var_54_0)
				end

				if not var_54_0 then
					arg_52_0:onRoleSpecial(arg_54_1)
				end

				return
			end)
			arg_52_0._event:bind(var_0_19, function()
				arg_52_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_56_0)
			if arg_56_0.leftRole then
				destroy(arg_56_0.leftRole.tf)

				arg_56_0.leftRole = nil
			end

			if arg_56_0.rightRole then
				destroy(arg_56_0.rightRole.tf)

				arg_56_0.rightRole = nil
			end

			arg_56_0.leftRole = arg_56_0:createRole(var_0_45, true, arg_56_0._leftRolePos)
			arg_56_0.rightRole = arg_56_0:createRole(var_0_46, false, arg_56_0._rightRolePos)
			arg_56_0.leftRole.targetRole = arg_56_0.rightRole
			arg_56_0.rightRole.targetRole = arg_56_0.leftRole

			arg_56_0.leftRole.animator:SetTrigger("idle")
			arg_56_0.leftRole.animator:SetBool("special", false)
			arg_56_0.rightRole.animator:SetTrigger("idle")
			arg_56_0.rightRole.animator:SetBool("special", false)

			arg_56_0.leftRole.specialBody = false
			arg_56_0.rightRole.specialBody = false
			arg_56_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_56_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_56_0.emptySkillTime = math.random(1, 2)
			arg_56_0.addScore = {
				0,
				0
			}

			arg_56_0._event:emit(var_0_16, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_57_0)
			arg_57_0:checkSkillDeltaTime()
			arg_57_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_58_0)
			if arg_58_0.skillDeltaTime and arg_58_0.skillDeltaTime <= 0 then
				arg_58_0.skillDeltaTime = var_0_58
			end

			arg_58_0.skillDeltaTime = arg_58_0.skillDeltaTime - Time.deltaTime

			if arg_58_0.skillDeltaTime <= 0 then
				local var_58_0 = false

				for iter_58_0, iter_58_1 in pairs(arg_58_0.playingDatas) do
					if iter_58_1.inPlaying then
						var_58_0 = true
					end
				end

				if not var_58_0 then
					for iter_58_2, iter_58_3 in pairs(arg_58_0.playingDatas) do
						if #iter_58_3.skillDatas > 0 then
							arg_58_0:applyOrAddSkillData(iter_58_3)

							break
						end
					end
				end
			end

			var_0_78 = false

			for iter_58_4, iter_58_5 in pairs(arg_58_0.playingDatas) do
				if iter_58_5.inPlaying then
					var_0_78 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_59_0)
			if arg_59_0.emptySkillTime and arg_59_0.emptySkillTime <= 0 then
				arg_59_0.emptySkillTime = var_0_59
			end

			arg_59_0.emptySkillTime = arg_59_0.emptySkillTime - Time.deltaTime

			if arg_59_0.emptySkillTime <= 0 then
				local var_59_0 = false

				for iter_59_0, iter_59_1 in pairs(arg_59_0.playingDatas) do
					if iter_59_1.inPlaying then
						var_59_0 = true
					end
				end

				if not var_59_0 then
					local var_59_1 = arg_59_0:getRoleEmptySkill(arg_59_0.rightRole)

					if var_59_1 then
						arg_59_0:addRolePlaying(arg_59_0.rightRole, var_59_1)
					end
				end
			end

			return
		end,
		getRoleTestSkill = function(arg_60_0, arg_60_1)
			return arg_60_1.skill[10]
		end,
		getRoleEmptySkill = function(arg_61_0, arg_61_1)
			for iter_61_0 = 1, #arg_61_1.skill do
				if tobool(arg_61_1.skill[iter_61_0].special_time) == arg_61_1.specialBody and arg_61_1.skill[iter_61_0].atk_index then
					table.insert({}, arg_61_1.skill[iter_61_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_62_0, arg_62_1)
			arg_62_0.leftRole.specialTime = true

			for iter_62_0 = 1, #arg_62_0.leftRole.skill do
				if arg_62_0.leftRole.skill[iter_62_0].special_trigger then
					arg_62_0:addRolePlaying(arg_62_0.leftRole, Clone(arg_62_0.leftRole.skill[iter_62_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_63_0)
			arg_63_0.leftRole.specialTime = false

			local var_63_0

			for iter_63_0 = 1, #arg_63_0.leftRole.skill do
				local var_63_1

				if arg_63_0.leftRole.skill[iter_63_0].special_time and arg_63_0.leftRole.skill[iter_63_0].power_index == 1 and arg_63_0.leftRole.skill[iter_63_0].atk_index > 0 then
					var_63_1 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end

				if not arg_63_0.leftRole.skill[iter_63_0].special_trigger and arg_63_0.leftRole.skill[iter_63_0].special_end then
					var_63_0 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end
			end

			if nil then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, nil)
			end

			if var_63_0 then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, var_63_0)
			end

			return
		end,
		clear = function(arg_64_0)
			if LeanTween.isTweening(go(arg_64_0._leftRolePos)) then
				LeanTween.cancel(go(arg_64_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0._rightRolePos)) then
				LeanTween.cancel(go(arg_64_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_64_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_64_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_64_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_65_0)
			for iter_65_0 = 1, #arg_65_0.leftRole.skill do
				if tobool(arg_65_0.leftRole.skill[iter_65_0].special_time) == tobool(arg_65_0.leftRole.specialTime) and arg_65_0.leftRole.skill[iter_65_0].power_index == var_0_23.power_grid and table.contains(arg_65_0.leftRole.skill[iter_65_0].grid_index, var_0_23.grid_index) and arg_65_0.leftRole.skill[iter_65_0].atk_index then
					arg_65_0:addRolePlaying(arg_65_0.leftRole, Clone(arg_65_0.leftRole.skill[iter_65_0]))
				end
			end

			return
		end,
		createRole = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			local var_66_0 = arg_66_0:getRoleData(arg_66_1)

			if not var_66_0 then
				return nil
			end

			local var_66_1 = {}
			local var_66_2 = tf(instantiate(findTF(arg_66_0._tpl, var_66_0.name)))

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
			for iter_70_0 = 1, #var_0_76 do
				if var_0_76[iter_70_0].index == arg_70_1 then
					return Clone(var_0_76[iter_70_0])
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
		addRolePlaying = function(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
			for iter_73_0, iter_73_1 in pairs(arg_73_0.playingDatas) do
				if iter_73_0 == arg_73_1.name then
					if arg_73_3 then
						arg_73_0:applyOrAddSkillData(iter_73_1, arg_73_2)
					else
						table.insert(iter_73_1.skillDatas, arg_73_2)

						if arg_73_2.power_index > 0 and arg_73_2.atk_index > 1 or arg_73_2.special_trigger then
							for iter_73_2 = #iter_73_1.skillDatas - 1, 1, -1 do
								if iter_73_1.skillDatas[iter_73_2].power_index == 0 and iter_73_1.skillDatas[iter_73_2].atk_index == 1 then
									local var_73_0 = table.remove(iter_73_1.skillDatas, iter_73_2)

									if var_73_0.score then
										arg_73_0.addScore = {
											arg_73_0.addScore[1] + var_73_0.score[1],
											arg_73_0.addScore[2] + var_73_0.score[2]
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

			if arg_74_1.role == arg_74_0.leftRole and not var_74_0.dmg_index then
				arg_74_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_74_1.role == arg_74_0.rightRole and not var_74_0.dmg_index then
				arg_74_0._rightRolePos:SetSiblingIndex(1)
			end

			local var_74_1 = var_74_0.anim_init_pos

			if var_74_0.anim_init_pos then
				findTF(arg_74_1.role.tf, "body/anim").anchoredPosition = var_74_1
			end

			if var_74_0.special_end then
				arg_74_1.role.specialBody = false
			elseif var_74_0.special_trigger then
				arg_74_1.role.specialBody = true
			end

			arg_74_1.actionIndex = 1

			arg_74_0:checkAction(arg_74_1, function()
				arg_74_1.inPlaying = false

				arg_74_0._event:emit(var_0_16, {
					Vector2(0, 0),
					false
				})

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

				if arg_76_1.currentSkill.special_trigger or arg_76_1.currentSkill.special_time and arg_76_1.currentSkill.atk_index and arg_76_1.currentSkill.atk_index >= 2 then
					arg_76_0._event:emit(var_0_22, true)
				end

				if var_76_1 and var_76_1 > 0 then
					-- block empty
				else
					arg_76_0:setDftHandle(arg_76_1.role, function()
						if var_76_5 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_5)
						end

						if var_76_2 then
							arg_76_0:moveRole(arg_76_1.role, var_76_2)
						end

						if var_76_4 then
							arg_76_1.role.targetRole.canvasGroup.alpha = 0

							arg_76_0._event:emit(var_0_20, arg_76_1)
						end

						return
					end, function()
						if var_76_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_6)
						end

						if var_76_4 then
							var_76_4 = false
							arg_76_1.role.targetRole.canvasGroup.alpha = 1

							arg_76_0._event:emit(var_0_21)
						else
							local var_78_0 = arg_76_1.currentSkill.anim_trigger_pos

							if arg_76_1.currentSkill.anim_trigger_pos then
								findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_78_0
							end

							local var_78_1 = arg_76_1.currentSkill.atk_index

							if arg_76_1.currentSkill.atk_index then
								local var_78_2 = arg_76_0:getRoleDmgData(arg_76_1.role.targetRole, var_78_1)

								if var_78_2 then
									for iter_78_0, iter_78_1 in pairs(arg_76_0.playingDatas) do
										if iter_78_0 == arg_76_1.role.targetRole.name then
											arg_76_0:applyOrAddSkillData(iter_78_1, Clone(var_78_2), true)
										end
									end
								end

								if arg_76_1.currentSkill.score and arg_76_1.role == arg_76_0.leftRole then
									arg_76_0._event:emit(var_0_17, math.random(var_78_3[1] + arg_76_0.addScore[1], var_78_3[2] + arg_76_0.addScore[2]))

									arg_76_0.addScore = {
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

						local var_79_0 = arg_76_1.currentSkill.anim_end_pos

						if arg_76_1.currentSkill.anim_end_pos then
							findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_79_0
						end

						arg_76_0._event:emit(var_0_22, false)

						if var_76_3 then
							arg_76_1.role.tf.anchoredPosition = Vector2(arg_76_1.role.tf.anchoredPosition.x + var_76_3.x, arg_76_1.role.tf.anchoredPosition.y + var_76_3.y)
						end

						if arg_76_1.currentSkill.special_trigger and var_0_23.special_time and not var_0_23.special_complete then
							var_0_23.special_complete = true
						end

						arg_76_1.playingAction = nil

						arg_76_0:setDftHandle(arg_76_1.role, nil, nil, nil)
						arg_76_0:checkAction(arg_76_1, arg_76_2)

						return
					end)
					arg_76_0:playAnimation(arg_76_1.role, var_76_0)
				end
			else
				local var_76_8 = arg_76_1.currentSkill.atk_index

				if arg_76_1.currentSkill.atk_index == 3 then
					local var_76_9 = arg_76_0:getRoleDmgBack(arg_76_1.role.targetRole, var_76_8)

					if var_76_9 then
						for iter_76_0, iter_76_1 in pairs(arg_76_0.playingDatas) do
							if iter_76_0 == arg_76_1.role.targetRole.name then
								arg_76_0:applyOrAddSkillData(iter_76_1, Clone(var_76_9))
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
			if LeanTween.isTweening(go(arg_80_1.tf)) then
				LeanTween.cancel(go(arg_80_1.tf))
			end

			if arg_80_2.distance then
				arg_80_0._event:emit(var_0_16, {
					arg_80_2.distance,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_0 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(arg_80_2.distance.x, arg_80_2.distance.y, 0), arg_80_2.time):setEase(var_80_0)
			elseif arg_80_2.distance_m then
				local var_80_1 = Vector2(arg_80_1.tf.anchoredPosition.x + arg_80_2.distance_m.x, arg_80_1.tf.anchoredPosition.y + arg_80_2.distance_m.y)

				arg_80_0._event:emit(var_0_16, {
					var_80_1,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_2 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(var_80_1.x, var_80_1.y, 0), arg_80_2.time):setEase(var_80_2)
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
	})

	return {
		ctor = function(arg_52_0)
			arg_52_0._scene = arg_51_0
			arg_52_0._tpl = findTF(arg_52_0._scene, "tpl")
			arg_52_0._leftRolePos = findTF(arg_52_0._scene, "rolePos/leftRole")
			arg_52_0._rightRolePos = findTF(arg_52_0._scene, "rolePos/rightRole")
			arg_52_0._event = arg_51_1

			arg_52_0._event:bind(var_0_15, function()
				arg_52_0:onGridTrigger()

				return
			end)
			arg_52_0._event:bind(var_0_18, function(arg_54_0, arg_54_1, arg_54_2)
				local var_54_0 = false

				for iter_54_0, iter_54_1 in pairs(arg_52_0.playingDatas) do
					if iter_54_1.inPlaying then
						var_54_0 = true
					end
				end

				if arg_54_1.callback then
					arg_54_1.callback(not var_54_0)
				end

				if not var_54_0 then
					arg_52_0:onRoleSpecial(arg_54_1)
				end

				return
			end)
			arg_52_0._event:bind(var_0_19, function()
				arg_52_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_56_0)
			if arg_56_0.leftRole then
				destroy(arg_56_0.leftRole.tf)

				arg_56_0.leftRole = nil
			end

			if arg_56_0.rightRole then
				destroy(arg_56_0.rightRole.tf)

				arg_56_0.rightRole = nil
			end

			arg_56_0.leftRole = arg_56_0:createRole(var_0_45, true, arg_56_0._leftRolePos)
			arg_56_0.rightRole = arg_56_0:createRole(var_0_46, false, arg_56_0._rightRolePos)
			arg_56_0.leftRole.targetRole = arg_56_0.rightRole
			arg_56_0.rightRole.targetRole = arg_56_0.leftRole

			arg_56_0.leftRole.animator:SetTrigger("idle")
			arg_56_0.leftRole.animator:SetBool("special", false)
			arg_56_0.rightRole.animator:SetTrigger("idle")
			arg_56_0.rightRole.animator:SetBool("special", false)

			arg_56_0.leftRole.specialBody = false
			arg_56_0.rightRole.specialBody = false
			arg_56_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_56_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_56_0.emptySkillTime = math.random(1, 2)
			arg_56_0.addScore = {
				0,
				0
			}

			arg_56_0._event:emit(var_0_16, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_57_0)
			arg_57_0:checkSkillDeltaTime()
			arg_57_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_58_0)
			if arg_58_0.skillDeltaTime and arg_58_0.skillDeltaTime <= 0 then
				arg_58_0.skillDeltaTime = var_0_58
			end

			arg_58_0.skillDeltaTime = arg_58_0.skillDeltaTime - Time.deltaTime

			if arg_58_0.skillDeltaTime <= 0 then
				local var_58_0 = false

				for iter_58_0, iter_58_1 in pairs(arg_58_0.playingDatas) do
					if iter_58_1.inPlaying then
						var_58_0 = true
					end
				end

				if not var_58_0 then
					for iter_58_2, iter_58_3 in pairs(arg_58_0.playingDatas) do
						if #iter_58_3.skillDatas > 0 then
							arg_58_0:applyOrAddSkillData(iter_58_3)

							break
						end
					end
				end
			end

			var_0_78 = false

			for iter_58_4, iter_58_5 in pairs(arg_58_0.playingDatas) do
				if iter_58_5.inPlaying then
					var_0_78 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_59_0)
			if arg_59_0.emptySkillTime and arg_59_0.emptySkillTime <= 0 then
				arg_59_0.emptySkillTime = var_0_59
			end

			arg_59_0.emptySkillTime = arg_59_0.emptySkillTime - Time.deltaTime

			if arg_59_0.emptySkillTime <= 0 then
				local var_59_0 = false

				for iter_59_0, iter_59_1 in pairs(arg_59_0.playingDatas) do
					if iter_59_1.inPlaying then
						var_59_0 = true
					end
				end

				if not var_59_0 then
					local var_59_1 = arg_59_0:getRoleEmptySkill(arg_59_0.rightRole)

					if var_59_1 then
						arg_59_0:addRolePlaying(arg_59_0.rightRole, var_59_1)
					end
				end
			end

			return
		end,
		getRoleTestSkill = function(arg_60_0, arg_60_1)
			return arg_60_1.skill[10]
		end,
		getRoleEmptySkill = function(arg_61_0, arg_61_1)
			for iter_61_0 = 1, #arg_61_1.skill do
				if tobool(arg_61_1.skill[iter_61_0].special_time) == arg_61_1.specialBody and arg_61_1.skill[iter_61_0].atk_index then
					table.insert({}, arg_61_1.skill[iter_61_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_62_0, arg_62_1)
			arg_62_0.leftRole.specialTime = true

			for iter_62_0 = 1, #arg_62_0.leftRole.skill do
				if arg_62_0.leftRole.skill[iter_62_0].special_trigger then
					arg_62_0:addRolePlaying(arg_62_0.leftRole, Clone(arg_62_0.leftRole.skill[iter_62_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_63_0)
			arg_63_0.leftRole.specialTime = false

			local var_63_0

			for iter_63_0 = 1, #arg_63_0.leftRole.skill do
				local var_63_1

				if arg_63_0.leftRole.skill[iter_63_0].special_time and arg_63_0.leftRole.skill[iter_63_0].power_index == 1 and arg_63_0.leftRole.skill[iter_63_0].atk_index > 0 then
					var_63_1 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end

				if not arg_63_0.leftRole.skill[iter_63_0].special_trigger and arg_63_0.leftRole.skill[iter_63_0].special_end then
					var_63_0 = Clone(arg_63_0.leftRole.skill[iter_63_0])
				end
			end

			if nil then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, nil)
			end

			if var_63_0 then
				arg_63_0:addRolePlaying(arg_63_0.leftRole, var_63_0)
			end

			return
		end,
		clear = function(arg_64_0)
			if LeanTween.isTweening(go(arg_64_0._leftRolePos)) then
				LeanTween.cancel(go(arg_64_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0._rightRolePos)) then
				LeanTween.cancel(go(arg_64_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_64_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_64_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_64_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_64_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_65_0)
			for iter_65_0 = 1, #arg_65_0.leftRole.skill do
				if tobool(arg_65_0.leftRole.skill[iter_65_0].special_time) == tobool(arg_65_0.leftRole.specialTime) and arg_65_0.leftRole.skill[iter_65_0].power_index == var_0_23.power_grid and table.contains(arg_65_0.leftRole.skill[iter_65_0].grid_index, var_0_23.grid_index) and arg_65_0.leftRole.skill[iter_65_0].atk_index then
					arg_65_0:addRolePlaying(arg_65_0.leftRole, Clone(arg_65_0.leftRole.skill[iter_65_0]))
				end
			end

			return
		end,
		createRole = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			local var_66_0 = arg_66_0:getRoleData(arg_66_1)

			if not var_66_0 then
				return nil
			end

			local var_66_1 = {}
			local var_66_2 = tf(instantiate(findTF(arg_66_0._tpl, var_66_0.name)))

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
			for iter_70_0 = 1, #var_0_76 do
				if var_0_76[iter_70_0].index == arg_70_1 then
					return Clone(var_0_76[iter_70_0])
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
		addRolePlaying = function(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
			for iter_73_0, iter_73_1 in pairs(arg_73_0.playingDatas) do
				if iter_73_0 == arg_73_1.name then
					if arg_73_3 then
						arg_73_0:applyOrAddSkillData(iter_73_1, arg_73_2)
					else
						table.insert(iter_73_1.skillDatas, arg_73_2)

						if arg_73_2.power_index > 0 and arg_73_2.atk_index > 1 or arg_73_2.special_trigger then
							for iter_73_2 = #iter_73_1.skillDatas - 1, 1, -1 do
								if iter_73_1.skillDatas[iter_73_2].power_index == 0 and iter_73_1.skillDatas[iter_73_2].atk_index == 1 then
									local var_73_0 = table.remove(iter_73_1.skillDatas, iter_73_2)

									if var_73_0.score then
										arg_73_0.addScore = {
											arg_73_0.addScore[1] + var_73_0.score[1],
											arg_73_0.addScore[2] + var_73_0.score[2]
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

			if arg_74_1.role == arg_74_0.leftRole and not var_74_0.dmg_index then
				arg_74_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_74_1.role == arg_74_0.rightRole and not var_74_0.dmg_index then
				arg_74_0._rightRolePos:SetSiblingIndex(1)
			end

			local var_74_1 = var_74_0.anim_init_pos

			if var_74_0.anim_init_pos then
				findTF(arg_74_1.role.tf, "body/anim").anchoredPosition = var_74_1
			end

			if var_74_0.special_end then
				arg_74_1.role.specialBody = false
			elseif var_74_0.special_trigger then
				arg_74_1.role.specialBody = true
			end

			arg_74_1.actionIndex = 1

			arg_74_0:checkAction(arg_74_1, function()
				arg_74_1.inPlaying = false

				arg_74_0._event:emit(var_0_16, {
					Vector2(0, 0),
					false
				})

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

				if arg_76_1.currentSkill.special_trigger or arg_76_1.currentSkill.special_time and arg_76_1.currentSkill.atk_index and arg_76_1.currentSkill.atk_index >= 2 then
					arg_76_0._event:emit(var_0_22, true)
				end

				if var_76_1 and var_76_1 > 0 then
					-- block empty
				else
					arg_76_0:setDftHandle(arg_76_1.role, function()
						if var_76_5 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_5)
						end

						if var_76_2 then
							arg_76_0:moveRole(arg_76_1.role, var_76_2)
						end

						if var_76_4 then
							arg_76_1.role.targetRole.canvasGroup.alpha = 0

							arg_76_0._event:emit(var_0_20, arg_76_1)
						end

						return
					end, function()
						if var_76_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_76_6)
						end

						if var_76_4 then
							var_76_4 = false
							arg_76_1.role.targetRole.canvasGroup.alpha = 1

							arg_76_0._event:emit(var_0_21)
						else
							local var_78_0 = arg_76_1.currentSkill.anim_trigger_pos

							if arg_76_1.currentSkill.anim_trigger_pos then
								findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_78_0
							end

							local var_78_1 = arg_76_1.currentSkill.atk_index

							if arg_76_1.currentSkill.atk_index then
								local var_78_2 = arg_76_0:getRoleDmgData(arg_76_1.role.targetRole, var_78_1)

								if var_78_2 then
									for iter_78_0, iter_78_1 in pairs(arg_76_0.playingDatas) do
										if iter_78_0 == arg_76_1.role.targetRole.name then
											arg_76_0:applyOrAddSkillData(iter_78_1, Clone(var_78_2), true)
										end
									end
								end

								if arg_76_1.currentSkill.score and arg_76_1.role == arg_76_0.leftRole then
									arg_76_0._event:emit(var_0_17, math.random(var_78_3[1] + arg_76_0.addScore[1], var_78_3[2] + arg_76_0.addScore[2]))

									arg_76_0.addScore = {
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

						local var_79_0 = arg_76_1.currentSkill.anim_end_pos

						if arg_76_1.currentSkill.anim_end_pos then
							findTF(arg_76_1.role.tf, "body/anim").anchoredPosition = var_79_0
						end

						arg_76_0._event:emit(var_0_22, false)

						if var_76_3 then
							arg_76_1.role.tf.anchoredPosition = Vector2(arg_76_1.role.tf.anchoredPosition.x + var_76_3.x, arg_76_1.role.tf.anchoredPosition.y + var_76_3.y)
						end

						if arg_76_1.currentSkill.special_trigger and var_0_23.special_time and not var_0_23.special_complete then
							var_0_23.special_complete = true
						end

						arg_76_1.playingAction = nil

						arg_76_0:setDftHandle(arg_76_1.role, nil, nil, nil)
						arg_76_0:checkAction(arg_76_1, arg_76_2)

						return
					end)
					arg_76_0:playAnimation(arg_76_1.role, var_76_0)
				end
			else
				local var_76_8 = arg_76_1.currentSkill.atk_index

				if arg_76_1.currentSkill.atk_index == 3 then
					local var_76_9 = arg_76_0:getRoleDmgBack(arg_76_1.role.targetRole, var_76_8)

					if var_76_9 then
						for iter_76_0, iter_76_1 in pairs(arg_76_0.playingDatas) do
							if iter_76_0 == arg_76_1.role.targetRole.name then
								arg_76_0:applyOrAddSkillData(iter_76_1, Clone(var_76_9))
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
			if LeanTween.isTweening(go(arg_80_1.tf)) then
				LeanTween.cancel(go(arg_80_1.tf))
			end

			if arg_80_2.distance then
				arg_80_0._event:emit(var_0_16, {
					arg_80_2.distance,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_0 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(arg_80_2.distance.x, arg_80_2.distance.y, 0), arg_80_2.time):setEase(var_80_0)
			elseif arg_80_2.distance_m then
				local var_80_1 = Vector2(arg_80_1.tf.anchoredPosition.x + arg_80_2.distance_m.x, arg_80_1.tf.anchoredPosition.y + arg_80_2.distance_m.y)

				arg_80_0._event:emit(var_0_16, {
					var_80_1,
					arg_80_1 == arg_80_0.leftRole
				})

				local var_80_2 = arg_80_2.ease or LeanTweenType.linear

				LeanTween.move(arg_80_1.tf, Vector3(var_80_1.x, var_80_1.y, 0), arg_80_2.time):setEase(var_80_2)
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
end

function var_0_0.getUIName(arg_83_0)
	return "GridGameReUI"
end

function var_0_0.didEnter(arg_84_0)
	arg_84_0:initEvent()
	arg_84_0:initData()
	arg_84_0:initUI()
	arg_84_0:initGameUI()
	arg_84_0:initController()
	arg_84_0:updateMenuUI()
	arg_84_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_85_0)
	arg_85_0:bind(var_0_17, function(arg_86_0, arg_86_1, arg_86_2)
		arg_85_0:addScore(arg_86_1)

		return
	end)
	arg_85_0:bind(var_0_22, function(arg_87_0, arg_87_1, arg_87_2)
		arg_85_0.ignoreTime = arg_87_1

		return
	end)

	return
end

function var_0_0.onEventHandle(arg_88_0, arg_88_1)
	return
end

function var_0_0.initData(arg_89_0)
	local var_89_0 = Application.targetFrameRate or 60

	if var_89_0 > 60 then
		var_89_0 = 60
	end

	arg_89_0.timer = Timer.New(function()
		arg_89_0:onTimer()

		return
	end, 1 / var_89_0, -1)

	return
end

function var_0_0.initUI(arg_91_0)
	arg_91_0.backSceneTf = findTF(arg_91_0._tf, "scene_background")
	arg_91_0.sceneTf = findTF(arg_91_0._tf, "scene")
	arg_91_0.clickMask = findTF(arg_91_0._tf, "clickMask")

	setText(findTF(arg_91_0._tf, "ui/gameUI/top/time"), i18n("mini_game_time"))
	setText(findTF(arg_91_0._tf, "ui/gameUI/top/scoreDesc"), i18n("mini_game_score"))
	setText(findTF(arg_91_0._tf, "pop/LeaveUI/ad/desc"), i18n("mini_game_leave"))
	setText(findTF(arg_91_0._tf, "pop/pauseUI/ad/desc"), i18n("mini_game_pause"))
	setText(findTF(arg_91_0._tf, "pop/SettleMentUI/ad/currentTextDesc"), i18n("mini_game_cur_score"))
	setText(findTF(arg_91_0._tf, "pop/SettleMentUI/ad/highTextDesc"), i18n("mini_game_high_score"))

	arg_91_0.countUI = findTF(arg_91_0._tf, "pop/CountUI")
	arg_91_0.countAnimator = GetComponent(findTF(arg_91_0.countUI, "count"), typeof(Animator))
	arg_91_0.countDft = GetOrAddComponent(findTF(arg_91_0.countUI, "count"), typeof(DftAniEvent))

	arg_91_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_91_0.countDft:SetEndEvent(function()
		setActive(arg_91_0.countUI, false)
		arg_91_0:gameStart()

		return
	end)

	arg_91_0.leaveUI = findTF(arg_91_0._tf, "pop/LeaveUI")

	onButton(arg_91_0, findTF(arg_91_0.leaveUI, "ad/btnOk"), function()
		arg_91_0:resumeGame()
		arg_91_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_91_0, findTF(arg_91_0.leaveUI, "ad/btnCancel"), function()
		arg_91_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_91_0.pauseUI = findTF(arg_91_0._tf, "pop/pauseUI")

	onButton(arg_91_0, findTF(arg_91_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_91_0.pauseUI, false)
		arg_91_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_91_0.settlementUI = findTF(arg_91_0._tf, "pop/SettleMentUI")

	onButton(arg_91_0, findTF(arg_91_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_91_0.settlementUI, false)
		arg_91_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_91_0.selectedUI = findTF(arg_91_0._tf, "pop/selectedUI")
	arg_91_0.leftSelectRole = {}

	for iter_91_0 = 1, #var_0_49 do
		local var_91_0 = findTF(arg_91_0.selectedUI, "ad/leftRole/role" .. var_0_49[iter_91_0])

		setActive(var_91_0, true)

		local var_91_1 = var_0_49[iter_91_0]

		onButton(arg_91_0, var_91_0, function()
			var_0_45, var_0_46 = arg_91_0:checkRoleId(var_91_1, var_0_46, var_0_50)

			arg_91_0:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(arg_91_0.leftSelectRole, {
			id = var_0_49[iter_91_0],
			tf = var_91_0
		})
	end

	onButton(arg_91_0, findTF(arg_91_0.selectedUI, "close"), function()
		setActive(arg_91_0.selectedUI, false)

		return
	end, SFX_CANCEL)

	arg_91_0.rightSelectRole = {}

	for iter_91_1 = 1, #var_0_50 do
		local var_91_2 = findTF(arg_91_0.selectedUI, "ad/rightRole/role" .. var_0_50[iter_91_1])

		setActive(var_91_2, true)

		local var_91_3 = var_0_50[iter_91_1]

		onButton(arg_91_0, var_91_2, function()
			var_0_46, var_0_45 = arg_91_0:checkRoleId(var_91_3, var_0_45, var_0_49)

			arg_91_0:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(arg_91_0.rightSelectRole, {
			id = var_0_50[iter_91_1],
			tf = var_91_2
		})
	end

	onButton(arg_91_0, findTF(arg_91_0.selectedUI, "ad/btnOk"), function()
		setActive(arg_91_0.selectedUI, false)
		setActive(arg_91_0.menuUI, false)
		arg_91_0:readyStart()

		return
	end, SFX_CONFIRM)

	arg_91_0.btnDay = findTF(arg_91_0.selectedUI, "ad/btnDay")
	arg_91_0.btnNight = findTF(arg_91_0.selectedUI, "ad/btnNight")

	local var_91_4 = arg_91_0:getGameUsedTimes() or 0

	if var_0_52[var_91_4 + 1] then
		var_0_69 = var_0_52[var_91_4 + 1] or var_0_68

		setActive(findTF(arg_91_0.btnDay, "on"), var_0_69 == var_0_67)
		setActive(findTF(arg_91_0.btnNight, "on"), var_0_69 == var_0_68)
		onButton(arg_91_0, arg_91_0.btnDay, function()
			var_0_69 = var_0_67

			setActive(findTF(arg_91_0.btnDay, "on"), true)
			setActive(findTF(arg_91_0.btnNight, "on"), false)
			arg_91_0:updateMenuUI()

			return
		end, SFX_CONFIRM)
		onButton(arg_91_0, arg_91_0.btnNight, function()
			var_0_69 = var_0_68

			setActive(findTF(arg_91_0.btnDay, "on"), false)
			setActive(findTF(arg_91_0.btnNight, "on"), true)
			arg_91_0:updateMenuUI()

			return
		end, SFX_CONFIRM)
		setActive(arg_91_0.selectedUI, false)

		arg_91_0.menuUI = findTF(arg_91_0._tf, "pop/menuUI")
		arg_91_0.battleScrollRect = GetComponent(findTF(arg_91_0.menuUI, "battList"), typeof(ScrollRect))
		arg_91_0.totalTimes = arg_91_0:getGameTotalTime()

		scrollTo(arg_91_0.battleScrollRect, 0, 1 - (arg_91_0:getGameUsedTimes() - 4 < 0 and 0 or arg_91_0:getGameUsedTimes() - 4) / (arg_91_0.totalTimes - 4))
		onButton(arg_91_0, findTF(arg_91_0.menuUI, "rightPanelBg/arrowUp"), function()
			local var_104_0 = arg_91_0.battleScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4)

			if arg_91_0.battleScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4) > 1 then
				var_104_0 = 1
			end

			scrollTo(arg_91_0.battleScrollRect, 0, var_104_0)

			return
		end, SFX_CANCEL)
		onButton(arg_91_0, findTF(arg_91_0.menuUI, "rightPanelBg/arrowDown"), function()
			local var_105_0 = arg_91_0.battleScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4)

			if arg_91_0.battleScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4) < 0 then
				var_105_0 = 0
			end

			scrollTo(arg_91_0.battleScrollRect, 0, var_105_0)

			return
		end, SFX_CANCEL)
		onButton(arg_91_0, findTF(arg_91_0.menuUI, "btnBack"), function()
			arg_91_0:closeView()

			return
		end, SFX_CANCEL)
		onButton(arg_91_0, findTF(arg_91_0.menuUI, "btnRule"), function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_HELP,
				helps = pg.gametip.ssss_game_tip.tip
			})

			return
		end, SFX_CONFIRM)
		onButton(arg_91_0, findTF(arg_91_0.menuUI, "btnStart"), function()
			local var_108_0 = arg_91_0:getGameUsedTimes() or 0
			local var_108_1 = arg_91_0:getGameTimes() or 0

			if var_108_0 >= var_0_54 and arg_91_0.selectedUI then
				arg_91_0:updateSelectedUI()
				setActive(arg_91_0.selectedUI, true)

				goto label_108_0
			end

			::label_108_0::

			if var_0_52[var_108_0 + 1] then
				var_0_69 = var_0_52[var_108_0 + 1] or 1

				if var_108_2 > #var_0_51 then
					var_108_2 = #var_0_51
				end

				do
					local var_108_4 = var_0_51[var_108_2]

					var_0_45 = var_0_51[var_108_2][1]
					var_0_46 = var_108_4[2]

					setActive(arg_91_0.menuUI, false)
					arg_91_0:readyStart()
				end

				return
			end
		end, SFX_CONFIRM)

		local var_91_5 = findTF(arg_91_0.menuUI, "tplBattleItem")

		arg_91_0.battleItems = {}
		arg_91_0.dropItems = {}

		for iter_91_2 = 1, 7 do
			local var_91_6 = tf(instantiate(var_91_5))

			var_91_6.name = "battleItem_" .. iter_91_2

			setParent(var_91_6, findTF(arg_91_0.menuUI, "battList/Viewport/Content"))
			GetSpriteFromAtlasAsync(var_0_6, "battleDesc" .. iter_91_2, function(arg_109_0)
				setImageSprite(findTF(var_91_6, "state_open/buttomDesc"), arg_109_0, true)
				setImageSprite(findTF(var_91_6, "state_clear/buttomDesc"), arg_109_0, true)
				setImageSprite(findTF(var_91_6, "state_current/buttomDesc"), arg_109_0, true)
				setImageSprite(findTF(var_91_6, "state_closed/buttomDesc"), arg_109_0, true)

				return
			end)
			setActive(var_91_6, true)
			table.insert(arg_91_0.battleItems, var_91_6)
		end

		arg_91_0.handle = arg_91_0.handle or UpdateBeat:CreateListener(arg_91_0.Update, arg_91_0)

		UpdateBeat:AddListener(arg_91_0.handle)

		return
	end
end

function var_0_0.checkRoleId(arg_110_0, arg_110_1, arg_110_2, arg_110_3)
	if not arg_110_0:matchRoleId(arg_110_1, arg_110_2) then
		for iter_110_0 = 1, #arg_110_3 do
			if arg_110_0:matchRoleId(arg_110_1, arg_110_3[iter_110_0]) then
				return arg_110_1, arg_110_3[iter_110_0]
			end
		end
	end

	return arg_110_1, arg_110_2
end

function var_0_0.matchRoleId(arg_111_0, arg_111_1, arg_111_2)
	if arg_111_1 == arg_111_2 then
		return false
	end

	for iter_111_0 = 1, #var_0_48 do
		if table.contains(var_0_48[iter_111_0], arg_111_1) and table.contains(var_0_48[iter_111_0], arg_111_2) then
			return false
		end
	end

	return true
end

function var_0_0.initGameUI(arg_112_0)
	arg_112_0.gameUI = findTF(arg_112_0._tf, "ui/gameUI")

	onButton(arg_112_0, findTF(arg_112_0.gameUI, "topRight/btnStop"), function()
		arg_112_0:stopGame()
		setActive(arg_112_0.pauseUI, true)

		return
	end)
	onButton(arg_112_0, findTF(arg_112_0.gameUI, "btnLeave"), function()
		arg_112_0:stopGame()
		setActive(arg_112_0.leaveUI, true)

		return
	end)

	arg_112_0.gameTimeS = findTF(arg_112_0.gameUI, "top/time/s")
	arg_112_0.scoreTf = findTF(arg_112_0.gameUI, "top/score")
	arg_112_0.scoreAnimTf = findTF(arg_112_0._tf, "sceneContainer/scene_front/scoreAnim")
	arg_112_0.scoreAnimTextTf = findTF(arg_112_0._tf, "sceneContainer/scene_front/scoreAnim/text")

	setActive(arg_112_0.scoreAnimTf, false)

	return
end

function var_0_0.initController(arg_115_0)
	arg_115_0.boxController = var_0_77(findTF(arg_115_0.gameUI, "box"), arg_115_0)
	arg_115_0.specialController = var_0_79(findTF(arg_115_0.gameUI, "specialPower"), findTF(arg_115_0.gameUI, "successPower"), arg_115_0)
	arg_115_0.bgController = var_0_80(findTF(arg_115_0._tf, "sceneContainer"), arg_115_0.gameUI, arg_115_0)
	arg_115_0.roleController = var_0_81(findTF(arg_115_0._tf, "sceneContainer/scene"), arg_115_0)

	return
end

function var_0_0.Update(arg_116_0)
	arg_116_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_117_0)
	if arg_117_0.gameStop or arg_117_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateSelectedUI(arg_118_0)
	for iter_118_0 = 1, #arg_118_0.leftSelectRole do
		if var_0_45 == arg_118_0.leftSelectRole[iter_118_0].id then
			setActive(findTF(arg_118_0.leftSelectRole[iter_118_0].tf, "selected"), true)
			setActive(findTF(arg_118_0.leftSelectRole[iter_118_0].tf, "unSelected"), false)
		else
			setActive(findTF(arg_118_0.leftSelectRole[iter_118_0].tf, "selected"), false)
			setActive(findTF(arg_118_0.leftSelectRole[iter_118_0].tf, "unSelected"), true)
		end
	end

	for iter_118_1 = 1, #arg_118_0.rightSelectRole do
		setGray(arg_118_0.rightSelectRole[iter_118_1].tf, not arg_118_0:matchRoleId(var_0_45, arg_118_0.rightSelectRole[iter_118_1].id), true)

		if var_0_46 == arg_118_0.rightSelectRole[iter_118_1].id then
			setActive(findTF(arg_118_0.rightSelectRole[iter_118_1].tf, "selected"), true)
			setActive(findTF(arg_118_0.rightSelectRole[iter_118_1].tf, "unSelected"), false)
		else
			setActive(findTF(arg_118_0.rightSelectRole[iter_118_1].tf, "selected"), false)
			setActive(findTF(arg_118_0.rightSelectRole[iter_118_1].tf, "unSelected"), true)
		end
	end

	return
end

function var_0_0.updateMenuUI(arg_119_0)
	local var_119_0 = arg_119_0:getGameUsedTimes()

	if var_119_0 and var_119_0 >= 7 then
		setActive(findTF(arg_119_0.menuUI, "btnStart/free"), true)
	else
		setActive(findTF(arg_119_0.menuUI, "btnStart/free"), false)
	end

	local var_119_1 = arg_119_0:getGameTimes()

	for iter_119_0 = 1, #arg_119_0.battleItems do
		setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_open"), false)
		setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_closed"), false)
		setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_clear"), false)
		setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_current"), false)

		if iter_119_0 <= var_119_0 then
			setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_clear"), true)
		elseif iter_119_0 == var_119_0 + 1 and var_119_1 >= 1 then
			setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_current"), true)
		elseif var_119_0 < iter_119_0 and iter_119_0 <= var_119_0 + var_119_1 then
			setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_open"), true)
		else
			setActive(findTF(arg_119_0.battleItems[iter_119_0], "state_closed"), true)
		end
	end

	arg_119_0.totalTimes = arg_119_0:getGameTotalTime()

	local var_119_2 = 1 - (arg_119_0:getGameUsedTimes() - 3 < 0 and 0 or arg_119_0:getGameUsedTimes() - 3) / (arg_119_0.totalTimes - 4)

	if var_119_2 > 1 then
		var_119_2 = 1
	end

	scrollTo(arg_119_0.battleScrollRect, 0, var_119_2)
	setActive(findTF(arg_119_0.menuUI, "btnStart/tip"), var_119_1 > 0)

	local var_119_3

	if var_0_69 == var_0_67 then
		var_119_3 = var_0_64
	elseif var_0_69 == var_0_68 then
		var_119_3 = var_0_65
	end

	for iter_119_1, iter_119_2 in ipairs(var_0_63) do
		setActive(findTF(arg_119_0._tf, "bg/" .. iter_119_2), table.contains(var_119_3, iter_119_2))
	end

	setActive(findTF(arg_119_0.menuUI, "bg/title_day"), var_0_69 == var_0_67)
	setActive(findTF(arg_119_0.menuUI, "bg/title_night"), var_0_69 ~= var_0_67)
	arg_119_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_120_0)
	setActive(findTF(arg_120_0.menuUI, "got"), false)

	if arg_120_0:getUltimate() and arg_120_0:getUltimate() ~= 0 then
		setActive(findTF(arg_120_0.menuUI, "got"), true)
	end

	if arg_120_0:getUltimate() == 0 then
		if arg_120_0:getGameTotalTime() > arg_120_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_120_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_120_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_121_0)
	setActive(findTF(arg_121_0._tf, "sceneContainer/scene_front"), false)
	setActive(findTF(arg_121_0._tf, "sceneContainer/scene_background"), false)
	setActive(findTF(arg_121_0._tf, "sceneContainer/scene"), false)
	setActive(arg_121_0.gameUI, false)
	setActive(arg_121_0.menuUI, true)
	setActive(arg_121_0.selectedUI, false)
	arg_121_0:updateMenuUI()

	local var_121_0 = arg_121_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

	if arg_121_0.bgm ~= var_121_0 then
		arg_121_0.bgm = var_121_0

		pg.BgmMgr.GetInstance():Push(arg_121_0.__cname, var_121_0)
	end

	return
end

function var_0_0.clearUI(arg_122_0)
	setActive(arg_122_0.sceneTf, false)
	setActive(arg_122_0.settlementUI, false)
	setActive(arg_122_0.countUI, false)
	setActive(arg_122_0.menuUI, false)
	setActive(arg_122_0.gameUI, false)
	setActive(arg_122_0.selectedUI, false)

	return
end

function var_0_0.readyStart(arg_123_0)
	setActive(arg_123_0.countUI, true)
	arg_123_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

	if var_0_2 and arg_123_0.bgm ~= var_0_2 then
		arg_123_0.bgm = var_0_2

		pg.BgmMgr.GetInstance():Push(arg_123_0.__cname, var_0_2)
	end

	return
end

function var_0_0.gameStart(arg_124_0)
	setActive(findTF(arg_124_0._tf, "sceneContainer/scene_front"), true)
	setActive(findTF(arg_124_0._tf, "sceneContainer/scene_background"), true)
	setActive(findTF(arg_124_0._tf, "sceneContainer/scene"), true)
	setActive(arg_124_0.scoreAnimTf, false)
	setActive(arg_124_0.gameUI, true)

	arg_124_0.gameStartFlag = true
	arg_124_0.scoreNum = 0
	arg_124_0.playerPosIndex = 2
	arg_124_0.gameStepTime = 0
	arg_124_0.gameTime = var_0_7
	arg_124_0.ignoreTime = false

	arg_124_0.boxController:start()
	arg_124_0.specialController:start()
	arg_124_0.bgController:start()
	arg_124_0.roleController:start()
	arg_124_0:updateGameUI()
	arg_124_0:timerStart()

	return
end

function var_0_0.getGameTimes(arg_125_0)
	return arg_125_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_126_0)
	return arg_126_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_127_0)
	return arg_127_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_128_0)
	return (arg_128_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_129_0, arg_129_1)
	return
end

function var_0_0.onTimer(arg_130_0)
	arg_130_0:gameStep()

	return
end

function var_0_0.gameStep(arg_131_0)
	if not arg_131_0.ignoreTime then
		arg_131_0.gameTime = arg_131_0.gameTime - Time.deltaTime

		if arg_131_0.gameTime < 0 then
			arg_131_0.gameTime = 0
		end

		arg_131_0.gameStepTime = arg_131_0.gameStepTime + Time.deltaTime
	end

	arg_131_0.boxController:step()
	arg_131_0.specialController:step()
	arg_131_0.bgController:step()
	arg_131_0.roleController:step()
	arg_131_0:updateGameUI()

	if arg_131_0.gameTime <= 0 then
		arg_131_0:onGameOver()

		return
	end

	return
end

function var_0_0.timerStart(arg_132_0)
	if not arg_132_0.timer.running then
		arg_132_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_133_0)
	if arg_133_0.timer.running then
		arg_133_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_134_0)
	setText(arg_134_0.scoreTf, arg_134_0.scoreNum)
	setText(arg_134_0.gameTimeS, math.ceil(arg_134_0.gameTime))

	return
end

function var_0_0.addScore(arg_135_0, arg_135_1)
	setActive(arg_135_0.scoreAnimTf, false)
	setActive(arg_135_0.scoreAnimTf, true)
	setText(arg_135_0.scoreAnimTextTf, "+" .. tostring(arg_135_1))

	arg_135_0.scoreNum = arg_135_0.scoreNum + arg_135_1

	if arg_135_0.scoreNum < 0 then
		arg_135_0.scoreNum = 0
	end

	return
end

function var_0_0.onGameOver(arg_136_0)
	if arg_136_0.settlementFlag then
		return
	end

	arg_136_0:timerStop()

	arg_136_0.settlementFlag = true

	setActive(arg_136_0.clickMask, true)

	if arg_136_0.roleController then
		arg_136_0.roleController:clear()
	end

	if arg_136_0.bgController then
		arg_136_0.bgController:clear()
	end

	LeanTween.delayedCall(go(arg_136_0._tf), 0.1, System.Action(function()
		arg_136_0.settlementFlag = false
		arg_136_0.gameStartFlag = false

		setActive(arg_136_0.clickMask, false)
		arg_136_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_138_0)
	setActive(arg_138_0.settlementUI, true)
	GetComponent(findTF(arg_138_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_138_0 = arg_138_0:GetMGData():GetRuntimeData("elements")
	local var_138_1 = arg_138_0.scoreNum

	if var_138_0 and #var_138_0 > 0 then
		local var_138_2 = var_138_0[1] or 0

		setActive(findTF(arg_138_0.settlementUI, "ad/new"), var_138_2 < var_138_1)

		if var_138_2 <= var_138_1 then
			var_138_2 = var_138_1

			arg_138_0:StoreDataToServer({
				var_138_1
			})
		end

		setText(findTF(arg_138_0.settlementUI, "ad/highText"), var_138_2)
		setText(findTF(arg_138_0.settlementUI, "ad/currentText"), var_138_1)

		if arg_138_0:getGameTimes() and arg_138_0:getGameTimes() > 0 then
			arg_138_0.sendSuccessFlag = true

			arg_138_0:SendSuccess(0)
		end

		return
	end
end

function var_0_0.resumeGame(arg_139_0)
	arg_139_0.gameStop = false

	setActive(arg_139_0.leaveUI, false)
	arg_139_0:changeSpeed(1)
	arg_139_0:timerStart()

	return
end

function var_0_0.stopGame(arg_140_0)
	arg_140_0.gameStop = true

	arg_140_0:timerStop()
	arg_140_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_141_0)
	if not arg_141_0.gameStartFlag then
		arg_141_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_141_0.settlementFlag then
			return
		end

		if isActive(arg_141_0.pauseUI) then
			setActive(arg_141_0.pauseUI, false)
		end

		arg_141_0:stopGame()
		setActive(arg_141_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_142_0)
	if arg_142_0.handle then
		UpdateBeat:RemoveListener(arg_142_0.handle)
	end

	if arg_142_0._tf and LeanTween.isTweening(go(arg_142_0._tf)) then
		LeanTween.cancel(go(arg_142_0._tf))
	end

	if arg_142_0.timer and arg_142_0.timer.running then
		arg_142_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_142_0.timer = nil

	return
end

return var_0_0
