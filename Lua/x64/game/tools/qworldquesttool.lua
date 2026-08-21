local var_0_0 = {
	IsMainQuestTrackable = function(arg_1_0, arg_1_1, arg_1_2)
		if arg_1_0 == -1 then
			return false
		end

		local var_1_0 = QWorldQuestData:GetMainQuestData(arg_1_0)

		if not var_1_0 then
			return false
		end

		local var_1_1 = SandplayTaskMainCfg[arg_1_0]

		if not arg_1_2 and var_1_1.hide_task ~= 0 then
			return false
		end

		local var_1_2 = var_1_1.main_task_type
		local var_1_3 = var_1_0.status

		if var_1_3 == QWorldQuestConst.MAIN_QUEST_STATUS.UNLOCK then
			return false
		end

		if not QWorldQuestTool.IsCurMapMainQuest(arg_1_0) then
			return false
		end

		if not arg_1_1 and var_1_3 == QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE then
			return true
		end

		if var_1_3 == QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS then
			return true
		end

		return false
	end,
	FindFirstTrackableMainQuestId = function()
		local var_2_0 = QWorldQuestData:GetMainQuestTrackingIdRaw()

		if var_2_0 ~= -1 then
			local var_2_1 = QWorldQuestData:GetMainQuestData(var_2_0)

			if var_2_1 and var_2_1.status == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH then
				local var_2_2 = SandplayTaskMainCfg[var_2_0]

				if var_2_2.next_main_mission ~= 0 and QWorldQuestTool.IsMainQuestTrackable(var_2_2.next_main_mission, true) then
					return var_2_2.next_main_mission
				end
			end
		end

		local var_2_3 = {}

		for iter_2_0, iter_2_1 in ipairs(SandplayTaskMainCfg.all) do
			if QWorldQuestTool.IsMainQuestTrackable(iter_2_1, true) then
				table.insert(var_2_3, iter_2_1)
			end
		end

		table.sort(var_2_3, function(arg_3_0, arg_3_1)
			local var_3_0 = SandplayTaskMainCfg[arg_3_0]
			local var_3_1 = SandplayTaskMainCfg[arg_3_1]

			if var_3_0.priority ~= var_3_1.priority then
				return var_3_0.priority < var_3_1.priority
			end

			if var_3_0.main_task_type ~= var_3_1.main_task_type then
				return var_3_0.main_task_type < var_3_1.main_task_type
			end

			return var_3_0.main_task_id < var_3_1.main_task_id
		end)

		return #var_2_3 > 0 and var_2_3[1] or -1
	end,
	FindAllTrackableMainQuestId = function(arg_4_0, arg_4_1)
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(SandplayTaskMainCfg.all) do
			if QWorldQuestTool.IsMainQuestTrackable(iter_4_1, not arg_4_0, arg_4_1) then
				table.insert(var_4_0, iter_4_1)
			end
		end

		return var_4_0
	end,
	GetQuestTrackingEntityIdList = function(arg_5_0)
		local var_5_0 = QWorldQuestTool.GetMainQuestActiveNpcIdList(arg_5_0)
		local var_5_1 = QWorldQuestTool.GetInProgQuestIdList(arg_5_0)

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			QWorldQuestGraph:GetTrackingEntityIdList(iter_5_1, var_5_0)
		end

		return var_5_0
	end,
	GetMainQuestTrackingId = function()
		local var_6_0 = QWorldQuestData:GetMainQuestTrackingIdRaw()

		if not QWorldQuestTool.IsMainQuestTrackable(var_6_0, true) then
			return -1
		end

		return var_6_0
	end,
	GetCurQuestTrackingEntityIdList = function()
		local var_7_0 = QWorldQuestTool.GetMainQuestTrackingId()

		if var_7_0 == -1 then
			return {}
		end

		return QWorldQuestTool.GetQuestTrackingEntityIdList(var_7_0)
	end,
	IsMainQuestCanReceive = function(arg_8_0)
		local var_8_0 = QWorldQuestData:GetMainQuestData(arg_8_0)
		local var_8_1 = SandplayTaskMainCfg[arg_8_0]

		if var_8_0.status == QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE and var_8_1.receive_npc ~= 0 then
			return true
		end

		return false
	end,
	IsQuestCanSubmit = function(arg_9_0)
		local var_9_0 = QWorldQuestData:GetQuestData(arg_9_0)

		if var_9_0.status ~= QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			return false
		end

		local var_9_1 = SandplayTaskCfg[arg_9_0]

		return var_9_0.progress >= var_9_1.need
	end,
	IsMainQuestCanSubmit = function(arg_10_0)
		if QWorldQuestData:GetMainQuestData(arg_10_0).status ~= QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS then
			return false
		end

		local var_10_0 = SandplayTaskMainCfg[arg_10_0].end_task_id
		local var_10_1 = QWorldQuestData:GetQuestData(var_10_0)

		return var_10_1 and var_10_1.status == QWorldQuestConst.QUEST_STATUS.FINISH
	end,
	GetQuestStatus = function(arg_11_0)
		local var_11_0 = QWorldQuestData:GetQuestData(arg_11_0)

		if var_11_0 then
			return var_11_0.status
		else
			return QWorldQuestConst.QUEST_STATUS.NOT_START
		end
	end
}

