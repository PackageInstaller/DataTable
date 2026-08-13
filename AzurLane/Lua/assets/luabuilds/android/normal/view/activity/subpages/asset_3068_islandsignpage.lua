class = var_0_10000

local var_0_0 = "IslandSignPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSignPage"
end

function var_0_1.OnInit(arg_2_0)
	UIItemList = var_1_10001
	arg_2_0.uilist = var_1_10001.New(arg_2_0.uiItemsTf, arg_2_0.uiItemTf)
	UIItemList = var_1
	arg_2_0.uiGotList = var_1.New(arg_2_0.uiItemsGetTf, arg_2_0.uiGotItemTf)
	setText = var_1

	local var_2_0 = arg_2_0.uiText

	i18n = var_3

	var_1(var_2_0, var_3("island_sign_text"))

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	getProxy = var_1_10001
	ActivityTaskProxy = var_1_10002
	arg_3_0.actTaskProxy = var_1_10001(var_1_10002)
	underscore = var_1

	local var_3_0 = var_1.flatten
	local var_3_1 = arg_3_0.activity

	arg_3_0.taskGroup = var_3_0(var_2.getConfig(var_3_1, "config_data"))
	pg = var_1
	arg_3_0.taskConfig = var_1.task_data_template

	return
end

function var_0_1.UpdateTaskData(arg_4_0)
	local var_4_0 = arg_4_0.actTaskProxy

	arg_4_0.taskVOs = var_1.getTaskById(var_4_0, arg_4_0.activity.id)

	local var_4_1 = arg_4_0.actTaskProxy

	arg_4_0.finishTaksVOs = var_1.getFinishTaskById(var_4_1, arg_4_0.activity.id)
	arg_4_0.taskDic = {}
	_ = var_1

	var_1.each(arg_4_0.taskVOs, function(arg_5_0)
		arg_4_0.taskDic[arg_5_0.id] = arg_5_0

		return
	end)

	_ = var_1

	var_1.each(arg_4_0.finishTaksVOs, function(arg_6_0)
		arg_4_0.taskDic[arg_6_0.id] = arg_6_0

		return
	end)

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	local var_7_0 = arg_7_0.uilist

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 == var_2_10003.EventInit then
			local var_8_0 = arg_8_1 + 1
			local var_8_1 = arg_7_0.taskGroup[var_8_0]

			Drop = var_2_10005

			local var_8_2 = var_2_10005.Create(arg_7_0.taskConfig[var_8_1].award_display[1])
			local var_8_4

			if var_8_0 < 7 then
				local var_8_3 = arg_8_2

				var_8_4 = arg_8_2.Find(var_8_3, "item")
				updateDrop = var_8_3

				var_8_3(var_8_4, var_8_2)
			end

			onButton = var_8_4

			local var_8_5 = arg_7_0
			local var_8_6 = arg_8_2

			local function var_8_7()
				local var_9_0 = arg_7_0
				local var_9_1 = var_0.emit

				BaseUI = var_3_10002

				var_9_1(var_9_0, var_3_10002.ON_DROP, var_8_2)

				return
			end

			SFX_PANEL = var_2_10010

			var_8_4(var_8_5, var_8_6, var_8_7, var_2_10010)
		end

		return
	end)

	local var_7_1 = arg_7_0.uiGotList

	var_1.make(var_7_1, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_10_1 + 1
			local var_10_1 = arg_7_0.taskGroup[var_10_0]
			local var_10_2 = arg_7_0.taskDic[var_10_1]

			setActive = var_2_10006

			var_2_10006(arg_10_2:Find("get_bg"), var_10_2 and var_10_2:isOver())

			setActive = var_2_10006

			var_2_10006(arg_10_2:Find("tip"), var_10_2 and var_10_2:getTaskStatus() == 0 and not var_10_2:isOver())
		end

		return
	end)

	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.GetCanReceiveTaskList(var_7_2)

	setActive = var_7_2

	local var_7_4 = arg_7_0.uiGoBtn

	var_7_2(var_3.Find(var_7_4, "tip"), #var_7_3 > 0)

	onButton = var_7_2

	local var_7_5 = arg_7_0
	local var_7_6 = arg_7_0.uiGoBtn

	local function var_7_7()
		if arg_7_0.liveAreaPage == nil then
			local var_11_0 = arg_7_0

			MainLiveAreaPage = var_2_10001
			var_11_0.liveAreaPage = var_2_10001.New(arg_7_0._parentTf, arg_7_0.event)
		end

		local var_11_1 = arg_7_0.liveAreaPage

		var_0.ExecuteAction(var_11_1, "Show", true, function()
			local var_12_0 = arg_7_0

			if #var_0.GetCanReceiveTaskList(var_12_0) > 0 then
				local var_12_1 = arg_7_0
				local var_12_2 = var_1.emit

				ActivityMediator = var_3_10003

				var_12_2(var_12_1, var_3_10003.ON_ACTIVITY_TASK_LIST_SUBMIT, {
					activityId = arg_7_0.activity.id,
					ids = var_0
				})
			end

			return
		end)

		return
	end

	SFX_PANEL = var_1_10006

	var_7_2(var_7_5, var_7_6, var_7_7, var_1_10006)

	PlayerPrefs = var_7_2

	var_7_2.SetString("IslandSignPage", var_0_1.GetDate())

	return
end

function var_0_1.OnUpdateFlush(arg_13_0)
	arg_13_0:UpdateTaskData()

	local var_13_0 = arg_13_0.uilist

	var_1.align(var_13_0, #arg_13_0.taskGroup)

	local var_13_1 = arg_13_0.uiGotList

	var_1.align(var_13_1, #arg_13_0.taskGroup)

	local var_13_2 = arg_13_0
	local var_13_3 = arg_13_0.GetCanReceiveTaskList(var_13_2)

	setActive = var_13_2

	local var_13_4 = arg_13_0.uiGoBtn

	var_13_2(var_3.Find(var_13_4, "tip"), #var_13_3 > 0)

	return
end

function var_0_1.GetDate()
	pg = var_1_10000

	local var_14_0 = var_1_10000.TimeMgr.GetInstance()
	local var_14_1 = var_0.STimeDescC

	pg = var_1_10002

	local var_14_2 = var_1_10002.TimeMgr.GetInstance()

	return var_14_1(var_14_0, var_2.GetServerTime(var_14_2), "%Y/%m/%d")
end

function var_0_1.IsShowRed()
	return var_0_1.IsShowAwardRed()
end

function var_0_1.IsShowGoRed()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetString("IslandSignPage", "") ~= var_0_1.GetDate()
end

function var_0_1.IsShowAwardRed()
	getProxy = var_1_10000
	ActivityTaskProxy = var_1_10001

	local var_17_0 = var_1_10000(var_1_10001)
	local var_17_1 = var_0.getTaskById

	ActivityConst = var_1_10002

	local var_17_2 = var_17_1(var_17_0, var_1_10002.ISLAND_SIGN_ID)

	_ = var_17_0

	return var_17_0.any(var_17_2, function(arg_18_0)
		return arg_18_0:getTaskStatus() == 0
	end)
end

function var_0_1.GetCanReceiveTaskList(arg_19_0)
	getProxy = var_1_10001
	ActivityTaskProxy = var_1_10002

	local var_19_0 = var_1_10001(var_1_10002)
	local var_19_1 = var_1.getTaskById

	ActivityConst = var_1_10003

	local var_19_2 = var_19_1(var_19_0, var_1_10003.ISLAND_SIGN_ID)
	local var_19_3 = {}

	pairs = var_3

	for iter_19_0, iter_19_1 in var_3(var_19_2) do
		if iter_19_1:getTaskStatus() == 0 then
			table = var_8

			var_8.insert(var_19_3, iter_19_1.id)
		end
	end

	return var_19_3
end

function var_0_1.Destroy(arg_20_0)
	if arg_20_0.liveAreaPage then
		local var_20_0 = arg_20_0.liveAreaPage

		var_1.Destroy(var_20_0)

		arg_20_0.liveAreaPage = nil
	end

	var_0_1.super.Destroy(arg_20_0)

	return
end

function var_0_1.onBackPressed(arg_21_0)
	if arg_21_0.liveAreaPage then
		local var_21_0 = arg_21_0.liveAreaPage

		if var_1.GetLoaded(var_21_0) then
			local var_21_1 = arg_21_0.liveAreaPage

			if var_1.isShowing(var_21_1) then
				local var_21_2 = arg_21_0.liveAreaPage

				var_1.Hide(var_21_2)

				return true
			end
		end
	end

	return false
end

return var_0_1
