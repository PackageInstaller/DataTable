require = var_0_10000

local var_0_0 = var_0_10000("Framework.toLua.UnityEngine.Vector3")

require = var_0_10001

local var_0_1 = var_0_10001("Framework.toLua.UnityEngine.Vector2")
local var_0_2 = var_0_0.zero

class = var_3

local var_0_3 = "IslandThirdTakePhotoUnit"

import = var_0_10006

local var_0_4 = var_3(var_0_3, var_0_10006(".IslandSceneUnit"))

LayerMask = var_0_10004

local var_0_5 = var_0_10004.NameToLayer("IgnoreIslandCharacter")

bit = var_0_3

local var_0_6 = var_0_3.bnot

bit = var_0_10007

local var_0_7 = var_0_6(var_0_10007.lshift(1, var_0_5))

function var_0_4.OnAttach(arg_1_0, arg_1_1)
	var_0_4.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0._tf = arg_1_0._go.transform

	local var_1_0 = arg_1_0._go
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	CharacterController = var_1_10007
	arg_1_0.characterController = var_1_1(var_1_0, var_5(var_1_10007))
	arg_1_0.targetSpeed = 0
	arg_1_0.speed = 0
	pg = var_2

	local var_1_2 = var_2.island_set.player_movement_parameters.key_value_varchar

	arg_1_0.degreeSpeed = 720
	arg_1_0.maxSpeed = var_1_2[1]
	arg_1_0.sprintSpeed = var_1_2[2]
	arg_1_0.upSpeedDamping = 3
	arg_1_0.downSpeedDamping = 6
	arg_1_0.jumpHeight = var_1_2[3]
	Vector3 = var_3
	arg_1_0.targetDir = var_3.zero
	Vector3 = var_3
	arg_1_0.velocity = var_3.zero
	Vector3 = var_3
	arg_1_0.extraVelocity = var_3.zero
	arg_1_0.gravitySpeed = 0
	arg_1_0.orginTargetDir = var_0_2
	setActive = var_3

	var_3(arg_1_0._go, false)
	arg_1_0:ActiveOrDisactive(false)

	return
end

function var_0_4.OnLateUpdate(arg_2_0)
	return
end

function var_0_4.OnUpdate(arg_3_0)
	arg_3_0:RefreshTemp()

	Time = var_1

	local var_3_0 = var_1.deltaTime

	arg_3_0:Rotation(var_3_0)
	arg_3_0:Move(var_3_0)

	return
end

function var_0_4.RefreshTemp(arg_4_0)
	arg_4_0.ignoreStepdown = false
	IslandConst = var_1
	arg_4_0.gravityAcc = var_1.GRAVITYACC

	if arg_4_0.orginTargetDir.x ~= 0 or arg_4_0.orginTargetDir.z ~= 0 then
		IslandCameraMgr = var_1

		local var_4_0 = var_1.instance._mainCamera.transform
		local var_4_1 = var_1.TransformVector(var_4_0, arg_4_0.orginTargetDir)

		arg_4_0.targetDir = var_0_0(var_4_1.x, 0, var_4_1.z).normalized
		Quaternion = var_2
		arg_4_0.targetRotation = var_2.LookRotation(arg_4_0.targetDir)
	end

	return
end

function var_0_4.Rotation(arg_5_0, arg_5_1)
	if arg_5_0.targetRotation then
		Quaternion = var_2

		local var_5_0 = var_2.RotateTowards(arg_5_0._tf.rotation, arg_5_0.targetRotation, arg_5_0.degreeSpeed * arg_5_1)

		arg_5_0._tf.rotation = var_5_0
	end

	return
end

function var_0_4.SetTargetRotation(arg_6_0, arg_6_1)
	arg_6_0.targetRotation = arg_6_1

	return
end

