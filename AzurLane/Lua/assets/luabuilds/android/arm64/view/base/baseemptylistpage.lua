local var_0_0 = class("BaseEmptyListPage", import("..base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "TaskEmptyListUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0._tf:SetSiblingIndex(1)

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.isShowUI = false

	return
end

function var_0_0.SetEmptyText(arg_4_0, arg_4_1)
	setText(findTF(arg_4_0._tf, "Text"), arg_4_1)

	return
end

function var_0_0.SetPosY(arg_5_0, arg_5_1)
	setAnchoredPosition(arg_5_0._tf, arg_5_1)

	return
end

function var_0_0.ShowOrHide(arg_6_0, arg_6_1)
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

return var_0_0
