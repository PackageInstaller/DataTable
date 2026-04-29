_class("SkillPickUpLinkLineSystem_Render", ReactiveSystem)
SkillPickUpLinkLineSystem_Render = SkillPickUpLinkLineSystem_Render

function SkillPickUpLinkLineSystem_Render:Constructor(world)
  self._world = world
  self._pickUpType = nil
  self._pickUpNum = 0
end

function SkillPickUpLinkLineSystem_Render:GetTrigger(world)
  local c = Collector:New({
    world:GetGroup(world.BW_WEMatchers.PickUpTarget)
  }, {"Added"})
  return c
end

function SkillPickUpLinkLineSystem_Render:Filter(entity)
  local pickUpTargetCmpt = entity:PickUpTarget()
  local skillHandleType = pickUpTargetCmpt:GetPickUpTargetType()
  if skillHandleType == SkillPickUpType.LinkLine then
    return true
  end
  return false
end

function SkillPickUpLinkLineSystem_Render:ExecuteEntities(entities)
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

function SkillPickUpLinkLineSystem_Render:DoLinkLine(entity)
  local previewEntity = self._world:GetPreviewEntity()
  if not previewEntity then
    return
  end
  local previewLinkLineCmpt = previewEntity:PreviewLinkLine()
  local chainPath = previewLinkLineCmpt:GetPreviewChainPath()
  local pickUpTargetCmpt = entity:PickUpTarget()
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
  local canLinkMonster = tonumber(skillConfigData._pickUpParam[3]) or 0
  local previewPickUpComponent = petEntity:PreviewPickUpComponent()
  previewPickUpComponent:ClearGridPos()
  previewPickUpComponent:AddGridPosList(chainPath)
  local isLinkMonster = false
  if 1 < #chainPath and canLinkMonster == 1 then
    local lastPos = chainPath[#chainPath]
    if utilDataSvc:GetMonsterAtPos(lastPos) then
      isLinkMonster = true
    end
  end
  self:UpdateUI(previewPickUpComponent, isLinkMonster)
end

function SkillPickUpLinkLineSystem_Render:DoPickUp(entity)
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
  if pickUpGridPos == casterPos then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    utilScopeSvc:ChangeGameFSMState2PickUp()
    local inputCmpt = self._world:Input()
    inputCmpt:SetPreviewActiveSkill(true)
  else
    local previewActiveSkill = self._world:GetService("PreviewActiveSkill")
    if previewActiveSkill then
      previewActiveSkill:PickUpInvalidGridCancelPreview(activeSkillID, petPstID)
    end
  end
end

function SkillPickUpLinkLineSystem_Render:UpdateUI(previewPickUpComponent, isLinkMonster)
  local gridCount = previewPickUpComponent:GetAllValidPickUpGridPosCount()
  gridCount = gridCount - 1
  local canCast = false
  local leftNum = self._pickUpNum
  if 0 < gridCount then
    canCast = true
    leftNum = leftNum - gridCount
  end
  if isLinkMonster then
    canCast = true
    leftNum = 0
  end
  if leftNum < 0 then
    leftNum = 0
  end
  self._world:EventDispatcher():Dispatch(GameEventType.RefreshPickUpNum, leftNum)
  self._world:EventDispatcher():Dispatch(GameEventType.EnablePickUpSkillCast, canCast)
end
