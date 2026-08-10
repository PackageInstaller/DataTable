local var_0_0 = {}

local function var_0_1(arg_1_0, arg_1_1)
	if QWorldMgr:GetQWorldQuestMgr() then
		QWorldMgr:GetQWorldQuestMgr():OnQuestUpdate(arg_1_1)

		if arg_1_0 then
			QWorldQuestGraph:DispatchQuestEvent(arg_1_0, arg_1_1)
		end
	end
end

local function var_0_2(arg_2_0)
	if QWorldMgr:GetQWorldQuestMgr() then
		QWorldMgr:GetQWorldQuestMgr():OnMainQuestUpdate(arg_2_0.id)
	end
end

local function var_0_3(arg_3_0)
	manager.notify:Invoke(QWORLD_MAIN_QUEST_FINISH, arg_3_0)
	SandplayIlluAction.ModifyMainQuestID(arg_3_0)
end

local function var_0_4(arg_4_0)
	manager.notify:Invoke(QWORLD_SUB_QUEST_FINISH, arg_4_0)
	QWorldNotifyQueue:SubQuestFinish(arg_4_0)
end

manager.net:Bind(28801, function(arg_5_0)
	QWorldQuestData:InitData(arg_5_0)
end)
manager.net:Bind(28803, function(arg_6_0)
	QWorldQuestData:UpdateQuest(arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.quest_list) do
		var_0_2(iter_6_1)
	end
end)
manager.net:Bind(28805, function(arg_7_0)
	QWorldQuestData:CancelMainQuest(arg_7_0)
end)

function var_0_0.SubmitMainQuest(arg_8_0, arg_8_1)
	local var_8_0 = {
		quest_id_list = arg_8_0
	}

	manager.net:SendWithLoadingNew(28820, var_8_0, 28821, function(arg_9_0, arg_9_1)
		if isSuccess(arg_9_0.result) then
			QWorldQuestData:FinishMainQuest(arg_8_0)

			if arg_8_1 then
				arg_8_1(arg_9_0, arg_9_1)
			end

			for iter_9_0, iter_9_1 in ipairs(arg_8_0) do
				var_0_3(iter_9_1)
			end
		else
			ShowTips(arg_9_0.result)

			if arg_8_1 then
				arg_8_1(arg_9_0, arg_9_1)
			end
		end
	end)
end

function var_0_0.SubmitQuest(arg_10_0, arg_10_1)
	local var_10_0 = {
		quest_task_id = arg_10_0
	}

	manager.net:SendWithLoadingNew(28822, var_10_0, 28823, function(arg_11_0, arg_11_1)
		if isSuccess(arg_11_0.result) then
			QWorldQuestData:FinishQuest(arg_10_0)

			if arg_10_1 then
				arg_10_1(arg_11_0, arg_11_1)
			end

			for iter_11_0, iter_11_1 in ipairs(arg_10_0) do
				var_0_4(iter_11_1)
			end
		else
			ShowTips(arg_11_0.result)

			if arg_10_1 then
				arg_10_1(arg_11_0, arg_11_1)
			end
		end
	end)
end

function var_0_0.TakeMainQuest(arg_12_0, arg_12_1)
	local var_12_0 = {
		quest_id = arg_12_0
	}

	manager.net:SendWithLoadingNew(28830, var_12_0, 28831, function(arg_13_0, arg_13_1)
		if isSuccess(arg_13_0.result) then
			QWorldQuestData:TakeMainQuest(arg_12_0)

			if arg_12_1 then
				arg_12_1(arg_13_0, arg_13_1)
			end
		else
			ShowTips(arg_13_0.result)
		end
	end)
end

function var_0_0.QuestSetParam(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {
		param = arg_14_0,
		value = arg_14_1
	}

	manager.net:SendWithLoadingNew(28832, var_14_0, 28833, function(arg_15_0, arg_15_1)
		if isSuccess(arg_15_0.result) then
			if arg_14_2 then
				arg_14_2(arg_15_0, arg_15_1)
			end
		else
			ShowTips(arg_15_0.result)

			if arg_14_2 then
				arg_14_2(arg_15_0, arg_15_1)
			end
		end
	end)
end

function var_0_0.NotifyServerUpdateQuests(arg_16_0)
	QWorldQuestAction.QuestSetParam(0, 1, arg_16_0)
end

function var_0_0.UpdateTrackingMainQuestId(arg_17_0, arg_17_1)
	local var_17_0 = QWorldQuestData:GetMainQuestTrackingIdRaw()

	QWorldQuestData:SetMainQuestTrackingId(arg_17_0)

	if QWorldMgr:GetQWorldQuestMgr() then
		QWorldMgr:GetQWorldQuestMgr():OnUpdateTrackingQuest(arg_17_0, var_17_0)
	end

	if arg_17_1 then
		arg_17_1()
	end
end

function var_0_0.SendUpdateQuestTrackToSdk(arg_18_0, arg_18_1)
	local var_18_0 = QWorldData:GetCurMapId()

	if var_18_0 == 0 then
		return
	end

	local var_18_1

	for iter_18_0, iter_18_1 in ipairs(SandPlayMapCfg.all) do
		local var_18_2 = SandPlayMapCfg[iter_18_1]

		if var_18_2.id == var_18_0 then
			var_18_1 = var_18_2.activity_id

			break
		end
	end

	if not var_18_1 then
		return
	end

	local var_18_3 = SandplayTaskMainCfg[arg_18_0]

	if not var_18_3 then
		return
	end

	local var_18_4 = QWorldQuestData:GetMainQuestData(arg_18_0)

	if not var_18_4 then
		return
	end

	local var_18_5 = {}

	for iter_18_2, iter_18_3 in ipairs(var_18_4.taskIdList) do
		if QWorldQuestData:GetQuestData(iter_18_3).status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			table.insert(var_18_5, iter_18_3)
		end
	end

	local var_18_6 = string.format("[%s]", table.concat(var_18_5, ","))

	SDKTools.SendMessageToSDK("task_accept", {
		activity_id = var_18_1,
		stage_id = var_18_0,
		task_id = arg_18_0,
		params_list = var_18_6,
		task_type = var_18_3.main_task_type,
		opt = arg_18_1
	})
end

return var_0_0
