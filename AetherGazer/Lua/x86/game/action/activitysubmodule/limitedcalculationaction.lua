local var_0_0 = {}
local var_0_1 = false

function var_0_0.Init()
	if var_0_1 then
		return
	end

	var_0_1 = true

	LimitedCalculationData:Init()
	manager.net:Bind(60053, function(arg_2_0)
		LimitedCalculationData:SetData(arg_2_0.calculation)
		LimitedCalculationAction:RefreshRedPoint(arg_2_0.calculation.activity_id)
	end)
end

function var_0_0.InitRedPointKey(arg_3_0)
	manager.redPoint:addGroup(RedPointConst.LIMITED_CALCULATION .. arg_3_0, {
		RedPointConst.LIMITED_CALCULATION_OPEN .. arg_3_0,
		RedPointConst.LIMITED_CALCULATION_REWARD .. arg_3_0
	})
end

function var_0_0.OnReceivePointReward(arg_4_0, arg_4_1, arg_4_2)
	LimitedCalculationData:SetRewardState(arg_4_1, arg_4_2)
	arg_4_0:RefreshRewardRedPoint(arg_4_1)
end

function var_0_0.RefreshRedPoint(arg_5_0, arg_5_1)
	if not ActivityData:GetActivityIsOpen(arg_5_1) then
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. arg_5_1, 0)
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. arg_5_1, 0)

		return
	end

	arg_5_0:RefreshActivityOpenRedPoint(arg_5_1)
	arg_5_0:RefreshRewardRedPoint(arg_5_1)
end

function var_0_0.RefreshActivityOpenRedPoint(arg_6_0, arg_6_1)
	if not LimitedCalculationData:GetIsNeed(arg_6_1) then
		return
	end

	local var_6_0 = LimitedCalculationData:GetScore(arg_6_1)

	if var_6_0 and var_6_0 <= 0 then
		manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_OPEN .. arg_6_1, 1)
	end
end

function var_0_0.RefreshRewardRedPoint(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1 = LimitedCalculationData:GetScore(arg_7_1)
	local var_7_2 = LimitedCalculationData:GetRewardList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		if var_7_1 > ActivityPointRewardCfg[iter_7_1.id].need and iter_7_1.complete_flag == ActivityConst.LIMITED_CALCULATION_REWARD_STATE.UNFINISHED then
			manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. arg_7_1, 1)

			return
		end
	end

	manager.redPoint:setTip(RedPointConst.LIMITED_CALCULATION_REWARD .. arg_7_1, 0)
end

function var_0_0.GetAllRewardAction(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = {}
	local var_8_2 = LimitedCalculationData:GetRewardList(arg_8_1)
	local var_8_3 = LimitedCalculationData:GetScore(arg_8_1)
	local var_8_4

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		local var_8_5 = ActivityPointRewardCfg[iter_8_1.id].need

		if iter_8_1.complete_flag <= 0 and var_8_5 <= var_8_3 then
			table.insert(var_8_0, iter_8_1)
			table.insert(var_8_1, iter_8_1.id)
		end
	end

	manager.net:SendWithLoadingNew(60054, {
		point_reward_id_list = var_8_1
	}, 60055, function(arg_9_0, arg_9_1)
		if isSuccess(arg_9_0.result) then
			for iter_9_0, iter_9_1 in pairs(var_8_0) do
				LimitedCalculationData:SetRewardState(arg_8_1, iter_9_1.id)
			end

			getReward2(mergeReward2(arg_9_0.reward_list))
			manager.notify:Invoke(ACTIVITY_REWARD_GET, {
				point_reward_id_list = arg_9_1.point_reward_id_list
			})
			manager.notify:CallUpdateFunc(RECEIVE_POINT_REWARD, arg_9_1.point_reward_id_list)
			arg_8_0:RefreshRewardRedPoint(arg_8_1)
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

return var_0_0
