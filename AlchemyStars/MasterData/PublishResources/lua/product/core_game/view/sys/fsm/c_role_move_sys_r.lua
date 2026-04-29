require("role_movement_system")
_class("ClientRoleMovementSystem_Render", RoleMovementSystem)
ClientRoleMovementSystem_Render = ClientRoleMovementSystem_Render

function ClientRoleMovementSystem_Render:_DoRenderPetHeadShow(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  for i, eId in ipairs(petRoundTeam) do
    local pet = self._world:GetEntityByID(eId)
    local cPetPstId = pet:PetPstID()
    self._world:EventDispatcher():Dispatch(GameEventType.InOutQueue, cPetPstId:GetPstID(), true)
  end
  local chainPreviewMonsterBehaviorCmpt = renderBoardEntity:ChainPreviewMonsterBehavior()
  chainPreviewMonsterBehaviorCmpt:SetChainPath({})
end

function ClientRoleMovementSystem_Render:_DoRendererMove(TT, team)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chain_path = renderBoardEntity:RenderChainPath():GetRenderChainPath()
  local teamLeaderEntity = team:GetTeamLeaderPetEntity()
  if not teamLeaderEntity:HasChainMove() then
    local petRoundTeam = self:_GetRoleTurnPetRoundTeam()
    if 0 < #petRoundTeam then
      local startPos = teamLeaderEntity:GetRenderGridPosition()
      local utilDataSvc = self._world:GetService("UtilData")
      if utilDataSvc:IsActiveSkillLinkLine() then
        startPos = chain_path[1]
      end
      local startDir = teamLeaderEntity:GetRenderGridDirection()
      for i, petEntityID in ipairs(petRoundTeam) do
        local petEntity = self._world:GetEntityByID(petEntityID)
        petEntity:AddChainMove({}, 0, 0, 0)
      end
      team:ReplacePlayerMovingFlag()
      TaskManager:GetInstance():CoreGameStartTask(self._PetMoveTask, self, chain_path, startPos, startDir)
    end
  end
  while team:HasPlayerMovingFlag() do
    YIELD(TT, 100)
  end
end

function ClientRoleMovementSystem_Render:_PetMoveTask(TT, chain_path, startPos, startDir)
  local petRoundTeam = self:_GetRoleTurnPetRoundTeam()
  for i, petEntityID in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(petEntityID)
    petEntity:SetLocation(startPos, startDir)
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local normalAtkRes = renderBoardEntity:LogicResult():GetLogicResult(LogicStepType.NormalAttack)
    local startWaitTime = normalAtkRes:GetPathMoveStartWaitTime() * 1000
    if 1 < i then
      while self:IsPrevPetsAtStartPos(i, startPos, petRoundTeam) do
        YIELD(TT)
      end
    end
    local timeService = self._world:GetService("Time")
    local curtime = timeService:GetCurrentTimeMs()
    petEntity:ReplaceChainMove(chain_path, 1, curtime, BattleConst.MoveSpeed)
    self._world:EventDispatcher():Dispatch(GameEventType.IdleEnd, 1, petEntity:GetID())
    YIELD(TT, startWaitTime)
  end
end

function ClientRoleMovementSystem_Render:IsPrevPetsAtStartPos(curIdx, startPos, es)
  if not es then
    return
  end
  local boardServiceRender = self._world:GetService("BoardRender")
  local nCount = math.min(#es, curIdx - 1)
  for i = 1, nCount do
    local e = self._world:GetEntityByID(es[i])
    local posWork = boardServiceRender:GetRealEntityGridPos(e)
    if posWork == startPos then
      local chainMoveCmp = e:ChainMove()
      if chainMoveCmp and chainMoveCmp:GetPathIndex() == 1 then
        return true
      end
    end
  end
end

function ClientRoleMovementSystem_Render:_GetRoleTurnPetRoundTeam()
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  return petRoundTeam
end

function ClientRoleMovementSystem_Render:_DoRenderNotifyBuff(TT, elementType, teamEntity)
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTTeamNormalAttackStart:New())
  local ntPlayerMoveStart = NTPlayerMoveStart:New()
  ntPlayerMoveStart:SetChainPathType(elementType)
  ntPlayerMoveStart:SetTeamEntity(teamEntity)
  playBuffSvc:PlayBuffView(TT, ntPlayerMoveStart)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  local chain_path = renderBoardEntity:RenderChainPath():GetRenderChainPath()
  for i, eId in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(eId)
    playBuffSvc:PlayBuffView(TT, NTNormalAttackStart:New(petEntity, elementType, chain_path))
  end
end

function ClientRoleMovementSystem_Render:_DoRenderNotifyBuffNormalAttackEnd(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  for i, eId in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(eId)
    playBuffSvc:PlayBuffView(TT, NTNormalAttackEnd:New(petEntity))
  end
end

function ClientRoleMovementSystem_Render:_DoRenderResetPieceAnim(TT)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
end

function ClientRoleMovementSystem_Render:_SendPrismNotify(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTCovCrystalPrism:New())
end

function ClientRoleMovementSystem_Render:_DoRenderFeatureOnRoleMoveEnter(TT)
  local featureSvcRender = self._world:GetService("FeatureRender")
  if featureSvcRender then
    featureSvcRender:DoFeatureOnRoleMoveEnter(TT)
  end
end

function ClientRoleMovementSystem_Render:_DoRenderCreateActiveLinkLineGhost(TT, teamEntity)
  local utilDataSvc = self._world:GetService("UtilData")
  if not utilDataSvc:IsPreviewNeedShowLinkageNumForCostStep() then
    return
  end
  local teamCmpt = teamEntity:Team()
  local teamLeaderEntityID = teamCmpt:GetOriginalTeamLeaderID()
  local teamLeaderEntity = teamCmpt:GetTeamLeaderEntity()
  local teamEntities = teamCmpt:GetTeamPetEntities()
  if teamLeaderEntityID then
    teamLeaderEntity = self._world:GetEntityByID(teamLeaderEntityID)
  end
  teamEntity:Location():SetSyncToHPBarState(false)
  local teamPos = utilDataSvc:GetRenderActiveSkillLinkLineTeamPos()
  local boardEntity = self._world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local renderEntitySvc = self._world:GetService("RenderEntity")
  local ghostEntity = renderEntitySvc:CreateGhost(teamPos, teamLeaderEntity)
  renderBoardCmpt:SetActiveLinkLineGhostEntityID(ghostEntity:GetID())
  utilDataSvc:SetPet1702361TrapHide()
end
