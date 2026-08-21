_class("PreviewChainSkillSystem_Render", ReactiveSystem)
PreviewChainSkillSystem_Render = PreviewChainSkillSystem_Render

function PreviewChainSkillSystem_Render:Constructor(world)
  self._world = world
  self._sConfig = world:GetService("Config")
  self._carouselIdx = 0
  self._taskId = 0
end

function PreviewChainSkillSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.PreviewChainSkill)
  local c = Collector:New({group}, {
    "AddedOrRemoved"
  })
  return c
end

function PreviewChainSkillSystem_Render:Filter(entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local curMainStateID = utilDataSvc:GetCurMainStateID()
  return entity:HasPreviewChainSkill() and curMainStateID == GameStateID.PickUpChainSkillTarget
end

function PreviewChainSkillSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:ExecuteEntity(entities[i])
  end
end

function PreviewChainSkillSystem_Render:ExecuteEntity(e)
  GameGlobal.TaskManager():KillTask(self._taskId)
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  local cPreviewChainSkill = e:PreviewChainSkill()
  local petIds = cPreviewChainSkill:GetPetIds()
  local skillIds = cPreviewChainSkill:GetSkillIds()
  local posPickUpSafe = cPreviewChainSkill:GetPosPickUpSafe()
  if not petIds or table.count(petIds) <= 0 then
    self._carouselIdx = 0
    local clearTaskID = GameGlobal.TaskManager():CoreGameStartTask(sPreviewSkill.StopPreviewChainSkill, sPreviewSkill)
    local renderBoardEntity = self._world:GetRenderBoardEntity()
    local renderBoardCmpt = renderBoardEntity:RenderBoard()
    renderBoardCmpt:SetDimensionClearPreviewTaskID(clearTaskID)
    local pieceService = self._world:GetService("Piece")
    pieceService:RefreshPieceAnim()
    return
  end
  local len = table.count(petIds)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(BattleConst.DimensionPreviewInstructionSetIdChain)
  local entityList = {}
  local instructionSetList = {}
  local previewContextList = {}
  for i, id in ipairs(petIds) do
    local skillId = skillIds[i]
    table.insert(instructionSetList, instructionSet)
    local e = self._world:GetEntityByID(id)
    table.insert(entityList, e)
    local previewContext = SkillPreviewContext:New(self._world, e)
    local skillConfigData = self._sConfig:GetSkillConfigData(skillId, e)
    local utilData = self._world:GetService("UtilData")
    skillConfigData = utilData:ProcessChianSkillConfig(skillConfigData, e)
    local skillEffectArray = utilData:GetLatestEffectParamArray(e:GetID(), skillId)
    previewContext:SetEffectList(skillEffectArray)
    local targetType = skillConfigData:GetSkillTargetType()
    local scopeType = skillConfigData:GetSkillScopeType()
    local scopeParam = SkillPreviewScopeParam:New({
      TargetType = targetType,
      ScopeType = scopeType,
      ScopeCenterType = SkillScopeCenterType.ChainSkillPickUpGridPos,
      OnlyCanMove = false
    })
    scopeParam:SetScopeParamData(skillConfigData:GetSkillScopeParam())
    local scopeResult = utilScopeSvc:CalcScopeResult(scopeParam, e)
    local casterPos = e:GridLocation():CenterNoOffset()
    utilScopeSvc:ExpandMaxChainSkillScope(e, skillId, scopeResult, casterPos)
    previewContext:SetScopeResult(scopeResult:GetAttackRange())
    previewContext:SetScopeType(scopeResult:GetScopeType())
    previewContext:SetPickUpPos(posPickUpSafe)
    local targetIDList = utilScopeSvc:SelectSkillTarget(e, targetType, scopeResult)
    previewContext:SetTargetEntityIDList(targetIDList)
    table.insert(previewContextList, previewContext)
    local pstID = e:PetPstID():GetPstID()
    self._world:EventDispatcher():Dispatch(GameEventType.UpdateBuffLayerActiveSkillEnergyPreview, {
      pstID = pstID,
      index = e:SkillInfo():GetChainSkillLevel(skillId)
    })
  end
  self._carouselIdx = 1
  self._taskId = GameGlobal.TaskManager():CoreGameStartTask(self.PlayChainSkillCarousel, self, entityList, instructionSetList, previewContextList)
end

function PreviewChainSkillSystem_Render:PlayChainSkillCarousel(TT, entityList, instructionSetList, previewContextList)
  local sPreviewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  local linkrsvc = self._world:GetService("LinkageRender")
  local len = table.count(entityList)
  if 1 < len then
    while self._carouselIdx > 0 do
      sPreviewSkill:StopPreviewChainSkill(TT)
      YIELD(TT)
      local e = entityList[self._carouselIdx]
      local instructionSet = instructionSetList[self._carouselIdx]
      local previewContext = previewContextList[self._carouselIdx]
      sPreviewActiveSkill:DoPreviewInstruction(TT, instructionSet, e, previewContext)
      linkrsvc:ShowChainSkillIcon(e:GetID())
      YIELD(TT, BattleConst.DimensionPreviewCarouselDuration)
      if self._carouselIdx == table.count(entityList) then
        self._carouselIdx = 1
      else
        self._carouselIdx = self._carouselIdx + 1
      end
    end
  else
    sPreviewSkill:StopPreviewChainSkill(TT)
    local e = entityList[self._carouselIdx]
    local instructionSet = instructionSetList[self._carouselIdx]
    local previewContext = previewContextList[self._carouselIdx]
    sPreviewActiveSkill:DoPreviewInstruction(TT, instructionSet, e, previewContext)
    linkrsvc:HideChainSkillIcon()
  end
end
