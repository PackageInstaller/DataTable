local QWorldEntityMgr = class("QWorldEntityMgr")

QWORLD_ENTITY_TYPE = {
	FUNITURE = 2,
	ZONE = 3,
	DEFAULT = 0,
	NPC = 1
}

local var_0_1 = {}

function QWorldEntityMgr:Init()
	self.Ents = {}
	self._Ents4EntityId = {}
	self.track_entity_id = 0
	self.track_quest_entity_id_list = {}
	self.track_disable_id_list = {}
	self.spawn_after_quest_entitys = {}

	self:InitPlayerContext()

	self.questUpdateHandle = handler(self, self.OnQuestFinish)

	manager.notify:RegistListener(QWORLD_SUB_QUEST_FINISH, self.questUpdateHandle)
	manager.redPoint:addGroup(RedPointConst.QWORLD_MINI_MAP, {}, true)
end

function QWorldEntityMgr:Dispose()
	for iter_2_0, iter_2_1 in pairs(self.Ents) do
		iter_2_1:Remove()
	end

	self.Ents = {}
	self._Ents4EntityId = {}
	self.track_entity_id = 0
	self.track_quest_entity_id_list = {}
	self.track_disable_id_list = {}
	self.spawn_after_quest_entitys = {}

	self:DisposePlayerContext()
	manager.notify:RemoveListener(QWORLD_SUB_QUEST_FINISH, self.questUpdateHandle)

	self.questUpdateHandle = nil
end

function QWorldEntityMgr:GetEnt(arg_3_1)
	return self.Ents[arg_3_1]
end

function QWorldEntityMgr:OnRemoveEntity(arg_4_1)
	if self.Ents[arg_4_1] then
		self:RaiseOnRemoveEntity(self.Ents[arg_4_1])
		QWorldLuaBridge.RemoveMapEntity(arg_4_1)

		self.Ents[arg_4_1] = nil
		self._Ents4EntityId[self.Ents[arg_4_1].entityId] = nil

		self:RemoveTrack(self.Ents[arg_4_1].entityId)
	end
end

function QWorldEntityMgr:SpawnPrefab(arg_5_1, arg_5_2, arg_5_3)
	if var_0_1[arg_5_1] == nil then
		var_0_1[arg_5_1] = import(string.format("game.qworld.prefab.%s", arg_5_1))
	end

	if arg_5_2 == nil then
		arg_5_2 = 0
	end

	if var_0_1[arg_5_1] then
		local var_5_0 = var_0_1[arg_5_1].fn(arg_5_2, arg_5_3)

		if var_5_0 ~= nil then
			var_5_0.entityId = arg_5_2

			self:RaiseOnSpawnEntity(var_5_0)

			return self.Ents[var_5_0.entity.uniqueId]
		else
			print("Failed to spawn", arg_5_1)

			return nil
		end
	end
end

function QWorldEntityMgr:CreateEntity(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = QWorldLuaBridge.CreateMapEntity(arg_6_1, arg_6_3)
	local var_6_1 = QWorldEntiyScript.New(var_6_0, arg_6_3, arg_6_1, arg_6_2)

	self.Ents[var_6_0.uniqueId] = var_6_1
	self._Ents4EntityId[arg_6_1] = var_6_1

	return var_6_1
end

function QWorldEntityMgr:GetEntByEntityId(arg_7_1)
	return self._Ents4EntityId[arg_7_1]
end

function QWorldEntityMgr:RegistSpawnEntityAfterQuest(arg_8_1, arg_8_2)
	if self.spawn_after_quest_entitys[arg_8_1] == nil then
		self.spawn_after_quest_entitys[arg_8_1] = {}
	end

	table.insert(self.spawn_after_quest_entitys[arg_8_1], arg_8_2)
end

function QWorldEntityMgr:OnQuestFinish(arg_9_1)
	if self.spawn_after_quest_entitys[arg_9_1] then
		for iter_9_0, iter_9_1 in ipairs(self.spawn_after_quest_entitys[arg_9_1]) do
			QWorldSpawnPrefabByEntityId(iter_9_1)
		end

		self.spawn_after_quest_entitys[arg_9_1] = nil
	end

	self:PostQuestPlayerCheck(arg_9_1)
end

function QWorldEntityMgr:GetMiniMapBoardList()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.Ents) do
		if iter_10_1.miniMapUnit then
			for iter_10_2, iter_10_3 in pairs((iter_10_1.miniMapUnit:GetBoardDict())) do
				table.insert(var_10_0, iter_10_3)
			end
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		if arg_11_0.tag == arg_11_1.tag and QWorldEntityMiniMapTag.Hud == arg_11_0.tag then
			if SandplayTagCfg[arg_11_0.param].sort ~= SandplayTagCfg[arg_11_1.param].sort then
				return SandplayTagCfg[arg_11_0.param].sort > SandplayTagCfg[arg_11_1.param].sort
			else
				return arg_11_0.param < arg_11_1.param
			end
		end

		return arg_11_0.tag > arg_11_1.tag
	end)

	return var_10_0
