local var_0_0 = class("CarWashPovControlSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

var_0_0.ON_STICK_MOVE_BEGIN = "CarWashPovControlSystem.ON_STICK_MOVE_BEGIN"
var_0_0.ON_STICK_MOVE = "CarWashPovControlSystem.ON_STICK_MOVE"
var_0_0.ON_STICK_MOVE_END = "CarWashPovControlSystem.ON_STICK_MOVE_END"
var_0_0.ON_STICK_VIEW = "CarWashPovControlSystem.ON_STICK_VIEW"
var_0_0.SWITCH_CAMERA = "CarWashPovControlSystem.SWITCH_CAMERA"
var_0_0.MOVE_SPEED = 2
var_0_0.MOVE_STICK_RANGE = 200
var_0_0.VIEW_STICK_RATIO = 0.03
var_0_0.FP_CAMERA = "FP Camera"
var_0_0.INSIDE_CAR_CAMERA = "InsideCarCamera"

function var_0_0.OnInit(arg_1_0)
	arg_1_0:InitSceneRefs()
	arg_1_0:ResetMoveStick()

	return
end

function var_0_0.RegisterEvents(arg_2_0)
	arg_2_0:Bind(var_0_0.ON_STICK_MOVE_BEGIN, function(arg_3_0, arg_3_1)
		arg_2_0:StartMove(arg_3_1)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_STICK_MOVE, function(arg_4_0, arg_4_1)
		arg_2_0:UpdateMoveStick(arg_4_1)

		return
	end)
	arg_2_0:Bind(var_0_0.ON_STICK_MOVE_END, function()
		arg_2_0:ResetMoveStick()

		return
	end)
	arg_2_0:Bind(var_0_0.ON_STICK_VIEW, function(arg_6_0, arg_6_1)
		arg_2_0:UpdateViewStick(arg_6_1)

		return
	end)
	arg_2_0:Bind(var_0_0.SWITCH_CAMERA, function(arg_7_0, arg_7_1)
		arg_2_0:SwitchCameraByName(arg_7_1)

		return
	end)
	arg_2_0:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		if arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			arg_2_0:SwitchCameraByName(var_0_0.FP_CAMERA)
		elseif arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			arg_2_0:SwitchCameraByName(var_0_0.INSIDE_CAR_CAMERA)
		end

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function()
		setActive(arg_2_0.mainCameraTF, false)

		return
	end)
	arg_2_0:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function()
		setActive(arg_2_0.mainCameraTF, true)

		return
	end)

	return
end

function var_0_0.OnUpdate(arg_11_0, arg_11_1)
	arg_11_0:UpdatePlayerMove()

	return
end

function var_0_0.OnDispose(arg_12_0)
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

function var_0_0.InitSceneRefs(arg_13_0)
	arg_13_0.mainCameraTF = arg_13_0:GetMainCameraTF()
	arg_13_0.player = GameObject.Find("Player").transform
	arg_13_0.characterController = arg_13_0.player:GetComponent(typeof(UnityEngine.CharacterController))

	assert(arg_13_0.characterController, "CarWash Player CharacterController not found")
	arg_13_0:InitCameras()

	return
end

function var_0_0.InitCameras(arg_14_0)
	arg_14_0.cameraRoot = arg_14_0:GetCameraRoot()

	assert(arg_14_0.cameraRoot, "CarWash camera root not found")

	arg_14_0.cameras = {}
	arg_14_0.cameraNames = {}

	for iter_14_0 = 0, arg_14_0.cameraRoot.childCount - 1 do
		local var_14_0 = arg_14_0.cameraRoot:GetChild(iter_14_0)

		arg_14_0.cameras[var_14_0.name] = {
			tf = var_14_0,
			virtualCamera = var_14_0:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)),
			freeLook = var_14_0:GetComponent(typeof(Cinemachine.CinemachineFreeLook))
		}

		table.insert(arg_14_0.cameraNames, var_14_0.name)
	end

	return
end

