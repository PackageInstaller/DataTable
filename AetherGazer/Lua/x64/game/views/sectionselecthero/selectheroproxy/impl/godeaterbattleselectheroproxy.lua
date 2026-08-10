local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("GodEaterBattleSelectHeroProxy", var_0_0)

function var_0_1.GetStageData(arg_1_0)
	local var_1_0 = DailyMonsterData:GetBattleType()

	return BattleStageFactory.Produce(arg_1_0.stageType, arg_1_0.stageID, {
		viewType = var_1_0,
		activityId = arg_1_0.activityID
	})
end

return var_0_1
