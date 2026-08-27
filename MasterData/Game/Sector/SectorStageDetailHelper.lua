local SectorStageDetailHelper = class("SectorStageDetailHelper")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local cs_MessageCommon = CS.MessageCommon
local emptyString = ""
local SectorEnum = require("Game.Sector.SectorEnum")
SectorStageDetailHelper.PlayMoudleType = {
  Ep = 1,
  Warchess = 2,
  WarchessSeason = 3,
  EpMixWarchess = 4,
  AVG = 5
}
local GetChipPreviewByEpModuleIdFunc = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = function(stageId, param)
    local chip_dic = {}
    local stageCfg = ConfigData.sector_stage[stageId]
    for k, v in pairs(stageCfg.function_extra) do
      chip_dic[v] = true
    end
    local chip_pool_dic = {}
    for _, epId in pairs(stageCfg.exploration_list) do
      local epCfg = ConfigData.exploration[epId]
      if epCfg ~= nil then
        for _, poolId in pairs(epCfg.chip_pool) do
          chip_pool_dic[poolId] = true
          local funcPoolCfg = ConfigData.ep_function_pool[poolId]
          if funcPoolCfg ~= nil then
            for _, chipId in pairs(funcPoolCfg.function_pool) do
              chip_dic[chipId] = true
            end
          end
        end
      end
    end
    return chip_dic
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = function(stageId, param)
    local chip_dic = {}
    local levelDic = ConfigData.endless.levelDic[stageId]
    local cfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    for k, v in pairs(cfg.chip) do
      chip_dic[v] = true
    end
    return chip_dic
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge] = function(stageId, param)
    local chip_dic = {}
    local chipList = PlayerDataCenter.periodicChallengeData.dailyChipList
    if chipList ~= nil then
      for index, value in ipairs(chipList) do
        chip_dic[value] = true
      end
    end
    return chip_dic
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge] = function(stageId, param)
    local chip_dic = {}
    local weeklyData = PlayerDataCenter.allWeeklyChallengeData.dataDic[stageId]
    if weeklyData ~= nil then
      chip_dic = weeklyData:GetWeeklyChanllengeChipDic()
    end
    return chip_dic
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess] = function(stageId, param)
    local chip_dic = {}
    local chipPoolList
    local stageCfg = ConfigData.sector_stage[stageId]
    local warchessLevelCfg = ConfigData.warchess_level[stageCfg.exploration_list[1]]
    if warchessLevelCfg ~= nil then
      for _, poolId in ipairs(warchessLevelCfg.chip_pool) do
        local funcPoolCfg = ConfigData.ep_function_pool[poolId]
        if funcPoolCfg ~= nil then
          for _, chipId in pairs(funcPoolCfg.function_pool) do
            chip_dic[chipId] = true
          end
        end
      end
    end
    return chip_dic
  end
}
local TryGetUncompletedSectorStateCfgFunc = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = function(dungeonId)
    local sectorStateCfg = ConfigData.sector_stage[dungeonId]
    if sectorStateCfg == nil then
      error("Can't find sectorStateCfg, id = " .. tostring(dungeonId))
      return
    end
    return sectorStateCfg
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = function(dungeonId)
    local levelDic = ConfigData.endless.levelDic[dungeonId]
    local cfg = ConfigData.endless[levelDic.sectorId][levelDic.index]
    if cfg == nil then
      error("endlessCfg is null,endlessId:" .. tostring(dungeonId))
      return
    end
    local stageCfg = {
      endlessCfg = cfg,
      name = cfg.name,
      sector = levelDic.sectorId,
      cost_strength_num = cfg.cost_strength_itemNums[1],
      difficulty = SectorLevelDetailEnum.eDifficulty.infinity,
      dungeonId = dungeonId
    }
    return stageCfg
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge] = function(dungeonId)
    local challengeCfg = ConfigData.daily_challenge[dungeonId]
    local stageCfg = {
      challengeCfg = challengeCfg,
      name = LanguageUtil.GetLocaleText(challengeCfg.name),
      sector = nil,
      cost_strength_num = 0,
      difficulty = SectorLevelDetailEnum.eDifficulty.daily_challenge,
      dungeonId = dungeonId
    }
    return stageCfg
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge] = function(dungeonId)
    local challengeCfg = ConfigData.weekly_challenge[dungeonId]
    local stageCfg = {
      challengeCfg = challengeCfg,
      name = LanguageUtil.GetLocaleText(challengeCfg.name),
      sector = nil,
      cost_strength_num = 0,
      difficulty = SectorLevelDetailEnum.eDifficulty.weekly_challenge,
      dungeonId = dungeonId,
      combat = 5000
    }
    return stageCfg
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess] = function(dungeonId)
    local sectorStateCfg = ConfigData.sector_stage[dungeonId]
    if sectorStateCfg == nil then
      error("Can't find sectorStateCfg, id = " .. tostring(dungeonId))
      return
    end
    return sectorStateCfg
  end
}
local TryToShowCurrentLevelTipsFunc = {
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration] = function(stageCfg, playModeType)
    local msg
    local sectorCfg = ConfigData.sector[stageCfg.sector]
    local strName = LanguageUtil.GetLocaleText(sectorCfg.name)
    local courseDes = LanguageUtil.GetLocaleText(sectorCfg.course_des)
    if ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
      if playModeType == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess and ControllerManager:GetController(ControllerTypeId.ActivityWinter23) ~= nil then
        local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
        if win23Ctrl then
          local actName, mainName = win23Ctrl:GetActWin23NameAndMode()
          msg = string.format(ConfigData:GetTipContent(7133), strName, stageCfg.num, actName, mainName)
        end
      else
        msg = string.format(ConfigData:GetTipContent(7009), strName, stageCfg.num)
      end
    elseif ConfigData.sector.onlyShowNameSectorDic[stageCfg.sector] then
      msg = string.format(ConfigData:GetTipContent(390), strName)
    else
      local strDiff
      local sectorShowId, isConvert = ConfigData:GetSectorIdShow(stageCfg.sector)
      if isConvert then
        strDiff = ConfigData:GetTipContent(13008)
      else
        local difficult = stageCfg.difficulty
        if difficult == ExplorationEnum.eDifficultType.Normal then
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_1)
        elseif difficult == ExplorationEnum.eDifficultType.Hard then
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_2)
        else
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_3)
        end
      end
      local strLv = tostring(sectorShowId) .. "-" .. tostring(stageCfg.num)
      if playModeType == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess and ControllerManager:GetController(ControllerTypeId.ActivityWinter23) ~= nil then
        local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
        if win23Ctrl then
          local actName, mainName = win23Ctrl:GetActWin23NameAndMode()
          msg = string.format(ConfigData:GetTipContent(7131), strName, strLv, strDiff, actName, mainName)
        end
      elseif courseDes ~= nil and courseDes ~= emptyString then
        msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2normal), strName, emptyString, strDiff)
      else
        msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2normal), strName, strLv, strDiff)
      end
    end
    ExplorationManager:TryGiveUpLastExploration(msg, stageCfg)
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_Endless] = function(stageCfg, playModeType)
    local strName = LanguageUtil.GetLocaleText(stageCfg.endlessCfg.name)
    local strNum = tostring(stageCfg.endlessCfg.index * 10) .. "m"
    local msg
    if playModeType == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess and ControllerManager:GetController(ControllerTypeId.ActivityWinter23) ~= nil then
      local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
      if win23Ctrl then
        local actName, mainName = win23Ctrl:GetActWin23NameAndMode()
        msg = string.format(ConfigData:GetTipContent(7132), strName, strNum, actName, mainName)
      end
    else
      msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2endless), strName, strNum)
    end
    ExplorationManager:TryGiveUpLastExploration(msg, stageCfg)
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge] = function(stageCfg)
    local msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2DailyAndWeekly), stageCfg.name)
    ExplorationManager:TryGiveUpLastExploration(msg, stageCfg)
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge] = function(stageCfg)
    local msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2DailyAndWeekly), stageCfg.name)
    ExplorationManager:TryGiveUpLastExploration(msg, stageCfg)
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess] = function(stageCfg, playModeType)
    local msg
    local sectorCfg = ConfigData.sector[stageCfg.sector]
    local strName = LanguageUtil.GetLocaleText(sectorCfg.name)
    if ConfigData.sector.onlyShowStageIdSectorDic[stageCfg.sector] then
      if playModeType == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess and ControllerManager:GetController(ControllerTypeId.ActivityWinter23) ~= nil then
        local win23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
        if win23Ctrl then
          local actName, mainName = win23Ctrl:GetActWin23NameAndMode()
          msg = string.format(ConfigData:GetTipContent(7134), strName, stageCfg.num, actName, mainName)
        end
      else
        msg = string.format(ConfigData:GetTipContent(7009), strName, stageCfg.num)
      end
    else
      local strDiff
      local sectorShowId, isConvert = ConfigData:GetSectorIdShow(stageCfg.sector)
      if isConvert then
        strDiff = ConfigData:GetTipContent(13008)
      else
        local difficult = stageCfg.difficulty
        if difficult == ExplorationEnum.eDifficultType.Normal then
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_1)
        elseif difficult == ExplorationEnum.eDifficultType.Hard then
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_2)
        else
          strDiff = ConfigData:GetTipContent(TipContent.DifficultyName_3)
        end
      end
      local strLv = tostring(sectorShowId) .. "-" .. tostring(stageCfg.num)
      msg = string.format(ConfigData:GetTipContent(TipContent.Sector_IsExploringOtherSector2normal), strName, strLv, strDiff)
    end
    WarChessManager:TryGiveUpLastWarChess(msg, stageCfg)
  end,
  [proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason] = function(stageCfg, playModeType, argList)
    local _, _, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySeasonId(stageCfg.seasonId)
    local actName = actFrameData ~= nil and actFrameData:GetActivityFrameName() or nil
    local tip = ConfigData:GetTipContent(8705, actName, tostring(stageCfg.floorId))
    local isReconnect = argList[1]
    if isReconnect then
      tip = tip .. [[


]]
      local loadTip = ConfigData:GetTipContent(8707, actName)
      tip = tip .. loadTip
      cs_MessageCommon.ShowMessageBox(tip, function()
        WarChessSeasonManager:ContinueWarChessSeasonCommon()
      end, nil)
      return
    end
    WarChessManager:TryGiveUpLastWarChess(tip, stageCfg)
  end
}

