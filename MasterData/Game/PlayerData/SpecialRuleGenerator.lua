local SpecialRuleGenerator = class("SpecialRuleGenerator")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local SpecificHeroDataRuler = require("Game.PlayerData.Hero.SpecificHeroDataRuler")

function SpecialRuleGenerator:SetSpeicalRuler(specialRuler)
  self.specialRuler = specialRuler
  self.specificHeroDataCacheDic = {}
end

function SpecialRuleGenerator:GetSpecificHeroData(heroId)
  if self.specialRuler == nil then
    error("self.specialRuler is empty")
    return nil
  end
  local heroData = self.specificHeroDataCacheDic[heroId]
  if heroData == nil then
    heroData = self.CreateSpecificHeroData(heroId, self.specialRuler)
    self.specificHeroDataCacheDic[heroId] = heroData
  end
  return heroData
end

function SpecialRuleGenerator:CancelSpeicalRulerCache()
  self.specialRuler = nil
  self.specificHeroDataCacheDic = {}
end

function SpecialRuleGenerator.CreateSpecificHeroData(heroId, specificHeroDataRuler)
  local customLevel = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customLevel]
  local customStar = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customStar]
  local customPotential = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customPotential]
  local customSkillLevelRange = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.customSkillLevelRange]
  local isSkillFullLevel = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isSkillFullLevel]
  local isRemoveAllBounce = specificHeroDataRuler.ruler[SpecificHeroDataRuler.eSpecificHeroRuler.isRemoveAllBounce]
  local OringHeroData = PlayerDataCenter.heroDic[heroId]
  local heroCfg = ConfigData.hero_data[heroId]
  local heroLevel = 1
  if OringHeroData ~= nil then
    if table.IsEmptyTable(customLevel) then
      heroLevel = OringHeroData.level
    else
      heroLevel = math.clamp(OringHeroData.level, customLevel[1], customLevel[2])
    end
  elseif not table.IsEmptyTable(customLevel) then
    heroLevel = customLevel[1]
  end
  local heroStar = heroCfg.rank
  if OringHeroData ~= nil then
    if table.IsEmptyTable(customStar) then
      heroStar = OringHeroData.rank
    else
      heroStar = math.clamp(OringHeroData.rank, customStar[1], customStar[2])
    end
  elseif not table.IsEmptyTable(customStar) then
    heroStar = customStar[1]
  end
  local heroPotentialLvl = 1
  if OringHeroData ~= nil then
    if table.IsEmptyTable(customPotential) then
      heroPotentialLvl = OringHeroData.potential
    else
      heroPotentialLvl = math.clamp(OringHeroData.level, customPotential[1], customPotential[2])
    end
  elseif not table.IsEmptyTable(customPotential) then
    heroPotentialLvl = customPotential[1]
  end
  local vowMsg = table.emptytable
  if OringHeroData ~= nil then
    vowMsg = OringHeroData.vow
  end
  local heroData = HeroData.New({
    basic = {
      id = heroId,
      level = heroLevel,
      exp = 0,
      star = heroStar,
      potentialLvl = heroPotentialLvl,
      ts = not OringHeroData and -1 or OringHeroData.ts,
      career = not OringHeroData and heroCfg.career or OringHeroData.career,
      company = not OringHeroData and heroCfg.camp or OringHeroData.company,
      skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(OringHeroData ~= nil and OringHeroData.skinId or 0, heroId)
    },
    vow = vowMsg
  })
  if OringHeroData ~= nil then
    local specWeaponDic = OringHeroData:GetHeroDataSpecWeaponAll()
    if specWeaponDic ~= nil then
      for k, weaponData in pairs(specWeaponDic) do
        heroData:BindHeroSpecWeapon(weaponData)
      end
      heroData:ReplaceHeroSkill()
    end
  end
  if isSkillFullLevel then
    for _, skillData in ipairs(heroData.skillList) do
      if skillData.skillCfg.open_star <= heroData.rank then
        skillData:UpdateSkill(skillData.skillCfg.lv)
      end
    end
  elseif customSkillLevelRange ~= nil then
    if OringHeroData ~= nil then
      for skillId, skillData in pairs(heroData.skillDic) do
        local newSkillId = OringHeroData:GetReplaceSkill(skillId)
        local OringSkillData
        if newSkillId ~= nil then
          OringSkillData = OringHeroData.skillDic[newSkillId]
        else
          OringSkillData = OringHeroData.skillDic[skillId]
        end
        if OringSkillData ~= nil then
          skillData:UpdateSkill(math.clamp(OringSkillData.level, customSkillLevelRange[1], customSkillLevelRange[2]))
        elseif isGameDev then
          error("skill limit is fail")
        end
      end
    else
      for _, skillData in ipairs(heroData.skillList) do
        if skillData.skillCfg.open_star <= heroData.rank then
          skillData:UpdateSkill(customSkillLevelRange[1])
        end
      end
    end
  elseif OringHeroData ~= nil then
    for skillId, OringSkillData in pairs(OringHeroData.skillDic) do
      if ConfigData.hero_skill[skillId].open_star <= heroData.rank then
        local skillData = heroData.skillDic[skillId]
        skillData:UpdateSkill(OringSkillData.level)
      end
    end
  end
  heroData.isRemoveAllBounce = isRemoveAllBounce
  return heroData
end

return SpecialRuleGenerator
