local var_0_0 = import("game.reserve.template.ReserveBaseTemplate")
local var_0_1 = class("ReserveOsirisPlayGameBattleTemplate", var_0_0)

function var_0_1.GetDefaultTeam(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_1_1.stageID][1]
	local var_1_1 = ActivityGeneralityStageCfg[var_1_0].chapter_id
	local var_1_2 = ActivityGeneralityChapterCfg[var_1_1].character

	if #var_1_2 > 0 then
		local var_1_3 = var_1_2[1]
		local var_1_4 = HeroStandardSystemCfg[var_1_3].hero_id

		arg_1_2.resultHeroList = {
			var_1_4,
			0,
			0
		}
		arg_1_2.resultTrialList = var_1_2
	else
		arg_1_2.resultHeroList = {
			0,
			0,
			0
		}
		arg_1_2.resultTrialList = {
			0,
			0,
			0
		}
	end
end

return var_0_1
