require("skill_effect_param_base")
_class("SkillEffectParamRobotBomb", SkillDamageEffectParam)
SkillEffectParamRobotBomb = SkillEffectParamRobotBomb

function SkillEffectParamRobotBomb:Constructor(t)
  self._robotBombParam = RobotBombParam:New(t.robot[1])
end

function SkillEffectParamRobotBomb:GetEffectType()
  return SkillEffectType.RobotBomb
end

function SkillEffectParamRobotBomb:GetRobotBombParam()
  return self._robotBombParam
end

_class("RobotBombParam", Object)
RobotBombParam = RobotBombParam

function RobotBombParam:Constructor(info)
  self.scopeType = info.scopeType
  self.scopeParam = info.scopeParam
  self.recordCount = info.recordCount or 0
  self.trapID = info.trapID
end
