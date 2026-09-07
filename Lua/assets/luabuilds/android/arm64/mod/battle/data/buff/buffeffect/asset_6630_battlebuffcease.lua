ys = ys or {}

local BattleBuffCease = class("BattleBuffCease", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCease = BattleBuffCease
BattleBuffCease.__name = "BattleBuffCease"

function BattleBuffCease:Ctor(arg_1_1)
	BattleBuffCease.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffCease:onAttach(arg_2_1, arg_2_2)
	arg_2_1:CeaseAllWeapon(true)

	return
end

function BattleBuffCease:onRemove(arg_3_1, arg_3_2)
	arg_3_1:CeaseAllWeapon(false)

	return
end

return
