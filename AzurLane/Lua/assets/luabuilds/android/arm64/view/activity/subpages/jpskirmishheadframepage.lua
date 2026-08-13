class = var_0_10000

local var_0_0 = "JPSkirmishHeadFramePage"

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

	arg_1_0.gotTag = var_1.Find(var_1_4, "GotTag")

	local var_1_5 = arg_1_0.bg

	arg_1_0.progressBar = var_1.Find(var_1_5, "Progress")

	local var_1_6 = arg_1_0.bg

	arg_1_0.progressText = var_1.Find(var_1_6, "ProgressText")
	setActive = var_1

	var_1(arg_1_0.goBtn, false)

	setActive = var_1

	var_1(arg_1_0.getBtn, false)

	setActive = var_1

	var_1(arg_1_0.gotBtn, false)

	setActive = var_1

	var_1(arg_1_0.gotTag, false)

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

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity
	local var_6_1 = var_1.getConfig(var_6_0, "config_client").linkExpActID

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_6_2 = var_1_10002(var_4)

	if not var_2.getActivityById(var_6_2, var_6_1) or var_2:isEnd() then
		local var_6_3 = arg_6_0.ptData
		local var_6_4 = var_3.CanGetAward(var_6_3)

		var_1_10006 = arg_6_0.ptData

		local var_6_5 = var_4.CanGetNextAward(var_1_10006)
		local var_6_6 = arg_6_0.ptData
		local var_6_7 = var_5.CanGetMorePt(var_6_6)

		setActive = var_1_10006

		local var_6_8 = arg_6_0.goBtn

		var_1_10009 = var_6_7 and not var_6_4 and var_6_5

		var_1_10006(var_6_8, var_1_10009)

		setActive = var_1_10006

		var_1_10006(arg_6_0.getBtn, var_6_4)

		setActive = var_1_10006

		var_1_10006(arg_6_0.gotBtn, not var_6_5)

		setActive = var_1_10006

		var_1_10006(arg_6_0.gotTag, not var_6_5)
	end

	local var_6_9 = arg_6_0.ptData
	local var_6_10, var_6_11, var_6_12 = var_3.GetResProgress(var_6_9)

	setText = var_1_10006

	local var_6_13 = arg_6_0.progressText

	setColorStr = var_1_10009

	var_1_10006(var_6_13, var_1_10009(var_6_10, "#487CFFFF") .. "/" .. var_6_11)

	setSlider = var_1_10006

	var_1_10006(arg_6_0.progressBar, 0, 1, var_6_12)

	setActive = var_1_10006

	var_1_10006(arg_6_0.progressText, true)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
