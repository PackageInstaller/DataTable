local var_0_0 = {}

manager.net:Bind(61041, function(arg_1_0)
	ActivityRaceData:SetData(arg_1_0)
end)
manager.net:Bind(61045, function(arg_2_0)
	ActivityRaceData:SetDropAffixes(arg_2_0)
end)

function var_0_0.RequireReceive(arg_3_0, arg_3_1, arg_3_2)
	manager.net:SendWithLoadingNew(61042, {
		activity_id = arg_3_0,
		reward_id = arg_3_1
	}, 61043, function(arg_4_0, arg_4_1)
		if isSuccess(arg_4_0.result) then
			if arg_3_2 ~= nil then
				arg_3_2(arg_4_0)
			end
		else
			ShowTips(arg_4_0.result)
		end
	end)
end

function var_0_0.InitRedPointKey(arg_5_0)
	local var_5_0 = ActivityData:GetActivityData(arg_5_0).subActivityIdList
	local var_5_1 = {}
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_0) do
		var_5_1[#var_5_1 + 1] = string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_5_0, iter_5_1)
		var_5_2[#var_5_2 + 1] = string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_5_0, iter_5_1)
	end

	manager.redPoint:addGroup(string.format("%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_5_0), var_5_1)
	manager.redPoint:addGroup(string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_5_0), var_5_2)

	local var_5_3 = {}

	var_5_3[#var_5_3 + 1] = string.format("%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_5_0)
	var_5_3[#var_5_3 + 1] = string.format("%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_5_0)

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_RACE, arg_5_0), var_5_3)
end

function var_0_0.UpdateRedPoint(arg_6_0)
	if ActivityData:GetActivityData(arg_6_0).stopTime <= manager.time:GetServerTime() then
		local var_6_0 = ActivityData:GetActivityData(arg_6_0).subActivityIdList

		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			manager.redPoint:setTip(string.format("%s_%s_%s_complete", RedPointConst.ACTIVITY_RACE, arg_6_0, iter_6_1), 0)
			manager.redPoint:setTip(string.format("%s_%s_%s_reward", RedPointConst.ACTIVITY_RACE, arg_6_0, iter_6_1), 0)
		end
	end
end

return var_0_0
