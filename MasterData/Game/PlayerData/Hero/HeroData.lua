local HeroData = class("HeroData")
local HeroSkillData = require("Game.PlayerData.Skill.HeroSkillData")
local attrIdOffset = ConfigData.buildinConfig.AttrIdOffset
local SkinEnum = require("Game.Skin.SkinEnum")
local VowEnum = require("Game.VowSystem.Data.VowEnum")
local HeroEnum = require("Game.PlayerData.Hero.HeroEnum")
local HeroVowData = require("Game.PlayerData.Hero.HeroVowData")

function HeroData:ctor(data)
  local baseData = data.basic
  self.dataId = baseData.id
  self.level = baseData.level
  self.curExp = baseData.exp
  self.ts = baseData.ts
  self.potential = baseData.potentialLvl or 0
  self.archive = baseData.archive
  self.audio = baseData.audioEx
  self.cat = baseData.cat
  self.questRecord = baseData.questRecord
  self.modelSpecSign = baseData.serverModel
  local heroCfg = ConfigData.hero_data[self.dataId]
  if heroCfg == nil then
    error("hero cfg is null,id:" .. tostring(self.dataId))
    return
  end
  self.heroCfg = heroCfg
  self.camp = heroCfg.camp
  self.career = heroCfg.career
  self.rank = baseData.star
  self:UpdateHeroRank(self.rank)
  data.__notHaveLegalSkin = false
  self:UpdateSkin(baseData.skinId)
  self:__UpdateBaseArriDic()
  self.skillDic = {}
  self.skillList = {}
  for k, skillId in ipairs(heroCfg.skill_list) do
    local skillData = HeroSkillData.New(skillId, self)
    self.skillDic[skillId] = skillData
    table.insert(self.skillList, skillData)
  end
  table.sort(self.skillList, function(skillData1, skillData2)
    local isCommonAttack1 = skillData1:IsCommonAttack()
    local isCommonAttack2 = skillData2:IsCommonAttack()
    local isPassive1 = skillData1:IsPassiveSkill()
    local isPassive2 = skillData2:IsPassiveSkill()
    local isUskill1 = skillData2:IsUniqueSkill()
    local isUskill2 = skillData2:IsUniqueSkill()
    if isCommonAttack1 == isCommonAttack2 then
      if isPassive1 == isPassive2 then
        if isUskill1 == isUskill2 then
          if skillData1.type == skillData2.type then
            return skillData1.dataId < skillData2.dataId
          else
            return skillData1.type < skillData2.type
          end
        else
          return not isUskill1
        end
      else
        return isPassive1
      end
    else
      return isCommonAttack1
    end
  end)
  self.fragId = heroCfg.fragment
  self.__isFavouriteHero = baseData.subscribeDungeon
  if data.spWeapon ~= nil then
    for i, spWeapon in ipairs(data.spWeapon) do
      PlayerDataCenter.allSpecWeaponData:CreateOrUpdateHeroWeapon(self, spWeapon.id, spWeapon.step, spWeapon.level)
    end
  end
  self:ReplaceHeroSkill()
  if data.skill ~= nil then
    for skillId, skillLevel in pairs(data.skill.data) do
      local skillData = self.skillDic[skillId]
      if skillData ~= nil then
        skillData:UpdateSkill(skillLevel)
      end
    end
  end
  self.vow = HeroVowData.CreateVowData(data.vow)
  self.vowName = baseData.name
end

function HeroData:UpdateHeroData(data)
  local baseData = data.basic
  if baseData ~= nil then
    local attrChange = baseData.level ~= self.level or self.rank ~= baseData.star or self.potential ~= baseData.potentialLvl
    self.level = baseData.level
    self.curExp = baseData.exp or self.curExp
    self.rank = baseData.star or self.rank
    self:UpdateHeroRank(self.rank)
    self.ts = baseData.ts or self.ts
    self.potential = baseData.potentialLvl or 0
    self.archive = baseData.archive or self.archive
    self.audio = baseData.audioEx or self.audio
    self.questRecord = baseData.questRecord
    if baseData.skinId ~= nil then
      self:UpdateSkin(baseData.skinId)
    end
    if attrChange then
      self:__UpdateBaseArriDic()
    end
    self.__isFavouriteHero = baseData.subscribeDungeon
  end
  if data.spWeapon ~= nil then
    for i, spWeapon in ipairs(data.spWeapon) do
      PlayerDataCenter.allSpecWeaponData:CreateOrUpdateHeroWeapon(self, spWeapon.id, spWeapon.step, spWeapon.level)
    end
  end
  self:ReplaceHeroSkill()
  if data.skill ~= nil then
    for skillId, skillLevel in pairs(data.skill.data) do
      local skillData = self.skillDic[skillId]
      if skillData ~= nil then
        skillData:UpdateSkill(skillLevel)
      end
    end
  end
end

function HeroData:UpdateSkin(skinId)
  if skinId == nil then
    skinId = self.heroCfg.default_skin
    self.__notHaveLegalSkin = true
  elseif skinId == 1 or skinId == 0 then
    skinId = self.heroCfg.default_skin
  end
  local oldSkinId = self.skinId
  self.skinId = skinId
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resCfg = skinCtr:GetResModel(self.dataId, self.skinId)
end

function HeroData:GetHeroIsNotHaveLegalSkin()
  return self.__notHaveLegalSkin
end

function HeroData:GetAttr(attrId, withoutAth, dontWarning, onlyBaseAttr, fairyData)
  local athHeroId = self.dataId
  if withoutAth then
    athHeroId = nil
  end
  if self.isRemoveAllBounce then
    dontWarning = true
    athHeroId = nil
  end
  local fairyAttrDic
  if fairyData ~= nil then
    fairyAttrDic = fairyData:GetFairyAttrAdd()
  end
  local atrValue = 0
  atrValue = self:__CalBaseAttr(attrId, withoutAth, athHeroId, fairyAttrDic)
  if onlyBaseAttr then
    return atrValue
  end
  atrValue = self:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId, nil, nil, fairyAttrDic)
  atrValue = self:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId, fairyAttrDic)
  if isGameDev and not dontWarning and not withoutAth then
    PlayerDataCenter.heroAttrChecker:DirtyPlayerHeroAttri(self.dataId, attrId, atrValue)
  end
  return atrValue
