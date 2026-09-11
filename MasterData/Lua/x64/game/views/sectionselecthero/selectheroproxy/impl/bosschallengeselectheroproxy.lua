local BossChallengeSelectHeroProxy = class("BossChallengeSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function BossChallengeSelectHeroProxy:InitCustomParams(arg_1_1)
	self.bossIndex = arg_1_1.bossIndex
	self.updateHandler = handler(self, self.UpdateBossChallenge)
end

function BossChallengeSelectHeroProxy:UpdateBossChallenge()
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function BossChallengeSelectHeroProxy:OnSectionSelectEnter()
	if BattleBossChallengeData:GetSelectMode() == BossConst.MODE_NONE then
		self:UpdateBossChallenge()
	end

	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, self.updateHandler)
end

function BossChallengeSelectHeroProxy:OnSectionSelectExit()
	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, self.updateHandler)
end

function BossChallengeSelectHeroProxy:CustomCheckBeforeBattle()
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

function BossChallengeSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/heroTeamInfoBoss"
end

function BossChallengeSelectHeroProxy:GetCustomeTeamInfoParams(arg_9_1)
	return {
		bossIndex = self.bossIndex
	}
end

function BossChallengeSelectHeroProxy:GetStageData()
	return BattleStageFactory.Produce(self.stageType, self.stageID, self.bossIndex)
end

return BossChallengeSelectHeroProxy
