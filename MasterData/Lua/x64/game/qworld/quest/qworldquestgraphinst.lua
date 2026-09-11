local QWorldQuestGraphInst = class("QWorldQuestGraphInst")

function QWorldQuestGraphInst:Ctor(arg_1_1)
	self.questId_ = arg_1_1
	self.events_ = {}
end

function QWorldQuestGraphInst:BindGraph(arg_2_1)
	self.graph_ = import(string.format("game.qworld.generated.quest.%s", arg_2_1))

	self:UpdateGraph()
end

function QWorldQuestGraphInst:UpdateGraph()
	self:UnbindEvents()

	local var_3_0 = QWorldQuestTool.GetQuestStatus(self.questId_)

	if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_UNMEET, "OnQuestUnmeet")
		self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_FINISH, "OnQuestFinish")
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
		self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_NOT_START, "OnQuestNotStart")
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
		self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_ACCOMPLISHED, "OnQuestAccomplished")
	end

	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_PROG_UPDATE, "OnQuestProgUpdate")
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_ENTER_ZONE, "OnEnterZone")
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_EXIT_ZONE, "OnExitZone")
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FINISH, "OnMiniGameFinish")
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FAIL, "OnMiniGameFail")
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, "OnBackMainHome", 0)
	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_RECEIVE_EVENT, "OnReceiveEvent")

	if self.graph_.OnClickBubble then
		self.OnClickBubble = {}

		local var_3_1

		if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			var_3_1 = bit.lshift(1, 0)
		elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
			var_3_1 = bit.lshift(1, 1)
		elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
			var_3_1 = bit.lshift(1, 2)
		end

		for iter_3_0, iter_3_1 in ipairs(self.graph_.OnClickBubble) do
			if bit.band(self.graph_.OnClickBubbleWhen[iter_3_1], var_3_1) ~= 0 then
				table.insert(self.OnClickBubble, iter_3_1)
			end
		end
	end

	self:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, "OnClickBubble")
end

function QWorldQuestGraphInst:UnbindEvents()
	for iter_4_0, iter_4_1 in pairs(self.events_) do
		QWorldQuestGraph:UnregisterQuestEventCallback(iter_4_1[1], iter_4_1[2], iter_4_1[3])
	end
end

function QWorldQuestGraphInst:BindGraphEvent(arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = self[arg_5_2] or self.graph_[arg_5_2]

	if type(var_5_0) == "table" then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			self:BindGraphEvent(arg_5_1, arg_5_2 .. "_" .. iter_5_1, iter_5_1)
		end

		return
	end

	if var_5_0 then
		arg_5_3 = arg_5_3 or self.questId_

		local function var_5_1(...)
			_GRAPH_API.cur_graph = self.graph_
			_GRAPH_API.cur_graph_inst = self

			var_5_0(self, ...)

			_GRAPH_API.cur_graph = nil
			_GRAPH_API.cur_graph_inst = nil
		end

		QWorldQuestGraph:RegisterQuestEventCallback(arg_5_1, arg_5_3, var_5_1)
		table.insert(self.events_, {
			arg_5_1,
			arg_5_3,
			var_5_1
		})
	end
end

function QWorldQuestGraphInst:GetTrackingEntityIdList(arg_7_1, arg_7_2)
	if SandplayTaskCfg[self.questId_].hide_task ~= 0 then
		return
	end

	if self.graph_.trackingEntityIdList then
		if arg_7_2 then
			table.insertto(arg_7_1, self.graph_.trackingEntityIdList)

			return
		end

		if QWorldQuestTool.GetQuestStatus(self.questId_) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			table.insertto(arg_7_1, self.graph_.trackingEntityIdList)
		end
	end
end

function QWorldQuestGraphInst:GetLocalVariable(arg_8_1)
	return (self.localVarTable_ or nil) and (self.localVarTable_[arg_8_1] or nil)
end

function QWorldQuestGraphInst:SetLocalVariable(arg_9_1, arg_9_2)
	local var_9_0 = self.localVarTable_

	if not self.localVarTable_ then
		var_9_0 = {}
		self.localVarTable_ = var_9_0
	end

	var_9_0[arg_9_1] = arg_9_2
end

function QWorldQuestGraphInst:GetQuestLocalProgress()
	return self:GetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS)
end

function QWorldQuestGraphInst:IncreaseQuestLocalProgress(arg_11_1)
	local var_11_0 = (self:GetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS) or 0) + arg_11_1

	self:SetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS, (self:GetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS) or 0) + arg_11_1)

	if var_11_0 >= SandplayTaskCfg[self.questId_].need then
		QWorldMgr:GetQWorldQuestMgr():QuestSetParam(self.questId_, self.questId_, var_11_0, nil)
	end

	QWorldMgr:GetQWorldQuestMgr():OnMainQuestUpdate(SandplayTaskCfg[self.questId_].main_task_id)
end

function QWorldQuestGraphInst:Dispose()
	self:UnbindEvents()

	self.events_ = nil
end

return QWorldQuestGraphInst
