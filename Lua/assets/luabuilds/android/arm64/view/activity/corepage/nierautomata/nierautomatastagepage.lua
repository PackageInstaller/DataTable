local var_0_0 = class("NieRAutomataStagePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("panel")
	arg_1_0.chainTFList = {}
	arg_1_0.stageTFList = {}

	local var_1_0 = arg_1_0.bg:Find("stages")
	local var_1_1 = arg_1_0.bg:Find("progress_chain")

	for iter_1_0 = 1, 2 do
		table.insert(arg_1_0.stageTFList, var_1_0:Find("stage_" .. iter_1_0))
		table.insert(arg_1_0.chainTFList, var_1_1:Find("chain_mark_" .. iter_1_0))
	end

	table.insert(arg_1_0.stageTFList, var_1_0:Find("stage_3"))

	return
end

function var_0_0.flushTaskData(arg_2_0)
	arg_2_0._taskList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.activity:getConfig("config_client").task) do
		local var_2_0 = getProxy(TaskProxy):getTaskById(iter_2_1)

		var_2_0 = var_2_0 or getProxy(TaskProxy):getFinishTaskById(iter_2_1)

		table.insert(arg_2_0._taskList, var_2_0)
	end

	return
end

function var_0_0.GetClearEnemyList(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.activity.data2_list) do
		table.insert({}, arg_3_0.activity:GetEnemyDataByStageId(iter_3_1).id)
	end

	return {}
end

function var_0_0.IsStageUnlock(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_1:GetPreChapterId() == 0 or table.contains(arg_4_2, arg_4_1:GetPreChapterId())
end

function var_0_0.UpdateAwardState(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2:Find("award")

	if not arg_5_0._taskList[arg_5_1] then
		return
	end

	local var_5_1 = arg_5_0._taskList[arg_5_1]:getConfig("award_display")[1]
	local var_5_2 = var_5_0:Find("got")

	updateDrop(findTF(var_5_0, "mask"), {
		type = var_5_1[1],
		id = var_5_1[2],
		count = var_5_1[3]
	})
	setActive(var_5_0:Find("bg"), arg_5_3)

	if var_5_2 then
		setActive(var_5_2, arg_5_3 and arg_5_0._taskList[arg_5_1]:getTaskStatus() == 2)
	end

	onButton(arg_5_0, var_5_0, function()
		arg_5_0:emit(BaseUI.ON_DROP, var_0)

		return
	end)

	return
end

function var_0_0.RefreshAwardStates(arg_7_0)
	local var_7_0 = arg_7_0.activity:getConfig("config_data")
	local var_7_1 = arg_7_0:GetClearEnemyList()

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.stageTFList) do
		arg_7_0:UpdateAwardState(iter_7_0, iter_7_1, arg_7_0:IsStageUnlock(arg_7_0.activity:GetEnemyDataById(var_7_0[iter_7_0]), var_7_1))
	end

	return
end

function var_0_0.OnFirstFlush(arg_8_0)
	local var_8_0 = arg_8_0.activity:getConfig("config_data")
	local var_8_1 = arg_8_0:GetClearEnemyList()

	arg_8_0:flushTaskData()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.stageTFList) do
		local var_8_3 = arg_8_0.activity:GetEnemyDataById(var_8_0[iter_8_0])

		setText(iter_8_1:Find("name/text"), var_8_3:getConfig("name"))

		local var_8_4 = arg_8_0:IsStageUnlock(var_8_3, var_8_1)

		arg_8_0:UpdateAwardState(iter_8_0, iter_8_1, var_8_4)

		if var_8_4 then
			setActive(iter_8_1:Find("lock"), false)
			onButton(arg_8_0, iter_8_1, function()
				arg_8_0.fleetEditPanel = arg_8_0:GetFleetEditPanel()

				arg_8_0.fleetEditPanel.buffer:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
				arg_8_0.fleetEditPanel.buffer:SetSettings(1, 0, var_8_3:GetExpeditionId(), SYSTEM_REWARD_PERFORM, arg_8_0.activity.configId)
				arg_8_0.fleetEditPanel.buffer:UpdateView()
				arg_8_0.fleetEditPanel.buffer:Show()

				return
			end)

			if arg_8_0.chainTFList[iter_8_0] then
				arg_8_0:setChianMark(iter_8_0, true)
			end
		else
			if arg_8_0.chainTFList[iter_8_0] then
				arg_8_0:setChianMark(iter_8_0, false)
			end

			setActive(iter_8_1:Find("lock"), true)
		end
	end

	return
end

function var_0_0.GetFleetEditPanel(arg_10_0)
	if not arg_10_0.fleetEditPanel then
		arg_10_0.fleetEditPanel = BossSingleBattleFleetSelectSubPanelLite.New(arg_10_0)

		arg_10_0.fleetEditPanel:Load()
	end

	return arg_10_0.fleetEditPanel
end

function var_0_0.setChianMark(arg_11_0, arg_11_1, arg_11_2)
	setActive(arg_11_0.chainTFList[arg_11_1]:Find("finish"), arg_11_2)
	setActive(arg_11_0.chainTFList[arg_11_1]:Find("unfinish"), not arg_11_2)

	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	arg_12_0:flushTaskData()
	arg_12_0:RefreshAwardStates()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._taskList) do
		if iter_12_1:getTaskStatus() == 1 then
			arg_12_0:emit(ActivityMediator.ON_TASK_SUBMIT, iter_12_1, function()
				arg_12_0:flushTaskData()
				arg_12_0:RefreshAwardStates()

				return
			end)
		end
	end

	return
end

function var_0_0.OnDestroy(arg_14_0)
	if arg_14_0.fleetEditPanel then
		arg_14_0.fleetEditPanel:OnHide()
	end

	return
end

return var_0_0
