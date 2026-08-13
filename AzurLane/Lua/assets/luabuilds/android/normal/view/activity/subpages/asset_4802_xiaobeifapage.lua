class = var_0_10000

local var_0_0 = "XiaobeiFaPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0._tf

	arg_1_0.layer = var_1.Find(var_1_1, "layer")

	local var_1_2 = arg_1_0.layer

	arg_1_0.btn = var_1.Find(var_1_2, "btn")

	local var_1_3 = arg_1_0.layer

	arg_1_0.bonusList = var_1.Find(var_1_3, "bonus_list")

	local var_1_4 = arg_1_0.layer

	arg_1_0.progress = var_1.Find(var_1_4, "progress")

	local var_1_5 = arg_1_0.layer

	arg_1_0.progressTxt = var_1.Find(var_1_5, "progressText")

	local var_1_6 = arg_1_0.layer

	arg_1_0.phaseTxt = var_1.Find(var_1_6, "phase/Text")

	local var_1_7 = arg_1_0.layer

	arg_1_0.award = var_1.Find(var_1_7, "award")

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	local var_2_0 = arg_2_0.activity

	onButton = var_1_10002

	var_1_10002(arg_2_0, arg_2_0.bonusList, function()
		local var_3_0 = var_2_0
		local var_3_1 = var_0.getConfig(var_3_0, "config_data")
		local var_3_2 = var_2_0
		local var_3_3 = var_1.getConfig(var_3_2, "config_client").pt_id

		getProxy = var_3_2
		ActivityProxy = var_3

		local var_3_4 = var_3_2(var_3)
		local var_3_5 = var_2.getActivityById
		local var_3_6 = var_2_0
		local var_3_7 = var_3_5(var_3_4, var_4.getConfig(var_3_6, "config_client").rank_act_id).data1
		local var_3_8 = arg_2_0
		local var_3_9 = var_4.emit

		ActivityMediator = var_6

		local var_3_10 = var_6.SHOW_AWARD_WINDOW

		PtTaskAwardWindow = var_2_10007

		var_3_9(var_3_8, var_3_10, var_2_10007, {
			tasklist = var_3_1,
			ptId = var_3_3,
			totalPt = var_3_7
		})

		return
	end)

	return
end

function var_0_1.OnUpdateFlush(arg_4_0)
	arg_4_0:flush_task_list_pt_xiaobeifa()

	return
end

function var_0_1.flush_task_list_pt_xiaobeifa(arg_5_0)
	arg_5_0:flush_task_list_pt()

	local var_5_0 = arg_5_0.activity
	local var_5_1, var_5_2, var_5_3 = arg_5_0:getDoingTask(var_5_0)

	if var_5_0:getConfig("config_client").main_task then
		local var_5_4 = var_5_3 and var_5_1 or var_5_1 - 1
		local var_5_5 = arg_5_0
		local var_5_6 = arg_5_0.setImportantProgress
		local var_5_7 = var_5_0
		local var_5_8 = arg_5_0._tf

		var_5_6(var_5_5, var_5_7, var_9.Find(var_5_8, "progress_important"), var_5_4, var_5_0:getConfig("config_client").main_task, var_5_0:getConfig("config_data"))
	end

	return
end

function var_0_1.getDoingTask(arg_6_0, arg_6_1, arg_6_2)
	getProxy = var_1_10003
	TaskProxy = var_1_10004

	local var_6_0 = var_1_10003(var_1_10004)

	_ = var_1_10004

	local var_6_1 = var_1_10004.flatten(arg_6_1:getConfig("config_data"))
	local var_6_2
	local var_6_3
	local var_6_4 = arg_6_1
	local var_6_5 = arg_6_1.getConfig(var_6_4, "type")

	ActivityConst = var_6_4

	if var_6_5 == var_6_4.ACTIVITY_TYPE_TASKS then
		for iter_6_0 = #var_6_1, 1, -1 do
			if var_6_0:getFinishTaskById(var_6_1[iter_6_0]) then
				if not var_6_3 then
					var_6_2 = var_6_1[iter_6_0]
					var_6_3 = var_11
				end

				break
			end

			var_6_2 = var_6_1[iter_6_0]
			var_6_3 = var_6_0:getTaskById(var_6_1[iter_6_0])
		end
	else
		getActivityTask = var_6_5

		local var_6_6

		var_6_5, var_6_6 = var_6_5(arg_6_1)
		var_6_3 = var_6_6
		var_6_2 = var_6_5
	end

	if not arg_6_2 then
		assert = var_6_5

		var_6_5(var_6_3, "without taskVO " .. var_6_2 .. " from server")
	end

	table = var_6_5

	return var_6_5.indexof(var_6_1, var_6_2), var_6_2, var_6_3
