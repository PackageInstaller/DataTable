class = var_0_10000

local var_0_0 = "TaskWeekPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TaskCommonPage"))

var_0_1.WEEK_TASK_TYPE_COMMON = 1
var_0_1.WEEK_TASK_TYPE_PT = 2

function var_0_1.getUIName(arg_1_0)
	return "TaskListForWeekPage"
end

function var_0_1.RefreshWeekProgress(arg_2_0)
	arg_2_0:UpdateWeekProgress(arg_2_0.contextData.weekTaskProgressInfo)

	return
end

function var_0_1.OnLoaded(arg_3_0)
	var_0_1.super.OnLoaded(arg_3_0)

	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "task_progress")

	setActive = var_3_0

	var_3_0(var_3_1, true)

	setText = var_3_0

	local var_3_2 = var_3_1
	local var_3_3 = var_3_1.Find(var_3_2, "title")

	i18n = var_3_2

	var_3_0(var_3_3, var_3_2("week_task_title_label"))

	arg_3_0.awardPreviewBtn = var_3_1:Find("award_preview")
	setText = var_2

	local var_3_4 = arg_3_0.awardPreviewBtn
	local var_3_5 = var_3.Find(var_3_4, "Text")

	i18n = var_3_4

	var_2(var_3_5, var_3_4("week_task_award_preview_label"))

	local var_3_6 = var_3_1:Find("phase/Text")
	local var_3_7 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_3_0.phaseTxt = var_3_7(var_3_6, var_4(var_5))

	local var_3_8 = var_3_1:Find("slider")
	local var_3_9 = var_2.GetComponent

	typeof = var_4
	Slider = var_5
	arg_3_0.progressSlider = var_3_9(var_3_8, var_4(var_5))

	local var_3_10 = var_3_1:Find("slider/Text")
	local var_3_11 = var_2.GetComponent

	typeof = var_4
	Text = var_5
	arg_3_0.progressTxt = var_3_11(var_3_10, var_4(var_5))
	UIItemList = var_2
	arg_3_0.awardList = var_2.New(var_3_1:Find("awards"), var_3_1:Find("awards/itemtpl"))
	arg_3_0.getBtn = var_3_1:Find("get_btn")

	local var_3_12 = arg_3_0.getBtn

	arg_3_0.getBtnEnableTF = var_2.Find(var_3_12, "enable")

	local var_3_13 = arg_3_0.getBtn

	arg_3_0.getBtnDisableTF = var_2.Find(var_3_13, "disable")
	arg_3_0.tip = var_3_1:Find("tip")
	onButton = var_2

	local var_3_14 = arg_3_0
	local var_3_15 = arg_3_0.awardPreviewBtn

	local function var_3_16()
		local var_4_0 = arg_3_0.contextData.weekTaskProgressInfo
		local var_4_1 = arg_3_0.contextData.ptAwardWindow

		var_1.ExecuteAction(var_4_1, "Display", var_4_0:GetAllPhaseDrops())

		return
	end

	SFX_PANEL = var_6

	var_2(var_3_14, var_3_15, var_3_16, var_6)

	return
end

