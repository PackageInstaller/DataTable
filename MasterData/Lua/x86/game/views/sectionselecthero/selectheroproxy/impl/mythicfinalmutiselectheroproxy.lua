local MythicFinalMutiSelectHeroProxy = class("MythicFinalMutiSelectHeroProxy", (import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")))

function MythicFinalMutiSelectHeroProxy:CustomCheckBeforeBattle()
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythicUltimateView/mythicDifficulty", nil)
			end
		})

		return false
	end

	return true
end

function MythicFinalMutiSelectHeroProxy:GetStageInfoClass()
	return MythicSectionStageInfoView
end

function MythicFinalMutiSelectHeroProxy:InitCustomParams(arg_4_1)
	self.teamLength = arg_4_1.teamLength
	self.teamID = arg_4_1.teamID
end

function MythicFinalMutiSelectHeroProxy:GetHeroTeamInfoRoute()
	return "/mythicHeroTeamInfoView"
end

function MythicFinalMutiSelectHeroProxy:GetCustomeTeamInfoParams(arg_6_1)
	return {
		canCleanTeam = true,
		selectHeroPos = arg_6_1,
		section = self.stageID,
		sectionType = self.stageType,
		teamLength = self.teamLength,
		reserveParams = self.reserveParams,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		activityID = self.activityID
	}
end

function MythicFinalMutiSelectHeroProxy:GetAdditionalViewClass()
	return MythicSectionAdditionalView
end

return MythicFinalMutiSelectHeroProxy
