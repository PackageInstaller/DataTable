ConfigData = {}
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_GameData = CS.GameData.instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local CampEnum = require("Game.Common.Camp.CampEnum")
local emptyString = ""

local function DefineConfigDataFunc()
  local langInt = CS.LanguageGlobal.GetLanguageInt()
  local item_metatable = ConfigData.item.__basemetatable
  
  function item_metatable.__index:GetHeroResCfg()
    if self.action_type == eItemActionType.HeroCard or self.action_type == eItemActionType.HeroCardFrag then
      local heroId = self.arg[1]
      local heroCfg = ConfigData.hero_data[heroId]
      if heroCfg == nil then
        return heroCfg
      end
      local resCfg = ConfigData.resource_model[heroCfg.src_id]
      return resCfg
    end
    return nil
  end
  
  if langInt ~= eLanguageType.ZH_CN then
    local langStr = "_" .. CS.LanguageGlobal.GetLanguageStr()
    for _, itemId in pairs(ConfigData.item.item_lang_icons) do
      local itemCfg = ConfigData.item[itemId]
      itemCfg.icon = itemCfg.icon .. langStr
    end
  end
  
  function item_metatable.__newindex()
    error("Attempt to modify read-only table")
  end
  
  function ConfigData.hero_data.__basemetatable.__index:GetHeroResCfg()
    local resCfg = ConfigData.resource_model[self.src_id]
    return resCfg
  end
  
  function ConfigData.guide.__basemetatable.__index:GetFirstCondition()
    local firstId = self.step_list[1]
    if firstId == nil then
      return 0
    end
    local stepCfg = ConfigData.guide_step[firstId]
    if stepCfg == nil then
      error("guide step cfg is null,id:" .. tostring(firstId))
      return 0
    end
    return stepCfg.condition, stepCfg.condition_arg
  end
end

function ConfigData:InitConfigData()
  self.DynConfigNum = {}
  DefineConfigDataFunc()
  self.buildinConfig = require("Game.ConfigData.BuildinConfig")
  local campCount = 0
  local otherCount = 0
  for _, camp in ipairs(ConfigData.camp) do
    if not self:IsCampExclude(camp.id) then
      if not self:IsCampBelongOther(camp.id) then
        campCount = campCount + 1
      else
        otherCount = otherCount + 1
      end
    end
  end
  self.game_config.heroMaxCamp = campCount + otherCount
  self.game_config.heroMaxCampWithOther = campCount + 1
  self.game_config.heroMaxCareer = 5
  self.game_config.heroMaxVowed = 2
  self.game_config.heroVowed = 1
end

function ConfigData:GetCampCountWithOther()
  return self.game_config.heroMaxCampWithOther or 0
end

function ConfigData:GetCampMaxCount()
  return self.game_config.heroMaxCamp or 0
end

function ConfigData:IsCampBelongOther(campId)
  local campCfg = ConfigData.camp[campId]
  if campCfg == nil then
    return false
  end
  return campCfg.sort == CampEnum.eSortType.belongOther
end

function ConfigData:IsCampExclude(campId)
  local campCfg = ConfigData.camp[campId]
  if campCfg == nil then
    return false
  end
  return campCfg.exclude == 1
end

function ConfigData:LoadDynCfg(type)
  if ConfigData[type] == nil then
    ConfigData[type] = require("LuaConfigs." .. type)
  end
  self.DynConfigNum[type] = (self.DynConfigNum[type] or 0) + 1
end

function ConfigData:ReleaseDynCfg(type)
  self.DynConfigNum[type] = (self.DynConfigNum[type] or 0) - 1
  if self.DynConfigNum[type] <= 0 then
    ConfigData[type] = nil
    package.loaded["LuaConfigs." .. type] = nil
    self.DynConfigNum[type] = nil
  end
end

function ConfigData:ForceReleaseDynCfg(type)
  ConfigData[type] = nil
  package.loaded["LuaConfigs." .. type] = nil
end

