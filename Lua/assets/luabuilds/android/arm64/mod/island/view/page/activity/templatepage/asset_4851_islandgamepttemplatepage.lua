local IslandGamePtTemplatePage = class("IslandGamePtTemplatePage", import("Mod.Island.View.page.activity.IslandBaseActivityPage"))

function IslandGamePtTemplatePage:OnDataSetting()
	self.config = pg.island_activity_pt_page[self.activity:getIslandConfig("config_id")]
	self.targetActivity = getProxy(ActivityProxy):getActivityById(self.config.activity_id)

	self:BuildAllTask()

	return
end

function IslandGamePtTemplatePage:BuildAllTask()
	self.taskList = {}

	_.each(self.config.task_id, function(arg_3_0)
		local var_3_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency():GetTask(arg_3_0)

		var_3_0 = var_3_0 or IslandTask.BuildFakeTask(arg_3_0)

		table.insert(self.taskList, var_3_0)

		return
	end)

	return
end

function IslandGamePtTemplatePage:GetFirstUncompletedTaskIndex()
	for iter_4_0, iter_4_1 in ipairs(self.taskList) do
		if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(iter_4_1.id) then
			return iter_4_0
		end
	end

	return 1
end

function IslandGamePtTemplatePage:GetAllAvailableTaskIds()
	local var_5_0 = {}

	_.each(self.taskList, function(arg_6_0)
		if arg_6_0:IsFinish() then
			if not getProxy(IslandProxy):GetIsland():GetTaskAgency():IsFinishTask(arg_6_0.id) then
				table.insert(var_5_0, arg_6_0.id)
			end
		end

		return
	end)

	return var_5_0
end

