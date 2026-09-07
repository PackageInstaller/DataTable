ys = ys or {}

local BattleSkillPhaseJump = class("BattleSkillPhaseJump", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillPhaseJump = BattleSkillPhaseJump
BattleSkillPhaseJump.__name = "BattleSkillPhaseJump"

function BattleSkillPhaseJump:Ctor(arg_1_1)
	BattleSkillPhaseJump.super.Ctor(self, arg_1_1, lv)

	self._phaseIndex = self._tempData.arg_list.index or 0

	return
end

function BattleSkillPhaseJump:DoDataEffect(arg_2_1)
	self:doJump(arg_2_1)

	return
end

function BattleSkillPhaseJump:DoDataEffectWithoutTarget(arg_3_1)
	self:doJump(arg_3_1)

	return
end

function BattleSkillPhaseJump:doJump(arg_4_1)
	local var_4_0 = arg_4_1:GetPhaseSwitcher()

	if var_4_0 then
		var_4_0:ForceSwitch(self._phaseIndex)
	end

	return
end

return
