_class("EffectAttachedComponent", Object)
EffectAttachedComponent = EffectAttachedComponent

function EffectAttachedComponent:Constructor()
  self._tAttachedEntityID = {}
  self._mapAttachedFxEntity = {}
  self._mapAttachedFxID = {}
end

function EffectAttachedComponent:AddAttachedEntityID(id)
  table.insert(self._tAttachedEntityID, id)
end

function EffectAttachedComponent:AddAttachedEffectEntityID(id, effectID)
  self:AddAttachedEntityID(id)
  self._mapAttachedFxEntity[effectID] = id
  self._mapAttachedFxID[id] = effectID
end

function EffectAttachedComponent:GetAttachedEntityIDArray()
  return self._tAttachedEntityID
end

function EffectAttachedComponent:ClearAttachedEntityIDArray()
  self._tAttachedEntityID = {}
  self._mapAttachedFxEntity = {}
  self._mapAttachedFxID = {}
end

function EffectAttachedComponent:GetAttachedFxMap()
  return self._mapAttachedFxEntity, self._mapAttachedFxID
end

function EffectAttachedComponent:RemoveAttachedEntityID(id)
  for i = 1, #self._tAttachedEntityID do
    if self._tAttachedEntityID[i] == id then
      table.remove(self._tAttachedEntityID, i)
      break
    end
  end
  local fxID = self._mapAttachedFxID[id]
  if fxID then
    self._mapAttachedFxEntity[fxID] = nil
  end
  self._mapAttachedFxID[id] = nil
end

function Entity:EffectAttached()
  return self:GetComponent(self.WEComponentsEnum.EffectAttached)
end

function Entity:HasEffectAttached()
  return self:HasComponent(self.WEComponentsEnum.EffectController)
end

function Entity:AddEffectAttached(e)
  local c = EffectAttachedComponent:New()
  self:AddComponent(self.WEComponentsEnum.EffectAttached, c)
end

function Entity:ReplaceEffectAttached()
  local c = EffectAttachedComponent:New()
  self:ReplaceComponent(self.WEComponentsEnum.EffectAttached, c)
end

function Entity:RemoveEffectController()
  if self:HasEffectAttached() then
    self:RemoveComponent(self.WEComponentsEnum.EffectAttached)
  end
end
