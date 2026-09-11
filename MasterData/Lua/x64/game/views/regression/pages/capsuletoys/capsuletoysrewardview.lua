local CapsuleToysRewardView = class("CapsuleToysRewardView", ReduxView)

function CapsuleToysRewardView:UIName()
	return "Widget/System/ReturnTwo/RT2stBonusPreviewUI"
end

function CapsuleToysRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function CapsuleToysRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CapsuleToysRewardView:InitUI()
	self:BindCfgUI()

	self.coreRewardList_ = {}
	self.normalRewardList_ = {}
end

function CapsuleToysRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function CapsuleToysRewardView:OnEnter()
	self:RefreshUI()
end

function CapsuleToysRewardView:RefreshUI()
	self.version_ = RegressionData:GetRegressionVersion()

	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(RegressionCfg[self.version_].gashapon) do
		if RegressionCapsuleToysCfg[iter_8_1].reward_type == 1 then
			var_8_0[#var_8_0 + 1] = iter_8_1
		else
			var_8_1[#var_8_1 + 1] = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		self.coreRewardList_[iter_8_2] = self.coreRewardList_[iter_8_2] or CapsuleToysRewardItem.New(self.coreRewardPanel_, self.rewardGo_, false)

		self.coreRewardList_[iter_8_2]:SetData(iter_8_3, iter_8_2)
	end

	for iter_8_4 = #var_8_0 + 1, #self.coreRewardList_ do
		self.coreRewardList_[iter_8_4]:Show(false)
	end

	for iter_8_5, iter_8_6 in ipairs(var_8_1) do
		self.normalRewardList_[iter_8_5] = self.normalRewardList_[iter_8_5] or CapsuleToysRewardItem.New(self.normalRewardPanel_, self.rewardGo_, false)

		self.normalRewardList_[iter_8_5]:SetData(iter_8_6, iter_8_5)
	end

	for iter_8_7 = #var_8_1 + 1, #self.normalRewardList_ do
		self.normalRewardList_[iter_8_7]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.coreRewardPanel_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.corRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.normalRewardPanel_.transform)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.normalRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function CapsuleToysRewardView:Dispose()
	CapsuleToysRewardView.super.Dispose(self)

	if self.coreRewardList_ then
		for iter_9_0, iter_9_1 in ipairs(self.coreRewardList_) do
			iter_9_1:Dispose()
		end

		self.coreRewardList_ = nil
	end

	if self.normalRewardList_ then
		for iter_9_2, iter_9_3 in ipairs(self.normalRewardList_) do
			iter_9_3:Dispose()
		end

		self.normalRewardList_ = nil
	end
end

return CapsuleToysRewardView
