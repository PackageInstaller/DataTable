local this = {}
local heroTpl = L_GameTpl:getHeroTpl()
local skillLevelTpl = L_GameTpl:getSkillLevelTpl()
local accessoryTpl = L_GameTpl:getAccessoryTpl()
local charDataTpl = L_GameTpl:getCharDataTpl()
local charVoiceTpl = L_GameTpl:getCharVoiceTpl()
local charStoryTpl = L_GameTpl:getCharStoryTpl()
local playerTitleTpl = L_GameTpl:getPlayerTitleTpl()
local _achievementAwardTpl = L_GameTpl:getAchievementAwardTpl()
local charPlotTpl = L_GameTpl:getCharPlotTpl()
local mountTpl = L_GameTpl:getMountTpl()
local gameEventsTpl = L_GameTpl:getGameEventsTpl()
local _gameEventsTpl = L_GameTpl:getGameEventsTpl()
local gameEventsRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()
local gameEventsKiboDuelGroupTpl = L_GameTpl:getGameEventsKiboDuelTpl()
local productsTpl = L_GameTpl:getProductsTpl()
local foodGroupTpl = L_GameTpl:getFoodGroupTpl()
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()
local _dungeonEntrustRewardTpl = L_GameTpl:getDungeonEntrustRewardTpl()
local _filterMarkTpl = L_GameTpl:getWorldFilterMarkTpl()
local _soulessenceTpl = L_GameTpl:getSoulessenceTpl()
local _soulessenceRankTpl = L_GameTpl:getSoulessenceRankTpl()
local _homeLevelShowTpl = L_GameTpl:getHomeLevelShowTpl()
local _charKiboTpl = L_GameTpl:getCharKiboTpl()

local function singleHeroIterator(hero, index)
  if index == nil and hero then
    return true, hero
  end
end

local function getTargetHeroIterator(heroGuid)
  if heroGuid then
    return singleHeroIterator, L_HeroStore:getHero(heroGuid)
  end
  return pairs(L_HeroStore:getAllNormalHero())
end

function this:getDotHeroNew()
  local heros = L_HeroStore:getAllNormalHero()
  local kvMap = {}
  for _, hero in pairs(heros) do
    if self:haveNew(self.DotDef.HeroNew, L_HeroStore:getHeroGuid(hero)) then
      kvMap[L_HeroStore:getHeroGuid(hero)] = 1
    end
  end
  return kvMap
end

function this:getHandBookCharacterNewItem()
  local heros = L_HeroStore:getAllNormalHero()
  local kvMap = {}
  for _, hero in pairs(heros) do
    if self:haveNew(self.DotDef.HandBook_Character_New_Item, L_HeroStore:getHeroGuid(hero)) then
      kvMap[L_HeroStore:getHeroGuid(hero)] = 1
    end
  end
  return kvMap
end

function this:getDotHeroSkill()
  local heros = L_HeroStore:getAllNormalHero()
  local kvMap = {}
  for _, hero in pairs(heros) do
    local skill_list = L_HeroStore:getHeroSysSkillLevel(hero)
    local skill_config_list = heroTpl:getSkillSystem(heroTpl:getTplById(L_HeroStore:getHeroConfigId(hero)))
    for k, skillId in ipairs(skill_config_list) do
      if skill_list[k] then
        local tpl = skillLevelTpl:getTplByIdAndLevel(skillId, skill_list[k])
        if skillLevelTpl:getCanUp(tpl) then
          local canUpgrade = true
          local material_list = skillLevelTpl:getItem(tpl)
          for i = 1, #material_list do
            local item = L_ItemManager:parseCommonItem(material_list[i][1])
            canUpgrade = canUpgrade and item.num >= material_list[i][2]
          end
          local nextTpl = skillLevelTpl:getTplByIdAndLevel(skillId, skill_list[k] + 1)
          nextTpl = nextTpl or tpl
          canUpgrade = canUpgrade and skillLevelTpl:getHeroLevel(nextTpl) <= L_HeroStore:getHeroLevel(hero) and skillLevelTpl:getHeroRank(nextTpl) <= L_HeroStore:getHeroRank(hero)
          if canUpgrade then
            kvMap[L_HeroStore:getHeroGuid(hero) .. "_" .. skillId] = 1
          end
        end
      end
    end
  end
  return kvMap
end

local function getHeroStarUpState(hero)
  local heroGrade = L_HeroStore:getHeroStar(hero)
  local heroConfigId = L_HeroStore:getHeroConfigId(hero)
  local canBreak = heroGrade < 6
  local heroGradeUpItems = heroTpl:getGradeUpItem(heroConfigId, heroGrade)
  if heroGradeUpItems and #heroGradeUpItems == 2 then
    local upitemId = heroGradeUpItems[1]
    local upItemNum = heroGradeUpItems[2]
    canBreak = canBreak and upItemNum <= C_BagMgr:getItemNumByItemId(upitemId)
  end
  return canBreak, heroGrade
end

function this:canHeroStarUp(heroGuid, targetGrade)
  local hero = L_HeroStore:getHero(heroGuid)
  local result = false
  if hero then
    local canBreak, heroGrade = getHeroStarUpState(hero)
    result = canBreak and (not targetGrade or targetGrade == heroGrade + 1)
  end
  return result
end

function this:getDotHeroStar()
  local heros = L_HeroStore:getAllNormalHero()
  local kvMap = {}
  for _, hero in pairs(heros) do
    local canBreak, heroGrade = getHeroStarUpState(hero)
    if canBreak then
      local heroGuid = L_HeroStore:getHeroGuid(hero)
      kvMap[heroGuid] = 1
      kvMap[heroGuid .. "_" .. heroGrade + 1] = 1
    end
  end
  return kvMap
end

function this:getHeroAcc()
  local kvMap = {}
  local kvMapSp = {}
  local kvMapAc = {}
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.soulEssence) then
    kvMapSp = self:getDotHeroSpirit()
  end
  if C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.accessory) then
    kvMapAc = self:getDotHeroJewel()
  end
  for k, sp in pairs(kvMapSp) do
    kvMap[k] = sp
  end
  for k, ac in pairs(kvMapAc) do
    if kvMap[k] == 0 or not kvMap[k] then
      kvMap[k] = ac
    end
  end
  return kvMap
end

