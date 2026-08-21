local var_0_0 = class("CrusingTaskLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "CrusingTaskUI"
end

function var_0_0.tempCache(arg_2_0)
	return true
end

function var_0_0.init(arg_3_0)
	arg_3_0.rtBg = arg_3_0._tf:Find("bg")

	local var_3_0 = arg_3_0._tf:Find("window")

	arg_3_0.itemQuick = var_3_0:Find("item_quick")
	arg_3_0.btnBack = var_3_0:Find("btn_back")
	arg_3_0.btnHelp = var_3_0:Find("btn_help")
	arg_3_0.textPhase = var_3_0:Find("text_phase")
	arg_3_0.sliderPt = var_3_0:Find("Slider")
	arg_3_0.textComplete = var_3_0:Find("text_complete")

	local var_3_1 = var_3_0:Find("view/content")

	arg_3_0.taskGroupItemList = UIItemList.New(var_3_1, var_3_1:Find("tpl"))

	arg_3_0.taskGroupItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			arg_3_0:updateTaskGroup(arg_4_2, arg_3_0.tempTaskGroup[arg_4_1])
		end

		return
	end)

	arg_3_0.rtWeekToggles = var_3_0:Find("week_list")

	return
end

function var_0_0.didEnter(arg_5_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_5_0._tf)
	onButton(arg_5_0, arg_5_0.rtBg, function()
		arg_5_0:emit(CrusingTaskMediator.ON_EXIT)
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.btnBack, function()
		arg_5_0:emit(CrusingTaskMediator.ON_EXIT)
		arg_5_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_5_0, arg_5_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("cruise_task_help_" .. pg.battlepass_event_pt[arg_5_0.activity.id].map_name)
		})

		return
	end, SFX_PANEL)

	local var_5_0 = getProxy(TaskProxy)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.taskGroupList) do
		local var_5_1 = arg_5_0.rtWeekToggles:Find(iter_5_0)

		if iter_5_0 > 0 then
			setText(var_5_1:Find("off/Text"), i18n("cruise_task_week", iter_5_0))
			setText(var_5_1:Find("on/Text"), i18n("cruise_task_week", iter_5_0))
		end

		setActive(var_5_1:Find("tip"), not iter_5_1.isLock and PlayerPrefs.GetInt(string.format("cursing_%d_task_week_%d", arg_5_0.activity.id, iter_5_0), 0) == 0)
		onToggle(arg_5_0, var_5_1, function(arg_9_0)
			if arg_9_0 then
				setActive(var_5_1:Find("tip"), false)
				PlayerPrefs.SetInt(string.format("cursing_%d_task_week_%d", arg_5_0.activity.id, iter_5_0), 1)

				arg_5_0.weekToggle = iter_5_0
				arg_5_0.contextData.weekToggle = iter_5_0
				arg_5_0.tempTaskGroup = underscore.map(iter_5_1.task_group, function(arg_10_0)
					return underscore.map(arg_10_0, function(arg_11_0)
						assert(var_5_0:getTaskVO(arg_11_0), "without this task:" .. arg_11_0)

						return var_5_0:getTaskVO(arg_11_0)
					end)
				end)

				table.sort(arg_5_0.tempTaskGroup, CompareFuncs({
					function(arg_12_0)
						return underscore.all(arg_12_0, function(arg_13_0)
							return arg_13_0:isReceive()
						end) and 1 or 0
					end,
					function(arg_14_0)
						return arg_14_0[1].id
					end
				}))
				arg_5_0.taskGroupItemList:align(#arg_5_0.tempTaskGroup)
				arg_5_0:updateTaskInfo()
			end

			return
		end, SFX_PANEL)

		if var_5_1:Find("mask") then
			setActive(var_5_1:Find("mask"), iter_5_1.isLock)
		end
	end

	local var_5_2 = underscore.keys(arg_5_0.taskGroupList)

	table.sort(var_5_2, function(arg_15_0, arg_15_1)
		return arg_15_0 < arg_15_1
	end)

	if arg_5_0.contextData.weekToggle and not arg_5_0.taskGroupList[arg_5_0.contextData.weekToggle].isLock then
		arg_5_0.weekToggle = arg_5_0.contextData.weekToggle
		arg_5_0.contextData.weekToggle = nil
	else
		arg_5_0.weekToggle = table.remove(var_5_2, 1)

		for iter_5_2, iter_5_3 in ipairs(var_5_2) do
			if arg_5_0.taskGroupList[iter_5_3].isLock then
				break
			elseif underscore.any(underscore.flatten(arg_5_0.taskGroupList[iter_5_3].task_group), function(arg_16_0)
				local var_16_0 = var_5_0:getTaskVO(arg_16_0)

				return var_16_0 and not var_16_0:isReceive()
			end) then
				arg_5_0.weekToggle = iter_5_3

				break
			end
		end
	end

	triggerToggle(arg_5_0.rtWeekToggles:Find(arg_5_0.weekToggle), true)

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.taskGroupList) do
		local var_5_3 = arg_5_0.rtWeekToggles:Find(iter_5_4)

		SetCompomentEnabled(var_5_3, typeof(Toggle), not iter_5_5.isLock)

		if not iter_5_5.isLock then
			setGray(var_5_3, underscore.all(underscore.flatten(iter_5_5.task_group), function(arg_17_0)
				local var_17_0 = var_5_0:getTaskVO(arg_17_0)

				return var_17_0 and var_17_0:isReceive()
			end))
		end
	end

	arg_5_0:updatePhaseInfo()
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_VITEM,
		id = arg_5_0.ptId
	}):getIcon(), "", arg_5_0.sliderPt:Find("icon"), true)
	onButton(arg_5_0, arg_5_0.itemQuick, function()
		arg_5_0:emit(var_0_0.ON_DROP, {
			count = 1,
			type = DROP_TYPE_ITEM,
			id = Item.QUICK_TASK_PASS_TICKET_ID
		})

		return
	end, SFX_PANEL)
	LoadImageSpriteAtlasAsync(Drop.New({
		type = DROP_TYPE_ITEM,
		id = Item.QUICK_TASK_PASS_TICKET_ID
	}):getIcon(), "", arg_5_0.itemQuick:Find("icon"), true)
	onButton(arg_5_0, arg_5_0.itemQuick:Find("plus"), function()
		shoppingBatch(61017, {
			id = Item.QUICK_TASK_PASS_TICKET_ID
		}, 20, "build_ship_quickly_buy_stone")

		return
	end)
	arg_5_0:updateItemInfo()
	setText(arg_5_0.textComplete:Find("Text"), i18n("cruise_task_tips"))

	return
