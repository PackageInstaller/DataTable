local var_0_0 = singletonClass("RedEnvelopeData")
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = {}
local var_0_5 = 1
local var_0_6 = true
local var_0_7 = 313581
local var_0_8 = false

function var_0_0.UpdateActivityData(arg_1_0, arg_1_1)
	var_0_2 = arg_1_1.activity_id
	var_0_1 = arg_1_1.got_reward
	var_0_4 = arg_1_1.current_get_red_day

	var_0_0:SetNormalSelectDay()
	var_0_0:UpdateRedDotCount(var_0_2)
	manager.notify.Invoke(ACTIVITY_RED_ENVELOPE_NEW_DAY)

	if not var_0_8 then
		manager.notify:RegistListener(ACTIVITY_UPDATE, function(arg_2_0)
			if arg_2_0 and arg_2_0 == SandplayTagCfg[var_0_7].activityId then
				RedEnvelopeData:UpdateRedDotCount(var_0_2)
			end
		end)
		manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, function(arg_3_0)
			if arg_3_0 and arg_3_0 == SandplayTagCfg[var_0_7].questId then
				RedEnvelopeData:UpdateRedDotCount(var_0_2)
			end
		end)

		var_0_8 = true
	end
end

function var_0_0.GetCurDays(arg_4_0)
	local var_4_0 = ActivitySpringRedEnvelopeCfg.all
	local var_4_1 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_2 = ActivitySpringRedEnvelopeCfg[iter_4_1].sub_activity_id

		if ActivityData:GetActivityIsOpen(var_4_2) then
			var_4_1 = var_4_1 + 1
		end
	end

	return var_4_1
end

function var_0_0.SetNormalSelectDay(arg_5_0)
	var_0_6 = true

	if var_0_4 and #var_0_4 > 0 then
		var_0_5 = var_0_4[1]

		for iter_5_0 = 2, #var_0_4 do
			if var_0_4[iter_5_0] < var_0_5 then
				var_0_5 = var_0_4[iter_5_0]
			end
		end

		var_0_5 = var_0_5 - 1000

		return
	end

	if var_0_1 and #var_0_1 > 0 then
		for iter_5_1, iter_5_2 in ipairs(var_0_1) do
			if iter_5_2.id - 1000 > var_0_5 then
				var_0_5 = iter_5_2.id - 1000
			end
		end
	end
end

function var_0_0.GetNormalSelectDay(arg_6_0)
	return var_0_5
end

function var_0_0.SetIsResetNormalSelect(arg_7_0, arg_7_1)
	var_0_6 = arg_7_1
end

function var_0_0.GetIsResetNormalSelect(arg_8_0)
	return var_0_6
end

function var_0_0.TotalSignDay(arg_9_0)
	return ActivitySpringRedEnvelopeCfg and #ActivitySpringRedEnvelopeCfg.all or 7
end

function var_0_0.GetActivityData(arg_10_0)
	return var_0_1
end

function var_0_0.GetActivityId(arg_11_0)
	return var_0_2
end

function var_0_0.SetCurSelectDay(arg_12_0, arg_12_1)
	var_0_3 = arg_12_1
end

function var_0_0.GetCurSelectDay(arg_13_0)
	return var_0_3
end

function var_0_0.GetCurrentGetDay(arg_14_0)
	return var_0_4
end

function var_0_0.IsCanGetReward(arg_15_0)
	return #var_0_4 > 0
end

function var_0_0.SetIsFlipCardAnim(arg_16_0, arg_16_1)
	var_0_0.isFlipCardAnim = arg_16_1
end

function var_0_0.GetIsFlipCardAnim(arg_17_0, arg_17_1)
	return var_0_0.isFlipCardAnim
end

function var_0_0.UpdateRedDotCount(arg_18_0, arg_18_1)
	local var_18_0 = ActivityCfg[arg_18_1].sub_activity_list

	if var_0_4 and #var_0_4 > 0 and QWorldTools.CheckTagCanOpen(var_0_7) then
		for iter_18_0, iter_18_1 in ipairs(var_18_0) do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. iter_18_1, 0)
		end

		for iter_18_2 = 1, #var_0_4 do
			local var_18_1 = 3135900 + (var_0_4[iter_18_2] - 1000)

			manager.redPoint:setTip(RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. var_18_1, 1)
		end
	else
		for iter_18_3, iter_18_4 in ipairs(var_18_0) do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_RED_ENVELOPE_CAN_CLAIMED .. "_" .. iter_18_4, 0)
		end
	end
end

return var_0_0
