class = var_0_10000

local var_0_0 = "StarsCityOmenPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.activity.CorePage.CoreLoginTemplatePage"))

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

	arg_1_0.ruleTxt = var_1.Find(var_1_7, "rule_get")

	local var_1_8 = arg_1_0.bg

	arg_1_0.btnStory = var_1.Find(var_1_8, "btn_story")

	local var_1_9 = arg_1_0.btnStory

	arg_1_0.redPoint = var_1.Find(var_1_9, "red")
	arg_1_0.scenario = arg_1_0:GetOutPostScenarioPage().New(arg_1_0._tf, arg_1_0.event)

	local var_1_10 = arg_1_0.scenario

	var_1.SetCoreStoryPage(var_1_10, arg_1_0)

	local var_1_11 = arg_1_0.scenario

	var_1.RegisterView(var_1_11, arg_1_0.coreActivityUI)

	StarsCityOmenTaskWindow = var_1
	arg_1_0.taskWindow = var_1.New(arg_1_0._tf, arg_1_0.event)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_12 = arg_1_0.bg

	arg_1_0.progressLabel = var_1.Find(var_1_12, "total_progress/label")
	setText = var_1

	local var_1_13 = arg_1_0.progressLabel

	i18n = var_4

	var_1(var_1_13, var_4("Outpost_20250904_Progress"))

	setText = var_1

	local var_1_14 = arg_1_0.txtDetail

	i18n = var_4

	var_1(var_1_14, var_4("Outpost_20260514_Detail"))

	setText = var_1

	local var_1_15 = arg_1_0.ruleTxt

	i18n = var_4

	var_1(var_1_15, var_4("Outpost_20260806_rule"))

	return
end

function var_0_1.GetOutPostScenarioPage(arg_2_0)
	OutPostScenarioPage_260806 = var_1_10001

	return var_1_10001
end

function var_0_1.OnDataSetting(arg_3_0)
	arg_3_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_3_0.taskProxy = var_1(var_1_10003)

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

	SFX_PANEL = var_1_10006

	var_1(var_4_0, var_4_1, var_4_2, var_1_10006)

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

			Activity = var_0

			local var_6_5 = var_0.GetPlayerActivyIDKey(arg_4_0.activity.id)

			PlayerPrefs = var_2_10001

			var_2_10001.SetInt(var_6_5, 1)

			PlayerPrefs = var_1

			var_1.Save()

			local var_6_6 = arg_4_0

			var_1.refreshStoryPoint(var_6_6)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_4_3, var_4_4, var_4_5, var_1_10006)

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
	arg_11_0:refreshStoryPoint()

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

