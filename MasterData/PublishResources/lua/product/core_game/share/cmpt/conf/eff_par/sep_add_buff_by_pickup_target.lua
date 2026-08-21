require("skill_damage_effect_param")
_class("SkillEffectAddBuffByPickupTargetParam", SkillEffectParamBase)
SkillEffectAddBuffByPickupTargetParam = SkillEffectAddBuffByPickupTargetParam

function SkillEffectAddBuffByPickupTargetParam:Constructor(t)
  self._buffID = t.buffID
  self._matchPieceType = t.matchPieceType
  self._trapIDBuffTab = t.trapIDBuffTab
  self._trapIDBuffMatchPieceTypeTab = t.trapIDBuffMatchPieceTypeTab
  self._trapIDList = {}
  if self._trapIDBuffTab then
    for key, value in pairs(self._trapIDBuffTab) do
      table.insert(self._trapIDList, key)
    end
  end
end

function SkillEffectAddBuffByPickupTargetParam:GetEffectType()
  return SkillEffectType.AddBuffByPickupTarget
end

function SkillEffectAddBuffByPickupTargetParam:GetTrapIDList()
  return self._trapIDList
end

function SkillEffectAddBuffByPickupTargetParam:GetBuffID()
  return self._buffID
end

function SkillEffectAddBuffByPickupTargetParam:GetBuffIDByTrapID(trapID)
  return self._trapIDBuffTab[trapID]
end

function SkillEffectAddBuffByPickupTargetParam:GetMatchPieceTypeBuffIDByTrapID(trapID)
  return self._trapIDBuffMatchPieceTypeTab[trapID]
end

function SkillEffectAddBuffByPickupTargetParam:GetMatchPieceType()
  return self._matchPieceType
end
