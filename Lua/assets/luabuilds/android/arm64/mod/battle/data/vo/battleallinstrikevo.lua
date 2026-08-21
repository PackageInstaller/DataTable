ys = ys or {}
ys.Battle.BattleAllInStrikeVO = class("BattleAllInStrikeVO", ys.Battle.BattlePlayerWeaponVO)
ys.Battle.BattleAllInStrikeVO.__name = "BattleAllInStrikeVO"

local var_0_0 = ys.Battle.BattleAllInStrikeVO

ys.Battle.BattleAllInStrikeVO.GCD = ys.Battle.BattleConfig.AirAssistCFG.GCD

function ys.Battle.BattleAllInStrikeVO.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0, var_0_0.GCD)

	return
end

function ys.Battle.BattleAllInStrikeVO.AppendWeapon(arg_2_0, arg_2_1)
	arg_2_1:SetAllInWeaponVO(arg_2_0)
	var_0_0.super.AppendWeapon(arg_2_0, arg_2_1)

	return
end

function ys.Battle.BattleAllInStrikeVO.GetCurrentWeaponIconIndex(arg_3_0)
	return 3
end

return
