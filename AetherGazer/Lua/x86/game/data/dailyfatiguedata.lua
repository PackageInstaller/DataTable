local var_0_0 = singletonClass("DailyFatigueData")
local var_0_1 = ActivityConst.DAILY_FATIGUE_STATUS

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.data = {}
	arg_1_0.loginPopFlag = true

	local var_1_0 = arg_1_1.daily_fatigue_dessert_list

	if not var_1_0 then
		return
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		arg_1_0:SetData(iter_1_1.type, iter_1_1.is_got)
	end
end

function var_0_0.Clear(arg_2_0)
	arg_2_0.data = nil
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0.data then
		arg_3_0.data = {}
	end

	arg_3_0.data[arg_3_1] = arg_3_2
end

function var_0_0.GetStatus(arg_4_0, arg_4_1)
	if arg_4_0.data and arg_4_0.data[arg_4_1] then
		return var_0_1.CLAIMED
	end

	local var_4_0 = manager.time
	local var_4_1 = var_4_0:GetServerTime()
	local var_4_2 = var_4_0:GetLastZeroTime()
	local var_4_3 = var_4_0:GetDeltaToday()
	local var_4_4 = var_4_0:GetToday()

	if var_4_3 < var_4_4 or math.abs(var_4_3 - var_4_4) > 1 then
		return var_0_1.AVAILABLE
	elseif var_4_1 > var_4_2 + arg_4_1 * 3600 then
		return var_0_1.AVAILABLE
	end

	return var_0_1.NOT_AVAILABLE
end

function var_0_0.IsFatigueFull(arg_5_0)
	return ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= 999
end

function var_0_0.LoginPopFlag(arg_6_0, arg_6_1)
	if arg_6_1 ~= nil then
		arg_6_0.loginPopFlag = arg_6_1
	else
		return arg_6_0.loginPopFlag
	end
end

function var_0_0.GetRedCount(arg_7_0)
	local var_7_0 = GameSetting.daily_free_physical_strength.value

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = iter_7_1[1]

		if arg_7_0:GetStatus(var_7_1) == var_0_1.AVAILABLE then
			return 1
		end
	end

	return 0
end

return var_0_0
