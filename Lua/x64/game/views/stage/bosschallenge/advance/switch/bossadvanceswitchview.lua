local var_0_0 = class("BossAdvanceSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossAdvanceSwitchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.bossItemList_ = {}
	arg_3_0.challengeUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateBossChallenge)
	arg_3_0.challengeInitHandler_ = handler(arg_3_0, arg_3_0.RefreshUI)
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")
	BossTools.CheckTimeout()
	arg_4_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_4_0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_4_0.challengeUpdateHandler_)
	manager.notify:RegistListener(BOSS_CHALLENGE_UPDATE, arg_4_0.challengeInitHandler_)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.bossItemList_) do
		iter_4_1:OnEnter()
	end

	if not manager.guide:IsPlaying() then
		arg_4_0:CheckMail(arg_4_0.CheckRewardPreview)
	end
end

function var_0_0.OnUpdate(arg_5_0)
	arg_5_0:RefreshResetBtn()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.bossItemList_) do
		iter_5_1:RefreshResetBtn()
	end
end

function var_0_0.CheckMail(arg_6_0, arg_6_1)
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

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(arg_8_0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_8_0.challengeUpdateHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_UPDATE, arg_8_0.challengeInitHandler_)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.bossItemList_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

	arg_9_0.challengeUpdateHandler_ = nil
	arg_9_0.challengeInitHandler_ = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.bossItemList_) do
		iter_9_1:Dispose()
	end

	arg_9_0.bossItemList_ = nil
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.buttonShop_, nil, function()
		JumpTools.GoToSystem("/shop", {
			shopId = ShopConst.SHOP_ID.DREAM_SHOP
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_10_0:AddBtnListener(arg_10_0.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	arg_10_0:AddBtnListener(arg_10_0.resetBtn_, nil, function()
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

function var_0_0.RefreshUI(arg_16_0)
	local var_16_0 = BattleBossChallengeAdvanceData:GetChooseModeID()
	local var_16_1 = BossChallengeAdvanceCfg[var_16_0]

	arg_16_0.nameText_.text = GetI18NText(var_16_1.name2)

	arg_16_0:RefreshBossBtnList()
	arg_16_0:AddUpdateTimer()
	arg_16_0:ClacuteScrollWidth()
	arg_16_0:RefreshResetBtn()
end

function var_0_0.CheckRewardPreview(arg_17_0)
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

	local var_17_3 = formatRewardCfgList(var_17_2)
	local var_17_4 = sortReward(var_17_3)
	local var_17_5 = string.format("%s", var_17_0.name2)
	local var_17_6 = GetTips("BOSS_CHALLENGE_REWARD_TARGET_2")
	local var_17_7 = string.format(var_17_6, var_17_1)

	JumpTools.OpenPageByJump("bossChallengeRewardPreview", {
		titleText = var_17_5,
		targetText = var_17_7,
		rewardList = var_17_4
	})
	BossTools.SaveFirstEnterUIValue(BossConst.MODE_HARD)
end

function var_0_0.RefreshResetBtn(arg_18_0)
	local var_18_0 = #BattleBossChallengeAdvanceData:GetReceiveRewardList() <= 0

	SetActive(arg_18_0.resetGo_, var_18_0)
end

function var_0_0.UpdateBossChallenge(arg_19_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function var_0_0.RefreshBossBtnList(arg_20_0)
	local var_20_0 = BattleBossChallengeAdvanceData:GetBossList()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if arg_20_0.bossItemList_[iter_20_0] then
			arg_20_0.bossItemList_[iter_20_0]:RefreshUI()
		else
			arg_20_0.bossItemList_[iter_20_0] = BossAdvanceSwitchItem.New(arg_20_0.goItem_, arg_20_0.itemParent_, iter_20_0)
		end
	end

	for iter_20_2 = #arg_20_0.bossItemList_, #var_20_0 + 1, -1 do
		arg_20_0.bossItemList_[iter_20_2]:OnExit()
		arg_20_0.bossItemList_[iter_20_2]:Dispose()

		arg_20_0.bossItemList_[iter_20_2] = nil
	end
end

function var_0_0.AddUpdateTimer(arg_21_0)
	arg_21_0:RemoveUpdateTimer()

	local var_21_0 = BattleBossChallengeData:GetNextRefreshTime()

	arg_21_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_21_0)
	arg_21_0.updateTimer_ = Timer.New(function()
		local var_22_0 = BattleBossChallengeData:GetNextRefreshTime()

		if var_22_0 ~= var_21_0 then
			arg_21_0:RemoveUpdateTimer()
		end

		arg_21_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_22_0)
	end, 1, -1)

	arg_21_0.updateTimer_:Start()
end

function var_0_0.RemoveUpdateTimer(arg_23_0)
	if arg_23_0.updateTimer_ then
		arg_23_0.updateTimer_:Stop()

		arg_23_0.updateTimer_ = nil
	end
end

function var_0_0.ClacuteScrollWidth(arg_24_0)
	local var_24_0 = BattleBossChallengeAdvanceData:GetBossList()
	local var_24_1 = BossChallengeAdvancePosCfg[#var_24_0].position

	arg_24_0.parentRect_.sizeDelta = Vector2(var_24_1[1] - arg_24_0.viewportRect_.rect.width + arg_24_0.viewportRect_.rect.width / 4, 707)
end

return var_0_0