function this:getDotHeroSpirit()
  print("==============================reddot111111111111")
  local kvMap = {}
  local weaponList = C_SoulEssenceMgr:getSoulEssenceMap()
  local haveRest = false
  for k, weapon in pairs(weaponList) do
    if math.isEmpty(weapon.wearHero) then
      haveRest = true
      break
    end
  end
  if not haveRest then
    return kvMap
  end
  local heros = L_HeroStore:getAllNormalHero()
  for _, hero in pairs(heros) do
    if L_HeroStore:getHeroSoulEssenceGuid(hero) == 0 then
      kvMap[L_HeroStore:getHeroGuid(hero)] = 1
    end
  end
  return kvMap
end

function this:getDotHeroPresent()
  print("==============================reddotheroGuid")
  local kvMap = {}
  local heros = L_HeroStore:getAllNormalHero()
  for _, hero in pairs(heros) do
    local heroConfigId = L_HeroStore:getHeroConfigId(hero)
    local heroGuid = L_HeroStore:getHeroGuid(hero)
    local furnitureList = L_HeroStore:getHero(heroGuid).furnitures
    local homeDormFurnitureTpl = L_GameTpl:gethomeDormFurnitureTpl()
    local allData = homeDormFurnitureTpl:getHerofurnitureMap()[heroConfigId]
    if allData then
      for key, itemId in pairs(allData) do
        if C_BagMgr:getItemNumByItemId(itemId) > 0 and table.containsValue(furnitureList, itemId) == false then
          kvMap[heroGuid] = 1
          kvMap[heroGuid .. "_" .. itemId] = 1
        end
      end
    end
  end
  return kvMap
end

function this:getDotHeroJewel()
  local kvMap = {}
  return self:dotHeroJewel(kvMap, false)
end

function this:getDotHeroJewelMenu()
  local kvMap = {}
  return self:dotHeroJewel(kvMap, true)
end

function this:dotHeroJewel(kvMap, isMenu, heroGuid)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.accessory) then
    return kvMap
  end
  local jewelList = C_AccessoryMgr:getHeroAccessory()
  local restMap = {}
  for _, jewel in pairs(jewelList) do
    if math.isEmpty(jewel.wearHero) and not math.isEmpty(jewel.accessoryId) then
      local tpl = accessoryTpl:getTplById(jewel.accessoryId)
      if not tpl then
        errorf("穿了装备表不存在得装备 accessoryId == " .. tostring(jewel.accessoryId))
      else
        restMap[accessoryTpl:getType(tpl)] = true
      end
    end
  end
  local posData = isMenu and L_FormationStore:getFormationPosData(L_FormationConst.FormationType.world) or nil
  for _, hero in getTargetHeroIterator(heroGuid) do
    local guid = L_HeroStore:getHeroGuid(hero)
    local isOut = false
    if isMenu then
      for i, posGuid in pairs(posData) do
        if not math.isEmpty(guid) and guid == posGuid then
          isOut = true
          break
        end
      end
    end
    if isOut or not isMenu then
      local accessoryList
      for t, _ in pairs(restMap) do
        accessoryList = accessoryList or L_HeroStore:getHeroAccessoryGuidList(hero)
        if math.isEmpty(accessoryList[t]) then
          kvMap[guid] = 1
          kvMap[guid .. "_" .. t] = 1
        end
      end
    end
  end
  return kvMap
end

function this:dotHeroSoulEssence(kvMap, isMenu, heroGuid)
  local weaponList = C_SoulEssenceMgr:getSoulEssenceMap()
  local haveRest = false
  for k, weapon in pairs(weaponList) do
    if math.isEmpty(weapon.wearHero) then
      haveRest = true
      break
    end
  end
  if not haveRest then
    return kvMap
  end
  local posData = isMenu and L_FormationStore:getFormationPosData(L_FormationConst.FormationType.world) or nil
  for _, hero in getTargetHeroIterator(heroGuid) do
    local guid = L_HeroStore:getHeroGuid(hero)
    local isOut = false
    if isMenu then
      for i, posGuid in pairs(posData) do
        if not math.isEmpty(guid) and guid == posGuid then
          isOut = true
          break
        end
      end
    end
    if (isOut or not isMenu) and L_HeroStore:getHeroSoulEssenceGuid(hero) == 0 then
      kvMap[guid] = 1
    end
  end
  return kvMap
end

function this:getDotHeroInfo()
  local kvMap = {}
  local heros = L_HeroStore:getAllHero()
  local storyOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroDataStory)
  local voiceOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroDataVoice)
  local dramaOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroDataDrama)
  local favorOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroFavorability)
  local petOpen = C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroDataPet)
  for _, hero in ipairs(heros) do
    local heroId = L_HeroStore:getHeroConfigId(hero)
    if not math.isEmpty(heroId) then
      local charConf = charDataTpl:getTplById(heroId)
      if not charConf then
        errorf("charData表 没有heroid: " .. heroId)
      else
        if storyOpen then
          local storys = charDataTpl:getCharacterStory(charConf)
          for _, v in pairs(storys) do
            if L_HeroStore:getCharDataState(heroId, L_Const.heroData.story, v) == 1 then
              kvMap[heroId .. "_story"] = 1
              break
            end
          end
        end
        if voiceOpen then
          local voices = charDataTpl:getCharacterVoice(charConf)
          for _, v in pairs(voices) do
            if charVoiceTpl:getTplById(v) == nil then
              errorf("charDataTpl的CharacterVoice配了一个id " .. v .. " 在charVoice表里找不到", 2)
            elseif L_HeroStore:getCharDataState(heroId, L_Const.heroData.voice, v) == 1 then
              kvMap[heroId .. "_voice"] = 1
              break
            end
          end
        end
        if dramaOpen then
          local charPlots = charPlotTpl:getChildren(heroId)
          if charPlots then
            for _, charPlot in ipairs(charPlots) do
              local taskId = charPlotTpl:getTaskId(charPlot)
              local taskFinish = true
              if taskId and taskId ~= 0 then
                taskFinish = AzurWorld.TaskMgr:IsFinishTask(taskId)
              end
              if not taskFinish then
                local charId = charPlotTpl:getId(charPlot)
                if L_HeroStore:getCharDataState(heroId, L_Const.heroData.drama, charId) == 1 then
                  kvMap[heroId .. "_drama"] = 1
                  kvMap[heroId .. "_drama_" .. charId] = 1
                end
              end
            end
          end
        end
        if petOpen then
          local herotpl = heroTpl:getTplById(heroId)
          local kiboId = heroTpl:getKiboId(herotpl)
          if kiboId and 0 < kiboId then
            local tableData = _charKiboTpl:getTplById(heroId)
            if tableData then
              local unLockCondition = _charKiboTpl:getUnlockCondition(tableData)
              local isComp, results = L_ConditionManager:isComplete(unLockCondition)
              if isComp and tableData.getType == 1 and L_PetStore:getPetNum(kiboId) == 0 then
                kvMap[hero.guid] = 1
                kvMap[hero.guid .. "_pet"] = 1
                kvMap[hero.guid .. "_petGet"] = 1
              end
            end
          end
        end
      end
    end
  end
  return kvMap
