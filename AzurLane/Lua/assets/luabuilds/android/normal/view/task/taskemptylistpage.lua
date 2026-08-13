class = var_0_10000

local var_0_0 = "TaskEmptyListPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TaskEmptyListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	var_1.SetSiblingIndex(var_2_0, 1)

	findTF = var_1

	local var_2_1

	var_2_1, setText = var_1(arg_2_0._tf, "Text"), var_2
	i18n = var_1_10004

	var_2(var_2_1, var_1_10004("list_empty_tip_taskscene"))

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.isShowUI = false

	return
end

function var_0_1.ShowOrHide(arg_4_0, arg_4_1)
	if arg_4_0.isShowUI == arg_4_1 then
		return
	end

	if arg_4_1 then
		arg_4_0:Show()
	else
		arg_4_0:Hide()
	end

	arg_4_0.isShowUI = arg_4_1

	return
end

return var_0_1
