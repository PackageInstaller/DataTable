ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle
local var_0_2

if not var_0.Battle.BattleVariable then
	var_0_2 = {}
end

var_0_1.BattleVariable = var_0_2

local var_0_3 = var_0.Battle.BattleVariable
local var_0_4 = var_0.Battle.BattleConfig

function var_0_3.Init(arg_1_0)
	var_0_3.speedRatioByIFF = {
		[0] = -1,
		1,
		[1] = 1
	}
	var_0_3.focusExemptList = {}
	var_0_3.MapSpeedRatio = 1
	var_0_3.MapSpeedFacotrList = {}

	local var_1_0 = var_0_3

	var_1_0.IFFFactorList = {}
	pairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(var_0_3.speedRatioByIFF) do
		var_1_10006 = var_0_3.IFFFactorList
		var_1_10006[iter_1_0] = {}
	end

	local var_1_1 = var_0_3

	var_1_1._lastCameraPos = nil
	pg = var_1_1

	local var_1_2 = var_1_1.UIMgr.GetInstance()
	local var_1_3 = var_1.GetMainCamera(var_1_2)

	if not arg_1_0 then
		setActive = var_2

		var_2(var_1_3, true)
	end

	local var_1_4 = var_0_3
	local var_1_5 = var_1_3
	local var_1_6 = var_1_3.GetComponent

	typeof = var_1_10006
	Camera = var_1_10008
	var_1_4._camera = var_1_6(var_1_5, var_1_10006(var_1_10008))
	var_0_3._cameraTF = var_0_3._camera.transform

	local var_1_7 = var_0_3

	GameObject = var_3

	local var_1_8 = var_3.Find("UICamera")
	local var_1_9 = var_3.GetComponent

	typeof = var_6
	Camera = var_1_10008
	var_1_7._uiCamera = var_1_9(var_1_8, var_6(var_1_10008))
	math = var_1_7

	local var_1_10 = var_1_7.deg2Rad * var_0_3._cameraTF.localEulerAngles.x
	local var_1_11 = var_0_3

	math = iter_1_0
	var_1_11._camera_radian_x_sin = iter_1_0.sin(var_1_10)

	local var_1_12 = var_0_3

	math = var_4
	var_1_12._camera_radian_x_cos = var_4.cos(var_1_10)
	var_0_3._camera_radian_x_tan = var_0_3._camera_radian_x_sin / var_0_3._camera_radian_x_cos
	var_0_3.CameraNormalHeight = var_0_3._camera_radian_x_cos * var_0_4.CAMERA_SIZE + var_0_4.CAMERA_BASE_HEIGH
	var_0_3.CameraFocusHeight = var_0_3._camera_radian_x_cos * var_0_4.CAST_CAM_ZOOM_SIZE + var_0_4.CAMERA_BASE_HEIGH

	return
end

function var_0_3.Clear()
	var_0_3.speedRatioByIFF = nil
	var_0_3.focusExemptList = nil
	var_0_3.MapSpeedRatio = nil
	var_0_3.MapSpeedFacotrList = nil
	var_0_3.IFFFactorList = nil
	var_0_3._lastCameraPos = nil
	var_0_3._camera = nil
	var_0_3._cameraTF = nil
	var_0_3._uiCamera = nil
	var_0_3._camera_radian_x_sin = nil
	var_0_3._camera_radian_x_cos = nil
	var_0_3._camera_radian_x_tan = nil
	var_0_3.CameraNormalHeight = nil
	var_0_3.CameraFocusHeight = nil

	return
end

local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = 0
local var_0_9 = 0
local var_0_10 = 0

function var_0_3.UpdateCameraPositionArgs()
	local var_3_0 = var_0_3._cameraTF.position

	CameraMgr = var_1_10001

	local var_3_1 = var_1_10001.instance
	local var_3_2 = var_1.GetCameraOrthographicSize(var_3_1, var_0_3._camera)
	local var_3_3

	if var_0_3._lastCameraPos == var_3_0 and var_0_3._lastCameraSize == var_3_2 then
		return
	else
		var_3_3 = var_0_3
		var_3_3._lastCameraPos = var_3_0
		var_3_3 = var_0_3
		var_3_3._lastCameraSize = var_3_2
	end

	pg = var_3_3

	local var_3_4 = var_3_3.CameraFixMgr.GetInstance()
	local var_3_5 = var_0_3._camera
	local var_3_6 = var_3.ScreenToWorldPoint(var_3_5, var_3_4.leftBottomVector)
	local var_3_7 = var_0_3._camera
	local var_3_8 = var_4.ScreenToWorldPoint(var_3_7, var_3_4.rightTopVector)
	local var_3_9 = var_0_3._uiCamera
	local var_3_10 = var_5.ScreenToWorldPoint(var_3_9, var_3_4.leftBottomVector)
	local var_3_11 = var_0_3._uiCamera
	local var_3_12 = var_6.ScreenToWorldPoint(var_3_11, var_3_4.rightTopVector)

	var_0_5 = var_3_6.x
	var_0_6 = var_3_10.x
	var_0_7 = (var_3_12.x - var_3_10.x) / (var_3_8.x - var_3_6.x)

	local var_3_13 = var_3_6.y * 0.866 + var_3_6.z * 0.5
	local var_3_14 = var_3_8.y * 0.866 + var_3_8.z * 0.5

	var_0_8 = var_3_13
	var_0_9 = var_3_10.y
	var_0_10 = (var_3_12.y - var_3_10.y) / (var_3_14 - var_3_13)

	return
