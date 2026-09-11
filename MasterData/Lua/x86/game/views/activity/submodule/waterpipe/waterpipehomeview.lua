ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local WaterPipeHomeView = class("WaterPipeHomeView", ActivityMainBasePanel)

function WaterPipeHomeView:GetUIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_WaterPipeUI/WaterPipeEntranceUI"
end

function WaterPipeHomeView:AddListeners()
	self:AddBtnListener(self.btnstartBtn_, nil, function()
		if self:CheckAdvanceOpenTime() then
			return
		end

		JumpTools.OpenPageByJump("/waterPipeSelectView")
	end)
	self:AddBtnListener(self.btnlockBtn_, nil, function()
		local var_4_0, var_4_1 = self:CheckAdvanceOpenTime()

		if var_4_0 then
			ShowTips(var_4_1)
		end
	end)
	self:AddBtnListener(nil, self.descBtn_, function()
		local var_5_0 = {
			content = GetTips("ACTIVITY_WATER_PIPE_GAME_TIP")
		}

		var_5_0.key = "ACTIVITY_WATER_PIPE_GAME_TIP"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
end

function WaterPipeHomeView:Init()
	WaterPipeHomeView.super.Init(self)

	self.openController_ = self.controller_:GetController("isOpen")
end

function WaterPipeHomeView:OnEnter()
	WaterPipeHomeView.super.OnEnter(self)
	manager.redPoint:setRedPoint({
		display = self.btnstartBtn_.transform
	}, manager.redPoint:getTipBoolean(ActivityTools.GetRedPointKey(WaterPipeData:GetMainActivityID()) .. WaterPipeData:GetMainActivityID()), RedPointStyle.NORMAL)
end

function WaterPipeHomeView:OnExit()
	WaterPipeHomeView.super.OnExit(self)
end

function WaterPipeHomeView:RefreshAcvanceStatus(arg_9_1)
	self.openController_:SetSelectedState(arg_9_1 and "open" or "preview")
end

function WaterPipeHomeView:isHasLeftTimeDes()
	return true
end

return WaterPipeHomeView
