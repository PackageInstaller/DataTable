ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = class("BattleBuffAddFleetBuff", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAddFleetBuff = var_0_1
var_0_1.__name = "BattleBuffAddFleetBuff"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._level = arg_2_2:GetLv()
	arg_2_0._fleetBuffID = arg_2_0._tempData.arg_list.fleet_buff_id

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1:GetUnitType() ~= var_0_0.UnitType.PLAYER_UNIT then
		return
	end

	arg_3_1:GetFleetVO():AttachFleetBuff((var_0.Battle.BattleFleetBuffUnit.New(arg_3_0._fleetBuffID)))

	return
end

function var_0_1.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1:GetUnitType() ~= var_0_0.UnitType.PLAYER_UNIT then
		return
	end

	arg_4_1:GetFleetVO():RemoveFleetBuff(arg_4_0._fleetBuffID)

	return
end

return
