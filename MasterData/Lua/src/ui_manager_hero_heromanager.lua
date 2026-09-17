local this = class("heroManager", G_EventManagerBase)
local wordsTpl = L_GameTpl:getWordsTpl()
local talentRankTpl = L_GameTpl:getTalentRankTpl()
local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
local _heroTpl = L_GameTpl:getHeroTpl()
local _skillLevelTpl = L_GameTpl:getSkillLevelTpl()
this.event = {
  showHeroSelection = "showHeroSelection",
  curModuleChanged = "curModuleChanged"
}

function this:ctor()
  this.super.ctor(self)
  self.previewHeroList = {}
  self.previewHeroListMaxLevel = {}
  self.previewSoulEssenceList = {}
  self.previewSoulEssenceListMaxLevel = {}
  self.selModuleName = L_Const.heroModuleType.Property
  self._ESyncHeroFavorAbilityHandler = handler(self, self.onEvent_heroFavorabilityUp)
  AzurWorld.heroMgr:RegisterEvent(C_EHeroEvent.ESyncHeroFavorAbility, self._ESyncHeroFavorAbilityHandler)
  self.onCutWorldEndHandler = handler(self, self.onCutWorldEnd)
  C_GameFlow.flowEvent:Listen(C_EGameFlowEvent.CutWorldComplete, self.onCutWorldEndHandler)
  self.lastInstanceObj = nil
end

function this:onCutWorldEnd()
  L_EntrustStore:openRuneRelatedPage()
end

function this:heroHintInfo(num)
  local switch = {
    [1] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackGold"))
      return
    end,
    [2] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_lackLevel"))
      return
    end,
    [3] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackItem"))
      return
    end,
    [4] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_rankMax"))
      return
    end,
    [5] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_levelMax"))
      return
    end,
    [6] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_chooseLevelItem"))
      return
    end,
    [7] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_common_lackItem"))
      return
    end,
    [0] = function()
      L_FlyMsgManager:showNormalMsg(wordsTpl:getTplById("notice_hero_chooseStarItem"))
      return
    end
  }
  local f = switch[num]
  if f then
    return f()
  else
  end
end

function this:addComma(value)
  if tonumber(value) == nil then
    return "Error: Input is not a number."
  end
  value = tostring(value)
  local integer_part, decimal_part = string.match(value, "^(%d+)(%.%d*)$")
  integer_part = integer_part or value
  local output = ""
  local length = string.len(integer_part)
  local counter = 0
  for i = length, 1, -1 do
    counter = counter + 1
    output = string.sub(integer_part, i, i) .. output
    if counter == 3 and 1 < i then
      output = "," .. output
      counter = 0
    end
  end
  if decimal_part then
    output = output .. decimal_part
  end
  return output
end

function this:getHeroName(heroId, heroConfigId)
  if math.isEmpty(heroId) then
    return
  end
  local heroTpl = L_GameTpl:getHeroTpl()
  if math.isEmpty(heroConfigId) then
    heroConfigId = L_HeroStore:getHeroConfigId(L_HeroStore:getHero(heroId))
  end
  if heroId == L_HeroStore:getDefaultHeroGuid() then
    return L_PlayerStore:getPlayerName()
  else
    return heroTpl:getName(heroTpl:getTplById(heroConfigId))
  end
end

function this:sliderChange(value)
  return 0.1 + value * 0.8
end

function this:getTimelineControl()
  if self.timelineControl == nil then
    self.timelineControl = require("ui.manager.hero.timeline.timelineControl").new()
  end
  return self.timelineControl
end

function this:getNestTimelineControl()
  return require("ui.manager.hero.timeline.timelineControl").new()
end

function this:getTimelineHeroPrefab()
  if self.timelineControl == nil then
    return
  end
  return self.timelineControl:getCurHeroPrefab()
end

function this:disposeTimelineControl()
  if self.timelineControl then
    self.timelineControl:dispose()
  end
  self.timelineControl = nil
end

function this:lvChange(lv)
  if lv < 10 then
    return string.format("0%d", lv)
  end
  return tostring(lv)
end

