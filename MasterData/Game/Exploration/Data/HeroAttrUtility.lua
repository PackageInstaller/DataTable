local HeroAttrUtility = {
  ExtraPropertyEnd = 100,
  BasePropertyStart = 100,
  BasePropertyEnd = 200,
  RatioPropertyStart = 200,
  RatioPropertyEnd = 300
}

function HeroAttrUtility.OffsetAttrFromDynHero(role, property, value)
  if property < HeroAttrUtility.ExtraPropertyEnd then
    role:SetExtraAttr(property, role:GetExtraAttr(property) + value)
  elseif property < HeroAttrUtility.BasePropertyEnd then
    local newPropNum = property - HeroAttrUtility.BasePropertyStart
    role:SetBaseAttr(newPropNum, role:GetBaseAttr(newPropNum) + value)
  elseif property < HeroAttrUtility.RatioPropertyEnd then
    local newPropNum = property - HeroAttrUtility.RatioPropertyStart
    role:SetRatioAttr(newPropNum, role:GetRatioAttr(newPropNum) + value)
  end
end

function HeroAttrUtility.OffsetAttrFormDynPlayer(dynPlayerData, property, value)
  if property < HeroAttrUtility.ExtraPropertyEnd then
    dynPlayerData:SetExtraAttr(property, dynPlayerData:GetExtraAttr(property) + value)
  elseif property < HeroAttrUtility.BasePropertyEnd then
    local newPropNum = property - HeroAttrUtility.BasePropertyStart
    dynPlayerData:SetBaseAttr(newPropNum, dynPlayerData:GetBaseAttr(newPropNum) + value)
  elseif property < HeroAttrUtility.RatioPropertyEnd then
    local newPropNum = property - HeroAttrUtility.RatioPropertyStart
    dynPlayerData:SetRatioAttr(newPropNum, dynPlayerData:GetRatioAttr(newPropNum) + value)
  end
end

return HeroAttrUtility
