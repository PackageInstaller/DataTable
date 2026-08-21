local var_0_0 = {}

manager.net:Bind(76301, function(arg_1_0)
	IndiaNianData:UpdateNianData(arg_1_0)
	var_0_0.InitIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)
manager.net:Bind(76303, function(arg_2_0)
	IndiaNianData:UpdateNianData(arg_2_0)
	var_0_0.UpdateIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)
manager.net:Bind(76305, function(arg_3_0)
	IndiaNianData:UpdateNianData(arg_3_0)
	var_0_0.UpdateIndiaNianRedPoint()
	manager.notify:CallUpdateFunc(INDIA_NIAN_UPDATE_DATA)
end)

function var_0_0.SendGetNianData(arg_4_0)
	manager.net:SendWithLoadingNew(76302, {
		activity_id = arg_4_0
	}, 76303, var_0_0.GetNianDataResultHandler)
end

function var_0_0.GetNianDataResultHandler(arg_5_0, arg_5_1)
	if isSuccess(arg_5_0.result) then
		IndiaNianData:UpdateNianData(arg_5_0)
	else
		ShowTips(GetTips(arg_5_0.result))
	end
end

function var_0_0.IsActivityTime()
	local var_6_0 = ActivityData:GetActivityData(IndiaNianData:GetActivityID())
	local var_6_1 = var_6_0.stopTime
	local var_6_2 = var_6_0.startTime

	if var_6_1 > manager.time:GetServerTime() and var_6_2 < manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.InitIndiaNianRedPoint()
	local var_7_0 = ActivityTools.GetRedPointKey(IndiaNianData:GetActivityID()) .. IndiaNianData:GetActivityID()

	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0.UpdateIndiaNianRedPoint()
	end)
	manager.redPoint:addGroup(var_7_0, {
		RedPointConst.ACTIVITY_INDIA_NIAN_REWARD,
		RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK
	})
	manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_REWARD, IndiaNianData:GetHasCompeletedTask() and var_0_0.IsActivityTime() and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, IndiaNianData:GetHasUnlockBuff() and var_0_0.IsActivityTime() and 1 or 0)
end

function var_0_0.UpdateIndiaNianRedPoint()
	manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_REWARD, IndiaNianData:GetHasCompeletedTask() and var_0_0.IsActivityTime() and 1 or 0)
	manager.redPoint:setTip(RedPointConst.ACTIVITY_INDIA_NIAN_UNLOCK, IndiaNianData:GetHasUnlockBuff() and var_0_0.IsActivityTime() and 1 or 0)
end

return var_0_0
