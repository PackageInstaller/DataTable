local var_0_0 = singletonClass("DailyFatigueData")
local var_0_1 = ActivityConst.DAILY_FATIGUE_STATUS

function var_0_0:InitData(arg_1_1)
	self.data = {}
	self.loginPopFlag = true

	if not arg_1_1.daily_fatigue_dessert_list then
		return
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.daily_fatigue_dessert_list) do
		self:SetData(iter_1_1.type, iter_1_1.is_got)
	end
end

function var_0_0.Clear(arg_2_0)
	arg_2_0.data = nil
end

function var_0_0:SetData(arg_3_1, arg_3_2)
	self.data = self.data or {}
	self.data[arg_3_1] = arg_3_2
end

function var_0_0:GetStatus(arg_4_1)
	local var_4_0

	if self.data and self.data[arg_4_1] then
		do return var_0_1.CLAIMED end

		var_4_0 = manager.time:GetDeltaToday()
	end

	local var_4_1 = manager.time:GetToday()

	if var_4_0 < var_4_1 or math.abs(var_4_0 - var_4_1) > 1 then
		return var_0_1.AVAILABLE
	elseif manager.time:GetServerTime() > manager.time:GetLastZeroTime() + arg_4_1 * 3600 then
		return var_0_1.AVAILABLE
	end

	return var_0_1.NOT_AVAILABLE
end

function var_0_0.IsFatigueFull(arg_5_0)
	return ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) >= 999
end

function var_0_0:LoginPopFlag(arg_6_1)
	if arg_6_1 ~= nil then
		self.loginPopFlag = arg_6_1
	else
		return self.loginPopFlag
	end
end

function var_0_0:GetRedCount()
	for iter_7_0, iter_7_1 in ipairs(GameSetting.daily_free_physical_strength.value) do
		if self:GetStatus(iter_7_1[1]) == var_0_1.AVAILABLE then
			return 1
		end
	end

	return 0
end

return var_0_0
