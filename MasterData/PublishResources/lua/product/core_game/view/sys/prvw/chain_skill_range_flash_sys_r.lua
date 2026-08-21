_class("ChainSkllRangeFlashSystem_Render", Object)
ChainSkllRangeFlashSystem_Render = ChainSkllRangeFlashSystem_Render

function ChainSkllRangeFlashSystem_Render:Constructor(world)
  self._world = world
  self._timeService = world:GetService("Time")
end

function ChainSkllRangeFlashSystem_Render:Execute()
  local reBoard = self._world:GetRenderBoardEntity()
  if reBoard == nil then
    return
  end
  local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  local isEnable = previewChainSkillRangeCmpt:GetPreviewChainSkillRangeEnable()
  if not isEnable then
    if previewChainSkillRangeCmpt:HasPreviewChainSkillData() then
      self:_DestroyChainSkillRange()
      self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {shutdown = true})
    end
    return
  end
  if not previewChainSkillRangeCmpt:HasPreviewChainSkillData() then
    self:_ClearFlashTarget()
    local linkrsvc = self._world:GetService("LinkageRender")
    linkrsvc:HideChainSkillIcon()
    self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {shutdown = true})
    return
  end
  local previewIndex = previewChainSkillRangeCmpt:GetPreviewTypeIndex()
  if previewIndex <= 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {shutdown = true})
    return
  end
  local isFlashRange = previewChainSkillRangeCmpt:IsFlashChainSkillRange()
  if isFlashRange == true then
    local previewStartTime = previewChainSkillRangeCmpt:GetPreviewStartTime()
    local curTime = self._timeService:GetCurrentTimeMs()
    if previewStartTime <= 0 then
      self:_CreatePreviewChainSkill(previewIndex)
    else
      local activeTime = curTime - previewStartTime
      local showTime = previewChainSkillRangeCmpt:GetPreviewShowTime()
      if activeTime > showTime then
        self:_HidePreviewChainSkill(previewIndex)
      end
    end
  elseif 0 < previewIndex then
    self:_CreatePreviewChainSkill(previewIndex)
  end
end

function ChainSkllRangeFlashSystem_Render:_ShowOutlineEntityArray(outlineEntityArray)
  for k, outlineEntityID in ipairs(outlineEntityArray) do
    local outlineEntity = self._world:GetEntityByID(outlineEntityID)
    self:_SetOutlineEntityVisible(outlineEntity, true)
  end
end

function ChainSkllRangeFlashSystem_Render:_HideOutlineEntityArray(outlineEntityArray)
  for k, outlineEntityID in ipairs(outlineEntityArray) do
    local outlineEntity = self._world:GetEntityByID(outlineEntityID)
    self:_SetOutlineEntityVisible(outlineEntity, false)
  end
end

function ChainSkllRangeFlashSystem_Render:_FlashTarget()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MaterialAnimation):GetEntities()
  local chainAttackTargetList = {}
  local previewEntity = self._world:GetPreviewEntity()
  local selectPetCmpt = previewEntity:PreviewChainSelectPet()
  local configService = self._world:GetService("Config")
  local petList = selectPetCmpt:GetRenderPetList()
  for i, v in ipairs(petList) do
    local petEntityID = v
    local chainSkillID = selectPetCmpt:GetPreviewChainSelectPetSkillID(petEntityID)
    local scopeResult = selectPetCmpt:GetPreviewChainSelectPetScopeResult(petEntityID)
    local skillConfigData = configService:GetSkillConfigData(chainSkillID)
    local preViewType = skillConfigData:GetSkillPreviewType()
    if preViewType ~= SkillPreviewType.AddHPChainSkill then
      table.appendArray(chainAttackTargetList, scopeResult:GetTargetIDs())
    end
  end
  for _, beAttackEntityID in pairs(chainAttackTargetList) do
    local beAttackEntity = self._world:GetEntityByID(beAttackEntityID)
    if beAttackEntity then
      local hasFlash = self:_IsFlashEntity(beAttackEntityID, flashEnemyEntities)
      if not hasFlash and self:_GetCanPlayMaterialAnimationWithBuff(beAttackEntity) then
        beAttackEntity:NewEnableFlashAlpha()
      end
    end
  end
  for _, v in ipairs(flashEnemyEntities) do
    local curEntityID = v:GetID()
    local beAttackEntity = self._world:GetEntityByID(curEntityID)
    if beAttackEntity and not beAttackEntity:HasOutsideRegion() and not beAttackEntity:HasOffBoardMonster() then
      local inAttackRange = self:_InAttackTargetList(curEntityID, chainAttackTargetList)
      if not inAttackRange and not v:HasPetPstID() and self:_GetCanPlayMaterialAnimationWithBuff(beAttackEntity) then
        v:NewEnableGhost()
      end
    end
  end
