ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffSetBattleUnitType = class("BattleBuffSetBattleUnitType", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffSetBattleUnitType.__name = "BattleBuffSetBattleUnitType"

local var_0_1 = ys.Battle.BattleBuffSetBattleUnitType
local var_0_2 = ys.Battle.BattleAttr

ys.Battle.BattleBuffSetBattleUnitType.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TTPE_MOD_BATTLE_UNIT_TYPE
ys.Battle.BattleBuffSetBattleUnitType.ATTR_KEY = "battle_unit_type"

function ys.Battle.BattleBuffSetBattleUnitType.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffSetBattleUnitType.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function ys.Battle.BattleBuffSetBattleUnitType:SetArgs(arg_3_1, arg_3_2)
	self._value = self._tempData.arg_list.value

	return
end

function ys.Battle.BattleBuffSetBattleUnitType:onAttach(arg_4_1, arg_4_2)
	var_0_2.SetCurrent(arg_4_1, var_0_1.ATTR_KEY, self._value)
	self.flash(arg_4_1)

	return
end

function ys.Battle.BattleBuffSetBattleUnitType:onRemove(arg_5_1, arg_5_2)
	var_0_2.SetCurrent(arg_5_1, var_0_1.ATTR_KEY, nil)
	self.flash(arg_5_1)

	return
end

function ys.Battle.BattleBuffSetBattleUnitType:flash()
	self:UpdateBlindInvisibleBySpectre()
	var_0_0.Battle.BattleDataProxy.GetInstance():SwitchSpectreUnit(self)

	return
end

return
