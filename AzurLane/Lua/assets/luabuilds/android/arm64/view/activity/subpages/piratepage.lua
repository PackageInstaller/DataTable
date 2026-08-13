class = var_0_10000

local var_0_0 = "PiratePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

var_0_1.PROGRESS_TEXT = "%d/7"
var_0_1.DIALOG_DELAY = 15

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.progress = var_1.Find(var_1_1, "progress")

	local var_1_2 = arg_1_0.progress

	arg_1_0.progressText = var_1.Find(var_1_2, "Text")

	local var_1_3 = arg_1_0.bg

	arg_1_0.complete = var_1.Find(var_1_3, "complete")

	local var_1_4 = arg_1_0.bg

	arg_1_0.goBtn = var_1.Find(var_1_4, "go_btn")

	local var_1_5 = arg_1_0.goBtn

	arg_1_0.red = var_1.Find(var_1_5, "red")

	local var_1_6 = arg_1_0.bg

	arg_1_0.dialogTf = var_1.Find(var_1_6, "dialog")

	local var_1_7 = arg_1_0.dialogTf

	arg_1_0.dialogText = var_1.Find(var_1_7, "Text")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.count = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_data")
	arg_2_0.totoalCount = #arg_2_0.taskGroup

	local var_2_1 = arg_2_0.activity

	arg_2_0.dialog_progress = var_1.getConfig(var_2_1, "config_client").shipyard_phase_1

	local var_2_2 = arg_2_0.activity

	arg_2_0.dialog_complete = var_1.getConfig(var_2_2, "config_client").shipyard_phase_2
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnShowFlush(arg_3_0)
	setActive = var_1_10001

	var_1_10001(arg_3_0.dialogTf, true)

	setImageAlpha = var_1_10001

	var_1_10001(arg_3_0.dialogTf, 1)

	setText = var_1_10001

	local var_3_0 = arg_3_0.dialogText
	local var_3_1 = arg_3_0.activity

	if not var_4.canPermanentFinish(var_3_1) then
		local var_3_2 = arg_3_0.dialog_progress

		math = var_1_10005

		if not var_3_2[var_1_10005.random(#arg_3_0.dialog_progress)] then
			var_3_2 = arg_3_0.dialog_complete
			math = var_1_10005
			var_3_2 = var_3_2[var_1_10005.random(#arg_3_0.dialog_complete)]
		end

		var_1_10001(var_3_0, var_3_2)

		LeanTween = var_1_10001

		local var_3_3 = var_1_10001.alpha(arg_3_0.dialogTf, 0, 0.5)
		local var_3_4 = var_1.setDelay(var_3_3, var_0_1.DIALOG_DELAY)
		local var_3_5 = var_1.setOnComplete

		System = var_4

		var_3_5(var_3_4, var_4.Action(function()
			SetActive = var_2_10000

			var_2_10000(arg_3_0.dialogTf, false)

			return
		end))

		return
	end
end

function var_0_1.OnHideFlush(arg_5_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_5_0.dialogTf)

	return
end

function var_0_1.OnFirstFlush(arg_6_0)
	arg_6_0.count = arg_6_0.activity.data3
	setActive = var_1

	local var_6_0 = arg_6_0.red
	local var_6_1 = arg_6_0

	var_1(var_6_0, arg_6_0.CheckRed(var_6_1))

	onButton = var_1

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.goBtn

	local function var_6_4()
		local var_7_0 = arg_6_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_7_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_7_1(var_7_0, var_7_2, var_2_10004.SECRET_SHIPYARD)

		return
	end

	SFX_PANEL = var_6_1

	var_1(var_6_2, var_6_3, var_6_4, var_6_1)

	return
end

function var_0_1.CheckRed(arg_8_0)
	local var_8_0 = false
	local var_8_1 = arg_8_0.activity

	if var_2.readyToAchieve(var_8_1) then
		var_8_0 = true
	end

	local var_8_2 = arg_8_0.activity

	if var_2.getNDay(var_8_2) < 8 then
		PlayerPrefs = var_3

		if var_3.GetInt("PiratePage" .. var_2, 0) == 0 then
			PlayerPrefs = var_3

			var_3.SetInt("PiratePage" .. var_2, 1)

			var_8_0 = true
		end
	end

	return var_8_0
end

function var_0_1.OnUpdateFlush(arg_9_0)
	arg_9_0.count = arg_9_0.activity.data3

	if arg_9_0.progress then
		setText = var_1

		local var_9_0 = arg_9_0.progressText

		string = var_1_10004

		var_1(var_9_0, var_1_10004.format(var_0_1.PROGRESS_TEXT, arg_9_0.count))

		setActive = var_1

		local var_9_1 = arg_9_0.progress
		local var_9_2 = arg_9_0.activity

		var_1(var_9_1, not var_4.canPermanentFinish(var_9_2))

		setActive = var_1

		local var_9_3 = arg_9_0.complete
		local var_9_4 = arg_9_0.activity

		var_1(var_9_3, var_4.canPermanentFinish(var_9_4))
	end

	return
end

return var_0_1
