_class("ISpawnRule", Object)

function ISpawnRule:MakeSpawn(entity)
end

_class("ISpawnRuleWitchManager", Object)

function ISpawnRuleWitchManager:MakeSpawnByMng(entity)
end

_class("SpawnComponent", Object)

function SpawnComponent:Constructor(spawnRule)
  self.SpawnRule = spawnRule
end

function Entity:Spawn()
  return self:GetComponent(self.WEComponentsEnum.Spawn)
end

function Entity:HasSpawn()
  return self:HasComponent(self.WEComponentsEnum.Spawn)
end

function Entity:AddSpawn(spawnRule)
  local index = self.WEComponentsEnum.Spawn
  local component = SpawnComponent:New(spawnRule)
  self:AddComponent(index, component)
end

function Entity:ReplaceSpawn(spawnRule)
  local index = self.WEComponentsEnum.Spawn
  local component = SpawnComponent:New(spawnRule)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveSpawn()
  if self:HasSpawn() then
    self:RemoveComponent(self.WEComponentsEnum.Spawn)
  end
end
