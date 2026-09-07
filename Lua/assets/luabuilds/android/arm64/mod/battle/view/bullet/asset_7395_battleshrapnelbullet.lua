ys = ys or {}

local var_0_0 = ys.Battle.BattleBulletEvent
local BattleShrapnelBullet = class("BattleShrapnelBullet", ys.Battle.BattleBullet)

ys.Battle.BattleShrapnelBullet = BattleShrapnelBullet
BattleShrapnelBullet.__name = "BattleShrapnelBullet"

function BattleShrapnelBullet:Ctor(arg_1_1, arg_1_2)
	BattleShrapnelBullet.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleShrapnelBullet:AddBulletEvent()
	BattleShrapnelBullet.super.AddBulletEvent(self)
	self._bulletData:RegisterEventListener(self, var_0_0.SPLIT, self.onBulletSplit)

	return
end

function BattleShrapnelBullet:RemoveBulletEvent()
	BattleShrapnelBullet.super.RemoveBulletEvent(self)
	self._bulletData:UnregisterEventListener(self, var_0_0.SPLIT)

	return
end

function BattleShrapnelBullet:onBulletSplit(arg_4_1)
	self:_bulletHitFunc()

	return
end

return
