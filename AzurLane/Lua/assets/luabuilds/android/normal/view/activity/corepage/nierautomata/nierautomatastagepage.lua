class = var_0_10000

local var_0_0 = "NieRAutomataStagePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CoreActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "panel")
	arg_1_0.chainTFList = {}
	arg_1_0.stageTFList = {}

	local var_1_1 = arg_1_0.bg
	local var_1_2 = var_1.Find(var_1_1, "stages")
	local var_1_3 = arg_1_0.bg
	local var_1_4 = var_2.Find(var_1_3, "progress_chain")

	for iter_1_0 = 1, 2 do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.stageTFList, var_1_2:Find("stage_" .. iter_1_0))

		table = var_1_10007

		var_1_10007.insert(arg_1_0.chainTFList, var_1_4:Find("chain_mark_" .. iter_1_0))
	end

	table = var_3

	var_3.insert(arg_1_0.stageTFList, var_1_2:Find("stage_3"))

	return
end

function var_0_1.flushTaskData(arg_2_0)
	arg_2_0._taskList = {}

	local var_2_0 = arg_2_0.activity
	local var_2_1 = var_1.getConfig(var_2_0, "config_client").task

	ipairs = var_2_0

	for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
		getProxy = var_1_10007
		TaskProxy = var_1_10008
		var_1_10008 = var_1_10007(var_1_10008)

		if not var_1_10007.getTaskById(var_1_10008, iter_2_1) then
			getProxy = var_1_10008
			TaskProxy = var_9

			local var_2_2 = var_1_10008(var_9)

			var_1_10007 = var_1_10008.getFinishTaskById(var_2_2, iter_2_1)
		end

		table = var_1_10008

		var_1_10008.insert(arg_2_0._taskList, var_1_10007)
	end

	return
end

function var_0_1.GetClearEnemyList(arg_3_0)
	local var_3_0 = {}

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.activity.data2_list) do
		table = var_1_10007
		var_1_10007 = var_1_10007.insert

		local var_3_1 = var_3_0
		local var_3_2 = arg_3_0.activity

		var_1_10007(var_3_1, var_9.GetEnemyDataByStageId(var_3_2, iter_3_1).id)
	end

	return var_3_0
end

