local var_0_0 = require("Framework.toLua.UnityEngine.Vector2")
local var_0_1 = require("Framework.toLua.UnityEngine.Vector3").zero
local var_0_2 = class("IslandThirdTakePhotoUnit", import(".IslandSceneUnit"))
local var_0_3 = bit.bnot(bit.lshift(1, (LayerMask.NameToLayer("IgnoreIslandCharacter"))))

function var_0_2.OnAttach(arg_1_0, arg_1_1)
	var_0_2.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0.characterController = arg_1_0._go:GetComponent(typeof(CharacterController))
	arg_1_0.targetSpeed = 0
	arg_1_0.speed = 0
	arg_1_0.degreeSpeed = 720
	arg_1_0.maxSpeed = pg.island_set.player_movement_parameters.key_value_varchar[1]
	arg_1_0.sprintSpeed = pg.island_set.player_movement_parameters.key_value_varchar[2]
	arg_1_0.upSpeedDamping = 3
	arg_1_0.downSpeedDamping = 6
	arg_1_0.jumpHeight = pg.island_set.player_movement_parameters.key_value_varchar[3]
	arg_1_0.targetDir = Vector3.zero
	arg_1_0.velocity = Vector3.zero
	arg_1_0.extraVelocity = Vector3.zero
	arg_1_0.gravitySpeed = 0
	arg_1_0.orginTargetDir = var_0_1

	setActive(arg_1_0._go, false)
	arg_1_0:ActiveOrDisactive(false)

	return
end

function var_0_2.OnLateUpdate(arg_2_0)
	return
end

function var_0_2.OnUpdate(arg_3_0)
	arg_3_0:RefreshTemp()
	arg_3_0:Rotation(Time.deltaTime)
	arg_3_0:Move(Time.deltaTime)

	return
end

function var_0_2.RefreshTemp(arg_4_0)
	arg_4_0.ignoreStepdown = false
	arg_4_0.gravityAcc = IslandConst.GRAVITYACC

	if arg_4_0.orginTargetDir.x ~= 0 or arg_4_0.orginTargetDir.z ~= 0 then
		local var_4_0 = IslandCameraMgr.instance._mainCamera.transform:TransformVector(arg_4_0.orginTargetDir)

		arg_4_0.targetDir = var_0(var_4_0.x, 0, var_4_0.z).normalized
		arg_4_0.targetRotation = Quaternion.LookRotation(arg_4_0.targetDir)
	end

	return
end

function var_0_2.Rotation(arg_5_0, arg_5_1)
	if arg_5_0.targetRotation then
		arg_5_0._tf.rotation = Quaternion.RotateTowards(arg_5_0._tf.rotation, arg_5_0.targetRotation, arg_5_0.degreeSpeed * arg_5_1)
	end

	return
end

function var_0_2.SetTargetRotation(arg_6_0, arg_6_1)
	arg_6_0.targetRotation = arg_6_1

	return
end

function var_0_2.Move(arg_7_0, arg_7_1)
	arg_7_0.speed = Mathf.Approximately(arg_7_0.speed, arg_7_0.targetSpeed) and arg_7_0.targetSpeed or arg_7_0.targetSpeed > arg_7_0.speed and Mathf.Lerp(arg_7_0.speed, arg_7_0.targetSpeed, arg_7_0.upSpeedDamping * arg_7_1) or Mathf.Lerp(arg_7_0.speed, arg_7_0.targetSpeed, arg_7_0.downSpeedDamping * arg_7_1)
	arg_7_0.velocity = arg_7_0.targetDir * arg_7_0.speed
	arg_7_0.onGroud = true

	local var_7_0 = 0

	if arg_7_0.gravitySpeed >= 0 then
		local var_7_1, var_7_2 = arg_7_0:CalcGrounded()

		if var_7_1 then
			arg_7_0.gravitySpeed = 0
			var_7_0 = var_7_2
		else
			local var_7_3, var_7_4 = arg_7_0:CalcNotFalling()

			if var_7_3 then
				arg_7_0.gravitySpeed = 0
				var_7_0 = var_7_4
			else
				arg_7_0.onGroud = false
			end
		end
	else
		arg_7_0.onGroud = false
	end

	local var_7_5 = Vector3(0, IslandConst.GRAVITYDIR.y * var_7_0, 0)

	if arg_7_0.ignoreStepdown then
		var_7_5 = var_0_1
	end

	arg_7_0.characterController:Move(arg_7_0.velocity * Time.deltaTime + var_7_5)

	return
end

function var_0_2.CalcGrounded(arg_8_0)
	local var_8_0, var_8_1 = Physics.SphereCast(arg_8_0._tf.position + arg_8_0.characterController.center, arg_8_0.characterController.radius, Vector3.down, nil, 2 * arg_8_0.characterController.skinWidth + (0.5 * arg_8_0.characterController.height - arg_8_0.characterController.radius), var_0_3)

	if var_8_0 then
		return true, arg_8_0._tf.position.y + arg_8_0.characterController.skinWidth - var_8_1.point.y
	end

	return false
end

function var_0_2.CalcNotFalling(arg_9_0)
	local var_9_0, var_9_1 = Physics.SphereCast(arg_9_0._tf.position + arg_9_0.characterController.center, arg_9_0.characterController.radius, Vector3.down, nil, 0.3 + 2 * arg_9_0.characterController.skinWidth + (0.5 * arg_9_0.characterController.height - arg_9_0.characterController.radius), var_0_3)

	if var_9_0 then
		return true, arg_9_0._tf.position.y + arg_9_0.characterController.skinWidth - var_9_1.point.y
	end

	return false
end

function var_0_2.OnPlayerPlayerSprint(arg_10_0)
	if arg_10_0.targetSpeed ~= 0 then
		arg_10_0.isSprint = true
		arg_10_0.lastTargetSpeed = arg_10_0.targetSpeed
		arg_10_0.targetSpeed = arg_10_0.sprintSpeed
		arg_10_0.speed = arg_10_0.targetSpeed
	end

	return
end

function var_0_2.ChangeHeight(arg_11_0, arg_11_1)
	arg_11_0.characterController.center = Vector3(0, arg_11_1, 0)

	return
end

function var_0_2.OnStopPlayerSprint(arg_12_0)
	if arg_12_0.isSprint and arg_12_0.targetSpeed ~= 0 then
		arg_12_0.targetSpeed = arg_12_0.lastTargetSpeed
		arg_12_0.speed = arg_12_0.lastTargetSpeed
		arg_12_0.isSprint = false
	end

	return
end

function var_0_2.MoveHandle(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0.orginTargetDir = arg_13_1
	arg_13_0.lastTargetSpeed = arg_13_2 * arg_13_0.maxSpeed

	if arg_13_0.isSprint then
		arg_13_0.targetSpeed = arg_13_0.sprintSpeed or arg_13_0.lastTargetSpeed

		return
	end
end

function var_0_2.StopMoveHandle(arg_14_0)
	arg_14_0.targetSpeed = 0
	arg_14_0.speed = 0
	arg_14_0.orginTargetDir = var_0_1
	arg_14_0.isSprint = false

	return
end

return var_0_2
