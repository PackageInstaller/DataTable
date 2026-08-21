local var_0_0 = class("BuffDescriptionMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerPlayerAffixesPop"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, BuffDescriptionView)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.list_[arg_5_1], arg_5_0.params_.type)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0.scrollHelper_:SetPageChangeHandler(handler(arg_6_0, arg_6_0.OnPageChange))
	arg_6_0:AddBtnListener(arg_6_0.leftBtn_, nil, function()
		if arg_6_0.pageIndex_ > 1 then
			arg_6_0.pageIndex_ = arg_6_0.pageIndex_ - 1

			arg_6_0.scrollHelper_:SwitchToPage(arg_6_0.pageIndex_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.rightBtn_, nil, function()
		if arg_6_0.pageIndex_ < arg_6_0.maxLv_ then
			arg_6_0.pageIndex_ = arg_6_0.pageIndex_ + 1

			arg_6_0.scrollHelper_:SwitchToPage(arg_6_0.pageIndex_)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
end

function var_0_0.OnPageChange(arg_10_0, arg_10_1)
	arg_10_0.pageIndex_ = arg_10_1

	arg_10_0:RefreshBtn()
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0.activityID_ = arg_11_0.params_.activityID
	arg_11_0.curdifficulty_ = LimitedCalculationData:GetCurDifficulty(arg_11_0.activityID_)

	if arg_11_0.params_.type == "buff" then
		arg_11_0.list_ = LimitedCalculationTools.GetBuffList(arg_11_0.activityID_)
	elseif arg_11_0.params_.type == "debuff" then
		arg_11_0.list_ = LimitedCalculationTools.GetDebuffList(arg_11_0.activityID_)
	end

	local var_11_0 = table.indexof(arg_11_0.list_, arg_11_0.curdifficulty_)

	if var_11_0 then
		arg_11_0.pageIndex_ = var_11_0
	else
		arg_11_0.pageIndex_ = 1
	end

	arg_11_0.maxLv_ = #arg_11_0.list_

	arg_11_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_12_0)
	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.list_, arg_12_0.pageIndex_, true, false)
	arg_12_0.scrollHelper_:SwitchToPage(arg_12_0.pageIndex_)
	arg_12_0:RefreshBtn()
end

function var_0_0.RefreshBtn(arg_13_0)
	SetActive(arg_13_0.leftBtn_.gameObject, arg_13_0.pageIndex_ > 1)
	SetActive(arg_13_0.rightBtn_.gameObject, arg_13_0.pageIndex_ < arg_13_0.maxLv_)
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnExit(arg_15_0)
	return
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	arg_16_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
