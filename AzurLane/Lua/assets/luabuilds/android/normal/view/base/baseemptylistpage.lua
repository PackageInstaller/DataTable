class = var_0_10000

local var_0_0 = "BaseEmptyListPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "TaskEmptyListUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	var_1.SetSiblingIndex(var_2_0, 1)

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0.isShowUI = false

	return
end

function var_0_1.SetEmptyText(arg_4_0, arg_4_1)
	findTF = var_1_10002

	local var_4_0 = var_1_10002(arg_4_0._tf, "Text")

	setText = var_3

	var_3(var_4_0, arg_4_1)

	return
end

function var_0_1.SetPosY(arg_5_0, arg_5_1)
	setAnchoredPosition = var_1_10002

	var_1_10002(arg_5_0._tf, arg_5_1)

	return
end

function var_0_1.ShowOrHide(arg_6_0, arg_6_1)
	if arg_6_0.isShowUI == arg_6_1 then
		return
	end

	if arg_6_1 then
		arg_6_0:Show()
	else
		arg_6_0:Hide()
	end

	arg_6_0.isShowUI = arg_6_1

	return
end

return var_0_1