end

function QWorldEntityMgr:TrackId(arg_12_1)
	if table.indexof(self.track_quest_entity_id_list, arg_12_1) then
		return
	end

	self.track_entity_id = arg_12_1

	self:UpdateTrack()
end

function QWorldEntityMgr:TrackQuest(arg_13_1)
	if table.indexof(arg_13_1, self.track_entity_id) then
		self.track_entity_id = 0
	end

	self.track_quest_entity_id_list = arg_13_1

	self:UpdateTrack()
end

function QWorldEntityMgr:IsTrack(arg_14_1)
	if arg_14_1 == self.track_entity_id then
		return true
	end

	return table.indexof(self.track_quest_entity_id_list, arg_14_1)
end

function QWorldEntityMgr:RemoveTrack(arg_15_1)
	if arg_15_1 == self.track_entity_id then
		self.track_entity_id = 0

		self:UpdateTrack()

		return
	end

	local var_15_0 = table.indexof(self.track_quest_entity_id_list, arg_15_1)

	if var_15_0 then
		table.remove(self.track_quest_entity_id_list, var_15_0)
		self:UpdateTrack()

		return
	end
end

function QWorldEntityMgr:CancelTrack(arg_16_1)
	if arg_16_1 == self.track_entity_id then
		self.track_entity_id = 0

		self:UpdateTrack()

		local var_16_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_16_1)

		if var_16_0.thingCfg and var_16_0.thingCfg.label[1] and SandPlayTakePhotoTools.CheckIsPhotoTag(var_16_0.thingCfg.label[1]) and var_16_0 then
			var_16_0:RemoveMiniMapEntity(QWorldEntityMiniMapTag.Thing, SandplayThingCfg[var_16_0.configId].label[1])
		end

		return
	end

	if table.indexof(self.track_quest_entity_id_list, arg_16_1) then
		local var_16_1 = QWorldQuestTool.GetMainQuestTrackingId()

		QWorldQuestAction.UpdateTrackingMainQuestId(-1)

		if var_16_1 ~= -1 then
			QWorldQuestAction.SendUpdateQuestTrackToSdk(var_16_1, QWorldQuestConst.SDK_QUEST_TRACK_TYPE.UNTRACK)
		end
	end
end

function QWorldEntityMgr:SetTrackEnable(arg_17_1, arg_17_2)
	local var_17_0 = table.indexof(self.track_disable_id_list, arg_17_1)

	if arg_17_2 then
		if var_17_0 then
			table.remove(self.track_disable_id_list, var_17_0)

			if table.indexof(self.track_quest_entity_id_list, arg_17_1) then
				self:UpdateTrack()
			end
		end
	elseif not var_17_0 then
		table.insert(self.track_disable_id_list, arg_17_1)

		if table.indexof(self.track_quest_entity_id_list, arg_17_1) then
			self:UpdateTrack()
		end
	end
end