end

function HeroData:__CalBaseAttr(attrId, withoutAth, athHeroId, fairyAttrDic)
  local baseAttrId = attrId + attrIdOffset
  local atrValue = self.baseAttrDic[attrId]
  if self._talentData ~= nil then
    atrValue = atrValue + self._talentData:GetAttributeAddtion(baseAttrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      atrValue = atrValue + v:GetSpecWeaponAttriAddtionById(baseAttrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[baseAttrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[baseAttrId]
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, baseAttrId, self.camp, self.career, athHeroId)
end

function HeroData:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId, extrValue, onlyExtraValue, fairyAttrDic)
  local ratioAttrId = attrId + attrIdOffset * 2
  local heroStarExtraValue = self.heroStarCfg.atrExtraDic[ratioAttrId] or 0
  if self.potentialCfg ~= nil and self.potentialCfg.extra[ratioAttrId] ~= nil then
    local temp = self.potentialCfg.extra[ratioAttrId] or 0
    heroStarExtraValue = heroStarExtraValue + temp
  end
  if self._talentData ~= nil then
    heroStarExtraValue = heroStarExtraValue + self._talentData:GetAttributeAddtion(ratioAttrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      heroStarExtraValue = heroStarExtraValue + v:GetSpecWeaponAttriAddtionById(ratioAttrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[ratioAttrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[ratioAttrId]
  end
  if extrValue ~= nil then
    heroStarExtraValue = heroStarExtraValue + extrValue
  end
  if onlyExtraValue ~= nil then
    heroStarExtraValue = onlyExtraValue
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, ratioAttrId, self.camp, self.career, athHeroId, heroStarExtraValue)
end

function HeroData:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId, fairyAttrDic)
  local heroStarExtraValue = self.heroStarCfg.atrExtraDic[attrId] or 0
  if self.potentialCfg ~= nil and self.potentialCfg.extra[attrId] ~= nil then
    local temp = self.potentialCfg.extra[attrId] or 0
    heroStarExtraValue = heroStarExtraValue + temp
  end
  if self._talentData ~= nil then
    atrValue = atrValue + self._talentData:GetAttributeAddtion(attrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      atrValue = atrValue + v:GetSpecWeaponAttriAddtionById(attrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[attrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[attrId]
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, attrId, self.camp, self.career, athHeroId, heroStarExtraValue)
end

function HeroData:GetNewLevelAttr(attrId, newLevel, newRank, newPotential)
  self:__UpdateBaseArriDic(newLevel, newRank, newPotential)
  local answer = self:GetAttr(attrId, nil, true)
  self:__UpdateBaseArriDic()
  return answer
end

function HeroData:__UpdateBaseArriDic(newLevel, newRank, newPotential)
  local rank = newRank or self.rank
  local level = newLevel or self.level
  local potential = newPotential or self.potential
  local baseAttrDic = setmetatable({}, {
    __index = function(tab, key)
      return 0
    end
  })
  self.baseAttrDic = baseAttrDic
  if ConfigData.hero_star[self.dataId] == nil or ConfigData.hero_star[self.dataId][self.rank] == nil then
    error(string.format("Can't get heroStarCfg, heroId = %s,rank = %s", self.dataId, self.rank))
    return
  end
  local heroStarCfg = ConfigData.hero_star[self.dataId][rank]
  self.heroStarCfg = heroStarCfg
  local heroLevelCfg = ConfigData.hero_level[level]
  if heroLevelCfg == nil then
    error("Can't find heroLevelCfg, level = " .. tostring(self.level))
    return
  end
  for k, v in pairs(heroStarCfg.atrGrowthDic) do
    baseAttrDic[k - 100] = v * heroLevelCfg.level_growth // 1000000 + (heroStarCfg.atrExtraDic[k] or 0)
  end
  for k, v in pairs(heroStarCfg.atrBaseDic) do
    local id = k - 100
    baseAttrDic[id] = baseAttrDic[id] + v
  end
  local potentialCfg = ConfigData.hero_potential[self.dataId][potential]
  self.potentialCfg = potentialCfg
  if potentialCfg ~= nil then
    for k, v in pairs(potentialCfg.atrDic) do
      local id = k - attrIdOffset
      baseAttrDic[id] = baseAttrDic[id] + v
    end
  end
  baseAttrDic[8] = self.heroCfg.move_spd
  baseAttrDic[16] = self.heroCfg.range
end

function HeroData:GetName()
  return LanguageUtil.GetLocaleText(self.heroCfg.name)
end

function HeroData:GetCurrentUseSkinId()
  return self.skinId
end

function HeroData:GetResPicName(isDefault)
  if isDefault then
    return self.resCfg.res_Name
  end
  return self.resCfg.src_id_pic or self.resCfg.res_Name
end

function HeroData:GetResModelName(isDefault)
  if isDefault then
    return self.resCfg.res_Name
  end
  return self.resCfg.src_id_model or self.resCfg.res_Name
end

function HeroData:GetExtendResName()
  return self.resCfg.extend_res
end

function HeroData:GetEnName()
  return LanguageUtil.GetLocaleText(self.heroCfg.name_en)
end

function HeroData:GetHeroTag()
  return self.heroCfg.tag
end

function HeroData:GetHeroDefaultRank()
  return self.heroCfg.rank
end

function HeroData:GetIsCouldMerge()
  if self:IsHeroNotMergeable() then
    return false, 0, 0
  end
  local fragId = self.fragId
  local curFrage = PlayerDataCenter:GetItemCount(fragId)
  local mergeCfg = ConfigData.hero_merge[self:GetHeroDefaultRank()]
  if mergeCfg == nil then
    error("can't get merge cfg for hero:" .. tostring(self.heroData.dataId) .. " defaultRank:" .. tostring(self.heroData:GetHeroDefaultRank()))
    return false, curFrage, "?"
  end
  local mergeNeedFrage = mergeCfg.frag_merge
  local couldMerge = curFrage >= mergeNeedFrage
  return couldMerge, curFrage, mergeNeedFrage
end

function HeroData:IsHeroNotMergeable()
  return self.heroCfg.not_mergeable
end

function HeroData:GetCareerCfg()
  local careerCfg = ConfigData.career[self.career]
  return careerCfg
end

function HeroData:GetCampCfg()
  local campCfg = ConfigData.camp[self.camp]
  return campCfg
end

function HeroData:GetDormMoveSpeed()
  return self.heroCfg.dorm_move_spd
end

function HeroData:GetHeroFragCount()
  return PlayerDataCenter:GetItemCount(self.heroCfg.fragment)
end

function HeroData:IsFullRank()
  return self.rank >= ConfigData.hero_rank.maxRank
end

function HeroData:UpdateHeroRank(rank)
  local rankCfg = ConfigData.hero_rank[rank]
  if rankCfg == nil then
    error("Can't find rankCfg, id = " .. tostring(rank))
    return
  end
  self.rankCfg = rankCfg
  self.star = rankCfg.star
  self.rare = rankCfg.rare
end

function HeroData:StarNeedFrag()
  if self:IsFullRank() then
    return 0
  end
  return self.rankCfg.upgrade_star_frag_cost
end

function HeroData:StarNeedCurrencyNum()
  if self:IsFullRank() then
    return 0
  end
  local extra_cost = self.rankCfg.upgrade_star_extra_cost
  if extra_cost[1] ~= nil then
    return extra_cost[1].itemId, extra_cost[1].num
  end
end

function HeroData:StarNeedItemNum()
  if self:IsFullRank() then
    return 0
  end
  local extra_cost = self.rankCfg.upgrade_star_extra_cost
  if extra_cost[2] ~= nil then
    return extra_cost[2].itemId, extra_cost[2].num
  end
end

function HeroData:AbleUpLevel()
  if self:IsFullLevel() or self:IsReachLevelLimit() then
    return false
  end
  return PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp) > 0
end

function HeroData:AbleUpgradeStar()
  if self:IsFullRank() then
    return false
  end
  local id, num
  local fitFrag = self:GetHeroFragCount() >= self:StarNeedFrag()
  local fitCurrency, fitItem
  id, num = self:StarNeedCurrencyNum()
  if id ~= nil then
    fitCurrency = num <= PlayerDataCenter:GetItemCount(id)
  else
    fitCurrency = true
  end
  id, num = self:StarNeedItemNum()
  if id ~= nil then
    fitItem = num <= PlayerDataCenter:GetItemCount(id)
  else
    fitItem = true
  end
  return fitFrag and fitCurrency and fitItem, fitFrag, fitCurrency, fitItem
end

function HeroData:IsHalfStar()
  return self.star % 2 == 1
end

function HeroData:AbleUpgrade2FullStar()
  if self:AbleUpgradeStar() then
    return self:IsHalfStar(), true
  end
  return false, false
end

function HeroData:GetDifferAttrWhenRankUp(newRank, newLevel, oldRank, oldLevel, newPotential, oldPotential)
  local changeList = {}
  for _, attrId in pairs(ConfigData.attribute.baseAttrIds) do
    local oldAttr
    if oldLevel ~= nil or oldRank ~= nil or oldPotential ~= nil then
      oldAttr = self:GetNewLevelAttr(attrId, oldLevel, oldRank, oldPotential)
    else
      oldAttr = self:GetAttr(attrId, nil, true)
    end
    local newAttr = self:GetNewLevelAttr(attrId, newLevel, newRank, newPotential)
    if oldAttr ~= newAttr then
      table.insert(changeList, {
        attrId = attrId,
        property = ConfigData.attribute[attrId].attribute_priority,
        oldAttr = oldAttr,
        newAttr = newAttr
      })
    end
  end
  return changeList
end

function HeroData:GenHeroCanQuickLevelUp()
  if self:IsReachLevelLimit() or self:IsFullLevel() then
    return false
  end
  local remainExp = ConfigData.hero_level[self.level].exp
  if remainExp <= PlayerDataCenter:GetItemCount(ConstGlobalItem.HeroExp) then
    return true, {
      [ConstGlobalItem.HeroExp] = remainExp
    }
  end
  return false
end

function HeroData:IsFullLevel()
  return self.level >= self:GetHeroMaxLevel()
end

function HeroData:GetLevelLimit()
  return ConfigData.hero_potential[self.dataId][self.potential].level_max
end

function HeroData:IsReachLevelLimit()
  return self.level >= self:GetLevelLimit()
end

function HeroData:GetExpRatio()
  local totalExp = self:GetLevelTotalExp()
  if totalExp == 0 then
    return 0
  end
  return self.curExp / totalExp
end

function HeroData:GetExpByLevel(level)
  local levelCfg = ConfigData.hero_level[level]
  if levelCfg ~= nil then
    return levelCfg.exp
  end
  return 0
end

function HeroData:GetLevelTotalExp()
  return self:GetExpByLevel(self.level)
end

function HeroData:GetUpgradeLevelProcess(oldLevel, oldExp, getExp)
  local fromlist = {}
  local tolist = {}
  if getExp <= 0 then
    return fromlist, tolist
  end
  getExp = getExp + oldExp
  local heroMaxLevel = self:GetHeroMaxLevel()
  for i = oldLevel, heroMaxLevel - 1 do
    local levelCfg = ConfigData.hero_level[i]
    if levelCfg == nil then
      error("hero level cfg is null,id:" .. tostring(i))
      break
    end
    local curLevelTotalExp = levelCfg.exp
    if i == oldLevel then
      table.insert(fromlist, oldExp)
    else
      table.insert(fromlist, 0)
    end
    if i == self:GetLevelLimit() then
      table.insert(tolist, getExp)
      break
    end
    if getExp < curLevelTotalExp then
      table.insert(tolist, getExp)
      break
    elseif getExp == curLevelTotalExp then
      table.insert(tolist, curLevelTotalExp)
      if i < self:GetLevelLimit() then
        table.insert(fromlist, 0)
        table.insert(tolist, 0)
      end
      break
    else
      getExp = getExp - curLevelTotalExp
      table.insert(tolist, curLevelTotalExp)
      if i + 1 == heroMaxLevel then
        table.insert(fromlist, 0)
        table.insert(tolist, 0)
        break
      end
    end
  end
  return fromlist, tolist
end

function HeroData:AddTestExp(exp)
  local nextExp = 0
  local nextTotalExp = self:GetLevelTotalExp()
  local overflowExp = 0
  local testExp = exp + self.curExp
  local testLevel = self.level
  local heroMaxLevel = self:GetHeroMaxLevel()
  for i = self.level, heroMaxLevel - 1 do
    local levelCfg = ConfigData.hero_level[i]
    if levelCfg == nil then
      error("hero level cfg is null,level:" .. tostring(i))
      return testLevel, nextExp, nextTotalExp, overflowExp
    end
    nextTotalExp = levelCfg.exp
    if testExp < levelCfg.exp then
      break
    end
    testExp = testExp - levelCfg.exp
    testLevel = i + 1
  end
  if testLevel == heroMaxLevel then
    nextExp = 0
    overflowExp = testExp
  else
    nextExp = testExp
    overflowExp = 0
  end
  return testLevel, nextExp, nextTotalExp, overflowExp
end

function HeroData:GetExp2FullLevel()
  if self:IsFullLevel() then
    return 0
  else
    local totalCouldAddExp = -self.curExp
    for i = self.level, self:GetHeroMaxLevel() do
      totalCouldAddExp = totalCouldAddExp + ConfigData.hero_level[i].exp
    end
    return totalCouldAddExp
  end
end

function HeroData:GetExp2LimitLevel()
  local total = -self.curExp
  for i = self.level, self:GetLevelLimit() do
    total = total + ConfigData.hero_level[i].exp
  end
  return 0 < total and total or 0
end

function HeroData:GetExpToTargetLevel(targetLevel)
  local total = -self.curExp
  for i = self.level, targetLevel do
    total = total + ConfigData.hero_level[i].exp
  end
  return 0 < total and total or 0
end

function HeroData:GetHeroExpAddFromLevel(fromLevel, fromExp)
  if fromLevel == self.level then
    return self.curExp - fromExp
  end
  local needExp = 0
  for i = fromLevel, self.level do
    local levelCfg = ConfigData.hero_level[i]
    if levelCfg == nil then
      error("hero level cfg is null,level:" .. tostring(i))
      return 0
    end
    if i == fromLevel then
      needExp = needExp + levelCfg.exp - fromExp
    elseif i == self.level then
      needExp = needExp + self.curExp
    else
      needExp = needExp + levelCfg.exp
    end
  end
  return needExp
end

function HeroData:GetHeroAthSuitRecommendDic()
  return self.heroCfg.recommendSuitDic, self.heroCfg.recommendAredSuitDic
end

function HeroData:GetAthSlotList(fullSpace, specificRank, specialPotential, specialLevel)
  local athslotList = {}
  local level = specialLevel or self.level
  local rank = specificRank or self.rank
  local athSlotLevel = PlayerDataCenter.allAthData:GetHeroAthSlotInfo(self.dataId)
  local potentialLevel = specialPotential or self.potential
  local talentAlgorithmSpaceDic = self._talentData ~= nil and self._talentData:GetAlgorithmSpace() or nil
  if fullSpace then
    level = self:GetHeroMaxLevel()
    rank = ConfigData.hero_rank.maxRank
    athSlotLevel = ConfigData.ath_efficiency.maxLevel
    potentialLevel = self:GetMaxPotential()
    talentAlgorithmSpaceDic = ConfigData.hero_talent.maxAlgSpaceDic[self.dataId]
  end
  local baseSpaceCfg = self.heroCfg.algorithm_space
  local levelSpaceCfg = ConfigData.hero_level[level].algorithm_space
  local starSpaceCfg = ConfigData.hero_star[self.dataId][rank].algorithm_space
  local athEfccSpaceCfg = ConfigData.ath_efficiency[athSlotLevel].algorithm_space
  local potentialCfg = ConfigData.hero_potential[self.dataId][potentialLevel].algorithm_space
  if #baseSpaceCfg ~= #starSpaceCfg or #baseSpaceCfg ~= #levelSpaceCfg or #baseSpaceCfg ~= #athEfccSpaceCfg then
    error("Hero algorithm_space Config error, heroId = " .. tostring(self.dataId))
    return athslotList
  end
  if ConfigData.game_config.athSlotCount < #baseSpaceCfg then
    error("Hero algorithm_space Config error, heroId = " .. tostring(self.dataId))
    return athslotList
  end
  for k, v in ipairs(baseSpaceCfg) do
    local space = v + levelSpaceCfg[k] + starSpaceCfg[k] + athEfccSpaceCfg[k] + potentialCfg[k]
    if talentAlgorithmSpaceDic ~= nil then
      space = space + (talentAlgorithmSpaceDic[k] or 0)
    end
    athslotList[k] = space
  end
  return athslotList
end

function HeroData:AbleUpgradeSkill()
  for _, skillData in ipairs(self.skillList) do
    if not skillData:IsUniqueSkill() and skillData:CanUpgrade() then
      return true
    end
  end
  return false
end

function HeroData:AblePotential()
  if self:IsFullPotential() then
    return false
  end
  local potentialCfg = ConfigData.hero_potential[self.dataId][self.potential]
  if potentialCfg == nil then
    return false
  end
  if self.level < potentialCfg.level_max then
    return false
  end
  for k, v in pairs(potentialCfg.cost) do
    local itemData = PlayerDataCenter.itemDic[k]
    if itemData == nil or v > itemData:GetCount() then
      return false
    end
  end
  return true
end

function HeroData:CanHeroUsePotential()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Potential) then
    return false
  end
  if not self:IsReachLevelLimit() then
    return false
  end
  return self:AblePotential()
end

function HeroData:IsFullPotential()
  return self.potential >= self:GetMaxPotential()
end

function HeroData:GetHeroPotential()
  return self.potential
end

function HeroData:GetMaxPotential(without6)
  local potentialMaxNum
  if FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_potential_2_70) and not without6 then
    potentialMaxNum = 6
  else
    potentialMaxNum = 5
  end
  return math.min(table.count(ConfigData.hero_potential[self.dataId]) - 1, potentialMaxNum)
end

function HeroData:IsHeroLongTrailLevel()
  return self.level >= ConfigData.buildinConfig.HeroLongTailLevel
end

function HeroData:GetHeroMaxLevel()
  local hero_max_potentialCfg = ConfigData.hero_potential[self.dataId][self:GetMaxPotential()]
  if hero_max_potentialCfg == nil then
    return ConfigData.game_config.heroMaxLevel
  end
  return hero_max_potentialCfg.level_max
end

function HeroData:GetHeroPotentialByLevel(level)
  local potential_level = self.potential
  local heroAllPotentialCfg = ConfigData.hero_potential[self.dataId]
  for _, cfg in pairs(heroAllPotentialCfg) do
    if level <= cfg.level_max then
      potential_level = cfg.potential_level
      break
    end
  end
  return potential_level
end

function HeroData:GetFormulaAttr(attrId)
  if attrId == eHeroAttr.hp then
    local maxHp = self:GetRealAttr(eHeroAttr.maxHp)
    return maxHp
  elseif attrId == eHeroAttr.attack_range then
    return self.attackRange
  else
    return self:GetAttr(attrId, true)
  end
end

function HeroData:GetSkillFightingPower(heroPower)
  local fightingPower = 0
  for k, skill in pairs(self.skillDic) do
    local battleCfg = ConfigData.battle_skill[skill.dataId]
    if skill.type ~= eHeroSkillType.LifeSkill and skill:GetIsUnlock() and battleCfg ~= nil and battleCfg.skill_comat ~= "" then
      fightingPower = PlayerDataCenter:GetBattleSkillFightPower(skill.dataId, skill.level, heroPower) + fightingPower
    end
  end
  return fightingPower
end

function HeroData:GetFightingPower(attrDic, fairyData)
  if attrDic == nil then
    attrDic = self:GetFightHeroAttrDic(fairyData)
  end
  local heroPower = ConfigData.GetFormulaValue(eFormulaType.Hero, attrDic)
  local skillPower = self:GetSkillFightingPower(heroPower)
  local totalPower = heroPower + skillPower
  totalPower = math.floor(totalPower)
  if self._talentData ~= nil then
    totalPower = totalPower + self._talentData:GetHeroTalentFixedComat()
  end
  self.__cachedPower = totalPower
  return totalPower
end

function HeroData:TryGetCachedPower()
  return self.__cachedPower or self:GetFightingPower()
end

function HeroData:GetFightHeroAttrDic(fairyData)
  local attrDic = table.GetDefaulValueTable(0)
  for i = 1, ConfigData.attribute.maxPropertyId - 1 do
    attrDic[i] = self:GetAttr(i, nil, true, nil, fairyData)
  end
  return attrDic
end

function HeroData:GetUltimateSkillLevel()
  return ConfigData.hero_rank[self.rank].ultimateskill_level
end

function HeroData:GetMaxNeedFragNum(isMinusBackpack)
  local num = 0
  for i = self.rank, ConfigData.hero_rank.maxRank - 1 do
    num = num + ConfigData.hero_rank[i].upgrade_star_frag_cost
  end
  if PlayerDataCenter.allSpecWeaponData:IsUnlockSpecWeaponSystem() then
    local heroMapping = ConfigData.spec_weapon_basic_config.heroWeaponMapping
    local weaponList = heroMapping[self.dataId]
    if weaponList ~= nil then
      for _, weaponId in ipairs(weaponList) do
        local weapon = self._specWeaponDic ~= nil and self._specWeaponDic[weaponId] or nil
        if weapon ~= nil then
          num = num + weapon:GetSpecWeaponHeroFragCount()
        else
          local weaponBasicCfg = ConfigData.spec_weapon_basic_config[weaponId]
          num = num + weaponBasicCfg.fragTotal
        end
      end
    end
  end
  if isMinusBackpack then
    return num - PlayerDataCenter:GetItemCount(self.fragId)
  else
    return num
  end
end

function HeroData:IsCouldFragConvert()
  if not self:IsFullRank() then
    return false
  end
  local weaponList = ConfigData.spec_weapon_basic_config.heroWeaponMapping[self.dataId]
  local isSpecFullLevel = true
  local converDic
  if weaponList ~= nil then
    for _, weaponId in ipairs(weaponList) do
      converDic = ConfigData.spec_weapon_basic_config[weaponId].fragment_redeem
      if table.IsEmptyTable(converDic) then
        return false
      end
      local weapon = self._specWeaponDic ~= nil and self._specWeaponDic[weaponId] or nil
      if weapon == nil or not weapon:IsSpecWeaponFullLevel() then
        isSpecFullLevel = false
      end
    end
  else
    return false
  end
  if PlayerDataCenter:GetItemCount(self.fragId) <= 0 then
    return false
  end
  return true, isSpecFullLevel, converDic
end

function HeroData:GetHeroFragId()
  return self.fragId
end

function HeroData:IsHaveCompletedHeroTask()
  local beginLevel = 10
  local heroTaskIds = ConfigData.training_task[self.dataId]
  for index, task in ipairs(heroTaskIds) do
    if task.param <= self.level and not self:HasGetQuestReward(task.indx) then
      return true
    end
  end
  return false
end

function HeroData:GetHeroArchiveInfo()
  local birthday = LanguageUtil.GetLocaleText(self.heroCfg.birthday)
  local model = LanguageUtil.GetLocaleText(self.heroCfg.model)
  local cv = LanguageUtil.GetLocaleText(self.heroCfg.cv)
  local archives_career = LanguageUtil.GetLocaleText(self.heroCfg.archives_career)
  return birthday, model, cv, archives_career
end

function HeroData:IsArchiveUnlocked(archiveId)
  if self.archive == nil then
    return false
  end
  return self.archive & 1 << archiveId > 0
end

function HeroData:HasGetQuestReward(questId)
  if self.questRecord == nil then
    return false
  end
  return self.questRecord & 1 << questId > 0
end

function HeroData:SetQuestGeted(questId)
  if self.questRecord == nil then
    self.questRecord = 0
  end
  self.questRecord = self.questRecord | 1 << questId
end

function HeroData:SetArchiveUnlocked(archiveId)
  if self.archive == nil then
    self.archive = 0
  end
  self.archive = self.archive | 1 << archiveId
end

function HeroData:BindHeroDataTalent(talentData)
  self._talentData = talentData
end

function HeroData:GetHeroDataTalent()
  return self._talentData
end

function HeroData:IsActivateSpecWeapon()
  if self._specWeaponDic == nil then
    return false
  end
  local isHasSpecWeaponData = PlayerDataCenter.allSpecWeaponData:ContainHeroSpecWeapon(self.dataId)
  if not isHasSpecWeaponData then
    return false
  end
  for weaponId, specWeaponData in pairs(self._specWeaponDic) do
    if specWeaponData ~= nil then
      local specWeaponCurStep = specWeaponData:GetSpecWeaponCurStep()
      if specWeaponCurStep ~= nil and 0 < specWeaponCurStep then
        return true
      end
    end
  end
  return false
end

function HeroData:BindHeroSpecWeapon(specWeaponData)
  if self._specWeaponDic == nil then
    self._specWeaponDic = {}
  end
  self._specWeaponDic[specWeaponData:GetSpecWeaponId()] = specWeaponData
end

function HeroData:GetHeroDataSpecWeapon(weaponId)
  if self._specWeaponDic == nil then
    return nil
  end
  return self._specWeaponDic[weaponId]
end

function HeroData:GetHeroDataSpecWeaponAll()
  return self._specWeaponDic
end

function HeroData:GetSpecWeaponData()
  local heroId = self.dataId
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(heroId)
  if not weaponId then
    return nil, nil
  end
  local weaponData = self:GetHeroDataSpecWeapon(weaponId)
  return weaponId, weaponData
end

function HeroData:ReplaceHeroSkill()
  if self._specWeaponDic == nil then
    return
  end
  local newReplaceDic = {}
  for k, v in pairs(self._specWeaponDic) do
    local specWeaponReplaceDic = v:GetSpecWeaponReplaceSkillDic()
    if specWeaponReplaceDic ~= nil then
      table.merge(newReplaceDic, specWeaponReplaceDic)
    end
  end
  for oriSkillId, newSkillId in pairs(newReplaceDic) do
    if self.skillDic[newSkillId] == nil then
      local lastSkillId = oriSkillId
      if self._replaceSkillDic ~= nil then
        lastSkillId = self._replaceSkillDic[oriSkillId] or oriSkillId
      end
      local index = table.indexof(self.skillList, self.skillDic[lastSkillId])
      if index then
        local newSkillData = HeroSkillData.New(newSkillId, self)
        self.skillList[index] = newSkillData
        self.skillDic[lastSkillId] = nil
        self.skillDic[newSkillId] = newSkillData
      elseif isGameDev then
        error("replace skill is ERROR")
      end
    end
  end
  self._replaceSkillDic = newReplaceDic
end

function HeroData:IsHaveCouldGetRewardArchive()
  local friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.dataId)
  local friendship_awardCfg = ConfigData.friendship_award[self.dataId]
  if friendship_awardCfg == nil then
    error("hero " .. tostring(self.dataId) .. "not have friendship_awardCfg")
    return
  end
  local friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.dataId)
  for fsLevel, cfg in pairs(friendship_awardCfg) do
    local state
    if not self:IsArchiveUnlocked(cfg.friendship_level) and fsLevel <= friendShipLevel then
      return true
    end
  end
  return false
