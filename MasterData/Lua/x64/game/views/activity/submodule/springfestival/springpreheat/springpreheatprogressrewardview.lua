local SpringPreheatRewardView = class("SpringPreheatRewardView", ReduxView)

function SpringPreheatRewardView:UIName()
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeRewardsUI"
end

function SpringPreheatRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function SpringPreheatRewardView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.rewardList_ = LuaList.New(handler(self, self.IndexItem), self.uiListGo_, SpringPreheatProgressRewardItem)
end

function SpringPreheatRewardView:OnEnter()
	self:RefreshUI()
end

function SpringPreheatRewardView:OnExit()
	return
end

function SpringPreheatRewardView:OnTop()
	SetActive(self.gameObject_, true)
end

function SpringPreheatRewardView:OnBehind()
	SetActive(self.gameObject_, false)
end

function SpringPreheatRewardView:Dispose()
	self.rewardList_:Dispose()
	SpringPreheatRewardView.super.Dispose(self)
end

function SpringPreheatRewardView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
end

function SpringPreheatRewardView:RefreshUI()
	self.rewardList_:StartScroll(#SpringPreheatData:GetProgressRewardList())
	self:RefreshProgressUI()
end

function SpringPreheatRewardView:RefreshProgressUI()
	self.progressText_.text = string.format("%d/%d", SpringPreheatData:GetProgressRewardScore(), (SpringPreheatData:GetMaxPrgressRewardScore()))
end

function SpringPreheatRewardView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:SetData(SpringPreheatData:GetProgressRewardList()[arg_13_1].id)
	arg_13_2:SetClickHandler(function(arg_14_0)
		self:OnClickRewardItem(arg_13_1, arg_14_0)
	end)
	arg_13_2:RefreshUI()
end

function SpringPreheatRewardView:OnClickRewardItem(arg_15_1, arg_15_2)
	local var_15_0 = SpringPreheatData:GetProgressRewardList()[arg_15_1]

	if not SpringPreheatData:CanAcquire(var_15_0.id) or SpringPreheatData:IsAcquired(var_15_0.id) then
		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_15_0.reward_item_list
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)

		return
	end

	SpringPreheatAction:RequestProgressReward(var_15_0.id, function(arg_16_0)
		self:RefreshProgressUI()
		arg_15_2:RefreshUI()
		getReward2(arg_16_0.reward_list)
	end)
end

return SpringPreheatRewardView
