return {
	Init = function(self)
		self.questMap = {}

		for iter_1_0, iter_1_1 in pairs(QuanzhouPhaseCfg.get_id_list_by_task_id) do
			if QuanzhouPhaseCfg[iter_1_1[1]] then
				self.questMap[QuanzhouPhaseCfg[iter_1_1[1]].task_id] = QuanzhouPhaseCfg[iter_1_1[1]].id
			end
		end

		self.alreadyPopTask = {}
		self.entity = nil
		self.isInit = true

		self:AddListener()
	end,
	AddListener = function(self)
		self.questHandle = handler(self, self.OnQuestGraphStart)

		manager.notify:RegistListener(QWORLD_ON_QUEST_GRAPH_START, self.questHandle)

		self.destroyHandle = handler(self, self.OnDisposeLua)

		manager.notify:RegistListener(ON_DESTROY_LUA, function()
			self:OnDisposeLua()
		end)
	end,
	RemoveListener = function(self)
		manager.notify:RemoveListener(QWORLD_ON_QUEST_GRAPH_START, self.questHandle)
		manager.notify:RemoveListener(ON_DESTROY_LUA, self.destroyHandle)
	end,
	OnDisposeLua = function(self)
		self:Dispose()
	end,
	OnQuestGraphStart = function(self, arg_6_1)
		if self.questMap[arg_6_1] then
			if self.alreadyPopTask[arg_6_1] then
				return
			end

			self.alreadyPopTask[arg_6_1] = true

			self:Show()
		end
	end,
	Process = function(self)
		for iter_7_0, iter_7_1 in pairs(self.questMap) do
			if QWorldQuestTool.GetQuestStatus(iter_7_0) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
				if self.alreadyPopTask[iter_7_0] then
					return
				end

				self.alreadyPopTask[iter_7_0] = true

				self:Show()

				return
			end
		end
	end,
	Show = function(self)
		self.entity = self.entity or QWorldQuanzhouPhaseView.New()

		self.entity:SetData()
		self.entity:Show()
		QWorldUIHide()
	end,
	Hide = function(self)
		if self.entity then
			self.entity:Hide()
			self.entity:Dispose()

			self.entity = nil
		end

		QWorldUIShow()
	end,
	Dispose = function(self)
		self.isInit = false

		if self.entity then
			self.entity:Dispose()

			self.entity = nil
		end
	end
}
