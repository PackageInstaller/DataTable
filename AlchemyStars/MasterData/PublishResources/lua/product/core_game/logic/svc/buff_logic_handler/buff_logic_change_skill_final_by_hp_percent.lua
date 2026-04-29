local ChangeSkillFinalByHPPercentType = {RestHP = 1, LostHP = 2}
_enum("ChangeSkillFinalByHPPercentType", ChangeSkillFinalByHPPercentType)
_class("BuffLogicChangeSkillFinalByHPPercent", BuffLogicBase)
BuffLogicChangeSkillFinalByHPPercent = BuffLogicChangeSkillFinalByHPPercent

function BuffLogicChangeSkillFinalByHPPercent:Constructor(buffInstance, logicParam)
  self._HPPercent = logicParam.HPPercent or {}
  self._promote = logicParam.promote or {}
  self._useLinear = logicParam.useLinear
  self._promoteType = logicParam.promoteType or ChangeSkillFinalByHPPercentType.RestHP
  self._eachHpPercent = logicParam.eachHpPercent
  self._promotePercent = logicParam.promotePercent
  self._maxSkillFinal = logicParam.maxSkillFinal
  self._effectList = logicParam.effectList
  self._calcSourceType = tonumber(logicParam.hpPercentSourceType) or 1
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillFinalByHPPercent:DoLogic(notify)
  local sourceEntity
  if self._calcSourceType == 1 then
    sourceEntity = notify:GetDefenderEntity()
  elseif self._calcSourceType == 2 then
    sourceEntity = self._world:Player():GetCurrentTeamEntity()
  elseif self._calcSourceType == 3 then
    sourceEntity = self:GetEntity()
  end
  local cAttributes = sourceEntity:Attributes()
  local curHP = cAttributes:GetCurrentHP()
  local maxHP = cAttributes:CalcMaxHp()
  local percentHP = curHP / maxHP
  if self._promoteType == ChangeSkillFinalByHPPercentType.LostHP then
    percentHP = (maxHP - curHP) / maxHP
  end
  local promoteRate = 0
  if self._useLinear and self._useLinear == 1 then
    if self._eachHpPercent and self._promotePercent and self._eachHpPercent ~= 0 then
      promoteRate = percentHP / self._eachHpPercent * self._promotePercent
      if self._maxSkillFinal and promoteRate > self._maxSkillFinal then
        promoteRate = self._maxSkillFinal
      end
    end
  else
    local sepIdx = 0
    for index, per in ipairs(self._HPPercent) do
      if per >= percentHP then
        sepIdx = index
      end
    end
    promoteRate = self._promote[sepIdx] or 0
  end
  if promoteRate == 0 then
    return
  end
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, promoteRate)
  end
end

_class("BuffLogicRemoveSkillFinalByHPPercent", BuffLogicBase)
BuffLogicRemoveSkillFinalByHPPercent = BuffLogicRemoveSkillFinalByHPPercent

function BuffLogicRemoveSkillFinalByHPPercent:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
  self._effectList = logicParam.effectList
end

function BuffLogicRemoveSkillFinalByHPPercent:DoLogic()
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