function IslandGamePtTemplatePage:OnFirstFlush()
	PlayerPrefs.SetInt(IslandGamePtTemplatePage.GetTipKey(self.activity.id), 1)
	setText(self.importGot:Find("Text"), i18n("island_activity_pt_got_all"))
	setText(self.scoreTipText, i18n("island_activity_pt_point"))
	setText(self.getText, i18n("island_activity_pt_get_oneclick"))
	onButton(self, self.getButton, function()
		local var_8_0 = self:GetAllAvailableTaskIds()

		if #var_8_0 == 0 then
			return
		end

		self:emit(IslandMediator.ON_SUBMIT_TASK_ONE_STEP, var_8_0, function()
			self:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)
	_.each(self.config.btn_param, function(arg_10_0)
		if not self[arg_10_0[1]] then
			errorMsg("不存在节点或ItemList未绑定节点" .. arg_10_0[1])

			return
		end

		setText(self[arg_10_0[1]]:Find("Text"), i18n(arg_10_0[2]))
		onButton(self, self[arg_10_0[1]], function()
			self:emit(IslandMediator.OPEN_PAGE, arg_10_0[3][1], arg_10_0[3][2])

			return
		end, SFX_PANEL)
		self:CheckBtnSkip(self[arg_10_0[1]], arg_10_0[4] or {})

		return
	end)

	self.scrollCom = self.taskRoot:GetComponent("LScrollRect")

	function self.scrollCom.onUpdateItem(arg_12_0, arg_12_1)
		self:UpdateTaskList(arg_12_0, tf(arg_12_1))

		return
	end

	self.scrollCom:SetTotalCount(#self.config.task_id)

	return
end

function IslandGamePtTemplatePage:CheckBtnSkip(arg_13_1, arg_13_2)
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

function IslandGamePtTemplatePage:GetShowPTCount(arg_16_1)
	return switch(arg_16_1, {
		function()
			return self.targetActivity.data1
		end,
		function()
			return self.targetActivity.data2
		end
	})
end

function IslandGamePtTemplatePage:OnUpdateFlush()
	self.targetActivity = getProxy(ActivityProxy):getActivityById(self.config.activity_id)

	setText(self.scoreText, self:GetShowPTCount(self.config.point_type))

	local var_19_0 = self:GetFirstUncompletedTaskIndex()

	onNextTick(function()
		self.scrollCom:ScrollTo(self.scrollCom:HeadIndexToValue(var_19_0 - 1))

		return
	end)

	local var_19_1 = #self:GetAllAvailableTaskIds() > 0

	setActive(self.getButton:Find("red"), var_19_1)
	setGray(self.getButton, not var_19_1, true)
	self:UpdateImport()

	return
end

function IslandGamePtTemplatePage:UpdateTaskList(arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 + 1

	local var_21_0 = self.config.task_id[arg_21_1]
	local var_21_1 = getProxy(IslandProxy):GetIsland():GetTaskAgency()
	local var_21_2 = var_21_1:IsFinishTask(self.config.task_id[arg_21_1])
	local var_21_3 = self.taskList[arg_21_1]:GetTargetList()[1]
	local var_21_4 = self.taskList[arg_21_1]:IsFinish()

	if var_21_1 then
		var_21_4 = not var_21_2
	end

	setText(arg_21_2:Find("bg/name"), self.taskList[arg_21_1]:GetName())
	setText(arg_21_2:Find("bg/count"), var_21_3:GetProgress() .. "/" .. var_21_3:GetTargetNum())
	setText(arg_21_2:Find("bg/desc"), var_21_3:GetName())

	local var_21_5 = self.taskList[arg_21_1]:GetAwards()
	local var_21_6 = arg_21_2:Find("bg/items")

	UIItemList.StaticAlign(var_21_6, var_21_6:Find("IslandItemTpl"), #var_21_5, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = var_21_5[arg_22_1 + 1]

			updateCustomDrop(arg_22_2, var_21_5[arg_22_1 + 1])
			onButton(self, arg_22_2, function()
				self:emit(IslandMediator.SHOW_MSG_BOX, {
					title = i18n("island_word_desc"),
					type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
					dropData = var_22_0
				})

				return
			end, SFX_PANEL)
		end

		return
	end)
	setActive(arg_21_2:Find("got"), var_21_2)
	setActive(arg_21_2:Find("get"), var_21_4)
	setActive(arg_21_2:Find("red"), var_21_4)
	onButton(self, arg_21_2:Find("get"), function()
		self:emit(IslandMediator.ON_SUBMIT_TASK, var_21_0, function()
			self:OnUpdateFlush()

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function IslandGamePtTemplatePage:GetAtlasName()
	assert(false, "override")

	return
end

function IslandGamePtTemplatePage:GetShowImportInfo()
	local var_27_0 = getProxy(IslandProxy):GetIsland():GetTaskAgency()

	for iter_27_0, iter_27_1 in ipairs(self.config.import) do
		if not var_27_0:IsFinishTask(iter_27_1[1]) then
			return iter_27_0, false
		end
	end

	return #self.config.import, true
end

function IslandGamePtTemplatePage:UpdateImport()
	local var_28_0, var_28_1 = self:GetShowImportInfo()

	setActive(self.importGot, var_28_1)
	setImageAlpha(self.importIcon, var_28_1 and 0.6 or 1)
	GetImageSpriteFromAtlasAsync(self:GetAtlasName(), var_28_0, self.importIcon, true)
	setText(self.goTipText, i18n(self.config.import[var_28_0][2]))

	local var_28_2 = IslandTask.GetAwardsStatic(self.config.import[var_28_0][1])

	onButton(self, self.viewButton, function()
		if not var_28_2[1] then
			return
		end

		self:emit(IslandMediator.SHOW_MSG_BOX, {
			title = i18n("island_word_desc"),
			type = IslandMsgBox.TYPE_COMMON_DROP_DESCRIBE,
			dropData = var_28_2[1]
		})

		return
	end, SFX_PANEL)

	return
end

function IslandGamePtTemplatePage:OnDestroy()
	ClearLScrollrect(self.scrollCom)
	bindComponent(self, self._tf, true)

	return
end

function IslandGamePtTemplatePage:GetTipKey()
	return "island_game_pt_template_page_tip_" .. self .. "_" .. getProxy(PlayerProxy):getData().id
end

function IslandGamePtTemplatePage:ShouldFirstTip()
	return PlayerPrefs.GetInt(IslandGamePtTemplatePage.GetTipKey(self), 0) == 0
end

return IslandGamePtTemplatePage
