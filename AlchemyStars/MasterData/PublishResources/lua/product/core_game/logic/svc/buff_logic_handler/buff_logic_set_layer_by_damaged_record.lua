_class("BuffLogicSetLayerByDamagedRecord", BuffLogicBase)
BuffLogicSetLayerByDamagedRecord = BuffLogicSetLayerByDamagedRecord

function BuffLogicSetLayerByDamagedRecord:Constructor(buffInstance, logicParam)
  self._hpPercentPerLayer = logicParam.hpPercentPerLayer or 1
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._entity = buffInstance._entity
end

function BuffLogicSetLayerByDamagedRecord:DoLogic()
  if self._entity:HasDamageStatisticsComponent() then
    local totalDamage = self._entity:DamageStatisticsComponent():GetTotalDamage()
    if 0 < totalDamage then
      local attrCmpt = self._entity:Attributes()
      local max_hp = attrCmpt:CalcMaxHp()
      if 0 < max_hp then
        local totalRate = totalDamage / max_hp
        local layerCount = math.floor(totalRate / self._hpPercentPerLayer)
        local svc = self._world:GetService("BuffLogic")
        svc:SetBuffLayer(self._entity, self._layerType, layerCount)
        local buffResult = BuffResultAddLayer:New(layerCount)
        return buffResult
      end
    end
  end
end
