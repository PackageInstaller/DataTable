ys = ys or {}

local var_0_0 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleConfig
local BattleBombBullet = class("BattleBombBullet", ys.Battle.BattleBullet)

ys.Battle.BattleBombBullet = BattleBombBullet
BattleBombBullet.__name = "BattleBombBullet"

function BattleBombBullet:Ctor()
	BattleBombBullet.super.Ctor(self)

	return
end

function BattleBombBullet:Dispose()
	if self._alert then
		self._alert:Dispose()
	end

	BattleBombBullet.super.Dispose(self)

	return
end

function BattleBombBullet:AddBulletEvent()
	self._bulletData:RegisterEventListener(self, var_0_0.EXPLODE, self.onBulletExplode)

	return
end

function BattleBombBullet:RemoveBulletEvent()
	self._bulletData:UnregisterEventListener(self, var_0_0.EXPLODE)

	return
end

function BattleBombBullet:onBulletExplode(arg_5_1)
	self:_bulletHitFunc()

	return
end

function BattleBombBullet:UpdatePosition()
	local var_6_0 = Vector3.Lerp(self._tf.localPosition, self:GetPosition(), var_0_2.BulletMotionRate)

	self._tf.localPosition = var_6_0

	self._cacheTFPos:Set(var_6_0.x, var_6_0.y, var_6_0.z)

	return
end

return
