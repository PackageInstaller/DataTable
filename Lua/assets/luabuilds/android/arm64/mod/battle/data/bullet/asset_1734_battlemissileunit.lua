ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleBulletEvent
local var_0_5 = ys.Battle.BattleFormulas
local BattleMissileUnit = class("BattleMissileUnit", ys.Battle.BattleBulletUnit)

BattleMissileUnit.__name = "BattleMissileUnit"
ys.Battle.BattleMissileUnit = BattleMissileUnit
BattleMissileUnit.STATE_LAUNCH = "Launch"
BattleMissileUnit.STATE_ATTACK = "Attack"
BattleMissileUnit.TYPE_COORD = 1
BattleMissileUnit.TYPE_RANGE = 2
BattleMissileUnit.TYPE_TARGET = 3

function BattleMissileUnit:Ctor(...)
	BattleMissileUnit.super.Ctor(self, ...)

	self._state = self.STATE_LAUNCH

	return
end

function BattleMissileUnit:SetTemplateData(arg_2_1)
	BattleMissileUnit.super.SetTemplateData(self, arg_2_1)
	self:ResetVelocity(0)

	local var_2_0 = self:GetTemplate().extra_param

	self._gravity = var_2_0.gravity or var_0_0.Battle.BattleConfig.GRAVITY
	self._targetType = var_2_0.aimType or BattleMissileUnit.TYPE_TARGET

	return
end

function BattleMissileUnit:GetPierceCount()
	return 1
end

function BattleMissileUnit:RegisterOnTheAir(arg_4_1)
	self._onTheHighest = arg_4_1

	return
end

function BattleMissileUnit:SetExplodePosition(arg_5_1)
	self._explodePos = arg_5_1:Clone()
	self._explodePos.y = var_0_1.BombDetonateHeight

	return
end

function BattleMissileUnit:GetExplodePostion()
	return self._explodePos
end

local var_0_7 = 1 / ys.Battle.BattleConfig.viewFPS

function BattleMissileUnit:SetSpawnPosition(arg_7_1)
	BattleMissileUnit.super.SetSpawnPosition(self, arg_7_1)

	self._verticalSpeed = self:GetTemplate().extra_param.launchVrtSpeed

	return
end

function BattleMissileUnit:Update(arg_8_1)
	BattleMissileUnit.super.Update(self, arg_8_1)

	if self._state == self.STATE_LAUNCH and arg_8_1 > self:GetTemplate().extra_param.launchRiseTime + self._timeStamp then
		self:CompleteRise()
	end

	return
end

function BattleMissileUnit:CompleteRise()
	self._state = self.STATE_ATTACK
	self._gravity = 0

	if self._onTheHighest then
		self._onTheHighest()
	end

	local var_9_0 = self:GetTemplate().extra_param.fallTime

	self._targetPos = self._explodePos
	self._yAngle = math.rad2Deg * math.atan2(self._explodePos.z - self._spawnPos.z, self._explodePos.x - self._spawnPos.x)
	self._verticalSpeed = -(self._position.y / var_9_0) * var_0_7

	self:ResetVelocity(var_0_5.ConvertBulletDataSpeed(pg.Tool.FilterY(self._explodePos - self._position):Magnitude() / var_9_0 * var_0_7))
	self:calcSpeed()

	return
end

function BattleMissileUnit:IsOutRange()
	return self._state == self.STATE_ATTACK and self._position.y <= var_0_1.BombDetonateHeight
end

function BattleMissileUnit:OutRange(arg_11_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_3.EXPLODE, {
		UID = arg_11_1
	}))
	BattleMissileUnit.super.OutRange(self)

	return
end

function BattleMissileUnit:GetMissileTargetPosition()
	if self._targetType == BattleMissileUnit.TYPE_RANGE then
		return self:aimRange()
	elseif self._targetType == BattleMissileUnit.TYPE_COORD then
		return self:aimCoord()
	elseif self._targetType == BattleMissileUnit.TYPE_TARGET then
		return self:aimTarget()
	end

	return
end

function BattleMissileUnit:aimRange()
	return (Vector3(self._spawnPos.x + self._range * self:GetIFF(), 0, 0))
end

function BattleMissileUnit:aimCoord()
	local var_14_0 = self:GetTemplate().extra_param

	if not var_14_0.missileX or not var_14_0.missileZ then
		return self:aimRange()
	end

	return (Vector3(var_14_0.missileX, 0, var_14_0.missileZ))
end

function BattleMissileUnit:aimTarget()
	local var_15_0 = self:GetWeapon()
	local var_15_1 = var_15_0:GetHost()

	if not var_15_1 or not var_15_1:IsAlive() then
		return self:aimCoord()
	end

	local var_15_2 = var_15_0:Tracking()

	return var_15_0:GetTemplateData().aim_type == var_0_2.WeaponAimType.AIM and var_15_2 and var_15_0:CalculateRandTargetPosition(self, var_15_2) or var_15_0:CalculateFixedExplodePosition(self)
end

return