end

function HeroData:IsAudioListed(audioId)
  if self.audio == nil then
    return false
  end
  local pos = math.floor(audioId / 32) + 1
  local newAudioId = audioId % 32
  return self.audio[pos] and self.audio[pos] & 1 << newAudioId > 0
end

function HeroData:SetAudioListed(audioId)
  if self.audio == nil then
    self.audio = {}
  end
  local pos = math.floor(audioId / 32) + 1
  local newAudioId = audioId % 32
  if 1 <= pos then
    for i = 1, pos do
      if self.audio[i] == nil then
        self.audio[i] = 0
      end
    end
  end
  self.audio[pos] = self.audio[pos] | 1 << newAudioId
end

function HeroData:GetRepeatExtraItemList()
  local ids = self.rankCfg.repeat_extra_trans_id
  local nums = self.rankCfg.repeat_extra_trans_num
  local itemList = {}
  for k, id in ipairs(ids) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(id))
    else
      table.insert(itemList, {
        itemCfg = itemCfg,
        num = nums[k]
      })
    end
  end
  return itemList
end

function HeroData:GetRepeatFragTrans()
  local itemCfg = ConfigData.item[self.fragId]
  local num = self.rankCfg.repeat_frag_trans
  return itemCfg, num
end

function HeroData:IsHeroRecommendAttr(attrId)
  return self.heroCfg.attribute_recommend[attrId] == true
