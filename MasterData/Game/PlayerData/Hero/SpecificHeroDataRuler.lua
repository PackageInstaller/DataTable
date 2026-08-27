local SpecificHeroDataRuler = class("SpecificHeroDataRuler")
SpecificHeroDataRuler.eSpecificHeroRuler = {
  customLevel = 1,
  customStar = 2,
  customPotential = 3,
  isSkillFullLevel = 4,
  isRemoveAllBounce = 5,
  customSkillLevelRange = 6,
  customSkillLevel = 7
}

function SpecificHeroDataRuler.ctorWithChallengeCfg(cfg)
  local data = SpecificHeroDataRuler.New(cfg.hero_level, cfg.hero_star, cfg.hero_rank, true, true)
  return data
end

function SpecificHeroDataRuler:ctor(customLevel, customStar, customPotential, isSkillFullLevel, isRemoveAllBounce)
  self.ruler = {}
  self.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customLevel] = {customLevel, customLevel}
  self.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customStar] = {customStar, customStar}
  self.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customPotential] = {customPotential, customPotential}
  self.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isSkillFullLevel] = isSkillFullLevel or false
  self.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isRemoveAllBounce] = isRemoveAllBounce or false
end

function SpecificHeroDataRuler.ctorWithWeeklyChallengeCfg(cfg, weeklyData)
  local data = SpecificHeroDataRuler.New()
  local heroIds = weeklyData.heroIdList
  data.heroIds = heroIds
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customLevel] = {
    cfg.hero_level_min,
    cfg.hero_level_max
  }
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customStar] = {
    cfg.hero_star_min,
    cfg.hero_star_max
  }
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customPotential] = {
    cfg.hero_rank_min,
    cfg.hero_rank_max
  }
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customSkillLevelRange] = {
    cfg.hero_skill_level_min,
    cfg.hero_skill_level_max
  }
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isSkillFullLevel] = false
  data.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isRemoveAllBounce] = true
  return data
end

function SpecificHeroDataRuler.ctorWithBrotatoChallenge(stageId)
  local cfg = ConfigData.brotato_challenge[stageId]
  local data = SpecificHeroDataRuler.New()
  local heroIds = cfg.hero_list
  data.heroIds = heroIds
  return data
end

function SpecificHeroDataRuler:CampareTo(otherRuler)
  return self:__CampareCheckData(self.ruler, otherRuler.ruler)
end

function SpecificHeroDataRuler:__CampareCheckData(table1, table2)
  if table1 == nil or table2 == nil then
    return table1 == table2
  end
  if table.count(table1) ~= table.count(table2) then
    return false
  end
  for k1, v1 in pairs(table1) do
    local v2 = table2[k1]
    if type(v1) == "table" then
      if not self:__CampareCheckData(v1, v2) then
        return false
      end
    elseif v1 ~= v2 then
      return false
    end
  end
  return true
end

return SpecificHeroDataRuler
