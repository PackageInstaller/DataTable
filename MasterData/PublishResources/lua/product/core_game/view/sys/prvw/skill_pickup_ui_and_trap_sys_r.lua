_class("SkillPickUpUIAndTrapInstSystem_Render", ReactiveSystem)
SkillPickUpUIAndTrapInstSystem_Render = SkillPickUpUIAndTrapInstSystem_Render

function SkillPickUpUIAndTrapInstSystem_Render:Constructor(world)
  self._world = world
end

function SkillPickUpUIAndTrapInstSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpUIAndTrapInstSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickUpUIAndTrap then
    return true
  end
  return false
end

function SkillPickUpUIAndTrapInstSystem_Render:IsPosInvalid(pos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
end

function SkillPickUpUIAndTrapInstSystem_Render:ExecuteEntities(entities)
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petEntityId = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
  local petEntity = self._world:GetEntityByID(petEntityId)
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local validGirdList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  if not table.Vector2Include(validGirdList, pickUpGridPos) then
    previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
  end
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  if pickUpNum == 0 then
    return
  end
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
  local alreadyPickUpGrid = previewPickUpComponent:GetAllValidPickUpGridPos()
  local guideService = self._world:GetService("Guide")
  if guideService then
    if guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y) then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    else
      return
    end
  end
  if table.icontains(validGirdList, pickUpGridPos) then
    if 0 < #alreadyPickUpGrid then
      if pickUpNum == 1 then
        if table.Vector2Include(alreadyPickUpGrid, pickUpGridPos) then
          Log.debug("只可点选一次,重复点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
          previewPickUpComponent:RemoveGridPos(pickUpGridPos)
          self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, 1)
          GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
        end
        self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
      end
    else
      Log.debug("第一次点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      previewPickUpComponent:ClearPickUpPetPstID()
      utilScopeSvc:ChangeGameFSMState2PickUp()
      GameGlobal.EventDispatcher():Dispatch(GameEventType.IstavanPreviewCancelPetHeadUI, false)
      self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, 0)
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
      if pickUpNum == 1 then
        self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, SkillPickUpTextStateType.Normal)
      else
        self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, SkillPickUpTextStateType.ColOrRow)
      end
      GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
    end
  end
end

function SkillPickUpUIAndTrapInstSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos)
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

function SkillPickUpUIAndTrapInstSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
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

function SkillPickUpUIAndTrapInstSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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
