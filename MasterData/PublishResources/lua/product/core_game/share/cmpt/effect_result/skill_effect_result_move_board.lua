require("skill_effect_result_base")
_class("SkillEffectResultMoveBoard", SkillEffectResultBase)
SkillEffectResultMoveBoard = SkillEffectResultMoveBoard

function SkillEffectResultMoveBoard:Constructor(trapID, summonPosList)
  self._convertColors = {}
  self._MoveBoardPieces = {}
  self._MoveBoardEntities = {}
  self._MoveBoardPrisms = {}
  self._trapSkillResults = {}
  self._trapDestroyList = {}
  self._moveBoardPiecesCutIn = {}
end

function SkillEffectResultMoveBoard:GetEffectType()
  return SkillEffectType.MoveBoard
end

function SkillEffectResultMoveBoard:AddMoveBoardPiece(oldPos, newPos)
  table.insert(self._MoveBoardPieces, {oldPos, newPos})
end

function SkillEffectResultMoveBoard:GetMoveBoardPieceResult()
  return self._MoveBoardPieces
end

function SkillEffectResultMoveBoard:AddConvertColor(pos, oldColor, newColor)
  table.insert(self._convertColors, {
    pos,
    oldColor,
    newColor
  })
end

function SkillEffectResultMoveBoard:GetConvertColors()
  return self._convertColors
end

function SkillEffectResultMoveBoard:AddMoveBoardEntity(eid, oldPos, newPos)
  table.insert(self._MoveBoardEntities, {
    eid,
    oldPos,
    newPos
  })
end

function SkillEffectResultMoveBoard:GetMoveBoardEntities()
  return self._MoveBoardEntities
end

function SkillEffectResultMoveBoard:AddTrapSkillResult(eid, skillResult, triggerEid)
  table.insert(self._trapSkillResults, {
    eid,
    skillResult,
    triggerEid
  })
end

function SkillEffectResultMoveBoard:GetTrapSkillResults()
  return self._trapSkillResults
end

function SkillEffectResultMoveBoard:AddTrapDestroyList(entityID)
  table.insert(self._trapDestroyList, entityID)
end

function SkillEffectResultMoveBoard:GetTrapDestroyList()
  return self._trapDestroyList
end

function SkillEffectResultMoveBoard:AddMoveBoardPrism(oldPos, newPos, prismEntityID, pieceEffectType)
  table.insert(self._MoveBoardPrisms, {
    oldPos,
    newPos,
    prismEntityID,
    pieceEffectType
  })
end

function SkillEffectResultMoveBoard:GetMoveBoardPrisms()
  return self._MoveBoardPrisms
end

function SkillEffectResultMoveBoard:AddMoveBoardPieceCutIn(oldPos, newPos, pieceType)
  table.insert(self._moveBoardPiecesCutIn, {
    oldPos,
    newPos,
    pieceType
  })
end

function SkillEffectResultMoveBoard:GetMoveBoardPieceResultCutIn()
  return self._moveBoardPiecesCutIn
end
