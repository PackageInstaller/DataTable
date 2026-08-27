local SectorStageData = class("SectorStageData")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local eDifficulty = require("Game.Sector.Enum.SectorLevelDetailEnum").eDifficulty
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorEnum = require("Game.Sector.SectorEnum")
local cs_MicaSDKManager = CS.MicaSDKManager

function SectorStageData:ctor()
  self.__lastSelectSector = nil
  self.lastChallengeType = nil
  self.stageData = {}
  self.lastSatgeData = nil
  self._lastDiffDic = {}
  self.stageRecordDic = {}
  self._chapterUnlockShowDic = {}
end

function SectorStageData:InitSectorChapterUnlockShow(chapterIdList)
  for k, chapterId in ipairs(chapterIdList) do
    self:SetSectorChapterUnlockShow(chapterId)
  end
end

function SectorStageData:SetSectorChapterUnlockShow(chapterId)
  self._chapterUnlockShowDic[chapterId] = true
end

function SectorStageData:IsSectorChapterUnlockShow(chapterId)
  return self._chapterUnlockShowDic[chapterId] ~= nil
end

function SectorStageData:InitSelectStage(sectorId, difficult)
  self.__lastSelectSector = sectorId
  self.__lastSelectDiff = difficult or 1
  if sectorId == nil then
    return
  end
  self._lastDiffDic[sectorId] = difficult or 1
end

function SectorStageData:SetSelectSectorId(sectorId)
  self.__lastSelectSector = sectorId
  if sectorId == nil then
    return
  end
  if self._lastDiffDic[sectorId] == nil then
    self._lastDiffDic[sectorId] = 1
  end
end

function SectorStageData:GetSelectSectorId()
  return self.__lastSelectSector
end

function SectorStageData:SetSelectDifficult(difficult)
  self.__lastSelectDiff = difficult or 1
  if self.__lastSelectSector == nil then
    return
  end
  self._lastDiffDic[self.__lastSelectSector] = difficult or 1
end

function SectorStageData:GetSelectDifficult(sectorId)
  if self.__lastSelectDiff ~= nil then
    if self.__lastSelectDiff == eSectorStageDifficult.Endless then
      if ConfigData.endless[sectorId] ~= nil then
        return self._lastDiffDic[sectorId] or 1
      end
    elseif ConfigData.sector_stage.sectorTotalCountDic[sectorId] ~= nil and 0 < (ConfigData.sector_stage.sectorTotalCountDic[sectorId][self.__lastSelectDiff] or 0) then
      return self._lastDiffDic[sectorId] or 1
    end
  end
  return 1
end

function SectorStageData:UpdateSectorPassTm(data)
  self.stageRecordDic = data
end

function SectorStageData:UpdateSectorPassTmDiff(data)
  for i, v in pairs(data) do
    self.stageRecordDic[i] = v
  end
end

function SectorStageData:UpdateStageData(data, isInit)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for k, v in pairs(data) do
    if not isInit then
      self:_StageTrackEvent(k, v)
    end
    self.stageData[k] = v
    if not isInit then
      self:UpdateSctStageItemState(k)
      if self:IsStageComplete(k) then
        UnlockCenter:TriggerUnlockEvent(UnlockCenter.eUnlockLogic.CompleteStage, k)
      end
      local unlockDic = ConfigData.sector.stageUnlockDic[k]
      if unlockDic ~= nil then
        for id, checkerTypeId in pairs(unlockDic) do
          if checkerTypeId == CheckerTypeId.CompleteStage then
            self:UpdateSctStageItemState(id)
          elseif checkerTypeId == CheckerTypeId.CompleteAvg then
            avgPlayCtrl:UpdateMainAvgState(id)
          end
        end
      end
    end
  end
end

function SectorStageData:GetStageState(stageId)
  local stageState = self.stageData[stageId]
  return stageState or 0
end

