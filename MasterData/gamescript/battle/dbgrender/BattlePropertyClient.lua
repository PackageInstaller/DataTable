local BattlePropertyClient, Super = System.NewClass("BattlePropertyClient", BattleComponent)
local BP = bc.BattleProperty
local PropertyMin = {
  [BP.hp] = 0,
  [BP.block] = 0,
  [BP.energy] = 0,
  [BP.max_energy] = 0,
  [BP.card_cost] = 0
}
local DefaultNil = {
  [BP.card_cost] = true,
  [BP.card_origin_cost] = true,
  [BP.useless] = true,
  [BP.card_use_times] = true
}
for _, fixedCostKey in ipairs(bc.CardFixedCostKeys) do
  DefaultNil[fixedCostKey] = true
end

function BattlePropertyClient:ctor(entity, properties)
  Super.ctor(self, entity)
  self.owner = entity
  self.properties = Vue.reactive(table.clone(properties or {}))
end

function BattlePropertyClient:GetProperty(propertyName)
  local default = 0
  if DefaultNil[propertyName] then
    default = nil
  end
  if propertyName == BP.tentacle_count then
    local bout = self.properties[BP.bout_tentacle_count] or 0
    local battle = self.properties[BP.battle_tentacle_count] or 0
    local permanent = self.properties[BP.permanent_tentacle_count] or 0
    return bout + battle + permanent
  end
  if propertyName == BP.max_tentacle_count then
    local bout = self.properties[BP.bout_max_tentacle_count] or 0
    local battle = self.properties[BP.battle_max_tentacle_count] or 0
    local permanent = self.properties[BP.permanent_max_tentacle_count] or 0
    return bout + battle + permanent
  end
  return self.properties[propertyName] or default
end

function BattlePropertyClient:SetProperty(propertyName, value)
  self.properties[propertyName] = value
  return self.properties[propertyName] or 0
end

function BattlePropertyClient:ChangeProperty(propertyName, value)
  if value >= 0 then
    do return self.AddProperty, self, propertyName end
    return self.AddProperty, self, propertyName, value, nil
  else
    do return self.SubProperty, self, propertyName, math.abs(value) end
    return self.SubProperty, self, propertyName, math.abs(value)
  end
end

function BattlePropertyClient:AddProperty(propertyName, value)
  if propertyName == BP.card_cost and self.properties[propertyName] and self.properties[propertyName] < 0 then
    return
  end
  if not self.properties[propertyName] then
    self.properties[propertyName] = 0
  end
  self.properties[propertyName] = self.properties[propertyName] + value
  return self.properties[propertyName]
end

function BattlePropertyClient:SubProperty(propertyName, value)
  if propertyName == BP.card_cost and self.properties[propertyName] and self.properties[propertyName] < 0 then
    return
  end
  if not self.properties[propertyName] then
    self.properties[propertyName] = 0
  end
  if PropertyMin[propertyName] then
    self.properties[propertyName] = math.max(PropertyMin[propertyName], self.properties[propertyName] - value)
  else
    self.properties[propertyName] = self.properties[propertyName] - value
  end
  return self.properties[propertyName]
end

function BattlePropertyClient:Serialize()
  do return table.deepclone end
  return table.deepclone, self.properties
end

return BattlePropertyClient
