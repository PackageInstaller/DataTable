require("reactive_system")
_class("BulletTimeSystem", ReactiveSystem)
BulletTimeSystem = BulletTimeSystem

function BulletTimeSystem:Constructor(world)
  self._world = world
end

function BulletTimeSystem:GetTrigger(world)
  local group = world:GetGroup(world.BW_WEMatchers.BulletTime)
  local c = Collector:New({group}, {"Added"})
  return c
end

function BulletTimeSystem:Filter(entity)
  return entity:HasBulletTime()
end

function BulletTimeSystem:ExecuteEntities(entities)
  for i = 1, #entities do
    local e = entities[i]
    self:HandleEntity(e)
  end
end

function BulletTimeSystem:HandleEntity(e)
  local bulletTimeCmpt = e:BulletTime()
  local enableBulletTime = bulletTimeCmpt:IsEnableBullteTime()
  if enableBulletTime then
    self:_EnalbeEntityBulletTime(e)
  else
    self:_DisableEntityBulletTime(e)
  end
end

function BulletTimeSystem:_EnalbeEntityBulletTime(e)
  local bulletTimeCmpt = e:BulletTime()
  self._world:MainCamera():EnableSceneTiltShift(true)
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(monsterGroup:GetEntities()) do
    bulletTimeCmpt:AddBulletTimeEntityID(entity:GetID())
    self:_ModifyEntityFadeSpeed(entity, BattleConst.BulletTimeSpeed)
  end
  local trapRenderSvc = self._world:GetService("TrapRender")
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for _, entity in ipairs(trapGroup:GetEntities()) do
    if not trapRenderSvc:IsRuneTrap(entity) then
      bulletTimeCmpt:AddBulletTimeEntityID(entity:GetID())
      self:_ModifyEntityFadeSpeed(entity, BattleConst.BulletTimeSpeed)
    end
  end
  local teamGroup = self._world:GetGroup(self._world.BW_WEMatchers.Team)
  for _, entity in ipairs(teamGroup:GetEntities()) do
    bulletTimeCmpt:AddBulletTimeEntityID(entity:GetID())
    self:_ModifyEntityFadeSpeed(entity, BattleConst.BulletTimeSpeed)
  end
end

function BulletTimeSystem:_ModifyEntityFadeSpeed(entity, speed)
  local viewCmpt = entity:View()
  if not viewCmpt then
    return
  end
  local u3dObj = viewCmpt:GetGameObject()
  if not u3dObj or tostring(u3dObj) == "null" then
    return
  end
  local fadeCmpt = u3dObj:GetComponent(typeof(FadeComponent))
  if not fadeCmpt then
    return
  end
  fadeCmpt.Speed = speed
end

function BulletTimeSystem:_DisableEntityBulletTime(e)
  local normalSpeed = 1
  local bulletTimeCmpt = e:BulletTime()
  local idList = bulletTimeCmpt:GetBulletTimeEntityIDList()
  for _, id in ipairs(idList) do
    local entity = self._world:GetEntityByID(id)
    self:_ModifyEntityFadeSpeed(entity, normalSpeed)
  end
  bulletTimeCmpt:ResetBulletTimeData()
  self._world:MainCamera():EnableSceneTiltShift(false)
end
