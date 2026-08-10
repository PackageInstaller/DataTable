local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("PushBoxSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.destID = arg_1_1.dest_id
end

function var_0_1.GetStageData(arg_2_0)
	return BattleActivityPushBoxTemplate.New(arg_2_0.stageID, arg_2_0.activityID, arg_2_0.destID)
end

return var_0_1
