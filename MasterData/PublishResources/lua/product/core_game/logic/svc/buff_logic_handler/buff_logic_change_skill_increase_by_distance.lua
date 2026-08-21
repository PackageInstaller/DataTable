_class("BuffLogicChangeSkillIncreaseByDistance", BuffLogicBase)
BuffLogicChangeSkillIncreaseByDistance = BuffLogicChangeSkillIncreaseByDistance

function BuffLogicChangeSkillIncreaseByDistance:Constructor(buffInstance, logicParam)
  self._ratesByDis = logicParam.ratesByDis or {}
  self._entity = buffInstance:Entity()
  self._disToPick = logicParam.disToPick
  self._buffInstance._effectList = logicParam.effectList
end

function BuffLogicChangeSkillIncreaseByDistance:DoLogic(notify)
  if notify == nil then
    return
  end
  local attacker = notify:GetNotifyEntity()
  if self._entity ~= attacker then
    return
  end
  local notifyType = notify:GetNotifyType()
  local attackerPos = self._entity:GridLocation().Position
  if self._disToPick then
    local pickIndex = tonumber(self._disToPick)
    local component = self._entity:ActiveSkillPickUpComponent()
    if component then
      local pickVec = component:GetAllValidPickUpGridPos()
      if pickIndex <= #pickVec then
        attackerPos = pickVec[pickIndex]
      end
    end
  end
  if notifyType ~= NotifyType.ChainSkillEachAttackStart or self._world:SubMatchType() == MatchType.MT_PopStarPro then
  else
    local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
    local logicChainPathCmpt = teamEntity:LogicChainPath()
    local chainPath = logicChainPathCmpt:GetLogicChainPath()
    if chainPath and 1 <= #chainPath then
      attackerPos = chainPath[#chainPath]
    end
  end
  local dis = 100
  local skillID = notify:GetSkillID()
  local configsvc = self._world:GetService("Config")
  local skillConfig = configsvc:GetSkillConfigData(skillID)
  local filter = skillConfig:GetScopeFilterParam()
  local targetMode = filter:GetTargetSelectionMode()
  if targetMode == SkillTargetSelectionMode.Grid then
    local defenderPos = notify:GetTargetPos()
    local offsetX = math.abs(defenderPos.x - attackerPos.x)
    local offsetY = math.abs(defenderPos.y - attackerPos.y)
    dis = offsetX > offsetY and offsetX or offsetY
  elseif targetMode == SkillTargetSelectionMode.Entity then
    local defender = notify:GetDefenderEntity()
    local defenderPos = defender:GridLocation().Position
    local defenderArea = defender:BodyArea():GetArea()
    for i, v in ipairs(defenderArea) do
      local pos = defenderPos + v
      local offsetX = math.abs(pos.x - attackerPos.x)
      local offsetY = math.abs(pos.y - attackerPos.y)
      local d = offsetX > offsetY and offsetX or offsetY
      dis = dis > d and d or dis
    end
  end
  local changeValue = self._ratesByDis[dis]
  if not changeValue then
    return
  end
  if notifyType == NotifyType.ChainSkillEachAttackStart then
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.ChainSkill, changeValue)
  elseif notifyType == NotifyType.ActiveSkillEachAttackStart then
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.ActiveSkill, changeValue)
  elseif notifyType == NotifyType.MonsterEachAttackStart then
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.MonsterDamage, changeValue)
  elseif self._buffInstance._effectList then
    for _, paramType in ipairs(self._buffInstance._effectList) do
      self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveSkillIncreaseByDistance", BuffLogicBase)
BuffLogicRemoveSkillIncreaseByDistance = BuffLogicRemoveSkillIncreaseByDistance

function BuffLogicRemoveSkillIncreaseByDistance:Constructor(buffInstance, logicParam)
  self._entity = buffInstance:Entity()
end

function BuffLogicRemoveSkillIncreaseByDistance:DoLogic(data)
  if data == nil then
    return
  end
  local attacker = data:GetNotifyEntity()
  if self._entity ~= attacker then
    return
  end
  local notifyType = data:GetNotifyType()
  if notifyType == NotifyType.ChainSkillEachAttackEnd then
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.ChainSkill)
  elseif notifyType == NotifyType.ActiveSkillEachAttackEnd then
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.ActiveSkill)
  elseif notifyType == NotifyType.MonsterEachAttackEnd then
    self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), ModifySkillIncreaseParamType.MonsterDamage)
  elseif self._buffInstance._effectList then
    for _, paramType in ipairs(self._buffInstance._effectList) do
      self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), paramType)
    end
  end
end
