local Vector3 = require("Framework.toLua.UnityEngine.Vector3")
local Vector2 = require("Framework.toLua.UnityEngine.Vector2")
local var_0_2 = Vector3.zero
local IslandPlayerUnit = class("IslandPlayerUnit", import(".IslandNavigableUnit"))
local var_0_4 = 5
local var_0_5 = 150
local var_0_6 = Vector2(1.8, 1.8)
local var_0_7 = Vector2(0, 2)
local var_0_8 = bit.bnot(bit.lshift(1, (LayerMask.NameToLayer("IgnoreIslandCharacter"))))
local var_0_9 = {
	LoadToolHandle = 2,
	JumpHandle = 1,
	NoMoveAndWork = 3,
	AttackHandle = 4
}

function IslandPlayerUnit:OnAttach(arg_1_1)
	IslandPlayerUnit.super.OnAttach(self, arg_1_1)

	self.mapId = getProxy(IslandProxy):GetIsland():GetMapId()
	self._tf = self._go.transform
	self.animator = self._tf:GetChild(0):GetComponent(typeof(Animator))
	self.characterController = self._go:GetComponent(typeof(CharacterController))
	self.characterHandleController = self._go:GetComponent(typeof(CharacterHandleController))
	var_0_4 = pg.island_set.detection_parameters.key_value_varchar[2]
	var_0_5 = pg.island_set.detection_parameters.key_value_varchar[1]
	var_0_7 = Vector2(0, pg.island_set.detection_parameters.key_value_varchar[3])

	self.characterHandleController:SetDrawParameter(var_0_4, var_0_5, pg.island_set.detection_parameters.key_value_varchar[3])
	self.characterHandleController:AddStateEnterFunc(function(arg_2_0, arg_2_1)
		self:StateEnterHandle(arg_2_0, arg_2_1)

		return
	end)
	self.characterHandleController:AddStateExitFunc(function(arg_3_0, arg_3_1)
		self:StateExitHandle(arg_3_0, arg_3_1)

		return
	end)
	self.characterHandleController:AddStateEnterFixCompleteFunc(function(arg_4_0, arg_4_1)
		self:StateEnterFixHandle(arg_4_0, arg_4_1)

		return
	end)
	self.characterHandleController:AddStateExitFixCompleteFunc(function(arg_5_0, arg_5_1)
		self:StateExitFixHandle(arg_5_0, arg_5_1)

		return
	end)

	self.targetSpeed = 0
	self.speed = 0
	self.gravitySpeed = 0
	self.jumpVector = Vector3.zero
	self.degreeSpeed = 720
	self.maxSpeed = pg.island_set.player_movement_parameters.key_value_varchar[1]
	self.sprintSpeed = pg.island_set.player_movement_parameters.key_value_varchar[2]
	self.upSpeedDamping = 3
	self.downSpeedDamping = 6
	self.jumpHeight = pg.island_set.player_movement_parameters.key_value_varchar[3]
	self.targetDir = Vector3.zero
	self.velocity = Vector3.zero
	self.extraVelocity = Vector3.zero
	self.isSitting = false
	self.prevStandPosition = nil
	self.checkInSet = {}
	self.lastCrossCount = 0
	self.orginTargetDir = var_0_2

	self:InitDress()
	self:InitFarmCheckWorldObject()

	self.objTfList = {}
	self.toolIdMap = {}
	self.islandid = self:GetView():GetIsland().id
	self.isSelfIsland = getProxy(PlayerProxy):getRawData().id == self.islandid

	return
end

function IslandPlayerUnit:InitJump(arg_6_1)
	self.jumpCurve = arg_6_1
	self.jumpCruveAllTime = self.jumpCurve.keys[self.jumpCurve.length - 1].time

	return
end

function IslandPlayerUnit:OnLateUpdate()
	return
end

function IslandPlayerUnit:OnUpdate()
	self:RefreshTemp()
	self:PositionTween(Time.deltaTime)
	self:Rotation(Time.deltaTime)
	self:Move(Time.deltaTime)
	self:Detectionobject()

	return
end

function IslandPlayerUnit:RefreshTemp()
	self.ignoreStepdown = false
	self.gravityAcc = IslandConst.GRAVITYACC

	if self.orginTargetDir.x ~= 0 or self.orginTargetDir.z ~= 0 then
		local var_9_0 = IslandCameraMgr.instance._mainCamera.transform:TransformVector(self.orginTargetDir)

		self.targetDir = Vector3(var_9_0.x, 0, var_9_0.z).normalized

		if self.targetDir ~= Vector3.zero then
			self.targetRotation = Quaternion.LookRotation(self.targetDir)
		end
	end

	return
