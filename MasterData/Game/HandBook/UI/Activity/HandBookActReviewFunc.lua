local eActivityType = require("Game.ActivityFrame.ActivityFrameEnum").eActivityType
local CommonPoltReviewData = require("Game.CommonUI.PlotReview.CommonPoltReviewData")
local CommonPoltReviewGroupData = require("Game.CommonUI.PlotReview.CommonPoltReviewGroupData")
local SectorEnum = require("Game.Sector.SectorEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local _, _, CheckerExtra = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local emptyString = ""

local function __CreateAvgItem(CPRData, avgCfg, avgPlayCtrl, overrideAvgCheck, isBlockCommonCheck, overrideUnlockDesFunc)
  local avgId = avgCfg.id
  local groupENName = string.format(SectorEnum.SectorAvgItemDesc[SectorEnum.eSectorLevelItemType.Normal], tostring(avgCfg.number))
  local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
  local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {avgId})
  local overrideCheckResult = overrideAvgCheck ~= nil and overrideAvgCheck(avgId)
  local commonCheckResult = avgPlayCtrl:IsAvgUnlock(avgId) or avgPlayCtrl:IsAvgPlayed(avgId)
  local isUnlock = false
  if isBlockCommonCheck then
    isUnlock = overrideCheckResult
  else
    isUnlock = overrideCheckResult or commonCheckResult
  end
  if isUnlock then
    CPRGroupData:SetAvgGroupDataIsUnlock(true)
    CPRData:AddAvgGroup(CPRGroupData)
    return true
  end
  local unlockDes
  if overrideUnlockDesFunc ~= nil then
    unlockDes = overrideUnlockDesFunc(avgId)
  elseif CheckerExtra.IsHasActivityChecker(avgCfg.pre_condition) then
    unlockDes = ConfigData:GetTipContent(8305)
  else
    local str1, str2
    str1 = groupName
    str2 = groupENName
    local stageId = ControllerManager:GetController(ControllerTypeId.AvgPlay):GetPreUnlockSectorStage(avgId)
    if stageId ~= nil then
      local stageCfg = ConfigData.sector_stage[stageId]
      if stageCfg ~= nil then
        str2 = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
        local sectorCfg = ConfigData.sector[stageCfg.sector]
        str1 = LanguageUtil.GetLocaleText(sectorCfg.name)
      end
    end
    unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), str1, str2)
  end
  CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
  CPRData:AddAvgGroup(CPRGroupData)
  return false
end

local function __CreateStageItem(CPRData, stageId, stageAvgList, overrideStageCheck)
  local stageCfg = ConfigData.sector_stage[stageId]
  local sectorCfg = ConfigData.sector[stageCfg.sector]
  local groupENName = string.format(SectorEnum.SectorLevelItemDesc[SectorEnum.eSectorLevelItemType.OnlyNumber], tostring(stageCfg.num))
  local groupName = LanguageUtil.GetLocaleText(stageCfg.name)
  local groupDes = LanguageUtil.GetLocaleText(stageCfg.story_review_introduce)
  local sectorName = LanguageUtil.GetLocaleText(sectorCfg.name)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, stageAvgList)
  local isUnlock = overrideStageCheck ~= nil and overrideStageCheck(stageId) or PlayerDataCenter.sectorStage:IsStageComplete(stageId)
  if isUnlock then
    CPRGroupData:SetAvgGroupDataIsUnlock(true)
    CPRData:AddAvgGroup(CPRGroupData)
    return true
  end
  local unlockDes
  if CheckerExtra.IsHasActivityChecker(stageCfg.pre_condition) then
    unlockDes = ConfigData:GetTipContent(8305)
  else
    unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7304)), sectorName, groupENName)
  end
  CPRGroupData:SetAvgGroupDataIsUnlock(false, unlockDes)
  CPRData:AddAvgGroup(CPRGroupData)
  return false
end

