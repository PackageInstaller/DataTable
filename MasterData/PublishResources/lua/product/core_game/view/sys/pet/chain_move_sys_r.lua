_class("ChainMoveSystem_Render", Object)
ChainMoveSystem_Render = ChainMoveSystem_Render

function ChainMoveSystem_Render:Constructor(world)
  self._world = world
  self.group = world:GetGroup(world.BW_WEMatchers.ChainMove)
  self._configService = world:GetService("Config")
  self._listTrapTask = nil
  self._chainMoveTaskIDs = {}
end

function ChainMoveSystem_Render:Execute()
  if self.group ~= nil then
    self.group:HandleForeach(self, self.UpdateChainMove)
  end
end

function ChainMoveSystem_Render:UpdateChainMove(e)
  if e:MoveFSM():GetMoveFSMCurStateID() ~= PlayerActionStateID.Move then
    return
  end
  local move_cmpt = e:ChainMove()
  local chain_path = move_cmpt:GetChainPath()
  local path_index = move_cmpt:GetPathIndex()
  if path_index > #chain_path then
    e:RemoveChainMove()
    self:_HandlePetMoveEnd(e)
  else
    self:_HandlePetMove(e)
  end
end

function ChainMoveSystem_Render:_HandlePetMoveEnd(e)
  local effectService = self._world:GetService("Effect")
  effectService:ShowChainMoveEffect(e, false)
  e:SetAnimatorControllerBools({Move = false})
  e:SetAnimatorControllerBools({MoveSpecial = false})
  self._world:EventDispatcher():Dispatch(GameEventType.MoveFinish, 2, e:GetID())
  local boardServiceRender = self._world:GetService("BoardRender")
  if #self.group:GetEntities() == 0 then
    local teamEntity = e:Pet():GetOwnerTeamEntity()
    local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
    local position = boardServiceRender:GetRealEntityGridPos(teamLeader)
    local direction = teamLeader:GetDirection()
    local es = teamEntity:Team():GetTeamPetEntities()
    for i, petEntity in ipairs(es) do
      if petEntity:GetID() ~= teamLeader:GetID() then
        petEntity:SetLocation(position, direction)
        petEntity:SetViewVisible(false)
      end
    end
    teamEntity:SetLocation(position, direction)
    self:RemoveCutChainPath()
    teamEntity:RemovePlayerMovingFlag()
  else
    Log.notice("_HandlePetMoveEnd chain path not null")
  end
end

function ChainMoveSystem_Render:_HandlePetMove(e)
  local move_cmpt = e:ChainMove()
  local chain_path = move_cmpt:GetChainPath()
  local path_index = move_cmpt:GetPathIndex()
  local start_time = move_cmpt:GetStartTime()
  local speed = move_cmpt:GetSpeed()
  move_cmpt:SetCurGridPathIndex(path_index)
  local dest_pos = chain_path[path_index]
  local timeService = self._world:GetService("Time")
  local curtime = timeService:GetCurrentTimeMs()
  if start_time > curtime then
    return
  end
  if e:HasGridMove() then
    return
  end
  if e:HasViewExtension() then
    e:SetViewVisible(true)
  end
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  if teamLeader:GetID() ~= e:GetID() and self:_AfterFrontPet(path_index, e) then
    local effectService = self._world:GetService("Effect")
    effectService:ShowChainMoveEffect(e, false)
    e:SetAnimatorControllerBools({Move = false})
    e:SetAnimatorControllerBools({MoveSpecial = false})
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local syncMoveServiceRender = self._world:GetService("SyncMoveRender")
  local autoBeadServiceRender = self._world:GetService("AutoBeadRender")
  local cur_pos = boardServiceRender:GetRealEntityGridPos(e)
  if cur_pos == dest_pos then
    syncMoveServiceRender:OnArriveAtPos(e, path_index, teamEntity)
    self:_ArriveAtPos(e, cur_pos)
  else
    syncMoveServiceRender:OnGridMoveToPos(e, path_index, speed, teamEntity)
    autoBeadServiceRender:OnGridMoveToPos(e, speed, cur_pos, dest_pos, teamEntity)
    self:_GridMoveToPos(e, speed, cur_pos, dest_pos, teamEntity)
  end
end

