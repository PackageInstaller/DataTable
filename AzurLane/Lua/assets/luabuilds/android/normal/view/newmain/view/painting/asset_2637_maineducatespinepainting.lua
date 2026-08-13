class = var_0_10000

local var_0_0 = "MainEducateSpinePainting"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".MainSpinePainting"))
local var_0_2

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	pg = var_4
	var_0_2 = var_4.AssistantInfo

	return
end

function var_0_1.OnLoad(arg_2_0, arg_2_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_3_0)
			var_0_1.super.OnLoad(arg_2_0, arg_3_0)

			return
		end
	}, function()
		local var_4_0 = arg_2_0

		var_0.InitTellTimeService(var_4_0)
		arg_2_1()

		return
	end)

	return
end

function var_0_1.OnFirstTimeTriggerEvent(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.TimeMgr.GetInstance()
	local var_5_1 = var_1.GetServerTime(var_5_0)

	ChineseCalendar = var_5_0

	local var_5_2, var_5_3, var_5_4 = var_5_0.GetCurrYearMonthDay(var_5_1)

	local function var_5_5(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.DisplayWord(var_6_0, arg_6_0)

		getProxy = var_1
		SettingsProxy = var_6_0

		local var_6_1 = var_1(var_6_0)

		var_1.RecordTipDay(var_6_1, var_5_2, var_5_3, var_5_4)

		return
	end

	local function var_5_6()
		getProxy = var_2_10000
		SettingsProxy = var_2_10001

		local var_7_0 = var_2_10000(var_2_10001)

		return var_0.IsTipDay(var_7_0, var_5_2, var_5_3, var_5_4)
	end

	ChineseCalendar = var_1_10007

	local var_5_7

	if var_1_10007.IsNewYear(var_5_2, var_5_3, var_5_4) and not var_5_6() then
		var_5_7 = var_5_5
		EducateCharWordHelper = var_8

		var_5_7(var_8.WORD_KEY_NEWYEAR)
	else
		ChineseCalendar = var_5_7

		local var_5_8

		if var_5_7.IsLunarNewYear(var_5_2, var_5_3, var_5_4) and not var_5_6() then
			var_5_8 = var_5_5
			EducateCharWordHelper = var_8

			var_5_8(var_8.WORD_KEY_LUNARNEWYEAR)
		else
			ChineseCalendar = var_5_8

			local var_5_9

			if var_5_8.IsValentineDay(var_5_2, var_5_3, var_5_4) and not var_5_6() then
				var_5_9 = var_5_5
				EducateCharWordHelper = var_8

				var_5_9(var_8.WORD_KEY_VALENTINE)
			else
				ChineseCalendar = var_5_9

				local var_5_10

				if var_5_9.IsMidAutumnFestival(var_5_2, var_5_3, var_5_4) and not var_5_6() then
					var_5_10 = var_5_5
					EducateCharWordHelper = var_8

					var_5_10(var_8.WORD_KEY_MIDAUTUMNFESTIVAL)
				else
					ChineseCalendar = var_5_10

					local var_5_11

					if var_5_10.AllHallowsDay(var_5_2, var_5_3, var_5_4) and not var_5_6() then
						var_5_11 = var_5_5
						EducateCharWordHelper = var_8

						var_5_11(var_8.WORD_KEY_ALLHALLOWSDAY)
					else
						ChineseCalendar = var_5_11

						local var_5_12

						if var_5_11.IsChristmas(var_5_2, var_5_3, var_5_4) and not var_5_6() then
							var_5_12 = var_5_5
							EducateCharWordHelper = var_8

							var_5_12(var_8.WORD_KEY_CHRISTMAS)
						else
							getProxy = var_5_12
							PlayerProxy = var_8

							local var_5_13 = var_5_12(var_8)
							local var_5_14

							if not var_7.getFlag(var_5_13, "tb_activity") then
								var_5_13 = arg_5_0

								if arg_5_0.ExistImportantActivity(var_5_13) then
									getProxy = var_5_14
									PlayerProxy = var_5_13
									var_5_13 = var_5_14(var_5_13)

									var_5_14.setFlag(var_5_13, "tb_activity", true)

									var_5_13 = arg_5_0
									var_5_14 = arg_5_0.DisplayWord
									EducateCharWordHelper = var_9

									var_5_14(var_5_13, var_9.WORD_KEY_ACT)

									goto label_5_0
								end
							end

							getProxy = var_5_14
							PlayerProxy = var_5_13

							local var_5_15 = var_5_14(var_5_13)

							if var_7.getFlag(var_5_15, "change_tb") then
								getProxy = var_7
								PlayerProxy = var_5_15

								local var_5_16 = var_7(var_5_15)

								var_7.setFlag(var_5_16, "change_tb", nil)

								local var_5_17 = arg_5_0
								local var_5_18 = arg_5_0.DisplayWord

								EducateCharWordHelper = var_9

								var_5_18(var_5_17, var_9.WORD_KEY_CHANGE_TB)
							else
								var_0_1.super.OnFirstTimeTriggerEvent(arg_5_0)
							end
						end
					end
				end
			end
		end
	end

	::label_5_0::

	return
end

function var_0_1.ExistImportantActivity(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.gameset.secretary_special_ship_event_type.description

	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_8_1 = var_1_10002(var_1_10003)

	_ = var_1_10003

	return var_1_10003.any(var_8_0, function(arg_9_0)
		local var_9_0 = var_8_1
		local var_9_1

		var_9_1 = var_1.getActivityByType(var_9_0, arg_9_0) and not var_1:isEnd()

		return var_9_1
	end)
end

function var_0_1.InitTellTimeService(arg_10_0)
	arg_10_0:RemoveTellTimeTimer()

	GetNextHour = var_1

	local var_10_0 = var_1(1)

	pg = var_2

	local var_10_1 = var_2.TimeMgr.GetInstance()

	if var_10_0 - var_2.GetServerTime(var_10_1) >= 0 then
		arg_10_0:TriggerTellTime(var_2)
	else
		arg_10_0:AddTellTimeTimer(var_10_0, var_3)
	end

	return
end

function var_0_1.AddTellTimeTimer(arg_11_0, arg_11_1, arg_11_2)
	Timer = var_1_10003
	arg_11_0.tellTimeTimer = var_1_10003.New(function()
		if arg_11_0.chatting then
			arg_11_0.waitForCharEnd = arg_11_1

			return
		end

		local var_12_0 = arg_11_0

		var_0.DisplayTellTimeWord(var_12_0, arg_11_1)

		local var_12_1 = arg_11_0

		var_0.RemoveTellTimeTimer(var_12_1)

		return
	end, arg_11_2, 1)

	local var_11_0 = arg_11_0.tellTimeTimer

	var_3.Start(var_11_0)

	return
end

function var_0_1.RemoveTellTimeTimer(arg_13_0)
	if arg_13_0.tellTimeTimer then
		local var_13_0 = arg_13_0.tellTimeTimer

		var_1.Stop(var_13_0)

		arg_13_0.tellTimeTimer = nil
	end

	return
end

function var_0_1.DisplayTellTimeWord(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0 = var_1_10002.TimeMgr.GetInstance()
	local var_14_1 = var_2.STimeDescC(var_14_0, arg_14_1, "%Y:%m:%d:%H:%M:%S")

	string = var_14_0

	local var_14_2 = var_14_0.split(var_14_1, ":")

	tonumber = var_4

	local var_14_3 = var_4(var_14_2[4])
	local var_14_4 = arg_14_0
	local var_14_5 = arg_14_0.DisplayWord

	EducateCharWordHelper = var_1_10007

	var_14_5(var_14_4, var_1_10007.WORD_KEY_TELL_TIME .. var_14_3)

	return
end

function var_0_1.TriggerPersonalTask(arg_15_0)
	if arg_15_0.isFoldState then
		return
	end

	arg_15_0:TriggerInterActionTask()

	return
end

function var_0_1.OnLongPress(arg_16_0)
	return
end

function var_0_1.OnDisplayWorld(arg_17_0, arg_17_1)
	EducateCharWordHelper = var_1_10002

	local var_17_0 = var_1_10002.GetExpression(arg_17_0.ship.educateCharId, arg_17_1)

	expressionAnimName = var_3

	if var_3 ~= "" then
		local var_17_1 = arg_17_0.spinePainting

		var_3.SetAction(var_17_1, var_17_0, 1)

		local var_17_2 = arg_17_0.spinePainting

		var_3.displayWord(var_17_2, true)
	end

	return
end

function var_0_1.OnDisplayWordEnd(arg_18_0)
	arg_18_0:RemoveDelayTellTimeTimer()

	if arg_18_0.waitForCharEnd then
		math = var_1

		local var_18_0 = var_1.random(1, 3)

		Timer = var_2
		arg_18_0.delayTellTimeTimer = var_2.New(function()
			local var_19_0 = arg_18_0

			var_0.DisplayTellTimeWord(var_19_0, arg_18_0.waitForCharEnd)

			local var_19_1 = arg_18_0

			var_0.RemoveDelayTellTimeTimer(var_19_1)
			var_0_1.super.OnDisplayWordEnd(arg_18_0)

			return
		end, var_18_0, 1)

		local var_18_1 = arg_18_0.delayTellTimeTimer

		var_2.Start(var_18_1)

		arg_18_0.waitForCharEnd = nil
	else
		var_0_1.super.OnDisplayWordEnd(arg_18_0)
	end

	return
end

function var_0_1.RemoveDelayTellTimeTimer(arg_20_0)
	if arg_20_0.delayTellTimeTimer then
		local var_20_0 = arg_20_0.delayTellTimeTimer

		var_1.Stop(var_20_0)

		arg_20_0.delayTellTimeTimer = nil
	end

	return
end

function var_0_1.GetWordAndCv(arg_21_0, arg_21_1, arg_21_2)
	EducateCharWordHelper = var_1_10003

	local var_21_0, var_21_1, var_21_2 = var_1_10003.GetWordAndCV(arg_21_1.educateCharId, arg_21_2)

	return var_21_0, var_21_1, var_21_2
end

function var_0_1.PlayCV(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	EducateCharWordHelper = var_1_10005

	if not var_1_10005.RawGetCVKey(arg_22_0.ship.educateCharId) or var_5 == "" then
		arg_22_4()

		return
	end

	local var_22_0 = var_5
	local var_22_1 = arg_22_0.cvLoader

	var_7.Load(var_22_1, var_22_0, arg_22_3, 0, arg_22_4)

	return
end

function var_0_1.CollectIdleEvents(arg_23_0, arg_23_1)
	local var_23_0 = {}

	getProxy = var_1_10003
	EventProxy = var_1_10004

	local var_23_1 = var_1_10003(var_1_10004)

	if var_3.hasFinishState(var_23_1) and arg_23_1 ~= "event_complete" then
		table = var_3

		var_3.insert(var_23_0, "event_complete")
	else
		getProxy = var_3
		TaskProxy = var_23_1

		local var_23_2 = var_3(var_23_1)
		local var_23_3 = var_3.getCanReceiveCount(var_23_2)

		if 0 < var_23_3 and arg_23_1 ~= "mission_complete" then
			table = var_23_3

			var_23_3.insert(var_23_0, "mission_complete")
		end

		getProxy = var_23_3
		MailProxy = var_4

		local var_23_4 = var_23_3(var_4)

		if var_3.GetUnreadCount(var_23_4) > 0 and arg_23_1 ~= "mail" then
			table = var_3

			var_3.insert(var_23_0, "mail")
		end

		if #var_23_0 == 0 then
			local var_23_5 = arg_23_0
			local var_23_6 = arg_23_0.FilterExistEvents
			local var_23_7 = var_0_2.GetShipMainEvents
			local var_23_8 = arg_23_0.ship
			local var_23_9 = var_6.getSkinId(var_23_8)
			local var_23_10 = arg_23_0.ship

			var_23_0 = var_23_6(var_23_5, var_23_7(var_23_9, var_7.getCVIntimacy(var_23_10)))
			getProxy = var_3
			TaskProxy = var_23_5

			local var_23_11 = var_3(var_23_5)

			if var_3.getNotFinishCount(var_23_11) then
				getProxy = var_3
				TaskProxy = var_23_11

				local var_23_12 = var_3(var_23_11)

				if var_3.getNotFinishCount(var_23_12) > 0 and arg_23_1 ~= "mission" then
					table = var_3

					var_3.insert(var_23_0, "mission")
				end
			end
		end
	end

	return var_23_0
end

function var_0_1.FilterExistEvents(arg_24_0, arg_24_1)
	local var_24_0 = {}

	pairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_1) do
		pg = var_1_10008

		if var_1_10008.AssistantInfo.GetAssistantEvents(iter_24_1) and var_1_10008.dialog then
			EducateCharWordHelper = var_9

			if var_9.ExistWord(arg_24_0.ship.educateCharId, var_1_10008.dialog) then
				table = var_9

				var_9.insert(var_24_0, iter_24_1)
			end
		end
	end

	return var_24_0
end

function var_0_1.CollectTouchEvents(arg_25_0)
	local var_25_0 = arg_25_0
	local var_25_1 = arg_25_0.FilterExistEvents
	local var_25_2 = var_0_2.GetShipTouchEvents
	local var_25_3 = arg_25_0.ship
	local var_25_4 = var_4.getSkinId(var_25_3)
	local var_25_5 = arg_25_0.ship

	return (var_25_1(var_25_0, var_25_2(var_25_4, var_5.getCVIntimacy(var_25_5))))
end

function var_0_1.EnableOrDisableMove(arg_26_0, arg_26_1)
	var_0_1.super.EnableOrDisableMove(arg_26_0, arg_26_1)

	if arg_26_1 then
		arg_26_0.waitForCharEnd = nil

		arg_26_0:RemoveTellTimeTimer()
		arg_26_0:RemoveDelayTellTimeTimer()
	else
		arg_26_0:InitTellTimeService()
	end

	return
end

function var_0_1.OnPause(arg_27_0)
	var_0_1.super.OnPause(arg_27_0)

	arg_27_0.waitForCharEnd = nil

	arg_27_0:RemoveTellTimeTimer()
	arg_27_0:RemoveDelayTellTimeTimer()

	return
end

function var_0_1.OnResume(arg_28_0)
	var_0_1.super.OnResume(arg_28_0)
	arg_28_0:RemoveTellTimeTimer()
	arg_28_0:RemoveDelayTellTimeTimer()
	arg_28_0:InitTellTimeService()

	return
end

function var_0_1.OnUnload(arg_29_0)
	var_0_1.super.OnUnload(arg_29_0)

	arg_29_0.waitForCharEnd = nil

	arg_29_0:RemoveTellTimeTimer()
	arg_29_0:RemoveDelayTellTimeTimer()

	return
end

function var_0_1.Dispose(arg_30_0)
	var_0_1.super.Dispose(arg_30_0)

	arg_30_0.waitForCharEnd = nil

	arg_30_0:RemoveTellTimeTimer()
	arg_30_0:RemoveDelayTellTimeTimer()

	return
end

return var_0_1
