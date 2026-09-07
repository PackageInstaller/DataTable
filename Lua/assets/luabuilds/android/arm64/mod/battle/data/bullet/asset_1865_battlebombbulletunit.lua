ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleBombBulletUnit = class("BattleBombBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleBombBulletUnit.__name = "BattleBombBulletUnit"

local var_0_3 = ys.Battle.BattleBombBulletUnit

function ys.Battle.BattleBombBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._randomOffset = Vector3.zero

	return
end

function ys.Battle.BattleBombBulletUnit:InitSpeed()
	self._yAngle = self._barrageLowPriority and self._baseAngle + self._barrageAngle or math.rad2Deg * math.atan2(self._explodePos.z - self._spawnPos.z, self._explodePos.x - self._spawnPos.x)

	self:calcSpeed()

	self.updateSpeed = var_0_3.doNothing

	return
end

function ys.Battle.BattleBombBulletUnit:Update()
	if self._exist then
		var_0_3.super.Update(self)
	end

	return
end

function ys.Battle.BattleBombBulletUnit.GetPierceCount(arg_4_0)
	return 1
end

function ys.Battle.BattleBombBulletUnit:IsOutRange(arg_5_1)
	if not self._exist then
		return false
	end

	if self._explodeTime and arg_5_1 >= self._explodeTime then
		return true
	end

	if self._reachDestFlag and not self._explodeTime then
		return true
	else
		return false
	end

	return
end

function ys.Battle.BattleBombBulletUnit:OutRange()
	self:DispatchEvent(var_0_0.Event.New(var_0_1.EXPLODE, {
		UID = unitUniqueID
	}))
	var_0_3.super.OutRange(self)

	return
end

function ys.Battle.BattleBombBulletUnit:SetSpawnPosition(arg_7_1)
	var_0_3.super.SetSpawnPosition(self, arg_7_1)

	if self._barragePriority then
		self._explodePos = self._explodePos + Vector3(self._offsetX, 0, self._offsetZ)

		local var_7_0 = pg.Tool.FilterY(self._spawnPos)

		self._explodePos = Quaternion.Euler(0, self._barrageAngle, 0) * (self._explodePos - var_7_0) + var_7_0
	end

	if self._fixToRange and Vector3.BattleDistance(self._explodePos, self._spawnPos) > self._range then
		self._explodePos = Vector3.Normalize((pg.Tool.FilterY(self._explodePos - self._spawnPos))) * self._range + self._spawnPos
	end

	if self._convertedVelocity ~= 0 then
		local var_7_1 = Vector3.Distance(pg.Tool.FilterY(self._spawnPos), self._explodePos) / self._convertedVelocity

		self._verticalSpeed = self:GetTemplate().extra_param.launchVrtSpeed or (self._explodePos.y - self._spawnPos.y) / var_7_1 - 0.5 * self._gravity * var_7_1
	end

	return
end

function ys.Battle.BattleBombBulletUnit:SetExplodePosition(arg_8_1)
	local var_8_0 = self:GetTemplate().extra_param

	self._explodePos = var_8_0.targetFixX and var_8_0.targetFixZ and Vector3(var_8_0.targetFixX, 0, var_8_0.targetFixZ) or arg_8_1:Clone()

	if not self._barragePriority then
		self._explodePos = self._explodePos + self._randomOffset
	end

	self._explodePos.y = var_0_2.BombDetonateHeight

	return
end

function ys.Battle.BattleBombBulletUnit:SetShiftInfo(arg_9_1, arg_9_2)
	var_0_3.super.SetShiftInfo(self, arg_9_1, arg_9_2)

	if self:GetTemplate().extra_param.currentdrop then
		self._explodePos.x = self._explodePos.x + self._offsetX
		self._explodePos.z = self._explodePos.z + self._offsetZ
	end

	return
end

function ys.Battle.BattleBombBulletUnit:SetTemplateData(arg_10_1)
	var_0_3.super.SetTemplateData(self, arg_10_1)

	local var_10_0 = self:GetTemplate().extra_param

	self._barragePriority = var_10_0.barragePriority
	self._barrageLowPriority = var_10_0.barrageLowPriority
	self._fixToRange = var_10_0.fixToRange

	if var_10_0.barragePriority then
		self._randomOffset = Vector3.zero
	else
		local var_10_1 = 0

		if var_10_0.accuracy then
			var_10_1 = self:GetAttrByName(var_10_0.accuracy)
		end

		local var_10_2 = var_10_0.randomOffsetZ or 0
		local var_10_3 = math.max(0, (var_10_0.randomOffsetX or 0) - var_10_1)
		local var_10_4 = math.max(0, var_10_2 - var_10_1)
		local var_10_5 = var_10_0.offsetZ or 0

		if var_10_3 ~= 0 then
			var_10_3 = var_10_3 * (math.random() - 0.5) + (var_10_0.offsetX or 0)
		end

		if var_10_4 ~= 0 then
			var_10_4 = var_10_4 * (math.random() - 0.5) + var_10_5
		end

		self._randomOffset = Vector3(var_10_3 + (var_10_0.targetOffsetX or 0), 0, var_10_4 + (var_10_0.targetOffsetZ or 0))
	end

	if var_10_0.timeToExplode then
		self._explodeTime = pg.TimeMgr.GetInstance():GetCombatTime() + var_10_0.timeToExplode
	end

	self._gravity = var_10_0.gravity or var_0_0.Battle.BattleConfig.GRAVITY
	self._hitInterval = arg_10_1.hit_type.interval or 0.2

	return
end

function ys.Battle.BattleBombBulletUnit:DealDamage()
	self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._hitInterval

	return
end

function ys.Battle.BattleBombBulletUnit:CanDealDamage()
	if not self._nextDamageTime then
		self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._tempData.extra_param.alert_duration

		return false
	else
		return self._nextDamageTime < pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

function ys.Battle.BattleBombBulletUnit:HideBullet()
	self._position.x = 0
	self._position.y = 100
	self._position.z = 0

	return
end

function ys.Battle.BattleBombBulletUnit:GetExplodePostion()
	return self._explodePos
end

return
