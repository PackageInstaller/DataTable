local SectorLevelChapterController = class("SectorLevelChapterController", ControllerBase)
local base = ControllerBase
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local chapterData = require("Game.Sector.Data.SectorLevelChapterData")
local SectorChapterEnum = require("Game.Sector.Enum.SectorLevelChapterEnum")

function SectorLevelChapterController:ctor()
  self.chapterDataDic = {}
  self.chapterData = chapterData.New()
  self.chapterDataDic[SectorChapterEnum.chapterDataType.default] = self.chapterData
end

function SectorLevelChapterController:OnInit()
end

function SectorLevelChapterController:ChangeChapterDataType(chapterType)
  self.chapterDataDic[chapterType] = self.chapterDataDic[chapterType] or chapterData.New()
  self.chapterData = self.chapterDataDic[chapterType]
end

function SectorLevelChapterController:RemoveChapterDataType(chapterType)
  self.chapterDataDic[chapterType] = nil
end

function SectorLevelChapterController:SetIsFirstEnter(bool)
  self.chapterData:SetIsFirstEnter(bool)
end

function SectorLevelChapterController:GetIsFirstEnter()
  return self.chapterData:GetIsFirstEnter()
end

function SectorLevelChapterController:SetChapterBaseInfo(sectorId, isRepeat, closeCallback, isNeedRefreshChapter)
  local chapterId = self.chapterData:GetChapterId()
  if isNeedRefreshChapter then
    chapterId = nil
  end
  self.chapterData:SetChapterBaseInfo(sectorId, isRepeat, closeCallback, chapterId)
end

function SectorLevelChapterController:ResetSctLvChapterData()
  self.chapterData:ResetSctLvChapterData()
end

function SectorLevelChapterController:EnterChapterMainEpResident(sectorId, autoDifficulty, autoStageCfg, enterCallback, closeCallback, isShowSelect)
  self.chapterData:SetChapterBaseInfo(sectorId, false, nil)
  local levelList = self:GetLevelListByChapterId()
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    window:SetSpecialLevelList(levelList)
    window:InitSectorLevel(sectorId, closeCallback, autoDifficulty, autoStageCfg)
    window:SctLVShowSectorName(isShowSelect, true)
    if enterCallback then
      enterCallback()
    end
  end)
end

function SectorLevelChapterController:EnterChapterMainEp(sectorId, isRepeat, closeCallback, chapterId)
  self.chapterData:SetChapterBaseInfo(sectorId, isRepeat, closeCallback)
  local levelList
  if isRepeat then
    levelList = self:GetLevelListByRepeatId()
  elseif chapterId then
    levelList = self:GetLevelListByChapterId(chapterId)
  else
    levelList = self:GetLevelListByChapterId()
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.SectorLevel, function(window)
    if window == nil then
      return
    end
    window:SetSpecialState(isRepeat)
    window:SetSpecialLevelList(levelList)
    local autoStageId = self.chapterData:GetNowStageId()
    local stageCfg = autoStageId ~= nil and ConfigData.sector_stage[autoStageId] or nil
    window:InitSectorLevel(sectorId, closeCallback, 1, stageCfg)
    window:SetCustomExBattleStartCallback(function()
      ControllerManager:DeleteController(ControllerTypeId.ActivityLobbyCtrl)
      if self.chapterData:GetNowStageId() then
        self:SendRecordEnterInterface()
      end
    end)
    window:SetSelectCanEnterCallback(BindCallback(self, self.GiveSelectIsEnterStage))
  end)
end

function SectorLevelChapterController:ChangeMainEpChapter(chapterId)
  local levelList = self:GetLevelListByChapterId(chapterId)
  local sectorId = self:GetSectorId()
  local sectorLevelWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if sectorLevelWin then
    sectorLevelWin:SetSpecialState(false)
    sectorLevelWin:SetSpecialLevelList(levelList)
    sectorLevelWin:ChangeSectorDifficulty(1, sectorId)
  end
end

function SectorLevelChapterController:EnterMainEpRepeat()
  local levelList = self:GetLevelListByRepeatId()
  local sectorId = self:GetSectorId()
  local sectorLevelWin = UIManager:GetWindow(UIWindowTypeID.SectorLevel)
  if sectorLevelWin then
    sectorLevelWin:SetSpecialState(true)
    sectorLevelWin:SetSpecialLevelList(levelList)
    sectorLevelWin:ChangeSectorDifficulty(1, sectorId)
  end
end

function SectorLevelChapterController:SelectDiffChangeCallback(callback)
  self.diffChangeCallback = callback
end

function SectorLevelChapterController:ChangeMainEpSector(sectorId)
  self.diffChangeCallback(sectorId)
  local nowSectorId = self.chapterData:GetSectorId()
  if sectorId and sectorId == nowSectorId then
    return
  end
  self.chapterData:SetSectorId(sectorId)
  local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if detailWin and detailWin.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
  end
  local chapterId = self:GetNowChapterId()
  self:_FinEnterMainEp(chapterId)
end

