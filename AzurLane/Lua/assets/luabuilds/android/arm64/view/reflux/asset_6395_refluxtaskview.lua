class = var_0_10000

local var_0_0 = "RefluxTaskView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RefluxTaskUI"
end

function var_0_1.OnInit(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:updateUI()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	return
end

function var_0_1.OnBackPress(arg_4_0)
	arg_4_0:Hide()

	return
end

function var_0_1.initData(arg_5_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003
	arg_5_0.taskProxy = var_1_10001(var_1_10003)
	getProxy = var_1
	RefluxProxy = var_1_10003
	arg_5_0.refluxProxy = var_1(var_1_10003)
	pg = var_1

	local var_5_0 = var_1.return_task_template.all

	pg = var_1_10002

	local var_5_1 = var_5_0[#var_1_10002.return_task_template.all]

	pg = var_2
	arg_5_0.totalDayCount = var_2.return_task_template[var_5_1].reward_date
	arg_5_0.taskVOList = nil
	arg_5_0.taskVOListForShow = nil
	arg_5_0.lastSubmitTaskIDList = {}

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf
	local var_6_1 = var_1.Find(var_6_0, "DayImg")

	arg_6_0.daySpriteList = {}

	for iter_6_0 = 0, arg_6_0.totalDayCount - 1 do
		local var_6_2 = var_6_1
		local var_6_3 = var_6_1.GetChild(var_6_2, iter_6_0)

		getImageSprite = var_1_10007
		var_1_10007 = var_1_10007(var_6_3)
		table = var_6_2

		var_6_2.insert(arg_6_0.daySpriteList, var_1_10007)
	end

	local var_6_4 = arg_6_0._tf

	arg_6_0.itemTpl = var_2.Find(var_6_4, "ItemTpl")

	local var_6_5 = arg_6_0._tf
	local var_6_6 = var_2.Find(var_6_5, "TaskTpl")
	local var_6_7 = arg_6_0._tf
	local var_6_8 = var_3.Find(var_6_7, "ScrollRect/Container")

	UIItemList = var_6_5
	arg_6_0.taskUIList = var_6_5.New(var_6_8, var_6_6)

	local var_6_9 = arg_6_0.taskUIList

	var_4.make(var_6_9, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			arg_7_1 = arg_7_1 + 1

			local var_7_0 = arg_6_0.taskVOListForShow[arg_7_1]
			local var_7_1 = arg_6_0

			var_4.updateTask(var_7_1, arg_7_2, var_7_0)
		end

		return
	end)

	local var_6_10 = arg_6_0._tf

	arg_6_0.taskProgressText = var_4.Find(var_6_10, "BG/ProgressText")

	local var_6_11 = arg_6_0._tf

	arg_6_0.oneStepBtnDisable = var_4.Find(var_6_11, "OneStepDisable")

	local var_6_12 = arg_6_0._tf

	arg_6_0.oneStepBtn = var_4.Find(var_6_12, "OneStepBtn")
	onButton = var_4

	local var_6_13 = arg_6_0
	local var_6_14 = arg_6_0.oneStepBtn

	local function var_6_15()
		local var_8_0 = arg_6_0

		if var_0.isTaskListOverflow(var_8_0) then
			pg = var_2_10001

			local var_8_1 = var_2_10001.TipsMgr.GetInstance()
			local var_8_2 = var_1.ShowTips

			i18n = var_2_10004

			var_8_2(var_8_1, var_2_10004("award_overflow_tip"))

			return
		else
			local var_8_3 = {}
			local var_8_4 = {}
			local var_8_5 = arg_6_0
			local var_8_6 = var_3.getTaskVOList(var_8_5)

			ipairs = var_2_10004

			for iter_8_0, iter_8_1 in var_2_10004(var_8_6) do
				local var_8_7 = iter_8_1:getTaskStatus()
				local var_8_8 = arg_6_0
				local var_8_9, var_8_10 = var_10.isTaskOverflow(var_8_8, iter_8_1)

				if var_8_7 == 1 then
					local var_8_11 = arg_6_0

					if var_12.isTaskUnlocked(var_8_11, iter_8_1) and not var_8_9 then
						table = var_12

						var_12.insert(var_8_3, iter_8_1)

						table = var_12

						var_12.insert(var_8_4, iter_8_1.id)
					end
				end
			end

			if #var_8_3 > 0 then
				local var_8_12 = arg_6_0

				var_4.setLastSubmitTask(var_8_12, var_8_4)

				pg = var_4

				local var_8_13 = var_4.m02
				local var_8_14 = var_4.sendNotification

				GAME = var_7

				var_8_14(var_8_13, var_7.SUBMIT_TASK_ONESTEP, {
					resultList = var_8_3
				})
			end
		end

		return
	end

	SFX_PANEL = var_1_10009

	var_4(var_6_13, var_6_14, var_6_15, var_1_10009)

	return
end

function var_0_1.updateData(arg_9_0)
	arg_9_0.taskVOList = arg_9_0:getTaskVOList()
	arg_9_0.taskVOListForShow = arg_9_0:getTaskVOListForShow()

	return
end

function var_0_1.updateUI(arg_10_0)
	arg_10_0:updateData()
	arg_10_0:updateTaskList()
	arg_10_0:updateTaskProgress()
	arg_10_0:updateOneStepBtn()

	return
end

function var_0_1.updateOutline(arg_11_0)
	return
end

function var_0_1.updateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1
	local var_12_1 = arg_12_1.Find(var_12_0, "Icon")
	local var_12_2 = arg_12_1
	local var_12_3 = arg_12_1.Find(var_12_2, "Count")

	setText = var_12_0

	var_12_0(var_12_3, arg_12_2.count)

	local var_12_4 = arg_12_2.type

	DROP_TYPE_SHIP = var_12_2

	if var_12_4 ~= var_12_2 then
		setImageSprite = var_12_4

		local var_12_5 = var_12_1

		LoadSprite = var_8

		var_12_4(var_12_5, var_8(arg_12_2:getIcon()))
	else
		Ship = var_12_4

		local var_12_6 = var_12_4.New({
			configId = arg_12_2.id
		})
		local var_12_7 = var_5.getPainting(var_12_6)

		setImageSprite = var_7

		local var_12_8 = var_12_1

		LoadSprite = var_1_10010

		var_7(var_12_8, var_1_10010("QIcon/" .. var_12_7))
	end

	return
end

function var_0_1.updateTaskList(arg_13_0)
	local var_13_0 = arg_13_0.taskUIList

	var_1.align(var_13_0, #arg_13_0.taskVOListForShow)

	return
end

function var_0_1.updateTask(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1:Find("Go")
	local var_14_1 = var_3.Find(var_14_0, "Btn")
	local var_14_2 = var_3:Find("Progress")
	local var_14_3 = var_5.Find(var_14_2, "Text")
	local var_14_4 = arg_14_1:Find("Get")
	local var_14_5 = var_7.Find(var_14_4, "Btn")
	local var_14_6 = var_7:Find("Progress")
	local var_14_7 = var_9.Find(var_14_6, "Text")
	local var_14_8 = arg_14_1
	local var_14_9 = arg_14_1.Find(var_14_8, "Got")
	local var_14_10 = arg_14_2:getTaskStatus()

	setActive = var_14_8

	var_14_8(var_3, var_14_10 == 0)

	setActive = var_14_8

	var_14_8(var_7, var_14_10 == 1)

	setActive = var_14_8

	var_14_8(var_14_9, var_14_10 == 2)

	local var_14_11 = arg_14_1
	local var_14_12 = arg_14_1.Find(var_14_11, "DayImg")
	local var_14_13 = arg_14_0
	local var_14_14 = arg_14_0.getTaskUnlockSignCount(var_14_13, arg_14_2)

	setImageSprite = var_14_11

	var_14_11(var_14_12, arg_14_0.daySpriteList[var_14_14])

	local var_14_15 = arg_14_1
	local var_14_16 = arg_14_1.Find(var_14_15, "Lock")

	setActive = var_14_13

	var_14_13(var_14_16, not arg_14_0:isTaskUnlocked(arg_14_2))

	local var_14_17 = arg_14_1:Find("DescText")

	setText = var_14_15

	var_14_15(var_14_17, arg_14_2:getConfig("desc"))

	local var_14_18 = arg_14_2
	local var_14_19 = arg_14_2.getProgress(var_14_18)
	local var_14_20 = arg_14_2:getConfig("target_num")

	setSlider = var_14_18

	var_14_18(var_5, 0, var_14_20, var_14_19)

	setText = var_14_18

	var_14_18(var_14_3, var_14_19 .. "/" .. var_14_20)

	setSlider = var_14_18

	var_14_18(var_9, 0, var_14_20, var_14_19)

	setText = var_14_18

	var_14_18(var_14_7, var_14_19 .. "/" .. var_14_20)

	local var_14_21 = arg_14_1
	local var_14_22 = arg_14_1.Find(var_14_21, "Drops")
	local var_14_23 = arg_14_0:getTaskAwardForShow(arg_14_2)

	UIItemList = var_14_21

	local var_14_24 = var_14_21.New(var_14_22, arg_14_0.itemTpl)

	var_21.make(var_14_24, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventUpdate then
			arg_15_1 = arg_15_1 + 1

			local var_15_0 = var_14_23[arg_15_1]
			local var_15_1 = arg_14_0

			var_4.updateItem(var_15_1, arg_15_2, var_15_0)
		end

		return
	end)
	var_21:align(#var_14_23)

	onButton = var_22

	local var_14_25 = arg_14_0
	local var_14_26 = var_14_1

	local function var_14_27()
		pg = var_2_10000

		local var_16_0 = var_2_10000.m02
		local var_16_1 = var_0.sendNotification

		GAME = var_2_10003

		var_16_1(var_16_0, var_2_10003.TASK_GO, {
			taskVO = arg_14_2
		})

		return
	end

	SFX_PANEL = var_1_10027

	var_22(var_14_25, var_14_26, var_14_27, var_1_10027)

	onButton = var_22

	local var_14_28 = arg_14_0
	local var_14_29 = var_14_5

	local function var_14_30()
		local function var_17_0()
			pg = var_3_10000

			local var_18_0 = var_3_10000.m02
			local var_18_1 = var_0.sendNotification

			GAME = var_3_10003

			var_18_1(var_18_0, var_3_10003.SUBMIT_TASK, arg_14_2.id)

			local var_18_2 = arg_14_0

			var_0.setLastSubmitTask(var_18_2, {
				arg_14_2.id
			})

			return
		end

		local var_17_1 = arg_14_0
		local var_17_2, var_17_3 = var_1.isTaskOverflow(var_17_1, arg_14_2)

		if var_17_2 then
			pg = var_17_1

			local var_17_4 = var_17_1.MsgboxMgr.GetInstance()
			local var_17_5 = var_3.ShowMsgBox
			local var_17_6 = {}

			MSGBOX_TYPE_ITEM_BOX = var_2_10007
			var_17_6.type = var_2_10007
			i18n = var_2_10007
			var_17_6.content = var_2_10007("award_max_warning")
			var_17_6.items = var_17_3
			var_17_6.onYes = var_17_0

			var_17_5(var_17_4, var_17_6)
		else
			var_17_0()
		end

		return
	end

	SFX_PANEL = var_1_10027

	var_22(var_14_28, var_14_29, var_14_30, var_1_10027)

	return
end

function var_0_1.updateTaskProgress(arg_19_0)
	local var_19_0 = arg_19_0:getTaskVOList()
	local var_19_1 = 0
	local var_19_2 = #var_19_0

	ipairs = var_1_10004

	for iter_19_0, iter_19_1 in var_1_10004(var_19_0) do
		if arg_19_0:isTaskUnlocked(iter_19_1) then
			var_19_1 = var_19_1 + 1
		end
	end

	setText = var_4

	var_4(arg_19_0.taskProgressText, var_19_1 .. "/" .. var_19_2)

	return
end

function var_0_1.updateOneStepBtn(arg_20_0)
	local var_20_0 = 0
	local var_20_1 = arg_20_0:getTaskVOList()

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(var_20_1) do
		if iter_20_1:getTaskStatus() == 1 and arg_20_0:isTaskUnlocked(iter_20_1) then
			var_20_0 = var_20_0 + 1
		end
	end

	setActive = var_3

	var_3(arg_20_0.oneStepBtnDisable, not (var_20_0 > 1))

	return
end

function var_0_1.getTaskVOList(arg_21_0)
	local var_21_0 = {}

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10002(var_1_10004.return_task_template.all) do
		local var_21_1 = arg_21_0.taskProxy
		local var_21_2 = var_7.getTaskVO(var_21_1, iter_21_1)

		table = var_1_10008

		var_1_10008.insert(var_21_0, var_21_2)
	end

	return var_21_0
end

function var_0_1.getTaskVOListForShow(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = {}

	ipairs = var_1_10003

	for iter_22_0, iter_22_1 in var_1_10003(arg_22_0.taskVOList) do
		if arg_22_0:isTaskUnlocked(iter_22_1) then
			table = var_8

			var_8.insert(var_22_0, iter_22_1)
		else
			table = var_8

			var_8.insert(var_22_1, iter_22_1)
		end
	end

	local function var_22_2(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_0:getTaskStatus()
		local var_23_1 = arg_23_1:getTaskStatus()

		if var_23_0 == 2 then
			var_23_0 = -1
		end

		if var_23_1 == 2 then
			var_23_1 = -1
		end

		if var_23_0 == var_23_1 then
			local var_23_2 = arg_22_0
			local var_23_3 = var_4.getTaskUnlockSignCount(var_23_2, arg_23_0)
			local var_23_4 = arg_22_0

			return var_23_3 < var_5.getTaskUnlockSignCount(var_23_4, arg_23_1)
		else
			return var_23_1 < var_23_0
		end

		return
	end

	table = var_4

	var_4.sort(var_22_0, var_22_2)

	local function var_22_3(arg_24_0, arg_24_1)
		return arg_24_0.id < arg_24_1.id
	end

	table = var_5

	var_5.sort(var_22_1, var_22_3)

	local var_22_4 = {}

	ipairs = var_6

	for iter_22_2, iter_22_3 in var_6(var_22_0) do
		table = var_1_10011

		var_1_10011.insert(var_22_4, iter_22_3)
	end

	ipairs = var_6

	for iter_22_4, iter_22_5 in var_6(var_22_1) do
		table = var_1_10011

		var_1_10011.insert(var_22_4, iter_22_5)
	end

	return var_22_4
end

function var_0_1.getTaskUnlockSignCount(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.id

	pg = var_1_10003

	return var_1_10003.return_task_template[var_25_0].reward_date
end

function var_0_1.isTaskUnlocked(arg_26_0, arg_26_1)
	return arg_26_0:getTaskUnlockSignCount(arg_26_1) <= arg_26_0.refluxProxy.signCount
end

function var_0_1.isTaskOverflow(arg_27_0, arg_27_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_27_0 = var_1_10002(var_1_10004)
	local var_27_1 = var_2.getRawData(var_27_0)

	pg = var_1_10003

	local var_27_2 = var_1_10003.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_27_0

	if var_27_0 then
		var_27_0 = 0
	else
		getProxy = var_27_0
		BagProxy = var_1_10006

		local var_27_3 = var_27_0(var_1_10006)
		local var_27_4 = var_4.GetLimitCntById(var_27_3, var_27_2)
	end

	local var_27_5 = arg_27_0:getTaskAwardForShow(arg_27_1)
	local var_27_6 = {
		var_27_5[1].type,
		var_27_5[1].id,
		var_27_5[1].count
	}
	local var_27_7 = {
		var_27_6
	}

	Task = var_8

	local var_27_8, var_27_9 = var_8.StaticJudgeOverflow(false, false, false, true, true, var_27_7)

	return var_27_8, var_27_9
end

function var_0_1.isTaskListOverflow(arg_28_0)
	local var_28_0 = {}
	local var_28_1 = arg_28_0:getTaskVOList()

	ipairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(var_28_1) do
		if iter_28_1:getTaskStatus() == 1 and arg_28_0:isTaskUnlocked(iter_28_1) then
			local var_28_2 = arg_28_0:getTaskAwardForShow(iter_28_1)[1].type
			local var_28_3 = var_1_10009[1].id
			local var_28_4 = var_1_10009[1].count
			local var_28_5

			if not var_28_0[var_28_3] then
				var_28_5 = {
					var_28_2,
					var_28_3,
					var_28_4
				}
			else
				var_28_5[3] = var_28_5[3] + var_28_4
			end

			var_28_0[var_28_3] = var_28_5
		end
	end

	local var_28_6 = {}

	pairs = var_4

	for iter_28_2, iter_28_3 in var_4(var_28_0) do
		table = var_1_10009

		var_1_10009.insert(var_28_6, iter_28_3)
	end

	Task = var_4

	local var_28_7, var_28_8 = var_4.StaticJudgeOverflow(false, false, false, true, true, var_28_6)

	return var_28_7, var_28_8
end

function var_0_1.setLastSubmitTask(arg_29_0, arg_29_1)
	arg_29_0.lastSubmitTaskIDList = arg_29_1

	return
end

function var_0_1.clearLastSubmitTask(arg_30_0)
	arg_30_0.lastSubmitTaskIDList = {}

	return
end

function var_0_1.calcLastSubmitTaskPT(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = 0

	ipairs = var_1_10003

	for iter_31_0, iter_31_1 in var_1_10003(arg_31_0.lastSubmitTaskIDList) do
		pg = var_1_10008
		var_31_0 = var_31_0 + var_1_10008.return_task_template[iter_31_1].pt_award
		var_31_1 = var_1_10008.pt_item
	end

	arg_31_0:clearLastSubmitTask()

	local var_31_2 = {}

	DROP_TYPE_ITEM = var_4
	var_31_2.type = var_4
	var_31_2.id = var_31_1
	var_31_2.count = var_31_0

	return var_31_2
end

function var_0_1.getTaskAwardForShow(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1.id

	pg = var_1_10003

	local var_32_1 = var_1_10003.return_task_template[var_32_0].level
	local var_32_2 = arg_32_0.refluxProxy.returnLV
	local var_32_3

	ipairs = var_1_10007

	for iter_32_0, iter_32_1 in var_1_10007(var_32_1) do
		local var_32_4 = iter_32_1[1]
		local var_32_5 = iter_32_1[2]

		if var_32_4 <= var_32_2 and var_32_2 <= var_32_5 then
			var_32_3 = iter_32_0
		end
	end

	local var_32_6 = {}
	local var_32_7 = var_3.award_display[var_32_3]

	Drop = iter_32_0

	local var_32_8 = iter_32_0.New({
		type = var_32_7[1],
		id = var_32_7[2],
		count = var_32_7[3]
	})

	table = iter_32_1

	iter_32_1.insert(var_32_6, var_32_8)

	local var_32_9 = var_3.pt_award
	local var_32_10 = var_3.pt_item

	Drop = var_13

	local var_32_11 = var_13.New
	local var_32_12 = {}

	DROP_TYPE_ITEM = var_1_10016
	var_32_12.type = var_1_10016
	var_32_12.id = var_32_10
	var_32_12.count = var_32_9

	local var_32_13 = var_32_11(var_32_12)

	table = var_14

	var_14.insert(var_32_6, var_32_13)

	return var_32_6
end

function var_0_1.isAnyTaskCanGetAward()
	getProxy = var_1_10000
	TaskProxy = var_1_10002

	local var_33_0 = var_1_10000(var_1_10002)

	getProxy = var_1_10001
	RefluxProxy = var_1_10003

	local var_33_1 = var_1_10001(var_1_10003)
	local var_33_2 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	for iter_33_0, iter_33_1 in var_1_10003(var_1_10005.return_task_template.all) do
		local var_33_3 = var_33_0:getTaskVO(iter_33_1)

		table = var_1_10009

		var_1_10009.insert(var_33_2, var_33_3)
	end

	local function var_33_4(arg_34_0)
		local var_34_0 = arg_34_0.id

		pg = var_2_10002

		return var_2_10002.return_task_template[var_34_0].reward_date
	end

	local function var_33_5(arg_35_0)
		return var_33_4(arg_35_0) <= var_33_1.signCount
	end

	ipairs = var_5

	for iter_33_2, iter_33_3 in var_5(var_33_2) do
		if iter_33_3:getTaskStatus() == 1 and var_33_5(iter_33_3) then
			return true
		end
	end

	return false
end

return var_0_1
