_class("SkillPickUpAlGoreInstSystem_Render", ReactiveSystem)
SkillPickUpAlGoreInstSystem_Render = SkillPickUpAlGoreInstSystem_Render

function SkillPickUpAlGoreInstSystem_Render:Constructor(world)
  self._world = world
end

function SkillPickUpAlGoreInstSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpAlGoreInstSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.AlGorePickUp then
    return true
  end
  return false
end

function SkillPickUpAlGoreInstSystem_Render:IsPosInvalid(pos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
end

function SkillPickUpAlGoreInstSystem_Render:ExecuteEntities(entities)
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
  local firstValidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local firstPickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local secondPickUpNum = tonumber(skillConfigData._pickUpParam[2])
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local activeSkillPickUpComponent = petEntity:ActiveSkillPickUpComponent()
  local alreadyPickUpGrid = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
  local secondValidScopeList = {}
  if 0 < #alreadyPickUpGrid then
    secondValidScopeList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity, alreadyPickUpGrid[1])
  end
  local guideService = self._world:GetService("Guide")
  if guideService then
    if guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y) then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    else
      return
    end
  end
  if #alreadyPickUpGrid == 0 then
    if table.icontains(firstValidGridList, pickUpGridPos) then
      Log.debug("第一次点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      activeSkillPickUpComponent:AddGridPos(pickUpGridPos)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, secondPickUpNum)
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
      self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, SkillPickUpTextStateType.ChangePreText, true)
    else
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
      Log.debug("本次点选无效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    end
  elseif table.icontains(secondValidScopeList, pickUpGridPos) then
    if table.Vector2Include(alreadyPickUpGrid, pickUpGridPos) then
      Log.debug("只可点选一次,二次点选重复点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      activeSkillPickUpComponent:RemoveGridPos(pickUpGridPos)
    else
      if secondPickUpNum <= #alreadyPickUpGrid - 1 then
        Log.debug("点选次数超了，只可以点选 ", secondPickUpNum, " 次 已经点选:", #alreadyPickUpGrid - 1, " 坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
        return
      end
      activeSkillPickUpComponent:AddGridPos(pickUpGridPos)
    end
    alreadyPickUpGrid = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
    self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, secondPickUpNum - #alreadyPickUpGrid + 1)
    if 1 < #alreadyPickUpGrid then
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
    else
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    end
    GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  elseif table.icontains(firstValidGridList, pickUpGridPos) and #alreadyPickUpGrid == 1 then
    if table.Vector2Include(alreadyPickUpGrid, pickUpGridPos) then
      Log.debug("第一次点选 重复点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      activeSkillPickUpComponent:RemoveGridPos(pickUpGridPos)
      self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, 1)
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
      self._world:EventDispatcher():Dispatch(GameEventType.ChangePickUpText, SkillPickUpTextStateType.ChangePreText, false)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
    else
      Log.debug("第一次点选 替换点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      activeSkillPickUpComponent:ClearGridPos()
      activeSkillPickUpComponent:AddGridPos(pickUpGridPos)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
    end
  end
end
