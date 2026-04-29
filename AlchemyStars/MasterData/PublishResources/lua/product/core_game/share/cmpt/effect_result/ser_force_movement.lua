require("skill_effect_result_base")
_class("SkillEffectResult_ForceMovement_MoveResult", Object)
SkillEffectResult_ForceMovement_MoveResult = SkillEffectResult_ForceMovement_MoveResult

function SkillEffectResult_ForceMovement_MoveResult:Constructor(targetID, v2OldPos, v2NewPos, triggeredTrapIDs)
  self.targetID = targetID
  self.v2OldPos = v2OldPos
  self.v2NewPos = v2NewPos
  self.triggeredTrapIDs = triggeredTrapIDs
  self.isMoved = v2OldPos ~= v2NewPos
end

_class("SkillEffectResult_ForceMovement", SkillEffectResultBase)
SkillEffectResult_ForceMovement = SkillEffectResult_ForceMovement

function SkillEffectResult_ForceMovement:Constructor()
  self._moveResult = {}
end

function SkillEffectResult_ForceMovement:GetEffectType()
  return SkillEffectType.ForceMovement
end

function SkillEffectResult_ForceMovement:AppendMoveResult(targetID, v2OldPos, v2NewPos, triggeredTrapIDs)
  table.insert(self._moveResult, SkillEffectResult_ForceMovement_MoveResult:New(targetID, v2OldPos, v2NewPos, triggeredTrapIDs))
end

function SkillEffectResult_ForceMovement:GetMoveResult()
  return self._moveResult
end
