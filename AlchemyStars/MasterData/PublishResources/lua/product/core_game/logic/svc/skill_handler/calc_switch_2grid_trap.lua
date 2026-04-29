_class("SkillEffectCalc_Switch2GridTrap", Object)
SkillEffectCalc_Switch2GridTrap = SkillEffectCalc_Switch2GridTrap

function SkillEffectCalc_Switch2GridTrap:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_Switch2GridTrap:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam:GetSkillEffectParam()
  local scopeRange = skillEffectCalcParam:GetSkillRange()
  local sUtilData = self._world:GetService("UtilData")
  local listTrap1 = sUtilData:GetTrapsAtPos(scopeRange[1])
  local listTrap2 = sUtilData:GetTrapsAtPos(scopeRange[2])
  local boardEntity = self._world:GetBoardEntity()
  local boardCmpt = boardEntity:Board()
  local pieceEffectType1 = boardCmpt:GetBoardPieceEffectType(scopeRange[1])
  local prismEntityID1 = boardCmpt:GetPrismEntityIDAtPos(scopeRange[1])
  if pieceEffectType1 == PieceEffectType.Deep then
    boardCmpt:RemoveBoardPieceEffectType(scopeRange[1])
  end
  local pieceEffectType2 = boardCmpt:GetBoardPieceEffectType(scopeRange[2])
  local prismEntityID2 = boardCmpt:GetPrismEntityIDAtPos(scopeRange[2])
  if pieceEffectType2 == PieceEffectType.Deep then
    boardCmpt:RemoveBoardPieceEffectType(scopeRange[2])
  end
  if pieceEffectType1 == PieceEffectType.Deep then
    boardCmpt:SetBoardPieceEffectType(scopeRange[2], pieceEffectType1, prismEntityID1)
  end
  if pieceEffectType2 == PieceEffectType.Deep then
    boardCmpt:SetBoardPieceEffectType(scopeRange[1], pieceEffectType2, prismEntityID2)
  end
  local trapIDList = skillEffectParam:GetTrapID()
  local sBoard = self._world:GetService("BoardLogic")
  local data = {}
  for i = 1, #listTrap1 do
    local targetEntity = listTrap1[i]
    if table.icontains(trapIDList, targetEntity:TrapID():GetTrapID()) then
      local posNew = scopeRange[2]
      local posOld = targetEntity:GridLocation():GetGridPos()
      local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(targetEntity, posOld)
      targetEntity:SetGridPosition(posNew)
      sBoard:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
      sBoard:SetEntityBlockFlag(targetEntity, posNew, blockFlag)
      table.insert(data, {
        targetID = targetEntity:GetID(),
        posOld = posOld,
        posNew = posNew
      })
    end
  end
  for i = 1, #listTrap2 do
    local targetEntity = listTrap2[i]
    if table.icontains(trapIDList, targetEntity:TrapID():GetTrapID()) then
      local posNew = scopeRange[1]
      local posOld = targetEntity:GridLocation():GetGridPos()
      local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(targetEntity, posOld)
      targetEntity:SetGridPosition(posNew)
      sBoard:UpdateEntityBlockFlag(targetEntity, posOld, posNew)
      sBoard:SetEntityBlockFlag(targetEntity, posNew, blockFlag)
      table.insert(data, {
        targetID = targetEntity:GetID(),
        posOld = posOld,
        posNew = posNew
      })
    end
  end
  local buffResult = SkillEffectResult_Switch2GridTrap:New(data, scopeRange)
  return buffResult
end
