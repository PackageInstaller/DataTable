local QWorldQuestMgr = class("QWorldQuestMgr")

QWorldQuestGraph = import("game.qworld.quest.QWorldQuestGraph")

function QWorldQuestMgr:Init()
	self.onEntityEnterInteractRange_ = handler(self, self._OnEntityEnterInteractRange)
	self.onEntityExitInteractRange_ = handler(self, self._OnEntityExitInteractRange)
	QWorldLuaBridge.onEntityEnterInteractRange = QWorldLuaBridge.onEntityEnterInteractRange + self.onEntityEnterInteractRange_
	QWorldLuaBridge.onEntityExitInteractRange = QWorldLuaBridge.onEntityExitInteractRange + self.onEntityExitInteractRange_
	self.onEntityEnterZone_ = handler(self, self._OnEntityEnterZone)
	self.onEntityExitZone_ = handler(self, self._OnEntityExitZone)
	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone + self.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone + self.onEntityExitZone_
	self.entityBubbleList_ = {}
	self.mainQuestTrackingIdList = {}
	self.finishQuests_ = {}
	self.finishMainQuests_ = {}
	self.mainQuestStarted_ = {}
	self.mainQuestsNotifyServer_ = {}
	self.onQuestOptionClick_ = handler(self, self._OnQuestOptionClick)

	QWorldQuestGraph:Init()
end

function QWorldQuestMgr:Dispose()
	self:_StopTimer()

	QWorldLuaBridge.onEntityEnterZone = QWorldLuaBridge.onEntityEnterZone - self.onEntityEnterZone_
	QWorldLuaBridge.onEntityExitZone = QWorldLuaBridge.onEntityExitZone - self.onEntityExitZone_
	self.onEntityEnterZone_ = nil
	self.onEntityExitZone_ = nil
	QWorldLuaBridge.onEntityEnterInteractRange = QWorldLuaBridge.onEntityEnterInteractRange - self.onEntityEnterInteractRange_
	QWorldLuaBridge.onEntityExitInteractRange = QWorldLuaBridge.onEntityExitInteractRange - self.onEntityExitInteractRange_
	self.onEntityEnterInteractRange_ = nil
	self.onEntityExitInteractRange_ = nil
	self.entityBubbleList_ = nil
	self.mainQuestTrackingIdList = nil
	self.finishQuests_ = nil
	self.finishMainQuests_ = nil
	self.mainQuestStarted_ = nil
	self.mainQuestsNotifyServer_ = nil
	self.onQuestOptionClick_ = nil

	QWorldQuestGraph:Dispose()
end

