ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig.TorpedoCFG

class = var_0_10002

local var_0_2 = var_0_10002("BattleTorpedoWeaponVO", var_0.Battle.BattlePlayerWeaponVO)

var_0.Battle.BattleTorpedoWeaponVO = var_0_2
var_0_2.__name = "BattleTorpedoWeaponVO"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0, var_0_1.GCD)

	return
end

function var_0_2.AppendWeapon(arg_2_0, arg_2_1)
	var_0_2.super.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetPlayerTorpedoWeaponVO(arg_2_0)

	return
end

function var_0_2.GetCurrentWeaponIconIndex(arg_3_0)
	return 2
end

return
