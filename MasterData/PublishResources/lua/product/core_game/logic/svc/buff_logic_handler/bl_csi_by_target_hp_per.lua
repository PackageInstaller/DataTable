_class("BuffLogicChangeSkillIncreaseByTargetHPPercent", BuffLogicBase)
BuffLogicChangeSkillIncreaseByTargetHPPercent = BuffLogicChangeSkillIncreaseByTargetHPPercent

function BuffLogicChangeSkillIncreaseByTargetHPPercent:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._buffInstance._effectList = logicParam.effectList
  self._maxHpPercent = logicParam.maxHpPercent
  self._entity = buffInstance._entity
  self._targetIsTeam = logicParam.targetIsTeam or 0
end

function BuffLogicChangeSkillIncreaseByTargetHPPercent:DoLogic(notify)
  if not notify.GetDefenderEntity then
    return
  end
  local e = notify:GetDefenderEntity()
  if self._targetIsTeam == 1 then
    e = self._world:Player():GetCurrentTeamEntity()
  end
  local attrCmpt = e:Attributes()
  local max_hp = attrCmpt:CalcMaxHp()
  local cur_hp = e:Attributes():GetCurrentHP()
  local losePercent = 1 - cur_hp / max_hp
  local changeValue = 0
  if losePercent ~= 0 then
    if self._maxHpPercent and losePercent > self._maxHpPercent then
      losePercent = self._maxHpPercent
    end
    changeValue = losePercent * self._changeValue
  end
  for _, paramType in ipairs(self._buffInstance._effectList) do
    if changeValue ~= 0 then
      self._buffLogicService:ChangeSkillIncrease(self._entity, self._buffInstance._buffSeq, paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveSkillIncreaseByTargetHPPercent", BuffLogicBase)
BuffLogicRemoveSkillIncreaseByTargetHPPercent = BuffLogicRemoveSkillIncreaseByTargetHPPercent

function BuffLogicRemoveSkillIncreaseByTargetHPPercent:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
end

function BuffLogicRemoveSkillIncreaseByTargetHPPercent:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillIncrease(self._entity, self._buffInstance:BuffSeq(), paramType)
  end
end