end

function IslandPlayerUnit:Rotation(arg_10_1)
	if self.targetRotation then
		self._tf.rotation = Quaternion.RotateTowards(self._tf.rotation, self.targetRotation, self.degreeSpeed * arg_10_1)
	end

	return
end

function IslandPlayerUnit:SetTargetRotation(arg_11_1)
	self.targetRotation = arg_11_1

	return
end

function IslandPlayerUnit:Move(arg_12_1)
	self.speed = Mathf.Approximately(self.speed, self.targetSpeed) and self.targetSpeed or self.targetSpeed > self.speed and Mathf.Lerp(self.speed, self.targetSpeed, self.upSpeedDamping * arg_12_1) or Mathf.Lerp(self.speed, self.targetSpeed, self.downSpeedDamping * arg_12_1)

	self.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, self.speed)

	self.velocity = self.targetDir * self.speed
	self.gravitySpeed = self.gravitySpeed + self.gravityAcc * arg_12_1
	self.onGroud = true

	local var_12_0 = 0

	if self.gravitySpeed >= 0 then
		local var_12_1, var_12_2 = self:CalcGrounded()

		if var_12_1 then
			self.gravitySpeed = 0
			var_12_0 = var_12_2
		else
			local var_12_3, var_12_4 = self:CalcNotFalling()

			if var_12_3 then
				self.gravitySpeed = 0
				var_12_0 = var_12_4
			else
				self.onGroud = false
			end
		end
	else
		self.onGroud = false
	end

	self.animator:SetBool(IslandConst.GROUD_FLAG, self.onGroud)

	local var_12_5 = Vector3(0, IslandConst.GRAVITYDIR.y * var_12_0, 0)

	self.characterController:Move((self.velocity + Vector3(0, IslandConst.GRAVITYDIR.y * self.gravitySpeed, 0)) * Time.deltaTime + (self.jumpVector + ((self.ignoreStepdown or nil) and var_0_2)) + self.extraVelocity * Time.deltaTime)

	return
end

function IslandPlayerUnit:PositionTween(arg_13_1)
	if self._positionTweenCom ~= nil then
		self._positionTweenCom.elapse = self._positionTweenCom.elapse + arg_13_1

		local var_13_0 = self.jumpCurve:Evaluate(self._positionTweenCom.elapse)

		self._positionTweenCom.oldPosition = var_13_0

		local var_13_1 = UnityEngine.Matrix4x4.TRS(self._tf.position, self._tf.rotation, Vector3.one):MultiplyVector(Vector3.New(0, var_13_0 - self._positionTweenCom.oldPosition, 0))

		self.gravityAcc = 0
		self.ignoreStepdown = true

		if self._positionTweenCom.elapse >= self._positionTweenCom.duration - 0.001 then
			self._positionTweenCom = nil
			self.gravitySpeed = Vector3.Dot(Vector3(0, -1, 0), var_13_1) / arg_13_1
			self.jumpVector = var_0_2
		else
			self.jumpVector = var_13_1
			self.gravitySpeed = 0
		end
	end

	return
end

function IslandPlayerUnit:CalcGrounded()
	local var_14_0, var_14_1 = Physics.SphereCast(self._tf.position + self.characterController.center, self.characterController.radius, Vector3.down, nil, 2 * self.characterController.skinWidth + (0.5 * self.characterController.height - self.characterController.radius), var_0_8)

	if var_14_0 then
		if var_14_1.collider.isTrigger then
			return true, 0
		end

		return true, self._tf.position.y + self.characterController.skinWidth - var_14_1.point.y
	end

	return false
end

function IslandPlayerUnit:CalcNotFalling()
	local var_15_0, var_15_1 = Physics.SphereCast(self._tf.position + self.characterController.center, self.characterController.radius, Vector3.down, nil, 0.3 + 2 * self.characterController.skinWidth + (0.5 * self.characterController.height - self.characterController.radius), var_0_8)

	if var_15_0 then
		if var_15_1.collider.isTrigger then
			return false
		end

		return true, self._tf.position.y + self.characterController.skinWidth - var_15_1.point.y
	end

	return false
end

function IslandPlayerUnit:StandOnWorldObject()
	local var_16_0, var_16_1 = Physics.SphereCast(self._tf.position + self.characterController.center, self.characterController.radius * 1.2, Vector3.down, nil, 0.3 + 2 * self.characterController.skinWidth + (0.5 * self.characterController.height - self.characterController.radius), var_0_8)

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

