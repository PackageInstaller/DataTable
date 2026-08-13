class = var_0_10000

local var_0_0 = "OutPostOmenTaskWindow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.SKIP_TYPE_SCENE = 2
var_0_1.SKIP_TYPE_ACTIVITY = 3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_1.getUIName(arg_2_0)
	return "OutPostOmenTaskWindow"
end

function var_0_1.OnLoaded(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.bg = var_1.Find(var_3_0, "bg")

	local var_3_1 = arg_3_0._tf

	arg_3_0.btnClose = var_1.Find(var_3_1, "window/btnClose")
	onButton = var_1

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.btnClose

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_3_2, var_3_3, var_3_4, var_1_10005)

	onButton = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.bg

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1(var_3_5, var_3_6, var_3_7, var_1_10005)

	return
end

function var_0_1.OnInit(arg_6_0)
	findTF = var_1_10001
	arg_6_0.page = var_1_10001(arg_6_0._tf, "window")
	findTF = var_1
	arg_6_0.list = var_1(arg_6_0.page, "list/Viewport/Content")
	findTF = var_1
	arg_6_0.list_tpl = var_1(arg_6_0.page, "list_tpl")
	UIItemList = var_1
	arg_6_0.uilist = var_1.New(arg_6_0.list, arg_6_0.list_tpl)

	local var_6_0 = arg_6_0.uilist

	var_1.make(var_6_0, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			local var_7_0 = arg_6_0

			var_3.UpdateListItem(var_7_0, arg_7_1, arg_7_2)
		end

		return
	end)

	pg = var_1

	local var_6_1 = var_1.TimeMgr.GetInstance()
	local var_6_2 = var_1.GetServerTime(var_6_1)

	ChineseCalendar = var_6_1
	arg_6_0.year, arg_6_0.month, arg_6_0.day = var_6_1.GetCurrYearMonthDay(var_6_2)

	return
end

