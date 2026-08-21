_class("BuffLogicChangeSkillFinalByDotCount", BuffLogicBase)
BuffLogicChangeSkillFinalByDotCount = BuffLogicChangeSkillFinalByDotCount

function BuffLogicChangeSkillFinalByDotCount:Constructor(buffInstance, logicParam)
  self._changeValue = logicParam.changeValue or 0
  self._buffEffectList = logicParam.buffEffectList
  self._buffInstance._effectList = logicParam.effectList
end

function BuffLogicChangeSkillFinalByDotCount:DoLogic(notify)
  if notify.GetDefenderEntity then
    local defenderEntity = notify:GetDefenderEntity()
    local dotCount = self._buffLogicService:CalcBuffEffectCount(defenderEntity, self._buffEffectList)
    local changeValue = self._changeValue * dotCount
    for _, paramType in ipairs(self._buffInstance._effectList) do
      self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, changeValue)
    end
  end
end

_class("BuffLogicRemoveChangeSkillFinalByDotCount", BuffLogicBase)
BuffLogicRemoveChangeSkillFinalByDotCount = BuffLogicRemoveChangeSkillFinalByDotCount

function BuffLogicRemoveChangeSkillFinalByDotCount:Constructor(buffInstance, logicParam)
end

function BuffLogicRemoveChangeSkillFinalByDotCount:DoLogic()
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), paramType)
  end
end
