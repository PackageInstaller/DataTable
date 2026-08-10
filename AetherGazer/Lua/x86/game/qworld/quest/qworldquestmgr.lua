local var_0_0 = class("QWorldQuestMgr")

QWorldQuestGraph = import("game.qworld.quest.QWorldQuestGraph")

function var_0_0.Init(arg_1_0)
	arg_1_0.onEntityEnterInteractRange_ = handler(arg_1_0, arg_1_0._OnEntityEnterInteractRange)
	arg_1_0.onEntityExitInteractRange_ = handler(arg_1_0, arg_1_0._OnEntityExitInteractRange)
	QWorldLuaBridge.onEntityEnterInteractRange = QWorldLuaBridge.onEntityEnterInteractRange + arg_1_0.onEntityEnterInteractRange_
	QWorldLuaBridge.onEntityExitInteractRange = QWorldLuaBridge.onEntityExitInteractRange + arg_1_0.onEntityExitInteractRange_
	arg_1_0.onEntityEnterZone_ = handler(arg_1_0, arg_1_0._OnEntityEnterZone)
	arg_1_0.onEntityExitZone_ = handler(arg_1_0, arg_1_0._OnEntityExitZone)
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone + arg_1_0.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone + arg_1_0.onEntityExitZone_
	arg_1_0.entityBubbleList_ = {}
	arg_1_0.mainQuestTrackingIdList = {}
	arg_1_0.finishQuests_ = {}
	arg_1_0.finishMainQuests_ = {}
	arg_1_0.mainQuestStarted_ = {}
	arg_1_0.mainQuestsNotifyServer_ = {}
	arg_1_0.onQuestOptionClick_ = handler(arg_1_0, arg_1_0._OnQuestOptionClick)

	QWorldQuestGraph:Init()
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:_StopTimer()

	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone - arg_2_0.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone - arg_2_0.onEntityExitZone_
	arg_2_0.onEntityEnterZone_ = nil
	arg_2_0.onEntityExitZone_ = nil
	QWorldLuaBridge.onEntityEnterInteractRange = QWorldLuaBridge.onEntityEnterInteractRange - arg_2_0.onEntityEnterInteractRange_
	QWorldLuaBridge.onEntityExitInteractRange = QWorldLuaBridge.onEntityExitInteractRange - arg_2_0.onEntityExitInteractRange_
	arg_2_0.onEntityEnterInteractRange_ = nil
	arg_2_0.onEntityExitInteractRange_ = nil
	arg_2_0.entityBubbleList_ = nil
	arg_2_0.mainQuestTrackingIdList = nil
	arg_2_0.finishQuests_ = nil
	arg_2_0.finishMainQuests_ = nil
	arg_2_0.mainQuestStarted_ = nil
	arg_2_0.mainQuestsNotifyServer_ = nil
	arg_2_0.onQuestOptionClick_ = nil

	QWorldQuestGraph:Dispose()
end

