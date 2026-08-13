ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleAllInStrikeVO = var_0_10003("BattleAllInStrikeVO", var_0.Battle.BattlePlayerWeaponVO)
var_0.Battle.BattleAllInStrikeVO.__name = "BattleAllInStrikeVO"

local var_0_3 = var_0.Battle.BattleAllInStrikeVO

var_0_3.GCD = var_0_1.AirAssistCFG.GCD

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0, var_0_3.GCD)

	return
end

function var_0_3.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetAllInWeaponVO(arg_2_0)
	var_0_3.super.AppendWeapon(arg_2_0, arg_2_1)

	return
end

function var_0_3.GetCurrentWeaponIconIndex(arg_3_0)
	return 3
end

return