function this:autoLvUp(expBookTable, upExp)
  local sortMax = {}
  for i in pairs(expBookTable) do
    table.insert(sortMax, i)
  end
  table.sort(sortMax, function(a, b)
    return b < a
  end)
  local exp = upExp
  local tempData = {}
  for i = 1, #sortMax do
    tempData[sortMax[i]] = 0
    if exp >= sortMax[i] then
      local num = math.min(math.modf(exp / sortMax[i]), expBookTable[sortMax[i]])
      tempData[sortMax[i]] = num
      exp = exp - num * sortMax[i]
    end
  end
  if 0 < exp then
    for i = #sortMax, 1, -1 do
      local v = sortMax[i]
      if exp <= sortMax[i] and expBookTable[v] > tempData[v] then
        tempData[v] = tempData[v] + 1
        break
      end
    end
  end
  return tempData
end

function this:initHeroDataAll(hero, isMaxLevel)
  self:initHeroDataLevel(hero, isMaxLevel)
  self:initHeroDataSkill(hero, isMaxLevel)
  self:initHeroDataStar(hero, isMaxLevel)
end

function this:initHeroDataStar(hero, isMaxLevel)
  local tpl
  if isMaxLevel then
    hero.heroGrade = L_GameTpl:getGameConstTpl():getData("HERO_MAX_GRADE", L_Const.GameTplType.int, 0)
  else
    local data = AzurWorld.heroMgr:GetHero(hero.guid)
    if data then
      hero.heroGrade = data.heroGrade
    else
      hero.heroGrade = 0
    end
  end
end

function this:initHeroDataLevel(hero, isMaxLevel)
  if isMaxLevel then
    local tpl = talentRankTpl:getMaxTpl(L_HeroStore:getHeroConfigId(hero))
    hero.heroRank = talentRankTpl:getRank(tpl)
    hero.lv = talentRankTpl:getRankLevelLimit(tpl)
  else
    local data = AzurWorld.heroMgr:GetHero(hero.guid)
    if data then
      hero.heroRank = data.rank
      hero.lv = data.level
    else
      hero.heroRank = 1
      hero.lv = 1
    end
  end
  hero.runeIds = {}
  local tpl = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), L_HeroStore:getHeroRank(hero))
  local runes = talentRankTpl:getRankBreakthroughItem(tpl)
  for _, rune in ipairs(runes) do
    table.insert(hero.runeIds, rune)
  end
end

function this:initHeroDataSkill(hero, isMaxLevel)
  hero.systemSkillLevel = {}
  local data = AzurWorld.heroMgr:GetHero(hero.guid)
  if data then
    local skillSystem = data.systemSkillLevel
    for i = 0, skillSystem.Count - 1 do
      local level = isMaxLevel and _skillLevelTpl:getMaxLevelById(v) or 1
      table.insert(hero.systemSkillLevel, level)
    end
  else
    local skillSystem = _heroTpl:getSkillSystem(_heroTpl:getTplById(L_HeroStore:getHeroConfigId(hero)))
    for k, v in ipairs(skillSystem) do
      local level = isMaxLevel and _skillLevelTpl:getMaxLevelById(v) or 1
      table.insert(hero.systemSkillLevel, level)
    end
  end
end

function this:getPreviewHeroData(heroId, isMaxLevel, showCurrentProperty)
  local list
  if isMaxLevel then
    list = self.previewHeroListMaxLevel
  else
    list = self.previewHeroList
  end
  local hero = list[heroId] or {}
  local configId = heroId
  local hero_data = AzurWorld.heroMgr:GetHero(heroId)
  if hero_data ~= nil then
    configId = hero_data.configId
  end
  if table.isEmpty(hero) or showCurrentProperty then
    hero.guid = heroId
    hero.configId = configId
    self:initHeroDataAll(hero, isMaxLevel)
    list[heroId] = hero
  end
  return hero
end

local heroSkillMap = {}
heroSkillMap.skillId = 1
heroSkillMap.skillLevel = 2

function this:creatHeroSkillMap(skillId, level)
  return {skillId = skillId, skillLevel = level}
end

function this:getHeroAllSystemSkills(heroItemInfo)
  local tpl = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(heroItemInfo))
  local systemSkillIdList = _heroTpl:getSkillSystem(tpl)
  local systemSkillLevelList = L_HeroStore:getHeroSysSkillLevel(heroItemInfo)
  local skillTpl = L_GameTpl:getSkillTpl()
  local res = {}
  local childs
  for i, v in ipairs(systemSkillIdList) do
    if res[v] ~= nil then
      errorf("获取技能id和等级时出现重复的技能ID: " .. v, 2)
    end
    res[v] = self:creatHeroSkillMap(v, systemSkillLevelList[i])
    if not skillTpl:getTplById(v) then
      errorf("skill技能表读取不到ID: " .. v, 2)
      break
    end
    childs = skillTpl:getChildSkills(skillTpl:getTplById(v))
    for _, child in pairs(childs) do
      if res[child] ~= nil then
        errorf("获取技能id和等级时出现重复的技能ID: " .. child, 2)
      end
      res[child] = self:creatHeroSkillMap(child, systemSkillLevelList[i])
    end
  end
  return res
