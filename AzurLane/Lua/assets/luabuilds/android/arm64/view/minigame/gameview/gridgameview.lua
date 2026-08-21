local var_0_0 = class("GridGameView", import("..BaseMiniGameView"))
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
			distance = Vector3(-50, 0, 0),
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
			distance = Vector3(-50, 0, 0),
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
local var_0_45 = {
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
			distance = Vector3(-50, 0, 0),
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
			distance = Vector3(-50, 0, 0),
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
local var_0_46 = {
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
			distance = Vector3(-50, 0, 0),
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
local var_0_47 = {
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
					var_0_44.n_Atk,
					var_0_44.n_Move_L
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
					var_0_44.n_Skill_1
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
					var_0_44.n_Skill_2,
					var_0_44.n_Move_L
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
					var_0_44.n_Skill_3
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
					var_0_44.n_DMG,
					var_0_44.n_DMG_Back_R
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
					var_0_44.n_DMG_S
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
					var_0_44.n_DMG_Back_R
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
					var_0_44.n_Combine
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
					var_0_44.c_Atk,
					var_0_44.c_MoveL
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
					var_0_44.c_Skill_1
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
					var_0_44.c_Skill_1
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
					var_0_44.c_Skill_1
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
					var_0_44.c_Dmg,
					var_0_44.c_DMG_Back_R
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
					var_0_44.c_Dmg_S
				}
			}
		},
		actions = var_0_44
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
					var_0_45.n_Move_R,
					var_0_45.n_Skill_1,
					var_0_45.n_Move_L
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
					var_0_45.n_Skill_2
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
					var_0_45.n_Skill_3,
					var_0_45.n_Move_L
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
					var_0_45.n_DMG,
					var_0_45.n_DMG_Back_R
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
					200,
					200
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
				name = "c_Dmg",
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
				name = "c_DmgS",
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
					var_0_46.Atk,
					var_0_46.Move_L
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
					var_0_46.Skill_1
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
					var_0_46.Move_R,
					var_0_46.Skill_2,
					var_0_46.Move_L
				}
			},
			{
				dmg_index = 2,
				name = "DMG",
				special_time = false,
				actions = {
					var_0_46.DMG,
					var_0_46.DMG_Back_R
				}
			},
			{
				dmg_index = 1,
				name = "DMG_Stand",
				special_time = false,
				actions = {
					var_0_46.DMG_S
				}
			}
		},
		actions = var_0_46
	}
}

