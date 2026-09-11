ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local TetrisGameHomeView = class("TetrisGameHomeView", ActivityMainBasePanel)

function TetrisGameHomeView:GetUIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameEntranceUI"
end

function TetrisGameHomeView:Init()
	TetrisGameHomeView.super.Init(self)

	self.btnController_ = self.btnControllerEx_:GetController("statelock01")
end

function TetrisGameHomeView:AddListeners()
	self:AddBtnListener(self.btnstartBtn_, nil, function()
		JumpTools.OpenPageByJump("/tetrisGameMainView")
	end)
	self:AddBtnListener(nil, self.infobtn, function()
		local var_5_0 = {
			content = GetTips("TETRIS_GAME_HOME_DESC")
		}

		var_5_0.key = "TETRIS_GAME_HOME_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_5_0)
	end)
end

function TetrisGameHomeView:RefreshAcvanceStatus(arg_6_1)
	if arg_6_1 then
		self.btnController_:SetSelectedState("normal01")
	else
		self.btnController_:SetSelectedState("lock01")
	end
end

function TetrisGameHomeView:OnEnter()
	TetrisGameHomeView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.btnstartBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function TetrisGameHomeView:OnExit()
	TetrisGameHomeView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btnstartBtn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

return TetrisGameHomeView
