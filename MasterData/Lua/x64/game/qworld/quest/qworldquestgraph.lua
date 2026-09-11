local var_0_0 = {}
local QWorldQuestGraphApi = import("game.qworld.quest.QWorldQuestGraphApi")
local QWorldQuestGraphInst = import("game.qworld.quest.QWorldQuestGraphInst")

function var_0_0:Init()
	self.graphCallback_ = {}
	self.questGraph_ = {}

	QWorldQuestGraphApi.Init()

	self.onEntityEnterZone_ = handler(self, self._OnEntityEnterZone)
	self.onEntityExitZone_ = handler(self, self._OnEntityExitZone)
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone + self.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone + self.onEntityExitZone_
	self.entityBubbleQuests_ = {}
	self.questLastStatus_ = {}
	self.timers_ = {}
end

function var_0_0:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.timers_) do
		if iter_2_1:IsRunning() then
			iter_2_1:Stop()
		end
	end

	self.timers_ = nil
	self.questLastStatus_ = nil
	self.entityBubbleQuests_ = nil
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone - self.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone - self.onEntityExitZone_
	self.onEntityEnterZone_ = nil
	self.onEntityExitZone_ = nil

	QWorldQuestGraphApi.Clear()

	for iter_2_2, iter_2_3 in pairs(self.questGraph_) do
		iter_2_3:Dispose()
	end

	self.graphCallback_ = nil
	self.questGraph_ = nil
end

function var_0_0:UpdateQuestGraph(arg_3_1)
	local var_3_0 = QWorldQuestTool.GetQuestStatus(arg_3_1)
	local var_3_1 = self.questLastStatus_[arg_3_1]

	if self.questLastStatus_[arg_3_1] == var_3_0 then
		return
	end

	self.questLastStatus_[arg_3_1] = var_3_0

	if (not var_3_1 or var_3_1 == QWorldQuestConst.QUEST_STATUS.NOT_START) and var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		manager.notify:Invoke(QWORLD_ON_QUEST_GRAPH_START, arg_3_1)
	end

	local var_3_2 = SandplayTaskCfg[arg_3_1]

	if SandplayTaskCfg[arg_3_1].task_blueprint_sign == QWorldQuestConst.TASK_BLUEPRINT_TAG.NO_GRAPH then
		return
	end

	if var_3_1 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS and var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_FINISH, arg_3_1)
	end

	if var_3_0 ~= QWorldQuestConst.QUEST_STATUS.IN_PROGRESS and var_3_2.task_blueprint_sign ~= QWorldQuestConst.TASK_BLUEPRINT_TAG.ALWAYS_RUN_GRAPH then
		if var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
			QWorldQuestGraph:DestroyQuestGraph(arg_3_1)
		end

		return
	end

	if self.questGraph_[arg_3_1] then
		self:_RemoveGraphBubbles(arg_3_1)
		self.questGraph_[arg_3_1]:UpdateGraph()
	else
		local var_3_3 = QWorldQuestGraphInst.New(arg_3_1)

		self.questGraph_[arg_3_1] = var_3_3

		var_3_3:BindGraph(string.format("quest_%d", arg_3_1))
	end

	self:_InsertGraphBubbles(arg_3_1)

	if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		self:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_UNMEET, arg_3_1)
		QWorldMgr:GetQWorldQuestMgr():_OnUpdateMapQuestInfoWrapped(arg_3_1)
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
		self:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_NOT_START, arg_3_1)
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
		self:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_ACCOMPLISHED, arg_3_1)
	end
end

function var_0_0:DestroyQuestGraph(arg_4_1)
	if self.questGraph_[arg_4_1] then
		QWorldMgr:GetQWorldQuestMgr():_OnUpdateMapQuestInfoWrapped(arg_4_1)
		self:_RemoveGraphBubbles(arg_4_1)
		self.questGraph_[arg_4_1]:Dispose()

		self.questGraph_[arg_4_1] = nil
	end
end

function var_0_0:DispatchQuestEvent(arg_5_1, arg_5_2, ...)
	if self.graphCallback_[arg_5_1] then
		if self.graphCallback_[arg_5_1][arg_5_2] then
			for iter_5_0, iter_5_1 in ipairs(self.graphCallback_[arg_5_1][arg_5_2]) do
				iter_5_1(...)
			end

			return true
		end
	end

	return false
