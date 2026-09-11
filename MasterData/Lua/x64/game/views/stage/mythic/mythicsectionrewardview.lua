local MythicSectionRewardView = class("MythicSectionRewardView", ReduxView)

function MythicSectionRewardView:UIName()
	return "Widget/System/Challenge_Mythic/MythicSectionRewardUI"
end

function MythicSectionRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function MythicSectionRewardView:OnCtor()
	return
end

function MythicSectionRewardView:Init()
	self.rewardPanelItems_ = {}

	self:InitUI()
	self:AddListeners()
end

function MythicSectionRewardView:OnEnter()
	self.difficulty_ = tonumber(self.params_.difficulty)

	for iter_5_0, iter_5_1 in ipairs(self.rewardPanelItems_) do
		iter_5_1:SetData(self.difficulty_)
	end

	manager.windowBar:HideBar()
end

function MythicSectionRewardView:Dispose()
	self:RemoveListeners()

	for iter_6_0, iter_6_1 in pairs(self.rewardPanelItems_) do
		iter_6_1:Dispose()
	end

	self.rewardPanelItems_ = nil

	MythicSectionRewardView.super.Dispose(self)
end

function MythicSectionRewardView:InitUI()
	self:BindCfgUI()

	for iter_7_0 = 1, 3 do
		self.rewardPanelItems_[iter_7_0] = MythicSectionRewardItem.New(self[string.format("rewardPanelItem%s_", iter_7_0)], iter_7_0)
	end
end

function MythicSectionRewardView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.Back()
	end)
end

function MythicSectionRewardView:RemoveListeners()
	return
end

function MythicSectionRewardView:OnMythicStarRewardUpdate()
	for iter_11_0, iter_11_1 in ipairs(self.rewardPanelItems_) do
		iter_11_1:SetData(self.difficulty_)
	end
end

return MythicSectionRewardView