local function DefaultJump2ActFunc(actFrameId)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  local actName = actFrameData:GetActivityFrameName()
  local tip = string.format(ConfigData:GetTipContent(6201), actName, actName)
  cs_MessageCommon.ShowMessageBox(tip, function()
    local JumpManager = require("Game.Jump.JumpManager")
    JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {actFrameId})
  end, function()
    return
  end)
end

local Try2Jump2ActFunc = {
  [ActivityFrameEnum.eActivityType.SectorIII] = function(actFrameId)
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
    local actName = actFrameData:GetActivityFrameName()
    local tip = string.format(ConfigData:GetTipContent(6201), actName, actName)
    cs_MessageCommon.ShowMessageBox(tip, function()
      local JumpManager = require("Game.Jump.JumpManager")
      JumpManager:Jump(JumpManager.eJumpTarget.DynActivity, nil, nil, {actFrameId})
    end, function()
      return
    end)
  end
}

function SectorStageDetailHelper.GetChipPreviewByEpModuleId(moduleId, stageId, param)
  local func = GetChipPreviewByEpModuleIdFunc[moduleId]
  if func ~= nil then
    return func(stageId, param)
  end
  return {}
end

function SectorStageDetailHelper.IsSectorNoCollide(sectorId, isShowTip)
  if ConfigData.sector_stage.sectorIdList[sectorId] == nil then
    return true
  end
  local moudleType = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  local cfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(moudleType)
  if cfg == nil then
    return true
  end
  if cfg.sector == sectorId then
    return true
  end
  if isShowTip then
    SectorStageDetailHelper.TryToShowCurrentLevelTips(moudleType)
  end
  return false
