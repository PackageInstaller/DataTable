require("skill_effect_param_base")
_class("SkillLeaveEnterBattleFieldEffectParam", SkillEffectParamBase)
SkillLeaveEnterBattleFieldEffectParam = SkillLeaveEnterBattleFieldEffectParam

function SkillLeaveEnterBattleFieldEffectParam:Constructor(t)
  self._leave = t.leave
  if t.pos then
    self._pos = Vector2(t.pos[1], t.pos[2])
  end
  if t.dir then
    self._dir = Vector2(t.dir[1], t.dir[2])
  end
end

function SkillLeaveEnterBattleFieldEffectParam:GetEffectType()
  return SkillEffectType.LeaveEnterBattleField
end

function SkillLeaveEnterBattleFieldEffectParam:IsLeave()
  return self._leave
end

function SkillLeaveEnterBattleFieldEffectParam:EnterPos()
  return self._pos
end

function SkillLeaveEnterBattleFieldEffectParam:EnterDir()
  return self._dir
end
