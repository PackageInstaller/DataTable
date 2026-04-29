_class("SkillEffectTargetSorter", Object)
SkillEffectTargetSorter = SkillEffectTargetSorter

function SkillEffectTargetSorter:Constructor(world)
  self._world = world
end

function SkillEffectTargetSorter:DoSortTargetList(casterEntity, targetIDArray, skillEffectParam, skillScopeResult)
  local skillEffectType = skillEffectParam:GetEffectType()
  if skillEffectType == SkillEffectType.HitBack then
    return self:_SortHitbackEffectTargetList(casterEntity, targetIDArray, skillEffectParam)
  end
  local component = casterEntity:ActiveSkillPickUpComponent()
  if component then
    local direction = component:GetLastPickUpDirection()
    if skillEffectType == SkillEffectType.Damage and component:GetLastPickUpDirection() then
      return self:_SortDamageEffectTargetList(casterEntity, targetIDArray, skillEffectParam, direction, skillScopeResult)
    end
  end
  return targetIDArray
end

function SkillEffectTargetSorter:_SortHitbackEffectTargetList(casterEntity, enemyIDList, hitbackParam)
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  if skillEffectResultContainer == nil then
    Log.fatal("caster has no skill routine component")
  end
  local skillID = skillEffectResultContainer:GetSkillID()
  local effectCalcService = self._world:GetService("SkillEffectCalc")
  local casterPetEntityID = casterEntity:GetID()
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillID)
  local scopeType = skillConfigData:GetSkillScopeType()
  local pickUpType = skillConfigData:GetSkillPickType()
  local targetType = skillConfigData:GetSkillTargetType()
  local hitbackDirType = hitbackParam:GetDirType()
  local usePickPosIndex = hitbackParam:GetUsePickPosIndex()
  local casterPos = casterEntity:GridLocation().Position
  if pickUpType == SkillPickUpType.DirectionInstruction then
    local component = casterEntity:ActiveSkillPickUpComponent()
    if component then
      hitbackDirType = component:GetLastPickUpDirection()
    end
  elseif pickUpType == SkillPickUpType.Instruction then
    local component = casterEntity:ActiveSkillPickUpComponent()
    if component then
      local pickList = component:GetAllValidPickUpGridPos()
      if hitbackParam:GetForceUseCasterPos() then
      elseif usePickPosIndex and 0 < usePickPosIndex and usePickPosIndex <= #pickList then
        casterPos = pickList[usePickPosIndex]
      else
        casterPos = component:GetLastPickUpGridPos()
      end
    end
  end
  self:_SortHitbackTargetByDirType(enemyIDList, hitbackDirType, casterPos)
  for k, v in ipairs(enemyIDList) do
    local enemyEntity = self._world:GetEntityByID(v)
    local pos = enemyEntity:GridLocation().Position
  end
  return enemyIDList
end

function SkillEffectTargetSorter:_SortHitbackTargetByDirType(hitbackIDArray, hitbackDirType, casterPos)
  if hitbackDirType == HitBackDirectionType.Left then
    local function CmpLeftfunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      return pos1.x < pos2.x
    end
    
    table.sort(hitbackIDArray, CmpLeftfunc)
  elseif hitbackDirType == HitBackDirectionType.Right then
    local function CmpRightfunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      return pos1.x > pos2.x
    end
    
    table.sort(hitbackIDArray, CmpRightfunc)
  elseif hitbackDirType == HitBackDirectionType.Up then
    local function CmpUpfunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      return pos1.y > pos2.y
    end
    
    table.sort(hitbackIDArray, CmpUpfunc)
  elseif hitbackDirType == HitBackDirectionType.Down then
    local function CmpDownfunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      return pos1.y < pos2.y
    end
    
    table.sort(hitbackIDArray, CmpDownfunc)
  elseif hitbackDirType == HitBackDirectionType.AntiEightDir then
    local function CmpDistancefunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      local castPos = casterPos
      local dis1 = Vector2.Distance(castPos, pos1)
      local dis2 = Vector2.Distance(castPos, pos2)
      return dis1 < dis2
    end
    
    table.sort(hitbackIDArray, CmpDistancefunc)
  else
    local function CmpDistancefunc(entityID1, entityID2)
      local entity1 = self._world:GetEntityByID(entityID1)
      
      local entity2 = self._world:GetEntityByID(entityID2)
      local pos1 = entity1:GridLocation().Position
      local pos2 = entity2:GridLocation().Position
      local castPos = casterPos
      local dis1 = Vector2.Distance(castPos, pos1)
      local dis2 = Vector2.Distance(castPos, pos2)
      return dis1 > dis2
    end
    
    table.sort(hitbackIDArray, CmpDistancefunc)
  end
end

function SkillEffectTargetSorter:_SortDamageEffectTargetList(casterEntity, targetIDArray, skillEffectParam, directionType, skillScopeResult)
  if not (#targetIDArray ~= 0 and directionType) or directionType == HitBackDirectionType.None then
    return targetIDArray
  end
  local validScopeGridList = skillScopeResult:GetAttackRange()
  local cmpFun
  if directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.LeftUp or directionType == HitBackDirectionType.RightUp then
    function cmpFun(p1, p2)
      return p1.y < p2.y
    end
  elseif directionType == HitBackDirectionType.Down or directionType == HitBackDirectionType.LeftDown or directionType == HitBackDirectionType.RightDown then
    function cmpFun(p1, p2)
      return p1.y > p2.y
    end
  elseif directionType == HitBackDirectionType.Left then
    function cmpFun(p1, p2)
      return p1.x > p2.x
    end
  elseif directionType == HitBackDirectionType.Right then
    function cmpFun(p1, p2)
      return p1.x < p2.x
    end
  end
  local pos2IDList = {}
  local targetPosList = {}
  for _, entityID in ipairs(targetIDArray) do
    local targetEntity = self._world:GetEntityByID(entityID)
    local bodyArea = targetEntity:BodyArea():GetArea()
    local position = targetEntity:GridLocation().Position
    for k, v in ipairs(bodyArea) do
      local bodyPos = Vector2(v.x + position.x, v.y + position.y)
      if table.icontains(validScopeGridList, bodyPos) then
        table.insert(targetPosList, bodyPos)
        pos2IDList[bodyPos] = entityID
      end
    end
  end
  table.sort(targetPosList, cmpFun)
  local firstRowPosList = {}
  local firstRowPos
  local newTargetIDList = {}
  for index, pos in ipairs(targetPosList) do
    if index == 1 then
      firstRowPos = pos
      table.insert(firstRowPosList, firstRowPos)
    elseif directionType == HitBackDirectionType.Left or directionType == HitBackDirectionType.Right then
      if pos.x == firstRowPos.x then
        table.insert(firstRowPosList, pos)
      end
    elseif (directionType == HitBackDirectionType.Up or directionType == HitBackDirectionType.Down) and pos.y == firstRowPos.y then
      table.insert(firstRowPosList, pos)
    end
    table.insert(newTargetIDList, pos2IDList[pos])
  end
  self._world:GetService("Trigger"):Notify(NTNotifyTrainFirstRowPos:New(firstRowPosList, casterEntity))
  newTargetIDList = table.unique(newTargetIDList)
  return newTargetIDList
end
