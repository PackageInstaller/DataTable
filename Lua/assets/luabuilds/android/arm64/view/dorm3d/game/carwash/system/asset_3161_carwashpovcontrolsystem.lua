local CarWashPovControlSystem = class("CarWashPovControlSystem", import("view.dorm3d.Game.CarWash.CarWashBaseSystem"))

CarWashPovControlSystem.ON_STICK_MOVE_BEGIN = "CarWashPovControlSystem.ON_STICK_MOVE_BEGIN"
CarWashPovControlSystem.ON_STICK_MOVE = "CarWashPovControlSystem.ON_STICK_MOVE"
CarWashPovControlSystem.ON_STICK_MOVE_END = "CarWashPovControlSystem.ON_STICK_MOVE_END"
CarWashPovControlSystem.ON_STICK_VIEW = "CarWashPovControlSystem.ON_STICK_VIEW"
CarWashPovControlSystem.SWITCH_CAMERA = "CarWashPovControlSystem.SWITCH_CAMERA"
CarWashPovControlSystem.MOVE_SPEED = 2
CarWashPovControlSystem.MOVE_STICK_RANGE = 200
CarWashPovControlSystem.VIEW_STICK_RATIO = 0.03
CarWashPovControlSystem.FP_CAMERA = "FP Camera"
CarWashPovControlSystem.INSIDE_CAR_CAMERA = "InsideCarCamera"

function CarWashPovControlSystem:OnInit()
	self:InitSceneRefs()
	self:ResetMoveStick()

	return
end

function CarWashPovControlSystem:RegisterEvents()
	self:Bind(CarWashPovControlSystem.ON_STICK_MOVE_BEGIN, function(arg_3_0, arg_3_1)
		self:StartMove(arg_3_1)

		return
	end)
	self:Bind(CarWashPovControlSystem.ON_STICK_MOVE, function(arg_4_0, arg_4_1)
		self:UpdateMoveStick(arg_4_1)

		return
	end)
	self:Bind(CarWashPovControlSystem.ON_STICK_MOVE_END, function()
		self:ResetMoveStick()

		return
	end)
	self:Bind(CarWashPovControlSystem.ON_STICK_VIEW, function(arg_6_0, arg_6_1)
		self:UpdateViewStick(arg_6_1)

		return
	end)
	self:Bind(CarWashPovControlSystem.SWITCH_CAMERA, function(arg_7_0, arg_7_1)
		self:SwitchCameraByName(arg_7_1)

		return
	end)
	self:Bind(CarWashGameFlowSystem.UPDATE_GAME_STATE, function(arg_8_0, arg_8_1)
		if arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_1 then
			self:SwitchCameraByName(CarWashPovControlSystem.FP_CAMERA)
		elseif arg_8_1.newValue == CarWashConst.GAME_STATE.PHASE_2 then
			self:SwitchCameraByName(CarWashPovControlSystem.INSIDE_CAR_CAMERA)
		end

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_BEGIN, function()
		setActive(self.mainCameraTF, false)

		return
	end)
	self:Bind(CarWashTimelineSystem.TIMELINE_SEQUENCE_END, function()
		setActive(self.mainCameraTF, true)

		return
	end)

	return
end

function CarWashPovControlSystem:OnUpdate(arg_11_1)
	self:UpdatePlayerMove()

	return
end

function CarWashPovControlSystem:OnDispose()
	self:ResetMoveStick()

	self.compPovAim = nil
	self.povCamera = nil
	self.currentCamera = nil
	self.currentCameraTF = nil
	self.currentCameraName = nil
	self.cameras = nil
	self.cameraNames = nil
	self.cameraRoot = nil
	self.characterController = nil
	self.player = nil

	return
end

function CarWashPovControlSystem:InitSceneRefs()
	self.mainCameraTF = self:GetMainCameraTF()
	self.player = GameObject.Find("Player").transform
	self.characterController = self.player:GetComponent(typeof(UnityEngine.CharacterController))

	assert(self.characterController, "CarWash Player CharacterController not found")
	self:InitCameras()

	return
end

