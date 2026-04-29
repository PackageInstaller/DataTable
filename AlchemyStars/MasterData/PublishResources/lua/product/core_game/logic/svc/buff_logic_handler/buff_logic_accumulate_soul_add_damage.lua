require("buff_logic_base")
_class("BuffLogicAccumulateSoulDefault", BuffLogicBase)
BuffLogicAccumulateSoulDefault = BuffLogicAccumulateSoulDefault

function BuffLogicAccumulateSoulDefault:Constructor(buffInstance, logicParam)
  self._baseSoulCount = logicParam.baseSoulCount or 0
  self._soulIncreaseRate = logicParam.soulIncreaseRate or 0.05
  self._buffInstance._effectList = logicParam.effectList
  self._buffComp = buffInstance:Entity():BuffComponent()
end

function BuffLogicAccumulateSoulDefault:DoLogic()
  self._buffComp:SetBuffValue("SoulCount", self._baseSoulCount)
  local curIncrease = self._baseSoulCount * self._soulIncreaseRate
  for _, paramType in ipairs(self._buffInstance._effectList) do
    self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, curIncrease)
  end
end

require("buff_logic_base")
_class("BuffLogicAccumulateSoulAddDamage", BuffLogicBase)
BuffLogicAccumulateSoulAddDamage = BuffLogicAccumulateSoulAddDamage

function BuffLogicAccumulateSoulAddDamage:Constructor(buffInstance, logicParam)
  self._maxSoulCount = logicParam.maxSoulCount or 5
  self._soulIncreaseRates = logicParam.soulIncreaseRates or {0.05, 0.05}
  self._buffInstance._effectList = logicParam.effectList
  self._buffComp = buffInstance:Entity():BuffComponent()
end

function BuffLogicAccumulateSoulAddDamage:DoLogic(notify)
  if notify:GetNotifyType() ~= NotifyType.CollectSouls then
    return
  end
  local collectNum = notify:GetSoulNum()
  local petEntity = self._buffInstance:Entity()
  local curMarkLayer = self._buffComp:GetBuffValue("SoulCount") or 0
  if curMarkLayer <= self._maxSoulCount then
    curMarkLayer = curMarkLayer + collectNum
    if curMarkLayer > self._maxSoulCount then
      curMarkLayer = self._maxSoulCount
    end
    self._buffComp:SetBuffValue("SoulCount", curMarkLayer)
    for _, paramType in ipairs(self._buffInstance._effectList) do
      self._buffLogicService:RemoveSkillIncrease(self._entity, self:GetBuffSeq(), paramType)
    end
    for i, paramType in ipairs(self._buffInstance._effectList) do
      local curIncrease = curMarkLayer * self._soulIncreaseRates[i]
      self._buffLogicService:ChangeSkillIncrease(self._entity, self:GetBuffSeq(), paramType, curIncrease)
    end
  end
  local result = BuffResultAccumulateSoulAddDamage:New(curMarkLayer)
  return result
end
