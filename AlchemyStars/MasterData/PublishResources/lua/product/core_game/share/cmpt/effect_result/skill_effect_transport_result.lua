require("skill_effect_result_base")
_class("SkillEffectTransportResult", SkillEffectResultBase)
SkillEffectTransportResult = SkillEffectTransportResult

function SkillEffectTransportResult:Constructor()
  self._convertColors = {}
  self._transportPieces = {}
  self._transportEntities = {}
  self._transportPrisms = {}
  self._trapSkillResults = {}
  self._isLoop = true
end

function SkillEffectTransportResult:GetEffectType()
  return SkillEffectType.Transport
end

function SkillEffectTransportResult:AddTransportPiece(oldPos, newPos)
  table.insert(self._transportPieces, {oldPos, newPos})
end

function SkillEffectTransportResult:GetTransportPieceResult()
  return self._transportPieces
end

function SkillEffectTransportResult:AddConvertColor(pos, oldColor, newColor)
  table.insert(self._convertColors, {
    pos,
    oldColor,
    newColor
  })
end

function SkillEffectTransportResult:GetConvertColors()
  return self._convertColors
end

function SkillEffectTransportResult:AddTransportEntity(eid, oldPos, newPos)
  table.insert(self._transportEntities, {
    eid,
    oldPos,
    newPos
  })
end

function SkillEffectTransportResult:GetTransportEntities()
  return self._transportEntities
end

function SkillEffectTransportResult:AddTrapSkillResult(eid, skillResult, triggerEid)
  table.insert(self._trapSkillResults, {
    eid,
    skillResult,
    triggerEid
  })
end

function SkillEffectTransportResult:GetTrapSkillResults()
  return self._trapSkillResults
end

function SkillEffectTransportResult:AddTransportPrism(oldPos, newPos, prismEntityID, pieceEffectType)
  table.insert(self._transportPrisms, {
    oldPos,
    newPos,
    prismEntityID,
    pieceEffectType
  })
end

function SkillEffectTransportResult:GetTransportPrisms()
  return self._transportPrisms
end

function SkillEffectTransportResult:SetIsLoop(isLoop)
  self._isLoop = isLoop
end

function SkillEffectTransportResult:IsLoop()
  return self._isLoop
end
