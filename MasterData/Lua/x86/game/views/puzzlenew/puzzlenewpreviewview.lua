local PuzzleNewRewardView = class("PuzzleNewRewardView", ReduxView)

function PuzzleNewRewardView:UIName()
	return PuzzleNewTools.GetPreviewUIName(self.params_.activityID)
end

function PuzzleNewRewardView:UIParent()
	return manager.ui.uiPop.transform
end

function PuzzleNewRewardView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewRewardView:InitUI()
	self:BindCfgUI()
end

function PuzzleNewRewardView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PuzzleNewRewardView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.img_.sprite = pureGetSpriteWithoutAtlas(PuzzleNewCfg[self.activityID_].preview_album_id)
end

return PuzzleNewRewardView
