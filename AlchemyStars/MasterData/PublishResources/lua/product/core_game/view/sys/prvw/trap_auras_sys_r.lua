require("reactive_system")
_class("TrapAurasSystem_Render", ReactiveSystem)
TrapAurasSystem_Render = TrapAurasSystem_Render

function TrapAurasSystem_Render:Constructor(world)
  self._world = world
end

function TrapAurasSystem_Render:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.TrapAurasOutline)
  local c = Collector:New({group}, {
    "AddedOrRemoved"
  })
  return c
end

function TrapAurasSystem_Render:Filter(entity)
  return entity:HasTrapRender() and entity:TrapRender():HasAurasGroupID()
end

function TrapAurasSystem_Render:ExecuteEntities()
  local entities = self._world:GetGroupEntities(self._world.BW_WEMatchers.TrapAurasOutline)
  if not entities then
    return
  end
  local groupEntityList = {}
  for i, e in ipairs(entities) do
    local trapRenderComponent = e:TrapRender()
    local groupID = trapRenderComponent:GetAurasGroupID()
    if not groupEntityList[groupID] then
      groupEntityList[groupID] = {}
    end
    table.insert(groupEntityList[groupID], e)
  end
  for groupID, entityList in pairs(groupEntityList) do
    self:PlayGroupAuras(entityList)
  end
end

function TrapAurasSystem_Render:PlayGroupAuras(groupEntityList)
  local totalRange = {}
  local entity2RangeList = {}
  local groupEffect, birthAnim, deadAnim, birthDelay, deadDelay, loopAnim, radius
  local configService = self._world:GetService("Config")
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local entityPoolService = self._world:GetService("EntityPool")
  local birthEntityList = {}
  local deadEntityList = {}
  local destroyEntityList = {}
  for _, entity in ipairs(groupEntityList) do
    local trapRenderComponent = entity:TrapRender()
    local effect = trapRenderComponent:GetAurasEffect()
    groupEffect = groupEffect or effect
    local myRadius = trapRenderComponent:GetAurasRadius()
    radius = radius or myRadius
    if trapRenderComponent:GetAurasStatus() == TrapAurasState.Close then
      local dead = trapRenderComponent:GetAurasDeathAnim()
      local delay = trapRenderComponent:GetAurasBirthDelay()
      deadAnim = deadAnim or dead
      deadDelay = deadDelay or delay
      if groupEffect ~= effect or deadAnim ~= dead or deadDelay ~= delay then
        Log.exception("Trap Auras Effect Invalid")
      end
      local aurasEntityList = trapRenderComponent:GetAllAurasEntity()
      for i, id in ipairs(aurasEntityList) do
        local aurasEntity = self._world:GetEntityByID(id)
        if not trapRenderComponent:IsAurasFinish() then
          table.insert(deadEntityList, aurasEntity)
        end
      end
    elseif trapRenderComponent:GetAurasStatus() == TrapAurasState.Open then
      local birth = trapRenderComponent:GetAurasBirthAnim()
      local loop = trapRenderComponent:GetAurasLoopAnim()
      local delay = trapRenderComponent:GetAurasBirthDelay()
      birthAnim = birthAnim or birth
      birthDelay = birthDelay or delay
      loopAnim = loopAnim or loop
      if groupEffect ~= effect or birthAnim ~= birth or birthDelay ~= delay or loopAnim ~= loop then
        Log.exception("Trap Auras Effect Invalid")
      end
      local skillID = trapRenderComponent:GetAurasRangeSkillID()
      local skillConfigData = configService:GetSkillConfigData(skillID)
      local casterPos = entity:GetGridPosition()
      local scapeResult = utilScopeSvc:CalcSkillScope(skillConfigData, casterPos, entity)
      local range = scapeResult:GetAttackRange()
      for i, pos in ipairs(range) do
        if not table.Vector2Include(totalRange, pos) then
          table.insert(totalRange, pos)
        end
      end
      entity2RangeList[entity:GetID()] = range
      local aurasEntityList = trapRenderComponent:GetAllAurasEntity()
      for i, id in ipairs(aurasEntityList) do
        local aurasEntity = self._world:GetEntityByID(id)
        table.insert(destroyEntityList, aurasEntity)
      end
    end
    trapRenderComponent:ClearAurasEntity()
  end
  GameGlobal.TaskManager():StartTask(self.PlayDead, self, deadEntityList, deadAnim, deadDelay)
  local renderEntitySvcR = self._world:GetService("RenderEntity")
  local outlineEntityList = renderEntitySvcR:CreateAreaOutlineEntity(totalRange, EntityConfigIDRender.TrapAurasArea, groupEffect, nil, nil, radius)
  for i, aurasEntity in ipairs(destroyEntityList) do
    entityPoolService:DestroyCacheEntity(aurasEntity, EntityConfigIDRender.TrapAurasArea)
  end
  for i, outlineEntity in ipairs(outlineEntityList) do
    local sourcePos = renderEntitySvcR:GetOutlineSourcePos(outlineEntity, radius)
    for entityID, range in pairs(entity2RangeList) do
      if table.Vector2Include(range, sourcePos) then
        local entity = self._world:GetEntityByID(entityID)
        local trapRenderComponent = entity:TrapRender()
        trapRenderComponent:AddMyAurasEntity(outlineEntity:GetID())
        if trapRenderComponent:GetAurasStatus() == TrapAurasState.Open and not trapRenderComponent:IsAurasFinish() then
          table.insert(birthEntityList, outlineEntity)
        end
        break
      end
    end
  end
  for _, entity in ipairs(groupEntityList) do
    local trapRenderComponent = entity:TrapRender()
    trapRenderComponent:SetAurasFinish()
  end
  GameGlobal.TaskManager():StartTask(self.PlayBirth, self, birthEntityList, birthAnim, birthDelay, loopAnim)
end

function TrapAurasSystem_Render:PlayBirth(TT, entityList, birthAnim, delay, loopAnim)
  if not entityList or #entityList == 0 or not birthAnim then
    return
  end
  local renderBattle = self._world:GetService("RenderBattle")
  for i, entity in ipairs(entityList) do
    renderBattle:PlayAnimation(entity, {birthAnim})
  end
  YIELD(TT, delay)
  for i, entity in ipairs(entityList) do
    renderBattle:PlayAnimation(entity, {loopAnim})
  end
end

function TrapAurasSystem_Render:PlayDead(TT, entityList, deadAnim, deadDelay)
  if not entityList or #entityList == 0 then
    return
  end
  local renderBattle = self._world:GetService("RenderBattle")
  if deadAnim then
    for i, entity in ipairs(entityList) do
      renderBattle:PlayAnimation(entity, {deadAnim})
    end
  end
  if deadDelay then
    YIELD(TT, deadDelay)
  end
  local entityPoolService = self._world:GetService("EntityPool")
  for i, entity in ipairs(entityList) do
    entityPoolService:DestroyCacheEntity(entity, EntityConfigIDRender.TrapAurasArea)
  end
end
