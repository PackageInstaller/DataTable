local var_0_0 = require("Framework.toLua.UnityEngine.Vector2")
local var_0_1 = require("Framework.toLua.UnityEngine.Vector3").zero
local var_0_2 = class("IslandPlayerUnit", import(".IslandNavigableUnit"))
local var_0_3 = 5
local var_0_4 = 150
local var_0_5 = var_0_0(1.8, 1.8)
local var_0_6 = var_0_0(0, 2)
local var_0_7 = bit.bnot(bit.lshift(1, (LayerMask.NameToLayer("IgnoreIslandCharacter"))))
local var_0_8 = {
	LoadToolHandle = 2,
	JumpHandle = 1,
	NoMoveAndWork = 3,
	AttackHandle = 4
}

function var_0_2.OnAttach(arg_1_0, arg_1_1)
	var_0_2.super.OnAttach(arg_1_0, arg_1_1)

	arg_1_0.mapId = getProxy(IslandProxy):GetIsland():GetMapId()
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0.animator = arg_1_0._tf:GetChild(0):GetComponent(typeof(Animator))
	arg_1_0.characterController = arg_1_0._go:GetComponent(typeof(CharacterController))
	arg_1_0.characterHandleController = arg_1_0._go:GetComponent(typeof(CharacterHandleController))
	var_0_3 = pg.island_set.detection_parameters.key_value_varchar[2]
	var_0_4 = pg.island_set.detection_parameters.key_value_varchar[1]
	var_0_6 = var_0_0(0, pg.island_set.detection_parameters.key_value_varchar[3])

	arg_1_0.characterHandleController:SetDrawParameter(var_0_3, var_0_4, pg.island_set.detection_parameters.key_value_varchar[3])
	arg_1_0.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		arg_1_0:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		arg_1_0:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateEnterFixCompleteFunc(function(arg_4_0, arg_4_1)
		arg_1_0:StateEnterFixHandle(arg_4_0, arg_4_1)

		return
	end)
	arg_1_0.characterHandleController:AddStateExitFixCompleteFunc(function(arg_5_0, arg_5_1)
		arg_1_0:StateExitFixHandle(arg_5_0, arg_5_1)

		return
	end)

	arg_1_0.targetSpeed = 0
	arg_1_0.speed = 0
	arg_1_0.gravitySpeed = 0
	arg_1_0.jumpVector = Vector3.zero
	arg_1_0.degreeSpeed = 720
	arg_1_0.maxSpeed = pg.island_set.player_movement_parameters.key_value_varchar[1]
	arg_1_0.sprintSpeed = pg.island_set.player_movement_parameters.key_value_varchar[2]
	arg_1_0.upSpeedDamping = 3
	arg_1_0.downSpeedDamping = 6
	arg_1_0.jumpHeight = pg.island_set.player_movement_parameters.key_value_varchar[3]
	arg_1_0.targetDir = Vector3.zero
	arg_1_0.velocity = Vector3.zero
	arg_1_0.extraVelocity = Vector3.zero
	arg_1_0.isSitting = false
	arg_1_0.prevStandPosition = nil
	arg_1_0.checkInSet = {}
	arg_1_0.lastCrossCount = 0
	arg_1_0.orginTargetDir = var_0_1

	arg_1_0:InitDress()
	arg_1_0:InitFarmCheckWorldObject()

	arg_1_0.objTfList = {}
	arg_1_0.toolIdMap = {}
	arg_1_0.islandid = arg_1_0:GetView():GetIsland().id

	local var_1_0 = getProxy(PlayerProxy)

	arg_1_0.isSelfIsland = var_1_0:getRawData().id == arg_1_0.islandid

	return
end

function var_0_2.InitJump(arg_6_0, arg_6_1)
	arg_6_0.jumpCurve = arg_6_1
	arg_6_0.jumpCruveAllTime = arg_6_0.jumpCurve.keys[arg_6_0.jumpCurve.length - 1].time

	return
end

function var_0_2.OnLateUpdate(arg_7_0)
	return
end