local function SeekAvgGroupInSector(CPRData, sectorStageCfg, overrideAvgCheck, overrideStageCheck)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local totalCount = 0
  local unLockCount = 0
  for _, stageId in ipairs(sectorStageCfg) do
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(CPRData, avgCfg, avgPlayCtrl, overrideAvgCheck) then
          unLockCount = unLockCount + 1
        end
      end
    end
    local stageAvgList = ConfigData.story_avg.stageAvgDic[stageId]
    if stageAvgList ~= nil then
      totalCount = totalCount + 1
      if __CreateStageItem(CPRData, stageId, stageAvgList, overrideStageCheck) then
        unLockCount = unLockCount + 1
      end
    end
    local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
    for i = 0, para2num - 1 do
      local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(CPRData, avgCfg, avgPlayCtrl, overrideAvgCheck) then
          unLockCount = unLockCount + 1
        end
      end
    end
  end
  return totalCount, unLockCount
end

local function SeekAvgGroupInAvgIds(CPRData, avgIds, overrideAvgCheck, isBlockCommonCheck, overrideUnlockDesFunc)
  local totalCount = 0
  local unLockCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  if avgIds ~= nil then
    for i, avgId in ipairs(avgIds) do
      local avgCfg = ConfigData.story_avg[avgId]
      if avgCfg ~= nil then
        totalCount = totalCount + 1
        if __CreateAvgItem(CPRData, avgCfg, avgPlayCtrl, overrideAvgCheck, isBlockCommonCheck, overrideUnlockDesFunc) then
          unLockCount = unLockCount + 1
        end
      end
    end
  end
  return totalCount, unLockCount
end

local function SeekAvgGroupInSectorWithoutStage(CPRData, sectorId, overrideAvgCheck)
  local avgIds = ConfigData.story_avg.sectorAvgDic[sectorId]
  return SeekAvgGroupInAvgIds(CPRData, avgIds, overrideAvgCheck)
end

local function GenCPRDataWithFirstAvgInAct(CPRData, avgId, useUnlock)
  local firstAvg = ConfigData.story_avg[avgId]
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local groupENName = LanguageUtil.GetLocaleText(firstAvg.name)
  local groupName = LanguageUtil.GetLocaleText(firstAvg.name)
  local groupDes = LanguageUtil.GetLocaleText(firstAvg.story_review_describe)
  local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {
    firstAvg.id
  })
  local isFirstUnlock = avgPlayCtrl:IsAvgPlayed(firstAvg.id) or useUnlock and avgPlayCtrl:IsAvgUnlock(firstAvg.id)
  local unlockDes = ConfigData:GetTipContent(8305)
  CPRGroupData:SetAvgGroupDataIsUnlock(isFirstUnlock, unlockDes)
  CPRData:AddAvgGroup(CPRGroupData)
  return 1, isFirstUnlock and 1 or 0
end

