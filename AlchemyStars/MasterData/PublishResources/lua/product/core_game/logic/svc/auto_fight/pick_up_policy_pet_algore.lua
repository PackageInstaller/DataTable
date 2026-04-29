require("pick_up_policy_base")
_class("PickUpPolicy_PetAlGore", PickUpPolicy_Base)
PickUpPolicy_PetAlGore = PickUpPolicy_PetAlGore

function PickUpPolicy_PetAlGore:CalcAutoFightPickUpPolicy(calcParam)
  local petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local secondFirstPosRed = false
  if calcParam.policyParam and calcParam.policyParam.secondFirstPosRed then
    secondFirstPosRed = true
  end
  local casterPos = petEntity:GridLocation().Position
  local pickPosList, atkPosList, targetIds = self:_CalPickPosPolicyPetAlGore(petEntity, casterPos, secondFirstPosRed, activeSkillID)
  return pickPosList, atkPosList, targetIds
end

function PickUpPolicy_PetAlGore:_CalPickPosPolicyPetAlGore(petEntity, casterPos, secondFirstPosRed, activeSkillID)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local env = self:_GetPickUpPolicyEnv()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local boardService = self._world:GetService("BoardLogic")
  local spPieceType = PieceType.Red
  local firstPos
  local targetEntityList = {}
  local nearestEnemy
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local teamEntity = petEntity:Pet():GetOwnerTeamEntity()
    local enemyTeam = teamEntity:Team():GetEnemyTeamEntity()
    table.insert(targetEntityList, enemyTeam)
    nearestEnemy = enemyTeam
    firstPos = enemyTeam:GetGridPosition()
  else
    local utilScope = self._world:GetService("UtilScopeCalc")
    local monsterList, monsterPosList = utilScope:SelectNearestMonsterOnPos(casterPos, 1)
    if monsterList and 0 < #monsterList then
      table.insert(targetEntityList, monsterList[1])
      nearestEnemy = monsterList[1]
      local enemyPos = nearestEnemy:GetGridPosition()
      local bodyAreaCmpt = nearestEnemy:BodyArea()
      if bodyAreaCmpt then
        local length = 1000
        local enemyBodyArea = bodyAreaCmpt:GetArea()
        for index, off in ipairs(enemyBodyArea) do
          local bodyPos = enemyPos + off
          local len = Vector2.Distance(bodyPos, casterPos)
          if length > len then
            length = len
            firstPos = bodyPos
          end
        end
      end
    end
  end
  if not nearestEnemy then
    return {}, {}, {}
  end
  local retPosList = {firstPos}
  local board = self._world:GetBoardEntity():Board()
  local utilDataSvc = self._world:GetService("UtilData")
  local ringPosList = ComputeScopeRange.ComputeRange_SquareRing(firstPos, 1, 1)
  local canPickPosList = {}
  for i, pos in ipairs(ringPosList) do
    if not board:IsPrismPiece(pos) and not utilDataSvc:IsMaintainColorTrap(pos) and utilDataSvc:IsValidPiecePos(pos) then
      table.insert(canPickPosList, pos)
    end
  end
  if #canPickPosList == 0 then
    return {}, {}, {}
  end
  local firstPickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local secondPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  for i, pos in ipairs(canPickPosList) do
    local posIdx = self:_Pos2Index(pos)
    local color = env.BoardPosPieces[posIdx]
    if #retPosList == 1 then
      if secondFirstPosRed and color == spPieceType and secondPickUpNum >= #retPosList then
        table.insert(retPosList, pos)
      elseif not secondFirstPosRed and color ~= spPieceType and secondPickUpNum >= #retPosList then
        table.insert(retPosList, pos)
      end
    elseif color == spPieceType and secondPickUpNum >= #retPosList then
      table.insert(retPosList, pos)
    end
  end
  for _, pos in ipairs(canPickPosList) do
    if secondPickUpNum >= #retPosList and not table.Vector2Include(retPosList, pos) then
      table.insert(retPosList, pos)
    end
  end
  return retPosList, retPosList, {
    nearestEnemy:GetID()
  }
end
