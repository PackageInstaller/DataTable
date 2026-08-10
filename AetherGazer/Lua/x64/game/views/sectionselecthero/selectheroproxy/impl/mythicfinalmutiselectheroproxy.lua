local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("MythicFinalMutiSelectHeroProxy", var_0_0)

function var_0_1.CustomCheckBeforeBattle(arg_1_0)
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

function var_0_1.GetStageInfoClass(arg_3_0)
	return MythicSectionStageInfoView
end

function var_0_1.InitCustomParams(arg_4_0, arg_4_1)
	arg_4_0.teamLength = arg_4_1.teamLength
	arg_4_0.teamID = arg_4_1.teamID
end

function var_0_1.GetHeroTeamInfoRoute(arg_5_0)
	return "/mythicHeroTeamInfoView"
end

function var_0_1.GetCustomeTeamInfoParams(arg_6_0, arg_6_1)
	return {
		canCleanTeam = true,
		selectHeroPos = arg_6_1,
		section = arg_6_0.stageID,
		sectionType = arg_6_0.stageType,
		teamLength = arg_6_0.teamLength,
		reserveParams = arg_6_0.reserveParams,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		activityID = arg_6_0.activityID
	}
end

function var_0_1.GetAdditionalViewClass(arg_7_0)
	return MythicSectionAdditionalView
end

return var_0_1
