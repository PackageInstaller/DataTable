local var_0_0 = singletonClass("BigMonthCardData")
local var_0_1 = {
	sign_days = 0,
	is_expire_tip = 0,
	template_id = 0,
	monthly_card_timestamp = 0,
	is_sign = 0,
	have_sign = {},
	daily_record = {}
}
local var_0_2 = false

function var_0_0.Init(arg_1_0)
	var_0_1.monthly_card_timestamp = 0
	var_0_1.is_sign = 0
	var_0_1.sign_days = 0
	var_0_1.have_sign = {}
	var_0_1.daily_record = {}
	var_0_1.is_expire_tip = 0
	var_0_1.template_id = 0
	var_0_2 = false
end

function var_0_0:InitData(arg_2_1)
	var_0_1.monthly_card_timestamp = arg_2_1.buy_timestamp
	var_0_1.is_sign = arg_2_1.is_sign
	var_0_1.sign_days = arg_2_1.total_sign_times
	var_0_1.have_sign = arg_2_1.total_sign_receive_list
	var_0_1.is_expire_tip = arg_2_1.is_expire_tip
	var_0_1.template_id = arg_2_1.template_id

	self:InitRecord(arg_2_1.daily_record)
end

function var_0_0.UpdateIsSign(arg_3_0, arg_3_1)
	var_0_1.is_sign = arg_3_1
end

function var_0_0.UpdateSignData(arg_4_0, arg_4_1)
	var_0_1.sign_days = arg_4_1
end

function var_0_0.InitRecord(arg_5_0, arg_5_1)
	var_0_1.daily_record = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1 or {}) do
		var_0_1.daily_record[iter_5_1.index] = iter_5_1.times
	end
end

function var_0_0.IsSignToday(arg_6_0)
	return var_0_1.is_sign == 1
end

function var_0_0:HaveMonthCard()
	local var_7_0

	if var_0_1.monthly_card_timestamp > 0 then
		if TimeMgr.GetInstance():GetServerTime() >= self:GetMonthCardDeadTime() then
			var_7_0 = false

			goto label_7_0
		end
	end

	::label_7_0::

	return true
end

function var_0_0.SignToday(arg_8_0)
	var_0_1.is_sign = 1
	var_0_1.sign_days = var_0_1.sign_days + 1
end

function var_0_0.SignAccumulate(arg_9_0, arg_9_1)
	if arg_9_1 == nil then
		return
	end

	if #arg_9_1 == 0 then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if table.indexof(var_0_1.have_sign, iter_9_1) then
			break
		end

		table.insert(var_0_1.have_sign, iter_9_1)
	end
end

function var_0_0.IsNeedAccumulatSign(arg_10_0)
	if var_0_1.template_id == 0 then
		return false
	end

	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(BigMonthCardAccumulationCfg.get_id_list_by_template_id[var_0_1.template_id]) do
		if var_0_1.sign_days >= BigMonthCardAccumulationCfg[iter_10_1].accumulation and not table.indexof(var_0_1.have_sign, iter_10_1) then
			var_10_0 = true

			break
		end
	end

	return var_10_0
end

function var_0_0.ResetSign(arg_11_0)
	var_0_1.is_sign = 0
end

function var_0_0.GetMonthCardDeadTime(arg_12_0)
	local var_12_0

	if tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp, "!%H")) < GameSetting.refresh_time1.value[1][1] then
		var_12_0 = manager.time:Table2ServerTime({
			year = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp - 86400, "!%Y")),
			month = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp - 86400, "!%m")),
			day = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp - 86400, "!%d")),
			hour = GameSetting.refresh_time1.value[1][1],
			min = GameSetting.refresh_time1.value[1][2],
			sec = GameSetting.refresh_time1.value[1][3]
		})
	else
		local var_12_1 = {}

		var_12_1.year = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp, "!%Y"))
		var_12_1.month = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp, "!%m"))
		var_12_1.day = tonumber(manager.time:STimeDescS(var_0_1.monthly_card_timestamp, "!%d"))
		var_12_1.hour = GameSetting.refresh_time1.value[1][1]
		var_12_1.min = GameSetting.refresh_time1.value[1][2]
		var_12_1.sec = GameSetting.refresh_time1.value[1][3]
		var_12_0 = manager.time:Table2ServerTime(var_12_1)
	end

	return var_12_0 + (GameSetting.big_monthly_card_duration.value[1] + 1) * 86400
end

function var_0_0.GetSignDays(arg_13_0)
	return var_0_1.sign_days
end

function var_0_0.GetHaveSign(arg_14_0)
	return var_0_1.have_sign
end

function var_0_0:SetRecord(arg_15_1)
	self:InitRecord(arg_15_1.daily_record)
end

function var_0_0.GetRecord(arg_16_0)
	return var_0_1.daily_record
end

function var_0_0:GetMonthCardLastDay()
	local var_17_0 = math.floor((self:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()) / 86400) - var_0_1.is_sign

	return (math.floor((self:GetMonthCardDeadTime() - TimeMgr.GetInstance():GetServerTime()) / 86400) - var_0_1.is_sign < 0 or nil) and 0
end

function var_0_0.LoginPopFlag(arg_18_0)
	if not var_0_2 then
		var_0_2 = true

		return var_0_2
	end

	return false
end

function var_0_0.IsExpireTip(arg_19_0)
	return var_0_1.is_expire_tip
end

function var_0_0.SetIsExpireTip(arg_20_0)
	var_0_1.is_expire_tip = 0
end

function var_0_0.GetTemplateId(arg_21_0)
	return var_0_1.template_id
end

return var_0_0
