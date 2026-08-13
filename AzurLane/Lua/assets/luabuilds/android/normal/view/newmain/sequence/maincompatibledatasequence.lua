class = var_0_10000

local var_0_0 = var_0_10000("MainCompatibleDataSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			getProxy = var_2_10001
			SixthAnniversaryIslandProxy = var_2_10002

			local var_2_0 = var_2_10001(var_2_10002)

			var_1.CheckAndRequest(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.CheckSpecialDayForEducateChar(var_3_0, arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.CheckSpecialDayForEducateChar(arg_4_0, arg_4_1)
	LOCK_EDUCATE_SYSTEM = var_1_10002

	if var_1_10002 then
		arg_4_1()

		return
	end

	pg = var_1_10002

	local var_4_0 = var_1_10002.TimeMgr.GetInstance()
	local var_4_1 = var_2.GetServerTime(var_4_0)

	ChineseCalendar = var_4_0

	local var_4_2, var_4_3, var_4_4 = var_4_0.GetCurrYearMonthDay(var_4_1)

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_4_5 = var_1_10006(var_1_10007)
	local var_4_6 = var_6.getRawData(var_4_5)
	local var_4_7 = var_6.ExistEducateChar(var_4_6)

	getProxy = var_4_6
	SettingsProxy = var_1_10008

	local var_4_8 = var_4_6(var_1_10008)

	if var_4_7 then
		local var_4_9 = var_4_8
		local var_4_10 = var_4_8.GetFlagShipDisplayMode(var_4_9)

		FlAG_SHIP_DISPLAY_ONLY_SHIP = var_4_9

		if var_4_10 ~= var_4_9 and not var_4_8:IsTipDay(var_4_2, var_4_3, var_4_4) then
			ChineseCalendar = var_8

			if var_8.AnySpecialDay(var_4_2, var_4_3, var_4_4) then
				PlayerVitaeShipsPage = var_8

				local var_4_11, var_4_12 = var_8.GetSlotMaxCnt()

				if var_4_12 + 1 and var_10 > 0 then
					var_4_8:setCurrentSecretaryIndex(var_10)
				end
			end
		end
	end

	arg_4_1()

	return
end

return var_0_0