function ConfigData:GetCampFetter(camp, number)
  local fetterList = self.camp_connection.fetterList[camp]
  if fetterList == nil then
    return nil
  end
  for i = #fetterList, 1, -1 do
    local curNum = fetterList[i]
    if number >= curNum then
      return self.camp_connection[camp][curNum]
    end
  end
  return nil
end

function ConfigData:GetCareerIcon(career)
  local careerCfg = self.career[career]
  if careerCfg == nil then
    return nil
  end
  return careerCfg.icon
end

function ConfigData:GetCampIcon(camp)
  local campCfg = self.camp[camp]
  if campCfg == nil then
    return nil
  end
  return campCfg.icon
end

function ConfigData:GetAudioCategoryCfg(id)
  local cfg = self.audio_category[id]
  if cfg == nil then
    error("Can't find audio_category, id = " .. tostring(id))
    return
  end
  return cfg.category, cfg.aisac
end

local function eVoicePointTypeFunc(normalCfg, normalList, specialCfg, specialList, key)
  normalList = normalCfg[key]
  if specialCfg then
    specialList = specialCfg[key]
  end
  return specialList, normalList
end

local eVoicePointTypeKey = {
  [eVoicePointType.EnterHome] = "vo_main",
  [eVoicePointType.WaitInHome] = "vo_afk",
  [eVoicePointType.EnterTeam] = "vo_formation",
  [eVoicePointType.StartBattle] = "vo_battle",
  [eVoicePointType.MVP] = "vo_mvp",
  [eVoicePointType.InFactory] = "vo_duty",
  [eVoicePointType.HellowDrom] = "vo_dormgreet",
  [eVoicePointType.PicClick] = "vo_interact",
  [eVoicePointType.ultSkill] = "vo_ultSkill",
  [eVoicePointType.levelup] = "vo_levelup",
  [eVoicePointType.rankup] = "vo_rankup",
  [eVoicePointType.title] = "vo_title"
}

function ConfigData:GetVoListByPointId(heroId, voPointId)
  local cfgList = self.audio_voice_point
  local specialCfg, specialList
  if heroId and cfgList[heroId] then
    specialCfg = cfgList[heroId]
  else
    specialList = table.emptytable
  end
  local normalCfg = cfgList[0]
  local normalList
  if eVoicePointTypeKey[voPointId] == nil then
    error("Can't get audio_voice_point cfg, voPointId = " .. tostring(voPointId))
    return nil
  else
    specialList, normalList = eVoicePointTypeFunc(normalCfg, normalList, specialCfg, specialList, eVoicePointTypeKey[voPointId])
  end
  local realList = {}
  table.insertto(realList, specialList, 0)
  table.insertto(realList, normalList, 0)
  return realList
end

function ConfigData:GetVoicePointRandom(voPointId, excludeVoiceId, heroId)
  local vo_list = self:GetVoListByPointId(heroId, voPointId)
  if self.lastAllHeroVoiceIdDic == nil then
    self.lastAllHeroVoiceIdDic = {}
  end
  if heroId then
    if self.lastAllHeroVoiceIdDic[heroId] == nil then
      self.lastAllHeroVoiceIdDic[heroId] = {}
    end
    if excludeVoiceId == nil or excludeVoiceId == 0 then
      excludeVoiceId = self.lastAllHeroVoiceIdDic[heroId][voPointId]
    end
  end
  local voiceId = self:GetRandomExcludeSpecify(vo_list, excludeVoiceId)
  if heroId then
    self.lastAllHeroVoiceIdDic[heroId][voPointId] = voiceId
  end
  return voiceId
end