local function var_0_48(arg_1_0, arg_1_1)
	local var_1_0 = 12
	local var_1_1 = 0.3
	local var_1_2 = Vector2(138, 150)
	local var_1_3 = 2500
	local var_1_4 = 0
	local var_1_5 = 100
	local var_1_6 = {
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

	;({}).ctor = function(arg_2_0)
		arg_2_0._boxTf = arg_1_0
		arg_2_0._event = arg_1_1
		arg_2_0._gridEffect = findTF(arg_2_0._boxTf, "effectGrid")
		arg_2_0._content = findTF(arg_2_0._boxTf, "viewport/content")
		arg_2_0.tplGrid = findTF(arg_1_0, "tplGrid")

		setActive(arg_2_0.tplGrid, false)

		arg_2_0.grids = {}
		arg_2_0.effects = {}
		arg_2_0.combo = 0

		for iter_2_0 = 1, var_1_0 do
			local var_2_0 = tf(instantiate(arg_2_0._gridEffect))

			setParent(var_2_0, arg_2_0._content)
			setActive(var_2_0, false)

			var_2_0.anchoredPosition = Vector2(var_1_2.x * iter_2_0 - var_1_2.x / 2, var_1_2.y / 2)

			table.insert(arg_2_0.effects, var_2_0)
		end

		return
	end
	;({}).start = function(arg_3_0)
		arg_3_0.nextCheck = false

		arg_3_0:initGrids(false)

		for iter_3_0 = 1, #arg_3_0.effects do
			setActive(arg_3_0.effects[iter_3_0], false)
		end

		return
	end
	;({}).step = function(arg_4_0)
		if arg_4_0.takeAwayTime and arg_4_0.takeAwayTime > 0 then
			arg_4_0.takeAwayTime = arg_4_0.takeAwayTime - Time.deltaTime

			return
		end

		arg_4_0.gridCreateIndex = 1

		local var_4_0 = false

		for iter_4_0 = 1, #arg_4_0.grids do
			local var_4_1 = iter_4_0

			if not arg_4_0.grids[iter_4_0].checkAble then
				var_4_0 = var_4_0 or true

				local var_4_2 = (iter_4_0 - 1) * var_1_2.x

				if (iter_4_0 - 1) * var_1_2.x < arg_4_0.grids[iter_4_0].tf.anchoredPosition.x then
					arg_4_0.grids[iter_4_0].tf.anchoredPosition = Vector2(arg_4_0.grids[iter_4_0].tf.anchoredPosition.x - arg_4_0.grids[iter_4_0].speed * Time.deltaTime, 0)

					if arg_4_0.grids[iter_4_0].speed < var_1_3 then
						arg_4_0.grids[iter_4_0].speed = arg_4_0.grids[iter_4_0].speed + var_1_5
					end
				end

				if var_4_2 >= arg_4_0.grids[iter_4_0].tf.anchoredPosition.x then
					arg_4_0.grids[iter_4_0].speed = 0
					arg_4_0.grids[iter_4_0].checkAble = true

					if var_4_2 > arg_4_0.grids[iter_4_0].tf.anchoredPosition.x then
						arg_4_0.grids[iter_4_0].tf.anchoredPosition = Vector2(var_4_2, 0)
					end
				end
			end

			if not arg_4_0.grids[iter_4_0].eventAble then
				GetComponent(arg_4_0.grids[iter_4_0].tf, typeof(EventTriggerListener)):AddPointDownFunc(function()
					if arg_4_0.nextCheck == false then
						local var_5_0, var_5_1 = arg_4_0:triggerDownGrid(var_4_1)

						if #var_5_0 >= 2 then
							arg_4_0.nextCheck = true

							arg_4_0:takeAwayGrid(var_5_0)
							arg_4_0:insertGrids()
							arg_4_0._event:emit(var_0_12, {
								series = #var_5_0,
								combo = arg_4_0.combo,
								index = var_5_1
							})

							arg_4_0.combo = arg_4_0.combo + 1
						else
							arg_4_0.nextCheck = true

							arg_4_0:takeAwayGrid({
								var_4_1
							})
							arg_4_0:insertGrids()
						end
					end

					return
				end)

				arg_4_0.grids[iter_4_0].eventAble = true
			end
		end

		if not var_4_0 and arg_4_0.nextCheck then
			local var_4_3 = arg_4_0:getSeriesGrids()

			if #var_4_3 > 0 then
				for iter_4_1 = 1, #var_4_3 do
					for iter_4_2 = 1, #var_4_3[iter_4_1].series do
						table.insert({}, var_4_3[iter_4_1].series[iter_4_2])
					end

					arg_4_0._event:emit(var_0_12, {
						series = #var_4_3[iter_4_1].series,
						combo = arg_4_0.combo,
						index = var_4_3[iter_4_1].gridIndex
					})
				end

				arg_4_0:clearGridSeriesAble()
				arg_4_0:takeAwayGrid({})
				arg_4_0:insertGrids()

				arg_4_0.nextCheck = true
				arg_4_0.combo = arg_4_0.combo + 1
			else
				arg_4_0.nextCheck = false

				if not var_0_21.special_time then
					arg_4_0.combo = 0
				end
			end
		end

		return
	end
	;({}).clear = function(arg_6_0)
		for iter_6_0 = 1, #arg_6_0.grids do
			if arg_6_0.grids[iter_6_0].tf then
				destroy(arg_6_0.grids[iter_6_0].tf)
			end
		end

		arg_6_0.grids = {}
		arg_6_0.gridCreateIndex = 1

		return
	end
	;({}).clearGridSeriesAble = function(arg_7_0)
		for iter_7_0 = 1, #arg_7_0.grids do
			if arg_7_0.grids[iter_7_0].seriesAble then
				arg_7_0.grids[iter_7_0].seriesAble = false
			end
		end

		return
	end
	;({}).getSeriesGrids = function(arg_8_0)
		local var_8_0

		for iter_8_0 = 1, #arg_8_0.grids do
			local var_8_1

			if not var_8_0 then
				var_8_0 = arg_8_0.grids[iter_8_0].index

				table.insert({}, iter_8_0)
			elseif var_8_0 == arg_8_0.grids[iter_8_0].index then
				table.insert({}, iter_8_0)

				if #{} >= 3 and iter_8_0 == #arg_8_0.grids and arg_8_0:checkSeriesAble({}) then
					table.insert({}, {
						series = {},
						gridIndex = var_8_0
					})
				end
			elseif var_8_0 ~= arg_8_0.grids[iter_8_0].index then
				if #{} >= 3 and arg_8_0:checkSeriesAble({}) then
					table.insert({}, {
						series = {},
						gridIndex = var_8_0
					})
				end

				var_8_1 = {}
				var_8_0 = arg_8_0.grids[iter_8_0].index

				table.insert({}, iter_8_0)
			end
		end

		return {}
	end
	;({}).checkSeriesAble = function(arg_9_0, arg_9_1)
		for iter_9_0 = 1, #arg_9_1 do
			if arg_9_0.grids[arg_9_1[iter_9_0]].seriesAble then
				return true
			end
		end

		return false
	end
	;({}).insertGrids = function(arg_10_0)
		for iter_10_0 = 1, var_1_0 - #arg_10_0.grids do
			table.insert(arg_10_0.grids, (arg_10_0:createGridData()))
		end

		if arg_10_0:checkGridsSeries() then
			arg_10_0:instiateGrids(true)
		else
			arg_10_0:initGrids(true)
		end

		arg_10_0:changeAbleGrids()

		return
	end
	;({}).changeAbleGrids = function(arg_11_0)
		for iter_11_0 = 1, #arg_11_0.grids do
			arg_11_0.grids[iter_11_0].checkAble = false
			arg_11_0.grids[iter_11_0].eventAble = false
			arg_11_0.grids[iter_11_0].speed = var_1_4
		end

		return
	end
	;({}).takeAwayGrid = function(arg_12_0, arg_12_1)
		table.sort(arg_12_1, function(arg_13_0, arg_13_1)
			return arg_13_0 <= arg_13_1
		end)

		arg_12_0.takeAwayTime = var_1_1

		if arg_12_1[1] - 1 > 0 then
			arg_12_0.grids[arg_12_1[1] - 1].seriesAble = true
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. "xiaochu")

		for iter_12_0 = #arg_12_1, 1, -1 do
			table.insert({}, table.remove(arg_12_0.grids, arg_12_1[iter_12_0]))
			setActive(arg_12_0.effects[arg_12_1[iter_12_0]], false)
			setActive(arg_12_0.effects[arg_12_1[iter_12_0]], true)
		end

		for iter_12_1 = 1, #{} do
			destroy(({})[iter_12_1].tf)

			;({})[iter_12_1] = 0
		end

		return
	end
	;({}).triggerDownGrid = function(arg_14_0, arg_14_1)
		if not arg_14_0.grids[arg_14_1] then
			return {
				arg_14_1
			}, 0
		end

		for iter_14_0 = arg_14_1 - 1, 1, -1 do
			if arg_14_0.grids[arg_14_1].index == arg_14_0.grids[iter_14_0].index then
				table.insert({
					arg_14_1
				}, iter_14_0)
			else
				break
			end
		end

		for iter_14_1 = arg_14_1 + 1, #arg_14_0.grids do
			if arg_14_0.grids[arg_14_1].index == arg_14_0.grids[iter_14_1].index then
				table.insert({
					arg_14_1
				}, iter_14_1)
			else
				break
			end
		end

		table.sort({
			arg_14_1
		}, function(arg_15_0, arg_15_1)
			return arg_15_0 <= arg_15_1
		end)

		return {
			arg_14_1
		}, arg_14_0.grids[arg_14_1].index
	end
	;({}).initGrids = function(arg_16_0, arg_16_1)
		arg_16_0:clear()

		for iter_16_0 = 1, var_1_0 do
			table.insert(arg_16_0.grids, (arg_16_0:createGridData()))
		end

		if arg_16_0:checkGridsSeries() then
			arg_16_0:instiateGrids(arg_16_1)
		else
			arg_16_0:initGrids(arg_16_1)
		end

		arg_16_0.nextCheck = false

		return
	end
	;({}).instiateGrids = function(arg_17_0, arg_17_1)
		for iter_17_0 = 1, #arg_17_0.grids do
			local var_17_0 = arg_17_0.grids[iter_17_0]

			if not arg_17_0.grids[iter_17_0].tf then
				local var_17_1 = tf(instantiate(arg_17_0.tplGrid))

				SetParent(var_17_1, arg_17_0._content)
				setActive(var_17_1, true)
				setActive(findTF(var_17_1, var_17_0.name), true)

				local var_17_2 = arg_17_1 and (var_1_0 + arg_17_0.gridCreateIndex - 1) * var_1_2.x or (arg_17_0.gridCreateIndex - 1) * var_1_2.x

				var_17_1.anchoredPosition = Vector2(var_17_2, 0)
				arg_17_0.gridCreateIndex = arg_17_0.gridCreateIndex + 1
				var_17_0.tf = var_17_1
			end
		end

		return
	end
	;({}).createGridData = function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_1 and Clone(var_1_6[arg_18_1]) or Clone(var_1_6[math.random(1, #var_1_6)])

		;({
			checkAble = false,
			eventAble = false,
			speed = var_1_4
		}).index = var_18_0.index
		;({
			checkAble = false,
			eventAble = false,
			speed = var_1_4
		}).name = var_18_0.name

		return {
			checkAble = false,
			eventAble = false,
			speed = var_1_4
		}
	end
	;({}).checkGridsSeries = function(arg_19_0)
		return true
	end

	;({}):ctor()

	return {}
end

local var_0_49 = false

local function var_0_50(arg_20_0, arg_20_1, arg_20_2)
	({
		ctor = function(arg_21_0)
			arg_21_0._specialTf = arg_20_0
			arg_21_0._successTf = arg_20_1
			arg_21_0._effectSuccess = findTF(arg_21_0._successTf, "effectSuccess")
			arg_21_0._event = arg_20_2

			arg_21_0._event:bind(var_0_12, function(arg_22_0, arg_22_1, arg_22_2)
				arg_21_0:addPowerAmount(arg_22_1.index, arg_21_0:getPowerAmount(arg_22_1.series, arg_22_1.combo))

				return
			end)

			arg_21_0.powers = {}

			for iter_21_0 = 1, #var_0_22 do
				table.insert(arg_21_0.powers, {
					active = false,
					tf = findTF(arg_21_0._specialTf, var_0_22[iter_21_0].name),
					index = var_0_22[iter_21_0].index,
					max = var_0_22[iter_21_0].max,
					cur = var_0_22[iter_21_0].cur
				})
			end

			arg_21_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_21_0._successTf, "box"), typeof(Slider)),
				max = var_0_30
			}

			return
		end,
		start = function(arg_23_0)
			for iter_23_0 = 1, #arg_23_0.powers do
				arg_23_0.powers[iter_23_0].cur = 0
				arg_23_0.powers[iter_23_0].active = false
			end

			arg_23_0.success.cur = 0
			arg_23_0.success.active = false

			setActive(arg_23_0._effectSuccess, false)
			arg_23_0:resetSpecialData()
			arg_23_0:step()

			return
		end,
		step = function(arg_24_0)
			for iter_24_0 = 1, #arg_24_0.powers do
				if arg_24_0.powers[iter_24_0].active and arg_24_0.powers[iter_24_0].cur > 0 then
					arg_24_0.powers[iter_24_0].cur = arg_24_0.powers[iter_24_0].cur - var_0_27 * Time.deltaTime

					if arg_24_0.powers[iter_24_0].cur <= 0 then
						arg_24_0.powers[iter_24_0].active = false
						arg_24_0.powers[iter_24_0].cur = 0
					end
				end

				local var_24_0 = GetComponent(arg_24_0.powers[iter_24_0].tf, typeof(Slider))

				if arg_24_0.powers[iter_24_0].cur > 0 then
					var_24_0.value = arg_24_0.powers[iter_24_0].cur / arg_24_0.powers[iter_24_0].max or 0
				end
			end

			if arg_24_0.success.active and arg_24_0.success.cur > 0 and var_0_21.special_complete then
				arg_24_0.success.cur = arg_24_0.success.cur - var_0_28 * Time.deltaTime

				if arg_24_0.success.cur <= 0 then
					arg_24_0.success.active = false
					arg_24_0.success.cur = 0

					arg_24_0._event:emit(var_0_17)
				end
			end

			if arg_24_0.success.cur >= arg_24_0.success.max or arg_24_0.success.active then
				setActive(arg_24_0._effectSuccess, true)
			else
				setActive(arg_24_0._effectSuccess, false)
			end

			local var_24_1 = arg_24_0.success.slider

			if arg_24_0.success.cur > 0 then
				var_24_1.value = arg_24_0.success.cur / arg_24_0.success.max or 0
				var_0_21.special_time = arg_24_0.success.active
				var_0_21.grid_index = 0

				return
			end
		end,
		clear = function(arg_25_0)
			return
		end,
		updateSpecialData = function(arg_26_0, arg_26_1)
			var_0_21.special_time = arg_26_0.success.active
			var_0_21.grid_index = arg_26_1
			var_0_21.power_grid = 0

			for iter_26_0 = 1, #arg_26_0.powers do
				if arg_26_0.powers[iter_26_0].index == arg_26_1 and arg_26_0.powers[iter_26_0].cur == arg_26_0.powers[iter_26_0].max then
					var_0_21.power_grid = arg_26_0.powers[iter_26_0].index
				end
			end

			arg_26_0._event:emit(var_0_13)

			return
		end,
		resetSpecialData = function(arg_27_0)
			var_0_21.special_complete = false

			return
		end,
		addPowerAmount = function(arg_28_0, arg_28_1, arg_28_2)
			local var_28_0 = arg_28_0:getPowerByIndex(arg_28_1)

			if arg_28_0.success and not arg_28_0.success.active then
				arg_28_0.success.cur = arg_28_0.success.cur + arg_28_2

				if arg_28_0.success.cur >= arg_28_0.success.max then
					arg_28_0.success.cur = arg_28_0.success.max

					if not isActive(arg_28_0._effectSuccess) then
						setActive(arg_28_0._effectSuccess, true)
					end

					arg_28_0.success.active = true
					var_0_21.special_complete = false

					arg_28_0._event:emit(var_0_16)
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
				return var_0_29
			end

			return (var_0_26 + (arg_30_1 - var_0_25) * var_0_24) * (1 + arg_30_2 * var_0_23)
		end
	}).ctor({
		ctor = function(arg_21_0)
			arg_21_0._specialTf = arg_20_0
			arg_21_0._successTf = arg_20_1
			arg_21_0._effectSuccess = findTF(arg_21_0._successTf, "effectSuccess")
			arg_21_0._event = arg_20_2

			arg_21_0._event:bind(var_0_12, function(arg_22_0, arg_22_1, arg_22_2)
				arg_21_0:addPowerAmount(arg_22_1.index, arg_21_0:getPowerAmount(arg_22_1.series, arg_22_1.combo))

				return
			end)

			arg_21_0.powers = {}

			for iter_21_0 = 1, #var_0_22 do
				table.insert(arg_21_0.powers, {
					active = false,
					tf = findTF(arg_21_0._specialTf, var_0_22[iter_21_0].name),
					index = var_0_22[iter_21_0].index,
					max = var_0_22[iter_21_0].max,
					cur = var_0_22[iter_21_0].cur
				})
			end

			arg_21_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_21_0._successTf, "box"), typeof(Slider)),
				max = var_0_30
			}

			return
		end,
		start = function(arg_23_0)
			for iter_23_0 = 1, #arg_23_0.powers do
				arg_23_0.powers[iter_23_0].cur = 0
				arg_23_0.powers[iter_23_0].active = false
			end

			arg_23_0.success.cur = 0
			arg_23_0.success.active = false

			setActive(arg_23_0._effectSuccess, false)
			arg_23_0:resetSpecialData()
			arg_23_0:step()

			return
		end,
		step = function(arg_24_0)
			for iter_24_0 = 1, #arg_24_0.powers do
				if arg_24_0.powers[iter_24_0].active and arg_24_0.powers[iter_24_0].cur > 0 then
					arg_24_0.powers[iter_24_0].cur = arg_24_0.powers[iter_24_0].cur - var_0_27 * Time.deltaTime

					if arg_24_0.powers[iter_24_0].cur <= 0 then
						arg_24_0.powers[iter_24_0].active = false
						arg_24_0.powers[iter_24_0].cur = 0
					end
				end

				local var_24_0 = GetComponent(arg_24_0.powers[iter_24_0].tf, typeof(Slider))

				if arg_24_0.powers[iter_24_0].cur > 0 then
					var_24_0.value = arg_24_0.powers[iter_24_0].cur / arg_24_0.powers[iter_24_0].max or 0
				end
			end

			if arg_24_0.success.active and arg_24_0.success.cur > 0 and var_0_21.special_complete then
				arg_24_0.success.cur = arg_24_0.success.cur - var_0_28 * Time.deltaTime

				if arg_24_0.success.cur <= 0 then
					arg_24_0.success.active = false
					arg_24_0.success.cur = 0

					arg_24_0._event:emit(var_0_17)
				end
			end

			if arg_24_0.success.cur >= arg_24_0.success.max or arg_24_0.success.active then
				setActive(arg_24_0._effectSuccess, true)
			else
				setActive(arg_24_0._effectSuccess, false)
			end

			local var_24_1 = arg_24_0.success.slider

			if arg_24_0.success.cur > 0 then
				var_24_1.value = arg_24_0.success.cur / arg_24_0.success.max or 0
				var_0_21.special_time = arg_24_0.success.active
				var_0_21.grid_index = 0

				return
			end
		end,
		clear = function(arg_25_0)
			return
		end,
		updateSpecialData = function(arg_26_0, arg_26_1)
			var_0_21.special_time = arg_26_0.success.active
			var_0_21.grid_index = arg_26_1
			var_0_21.power_grid = 0

			for iter_26_0 = 1, #arg_26_0.powers do
				if arg_26_0.powers[iter_26_0].index == arg_26_1 and arg_26_0.powers[iter_26_0].cur == arg_26_0.powers[iter_26_0].max then
					var_0_21.power_grid = arg_26_0.powers[iter_26_0].index
				end
			end

			arg_26_0._event:emit(var_0_13)

			return
		end,
		resetSpecialData = function(arg_27_0)
			var_0_21.special_complete = false

			return
		end,
		addPowerAmount = function(arg_28_0, arg_28_1, arg_28_2)
			local var_28_0 = arg_28_0:getPowerByIndex(arg_28_1)

			if arg_28_0.success and not arg_28_0.success.active then
				arg_28_0.success.cur = arg_28_0.success.cur + arg_28_2

				if arg_28_0.success.cur >= arg_28_0.success.max then
					arg_28_0.success.cur = arg_28_0.success.max

					if not isActive(arg_28_0._effectSuccess) then
						setActive(arg_28_0._effectSuccess, true)
					end

					arg_28_0.success.active = true
					var_0_21.special_complete = false

					arg_28_0._event:emit(var_0_16)
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
				return var_0_29
			end

			return (var_0_26 + (arg_30_1 - var_0_25) * var_0_24) * (1 + arg_30_2 * var_0_23)
		end
	})

	return {
		ctor = function(arg_21_0)
			arg_21_0._specialTf = arg_20_0
			arg_21_0._successTf = arg_20_1
			arg_21_0._effectSuccess = findTF(arg_21_0._successTf, "effectSuccess")
			arg_21_0._event = arg_20_2

			arg_21_0._event:bind(var_0_12, function(arg_22_0, arg_22_1, arg_22_2)
				arg_21_0:addPowerAmount(arg_22_1.index, arg_21_0:getPowerAmount(arg_22_1.series, arg_22_1.combo))

				return
			end)

			arg_21_0.powers = {}

			for iter_21_0 = 1, #var_0_22 do
				table.insert(arg_21_0.powers, {
					active = false,
					tf = findTF(arg_21_0._specialTf, var_0_22[iter_21_0].name),
					index = var_0_22[iter_21_0].index,
					max = var_0_22[iter_21_0].max,
					cur = var_0_22[iter_21_0].cur
				})
			end

			arg_21_0.success = {
				cur = 0,
				slider = GetComponent(findTF(arg_21_0._successTf, "box"), typeof(Slider)),
				max = var_0_30
			}

			return
		end,
		start = function(arg_23_0)
			for iter_23_0 = 1, #arg_23_0.powers do
				arg_23_0.powers[iter_23_0].cur = 0
				arg_23_0.powers[iter_23_0].active = false
			end

			arg_23_0.success.cur = 0
			arg_23_0.success.active = false

			setActive(arg_23_0._effectSuccess, false)
			arg_23_0:resetSpecialData()
			arg_23_0:step()

			return
		end,
		step = function(arg_24_0)
			for iter_24_0 = 1, #arg_24_0.powers do
				if arg_24_0.powers[iter_24_0].active and arg_24_0.powers[iter_24_0].cur > 0 then
					arg_24_0.powers[iter_24_0].cur = arg_24_0.powers[iter_24_0].cur - var_0_27 * Time.deltaTime

					if arg_24_0.powers[iter_24_0].cur <= 0 then
						arg_24_0.powers[iter_24_0].active = false
						arg_24_0.powers[iter_24_0].cur = 0
					end
				end

				local var_24_0 = GetComponent(arg_24_0.powers[iter_24_0].tf, typeof(Slider))

				if arg_24_0.powers[iter_24_0].cur > 0 then
					var_24_0.value = arg_24_0.powers[iter_24_0].cur / arg_24_0.powers[iter_24_0].max or 0
				end
			end

			if arg_24_0.success.active and arg_24_0.success.cur > 0 and var_0_21.special_complete then
				arg_24_0.success.cur = arg_24_0.success.cur - var_0_28 * Time.deltaTime

				if arg_24_0.success.cur <= 0 then
					arg_24_0.success.active = false
					arg_24_0.success.cur = 0

					arg_24_0._event:emit(var_0_17)
				end
			end

			if arg_24_0.success.cur >= arg_24_0.success.max or arg_24_0.success.active then
				setActive(arg_24_0._effectSuccess, true)
			else
				setActive(arg_24_0._effectSuccess, false)
			end

			local var_24_1 = arg_24_0.success.slider

			if arg_24_0.success.cur > 0 then
				var_24_1.value = arg_24_0.success.cur / arg_24_0.success.max or 0
				var_0_21.special_time = arg_24_0.success.active
				var_0_21.grid_index = 0

				return
			end
		end,
		clear = function(arg_25_0)
			return
		end,
		updateSpecialData = function(arg_26_0, arg_26_1)
			var_0_21.special_time = arg_26_0.success.active
			var_0_21.grid_index = arg_26_1
			var_0_21.power_grid = 0

			for iter_26_0 = 1, #arg_26_0.powers do
				if arg_26_0.powers[iter_26_0].index == arg_26_1 and arg_26_0.powers[iter_26_0].cur == arg_26_0.powers[iter_26_0].max then
					var_0_21.power_grid = arg_26_0.powers[iter_26_0].index
				end
			end

			arg_26_0._event:emit(var_0_13)

			return
		end,
		resetSpecialData = function(arg_27_0)
			var_0_21.special_complete = false

			return
		end,
		addPowerAmount = function(arg_28_0, arg_28_1, arg_28_2)
			local var_28_0 = arg_28_0:getPowerByIndex(arg_28_1)

			if arg_28_0.success and not arg_28_0.success.active then
				arg_28_0.success.cur = arg_28_0.success.cur + arg_28_2

				if arg_28_0.success.cur >= arg_28_0.success.max then
					arg_28_0.success.cur = arg_28_0.success.max

					if not isActive(arg_28_0._effectSuccess) then
						setActive(arg_28_0._effectSuccess, true)
					end

					arg_28_0.success.active = true
					var_0_21.special_complete = false

					arg_28_0._event:emit(var_0_16)
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
				return var_0_29
			end

			return (var_0_26 + (arg_30_1 - var_0_25) * var_0_24) * (1 + arg_30_2 * var_0_23)
		end
	}
