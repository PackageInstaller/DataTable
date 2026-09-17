local this = class("conditionNode_13000", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local heroId = condition[2]
  local needFavorabilityLevel = condition[3]
  if L_HeroStore:getHasHero(heroId) then
    local heroGuild = L_HeroStore:getGuidByConfigId(heroId)
    local hero = L_HeroStore:getHero(heroGuild)
    local currLevel = L_HeroStore:getHeroFavorAbilityLevel(hero) or 0
    return needFavorabilityLevel <= currLevel
  end
  return false
end

return this
