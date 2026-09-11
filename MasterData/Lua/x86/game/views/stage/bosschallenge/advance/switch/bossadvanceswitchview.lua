local BossAdvanceSwitchView = class("BossAdvanceSwitchView", ReduxView)

function BossAdvanceSwitchView:UIName()
	return "Widget/System/Challenge_Boss/BossAdvanceSwitchUI"
end

function BossAdvanceSwitchView:UIParent()
	return manager.ui.uiMain.transform
end

function BossAdvanceSwitchView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.bossItemList_ = {}
	self.challengeUpdateHandler_ = handler(self, self.UpdateBossChallenge)
	self.challengeInitHandler_ = handler(self, self.RefreshUI)
end

function BossAdvanceSwitchView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
	BossTools.CheckTimeout()
	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_UPDATE, self.challengeInitHandler_)

	for iter_4_0, iter_4_1 in ipairs(self.bossItemList_) do
		iter_4_1:OnEnter()
	end

	if not manager.guide:IsPlaying() then
		self:CheckMail(self.CheckRewardPreview)
	end
end

function BossAdvanceSwitchView:OnUpdate()
	self:RefreshResetBtn()

	for iter_5_0, iter_5_1 in pairs(self.bossItemList_) do
		iter_5_1:RefreshResetBtn()
	end
end

function BossAdvanceSwitchView:CheckMail(arg_6_1)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS)
				arg_6_1()
			end
		})
	else
		arg_6_1()
	end
end

function BossAdvanceSwitchView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_UPDATE, self.challengeInitHandler_)

	for iter_8_0, iter_8_1 in ipairs(self.bossItemList_) do
		iter_8_1:OnExit()
	end
end

function BossAdvanceSwitchView:Dispose()
	BossAdvanceSwitchView.super.Dispose(self)

	self.challengeUpdateHandler_ = nil
	self.challengeInitHandler_ = nil

	for iter_9_0, iter_9_1 in pairs(self.bossItemList_) do
		iter_9_1:Dispose()
	end

	self.bossItemList_ = nil
end

function BossAdvanceSwitchView:AddListeners()
	self:AddBtnListener(self.buttonShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DREAM_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	self:AddBtnListener(self.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET_MODE"),
			OkCallback = function()
				BattleBossChallengeAction.ResetHardMode(function(arg_15_0)
					if isSuccess(arg_15_0.result) then
						gameContext:OverrideUrl("/bossSwitch", "/bossMode", nil, "home")
						gameContext:OverrideUrl("/bossAdvanceSwitch", "/bossMode", nil, "home")
						gameContext:Go("/bossMode")
					else
						ShowTips(arg_15_0.result)
					end
				end)
			end
		})
	end)
end

function BossAdvanceSwitchView:RefreshUI()
	self.nameText_.text = GetI18NText(BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()].name2)

	self:RefreshBossBtnList()
	self:AddUpdateTimer()
	self:ClacuteScrollWidth()
	self:RefreshResetBtn()
end

function BossAdvanceSwitchView:CheckRewardPreview()
	if not BossTools.IsFirstEnterUI(BossConst.MODE_HARD) then
		return
	end

	local var_17_0 = BossChallengeAdvanceCfg[BattleBossChallengeAdvanceData:GetChooseModeID()]
	local var_17_1 = 0
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0.reward) do
		var_17_1 = iter_17_1[1]
		var_17_2 = mergeRewardList(var_17_2, getRewardFromDropCfg(iter_17_1[2], true))
	end

	JumpTools.OpenPageByJump("bossChallengeRewardPreview", {
		titleText = string.format("%s", var_17_0.name2),
		targetText = string.format(GetTips("BOSS_CHALLENGE_REWARD_TARGET_2"), var_17_1),
		rewardList = sortReward((formatRewardCfgList(var_17_2)))
	})
	BossTools.SaveFirstEnterUIValue(BossConst.MODE_HARD)
end

function BossAdvanceSwitchView:RefreshResetBtn()
	SetActive(self.resetGo_, #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0)
end

function BossAdvanceSwitchView:UpdateBossChallenge()
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function BossAdvanceSwitchView:RefreshBossBtnList()
	local var_20_0 = BattleBossChallengeAdvanceData:GetBossList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if self.bossItemList_[iter_20_0] then
			self.bossItemList_[iter_20_0]:RefreshUI()
		else
			self.bossItemList_[iter_20_0] = BossAdvanceSwitchItem.New(self.goItem_, self.itemParent_, iter_20_0)
		end
	end

	for iter_20_2 = #self.bossItemList_, #var_20_0 + 1, -1 do
		self.bossItemList_[iter_20_2]:OnExit()
		self.bossItemList_[iter_20_2]:Dispose()

		self.bossItemList_[iter_20_2] = nil
	end
end

function BossAdvanceSwitchView:AddUpdateTimer()
	self:RemoveUpdateTimer()

	local var_21_0 = BattleBossChallengeData:GetNextRefreshTime()

	self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_21_0)
	self.updateTimer_ = Timer.New(function()
		local var_22_0 = BattleBossChallengeData:GetNextRefreshTime()

		if var_22_0 ~= var_21_0 then
			self:RemoveUpdateTimer()
		end

		self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_22_0)
	end, 1, -1)

	self.updateTimer_:Start()
end

function BossAdvanceSwitchView:RemoveUpdateTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

function BossAdvanceSwitchView:ClacuteScrollWidth()
	self.parentRect_.sizeDelta = Vector2(BossChallengeAdvancePosCfg[#BattleBossChallengeAdvanceData:GetBossList()].position[1] - self.viewportRect_.rect.width + self.viewportRect_.rect.width / 4, 707)
end

return BossAdvanceSwitchView
