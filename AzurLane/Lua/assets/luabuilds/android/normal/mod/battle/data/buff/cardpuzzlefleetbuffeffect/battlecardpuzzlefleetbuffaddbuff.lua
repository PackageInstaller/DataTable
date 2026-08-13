ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleCardPuzzleFleetBuffAddBuff", var_0.Battle.BattleFleetBuffEffect)

var_0.Battle.BattleCardPuzzleFleetBuffAddBuff = var_0_1
var_0_1.__name = "BattleCardPuzzleFleetBuffAddBuff"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	Clone = var_1_10002
	arg_1_0._tempData = var_1_10002(arg_1_1)

	arg_1_0:SetActive()

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetArgs(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._buffID = arg_2_0._tempData.arg_list.buff_id
	arg_2_0._targetFilter = arg_2_0._tempData.arg_list.target
	arg_2_0._targetParam = arg_2_0._tempData.arg_list.target_param

	local var_2_0

	if not arg_2_0._tempData.arg_list.caster then
		TeamType = var_2_0
		var_2_0 = var_2_0.TeamPos.LEADER
	end

	arg_2_0._caster = var_0.Battle.BattleTargetChoise.TargetFleetIndex(nil, {
		fleetPos = var_2_0
	})[1]

	return
end

function var_0_1.onTrigger(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = arg_3_0._targetParam

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(arg_3_0._targetFilter) do
		var_3_0 = var_0.Battle.BattleTargetChoise[iter_3_1](arg_3_0._caster, var_3_1, var_3_0)
	end

	ipairs = var_3

	for iter_3_2, iter_3_3 in var_3(var_3_0) do
		local var_3_2 = var_0.Battle.BattleBuffUnit.New(arg_3_0._buffID)

		iter_3_3:AddBuff(var_3_2)
	end

	return
end

return