function QWorldQuestMgr:CreateMissingQuestStaff()
	for iter_3_0, iter_3_1 in ipairs((QWorldQuestTool.FindAllTrackableMainQuestId(true, true))) do
		self:OnMainQuestUpdate(iter_3_1, true)
	end

	self:OnUpdateTrackingQuest(QWorldQuestTool.GetMainQuestTrackingId(), -1)

	for iter_3_2, iter_3_3 in ipairs(SandplayTaskCfg.all) do
		if SandplayTaskCfg[iter_3_3].task_blueprint_sign == QWorldQuestConst.TASK_BLUEPRINT_TAG.ALWAYS_RUN_GRAPH and QWorldQuestTool.IsCurMapMainQuest(SandplayTaskCfg[iter_3_3].main_task_id) then
			QWorldQuestGraph:UpdateQuestGraph(iter_3_3)
		end
	end

	if gameContext:GetLastOpenPage() == "qworldMainHome" then
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_BACK_MAIN_HOME, 0)
	end

	local var_3_0 = QWorldData:GetCurMapId()

	if var_3_0 and getData("qworld", string.format("first_tracking_main_quest_%d", var_3_0)) == nil then
		local var_3_1 = QWorldQuestTool.FindFirstTrackableMainQuestId()

		QWorldQuestAction.UpdateTrackingMainQuestId(var_3_1, function()
			saveData("qworld", string.format("first_tracking_main_quest_%d", var_3_0), var_3_1)
			QWorldQuestAction.SendUpdateQuestTrackToSdk(var_3_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
		end)
	end
end

function QWorldQuestMgr:QuestSetParam(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self.isSendingQuestParamUpdate_ = true

	QWorldQuestAction.QuestSetParam(arg_5_2, arg_5_3, function(arg_6_0)
		self.isSendingQuestParamUpdate_ = false

		if arg_5_4 and isSuccess(arg_6_0.result) then
			arg_5_4()
		end
	end)
end

function QWorldQuestMgr:IsSendingQuestParamUpdateOrFinish()
	return self.isSendingQuestParamUpdate_ or self:IsSendingQuestFinish()
end

function QWorldQuestMgr:OnMainQuestUpdate(arg_8_1, arg_8_2)
	if not QWorldQuestTool.IsCurMapMainQuest(arg_8_1) then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(QWorldQuestData:GetMainQuestData(arg_8_1).taskIdList) do
		self:OnQuestUpdate(iter_8_1)
	end

	if QWorldQuestTool.IsMainQuestCanSubmit(arg_8_1) then
		self:_PushFinishQuest(arg_8_1, nil)
	elseif QWorldQuestTool.GetMainQuestTrackingId() == arg_8_1 then
		self:OnUpdateTrackingQuest(arg_8_1, -1)
	end

	self:UpdateMainQuestIcon(arg_8_1)
	manager.notify:CallUpdateFunc("OnQWorldMainQuestUpdate", arg_8_1)
	QWorldNotifyQueue:MainQuestUpdate(arg_8_1)
	self:_CheckNotifyServerTimer(arg_8_1)

	if arg_8_2 then
		self.mainQuestStarted_[arg_8_1] = true
	elseif not self.mainQuestStarted_[arg_8_1] then
		self.mainQuestStarted_[arg_8_1] = true

		QWorldNotifyQueue:MainQuestsNew(arg_8_1)
	end
end

function QWorldQuestMgr:OnUpdateTrackingQuest(arg_9_1, arg_9_2)
	if arg_9_2 and arg_9_2 ~= -1 and QWorldQuestData:GetMainQuestData(arg_9_2) ~= nil then
		self:UpdateMainQuestIcon(arg_9_2)
	end

	self:UpdateMainQuestIcon(arg_9_1)
	QWorldMgr:GetQWorldEntityMgr():TrackQuest((QWorldQuestTool.GetCurQuestTrackingEntityIdList()))
	manager.notify:CallUpdateFunc("OnQWorldMainQuestUpdate", arg_9_1)
	QWorldNotifyQueue:MainQuestUpdate(arg_9_1)
end

function QWorldQuestMgr:OnUpdateMapQuestInfo(arg_10_1, arg_10_2, arg_10_3)
	printf("子任务%d(完成:%s)更新地图实体信息[%s]", arg_10_1, tostring(arg_10_3), table.concat(arg_10_2, ", "))

	for iter_10_0, iter_10_1 in ipairs(arg_10_2) do
		local var_10_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_10_1)

		if var_10_0 then
			self:UpdateEntityQuestIcon(var_10_0)

			if arg_10_3 then
				var_10_0:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Task, arg_10_1)
			end
		end
	end
end

function QWorldQuestMgr:OnQuestUpdate(arg_11_1)
	if not QWorldQuestTool.IsCurMapMainQuest(SandplayTaskCfg[arg_11_1].main_task_id) then
		return
	end

	local var_11_0 = QWorldQuestData:GetQuestData(arg_11_1)

	if QWorldQuestTool.IsQuestCanSubmit(arg_11_1) then
		self:_PushFinishQuest(nil, arg_11_1)
	else
		QWorldQuestGraph:UpdateQuestGraph(arg_11_1)
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_PROG_UPDATE, arg_11_1, QWorldQuestTool.GetQuestProgress(arg_11_1))

		local var_11_1 = QWorldQuestData:GetQuestData(arg_11_1)

		if var_11_1.status ~= QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			return false
		end

		if var_11_1.progress > SandplayTaskCfg[arg_11_1].need then
			Debug.LogWarning(string.format("%d 实际进度大于配置所需进度", arg_11_1))
		end

		if QWorldQuestTool.IsQuestCanSubmit(arg_11_1) then
			self:_PushFinishQuest(nil, arg_11_1)
		end
	end
end

function QWorldQuestMgr:OnSpawnEntity(arg_12_1)
	self:UpdateEntityQuestIcon(arg_12_1)
end

function QWorldQuestMgr:OnRemoveEntity(arg_13_1)
	return
end

function QWorldQuestMgr:SetStoryEndCallback(arg_14_1, arg_14_2)
	self.storyEndCallback_ = self.storyEndCallback_ or {}
	self.storyEndCallback_[arg_14_1] = arg_14_2
end

