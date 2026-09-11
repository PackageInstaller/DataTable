function QWorldSpawnPrefab(arg_1_0, arg_1_1, arg_1_2)
	return (QWorldMgr:GetQWorldEntityMgr():SpawnPrefab(arg_1_0, arg_1_1, arg_1_2))
end

function QWorldSpawnPrefabAterQuestId(arg_2_0, arg_2_1)
	local var_2_0 = QWorldQuestData:GetQuestData(arg_2_0)

	if var_2_0 and var_2_0.status == QWorldQuestConst.QUEST_STATUS.FINISH then
		QWorldSpawnPrefabByEntityId(arg_2_1)
	else
		QWorldMgr:GetQWorldEntityMgr():RegistSpawnEntityAfterQuest(arg_2_0, arg_2_1)
	end
end

function QWorldSpawnPrefabByEntityId(arg_3_0)
	if QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_3_0) ~= nil then
		return true
	end

	local var_3_0 = QWorldLuaBridge.GetMapEntityData(arg_3_0)

	if var_3_0 == nil then
		return false
	end

	QWorldSpawnPrefab(var_3_0.script_name, var_3_0.id, var_3_0.configId)
	manager.notify:CallUpdateFunc(QWORLD_TRACK_UPDATE)

	local var_3_1 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_3_0)

	if QWorldMgr:GetQWorldQuestMgr() and var_3_1 then
		local var_3_2 = QWorldQuestTool.GetEntitySortedMainQuestList(var_3_1.entityId)
		local var_3_3 = QWorldQuestTool.GetMainQuestTrackingId()

		if #var_3_2 ~= 0 and var_3_3 ~= -1 and table.indexof(var_3_2, var_3_3) then
			QWorldMgr:GetQWorldEntityMgr():TrackId(var_3_1.entityId)
		end

		QWorldMgr:GetQWorldQuestMgr():UpdateEntityQuestIcon(var_3_1)
	end

	return true
end

function QWorldRemovePrefabByEntityId(arg_4_0)
	local var_4_0 = QWorldMgr:GetQWorldEntityMgr():GetEntByEntityId(arg_4_0)

	if var_4_0 ~= nil then
		var_4_0:Remove()

		return true
	end

	return false
end

function QWBoxTriggerEnterAreaFunc(arg_5_0)
	local var_5_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_5_0)

	if var_5_0 and var_5_0.OnQWBoxTriggerArea then
		var_5_0:OnQWBoxTriggerArea(true)
	end
end

function QWBoxTriggerExitAreaFunc(arg_6_0)
	local var_6_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_6_0)

	if var_6_0 and var_6_0.OnQWBoxTriggerArea then
		var_6_0:OnQWBoxTriggerArea(false)
	end
end

function QWSphereEnterAreaFunc(arg_7_0)
	local var_7_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_7_0)

	if var_7_0 and var_7_0.OnEnterSphereArea then
		var_7_0:OnEnterSphereArea()
	end
end

function QWSphereExitAreaFunc(arg_8_0)
	local var_8_0 = QWorldMgr:GetQWorldEntityMgr():GetEnt(arg_8_0)

	if var_8_0 and var_8_0.OnExitSphereArea then
		var_8_0:OnExitSphereArea()
	end
end