function var_0_0.CreateMissingQuestStaff(arg_3_0)
	local var_3_0 = QWorldQuestTool.FindAllTrackableMainQuestId(true, true)

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0:OnMainQuestUpdate(iter_3_1, true)
	end

	arg_3_0:OnUpdateTrackingQuest(QWorldQuestTool.GetMainQuestTrackingId(), -1)

	for iter_3_2, iter_3_3 in ipairs(SandplayTaskCfg.all) do
		local var_3_1 = SandplayTaskCfg[iter_3_3]

		if var_3_1.task_blueprint_sign == QWorldQuestConst.TASK_BLUEPRINT_TAG.ALWAYS_RUN_GRAPH and QWorldQuestTool.IsCurMapMainQuest(var_3_1.main_task_id) then
			QWorldQuestGraph:UpdateQuestGraph(iter_3_3)
		end
	end

	if gameContext:GetLastOpenPage() == "qworldMainHome" then
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, 0)
	end

	local var_3_2 = QWorldData:GetCurMapId()

	if var_3_2 and getData("qworld", string.format("first_tracking_main_quest_%d", var_3_2)) == nil then
		local var_3_3 = QWorldQuestTool.FindFirstTrackableMainQuestId()

		QWorldQuestAction.UpdateTrackingMainQuestId(var_3_3, function()
			saveData("qworld", string.format("first_tracking_main_quest_%d", var_3_2), var_3_3)
			QWorldQuestAction.SendUpdateQuestTrackToSdk(var_3_3, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
		end)
	end
end

function var_0_0.QuestSetParam(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.isSendingQuestParamUpdate_ = true

	local function var_5_0(arg_6_0)
		arg_5_0.isSendingQuestParamUpdate_ = false

		if arg_5_4 and isSuccess(arg_6_0.result) then
			arg_5_4()
		end
	end

	QWorldQuestAction.QuestSetParam(arg_5_2, arg_5_3, var_5_0)
end

function var_0_0.IsSendingQuestParamUpdateOrFinish(arg_7_0)
	return arg_7_0.isSendingQuestParamUpdate_ or arg_7_0:IsSendingQuestFinish()
end

function var_0_0.OnMainQuestUpdate(arg_8_0, arg_8_1, arg_8_2)
	if not QWorldQuestTool.IsCurMapMainQuest(arg_8_1) then
		return
	end

	local var_8_0 = QWorldQuestData:GetMainQuestData(arg_8_1)

	for iter_8_0, iter_8_1 in ipairs(var_8_0.taskIdList) do
		arg_8_0:OnQuestUpdate(iter_8_1)
	end

	if QWorldQuestTool.IsMainQuestCanSubmit(arg_8_1) then
		arg_8_0:_PushFinishQuest(arg_8_1, nil)
	elseif QWorldQuestTool.GetMainQuestTrackingId() == arg_8_1 then
		arg_8_0:OnUpdateTrackingQuest(arg_8_1, -1)
	end

	arg_8_0:UpdateMainQuestIcon(arg_8_1)
	manager.notify:CallUpdateFunc("OnQWorldMainQuestUpdate", arg_8_1)
	QWorldNotifyQueue:MainQuestUpdate(arg_8_1)
	arg_8_0:_CheckNotifyServerTimer(arg_8_1)

	if arg_8_2 then
		arg_8_0.mainQuestStarted_[arg_8_1] = true
	elseif not arg_8_0.mainQuestStarted_[arg_8_1] then
		arg_8_0.mainQuestStarted_[arg_8_1] = true

		QWorldNotifyQueue:MainQuestsNew(arg_8_1)
	end
end

function var_0_0.OnUpdateTrackingQuest(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2 and arg_9_2 ~= -1 and QWorldQuestData:GetMainQuestData(arg_9_2) ~= nil then
		arg_9_0:UpdateMainQuestIcon(arg_9_2)
	end

	arg_9_0:UpdateMainQuestIcon(arg_9_1)

	local var_9_0 = QWorldQuestTool.GetCurQuestTrackingEntityIdList()

	QWorldMgr:GetQWorldEntityMgr():TrackQuest(var_9_0)
	manager.notify:CallUpdateFunc("OnQWorldMainQuestUpdate", arg_9_1)
	QWorldNotifyQueue:MainQuestUpdate(arg_9_1)
end

function var_0_0.OnUpdateMapQuestInfo(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	printf("子任务%d(完成:%s)更新地图实体信息[%s]", arg_10_1, tostring(arg_10_3), table.concat(arg_10_2, ", "))

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		local var_10_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_10_1)

		if var_10_0 then
			arg_10_0:UpdateEntityQuestIcon(var_10_0)

			if arg_10_3 then
				var_10_0:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Task, arg_10_1)
			end
		end
	end
end

function var_0_0.OnQuestUpdate(arg_11_0, arg_11_1)
	local var_11_0 = SandplayTaskCfg[arg_11_1]

	if not QWorldQuestTool.IsCurMapMainQuest(var_11_0.main_task_id) then
		return
	end

	local var_11_1 = QWorldQuestData:GetQuestData(arg_11_1)

	if QWorldQuestTool.IsQuestCanSubmit(arg_11_1) then
		arg_11_0:_PushFinishQuest(nil, arg_11_1)
	else
		QWorldQuestGraph:UpdateQuestGraph(arg_11_1)
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_PROG_UPDATE, arg_11_1, QWorldQuestTool.GetQuestProgress(arg_11_1))

		local var_11_2 = QWorldQuestData:GetQuestData(arg_11_1)

		if var_11_2.status ~= QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			return false
		end

		if var_11_2.progress > var_11_0.need then
			Debug.LogWarning(string.format("%d 实际进度大于配置所需进度", arg_11_1))
		end

		if QWorldQuestTool.IsQuestCanSubmit(arg_11_1) then
			arg_11_0:_PushFinishQuest(nil, arg_11_1)
		end
	end
end

function var_0_0.OnSpawnEntity(arg_12_0, arg_12_1)
	arg_12_0:UpdateEntityQuestIcon(arg_12_1)
end

function var_0_0.OnRemoveEntity(arg_13_0, arg_13_1)
	return
end

function var_0_0.SetStoryEndCallback(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0.storyEndCallback_ then
		arg_14_0.storyEndCallback_ = {}
	end

	arg_14_0.storyEndCallback_[arg_14_1] = arg_14_2
end

function var_0_0.OnStoryEnd(arg_15_0, arg_15_1)
	if arg_15_0.storyEndCallback_ and arg_15_0.storyEndCallback_[arg_15_1] then
		arg_15_0.storyEndCallback_[arg_15_1]()
	end
end

function var_0_0.OnMiniGameChangeState(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 then
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FINISH, arg_16_1)
	else
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FAIL, arg_16_1)
	end
end

function var_0_0.UpdateEntityQuestIcon(arg_17_0, arg_17_1)
	if arg_17_1 then
		local var_17_0 = QWorldQuestTool.GetEntitySortedMainQuestList(arg_17_1.entityId)

		if #var_17_0 == 0 then
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, QWorldQuestConst.QUEST_TASK_TYPE.NONE)

			return
		end

		local var_17_1 = var_17_0[1]
		local var_17_2 = SandplayTaskMainCfg[var_17_1]

		if QWorldQuestTool.GetMainQuestTrackingId() ~= var_17_1 then
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, var_17_2.main_task_type)
		else
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, QWorldQuestConst.QUEST_TASK_TYPE.NONE, true)
		end

		local var_17_3 = QWorldQuestData:GetMainQuestData(var_17_1)

		for iter_17_0, iter_17_1 in ipairs(var_17_3.taskIdList) do
			if QWorldQuestTool.GetQuestStatus(iter_17_1) == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
				if QWorldQuestTool.GetMainQuestTrackingId() ~= var_17_1 then
					arg_17_1:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Task, iter_17_1)
				else
					arg_17_1:AddMiniMapEntity(QWorldEntityMiniMapTag.Task, iter_17_1)
				end
			end
		end
	end
