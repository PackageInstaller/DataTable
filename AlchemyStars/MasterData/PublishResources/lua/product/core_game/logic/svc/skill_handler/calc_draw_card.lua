_class("SkillEffectCalc_DrawCard", Object)
SkillEffectCalc_DrawCard = SkillEffectCalc_DrawCard

function SkillEffectCalc_DrawCard:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DrawCard:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local lsvcFeature = self._world:GetService("FeatureLogic")
  if not lsvcFeature:HasFeatureType(FeatureType.Card) then
    return
  end
  if not lsvcFeature:CanAddCard() then
    return
  end
  local cardType
  local fixedCard = lsvcFeature:GetNextDrawFixedCard()
  if fixedCard then
    cardType = fixedCard
  else
    local weightTb = {
      5,
      5,
      5
    }
    local teamEntity = self._world:Player():GetCurrentTeamEntity()
    if teamEntity then
      local teamEntityID = teamEntity:GetID()
      weightTb = lsvcFeature:GetRandomDrawCardWeight(teamEntityID)
    end
    weightTb = weightTb or {
      5,
      5,
      5
    }
    local totalWeight = 0
    for weightCard, weight in ipairs(weightTb) do
      totalWeight = totalWeight + weight
    end
    local randomSvc = self._world:GetService("RandomLogic")
    local randNum = randomSvc:LogicRand(1, totalWeight)
    local sumWeight = 0
    local findCardType = FeatureCardType.A
    for weightCard, weight in ipairs(weightTb) do
      sumWeight = sumWeight + weight
      if randNum <= sumWeight then
        findCardType = weightCard
        break
      end
    end
    cardType = findCardType
  end
  local result = SkillEffectResultDrawCard:New(cardType)
  return result
end
