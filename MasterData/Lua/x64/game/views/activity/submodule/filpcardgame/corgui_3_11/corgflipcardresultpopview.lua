local CORGflipCardResultPopView = class("CORGflipCardResultPopView", ReduxView)

function CORGflipCardResultPopView:UIName()
	return XH3rdFlipCardTool:GetResultUI()
end

function CORGflipCardResultPopView:UIParent()
	return manager.ui.uiPop.transform
end

function CORGflipCardResultPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CORGflipCardResultPopView:InitUI()
	self:BindCfgUI()

	self.resultController_ = self.controller_:GetController("result")
end

function CORGflipCardResultPopView:AddUIListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		local var_6_0 = XH3rdFlipCardTool:GetIsSuccess()

		XH3rdFlipCardTool:ResetGame()
		self:Back()
	end)
end

function CORGflipCardResultPopView:OnEnter()
	self.clueID_ = self.params_.clueID or 0

	self:RefreshUI()
end

function CORGflipCardResultPopView:RefreshUI()
	if XH3rdFlipCardTool.GetIsSuccess() then
		self.useTimeText_.text = string.format(GetTips("ACTIVITY_FLIP_CARD_TIME_COST"), XH3rdFlipCardTool:GetUseTime())

		if self.clueID_ ~= 0 then
			SetActive(self.successClueGo_, true)
		else
			SetActive(self.successClueGo_, false)
		end

		self.resultController_:SetSelectedState("win")
	else
		self.resultController_:SetSelectedState("lose")
	end
end

function CORGflipCardResultPopView:Dispose()
	CORGflipCardResultPopView.super.Dispose(self)
end

function CORGflipCardResultPopView:OnExit()
	return
end

return CORGflipCardResultPopView
