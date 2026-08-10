local var_0_0 = {
	pass = "QWWorld/Effect/fx_yahaha_step_footprint_blue_",
	start = "QWWorld/Effect/fx_yahaha_step_footprint_",
	fail = "QWWorld/Effect/fx_yahaha_step_footprint_red_",
	win = "QWWorld/Effect/fx_yahaha_step_footprint_green_"
}
local var_0_1

local function var_0_2(arg_1_0, arg_1_1)
	SetActive(arg_1_0.entity.transform.gameObject, arg_1_1)
end

local function var_0_3(arg_2_0, arg_2_1)
	local var_2_0 = QWorldData:GetCachedPosition()
	local var_2_1 = {
		var_2_0[1],
		",",
		var_2_0[2],
		",",
		var_2_0[3]
	}

	SDKTools.SendMessageToSDK("activity_sandplay_act", {
		type = 11,
		activity_id = QWorldMgr:GetActivityId(),
		stage_id = QWorldMgr:GetMapId(),
		location_id = table.concat(var_2_1),
		params_select = arg_2_0,
		sequence_id = arg_2_1
	})
end

local function var_0_4(arg_3_0)
	var_0_3(arg_3_0.entityId, arg_3_0.localData.totalNum + 1)

	arg_3_0.localData.isStart = false

	QWorldMgr:GetQWorldQuestMgr():OnMiniGameChangeState(arg_3_0.entityId, true)
	arg_3_0.entity:SetBuild(var_0_0.win .. 1)

	for iter_3_0, iter_3_1 in pairs(arg_3_0.localData.childUnits) do
		iter_3_1.entity:SetBuild(var_0_0.win .. iter_3_1.localData.index)
	end

	Timer.New(function()
		for iter_4_0, iter_4_1 in pairs(arg_3_0.localData.childUnits) do
			iter_4_1:Remove()
		end

		arg_3_0:Remove()
	end, 1, 1):Start()
end

local function var_0_5(arg_5_0, arg_5_1)
	if not arg_5_0.localData.isStart then
		return
	end

	var_0_3(arg_5_0.entityId, arg_5_1 and arg_5_1.index or -1)

	arg_5_0.localData.isStart = false
	arg_5_0.localData.nowIndex = 1

	arg_5_0.entity:SetBuild(var_0_0.fail .. 1)

	for iter_5_0, iter_5_1 in pairs(arg_5_0.localData.childUnits) do
		iter_5_1.localData.hasEnter = false
		iter_5_1.localData.isStart = false

		iter_5_1.entity:SetBuild(var_0_0.fail .. iter_5_1.localData.index)
	end

	manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_wrong", "")

	var_0_1 = Timer.New(function()
		for iter_6_0, iter_6_1 in pairs(arg_5_0.localData.childUnits) do
			iter_6_1.entity:SetBuild(var_0_0.start .. iter_6_1.localData.index)
		end

		arg_5_0.entity:SetBuild(var_0_0.start .. 1)
		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_refresh", "")
		var_0_1:Stop()

		var_0_1 = nil
	end, 1, 1)

	var_0_1:Start()
end

local function var_0_6(arg_7_0, arg_7_1)
	if not arg_7_0.localData.isStart then
		return
	end

	if arg_7_1.index == arg_7_0.localData.nowIndex + 1 then
		arg_7_0.localData.nowIndex = arg_7_0.localData.nowIndex + 1

		var_0_3(arg_7_0.entityId, arg_7_0.localData.nowIndex)

		local var_7_0 = arg_7_0.localData.childUnits[arg_7_0.localData.nowIndex]

		var_7_0.entity:SetBuild(var_0_0.pass .. var_7_0.localData.index)

		arg_7_0.localData.childUnits[arg_7_1.index + 1].localData.hasEnter = true

		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_right", "")
	else
		var_0_5(arg_7_0, arg_7_1)
	end
end

local function var_0_7(arg_8_0)
	arg_8_0.localData.childUnits = {}

	local var_8_0 = QWorldLuaBridge.GetMapEntityData(arg_8_0.entityId)
	local var_8_1 = var_8_0.entity_child_list.Count

	arg_8_0.localData.totalNum = var_8_1 - 1

	for iter_8_0 = 0, var_8_1 - 1 do
		local var_8_2 = var_8_0.entity_child_list[iter_8_0]
		local var_8_3 = QWorldLuaBridge.GetMapEntityData(var_8_2)
		local var_8_4 = arg_8_0:SpawnChild(var_8_3.script_name, var_8_2, var_8_3.configId)
		local var_8_5 = var_8_3.index

		var_8_4.localData.hasExit = not var_8_3.isAreaNode

		if not var_8_3.isAreaNode then
			arg_8_0.localData.childUnits[var_8_5] = var_8_4
			var_8_4.localData.hasEnter = false
			var_8_4.localData.index = var_8_5
			var_8_4.localData.isLast = var_8_3.isLast

			var_8_4.entity:SetBuild(var_0_0.start .. var_8_5)
			arg_8_0:ListenForEvent("next_step", function(arg_9_0, arg_9_1)
				var_0_6(arg_8_0, arg_9_1)
			end, var_8_4)

			if var_8_4.localData.isLast then
				arg_8_0:ListenForEvent("success_game", function(arg_10_0, arg_10_1)
					var_0_4(arg_8_0, arg_10_1)
				end, var_8_4)
			end
		end

		arg_8_0:ListenForEvent("reset_game", function(arg_11_0, arg_11_1)
			var_0_5(arg_8_0, arg_11_1)
		end, var_8_4)
	end
end

local function var_0_8(arg_12_0)
	if arg_12_0.localData.isStart == true then
		return
	end

	if var_0_1 then
		for iter_12_0, iter_12_1 in pairs(arg_12_0.localData.childUnits) do
			iter_12_1.entity:SetBuild(var_0_0.start .. iter_12_1.localData.index)
		end

		manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_refresh", "")
		var_0_1:Stop()

		var_0_1 = nil
	end

	arg_12_0.localData.isStart = true
	arg_12_0.localData.nowIndex = 1

	arg_12_0.entity:SetBuild(var_0_0.pass .. 1)

	arg_12_0.localData.childUnits[2].localData.hasEnter = true

	manager.audio:PlayEffect("ui_sandplay", "ui_sandplay_x511_action_yhh_right", "")
	var_0_3(arg_12_0.entityId, 1)
end

local function var_0_9(arg_13_0)
	var_0_8(arg_13_0)
end

local function var_0_10(arg_14_0, arg_14_1)
	local var_14_0 = QWorldMgr:GetQWorldEntityMgr():CreateEntity(arg_14_0, arg_14_1, QWORLD_ENTITY_TYPE.DEFAULT)

	var_14_0.entityId = arg_14_0

	var_14_0.entity:SetBuild(var_0_0.start .. 1)
	var_14_0.entity:AddComponent("QWSphereTriggerArea")

	var_14_0.OnEnterSphereArea = var_0_9

	var_0_7(var_14_0)

	return var_14_0
end

return QWorldPrefab.New("QWStepFlower", var_0_10)
