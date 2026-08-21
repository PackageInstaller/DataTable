ys = ys or {}
ys.Battle.BattleVariable = ys.Battle.BattleVariable or {}

local var_0_0 = ys.Battle.BattleVariable
local var_0_1 = ys.Battle.BattleConfig

function ys.Battle.BattleVariable.Init(arg_1_0)
	var_0_0.speedRatioByIFF = {
		[0] = -1,
		1,
		[1] = 1
	}
	var_0_0.focusExemptList = {}
	var_0_0.MapSpeedRatio = 1
	var_0_0.MapSpeedFacotrList = {}
	var_0_0.IFFFactorList = {}

	for iter_1_0, iter_1_1 in pairs(var_0_0.speedRatioByIFF) do
		var_0_0.IFFFactorList[iter_1_0] = {}
	end

	var_0_0._lastCameraPos = nil

	local var_1_0 = pg.UIMgr.GetInstance():GetMainCamera()

	if not arg_1_0 then
		setActive(var_1_0, true)
	end

	var_0_0._camera = var_1_0:GetComponent(typeof(Camera))
	var_0_0._cameraTF = var_0_0._camera.transform
	var_0_0._uiCamera = GameObject.Find("UICamera"):GetComponent(typeof(Camera))
	var_0_0._camera_radian_x_sin = math.sin(math.deg2Rad * var_0_0._cameraTF.localEulerAngles.x)
	var_0_0._camera_radian_x_cos = math.cos(math.deg2Rad * var_0_0._cameraTF.localEulerAngles.x)
	var_0_0._camera_radian_x_tan = var_0_0._camera_radian_x_sin / var_0_0._camera_radian_x_cos
	var_0_0.CameraNormalHeight = var_0_0._camera_radian_x_cos * var_0_1.CAMERA_SIZE + var_0_1.CAMERA_BASE_HEIGH
	var_0_0.CameraFocusHeight = var_0_0._camera_radian_x_cos * var_0_1.CAST_CAM_ZOOM_SIZE + var_0_1.CAMERA_BASE_HEIGH

	return
end

function ys.Battle.BattleVariable.Clear()
	var_0_0.speedRatioByIFF = nil
	var_0_0.focusExemptList = nil
	var_0_0.MapSpeedRatio = nil
	var_0_0.MapSpeedFacotrList = nil
	var_0_0.IFFFactorList = nil
	var_0_0._lastCameraPos = nil
	var_0_0._camera = nil
	var_0_0._cameraTF = nil
	var_0_0._uiCamera = nil
	var_0_0._camera_radian_x_sin = nil
	var_0_0._camera_radian_x_cos = nil
	var_0_0._camera_radian_x_tan = nil
	var_0_0.CameraNormalHeight = nil
	var_0_0.CameraFocusHeight = nil

	return
end

local var_0_2 = 0
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = 0

function ys.Battle.BattleVariable.UpdateCameraPositionArgs()
	local var_3_0 = CameraMgr.instance:GetCameraOrthographicSize(var_0_0._camera)

	if var_0_0._lastCameraPos == var_0_0._cameraTF.position and var_0_0._lastCameraSize == var_3_0 then
		return
	else
		var_0_0._lastCameraPos = var_0_0._cameraTF.position
		var_0_0._lastCameraSize = var_3_0
	end

	local var_3_1 = pg.CameraFixMgr.GetInstance()
	local var_3_2 = var_0_0._camera:ScreenToWorldPoint(var_3_1.leftBottomVector)
	local var_3_3 = var_0_0._camera:ScreenToWorldPoint(var_3_1.rightTopVector)
	local var_3_4 = var_0_0._uiCamera:ScreenToWorldPoint(var_3_1.leftBottomVector)
	local var_3_5 = var_0_0._uiCamera:ScreenToWorldPoint(var_3_1.rightTopVector)

	var_0_2 = var_3_2.x
	var_0_3 = var_3_4.x
	var_0_4 = (var_3_5.x - var_3_4.x) / (var_3_3.x - var_3_2.x)
	var_0_5 = var_3_2.y * 0.866 + var_3_2.z * 0.5
	var_0_6 = var_3_4.y
	var_0_7 = (var_3_5.y - var_3_4.y) / (var_3_3.y * 0.866 + var_3_3.z * 0.5 - (var_3_2.y * 0.866 + var_3_2.z * 0.5))

	return
