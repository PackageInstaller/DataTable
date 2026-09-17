local this = {}

function this:init()
  self.super.init(self)
  self.data = {
    heroAttrDic = {}
  }
end

function this:getDefaultHeroGuid()
  return AzurWorld.heroMgr:GetDefaultHeroGuid()
end

function this:getAllHero()
  if not AzurWorld or not AzurWorld.heroMgr then
    return {}
  end
  local heroList = {}
  for i, v in pairs(AzurWorld.heroMgr:GetNormalHero()) do
    local id = L_HeroStore:getHeroGuid(v)
    local belongPlayer = id & 268435455
    if belongPlayer == AzurWorld.playerMgr.myPlayerId then
      table.insert(heroList, v)
    end
  end
  return heroList
end

function this:getAllNormalHero()
  if not AzurWorld or not AzurWorld.heroMgr then
    return table.empty
  end
  local ret = AzurWorld.heroMgr:GetNormalHeroNOGC()
  return ret
end

function this:getHero(heroGuid)
  if heroGuid == nil then
    return nil
  end
  return AzurWorld.heroMgr:GetHero(heroGuid)
end

function this:getHeroId(heroGuid)
  if heroGuid == nil then
    return 0
  end
  local info = AzurWorld.heroMgr:GetHero(heroGuid)
  if not info then
    errorf("英雄数据不存在 heroGuid = " .. tostring(self.selectHeroGuid))
    return 0
  end
  return info.configId
end

function this:getHeroAttrInfo(heroGuid)
  local attrInfo = self.data.heroAttrDic[heroGuid]
  if attrInfo == nil then
    attrInfo = require(L_R.store .. "hero.data.heroAttrInfo").new(heroGuid)
    self.data.heroAttrDic[heroGuid] = attrInfo
  end
  return attrInfo
end

function this:getHeroPropertyMap(heroGuid)
  local info = self:getHeroAttrInfo(heroGuid)
  return info.attrMap
end

function this:getGuidByConfigId(configId)
  return self:getHeroGuid(AzurWorld.heroMgr:GetHeroByConfigId(math.floor(tonumber(configId))))
end

function this:getHasHero(heroConfigId)
  for i, v in pairs(self:getAllHero()) do
    if self:getHeroConfigId(v) == heroConfigId then
      return true
    end
  end
  return false
end

function this:getHeroByConfigId(heroConfigId)
  for i, v in pairs(self:getAllHero()) do
    if self:getHeroConfigId(v) == heroConfigId then
      return v
    end
  end
end

function this:getHeroGuid(hero)
  if hero == nil then
    return 0
  end
  return hero.guid
end

function this:getHeroLevel(hero)
  return hero.lv or 0
end

function this:getHeroExp(hero)
  return hero.heroExp or 0
end

function this:getHeroRank(hero)
  return hero.heroRank or 1
end

function this:getHeroSoulEssenceGuid(hero)
  return hero.soulEssenceGuid or 0
end

function this:getHeroFurniture(heroGuid)
  local bShow = false
  local heroData = L_HeroStore:getHero(heroGuid)
  if heroData == nil then
    return bShow
  end
  local furnitureList = heroData.furnitures
  local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
  local allData = homeDormFurnitureTpl:getHerofurnitureMap()[heroData.configId]
  if allData then
    for key, itemId in pairs(allData) do
      if table.containsValue(furnitureList, itemId) == false and C_BagMgr:getItemNumByItemId(itemId) > 0 then
        bShow = true
        break
      end
    end
  end
  return bShow
end

function this:getHeroSysSkillLevel(hero)
  if type(hero.systemSkillLevel) == "table" then
    return hero.systemSkillLevel
  end
  local res = {}
  if not hero.systemSkillLevel then
    return res
  end
  for i = 0, hero.systemSkillLevel.Count - 1 do
    table.insert(res, hero.systemSkillLevel[i])
  end
  return res
end

function this:getHeroStar(hero)
  return hero.heroGrade or 0
end

