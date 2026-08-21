ys = ys or {}

local var_0_0 = class("BattleAntiAirUnit", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleAntiAirUnit = var_0_0
var_0_0.__name = "BattleAntiAirUnit"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function var_0_0.TriggerBuffOnFire(arg_2_0)
	arg_2_0._host:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})

	return
end

function var_0_0.FilterTarget(arg_3_0)
	local var_3_0 = arg_3_0._host:GetIFF()

	for iter_3_0, iter_3_1 in pairs((arg_3_0._dataProxy:GetAircraftList())) do
		local var_3_1

		if iter_3_1:GetIFF() ~= var_3_0 and iter_3_1:IsVisitable() then
			({})[1] = iter_3_1
			var_3_1 = 1 + 1
		end
	end

	return {}
end

function var_0_0.Spawn(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.super.Spawn(arg_4_0, arg_4_1, arg_4_2)

	var_4_0:SetDirectHitUnit(arg_4_2)

	return var_4_0
end

function var_0_0.TriggerBuffWhenSpawn(arg_5_0, arg_5_1)
	local var_5_0 = {
		_bullet = arg_5_1,
		bulletTag = arg_5_1:GetExtraTag()
	}

	arg_5_0._host:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_5_0)
	arg_5_0._host:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_BULLET_CREATE, var_5_0)

	return
end

return
