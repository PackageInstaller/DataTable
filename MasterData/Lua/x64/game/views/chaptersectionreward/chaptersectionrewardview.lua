local ChapterSectionRewardView = class("ChapterSectionRewardView", ReduxView)

function ChapterSectionRewardView:UIName()
	return "Widget/System/Operation/ChapterSectionRewardUI"
end

function ChapterSectionRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function ChapterSectionRewardView:Init()
	self.rewardPanelItems_ = {}

	self:InitUI()
	self:AddListeners()
end

function ChapterSectionRewardView:OnEnter()
	self.chapterID_ = tonumber(self.params_.chapterID)

	for iter_4_0, iter_4_1 in ipairs(self.rewardPanelItems_) do
		iter_4_1:SetData(self.chapterID_)
	end
end

function ChapterSectionRewardView:Dispose()
	for iter_5_0, iter_5_1 in pairs(self.rewardPanelItems_) do
		iter_5_1:Dispose()
	end

	self.rewardPanelItems_ = nil

	ChapterSectionRewardView.super.Dispose(self)
end

function ChapterSectionRewardView:InitUI()
	self:BindCfgUI()

	for iter_6_0 = 1, 3 do
		self.rewardPanelItems_[iter_6_0] = ChapterSectionRewardItemPanel.New(self[string.format("rewardPanelItem%s_", iter_6_0)], iter_6_0)
	end
end

function ChapterSectionRewardView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

return ChapterSectionRewardView