end

function this:getDotSpiritNew()
  local weapons = C_SoulEssenceMgr:getSoulEssenceMap()
  local kvMap = {}
  for _, weapon in pairs(weapons) do
    if self:haveNew(self.DotDef.SpiritNew, weapon.guid) and math.isEmpty(weapon.exp) and math.isEmpty(weapon.wearHero) then
      kvMap[weapon.guid] = 1
    elseif self:haveNew(self.DotDef.SpiritNew, weapon.guid) then
      self:clearNew(self.DotDef.SpiritNew, weapon.guid)
    end
  end
  return kvMap
end

function this:getDotJewelNew()
  local jewels = C_AccessoryMgr:getHeroAccessory()
  local kvMap = {}
  for _, jewel in pairs(jewels) do
    if self:haveNew(L_ReddotManager.DotDef.JewelNew, jewel.guid) then
      kvMap[jewel.guid] = 1
    end
  end
  return kvMap
end

function this:getDotFriendApplication()
  local oldStr = L_CommonUtil.getLocalValue(L_ReddotManager.DotDef.Friend) and L_CommonUtil.getLocalValue(L_ReddotManager.DotDef.Friend) or ""
  local newStr = ""
  local applyList = table.count(L_FriendStore:getFriendApplicationList()) > 0 and L_FriendStore:getFriendApplicationList() or {}
  for k, v in pairs(applyList) do
    newStr = newStr .. "," .. v:getPlayerUid()
  end
  local result = oldStr ~= newStr and 1 or 0
  C_MJLog.LogInfo("[好友申请]\n" .. "oldStr:" .. oldStr .. "\n" .. "newStr:" .. newStr, C_ELogModule.Guide)
  return result
end

function this:getDotFriendPrivateChat()
  local kvMap = {}
  local playerList = L_FriendStore:getFriendList()
  for k, v in pairs(playerList) do
    local conversation = L_ChatStore:getConversation(v:getPlayerUid())
    if conversation and conversation.readedOrder < conversation.currentOrder then
      kvMap[v:getPlayerUid()] = 1
    else
      kvMap[v:getPlayerUid()] = 0
    end
  end
  return kvMap
end

function this:getDotWorldChat()
  return L_ChatStore:getChannelData(L_Const.chatType.world):getChannelGetNewMessage() and 1 or 0
end

function this:getDotTeamChat()
  return L_ChatStore:getChannelData(L_Const.chatType.team):getChannelGetNewMessage() and 1 or 0
end

function this:getDotAchieve()
  local pointAllNum = L_AchievementUtil.getStore():GetCurAllPointValue()
  local lastGetPoint = L_AchievementUtil.getStore():GetLastAchievementAwardPoint()
  local curGetPoint = 0
  if lastGetPoint == nil or lastGetPoint == 0 then
    local tpl = _achievementAwardTpl:getFirstTpl()
    curGetPoint = _achievementAwardTpl:getAchiPoint(tpl)
  else
    local awardId = _achievementAwardTpl:getIdByPoint(lastGetPoint)
    local tpl = _achievementAwardTpl:getNextTplById(awardId)
    curGetPoint = _achievementAwardTpl:getAchiPoint(tpl)
  end
  if curGetPoint == 0 or not curGetPoint then
  end
  local canReward = pointAllNum >= curGetPoint and pointAllNum ~= lastGetPoint
  return canReward and 1 or 0
end

function this:getDotSocialEmotion()
  local oldStr = L_CommonUtil.getLocalValue(L_ReddotManager.DotDef.SocialEmotion_New) and L_CommonUtil.getLocalValue(L_ReddotManager.DotDef.SocialEmotion_New) or ""
  local newStr = C_SocialRouletteStore.GetReddotLocalRecord()
  local result = oldStr ~= newStr and 1 or 0
  return result
end

function this:getDotSpecialShop()
  return 0
end

function this:getDotMail()
  local mails = L_MailManager:getMailByCategory(L_Const.mailCategory.all)
  for _, mail in pairs(mails) do
    if L_MailManager:isMailHasRed(mail) then
      return 1
    end
  end
  return 0
end

function this:getDotWorldExplore()
  local kvMap = {}
  return kvMap
end

function this:getDotPetNew()
  local kvMap = {}
  local pets = L_PetStore:getPetList()
  for _, pet in pairs(pets) do
    if self:haveNew(self.DotDef.PetNew, pet.guid) then
      kvMap[pet.guid] = 1
    end
  end
  return kvMap
end

function this:getDotPetGeneMutation()
  local kvMap = {}
  local pets = L_PetStore:getPetList()
  for _, pet in pairs(pets) do
    if self:haveNew(self.DotDef.PetGeneMutation, pet.guid) then
      kvMap[pet.guid] = 1
    end
  end
  return kvMap
end

function this:getDotEntrustTaskDifficulty()
  local kvMap = {}
  local allModeInfo = _dungeonEntrustTpl:getModeInfo()
  for difficultyId, v in pairs(allModeInfo) do
    local starNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, difficultyId)
    local modeInfo = _dungeonEntrustRewardTpl:getInfoByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, difficultyId)
    if modeInfo then
      local haveNew = false
      for _, v in ipairs(modeInfo) do
        if starNum >= v.starNum and not L_EntrustStore:checkEntrustRewardReceived(v.id) then
          kvMap[difficultyId] = 1
          haveNew = true
          break
        end
      end
      if not haveNew then
        kvMap[difficultyId] = 0
      end
    end
  end
  return kvMap
end

