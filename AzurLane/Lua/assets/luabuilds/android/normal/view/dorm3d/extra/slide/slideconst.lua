class = var_0_10000

local var_0_0 = var_0_10000("SlideConst")

var_0_0.ROOM_ID = 4
var_0_0.FURNITURE_ID = 401
var_0_0.TIMER_INTERVAL = 100
var_0_0.COMMAND_TYPE = {
	TELEPORT = 4,
	WALK = 1,
	SLIDE = 3,
	ANIM_MOVE_ROTATE = 6,
	LADDER = 2,
	ANIM = 5
}
var_0_0.LADDER_DISPLACEMENT = {
	z = 0.53,
	x = 0,
	y = 0.338
}
var_0_0.SLIDE_GRAVITY = 9.8
var_0_0.WALK_ANIM = "swim_slide_walk_01"
var_0_0.SLIDE_ANIM = "swim_slide_down_01"
var_0_0.LADDER_ANIM = "swim_slide_ladder_01"
var_0_0.IDLE_ANIM = "Idle"
var_0_0.QTE_INTERVAL = 0.7
var_0_0.QTE_TIME = 1
var_0_0.QTE_SUCCESS_RANGE = {
	0.2,
	0.8
}
var_0_0.QTE_COUNT = 4
var_0_0.QTE_SLOW_SPEED = 0.1
var_0_0.WET_FADE_IN_TIME = 3
var_0_0.SLIDE_ZONE = "Slide"

return var_0_0
