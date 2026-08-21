ys = ys or {}

local var_0_0 = ys.Battle.BattleConfig.TorpedoCFG
local var_0_1 = class("BattleTorpedoWeaponVO", ys.Battle.BattlePlayerWeaponVO)

ys.Battle.BattleTorpedoWeaponVO = var_0_1
var_0_1.__name = "BattleTorpedoWeaponVO"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0, var_0_0.GCD)

	return
end

function var_0_1.AppendWeapon(arg_2_0, arg_2_1)
	var_0_1.super.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetPlayerTorpedoWeaponVO(arg_2_0)

	return
end

function var_0_1.GetCurrentWeaponIconIndex(arg_3_0)
	return 2
end

return
