local Dorm3dDanceConst = class("Dorm3dDanceConst")

Dorm3dDanceConst.CUCOLORIS_COUNT = 3
Dorm3dDanceConst.PHOTO_TIMES = 6
Dorm3dDanceConst.VIEW_ENUM = {
	PREPARE = 1,
	GAME = 2,
	RESULT = 3
}
Dorm3dDanceConst.GAME_STATE = {
	PREPARE = 1,
	GAME = 2,
	RESULT = 3,
	NONE = 0
}
Dorm3dDanceConst.GAME_RANDOM_RANGE_POSX = {
	-20,
	20
}
Dorm3dDanceConst.GAME_RANDOM_RANGE_POSY = {
	-20,
	20
}
Dorm3dDanceConst.GAME_RANDOM_RANGE_ANGLE = {
	-15,
	15
}
Dorm3dDanceConst.RESULT_RANDOM_RANGE_POSY = {
	-10,
	10
}
Dorm3dDanceConst.RESULT_RANDOM_RANGE_ANGLE = {
	-15,
	15
}
Dorm3dDanceConst.SCORE_RANGE = {
	S = {
		2800,
		3000
	},
	A = {
		2000,
		2699
	},
	B = {
		1000,
		1999
	},
	C = {
		0,
		999
	}
}
Dorm3dDanceConst.PHOTO_MOVE_TIME = 1
Dorm3dDanceConst.CUCOLORIS_FADE_100_50 = 0.5
Dorm3dDanceConst.CUCOLORIS_FADE_50_0 = 0.5
Dorm3dDanceConst.MATCH_ANIM_TIME = 0.2
Dorm3dDanceConst.SCORE_ANIM_TIME = 0.3
Dorm3dDanceConst.RANK_ANIM_TIME = 0.5
Dorm3dDanceConst.PHOTO_SCALE = Vector3(0.58, 0.58, 0.58)

return Dorm3dDanceConst
