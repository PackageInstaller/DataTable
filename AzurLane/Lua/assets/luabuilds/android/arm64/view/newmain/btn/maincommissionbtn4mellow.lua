class = var_0_10000

local var_0_0 = "MainCommissionBtn4Mellow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainCommissionBtn"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, 0)

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.GetComponent

	typeof = var_7
	Animation = var_9
	arg_1_0.animationPlayer = var_1_1(var_1_0, var_7(var_9))

	return
end

function var_0_1.OnClick(arg_2_0)
	local var_2_0 = arg_2_0.animationPlayer

	var_1.Play(var_2_0, "anim_newmain_extend_show")

	local var_2_1 = arg_2_0
	local var_2_2 = arg_2_0.emit

	NewMainMediator = var_4

	var_2_2(var_2_1, var_4.OPEN_COMMISION)

	return
end

function var_0_1.ResetCommissionBtn(arg_3_0)
	local var_3_0 = arg_3_0.animationPlayer

	var_1.Play(var_3_0, "anim_newmain_extend_hide")

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_4_0 = var_1_10002(var_1_10004)
	local var_4_1 = var_2.getCurrentContext(var_4_0)
	local var_4_2 = var_2.getContextByMediator

	CommissionInfoMediator = var_1_10006

	local var_4_3 = var_4_2(var_4_1, var_1_10006)

	if not arg_4_1 and not var_4_3 then
		arg_4_0:ResetCommissionBtn()
	end

	return
end

return var_0_1
