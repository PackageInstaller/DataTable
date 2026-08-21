local var_0_0 = class("CommissionInfoClassItem", import(".CommissionInfoItem"))

function var_0_0.OnFlush(arg_1_0)
	local var_1_0 = getProxy(NavalAcademyProxy):getStudents()
	local var_1_1 = getProxy(NavalAcademyProxy):getSkillClassNum()
	local var_1_2 = table.getCount(var_1_0)
	local var_1_3 = 0

	_.each(_.values(var_1_0), function(arg_2_0)
		if arg_2_0:getFinishTime() <= pg.TimeMgr.GetInstance():GetServerTime() then
			var_1_3 = var_1_3 + 1
		end

		return
	end)

	arg_1_0.finishedCounter.text = var_1_3
	arg_1_0.ongoingCounter.text = var_1_2 - var_1_3
	arg_1_0.leisureCounter.text = var_1_1 - var_1_2

	setActive(arg_1_0.finishedCounterContainer, var_1_3 > 0)
	setActive(arg_1_0.ongoingCounterContainer, var_1_3 < var_1_2)
	setActive(arg_1_0.leisureCounterContainer, var_1_2 < var_1_1)
	setActive(arg_1_0.goBtn, var_1_3 == 0)
	setActive(arg_1_0.finishedBtn, var_1_3 > 0)

	arg_1_0.list = var_1_0

	return
end

function var_0_0.UpdateListItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3:Find("unlock/name_bg")

	if arg_3_2 then
		arg_3_0:UpdateStudent(arg_3_2, arg_3_3)

		var_3_0.sizeDelta = Vector2(267, 45)
	else
		arg_3_0:UpdateEmpty(arg_3_3)

		var_3_0.sizeDelta = Vector2(400, 45)
	end

	local var_3_1

	if arg_3_2 then
		::label_3_0::

		var_3_1 = arg_3_2:getFinishTime() <= pg.TimeMgr.GetInstance():GetServerTime()
	end

	setActive(arg_3_3:Find("unlock"), true)
	setActive(arg_3_3:Find("lock"), false)
	setActive(arg_3_3:Find("unlock/leisure"), not arg_3_2)
	setActive(arg_3_3:Find("unlock/ongoging"), arg_3_2 and not var_3_1)
	setActive(arg_3_3:Find("unlock/finished"), arg_3_2 and var_3_1)

	return
end

function var_0_0.UpdateStudent(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getShipVO()
	local var_4_1

	setText(arg_4_2:Find("unlock/name_bg/Text"), shortenString(arg_4_1:getSkillName(), 7))

	if pg.TimeMgr.GetInstance():GetServerTime() < arg_4_1:getFinishTime() then
		arg_4_0:AddTimer(arg_4_1, arg_4_2)

		var_4_1 = arg_4_2:Find("unlock/ongoging/shipicon")
	else
		onButton(arg_4_0, arg_4_2:Find("unlock/finished/finish_btn"), function()
			arg_4_0:emit(CommissionInfoMediator.FINISH_CLASS, arg_4_1.id, Student.CANCEL_TYPE_AUTO)

			return
		end, SFX_PANEL)
		onButton(arg_4_0, arg_4_2, function()
			triggerButton(arg_4_2:Find("unlock/finished/finish_btn"))

			return
		end, SFX_PANEL)

		var_4_1 = arg_4_2:Find("unlock/finished/shipicon")
	end

	updateShip(var_4_1, var_4_0)

	return
end

function var_0_0.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:RemoveTimer(arg_7_1)

	local var_7_0 = arg_7_2:Find("unlock/ongoging/time"):GetComponent(typeof(Text))
	local var_7_1 = arg_7_1:getFinishTime()

	arg_7_0.timers[arg_7_1.id] = Timer.New(function()
		local var_8_0 = var_7_1 - pg.TimeMgr.GetInstance():GetServerTime()

		if var_8_0 <= 0 then
			arg_7_0:RemoveTimer(arg_7_1)
			arg_7_0:Update()
		else
			local var_8_1 = var_7_0

			var_8_1.text = pg.TimeMgr.GetInstance():DescCDTime(var_8_0)
		end

		return
	end, 1, -1)

	arg_7_0.timers[arg_7_1.id]:Start()
	arg_7_0.timers[arg_7_1.id]:func()

	return
end

function var_0_0.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1.id] then
		arg_9_0.timers[arg_9_1.id]:Stop()

		arg_9_0.timers[arg_9_1.id] = nil
	end

	return
end

function var_0_0.UpdateEmpty(arg_10_0, arg_10_1)
	setText(arg_10_1:Find("unlock/name_bg/Text"), i18n("commission_idle"))
	onButton(arg_10_0, arg_10_1:Find("unlock/leisure/go_btn"), function()
		arg_10_0:emit(CommissionInfoMediator.ON_ACTIVE_CLASS)

		return
	end, SFX_PANEL)
	onButton(arg_10_0, arg_10_1, function()
		arg_10_0:OnSkip()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetList(arg_13_0)
	return arg_13_0.list, (getProxy(NavalAcademyProxy):getSkillClassNum())
end

function var_0_0.OnSkip(arg_14_0)
	arg_14_0:emit(CommissionInfoMediator.ON_ACTIVE_CLASS)

	return
end

function var_0_0.OnFinishAll(arg_15_0)
	arg_15_0:emit(CommissionInfoMediator.FINISH_CLASS_ALL)

	return
end

return var_0_0
