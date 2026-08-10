local var_0_0 = import("game.views.sectionSelectHero.SectionStageInfoView")
local var_0_1 = class("MythicSectionStageInfoView", var_0_0)

function var_0_1.RefreshTitle(arg_1_0)
	local var_1_0 = arg_1_0.sectionProxy_.teamID
	local var_1_1 = ""

	if var_1_0 == 1 then
		var_1_1 = GetTips("TEAM_1")
	elseif var_1_0 == 2 then
		var_1_1 = GetTips("TEAM_2")
	else
		var_1_1 = BattleStageTools.GetStageName(arg_1_0.stageType_, arg_1_0.stageID_)
	end

	arg_1_0.titleText_.text = var_1_1
end

return var_0_1