end

function SectorStageDetailHelper.IsSectorNoActCollide(actCat, ignoreJumpFunc, ignoreFrameIdDic)
  if actCat == nil or actCat <= 0 or SectorEnum.SctRelevancyNormalSector == actCat then
    return true
  end
  local activivityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityDic = activivityCtrl:GetActivityFrameDataDic()
  for activityFrameId, activityFrameData in pairs(activityDic) do
    local theActCat = activityFrameData:GetActivityFrameCat()
    if theActCat == actCat and not activityFrameData:GetIsActivityFinished() and not ignoreFrameIdDic[activityFrameId] then
      local func = Try2Jump2ActFunc[actCat] or DefaultJump2ActFunc
      if func ~= nil and not ignoreJumpFunc then
        func(activityFrameId)
      end
      return false
    end
  end
  return true
end

function SectorStageDetailHelper.IsWarchessSeasonNoCollide(seasonId, isShowTip, isReconnect)
  local unComleteEp, tempSeasonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.WarchessSeason)
  if not unComleteEp then
    return true
  end
  local unCompleteWCS, data = WarChessSeasonManager:GetUncompleteWCSData()
  if seasonId == data.seasonId then
    return true
  end
  if isShowTip then
    local argList = {
      [1] = isReconnect
    }
    SectorStageDetailHelper.TryToShowCurrentLevelTips(SectorStageDetailHelper.PlayMoudleType.WarchessSeason, argList)
  end
  return false
