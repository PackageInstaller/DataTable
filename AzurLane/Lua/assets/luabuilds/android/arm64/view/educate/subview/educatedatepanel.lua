class = var_0_10000

local var_0_0 = "EducateDatePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "EducateDatePanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.timeTF = var_1.Find(var_2_0, "content/top/time")

	local var_2_1 = arg_2_0.timeTF

	arg_2_0.weekTF = var_1.Find(var_2_1, "week")

	local var_2_2 = arg_2_0.timeTF

	arg_2_0.dayTF = var_1.Find(var_2_2, "day")

	local var_2_3 = arg_2_0._tf

	arg_2_0.homeTF = var_1.Find(var_2_3, "content/top/home")
	setText = var_1

	local var_2_4 = arg_2_0.homeTF
	local var_2_5 = var_3.Find(var_2_4, "Text")

	i18n = var_4

	var_1(var_2_5, var_4("child_date_text1"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.schoolTF = var_1.Find(var_2_6, "content/top/school")
	setText = var_1

	local var_2_7 = arg_2_0.schoolTF
	local var_2_8 = var_3.Find(var_2_7, "Text")

	i18n = var_4

	var_1(var_2_8, var_4("child_date_text2"))

	local var_2_9 = arg_2_0._tf

	arg_2_0.upgradeTF = var_1.Find(var_2_9, "content/top/upgrade")
	setText = var_1

	local var_2_10 = arg_2_0.upgradeTF
	local var_2_11 = var_3.Find(var_2_10, "Text")

	i18n = var_4

	var_1(var_2_11, var_4("child_date_text3"))

	local var_2_12 = arg_2_0._tf

	arg_2_0.dataTF = var_1.Find(var_2_12, "content/top/data")
	setText = var_1

	local var_2_13 = arg_2_0.dataTF
	local var_2_14 = var_3.Find(var_2_13, "Text")

	i18n = var_4

	var_1(var_2_14, var_4("child_date_text4"))

	local var_2_15 = arg_2_0._tf

	arg_2_0.newsBtn = var_1.Find(var_2_15, "content/bottom")
	onButton = var_1

	local var_2_16 = arg_2_0
	local var_2_17 = arg_2_0.newsBtn

	local function var_2_18()
		local var_3_0 = arg_2_0
		local var_3_1 = var_0.emit

		EducateBaseUI = var_2_10003

		local var_3_2 = var_2_10003.EDUCATE_GO_SUBLAYER

		Context = var_2_10004

		local var_3_3 = var_2_10004.New
		local var_3_4 = {}

		EducateNewsMediator = var_2_10007
		var_3_4.mediator = var_2_10007
		EducateNewsLayer = var_2_10007
		var_3_4.viewComponent = var_2_10007

		var_3_1(var_3_0, var_3_2, var_3_3(var_3_4))

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_16, var_2_17, var_2_18, var_6)

	onButton = var_1

	local var_2_19 = arg_2_0
	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_4.Find(var_2_20, "content/back")

	local function var_2_22()
		if arg_2_0.contextData and arg_2_0.contextData.isMain then
			local var_4_0 = arg_2_0
			local var_4_1 = var_0.emit

			EducateBaseUI = var_2_10003
			var_2_10003 = var_2_10003.EDUCATE_GO_SCENE
			SCENE = var_2_10004

			var_4_1(var_4_0, var_2_10003, var_2_10004.NEW_EDUCATE_SELECT, {
				isTb1 = true
			})
		else
			local var_4_2 = arg_2_0
			local var_4_3 = var_0.emit

			EducateBaseUI = var_2_10003

			var_4_3(var_4_2, var_2_10003.ON_BACK)
		end

		return
	end

	SFX_PANEL = var_2_20

	var_1(var_2_19, var_2_21, var_2_22, var_2_20)

	getProxy = var_1
	EducateProxy = var_2_19

	local var_2_23 = var_1(var_2_19)
	local var_2_24 = var_1.GetTaskProxy(var_2_23)

	arg_2_0.targetSetDays = var_1.GetTargetSetDays(var_2_24)

	arg_2_0:Flush()

	return
end

function var_0_1.Flush(arg_5_0)
	local var_5_0 = arg_5_0

	if not arg_5_0.GetLoaded(var_5_0) then
		return
	end

	getProxy = var_1
	EducateProxy = var_5_0

	local var_5_1 = var_1(var_5_0)

	arg_5_0.curTime = var_1.GetCurTime(var_5_1)
	getProxy = var_1
	EducateProxy = var_5_1

	local var_5_2 = var_1(var_5_1)

	arg_5_0.status = var_1.GetGameStatus(var_5_2)
	setActive = var_1

	var_1(arg_5_0.homeTF, arg_5_0:isHomeShow())

	setActive = var_1

	var_1(arg_5_0.schoolTF, arg_5_0:isSchoolShow())

	setActive = var_1

	local var_5_3 = arg_5_0.upgradeTF
	local var_5_4 = arg_5_0

	var_1(var_5_3, arg_5_0.isUpgradeShow(var_5_4))

	setActive = var_1

	local var_5_5 = arg_5_0.dataTF
	local var_5_6 = arg_5_0.status

	EducateConst = var_1_10005

	var_1(var_5_5, var_5_6 == var_1_10005.STATUES_RESET)

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.isTimeShow(var_5_7)

	setActive = var_1_10002

	var_1_10002(arg_5_0.timeTF, var_5_8)

	if var_5_8 then
		local var_5_9 = arg_5_0.curTime.month

		EducateHelper = var_5_7

		local var_5_10 = var_5_7.GetShowMonthNumber(var_5_9)

		i18n = var_5

		local var_5_11 = var_5("word_month")

		i18n = var_5_4

		local var_5_12 = var_5_10 .. var_5_11 .. var_5_4("word_which_week", arg_5_0.curTime.week)

		setText = var_5_11

		var_5_11(arg_5_0.weekTF, var_5_12)

		setText = var_5_11

		local var_5_13 = arg_5_0.dayTF

		EducateHelper = var_8

		var_5_11(var_5_13, var_8.GetWeekStrByNumber(arg_5_0.curTime.day))
	end

	return
end

function var_0_1.UpdateWeekDay(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0

	if not arg_6_0.GetLoaded(var_6_0) then
		return
	end

	EducateHelper = var_2

	local var_6_1 = var_2.GetTimeAfterWeeks

	getProxy = var_6_0
	EducateProxy = var_1_10006

	local var_6_2 = var_6_0(var_1_10006)
	local var_6_3 = var_6_1(var_4.GetCurTime(var_6_2), 1)

	EducateHelper = var_1_10003

	local var_6_4 = var_1_10003.GetShowMonthNumber(var_6_3.month)

	i18n = var_5

	local var_6_5 = var_5("word_month")

	i18n = var_6_2

	local var_6_6 = var_6_4 .. var_6_5 .. var_6_2("word_which_week", var_6_3.week)

	setText = var_6_5

	var_6_5(arg_6_0.weekTF, var_6_6)

	setText = var_6_5

	local var_6_7 = arg_6_0.dayTF

	EducateHelper = var_8

	var_6_5(var_6_7, var_8.GetWeekStrByNumber(arg_6_1))

	return
end

function var_0_1.isHomeShow(arg_7_0)
	EducateHelper = var_1_10001

	return var_1_10001.IsSameDay(arg_7_0.curTime, arg_7_0.targetSetDays[1])
end

function var_0_1.isSchoolShow(arg_8_0)
	EducateHelper = var_1_10001

	return var_1_10001.IsSameDay(arg_8_0.curTime, arg_8_0.targetSetDays[2])
end

function var_0_1.isUpgradeShow(arg_9_0)
	EducateHelper = var_1_10001

	local var_9_0

	if not var_1_10001.IsSameDay(arg_9_0.curTime, arg_9_0.targetSetDays[3]) then
		EducateHelper = var_9_0
		var_9_0 = var_9_0.IsSameDay(arg_9_0.curTime, arg_9_0.targetSetDays[4])
	end

	return var_9_0
end

function var_0_1.isTimeShow(arg_10_0)
	isActive = var_1_10001

	local var_10_0

	if not var_1_10001(arg_10_0.homeTF) then
		isActive = var_1

		if not var_1(arg_10_0.schoolTF) then
			isActive = var_1

			if not var_1(arg_10_0.upgradeTF) then
				isActive = var_1
				var_10_0 = not var_1(arg_10_0.dataTF)

				goto label_10_0
			end
		end
	end

	var_10_0 = false

	if false then
		var_10_0 = true
	end

	::label_10_0::

	return var_10_0
end

return var_0_1