end

function ChainSkllRangeFlashSystem_Render:_GetCanPlayMaterialAnimationWithBuff(entity)
  if not entity then
    return false
  end
  if entity:BuffView() and entity:BuffView():HasBuffEffect(BuffEffectType.NotPlayMaterialAnimation) then
    return false
  end
  return true
end

function ChainSkllRangeFlashSystem_Render:_IsFlashEntity(entityID, entityGroup)
  for k, entityInGroup in pairs(entityGroup) do
    if entityInGroup:GetID() == entityID and entityInGroup:MaterialAnimationComponent() and entityInGroup:MaterialAnimationComponent():IsPlayingSelectAlpha() then
      return true
    end
  end
  return false
end

function ChainSkllRangeFlashSystem_Render:_InAttackTargetList(curEntityID, chainAttackTargetList)
  for _, entityID in pairs(chainAttackTargetList) do
    if entityID == curEntityID then
      return true
    end
  end
  return false
end

function ChainSkllRangeFlashSystem_Render:_ClearFlashTarget()
  local flashEnemyEntities = self._world:GetGroup(self._world.BW_WEMatchers.MaterialAnimation):GetEntities()
  for _, v in ipairs(flashEnemyEntities) do
    if v:MaterialAnimationComponent() and v:MaterialAnimationComponent():IsPlayingSelectAlpha() and not v:HasPetPstID() then
      v:NewEnableGhost()
    end
  end
end

function ChainSkllRangeFlashSystem_Render:_DestroyChainSkillRange()
  local renderBattleService = self._world:GetService("RenderBattle")
  renderBattleService:ClearChainSkillPreviewRenderData()
  self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {shutdown = true})
end

function ChainSkllRangeFlashSystem_Render:_SetOutlineEntityVisible(outLineEntity, visible)
  local viewCmpt = outLineEntity:View()
  if viewCmpt == nil then
    Log.fatal("outline entity has no view")
    return
  end
  local gameObj = viewCmpt:GetGameObject()
  local curPos = gameObj.transform.position
  if visible then
    if curPos ~= Vector3(curPos.x, 0, curPos.z) then
      gameObj.transform.position = Vector3(curPos.x, 0, curPos.z)
    end
  elseif curPos ~= Vector3(curPos.x, 1000, curPos.z) then
    gameObj.transform.position = Vector3(curPos.x, 1000, curPos.z)
  end
end

function ChainSkllRangeFlashSystem_Render:_HidePreviewChainSkill(previewIndex)
  local previewChainSkillRangeCmpt, chainSkillRangeEntityDic = self:_GetPreviewChainSkillRangeAndRangeEntityDic()
  local type = previewChainSkillRangeCmpt:GetPreviewChainSkillTypeByPreviewIndex(previewIndex)
  local curTime = self._timeService:GetCurrentTimeMs()
  if type == PreviewChainSkillType.Range then
    local outlineEntityArray = chainSkillRangeEntityDic[previewIndex]
    self:_HideOutlineEntityArray(outlineEntityArray)
  elseif type == PreviewChainSkillType.SingleEntity then
    self:_HidePreviewSnipeEffect(previewIndex)
  elseif type == PreviewChainSkillType.AddHP then
    self:_HideAddHPPetAnim(previewIndex)
  elseif type == PreviewChainSkillType.RangeAndSingleEntity then
    local outlineEntityArray = chainSkillRangeEntityDic[previewIndex]
    self:_HideOutlineEntityArray(outlineEntityArray)
    self:_HidePreviewSnipeEffect(previewIndex)
  end
  local nextIndex = previewIndex + 1
  if previewChainSkillRangeCmpt:GetPreviewChainSkillTypeByPreviewIndex(nextIndex) == PreviewChainSkillType.None then
    nextIndex = 1
  end
  previewChainSkillRangeCmpt:SetPreviewTypeIndex(nextIndex)
  previewChainSkillRangeCmpt:SetPreviewStartTime(0)
  local linkrsvc = self._world:GetService("LinkageRender")
  linkrsvc:HideChainSkillIcon()