function this:getDotEntrustMultiTaskDifficulty()
  local kvMap = {}
  local _dungeonCrisisCrusadeTpl = L_GameTpl:getDungeonCrisisCrusadeTpl()
  local data = _dungeonCrisisCrusadeTpl:getData()
  local _specialEntrustList = C_MultiTeam.GetLimiteEntrust()
  local specialEntrustMap = {}
  for i = 0, _specialEntrustList.Count - 1 do
    local specialIevelId = _dungeonCrisisCrusadeTpl:getLevelIdByDungeonId(_specialEntrustList[i])
    if specialIevelId and specialIevelId ~= 0 then
      specialEntrustMap[specialIevelId] = 1
    end
  end
  local id, tpl
  for _, v in pairs(data) do
    id = v.id
    tpl = _dungeonCrisisCrusadeTpl:getTplById(id)
    if tpl and _dungeonCrisisCrusadeTpl:getEntrustType(tpl) == L_Const.EntrustTypeEnum.SpecialEntrust and specialEntrustMap[id] ~= nil then
      if self:haveNew(L_ReddotManager.DotDef.EntrustMultiTaskDifficulty, id) then
        kvMap[id] = 1
      else
        kvMap[id] = 0
      end
    end
  end
  return kvMap
end

function this:getDotEntrustTrain()
  local hasRedPoint = AzurWorld.TaskMgr:HasAnyEntrustTrainRedPoint()
  local state = hasRedPoint and 1 or 0
  local kvMap = {
    [1] = state
  }
  return kvMap
end

function this:getDairyDotActivity()
  local activityRewardData1 = L_ActivityTaskStore:getActivityRewardListByIndex(1)
  for i, v in pairs(activityRewardData1) do
    if v.canReward == 1 and v.isFinish == false then
      return 1
    end
  end
  local activityTaskList1 = L_ActivityTaskStore:getActivityTaskGroupByIndex(1)
  for i, v in pairs(activityTaskList1) do
    if v.finishState == 1 then
      return 1
    end
  end
  return 0
end

function this:getWeeklyDotActivity()
  local activityRewardData2 = L_ActivityTaskStore:getActivityRewardListByIndex(2)
  for i, v in pairs(activityRewardData2) do
    if v.canReward == 1 and v.isFinish == false then
      return 1
    end
  end
  local activityTaskList2 = L_ActivityTaskStore:getActivityTaskGroupByIndex(2)
  for i, v in pairs(activityTaskList2) do
    if v.finishState == 1 then
      return 1
    end
  end
  return 0
end

function this:getJourneyTaskDot()
  return this:getNoviceTaskDot()
end

function this:getJourneyNewTaskDot()
  if AzurWorld.RedDotMgr:GetRedDotState(L_ReddotManager.DotDef.JourneyTask, true) then
    return 0
  elseif AzurWorld.RedDotMgr:GetRedDotState(L_ReddotManager.DotDef.JourneyTaskNew, true) then
    return 1
  else
    return 0
  end
end

function this:getNoviceTaskDot()
  if AzurWorld.RedDotMgr:GetRedDotState(L_ReddotManager.DotDef.JourneyTask) then
    return 1
  else
    return 0
  end
end

function this:getNoviceGuideTaskDot()
  return L_NoviceTaskStore:getNoviceTaskRewardNumber(1)
end

function this:getNoviceDuelTaskDot()
  return L_NoviceTaskStore:getNoviceTaskRewardNumber(201)
end

function this:getDotNewTutorialGuide()
  local ids = L_GuideStore:getUnlockGuideDataMapIds()
  local _guideGroupTpl = L_GameTpl:getGuideGroupTpl()
  local kvMap = {}
  for _, id in pairs(ids) do
    local tpl = _guideGroupTpl:getTplById(id)
    local tutorialIds = _guideGroupTpl:getTutorialId(tpl)
    for i, tutorialId in pairs(tutorialIds) do
      if self:haveNew(L_ReddotManager.DotDef.NewTutorialGuide, tutorialId) then
        kvMap[tutorialId] = 1
      end
    end
  end
  return kvMap
end

function this:getDotTitle()
  local kvMap = {}
  for id, conf in pairs(playerTitleTpl.data) do
    if self:haveNew(L_ReddotManager.DotDef.Title, id) then
      kvMap[id] = 1
    end
  end
  self._dirtyList[L_ReddotManager.DotDef.TitleSuf] = true
  self._dirtyList[L_ReddotManager.DotDef.TitlePre] = true
  return kvMap
end

function this:getDotTitlePre()
  for id, conf in pairs(playerTitleTpl.data) do
    if playerTitleTpl:getType(conf) == 1 and self:haveNew(L_ReddotManager.DotDef.Title, id) then
      return 1
    end
  end
  return 0
end

function this:getDotTitleSuf()
  for id, conf in pairs(playerTitleTpl.data) do
    if playerTitleTpl:getType(conf) == 2 and self:haveNew(L_ReddotManager.DotDef.Title, id) then
      return 1
    end
  end
  return 0
end

function this:getTechnologyTypeRedList()
  return L_TechnologyStore:getTechnologyTypeRedList()
end

function this:getDotAnnouncementActive()
  local kvMap = {}
  local ids = C_AnnouncementStore.GetAnnouncementIds()
  local elementCount = ids.Count
  for i = 0, elementCount - 1 do
    local id = ids[i]
    if not L_ReddotManager:haveNew(L_ReddotManager.DotDef.AnnouncementActive, id) then
      kvMap[id] = 1
      kvMap["tab_" .. C_AnnouncementStore.GetAnnouncementTabById(id)] = 1
    end
  end
  return kvMap
end

function this:getDotHomeLevelNew()
  local kvMap = {}
  local allTpl = _homeLevelShowTpl.data
  local curLv = L_PlayerStore:getLv()
  local index = 0
  for i, tpl in pairs(allTpl) do
    local level = _homeLevelShowTpl:getId(tpl)
    index = index + 1
    if curLv >= level and self:haveNew(self.DotDef.LevelUnlockHomeContent, i) then
      kvMap[i] = 1
    end
  end
  return kvMap
end

function this:getPetRankUp()
  local kvMap = {}
  local pets = L_PetStore:getPetList()
  local petRankTpl = L_GameTpl:getPetRankTpl()
  for _, pet in pairs(pets) do
    local rankData = petRankTpl:getchildren(pet.id)
    if not table.isEmpty(rankData) then
      local lackUpCondition = pet.lv < rankData.levelNeed
      local nextStageId = rankData.nextPetId
      if math.isEmpty(nextStageId) then
        lackUpCondition = true
      end
      if not lackUpCondition then
        local item = rankData.rankBreakthroughItem
        for i = 1, #item do
          if not math.isEmpty(item[i][1]) and item[i][3] > L_ItemTplManager:getItemNum(item[i][1], item[i][2]) then
            lackUpCondition = true
          end
        end
      end
      if not lackUpCondition then
        kvMap[pet.guid] = 1
      end
    end
  end
  return kvMap
