local ValentineQteGameConst = class("ValentineQteGameConst")

ValentineQteGameConst.DEBUG = false
ValentineQteGameConst.OP_SCORE_GEAR_PERFECT = 1
ValentineQteGameConst.OP_SCORE_GEAR_GREAT = 2
ValentineQteGameConst.OP_SCORE_GEAR_GOOD = 3
ValentineQteGameConst.OP_SCORE_GEAR_MISS = 4
ValentineQteGameConst.GMAE_TIME = 50
ValentineQteGameConst.SLIDEWAY_WIDTH = 1334
ValentineQteGameConst.SLIDER_WIDTH = 104
ValentineQteGameConst.PERFECT_WIDTH = 150
ValentineQteGameConst.GREAT_WIDTH = 270
ValentineQteGameConst.GOOD_WIDTH = 500
ValentineQteGameConst.INIT_SPEED = 550
ValentineQteGameConst.SPEEDUP_RATIO_PRE_5SEC = 3
ValentineQteGameConst.SPEED_UP = ValentineQteGameConst.INIT_SPEED * ValentineQteGameConst.SPEEDUP_RATIO_PRE_5SEC * 0.01
ValentineQteGameConst.MAX_SPEEDUP_RATIO = 120
ValentineQteGameConst.MAX_SPEED = ValentineQteGameConst.INIT_SPEED * ValentineQteGameConst.MAX_SPEEDUP_RATIO * 0.01
ValentineQteGameConst.BASE_OP_SCORE = 100
ValentineQteGameConst.OP_SCORE = {
	[ValentineQteGameConst.OP_SCORE_GEAR_PERFECT] = 1,
	[ValentineQteGameConst.OP_SCORE_GEAR_GREAT] = 0.7,
	[ValentineQteGameConst.OP_SCORE_GEAR_GOOD] = 0.5,
	[ValentineQteGameConst.OP_SCORE_GEAR_MISS] = 0
}
ValentineQteGameConst.COMBO_EXTRA_SCORE_RATIO = {
	{
		2,
		5,
		20
	},
	{
		6,
		10,
		40
	},
	{
		11,
		15,
		60
	},
	{
		16,
		20,
		80
	},
	{
		21,
		Mathf.Infinity,
		100
	}
}
ValentineQteGameConst.OP_INTERVAL = 0.2
ValentineQteGameConst.GEN_ITEM_FIRST_TIME = 5
ValentineQteGameConst.GEN_ITEM_INTERVAL = 3
ValentineQteGameConst.ITEM_DISAPPEAR_TIME = 5
ValentineQteGameConst.MAX_ITEM_COUNT = 4
ValentineQteGameConst.CHAT_CONTENT = {
	{
		6000,
		Mathf.Infinity,
		"s"
	},
	{
		3000,
		5999,
		"a"
	},
	{
		1000,
		2999,
		"b"
	},
	{
		0,
		999,
		"c"
	}
}
ValentineQteGameConst.GEAR_SHOW_TIME = 0.7
ValentineQteGameConst.OPEN_DOOR_TIME = 3
ValentineQteGameConst.SOUND_PICK_ITEM = "event:/ui/mini_get"
ValentineQteGameConst.GEAR_SOUND = {
	[ValentineQteGameConst.OP_SCORE_GEAR_PERFECT] = "event:/ui/mini_perfect",
	[ValentineQteGameConst.OP_SCORE_GEAR_GREAT] = "event:/ui/mini_great",
	[ValentineQteGameConst.OP_SCORE_GEAR_GOOD] = "event:/ui/mini_miss",
	[ValentineQteGameConst.OP_SCORE_GEAR_MISS] = "event:/ui/mini_miss"
}

return ValentineQteGameConst