function var_0_1.Show(arg_8_0, arg_8_1)
	var_0_1.super.Show(arg_8_0)

	pg = var_2

	local var_8_0 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_8_0, arg_8_0._tf, {
		staticBlur = true
	})

	arg_8_0.activity = arg_8_1

	local var_8_1 = arg_8_0.activity

	arg_8_0.nday = var_2.getNDay(var_8_1)
	getProxy = var_2
	TaskProxy = var_8_1
	arg_8_0.taskProxy = var_2(var_8_1)

	local var_8_2 = arg_8_0.activity

	arg_8_0.taskGroup = var_2.getConfig(var_8_2, "config_client").unlock_task

	local var_8_3 = arg_8_0.uilist

	var_2.align(var_8_3, #arg_8_0.taskGroup)

	return
end

function var_0_1.UpdateListItem(arg_9_0, arg_9_1, arg_9_2)
	findTF = var_1_10003

	local var_9_0 = var_1_10003(arg_9_2, "default")

	findTF = var_4

	local var_9_1 = var_4(var_9_0, "day")

	findTF = var_5

	local var_9_2 = var_5(var_9_0, "tasks")

	findTF = var_6

	local var_9_3 = var_6(arg_9_2, "lock")

	findTF = var_7

	local var_9_4 = var_7(var_9_3, "desc")
	local var_9_5 = arg_9_1 + 1

	setText = var_9

	var_9(var_9_1, "DAY " .. var_9_5)

	for iter_9_0 = 0, var_9_2.childCount - 1 do
		var_1_10014 = var_9_2

		local var_9_6 = var_9_2.GetChild(var_1_10014, iter_9_0)

		arg_9_0:UpdateTaskItem(var_9_5, iter_9_0, var_9_6)
	end

	local var_9_7 = arg_9_0:isTaskLock(var_9_5) ~= 0

	setActive = var_11

	var_11(var_9_3, var_9_7)

	GetOrAddComponent = var_11

	local var_9_8 = var_9_0

	typeof = var_13
	CanvasGroup = var_1_10014

	local var_9_9 = var_11(var_9_8, var_13(var_1_10014))

	var_9_9.alpha = var_9_7 and 0.5 or 1
	switch = var_9_9

	var_9_9(var_9, {
		function()
			local var_10_0 = arg_9_0
			local var_10_1, var_10_2 = var_0.getDate(var_10_0, arg_9_0.month, arg_9_0.day + var_9_5 - arg_9_0.nday)

			setText = var_2

			local var_10_3 = var_9_4

			i18n = var_4

			var_2(var_10_3, var_4("OutPostOmenPage_task_tip1", var_10_1, var_10_2))

			return
		end,
		function()
			setText = var_2_10000

			local var_11_0 = var_9_4

			i18n = var_2_10002

			var_2_10000(var_11_0, var_2_10002("OutPostOmenPage_task_tip2"))

			return
		end
	})

	return
end

function var_0_1.UpdateTaskItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_2 + 1
	local var_12_1 = arg_12_3:Find("item")
	local var_12_2 = arg_12_0.taskGroup[arg_12_1][var_12_0]
	local var_12_3 = arg_12_0.taskProxy
	local var_12_4

	if not var_7.getTaskById(var_12_3, var_12_2) then
		var_12_3 = arg_12_0.taskProxy
		var_12_4 = var_7.getFinishTaskById(var_12_3, var_12_2)
	end

	pg = var_12_3

	local var_12_5 = var_12_3.task_data_template[var_12_2]

	Drop = var_9

	local var_12_6 = var_9.Create(var_12_5.award_display[1])

	updateDrop = var_10

	var_10(var_12_1, var_12_6)

	onButton = var_10

	local var_12_7 = arg_12_0
	local var_12_8 = var_12_1

	local function var_12_9()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10002

		var_13_1(var_13_0, var_2_10002.ON_DROP, var_12_6)

		return
	end

	SFX_PANEL = var_1_10014

	var_10(var_12_7, var_12_8, var_12_9, var_1_10014)

	local var_12_10

	if not var_12_4 or not var_12_4:getProgress() then
		var_12_10 = 0
	end

	local var_12_11 = var_12_5.target_num

	setText = var_12_8

	var_12_8(arg_12_3:Find("description"), var_12_5.desc)

	setSlider = var_12_8

	var_12_8(arg_12_3:Find("progress"), 0, var_12_11, var_12_10)

	setText = var_12_8

	var_12_8(arg_12_3:Find("progressText"), var_12_10 .. "/" .. var_12_11)

	return
end

function var_0_1.getDate(arg_14_0, arg_14_1, arg_14_2)
	pg = var_1_10003

	local var_14_0 = var_1_10003.TimeMgr.GetInstance()

	if var_3.CalcMonthDays(var_14_0, arg_14_0.year, arg_14_1) < arg_14_2 then
		arg_14_2 = arg_14_2 - var_3

		if arg_14_1 + 1 > 12 then
			arg_14_1 = 1
			arg_14_0.year = arg_14_0.year + 1
		end
	end

	return arg_14_1, arg_14_2
end

function var_0_1.GetProgressColor(arg_15_0)
	return nil
end

function var_0_1.isTaskLock(arg_16_0, arg_16_1)
	if arg_16_1 > arg_16_0.nday then
		return 1
	end

	for iter_16_0 = 1, arg_16_1 - 1 do
		local var_16_0 = arg_16_0.taskGroup[iter_16_0]

		ipairs = var_1_10007

		for iter_16_1, iter_16_2 in var_1_10007(var_16_0) do
			local var_16_1 = arg_16_0.taskProxy
			local var_16_3

			if not var_12.getTaskById(var_16_1, iter_16_2) then
				local var_16_2 = arg_16_0.taskProxy

				var_16_3 = var_12.getFinishTaskById(var_16_2, iter_16_2)
			end

			if var_16_3:getTaskStatus() ~= 2 then
				return 2
			end
		end
	end

	return 0
end

function var_0_1.Hide(arg_17_0)
	if arg_17_0:isShowing() then
		var_0_1.super.Hide(arg_17_0)

		pg = var_1

		local var_17_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_17_0, arg_17_0._tf, arg_17_0._parentTf)
	end

	return
end

return var_0_1
