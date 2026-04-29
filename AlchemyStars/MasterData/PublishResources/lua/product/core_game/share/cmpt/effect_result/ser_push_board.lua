require("skill_effect_result_base")
_class("SkillEffectPushBoardResult", SkillEffectResultBase)
SkillEffectPushBoardResult = SkillEffectPushBoardResult

function SkillEffectPushBoardResult:Constructor()
  self._convertInfoList = {}
  self._moveBoardPieces = {}
  self._removeBoardPieces = {}
  self._newBoardPieces = {}
  self._moveBoardPrisms = {}
  self._trapSkillResults = {}
  self._trapDestroyList = {}
  self._logicMoveEntities = {}
  self._renderMoveEntities = {}
end

function SkillEffectPushBoardResult:GetEffectType()
  return SkillEffectType.PushBoard
end

function SkillEffectPushBoardResult:AddMoveBoardPiece(oldPos, newPos)
  table.insert(self._moveBoardPieces, {oldPos, newPos})
end

function SkillEffectPushBoardResult:GetMoveBoardPiece()
  return self._moveBoardPieces
end

function SkillEffectPushBoardResult:AddRemoveBoardPiece(pos)
  table.insert(self._removeBoardPieces, pos)
end

function SkillEffectPushBoardResult:GetRemoveBoardPiece()
  return self._removeBoardPieces
end

function SkillEffectPushBoardResult:AddNewBoardPiece(pos, pieceType, fakeGridPos)
  table.insert(self._newBoardPieces, {
    pos,
    pieceType,
    fakeGridPos
  })
end

function SkillEffectPushBoardResult:GetNewBoardPiece()
  return self._newBoardPieces
end

function SkillEffectPushBoardResult:AddConvertInfo(pos, newColor)
  table.insert(self._convertInfoList, {pos, newColor})
end

function SkillEffectPushBoardResult:GetConvertInfo()
  return self._convertInfoList
end

function SkillEffectPushBoardResult:AddTrapSkillResult(entityID, skillResult, triggerEntityID)
  table.insert(self._trapSkillResults, {
    entityID,
    skillResult,
    triggerEntityID
  })
end

function SkillEffectPushBoardResult:GetTrapSkillResults()
  return self._trapSkillResults
end

function SkillEffectPushBoardResult:AddTrapDestroyList(entityID)
  table.insert(self._trapDestroyList, entityID)
end

function SkillEffectPushBoardResult:GetTrapDestroyList()
  return self._trapDestroyList
end

function SkillEffectPushBoardResult:AddMoveBoardPrism(oldPos, newPos, prismEntityID, pieceEffectType)
  table.insert(self._moveBoardPrisms, {
    oldPos,
    newPos,
    prismEntityID,
    pieceEffectType
  })
end

function SkillEffectPushBoardResult:GetMoveBoardPrisms()
  return self._moveBoardPrisms
end

function SkillEffectPushBoardResult:AddLogicMoveEntity(entityID)
  table.insert(self._logicMoveEntities, entityID)
end

function SkillEffectPushBoardResult:GetLogicMoveEntity()
  return self._logicMoveEntities
end

function SkillEffectPushBoardResult:AddRenderMoveEntity(entityID, gridPos)
  table.insert(self._renderMoveEntities, {entityID, gridPos})
end

function SkillEffectPushBoardResult:GetRenderMoveEntity()
  return self._renderMoveEntities
end