end

function var_0_0.UpdateMainQuestIcon(arg_18_0, arg_18_1)
	if arg_18_1 == -1 then
		return
	end

	local var_18_0 = arg_18_0.mainQuestTrackingIdList[arg_18_1] or {}
	local var_18_1 = QWorldQuestTool.GetQuestTrackingEntityIdList(arg_18_1)
	local var_18_2 = SandplayTaskMainCfg[arg_18_1]

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_3 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_1)
		local var_18_4 = iter_18_1 == var_18_2.receive_npc

		if not var_18_3 and var_18_4 then
			QWorldSpawnPrefabByEntityId(iter_18_1)

			var_18_3 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_1)
		end

		if var_18_3 then
			arg_18_0:UpdateEntityQuestIcon(var_18_3)
		end

		table.removebyvalue(var_18_0, iter_18_1)
	end

	arg_18_0.mainQuestTrackingIdList[arg_18_1] = var_18_1

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		local var_18_5 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_3)

		if var_18_5 then
			arg_18_0:UpdateEntityQuestIcon(var_18_5)
		end
	end
end

function var_0_0.UpdateEntityQuestBubble(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.entity
	local var_19_1 = arg_19_0.entityBubbleList_[var_19_0.uniqueId]

	if var_19_1 then
		for iter_19_0, iter_19_1 in ipairs(var_19_1) do
			arg_19_1:RemoveQuestTag(iter_19_1)
		end

		arg_19_1:RemoveEventCallback(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, arg_19_0.onQuestOptionClick_)
	end

	local var_19_2 = arg_19_1.entityId

	if var_19_2 == 0 then
		return
	end

	local var_19_3 = QWorldQuestTool.GetNpcMainQuestReceiveList(var_19_2)
	local var_19_4 = {}

	for iter_19_2, iter_19_3 in ipairs(var_19_3) do
		if QWorldQuestTool.IsMainQuestCanReceive(iter_19_3) then
			local var_19_5 = -iter_19_3
			local var_19_6 = SandplayTaskMainCfg[iter_19_3].title

			arg_19_1:AddQuestTag(var_19_5, var_19_6, function()
				QWorldMgr:GetQWorldStoryMgr():StopStory()
				arg_19_1:PushEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_19_5)
			end)
			table.insert(var_19_4, var_19_5)
		end
	end

	if #var_19_4 > 0 then
		arg_19_0.entityBubbleList_[var_19_0.uniqueId] = var_19_4

		arg_19_1:ListenForEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, arg_19_0.onQuestOptionClick_)
	else
		arg_19_0.entityBubbleList_[var_19_0.uniqueId] = nil
	end
