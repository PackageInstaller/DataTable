require = var_0_10000

local var_0_0 = var_0_10000("Framework.toLua.UnityEngine.Vector3")

require = var_1

local var_0_1 = var_1("Framework.toLua.UnityEngine.Vector2")
local var_0_2 = var_0_0.zero

class = var_0_10003

local var_0_3 = "IslandPlayerUnit"

import = var_0_10005

local var_0_4 = var_0_10003(var_0_3, var_0_10005(".IslandNavigableUnit"))
local var_0_5 = 5
local var_0_6 = 150
local var_0_7 = var_0_1(1.8, 1.8)
local var_0_8 = var_0_1(0, 2)

LayerMask = var_8

local var_0_9 = var_8.NameToLayer("IgnoreIslandCharacter")

bit = var_9

local var_0_10 = var_9.bnot

bit = var_0_10010

local var_0_11 = var_0_10(var_0_10010.lshift(1, var_0_9))
local var_0_12 = {
	LoadToolHandle = 2,
	JumpHandle = 1,
	NoMoveAndWork = 3,
	AttackHandle = 4
}

function var_0_4.OnAttach(arg_1_0, arg_1_1)
	var_0_4.super.OnAttach(arg_1_0, arg_1_1)

	getProxy = var_2
	IslandProxy = var_3

	local var_1_0 = var_2(var_3)
	local var_1_1 = var_2.GetIsland(var_1_0)

	arg_1_0.mapId = var_2.GetMapId(var_1_1)
	arg_1_0._tf = arg_1_0._go.transform

	local var_1_2 = arg_1_0._tf
	local var_1_3 = var_2.GetChild(var_1_2, 0)
	local var_1_4 = var_2.GetComponent

	typeof = var_4
	Animator = var_1_10005
	arg_1_0.animator = var_1_4(var_1_3, var_4(var_1_10005))

	local var_1_5 = arg_1_0._go
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	CharacterController = var_1_10005
	arg_1_0.characterController = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0._go
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	CharacterHandleController = var_1_10005
	arg_1_0.characterHandleController = var_1_8(var_1_7, var_4(var_1_10005))
	pg = var_2
	var_0_5 = var_2.island_set.detection_parameters.key_value_varchar[2]
	var_0_6 = var_2[1]
	var_0_8 = var_0_1(0, var_2[3])

	local var_1_9 = arg_1_0.characterHandleController

	var_3.SetDrawParameter(var_1_9, var_0_5, var_0_6, var_2[3])

	local var_1_10 = arg_1_0.characterHandleController

	var_3.AddStateEnterFunc(var_1_10, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0

		var_2.StateEnterHandle(var_2_0, arg_2_0, arg_2_1)

		return
	end)

	local var_1_11 = arg_1_0.characterHandleController

	var_3.AddStateExitFunc(var_1_11, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.StateExitHandle(var_3_0, arg_3_0, arg_3_1)

		return
	end)

	local var_1_12 = arg_1_0.characterHandleController

	var_3.AddStateEnterFixCompleteFunc(var_1_12, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0

		var_2.StateEnterFixHandle(var_4_0, arg_4_0, arg_4_1)

		return
	end)

	local var_1_13 = arg_1_0.characterHandleController

	var_3.AddStateExitFixCompleteFunc(var_1_13, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0

		var_2.StateExitFixHandle(var_5_0, arg_5_0, arg_5_1)

		return
	end)

	arg_1_0.targetSpeed = 0
	arg_1_0.speed = 0
	arg_1_0.gravitySpeed = 0
	Vector3 = var_3
	arg_1_0.jumpVector = var_3.zero
	pg = var_3

	local var_1_14 = var_3.island_set.player_movement_parameters.key_value_varchar

	arg_1_0.degreeSpeed = 720
	arg_1_0.maxSpeed = var_1_14[1]
	arg_1_0.sprintSpeed = var_1_14[2]
	arg_1_0.upSpeedDamping = 3
	arg_1_0.downSpeedDamping = 6
	arg_1_0.jumpHeight = var_1_14[3]
	Vector3 = var_4
	arg_1_0.targetDir = var_4.zero
	Vector3 = var_4
	arg_1_0.velocity = var_4.zero
	Vector3 = var_4
	arg_1_0.extraVelocity = var_4.zero
	arg_1_0.isSitting = false
	arg_1_0.prevStandPosition = nil
	arg_1_0.checkInSet = {}
	arg_1_0.lastCrossCount = 0
	arg_1_0.orginTargetDir = var_0_2

	arg_1_0:InitDress()
	arg_1_0:InitFarmCheckWorldObject()

	arg_1_0.objTfList = {}
	arg_1_0.toolIdMap = {}

	local var_1_15 = arg_1_0:GetView()

	arg_1_0.islandid = var_4.GetIsland(var_1_15).id
	getProxy = var_4
	PlayerProxy = var_1_15

	local var_1_16 = var_4(var_1_15)

	arg_1_0.isSelfIsland = var_4.getRawData(var_1_16).id == arg_1_0.islandid

	return
end

function var_0_4.InitJump(arg_6_0, arg_6_1)
	arg_6_0.jumpCurve = arg_6_1
	arg_6_0.jumpCruveAllTime = arg_6_0.jumpCurve.keys[arg_6_0.jumpCurve.length - 1].time

	return
end

function var_0_4.OnLateUpdate(arg_7_0)
	return
end

function var_0_4.OnUpdate(arg_8_0)
	arg_8_0:RefreshTemp()

	Time = var_1

	local var_8_0 = var_1.deltaTime

	arg_8_0:PositionTween(var_8_0)
	arg_8_0:Rotation(var_8_0)
	arg_8_0:Move(var_8_0)
	arg_8_0:Detectionobject()

	return
end