end

function ChainSkllRangeFlashSystem_Render:_CreatePreviewChainSkill(previewIndex)
  self:_FlashTarget()
  local previewChainSkillRangeCmpt, chainSkillRangeEntityDic = self:_GetPreviewChainSkillRangeAndRangeEntityDic()
  local type = previewChainSkillRangeCmpt:GetPreviewChainSkillTypeByPreviewIndex(previewIndex)
  local curTime = self._timeService:GetCurrentTimeMs()
  if type == PreviewChainSkillType.Range then
    local outlineEntityArray = chainSkillRangeEntityDic[previewIndex]
    self:_ShowOutlineEntityArray(outlineEntityArray)
  elseif type == PreviewChainSkillType.SingleEntity then
    self:_ShowPreviewSnipeEffect(previewIndex)
  elseif type == PreviewChainSkillType.AddHP then
    self:_ShowAddHPPetAnim(previewIndex)
  elseif type == PreviewChainSkillType.RangeAndSingleEntity then
    local outlineEntityArray = chainSkillRangeEntityDic[previewIndex]
    self:_ShowOutlineEntityArray(outlineEntityArray)
    self:_ShowPreviewSnipeEffect(previewIndex)
  else
    Log.fatal("")
  end
  previewChainSkillRangeCmpt:SetPreviewStartTime(curTime)
  local petEntityID = previewChainSkillRangeCmpt:GetPreviewPetID(previewIndex)
  local linkrsvc = self._world:GetService("LinkageRender")
  linkrsvc:ShowChainSkillIcon(petEntityID)
end

function ChainSkllRangeFlashSystem_Render:_ShowPreviewSnipeEffect(previewType)
  local previewChainSkillRangeCmpt, _ = self:_GetPreviewChainSkillRangeAndRangeEntityDic()
  local entityList = previewChainSkillRangeCmpt:GetPreviewChainSkillSingleEffectList(previewType)
  local attackElementType = previewChainSkillRangeCmpt:GetChainSkillAttackElementType(previewType)
  local renderBattleService = self._world:GetService("RenderBattle")
  for k, entity in pairs(entityList) do
    if not entity:IsViewVisible() then
      entity:SetViewVisible(true)
    end
    renderBattleService:PlaySnipeEffectAnimation(entity, attackElementType)
  end
end

function ChainSkllRangeFlashSystem_Render:_HidePreviewSnipeEffect(previewType)
  local previewChainSkillRangeCmpt, _ = self:_GetPreviewChainSkillRangeAndRangeEntityDic()
  local entityList = previewChainSkillRangeCmpt:GetPreviewChainSkillSingleEffectList(previewType)
  local renderBattleService = self._world:GetService("RenderBattle")
  for k, entity in pairs(entityList) do
    renderBattleService:StopAnimation(entity)
    if entity:IsViewVisible() then
      entity:SetViewVisible(false)
    end
  end
end

function ChainSkllRangeFlashSystem_Render:_ShowAddHPPetAnim(previewType)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  teamLeaderEntity:PlayCurePreMaterialAnim()
end

function ChainSkllRangeFlashSystem_Render:_HideAddHPPetAnim(previewType)
  local teamEntity = self._world:Player():GetPreviewTeamEntity()
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  teamLeaderEntity:StopCurePreAnim()
end

function ChainSkllRangeFlashSystem_Render:_GetPreviewChainSkillRangeAndRangeEntityDic()
  local reBoard = self._world:GetRenderBoardEntity()
  local previewChainSkillRangeCmpt = reBoard:PreviewChainSkillRange()
  local chainSkillRangeData = previewChainSkillRangeCmpt:GetChainSkillRangeOutlineDic()
  local chainSkillRangeEntityDic = chainSkillRangeData:GetChainSkillOutlineEntityDic()
  return previewChainSkillRangeCmpt, chainSkillRangeEntityDic
end
