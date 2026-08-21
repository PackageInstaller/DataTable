local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("SlayerSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.region_activity_id = arg_1_1.region_activity_id
	arg_1_0.slayer_activity_id = arg_1_0.activityID
end

function var_0_1.CustomCheckBeforeBattle(arg_2_0)
	if not ActivityData:GetActivityIsOpen(arg_2_0.region_activity_id) then
		return false, "TIP_EXPIRED"
	end

	return true
end

function var_0_1.GetStageData(arg_3_0)
	return BattleStageFactory.Produce(arg_3_0.stageType, arg_3_0.region_activity_id, arg_3_0.slayer_activity_id)
end

return var_0_1
