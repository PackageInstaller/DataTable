_class("SkillPickUpPosAndRotateInstructionSystem_Render", ReactiveSystem)
SkillPickUpPosAndRotateInstructionSystem_Render = SkillPickUpPosAndRotateInstructionSystem_Render

function SkillPickUpPosAndRotateInstructionSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
end

function SkillPickUpPosAndRotateInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpPosAndRotateInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickOnePosAndRotate then
    return true
  end
  return false
end

function SkillPickUpPosAndRotateInstructionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpPosAndRotateInstructionSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  self._previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
  local petEntity = self._world:GetEntityByID(petEntityId)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local alreadyPickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  for _, pos in ipairs(invalidGridList) do
    if table.intable(validGridList, pos) then
      table.removev(validGridList, pos)
    end
  end
  if not table.Vector2Include(validGridList, pickUpGridPos) then
    self._previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickPosAndRotateInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    return
  end
  utilScopeSvc:ChangeGameFSMState2PickUp()
  if alreadyPickUpCount == 0 then
    previewPickUpComponent:AddGridPos(pickUpGridPos)
    self:_OnPickOnePos(petEntity, skillConfigData, pickUpGridPos)
  else
    local lastPickUpPos = previewPickUpComponent:GetLastPickUpGridPos()
    if pickUpGridPos == lastPickUpPos then
      self:_OnRotate(petEntity, skillConfigData, pickUpGridPos)
    else
      previewPickUpComponent:ClearGridPos()
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      previewPickUpComponent:SetReflectDir(ReflectDirectionType.Heng)
      self:_OnPickOnePos(petEntity, skillConfigData, pickUpGridPos)
    end
  end
end

function SkillPickUpPosAndRotateInstructionSystem_Render:_OnInitialize(petEntity, skillConfigData, pickUpGridPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  self._previewActiveSkill:ResetPreview()
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPosAndRotateInstructionSystem_Render:_OnPickOnePos(petEntity, skillConfigData, pickUpGridPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPosAndRotateInstructionSystem_Render:_OnRotate(petEntity, skillConfigData, pickUpGridPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPosAndRotateInstructionSystem_Render:UpdateUI(previewPickUpComponent)
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local canCast = false
  local uiTextState = SkillPickUpTextStateType.Normal
  if 1 <= pickUpCount then
    uiTextState = SkillPickUpTextStateType.Rotate
    canCast = true
  end
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, uiTextState)
end

function SkillPickUpPosAndRotateInstructionSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos, pickPosNum)
  local taskIDList = {}
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for i, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in ipairs(instructionParam._previewList) do
        local instructionSet = self:_GetInstructSet(type, skillPreviewConfigData)
        if instructionSet then
          local previewContext = self:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, skillPreviewConfigData:GetID(), pickUpGirdPos)
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

function SkillPickUpPosAndRotateInstructionSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
  if type == PickUpInstructionType.Invalid then
    return skillPreviewConfigData:GetOnSelectInvalidInstructionSet()
  end
  if type == PickUpInstructionType.Repeat then
    return skillPreviewConfigData:GetOnSelectCancelInstructionSet()
  end
  if type == PickUpInstructionType.Valid then
    return skillPreviewConfigData:GetOnSelectValidInstructionSet()
  end
  if type == PickUpInstructionType.Empty then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  return nil
end

function SkillPickUpPosAndRotateInstructionSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local context = previewPickUpComponent:GetPreviewContext(id)
  if not context then
    if type == PickUpInstructionType.Invalid then
      context = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, casterEntity, pickUpGridPos, {pickUpGridPos})
    else
      context = previewActiveSkillService:CreatePreviewContext(skillPreviewConfigData, casterEntity, pickUpGridPos)
    end
  end
  return context
end
