local BattleFailedWithButtonView = class("BattleFailedWithButtonView", ReduxView)

function BattleFailedWithButtonView:UIName()
	return "UI/BattleResult/BattleFailed"
end

function BattleFailedWithButtonView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleFailedWithButtonView:Init()
	self:BindCfgUI()
	self:AddUIListener()

	self.controller_ = ControllerUtil.GetController(self.transform_, "failedType")

	self.controller_:SetSelectedState("keep")
end

function BattleFailedWithButtonView:OnEnter()
	BattleInstance.hideBattlePanel()

	self.startTime_ = Time.realtimeSinceStartup
	self.isEnd_ = false
	self.battleTimeText_.text = self:GetBattleTime()

	self.animator_:Play("battleFailed")
end

function BattleFailedWithButtonView:OnExit()
	self:RemoveTimer()
end

function BattleFailedWithButtonView:Dispose()
	BattleFailedWithButtonView.super.Dispose(self)
end

function BattleFailedWithButtonView:AddUIListener()
	self:AddBtnListener(self.keepBtn_, nil, function()
		self:OnClickKeep()
	end)
	self:AddBtnListener(self.giveupBtn_, nil, function()
		self:OnClickBack()
	end)
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		if self.isEnd then
			return
		end

		self:RemoveTimer()
		JumpTools.OpenPageByJump("battleStatistics", {
			stageData = self.stageData,
			battleTime = self:GetBattleTime()
		})
	end)
end

function BattleFailedWithButtonView:GetBattleTime()
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function BattleFailedWithButtonView:OnClickKeep()
	self:Quit()
end

function BattleFailedWithButtonView:OnClickBack()
	self:Quit()
end

function BattleFailedWithButtonView:Quit()
	self.isEnd_ = true

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		BattleInstance.QuitBattle(self.params_.stageData, true, true)
	end, 1, 1)

	self.timer_:Start()
	self.animator_:Play("battleFailed_out")
end

function BattleFailedWithButtonView:RemoveTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return BattleFailedWithButtonView
