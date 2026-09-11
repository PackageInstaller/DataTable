local SailEnterView = class("SailEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function SailEnterView:GetUIName()
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHomeUI"
end

function SailEnterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SailEnterView:InitUI()
	self:BindCfgUI()
end

function SailEnterView:OnEnter()
	SailEnterView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME, self.activityID_)))
end

function SailEnterView:OnExit()
	SailEnterView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, (string.format("%s_%s", RedPointConst.SAIL_GAME, self.activityID_)))
end

function SailEnterView:AddUIListener()
	self:AddBtnListener(self.goBtn_, nil, function()
		if not self:IsActivityTime() then
			return
		end

		SailGameData:SetSelectedMainBtn(self.activityID_)
		JumpTools.OpenPageByJump("/sailMain", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SKADI_SEA_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")
		})
	end)
end

return SailEnterView