function var_0_1.IsStageUnlock(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if arg_4_1:GetPreChapterId() ~= 0 then
		table = var_3
		var_4_0 = var_3.contains(arg_4_2, arg_4_1:GetPreChapterId())

		if false then
			var_4_0 = false
		end
	else
		var_4_0 = true
	end

	return var_4_0
end

function var_0_1.UpdateAwardState(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2:Find("award")

	if not arg_5_0._taskList[arg_5_1] then
		return
	end

	local var_5_1 = var_5:getConfig("award_display")[1]
	local var_5_2 = {
		type = var_5_1[1],
		id = var_5_1[2],
		count = var_5_1[3]
	}
	local var_5_3 = var_5_0:Find("bg")
	local var_5_4 = var_5_0:Find("got")
	local var_5_5 = var_5
	local var_5_6 = var_5.getTaskStatus(var_5_5)

	updateDrop = var_5_5
	findTF = var_1_10012

	var_5_5(var_1_10012(var_5_0, "mask"), var_5_2)

	setActive = var_5_5

	var_5_5(var_5_3, arg_5_3)

	if var_5_4 then
		setActive = var_5_5

		var_5_5(var_5_4, arg_5_3 and var_5_6 == 2)
	end

	onButton = var_5_5

	var_5_5(arg_5_0, var_5_0, function()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.emit

		BaseUI = var_2_10002

		var_6_1(var_6_0, var_2_10002.ON_DROP, var_5_2)

		return
	end)

	return
end

function var_0_1.RefreshAwardStates(arg_7_0)
	local var_7_0 = arg_7_0.activity
	local var_7_1 = var_1.getConfig(var_7_0, "config_data")
	local var_7_2 = arg_7_0
	local var_7_3 = arg_7_0.GetClearEnemyList(var_7_2)

	ipairs = var_7_2

	for iter_7_0, iter_7_1 in var_7_2(arg_7_0.stageTFList) do
		local var_7_4 = arg_7_0.activity
		local var_7_5 = var_8.GetEnemyDataById(var_7_4, var_7_1[iter_7_0])

		arg_7_0:UpdateAwardState(iter_7_0, iter_7_1, arg_7_0:IsStageUnlock(var_7_5, var_7_3))
	end

	return
end

function var_0_1.OnFirstFlush(arg_8_0)
	local var_8_0 = arg_8_0.activity
	local var_8_1 = var_1.getConfig(var_8_0, "config_data")
	local var_8_2 = arg_8_0:GetClearEnemyList()
	local var_8_3 = arg_8_0

	arg_8_0.flushTaskData(var_8_3)

	local var_8_4 = 1

	ipairs = var_8_3

	for iter_8_0, iter_8_1 in var_8_3(arg_8_0.stageTFList) do
		local var_8_5 = arg_8_0.activity
		local var_8_6 = var_9.GetEnemyDataById(var_8_5, var_8_1[iter_8_0])

		setText = var_8_5

		var_8_5(iter_8_1:Find("name/text"), var_8_6:getConfig("name"))

		local var_8_7 = arg_8_0:IsStageUnlock(var_8_6, var_8_2)

		arg_8_0:UpdateAwardState(iter_8_0, iter_8_1, var_8_7)

		if var_8_7 then
			setActive = var_11

			var_11(iter_8_1:Find("lock"), false)

			onButton = var_11

			var_11(arg_8_0, iter_8_1, function()
				local var_9_0 = arg_8_0
				local var_9_1 = arg_8_0

				var_9_0.fleetEditPanel = var_1.GetFleetEditPanel(var_9_1)
				getProxy = var_9_0
				FleetProxy = var_1

				local var_9_2 = var_9_0(var_1)
				local var_9_3 = var_0.GetRegularFleets(var_9_2)
				local var_9_4 = arg_8_0.fleetEditPanel.buffer

				var_2.SetFleets(var_9_4, var_9_3)

				local var_9_5 = arg_8_0.fleetEditPanel.buffer
				local var_9_6 = var_2.SetSettings
				local var_9_7 = 1
				local var_9_8 = 0
				local var_9_9 = var_8_6
				local var_9_10 = var_6.GetExpeditionId(var_9_9)

				SYSTEM_REWARD_PERFORM = var_9_9

				var_9_6(var_9_5, var_9_7, var_9_8, var_9_10, var_9_9, arg_8_0.activity.configId)

				local var_9_11 = arg_8_0.fleetEditPanel.buffer

				var_2.UpdateView(var_9_11)

				local var_9_12 = arg_8_0.fleetEditPanel.buffer

				var_2.Show(var_9_12)

				return
			end)

			if arg_8_0.chainTFList[iter_8_0] then
				arg_8_0:setChianMark(iter_8_0, true)
			end

			local var_8_8 = iter_8_0
		else
			if arg_8_0.chainTFList[iter_8_0] then
				arg_8_0:setChianMark(iter_8_0, false)
			end

			setActive = var_11

			var_11(iter_8_1:Find("lock"), true)
		end
	end

	return
end

function var_0_1.GetFleetEditPanel(arg_10_0)
	if not arg_10_0.fleetEditPanel then
		BossSingleBattleFleetSelectSubPanelLite = var_1
		arg_10_0.fleetEditPanel = var_1.New(arg_10_0)

		local var_10_0 = arg_10_0.fleetEditPanel

		var_1.Load(var_10_0)
	end

	return arg_10_0.fleetEditPanel
end

function var_0_1.setChianMark(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.chainTFList[arg_11_1]

	setActive = var_1_10004

	var_1_10004(var_11_0:Find("finish"), arg_11_2)

	setActive = var_1_10004

	var_1_10004(var_11_0:Find("unfinish"), not arg_11_2)

	return
end

function var_0_1.OnUpdateFlush(arg_12_0)
	arg_12_0:flushTaskData()
	arg_12_0:RefreshAwardStates()

	ipairs = var_1

	for iter_12_0, iter_12_1 in var_1(arg_12_0._taskList) do
		if iter_12_1:getTaskStatus() == 1 then
			local var_12_0 = arg_12_0
			local var_12_1 = arg_12_0.emit

			ActivityMediator = var_1_10009

			var_12_1(var_12_0, var_1_10009.ON_TASK_SUBMIT, iter_12_1, function()
				local var_13_0 = arg_12_0

				var_0.flushTaskData(var_13_0)

				local var_13_1 = arg_12_0

				var_0.RefreshAwardStates(var_13_1)

				return
			end)
		end
	end

	return
end

function var_0_1.OnDestroy(arg_14_0)
	if arg_14_0.fleetEditPanel then
		local var_14_0 = arg_14_0.fleetEditPanel

		var_1.OnHide(var_14_0)
	end

	return
end

return var_0_1