end

function var_0_1.flush_task_list_pt(arg_7_0)
	local var_7_0 = arg_7_0.activity

	_ = var_1_10002

	local var_7_1 = var_1_10002.flatten(var_7_0:getConfig("config_data"))
	local var_7_2, var_7_3, var_7_4 = arg_7_0:getDoingTask(var_7_0)

	getProxy = var_1_10006
	ActivityProxy = var_1_10007

	local var_7_5 = var_1_10006(var_1_10007)
	local var_7_6 = var_6.getActivityById(var_7_5, var_7_0:getConfig("config_client").rank_act_id).data1

	setText = var_8

	var_8(arg_7_0.phaseTxt, var_7_2 .. "/" .. #var_7_1)

	if var_7_4 then
		local var_7_7 = var_7_4
		local var_7_8 = var_7_4.getConfig(var_7_7, "target_num")

		setColorStr = var_7_7
		math = var_10

		local var_7_9 = var_10.min(var_7_6, var_7_8)

		if var_7_6 < var_7_8 then
			COLOR_RED = var_11

			if not var_11 then
				COLOR_GREEN = var_11
			end

			local var_7_10 = var_7_7(var_7_9, var_11) .. "/" .. var_7_8

			setText = var_10

			var_10(arg_7_0.progressTxt, var_7_10)

			setSlider = var_10

			local var_7_11 = arg_7_0.progress
			local var_7_12 = 0
			local var_7_13 = var_7_8

			math = var_1_10014

			var_10(var_7_11, var_7_12, var_7_13, var_1_10014.min(var_7_6, var_7_8))

			local var_7_14 = var_7_4:getConfig("award_display")[1]
			local var_7_15 = {
				type = var_7_14[1],
				id = var_7_14[2],
				count = var_7_14[3]
			}

			updateDrop = var_12

			var_12(arg_7_0.award, var_7_15)

			onButton = var_12

			local var_7_16 = arg_7_0
			local var_7_17 = arg_7_0.award

			local function var_7_18()
				local var_8_0 = arg_7_0
				local var_8_1 = var_0.emit

				BaseUI = var_2_10002

				var_8_1(var_8_0, var_2_10002.ON_DROP, var_7_15)

				return
			end

			SFX_PANEL = var_16

			var_12(var_7_16, var_7_17, var_7_18, var_16)

			local var_7_19 = arg_7_0.btn
			local var_7_20 = var_12.GetComponent

			typeof = var_7_17
			Image = var_7_18

			local var_7_21 = var_7_20(var_7_19, var_7_17(var_7_18))

			var_7_21.enabled = not var_7_4:isFinish()
			setActive = var_7_21

			local var_7_22 = arg_7_0.btn
			local var_7_23 = var_13.Find(var_7_22, "get")
			local var_7_24

			if var_7_4:isFinish() then
				var_7_24 = not var_7_4:isReceive()
			end

			var_7_21(var_7_23, var_7_24)

			setActive = var_7_21

			local var_7_25 = arg_7_0.btn

			var_7_21(var_13.Find(var_7_25, "achieved"), var_7_4:isReceive())

			onButton = var_7_21

			local var_7_26 = arg_7_0
			local var_7_27 = arg_7_0.btn

			local function var_7_28()
				local var_9_0 = var_7_4

				if not var_0.isFinish(var_9_0) then
					local var_9_1 = arg_7_0
					local var_9_2 = var_0.emit

					ActivityMediator = var_2_10002

					var_9_2(var_9_1, var_2_10002.ON_TASK_GO, var_7_4)
				else
					local var_9_3 = arg_7_0

					if not var_0.TaskSubmitCheck(var_9_3, var_7_4) then
						return
					end

					local var_9_4 = arg_7_0
					local var_9_5 = var_0.emit

					ActivityMediator = var_2

					var_9_5(var_9_4, var_2.ON_TASK_SUBMIT, var_7_4)
				end

				return
			end

			SFX_PANEL = var_16

			var_7_21(var_7_26, var_7_27, var_7_28, var_16)

			setButtonEnabled = var_7_21

			var_7_21(arg_7_0.btn, not var_7_4:isReceive())

			return
		end
	end
end

function var_0_1.TaskSubmitCheck(arg_10_0, arg_10_1)
	if var_0_1.checkList[arg_10_1.id] then
		getProxy = var_2
		BayProxy = var_3

		local var_10_0 = var_2(var_3)
		local var_10_1 = var_2.getShips(var_10_0)

		ipairs = var_10_0

		for iter_10_0, iter_10_1 in var_10_0(var_10_1) do
			if iter_10_1:getGroupId() == var_0_1.checkList[arg_10_1.id] and iter_10_1:isActivityNpc() then
				return true
			end
		end

		pg = var_3

		local var_10_2 = var_3.TipsMgr.GetInstance()
		local var_10_3 = var_3.ShowTips

		i18n = var_5

		var_10_3(var_10_2, var_5("task_submitTask_error_client"))

		return false
	end

	return true
end

function var_0_1.setImportantProgress(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = arg_11_2:Find("award_display")
	local var_11_1 = arg_11_2
	local var_11_2 = arg_11_2.Find(var_11_1, "important_task_tpl")

	getProxy = var_11_1
	TaskProxy = var_9

	local var_11_3 = var_11_1(var_9)

	pg = var_9

	local var_11_4 = var_9.task_data_template[arg_11_5[#arg_11_5]].target_num

	getProxy = var_10
	ActivityProxy = var_1_10011

	local var_11_5 = var_10(var_1_10011)
	local var_11_6 = var_10.getActivityById(var_11_5, arg_11_1:getConfig("config_client").rank_act_id).data1

	setSlider = var_12

	var_12(arg_11_2, 0, var_11_4, var_11_6)

	local var_11_7
	local var_11_8 = var_11_0
	local var_11_9 = var_11_0.GetComponent

	typeof = var_15
	RectTransform = var_16

	local var_11_10 = var_11_9(var_11_8, var_15(var_16)).rect.width
	local var_11_11

	removeAllChildren = var_15

	var_15(var_11_0)

	setActive = var_15

	var_15(var_11_2, false)

	ipairs = var_15

	for iter_11_0, iter_11_1 in var_15(arg_11_4) do
		ipairs = var_1_10020

		for iter_11_2, iter_11_3 in var_1_10020(arg_11_5) do
			if iter_11_1 == iter_11_3 then
				Instantiate = var_1_10025

				local var_11_12 = var_1_10025(var_11_2)

				SetParent = var_1_10025

				var_1_10025(var_11_12, var_11_0)

				setActive = var_1_10025

				var_1_10025(var_11_12, true)

				setAnchoredPosition = var_1_10025

				local var_11_13 = var_11_12
				local var_11_14 = {}

				pg = var_1_10028
				var_11_14.x = var_1_10028.task_data_template[arg_11_5[iter_11_2]].target_num / var_11_4 * var_11_10

				var_1_10025(var_11_13, var_11_14)

				pg = var_1_10025

				local var_11_15 = var_1_10025.task_data_template[iter_11_1].award_display[1]

				var_1_10028 = var_11_12

				local var_11_16 = var_11_12.Find(var_1_10028, "award")

				var_1_10028 = {
					type = var_11_15[1],
					id = var_11_15[2],
					count = var_11_15[3]
				}
				updateDrop = var_29

				var_29(var_11_16, var_1_10028)

				onButton = var_29

				local var_11_17 = arg_11_0
				local var_11_18 = var_11_16

				local function var_11_19()
					local var_12_0 = arg_11_0
					local var_12_1 = var_0.emit

					BaseUI = var_2_10002

					var_12_1(var_12_0, var_2_10002.ON_DROP, var_1_10028)

					return
				end

				SFX_PANEL = var_1_10033

				var_29(var_11_17, var_11_18, var_11_19, var_1_10033)

				setText = var_29

				var_29(var_11_12:Find("Text"), var_1_10025.target_num)

				local var_11_20 = var_11_16
				local var_11_21 = var_11_16.Find(var_11_20, "mask")

				setActive = var_11_20

				var_11_20(var_11_21, iter_11_2 <= arg_11_3)

				break
			end
		end
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

return var_0_1
