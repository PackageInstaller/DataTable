class = var_0_10000

local var_0_0 = "StarsCityOmenTaskWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.SKIP_TYPE_SCENE = 2
var_0_1.SKIP_TYPE_ACTIVITY = 3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_1.getUIName(arg_2_0)
	return "StarsCityOmenTaskWindow"
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

	SOUND_BACK = var_1_10006

	var_1(var_3_2, var_3_3, var_3_4, var_1_10006)

	onButton = var_1

	local var_3_5 = arg_3_0
	local var_3_6 = arg_3_0.bg

	local function var_3_7()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_3_5, var_3_6, var_3_7, var_1_10006)

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

	ChineseCalendar = var_1_10002
	arg_6_0.year, arg_6_0.month, arg_6_0.day = var_1_10002.GetCurrYearMonthDay(var_6_2)

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

	findTF = var_1_10004

	local var_9_1 = var_1_10004(var_9_0, "day")

	findTF = var_5

	local var_9_2 = var_5(var_9_0, "tasks")

	findTF = var_6

	local var_9_3 = var_6(arg_9_2, "lock")

	findTF = var_7

	local var_9_4 = var_7(var_9_3, "desc")

	findTF = var_8

	local var_9_5 = var_8(var_9_3, "lockText1")

	findTF = var_9

	local var_9_6 = var_9(var_9_3, "lockText2")
	local var_9_7 = arg_9_1 + 1

	setText = var_11

	var_11(var_9_1, "DAY " .. var_9_7)

	for iter_9_0 = 0, var_9_2.childCount - 1 do
		local var_9_8 = var_9_2:GetChild(iter_9_0)

		var_1_10018 = arg_9_0

		arg_9_0.UpdateTaskItem(var_1_10018, var_9_7, iter_9_0, var_9_8)
	end

	local var_9_9 = arg_9_0
	local var_9_10 = arg_9_0.isTaskLock(var_9_9, var_9_7) ~= 0

	setActive = var_9_9

	var_9_9(var_9_3, var_9_10)

	GetOrAddComponent = var_9_9

	local var_9_11 = var_9_0

	typeof = var_16
	CanvasGroup = var_1_10018

	local var_9_12 = var_9_9(var_9_11, var_16(var_1_10018))

	var_9_12.alpha = var_9_10 and 0.5 or 1
	switch = var_9_12

	var_9_12(var_11, {
		function()
			local var_10_0 = arg_9_0
			local var_10_1, var_10_2 = var_0.getDate(var_10_0, arg_9_0.month, arg_9_0.day + var_9_7 - arg_9_0.nday)

			setText = var_10_0

			local var_10_3 = var_9_5
			local var_10_4 = var_4.Find(var_10_3, "Text")

			i18n = var_5

			var_10_0(var_10_4, var_5("OutPostOmenPage_task_tip1", var_10_1, var_10_2))

			setText = var_10_0

			local var_10_5 = var_9_6
			local var_10_6 = var_4.Find(var_10_5, "Text")

			i18n = var_5

			var_10_0(var_10_6, var_5("OutPostOmenPage_task_tip1", var_10_1, var_10_2))

			setActive = var_10_0

			var_10_0(var_9_4, false)

			setActive = var_10_0

			var_10_0(var_9_5, true)

			setActive = var_10_0

			var_10_0(var_9_6, true)

			return
		end,
		function()
			setText = var_2_10000

			local var_11_0 = var_9_4

			i18n = var_2_10003

			var_2_10000(var_11_0, var_2_10003("OutPostOmenPage_task_tip2"))

			setActive = var_2_10000

			var_2_10000(var_9_4, true)

			setActive = var_2_10000

			var_2_10000(var_9_5, false)

			setActive = var_2_10000

			var_2_10000(var_9_6, false)

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
	local var_12_5

	if not var_7.getTaskById(var_12_3, var_12_2) then
		local var_12_4 = arg_12_0.taskProxy

		var_12_5 = var_7.getFinishTaskById(var_12_4, var_12_2)
	end

	pg = var_8

	local var_12_6 = var_8.task_data_template[var_12_2]
	local var_12_7 = arg_12_3
	local var_12_8 = arg_12_3.Find(var_12_7, "got_mask")

	Drop = var_10

	local var_12_9 = var_10.Create(var_12_6.award_display[1])

	updateDrop = var_12_7

	var_12_7(var_12_1, var_12_9)

	onButton = var_12_7

	local var_12_10 = arg_12_0
	local var_12_11 = var_12_1

	local function var_12_12()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_9)

		return
	end

	SFX_PANEL = var_1_10016

	var_12_7(var_12_10, var_12_11, var_12_12, var_1_10016)

	if var_12_5 then
		var_12_10 = var_12_5

		local var_12_13

		if not var_12_5.getProgress(var_12_10) then
			var_12_13 = 0
		end

		local var_12_14 = var_12_6.target_num

		setText = var_12_10

		var_12_10(arg_12_3:Find("description"), var_12_6.desc)

		setSlider = var_12_10

		var_12_10(arg_12_3:Find("progress"), 0, var_12_14, var_12_13)

		local var_12_15 = arg_12_0
		local var_12_16, var_12_17 = arg_12_0.GetProgressColor(var_12_15)

		setColorStr = var_12_15

		local var_12_18 = var_12_15(var_12_13, var_12_16)

		setColorStr = var_16

		local var_12_19 = var_16("/" .. var_12_14, var_12_17)

		setText = var_17

		var_17(arg_12_3:Find("progressText"), var_12_18 .. var_12_19)

		if var_12_5:getTaskStatus() == 2 then
			setActive = var_17

			var_17(var_12_8, true)
		end

		return
	end
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
	return "#FFFFFF", "#C3C3C3"
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
