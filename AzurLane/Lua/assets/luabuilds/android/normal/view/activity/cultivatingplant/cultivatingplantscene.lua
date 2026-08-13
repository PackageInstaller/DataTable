class = var_0_10000

local var_0_0 = "CultivatingPlantScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "CultivatingPlantPartUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SFX_CANCLE = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiCultivatingBtn

	local function var_2_5()
		local var_4_0 = arg_2_0
		local var_4_1 = var_0.emit

		CultivatingPlantMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.GO_SCENE)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	onButton = var_1_10001

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.uiIslandBtn

	local function var_2_8()
		getProxy = var_2_10000
		TaskProxy = var_2_10001

		local var_5_0 = var_2_10000(var_2_10001)

		if var_0.getTaskVO(var_5_0, arg_2_0.taskList[arg_2_0.index]) == nil or not var_0:isFinish() then
			return
		end

		if not var_0:isReceive() then
			local var_5_1 = arg_2_0
			local var_5_2 = var_1.emit

			CultivatingPlantMediator = var_3

			var_5_2(var_5_1, var_3.ON_TASK_SUBMIT, var_0)
		else
			local var_5_3 = arg_2_0

			var_1.OpenLiveArea(var_5_3)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_2_6, var_2_7, var_2_8, var_1_10005)

	for iter_2_0 = 1, arg_2_0.uiList.childCount do
		local var_2_9 = arg_2_0.uiList
		local var_2_10 = var_5.GetChild(var_2_9, iter_2_0 - 1)

		onButton = var_2_9

		local var_2_11 = arg_2_0
		local var_2_12 = var_2_10

		local function var_2_13()
			local var_6_0 = arg_2_0

			var_0.SelectPage(var_6_0, iter_2_0)

			return
		end

		SFX_PANEL = var_1_10010

		var_2_9(var_2_11, var_2_12, var_2_13, var_1_10010)
	end

	setText = var_1

	local var_2_14 = arg_2_0.uiTaskTitle

	i18n = var_3

	var_1(var_2_14, var_3("cultivating_plant_task_title"))

	setText = var_1

	local var_2_15 = arg_2_0.uiIslandText

	i18n = var_3

	var_1(var_2_15, var_3("cultivating_plant_island_task"))

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:BlurPanel(arg_7_0._tf)

	CultivatingPlantTools = var_1
	arg_7_0.taskList = var_1.GetTaskIDList()

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.SelectPage
	local var_7_2

	if not arg_7_0.contextData.id or not (arg_7_0.contextData.id + 1) then
		var_7_2 = 1
	end

	var_7_1(var_7_0, var_7_2)

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	if arg_8_0.liveAreaPage then
		local var_8_0 = arg_8_0.liveAreaPage

		var_1.Destroy(var_8_0)

		arg_8_0.liveAreaPage = nil
	end

	return
end

function var_0_1.SelectPage(arg_9_0, arg_9_1)
	if arg_9_0.index == arg_9_1 then
		return
	end

	local var_9_0 = 216
	local var_9_1 = 1238

	arg_9_0.index = arg_9_1

	for iter_9_0 = 1, arg_9_0.uiList.childCount do
		local var_9_2 = arg_9_0.uiList
		local var_9_3 = var_8.GetChild(var_9_2, iter_9_0 - 1)
		local var_9_4 = var_8.GetComponent

		typeof = var_1_10011
		LayoutElement = var_1_10012
		var_9_4(var_9_3, var_1_10011(var_1_10012)).preferredWidth = iter_9_0 == arg_9_1 and var_9_1 or var_9_0
		setActive = var_1_10011

		var_1_10011(var_8:Find("Image"), iter_9_0 ~= arg_9_1)

		setActive = var_1_10011

		var_1_10011(var_8:Find("main"), iter_9_0 == arg_9_1)

		getProxy = var_1_10011
		TaskProxy = var_1_10012
		var_1_10012 = var_1_10011(var_1_10012)

		if var_1_10011.getTaskVO(var_1_10012, arg_9_0.taskList[iter_9_0]) then
			local var_9_5 = var_1_10011

			if not var_1_10011.isFinish(var_9_5) then
				var_1_10012 = false
			end

			setActive = var_9_5

			var_9_5(var_8:Find("Image/got"), var_1_10012)

			setActive = var_9_5

			var_9_5(var_8:Find("main/got"), var_1_10012)
		end
	end

	arg_9_0:RefreshTask()

	setText = var_4

	local var_9_6 = arg_9_0.uiCultivatingText

	i18n = var_6
	string = iter_9_0

	var_4(var_9_6, var_6(iter_9_0.format("cultivating_plant_part_" .. arg_9_0.index)))

	return
