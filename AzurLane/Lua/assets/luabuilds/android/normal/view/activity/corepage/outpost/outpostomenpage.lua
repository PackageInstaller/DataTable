class = var_0_10000

local var_0_0 = "OutPostOmenPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreLoginTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_1, "total_progress/day")

	local var_1_2 = arg_1_0.bg

	arg_1_0.maxDayTF = var_1.Find(var_1_2, "total_progress/max_day")

	local var_1_3 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_3, "item")

	local var_1_4 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_4, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_5 = arg_1_0.bg

	arg_1_0.btnDetail = var_1.Find(var_1_5, "btn_detail")

	local var_1_6 = arg_1_0.btnDetail

	arg_1_0.txtDetail = var_1.Find(var_1_6, "detail")

	local var_1_7 = arg_1_0.bg

	arg_1_0.btnStory = var_1.Find(var_1_7, "btn_story")
	arg_1_0.scenario = arg_1_0:GetOutPostScenarioPage().New(arg_1_0._tf, arg_1_0.event)

	local var_1_8 = arg_1_0.scenario

	var_1.SetCoreStoryPage(var_1_8, arg_1_0)

	local var_1_9 = arg_1_0.scenario

	var_1.RegisterView(var_1_9, arg_1_0.coreActivityUI)

	OutPostOmenTaskWindow = var_1
	arg_1_0.taskWindow = var_1.New(arg_1_0._tf, arg_1_0.event)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_10 = arg_1_0.bg

	arg_1_0.progressLabel = var_1.Find(var_1_10, "total_progress/label")
	setText = var_1

	local var_1_11 = arg_1_0.progressLabel

	i18n = var_3

	var_1(var_1_11, var_3("Outpost_20250904_Progress"))

	setText = var_1

	local var_1_12 = arg_1_0.txtDetail

	i18n = var_3

	var_1(var_1_12, var_3("Outpost_20260514_Detail"))

	return
end

function var_0_1.GetOutPostScenarioPage(arg_2_0)
	OutPostScenarioPage = var_1_10001

	return var_1_10001
end

function var_0_1.OnDataSetting(arg_3_0)
	arg_3_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10002
	arg_3_0.taskProxy = var_1(var_1_10002)

	local var_3_0 = arg_3_0.activity

	arg_3_0.taskGroup = var_1.getConfig(var_3_0, "config_client").unlock_task
	updateActivityTaskStatus = var_1

	return var_1(arg_3_0.activity)
end

function var_0_1.OnFirstFlush(arg_4_0)
	var_0_1.super.OnFirstFlush(arg_4_0)

	setActive = var_1

	var_1(arg_4_0.maxTF, #arg_4_0.taskGroup)

	onButton = var_1

	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.btnDetail

	local function var_4_2()
		local var_5_0 = arg_4_0.taskWindow

		var_0.ExecuteAction(var_5_0, "Show", arg_4_0.activity)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_0, var_4_1, var_4_2, var_1_10005)

	onButton = var_1

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.btnStory

	local function var_4_5()
		if arg_4_0.scenario then
			local var_6_0 = arg_4_0.scenario

			var_0.Load(var_6_0)

			local var_6_1 = arg_4_0.scenario

			var_0.SetActivity(var_6_1, arg_4_0.activity)

			local var_6_2 = arg_4_0.scenario

			var_0.UpdateStoryTask(var_6_2)

			local var_6_3 = arg_4_0.scenario

			var_0.ActionInvoke(var_6_3, "UpdateView")

			local var_6_4 = arg_4_0

			var_0.ShowScenarioLayer(var_6_4, true)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_4_3, var_4_4, var_4_5, var_1_10005)

	return
end

function var_0_1.OnShowFlush(arg_7_0)
	var_0_1.super.OnShowFlush(arg_7_0)

	return
end

function var_0_1.ShowScenarioLayer(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_8_0, true)

		if arg_8_0.scenario then
			local var_8_1 = arg_8_0.scenario

			var_2.ActionInvoke(var_8_1, "Show")
		end
	else
		if arg_8_0.scenario then
			local var_8_2 = arg_8_0.scenario

			var_2.Hide(var_8_2)
		end

		local var_8_3 = arg_8_0.coreActivityUI

		var_2.ActiveScenarioLayer(var_8_3, false)
	end

	return
