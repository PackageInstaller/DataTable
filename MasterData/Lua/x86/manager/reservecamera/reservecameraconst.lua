local var_0_0 = {}

var_0_0.CUSTOM_BLEND_ASSET_PATH = "UI/HeroCamera/CameraData/MainCamera_Blends_Formation_X104.asset"
var_0_0.CAMERA_TYPE = {
	common = 1,
	hero = 2,
	null = 0
}
var_0_0.CAMERA_TEMPLATE_PREFAB = {
	[var_0_0.CAMERA_TYPE.common] = "UI/HeroCamera/FormationCommonCameraGroup_X104",
	[var_0_0.CAMERA_TYPE.hero] = "UI/HeroCamera/FormationHeroCameraGroup_X104"
}
var_0_0.CAMERA_TEMPLATE_CLASS_NAME = {
	[var_0_0.CAMERA_TYPE.common] = "ReserveCameraTemplate",
	[var_0_0.CAMERA_TYPE.hero] = "ReserveHeroCameraTemplate"
}
var_0_0.VIRTUAL_CAMERA = {
	heroPos_2 = 4,
	reserveProposal = 2,
	heroPos_1 = 3,
	sectionSelectHero = 1,
	heroPos_3 = 5
}

return var_0_0