end

function SectorStageDetailHelper.IsWeeklyChallengeNoCollide(isShowTip)
  local unComleteEp, _, moduleId = SectorStageDetailHelper.HasUnCompleteStage(SectorStageDetailHelper.PlayMoudleType.Ep)
  if not unComleteEp then
    return true
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    return true
  end
  local lastSelectSector = PlayerDataCenter.sectorStage:GetSelectSectorId()
  local isWeeklyChallengeSector = table.contain(ConfigData.game_config.weeklyChallengeSectorIds, lastSelectSector)
  if isWeeklyChallengeSector then
    return true
  end
  if isShowTip then
    SectorStageDetailHelper.TryToShowCurrentLevelTips(SectorStageDetailHelper.PlayMoudleType.Ep)
  end
  return false
end

function SectorStageDetailHelper.HasUnCompleteStage(PlayMoudleType)
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.EpMixWarchess then
    local unComplete, dungeonId, moduleId, canFloorOver = ExplorationManager:HasUncompletedEp()
    if unComplete then
      return unComplete, dungeonId, moduleId, canFloorOver
    end
    unComplete, dungeonId, moduleId, canFloorOver = WarChessManager:GetIsHaveUncompletedWarChess()
    return unComplete, dungeonId, moduleId, canFloorOver
  end
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.Ep then
    local unComplete, dungeonId, moduleId, canFloorOver = ExplorationManager:HasUncompletedEp()
    return unComplete, dungeonId, moduleId, canFloorOver
  end
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.Warchess then
    local unComplete, dungeonId, moduleId, canFloorOver = WarChessManager:GetIsHaveUncompletedWarChess()
    return unComplete, dungeonId, moduleId, canFloorOver
  end
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.WarchessSeason then
    local unComplete, data = WarChessSeasonManager:GetUncompleteWCSData()
    if unComplete then
      return unComplete, data.seasonId, proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason, false
    end
    return false
  end
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.AVG then
    return false
  end
  if isGameDev then
    error("PlayMoudleType Error")
  end
  return false
end

function SectorStageDetailHelper.TryGetUncompletedStateCfg(PlayMoudleType)
  if PlayMoudleType == SectorStageDetailHelper.PlayMoudleType.WarchessSeason then
    local unComplete, data = WarChessSeasonManager:GetUncompleteWCSData()
    if unComplete then
      return data, proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason
    end
    return nil
  end
  local unComplete, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(PlayMoudleType)
  if not unComplete then
    return nil
  end
  local func = TryGetUncompletedSectorStateCfgFunc[moduleId]
  if func ~= nil then
    return func(dungeonId), moduleId
  end
  if isGameDev then
    error("没有配置获取方法 " .. tostring(moduleId))
  end
  return nil
end

function SectorStageDetailHelper.TryGetUncompleteStageSectorId()
  local lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Ep)
  if lastEpStateCfg ~= nil then
    return lastEpStateCfg.sector
  end
  lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(SectorStageDetailHelper.PlayMoudleType.Warchess)
  if lastEpStateCfg ~= nil then
    return lastEpStateCfg.sector
  end
  return nil
end

function SectorStageDetailHelper.TryToShowCurrentLevelTips(PlayMoudleType, argList)
  local stageCfg, moduleId = SectorStageDetailHelper.TryGetUncompletedStateCfg(PlayMoudleType)
  if stageCfg == nil then
    return
  end
  local func = TryToShowCurrentLevelTipsFunc[moduleId]
  if func ~= nil then
    func(stageCfg, PlayMoudleType, argList)
  elseif isGameDev then
    error("没有提示方法" .. tostring(moduleId))
  end
end

