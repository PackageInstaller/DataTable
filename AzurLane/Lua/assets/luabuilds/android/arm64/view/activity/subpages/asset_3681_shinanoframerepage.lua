class = var_0_10000

local var_0_0 = "ShinanoframeRePage"

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

	arg_1_0.gotTag = var_1.Find(var_1_4, "got")

	local var_1_5 = arg_1_0.bg

	arg_1_0.cur = var_1.Find(var_1_5, "cur")

	local var_1_6 = arg_1_0.bg

	arg_1_0.max = var_1.Find(var_1_6, "max")

	local var_1_7 = arg_1_0.bg

	arg_1_0.progressBar = var_1.Find(var_1_7, "progress")
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

		var_4_1(var_4_0, var_4_2, var_2_10004.TASK, {})

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

	pg = var_1_10001

	local var_3_6 = var_1_10001.activity_event_avatarframe
	local var_3_7 = arg_3_0.activity
	local var_3_8 = var_3_6[var_2.getConfig(var_3_7, "config_id")].icon_frame

	LoadAndInstantiateSync = var_2

	local var_3_9

	var_3_9, setParent = var_2("IconFrame", var_3_8), var_3_3
	findTF = var_1_10006

	var_3_3(var_3_9, var_1_10006(arg_3_0.bg, "icon"), false)

	return
end

function var_0_1.OnUpdateFlush(arg_6_0)
	local var_6_0 = arg_6_0.activity.data1

	pg = var_1_10002

	local var_6_1 = var_1_10002.activity_event_avatarframe
	local var_6_2 = arg_6_0.activity

	if var_6_1[var_3.getConfig(var_6_2, "config_id")].target < var_6_0 then
		var_6_0 = var_2
	end

	local var_6_3 = var_6_0 / var_2

	setText = var_1_10004

	var_1_10004(arg_6_0.cur, var_6_0)

	setText = var_1_10004

	var_1_10004(arg_6_0.max, "/" .. var_2)

	setSlider = var_1_10004

	var_1_10004(arg_6_0.progressBar, 0, 1, var_6_3)

	setActive = var_1_10004

	var_1_10004(arg_6_0.progressBar, true)

	local var_6_4 = var_2 <= var_6_0
	local var_6_5 = arg_6_0.activity.data2
	local var_6_6 = 1 <= var_6_5

	setActive = var_6

	var_6(arg_6_0.goBtn, not var_6_4)

	setActive = var_6

	var_6(arg_6_0.getBtn, not var_6_6 and var_6_4)

	setActive = var_6

	var_6(arg_6_0.gotBtn, var_6_6)

	setActive = var_6

	var_6(arg_6_0.gotTag, var_6_6)

	return
end

function var_0_1.OnDestroy(arg_7_0)
	return
end

return var_0_1
