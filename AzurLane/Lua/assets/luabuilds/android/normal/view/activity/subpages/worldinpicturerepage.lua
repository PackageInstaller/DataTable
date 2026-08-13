class = var_0_10000

local var_0_0 = "WorldInPictureRePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.SkinTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "items/item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_3 = arg_1_0._tf

	arg_1_0.help = var_1.Find(var_1_3, "AD/help")

	local var_1_4 = arg_1_0._tf

	arg_1_0.start = var_1.Find(var_1_4, "AD/start")

	local var_1_5 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_5, "Text")

	local var_1_6 = arg_1_0._tf

	arg_1_0.tip = var_1.Find(var_1_6, "AD/tip")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)

	onButton = var_1

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.help

	local function var_2_2()
		pg = var_2_10000

		local var_3_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_3_1 = var_0.ShowMsgBox
		local var_3_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_3_2.type = var_2_10003
		pg = var_2_10003
		var_3_2.helps = var_2_10003.gametip.worldinpicture_task_help.tip

		var_3_1(var_3_0, var_3_2)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.start

	local function var_2_5()
		pg = var_2_10000

		local var_4_0 = var_2_10000.m02
		local var_4_1 = var_0.sendNotification

		GAME = var_2_10002

		local var_4_2 = var_2_10002.GO_SCENE

		SCENE = var_2_10003

		var_4_1(var_4_0, var_4_2, var_2_10003.WORLDINPICTURE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_2_3, var_2_4, var_2_5, var_1_10005)

	getProxy = var_1
	ActivityProxy = var_2_3

	local var_2_6 = var_1(var_2_3)
	local var_2_7 = var_1.getActivityByType

	ActivityConst = var_2_4
	arg_2_0.miniGameAct = var_2_7(var_2_6, var_2_4.ACTIVITY_TYPE_WORLDINPICTURE)

	return
end

function var_0_1.UpdateTask(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 + 1
	local var_5_1 = arg_5_2:Find("item")
	local var_5_2 = arg_5_0.taskGroup[arg_5_0.nday][var_5_0]
	local var_5_3 = arg_5_0.taskProxy
	local var_5_4

	if not var_6.getTaskById(var_5_3, var_5_2) then
		var_5_3 = arg_5_0.taskProxy
		var_5_4 = var_6.getFinishTaskById(var_5_3, var_5_2)
	end

	assert = var_5_3

	var_5_3(var_5_4, "without this task by id: " .. var_5_2)

	local var_5_5 = var_5_4:getConfig("award_display")[1]
	local var_5_6 = {
		type = var_5_5[1],
		id = var_5_5[2],
		count = var_5_5[3]
	}

	updateDrop = var_9

	var_9(var_5_1, var_5_6)

	onButton = var_9

	local var_5_7 = arg_5_0
	local var_5_8 = var_5_1

	local function var_5_9()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_5_6)

		return
	end

	SFX_PANEL = var_1_10013

	var_9(var_5_7, var_5_8, var_5_9, var_1_10013)

	local var_5_10 = var_5_4:getProgress()
	local var_5_11 = var_5_4
	local var_5_12 = var_5_4.getConfig(var_5_11, "target_num")

	setText = var_5_11

	var_5_11(arg_5_2:Find("description"), var_5_4:getConfig("desc"))

	setSlider = var_5_11

	var_5_11(arg_5_2:Find("progress"), 0, var_5_12, var_5_10)

	local var_5_13 = arg_5_2:Find("go_btn")
	local var_5_14 = arg_5_2:Find("get_btn")
	local var_5_15 = arg_5_2:Find("got_btn")
	local var_5_16 = var_5_4
	local var_5_17 = var_5_4.getTaskStatus(var_5_16)

	setActive = var_5_16

	var_5_16(var_5_13, var_5_17 == 0)

	setActive = var_5_16

	var_5_16(var_5_14, var_5_17 == 1)

	setActive = var_5_16

	var_5_16(var_5_15, var_5_17 == 2)

	onButton = var_5_16

	local var_5_18 = arg_5_0
	local var_5_19 = var_5_13

	local function var_5_20()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_7_1(var_7_0, var_2_10002.ON_TASK_GO, var_5_4)

		return
	end

	SFX_PANEL = var_1_10019

	var_5_16(var_5_18, var_5_19, var_5_20, var_1_10019)

	onButton = var_5_16

	local var_5_21 = arg_5_0
	local var_5_22 = var_5_14

	local function var_5_23()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		ActivityMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.ON_TASK_SUBMIT, var_5_4)

		return
	end

	SFX_PANEL = var_1_10019

	var_5_16(var_5_21, var_5_22, var_5_23, var_1_10019)

	setText = var_5_16

	var_5_16(arg_5_2:Find("progressText"), "<color=#789143>" .. var_5_10 .. "</color><color=#a3876f>/" .. var_5_12 .. "</color>")

	return
end

function var_0_1.OnUpdateFlush(arg_9_0)
	var_0_1.super.OnUpdateFlush(arg_9_0)

	local var_9_0

	if arg_9_0.miniGameAct then
		::label_9_0::

		var_1_10003 = var_1

		if not var_1.isEnd(var_1_10003) then
			var_1_10003 = var_1
			var_9_0 = var_1.readyToAchieve(var_1_10003)
		else
			var_9_0 = false
		end

		if false then
			var_9_0 = true
		end
	end

	setActive = var_1_10003

	var_1_10003(arg_9_0.tip, var_9_0)

	return
end

return var_0_1
