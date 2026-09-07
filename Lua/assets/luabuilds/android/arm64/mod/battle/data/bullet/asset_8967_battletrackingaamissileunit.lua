ys = ys or {}

local var_0_0 = ys
local var_0_1 = Vector3.up
local var_0_2 = ys.Battle.BattleTargetChoise
local BattleTrackingAAMissileUnit = class("BattleTrackingAAMissileUnit", ys.Battle.BattleBulletUnit)

BattleTrackingAAMissileUnit.__name = "BattleTrackingAAMissileUnit"
ys.Battle.BattleTrackingAAMissileUnit = BattleTrackingAAMissileUnit

function BattleTrackingAAMissileUnit:doAccelerate(arg_1_1)
	local var_1_0, var_1_1 = self:GetAcceleration(arg_1_1)

	if var_1_0 == 0 and var_1_1 == 0 then
		return
	end

	if var_1_0 < 0 and self._speedLength + var_1_0 < 0 then
		self:reverseAcceleration()
	end

	self._speed:Set(self._speed.x + self._speedNormal.x * var_1_0 + self._speedCross.x * var_1_1, self._speed.y + self._speedNormal.y * var_1_0 + self._speedCross.y * var_1_1, self._speed.z + self._speedNormal.z * var_1_0 + self._speedCross.z * var_1_1)

	self._speedLength = self._speed:Magnitude()

	if self._speedLength ~= 0 then
		self._speedNormal:Copy(self._speed)
		self._speedNormal:Div(self._speedLength)
	end

	self._speedCross:Copy(self._speedNormal)
	self._speedCross:Cross2(var_0_1)

	return
end

function BattleTrackingAAMissileUnit:doTrack()
	if self:getTrackingTarget() == nil then
		local var_2_0 = var_0_2.TargetWeightiest(self, nil, (self:GetFilteredList()))[1]

		if var_2_0 ~= nil then
			self:setTrackingTarget(var_2_0)
		end
	end

	local var_2_1 = self:getTrackingTarget()

	if var_2_1 == nil or var_2_1 == -1 then
		return
	elseif not var_2_1:IsAlive() then
		self:CleanAimMark()
		self:setTrackingTarget(-1)

		return
	end

	local var_2_2 = var_2_1:GetBeenAimedPosition()

	if not var_2_2 then
		return
	end

	local var_2_3 = var_2_2 - self:GetPosition()

	var_2_3:SetNormalize()

	local var_2_4 = Vector3.Normalize(self._speed)
	local var_2_5 = self:GetSpeedRatio()
	local var_2_6 = Vector3.Dot(var_2_4, var_2_3)

	self._speed:Set(self._speed.x * var_2_6 + self._speed.z * (var_2_4.z * var_2_3.x - var_2_4.x * var_2_3.z), 0, self._speed.z * var_2_6 - self._speed.x * (var_2_4.z * var_2_3.x - var_2_4.x * var_2_3.z))

	return
end

function BattleTrackingAAMissileUnit:doNothing()
	if self._gravity ~= 0 then
		self._verticalSpeed = self._verticalSpeed + self._gravity * self:GetSpeedRatio()
	end

	return
end

function BattleTrackingAAMissileUnit:GetFilteredList()
	return (self:FilterAngle((self:FilterRange((var_0_2.TargetAllHarm(self))))))
end

function BattleTrackingAAMissileUnit:FilterRange(arg_5_1)
	if not self._trackDist then
		return arg_5_1
	end

	for iter_5_0 = #arg_5_1, 1, -1 do
		if self:IsOutOfRange(arg_5_1[iter_5_0]) then
			table.remove(arg_5_1, iter_5_0)
		end
	end

	return arg_5_1
end

function BattleTrackingAAMissileUnit:IsOutOfRange(arg_6_1)
	if not self._trackDist then
		return true
	end

	return self:GetDistance(arg_6_1) > self._trackDist
end

function BattleTrackingAAMissileUnit:FilterAngle(arg_7_1)
	if not self._trackAngle or self._trackAngle >= 360 then
		return arg_7_1
	end

	for iter_7_0 = #arg_7_1, 1, -1 do
		if self:IsOutOfAngle(arg_7_1[iter_7_0]) then
			table.remove(arg_7_1, iter_7_0)
		end
	end

	return arg_7_1
end

function BattleTrackingAAMissileUnit:IsOutOfAngle(arg_8_1)
	if not self._trackAngle or self._trackAngle >= 360 then
		return false
	end

	local var_8_0 = arg_8_1:GetPosition() - self:GetPosition()
	local var_8_1 = math.acos(Vector3.Dot(var_8_0, self._speedNormal) / var_8_0:Magnitude())

	return var_8_1 > self._trackRadian or var_8_1 < -self._trackRadian
end

function BattleTrackingAAMissileUnit:SetTrackingFXData(arg_9_1)
	self._trackingFXData = arg_9_1

	return
end

function BattleTrackingAAMissileUnit:InitSpeed(arg_10_1)
	if self._yAngle == nil then
		self._yAngle = self._targetPos ~= nil and arg_10_1 + self._barrageAngle or self._baseAngle + self._barrageAngle
	end

	self:calcSpeed()

	local var_10_0 = {}

	if self:IsTracker() then
		self._trackAngle = 360
		self._trackDist = self._accTable.tracker.range

		if self._accTable.tracker.angular then
			self._trackRadian = math.deg2Rad * self._trackAngle * 0.5
		end

		table.insert(var_10_0, self.doTrack)
	end

	if self:HasAcceleration() then
		self._speedLength = self._speed:Magnitude()
		self._speedNormal = self._speed / self._speedLength
		self._speedCross = Vector3.Cross(self._speedNormal, var_0_1)

		table.insert(var_10_0, function(arg_12_0, ...)
			self._speedLength = self._speed:Magnitude()
			self._speedNormal = self._speed / self._speedLength
			self._speedCross = Vector3.Cross(self._speedNormal, var_0_1)

			self.doAccelerate(arg_12_0, ...)

			return
		end)
	end

	if #var_10_0 == 0 then
		table.insert(var_10_0, self.doNothing)
	end

	function self.updateSpeed(arg_11_0, arg_11_1)
		for iter_11_0, iter_11_1 in ipairs(var_10_0) do
			iter_11_1(arg_11_0, arg_11_1)
		end

		local var_11_0 = self:getTrackingTarget()

		if var_11_0 and var_11_0 ~= -1 and not self._trackingFXData.aimingFX and self._trackingFXData.fxName and self._trackingFXData.fxName ~= "" then
			self._trackingFXData.aimingFX = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(var_11_0:GetUniqueID()):AddFX(self._trackingFXData.fxName)
		end

		return
	end

	return
end

function BattleTrackingAAMissileUnit:CleanAimMark()
	local var_13_0 = self:getTrackingTarget()

	if var_13_0 and var_13_0 ~= -1 and self._trackingFXData.aimingFX then
		local var_13_1 = var_0_0.Battle.BattleState.GetInstance():GetSceneMediator():GetCharacter(var_13_0:GetUniqueID())

		if var_13_1 then
			var_13_1:RemoveFX(self._trackingFXData.aimingFX)
		end

		self._trackingFXData.aimingFX = nil
	end

	return
end

function BattleTrackingAAMissileUnit:OutRange(...)
	self:CleanAimMark()
	BattleTrackingAAMissileUnit.super.OutRange(self, ...)

	return
end

return
