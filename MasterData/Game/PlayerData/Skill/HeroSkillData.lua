local HeroSkillData = class("HeroSkillData")
local cs_GameData_ins = CS.GameData.instance
local cs_FormulaUtility = CS.FormulaUtility

function HeroSkillData:ctor(dataId, heroData, skillCfg)
  self.dataId = dataId
  self.level = 0
  self.heroData = heroData
  local skillCfg = skillCfg or ConfigData.hero_skill[dataId]
  if skillCfg == nil then
    error("skill cfg is null,Id:" .. tostring(dataId))
    return
  end
  self.skillCfg = skillCfg
  self.type = skillCfg.type
  if self.type ~= eHeroSkillType.LifeSkill then
    self.battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(self.dataId)
    if self.battleSkillCfg == nil then
      error("battle_skill cfg is null,Id:" .. tostring(self.dataId))
    end
  else
    self.lifeSkillCfg = ConfigData.life_skill[self.dataId]
    if self.lifeSkillCfg == nil then
      error("life_skill cfg is null,Id:" .. tostring(self.dataId))
    end
  end
  self.labelDic = ConfigData.battle_skill.skill_label_Dic[self.dataId]
end

function HeroSkillData:UpdateSkill(level)
  self.level = level
end

function HeroSkillData:GetIsUnlock()
  return self.level > 0
end

function HeroSkillData:GetOpenStar()
  local rankCfg = ConfigData.hero_rank[self.skillCfg.open_star]
  if rankCfg == nil then
    error("Cant find rankCfg,rank = " .. tostring(self.skillCfg.open_star))
    return
  end
  return rankCfg.rare, rankCfg.star
end

function HeroSkillData:GetMaxLevel()
  return math.min(self.skillCfg.lv, ConfigData.hero_rank.maxSkillLevel)
end

function HeroSkillData:IsFullLevel()
  return self.level >= self:GetMaxLevel()
end

function HeroSkillData:GetNextLevelRankCfg()
  local nextLevel = self.level + 1
  for i = self.heroData.rank, ConfigData.hero_rank.maxRank do
    local rankCfg = ConfigData.hero_rank[i]
    if nextLevel <= rankCfg.skill_level_max then
      return rankCfg
    end
  end
  return 0
end

function HeroSkillData:IsSkillUnlockAdvance()
  local rank = self.heroData.rank
  local unlockAdvance = rank >= self.skillCfg.advanced_open_star
  return unlockAdvance
end

function HeroSkillData:GetIcon()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg.Icon
  else
    return self.lifeSkillCfg[self.level].icon
  end
end

function HeroSkillData:GetBattleSkillTypeColor()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg.TypeColor
  end
end

function HeroSkillData:GetName()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg.Name
  else
    return LanguageUtil.GetLocaleText(self.lifeSkillCfg[self.level].name)
  end
end

function HeroSkillData:GetSkillTag()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg.SkillTag
  end
end

function HeroSkillData:GetDescribe()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:GetDescribe()
  else
    return ""
  end
end

function HeroSkillData:GetSkillAdaptationSource()
  return self.skillCfg.skill_adaption
end

function HeroSkillData:GetLevelDescribe(level, unlockAdvance, showDetail)
  local isDetail = showDetail == nil or showDetail == true
  if self.type ~= eHeroSkillType.LifeSkill then
    if unlockAdvance == nil then
      unlockAdvance = self:IsSkillUnlockAdvance()
    end
    return self.battleSkillCfg:GetLevelDescribe(level, unlockAdvance, isDetail)
  else
    return LanguageUtil.GetLocaleText(self.lifeSkillCfg[self.level].describe)
  end
end

function HeroSkillData:GetCurLevelDescribe(unlockAdvance)
  local curLevel = math.max(self.level, 1)
  if self.type ~= eHeroSkillType.LifeSkill then
    if unlockAdvance == nil then
      unlockAdvance = self:IsSkillUnlockAdvance()
    end
    local showDetail = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.skill)
    return self:GetLevelDescribe(curLevel, unlockAdvance, showDetail)
  else
    return LanguageUtil.GetLocaleText(self.lifeSkillCfg[curLevel].describe)
  end
end