end

function var_0_0.willExit(arg_20_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_20_0._tf)

	return
end

function var_0_0.setActivity(arg_21_0, arg_21_1)
	arg_21_0.activity = arg_21_1

	for iter_21_0, iter_21_1 in pairs(arg_21_1:GetCrusingInfo()) do
		arg_21_0[iter_21_0] = iter_21_1
	end

	arg_21_0.taskGroupList = {}

	local var_21_0 = pg.TimeMgr.GetInstance():GetServerOverWeek(arg_21_1:getStartTime())

	for iter_21_2, iter_21_3 in ipairs(arg_21_1:getConfig("config_data")) do
		arg_21_0.taskGroupList[pg.battlepass_task_group[iter_21_3].group_mask] = {
			task_group = pg.battlepass_task_group[iter_21_3].task_group,
			isLock = var_21_0 < pg.battlepass_task_group[iter_21_3].group_mask
		}
	end

	return
end

function var_0_0.updatePhaseInfo(arg_22_0)
	setText(arg_22_0.textPhase, i18n("cruise_task_phase", arg_22_0.phase))

	if arg_22_0.phase < #arg_22_0.awardList then
		local var_22_0 = arg_22_0.pt - (arg_22_0.phase == 0 and 0 or arg_22_0.awardList[arg_22_0.phase].pt)

		setSlider(arg_22_0.sliderPt, 0, arg_22_0.awardList[arg_22_0.phase + 1].pt - (arg_22_0.phase == 0 and 0 or arg_22_0.awardList[arg_22_0.phase].pt), arg_22_0.pt - (arg_22_0.phase == 0 and 0 or arg_22_0.awardList[arg_22_0.phase].pt))
		setText(arg_22_0.sliderPt:Find("Text"), var_22_0 .. "/" .. arg_22_0.awardList[arg_22_0.phase + 1].pt - (arg_22_0.phase == 0 and 0 or arg_22_0.awardList[arg_22_0.phase].pt))
	else
		setSlider(arg_22_0.sliderPt, 0, 1, 1)
		setText(arg_22_0.sliderPt:Find("Text"), "MAX")
	end

	return
end

function var_0_0.updateTaskInfo(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = 0

	underscore.each(arg_23_0.tempTaskGroup, function(arg_24_0)
		underscore.each(arg_24_0, function(arg_25_0)
			var_23_1 = var_23_1 + 1

			if arg_25_0:isReceive() then
				var_23_0 = var_23_0 + 1
			end

			return
		end)

		return
	end)
	setText(arg_23_0.textComplete, 0 .. "/" .. 0)

	return
end

function var_0_0.updateItemInfo(arg_26_0)
	setText(arg_26_0.itemQuick, getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID))

	return
