local var_0_0 = class("MainCompatibleDataSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	seriesAsync({
		function(arg_2_0)
			getProxy(SixthAnniversaryIslandProxy):CheckAndRequest(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:CheckSpecialDayForEducateChar(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.CheckSpecialDayForEducateChar(arg_4_0, arg_4_1)
	if LOCK_EDUCATE_SYSTEM then
		arg_4_1()

		return
	end

	local var_4_0 = pg.TimeMgr.GetInstance()
	local var_4_1, var_4_2, var_4_3 = ChineseCalendar.GetCurrYearMonthDay((var_4_0:GetServerTime()))
	local var_4_4 = getProxy(SettingsProxy)

	if getProxy(PlayerProxy):getRawData():ExistEducateChar() and var_4_4:GetFlagShipDisplayMode() ~= FlAG_SHIP_DISPLAY_ONLY_SHIP and not var_4_4:IsTipDay(var_4_1, var_4_2, var_4_3) and ChineseCalendar.AnySpecialDay(var_4_1, var_4_2, var_4_3) then
		local var_4_5, var_4_6 = PlayerVitaeShipsPage.GetSlotMaxCnt()

		if var_4_6 + 1 and var_4_6 + 1 > 0 then
			var_4_4:setCurrentSecretaryIndex(var_4_6 + 1)
		end
	end

	arg_4_1()

	return
end

return var_0_0
