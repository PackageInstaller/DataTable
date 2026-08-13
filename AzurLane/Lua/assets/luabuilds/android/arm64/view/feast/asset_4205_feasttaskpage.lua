class = var_0_10000

local var_0_0 = "FeastTaskPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.PAGE_PT = 1
var_0_1.PAGE_TASK = 2

function var_0_1.getUIName(arg_1_0)
	return "FeastTaskPage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.getAllBtn = var_1.Find(var_2_0, "main/getall")

	local var_2_1 = arg_2_0.getAllBtn

	arg_2_0.getAllTip = var_1.Find(var_2_1, "tip")

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_1.Find(var_2_2, "main/level/Text")
	local var_2_4 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.levelTxt = var_2_4(var_2_3, var_4(var_1_10006))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "main/level/value/Text")
	local var_2_7 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.progressTxt = var_2_7(var_2_6, var_4(var_1_10006))

	local var_2_8 = arg_2_0._tf

	arg_2_0.progress = var_1.Find(var_2_8, "main/level/progress/bar")

	local var_2_9 = arg_2_0._tf

	arg_2_0.lastAwardItem = var_1.Find(var_2_9, "main/level/item")

	local var_2_10 = arg_2_0.lastAwardItem
	local var_2_11 = var_1.Find(var_2_10, "lock/Text")
	local var_2_12 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.lastAwardLvTxt = var_2_12(var_2_11, var_4(var_1_10006))
	setText = var_1

	local var_2_13 = arg_2_0.lastAwardItem
	local var_2_14 = var_3.Find(var_2_13, "get")

	i18n = var_4

	var_1(var_2_14, var_4("feast_task_pt_get"))

	setText = var_1

	local var_2_15 = arg_2_0.lastAwardItem
	local var_2_16 = var_3.Find(var_2_15, "got")

	i18n = var_4

	var_1(var_2_16, var_4("feast_task_pt_got"))

	setText = var_1

	local var_2_17 = arg_2_0._tf
	local var_2_18 = var_3.Find(var_2_17, "main/tip")

	i18n = var_4

	var_1(var_2_18, var_4("feast_click_to_close"))

	setText = var_1

	local var_2_19 = arg_2_0._tf
	local var_2_20 = var_3.Find(var_2_19, "main/level/value/label")

	i18n = var_4

	var_1(var_2_20, var_4("feast_task_pt_label"))

	local var_2_21 = arg_2_0._tf

	arg_2_0.taskTip = var_1.Find(var_2_21, "main/toggles/task/tip")

	local var_2_22 = {}
	local var_2_23 = arg_2_0._tf

	var_2_22[1] = var_2.Find(var_2_23, "main/toggles/pt")

	local var_2_24 = arg_2_0._tf

	var_2_22[2] = var_2.Find(var_2_24, "main/toggles/task")
	arg_2_0.toggles = var_2_22

	local var_2_25 = {}
	local var_2_26 = arg_2_0._tf
	local var_2_27 = var_2.Find(var_2_26, "main/pt/scrollrect")

	var_2_25[1] = var_2.GetComponent(var_2_27, "LScrollRect")

	local var_2_28 = arg_2_0._tf
	local var_2_29 = var_2.Find(var_2_28, "main/task/scrollrect")

	var_2_25[2] = var_2.GetComponent(var_2_29, "LScrollRect")
	arg_2_0.scrollRects = var_2_25

	local var_2_30 = {}

	FeastPtCard = var_2
	var_2_30[1] = var_2
	FeastTaskCard = var_2
	var_2_30[2] = var_2
	arg_2_0.cardCls = var_2_30
	arg_2_0.cards = {
		{},
		{}
	}
	arg_2_0.counts = {
		0,
		0
	}

	arg_2_0:AddListener()

	return
end

