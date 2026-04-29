_class("PreviewActiveSkillSystem_Render", ReactiveSystem)
PreviewActiveSkillSystem_Render = PreviewActiveSkillSystem_Render

function PreviewActiveSkillSystem_Render:Constructor(world)
  self._world = world
  self._configService = world:GetService("Config")
  self._previewInstructionSetDic = {}
  self._previewInstructionSetDic[SkillPreviewType.ConvertElement] = 110
  self._previewInstructionSetDic[SkillPreviewType.Scope] = 111
  self._previewInstructionSetDic[SkillPreviewType.ActorDamage] = 112
  self._previewInstructionSetDic[SkillPreviewType.SupportAddBuff] = 113
  self._previewInstructionSetDic[SkillPreviewType.SupportAddBuffWithCastCheck] = 120
  self._previewInstructionSetDic[SkillPreviewType.SupportAddBuffWithCastCheckSan] = 121
end

function PreviewActiveSkillSystem_Render:Dispose()
end

function PreviewActiveSkillSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.PreviewActiveSkill)
  local c = Collector:New({group}, {
    "AddedOrRemoved"
  })
  return c
end

function PreviewActiveSkillSystem_Render:Filter(entity)
  return true
end

function PreviewActiveSkillSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    local actorEntity = entities[i]
    local hasPreviewCmpt = actorEntity:HasPreviewActiveSkill()
    if hasPreviewCmpt then
      local previewIndex = self:_GetPreviewIndex()
      GameGlobal.TaskManager():CoreGameStartTask(self._NewPreviewRoutine, self, actorEntity, previewIndex)
    end
  end
end

function PreviewActiveSkillSystem_Render:_NewPreviewRoutine(TT, actorEntity, previewIndex)
  self:_HideLastPreview(actorEntity)
  YIELD(TT)
  local utilDataSvc = self._world:GetService("UtilData")
  local curStateID = utilDataSvc:GetCurMainStateID()
  if curStateID ~= GameStateID.PreviewActiveSkill then
    Log.fatal("PreviewActiveSkill not in preview state,cur state is :", curStateID)
  end
  local curPreviewIndex = self:_GetPreviewIndex()
  if curPreviewIndex ~= previewIndex then
    return
  end
  self:_NewPreviewIndex()
  self:_ShowPreview(TT, actorEntity)
end

function PreviewActiveSkillSystem_Render:_ShowPreview(TT, actorEntity)
  local eventListenerService = self._world:GetService("EventListener")
  local preClickHeadSkillID = eventListenerService:GetPreClickHeadSkillID()
  local previewActiveSkillCmpt = actorEntity:PreviewActiveSkill()
  local activeSkillID = previewActiveSkillCmpt:GetActiveSKillID()
  if preClickHeadSkillID ~= activeSkillID then
    Log.fatal("preview active skill not match", preClickHeadSkillID, activeSkillID)
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HideCanMoveArrow)
  local configService = self._configService
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, actorEntity)
  local previewType = skillConfigData:GetSkillPreviewType()
  if previewType == SkillPreviewType.Instruction then
    self:_DoPreviewInstruction(TT, activeSkillID, actorEntity)
  elseif previewType == SkillPreviewType.ConvertElement or previewType == SkillPreviewType.Scope or previewType == SkillPreviewType.ActorDamage or previewType == SkillPreviewType.SupportAddBuff or previewType == SkillPreviewType.SupportAddBuffWithCastCheck or previewType == SkillPreviewType.SupportAddBuffWithCastCheckSan then
    self:_DoOtherPreviewInstruction(TT, activeSkillID, actorEntity, previewType)
  elseif previewType == SkillPreviewType.TrapActiveSkill then
    self:_DoPreviewInstruction(TT, activeSkillID, actorEntity)
  else
    Log.fatal("other preview type is ", previewType)
  end
end

function PreviewActiveSkillSystem_Render:_HideLastPreview(actorEntity)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.PetHidePreviewArrow)
end

function PreviewActiveSkillSystem_Render:_NewPreviewIndex(enablePrview)
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity ~= nil then
    local renderState = previewEntity:RenderState()
    renderState:NewPreviewRoutine()
  end
end

function PreviewActiveSkillSystem_Render:ResetPreview()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity ~= nil then
    local renderState = previewEntity:RenderState()
    renderState:ResetPreviewRoutine()
  end
end

function PreviewActiveSkillSystem_Render:_GetPreviewIndex()
  local previewEntity = self._world:GetPreviewEntity()
  if previewEntity ~= nil then
    local renderState = previewEntity:RenderState()
    return renderState:GetPreviewRoutineIndex()
  end
  return 0
end

function PreviewActiveSkillSystem_Render:_DoOtherPreviewInstruction(TT, activeSkillID, casterEntity, previewType)
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID, casterEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local skillPreviewParamInstruction = SkillPreviewParamInstruction:New({})
  local instructionSetID = self._previewInstructionSetDic[previewType]
  if not instructionSetID then
    Log.exception("SkillID:", activeSkillID, "PreviewType :", previewType, "Invalid ")
    return
  end
  local instructionSet = skillPreviewParamInstruction:_ParseInstructionSet(instructionSetID)
  local previewContext = SkillPreviewContext:New(self._world, casterEntity)
  local skillEffectArray = skillConfigData:GetSkillSourceEffectTable()
  previewContext:SetEffectList(skillEffectArray)
  local targetType = skillConfigData:GetSkillTargetType()
  local targetTypeParam = skillConfigData:GetSkillTargetTypeParam()
  local scopeParam = SkillPreviewScopeParam:New({
    TargetType = targetType,
    ScopeType = skillConfigData:GetSkillScopeType(),
    ScopeCenterType = skillConfigData:GetSkillScopeCenterType(),
    TargetTypeParam = targetTypeParam
  })
  scopeParam:SetScopeParamData(skillConfigData:GetSkillScopeParam())
  local scopeResult = utilScopeSvc:CalcScopeResult(scopeParam, casterEntity)
  previewContext:SetScopeResult(scopeResult:GetAttackRange())
  previewContext:SetScopeType(scopeResult:GetScopeType())
  local targetIDList = utilScopeSvc:SelectSkillTarget(casterEntity, targetType, scopeResult, activeSkillID, targetTypeParam)
  previewContext:SetTargetEntityIDList(targetIDList)
  if instructionSet then
    local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, casterEntity, previewContext)
    table.insert(taskIDList, taskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PreviewActiveSkillSystem_Render:_DoPreviewInstruction(TT, activeSkillID, casterEntity)
  local taskIDList = {}
  local skillConfigData = self._configService:GetSkillConfigData(activeSkillID, casterEntity)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in pairs(instructionParam._previewList) do
        local instructionSet = skillPreviewConfigData:GetOnStartInstructionSet()
        if instructionSet then
          local previewContext = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, casterEntity)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillService.DoPreviewInstruction, previewActiveSkillService, instructionSet, casterEntity, previewContext)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end
