local var_0_0 = import("game.views.stage.bossChallenge.BattleBossInfoBaseView")
local var_0_1 = class("BattleBossAdvanceInfoView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Challenge_Boss/BossAdvanceInformationUI"
end

function var_0_1.OnEnterExtend(arg_2_0)
	manager.windowBar:SetGameHelpKey("BOSS_CHALLENGE_ADVANCE_DESC")

	arg_2_0.bossIndex_ = arg_2_0.params_.bossIndex or BattleBossChallengeData:GetCacheSelectBossIndex()

	BattleBossChallengeData:SaveCacheSelectBossIndex(arg_2_0.bossIndex_)
	manager.redPoint:bindUIandKey(arg_2_0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function var_0_1.OnExit(arg_3_0)
	var_0_1.super.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transformStar_, RedPointConst.BOSS_CHALLENGE_ADVANCE)
end

function var_0_1.OnUpdate(arg_4_0)
	var_0_1.super.OnUpdate(arg_4_0)
	arg_4_0:RefreshResetBtn()
end

function var_0_1.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.startBattleBtn_, nil, function()
		arg_5_0:Go("/bossAdvanceTarget", {
			bossIndex = arg_5_0.bossIndex_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.buttonExchange_, nil, function()
		JumpTools.OpenPageByJump("bossAdvanceReward")
	end)
	arg_5_0:AddBtnListener(arg_5_0.resetBtn_, nil, function()
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("BOSS_CHALLENGE_RESET"),
			OkCallback = function()
				BattleBossChallengeAction.ResetHardModeBoss(arg_5_0.bossIndex_, function(arg_10_0)
					if isSuccess(arg_10_0.result) then
						arg_5_0:RefreshData()
						arg_5_0:RefreshUI()
					else
						ShowTips(arg_10_0.result)
					end
				end)
			end
		})
	end)
end

function var_0_1.RefreshData(arg_11_0)
	arg_11_0.templateID_ = BattleBossChallengeAdvanceData:GetBossList()[arg_11_0.bossIndex_].templateID
	arg_11_0.lockHeroGroup_ = BossTools.GetLockHero()
end

function var_0_1.RefreshUI(arg_12_0)
	var_0_1.super.RefreshUI(arg_12_0)

	arg_12_0.pointText_.text = BattleBossChallengeAdvanceData:GetMaxPoint(arg_12_0.bossIndex_)

	arg_12_0:RefreshResetBtn()
end

function var_0_1.RefreshResetBtn(arg_13_0)
	if #BattleBossChallengeAdvanceData:GetReceiveRewardList() > 0 then
		SetActive(arg_13_0.resetGo_, false)

		return
	end

	if BattleBossChallengeAdvanceData:GetBossList()[arg_13_0.bossIndex_].maxPoint > 0 then
		SetActive(arg_13_0.resetGo_, true)
	else
		SetActive(arg_13_0.resetGo_, false)
	end
end

return var_0_1
