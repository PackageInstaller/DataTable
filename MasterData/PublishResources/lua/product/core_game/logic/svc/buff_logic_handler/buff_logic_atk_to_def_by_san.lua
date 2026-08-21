_class("BuffLogicAtkToDefBySan", BuffLogicBase)
BuffLogicAtkToDefBySan = BuffLogicAtkToDefBySan

function BuffLogicAtkToDefBySan:Constructor(buffInstance, logicParam)
  self._maxAtkPercent = logicParam.maxAtkPercent or 0
end

function BuffLogicAtkToDefBySan:DoLogic()
  local e = self._entity
  if not e:HasMonsterID() then
    return
  end
  local buffCmpt = e:BuffComponent()
  if buffCmpt == nil then
    return
  end
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.Sanity) then
    return
  end
  local monsterID = e:MonsterID():GetMonsterID()
  local cfgService = self._world:GetService("Config")
  local monsterConfigData = cfgService:GetMonsterConfigData()
  local baseAtk = monsterConfigData:GetMonsterAttack(monsterID)
  local baseDef = monsterConfigData:GetMonsterDefense(monsterID)
  local maxTransAtk = math.floor(baseAtk * tonumber(self._maxAtkPercent))
  local sanVal = lsvcFeature:GetSanValue()
  local maxSanValue = lsvcFeature:GetSanMaxValue()
  if maxSanValue == 0 then
    return
  end
  local sanRate = sanVal / maxSanValue
  local transVal = math.floor(maxTransAtk * sanRate)
  local newAtk = math.max(baseAtk - transVal, 0)
  local newDef = baseDef + transVal
  self._buffLogicService:ChangeBaseAttack(e, self:GetBuffSeq(), ModifyBaseAttackType.Attack, newAtk)
  self._buffLogicService:ChangeBaseDefence(e, self:GetBuffSeq(), ModifyBaseDefenceType.Defense, newDef)
  Log.info("BuffLogicAtkToDefBySan MonsterID:", monsterID, " transVal:", transVal, " newAtk:", newAtk, " newDef:", newDef)
  return true
end

_class("BuffLogicUndoAtkToDefBySan", BuffLogicBase)
BuffLogicUndoAtkToDefBySan = BuffLogicUndoAtkToDefBySan

function BuffLogicUndoAtkToDefBySan:DoLogic()
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffSeqID = self:GetBuffSeq()
  buffLogicService:RemoveBaseAttack(self._entity, buffSeqID, ModifyBaseAttackType.Attack)
  buffLogicService:RemoveBaseDefence(self._entity, buffSeqID, ModifyBaseDefenceType.Defense)
end
