_class("PlayChargeAndStoneBreakInstruction", BaseInstruction)
PlayChargeAndStoneBreakInstruction = PlayChargeAndStoneBreakInstruction

function PlayChargeAndStoneBreakInstruction:Constructor(paramList)
  self._beginAnim = paramList.beginAnim
  self._beginEffectID = tonumber(paramList.beginEffectID)
  self._beginAnimTime = tonumber(paramList.beginAnimTime)
  self._chargeAnim = paramList.chargeAnim
  self._chargeEffectID = tonumber(paramList.chargeEffectID)
  self._attackAnim = paramList.attackAnim
  self._attackEffectID = tonumber(paramList.attackEffectID)
  self._chargeTime = tonumber(paramList.chargeTime)
end

function PlayChargeAndStoneBreakInstruction:GetCacheResource()
  local t = {}
  if self._attackEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._attackEffectID].ResPath,
      1
    })
  end
  if self._beginEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._beginEffectID].ResPath,
      1
    })
  end
  if self._chargeEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._chargeEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayChargeAndStoneBreakInstruction:DoInstruction(TT, casterEntity, phaseContext)
  self._world = casterEntity:GetOwnerWorld()
  local bodyArea = casterEntity:BodyArea():GetArea()
  local casterPos = casterEntity:GetRenderGridPosition()
  local resultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local trapServiceRender = self._world:GetService("TrapRender")
  local resultList = resultContainer:GetEffectResultsAsArray(SkillEffectType.Teleport)
  local teleportResult = resultList[1]
  local teleportDir = teleportResult:GetDirNew()
  local teleportNewPos = teleportResult:GetPosNew()
  local oldPos = teleportResult:GetPosOld()
  local renderEntityService = self._world:GetService("RenderEntity")
  local effectSvc = self._world:GetService("Effect")
  self:RefreshPieceAnim(oldPos, casterEntity, true)
  renderEntityService:DestroyMonsterAreaOutLineEntity(casterEntity)
  casterEntity:SetDirection(teleportDir)
  trapServiceRender:ShowHideTrapAtPos(oldPos, true)
  casterEntity:SetAnimatorControllerTriggers({
    self._beginAnim
  })
  effectSvc:CreateEffect(self._beginEffectID, casterEntity)
  YIELD(TT, self._beginAnimTime)
  casterEntity:SetAnimatorControllerTriggers({
    self._chargeAnim
  })
  effectSvc:CreateEffect(self._chargeEffectID, casterEntity)
  local boardServiceRender = self._world:GetService("BoardRender")
  self._boardSvcRender = boardServiceRender
  local renderPos = boardServiceRender:GridPos2RenderPos(teleportNewPos)
  local offset = casterEntity:GetGridOffset()
  renderPos = Vector3(renderPos.x + offset.x, renderPos.y, renderPos.z + offset.y)
  local go = casterEntity:View():GetGameObject()
  local dotween = go.transform:DOMove(renderPos, self._chargeTime / 1000)
  resultList = resultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyTrap, 1)
  self._taskID = {}
  local casterRealPos = casterEntity:GetRenderGridPosition()
  while dotween:IsActive() do
    self:PlayDestroyTrap(TT, resultList, casterEntity, teleportDir, trapServiceRender)
    casterRealPos = casterEntity:GetRenderGridPosition()
    YIELD(TT)
  end
  casterEntity:SetPosition(teleportNewPos + casterEntity:GetGridOffset())
  casterEntity:SetAnimatorControllerTriggers({
    self._attackAnim
  })
  effectSvc:CreateEffect(self._attackEffectID, casterEntity)
  self:RefreshPieceAnim(teleportNewPos, casterEntity, false)
  trapServiceRender:ShowHideTrapAtPos(teleportNewPos, false)
  renderEntityService:CreateMonsterAreaOutlineEntity(casterEntity)
  self._world:GetService("PlayBuff"):PlayBuffView(TT, NTTeleport:New(casterEntity, oldPos, teleportNewPos))
  self:PlayDestroyTrap(TT, resultList, casterEntity, teleportDir, trapServiceRender)
  while not TaskHelper:GetInstance():IsAllTaskFinished(self._taskID) do
    YIELD(TT)
  end
end

function PlayChargeAndStoneBreakInstruction:RefreshPieceAnim(pos, casterEntity, bLight)
  local pieceService = self._world:GetService("Piece")
  local utilDataService = self._world:GetService("UtilData")
  local bodyArea = casterEntity:BodyArea():GetArea()
  for i = 1, #bodyArea do
    local posWork = pos + bodyArea[i]
    if utilDataService:IsValidPiecePos(posWork) then
      if bLight then
        pieceService:SetPieceAnimUp(posWork)
      else
        pieceService:SetPieceAnimDown(posWork)
      end
    end
  end
end

function PlayChargeAndStoneBreakInstruction:PlayDestroyTrap(TT, resultList, casterEntity, teleportDir, trapServiceRender)
  if not resultList then
    return
  end
  for i, v in ipairs(resultList) do
    local pos = v:GetTrapPos()
    local entityID = v:GetEntityID()
    local entity = self._world:GetEntityByID(entityID)
    local trapRenderCmpt = entity:TrapRender()
    local hadPlayDead = trapRenderCmpt:GetHadPlayDead()
    if self:NeedPlayDead(casterEntity, pos, teleportDir) and not hadPlayDead then
      local id = GameGlobal.TaskManager():CoreGameStartTask(trapServiceRender.PlayTrapDieSkill, trapServiceRender, {entity})
      table.insert(self._taskID, id)
    end
  end
end

function PlayChargeAndStoneBreakInstruction:NeedPlayDead(casterEntity, pos, teleportDir)
  local casterRealPos = self._boardSvcRender:GetEntityRealTimeGridPosByGO(casterEntity)
  if teleportDir == Vector2(0, 1) then
    if pos.y <= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(0, -1) then
    if pos.y >= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(1, 0) then
    if pos.y >= casterRealPos.y then
      return true
    end
  elseif teleportDir == Vector2(-1, 0) and pos.y >= casterRealPos.y then
    return true
  end
  return false
end
