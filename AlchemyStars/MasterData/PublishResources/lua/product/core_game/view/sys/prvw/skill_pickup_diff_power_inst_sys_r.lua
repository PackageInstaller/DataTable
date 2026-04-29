_class("SkillPickUpDiffPowerInstructionSystem_Render", ReactiveSystem)
SkillPickUpDiffPowerInstructionSystem_Render = SkillPickUpDiffPowerInstructionSystem_Render

function SkillPickUpDiffPowerInstructionSystem_Render:Constructor(world)
  self._world = world
  self._isGuide = false
  self._pickUpType = nil
  self._IsRepeatPickupFunc = {}
  self._IsRepeatPickupFunc[SkillPickUpType.PickDiffPowerInstruction] = self.IsRepeatPickUP_PickGrid
  self._ProgressInvalidFunc = {}
  self._ProgressInvalidFunc[SkillPickUpType.PickDiffPowerInstruction] = self.ProgressInvalidGridList_PickGrid
  self._RemovePickUpGridPos = {}
  self._RemovePickUpGridPos[SkillPickUpType.PickDiffPowerInstruction] = self.RemovePickUpGridPos_PickGrid
end

function SkillPickUpDiffPowerInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpDiffPowerInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickDiffPowerInstruction then
    return true
  end
  return false
end

function SkillPickUpDiffPowerInstructionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpDiffPowerInstructionSystem_Render:_DoInstruction(instructionType, skillConfigData, petEntity, pickUpGridPos)
  GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, instructionType, skillConfigData, petEntity, pickUpGridPos)
end

function SkillPickUpDiffPowerInstructionSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, entity)
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local entityID = 0
  if skillConfigData:GetSkillType() == SkillType.Active then
    entityID = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  end
  local petEntity = self._world:GetEntityByID(entityID)
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  validGridList = self:ProcessInvalidGridList(validGridList, invalidGridList)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  self._pickUpNum = pickUpNum
  local musPickUpNum
  if skillConfigData._pickUpParam[2] then
    musPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  self._mustPickUpNum = musPickUpNum
  local tarTrapId
  if skillConfigData._pickUpParam[3] then
    tarTrapId = tonumber(skillConfigData._pickUpParam[3])
  end
  self._tarTrapId = tarTrapId
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  if self:IsRepeatPickUP(previewPickUpComponent:GetAllValidPickUpGridPos(), pickUpGridPos) then
    if self._isGuide then
      return
    end
    self:_HandlePickRepeatPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickDiffPowerInsRepeat, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    return
  end
  if table.icontains(validGridList, pickUpGridPos) then
    local guideService = self._world:GetService("Guide")
    if pickUpNum == 1 and previewPickUpComponent:GetAllValidPickUpGridPosCount() == 1 then
      local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
      if isValid then
        if isGuide then
          self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
        end
        self._isGuide = isGuide
      else
        return
      end
      self:_HandleRePickPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
      return
    elseif pickUpNum > previewPickUpComponent:GetAllValidPickUpGridPosCount() then
      local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
      if isValid then
        if isGuide then
          self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
        end
        self._isGuide = isGuide
      else
        return
      end
      self:_HandlePickValidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
      return
    else
      local guideService = self._world:GetService("Guide")
      local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
      if not isValid then
        return
      end
    end
  else
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickDiffPowerInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    if table.icontains(invalidGridList, pickUpGridPos) then
      self:_HandlePickInvalidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
    else
      self:_HandlePickCancelPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
    end
  end
end