function SectorStageData:IsStageUnlock(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  return CheckCondition.CheckLua(stageCfg.pre_condition, stageCfg.pre_para1, stageCfg.pre_para2)
end

function SectorStageData:IsSctChapterUnlock(chapterId, ignoreBuy, ignoreUnlockSkipped)
  local chapterCfg = ConfigData.sector_sector_resident[chapterId]
  if chapterCfg == nil then
    error(string.format("sector_sector_resident is nil, id:%s", chapterId))
    return false
  end
  local curChapterUnlock = self:_IsChapterUnlock(chapterId, ignoreBuy)
  if not curChapterUnlock then
    return false
  end
  if #chapterCfg.show_need_pass > 0 and not ignoreUnlockSkipped then
    for k, chapterId in ipairs(chapterCfg.show_need_pass) do
      if not self:_IsChapterUnlock(chapterId) then
        return false
      end
    end
    return true
  end
  for i = 1, chapterId - 1 do
    if not self:_IsChapterUnlock(i) then
      return false
    end
  end
  return true
end

function SectorStageData:_IsChapterUnlock(chapterId, ignoreBuy)
  local chapterCfg = ConfigData.sector_sector_resident[chapterId]
  if chapterCfg == nil then
    error(string.format("sector_sector_resident is nil, id:%s", chapterId))
    return false
  end
  local sectorId = chapterCfg.relevancy_parameter
  local unlock = self:IsSectorUnlock(sectorId, ignoreBuy)
  return unlock
end

function SectorStageData:IsSectorUnlock(sectorId, ignoreBuy)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    return false
  end
  local unlock = false
  local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  local sectorStage = ConfigData.sector_stage.sectorIdList[sectorId]
  if isAvgSector then
    local avgIds = ConfigData.story_avg.sectorAvgDic[sectorId]
    if avgIds == nil or #avgIds == 0 then
      return false
    end
    local avgCfg = ConfigData.story_avg[avgIds[1]]
    unlock = avgPlayCtrl:IsAvgUnlock(avgCfg.id)
  else
    local sectorStageCfg = ConfigData.sector_stage[sectorStage[1]]
    local stageId = sectorStageCfg.id
    local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1)
    if avgCfg == nil then
      unlock = self:IsStageUnlock(stageId)
    else
      unlock = avgPlayCtrl:IsAvgUnlock(avgCfg.id)
    end
  end
  local chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId]
  if not ignoreBuy and unlock and chapterId and 0 < ConfigData.sector_sector_resident[chapterId].costItemId then
    unlock = self:IsSectorCostBuyOk(sectorId)
  end
  return unlock
end

function SectorStageData:IsSectorFirstStageUnlock(sectorId)
  local sectorStage = ConfigData.sector_stage.sectorIdList[sectorId]
  if sectorStage == nil then
    return false
  end
  local sectorStageCfg = ConfigData.sector_stage[sectorStage[1]]
  local stageId = sectorStageCfg.id
  return self:IsStageUnlock(stageId)
end

function SectorStageData:GetSectorUnlockInfo(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    return
  end
  local sectorStage = ConfigData.sector_stage.sectorIdList[sectorId]
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
  if isAvgSector then
    local avgIds = ConfigData.story_avg.sectorAvgDic[sectorId]
    if avgIds == nil or #avgIds == 0 then
      return
    end
    local avgCfg = ConfigData.story_avg[avgIds[1]]
    return avgPlayCtrl:GetAvgUnlockInfo(avgCfg.id)
  else
    local sectorStageCfg = ConfigData.sector_stage[sectorStage[1]]
    local stageId = sectorStageCfg.id
    local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1)
    if avgCfg == nil then
      return self:GetGetUnlockInfo(stageId)
    else
      return avgPlayCtrl:GetAvgUnlockInfo(avgCfg.id)
    end
  end
end

function SectorStageData:InitSectorCostBuy(sectorData)
  self._sectorCostBuyDic = {}
  for sectorId, v in pairs(sectorData) do
    self:SetSectorCostBuy(sectorId)
  end
end

function SectorStageData:SetSectorCostBuy(sectorId)
  self._sectorCostBuyDic[sectorId] = true
end

function SectorStageData:IsSectorCostBuyOk(sectorId)
  return self._sectorCostBuyDic[sectorId] ~= nil
end

function SectorStageData:IsSectorMapUnlock(sctMapId)
  local chapterIdList = ConfigData.sector_sector_resident.sectorMapChapterDic[sctMapId]
  if chapterIdList == nil or #chapterIdList <= 0 then
    return false
  end
  local firstChapterId = chapterIdList[1]
  return self:IsSctChapterUnlock(firstChapterId, true)
end

function SectorStageData:GetSectorMapUnlockInfo(sctMapId)
  local chapterIdList = ConfigData.sector_sector_resident.sectorMapChapterDic[sctMapId]
  if chapterIdList == nil or #chapterIdList <= 0 then
    return ConfigData:GetTipContent(170)
  end
  local mapCfg = ConfigData.sector_sector_map[sctMapId - 1]
  if mapCfg == nil then
    error(string.format("Cant get sector_sector_map cfg, mapId:%s", sctMapId - 1))
    return nil
  end
  local mapName = LanguageUtil.GetLocaleText(mapCfg.name)
  return string.format(ConfigData:GetTipContent(427), mapName)
end

function SectorStageData:IsStageComplete(stageId)
  local stageState = self:GetStageState(stageId)
  return 0 < stageState
