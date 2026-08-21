local var_0_0 = class("FuShunPowerSpeedScript", import("..RectBaseScript"))
local var_0_1 = {
	400,
	450
}
local var_0_2 = 20

function var_0_0.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 4
	arg_1_0._overrideAble = false
	arg_1_0._lastActive = false
	arg_1_0._scriptTime = 10
	arg_1_0._name = "FuShunPowerSpeedScript"

	return
end

function var_0_0.onStep(arg_2_0)
	if arg_2_0._active then
		local var_2_0 = arg_2_0._collisionInfo:getVelocity()
		local var_2_1 = arg_2_0._collisionInfo:getPos()

		if var_2_1.y >= var_0_1[2] then
			var_2_0.y = -10
		elseif var_2_1.y <= var_0_1[1] then
			var_2_0.y = 10
		else
			var_2_0.y = 0
			var_2_0.x = var_0_2

			if not arg_2_0.powerFlag then
				arg_2_0._event:emit(Fushun3GameEvent.script_power_event)

				arg_2_0.powerFlag = true
			end
		end

		arg_2_0._collisionInfo:setVelocity(var_2_0)
	else
		arg_2_0.powerFlag = false

		if arg_2_0._collisionInfo.script == arg_2_0 then
			arg_2_0._collisionInfo:removeScript()
		end
	end

	arg_2_0._lastActive = arg_2_0._active

	return
end

function var_0_0.onLateStep(arg_3_0)
	return
end

function var_0_0.onTrigger(arg_4_0)
	return
end

return var_0_0
