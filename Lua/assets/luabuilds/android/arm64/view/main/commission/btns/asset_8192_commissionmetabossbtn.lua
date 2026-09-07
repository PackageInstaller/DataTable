local CommissionMetaBossBtn = class("CommissionMetaBossBtn")

CommissionMetaBossBtn.STATE_LOCK = 1
CommissionMetaBossBtn.STATE_NORMAL = 2
CommissionMetaBossBtn.STATE_AUTO_BATTLE = 3
CommissionMetaBossBtn.STATE_FINSH_BATTLE = 4
CommissionMetaBossBtn.STATE_GET_AWARDS = 5

function CommissionMetaBossBtn:Ctor(arg_1_1, arg_1_2)
	pg.DelegateInfo.New(self)

	self.event = arg_1_2
	self.tr = arg_1_1
	self.text = self.tr:Find("Text"):GetComponent(typeof(Text))
	self.tip = self.tr:Find("tip")
	self.timerIcon = self.tr:Find("timer")
	self.finishIcon = self.tr:Find("finish")

	self:Init()

	return
end

function CommissionMetaBossBtn:Init()
	return
end

function CommissionMetaBossBtn:Flush()
	local var_3_0 = self:GetBossState()

	self:RemoveTimer()

	self.text.text = ""

	if CommissionMetaBossBtn.STATE_AUTO_BATTLE == var_3_0 then
		self:SetLeftTime()
	end

	setActive(self.timerIcon, CommissionMetaBossBtn.STATE_AUTO_BATTLE == var_3_0)
	setActive(self.tip, CommissionMetaBossBtn.STATE_GET_AWARDS == var_3_0 or CommissionMetaBossBtn.STATE_FINSH_BATTLE == var_3_0)
	setActive(self.finishIcon, CommissionMetaBossBtn.STATE_FINSH_BATTLE == var_3_0)
	setActive(self.tr, CommissionMetaBossBtn.STATE_LOCK ~= var_3_0)
	onButton(self, self.tr, function()
		if var_3_0 ~= CommissionMetaBossBtn.STATE_LOCK then
			self.event:emit(CommissionInfoMediator.GO_META_BOSS)
		end

		return
	end, SFX_PANEL)

	return
end

function CommissionMetaBossBtn:SetLeftTime()
	self:RemoveTimer()

	self.timer = Timer.New(function()
		local var_6_0 = WorldBossConst.GetAutoBattleLeftTime()

		if var_6_0 <= 0 then
			self:Flush()
		end

		self.text.text = pg.TimeMgr.GetInstance():DescCDTimeForMinute(var_6_0)

		return
	end, 1, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function CommissionMetaBossBtn:RemoveTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function CommissionMetaBossBtn:GetBossState()
	return WorldBossConst.GetCommissionSceneMetaBossBtnState()
end

function CommissionMetaBossBtn:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:RemoveTimer()

	return
end

return CommissionMetaBossBtn