function IslandPlayerUnit:Sit(arg_17_1, arg_17_2)
	self.characterController.enabled = false
	self.prevStandPosition = self._tf.position
	self._tf.position = arg_17_1

	local var_17_0 = self._tf:Find("all/foot_l_d_mount")

	self._tf.rotation = Quaternion.LookRotation(arg_17_2, Vector3.New(0, 1, 0))

	self.animator:SetBool(IslandConst.SIT_HASH, true)

	self.isSitting = true

	return
end

function IslandPlayerUnit:MoveHandle(arg_18_1, arg_18_2)
	if self.cantMove then
		return
	end

	if self.isSitting and self.prevStandPosition then
		self.characterController.enabled = true
		self._tf.position = self.prevStandPosition

		self.animator:SetBool(IslandConst.SIT_HASH, false)

		self.isSitting = false

		return
	end

	if self.animator then
		self.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, arg_18_2)
	end

	self.orginTargetDir = arg_18_1
	self.lastTargetSpeed = arg_18_2 * self.maxSpeed

	if self.isSprint then
		self.targetSpeed = self.sprintSpeed or self.lastTargetSpeed
	end

	return
end

function IslandPlayerUnit:StopMoveHandle()
	self.targetSpeed = 0
	self.speed = 0

	self.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	self.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, 0)

	self.orginTargetDir = var_0_2
	self.isSprint = false

	return
end

function IslandPlayerUnit:StopMoveHandleByInput()
	self.targetSpeed = 0

	self.animator:SetFloat(IslandConst.SPEED_FLAG_HASH, 0)
	self.animator:SetFloat(IslandConst.INPUT_MAGNITUDE, 0)

	self.orginTargetDir = var_0_2
	self.isSprint = false

	return
end

function IslandPlayerUnit:JumpHandle()
	if self.cantMove then
		return
	end

	if self:CheckCanJump() then
		self.animator:SetTrigger(IslandConst.JUMP_FLAG)
	end

	return
end

function IslandPlayerUnit:WorkHandle(arg_22_1, arg_22_2)
	if self.cantMove then
		return
	end

	if arg_22_2 then
		self.unitData = arg_22_2

		local var_22_0 = arg_22_2.position - self:GetCurrentPosition()

		self.targetRotation = Quaternion.LookRotation(Vector3(var_22_0.x, 0, var_22_0.z).normalized)
	end

	self.animator:SetTrigger(arg_22_1)

	return
end

function IslandPlayerUnit:DeviceStateHandle(arg_23_1)
	if not self.animator then
		return
	end

	if self.view:GetController():IsPlayerInTimeline() then
		return
	end

	if arg_23_1 then
		self.animator:SetTrigger(IslandConst.DEVICE_SHOW_FLAG)
		self.animator:ResetTrigger(IslandConst.UN_DEVICE_SHOW_FLAG)
	else
		self.animator:SetTrigger(IslandConst.UN_DEVICE_SHOW_FLAG)
	end

	return
end

function IslandPlayerUnit:OnPlayerPlayerSprint()
	if self.targetSpeed ~= 0 then
		self.isSprint = true
		self.lastTargetSpeed = self.targetSpeed
		self.targetSpeed = self.sprintSpeed
		self.speed = self.targetSpeed
	end

	return
end

function IslandPlayerUnit:OnStopPlayerSprint()
	if self.isSprint and self.targetSpeed ~= 0 then
		self.targetSpeed = self.lastTargetSpeed
		self.speed = self.lastTargetSpeed
		self.isSprint = false
	end

	return
end

function IslandPlayerUnit:LoadInteractiveTool(arg_26_1)
	self.toolId = arg_26_1 == 0 and self.unitData:GetToolId() or arg_26_1
	self.currentToolId = IslandAnimationAttachmentHelper.ResolveId(self.animator, self.toolId)
	self.toolIdMap[arg_26_1] = self.currentToolId
	self.toolIdMap[self.toolId] = self.currentToolId

	if self.objTfList[self.currentToolId] then
		setActive(self.objTfList[self.currentToolId], true)
		setParent(self.objTfList[self.currentToolId], self._tf)
		pg.ViewUtils.SetLayer(self.objTfList[self.currentToolId], Layer.UIHidden)

		return
	end

	local var_26_0 = pg.island_animation_attachments[self.currentToolId]

	self.objTfList[self.currentToolId] = Object.Instantiate((LoadAny(pg.island_animation_attachments[self.currentToolId].model, nil))).transform
	GetOrAddComponent(self.objTfList[self.currentToolId], typeof(Animator)).runtimeAnimatorController = LoadAny(var_26_0.animator, nil, typeof(RuntimeAnimatorController))

	setParent(self.objTfList[self.currentToolId], self._tf)
	pg.ViewUtils.SetLayer(self.objTfList[self.currentToolId], Layer.UIHidden)

	return
