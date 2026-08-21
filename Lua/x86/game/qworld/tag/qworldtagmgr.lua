local var_0_0 = class("QWorldTagMgr")

function var_0_0.Init(arg_1_0)
	arg_1_0.activityTag = {}
	arg_1_0.questTag = {}
	arg_1_0.tagEntity = {}

	for iter_1_0, iter_1_1 in ipairs(SandplayTagCfg.all) do
		local var_1_0 = SandplayTagCfg[iter_1_1]

		if var_1_0.activityId > 0 then
			if arg_1_0.activityTag[var_1_0.activityId] == nil then
				arg_1_0.activityTag[var_1_0.activityId] = {}
			end

			table.insert(arg_1_0.activityTag[var_1_0.activityId], var_1_0.tag_id)
		end

		if var_1_0.questId > 0 then
			if arg_1_0.questTag[var_1_0.questId] == nil then
				arg_1_0.questTag[var_1_0.questId] = {}
			end

			table.insert(arg_1_0.questTag[var_1_0.questId], var_1_0.tag_id)
		end
	end

	arg_1_0.activityUpdateHandle_ = handler(arg_1_0, arg_1_0.OnActivityUpdate)

	manager.notify:RegistListener(ACTIVITY_UPDATE, arg_1_0.activityUpdateHandle_)

	arg_1_0.questUpdateHandle_ = handler(arg_1_0, arg_1_0.OnQuestFinish)

	manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, arg_1_0.questUpdateHandle_)
end

function var_0_0.CheckHasActivityTag(arg_2_0, arg_2_1)
	if arg_2_0.activityTag[arg_2_1] then
		return true
	end

	return false
end

function var_0_0.CheckHasQuestTag(arg_3_0, arg_3_1)
	if arg_3_0.questTag[arg_3_1] then
		return true
	end

	return false
end

function var_0_0.CheckTagCanOpen(arg_4_0, arg_4_1)
	local var_4_0 = SandplayTagCfg[arg_4_1]
	local var_4_1 = true

	if not var_4_0 then
		var_4_1 = false
	else
		if var_4_0.activityId > 0 then
			var_4_1 = var_4_1 and ActivityData:GetActivityIsOpen(var_4_0.activityId)
		end

		if var_4_0.questId > 0 then
			var_4_1 = var_4_1 and QWorldQuestTool.IsSubQuestFinish(var_4_0.questId)
		end
	end

	return var_4_1
end

function var_0_0.RegisterTagEntity(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.tagEntity[arg_5_1] then
		arg_5_0.tagEntity[arg_5_1] = {}
	end

	if arg_5_2 and not arg_5_0.tagEntity[arg_5_1][arg_5_2] then
		arg_5_0.tagEntity[arg_5_1][arg_5_2] = true
	end
end

function var_0_0.OnActivityUpdate(arg_6_0, arg_6_1)
	if not arg_6_0:CheckHasActivityTag(arg_6_1) or not IsQworldRunning() then
		return
	end

	local var_6_0 = arg_6_0.activityTag[arg_6_1]

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = arg_6_0.tagEntity[iter_6_1]

		if var_6_1 then
			for iter_6_2, iter_6_3 in pairs(var_6_1) do
				if iter_6_3 then
					local var_6_2 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_6_2)

					if var_6_2 then
						manager.notify:Invoke(QWORLD_TAG_ACTIVE_CHANGE, iter_6_1)

						if ActivityData:GetActivityIsOpen(arg_6_1) then
							var_6_2:AddTagFromTagSystem(iter_6_1)
						else
							var_6_2:RemoveTagFromTagSystem(iter_6_1)
						end
					end
				end
			end
		end
	end
end

function var_0_0.OnQuestFinish(arg_7_0, arg_7_1)
	if not arg_7_0:CheckHasQuestTag(arg_7_1) or not IsQworldRunning() then
		return
	end

	local var_7_0 = arg_7_0.questTag[arg_7_1]

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_1 = arg_7_0.tagEntity[iter_7_1]

		if var_7_1 then
			for iter_7_2, iter_7_3 in pairs(var_7_1) do
				if iter_7_3 then
					local var_7_2 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_7_2)

					if var_7_2 then
						manager.notify:Invoke(QWORLD_TAG_ACTIVE_CHANGE, iter_7_1)

						if QWorldQuestTool.IsSubQuestFinish(arg_7_1) then
							var_7_2:AddTagFromTagSystem(iter_7_1)
						else
							var_7_2:RemoveTagFromTagSystem(iter_7_1)
						end
					end
				end
			end
		end
	end
end

function var_0_0.GotoTag(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = SandplayTagCfg[arg_8_1]

	if var_8_0 then
		local var_8_1 = {}
		local var_8_2 = manager.ui.mainCamera.transform

		var_8_1.cameraPosition = var_8_2.position
		var_8_1.cameraRotation = var_8_2.rotation

		if arg_8_0:NeedCacheTag(var_8_0.tag_behaviour) then
			var_8_1.cacheTag = arg_8_1
		end

		QWorldData:SetQWorldContext(var_8_1)
		QWorldGoto:SetTagId(arg_8_1)
		QWorldGoto:Goto(var_8_0.tag_behaviour, arg_8_2, var_8_0.behaviour_parameters, var_8_0.passthrough_parameters, var_8_0.camera_parameters, arg_8_3)
	else
		print("未找到标签" .. arg_8_1)
	end
end

function var_0_0.Dispose(arg_9_0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, arg_9_0.activityUpdateHandle_)
	manager.notify:RemoveListener(QWORLD_SUB_QUEST_FINISH, arg_9_0.questUpdateHandle_)
end

function var_0_0.NeedCacheTag(arg_10_0, arg_10_1)
	return NEED_CACHE_GOTO_TYPE[arg_10_1] == true
end

return var_0_0
