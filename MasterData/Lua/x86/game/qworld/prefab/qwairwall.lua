return QWorldPrefab.New("QWAirWall", function(arg_1_0, arg_1_1)
	local var_1_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_1_0, arg_1_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_1_0.entity:AddComponent("BoxCollider")

	return var_1_0
end)