end

function SectorStageData:AnySectorBuildingUnlock(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  if sectorCfg == nil then
    return
  end
  for k, buildId in ipairs(sectorCfg.building) do
    local lvCfg = ConfigData.buildingLevel[buildId]
    if lvCfg == nil then
      error("Cant get buildingLevel cfg, buildId : " .. tostring(buildId))
      return
    end
    local lv1Cfg = lvCfg[1]
    if lv1Cfg == nil then
      error("Cant get building level 1 cfg, buildId : " .. tostring(buildId))
      return
    end
    if CheckCondition.CheckLua(lv1Cfg.pre_condition, lv1Cfg.pre_para1, lv1Cfg.pre_para2) then
      return true
    end
  end
end

function SectorStageData:UpdateSctStageItemState(stageId)
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil then
    error("Cant get sector_stage cfg, stageId = " .. tostring(stageId))
    return
  end
  MsgCenter:Broadcast(eMsgEventId.OnMainLevelStateChange, stageCfg.sector, stageCfg.difficulty, stageId)
end

function SectorStageData:GetSectorProcess(sectorId)
  local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
  if isAvgSector then
    error("cant get avg sector process")
  end
  local normalStageList = ConfigData.sector_stage.sectorDiffDic[sectorId][eDifficulty.normal]
  for _, stageId in ipairs(normalStageList) do
    if not self:IsStageComplete(stageId) then
      return false, stageId
    end
  end
  return true, normalStageList[#normalStageList]
end

function SectorStageData:GetSectorUnlockProcess(sectorId)
  local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
  if isAvgSector then
    error("cant get avg sector UnlockProcess")
  end
  local normalStageList = ConfigData.sector_stage.sectorDiffDic[sectorId][eDifficulty.normal]
  local lastUnlockStageId = 0
  for _, stageId in ipairs(normalStageList) do
    if not self:IsSectorUnlock(stageId) then
      break
    end
    lastUnlockStageId = stageId
  end
  return lastUnlockStageId
end

function SectorStageData:GetEpStageCfg4Home()
  local latestSectorId, latestStageIndex, lastdifferIdex
  for _, chapterId in ipairs(ConfigData.sector_sector_resident.sectorChapterIdList) do
    local chapterCfg = ConfigData.sector_sector_resident[chapterId]
    local sectorId = chapterCfg.relevancy_parameter
    if self:IsSectorUnlock(sectorId) and self:IsSectorFirstStageUnlock(sectorId) and not SectorStageDetailHelper.GetSectorIsAvgSector(sectorId) and self:IsSctChapterUnlock(chapterId) then
      latestSectorId = sectorId
    end
  end
  if latestSectorId == nil then
    latestSectorId = SectorEnum.NewbeeSectorId
  end
  local sageDifferList = ConfigData.sector_stage.sectorDiffDic[latestSectorId]
  if sageDifferList then
    for differIdex = 1, ConfigData.sector_stage.difficultyCount do
      local stageList = sageDifferList[differIdex]
      if stageList ~= nil and #stageList ~= 0 then
        for index, stageId in ipairs(stageList) do
          if self:IsStageUnlock(stageId) or self:IsStageComplete(stageId) then
            latestStageIndex = index
            lastdifferIdex = differIdex
          elseif latestStageIndex == nil then
            return latestSectorId, latestStageIndex, lastdifferIdex
          end
        end
      end
    end
  end
  if latestStageIndex ~= nil then
    return latestSectorId, latestStageIndex, lastdifferIdex
  end
  local final
  for key, value in pairs(ConfigData.sector_stage) do
    final = value
    break
  end
  return final.sector, final.id, final.difficulty
end

function SectorStageData:GetEpStageCfg4UserInfo()
  local latestSectorId, latestStageIndex
  for _, chapterId in ipairs(ConfigData.sector_sector_resident.sectorChapterIdList) do
    local chapterCfg = ConfigData.sector_sector_resident[chapterId]
    local sectorId = chapterCfg.relevancy_parameter
    local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
    if not isAvgSector then
      if not self:IsSectorUnlock(sectorId) then
        break
      end
      do
        local sectorStage = ConfigData.sector_stage.sectorIdList[sectorId]
        if not self:IsStageComplete(sectorStage[1]) then
          break
        end
        latestSectorId = sectorId
        latestStageIndex = 1
        local sageDifferList = ConfigData.sector_stage.sectorDiffDic[latestSectorId]
        local differIdex = 1
        local stageList = sageDifferList[differIdex]
        if stageList ~= nil and #stageList ~= 0 then
          for index, stageId in ipairs(stageList) do
            if self:IsStageComplete(stageId) then
              latestStageIndex = index
            else
              return latestSectorId, latestStageIndex
            end
          end
          goto lbl_62
          break
        end
      end
    end
    ::lbl_62::
  end
  if latestStageIndex ~= nil then
    return latestSectorId, latestStageIndex
  end
  return
end

function SectorStageData:CheckStagePassTmInRange(stageId, passTm)
  local stageRecord = self.stageRecordDic[stageId]
  if stageRecord == nil then
    return false
  end
  local passAt = stageRecord.passAt + passTm
  local stamp = PlayerDataCenter.timestamp
  return true, stageRecord.passAt + passTm < PlayerDataCenter.timestamp, stageRecord.passAt, stageRecord.passAt + passTm
end

function SectorStageData:GetIsStagePassedWithoutHelp(stageId)
  local stageRecord = self.stageRecordDic[stageId]
  if stageRecord == nil then
    return false
  end
  return stageRecord.noAstPassChallengeMode
end

function SectorStageData:GetGetUnlockInfo(stageId)
  local cfg = ConfigData.sector_stage[stageId]
  local lockInfo = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
  return lockInfo
end

function SectorStageData:GetCanCompleteStage(difficult)
  if difficult == eDifficulty.normal then
    for index = 1, #ConfigData.sector_sector_resident.sectorChapterIdList do
      local chapterId = ConfigData.sector_sector_resident.sectorChapterIdList[index]
      local chapterCfg = ConfigData.sector_sector_resident[chapterId]
      local sectorId = chapterCfg.relevancy_parameter
      local relevancyFunc = chapterCfg.relevancy_function
      local ignoreActDic = chapterCfg.allowActivityDic
      local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
      if not isAvgSector and self:IsSctChapterUnlock(chapterId) and SectorStageDetailHelper.IsSectorNoActCollide(relevancyFunc, true, ignoreActDic) then
        local normalStageList = ConfigData.sector_stage.sectorDiffDic[sectorId][eDifficulty.normal]
        for _, stageId in ipairs(normalStageList) do
          if self:IsStageUnlock(stageId) and not self:IsStageComplete(stageId) then
            return ConfigData.sector_stage[stageId]
          end
        end
      end
    end
    return nil
  elseif difficult == eDifficulty.nightmare then
    local stageCfg
    for _, sectorId in ipairs(ConfigData.sector.id_sort_list) do
      if not self:IsSectorUnlock(sectorId) then
        break
      end
      local isAvgSector = SectorStageDetailHelper.GetSectorIsAvgSector(sectorId)
      if not isAvgSector then
        local _, _, actFrameData = PlayerDataCenter.sectorEntranceHandler:GetActivityDataBySectorId(sectorId)
        if actFrameData == nil then
          local nightmareStageList = ConfigData.sector_stage.sectorDiffDic[sectorId][eDifficulty.nightmare]
          if nightmareStageList ~= nil and #nightmareStageList ~= 0 then
            local endStageId = nightmareStageList[#nightmareStageList]
            if not self:IsStageComplete(endStageId) then
              for _, stageId in ipairs(nightmareStageList) do
                if self:IsStageUnlock(stageId) and not self:IsStageComplete(stageId) then
                  local tempStage = ConfigData.sector_stage[stageId]
                  if tempStage ~= nil and (stageCfg == nil or stageCfg.combat > tempStage.combat) then
                    stageCfg = tempStage
                  end
                  break
                end
              end
            end
          end
        end
      end
    end
    return stageCfg
  end
end

local pnSdkTrackCfg = {
  [1105] = "stdhour1",
  [1112] = "stdhour3",
  [2103] = "levelnopurchase"
}
local overseaTrackCfg = {
  [100101] = "stage_100101",
  [100105] = "stage_100105",
  [1104] = "stage_1104",
  [1112] = "stage_1112",
  [2115] = "stage_2115",
  [3115] = "stage_0315",
  [4115] = "stage_0415",
  [5115] = "stage_0515",
  [6129] = "stage_0629"
}

function SectorStageData:_StageTrackEvent(stageId, state)
  if not cs_MicaSDKManager.Instance:IsUseSdk() then
    return
  end
  if self:IsStageComplete(stageId) then
    return
  end
  if Consts.GameChannelType.IsPnSdk() then
    local param = pnSdkTrackCfg[stageId]
    if param ~= nil then
      cs_MicaSDKManager.Instance:TrackEvent(param)
    end
  elseif Consts.GameChannelType.IsOversea() then
    local param = overseaTrackCfg[stageId]
    if param ~= nil then
      cs_MicaSDKManager.Instance:StatsEventPreSetUid(param)
    end
  end
end

return SectorStageData
