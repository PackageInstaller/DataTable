local var_0_0 = class("MainEducateCharPainting", import(".MainMeshImagePainting"))
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	var_0_1 = pg.AssistantInfo

	return
end

function var_0_0.OnLoad(arg_2_0, arg_2_1)
	seriesAsync({
		function(arg_3_0)
			var_0_0.super.OnLoad(arg_2_0, arg_3_0)

			return
		end
	}, function()
		arg_2_0:InitTellTimeService()
		arg_2_1()

		return
	end)

	return
end

function var_0_0.OnFirstTimeTriggerEvent(arg_5_0)
	local var_5_0, var_5_1, var_5_2 = ChineseCalendar.GetCurrYearMonthDay((pg.TimeMgr.GetInstance():GetServerTime()))

	if ChineseCalendar.IsNewYear(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_NEWYEAR)
	elseif ChineseCalendar.IsLunarNewYear(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_LUNARNEWYEAR)
	elseif ChineseCalendar.IsValentineDay(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_VALENTINE)
	elseif ChineseCalendar.IsMidAutumnFestival(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_MIDAUTUMNFESTIVAL)
	elseif ChineseCalendar.AllHallowsDay(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_ALLHALLOWSDAY)
	elseif ChineseCalendar.IsChristmas(var_5_0, var_5_1, var_5_2) and not (function()
		return getProxy(SettingsProxy):IsTipDay(var_5_0, var_5_1, var_5_2)
	end)() then
		(function(arg_6_0)
			arg_5_0:DisplayWord(arg_6_0)
			getProxy(SettingsProxy):RecordTipDay(var_5_0, var_5_1, var_5_2)

			return
		end)(EducateCharWordHelper.WORD_KEY_CHRISTMAS)
	else
		local var_5_3 = getProxy(PlayerProxy)

		if not var_5_3:getFlag("tb_activity") and arg_5_0:ExistImportantActivity() then
			getProxy(PlayerProxy):setFlag("tb_activity", true)
			arg_5_0:DisplayWord(EducateCharWordHelper.WORD_KEY_ACT)
		else
			local var_5_4 = getProxy(PlayerProxy)

			if var_5_4:getFlag("change_tb") then
				getProxy(PlayerProxy):setFlag("change_tb", nil)
				arg_5_0:DisplayWord(EducateCharWordHelper.WORD_KEY_CHANGE_TB)
			else
				var_0_0.super.OnFirstTimeTriggerEvent(arg_5_0)
			end
		end
	end

	return
end

function var_0_0.ExistImportantActivity(arg_8_0)
	local var_8_0 = getProxy(ActivityProxy)

	return _.any(pg.gameset.secretary_special_ship_event_type.description, function(arg_9_0)
		local var_9_0 = var_8_0:getActivityByType(arg_9_0)

		return var_9_0 and not var_9_0:isEnd()
	end)
end

function var_0_0.InitTellTimeService(arg_10_0)
	arg_10_0:RemoveTellTimeTimer()

	local var_10_0 = GetNextHour(1)
	local var_10_1 = pg.TimeMgr.GetInstance():GetServerTime()

	if var_10_0 - var_10_1 >= 0 then
		arg_10_0:TriggerTellTime(var_10_1)
	else
		arg_10_0:AddTellTimeTimer(var_10_0, var_10_0 - var_10_1)
	end

	return
end

