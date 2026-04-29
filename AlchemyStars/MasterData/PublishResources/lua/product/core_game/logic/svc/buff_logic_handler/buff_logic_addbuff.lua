_class("BuffLogicAddBuff", BuffLogicBase)
BuffLogicAddBuff = BuffLogicAddBuff

function BuffLogicAddBuff:Constructor(buffInstance, logicParam)
  self._buffID = logicParam.buffID
  self._targetType = logicParam.targetType or BuffTargetType.Self
  self._targetParam = logicParam.targetParam or 0
  self._layerName = logicParam.layerName or nil
  self._light = logicParam.light or 0
  self._saveDataName = logicParam.saveDataName
  self._addBuffType = logicParam.addTimesType or SkillAddBuffType.Default
  self._buffCountParam = logicParam.addTimesParam
  self._useNotifyBuffID = logicParam.useNotifyBuffID == 1
  self._transmitAttack = logicParam.transmitAttack
  self._getFinalAtk = logicParam.isTransmitFinalAtk
  self._transmitDefence = logicParam.transmitDefence
  self._getFinalDefence = logicParam.isTransmitFinalDefense
  self._ownerAsBuffSource = logicParam.ownerAsBuffSource or 0
  self._logicParam = logicParam
end

function BuffLogicAddBuff:_DoSingleAddBuff(buffSvc, result, target, context, times)
  if self._buffInstance._buffID == self._buffID then
    if EDITOR then
      Log.exception("Buff自己加自己循环了，请修改 Buff:", self._buffID)
    else
      Log.fatal("Buff自己加自己循环了，请修改 Buff:", self._buffID)
    end
  end
  local buffSource = BuffSource:New(BuffSourceType.Buff, context.casterEntity:GetID())
  for t = 1, times do
    local ins = buffSvc:AddBuff(self._buffID, target, context, buffSource)
    if ins then
      result:AddBuffData(target:GetID(), ins:BuffSeq())
    end
  end
end

function BuffLogicAddBuff:RandomBuffID()
  local randomBuffIDs = {}
  local totalWeight = 0
  for _, value in pairs(self._targetParam.randomBuffIDs) do
    totalWeight = totalWeight + value[2]
    table.insert(randomBuffIDs, {
      ID = value[1],
      Weight = value[2]
    })
  end
  local world = self._buffInstance:World()
  local randomSvc = world:GetService("RandomLogic")
  local random = randomSvc:LogicRand(1, totalWeight)
  local curWeight = 0
  for _, buffInfo in ipairs(randomBuffIDs) do
    curWeight = curWeight + buffInfo.Weight
    if random <= curWeight then
      self._buffID = buffInfo.ID
      return
    end
  end
end

