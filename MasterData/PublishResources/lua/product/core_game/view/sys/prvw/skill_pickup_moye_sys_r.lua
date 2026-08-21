_class("SkillPickUpMoyeSystem_Render", ReactiveSystem)
SkillPickUpMoyeSystem_Render = SkillPickUpMoyeSystem_Render

function SkillPickUpMoyeSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
  self._pickUpNum = 0
end

function SkillPickUpMoyeSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpMoyeSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.Moye then
    return true
  end
  return false
end

function SkillPickUpMoyeSystem_Render:ExecuteEntities(entities)
  local inputCmpt = self._world:Input()
  local isStartPreview = inputCmpt:IsPreviewActiveSkill()
  for i = 1, #entities do
    if isStartPreview then
      self:DoLinkLine(entities[i])
    else
      self:DoPickUp(entities[i])
    end
  end
end

function SkillPickUpMoyeSystem_Render:DoLinkLine(entity)
  local previewEntity = self._world:GetPreviewEntity()
  if not previewEntity then
    return
  end
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local pickUpTargetCmpt = entity:PickUpTarget()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
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
  local pickUpParam = skillConfigData:GetSkillPickParam()
  self._pickUpNum = pickUpParam[1]
  self._pieceType = pickUpParam[2]
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:ClearGridPos()
  previewPickUpComponent:AddGridPosList(chainPath)
  if chainPath then
    GameGlobal.TaskManager():CoreGameStartTask(self._DoPickUpInstruction, self, PickUpInstructionType.Empty, skillConfigData, petEntity, pickUpGridPos, chainPath)
  end
  self:UpdateUI(previewPickUpComponent)
end

function SkillPickUpMoyeSystem_Render:UpdateUI(previewPickUpComponent)
  local gridCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  gridCount = gridCount - 1
  local canCast = false
  local leftNum = self._pickUpNum
  if 0 < gridCount then
    canCast = true
    leftNum = leftNum - gridCount
  end
  if leftNum < 0 then
    leftNum = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftNum)
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
end

function SkillPickUpMoyeSystem_Render:_ParseScopeList(list)
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

function SkillPickUpMoyeSystem_Render:DoPickUp(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local pickUpGridPos = pickUpTargetCmpt:GetCurPickUpGridPos()
  self._pickUpType = pickUpTargetCmpt:GetPickUpTargetType()
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
  local pickUpNum = tonumber(skillConfigData._pickUpParam[1]) or 0
  self._pickUpNum = pickUpNum
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:ClearGridPos()
  self:UpdateUI(previewPickUpComponent, false)
  local casterPos = petEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  utilScopeSvc:ChangeGameFSMState2PickUp()
  local inputCmpt = self._world:Input()
  inputCmpt:SetPreviewActiveSkill(true)
end

function SkillPickUpMoyeSystem_Render:_DoPickUpInstruction(TT, type, skillConfigData, casterEntity, pickUpGirdPos, chainPath)
  local taskIDList = {}
  local previewActiveSkillService = self._world:GetService("PreviewActiveSkill")
  for i, v in ipairs(skillConfigData._previewParamList) do
    if v:GetPreviewType() == SkillPreviewType.Instruction then
      local instructionParam = v
      for _, skillPreviewConfigData in ipairs(instructionParam._previewList) do
        local instructionSet = self:_GetInstructSet(type, skillPreviewConfigData)
        if instructionSet then
          local previewContext = self:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, skillPreviewConfigData:GetID(), pickUpGirdPos)
          if 0 < #chainPath then
            local boardServiceRender = self._world:GetService("BoardRender")
            local connect_pieces = boardServiceRender:CalcConnectPiecesMoye(chainPath, self._pieceType, skillConfigData)
            previewContext:SetScopeResult(connect_pieces)
          else
            local board = self._world:GetRenderBoardEntity()
            local linkRendererDataCmpt = board:LinkRendererData()
            local allEntities = linkRendererDataCmpt:GetLinkLineEntityList()
            local removeList = {}
            for _, linkLineEntity in ipairs(allEntities) do
              table.insert(removeList, linkLineEntity)
            end
            local linkageRenderService = self._world:GetService("LinkageRender")
            for _, e in ipairs(removeList) do
              linkageRenderService:DestroyLinkLine(e)
            end
            local scopeResult = previewActiveSkillService:CalcScopeResult(skillPreviewConfigData:GetPreviewScopeParam(), casterEntity)
            previewContext:SetScopeResult(scopeResult:GetAttackRange())
          end
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

function SkillPickUpMoyeSystem_Render:_GetInstructSet(type, skillPreviewConfigData)
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

function SkillPickUpMoyeSystem_Render:_GetPreviewContext(type, skillPreviewConfigData, casterEntity, id, pickUpGridPos)
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
