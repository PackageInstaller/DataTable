local var_0_0 = class("OutPostOmenPage", import("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("bg")
	arg_1_0.dayTF = arg_1_0.bg:Find("total_progress/day")
	arg_1_0.maxDayTF = arg_1_0.bg:Find("total_progress/max_day")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.uilist = UIItemList.New(arg_1_0.items, arg_1_0.item)
	arg_1_0.btnDetail = arg_1_0.bg:Find("btn_detail")
	arg_1_0.txtDetail = arg_1_0.btnDetail:Find("detail")
	arg_1_0.btnStory = arg_1_0.bg:Find("btn_story")
	arg_1_0.scenario = arg_1_0:GetOutPostScenarioPage().New(arg_1_0._tf, arg_1_0.event)

	arg_1_0.scenario:SetCoreStoryPage(arg_1_0)
	arg_1_0.scenario:RegisterView(arg_1_0.coreActivityUI)

	arg_1_0.taskWindow = OutPostOmenTaskWindow.New(arg_1_0._tf, arg_1_0.event)

	setActive(arg_1_0.item, false)

	arg_1_0.progressLabel = arg_1_0.bg:Find("total_progress/label")

	setText(arg_1_0.progressLabel, i18n("Outpost_20250904_Progress"))
	setText(arg_1_0.txtDetail, i18n("Outpost_20260514_Detail"))

	return
end

function var_0_0.GetOutPostScenarioPage(arg_2_0)
	return OutPostScenarioPage
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

function var_0_0.getTaskIdx(arg_12_0, arg_12_1)
	local var_12_0 = 1
	local var_12_1 = math.min(arg_12_1:getNDay(), #arg_12_0.taskGroup)

	for iter_12_0 = 1, var_12_1 do
		if not true then
			break
		end

		var_12_0 = iter_12_0

		if iter_12_0 < var_12_1 then
			for iter_12_1, iter_12_2 in ipairs(arg_12_0.taskGroup[iter_12_0]) do
				local var_12_2

				if not arg_12_0:isTaskFinished(iter_12_2) then
					var_12_2 = false

					break
				end
			end
		end
	end

	return math.min(var_12_0, #arg_12_0.taskGroup)
end

function var_0_0.isTaskFinished(arg_13_0, arg_13_1)
	arg_13_0.taskProxy = arg_13_0.taskProxy or getProxy(TaskProxy)

	local var_13_0 = arg_13_0.taskProxy:getTaskById(arg_13_1) or arg_13_0.taskProxy:getFinishTaskById(arg_13_1)

	return var_13_0 and var_13_0:getTaskStatus() == 2
end

function var_0_0.OnHideFlush(arg_14_0)
	if arg_14_0.taskWindow:isShowing() then
		arg_14_0.taskWindow:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_15_0)
	if arg_15_0.taskWindow then
		arg_15_0.taskWindow:Hide()
		arg_15_0.taskWindow:Destroy()

		arg_15_0.taskWindow = nil
	end

	if arg_15_0.scenario then
		if arg_15_0.scenario:isShowing() then
			arg_15_0.scenario:Hide()
		end

		arg_15_0.scenario:Destroy()
	end

	return
end

return var_0_0
