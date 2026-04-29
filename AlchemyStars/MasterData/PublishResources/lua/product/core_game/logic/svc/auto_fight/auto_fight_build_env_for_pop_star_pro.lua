require("auto_fight_service")

function AutoFightService:_BuildPopStarProPickUpEnv(teamEntity)
  self._envPickUp = {}
  local env = self._envPickUp
  env.TeamEntity = teamEntity
  env.PlayerPos = teamEntity:GridLocation().Position
  env.Index2Pos = self:_CalcPosIndex()
  env.BoardPosPieces = self:_CalcBoardPosPieceType()
  env.BoardPosCanPick = self:_CalcBoardPosCanPickUp()
  env.PieceTypeOutPets = self:_CalcPieceOutPets()
  env.MVP = nil
  env.MonsterAttackPos = {}
  self:_CalcMonsterAttackRange()
end

function AutoFightService:_CalcPieceOutPets()
  local t = {}
  t[PieceType.Blue] = self:_CalcOutEntities(PieceType.Blue)
  t[PieceType.Red] = self:_CalcOutEntities(PieceType.Red)
  t[PieceType.Green] = self:_CalcOutEntities(PieceType.Green)
  t[PieceType.Yellow] = self:_CalcOutEntities(PieceType.Yellow)
  t[PieceType.Any] = self:_CalcOutEntities(PieceType.Any)
  t[PieceType.None] = self:_CalcOutEntities(PieceType.None)
  return t
end

function AutoFightService:_CalcOutEntities(pieceType)
  local utilDataSvc = self:GetService("UtilData")
  local teamEntity = self._env.TeamEntity
  local leaderId = teamEntity:Team():GetTeamLeaderEntityID()
  local outPetEntities = {}
  for _, e in ipairs(teamEntity:Team():GetTeamPetEntities()) do
    local elementCmpt = e:Element()
    local primaryType = elementCmpt:GetPrimaryType()
    local fettersType = utilDataSvc:GetFettersPrimaryType(e)
    local sencondardType = elementCmpt:GetSecondaryType()
    local isLeader = e:GetID() == leaderId
    local primaryMatch = CanMatchPieceType(primaryType, pieceType)
    local fettersMatch = CanMatchPieceType(fettersType, pieceType)
    local secondaryMatch = CanMatchPieceType(sencondardType, pieceType)
    if isLeader or primaryMatch or secondaryMatch or fettersMatch then
      outPetEntities[#outPetEntities + 1] = {
        petEntity = e,
        priMatch = isLeader or primaryMatch or fettersMatch,
        secMatch = secondaryMatch
      }
    end
  end
  return outPetEntities
end

function AutoFightService:_CalcBoardPosCanPickUp()
  local posCanPickUp = {}
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  for x = 1, boardMaxX do
    for y = 1, boardMaxY do
      local posIdx = x * 100 + y
      local pos = self._env.Index2Pos[posIdx]
      if self:IsPosCanPickUp(pos) then
        posCanPickUp[posIdx] = true
      end
    end
  end
  return posCanPickUp
end

function AutoFightService:IsPosCanPickUp(pos)
  local utilDataSvc = self:GetService("UtilData")
  if utilDataSvc:IsPosBlock(pos, BlockFlag.LinkLine) then
    return false
  end
  local listTrap = utilDataSvc:GetTrapsAtPos(pos)
  for _, trapEntity in ipairs(listTrap) do
    local trapRCmp = trapEntity:TrapRender()
    if #trapRCmp:GetActiveSkillID() > 0 then
      return false
    end
  end
  return true
end

