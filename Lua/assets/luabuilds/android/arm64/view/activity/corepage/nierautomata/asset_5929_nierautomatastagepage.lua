local NieRAutomataStagePage = class("NieRAutomataStagePage", import("view.activity.CorePage.CoreActivityPage"))

function NieRAutomataStagePage:OnInit()
	self.bg = self._tf:Find("panel")
	self.chainTFList = {}
	self.stageTFList = {}

	local var_1_0 = self.bg:Find("stages")
	local var_1_1 = self.bg:Find("progress_chain")

	for iter_1_0 = 1, 2 do
		table.insert(self.stageTFList, var_1_0:Find("stage_" .. iter_1_0))
		table.insert(self.chainTFList, var_1_1:Find("chain_mark_" .. iter_1_0))
	end

	table.insert(self.stageTFList, var_1_0:Find("stage_3"))

	return
end

function NieRAutomataStagePage:flushTaskData()
	self._taskList = {}

	for iter_2_0, iter_2_1 in ipairs(self.activity:getConfig("config_client").task) do
		local var_2_0 = getProxy(TaskProxy):getTaskById(iter_2_1)

		var_2_0 = var_2_0 or getProxy(TaskProxy):getFinishTaskById(iter_2_1)

		table.insert(self._taskList, var_2_0)
	end

	return
end

function NieRAutomataStagePage:GetClearEnemyList()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.activity.data2_list) do
		table.insert(var_3_0, self.activity:GetEnemyDataByStageId(iter_3_1).id)
	end

	return var_3_0
end

function NieRAutomataStagePage:IsStageUnlock(arg_4_1, arg_4_2)
	return arg_4_1:GetPreChapterId() == 0 or table.contains(arg_4_2, arg_4_1:GetPreChapterId())
end

function NieRAutomataStagePage:UpdateAwardState(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2:Find("award")

	if not self._taskList[arg_5_1] then
		return
	end

	local var_5_1 = self._taskList[arg_5_1]:getConfig("award_display")[1]
	local var_5_2 = {
		type = var_5_1[1],
		id = var_5_1[2],
		count = var_5_1[3]
	}
	local var_5_3 = var_5_0:Find("got")

	updateDrop(findTF(var_5_0, "mask"), var_5_2)
	setActive(var_5_0:Find("bg"), arg_5_3)

	if var_5_3 then
		setActive(var_5_3, arg_5_3 and self._taskList[arg_5_1]:getTaskStatus() == 2)
	end

	onButton(self, var_5_0, function()
		self:emit(BaseUI.ON_DROP, var_5_2)

		return
	end)

	return
end

function NieRAutomataStagePage:RefreshAwardStates()
	local var_7_0 = self.activity:getConfig("config_data")
	local var_7_1 = self:GetClearEnemyList()

	for iter_7_0, iter_7_1 in ipairs(self.stageTFList) do
		self:UpdateAwardState(iter_7_0, iter_7_1, self:IsStageUnlock(self.activity:GetEnemyDataById(var_7_0[iter_7_0]), var_7_1))
	end

	return
end

function NieRAutomataStagePage:OnFirstFlush()
	local var_8_0 = self.activity:getConfig("config_data")
	local var_8_1 = self:GetClearEnemyList()

	self:flushTaskData()

	for iter_8_0, iter_8_1 in ipairs(self.stageTFList) do
		local var_8_3 = self.activity:GetEnemyDataById(var_8_0[iter_8_0])

		setText(iter_8_1:Find("name/text"), var_8_3:getConfig("name"))

		local var_8_4 = self:IsStageUnlock(var_8_3, var_8_1)

		self:UpdateAwardState(iter_8_0, iter_8_1, var_8_4)

		if var_8_4 then
			setActive(iter_8_1:Find("lock"), false)
			onButton(self, iter_8_1, function()
				self.fleetEditPanel = self:GetFleetEditPanel()

				self.fleetEditPanel.buffer:SetFleets((getProxy(FleetProxy):GetRegularFleets()))
				self.fleetEditPanel.buffer:SetSettings(1, 0, var_8_3:GetExpeditionId(), SYSTEM_REWARD_PERFORM, self.activity.configId)
				self.fleetEditPanel.buffer:UpdateView()
				self.fleetEditPanel.buffer:Show()

				return
			end)

			if self.chainTFList[iter_8_0] then
				self:setChianMark(iter_8_0, true)
			end
		else
			if self.chainTFList[iter_8_0] then
				self:setChianMark(iter_8_0, false)
			end

			setActive(iter_8_1:Find("lock"), true)
		end
	end

	return
end

function NieRAutomataStagePage:GetFleetEditPanel()
	if not self.fleetEditPanel then
		self.fleetEditPanel = BossSingleBattleFleetSelectSubPanelLite.New(self)

		self.fleetEditPanel:Load()
	end

	return self.fleetEditPanel
end

function NieRAutomataStagePage:setChianMark(arg_11_1, arg_11_2)
	setActive(self.chainTFList[arg_11_1]:Find("finish"), arg_11_2)
	setActive(self.chainTFList[arg_11_1]:Find("unfinish"), not arg_11_2)

	return
end

function NieRAutomataStagePage:OnUpdateFlush()
	self:flushTaskData()
	self:RefreshAwardStates()

	for iter_12_0, iter_12_1 in ipairs(self._taskList) do
		if iter_12_1:getTaskStatus() == 1 then
			self:emit(ActivityMediator.ON_TASK_SUBMIT, iter_12_1, function()
				self:flushTaskData()
				self:RefreshAwardStates()

				return
			end)
		end
	end

	return
end

function NieRAutomataStagePage:OnDestroy()
	if self.fleetEditPanel then
		self.fleetEditPanel:OnHide()
	end

	return
end

return NieRAutomataStagePage
