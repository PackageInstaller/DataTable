local function var_0_0(arg_1_0, arg_1_1)
	SetActive(arg_1_0.entity.transform.gameObject, arg_1_1)
end

local function var_0_1(arg_2_0, arg_2_1)
	local var_2_0 = QWorldData:GetCachedPosition()
	local var_2_1 = {
		var_2_0[1],
		",",
		var_2_0[2],
		",",
		var_2_0[3]
	}

	SDKTools.SendMessageToSDK("activity_sandplay_act", {
		type = 10,
		activity_id = QWorldMgr:GetActivityId(),
		stage_id = QWorldMgr:GetMapId(),
		location_id = table.concat(var_2_1),
		params_select = arg_2_0,
		sequence_id = arg_2_1
	})
end

local function var_0_2(arg_3_0)
	var_0_1(arg_3_0.entityId, arg_3_0.localData.childCount + 1)

	arg_3_0.localData.isStart = false

	for iter_3_0, iter_3_1 in pairs(arg_3_0.localData.childUnits) do
		iter_3_1:Remove()
	end

	arg_3_0:Remove()
	QWorldMgr:GetQWorldQuestMgr():OnMiniGameChangeState(arg_3_0.entityId, true)
end

local function var_0_3(arg_4_0, arg_4_1)
	if not arg_4_0.localData.isStart then
		return
	end

	var_0_1(arg_4_0.entityId, arg_4_1 and arg_4_1.index or -1)
	var_0_0(arg_4_0, true)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.localData.childUnits) do
		iter_4_1:Remove()
	end

	arg_4_0.localData.childUnits = {}
	arg_4_0.localData.isStart = false
	arg_4_0.localData.nowStep = 1

	manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_refresh", "")
end

local function var_0_4(arg_5_0, arg_5_1)
	if not arg_5_0.localData.isStart then
		return
	end

	local var_5_0 = arg_5_0.localData.childUnits[arg_5_0.localData.nowStep]

	if var_5_0 then
		var_0_0(var_5_0, false)
	end

	var_0_1(arg_5_0.entityId, arg_5_0.localData.nowStep)

	arg_5_0.localData.nowStep = arg_5_0.localData.nowStep + 1

	local var_5_1 = arg_5_0.localData.childUnits[arg_5_0.localData.nowStep]

	if var_5_1 then
		var_0_0(var_5_1, true)
		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_right", "")
	end
end

local function var_0_5(arg_6_0)
	arg_6_0.localData.childUnits = {}

	local var_6_0 = QWorldLuaBridge.GetMapEntityData(arg_6_0.entityId)
	local var_6_1 = var_6_0.entity_child_list.Count

	arg_6_0.localData.childCount = var_6_1

	for iter_6_0 = 0, var_6_1 - 1 do
		local var_6_2 = var_6_0.entity_child_list[iter_6_0]
		local var_6_3 = QWorldLuaBridge.GetMapEntityData(var_6_2)
		local var_6_4 = arg_6_0:SpawnChild(var_6_3.script_name, var_6_2, var_6_3.configId)
		local var_6_5 = var_6_3.index

		arg_6_0.localData.childUnits[var_6_5] = var_6_4

		var_6_4.entity:SetBuild(var_6_3.isLast and "QWWorld/Effect/fx_yahaha_catch_footprint_white" or "QWWorld/Effect/fx_yahaha_catch_footprint")
		var_0_0(var_6_4, false)

		var_6_4.localData.hasEnter = true
		var_6_4.localData.hasExit = true
		var_6_4.localData.index = var_6_5
		var_6_4.localData.isLast = var_6_3.isLast

		arg_6_0:ListenForEvent("reset_game", function(arg_7_0, arg_7_1)
			var_0_3(arg_6_0, arg_7_1)
		end, var_6_4)
		arg_6_0:ListenForEvent("next_step", function(arg_8_0, arg_8_1)
			var_0_4(arg_6_0, arg_8_1)
		end, var_6_4)

		if var_6_4.localData.isLast then
			arg_6_0:ListenForEvent("success_game", function(arg_9_0, arg_9_1)
				var_0_2(arg_6_0, arg_9_1)
			end, var_6_4)
		end
	end
end

local function var_0_6(arg_10_0)
	if arg_10_0.localData.isStart == true then
		return
	end

	arg_10_0.localData.isStart = true
	arg_10_0.localData.nowStep = 1

	var_0_5(arg_10_0)
	var_0_0(arg_10_0, false)
	var_0_4(arg_10_0)
end

local function var_0_7(arg_11_0)
	var_0_6(arg_11_0)
end

local function var_0_8(arg_12_0)
	var_0_3(arg_12_0)
end

local function var_0_9(arg_13_0, arg_13_1)
	local var_13_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_13_0, arg_13_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_13_0.entityId = arg_13_0
	var_13_0.configId = arg_13_1

	var_13_0.entity:SetBuild("QWWorld/Effect/fx_yahaha_catch_footprint")
	var_13_0.entity:AddComponent("QWSphereTriggerArea")

	var_13_0.OnEnterSphereArea = var_0_7
	var_13_0.OnExitSphereArea = var_0_8

	return var_13_0
end

return QWorldPrefab.New("QWCatchFlower", var_0_9)
