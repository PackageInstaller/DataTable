ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleStrayBullet = class("BattleStrayBullet", ys.Battle.BattleBullet)
ys.Battle.BattleStrayBullet.__name = "BattleStrayBullet"

local var_0_2 = ys.Battle.BattleStrayBullet

function ys.Battle.BattleStrayBullet.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleStrayBullet:SetSpawn(arg_2_1)
	var_0_2.super.SetSpawn(self, arg_2_1)

	self._targetPos = Clone(self._bulletData:GetExplodePostion())
	self._spawnDir = self._speed.normalized
	self._velocity = self._bulletData:GetVelocity() * (1 + var_0_0.Battle.BattleAttr.GetCurrent(self._bulletData, "bulletSpeedRatio"))
	self._velocity = var_0_0.Battle.BattleFormulas.ConvertBulletSpeed(self._velocity)
	self._step = Vector3.Distance(self._targetPos, self._spawnPos) / self._velocity
	self._count = math.random(600) - 300
	self.updateSpeed = var_0_2._doStray

	return
end

function ys.Battle.BattleStrayBullet:_doStray()
	if self._step > 0 and self._targetPos and not self._targetPos:EqualZero() then
		self._count = self._count / 1.06
		self._step = self._step - 1

		local var_3_0 = self._bulletData:GetPosition()

		self._speed = Vector3(self._targetPos.x - var_3_0.x, 0, self._targetPos.z - var_3_0.z).normalized
		self._speed = self._speed + Vector3(self._speed.z * self._count / 100, 0, -self._speed.x * self._count / 100)
		self._speed = self._speed.normalized
		self._speed = Vector3(self._speed.x * self._velocity, 0, self._speed.z * self._velocity)
	else
		self.updateSpeed = var_0_2._updateSpeed
	end

	return
end

return
