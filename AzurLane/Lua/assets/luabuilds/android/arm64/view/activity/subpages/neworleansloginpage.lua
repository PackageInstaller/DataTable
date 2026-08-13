class = var_0_10000

local var_0_0 = "NewOrleansLoginPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.showItemTpl = var_1.Find(var_1_1, "ShowItem")

	local var_1_2 = arg_1_0.bg

	arg_1_0.showItemContainer = var_1.Find(var_1_2, "ItemShowList")
	UIItemList = var_1
	arg_1_0.itemList = var_1.New(arg_1_0.showItemContainer, arg_1_0.showItemTpl)
	setActive = var_1

	var_1(arg_1_0.showItemTpl, false)

	local var_1_3 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_3, "item")

	local var_1_4 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_4, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_5 = arg_1_0.bg

	arg_1_0.stepText = var_1.Find(var_1_5, "step_text")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").act_id

	getProxy = var_1_10002
	ActivityProxy = var_4

	local var_2_2 = var_1_10002(var_4)

	arg_2_0.linkActivity = var_2.getActivityById(var_2_2, var_2_1)
	arg_2_0.nday = 0
	getProxy = var_2
	TaskProxy = var_2_2
	arg_2_0.taskProxy = var_2(var_2_2)

	local var_2_3 = arg_2_0.linkActivity

	arg_2_0.taskGroup = var_2.getConfig(var_2_3, "config_data")
	pg = var_2

	local var_2_4 = var_2.activity_7_day_sign
	local var_2_5 = arg_2_0.activity

	arg_2_0.config = var_2_4[var_3.getConfig(var_2_5, "config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops
	arg_2_0.curDay = 0
	updateActivityTaskStatus = var_2

	return var_2(arg_2_0.linkActivity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.uilist

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_4_1 + 1
			local var_4_1 = arg_4_2:Find("item")
			local var_4_2 = arg_3_0.taskGroup[arg_3_0.nday][var_4_0]
			local var_4_3 = arg_3_0.taskProxy
			local var_4_5

			if not var_6.getTaskById(var_4_3, var_4_2) then
				local var_4_4 = arg_3_0.taskProxy

				var_4_5 = var_6.getFinishTaskById(var_4_4, var_4_2)
			end

			assert = var_7

			var_7(var_4_5, "without this task by id: " .. var_4_2)

			local var_4_6 = var_4_5:getConfig("award_display")[1]
			local var_4_7 = {
				type = var_4_6[1],
				id = var_4_6[2],
				count = var_4_6[3]
			}

			updateDrop = var_9

			var_9(var_4_1, var_4_7)

			onButton = var_9

			local var_4_8 = arg_3_0
			local var_4_9 = var_4_1

			local function var_4_10()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_4_7)

				return
			end

			SFX_PANEL = var_2_10014

			var_9(var_4_8, var_4_9, var_4_10, var_2_10014)

			local var_4_11 = var_4_5
			local var_4_12 = var_4_5.getProgress(var_4_11)
			local var_4_13 = var_4_5:getConfig("target_num")

			setText = var_4_11

			var_4_11(arg_4_2:Find("description"), var_4_5:getConfig("desc"))

			setText = var_4_11

			var_4_11(arg_4_2:Find("progressText"), var_4_12 .. "/" .. var_4_13)

			setSlider = var_4_11

			var_4_11(arg_4_2:Find("progress"), 0, var_4_13, var_4_12)

			local var_4_14 = arg_4_2:Find("go_btn")
			local var_4_15 = arg_4_2:Find("get_btn")
			local var_4_16 = arg_4_2
			local var_4_17 = arg_4_2.Find(var_4_16, "got_btn")
			local var_4_18 = var_4_5:getTaskStatus()

			setActive = var_4_16

			var_4_16(var_4_14, var_4_18 == 0)

			setActive = var_4_16

			var_4_16(var_4_15, var_4_18 == 1)

			setActive = var_4_16

			var_4_16(var_4_17, var_4_18 == 2)

			onButton = var_4_16

			local var_4_19 = arg_3_0
			local var_4_20 = var_4_14

			local function var_4_21()
				local var_6_0 = arg_3_0
				local var_6_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_6_1(var_6_0, var_3_10003.ON_TASK_GO, var_4_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_4_16(var_4_19, var_4_20, var_4_21, var_2_10020)

			onButton = var_4_16

			local var_4_22 = arg_3_0
			local var_4_23 = var_4_15

			local function var_4_24()
				local var_7_0 = arg_3_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_3_10003

				var_7_1(var_7_0, var_3_10003.ON_TASK_SUBMIT, var_4_5)

				return
			end

			SFX_PANEL = var_2_10020

			var_4_16(var_4_22, var_4_23, var_4_24, var_2_10020)
		end

		return
	end)

	local var_3_1 = arg_3_0.itemList

	var_1.make(var_3_1, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		local var_8_0

		if arg_8_0 == var_2_10003.EventInit then
			var_8_0 = arg_3_0.config.front_drops[arg_8_1 + 1]
			var_2_10004 = {
				type = var_8_0[1],
				id = var_8_0[2],
				count = var_8_0[3]
			}
			updateDrop = var_5

			var_5(arg_8_2, var_2_10004)

			onButton = var_5

			local var_8_1 = arg_3_0
			local var_8_2 = arg_8_2

			local function var_8_3()
				local var_9_0 = arg_3_0
				local var_9_1 = var_0.emit

				BaseUI = var_3_10003

				var_9_1(var_9_0, var_3_10003.ON_DROP, var_2_10004)

				return
			end

			SFX_PANEL = var_2_10010

			var_5(var_8_1, var_8_2, var_8_3, var_2_10010)
		else
			UIItemList = var_8_0

			if arg_8_0 == var_8_0.EventUpdate then
				local var_8_4 = arg_8_2:Find("icon_mask")

				setActive = var_2_10004

				var_2_10004(var_8_4, arg_8_1 < arg_3_0.curDay)
			end
		end

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	arg_10_0.nday = arg_10_0.linkActivity.data3

	local var_10_0 = arg_10_0.linkActivity
	local var_10_1 = var_1.getConfig(var_10_0, "config_client").story

	checkExist = var_1_10002

	if var_1_10002(var_10_1, {
		arg_10_0.nday
	}, {
		1
	}) then
		pg = var_2

		local var_10_2 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_10_2, var_10_1[arg_10_0.nday][1])
	end

	if arg_10_0.stepText then
		setText = var_2

		local var_10_3 = arg_10_0.stepText

		tostring = var_5

		var_2(var_10_3, var_5(arg_10_0.nday))
	end

	local var_10_4 = arg_10_0.uilist

	var_2.align(var_10_4, #arg_10_0.taskGroup[arg_10_0.nday])

	arg_10_0.curDay = arg_10_0.activity.data1

	local var_10_5 = arg_10_0.itemList

	var_2.align(var_10_5, arg_10_0.Day)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
