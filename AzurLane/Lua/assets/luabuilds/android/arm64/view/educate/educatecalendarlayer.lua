local var_0_0 = class("EducateCalendarLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateCalendarUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.calendarTF = arg_2_0._tf:Find("anim_root/calendar")
	arg_2_0.monthTF = arg_2_0.calendarTF:Find("month")

	setText(arg_2_0.monthTF:Find("Text"), i18n("word_month"))

	arg_2_0.weekTF = arg_2_0.calendarTF:Find("week/week")
	arg_2_0.curTime = getProxy(EducateProxy):GetCurTime()
	arg_2_0.anim = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(Animation))
	arg_2_0.animEvent = arg_2_0._tf:Find("anim_root"):GetComponent(typeof(DftAniEvent))

	arg_2_0.animEvent:SetEndEvent(function()
		arg_2_0:emit(var_0_0.ON_CLOSE)

		return
	end)
	arg_2_0.animEvent:SetTriggerEvent(function()
		local var_4_0 = EducateHelper.GetTimeAfterWeeks(arg_2_0.curTime, 1)

		setText(arg_2_0.monthTF, (EducateHelper.GetShowMonthNumber(var_4_0.month)))
		setText(arg_2_0.weekTF, (i18n("word_which_week", var_4_0.week)))

		return
	end)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		groupDelta = 1
	})
	setText(arg_5_0.monthTF, (EducateHelper.GetShowMonthNumber(arg_5_0.curTime.month)))
	setText(arg_5_0.weekTF, (i18n("word_which_week", arg_5_0.curTime.week)))

	return
end

function var_0_0.onBackPressed(arg_6_0)
	return
end

function var_0_0.willExit(arg_7_0)
	arg_7_0:UnOverlayPanel(arg_7_0._tf)

	if arg_7_0.contextData.onExit then
		arg_7_0.contextData.onExit()
	end

	return
end

return var_0_0
