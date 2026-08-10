local function var_0_0(arg_1_0)
	QWorldMgr:GetQWorldEntityMgr():SetTrackEnable(arg_1_0.entityId, true)
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_2_0, arg_2_1, QWORLD_ENTITY_TYPE.ZONE)

	var_2_0.isZone = true

	function var_2_0.CreateMiniMapEntity()
		local var_3_0 = QWorldEntityMiniMap.New(var_2_0)

		var_3_0:SetMiniType(1)

		return var_3_0
	end

	var_2_0.OnRemoveEntity = var_0_0

	return var_2_0
end

return QWorldPrefab.New("QWZone", var_0_1)