function var_0_1.AddListener(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.bind

	FeastScene = var_1_10004

	var_3_1(var_3_0, var_1_10004.ON_TASK_UPDATE, function(arg_4_0)
		local var_4_0 = arg_3_0

		if var_1.isShowing(var_4_0) then
			local var_4_1 = arg_3_0

			var_1.GenTaskData(var_4_1)

			local var_4_2 = arg_3_0

			var_1.UpdateLevel(var_4_2)

			if arg_3_0.page == var_0_1.PAGE_TASK then
				local var_4_3 = arg_3_0

				var_1.SwitchPage(var_4_3, arg_3_0.page)
			end
		end

		return
	end)

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.bind

	FeastScene = var_4

	var_3_3(var_3_2, var_4.ON_ACT_UPDATE, function(arg_5_0)
		local var_5_0 = arg_3_0

		if var_1.isShowing(var_5_0) then
			local var_5_1 = arg_3_0

			var_1.GenPtData(var_5_1)

			local var_5_2 = arg_3_0

			var_1.UpdateLevel(var_5_2)

			if arg_3_0.page == var_0_1.PAGE_PT then
				local var_5_3 = arg_3_0

				var_1.SwitchPage(var_5_3, arg_3_0.page)
			end
		end

		return
	end)

	return
end

function var_0_1.OnInit(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.scrollRects) do
		function iter_6_1.onInitItem(arg_7_0)
			local var_7_0 = arg_6_0

			var_1.OnInitItem(var_7_0, iter_6_0, arg_7_0)

			return
		end

		function iter_6_1.onUpdateItem(arg_8_0, arg_8_1)
			local var_8_0 = arg_6_0

			var_2.OnUpdateItem(var_8_0, iter_6_0, arg_8_0, arg_8_1)

			return
		end
	end

	ipairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0.toggles) do
		onToggle = var_1_10006

		local var_6_0 = arg_6_0
		local var_6_1 = iter_6_3

		local function var_6_2(arg_9_0)
			if arg_9_0 then
				local var_9_0 = arg_6_0

				var_1.SwitchPage(var_9_0, iter_6_2)
			end

			return
		end

		SFX_PANEL = var_1_10011

		var_1_10006(var_6_0, var_6_1, var_6_2, var_1_10011)
	end

	onButton = var_1

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0._tf

	local function var_6_5()
		local var_10_0 = arg_6_0

		var_0.Hide(var_10_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_3, var_6_4, var_6_5, var_1_10006)

	onButton = var_1

	local var_6_6 = arg_6_0
	local var_6_7 = arg_6_0.getAllBtn

	local function var_6_8()
		if arg_6_0.page == var_0_1.PAGE_TASK then
			local var_11_0 = arg_6_0

			var_0.GetAllForTask(var_11_0)
		elseif arg_6_0.page == var_0_1.PAGE_PT then
			local var_11_1 = arg_6_0

			var_0.GetAllForPt(var_11_1)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_6, var_6_7, var_6_8, var_1_10006)

	return
end

function var_0_1.UpdateGetAllTip(arg_12_0, arg_12_1)
	getProxy = var_1_10002
	FeastProxy = var_1_10004

	local var_12_0 = var_1_10002(var_1_10004)
	local var_12_1 = false

	if arg_12_1 == var_0_1.PAGE_PT then
		var_12_1 = var_12_0:ShouldTipPt()
	elseif arg_12_1 == var_0_1.PAGE_TASK then
		var_12_1 = var_12_0:ShouldTipFeastTask()
	end

	setActive = var_4

	var_4(arg_12_0.getAllTip, var_12_1)

	setActive = var_4

	var_4(arg_12_0.taskTip, var_12_0:ShouldTipFeastTask())

	return
end

function var_0_1.GetAllForTask(arg_13_0)
	local var_13_0 = {}

	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_13_1 = var_1_10002(var_1_10004)

	ipairs = var_1_10003

	for iter_13_0, iter_13_1 in var_1_10003(arg_13_0.taskList) do
		if var_13_1:getTaskById(iter_13_1) and var_8:isFinish() and not var_8:isReceive() then
			table = var_9

			var_9.insert(var_13_0, var_8)
		end
	end

	if #var_13_0 <= 0 then
		pg = var_3

		local var_13_2 = var_3.TipsMgr.GetInstance()
		local var_13_3 = var_3.ShowTips

		i18n = iter_13_0

		var_13_3(var_13_2, iter_13_0("faest_nothing_to_get"))

		return
	end

	local var_13_4 = arg_13_0
	local var_13_5 = arg_13_0.emit

	FeastMediator = iter_13_0

	var_13_5(var_13_4, iter_13_0.ON_SUBMIT_ONE_KEY, var_13_0)

	return
end