function ChainMoveSystem_Render:_ArriveAtPos(e, posCur)
  local move_cmpt = e:ChainMove()
  local chain_path = move_cmpt:GetChainPath()
  local path_index = move_cmpt:GetPathIndex()
  local start_time = move_cmpt:GetStartTime()
  local speed = move_cmpt:GetSpeed()
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
  if teamLeader:GetID() == e:GetID() then
    self:_AfterPlayerMoveOneTile(e, path_index, chain_path)
  else
    self:_OnTeamMemberArrivePos(e, path_index, chain_path)
    if path_index == #chain_path then
      e:SetViewVisible(false)
    end
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local timeService = self._world:GetService("Time")
  if teamEntity:HasTeamDeadMark() and teamEntity:TeamDeadMark():GetDeadGridPos() == boardServiceRender:GetRealEntityGridPos(e) then
    move_cmpt:SetPathIndex(#chain_path)
    return
  end
  local trapServiceRender = self._world:GetService("TrapRender")
  if path_index <= #chain_path then
    trapServiceRender:ShowHideTrapByChainMove(posCur, false, e)
    if 1 < path_index and not self:_IsAnyPetAtChainPos(path_index - 1) then
      trapServiceRender:ShowHideTrapByChainMove(chain_path[path_index - 1], true, e)
    end
  end
  if path_index <= #chain_path and path_index == 2 and self:_IsAllPetLeaveChainPos(1) then
    local playBuffSvc = self._world:GetService("PlayBuff")
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      playBuffSvc:PlayBuffView(TT, NTPlayerFirstMoveEnd:New(e, chain_path[1]))
    end)
  end
  path_index = path_index + 1
  move_cmpt:SetPathIndex(path_index)
  move_cmpt:AddPathArriveTime(path_index, timeService:GetCurrentTimeMs())
  local hasNormalAttack = self:_CheckNormalAttack(e)
  if hasNormalAttack == true then
    local effectService = self._world:GetService("Effect")
    effectService:ShowChainMoveEffect(e, false)
    self._world:EventDispatcher():Dispatch(GameEventType.MoveFinish, 1, e:GetID())
  else
    self:UpdateChainMove(e)
  end
end

function ChainMoveSystem_Render:_OnTeamMemberArrivePos(e, path_index, chain_path)
  if path_index < 1 then
    return
  end
  local last_pos = chain_path[path_index]
  local ntPlayerEachMoveEnd = NTPlayerEachMoveEnd:New(e, last_pos, nil, nil, path_index)
  local playBuffSvc = self._world:GetService("PlayBuff")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    playBuffSvc:PlayBuffView(TT, ntPlayerEachMoveEnd)
  end)
end

function ChainMoveSystem_Render:_CheckNormalAttack(e)
  local boardServiceRender = self._world:GetService("BoardRender")
  local pathNormalAttackData = self:_GetPetNormalAttackData(e)
  local position = boardServiceRender:GetRealEntityGridPos(e)
  local pathPointAttackData = pathNormalAttackData:GetPathPointAttackData(position)
  if pathPointAttackData == nil then
    Log.fatal("no pathPointAttackData:", e:GetID(), " pos ", position.x, " ", position.y)
    return false
  else
    local pathPointAttackCount = pathPointAttackData:GetPathPointAttackCount()
    if 0 < pathPointAttackCount then
      return true
    end
  end
end

function ChainMoveSystem_Render:_GetPetNormalAttackData(e)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local normalAtkResCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
  local pathNormalAttackData = normalAtkResCmpt:GetPetNormalAttackResult(e:GetID())
  return pathNormalAttackData
end

function ChainMoveSystem_Render:_GridMoveToPos(e, speed, curPos, destPos, teamEntity)
  local effectService = self._world:GetService("Effect")
  effectService:ShowChainMoveEffect(e, true)
  local utilDataSvc = self._world:GetService("UtilData")
  local normalSkillBeforeMove = utilDataSvc:GetEntityBuffValue(e, "NormalSkillBeforeMove")
  if normalSkillBeforeMove then
    e:SetAnimatorControllerBools({MoveSpecial = true})
  else
    e:SetAnimatorControllerBools({Move = true})
  end
  e:SetDirection(destPos - curPos)
  local boardServiceRender = self._world:GetService("BoardRender")
  local gridPos = boardServiceRender:GetRealEntityGridPos(e)
  e:AddGridMove(speed, destPos, gridPos)
  local move_cmpt = e:ChainMove()
  local chain_path = move_cmpt:GetChainPath()
  local path_index = move_cmpt:GetPathIndex()
  local leader = teamEntity:GetTeamLeaderPetEntity()
  if leader:GetID() == e:GetID() then
    self:_RemoveLinkageNum(path_index)
    self:_RemoveLinkLine(path_index)
  end
  local chainPathPoint = chain_path[path_index]
  local utilData = self._world:GetService("UtilData")
  local pieceType = utilData:FindPieceElement(chainPathPoint)
  local playbufsvc = self._world:GetService("PlayBuff")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    playbufsvc:PlayBuffView(TT, NTPlayerEachMoveStart:New(e, chainPathPoint, pieceType, path_index))
    if leader:GetID() == e:GetID() then
      playbufsvc:PlayBuffView(TT, NTTeamLeaderEachMoveStart:New(e, chainPathPoint, pieceType))
      playbufsvc:PlayBuffView(TT, NTTeamEachMoveStart:New(teamEntity, chainPathPoint, pieceType))
    end
  end)