function var_0_2.OnUpdate(arg_8_0)
	arg_8_0:RefreshTemp()
	arg_8_0:PositionTween(Time.deltaTime)
	arg_8_0:Rotation(Time.deltaTime)
	arg_8_0:Move(Time.deltaTime)
	arg_8_0:Detectionobject()

	return
end

function var_0_2.RefreshTemp(arg_9_0)
	arg_9_0.ignoreStepdown = false
	arg_9_0.gravityAcc = IslandConst.GRAVITYACC

	if arg_9_0.orginTargetDir.x ~= 0 or arg_9_0.orginTargetDir.z ~= 0 then
		local var_9_0 = IslandCameraMgr.instance._mainCamera.transform:TransformVector(arg_9_0.orginTargetDir)

		arg_9_0.targetDir = var_0(var_9_0.x, 0, var_9_0.z).normalized

		if arg_9_0.targetDir ~= Vector3.zero then
			arg_9_0.targetRotation = Quaternion.LookRotation(arg_9_0.targetDir)
		end
	end

	return
end

function var_0_2.Rotation(arg_10_0, arg_10_1)
	if arg_10_0.targetRotation then
		arg_10_0._tf.rotation = Quaternion.RotateTowards(arg_10_0._tf.rotation, arg_10_0.targetRotation, arg_10_0.degreeSpeed * arg_10_1)
	end

	return
end

function var_0_2.SetTargetRotation(arg_11_0, arg_11_1)
	arg_11_0.targetRotation = arg_11_1

	return
end

function var_0_2.Move(arg_12_0, arg_12_1)
	arg_12_0.speed = Mathf.Approximately(arg_12_0.speed, arg_12_0.targetSpeed) and arg_12_0.targetSpeed or arg_12_0.targetSpeed > arg_12_0.speed and Mathf.Lerp(arg_12_0.speed, arg_12_0.targetSpeed, arg_12_0.upSpeedDamping * arg_12_1) or Mathf.Lerp(arg_12_0.speed, arg_12_0.targetSpeed, arg_12_0.downSpeedDamping * arg_12_1)

	arg_12_0.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, arg_12_0.speed)

	arg_12_0.velocity = arg_12_0.targetDir * arg_12_0.speed
	arg_12_0.gravitySpeed = arg_12_0.gravitySpeed + arg_12_0.gravityAcc * arg_12_1
	arg_12_0.onGroud = true

	local var_12_0 = 0

	if arg_12_0.gravitySpeed >= 0 then
		local var_12_1, var_12_2 = arg_12_0:CalcGrounded()

		if var_12_1 then
			arg_12_0.gravitySpeed = 0
			var_12_0 = var_12_2
		else
			local var_12_3, var_12_4 = arg_12_0:CalcNotFalling()

			if var_12_3 then
				arg_12_0.gravitySpeed = 0
				var_12_0 = var_12_4
			else
				arg_12_0.onGroud = false
			end
		end
	else
		arg_12_0.onGroud = false
	end

	arg_12_0.animator:SetBool(IslandConst.GROUD_FLAG, arg_12_0.onGroud)

	local var_12_5 = Vector3(0, IslandConst.GRAVITYDIR.y * var_12_0, 0)

	if arg_12_0.ignoreStepdown then
		var_12_5 = var_0_1
	end

	arg_12_0.characterController:Move((arg_12_0.velocity + Vector3(0, IslandConst.GRAVITYDIR.y * arg_12_0.gravitySpeed, 0)) * Time.deltaTime + (arg_12_0.jumpVector + var_12_5) + arg_12_0.extraVelocity * Time.deltaTime)

	return
end