end

function var_0_0.IsSendingQuestFinish(arg_21_0)
	return arg_21_0.__isSendingFinishQuest or arg_21_0.__isSendingFinishMainQuest or #arg_21_0.finishQuests_ > 0 or #arg_21_0.finishMainQuests_ > 0
end

function var_0_0._OnEntityEnterInteractRange(arg_22_0, arg_22_1)
	local var_22_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_22_1.uniqueId)

	arg_22_0:UpdateEntityQuestBubble(var_22_0)
end

function var_0_0._OnEntityExitInteractRange(arg_23_0, arg_23_1)
	return
end

function var_0_0._OnEntityEnterZone(arg_24_0, arg_24_1, arg_24_2)
	QWorldMgr:GetQWorldEntityMgr():SetTrackEnable(arg_24_1, false)
end

function var_0_0._OnEntityExitZone(arg_25_0, arg_25_1, arg_25_2)
	QWorldMgr:GetQWorldEntityMgr():SetTrackEnable(arg_25_1, true)
end

function var_0_0._OnQuestOptionClick(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = -arg_26_2
	local var_26_1 = QWorldQuestData:GetMainQuestData(var_26_0)
	local var_26_2 = SandplayTaskMainCfg[var_26_0]

	if QWorldQuestTool.IsMainQuestCanReceive(var_26_0) then
		QWorldQuestAction.TakeMainQuest(var_26_0, function()
			arg_26_0:UpdateEntityQuestBubble(arg_26_1)
		end)
	end
end

function var_0_0._StopTimer(arg_28_0)
	if arg_28_0.timerNotifyServer_ then
		arg_28_0.timerNotifyServer_:Stop()

		arg_28_0.timerNotifyServer_ = nil
	end

	if arg_28_0.timerFinishQuest_ then
		arg_28_0.timerFinishQuest_:Stop()

		arg_28_0.timerFinishQuest_ = nil
	end
end

function var_0_0._ShouldUpdateQuests(arg_29_0, arg_29_1)
	local var_29_0 = QWorldQuestData:GetMainQuestData(arg_29_1)

	for iter_29_0, iter_29_1 in ipairs(var_29_0.taskIdList) do
		if QWorldQuestData:GetQuestData(iter_29_1).status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			local var_29_1 = SandplayTaskCfg[iter_29_1]
			local var_29_2 = var_29_1.additional_parameter

			if var_29_1.condition == 61 then
				local var_29_3 = {
					{
						var_29_2[1],
						var_29_2[2],
						var_29_2[3]
					},
					{
						var_29_2[4],
						var_29_2[5],
						var_29_2[6]
					}
				}

				if manager.time:parseTimeFromConfig(var_29_3) <= manager.time:GetServerTime() then
					return true, iter_29_1
				else
					return true
				end
			end
		end
	end

	return false
end

function var_0_0._CheckNotifyServerTimer(arg_30_0, arg_30_1)
	if not arg_30_0:_ShouldUpdateQuests(arg_30_1) then
		return
	end

	if not table.indexof(arg_30_0.mainQuestsNotifyServer_, arg_30_1) then
		table.insert(arg_30_0.mainQuestsNotifyServer_, arg_30_1)
	end

	if not arg_30_0.timerNotifyServer_ then
		arg_30_0.timerNotifyServer_ = Timer.New(function()
			local var_31_0 = false
			local var_31_1 = false
			local var_31_2 = #arg_30_0.mainQuestsNotifyServer_

			while var_31_2 > 0 do
				local var_31_3 = arg_30_0.mainQuestsNotifyServer_[var_31_2]
				local var_31_4, var_31_5 = arg_30_0:_ShouldUpdateQuests(var_31_3)

				if var_31_4 then
					if var_31_5 then
						var_31_1 = true
					end

					var_31_0 = true
				else
					table.removebyvalue(arg_30_0.mainQuestsNotifyServer_, var_31_3)
				end

				var_31_2 = var_31_2 - 1
			end

			if var_31_0 then
				if var_31_1 then
					QWorldQuestAction.NotifyServerUpdateQuests()
				end

				manager.notify:CallUpdateFunc("OnQWorldQuestUpdateProgress")
			else
				arg_30_0.timerNotifyServer_:Stop()

				arg_30_0.timerNotifyServer_ = nil
			end
		end, 5, -1)

		arg_30_0.timerNotifyServer_:Start()
	end
end

function var_0_0._OnUpdateMapQuestInfoWrapped(arg_32_0, arg_32_1)
	local var_32_0 = {}

	QWorldQuestGraph:GetTrackingEntityIdListRaw(arg_32_1, var_32_0)

	local var_32_1 = QWorldQuestTool.GetQuestStatus(arg_32_1)

	arg_32_0:OnUpdateMapQuestInfo(arg_32_1, var_32_0, var_32_1 == QWorldQuestConst.QUEST_STATUS.FINISH)
end

function var_0_0._FinishMainQuest(arg_33_0, arg_33_1)
	print(string.format("自动完成主任务[%s]", table.concat(arg_33_1, ", ")))

	arg_33_0.__isSendingFinishMainQuest = true

	QWorldQuestAction.SubmitMainQuest(arg_33_1, function(arg_34_0)
		arg_33_0.__isSendingFinishMainQuest = false

		if not isSuccess(arg_34_0.result) then
			return
		end

		for iter_34_0, iter_34_1 in ipairs(arg_33_1) do
			local var_34_0 = SandplayTaskMainCfg[iter_34_1]

			if var_34_0.important_reward and var_34_0.important_reward ~= "" then
				QWorldNotifyQueue:GetCriticalRewards(formatRewardCfgList(var_34_0.important_reward))
			end
		end

		QWorldNotifyQueue:GetRewards(arg_34_0.reward_list)
		QWorldNotifyQueue:MainQuestsFinish(arg_33_1)

		local var_34_1 = QWorldQuestData:GetMainQuestTrackingIdRaw()

		if table.indexof(arg_33_1, var_34_1) then
			local var_34_2 = SandplayTaskMainCfg[var_34_1].next_main_mission

			if var_34_2 == 0 or QWorldQuestTool.IsMainQuestFinish(var_34_2) then
				var_34_2 = QWorldQuestTool.FindFirstTrackableMainQuestId()
			end

			if var_34_2 ~= -1 and QWorldQuestData:GetMainQuestData(var_34_2) then
				QWorldQuestAction.UpdateTrackingMainQuestId(var_34_2, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_34_2, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
				end)
			else
				QWorldQuestAction.UpdateTrackingMainQuestId(-1)
			end
		elseif QWorldQuestTool.GetMainQuestTrackingId() == -1 then
			local var_34_3 = false
			local var_34_4 = 0

			for iter_34_2, iter_34_3 in ipairs(arg_33_1) do
				local var_34_5 = SandplayTaskMainCfg[iter_34_3]

				if var_34_5.next_main_mission ~= 0 and QWorldQuestTool.IsMainQuestTrackable(var_34_5.next_main_mission, true) then
					var_34_4 = var_34_5.next_main_mission
				end

				if var_34_5.hide_task == 0 then
					var_34_3 = true
				end
			end

			if var_34_4 == 0 then
				if var_34_3 then
					var_34_4 = QWorldQuestTool.FindFirstTrackableMainQuestId()
				else
					var_34_4 = -1
				end
			end

			if var_34_4 ~= -1 and QWorldQuestData:GetMainQuestData(var_34_4) then
				QWorldQuestAction.UpdateTrackingMainQuestId(var_34_4, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_34_4, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
				end)
			end
		end
	end)
end

function var_0_0._FinishQuest(arg_37_0, arg_37_1)
	print(string.format("自动完成任务[%s]", table.concat(arg_37_1, ", ")))

	arg_37_0.__isSendingFinishQuest = true

	QWorldQuestAction.SubmitQuest(arg_37_1, function(arg_38_0)
		arg_37_0.__isSendingFinishQuest = false

		if not isSuccess(arg_38_0.result) then
			return
		end

		QWorldNotifyQueue:GetRewards(arg_38_0.reward_list)

		for iter_38_0, iter_38_1 in ipairs(arg_37_1) do
			QWorldQuestGraph:UpdateQuestGraph(iter_38_1)
		end
	end)
end

function var_0_0._PushFinishQuest(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_2 and not table.indexof(arg_39_0.finishQuests_, arg_39_2) then
		table.insert(arg_39_0.finishQuests_, arg_39_2)
	end

	if arg_39_1 and not table.indexof(arg_39_0.finishMainQuests_, arg_39_1) then
		table.insert(arg_39_0.finishMainQuests_, arg_39_1)
	end

	if not arg_39_0.timerFinishQuest_ then
		arg_39_0.timerFinishQuest_ = Timer.New(function()
			local var_40_0 = true

			if #arg_39_0.finishQuests_ > 0 then
				var_40_0 = false

				if not arg_39_0.__isSendingFinishQuest then
					arg_39_0:_FinishQuest(arg_39_0.finishQuests_)

					arg_39_0.finishQuests_ = {}
				end
			end

			if #arg_39_0.finishMainQuests_ > 0 then
				var_40_0 = false

				if not arg_39_0.__isSendingFinishMainQuest then
					arg_39_0:_FinishMainQuest(arg_39_0.finishMainQuests_)

					arg_39_0.finishMainQuests_ = {}
				end
			end

			if var_40_0 then
				arg_39_0.timerFinishQuest_:Stop()

				arg_39_0.timerFinishQuest_ = nil
			end
		end, 0.1, -1)

		arg_39_0.timerFinishQuest_:Start()
	end
end

return var_0_0
