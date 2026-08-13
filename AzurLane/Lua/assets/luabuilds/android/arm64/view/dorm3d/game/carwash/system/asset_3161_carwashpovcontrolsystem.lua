class = var_0_10000

local var_0_0 = "CarWashPovControlSystem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_1.ON_STICK_MOVE_BEGIN = "CarWashPovControlSystem.ON_STICK_MOVE_BEGIN"
var_0_1.ON_STICK_MOVE = "CarWashPovControlSystem.ON_STICK_MOVE"
var_0_1.ON_STICK_MOVE_END = "CarWashPovControlSystem.ON_STICK_MOVE_END"
var_0_1.ON_STICK_VIEW = "CarWashPovControlSystem.ON_STICK_VIEW"
var_0_1.SWITCH_CAMERA = "CarWashPovControlSystem.SWITCH_CAMERA"
var_0_1.MOVE_SPEED = 2
var_0_1.MOVE_STICK_RANGE = 200
var_0_1.VIEW_STICK_RATIO = 0.03
var_0_1.FP_CAMERA = "FP Camera"
var_0_1.INSIDE_CAR_CAMERA = "InsideCarCamera"

function var_0_1.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()
	arg_1_0:ResetMoveStick()

	return
end

function var_0_1.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_1.ON_STICK_MOVE_BEGIN, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_2_0

		var_2.StartMove(var_3_0, arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_STICK_MOVE, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.UpdateMoveStick(var_4_0, arg_4_1)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_STICK_MOVE_END, function()
		local var_5_0 = arg_2_0

		var_0.ResetMoveStick(var_5_0)

		return
	end)
	arg_2_0:Bind(var_0_1.ON_STICK_VIEW, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_2_0

		var_2.UpdateViewStick(var_6_0, arg_6_1)

		return
	end)
	arg_2_0:Bind(var_0_1.SWITCH_CAMERA, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_2_0

		var_2.SwitchCameraByName(var_7_0, arg_7_1)

		return
	end)

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.Bind

	CarWashGameFlowSystem = var_4

	var_2_1(var_2_0, var_4.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_8_1.newValue

		CarWashConst = var_2_10003

		if var_8_0 == var_2_10003.GAME_STATE.PHASE_1 then
			local var_8_1 = arg_2_0

			var_2.SwitchCameraByName(var_8_1, var_0_1.FP_CAMERA)
		else
			local var_8_2 = arg_8_1.newValue

			CarWashConst = var_3

			if var_8_2 == var_3.GAME_STATE.PHASE_2 then
				local var_8_3 = arg_2_0

				var_2.SwitchCameraByName(var_8_3, var_0_1.INSIDE_CAR_CAMERA)
			end
		end

		return
	end)

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_3(var_2_2, var_4.TIMELINE_SEQUENCE_BEGIN, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.mainCameraTF, false)

		return
	end)

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.Bind

	CarWashTimelineSystem = var_4

	var_2_5(var_2_4, var_4.TIMELINE_SEQUENCE_END, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.mainCameraTF, true)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_11_0, arg_11_1)
	arg_11_0:UpdatePlayerMove()

	return
end

function var_0_1.OnDispose(arg_12_0)
	arg_12_0:ResetMoveStick()

	arg_12_0.compPovAim = nil
	arg_12_0.povCamera = nil
	arg_12_0.currentCamera = nil
	arg_12_0.currentCameraTF = nil
	arg_12_0.currentCameraName = nil
	arg_12_0.cameras = nil
	arg_12_0.cameraNames = nil
	arg_12_0.cameraRoot = nil
	arg_12_0.characterController = nil
	arg_12_0.player = nil

	return
end

function var_0_1.InitSceneRefs(arg_13_0)
	arg_13_0.mainCameraTF = arg_13_0:GetMainCameraTF()
	GameObject = var_1
	arg_13_0.player = var_1.Find("Player").transform

	local var_13_0 = arg_13_0.player
	local var_13_1 = var_1.GetComponent

	typeof = var_1_10004
	UnityEngine = var_1_10006
	arg_13_0.characterController = var_13_1(var_13_0, var_1_10004(var_1_10006.CharacterController))
	assert = var_1

	var_1(arg_13_0.characterController, "CarWash Player CharacterController not found")
	arg_13_0:InitCameras()

	return
end

function var_0_1.InitCameras(arg_14_0)
	arg_14_0.cameraRoot = arg_14_0:GetCameraRoot()
	assert = var_1

	var_1(arg_14_0.cameraRoot, "CarWash camera root not found")

	arg_14_0.cameras = {}
	arg_14_0.cameraNames = {}

	for iter_14_0 = 0, arg_14_0.cameraRoot.childCount - 1 do
		local var_14_0 = arg_14_0.cameraRoot
		local var_14_1 = var_5.GetChild(var_14_0, iter_14_0)
		local var_14_2 = arg_14_0.cameras
		local var_14_3 = var_14_1.name
		local var_14_4 = {
			tf = var_14_1
		}
		local var_14_5 = var_14_1
		local var_14_6 = var_14_1.GetComponent

		typeof = var_1_10012
		Cinemachine = var_1_10014
		var_14_4.virtualCamera = var_14_6(var_14_5, var_1_10012(var_1_10014.CinemachineVirtualCamera))

		local var_14_7 = var_14_1
		local var_14_8 = var_14_1.GetComponent

		typeof = var_1_10012
		Cinemachine = var_1_10014
		var_14_4.freeLook = var_14_8(var_14_7, var_1_10012(var_1_10014.CinemachineFreeLook))
		var_14_2[var_14_3] = var_14_4
		table = var_14_2

		var_14_2.insert(arg_14_0.cameraNames, var_14_1.name)
	end

	return
