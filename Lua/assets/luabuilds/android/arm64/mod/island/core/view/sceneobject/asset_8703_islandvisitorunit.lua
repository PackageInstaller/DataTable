local IslandVisitorUnit = class("IslandVisitorUnit", import(".IslandNavigableUnit"))

function IslandVisitorUnit:OnUpdate()
	if self.delayTime == 0 then
		return
	end

	if self.isSleeping then
		return
	end

	self:MoveHandle()
	self:AnimHandle()

	return
end

function IslandVisitorUnit:OnStart()
	self.behaviourTreeOwner.graph.blackboard:SetVariableValue("playerId", tostring(self.id))

	return
end

function IslandVisitorUnit:OnLaterAttach(arg_3_1)
	IslandVisitorUnit.super.OnLaterAttach(self, arg_3_1)

	self.delayTime = 0
	self.syncData = nil

	return
end

function IslandVisitorUnit:UpdateSyncData(arg_4_1)
	self.syncData = arg_4_1
	self.delayTime = IslandConst.SYNC_TIME_INTERVAL

	return
end

function IslandVisitorUnit:Sleep()
	self.isSleeping = true

	return
end

function IslandVisitorUnit:WakeUp()
	self.isSleeping = false

	return
end

function IslandVisitorUnit:MoveHandle()
	local var_7_0
	local var_7_1

	if self.delayTime - Time.deltaTime > 0 then
		var_7_0 = Vector3.Lerp(self:GetLocalPosition(), self.syncData.pos, Time.deltaTime / self.delayTime)
		var_7_1 = Quaternion.Lerp(self:GetRotation(), self:GetSyncDataRotation(), Time.deltaTime / self.delayTime)
		self.delayTime = self.delayTime - Time.deltaTime
	else
		var_7_0 = self.syncData.pos
		var_7_1 = self:GetSyncDataRotation()
		self.delayTime = 0
	end

	local var_7_2 = (var_7_0 - self:GetLocalPosition()) / Time.deltaTime

	self.speed = Vector2(var_7_2.x, var_7_2.z).magnitude

	self:SetLocalPosition(var_7_0)
	self:SetRotation(var_7_1)

	return
end

function IslandVisitorUnit:AnimHandle()
	if self.speed > 0.1 then
		self.speed = 5
	end

	local var_8_0 = self:GetAnimator()

	var_8_0:SetFloat(IslandConst.SPEED_FLAG_HASH, self.speed)

	for iter_8_0 = 1, var_8_0.layerCount do
		if not var_8_0:IsInTransition(iter_8_0 - 1) then
			if var_8_0:GetCurrentAnimatorStateInfo(iter_8_0 - 1).shortNameHash ~= self.syncData.status[iter_8_0] then
				var_8_0:CrossFadeInFixedTime(self.syncData.status[iter_8_0], 0.25, iter_8_0 - 1)
			end
		end
	end

	return
end

function IslandVisitorUnit:GetSyncDataRotation()
	return self.syncData.dir
end

function IslandVisitorUnit:GetLocalPosition()
	return self._go.transform.localPosition
end

function IslandVisitorUnit:GetRotation()
	return self._go.transform.rotation
end

function IslandVisitorUnit:SetLocalPosition(arg_12_1)
	self._go.transform.localPosition = arg_12_1

	return
end

function IslandVisitorUnit:SetRotation(arg_13_1)
	self._go.transform.rotation = arg_13_1

	return
end

function IslandVisitorUnit:SetShipDressHelper(arg_14_1)
	self.shipDressHelper = arg_14_1

	return
end

function IslandVisitorUnit:OnDetach()
	if self.shipDressHelper then
		self.shipDressHelper:Destroy()
	end

	return
end

function IslandVisitorUnit:OnChangeDress(arg_16_1)
	for iter_16_0, iter_16_1 in pairs(arg_16_1) do
		if iter_16_1.changedDressColorId then
			if not iter_16_1.changeedDressId then
				self.shipDressHelper:ChangeCommanderPartColor(iter_16_0, iter_16_1.changedDressColorId)
			else
				self.shipDressHelper:ChangeDressByType(iter_16_0, {
					id = iter_16_1.changeedDressId,
					colorId = iter_16_1.changedDressColorId
				})
			end
		end
	end

	return
end

return IslandVisitorUnit