function var_0_4.RefreshTemp(arg_9_0)
	arg_9_0.ignoreStepdown = false
	IslandConst = var_1
	arg_9_0.gravityAcc = var_1.GRAVITYACC

	if arg_9_0.orginTargetDir.x ~= 0 or arg_9_0.orginTargetDir.z ~= 0 then
		IslandCameraMgr = var_1

		local var_9_0 = var_1.instance._mainCamera.transform
		local var_9_1 = var_1.TransformVector(var_9_0, arg_9_0.orginTargetDir)

		arg_9_0.targetDir = var_0_0(var_9_1.x, 0, var_9_1.z).normalized

		local var_9_2 = arg_9_0.targetDir

		Vector3 = var_3

		if var_9_2 ~= var_3.zero then
			Quaternion = var_9_2
			arg_9_0.targetRotation = var_9_2.LookRotation(arg_9_0.targetDir)
		end
	end

	return
end

function var_0_4.Rotation(arg_10_0, arg_10_1)
	if arg_10_0.targetRotation then
		Quaternion = var_2

		local var_10_0 = var_2.RotateTowards(arg_10_0._tf.rotation, arg_10_0.targetRotation, arg_10_0.degreeSpeed * arg_10_1)

		arg_10_0._tf.rotation = var_10_0
	end

	return
end

function var_0_4.SetTargetRotation(arg_11_0, arg_11_1)
	arg_11_0.targetRotation = arg_11_1

	return
end

function var_0_4.Move(arg_12_0, arg_12_1)
	Mathf = var_1_10002

	if var_1_10002.Approximately(arg_12_0.speed, arg_12_0.targetSpeed) then
		arg_12_0.speed = arg_12_0.targetSpeed
	elseif arg_12_0.targetSpeed > arg_12_0.speed then
		Mathf = var_2
		arg_12_0.speed = var_2.Lerp(arg_12_0.speed, arg_12_0.targetSpeed, arg_12_0.upSpeedDamping * arg_12_1)
	else
		Mathf = var_2
		arg_12_0.speed = var_2.Lerp(arg_12_0.speed, arg_12_0.targetSpeed, arg_12_0.downSpeedDamping * arg_12_1)
	end

	local var_12_0 = arg_12_0.animator
	local var_12_1 = var_2.SetFloat

	IslandConst = var_4

	var_12_1(var_12_0, var_4.SPEED_FLAG_HASH, arg_12_0.speed)

	arg_12_0.velocity = arg_12_0.targetDir * arg_12_0.speed

	local var_12_2 = arg_12_0.gravityAcc * arg_12_1

	arg_12_0.gravitySpeed = arg_12_0.gravitySpeed + var_12_2
	arg_12_0.onGroud = true

	local var_12_3 = 0

	if arg_12_0.gravitySpeed >= 0 then
		local var_12_4, var_12_5 = arg_12_0:CalcGrounded()

		if var_12_4 then
			arg_12_0.gravitySpeed = 0
			var_12_3 = var_12_5
		else
			local var_12_6

			var_1_10006, var_12_6 = arg_12_0:CalcNotFalling()

			if var_1_10006 then
				arg_12_0.gravitySpeed = 0
				var_12_3 = var_12_6
			else
				arg_12_0.onGroud = false
			end
		end
	else
		arg_12_0.onGroud = false
	end

	local var_12_7 = arg_12_0.animator
	local var_12_8 = var_4.SetBool

	IslandConst = var_1_10006

	var_12_8(var_12_7, var_1_10006.GROUD_FLAG, arg_12_0.onGroud)

	Vector3 = var_12_8

	local var_12_9 = 0

	IslandConst = var_6

	local var_12_10 = var_12_8(var_12_9, var_6.GRAVITYDIR.y * var_12_3, 0)

	if arg_12_0.ignoreStepdown then
		var_12_10 = var_0_2
	end

	local var_12_11 = arg_12_0.jumpVector + var_12_10

	Vector3 = var_6

	local var_12_12 = 0

	IslandConst = var_1_10008

	local var_12_13 = var_6(var_12_12, var_1_10008.GRAVITYDIR.y * arg_12_0.gravitySpeed, 0)
	local var_12_14 = arg_12_0.characterController
	local var_12_15 = var_7.Move
	local var_12_16 = arg_12_0.velocity + var_12_13

	Time = var_1_10010

	local var_12_17 = var_12_16 * var_1_10010.deltaTime + var_12_11
	local var_12_18 = arg_12_0.extraVelocity

	Time = var_1_10011

	var_12_15(var_12_14, var_12_17 + var_12_18 * var_1_10011.deltaTime)

	return
end

function var_0_4.PositionTween(arg_13_0, arg_13_1)
	if arg_13_0._positionTweenCom ~= nil then
		arg_13_0._positionTweenCom.elapse = arg_13_0._positionTweenCom.elapse + arg_13_1

		local var_13_0 = arg_13_0.jumpCurve
		local var_13_1 = var_2.Evaluate(var_13_0, arg_13_0._positionTweenCom.elapse) - arg_13_0._positionTweenCom.oldPosition
		local var_13_2 = arg_13_0._positionTweenCom

		var_13_2.oldPosition = var_2
		UnityEngine = var_13_2

		local var_13_3 = var_13_2.Matrix4x4.TRS
		local var_13_4 = arg_13_0._tf.position
		local var_13_5 = arg_13_0._tf.rotation

		Vector3 = var_1_10007

		local var_13_6 = var_13_3(var_13_4, var_13_5, var_1_10007.one)
		local var_13_7 = var_4.MultiplyVector(var_13_6, var_0_0.New(0, var_13_1, 0))

		arg_13_0.gravityAcc = 0
		arg_13_0.ignoreStepdown = true

		local var_13_8 = arg_13_0._positionTweenCom.elapse

		if arg_13_0._positionTweenCom.duration - 0.001 <= var_13_8 then
			arg_13_0._positionTweenCom = nil
			Vector3 = var_6

			local var_13_9 = var_6.Dot

			Vector3 = var_7
			arg_13_0.gravitySpeed = var_13_9(var_7(0, -1, 0), var_13_7) / arg_13_1
			arg_13_0.jumpVector = var_0_2
		else
			arg_13_0.jumpVector = var_13_7
			arg_13_0.gravitySpeed = 0
		end
	end

	return
