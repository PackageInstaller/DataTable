local var_0_0 = class("CapsuleToysRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/ReturnTwo/RT2stBonusPreviewUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.coreRewardList_ = {}
	arg_4_0.normalRewardList_ = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.backMask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.version_ = RegressionData:GetRegressionVersion()

	local var_8_0 = RegressionCfg[arg_8_0.version_].gashapon
	local var_8_1 = {}
	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if RegressionCapsuleToysCfg[iter_8_1].reward_type == 1 then
			var_8_1[#var_8_1 + 1] = iter_8_1
		else
			var_8_2[#var_8_2 + 1] = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		if not arg_8_0.coreRewardList_[iter_8_2] then
			arg_8_0.coreRewardList_[iter_8_2] = CapsuleToysRewardItem.New(arg_8_0.coreRewardPanel_, arg_8_0.rewardGo_, false)
		end

		arg_8_0.coreRewardList_[iter_8_2]:SetData(iter_8_3, iter_8_2)
	end

	for iter_8_4 = #var_8_1 + 1, #arg_8_0.coreRewardList_ do
		arg_8_0.coreRewardList_[iter_8_4]:Show(false)
	end

	for iter_8_5, iter_8_6 in ipairs(var_8_2) do
		if not arg_8_0.normalRewardList_[iter_8_5] then
			arg_8_0.normalRewardList_[iter_8_5] = CapsuleToysRewardItem.New(arg_8_0.normalRewardPanel_, arg_8_0.rewardGo_, false)
		end

		arg_8_0.normalRewardList_[iter_8_5]:SetData(iter_8_6, iter_8_5)
	end

	for iter_8_7 = #var_8_2 + 1, #arg_8_0.normalRewardList_ do
		arg_8_0.normalRewardList_[iter_8_7]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.coreRewardPanel_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.corRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.normalRewardPanel_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.normalRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.contentTrans_)
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	if arg_9_0.coreRewardList_ then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0.coreRewardList_) do
			iter_9_1:Dispose()
		end

		arg_9_0.coreRewardList_ = nil
	end

	if arg_9_0.normalRewardList_ then
		for iter_9_2, iter_9_3 in ipairs(arg_9_0.normalRewardList_) do
			iter_9_3:Dispose()
		end

		arg_9_0.normalRewardList_ = nil
	end
end

return var_0_0
