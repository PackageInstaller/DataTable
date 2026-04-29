_class("SkillPickUpPuzzleSystem_Render", ReactiveSystem)
SkillPickUpPuzzleSystem_Render = SkillPickUpPuzzleSystem_Render

function SkillPickUpPuzzleSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
end

function SkillPickUpPuzzleSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpPuzzleSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.Puzzle then
    return true
  end
  return false
end

function SkillPickUpPuzzleSystem_Render:ExecuteEntities(entities)
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if not previewPuzzleCmpt then
    return
  end
  for i = 1, #entities do
    if previewPuzzleCmpt:GetPuzzleState() == PuzzleStateType.Enter then
      self:DoPuzzle(entities[i])
    elseif previewPuzzleCmpt:GetPuzzleState() == PuzzleStateType.None then
      self:DoPickUp(entities[i])
    end
  end
end

function SkillPickUpPuzzleSystem_Render:DoPuzzle(entity)
  local previewEntity = self._world:GetPreviewEntity()
  local previewPuzzleCmpt = previewEntity:PreviewPuzzle()
  if not previewPuzzleCmpt then
    return
  end
  local gapTilePos = previewPuzzleCmpt:GetGapTilePos()
  local puzzleRange = previewPuzzleCmpt:GetPuzzleRange()
  local pickUpTargetCmpt = entity:PickUpTarget()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local guideService = self._world:GetService("Guide")
  local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
  if isValid then
    if isGuide then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    end
  else
    return
  end
  local utilDataSvc = self._world:GetService("UtilData")
  local isValid = utilDataSvc:CheckPuzzlePickUpIsValid(pickUpGridPos, gapTilePos, puzzleRange)
  if isValid then
    local previewPuzzleSvc = self._world:GetService("PreviewPuzzle")
    previewPuzzleSvc:PuzzlePickUpGrid(pickUpGridPos)
  end
end

function SkillPickUpPuzzleSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local petPstID = pickUpTargetCmpt:GetPetPstid()
  local petEntityId = utilDataSvc:GetEntityIDByPstID(petPstID)
  local petEntity = self._world:GetEntityByID(petEntityId)
  if not petEntity then
    local entityID = pickUpTargetCmpt:GetEntityID()
    petEntity = self._world:GetEntityByID(entityID)
  end
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, petEntity)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData:GetPickUpValidScopeConfig(), petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData:GetPickUpInvalidScopeConfig(), petEntity)
  for _, pos in ipairs(invalidGridList) do
    if table.intable(validGridList, pos) then
      table.removev(validGridList, pos)
    end
  end
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  local pickUpNum = 1
  if table.icontains(previewPickUpComponent:GetAllValidPickUpGridPos(), pickUpGridPos) then
    previewPickUpComponent:ClearGridPos()
    previewActiveSkillSvc:ResetPreview()
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
    self:UpdateUI(pickUpNum, false)
    return
  end
  local guideService = self._world:GetService("Guide")
  local isValid, isGuide = guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y)
  if isValid then
    if isGuide then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    end
  else
    return
  end
  if table.icontains(validGridList, pickUpGridPos) then
    if pickUpNum == previewPickUpComponent:GetAllValidPickUpGridPosCount() then
      previewPickUpComponent:ClearGridPos()
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      previewActiveSkillSvc:ResetPreview()
      GameGlobal.TaskManager():CoreGameStartTask(function(TT)
        self:_DoPickUpInstruction(TT, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
        self:_DoPickUpInstruction(TT, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      end)
    else
      previewPickUpComponent:AddGridPos(pickUpGridPos)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      previewActiveSkillSvc:ResetPreview()
      GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      self:UpdateUI(0, true)
    end
  else
    local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
    if previewActiveSkillSvc then
      previewActiveSkillSvc:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
    end
  end
end

function SkillPickUpPuzzleSystem_Render:UpdateUI(pickUpNum, canCast)
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, pickUpNum)
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
end

function SkillPickUpPuzzleSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGridPos)
  local taskIDList = {}
  local previewActiveSkillSvc = self._world:GetService("PreviewActiveSkill")
  for _, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, preCfgData in ipairs(instructionParam._previewList) do
        local instructionSet = self:_GetInstructSet(type, preCfgData)
        if instructionSet then
          local context = previewActiveSkillSvc:CreatePreviewContext(preCfgData, casterEntity, pickUpGridPos)
          local taskID = GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkillSvc.DoPreviewInstruction, previewActiveSkillSvc, instructionSet, casterEntity, context)
          table.insert(taskIDList, taskID)
        end
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function SkillPickUpPuzzleSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
  if type == PickUpInstructionType.Valid then
    return skillPreviewConfigData:GetOnSelectValidInstructionSet()
  end
  if type == PickUpInstructionType.Empty then
    return skillPreviewConfigData:GetOnSelectEmptyInstructionSet()
  end
  return nil
end