end

function HeroData:SetIsFavouriteHero(bool)
  self.__isFavouriteHero = bool
end

function HeroData:IsFavouriteHero()
  return self.__isFavouriteHero
end

function HeroData:GetIsNotShowInfo()
  return self.heroCfg.lock_heroinfo
end

function HeroData:GetHeroHeadResName()
  local resName
  if (self.skinId or 0) ~= 0 then
    local skinCfg = ConfigData.skin[self.skinId]
    if skinCfg ~= nil and not string.IsNullOrEmpty(skinCfg.src_id_icon) then
      resName = skinCfg.src_id_icon
    end
  end
  if string.IsNullOrEmpty(resName) and self.heroCfg.fragment ~= nil then
    local itemCfg = ConfigData.item[self.heroCfg.fragment]
    if itemCfg ~= nil then
      resName = itemCfg.icon
    end
  end
  return resName
end

function HeroData:GetVowCfg()
  return ConfigData.hero_vow_reward[self.dataId]
end

function HeroData:GetHeroVowState()
  if self:GetVowCfg() == nil then
    return VowEnum.EVowState.NoData
  end
  if self:GetHeroVowTime() > 0 then
    return VowEnum.EVowState.Vowed
  end
  if PlayerDataCenter.allFriendshipData:GetLevel(self.dataId) >= self:GetVowCfg().open_friendship_level then
    return VowEnum.EVowState.CanVow
  end
  return VowEnum.EVowState.CanNotVow
