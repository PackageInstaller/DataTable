local var_0_0 = class("MainCommissionBtn4Mellow", import(".MainCommissionBtn"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, 0)

	arg_1_0.animationPlayer = arg_1_1:GetComponent(typeof(Animation))

	return
end

function var_0_0.OnClick(arg_2_0)
	arg_2_0.animationPlayer:Play("anim_newmain_extend_show")
	arg_2_0:emit(NewMainMediator.OPEN_COMMISION)

	return
end

function var_0_0.ResetCommissionBtn(arg_3_0)
	arg_3_0.animationPlayer:Play("anim_newmain_extend_hide")

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	if not arg_4_1 and not getProxy(ContextProxy):getCurrentContext():getContextByMediator(CommissionInfoMediator) then
		arg_4_0:ResetCommissionBtn()
	end

	return
end

return var_0_0
