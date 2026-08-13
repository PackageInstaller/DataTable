class = var_0_10000

local var_0_0 = "NewFrameTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.battleBtn = var_1.Find(var_1_1, "battle_btn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "get_btn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "got_btn")

	local var_1_4 = arg_1_0._tf

	arg_1_0.switchBtn = var_1.Find(var_1_4, "AD/switch_btn")

	local var_1_5 = {}
	local var_1_6 = arg_1_0._tf

	var_1_5[1] = var_2.Find(var_1_6, "AD/switcher/phase1")

	local var_1_7 = arg_1_0._tf

	var_1_5[2] = var_2.Find(var_1_7, "AD/switcher/phase2")
	arg_1_0.phases = var_1_5

	local var_1_8 = arg_1_0._tf

	arg_1_0.bar = var_1.Find(var_1_8, "AD/switcher/phase2/Image/barContent/bar")

	local var_1_9 = arg_1_0._tf

	arg_1_0.cur = var_1.Find(var_1_9, "AD/switcher/phase2/Image/step")

	local var_1_10 = arg_1_0._tf

	arg_1_0.target = var_1.Find(var_1_10, "AD/switcher/phase2/Image/progress")

	local var_1_11 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_11, "AD/switcher/phase2/Image/got")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.activity_event_avatarframe
	local var_2_1 = arg_2_0.activity

	arg_2_0.avatarConfig = var_2_0[var_2.getConfig(var_2_1, "config_id")]

	if arg_2_0.avatarConfig.start_time == "stop" then
		arg_2_0.timeStamp = nil
	else
		pg = var_2

		local var_2_2 = var_2.TimeMgr.GetInstance()

		arg_2_0.timeStamp = var_2.parseTimeFromConfig(var_2_2, var_1)
	end

	return
end

