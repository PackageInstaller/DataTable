local var_0_0 = class("EducateDatePanel", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "EducateDatePanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.timeTF = arg_2_0._tf:Find("content/top/time")
	arg_2_0.weekTF = arg_2_0.timeTF:Find("week")
	arg_2_0.dayTF = arg_2_0.timeTF:Find("day")
	arg_2_0.homeTF = arg_2_0._tf:Find("content/top/home")

	setText(arg_2_0.homeTF:Find("Text"), i18n("child_date_text1"))

	arg_2_0.schoolTF = arg_2_0._tf:Find("content/top/school")

	setText(arg_2_0.schoolTF:Find("Text"), i18n("child_date_text2"))

	arg_2_0.upgradeTF = arg_2_0._tf:Find("content/top/upgrade")

	setText(arg_2_0.upgradeTF:Find("Text"), i18n("child_date_text3"))

	arg_2_0.dataTF = arg_2_0._tf:Find("content/top/data")

	setText(arg_2_0.dataTF:Find("Text"), i18n("child_date_text4"))

	arg_2_0.newsBtn = arg_2_0._tf:Find("content/bottom")

	onButton(arg_2_0, arg_2_0.newsBtn, function()
		arg_2_0:emit(EducateBaseUI.EDUCATE_GO_SUBLAYER, Context.New({
			mediator = EducateNewsMediator,
			viewComponent = EducateNewsLayer
		}))

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._tf:Find("content/back"), function()
		if arg_2_0.contextData and arg_2_0.contextData.isMain then
			arg_2_0:emit(EducateBaseUI.EDUCATE_GO_SCENE, SCENE.NEW_EDUCATE_SELECT, {
				isTb1 = true
			})
		else
			arg_2_0:emit(EducateBaseUI.ON_BACK)
		end

		return
	end, SFX_PANEL)

	arg_2_0.targetSetDays = getProxy(EducateProxy):GetTaskProxy():GetTargetSetDays()

	arg_2_0:Flush()

	return
end

function var_0_0.Flush(arg_5_0)
	if not arg_5_0:GetLoaded() then
		return
	end

	arg_5_0.curTime = getProxy(EducateProxy):GetCurTime()
	arg_5_0.status = getProxy(EducateProxy):GetGameStatus()

	setActive(arg_5_0.homeTF, arg_5_0:isHomeShow())
	setActive(arg_5_0.schoolTF, arg_5_0:isSchoolShow())
	setActive(arg_5_0.upgradeTF, arg_5_0:isUpgradeShow())
	setActive(arg_5_0.dataTF, arg_5_0.status == EducateConst.STATUES_RESET)

	local var_5_0 = arg_5_0:isTimeShow()

	setActive(arg_5_0.timeTF, var_5_0)

	if var_5_0 then
		setText(arg_5_0.weekTF, EducateHelper.GetShowMonthNumber(arg_5_0.curTime.month) .. i18n("word_month") .. i18n("word_which_week", arg_5_0.curTime.week))
		setText(arg_5_0.dayTF, EducateHelper.GetWeekStrByNumber(arg_5_0.curTime.day))
	end

	return
end

function var_0_0.UpdateWeekDay(arg_6_0, arg_6_1)
	if not arg_6_0:GetLoaded() then
		return
	end

	local var_6_0 = EducateHelper.GetTimeAfterWeeks(getProxy(EducateProxy):GetCurTime(), 1)

	setText(arg_6_0.weekTF, EducateHelper.GetShowMonthNumber(var_6_0.month) .. i18n("word_month") .. i18n("word_which_week", var_6_0.week))
	setText(arg_6_0.dayTF, EducateHelper.GetWeekStrByNumber(arg_6_1))

	return
end

function var_0_0.isHomeShow(arg_7_0)
	return EducateHelper.IsSameDay(arg_7_0.curTime, arg_7_0.targetSetDays[1])
end

function var_0_0.isSchoolShow(arg_8_0)
	return EducateHelper.IsSameDay(arg_8_0.curTime, arg_8_0.targetSetDays[2])
end

function var_0_0.isUpgradeShow(arg_9_0)
	return EducateHelper.IsSameDay(arg_9_0.curTime, arg_9_0.targetSetDays[3]) or EducateHelper.IsSameDay(arg_9_0.curTime, arg_9_0.targetSetDays[4])
end

function var_0_0.isTimeShow(arg_10_0)
	return not isActive(arg_10_0.homeTF) and not isActive(arg_10_0.schoolTF) and not isActive(arg_10_0.upgradeTF) and not isActive(arg_10_0.dataTF)
end

return var_0_0
