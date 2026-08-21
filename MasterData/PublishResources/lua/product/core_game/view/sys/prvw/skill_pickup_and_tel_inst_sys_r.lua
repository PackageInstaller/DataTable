_class("SkillPickUpAndTeleportInstructionSystem_Render", ReactiveSystem)
SkillPickUpAndTeleportInstructionSystem_Render = SkillPickUpAndTeleportInstructionSystem_Render

function SkillPickUpAndTeleportInstructionSystem_Render:Constructor(world)
  self._world = world
  self._isGuide = false
  self._pickUpType = nil
  self._IsRepeatPickupFunc = {}
  self._IsRepeatPickupFunc[SkillPickUpType.PickAndTeleportInst] = self.IsRepeatPickUP_PickGrid
  self._ProgressInvalidFunc = {}
  self._ProgressInvalidFunc[SkillPickUpType.PickAndTeleportInst] = self.ProgressInvalidGridList_PickGrid
  self._RemovePickUpGridPos = {}
  self._RemovePickUpGridPos[SkillPickUpType.PickAndTeleportInst] = self.RemovePickUpGridPos_PickGrid
end

function SkillPickUpAndTeleportInstructionSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpAndTeleportInstructionSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.PickAndTeleportInst then
    return true
  end
  return false
end

function SkillPickUpAndTeleportInstructionSystem_Render:ExecuteEntities(entities)
  for i = 1, #entities do
    self:DoPickUp(entities[i])
  end
end

function SkillPickUpAndTeleportInstructionSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
  local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local renderBoardEntity = self._world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local utilDataSvc = self._world:GetService("UtilData")
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID)
  local entityID = 0
  if skillConfigData:GetSkillType() == SkillType.Active then
    entityID = utilDataSvc:GetEntityIDByPstID(pickUpTargetCmpt:GetPetPstid())
    local caster = self._world:GetEntityByID(entityID)
    skillConfigData = configService:GetSkillConfigData(activeSkillID, caster)
  elseif skillConfigData:GetSkillType() == SkillType.TrapSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  elseif skillConfigData:GetSkillType() == SkillType.FeatureSkill then
    entityID = pickUpTargetCmpt:GetEntityID()
  end
  local petEntity = self._world:GetEntityByID(entityID)
  if not petEntity:HasPreviewPickUpComponent() then
    petEntity:AddPreviewPickUpComponent()
  end
  local validGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpValidScopeList, petEntity)
  local skillScopeGridList = utilScopeSvc:CalcSkillResultByConfigData(skillConfigData, petEntity)
  local invalidGridList = utilScopeSvc:BuildScopeGridList(skillConfigData._pickUpInvalidScopeList, petEntity)
  self:ProcessInvalidGridList(validGridList, invalidGridList)
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1])
  local pickTelIndex = tonumber(skillConfigData._pickUpParam[2])
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:SetIgnorePickCheck(true)
  local alreadyPickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  if self:IsRepeatPickUP(previewPickUpComponent:GetLastPickUpGridPos(), pickUpGridPos) then
    Log.debug("本次重复点选生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    previewPickUpComponent:RemoveGridPos(pickUpGridPos)
    local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
    self:UpdateUI(previewPickUpComponent)
    if pickUpCount == 0 then
      Log.debug("本次重复点选 清空点选列表，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos)
    else
      Log.debug("本次重复点选 去掉瞬移位置，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
      GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
    end
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndTelInsRepeat, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
  elseif pickTelIndex <= alreadyPickUpCount + 1 then
    if pickTelIndex < alreadyPickUpCount + 1 then
      if self:IsRepeatPickUP(previewPickUpComponent:GetFirstValidPickUpGridPos(), pickUpGridPos) then
        Log.debug("本次点选位置无效,没有取消瞬移位置就点选怪物，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
        return
      end
      if self:IsPosCanTel(skillScopeGridList, pickUpGridPos, previewPickUpComponent) then
        Log.debug("本次点选新瞬移位置生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
        local lastPickUpPos = previewPickUpComponent:GetLastPickUpGridPos()
        previewPickUpComponent:RemoveGridPos(lastPickUpPos)
      end
    end
    if self:_CheckMonsterSingleAndCanHitBack(previewPickUpComponent) then
      if self:IsPosCanTel(skillScopeGridList, pickUpGridPos, previewPickUpComponent) then
        Log.debug("本次怪物放置位置生效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
        previewPickUpComponent:AddGridPos(pickUpGridPos)
        self:UpdateUI(previewPickUpComponent)
        GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
      elseif AutoPickCheckHelperRender.IsAutoFightRunning() then
        AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndTelInsCanNotTel, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
      end
    else
      Log.debug("本次怪物放置位置无效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    end
  elseif table.Vector2Include(validGridList, pickUpGridPos) then
    utilScopeSvc:ChangeGameFSMState2PickUp()
    previewPickUpComponent:AddGridPos(pickUpGridPos)
    self:UpdateUI(previewPickUpComponent)
    GameGlobal.TaskManager():CoreGameStartTask(previewActiveSkill._DoPickUpInstruction, previewActiveSkill, PickUpInstructionType.Repeat, skillConfigData, petEntity, pickUpGridPos)
  else
    previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, pickUpTargetCmpt:GetPetPstid())
    Log.debug("本次重复点选无效，坐标：", tostring(pickUpGridPos), "SkillID:", activeSkillID)
    if AutoPickCheckHelperRender.IsAutoFightRunning() then
      AutoPickCheckHelperRender.ReportAutoFightPickError(ActivePickSkillCheckErrorStep.PickAndTelInsInvalid, ActivePickSkillCheckErrorType.None, activeSkillID, pickUpGridPos)
    end
  end
end

function SkillPickUpAndTeleportInstructionSystem_Render:ProcessInvalidGridList(validGridList, invalidGridList)
  local fun = self._ProgressInvalidFunc[self._pickUpType]
  return fun(self, validGridList, invalidGridList)
end

function SkillPickUpAndTeleportInstructionSystem_Render:ProgressInvalidGridList_PickGrid(validGridList, invalidGridList)
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
  invalidGridList = tv2FilteredInvalidGridList
end

function SkillPickUpAndTeleportInstructionSystem_Render:IsRepeatPickUP(lastPickUpPos, pickUpGridPos)
  if lastPickUpPos then
    return lastPickUpPos.x == pickUpGridPos.x and lastPickUpPos.y == pickUpGridPos.y
  else
    return false
  end
end

function SkillPickUpAndTeleportInstructionSystem_Render:_CheckMonsterSingleAndCanHitBack(previewPickUpComponent)
  if previewPickUpComponent:GetAllValidPickUpGridPosCount() == 1 then
    local utilDataSvc = self._world:GetService("UtilData")
    local pos = previewPickUpComponent:GetLastPickUpGridPos()
    local entity = utilDataSvc:GetMonsterAtPos(pos)
    local areaCmpt = entity:BodyArea()
    local env = self._world:GetPreviewEntity():PreviewEnv()
    if not env:IsImmuneHitback(entity) and #areaCmpt:GetArea() == 1 then
      return true
    end
  end
  return false
end

function SkillPickUpAndTeleportInstructionSystem_Render:UpdateUI(previewPickUpComponent)
  local pickUpCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  local pickUpGridList = previewPickUpComponent:GetAllValidPickUpGridPos()
  local leftPickUpNum = 0
  local canCast = false
  local uiTextState = SkillPickUpTextStateType.Normal
  if pickUpCount == 1 then
    if self:_CheckMonsterSingleAndCanHitBack(previewPickUpComponent) then
      uiTextState = SkillPickUpTextStateType.Tel
      leftPickUpNum = 1
    end
    canCast = true
  elseif pickUpCount == 2 then
    uiTextState = SkillPickUpTextStateType.Tel
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

function SkillPickUpAndTeleportInstructionSystem_Render:IsPosCanTel(skillGridList, pos, previewPickUpComponent)
  if not table.Vector2Include(skillGridList, pos) then
    return false
  end
  local monsterPos = previewPickUpComponent:GetFirstValidPickUpGridPos()
  local utilDataSvc = self._world:GetService("UtilData")
  local entity = utilDataSvc:GetMonsterAtPos(monsterPos)
  return utilDataSvc:IsMonsterCanTel2TargetPos(entity, pos)
end