end

function this:getHeroSystemSkillList(heroItemInfo)
  local tpl = _heroTpl:getTplById(L_HeroStore:getHeroConfigId(heroItemInfo))
  local systemSkillIdList = _heroTpl:getSkillSystem(tpl)
  local systemSkillLevelList = L_HeroStore:getHeroSysSkillLevel(heroItemInfo)
  local res = {}
  for i, v in ipairs(systemSkillIdList) do
    table.insert(res, self:creatHeroSkillMap(v, systemSkillLevelList[i] or 1))
  end
  return res
end

function this:getHeroConfigProperty(heroData, lv, rank)
  lv = lv or L_HeroStore:getHeroLevel(heroData)
  rank = rank or L_HeroStore:getHeroRank(heroData)
  local heroTpl = L_GameTpl:getHeroTpl()
  local property = heroTpl:getHeroConfigAtt(L_HeroStore:getHeroConfigId(heroData), lv, rank)
  return property
end

function this:getHeroStarGiftByHeroIdAndRank(configId, rank, runeIds)
  local rankData = talentRankTpl:getHeroRankTpls(configId)
  if rankData == nil then
    error("获取英雄rank相关属性加成时，talentRank表查询为空 configID:" .. tostring(configId))
    return {}, {}
  end
  local attributeAll = {}
  local tempAttribute = {}
  for i = 0, rank - 1 do
    if rankData[i] then
      tempAttribute = talentRankTpl:getAttribute(rankData[i])
      for k, v in pairs(tempAttribute) do
        if not attributeAll[k] then
          attributeAll[k] = 0
        end
        attributeAll[k] = attributeAll[k] + v
      end
      local runes = talentRankTpl:getRankBreakthroughItem(rankData[i])
      self:addRuneAttributes(runes, attributeAll)
    end
  end
  self:addRuneAttributes(runeIds, attributeAll)
  return attributeAll, {}
end

function this:addRuneAttributes(runeIds, attributeAll)
  for _, runeId in ipairs(runeIds) do
    if not math.isEmpty(runeId) then
      local runeTpl = talentRuneTpl:getTplById(runeId)
      local runeAttrs = talentRuneTpl:getRuneAttribute(runeTpl)
      for id, v in pairs(runeAttrs) do
        if not attributeAll[id] then
          attributeAll[id] = 0
        end
        attributeAll[id] = attributeAll[id] + v
      end
    end
  end
end

function this:sortAttrId(datas)
  table.sort(datas, function(a, b)
    local aw = a.id == 5 and 0 or a.id
    local bw = b.id == 5 and 0 or b.id
    return aw < bw
  end)
end

function this:reqWearPet(heroGuid, petGuid, callback)
  if not L_FormationManager:checkCanChangeFormation() then
    return
  end
  
  local function endDo()
    AzurWorld.heroMgr:ReqWearPet(heroGuid, petGuid, callback)
  end
  
  if not L_FormationManager:checkCanChangeFormationPet(petGuid, endDo) then
    return
  end
  endDo()
end

function this:showHeroSelection(selectionType, heroGuid, jumpData)
  self:sendEvent(self.event.showHeroSelection, {
    selectionType = selectionType,
    heroGuid = heroGuid,
    jumpData = jumpData
  })
end

function this:curModuleChanged(moduleName, status)
  self:sendEvent(self.event.curModuleChanged, {moduleName = moduleName, status = status})
end

function this:onEvent_heroFavorabilityUp(enum, varList)
  if L_UI:checkPageOpen("PageGiveGift") == false and C_StoryManager.GetIsPlaying() == false and AzurWorld.DungeonMgr:CheckIsDungeonScene() == false then
    print("================================favorchange")
    local heroList = varList:GetObject(0)
    local res = {}
    for i = 0, heroList.Count - 1 do
      table.insert(res, {
        heroId = heroList[i][0],
        startLevel = heroList[i][1]
      })
    end
    L_UI:open("pageHeroFavorabilityLevelUp", {heroList = res})
  end
  L_HeroStore:call(L_HeroStore.event.favorLvChange)
end

return this
