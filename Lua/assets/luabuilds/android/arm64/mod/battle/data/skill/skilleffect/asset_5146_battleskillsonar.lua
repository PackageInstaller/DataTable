ys = ys or {}

local BattleSkillSonar = class("BattleSkillSonar", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillSonar = BattleSkillSonar
BattleSkillSonar.__name = "BattleSkillSonar"

function BattleSkillSonar:Ctor(arg_1_1)
	BattleSkillSonar.super.Ctor(self, arg_1_1, lv)

	self._range = self._tempData.arg_list.range
	self._duration = self._tempData.arg_list.duration

	return
end

function BattleSkillSonar:DoDataEffect(arg_2_1)
	arg_2_1:GetFleetVO():AppendIndieSonar(self._range, self._duration)

	return
end

function BattleSkillSonar:DataEffectWithoutTarget(arg_3_1)
	arg_3_1:GetFleetVO():AppendIndieSonar(self._range, self._duration)

	return
end

return
