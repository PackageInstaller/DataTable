local PaperCutResultView = class("PaperCutResultView", ReduxView)

function PaperCutResultView:UIBackCount()
	return 2
end

function PaperCutResultView:UIName()
	return "UI/EmptyDream/PaperCut/PaperCutResultUI"
end

function PaperCutResultView:UIParent()
	return manager.ui.uiMain.transform
end

function PaperCutResultView:Init()
	self:InitUI()
	self:AddUIListener()
end

function PaperCutResultView:InitUI()
	self:BindCfgUI()

	self.resultImage_ = self.resultImageGo_:GetComponent("PaperCutUIImage")
end

function PaperCutResultView:AddUIListener()
	self:AddBtnListener(self.backMask_, nil, function()
		self:Back()
	end)
end

function PaperCutResultView:OnEnter()
	self.activityID_ = self.params_.activityID
	self.titleText_.text = GetI18NText(PaperCutCfg[self.activityID_].name)

	self:RefreshImage()
	self:RefreshScore()
end

function PaperCutResultView:RefreshImage()
	PaperCutTool:DisplayResultImage(self.resultImage_)

	if self.scorePanelTrans_.localPosition.y >= self.resultImageTrans_.localPosition.y - self.resultImageTrans_.sizeDelta.y * 0.5 then
		self.scorePanelTrans_.localPosition.y = self.resultImageTrans_.localPosition.y - self.resultImageTrans_.sizeDelta.y * 0.5 - 40
		self.scorePanelTrans_.localPosition = self.scorePanelTrans_.localPosition
	end
end

function PaperCutResultView:RefreshScore()
	local var_10_0 = PaperCutTool:CalculateScore()

	PaperCutAction.RequireComplete(self.activityID_, var_10_0)

	self.scoreText_.text = var_10_0 or 0
end

return PaperCutResultView
