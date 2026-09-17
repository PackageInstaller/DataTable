local this = class("conditionNode_2006", require(L_R.condition .. "conditionNode"))

function this.checkFunc(condition)
  local heroId = condition[2]
  local needRankLevel = condition[3]
  local hero = L_HeroStore:getHero(heroId)
  if hero == nil then
    return false
  end
  local currLevel = L_HeroStore:getHeroRank(hero) or 0
  return needRankLevel <= currLevel
end

return this
