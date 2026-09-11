local BossSwitchView = class("BossSwitchView", ReduxView)

function BossSwitchView:UIName()
	return "Widget/System/Challenge_Boss/BossSwitchUI"
end

function BossSwitchView:UIParent()
	return manager.ui.uiMain.transform
end

function BossSwitchView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.bossItemList_ = {}
	self.bossGoList_ = {
		self.goItem1_,
		self.goItem2_,
		self.goItem3_
	}
end

function BossSwitchView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")
	BossTools.CheckTimeout()
	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)

	self.challengeUpdateHandler_ = handler(self, self.UpdateBossChallenge)

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)

	self.challengeInitHandler_ = handler(self, self.RefreshUI)

	manager.notify:RegistListener(BOSS_CHALLENGE_UPDATE, self.challengeInitHandler_)

	for iter_4_0, iter_4_1 in ipairs(self.bossItemList_) do
		iter_4_1:OnEnter()
	end

	self:CheckMail(self.CheckRewardPreview)
end

function BossSwitchView:CheckMail(arg_5_1)
	if PlayerData:GetUnclaimed(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS) ~= nil then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("UNCLAIMED_BONUS_MAIL_TIP"),
			OkCallback = function()
				PlayerAction.ReadUnclaimedMessage(MailConst.MAIL_CHALLENGE_COMPENSATE_ID.BOSS)
				arg_5_1()
			end
		})
	else
		arg_5_1()
	end
end

function BossSwitchView:OnTop()
	self:RefreshUI()
end

function BossSwitchView:OnExit()
	manager.windowBar:HideBar()
	self:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(self.transformStar_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_UPDATE, self.challengeInitHandler_)

	self.challengeUpdateHandler_ = nil
	self.challengeInitHandler_ = nil

	for iter_8_0, iter_8_1 in ipairs(self.bossItemList_) do
		iter_8_1:OnExit()
	end
end

function BossSwitchView:Dispose()
	BossSwitchView.super.Dispose(self)

	for iter_9_0, iter_9_1 in pairs(self.bossItemList_) do
		iter_9_1:Dispose()
	end

	self.bossItemList_ = nil
end

function BossSwitchView:AddListeners()
	self:AddBtnListener(self.buttonShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DREAM_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossStarExchange")
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

function BossSwitchView:RefreshUI()
	self:RefreshText()
	self:RefreshBossBtnList()
	self:AddUpdateTimer()
	self:RefreshStar()
	self:RefreshResetBtn()
end

function BossSwitchView:CheckRewardPreview()
	if not GuideData:IsFinish(1301) then
		return
	end

	if not BossTools.IsFirstEnterUI(BossConst.MODE_NORMAL) then
		return
	end

	local var_17_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_17_1 = 0
	local var_17_2 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0.reward) do
		var_17_1 = iter_17_1[1]
		var_17_2 = mergeRewardList(var_17_2, getRewardFromDropCfg(iter_17_1[2], true))
	end

	JumpTools.OpenPageByJump("bossChallengeRewardPreview", {
		titleText = string.format("%s·%s", GetI18NText(BossChallengeAdvanceCfg[3].name), GetI18NText(var_17_0.name)),
		targetText = string.format(GetTips("BOSS_CHALLENGE_REWARD_TARGET"), var_17_1),
		rewardList = sortReward((formatRewardCfgList(var_17_2)))
	})
	BossTools.SaveFirstEnterUIValue(BossConst.MODE_NORMAL)
end

function BossSwitchView:RefreshResetBtn()
	SetActive(self.resetGo_, table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 and #BattleBossChallengeData:GetOpenModeList() > 0)
end

function BossSwitchView:UpdateBossChallenge()
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function BossSwitchView:RefreshText()
	local var_20_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()

	self.textLv_.text = string.format("(%s%s~%s)", GetTips("LEVEL"), var_20_0.level[1], var_20_0.level[2])
	self.textName_.text = GetI18NText(var_20_0.name)
end

function BossSwitchView:RefreshStar()
	local var_21_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_21_1 = var_21_0.reward[#var_21_0.reward][1]
	local var_21_2 = BattleBossChallengeNormalData:GetReceiveStarList()

	for iter_21_0 = 1, #var_21_0.reward do
		if not table.keyof(var_21_2, var_21_0.reward[iter_21_0][1]) then
			var_21_1 = var_21_0.reward[iter_21_0][1]

			break
		end
	end

	self.textCurStar_.text = StageTools.CalcBossChallengeStar()
	self.textTotalStar_.text = string.format("/%s", var_21_1)
end

function BossSwitchView:RefreshBossBtnList()
	local var_22_0 = BattleBossChallengeNormalData:GetBossList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if self.bossItemList_[iter_22_0] then
			self.bossItemList_[iter_22_0]:RefreshUI()
		else
			self.bossItemList_[iter_22_0] = BattleBossChallengeBossItem.New(self.bossGoList_[iter_22_0], iter_22_0)
		end
	end

	for iter_22_2 = #self.bossItemList_, #var_22_0 + 1, -1 do
		self.bossItemList_[iter_22_2]:OnExit()
		self.bossItemList_[iter_22_2]:Dispose()

		self.bossItemList_[iter_22_2] = nil
	end
end

function BossSwitchView:AddUpdateTimer()
	self:RemoveUpdateTimer()

	local var_23_0 = BattleBossChallengeData:GetNextRefreshTime()

	self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_23_0)
	self.updateTimer_ = Timer.New(function()
		local var_24_0 = BattleBossChallengeData:GetNextRefreshTime()

		if var_23_0 ~= var_24_0 then
			self:RemoveUpdateTimer()
		end

		self.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_24_0)
	end, 1, -1)

	self.updateTimer_:Start()
end

function BossSwitchView:RemoveUpdateTimer()
	if self.updateTimer_ then
		self.updateTimer_:Stop()

		self.updateTimer_ = nil
	end
end

return BossSwitchView
