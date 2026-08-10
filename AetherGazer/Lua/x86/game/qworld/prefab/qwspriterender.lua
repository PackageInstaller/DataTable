local function var_0_0(arg_1_0, arg_1_1)
	local var_1_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_1_0, arg_1_1, QWORLD_ENTITY_TYPE.DEFAULT)
	local var_1_1 = QWorldLuaBridge.GetMapEntityData(arg_1_0)
	local var_1_2 = string.isNullOrEmpty(var_1_1.spritePath) and "QWWorld/Game/Props_lattice_wall_1" or var_1_1.spritePath
	local var_1_3 = Asset.Instantiate(var_1_2)

	var_1_3.transform.parent = var_1_0:GetTransform()
	var_1_3.transform.localPosition = Vector3.zero
	var_1_3.transform.localRotation = Quaternion.identity
	var_1_3:GetComponent("SpriteRenderer").size = var_1_1.size

	return var_1_0
end

return QWorldPrefab.New("QWSpriteRender", var_0_0)