function SectorStageDetailHelper.GiveupStageLevel(PlayMoudleType)
  local unComplete, dungeonId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(PlayMoudleType)
  if not unComplete then
    return
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess then
    local msg = ConfigData:GetTipContent(8511)
    cs_MessageCommon.ShowMessageBox(msg, function()
      WarChessManager:GiveUpLastWarchess()
    end, nil)
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason then
    WarChessSeasonManager:GiveUpLastWarchessSeason()
  else
    ExplorationManager:TryGiveUpLastExploration()
  end
end

function SectorStageDetailHelper.ContinueUncompleteStage(PlayMoudleType)
  local hasHasUncompletedEp, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(PlayMoudleType)
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess then
    WarChessManager:ContinueLastWarchess()
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason then
    self:__ContinueUncompleteWarchessSeason()
  else
    ExplorationManager:ContinueLastExploration()
  end
end

function SectorStageDetailHelper.IsSectorHasUnComplete(sectorId)
  local playerModuleId = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  local unComplete, stageId, moduleId = SectorStageDetailHelper.HasUnCompleteStage(playerModuleId)
  if not unComplete then
    return false
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    return false
  end
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local endlessCfg = ConfigData.endless.levelDic[stageId]
    return endlessCfg.sectorId == sectorId, stageId
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  return stageCfg.sector == sectorId, stageId
end

function SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    return 0
  end
  if ConfigData.sector_stage.sectorIdList[sectorId] == nil then
    return SectorStageDetailHelper.PlayMoudleType.AVG
  end
  local isWarchessSector = sectorCfg.sector_type == SectorLevelDetailEnum.eSectorType.WarChess
  local isMixSector = sectorCfg.sector_type == SectorLevelDetailEnum.eSectorType.ActWin23
  return isWarchessSector and SectorStageDetailHelper.PlayMoudleType.Warchess or isMixSector and SectorStageDetailHelper.PlayMoudleType.EpMixWarchess or SectorStageDetailHelper.PlayMoudleType.Ep
end

function SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
  local moduleType = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  return moduleType == SectorStageDetailHelper.PlayMoudleType.AVG
end

function SectorStageDetailHelper.GetIsSectorHaveWarChessStage(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg.sector_type == SectorLevelDetailEnum.eSectorType.WarChess then
    return true
  end
  return ConfigData.sector_stage.sectorIsHaveWCStageDic[sectorId]
end

function SectorStageDetailHelper.GetSectorStagePerformance(sectorId, isOpenChallenge)
  local allCount = 0
  local completeCount = 0
  local curChallengeTaskNum = 0
  local allChallengeTaskNum = 0
  local playModuleType = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  if playModuleType == SectorStageDetailHelper.PlayMoudleType.AVG then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
    local avgIds = ConfigData.story_avg.sectorAvgDic[sectorId]
    if avgIds == nil or #avgIds == 0 then
      return false
    end
    for i, avgId in pairs(avgIds) do
      allCount = allCount + 1
      if avgPlayCtrl:IsAvgPlayed(avgId) then
        completeCount = completeCount + 1
      end
    end
  else
    local sectorIdList = ConfigData.sector_stage.sectorIdList[sectorId]
    for k, id in ipairs(sectorIdList) do
      local stageCfg = ConfigData.sector_stage[id]
      if stageCfg.difficulty == eSectorStageDifficult.Endless then
        break
      end
      allCount = allCount + 1
      if PlayerDataCenter.sectorStage:IsStageComplete(id) then
        completeCount = completeCount + 1
      end
      if isOpenChallenge then
        allChallengeTaskNum = allChallengeTaskNum + #stageCfg.hard_task
        curChallengeTaskNum = curChallengeTaskNum + PlayerDataCenter.sectorAchievementDatas:GetStageChallengeTaskCompleteNum(id)
      end
    end
  end
  return allCount, completeCount, curChallengeTaskNum, allChallengeTaskNum
end

function SectorStageDetailHelper.__ContinueUncompleteWarchessSeason()
  local unComplete, data = WarChessSeasonManager:GetUncompleteWCSData()
  if not unComplete then
    return
  end
  local actType = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySeasonId(data.seasonId)
  if actType == nil then
    return
  end
  if actType == ActivityFrameEnum.eActivityType.Hallowmas then
    local ctrl = ControllerManager:GetController(ControllerTypeId.ActivityHallowmas)
    ctrl:ContinuehallowmasSeason()
  end
end

return SectorStageDetailHelper