function CarWashPovControlSystem:InitCameras()
	self.cameraRoot = self:GetCameraRoot()

	assert(self.cameraRoot, "CarWash camera root not found")

	self.cameras = {}
	self.cameraNames = {}

	for iter_14_0 = 0, self.cameraRoot.childCount - 1 do
		local var_14_0 = self.cameraRoot:GetChild(iter_14_0)

		self.cameras[var_14_0.name] = {
			tf = var_14_0,
			virtualCamera = var_14_0:GetComponent(typeof(Cinemachine.CinemachineVirtualCamera)),
			freeLook = var_14_0:GetComponent(typeof(Cinemachine.CinemachineFreeLook))
		}

		table.insert(self.cameraNames, var_14_0.name)
	end

	return
end

function CarWashPovControlSystem:GetCameraInfo(arg_15_1)
	if not self.cameras then
		return nil
	end

	return self.cameras[arg_15_1]
end

function CarWashPovControlSystem:GetCameraNames()
	return self.cameraNames or {}
end

function CarWashPovControlSystem:GetCurrentCameraName()
	return self.currentCameraName
end

function CarWashPovControlSystem:GetCurrentCamera()
	return self.currentCamera
end

function CarWashPovControlSystem:GetCurrentCameraTF()
	return self.currentCameraTF
end

function CarWashPovControlSystem:SwitchCameraByName(arg_20_1)
	local var_20_0 = self:GetCameraInfo(arg_20_1)

	assert(var_20_0, "CarWash camera not found: " .. tostring(arg_20_1))

	for iter_20_0, iter_20_1 in pairs(self.cameras) do
		setActive(iter_20_1.tf, iter_20_1 == var_20_0)
	end

	self.currentCameraName = arg_20_1
	self.currentCameraTF = var_20_0.tf
	self.currentCamera = var_20_0.virtualCamera or var_20_0.freeLook
	self.povCamera = var_20_0.virtualCamera
	self.compPovAim = self.povCamera and self.povCamera:GetCinemachineComponent(Cinemachine.CinemachineCore.Stage.Aim) or nil

	return self.currentCamera
end

function CarWashPovControlSystem:StartMove(arg_21_1)
	if not arg_21_1 then
		return
	end

	self.moveStickOrigin = arg_21_1.position
	self.moveStickPosition = self.moveStickOrigin
	self.isMoveStickDragging = true

	return
end

function CarWashPovControlSystem:ResetMoveStick()
	self.moveStickOrigin = nil
	self.moveStickPosition = nil
	self.isMoveStickDragging = false

	return
end

function CarWashPovControlSystem:UpdateMoveStick(arg_23_1)
	if not self.isMoveStickDragging then
		return
	end

	if not arg_23_1 then
		return
	end

	self.moveStickPosition = self.moveStickPosition + arg_23_1

	return
end

function CarWashPovControlSystem:UpdateViewStick(arg_24_1)
	if not self.compPovAim then
		return
	end

	if not arg_24_1 then
		return
	end

	arg_24_1 = arg_24_1 * (CarWashPovControlSystem.VIEW_STICK_RATIO * 1080 / Screen.height)

	self:SetAxisInput("m_HorizontalAxis", arg_24_1.x)
	self:SetAxisInput("m_VerticalAxis", arg_24_1.y)

	return
end

function CarWashPovControlSystem:SetAxisInput(arg_25_1, arg_25_2)
	self.compPovAim[arg_25_1].m_InputAxisValue = arg_25_2
	self.compPovAim[arg_25_1] = self.compPovAim[arg_25_1]

	return
end

function CarWashPovControlSystem:UpdatePlayerMove()
	if not self.isMoveStickDragging then
		return
	end

	local var_26_0 = Vector2.ClampMagnitude(self.moveStickPosition - self.moveStickOrigin, CarWashPovControlSystem.MOVE_STICK_RANGE)

	self.moveStickPosition = self.moveStickOrigin + var_26_0

	local var_26_1 = Vector3.New((var_26_0 / CarWashPovControlSystem.MOVE_STICK_RANGE).x, 0, (var_26_0 / CarWashPovControlSystem.MOVE_STICK_RANGE).y)

	if var_26_1:SqrMagnitude() <= 0 then
		return
	end

	local var_26_2 = self.mainCameraTF:TransformDirection(var_26_1)

	var_26_2.y = 0

	local var_26_3 = var_26_2:Normalize()

	var_26_3:Mul(CarWashPovControlSystem.MOVE_SPEED)
	self.characterController:SimpleMove(var_26_3)

	return
end

return CarWashPovControlSystem
