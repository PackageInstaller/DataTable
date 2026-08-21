ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleFleetBuffJam = class("BattleFleetBuffJam", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffJam.__name = "BattleFleetBuffJam"

local var_0_1 = ys.Battle.BattleFleetBuffJam

function ys.Battle.BattleFleetBuffJam.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffJam.onAttach(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.Battle.BattleDataProxy.GetInstance():JamManualCast(true)
	arg_2_1:Jamming(true)
	arg_2_1:SetWeaponBlock(1)

	return
end

function ys.Battle.BattleFleetBuffJam.onRemove(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.Battle.BattleDataProxy.GetInstance():JamManualCast(false)
	arg_3_1:Jamming(false)
	arg_3_1:SetWeaponBlock(-1)

	return
end

return
