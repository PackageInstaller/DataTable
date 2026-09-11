local BattleVictoryView = class("BattleVictoryView", ReduxView)

function BattleVictoryView:UIName()
	return "UI/BattleVictory"
end

function BattleVictoryView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleVictoryView:OnCtor()
	return
end

function BattleVictoryView:InitUI()
	self.bg_screen_ = self:FindCom(typeof(Image), "bg_screen")
	self.bg_screen_.enabled = false
	self.mask_ = self:FindCom(typeof(Button), "bg")
	self.timer_ = Timer.New(function()
		self.timer_:Stop()
		self:Back()
		manager.newPlayerGuide:FinishStep()
	end, 1.5, 1)

	self.timer_:Start()
end

function BattleVictoryView:AddUIListener()
	self:AddBtnListener(self.mask_, nil, function()
		self.timer_:Stop()
		self:Back()
		manager.newPlayerGuide:FinishStep()
	end)
end

function BattleVictoryView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BattleVictoryView:Dispose()
	BattleVictoryView.super.Dispose(self)
end

return BattleVictoryView
