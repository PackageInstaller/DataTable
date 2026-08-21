local function var_0_0(arg_1_0, arg_1_1)
	return (QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_1_0, arg_1_1, QWORLD_ENTITY_TYPE.DEFAULT))
end

return QWorldPrefab.New("QWCommon", var_0_0)