function QWorldQuestMgr:OnStoryEnd(arg_15_1)
	if self.storyEndCallback_ and self.storyEndCallback_[arg_15_1] then
		self.storyEndCallback_[arg_15_1]()
	end
end

function QWorldQuestMgr:OnMiniGameChangeState(arg_16_1, arg_16_2)
	if arg_16_2 then
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FINISH, arg_16_1)
	else
		QWorldQuestGraph:DispatchQuestEvent(QWorldQuestConst.QUEST_EVENT.ON_MINIGAME_FAIL, arg_16_1)
	end
end

function QWorldQuestMgr:UpdateEntityQuestIcon(arg_17_1)
	if arg_17_1 then
		local var_17_0 = QWorldQuestTool.GetEntitySortedMainQuestList(arg_17_1.entityId)

		if #var_17_0 == 0 then
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, QWorldQuestConst.QUEST_TASK_TYPE.NONE)

			return
		end

		local var_17_1 = var_17_0[1]

		if QWorldQuestTool.GetMainQuestTrackingId() ~= var_17_0[1] then
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, SandplayTaskMainCfg[var_17_0[1]].main_task_type)
		else
			QWorldLuaBridge.EntityShowQuest(arg_17_1.entity, QWorldQuestConst.QUEST_TASK_TYPE.NONE, true)
		end

		for iter_17_0, iter_17_1 in ipairs(QWorldQuestData:GetMainQuestData(var_17_1).taskIdList) do
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

function QWorldQuestMgr:UpdateMainQuestIcon(arg_18_1)
	if arg_18_1 == -1 then
		return
	end

	local var_18_0 = self.mainQuestTrackingIdList[arg_18_1] or {}
	local var_18_1 = QWorldQuestTool.GetQuestTrackingEntityIdList(arg_18_1)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		local var_18_2 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_1)

		if not var_18_2 and iter_18_1 == SandplayTaskMainCfg[arg_18_1].receive_npc then
			QWorldSpawnPrefabByEntityId(iter_18_1)

			var_18_2 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_1)
		end

		if var_18_2 then
			self:UpdateEntityQuestIcon(var_18_2)
		end

		table.removebyvalue(var_18_0, iter_18_1)
	end

	self.mainQuestTrackingIdList[arg_18_1] = var_18_1

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		local var_18_3 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_18_3)

		if var_18_3 then
			self:UpdateEntityQuestIcon(var_18_3)
		end
	end
end

function QWorldQuestMgr:UpdateEntityQuestBubble(arg_19_1)
	if self.entityBubbleList_[arg_19_1.entity.uniqueId] then
		for iter_19_0, iter_19_1 in ipairs(self.entityBubbleList_[arg_19_1.entity.uniqueId]) do
			arg_19_1:RemoveQuestTag(iter_19_1)
		end

		arg_19_1:RemoveEventCallback(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, self.onQuestOptionClick_)
	end

	local var_19_0 = arg_19_1.entityId
	local var_19_1

	if arg_19_1.entityId == 0 then
		do return end

		var_19_1 = {}
	end

	for iter_19_2, iter_19_3 in ipairs((QWorldQuestTool.GetNpcMainQuestReceiveList(var_19_0))) do
		if QWorldQuestTool.IsMainQuestCanReceive(iter_19_3) then
			local var_19_2 = -iter_19_3

			arg_19_1:AddQuestTag(-iter_19_3, SandplayTaskMainCfg[iter_19_3].title, function()
				QWorldMgr:GetQWorldStoryMgr():StopStory()
				arg_19_1:PushEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, var_19_2)
			end)
			table.insert(var_19_1, -iter_19_3)
		end
	end

	if #var_19_1 > 0 then
		self.entityBubbleList_[arg_19_1.entity.uniqueId] = var_19_1

		arg_19_1:ListenForEvent(QWorldQuestConst.QUEST_EVENT.ON_BUBBLE_CLICK, self.onQuestOptionClick_)
	else
		self.entityBubbleList_[arg_19_1.entity.uniqueId] = nil
	end
end

function QWorldQuestMgr:IsSendingQuestFinish()
	return self.__isSendingFinishQuest or self.__isSendingFinishMainQuest or #self.finishQuests_ > 0 or #self.finishMainQuests_ > 0
end

function QWorldQuestMgr:_OnEntityEnterInteractRange(arg_22_1)
	self:UpdateEntityQuestBubble((QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_22_1.uniqueId)))
end

