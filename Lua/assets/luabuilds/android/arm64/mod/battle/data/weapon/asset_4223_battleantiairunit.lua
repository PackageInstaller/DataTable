ys = ys or {}

local var_0_0 = ys
local BattleAntiAirUnit = class("BattleAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleAntiAirUnit = BattleAntiAirUnit
BattleAntiAirUnit.__name = "BattleAntiAirUnit"

function BattleAntiAirUnit:Ctor()
	BattleAntiAirUnit.super.Ctor(self)

	return
end

function BattleAntiAirUnit:TriggerBuffOnFire()
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})

	return
end

function BattleAntiAirUnit:FilterTarget()
	local var_3_0 = {}
	local var_3_1 = self._host:GetIFF()

	for iter_3_0, iter_3_1 in pairs((self._dataProxy:GetAircraftList())) do
		if iter_3_1:GetIFF() ~= var_3_1 and iter_3_1:IsVisitable() then
			var_3_0[1] = iter_3_1
		end
	end

	return var_3_0
end

function BattleAntiAirUnit:Spawn(arg_4_1, arg_4_2)
	local var_4_0 = BattleAntiAirUnit.super.Spawn(self, arg_4_1, arg_4_2)

	var_4_0:SetDirectHitUnit(arg_4_2)

	return var_4_0
end

function BattleAntiAirUnit:TriggerBuffWhenSpawn(arg_5_1)
	local var_5_0 = {
		_bullet = arg_5_1,
		bulletTag = arg_5_1:GetExtraTag()
	}

	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_5_0)
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_BULLET_CREATE, var_5_0)

	return
end

return