end

function var_0_1.IsShowingPopWindow(arg_9_0)
	if arg_9_0.scenario then
		local var_9_0 = arg_9_0.scenario

		return var_1.isShowing(var_9_0)
	end

	return
end

function var_0_1.ClosePopWindow(arg_10_0)
	if arg_10_0.scenario then
		local var_10_0 = arg_10_0.scenario

		var_1.Hide(var_10_0)
		arg_10_0:ShowScenarioLayer(false)
	end

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	local var_11_0 = #arg_11_0.taskGroup

	arg_11_0.nday = arg_11_0:getTaskIdx(arg_11_0.activity)

	arg_11_0:PlayStory()

	if arg_11_0.dayTF then
		setText = var_2

		var_2(arg_11_0.dayTF, "DAY " .. arg_11_0.nday)

		setText = var_2

		var_2(arg_11_0.maxDayTF, "/" .. var_11_0)
	end

	local var_11_1 = arg_11_0.uilist

	var_2.align(var_11_1, #arg_11_0.taskGroup[arg_11_0.nday])

	local var_11_2 = arg_11_0.taskWindow

	if var_2.isShowing(var_11_2) then
		local var_11_3 = arg_11_0.taskWindow

		var_2.ExecuteAction(var_11_3, "Show", arg_11_0.activity)
	end

	return
end

function var_0_1.getTaskIdx(arg_12_0, arg_12_1)
	local var_12_0 = 1
	local var_12_1 = arg_12_1:getNDay()
	local var_12_2 = #arg_12_0.taskGroup

	math = var_1_10005

	local var_12_3 = var_1_10005.min(var_12_1, var_12_2)
	local var_12_4 = true

	for iter_12_0 = 1, var_12_3 do
		if not var_12_4 then
			break
		end

		var_12_0 = iter_12_0

		if iter_12_0 < var_12_3 then
			ipairs = var_1_10011

			for iter_12_1, iter_12_2 in var_1_10011(arg_12_0.taskGroup[iter_12_0]) do
				if not arg_12_0:isTaskFinished(iter_12_2) then
					var_12_4 = false

					break
				end
			end
		end
	end

	math = var_7

	return var_7.min(var_12_0, var_12_2)
end

function var_0_1.isTaskFinished(arg_13_0, arg_13_1)
	if not arg_13_0.taskProxy then
		getProxy = var_2
		TaskProxy = var_1_10003
		arg_13_0.taskProxy = var_2(var_1_10003)
	end

	local var_13_0 = arg_13_0.taskProxy
	local var_13_2

	if not var_2.getTaskById(var_13_0, arg_13_1) then
		local var_13_1 = arg_13_0.taskProxy

		var_13_2 = var_2.getFinishTaskById(var_13_1, arg_13_1)
	end

	return var_13_2 and var_13_2:getTaskStatus() == 2
end

function var_0_1.OnHideFlush(arg_14_0)
	local var_14_0 = arg_14_0.taskWindow

	if var_1.isShowing(var_14_0) then
		local var_14_1 = arg_14_0.taskWindow

		var_1.Hide(var_14_1)
	end

	return
end

function var_0_1.OnDestroy(arg_15_0)
	if arg_15_0.taskWindow then
		local var_15_0 = arg_15_0.taskWindow

		var_1.Hide(var_15_0)

		local var_15_1 = arg_15_0.taskWindow

		var_1.Destroy(var_15_1)

		arg_15_0.taskWindow = nil
	end

	if arg_15_0.scenario then
		local var_15_2 = arg_15_0.scenario

		if var_1.isShowing(var_15_2) then
			local var_15_3 = arg_15_0.scenario

			var_1.Hide(var_15_3)
		end

		local var_15_4 = arg_15_0.scenario

		var_1.Destroy(var_15_4)
	end

	return
end

return var_0_1