local HandBookActReviewFunc = {
  [eActivityType.SectorI] = function(actId)
    local timeLimitCfg = ConfigData.activity_time_limit[actId]
    if timeLimitCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    CPRData:SetCPRBgResAllScreen(true)
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, timeLimitCfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local sectorId = timeLimitCfg.easy_stage
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.SectorII] = function(actId)
    local winterCfg = ConfigData.activity_winter[actId]
    if winterCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    CPRData:SetCPRBgResAllScreen(true)
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, winterCfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local sectorId = winterCfg.main_sector
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    local storyExtrCfgDic = ConfigData.activity_winter_sector_story_extra[sectorId]
    if storyExtrCfgDic ~= nil then
      for story_id, cfg in pairs(storyExtrCfgDic) do
        if cfg.is_isolated then
          local avgCfg = ConfigData.story_avg[story_id]
          if avgCfg ~= nil then
            local avgTotal, avgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, story_id)
            totalCount = totalCount + avgTotal
            unlockCount = unlockCount + avgUnlock
          end
        end
      end
    end
    local techTypeId = winterCfg.activity_tech_type
    local techRowIdDic = ConfigData.activity_tech.actTechTypeList[techTypeId].techRowIdDic
    local lineList = {}
    for lineId, _ in pairs(techRowIdDic) do
      table.insert(lineList, lineId)
    end
    table.sort(lineList)
    for _, lineId in ipairs(lineList) do
      local techAvgCfg = ConfigData.activity_tech_line[lineId]
      local avgCfg = ConfigData.story_avg[techAvgCfg.story_id]
      if avgCfg ~= nil then
        local groupENName = LanguageUtil.GetLocaleText(avgCfg.name)
        local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
        local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
        local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, {
          avgCfg.id
        })
        totalCount = totalCount + 1
        local isFirstUnlock = avgPlayCtrl:IsAvgUnlock(avgCfg.id)
        unlockCount = isFirstUnlock and unlockCount + 1 or unlockCount
        local unlockDes = ConfigData:GetTipContent(8305)
        CPRGroupData:SetAvgGroupDataIsUnlock(isFirstUnlock, unlockDes)
        CPRData:AddAvgGroup(CPRGroupData)
      end
    end
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.Carnival] = function(actId)
    local carnivalCfg = ConfigData.activity_carnival[actId]
    if carnivalCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    CPRData:SetCPRBgResAllScreen(true)
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, carnivalCfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local sectorId = carnivalCfg.story_stage
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.RefreshDun] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon)
    local refreshDunCfg = ConfigData.activity_refresh_dungeon[actId]
    if refreshDunCfg == nil then
      ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon)
      return
    end
    ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
    ConfigData:LoadDynCfg(eDynConfigData.activity_refresh_dungeon_dun)
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    CPRData:SetCPRBgResName(refreshDunCfg.pic, false)
    CPRData:SetCPRTitleName(LanguageUtil.GetLocaleText(refreshDunCfg.avg_name))
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, refreshDunCfg.activity_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    for heroId, dunHeroCfg in pairs(ConfigData.activity_refresh_dungeon_hero) do
      totalCount = totalCount + 1
      local avgCfg = ConfigData.story_avg[dunHeroCfg.avg_id]
      local played = avgPlayCtrl:IsAvgPlayed(avgCfg.id)
      local groupName = LanguageUtil.GetLocaleText(avgCfg.name)
      local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
      local CPRGroupData = CommonPoltReviewGroupData.New(groupName, groupName, groupDes, {
        avgCfg.id
      })
      if played then
        unlockCount = unlockCount + 1
        CPRGroupData:SetAvgGroupDataIsUnlock(played)
      else
        local heroCfg = ConfigData.hero_data[heroId]
        local heroName = LanguageUtil.GetLocaleText(heroCfg.name)
        local unlockDes = string.format(LanguageUtil.GetLocaleText(ConfigData:GetTipContent(7303)), heroName)
        CPRGroupData:SetAvgGroupDataIsUnlock(played, unlockDes)
      end
      CPRData:AddAvgGroup(CPRGroupData)
    end
    local finishAvgTotal, finishAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, refreshDunCfg.finish_avg)
    totalCount = totalCount + finishAvgTotal
    unlockCount = unlockCount + finishAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon_hero)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_refresh_dungeon_dun)
    return CPRData
  end,
  [eActivityType.HistoryTinyGame] = function(actId)
    local cfg = ConfigData.activity_tiny_game_main[actId]
    if cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local group = {}
    local avgPreCondMapping = {}
    local avgPreGroup = ConfigData.activity_tiny_game_avg_pre_condition.groupDic[actId]
    for groupId, avgPreList in ipairs(avgPreGroup) do
      group[groupId] = {}
      for _, preId in ipairs(avgPreList) do
        local avgId = cfg.activity_avg[preId]
        table.insert(group[groupId], avgId)
        avgPreCondMapping[avgId] = ConfigData.activity_tiny_game_avg_pre_condition[actId][preId]
      end
    end
    for _, avglist in ipairs(group) do
      totalCount = totalCount + 1
      local avgCfg = ConfigData.story_avg[avglist[1]]
      local groupEnName = "Stage " .. tostring(totalCount)
      local groupName = LanguageUtil.GetLocaleText(avgCfg.describe)
      local groupDes = LanguageUtil.GetLocaleText(avgCfg.story_review_describe)
      local CPRGroupData = CommonPoltReviewGroupData.New(groupEnName, groupName, groupDes, avglist)
      local played = avgPlayCtrl:IsAvgPlayed(avgCfg.id)
      if played then
        CPRGroupData:SetAvgGroupDataIsUnlock(true)
        unlockCount = unlockCount + 1
      else
        local lockedDes = LanguageUtil.GetLocaleText(avgPreCondMapping[avgCfg.id].describe_condition)
        if string.IsNullOrEmpty(lockedDes) then
          lockedDes = ConfigData:GetTipContent(8305)
        end
        CPRGroupData:SetAvgGroupDataIsUnlock(false, lockedDes)
      end
      CPRData:AddAvgGroup(CPRGroupData)
    end
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.HeroGrow] = function(actId)
    local heroGrowCfg = ConfigData.activity_hero[actId]
    return CommonPoltReviewData.Create4CharAct(heroGrowCfg)
  end,
  [eActivityType.DailyChallenge] = function(actId)
    local cfg = ConfigData.activity_dailychallenge[actId]
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, cfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local endAvgTotal, endAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, cfg.last_avg, true)
    totalCount = totalCount + endAvgTotal
    unlockCount = unlockCount + endAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.SectorIII] = function(actId)
    local summer22Cfg = ConfigData.activity_summer_main[actId]
    if summer22Cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    CPRData:SetCPRBgResAllScreen(true)
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, summer22Cfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local sectorId = summer22Cfg.main_sector
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.Hallowmas] = function(actId)
    local hallowmasCfg = ConfigData.activity_hallowmas_main[actId]
    if hallowmasCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    CPRData:SetCPRBgResAllScreen(true)
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSectorWithoutStage(CPRData, hallowmasCfg.story_stage)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.Winter23] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_winter23_main)
    local cfg = ConfigData.activity_winter23_main[actId]
    if cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local sectorId = cfg.normal_sector
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_winter23_main)
    return CPRData
  end,
  [eActivityType.Season] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_season_main)
    local seasonCfg = ConfigData.activity_season_main[actId]
    if seasonCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSectorWithoutStage(CPRData, seasonCfg.story_stage)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_season_main)
    return CPRData
  end,
  [eActivityType.ActivityCarnival23] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_carnival23_main)
    local cfg = ConfigData.activity_carnival23_main[actId]
    if cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, cfg.first_avg)
    totalCount = totalCount + firstAvgTotal
    unlockCount = unlockCount + firstAvgUnlock
    local sectorId = cfg.normal_sector
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    local removedCount, removedUnlockCount = CPRData:RemoveDuplicatedAvgGroupList()
    totalCount = totalCount - removedCount
    unlockCount = unlockCount - removedUnlockCount
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_carnival23_main)
    return CPRData
  end,
  [eActivityType.Spring] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_interact_info)
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
    ConfigData:LoadDynCfg(eDynConfigData.activity_spring_main)
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local actFrameId = ConfigData.activity.actTypeMapping[eActivityType.Spring][actId]
    local firstAvgId = ConfigData.activity_lobby[actFrameId].first_avg
    local ids = ConfigData.activity_interact_info.activityAvgsDic[actFrameId]
    table.sort(ids)
    local avgTotal, avgUnlock = SeekAvgGroupInAvgIds(CPRData, ids, function(avgId)
      if firstAvgId == avgId then
        return true
      end
      return avgPlayCtrl:IsAvgPlayed(avgId)
    end, true, function()
      return ConfigData:GetTipContent(8305)
    end)
    totalCount = totalCount + avgTotal
    unlockCount = unlockCount + avgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_interact_info)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_spring_main)
    return CPRData
  end,
  [eActivityType.ShortTheatre] = function(actId)
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local ids = {}
    local signTheaterCfg = ConfigData.sign_theater_main[actId]
    if signTheaterCfg ~= nil and 0 < signTheaterCfg.start_avg then
      table.insert(ids, signTheaterCfg.start_avg)
    end
    local taskConditionCfg = ConfigData.sign_theater_task_condition[actId]
    if taskConditionCfg ~= nil then
      for k, v in pairs(taskConditionCfg) do
        if 0 < v.task_avg then
          table.insert(ids, v.task_avg)
        end
      end
    end
    local avgTotal, avgUnlock = SeekAvgGroupInAvgIds(CPRData, ids, function(avgId)
      return avgPlayCtrl:IsAvgPlayed(avgId)
    end, true, function(avgId)
      if avgId == signTheaterCfg.start_avg then
        return LanguageUtil.GetLocaleText(signTheaterCfg.text)
      end
      if taskConditionCfg ~= nil then
        for k, v in pairs(taskConditionCfg) do
          if v.task_avg == avgId then
            return LanguageUtil.GetLocaleText(v.text)
          end
        end
      end
    end)
    totalCount = totalCount + avgTotal
    unlockCount = unlockCount + avgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.Anniversary23] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary_main)
    local cfg = ConfigData.activity_anniversary_main[actId]
    if cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSectorWithoutStage(CPRData, cfg.story_stage)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary_main)
    return CPRData
  end,
  [eActivityType.SteinsGate] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_23steinsgate_storyline)
    local storylineCfg = ConfigData.activity_23steinsgate_storyline
    if storylineCfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    for nodeId, nodeCfg in ipairs(storylineCfg) do
      if nodeCfg.story_id ~= 0 then
        local firstAvgTotal, firstAvgUnlock = GenCPRDataWithFirstAvgInAct(CPRData, nodeCfg.story_id)
        totalCount = totalCount + firstAvgTotal
        unlockCount = unlockCount + firstAvgUnlock
        local CPRGroupData = CPRData.avgGroupList[#CPRData.avgGroupList]
        CPRGroupData.groupENName = string.format("%s %s", nodeCfg.code, nodeCfg.code_num)
      end
      if nodeCfg.stage_id ~= nil and #nodeCfg.stage_id > 1 then
        if nodeCfg.avg_preview ~= nil and 0 < #nodeCfg.avg_preview then
          totalCount = totalCount + 1
        end
        if __CreateStageItem(CPRData, nodeCfg.stage_id[1], nodeCfg.avg_preview, nil) then
          unlockCount = unlockCount + 1
        end
        local CPRGroupData = CPRData.avgGroupList[#CPRData.avgGroupList]
        CPRGroupData.groupENName = string.format("%s %s", nodeCfg.code, nodeCfg.code_num)
        if CPRGroupData.isUnlock == false then
          CPRGroupData.unlockDes = ConfigData:GetTipContent(8305)
        end
      end
    end
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_23steinsgate_storyline)
    return CPRData
  end,
  [eActivityType.Spring24] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_lobby)
    ConfigData:LoadDynCfg(eDynConfigData.activity_treasurehunt_main)
    ConfigData:LoadDynCfg(eDynConfigData.activity_treasurehunt_story)
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local ids = {}
    local actFrameId = ConfigData.activity.actTypeMapping[eActivityType.Spring24][actId]
    local firstAvgId = ConfigData.activity_lobby[actFrameId].first_avg
    if 0 < firstAvgId then
      table.insert(ids, firstAvgId)
    end
    local storyCfg = ConfigData.activity_treasurehunt_story[actId]
    if storyCfg ~= nil then
      for k, v in pairs(storyCfg) do
        if 0 < v.story_id then
          table.insert(ids, v.story_id)
        end
      end
    end
    local mainCfg = ConfigData.activity_treasurehunt_main[actId]
    local bonusAvgId = mainCfg.bonus_story_id
    if 0 < bonusAvgId then
      table.insert(ids, bonusAvgId)
    end
    table.sort(ids)
    local avgTotal, avgUnlock = SeekAvgGroupInAvgIds(CPRData, ids, function(avgId)
      if firstAvgId == avgId then
        return true
      end
      return avgPlayCtrl:IsAvgPlayed(avgId)
    end, true, function(avgId)
      if storyCfg ~= nil then
        for k, v in pairs(storyCfg) do
          if v.story_id == avgId then
            return ConfigData:GetTipContent(9113, v.treasure_count)
          end
        end
      end
      return ConfigData:GetTipContent(8305)
    end)
    totalCount = totalCount + avgTotal
    unlockCount = unlockCount + avgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_lobby)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_treasurehunt_main)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_treasurehunt_story)
    return CPRData
  end,
  [eActivityType.HeroGrowV3] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_ui_config)
    ConfigData:LoadDynCfg(eDynConfigData.activity_herolite_avg)
    local CPRData = CommonPoltReviewData.Create4CharActV3(actId)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_avg)
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_herolite_ui_config)
    return CPRData
  end,
  [eActivityType.Carnival24] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_carnival24_main)
    local mainCfg = ConfigData.activity_carnival24_main[actId]
    local CPRData = CommonPoltReviewData.New()
    local unlockCount = 0
    local totalCount = 0
    local sectorId = mainCfg.story_stage
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    local cfgList = {}
    for stageId, cfg in pairs(ConfigData.activity_carnival24_memory_stage) do
      if stageId // 1000 == actId then
        table.insert(cfgList, cfg)
      end
    end
    table.sort(cfgList, function(a, b)
      return a.lobby_id < b.lobby_id
    end)
    for id, cfg in pairs(cfgList) do
      local groupENName = string.format("LANES.%d", cfg.lobby_id)
      local groupName = LanguageUtil.GetLocaleText(cfg.handbook_title)
      local groupDes = LanguageUtil.GetLocaleText(cfg.handbook_des)
      local avgList = {}
      for i, actAvgCfg in pairs(ConfigData.activity_carnival24_memory_demand[cfg.stage_id]) do
        table.insert(avgList, actAvgCfg.avg_id)
      end
      table.sort(avgList)
      local CPRGroupData = CommonPoltReviewGroupData.New(groupENName, groupName, groupDes, avgList)
      local unlockDes = ConfigData:GetTipContent(8305)
      local hisData = PlayerDataCenter.actHisSpecialData
      local isUnlock = hisData:IsHaveCarnival24Data(actId) and hisData:IsUnLockMemoryFragMent(actId, cfg.stage_id)
      if isUnlock then
        unlockCount = unlockCount + #avgList
      end
      totalCount = totalCount + #avgList
      CPRGroupData:SetAvgGroupDataIsUnlock(isUnlock, unlockDes)
      CPRData:AddAvgGroup(CPRGroupData)
    end
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_carnival24_main)
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end,
  [eActivityType.DeliverySimulator] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.delivery_activity_main)
    local cfg = ConfigData.delivery_activity_main[actId]
    if cfg == nil then
      return
    end
    local CPRData = CommonPoltReviewData.New()
    local totalCount = 0
    local unlockCount = 0
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSectorWithoutStage(CPRData, cfg.story_sector)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    ConfigData:ReleaseDynCfg(eDynConfigData.delivery_activity_main)
    return CPRData
  end,
  [eActivityType.ActAnniversary24] = function(actId)
    ConfigData:LoadDynCfg(eDynConfigData.activity_anniversary24_main)
    local mainCfg = ConfigData.activity_anniversary24_main[actId]
    local CPRData = CommonPoltReviewData.New()
    local unlockCount = 0
    local totalCount = 0
    local sectorId = mainCfg.normal_sector
    local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[sectorId][SectorLevelDetailEnum.eDifficulty.normal]
    local sectorAvgTotal, sectorAvgUnlock = SeekAvgGroupInSector(CPRData, sectorStageCfg)
    totalCount = totalCount + sectorAvgTotal
    unlockCount = unlockCount + sectorAvgUnlock
    ConfigData:ReleaseDynCfg(eDynConfigData.activity_anniversary24_main)
    CPRData:SetCPRUnlockNum(totalCount, unlockCount)
    return CPRData
  end
}

