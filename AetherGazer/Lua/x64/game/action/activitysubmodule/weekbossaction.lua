local var_0_0 = {}

manager.net:Bind(79501, function(arg_1_0)
	WeekBossData:InitData(arg_1_0)
	WeekBossAction.UpdateRedPoint()
end)

function var_0_0.ActiveTalent(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.heroId = arg_2_3

	return manager.net:SendWithLoadingNew(79502, {
		index = arg_2_0,
		talent_id = arg_2_1,
		id = arg_2_2,
		activity_id = WeekBossData:GetActivityId()
	}, 79503, var_0_0.OnActiveTalent)
end

function var_0_0.OnActiveTalent(arg_3_0, arg_3_1)
	WeekBossData:UpdateTalent(var_0_0.heroId, arg_3_1.index, arg_3_1.talent_id)
	manager.notify:Invoke(TALENT_UPDATE)
end

function var_0_0.InitRedPointKey(arg_4_0)
	for iter_4_0 = 1, #BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1] do
		manager.redPoint:appendGroup(RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE .. iter_4_0)
	end

	manager.redPoint:appendGroup(ActivityTools.GetRedPointKey(340001) .. 340001, RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE)
end

function var_0_0.UpdateRedPoint()
	if not WeekBossData:GetIsInit() then
		return
	end

	local var_5_0, var_5_1 = WeekBossData:GetRemainHpProp()
	local var_5_2 = var_5_1 == #BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1] and var_5_0 <= 0

	for iter_5_0 = 1, var_5_1 do
		local var_5_3 = WeekBossData:GetRemainHpProp(iter_5_0)

		manager.redPoint:setTip(RedPointConst.ACTIVITY_GODEATER_BOSS_BATTLE .. iter_5_0, var_5_3 > 0 and not var_5_2 and 1 or 0)
	end
end

return var_0_0