function this:getHeroAccessoryGuidList(hero)
  local res = {}
  if not hero then
    return res
  end
  if not hero.accessoryGuidList then
    return res
  end
  for i = 0, hero.accessoryGuidList.Count - 1 do
    table.insert(res, hero.accessoryGuidList[i])
  end
  return res
end

function this:getHeroPetGuid(hero)
  if not math.isEmpty(hero.trailPetId) then
    return hero.trailPetId
  end
  return hero.petId or 0
end

function this:getHeroPetGuidByHeroGuid(guid)
  local hero = L_HeroStore:getHero(guid)
  if hero == nil then
    return 0
  end
  if not math.isEmpty(hero.trailPetId) then
    return hero.trailPetId
  end
  return hero.petId or 0
end

function this:getHeroFavorAbilityExp(hero)
  return hero.favorabilityExp or 0
end

function this:IsRankRewardGetted(hero, rewardId)
  if 64 <= rewardId then
    return false
  end
  return hero.rankReward & 1 << rewardId ~= 0
end

function this:getHeroStoreFavorRewards(hero)
  local res = {}
  if not hero.storeFavorRewards then
    return res
  end
  for i = 0, hero.storeFavorRewards.Count - 1 do
    table.insert(res, hero.storeFavorRewards[i])
  end
  return res
end

function this:getHeroConfigId(hero)
  return hero.configId
end

function this:getHeroFavorAbilityLevel(hero)
  return hero.favorabilityLevel or 0
end

function this:getHeroCharKiboState(hero)
  return hero.charKiboState or 0
end

function this:getHeroRuneIds(hero)
  if type(hero.runeIds) == "table" then
    return hero.runeIds
  end
  local res = {}
  if not hero.runeIds then
    return res
  end
  for i = 0, hero.runeIds.Count - 1 do
    table.insert(res, hero.runeIds[i])
  end
  return res
end

function this:getHeroType(hero)
  return hero.type
end

function this:getHeroType(hero)
  return hero.type
end

function this:getTrailPet(hero)
  return hero.trailPetId or 0
end

function this:getIsTrail(hero)
  return hero:GetIsTrialHero()
end

function this:getIsCharDataRead(heroGuid, dataType, dataId)
  local infos = AzurWorld.heroMgr:GetCharDataInfoList(heroGuid)
  if infos then
    local isExist, info = infos:TryGetValue(dataType)
    if isExist and info.recordIds ~= nil then
      return info.recordIds:Contains(dataId)
    end
  end
  return false
end

function this:getCharDataState(heroGuid, dataType, dataId)
  if self.dataState == nil then
    self.dataState = {}
  end
  if self.dataState[heroGuid] == nil then
    self.dataState[heroGuid] = {}
  end
  if self.dataState[heroGuid][dataType] == nil then
    self.dataState[heroGuid][dataType] = {}
  end
  local cache = self.dataState[heroGuid][dataType]
  local state = cache[dataId]
  if state == 2 then
    return 2
  end
  local isReaded = self:getIsCharDataRead(heroGuid, dataType, dataId)
  if isReaded then
    cache[dataId] = 2
    return 2
  end
  if state == 1 then
    return 1
  end
  local unlockCondition
  if dataType == L_Const.heroData.story then
    local tpl = L_GameTpl:getCharStoryTpl()
    unlockCondition = tpl:getUnlockCondition(tpl:getTplById(dataId))
  elseif dataType == L_Const.heroData.voice then
    local tpl = L_GameTpl:getCharVoiceTpl()
    unlockCondition = tpl:getUnlockCondition(tpl:getTplById(dataId))
  elseif dataType == L_Const.heroData.drama then
    local tpl = L_GameTpl:getCharPlotTpl()
    local charPlots = tpl:getTplById(dataId)
    unlockCondition = tpl:getUnlockCondition(charPlots)
  else
    return 0
  end
  if L_ConditionManager:isComplete(unlockCondition) then
    cache[dataId] = 1
    return 1
  end
  cache[dataId] = 0
  return 0
end

function this:getIsPlayLevelAnim()
  return self.data.isPlayLevelAnim
end

function this:setIsPlayLevelAnim(isPlay)
  self.data.isPlayLevelAnim = isPlay
end

return this
