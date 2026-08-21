local var_0_0 = class("IslandMechaTaskPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.item = arg_1_0._tf:Find("bg/tasks/task")
	arg_1_0.items = arg_1_0._tf:Find("bg/tasks")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.timeTxt = arg_1_0._tf:Find("bg/time/Text"):GetComponent(typeof(Text))
	arg_1_0.descTxt = arg_1_0._tf:Find("bg/desc"):GetComponent(typeof(Text))
	arg_1_0.progressTxt = arg_1_0._tf:Find("bg/progress"):GetComponent(typeof(Text))
	arg_1_0.lookAllBtn = arg_1_0._tf:Find("bg/look_all")
	arg_1_0.preViewBtn = arg_1_0._tf:Find("bg/preview")

	setText(arg_1_0._tf:Find("bg/preview/Text"), i18n("island_mecha_task_preview"))
	setText(arg_1_0._tf:Find("bg/look_all/Text"), i18n("island_mecha_task_look_all"))

	arg_1_0.descPage = IslandMechaTaskDescPage.New(pg.UIMgr.GetInstance().OverlayMain, arg_1_0.event)

	onButton(arg_1_0, arg_1_0.preViewBtn, function()
		pg.m02:sendNotification(IslandMediator.OPEN_MACHA_MODEL_PREVIEW)

		return
	end, SFX_PANEL)
	onButton(arg_1_0, arg_1_0.lookAllBtn, function()
		arg_1_0.descPage:ExecuteAction("Show", arg_1_0.activity:getStartTime(), arg_1_0.activity:getDayIndex(), arg_1_0.taskGroup)

		return
	end, SFX_PANEL)
	arg_1_0.uilist:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			arg_1_0:UpdateTask(arg_4_1, arg_4_2)
		end

		return
	end)

	return
end

function var_0_0.OnFirstFlush(arg_5_0)
	IslandTaskActhelper.SetNonFirstEnter(arg_5_0.activity.id)

	return
end

function var_0_0.OnDataSetting(arg_6_0)
	arg_6_0.nday = 0
	arg_6_0.taskGroup = arg_6_0.activity:getIslandConfig("config_data")

	return
end

function var_0_0.UpdateTask(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_2:Find("item")
	local var_7_1 = arg_7_0.taskGroup[arg_7_0.nday][arg_7_1 + 1]
	local var_7_2 = IslandTask.New({
		id = arg_7_0.taskGroup[arg_7_0.nday][arg_7_1 + 1],
		process_list = {}
	})

	assert(var_7_2, "without this task by id: " .. arg_7_0.taskGroup[arg_7_0.nday][arg_7_1 + 1])
	updateCustomDrop(var_7_0, var_7_2:GetAwards()[1])
	onButton(arg_7_0, var_7_0, function()
		arg_7_0:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_0
		})

		return
	end, SFX_PANEL)

	local var_7_3 = arg_7_2:Find("go_btn")
	local var_7_4 = arg_7_2:Find("get_btn")
	local var_7_5 = arg_7_2:Find("got_btn")
	local var_7_6 = arg_7_2:Find("un_finish")
	local var_7_7, var_7_8, var_7_9 = IslandTaskActhelper.GetIslandTaskState(arg_7_0.taskGroup[arg_7_0.nday][arg_7_1 + 1])

	setText(arg_7_2:Find("description"), var_7_2:getConfig("task_desc"))
	setText(arg_7_2:Find("progressText"), var_7_7 .. "/" .. var_7_8)
	setSlider(arg_7_2:Find("progress"), 0, var_7_8, var_7_7)

	local var_7_10 = pg.island_task_target[var_7_2:GetTargetList()[1].id]
	local var_7_11 = tonumber(var_7_10.jump_ui)
	local var_7_12 = tonumber(var_7_10.tips) or tonumber(var_7_10.jump_ui)

	setActive(var_7_6, var_7_9 == 0 and not var_7_12)
	setActive(var_7_3, var_7_9 == 0 and var_7_12)
	setActive(var_7_4, var_7_9 == 1)
	setActive(var_7_5, var_7_9 == 2)
	onButton(arg_7_0, var_7_3, function()
		if not var_7_12 then
			return
		end

		if var_7_11 then
			arg_7_0:_SkipBtn(var_7_11)
		elseif var_0 then
			if IslandMainBtnTipHelper.IsUnlock("map") then
				arg_7_0:_SkipObj(var_0)
			end
		end

		return
	end, SFX_PANEL)
	onButton(arg_7_0, var_7_4, function()
		pg.m02:sendNotification(GAME.ISLAND_SUBMIT_TASK, {
			taskId = var_7_1
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateAll(arg_11_0)
	if not arg_11_0.activity then
		return
	end

	arg_11_0.nday = IslandTaskActhelper.GetNDay(arg_11_0.activity)

	arg_11_0:UpdateDay()
	arg_11_0:UpdateDesc()
	arg_11_0:UpdateProgress()

	local var_11_0 = arg_11_0.taskGroup[arg_11_0.nday] or {}

	arg_11_0.uilist:align(#var_11_0)

	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	arg_12_0:UpdateAll()

	return
end

function var_0_0.OnShowFlush(arg_13_0)
	arg_13_0:UpdateAll()

	return
end

function var_0_0.UpdateDay(arg_14_0)
	local var_14_0 = arg_14_0.activity:getConfig("time")

	arg_14_0.timeTxt.text = string.format("%d.%d - %d.%d%s", var_14_0[2][1][2], var_14_0[2][1][3], var_14_0[3][1][2], var_14_0[3][1][3], i18n("island_draw_time_1"))

	return
end

function var_0_0.UpdateDesc(arg_15_0)
	arg_15_0.descTxt.text = i18n("island_mecha_task_description")

	return
end

function var_0_0.UpdateProgress(arg_16_0)
	arg_16_0.progressTxt.text = i18n("island_mecha_task_progress", arg_16_0.nday, #arg_16_0.taskGroup)

	return
end

function var_0_0.Hide(arg_17_0)
	var_0_0.super.Hide(arg_17_0)

	if arg_17_0.descPage and arg_17_0.descPage:isShowing() then
		arg_17_0.descPage:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_18_0)
	if arg_18_0.descPage then
		arg_18_0.descPage:Destroy()

		arg_18_0.descPage = nil
	end

	eachChild(arg_18_0.items, function(arg_19_0)
		Destroy(arg_19_0)

		return
	end)

	return
end

function var_0_0._SkipBtn(arg_20_0, arg_20_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():HasAbility(pg.island_main_btns[arg_20_1].ability_id) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_systemnoopen_tips"))

		return
	end

	if pg.island_main_btns[arg_20_1].open_page ~= "" then
		arg_20_0:emit(IslandMediator.OPEN_PAGE, pg.island_main_btns[arg_20_1].open_page, pg.island_main_btns[arg_20_1].page_param)
	end

	return
end

function var_0_0._SkipObj(arg_21_0, arg_21_1)
	if not getProxy(IslandProxy):GetIsland():GetAblityAgency():IsUnlockMap(pg.island_world_objects[arg_21_1].mapId) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_taskjump_placenoopen_tips"))

		return
	end

	arg_21_0:emit(IslandSeasonPage.CLOSE)

	if _IslandCore then
		if pg.island_world_objects[arg_21_1].mapId == _IslandCore:GetController():GetMapID() then
			return
		end
	end

	arg_21_0:emit(IslandBaseMediator.SWITCH_MAP, pg.island_world_objects[arg_21_1].mapId, pg.island_map[pg.island_world_objects[arg_21_1].mapId].born_object)

	return
end

return var_0_0
