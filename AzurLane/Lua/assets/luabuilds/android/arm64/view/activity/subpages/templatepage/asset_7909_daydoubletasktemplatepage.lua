class = var_0_10000

local var_0_0 = "DayDoubleTaskTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_1, "total_progress/day")

	local var_1_2 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_2, "item")

	local var_1_3 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_3, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_4 = arg_1_0.bg

	arg_1_0.progressLabel = var_1.Find(var_1_4, "total_progress/label")
	setText = var_1

	local var_1_5 = arg_1_0.progressLabel

	i18n = var_4

	var_1(var_1_5, var_4("Outpost_20250904_Progress"))

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1(var_1_10003)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_data")
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.uilist

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0

			var_3.UpdateTask(var_4_0, arg_4_1, arg_4_2)
		end

		return
	end)

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

	assert = var_7

	var_7(var_5_4, "without this task by id: " .. var_5_2)

	Drop = var_7

	local var_5_5 = var_7.Create(var_5_4:getConfig("award_display")[1])

	updateDrop = var_5_3

	var_5_3(var_5_1, var_5_5)

	onButton = var_5_3

	local var_5_6 = arg_5_0
	local var_5_7 = var_5_1

	local function var_5_8()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10003

		var_6_1(var_6_0, var_2_10003.ON_DROP, var_5_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_5_3(var_5_6, var_5_7, var_5_8, var_1_10013)

	local var_5_9 = var_5_4
	local var_5_10 = var_5_4.getProgress(var_5_9)
	local var_5_11 = var_5_4:getConfig("target_num")

	setText = var_5_9

	var_5_9(arg_5_2:Find("description"), var_5_4:getConfig("desc"))

	local var_5_12 = arg_5_0
	local var_5_13, var_5_14 = arg_5_0.GetProgressColor(var_5_12)

	if var_5_13 then
		setColorStr = var_5_12

		local var_5_15

		if not var_5_12(var_5_10, var_5_13) then
			::label_5_0::

			var_5_15 = var_5_10
		end

		if var_5_14 then
			setColorStr = var_5_12

			local var_5_16

			if not var_5_12("/" .. var_5_11, var_5_14) then
				::label_5_1::

				var_5_16 = "/" .. var_5_11
			end

			setText = var_5_12

			var_5_12(arg_5_2:Find("progressText"), var_5_15 .. var_5_16)

			setSlider = var_5_12

			var_5_12(arg_5_2:Find("progress"), 0, var_5_11, var_5_10)

			local var_5_17 = arg_5_2:Find("go_btn")
			local var_5_18 = arg_5_2:Find("get_btn")
			local var_5_19 = arg_5_2
			local var_5_20 = arg_5_2.Find(var_5_19, "got_btn")
			local var_5_21 = var_5_4:getTaskStatus()

			setActive = var_5_19

			var_5_19(var_5_17, var_5_21 == 0)

			setActive = var_5_19

			var_5_19(var_5_18, var_5_21 == 1)

			setActive = var_5_19

			var_5_19(var_5_20, var_5_21 == 2)

			onButton = var_5_19

			local var_5_22 = arg_5_0
			local var_5_23 = var_5_17

			local function var_5_24()
				local var_7_0 = arg_5_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_7_1(var_7_0, var_2_10003.ON_TASK_GO, var_5_4)

				return
			end

			SFX_PANEL = var_1_10021

			var_5_19(var_5_22, var_5_23, var_5_24, var_1_10021)

			onButton = var_5_19

			local var_5_25 = arg_5_0
			local var_5_26 = var_5_18

			local function var_5_27()
				local var_8_0 = {}
				local var_8_1 = var_5_4
				local var_8_2 = var_1.getConfig(var_8_1, "award_display")

				getProxy = var_2_10002
				PlayerProxy = var_4

				local var_8_3 = var_2_10002(var_4)
				local var_8_4 = var_2.getRawData(var_8_3)

				pg = var_4

				local var_8_5 = var_4.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_8_3

				if var_8_3 then
					var_8_3 = 0
				else
					getProxy = var_8_3
					BagProxy = var_2_10007

					local var_8_6 = var_8_3(var_2_10007)

					var_8_3 = var_8_3.GetLimitCntById(var_8_6, var_8_5)
				end

				Task = var_2_10006

				local var_8_7, var_8_8 = var_2_10006.StaticJudgeOverflow(var_8_4.gold, var_8_4.oil, var_8_3, true, true, var_8_2)

				if var_8_7 then
					table = var_8

					var_8.insert(var_8_0, function(arg_9_0)
						pg = var_3_10001

						local var_9_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_9_1 = var_1.ShowMsgBox
						local var_9_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10005
						var_9_2.type = var_3_10005
						i18n = var_3_10005
						var_9_2.content = var_3_10005("award_max_warning")
						var_9_2.items = var_8_8
						var_9_2.onYes = arg_9_0

						var_9_1(var_9_0, var_9_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_8_0, function()
					local var_10_0 = arg_5_0
					local var_10_1 = var_0.emit

					ActivityMediator = var_3_10003

					var_10_1(var_10_0, var_3_10003.ON_TASK_SUBMIT, var_5_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10021

			var_5_19(var_5_25, var_5_26, var_5_27, var_1_10021)

			return
		end
	end
end

function var_0_1.OnUpdateFlush(arg_11_0)
	arg_11_0.nday = arg_11_0.activity.data3

	arg_11_0:PlayStory()
	arg_11_0:UpdateProgress()

	local var_11_0 = arg_11_0.uilist

	var_1.align(var_11_0, #arg_11_0.taskGroup[arg_11_0.nday])

	return
end

local function var_0_2()
	self = var_1_10000

	if var_1_10000.dayTF then
		setText = var_0
		self = var_1_10002

		local var_12_0 = var_1_10002.dayTF

		self = var_1_10003

		local var_12_1 = var_1_10003.nday
		local var_12_2 = "/"

		self = var_1_10005

		var_0(var_12_0, var_12_1 .. var_12_2 .. #var_1_10005.taskGroup)
	end

	return
end

local var_0_3 = UpdateProgress

function var_0_1.PlayStory(arg_13_0)
	local var_13_0 = arg_13_0.activity
	local var_13_1 = var_1.getConfig(var_13_0, "config_client").story

	checkExist = var_1_10002

	if var_1_10002(var_13_1, {
		arg_13_0.nday
	}, {
		1
	}) then
		pg = var_2

		local var_13_2 = var_2.NewStoryMgr.GetInstance()

		var_2.Play(var_13_2, var_13_1[arg_13_0.nday][1])
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	eachChild = var_1_10001

	var_1_10001(arg_14_0.items, function(arg_15_0)
		Destroy = var_2_10001

		var_2_10001(arg_15_0)

		return
	end)

	return
end

function var_0_1.GetProgressColor(arg_16_0)
	return nil
end

return var_0_1
