class = var_0_10000

local var_0_0 = "IslandSeasonTaskPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSeasonTaskPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "content")

	arg_2_0.getAllBtn = var_1.Find(var_2_1, "get_all")
	setText = var_2

	local var_2_2 = arg_2_0.getAllBtn
	local var_2_3 = var_3.Find(var_2_2, "Text")

	i18n = var_2_2

	var_2(var_2_3, var_2_2("island_season_task_collectall"))

	local var_2_4 = var_1
	local var_2_5 = var_1.Find(var_2_4, "tpl")

	setActive = var_2_4

	var_2_4(var_2_5, false)

	local var_2_6 = var_1:Find("view")

	arg_2_0.scrollCom = var_3.GetComponent(var_2_6, "LScrollRect")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getAllBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		IslandMediator = var_2_10002

		var_4_1(var_4_0, var_2_10002.ON_SUBMIT_TASK_ONE_STEP, arg_3_0.canSubmitIds)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	function arg_3_0.scrollCom.onUpdateItem(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0
		local var_5_1 = var_2.UpdateTask
		local var_5_2 = arg_5_0

		tf = var_2_10005

		var_5_1(var_5_0, var_5_2, var_2_10005(arg_5_1))

		return
	end

	return
end

function var_0_1.UpdateTask(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2.name = arg_6_0.taskIds[arg_6_1 + 1]
	setText = var_4

	local var_6_0 = arg_6_2
	local var_6_1 = arg_6_2.Find(var_6_0, "get/Text")

	i18n = var_6_0

	var_4(var_6_1, var_6_0("island_season_task_collect"))

	setText = var_4

	local var_6_2 = arg_6_2
	local var_6_3 = arg_6_2.Find(var_6_2, "got/Text")

	i18n = var_6_2

	var_4(var_6_3, var_6_2("island_season_task_collected"))

	local var_6_4 = arg_6_0.taskVODic[var_3]

	pg = var_6_3

	local var_6_5 = var_6_3.island_task[var_3]

	setText = var_6

	var_6(arg_6_2:Find("desc"), var_6_5.task_desc)

	setText = var_6

	var_6(arg_6_2:Find("name"), var_6_5.name)

	IslandTask = var_6

	local var_6_6 = var_6.GetAwardsStatic(var_3)

	UIItemList = var_7

	var_7.StaticAlign(arg_6_2:Find("awards"), arg_6_2:Find("awards/tpl"), #var_6_6, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventUpdate then
			updateCustomDrop = var_3

			var_3(arg_7_2, var_6_6[arg_7_1 + 1], {
				style = "island"
			})

			onButton = var_3

			var_3(arg_6_0, arg_7_2, function()
				local var_8_0 = arg_6_0.contextData
				local var_8_1 = var_0.ShowMsgBox
				local var_8_2 = {}

				i18n = var_3_10003
				var_8_2.title = var_3_10003("island_word_desc")
				IslandMsgBox = var_3
				var_8_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
				var_8_2.dropData = var_6_6[arg_7_1 + 1]

				var_8_1(var_8_0, var_8_2)

				return
			end)
		end

		return
	end)

	pg = var_7

	local var_6_7 = var_7.island_task_target[var_6_5.target_id[1]].target_num

	if var_6_4 then
		local var_6_8 = var_6_4

		var_6_8 = var_6_4.GetTargetList(var_6_8)[1]

		local var_6_9

		if not var_8.GetProgress(var_6_8) then
			var_6_9 = var_6_7
		end

		setText = var_6_8

		var_6_8(arg_6_2:Find("progress"), var_6_9 .. "/" .. var_6_7)

		setActive = var_6_8

		var_6_8(arg_6_2:Find("get_bg"), var_6_4 and var_6_4:IsFinish())

		setActive = var_6_8

		local var_6_10 = arg_6_2:Find("get")
		local var_6_11

		if var_6_4 and var_6_4:IsSubmitOnUI() then
			var_6_11 = var_6_4:IsFinish()
		end

		var_6_8(var_6_10, var_6_11)

		setActive = var_6_8

		var_6_8(arg_6_2:Find("got"), not var_6_4)

		onButton = var_6_8

		local var_6_12 = arg_6_0
		local var_6_13 = arg_6_2:Find("get")

		local function var_6_14()
			local var_9_0 = arg_6_0
			local var_9_1 = var_0.emit

			IslandMediator = var_2_10002

			var_9_1(var_9_0, var_2_10002.ON_SUBMIT_TASK, var_6_4.id)

			return
		end

		SFX_PANEL = var_13

		var_6_8(var_6_12, var_6_13, var_6_14, var_13)

		return
	end
end

function var_0_1.Show(arg_10_0)
	arg_10_0.super.Show(arg_10_0)
	arg_10_0:Flush()

	IslandGuideChecker = var_1

	var_1.CheckGuide("ISLAND_GUIDE_16")

	return
end

function var_0_1.Flush(arg_11_0)
	local var_11_0 = arg_11_0.contextData.season

	arg_11_0.taskIds = var_1.GetTaskIds(var_11_0)
	arg_11_0.taskVODic = {}
	getProxy = var_1
	IslandProxy = var_11_0

	local var_11_1 = var_1(var_11_0)
	local var_11_2 = var_1.GetIsland(var_11_1)
	local var_11_3 = var_1.GetTaskAgency(var_11_2)

	ipairs = var_11_2

	local var_11_4 = arg_11_0.contextData.season

	for iter_11_0, iter_11_1 in var_11_2(var_3.GetTaskIds(var_11_4)) do
		if var_11_3:GetTask(iter_11_1) then
			arg_11_0.taskVODic[iter_11_1] = var_7
		end
	end

	table = var_2

	local var_11_5 = var_2.sort
	local var_11_6 = arg_11_0.taskIds

	CompareFuncs = var_4

	var_11_5(var_11_6, var_4({
		function(arg_12_0)
			local var_12_1

			if arg_11_0.taskVODic[arg_12_0] then
				local var_12_0 = arg_11_0.taskVODic[arg_12_0]

				if var_1.IsFinish(var_12_0) then
					var_12_1 = 0

					goto label_12_0
				end
			end

			var_12_1 = 1

			::label_12_0::

			return var_12_1
		end,
		function(arg_13_0)
			return arg_11_0.taskVODic[arg_13_0] and 0 or 1
		end,
		function(arg_14_0)
			return arg_14_0
		end
	}))

	local var_11_7 = arg_11_0.scrollCom

	var_2.SetTotalCount(var_11_7, #arg_11_0.taskIds, -1)

	underscore = var_2
	arg_11_0.canSubmitIds = var_2.select(arg_11_0.taskIds, function(arg_15_0)
		local var_15_2

		if arg_11_0.taskVODic[arg_15_0] then
			local var_15_0 = arg_11_0.taskVODic[arg_15_0]

			if var_1.IsSubmitOnUI(var_15_0) then
				local var_15_1 = arg_11_0.taskVODic[arg_15_0]

				var_15_2 = var_1.IsFinish(var_15_1)
			end
		end

		return var_15_2
	end)
	setActive = var_2

	var_2(arg_11_0.getAllBtn, #arg_11_0.canSubmitIds > 0)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_16_0.scrollCom)

	return
end

return var_0_1
