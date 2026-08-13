ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleFleetBuffJam = var_0_10002("BattleFleetBuffJam", var_0.Battle.BattleFleetBuffEffect)
var_0.Battle.BattleFleetBuffJam.__name = "BattleFleetBuffJam"

local var_0_2 = var_0.Battle.BattleFleetBuffJam

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.onAttach(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_3.JamManualCast(var_2_0, true)
	arg_2_1:Jamming(true)
	arg_2_1:SetWeaponBlock(1)

	return
end

function var_0_2.onRemove(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_3.JamManualCast(var_3_0, false)
	arg_3_1:Jamming(false)
	arg_3_1:SetWeaponBlock(-1)

	return
end

return
