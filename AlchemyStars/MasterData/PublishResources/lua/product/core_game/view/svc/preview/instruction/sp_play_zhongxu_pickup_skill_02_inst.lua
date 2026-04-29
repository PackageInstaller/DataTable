require("sp_base_inst")
_class("SkillPreviewPlayZhongxuPickupSkill02Instruction", SkillPreviewBaseInstruction)
SkillPreviewPlayZhongxuPickupSkill02Instruction = SkillPreviewPlayZhongxuPickupSkill02Instruction

function SkillPreviewPlayZhongxuPickupSkill02Instruction:Constructor(params)
  self._trapID = tonumber(params.trapID)
  self._forceMovementIndex = tonumber(params.forceMovementIndex)
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local utilScopeSvc = world:GetService("UtilScopeCalc")
  local renderBoardEntity = world:GetRenderBoardEntity()
  local pickUpTargetCmpt = renderBoardEntity:PickUpTarget()
  local activeSkillID = pickUpTargetCmpt:GetCurActiveSkillID()
  local configService = world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(activeSkillID, casterEntity)
  local pickUpValidScopeList = {}
  local pickUpInvalidScopeList = {}
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local parser = SkillScopeParamParser:New()
  local entitySvc = world:GetService("RenderEntity")
  local previewPickUpComponent = casterEntity:PreviewPickUpComponent()
  local pickupPosArray = previewPickUpComponent and previewPickUpComponent:GetAllValidPickUpGridPos() or {}
  if #pickupPosArray == 0 then
    entitySvc:DestroyGhost()
    previewActiveSkillService:DestroyPickUpArrow()
    pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickValidScopeList or {})
    pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.firstPickInvalidScopeList or {})
    local validGridList = utilScopeSvc:BuildScopeGridList(pickUpValidScopeList, casterEntity) or {}
    local invalidGridList = utilScopeSvc:BuildScopeGridList(pickUpInvalidScopeList, casterEntity) or {}
    local finalGridList = {}
    for _, v2 in ipairs(validGridList) do
      if not table.Vector2Include(invalidGridList, v2) then
        table.insert(finalGridList, v2)
      end
    end
    previewActiveSkillService:DoConvert(finalGridList, "Normal", "Dark")
  else
    local firstPickup = pickupPosArray[1]
    local utilData = world:GetService("UtilData")
    local isPickTrap = false
    local isPickEnemyTeam = false
    local isPickMonster = false
    local pickEntity
    local tTrapEntities = utilData:GetTrapsAtPos(firstPickup)
    for _, e in ipairs(tTrapEntities) do
      if e:TrapID():GetTrapID() == self._trapID then
        isPickTrap = true
        pickEntity = e
        break
      end
    end
    if not isPickTrap then
      if world:MatchType() == MatchType.MT_BlackFist then
        if casterEntity:HasPet() then
          local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
          local enemyEntity = teamEntity:Team():GetEnemyTeamEntity()
          local enemyTeamPos = enemyEntity:GetGridPosition()
          if enemyTeamPos == firstPickup then
            isPickEnemyTeam = true
            pickEntity = enemyEntity
          end
        end
      else
        local monsterEntity = utilData:GetMonsterAtPos(firstPickup)
        if monsterEntity then
          isPickMonster = true
          pickEntity = monsterEntity
        end
      end
    end
    if isPickTrap then
      if #pickupPosArray == 1 then
        entitySvc:DestroyGhost()
        pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickValidScopeList or {})
        pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.trapPickInvalidScopeList or {})
        local validGridList = utilScopeSvc:BuildScopeGridList(pickUpValidScopeList, casterEntity) or {}
        local invalidGridList = utilScopeSvc:BuildScopeGridList(pickUpInvalidScopeList, casterEntity) or {}
        local arrowScope = {}
        local finalGridList = {}
        for _, v2 in ipairs(validGridList) do
          if not table.Vector2Include(invalidGridList, v2) then
            table.insert(finalGridList, v2)
            table.insert(arrowScope, v2)
          end
        end
        table.insert(finalGridList, firstPickup)
        previewActiveSkillService:DoConvert(finalGridList, "Normal", "Dark")
        previewActiveSkillService:DestroyPickUpArrow()
        self:_ShowAroundScopeArrows(world, pickEntity, arrowScope)
      else
        entitySvc:DestroyGhost()
        YIELD(TT)
        local previewEffectCalcService = world:GetService("PreviewCalcEffect")
        local scopeGridList = previewContext:GetScopeResult()
        local effect = skillConfigData:GetSkillEffectByIndex(self._forceMovementIndex)
        local result = previewEffectCalcService:CalcForceMovement(casterEntity, previewContext, effect)
        if result then
          self:_DoForceMovementPresentation(TT, world, result)
        end
        local arrowEntities = world:GetGroup(world.BW_WEMatchers.PickUpArrow):GetEntities()
        for _, e in ipairs(arrowEntities) do
          local arrowPos = e:GetRenderGridPosition()
          local statTable = {}
          if arrowPos == pickupPosArray[2] then
            statTable = {select = true, idle = false}
          else
            statTable = {select = false, idle = true}
          end
          e:SetAnimatorControllerBools(statTable)
        end
      end
    elseif isPickEnemyTeam or isPickMonster then
      if #pickupPosArray == 1 then
        entitySvc:DestroyGhost()
        pickUpValidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickValidScopeList or {})
        pickUpInvalidScopeList = self:_ParseScopeList(skillConfigData._pickUpParam.monsterPickInvalidScopeList or {})
        local validGridList = utilScopeSvc:BuildScopeGridList(pickUpValidScopeList, casterEntity) or {}
        local invalidGridList = utilScopeSvc:BuildScopeGridList(pickUpInvalidScopeList, casterEntity) or {}
        local arrowScope = {}
        local finalGridList = {}
        for _, v2 in ipairs(validGridList) do
          if not table.Vector2Include(invalidGridList, v2) then
            table.insert(finalGridList, v2)
            table.insert(arrowScope, v2)
          end
        end
        table.insert(finalGridList, firstPickup)
        previewActiveSkillService:DoConvert(finalGridList, "Normal", "Dark")
        previewActiveSkillService:DestroyPickUpArrow()
        self:_ShowAroundScopeArrows(world, pickEntity, arrowScope)
      else
        entitySvc:DestroyGhost()
        YIELD(TT)
        local previewEffectCalcService = world:GetService("PreviewCalcEffect")
        local scopeGridList = previewContext:GetScopeResult()
        local effect = skillConfigData:GetSkillEffectByIndex(self._forceMovementIndex)
        local result = previewEffectCalcService:CalcForceMovement(casterEntity, previewContext, effect)
        if result then
          self:_DoForceMovementPresentation(TT, world, result)
        end
        local arrowEntities = world:GetGroup(world.BW_WEMatchers.PickUpArrow):GetEntities()
        for _, e in ipairs(arrowEntities) do
          local arrowPos = e:GetRenderGridPosition()
          local statTable = {}
          if arrowPos == pickupPosArray[2] then
            statTable = {select = true, idle = false}
          else
            statTable = {select = false, idle = true}
          end
          e:SetAnimatorControllerBools(statTable)
        end
      end
    end
  end
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_DoForceMovementPresentation(TT, world, result)
  local taskIDs = {}
  local array = result:GetMoveResult()
  for _, info in ipairs(array) do
    local entity = world:GetEntityByID(info.targetID)
    if info.isMoved then
      local tid = self:_DoSingleTarget(TT, world, info, entity)
      if tid then
        table.insert(taskIDs, tid)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_DoSingleTarget(TT, world, info, entity)
  local boardServiceRender = world:GetService("BoardRender")
  local entitySvc = world:GetService("RenderEntity")
  local ghostEntity = entitySvc:CreateGhost(info.v2OldPos, entity, "AtkUltPreview")
  ghostEntity:AddGridMove(BattleConst.ForceMovementPreviewSpeed, info.v2NewPos, info.v2OldPos)
  return GameGlobal.TaskManager():CoreGameStartTask(self._IsMoveFinished, self, ghostEntity)
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_IsMoveFinished(TT, entity)
  return not entity:HasGridMove()
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_ParseScopeList(list)
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

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_ShowAroundScopeArrows(world, entity, arrowScope)
  local renderEntityService = world:GetService("RenderEntity")
  local pieceService = world:GetService("Piece")
  local v2CasterPos = entity:GetGridPosition()
  for _, v2Scope in ipairs(arrowScope) do
    local dir = self:_CalcArrowDirByTargetAndPos(entity, v2Scope)
    local eArrow = renderEntityService:CreateRenderEntity(EntityConfigIDRender.PickUpArrow)
    eArrow:SetLocation(v2Scope, dir)
    pieceService:SetEffectEntityParentWithPiecePos(eArrow, v2Scope)
  end