end

function ChainMoveSystem_Render:_AfterFrontPet(pathIndex, e)
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  local myIndex = 1
  for i, petEntityID in ipairs(petRoundTeam) do
    if e:GetID() == petEntityID then
      myIndex = i
      break
    end
  end
  local timeService = self._world:GetService("Time")
  if myIndex ~= 1 then
    local PrePetEntityID = petRoundTeam[myIndex - 1]
    local petEntity = self._world:GetEntityByID(PrePetEntityID)
    local preChainMoveComponent = petEntity:ChainMove()
    if petEntity:ChainMove() then
      local chainMoveComponent = e:ChainMove()
      local renderBoardEntity = self._world:GetRenderBoardEntity()
      local normalAtkCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
      local attackCount = table.count(normalAtkCmpt:GetPlayNormalSkillSequence())
      if attackCount == 0 then
        return false
      end
      local index = petEntity:ChainMove():GetCurGridPathIndex()
      if index ~= 0 and pathIndex > index then
        if not chainMoveComponent:IsWait() then
          chainMoveComponent:SetWaitState(true)
        end
        return true
      else
        local canMoveTime = chainMoveComponent:GetCanMoveTime()
        if canMoveTime == 0 then
          local targetPathIndex = pathIndex + 1
          local prePetArriveTime = preChainMoveComponent:GetPathArriveTime(targetPathIndex)
          if not prePetArriveTime then
            return true
          end
          local waitAttactTime = normalAtkCmpt:GetNormalSkillWaitTimeDic(myIndex, pathIndex)
          if waitAttactTime < 0 then
            waitAttactTime = 0
          end
          waitAttactTime = waitAttactTime * 1000
          local startWaitTime = normalAtkCmpt:GetPathMoveStartWaitTime() * 1000
          canMoveTime = prePetArriveTime + waitAttactTime + startWaitTime
          chainMoveComponent:SetCanMoveTime(canMoveTime)
        end
        canMoveTime = chainMoveComponent:GetCanMoveTime()
        if canMoveTime < timeService:GetCurrentTimeMs() then
          chainMoveComponent:SetWaitState(false)
          chainMoveComponent:SetCanMoveTime(0)
          return false
        else
          return true
        end
      end
    end
  else
    return false
  end
end

function ChainMoveSystem_Render:_HasPetOnNextPathPoint(pathIndex)
  for i, ee in ipairs(self.group:GetEntities()) do
    if ee:ChainMove():GetPathIndex() == pathIndex + 1 then
      return true
    end
  end
end

function ChainMoveSystem_Render:_IsAllPetLeaveChainPos(chainIdx)
  for i, ee in ipairs(self.group:GetEntities()) do
    if chainIdx >= ee:ChainMove():GetPathIndex() then
      return false
    end
  end
  return true
end

function ChainMoveSystem_Render:_IsAnyPetAtChainPos(chainIdx)
  for i, ee in ipairs(self.group:GetEntities()) do
    if ee:ChainMove():GetPathIndex() == chainIdx then
      return true
    end
  end
  return false
end

