local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("MythicSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.partition = arg_1_1.partition
	arg_1_0.difficulty = arg_1_1.difficulty
end

function var_0_1.CustomCheckBeforeBattle(arg_2_0)
	if MythicData:GetIsNew() then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("MYTHIC_REFRESH_DATA"),
			OkCallback = function()
				JumpTools.OpenPageByJump("/mythic", nil)
			end
		})

		return false
	end

	return true
end

function var_0_1.GetStageData(arg_4_0)
	local var_4_0 = arg_4_0.partition
	local var_4_1 = arg_4_0.difficulty

	return (BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC, arg_4_0.stageID, var_4_0))
end

return var_0_1
