require("skill_effect_result_base")
_class("SkillEffectResultRubikCube", SkillEffectResultBase)
SkillEffectResultRubikCube = SkillEffectResultRubikCube

function SkillEffectResultRubikCube:Constructor(trapID, summonPosList)
  self._rubikCubeEntities = {}
  self._convertColors = {}
  self._rubikCubePieces = {}
  self._rubikCubePrisms = {}
  self._trapDestroyList = {}
  self._targetAngle = Vector3(0, 0, 0)
end

function SkillEffectResultRubikCube:GetEffectType()
  return SkillEffectType.RubikCube
end

function SkillEffectResultRubikCube:GetRubikCubeTargetAngle()
  return self._targetAngle
end

function SkillEffectResultRubikCube:SetRubikCubeTargetAngle(targetAngle)
  self._targetAngle = targetAngle
end

function SkillEffectResultRubikCube:AddRubikCubeEntity(eid, oldPos, newPos, fromBoard, toBoard)
  table.insert(self._rubikCubeEntities, {
    eid,
    oldPos,
    newPos,
    fromBoard,
    toBoard
  })
end

function SkillEffectResultRubikCube:GetRubikCubeEntities()
  return self._rubikCubeEntities
end

function SkillEffectResultRubikCube:AddConvertColor(oldPos, newPos, oldPieceType, newPieceType, fromBoard, toBoard)
  table.insert(self._convertColors, {
    oldPos,
    newPos,
    oldPieceType,
    newPieceType,
    fromBoard,
    toBoard
  })
end

function SkillEffectResultRubikCube:GetConvertColors()
  return self._convertColors
end

function SkillEffectResultRubikCube:AddRubikCubePiece(oldPos, newPos, fromBoard, toBoard)
  table.insert(self._rubikCubePieces, {
    oldPos,
    newPos,
    fromBoard,
    toBoard
  })
end

function SkillEffectResultRubikCube:RubikCube()
  return self._rubikCubePieces
end

function SkillEffectResultRubikCube:AddRubikCubePrism(oldPos, newPos, fromBoard, toBoard, pieceEffectType)
  table.insert(self._rubikCubePrisms, {
    oldPos,
    newPos,
    fromBoard,
    toBoard,
    pieceEffectType
  })
end

function SkillEffectResultRubikCube:GetRubikCubePrisms()
  return self._rubikCubePrisms
end

function SkillEffectResultRubikCube:AddTrapDestroyList(entityID)
  table.insert(self._trapDestroyList, entityID)
end

function SkillEffectResultRubikCube:GetTrapDestroyList()
  return self._trapDestroyList
end

function SkillEffectResultRubikCube:SetAloneBoard(aloneBoardID)
  self._aloneBoardID = aloneBoardID
end

function SkillEffectResultRubikCube:GetAloneBoard()
  return self._aloneBoardID
end