end

function HeroData:GetHeroVowTime()
  return self.vow.vowTime
end

function HeroData:GetIsSetVowCard()
  return not table.IsEmptyTable(self:GetVowSignData())
end

function HeroData:GetVowSignData()
  return self.vow.sign
end

function HeroData:GetVowNextChangeNameTime()
  if self.vow == nil then
    return 0
  end
  return self.vow.nextModifyNameTm
end

function HeroData:SetHeroVowTime(vowTime)
  self.vow.vowTime = vowTime
  MsgCenter:Broadcast(eMsgEventId.UpdateHeroVow, self.dataId)
end

function HeroData:SetHeroSignData(signData)
  self.vow.sign = signData
  MsgCenter:Broadcast(eMsgEventId.UpdateHeroVow, self.dataId)
end

function HeroData:SetHeroVowName(name)
  self.vow.name = name
  local nextTime = PlayerDataCenter.timestamp + 2592000
  self.vow.nextModifyNameTm = nextTime
  MsgCenter:Broadcast(eMsgEventId.UpdateHeroVow, self.dataId)
end

function HeroData:GetReplaceSkill(oriSkill)
  if self._replaceSkillDic == nil then
    return nil
  end
  return self._replaceSkillDic[oriSkill]
end

function HeroData:GetHeroSkill(skillId)
  return self.skillDic[skillId]
