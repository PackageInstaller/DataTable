class = var_0_10000

local var_0_0 = "USChristmas2024Page"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_1, "item")

	local var_1_2 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_2, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_3 = arg_1_0.bg

	arg_1_0.awardNum = var_1.Find(var_1_3, "awardNum")

	local var_1_4 = arg_1_0.bg

	arg_1_0.linkBtn = var_1.Find(var_1_4, "linkBtn")
	setActive = var_1

	var_1(arg_1_0.item, false)

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	ActivityTaskProxy = var_1_10002
	arg_2_0.activityTaskProxy = var_1(var_1_10002)

	local var_2_0 = arg_2_0.activity

	arg_2_0.taskGroup = var_1.getConfig(var_2_0, "config_data")

	return
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
	local var_5_3
	local var_5_4 = arg_5_0.activityTaskProxy
	local var_5_5 = var_7.getTaskById(var_5_4, arg_5_0.activity.id)
	local var_5_6 = arg_5_0.activityTaskProxy
	local var_5_7 = var_8.getFinishTaskById(var_5_6, arg_5_0.activity.id)
	local var_5_8 = false

	ipairs = var_10

	for iter_5_0, iter_5_1 in var_10(var_5_5) do
		if iter_5_1.id == var_5_2 then
			var_5_3 = iter_5_1

			break
		end
	end

	if not var_5_3 then
		ipairs = var_10

		for iter_5_2, iter_5_3 in var_10(var_5_7) do
			if iter_5_3.id == var_5_2 then
				var_5_3 = iter_5_3
				var_5_8 = true

				break
			end
		end
	end

	assert = var_10

	var_10(var_5_3, "without this task by id: " .. var_5_2)

	Drop = var_10

	local var_5_9 = var_10.Create(var_5_3:getConfig("award_display")[1])

	updateDrop = var_11

	var_11(var_5_1, var_5_9)

	onButton = var_11

	local var_5_10 = arg_5_0
	local var_5_11 = var_5_1

	local function var_5_12()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_5_9)

		return
	end

	SFX_PANEL = var_1_10015

	var_11(var_5_10, var_5_11, var_5_12, var_1_10015)

	local var_5_13 = var_5_3:getProgress()
	local var_5_14 = var_5_3
	local var_5_15 = var_5_3.getConfig(var_5_14, "target_num")

	setText = var_5_14

	var_5_14(arg_5_2:Find("description"), var_5_3:getConfig("desc"))

	local var_5_16, var_5_17 = arg_5_0:GetProgressColor()

	if var_5_16 then
		setColorStr = var_15

		local var_5_18

		if not var_15(var_5_13, var_5_16) then
			::label_5_0::

			var_5_18 = var_5_13
		end

		if var_5_17 then
			setColorStr = var_15

			local var_5_19

			if not var_15("/" .. var_5_15, var_5_17) then
				::label_5_1::

				var_5_19 = "/" .. var_5_15
			end

			setText = var_15

			var_15(arg_5_2:Find("progressText"), var_5_18 .. var_5_19)

			setSlider = var_15

			var_15(arg_5_2:Find("progress"), 0, var_5_15, var_5_13)

			local var_5_20 = arg_5_2:Find("go_btn")
			local var_5_21 = arg_5_2:Find("get_btn")
			local var_5_22 = arg_5_2:Find("got_btn")
			local var_5_23 = var_5_3
			local var_5_24 = var_5_3.getTaskStatus(var_5_23)

			setActive = var_5_23

			var_5_23(var_5_20, not var_5_8 and var_5_24 == 0)

			setActive = var_5_23

			var_5_23(var_5_21, not var_5_8 and var_5_24 == 1)

			setActive = var_5_23

			var_5_23(var_5_22, var_5_8)

			onButton = var_5_23

			local var_5_25 = arg_5_0
			local var_5_26 = var_5_20

			local function var_5_27()
				local var_7_0 = arg_5_0
				local var_7_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_7_1(var_7_0, var_2_10002.ON_TASK_GO, var_5_3)

				return
			end

			SFX_PANEL = var_1_10023

			var_5_23(var_5_25, var_5_26, var_5_27, var_1_10023)

			onButton = var_5_23

			local var_5_28 = arg_5_0
			local var_5_29 = var_5_21

			local function var_5_30()
				local var_8_0 = {}
				local var_8_1 = var_5_3
				local var_8_2 = var_1.getConfig(var_8_1, "award_display")

				getProxy = var_8_1
				PlayerProxy = var_3

				local var_8_3 = var_8_1(var_3)
				local var_8_4 = var_2.getRawData(var_8_3)

				pg = var_8_3

				local var_8_5 = var_8_3.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_2_10005

				if var_2_10005 then
					var_2_10005 = 0
				else
					getProxy = var_2_10005
					BagProxy = var_2_10006
					var_2_10006 = var_2_10005(var_2_10006)
					var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_8_5)
				end

				Task = var_2_10006

				local var_8_6, var_8_7 = var_2_10006.StaticJudgeOverflow(var_8_4.gold, var_8_4.oil, var_2_10005, true, true, var_8_2)

				if var_8_6 then
					table = var_8

					var_8.insert(var_8_0, function(arg_9_0)
						pg = var_3_10001

						local var_9_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_9_1 = var_1.ShowMsgBox
						local var_9_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10004
						var_9_2.type = var_3_10004
						i18n = var_3_10004
						var_9_2.content = var_3_10004("award_max_warning")
						var_9_2.items = var_8_7
						var_9_2.onYes = arg_9_0

						var_9_1(var_9_0, var_9_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_8_0, function()
					local var_10_0 = arg_5_0
					local var_10_1 = var_0.emit

					ActivityMediator = var_3_10002

					var_10_1(var_10_0, var_3_10002.ON_ACTIVITY_TASK_SUBMIT, {
						activityId = arg_5_0.activity.id,
						id = var_5_2
					})

					return
				end)

				return
			end

			SFX_PANEL = var_1_10023

			var_5_23(var_5_28, var_5_29, var_5_30, var_1_10023)

			return
		end
	end
end

function var_0_1.OnUpdateFlush(arg_11_0)
	local var_11_0 = arg_11_0.activity

	arg_11_0.nday = var_1.GetCurrentDay(var_11_0)

	local var_11_1 = 0
	local var_11_2 = arg_11_0.activity
	local var_11_3 = var_2.getConfig(var_11_2, "config_client").link_act_id

	getProxy = var_11_2
	ActivityProxy = var_4

	local var_11_4 = var_11_2(var_4)

	if var_3.getActivityById(var_11_4, var_11_3) then
		var_11_1 = var_3.data1
	end

	setText = var_11_4

	var_11_4(arg_11_0.awardNum, var_11_1)

	onButton = var_11_4

	local var_11_5 = arg_11_0
	local var_11_6 = arg_11_0.linkBtn

	local function var_11_7()
		Application = var_2_10000

		local var_12_0 = var_2_10000.OpenURL
		local var_12_1 = arg_11_0.activity

		var_12_0(var_1.getConfig(var_12_1, "config_client").url)

		return
	end

	SFX_PANEL = var_1_10008

	var_11_4(var_11_5, var_11_6, var_11_7, var_1_10008)

	local var_11_8 = arg_11_0.uilist

	var_4.align(var_11_8, #arg_11_0.taskGroup[arg_11_0.nday])

	return
end

function var_0_1.OnDestroy(arg_13_0)
	eachChild = var_1_10001

	var_1_10001(arg_13_0.items, function(arg_14_0)
		Destroy = var_2_10001

		var_2_10001(arg_14_0)

		return
	end)

	return
end

function var_0_1.GetProgressColor(arg_15_0)
	return nil
end

return var_0_1