function SkillPickUpDiffPowerInstructionSystem_Render:UpdateUI(previewPickUpComponent, checkPowerEnough, activeSkillID)
  local leftPickUpNumber = self._pickUpNum - previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  if leftPickUpNumber < 0 then
    Log.fatal("leftPickUpNumber <=0 number:", leftPickUpNumber)
    leftPickUpNumber = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftPickUpNumber)
  if self._mustPickUpNum then
    if pickUpCount == self._mustPickUpNum then
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, checkPowerEnough)
      return
    end
  elseif pickUpCount ~= 0 then
    self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, checkPowerEnough)
    return
  end
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
  GameGlobal:EventDispatcher():Dispatch(GameEventType.SetCurPickExtraParam, activeSkillID, previewPickUpComponent:GetAllPickExtraParam())
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandlePickRepeatPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次重复点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  self:RemoveRepeatPickUpGrid(previewPickUpComponent, pickUpGridPos)
  if previewActiveSkill then
    previewActiveSkill:ResetPreview()
    previewActiveSkill:_RevertAllConvertElement()
    if previewPickUpComponent:GetAllValidPickUpGridPosCount() == 0 then
      self:_DoInstruction(PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
    else
      self:_DoInstruction(PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
    end
  end
  local checkPowerEnough = true
  self:UpdateUI(previewPickUpComponent, checkPowerEnough, activeSkillID)
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandleRePickPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次点选其他格子生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:ClearGridPos()
  previewPickUpComponent:AddGridPos(pickUpGridPos)
  if previewActiveSkill then
    previewActiveSkill:ResetPreview()
    previewActiveSkill:_RevertAllConvertElement()
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:_DoPickUpInstruction(TT, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
      previewActiveSkill:_RevertAllConvertElement()
      self:_DoPickUpInstruction(TT, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
    end)
  end
  local checkPowerEnough = self:_HandlePickTrap(petEntity, pickUpGridPos, previewPickUpComponent, skillConfigData)
  self:UpdateUI(previewPickUpComponent, checkPowerEnough, activeSkillID)
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandlePickValidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  Log.debug("本次点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:AddGridPos(pickUpGridPos)
  local checkPowerEnough = self:_HandlePickTrap(petEntity, pickUpGridPos, previewPickUpComponent, skillConfigData)
  utilScopeSvc:ChangeGameFSMState2PickUp()
  if previewActiveSkill then
    previewActiveSkill:ResetPreview()
    self:_DoInstruction(PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
  end
  self:UpdateUI(previewPickUpComponent, checkPowerEnough, activeSkillID)
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandlePickInvalidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次点选无效目标生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  if previewActiveSkill then
    self:_DoInstruction(PickUpInstructionType.Invalid, skillConfigData, petEntity, pickUpGridPos)
  end
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandlePickCancelPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  if previewActiveSkill then
    previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
  end
end

function SkillPickUpDiffPowerInstructionSystem_Render:_HandlePickTrap(petEntity, pickUpGridPos, previewPickUpComponent, skillConfigData)
  local checkPowerEnough = true
  if self._tarTrapId then
    local bPickTrap = false
    local udsvc = self._world:GetService("UtilData")
    local traps = udsvc:GetTrapsAtPos(pickUpGridPos)
    if traps then
      for index, e in ipairs(traps) do
        if self._tarTrapId == e:TrapRender():GetTrapID() then
          bPickTrap = true
        end
      end
    end
    if bPickTrap then
      previewPickUpComponent:RemovePickExtraParam(SkillTriggerTypeExtraParam.PickPosNoCfgTrap)
      GameGlobal:EventDispatcher():Dispatch(GameEventType.SetCurPickExtraParam, skillConfigData:GetID(), previewPickUpComponent:GetAllPickExtraParam())
    else
      if not previewPickUpComponent:HasPickExtraParam(SkillTriggerTypeExtraParam.PickPosNoCfgTrap) then
        previewPickUpComponent:AddPickExtraParam(SkillTriggerTypeExtraParam.PickPosNoCfgTrap)
      end
      GameGlobal:EventDispatcher():Dispatch(GameEventType.SetCurPickExtraParam, skillConfigData:GetID(), previewPickUpComponent:GetAllPickExtraParam())
      local cfgExtraParam = skillConfigData:GetSkillTriggerExtraParam()
      if cfgExtraParam and cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap] then
        local newCost = cfgExtraParam[SkillTriggerTypeExtraParam.PickPosNoCfgTrap]
        local legendPower = udsvc:GetEntityAttributeByName(petEntity, "LegendPower")
        if legendPower and newCost > legendPower then
          checkPowerEnough = false
        end
      end
    end
  end
  return checkPowerEnough
end

function SkillPickUpDiffPowerInstructionSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpDiffPowerInstructionSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
  if type == PickUpInstructionType.Repeat then
    return skillPreviewConfigData:GetOnSelectCancelInstructionSet()
  end
  if type == PickUpInstructionType.Invalid then
    return skillPreviewConfigData:GetOnSelectInvalidInstructionSet()
  end
  if type == PickUpInstructionType.Valid then
    return skillPreviewConfigData:GetOnSelectValidInstructionSet()
  end
  if type == PickUpInstructionType.Empty then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  return nil
end

function SkillPickUpDiffPowerInstructionSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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

function SkillPickUpDiffPowerInstructionSystem_Render:ProcessInvalidGridList(validGridList, invalidGridList)
  local fun = self._ProgressInvalidFunc[self._pickUpType]
  return fun(self, validGridList, invalidGridList)
end

function SkillPickUpDiffPowerInstructionSystem_Render:ProgressInvalidGridList_PickGrid(validGridList, invalidGridList)
  local tv2FilteredInvalidGridList = {}
  for _, v2 in ipairs(invalidGridList) do
    if table.icontains(validGridList, v2) then
      table.insert(tv2FilteredInvalidGridList, v2)
    end
  end
  local tv2FilteredValidGridList = {}
  for _, v2 in ipairs(validGridList) do
    if not table.icontains(tv2FilteredInvalidGridList, v2) then
      table.insert(tv2FilteredValidGridList, v2)
    end
  end
  validGridList = tv2FilteredValidGridList
  return tv2FilteredValidGridList
end

function SkillPickUpDiffPowerInstructionSystem_Render:ProgressInvalidGridList_PickColor(validGridList, invalidGridList)
  return validGridList
end

function SkillPickUpDiffPowerInstructionSystem_Render:IsRepeatPickUP(allPickUpPos, pickUpGridPos)
  return self._IsRepeatPickupFunc[self._pickUpType](self, allPickUpPos, pickUpGridPos)
end

function SkillPickUpDiffPowerInstructionSystem_Render:IsRepeatPickUP_PickGrid(allPickUpPos, pickUpGridPos)
  return table.icontains(allPickUpPos, pickUpGridPos)
end

function SkillPickUpDiffPowerInstructionSystem_Render:IsRepeatPickUP_PickColor(allPickUpPos, pickUpGridPos)
  local utilDataSvc = self._world:GetService("UtilData")
  if table.count(allPickUpPos) > 0 then
    local pickPieceType = utilDataSvc:GetPieceType(pickUpGridPos)
    for _, pos in pairs(allPickUpPos) do
      local alreadyPieceType = utilDataSvc:GetPieceType(pos)
      if pickPieceType == alreadyPieceType then
        return true
      end
    end
    return false
  else
    return false
  end
end

function SkillPickUpDiffPowerInstructionSystem_Render:RemovePickUpGridPos_PickGrid(previewPickUpComponent, pickGridPos)
  previewPickUpComponent:RemoveGridPos(pickGridPos)
end

function SkillPickUpDiffPowerInstructionSystem_Render:RemovePickUpGridPos_PickColor(previewPickUpComponent, pickGridPos)
  previewPickUpComponent:ClearGridPos()
end

function SkillPickUpDiffPowerInstructionSystem_Render:RemoveRepeatPickUpGrid(previewPickUpComponent, pickGridPos)
  self._RemovePickUpGridPos[self._pickUpType](self, previewPickUpComponent, pickGridPos)
end
