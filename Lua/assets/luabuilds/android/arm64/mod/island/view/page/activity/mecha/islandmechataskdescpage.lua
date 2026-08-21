local var_0_0 = class("IslandMechaTaskDescPage", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "IslandMechaTaskDescPage"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.uiItemList = UIItemList.New(arg_2_0._tf:Find("list/content"), arg_2_0._tf:Find("list/content/tpl"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("close"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.startTime = arg_6_1
	arg_6_0.nday = arg_6_2
	arg_6_0.taskGroup = arg_6_3

	arg_6_0:UpdateList()
	var_0_0.super.Show(arg_6_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_6_0._tf)

	return
end

function var_0_0.Hide(arg_7_0)
	var_0_0.super.Hide(arg_7_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_7_0._tf, arg_7_0._parentTf)

	return
end

function var_0_0.UpdateList(arg_8_0)
	arg_8_0.uiItemList:make(function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_8_0.taskGroup[arg_9_1 + 1] or {}

		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			arg_8_0:UpdateTask(arg_9_1 + 1, iter_9_1, arg_9_2:Find("tpl_" .. iter_9_0))
		end

		local var_9_2 = arg_9_2:Find("day")

		if arg_9_1 + 1 < 10 then
			local var_9_3 = "0" .. arg_9_1 + 1 or arg_9_1 + 1

			var_9_1(var_9_2, var_9_3)

			return
		end
	end)
	arg_8_0.uiItemList:align(#arg_8_0.taskGroup)

	return
end

function var_0_0.GetDayDesc(arg_10_0, arg_10_1)
	local var_10_0 = string.split(pg.TimeMgr.GetInstance():STimeDescS(arg_10_0.startTime + arg_10_1 * 0, "%Y/%m/%d/%H/%M/%S"), "/")

	return var_10_0[2], var_10_0[3]
end

function var_0_0.UpdateTask(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_3 then
		return
	end

	local var_11_0 = IslandTask.New({
		id = arg_11_2,
		process_list = {}
	})

	setText(arg_11_3:Find("Text"), var_11_0:getConfig("task_desc"))

	local var_11_1, var_11_2, var_11_3 = IslandTaskActhelper.GetIslandTaskState(arg_11_2)

	setText(arg_11_3:Find("progress_1/Text"), var_11_1 .. "/" .. var_11_2)
	setFillAmount(arg_11_3:Find("progress_1/bar"), var_11_1 / var_11_2)
	setActive(arg_11_3:Find("lock"), arg_11_1 > arg_11_0.nday)

	local var_11_4 = arg_11_3:Find("InventoryTpl_1")

	updateCustomDrop(var_11_4, var_11_0:GetAwards()[1])
	onButton(arg_11_0, var_11_4, function()
		arg_11_0:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_0
		})

		return
	end, SFX_PANEL)

	local var_11_5, var_11_6 = arg_11_0:GetDayDesc(arg_11_1 - 1)

	setText(arg_11_3:Find("lock/Text"), i18n("island_mecha_task_lock_tip", var_11_5, var_11_6))
	setActive(arg_11_3.parent:Find("finish"), var_11_3 == 2)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	if arg_13_0:isShowing() then
		arg_13_0:Hide()
	end

	return
end

return var_0_0
