local var_0_0 = class("StarsCityOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.dayTF = arg_1_0.bg:Find("total_progress/day")
	arg_1_0.maxDayTF = arg_1_0.bg:Find("total_progress/max_day")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.btnDetail = arg_1_0.bg:Find("btn_detail")
	arg_1_0.txtDetail = arg_1_0.btnDetail:Find("detail")
	arg_1_0.ruleTxt = arg_1_0.bg:Find("rule_get")
	arg_1_0.btnStory = arg_1_0.bg:Find("btn_story")
	arg_1_0.redPoint = arg_1_0.btnStory:Find("red")
	arg_1_0.scenario = arg_1_0:GetOutPostScenarioPage().New(arg_1_0._tf, arg_1_0.event)

	arg_1_0.scenario:SetCoreStoryPage(arg_1_0)
	arg_1_0.scenario:RegisterView(arg_1_0.coreActivityUI)

	arg_1_0.taskWindow = StarsCityOmenTaskWindow.New(arg_1_0._tf, arg_1_0.event)

	setActive(arg_1_0.item, false)

	arg_1_0.progressLabel = arg_1_0.bg:Find("total_progress/label")

	setText(arg_1_0.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(arg_1_0.txtDetail, i18n("Outpost_20260514_Detail"))
	setText(arg_1_0.ruleTxt, i18n("Outpost_20260806_rule"))

	return
end

function var_0_0.GetOutPostScenarioPage(arg_2_0)
	return OutPostScenarioPage_260806
end

function var_0_0.OnDataSetting(arg_3_0)
	arg_3_0.nday = 0
	arg_3_0.taskProxy = getProxy(TaskProxy)
	arg_3_0.taskGroup = arg_3_0.activity:getConfig("config_client").unlock_task

	return updateActivityTaskStatus(arg_3_0.activity)
end

function var_0_0.OnFirstFlush(arg_4_0)
	var_0_0.super.OnFirstFlush(arg_4_0)
	setActive(arg_4_0.maxTF, #arg_4_0.taskGroup)
	onButton(arg_4_0, arg_4_0.btnDetail, function()
		arg_4_0.taskWindow:ExecuteAction("Show", arg_4_0.activity)

		return
	end, SFX_PANEL)
	onButton(arg_4_0, arg_4_0.btnStory, function()
		if arg_4_0.scenario then
			arg_4_0.scenario:Load()
			arg_4_0.scenario:SetActivity(arg_4_0.activity)
			arg_4_0.scenario:UpdateStoryTask()
			arg_4_0.scenario:ActionInvoke("UpdateView")
			arg_4_0:ShowScenarioLayer(true)
			PlayerPrefs.SetInt(Activity.GetPlayerActivyIDKey(arg_4_0.activity.id), 1)
			PlayerPrefs.Save()
			arg_4_0:refreshStoryPoint()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnShowFlush(arg_7_0)
	var_0_0.super.OnShowFlush(arg_7_0)

	return
end

function var_0_0.ShowScenarioLayer(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0.coreActivityUI:ActiveScenarioLayer(true)

		if arg_8_0.scenario then
			arg_8_0.scenario:ActionInvoke("Show")
		end
	else
		if arg_8_0.scenario then
			arg_8_0.scenario:Hide()
		end

		arg_8_0.coreActivityUI:ActiveScenarioLayer(false)
	end

	return
end

function var_0_0.IsShowingPopWindow(arg_9_0)
	if arg_9_0.scenario then
		return arg_9_0.scenario:isShowing()
	end

	return
end

function var_0_0.ClosePopWindow(arg_10_0)
	if arg_10_0.scenario then
		arg_10_0.scenario:Hide()
		arg_10_0:ShowScenarioLayer(false)
	end

	return
end

function var_0_0.OnUpdateFlush(arg_11_0)
	arg_11_0.nday = arg_11_0:getTaskIdx(arg_11_0.activity)

	arg_11_0:PlayStory()
	arg_11_0:refreshStoryPoint()

	if arg_11_0.dayTF then
		setText(arg_11_0.dayTF, "DAY " .. arg_11_0.nday)
		setText(arg_11_0.maxDayTF, "/" .. #arg_11_0.taskGroup)
	end

	arg_11_0.uilist:align(#arg_11_0.taskGroup[arg_11_0.nday])

	if arg_11_0.taskWindow:isShowing() then
		arg_11_0.taskWindow:ExecuteAction("Show", arg_11_0.activity)
	end

	return
end

function var_0_0.UpdateTask(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2:Find("item")
	local var_12_1 = arg_12_0.taskProxy:getTaskById(arg_12_0.taskGroup[arg_12_0.nday][arg_12_1 + 1]) or arg_12_0.taskProxy:getFinishTaskById(arg_12_0.taskGroup[arg_12_0.nday][arg_12_1 + 1])

	assert(var_12_1, "without this task by id: " .. arg_12_0.taskGroup[arg_12_0.nday][arg_12_1 + 1])
	updateDrop(var_12_0, (Drop.Create(var_12_1:getConfig("award_display")[1])))
	onButton(arg_12_0, var_12_0, function()
		arg_12_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	local var_12_2 = var_12_1:getProgress()
	local var_12_3 = var_12_1:getConfig("target_num")

	setScrollText(arg_12_2:Find("mask/description"), var_12_1:getConfig("desc"))

	local var_12_4, var_12_5 = arg_12_0:GetProgressColor()
	local var_12_6

	var_12_6 = var_12_4 and setColorStr(var_12_2, var_12_4) or var_12_2

	local var_12_7

	var_12_7 = var_12_5 and setColorStr("/" .. var_12_3, var_12_5) or "/" .. var_12_3

	setText(arg_12_2:Find("progressText"), var_12_6 .. var_12_7)
	setSlider(arg_12_2:Find("progress"), 0, var_12_3, var_12_2)

	local var_12_8 = arg_12_2:Find("go_btn")
	local var_12_9 = arg_12_2:Find("get_btn")
	local var_12_10 = arg_12_2:Find("got_btn")

	arg_12_0:SetBtnLocal(arg_12_2)

	local var_12_11 = var_12_1:getTaskStatus()

	setActive(var_12_8, var_12_11 == 0)
	setActive(var_12_9, var_12_11 == 1)
	setActive(var_12_10, var_12_11 == 2)
	onButton(arg_12_0, var_12_8, function()
		arg_12_0:emit(ActivityMediator.ON_TASK_GO, var_12_1)

		return
	end, SFX_PANEL)
	onButton(arg_12_0, var_12_9, function()
		local var_15_0 = var_12_1:getConfig("award_display")
		local var_15_1 = getProxy(PlayerProxy):getRawData()
		local var_15_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_15_3, var_15_4 = Task.StaticJudgeOverflow(var_15_1.gold, var_15_1.oil, var_15_2, true, true, var_15_0)

		if var_15_3 then
			table.insert({}, function(arg_16_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_15_4,
					onYes = arg_16_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			arg_12_0:emit(ActivityMediator.ON_TASK_SUBMIT, var_12_1)

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.getTaskIdx(arg_18_0, arg_18_1)
	local var_18_0 = 1
	local var_18_1 = math.min(arg_18_1:getNDay(), #arg_18_0.taskGroup)

	for iter_18_0 = 1, var_18_1 do
		if not true then
			break
		end

		var_18_0 = iter_18_0

		if iter_18_0 < var_18_1 then
			for iter_18_1, iter_18_2 in ipairs(arg_18_0.taskGroup[iter_18_0]) do
				local var_18_2

				if not arg_18_0:isTaskFinished(iter_18_2) then
					var_18_2 = false

					break
				end
			end
		end
	end

	return math.min(var_18_0, #arg_18_0.taskGroup)
end

function var_0_0.isTaskFinished(arg_19_0, arg_19_1)
	arg_19_0.taskProxy = arg_19_0.taskProxy or getProxy(TaskProxy)

	local var_19_0 = arg_19_0.taskProxy:getTaskById(arg_19_1) or arg_19_0.taskProxy:getFinishTaskById(arg_19_1)

	return var_19_0 and var_19_0:getTaskStatus() == 2
end

function var_0_0.refreshStoryPoint(arg_20_0)
	setActive(arg_20_0.redPoint, PlayerPrefs.GetInt(Activity.GetPlayerActivyIDKey(arg_20_0.activity.id), 0) == 0)

	return
end

function var_0_0.GetProgressColor(arg_21_0)
	return "#FFFFFF", "#C3C3C3"
end

function var_0_0.SetBtnLocal(arg_22_0, arg_22_1)
	setText(arg_22_1:Find("get_btn"):Find("Text"), i18n("LiquorFloorTaskUI_get"))
	setText(arg_22_1:Find("go_btn"):Find("Text"), i18n("LiquorFloorTaskUI_go"))
	setText(arg_22_1:Find("got_btn"):Find("Text"), i18n("LiquorFloorTaskUI_got"))

	return
end

function var_0_0.OnHideFlush(arg_23_0)
	if arg_23_0.taskWindow:isShowing() then
		arg_23_0.taskWindow:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_24_0)
	if arg_24_0.taskWindow then
		arg_24_0.taskWindow:Hide()
		arg_24_0.taskWindow:Destroy()

		arg_24_0.taskWindow = nil
	end

	if arg_24_0.scenario then
		if arg_24_0.scenario:isShowing() then
			arg_24_0.scenario:Hide()
		end

		arg_24_0.scenario:Destroy()
	end

	return
end

return var_0_0