function var_0_1.OnFirstFlush(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.battleBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_4_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_4_1(var_4_0, var_4_2, var_2_10004.TASK)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		ActivityMediator = var_2_10003

		var_5_1(var_5_0, var_2_10003.EVENT_OPERATION, {
			cmd = 1,
			activity_id = arg_3_0.activity.id
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.switchBtn

	local function var_3_8(arg_6_0)
		if arg_3_0.isSwitching then
			return
		end

		local var_6_0 = arg_3_0

		var_1.Switch(var_6_0, arg_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_10

	if arg_3_0.timeStamp then
		pg = var_3_10

		local var_3_9 = var_3_10.TimeMgr.GetInstance()

		var_3_10 = var_3_10.GetServerTime(var_3_9) - arg_3_0.timeStamp > 0
	end

	arg_3_0.inPhase2 = var_3_10
	triggerToggle = var_3_10

	var_3_10(arg_3_0.switchBtn, arg_3_0.inPhase2)

	IsNil = var_3_10

	local var_3_11 = arg_3_0.gotTag

	if not var_3_10(var_3.Find(var_3_11, "Text")) then
		setText = var_1

		local var_3_12 = arg_3_0.gotTag
		local var_3_13 = var_3.Find(var_3_12, "Text")

		i18n = var_4

		var_1(var_3_13, var_4("avatarframe_got"))
	end

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	local var_7_0 = arg_7_0.activity.data1

	var_7_0 = arg_7_0.avatarConfig.target < var_7_0 and var_2 or var_7_0

	local var_7_1 = var_7_0 / var_2

	setText = var_1_10004

	var_1_10004(arg_7_0.cur, var_7_1 >= 1 and var_7_0 or var_7_0)

	setText = var_1_10004

	var_1_10004(arg_7_0.target, "/" .. var_2)

	setFillAmount = var_1_10004

	var_1_10004(arg_7_0.bar, var_7_1)

	local var_7_2 = var_2 <= var_7_0
	local var_7_3 = arg_7_0.activity.data2
	local var_7_4 = 1 <= var_7_3

	setActive = var_6

	local var_7_5 = arg_7_0.battleBtn
	local var_7_6

	if arg_7_0.inPhase2 then
		var_7_6 = not var_7_2
	end

	var_6(var_7_5, var_7_6)

	setActive = var_6

	local var_7_7 = arg_7_0.getBtn
	local var_7_8

	if arg_7_0.inPhase2 then
		var_7_8 = not var_7_4 and var_7_2
	end

	var_6(var_7_7, var_7_8)

	setActive = var_6

	local var_7_9 = arg_7_0.gotBtn
	local var_7_10

	if arg_7_0.inPhase2 then
		var_7_10 = var_7_4
	end

	var_6(var_7_9, var_7_10)

	setActive = var_6

	local var_7_11 = arg_7_0.gotTag
	local var_7_12

	if arg_7_0.inPhase2 then
		var_7_12 = var_7_4
	end

	var_6(var_7_11, var_7_12)

	setActive = var_6

	var_6(arg_7_0.cur, not var_7_4)

	setActive = var_6

	var_6(arg_7_0.target, not var_7_4)

	return
end

function var_0_1.Switch(arg_8_0, arg_8_1)
	arg_8_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_8_0.switchBtn, false)

	local var_8_0
	local var_8_1
	local var_8_2

	if arg_8_1 then
		var_8_2 = arg_8_0.phases[1]
		var_8_1 = arg_8_0.phases[2]
		var_8_0 = var_8_2
	else
		var_8_2 = arg_8_0.phases[2]
		var_8_1 = arg_8_0.phases[1]
		var_8_0 = var_8_2
	end

	GetOrAddComponent = var_8_2

	local var_8_3 = var_8_0

	typeof = var_1_10007
	CanvasGroup = var_1_10009

	local var_8_4 = var_8_2(var_8_3, var_1_10007(var_1_10009))
	local var_8_5 = var_8_0.localPosition
	local var_8_6 = var_8_1.localPosition

	var_8_1:SetAsLastSibling()

	setActive = var_7

	var_7(var_8_0:Find("Image"), false)

	LeanTween = var_7

	local var_8_7 = var_7.moveLocal

	go = var_9

	local var_8_8 = var_8_7(var_9(var_8_0), var_8_6, 0.4)
	local var_8_9 = var_7.setOnComplete

	System = var_10

	var_8_9(var_8_8, var_10.Action(function()
		setActive = var_2_10000

		local var_9_0 = var_8_0

		var_2_10000(var_2.Find(var_9_0, "label"), true)

		return
	end))

	LeanTween = var_8_9

	local var_8_10 = var_8_9.value

	go = var_8_8

	local var_8_11 = var_8_10(var_8_8(var_8_0), 0, 1, 0.4)
	local var_8_12 = var_7.setOnUpdate

	System = var_10

	var_8_12(var_8_11, var_10.Action_float(function(arg_10_0)
		var_8_4.alpha = arg_10_0

		return
	end))

	setActive = var_8_12

	var_8_12(var_8_1:Find("Image"), true)

	GetOrAddComponent = var_8_12

	local var_8_13 = var_8_1

	typeof = var_10
	CanvasGroup = var_12

	local var_8_14 = var_8_12(var_8_13, var_10(var_12))

	LeanTween = var_1_10008

	local var_8_15 = var_1_10008.value

	go = var_10

	local var_8_16 = var_8_15(var_10(var_8_1), 0, 1, 0.4)
	local var_8_17 = var_8.setOnUpdate

	System = var_11

	var_8_17(var_8_16, var_11.Action_float(function(arg_11_0)
		var_8_14.alpha = arg_11_0

		return
	end))

	setActive = var_8_17

	var_8_17(var_8_1:Find("label"), false)

	LeanTween = var_8_17

	local var_8_18 = var_8_17.moveLocal

	go = var_10

	local var_8_19 = var_8_18(var_10(var_8_1), var_8_5, 0.4)
	local var_8_20 = var_8.setOnComplete

	System = var_11

	var_8_20(var_8_19, var_11.Action(function()
		local var_12_0 = arg_8_0

		var_12_0.isSwitching = nil
		setToggleEnabled = var_12_0

		var_12_0(arg_8_0.switchBtn, true)

		return
	end))

	return
end

return var_0_1
