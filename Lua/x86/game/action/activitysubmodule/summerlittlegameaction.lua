local var_0_0 = {}

manager.net:Bind(60059, function(arg_1_0)
	SummerLittleGameData:InitLeviathanGameData(arg_1_0)
	var_0_0.InitLeviathanRedPoint(arg_1_0.activity_id)
end)
manager.net:Bind(60063, function(arg_2_0)
	SummerLittleGameData:InitSkadiGameData(arg_2_0)
	var_0_0.InitSkadiRedPoint(arg_2_0.activity_id)
end)

function var_0_0.GetLeviathanReward(arg_3_0)
	manager.net:SendWithLoadingNew(60060, {
		activity_id = arg_3_0
	}, 60061, var_0_0.OnGetLeviathanReward)
end

function var_0_0.OnGetLeviathanReward(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		SummerLittleGameData:SetLeviathanGameReward(arg_4_1.activity_id, ActivityConst.LITTLE_GAME_STATE.REWARDED)
		getReward2(arg_4_0.reward_list)
		var_0_0.RefreshLeviathanRewardRedPoint()
		manager.notify:CallUpdateFunc(GET_LEVIATHAN_REWARD)
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.GetSkadiReward(arg_5_0, arg_5_1)
	manager.net:SendWithLoadingNew(60064, {
		activity_id = arg_5_0,
		treasure_id = arg_5_1
	}, 60065, var_0_0.OnGetSkadiReward)
end

function var_0_0.OnGetSkadiReward(arg_6_0, arg_6_1)
	if isSuccess(arg_6_0.result) then
		SummerLittleGameData:SetSkadiGameReward(arg_6_1.activity_id, arg_6_1.treasure_id)
		getReward(arg_6_0.reward_list)
		var_0_0.RefreshSkadiRewardRedPoint()
		manager.notify:CallUpdateFunc(GET_SKADI_REWARD)
	else
		ShowTips(arg_6_0.result)
	end
end

function var_0_0.ActivityOpenCheck(arg_7_0)
	local var_7_0 = ActivityData:GetActivityData(arg_7_0)

	if manager.time:GetServerTime() < var_7_0.startTime then
		return false
	end

	if manager.time:GetServerTime() >= var_7_0.stopTime then
		return false
	end

	return true
end

function var_0_0.InitSkadiRedPoint()
	local var_8_0 = SummerLittleGameData:IsSkadiRewardPointShow() and 1 or 0
	local var_8_1 = SummerLittleGameData:IsSkadiLevelPointShow() and 1 or 0

	if not var_0_0.ActivityOpenCheck(ActivityConst.SIKADI_GAME) then
		var_8_0, var_8_1 = 0, 0
	end

	manager.redPoint:addGroup(RedPointConst.SKADI_LITTLE_GAME .. "_" .. ActivityConst.SIKADI_GAME, {
		RedPointConst.SKADI_LITTLE_GAME_REWARD,
		RedPointConst.SKADI_LITTLE_GAME_LEVEL
	})
	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_REWARD, var_8_0)
	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_LEVEL, var_8_1)
end

function var_0_0.InitLeviathanRedPoint()
	local var_9_0 = SummerLittleGameData:IsLeviathanRewardPointShow() and 1 or 0
	local var_9_1 = SummerLittleGameData:IsLeviathanLevelPointShow() and 1 or 0

	if not var_0_0.ActivityOpenCheck(ActivityConst.LEVIATHAN_GAME) then
		var_9_0, var_9_1 = 0, 0
	end

	manager.redPoint:addGroup(RedPointConst.LEVIATHAN_LITTLE_GAME .. "_" .. ActivityConst.LEVIATHAN_GAME, {
		RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD,
		RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL
	})
	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD, var_9_0)
	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_LEVEL, var_9_1)
end

function var_0_0.RefreshSkadiRewardRedPoint()
	local var_10_0
	local var_10_1 = not var_0_0.ActivityOpenCheck(ActivityConst.SIKADI_GAME) and 0 or SummerLittleGameData:IsSkadiRewardPointShow() and 1 or 0

	manager.redPoint:setTip(RedPointConst.SKADI_LITTLE_GAME_REWARD, var_10_1)
end

function var_0_0.RefreshLeviathanRewardRedPoint()
	local var_11_0
	local var_11_1 = not var_0_0.ActivityOpenCheck(ActivityConst.LEVIATHAN_GAME) and 0 or SummerLittleGameData:IsLeviathanRewardPointShow() and 1 or 0

	manager.redPoint:setTip(RedPointConst.LEVIATHAN_LITTLE_GAME_REWARD, var_11_1)
end

return var_0_0
