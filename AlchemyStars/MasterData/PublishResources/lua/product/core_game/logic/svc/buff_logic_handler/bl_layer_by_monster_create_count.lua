require("buff_logic_base")
_class("BuffLogicAddLayerByMonsterCreateCount", BuffLogicBase)
BuffLogicAddLayerByMonsterCreateCount = BuffLogicAddLayerByMonsterCreateCount

function BuffLogicAddLayerByMonsterCreateCount:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._dontDisplay = logicParam.dontDisplay or false
  self._monsterID = logicParam.monsterID
  self._monsterClassID = logicParam.monsterClassID
end

function BuffLogicAddLayerByMonsterCreateCount:DoLogic(notify)
  local svc = self._world:GetService("BuffLogic")
  local count = 0
  self._entity = self._buffInstance:Entity()
  if not self._entity:HasMonsterID() then
    return
  end
  local cBattleStat = self._world:BattleStat()
  if self._monsterID then
    count = count + cBattleStat:GetMonsterIDCount(self._entity:MonsterID():GetMonsterID())
  end
  if self._monsterClassID then
    count = count + cBattleStat:GetMonsterClassIDCount(self._entity:MonsterID():GetMonsterClassID())
  end
  local addLayer = count - 1
  local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
  local curMarkLayer, buffinst = svc:AddBuffLayer(self._entity, self._layerType, addLayer, nil, casterEntity)
  if not buffinst then
    return
  end
  local buffResult = BuffResultLayer:New(curMarkLayer, buffinst:BuffSeq(), addLayer, self._layerType)
  buffResult:SetDontDisplay(self._dontDisplay)
  if self._dontDisplay then
    return
  end
  return buffResult
end
