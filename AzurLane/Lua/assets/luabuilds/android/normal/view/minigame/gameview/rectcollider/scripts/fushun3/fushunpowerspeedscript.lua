class = var_0_10000

local var_0_0 = "FuShunPowerSpeedScript"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..RectBaseScript"))
local var_0_2 = {
	400,
	450
}
local var_0_3 = 20

function var_0_1.onInit(arg_1_0)
	arg_1_0._loop = false
	arg_1_0._active = false
	arg_1_0._weight = 4
	arg_1_0._overrideAble = false
	arg_1_0._lastActive = false
	arg_1_0._scriptTime = 10
	arg_1_0._name = "FuShunPowerSpeedScript"

	return
end

function var_0_1.onStep(arg_2_0)
	if arg_2_0._active then
		local var_2_0 = arg_2_0._collisionInfo
		local var_2_1 = var_1.getVelocity(var_2_0)
		local var_2_2 = arg_2_0._collisionInfo

		if var_2.getPos(var_2_2).y >= var_0_2[2] then
			var_2_1.y = -10
		elseif var_2.y <= var_0_2[1] then
			var_2_1.y = 10
		else
			var_2_1.y = 0
			var_2_1.x = var_0_3

			if not arg_2_0.powerFlag then
				local var_2_3 = arg_2_0._event
				local var_2_4 = var_3.emit

				Fushun3GameEvent = var_1_10005

				var_2_4(var_2_3, var_1_10005.script_power_event)

				arg_2_0.powerFlag = true
			end
		end

		local var_2_5 = arg_2_0._collisionInfo

		var_3.setVelocity(var_2_5, var_2_1)
	else
		arg_2_0.powerFlag = false

		if arg_2_0._collisionInfo.script == arg_2_0 then
			local var_2_6 = arg_2_0._collisionInfo

			var_1.removeScript(var_2_6)
		end
	end

	arg_2_0._lastActive = arg_2_0._active

	return
end

function var_0_1.onLateStep(arg_3_0)
	return
end

function var_0_1.onTrigger(arg_4_0)
	return
end

return var_0_1
