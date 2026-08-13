ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleDirectHitWeaponUnit = var_0_10002("BattleDirectHitWeaponUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleDirectHitWeaponUnit.__name = "BattleDirectHitWeaponUnit"

local var_0_2 = var_0.Battle.BattleDirectHitWeaponUnit

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Spawn(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_2.super.Spawn(arg_2_0, arg_2_1, arg_2_2)

	var_3.SetDirectHitUnit(var_2_0, arg_2_2)

	return var_3
end

return
