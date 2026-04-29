_class("SkillPickUpPickAndDirectionInstructionSystem_Render", ReactiveSystem)
SkillPickUpPickAndDirectionInstructionSystem_Render = SkillPickUpPickAndDirectionInstructionSystem_Render

function SkillPickUpPickAndDirectionInstructionSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickAndDirectionInstruction then
    return true
  end
  return false
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:_OnInitializeShow(petEntity, skillConfigData, pickUpGridPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  self._previewActiveSkill:ResetPreview()
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:_OnReadyToSelectDirectionShow(petEntity, skillConfigData, pickUpGridPos, lastPickUpPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local firstPickUpPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  previewActiveSkillService:DoConvert({firstPickUpPos}, "Silver", "Dark")
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  if table.count(arrowEntities) == 0 then
    self._previewActiveSkill:ShowFourPickUpArrow(true, firstPickUpPos)
  end
  if lastPickUpPos then
    self:_ShowPickUpArrow(lastPickUpPos, firstPickUpPos, false)
  end
  self:_ShowPickUpArrow(pickUpGridPos, firstPickUpPos, false)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:_OnHadToSelectDirectionShow(petEntity, skillConfigData, pickUpGridPos, lastPickUpPos)
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local firstPickUpPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
  self:_ShowPickUpArrow(lastPickUpPos, firstPickUpPos, false)
  self:_ShowPickUpArrow(pickUpGridPos, firstPickUpPos, true)
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:IsDirValid(lastPickUpPos, curPickUpPos)
  if (curPickUpPos.x == lastPickUpPos.x + 1 or curPickUpPos.x == lastPickUpPos.x - 1 or curPickUpPos.x == lastPickUpPos.x) and curPickUpPos.y == lastPickUpPos.y then
    return true
  end
  if (curPickUpPos.y == lastPickUpPos.y + 1 or curPickUpPos.y == lastPickUpPos.y - 1 or curPickUpPos.y == lastPickUpPos.y) and curPickUpPos.x == lastPickUpPos.x then
    return true
  end
  return false
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  self._previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  if pickUpGridPos then
    local guideService = self._world:GetService("Guide")
    local isGuide, isValid = guideService:IsGuideAndPieceValid(pickUpGridPos.x, pickUpGridPos.y)
    if isGuide then
      if isValid then
        self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
      else
        return
      end
    end
  end
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
  if petEntityId == -1 then
    petEntityId = pickUpTargetCmpt:GetEntityID()
  end
  local petEntity = self._world:GetEntityByID(petEntityId)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpParam = skillConfigData:GetSkillPickParam()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local alreadyPickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  if alreadyPickUpCount == 0 then
    for _, pos in ipairs(invalidGridList) do
      if table.intable(validGridList, pos) then
        table.removev(validGridList, pos)
      end
    end
  end
  local pickTelIndex = tonumber(skillConfigData._pickUpParam[1])
  local lastPickUpPos = previewPickUpComponent:GetLastPickUpGridPos()
  if self._pickUpType == SkillPickUpType.PickAndDirectionInstruction2 then
    if alreadyPickUpCount == 0 then
      if not table.Vector2Include(validGridList, pickUpGridPos) then
        previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
        if AutoPickCheckHelperRender.IsAutoFightRunning() then
          AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndDirectionInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
        end
        return
      end
    elseif not self:IsDirValid(lastPickUpPos, pickUpGridPos) then
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
      if AutoPickCheckHelperRender.IsAutoFightRunning() then
        AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndDirectionInsDirInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
      end
      return
    end
  elseif not table.Vector2Include(validGridList, pickUpGridPos) then
    previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndDirectionInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    return
  end
  utilScopeSvc:ChangeGameFSMState2PickUp()
  if alreadyPickUpCount == 0 then
    previewPickUpComponent:AddGridPos(pickUpGridPos)
    self:_OnReadyToSelectDirectionShow(petEntity, skillConfigData, pickUpGridPos, lastPickUpPos)
  else
    local firstPickUpPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
    if pickUpGridPos == firstPickUpPos then
      previewPickUpComponent:ClearGridPos()
      previewPickUpComponent:ClearDirection()
      self:_OnInitializeShow(petEntity, skillConfigData, pickUpGridPos)
    else
      local directionGridList = {}
      table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y + 1))
      table.insert(directionGridList, Vector2(firstPickUpPos.x + 1, firstPickUpPos.y + 0))
      table.insert(directionGridList, Vector2(firstPickUpPos.x + 0, firstPickUpPos.y - 1))
      table.insert(directionGridList, Vector2(firstPickUpPos.x - 1, firstPickUpPos.y + 0))
      if table.Vector2Include(directionGridList, pickUpGridPos) then
        if pickUpGridPos == lastPickUpPos then
          previewPickUpComponent:RemoveGridPos(lastPickUpPos)
          self:_OnReadyToSelectDirectionShow(petEntity, skillConfigData, pickUpGridPos, lastPickUpPos)
          if self._pickUpType == SkillPickUpType.PickAndDirectionInstruction2 then
            GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
          end
        else
          if alreadyPickUpCount == 2 then
            previewPickUpComponent:RemoveGridPos(lastPickUpPos)
          end
          previewPickUpComponent:AddGridPos(pickUpGridPos)
          self:_OnHadToSelectDirectionShow(petEntity, skillConfigData, pickUpGridPos, lastPickUpPos)
        end
      end
    end
  end
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:IsRepeatPickUP(lastPickUpPos, pickUpGridPos)
  if lastPickUpPos then
    return lastPickUpPos.x == pickUpGridPos.x and lastPickUpPos.y == pickUpGridPos.y
  else
    return false
  end
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:UpdateUI(previewPickUpComponent)
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local pickUpGridList = previewPickUpComponent:GetAllValidPickUpGridPos()
  local leftPickUpNum = 0
  local canCast = false
  local uiTextState = SkillPickUpTextStateType.Normal
  if pickUpCount == 1 then
    uiTextState = SkillPickUpTextStateType.Direction
    leftPickUpNum = 1
    canCast = false
  elseif pickUpCount == 2 then
    uiTextState = SkillPickUpTextStateType.Direction
    leftPickUpNum = 0
    canCast = true
  elseif pickUpCount == 0 then
    canCast = false
    leftPickUpNum = 1
    uiTextState = SkillPickUpTextStateType.Normal
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftPickUpNum)
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
  self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, uiTextState)
end

function SkillPickUpPickAndDirectionInstructionSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpPickAndDirectionInstructionSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
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

function SkillPickUpPickAndDirectionInstructionSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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

function SkillPickUpPickAndDirectionInstructionSystem_Render:_ShowPickUpArrow(gridpos, centerPos, isSelect)
  local dis = gridpos - centerPos
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    local arrowPos = e:GetRenderGridPosition()
    local arrowDir = arrowPos - centerPos
    local angle = Vector2.Angle(dis, arrowDir)
    local statTable
    if math.abs(angle) <= 1 then
      if isSelect == true then
        statTable = {select = true, idle = false}
      else
        statTable = {select = false, idle = true}
      end
      e:SetAnimatorControllerBools(statTable)
    end
  end
end