end

function var_0_1.RefreshTask(arg_10_0)
	local var_10_0 = arg_10_0.taskList[arg_10_0.index]

	pg = var_2

	local var_10_1 = var_2.task_data_template[var_10_0]

	getProxy = var_1_10003
	TaskProxy = var_1_10004

	local var_10_2 = var_1_10003(var_1_10004)
	local var_10_3 = var_3.getTaskVO(var_10_2, arg_10_0.taskList[arg_10_0.index])

	Drop = var_10_2

	local var_10_4 = var_10_2.Create(var_10_1.award_display[1])

	updateDrop = var_5

	var_5(arg_10_0.uiRewardItem, var_10_4)

	onButton = var_5

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.uiRewardItem

	local function var_10_7()
		local var_11_0 = arg_10_0
		local var_11_1 = var_0.emit

		BaseUI = var_2_10002

		var_11_1(var_11_0, var_2_10002.ON_DROP, var_10_4)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_10_5, var_10_6, var_10_7, var_1_10009)

	local var_10_8

	if not var_10_3 or not var_10_3:isReceive() then
		var_10_8 = false
	end

	if var_10_3 then
		var_10_6 = var_10_3

		local var_10_9

		if not var_10_3.isFinish(var_10_6) then
			var_10_9 = false
		end

		setActive = var_10_6

		var_10_6(arg_10_0.uiRewardGot, var_10_8)

		setActive = var_10_6

		var_10_6(arg_10_0.uiRed, var_10_9 and not var_10_8)

		setGray = var_10_6

		var_10_6(arg_10_0.uiIslandBtn, not var_10_9)

		setText = var_10_6

		var_10_6(arg_10_0.uiTaskDesc, var_10_1.desc)

		if var_10_3 then
			local var_10_10 = var_10_3
			local var_10_11

			if not var_10_3.getProgress(var_10_10) then
				var_10_11 = 0
			end

			setText = var_10_10

			local var_10_12 = arg_10_0.uiTaskCnt

			string = var_1_10010

			var_10_10(var_10_12, var_1_10010.format("<color=#268BC5>%s</color>/%s", var_10_11, var_10_1.target_num))

			local var_10_13 = arg_10_0.uiSlider

			var_10_13.fillAmount = var_10_11 / var_10_1.target_num
			setActive = var_10_13

			var_10_13(arg_10_0.uiTask, false)

			setActive = var_10_13

			var_10_13(arg_10_0.uiTask, true)

			return
		end
	end
end

function var_0_1.OpenLiveArea(arg_12_0)
	if arg_12_0.liveAreaPage == nil then
		MainLiveAreaPage = var_1
		arg_12_0.liveAreaPage = var_1.New(arg_12_0._parentTf, arg_12_0.event)
	end

	local var_12_0 = arg_12_0.liveAreaPage

	var_1.ExecuteAction(var_12_0, "Show", true, function()
		return
	end)

	return
end

function var_0_1.RefreshSubmitTaskDone(arg_14_0)
	setActive = var_1_10001

	var_1_10001(arg_14_0.uiRewardGot, true)

	setActive = var_1_10001

	var_1_10001(arg_14_0.uiRed, false)
	arg_14_0:OpenLiveArea()

	return
end

function var_0_1.onBackPressed(arg_15_0)
	if arg_15_0.liveAreaPage then
		local var_15_0 = arg_15_0.liveAreaPage

		if var_1.GetLoaded(var_15_0) then
			local var_15_1 = arg_15_0.liveAreaPage

			if var_1.isShowing(var_15_1) then
				local var_15_2 = arg_15_0.liveAreaPage

				var_1.Hide(var_15_2)

				return true
			end
		end
	end

	return false
end

return var_0_1