function ChainMoveSystem_Render:_AfterPlayerMoveOneTile(e, pathIndex, chainPath)
  if pathIndex < 1 then
    return
  end
  local last_pos = chainPath[pathIndex]
  local pieceSvc = self._world:GetService("Piece")
  local pieceEntity = pieceSvc:FindPieceEntity(last_pos)
  if self:_IsNeedHidePiece(pathIndex, chainPath) then
    pieceEntity:SetViewVisible(false)
  else
    self._world:GetService("Piece"):SetPieceAnimMoveDone(last_pos)
  end
  local teamEntity = e:Pet():GetOwnerTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  teamEntity:SetLocation(last_pos, teamLeaderEntity:GetRenderGridDirection())
  local utilData = self._world:GetService("UtilData")
  local pieceType = utilData:FindPieceElement(last_pos)
  local pieceEffectType = PieceEffectType.Normal
  if utilData:IsPrismPiece(last_pos) then
    pieceEffectType = utilData:GetBoardPieceEffectType(last_pos)
  end
  local playBuffSvc = self._world:GetService("PlayBuff")
  local ntPlayerEachMoveEnd = NTPlayerEachMoveEnd:New(e, last_pos, pieceType, nil, pathIndex)
  ntPlayerEachMoveEnd:SetPieceEffectType(pieceEffectType)
  local ntPetChainMoveBegin
  if pathIndex == 1 then
    ntPetChainMoveBegin = NTPetChainMoveBegin:New(e, last_pos, pieceType, nil, pathIndex)
    ntPetChainMoveBegin:SetPieceEffectType(pieceEffectType)
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    if ntPetChainMoveBegin then
      playBuffSvc:PlayBuffView(TT, ntPetChainMoveBegin)
    end
    playBuffSvc:PlayBuffView(TT, ntPlayerEachMoveEnd)
    if teamLeaderEntity:GetID() == e:GetID() then
      local ntTeamLeaderEachMoveEnd = NTTeamLeaderEachMoveEnd:New(e, last_pos, pieceType)
      ntTeamLeaderEachMoveEnd:SetPieceEffectType(pieceEffectType)
      playBuffSvc:PlayBuffView(TT, ntTeamLeaderEachMoveEnd)
      local ntTeamEachMoveEnd = NTTeamEachMoveEnd:New(teamEntity, last_pos, pieceType)
      ntTeamEachMoveEnd:SetPieceEffectType(pieceEffectType)
      playBuffSvc:PlayBuffView(TT, ntTeamEachMoveEnd)
    end
  end)
  if 1 < pathIndex then
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local normalAtkCmpt = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
    local triggerTraps = normalAtkCmpt:GetChainPathTriggerTrap(pathIndex)
    local trapServiceRender = self._world:GetService("TrapRender")
    if triggerTraps then
      trapServiceRender:ChainMovePlayTrapTrigger(triggerTraps, e)
    end
  end
end

function ChainMoveSystem_Render:IsChainPathFstPos(targetEntity, pos)
  local cChainMove = targetEntity:ChainMove()
  local chainPath = cChainMove:GetChainPath()
  if chainPath and table.count(chainPath) > 0 then
    return pos == chainPath[1]
  end
  return false
end

function ChainMoveSystem_Render:_RemoveLinkageNum(index)
  local entityPoolService = self._world:GetService("EntityPool")
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkageNumEntityList()
  local linkageRenderService = self._world:GetService("LinkageRender")
  local remove_list = {}
  for _, linkageNumEntity in ipairs(allEntities) do
    local linkageNumCmp = linkageNumEntity:LinkageNum()
    if linkageNumCmp:GetLinkageIndex() == index then
      linkageRenderService:DestroyLinkNum(linkageNumEntity)
      return
    end
  end
end

function ChainMoveSystem_Render:_RemoveLinkLine(index)
  local entityPoolService = self._world:GetService("EntityPool")
  local linkageRenderService = self._world:GetService("LinkageRender")
  local reBoard = self._world:GetRenderBoardEntity()
  local linkRendererDataCmpt = reBoard:LinkRendererData()
  local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
  for _, linkLineEntity in ipairs(allEntities) do
    local LinkLineIndex = linkLineEntity:LinkLineIndex()
    if LinkLineIndex:GetPathIndex() == index then
      linkageRenderService:DestroyLinkLine(linkLineEntity)
      return
    end
  end
end

function ChainMoveSystem_Render:RemoveCutChainPath()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local renderChainPathCmpt = renderBoardEntity:RenderChainPath()
  local cutRenderChainPath = renderChainPathCmpt:GetRenderCutChainPath()
  local pieceServiceRender = self._world:GetService("Piece")
  local sBoardRender = self._world:GetService("BoardRender")
  local ePreview = self._world:GetPreviewEntity()
  for index, pos in pairs(cutRenderChainPath) do
    self:_RemoveLinkageNum(index)
    self:_RemoveLinkLine(index)
    pieceServiceRender:SetPieceAnimNormal(pos)
  end
  if cutRenderChainPath then
    local indexArray = {}
    for index, pos in pairs(cutRenderChainPath) do
      table.insert(indexArray, index)
    end
    table.sort(indexArray, function(a, b)
      return b < a
    end)
    for _, tarIndex in ipairs(indexArray) do
      local pos = cutRenderChainPath[tarIndex]
      if ePreview then
        local cPreviewEnv = ePreview:PreviewEnv()
        if cPreviewEnv and cPreviewEnv:IsPrismPiece(pos) then
          sBoardRender:UnapplyPrism(pos)
        end
      end
    end
  end
end

function ChainMoveSystem_Render:_IsNeedHidePiece(index, chainPath)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsPieceRefreshTypeDestroy() then
    return false
  end
  if utilDataSvc:GetStatIsRoundAuroraTime() then
    return false
  end
  if index == #chainPath then
    return false
  end
  local pos = chainPath[index]
  if utilDataSvc:GetMonsterAtPos(pos) then
    return false
  end
  return true
end