function var_0_0.AddTellTimeTimer(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.tellTimeTimer = Timer.New(function()
		if arg_11_0.chatting then
			arg_11_0.waitForCharEnd = arg_11_1

			return
		end

		arg_11_0:DisplayTellTimeWord(arg_11_1)
		arg_11_0:RemoveTellTimeTimer()

		return
	end, arg_11_2, 1)

	arg_11_0.tellTimeTimer:Start()

	return
end

function var_0_0.RemoveTellTimeTimer(arg_13_0)
	if arg_13_0.tellTimeTimer then
		arg_13_0.tellTimeTimer:Stop()

		arg_13_0.tellTimeTimer = nil
	end

	return
end

function var_0_0.DisplayTellTimeWord(arg_14_0, arg_14_1)
	arg_14_0:DisplayWord(EducateCharWordHelper.WORD_KEY_TELL_TIME .. tonumber(string.split(pg.TimeMgr.GetInstance():STimeDescC(arg_14_1, "%Y:%m:%d:%H:%M:%S"), ":")[4]))

	return
end

function var_0_0.TriggerPersonalTask(arg_15_0)
	if arg_15_0.isFoldState then
		return
	end

	arg_15_0:TriggerInterActionTask()

	return
end

function var_0_0.OnLongPress(arg_16_0)
	return
end

function var_0_0.OnDisplayWorld(arg_17_0, arg_17_1)
	local var_17_0 = EducateCharWordHelper.GetExpression(arg_17_0.ship.educateCharId, arg_17_1)

	if var_17_0 and var_17_0 ~= "" then
		ShipExpressionHelper.UpdateExpression(findTF(arg_17_0.container, "fitter"):GetChild(0), arg_17_0.paintingName, var_17_0)
	else
		ShipExpressionHelper.UpdateExpression(findTF(arg_17_0.container, "fitter"):GetChild(0), arg_17_0.paintingName, "")
	end

	return
end

function var_0_0.OnDisplayWordEnd(arg_18_0)
	arg_18_0:RemoveDelayTellTimeTimer()

	if arg_18_0.waitForCharEnd then
		arg_18_0.delayTellTimeTimer = Timer.New(function()
			arg_18_0:DisplayTellTimeWord(arg_18_0.waitForCharEnd)
			arg_18_0:RemoveDelayTellTimeTimer()
			var_0_0.super.OnDisplayWordEnd(arg_18_0)

			return
		end, math.random(1, 3), 1)

		arg_18_0.delayTellTimeTimer:Start()

		arg_18_0.waitForCharEnd = nil
	else
		var_0_0.super.OnDisplayWordEnd(arg_18_0)
	end

	return
end

function var_0_0.RemoveDelayTellTimeTimer(arg_20_0)
	if arg_20_0.delayTellTimeTimer then
		arg_20_0.delayTellTimeTimer:Stop()

		arg_20_0.delayTellTimeTimer = nil
	end

	return
end

function var_0_0.GetWordAndCv(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0, var_21_1, var_21_2 = EducateCharWordHelper.GetWordAndCV(arg_21_1.educateCharId, arg_21_2)

	return var_21_0, var_21_1, var_21_2
end

function var_0_0.PlayCV(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = EducateCharWordHelper.RawGetCVKey(arg_22_0.ship.educateCharId)

	if not var_22_0 or var_22_0 == "" then
		arg_22_4()

		return
	end

	arg_22_0.cvLoader:Load(var_22_0, arg_22_3, 0, arg_22_4)

	return
end

function var_0_0.CollectIdleEvents(arg_23_0, arg_23_1)
	local var_23_0 = {}

	if getProxy(EventProxy):hasFinishState() and arg_23_1 ~= "event_complete" then
		table.insert(var_23_0, "event_complete")
	else
		local var_23_1 = getProxy(TaskProxy)

		if var_23_1:getCanReceiveCount() > 0 and arg_23_1 ~= "mission_complete" then
			table.insert(var_23_0, "mission_complete")
		end

		local var_23_2 = getProxy(MailProxy)

		if var_23_2:GetUnreadCount() > 0 and arg_23_1 ~= "mail" then
			table.insert(var_23_0, "mail")
		end

		if #var_23_0 == 0 then
			var_23_0 = arg_23_0:FilterExistEvents(var_0_1.GetShipMainEvents(arg_23_0.ship:getSkinId(), -1))

			if getProxy(TaskProxy):getNotFinishCount() then
				if getProxy(TaskProxy):getNotFinishCount() > 0 and arg_23_1 ~= "mission" then
					table.insert(var_23_0, "mission")
				end
			end
		end
	end

	return var_23_0
end

function var_0_0.FilterExistEvents(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		local var_24_0 = pg.AssistantInfo.GetAssistantEvents(iter_24_1)

		if var_24_0 and var_24_0.dialog and EducateCharWordHelper.ExistWord(arg_24_0.ship.educateCharId, var_24_0.dialog) then
			table.insert({}, iter_24_1)
		end
	end

	return {}
end

function var_0_0.CollectTouchEvents(arg_25_0)
	return (arg_25_0:FilterExistEvents(var_0_1.GetShipTouchEvents(arg_25_0.ship:getSkinId(), arg_25_0.ship:getCVIntimacy())))
end

function var_0_0.EnableOrDisableMove(arg_26_0, arg_26_1)
	var_0_0.super.EnableOrDisableMove(arg_26_0, arg_26_1)

	if arg_26_1 then
		arg_26_0.waitForCharEnd = nil

		arg_26_0:RemoveTellTimeTimer()
		arg_26_0:RemoveDelayTellTimeTimer()
	else
		arg_26_0:InitTellTimeService()
	end

	return
end

function var_0_0.OnPause(arg_27_0)
	var_0_0.super.OnPause(arg_27_0)

	arg_27_0.waitForCharEnd = nil

	arg_27_0:RemoveTellTimeTimer()
	arg_27_0:RemoveDelayTellTimeTimer()

	return
end

function var_0_0.OnResume(arg_28_0)
	var_0_0.super.OnResume(arg_28_0)
	arg_28_0:RemoveTellTimeTimer()
	arg_28_0:RemoveDelayTellTimeTimer()
	arg_28_0:InitTellTimeService()

	return
end

function var_0_0.OnUnload(arg_29_0)
	var_0_0.super.OnUnload(arg_29_0)

	arg_29_0.waitForCharEnd = nil

	arg_29_0:RemoveTellTimeTimer()
	arg_29_0:RemoveDelayTellTimeTimer()

	return
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)

	arg_30_0.waitForCharEnd = nil

	arg_30_0:RemoveTellTimeTimer()
	arg_30_0:RemoveDelayTellTimeTimer()

	return
end

return var_0_0