function var_0_1.GetAllForPt(arg_14_0)
	local var_14_0 = arg_14_0.ptActData

	if not var_1.CanGetAward(var_14_0) then
		pg = var_1

		local var_14_1 = var_1.TipsMgr.GetInstance()
		local var_14_2 = var_1.ShowTips

		i18n = var_1_10004

		var_14_2(var_14_1, var_1_10004("faest_nothing_to_get"))

		return
	end

	local var_14_3 = arg_14_0.ptActData
	local var_14_4 = var_1.GetCurrTarget(var_14_3)
	local var_14_5 = arg_14_0
	local var_14_6 = arg_14_0.emit

	FeastMediator = var_1_10005

	local var_14_7 = var_1_10005.EVENT_PT_OPERATION
	local var_14_8 = {
		cmd = 4
	}
	local var_14_9 = arg_14_0.ptActData

	var_14_8.activity_id = var_7.GetId(var_14_9)
	var_14_8.arg1 = var_14_4

	var_14_6(var_14_5, var_14_7, var_14_8)

	return
end

function var_0_1.SwitchPage(arg_15_0, arg_15_1)
	local var_15_0

	if not arg_15_0.counts[arg_15_1] then
		var_15_0 = 0
	end

	local var_15_1 = arg_15_0.scrollRects[arg_15_1]

	var_3.SetTotalCount(var_15_1, var_15_0)

	arg_15_0.page = arg_15_1

	arg_15_0:UpdateGetAllTip(arg_15_1)
	arg_15_0:UpdateLevel()

	return
end

function var_0_1.UpdateLevel(arg_16_0)
	local var_16_0 = arg_16_0.ptActData
	local var_16_1 = var_1.GetCurrLevel(var_16_0)

	arg_16_0.levelTxt.text = var_16_1

	local var_16_2 = 0
	local var_16_3 = 0
	local var_16_4 = arg_16_0.ptActData
	local var_16_6

	if not var_4.IsMaxLevel(var_16_4) then
		local var_16_5 = arg_16_0.ptActData

		var_16_6 = var_16_6.GetPtTarget(var_16_5, var_16_1)

		local var_16_7 = arg_16_0.ptActData.count
		local var_16_8 = arg_16_0.ptActData

		var_16_3 = var_6.GetNextLevelTarget(var_16_8)
		var_16_2 = var_16_7 - var_16_6
		var_16_3 = var_16_3 - var_16_6
		math = var_16_7
		var_16_2 = var_16_7.min(var_16_2, var_16_3)
		arg_16_0.progressTxt.text = var_16_2 .. "/" .. var_16_3
	else
		var_16_6 = 1
		var_16_3 = 1
		var_16_2 = var_16_6
		var_16_6 = arg_16_0.progressTxt
		var_16_6.text = "MAX"
	end

	setFillAmount = var_16_6

	var_16_6(arg_16_0.progress, var_16_2 / var_16_3)

	local var_16_9 = arg_16_0.page == var_0_1.PAGE_PT

	setActive = var_5

	var_5(arg_16_0.lastAwardItem, var_16_9)

	if var_16_9 then
		arg_16_0:UpdateLastAward()
	end

	return
end