end

function var_0_4.CalcGrounded(arg_14_0)
	Physics = var_1_10001

	local var_14_0 = var_1_10001.SphereCast
	local var_14_1 = arg_14_0._tf.position + arg_14_0.characterController.center
	local var_14_2 = arg_14_0.characterController.radius

	Vector3 = var_1_10004

	local var_14_3, var_14_4 = var_14_0(var_14_1, var_14_2, var_1_10004.down, nil, 2 * arg_14_0.characterController.skinWidth + (0.5 * arg_14_0.characterController.height - arg_14_0.characterController.radius), var_0_11)

	if var_14_3 then
		local var_14_5 = arg_14_0._tf.position.y + arg_14_0.characterController.skinWidth - var_14_4.point.y

		if var_14_4.collider.isTrigger then
			return true, 0
		end

		return true, var_14_5
	end

	return false
end

function var_0_4.CalcNotFalling(arg_15_0)
	Physics = var_1_10001

	local var_15_0 = var_1_10001.SphereCast
	local var_15_1 = arg_15_0._tf.position + arg_15_0.characterController.center
	local var_15_2 = arg_15_0.characterController.radius

	Vector3 = var_1_10004

	local var_15_3, var_15_4 = var_15_0(var_15_1, var_15_2, var_1_10004.down, nil, 0.3 + 2 * arg_15_0.characterController.skinWidth + (0.5 * arg_15_0.characterController.height - arg_15_0.characterController.radius), var_0_11)

	if var_15_3 then
		local var_15_5 = arg_15_0._tf.position.y + arg_15_0.characterController.skinWidth - var_15_4.point.y

		if var_15_4.collider.isTrigger then
			return false
		end

		return true, var_15_5
	end

	return false
end

function var_0_4.StandOnWorldObject(arg_16_0)
	Physics = var_1_10001

	local var_16_0 = var_1_10001.SphereCast
	local var_16_1 = arg_16_0._tf.position + arg_16_0.characterController.center
	local var_16_2 = arg_16_0.characterController.radius * 1.2

	Vector3 = var_1_10004

	local var_16_3, var_16_4 = var_16_0(var_16_1, var_16_2, var_1_10004.down, nil, 0.3 + 2 * arg_16_0.characterController.skinWidth + (0.5 * arg_16_0.characterController.height - arg_16_0.characterController.radius), var_0_11)

	if var_16_3 then
		if var_16_4.collider.isTrigger then
			return false
		end

		local var_16_5 = var_16_4.collider.gameObject
		local var_16_6 = var_3.GetComponent

		typeof = var_5
		WorldObjectItem = var_6

		if var_16_6(var_16_5, var_5(var_6)) then
			return true
		end
	end

	return false
end