function var_0_4.Move(arg_7_0, arg_7_1)
	Mathf = var_1_10002

	if var_1_10002.Approximately(arg_7_0.speed, arg_7_0.targetSpeed) then
		arg_7_0.speed = arg_7_0.targetSpeed
	elseif arg_7_0.targetSpeed > arg_7_0.speed then
		Mathf = var_2
		arg_7_0.speed = var_2.Lerp(arg_7_0.speed, arg_7_0.targetSpeed, arg_7_0.upSpeedDamping * arg_7_1)
	else
		Mathf = var_2
		arg_7_0.speed = var_2.Lerp(arg_7_0.speed, arg_7_0.targetSpeed, arg_7_0.downSpeedDamping * arg_7_1)
	end

	arg_7_0.velocity = arg_7_0.targetDir * arg_7_0.speed
	arg_7_0.onGroud = true

	local var_7_0 = 0
	local var_7_1

	if arg_7_0.gravitySpeed >= 0 then
		local var_7_2

		var_7_1, var_7_2 = arg_7_0:CalcGrounded()

		if var_7_1 then
			arg_7_0.gravitySpeed = 0
			var_7_0 = var_7_2
		else
			local var_7_3

			var_7_3, var_1_10006 = arg_7_0:CalcNotFalling()

			if var_7_3 then
				arg_7_0.gravitySpeed = 0
				var_7_0 = var_1_10006
			else
				arg_7_0.onGroud = false
			end
		end
	else
		arg_7_0.onGroud = false
	end

	Vector3 = var_7_1

	local var_7_4 = 0

	IslandConst = var_1_10006

	local var_7_5 = var_7_1(var_7_4, var_1_10006.GRAVITYDIR.y * var_7_0, 0)

	if arg_7_0.ignoreStepdown then
		var_7_5 = var_0_2
	end

	local var_7_6 = var_7_5
	local var_7_7 = arg_7_0.characterController
	local var_7_8 = var_5.Move
	local var_7_9 = arg_7_0.velocity

	Time = var_1_10009

	var_7_8(var_7_7, var_7_9 * var_1_10009.deltaTime + var_7_6)

	return
end

function var_0_4.CalcGrounded(arg_8_0)
	Physics = var_1_10001

	local var_8_0 = var_1_10001.SphereCast
	local var_8_1 = arg_8_0._tf.position + arg_8_0.characterController.center
	local var_8_2 = arg_8_0.characterController.radius

	Vector3 = var_1_10005

	local var_8_3, var_8_4 = var_8_0(var_8_1, var_8_2, var_1_10005.down, nil, 2 * arg_8_0.characterController.skinWidth + (0.5 * arg_8_0.characterController.height - arg_8_0.characterController.radius), var_0_7)

	if var_8_3 then
		local var_8_5 = arg_8_0._tf.position.y + arg_8_0.characterController.skinWidth - var_8_4.point.y

		return true, var_8_5
	end

	return false
end

function var_0_4.CalcNotFalling(arg_9_0)
	Physics = var_1_10001

	local var_9_0 = var_1_10001.SphereCast
	local var_9_1 = arg_9_0._tf.position + arg_9_0.characterController.center
	local var_9_2 = arg_9_0.characterController.radius

	Vector3 = var_1_10005

	local var_9_3, var_9_4 = var_9_0(var_9_1, var_9_2, var_1_10005.down, nil, 0.3 + 2 * arg_9_0.characterController.skinWidth + (0.5 * arg_9_0.characterController.height - arg_9_0.characterController.radius), var_0_7)

	if var_9_3 then
		local var_9_5 = arg_9_0._tf.position.y + arg_9_0.characterController.skinWidth - var_9_4.point.y

		return true, var_9_5
	end

	return false
end

function var_0_4.OnPlayerPlayerSprint(arg_10_0)
	if arg_10_0.targetSpeed ~= 0 then
		arg_10_0.isSprint = true
		arg_10_0.lastTargetSpeed = arg_10_0.targetSpeed
		arg_10_0.targetSpeed = arg_10_0.sprintSpeed
		arg_10_0.speed = arg_10_0.targetSpeed
	end

	return
end

function var_0_4.ChangeHeight(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.characterController

	Vector3 = var_1_10003
	var_11_0.center = var_1_10003(0, arg_11_1, 0)

	return
end

function var_0_4.OnStopPlayerSprint(arg_12_0)
	if arg_12_0.isSprint and arg_12_0.targetSpeed ~= 0 then
		arg_12_0.targetSpeed = arg_12_0.lastTargetSpeed
		arg_12_0.speed = arg_12_0.lastTargetSpeed
		arg_12_0.isSprint = false
	end

	return
end

function var_0_4.MoveHandle(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.orginTargetDir = arg_13_1
	arg_13_0.lastTargetSpeed = arg_13_2 * arg_13_0.maxSpeed

	local var_13_0

	if not arg_13_0.isSprint or not arg_13_0.sprintSpeed then
		var_13_0 = arg_13_0.lastTargetSpeed
	end

	arg_13_0.targetSpeed = var_13_0

	return
end

function var_0_4.StopMoveHandle(arg_14_0)
	arg_14_0.targetSpeed = 0
	arg_14_0.speed = 0
	arg_14_0.orginTargetDir = var_0_2
	arg_14_0.isSprint = false

	return
end

return var_0_4
