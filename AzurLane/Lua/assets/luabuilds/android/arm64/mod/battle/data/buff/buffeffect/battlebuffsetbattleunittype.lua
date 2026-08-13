ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffSetBattleUnitType = var_0_10002("BattleBuffSetBattleUnitType", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffSetBattleUnitType.__name = "BattleBuffSetBattleUnitType"

local var_0_2 = var_0.Battle.BattleBuffSetBattleUnitType
local var_0_3 = var_0.Battle.BattleAttr

var_0_2.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TTPE_MOD_BATTLE_UNIT_TYPE
var_0_2.ATTR_KEY = "battle_unit_type"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0_2.FX_TYPE
end

function var_0_2.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._value = arg_3_0._tempData.arg_list.value

	return
end

function var_0_2.onAttach(arg_4_0, arg_4_1, arg_4_2)
	var_0_3.SetCurrent(arg_4_1, var_0_2.ATTR_KEY, arg_4_0._value)
	arg_4_0.flash(arg_4_1)

	return
end

function var_0_2.onRemove(arg_5_0, arg_5_1, arg_5_2)
	var_0_3.SetCurrent(arg_5_1, var_0_2.ATTR_KEY, nil)
	arg_5_0.flash(arg_5_1)

	return
end

function var_0_2.flash(arg_6_0)
	arg_6_0:UpdateBlindInvisibleBySpectre()

	local var_6_0 = var_0.Battle.BattleDataProxy.GetInstance()

	var_1.SwitchSpectreUnit(var_6_0, arg_6_0)

	return
end

return