end

function IslandPlayerUnit:UnLoadInteractiveTool(arg_27_1)
	local var_27_0 = self.toolIdMap[arg_27_1] or self.currentToolId or IslandAnimationAttachmentHelper.ResolveId(self.animator, arg_27_1)

	if self.objTfList[var_27_0] then
		setActive(self.objTfList[var_27_0], false)
	end

	return
end

function IslandPlayerUnit:NoMoveHandle(arg_28_1)
	self.cantMove = true

	if self.delayMoveTimer then
		self.delayMoveTimer:Stop()

		self.delayMoveTimer = nil
	end

	self.delayMoveTimer = Timer.New(function()
		self.cantMove = false

		return
	end, arg_28_1, 1)

	self.delayMoveTimer:Start()

	return
end

function IslandPlayerUnit:AttackHandle(arg_30_1)
	if self.delayAttackTimer then
		self.delayAttackTimer:Stop()

		self.delayAttackTimer = nil
	end

	self.delayAttackTimer = Timer.New(function()
		if self.unitData then
			self:NotifiyCore(ISLAND_EVT.Take_Plant_Attact, {
				type = self.unitData.unitType,
				id = self.unitData.id
			})
		end

		return
	end, arg_30_1, 1)

	self.delayAttackTimer:Start()

	return
end

function IslandPlayerUnit:StateEnterHandle(arg_32_1, arg_32_2)
	if arg_32_1 == var_0_9.JumpHandle then
		self:OnEnterJumpState()
	elseif arg_32_1 == var_0_9.LoadToolHandle then
		self:LoadInteractiveTool(arg_32_2)
	elseif arg_32_1 == var_0_9.NoMoveAndWork then
		self:NoMoveHandle(arg_32_2)
	elseif arg_32_1 == var_0_9.AttackHandle then
		self:AttackHandle(arg_32_2)
	end

	return
end

function IslandPlayerUnit:StateEnterFixHandle(arg_33_1, arg_33_2)
	local var_33_0 = self.toolIdMap[arg_33_2] or self.currentToolId

	if arg_33_1 == var_0_9.LoadToolHandle and var_33_0 and self.objTfList[var_33_0] then
		pg.ViewUtils.SetLayer(self.objTfList[var_33_0], Layer.Default)
	end

	return
end

function IslandPlayerUnit:StateExitFixHandle(arg_34_1, arg_34_2)
	local var_34_0 = self.toolIdMap[arg_34_2] or self.currentToolId

	if arg_34_1 == var_0_9.LoadToolHandle and var_34_0 and self.objTfList[var_34_0] then
		pg.ViewUtils.SetLayer(self.objTfList[var_34_0], Layer.UIHidden)
	end

	return
end

function IslandPlayerUnit:StateExitHandle(arg_35_1, arg_35_2)
	if arg_35_1 == var_0_9.LoadToolHandle then
		self:UnLoadInteractiveTool(arg_35_2)
	end

	return
end

function IslandPlayerUnit:OnEnterJumpState()
	self._positionTweenCom = {
		elapse = 0,
		oldPosition = 0,
		duration = self.jumpCruveAllTime
	}

	return
end

local var_0_10 = Vector2(0, 0)

function IslandPlayerUnit:InitFarmCheckWorldObject()
	if not self:IsSpecialMap() then
		return
	end

	self.detectionList = {}

	for iter_37_0, iter_37_1 in ipairs(pg.island_production_place.get_id_list_by_map_id[self.mapId] or {}) do
		for iter_37_2, iter_37_3 in ipairs(pg.island_production_farm.get_id_list_by_place_id[iter_37_1] or {}) do
			table.insert(self.detectionList, {
				id = pg.island_world_objects[pg.island_production_farm[iter_37_3].objId].id,
				position = pg.island_world_objects[pg.island_production_farm[iter_37_3].objId].param.position
			})
		end
	end

	return
end

function IslandPlayerUnit:IsSpecialMap()
	return self.mapId == 1001 or self.mapId == 1005
end