function BuffLogicAddBuff:DoLogic(notify)
  local world = self._buffInstance:World()
  self._targetType = world:ReplaceBuffTarget(self._targetType)
  if self._useNotifyBuffID and type(notify.GetBuffID) == "function" then
    Log.info(self._className, "useNotifyBuffID=1, formerBuffID=", self._buffID, "newBuffID=", notify:GetBuffID())
    self._buffID = notify:GetBuffID()
  end
  if self._targetType == BuffTargetType.SkillTargetRandomBuff then
    self:RandomBuffID()
  end
  if self._targetType == BuffTargetType.RandomMonsterByLayer and self._layerName then
    self._targetType = BuffTargetType.RandomMonster
    self._targetParam = tonumber(self._buffComponent:GetBuffValue(self._layerName)) or 0
  end
  local result = BuffResultAddBuff:New()
  local owner = self._buffInstance:Entity()
  local buffSvc = world:GetService("BuffLogic")
  local es = self:_GetTargetEntities(buffSvc, owner, notify)
  for _, e in ipairs(es) do
    local times = 1
    if self._targetType == BuffTargetType.SelfLayerComboModX then
      local x = self._targetParam
      if x == 0 then
        Log.exception(self._className, "SelfLayerComboModX: Non-zero targetParam required. ")
      end
      local battlesvc = world:GetService("Battle")
      local comboNum = battlesvc:GetLogicComboNum()
      times = math.modf(comboNum / x)
    else
      times = buffSvc:CalcAddTimesByParam(self._addBuffType, self._buffCountParam, owner, e, notify, nil)
    end
    if self._transmitAttack then
      local casterEntity = self:GetEntity()
      local actualAttack = casterEntity:Attributes():GetAttribute("Attack")
      if self._getFinalAtk then
        actualAttack = casterEntity:Attributes():GetAttack()
      end
      e:BuffComponent():SetBuffValue("GuestAttack", actualAttack)
    end
    if self._transmitDefence then
      local casterEntity = self:GetEntity()
      local actualDefense = casterEntity:Attributes():GetAttribute("Defense")
      if self._getFinalDefence then
        actualDefense = casterEntity:Attributes():GetDefence()
      end
      e:BuffComponent():SetBuffValue("GuestDefence", actualDefense)
    end
    local caster = self._buffInstance:Context() and self._buffInstance:Context().casterEntity or owner
    if self._ownerAsBuffSource and self._ownerAsBuffSource == 1 then
      caster = owner
    end
    self:_DoSingleAddBuff(buffSvc, result, e, {casterEntity = caster}, times)
  end
  local arr = result:GetBuffArray()
  if 0 < #arr then
    result:SetLight(self._light)
    if notify.GetAttackPos and notify.GetTargetPos then
      result:SetAttackPos(notify:GetAttackPos())
      result:SetTargetPos(notify:GetTargetPos())
    end
    if notify.GetRandHalfDamageIndex then
      local randHalfDamageIndex = notify:GetRandHalfDamageIndex()
      if randHalfDamageIndex then
        result:SetRandHalfDamageIndex(randHalfDamageIndex)
      end
    end
    if self._targetType == BuffTargetType.SkillTargetXScopeType then
      local attackPos = notify:GetAttackPos()
      local targetPos = notify:GetTargetPos()
      result:SetAttackPos(attackPos)
      result:SetTargetPos(targetPos)
    end
    if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
      local walkPos = notify:GetPos()
      result:SetWalkPos(walkPos)
    end
    if notify:GetNotifyType() == NotifyType.NotifyLayerChange then
      local nt = notify
      result:SetNotifyLayerChange_Entity(nt:GetNotifyEntity())
      result:SetNotifyLayerChange_TotalLayer(nt:GetTotalCount())
      result.__oldFinalLayer = nt.__oldFinalLayer
    end
    result.__buffID = self._buffID
    if notify and notify:GetNotifyType() == NotifyType.EntityMoveEnd then
      local walkPos = notify:GetPosNew()
      result:SetWalkPos(walkPos)
    end
    if notify:GetNotifyType() == NotifyType.AutoBeadSkillEachAttackEnd then
      local nt = notify
      result:SetAutoBeadSkillIndex(nt:GetAutoBeadSkillIndex())
      local battleStatCmpt = self._world:BattleStat()
      local round = battleStatCmpt:GetLevelTotalRoundCount()
      result:SetLevelTotalRoundCount(round)
    end
    if notify.GetNormalAttackIndex and notify:GetNormalAttackIndex() then
      result:SetNormalAttackIndex(notify:GetNormalAttackIndex())
    end
    if notify.GetSkillID and notify:GetSkillID() then
      result:SetSkillID(notify:GetSkillID())
    end
    return result
  end
end

