local var_0_0 = class("QWorldQuestGraphInst")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.questId_ = arg_1_1
	arg_1_0.events_ = {}
end

function var_0_0.BindGraph(arg_2_0, arg_2_1)
	arg_2_0.graph_ = import(string.format("game.qworld.generated.quest.%s", arg_2_1))

	arg_2_0:UpdateGraph()
end

function var_0_0.UpdateGraph(arg_3_0)
	arg_3_0:UnbindEvents()

	local var_3_0 = QWorldQuestTool.GetQuestStatus(arg_3_0.questId_)

	if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_UNMEET, "OnQuestUnmeet")
		arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_FINISH, "OnQuestFinish")
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
		arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_NOT_START, "OnQuestNotStart")
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
		arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_ACCOMPLISHED, "OnQuestAccomplished")
	end

	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_PROG_UPDATE, "OnQuestProgUpdate")
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_ENTER_ZONE, "OnEnterZone")
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_EXIT_ZONE, "OnExitZone")
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FINISH, "OnMiniGameFinish")
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FAIL, "OnMiniGameFail")
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, "OnBackMainHome", 0)
	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_RECEIVE_EVENT, "OnReceiveEvent")

	if arg_3_0.graph_.OnClickBubble then
		arg_3_0.OnClickBubble = {}

		local var_3_1

		if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			var_3_1 = bit.lshift(1, 0)
		elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
			var_3_1 = bit.lshift(1, 1)
		elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
			var_3_1 = bit.lshift(1, 2)
		end

		for iter_3_0, iter_3_1 in ipairs(arg_3_0.graph_.OnClickBubble) do
			local var_3_2 = arg_3_0.graph_.OnClickBubbleWhen[iter_3_1]

			if bit.band(var_3_2, var_3_1) ~= 0 then
				table.insert(arg_3_0.OnClickBubble, iter_3_1)
			end
		end
	end

	arg_3_0:BindGraphEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, "OnClickBubble")
end

function var_0_0.UnbindEvents(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.events_) do
		QWorldQuestGraph:UnregisterQuestEventCallback(iter_4_1[1], iter_4_1[2], iter_4_1[3])
	end
end

function var_0_0.BindGraphEvent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0[arg_5_2] or arg_5_0.graph_[arg_5_2]

	if type(var_5_0) == "table" then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			arg_5_0:BindGraphEvent(arg_5_1, arg_5_2 .. "_" .. iter_5_1, iter_5_1)
		end

		return
	end

	if var_5_0 then
		arg_5_3 = arg_5_3 or arg_5_0.questId_

		local function var_5_1(...)
			_GRAPH_API.cur_graph = arg_5_0.graph_
			_GRAPH_API.cur_graph_inst = arg_5_0

			var_5_0(arg_5_0, ...)

			_GRAPH_API.cur_graph = nil
			_GRAPH_API.cur_graph_inst = nil
		end

		QWorldQuestGraph:RegisterQuestEventCallback(arg_5_1, arg_5_3, var_5_1)
		table.insert(arg_5_0.events_, {
			arg_5_1,
			arg_5_3,
			var_5_1
		})
	end
end

function var_0_0.GetTrackingEntityIdList(arg_7_0, arg_7_1, arg_7_2)
	if SandplayTaskCfg[arg_7_0.questId_].hide_task ~= 0 then
		return
	end

	if arg_7_0.graph_.trackingEntityIdList then
		if arg_7_2 then
			table.insertto(arg_7_1, arg_7_0.graph_.trackingEntityIdList)

			return
		end

		if QWorldQuestTool.GetQuestStatus(arg_7_0.questId_) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			table.insertto(arg_7_1, arg_7_0.graph_.trackingEntityIdList)
		end
	end
end

function var_0_0.GetLocalVariable(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.localVarTable_

	return var_8_0 and var_8_0[arg_8_1] or nil
end

function var_0_0.SetLocalVariable(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.localVarTable_

	if not var_9_0 then
		var_9_0 = {}
		arg_9_0.localVarTable_ = var_9_0
	end

	var_9_0[arg_9_1] = arg_9_2
end

function var_0_0.GetQuestLocalProgress(arg_10_0)
	return arg_10_0:GetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS)
end

function var_0_0.IncreaseQuestLocalProgress(arg_11_0, arg_11_1)
	local var_11_0 = (arg_11_0:GetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS) or 0) + arg_11_1

	arg_11_0:SetLocalVariable(QWorldQuestConst.GRAPH_PREDEFINE_VAR.QUEST_LOCAL_PROGRESS, var_11_0)

	local var_11_1 = SandplayTaskCfg[arg_11_0.questId_]

	if var_11_0 >= var_11_1.need then
		QWorldMgr:GetQWorldQuestMgr():QuestSetParam(arg_11_0.questId_, arg_11_0.questId_, var_11_0, nil)
	end

	QWorldMgr:GetQWorldQuestMgr():OnMainQuestUpdate(var_11_1.main_task_id)
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:UnbindEvents()

	arg_12_0.events_ = nil
end

return var_0_0
