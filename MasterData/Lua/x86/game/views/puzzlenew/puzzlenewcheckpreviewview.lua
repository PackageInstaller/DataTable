local PuzzleNewCheckPreviewView = class("PuzzleNewCheckPreviewView", ReduxView)

function PuzzleNewCheckPreviewView:UIName()
	return PuzzleNewTools.GetCheckPreviewUIName(self.params_.activityID)
end

function PuzzleNewCheckPreviewView:UIParent()
	return manager.ui.uiPop.transform
end

function PuzzleNewCheckPreviewView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PuzzleNewCheckPreviewView:InitUI()
	self:BindCfgUI()
end

function PuzzleNewCheckPreviewView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PuzzleNewCheckPreviewView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.originImg_.sprite = pureGetSpriteWithoutAtlas(PuzzleNewCfg[self.activityID_].preview_album_id)
	self.checkImg_.sprite = pureGetSpriteWithoutAtlas(PuzzleNewCfg[self.activityID_].album_id)

	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs((PuzzleNewData:GetCurCheckList(self.activityID_))) do
		var_7_0 = var_7_0 + 1
	end

	self.progressText_.text = string.format("%d/%d", var_7_0, #PuzzleNewCfg[self.activityID_].clue_id)
	self.checkGoalText_.text = string.format(GetTips("PUZZLE_CHECK_GOAL_TIP"), #PuzzleNewCfg[self.activityID_].clue_id)
end

return PuzzleNewCheckPreviewView