function BuffLogicAddBuff:_GetTargetEntities(buffSvc, owner, notify)
  local es = {}
  if self._targetType == BuffTargetType.Self then
    es[#es + 1] = owner
  elseif self._targetType == BuffTargetType.SkillTarget then
    table.appendArray(es, self:_GetTargetEntitiesFromNotifyDefender(notify))
  elseif self._targetType == BuffTargetType.SkillTargetNoRepeatID then
    local targetFromNotify = self:_GetTargetEntitiesFromNotifyDefender(notify)
    table.appendArray(es, table.unique(targetFromNotify))
  elseif self._targetType == BuffTargetType.SkillTargetXScopeType then
    local attackPos = notify:GetAttackPos()
    local targetPos = notify:GetTargetPos()
    if notify:GetDefenderEntity() == owner and math.abs(attackPos.x - targetPos.x) == 1 and math.abs(attackPos.y - targetPos.y) == 1 then
      es[#es + 1] = notify:GetDefenderEntity()
    end
  elseif self._targetType == BuffTargetType.NotifyTarget then
    es[#es + 1] = notify:GetNotifyEntity()
  elseif self._targetType == BuffTargetType.TheOneLastHitMe then
    if notify.GetDamageSrcEntity then
      local damageSrcEntity = notify:GetDamageSrcEntity()
      if "number" == type(damageSrcEntity) then
        damageSrcEntity = self._world:GetEntityByID(damageSrcEntity)
      end
      es[#es + 1] = damageSrcEntity
    end
  elseif self._targetType == BuffTargetType.SkillTargetRandomByLayer then
    if notify:GetScopeResult() ~= nil then
      local scopeResult = notify:GetScopeResult()
      local tmp = scopeResult:GetTargetIDs()
      local targetIDs = {}
      for i = 1, #tmp do
        targetIDs[i] = tmp[i]
      end
      local count = tonumber(self._buffComponent:GetBuffValue(self._layerName)) or 0
      local randomSvc = self._world:GetService("RandomLogic")
      while 0 < count and 0 < #targetIDs do
        local index = randomSvc:LogicRand(1, #targetIDs)
        local targetID = targetIDs[index]
        local targetEntity = self._world:GetEntityByID(targetID)
        es[#es + 1] = targetEntity
        table.remove(targetIDs, index)
        count = count - 1
      end
    end
  elseif self._targetType == BuffTargetType.AlreadySelectData then
    local defenders = self:_GetTargetEntitiesFromNotifyDefender(notify)
    local targetIDs = self._buffComponent:GetBuffValue(self._saveDataName)
    if targetIDs and 0 < #targetIDs then
      for _, e in ipairs(defenders) do
        if table.icontains(targetIDs, e:GetID()) then
          es[#es + 1] = e
        end
      end
    end
  elseif self._targetType == BuffTargetType.Defender then
    table.appendArray(es, self:_GetTargetEntitiesFromNotifyDefender(notify))
  elseif self._targetType == BuffTargetType.SelfLayerComboModX then
    es[#es + 1] = owner
  elseif self._targetType == BuffTargetType.SkillTargetRandomBuff then
    es[#es + 1] = owner
  elseif self._targetType == BuffTargetType.MyTrap then
    local buffTargetParam = self._targetParam
    local tarTrapIdList = {}
    if buffTargetParam and type(buffTargetParam) == "table" and buffTargetParam.trapIDs then
      tarTrapIdList = buffTargetParam.trapIDs
    end
    local checkTrapId = false
    if tarTrapIdList and 0 < #tarTrapIdList then
      checkTrapId = true
    end
    local g = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
    local listTrap = g:GetEntities()
    for i = 1, #listTrap do
      local trapEntity = listTrap[i]
      if trapEntity:HasSummoner() then
        local summonerEntity = trapEntity:GetSummonerEntity()
        local isOwner = summonerEntity == owner
        if not isOwner and summonerEntity and summonerEntity:HasPet() then
          local cTeam = summonerEntity:Pet():GetOwnerTeamEntity():Team()
          local petEntities = cTeam:GetTeamPetEntities()
          for _, e in ipairs(petEntities) do
            if e:GetID() == summonerEntity:GetID() then
              isOwner = true
              break
            end
          end
        end
        if isOwner then
          if checkTrapId then
            local trapID = trapEntity:Trap():GetTrapID()
            if table.icontains(tarTrapIdList, trapID) then
              table.insert(es, trapEntity)
            end
          else
            table.insert(es, trapEntity)
          end
        end
      end
    end
  elseif self._targetType == BuffTargetType.PetHpChangeSourcePet then
    local nt = notify
    local targetEntity
    if nt and nt.GetDamageSrcEntityID then
      local tarEntityID = nt:GetDamageSrcEntityID()
      local sourceEntity = self._world:GetEntityByID(tarEntityID)
      if sourceEntity then
        if sourceEntity:HasSuperEntity() then
          sourceEntity = sourceEntity:GetSuperEntity()
        end
        if sourceEntity:HasPet() then
          targetEntity = sourceEntity
        end
      end
    end
    if targetEntity then
      es[#es + 1] = targetEntity
    end
  elseif self._targetType == BuffTargetType.SpCampTypeMonster then
    local MonsterEntityArray = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
    for k, monsterEntity in ipairs(MonsterEntityArray) do
      if not monsterEntity:HasDeadMark() then
        local monsterIDCmpt = monsterEntity:MonsterID()
        local campType = monsterIDCmpt:GetCampType()
        if table.icontains(self._targetParam, campType) then
          table.insert(es, monsterEntity)
        end
      end
    end
  else
    es = buffSvc:CalcBuffTargetEntities(self._targetType, self._targetParam, owner)
  end
  return es
end

function BuffLogicAddBuff:_GetTargetEntitiesFromNotifyDefender(notify)
  local es = {}
  if notify.GetDefenderEntityIDList then
    local eids = notify:GetDefenderEntityIDList()
    for _, eid in ipairs(eids) do
      local e = self._world:GetEntityByID(eid)
      es[#es + 1] = e
    end
  elseif notify.GetDefenderEntity then
    es[#es + 1] = notify:GetDefenderEntity()
  end
  return es
end

_class("BuffLogicRemoveBuff", BuffLogicBase)
BuffLogicRemoveBuff = BuffLogicRemoveBuff

function BuffLogicRemoveBuff:Constructor(buffInstance, logicParam)
  self._buffEffectTypeList = logicParam.buffEffectTypeList
  self._targetType = logicParam.targetType
  self._targetParam = logicParam.targetParam
  self._entity = buffInstance._entity
  self._black = logicParam.black or 0
end

function BuffLogicRemoveBuff:DoLogic(notify)
  local owner = self._buffInstance:Entity()
  local w = self._buffInstance:World()
  local buffSvc = w:GetService("BuffLogic")
  local es = {}
  if self._targetType == BuffTargetType.Self then
    es[#es + 1] = owner
  elseif self._targetType == BuffTargetType.SkillTarget then
    if notify.GetDefenderEntityIDList then
      local eids = notify:GetDefenderEntityIDList()
      for _, id in ipairs(eids) do
        local defender = self._world:GetEntityByID(id)
        es[#es + 1] = defender
      end
    elseif notify._defender then
      es[#es + 1] = notify._defender
    else
      es[#es + 1] = notify:GetNotifyEntity()
    end
  elseif self._targetType == BuffTargetType.Defender and notify.GetDefenderEntity then
    table.insert(es, notify:GetDefenderEntity())
  elseif self._targetType == BuffTargetType.Defender and notify.GetDefenderEntityIDList then
    local eids = notify:GetDefenderEntityIDList()
    for _, eid in ipairs(eids) do
      local e = self._world:GetEntityByID(eid)
      es[#es + 1] = e
    end
  else
    es = buffSvc:CalcBuffTargetEntities(self._targetType, self._targetParam, owner)
  end
  local result = BuffResultRemoveBuff:New()
  for i, e in ipairs(es) do
    for _, buffEffectType in ipairs(self._buffEffectTypeList) do
      local buffComponent = e:BuffComponent()
      if buffComponent then
        local tSeqID = buffComponent:RemoveBuffByEffectType(buffEffectType, NTBuffUnload:New())
        result:AddRemovedInfo(e:GetID(), tSeqID)
      end
    end
  end
  if notify and notify.GetRandHalfDamageIndex then
    local randHalfDamageIndex = notify:GetRandHalfDamageIndex()
    if randHalfDamageIndex then
      result:SetRandHalfDamageIndex(randHalfDamageIndex)
    end
  end
  if notify and (notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd or notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveStart) then
    local walkPos = notify:GetPos()
    result:SetWalkPos(walkPos)
  end
  if notify and notify:GetNotifyType() == NotifyType.EntityMoveEnd then
    local walkPos = notify:GetPosNew()
    result:SetWalkPos(walkPos)
  end
  if notify:GetNotifyType() == NotifyType.ChainSkillAttackEnd then
    result:SetNotifyEntityID(notify:GetNotifyEntity():GetID())
    result:SetNotifyChainSkillId(notify:GetChainSkillId())
    result:SetNotifyChainSkillTimeIndex(notify:GetChainSkillTimeIndex())
    result:SetNotifyChainSkillStageIndex(notify:GetChainSkillStageIndex())
  end
  if notify:GetNotifyType() == NotifyType.AutoBeadSkillEachEnd then
    result:SetAutoBeadSkillIndex(notify:GetAutoBeadSkillIndex())
  end
  result:SetBlack(self._black)
  return result
end