end

function SkillPreviewPlayZhongxuPickupSkill02Instruction:_CalcArrowDirByTargetAndPos(targetEntity, arrowPos)
  local dir
  local targetPos = targetEntity:GetGridPosition()
  local bodyArea = targetEntity:BodyArea():GetArea()
  if bodyArea then
    if #bodyArea == 1 then
      dir = arrowPos - targetPos
    else
      local upMaxY, downMinY, rightMaxX, leftMinX
      for index, off in ipairs(bodyArea) do
        local bodyPos = targetPos + off
        if not upMaxY then
          upMaxY = bodyPos.y
        elseif upMaxY < bodyPos.y then
          upMaxY = bodyPos.y
        end
        if not downMinY then
          downMinY = bodyPos.y
        elseif downMinY > bodyPos.y then
          downMinY = bodyPos.y
        end
        if not rightMaxX then
          rightMaxX = bodyPos.x
        elseif rightMaxX < bodyPos.x then
          rightMaxX = bodyPos.x
        end
        if not leftMinX then
          leftMinX = bodyPos.x
        elseif leftMinX > bodyPos.x then
          leftMinX = bodyPos.x
        end
      end
      if upMaxY < arrowPos.y then
        dir = Vector2.up
      elseif downMinY > arrowPos.y then
        dir = Vector2.down
      elseif rightMaxX < arrowPos.x then
        dir = Vector2.right
      elseif leftMinX > arrowPos.x then
        dir = Vector2.left
      end
    end
  end
  return dir
end
