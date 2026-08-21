ys = ys or {}
ys.Battle.BattleFleetBuffInk = class("BattleFleetBuffInk", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffInk.__name = "BattleFleetBuffInk"

local var_0_0 = ys.Battle.BattleFleetBuffInk

function ys.Battle.BattleFleetBuffInk.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffInk.onAttach(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:Blinding(true)
	arg_2_1:SetWeaponBlock(1)

	return
end

function ys.Battle.BattleFleetBuffInk.onRemove(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:Blinding(false)
	arg_3_1:SetWeaponBlock(-1)

	return
end

return