function QWorldQuestMgr:_OnEntityExitInteractRange(arg_23_1)
	return
end

function QWorldQuestMgr:_OnEntityEnterZone(arg_24_1, arg_24_2)
	QWorldMgr:GetQWorldEntityMgr():SetTrackEnable(arg_24_1, false)
end

function QWorldQuestMgr:_OnEntityExitZone(arg_25_1, arg_25_2)
	QWorldMgr:GetQWorldEntityMgr():SetTrackEnable(arg_25_1, true)
end

function QWorldQuestMgr:_OnQuestOptionClick(arg_26_1, arg_26_2)
	local var_26_0 = QWorldQuestData:GetMainQuestData(-arg_26_2)

	if QWorldQuestTool.IsMainQuestCanReceive(-arg_26_2) then
		QWorldQuestAction.TakeMainQuest(-arg_26_2, function()
			self:UpdateEntityQuestBubble(arg_26_1)
		end)
	end
end

function QWorldQuestMgr:_StopTimer()
	if self.timerNotifyServer_ then
		self.timerNotifyServer_:Stop()

		self.timerNotifyServer_ = nil
	end

	if self.timerFinishQuest_ then
		self.timerFinishQuest_:Stop()

		self.timerFinishQuest_ = nil
	end
end

function QWorldQuestMgr:_ShouldUpdateQuests(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(QWorldQuestData:GetMainQuestData(arg_29_1).taskIdList) do
		if QWorldQuestData:GetQuestData(iter_29_1).status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			if SandplayTaskCfg[iter_29_1].condition == 61 then
				if manager.time:parseTimeFromConfig({
					{
						SandplayTaskCfg[iter_29_1].additional_parameter[1],
						SandplayTaskCfg[iter_29_1].additional_parameter[2],
						SandplayTaskCfg[iter_29_1].additional_parameter[3]
					},
					{
						SandplayTaskCfg[iter_29_1].additional_parameter[4],
						SandplayTaskCfg[iter_29_1].additional_parameter[5],
						SandplayTaskCfg[iter_29_1].additional_parameter[6]
					}
				}) <= manager.time:GetServerTime() then
					return true, iter_29_1
				else
					return true
				end
			end
		end
	end

	return false
end

function QWorldQuestMgr:_CheckNotifyServerTimer(arg_30_1)
	if not self:_ShouldUpdateQuests(arg_30_1) then
		return
	end

	if not table.indexof(self.mainQuestsNotifyServer_, arg_30_1) then
		table.insert(self.mainQuestsNotifyServer_, arg_30_1)
	end

	if not self.timerNotifyServer_ then
		self.timerNotifyServer_ = Timer.New(function()
			local var_31_0 = false
			local var_31_1 = false
			local var_31_2 = #self.mainQuestsNotifyServer_

			while var_31_2 > 0 do
				local var_31_3, var_31_4 = self:_ShouldUpdateQuests(self.mainQuestsNotifyServer_[var_31_2])

				if var_31_3 then
					if var_31_4 then
						var_31_1 = true
					end

					var_31_0 = true
				else
					table.removebyvalue(self.mainQuestsNotifyServer_, self.mainQuestsNotifyServer_[var_31_2])
				end

				var_31_2 = var_31_2 - 1
			end

			if var_31_0 then
				if var_31_1 then
					QWorldQuestAction.NotifyServerUpdateQuests()
				end

				manager.notify:CallUpdateFunc("OnQWorldQuestUpdateProgress")
			else
				self.timerNotifyServer_:Stop()

				self.timerNotifyServer_ = nil
			end
		end, 5, -1)

		self.timerNotifyServer_:Start()
	end
end

function QWorldQuestMgr:_OnUpdateMapQuestInfoWrapped(arg_32_1)
	local var_32_0 = {}

	QWorldQuestGraph:GetTrackingEntityIdListRaw(arg_32_1, var_32_0)
	self:OnUpdateMapQuestInfo(arg_32_1, var_32_0, QWorldQuestTool.GetQuestStatus(arg_32_1) == QWorldQuestConst.QUEST_STATUS.FINISH)
end

function QWorldQuestMgr:_FinishMainQuest(arg_33_1)
	print(string.format("自动完成主任务[%s]", table.concat(arg_33_1, ", ")))

	self.__isSendingFinishMainQuest = true

	QWorldQuestAction.SubmitMainQuest(arg_33_1, function(arg_34_0)
		self.__isSendingFinishMainQuest = false

		if not isSuccess(arg_34_0.result) then
			return
		end

		for iter_34_0, iter_34_1 in ipairs(arg_33_1) do
			if SandplayTaskMainCfg[iter_34_1].important_reward and SandplayTaskMainCfg[iter_34_1].important_reward ~= "" then
				QWorldNotifyQueue:GetCriticalRewards(formatRewardCfgList(SandplayTaskMainCfg[iter_34_1].important_reward))
			end
		end

		QWorldNotifyQueue:GetRewards(arg_34_0.reward_list)
		QWorldNotifyQueue:MainQuestsFinish(arg_33_1)

		local var_34_0 = QWorldQuestData:GetMainQuestTrackingIdRaw()

		if table.indexof(arg_33_1, var_34_0) then
			local var_34_1 = SandplayTaskMainCfg[var_34_0].next_main_mission

			if SandplayTaskMainCfg[var_34_0].next_main_mission == 0 or QWorldQuestTool.IsMainQuestFinish(var_34_1) then
				var_34_1 = QWorldQuestTool.FindFirstTrackableMainQuestId()
			end

			if var_34_1 ~= -1 and QWorldQuestData:GetMainQuestData(var_34_1) then
				QWorldQuestAction.UpdateTrackingMainQuestId(var_34_1, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_34_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
				end)
			else
				QWorldQuestAction.UpdateTrackingMainQuestId(-1)
			end
		elseif QWorldQuestTool.GetMainQuestTrackingId() == -1 then
			local var_34_2 = false
			local var_34_3 = 0

			for iter_34_2, iter_34_3 in ipairs(arg_33_1) do
				if SandplayTaskMainCfg[iter_34_3].next_main_mission ~= 0 and QWorldQuestTool.IsMainQuestTrackable(SandplayTaskMainCfg[iter_34_3].next_main_mission, true) then
					var_34_3 = SandplayTaskMainCfg[iter_34_3].next_main_mission
				end

				if SandplayTaskMainCfg[iter_34_3].hide_task == 0 then
					var_34_2 = true
				end
			end

			if var_34_3 == 0 then
				var_34_3 = var_34_2 and QWorldQuestTool.FindFirstTrackableMainQuestId() or -1
			end

			if var_34_3 ~= -1 and QWorldQuestData:GetMainQuestData(var_34_3) then
				QWorldQuestAction.UpdateTrackingMainQuestId(var_34_3, function()
					QWorldQuestAction.SendUpdateQuestTrackToSdk(var_34_3, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.AUTO_TRACK)
				end)
			end
		end
	end)
end

function QWorldQuestMgr:_FinishQuest(arg_37_1)
	print(string.format("自动完成任务[%s]", table.concat(arg_37_1, ", ")))

	self.__isSendingFinishQuest = true

	QWorldQuestAction.SubmitQuest(arg_37_1, function(arg_38_0)
		self.__isSendingFinishQuest = false

		if not isSuccess(arg_38_0.result) then
			return
		end

		QWorldNotifyQueue:GetRewards(arg_38_0.reward_list)

		for iter_38_0, iter_38_1 in ipairs(arg_37_1) do
			QWorldQuestGraph:UpdateQuestGraph(iter_38_1)
		end
	end)
end

function QWorldQuestMgr:_PushFinishQuest(arg_39_1, arg_39_2)
	if arg_39_2 and not table.indexof(self.finishQuests_, arg_39_2) then
		table.insert(self.finishQuests_, arg_39_2)
	end

	if arg_39_1 and not table.indexof(self.finishMainQuests_, arg_39_1) then
		table.insert(self.finishMainQuests_, arg_39_1)
	end

	if not self.timerFinishQuest_ then
		self.timerFinishQuest_ = Timer.New(function()
			local var_40_0 = true

			if #self.finishQuests_ > 0 then
				var_40_0 = false

				if not self.__isSendingFinishQuest then
					self:_FinishQuest(self.finishQuests_)

					self.finishQuests_ = {}
				end
			end

			if #self.finishMainQuests_ > 0 then
				var_40_0 = false

				if not self.__isSendingFinishMainQuest then
					self:_FinishMainQuest(self.finishMainQuests_)

					self.finishMainQuests_ = {}
				end
			end

			if var_40_0 then
				self.timerFinishQuest_:Stop()

				self.timerFinishQuest_ = nil
			end
		end, 0.1, -1)

		self.timerFinishQuest_:Start()
	end
end

return QWorldQuestMgr