function var_0_4.Sit(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.characterController.enabled = false
	arg_17_0.prevStandPosition = arg_17_0._tf.position
	arg_17_0._tf.position = arg_17_1

	local var_17_0 = arg_17_0._tf
	local var_17_1 = var_3.Find(var_17_0, "all/foot_l_d_mount")

	Quaternion = var_17_0

	local var_17_2 = var_17_0.LookRotation
	local var_17_3 = arg_17_2

	Vector3 = var_1_10006

	local var_17_4 = var_17_2(var_17_3, var_1_10006.New(0, 1, 0))

	arg_17_0._tf.rotation = var_17_4

	local var_17_5 = arg_17_0.animator
	local var_17_6 = var_5.SetBool

	IslandConst = var_7

	var_17_6(var_17_5, var_7.SIT_HASH, true)

	arg_17_0.isSitting = true

	return
end

function var_0_4.MoveHandle(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.cantMove then
		return
	end

	if arg_18_0.isSitting and arg_18_0.prevStandPosition then
		arg_18_0.characterController.enabled = true
		arg_18_0._tf.position = arg_18_0.prevStandPosition

		local var_18_0 = arg_18_0.animator
		local var_18_1 = var_3.SetBool

		IslandConst = var_1_10005

		var_18_1(var_18_0, var_1_10005.SIT_HASH, false)

		arg_18_0.isSitting = false

		return
	end

	if arg_18_0.animator then
		local var_18_2 = arg_18_0.animator
		local var_18_3 = var_3.SetFloat

		IslandConst = var_1_10005

		var_18_3(var_18_2, var_1_10005.INPUT_MAGNITUDE, arg_18_2)
	end

	arg_18_0.orginTargetDir = arg_18_1
	arg_18_0.lastTargetSpeed = arg_18_2 * arg_18_0.maxSpeed

	local var_18_4

	if not arg_18_0.isSprint or not arg_18_0.sprintSpeed then
		var_18_4 = arg_18_0.lastTargetSpeed
	end

	arg_18_0.targetSpeed = var_18_4

	return
end

function var_0_4.StopMoveHandle(arg_19_0)
	arg_19_0.targetSpeed = 0
	arg_19_0.speed = 0

	local var_19_0 = arg_19_0.animator
	local var_19_1 = var_1.SetFloat

	IslandConst = var_1_10003

	var_19_1(var_19_0, var_1_10003.SPEED_FLAG_HASH, 0)

	local var_19_2 = arg_19_0.animator
	local var_19_3 = var_1.SetFloat

	IslandConst = var_3

	var_19_3(var_19_2, var_3.INPUT_MAGNITUDE, 0)

	arg_19_0.orginTargetDir = var_0_2
	arg_19_0.isSprint = false

	return
end

function var_0_4.StopMoveHandleByInput(arg_20_0)
	arg_20_0.targetSpeed = 0

	local var_20_0 = arg_20_0.animator
	local var_20_1 = var_1.SetFloat

	IslandConst = var_1_10003

	var_20_1(var_20_0, var_1_10003.SPEED_FLAG_HASH, 0)

	local var_20_2 = arg_20_0.animator
	local var_20_3 = var_1.SetFloat

	IslandConst = var_3

	var_20_3(var_20_2, var_3.INPUT_MAGNITUDE, 0)

	arg_20_0.orginTargetDir = var_0_2
	arg_20_0.isSprint = false

	return
end

function var_0_4.JumpHandle(arg_21_0)
	if arg_21_0.cantMove then
		return
	end

	if arg_21_0:CheckCanJump() then
		local var_21_0 = arg_21_0.animator
		local var_21_1 = var_1.SetTrigger

		IslandConst = var_1_10003

		var_21_1(var_21_0, var_1_10003.JUMP_FLAG)
	end

	return
end

function var_0_4.WorkHandle(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.cantMove then
		return
	end

	if arg_22_2 then
		arg_22_0.unitData = arg_22_2

		local var_22_0 = arg_22_2.position - arg_22_0:GetCurrentPosition()
		local var_22_1 = var_0_0(var_22_0.x, 0, var_22_0.z).normalized

		Quaternion = var_6
		arg_22_0.targetRotation = var_6.LookRotation(var_22_1)
	end

	local var_22_2 = arg_22_0.animator

	var_3.SetTrigger(var_22_2, arg_22_1)

	return
end

function var_0_4.DeviceStateHandle(arg_23_0, arg_23_1)
	if not arg_23_0.animator then
		return
	end

	local var_23_0 = arg_23_0.view
	local var_23_1 = var_2.GetController(var_23_0)

	if var_2.IsPlayerInTimeline(var_23_1) then
		return
	end

	if arg_23_1 then
		local var_23_2 = arg_23_0.animator
		local var_23_3 = var_2.SetTrigger

		IslandConst = var_1_10004

		var_23_3(var_23_2, var_1_10004.DEVICE_SHOW_FLAG)

		local var_23_4 = arg_23_0.animator
		local var_23_5 = var_2.ResetTrigger

		IslandConst = var_1_10004

		var_23_5(var_23_4, var_1_10004.UN_DEVICE_SHOW_FLAG)
	else
		local var_23_6 = arg_23_0.animator
		local var_23_7 = var_2.SetTrigger

		IslandConst = var_1_10004

		var_23_7(var_23_6, var_1_10004.UN_DEVICE_SHOW_FLAG)
	end

	return
end

function var_0_4.OnPlayerPlayerSprint(arg_24_0)
	if arg_24_0.targetSpeed ~= 0 then
		arg_24_0.isSprint = true
		arg_24_0.lastTargetSpeed = arg_24_0.targetSpeed
		arg_24_0.targetSpeed = arg_24_0.sprintSpeed
		arg_24_0.speed = arg_24_0.targetSpeed
	end

	return
end

function var_0_4.OnStopPlayerSprint(arg_25_0)
	if arg_25_0.isSprint and arg_25_0.targetSpeed ~= 0 then
		arg_25_0.targetSpeed = arg_25_0.lastTargetSpeed
		arg_25_0.speed = arg_25_0.lastTargetSpeed
		arg_25_0.isSprint = false
	end

	return
end

function var_0_4.LoadInteractiveTool(arg_26_0, arg_26_1)
	if arg_26_1 == 0 then
		local var_26_0 = arg_26_0.unitData

		arg_26_0.toolId = var_1_10002.GetToolId(var_26_0)
	else
		arg_26_0.toolId = arg_26_1
	end

	IslandAnimationAttachmentHelper = var_1_10002
	arg_26_0.currentToolId = var_1_10002.ResolveId(arg_26_0.animator, arg_26_0.toolId)
	arg_26_0.toolIdMap[arg_26_1] = arg_26_0.currentToolId
	arg_26_0.toolIdMap[arg_26_0.toolId] = arg_26_0.currentToolId

	local var_26_1

	if arg_26_0.objTfList[arg_26_0.currentToolId] then
		setActive = var_26_1

		var_26_1(var_2, true)

		setParent = var_26_1

		var_26_1(var_2, arg_26_0._tf)

		pg = var_26_1
		var_26_1 = var_26_1.ViewUtils.SetLayer

		local var_26_2 = var_2

		Layer = var_5

		var_26_1(var_26_2, var_5.UIHidden)

		return
	end

	pg = var_26_1

	local var_26_3 = var_26_1.island_animation_attachments[arg_26_0.currentToolId]

	LoadAny = var_4

	local var_26_4 = var_4(var_26_3.model, nil)

	Object = var_5

	local var_26_5 = var_5.Instantiate(var_26_4)
	local var_26_6 = arg_26_0.objTfList

	var_26_6[arg_26_0.currentToolId] = var_26_5.transform
	LoadAny = var_26_6

	local var_26_7 = var_26_3.animator
	local var_26_8

	typeof = var_1_10009
	RuntimeAnimatorController = var_1_10010

	local var_26_9 = var_26_6(var_26_7, var_26_8, var_1_10009(var_1_10010))

	GetOrAddComponent = var_26_7

	local var_26_10 = arg_26_0.objTfList[arg_26_0.currentToolId]

	typeof = var_9
	Animator = var_1_10010
	var_26_7(var_26_10, var_9(var_1_10010)).runtimeAnimatorController = var_26_9
	setParent = var_26_10

	var_26_10(arg_26_0.objTfList[arg_26_0.currentToolId], arg_26_0._tf)

	pg = var_26_10

	local var_26_11 = var_26_10.ViewUtils.SetLayer
	local var_26_12 = arg_26_0.objTfList[arg_26_0.currentToolId]

	Layer = var_10

	var_26_11(var_26_12, var_10.UIHidden)

	return
end

function var_0_4.UnLoadInteractiveTool(arg_27_0, arg_27_1)
	local var_27_0

	if not arg_27_0.toolIdMap[arg_27_1] and not arg_27_0.currentToolId then
		IslandAnimationAttachmentHelper = var_27_0
		var_27_0 = var_27_0.ResolveId(arg_27_0.animator, arg_27_1)
	end

	if arg_27_0.objTfList[var_27_0] then
		setActive = var_3

		var_3(arg_27_0.objTfList[var_27_0], false)
	end

	return
end

function var_0_4.NoMoveHandle(arg_28_0, arg_28_1)
	arg_28_0.cantMove = true

	if arg_28_0.delayMoveTimer then
		local var_28_0 = arg_28_0.delayMoveTimer

		var_2.Stop(var_28_0)

		arg_28_0.delayMoveTimer = nil
	end

	Timer = var_2
	arg_28_0.delayMoveTimer = var_2.New(function()
		arg_28_0.cantMove = false

		return
	end, arg_28_1, 1)

	local var_28_1 = arg_28_0.delayMoveTimer

	var_2.Start(var_28_1)

	return
end

function var_0_4.AttackHandle(arg_30_0, arg_30_1)
	if arg_30_0.delayAttackTimer then
		local var_30_0 = arg_30_0.delayAttackTimer

		var_2.Stop(var_30_0)

		arg_30_0.delayAttackTimer = nil
	end

	Timer = var_2
	arg_30_0.delayAttackTimer = var_2.New(function()
		if arg_30_0.unitData then
			local var_31_0 = arg_30_0
			local var_31_1 = var_0.NotifiyCore

			ISLAND_EVT = var_2_10002

			var_31_1(var_31_0, var_2_10002.Take_Plant_Attact, {
				type = arg_30_0.unitData.unitType,
				id = arg_30_0.unitData.id
			})
		end

		return
	end, arg_30_1, 1)

	local var_30_1 = arg_30_0.delayAttackTimer

	var_2.Start(var_30_1)

	return
end

function var_0_4.StateEnterHandle(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == var_0_12.JumpHandle then
		arg_32_0:OnEnterJumpState()
	elseif arg_32_1 == var_0_12.LoadToolHandle then
		arg_32_0:LoadInteractiveTool(arg_32_2)
	elseif arg_32_1 == var_0_12.NoMoveAndWork then
		arg_32_0:NoMoveHandle(arg_32_2)
	elseif arg_32_1 == var_0_12.AttackHandle then
		arg_32_0:AttackHandle(arg_32_2)
	end

	return
end

function var_0_4.StateEnterFixHandle(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0

	if not arg_33_0.toolIdMap[arg_33_2] then
		var_33_0 = arg_33_0.currentToolId
	end

	if arg_33_1 == var_0_12.LoadToolHandle and var_33_0 and arg_33_0.objTfList[var_33_0] then
		pg = var_4

		local var_33_1 = var_4.ViewUtils.SetLayer
		local var_33_2 = arg_33_0.objTfList[var_33_0]

		Layer = var_1_10006

		var_33_1(var_33_2, var_1_10006.Default)
	end

	return
end

function var_0_4.StateExitFixHandle(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0

	if not arg_34_0.toolIdMap[arg_34_2] then
		var_34_0 = arg_34_0.currentToolId
	end

	if arg_34_1 == var_0_12.LoadToolHandle and var_34_0 and arg_34_0.objTfList[var_34_0] then
		pg = var_4

		local var_34_1 = var_4.ViewUtils.SetLayer
		local var_34_2 = arg_34_0.objTfList[var_34_0]

		Layer = var_1_10006

		var_34_1(var_34_2, var_1_10006.UIHidden)
	end

	return
end

function var_0_4.StateExitHandle(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == var_0_12.LoadToolHandle then
		arg_35_0:UnLoadInteractiveTool(arg_35_2)
	end

	return
end

function var_0_4.OnEnterJumpState(arg_36_0)
	arg_36_0._positionTweenCom = {
		elapse = 0,
		oldPosition = 0,
		duration = arg_36_0.jumpCruveAllTime
	}

	return
end

local var_0_13 = var_0_1(0, 0)

function var_0_4.InitFarmCheckWorldObject(arg_37_0)
	local var_37_0 = arg_37_0

	if not arg_37_0.IsSpecialMap(var_37_0) then
		return
	end

	arg_37_0.detectionList = {}
	ipairs = var_1
	pg = var_37_0

	local var_37_1

	if not var_37_0.island_production_place.get_id_list_by_map_id[arg_37_0.mapId] then
		var_37_1 = {}
	end

	for iter_37_0, iter_37_1 in var_1(var_37_1) do
		ipairs = var_1_10006
		pg = var_1_10007

		if not var_1_10007.island_production_farm.get_id_list_by_place_id[iter_37_1] then
			var_1_10007 = {}
		end

		for iter_37_2, iter_37_3 in var_1_10006(var_1_10007) do
			pg = var_1_10011
			var_1_10011 = var_1_10011.island_production_farm[iter_37_3]
			pg = var_1_10012
			var_1_10012 = var_1_10012.island_world_objects[var_1_10011.objId]
			table = var_13

			var_13.insert(arg_37_0.detectionList, {
				id = var_1_10012.id,
				position = var_1_10012.param.position
			})
		end
	end

	return
end

function var_0_4.IsSpecialMap(arg_38_0)
	return arg_38_0.mapId == 1001 or arg_38_0.mapId == 1005
end

function var_0_4.IsSelf(arg_39_0)
	return
end

function var_0_4.Detectionobject(arg_40_0)
	if not arg_40_0:IsSpecialMap() or not arg_40_0.isSelfIsland then
		return
	end

	local var_40_0 = {}

	local function var_40_1(arg_41_0)
		local var_41_0 = arg_41_0.position[1]
		local var_41_1 = arg_41_0.position[3]
		local var_41_2 = var_0_7.x / 2
		local var_41_3 = arg_40_0._tf.position.x
		local var_41_4 = arg_40_0._tf.position.z
		local var_41_5 = var_0_5

		math = var_2_10007

		local var_41_6 = var_2_10007.max
		local var_41_7 = var_41_0 - var_41_2

		math = var_2_10009

		local var_41_8 = var_41_6(var_41_7, var_2_10009.min(var_41_3, var_41_0 + var_41_2))

		math = var_41_7

		local var_41_9 = var_41_7.max
		local var_41_10 = var_41_1 - var_41_2

		math = var_10

		local var_41_11 = var_41_9(var_41_10, var_10.min(var_41_4, var_41_1 + var_41_2))
		local var_41_12 = var_41_8 - var_41_3
		local var_41_13 = var_41_11 - var_41_4

		return var_41_12 * var_41_12 + var_41_13 * var_41_13 <= var_41_5 * var_41_5
	end

	ipairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(arg_40_0.detectionList) do
		local var_40_2 = arg_40_0.view
		local var_40_3 = var_8.GetUnitModuleWithType

		IslandConst = var_1_10010
		var_1_10010 = var_40_3(var_40_2, var_1_10010.UNIT_LIST_OBJ, iter_40_1.id)

		if var_8.CanCheckByPlayer(var_1_10010) and var_40_1(iter_40_1) then
			table = var_9

			var_9.insert(var_40_0, iter_40_1)
		end
	end

	local function var_40_4(arg_42_0, arg_42_1, arg_42_2)
		return (arg_42_2.x - arg_42_0.x) * (arg_42_1.y - arg_42_0.y) - (arg_42_2.y - arg_42_0.y) * (arg_42_1.x - arg_42_0.x)
	end

	local function var_40_5(arg_43_0, arg_43_1, arg_43_2)
		Mathf = var_2_10003

		if var_2_10003.Min(arg_43_0.x, arg_43_1.x) <= arg_43_2.x then
			local var_43_0 = arg_43_2.x

			Mathf = var_4

			if var_43_0 <= var_4.Max(arg_43_0.x, arg_43_1.x) then
				Mathf = var_43_0

				if var_43_0.Min(arg_43_0.y, arg_43_1.y) <= arg_43_2.y then
					local var_43_1 = arg_43_2.y

					Mathf = var_4

					local var_43_2

					if not (var_43_1 <= var_4.Max(arg_43_0.y, arg_43_1.y)) then
						var_43_2 = false
					else
						var_43_2 = true
					end

					return var_43_2
				end
			end
		end
	end

	local function var_40_6(arg_44_0, arg_44_1)
		local var_44_0 = #arg_44_1

		for iter_44_0 = 0, var_44_0 do
			local var_44_1 = arg_44_1[iter_44_0]
			local var_44_2 = arg_44_1[(iter_44_0 + 1) % var_44_0] - var_44_1
			local var_44_3 = arg_44_0 - var_44_1

			if var_0_1.Dot(var_44_2.normalized, var_44_3) > 0 then
				return false
			end
		end

		return true
	end

	local function var_40_7(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
		local var_45_0 = var_40_4(arg_45_2, arg_45_3, arg_45_0)
		local var_45_1 = var_40_4(arg_45_2, arg_45_3, arg_45_1)
		local var_45_2 = var_40_4(arg_45_0, arg_45_1, arg_45_2)
		local var_45_3 = var_40_4(arg_45_0, arg_45_1, arg_45_3)

		if (var_45_0 > 0 and var_45_1 < 0 or var_45_0 < 0 and var_45_1 > 0) and (var_45_2 > 0 and var_45_3 < 0 or var_45_2 < 0 and var_45_3 > 0) then
			return true
		end

		if var_45_0 == 0 and var_40_5(arg_45_2, arg_45_3, arg_45_0) then
			return true
		end

		if var_45_1 == 0 and var_40_5(arg_45_2, arg_45_3, arg_45_1) then
			return true
		end

		if var_45_2 == 0 and var_40_5(arg_45_0, arg_45_1, arg_45_2) then
			return true
		end

		if var_45_3 == 0 and var_40_5(arg_45_0, arg_45_1, arg_45_3) then
			return true
		end

		return false
	end

	local function var_40_8(arg_46_0, arg_46_1)
		local var_46_0 = {}

		Mathf = var_2_10003

		local var_46_1 = arg_46_1 * var_2_10003.Deg2Rad

		Mathf = var_2_10004

		local var_46_2 = var_2_10004.Cos(var_46_1)

		Mathf = var_5

		local var_46_3 = var_5.Sin(var_46_1)
		local var_46_4 = var_0_7 * 0.5

		var_46_0[0] = arg_46_0 + var_0_1(-var_46_4.x * var_46_2 - var_46_4.y * var_46_3, -var_46_4.x * var_46_3 + var_46_4.y * var_46_2)
		var_46_0[1] = arg_46_0 + var_0_1(var_46_4.x * var_46_2 - var_46_4.y * var_46_3, var_46_4.x * var_46_3 + var_46_4.y * var_46_2)
		var_46_0[2] = arg_46_0 + var_0_1(var_46_4.x * var_46_2 + var_46_4.y * var_46_3, var_46_4.x * var_46_3 - var_46_4.y * var_46_2)
		var_46_0[3] = arg_46_0 + var_0_1(-var_46_4.x * var_46_2 + var_46_4.y * var_46_3, -var_46_4.x * var_46_3 - var_46_4.y * var_46_2)

		return var_46_0
	end

	local function var_40_9(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		local var_47_0 = var_40_8(arg_47_0, arg_47_1)

		for iter_47_0 = 0, 3 do
			local var_47_1 = var_47_0[iter_47_0]
			local var_47_2 = var_47_0[(iter_47_0 + 1) % 4]

			if var_40_7(arg_47_2, arg_47_3, var_47_1, var_47_2) then
				return true
			end
		end

		if var_40_6(arg_47_2, var_47_0) or var_40_6(arg_47_3, var_47_0) then
			return true
		end

		return false
	end

	local function var_40_10(arg_48_0, arg_48_1, arg_48_2)
		local var_48_0 = arg_48_0 - arg_48_2
		local var_48_1 = var_0_1.Dot(var_48_0, arg_48_1)
		local var_48_2 = var_0_1.Dot(var_48_0, var_0_1(-arg_48_1.y, arg_48_1.x))
		local var_48_3 = var_0_1(var_48_1, var_48_2)
		local var_48_4 = var_0_7 * 0.5
		local var_48_5 = var_0_1.Max(var_48_3 - var_0_1.zero, var_0_1.zero - var_48_3)
		local var_48_6 = var_0_1.Max(var_48_5 - var_48_4, var_0_1.zero)
		local var_48_7 = var_0_1.Angle(var_48_6, var_0_1.right)
		local var_48_8 = (180 - var_0_6) / 2
		local var_48_9 = var_40_9
		local var_48_10 = var_48_5
		local var_48_11 = 0
		local var_48_12 = var_0_1.zero
		local var_48_13 = var_0_1
		local var_48_14 = var_0_5

		Mathf = var_2_10018

		local var_48_15 = var_2_10018.Cos

		Mathf = var_2_10019

		local var_48_16 = var_48_14 * var_48_15(15 * var_2_10019.Deg2Rad)
		local var_48_17 = var_0_5

		Mathf = var_19

		local var_48_18 = var_19.Sin

		Mathf = var_2_10020

		local var_48_19 = var_48_9(var_48_10, var_48_11, var_48_12, var_48_13(var_48_16, var_48_17 * var_48_18(15 * var_2_10020.Deg2Rad)))

		return var_48_8 <= var_48_7 or var_48_19
	end

	local function var_40_11(arg_49_0)
		if var_0_0.Dot(var_0_0(arg_49_0.position[1], arg_49_0.position[2], arg_49_0.position[3]) - arg_40_0._tf.position, arg_40_0._tf.forward) < 0 then
			return
		end

		local var_49_0 = var_0_1(arg_49_0.position[1], arg_49_0.position[3])
		local var_49_1 = arg_40_0
		local var_49_2 = var_2.Vector3ToVector2(var_49_1, arg_40_0._tf.position) + var_0_13
		local var_49_3 = var_40_10
		local var_49_4 = var_49_0
		local var_49_5 = arg_40_0

		return var_49_3(var_49_4, var_5.Vector3ToVector2(var_49_5, arg_40_0._tf.right), var_49_2)
	end

	local var_40_12 = {}

	ipairs = var_1_10012

	for iter_40_2, iter_40_3 in var_1_10012(var_40_0) do
		if var_40_11(iter_40_3) then
			table = var_17

			var_17.insert(var_40_12, iter_40_3)
		end
	end

	local var_40_13 = #var_40_12
	local var_40_14 = false

	if var_40_13 ~= 0 then
		local var_40_15

		iter_40_3 = arg_40_0

		local var_40_16 = arg_40_0.Vector3ToVector2(iter_40_3, arg_40_0._tf.position) + var_0_13 + arg_40_0:Vector3ToVector2(arg_40_0._tf.forward) * 2

		var_1_10018 = 10

		local var_40_17 = {}

		ipairs = var_1_10020

		for iter_40_4, iter_40_5 in var_1_10020(var_40_12) do
			local var_40_18 = var_0_1(iter_40_5.position[1], iter_40_5.position[3]) - var_40_16

			if var_26.Magnitude(var_40_18) < var_1_10018 then
				var_1_10018 = var_26
				var_40_15 = iter_40_5
			end
		end

		if var_40_15 then
			local var_40_19 = var_40_15.id

			itemId = itemId

			if var_20 ~= arg_40_0.nearId then
				itemId = var_20
				arg_40_0.nearId = var_20
				arg_40_0.nearItem = var_40_15
				var_40_14 = true
			end
		end
	end

	if var_40_13 ~= arg_40_0.lastCrossCount or var_40_14 then
		arg_40_0.lastCrossCount = var_40_13

		if var_40_13 == 0 then
			local var_40_20 = arg_40_0
			local var_40_21 = arg_40_0.NotifiyCore

			ISLAND_EVT = iter_40_3
			iter_40_3 = iter_40_3.HIDE_UNIT_HUD_OP

			local var_40_22 = {
				isHighLightControl = true
			}

			tonumber = var_1_10018
			var_40_22.id = var_1_10018(arg_40_0.nearId)
			IslandConst = var_1_10018
			var_40_22.type = var_1_10018.UNIT_LIST_OBJ

			var_40_21(var_40_20, iter_40_3, var_40_22)

			arg_40_0.nearId = 0
		else
			local var_40_23 = arg_40_0
			local var_40_24 = arg_40_0.NotifiyCore

			ISLAND_EVT = iter_40_3

			local var_40_25 = iter_40_3.SHOW_UNIT_HUD_OP
			local var_40_26 = {
				isHighLightControl = true
			}

			tonumber = var_1_10018
			var_40_26.id = var_1_10018(arg_40_0.nearId)
			IslandOpView = var_18
			var_40_26.operationType = var_18.OperationType.Plant
			IslandConst = var_18
			var_40_26.type = var_18.UNIT_LIST_OBJ

			var_40_24(var_40_23, var_40_25, var_40_26)
		end
	end

	return
end

function var_0_4.Vector3ToVector2(arg_50_0, arg_50_1)
	return var_0_1(arg_50_1.x, arg_50_1.z)
end

function var_0_4.GetNearItemId(arg_51_0)
	return arg_51_0.nearId
end

function var_0_4.OnGrouded(arg_52_0)
	return arg_52_0.onGroud
end

function var_0_4.GetCurrentPosition(arg_53_0)
	return arg_53_0._tf.position
end

function var_0_4.LastGroundedPosition(arg_54_0)
	local var_54_0 = arg_54_0._tf.eulerAngles

	if not arg_54_0.onGroud then
		Physics = var_2

		local var_54_1 = var_2.Raycast
		local var_54_2 = arg_54_0._tf.position

		Vector3 = var_1_10004

		local var_54_3 = var_1_10004.down
		local var_54_4

		math = var_1_10006

		local var_54_5, var_54_6 = var_54_1(var_54_2, var_54_3, var_54_4, var_1_10006.huge, var_0_11)

		if var_54_5 then
			return var_54_6.point, var_54_0
		end
	end

	return arg_54_0._tf.position, var_54_0
end

function var_0_4.CheckCanJump(arg_55_0)
	if arg_55_0.onGroud then
		return true
	end

	if arg_55_0.jumpVector.y > 0 then
		return false
	end

	Physics = var_1

	local var_55_0 = var_1.Raycast
	local var_55_1 = arg_55_0._tf.position + arg_55_0.characterController.center

	Vector3 = var_3

	local var_55_2, var_55_3 = var_55_0(var_55_1, var_3.down, nil, 2, var_0_11)

	if var_55_2 then
		return true
	end

	return false
end

function var_0_4.OnDetach(arg_56_0)
	if arg_56_0.delayMoveTimer then
		local var_56_0 = arg_56_0.delayMoveTimer

		var_1.Stop(var_56_0)

		arg_56_0.delayMoveTimer = nil
	end

	if arg_56_0.delayAttackTimer then
		local var_56_1 = arg_56_0.delayAttackTimer

		var_1.Stop(var_56_1)

		arg_56_0.delayAttackTimer = nil
	end

	arg_56_0:ClearAnimationTools()

	local var_56_2 = arg_56_0.shipDressHelper

	var_1.Destroy(var_56_2)

	local var_56_3 = arg_56_0.characterHandleController

	var_1.AddStateEnterFunc(var_56_3, nil)

	local var_56_4 = arg_56_0.characterHandleController

	var_1.AddStateExitFunc(var_56_4, nil)

	return
end

function var_0_4.ClearAnimationTools(arg_57_0)
	pairs = var_1_10001

	for iter_57_0, iter_57_1 in var_1_10001(arg_57_0.objTfList) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_57_1.gameObject)
	end

	arg_57_0.objTfList = {}

	return
end

function var_0_4.SetActiveByLayer(arg_58_0, arg_58_1)
	if arg_58_1 then
		pg = var_1_10002
		var_1_10002 = var_1_10002.ViewUtils.SetLayer

		local var_58_0 = arg_58_0._tf

		Layer = var_1_10004

		var_1_10002(var_58_0, var_1_10004.Default)
	else
		pg = var_1_10002

		local var_58_1 = var_1_10002.ViewUtils.SetLayer
		local var_58_2 = arg_58_0._tf

		Layer = var_1_10004

		var_58_1(var_58_2, var_1_10004.UIHidden)
	end

	return
end

function var_0_4.SetShipDressHelper(arg_59_0, arg_59_1)
	arg_59_0.shipDressHelper = arg_59_1

	return
end

function var_0_4.OnChangeDress(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = {}

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_60_1 = var_1_10004(var_1_10005)
	local var_60_2 = var_4.GetIsland(var_60_1)
	local var_60_3 = var_4.GetDressUpAgency(var_60_2)

	local function var_60_4(arg_61_0)
		ipairs = var_2_10001

		for iter_61_0, iter_61_1 in var_2_10001(arg_60_2) do
			if arg_61_0 == iter_61_1.id then
				return iter_61_1.color, true
			end
		end

		local var_61_0 = var_60_3

		return var_1.GetCurrentColorByDressId(var_61_0, arg_61_0), false
	end

	ipairs = var_1_10007

	for iter_60_0, iter_60_1 in var_1_10007(arg_60_1) do
		local var_60_5, var_60_6 = var_60_4(iter_60_1.id)

		if var_60_6 then
			var_60_0[iter_60_1.id] = true
		end

		local var_60_7 = arg_60_0.shipDressHelper

		var_14.ChangeDressByType(var_60_7, iter_60_1.type, {
			id = iter_60_1.id,
			colorId = var_60_5
		})
	end

	ipairs = var_7

	for iter_60_2, iter_60_3 in var_7(arg_60_2) do
		if not var_60_0[iter_60_3.id] then
			pg = var_13

			local var_60_8 = var_13.island_dress_template[var_12].type
			local var_60_9 = arg_60_0.shipDressHelper

			var_14.ChangeCommanderPartColor(var_60_9, var_60_8, iter_60_3.color)
		end
	end

	return
end

function var_0_4.InitDress(arg_62_0)
	return
end

return var_0_4