end

function this:getDotNewEmoji()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.chat) then
    return kvMap
  end
  local emojiOwnedList = L_ChatStore:getEmojiOwnedDic()
  for type, list in pairs(emojiOwnedList) do
    for i, id in ipairs(list) do
      if not self:haveNew(self.DotDef.NewEmoji, id) then
        kvMap[id] = 1
      end
    end
  end
  return kvMap
end

function this:getDotNewEmojiType()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.chat) then
    return kvMap
  end
  local emojiOwnedList = L_ChatStore:getEmojiOwnedDic()
  local emojiTpl = L_GameTpl:getChatEmojiTpl()
  for type, list in pairs(emojiOwnedList) do
    local hasNew = false
    for i, id in ipairs(list) do
      if not self:haveNew(self.DotDef.NewEmoji, id) then
        hasNew = true
        break
      end
    end
    if hasNew then
      kvMap[type] = 1
    end
  end
  return kvMap
end

function this:getDotHeroTalent()
  local kvMap = {}
  return self:dotHeroTalent(kvMap, false, true)
end

function this:getDotHeroTalentMainMenu()
  local kvMap = {}
  return self:dotHeroTalent(kvMap, true, true)
end

function this:dotHeroTalent(kvMap, isMenu, withEquip, heroGuid)
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.heroTalent) then
    return kvMap
  end
  local talentRankTpl = L_GameTpl:getTalentRankTpl()
  local talentRuneTpl = L_GameTpl:getTalentRuneTpl()
  local talentRankRewardTpl = L_GameTpl:getTalentRankReward()
  local configId, guid, rank, rankTpl, runeTpl, runes, allRunes, itemId, heroRank
  local maxRank = 0
  local rewardData
  local posData = isMenu and L_FormationStore:getFormationPosData(L_FormationConst.FormationType.world) or nil
  for _, hero in getTargetHeroIterator(heroGuid) do
    guid = L_HeroStore:getHeroGuid(hero)
    local isOut = false
    if isMenu then
      for i, posGuid in pairs(posData) do
        if not math.isEmpty(guid) and guid == posGuid then
          isOut = true
          break
        end
      end
    end
    heroRank = L_HeroStore:getHeroRank(hero)
    rewardData = talentRankRewardTpl:getSortedData()
    kvMap[guid] = 0
    for _, reward in ipairs(rewardData) do
      if not L_HeroStore:IsRankRewardGetted(hero, reward.level) and heroRank >= reward.level then
        kvMap[guid] = 1
        break
      end
    end
    if isOut or not isMenu then
      configId = L_HeroStore:getHeroConfigId(hero)
      rank = L_HeroStore:getHeroRank(hero)
      runes = L_HeroStore:getHeroRuneIds(hero)
      rankTpl = talentRankTpl:getHeroRankTpl(configId, rank)
      maxRank = talentRankTpl:getHeroMaxRankNum(configId)
      if rankTpl ~= nil then
        allRunes = talentRankTpl:getRankBreakthroughItem(rankTpl)
        if 0 < table.count(allRunes) then
          for k, id in ipairs(allRunes) do
            if withEquip and kvMap[guid] ~= 1 and (table.containsValue(runes, 0) or #runes == 0) and math.isEmpty(runes[k]) then
              local isHadMaterial = L_RuneStore:checkIsCanMaterialByRuneId(id, true)
              if isHadMaterial then
                kvMap[guid] = 1
              end
            end
            if 0 < #runes and not table.containsValue(runes, 0) and rank < maxRank then
              local rankPlus = talentRankTpl:getHeroRankTpl(L_HeroStore:getHeroConfigId(hero), rank + 1)
              local rankLevellimit = talentRankTpl:getRankLevelLimit(rankPlus)
              local level = L_HeroStore:getHeroLevel(hero)
              if rankLevellimit <= level and L_GameUtil.getIsHadItemListNum(talentRankTpl:getRankBreakthroughCoin(rankTpl)) then
                kvMap[guid] = 1
              end
            end
          end
        end
      end
    end
  end
  return kvMap
end

function this:dotHeroTalentAndJewel(heroGuid)
  local kvMap = {}
  self:dotHeroTalent(kvMap, false, false, heroGuid)
  self:dotHeroJewel(kvMap, true, heroGuid)
  self:dotHeroSoulEssence(kvMap, true, heroGuid)
  return kvMap
end

function this:getDotMountNew()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.mount) then
    return kvMap
  end
  local allMount = mountTpl.data
  for _, tpl in pairs(allMount) do
    local mountId = mountTpl:getId(tpl)
    if self:haveNew(self.DotDef.MountNew, mountId) then
      kvMap[mountId] = 1
    end
  end
  return kvMap
end

function this:getDotGameActNew()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local allGameAct = gameEventsTpl:getAllData()
  for _, tpl in pairs(allGameAct) do
    if not math.isEmpty(gameEventsTpl:getShow(tpl)) then
      local actId = gameEventsTpl:getId(tpl)
      local showRed = false
      local GE = L_GameEventStore:getGameEventData(actId)
      if GE == nil then
        break
      end
      if GE and GE.showRedPoint then
        showRed = true
      end
      if self:haveNew(self.DotDef.GameAct_New, actId) or showRed then
        kvMap[actId] = 1
      end
    end
  end
  return kvMap
end

function this:getDotGameSingleActNew()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local allGameAct = gameEventsTpl:getAllData()
  for _, tpl in pairs(allGameAct) do
    if not math.isEmpty(gameEventsTpl:getShow(tpl)) then
      local actId = gameEventsTpl:getId(tpl)
      local GE = L_GameEventStore:getGameEventData(actId)
      GE = GE and GE:getGameEvent()
      if GE and GE:getRedState() or self:haveNew(self.DotDef.GameAct_Single_New, actId) then
        kvMap[actId] = 1
      end
    end
  end
  return kvMap
end

function this:GetDotGameActEventsReward()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local allGroup = gameEventsRewardGroupTpl:getData()
  for _, tpl in pairs(allGroup) do
    local Id = gameEventsRewardGroupTpl:getId(tpl)
    if self:haveNew(self.DotDef.GameAct_New, Id) then
      kvMap[Id] = 1
    end
  end
  return kvMap
