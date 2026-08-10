local var_0_0 = class("SpringPreheatRewardView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeRewardsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListGo_, SpringPreheatProgressRewardItem)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	return
end

function var_0_0.OnTop(arg_6_0)
	SetActive(arg_6_0.gameObject_, true)
end

function var_0_0.OnBehind(arg_7_0)
	SetActive(arg_7_0.gameObject_, false)
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.rewardList_:Dispose()
	var_0_0.super.Dispose(arg_8_0)
end

function var_0_0.AddListeners(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.maskBtn_, nil, function()
		arg_9_0:Back()
	end)
end

function var_0_0.RefreshUI(arg_11_0)
	local var_11_0 = SpringPreheatData:GetProgressRewardList()

	arg_11_0.rewardList_:StartScroll(#var_11_0)
	arg_11_0:RefreshProgressUI()
end

function var_0_0.RefreshProgressUI(arg_12_0)
	local var_12_0 = SpringPreheatData:GetProgressRewardScore()
	local var_12_1 = SpringPreheatData:GetMaxPrgressRewardScore()

	arg_12_0.progressText_.text = string.format("%d/%d", var_12_0, var_12_1)
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SpringPreheatData:GetProgressRewardList()[arg_13_1]

	arg_13_2:SetData(var_13_0.id)
	arg_13_2:SetClickHandler(function(arg_14_0)
		arg_13_0:OnClickRewardItem(arg_13_1, arg_14_0)
	end)
	arg_13_2:RefreshUI()
end

function var_0_0.OnClickRewardItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = SpringPreheatData:GetProgressRewardList()[arg_15_1]
	local var_15_1 = var_15_0.reward_item_list

	if not SpringPreheatData:CanAcquire(var_15_0.id) or SpringPreheatData:IsAcquired(var_15_0.id) then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_15_1
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)

		return
	end

	SpringPreheatAction:RequestProgressReward(var_15_0.id, function(arg_16_0)
		arg_15_0:RefreshProgressUI()
		arg_15_2:RefreshUI()
		getReward2(arg_16_0.reward_list)
	end)
end

return var_0_0
