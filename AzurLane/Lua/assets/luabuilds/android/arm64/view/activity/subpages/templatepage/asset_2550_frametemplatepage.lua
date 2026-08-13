class = var_0_10000

local var_0_0 = "FrameTemplatePage"

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

	arg_1_0.step = var_1.Find(var_1_9, "AD/switcher/phase2/Image/step")

	local var_1_10 = arg_1_0._tf

	arg_1_0.progress = var_1.Find(var_1_10, "AD/switcher/phase2/Image/progress")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		local var_2_0 = arg_2_0.ptData

		var_1.Update(var_2_0, arg_2_0.activity)
	else
		ActivityPtData = var_1
		arg_2_0.ptData = var_1.New(arg_2_0.activity)
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

		var_4_1(var_4_0, var_4_2, var_2_10004.TASK, {
			page = "activity"
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.getBtn

	local function var_3_5()
		local var_5_0 = {}
		local var_5_1 = arg_3_0.ptData
		local var_5_2 = var_1.GetAward(var_5_1)

		getProxy = var_2_10002
		PlayerProxy = var_2_10004

		local var_5_3 = var_2_10002(var_2_10004)
		local var_5_4 = var_2.getData(var_5_3)
		local var_5_5 = var_5_2.type

		DROP_TYPE_RESOURCE = var_5_3

		if var_5_5 == var_5_3 then
			var_5_5 = var_5_2.id
			PlayerConst = var_5_3

			if var_5_5 == var_5_3.ResGold and var_5_4:GoldMax(var_5_2.count) then
				table = var_5_5

				var_5_5.insert(var_5_0, function(arg_6_0)
					pg = var_3_10001

					local var_6_0 = var_3_10001.MsgboxMgr.GetInstance()
					local var_6_1 = var_1.ShowMsgBox
					local var_6_2 = {}

					i18n = var_3_10005

					local var_6_3 = var_3_10005("gold_max_tip_title")

					i18n = var_3_10006
					var_6_2.content = var_6_3 .. var_3_10006("award_max_warning")
					var_6_2.onYes = arg_6_0

					var_6_1(var_6_0, var_6_2)

					return
				end)
			end
		end

		seriesAsync = var_5_5

		var_5_5(var_5_0, function()
			local var_7_0 = arg_3_0.ptData
			local var_7_1, var_7_2 = var_0.GetResProgress(var_7_0)
			local var_7_3 = arg_3_0
			local var_7_4 = var_2.emit

			ActivityMediator = var_3_10005

			local var_7_5 = var_3_10005.EVENT_PT_OPERATION
			local var_7_6 = {
				cmd = 1
			}
			local var_7_7 = arg_3_0.ptData

			var_7_6.activity_id = var_7.GetId(var_7_7)
			var_7_6.arg1 = var_7_2

			var_7_4(var_7_3, var_7_5, var_7_6)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onToggle = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.switchBtn

	local function var_3_8(arg_8_0)
		if arg_3_0.isSwitching then
			return
		end

		arg_3_0.inPhase2 = arg_8_0

		local var_8_0 = arg_3_0

		var_1.Switch(var_8_0, arg_8_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = arg_3_0.activity
	local var_3_10 = var_1.getConfig(var_3_9, "config_client")

	pg = var_1_10002

	local var_3_11 = var_1_10002.TimeMgr.GetInstance()
	local var_3_12 = var_2.inTime(var_3_11, var_3_10)

	setActive = var_3_9

	var_3_9(arg_3_0.battleBtn, var_3_12)

	arg_3_0.inPhase2 = var_3_12

	if var_3_12 then
		triggerToggle = var_3_9

		var_3_9(arg_3_0.switchBtn, true)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	local var_9_0 = arg_9_0.ptData
	local var_9_1 = var_1.CanGetAward(var_9_0)
	local var_9_2 = arg_9_0.ptData
	local var_9_3 = var_2.CanGetNextAward(var_9_2)

	setActive = var_9_0

	var_9_0(arg_9_0.getBtn, var_9_1)

	setActive = var_9_0

	var_9_0(arg_9_0.gotBtn, not var_9_3)

	local var_9_4 = arg_9_0.ptData
	local var_9_5, var_9_6, var_9_7 = var_3.GetResProgress(var_9_4)

	setText = var_6

	local var_9_8 = arg_9_0.step

	if 1 <= var_9_7 then
		setColorStr = var_9

		local var_9_9 = var_9_5

		COLOR_GREEN = var_1_10012

		local var_9_10

		if not var_9(var_9_9, var_1_10012) then
			var_9_10 = var_9_5
		end

		var_6(var_9_8, var_9_10)

		setText = var_6

		var_6(arg_9_0.progress, "/" .. var_9_6)

		setFillAmount = var_6

		var_6(arg_9_0.bar, var_9_5 / var_9_6)
		arg_9_0:UpdateAwardGot()

		return
	end
end

function var_0_1.Switch(arg_10_0, arg_10_1)
	arg_10_0.isSwitching = true
	GetOrAddComponent = var_2

	local var_10_0 = arg_10_0.phases[1]

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_10_1 = var_2(var_10_0, var_1_10005(var_1_10007))
	local var_10_2 = arg_10_0.phases[1].localPosition
	local var_10_3 = arg_10_0.phases[2].localPosition
	local var_10_4 = arg_10_0.phases[2]

	var_5.SetAsLastSibling(var_10_4)

	setActive = var_5

	local var_10_5 = arg_10_0.phases[1]

	var_5(var_7.Find(var_10_5, "Image"), false)

	LeanTween = var_5

	local var_10_6 = var_5.moveLocal

	go = var_7

	local var_10_7 = var_10_6(var_7(arg_10_0.phases[1]), var_10_3, 0.4)
	local var_10_8 = var_5.setOnComplete

	System = var_8

	var_10_8(var_10_7, var_8.Action(function()
		setActive = var_2_10000

		local var_11_0 = arg_10_0.phases[1]

		var_2_10000(var_2.Find(var_11_0, "label"), true)

		return
	end))

	LeanTween = var_10_8

	local var_10_9 = var_10_8.value

	go = var_10_7

	local var_10_10 = var_10_9(var_10_7(arg_10_0.phases[1]), 0, 1, 0.4)
	local var_10_11 = var_5.setOnUpdate

	System = var_8

	var_10_11(var_10_10, var_8.Action_float(function(arg_12_0)
		var_10_1.alpha = arg_12_0

		return
	end))

	setActive = var_10_11

	local var_10_12 = arg_10_0.phases[2]

	var_10_11(var_7.Find(var_10_12, "Image"), true)

	GetOrAddComponent = var_10_11

	local var_10_13 = arg_10_0.phases[2]

	typeof = var_8
	CanvasGroup = var_10

	local var_10_14 = var_10_11(var_10_13, var_8(var_10))

	LeanTween = var_1_10006

	local var_10_15 = var_1_10006.value

	go = var_8

	local var_10_16 = var_10_15(var_8(arg_10_0.phases[2]), 0, 1, 0.4)
	local var_10_17 = var_6.setOnUpdate

	System = var_9

	var_10_17(var_10_16, var_9.Action_float(function(arg_13_0)
		var_10_14.alpha = arg_13_0

		return
	end))

	setActive = var_10_17

	local var_10_18 = arg_10_0.phases[2]

	var_10_17(var_8.Find(var_10_18, "label"), false)

	LeanTween = var_10_17

	local var_10_19 = var_10_17.moveLocal

	go = var_8

	local var_10_20 = var_10_19(var_8(arg_10_0.phases[2]), var_10_2, 0.4)
	local var_10_21 = var_6.setOnComplete

	System = var_9

	var_10_21(var_10_20, var_9.Action(function()
		arg_10_0.isSwitching = nil
		arg_10_0.phases[1], arg_10_0.phases[2] = arg_10_0.phases[2], arg_10_0.phases[1]

		return
	end))
	arg_10_0:UpdateAwardGot()

	return
end

function var_0_1.UpdateAwardGot(arg_15_0)
	local var_15_0 = arg_15_0.bg
	local var_15_1 = var_1.Find(var_15_0, "switcher/phase2/got")
	local var_15_2 = arg_15_0.ptData
	local var_15_3 = not var_2.CanGetNextAward(var_15_2) and arg_15_0.inPhase2

	setActive = var_15_0

	var_15_0(var_15_1, var_15_3)

	if var_15_3 then
		setActive = var_15_0

		var_15_0(arg_15_0.battleBtn, false)
	end

	return
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

return var_0_1
