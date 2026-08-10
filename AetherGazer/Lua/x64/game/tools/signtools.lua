local var_0_0 = {}

function var_0_0.IsCanSign()
	local var_1_0 = BigMonthCardData:LoginPopFlag() and BigMonthCardData:HaveMonthCard() and (not BigMonthCardData:IsSignToday() or BigMonthCardData:IsNeedAccumulatSign())

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SIGN) then
		return false
	end

	if isPopFatigue then
		return true
	end

	if var_1_0 then
		return true
	end

	if var_0_0.GetDailySignIndex() ~= 0 then
		return true
	end

	local var_1_1 = ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SEVEN_SIGN] or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if var_0_0.GetSevenDaySignIndex(iter_1_1) ~= 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetDailySignIndex()
	local var_2_0 = manager.time:GetDeltaToday()
	local var_2_1 = SignData:GetDailySignInfo()

	if not var_2_1 then
		return 0
	end

	if not table.keyof(var_2_1.days, var_2_0) then
		return table.nums(var_2_1.days) + 1
	end

	return 0
end

function var_0_0.GetSevenDaySignIndex(arg_3_0)
	local var_3_0 = manager.time:GetTodayFreshTime()

	if not ActivityData:GetActivityIsOpen(arg_3_0) then
		return 0
	end

	local var_3_1 = SignData:GetSevenDaySignInfo(arg_3_0)
	local var_3_2 = ActivityData:GetActivityData(arg_3_0)

	if not var_3_1 or not var_3_2 then
		return 0
	end

	local var_3_3 = ActivityCumulativeSignCfg[arg_3_0]

	if var_3_3 == nil then
		return 0
	end

	if PlayerData:GetPlayerInfo().userLevel < var_3_3.limit_level then
		return 0
	end

	if var_3_1.signCount >= #var_3_3.config_list then
		return 0
	end

	if var_3_0 > var_3_1.lastSignTime then
		return var_3_1.signCount + 1
	end

	return 0
end

function var_0_0.GetDailySignState(arg_4_0)
	local var_4_0 = manager.time:GetDeltaToday()
	local var_4_1 = SignData:GetDailySignInfo().days
	local var_4_2 = #var_4_1
	local var_4_3 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		if var_4_3 < iter_4_1 then
			var_4_3 = iter_4_1
		end
	end

	if arg_4_0 <= var_4_2 then
		return ActivityConst.SIGN_STATE.GETTED
	end

	if var_4_3 < var_4_0 and var_4_2 + 1 == arg_4_0 then
		return ActivityConst.SIGN_STATE.CAN_GET
	end

	if var_4_3 < var_4_0 and var_4_2 + 2 == arg_4_0 or var_4_3 == var_4_0 and var_4_2 + 1 == arg_4_0 then
		return ActivityConst.SIGN_STATE.TOMORROW_GET
	end

	return ActivityConst.SIGN_STATE.NONE
end

function var_0_0.GetSevenDaySignState(arg_5_0, arg_5_1)
	local var_5_0 = SignData:GetSevenDaySignInfo(arg_5_0)

	if not var_5_0 then
		return ActivityConst.SIGN_STATE.NONE
	end

	local var_5_1 = manager.time:GetDeltaToday()

	if arg_5_1 <= var_5_0.signCount then
		return ActivityConst.SIGN_STATE.GETTED
	end

	if var_5_1 > var_5_0.lastSignTime and var_5_0.signCount + 1 == arg_5_1 then
		return ActivityConst.SIGN_STATE.CAN_GET
	end

	if var_5_1 > var_5_0.lastSignTime and var_5_0.signCount + 2 == arg_5_1 or var_5_0.lastSignTime == var_5_1 and var_5_0.signCount + 1 == arg_5_1 then
		return ActivityConst.SIGN_STATE.TOMORROW_GET
	end

	return ActivityConst.SIGN_STATE.NONE
end

function var_0_0.GetSevenDaySignState2(arg_6_0, arg_6_1)
	if var_0_0.GetSevenDaySignIndex(arg_6_0) == arg_6_1 then
		return ActivityConst.SIGN_STATE.CAN_GET
	end

	local var_6_0 = SignData:GetSevenDaySignInfo(arg_6_0)

	if not var_6_0 then
		return ActivityConst.SIGN_STATE.NONE
	end

	if arg_6_1 <= var_6_0.signCount then
		return ActivityConst.SIGN_STATE.GETTED
	end

	return ActivityConst.SIGN_STATE.NONE
end

return var_0_0
