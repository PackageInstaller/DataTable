local var_0_0 = {}
local var_0_1 = import("game.qworld.quest.QWorldQuestGraphApi")
local var_0_2 = import("game.qworld.quest.QWorldQuestGraphInst")

function var_0_0.Init(arg_1_0)
	arg_1_0.graphCallback_ = {}
	arg_1_0.questGraph_ = {}

	var_0_1.Init()

	arg_1_0.onEntityEnterZone_ = handler(arg_1_0, arg_1_0._OnEntityEnterZone)
	arg_1_0.onEntityExitZone_ = handler(arg_1_0, arg_1_0._OnEntityExitZone)
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone + arg_1_0.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone + arg_1_0.onEntityExitZone_
	arg_1_0.entityBubbleQuests_ = {}
	arg_1_0.questLastStatus_ = {}
	arg_1_0.timers_ = {}
end

function var_0_0.Dispose(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.timers_) do
		if iter_2_1:IsRunning() then
			iter_2_1:Stop()
		end
	end

	arg_2_0.timers_ = nil
	arg_2_0.questLastStatus_ = nil
	arg_2_0.entityBubbleQuests_ = nil
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone - arg_2_0.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone - arg_2_0.onEntityExitZone_
	arg_2_0.onEntityEnterZone_ = nil
	arg_2_0.onEntityExitZone_ = nil

	var_0_1.Clear()

	for iter_2_2, iter_2_3 in pairs(arg_2_0.questGraph_) do
		iter_2_3:Dispose()
	end

	arg_2_0.graphCallback_ = nil
	arg_2_0.questGraph_ = nil
end

function var_0_0.UpdateQuestGraph(arg_3_0, arg_3_1)
	local var_3_0 = QWorldQuestTool.GetQuestStatus(arg_3_1)
	local var_3_1 = arg_3_0.questLastStatus_[arg_3_1]

	if var_3_1 == var_3_0 then
		return
	end

	arg_3_0.questLastStatus_[arg_3_1] = var_3_0

	if (not var_3_1 or var_3_1 == QWorldQuestConst.QUEST_STATUS.NOT_START) and var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		manager.notify:Invoke(QWORLD_ON_QUEST_GRAPH_START, arg_3_1)
	end

	local var_3_2 = SandplayTaskCfg[arg_3_1]

	if var_3_2.task_blueprint_sign == QWorldQuestConst.TASK_BLUEPRINT_TAG.NO_GRAPH then
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

	local var_3_3 = arg_3_0.questGraph_[arg_3_1]

	if var_3_3 then
		arg_3_0:_RemoveGraphBubbles(arg_3_1)
		var_3_3:UpdateGraph()
	else
		local var_3_4 = var_0_2.New(arg_3_1)

		arg_3_0.questGraph_[arg_3_1] = var_3_4

		var_3_4:BindGraph(string.format("quest_%d", arg_3_1))
	end

	arg_3_0:_InsertGraphBubbles(arg_3_1)

	if var_3_0 == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
		arg_3_0:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_UNMEET, arg_3_1)
		QWorldMgr:GetQWorldQuestMgr():_OnUpdateMapQuestInfoWrapped(arg_3_1)
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.NOT_START then
		arg_3_0:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_NOT_START, arg_3_1)
	elseif var_3_0 == QWorldQuestConst.QUEST_STATUS.FINISH then
		arg_3_0:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_ACCOMPLISHED, arg_3_1)
	end
end

