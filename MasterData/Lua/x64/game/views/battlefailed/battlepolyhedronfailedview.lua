local BattleMythicFinalFailedView = class("BattleMythicFinalFailedView", BattleFailedView)

function BattleMythicFinalFailedView:UIName()
	return "UI/BattleResult/BattlePolyhedronFailed"
end

function BattleMythicFinalFailedView:InitUI()
	self:BindCfgUI()

	self.stageData = self.params_.stageData
	self.stayTime = 30
end

function BattleMythicFinalFailedView:AddUIListener()
	self:AddBtnListener(self.btnBattleCount_, nil, function()
		if self.isEnd then
			return
		end

		self:RemoveTimer()
		JumpTools.OpenPageByJump("/battleStatisticsPolyhdronOver")
	end)
	self:AddBtnListener(self.m_polyhedronSettlementBtn, nil, function()
		if self.isEnd then
			return
		end

		self:OnceMoreBattle()
	end)
	self:AddBtnListener(self.m_polyhedronReturnBtn, nil, function()
		if self.isEnd then
			return
		end

		self:Quit()
	end)
	self:AddBtnListener(self.m_polyhedronRestartBtn, nil, function()
		if self.isEnd then
			return
		end

		PolyhedronAction.QueryPolyhedronGiveUp(function(arg_8_0)
			if isSuccess(arg_8_0.result) then
				self:Quit()
			else
				self:Quit()
				ShowTips(arg_8_0.result)
			end
		end)
	end)
	self:AddBtnListener(self.mask_, nil, function()
		if self.isEnd then
			return
		end

		if Time.realtimeSinceStartup - self.startTime < 2 then
			return
		end

		self:Quit()
	end)
end

function BattleMythicFinalFailedView:OnEnter()
	BattleInstance.hideBattlePanel()
	self:RecordThreeStar()

	self.startTime = Time.realtimeSinceStartup
	self.isEnd = false

	self:RemoveTimer()

	self.battleTimeText_.text = self:GetBattleTime()

	self.animator_:Play("battleFailed")
end

function BattleMythicFinalFailedView:OnceMoreBattle()
	self.isEnd = true

	self:RemoveTimer()

	self.timer_ = Timer.New(function()
		BattleInstance.OnceMoreBattle(self.stageData)
	end, 1, 1)

	self.timer_:Start()
	self.animator_:Play("battleFailed_out")
end

return BattleMythicFinalFailedView
