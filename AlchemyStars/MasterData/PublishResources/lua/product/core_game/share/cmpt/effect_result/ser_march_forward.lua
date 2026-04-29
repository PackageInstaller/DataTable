require("skill_effect_result_base")
_class("SkillEffectMarchForwardResult", SkillEffectResultBase)
SkillEffectMarchForwardResult = SkillEffectMarchForwardResult

function SkillEffectMarchForwardResult:Constructor(walkResultList, isDead, isEnd)
  self._walkResultList = walkResultList
  self._isDead = isDead
  self._isMarchEnd = isEnd
end

function SkillEffectMarchForwardResult:GetEffectType()
  return SkillEffectType.MarchForward
end

function SkillEffectMarchForwardResult:GetWalkResultList()
  return self._walkResultList
end

function SkillEffectMarchForwardResult:IsCasterDead()
  return self._isDead
end

function SkillEffectMarchForwardResult:IsMarchEnd()
  return self._isMarchEnd
end

_class("MarchForwardResult", Object)
MarchForwardResult = MarchForwardResult

function MarchForwardResult:Constructor()
  self._walkPos = nil
  self._moveEntities = {}
  self._convertInfoList = {}
  self._trapSkillResults = {}
end

function MarchForwardResult:GetWalkPos()
  return self._walkPos
end

function MarchForwardResult:SetWalkPos(pos)
  self._walkPos = pos
end

function MarchForwardResult:AddMoveEntity(eid, oldPos, newPos)
  table.insert(self._moveEntities, {
    eid,
    oldPos,
    newPos
  })
end

function MarchForwardResult:GetMoveEntities()
  return self._moveEntities
end

function MarchForwardResult:AddConvertInfo(pos, newColor)
  table.insert(self._convertInfoList, {pos, newColor})
end

function MarchForwardResult:GetConvertInfo()
  return self._convertInfoList
end

function MarchForwardResult:AddTrapSkillResult(entityID, skillResult, triggerEntityID)
  table.insert(self._trapSkillResults, {
    entityID,
    skillResult,
    triggerEntityID
  })
end

function MarchForwardResult:GetTrapSkillResults()
  return self._trapSkillResults
end