function HeroSkillData:Get2NewLevelDes(oldLevel, newLevel)
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:GetLevelUpDescribe(oldLevel, newLevel, ConfigData.buildinConfig.skillLevelUpSign, ConfigData.buildinConfig.skillLevelUpNumDesColor, ConfigData.buildinConfig.skillLevelUpNumDesColor, true)
  else
    return LanguageUtil.GetLocaleText(self.lifeSkillCfg[self.level].describe)
  end
end

function HeroSkillData:GetConsumeId()
  return self.skillCfg.consume_id
end

function HeroSkillData:GetSkillLevelCfg()
  local consumeId = self:GetConsumeId()
  local consumeCfg = ConfigData.hero_skill_level[consumeId]
  if consumeCfg == nil then
    error("hero skill level cfg is null,consumeId:" .. tostring(consumeId))
    return nil
  end
  local levelCfg = consumeCfg[self.level]
  return levelCfg
end

function HeroSkillData:IsUniqueSkill()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:IsUltSkill()
  else
    return false
  end
end

function HeroSkillData:IsCommonAttack()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:IsCommonAttack()
  else
    return false
  end
end

function HeroSkillData:IsPassiveSkill()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:IsPassiveSkill()
  else
    return false
  end
end

function HeroSkillData:IsNormalSkill()
  if self.type ~= eHeroSkillType.LifeSkill then
    return self.battleSkillCfg:IsNormalSkill()
  else
    return false
  end
end

function HeroSkillData:HaveSkillLabeId(level)
  if self.labelDic == nil then
    return false
  end
  local compareLv = 1
  compareLv = level == nil and self.level or level
  for id, unlockLevel in pairs(self.labelDic) do
    if unlockLevel <= compareLv then
      return true
    end
  end
  return false
end

function HeroSkillData:GetSkillLabeIdList(level)
  if self.labelDic == nil then
    return
  end
  local compareLv = 1
  compareLv = level == nil and self.level or level
  local tab = {}
  local labelList = ConfigData.battle_skill.skill_label_List[self.dataId]
  for index, id in ipairs(labelList) do
    if self.labelDic[id] ~= nil and compareLv >= self.labelDic[id] then
      table.insert(tab, id)
    end
  end
  return tab
end

function HeroSkillData:CanUpgrade()
  if not self:GetIsUnlock() or self:IsFullLevel() then
    return false
  end
  local needItemIds
  local isHaveEnoughItem = true
  local consume = self:GetSkillLevelCfg()
  for index, itemId in ipairs(consume.itemIdList) do
    local num = consume.countList[index]
    if num > PlayerDataCenter:GetItemCount(itemId) then
      if needItemIds == nil then
        needItemIds = {}
      end
      needItemIds[itemId] = true
    end
  end
  if needItemIds ~= nil then
    isHaveEnoughItem = false
  end
  local needRank = self:GetNextLevelRankCfg()
  local requireRare = needRank.rare
  local requireStar = needRank.star
  local rare = requireRare <= self.heroData.rare
  local star = requireStar <= self.heroData.star
  local notLimitLv = true
  if consume.level_limit ~= nil then
    notLimitLv = self.heroData.level >= consume.level_limit
  end
  return rare and star and isHaveEnoughItem and notLimitLv, rare, star, isHaveEnoughItem, notLimitLv, needItemIds
end

function HeroSkillData:GetLimitLevel()
  local consume = self:GetSkillLevelCfg()
  return consume.level_limit
end

function HeroSkillData:GetCurrentSkillCDTime()
  if self.type ~= eHeroSkillType.LifeSkill then
    return cs_FormulaUtility.CalculateSkillCd(self.dataId, self.level)
  end
  return 0
end

function HeroSkillData:GetStartSkillCDTime(roleRank)
  if self.type ~= eHeroSkillType.LifeSkill then
    return cs_FormulaUtility.CalculateSkillStartCdTime(self.dataId, roleRank)
  end
  return 0
end

function HeroSkillData:GetStartSkillCdUp(roleRank)
  if self.type ~= eHeroSkillType.LifeSkill then
    return cs_FormulaUtility.GetMeetAdvancedStar(self.dataId, roleRank)
  end
  return 0
end

function HeroSkillData:CopyHeroSkillNewId(skillId)
  local skill = HeroSkillData.New(skillId, self.heroData, self.skillCfg)
  skill:UpdateSkill(self.level)
  return skill
end

return HeroSkillData
