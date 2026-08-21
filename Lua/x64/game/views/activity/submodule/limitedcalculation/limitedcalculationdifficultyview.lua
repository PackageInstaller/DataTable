local var_0_0 = class("LimitedCalculationDifficultyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerDifficultySelectionPop"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, DifficultySelectItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.activityID_, arg_5_0.list_[arg_5_1])
	arg_5_2:SetSelected(arg_5_0.curDifficulty_)
	arg_5_2:RegisterClickListener(function(arg_6_0)
		arg_5_0.curDifficulty_ = arg_6_0

		arg_5_0:Back()
	end)
end

function var_0_0.AddUIListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		arg_7_0:Back()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.curDifficulty_ = LimitedCalculationData:GetCurDifficulty(arg_10_0.activityID_)
	arg_10_0.list_ = LimitedCalculationData:GetDifficultyList(arg_10_0.activityID_)

	local var_10_0 = table.indexof(arg_10_0.list_, arg_10_0.curDifficulty_)

	if var_10_0 == 1 then
		arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_)
	else
		arg_10_0.scrollHelper_:StartScroll(#arg_10_0.list_, var_10_0 - 1)
	end
end

function var_0_0.RefreshList(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.scrollHelper_:GetItemList()) do
		iter_11_1:SetSelected(arg_11_0.curDifficulty_)
	end
end

function var_0_0.OnExit(arg_12_0)
	LimitedCalculationData:SetCurDifficulty(arg_12_0.activityID_, arg_12_0.curDifficulty_)
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0:RemoveAllListeners()
	arg_13_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
