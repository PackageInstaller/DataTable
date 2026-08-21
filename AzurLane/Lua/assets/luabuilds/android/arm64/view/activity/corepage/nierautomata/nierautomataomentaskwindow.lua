local var_0_0 = class("NieRAutomataOmenTaskWindow", import("view.base.BaseSubView"))

var_0_0.SKIP_TYPE_SCENE = 2
var_0_0.SKIP_TYPE_ACTIVITY = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_0.getUIName(arg_2_0)
	return "NieRAutomataOmenTaskWindow"
end

function var_0_0.OnLoaded(arg_3_0)
	arg_3_0.bg = arg_3_0._tf:Find("bg")
	arg_3_0.btnClose = arg_3_0._tf:Find("window/btnClose")

	onButton(arg_3_0, arg_3_0.btnClose, function()
		arg_3_0:Hide()

		return
	end, SOUND_BACK)
	onButton(arg_3_0, arg_3_0.bg, function()
		arg_3_0:Hide()

		return
	end, SOUND_BACK)

	return
end

function var_0_0.OnInit(arg_6_0)
	arg_6_0.page = findTF(arg_6_0._tf, "window")
	arg_6_0.list = findTF(arg_6_0.page, "list/Viewport/Content")
	arg_6_0.list_tpl = findTF(arg_6_0.page, "list_tpl")

	setActive(arg_6_0.list_tpl, false)

	arg_6_0.uilist = UIItemList.New(arg_6_0.list, arg_6_0.list_tpl)

	arg_6_0.uilist:make(function(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_0 == UIItemList.EventUpdate then
			arg_6_0:UpdateListItem(arg_7_1, arg_7_2)
		end

		return
	end)

	arg_6_0.year, arg_6_0.month, arg_6_0.day = ChineseCalendar.GetCurrYearMonthDay((pg.TimeMgr.GetInstance():GetServerTime()))

	return
end

function var_0_0.Show(arg_8_0, arg_8_1)
	var_0_0.super.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf, {
		staticBlur = true
	})

	arg_8_0.activity = arg_8_1
	arg_8_0.nday = arg_8_0.activity:getNDay()
	arg_8_0.taskProxy = getProxy(TaskProxy)
	arg_8_0.taskGroup = arg_8_0.activity:getConfig("config_client").unlock_task

	arg_8_0.uilist:align(#arg_8_0.taskGroup)

	return
end

function var_0_0.UpdateListItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = findTF(arg_9_2, "default")
	local var_9_1 = findTF(var_9_0, "tasks")
	local var_9_2 = findTF(arg_9_2, "lock")
	local var_9_3 = findTF(var_9_2, "desc_bg/desc")
	local var_9_4 = arg_9_1 + 1

	setText(findTF(var_9_0, "day/dayText"), "DAY " .. arg_9_1 + 1)

	for iter_9_0 = 0, var_9_1.childCount - 1 do
		arg_9_0:UpdateTaskItem(arg_9_1 + 1, iter_9_0, (var_9_1:GetChild(iter_9_0)))
	end

	local var_9_5 = arg_9_0:isTaskLock(arg_9_1 + 1)

	setActive(var_9_2, var_9_5 ~= 0)
	switch(var_9_5, {
		function()
			local var_10_0, var_10_1 = arg_9_0:getDate(arg_9_0.month, arg_9_0.day + var_9_4 - arg_9_0.nday)

			setText(var_9_3, i18n("OutPostOmenPage_task_tip1", var_10_0, var_10_1))

			return
		end,
		function()
			setText(var_9_3, i18n("OutPostOmenPage_task_tip2"))

			return
		end
	})

	return
end

function var_0_0.UpdateTaskItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_3:Find("item")
	local var_12_1 = arg_12_0.taskProxy:getTaskById(arg_12_0.taskGroup[arg_12_1][arg_12_2 + 1]) or arg_12_0.taskProxy:getFinishTaskById(arg_12_0.taskGroup[arg_12_1][arg_12_2 + 1])
	local var_12_2 = pg.task_data_template[arg_12_0.taskGroup[arg_12_1][arg_12_2 + 1]]

	updateDrop(var_12_0, (Drop.Create(pg.task_data_template[arg_12_0.taskGroup[arg_12_1][arg_12_2 + 1]].award_display[1])))
	onButton(arg_12_0, var_12_0, function()
		arg_12_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_12_3 = var_12_1 and var_12_1:getProgress() or 0
	local var_12_4 = var_12_2.target_num
	local var_12_5 = var_12_1 and var_12_1:getTaskStatus() == 2
	local var_12_6 = var_12_2.desc

	if utf8.len(var_12_2.desc) >= 17 then
		setScrollText(arg_12_3:Find("mask/description"), var_12_6)
	else
		setText(arg_12_3:Find("mask/description"), var_12_6)
	end

	setSlider(arg_12_3:Find("progress"), 0, var_12_4, var_12_3)
	setText(arg_12_3:Find("progressText"), var_12_3 .. "<color=#52514a>/" .. var_12_4 .. "</color>")
	setActive(arg_12_3:Find("progressText"), not var_12_5)
	setActive(arg_12_3:Find("mask_got"), var_12_5)
	setText(arg_12_3:Find("mask_got/Text"), i18n("nier_a2_item_got"))

	return
end

function var_0_0.getDate(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = pg.TimeMgr.GetInstance():CalcMonthDays(arg_14_0.year, arg_14_1)

	if var_14_0 < arg_14_2 then
		arg_14_2 = arg_14_2 - var_14_0
		arg_14_1 = arg_14_1 + 1

		if arg_14_1 > 12 then
			arg_14_1 = 1
			arg_14_0.year = arg_14_0.year + 1
		end
	end

	return arg_14_1, arg_14_2
end

function var_0_0.isTaskLock(arg_15_0, arg_15_1)
	if arg_15_1 > arg_15_0.nday then
		return 1
	end

	for iter_15_0 = 1, arg_15_1 - 1 do
		for iter_15_1, iter_15_2 in ipairs(arg_15_0.taskGroup[iter_15_0]) do
			local var_15_0 = arg_15_0.taskProxy:getTaskById(iter_15_2) or arg_15_0.taskProxy:getFinishTaskById(iter_15_2)

			if not var_15_0 or var_15_0:getTaskStatus() ~= 2 then
				return 2
			end
		end
	end

	return 0
end

function var_0_0.Hide(arg_16_0)
	if arg_16_0:isShowing() then
		var_0_0.super.Hide(arg_16_0)
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf, arg_16_0._parentTf)
	end

	return
end

return var_0_0
