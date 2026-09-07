ys = ys or {}

local var_0_0 = ys
local BattleBuffGuarded = class("BattleBuffGuarded", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffGuarded = BattleBuffGuarded
BattleBuffGuarded.__name = "BattleBuffGuarded"

function BattleBuffGuarded:Ctor(arg_1_1)
	BattleBuffGuarded.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffGuarded:SetArgs(arg_2_1, arg_2_2)
	self._casterUID = arg_2_2:GetCaster():GetUniqueID()

	return
end

function BattleBuffGuarded:onAttach(arg_3_1, arg_3_2)
	var_0_0.Battle.BattleAttr.AddGuardianID(arg_3_1, self._casterUID)

	return
end

function BattleBuffGuarded:onRemove(arg_4_1, arg_4_2)
	var_0_0.Battle.BattleAttr.RemoveGuardianID(arg_4_1, self._casterUID)

	return
end

return
