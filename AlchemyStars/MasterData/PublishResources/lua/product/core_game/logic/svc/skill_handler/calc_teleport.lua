_class("SkillEffectCalc_Teleport", Object)
SkillEffectCalc_Teleport = SkillEffectCalc_Teleport

function SkillEffectCalc_Teleport:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
  self._needDelTrapEntityID = 0
  self._extraTeleportPos = Vector2.zero
  self._needDelTrapEntityIDs = {}
  self._renderTeleportPath = {}
  self._posCalcState = nil
end

local function GetLogicDirection(dir)
  local ret = Vector2.zero
  if dir.x > 0 then
    ret.x = 1
  elseif dir.x < 0 then
    ret.x = -1
  end
  if 0 < dir.y then
    ret.y = 1
  elseif 0 > dir.y then
    ret.y = -1
  end
  return ret
end

function SkillEffectCalc_Teleport:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_Teleport:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local teleportParam = skillEffectCalcParam.skillEffectParam
  local world = self._world
  local entityWork = world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local posNew = entityWork:GetGridPosition():Clone()
  local dirNew = entityWork:GetGridDirection()
  local nTeleportType = skillEffectCalcParam.skillEffectParam:GetTeleportType()
  local userData = skillEffectCalcParam.skillEffectParam:GetUserPoint()
  local checkBlock = skillEffectCalcParam.skillEffectParam:GetCheckBlock()
  local isOnylDeleteBlock = false
  if EnumSkillEffectParam_Teleport.PickUp == nTeleportType then
    posNew = self:_FindTeleportPos_PickUp(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
    local telportSEParam = skillEffectCalcParam.skillEffectParam
    if not self:CanTeleport(posNew, telportSEParam, skillEffectCalcParam.casterEntityID) then
      return
    end
  elseif EnumSkillEffectParam_Teleport.User == nTeleportType then
    local point = skillEffectCalcParam.skillEffectParam:GetUserPoint()
    local dir = skillEffectCalcParam.skillEffectParam:GetUserDir()
    posNew = Vector2(point[1], point[2])
    dirNew = Vector2(dir[1], dir[2])
  elseif EnumSkillEffectParam_Teleport.CrossFarest == nTeleportType then
    local skillEffectCalc = SkillEffectCalc_CalEdgePos:New(self._world)
    local tCalEdgePos = skillEffectCalc:DoSkillEffectCalculator(skillEffectCalcParam)
    local calEdgePos = tCalEdgePos[1]
    local idx = calEdgePos:GetFarestIdx()
    local posArr = calEdgePos:GetPosArr()
    local dirArr = calEdgePos:GetDirArr()
    posNew = posArr[idx]
    dirNew = dirArr[idx]
    dirNew = Vector2(dirNew.x, dirNew.y)
  elseif EnumSkillEffectParam_Teleport.Forward == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    posNew = self:CalcEndPos(entityWork, eTarget)
    dirNew = Vector2(entityWork:GridLocation().Direction.x, entityWork:GridLocation().Direction.y)
  elseif EnumSkillEffectParam_Teleport.UserPointArray == nTeleportType then
    local posArr = skillEffectCalcParam.skillEffectParam:GetUserPoint()
    local dirArr = skillEffectCalcParam.skillEffectParam:GetUserDir()
    local area = entityWork:BodyArea():GetArea()
    local location = entityWork:GridLocation().Position
    for i = 1, #posArr do
      local pos = posArr[i]
      local canUse = true
      for i, p in ipairs(area) do
        if location.x + p.x == pos.x and location.y + p.y == pos.y then
          canUse = false
          break
        end
      end
      if canUse then
        posNew = Vector2(pos.x, pos.y)
        local dir = dirArr[i]
        dirNew = Vector2(dir.x, dir.y)
        break
      end
    end
  elseif EnumSkillEffectParam_Teleport.SkillRange_Far == nTeleportType then
    posNew = self:_FindTeleportPos_FarFromPlayer(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.SkillRange_Near == nTeleportType then
    posNew = self:_FindTeleportPos_NearFromPlayer(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.SkillScopePos == nTeleportType then
    if skillEffectCalcParam.skillRange._className and skillEffectCalcParam.skillRange._className == "Vector2" then
      posNew = skillEffectCalcParam.skillRange
    else
      posNew = skillEffectCalcParam.skillRange[1]
    end
    if not posNew then
      Log.debug("Teleport：pos err，SkillID = ", skillEffectCalcParam.skillID)
      return
    end
  elseif EnumSkillEffectParam_Teleport.TeleportTargetToCasterPos == nTeleportType then
    posNew = skillEffectCalcParam.attackPos
    skillEffectCalcParam.casterEntityID = defenderEntityID
    entityWork = self._world:GetEntityByID(defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.TeleportTargetToPickPos == nTeleportType then
    if defenderEntityID == -1 then
      return
    end
    if skillEffectCalcParam.skillRange[2] then
      posNew = skillEffectCalcParam.skillRange[2]
    else
      return nil
    end
    entityWork = self._world:GetEntityByID(defenderEntityID)
    skillEffectCalcParam.casterEntityID = defenderEntityID
  elseif EnumSkillEffectParam_Teleport.TeleportTargetToFirstPickPos == nTeleportType then
    if defenderEntityID == -1 then
      return
    end
    if skillEffectCalcParam.skillRange[1] then
      posNew = skillEffectCalcParam.skillRange[1]
    else
      return nil
    end
    entityWork = self._world:GetEntityByID(defenderEntityID)
    skillEffectCalcParam.casterEntityID = defenderEntityID
  elseif EnumSkillEffectParam_Teleport.TeleportTargetToSquareRing == nTeleportType then
    posNew = self:FindValidBySquareRing(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.HostOriginalPosSquareRing == nTeleportType then
    local centerPos = skillEffectCalcParam.gridPos
    local buffCmpt = entityWork:BuffComponent()
    if buffCmpt then
      local hostOriPos = buffCmpt:GetBuffValue("HostOriginalPos")
      if hostOriPos then
        centerPos = Vector2(hostOriPos.x, hostOriPos.y)
      end
      buffCmpt:SetBuffValue("HostOriginalPos", nil)
    end
    posNew = self:FindValidBySquareRing(skillEffectCalcParam.skillEffectParam, entityWork, centerPos)
  elseif EnumSkillEffectParam_Teleport.TeleportExitBoard == nTeleportType then
    posNew = Vector2(skillEffectCalcParam.gridPos.x + BattleConst.TeleportExitBoardOffsetX, skillEffectCalcParam.gridPos.y + BattleConst.TeleportExitBoardOffsetY)
    isOnylDeleteBlock = true
  elseif EnumSkillEffectParam_Teleport.CurPosBeforeSkillRangeNearest == nTeleportType then
    posNew = self:_FindTeleportPos_CurPosBeforeSkillRangeNearest(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.SkillScopePosFirst == nTeleportType then
    posNew = skillEffectCalcParam.skillRange[1]
  elseif EnumSkillEffectParam_Teleport.TargetPos == nTeleportType then
    local targetEntity = self._world:GetEntityByID(skillEffectCalcParam.targetEntityIDs[1])
    posNew = targetEntity:GetGridPosition()
  elseif EnumSkillEffectParam_Teleport.UseTeleportAndSummonTrapLastResult == nTeleportType then
    local routineComponent = entityWork:SkillContext():GetResultContainer()
    local resultsArray = routineComponent:GetEffectResultsAsArray(SkillEffectType.TeleportAndSummonTrap)
    local result = resultsArray[#resultsArray]
    posNew = result:GetTeleportPos()
  elseif EnumSkillEffectParam_Teleport.SkillScopeRandPos == nTeleportType then
    posNew = self:_FindTeleportPos_Random(entityWork, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.RoninKenshiStep == nTeleportType then
    posNew = self:_RoninKenshiStepPos(entityWork, posNew)
  elseif EnumSkillEffectParam_Teleport.NingKingJump == nTeleportType then
    posNew, dirNew = self:_NightKingJump(entityWork)
  elseif EnumSkillEffectParam_Teleport.TeleportMountForward == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_MountForward(skillEffectCalcParam, entityWork)
    if not posNew then
      return
    end
  elseif EnumSkillEffectParam_Teleport.UseMountTeleportExtraPos == nTeleportType then
    local routineComponent = entityWork:SkillContext():GetResultContainer()
    local resultsArray = routineComponent:GetEffectResultsAsArray(SkillEffectType.Teleport)
    if #resultsArray == 0 then
      return
    end
    local result = resultsArray[#resultsArray]
    posNew = result:GetExtraTeleportPos()
    if posNew == Vector2.zero then
      return
    end
  elseif EnumSkillEffectParam_Teleport.CasterGridDirectionForward == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    posNew = self:CalcEndPos(entityWork, eTarget, true, 1)
    dirNew = Vector2(entityWork:GridLocation().Direction.x, entityWork:GridLocation().Direction.y)
  elseif EnumSkillEffectParam_Teleport.TeleportPosByTargetPos == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    dirNew, posNew = self:CalcCasterPosAndDirByTargetPos(entityWork, eTarget)
  elseif EnumSkillEffectParam_Teleport.TeleportTargetToCasterPosValid == nTeleportType then
    skillEffectCalcParam.casterEntityID = defenderEntityID
    entityWork = self._world:GetEntityByID(defenderEntityID)
    if not entityWork then
      Log.fatal("[blink] TeleportTargetToCasterPosValid,no target entity,id: ", defenderEntityID)
      return
    end
    local bIncludeCenter = true
    local bExcludeMovePathEndPos = true
    local bExcludeTeamPos = true
    local excludeTraps = {}
    posNew = self:FindValidBySquareRing(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.attackPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange, bIncludeCenter, bExcludeMovePathEndPos, bExcludeTeamPos, excludeTraps)
  elseif EnumSkillEffectParam_Teleport.Boss2904001 == nTeleportType then
    posNew = self:CalcBoss2904001Pos(entityWork, skillEffectCalcParam.skillEffectParam)
  elseif EnumSkillEffectParam_Teleport.TargetAroundNearestCaster == nTeleportType then
    posNew = self:_CalcTargetAroundNearestCaster(entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.TargetPosWithCasterBody == nTeleportType then
    posNew = self:_CalcTargetPosWithCasterBody(entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.PickUpWithPath == nTeleportType then
    posNew = self:_FindTeleportPos_PickUpWithPath(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
    if self._renderTeleportPath and 0 < #self._renderTeleportPath then
      if 1 < #self._renderTeleportPath then
        local finalIndex = #self._renderTeleportPath
        local fromIndex = #self._renderTeleportPath - 1
        dirNew = self._renderTeleportPath[finalIndex] - self._renderTeleportPath[fromIndex]
      else
        local fromPos = entityWork:GetGridPosition()
        dirNew = self._renderTeleportPath[#self._renderTeleportPath] - fromPos
      end
    end
    local telportSEParam = skillEffectCalcParam.skillEffectParam
    if not self:CanTeleport(posNew, telportSEParam, skillEffectCalcParam.casterEntityID) then
      return
    end
  elseif EnumSkillEffectParam_Teleport.TargetAroundTrap == nTeleportType then
    posNew = self:_FindTeleportPos_TargetAroundTrap(skillEffectCalcParam, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.TargetAroundCalcCurBodyAreaAndDirCanDiffusion == nTeleportType then
  elseif EnumSkillEffectParam_Teleport.TrunToTargetOnSite == nTeleportType then
  elseif EnumSkillEffectParam_Teleport.TeleportWithScopeAndTrunToTarget == nTeleportType then
  elseif EnumSkillEffectParam_Teleport.FourHorsemenApproachPlayer == nTeleportType then
    posNew = self:_FindTeleportPos_FourHorsemenApproachPlayer(skillEffectCalcParam, entityWork)
  elseif EnumSkillEffectParam_Teleport.FourHorsemenAvoidPlayer == nTeleportType then
    posNew = self:_FindTeleportPos_FourHorsemenAvoidPlayer(skillEffectCalcParam, entityWork)
  elseif EnumSkillEffectParam_Teleport.BossDriller == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_BossDriller(skillEffectCalcParam, entityWork)
  elseif EnumSkillEffectParam_Teleport.NightKingTeleportRecordCalcState == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    posNew, dirNew = self:_FindTeleportPos_NightKingTeleportRecordCalcState(skillEffectCalcParam, entityWork, eTarget)
  elseif EnumSkillEffectParam_Teleport.NightKingDoubleCrossTeleport == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    posNew, dirNew = self:_FindTeleportPos_NightKingDoubleCrossTeleport(skillEffectCalcParam, entityWork, eTarget)
  elseif EnumSkillEffectParam_Teleport.NightKingTeleportWithPath == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    posNew, dirNew = self:_FindTeleportPos_NightKingTeleportWithPath(skillEffectCalcParam, entityWork, eTarget)
  elseif EnumSkillEffectParam_Teleport.TargetTeleportSelectPos == nTeleportType then
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    if not eTarget then
      return
    end
    posNew, dirNew = self:_FindTeleportPos_TargetTeleportSelectPos(skillEffectCalcParam, eTarget)
  elseif EnumSkillEffectParam_Teleport.PickUpAndSetDir == nTeleportType then
    posNew = self:_FindTeleportPos_PickUp(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
    local telportSEParam = skillEffectCalcParam.skillEffectParam
    if not self:CanTeleport(posNew, telportSEParam, skillEffectCalcParam.casterEntityID) then
      return
    end
    if posNew ~= entityWork:GetGridPosition() then
      dirNew = posNew - entityWork:GetGridPosition()
    end
  elseif EnumSkillEffectParam_Teleport.Boss2905701Move == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_Boss2905701Move(entityWork, teleportParam)
  elseif EnumSkillEffectParam_Teleport.Boss2905701BackToPos == nTeleportType then
    posNew = self:_FindTeleportPos_Boss2905701BackToPos(entityWork, teleportParam)
  elseif EnumSkillEffectParam_Teleport.Boss2905701MovePlayerToTrap == nTeleportType then
    skillEffectCalcParam.casterEntityID = defenderEntityID
    entityWork = self._world:GetEntityByID(defenderEntityID)
    posNew = self:_FindTeleportPos_Boss2905701MovePlayerToTrap(entityWork, teleportParam)
  elseif EnumSkillEffectParam_Teleport.SkillRange_FarAndDir == nTeleportType then
    posNew = self:_FindTeleportPos_FarFromPlayer(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
    local activeSkillPickUpComponent = entityWork:ActiveSkillPickUpComponent()
    local pickUpPos = posNew
    if activeSkillPickUpComponent then
      pickUpPos = activeSkillPickUpComponent:GetLastPickUpGridPos()
    end
    local dir = pickUpPos - entityWork:GetGridPosition()
    dirNew = dir
    if dirNew.x > 0 then
      dirNew.x = 1
    elseif dirNew.x < 0 then
      dirNew.x = -1
    end
    if dirNew.y > 0 then
      dirNew.y = 1
    elseif dirNew.y < 0 then
      dirNew.y = -1
    end
  elseif EnumSkillEffectParam_Teleport.SkillRangeFixed4 == nTeleportType then
    posNew = self:_FindSkillRangeFixed4(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
  elseif EnumSkillEffectParam_Teleport.CasterGridDirectionForward2 == nTeleportType then
    local forwardDis = teleportParam:GetForwardDis()
    local oldPos = entityWork:GetGridPosition()
    dirNew = Vector2(entityWork:GetGridDirection().x, entityWork:GetGridDirection().y)
    posNew = Vector2(oldPos.x + dirNew.x * forwardDis, oldPos.y + dirNew.y * forwardDis)
  elseif EnumSkillEffectParam_Teleport.JumpBack == nTeleportType then
    local utilData = self._world:GetService("UtilData")
    local forwardDis = teleportParam:GetForwardDis()
    local posOld = entityWork:GetGridPosition()
    local eTarget = self._world:GetEntityByID(defenderEntityID)
    local teamPos = eTarget:GetGridPosition()
    local calcDir = posOld - teamPos
    calcDir = GetLogicDirection(calcDir)
    dirNew = teamPos - posOld
    dirNew = GetLogicDirection(dirNew)
    for i = 1, forwardDis do
      posNew = posOld + calcDir * i
      if utilData:IsPosBlock(posNew, BlockFlag.MonsterLand) and posNew ~= posOld then
        posNew = posOld + calcDir * (i - 1)
        break
      end
    end
    if posNew == posOld then
      return
    end
  elseif EnumSkillEffectParam_Teleport.Monster2003801 == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_Monster2003801(entityWork, skillEffectCalcParam)
  elseif EnumSkillEffectParam_Teleport.Boss2906201 == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_Boss2906201(entityWork, skillEffectCalcParam)
  elseif EnumSkillEffectParam_Teleport.AlignTargetX == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_AlignTargetX(entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.AlignTargetY == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_AlignTargetY(entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.MultiJumpBack == nTeleportType then
    local forwardDis = teleportParam:GetForwardDis()
    local dir = entityWork:GetGridDirection()
    local calcDir = Vector2(-dir.x, -dir.y)
    posNew = self:_FindTeleportPos_MultiJumpBack(entityWork, forwardDis, calcDir)
    local posOld = entityWork:GetGridPosition()
    if posNew == posOld then
      return
    end
  elseif EnumSkillEffectParam_Teleport.JumpToAppointDir == nTeleportType then
    local forwardDis = teleportParam:GetForwardDis()
    local dir = entityWork:GetGridDirection()
    local calcDir = Vector2(dir.x, dir.y)
    local userDir = skillEffectCalcParam.skillEffectParam:GetUserDir()
    if userDir then
      calcDir = Vector2(userDir[1], userDir[2])
      dirNew = Vector2(userDir[1], userDir[2])
    end
    posNew = self:_FindTeleportPos_MultiJumpBack(entityWork, forwardDis, calcDir)
    local posOld = entityWork:GetGridPosition()
    if posNew == posOld then
      return
    end
  elseif EnumSkillEffectParam_Teleport.AngleFreeLineThroughTeamToEdge == nTeleportType then
    posNew = self:_FindTeleportPos_AngleFreeLineThroughTeamToEdge(skillEffectCalcParam, entityWork)
  elseif EnumSkillEffectParam_Teleport.ThroughTarget == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_ThroughTarget(entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.SkillRangeFarNoBlock == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_SkillRangeFarNoBlock(skillEffectCalcParam, entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.AntiClockWiseOnBoardEdge == nTeleportType then
    posNew = self:_FindTeleportPos_AntiClockWiseOnBoardEdge(skillEffectCalcParam, entityWork, defenderEntityID)
  elseif EnumSkillEffectParam_Teleport.ScopeNearestSelectPos == nTeleportType then
    posNew, dirNew = self:_FindTeleportPos_ScopeNearestSelectPos(skillEffectCalcParam, entityWork, defenderEntityID)
  else
    posNew = skillEffectCalcParam.gridPos
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local boardServiceLogic = world:GetService("BoardLogic")
  local utilData = self._world:GetService("UtilData")
  local sourcePos = entityWork:GetGridPosition()
  if checkBlock == 1 then
    local isBlock = utilData:IsPosBlock(posNew, BlockFlag.LinkLine)
    if isBlock then
      return
    end
  end
  local isResetDir = skillEffectCalcParam.skillEffectParam:IsResetDirection()
  if isResetDir then
    dirNew = posNew - sourcePos
    if dirNew.x > 0 then
      dirNew.x = 1
    elseif dirNew.x < 0 then
      dirNew.x = -1
    end
    if dirNew.y > 0 then
      dirNew.y = 1
    elseif dirNew.y < 0 then
      dirNew.y = -1
    end
  end
  local colorOld
  if casterEntity:HasPetPstID() or casterEntity:HasTeam() then
    local curSt = self._world:GameFSM():CurStateID()
    if curSt ~= GameStateID.PreviewActiveSkill and curSt ~= GameStateID.PickUpActiveSkillTarget then
      boardServiceLogic:RemoveEntityBlockFlag(casterEntity, sourcePos)
    end
    colorOld = boardServiceLogic:SupplyPieceList({sourcePos})[1].color
  elseif sourcePos then
    colorOld = utilData:FindPieceElement(sourcePos)
  end
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local result = SkillEffectResult_Teleport:New(skillEffectCalcParam.casterEntityID, sourcePos, colorOld, posNew, dirNew, stageIndex)
  if self._needDelTrapEntityID ~= 0 then
    result:SetNeedDelTrapEntityID(self._needDelTrapEntityID)
  end
  if self._extraTeleportPos ~= Vector2.zero then
    result:SetExtraTeleportPos(self._extraTeleportPos)
  end
  if 0 < #self._needDelTrapEntityIDs then
    result:SetNeedDelTrapEntityIDs(self._needDelTrapEntityIDs)
  end
  if casterEntity:HasPet() then
    local configSvc = self._world:GetService("Config")
    local skillConfigData = configSvc:GetSkillConfigData(skillEffectCalcParam.skillID)
    if skillConfigData:GetSkillType() == SkillType.Active then
      result:SetTeleportResult_IsPetActiveSkill(true)
    end
  end
  if self._renderTeleportPath and 0 < #self._renderTeleportPath then
    result:SetRenderTeleportPath(self._renderTeleportPath)
  end
  if self._posCalcState then
    result:SetTeleportPosCalcState(self._posCalcState)
  end
  return result
end

function SkillEffectCalc_Teleport:_FindTeleportPos_PickUp(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  local listTargetPos = skillRangePos
  local posReturn
  if #listTargetPos < 1 then
    Log.fatal("[blink] target error")
    posReturn = posCaster
  else
    posReturn = listTargetPos[1]
  end
  return posReturn
end

function SkillEffectCalc_Teleport:_FindTeleportPos_FarFromPlayer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  local posWork = self:_FindTeleportPos_Comparer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos, AiSortByDistance._ComparerByFar)
  return posWork
end

function SkillEffectCalc_Teleport:_FindTeleportPos_NearFromPlayer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  local posWork = self:_FindTeleportPos_Comparer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos, AiSortByDistance._ComparerByNear)
  return posWork
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Comparer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos, comparer, onlyEmpty)
  if nil == skillRangePos then
    return posCaster
  end
  local listRangeInPlan = skillRangePos
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posMain = teamEntity:GetGridPosition()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, comparer)
  sortPosList:AllowDuplicate()
  for i = 1, #skillRangePos do
    AINewNode.InsertSortedArray(sortPosList, posMain, skillRangePos[i], i)
  end
  local bodyArea = entityCaster:BodyArea():GetArea()
  local nRaceType
  if entityCaster:HasMonsterID() then
    nRaceType = entityCaster:MonsterID():GetMonsterRaceType()
  end
  local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
  if not nRaceType then
    nBlockRaceType = BlockFlag.LinkLine
  end
  for i = 1, sortPosList:Size() do
    local sortPosData = sortPosList:GetAt(i)
    local posWork = sortPosData.data
    if onlyEmpty then
      if boardServiceLogic:IsPosEmptyExceptConveyor(posWork) then
        return posWork
      end
    else
      local bPosBlock = boardServiceLogic:IsPosBlockByArea(posWork, nBlockRaceType, bodyArea, entityCaster)
      if not bPosBlock then
        return posWork
      end
    end
  end
  return posCaster
end

function SkillEffectCalc_Teleport:CalcEndPos(eCaster, eTarget, dontMoveLR, frontOffset)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local casterEndPos = Vector2.zero
  local cGridLocation = eCaster:GridLocation()
  casterEndPos.x = cGridLocation.Position.x
  casterEndPos.y = cGridLocation.Position.y
  local oriPos = eCaster:GetGridPosition()
  local preDashDir = {
    Vector2(0, -1),
    Vector2(-1, 0),
    Vector2(0, 1),
    Vector2(1, 0)
  }
  local casterDir = eCaster:GetGridDirection()
  local idx = 1
  for i, v in ipairs(preDashDir) do
    if v.x == casterDir.x and v.y == casterDir.y then
      idx = i
      break
    end
  end
  local isHit = false
  if eTarget then
    isHit = true
  end
  if isHit and not dontMoveLR then
    self:AdjustLRPos(idx, casterEndPos, eTarget:GridLocation().Position, eCaster)
  end
  local boardMaxX = boardServiceLogic:GetCurBoardMaxX()
  local boardMaxY = boardServiceLogic:GetCurBoardMaxY()
  frontOffset = frontOffset or 2
  if idx == 1 then
    if isHit then
      casterEndPos.y = eTarget:GridLocation().Position.y + 1
    else
      casterEndPos.y = 1
    end
  elseif idx == 2 then
    if isHit then
      casterEndPos.x = eTarget:GridLocation().Position.x + 1
    else
      casterEndPos.x = 1
    end
  elseif idx == 3 then
    if isHit then
      casterEndPos.y = eTarget:GridLocation().Position.y - frontOffset
    else
      casterEndPos.y = boardMaxY - 1
    end
  elseif isHit then
    casterEndPos.x = eTarget:GridLocation().Position.x - frontOffset
  else
    casterEndPos.x = boardMaxX - 1
  end
  local backDir = casterDir * -1
  casterEndPos = self:_BackToValidPos(casterEndPos, backDir, eCaster, BlockFlag.MonsterLand, oriPos)
  return casterEndPos
end

function SkillEffectCalc_Teleport:_BackToValidPos(casterEndPos, backDir, casterEntity, blockFlag, oriPos)
  local utilDataSvc = self._world:GetService("UtilData")
  local posOld = casterEndPos
  local bodyArea = casterEntity:BodyArea():GetArea()
  local posNew = posOld
  local boardSvc = self._world:GetService("BoardLogic")
  local maxLen = boardSvc:GetCurBoardMaxLen()
  local endPos = oriPos
  for i = 0, maxLen do
    posNew = posOld + backDir * i
    if utilDataSvc:IsValidPiecePos(posNew) and not self:_IsPosBlockByArea(posNew, blockFlag, bodyArea, casterEntity) then
      endPos = posNew
      break
    end
  end
  return endPos
end

function SkillEffectCalc_Teleport:AdjustLRPos(idx, casterEndPos, targetPos, casterEntity)
  local offset = 1
  if casterEntity:HasBodyArea() then
    local bodyAreaComponent = casterEntity:BodyArea()
    local bodyAreaArray = bodyAreaComponent:GetArea()
    local firstRowBodyArea = {}
    for _, areaPos in ipairs(bodyAreaArray) do
      if 0 == areaPos.x then
        table.insert(firstRowBodyArea, areaPos)
      end
    end
    offset = #firstRowBodyArea
  end
  if idx == 1 or idx == 3 then
    if targetPos.x < casterEndPos.x then
      casterEndPos.x = casterEndPos.x - offset
    elseif targetPos.x >= casterEndPos.x + offset then
      casterEndPos.x = casterEndPos.x + offset
    end
  elseif targetPos.y < casterEndPos.y then
    casterEndPos.y = casterEndPos.y - offset
  elseif targetPos.y >= casterEndPos.y + offset then
    casterEndPos.y = casterEndPos.y + offset
  end
end

function SkillEffectCalc_Teleport:FindValidBySquareRing(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos, bIncludeCenter, excludeMovePathEndPos, bExcludeTeamPos, excludeTraps)
  local findRoundCount = 8
  local offset = {
    1,
    0,
    -1
  }
  local bodyCmpt = entityCaster:BodyArea()
  local utilDataService = self._world:GetService("UtilData")
  local excludePosList = {}
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if excludeMovePathEndPos then
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local logicPath = logicChainPathCmpt:GetLogicChainPath()
    if logicPath then
      local endPos = logicPath[#logicPath]
      table.insert(excludePosList, endPos)
    end
  end
  if bExcludeTeamPos then
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local logicPath = logicChainPathCmpt:GetLogicChainPath()
    local bLinkMove = false
    if logicPath and 0 < #logicPath then
      bLinkMove = true
    end
    if not bLinkMove then
      local teamPos = teamEntity:GetGridPosition()
      table.insert(excludePosList, teamPos)
    end
  end
  if excludeTraps then
    local trapSvc = self._world:GetService("TrapLogic")
    for _, trapID in ipairs(excludeTraps) do
      local trapPosList = trapSvc:FindTrapPosByTrapID(trapID)
      if 0 < #trapPosList then
        table.appendArray(excludePosList, trapPosList)
      end
    end
  end
  if bIncludeCenter and not table.icontains(excludePosList, posCaster) and utilDataService:IsValidPiecePos(posCaster) and utilDataService:IsMonsterCanTel2TargetPos(entityCaster, posCaster) then
    return posCaster
  end
  for i = 1, findRoundCount do
    local posList = ComputeScopeRange.ComputeRange_SquareRing(posCaster, bodyCmpt:GetAreaCount(), i)
    for _, pos in ipairs(posList) do
      if not table.icontains(excludePosList, pos) and utilDataService:IsValidPiecePos(pos) and utilDataService:IsMonsterCanTel2TargetPos(entityCaster, pos) then
        return pos
      end
    end
  end
  return nil
end

function SkillEffectCalc_Teleport:_FindTeleportPos_CurPosBeforeSkillRangeNearest(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  local posWork = self:_FindTeleportPos_Comparer(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos, AiSortByDistance._ComparerByNear)
  local entityTeam = self._world:Player():GetLocalTeamEntity()
  local posTeam = entityTeam:GetGridPosition()
  local curPos = entityCaster:GetGridPosition()
  local curPosToTargetPosDistance = Vector2.Distance(curPos, posTeam)
  local workPosToTargetPosDistance = Vector2.Distance(posWork, posTeam)
  if curPosToTargetPosDistance <= workPosToTargetPosDistance then
    return curPos
  end
  return posWork
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Random(entityCaster, skillRangePos)
  local utilDataService = self._world:GetService("UtilData")
  local ret = skillRangePos[1]
  local range = {}
  for i, pos in ipairs(skillRangePos) do
    if utilDataService:IsMonsterCanTel2TargetPos(entityCaster, pos) then
      range[#range + 1] = pos
    end
  end
  if 0 < #range then
    local randomSvc = self._world:GetService("RandomLogic")
    ret = range[randomSvc:LogicRand(1, #range)]
  end
  return ret
end

function SkillEffectCalc_Teleport:CanTeleport(pos, teleportSEParam, casterEntityID)
  local trapID = teleportSEParam:GetTrapID()
  if trapID == 0 then
    return true
  end
  local boardCmpt = self._world:GetBoardEntity():Board()
  local traps = boardCmpt:GetPieceEntities(pos, function(e)
    local isOwner = false
    if e:HasSummoner() then
      if e:Summoner():GetSummonerEntityID() == casterEntityID then
        isOwner = true
      else
        local summonerID = e:Summoner():GetSummonerEntityID()
        local casterEntity = self._world:GetEntityByID(casterEntityID)
        if casterEntity:HasPet() then
          local cTeam = casterEntity:Pet():GetOwnerTeamEntity():Team()
          local entities = cTeam:GetTeamPetEntities()
          for _, petEntity in ipairs(entities) do
            if summonerID == petEntity:GetID() then
              isOwner = true
              break
            end
          end
        end
      end
    else
      isOwner = true
    end
    return isOwner and e:HasTrap() and e:Trap():GetTrapID() == trapID and not e:HasDeadMark()
  end)
  if 0 < #traps then
    local entity = traps[1]
    self._needDelTrapEntityID = entity:GetID()
    return true
  end
  return false
end

function SkillEffectCalc_Teleport:_RoninKenshiStepPos(entityWork, posNew)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local v2TeamPos = teamEntity:GetGridPosition()
  local v2CasterPos = entityWork:GetGridPosition()
  local rangeLT = {
    Vector2.New(v2CasterPos.x - 2, v2CasterPos.y + 2),
    Vector2.New(v2CasterPos.x - 2, v2CasterPos.y + 1),
    Vector2.New(v2CasterPos.x - 1, v2CasterPos.y + 2)
  }
  local rangeRT = {
    Vector2.New(v2CasterPos.x + 2, v2CasterPos.y + 2),
    Vector2.New(v2CasterPos.x + 2, v2CasterPos.y + 1),
    Vector2.New(v2CasterPos.x + 1, v2CasterPos.y + 2)
  }
  local rangeLB = {
    Vector2.New(v2CasterPos.x - 2, v2CasterPos.y - 2),
    Vector2.New(v2CasterPos.x - 2, v2CasterPos.y - 1),
    Vector2.New(v2CasterPos.x - 1, v2CasterPos.y - 2)
  }
  local rangeRB = {
    Vector2.New(v2CasterPos.x + 2, v2CasterPos.y - 2),
    Vector2.New(v2CasterPos.x + 2, v2CasterPos.y - 1),
    Vector2.New(v2CasterPos.x + 1, v2CasterPos.y - 2)
  }
  local v2Pos = posNew
  if table.icontains(rangeLT, v2TeamPos) then
    v2Pos = Vector2.New(v2CasterPos.x - 1, v2CasterPos.y + 1)
  elseif table.icontains(rangeRT, v2TeamPos) then
    v2Pos = Vector2.New(v2CasterPos.x + 1, v2CasterPos.y + 1)
  elseif table.icontains(rangeLB, v2TeamPos) then
    v2Pos = Vector2.New(v2CasterPos.x - 1, v2CasterPos.y - 1)
  elseif table.icontains(rangeRB, v2TeamPos) then
    v2Pos = Vector2.New(v2CasterPos.x + 1, v2CasterPos.y - 1)
  end
  if v2Pos ~= posNew then
    local nRaceType = MonsterRaceType.Land
    if entityWork:HasMonsterID() then
      nRaceType = entityWork:MonsterID():GetMonsterRaceType()
    end
    local bodyArea = entityWork:BodyArea():GetArea()
    local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local bPosBlock = boardServiceLogic:IsPosBlockByArea(v2Pos, nBlockRaceType, bodyArea, entityWork)
    if not bPosBlock then
      posNew = v2Pos
    end
  end
  return posNew
end

function SkillEffectCalc_Teleport:_NightKingJump(casterEntity)
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local casterPos = casterEntity:GetGridPosition()
  local utilDataSvc = self._world:GetService("UtilData")
  local utilScopeCalcSvc = self._world:GetService("UtilScopeCalc")
  local nearPos
  local nearDis = 10000
  local dir
  local dirList = {
    DirectionType.Up,
    DirectionType.Left,
    DirectionType.Down,
    DirectionType.Right
  }
  local sBoard = self._world:GetService("BoardLogic")
  local bodyArea, blockFlag = sBoard:RemoveEntityBlockFlag(casterEntity, casterPos)
  for x = 1, 10 do
    local posList = utilScopeCalcSvc:GetTargetSquareRing(teamEntity:GetID(), x)
    for i, newPos in ipairs(posList) do
      local dis = Vector2.Distance(newPos, casterPos)
      if nearDis >= dis and not utilDataSvc:IsPosBlock(newPos, BlockFlag.MonsterLand) then
        local bFind = false
        for _, dirType in ipairs(dirList) do
          local rangList = utilScopeCalcSvc:GetNightKing_Skill1A(casterEntity, newPos, dirType)
          if table.Vector2Include(rangList, teamPos) and utilScopeCalcSvc:IsNewBodyAreaPosValidByDirType(newPos, dirType) then
            dir = utilScopeCalcSvc:GetDirByDirType(dirType)
            bFind = true
            break
          end
        end
        if bFind then
          nearPos = newPos
          nearDis = dis
        end
      end
    end
    if nearPos ~= nil then
      break
    end
  end
  sBoard:SetEntityBlockFlag(casterEntity, casterPos, blockFlag)
  return nearPos, dir
end

function SkillEffectCalc_Teleport:_FindTeleportPos_MountForward(skillEffectCalcParam, entityWork)
  if not entityWork:HasRide() then
    return
  end
  local rideCmpt = entityWork:Ride()
  local mountID = rideCmpt:GetMountID()
  local mountEntity = self._world:GetEntityByID(mountID)
  local rideSvc = self._world:GetService("RideLogic")
  rideSvc:ResetBodyArea(entityWork)
  rideSvc:RemoveRide(entityWork:GetID(), mountID)
  local endPos, dir = self:_CalcMountEndPos(mountEntity)
  self:_CheckAlphaPos(entityWork, mountEntity, endPos)
  skillEffectCalcParam.casterEntityID = mountID
  entityWork = mountEntity
  local trapID = skillEffectCalcParam.skillEffectParam:GetTrapID()
  self:_FindTrapEntityIDInTeleportRange(mountEntity, endPos, trapID)
  return endPos, dir
end

function SkillEffectCalc_Teleport:GetPosListAroundBodyArea(entity, ringCount)
  local v2SelfGridPos = entity:GetGridPosition()
  local bodyArea = entity:BodyArea():GetArea()
  local v2SelfDir = entity:GetGridDirection()
  local scopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = SkillScopeCalculator:New(scopeSvc)
  local scopeResult = scopeCalc:ComputeScopeRange(SkillScopeType.AroundBodyArea, {0, ringCount}, v2SelfGridPos, bodyArea, v2SelfDir, SkillTargetType.Monster, v2SelfGridPos)
  return scopeResult:GetAttackRange()
end

function SkillEffectCalc_Teleport:_FindRideTeleportPos(rideEntity, mountEntity)
  local posRide = rideEntity:GetGridPosition()
  local boardSvc = self._world:GetService("BoardLogic")
  local pos = mountEntity:GetGridPosition()
  local bodyArea = mountEntity:BodyArea():GetArea()
  local skillRangePos = ComputeScopeRange.ComputeRange_CrossScope(pos, #bodyArea, 1)
  local posWork = self:_FindTeleportPos_Comparer(nil, rideEntity, posRide, nil, skillRangePos, AiSortByDistance._ComparerByFar, true)
  if posWork ~= posRide then
    return posWork
  end
  local maxLen = boardSvc:GetCurBoardMaxLen()
  for i = 1, maxLen do
    local skillRangePos = self:GetPosListAroundBodyArea(mountEntity, i)
    local posWork = self:_FindTeleportPos_Comparer(nil, rideEntity, posRide, nil, skillRangePos, AiSortByDistance._ComparerByFar, true)
    if posWork ~= posRide then
      return posWork
    end
  end
  return posRide
end

function SkillEffectCalc_Teleport:_CalcMountDir(mountEntity, petEntity)
  local posMain = petEntity:GetGridPosition()
  local endPos = mountEntity:GetGridPosition()
  local bodyArea = mountEntity:BodyArea():GetArea()
  local posList = {}
  for _, v in ipairs(bodyArea) do
    table.insert(posList, endPos + v)
  end
  local idx = 1
  local preDashDir = {
    Vector2(0, -1),
    Vector2(-1, 0),
    Vector2(0, 1),
    Vector2(1, 0)
  }
  for _, pos in ipairs(posList) do
    local mountDir = Vector2.Normalize(posMain - pos)
    for i, v in ipairs(preDashDir) do
      if v.x == mountDir.x and v.y == mountDir.y then
        return i
      end
    end
  end
  return idx
end

function SkillEffectCalc_Teleport:_CalcMountEndPos(mountEntity)
  local petEntity = self._world:Player():GetCurrentTeamEntity()
  local posMain = petEntity:GetGridPosition()
  local endPos = Vector2.zero
  endPos.x = mountEntity:GetGridPosition().x
  endPos.y = mountEntity:GetGridPosition().y
  local dir = GameHelper.ComputeLogicDir(posMain - endPos)
  local idx = self:_CalcMountDir(mountEntity, petEntity)
  local petBodySqure = 1
  local mountBodySqure = 2
  if idx == 1 then
    endPos.y = posMain.y + petBodySqure
  elseif idx == 2 then
    endPos.x = posMain.x + petBodySqure
  elseif idx == 3 then
    endPos.y = posMain.y - mountBodySqure
  else
    endPos.x = posMain.x - mountBodySqure
  end
  return endPos, dir
end

function SkillEffectCalc_Teleport:_CheckAlphaPos(entityWork, mountEntity, endPos)
  local oriPos = entityWork:GetGridPosition()
  local needTeleport = false
  local bodyArea = mountEntity:BodyArea():GetArea()
  for _, v in ipairs(bodyArea) do
    local curPos = endPos + v
    if curPos == oriPos then
      needTeleport = true
      break
    end
  end
  if not needTeleport then
    self._extraTeleportPos = oriPos
    return
  end
  self._extraTeleportPos = self:_FindRideTeleportPos(entityWork, mountEntity)
end

function SkillEffectCalc_Teleport:_FindTrapEntityIDInTeleportRange(mountEntity, endPos, trapID)
  local startPos = Vector2.zero
  startPos.x = mountEntity:GetGridPosition().x
  startPos.y = mountEntity:GetGridPosition().y
  if startPos == endPos then
    return
  end
  local bodyAreaArray = mountEntity:BodyArea():GetArea()
  local expandArea = {}
  for i, v in ipairs(bodyAreaArray) do
    local p = startPos + v
    table.insert(expandArea, p)
  end
  local casterDirX = endPos.x - startPos.x
  local casterDirY = endPos.y - startPos.y
  local length = math.max(math.abs(casterDirX), math.abs(casterDirY))
  if casterDirX ~= 0 then
    casterDirX = casterDirX / math.abs(casterDirX)
  end
  if casterDirY ~= 0 then
    casterDirY = casterDirY / math.abs(casterDirY)
  end
  local teleportRange = {}
  for _, p in ipairs(bodyAreaArray) do
    local center_x = startPos.x + p.x
    local center_y = startPos.y + p.y
    for index = 1, length do
      local curPos = Vector2(center_x + casterDirX * index, center_y + casterDirY * index)
      table.insert(teleportRange, curPos)
    end
  end
  teleportRange = table.unique(teleportRange)
  for _, pos in ipairs(teleportRange) do
    local utilDataSvc = self._world:GetService("UtilData")
    local trapEntityID = utilDataSvc:GetTrapAtPosByTrapID(pos, trapID)
    table.insert(self._needDelTrapEntityIDs, trapEntityID)
  end
end

function SkillEffectCalc_Teleport:CalcCasterPosAndDirByTargetPos(casterEntity, targetEntity)
  local casterPos = casterEntity:GetGridPosition()
  local casterBodyArea = casterEntity:BodyArea():GetArea()
  local targetPos = targetEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local dirTypeList = {
    DirectionType.Up,
    DirectionType.Down,
    DirectionType.Left,
    DirectionType.Right
  }
  local targetDir
  for i, dirType in ipairs(dirTypeList) do
    local range = utilScopeSvc:Monster2903501FindPlayer(dirType, casterPos, casterBodyArea)
    if table.Vector2Include(range, targetPos) then
      targetDir = dirType
      break
    end
  end
  local pos, dir
  if targetDir == DirectionType.Down then
    dir = Vector2(0, -1)
    if casterPos.x >= targetPos.x then
      pos = Vector2(targetPos.x, targetPos.y + 1)
    else
      pos = Vector2(targetPos.x - 1, targetPos.y + 1)
    end
  elseif targetDir == DirectionType.Up then
    dir = Vector2(0, 1)
    if casterPos.x >= targetPos.x then
      pos = Vector2(targetPos.x, targetPos.y - 2)
    else
      pos = Vector2(targetPos.x - 1, targetPos.y - 2)
    end
  elseif targetDir == DirectionType.Left then
    dir = Vector2(-1, 0)
    if casterPos.y < targetPos.y then
      pos = Vector2(targetPos.x + 1, targetPos.y - 1)
    else
      pos = Vector2(targetPos.x + 1, targetPos.y)
    end
  elseif targetDir == DirectionType.Right then
    dir = Vector2(1, 0)
    if casterPos.y < targetPos.y then
      pos = Vector2(targetPos.x - 2, targetPos.y - 1)
    else
      pos = Vector2(targetPos.x - 2, targetPos.y)
    end
  end
  return dir, pos
end

function SkillEffectCalc_Teleport:CalcBoss2904001Pos(entityCaster, skillEffectParam)
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local v2TeamPos = eLocalTeam:GetGridPosition()
  local utilScope = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScope:GetSkillScopeCalc()
  local scopeParamParser = SkillScopeParamParser:New()
  local skipRangeParam = scopeParamParser:ParseScopeParam(SkillScopeType.SquareRing, {1})
  local skipRangeScope = scopeCalc:ComputeScopeRange(SkillScopeType.SquareRing, skipRangeParam, entityCaster:GetGridPosition(), entityCaster:BodyArea():GetArea(), entityCaster:GetGridPosition(), SkillTargetType.Team, entityCaster:GetGridPosition(), entityCaster)
  if table.Vector2Include(skipRangeScope:GetAttackRange() or {}, v2TeamPos) then
    return entityCaster:GetGridPosition()
  end
  local aroundBodyAmplifyCrossParam = scopeParamParser:ParseScopeParam(SkillScopeType.AroundBodyAmplifyCross, {2, 9})
  local aroundBodyAmplifyCrossScope = scopeCalc:ComputeScopeRange(SkillScopeType.AroundBodyAmplifyCross, aroundBodyAmplifyCrossParam, entityCaster:GetGridPosition(), entityCaster:BodyArea():GetArea(), entityCaster:GetGridPosition(), SkillTargetType.Team, entityCaster:GetGridPosition(), entityCaster)
  local v2NearestGridPos = entityCaster:GetGridPosition()
  local v2CasterCenterPos = entityCaster:GetGridPosition()
  local distance = Vector2.Distance(v2NearestGridPos, v2TeamPos)
  for _, v2Body in ipairs(entityCaster:BodyArea():GetArea()) do
    local v2 = v2Body + v2CasterCenterPos
    local dis = Vector2.Distance(v2, v2TeamPos)
    if distance > dis then
      v2NearestGridPos = v2
      distance = dis
    end
  end
  local dir = v2TeamPos - v2NearestGridPos
  if dir.x > 0 then
    dir.x = 1
  end
  if dir.x < 0 then
    dir.x = -1
  end
  if 0 < dir.y then
    dir.y = 1
  end
  if 0 > dir.y then
    dir.y = -1
  end
  if table.Vector2Include(aroundBodyAmplifyCrossScope:GetAttackRange() or {}, v2TeamPos) then
    return self:_CalcBoss2904001NearestTeleportPos(entityCaster, dir, v2TeamPos, skillEffectParam:GetBoss2904001CrossMaxLength())
  else
    return self:_CalcBoss2904001NearestTeleportPos(entityCaster, dir, v2TeamPos, skillEffectParam:GetBoss2904001RotatedCrossMaxLength())
  end
end

function SkillEffectCalc_Teleport:_CalcBoss2904001NearestTeleportPos(entityCaster, dir, targetPos, maxLength)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local nRaceType = MonsterRaceType.Land
  if entityCaster:HasMonsterID() then
    nRaceType = entityCaster:MonsterID():GetMonsterRaceType()
  end
  local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
  local casterCenterPos = entityCaster:GetGridPosition()
  local bodyArea = entityCaster:BodyArea():GetArea()
  local minDistance = Vector2.Distance(casterCenterPos, targetPos)
  local minDisPos = casterCenterPos
  for offset = 1, maxLength do
    local centerPos = casterCenterPos + dir * offset
    local dis = self:_CalcNearestDistance(centerPos, bodyArea, targetPos)
    if minDistance > dis then
      local bPosBlock = self:_IsPosBlockByArea(centerPos, nBlockRaceType, bodyArea, entityCaster)
      if not bPosBlock then
        minDistance = dis
        minDisPos = centerPos
      end
    end
  end
  return minDisPos
end

function SkillEffectCalc_Teleport:_CalcNearestDistance(centerPos, bodyArea, targetPos)
  local distance = Vector2.Distance(targetPos, centerPos)
  for _, v2Body in ipairs(bodyArea) do
    local v2 = centerPos + v2Body
    local dis = Vector2.Distance(targetPos, v2)
    distance = math.min(distance, dis)
  end
  return distance
end

function SkillEffectCalc_Teleport:_IsPosBlockByArea(pos, blockFlag, listArea, entityExcept)
  local utilDataSvc = self._world:GetService("UtilData")
  local ret = false
  for i = 1, #listArea do
    local posWork = pos + listArea[i]
    if not utilDataSvc:IsValidPiecePos(posWork) then
      return true
    end
    if utilDataSvc:IsPosBlock(posWork, blockFlag) then
      if not entityExcept then
        return true
      end
      local playerBlock = false
      if #utilDataSvc:FindEntityByPosAndType(posWork, EnumTargetEntity.Pet) > 0 and not entityExcept:HasPet() then
        playerBlock = true
      end
      local monsterBlock = false
      local entityMonster = utilDataSvc:GetMonsterAtPos(posWork)
      if entityMonster and entityMonster ~= entityExcept then
        monsterBlock = true
      end
      local trapBlock = false
      local entityTrap = utilDataSvc:GetTrapsAtPos(posWork)
      if #entityTrap ~= 0 and not table.icontains(entityTrap, entityExcept) then
        trapBlock = true
      end
      local isBlock = playerBlock or monsterBlock or trapBlock
      if isBlock then
        return true
      end
    end
  end
  return false
end

function SkillEffectCalc_Teleport:_CalcTargetAroundNearestCaster(entityWork, defenderEntityID)
  local posNew
  local eTarget = self._world:GetEntityByID(defenderEntityID)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local maxLen = boardServiceLogic:GetCurBoardMaxLen()
  local casterPos = entityWork:GetGridPosition()
  local casterBodyArea = entityWork:BodyArea():GetArea()
  local targetPos = eTarget:GetGridPosition()
  local bodyArea = eTarget:BodyArea():GetArea()
  local block = BlockFlag.LinkLine
  local bodyX = {}
  local bodyY = {}
  for _, area in ipairs(bodyArea) do
    local workPos = targetPos + area
    if not table.intable(bodyX, workPos.x) then
      table.insert(bodyX, workPos.x)
    end
    if not table.intable(bodyY, workPos.y) then
      table.insert(bodyY, workPos.y)
    end
  end
  for i = 1, maxLen do
    local skillRangePos = self:GetPosListAroundBodyArea(eTarget, i)
    local crossPosList = {}
    local xPosList = {}
    for _, pos in ipairs(skillRangePos) do
      local bPosBlock = boardServiceLogic:IsPosBlockByArea(pos, block, casterBodyArea, entityWork)
      if not bPosBlock then
        if table.intable(bodyX, pos.x) or table.intable(bodyY, pos.y) then
          table.insert(crossPosList, pos)
        else
          table.insert(xPosList, pos)
        end
      end
    end
    if table.count(crossPosList) > 0 then
      table.sort(crossPosList, function(a, b)
        local disA = Vector2.Distance(casterPos, a)
        local disB = Vector2.Distance(casterPos, b)
        return disA < disB
      end)
      posNew = crossPosList[1]
      break
    end
    if table.count(xPosList) > 0 then
      table.sort(xPosList, function(a, b)
        local disA = Vector2.Distance(casterPos, a)
        local disB = Vector2.Distance(casterPos, b)
        return disA < disB
      end)
      posNew = xPosList[1]
      break
    end
  end
  return posNew
end

function SkillEffectCalc_Teleport:_CalcTargetPosWithCasterBody(entityWork, defenderEntityID)
  local posNew
  local utilDataSvc = self._world:GetService("UtilData")
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local targetEntity = self._world:GetEntityByID(defenderEntityID)
  local targetPos = targetEntity:GetGridPosition()
  local casterPos = entityWork:GetGridPosition()
  local bodyArea = entityWork:BodyArea():GetArea()
  local casterBodyPosList = {}
  for _, area in ipairs(bodyArea) do
    local workPos = area + casterPos
    table.insert(casterBodyPosList, workPos)
  end
  local block = BlockFlag.MonsterLand
  local posList = {}
  local notBlockPosCount = 0
  for _, area in ipairs(bodyArea) do
    local workPos = area + targetPos
    local isCasterBodyPos = table.intable(casterBodyPosList, workPos)
    local isBlock = utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand)
    if isBlock and utilDataSvc:IsPosHasSpTrap(workPos, TrapType.BadGrid) then
      isBlock = false
    end
    if isCasterBodyPos or workPos ~= targetPos and not isBlock then
      notBlockPosCount = notBlockPosCount + 1
    end
  end
  if notBlockPosCount == table.count(bodyArea) - 1 then
    posNew = targetPos
    return posNew
  end
  posList = {}
  for _, area in ipairs(bodyArea) do
    local workPosCenter = targetPos - area
    notBlockPosCount = 0
    for i, v in ipairs(bodyArea) do
      local workPos = v + workPosCenter
      local isCasterBodyPos = table.intable(casterBodyPosList, workPos)
      local isBlock = utilDataSvc:IsPosBlock(workPos, BlockFlag.MonsterLand)
      if isBlock and utilDataSvc:IsPosHasSpTrap(workPos, TrapType.BadGrid) then
        isBlock = false
      end
      if isCasterBodyPos or workPos ~= targetPos and not isBlock then
        notBlockPosCount = notBlockPosCount + 1
      end
    end
    if notBlockPosCount == table.count(bodyArea) - 1 then
      table.insert(posList, workPosCenter)
      break
    end
  end
  posNew = posList[1]
  return posNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_PickUpWithPath(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  local listTargetPos = skillRangePos
  local posReturn
  local pathReturn = {}
  if #listTargetPos < 1 then
    Log.fatal("[blink] target error")
    posReturn = posCaster
    table.insert(pathReturn, posCaster)
  else
    for index, pathPos in ipairs(listTargetPos) do
      table.insert(pathReturn, pathPos)
    end
    posReturn = listTargetPos[#listTargetPos]
  end
  self._renderTeleportPath = pathReturn
  return posReturn
end

function SkillEffectCalc_Teleport:_FindTeleportPos_TargetAroundTrap(skillEffectCalcParam, defenderEntityID)
  local telportSkillEffectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local posNew = casterEntity:GetGridPosition()
  local trapID = skillEffectCalcParam.skillEffectParam:GetTrapID()
  local eTarget = self._world:GetEntityByID(defenderEntityID)
  local skillRangePos = self:GetPosListAroundBodyArea(eTarget, 1)
  local validPosList = {}
  local trapServerLogic = self._world:GetService("TrapLogic")
  local tarpPosList = trapServerLogic:FindTrapPosByTrapID(trapID)
  for _, pos in ipairs(tarpPosList) do
    if table.intable(skillRangePos, pos) then
      table.insert(validPosList, pos)
    end
  end
  if table.intable(validPosList, posNew) then
  else
    local canTeleportPosList = {}
    local utilDataSvc = self._world:GetService("UtilData")
    for _, pos in ipairs(validPosList) do
      if not utilDataSvc:IsPosBlock(pos, BlockFlag.MonsterLand) then
        table.insert(canTeleportPosList, pos)
      end
    end
    if table.count(canTeleportPosList) == 0 then
    else
      local randomSvc = self._world:GetService("RandomLogic")
      local randomIndex = randomSvc:LogicRand(1, #canTeleportPosList)
      local randomPos = canTeleportPosList[randomIndex]
      posNew = randomPos
    end
  end
  return posNew
end

function SkillEffectCalc_Teleport:_FourHorsemen_GetAllHorsemenInfo(skillEffectCalcParam, ignoreCaster)
  local casterEntityID = skillEffectCalcParam.casterEntityID
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local v2LocalTeamPos = eLocalTeam:GetGridPosition()
  local effectParam = skillEffectCalcParam.skillEffectParam
  local teMonster = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  local teHorsemenInfo = {}
  for index, e in ipairs(teMonster) do
    local monsterClassID = e:MonsterID():GetMonsterClassID()
    if table.icontains(effectParam:GetHorsemenMonsterClassID(), monsterClassID) and not e:HasDeadMark() then
      local pos = e:GetGridPosition()
      local distance = Vector2.Distance(pos, v2LocalTeamPos)
      if not ignoreCaster or e:GetID() ~= casterEntityID then
        table.insert(teHorsemenInfo, {
          entity = e,
          sortIndex = #teHorsemenInfo,
          distance = distance
        })
      end
    end
  end
  return teHorsemenInfo
end

function SkillEffectCalc_Teleport:_FourHorsemen_GetFirstDistanceHorsemenEntities(teHorsemenInfo)
  local tNearestHorsemenEntity = {}
  local distance = teHorsemenInfo[1].distance
  for _, info in ipairs(teHorsemenInfo) do
    if info.distance == distance then
      table.insert(tNearestHorsemenEntity, info.entity)
    end
  end
  return tNearestHorsemenEntity
end

function SkillEffectCalc_Teleport:_FourHorsemen_GetFirstValidTeleportPosAround(teleportEntity, center)
  local nRaceType = MonsterRaceType.Land
  if teleportEntity:HasMonsterID() then
    nRaceType = teleportEntity:MonsterID():GetMonsterRaceType()
  end
  local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
  local utilData = self._world:GetService("UtilData")
  local lsvcBoard = self._world:GetService("BoardLogic")
  local ringMax = lsvcBoard:GetCurBoardRingMax()
  for _, v in ipairs(ringMax) do
    local pos = center + Vector2.New(v[1], v[2])
    if utilData:IsValidPiecePos(pos) and not lsvcBoard:IsPosBlockByArea(pos, nBlockRaceType, teleportEntity:BodyArea():GetArea()) then
      return pos
    end
  end
end

function SkillEffectCalc_Teleport:_FindTeleportPos_FourHorsemenApproachPlayer(skillEffectCalcParam, teleportEntity)
  local posNew
  local teHorsemenInfo = self:_FourHorsemen_GetAllHorsemenInfo(skillEffectCalcParam)
  if #teHorsemenInfo == 0 then
    posNew = teleportEntity:GetGridPosition():Clone()
    return posNew
  end
  table.sort(teHorsemenInfo, function(a, b)
    if a.distance ~= b.distance then
      return a.distance < b.distance
    end
    return a.sortIndex < b.sortIndex
  end)
  local tNearestHorsemenEntity = self:_FourHorsemen_GetFirstDistanceHorsemenEntities(teHorsemenInfo)
  if #tNearestHorsemenEntity == 0 then
    posNew = teleportEntity:GetGridPosition():Clone()
    return posNew
  end
  if tNearestHorsemenEntity[1]:GetID() == teleportEntity:GetID() and #tNearestHorsemenEntity == 1 then
    posNew = teleportEntity:GetGridPosition():Clone()
    return posNew
  end
  local tNonSelfNearestHorsemenEntity = {}
  for _, e in ipairs(tNearestHorsemenEntity) do
    if e:GetID() ~= teleportEntity:GetID() then
      table.insert(tNonSelfNearestHorsemenEntity, e)
    end
  end
  local tFreeCandidatePos = {}
  local tBlockedCandidatePos = {}
  for _, targetHorseman in ipairs(tNonSelfNearestHorsemenEntity) do
    local tFreePos = {}
    local tBlockPos = {}
    local centerPos = targetHorseman:GetGridPosition()
    local dir = {
      Vector2.New(-1, 1),
      Vector2.New(-1, -1),
      Vector2.New(1, 1),
      Vector2.New(1, -1)
    }
    local nRaceType = MonsterRaceType.Land
    if teleportEntity:HasMonsterID() then
      nRaceType = teleportEntity:MonsterID():GetMonsterRaceType()
    end
    local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
    local boardServiceLogic = self._world:GetService("BoardLogic")
    local utilData = self._world:GetService("UtilData")
    local eLocalTeam = self._world:Player():GetLocalTeamEntity()
    local v2LocalTeamPos = eLocalTeam:GetGridPosition()
    for _, v2 in ipairs(dir) do
      local pos = centerPos + v2
      local isValidPos = utilData:IsValidPiecePos(pos)
      local isBlocked = self:_IsPosBlockByArea(pos, nBlockRaceType, teleportEntity:BodyArea():GetArea())
      if isValidPos then
        if isBlocked then
          table.insert(tBlockPos, {
            pos = pos,
            sortIndex = #tBlockPos,
            distance = Vector2.Distance(pos, v2LocalTeamPos)
          })
        else
          table.insert(tFreePos, {
            pos = pos,
            sortIndex = #tFreePos,
            distance = Vector2.Distance(pos, v2LocalTeamPos)
          })
        end
      end
    end
    if 0 < #tFreePos then
      for _, info in ipairs(tFreePos) do
        if not table.Vector2Include(tFreeCandidatePos, info) then
          table.insert(tFreeCandidatePos, info)
        end
      end
    elseif 0 < #tBlockPos then
      for _, info in ipairs(tBlockPos) do
        if not table.Vector2Include(tBlockedCandidatePos, info) then
          table.insert(tBlockedCandidatePos, info)
        end
      end
    end
  end
  table.sort(tFreeCandidatePos, function(a, b)
    if a.distance ~= b.distance then
      return a.distance < b.distance
    end
    return a.sortIndex < b.sortIndex
  end)
  table.sort(tBlockedCandidatePos, function(a, b)
    if a.distance ~= b.distance then
      return a.distance < b.distance
    end
    return a.sortIndex < b.sortIndex
  end)
  if 0 < #tFreeCandidatePos then
    posNew = tFreeCandidatePos[1].pos
  elseif 0 < #tBlockedCandidatePos then
    local center = tBlockedCandidatePos[1].pos
    local nearestPos = self:_FourHorsemen_GetFirstValidTeleportPosAround(teleportEntity, center)
    posNew = nearestPos
  end
  return posNew or teleportEntity:GetGridPosition():Clone()
end

local function fourHorsemenAvoidPlayerGenTheoryEdgeGrid(a, b, calcByX)
  local v2 = Vector2.zero
  v2.x = calcByX and a or b
  v2.y = calcByX and b or a
  return v2
end

function SkillEffectCalc_Teleport:_FindTeleportPos_FourHorsemenAvoidPlayer(skillEffectCalcParam, teleportEntity)
  local posNew = teleportEntity:GetGridPosition():Clone()
  local eLocalTeam = self._world:Player():GetLocalTeamEntity()
  local v2LocalTeamPos = eLocalTeam:GetGridPosition()
  local utilData = self._world:GetService("UtilData")
  local dir = {
    Vector2.up,
    Vector2.down,
    Vector2.left,
    Vector2.right
  }
  local destPosCandidates = {}
  local teHorsemenInfo = self:_FourHorsemen_GetAllHorsemenInfo(skillEffectCalcParam)
  local tHorsemenGridPosition = {}
  for _, info in ipairs(teHorsemenInfo) do
    table.insert(tHorsemenGridPosition, info.entity:GetGridPosition())
  end
  local lsvcBoard = self._world:GetService("BoardLogic")
  local maxLen = math.max(lsvcBoard:GetCurBoardMaxX(), lsvcBoard:GetCurBoardMaxY())
  for _, v2 in ipairs(dir) do
    local pos = v2LocalTeamPos
    for i = 1, maxLen do
      local p = v2LocalTeamPos + v2 * i
      if utilData:IsValidPiecePos(p) then
        pos = p
      else
        break
      end
    end
    table.insert(destPosCandidates, pos)
  end
  if table.Vector2Include(destPosCandidates, teleportEntity:GetGridPosition()) then
  else
    local nRaceType = MonsterRaceType.Land
    if teleportEntity:HasMonsterID() then
      nRaceType = teleportEntity:MonsterID():GetMonsterRaceType()
    end
    local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
    local bodyArea = teleportEntity:BodyArea():GetArea()
    local blockedDestPosCandidates = {}
    for _, candidatePos in ipairs(destPosCandidates) do
      if not table.Vector2Include(tHorsemenGridPosition, candidatePos) then
        if not lsvcBoard:IsPosBlockByArea(candidatePos, nBlockRaceType, bodyArea, teleportEntity) then
          posNew = candidatePos
          break
        else
          table.insert(blockedDestPosCandidates, candidatePos)
        end
      end
    end
    local currentPosSatisfying = false
    if posNew == teleportEntity:GetGridPosition() then
      local utilScope = self._world:GetService("UtilScopeCalc")
      local edgeMax = 0
      local calcByX = false
      local currentMaxX = lsvcBoard:GetCurBoardMaxX()
      local currentMaxY = lsvcBoard:GetCurBoardMaxY()
      if currentMaxX > currentMaxY then
        edgeMax = currentMaxX
        calcByX = true
      else
        edgeMax = currentMaxY
        calcByX = false
      end
      local tEdgeGridInfo = {}
      local tEdgeGrids = {}
      for i = 1, currentMaxX do
        local data = utilScope:GetMinMaxGridYByGridX(i)
        local min = data.min
        local max = data.max
        if min then
          local v2 = fourHorsemenAvoidPlayerGenTheoryEdgeGrid(i, min, true)
          if utilData:IsValidPiecePos(v2) and not self:_IsPosBlockByArea(v2, nBlockRaceType, bodyArea, teleportEntity) then
            table.insert(tEdgeGridInfo, {
              sortIndex = #tEdgeGridInfo,
              v2 = v2,
              distance = Vector2.Distance(v2, v2LocalTeamPos)
            })
            table.insert(tEdgeGrids, v2)
          end
        end
        if max then
          local v2 = fourHorsemenAvoidPlayerGenTheoryEdgeGrid(i, max, true)
          if utilData:IsValidPiecePos(v2) and not self:_IsPosBlockByArea(v2, nBlockRaceType, bodyArea, teleportEntity) then
            table.insert(tEdgeGridInfo, {
              sortIndex = #tEdgeGridInfo,
              v2 = v2,
              distance = Vector2.Distance(v2, v2LocalTeamPos)
            })
            table.insert(tEdgeGrids, v2)
          end
        end
      end
      for i = 1, currentMaxY do
        local data = utilScope:GetMinMaxGridXByGridY(i)
        local min = data.min
        local max = data.max
        if min then
          local v2 = fourHorsemenAvoidPlayerGenTheoryEdgeGrid(i, min, false)
          if utilData:IsValidPiecePos(v2) and not self:_IsPosBlockByArea(v2, nBlockRaceType, bodyArea, teleportEntity) then
            table.insert(tEdgeGridInfo, {
              sortIndex = #tEdgeGridInfo,
              v2 = v2,
              distance = Vector2.Distance(v2, v2LocalTeamPos)
            })
            table.insert(tEdgeGrids, v2)
          end
        end
        if max then
          local v2 = fourHorsemenAvoidPlayerGenTheoryEdgeGrid(i, max, false)
          if utilData:IsValidPiecePos(v2) and not self:_IsPosBlockByArea(v2, nBlockRaceType, bodyArea, teleportEntity) then
            table.insert(tEdgeGridInfo, {
              sortIndex = #tEdgeGridInfo,
              v2 = v2,
              distance = Vector2.Distance(v2, v2LocalTeamPos)
            })
            table.insert(tEdgeGrids, v2)
          end
        end
      end
      if 0 < #tEdgeGridInfo then
        table.sort(tEdgeGridInfo, function(a, b)
          if a.distance ~= b.distance then
            return a.distance < b.distance
          end
          return a.sortIndex < b.sortIndex
        end)
        posNew = tEdgeGridInfo[1].v2 or posNew
      elseif 0 < #blockedDestPosCandidates then
        local centerPos = blockedDestPosCandidates[1]
        local aroundPos = self:_FourHorsemen_GetFirstValidTeleportPosAround(teleportEntity, centerPos)
        posNew = aroundPos or posNew
      end
    end
  end
  return posNew or teleportEntity:GetGridPosition():Clone()
end

function SkillEffectCalc_Teleport:_FindTeleportPos_BossDriller(skillEffectCalcParam, teleportEntity)
  local posNew = teleportEntity:GetGridPosition():Clone()
  local dirNew = teleportEntity:GetGridDirection():Clone()
  local movePosDic = {
    {
      pos = Vector2(1, 1),
      toPos = Vector2(2, 1)
    },
    {
      pos = Vector2(9, 1),
      toPos = Vector2(8, 1)
    },
    {
      pos = Vector2(1, 9),
      toPos = Vector2(2, 9)
    },
    {
      pos = Vector2(9, 9),
      toPos = Vector2(8, 9)
    }
  }
  for index, movePosInfo in ipairs(movePosDic) do
    if posNew == movePosInfo.pos then
      posNew = movePosInfo.toPos
      break
    end
  end
  local boardCenter = Vector2(5, 5)
  if posNew == boardCenter then
    local entityTeam = self._world:Player():GetLocalTeamEntity()
    local targetPos = entityTeam:GetGridPosition()
    dirNew = self:_BossDriller_CalcDir(targetPos, posNew, dirNew)
  else
    dirNew = self:_BossDriller_CalcDir(boardCenter, posNew, dirNew)
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_BossDriller_CalcDir(targetPos, casterPos, oriDir)
  local dirNew = oriDir:Clone()
  if casterPos == targetPos then
  else
    local posOff = targetPos - casterPos
    local xDis = math.abs(posOff.x)
    local yDis = math.abs(posOff.y)
    if xDis > yDis then
      if posOff.x > 0 then
        dirNew = Vector2.right
      else
        dirNew = Vector2.left
      end
    elseif xDis < yDis then
      if posOff.y > 0 then
        dirNew = Vector2.up
      else
        dirNew = Vector2.down
      end
    elseif posOff.y > 0 then
      dirNew = Vector2.up
    elseif posOff.y < 0 then
      dirNew = Vector2.down
    elseif posOff.x > 0 then
      dirNew = Vector2.right
    elseif posOff.x < 0 then
      dirNew = Vector2.left
    end
  end
  return dirNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_NightKingTeleportRecordCalcState(skillEffectCalcParam, teleportEntity, targetEntity)
  local utilDataService = self._world:GetService("UtilData")
  local posNew = teleportEntity:GetGridPosition():Clone()
  local dirNew = teleportEntity:GetGridDirection():Clone()
  local casterPos = teleportEntity:GetGridPosition()
  local targetPos = targetEntity:GetGridPosition()
  self._posCalcState = 0
  local bodyAreaCount = 1
  local onlyMaxRing = true
  local secondRingPosList = ComputeScopeRange.ComputeRange_SquareRing(casterPos, bodyAreaCount, 2, onlyMaxRing)
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  sortPosList:AllowDuplicate()
  for i = 1, #secondRingPosList do
    AINewNode.InsertSortedArray(sortPosList, targetPos, secondRingPosList[i], i)
  end
  local nearestPosData = sortPosList:GetAt(1)
  if nearestPosData then
    local nearestPos = nearestPosData:GetPosData()
    if utilDataService:IsValidPiecePos(nearestPos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, nearestPos) then
      posNew = nearestPos
      self._posCalcState = 1
    else
      local secondValidPosList = {}
      for index, secondRingPos in ipairs(secondRingPosList) do
        local crossDis = math.abs(secondRingPos.x - nearestPos.x) + math.abs(secondRingPos.y - nearestPos.y)
        if crossDis == 1 and utilDataService:IsValidPiecePos(secondRingPos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, secondRingPos) then
          table.insert(secondValidPosList, secondRingPos)
        end
      end
      if 0 < #secondValidPosList then
        posNew = secondValidPosList[1]
        self._posCalcState = 2
      else
        local firstRingPosList = ComputeScopeRange.ComputeRange_SquareRing(casterPos, bodyAreaCount, 1, onlyMaxRing)
        local firstRingSortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
        firstRingSortPosList:AllowDuplicate()
        for i = 1, #firstRingPosList do
          AINewNode.InsertSortedArray(firstRingSortPosList, targetPos, firstRingPosList[i], i)
        end
        local firstRingNearestPosData = sortPosList:GetAt(1)
        if firstRingNearestPosData then
          local firstRingNearestPos = firstRingNearestPosData:GetPosData()
          if utilDataService:IsValidPiecePos(firstRingNearestPos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, firstRingNearestPos) then
            posNew = firstRingNearestPos
            self._posCalcState = 3
          else
            self._posCalcState = 4
          end
        else
        end
      end
    end
  else
  end
  if posNew ~= teleportEntity:GetGridPosition() then
    dirNew = posNew - teleportEntity:GetGridPosition()
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_NightKingDoubleCrossTeleport(skillEffectCalcParam, teleportEntity, targetEntity)
  local utilDataService = self._world:GetService("UtilData")
  local posNew = teleportEntity:GetGridPosition():Clone()
  local dirNew = teleportEntity:GetGridDirection():Clone()
  local targetPos = targetEntity:GetGridPosition()
  local relateDir = posNew - targetPos
  if relateDir.x > 0 then
    relateDir.x = 1
  elseif relateDir.x < 0 then
    relateDir.x = -1
  end
  if 0 < relateDir.y then
    relateDir.y = 1
  elseif 0 > relateDir.y then
    relateDir.y = -1
  end
  local telPos = targetPos + relateDir
  if utilDataService:IsValidPiecePos(telPos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, telPos) then
    posNew = telPos
  else
    local lsvcBoard = self._world:GetService("BoardLogic")
    local ringMax = lsvcBoard:GetCurBoardRingMax()
    for _, v in ipairs(ringMax) do
      local pos = telPos + Vector2.New(v[1], v[2])
      if utilDataService:IsValidPiecePos(pos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, pos) then
        posNew = pos
        break
      end
    end
  end
  if posNew ~= teleportEntity:GetGridPosition() then
    dirNew = posNew - teleportEntity:GetGridPosition()
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_NightKingTeleportWithPath(skillEffectCalcParam, teleportEntity, targetEntity)
  local utilDataService = self._world:GetService("UtilData")
  local bodyAreaCount = 1
  local onlyMaxRing = true
  local pathReturn = {}
  local posNew = teleportEntity:GetGridPosition():Clone()
  local dirNew = teleportEntity:GetGridDirection():Clone()
  local targetPos = targetEntity:GetGridPosition()
  local finalPrePos = posNew
  local telportSEParam = skillEffectCalcParam.skillEffectParam
  local pathTrapID = telportSEParam:GetBossNightKingPathTrapID()
  local utilDataSvc = self._world:GetService("UtilData")
  local trapEntityIDList = utilDataSvc:GetSummonMeantimeLimitEntityID(pathTrapID)
  local finalTrapPos
  if trapEntityIDList and 0 < #trapEntityIDList then
    for index, trapEntityID in ipairs(trapEntityIDList) do
      local trapEntity = self._world:GetEntityByID(trapEntityID)
      if trapEntity then
        local trapPos = trapEntity:GetGridPosition()
        finalTrapPos = trapPos
        table.insert(pathReturn, trapPos)
      end
    end
  end
  if finalTrapPos then
    finalPrePos = finalTrapPos
  end
  local finalTargetPosList = {
    targetPos + Vector2.up,
    targetPos + Vector2.down,
    targetPos + Vector2.left,
    targetPos + Vector2.right
  }
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
  sortPosList:AllowDuplicate()
  for i = 1, #finalTargetPosList do
    AINewNode.InsertSortedArray(sortPosList, finalPrePos, finalTargetPosList[i], i)
  end
  local targetCrossValidPos
  for i = 1, sortPosList:Size() do
    local sortPosData = sortPosList:GetAt(i)
    local sortPos = sortPosData:GetPosData()
    if utilDataService:IsValidPiecePos(sortPos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, sortPos) then
      targetCrossValidPos = sortPos
      break
    end
  end
  if targetCrossValidPos then
    posNew = targetCrossValidPos
    table.insert(pathReturn, posNew)
  else
    local targetFirstRingSortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
    targetFirstRingSortPosList:AllowDuplicate()
    local targetFirstRingValidPosList = {}
    local targetFirstRingPosList = ComputeScopeRange.ComputeRange_SquareRing(targetPos, bodyAreaCount, 1, onlyMaxRing)
    for i = 1, #targetFirstRingPosList do
      AINewNode.InsertSortedArray(targetFirstRingSortPosList, finalPrePos, targetFirstRingPosList[i], i)
      local pos = targetFirstRingPosList[i]
      if utilDataService:IsValidPiecePos(pos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, pos) then
        table.insert(targetFirstRingValidPosList, pos)
      end
    end
    if 0 < #targetFirstRingValidPosList then
      local randomSvc = self._world:GetService("RandomLogic")
      local randIndex = randomSvc:LogicRand(1, #targetFirstRingValidPosList)
      posNew = targetFirstRingValidPosList[randIndex]
      table.insert(pathReturn, posNew)
    else
      local sortPosData = targetFirstRingSortPosList:GetAt(1)
      local targetFirstRingNearestPos = sortPosData:GetPosData()
      local lsvcBoard = self._world:GetService("BoardLogic")
      local ringMax = lsvcBoard:GetCurBoardRingMax()
      for _, v in ipairs(ringMax) do
        local pos = targetFirstRingNearestPos + Vector2.New(v[1], v[2])
        if utilDataService:IsValidPiecePos(pos) and utilDataService:IsMonsterCanTel2TargetPos(teleportEntity, pos) then
          posNew = pos
          table.insert(pathReturn, posNew)
          break
        end
      end
    end
  end
  self._renderTeleportPath = pathReturn
  return posNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_TargetTeleportSelectPos(skillEffectCalcParam, targetEntity)
  local skillEffectParam_Teleport = skillEffectCalcParam.skillEffectParam
  local point = skillEffectParam_Teleport:GetUserPoint()
  local dir = skillEffectParam_Teleport:GetUserDir() or {0, 0}
  local posNew = Vector2(point[1], point[2])
  local dirNew = Vector2(dir[1], dir[2])
  local nRaceType = MonsterRaceType.Land
  if targetEntity:HasMonsterID() then
    nRaceType = targetEntity:MonsterID():GetMonsterRaceType()
  end
  local bodyArea = targetEntity:BodyArea():GetArea()
  local targetEntityOldPos = targetEntity:GetGridPosition()
  local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local bPosBlock = boardServiceLogic:IsPosBlockByArea(posNew, nBlockRaceType, bodyArea, targetEntity)
  if not bPosBlock then
    return posNew, dirNew
  end
  local posList = ComputeScopeRange.ComputeRange_SquareRing(posNew, table.count(bodyArea), 1)
  table.sort(posList, function(a, b)
    local disA = Vector2.Distance(targetEntityOldPos, a)
    local disB = Vector2.Distance(targetEntityOldPos, b)
    return disA < disB
  end)
  for _, pos in ipairs(posList) do
    local curPosBlock = boardServiceLogic:IsPosBlockByArea(pos, nBlockRaceType, bodyArea, targetEntity)
    if not curPosBlock then
      return posNew, dirNew
    end
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Boss2905701Move(teleportEntity, teleportParam)
  local posNew
  local trapID = teleportParam:GetBoss2905701MoveTrapID()
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  local trapEntity
  for _, e in ipairs(globalTrapEntities) do
    if e:Trap():GetTrapID() == trapID then
      trapEntity = e
      break
    end
  end
  local playerTeamPos
  if trapEntity then
    local trapGridPos = trapEntity:GetGridPosition()
    local trapBodyArea = trapEntity:BodyArea():GetArea()
    local playerTeamEntity = self._world:Player():GetLocalTeamEntity()
    playerTeamPos = playerTeamEntity:GetGridPosition()
    local teleportEntityBodyArea = teleportEntity:BodyArea():GetArea()
    local trapAreas = {}
    for _, trapBodyPos in ipairs(trapBodyArea) do
      local bodyPos = trapGridPos + trapBodyPos
      table.insert(trapAreas, bodyPos)
    end
    local lowestDistance = 999
    local lowestDistancePosArray = {}
    for _, trapBodyPos in ipairs(trapBodyArea) do
      local testPos = trapGridPos + trapBodyPos
      local dis = 999
      local isQualified = true
      for _, teleportBodyPos in ipairs(teleportEntityBodyArea) do
        local v2 = testPos + teleportBodyPos
        if not table.Vector2Include(trapAreas, v2) then
          isQualified = false
          break
        end
        dis = math.min(dis, Vector2.Distance(v2, playerTeamPos))
      end
      if isQualified then
        if lowestDistance > dis then
          lowestDistancePosArray = {testPos}
          lowestDistance = dis
        elseif lowestDistance == dis then
          table.insert(lowestDistancePosArray, testPos)
        end
      end
    end
    if #lowestDistancePosArray <= 0 then
      posNew = nil
    else
      local teleportEntityGridPos = teleportEntity:GetGridPosition()
      if table.Vector2Include(lowestDistancePosArray, teleportEntityGridPos) then
        posNew = nil
      elseif #lowestDistancePosArray == 1 then
        posNew = lowestDistancePosArray[1]
      else
        local randsvc = self._world:GetService("RandomLogic")
        local luckyNum = randsvc:LogicRand(1, #lowestDistancePosArray)
        posNew = lowestDistancePosArray[luckyNum]
      end
    end
  else
    posNew = nil
  end
  posNew = posNew or teleportEntity:GetGridPosition():Clone()
  local dirNew = teleportEntity:GetGridDirection()
  if playerTeamPos then
    local bodyArea = teleportEntity:BodyArea():GetArea()
    dirNew = self:GetDirInFour(posNew, playerTeamPos, bodyArea)
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:GetDirInFour(centerPos, targetPos, centerBodyArea)
  local center = centerPos
  if centerBodyArea and 1 < #centerBodyArea then
    local nearest = centerPos
    local nearestRelative = Vector2(0, 0)
    local distance = Vector2.Distance(centerPos, targetPos)
    local minDis = distance
    for _, v2Relative in ipairs(centerBodyArea) do
      local v2 = centerPos + v2Relative
      local curDis = Vector2.Distance(v2, targetPos)
      if minDis > curDis then
        minDis = curDis
        nearest = v2
        nearestRelative = v2Relative
      end
    end
    center = nearest
  end
  local vectors = {
    Vector2(-1, 0),
    Vector2(1, 0),
    Vector2(0, -1),
    Vector2(0, 1)
  }
  local minIdx, minAngle = 1, 180
  local vec = targetPos - center
  for i, v in ipairs(vectors) do
    local angle = Vector2.Angle(vec, v)
    if minAngle > angle then
      minAngle = angle
      minIdx = i
    end
  end
  return vectors[minIdx]
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Boss2905701BackToPos(teleportEntity, teleportParam)
  return teleportParam:GetBoss2905701BackToPos()
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Boss2905701MovePlayerToTrap(teleportEntity, teleportParam)
  local posNew
  local trapIDArray = teleportParam:GetBoss2905701MovePlayerToTrapIDArray()
  local utilData = self._world:GetService("UtilData")
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  local trapEntityArray = {}
  for _, e in ipairs(globalTrapEntities) do
    if table.icontains(trapIDArray, e:Trap():GetTrapID()) and not utilData:IsPosBlock(e:GetGridPosition(), BlockFlag.LinkLine) then
      table.insert(trapEntityArray, e)
    end
  end
  if 0 < #trapEntityArray then
    if 1 < #trapEntityArray then
      local randsvc = self._world:GetService("RandomLogic")
      local luckyNum = randsvc:LogicRand(1, #trapEntityArray)
      posNew = trapEntityArray[luckyNum]:GetGridPosition()
    else
      posNew = trapEntityArray[1]:GetGridPosition()
    end
  else
    local utilScope = self._world:GetService("UtilScopeCalc")
    local emptyPiecesArray = utilScope:GetEmptyPieces()
    if #emptyPiecesArray ~= 0 then
      if 1 < #emptyPiecesArray then
        local randsvc = self._world:GetService("RandomLogic")
        local luckyNum = randsvc:LogicRand(1, #emptyPiecesArray)
        posNew = emptyPiecesArray[luckyNum]
      else
        posNew = emptyPiecesArray[1]
      end
    end
  end
  posNew = posNew or teleportEntity:GetGridPosition():Clone()
  return posNew
end

function SkillEffectCalc_Teleport:_FindSkillRangeFixed4(skillEffectParam, entityCaster, posCaster, nSkillID, skillRangePos)
  return self._skillEffectService:FindSkillRangeFixed4(posCaster, skillRangePos)
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Monster2003801(entityWork, skillEffectCalcParam)
  local posNew = entityWork:GetGridPosition():Clone()
  local dirNew = entityWork:GetGridDirection():Clone()
  local teleportParam = skillEffectCalcParam.skillEffectParam
  local checkSkillID = teleportParam:GetMonster2003801CheckSkillID()
  if checkSkillID then
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    local teamPos = teamEntity:GetGridPosition()
    local targetCenterPos = teamPos
    local bodyAreaCmpt = teamEntity:BodyArea()
    local casterPos = entityWork:GetGridPosition()
    local canAttackRange = self:ComputeSkillRange(checkSkillID, targetCenterPos, bodyAreaCmpt:GetArea())
    local canReachRange = skillEffectCalcParam.skillRange
    local validSkillRange = self:_FilterSkillRangePos_Monster2003801(canAttackRange, canReachRange)
    if validSkillRange and 0 < #validSkillRange then
      posNew = self:_FindTeleportPos_FarFromPlayer(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, validSkillRange)
    else
      posNew = self:_FindTeleportPos_NearFromPlayer(skillEffectCalcParam.skillEffectParam, entityWork, skillEffectCalcParam.gridPos, skillEffectCalcParam.skillID, skillEffectCalcParam.skillRange)
    end
    local bodyArea = entityWork:BodyArea():GetArea()
    dirNew = self:GetDirInFour(posNew, teamPos, bodyArea)
  end
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_FilterSkillRangePos_Monster2003801(canAttackRange, canReachRange)
  local retRange = {}
  for _, pos in ipairs(canAttackRange) do
    for _, canReachPos in ipairs(canReachRange) do
      if canReachPos == pos then
        table.insert(retRange, pos)
        break
      end
    end
  end
  return retRange
end

function SkillEffectCalc_Teleport:_FindTeleportPos_Boss2906201(entityWork, skillEffectCalcParam)
  local posNew = entityWork:GetGridPosition():Clone()
  local dirNew = entityWork:GetGridDirection():Clone()
  local teleportParam = skillEffectCalcParam.skillEffectParam
  local bodyArea = entityWork:BodyArea():GetArea()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local edgeRingScopeRes = skillCalc:ComputeScopeRange(SkillScopeType.WalkableGridOnEdge, {0, 1}, posNew, bodyArea, nil, nil, posNew)
  local edgeRingPosList = edgeRingScopeRes:GetAttackRange()
  local entityTeam = self._world:Player():GetLocalTeamEntity()
  local posTeam = entityTeam:GetGridPosition()
  local teamBodyArea = entityTeam:BodyArea():GetArea()
  local teamRoundRingScopeRes = skillCalc:ComputeScopeRange(SkillScopeType.SquareRing, {2, 1}, posTeam, teamBodyArea, nil, nil, posTeam)
  local teamRoundRingPosList = teamRoundRingScopeRes:GetAttackRange()
  local excludePosList = {}
  table.appendArray(excludePosList, edgeRingPosList)
  table.appendArray(excludePosList, teamRoundRingPosList)
  table.insert(excludePosList, posNew)
  local excludePosIndexDic = {}
  for index, excludePos in ipairs(excludePosList) do
    local posIdx = Vector2.Pos2Index(excludePos)
    excludePosIndexDic[posIdx] = 1
  end
  local canLandPosList = utilScopeSvc:GetFullScreenNoBlockRange(BlockFlag.MonsterLand)
  local validPosList = {}
  for index, landPos in ipairs(canLandPosList) do
    local landPosIdx = Vector2.Pos2Index(landPos)
    if not excludePosIndexDic[landPosIdx] then
      table.insert(validPosList, landPos)
    end
  end
  local randPos = posNew
  if 0 < #validPosList then
    local randomSvc = self._world:GetService("RandomLogic")
    randPos = validPosList[randomSvc:LogicRand(1, #validPosList)]
  end
  posNew = randPos
  dirNew = self:GetDirInFour(posNew, posTeam, bodyArea)
  return posNew, dirNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_ToTargetPosBolck(entityWork, targetPos, calcDir)
  local utilDataSvc = self._world:GetService("UtilData")
  local posOld = entityWork:GetGridPosition()
  local bodyArea = entityWork:BodyArea():GetArea()
  local isEnd = false
  local posNew = posOld
  while not isEnd do
    local tmpBodyArea = {}
    for _, offset in ipairs(bodyArea) do
      table.insert(tmpBodyArea, posNew + offset)
    end
    posNew = posNew + calcDir
    for _, offset in ipairs(bodyArea) do
      local curPos = posNew + offset
      if not table.icontains(tmpBodyArea, curPos) and utilDataSvc:IsPosBlock(curPos, BlockFlag.MonsterLand) then
        posNew = posNew - calcDir
        isEnd = true
        break
      end
    end
    for _, offset in ipairs(bodyArea) do
      local curPos = posNew + offset
      if not isEnd and not table.icontains(tmpBodyArea, curPos) and curPos == targetPos then
        isEnd = true
        break
      end
    end
  end
  return posNew, calcDir
end

function SkillEffectCalc_Teleport:_FindTeleportPos_AlignTargetX(entityWork, targetEntityID)
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local targetPos = targetEntity:GetGridPosition():Clone()
  local casterPos = entityWork:GetGridPosition():Clone()
  local bodyArea = entityWork:BodyArea():GetArea()
  local dirNew = entityWork:GetGridDirection():Clone()
  for _, offset in ipairs(bodyArea) do
    local tmpPos = casterPos + offset
    if tmpPos.x == targetPos.x then
      return casterPos, dirNew
    end
  end
  targetPos.y = casterPos.y
  local dir = Vector2.left
  if targetPos.x > casterPos.x then
    dir = Vector2.right
  end
  return self:_FindTeleportPos_ToTargetPosBolck(entityWork, targetPos, dir)
end

function SkillEffectCalc_Teleport:_FindTeleportPos_AlignTargetY(entityWork, targetEntityID)
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local targetPos = targetEntity:GetGridPosition():Clone()
  local casterPos = entityWork:GetGridPosition():Clone()
  local bodyArea = entityWork:BodyArea():GetArea()
  local dirNew = entityWork:GetGridDirection():Clone()
  for _, offset in ipairs(bodyArea) do
    local tmpPos = casterPos + offset
    if tmpPos.y == targetPos.y then
      return casterPos, dirNew
    end
  end
  targetPos.x = casterPos.x
  local dir = Vector2.down
  if targetPos.y > casterPos.y then
    dir = Vector2.up
  end
  return self:_FindTeleportPos_ToTargetPosBolck(entityWork, targetPos, dir)
end

function SkillEffectCalc_Teleport:_FindTeleportPos_MultiJumpBack(entityWork, forwardDis, calcDir)
  local utilData = self._world:GetService("UtilData")
  local posOld = entityWork:GetGridPosition()
  local bodyArea = entityWork:BodyArea():GetArea()
  local posNew = posOld
  for i = 1, forwardDis do
    local tmpBodyArea = {}
    for _, offset in ipairs(bodyArea) do
      table.insert(tmpBodyArea, posNew + offset)
    end
    posNew = posNew + calcDir
    if posNew ~= posOld then
      for _, offset in ipairs(bodyArea) do
        local curPos = posNew + offset
        if not table.icontains(tmpBodyArea, curPos) and utilData:IsPosBlock(curPos, BlockFlag.MonsterLand) then
          posNew = posNew - calcDir
          return posNew
        end
      end
    end
  end
  return posNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_AngleFreeLineThroughTeamToEdge(skillEffectCalcParam, teleportEntity)
  local posNew
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local utilData = self._world:GetService("UtilData")
  local teleportParam = skillEffectCalcParam.skillEffectParam
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local teamPos = teamEntity:GetGridPosition()
  local casterPos = teleportEntity:GetGridPosition()
  local casterBodyArea = teleportEntity:BodyArea():GetArea()
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local scopeParam = {}
  local scopeResult = scopeCalculator:ComputeScopeRange(SkillScopeType.AngleFreeLine, scopeParam, teamPos, casterBodyArea, nil, nil, casterPos)
  local attackRange = scopeResult:GetAttackRange()
  
  local function CmpDistancefunc(pos1, pos2)
    local dis1 = Vector2.Distance(casterPos, pos1)
    local dis2 = Vector2.Distance(casterPos, pos2)
    return dis1 > dis2
  end
  
  table.sort(attackRange, CmpDistancefunc)
  local targetPos = attackRange[1]
  if not utilData:IsPosBlock(targetPos, BlockFlag.MonsterLand) then
    return targetPos
  end
  local skillRange = {}
  table.appendArray(skillRange, skillEffectCalcParam.skillRange)
  table.sort(skillRange, CmpDistancefunc)
  for _, pos in ipairs(skillRange) do
    if not utilData:IsPosBlock(pos, BlockFlag.MonsterLand) then
      return pos
    end
  end
  posNew = posNew or teleportEntity:GetGridPosition():Clone()
  return posNew
end

function SkillEffectCalc_Teleport:_FindTeleportPos_ThroughTarget(entityWork, targetEntityID)
  local casterPos = entityWork:GetGridPosition():Clone()
  local oriDir = entityWork:GetGridDirection():Clone()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if not targetEntity then
    return casterPos, oriDir
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local targetPos = targetEntity:GetGridPosition():Clone()
  local moveDir = targetPos - casterPos
  local forward = moveDir.normalized
  local telPos = targetPos + forward
  if utilDataSvc:IsValidPiecePos(telPos) and utilDataSvc:IsMonsterCanTel2TargetPos(entityWork, telPos) then
    local posNew = telPos
    local dirNew = forward
    return posNew, dirNew
  end
  local excludePosList = {}
  table.insert(excludePosList, casterPos)
  local lsvcBoard = self._world:GetService("BoardLogic")
  local ringMax = lsvcBoard:GetCurBoardMaxLen()
  for i = 1, ringMax do
    local bodyAreaCount = 1
    local posList = ComputeScopeRange.ComputeRange_SquareRing(targetPos, bodyAreaCount, i)
    local sortList = {}
    for _, pos in ipairs(posList) do
      local radAngle, ringLen = self:CalcClockWiseRadAngle(forward, targetPos, pos)
      local sortData = {_pos = pos, _rad = radAngle}
      table.insert(sortList, sortData)
    end
    table.sort(sortList, function(a, b)
      return a._rad < b._rad
    end)
    for index, data in ipairs(sortList) do
      local telPos = data._pos
      if not table.icontains(excludePosList, telPos) and utilDataSvc:IsValidPiecePos(telPos) and utilDataSvc:IsMonsterCanTel2TargetPos(entityWork, telPos) then
        local posNew = telPos
        local dirNew = telPos - targetPos
        return posNew, dirNew
      end
    end
  end
  return casterPos, oriDir
end

function SkillEffectCalc_Teleport:CalcClockWiseRadAngle(refvec, origin, point)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local dirVec = point - origin
  local lenVector = utilCalcSvc:GetGridRingNum(point, origin)
  if lenVector == 0 then
    return -math.pi, 0
  end
  local normalized = dirVec.normalized
  local dotprod = normalized.x * refvec.x + normalized.y * refvec.y
  local diffprod = refvec.y * normalized.x - refvec.x * normalized.y
  local angle = math.atan(diffprod, dotprod)
  if angle < 0 then
    return 2 * math.pi + angle, lenVector
  end
  return angle, lenVector
end

function SkillEffectCalc_Teleport:ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  if scopeType == SkillScopeType.DirectLineExpand then
    local ret1 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, 1))
    local ret2 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(0, -1))
    local ret3 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(1, 0))
    local ret4 = self:_ComputeSkillRange(skillID, centerPos, bodyArea, Vector2(-1, 0))
    local ret = {}
    table.appendArray(ret, ret1)
    table.appendArray(ret, ret2)
    table.appendArray(ret, ret3)
    table.appendArray(ret, ret4)
    return ret
  else
    return self:_ComputeSkillRange(skillID, centerPos, bodyArea, dir)
  end
end

function SkillEffectCalc_Teleport:_ComputeSkillRange(nSkillID, posCenter, bodyArea, dir)
  if nSkillID == 0 then
    return {}
  end
  local workCenter = posCenter
  if 4 == #bodyArea then
    workCenter = workCenter + Vector2(-1, -1)
  elseif 9 == #bodyArea then
    workCenter = workCenter + Vector2(-2, -2)
  end
  return self:CalculateSkillRange(nSkillID, workCenter, dir, bodyArea)
end

function SkillEffectCalc_Teleport:CalculateSkillRange(skillID, centerPos, dir, bodyAreaList)
  local skillResult = self:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList)
  if not skillResult then
    return {}
  end
  local skillRange = skillResult:GetAttackRange()
  local listReturn = {}
  for i = 1, #skillRange do
    local posWork = skillRange[i]
    if false == table.icontains(listReturn, posWork) then
      table.insert(listReturn, posWork)
    end
  end
  return listReturn
end

function SkillEffectCalc_Teleport:_CalculateSkillScope(skillID, centerPos, dir, bodyAreaList, entityCaster)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalculater = utilScopeSvc:GetSkillScopeCalc()
  dir = dir or Vector2(0, 1)
  local skillResult = skillCalculater:CalcSkillScope(skillConfigData, centerPos, dir, bodyAreaList, entityCaster)
  return skillResult
end

function SkillEffectCalc_Teleport:_FindTeleportPos_SkillRangeFarNoBlock(skillEffectCalcParam, entityCaster, defenderEntityID)
  local teleportParam = skillEffectCalcParam:GetSkillEffectParam()
  local skillRange = skillEffectCalcParam:GetSkillRange()
  local casterPos = entityCaster:GetGridPosition()
  local defenderEntity = self._world:GetEntityByID(defenderEntityID)
  local defenderPos = defenderEntity:GetGridPosition()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local posMain = teamEntity:GetGridPosition()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByFar)
  sortPosList:AllowDuplicate()
  for i = 1, #skillRange do
    AINewNode.InsertSortedArray(sortPosList, casterPos, skillRange[i], i)
  end
  local retPos
  for i = 1, sortPosList:Size() do
    local sortPosData = sortPosList:GetAt(i)
    local posWork = sortPosData.data
    if posWork ~= defenderPos then
      retPos = posWork
      break
    end
  end
  Log.fatal("Pos:", retPos, "EntityID:", entityCaster:GetID(), "SourcePos:", casterPos)
  local retDir = retPos - casterPos
  return retPos, retDir
end

function SkillEffectCalc_Teleport:_FindTeleportPos_AntiClockWiseOnBoardEdge(skillEffectCalcParam, entityCaster, defenderEntityID)
  local teleportParam = skillEffectCalcParam:GetSkillEffectParam()
  local dis = teleportParam:GetForwardDis()
  local skillRange = skillEffectCalcParam:GetSkillRange()
  local casterPos = entityCaster:GetGridPosition()
  local nRaceType
  if entityCaster:HasMonsterID() then
    nRaceType = entityCaster:MonsterID():GetMonsterRaceType()
  end
  local nBlockRaceType = self._skillEffectService:_TransBlockByRaceType(nRaceType)
  if not nRaceType then
    nBlockRaceType = BlockFlag.LinkLine
  end
  local boardSvc = self._world:GetService("BoardLogic")
  local maxX = boardSvc:GetCurBoardMaxX()
  local maxY = boardSvc:GetCurBoardMaxY()
  local posNew
  local find = false
  local index = 1
  local beginIndex
  for i, pos in ipairs(skillRange) do
    if pos == casterPos then
      beginIndex = i
    end
  end
  local retPos = casterPos
  local rangeLen = #skillRange
  while 0 < dis do
    local teleportIndex
    local newIndex = beginIndex + dis
    if rangeLen >= newIndex then
      teleportIndex = newIndex
    else
      teleportIndex = newIndex % rangeLen
    end
    local tmpPos = skillRange[teleportIndex]
    if not boardSvc:IsPosBlock(tmpPos, nBlockRaceType) then
      retPos = tmpPos
      break
    end
    dis = dis - 1
  end
  Log.fatal("Pos:", retPos, "EntityID:", entityCaster:GetID(), "SourcePos:", casterPos)
  return retPos
end

function SkillEffectCalc_Teleport:_FindTeleportPos_ScopeNearestSelectPos(skillEffectCalcParam, entityWork, targetEntityID)
  local point = skillEffectCalcParam.skillEffectParam:GetUserPoint()
  local selectPos = Vector2(point[1], point[2])
  local skillRange = skillEffectCalcParam.skillRange
  table.sort(skillRange, function(a, b)
    local disA = Vector2.Distance(selectPos, a)
    local disB = Vector2.Distance(selectPos, b)
    return disA < disB
  end)
  local utilData = self._world:GetService("UtilData")
  local posOld = entityWork:GetGridPosition()
  local posNew = posOld
  for _, pos in ipairs(skillRange) do
    if not utilData:IsPosBlock(pos, BlockFlag.MonsterLand) or pos == posOld then
      posNew = pos
      break
    end
  end
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  local targetEntityPos = targetEntity:GetGridPosition()
  local dirNew = targetEntityPos - posNew
  return posNew, dirNew
end
