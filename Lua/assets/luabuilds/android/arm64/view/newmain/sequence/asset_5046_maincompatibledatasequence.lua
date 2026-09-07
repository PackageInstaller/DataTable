local MainCompatibleDataSequence = class("MainCompatibleDataSequence")

function MainCompatibleDataSequence:Execute(arg_1_1)
	seriesAsync({
		function(arg_2_0)
			getProxy(SixthAnniversaryIslandProxy):CheckAndRequest(arg_2_0)

			return
		end,
		function(arg_3_0)
			self:CheckSpecialDayForEducateChar(arg_3_0)

			return
		end
	}, arg_1_1)

	return
end

function MainCompatibleDataSequence:CheckSpecialDayForEducateChar(arg_4_1)
	if LOCK_EDUCATE_SYSTEM then
		arg_4_1()

		return
	end

	local var_4_0, var_4_1, var_4_2 = ChineseCalendar.GetCurrYearMonthDay((pg.TimeMgr.GetInstance():GetServerTime()))
	local var_4_3 = getProxy(SettingsProxy)

	if getProxy(PlayerProxy):getRawData():ExistEducateChar() and var_4_3:GetFlagShipDisplayMode() ~= FlAG_SHIP_DISPLAY_ONLY_SHIP and not var_4_3:IsTipDay(var_4_0, var_4_1, var_4_2) and ChineseCalendar.AnySpecialDay(var_4_0, var_4_1, var_4_2) then
		local var_4_4, var_4_5 = PlayerVitaeShipsPage.GetSlotMaxCnt()

		if var_4_5 + 1 and var_4_5 + 1 > 0 then
			var_4_3:setCurrentSecretaryIndex(var_4_5 + 1)
		end
	end

	arg_4_1()

	return
end

return MainCompatibleDataSequence
