_class("SkillEffectResult_ScorpionSummon", SkillEffectResultBase)
SkillEffectResult_ScorpionSummon = SkillEffectResult_ScorpionSummon

function SkillEffectResult_ScorpionSummon:Constructor(nSummonType, summonID, positions)
  self._summonType = nSummonType
  self._summonID = summonID
  self._positions = positions
  self._direction = Vector2(0, 1)
  self._groupID = 0
  self._monsters = {}
end

function SkillEffectResult_ScorpionSummon:GetEffectType()
  return SkillEffectType.ScorpionSummon
end

function SkillEffectResult_ScorpionSummon:GetSummonType()
  return self._summonType
end

function SkillEffectResult_ScorpionSummon:GetSummonID()
  return self._summonID
end

function SkillEffectResult_ScorpionSummon:GetSummonPositions()
  return self._positions
end

function SkillEffectResult_ScorpionSummon:SetGroupID(groupID)
  self._groupID = groupID
end

function SkillEffectResult_ScorpionSummon:GetGroupID()
  return self._groupID
end

function SkillEffectResult_ScorpionSummon:AddSummonResult(monster)
  table.insert(self._monsters, monster)
end

function SkillEffectResult_ScorpionSummon:GetSummonResult()
  return self._monsters
end
