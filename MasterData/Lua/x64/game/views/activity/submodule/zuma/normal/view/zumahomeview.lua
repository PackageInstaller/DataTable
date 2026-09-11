ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ZumaHomeView = class("ZumaHomeView", ActivityMainBasePanel)

function ZumaHomeView:GetUIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaMainUI"
end

function ZumaHomeView:AddListeners()
	self:AddBtnListener(self.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/springFestivalZumaMainView", {})
	end)
	self:AddBtnListener(nil, self.descBtn_, function()
		local var_4_0 = {
			content = GetTips("ACTIVITY_ZUMA_DESC")
		}

		var_4_0.key = "ACTIVITY_ZUMA_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_4_0)
	end)
end

function ZumaHomeView:OnEnter()
	ZumaHomeView.super.OnEnter(self)
	ZumaData:SetZumaActivityID(self.activityID_)
	manager.redPoint:bindUIandKey(self.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

function ZumaHomeView:OnExit()
	ZumaHomeView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btnstartBtn_.transform, RedPointConst.ZUMA .. ActivityConst.ACTIVITY_ZUMA)
end

return ZumaHomeView
