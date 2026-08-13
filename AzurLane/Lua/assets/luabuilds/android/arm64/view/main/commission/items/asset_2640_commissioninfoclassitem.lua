class = var_0_10000

local var_0_0 = "CommissionInfoClassItem"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CommissionInfoItem"))

function var_0_1.OnFlush(arg_1_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getStudents(var_1_0)

	getProxy = var_1_10002
	NavalAcademyProxy = var_1_10004

	local var_1_2 = var_1_10002(var_1_10004)
	local var_1_3 = var_2.getSkillClassNum(var_1_2)

	table = var_1_0

	local var_1_4 = var_1_0.getCount(var_1_1)
	local var_1_5 = 0

	_ = var_5

	local var_1_6 = var_5.each

	_ = var_1_10007

	var_1_6(var_1_10007.values(var_1_1), function(arg_2_0)
		local var_2_0 = arg_2_0:getFinishTime()

		pg = var_2_10002

		local var_2_1 = var_2_10002.TimeMgr.GetInstance()

		if var_2_0 <= var_2.GetServerTime(var_2_1) then
			var_1_5 = var_1_5 + 1
		end

		return
	end)

	arg_1_0.finishedCounter.text = var_1_5
	arg_1_0.ongoingCounter.text = var_1_4 - var_1_5

	local var_1_7 = arg_1_0.leisureCounter

	var_1_7.text = var_1_3 - var_1_4
	setActive = var_1_7

	var_1_7(arg_1_0.finishedCounterContainer, var_1_5 > 0)

	setActive = var_1_7

	var_1_7(arg_1_0.ongoingCounterContainer, var_1_5 < var_1_4)

	setActive = var_1_7

	var_1_7(arg_1_0.leisureCounterContainer, var_1_4 < var_1_3)

	setActive = var_1_7

	var_1_7(arg_1_0.goBtn, var_1_5 == 0)

	setActive = var_1_7

	var_1_7(arg_1_0.finishedBtn, var_1_5 > 0)

	arg_1_0.list = var_1_1

	return
end

function var_0_1.UpdateListItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_2
	local var_3_1 = arg_3_3
	local var_3_2 = arg_3_3.Find(var_3_1, "unlock/name_bg")

	if var_3_0 then
		arg_3_0:UpdateStudent(var_3_0, arg_3_3)

		Vector2 = var_1_10006
		var_3_2.sizeDelta = var_1_10006(267, 45)
	else
		arg_3_0:UpdateEmpty(arg_3_3)

		Vector2 = var_1_10006
		var_3_2.sizeDelta = var_1_10006(400, 45)
	end

	if var_3_0 then
		::label_3_0::

		var_1_10006 = var_3_0:getFinishTime()
		pg = var_3_1

		local var_3_3 = var_3_1.TimeMgr.GetInstance()

		var_1_10006 = var_1_10006 <= var_3_1.GetServerTime(var_3_3)
	end

	setActive = var_3_1

	var_3_1(arg_3_3:Find("unlock"), true)

	setActive = var_3_1

	var_3_1(arg_3_3:Find("lock"), false)

	setActive = var_3_1

	var_3_1(arg_3_3:Find("unlock/leisure"), not var_3_0)

	setActive = var_3_1

	var_3_1(arg_3_3:Find("unlock/ongoging"), var_3_0 and not var_1_10006)

	setActive = var_3_1

	var_3_1(arg_3_3:Find("unlock/finished"), var_3_0 and var_1_10006)

	return
end

function var_0_1.UpdateStudent(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1:getFinishTime()

	pg = var_1_10004

	local var_4_1 = var_1_10004.TimeMgr.GetInstance()
	local var_4_2 = var_4.GetServerTime(var_4_1)
	local var_4_3 = arg_4_1
	local var_4_4 = arg_4_1.getShipVO(var_4_3)
	local var_4_5

	setText = var_4_3

	local var_4_6 = arg_4_2:Find("unlock/name_bg/Text")

	shortenString = var_1_10010

	var_4_3(var_4_6, var_1_10010(arg_4_1:getSkillName(), 7))

	if var_4_2 < var_4_0 then
		arg_4_0:AddTimer(arg_4_1, arg_4_2)

		var_4_5 = arg_4_2:Find("unlock/ongoging/shipicon")
	else
		onButton = var_4_3

		local var_4_7 = arg_4_0
		local var_4_8 = arg_4_2
		local var_4_9 = arg_4_2.Find(var_4_8, "unlock/finished/finish_btn")

		local function var_4_10()
			local var_5_0 = arg_4_0
			local var_5_1 = var_0.emit

			CommissionInfoMediator = var_2_10003

			local var_5_2 = var_2_10003.FINISH_CLASS
			local var_5_3 = arg_4_1.id

			Student = var_2_10005

			var_5_1(var_5_0, var_5_2, var_5_3, var_2_10005.CANCEL_TYPE_AUTO)

			return
		end

		SFX_PANEL = var_4_8

		var_4_3(var_4_7, var_4_9, var_4_10, var_4_8)

		onButton = var_4_3

		local var_4_11 = arg_4_0
		local var_4_12 = arg_4_2

		local function var_4_13()
			triggerButton = var_2_10000

			local var_6_0 = arg_4_2

			var_2_10000(var_2.Find(var_6_0, "unlock/finished/finish_btn"))

			return
		end

		SFX_PANEL = var_4_8

		var_4_3(var_4_11, var_4_12, var_4_13, var_4_8)

		var_4_5 = arg_4_2:Find("unlock/finished/shipicon")
	end

	updateShip = var_4_3

	var_4_3(var_4_5, var_4_4)

	return
end

function var_0_1.AddTimer(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:RemoveTimer(arg_7_1)

	local var_7_0 = arg_7_2:Find("unlock/ongoging/time")
	local var_7_1 = var_3.GetComponent

	typeof = var_6
	Text = var_1_10008

	local var_7_2 = var_7_1(var_7_0, var_6(var_1_10008))
	local var_7_3 = arg_7_1:getFinishTime()
	local var_7_4 = arg_7_0.timers
	local var_7_5 = arg_7_1.id

	Timer = var_1_10007
	var_7_4[var_7_5] = var_1_10007.New(function()
		local var_8_0 = var_7_3

		pg = var_2_10001

		local var_8_1 = var_2_10001.TimeMgr.GetInstance()

		if var_8_0 - var_1.GetServerTime(var_8_1) <= 0 then
			local var_8_2 = arg_7_0

			var_1.RemoveTimer(var_8_2, arg_7_1)

			local var_8_3 = arg_7_0

			var_1.Update(var_8_3)
		else
			local var_8_4 = var_7_2

			pg = var_2_10002

			local var_8_5 = var_2_10002.TimeMgr.GetInstance()

			var_8_4.text = var_2.DescCDTime(var_8_5, var_0)
		end

		return
	end, 1, -1)

	local var_7_6 = arg_7_0.timers[arg_7_1.id]

	var_5.Start(var_7_6)

	local var_7_7 = arg_7_0.timers[arg_7_1.id]

	var_5.func(var_7_7)

	return
end

function var_0_1.RemoveTimer(arg_9_0, arg_9_1)
	if arg_9_0.timers[arg_9_1.id] then
		local var_9_0 = arg_9_0.timers[arg_9_1.id]

		var_2.Stop(var_9_0)

		arg_9_0.timers[arg_9_1.id] = nil
	end

	return
end

function var_0_1.UpdateEmpty(arg_10_0, arg_10_1)
	setText = var_1_10002

	local var_10_0 = arg_10_1:Find("unlock/name_bg/Text")

	i18n = var_1_10005

	var_1_10002(var_10_0, var_1_10005("commission_idle"))

	onButton = var_1_10002

	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_1
	local var_10_3 = arg_10_1.Find(var_10_2, "unlock/leisure/go_btn")

	local function var_10_4()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		CommissionInfoMediator = var_2_10003

		var_11_1(var_11_0, var_2_10003.ON_ACTIVE_CLASS)

		return
	end

	SFX_PANEL = var_10_2

	var_1_10002(var_10_1, var_10_3, var_10_4, var_10_2)

	onButton = var_1_10002

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_1

	local function var_10_7()
		local var_12_0 = arg_10_0

		var_0.OnSkip(var_12_0)

		return
	end

	SFX_PANEL = var_10_2

	var_1_10002(var_10_5, var_10_6, var_10_7, var_10_2)

	return
end

function var_0_1.GetList(arg_13_0)
	getProxy = var_1_10001
	NavalAcademyProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getSkillClassNum(var_13_0)

	return arg_13_0.list, var_13_1
end

function var_0_1.OnSkip(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.emit

	CommissionInfoMediator = var_1_10004

	var_14_1(var_14_0, var_1_10004.ON_ACTIVE_CLASS)

	return
end

function var_0_1.OnFinishAll(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.emit

	CommissionInfoMediator = var_1_10004

	var_15_1(var_15_0, var_1_10004.FINISH_CLASS_ALL)

	return
end

return var_0_1