function var_0_0.DestroyQuestGraph(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.questGraph_[arg_4_1]

	if var_4_0 then
		QWorldMgr:GetQWorldQuestMgr():_OnUpdateMapQuestInfoWrapped(arg_4_1)
		arg_4_0:_RemoveGraphBubbles(arg_4_1)
		var_4_0:Dispose()

		arg_4_0.questGraph_[arg_4_1] = nil
	end
end

function var_0_0.DispatchQuestEvent(arg_5_0, arg_5_1, arg_5_2, ...)
	local var_5_0 = arg_5_0.graphCallback_[arg_5_1]

	if var_5_0 then
		local var_5_1 = var_5_0[arg_5_2]

		if var_5_1 then
			for iter_5_0, iter_5_1 in ipairs(var_5_1) do
				iter_5_1(...)
			end

			return true
		end
	end

	return false
end

function var_0_0.HasQuestEvent(arg_6_0, arg_6_1, arg_6_2, ...)
	local var_6_0 = arg_6_0.graphCallback_[arg_6_1]

	if var_6_0 and var_6_0[arg_6_2] then
		return true
	end

	return false
end

function var_0_0.RegisterQuestEventCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0.graphCallback_[arg_7_1] or {}
	local var_7_1 = var_7_0[arg_7_2] or {}

	table.insert(var_7_1, arg_7_3)

	var_7_0[arg_7_2] = var_7_1
	arg_7_0.graphCallback_[arg_7_1] = var_7_0
end

function var_0_0.UnregisterQuestEventCallback(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0.graphCallback_[arg_8_1]

	if var_8_0 then
		local var_8_1 = var_8_0[arg_8_2]

		if var_8_1 then
			table.removebyvalue(var_8_1, arg_8_3)

			if #var_8_1 == 0 then
				var_8_0[arg_8_2] = nil
			end
		end

		if table.isEmpty(var_8_0) then
			arg_8_0.graphCallback_[arg_8_1] = nil
		end
	end
end

function var_0_0.GetTrackingEntityIdList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.questGraph_[arg_9_1]

	if var_9_0 then
		var_9_0:GetTrackingEntityIdList(arg_9_2)
	end
end

function var_0_0.GetTrackingEntityIdListRaw(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.questGraph_[arg_10_1]

	if var_10_0 then
		var_10_0:GetTrackingEntityIdList(arg_10_2, true)
	end
end

function var_0_0.GetEntityBubbleQuests(arg_11_0, arg_11_1)
	return arg_11_0.entityBubbleQuests_[arg_11_1]
end

function var_0_0.StartTimer(arg_12_0, arg_12_1)
	table.insert(arg_12_0.timers_, arg_12_1)
	arg_12_1:Start()

	local var_12_0 = #arg_12_0.timers_ - 1

	while var_12_0 > 0 do
		local var_12_1 = arg_12_0.timers_[var_12_0]

		if not var_12_1:IsRunning() then
			var_12_1:Stop()
			table.remove(arg_12_0.timers_, var_12_0)
		end

		var_12_0 = var_12_0 - 1
	end
end

function var_0_0.GetQuestLocalProgress(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.questGraph_[arg_13_1]

	if not var_13_0 then
		return nil
	end

	return var_13_0:GetQuestLocalProgress()
end

function var_0_0.IncreaseQuestLocalProgress(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0.questGraph_[arg_14_1]

	if var_14_0 then
		var_14_0:IncreaseQuestLocalProgress(arg_14_2)
	end
end

function var_0_0._InsertGraphBubbles(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.questGraph_[arg_15_1]

	if var_15_0.OnClickBubble then
		for iter_15_0, iter_15_1 in ipairs(var_15_0.OnClickBubble) do
			local var_15_1 = arg_15_0.entityBubbleQuests_[iter_15_1] or {}

			table.insert(var_15_1, arg_15_1)

			arg_15_0.entityBubbleQuests_[iter_15_1] = var_15_1
		end
	end
end

function var_0_0._RemoveGraphBubbles(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.questGraph_[arg_16_1]

	if var_16_0.OnClickBubble then
		for iter_16_0, iter_16_1 in ipairs(var_16_0.OnClickBubble) do
			table.removebyvalue(arg_16_0.entityBubbleQuests_[iter_16_1], arg_16_1)

			if #arg_16_0.entityBubbleQuests_[iter_16_1] == 0 then
				arg_16_0.entityBubbleQuests_[iter_16_1] = nil
			end
		end
	end
end

function var_0_0._OnEntityEnterZone(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_ENTER_ZONE, arg_17_1)
end

function var_0_0._OnEntityExitZone(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_EXIT_ZONE, arg_18_1)
end

return var_0_0
