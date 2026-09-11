local ReserveOsirisPlayGameBattleTemplate = class("ReserveOsirisPlayGameBattleTemplate", (import("game.reserve.template.ReserveBaseTemplate")))

function ReserveOsirisPlayGameBattleTemplate:GetDefaultTeam(arg_1_1, arg_1_2)
	if #ActivityGeneralityChapterCfg[ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_1_1.stageID][1]].chapter_id].character > 0 then
		arg_1_2.resultHeroList = {
			HeroStandardSystemCfg[ActivityGeneralityChapterCfg[ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_1_1.stageID][1]].chapter_id].character[1]].hero_id,
			0,
			0
		}
		arg_1_2.resultTrialList = ActivityGeneralityChapterCfg[ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[arg_1_1.stageID][1]].chapter_id].character
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

return ReserveOsirisPlayGameBattleTemplate
