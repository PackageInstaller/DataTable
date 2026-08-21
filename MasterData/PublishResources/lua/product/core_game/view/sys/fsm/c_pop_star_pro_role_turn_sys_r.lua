require("pop_star_pro_role_turn_system")
_class("PopStarProRoleTurnSystem_Render", PopStarProRoleTurnSystem)
PopStarProRoleTurnSystem_Render = PopStarProRoleTurnSystem_Render

function PopStarProRoleTurnSystem_Render:_DoRenderPetHeadShow(TT)
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local chainPreviewMonsterBehaviorCmpt = renderBoardEntity:ChainPreviewMonsterBehavior()
  chainPreviewMonsterBehaviorCmpt:SetChainPath({})
end

function PopStarProRoleTurnSystem_Render:_DoRendererTeleport(TT, teamEntity)
  local oldPos = teamEntity:GetRenderGridPosition()
  local dir = teamEntity:GetRenderGridDirection()
  local newPos = teamEntity:GetGridPosition()
  local teleportSkillRes = SkillEffectResult_Teleport:New(teamEntity:GetID(), oldPos, PieceType.None, newPos, dir, 1)
  self:Teleport(TT, teamEntity, RoleShowType.TeleportHide, teleportSkillRes)
  self:Teleport(TT, teamEntity, RoleShowType.TeleportMove, teleportSkillRes)
  YIELD(TT, 1000)
  self:Teleport(TT, teamEntity, RoleShowType.TeleportShow, teleportSkillRes)
end

function PopStarProRoleTurnSystem_Render:Teleport(TT, teamEntity, showType, teleportEffectResult)
  local trapServiceRender = self._world:GetService("TrapRender")
  if RoleShowType.TeleportHide == showType then
    local oldPos = teleportEffectResult:GetPosOld()
    self:_RoleShow(teamEntity, false, false)
    trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  elseif RoleShowType.TeleportMove == showType then
    self:_TeleportTargetPos(TT, teamEntity, teleportEffectResult)
  elseif RoleShowType.TeleportShow == showType then
    local newPos = teleportEffectResult:GetPosNew()
    self:_RoleShow(teamEntity, true, true)
    trapServiceRender:ShowHideTrapAtPos(newPos, false)
    local pieceService = self._world:GetService("Piece")
    pieceService:RemovePrismAt(newPos)
  end
end

function PopStarProRoleTurnSystem_Render:_RoleShow(teamEntity, bShowRole, bShowBloodSlider, noActiveModel)
  if not noActiveModel then
    teamEntity:SetViewVisible(bShowRole)
  else
    teamEntity:SetLocationHeight(1000)
  end
  local slider_entity_id = teamEntity:HP():GetHPSliderEntityID()
  local slider_entity = self._world:GetEntityByID(slider_entity_id)
  if slider_entity then
    slider_entity:SetViewVisible(bShowBloodSlider)
  end
end

function PopStarProRoleTurnSystem_Render:_TeleportTargetPos(TT, teamEntity, skillResult)
  if nil == teamEntity then
    return
  end
  local posNew = skillResult:GetPosNew()
  if nil == posNew then
    return
  end
  local dirNew = skillResult:GetDirNew()
  local casterDir
  if dirNew then
    casterDir = dirNew
  else
    casterDir = teamEntity:GridLocation().Direction
  end
  teamEntity:SetLocation(posNew, casterDir)
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, petEntity in ipairs(pets) do
    petEntity:SetLocation(posNew, casterDir)
  end
end

function PopStarProRoleTurnSystem_Render:_DoRenderNotifyBuff(TT, elementType, teamEntity)
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

function PopStarProRoleTurnSystem_Render:_DoRenderNotifyBuffNormalAttackEnd(TT)
  local playBuffSvc = self._world:GetService("PlayBuff")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local petRoundTeam = renderBoardEntity:RenderRoundTeam():GetRoundTeam()
  for i, eId in ipairs(petRoundTeam) do
    local petEntity = self._world:GetEntityByID(eId)
    playBuffSvc:PlayBuffView(TT, NTNormalAttackEnd:New(petEntity))
  end
end

function PopStarProRoleTurnSystem_Render:_DoRenderResetPieceAnim(TT)
  local pieceService = self._world:GetService("Piece")
  pieceService:RefreshPieceAnim()
  pieceService:RefreshMonsterAreaOutLine(TT)
end

function PopStarProRoleTurnSystem_Render:_SendPrismNotify(TT)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTCovCrystalPrism:New())
end
