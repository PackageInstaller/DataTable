class = var_0_10000

local var_0_0 = "FuShunMovementScript"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..RectBaseScript"))

function var_0_1.onInit(arg_1_0)
	arg_1_0._loop = true
	arg_1_0._active = true
	arg_1_0._weight = 1
	arg_1_0._scriptTime = nil
	arg_1_0._name = "FuShunMovementScript"

	return
end

function var_0_1.onStep(arg_2_0)
	arg_2_0._collisionInfo.playerInput.x = 1

	local var_2_0 = arg_2_0._collisionInfo.playerInput.x * arg_2_0._collisionInfo.config.moveSpeed
	local var_2_1 = arg_2_0._collisionInfo
	local var_2_2 = var_2.getVelocity(var_2_1)
	local var_2_3 = arg_2_0._collisionInfo.velocityXSmoothing

	if var_2_2.x == var_2_0 then
		var_2_3 = 0
	end

	local var_2_4

	if not arg_2_0._collisionInfo.below or not arg_2_0._collisionInfo.config.accelerationTimeGrounded then
		var_2_4 = arg_2_0._collisionInfo.config.accelerationTimeAirborne
	end

	Mathf = var_1_10005

	local var_2_5

	var_2_2.x, var_2_5 = var_1_10005.SmoothDamp(var_2_2.x, var_2_0, var_2_3, var_2_4)

	if not arg_2_0._collisionInfo.below then
		var_2_2.y = var_2_2.y + arg_2_0._collisionInfo.config.gravity * arg_2_0._collisionInfo.frameRate
	end

	local var_2_6 = arg_2_0._collisionInfo

	var_5.setVelocity(var_2_6, var_2_2)

	arg_2_0._collisionInfo.velocityXSmoothing = var_2_5

	return
end

function var_0_1.onLateStep(arg_3_0)
	return
end

function var_0_1.onTrigger(arg_4_0)
	Application = var_1_10001

	if var_1_10001.isEditor then
		local var_4_0 = arg_4_0._triggerKey

		KeyCode = var_1_10002

		if var_4_0 ~= var_1_10002.A then
			local var_4_1 = arg_4_0._triggerKey

			KeyCode = var_1_10002

			if var_4_1 == var_1_10002.D then
				local var_4_2 = arg_4_0._keyInfo
				local var_4_3 = var_1.getKeyCode

				KeyCode = var_1_10004

				local var_4_4 = var_4_3(var_4_2, var_1_10004.A)
				local var_4_5 = arg_4_0._keyInfo
				local var_4_6 = var_2.getKeyCode

				KeyCode = var_1_10005

				local var_4_7 = var_4_6(var_4_5, var_1_10005.D)
				local var_4_8 = arg_4_0._triggerKey

				KeyCode = var_4_5

				local var_4_10

				if var_4_8 == var_4_5.A then
					local var_4_9 = arg_4_0._collisionInfo.playerInput

					var_4_10 = arg_4_0._triggerStatus and -1 or var_4_7 and 1 or 0
					var_4_9.x = var_4_10
				else
					local var_4_11 = arg_4_0._triggerKey

					KeyCode = var_4_10

					if var_4_11 == var_4_10.D then
						arg_4_0._collisionInfo.playerInput.x = arg_4_0._triggerStatus and 1 or var_4_4 and -1 or 0
					end
				end

				arg_4_0._collisionInfo.directionalInput = arg_4_0._collisionInfo.playerInput
			end

			return
		end
	end
end

return var_0_1