function var_0_2.PositionTween(arg_13_0, arg_13_1)
	if arg_13_0._positionTweenCom ~= nil then
		arg_13_0._positionTweenCom.elapse = arg_13_0._positionTweenCom.elapse + arg_13_1

		local var_13_0 = arg_13_0.jumpCurve:Evaluate(arg_13_0._positionTweenCom.elapse)

		arg_13_0._positionTweenCom.oldPosition = var_13_0

		local var_13_1 = UnityEngine.Matrix4x4.TRS(arg_13_0._tf.position, arg_13_0._tf.rotation, Vector3.one):MultiplyVector(var_0.New(0, var_13_0 - arg_13_0._positionTweenCom.oldPosition, 0))

		arg_13_0.gravityAcc = 0
		arg_13_0.ignoreStepdown = true

		if arg_13_0._positionTweenCom.elapse >= arg_13_0._positionTweenCom.duration - 0.001 then
			arg_13_0._positionTweenCom = nil
			arg_13_0.gravitySpeed = Vector3.Dot(Vector3(0, -1, 0), var_13_1) / arg_13_1
			arg_13_0.jumpVector = var_0_1
		else
			arg_13_0.jumpVector = var_13_1
			arg_13_0.gravitySpeed = 0
		end
	end

	return
end

function var_0_2.CalcGrounded(arg_14_0)
	local var_14_0, var_14_1 = Physics.SphereCast(arg_14_0._tf.position + arg_14_0.characterController.center, arg_14_0.characterController.radius, Vector3.down, nil, 2 * arg_14_0.characterController.skinWidth + (0.5 * arg_14_0.characterController.height - arg_14_0.characterController.radius), var_0_7)

	if var_14_0 then
		if var_14_1.collider.isTrigger then
			return true, 0
		end

		return true, arg_14_0._tf.position.y + arg_14_0.characterController.skinWidth - var_14_1.point.y
	end

	return false
end

function var_0_2.CalcNotFalling(arg_15_0)
	local var_15_0, var_15_1 = Physics.SphereCast(arg_15_0._tf.position + arg_15_0.characterController.center, arg_15_0.characterController.radius, Vector3.down, nil, 0.3 + 2 * arg_15_0.characterController.skinWidth + (0.5 * arg_15_0.characterController.height - arg_15_0.characterController.radius), var_0_7)

	if var_15_0 then
		if var_15_1.collider.isTrigger then
			return false
		end

		return true, arg_15_0._tf.position.y + arg_15_0.characterController.skinWidth - var_15_1.point.y
	end

	return false
end

function var_0_2.StandOnWorldObject(arg_16_0)
	local var_16_0, var_16_1 = Physics.SphereCast(arg_16_0._tf.position + arg_16_0.characterController.center, arg_16_0.characterController.radius * 1.2, Vector3.down, nil, 0.3 + 2 * arg_16_0.characterController.skinWidth + (0.5 * arg_16_0.characterController.height - arg_16_0.characterController.radius), var_0_7)

	if var_16_0 then
		if var_16_1.collider.isTrigger then
			return false
		end

		if var_16_1.collider.gameObject:GetComponent(typeof(WorldObjectItem)) then
			return true
		end
	end

	return false
end

function var_0_2.Sit(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.characterController.enabled = false
	arg_17_0.prevStandPosition = arg_17_0._tf.position
	arg_17_0._tf.position = arg_17_1

	local var_17_0 = arg_17_0._tf:Find("all/foot_l_d_mount")

	arg_17_0._tf.rotation = Quaternion.LookRotation(arg_17_2, Vector3.New(0, 1, 0))

	arg_17_0.animator:SetBool(IslandConst.SIT_HASH, true)

	arg_17_0.isSitting = true

	return
end

function var_0_2.MoveHandle(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.cantMove then
		return
	end

	if arg_18_0.isSitting and arg_18_0.prevStandPosition then
		arg_18_0.characterController.enabled = true
		arg_18_0._tf.position = arg_18_0.prevStandPosition

		arg_18_0.animator:SetBool(IslandConst.SIT_HASH, false)

		arg_18_0.isSitting = false

		return
	end

	if arg_18_0.animator then
		arg_18_0.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, arg_18_2)
	end

	arg_18_0.orginTargetDir = arg_18_1
	arg_18_0.lastTargetSpeed = arg_18_2 * arg_18_0.maxSpeed

	if arg_18_0.isSprint then
		arg_18_0.targetSpeed = arg_18_0.sprintSpeed or arg_18_0.lastTargetSpeed

		return
	end
end

function var_0_2.StopMoveHandle(arg_19_0)
	arg_19_0.targetSpeed = 0
	arg_19_0.speed = 0

	arg_19_0.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	arg_19_0.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, 0)

	arg_19_0.orginTargetDir = var_0_1
	arg_19_0.isSprint = false

	return