end

function ys.Battle.BattleVariable.CameraPosToUICamera(arg_4_0)
	var_0_0.CameraPosToUICameraByRef(arg_4_0)

	return arg_4_0
end

function ys.Battle.BattleVariable.CameraPosToUICameraByRef(arg_5_0)
	arg_5_0.y, arg_5_0.x = (arg_5_0.y * 0.866 + arg_5_0.z * 0.5 - var_0_5) * var_0_7 + var_0_6, (arg_5_0.x - var_0_2) * var_0_4 + var_0_3
	arg_5_0.z = 0

	return
end

function ys.Battle.BattleVariable.UIPosToScenePos(arg_6_0, arg_6_1)
	local var_6_0 = pg.CameraFixMgr.GetInstance()

	arg_6_0 = Vector2(var_6_0:GetCurrentWidth() / 0 * arg_6_0.x, var_6_0:GetCurrentHeight() / 1080 * arg_6_0.y)

	local var_6_1 = var_0_0._uiCamera:ScreenToWorldPoint(arg_6_0)
	local var_6_2 = math.tan(30 * Mathf.Deg2Rad)

	arg_6_1:Set((var_6_1.x - var_0_3) / var_0_4 + var_0_2, 0, ((var_6_1.y - var_0_6) / var_0_7 + var_0_5) / var_6_2 + ((var_6_1.y - var_0_6) / var_0_7 + var_0_5) * var_6_2 * 0.5)

	return
end

function ys.Battle.BattleVariable.AppendMapFactor(arg_7_0, arg_7_1)
	if var_0_0.MapSpeedFacotrList[arg_7_0] ~= nil then
		var_0_0.RemoveMapFactor(arg_7_0)
	end

	var_0_0.MapSpeedRatio = var_0_0.MapSpeedRatio * arg_7_1
	var_0_0.MapSpeedFacotrList[arg_7_0] = arg_7_1

	return
end

function ys.Battle.BattleVariable.RemoveMapFactor(arg_8_0)
	if var_0_0.MapSpeedFacotrList[arg_8_0] ~= nil then
		var_0_0.MapSpeedRatio = var_0_0.MapSpeedRatio / var_0_0.MapSpeedFacotrList[arg_8_0]
		var_0_0.MapSpeedFacotrList[arg_8_0] = nil
	end

	return
end

function ys.Battle.BattleVariable.AppendIFFFactor(arg_9_0, arg_9_1, arg_9_2)
	if var_0_0.IFFFactorList[arg_9_0][arg_9_1] ~= nil then
		var_0_0.RemoveIFFFactor(arg_9_0, arg_9_1)
	end

	var_0_0.speedRatioByIFF[arg_9_0] = var_0_0.speedRatioByIFF[arg_9_0] * arg_9_2
	var_0_0.IFFFactorList[arg_9_0][arg_9_1] = arg_9_2
	var_0_0.focusExemptList = {}

	return
end

function ys.Battle.BattleVariable.RemoveIFFFactor(arg_10_0, arg_10_1)
	if var_0_0.IFFFactorList[arg_10_0][arg_10_1] ~= nil then
		var_0_0.speedRatioByIFF[arg_10_0] = var_0_0.speedRatioByIFF[arg_10_0] / var_0_0.IFFFactorList[arg_10_0][arg_10_1]
		var_0_0.IFFFactorList[arg_10_0][arg_10_1] = nil
		var_0_0.focusExemptList = {}
	end

	return
end

function ys.Battle.BattleVariable.GetSpeedRatio(arg_11_0, arg_11_1)
	return var_0_0.focusExemptList[arg_11_0] or var_0_0.speedRatioByIFF[arg_11_1]
end

function ys.Battle.BattleVariable.AddExempt(arg_12_0, arg_12_1, arg_12_2)
	if var_0_0.IFFFactorList[arg_12_1][arg_12_2] ~= nil then
		var_0_0.focusExemptList[arg_12_0] = var_0_0.speedRatioByIFF[arg_12_1] / var_0_0.IFFFactorList[arg_12_1][arg_12_2]
	end

	return
end

return
