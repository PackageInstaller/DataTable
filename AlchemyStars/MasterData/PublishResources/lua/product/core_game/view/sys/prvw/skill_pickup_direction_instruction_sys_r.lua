_class("SkillPickUpDirectionInstructionSystem_Render", ReactiveSystem)
SkillPickUpDirectionInstructionSystem_Render = SkillPickUpDirectionInstructionSystem_Render

function SkillPickUpDirectionInstructionSystem_Render:Constructor(world)
  self._world = world
  self._isGuide = false
end

function SkillPickUpDirectionInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpDirectionInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.DirectionInstruction then
    return true
  end
  return false
end

function SkillPickUpDirectionInstructionSystem_Render:ExecuteEntities(entities)
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local entityID = 0
  if skillConfigData:GetSkillType() == SkillType.Active then
    entityID = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
    local entity = self._world:GetEntityByID(entityID)
    skillConfigData = configService:GetSkillConfigData(activeSkillID, entity)
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  elseif skillConfigData:GetSkillType() == SkillType.FeatureSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  end
  local petEntity = self._world:GetEntityByID(entityID)
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local musPickUpNum
  if skillConfigData._pickUpParam[2] then
    musPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local casterPos = petEntity:GridLocation().Position
  local direction = scopeCalculator:GetDirection(pickUpGridPos, casterPos)
  if table.icontains(validGirdList, pickUpGridPos) then
    if previewPickUpComponent:IsRepeatDirection(direction) then
      Log.debug("本次重复点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      if self._isGuide then
        return
      end
      previewPickUpComponent:RemoveDirection(direction)
      self:_ShowPickUpArrow(pickUpGridPos, casterPos, false)
      if previewActiveSkill then
        previewActiveSkill:ResetPreview()
        if previewPickUpComponent:GetAllValidPickUpGridPosCount() == 0 then
          previewActiveSkill:_RevertAllConvertElement()
          GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
        else
          GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
        end
      end
      previewActiveSkill:UpdateUI(pickUpNum, musPickUpNum, previewPickUpComponent)
      return
    end
    local guideService = self._world:GetService("Guide")
    if pickUpNum == 1 and previewPickUpComponent:GetAllValidPickUpGridPosCount() == 1 then
      if guideService then
        local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
        if isValid then
          if isGuide then
            self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
          end
          self._isGuide = isGuide
        else
          return
        end
      end
      local allValidPickUpGridPos = previewPickUpComponent:GetAllValidPickUpGridPos()
      local lastValidPickUPPos = allValidPickUpGridPos[1]
      self:_ShowPickUpArrow(lastValidPickUPPos, casterPos, false)
      Log.debug("本次点选其他格子生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      previewPickUpComponent:ClearGridPos()
      previewPickUpComponent:ClearDirection()
      self:_ShowPickUpArrow(pickUpGridPos, casterPos, true)
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      previewPickUpComponent:AddDirection(direction, pickUpGridPos)
      if previewActiveSkill then
        previewActiveSkill:ResetPreview()
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          self:_DoPickUpInstruction(TT, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
          previewActiveSkill:_RevertAllConvertElement()
          self:_DoPickUpInstruction(TT, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
        end)
      end
      return
    elseif pickUpNum > previewPickUpComponent:GetAllValidPickUpGridPosCount() then
      if guideService then
        local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
        if isValid then
          if isGuide then
            self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
          end
          self._isGuide = isGuide
        else
          return
        end
      end
      local lastDir = previewPickUpComponent:GetLastPickUpDirection()
      if lastDir == direction then
        return
      end
      Log.debug("本次点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      previewPickUpComponent:AddDirection(direction, pickUpGridPos)
      self:_ShowPickUpArrow(pickUpGridPos, casterPos, true)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      if previewActiveSkill then
        previewActiveSkill:ResetPreview()
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      end
      previewActiveSkill:UpdateUI(pickUpNum, musPickUpNum, previewPickUpComponent)
      return
    end
  else
    if previewActiveSkill then
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
    end
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickDirectionInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    self:_ShowPickUpArrow(pickUpGridPos, casterPos, false)
    if table.icontains(invalidGridList, pickUpGridPos) then
      Log.debug("本次点选无效目标生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      if previewActiveSkill then
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Invalid, skillConfigData, petEntity, pickUpGridPos)
      end
    end
  end
end

function SkillPickUpDirectionInstructionSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpDirectionInstructionSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
  if type == PickUpInstructionType.Repeat then
    return skillPreviewConfigData:GetOnSelectCancelInstructionSet()
  end
  if type == PickUpInstructionType.Invalid then
    return skillPreviewConfigData:GetOnSelectInvalidInstructionSet()
  end
  if type == PickUpInstructionType.Repeat then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  if type == PickUpInstructionType.Valid then
    return skillPreviewConfigData:GetOnSelectValidInstructionSet()
  end
  if type == PickUpInstructionType.Empty then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  return nil
end

function SkillPickUpDirectionInstructionSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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

function SkillPickUpDirectionInstructionSystem_Render:_ShowPickUpArrow(gridpos, casterPos, isSelect)
  local dis = gridpos - casterPos
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    local arrowPos = e:GetRenderGridPosition()
    local arrowDir = arrowPos - casterPos
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

function SkillPickUpDirectionInstructionSystem_Render:_GetPickUpDirect(gridpos, casterPos)
  local deltal = gridpos - casterPos
  if deltal.x == 0 and deltal.y <= -1 then
    return HitBackDirectionType.Down
  elseif deltal.x == 0 and deltal.y >= 1 then
    return HitBackDirectionType.Up
  elseif deltal.y == 0 and deltal.x >= 1 then
    return HitBackDirectionType.Right
  elseif deltal.y == 0 and deltal.x <= -1 then
    return HitBackDirectionType.Left
  elseif deltal.y >= 1 and deltal.x <= -1 then
    return HitBackDirectionType.LeftUp
  elseif deltal.y >= 1 and deltal.x >= 1 then
    return HitBackDirectionType.RightUp
  elseif deltal.y <= -1 and deltal.x >= 1 then
    return HitBackDirectionType.RightDown
  elseif deltal.y <= -1 and deltal.x <= -1 then
    return HitBackDirectionType.LeftDown
  else
    return HitBackDirectionType.None
  end
end

function SkillPickUpDirectionInstructionSystem_Render:ChangeAllPickArrow(state)
  local arrowEntities = self._world:GetGroup(self._world.BW_WEMatchers.PickUpArrow):GetEntities()
  for _, e in ipairs(arrowEntities) do
    local statTable
    if state == "Show" then
      statTable = {select = true, idle = false}
    elseif state == "Hide" then
      statTable = {select = false, idle = true}
    end
    e:SetAnimatorControllerBools(statTable)
  end
end