end

function this:getDotGameActEventsBattle()
  local kvMap = {}
  local kiboBattleActivityId = 20001
  local data = L_GameEventStore:getGameEventData(kiboBattleActivityId)
  if data and data:isFinishGuideTask() and data:isShow() then
    local allGroup = gameEventsKiboDuelGroupTpl:getData()
    for id, value in pairs(allGroup) do
      if not self:haveNew(L_ReddotManager.DotDef.GameAct_Events_Battle, id) then
        kvMap[id] = 1
      end
    end
  end
  return kvMap
end

function this:getGameEventCommit()
  local _data = L_GameEventStore:getGameEventData(30001)
  local gameTpl = L_GameTpl:getGameeventssubitemTpl()
  local allData = gameTpl:getAllData()
  local playerId = L_PlayerStore:getPlayerId()
  for _, value in pairs(allData) do
    local redKey = string.format("GameActivitySubmitItem_%d_%d_new", value.id, playerId)
    local noMark = C_PlayerPrefsUtility.HasKey(redKey) == false
    local isActive = _data._gameEvent:getIsActiveById(value.id)
    local canSubmit = _data._gameEvent:checkCanSubmitById(value.id)
    if noMark and isActive or canSubmit then
      _data._gameEvent:SetRedState(true)
      return 1
    end
  end
  _data._gameEvent:SetRedState(false)
  return 0
end

function this:getDotGameActEventsInCenter()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local gameEventDatas = L_GameEventStore:getAllGameEventDatas()
  for _, gameEventData in pairs(gameEventDatas) do
    local canParticipateIn = gameEventData:canParticipateIn()
    if canParticipateIn then
      local activityId = gameEventData:getActivityId()
      local gameEventsTpl = _gameEventsTpl:getTplById(activityId)
      local isShowInList = _gameEventsTpl:getShow(gameEventsTpl) == 1
      local isSevenDaySignEvent = _gameEventsTpl:getType(gameEventsTpl) == L_Const.ActivityType.AT_DAILY_SIGN
      if isShowInList or isSevenDaySignEvent then
        local gameEvent = gameEventData:getGameEvent()
        if gameEvent:checkRedDot() then
          kvMap[activityId] = 1
        end
      end
    end
  end
  printf("活动中心，活动内部红点", kvMap)
  return kvMap
end

function this:getDotGameActScenarioPreTask()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local gameEventDatas = L_GameEventStore:getAllGameEventDatas()
  for _, gameEventData in pairs(gameEventDatas) do
    local canParticipateIn = gameEventData:canParticipateIn()
    if canParticipateIn then
      local activityId = gameEventData:getActivityId()
      local tpl = _gameEventsTpl:getTplById(activityId)
      local eType = _gameEventsTpl:getType(tpl)
      if eType == L_Const.ActivityType.AT_GROWUP then
        local gameEvent = gameEventData:getGameEvent()
        if gameEvent and gameEvent.needPreTaskReddot and gameEvent:needPreTaskReddot() then
          kvMap[activityId] = 1
        end
      end
    end
  end
  return kvMap
end

function this:getDotSpiritStory()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.soulEssence) then
    return kvMap
  end
  for _, id in pairs(_soulessenceTpl:getHasStoryIDList()) do
    local isComplete, _, _ = L_ConditionManager:isComplete(_soulessenceTpl:getStoryLock(_soulessenceTpl:getTplById(id)))
    if isComplete and C_SoulEssenceMgr:isSoulessenceStoryPlayed(id) == false then
      kvMap[id] = 1
    end
  end
  return kvMap
end

function this:getDotSpiritBreak()
  local kvMap = {}
  local allSoulEssenceData = C_SoulEssenceMgr:getSoulEssenceMap()
  for key, value in pairs(allSoulEssenceData) do
    local spData = C_SoulEssenceMgr:getsoulessenceItem(key)
    local maxLevel = C_SoulEssenceMgr:getMaxLevelByGuid(key)
    local flag = false
    if maxLevel <= spData.level then
      local maxRank = _soulessenceRankTpl:getMaxRank(spData.soulEssenceId)
      if maxRank > spData.rank then
        flag = true
      end
    end
    if flag == true then
      local rankTpl = _soulessenceRankTpl:getTplByIdAndRank(spData.soulEssenceId, spData.rank)
      local itemList = _soulessenceRankTpl:getRankUpItem(rankTpl)
      local bShow = true
      for i = 1, #itemList do
        local itemId = itemList[i][1]
        local num = itemList[i][2]
        local currNum = C_BagMgr:getItemNumByItemId(itemId)
        if num > currNum then
          bShow = false
          break
        end
      end
      if bShow == true then
        kvMap[key] = 1
      end
    end
  end
  return kvMap
end

function this:getDotAllProduction()
  local kvMap = {}
  local configList = productsTpl:getConfig()
  local foodConfigList = foodGroupTpl:getConfig()
  for _, v in pairs(configList) do
    if v.material and not self:haveNew(L_ReddotManager.DotDef.productionNew, v.id) then
      kvMap[v.id] = 1
    end
  end
  for _, v in pairs(foodConfigList) do
    if not self:haveNew(L_ReddotManager.DotDef.productionNew, v.id) then
      kvMap[string.format("foodGroup_%d", v.id)] = 1
    end
  end
  return kvMap
end

function this:getDotHomeCenterBuildingManageReceiveAllProduction()
  local homeHubWorkingBuildingInfoList = L_HomeStore:getHomeHubWorkingBuildingInfoListByTabType(L_Const.HomeHubTabType.HHTT_PRODUCT)
  for _, homeHubWorkingBuildingInfo in pairs(homeHubWorkingBuildingInfoList) do
    local buildingGuid = homeHubWorkingBuildingInfo.guid
    local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
    local buildingType = L_HomeStore:getHomeBuildingType(csHomeBuildData)
    if buildingType ~= L_Const.WorldMapBuildType.WMBT_HATCH and csHomeBuildData:CanReward() then
      return 1
    end
  end
  return 0
end

