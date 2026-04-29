_class("SkillPickUpTetrisInstSystem_Render", ReactiveSystem)
SkillPickUpTetrisInstSystem_Render = SkillPickUpTetrisInstSystem_Render

function SkillPickUpTetrisInstSystem_Render:Constructor(world)
  self._world = world
end

function SkillPickUpTetrisInstSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpTetrisInstSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickUpAndTurnTetris then
    return true
  end
  return false
end

function SkillPickUpTetrisInstSystem_Render:IsPosInvalid(pos)
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
end

function SkillPickUpTetrisInstSystem_Render:ExecuteEntities(entities)
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
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local activeSkillPickUpComponent = petEntity:ActiveSkillPickUpComponent()
  local alreadyPickUpGrid = activeSkillPickUpComponent:GetAllValidPickUpGridPos()
  local guideService = self._world:GetService("Guide")
  if guideService then
    if guideService:IsValidGuidePiecePos(pickUpGridPos.x, pickUpGridPos.y) then
      self._world:EventDispatcher():Dispatch(GameEventType.FinishGuideStep, GuideType.Piece)
    else
      return
    end
  end
  if #alreadyPickUpGrid == 0 then
    if table.icontains(validGridList, pickUpGridPos) then
      local utilDataSvcL = self._world:GetService("UtilData")
      local newDirIndex = utilDataSvcL:GetFeatureTetrisDirIndex()
      activeSkillPickUpComponent:SetTetrisDirIndex(newDirIndex)
      Log.debug("第一次点选，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      activeSkillPickUpComponent:AddGridPos(pickUpGridPos)
      utilScopeSvc:ChangeGameFSMState2PickUp()
      self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, 0)
      self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, true)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Valid, skillConfigData, petEntity, pickUpGridPos)
    else
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
      Log.debug("本次点选无效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    end
  elseif table.Vector2Include(alreadyPickUpGrid, pickUpGridPos) then
    local utilCalcSvcL = self._world:GetService("UtilCalc")
    local newDirType, newDirIndex = utilCalcSvcL:TurnTetrisDir()
    activeSkillPickUpComponent:SetTetrisDirIndex(newDirIndex)
    Log.debug("重复点选,旋转,坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  else
    Log.debug("点选其他格子，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    activeSkillPickUpComponent:ClearGridPos()
    self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, pickUpNum)
    self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, false)
    GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
  end
end
