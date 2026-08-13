class = var_0_10000

local var_0_0 = "FuShunJumpScript"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..RectBaseScript"))

function var_0_1.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 2
	arg_1_0._scriptTime = 0.01
	arg_1_0._lastActive = false
	arg_1_0._name = "FuShunJumpScript"

	return
end

function var_0_1.onStep(arg_2_0)
	if arg_2_0._active then
		if arg_2_0._collisionInfo.below and arg_2_0._collisionInfo.useJumpTimes == 0 then
			local var_2_0 = arg_2_0._collisionInfo
			local var_2_1 = var_1.getVelocity(var_2_0)

			var_2_1.x = 0

			local var_2_2 = arg_2_0._collisionInfo

			var_2.setVelocity(var_2_2, var_2_1)
		end
	elseif arg_2_0._lastActive and arg_2_0:checkScirptApply() and arg_2_0._collisionInfo.below and arg_2_0._collisionInfo.useJumpTimes == 0 then
		local var_2_3 = arg_2_0._collisionInfo
		local var_2_4 = var_1.getVelocity(var_2_3)

		var_2_4.y = arg_2_0._collisionInfo.config.maxJumpVelocity
		arg_2_0._collisionInfo.useJumpTimes = 1

		if arg_2_0._event then
			local var_2_5 = arg_2_0._event
			local var_2_6 = var_2.emit

			Fushun3GameEvent = var_1_10004

			var_2_6(var_2_5, var_1_10004.script_jump_event)
		end

		var_2_4.x = arg_2_0._collisionInfo.config.moveSpeed

		local var_2_7 = arg_2_0._collisionInfo

		var_2.setVelocity(var_2_7, var_2_4)
	end

	arg_2_0._lastActive = arg_2_0._active

	return
end

function var_0_1.onLateStep(arg_3_0)
	if arg_3_0._collisionInfo.below and arg_3_0._collisionInfo.useJumpTimes == 1 then
		arg_3_0._collisionInfo.useJumpTimes = 0
	end

	return
end

function var_0_1.onTrigger(arg_4_0, arg_4_1, arg_4_2)
	Application = var_1_10003

	if var_1_10003.isEditor then
		local var_4_0 = arg_4_0._triggerKey

		KeyCode = var_1_10004

		if var_4_0 == var_1_10004.Space then
			if not arg_4_2 then
				print = var_4_0

				var_4_0()
			end

			if arg_4_0:checkScirptApply() then
				arg_4_0._active = true
			end
		end
	end

	return
end

return var_0_1
