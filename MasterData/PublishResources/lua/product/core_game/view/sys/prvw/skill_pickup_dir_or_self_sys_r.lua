_class("SkillPickUpDirOrSelfSystem_Render", ReactiveSystem)
SkillPickUpDirOrSelfSystem_Render = SkillPickUpDirOrSelfSystem_Render

function SkillPickUpDirOrSelfSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
  self._pickUpNum = 0
  self._ProgressInvalidFunc = {}
  self._ProgressInvalidFunc[SkillPickUpType.PickDirOrSelf] = self.ProgressInvalidGridList_PickGrid
end

function SkillPickUpDirOrSelfSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpDirOrSelfSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickDirOrSelf then
    return true
  end
  return false
end

function SkillPickUpDirOrSelfSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpDirOrSelfSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  validGridList = self:ProcessInvalidGridList(validGridList, invalidGridList)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1]) or 0
  self._pickUpNum = pickUpNum
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:SetIgnorePickCheck(true)
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local casterPos = petEntity:GetGridPosition()
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
  if table.icontains(validGridList, pickUpGridPos) then
    if pickUpGridPos == casterPos then
      if previewPickUpComponent:IsRepeatPickUP(pickUpGridPos) then
        self:_HandlePickRepeatPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
      else
        self:_HandlePickValidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
      end
    else
      local direction = scopeCalculator:GetDirection(pickUpGridPos, casterPos)
      if self:_IsCrossDir(direction) then
        if previewPickUpComponent:IsRepeatDirection(direction) then
          self:_HandlePickRepeatDirType(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
        else
          self:_HandlePickValidDirType(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent, direction)
        end
      end
    end
  else
    self:_HandlePickInvalid(pickUpTargetCmpt)
  end
end

function SkillPickUpDirOrSelfSystem_Render:_HandlePickInvalid(pickUpTargetCmpt)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  if previewActiveSkill then
    previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
  end
end

function SkillPickUpDirOrSelfSystem_Render:_HandlePickRepeatPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次重复点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:RemoveGridPos(pickUpGridPos)
  if previewActiveSkill then
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  end
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpDirOrSelfSystem_Render:_HandlePickValidPos(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:ClearDirection()
  previewPickUpComponent:ClearGridPos()
  previewPickUpComponent:AddGridPos(pickUpGridPos)
  previewActiveSkill:DestroyPickUpArrow()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  utilScopeSvc:ChangeGameFSMState2PickUp()
  if previewActiveSkill then
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
  end
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpDirOrSelfSystem_Render:_HandlePickRepeatDirType(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  Log.debug("本次重复点选方向生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:ClearDirection()
  local casterPos = petEntity:GetGridPosition()
  self:_ShowPickUpArrow(pickUpGridPos, casterPos, false)
  if previewActiveSkill then
    previewActiveSkill:ResetPreview()
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  end
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpDirOrSelfSystem_Render:_HandlePickValidDirType(pickUpTargetCmpt, skillConfigData, petEntity, previewPickUpComponent, direction)
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local lastDir = previewPickUpComponent:GetLastPickUpDirection()
  if lastDir == direction then
    return
  end
  Log.debug("本次点选方向生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
  previewPickUpComponent:ClearGridPos(pickUpGridPos)
  previewPickUpComponent:ClearDirection()
  previewPickUpComponent:AddDirection(direction, pickUpGridPos)
  previewPickUpComponent:AddGridPos(pickUpGridPos)
  local casterPos = petEntity:GetGridPosition()
  self:_ShowPickUpArrow(pickUpGridPos, casterPos, true)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  utilScopeSvc:ChangeGameFSMState2PickUp()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  if previewActiveSkill then
    previewActiveSkill:ResetPreview()
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
  end
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpDirOrSelfSystem_Render:_IsCrossDir(dirType)
  if dirType == HitBackDirectionType.Down or dirType == HitBackDirectionType.Up or dirType == HitBackDirectionType.Left or dirType == HitBackDirectionType.Right then
    return true
  end
  return false
end

function SkillPickUpDirOrSelfSystem_Render:UpdateUI(previewPickUpComponent)
  local gridCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local canCast = false
  local leftPickUpNumber = self._pickUpNum
  if 0 < gridCount then
    canCast = true
    leftPickUpNumber = leftPickUpNumber - gridCount
  end
  if leftPickUpNumber < 0 then
    leftPickUpNumber = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftPickUpNumber)
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
end

function SkillPickUpDirOrSelfSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpDirOrSelfSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
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

function SkillPickUpDirOrSelfSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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

function SkillPickUpDirOrSelfSystem_Render:ProcessInvalidGridList(validGridList, invalidGridList)
  local fun = self._ProgressInvalidFunc[self._pickUpType]
  return fun(self, validGridList, invalidGridList)
end

function SkillPickUpDirOrSelfSystem_Render:ProgressInvalidGridList_PickGrid(validGridList, invalidGridList)
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

function SkillPickUpDirOrSelfSystem_Render:_ShowPickUpArrow(gridPos, casterPos, isSelect)
  local dis = gridPos - casterPos
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