function var_0_1.UpdateTask(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1
	local var_12_1 = arg_12_2:Find("item")
	local var_12_2 = arg_12_0.taskGroup[arg_12_0.nday][var_12_0]
	local var_12_3 = arg_12_0.taskProxy
	local var_12_4

	if not var_6.getTaskById(var_12_3, var_12_2) then
		var_12_3 = arg_12_0.taskProxy
		var_12_4 = var_6.getFinishTaskById(var_12_3, var_12_2)
	end

	assert = var_7

	var_7(var_12_4, "without this task by id: " .. var_12_2)

	Drop = var_7

	local var_12_5 = var_7.Create(var_12_4:getConfig("award_display")[1])

	updateDrop = var_12_3

	var_12_3(var_12_1, var_12_5)

	onButton = var_12_3

	local var_12_6 = arg_12_0
	local var_12_7 = var_12_1

	local function var_12_8()
		local var_13_0 = arg_12_0
		local var_13_1 = var_0.emit

		BaseUI = var_2_10003

		var_13_1(var_13_0, var_2_10003.ON_DROP, var_12_5)

		return
	end

	SFX_PANEL = var_1_10013

	var_12_3(var_12_6, var_12_7, var_12_8, var_1_10013)

	local var_12_9 = var_12_4
	local var_12_10 = var_12_4.getProgress(var_12_9)
	local var_12_11 = var_12_4:getConfig("target_num")

	setScrollText = var_12_9

	var_12_9(arg_12_2:Find("mask/description"), var_12_4:getConfig("desc"))

	local var_12_12 = arg_12_0
	local var_12_13, var_12_14 = arg_12_0.GetProgressColor(var_12_12)

	if var_12_13 then
		setColorStr = var_12_12

		local var_12_15

		if not var_12_12(var_12_10, var_12_13) then
			::label_12_0::

			var_12_15 = var_12_10
		end

		if var_12_14 then
			setColorStr = var_12_12

			local var_12_16

			if not var_12_12("/" .. var_12_11, var_12_14) then
				::label_12_1::

				var_12_16 = "/" .. var_12_11
			end

			setText = var_12_12

			var_12_12(arg_12_2:Find("progressText"), var_12_15 .. var_12_16)

			setSlider = var_12_12

			var_12_12(arg_12_2:Find("progress"), 0, var_12_11, var_12_10)

			local var_12_17 = arg_12_2:Find("go_btn")
			local var_12_18 = arg_12_2:Find("get_btn")
			local var_12_19 = arg_12_2
			local var_12_20 = arg_12_2.Find(var_12_19, "got_btn")

			arg_12_0:SetBtnLocal(arg_12_2)

			local var_12_21 = var_12_4:getTaskStatus()

			setActive = var_12_19

			var_12_19(var_12_17, var_12_21 == 0)

			setActive = var_12_19

			var_12_19(var_12_18, var_12_21 == 1)

			setActive = var_12_19

			var_12_19(var_12_20, var_12_21 == 2)

			onButton = var_12_19

			local var_12_22 = arg_12_0
			local var_12_23 = var_12_17

			local function var_12_24()
				local var_14_0 = arg_12_0
				local var_14_1 = var_0.emit

				ActivityMediator = var_2_10003

				var_14_1(var_14_0, var_2_10003.ON_TASK_GO, var_12_4)

				return
			end

			SFX_PANEL = var_1_10021

			var_12_19(var_12_22, var_12_23, var_12_24, var_1_10021)

			onButton = var_12_19

			local var_12_25 = arg_12_0
			local var_12_26 = var_12_18

			local function var_12_27()
				local var_15_0 = {}
				local var_15_1 = var_12_4
				local var_15_2 = var_1.getConfig(var_15_1, "award_display")

				getProxy = var_2_10002
				PlayerProxy = var_4

				local var_15_3 = var_2_10002(var_4)
				local var_15_4 = var_2.getRawData(var_15_3)

				pg = var_4

				local var_15_5 = var_4.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_15_3

				if var_15_3 then
					var_15_3 = 0
				else
					getProxy = var_15_3
					BagProxy = var_2_10007

					local var_15_6 = var_15_3(var_2_10007)

					var_15_3 = var_15_3.GetLimitCntById(var_15_6, var_15_5)
				end

				Task = var_2_10006

				local var_15_7, var_15_8 = var_2_10006.StaticJudgeOverflow(var_15_4.gold, var_15_4.oil, var_15_3, true, true, var_15_2)

				if var_15_7 then
					table = var_8

					var_8.insert(var_15_0, function(arg_16_0)
						pg = var_3_10001

						local var_16_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_16_1 = var_1.ShowMsgBox
						local var_16_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10005
						var_16_2.type = var_3_10005
						i18n = var_3_10005
						var_16_2.content = var_3_10005("award_max_warning")
						var_16_2.items = var_15_8
						var_16_2.onYes = arg_16_0

						var_16_1(var_16_0, var_16_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_15_0, function()
					local var_17_0 = arg_12_0
					local var_17_1 = var_0.emit

					ActivityMediator = var_3_10003

					var_17_1(var_17_0, var_3_10003.ON_TASK_SUBMIT, var_12_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10021

			var_12_19(var_12_25, var_12_26, var_12_27, var_1_10021)

			return
		end
	end
end

function var_0_1.getTaskIdx(arg_18_0, arg_18_1)
	local var_18_0 = 1
	local var_18_1 = arg_18_1
	local var_18_2 = arg_18_1.getNDay(var_18_1)
	local var_18_3 = #arg_18_0.taskGroup

	math = var_18_1

	local var_18_4 = var_18_1.min(var_18_2, var_18_3)
	local var_18_5 = true

	for iter_18_0 = 1, var_18_4 do
		if not var_18_5 then
			break
		end

		var_18_0 = iter_18_0

		if iter_18_0 < var_18_4 then
			ipairs = var_1_10011

			for iter_18_1, iter_18_2 in var_1_10011(arg_18_0.taskGroup[iter_18_0]) do
				if not arg_18_0:isTaskFinished(iter_18_2) then
					var_18_5 = false

					break
				end
			end
		end
	end

	math = var_7

	return var_7.min(var_18_0, var_18_3)
end

function var_0_1.isTaskFinished(arg_19_0, arg_19_1)
	if not arg_19_0.taskProxy then
		getProxy = var_2
		TaskProxy = var_1_10004
		arg_19_0.taskProxy = var_2(var_1_10004)
	end

	local var_19_0 = arg_19_0.taskProxy
	local var_19_2

	if not var_2.getTaskById(var_19_0, arg_19_1) then
		local var_19_1 = arg_19_0.taskProxy

		var_19_2 = var_2.getFinishTaskById(var_19_1, arg_19_1)
	end

	return var_19_2 and var_19_2:getTaskStatus() == 2
end

function var_0_1.refreshStoryPoint(arg_20_0)
	Activity = var_1_10001

	local var_20_0 = var_1_10001.GetPlayerActivyIDKey(arg_20_0.activity.id)

	PlayerPrefs = var_1_10002

	local var_20_1 = var_1_10002.GetInt(var_20_0, 0) == 0

	setActive = var_3

	var_3(arg_20_0.redPoint, var_20_1)

	return
end

function var_0_1.GetProgressColor(arg_21_0)
	return "#FFFFFF", "#C3C3C3"
end

function var_0_1.SetBtnLocal(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:Find("get_btn")
	local var_22_1 = arg_22_1
	local var_22_2 = arg_22_1.Find(var_22_1, "go_btn")
	local var_22_3 = arg_22_1:Find("got_btn")

	setText = var_22_1

	local var_22_4 = var_22_0:Find("Text")

	i18n = var_1_10008

	var_22_1(var_22_4, var_1_10008("LiquorFloorTaskUI_get"))

	setText = var_22_1

	local var_22_5 = var_22_2:Find("Text")

	i18n = var_8

	var_22_1(var_22_5, var_8("LiquorFloorTaskUI_go"))

	setText = var_22_1

	local var_22_6 = var_22_3:Find("Text")

	i18n = var_8

	var_22_1(var_22_6, var_8("LiquorFloorTaskUI_got"))

	return
end

function var_0_1.OnHideFlush(arg_23_0)
	local var_23_0 = arg_23_0.taskWindow

	if var_1.isShowing(var_23_0) then
		local var_23_1 = arg_23_0.taskWindow

		var_1.Hide(var_23_1)
	end

	return
end

function var_0_1.OnDestroy(arg_24_0)
	if arg_24_0.taskWindow then
		local var_24_0 = arg_24_0.taskWindow

		var_1.Hide(var_24_0)

		local var_24_1 = arg_24_0.taskWindow

		var_1.Destroy(var_24_1)

		arg_24_0.taskWindow = nil
	end

	if arg_24_0.scenario then
		local var_24_2 = arg_24_0.scenario

		if var_1.isShowing(var_24_2) then
			local var_24_3 = arg_24_0.scenario

			var_1.Hide(var_24_3)
		end

		local var_24_4 = arg_24_0.scenario

		var_1.Destroy(var_24_4)
	end

	return
end

return var_0_1