function var_0_1.onUpdateTask(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.onUpdateTask(arg_5_0, arg_5_1, arg_5_2)

	arg_5_2.name = arg_5_0.taskCards[arg_5_2].taskVO.id

	return
end

function var_0_1.Update(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.contextData.weekTaskProgressInfo

	if var_4.ReachMaxPt(var_6_0) and arg_6_0:isShowing() then
		pg = var_5

		local var_6_1 = var_5.UIMgr.GetInstance()

		var_5.LoadingOn(var_6_1, false)
		arg_6_0:DoDisablePtTaskAnim(function()
			pg = var_2_10000

			local var_7_0 = var_2_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_7_0)

			local var_7_1 = arg_6_0

			var_0.Flush(var_7_1, arg_6_2)

			if arg_6_3 then
				local var_7_2 = arg_6_3
				local var_7_3

				if not arg_6_0.taskVOs then
					var_7_3 = {}
				end

				var_7_2(var_7_3)
			end

			return
		end)
	else
		TaskScene = var_5

		local var_6_2

		if var_5.IsPassScenario() then
			arg_6_0:Flush(arg_6_2)

			if arg_6_3 then
				var_6_2 = arg_6_3

				local var_6_3

				if not arg_6_0.taskVOs then
					var_6_3 = {}
				end

				var_6_2(var_6_3)
			end
		else
			setActive = var_6_2

			var_6_2(arg_6_0._tf, false)

			if arg_6_3 then
				arg_6_3({})
			end
		end
	end

	return
end

function var_0_1.DoDisablePtTaskAnim(arg_8_0, arg_8_1)
	local function var_8_0(arg_9_0, arg_9_1)
		arg_9_0:DoSubmitAnim(function()
			setActive = var_3_10000

			var_3_10000(arg_9_0._go, false)
			arg_9_1()

			return
		end)

		return
	end

	arg_8_0._scrollView.enabled = false

	local var_8_1 = {}

	ipairs = var_4

	local var_8_2

	if not arg_8_0.taskVOs then
		var_8_2 = {}
	end

	for iter_8_0, iter_8_1 in var_4(var_8_2) do
		if iter_8_1.isWeekTask then
			local var_8_3 = arg_8_0

			if arg_8_0.GetCard(var_8_3, iter_8_1.id) then
				table = var_8_3

				var_8_3.insert(var_8_1, function(arg_11_0)
					var_8_0(var_0, arg_11_0)

					return
				end)
			end
		end
	end

	seriesAsync = var_4

	var_4(var_8_1, function()
		arg_8_0._scrollView.enabled = true

		arg_8_1()

		return
	end)

	return
end

function var_0_1.GetCard(arg_13_0, arg_13_1)
	pairs = var_1_10002

	for iter_13_0, iter_13_1 in var_1_10002(arg_13_0.taskCards) do
		if iter_13_1.taskVO.id == arg_13_1 then
			return iter_13_1
		end
	end

	return nil
end

function var_0_1.Flush(arg_14_0, arg_14_1)
	arg_14_0.taskVOs = {}

	local var_14_0 = arg_14_0.contextData.weekTaskProgressInfo

	arg_14_0:UpdateWeekProgress(var_14_0)

	local var_14_1 = var_14_0

	if not var_14_0.ReachMaxPt(var_14_1) then
		var_14_1 = var_14_0

		local var_14_2 = var_14_0.GetSubTasks(var_14_1)

		pairs = var_14_1

		for iter_14_0, iter_14_1 in var_14_1(var_14_2) do
			table = var_1_10009

			var_1_10009.insert(arg_14_0.taskVOs, iter_14_1)
		end
	end

	local var_14_3 = arg_14_0.contextData.taskVOsById

	pairs = var_14_1

	for iter_14_2, iter_14_3 in var_14_1(var_14_3) do
		if iter_14_3:ShowOnTaskScene() and arg_14_1[iter_14_3:GetRealType()] then
			table = var_9

			var_9.insert(arg_14_0.taskVOs, iter_14_3)
		end
	end

	table = var_4

	local var_14_4 = var_4.sort
	local var_14_5 = arg_14_0.taskVOs

	CompareFuncs = var_6

	var_14_4(var_14_5, var_6({
		function(arg_15_0)
			return -arg_15_0:getTaskStatus(arg_15_0)
		end,
		function(arg_16_0)
			pg = var_2_10001

			local var_16_0 = var_2_10001.NewGuideMgr.GetInstance()
			local var_16_2

			if var_1.IsBusy(var_16_0) then
				local var_16_1 = arg_16_0.id

				getDorm3dGameset = var_16_0

				if var_16_1 == var_16_0("drom3d_weekly_task")[1] then
					var_16_2 = 0

					goto label_16_0
				end
			end

			var_16_2 = 1

			::label_16_0::

			return var_16_2
		end,
		function(arg_17_0)
			return arg_17_0.isWeekTask and 1 or 0
		end,
		function(arg_18_0)
			return arg_18_0.id
		end
	}))
	arg_14_0:Show()

	arg_14_0._scrollView.enabled = true

	local var_14_6 = arg_14_0._scrollView

	var_4.SetTotalCount(var_14_6, #arg_14_0.taskVOs, -1)

	return
end

function var_0_1.UpdateWeekProgress(arg_19_0, arg_19_1)
	arg_19_0:UpdateWeekProgressGetBtn(arg_19_1)

	arg_19_0.phaseTxt.text = arg_19_1:GetPhase() .. "/" .. arg_19_1:GetTotalPhase()

	local var_19_0 = arg_19_1:GetProgress()
	local var_19_1 = arg_19_1:GetTarget()

	arg_19_0.progressSlider.value = var_19_0 / var_19_1
	arg_19_0.progressTxt.text = var_19_0 .. "/" .. var_19_1

	local var_19_2 = arg_19_1:GetDropList()
	local var_19_3 = arg_19_0.awardList

	var_5.make(var_19_3, function(arg_20_0, arg_20_1, arg_20_2)
		UIItemList = var_2_10003

		if arg_20_0 == var_2_10003.EventUpdate then
			local var_20_0 = var_19_2[arg_20_1 + 1]
			local var_20_1 = {
				type = var_20_0[1],
				id = var_20_0[2],
				count = var_20_0[3]
			}

			updateDrop = var_5

			var_5(arg_20_2, var_20_1)

			onButton = var_5

			local var_20_2 = arg_19_0
			local var_20_3 = arg_20_2

			local function var_20_4()
				local var_21_0 = arg_19_0
				local var_21_1 = var_0.emit

				TaskMediator = var_3_10002

				var_21_1(var_21_0, var_3_10002.ON_DROP, var_20_1)

				return
			end

			SFX_PANEL = var_2_10009

			var_5(var_20_2, var_20_3, var_20_4, var_2_10009)
		end

		return
	end)

	local var_19_4 = arg_19_0.awardList

	var_5.align(var_19_4, #var_19_2)

	return
end

function var_0_1.UpdateWeekProgressGetBtn(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_1.CanUpgrade(var_22_0)

	setGray = var_22_0

	var_22_0(arg_22_0.getBtn, not var_22_1, false)

	setActive = var_22_0

	var_22_0(arg_22_0.getBtnEnableTF, var_22_1)

	setActive = var_22_0

	var_22_0(arg_22_0.getBtnDisableTF, not var_22_1)

	setActive = var_22_0

	var_22_0(arg_22_0.tip, var_22_1)

	onButton = var_22_0

	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.getBtn

	local function var_22_4()
		if var_22_1 then
			local var_23_0 = arg_22_0

			var_0.JudgeOverflow(var_23_0, arg_22_1, function()
				local var_24_0 = arg_22_0
				local var_24_1 = var_0.emit

				TaskMediator = var_3_10002

				var_24_1(var_24_0, var_3_10002.ON_SUBMIT_WEEK_PROGREE)

				return
			end)
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_22_0(var_22_2, var_22_3, var_22_4, var_1_10007)

	return
end

function var_0_1.JudgeOverflow(arg_25_0, arg_25_1, arg_25_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10004

	local var_25_0 = var_1_10003(var_1_10004)
	local var_25_1 = var_3.getRawData(var_25_0)

	pg = var_25_0

	local var_25_2 = var_25_0.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_1_10005

	if var_1_10005 then
		var_1_10005 = 0
	else
		getProxy = var_1_10005
		BagProxy = var_1_10006

		local var_25_3 = var_1_10005(var_1_10006)

		var_1_10005 = var_1_10005.GetLimitCntById(var_25_3, var_25_2)
	end

	local var_25_4 = arg_25_1
	local var_25_5 = arg_25_1.GetDropList(var_25_4)

	Task = var_25_4

	local var_25_6, var_25_7 = var_25_4.StaticJudgeOverflow(var_25_1.gold, var_25_1.oil, var_1_10005, true, true, var_25_5)

	if var_25_6 then
		pg = var_9

		local var_25_8 = var_9.MsgboxMgr.GetInstance()
		local var_25_9 = var_9.ShowMsgBox
		local var_25_10 = {}

		MSGBOX_TYPE_ITEM_BOX = var_12
		var_25_10.type = var_12
		i18n = var_12
		var_25_10.content = var_12("award_max_warning")
		var_25_10.items = var_25_7
		var_25_10.onYes = arg_25_2

		var_25_9(var_25_8, var_25_10)
	else
		arg_25_2()
	end

	return
end

function var_0_1.OnDestroy(arg_26_0)
	local var_26_0 = arg_26_0._scrollView.onValueChanged

	var_1.RemoveAllListeners(var_26_0)

	return
end

function var_0_1.RefreshWeekTaskPageBefore(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0

	if arg_27_0.GetCard(var_27_0, arg_27_1) then
		setActive = var_27_0

		var_27_0(var_2._go, false)
	end

	return
end

return var_0_1