function QWorldEntityMgr:GetTrackEntityIds()
	if self.track_entity_id == 0 and #self.track_quest_entity_id_list == 0 then
		return {}
	elseif self.track_entity_id == 0 then
		if #self.track_disable_id_list > 0 then
			local var_18_0 = {}

			for iter_18_0, iter_18_1 in ipairs(self.track_quest_entity_id_list) do
				if not table.indexof(self.track_disable_id_list, iter_18_1) then
					table.insert(var_18_0, iter_18_1)
				end
			end

			return var_18_0
		else
			return self.track_quest_entity_id_list or {}
		end
	else
		local var_18_2 = {}

		table.insert(var_18_2, self.track_entity_id)

		for iter_18_2, iter_18_3 in ipairs(self.track_quest_entity_id_list) do
			if not table.indexof(self.track_disable_id_list, iter_18_3) then
				table.insert(var_18_2, iter_18_3)
			end
		end

		return var_18_2
	end
end

function QWorldEntityMgr:UpdateTrack()
	QWorldLuaBridge.TrackMapEntity(self:GetTrackEntityIds())
	manager.notify:CallUpdateFunc(QWORLD_TRACK_UPDATE)
end

function QWorldEntityMgr:RebuildEntity(arg_20_1)
	for iter_20_0, iter_20_1 in pairs(self.Ents) do
		if iter_20_1.type == arg_20_1 and iter_20_1.thingCfg and iter_20_1.thingCfg.model_path and iter_20_1.thingCfg.model_path ~= "" then
			iter_20_1.entity:SetBuild(iter_20_1.thingCfg.model_path)
		end
	end
end

function QWorldEntityMgr:RaiseOnSpawnEntity(arg_21_1)
	if QWorldMgr:GetQWorldQuestMgr() then
		QWorldMgr:GetQWorldQuestMgr():OnSpawnEntity(arg_21_1)
	end
end

function QWorldEntityMgr:RaiseOnRemoveEntity(arg_22_1)
	if QWorldMgr:GetQWorldQuestMgr() then
		QWorldMgr:GetQWorldQuestMgr():OnRemoveEntity(arg_22_1)
	end
end

function QWorldEntityMgr:InitPlayerContext()
	self.playerContext = {
		priority = -1,
		id = SandPlayMapCfg[QWorldMgr:GetMapId()].hero_id
	}
	self.postQuestPlayer = {}

	self:AddPlayerListener()
end

function QWorldEntityMgr:DisposePlayerContext()
	self.postQuestPlayer = {}
	self.playerContext = {}
end

function QWorldEntityMgr:PostQuestPlayerCheck(arg_25_1)
	if self.postQuestPlayer[arg_25_1] and self.postQuestPlayer[arg_25_1].priority > self.playerContext.priority then
		self.playerContext.id = self.postQuestPlayer[arg_25_1].hero
		self.playerContext.priority = self.postQuestPlayer[arg_25_1].priority
	end

	if self.playerContext.id ~= self.postQuestPlayer.id then
		self:ChangePlayer()
	end
end

function QWorldEntityMgr:RefreshCurrentPlayerData()
	local var_26_0 = SandPlayMapCfg[QWorldMgr:GetMapId()].hero_replace

	if var_26_0 and var_26_0 ~= "" then
		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if iter_26_1 and iter_26_1[1] and iter_26_1[2] and iter_26_0 > self.playerContext.priority and QWorldQuestTool.IsSubQuestFinish(iter_26_1[1]) then
				self.playerContext.id = iter_26_1[2]
				self.playerContext.priority = iter_26_0
			end
		end
	end

	if self.playerContext.id ~= self.postQuestPlayer.id then
		self:ChangePlayer()
	end
end

function QWorldEntityMgr:ChangePlayer()
	QWorldLuaBridge.SwitchControlCharacter(self.playerContext.id)
end

function QWorldEntityMgr:GetCurrentPlayerId()
	return self.playerContext.id
end

function QWorldEntityMgr:AddPlayerListener()
	local var_29_0 = SandPlayMapCfg[QWorldMgr:GetMapId()].hero_replace

	if var_29_0 and var_29_0 ~= "" then
		for iter_29_0, iter_29_1 in ipairs(var_29_0) do
			if iter_29_1 and iter_29_1[1] and iter_29_1[2] then
				self.postQuestPlayer[iter_29_1[1]] = {
					quest = iter_29_1[1],
					hero = iter_29_1[2],
					priority = iter_29_0
				}
			end
		end
	end
end

return QWorldEntityMgr
