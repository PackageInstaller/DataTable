class = var_0_10000

local var_0_0 = "EducateCalendarLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".base.EducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "EducateCalendarUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.calendarTF = var_1.Find(var_2_0, "anim_root/calendar")

	local var_2_1 = arg_2_0.calendarTF

	arg_2_0.monthTF = var_1.Find(var_2_1, "month")
	setText = var_1

	local var_2_2 = arg_2_0.monthTF
	local var_2_3 = var_2.Find(var_2_2, "Text")

	i18n = var_2_2

	var_1(var_2_3, var_2_2("word_month"))

	local var_2_4 = arg_2_0.calendarTF

	arg_2_0.weekTF = var_1.Find(var_2_4, "week/week")
	getProxy = var_1
	EducateProxy = var_2_4

	local var_2_5 = var_1(var_2_4)

	arg_2_0.curTime = var_1.GetCurTime(var_2_5)

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "anim_root")
	local var_2_8 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.anim = var_2_8(var_2_7, var_3(var_4))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "anim_root")
	local var_2_11 = var_1.GetComponent

	typeof = var_3
	DftAniEvent = var_4
	arg_2_0.animEvent = var_2_11(var_2_10, var_3(var_4))

	local var_2_12 = arg_2_0.animEvent

	var_1.SetEndEvent(var_2_12, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_2_13 = arg_2_0.animEvent

	var_1.SetTriggerEvent(var_2_13, function()
		EducateHelper = var_2_10000

		local var_4_0 = var_2_10000.GetTimeAfterWeeks(arg_2_0.curTime, 1)

		EducateHelper = var_1

		local var_4_1 = var_1.GetShowMonthNumber(var_4_0.month)

		i18n = var_2

		local var_4_2 = var_2("word_which_week", var_4_0.week)

		setText = var_3

		var_3(arg_2_0.monthTF, var_4_1)

		setText = var_3

		var_3(arg_2_0.weekTF, var_4_2)

		return
	end)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})

	EducateHelper = var_1

	local var_5_0 = var_1.GetShowMonthNumber(arg_5_0.curTime.month)

	i18n = var_2

	local var_5_1 = var_2("word_which_week", arg_5_0.curTime.week)

	setText = var_3

	var_3(arg_5_0.monthTF, var_5_0)

	setText = var_3

	var_3(arg_5_0.weekTF, var_5_1)

	return
end

function var_0_1.onBackPressed(arg_6_0)
	return
end

function var_0_1.willExit(arg_7_0)
	arg_7_0:UnOverlayPanel(arg_7_0._tf)

	if arg_7_0.contextData.onExit then
		arg_7_0.contextData.onExit()
	end

	return
end

return var_0_1
