class = var_0_10000

local var_0_0 = "FushunEliteBeastChar"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".FushunBeastChar"))

function var_0_1.Hurt(arg_1_0, arg_1_1)
	if arg_1_0:IsDeath() or arg_1_0:IsEscape() then
		return
	end

	local var_1_0 = arg_1_0.animatorEvent

	var_2.SetEndEvent(var_1_0, nil)

	local var_1_1 = arg_1_0.animatorEvent

	var_2.SetEndEvent(var_1_1, function()
		local var_2_0 = arg_1_0

		var_0.Unfreeze(var_2_0)

		return
	end)
	arg_1_0:Freeze()
	arg_1_0:UpdateHp(arg_1_0.hp - arg_1_1)

	local var_1_2 = arg_1_0.animator

	var_2.SetTrigger(var_1_2, "damage")

	return
end

function var_0_1.UpdateHp(arg_3_0, arg_3_1)
	var_0_1.super.UpdateHp(arg_3_0, arg_3_1)

	local var_3_0 = arg_3_0.animator

	var_2.SetInteger(var_3_0, "hp", arg_3_0.hp)

	return
end

return var_0_1
