_class("SkillLeaveEnterBattleFieldResult", SkillEffectResultBase)
SkillLeaveEnterBattleFieldResult = SkillLeaveEnterBattleFieldResult

function SkillLeaveEnterBattleFieldResult:Constructor(isLeave, pos, dir)
  self._leave = isLeave
  self._pos = pos
  self._dir = dir
end

function SkillLeaveEnterBattleFieldResult:GetEffectType()
  return SkillEffectType.LeaveEnterBattleField
end

function SkillLeaveEnterBattleFieldResult:IsLeave()
  return self._leave
end

function SkillLeaveEnterBattleFieldResult:EnterPos()
  return self._pos
end

function SkillLeaveEnterBattleFieldResult:EnterDir()
  return self._dir
end
