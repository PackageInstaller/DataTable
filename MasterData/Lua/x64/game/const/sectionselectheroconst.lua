local var_0_0 = {
	HeroModelTransform = {
		{
			position = Vector3(500, 0, 0),
			rotation = Vector3(0, -10, 0),
			scale = Vector3(1, 1, 1)
		},
		{
			position = Vector3(502.36, 0, -3.6),
			rotation = Vector3(0, 20, 0),
			scale = Vector3(1, 1, 1)
		},
		{
			position = Vector3(498.32, 0, -3.6),
			rotation = Vector3(0, -25, 0),
			scale = Vector3(1, 1, 1)
		}
	}
}

var_0_0.f2SModelDistanceX = var_0_0.HeroModelTransform[2].position.x - var_0_0.HeroModelTransform[1].position.x
var_0_0.f2TModelDistanceX = var_0_0.HeroModelTransform[1].position.x - var_0_0.HeroModelTransform[3].position.x
var_0_0.f2SModelDistanceZ = var_0_0.HeroModelTransform[1].position.z - var_0_0.HeroModelTransform[2].position.z
var_0_0.f2TModelDistanceZ = var_0_0.HeroModelTransform[1].position.z - var_0_0.HeroModelTransform[2].position.z
var_0_0.f2SModelRotationY = var_0_0.HeroModelTransform[2].rotation.y - var_0_0.HeroModelTransform[1].rotation.y
var_0_0.f2TModelRotationY = var_0_0.HeroModelTransform[1].rotation.y - var_0_0.HeroModelTransform[3].rotation.y
var_0_0.DISPLAY_FILTER_LOCK_HERO_TYPE = {
	NORMAL = "normal",
	PROPOSAL = "proposal"
}
var_0_0.SELECT_HERO_MODE = {
	MULTI = 2,
	SINGLE = 1
}
var_0_0.HERO_POS_STATE = {
	selected = "selected",
	empty = "empty",
	lock = "lock"
}
var_0_0.HERO_CHANGE_FX_PATH = "Effect/tongyong/fx_appear_UI"
var_0_0.HERO_TEAM_DISPLAY_EXTRA_DELAY_TIME = 5000
var_0_0.SCREEN_OFFSET_OF_HERO_INFO_ITEM = 120
var_0_0.HERO_VOICE_TYPE = {
	APPERANCE = 1,
	NULL = 0,
	LEADER = 2,
	MULTI_HERO = 3
}
var_0_0.STANDARD_SCREEN_WIDTH = 1920
var_0_0.STANDARD_SCREEN_HEIGHT = 1080

return var_0_0
