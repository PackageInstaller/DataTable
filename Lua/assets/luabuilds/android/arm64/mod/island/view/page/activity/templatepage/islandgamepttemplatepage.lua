local var_0_0 = class("IslandGamePtTemplatePage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function var_0_0.OnDataSetting(arg_1_0)
	arg_1_0.config = pg.island_activity_pt_page[arg_1_0.activity:getIslandConfig("config_id")]
	arg_1_0.targetActivity = getProxy(ActivityProxy):getActivityById(arg_1_0.config.activity_id)

	arg_1_0:BuildAllTask()

	return
end

function var_0_0.BuildAllTask(arg_2_0)
	arg_2_0.taskList = {}

	_.each(arg_2_0.config.task_id, function(arg_3_0)
		local var_3_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(arg_3_0)

		var_3_0 = var_3_0 or IslandTask.BuildFakeTask(arg_3_0)

		table.insert(arg_2_0.taskList, var_3_0)

		return
	end)

	return
end

function var_0_0.GetFirstUncompletedTaskIndex(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.taskList) do
		local var_4_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

		if not var_4_0:IsFinishTask(iter_4_1.id) then
			return iter_4_0
		end
	end

	return 1
end

function var_0_0.GetAllAvailableTaskIds(arg_5_0)
	local var_5_0 = {}

	_.each(arg_5_0.taskList, function(arg_6_0)
		if arg_6_0:IsFinish() then
			if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(arg_6_0.id) then
				table.insert(var_5_0, arg_6_0.id)
			end
		end

		return
	end)

	return {}
end

function var_0_0.OnFirstFlush(arg_7_0)
	PlayerPrefs.SetInt(var_0_0.GetTipKey(arg_7_0.activity.id), 1)
	setText(arg_7_0.importGot:Find("Text"), i18n("island_activity_pt_got_all"))
	setText(arg_7_0.scoreTipText, i18n("island_activity_pt_point"))
	setText(arg_7_0.getText, i18n("island_activity_pt_get_oneclick"))
	onButton(arg_7_0, arg_7_0.getButton, function()
		local var_8_0 = arg_7_0:GetAllAvailableTaskIds()

		if #var_8_0 == 0 then
			return
		end

		arg_7_0:emit(IslandMediator.ON_SUBMIT_TASK_ONE_STEP, var_8_0, function()
			arg_7_0:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)
	_.each(arg_7_0.config.btn_param, function(arg_10_0)
		if not arg_7_0[arg_10_0[1]] then
			errorMsg("不存在节点或ItemList未绑定节点" .. arg_10_0[1])

			return
		end

		setText(arg_7_0[arg_10_0[1]]:Find("Text"), i18n(arg_10_0[2]))
		onButton(arg_7_0, arg_7_0[arg_10_0[1]], function()
			arg_7_0:emit(IslandMediator.OPEN_PAGE, arg_10_0[3][1], arg_10_0[3][2])

			return
		end, SFX_PANEL)

		local var_10_0 = arg_10_0[4] or {}

		arg_7_0:CheckBtnSkip(arg_7_0[arg_10_0[1]], var_10_0)

		return
	end)

	arg_7_0.scrollCom = arg_7_0.taskRoot:GetComponent("LScrollRect")

	function arg_7_0.scrollCom.onUpdateItem(arg_12_0, arg_12_1)
		arg_7_0:UpdateTaskList(arg_12_0, tf(arg_12_1))

		return
	end

	arg_7_0.scrollCom:SetTotalCount(#arg_7_0.config.task_id)

	return
end

function var_0_0.CheckBtnSkip(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_2[1]
	local var_13_1 = arg_13_2[2]

	if not arg_13_2[1] then
		return true
	end

	return switch(arg_13_2[1], {
		function()
			local var_14_0 = getProxy(ActivityProxy):getActivityById(var_13_1[1])

			setActive(arg_13_1, var_14_0 and not var_14_0:isEnd())

			return
		end
	}, function()
		assert(false, "未定义的按钮拦截type: ", var_13_0)

		return
	end)
end

function var_0_0.GetShowPTCount(arg_16_0, arg_16_1)
	return switch(arg_16_1, {
		function()
			return arg_16_0.targetActivity.data1
		end,
		function()
			return arg_16_0.targetActivity.data2
		end
	})
end

function var_0_0.OnUpdateFlush(arg_19_0)
	arg_19_0.targetActivity = getProxy(ActivityProxy):getActivityById(arg_19_0.config.activity_id)

	setText(arg_19_0.scoreText, arg_19_0:GetShowPTCount(arg_19_0.config.point_type))

	local var_19_0 = arg_19_0:GetFirstUncompletedTaskIndex()

	onNextTick(function()
		arg_19_0.scrollCom:ScrollTo(arg_19_0.scrollCom:HeadIndexToValue(var_19_0 - 1))

		return
	end)

	local var_19_1 = #arg_19_0:GetAllAvailableTaskIds() > 0

	setActive(arg_19_0.getButton:Find("red"), var_19_1)
	setGray(arg_19_0.getButton, not var_19_1, true)
	arg_19_0:UpdateImport()

	return
end

function var_0_0.UpdateTaskList(arg_21_0, arg_21_1, arg_21_2)
	local var_21_9000

	arg_21_1 = arg_21_1 + 1

	local var_21_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()
	local var_21_1 = var_21_0.IsFinishTask(var_21_9000, arg_21_0.config.task_id[arg_21_1])
	local var_21_2 = arg_21_0.taskList[arg_21_1]:GetTargetList()[1]
	local var_21_3 = arg_21_0.taskList[arg_21_1]:IsFinish()

	if var_21_0 then
		var_21_3 = not var_21_1
	end

	setText(arg_21_2:Find("bg/name"), arg_21_0.taskList[arg_21_1]:GetName())
	setText(arg_21_2:Find("bg/count"), var_21_2:GetProgress() .. "/" .. var_21_2:GetTargetNum())
	setText(arg_21_2:Find("bg/desc"), var_21_2:GetName())

	local var_21_4 = arg_21_2:Find("bg/items")

	UIItemList.StaticAlign(var_21_4, var_21_4:Find("IslandItemTpl"), #arg_21_0.taskList[arg_21_1]:GetAwards(), function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			updateCustomDrop(arg_22_2, var_0[arg_22_1 + 1])
			onButton(arg_21_0, arg_22_2, function()
				arg_21_0:emit(IslandMediator.SHOW_MSG_BOX, {
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_0
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	setActive(arg_21_2:Find("got"), var_21_1)
	setActive(arg_21_2:Find("get"), var_21_3)
	setActive(arg_21_2:Find("red"), var_21_3)
	onButton(arg_21_0, arg_21_2:Find("get"), function()
		arg_21_0:emit(IslandMediator.ON_SUBMIT_TASK, var_0, function()
			arg_21_0:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetAtlasName(arg_26_0)
	assert(false, "override")

	return
end

function var_0_0.GetShowImportInfo(arg_27_0)
	local var_27_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.config.import) do
		if not var_27_0:IsFinishTask(iter_27_1[1]) then
			return iter_27_0, false
		end
	end

	return #arg_27_0.config.import, true
end

function var_0_0.UpdateImport(arg_28_0)
	local var_28_0, var_28_1 = arg_28_0:GetShowImportInfo()

	setActive(arg_28_0.importGot, var_28_1)
	setImageAlpha(arg_28_0.importIcon, var_28_1 and 0.6 or 1)
	GetImageSpriteFromAtlasAsync(arg_28_0:GetAtlasName(), var_28_0, arg_28_0.importIcon, true)
	setText(arg_28_0.goTipText, i18n(arg_28_0.config.import[var_28_0][2]))

	local var_28_2 = IslandTask.GetAwardsStatic(arg_28_0.config.import[var_28_0][1])

	onButton(arg_28_0, arg_28_0.viewButton, function()
		if not var_28_2[1] then
			return
		end

		arg_28_0:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_28_2[1]
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_30_0)
	ClearLScrollrect(arg_30_0.scrollCom)
	bindComponent(arg_30_0, arg_30_0._tf, true)

	return
end

function var_0_0.GetTipKey(arg_31_0)
	return "island_game_pt_template_page_tip_" .. arg_31_0 .. "_" .. getProxy(PlayerProxy):getData().id
end

function var_0_0.ShouldFirstTip(arg_32_0)
	return PlayerPrefs.GetInt(var_0_0.GetTipKey(arg_32_0), 0) == 0
end

return var_0_0
