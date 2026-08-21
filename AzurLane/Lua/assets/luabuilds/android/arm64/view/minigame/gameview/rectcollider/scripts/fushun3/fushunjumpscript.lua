local var_0_0 = class("FuShunJumpScript", import("..RectBaseScript"))

function var_0_0.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 2
	arg_1_0._scriptTime = 0.01
	arg_1_0._lastActive = false
	arg_1_0._name = "FuShunJumpScript"

	return
end

function var_0_0.onStep(arg_2_0)
	if arg_2_0._active then
		if arg_2_0._collisionInfo.below and arg_2_0._collisionInfo.useJumpTimes == 0 then
			local var_2_0 = arg_2_0._collisionInfo:getVelocity()

			var_2_0.x = 0

			arg_2_0._collisionInfo:setVelocity(var_2_0)
		end
	elseif arg_2_0._lastActive and arg_2_0:checkScirptApply() and arg_2_0._collisionInfo.below and arg_2_0._collisionInfo.useJumpTimes == 0 then
		local var_2_1 = arg_2_0._collisionInfo:getVelocity()

		var_2_1.y = arg_2_0._collisionInfo.config.maxJumpVelocity
		arg_2_0._collisionInfo.useJumpTimes = 1

		if arg_2_0._event then
			arg_2_0._event:emit(Fushun3GameEvent.script_jump_event)
		end

		var_2_1.x = arg_2_0._collisionInfo.config.moveSpeed

		arg_2_0._collisionInfo:setVelocity(var_2_1)
	end

	arg_2_0._lastActive = arg_2_0._active

	return
end

function var_0_0.onLateStep(arg_3_0)
	if arg_3_0._collisionInfo.below and arg_3_0._collisionInfo.useJumpTimes == 1 then
		arg_3_0._collisionInfo.useJumpTimes = 0
	end

	return
end

function var_0_0.onTrigger(arg_4_0, arg_4_1, arg_4_2)
	if Application.isEditor and arg_4_0._triggerKey == KeyCode.Space then
		if not arg_4_2 then
			print()
		end

		if arg_4_0:checkScirptApply() then
			arg_4_0._active = true
		end
	end

	return
end

return var_0_0
