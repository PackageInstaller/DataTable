ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleBuffAddFleetBuff", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAddFleetBuff = var_0_2
var_0_2.__name = "BattleBuffAddFleetBuff"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()
	arg_2_0._fleetBuffID = arg_2_0._tempData.arg_list.fleet_buff_id

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
		return
	end

	local var_3_0 = var_0.Battle.BattleFleetBuffUnit.New(arg_3_0._fleetBuffID)
	local var_3_1 = arg_3_1:GetFleetVO()

	var_4.AttachFleetBuff(var_3_1, var_3_0)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
		return
	end

	local var_4_0 = arg_4_1:GetFleetVO()

	var_3.RemoveFleetBuff(var_4_0, arg_4_0._fleetBuffID)

	return
end

return