function this:getDotHomeCenterBuildingManageReceiveAllCrop()
  local homeHubWorkingBuildingInfoList = L_HomeStore:getHomeHubWorkingBuildingInfoListByTabType(L_Const.HomeHubTabType.HHTT_AUTO_WORK)
  for _, homeHubWorkingBuildingInfo in pairs(homeHubWorkingBuildingInfoList) do
    local buildingGuid = homeHubWorkingBuildingInfo.guid
    local csHomeBuildData = L_HomeStore:getCsHomeBuildDataByGuid(buildingGuid)
    local csRewardList = csHomeBuildData.auto.rewards
    if csRewardList.Count > 0 then
      return 1
    end
  end
  return 0
end

function this:getDotHomeCenterBuildingManageReceiveAllCollection()
  local C_HomeStore = C_HomeManager:GetHomeStore()
  return C_HomeStore.WorldCollectModule.OnHadCanReceiveReward() and 1 or 0
end

function this:getDotEntrustBattleTask()
  local _kiboDuleGroupTpl = L_GameTpl:getKiBoDuelGroupTpl()
  local dataList = _kiboDuleGroupTpl:getValue()
  local kvMap = {}
  for _, data in pairs(dataList) do
    local tpl = _kiboDuleGroupTpl:getTplById(data.id)
    local condition = _kiboDuleGroupTpl:getUnlockCondition(tpl)
    local tmp_lock, results, lockIndex = L_ConditionManager:isComplete(condition)
    local pre_level_id = _kiboDuleGroupTpl:getPreCondition(data.id)
    local is_unlock_pre_level = L_EntrustStore:checkEntrustKiboBattleSuc(pre_level_id)
    if not self:haveNew(L_ReddotManager.DotDef.EntrustBattleTask, data.id) and tmp_lock and is_unlock_pre_level then
      kvMap[data.id] = 1
    else
      kvMap[data.id] = 0
    end
  end
  return kvMap
end

function this:getDotEntrustDoubleReward()
  local activityData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_DOUBLE_DROP)
  if activityData then
    local gameEventData = activityData:getGameEvent()
    if gameEventData then
      local luckstate = gameEventData:getLockState()
      if not luckstate and self:haveDailyNew(L_ReddotManager.DotDef.EntrustDoubleReward) then
        return 1
      end
    end
  end
  return 0
end

function this:getDotEntrustKiboDuelReward()
  local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.PetDuel, 0)
  local firstRewardStarNum, rewardId = L_EntrustStore:getFirstCanReceiveStarNum(L_Const.EntrustTypeEnum.PetDuel, 0)
  local canReceiveReward = curStarNum >= firstRewardStarNum and 0 < rewardId
  return (canReceiveReward or this:kiboBattleActivityRedDot()) and 1 or 0
end

function this:kiboBattleActivityRedDot()
  local kiboBattleActivityId = 20001
  local singleEventRedDot = false
  local data = L_GameEventStore:getGameEventData(kiboBattleActivityId)
  if not data then
    return false
  end
  local gameEvent = data:getGameEvent()
  if gameEvent ~= nil then
    singleEventRedDot = gameEvent:hasRewardNewData(kiboBattleActivityId)
  end
  return singleEventRedDot
end

function this:getDotEntrustStarReward()
  local dungeonEntrustTypeTpl = L_GameTpl:getDungeonEntrustTypeTpl()
  local tpl = dungeonEntrustTypeTpl:getTplById(L_Const.EntrustTypeEnum.AreaEntrust)
  if tpl and dungeonEntrustTypeTpl:getStarRewardIsShow(tpl) == 0 then
    return 0
  end
  local curStarNum = L_EntrustStore:getEntrustStarNumByDifficulty(L_Const.EntrustTypeEnum.AreaEntrust, 1)
  local firstRewardStarNum, rewardId = L_EntrustStore:getFirstCanReceiveStarNum(L_Const.EntrustTypeEnum.AreaEntrust, 1)
  local canReceiveReward = curStarNum >= firstRewardStarNum and 0 < rewardId
  if canReceiveReward then
    return 1
  else
    return 0
  end
end

function this:getDotPlayerHeadMain()
  for i, v in pairs(L_PlayerDisplayStore:getItemListByType(L_Const.playerDressType.head)) do
    if self:haveNew(L_ReddotManager.DotDef.PlayerHeadItem, v.id) then
      return 1
    end
  end
  return 0
end

function this:getDotPlayerHeadFrame()
  for i, v in pairs(L_PlayerDisplayStore:getItemListByType(L_Const.playerDressType.headFrame)) do
    if self:haveNew(L_ReddotManager.DotDef.PlayerHeadItem, v.id) then
      return 1
    end
  end
  return 0
end

function this:getDotPlayerHead()
  local kvMap = {}
  for i, v in pairs(L_PlayerDisplayStore:getItemListByType(L_Const.playerDressType.headFrame)) do
    if self:haveNew(L_ReddotManager.DotDef.PlayerHeadItem, v.id) then
      kvMap[v.id] = 1
    end
  end
  for i, v in pairs(L_PlayerDisplayStore:getItemListByType(L_Const.playerDressType.head)) do
    if self:haveNew(L_ReddotManager.DotDef.PlayerHeadItem, v.id) then
      kvMap[v.id] = 1
    end
  end
  return kvMap
end

function this:getDotGameActRewardTab()
  local kvMap = {}
  local gameEventRewardGroupTpl = L_GameTpl:getGameEventsRewardGroupTpl()
  local data = gameEventRewardGroupTpl:getData()
  if data ~= nil then
    for k, v in pairs(data) do
      kvMap[v.id] = 1
    end
  end
  return kvMap
end

function this:getDotGameActRewardTabGroup()
  local kvMap = {}
  local gameEventTpl = L_GameTpl:getGameEventsTpl()
  local data = gameEventTpl:getAllData()
  for k, v in pairs(data) do
    kvMap[v.id] = 1
  end
  return kvMap
end

function this:getDotGameActKiboBattle()
  local kvMap = {}
  for i, v in pairs(L_GameEventStore.kiboBattleRedConfig) do
    if not self:haveNew(L_ReddotManager.DotDef.GameAct_Events_Kibo_Battle, v) then
      kvMap[v] = 1
    end
  end
  return kvMap
end

function this:getDotGameActKiboTravel()
  local gameEventData = L_GameEventStore:getGameEventData(L_Const.ActivityType.AT_Kibo_Tour_Group)
  local ge = gameEventData:getGameEvent()
  local kvMap = {}
  if ge:getRedState() then
    kvMap[L_GameEventStore.kiboTravelRedConfig[1]] = 1
  end
  return kvMap
