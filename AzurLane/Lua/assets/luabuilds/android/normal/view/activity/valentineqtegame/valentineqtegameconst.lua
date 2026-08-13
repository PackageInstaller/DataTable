class = var_0_10000

local var_0_0 = var_0_10000("ValentineQteGameConst")

var_0_0.DEBUG = false
var_0_0.OP_SCORE_GEAR_PERFECT = 1
var_0_0.OP_SCORE_GEAR_GREAT = 2
var_0_0.OP_SCORE_GEAR_GOOD = 3
var_0_0.OP_SCORE_GEAR_MISS = 4
var_0_0.GMAE_TIME = 50
var_0_0.SLIDEWAY_WIDTH = 1334
var_0_0.SLIDER_WIDTH = 104
var_0_0.PERFECT_WIDTH = 150
var_0_0.GREAT_WIDTH = 270
var_0_0.GOOD_WIDTH = 500
var_0_0.INIT_SPEED = 550
var_0_0.SPEEDUP_RATIO_PRE_5SEC = 3
var_0_0.SPEED_UP = var_0_0.INIT_SPEED * var_0_0.SPEEDUP_RATIO_PRE_5SEC * 0.01
var_0_0.MAX_SPEEDUP_RATIO = 120
var_0_0.MAX_SPEED = var_0_0.INIT_SPEED * var_0_0.MAX_SPEEDUP_RATIO * 0.01
var_0_0.BASE_OP_SCORE = 100
var_0_0.OP_SCORE = {
	[var_0_0.OP_SCORE_GEAR_PERFECT] = 1,
	[var_0_0.OP_SCORE_GEAR_GREAT] = 0.7,
	[var_0_0.OP_SCORE_GEAR_GOOD] = 0.5,
	[var_0_0.OP_SCORE_GEAR_MISS] = 0
}

local var_0_1 = {
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
	}
}
local var_0_2 = {
	21,
	nil,
	100
}

Mathf = var_3
var_0_2[2] = var_3.Infinity
var_0_1[5] = var_0_2
var_0_0.COMBO_EXTRA_SCORE_RATIO = var_0_1
var_0_0.OP_INTERVAL = 0.2
var_0_0.GEN_ITEM_FIRST_TIME = 5
var_0_0.GEN_ITEM_INTERVAL = 3
var_0_0.ITEM_DISAPPEAR_TIME = 5
var_0_0.MAX_ITEM_COUNT = 4

local var_0_3 = {}
local var_0_4 = {
	6000,
	nil,
	"s"
}

Mathf = var_3
var_0_4[2] = var_3.Infinity
var_0_3[1] = var_0_4
var_0_3[2] = {
	3000,
	5999,
	"a"
}
var_0_3[3] = {
	1000,
	2999,
	"b"
}
var_0_3[4] = {
	0,
	999,
	"c"
}
var_0_0.CHAT_CONTENT = var_0_3
var_0_0.GEAR_SHOW_TIME = 0.7
var_0_0.OPEN_DOOR_TIME = 3
var_0_0.SOUND_PICK_ITEM = "event:/ui/mini_get"
var_0_0.GEAR_SOUND = {
	[var_0_0.OP_SCORE_GEAR_PERFECT] = "event:/ui/mini_perfect",
	[var_0_0.OP_SCORE_GEAR_GREAT] = "event:/ui/mini_great",
	[var_0_0.OP_SCORE_GEAR_GOOD] = "event:/ui/mini_miss",
	[var_0_0.OP_SCORE_GEAR_MISS] = "event:/ui/mini_miss"
}

return var_0_0
