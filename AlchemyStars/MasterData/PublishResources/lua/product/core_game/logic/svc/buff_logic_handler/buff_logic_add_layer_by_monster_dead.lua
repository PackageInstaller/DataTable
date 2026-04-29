require("buff_logic_base")
_class("BuffLogicAddLayerByMonsterDead", BuffLogicBase)
BuffLogicAddLayerByMonsterDead = BuffLogicAddLayerByMonsterDead

function BuffLogicAddLayerByMonsterDead:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._buffInstance._buffLayerName = self._buffInstance._buffsvc:GetBuffLayerName(self._layerType)
  self._dontDisplay = logicParam.dontDisplay
end

function BuffLogicAddLayerByMonsterDead:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local addLayer = 0
  local casterEntity = notify:GetAttackerEntity()
  local skillEffectResultContainer = casterEntity:SkillContext():GetResultContainer()
  local damageResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage)
  if not damageResultArray or #damageResultArray == 0 then
    return
  end
  local targetEntityList = {}
  for _, v in ipairs(damageResultArray) do
    local damageResult = v
    local targetEntityID = damageResult:GetTargetID()
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity and targetEntity:HasMonsterID() and not table.intable(targetEntityList, targetEntity) then
      table.insert(targetEntityList, targetEntity)
    end
  end
  for _, entity in ipairs(targetEntityList) do
    if entity:Attributes():GetCurrentHP() == 0 then
      addLayer = addLayer + 1
    end
  end
  if addLayer == 0 then
    return
  end
  local curMarkLayer = svc:AddBuffLayer(self._entity, self._layerType, addLayer)
  local buffResult = BuffResultAddLayer:New(curMarkLayer, self._dontDisplay)
  return buffResult
end
