local var_0_0 = class("FuShunMovementScript", import("..RectBaseScript"))

function var_0_0.onInit(arg_1_0)
	arg_1_0._loop = true
	arg_1_0._active = true
	arg_1_0._weight = 1
	arg_1_0._scriptTime = nil
	arg_1_0._name = "FuShunMovementScript"

	return
end

function var_0_0.onStep(arg_2_0)
	arg_2_0._collisionInfo.playerInput.x = 1

	local var_2_0 = arg_2_0._collisionInfo.playerInput.x * arg_2_0._collisionInfo.config.moveSpeed
	local var_2_1 = arg_2_0._collisionInfo:getVelocity()
	local var_2_2 = arg_2_0._collisionInfo.velocityXSmoothing

	if var_2_1.x == arg_2_0._collisionInfo.playerInput.x * arg_2_0._collisionInfo.config.moveSpeed then
		var_2_2 = 0
	end

	if arg_2_0._collisionInfo.below then
		local var_2_3 = arg_2_0._collisionInfo.config.accelerationTimeGrounded or arg_2_0._collisionInfo.config.accelerationTimeAirborne
		local var_2_4

		var_2_1.x, var_2_4 = Mathf.SmoothDamp(var_2_1.x, var_2_0, var_2_2, var_2_3)

		if not arg_2_0._collisionInfo.below then
			var_2_1.y = var_2_1.y + arg_2_0._collisionInfo.config.gravity * arg_2_0._collisionInfo.frameRate
		end

		arg_2_0._collisionInfo:setVelocity(var_2_1)

		arg_2_0._collisionInfo.velocityXSmoothing = var_2_4

		return
	end
end

function var_0_0.onLateStep(arg_3_0)
	return
end

function var_0_0.onTrigger(arg_4_0)
	if Application.isEditor and arg_4_0._triggerKey == KeyCode.A or arg_4_0._triggerKey == KeyCode.D then
		local var_4_0 = arg_4_0._keyInfo:getKeyCode(KeyCode.A)
		local var_4_1 = arg_4_0._keyInfo:getKeyCode(KeyCode.D)

		if arg_4_0._triggerKey == KeyCode.A then
			arg_4_0._collisionInfo.playerInput.x = arg_4_0._triggerStatus and -1 or var_4_1 and 1 or 0
		elseif arg_4_0._triggerKey == KeyCode.D then
			arg_4_0._collisionInfo.playerInput.x = arg_4_0._triggerStatus and 1 or var_4_0 and -1 or 0
		end

		arg_4_0._collisionInfo.directionalInput = arg_4_0._collisionInfo.playerInput
	end

	return
end

return var_0_0
