local var_0_0 = class("FuShunAttakeScript", import("..RectBaseScript"))

function var_0_0.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 2
	arg_1_0._scriptTime = 0.4
	arg_1_0._overrideAble = true
	arg_1_0._name = "FuShunAttakeScript"

	return
end

function var_0_0.onStep(arg_2_0)
	if arg_2_0._active and arg_2_0._collisionInfo.below and not arg_2_0._lateActive then
		arg_2_0._event:emit(Fushun3GameEvent.script_attack_event)
	end

	return
end

function var_0_0.onLateStep(arg_3_0)
	return
end

function var_0_0.onTrigger(arg_4_0)
	if Application.isEditor and arg_4_0._triggerKey == KeyCode.J and arg_4_0._triggerStatus and arg_4_0:checkScirptApply() then
		arg_4_0._active = true
	end

	return
end

return var_0_0
