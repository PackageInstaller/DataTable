class = var_0_10000

local var_0_0 = "FuShunMonsterScript"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..RectBaseScript"))

function var_0_1.onInit(arg_1_0)
	arg_1_0._loop = true
	arg_1_0._active = true
	arg_1_0._weight = 1
	arg_1_0._scriptTime = nil

	local var_1_0 = arg_1_0._collisionInfo.playerInput

	math = var_1_10002
	var_1_0.x = var_1_10002.random() > 0.5 and 1 or -1
	arg_1_0._collisionInfo.directionalInput = arg_1_0._collisionInfo.playerInput
	arg_1_0._name = "FuShunMonsterScript"

	return
end

function var_0_1.onStep(arg_2_0)
	arg_2_0._collisionInfo.config.moveSpeed = 1

	if arg_2_0._collisionInfo.left and arg_2_0._collisionInfo.playerInput.x == -1 then
		arg_2_0._collisionInfo.playerInput.x = 1
		arg_2_0._collisionInfo.directionalInput = arg_2_0._collisionInfo.playerInput
	elseif arg_2_0._collisionInfo.right and arg_2_0._collisionInfo.playerInput.x == 1 then
		arg_2_0._collisionInfo.playerInput.x = -1
		arg_2_0._collisionInfo.directionalInput = arg_2_0._collisionInfo.playerInput
	end

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
	return
end

return var_0_1
