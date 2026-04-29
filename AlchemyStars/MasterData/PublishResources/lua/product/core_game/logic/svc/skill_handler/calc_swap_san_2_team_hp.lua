_class("SkillEffectCalc_SwapSan2TeamHp", Object)
SkillEffectCalc_SwapSan2TeamHp = SkillEffectCalc_SwapSan2TeamHp

function SkillEffectCalc_SwapSan2TeamHp:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SwapSan2TeamHp:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local resultList = {}
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.Sanity) then
    return resultList
  end
  local curSan = lsvcFeature:GetSanValue()
  local maxSan = lsvcFeature:GetSanMaxValue()
  if curSan <= 0 then
    return resultList
  end
  if maxSan <= 0 then
    return resultList
  end
  local sanPercent = curSan / maxSan
  local teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  local teamAttrConmpt = teamEntity:Attributes()
  local teamCurHP = teamAttrConmpt:GetCurrentHP()
  local teamMaxHP = teamAttrConmpt:CalcMaxHp()
  local hpPercent = teamCurHP / teamMaxHP
  if sanPercent ~= hpPercent then
    local result = SkillEffectResult_SwapSan2TeamHp:New(hpPercent, sanPercent)
    table.insert(resultList, result)
  end
  return resultList
end
