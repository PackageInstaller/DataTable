local BattleMatrixFailedView = class("BattleMatrixFailedView", BattleFailedView)

function BattleMatrixFailedView:UIName()
	return "UI/BattleResult/BattleMatrixFailed"
end

function BattleMatrixFailedView:InitUI()
	self:BindCfgUI()

	self.stageData = self.params_.stageData
	self.stayTime = 20
end

function BattleMatrixFailedView:AddUIListener()
	self:AddBtnListener(self.m_backBtn, nil, function()
		if self.isEnd then
			return
		end

		if Time.realtimeSinceStartup - self.startTime < 2 then
			return
		end

		self:Quit()
	end)
	self:AddBtnListener(self.m_againBtn, nil, function()
		if self.isEnd then
			return
		end

		if self.stageData then
			self:OnceMoreBattle()
		else
			self:Quit()
		end
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

function BattleMatrixFailedView:OnEnter()
	BattleMatrixFailedView.super.OnEnter(self)
	TimeTools.StartAfterSeconds(0.033, function()
		self.m_canvas.alpha = 1
	end, {})
end

function BattleMatrixFailedView:OnceMoreBattle()
	self.isEnd = true

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		BattleInstance.OnceMoreBattle(self.stageData)
	end, 1, 1)

	self.timer_:Start()
	self.animator_:Play("battleFailed_out")
end

return BattleMatrixFailedView
