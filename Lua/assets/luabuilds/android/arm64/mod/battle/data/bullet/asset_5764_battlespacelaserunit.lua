ys = ys or {}

local BattleSpaceLaserUnit = class("BattleSpaceLaserUnit", ys.Battle.BattleColumnAreaBulletUnit)

BattleSpaceLaserUnit.__name = "BattleSpaceLaserUnit"
ys.Battle.BattleSpaceLaserUnit = BattleSpaceLaserUnit
BattleSpaceLaserUnit.STATE_READY = "Ready"
BattleSpaceLaserUnit.STATE_PRECAST = "Precast"
BattleSpaceLaserUnit.STATE_ATTACK = "Attack"
BattleSpaceLaserUnit.STATE_DESTROY = "Destroy"

function BattleSpaceLaserUnit:Ctor(...)
	BattleSpaceLaserUnit.super.Ctor(self, ...)

	self._collidedTimes = {}

	return
end

function BattleSpaceLaserUnit:Dispose()
	self._lifeEndCb = nil
	self._collidedTimes = nil

	BattleSpaceLaserUnit.super.Dispose(self)

	return
end

function BattleSpaceLaserUnit:ExecuteLifeEndCallback()
	if self._lifeEndCb then
		self._lifeEndCb()
	end

	return
end

function BattleSpaceLaserUnit:AssertFields(arg_4_1)
	assert(self[arg_4_1], "Lack Field " .. arg_4_1)

	return
end

function BattleSpaceLaserUnit:SetTemplateData(arg_5_1)
	self.AssertFields(arg_5_1.extra_param, "attack_time")
	self.AssertFields(arg_5_1.hit_type, "interval")
	BattleSpaceLaserUnit.super.SetTemplateData(self, arg_5_1)

	self._hitInterval = arg_5_1.hit_type.interval

	return
end

function BattleSpaceLaserUnit:GetHitInterval()
	return self._hitInterval
end

function BattleSpaceLaserUnit:DoTrack()
	local var_7_0 = self:getTrackingTarget()

	if not var_7_0 or var_7_0 == -1 then
		return
	elseif not var_7_0:IsAlive() then
		self:setTrackingTarget(-1)
		self._speed:SetNormalize():Mul(self._convertedVelocity)

		return
	elseif self:GetDistance(var_7_0) > self._trackRange then
		self:setTrackingTarget(-1)
		self._speed:SetNormalize():Mul(self._convertedVelocity)

		return
	end

	local var_7_1 = var_7_0:GetPosition() - self:GetPosition()
	local var_7_2 = var_7_1:Magnitude()

	if var_7_2 <= 1e-05 then
		self._speed:Set(0, 0, 0)

		return
	end

	local var_7_3 = self._speedNormal

	var_7_1:SetNormalize()

	local var_7_4 = self:GetSpeedRatio()
	local var_7_5 = math.cos(self._cosAngularSpeed * var_7_4)
	local var_7_6 = var_7_1.x * var_7_3.x + var_7_1.z * var_7_3.z
	local var_7_7 = var_7_1.z * var_7_3.x - var_7_1.x * var_7_3.z

	if var_7_1.x * var_7_3.x + var_7_1.z * var_7_3.z < var_7_5 then
		var_7_6 = var_7_5
		var_7_7 = math.sin(self._sinAngularSpeed * var_7_4) * (var_7_7 > 0 and 1 or -1)
	end

	local var_7_8 = var_7_3.x * var_7_6 - var_7_3.z * var_7_7

	self._speed:Set(var_7_3.x * var_7_6 - var_7_3.z * var_7_7, 0, var_7_3.z * var_7_6 + var_7_3.x * var_7_7)
	self._speed:Mul((math.min(self._convertedVelocity, var_7_2)))
	self._speedNormal:Set(var_7_8, 0, var_7_3.z * var_7_6 + var_7_3.x * var_7_7)
	self._speedNormal:SetNormalize()

	self._yAngle = math.rad2Deg * math.atan2(var_7_8, var_7_3.z * var_7_6 + var_7_3.x * var_7_7)

	return
end

function BattleSpaceLaserUnit:InitSpeed(...)
	BattleSpaceLaserUnit.super.InitSpeed(self, ...)

	if self:IsTracker() then
		self._speedNormal = Vector3(math.cos(math.deg2Rad * self._yAngle), 0, math.sin(math.deg2Rad * self._yAngle))
		self.updateSpeed = self.DoTrack
	elseif self:IsCircle() and self:IsAlert() then
		self._centripetalSpeed = self._centripetalSpeed * self.alertSpeedRatio
	end

	return
end

function BattleSpaceLaserUnit:SetLifeTime(arg_9_1)
	self._lifeTime = arg_9_1

	return
end

function BattleSpaceLaserUnit:SetAlert(arg_10_1)
	self._alertFlag = arg_10_1

	local var_10_0 = self:GetTemplate().extra_param

	if not var_10_0.alertSpeed then
		return
	end

	self:ResetVelocity(self._velocity * var_10_0.alertSpeed)

	self.alertSpeedRatio = var_10_0.alertSpeed

	return
end

function BattleSpaceLaserUnit:IsAlert()
	return self._alertFlag
end

function BattleSpaceLaserUnit:Update(arg_12_1)
	BattleSpaceLaserUnit.super.Update(self, arg_12_1)

	self._reachDestFlag = arg_12_1 > self._timeStamp + self._lifeTime

	local var_12_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	for iter_12_0, iter_12_1 in pairs(self._collidedTimes) do
		if var_12_0 > iter_12_1 + self._hitInterval then
			self._collidedTimes[iter_12_0] = nil
			self._collidedList[iter_12_0] = nil
		end
	end

	return
end

function BattleSpaceLaserUnit:GetCollidedList()
	return self._collidedList, self._collidedTimes
end

function BattleSpaceLaserUnit:RegisterLifeEndCB(arg_14_1)
	self._lifeEndCb = arg_14_1

	return
end

function BattleSpaceLaserUnit:UnRegisterLifeEndCB()
	self._lifeEndCb = nil

	return
end

return
