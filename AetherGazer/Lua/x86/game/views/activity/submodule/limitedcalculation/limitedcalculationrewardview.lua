local var_0_0 = class("LimitedCalculationRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerIntegralRewardPop"
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

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.listGo_, LimitedCalculationRewardItem)
end

function var_0_0.IndexItem(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_0.list_[arg_5_1], arg_5_0.activityID_)
end

function var_0_0.AddUIListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddBtnListener(arg_6_0.getAllBtn_, nil, function()
		LimitedCalculationAction:GetAllRewardAction(arg_6_0.activityID_)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0.activityID_ = arg_9_0.params_.activityID

	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0:RefreshScore()
	arg_10_0:RefreshList()
end

function var_0_0.RefreshScore(arg_11_0)
	arg_11_0.score_ = LimitedCalculationData:GetScore(arg_11_0.activityID_)
	arg_11_0.title_.text = arg_11_0.score_
end

function var_0_0.RefreshList(arg_12_0)
	arg_12_0.list_ = {}

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = {}
	local var_12_3
	local var_12_4 = LimitedCalculationData:GetRewardList(arg_12_0.activityID_)

	for iter_12_0, iter_12_1 in ipairs(var_12_4) do
		local var_12_5 = ActivityPointRewardCfg[iter_12_1.id].need

		if iter_12_1.complete_flag <= 0 then
			if var_12_5 <= arg_12_0.score_ then
				table.insert(var_12_0, iter_12_1)
			else
				table.insert(var_12_1, iter_12_1)
			end
		else
			table.insert(var_12_2, iter_12_1)
		end
	end

	local function var_12_6(arg_13_0, arg_13_1)
		return arg_13_0.id < arg_13_1.id
	end

	table.sort(var_12_0, var_12_6)
	table.sort(var_12_1, var_12_6)
	table.sort(var_12_2, var_12_6)

	if var_12_0[1] == nil then
		SetActive(arg_12_0.getAllBtn_.gameObject, false)
	else
		SetActive(arg_12_0.getAllBtn_.gameObject, true)
	end

	table.insertto(arg_12_0.list_, var_12_0)
	table.insertto(arg_12_0.list_, var_12_1)
	table.insertto(arg_12_0.list_, var_12_2)
	arg_12_0.scrollHelper_:StartScroll(#arg_12_0.list_)
end

function var_0_0.OnReceivePointReward(arg_14_0)
	arg_14_0:RefreshList()
end

function var_0_0.OnExit(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.scrollHelper_:GetItemList()) do
		iter_15_1:OnExit()
	end
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0:RemoveAllListeners()
	arg_16_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