function var_0_0.IsSubQuestFinish(arg_12_0)
	return var_0_0.GetQuestStatus(arg_12_0) == QWorldQuestConst.QUEST_STATUS.FINISH
end

function var_0_0.GetMainQuestStatus(arg_13_0)
	local var_13_0 = QWorldQuestData:GetMainQuestData(arg_13_0)

	if var_13_0 then
		return var_13_0.status
	else
		return QWorldQuestConst.MAIN_QUEST_STATUS.LOCKED
	end
end

function var_0_0.GetInProgQuestIdList(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = QWorldQuestData:GetMainQuestData(arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_1.taskIdList) do
		if QWorldQuestData:GetQuestData(iter_14_1).status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return var_14_0
end

function var_0_0.GetNpcMainQuestReceiveList(arg_15_0)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(SandplayTaskMainCfg.all) do
		if QWorldQuestTool.IsMainQuestTrackable(iter_15_1) then
			local var_15_1 = QWorldQuestData:GetMainQuestData(iter_15_1)
			local var_15_2 = SandplayTaskMainCfg[iter_15_1]

			if var_15_1.status == QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE and var_15_2.receive_npc == arg_15_0 then
				table.insert(var_15_0, iter_15_1)
			end
		end
	end

	return var_15_0
end

function var_0_0.IsNpcInMainQuest(arg_16_0, arg_16_1)
	local var_16_0 = QWorldQuestTool.GetInProgQuestIdList(arg_16_1)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = {}

		QWorldQuestGraph:GetTrackingEntityIdList(iter_16_1, var_16_1)

		if table.indexof(var_16_1, arg_16_0) then
			return true
		end
	end

	return false
end

function var_0_0.GetEntitySortedMainQuestList(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(SandplayTaskMainCfg.all) do
		if QWorldQuestTool.IsMainQuestTrackable(iter_17_1) then
			local var_17_1 = QWorldQuestData:GetMainQuestData(iter_17_1)
			local var_17_2 = SandplayTaskMainCfg[iter_17_1]

			if var_17_1.status == QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE and var_17_2.receive_npc == arg_17_0 then
				table.insert(var_17_0, iter_17_1)
			elseif var_17_1.status == QWorldQuestConst.MAIN_QUEST_STATUS.IN_PROGRESS and QWorldQuestTool.IsNpcInMainQuest(arg_17_0, iter_17_1) then
				table.insert(var_17_0, iter_17_1)
			end
		end
	end

	local var_17_3 = {}

	for iter_17_2, iter_17_3 in ipairs(var_17_0) do
		var_17_3[iter_17_3] = QWorldQuestTool.IsMainQuestCanReceive(iter_17_3)
	end

	local var_17_4 = QWorldQuestTool.GetMainQuestTrackingId()

	table.sort(var_17_0, function(arg_18_0, arg_18_1)
		local var_18_0 = arg_18_0 == var_17_4

		if var_18_0 ~= (arg_18_1 == var_17_4) then
			return var_18_0
		end

		if var_17_3[arg_18_0] ~= var_17_3[arg_18_1] then
			return var_17_3[arg_18_0]
		end

		local var_18_1 = SandplayTaskMainCfg[arg_18_0]
		local var_18_2 = SandplayTaskMainCfg[arg_18_1]

		if var_18_1.priority ~= var_18_2.priority then
			return var_18_1.priority < var_18_2.priority
		end

		return var_18_1.main_task_type < var_18_2.main_task_type
	end)

	return var_17_0
end

function var_0_0.GetMainQuestActiveNpcIdList(arg_19_0)
	local var_19_0 = QWorldQuestData:GetMainQuestData(arg_19_0)
	local var_19_1 = {}
	local var_19_2 = SandplayTaskMainCfg[arg_19_0]

	if var_19_0.status == QWorldQuestConst.MAIN_QUEST_STATUS.UNTAKE and var_19_2.receive_npc ~= 0 then
		table.insert(var_19_1, var_19_2.receive_npc)
	end

	return var_19_1
end

function var_0_0.GetMainQuestHeadIcon(arg_20_0)
	local var_20_0 = QWorldQuestData:GetMainQuestData(arg_20_0)
	local var_20_1 = SandplayTaskMainCfg[arg_20_0].main_task_type
	local var_20_2

	var_20_2 = not QWorldQuestTool.IsMainQuestCanReceive(arg_20_0) and QWorldQuestTool.IsMainQuestCanSubmit(arg_20_0)

	if var_20_1 == QWorldQuestConst.QUEST_TASK_TYPE.MAIN then
		return getSprite("Atlas/SandPlayAtlas", "SandPlay_Questicon_00001")
	elseif var_20_1 == QWorldQuestConst.QUEST_TASK_TYPE.SIDE then
		return getSprite("Atlas/SandPlayAtlas", "SandPlay_Questicon_00002")
	elseif var_20_1 == QWorldQuestConst.QUEST_TASK_TYPE.EXPLORE then
		return getSprite("Atlas/SandPlayAtlas", "SandPlay_Questicon_00003")
	elseif var_20_1 == QWorldQuestConst.QUEST_TASK_TYPE.TREASURE then
		return nil
	end

	return nil
end

function var_0_0.IsCurMapMainQuest(arg_21_0)
	local var_21_0 = QWorldData:GetCurMapId()

	if not var_21_0 then
		return true
	end

	local var_21_1 = SandplayTaskMainCfg[arg_21_0].activity_id
	local var_21_2 = QWorldMgr:GetActivityMap(var_21_1)

	if not var_21_2 then
		return false
	end

	return var_21_2 == var_21_0
end

function var_0_0.IsMainQuestFinish(arg_22_0)
	local var_22_0 = QWorldQuestData:GetMainQuestData(arg_22_0)

	return var_22_0 and var_22_0.status == QWorldQuestConst.MAIN_QUEST_STATUS.FINISH
end

function var_0_0.IsChapterFinish(arg_23_0)
	local var_23_0 = SandplayTaskMainCfg.get_id_list_by_chapter_task_id[arg_23_0]

	if not var_23_0 then
		return false
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if not QWorldQuestTool.IsMainQuestFinish(iter_23_1) then
			return false
		end
	end

	return true
end

function var_0_0.GetVisibleQuestIdList(arg_24_0, arg_24_1)
	local var_24_0 = {}
	local var_24_1 = QWorldQuestData:GetMainQuestData(arg_24_0)

	for iter_24_0, iter_24_1 in ipairs(var_24_1.taskIdList) do
		local var_24_2 = QWorldQuestData:GetQuestData(iter_24_1)

		if (var_24_2.status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS or var_24_2.status == QWorldQuestConst.QUEST_STATUS.FINISH and not arg_24_1) and SandplayTaskCfg[iter_24_1].hide_task == 0 then
			table.insert(var_24_0, iter_24_1)
		end
	end

	table.sort(var_24_0)

	return var_24_0
end

local function var_0_1(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0) do
		if iter_25_1 == arg_25_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetLoadedQuestIdList(arg_26_0)
	local var_26_0 = var_0_0.GetVisibleQuestIdList(arg_26_0)
	local var_26_1 = #var_26_0

	while var_26_1 >= 1 do
		local var_26_2 = var_26_0[var_26_1]
		local var_26_3 = SandplayTaskCfg[var_26_2]

		for iter_26_0 = 1, var_26_1 - 1 do
			local var_26_4 = var_26_0[iter_26_0]
			local var_26_5 = SandplayTaskCfg[var_26_4]

			if var_26_5.pre_task_id ~= nil and type(var_26_5.pre_task_id) == "table" and #var_26_5.pre_task_id > 0 and var_0_1(var_26_5.pre_task_id, var_26_2) and var_26_4 < var_26_2 then
				local var_26_6 = var_26_0[var_26_1]

				table.remove(var_26_0, var_26_1)
				table.insert(var_26_0, iter_26_0, var_26_6)

				var_26_1 = var_26_1 + 1

				break
			end
		end

		var_26_1 = var_26_1 - 1
	end

	local var_26_7 = {}

	for iter_26_1, iter_26_2 in ipairs(var_26_0) do
		local var_26_8 = SandplayTaskCfg[iter_26_2]

		if var_26_8 and var_26_8.is_unload == 1 then
			table.clean(var_26_7)
		end

		table.insert(var_26_7, iter_26_2)
	end

	return var_26_7
end

function var_0_0.GetQuestProgress(arg_27_0)
	local var_27_0 = QWorldQuestGraph:GetQuestLocalProgress(arg_27_0)

	if var_27_0 then
		return var_27_0
	end

	local var_27_1 = QWorldQuestData:GetQuestData(arg_27_0)

	return var_27_1 and var_27_1.progress or -1
end

function var_0_0.GetQuestProgressText(arg_28_0)
	local var_28_0 = SandplayTaskCfg[arg_28_0]

	if var_28_0.condition == 61 then
		local var_28_1 = var_28_0.additional_parameter
		local var_28_2 = manager.time:parseTimeFromConfig({
			{
				var_28_1[1],
				var_28_1[2],
				var_28_1[3]
			},
			{
				var_28_1[4],
				var_28_1[5],
				var_28_1[6]
			}
		})

		return manager.time:GetLostTimeStr(var_28_2, nil, true)
	elseif var_28_0.need > 1 then
		local var_28_3 = QWorldQuestData:GetQuestData(arg_28_0)

		return GetTipsF("VERIFY_ASSETS_PROCESSING_RATE", QWorldQuestTool.GetQuestProgress(arg_28_0), var_28_0.need)
	else
		return ""
	end
end

function var_0_0.MainQuestHasRealtimeProgress(arg_29_0)
	if arg_29_0 == -1 then
		return false
	end

	local var_29_0 = QWorldQuestData:GetMainQuestData(arg_29_0)

	if not var_29_0 then
		return false
	end

	for iter_29_0, iter_29_1 in ipairs(var_29_0.taskIdList) do
		if QWorldQuestData:GetQuestData(iter_29_1).status == QWorldQuestConst.QUEST_STATUS.IN_PROGRESS and SandplayTaskCfg[iter_29_1].condition == 61 then
			return true
		end
	end

	return false
end

return var_0_0