end

function HeroData:GetSkinResFromWhere()
  return SkinEnum.fromWhere.heroInfoAndHandbook
end

function HeroData:SetHeroOverrideName(name)
  self._overrideName = name
end

function HeroData:GetHeroName(isShowVowName)
  if not string.IsNullOrEmpty(self._overrideName) then
    return self._overrideName
  end
  if not string.IsNullOrEmpty(self.vowName) then
    return self.vowName
  end
  if not isShowVowName or self.vow == nil or string.IsNullOrEmpty(self.vow.name) then
    return LanguageUtil.GetLocaleText(self.heroCfg.name)
  end
  return self.vow.name
end

function HeroData:GetVowChangedName()
  if self.vow == nil then
    return nil
  end
  return self.vow.name
end

function HeroData:GetHeroIsVowed()
  return self:GetHeroVowState() == VowEnum.EVowState.Vowed
end

function HeroData:GetHeroFriendLevel()
  local isOff = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetNoticeSwitchOff()[HeroEnum.HomeSideInfoType]
  if isOff then
    return HeroEnum.StateTip.NoTip
  end
  local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass, true)
  local lastTime = timePassCtrl:GetLogicTodayPassTimeStamp() - 86400
  local needTime = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroFriendLevelTipTime(self.dataId)
  local isTimeSure = lastTime > needTime
  local index = HeroEnum.StateTip.NoTip
  local level = isTimeSure and 0 or PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):GetHeroFriendLevelTip(self.dataId)
  local isNotMerger = self:IsHeroNotMergeable()
  local friendShipLevel = PlayerDataCenter.allFriendshipData:GetLevel(self.dataId)
  local isVowed = self:GetHeroIsVowed()
  local isLimited = self.heroCfg.is_limited
  if friendShipLevel < HeroEnum.TipLevel.Frame and not isNotMerger then
    index = not isLimited and HeroEnum.StateTip.FrameTip or HeroEnum.StateTip.NoTip
  elseif friendShipLevel < HeroEnum.TipLevel.Vow then
    index = HeroEnum.StateTip.BeforeVowTip
  elseif not isVowed then
    index = HeroEnum.StateTip.VowTip
  end
  if level >= index then
    return HeroEnum.StateTip.NoTip
  end
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroFriendLevelTip(self.dataId, index)
  PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetHeroFriendLevelTipTime(self.dataId)
  return index
