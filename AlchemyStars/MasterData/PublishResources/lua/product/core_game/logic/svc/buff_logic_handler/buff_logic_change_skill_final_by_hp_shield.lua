_class("BuffLogicChangeSkillFinalByHPShield", BuffLogicBase)
BuffLogicChangeSkillFinalByHPShield = BuffLogicChangeSkillFinalByHPShield

function BuffLogicChangeSkillFinalByHPShield:Constructor(buffInstance, logicParam)
  self._baseValue = logicParam.baseValue
  self._shieldParamMax = logicParam.shieldParamMax
  self._shieldPercentMax = logicParam.shieldPercentMax
  self._curHpParamMax = logicParam.curHpParamMax
  self._effectList = logicParam.effectList
  self._entity = buffInstance._entity
end

function BuffLogicChangeSkillFinalByHPShield:DoLogic(notify)
  local sourceEntity = self:GetEntity()
  if sourceEntity:HasPet() then
    local matchType = self._world:MatchType()
    if matchType ~= MatchType.MT_Maze and self._world:MatchType(GetMatchTypeType.SeasonMazeWorldBoss) ~= MatchType.MT_SeasonMaze then
      sourceEntity = sourceEntity:Pet():GetOwnerTeamEntity()
    end
  end
  local cAttributes = sourceEntity:Attributes()
  local maxHP = cAttributes:CalcMaxHp()
  local curHP = cAttributes:GetCurrentHP()
  local buffLogicService = self._world:GetService("BuffLogic")
  local curShieldValue = buffLogicService:GetHPShield(sourceEntity)
  if curShieldValue == 0 then
    return
  end
  if maxHP == 0 then
    return
  end
  local shieldParam = 0
  local curShieldPercent = curShieldValue / maxHP
  if curShieldPercent >= self._shieldPercentMax then
    shieldParam = self._shieldParamMax
  else
    shieldParam = curShieldPercent / self._shieldPercentMax * self._shieldParamMax
  end
  local hpParam = (1 - curHP / maxHP) * self._curHpParamMax
  local promoteRate = self._baseValue + shieldParam + hpParam
  if promoteRate == 0 then
    return
  end
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, promoteRate)
  end
end

_class("BuffLogicRemoveSkillFinalByHPShield", BuffLogicBase)
BuffLogicRemoveSkillFinalByHPShield = BuffLogicRemoveSkillFinalByHPShield

function BuffLogicRemoveSkillFinalByHPShield:Constructor(buffInstance, logicParam)
  self._entity = buffInstance._entity
  self._effectList = logicParam.effectList
end

function BuffLogicRemoveSkillFinalByHPShield:DoLogic()
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
