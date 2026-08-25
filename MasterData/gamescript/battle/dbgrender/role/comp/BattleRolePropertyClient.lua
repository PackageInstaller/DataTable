local PT = bc.BattleProperty
local BattleRolePropertyClient, Super = System.NewClass("BattleRolePropertyClient", BattleComponent)

function BattleRolePropertyClient:ctor(entity, properties)
  Super.ctor(self, entity)
  self.role = entity
  local clone = table.clone(properties or {})
  self.properties = Vue.reactive(clone)
  self.awakerProperties = Vue.reactive({})
  self.awakerPropertiesByConfigId = Vue.reactive({})
end

function BattleRolePropertyClient:InitAwakerProperties()
  for _, awaker in ipairs(self.role.awakerList) do
    self.awakerProperties[awaker.uid] = {}
    for k, v in pairs(awaker.properties) do
      self:SetAwakerProperty(awaker.uid, k, v)
    end
  end
  for _, awaker in ipairs(self.role.awakerList) do
    self.awakerPropertiesByConfigId[awaker.tid] = self.awakerProperties[awaker.uid]
  end
end

function BattleRolePropertyClient:SetProperty(propertyName, value)
  self.properties[propertyName] = value
end

function BattleRolePropertyClient:SetAwakerProperty(awakerUid, propertyName, value)
  local awakerProperty = self.awakerProperties[awakerUid]
  awakerProperty[propertyName] = value
end

function BattleRolePropertyClient:GetAwakerPropertyByUid(awakerUid, propertyName)
  if not self.awakerProperties[awakerUid] then
    return 0
  end
  return self.awakerProperties[awakerUid][propertyName] or 0
end

function BattleRolePropertyClient:GetAwakerPropertyByConfigId(awakerTid, propertyName)
  if not propertyName then
    return 0
  end
  if not self.awakerPropertiesByConfigId[awakerTid] then
    return 0
  end
  return self.awakerPropertiesByConfigId[awakerTid][propertyName] or 0
end

function BattleRolePropertyClient:GetProperty(propertyName)
  if not propertyName then
    return 0
  end
  return self.properties[propertyName] or 0
end

function BattleRolePropertyClient:GetHp()
  do return self.GetProperty, self end
  return self.GetProperty, self, PT.hp
end

function BattleRolePropertyClient:GetMaxHp()
  do return self.GetProperty, self end
  return self.GetProperty, self, PT.max_hp
end

function BattleRolePropertyClient:GetBlock()
  do return self.GetProperty, self end
  return self.GetProperty, self, PT.block
end

function BattleRolePropertyClient:GetEnergy()
  do return self.GetProperty, self end
  return self.GetProperty, self, PT.energy
end

function BattleRolePropertyClient:GetBaseEnergy()
  do return self.GetProperty, self end
  return self.GetProperty, self, PT.max_energy
end

return BattleRolePropertyClient