end

function this:getkiBoDuelAreaLevelReward()
  local kvMap = {}
  local store = L_PetDuelStore
  local areaInfos = store:getPetDuelAreaInfos()
  local levels, key
  for id, areaInfo in pairs(areaInfos) do
    levels = areaInfo:getCompleteLvls()
    for _, level in ipairs(levels) do
      key = table.concat({id, level}, "_")
      if not self:haveNew(self.DotDef.kiBoDuelAreaLevel_Reward, key) then
        kvMap[key] = 1
      end
    end
  end
  return kvMap
end

function this:getkiBoDuelAreaLevel()
  local sceneId = AzurWorld.areaManager:GetMapSceneId()
  local list = _filterMarkTpl:getTplListByWorldId(sceneId, L_MapConst.mapSievingType.areaLevel)
  local levels, areaType
  for _, tpl in ipairs(list) do
    areaType = _filterMarkTpl:getParam(tpl)
    if areaType and areaType ~= 0 then
      levels = L_PetDuelStore:getAreaCompleteLevel(areaType)
      if 0 < #levels then
        print(string.format("reddotManagerGetFuncs[getkiBoDuelAreaLevel] hasRed, sceneId:%s, areaType:%s", sceneId, areaType))
        return 1
      end
    end
  end
  print(string.format("reddotManagerGetFuncs[getkiBoDuelAreaLevel] not hasRed, sceneId:%s, areaType:%s", sceneId, areaType))
  return 0
end

function this:getkiBoDuelUnlockSkill()
  local kvMap = {}
  local skills = L_PetDuelStore:getUnlockSkills()
  for skillId, id in pairs(skills) do
    if self:haveNew(self.DotDef.kiBoDuel_Skill_New, skillId) then
      kvMap[skillId] = 1
    end
  end
  return kvMap
end

function this:getKiboDuelNewNpc()
  local kvMap = {}
  local list = _filterMarkTpl:getTplListByMarkType(L_MapConst.mapSievingType.kiboDuel)
  local levelId
  for _, tpl in ipairs(list) do
    levelId = _filterMarkTpl:getParam(tpl)
    if levelId and levelId ~= 0 and self:haveNew(self.DotDef.KiboDuel_NPC_New, levelId) then
      kvMap[levelId] = 1
    end
  end
  return kvMap
end

function this:getKiboDuelGroupNew()
  local kvMap = {}
  local list = _filterMarkTpl:getTplListByMarkType(L_MapConst.mapSievingType.kiboduelGroup)
  local groupId
  for _, tpl in ipairs(list) do
    groupId = _filterMarkTpl:getParam(tpl)
    if groupId and groupId ~= 0 and self:haveNew(self.DotDef.KiboDuel_LevelGroup_New, groupId) then
      kvMap[groupId] = 1
    end
  end
  return kvMap
end

function this:getDotIllustratedSoulEssenceNew()
  local weapons = C_SoulEssenceMgr:getSoulEssenceMap()
  local kvMap = {}
  for _, weapon in pairs(weapons) do
    if not self:haveNew(self.DotDef.IllustratedSoulEssence_New, weapon.soulEssenceId) then
      kvMap[weapon.soulEssenceId] = 1
    else
      kvMap[weapon.soulEssenceId] = 0
    end
  end
  return kvMap
end

function this:getHandBookCharacterNew()
  return self:haveNew(self.DotDef.HandBook_Character_New, "") and 1 or 0
end

function this:getShopRed()
  return 0
end

function this:getDotGameActSurveyNew()
  local kiboSurveyActivityId = 7001
  local GameEventTpl = L_GameTpl:getGameEventsTpl()
  local GameEventsKiboSurveyTpl = L_GameTpl:getGameEventsKiboSurveyTpl()
  local tpl = GameEventTpl:getTplById(kiboSurveyActivityId)
  if not tpl then
    return {}
  end
  local systemId = GameEventTpl:getSystemId(tpl)
  local groupData = GameEventsKiboSurveyTpl:getGroupData(systemId)
  local kvMap = {}
  local gameEventData = L_GameEventStore:getGameEventData(kiboSurveyActivityId)
  local gameEvent = gameEventData:getGameEvent()
  if not gameEventData:isShow() then
    return kvMap
  end
  for i, v in ipairs(groupData) do
    if not self:haveNew(self.DotDef.GameAct_Events_Survey_New, v.id) and not gameEvent:getHasAward(v.id) then
      kvMap[v.id] = 1
    end
  end
  return kvMap
end

function this:getDotGameActSurveyAward()
  local kiboSurveyActivityId = 7001
  local GameEventTpl = L_GameTpl:getGameEventsTpl()
  local GameEventsKiboSurveyTpl = L_GameTpl:getGameEventsKiboSurveyTpl()
  local tpl = GameEventTpl:getTplById(kiboSurveyActivityId)
  if not tpl then
    return {}
  end
  local systemId = GameEventTpl:getSystemId(tpl)
  local groupData = GameEventsKiboSurveyTpl:getGroupData(systemId)
  local gameEventData = L_GameEventStore:getGameEventData(kiboSurveyActivityId)
  local gameEvent = gameEventData:getGameEvent()
  local kvMap = {}
  local curDay = gameEventData.curDay
  for i = 1, curDay do
    local id = groupData[i].id
    if gameEvent:getHasAward(id) then
      kvMap[id] = 1
    end
  end
  return kvMap
end

function this:getDotGameActRedungeon()
  local gameEventData = L_GameEventStore:getDataByType(L_Const.ActivityType.AT_REPEAT_EVENT)
  local ge = gameEventData:getGameEvent()
  return ge:getRedState()
end

function this:GetDotGameActEventsPtShop()
  local kvMap = {}
  if not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.gameAct) then
    return kvMap
  end
  local allGameAct = gameEventsTpl:getAllData()
  for _, tpl in pairs(allGameAct) do
    if not math.isEmpty(gameEventsTpl:getShow(tpl)) then
      local actId = gameEventsTpl:getId(tpl)
      local GE = L_GameEventStore:getGameEventData(actId)
      GE = GE and GE:getGameEvent()
      if GE and GE and GE:getPtShopRedState() then
        kvMap[actId] = 1
      end
    end
  end
  return kvMap
end

function this:getPetCatalogDot()
  if L_CatalogStore:checkCanGetReward() then
    return 1
  end
  return 0
end

return this
