local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("AttributeArenaSelectHeroProxy", var_0_0)

function var_0_1.InitCustomParams(arg_1_0, arg_1_1)
	arg_1_0.attribute_arena_id = arg_1_1.attribute_arena_id
end

function var_0_1.GetHeroTeamInfoRoute(arg_2_0)
	return "/heroTeamInfoAttributeArena"
end

function var_0_1.GetCustomeTeamInfoParams(arg_3_0, arg_3_1)
	return {
		attribute_arena_id = arg_3_0.attribute_arena_id
	}
end

function var_0_1.GetStageData(arg_4_0)
	return BattleActivityAttributeArenaTemplate.New(arg_4_0.stageID, arg_4_0.activityID, arg_4_0.attribute_arena_id)
end

return var_0_1
