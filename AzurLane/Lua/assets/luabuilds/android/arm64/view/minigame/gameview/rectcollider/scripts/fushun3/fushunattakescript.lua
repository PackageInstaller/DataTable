class = var_0_10000

local var_0_0 = "FuShunAttakeScript"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..RectBaseScript"))

function var_0_1.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 2
	arg_1_0._scriptTime = 0.4
	arg_1_0._overrideAble = true
	arg_1_0._name = "FuShunAttakeScript"

	return
end

function var_0_1.onStep(arg_2_0)
	if arg_2_0._active and arg_2_0._collisionInfo.below and not arg_2_0._lateActive then
		local var_2_0 = arg_2_0._event
		local var_2_1 = var_1.emit

		Fushun3GameEvent = var_1_10004

		var_2_1(var_2_0, var_1_10004.script_attack_event)
	end

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

		if var_4_0 == var_1_10002.J and arg_4_0._triggerStatus and arg_4_0:checkScirptApply() then
			arg_4_0._active = true
		end
	end

	return
end

return var_0_1
