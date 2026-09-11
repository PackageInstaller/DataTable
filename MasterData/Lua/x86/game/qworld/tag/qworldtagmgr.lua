local QWorldTagMgr = class("QWorldTagMgr")

function QWorldTagMgr:Init()
	self.activityTag = {}
	self.questTag = {}
	self.tagEntity = {}

	for iter_1_0, iter_1_1 in ipairs(SandplayTagCfg.all) do
		if SandplayTagCfg[iter_1_1].activityId > 0 then
			if self.activityTag[SandplayTagCfg[iter_1_1].activityId] == nil then
				self.activityTag[SandplayTagCfg[iter_1_1].activityId] = {}
			end

			table.insert(self.activityTag[SandplayTagCfg[iter_1_1].activityId], SandplayTagCfg[iter_1_1].tag_id)
		end

		if SandplayTagCfg[iter_1_1].questId > 0 then
			if self.questTag[SandplayTagCfg[iter_1_1].questId] == nil then
				self.questTag[SandplayTagCfg[iter_1_1].questId] = {}
			end

			table.insert(self.questTag[SandplayTagCfg[iter_1_1].questId], SandplayTagCfg[iter_1_1].tag_id)
		end
	end

	self.activityUpdateHandle_ = handler(self, self.OnActivityUpdate)

	manager.notify:RegistListener(ACTIVITY_UPDATE, self.activityUpdateHandle_)

	self.questUpdateHandle_ = handler(self, self.OnQuestFinish)

	manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, self.questUpdateHandle_)
end

function QWorldTagMgr:CheckHasActivityTag(arg_2_1)
	if self.activityTag[arg_2_1] then
		return true
	end

	return false
end

function QWorldTagMgr:CheckHasQuestTag(arg_3_1)
	if self.questTag[arg_3_1] then
		return true
	end

	return false
end

function QWorldTagMgr:CheckTagCanOpen(arg_4_1)
	local var_4_0 = true

	if not SandplayTagCfg[arg_4_1] then
		var_4_0 = false
	else
		if SandplayTagCfg[arg_4_1].activityId > 0 then
			var_4_0 = var_4_0 and ActivityData:GetActivityIsOpen(SandplayTagCfg[arg_4_1].activityId)
		end

		if SandplayTagCfg[arg_4_1].questId > 0 then
			var_4_0 = var_4_0 and QWorldQuestTool.IsSubQuestFinish(SandplayTagCfg[arg_4_1].questId)
		end
	end

	return var_4_0
end

function QWorldTagMgr:RegisterTagEntity(arg_5_1, arg_5_2)
	self.tagEntity[arg_5_1] = self.tagEntity[arg_5_1] or {}

	if arg_5_2 and not self.tagEntity[arg_5_1][arg_5_2] then
		self.tagEntity[arg_5_1][arg_5_2] = true
	end
end

function QWorldTagMgr:OnActivityUpdate(arg_6_1)
	if not self:CheckHasActivityTag(arg_6_1) or not IsQworldRunning() then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(self.activityTag[arg_6_1]) do
		if self.tagEntity[iter_6_1] then
			for iter_6_2, iter_6_3 in pairs(self.tagEntity[iter_6_1]) do
				if iter_6_3 then
					local var_6_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_6_2)

					if var_6_0 then
						manager.notify:Invoke(QWORLD_TAG_ACTIVE_CHANGE, iter_6_1)

						if ActivityData:GetActivityIsOpen(arg_6_1) then
							var_6_0:AddTagFromTagSystem(iter_6_1)
						else
							var_6_0:RemoveTagFromTagSystem(iter_6_1)
						end
					end
				end
			end
		end
	end
end

function QWorldTagMgr:OnQuestFinish(arg_7_1)
	if not self:CheckHasQuestTag(arg_7_1) or not IsQworldRunning() then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(self.questTag[arg_7_1]) do
		if self.tagEntity[iter_7_1] then
			for iter_7_2, iter_7_3 in pairs(self.tagEntity[iter_7_1]) do
				if iter_7_3 then
					local var_7_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(iter_7_2)

					if var_7_0 then
						manager.notify:Invoke(QWORLD_TAG_ACTIVE_CHANGE, iter_7_1)

						if QWorldQuestTool.IsSubQuestFinish(arg_7_1) then
							var_7_0:AddTagFromTagSystem(iter_7_1)
						else
							var_7_0:RemoveTagFromTagSystem(iter_7_1)
						end
					end
				end
			end
		end
	end
end

function QWorldTagMgr:GotoTag(arg_8_1, arg_8_2, arg_8_3)
	if SandplayTagCfg[arg_8_1] then
		local var_8_0 = {}

		var_8_0.cameraPosition = manager.ui.mainCamera.transform.position
		var_8_0.cameraRotation = manager.ui.mainCamera.transform.rotation

		if self:NeedCacheTag(SandplayTagCfg[arg_8_1].tag_behaviour) then
			var_8_0.cacheTag = arg_8_1
		end

		QWorldData:SetQWorldContext(var_8_0)
		QWorldGoto:SetTagId(arg_8_1)
		QWorldGoto:Goto(SandplayTagCfg[arg_8_1].tag_behaviour, arg_8_2, SandplayTagCfg[arg_8_1].behaviour_parameters, SandplayTagCfg[arg_8_1].passthrough_parameters, SandplayTagCfg[arg_8_1].camera_parameters, arg_8_3)
	else
		print("未找到标签" .. arg_8_1)
	end
end

function QWorldTagMgr:Dispose()
	manager.notify:RemoveListener(ACTIVITY_UPDATE, self.activityUpdateHandle_)
	manager.notify:RemoveListener(QWORLD_SUB_QUEST_FINISH, self.questUpdateHandle_)
end

function QWorldTagMgr:NeedCacheTag(arg_10_1)
	return NEED_CACHE_GOTO_TYPE[arg_10_1] == true
end

return QWorldTagMgr