function AutoFightService:_CalcMonsterAttackRange()
  local utilDataSvc = self:GetService("UtilData")
  local configSvc = self:GetService("Config")
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local monsterSkillID = utilDataSvc:GetAIPreviewSkillID(monsterEntity)
    if monsterSkillID and 0 < monsterSkillID then
      goto lbl_27
      goto lbl_80
      ::lbl_27::
      local skillConfigData = configSvc:GetSkillConfigData(monsterSkillID, monsterEntity)
      local skillPreviewParam = skillConfigData:GetSkillPreviewParam()
      local dirCount = 0
      local previewUserCenter, lessMobility, calcMobiUseBlock
      if skillPreviewParam and skillPreviewParam ~= 0 then
        dirCount = skillPreviewParam.Direction
        previewUserCenter = skillPreviewParam.PreviewUserCenter
        lessMobility = skillPreviewParam.LessMobility
        calcMobiUseBlock = skillPreviewParam.CalcMobiUseBlock
      end
      local listWalkRange = self:_CalcMoveRange(monsterEntity, lessMobility)
      local attackRange = self:_CalcAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
      for _, pos in ipairs(attackRange) do
        local posIndex = self:_Pos2Index(pos)
        if self._envPickUp.MonsterAttackPos[posIndex] then
          self._envPickUp.MonsterAttackPos[posIndex] = self._envPickUp.MonsterAttackPos[posIndex] + 1
        else
          self._envPickUp.MonsterAttackPos[posIndex] = 1
        end
      end
    end
    ::lbl_80::
  end
end