function ConfigData:GetRandomExcludeSpecify(list, excludeSpecify)
  if #list == 1 then
    return list[1]
  end
  math.randomseed(os.time())
  local index = math.random(#list)
  local item = list[index]
  if excludeSpecify == nil then
    return item
  end
  if item ~= excludeSpecify then
    return item
  end
  if index >= #list then
    item = list[1]
  else
    item = list[index + 1]
  end
  return item
end

function ConfigData:GetUnLockFriendShipCvIds(heroId, heroData)
  if heroData == nil then
    return
  end
  local friendship_awardCfg = self.friendship_award[heroId]
  if friendship_awardCfg == nil then
    return
  end
  local cvIds
  for fsLevel, friendshipcCfg in pairs(friendship_awardCfg) do
    if friendshipcCfg.is_audio and heroData:IsArchiveUnlocked(fsLevel) then
      for cvId, voiceCfg in pairs(self.audio_voice) do
        if voiceCfg.name == friendshipcCfg.open then
          if cvIds == nil then
            cvIds = {}
          end
          table.insert(cvIds, cvId)
        end
      end
    end
  end
  return cvIds
end

function ConfigData:GetAttribute(attrId, value)
  local cfg = self.attribute[attrId]
  if cfg == nil then
    error("Can't find attribute, id = " .. tostring(attrId))
    return
  end
  local name = LanguageUtil.GetLocaleText(cfg.name)
  local valueStr
  if value ~= nil then
    if type(value) == "table" then
      valueStr = {}
      for index, val in ipairs(value) do
        if cfg.num_type == 1 then
          valueStr[index] = tostring(val)
        else
          valueStr[index] = tostring(FormatNum(val / 10)) .. "%"
        end
      end
    elseif type(value) == "number" then
      if cfg.num_type == 1 then
        valueStr = tostring(value)
      else
        valueStr = tostring(FormatNum(value / 10)) .. "%"
      end
    end
  end
  return name, valueStr, cfg.icon
end

function ConfigData.GetFormulaValue(formulaId, tab)
  local cfg = ConfigData.attr_combat[formulaId]
  if cfg == nil or cfg.formula == nil or cfg.formula == "" then
    error("Cant get attr_combat.formula, formulaId = " .. tostring(formulaId))
    return 0
  end
  local formulaFunc = cfg.formula
  if type(formulaFunc) ~= "function" then
    formulaFunc = load("return function(tab) return " .. formulaFunc .. " end")()
    cfg.formula = formulaFunc
  end
  local power = formulaFunc(tab)
  return power
end

function ConfigData:GetAddictionCfg(age)
  local cfg
  for _, ageRange in ipairs(self.anti_addiction.id_sort_list) do
    if age < ageRange then
      cfg = self.anti_addiction[ageRange]
      break
    end
  end
  return cfg
end

function ConfigData:GetTipContent(id, ...)
  if type(id) ~= "number" then
    id = 1
  end
  local tipCfg = ConfigData.tip_language[id]
  if tipCfg == nil then
    return LanguageUtil.GetLocaleText(ConfigData.tip_language[1].content)
  end
  if select("#", ...) > 0 then
    return string.format(LanguageUtil.GetLocaleText(tipCfg.content), ...)
  end
  return LanguageUtil.GetLocaleText(tipCfg.content)
end

function ConfigData:GetTipTag(tagTypeId, tagIndexId)
  if type(tagTypeId) ~= "number" then
    return LanguageUtil.GetLocaleText(ConfigData.tip_language[1].content)
  end
  local tipTagCfg = ConfigData.label_text.tipTagDic[tagTypeId]
  if tipTagCfg == nil or tipTagCfg[tagIndexId] == nil then
    return LanguageUtil.GetLocaleText(ConfigData.tip_language[1].content)
  end
  return LanguageUtil.GetLocaleText(tipTagCfg[tagIndexId])
end

function ConfigData.LoadLocalText()
  if package.loaded[ConfigData.locale_text] ~= nil then
    package.loaded[ConfigData.locale_text] = nil
  end
  local ConfigDataLoader = require("Game.ConfigData.ConfigDataLoader")
  local fileName = CS.GlobalRegister.IsLocalTextDebug() and "locale_text_debug" or "locale_text"
  ConfigData.locale_text = require(ConfigDataLoader.LoadConfigHead .. fileName)
end

function ConfigData:GetFormationHeroCount()
  local count = ConfigData.game_config.max_stage_hero
  for i = 1, ConfigData.game_config.max_bench_hero do
    local sysFuncId = proto_csmsg_SystemFunctionID["SystemFunctionID_bench" .. tostring(i)]
    local unlock = FunctionUnlockMgr:ValidateUnlock(sysFuncId)
    if unlock then
      count = count + 1
    end
  end
  return count
end

function ConfigData:IsManualOpenGiftItem(itemCfg)
  if itemCfg == nil then
    return false
  end
  if self.__GiftItemActionType == nil then
    self.__GiftItemActionType = {
      [proto_csmsg_ItemActionType.ItemActionTypeFixedItem] = true,
      [proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift] = true,
      [proto_csmsg_ItemActionType.ItemActionTypeRandomReward] = true,
      [proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceGift2] = true,
      [proto_csmsg_ItemActionType.ItemActionTypeRadioChoiceBpSkin] = true,
      [proto_csmsg_ItemActionType.ItemActionTypeMultChoiceNoDup] = true
    }
  end
  local action_type = itemCfg.action_type
  return self.__GiftItemActionType[action_type] or false
end

function ConfigData:IsManualOpenItem(itemCfg)
  return 0 < (itemCfg.available or 0)
end

function ConfigData:IsAutoUseGift(itemCfg)
  return (itemCfg.available or 0) == 2
end

function ConfigData:IsRewardNotShowATH(itemCfg)
  local id = itemCfg.id
  local isAthItemOrAutoUseAthGift = itemCfg.type == eItemType.Arithmetic or ConfigData.item.athGiftDic[id] ~= nil and self:IsAutoUseGift(itemCfg)
  return isAthItemOrAutoUseAthGift
end

function ConfigData:GetChipDescriptionById(chipId, num, isShowDetail)
  local showDetail = isShowDetail == nil or isShowDetail == true
  local description = ""
  local chipCfg = ConfigData.chip[chipId]
  if chipCfg == nil then
    error("Can't find chip cfg, id = " .. tostring(chipId))
    return description
  end
  if #chipCfg.skill_list > 0 then
    local skillId = chipCfg.skill_list[1]
    local skillCfg = cs_GameData.listBattleSkillDatas:GetDataById(skillId)
    if skillCfg == nil then
      error("Can't find skillCfg, id = " .. tostring(skillId))
      return description
    end
    description = skillCfg:GetLevelDescribe(num, false, showDetail)
  elseif 0 < #chipCfg.attribute_id then
    local attrInfo = BattleUtil.GetChipAttrInfo(chipCfg.attribute_id, chipCfg.attribute_initial, chipCfg.level_increase, num)
    description = ConfigData:GetChipinfluenceIntro(chipCfg.id, attrInfo)
  end
  return description
end

function ConfigData:GetChipinfluenceIntro(chipId, extraInfo)
  local chipCfg = ConfigData.chip[chipId]
  if chipCfg == nil then
    return ""
  end
  local introCfg1 = ConfigData.chip_intro[chipCfg.influence]
  if introCfg1 == nil then
    return ""
  end
  local intro_type = ConfigData.chip_intro.influence_type[chipCfg.influence]
  local content = ""
  if intro_type == 0 then
    local introCfg2 = introCfg1[chipCfg.arg]
    if introCfg2 ~= nil then
      content = string.format(LanguageUtil.GetLocaleText(introCfg2.intro), extraInfo)
    end
  elseif intro_type == 1 then
    local careerCfg = ConfigData.career[chipCfg.arg]
    local introCfg2 = introCfg1[0]
    if careerCfg ~= nil and introCfg2 ~= nil then
      content = string.format(LanguageUtil.GetLocaleText(introCfg2.intro), LanguageUtil.GetLocaleText(careerCfg.name), extraInfo)
    end
  elseif intro_type == 2 then
    local campCfg = ConfigData.camp[chipCfg.arg]
    local introCfg2 = introCfg1[0]
    if campCfg ~= nil and introCfg2 ~= nil then
      content = string.format(LanguageUtil.GetLocaleText(introCfg2.intro), LanguageUtil.GetLocaleText(campCfg.name), extraInfo)
    end
  elseif intro_type == 3 then
    local roleCfg = ConfigData.hero_data[chipCfg.arg]
    local introCfg2 = introCfg1[0]
    if roleCfg == nil then
      roleCfg = ConfigData.monster[chipCfg.arg]
    end
    if roleCfg ~= nil and introCfg2 ~= nil then
      content = string.format(LanguageUtil.GetLocaleText(introCfg2.intro), LanguageUtil.GetLocaleText(roleCfg.name), extraInfo)
    end
  end
  return content
end

function ConfigData:GetChipQuality(count)
  if count <= 0 then
    return eItemQualityType.Blue
  end
  return eChipLevelToQaulity[count] or eItemQualityType.Orange
end

function ConfigData:GetChipQualityColor(count)
  return ItemQualityColor[ConfigData:GetChipQuality(count)]
end

function ConfigData:GetItemType(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    return 0
  end
  return itemCfg.type
end

function ConfigData:GetItemName(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    return ""
  end
  return LanguageUtil.GetLocaleText(itemCfg.name)
end

function ConfigData:CalculateEpChipSalePrice(epRoomId, chipLvl, chipPrice, dynPlayer)
  local shopCfg = ConfigData.exploration_shop[epRoomId]
  if shopCfg == nil then
    error("exploration shop is null,id:" .. tostring(epRoomId))
    return 0
  end
  local levels = shopCfg.discount_level
  local disCount = shopCfg.discount_scale
  local levelCount = #levels
  if dynPlayer ~= nil then
    local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
    local scaleNum = dynPlayer:GetSpecificBuffLogicPerPara(ExplorationEnum.eBuffLogicId.sealChipScale)
    if scaleNum ~= nil and scaleNum ~= 0 then
      return math.floor(chipPrice * (scaleNum / 100))
    end
  end
  if levelCount <= 0 then
    return chipPrice
  end
  local index = 1
  for i = 1, levelCount do
    if levels[i] < 0 then
      index = i
      break
    end
    if chipLvl <= levels[i] then
      index = i
      break
    end
  end
  return chipPrice * disCount[index] // 1000
end

function ConfigData:CalculateEpChipDiscardSalePrice(discardId, chipLvl, chipPrice, dynPlayer)
  local discardCfg = ConfigData.exploration_discard[discardId]
  if discardCfg == nil then
    error("exploration discard cfg is null,id:" .. tostring(discardId))
    return 0
  end
  local levels = discardCfg.discard_level
  local disCount = discardCfg.discard_scaleValues
  local levelCount = #levels
  if dynPlayer ~= nil then
    local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
    local scaleNum = dynPlayer:GetSpecificBuffLogicPerPara(ExplorationEnum.eBuffLogicId.sealChipScale)
    if scaleNum ~= nil and scaleNum ~= 0 then
      return math.floor(chipPrice * (scaleNum / 100))
    end
  end
  if levelCount <= 0 then
    return chipPrice
  end
  local index = 1
  for i = 1, levelCount do
    if levels[i] < 0 then
      index = i
      break
    end
    if chipLvl <= levels[i] then
      index = i
      break
    end
  end
  return chipPrice * disCount[index] // 1000
end

function ConfigData:CalculateEpChipUpgradePrice(epRoomId, refreshTimes)
  local refreshTimeCfg = ConfigData.event_upgrade[epRoomId].refresh_times
  local price = ConfigData.event_upgrade[epRoomId].prices
  return self:CalculatePriceGeneralFunc(refreshTimes, refreshTimeCfg, price)
end

function ConfigData:CalculatePriceGeneralFunc(currentTime, cfgTimes, cfgPrices)
  local currentTime = currentTime + 1
  local refreshTimeCfgCount = #cfgTimes
  for i = 1, refreshTimeCfgCount do
    if i <= 1 then
      if currentTime <= cfgTimes[1] then
        return cfgPrices[1]
      end
    elseif i >= refreshTimeCfgCount then
      if currentTime > cfgTimes[i - 1] then
        return cfgPrices[refreshTimeCfgCount]
      end
    elseif currentTime > cfgTimes[i - 1] and currentTime <= cfgTimes[i] then
      return cfgPrices[i]
    end
  end
  return cfgPrices[refreshTimeCfgCount]
end

function ConfigData:GetPerformanceTypeinfoByName(name)
  local id = ConfigData.performance_typeinfo.name_index[name]
  if id == nil then
    error("performance_typeinfo cfg is null,name:" .. tostring(name))
    return nil
  end
  local typeinfoCfg = ConfigData.performance_typeinfo[id]
  if typeinfoCfg == nil then
    error("performance_typeinfo cfg is null,id:" .. tostring(id))
  end
  return typeinfoCfg
end

function ConfigData:GetResModelCfg(id)
  return ConfigData.resource_model[id]
end

function ConfigData:GetResNameByHeroId(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("[GetResNameByHeroId] hero cfg is null,id:" .. tostring(heroId))
    return ""
  end
  local resModelCfg = ConfigData.resource_model[heroCfg.src_id]
  if resModelCfg == nil then
    error("[GetResNameByHeroId] resource_model cfg is null,id:" .. tostring(heroCfg.src_id))
    return ""
  end
  return resModelCfg.res_Name
end

function ConfigData:GetSectorIdShow(sectorId)
  if sectorId == SectorEnum.NewbeeSectorId then
    return 0, false
  end
  local convertId = ConfigData.sector.sector_show_convert[sectorId]
  if convertId ~= nil then
    return convertId, true
  end
  return sectorId, false
end

function ConfigData:GetSectorStageName(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    error("Cant get sector_stage cfg, stageId = " .. tostring(stageId))
    return
  end
  local sectorCfg = ConfigData.sector[stageCfg.sector]
  local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
  local showSectorId = ConfigData:GetSectorIdShow(stageCfg.sector)
  local sectorNum = stageCfg.num
  local diffstr
  local difficult = stageCfg.difficulty
  if difficult == ExplorationEnum.eDifficultType.Normal then
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
  elseif difficult == ExplorationEnum.eDifficultType.Hard then
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
  else
    diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
  end
  local content = string.format("%s %s-%s(%s)", sectorName, showSectorId, sectorNum, diffstr)
  return content
end

function ConfigData:GetSectorName(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg ~= nil then
    return LanguageUtil.GetLocaleText(sectorCfg.name)
  end
  return nil
end

function ConfigData:GetSectorInfoMsg(sectorId, stageIndex, difficultyId, stageId)
  local sectorCfg = ConfigData.sector[sectorId]
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg ~= nil and not string.IsNullOrEmpty(stageCfg.exTitleName) then
    return LanguageUtil.GetLocaleText(sectorCfg.name) .. " " .. stageCfg.exTitleName
  end
  local msg, str
  if ConfigData.sector.onlyShowStageIdSectorDic[sectorId] then
    str = ConfigData:GetTipContent(13006)
    msg = string.format(str, LanguageUtil.GetLocaleText(sectorCfg.name), stageIndex)
    return msg
  end
  if ConfigData.sector.onlyShowNameSectorDic[sectorId] then
    local sectorCfg = ConfigData.sector[sectorId]
    msg = LanguageUtil.GetLocaleText(sectorCfg.name)
    return msg
  end
  local sectorActCoverCfg = ConfigData.sector_act_des_cover[sectorId]
  local isConvert
  sectorId, isConvert = ConfigData:GetSectorIdShow(sectorId)
  if sectorActCoverCfg and sectorActCoverCfg.act_tip_long[difficultyId] ~= 0 and sectorActCoverCfg.normal_tip_long[difficultyId] ~= 0 then
    local actType, actId, actData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
    local tipId = sectorActCoverCfg.normal_tip_long[difficultyId]
    if actData and not actData:IsActivityRunningTimeout() then
      tipId = sectorActCoverCfg.act_tip_long[difficultyId]
    end
    str = ConfigData:GetTipContent(tipId)
    msg = string.format(str, sectorId, stageIndex)
    return msg
  end
  if ConfigData.sector[sectorId] ~= nil then
    local courseDes = ConfigData.sector[sectorId].course_des
    if courseDes ~= emptyString then
      return LanguageUtil.GetLocaleText(courseDes)
    end
  end
  local str = difficultyId == 1 and ConfigData:GetTipContent(13000) or ConfigData:GetTipContent(13001)
  msg = string.format(str, sectorId, stageIndex)
  return msg
end

function ConfigData:GetChallengeInfoMsg(moduleId)
  local msg
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge then
    msg = ConfigData:GetTipContent(13004)
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    msg = ConfigData:GetTipContent(13005)
  end
  return msg
end

function ConfigData:GetEndlessInfoMsg(sectorCfg, depth)
  return string.format(ConfigData:GetTipContent(13002), LanguageUtil.GetLocaleText(sectorCfg.name), depth)
end

function ConfigData:GetTalentStage(level)
  if (level or 0) == 0 then
    return 1, ConfigData:GetTipContent(ConfigData.game_config.heroTalentLevelDesbrices[1])
  end
  local stage = #ConfigData.game_config.heroTalentLevelSplit
  for index, limit in ipairs(ConfigData.game_config.heroTalentLevelSplit) do
    if level < limit then
      stage = index
      break
    end
  end
  return stage, ConfigData:GetTipContent(ConfigData.game_config.heroTalentLevelDesbrices[stage])
end

function ConfigData:GetAdjPresetHeroCount(teamId)
  if ConfigData.game_config.adjCustomMultDic[teamId] ~= nil then
    return 2
  end
  return 1
end

function ConfigData:GetHeroNameById(heroId)
  local heroCfg = ConfigData.hero_data[heroId]
  if heroCfg == nil then
    error("heroCfg is nil ,id is" .. tostring(heroId))
    return nil
  end
  return LanguageUtil.GetLocaleText(heroCfg.name)
end

function ConfigData:GetFixedCstSkillsExp(stageId)
  if stageId == nil then
    return false
  end
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil or #sectorStageCfg.const_cstIds == 0 then
    return false
  end
  return true, sectorStageCfg.const_cstIds, sectorStageCfg.const_cstIdPosDic
end

function ConfigData:GetFixedCstSkillsDun(dungenId)
  if dungenId == nil then
    return false
  end
  local dungeonCfg = ConfigData.battle_dungeon[dungenId]
  if dungeonCfg == nil or #dungeonCfg.const_cstIds == 0 then
    return false
  end
  return true, dungeonCfg.const_cstIds, dungeonCfg.const_cstIdPosDic
end

function ConfigData:SetSpecailPayCfg(currencySymbol, priceDic)
  self._payCurrencySymbol = currencySymbol
  self._payPriceDic = priceDic
end

function ConfigData:TryGetSpecailPayPrice(sdkId)
  if self._payPriceDic == nil then
    return
  end
  return self._payPriceDic[sdkId]
end

function ConfigData:TryGetSpecailPayCurrencySymbol()
  return self._payCurrencySymbol
end

function ConfigData:GetSkillMovieBySkin(movieName, skinId)
  if skinId == 0 then
    return movieName
  end
  local skinCfg = ConfigData.skin[skinId]
  if skinCfg == nil or not skinCfg.has_skill_movie then
    return movieName
  end
  return movieName .. "_" .. skinCfg.src_id_pic
end

function ConfigData:GetCanByLimitGoodByShopId(shopId)
  local cfg = self.shop[shopId]
  if not cfg then
    return false
  end
  return cfg.is_max_limit
end

function ConfigData:GetHeroIdByItem(itemId)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get item, itemId:" .. tostring(itemId))
    return
  end
  if itemCfg.action_type == eItemActionType.HeroCard then
    local heroId = itemCfg.arg[1]
    return heroId
  end
  return nil
end
