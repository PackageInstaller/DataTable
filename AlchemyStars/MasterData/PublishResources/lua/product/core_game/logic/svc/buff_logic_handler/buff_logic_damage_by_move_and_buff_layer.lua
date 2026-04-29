_class("BuffLogicDamageByMoveAndBuffLayer", BuffLogicBase)
BuffLogicDamageByMoveAndBuffLayer = BuffLogicDamageByMoveAndBuffLayer

function BuffLogicDamageByMoveAndBuffLayer:Constructor(buffInstance, logicParam)
  self._damageParam = logicParam
  self._basePercent = logicParam.percent
  self._layerType = logicParam.layerType or self._buffInstance:GetBuffEffectType()
  self._monstBuffLayerAddSkillFinal = logicParam.monstBuffLayerAddSkillFinal or 0
end

function BuffLogicDamageByMoveAndBuffLayer:DoLogic(notify)
  local context = self._buffInstance:Context()
  if not context then
    return
  end
  local petEntity = context.casterEntity
  if not petEntity then
    return
  end
  local defender = self._entity
  local moveGridCount = 1
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    moveGridCount = 1
  elseif notify:GetNotifyType() == NotifyType.HitBackEnd or notify:GetNotifyType() == NotifyType.TractionEnd then
    local posStart = notify:GetPosStart()
    local posEnd = notify:GetPosEnd()
    moveGridCount = GameHelper.ComputeLogicStep(posStart, posEnd)
  elseif notify:GetNotifyType() == NotifyType.Teleport then
    local posOld = notify:GetPosOld()
    local posNew = notify:GetPosNew()
    moveGridCount = GameHelper.ComputeLogicStep(posOld, posNew)
  end
  if moveGridCount == 0 then
    return
  end
  local playerElementCmpt = petEntity:Element()
  if playerElementCmpt then
    playerElementCmpt:SetUseSecondaryType(false)
  end
  local svc = self._world:GetService("BuffLogic")
  local curMarkLayer = svc:GetBuffLayer(defender, self._layerType)
  if curMarkLayer == 0 then
    return
  end
  local newPercent = 0
  newPercent = self._basePercent * curMarkLayer * moveGridCount
  self._damageParam.percent = newPercent
  if self._damageParam.useSnapAttack then
    self._damageParam.simpleDamage = self._buffInstance:GetSnapCasterAttack()
  end
  self._world:GetMatchLogger():BeginBuff(defender:GetID(), self._buffInstance:BuffID())
  local defenderHasMostBuffLayer = false
  if self._monstBuffLayerAddSkillFinal ~= 0 then
    defenderHasMostBuffLayer = self:_OnCheckTTDefenderHasMostBuffLayer()
    if defenderHasMostBuffLayer then
      self._buffLogicService:ChangeSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.ActiveSkill, self._monstBuffLayerAddSkillFinal)
    end
  end
  local blsvc = self._world:GetService("BuffLogic")
  local damageInfo = blsvc:DoBuffDamage(self._buffInstance:BuffID(), petEntity, defender, self._damageParam)
  self._buffLogicService:RemoveSkillFinalParam(petEntity, self:GetBuffSeq(), ModifySkillParamType.ActiveSkill)
  self._world:GetMatchLogger():EndBuff(defender:GetID())
  local buffResult = BuffResultDamage:New(damageInfo)
  if notify:GetNotifyType() == NotifyType.MonsterMoveOneFinish then
    local walkPos = notify:GetWalkPos()
    buffResult:SetWalkPos(walkPos)
  end
  if notify:GetNotifyType() == NotifyType.TeamLeaderEachMoveEnd then
    local walkPos = notify:GetPos()
    buffResult:SetWalkPos(walkPos)
  end
  return buffResult
end

function BuffLogicDamageByMoveAndBuffLayer:_OnCheckTTDefenderHasMostBuffLayer()
  local defenderEntity = self._entity
  if not defenderEntity then
    return false
  end
  local buffCmp = defenderEntity:BuffComponent()
  if not buffCmp then
    return false
  end
  local satisfied = false
  local buffEffectType = self._layerType
  local svc = self._world:GetService("BuffLogic")
  local monsterEntityList = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(monsterGroup:GetEntities()) do
    if not e:HasDeadMark() then
      table.insert(monsterEntityList, e)
    end
  end
  if defenderEntity:HasTeam() then
    table.insert(monsterEntityList, defenderEntity)
  end
  if table.count(monsterEntityList) == 0 then
    return false
  end
  local hasMostBuffLayerMonsterEntityList = {}
  local mostBuffLayer = 0
  for _, e in ipairs(monsterEntityList) do
    local curMarkLayer = svc:GetBuffLayer(e, buffEffectType)
    if mostBuffLayer < curMarkLayer then
      table.clear(hasMostBuffLayerMonsterEntityList)
      table.insert(hasMostBuffLayerMonsterEntityList, e)
      mostBuffLayer = curMarkLayer
    elseif curMarkLayer == mostBuffLayer and curMarkLayer ~= 0 then
      table.insert(hasMostBuffLayerMonsterEntityList, e)
    end
  end
  if table.count(hasMostBuffLayerMonsterEntityList) == 0 then
    return false
  end
  local hasMostBuffLayerMonsterEntity
  if table.count(hasMostBuffLayerMonsterEntityList) > 0 then
    local mostHp = 0
    for _, e in ipairs(hasMostBuffLayerMonsterEntityList) do
      local curhp = e:Attributes():GetCurrentHP()
      if mostHp < curhp then
        curhp = mostHp
        hasMostBuffLayerMonsterEntity = e
      end
    end
  end
  if not hasMostBuffLayerMonsterEntity then
    return false
  end
  satisfied = hasMostBuffLayerMonsterEntity:GetID() == defenderEntity:GetID()
  return satisfied
end
