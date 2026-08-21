ys = ys or {}
ys.Battle.BattleFleetBuffSonarExtraRange = class("BattleFleetBuffSonarExtraRange", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffSonarExtraRange.__name = "BattleFleetBuffSonarExtraRange"

local var_0_0 = ys.Battle.BattleFleetBuffSonarExtraRange

function ys.Battle.BattleFleetBuffSonarExtraRange.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._extraRange = arg_2_0._tempData.arg_list.range

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:appendRange(arg_3_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange.onStack(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:appendRange(arg_4_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange.appendRange(arg_5_0, arg_5_1)
	arg_5_1:GetFleetSonar():AppendExtraSkillRange(arg_5_0._extraRange)

	return
end

return
