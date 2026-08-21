local var_0_0 = import("game.views.sectionSelectHero.SelectHeroProxy.SelectHeroBaseProxy")
local var_0_1 = class("ActivityWorldBossSelectHeroProxy", var_0_0)

function var_0_1.CustomCheckBeforeBattle(arg_1_0)
	if not ActivityData:GetActivityIsOpen(arg_1_0.activityID) then
		return false, "TIME_OVER"
	end

	return true
end

function var_0_1.GetStageData(arg_2_0)
	local var_2_0 = ActivityWorldBossData:GetStageId(arg_2_0.activityID)

	return (BattleActivityWorldBossTemplate.New(var_2_0, arg_2_0.activityID))
end

return var_0_1
