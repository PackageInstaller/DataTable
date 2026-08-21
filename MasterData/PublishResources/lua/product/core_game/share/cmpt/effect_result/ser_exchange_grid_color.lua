require("skill_effect_result_base")
_class("SkillEffectExchangeGridColorResult", SkillEffectResultBase)
SkillEffectExchangeGridColorResult = SkillEffectExchangeGridColorResult

function SkillEffectExchangeGridColorResult:Constructor(newGridList, summonTrapList)
  self._newGridList = newGridList
  self._summonTrapList = summonTrapList
  self._trapIDList = {}
end

function SkillEffectExchangeGridColorResult:GetEffectType()
  return SkillEffectType.ExChangeGridColor
end

function SkillEffectExchangeGridColorResult:GetNewGridList()
  return self._newGridList
end

function SkillEffectExchangeGridColorResult:GetSummonTrapList()
  return self._summonTrapList
end

function SkillEffectExchangeGridColorResult:SetTrapIDList(trapIDList)
  self._trapIDList = trapIDList
end

function SkillEffectExchangeGridColorResult:GetTrapIDList()
  return self._trapIDList
end

function SkillEffectExchangeGridColorResult:FindGridData(pos)
  for k, v in pairs(self._newGridList) do
    if k.x == pos.x and k.y == pos.y then
      return v
    end
  end
  return nil
end

function SkillEffectExchangeGridColorResult:GetSummonTrapEntityID(pos)
  for k, v in pairs(self._trapIDList) do
    if k.x == pos.x and k.y == pos.y then
      return v
    end
  end
  return nil
end
