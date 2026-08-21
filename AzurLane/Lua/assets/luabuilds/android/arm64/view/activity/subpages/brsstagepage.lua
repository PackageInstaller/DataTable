local var_0_0 = class("BRSStagePage", import("...base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("panel")

	setText(arg_1_0.bg:Find("hint"), i18n("brs_expedition_tip"))

	arg_1_0.chainTFList = {}
	arg_1_0.stageTFList = {}

	local var_1_0 = arg_1_0.bg:Find("stages")
	local var_1_1 = arg_1_0.bg:Find("progress_chain")

	for iter_1_0 = 1, 3 do
		table.insert(arg_1_0.stageTFList, var_1_0:Find("stage_" .. iter_1_0))
		table.insert(arg_1_0.chainTFList, var_1_1:Find("chain_mark_" .. iter_1_0))
	end

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	return
end

function var_0_0.flushTaskData(arg_3_0)
	arg_3_0._taskList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.activity:getConfig("config_client").task) do
		local var_3_0 = getProxy(TaskProxy):getTaskById(iter_3_1)

		var_3_0 = var_3_0 or getProxy(TaskProxy):getFinishTaskById(iter_3_1)

		table.insert(arg_3_0._taskList, var_3_0)
	end

	return
end

function var_0_0.OnFirstFlush(arg_4_0)
	local var_4_0 = arg_4_0.activity:getConfig("config_data")
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.activity.data2_list) do
		table.insert(var_4_1, arg_4_0.activity:GetEnemyDataByStageId(iter_4_1).id)
	end

	arg_4_0:flushTaskData()

	local var_4_2 = 1

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.stageTFList) do
		local var_4_3 = arg_4_0.activity:GetEnemyDataById(var_4_0[iter_4_2])

		setText(iter_4_3:Find("name/text"), var_4_3:getConfig("name"))
		setText(iter_4_3:Find("level"), var_4_3:getConfig("level"))

		local var_4_4 = iter_4_3:Find("award")
		local var_4_6 = arg_4_0._taskList[iter_4_2]:getConfig("award_display")[1]

		updateDrop(findTF(var_4_4, "mask"), {
			type = var_4_6[1],
			id = var_4_6[2],
			count = var_4_6[3]
		})

		local var_4_7 = var_4_5:getTaskStatus()

		setActive(var_4_4:Find("claimed"), var_4_5:getTaskStatus() == 2)
		onButton(arg_4_0, var_4_4, function()
			arg_4_0:emit(BaseUI.ON_DROP, var_0)

			return
		end)

		if var_4_3:GetPreChapterId() == 0 or table.contains(var_4_1, var_4_3:GetPreChapterId()) then
			setActive(iter_4_3:Find("lock"), false)
			onButton(arg_4_0, iter_4_3, function()
				arg_4_0.fleetEditPanel = arg_4_0:GetFleetEditPanel()

				arg_4_0.fleetEditPanel.buffer:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
				arg_4_0.fleetEditPanel.buffer:SetSettings(1, 0, var_4_3:GetExpeditionId(), SYSTEM_REWARD_PERFORM, arg_4_0.activity.configId)
				arg_4_0.fleetEditPanel.buffer:UpdateView()
				arg_4_0.fleetEditPanel.buffer:Show()

				return
			end)
			setActive(arg_4_0.chainTFList[iter_4_2]:Find("finish"), true)
			setActive(arg_4_0.chainTFList[iter_4_2]:Find("unfinish"), false)

			local var_4_8 = iter_4_3:Find("name/text")

			var_4_8:GetComponent(typeof(Text)).color = Color.white
			var_4_2 = iter_4_2
		else
			setActive(arg_4_0.chainTFList[iter_4_2]:Find("finish"), false)
			setActive(arg_4_0.chainTFList[iter_4_2]:Find("unfinish"), true)
			setActive(iter_4_3:Find("lock"), true)
		end
	end

	triggerToggle(arg_4_0.stageTFList[var_4_2]:Find("bg"), true)

	if #arg_4_0.activity.data2_list == 0 then
		pg.NewStoryMgr.GetInstance():Play(arg_4_0.activity:getConfig("config_client").story[1][1])
	end

	return
end

function var_0_0.GetFleetEditPanel(arg_7_0)
	if not arg_7_0.fleetEditPanel then
		arg_7_0.fleetEditPanel = BossSingleBattleFleetSelectSubPanelLite.New(arg_7_0)

		arg_7_0.fleetEditPanel:Load()
	end

	return arg_7_0.fleetEditPanel
end

function var_0_0.OnUpdateFlush(arg_8_0)
	arg_8_0:flushTaskData()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._taskList) do
		local var_8_0 = iter_8_1:getTaskStatus()

		setActive(arg_8_0.stageTFList[iter_8_0]:Find("award/claimed"), var_8_0 == 2)

		if iter_8_0 == 3 then
			if var_8_0 == 1 then
				local var_8_1 = pg.NewStoryMgr.GetInstance()
				local var_8_2 = arg_8_0.activity:getConfig("config_client").story[2][1]
				local var_8_3 = arg_8_0.activity:getConfig("config_client").story[3][1]
				local var_8_4 = var_8_1:StoryName2StoryId(var_8_2)
				local var_8_5 = var_8_1:StoryName2StoryId(var_8_3)

				if not var_8_1:IsPlayed(var_8_2) then
					arg_8_0:emit(ActivityMediator.GO_PERFORM_COMBAT, {
						stageId = var_8_4
					})
				elseif not var_8_1:IsPlayed(var_8_3) then
					arg_8_0:emit(ActivityMediator.GO_PERFORM_COMBAT, {
						stageId = var_8_5
					})
				else
					arg_8_0:emit(ActivityMediator.ON_TASK_SUBMIT, iter_8_1)
				end
			end
		elseif var_8_0 == 1 then
			arg_8_0:emit(ActivityMediator.ON_TASK_SUBMIT, iter_8_1)
		end
	end

	return
end

function var_0_0.OnDestroy(arg_9_0)
	if arg_9_0.fleetEditPanel then
		arg_9_0.fleetEditPanel:OnHide()
	end

	return
end

return var_0_0