end

function var_0_0.updateTaskGroup(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1:Find("info")

	LoadImageSpriteAtlasAsync("ui/crusingtaskui_atlas", tostring(arg_27_0.weekToggle), var_27_0:Find("week"), true)

	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_2) do
		if not iter_27_1:isReceive() then
			table.insert(var_27_1, iter_27_1)
		end
	end

	triggerToggle(var_27_0, false)

	local var_27_2 = #var_27_1 > 0 and table.remove(var_27_1, 1) or arg_27_2[#arg_27_2]

	SetCompomentEnabled(var_27_0, typeof(Toggle), #var_27_1 > 0)
	arg_27_0:updateTaskDisplay(var_27_0, var_27_2)
	setActive(var_27_0:Find("quick"), var_27_2:getConfig("quick_finish") > 0 and var_27_2:getTaskStatus() == 0)
	onButton(arg_27_0, var_27_0:Find("quick"), function()
		local var_28_0 = getProxy(BagProxy):getItemCountById(Item.QUICK_TASK_PASS_TICKET_ID)
		local var_28_1 = var_27_2:getConfig("quick_finish")

		if var_28_0 < var_28_1 then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("battlepass_task_quickfinish2", var_28_1 - var_28_0),
				onYes = function()
					shoppingBatch(61017, {
						id = Item.QUICK_TASK_PASS_TICKET_ID
					}, 20, "build_ship_quickly_buy_stone")

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("battlepass_task_quickfinish1", var_28_1, var_28_0),
				onYes = function()
					arg_27_0:emit(CrusingTaskMediator.ON_TASK_QUICK_SUBMIT, var_27_2)

					return
				end
			})
		end

		return
	end, SFX_CONFIRM)
	setActive(var_27_0:Find("toggle_mark"), #var_27_1 > 0)

	if #var_27_1 > 0 then
		local var_27_3 = arg_27_1:Find("content")
		local var_27_4 = UIItemList.New(var_27_3, var_27_3:Find("extend_tpl"))

		var_27_4:make(function(arg_31_0, arg_31_1, arg_31_2)
			arg_31_1 = arg_31_1 + 1

			if arg_31_0 == UIItemList.EventUpdate then
				arg_27_0:updateTaskDisplay(arg_31_2, var_27_1[arg_31_1])
			end

			return
		end)
		var_27_4:align(#var_27_1)
	end

	return
end

function var_0_0.updateTaskDisplay(arg_32_0, arg_32_1, arg_32_2)
	setText(arg_32_1:Find("desc"), arg_32_2:getConfig("desc"))

	local var_32_0 = arg_32_2:getProgress()
	local var_32_1 = arg_32_2:getConfig("target_num")

	setSlider(arg_32_1:Find("Slider"), 0, var_32_1, var_32_0)
	setText(arg_32_1:Find("Slider/Text"), var_32_0 .. "/" .. var_32_1)

	local var_32_2 = arg_32_2:getConfig("award_display")[1]

	updateDrop(arg_32_1:Find("IconTpl"), {
		type = var_32_2[1],
		id = var_32_2[2],
		count = var_32_2[3]
	})
	onButton(arg_32_0, arg_32_1:Find("IconTpl"), function()
		arg_32_0:emit(var_0_0.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_32_3 = arg_32_2:getTaskStatus()

	setActive(arg_32_1:Find("go"), var_32_3 == 0)
	setActive(arg_32_1:Find("get"), var_32_3 == 1)
	setActive(arg_32_1:Find("got"), var_32_3 == 2)
	setActive(arg_32_1:Find("IconTpl/mask"), var_32_3 == 2)
	setActive(arg_32_1:Find("IconTpl/mark"), var_32_3 == 2)
	onButton(arg_32_0, arg_32_1:Find("go"), function()
		arg_32_0:emit(CrusingTaskMediator.ON_TASK_GO, arg_32_2)

		return
	end, SFX_PANEL)
	onButton(arg_32_0, arg_32_1:Find("get"), function()
		arg_32_0:emit(CrusingTaskMediator.ON_TASK_SUBMIT, arg_32_2)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.updateCurrentTaskGroup(arg_36_0)
	triggerToggle(arg_36_0.rtWeekToggles:Find(arg_36_0.weekToggle), true)

	return
end

return var_0_0
