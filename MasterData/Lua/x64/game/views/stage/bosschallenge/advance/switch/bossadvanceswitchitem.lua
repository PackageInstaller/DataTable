local BossAdvanceSwitchItem = class("BossAdvanceSwitchItem", ReduxView)

function BossAdvanceSwitchItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.bossIndex_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "bossItem")
end

function BossAdvanceSwitchItem:OnEnter()
	self:RefreshUI()
	self:AddTimer()
	self:AddDelayTimer()
end

function BossAdvanceSwitchItem:OnExit()
	self:StopTimer()
	self:StopDelayTimer()
end

function BossAdvanceSwitchItem:Dispose()
	BossAdvanceSwitchItem.super.Dispose(self)
	self:RemoveListeners()
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function BossAdvanceSwitchItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].timestamp)))
		else
			self:Go("/bossAdvanceInfo", {
				bossIndex = self.bossIndex_
			})
		end
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetHardModeBoss(self.bossIndex_, function(arg_9_0)
					if isSuccess(arg_9_0.result) then
						self:RefreshUI()
					else
						ShowTips(arg_9_0.result)
					end
				end)
			end
		})
	end)
end

function BossAdvanceSwitchItem:RemoveListeners()
	return
end

function BossAdvanceSwitchItem:RefreshUI()
	local var_11_0 = BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_]

	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, BossChallengeUICfg[var_11_0.templateID].icon))
	self.nameText_.text = GetI18NText(BossChallengeUICfg[var_11_0.templateID].main_name)
	self.weaknessText_.text = GetI18NText(BossChallengeUICfg[var_11_0.templateID].weakness)
	self.numText_.text = string.format("NO.%02d", self.bossIndex_)
	self.pointText_.text = var_11_0.maxPoint
	self.transform_.localPosition = Vector3(BossChallengeAdvancePosCfg[self.bossIndex_].position[1], BossChallengeAdvancePosCfg[self.bossIndex_].position[2], 0)

	self:RefreshResetBtn()
	self:Show(true)
end

function BossAdvanceSwitchItem:RefreshResetBtn()
	if #BattleBossChallengeAdvanceData:GetReceiveRewardList() > 0 then
		SetActive(self.resetGo_, false)

		return
	end

	if BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].maxPoint > 0 then
		SetActive(self.resetGo_, true)
	else
		SetActive(self.resetGo_, false)
	end
end

function BossAdvanceSwitchItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function BossAdvanceSwitchItem:RefreshLock(arg_14_1)
	if arg_14_1 then
		self.controller_:SetSelectedState("lock")
	else
		self.controller_:SetSelectedState("false")
	end
end

function BossAdvanceSwitchItem:AddTimer()
	self:StopTimer()

	local var_15_0 = BattleBossChallengeAdvanceData:GetBossList()[self.bossIndex_].timestamp
	local var_15_1 = var_15_0 > manager.time:GetServerTime()

	self:RefreshLock(var_15_1)

	self.isLock_ = var_15_1

	if var_15_1 then
		self.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_15_0))
		self.timer_ = Timer.New(function()
			self.timeText_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr(var_15_0))

			if manager.time:GetServerTime() >= var_15_0 then
				self:StopTimer()

				self.isLock_ = false

				self:RefreshLock(false)
			end
		end, 1, -1)

		self.timer_:Start()
	end
end

function BossAdvanceSwitchItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BossAdvanceSwitchItem:AddDelayTimer()
	self:StopDelayTimer()
	self:Show(false)

	self.delayTimer_ = Timer.New(function()
		self:Show(true)
	end, 0.1 * (self.bossIndex_ - 1), 1)

	self.delayTimer_:Start()
end

function BossAdvanceSwitchItem:StopDelayTimer()
	if self.delayTimer_ then
		self.delayTimer_:Stop()

		self.delayTimer_ = nil
	end
end

return BossAdvanceSwitchItem
