ys = ys or {}
ys.Battle.BattleDirectHitWeaponUnit = class("BattleDirectHitWeaponUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleDirectHitWeaponUnit.__name = "BattleDirectHitWeaponUnit"

local var_0_0 = ys.Battle.BattleDirectHitWeaponUnit

function ys.Battle.BattleDirectHitWeaponUnit.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleDirectHitWeaponUnit.Spawn(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.super.Spawn(arg_2_0, arg_2_1, arg_2_2)

	var_2_0:SetDirectHitUnit(arg_2_2)

	return var_2_0
end

return
