class = var_0_10000

local var_0_0 = "IslandGamePtTemplatePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_1.OnDataSetting(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.island_activity_pt_page
	local var_1_1 = arg_1_0.activity

	arg_1_0.config = var_1_0[var_2.getIslandConfig(var_1_1, "config_id")]
	getProxy = var_1
	ActivityProxy = var_1_10003

	local var_1_2 = var_1(var_1_10003)

	arg_1_0.targetActivity = var_1.getActivityById(var_1_2, arg_1_0.config.activity_id)

	arg_1_0:BuildAllTask()

	return
end

function var_0_1.BuildAllTask(arg_2_0)
	arg_2_0.taskList = {}
	_ = var_1

	var_1.each(arg_2_0.config.task_id, function(arg_3_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_3_0 = var_2_10001(var_2_10003)
		local var_3_1 = var_1.GetIsland(var_3_0)
		local var_3_2 = var_1.GetTaskAgency(var_3_1)
		local var_3_3

		if not var_1.GetTask(var_3_2, arg_3_0) then
			IslandTask = var_3_3
			var_3_3 = var_3_3.BuildFakeTask(arg_3_0)
		end

		table = var_2_10002

		var_2_10002.insert(arg_2_0.taskList, var_3_3)

		return
	end)

	return
end

function var_0_1.GetFirstUncompletedTaskIndex(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.taskList) do
		getProxy = var_1_10006
		IslandProxy = var_1_10008
		var_1_10008 = var_1_10006(var_1_10008)
		var_1_10008 = var_1_10006.GetIsland(var_1_10008)
		var_1_10008 = var_1_10006.GetTaskAgency(var_1_10008)

		if not var_1_10006.IsFinishTask(var_1_10008, iter_4_1.id) then
			return iter_4_0
		end
	end

	return 1
end

function var_0_1.GetAllAvailableTaskIds(arg_5_0)
	local var_5_0 = {}

	_ = var_1_10002

	var_1_10002.each(arg_5_0.taskList, function(arg_6_0)
		local var_6_0 = arg_6_0

		if arg_6_0.IsFinish(var_6_0) then
			getProxy = var_1
			IslandProxy = var_6_0

			local var_6_1 = var_1(var_6_0)
			local var_6_2 = var_1.GetIsland(var_6_1)
			local var_6_3 = var_1.GetTaskAgency(var_6_2)

			if not var_1.IsFinishTask(var_6_3, arg_6_0.id) then
				table = var_1

				var_1.insert(var_5_0, arg_6_0.id)
			end
		end

		return
	end)

	return var_5_0
end

function var_0_1.OnFirstFlush(arg_7_0)
	PlayerPrefs = var_1_10001

	var_1_10001.SetInt(var_0_1.GetTipKey(arg_7_0.activity.id), 1)

	setText = var_1

	local var_7_0 = arg_7_0.importGot
	local var_7_1 = var_3.Find(var_7_0, "Text")

	i18n = var_4

	var_1(var_7_1, var_4("island_activity_pt_got_all"))

	setText = var_1

	local var_7_2 = arg_7_0.scoreTipText

	i18n = var_4

	var_1(var_7_2, var_4("island_activity_pt_point"))

	setText = var_1

	local var_7_3 = arg_7_0.getText

	i18n = var_4

	var_1(var_7_3, var_4("island_activity_pt_get_oneclick"))

	onButton = var_1

	local var_7_4 = arg_7_0
	local var_7_5 = arg_7_0.getButton

	local function var_7_6()
		local var_8_0 = arg_7_0

		if #var_0.GetAllAvailableTaskIds(var_8_0) == 0 then
			return
		end

		local var_8_1 = arg_7_0
		local var_8_2 = var_1.emit

		IslandMediator = var_2_10004

		var_8_2(var_8_1, var_2_10004.ON_SUBMIT_TASK_ONE_STEP, var_0, function()
			local var_9_0 = arg_7_0

			var_0.OnUpdateFlush(var_9_0)

			return
		end)

		return
	end

	SFX_PANEL = var_6

	var_1(var_7_4, var_7_5, var_7_6, var_6)

	_ = var_1

	var_1.each(arg_7_0.config.btn_param, function(arg_10_0)
		if not arg_7_0[arg_10_0[1]] then
			errorMsg = var_2

			var_2("不存在节点或ItemList未绑定节点" .. arg_10_0[1])

			return
		end

		setText = var_2

		local var_10_0 = var_1:Find("Text")

		i18n = var_2_10005

		var_2(var_10_0, var_2_10005(arg_10_0[2]))

		onButton = var_2

		local var_10_1 = arg_7_0
		local var_10_2 = var_1

		local function var_10_3()
			local var_11_0 = arg_7_0
			local var_11_1 = var_0.emit

			IslandMediator = var_3_10003

			var_11_1(var_11_0, var_3_10003.OPEN_PAGE, arg_10_0[3][1], arg_10_0[3][2])

			return
		end

		SFX_PANEL = var_7

		var_2(var_10_1, var_10_2, var_10_3, var_7)

		local var_10_4 = arg_7_0
		local var_10_5 = var_2.CheckBtnSkip
		local var_10_6 = var_1
		local var_10_7

		if not arg_10_0[4] then
			var_10_7 = {}
		end

		var_10_5(var_10_4, var_10_6, var_10_7)

		return
	end)

	local var_7_7 = arg_7_0.taskRoot

	arg_7_0.scrollCom = var_1.GetComponent(var_7_7, "LScrollRect")

	function arg_7_0.scrollCom.onUpdateItem(arg_12_0, arg_12_1)
		local var_12_0 = arg_7_0
		local var_12_1 = var_2.UpdateTaskList
		local var_12_2 = arg_12_0

		tf = var_2_10006

		var_12_1(var_12_0, var_12_2, var_2_10006(arg_12_1))

		return
	end

	local var_7_8 = arg_7_0.scrollCom

	var_1.SetTotalCount(var_7_8, #arg_7_0.config.task_id)

	return
end

function var_0_1.CheckBtnSkip(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2[1]
	local var_13_1 = arg_13_2[2]

	if not var_13_0 then
		return true
	end

	switch = var_1_10005

	return var_1_10005(var_13_0, {
		function()
			local var_14_0 = var_13_1[1]

			getProxy = var_2_10001
			ActivityProxy = var_2_10003

			local var_14_1 = var_2_10001(var_2_10003)
			local var_14_2 = var_1.getActivityById(var_14_1, var_14_0)

			setActive = var_2_10002

			var_2_10002(arg_13_1, var_14_2 and not var_14_2:isEnd())

			return
		end
	}, function()
		assert = var_2_10000

		var_2_10000(false, "未定义的按钮拦截type: ", var_13_0)

		return
	end)
end

function var_0_1.GetShowPTCount(arg_16_0, arg_16_1)
	switch = var_1_10002

	return var_1_10002(arg_16_1, {
		function()
			return arg_16_0.targetActivity.data1
		end,
		function()
			return arg_16_0.targetActivity.data2
		end
	})
end

function var_0_1.OnUpdateFlush(arg_19_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_19_0 = var_1_10001(var_1_10003)

	arg_19_0.targetActivity = var_1.getActivityById(var_19_0, arg_19_0.config.activity_id)
	setText = var_1

	var_1(arg_19_0.scoreText, arg_19_0:GetShowPTCount(arg_19_0.config.point_type))

	local var_19_1 = arg_19_0:GetFirstUncompletedTaskIndex()

	onNextTick = var_1_10002

	var_1_10002(function()
		local var_20_0 = arg_19_0.scrollCom
		local var_20_1 = var_0.ScrollTo
		local var_20_2 = arg_19_0.scrollCom

		var_20_1(var_20_0, var_3.HeadIndexToValue(var_20_2, var_19_1 - 1))

		return
	end)

	local var_19_2 = #arg_19_0:GetAllAvailableTaskIds()
	local var_19_3 = 0 < var_19_2

	setActive = var_3

	local var_19_4 = arg_19_0.getButton

	var_3(var_5.Find(var_19_4, "red"), var_19_3)

	setGray = var_3

	var_3(arg_19_0.getButton, not var_19_3, true)
	arg_19_0:UpdateImport()

	return
end

function var_0_1.UpdateTaskList(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 + 1

	local var_21_0 = arg_21_0.config.task_id[arg_21_1]
	local var_21_1 = arg_21_0.taskList[arg_21_1]

	getProxy = var_1_10005
	IslandProxy = var_1_10007

	local var_21_2 = var_1_10005(var_1_10007)
	local var_21_3 = var_5.GetIsland(var_21_2)
	local var_21_4 = var_5.GetTaskAgency(var_21_3)
	local var_21_5 = var_5.IsFinishTask(var_21_4, var_21_0)
	local var_21_6 = var_21_1
	local var_21_7 = var_21_1.GetTargetList(var_21_6)[1]
	local var_21_8

	if var_21_1:IsFinish() then
		var_21_8 = not var_21_5
	end

	setText = var_21_6

	var_21_6(arg_21_2:Find("bg/name"), var_21_1:GetName())

	setText = var_21_6

	var_21_6(arg_21_2:Find("bg/count"), var_21_7:GetProgress() .. "/" .. var_21_7:GetTargetNum())

	setText = var_21_6

	var_21_6(arg_21_2:Find("bg/desc"), var_21_7:GetName())

	local var_21_9 = var_21_1
	local var_21_10 = var_21_1.GetAwards(var_21_9)
	local var_21_11 = arg_21_2:Find("bg/items")

	UIItemList = var_21_9

	var_21_9.StaticAlign(var_21_11, var_21_11:Find("IslandItemTpl"), #var_21_10, function(arg_22_0, arg_22_1, arg_22_2)
		UIItemList = var_2_10003

		if arg_22_0 == var_2_10003.EventUpdate then
			local var_22_0 = var_21_10[arg_22_1 + 1]

			updateCustomDrop = var_4

			var_4(arg_22_2, var_22_0)

			onButton = var_4

			local var_22_1 = arg_21_0
			local var_22_2 = arg_22_2

			local function var_22_3()
				local var_23_0 = arg_21_0
				local var_23_1 = var_0.emit

				IslandMediator = var_3_10003

				local var_23_2 = var_3_10003.SHOW_MSG_BOX
				local var_23_3 = {}

				i18n = var_3_10005
				var_23_3.title = var_3_10005("island_word_desc")
				IslandMsgBox = var_5
				var_23_3.type = var_5.TYPE_COMMON_DROP_DESCRIBE
				var_23_3.dropData = var_22_0

				var_23_1(var_23_0, var_23_2, var_23_3)

				return
			end

			SFX_PANEL = var_2_10009

			var_4(var_22_1, var_22_2, var_22_3, var_2_10009)
		end

		return
	end)

	setActive = var_10

	var_10(arg_21_2:Find("got"), var_21_5)

	setActive = var_10

	var_10(arg_21_2:Find("get"), var_21_8)

	setActive = var_10

	var_10(arg_21_2:Find("red"), var_21_8)

	onButton = var_10

	local var_21_12 = arg_21_0
	local var_21_13 = arg_21_2
	local var_21_14 = arg_21_2.Find(var_21_13, "get")

	local function var_21_15()
		local var_24_0 = arg_21_0
		local var_24_1 = var_0.emit

		IslandMediator = var_2_10003

		var_24_1(var_24_0, var_2_10003.ON_SUBMIT_TASK, var_21_0, function()
			local var_25_0 = arg_21_0

			var_0.OnUpdateFlush(var_25_0)

			return
		end)

		return
	end

	SFX_PANEL = var_21_13

	var_10(var_21_12, var_21_14, var_21_15, var_21_13)

	return
end

function var_0_1.GetAtlasName(arg_26_0)
	assert = var_1_10001

	var_1_10001(false, "override")

	return
end

function var_0_1.GetShowImportInfo(arg_27_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_27_0 = var_1_10001(var_1_10003)
	local var_27_1 = var_1.GetIsland(var_27_0)
	local var_27_2 = var_1.GetTaskAgency(var_27_1)
	local var_27_3 = arg_27_0.config.import

	ipairs = var_27_1

	for iter_27_0, iter_27_1 in var_27_1(var_27_3) do
		if not var_27_2:IsFinishTask(iter_27_1[1]) then
			return iter_27_0, false
		end
	end

	return #var_27_3, true
end

function var_0_1.UpdateImport(arg_28_0)
	local var_28_0 = arg_28_0
	local var_28_1, var_28_2 = arg_28_0.GetShowImportInfo(var_28_0)

	setActive = var_28_0

	var_28_0(arg_28_0.importGot, var_28_2)

	setImageAlpha = var_28_0

	var_28_0(arg_28_0.importIcon, var_28_2 and 0.6 or 1)

	local var_28_3 = arg_28_0.config.import[var_28_1]

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004(arg_28_0:GetAtlasName(), var_28_1, arg_28_0.importIcon, true)

	setText = var_1_10004

	local var_28_4 = arg_28_0.goTipText

	i18n = var_7

	var_1_10004(var_28_4, var_7(var_28_3[2]))

	IslandTask = var_1_10004

	local var_28_5 = var_1_10004.GetAwardsStatic(var_28_3[1])

	onButton = var_5

	local var_28_6 = arg_28_0
	local var_28_7 = arg_28_0.viewButton

	local function var_28_8()
		if not var_28_5[1] then
			return
		end

		local var_29_0 = arg_28_0
		local var_29_1 = var_0.emit

		IslandMediator = var_2_10003

		local var_29_2 = var_2_10003.SHOW_MSG_BOX
		local var_29_3 = {}

		i18n = var_2_10005
		var_29_3.title = var_2_10005("island_word_desc")
		IslandMsgBox = var_5
		var_29_3.type = var_5.TYPE_COMMON_DROP_DESCRIBE
		var_29_3.dropData = var_28_5[1]

		var_29_1(var_29_0, var_29_2, var_29_3)

		return
	end

	SFX_PANEL = var_1_10010

	var_5(var_28_6, var_28_7, var_28_8, var_1_10010)

	return
end

function var_0_1.OnDestroy(arg_30_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_30_0.scrollCom)

	bindComponent = var_1_10001

	var_1_10001(arg_30_0, arg_30_0._tf, true)

	return
end

function var_0_1.GetTipKey(arg_31_0)
	local var_31_0 = "island_game_pt_template_page_tip_"
	local var_31_1 = arg_31_0
	local var_31_2 = "_"

	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_31_3 = var_1_10004(var_1_10006)

	return var_31_0 .. var_31_1 .. var_31_2 .. var_4.getData(var_31_3).id
end

function var_0_1.ShouldFirstTip(arg_32_0)
	local var_32_0 = var_0_1.GetTipKey(arg_32_0)

	PlayerPrefs = var_1_10002

	return var_1_10002.GetInt(var_32_0, 0) == 0
end

return var_0_1
