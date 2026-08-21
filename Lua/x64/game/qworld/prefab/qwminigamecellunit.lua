local function var_0_0(arg_1_0)
	if not isNil(arg_1_0.localData.effect) then
		QWorldLuaBridge.DestroyQWorldAsset(arg_1_0.localData.effect)
	end

	arg_1_0.localData.effect = nil
end

local function var_0_1(arg_2_0, arg_2_1)
	var_0_0(arg_2_0)

	if not isNil(arg_2_0.entity) then
		local var_2_0 = Asset.Instantiate(arg_2_1)

		var_2_0.transform.position = arg_2_0:GetPosition()
		var_2_0.transform.rotation = arg_2_0:GetRotation()

		return var_2_0
	end
end

local function var_0_2(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0:PushEvent("cell_state", {
			cell_uniqueId = arg_3_0.uniqueId
		})
	end
end

local function var_0_3(arg_4_0, arg_4_1)
	local var_4_0 = var_0_1(arg_4_0, arg_4_0.config.collectStartEffect)

	QWorldLuaBridge.DestroyQWorldAsset(var_4_0, 1)

	arg_4_0.localData.effect = var_0_1(arg_4_0, arg_4_0.config.collectNormalEffect)
end

local function var_0_4(arg_5_0, arg_5_1)
	arg_5_0.localData.effect = var_0_1(arg_5_0, arg_5_0.config.collectDirEffect)
end

local function var_0_5(arg_6_0, arg_6_1)
	local var_6_0 = var_0_1(arg_6_0, arg_6_0.config.winEffect)

	QWorldLuaBridge.DestroyQWorldAsset(var_6_0, 1)
end

local function var_0_6(arg_7_0, arg_7_1)
	local var_7_0 = var_0_1(arg_7_0, arg_7_0.config.failEffect)

	QWorldLuaBridge.DestroyQWorldAsset(var_7_0, 1)
end

local function var_0_7(arg_8_0)
	var_0_0(arg_8_0)
end

local function var_0_8(arg_9_0)
	arg_9_0.localData.effect = var_0_1(arg_9_0, arg_9_0.config.startEffect)

	local var_9_0

	var_9_0 = Timer.New(function()
		arg_9_0.localData.effect = var_0_1(arg_9_0, arg_9_0.config.startLoopEffect)

		var_9_0:Stop()

		var_9_0 = nil
	end, 0.3, 1)

	var_9_0:Start()
end

local function var_0_9(arg_11_0, arg_11_1)
	local var_11_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_11_0, arg_11_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_11_0.entityId = arg_11_0
	var_11_0.config = QWorldLuaBridge.GetMapEntityData(var_11_0.entityId)

	var_11_0.entity:AddComponent("QWBoxTriggerArea")

	var_11_0.OnQWBoxTriggerArea = var_0_2

	var_11_0:ListenForEvent("cell_game_success", var_0_5)
	var_11_0:ListenForEvent("cell_game_fail", var_0_6)
	var_11_0:ListenForEvent("cell_correct", var_0_3)
	var_11_0:ListenForEvent("cell_correct_level", var_0_4)

	var_11_0.OnRemoveEntity = var_0_7

	var_0_8(var_11_0)

	return var_11_0
end

return QWorldPrefab.New("QWMiniGameCellUnit", var_0_9)
