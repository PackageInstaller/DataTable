require("skill_effect_result_base")
_class("SkillEffectResultRobotBomb", SkillEffectResultBase)
SkillEffectResultRobotBomb = SkillEffectResultRobotBomb

function SkillEffectResultRobotBomb:Constructor()
  self.path = {}
  self.explosionRange = {}
  self.damageResult = {}
  self.pieceTypes = {}
  self.trapEntityID = nil
end

function SkillEffectResultRobotBomb:GetEffectType()
  return SkillEffectType.RobotBomb
end
