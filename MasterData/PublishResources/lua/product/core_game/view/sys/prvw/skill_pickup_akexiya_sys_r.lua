_class("SkillPickUpAkexiyaInstructionSystem_Render", ReactiveSystem)
SkillPickUpAkexiyaInstructionSystem_Render = SkillPickUpAkexiyaInstructionSystem_Render

function SkillPickUpAkexiyaInstructionSystem_Render:Constructor(world)
  self._world = world
  self._isGuide = false
  self._pickUpType = nil
  self._RemovePickUpGridPos = {}
  self._RemovePickUpGridPos[SkillPickUpType.Instruction] = self.RemovePickUpGridPos_PickGrid
  self._RemovePickUpGridPos[SkillPickUpType.ColorInstruction] = self.RemovePickUpGridPos_PickColor
end

function SkillPickUpAkexiyaInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpAkexiyaInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.Akexiya then
    return true
  end
  return false
end

function SkillPickUpAkexiyaInstructionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpAkexiyaInstructionSystem_Render:_IsPosHasMonsterOrEnemyTeam(pos, casterEntity)
  local bFind = false
  local utilData = self._world:GetService("UtilData")
  if self._world:MatchType() == MatchType.MT_BlackFist then
    if casterEntity:HasPet() then
      local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
      local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
      local enemyTeamPos = enemyEntity:GetGridPosition()
      if enemyTeamPos == pos then
        bFind = true
      end
    end
  else
    bFind = utilData:IsPosListHaveMonster({pos})
  end
  return bFind
end

function SkillPickUpAkexiyaInstructionSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local entityID = 0
  local petEntity
  if skillConfigData:GetSkillType() == SkillType.Active then
    entityID = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
    petEntity = self._world:GetEntityByID(entityID)
    skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  elseif skillConfigData:GetSkillType() == SkillType.FeatureSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  end
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local musPickUpNum
  if skillConfigData._pickUpParam[2] then
    musPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  end
  local isPickFirstRepeatRemoveAll = false
  if skillConfigData._pickUpParam[3] then
    local param3 = tonumber(skillConfigData._pickUpParam[3])
    isPickFirstRepeatRemoveAll = param3 == 1
  end
  local secondPickInvalidToChangeFirst = false
  if skillConfigData._pickUpParam[4] then
    local param4 = tonumber(skillConfigData._pickUpParam[4])
    secondPickInvalidToChangeFirst = param4 == 1
  end
  local trapID = 0
  if skillConfigData._pickUpParam[5] then
    trapID = tonumber(skillConfigData._pickUpParam[5])
  end
  local trapFirst = false
  if skillConfigData._pickUpParam[6] then
    local param6 = tonumber(skillConfigData._pickUpParam[6])
    trapFirst = param6 == 1
  end
  local pickUpValidScopeList = {}
  local pickUpInvalidScopeList = {}
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  if previewPickUpComponent:GetAllValidPickUpGridPosCount() == 0 then
    pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
    pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickInvalidScopeList or {})
  else
    local firstPickup = previewPickUpComponent:GetFirstValidPickUpGridPos()
    local utilData = self._world:GetService("UtilData")
    if trapFirst then
      local isPickTrap = false
      local tTrapEntities = utilData:GetTrapsAtPos(firstPickup)
      for _, e in ipairs(tTrapEntities) do
        if e:TrapID():GetTrapID() == trapID then
          isPickTrap = true
          break
        end
      end
      if isPickTrap then
        pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickValidScopeList or {})
        pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickInvalidScopeList or {})
      else
        pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickValidScopeList or {})
        pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickInvalidScopeList or {})
      end
    elseif self:_IsPosHasMonsterOrEnemyTeam(firstPickup, petEntity) then
      pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickValidScopeList or {})
      pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickInvalidScopeList or {})
    else
      pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickValidScopeList or {})
      pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickInvalidScopeList or {})
    end
  end
  local validGridList = utilScopeSvc:BuildScopeGridList(pickUpValidScopeList, petEntity) or {}
  local invalidGridList = utilScopeSvc:BuildScopeGridList(pickUpInvalidScopeList, petEntity) or {}
  validGridList = self:ProcessInvalidGridList(validGridList, invalidGridList)
  if self:IsRepeatPickUP(previewPickUpComponent:GetAllValidPickUpGridPos(), pickUpGridPos) then
    local guideService = self._world:GetService("Guide")
    if guideService then
      local isValid = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
      if self._isGuide then
        return
      end
    end
    Log.debug("本次重复点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickInsRepeat, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    if isPickFirstRepeatRemoveAll then
      local firstPickPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
      if firstPickPos and firstPickPos == pickUpGridPos then
        previewPickUpComponent:ClearGridPos()
      else
        self:RemoveRepeatPickUpGrid(previewPickUpComponent, pickUpGridPos)
      end
    else
      self:RemoveRepeatPickUpGrid(previewPickUpComponent, pickUpGridPos)
    end
    if previewActiveSkill then
      previewActiveSkill:ResetPreview()
      previewActiveSkill:_RevertAllConvertElement()
      if previewPickUpComponent:GetAllValidPickUpGridPosCount() == 0 then
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
      else
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
      end
    end
    previewActiveSkill:UpdateUI(pickUpNum, musPickUpNum, previewPickUpComponent)
    return
  end
  if secondPickInvalidToChangeFirst and previewPickUpComponent:GetAllValidPickUpGridPosCount() == 1 and not table.icontains(validGridList, pickUpGridPos) then
    local utilDataSvc = self._world:GetService("UtilData")
    if utilDataSvc:IsValidPiecePos(pickUpGridPos) then
      previewPickUpComponent:ClearGridPos()
      validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
      invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
      validGridList = self:ProcessInvalidGridList(validGridList, invalidGridList)
    end
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
      Log.debug("本次点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      if previewActiveSkill then
        previewActiveSkill:ResetPreview()
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      end
      previewActiveSkill:UpdateUI(pickUpNum, musPickUpNum, previewPickUpComponent)
    else
      previewPickUpComponent:RemoveGridPos(previewPickUpComponent:GetLastPickUpGridPos())
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      if previewActiveSkill then
        previewActiveSkill:ResetPreview()
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      end
      previewActiveSkill:UpdateUI(pickUpNum, musPickUpNum, previewPickUpComponent)
    end
  else
    local guideService = self._world:GetService("Guide")
    local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
    if not isValid then
      return
    end
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
    if table.icontains(invalidGridList, pickUpGridPos) then
      Log.debug("本次点选无效目标生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      if previewActiveSkill then
        GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Invalid, skillConfigData, petEntity, pickUpGridPos)
      end
    elseif previewActiveSkill then
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
    end
  end
end

function SkillPickUpAkexiyaInstructionSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpAkexiyaInstructionSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
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

function SkillPickUpAkexiyaInstructionSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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

function SkillPickUpAkexiyaInstructionSystem_Render:ProcessInvalidGridList(validGridList, invalidGridList)
  return self.ProgressInvalidGridList_PickGrid(self, validGridList, invalidGridList)
end

function SkillPickUpAkexiyaInstructionSystem_Render:ProgressInvalidGridList_PickGrid(validGridList, invalidGridList)
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

function SkillPickUpAkexiyaInstructionSystem_Render:ProgressInvalidGridList_PickColor(validGridList, invalidGridList)
  return validGridList
end

function SkillPickUpAkexiyaInstructionSystem_Render:IsRepeatPickUP(allPickUpPos, pickUpGridPos)
  return self.IsRepeatPickUP_PickGrid(self, allPickUpPos, pickUpGridPos)
end

function SkillPickUpAkexiyaInstructionSystem_Render:IsRepeatPickUP_PickGrid(allPickUpPos, pickUpGridPos)
  return table.icontains(allPickUpPos, pickUpGridPos)
end

function SkillPickUpAkexiyaInstructionSystem_Render:IsRepeatPickUP_PickColor(allPickUpPos, pickUpGridPos)
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

function SkillPickUpAkexiyaInstructionSystem_Render:RemovePickUpGridPos_PickGrid(previewPickUpComponent, pickGridPos)
  previewPickUpComponent:RemoveGridPos(pickGridPos)
end

function SkillPickUpAkexiyaInstructionSystem_Render:RemovePickUpGridPos_PickColor(previewPickUpComponent, pickGridPos)
  previewPickUpComponent:ClearGridPos()
end

function SkillPickUpAkexiyaInstructionSystem_Render:RemoveRepeatPickUpGrid(previewPickUpComponent, pickGridPos)
  self.RemovePickUpGridPos_PickGrid(self, previewPickUpComponent, pickGridPos)
end

function SkillPickUpAkexiyaInstructionSystem_Render:_ParseScopeList(list)
  local parser = SkillScopeParamParser:New()
  local t = {}
  for _, v in ipairs(list) do
    local param = SkillPreviewScopeParam:New(v)
    local data = parser:ParseScopeParam(v.ScopeType, v.ScopeParam)
    param:SetScopeParamData(data)
    table.insert(t, param)
  end
  return t
end
