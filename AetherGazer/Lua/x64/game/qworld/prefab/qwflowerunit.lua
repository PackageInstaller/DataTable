local function var_0_0(arg_1_0, arg_1_1)
	if arg_1_0.localData.isStart == true then
		return
	end

	arg_1_0.localData.isStart = true

	if arg_1_0.localData.isLast then
		arg_1_0:PushEvent("success_game")
	else
		arg_1_0:PushEvent("next_step", {
			index = arg_1_0.localData.index
		})
	end
end

local function var_0_1(arg_2_0)
	if arg_2_0.localData.hasEnter then
		var_0_0(arg_2_0)
	else
		arg_2_0:PushEvent("reset_game", {
			index = arg_2_0.localData.index
		})
	end
end

local function var_0_2(arg_3_0)
	if arg_3_0.localData.hasExit then
		arg_3_0:PushEvent("reset_game")
	end
end

local function var_0_3(arg_4_0, arg_4_1)
	local var_4_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_4_0, arg_4_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_4_0.entity:AddComponent("QWSphereTriggerArea")

	var_4_0.OnEnterSphereArea = var_0_1
	var_4_0.OnExitSphereArea = var_0_2

	return var_4_0
end

return QWorldPrefab.New("QWFlowerUnit", var_0_3)
