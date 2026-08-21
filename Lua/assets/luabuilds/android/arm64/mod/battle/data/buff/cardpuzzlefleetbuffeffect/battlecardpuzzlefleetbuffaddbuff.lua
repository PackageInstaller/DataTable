ys = ys or {}

local var_0_0 = class("BattleCardPuzzleFleetBuffAddBuff", ys.Battle.BattleFleetBuffEffect)

ys.Battle.BattleCardPuzzleFleetBuffAddBuff = var_0_0
var_0_0.__name = "BattleCardPuzzleFleetBuffAddBuff"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = Clone(arg_1_1)

	arg_1_0:SetActive()

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._buffID = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._targetFilter = arg_2_0._tempData.arg_list.target
	arg_2_0._targetParam = arg_2_0._tempData.arg_list.target_param

	local var_2_0 = arg_2_0._tempData.arg_list.caster or TeamType.TeamPos.LEADER

	arg_2_0._caster = var_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = var_2_0
	})[1]

	return
end

function var_0_0.onTrigger(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._targetFilter) do
		var_3_0 = var_0.Battle.BattleTargetChoise[iter_3_1](arg_3_0._caster, arg_3_0._targetParam, var_3_0)
	end

	for iter_3_2, iter_3_3 in ipairs(var_3_0) do
		iter_3_3:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_3_0._buffID)))
	end

	return
end

return
