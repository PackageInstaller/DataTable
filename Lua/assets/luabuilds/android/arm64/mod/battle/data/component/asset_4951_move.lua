ys = ys or {}

local MoveComponent = class("MoveComponent")

ys.Battle.MoveComponent = MoveComponent
MoveComponent._pos = Vector3.zero
MoveComponent._isForceMove = false
MoveComponent._staticState = false
MoveComponent._speed = Vector3.zero
MoveComponent._additiveSpeedList = {}
MoveComponent._additiveSpeed = Vector3.zero
MoveComponent._corpsLimitSpeed = 0
MoveComponent._leftCorpsBound = 0
MoveComponent._rightCorpsBound = 0
MoveComponent._immuneAreaLimit = false
MoveComponent._immuneMaxAreaLimit = false
MoveComponent._leftBorder = 0
MoveComponent._rightBorder = 0
MoveComponent._upBorder = 0
MoveComponent._downBorder = 0
MoveComponent._IFF = 0

function MoveComponent:Ctor()
	return
end

function MoveComponent:GetPos()
	return self._pos
end

function MoveComponent:SetPos(arg_3_1)
	self._pos = arg_3_1

	return
end

function MoveComponent:Update()
	self._speed = self:GetFinalSpeed()

	return
end

function MoveComponent:FixSpeed(arg_5_1)
	assert(arg_5_1.FixSpeed ~= nil and type(arg_5_1.FixSpeed) == "function", " MoveComponent.FixSpeed 速度修正出错")
	arg_5_1:FixSpeed(self._speed)

	return
end

function MoveComponent:Move(arg_6_1)
	arg_6_1 = arg_6_1 or 1
	self._pos.x = self._pos.x + self._speed.x * arg_6_1
	self._pos.y = self._pos.y + self._speed.y * arg_6_1
	self._pos.z = self._pos.z + self._speed.z * arg_6_1

	return
end

function MoveComponent:GetSpeed()
	return self._speed
end

function MoveComponent:SetCorpsArea(arg_8_1, arg_8_2)
	self._leftCorpsBound = arg_8_1
	self._rightCorpsBound = arg_8_2

	return
end

function MoveComponent:SetBorder(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	self._leftBorder = arg_9_1
	self._rightBorder = arg_9_2
	self._upBorder = arg_9_3
	self._downBorder = arg_9_4

	return
end

function MoveComponent:GetFinalSpeed()
	local var_10_0 = self:getInitialSpeed()

	if not self._unstoppable then
		var_10_0 = self:AdditiveForce(var_10_0)
	end

	return (self:BorderLimit(var_10_0))
end

function MoveComponent:CorpsAreaLimit(arg_11_1)
	if self._immuneAreaLimit then
		return arg_11_1
	end

	local var_11_0 = self._pos.x
	local var_11_1 = self._corpsLimitSpeed

	if self._pos.x < self._leftCorpsBound then
		var_11_1 = math.max(var_11_1, 0.1)

		if arg_11_1.x < 0 then
			var_11_1 = math.min(10, var_11_1 * 1.04)
		end
	elseif var_11_0 > self._rightCorpsBound then
		var_11_1 = math.min(var_11_1, -0.1)

		if arg_11_1.x > 0 then
			var_11_1 = math.max(-10, var_11_1 * 1.04)
		end
	else
		var_11_1 = var_11_1 < 0.1 and var_11_1 > -0.1 and 0 or var_11_1 * 0.8
	end

	self._corpsLimitSpeed = var_11_1
	arg_11_1.x = arg_11_1.x + self._corpsLimitSpeed

	return arg_11_1
end

function MoveComponent:BorderLimit(arg_12_1)
	if self._immuneMaxAreaLimit then
		return arg_12_1
	end

	local var_12_0 = self._pos

	if arg_12_1.x < 0 and var_12_0.x <= self._leftBorder or arg_12_1.x > 0 and var_12_0.x >= self._rightBorder then
		arg_12_1.x = 0
	end

	if arg_12_1.z < 0 and var_12_0.z <= self._downBorder or arg_12_1.z > 0 and var_12_0.z >= self._upBorder then
		arg_12_1.z = 0
	end

	return arg_12_1
end

function MoveComponent:ImmuneAreaLimit(arg_13_1)
	self._immuneAreaLimit = arg_13_1

	return
end

function MoveComponent:ImmuneMaxAreaLimit(arg_14_1)
	self._immuneMaxAreaLimit = arg_14_1

	return
end

function MoveComponent:getInitialSpeed()
	if self._isForceMove and not self._unstoppable then
		self:UpdateForceMove()

		return self._forceSpeed
	end

	if self._staticState and not self._unstoppable then
		return Vector3.zero
	end

	if self._manuallyMove then
		return self:CorpsAreaLimit(self._manuallyMove())
	end

	assert(self._autoMoveAi ~= nil, "角色缺少默认移动的ai")

	return self._autoMoveAi()
end

function MoveComponent:SetForceMove(arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5)
	self._isForceMove = true
	arg_16_1 = arg_16_1.normalized
	self._forceSpeed = arg_16_1 * arg_16_2
	self._forceReduce = arg_16_1 * arg_16_3
	self._forceLastTime = arg_16_4
	self._decayValve = arg_16_5 or 0

	return
end

function MoveComponent:UpdateForceMove()
	if self._forceLastTime <= 0 then
		self:ClearForceMove()

		return
	end

	self._forceLastTime = self._forceLastTime - 1

	if self._forceLastTime < self._decayValve then
		self._forceSpeed:Sub(self._forceReduce)
	end

	return
end

function MoveComponent:ClearForceMove()
	self._isForceMove = false
	self._forceSpeed = nil
	self._forceReduce = nil
	self._forceLastTime = nil

	return
end

function MoveComponent:SetStaticState(arg_19_1)
	self._staticState = arg_19_1

	return
end

function MoveComponent:SetAutoMoveAI(arg_20_1, arg_20_2)
	function self._autoMoveAi()
		return arg_20_1:GetDirection():Mul(arg_20_2:GetAttrByName("velocity"))
	end

	return
end

function MoveComponent:SetFormationCtrlInfo(arg_22_1)
	function self._manuallyMove()
		return self:UpdateFleetInfo(arg_22_1)
	end

	return
end

function MoveComponent:CancelFormationCtrl()
	self._manuallyMove = nil

	return
end

function MoveComponent:SetMotionVO(arg_25_1)
	self._fleetMotionVO = arg_25_1

	return
end

function MoveComponent:UpdateFleetInfo(arg_26_1)
	local var_26_0 = self._fleetMotionVO:GetSpeed()

	if arg_26_1:EqualZero() then
		return var_26_0
	end

	return (self._fleetMotionVO:GetDirAngle() * arg_26_1):Add((self._fleetMotionVO:GetPos())):Sub(self._pos):Div(25):Add(var_26_0)
end

function MoveComponent:AdditiveForce(arg_27_1)
	arg_27_1.x = arg_27_1.x + self._additiveSpeed.x
	arg_27_1.z = arg_27_1.z + self._additiveSpeed.z

	return arg_27_1
end

function MoveComponent:UpdateAdditiveSpeed(arg_28_1)
	self._additiveSpeed = arg_28_1

	return
end

function MoveComponent:RemoveAdditiveSpeed()
	self._additiveSpeed = Vector3.zero

	return
end

function MoveComponent:ActiveUnstoppable(arg_30_1)
	self._unstoppable = arg_30_1

	return
end

return
