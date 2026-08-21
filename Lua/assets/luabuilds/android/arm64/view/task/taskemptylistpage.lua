local var_0_0 = class("TaskEmptyListPage", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "TaskEmptyListUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._tf:SetSiblingIndex(1)
	setText(findTF(arg_2_0._tf, "Text"), i18n("list_empty_tip_taskscene"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.isShowUI = false

	return
end

function var_0_0.ShowOrHide(arg_4_0, arg_4_1)
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

return var_0_0
