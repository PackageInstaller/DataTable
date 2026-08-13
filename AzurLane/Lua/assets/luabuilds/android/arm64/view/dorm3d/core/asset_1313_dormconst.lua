class = var_0_10000

local var_0_0 = var_0_10000("DormConst")

var_0_0.boneMap = {
	Head = "Bip001 Head",
	LeftUpperArm = "Bip001 L UpperArm",
	RightThigh = "Bip001 R Thigh",
	LeftFoot = "Bip001 L Foot",
	RightUpperArm = "Bip001 R UpperArm",
	RightForeArm = "Bip001 R Forearm",
	RightFoot = "Bip001 R Foot",
	RightHand = "Bip001 R Hand",
	LeftThigh = "Bip001 L Thigh",
	Spine = "Bip001 Spine",
	Spine1 = "Bip001 Spine1",
	Spine2 = "Bip001 Spine2",
	LeftHand = "Bip001 L Hand",
	Pelvis = "Bip001 Pelvis",
	LeftForeArm = "Bip001 L Forearm",
	RightCalf = "Bip001 R Calf",
	LeftCalf = "Bip001 L Calf"
}
var_0_0.BONE_TO_TOUCH = {
	Head = "head",
	LeftUpperArm = "hand",
	RightThigh = "leg",
	LeftFoot = "leg",
	RightFoot = "leg",
	RightLowerArm = "hand",
	Chest = "chest",
	RightUpperArm = "hand",
	RightHand = "hand",
	Butt = "butt",
	LeftThigh = "leg",
	Back = "back",
	LeftLowerArm = "hand",
	LeftHand = "hand",
	RightCalf = "leg",
	LeftCalf = "leg",
	Belly = "belly"
}

function var_0_0.GetDefaultSystemClasses()
	local var_1_0 = {}

	SlideExtraSystem = var_1_10001
	var_1_0[1] = var_1_10001
	Dorm3dStockingMgr = var_1_10001
	var_1_0[2] = var_1_10001
	TeleportSystem = var_1_10001
	var_1_0[3] = var_1_10001
	RoomIKSystem = var_1_10001
	var_1_0[4] = var_1_10001
	RoomTouchSystem = var_1_10001
	var_1_0[5] = var_1_10001
	AimIKSystem = var_1_10001
	var_1_0[6] = var_1_10001

	return var_1_0
end

var_0_0.DEFAULT_ANIM_FADE_IN_TIME = 0.25
var_0_0.LADY_MOVE_SPEED = 0.85
var_0_0.LADY_ROTATE_SPEED = 10
var_0_0.TRANSPARENCY_MIN_DISTANCE = 0.6
var_0_0.TRANSPARENCY_MAX_DISTANCE = 1.2

local var_0_1 = {
	stepOffset = 0.2,
	radius = 0.08,
	height = 1.49
}

Vector3 = var_2
var_0_1.center = var_2(0, 0.78, 0)
var_0_0.CHARACTER_CONTROLLER = var_0_1

return var_0_0
