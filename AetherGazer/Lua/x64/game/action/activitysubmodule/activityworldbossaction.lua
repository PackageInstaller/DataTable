local var_0_0 = {}

manager.net:Bind(61201, function(arg_1_0)
	ActivityWorldBossData:InitWorldBossData(arg_1_0)
	manager.notify:CallUpdateFunc(ACTIVITY_WORLD_BOSS_UPDATE)
	var_0_0.CheckRedPoint(arg_1_0.activity_id)
end)
manager.net:Bind(61205, function(arg_2_0)
	ActivityWorldBossData:InitWorldBossSocre(arg_2_0)
end)
manager.notify:RegistListener(ZERO_REFRESH, function()
	if ActivityData:GetActivityIsOpen(ActivityConst.NIEN_WORLD_BOSS) then
		ActivityWorldBossAction.QueryBossData(ActivityConst.NIEN_WORLD_BOSS)
	end
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_4_0)
	if ActivityTools.GetActivityType(arg_4_0) == ActivityTemplateConst.ACTIVITY_WORLD_BOSS then
		ActivityWorldBossAction.CheckRedPoint(arg_4_0)
	end
end)

function var_0_0.QueryHealthRward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(61202, {
		activity_id = arg_5_0,
		damage_reward_id_list = arg_5_1
	}, 61203, var_0_0.OnHealthRewardBack)
end

function var_0_0.OnHealthRewardBack(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		local var_6_0 = arg_6_0.reward_list

		getReward2(mergeReward2(var_6_0))
		manager.notify:CallUpdateFunc(ACTIVITY_WORLD_BOSS_UPDATE)
		ActivityWorldBossAction.CheckRedPoint(arg_6_1.activity_id)
	else
		ShowTips(arg_6_0.result)
	end
end

local var_0_1

function var_0_0.QueryBossData(arg_7_0, arg_7_1)
	var_0_1 = arg_7_1

	manager.net:SendWithLoadingNew(11006, {
		activity_id = {
			arg_7_0
		}
	}, 11007, var_0_0.OnBossDataBack)
end

function var_0_0.OnBossDataBack(arg_8_0, arg_8_1)
	if isSuccess(arg_8_0.result) then
		if var_0_1 then
			var_0_1()
		end
	else
		ShowTips(arg_8_0.result)
	end
end

function var_0_0.CheckRedPoint(arg_9_0)
	if ActivityData:GetActivityIsOpen(arg_9_0) then
		local var_9_0 = ActivityWorldBossCfg[arg_9_0]

		for iter_9_0, iter_9_1 in ipairs(var_9_0.health_reward_list) do
			if ActivityWorldBossData:GetHealthRewardState(arg_9_0, iter_9_0) == 1 then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WORLD_BOSS, arg_9_0), 1)

				return
			end
		end
	end

	manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ACTIVITY_WORLD_BOSS, arg_9_0), 0)
end

return var_0_0