function var_0_0.GetCameraInfo(arg_15_0, arg_15_1)
	if not arg_15_0.cameras then
		return nil
	end

	return arg_15_0.cameras[arg_15_1]
end

function var_0_0.GetCameraNames(arg_16_0)
	return arg_16_0.cameraNames or {}
end

function var_0_0.GetCurrentCameraName(arg_17_0)
	return arg_17_0.currentCameraName
end

function var_0_0.GetCurrentCamera(arg_18_0)
	return arg_18_0.currentCamera
end

function var_0_0.GetCurrentCameraTF(arg_19_0)
	return arg_19_0.currentCameraTF
end

function var_0_0.SwitchCameraByName(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetCameraInfo(arg_20_1)

	assert(var_20_0, "CarWash camera not found: " .. tostring(arg_20_1))

	for iter_20_0, iter_20_1 in pairs(arg_20_0.cameras) do
		setActive(iter_20_1.tf, iter_20_1 == var_20_0)
	end

	arg_20_0.currentCameraName = arg_20_1
	arg_20_0.currentCameraTF = var_20_0.tf
	arg_20_0.currentCamera = var_20_0.virtualCamera or var_20_0.freeLook
	arg_20_0.povCamera = var_20_0.virtualCamera
	arg_20_0.compPovAim = arg_20_0.povCamera and arg_20_0.povCamera:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim) or nil

	return arg_20_0.currentCamera
end

function var_0_0.StartMove(arg_21_0, arg_21_1)
	if not arg_21_1 then
		return
	end

	arg_21_0.moveStickOrigin = arg_21_1.position
	arg_21_0.moveStickPosition = arg_21_0.moveStickOrigin
	arg_21_0.isMoveStickDragging = true

	return
end

function var_0_0.ResetMoveStick(arg_22_0)
	arg_22_0.moveStickOrigin = nil
	arg_22_0.moveStickPosition = nil
	arg_22_0.isMoveStickDragging = false

	return
end

function var_0_0.UpdateMoveStick(arg_23_0, arg_23_1)
	if not arg_23_0.isMoveStickDragging then
		return
	end

	if not arg_23_1 then
		return
	end

	arg_23_0.moveStickPosition = arg_23_0.moveStickPosition + arg_23_1

	return
end

function var_0_0.UpdateViewStick(arg_24_0, arg_24_1)
	if not arg_24_0.compPovAim then
		return
	end

	if not arg_24_1 then
		return
	end

	arg_24_1 = arg_24_1 * (var_0_0.VIEW_STICK_RATIO * 1080 / Screen.height)

	arg_24_0:SetAxisInput("m_HorizontalAxis", arg_24_1.x)
	arg_24_0:SetAxisInput("m_VerticalAxis", arg_24_1.y)

	return
end

function var_0_0.SetAxisInput(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0.compPovAim[arg_25_1].m_InputAxisValue = arg_25_2
	arg_25_0.compPovAim[arg_25_1] = arg_25_0.compPovAim[arg_25_1]

	return
end

function var_0_0.UpdatePlayerMove(arg_26_0)
	if not arg_26_0.isMoveStickDragging then
		return
	end

	local var_26_0 = Vector2.ClampMagnitude(arg_26_0.moveStickPosition - arg_26_0.moveStickOrigin, var_0_0.MOVE_STICK_RANGE)

	arg_26_0.moveStickPosition = arg_26_0.moveStickOrigin + var_26_0

	local var_26_1 = Vector3.New((var_26_0 / var_0_0.MOVE_STICK_RANGE).x, 0, (var_26_0 / var_0_0.MOVE_STICK_RANGE).y)

	if var_26_1:SqrMagnitude() <= 0 then
		return
	end

	local var_26_2 = arg_26_0.mainCameraTF:TransformDirection(var_26_1)

	var_26_2.y = 0

	local var_26_3 = var_26_2:Normalize()

	var_26_3:Mul(var_0_0.MOVE_SPEED)
	arg_26_0.characterController:SimpleMove(var_26_3)

	return
end

return var_0_0