end

function var_0_3.CameraPosToUICamera(arg_4_0)
	var_0_3.CameraPosToUICameraByRef(arg_4_0)

	return arg_4_0
end

function var_0_3.CameraPosToUICameraByRef(arg_5_0)
	local var_5_0 = (arg_5_0.x - var_0_5) * var_0_7 + var_0_6

	arg_5_0.y, arg_5_0.x = (arg_5_0.y * 0.866 + arg_5_0.z * 0.5 - var_0_8) * var_0_10 + var_0_9, var_5_0
	arg_5_0.z = 0

	return
end

function var_0_3.UIPosToScenePos(arg_6_0, arg_6_1)
	pg = var_1_10002

	local var_6_0 = var_1_10002.CameraFixMgr.GetInstance()
	local var_6_1 = var_2.GetCurrentWidth(var_6_0)
	local var_6_2 = var_2:GetCurrentHeight()
	local var_6_3 = var_6_1 / 0
	local var_6_4 = var_6_2 / 1080

	Vector2 = var_1_10007
	arg_6_0 = var_1_10007(var_6_3 * arg_6_0.x, var_6_4 * arg_6_0.y)

	local var_6_5 = var_0_3._uiCamera
	local var_6_6 = (var_7.ScreenToWorldPoint(var_6_5, arg_6_0).x - var_0_6) / var_0_7 + var_0_5
	local var_6_7 = (var_7.y - var_0_9) / var_0_10 + var_0_8

	math = var_10

	local var_6_8 = var_10.tan

	Mathf = var_1_10012

	local var_6_9 = var_6_7 / var_6_8(30 * var_1_10012.Deg2Rad) + var_6_7 * var_10 * 0.5

	arg_6_1:Set(var_6_6, 0, var_6_9)

	return
end

function var_0_3.AppendMapFactor(arg_7_0, arg_7_1)
	if var_0_3.MapSpeedFacotrList[arg_7_0] ~= nil then
		var_0_3.RemoveMapFactor(arg_7_0)
	end

	var_0_3.MapSpeedRatio = var_0_3.MapSpeedRatio * arg_7_1
	var_0_3.MapSpeedFacotrList[arg_7_0] = arg_7_1

	return
end

function var_0_3.RemoveMapFactor(arg_8_0)
	if var_0_3.MapSpeedFacotrList[arg_8_0] ~= nil then
		var_0_3.MapSpeedRatio = var_0_3.MapSpeedRatio / var_1
		var_0_3.MapSpeedFacotrList[arg_8_0] = nil
	end

	return
end

function var_0_3.AppendIFFFactor(arg_9_0, arg_9_1, arg_9_2)
	if var_0_3.IFFFactorList[arg_9_0][arg_9_1] ~= nil then
		var_0_3.RemoveIFFFactor(arg_9_0, arg_9_1)
	end

	var_0_3.speedRatioByIFF[arg_9_0] = var_0_3.speedRatioByIFF[arg_9_0] * arg_9_2
	var_3[arg_9_1] = arg_9_2
	var_0_3.focusExemptList = {}

	return
end

function var_0_3.RemoveIFFFactor(arg_10_0, arg_10_1)
	if var_0_3.IFFFactorList[arg_10_0][arg_10_1] ~= nil then
		var_0_3.speedRatioByIFF[arg_10_0] = var_0_3.speedRatioByIFF[arg_10_0] / var_3
		var_2[arg_10_1] = nil
		var_0_3.focusExemptList = {}
	end

	return
end

function var_0_3.GetSpeedRatio(arg_11_0, arg_11_1)
	local var_11_0

	if not var_0_3.focusExemptList[arg_11_0] then
		var_11_0 = var_0_3.speedRatioByIFF[arg_11_1]
	end

	return var_11_0
end

function var_0_3.AddExempt(arg_12_0, arg_12_1, arg_12_2)
	if var_0_3.IFFFactorList[arg_12_1][arg_12_2] ~= nil then
		var_0_3.focusExemptList[arg_12_0] = var_0_3.speedRatioByIFF[arg_12_1] / var_4
	end

	return
end

return