function HandBookActReviewFunc.CreateHandBookCardEggReview()
  local CPRData = CommonPoltReviewData.New()
  local totalCount = 0
  local unlockCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local cfgs = ConfigData.activity_anniversary24_talk_surprise[59001]
  if cfgs == nil then
    return CPRData
  end
  local ids = {}
  for k, v in pairs(cfgs) do
    if 0 < v.surprise_param2 then
      table.insert(ids, v.surprise_param2)
    end
  end
  local avgTotal, avgUnlock = SeekAvgGroupInAvgIds(CPRData, ids, function(avgId)
    return avgPlayCtrl:IsAvgPlayed(avgId)
  end, true, function(avgId)
    return ConfigData:GetTipContent(8305)
  end)
  totalCount = totalCount + avgTotal
  unlockCount = unlockCount + avgUnlock
  CPRData:SetCPRUnlockNum(totalCount, unlockCount)
  return CPRData
end

function HandBookActReviewFunc.CreateHandBookCardStoryReview()
  local CPRData = CommonPoltReviewData.New()
  local totalCount = 0
  local unlockCount = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local cfgs = ConfigData.reinforce_collect_collect_reward
  if cfgs == nil then
    return CPRData
  end
  local ids = {}
  for k, v in pairs(cfgs) do
    if 0 < v.story_id then
      table.insert(ids, v.story_id)
    end
  end
  local avgTotal, avgUnlock = SeekAvgGroupInAvgIds(CPRData, ids, function(avgId)
    return avgPlayCtrl:IsAvgPlayed(avgId)
  end, true, function(avgId)
    return ConfigData:GetTipContent(8305)
  end)
  totalCount = totalCount + avgTotal
  unlockCount = unlockCount + avgUnlock
  CPRData:SetCPRUnlockNum(totalCount, unlockCount)
  return CPRData
end

return HandBookActReviewFunc
