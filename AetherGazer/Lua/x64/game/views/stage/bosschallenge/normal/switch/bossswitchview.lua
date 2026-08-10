local var_0_0 = class("BossSwitchView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossSwitchUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.bossItemList_ = {}
	arg_3_0.bossGoList_ = {
		arg_3_0.goItem1_,
		arg_3_0.goItem2_,
		arg_3_0.goItem3_
	}
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_DESC")
	BossTools.CheckTimeout()
	arg_4_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_4_0.transformStar_, RedPointConst.BOSS_CHALLENGE_NORMAL)

	arg_4_0.challengeUpdateHandler_ = handler(arg_4_0, arg_4_0.UpdateBossChallenge)

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_4_0.challengeUpdateHandler_)

	arg_4_0.challengeInitHandler_ = handler(arg_4_0, arg_4_0.RefreshUI)

	manager.notify:RegistListener(BOSS_CHALLENGE_UPDATE, arg_4_0.challengeInitHandler_)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.bossItemList_) do
		iter_4_1:OnEnter()
	end

	arg_4_0:CheckMail(arg_4_0.CheckRewardPreview)
end

function var_0_0.CheckMail(arg_5_0, arg_5_1)
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

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshUI()
end

function var_0_0.OnExit(arg_8_0)
	manager.windowBar:HideBar()
	arg_8_0:RemoveUpdateTimer()
	manager.redPoint:unbindUIandKey(arg_8_0.transformStar_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_8_0.challengeUpdateHandler_)
	manager.notify:RemoveListener(BOSS_CHALLENGE_UPDATE, arg_8_0.challengeInitHandler_)

	arg_8_0.challengeUpdateHandler_ = nil
	arg_8_0.challengeInitHandler_ = nil

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.bossItemList_) do
		iter_8_1:OnExit()
	end
end

function var_0_0.Dispose(arg_9_0)
	var_0_0.super.Dispose(arg_9_0)

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
		JumpTools.OpenPageByJump("bossStarExchange")
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
	arg_16_0:RefreshText()
	arg_16_0:RefreshBossBtnList()
	arg_16_0:AddUpdateTimer()
	arg_16_0:RefreshStar()
	arg_16_0:RefreshResetBtn()
end

function var_0_0.CheckRewardPreview(arg_17_0)
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

	local var_17_3 = formatRewardCfgList(var_17_2)
	local var_17_4 = sortReward(var_17_3)
	local var_17_5 = string.format("%s·%s", GetI18NText(BossChallengeAdvanceCfg[3].name), GetI18NText(var_17_0.name))
	local var_17_6 = GetTips("BOSS_CHALLENGE_REWARD_TARGET")
	local var_17_7 = string.format(var_17_6, var_17_1)

	JumpTools.OpenPageByJump("bossChallengeRewardPreview", {
		titleText = var_17_5,
		targetText = var_17_7,
		rewardList = var_17_4
	})
	BossTools.SaveFirstEnterUIValue(BossConst.MODE_NORMAL)
end

function var_0_0.RefreshResetBtn(arg_18_0)
	local var_18_0 = BattleBossChallengeData:GetOpenModeList()
	local var_18_1 = table.length(BattleBossChallengeNormalData:GetReceiveStarList()) <= 0 and #var_18_0 > 0

	SetActive(arg_18_0.resetGo_, var_18_1)
end

function var_0_0.UpdateBossChallenge(arg_19_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function var_0_0.RefreshText(arg_20_0)
	local var_20_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_20_1 = GetTips("LEVEL")

	arg_20_0.textLv_.text = string.format("(%s%s~%s)", var_20_1, var_20_0.level[1], var_20_0.level[2])
	arg_20_0.textName_.text = GetI18NText(var_20_0.name)
end

function var_0_0.RefreshStar(arg_21_0)
	local var_21_0 = BattleBossChallengeNormalData:GetBossChallengeCfg()
	local var_21_1 = var_21_0.reward[#var_21_0.reward][1]
	local var_21_2 = BattleBossChallengeNormalData:GetReceiveStarList()

	for iter_21_0 = 1, #var_21_0.reward do
		if not table.keyof(var_21_2, var_21_0.reward[iter_21_0][1]) then
			var_21_1 = var_21_0.reward[iter_21_0][1]

			break
		end
	end

	arg_21_0.textCurStar_.text = StageTools.CalcBossChallengeStar()
	arg_21_0.textTotalStar_.text = string.format("/%s", var_21_1)
end

function var_0_0.RefreshBossBtnList(arg_22_0)
	local var_22_0 = BattleBossChallengeNormalData:GetBossList()

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		if arg_22_0.bossItemList_[iter_22_0] then
			arg_22_0.bossItemList_[iter_22_0]:RefreshUI()
		else
			arg_22_0.bossItemList_[iter_22_0] = BattleBossChallengeBossItem.New(arg_22_0.bossGoList_[iter_22_0], iter_22_0)
		end
	end

	for iter_22_2 = #arg_22_0.bossItemList_, #var_22_0 + 1, -1 do
		arg_22_0.bossItemList_[iter_22_2]:OnExit()
		arg_22_0.bossItemList_[iter_22_2]:Dispose()

		arg_22_0.bossItemList_[iter_22_2] = nil
	end
end

function var_0_0.AddUpdateTimer(arg_23_0)
	arg_23_0:RemoveUpdateTimer()

	local var_23_0 = BattleBossChallengeData:GetNextRefreshTime()

	arg_23_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_23_0)
	arg_23_0.updateTimer_ = Timer.New(function()
		local var_24_0 = BattleBossChallengeData:GetNextRefreshTime()

		if var_23_0 ~= var_24_0 then
			arg_23_0:RemoveUpdateTimer()
		end

		arg_23_0.textTime_.text = manager.time:GetLostTimeStrWith2Unit(var_24_0)
	end, 1, -1)

	arg_23_0.updateTimer_:Start()
end

function var_0_0.RemoveUpdateTimer(arg_25_0)
	if arg_25_0.updateTimer_ then
		arg_25_0.updateTimer_:Stop()

		arg_25_0.updateTimer_ = nil
	end
end

return var_0_0