end

function var_0_0:HasQuestEvent(arg_6_1, arg_6_2, ...)
	if self.graphCallback_[arg_6_1] and self.graphCallback_[arg_6_1][arg_6_2] then
		return true
	end

	return false
end

function var_0_0:RegisterQuestEventCallback(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = self.graphCallback_[arg_7_1] or {}
	local var_7_1 = var_7_0[arg_7_2] or {}

	table.insert(var_7_1, arg_7_3)

	var_7_0[arg_7_2] = var_7_1
	self.graphCallback_[arg_7_1] = var_7_0
end

function var_0_0:UnregisterQuestEventCallback(arg_8_1, arg_8_2, arg_8_3)
	if self.graphCallback_[arg_8_1] then
		if self.graphCallback_[arg_8_1][arg_8_2] then
			table.removebyvalue(self.graphCallback_[arg_8_1][arg_8_2], arg_8_3)

			if #self.graphCallback_[arg_8_1][arg_8_2] == 0 then
				self.graphCallback_[arg_8_1][arg_8_2] = nil
			end
		end

		if table.isEmpty(self.graphCallback_[arg_8_1]) then
			self.graphCallback_[arg_8_1] = nil
		end
	end
end

function var_0_0:GetTrackingEntityIdList(arg_9_1, arg_9_2)
	if self.questGraph_[arg_9_1] then
		self.questGraph_[arg_9_1]:GetTrackingEntityIdList(arg_9_2)
	end
end

function var_0_0:GetTrackingEntityIdListRaw(arg_10_1, arg_10_2)
	if self.questGraph_[arg_10_1] then
		self.questGraph_[arg_10_1]:GetTrackingEntityIdList(arg_10_2, true)
	end
end

function var_0_0:GetEntityBubbleQuests(arg_11_1)
	return self.entityBubbleQuests_[arg_11_1]
end

function var_0_0:StartTimer(arg_12_1)
	table.insert(self.timers_, arg_12_1)
	arg_12_1:Start()

	while #self.timers_ - 1 > 0 do
		if not self.timers_[#self.timers_ - 1]:IsRunning() then
			self.timers_[#self.timers_ - 1]:Stop()
			table.remove(self.timers_, #self.timers_ - 1)
		end
	end
end

function var_0_0:GetQuestLocalProgress(arg_13_1)
	if not self.questGraph_[arg_13_1] then
		return nil
	end

	return self.questGraph_[arg_13_1]:GetQuestLocalProgress()
end

function var_0_0:IncreaseQuestLocalProgress(arg_14_1, arg_14_2)
	if self.questGraph_[arg_14_1] then
		self.questGraph_[arg_14_1]:IncreaseQuestLocalProgress(arg_14_2)
	end
end

function var_0_0:_InsertGraphBubbles(arg_15_1)
	if self.questGraph_[arg_15_1].OnClickBubble then
		for iter_15_0, iter_15_1 in ipairs(self.questGraph_[arg_15_1].OnClickBubble) do
			local var_15_0 = self.entityBubbleQuests_[iter_15_1] or {}

			table.insert(var_15_0, arg_15_1)

			self.entityBubbleQuests_[iter_15_1] = var_15_0
		end
	end
end

function var_0_0:_RemoveGraphBubbles(arg_16_1)
	if self.questGraph_[arg_16_1].OnClickBubble then
		for iter_16_0, iter_16_1 in ipairs(self.questGraph_[arg_16_1].OnClickBubble) do
			table.removebyvalue(self.entityBubbleQuests_[iter_16_1], arg_16_1)

			if #self.entityBubbleQuests_[iter_16_1] == 0 then
				self.entityBubbleQuests_[iter_16_1] = nil
			end
		end
	end
end

function var_0_0:_OnEntityEnterZone(arg_17_1, arg_17_2)
	self:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_ENTER_ZONE, arg_17_1)
end

function var_0_0:_OnEntityExitZone(arg_18_1, arg_18_2)
	self:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_EXIT_ZONE, arg_18_1)
end

return var_0_0
