local SlideConst = class("SlideConst")

SlideConst.ROOM_ID = 4
SlideConst.FURNITURE_ID = 401
SlideConst.TIMER_INTERVAL = 100
SlideConst.COMMAND_TYPE = {
	TELEPORT = 4,
	WALK = 1,
	SLIDE = 3,
	ANIM_MOVE_ROTATE = 6,
	LADDER = 2,
	ANIM = 5
}
SlideConst.LADDER_DISPLACEMENT = {
	z = 0.53,
	x = 0,
	y = 0.338
}
SlideConst.SLIDE_GRAVITY = 9.8
SlideConst.WALK_ANIM = "swim_slide_walk_01"
SlideConst.SLIDE_ANIM = "swim_slide_down_01"
SlideConst.LADDER_ANIM = "swim_slide_ladder_01"
SlideConst.IDLE_ANIM = "Idle"
SlideConst.QTE_INTERVAL = 0.7
SlideConst.QTE_TIME = 1
SlideConst.QTE_SUCCESS_RANGE = {
	0.2,
	0.8
}
SlideConst.QTE_COUNT = 4
SlideConst.QTE_SLOW_SPEED = 0.1
SlideConst.WET_FADE_IN_TIME = 3
SlideConst.SLIDE_ZONE = "Slide"

return SlideConst