function SectorLevelChapterController:ChangeMainEpRepeat()
  local isRepeat = self.chapterData:GetIsRepeat()
  isRepeat = not isRepeat
  self.chapterData:SetIsRepeat(isRepeat)
  local detailWin = UIManager:GetWindow(UIWindowTypeID.SectorLevelDetail)
  if detailWin and detailWin.active then
    UIUtil.OnClickBackByWinId(UIWindowTypeID.SectorLevelDetail)
  end
  local chapterId = self:GetNowChapterId()
  self:_FinEnterMainEp(chapterId)
  return isRepeat
end

function SectorLevelChapterController:_FinEnterMainEp(chapterId)
  if self.chapterData:GetIsRepeat() then
    self:EnterMainEpRepeat()
  else
    self:ChangeMainEpChapter(chapterId)
  end
end

function SectorLevelChapterController:GetLastUnCompleteChapter(sectorId)
  local winter23Chapters = ConfigData.sector_chapter_chapters
  local lastChapterId = 1
  local sectorId = sectorId or self:GetSectorId()
  local playMoudle = SectorStageDetailHelper.SectorPlayMoudle(sectorId)
  self.__lastEpStateCfg = SectorStageDetailHelper.TryGetUncompletedStateCfg(playMoudle)
  if winter23Chapters[sectorId] == nil then
    error("Cant get sector_chapter_chapters cfg, sectorId:" .. tostring(sectorId))
    return lastChapterId
  end
  for chapterId, cfg in pairs(winter23Chapters[sectorId]) do
    if #cfg.stage_id == 0 then
      break
    end
    lastChapterId = chapterId
    for _, levelId in pairs(cfg.stage_id) do
      local stageCfg = ConfigData.sector_stage[levelId]
      if not (PlayerDataCenter.sectorStage:IsStageComplete(levelId) or stageCfg.is_special) or self.__lastEpStateCfg and self.__lastEpStateCfg.id == levelId then
        return lastChapterId
      end
    end
  end
  return lastChapterId
end

function SectorLevelChapterController:GetLevelListByChapterId(chapterId)
  local chapters = ConfigData.sector_chapter_chapters
  local levelList = {}
  chapterId = chapterId or self:GetLastUnCompleteChapter()
  chapterId = math.clamp(chapterId, 1, 999)
  self.chapterData:SetChapterId(chapterId)
  local sectorId = self.chapterData:GetSectorId()
  for i, v in pairs(chapters[sectorId][chapterId].stage_id) do
    table.insert(levelList, v)
  end
  return levelList
end

function SectorLevelChapterController:GetLevelListByRepeatId()
  local sectorId = self:GetSectorId()
  return self.chapterData:GetRepeatStageList(sectorId)
end

function SectorLevelChapterController:GiveSelectIsEnterStage(stageId, callback)
  if self.chapterData:IsNotRepeatStageAndComplete(stageId) and PlayerDataCenter.cacheSaveData:GetEnableActivityWinter23NoRepeatTip() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    local repeatName = LanguageUtil.GetLocaleText(self.chapterData:GetRepeatName())
    local msg = string.format(ConfigData:GetTipContent(7130), repeatName)
    window:ShowTextBoxWithYesAndNo(msg, function()
      callback()
    end)
    window:ShowDontRemindTog(function(isOn)
      PlayerDataCenter.cacheSaveData:SetEnableActivityWinter23NoRepeatTip(not isOn)
    end)
  else
    callback()
  end
end

function SectorLevelChapterController:IsNotRepeatStage(stageId)
  return self.chapterData:IsNotRepeatStage(stageId)
end

function SectorLevelChapterController:SendRecordEnterInterface()
  local interfaceId = self.chapterData:GetIsRepeat() and 2 or 1
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Client_Enter_Interface(interfaceId, self.nowStageId)
end

function SectorLevelChapterController:RecordNowStageId(stageId)
  self.chapterData:SetNowStageId(stageId)
end

function SectorLevelChapterController:SetRepeatName(name)
  self.chapterData:SetRepeatName(name)
end

function SectorLevelChapterController:GetRepeatName()
  return self.chapterData:GetRepeatName()
end

function SectorLevelChapterController:SetMainName(name)
  self.chapterData:SetMainName(name)
end

function SectorLevelChapterController:GetMainName()
  return self.chapterData:GetMainName()
end

function SectorLevelChapterController:GetNowChapterId()
  local chapterId = self.chapterData:GetChapterId()
  if chapterId and self:GetIsSpecialShowChapter() then
    local maxChapter = self:_CalMaxChapter()
    if chapterId > maxChapter then
      self:SetNowChapterId(maxChapter)
      return maxChapter
    end
  end
  return chapterId
end

