ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local CORGFlipCardHomeView = class("CORGFlipCardHomeView", ActivityMainBasePanel)

function CORGFlipCardHomeView:GetUIName()
	return XH3rdFlipCardTool:GetHomeUI()
end

function CORGFlipCardHomeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function CORGFlipCardHomeView:InitUI()
	self:BindCfgUI()
end

function CORGFlipCardHomeView:AddUIListener()
	self:BindHelpBtn(XH3rdFlipCardTool:GetHelpTips(XH3rdFlipCardData:GetActivityID()), self.tipsBtn_)
	self:AddBtnListener(self.playBtn_, nil, function()
		if not self:IsActivityTime() then
			ShowTips("TIME_OVER")

			return
		end

		if XH3rdFlipCardData:GetActivityID() == ActivityConst.ACTIVITY_4_5_FLIPCARD then
			JumpTools.OpenPageByJump("/xH3rdFlipCardGame_4_5", {
				activityId = XH3rdFlipCardData:GetActivityID()
			})
		else
			JumpTools.OpenPageByJump("/xH3rdFlipCardGame", {
				activityId = XH3rdFlipCardData:GetActivityID()
			})
		end

		XH3rdFlipCardAction.hasEnterGame = true
	end)
end

function CORGFlipCardHomeView:Dispose()
	CORGFlipCardHomeView.super.Dispose(self)
end

function CORGFlipCardHomeView:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)

	if arg_7_1 then
		self:UpdatePreview()
		manager.redPoint:bindUIandKey(self.playBtn_.transform, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityID_))
		self:RegistEventListener(OSIRIS_TASK_UPDATE, self.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(self.playBtn_.transform, string.format("%s_%s_challenge", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityID_))
		self:RemoveAllEventListener()
	end
end

function CORGFlipCardHomeView:UpdateData()
	self:RefreshUI()
end

function CORGFlipCardHomeView:OnExit()
	self:StopTimer()
end

return CORGFlipCardHomeView
