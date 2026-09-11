local BattleBossChallengeBossItem = class("BattleBossChallengeBossItem", ReduxView)

function BattleBossChallengeBossItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	SetActive(self.gameObject_, true)

	self.bossIndex_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "bossItem")
end

function BattleBossChallengeBossItem:OnEnter()
	self:RefreshUI()
	self:AddTimer()
	self:AddDelayTimer()
end

function BattleBossChallengeBossItem:OnExit()
	self:StopTimer()
	self:StopDelayTimer()
end

function BattleBossChallengeBossItem:Dispose()
	SetActive(self.gameObject_, false)
	BattleBossChallengeBossItem.super.Dispose(self)
	self:RemoveListeners()

	self.gameObject_ = nil
	self.transform_ = nil
end

function BattleBossChallengeBossItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			ShowTips(string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr((BattleBossChallengeNormalData:GetBossUnlockTime(self.bossIndex_)))))
		else
			self:Go("/bossChallenge", {
				bossIndex = self.bossIndex_
			})
		end
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_NORMAL_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetNormalModeBoss(self.bossIndex_, function(arg_9_0)
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

function BattleBossChallengeBossItem:RemoveListeners()
	return
end

function BattleBossChallengeBossItem:RefreshUI()
	local var_11_0 = BossChallengeUICfg[StageGroupCfg[BattleBossChallengeNormalData:GetBossList()[self.bossIndex_]].boss_id]

	self.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, var_11_0.icon))
	self.textName_.text = GetI18NText(var_11_0.main_name)
	self.textLv_.text = GetTips("BOSS_LEVEL_" .. StageTools.GetBossChallengeNextIndex(self.bossIndex_))

	self:RefreshResetBtn()
end

function BattleBossChallengeBossItem:RefreshResetBtn()
	if table.length(BattleBossChallengeNormalData:GetReceiveStarList()) > 0 then
		SetActive(self.resetGo_, false)

		return
	end

	if table.length(BattleBossChallengeNormalData:GetLockHero()[self.bossIndex_]) > 0 then
		SetActive(self.resetGo_, true)
	else
		SetActive(self.resetGo_, false)
	end
end

function BattleBossChallengeBossItem:Show(arg_13_1)
	SetActive(self.gameObject_, arg_13_1)
end

function BattleBossChallengeBossItem:RefreshLock(arg_14_1)
	if arg_14_1 then
		self.controller_:SetSelectedState("lock")
	else
		self.controller_:SetSelectedState("false")
	end
end

function BattleBossChallengeBossItem:AddTimer()
	self:StopTimer()

	local var_15_0 = BattleBossChallengeNormalData:GetBossUnlockTime(self.bossIndex_)
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

function BattleBossChallengeBossItem:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function BattleBossChallengeBossItem:AddDelayTimer()
	self:StopDelayTimer()
	self:Show(false)

	self.delayTimer_ = Timer.New(function()
		self:Show(true)
	end, 0.1 * (self.bossIndex_ - 1), 1)

	self.delayTimer_:Start()
end

function BattleBossChallengeBossItem:StopDelayTimer()
	if self.delayTimer_ then
		self.delayTimer_:Stop()

		self.delayTimer_ = nil
	end
end

return BattleBossChallengeBossItem
