local NewWarChessEnterView = class("NewWarChessEnterView", ReduxView)

function NewWarChessEnterView:UIName()
	return "UI/NewWarChess/NewWarChessGo"
end

function NewWarChessEnterView:UIParent()
	return manager.ui.uiMain.transform
end

function NewWarChessEnterView:Init()
	return
end

function NewWarChessEnterView:OnEnter()
	self.timer_ = Timer.New(function()
		self:StopTimer()

		if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN") == 0 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_START, {})
			manager.NewChessManager:StartExecuteEvent()
		end

		gameContext:Go("/newWarChessHome")
	end, 1.2, 1)

	self.timer_:Start()
end

function NewWarChessEnterView:OnExit()
	self:StopTimer()
end

function NewWarChessEnterView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function NewWarChessEnterView:Dispose()
	self:StopTimer()
	NewWarChessEnterView.super.Dispose(self)
end

return NewWarChessEnterView