function IslandPlayerUnit:IsSelf()
	return
end

function IslandPlayerUnit:Detectionobject()
	if not self:IsSpecialMap() or not self.isSelfIsland then
		return
	end

	local var_40_0 = {}

	local function var_40_1(arg_41_0)
		local var_41_0 = var_0_4
		local var_41_1 = math.max(arg_41_0.position[1] - var_0_6.x / 2, math.min(self._tf.position.x, arg_41_0.position[1] + var_0_6.x / 2)) - self._tf.position.x
		local var_41_2 = math.max(arg_41_0.position[3] - var_0_6.x / 2, math.min(self._tf.position.z, arg_41_0.position[3] + var_0_6.x / 2)) - self._tf.position.z

		return var_41_1 * var_41_1 + var_41_2 * var_41_2 <= var_41_0 * var_41_0
	end

	for iter_40_0, iter_40_1 in ipairs(self.detectionList) do
		if self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, iter_40_1.id):CanCheckByPlayer() and var_40_1(iter_40_1) then
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
			if Vector2.Dot((arg_44_1[(iter_44_0 + 1) % #arg_44_1] - arg_44_1[iter_44_0]).normalized, arg_44_0 - arg_44_1[iter_44_0]) > 0 then
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
		local var_46_0 = {}
		local var_46_1 = Mathf.Cos(arg_46_1 * Mathf.Deg2Rad)
		local var_46_2 = Mathf.Sin(arg_46_1 * Mathf.Deg2Rad)

		var_46_0[0] = arg_46_0 + Vector2(-(var_0_6 * 0.5).x * var_46_1 - (var_0_6 * 0.5).y * var_46_2, -(var_0_6 * 0.5).x * var_46_2 + (var_0_6 * 0.5).y * var_46_1)
		var_46_0[1] = arg_46_0 + Vector2((var_0_6 * 0.5).x * var_46_1 - (var_0_6 * 0.5).y * var_46_2, (var_0_6 * 0.5).x * var_46_2 + (var_0_6 * 0.5).y * var_46_1)
		var_46_0[2] = arg_46_0 + Vector2((var_0_6 * 0.5).x * var_46_1 + (var_0_6 * 0.5).y * var_46_2, (var_0_6 * 0.5).x * var_46_2 - (var_0_6 * 0.5).y * var_46_1)
		var_46_0[3] = arg_46_0 + Vector2(-(var_0_6 * 0.5).x * var_46_1 + (var_0_6 * 0.5).y * var_46_2, -(var_0_6 * 0.5).x * var_46_2 - (var_0_6 * 0.5).y * var_46_1)

		return var_46_0
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
		local var_48_0 = Vector2(Vector2.Dot(arg_48_0 - arg_48_2, arg_48_1), (Vector2.Dot(arg_48_0 - arg_48_2, Vector2(-arg_48_1.y, arg_48_1.x))))
		local var_48_1 = Vector2.Max(var_48_0 - Vector2.zero, Vector2.zero - var_48_0)

		return (180 - var_0_5) / 2 <= Vector2.Angle(Vector2.Max(var_48_1 - var_0_6 * 0.5, Vector2.zero), Vector2.right) or var_40_7(var_48_1, 0, Vector2.zero, Vector2(var_0_4 * Mathf.Cos(15 * Mathf.Deg2Rad), var_0_4 * Mathf.Sin(15 * Mathf.Deg2Rad)))
	end

	local function var_40_9(arg_49_0)
		if Vector3.Dot(Vector3(arg_49_0.position[1], arg_49_0.position[2], arg_49_0.position[3]) - self._tf.position, self._tf.forward) < 0 then
			return
		end

		return var_40_8(Vector2(arg_49_0.position[1], arg_49_0.position[3]), self:Vector3ToVector2(self._tf.right), self:Vector3ToVector2(self._tf.position) + var_0_10)
	end

	local var_40_10 = {}

	for iter_40_2, iter_40_3 in ipairs(var_40_0) do
		if var_40_9(iter_40_3) then
			table.insert(var_40_10, iter_40_3)
		end
	end

	local var_40_11 = false

	if #var_40_10 ~= 0 then
		local var_40_12
		local var_40_13 = self:Vector3ToVector2(self._tf.position) + var_0_10 + self:Vector3ToVector2(self._tf.forward) * 2

		for iter_40_4, iter_40_5 in ipairs(var_40_10) do
			if (Vector2(iter_40_5.position[1], iter_40_5.position[3]) - var_40_13):Magnitude() < 10 then
				var_40_12 = iter_40_5
			end
		end

		if var_40_12 then
			itemId = var_40_12.id

			if itemId ~= self.nearId then
				self.nearId = itemId
				self.nearItem = var_40_12
				var_40_11 = true
			end
		end
	end

	if #var_40_10 ~= self.lastCrossCount or var_40_11 then
		self.lastCrossCount = #var_40_10

		if #var_40_10 == 0 then
			self:NotifiyCore(ISLAND_EVT.HIDE_UNIT_HUD_OP, {
				isHighLightControl = true,
				id = tonumber(self.nearId),
				type = IslandConst.UNIT_LIST_OBJ
			})

			self.nearId = 0
		else
			self:NotifiyCore(ISLAND_EVT.SHOW_UNIT_HUD_OP, {
				isHighLightControl = true,
				id = tonumber(self.nearId),
				operationType = IslandOpView.OperationType.Plant,
				type = IslandConst.UNIT_LIST_OBJ
			})
		end
	end

	return
end

function IslandPlayerUnit:Vector3ToVector2(arg_50_1)
	return Vector2(arg_50_1.x, arg_50_1.z)
end

function IslandPlayerUnit:GetNearItemId()
	return self.nearId
end

function IslandPlayerUnit:OnGrouded()
	return self.onGroud
end

function IslandPlayerUnit:GetCurrentPosition()
	return self._tf.position
end

function IslandPlayerUnit:LastGroundedPosition()
	if not self.onGroud then
		local var_54_0, var_54_1 = Physics.Raycast(self._tf.position, Vector3.down, nil, math.huge, var_0_8)

		if var_54_0 then
			return var_54_1.point, self._tf.eulerAngles
		end
	end

	return self._tf.position, self._tf.eulerAngles
end

function IslandPlayerUnit:CheckCanJump()
	if self.onGroud then
		return true
	end

	if self.jumpVector.y > 0 then
		return false
	end

	local var_55_0, var_55_1 = Physics.Raycast(self._tf.position + self.characterController.center, Vector3.down, nil, 2, var_0_8)

	if var_55_0 then
		return true
	end

	return false
end

function IslandPlayerUnit:OnDetach()
	if self.delayMoveTimer then
		self.delayMoveTimer:Stop()

		self.delayMoveTimer = nil
	end

	if self.delayAttackTimer then
		self.delayAttackTimer:Stop()

		self.delayAttackTimer = nil
	end

	self:ClearAnimationTools()
	self.shipDressHelper:Destroy()
	self.characterHandleController:AddStateEnterFunc(nil)
	self.characterHandleController:AddStateExitFunc(nil)

	return
end

function IslandPlayerUnit:ClearAnimationTools()
	for iter_57_0, iter_57_1 in pairs(self.objTfList) do
		Object.Destroy(iter_57_1.gameObject)
	end

	self.objTfList = {}

	return
end

function IslandPlayerUnit:SetActiveByLayer(arg_58_1)
	if arg_58_1 then
		pg.ViewUtils.SetLayer(self._tf, Layer.Default)
	else
		pg.ViewUtils.SetLayer(self._tf, Layer.UIHidden)
	end

	return
end

function IslandPlayerUnit:SetShipDressHelper(arg_59_1)
	self.shipDressHelper = arg_59_1

	return
end

function IslandPlayerUnit:OnChangeDress(arg_60_1, arg_60_2)
	local var_60_0 = {}
	local var_60_1 = getProxy(IslandProxy):GetIsland():GetDressUpAgency()

	local function var_60_2(arg_61_0)
		for iter_61_0, iter_61_1 in ipairs(arg_60_2) do
			if arg_61_0 == iter_61_1.id then
				return iter_61_1.color, true
			end
		end

		return var_60_1:GetCurrentColorByDressId(arg_61_0), false
	end

	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		local var_60_3, var_60_4 = var_60_2(iter_60_1.id)

		if var_60_4 then
			var_60_0[iter_60_1.id] = true
		end

		self.shipDressHelper:ChangeDressByType(iter_60_1.type, {
			id = iter_60_1.id,
			colorId = var_60_3
		})
	end

	for iter_60_2, iter_60_3 in ipairs(arg_60_2) do
		if not var_60_0[iter_60_3.id] then
			self.shipDressHelper:ChangeCommanderPartColor(pg.island_dress_template[iter_60_3.id].type, iter_60_3.color)
		end
	end

	return
end

function IslandPlayerUnit:InitDress()
	return
end

return IslandPlayerUnit
