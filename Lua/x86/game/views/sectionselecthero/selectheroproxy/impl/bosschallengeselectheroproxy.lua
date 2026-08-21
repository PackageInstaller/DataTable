local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("BossChallengeSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.bossIndex = arg_1_1.bossIndex
	arg_1_0.updateHandler = handler(arg_1_0, arg_1_0.UpdateBossChallenge)
end

function var_0_1.UpdateBossChallenge(arg_2_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function var_0_1.OnSectionSelectEnter(arg_3_0)
	if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
		arg_3_0:UpdateBossChallenge()
	end

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_3_0.updateHandler)
end

function var_0_1.OnSectionSelectExit(arg_4_0)
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_4_0.updateHandler)
end

function var_0_1.CustomCheckBeforeBattle(arg_5_0)
	if manager.time:GetServerTime() >= BattleBossChallengeData:GetNextRefreshTime() - 300 then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("NEARLY_OVER"),
			OkCallback = function()
				return false
			end,
			MaskCallback = function()
				return false
			end
		})
	end

	return true
end

function var_0_1.GetHeroTeamInfoRoute(arg_8_0)
	return "/heroTeamInfoBoss"
end

function var_0_1.GetCustomeTeamInfoParams(arg_9_0, arg_9_1)
	return {
		bossIndex = arg_9_0.bossIndex
	}
end

function var_0_1.GetStageData(arg_10_0)
	return BattleStageFactory.Produce(arg_10_0.stageType, arg_10_0.stageID, arg_10_0.bossIndex)
end

return var_0_1
