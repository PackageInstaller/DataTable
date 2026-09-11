local NewServerCapsuleToysRewardView = class("NewServerCapsuleToysRewardView", ReduxView)

function NewServerCapsuleToysRewardView:UIName()
	return "Widget/System/NewServer/NewServerRewardPreviewPopUI"
end

function NewServerCapsuleToysRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function NewServerCapsuleToysRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewServerCapsuleToysRewardView:InitUI()
	self:BindCfgUI()

	self.coreRewardList_ = {}
	self.normalRewardList_ = {}
end

function NewServerCapsuleToysRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function NewServerCapsuleToysRewardView:OnEnter()
	self.activityID_ = self.params_.activityID

	self:RefreshUI()
end

function NewServerCapsuleToysRewardView:RefreshUI()
	local var_8_0 = {}
	local var_8_1 = {}

	for iter_8_0, iter_8_1 in ipairs(NewServerCfg[self.activityID_].gashapon) do
		if NewServerCapsuleToysCfg[iter_8_1].reward_type == 1 then
			var_8_0[#var_8_0 + 1] = iter_8_1
		else
			var_8_1[#var_8_1 + 1] = iter_8_1
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		self.coreRewardList_[iter_8_2] = self.coreRewardList_[iter_8_2] or NewServerCapsuleToysItem.New((Object.Instantiate(self.rewardGo_, self.coreRewardPanel_)))

		self.coreRewardList_[iter_8_2]:SetData(iter_8_3)
	end

	for iter_8_4 = #var_8_0 + 1, #self.coreRewardList_ do
		self.coreRewardList_[iter_8_4]:Show(false)
	end

	for iter_8_5, iter_8_6 in ipairs(var_8_1) do
		self.normalRewardList_[iter_8_5] = self.normalRewardList_[iter_8_5] or NewServerCapsuleToysItem.New((Object.Instantiate(self.rewardGo_, self.normalRewardPanel_)))

		self.normalRewardList_[iter_8_5]:SetData(iter_8_6, iter_8_5)
	end

	for iter_8_7 = #var_8_1 + 1, #self.normalRewardList_ do
		self.normalRewardList_[iter_8_7]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.coreRewardPanel_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.coreRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.normalRewardPanel_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.normalRewardGroup_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrans_)
end

function NewServerCapsuleToysRewardView:Dispose()
	NewServerCapsuleToysRewardView.super.Dispose(self)

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

return NewServerCapsuleToysRewardView
