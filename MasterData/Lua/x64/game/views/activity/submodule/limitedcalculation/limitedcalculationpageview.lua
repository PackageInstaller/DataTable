ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local LimitedCalculationPageView = class("LimitedCalculationPageView", ActivityMainBasePanel)

function LimitedCalculationPageView:GetUIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10ArtifactUI/JapanRegionUI_2_10ArtifactMainUI"
end

function LimitedCalculationPageView:OnEnter()
	LimitedCalculationPageView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function LimitedCalculationPageView:OnExit()
	LimitedCalculationPageView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function LimitedCalculationPageView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ActivityTools.JumpToSubmodulePage(self.activityID_)
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		local var_6_0 = LimitedCalculationTools.GetGameHelpKey(self.activiytID_)

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_6_0),
			key = var_6_0
		})
	end)
end

return LimitedCalculationPageView
