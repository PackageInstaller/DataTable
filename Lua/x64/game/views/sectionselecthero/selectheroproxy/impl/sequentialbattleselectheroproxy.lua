local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("SequentialBattleSelectHeroProxy", var_0_0)

function var_0_1.GetHeroTeamInfoRoute(arg_1_0)
	return "/heroTeamInfoSequentialBattle"
end

function var_0_1.GetAdditionalViewClass(arg_2_0)
	return SequentialBattleSectionAdditionalView
end

function var_0_1.ChangeHeroTeam(arg_3_0, ...)
	var_0_1.super.ChangeHeroTeam(arg_3_0, ...)
	arg_3_0:RefreshEnableBuff()
end

function var_0_1.ApplyReserveProposal(arg_4_0, ...)
	var_0_1.super.ApplyReserveProposal(arg_4_0, ...)
	arg_4_0:RefreshEnableBuff()
end

function var_0_1.RefreshEnableBuff(arg_5_0)
	local var_5_0 = table.keyof(SequentialBattleChapterCfg[arg_5_0.activityID].stage_id, arg_5_0.stageID)

	SequentialBattleTools.SaveEnabledBuff(arg_5_0.activityID, var_5_0)
end

return var_0_1
