local var_0_0 = class("FuShunMonsterScript", import("..RectBaseScript"))

function var_0_0.onInit(arg_1_0)
	arg_1_0._loop = true
	arg_1_0._active = true
	arg_1_0._weight = 1
	arg_1_0._scriptTime = nil
	arg_1_0._collisionInfo.playerInput.x = math.random() > 0.5 and 1 or -1
	arg_1_0._collisionInfo.directionalInput = arg_1_0._collisionInfo.playerInput
	arg_1_0._name = "FuShunMonsterScript"

	return
end

function var_0_0.onStep(arg_2_0)
	arg_2_0._collisionInfo.config.moveSpeed = 1

	if arg_2_0._collisionInfo.left and arg_2_0._collisionInfo.playerInput.x == -1 then
		arg_2_0._collisionInfo.playerInput.x = 1
		arg_2_0._collisionInfo.directionalInput = arg_2_0._collisionInfo.playerInput
	elseif arg_2_0._collisionInfo.right and arg_2_0._collisionInfo.playerInput.x == 1 then
		arg_2_0._collisionInfo.playerInput.x = -1
		arg_2_0._collisionInfo.directionalInput = arg_2_0._collisionInfo.playerInput
	end

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
	return
end

return var_0_0