end

function HeroData:GetAttr(attrId, withoutAth, dontWarning, onlyBaseAttr, fairyData)
  local athHeroId = self.dataId
  if withoutAth then
    athHeroId = nil
  end
  if self.isRemoveAllBounce then
    dontWarning = true
    athHeroId = nil
  end
  local fairyAttrDic
  if fairyData ~= nil then
    fairyAttrDic = fairyData:GetFairyAttrAdd()
  end
  local atrValue = 0
  atrValue = self:__CalBaseAttr(attrId, withoutAth, athHeroId, fairyAttrDic)
  if onlyBaseAttr then
    return atrValue
  end
  atrValue = self:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId, nil, nil, fairyAttrDic)
  atrValue = self:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId, fairyAttrDic)
  if isGameDev and not dontWarning and not withoutAth then
    PlayerDataCenter.heroAttrChecker:DirtyPlayerHeroAttri(self.dataId, attrId, atrValue)
  end
  return atrValue
end

function HeroData:__CalBaseAttr(attrId, withoutAth, athHeroId, fairyAttrDic)
  local baseAttrId = attrId + attrIdOffset
  local atrValue = self.baseAttrDic[attrId]
  if self._talentData ~= nil then
    atrValue = atrValue + self._talentData:GetAttributeAddtion(baseAttrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      atrValue = atrValue + v:GetSpecWeaponAttriAddtionById(baseAttrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[baseAttrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[baseAttrId]
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, baseAttrId, self.camp, self.career, athHeroId)
end

function HeroData:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId, extrValue, onlyExtraValue, fairyAttrDic)
  local ratioAttrId = attrId + attrIdOffset * 2
  local heroStarExtraValue = self.heroStarCfg.atrExtraDic[ratioAttrId] or 0
  if self.potentialCfg ~= nil and self.potentialCfg.extra[ratioAttrId] ~= nil then
    local temp = self.potentialCfg.extra[ratioAttrId] or 0
    heroStarExtraValue = heroStarExtraValue + temp
  end
  if self._talentData ~= nil then
    heroStarExtraValue = heroStarExtraValue + self._talentData:GetAttributeAddtion(ratioAttrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      heroStarExtraValue = heroStarExtraValue + v:GetSpecWeaponAttriAddtionById(ratioAttrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[ratioAttrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[ratioAttrId]
  end
  if extrValue ~= nil then
    heroStarExtraValue = heroStarExtraValue + extrValue
  end
  if onlyExtraValue ~= nil then
    heroStarExtraValue = onlyExtraValue
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, ratioAttrId, self.camp, self.career, athHeroId, heroStarExtraValue)
end

function HeroData:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId, fairyAttrDic)
  local heroStarExtraValue = self.heroStarCfg.atrExtraDic[attrId] or 0
  if self.potentialCfg ~= nil and self.potentialCfg.extra[attrId] ~= nil then
    local temp = self.potentialCfg.extra[attrId] or 0
    heroStarExtraValue = heroStarExtraValue + temp
  end
  if self._talentData ~= nil then
    atrValue = atrValue + self._talentData:GetAttributeAddtion(attrId)
  end
  if self._specWeaponDic ~= nil then
    for k, v in pairs(self._specWeaponDic) do
      atrValue = atrValue + v:GetSpecWeaponAttriAddtionById(attrId)
    end
  end
  if fairyAttrDic ~= nil and fairyAttrDic[attrId] ~= nil then
    atrValue = atrValue + fairyAttrDic[attrId]
  end
  return PlayerDataCenter.attributeBonus:AtrBonusAdd(self.isRemoveAllBounce, atrValue, attrId, attrId, self.camp, self.career, athHeroId, heroStarExtraValue)
end

function HeroData:GetHroBaseAttrForEdiotr()
  local attrDic = table.GetDefaulValueTable(0)
  for i = 1, ConfigData.attribute.maxPropertyId - 1 do
    attrDic[i] = self:__CalBaseAttr(i, false, false)
  end
  return attrDic
end

function HeroData:GetHroRatioAttrForEdiotr()
  local attrDic = table.GetDefaulValueTable(0)
  for i = 1, ConfigData.attribute.maxPropertyId - 1 do
    local ratioAttrId = i + attrIdOffset * 2
    local heroStarExtraValue = self.heroStarCfg.atrExtraDic[ratioAttrId] or 0
    if self.potentialCfg ~= nil and self.potentialCfg.extra[ratioAttrId] ~= nil then
      local temp = self.potentialCfg.extra[ratioAttrId] or 0
      heroStarExtraValue = heroStarExtraValue + temp
    end
    if self._talentData ~= nil then
      heroStarExtraValue = heroStarExtraValue + self._talentData:GetAttributeAddtion(ratioAttrId)
    end
    if self._specWeaponDic ~= nil then
      for k, v in pairs(self._specWeaponDic) do
        heroStarExtraValue = heroStarExtraValue + v:GetSpecWeaponAttriAddtionById(ratioAttrId)
      end
    end
    attrDic[i] = heroStarExtraValue
  end
  return attrDic
end

function HeroData:GetHroExtraAttrForEdiotr()
  local attrDic = table.GetDefaulValueTable(0)
  for i = 1, ConfigData.attribute.maxPropertyId - 1 do
    local heroStarExtraValue = self.heroStarCfg.atrExtraDic[i] or 0
    if self.potentialCfg ~= nil and self.potentialCfg.extra[i] ~= nil then
      local temp = self.potentialCfg.extra[i] or 0
      heroStarExtraValue = heroStarExtraValue + temp
    end
    if self._talentData ~= nil then
      heroStarExtraValue = heroStarExtraValue + self._talentData:GetAttributeAddtion(i)
    end
    if self._specWeaponDic ~= nil then
      for k, v in pairs(self._specWeaponDic) do
        heroStarExtraValue = heroStarExtraValue + v:GetSpecWeaponAttriAddtionById(i)
      end
    end
    attrDic[i] = heroStarExtraValue
  end
  return attrDic
end

function HeroData:SetGuideResName(resName)
  self.guideResName = resName
end

function HeroData:GetGuideResName()
  return self.guideResName
end

return HeroData
