class = var_0_10000

local var_0_0 = "DebugPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.onUILoaded

	DebugMgr = var_1_10003

	var_1_1(var_1_0, var_1_10003.Inst.DebugPanel)

	setActive = var_1_1

	var_1_1(arg_1_0._tf, false)

	local var_1_2 = arg_1_0._tf

	arg_1_0.ctrls = var_1.Find(var_1_2, "ctrls")
	arg_1_0._customBtnTpl = arg_1_0:getTpl("ctrls/custom_button")

	return
end

function var_0_1.addCustomBtn(arg_2_0, arg_2_1, arg_2_2)
	cloneTplTo = var_1_10003

	local var_2_0 = var_1_10003(arg_2_0._customBtnTpl, arg_2_0.ctrls)

	string = var_4
	arg_2_1 = var_4.gsub(arg_2_1, "(.)", "%1\n")
	setButtonText = var_4

	var_4(var_2_0, arg_2_1)

	onButton = var_4

	var_4(arg_2_0, var_2_0, arg_2_2)

	return
end

function var_0_1.hidePanel(arg_3_0)
	triggerButton = var_1_10001

	local var_3_0 = arg_3_0.ctrls

	var_1_10001(var_2.Find(var_3_0, "hide_button"))

	return
end

return var_0_1