end

function var_0_1.GetCameraInfo(arg_15_0, arg_15_1)
	if not arg_15_0.cameras then
		return nil
	end

	return arg_15_0.cameras[arg_15_1]
end

function var_0_1.GetCameraNames(arg_16_0)
	local var_16_0

	if not arg_16_0.cameraNames then
		var_16_0 = {}
	end

	return var_16_0
end

function var_0_1.GetCurrentCameraName(arg_17_0)
	return arg_17_0.currentCameraName
end

function var_0_1.GetCurrentCamera(arg_18_0)
	return arg_18_0.currentCamera
end

function var_0_1.GetCurrentCameraTF(arg_19_0)
	return arg_19_0.currentCameraTF
end

function var_0_1.SwitchCameraByName(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetCameraInfo(arg_20_1)

	assert = var_1_10003

	local var_20_1 = var_20_0
	local var_20_2 = "CarWash camera not found: "

	tostring = var_1_10007

	var_1_10003(var_20_1, var_20_2 .. var_1_10007(arg_20_1))

	pairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0.cameras) do
		setActive = var_1_10008

		var_1_10008(iter_20_1.tf, iter_20_1 == var_20_0)
	end

	arg_20_0.currentCameraName = arg_20_1
	arg_20_0.currentCameraTF = var_20_0.tf

	local var_20_3

	if not var_20_0.virtualCamera then
		var_20_3 = var_20_0.freeLook
	end

	arg_20_0.currentCamera = var_20_3
	arg_20_0.povCamera = var_20_0.virtualCamera

	if arg_20_0.povCamera then
		local var_20_4 = arg_20_0.povCamera
		local var_20_5 = var_3.GetCinemachineComponent

		Cinemachine = iter_20_0

		local var_20_6

		if not var_20_5(var_20_4, iter_20_0.CinemachineCore.Stage.Aim) then
			var_20_6 = nil
		end

		arg_20_0.compPovAim = var_20_6

		return arg_20_0.currentCamera
	end
end

function var_0_1.StartMove(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	arg_21_0.moveStickOrigin = arg_21_1.position
	arg_21_0.moveStickPosition = arg_21_0.moveStickOrigin
	arg_21_0.isMoveStickDragging = true

	return
end

function var_0_1.ResetMoveStick(arg_22_0)
	arg_22_0.moveStickOrigin = nil
	arg_22_0.moveStickPosition = nil
	arg_22_0.isMoveStickDragging = false

	return
end

function var_0_1.UpdateMoveStick(arg_23_0, arg_23_1)
	if not arg_23_0.isMoveStickDragging then
		return
	end

	if not arg_23_1 then
		return
	end

	arg_23_0.moveStickPosition = arg_23_0.moveStickPosition + arg_23_1

	return
end

function var_0_1.UpdateViewStick(arg_24_0, arg_24_1)
	if not arg_24_0.compPovAim then
		return
	end

	if not arg_24_1 then
		return
	end

	local var_24_0 = var_0_1.VIEW_STICK_RATIO * 1080

	Screen = var_1_10003
	arg_24_1 = arg_24_1 * (var_24_0 / var_1_10003.height)

	arg_24_0:SetAxisInput("m_HorizontalAxis", arg_24_1.x)
	arg_24_0:SetAxisInput("m_VerticalAxis", arg_24_1.y)

	return
end

function var_0_1.SetAxisInput(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.compPovAim[arg_25_1]

	var_25_0.m_InputAxisValue = arg_25_2
	arg_25_0.compPovAim[arg_25_1] = var_25_0

	return
end

function var_0_1.UpdatePlayerMove(arg_26_0)
	if not arg_26_0.isMoveStickDragging then
		return
	end

	Vector2 = var_1

	local var_26_0 = var_1.ClampMagnitude(arg_26_0.moveStickPosition - arg_26_0.moveStickOrigin, var_0_1.MOVE_STICK_RANGE) / var_0_1.MOVE_STICK_RANGE

	arg_26_0.moveStickPosition = arg_26_0.moveStickOrigin + var_1
	Vector3 = var_3

	local var_26_1 = var_3.New(var_26_0.x, 0, var_26_0.y)

	if var_3.SqrMagnitude(var_26_1) <= 0 then
		return
	end

	local var_26_2 = arg_26_0.mainCameraTF
	local var_26_3 = var_4.TransformDirection(var_26_2, var_3)

	var_26_3.y = 0

	local var_26_4 = var_26_3:Normalize()

	var_4.Mul(var_26_4, var_0_1.MOVE_SPEED)

	local var_26_5 = arg_26_0.characterController

	var_5.SimpleMove(var_26_5, var_4)

	return
end

return var_0_1
