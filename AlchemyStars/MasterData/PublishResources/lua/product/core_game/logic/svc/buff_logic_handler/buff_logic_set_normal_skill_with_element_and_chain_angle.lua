_class("BuffLogicSetNormalSkillWithElementAndChainAngle", BuffLogicBase)
BuffLogicSetNormalSkillWithElementAndChainAngle = BuffLogicSetNormalSkillWithElementAndChainAngle

function BuffLogicSetNormalSkillWithElementAndChainAngle:Constructor(buffInstance, logicParam)
  self._element = logicParam.element
  self._skillList = logicParam.skillList
end

function BuffLogicSetNormalSkillWithElementAndChainAngle:DoLogic(notify)
  if not notify.GetChainPathType then
    return
  end
  local setSkillValue, setOrderValue, setBeforeMoveValue
  local chainElement = notify:GetChainPathType()
  if chainElement == self._element then
    setSkillValue = self._skillList
    setOrderValue = 1
    setBeforeMoveValue = true
  end
  local e = self._buffInstance:Entity()
  local buffCmpt = e:BuffComponent()
  buffCmpt:SetBuffValue("ChangeNormalSkillIDWithChainPathRightAngle", setSkillValue)
  buffCmpt:SetBuffValue("NormalSkillBeforeMove", setBeforeMoveValue)
  buffCmpt:SetBuffValue("PetRoundTeamOrder_" .. SkillType.Normal, setOrderValue)
end