function var_0_1.UpdateLastAward(arg_17_0)
	local var_17_0 = arg_17_0.lastAwardItem
	local var_17_1 = var_1.Find(var_17_0, "award")
	local var_17_2 = arg_17_0.ptActData
	local var_17_3 = var_2.GetLastAward(var_17_2)

	updateDrop = var_17_0

	var_17_0(var_17_1, var_17_3)

	local var_17_4 = arg_17_0.ptActData.targets
	local var_17_5 = arg_17_0.ptActData
	local var_17_6 = var_4.GetDroptItemState(var_17_5, #var_17_4)
	local var_17_7 = arg_17_0.lastAwardLvTxt

	i18n = var_17_5
	var_17_7.text = var_17_5("feast_task_pt_level", #var_17_4)
	setActive = var_17_7

	local var_17_8 = arg_17_0.lastAwardItem
	local var_17_9 = var_7.Find(var_17_8, "lock")

	ActivityPtData = var_8

	var_17_7(var_17_9, var_17_6 == var_8.STATE_LOCK)

	setActive = var_17_7

	local var_17_10 = arg_17_0.lastAwardItem
	local var_17_11 = var_7.Find(var_17_10, "get")

	ActivityPtData = var_8

	var_17_7(var_17_11, var_17_6 == var_8.STATE_CAN_GET)

	setActive = var_17_7

	local var_17_12 = arg_17_0.lastAwardItem
	local var_17_13 = var_7.Find(var_17_12, "got")

	ActivityPtData = var_8

	var_17_7(var_17_13, var_17_6 == var_8.STATE_GOT)

	onButton = var_17_7

	local var_17_14 = arg_17_0
	local var_17_15 = var_17_1

	local function var_17_16()
		local var_18_0 = var_17_6

		ActivityPtData = var_2_10001

		if var_18_0 == var_2_10001.STATE_CAN_GET then
			local var_18_1 = arg_17_0.ptActData
			local var_18_2 = var_0.GetPtTarget(var_18_1, #var_17_4)

			var_2_10003 = arg_17_0

			local var_18_3 = var_1.emit

			FeastMediator = var_2_10004

			local var_18_4 = var_2_10004.EVENT_PT_OPERATION
			local var_18_5 = {
				cmd = 1
			}
			local var_18_6 = arg_17_0.ptActData

			var_18_5.activity_id = var_6.GetId(var_18_6)
			var_18_5.arg1 = var_18_2

			var_18_3(var_2_10003, var_18_4, var_18_5)
		else
			local var_18_7 = arg_17_0
			local var_18_8 = var_0.emit

			BaseUI = var_2_10003

			var_18_8(var_18_7, var_2_10003.ON_DROP, var_17_3)
		end

		return
	end

	SFX_PANEL = var_10

	var_17_7(var_17_14, var_17_15, var_17_16, var_10)

	return
end

function var_0_1.Show(arg_19_0)
	var_0_1.super.Show(arg_19_0)

	pg = var_1

	local var_19_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_19_0, arg_19_0._tf)
	arg_19_0:GenPtData()
	arg_19_0:GenTaskData()

	triggerToggle = var_1

	var_1(arg_19_0.toggles[var_0_1.PAGE_PT], true)

	return
end

function var_0_1.GenPtData(arg_20_0)
	getProxy = var_1_10001
	FeastProxy = var_1_10003

	local var_20_0 = var_1_10001(var_1_10003)

	arg_20_0.ptActData = var_1.GetPtActData(var_20_0)
	arg_20_0.counts[var_0_1.PAGE_PT] = #arg_20_0.ptActData.targets

	return
end

function var_0_1.GenTaskData(arg_21_0)
	getProxy = var_1_10001
	FeastProxy = var_1_10003

	local var_21_0 = var_1_10001(var_1_10003)

	arg_21_0.taskList = var_1.GetTaskList(var_21_0)
	getProxy = var_1
	TaskProxy = var_21_0

	local var_21_1 = var_1(var_21_0)

	table = var_1_10002

	var_1_10002.sort(arg_21_0.taskList, function(arg_22_0, arg_22_1)
		local var_22_0 = var_21_1
		local var_22_2

		if not var_2.getTaskById(var_22_0, arg_22_0) then
			local var_22_1 = var_21_1

			var_22_2 = var_2.getFinishTaskById(var_22_1, arg_22_0)
		end

		local var_22_3 = var_21_1
		local var_22_5

		if not var_3.getTaskById(var_22_3, arg_22_1) then
			local var_22_4 = var_21_1

			var_22_5 = var_3.getFinishTaskById(var_22_4, arg_22_1)
		end

		if (var_22_2:isReceive() and 1 or 0) == (var_22_5:isReceive() and 1 or 0) then
			if (var_22_2:IsActRoutineType() and 1 or 0) == (var_22_5:IsActRoutineType() and 1 or 0) then
				return arg_22_0 < arg_22_1
			else
				return var_7 < var_6
			end
		else
			return var_4 < var_5
		end

		return
	end)

	arg_21_0.counts[var_0_1.PAGE_TASK] = #arg_21_0.taskList

	return
end

function var_0_1.OnInitItem(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.cardCls[arg_23_1].New(arg_23_2, arg_23_0)

	arg_23_0.cards[arg_23_1][arg_23_2] = var_23_0

	return
end

function var_0_1.OnUpdateItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0

	if not arg_24_0.cards[arg_24_1][arg_24_3] then
		arg_24_0:OnInitItem(arg_24_1, arg_24_3)

		var_24_0 = arg_24_0.cards[arg_24_1][arg_24_3]
	end

	local var_24_1

	if arg_24_1 == var_0_1.PAGE_PT then
		var_24_1 = arg_24_0.ptActData
	elseif arg_24_1 == var_0_1.PAGE_TASK then
		var_24_1 = arg_24_0.taskList[arg_24_2 + 1]
	end

	var_24_0:Flush(var_24_1, arg_24_2 + 1)

	return
end

function var_0_1.Hide(arg_25_0)
	var_0_1.super.Hide(arg_25_0)

	pg = var_1

	local var_25_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_25_0, arg_25_0._tf, arg_25_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_26_0)
	if arg_26_0:isShowing() then
		arg_26_0:Hide()
	end

	return
end

return var_0_1
