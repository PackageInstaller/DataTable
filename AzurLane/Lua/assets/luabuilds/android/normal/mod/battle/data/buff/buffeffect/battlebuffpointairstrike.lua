ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffPointAirStrike = var_0_10002("BattleBuffPointAirStrike", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffPointAirStrike.__name = "BattleBuffPointAirStrike"

local var_0_2 = var_0.Battle.BattleBuffPointAirStrike

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._hiveIDList = arg_2_0._tempData.arg_list.aircraft_id_list
	arg_2_0._initCD = arg_2_0._tempData.arg_list.initial_over_heat
	arg_2_0._stackCount = arg_2_0._tempData.arg_list.stack_count
	arg_2_0._strikeWeapon = arg_2_0._tempData.arg_list.weapon_id

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:addManualWeapon(arg_3_1)

	return
end

function var_0_2.addManualWeapon(arg_4_0, arg_4_1)
	for iter_4_0 = 1, arg_4_0._stackCount do
		local var_4_0 = arg_4_1:AddPointAirStrike(arg_4_0._strikeWeapon, arg_4_0._coolDownDuration, arg_4_0._initCD)

		var_6.SetAirUnit(var_4_0, arg_4_0._hiveIDList)
	end

	return
end

return