function SectorLevelChapterController:_CalMaxChapter()
  local sectorId = self:GetSectorId()
  local cfgList = ConfigData.sector_chapter_chapters[sectorId]
  local maxChapter = 1
  if not cfgList then
    return maxChapter
  end
  for i, cfg in ipairs(cfgList) do
    if 1 < i then
      local lastCfg = cfgList[i - 1]
      local lastStageId = lastCfg.last_stage_id ~= 0 and lastCfg.last_stage_id or lastCfg.stage_id[#lastCfg.stage_id]
      if PlayerDataCenter.sectorStage:IsStageComplete(lastStageId) then
        maxChapter = i
      end
    end
  end
  return maxChapter
end

function SectorLevelChapterController:SetNowChapterId(chapterId)
  self.chapterData:SetChapterId(chapterId)
end

function SectorLevelChapterController:GetSectorList()
  return self.chapterData:GetSectorList() or {}
end

function SectorLevelChapterController:SetSectorList(value)
  self.chapterData:SetSectorList(value)
end

function SectorLevelChapterController:GetChapterCfgList()
  local sectorId = self:GetSectorId()
  local cfgList = ConfigData.sector_chapter_chapters[sectorId]
  if self:GetIsSpecialShowChapter() then
    cfgList = self:_CalChapterSpecialShow(cfgList)
  end
  return cfgList or table.emptytable
end

function SectorLevelChapterController:_CalChapterSpecialShow(cfgList)
  local realList = {}
  if not cfgList then
    return realList
  end
  for i, cfg in ipairs(cfgList) do
    if i == 1 then
      table.insert(realList, cfg)
    else
      local lastCfg = cfgList[i - 1]
      local lastStageId = lastCfg.last_stage_id ~= 0 and lastCfg.last_stage_id or lastCfg.stage_id[#lastCfg.stage_id]
      if PlayerDataCenter.sectorStage:IsStageComplete(lastStageId) then
        table.insert(realList, cfg)
      end
    end
  end
  return realList
end

function SectorLevelChapterController:GetChapterLooked(chapterId)
  local reads = self.chapterData:GetChapterReads()
  if not reads then
    return false
  end
  if self:GetIsSpecialShowChapter() then
    self:SetChapterLooked(chapterId)
  end
  return reads[chapterId]
end

function SectorLevelChapterController:SetChapterLooked(chapterId)
  self.chapterData:SetChapterReads(chapterId)
end

function SectorLevelChapterController:GetIsChapterRedOpen()
  return self.chapterData:GetIsChapterRedOpen()
end

function SectorLevelChapterController:SetIsChapterRedOpen(value)
  self.chapterData:SetIsChapterRedOpen(value)
end

function SectorLevelChapterController:GetRedChapterIndex()
  return self.chapterData:GetRedChapterIndex()
end

function SectorLevelChapterController:SetRedChapterIndex(value)
  self.chapterData:SetRedChapterIndex(value)
end

function SectorLevelChapterController:GetSectorId()
  return self.chapterData:GetSectorId()
end

function SectorLevelChapterController:SetSectorId(value)
  self.chapterData:SetSectorId(value)
end

function SectorLevelChapterController:GetIsRepeat()
  return self.chapterData:GetIsRepeat()
end

function SectorLevelChapterController:SetIsRepeat(value)
  self.chapterData:SetIsRepeat(value)
end

function SectorLevelChapterController:GetRepeatArrangeType()
  return self.chapterData:GetRepeatArrangeType()
end

function SectorLevelChapterController:SetRepeatArrangeType(value)
  self.chapterData:SetRepeatArrangeType(value)
end

function SectorLevelChapterController:GetChapterOpenTime()
  local cfg = ConfigData.sector_chapter_chapters[self:GetSectorId()]
  if cfg == nil then
    error("Cant get sector_chapter_chapters, sectorId:" .. tostring(self:GetSectorId()))
    return
  end
  local chapterCfg = cfg[self:GetNowChapterId()]
  if cfg == nil then
    error(string.format("Cant get sector_chapter_chapters, sectorId:%s,chapterId:%s", self:GetSectorId(), self:GetNowChapterId()))
    return
  end
  return chapterCfg.open_timestamp
end

function SectorLevelChapterController:GetCloseRepeatShow()
  return self.chapterData:GetCloseRepeatShow()
end

function SectorLevelChapterController:SetCloseRepeatShow(value)
  self.chapterData:SetCloseRepeatShow(value)
end

function SectorLevelChapterController:GetIsSpecialShowChapter()
  return self.chapterData:GetIsSpecialShowChapter()
end

function SectorLevelChapterController:SetIsSpecialShowChapter(value)
  self.chapterData:SetIsSpecialShowChapter(value)
end

function SectorLevelChapterController:GetNowChapterCfg()
  return self.chapterData:GetNowChapterCfg()
end

function SectorLevelChapterController:GetChapterIdByRepeatStageId(stageId)
  local cfg = ConfigData.sector_chapter_farm_desc[stageId]
  if cfg == nil then
    error("repeat cfg is null, stageId :" .. tostring(stageId))
  end
  return cfg.chapter_id
end

function SectorLevelChapterController:GetChapterCfgByChapterId(chapterId)
  local sectorId = self.chapterData:GetSectorId()
  return ConfigData.sector_chapter_chapters[sectorId][chapterId]
end

function SectorLevelChapterController:GetNowMaxChapter()
  local maxChapter = self:_CalMaxChapter()
  return maxChapter
end

return SectorLevelChapterController