end

function var_0_2.StopMoveHandleByInput(arg_20_0)
	arg_20_0.targetSpeed = 0

	arg_20_0.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	arg_20_0.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, 0)

	arg_20_0.orginTargetDir = var_0_1
	arg_20_0.isSprint = false

	return
end

function var_0_2.JumpHandle(arg_21_0)
	if arg_21_0.cantMove then
		return
	end

	if arg_21_0:CheckCanJump() then
		arg_21_0.animator:SetTrigger(IslandConst.JUMP_FLAG)
	end

	return
end

function var_0_2.WorkHandle(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_0.cantMove then
		return
	end

	if arg_22_2 then
		arg_22_0.unitData = arg_22_2

		local var_22_0 = arg_22_2.position - arg_22_0:GetCurrentPosition()

		arg_22_0.targetRotation = Quaternion.LookRotation(var_0(var_22_0.x, 0, var_22_0.z).normalized)
	end

	arg_22_0.animator:SetTrigger(arg_22_1)

	return
end

function var_0_2.DeviceStateHandle(arg_23_0, arg_23_1)
	if not arg_23_0.animator then
		return
	end

	local var_23_0 = arg_23_0.view:GetController()

	if var_23_0:IsPlayerInTimeline() then
		return
	end

	if arg_23_1 then
		arg_23_0.animator:SetTrigger(IslandConst.DEVICE_SHOW_FLAG)
		arg_23_0.animator:ResetTrigger(IslandConst.UN_DEVICE_SHOW_FLAG)
	else
		arg_23_0.animator:SetTrigger(IslandConst.UN_DEVICE_SHOW_FLAG)
	end

	return
end

function var_0_2.OnPlayerPlayerSprint(arg_24_0)
	if arg_24_0.targetSpeed ~= 0 then
		arg_24_0.isSprint = true
		arg_24_0.lastTargetSpeed = arg_24_0.targetSpeed
		arg_24_0.targetSpeed = arg_24_0.sprintSpeed
		arg_24_0.speed = arg_24_0.targetSpeed
	end

	return
end

function var_0_2.OnStopPlayerSprint(arg_25_0)
	if arg_25_0.isSprint and arg_25_0.targetSpeed ~= 0 then
		arg_25_0.targetSpeed = arg_25_0.lastTargetSpeed
		arg_25_0.speed = arg_25_0.lastTargetSpeed
		arg_25_0.isSprint = false
	end

	return
end

function var_0_2.LoadInteractiveTool(arg_26_0, arg_26_1)
	arg_26_0.toolId = arg_26_1 == 0 and arg_26_0.unitData:GetToolId() or arg_26_1
	arg_26_0.currentToolId = IslandAnimationAttachmentHelper.ResolveId(arg_26_0.animator, arg_26_0.toolId)
	arg_26_0.toolIdMap[arg_26_1] = arg_26_0.currentToolId
	arg_26_0.toolIdMap[arg_26_0.toolId] = arg_26_0.currentToolId

	if arg_26_0.objTfList[arg_26_0.currentToolId] then
		setActive(arg_26_0.objTfList[arg_26_0.currentToolId], true)
		setParent(arg_26_0.objTfList[arg_26_0.currentToolId], arg_26_0._tf)
		pg.ViewUtils.SetLayer(arg_26_0.objTfList[arg_26_0.currentToolId], Layer.UIHidden)

		return
	end

	local var_26_0 = pg.island_animation_attachments[arg_26_0.currentToolId]

	arg_26_0.objTfList[arg_26_0.currentToolId] = Object.Instantiate((LoadAny(pg.island_animation_attachments[arg_26_0.currentToolId].model, nil))).transform
	GetOrAddComponent(arg_26_0.objTfList[arg_26_0.currentToolId], typeof(Animator)).runtimeAnimatorController = LoadAny(var_26_0.animator, nil, typeof(RuntimeAnimatorController))

	setParent(arg_26_0.objTfList[arg_26_0.currentToolId], arg_26_0._tf)
	pg.ViewUtils.SetLayer(arg_26_0.objTfList[arg_26_0.currentToolId], Layer.UIHidden)

	return
end

function var_0_2.UnLoadInteractiveTool(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.toolIdMap[arg_27_1] or arg_27_0.currentToolId or IslandAnimationAttachmentHelper.ResolveId(arg_27_0.animator, arg_27_1)

	if arg_27_0.objTfList[var_27_0] then
		setActive(arg_27_0.objTfList[var_27_0], false)
	end

	return
end

function var_0_2.NoMoveHandle(arg_28_0, arg_28_1)
	arg_28_0.cantMove = true

	if arg_28_0.delayMoveTimer then
		arg_28_0.delayMoveTimer:Stop()

		arg_28_0.delayMoveTimer = nil
	end

	arg_28_0.delayMoveTimer = Timer.New(function()
		arg_28_0.cantMove = false

		return
	end, arg_28_1, 1)

	arg_28_0.delayMoveTimer:Start()

	return
end

function var_0_2.AttackHandle(arg_30_0, arg_30_1)
	if arg_30_0.delayAttackTimer then
		arg_30_0.delayAttackTimer:Stop()

		arg_30_0.delayAttackTimer = nil
	end

	arg_30_0.delayAttackTimer = Timer.New(function()
		if arg_30_0.unitData then
			arg_30_0:NotifiyCore(ISLAND_EVT.Take_Plant_Attact, {
				type = arg_30_0.unitData.unitType,
				id = arg_30_0.unitData.id
			})
		end

		return
	end, arg_30_1, 1)

	arg_30_0.delayAttackTimer:Start()

	return
end

function var_0_2.StateEnterHandle(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == var_0_8.JumpHandle then
		arg_32_0:OnEnterJumpState()
	elseif arg_32_1 == var_0_8.LoadToolHandle then
		arg_32_0:LoadInteractiveTool(arg_32_2)
	elseif arg_32_1 == var_0_8.NoMoveAndWork then
		arg_32_0:NoMoveHandle(arg_32_2)
	elseif arg_32_1 == var_0_8.AttackHandle then
		arg_32_0:AttackHandle(arg_32_2)
	end

	return
end

function var_0_2.StateEnterFixHandle(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.toolIdMap[arg_33_2] or arg_33_0.currentToolId

	if arg_33_1 == var_0_8.LoadToolHandle and var_33_0 and arg_33_0.objTfList[var_33_0] then
		pg.ViewUtils.SetLayer(arg_33_0.objTfList[var_33_0], Layer.Default)
	end

	return
end

function var_0_2.StateExitFixHandle(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0.toolIdMap[arg_34_2] or arg_34_0.currentToolId

	if arg_34_1 == var_0_8.LoadToolHandle and var_34_0 and arg_34_0.objTfList[var_34_0] then
		pg.ViewUtils.SetLayer(arg_34_0.objTfList[var_34_0], Layer.UIHidden)
	end

	return
end

function var_0_2.StateExitHandle(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == var_0_8.LoadToolHandle then
		arg_35_0:UnLoadInteractiveTool(arg_35_2)
	end

	return
end

function var_0_2.OnEnterJumpState(arg_36_0)
	arg_36_0._positionTweenCom = {
		elapse = 0,
		oldPosition = 0,
		duration = arg_36_0.jumpCruveAllTime
	}

	return
end

local var_0_9 = var_0_0(0, 0)

function var_0_2.InitFarmCheckWorldObject(arg_37_0)
	if not arg_37_0:IsSpecialMap() then
		return
	end

	arg_37_0.detectionList = {}

	local var_37_0 = pg.island_production_place.get_id_list_by_map_id[arg_37_0.mapId] or {}

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_1 = pg.island_production_farm.get_id_list_by_place_id[iter_37_1] or {}

		for iter_37_2, iter_37_3 in ipairs(var_37_1) do
			table.insert(arg_37_0.detectionList, {
				id = pg.island_world_objects[pg.island_production_farm[iter_37_3].objId].id,
				position = pg.island_world_objects[pg.island_production_farm[iter_37_3].objId].param.position
			})
		end
	end

	return
end

function var_0_2.IsSpecialMap(arg_38_0)
	return arg_38_0.mapId == 1001 or arg_38_0.mapId == 1005
end

function var_0_2.IsSelf(arg_39_0)
	return
end

function var_0_2.Detectionobject(arg_40_0)
	if not arg_40_0:IsSpecialMap() or not arg_40_0.isSelfIsland then
		return
	end

	local var_40_0 = {}

	for iter_40_0, iter_40_1 in ipairs(arg_40_0.detectionList) do
		local var_40_1 = arg_40_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_40_1.id)

		if var_40_1:CanCheckByPlayer() and (function(arg_41_0)
			local var_41_0 = var_0_3
			local var_41_1 = math.max(arg_41_0.position[1] - var_0_5.x / 2, math.min(arg_40_0._tf.position.x, arg_41_0.position[1] + var_0_5.x / 2)) - arg_40_0._tf.position.x
			local var_41_2 = math.max(arg_41_0.position[3] - var_0_5.x / 2, math.min(arg_40_0._tf.position.z, arg_41_0.position[3] + var_0_5.x / 2)) - arg_40_0._tf.position.z

			return var_41_1 * var_41_1 + var_41_2 * var_41_2 <= var_41_0 * var_41_0
		end)(iter_40_1) then
			table.insert(var_40_0, iter_40_1)
		end
	end

	local function var_40_2(arg_42_0, arg_42_1, arg_42_2)
		return (arg_42_2.x - arg_42_0.x) * (arg_42_1.y - arg_42_0.y) - (arg_42_2.y - arg_42_0.y) * (arg_42_1.x - arg_42_0.x)
	end

	local function var_40_3(arg_43_0, arg_43_1, arg_43_2)
		return Mathf.Min(arg_43_0.x, arg_43_1.x) <= arg_43_2.x and arg_43_2.x <= Mathf.Max(arg_43_0.x, arg_43_1.x) and Mathf.Min(arg_43_0.y, arg_43_1.y) <= arg_43_2.y and arg_43_2.y <= Mathf.Max(arg_43_0.y, arg_43_1.y)
	end

	local function var_40_4(arg_44_0, arg_44_1)
		for iter_44_0 = 0, #arg_44_1 do
			if var_0_0.Dot((arg_44_1[(iter_44_0 + 1) % #arg_44_1] - arg_44_1[iter_44_0]).normalized, arg_44_0 - arg_44_1[iter_44_0]) > 0 then
				return false
			end
		end

		return true
	end

	local function var_40_5(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
		local var_45_0 = var_40_2(arg_45_2, arg_45_3, arg_45_0)
		local var_45_1 = var_40_2(arg_45_2, arg_45_3, arg_45_1)
		local var_45_2 = var_40_2(arg_45_0, arg_45_1, arg_45_2)
		local var_45_3 = var_40_2(arg_45_0, arg_45_1, arg_45_3)

		if (var_45_0 > 0 and var_45_1 < 0 or var_45_0 < 0 and var_45_1 > 0) and (var_45_2 > 0 and var_45_3 < 0 or var_45_2 < 0 and var_45_3 > 0) then
			return true
		end

		if var_45_0 == 0 and var_40_3(arg_45_2, arg_45_3, arg_45_0) then
			return true
		end

		if var_45_1 == 0 and var_40_3(arg_45_2, arg_45_3, arg_45_1) then
			return true
		end

		if var_45_2 == 0 and var_40_3(arg_45_0, arg_45_1, arg_45_2) then
			return true
		end

		if var_45_3 == 0 and var_40_3(arg_45_0, arg_45_1, arg_45_3) then
			return true
		end

		return false
	end

	local function var_40_6(arg_46_0, arg_46_1)
		local var_46_0 = Mathf.Cos(arg_46_1 * Mathf.Deg2Rad)
		local var_46_1 = Mathf.Sin(arg_46_1 * Mathf.Deg2Rad)

		;({})[0] = arg_46_0 + var_0_0(-(var_0_5 * 0.5).x * var_46_0 - (var_0_5 * 0.5).y * var_46_1, -(var_0_5 * 0.5).x * var_46_1 + (var_0_5 * 0.5).y * var_46_0)
		;({})[1] = arg_46_0 + var_0_0((var_0_5 * 0.5).x * var_46_0 - (var_0_5 * 0.5).y * var_46_1, (var_0_5 * 0.5).x * var_46_1 + (var_0_5 * 0.5).y * var_46_0)
		;({})[2] = arg_46_0 + var_0_0((var_0_5 * 0.5).x * var_46_0 + (var_0_5 * 0.5).y * var_46_1, (var_0_5 * 0.5).x * var_46_1 - (var_0_5 * 0.5).y * var_46_0)
		;({})[3] = arg_46_0 + var_0_0(-(var_0_5 * 0.5).x * var_46_0 + (var_0_5 * 0.5).y * var_46_1, -(var_0_5 * 0.5).x * var_46_1 - (var_0_5 * 0.5).y * var_46_0)

		return {}
	end

	local function var_40_7(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
		local var_47_0 = var_40_6(arg_47_0, arg_47_1)

		for iter_47_0 = 0, 3 do
			if var_40_5(arg_47_2, arg_47_3, var_47_0[iter_47_0], var_47_0[(iter_47_0 + 1) % 4]) then
				return true
			end
		end

		if var_40_4(arg_47_2, var_47_0) or var_40_4(arg_47_3, var_47_0) then
			return true
		end

		return false
	end

	local function var_40_8(arg_48_0, arg_48_1, arg_48_2)
		local var_48_0 = var_0_0(var_0_0.Dot(arg_48_0 - arg_48_2, arg_48_1), (var_0_0.Dot(arg_48_0 - arg_48_2, var_0_0(-arg_48_1.y, arg_48_1.x))))
		local var_48_1 = var_0_0.Max(var_48_0 - var_0_0.zero, var_0_0.zero - var_48_0)
		local var_48_2 = var_40_7(var_48_1, 0, var_0_0.zero, var_0_0(var_0_3 * Mathf.Cos(15 * Mathf.Deg2Rad), var_0_3 * Mathf.Sin(15 * Mathf.Deg2Rad)))

		return (180 - var_0_4) / 2 <= var_0_0.Angle(var_0_0.Max(var_48_1 - var_0_5 * 0.5, var_0_0.zero), var_0_0.right) or var_48_2
	end

	for iter_40_2, iter_40_3 in ipairs(var_40_0) do
		if (function(arg_49_0)
			if var_0.Dot(var_0(arg_49_0.position[1], arg_49_0.position[2], arg_49_0.position[3]) - arg_40_0._tf.position, arg_40_0._tf.forward) < 0 then
				return
			end

			return var_40_8(var_0_0(arg_49_0.position[1], arg_49_0.position[3]), arg_40_0:Vector3ToVector2(arg_40_0._tf.right), arg_40_0:Vector3ToVector2(arg_40_0._tf.position) + var_0_9)
		end)(iter_40_3) then
			table.insert({}, iter_40_3)
		end
	end

	local var_40_9 = false

	if #{} ~= 0 then
		local var_40_10
		local var_40_11 = arg_40_0:Vector3ToVector2(arg_40_0._tf.position) + var_0_9 + arg_40_0:Vector3ToVector2(arg_40_0._tf.forward) * 2

		for iter_40_4, iter_40_5 in ipairs({}) do
			local var_40_13 = (var_0_0(iter_40_5.position[1], iter_40_5.position[3]) - var_40_11):Magnitude()
			local var_40_14

			if var_40_13 < 10 then
				var_40_14 = var_40_13
				var_40_10 = iter_40_5
			end
		end

		if var_40_10 then
			itemId = var_40_10.id

			if itemId ~= arg_40_0.nearId then
				arg_40_0.nearId = itemId
				arg_40_0.nearItem = var_40_10
				var_40_9 = true
			end
		end
	end

	if #{} ~= arg_40_0.lastCrossCount or var_40_9 then
		arg_40_0.lastCrossCount = #{}

		if #{} == 0 then
			arg_40_0:NotifiyCore(ISLAND_EVT.HIDE_UNIT_HUD_OP, {
				isHighLightControl = true,
				id = tonumber(arg_40_0.nearId),
				type = IslandConst.UNIT_LIST_OBJ
			})

			arg_40_0.nearId = 0
		else
			arg_40_0:NotifiyCore(ISLAND_EVT.SHOW_UNIT_HUD_OP, {
				isHighLightControl = true,
				id = tonumber(arg_40_0.nearId),
				operationType = IslandOpView.OperationType.Plant,
				type = IslandConst.UNIT_LIST_OBJ
			})
		end
	end

	return
end

function var_0_2.Vector3ToVector2(arg_50_0, arg_50_1)
	return var_0_0(arg_50_1.x, arg_50_1.z)
end

function var_0_2.GetNearItemId(arg_51_0)
	return arg_51_0.nearId
end

function var_0_2.OnGrouded(arg_52_0)
	return arg_52_0.onGroud
end

function var_0_2.GetCurrentPosition(arg_53_0)
	return arg_53_0._tf.position
end

function var_0_2.LastGroundedPosition(arg_54_0)
	if not arg_54_0.onGroud then
		local var_54_0, var_54_1 = Physics.Raycast(arg_54_0._tf.position, Vector3.down, nil, math.huge, var_0_7)

		if var_54_0 then
			return var_54_1.point, arg_54_0._tf.eulerAngles
		end
	end

	return arg_54_0._tf.position, arg_54_0._tf.eulerAngles
end

function var_0_2.CheckCanJump(arg_55_0)
	if arg_55_0.onGroud then
		return true
	end

	if arg_55_0.jumpVector.y > 0 then
		return false
	end

	local var_55_0, var_55_1 = Physics.Raycast(arg_55_0._tf.position + arg_55_0.characterController.center, Vector3.down, nil, 2, var_0_7)

	if var_55_0 then
		return true
	end

	return false
end

function var_0_2.OnDetach(arg_56_0)
	if arg_56_0.delayMoveTimer then
		arg_56_0.delayMoveTimer:Stop()

		arg_56_0.delayMoveTimer = nil
	end

	if arg_56_0.delayAttackTimer then
		arg_56_0.delayAttackTimer:Stop()

		arg_56_0.delayAttackTimer = nil
	end

	arg_56_0:ClearAnimationTools()
	arg_56_0.shipDressHelper:Destroy()
	arg_56_0.characterHandleController:AddStateEnterFunc(nil)
	arg_56_0.characterHandleController:AddStateExitFunc(nil)

	return
end

function var_0_2.ClearAnimationTools(arg_57_0)
	for iter_57_0, iter_57_1 in pairs(arg_57_0.objTfList) do
		Object.Destroy(iter_57_1.gameObject)
	end

	arg_57_0.objTfList = {}

	return
end

function var_0_2.SetActiveByLayer(arg_58_0, arg_58_1)
	if arg_58_1 then
		pg.ViewUtils.SetLayer(arg_58_0._tf, Layer.Default)
	else
		pg.ViewUtils.SetLayer(arg_58_0._tf, Layer.UIHidden)
	end

	return
end

function var_0_2.SetShipDressHelper(arg_59_0, arg_59_1)
	arg_59_0.shipDressHelper = arg_59_1

	return
end

function var_0_2.OnChangeDress(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		local var_60_1, var_60_2 = (function(arg_61_0)
			for iter_61_0, iter_61_1 in ipairs(arg_60_2) do
				if arg_61_0 == iter_61_1.id then
					return iter_61_1.color, true
				end
			end

			return var_60_0:GetCurrentColorByDressId(arg_61_0), false
		end)(iter_60_1.id)

		if var_60_2 then
			({})[iter_60_1.id] = true
		end

		arg_60_0.shipDressHelper:ChangeDressByType(iter_60_1.type, {
			id = iter_60_1.id,
			colorId = var_60_1
		})
	end

	for iter_60_2, iter_60_3 in ipairs(arg_60_2) do
		if not ({})[iter_60_3.id] then
			arg_60_0.shipDressHelper:ChangeCommanderPartColor(pg.island_dress_template[iter_60_3.id].type, iter_60_3.color)
		end
	end

	return
end

function var_0_2.InitDress(arg_62_0)
	return
end

return var_0_2
