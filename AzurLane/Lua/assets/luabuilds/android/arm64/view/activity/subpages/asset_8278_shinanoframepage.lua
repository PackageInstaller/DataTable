class = var_0_10000

local var_0_0 = "ShinanoframePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.goBtn = var_1.Find(var_1_1, "GoBtn")

	local var_1_2 = arg_1_0.bg

	arg_1_0.getBtn = var_1.Find(var_1_2, "GetBtn")

	local var_1_3 = arg_1_0.bg

	arg_1_0.gotBtn = var_1.Find(var_1_3, "GotBtn")

	local var_1_4 = arg_1_0.bg

	arg_1_0.switchBtn = var_1.Find(var_1_4, "SwitchBtn")

	local var_1_5 = arg_1_0.bg

	arg_1_0.phaseTF_1 = var_1.Find(var_1_5, "Phase1")

	local var_1_6 = arg_1_0.bg

	arg_1_0.phaseTF_2 = var_1.Find(var_1_6, "Phase2")

	local var_1_7 = arg_1_0.bg

	arg_1_0.gotTag = var_1.Find(var_1_7, "Phase2/GotTag")

	local var_1_8 = arg_1_0.bg

	arg_1_0.frameTF = var_1.Find(var_1_8, "Phase2/Icon")

	local var_1_9 = arg_1_0.bg

	arg_1_0.progressBar = var_1.Find(var_1_9, "Phase2/Progress")

	local var_1_10 = arg_1_0.bg

	arg_1_0.progressText = var_1.Find(var_1_10, "Phase2/ProgressText")
	setActive = var_1

	var_1(arg_1_0.goBtn, false)

	setActive = var_1

	var_1(arg_1_0.getBtn, false)

	setActive = var_1

	var_1(arg_1_0.gotBtn, false)

	setActive = var_1

	var_1(arg_1_0.gotTag, false)

	setActive = var_1

	var_1(arg_1_0.progressBar, false)

	setActive = var_1

	var_1(arg_1_0.progressText, false)

	setActive = var_1

	var_1(arg_1_0.phaseTF_2, false)

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
	local var_3_1 = arg_3_0.goBtn

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
		local var_5_0 = arg_3_0.ptData
		local var_5_1, var_5_2 = var_0.GetResProgress(var_5_0)
		local var_5_3 = arg_3_0
		local var_5_4 = var_2.emit

		ActivityMediator = var_2_10005

		local var_5_5 = var_2_10005.EVENT_PT_OPERATION
		local var_5_6 = {
			cmd = 1
		}
		local var_5_7 = arg_3_0.ptData

		var_5_6.activity_id = var_7.GetId(var_5_7)
		var_5_6.arg1 = var_5_2

		var_5_4(var_5_3, var_5_5, var_5_6)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.switchBtn

	local function var_3_8()
		setActive = var_2_10000

		local var_6_0 = arg_3_0.phaseTF_1

		isActive = var_2_10003

		var_2_10000(var_6_0, not var_2_10003(arg_3_0.phaseTF_1))

		setActive = var_2_10000

		local var_6_1 = arg_3_0.phaseTF_2

		isActive = var_3

		var_2_10000(var_6_1, not var_3(arg_3_0.phaseTF_2))

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	local var_3_9 = arg_3_0.ptData.dropList[1][2]

	tostring = var_3_6

	local var_3_10 = var_3_6(var_3_9)

	LoadAndInstantiateSync = var_3_7

	local var_3_11 = var_3_7("IconFrame", var_3_10)

	setParent = var_5

	var_5(var_3_11, arg_3_0.frameTF, false)

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_7_0 = var_1_10001(var_1_10003)
	local var_7_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	if not var_7_1(var_7_0, var_1_10004.SHINANO_EXP_ACT_ID) or var_1:isEnd() then
		setActive = var_1_10002

		var_1_10002(arg_7_0.phaseTF_1, false)

		setActive = var_1_10002

		var_1_10002(arg_7_0.phaseTF_2, true)

		local var_7_2 = arg_7_0.ptData
		local var_7_3, var_7_4

		var_1_10002, var_7_3, var_7_4 = var_1_10002.GetResProgress(var_7_2)
		setText = var_5

		var_5(arg_7_0.progressText, var_1_10002 .. "/" .. var_7_3)

		setSlider = var_5

		var_5(arg_7_0.progressBar, 0, 1, var_7_4)

		setActive = var_5

		var_5(arg_7_0.progressBar, true)

		setActive = var_5

		var_5(arg_7_0.progressText, true)

		local var_7_5 = arg_7_0.ptData
		local var_7_6 = var_5.CanGetAward(var_7_5)
		local var_7_7 = arg_7_0.ptData
		local var_7_8 = var_6.CanGetNextAward(var_7_7)
		local var_7_9 = arg_7_0.ptData
		local var_7_10 = var_7.CanGetMorePt(var_7_9)

		setActive = var_7_7

		var_7_7(arg_7_0.goBtn, var_7_10 and not var_7_6 and var_7_8)

		setActive = var_7_7

		var_7_7(arg_7_0.getBtn, var_7_6)

		setActive = var_7_7

		var_7_7(arg_7_0.gotBtn, not var_7_8)

		setActive = var_7_7

		var_7_7(arg_7_0.gotTag, not var_7_8)
	else
		setActive = var_1_10002

		var_1_10002(arg_7_0.phaseTF_1, true)

		setActive = var_1_10002

		var_1_10002(arg_7_0.phaseTF_2, false)

		local var_7_11 = arg_7_0.ptData
		local var_7_12, var_7_13, var_7_14 = var_2.GetResProgress(var_7_11)

		setText = var_5

		var_5(arg_7_0.progressText, var_7_12 .. "/" .. var_7_13)

		setSlider = var_5

		var_5(arg_7_0.progressBar, 0, 1, var_7_14)

		setActive = var_5

		var_5(arg_7_0.progressBar, true)

		setActive = var_5

		var_5(arg_7_0.progressText, true)
	end

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

return var_0_1
