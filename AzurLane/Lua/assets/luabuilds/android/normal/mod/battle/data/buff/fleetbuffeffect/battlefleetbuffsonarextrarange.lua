ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleFleetBuffSonarExtraRange = var_0_10002("BattleFleetBuffSonarExtraRange", var_0.Battle.BattleFleetBuffEffect)
var_0.Battle.BattleFleetBuffSonarExtraRange.__name = "BattleFleetBuffSonarExtraRange"

local var_0_2 = var_0.Battle.BattleFleetBuffSonarExtraRange

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._extraRange = arg_2_0._tempData.arg_list.range

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:appendRange(arg_3_1)

	return
end

function var_0_2.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:appendRange(arg_4_1)

	return
end

function var_0_2.appendRange(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetFleetSonar()

	var_2.AppendExtraSkillRange(var_5_0, arg_5_0._extraRange)

	return
end

return