function AutoFightService:_GetMoveRange(monsterEntity, bBase, bFilterInvalid, lessMobility)
  local monsterBasePos = monsterEntity:GridLocation().Position
  local bodyAreaCmpt = monsterEntity:BodyArea()
  local monsterBodyArea = bodyAreaCmpt:GetArea()
  local nBodyAreaCount = 0
  if bBase then
    nBodyAreaCount = 1
  else
    nBodyAreaCount = #monsterBodyArea
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local configsvc = self._world:GetService("Config")
  local monsterMobility = utilDataSvc:GetAIMobilityConfig(monsterEntity)
  local monsterID = monsterEntity:MonsterID():GetMonsterID()
  local monsterConfigData = configsvc:GetMonsterConfigData()
  local canMove = monsterConfigData:CanMove(monsterID)
  local listWalkRange
  if lessMobility then
    monsterMobility = monsterMobility - lessMobility
  end
  if canMove then
    if 0 < monsterMobility then
      local cbFilter = Callback:New(1, utilDataSvc.IsPosAccessibleMonsterMove, utilDataSvc)
      local monsterBlockData = monsterEntity:MonsterID():GetMonsterBlockData()
      listWalkRange = ComputeScopeRange.ComputeRange_PreviewWithStepAndBlock(monsterBasePos, monsterBodyArea, bBase, monsterMobility, monsterBlockData, cbFilter)
    else
      return {monsterBasePos}
    end
  else
    listWalkRange = ComputeScopeRange.ComputeBodyArea(monsterBasePos, nBodyAreaCount, 0)
  end
  local listReturn = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for key, value in pairs(listWalkRange) do
    local posWalk = value:GetPos()
    local isBlocked = false
    if bFilterInvalid then
      isBlocked = utilDataSvc:IsPosBlock(posWalk, monsterEntity:MonsterID():GetMonsterBlockData())
      if isBlocked then
        local posPlayer = self._world:Player():GetPreviewTeamEntity():GetGridPosition()
        if posPlayer == posWalk or utilDataSvc:GetMonsterAtPos(posWalk) then
          isBlocked = false
        end
      end
      if isBlocked and bBase and table.icontains(monsterBodyArea, posWalk - monsterBasePos) then
        isBlocked = false
      end
    else
      isBlocked = utilDataSvc:IsValidPiecePos(posWalk)
    end
    if false == isBlocked then
      listReturn[#listReturn + 1] = posWalk
    end
  end
  return listReturn
end

function AutoFightService:_CalcMoveRange(monsterEntity, lessMobility)
  return self:_GetMoveRange(monsterEntity, false, true, lessMobility)
end

function AutoFightService:_GetAttackRange(skillConfigData, movePos, monsterEntity, dir)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillAttackRange = {}
  local rangResult
  local utilDataSvc = self._world:GetService("UtilData")
  rangResult = utilDataSvc:GetAISkillScopeResult(monsterEntity)
  if not rangResult then
    local isRandomScope = false
    if skillConfigData then
      local scopeType = skillConfigData:GetSkillScopeType()
      if IsRandomSkillScopeType(scopeType) then
        isRandomScope = true
      end
    end
    if not isRandomScope then
      rangResult = utilScopeSvc:CalcSkillScope(skillConfigData, movePos, monsterEntity, dir)
    end
  end
  if rangResult then
    skillAttackRange = self:_FilerSkillRange(rangResult:GetWholeGridRange())
  end
  return skillAttackRange
end

function AutoFightService:_FilerSkillRange(skillRange)
  local skillAttackRange = {}
  local utilDataSvc = self._world:GetService("UtilData")
  for _, gridPos in ipairs(skillRange) do
    if utilDataSvc:IsValidPiecePos(gridPos) and not utilDataSvc:IsPosBlock(gridPos, BlockFlag.Skill | BlockFlag.SkillSkip) then
      skillAttackRange[#skillAttackRange + 1] = gridPos
    end
  end
  return skillAttackRange
end

function AutoFightService:_CalcAttackRange(monsterEntity, skillConfigData, listWalkRange, dirCount, previewUserCenter, lessMobility)
  local monsterBasePos = monsterEntity:GridLocation().Position
  local textPos
  if previewUserCenter then
    for _, v in ipairs(previewUserCenter) do
      if v.x ~= monsterBasePos.x and v.y ~= monsterBasePos.y then
        monsterBasePos = Vector2(v.x, v.y)
        textPos = monsterBasePos
        break
      end
    end
  end
  local nSkillScopeType = skillConfigData:GetSkillScopeType()
  local bOnlyBaseMoveRange = true
  if SkillScopeType.NRowsMColumns == nSkillScopeType then
    bOnlyBaseMoveRange = false
  end
  local monsterBaseMoveRange
  if nil == listWalkRange then
    monsterBaseMoveRange = self:_GetMoveRange(monsterEntity, bOnlyBaseMoveRange, true, lessMobility)
  else
    local bodyArea = monsterEntity:BodyArea():GetArea()
    if bOnlyBaseMoveRange and table.count(bodyArea) > 1 and SkillPreviewType.ScopeWithCasterPos ~= skillConfigData:GetSkillPreviewType() and SkillPreviewType.ScopeWithCasterPosAndTips ~= skillConfigData:GetSkillPreviewType() and SkillPreviewType.ScopeAndTipsAndArrowWithMoveParam ~= skillConfigData:GetSkillPreviewType() then
      monsterBaseMoveRange = self:_GetMoveRange(monsterEntity, bOnlyBaseMoveRange, true, lessMobility)
    else
      monsterBaseMoveRange = listWalkRange
    end
  end
  if false == table.icontains(monsterBaseMoveRange, monsterBasePos) then
    monsterBaseMoveRange[#monsterBaseMoveRange + 1] = monsterBasePos
  end
  local casterDirList = {}
  if dirCount == 4 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0)
    }
  elseif dirCount == 8 then
    casterDirList = {
      Vector2(0, 1),
      Vector2(0, -1),
      Vector2(1, 0),
      Vector2(-1, 0),
      Vector2(1, 1),
      Vector2(1, -1),
      Vector2(-1, 1),
      Vector2(-1, -1)
    }
  else
    casterDirList = {}
  end
  local skillAttackRange = {}
  for _, movePos in pairs(monsterBaseMoveRange) do
    if 0 < #casterDirList then
      for k, dir in pairs(casterDirList) do
        local range = self:_GetAttackRange(skillConfigData, movePos, monsterEntity, dir)
        for _, gridPos in pairs(range) do
          local alreadyInRange = table.icontains(skillAttackRange, gridPos)
          if not alreadyInRange then
            skillAttackRange[#skillAttackRange + 1] = gridPos
          end
        end
      end
    else
      local range = self:_GetAttackRange(skillConfigData, movePos, monsterEntity)
      for _, gridPos in pairs(range) do
        local alreadyInRange = table.icontains(skillAttackRange, gridPos)
        if not alreadyInRange then
          skillAttackRange[#skillAttackRange + 1] = gridPos
        end
      end
    end
  end
  return skillAttackRange
end