end

local function var_0_51(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = {
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

	;({}).ctor = function(arg_32_0)
		arg_32_0._sceneTf = arg_31_0
		arg_32_0._event = arg_31_2
		arg_32_0.bgs = {}
		arg_32_0._gameTf = arg_31_1
		arg_32_0._box = findTF(arg_32_0._gameTf, "box")
		arg_32_0._specialPower = findTF(arg_32_0._gameTf, "specialPower")
		arg_32_0._successPower = findTF(arg_32_0._gameTf, "successPower")
		arg_32_0._top = findTF(arg_32_0._gameTf, "top")

		for iter_32_0 = 1, #var_31_0 do
			table.insert(arg_32_0.bgs, {
				tf = findTF(arg_32_0._sceneTf, var_31_0[iter_32_0].source),
				rate = var_31_0[iter_32_0].rate
			})
		end

		arg_32_0._bgBackCanvas = GetComponent(findTF(arg_32_0._sceneTf, "scene_background"), typeof(CanvasGroup))
		arg_32_0._bgFrontCanvas = GetComponent(findTF(arg_32_0._sceneTf, "scene_front"), typeof(CanvasGroup))
		arg_32_0._bgBeamCanvas = GetComponent(findTF(arg_32_0._sceneTf, "scene/bgBeam"), typeof(CanvasGroup))

		arg_32_0._event:bind(var_0_14, function(arg_33_0, arg_33_1, arg_33_2)
			local var_33_0 = arg_33_1[2] and -1 or 1
			local var_33_1 = arg_33_1[3]

			if not arg_32_0.inCamera then
				arg_32_0:setTargetFllow(Vector2(var_33_0 * arg_33_1[1].x / 10, var_33_0 * arg_33_1[1].y / 10), var_33_1)
			end

			return
		end)
		arg_32_0._event:bind(var_0_18, function(arg_34_0, arg_34_1, arg_34_2)
			arg_32_0.inCamera = true

			arg_32_0:setTargetFllow(Vector2(550, 100))
			arg_32_0:setBeam(false)

			return
		end)
		arg_32_0._event:bind(var_0_19, function(arg_35_0, arg_35_1, arg_35_2)
			arg_32_0:setTargetFllow(Vector2(0, 0), function()
				return
			end, true)
			arg_32_0:setBeam(true)

			arg_32_0.inCamera = false

			return
		end)

		return
	end
	;({}).start = function(arg_37_0)
		arg_37_0.targetVec = Vector2(var_0_36.x, var_0_36.y)
		arg_37_0.currentVec = Vector2(var_0_36.x, var_0_36.y)

		for iter_37_0 = 1, #arg_37_0.bgs do
			arg_37_0.bgs[iter_37_0].tf.anchoredPosition = Vector2(arg_37_0.currentVec.x * arg_37_0.bgs[iter_37_0].rate, arg_37_0.currentVec.y * arg_37_0.bgs[iter_37_0].rate)
		end

		arg_37_0._bgBackCanvas.alpha = 1
		arg_37_0._bgFrontCanvas.alpha = 1
		arg_37_0._bgBeamCanvas.alpha = 0

		setActive(arg_37_0._box, true)
		setActive(arg_37_0._specialPower, true)
		setActive(arg_37_0._successPower, true)
		setActive(arg_37_0._top, true)

		return
	end
	;({}).clear = function(arg_38_0)
		if LeanTween.isTweening(go(arg_38_0._sceneTf)) then
			LeanTween.cancel(go(arg_38_0._sceneTf), false)
		end

		return
	end
	;({}).step = function(arg_39_0)
		local var_39_0 = 0
		local var_39_1 = 0

		if arg_39_0.targetVec.x ~= arg_39_0.currentVec.x then
			var_39_0 = (arg_39_0.targetVec.x - arg_39_0.currentVec.x) * var_0_37

			if math.abs((arg_39_0.targetVec.x - arg_39_0.currentVec.x) * var_0_37) < var_0_38 then
				var_39_0 = var_0_38 * math.sign(var_39_0)
			end

			arg_39_0.currentVec.x = arg_39_0.currentVec.x + var_39_0

			if math.abs(arg_39_0.currentVec.x - arg_39_0.targetVec.x) <= var_0_38 then
				arg_39_0.currentVec.x = arg_39_0.targetVec.x
			end
		end

		if arg_39_0.targetVec.y ~= arg_39_0.currentVec.y then
			var_39_1 = (arg_39_0.targetVec.y - arg_39_0.currentVec.y) * var_0_37

			if math.abs((arg_39_0.targetVec.y - arg_39_0.currentVec.y) * var_0_37) < var_0_38 then
				var_39_1 = var_0_38 * math.sign(var_39_1)
			end

			arg_39_0.currentVec.y = arg_39_0.currentVec.y + var_39_1

			if math.abs(arg_39_0.currentVec.y - arg_39_0.targetVec.y) <= var_0_38 then
				arg_39_0.currentVec.y = arg_39_0.targetVec.y
			end
		end

		if var_39_0 ~= 0 or var_39_1 ~= 0 then
			arg_39_0:moveTo(arg_39_0.currentVec)
		end

		return
	end
	;({}).moveTo = function(arg_40_0, arg_40_1)
		for iter_40_0 = 1, #arg_40_0.bgs do
			arg_40_0.bgs[iter_40_0].tf.anchoredPosition = Vector2(arg_40_1.x * arg_40_0.bgs[iter_40_0].rate, arg_40_1.y * arg_40_0.bgs[iter_40_0].rate)
		end

		return
	end
	;({}).setTargetFllow = function(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
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
	;({}).setBeam = function(arg_42_0, arg_42_1, arg_42_2)
		if LeanTween.isTweening(go(arg_42_0._sceneTf)) then
			LeanTween.cancel(go(arg_42_0._sceneTf), false)
		end

		if arg_42_1 then
			setActive(arg_42_0._box, true)
			setActive(arg_42_0._specialPower, true)
			setActive(arg_42_0._successPower, true)
			setActive(arg_42_0._top, true)
		else
			setActive(arg_42_0._box, false)
			setActive(arg_42_0._specialPower, false)
			setActive(arg_42_0._successPower, false)
			setActive(arg_42_0._top, false)
		end

		LeanTween.value(go(arg_42_0._sceneTf), 0, 1, 0.2):setOnUpdate(System.Action_float(function(arg_43_0)
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
		end)):setOnComplete(System.Action(function()
			if arg_42_2 then
				arg_42_2()
			end

			return
		end))

		return
	end

	;({}):ctor()

	return {}
end

local function var_0_52(arg_45_0, arg_45_1)
	({
		ctor = function(arg_46_0)
			arg_46_0._scene = arg_45_0
			arg_46_0._tpl = findTF(arg_46_0._scene, "tpl")
			arg_46_0._leftRolePos = findTF(arg_46_0._scene, "rolePos/leftRole")
			arg_46_0._rightRolePos = findTF(arg_46_0._scene, "rolePos/rightRole")
			arg_46_0._event = arg_45_1

			arg_46_0._event:bind(var_0_13, function()
				arg_46_0:onGridTrigger()

				return
			end)
			arg_46_0._event:bind(var_0_16, function()
				arg_46_0:onRoleSpecial()

				return
			end)
			arg_46_0._event:bind(var_0_17, function()
				arg_46_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_50_0)
			if arg_50_0.leftRole then
				destroy(arg_50_0.leftRole.tf)

				arg_50_0.leftRole = nil
			end

			if arg_50_0.rightRole then
				destroy(arg_50_0.rightRole.tf)

				arg_50_0.rightRole = nil
			end

			arg_50_0.leftRole = arg_50_0:createRole(var_0_31, true, arg_50_0._leftRolePos)
			arg_50_0.rightRole = arg_50_0:createRole(var_0_32, false, arg_50_0._rightRolePos)
			arg_50_0.leftRole.targetRole = arg_50_0.rightRole
			arg_50_0.rightRole.targetRole = arg_50_0.leftRole

			arg_50_0.leftRole.animator:SetTrigger("idle")
			arg_50_0.leftRole.animator:SetBool("special", false)
			arg_50_0.rightRole.animator:SetTrigger("idle")
			arg_50_0.rightRole.animator:SetBool("special", false)

			arg_50_0.leftRole.specialBody = false
			arg_50_0.rightRole.specialBody = false
			arg_50_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_50_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_50_0.emptySkillTime = math.random(1, 2)
			arg_50_0.addScore = {
				0,
				0
			}

			arg_50_0._event:emit(var_0_14, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_51_0)
			arg_51_0:checkSkillDeltaTime()
			arg_51_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_52_0)
			if arg_52_0.skillDeltaTime and arg_52_0.skillDeltaTime <= 0 then
				arg_52_0.skillDeltaTime = var_0_39
			end

			arg_52_0.skillDeltaTime = arg_52_0.skillDeltaTime - Time.deltaTime

			if arg_52_0.skillDeltaTime <= 0 then
				local var_52_0 = false

				for iter_52_0, iter_52_1 in pairs(arg_52_0.playingDatas) do
					if iter_52_1.inPlaying then
						var_52_0 = true
					end
				end

				if not var_52_0 then
					for iter_52_2, iter_52_3 in pairs(arg_52_0.playingDatas) do
						if #iter_52_3.skillDatas > 0 then
							if iter_52_3.role == arg_52_0.leftRole then
								print("开始执行角色攻击")
							end

							arg_52_0:applySkillData(iter_52_3)

							break
						end
					end
				end
			end

			var_0_49 = false

			for iter_52_4, iter_52_5 in pairs(arg_52_0.playingDatas) do
				if iter_52_5.inPlaying then
					var_0_49 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_53_0)
			if arg_53_0.emptySkillTime and arg_53_0.emptySkillTime <= 0 then
				arg_53_0.emptySkillTime = var_0_40
			end

			arg_53_0.emptySkillTime = arg_53_0.emptySkillTime - Time.deltaTime

			if arg_53_0.emptySkillTime <= 0 then
				local var_53_0 = false

				for iter_53_0, iter_53_1 in pairs(arg_53_0.playingDatas) do
					if iter_53_1.inPlaying then
						var_53_0 = true
					end
				end

				if not var_53_0 then
					local var_53_1 = arg_53_0:getRoleEmptySkill(arg_53_0.rightRole)

					if var_53_1 then
						arg_53_0:addRolePlaying(arg_53_0.rightRole, var_53_1)
					end
				end
			end

			return
		end,
		getRoleEmptySkill = function(arg_54_0, arg_54_1)
			for iter_54_0 = 1, #arg_54_1.skill do
				if tobool(arg_54_1.skill[iter_54_0].special_time) == arg_54_1.specialBody and arg_54_1.skill[iter_54_0].atk_index then
					table.insert({}, arg_54_1.skill[iter_54_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_55_0)
			arg_55_0.leftRole.specialTime = true

			for iter_55_0 = 1, #arg_55_0.leftRole.skill do
				if arg_55_0.leftRole.skill[iter_55_0].special_trigger then
					arg_55_0:addRolePlaying(arg_55_0.leftRole, Clone(arg_55_0.leftRole.skill[iter_55_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_56_0)
			arg_56_0.leftRole.specialTime = false

			for iter_56_0 = 1, #arg_56_0.leftRole.skill do
				if not arg_56_0.leftRole.skill[iter_56_0].special_trigger and arg_56_0.leftRole.skill[iter_56_0].special_end then
					arg_56_0:addRolePlaying(arg_56_0.leftRole, Clone(arg_56_0.leftRole.skill[iter_56_0]))
				end
			end

			return
		end,
		clear = function(arg_57_0)
			if LeanTween.isTweening(go(arg_57_0._leftRolePos)) then
				LeanTween.cancel(go(arg_57_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0._rightRolePos)) then
				LeanTween.cancel(go(arg_57_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_57_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_57_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_57_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_58_0)
			for iter_58_0 = 1, #arg_58_0.leftRole.skill do
				if tobool(arg_58_0.leftRole.skill[iter_58_0].special_time) == tobool(arg_58_0.leftRole.specialTime) and arg_58_0.leftRole.skill[iter_58_0].power_index == var_0_21.power_grid and table.contains(arg_58_0.leftRole.skill[iter_58_0].grid_index, var_0_21.grid_index) and arg_58_0.leftRole.skill[iter_58_0].atk_index then
					arg_58_0:addRolePlaying(arg_58_0.leftRole, Clone(arg_58_0.leftRole.skill[iter_58_0]))
				end
			end

			return
		end,
		createRole = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
			local var_59_0 = arg_59_0:getRoleData(arg_59_1)

			if not var_59_0 then
				return nil
			end

			local var_59_1 = {}
			local var_59_2 = tf(instantiate(findTF(arg_59_0._tpl, var_59_0.name)))

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
			for iter_63_0 = 1, #var_0_47 do
				if var_0_47[iter_63_0].index == arg_63_1 then
					return Clone(var_0_47[iter_63_0])
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
		addRolePlaying = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			for iter_66_0, iter_66_1 in pairs(arg_66_0.playingDatas) do
				if iter_66_0 == arg_66_1.name then
					if arg_66_3 then
						arg_66_0:applySkillData(iter_66_1, arg_66_2)
					else
						table.insert(iter_66_1.skillDatas, arg_66_2)

						if arg_66_2.power_index > 0 and arg_66_2.atk_index > 1 or arg_66_2.special_trigger then
							for iter_66_2 = #iter_66_1.skillDatas - 1, 1, -1 do
								if iter_66_1.skillDatas[iter_66_2].power_index == 0 and iter_66_1.skillDatas[iter_66_2].atk_index == 1 then
									local var_66_0 = table.remove(iter_66_1.skillDatas, iter_66_2)

									if var_66_0.score then
										arg_66_0.addScore = {
											arg_66_0.addScore[1] + var_66_0.score[1],
											arg_66_0.addScore[2] + var_66_0.score[2]
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

			local var_67_0 = arg_67_2 or table.remove(arg_67_1.skillDatas, 1)

			arg_67_1.currentSkill = var_67_0
			arg_67_1.actions = var_67_0.actions

			if var_67_0.anim_bool then
				arg_67_1.role.animator:SetBool(var_67_0.anim_bool, true)
			end

			if arg_67_1.role == arg_67_0.leftRole and not var_67_0.dmg_index then
				arg_67_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_67_1.role == arg_67_0.rightRole and not var_67_0.dmg_index then
				arg_67_0._rightRolePos:SetSiblingIndex(1)
			end

			if var_67_0.special_end then
				arg_67_1.role.specialBody = false
			elseif var_67_0.special_trigger then
				arg_67_1.role.specialBody = true
			end

			arg_67_1.actionIndex = 1

			arg_67_0:checkAction(arg_67_1, function()
				arg_67_1.inPlaying = false

				print(arg_67_1.role.name .. "动画播放完毕")

				return
			end)

			return
		end,
		checkAction = function(arg_69_0, arg_69_1, arg_69_2)
			if arg_69_1.actions and arg_69_1.actionIndex <= #arg_69_1.actions then
				local var_69_0 = arg_69_1.playingAction and arg_69_1.playingAction.anim_name

				print("准备执行" .. arg_69_1.actions[arg_69_1.actionIndex].anim_name .. "上一个动作:" .. tostring(var_69_0))

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
					arg_69_0._event:emit(var_0_20, true)
				end

				if var_69_2 and var_69_2 > 0 then
					-- block empty
				else
					arg_69_0:setDftHandle(arg_69_1.role, function()
						if var_69_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_6)
						end

						if var_69_3 then
							arg_69_0:moveRole(arg_69_1.role, var_69_3)
						end

						if var_69_5 then
							arg_69_1.role.targetRole.canvasGroup.alpha = 0

							arg_69_0._event:emit(var_0_18)
						end

						return
					end, function()
						if var_69_7 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_7)
						end

						if var_69_5 then
							var_69_5 = false
							arg_69_1.role.targetRole.canvasGroup.alpha = 1

							arg_69_0._event:emit(var_0_19)
						else
							local var_71_0 = arg_69_1.currentSkill.atk_index

							if arg_69_1.currentSkill.atk_index then
								local var_71_1 = arg_69_0:getRoleDmgData(arg_69_1.role.targetRole, var_71_0)

								if var_71_1 then
									arg_69_0:addRolePlaying(arg_69_1.role.targetRole, Clone(var_71_1), true)
								end

								if arg_69_1.currentSkill.score and arg_69_1.role == arg_69_0.leftRole then
									arg_69_0._event:emit(var_0_15, math.random(var_71_2[1] + arg_69_0.addScore[1], var_71_2[2] + arg_69_0.addScore[2]))

									arg_69_0.addScore = {
										0,
										0
									}
								end
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

						arg_69_0._event:emit(var_0_20, false)

						if var_69_4 then
							arg_69_1.role.tf.anchoredPosition = Vector2(arg_69_1.role.tf.anchoredPosition.x + var_69_4.x, arg_69_1.role.tf.anchoredPosition.y + var_69_4.y)
						end

						if arg_69_1.currentSkill.special_trigger and var_0_21.special_time and not var_0_21.special_complete then
							var_0_21.special_complete = true
						end

						arg_69_1.playingAction = nil

						arg_69_0:setDftHandle(arg_69_1.role, nil, nil, nil)
						print(arg_69_1.role.name .. "执行 " .. var_69_1 .. "结束")
						arg_69_0:checkAction(arg_69_1, arg_69_2)

						return
					end)
					arg_69_0:playAnimation(arg_69_1.role, var_69_1)
				end
			else
				if arg_69_1.role == arg_69_0.leftRole then
					print(arg_69_1.role.name .. "队列结束")
				end

				if arg_69_2 then
					arg_69_2()
				end
			end

			return
		end,
		moveRole = function(arg_73_0, arg_73_1, arg_73_2)
			if LeanTween.isTweening(go(arg_73_1.tf)) then
				LeanTween.cancel(go(arg_73_1.tf))
			end

			arg_73_0._event:emit(var_0_14, {
				arg_73_2.distance,
				arg_73_1 == arg_73_0.leftRole
			})

			local var_73_0 = arg_73_2.ease or LeanTweenType.linear

			LeanTween.move(arg_73_1.tf, Vector3(arg_73_2.distance.x, arg_73_2.distance.y, 0), arg_73_2.time):setEase(var_73_0)

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
	}).ctor({
		ctor = function(arg_46_0)
			arg_46_0._scene = arg_45_0
			arg_46_0._tpl = findTF(arg_46_0._scene, "tpl")
			arg_46_0._leftRolePos = findTF(arg_46_0._scene, "rolePos/leftRole")
			arg_46_0._rightRolePos = findTF(arg_46_0._scene, "rolePos/rightRole")
			arg_46_0._event = arg_45_1

			arg_46_0._event:bind(var_0_13, function()
				arg_46_0:onGridTrigger()

				return
			end)
			arg_46_0._event:bind(var_0_16, function()
				arg_46_0:onRoleSpecial()

				return
			end)
			arg_46_0._event:bind(var_0_17, function()
				arg_46_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_50_0)
			if arg_50_0.leftRole then
				destroy(arg_50_0.leftRole.tf)

				arg_50_0.leftRole = nil
			end

			if arg_50_0.rightRole then
				destroy(arg_50_0.rightRole.tf)

				arg_50_0.rightRole = nil
			end

			arg_50_0.leftRole = arg_50_0:createRole(var_0_31, true, arg_50_0._leftRolePos)
			arg_50_0.rightRole = arg_50_0:createRole(var_0_32, false, arg_50_0._rightRolePos)
			arg_50_0.leftRole.targetRole = arg_50_0.rightRole
			arg_50_0.rightRole.targetRole = arg_50_0.leftRole

			arg_50_0.leftRole.animator:SetTrigger("idle")
			arg_50_0.leftRole.animator:SetBool("special", false)
			arg_50_0.rightRole.animator:SetTrigger("idle")
			arg_50_0.rightRole.animator:SetBool("special", false)

			arg_50_0.leftRole.specialBody = false
			arg_50_0.rightRole.specialBody = false
			arg_50_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_50_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_50_0.emptySkillTime = math.random(1, 2)
			arg_50_0.addScore = {
				0,
				0
			}

			arg_50_0._event:emit(var_0_14, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_51_0)
			arg_51_0:checkSkillDeltaTime()
			arg_51_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_52_0)
			if arg_52_0.skillDeltaTime and arg_52_0.skillDeltaTime <= 0 then
				arg_52_0.skillDeltaTime = var_0_39
			end

			arg_52_0.skillDeltaTime = arg_52_0.skillDeltaTime - Time.deltaTime

			if arg_52_0.skillDeltaTime <= 0 then
				local var_52_0 = false

				for iter_52_0, iter_52_1 in pairs(arg_52_0.playingDatas) do
					if iter_52_1.inPlaying then
						var_52_0 = true
					end
				end

				if not var_52_0 then
					for iter_52_2, iter_52_3 in pairs(arg_52_0.playingDatas) do
						if #iter_52_3.skillDatas > 0 then
							if iter_52_3.role == arg_52_0.leftRole then
								print("开始执行角色攻击")
							end

							arg_52_0:applySkillData(iter_52_3)

							break
						end
					end
				end
			end

			var_0_49 = false

			for iter_52_4, iter_52_5 in pairs(arg_52_0.playingDatas) do
				if iter_52_5.inPlaying then
					var_0_49 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_53_0)
			if arg_53_0.emptySkillTime and arg_53_0.emptySkillTime <= 0 then
				arg_53_0.emptySkillTime = var_0_40
			end

			arg_53_0.emptySkillTime = arg_53_0.emptySkillTime - Time.deltaTime

			if arg_53_0.emptySkillTime <= 0 then
				local var_53_0 = false

				for iter_53_0, iter_53_1 in pairs(arg_53_0.playingDatas) do
					if iter_53_1.inPlaying then
						var_53_0 = true
					end
				end

				if not var_53_0 then
					local var_53_1 = arg_53_0:getRoleEmptySkill(arg_53_0.rightRole)

					if var_53_1 then
						arg_53_0:addRolePlaying(arg_53_0.rightRole, var_53_1)
					end
				end
			end

			return
		end,
		getRoleEmptySkill = function(arg_54_0, arg_54_1)
			for iter_54_0 = 1, #arg_54_1.skill do
				if tobool(arg_54_1.skill[iter_54_0].special_time) == arg_54_1.specialBody and arg_54_1.skill[iter_54_0].atk_index then
					table.insert({}, arg_54_1.skill[iter_54_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_55_0)
			arg_55_0.leftRole.specialTime = true

			for iter_55_0 = 1, #arg_55_0.leftRole.skill do
				if arg_55_0.leftRole.skill[iter_55_0].special_trigger then
					arg_55_0:addRolePlaying(arg_55_0.leftRole, Clone(arg_55_0.leftRole.skill[iter_55_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_56_0)
			arg_56_0.leftRole.specialTime = false

			for iter_56_0 = 1, #arg_56_0.leftRole.skill do
				if not arg_56_0.leftRole.skill[iter_56_0].special_trigger and arg_56_0.leftRole.skill[iter_56_0].special_end then
					arg_56_0:addRolePlaying(arg_56_0.leftRole, Clone(arg_56_0.leftRole.skill[iter_56_0]))
				end
			end

			return
		end,
		clear = function(arg_57_0)
			if LeanTween.isTweening(go(arg_57_0._leftRolePos)) then
				LeanTween.cancel(go(arg_57_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0._rightRolePos)) then
				LeanTween.cancel(go(arg_57_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_57_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_57_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_57_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_58_0)
			for iter_58_0 = 1, #arg_58_0.leftRole.skill do
				if tobool(arg_58_0.leftRole.skill[iter_58_0].special_time) == tobool(arg_58_0.leftRole.specialTime) and arg_58_0.leftRole.skill[iter_58_0].power_index == var_0_21.power_grid and table.contains(arg_58_0.leftRole.skill[iter_58_0].grid_index, var_0_21.grid_index) and arg_58_0.leftRole.skill[iter_58_0].atk_index then
					arg_58_0:addRolePlaying(arg_58_0.leftRole, Clone(arg_58_0.leftRole.skill[iter_58_0]))
				end
			end

			return
		end,
		createRole = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
			local var_59_0 = arg_59_0:getRoleData(arg_59_1)

			if not var_59_0 then
				return nil
			end

			local var_59_1 = {}
			local var_59_2 = tf(instantiate(findTF(arg_59_0._tpl, var_59_0.name)))

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
			for iter_63_0 = 1, #var_0_47 do
				if var_0_47[iter_63_0].index == arg_63_1 then
					return Clone(var_0_47[iter_63_0])
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
		addRolePlaying = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			for iter_66_0, iter_66_1 in pairs(arg_66_0.playingDatas) do
				if iter_66_0 == arg_66_1.name then
					if arg_66_3 then
						arg_66_0:applySkillData(iter_66_1, arg_66_2)
					else
						table.insert(iter_66_1.skillDatas, arg_66_2)

						if arg_66_2.power_index > 0 and arg_66_2.atk_index > 1 or arg_66_2.special_trigger then
							for iter_66_2 = #iter_66_1.skillDatas - 1, 1, -1 do
								if iter_66_1.skillDatas[iter_66_2].power_index == 0 and iter_66_1.skillDatas[iter_66_2].atk_index == 1 then
									local var_66_0 = table.remove(iter_66_1.skillDatas, iter_66_2)

									if var_66_0.score then
										arg_66_0.addScore = {
											arg_66_0.addScore[1] + var_66_0.score[1],
											arg_66_0.addScore[2] + var_66_0.score[2]
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

			local var_67_0 = arg_67_2 or table.remove(arg_67_1.skillDatas, 1)

			arg_67_1.currentSkill = var_67_0
			arg_67_1.actions = var_67_0.actions

			if var_67_0.anim_bool then
				arg_67_1.role.animator:SetBool(var_67_0.anim_bool, true)
			end

			if arg_67_1.role == arg_67_0.leftRole and not var_67_0.dmg_index then
				arg_67_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_67_1.role == arg_67_0.rightRole and not var_67_0.dmg_index then
				arg_67_0._rightRolePos:SetSiblingIndex(1)
			end

			if var_67_0.special_end then
				arg_67_1.role.specialBody = false
			elseif var_67_0.special_trigger then
				arg_67_1.role.specialBody = true
			end

			arg_67_1.actionIndex = 1

			arg_67_0:checkAction(arg_67_1, function()
				arg_67_1.inPlaying = false

				print(arg_67_1.role.name .. "动画播放完毕")

				return
			end)

			return
		end,
		checkAction = function(arg_69_0, arg_69_1, arg_69_2)
			if arg_69_1.actions and arg_69_1.actionIndex <= #arg_69_1.actions then
				local var_69_0 = arg_69_1.playingAction and arg_69_1.playingAction.anim_name

				print("准备执行" .. arg_69_1.actions[arg_69_1.actionIndex].anim_name .. "上一个动作:" .. tostring(var_69_0))

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
					arg_69_0._event:emit(var_0_20, true)
				end

				if var_69_2 and var_69_2 > 0 then
					-- block empty
				else
					arg_69_0:setDftHandle(arg_69_1.role, function()
						if var_69_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_6)
						end

						if var_69_3 then
							arg_69_0:moveRole(arg_69_1.role, var_69_3)
						end

						if var_69_5 then
							arg_69_1.role.targetRole.canvasGroup.alpha = 0

							arg_69_0._event:emit(var_0_18)
						end

						return
					end, function()
						if var_69_7 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_7)
						end

						if var_69_5 then
							var_69_5 = false
							arg_69_1.role.targetRole.canvasGroup.alpha = 1

							arg_69_0._event:emit(var_0_19)
						else
							local var_71_0 = arg_69_1.currentSkill.atk_index

							if arg_69_1.currentSkill.atk_index then
								local var_71_1 = arg_69_0:getRoleDmgData(arg_69_1.role.targetRole, var_71_0)

								if var_71_1 then
									arg_69_0:addRolePlaying(arg_69_1.role.targetRole, Clone(var_71_1), true)
								end

								if arg_69_1.currentSkill.score and arg_69_1.role == arg_69_0.leftRole then
									arg_69_0._event:emit(var_0_15, math.random(var_71_2[1] + arg_69_0.addScore[1], var_71_2[2] + arg_69_0.addScore[2]))

									arg_69_0.addScore = {
										0,
										0
									}
								end
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

						arg_69_0._event:emit(var_0_20, false)

						if var_69_4 then
							arg_69_1.role.tf.anchoredPosition = Vector2(arg_69_1.role.tf.anchoredPosition.x + var_69_4.x, arg_69_1.role.tf.anchoredPosition.y + var_69_4.y)
						end

						if arg_69_1.currentSkill.special_trigger and var_0_21.special_time and not var_0_21.special_complete then
							var_0_21.special_complete = true
						end

						arg_69_1.playingAction = nil

						arg_69_0:setDftHandle(arg_69_1.role, nil, nil, nil)
						print(arg_69_1.role.name .. "执行 " .. var_69_1 .. "结束")
						arg_69_0:checkAction(arg_69_1, arg_69_2)

						return
					end)
					arg_69_0:playAnimation(arg_69_1.role, var_69_1)
				end
			else
				if arg_69_1.role == arg_69_0.leftRole then
					print(arg_69_1.role.name .. "队列结束")
				end

				if arg_69_2 then
					arg_69_2()
				end
			end

			return
		end,
		moveRole = function(arg_73_0, arg_73_1, arg_73_2)
			if LeanTween.isTweening(go(arg_73_1.tf)) then
				LeanTween.cancel(go(arg_73_1.tf))
			end

			arg_73_0._event:emit(var_0_14, {
				arg_73_2.distance,
				arg_73_1 == arg_73_0.leftRole
			})

			local var_73_0 = arg_73_2.ease or LeanTweenType.linear

			LeanTween.move(arg_73_1.tf, Vector3(arg_73_2.distance.x, arg_73_2.distance.y, 0), arg_73_2.time):setEase(var_73_0)

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
	})

	return {
		ctor = function(arg_46_0)
			arg_46_0._scene = arg_45_0
			arg_46_0._tpl = findTF(arg_46_0._scene, "tpl")
			arg_46_0._leftRolePos = findTF(arg_46_0._scene, "rolePos/leftRole")
			arg_46_0._rightRolePos = findTF(arg_46_0._scene, "rolePos/rightRole")
			arg_46_0._event = arg_45_1

			arg_46_0._event:bind(var_0_13, function()
				arg_46_0:onGridTrigger()

				return
			end)
			arg_46_0._event:bind(var_0_16, function()
				arg_46_0:onRoleSpecial()

				return
			end)
			arg_46_0._event:bind(var_0_17, function()
				arg_46_0:onRoleSpecialEnd()

				return
			end)

			return
		end,
		start = function(arg_50_0)
			if arg_50_0.leftRole then
				destroy(arg_50_0.leftRole.tf)

				arg_50_0.leftRole = nil
			end

			if arg_50_0.rightRole then
				destroy(arg_50_0.rightRole.tf)

				arg_50_0.rightRole = nil
			end

			arg_50_0.leftRole = arg_50_0:createRole(var_0_31, true, arg_50_0._leftRolePos)
			arg_50_0.rightRole = arg_50_0:createRole(var_0_32, false, arg_50_0._rightRolePos)
			arg_50_0.leftRole.targetRole = arg_50_0.rightRole
			arg_50_0.rightRole.targetRole = arg_50_0.leftRole

			arg_50_0.leftRole.animator:SetTrigger("idle")
			arg_50_0.leftRole.animator:SetBool("special", false)
			arg_50_0.rightRole.animator:SetTrigger("idle")
			arg_50_0.rightRole.animator:SetBool("special", false)

			arg_50_0.leftRole.specialBody = false
			arg_50_0.rightRole.specialBody = false
			arg_50_0.leftRole.anchoredPosition = Vector2(0, 0)
			arg_50_0.rightRole.anchoredPosition = Vector2(0, 0)
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
			arg_50_0.emptySkillTime = math.random(1, 2)
			arg_50_0.addScore = {
				0,
				0
			}

			arg_50_0._event:emit(var_0_14, {
				Vector2(0, 0),
				false
			})

			return
		end,
		step = function(arg_51_0)
			arg_51_0:checkSkillDeltaTime()
			arg_51_0:checkEmptySkillTime()

			return
		end,
		checkSkillDeltaTime = function(arg_52_0)
			if arg_52_0.skillDeltaTime and arg_52_0.skillDeltaTime <= 0 then
				arg_52_0.skillDeltaTime = var_0_39
			end

			arg_52_0.skillDeltaTime = arg_52_0.skillDeltaTime - Time.deltaTime

			if arg_52_0.skillDeltaTime <= 0 then
				local var_52_0 = false

				for iter_52_0, iter_52_1 in pairs(arg_52_0.playingDatas) do
					if iter_52_1.inPlaying then
						var_52_0 = true
					end
				end

				if not var_52_0 then
					for iter_52_2, iter_52_3 in pairs(arg_52_0.playingDatas) do
						if #iter_52_3.skillDatas > 0 then
							if iter_52_3.role == arg_52_0.leftRole then
								print("开始执行角色攻击")
							end

							arg_52_0:applySkillData(iter_52_3)

							break
						end
					end
				end
			end

			var_0_49 = false

			for iter_52_4, iter_52_5 in pairs(arg_52_0.playingDatas) do
				if iter_52_5.inPlaying then
					var_0_49 = true
				end
			end

			return
		end,
		checkEmptySkillTime = function(arg_53_0)
			if arg_53_0.emptySkillTime and arg_53_0.emptySkillTime <= 0 then
				arg_53_0.emptySkillTime = var_0_40
			end

			arg_53_0.emptySkillTime = arg_53_0.emptySkillTime - Time.deltaTime

			if arg_53_0.emptySkillTime <= 0 then
				local var_53_0 = false

				for iter_53_0, iter_53_1 in pairs(arg_53_0.playingDatas) do
					if iter_53_1.inPlaying then
						var_53_0 = true
					end
				end

				if not var_53_0 then
					local var_53_1 = arg_53_0:getRoleEmptySkill(arg_53_0.rightRole)

					if var_53_1 then
						arg_53_0:addRolePlaying(arg_53_0.rightRole, var_53_1)
					end
				end
			end

			return
		end,
		getRoleEmptySkill = function(arg_54_0, arg_54_1)
			for iter_54_0 = 1, #arg_54_1.skill do
				if tobool(arg_54_1.skill[iter_54_0].special_time) == arg_54_1.specialBody and arg_54_1.skill[iter_54_0].atk_index then
					table.insert({}, arg_54_1.skill[iter_54_0])
				end
			end

			if #{} > 0 then
				return Clone(({})[math.random(1, #{})])
			end

			return nil
		end,
		onRoleSpecial = function(arg_55_0)
			arg_55_0.leftRole.specialTime = true

			for iter_55_0 = 1, #arg_55_0.leftRole.skill do
				if arg_55_0.leftRole.skill[iter_55_0].special_trigger then
					arg_55_0:addRolePlaying(arg_55_0.leftRole, Clone(arg_55_0.leftRole.skill[iter_55_0]))
				end
			end

			return
		end,
		onRoleSpecialEnd = function(arg_56_0)
			arg_56_0.leftRole.specialTime = false

			for iter_56_0 = 1, #arg_56_0.leftRole.skill do
				if not arg_56_0.leftRole.skill[iter_56_0].special_trigger and arg_56_0.leftRole.skill[iter_56_0].special_end then
					arg_56_0:addRolePlaying(arg_56_0.leftRole, Clone(arg_56_0.leftRole.skill[iter_56_0]))
				end
			end

			return
		end,
		clear = function(arg_57_0)
			if LeanTween.isTweening(go(arg_57_0._leftRolePos)) then
				LeanTween.cancel(go(arg_57_0._leftRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0._rightRolePos)) then
				LeanTween.cancel(go(arg_57_0._rightRolePos))
			end

			if LeanTween.isTweening(go(arg_57_0.rightRole.tf)) then
				LeanTween.cancel(go(arg_57_0.rightRole.tf))
			end

			if LeanTween.isTweening(go(arg_57_0.leftRole.tf)) then
				LeanTween.cancel(go(arg_57_0.leftRole.tf))
			end

			return
		end,
		onGridTrigger = function(arg_58_0)
			for iter_58_0 = 1, #arg_58_0.leftRole.skill do
				if tobool(arg_58_0.leftRole.skill[iter_58_0].special_time) == tobool(arg_58_0.leftRole.specialTime) and arg_58_0.leftRole.skill[iter_58_0].power_index == var_0_21.power_grid and table.contains(arg_58_0.leftRole.skill[iter_58_0].grid_index, var_0_21.grid_index) and arg_58_0.leftRole.skill[iter_58_0].atk_index then
					arg_58_0:addRolePlaying(arg_58_0.leftRole, Clone(arg_58_0.leftRole.skill[iter_58_0]))
				end
			end

			return
		end,
		createRole = function(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
			local var_59_0 = arg_59_0:getRoleData(arg_59_1)

			if not var_59_0 then
				return nil
			end

			local var_59_1 = {}
			local var_59_2 = tf(instantiate(findTF(arg_59_0._tpl, var_59_0.name)))

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
			for iter_63_0 = 1, #var_0_47 do
				if var_0_47[iter_63_0].index == arg_63_1 then
					return Clone(var_0_47[iter_63_0])
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
		addRolePlaying = function(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
			for iter_66_0, iter_66_1 in pairs(arg_66_0.playingDatas) do
				if iter_66_0 == arg_66_1.name then
					if arg_66_3 then
						arg_66_0:applySkillData(iter_66_1, arg_66_2)
					else
						table.insert(iter_66_1.skillDatas, arg_66_2)

						if arg_66_2.power_index > 0 and arg_66_2.atk_index > 1 or arg_66_2.special_trigger then
							for iter_66_2 = #iter_66_1.skillDatas - 1, 1, -1 do
								if iter_66_1.skillDatas[iter_66_2].power_index == 0 and iter_66_1.skillDatas[iter_66_2].atk_index == 1 then
									local var_66_0 = table.remove(iter_66_1.skillDatas, iter_66_2)

									if var_66_0.score then
										arg_66_0.addScore = {
											arg_66_0.addScore[1] + var_66_0.score[1],
											arg_66_0.addScore[2] + var_66_0.score[2]
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

			local var_67_0 = arg_67_2 or table.remove(arg_67_1.skillDatas, 1)

			arg_67_1.currentSkill = var_67_0
			arg_67_1.actions = var_67_0.actions

			if var_67_0.anim_bool then
				arg_67_1.role.animator:SetBool(var_67_0.anim_bool, true)
			end

			if arg_67_1.role == arg_67_0.leftRole and not var_67_0.dmg_index then
				arg_67_0._leftRolePos:SetSiblingIndex(1)
			elseif arg_67_1.role == arg_67_0.rightRole and not var_67_0.dmg_index then
				arg_67_0._rightRolePos:SetSiblingIndex(1)
			end

			if var_67_0.special_end then
				arg_67_1.role.specialBody = false
			elseif var_67_0.special_trigger then
				arg_67_1.role.specialBody = true
			end

			arg_67_1.actionIndex = 1

			arg_67_0:checkAction(arg_67_1, function()
				arg_67_1.inPlaying = false

				print(arg_67_1.role.name .. "动画播放完毕")

				return
			end)

			return
		end,
		checkAction = function(arg_69_0, arg_69_1, arg_69_2)
			if arg_69_1.actions and arg_69_1.actionIndex <= #arg_69_1.actions then
				local var_69_0 = arg_69_1.playingAction and arg_69_1.playingAction.anim_name

				print("准备执行" .. arg_69_1.actions[arg_69_1.actionIndex].anim_name .. "上一个动作:" .. tostring(var_69_0))

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
					arg_69_0._event:emit(var_0_20, true)
				end

				if var_69_2 and var_69_2 > 0 then
					-- block empty
				else
					arg_69_0:setDftHandle(arg_69_1.role, function()
						if var_69_6 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_6)
						end

						if var_69_3 then
							arg_69_0:moveRole(arg_69_1.role, var_69_3)
						end

						if var_69_5 then
							arg_69_1.role.targetRole.canvasGroup.alpha = 0

							arg_69_0._event:emit(var_0_18)
						end

						return
					end, function()
						if var_69_7 then
							pg.CriMgr.GetInstance():PlaySoundEffect_V3("event:/ui/" .. var_69_7)
						end

						if var_69_5 then
							var_69_5 = false
							arg_69_1.role.targetRole.canvasGroup.alpha = 1

							arg_69_0._event:emit(var_0_19)
						else
							local var_71_0 = arg_69_1.currentSkill.atk_index

							if arg_69_1.currentSkill.atk_index then
								local var_71_1 = arg_69_0:getRoleDmgData(arg_69_1.role.targetRole, var_71_0)

								if var_71_1 then
									arg_69_0:addRolePlaying(arg_69_1.role.targetRole, Clone(var_71_1), true)
								end

								if arg_69_1.currentSkill.score and arg_69_1.role == arg_69_0.leftRole then
									arg_69_0._event:emit(var_0_15, math.random(var_71_2[1] + arg_69_0.addScore[1], var_71_2[2] + arg_69_0.addScore[2]))

									arg_69_0.addScore = {
										0,
										0
									}
								end
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

						arg_69_0._event:emit(var_0_20, false)

						if var_69_4 then
							arg_69_1.role.tf.anchoredPosition = Vector2(arg_69_1.role.tf.anchoredPosition.x + var_69_4.x, arg_69_1.role.tf.anchoredPosition.y + var_69_4.y)
						end

						if arg_69_1.currentSkill.special_trigger and var_0_21.special_time and not var_0_21.special_complete then
							var_0_21.special_complete = true
						end

						arg_69_1.playingAction = nil

						arg_69_0:setDftHandle(arg_69_1.role, nil, nil, nil)
						print(arg_69_1.role.name .. "执行 " .. var_69_1 .. "结束")
						arg_69_0:checkAction(arg_69_1, arg_69_2)

						return
					end)
					arg_69_0:playAnimation(arg_69_1.role, var_69_1)
				end
			else
				if arg_69_1.role == arg_69_0.leftRole then
					print(arg_69_1.role.name .. "队列结束")
				end

				if arg_69_2 then
					arg_69_2()
				end
			end

			return
		end,
		moveRole = function(arg_73_0, arg_73_1, arg_73_2)
			if LeanTween.isTweening(go(arg_73_1.tf)) then
				LeanTween.cancel(go(arg_73_1.tf))
			end

			arg_73_0._event:emit(var_0_14, {
				arg_73_2.distance,
				arg_73_1 == arg_73_0.leftRole
			})

			local var_73_0 = arg_73_2.ease or LeanTweenType.linear

			LeanTween.move(arg_73_1.tf, Vector3(arg_73_2.distance.x, arg_73_2.distance.y, 0), arg_73_2.time):setEase(var_73_0)

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
end

function var_0_0.getUIName(arg_75_0)
	return "GridGameUI"
end

function var_0_0.didEnter(arg_76_0)
	arg_76_0:initEvent()
	arg_76_0:initData()
	arg_76_0:initUI()
	arg_76_0:initGameUI()
	arg_76_0:initController()
	arg_76_0:updateMenuUI()
	arg_76_0:openMenuUI()

	return
end

function var_0_0.initEvent(arg_77_0)
	arg_77_0:bind(var_0_15, function(arg_78_0, arg_78_1, arg_78_2)
		arg_77_0:addScore(arg_78_1)

		return
	end)
	arg_77_0:bind(var_0_20, function(arg_79_0, arg_79_1, arg_79_2)
		arg_77_0.ignoreTime = arg_79_1

		return
	end)

	return
end

function var_0_0.onEventHandle(arg_80_0, arg_80_1)
	return
end

function var_0_0.initData(arg_81_0)
	local var_81_0 = Application.targetFrameRate or 60

	if var_81_0 > 60 then
		var_81_0 = 60
	end

	arg_81_0.timer = Timer.New(function()
		arg_81_0:onTimer()

		return
	end, 1 / var_81_0, -1)

	return
end

function var_0_0.initUI(arg_83_0)
	arg_83_0.backSceneTf = findTF(arg_83_0._tf, "scene_background")
	arg_83_0.sceneTf = findTF(arg_83_0._tf, "scene")
	arg_83_0.clickMask = findTF(arg_83_0._tf, "clickMask")

	setText(findTF(arg_83_0._tf, "ui/gameUI/top/time"), i18n("mini_game_time"))
	setText(findTF(arg_83_0._tf, "ui/gameUI/top/scoreDesc"), i18n("mini_game_score"))
	setText(findTF(arg_83_0._tf, "pop/LeaveUI/ad/desc"), i18n("mini_game_leave"))
	setText(findTF(arg_83_0._tf, "pop/pauseUI/ad/desc"), i18n("mini_game_pause"))
	setText(findTF(arg_83_0._tf, "pop/SettleMentUI/ad/currentTextDesc"), i18n("mini_game_cur_score"))
	setText(findTF(arg_83_0._tf, "pop/SettleMentUI/ad/highTextDesc"), i18n("mini_game_high_score"))

	arg_83_0.countUI = findTF(arg_83_0._tf, "pop/CountUI")
	arg_83_0.countAnimator = GetComponent(findTF(arg_83_0.countUI, "count"), typeof(Animator))
	arg_83_0.countDft = GetOrAddComponent(findTF(arg_83_0.countUI, "count"), typeof(DftAniEvent))

	arg_83_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_83_0.countDft:SetEndEvent(function()
		setActive(arg_83_0.countUI, false)
		arg_83_0:gameStart()

		return
	end)

	arg_83_0.leaveUI = findTF(arg_83_0._tf, "pop/LeaveUI")

	onButton(arg_83_0, findTF(arg_83_0.leaveUI, "ad/btnOk"), function()
		arg_83_0:resumeGame()
		arg_83_0:onGameOver()

		return
	end, SFX_CANCEL)
	onButton(arg_83_0, findTF(arg_83_0.leaveUI, "ad/btnCancel"), function()
		arg_83_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_83_0.pauseUI = findTF(arg_83_0._tf, "pop/pauseUI")

	onButton(arg_83_0, findTF(arg_83_0.pauseUI, "ad/btnOk"), function()
		setActive(arg_83_0.pauseUI, false)
		arg_83_0:resumeGame()

		return
	end, SFX_CANCEL)

	arg_83_0.settlementUI = findTF(arg_83_0._tf, "pop/SettleMentUI")

	onButton(arg_83_0, findTF(arg_83_0.settlementUI, "ad/btnOver"), function()
		setActive(arg_83_0.settlementUI, false)
		arg_83_0:openMenuUI()

		return
	end, SFX_CANCEL)

	arg_83_0.selectedUI = findTF(arg_83_0._tf, "pop/selectedUI")
	arg_83_0.leftSelectRole = {}

	for iter_83_0 = 1, #var_0_33 do
		local var_83_0 = findTF(arg_83_0.selectedUI, "ad/leftRole/role" .. var_0_33[iter_83_0])
		local var_83_1 = var_0_33[iter_83_0]

		onButton(arg_83_0, var_83_0, function()
			if var_0_32 == var_83_1 then
				var_0_32 = var_0_31
			end

			var_0_31 = var_83_1

			arg_83_0:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(arg_83_0.leftSelectRole, {
			id = var_0_33[iter_83_0],
			tf = var_83_0
		})
	end

	onButton(arg_83_0, findTF(arg_83_0.selectedUI, "close"), function()
		setActive(arg_83_0.selectedUI, false)

		return
	end, SFX_CANCEL)

	arg_83_0.rightSelectRole = {}

	for iter_83_1 = 1, #var_0_34 do
		local var_83_2 = findTF(arg_83_0.selectedUI, "ad/rightRole/role" .. var_0_34[iter_83_1])
		local var_83_3 = var_0_34[iter_83_1]

		onButton(arg_83_0, var_83_2, function()
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

			arg_83_0:updateSelectedUI()

			return
		end, SFX_CONFIRM)
		table.insert(arg_83_0.rightSelectRole, {
			id = var_0_34[iter_83_1],
			tf = var_83_2
		})
	end

	onButton(arg_83_0, findTF(arg_83_0.selectedUI, "ad/btnOk"), function()
		setActive(arg_83_0.selectedUI, false)
		setActive(arg_83_0.menuUI, false)
		arg_83_0:readyStart()

		return
	end, SFX_CONFIRM)
	setActive(arg_83_0.selectedUI, false)

	arg_83_0.menuUI = findTF(arg_83_0._tf, "pop/menuUI")
	arg_83_0.battleScrollRect = GetComponent(findTF(arg_83_0.menuUI, "battList"), typeof(ScrollRect))
	arg_83_0.totalTimes = arg_83_0:getGameTotalTime()

	scrollTo(arg_83_0.battleScrollRect, 0, 1 - (arg_83_0:getGameUsedTimes() - 4 < 0 and 0 or arg_83_0:getGameUsedTimes() - 4) / (arg_83_0.totalTimes - 4))
	onButton(arg_83_0, findTF(arg_83_0.menuUI, "rightPanelBg/arrowUp"), function()
		local var_94_0 = arg_83_0.battleScrollRect.normalizedPosition.y + 1 / (arg_83_0.totalTimes - 4)

		if arg_83_0.battleScrollRect.normalizedPosition.y + 1 / (arg_83_0.totalTimes - 4) > 1 then
			var_94_0 = 1
		end

		scrollTo(arg_83_0.battleScrollRect, 0, var_94_0)

		return
	end, SFX_CANCEL)
	onButton(arg_83_0, findTF(arg_83_0.menuUI, "rightPanelBg/arrowDown"), function()
		local var_95_0 = arg_83_0.battleScrollRect.normalizedPosition.y - 1 / (arg_83_0.totalTimes - 4)

		if arg_83_0.battleScrollRect.normalizedPosition.y - 1 / (arg_83_0.totalTimes - 4) < 0 then
			var_95_0 = 0
		end

		scrollTo(arg_83_0.battleScrollRect, 0, var_95_0)

		return
	end, SFX_CANCEL)
	onButton(arg_83_0, findTF(arg_83_0.menuUI, "btnBack"), function()
		arg_83_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_83_0, findTF(arg_83_0.menuUI, "btnRule"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ssss_game_tip.tip
		})

		return
	end, SFX_CONFIRM)
	onButton(arg_83_0, findTF(arg_83_0.menuUI, "btnStart"), function()
		local var_98_0 = arg_83_0:getGameUsedTimes() or 0
		local var_98_1 = arg_83_0:getGameTimes() or 0

		if var_98_0 >= #var_0_35 and arg_83_0.selectedUI then
			arg_83_0:updateSelectedUI()
			setActive(arg_83_0.selectedUI, true)
		else
			if (var_98_0 == 0 and 1 or var_98_1 > 0 and var_98_0 + 1 or var_98_0) > #var_0_35 then
				var_98_2 = #var_0_35
			end

			local var_98_4 = var_0_35[var_98_2]

			var_0_31 = var_0_35[var_98_2][1]
			var_0_32 = var_98_4[2]

			setActive(arg_83_0.menuUI, false)
			arg_83_0:readyStart()
		end

		return
	end, SFX_CONFIRM)

	local var_83_4 = findTF(arg_83_0.menuUI, "tplBattleItem")

	arg_83_0.battleItems = {}
	arg_83_0.dropItems = {}

	for iter_83_2 = 1, 7 do
		local var_83_5 = tf(instantiate(var_83_4))

		var_83_5.name = "battleItem_" .. iter_83_2

		setParent(var_83_5, findTF(arg_83_0.menuUI, "battList/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/gridgameui_atlas", "battleDesc" .. iter_83_2, function(arg_99_0)
			setImageSprite(findTF(var_83_5, "state_open/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_clear/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_current/buttomDesc"), arg_99_0, true)
			setImageSprite(findTF(var_83_5, "state_closed/buttomDesc"), arg_99_0, true)

			return
		end)
		setActive(var_83_5, true)
		table.insert(arg_83_0.battleItems, var_83_5)
	end

	arg_83_0.handle = arg_83_0.handle or UpdateBeat:CreateListener(arg_83_0.Update, arg_83_0)

	UpdateBeat:AddListener(arg_83_0.handle)

	return
end

function var_0_0.initGameUI(arg_100_0)
	arg_100_0.gameUI = findTF(arg_100_0._tf, "ui/gameUI")

	onButton(arg_100_0, findTF(arg_100_0.gameUI, "topRight/btnStop"), function()
		arg_100_0:stopGame()
		setActive(arg_100_0.pauseUI, true)

		return
	end)
	onButton(arg_100_0, findTF(arg_100_0.gameUI, "btnLeave"), function()
		arg_100_0:stopGame()
		setActive(arg_100_0.leaveUI, true)

		return
	end)

	arg_100_0.gameTimeS = findTF(arg_100_0.gameUI, "top/time/s")
	arg_100_0.scoreTf = findTF(arg_100_0.gameUI, "top/score")
	arg_100_0.scoreAnimTf = findTF(arg_100_0._tf, "sceneContainer/scene_front/scoreAnim")
	arg_100_0.scoreAnimTextTf = findTF(arg_100_0._tf, "sceneContainer/scene_front/scoreAnim/text")

	setActive(arg_100_0.scoreAnimTf, false)

	return
end

function var_0_0.initController(arg_103_0)
	arg_103_0.boxController = var_0_48(findTF(arg_103_0.gameUI, "box"), arg_103_0)
	arg_103_0.specialController = var_0_50(findTF(arg_103_0.gameUI, "specialPower"), findTF(arg_103_0.gameUI, "successPower"), arg_103_0)
	arg_103_0.bgController = var_0_51(findTF(arg_103_0._tf, "sceneContainer"), arg_103_0.gameUI, arg_103_0)
	arg_103_0.roleController = var_0_52(findTF(arg_103_0._tf, "sceneContainer/scene"), arg_103_0)

	return
end

function var_0_0.Update(arg_104_0)
	arg_104_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_105_0)
	if arg_105_0.gameStop or arg_105_0.settlementFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.updateSelectedUI(arg_106_0)
	for iter_106_0 = 1, #arg_106_0.leftSelectRole do
		if var_0_31 == arg_106_0.leftSelectRole[iter_106_0].id then
			setActive(findTF(arg_106_0.leftSelectRole[iter_106_0].tf, "selected"), true)
			setActive(findTF(arg_106_0.leftSelectRole[iter_106_0].tf, "unSelected"), false)
		else
			setActive(findTF(arg_106_0.leftSelectRole[iter_106_0].tf, "selected"), false)
			setActive(findTF(arg_106_0.leftSelectRole[iter_106_0].tf, "unSelected"), true)
		end
	end

	for iter_106_1 = 1, #arg_106_0.rightSelectRole do
		if var_0_32 == arg_106_0.rightSelectRole[iter_106_1].id then
			setActive(findTF(arg_106_0.rightSelectRole[iter_106_1].tf, "selected"), true)
			setActive(findTF(arg_106_0.rightSelectRole[iter_106_1].tf, "unSelected"), false)
		else
			setActive(findTF(arg_106_0.rightSelectRole[iter_106_1].tf, "selected"), false)
			setActive(findTF(arg_106_0.rightSelectRole[iter_106_1].tf, "unSelected"), true)
		end
	end

	return
end

function var_0_0.updateMenuUI(arg_107_0)
	local var_107_0 = arg_107_0:getGameUsedTimes()

	if var_107_0 and var_107_0 >= 7 then
		setActive(findTF(arg_107_0.menuUI, "btnStart/free"), true)
	else
		setActive(findTF(arg_107_0.menuUI, "btnStart/free"), false)
	end

	local var_107_1 = arg_107_0:getGameTimes()

	for iter_107_0 = 1, #arg_107_0.battleItems do
		setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_open"), false)
		setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_closed"), false)
		setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_clear"), false)
		setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_current"), false)

		if iter_107_0 <= var_107_0 then
			setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_clear"), true)
		elseif iter_107_0 == var_107_0 + 1 and var_107_1 >= 1 then
			setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_current"), true)
		elseif var_107_0 < iter_107_0 and iter_107_0 <= var_107_0 + var_107_1 then
			setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_open"), true)
		else
			setActive(findTF(arg_107_0.battleItems[iter_107_0], "state_closed"), true)
		end
	end

	arg_107_0.totalTimes = arg_107_0:getGameTotalTime()

	local var_107_2 = 1 - (arg_107_0:getGameUsedTimes() - 3 < 0 and 0 or arg_107_0:getGameUsedTimes() - 3) / (arg_107_0.totalTimes - 4)

	if var_107_2 > 1 then
		var_107_2 = 1
	end

	scrollTo(arg_107_0.battleScrollRect, 0, var_107_2)
	setActive(findTF(arg_107_0.menuUI, "btnStart/tip"), var_107_1 > 0)
	arg_107_0:CheckGet()

	return
end

function var_0_0.CheckGet(arg_108_0)
	setActive(findTF(arg_108_0.menuUI, "got"), false)

	if arg_108_0:getUltimate() and arg_108_0:getUltimate() ~= 0 then
		setActive(findTF(arg_108_0.menuUI, "got"), true)
	end

	if arg_108_0:getUltimate() == 0 then
		if arg_108_0:getGameTotalTime() > arg_108_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_108_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
		setActive(findTF(arg_108_0.menuUI, "got"), true)
	end

	return
end

function var_0_0.openMenuUI(arg_109_0)
	setActive(findTF(arg_109_0._tf, "sceneContainer/scene_front"), false)
	setActive(findTF(arg_109_0._tf, "sceneContainer/scene_background"), false)
	setActive(findTF(arg_109_0._tf, "sceneContainer/scene"), false)
	setActive(arg_109_0.gameUI, false)
	setActive(arg_109_0.menuUI, true)
	setActive(arg_109_0.selectedUI, false)
	arg_109_0:updateMenuUI()

	local var_109_0 = arg_109_0:getBGM() or pg.CriMgr.GetInstance():IsDefaultBGM() and pg.voice_bgm.NewMainScene.default_bgm or pg.voice_bgm.NewMainScene.bgm

	if arg_109_0.bgm ~= var_109_0 then
		arg_109_0.bgm = var_109_0

		pg.BgmMgr.GetInstance():Push(arg_109_0.__cname, var_109_0)
	end

	return
end

function var_0_0.clearUI(arg_110_0)
	setActive(arg_110_0.sceneTf, false)
	setActive(arg_110_0.settlementUI, false)
	setActive(arg_110_0.countUI, false)
	setActive(arg_110_0.menuUI, false)
	setActive(arg_110_0.gameUI, false)
	setActive(arg_110_0.selectedUI, false)

	return
end

function var_0_0.readyStart(arg_111_0)
	setActive(arg_111_0.countUI, true)
	arg_111_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

	if var_0_1 and arg_111_0.bgm ~= var_0_1 then
		arg_111_0.bgm = var_0_1

		pg.BgmMgr.GetInstance():Push(arg_111_0.__cname, var_0_1)
	end

	return
end

function var_0_0.gameStart(arg_112_0)
	setActive(findTF(arg_112_0._tf, "sceneContainer/scene_front"), true)
	setActive(findTF(arg_112_0._tf, "sceneContainer/scene_background"), true)
	setActive(findTF(arg_112_0._tf, "sceneContainer/scene"), true)
	setActive(arg_112_0.scoreAnimTf, false)
	setActive(arg_112_0.gameUI, true)

	arg_112_0.gameStartFlag = true
	arg_112_0.scoreNum = 0
	arg_112_0.playerPosIndex = 2
	arg_112_0.gameStepTime = 0
	arg_112_0.gameTime = var_0_5
	arg_112_0.ignoreTime = false

	arg_112_0.boxController:start()
	arg_112_0.specialController:start()
	arg_112_0.bgController:start()
	arg_112_0.roleController:start()
	arg_112_0:updateGameUI()
	arg_112_0:timerStart()

	return
end

function var_0_0.getGameTimes(arg_113_0)
	return arg_113_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_114_0)
	return arg_114_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_115_0)
	return arg_115_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_116_0)
	return (arg_116_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.changeSpeed(arg_117_0, arg_117_1)
	return
end

function var_0_0.onTimer(arg_118_0)
	arg_118_0:gameStep()

	return
end

function var_0_0.gameStep(arg_119_0)
	if not arg_119_0.ignoreTime then
		arg_119_0.gameTime = arg_119_0.gameTime - Time.deltaTime

		if arg_119_0.gameTime < 0 then
			arg_119_0.gameTime = 0
		end

		arg_119_0.gameStepTime = arg_119_0.gameStepTime + Time.deltaTime
	end

	arg_119_0.boxController:step()
	arg_119_0.specialController:step()
	arg_119_0.bgController:step()
	arg_119_0.roleController:step()
	arg_119_0:updateGameUI()

	if arg_119_0.gameTime <= 0 then
		arg_119_0:onGameOver()

		return
	end

	return
end

function var_0_0.timerStart(arg_120_0)
	if not arg_120_0.timer.running then
		arg_120_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_121_0)
	if arg_121_0.timer.running then
		arg_121_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_122_0)
	setText(arg_122_0.scoreTf, arg_122_0.scoreNum)
	setText(arg_122_0.gameTimeS, math.ceil(arg_122_0.gameTime))

	return
end

function var_0_0.addScore(arg_123_0, arg_123_1)
	setActive(arg_123_0.scoreAnimTf, false)
	setActive(arg_123_0.scoreAnimTf, true)
	setText(arg_123_0.scoreAnimTextTf, "+" .. tostring(arg_123_1))

	arg_123_0.scoreNum = arg_123_0.scoreNum + arg_123_1

	if arg_123_0.scoreNum < 0 then
		arg_123_0.scoreNum = 0
	end

	return
end

function var_0_0.onGameOver(arg_124_0)
	if arg_124_0.settlementFlag then
		return
	end

	arg_124_0:timerStop()

	arg_124_0.settlementFlag = true

	setActive(arg_124_0.clickMask, true)

	if arg_124_0.roleController then
		arg_124_0.roleController:clear()
	end

	if arg_124_0.bgController then
		arg_124_0.bgController:clear()
	end

	LeanTween.delayedCall(go(arg_124_0._tf), 0.1, System.Action(function()
		arg_124_0.settlementFlag = false
		arg_124_0.gameStartFlag = false

		setActive(arg_124_0.clickMask, false)
		arg_124_0:showSettlement()

		return
	end))

	return
end

function var_0_0.showSettlement(arg_126_0)
	setActive(arg_126_0.settlementUI, true)
	GetComponent(findTF(arg_126_0.settlementUI, "ad"), typeof(Animator)):Play("settlement", -1, 0)

	local var_126_0 = arg_126_0:GetMGData():GetRuntimeData("elements")
	local var_126_1 = arg_126_0.scoreNum

	if var_126_0 and #var_126_0 > 0 then
		local var_126_2 = var_126_0[1] or 0

		setActive(findTF(arg_126_0.settlementUI, "ad/new"), var_126_2 < var_126_1)

		if var_126_2 <= var_126_1 then
			var_126_2 = var_126_1

			arg_126_0:StoreDataToServer({
				var_126_1
			})
		end

		setText(findTF(arg_126_0.settlementUI, "ad/highText"), var_126_2)
		setText(findTF(arg_126_0.settlementUI, "ad/currentText"), var_126_1)

		if arg_126_0:getGameTimes() and arg_126_0:getGameTimes() > 0 then
			arg_126_0.sendSuccessFlag = true

			arg_126_0:SendSuccess(0)
		end

		return
	end
end

function var_0_0.resumeGame(arg_127_0)
	arg_127_0.gameStop = false

	setActive(arg_127_0.leaveUI, false)
	arg_127_0:changeSpeed(1)
	arg_127_0:timerStart()

	return
end

function var_0_0.stopGame(arg_128_0)
	arg_128_0.gameStop = true

	arg_128_0:timerStop()
	arg_128_0:changeSpeed(0)

	return
end

function var_0_0.onBackPressed(arg_129_0)
	if not arg_129_0.gameStartFlag then
		arg_129_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_129_0.settlementFlag then
			return
		end

		if isActive(arg_129_0.pauseUI) then
			setActive(arg_129_0.pauseUI, false)
		end

		arg_129_0:stopGame()
		setActive(arg_129_0.leaveUI, true)
	end

	return
end

function var_0_0.willExit(arg_130_0)
	if arg_130_0.handle then
		UpdateBeat:RemoveListener(arg_130_0.handle)
	end

	if arg_130_0._tf and LeanTween.isTweening(go(arg_130_0._tf)) then
		LeanTween.cancel(go(arg_130_0._tf))
	end

	if arg_130_0.timer and arg_130_0.timer.running then
		arg_130_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_130_0.timer = nil

	return
end

return var_0_0
