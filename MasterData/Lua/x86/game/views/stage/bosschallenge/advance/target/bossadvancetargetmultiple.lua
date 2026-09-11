local BossAdvanceTargetMultiple = class("BossAdvanceTargetMultiple", ReduxView)

function BossAdvanceTargetMultiple:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "Item")
	self.switchMultipleHandler_ = handler(self, self.SwitchMultiple)

	manager.notify:RegistListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, self.switchMultipleHandler_)
end

function BossAdvanceTargetMultiple:Dispose()
	BossAdvanceTargetMultiple.super.Dispose(self)
	manager.notify:RemoveListener(BOSS_CHALLENGE_CHOOSE_MULTIPLE, self.switchMultipleHandler_)

	self.switchMultipleHandler_ = nil
end

function BossAdvanceTargetMultiple:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		BattleBossChallengeAdvanceData:SetBossMultipleIndex(self.bossIndex_, self.index_)
		manager.notify:Invoke(BOSS_CHALLENGE_CHOOSE_MULTIPLE, self.index_)
	end)
end

function BossAdvanceTargetMultiple:SetData(arg_5_1, arg_5_2)
	self.bossIndex_ = arg_5_1
	self.index_ = arg_5_2

	self:RefreshUI()
end

function BossAdvanceTargetMultiple:RefreshUI()
	self:SwitchMultiple(BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].multipleIndex)

	self.nameText_.text = string.format("%s%s", GetTips("HARDLEVEL"), GetTips(string.format("NUM_%s", self.index_)))
	self.pointText_.text = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].difficult_point[self.index_]
end

function BossAdvanceTargetMultiple:SwitchMultiple(arg_7_1)
	if self.index_ == arg_7_1 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

return BossAdvanceTargetMultiple
