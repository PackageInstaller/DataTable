ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleAntiAirUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattleAntiAirUnit = var_0_1
var_0_1.__name = "BattleAntiAirUnit"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.TriggerBuffOnFire(arg_2_0)
	local var_2_0 = arg_2_0._host

	var_1.TriggerBuff(var_2_0, var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})

	return
end

function var_0_1.FilterTarget(arg_3_0)
	local var_3_0 = arg_3_0._dataProxy
	local var_3_1 = var_1.GetAircraftList(var_3_0)
	local var_3_2 = {}
	local var_3_3 = arg_3_0._host
	local var_3_4 = var_3.GetIFF(var_3_3)
	local var_3_5 = 1

	pairs = var_3_3

	for iter_3_0, iter_3_1 in var_3_3(var_3_1) do
		if iter_3_1:GetIFF() ~= var_3_4 and iter_3_1:IsVisitable() then
			var_3_2[var_3_5] = iter_3_1
			var_3_5 = var_3_5 + 1
		end
	end

	return var_3_2
end

function var_0_1.Spawn(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_1.super.Spawn(arg_4_0, arg_4_1, arg_4_2)

	var_3.SetDirectHitUnit(var_4_0, arg_4_2)

	return var_3
end

function var_0_1.TriggerBuffWhenSpawn(arg_5_0, arg_5_1)
	local var_5_0 = {
		_bullet = arg_5_1,
		bulletTag = arg_5_1:GetExtraTag()
	}
	local var_5_1 = arg_5_0._host

	var_3.TriggerBuff(var_5_1, var_0.Battle.BattleConst.BuffEffectType.ON_BULLET_CREATE, var_5_0)

	local var_5_2 = arg_5_0._host

	var_3.TriggerBuff(var_5_2, var_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_BULLET_CREATE, var_5_0)

	return
end

return
