_class("BuffLogicSetChainDamage", BuffLogicBase)
BuffLogicSetChainDamage = BuffLogicSetChainDamage

function BuffLogicSetChainDamage:Constructor(buffInstance, logicParam)
  self._damage = logicParam.damage
  self._recover = logicParam.recover
  self._enable = logicParam.enable or 1
  self._remove = logicParam.remove or 0
  self._lineEffectID = logicParam.lineEffectID
  self._removeAnim = logicParam.removeAnim
  self._removeEffectID = logicParam.removeEffectID
  self._removeTargetBuffEffectTypeList = logicParam.removeTargetBuffEffectTypeList or {}
  self._onlyView = logicParam.onlyView or 0
end

function BuffLogicSetChainDamage:DoLogic(notify)
  local entity = self._buffInstance:Entity()
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local casterEntity = context.casterEntity
  if not casterEntity then
    return
  end
  local effectCasterEntity = casterEntity
  if casterEntity:HasSuperEntity() then
    effectCasterEntity = casterEntity:GetSuperEntity()
  end
  if effectCasterEntity:GetID() == entity:GetID() and self._remove == 0 then
    return
  end
  if notify and notify:GetNotifyType() == NotifyType.ChangeTeamLeader then
  else
    local isAdd = self._remove ~= 1
    if isAdd then
      self:_SetLogicChainValue(entity:GetID(), effectCasterEntity:GetID())
      self:_SetLogicChainValue(effectCasterEntity:GetID(), entity:GetID())
    elseif self._onlyView == 0 then
      self:_ClearChainEntity(entity:GetID())
    else
      self._removeLineEntityList = {}
      local teamEntity = self._world:Player():GetCurrentTeamEntity()
      local teamLeader = teamEntity:Team():GetTeamLeaderEntity()
      table.insert(self._removeLineEntityList, teamEntity:GetID())
    end
  end
  local buffResult = BuffResultSetChainDamage:New(casterEntity:GetID(), entity:GetID(), self._lineEffectID, self._remove)
  buffResult:SetRemoveAnim(self._removeAnim)
  buffResult:SetRemoveEffectID(self._removeEffectID)
  buffResult:SetRemoveLineEntityList(self._removeLineEntityList)
  if notify and notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    buffResult:SetMonsterMoveOneFinish(notify:GetNotifyEntity():GetID(), notify:GetWalkPos())
  end
  if notify and notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    buffResult:SetTeamLeaderEachMoveEnd(notify:GetPos())
  end
  return buffResult
end

function BuffLogicSetChainDamage:DoOverlap(logicParam, context)
  self._buffInstance:SetContext(context)
  return self:DoLogic()
end

function BuffLogicSetChainDamage:_SetLogicChainValue(defenderID, chainEntityID, isAdd)
  local entity = self._world:GetEntityByID(defenderID)
  if not entity:HasLogicChainDamage() then
    entity:AddLogicChainDamage()
  end
  local logicChainDamage = entity:LogicChainDamage()
  if self._damage then
    logicChainDamage:SetChainDamageList(chainEntityID, self._damage)
  end
  if self._recover then
    logicChainDamage:SetChainRecoverList(chainEntityID, self._recover)
  end
  if self._enable then
    logicChainDamage:SetChainDamageEnable(self._enable == 1)
  end
end

function BuffLogicSetChainDamage:_ClearChainEntity(castererID)
  local entity = self._world:GetEntityByID(castererID)
  if not entity:HasLogicChainDamage() then
    entity:AddLogicChainDamage()
  end
  local logicChainDamage = entity:LogicChainDamage()
  self._removeLineEntityList = {}
  local damageList = logicChainDamage:GetChainDamageList()
  for chainEntityID, percent in pairs(damageList) do
    local chainEntity = self._world:GetEntityByID(chainEntityID)
    local chainEntityComponent = chainEntity:LogicChainDamage()
    chainEntityComponent:SetChainDamageList(castererID, nil)
    if not table.intable(self._removeLineEntityList, chainEntityID) then
      table.insert(self._removeLineEntityList, chainEntityID)
    end
  end
  local recoverList = logicChainDamage:GetChainRecoverList()
  for chainEntityID, percent in pairs(recoverList) do
    local chainEntity = self._world:GetEntityByID(chainEntityID)
    local chainEntityComponent = chainEntity:LogicChainDamage()
    chainEntityComponent:SetChainRecoverList(castererID, nil)
    if not table.intable(self._removeLineEntityList, chainEntityID) then
      table.insert(self._removeLineEntityList, chainEntityID)
    end
  end
  logicChainDamage:Clear()
end

function BuffLogicSetChainDamage:_RemoveTargetBuff(defenderID)
  if not self._removeTargetBuffEffectTypeList or table.count(self._removeTargetBuffEffectTypeList) == 0 then
    return
  end
  local entity = self._buffInstance:Entity()
  local defender = self._world:GetEntityByID(defenderID)
  local buffCmpt = defender:BuffComponent()
  local buffArray = buffCmpt:GetBuffArray()
  local buffCopy = table.shallowcopy(buffArray)
  for _, buffInstance in ipairs(buffCopy) do
    local target
    if table.intable(self._removeTargetBuffEffectTypeList, buffInstance:GetBuffEffectType()) then
      local context = buffInstance:Context()
      if context and context.casterEntity then
        local casterEntity = context.casterEntity
        local effectCasterEntity = casterEntity
        if casterEntity:HasSuperEntity() then
          effectCasterEntity = casterEntity:GetSuperEntity()
        end
        if effectCasterEntity:GetID() == entity:GetID() then
          buffInstance:Unload(NTBuffUnload:New())
        end
      end
    end
  end
end
