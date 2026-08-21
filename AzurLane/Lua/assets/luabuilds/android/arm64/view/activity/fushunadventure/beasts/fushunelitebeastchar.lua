local var_0_0 = class("FushunEliteBeastChar", import(".FushunBeastChar"))

function var_0_0.Hurt(arg_1_0, arg_1_1)
	if arg_1_0:IsDeath() or arg_1_0:IsEscape() then
		return
	end

	arg_1_0.animatorEvent:SetEndEvent(nil)
	arg_1_0.animatorEvent:SetEndEvent(function()
		arg_1_0:Unfreeze()

		return
	end)
	arg_1_0:Freeze()
	arg_1_0:UpdateHp(arg_1_0.hp - arg_1_1)
	arg_1_0.animator:SetTrigger("damage")

	return
end

function var_0_0.UpdateHp(arg_3_0, arg_3_1)
	var_0_0.super.UpdateHp(arg_3_0, arg_3_1)
	arg_3_0.animator:SetInteger("hp", arg_3_0.hp)

	return
end

return var_0_0
