local BRSStagePage = class("BRSStagePage", import("...base.BaseActivityPage"))

function BRSStagePage:OnInit()
	self.bg = self._tf:Find("panel")

	setText(self.bg:Find("hint"), i18n("brs_expedition_tip"))

	self.chainTFList = {}
	self.stageTFList = {}

	local var_1_0 = self.bg:Find("stages")
	local var_1_1 = self.bg:Find("progress_chain")

	for iter_1_0 = 1, 3 do
		table.insert(self.stageTFList, var_1_0:Find("stage_" .. iter_1_0))
		table.insert(self.chainTFList, var_1_1:Find("chain_mark_" .. iter_1_0))
	end

	return
end

function BRSStagePage:OnDataSetting()
	return
end

function BRSStagePage:flushTaskData()
	self._taskList = {}

	for iter_3_0, iter_3_1 in ipairs(self.activity:getConfig("config_client").task) do
		local var_3_0 = getProxy(TaskProxy):getTaskById(iter_3_1)

		var_3_0 = var_3_0 or getProxy(TaskProxy):getFinishTaskById(iter_3_1)

		table.insert(self._taskList, var_3_0)
	end

	return
end

function BRSStagePage:OnFirstFlush()
	local var_4_0 = self.activity:getConfig("config_data")
	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(self.activity.data2_list) do
		table.insert(var_4_1, self.activity:GetEnemyDataByStageId(iter_4_1).id)
	end

	self:flushTaskData()

	local var_4_2 = 1

	for iter_4_2, iter_4_3 in ipairs(self.stageTFList) do
		local var_4_3 = self.activity:GetEnemyDataById(var_4_0[iter_4_2])

		setText(iter_4_3:Find("name/text"), var_4_3:getConfig("name"))
		setText(iter_4_3:Find("level"), var_4_3:getConfig("level"))

		local var_4_4 = iter_4_3:Find("award")
		local var_4_5 = self._taskList[iter_4_2]
		local var_4_6 = self._taskList[iter_4_2]:getConfig("award_display")[1]
		local var_4_7 = {
			type = var_4_6[1],
			id = var_4_6[2],
			count = var_4_6[3]
		}

		updateDrop(findTF(var_4_4, "mask"), var_4_7)

		local var_4_8 = var_4_5:getTaskStatus()

		setActive(var_4_4:Find("claimed"), var_4_5:getTaskStatus() == 2)
		onButton(self, var_4_4, function()
			self:emit(BaseUI.ON_DROP, var_4_7)

			return
		end)

		if var_4_3:GetPreChapterId() == 0 or table.contains(var_4_1, var_4_3:GetPreChapterId()) then
			setActive(iter_4_3:Find("lock"), false)
			onButton(self, iter_4_3, function()
				self.fleetEditPanel = self:GetFleetEditPanel()

				self.fleetEditPanel.buffer:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
				self.fleetEditPanel.buffer:SetSettings(1, 0, var_4_3:GetExpeditionId(), SYSTEM_REWARD_PERFORM, self.activity.configId)
				self.fleetEditPanel.buffer:UpdateView()
				self.fleetEditPanel.buffer:Show()

				return
			end)
			setActive(self.chainTFList[iter_4_2]:Find("finish"), true)
			setActive(self.chainTFList[iter_4_2]:Find("unfinish"), false)

			iter_4_3:Find("name/text"):GetComponent(typeof(Text)).color = Color.white
			var_4_2 = iter_4_2
		else
			setActive(self.chainTFList[iter_4_2]:Find("finish"), false)
			setActive(self.chainTFList[iter_4_2]:Find("unfinish"), true)
			setActive(iter_4_3:Find("lock"), true)
		end
	end

	triggerToggle(self.stageTFList[var_4_2]:Find("bg"), true)

	if #self.activity.data2_list == 0 then
		pg.NewStoryMgr.GetInstance():Play(self.activity:getConfig("config_client").story[1][1])
	end

	return
end

function BRSStagePage:GetFleetEditPanel()
	if not self.fleetEditPanel then
		self.fleetEditPanel = BossSingleBattleFleetSelectSubPanelLite.New(self)

		self.fleetEditPanel:Load()
	end

	return self.fleetEditPanel
end

function BRSStagePage:OnUpdateFlush()
	self:flushTaskData()

	for iter_8_0, iter_8_1 in ipairs(self._taskList) do
		local var_8_0 = iter_8_1:getTaskStatus()

		setActive(self.stageTFList[iter_8_0]:Find("award/claimed"), var_8_0 == 2)

		if iter_8_0 == 3 then
			if var_8_0 == 1 then
				local var_8_1 = pg.NewStoryMgr.GetInstance()
				local var_8_2 = self.activity:getConfig("config_client").story[2][1]
				local var_8_3 = self.activity:getConfig("config_client").story[3][1]
				local var_8_4 = var_8_1:StoryName2StoryId(var_8_2)
				local var_8_5 = var_8_1:StoryName2StoryId(var_8_3)

				if not var_8_1:IsPlayed(var_8_2) then
					self:emit(ActivityMediator.GO_PERFORM_COMBAT, {
						stageId = var_8_4
					})
				elseif not var_8_1:IsPlayed(var_8_3) then
					self:emit(ActivityMediator.GO_PERFORM_COMBAT, {
						stageId = var_8_5
					})
				else
					self:emit(ActivityMediator.ON_TASK_SUBMIT, iter_8_1)
				end
			end
		elseif var_8_0 == 1 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, iter_8_1)
		end
	end

	return
end

function BRSStagePage:OnDestroy()
	if self.fleetEditPanel then
		self.fleetEditPanel:OnHide()
	end

	return
end

return BRSStagePage
