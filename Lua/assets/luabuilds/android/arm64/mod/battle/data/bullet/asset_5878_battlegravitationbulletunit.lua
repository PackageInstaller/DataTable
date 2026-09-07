ys = ys or {}

local BattleGravitationBulletUnit = class("BattleGravitationBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleGravitationBulletUnit = BattleGravitationBulletUnit
BattleGravitationBulletUnit.__name = "BattleGravitationBulletUnit"

function BattleGravitationBulletUnit:Ctor(arg_1_1, arg_1_2)
	BattleGravitationBulletUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleGravitationBulletUnit:Update(arg_2_1)
	if self._pierceCount > 0 then
		BattleGravitationBulletUnit.super.Update(self, arg_2_1)
	end

	return
end

function BattleGravitationBulletUnit:SetTemplateData(arg_3_1)
	BattleGravitationBulletUnit.super.SetTemplateData(self, arg_3_1)

	self._hitInterval = arg_3_1.hit_type.interval or 0.2

	return
end

function BattleGravitationBulletUnit:GetExplodePostion()
	return self._explodePos
end

function BattleGravitationBulletUnit:SetExplodePosition(arg_5_1)
	self._explodePos = arg_5_1

	return
end

function BattleGravitationBulletUnit:DealDamage()
	self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._hitInterval

	return
end

function BattleGravitationBulletUnit:CanDealDamage()
	if not self._nextDamageTime then
		self._nextDamageTime = pg.TimeMgr.GetInstance():GetCombatTime() + self._tempData.extra_param.alert_duration

		return false
	else
		return self._nextDamageTime < pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

function BattleGravitationBulletUnit:Hit(arg_8_1, arg_8_2)
	BattleGravitationBulletUnit.super.Hit(self, arg_8_1, arg_8_2)

	self._pierceCount = self._pierceCount - 1
	self._position.y = 100

	return
end

return
