ys = ys or {}
ys.Battle.BattleFleetBuffSonarExtraRange = class("BattleFleetBuffSonarExtraRange", ys.Battle.BattleFleetBuffEffect)
ys.Battle.BattleFleetBuffSonarExtraRange.__name = "BattleFleetBuffSonarExtraRange"

local var_0_0 = ys.Battle.BattleFleetBuffSonarExtraRange

function ys.Battle.BattleFleetBuffSonarExtraRange.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange:SetArgs(arg_2_1, arg_2_2)
	self._extraRange = self._tempData.arg_list.range

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange:onAttach(arg_3_1, arg_3_2)
	self:appendRange(arg_3_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange:onStack(arg_4_1, arg_4_2)
	self:appendRange(arg_4_1)

	return
end

function ys.Battle.BattleFleetBuffSonarExtraRange:appendRange(arg_5_1)
	arg_5_1:GetFleetSonar():AppendExtraSkillRange(self._extraRange)

	return
end

return
