_class("BuffLogicSpreadDeadMonsterBuffLayerToOtherMonsters", BuffLogicBase)
BuffLogicSpreadDeadMonsterBuffLayerToOtherMonsters = BuffLogicSpreadDeadMonsterBuffLayerToOtherMonsters

function BuffLogicSpreadDeadMonsterBuffLayerToOtherMonsters:Constructor(buffInstance, logicParam)
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._maxSingleTargetAddLayer = logicParam.maxSingleTargetAddLayer
end

function BuffLogicSpreadDeadMonsterBuffLayerToOtherMonsters:DoLogic(notify)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local e = self._buffInstance:Entity()
  local lsvcBuff = self._world:GetService("BuffLogic")
  local eNotify = notify:GetNotifyEntity()
  local layer = lsvcBuff:GetBuffLayer(eNotify, self._layerType)
  if not layer or layer <= 0 then
    return
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalculator = SkillScopeCalculator:New(utilScopeSvc)
  local fullScreenCalc = SkillScopeCalculator_FullScreen:New(scopeCalculator)
  local scopeResult = fullScreenCalc:CalcRange(SkillScopeType.FullScreen, 0, e:GetGridPosition(), e:BodyArea():GetArea(), e:GetGridDirection(), SkillTargetType.Monster, e:GetGridPosition())
  local tmpTargetIDs = targetSelector:DoSelectSkillTarget(e, SkillTargetType.Monster, scopeResult)
  local targetIDs = {}
  for _, id in ipairs(tmpTargetIDs) do
    if id ~= eNotify:GetID() and not table.icontains(targetIDs, id) then
      table.insert(targetIDs, id)
    end
  end
  if #targetIDs == 0 then
    return
  end
  local ownerEntity = notify:GetNotifyEntity()
  local ownerEntityID = ownerEntity and ownerEntity:GetID() or nil
  local defenderEntity = notify:GetDefenderEntity()
  local defenderEntityID = defenderEntity and defenderEntity:GetID() or nil
  local result = BuffResultSpreadDeadMonsterBuffLayerToOtherMonsters:New(ownerEntityID, defenderEntityID)
  local avgLayer = math.ceil(layer / #targetIDs)
  if avgLayer > self._maxSingleTargetAddLayer then
    avgLayer = self._maxSingleTargetAddLayer
  end
  for _, targetID in ipairs(targetIDs) do
    local eTarget = self._world:GetEntityByID(targetID)
    local buffInstance = eTarget:BuffComponent():GetSingleBuffByBuffEffect(self._layerType)
    if buffInstance then
      local casterEntity = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or nil
      local finalLayer = lsvcBuff:AddBuffLayer(eTarget, self._layerType, avgLayer, nil, casterEntity, "SpreadDeadMonsterBuffLayerToOtherMonsters")
      result:AddSpreadResult(targetID, self._layerType, avgLayer, finalLayer, buffInstance:BuffSeq(), casterEntity)
    end
  end
  return result
end
