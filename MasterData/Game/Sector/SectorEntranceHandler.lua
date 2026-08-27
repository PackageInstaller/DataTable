local SectorEntranceHandler = class("SectorEntranceHandler")
local SectorHelpFuncDic = require("Game.Sector.SectorHelpFuncDic")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local SectorEntranceCheckFunc = require("Game.Sector.SectorEntranceCheckFunc")
local SectorStageDetailHelper = require("Game.Sector.SectorStageDetailHelper")
local SectorEnum = require("Game.Sector.SectorEnum")
local SectorLevelDetailEnum = require("Game.Sector.Enum.SectorLevelDetailEnum")
local LastPlayData = require("Game.Sector.Data.LastPlayData")
local cs_MessageCommon = CS.MessageCommon

function SectorEntranceHandler:__GetEnterChapterFunc(relevancyFunc)
  local enterFunc = SectorHelpFuncDic.EnterChapterFuncDic[relevancyFunc]
  if enterFunc == nil then
    error(string.format("unsupported EnterChapterFuncDic, relevancyFunc:%s", relevancyFunc))
    return
  end
  return enterFunc
end

function SectorEntranceHandler:Sector2ActData(sectorId)
  local chapterId, relevancyFunc, ignoreActDic
  if sectorId == SectorEnum.NewbeeSectorId then
    relevancyFunc = SectorEnum.SctRelevancyNormalSector
  else
    chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId]
    local chapterCfg = ConfigData.sector_sector_resident[chapterId]
    if chapterId == nil then
      error("Cant get sector_sector_resident by sectorId:" .. tostring(sectorId))
      return
    end
    relevancyFunc = chapterCfg.relevancy_function
    ignoreActDic = chapterCfg.allowActivityDic
  end
  return chapterId, relevancyFunc, ignoreActDic
end

function SectorEntranceHandler:EnterSctChapter(sectorId, difficuty, stageCfg)
  local isSectorUnlock = PlayerDataCenter.sectorEntranceHandler:CheckSectorValid(sectorId)
  if not isSectorUnlock then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Sector_Locked))
    return
  end
  if not SectorStageDetailHelper.IsSectorNoCollide(sectorId, true) then
    return
  end
  local chapterId, relevancyFunc, ignoreActDic = self:Sector2ActData(sectorId)
  if not SectorStageDetailHelper.IsSectorNoActCollide(relevancyFunc, nil, ignoreActDic or table.emptytable) then
    return
  end
  local enterFunc = self:__GetEnterChapterFunc(relevancyFunc)
  if enterFunc == nil then
    return
  end
  enterFunc(sectorId, difficuty, stageCfg)
  if chapterId and not PlayerDataCenter.sectorStage:IsSectorChapterUnlockShow(chapterId) then
    NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_ModifySectorUnlockVideo(chapterId)
    PlayerDataCenter.sectorStage:SetSectorChapterUnlockShow(chapterId)
  end
end

function SectorEntranceHandler:DealLeftPlayMode2Sector(lastPlayData, enterFunc, loadingAsyncOp)
  local isNeedLoadSector = true
  local fromWhere
  local enterFuncList = {enterFunc}
  local asyncFuncList = {loadingAsyncOp}
  
  local function AddEnterFunc(func)
    table.insert(enterFuncList, func)
  end
  
  local function AddAsyncFuncFunc(func)
    table.insert(asyncFuncList, func)
  end
  
  if lastPlayData == nil then
    lastPlayData = LastPlayData.New()
  end
  lastPlayData:SetLPDIsEnterOrReturn(false)
  local stageCfg = lastPlayData:GetLPDStageCfg()
  local dungeonLevelType = lastPlayData:GetLPDDngeonLevelType()
  local dungeonType = lastPlayData:GetLPDDngeonType()
  local seasonId = lastPlayData:GetLPDSeasonId()
  local actId = lastPlayData:GetLPDActId()
  local actType, actFrameData
  if seasonId ~= nil then
    fromWhere = AreaConst.WarChessSeason
    actType, actId, actFrameData = self:GetActivityDataBySeasonId(seasonId)
  elseif stageCfg ~= nil then
    local sectorId = lastPlayData:GetLastSectorId()
    fromWhere = AreaConst.Sector
    actType, actId, actFrameData = self:GetActivityDataBySectorId(sectorId)
    if actId == nil and stageCfg.is_brotato then
      actType, actId, actFrameData = self:GetActivityDataForBrotato(stageCfg.id)
    end
    if actId == nil then
      do
        local isWOrDChallenge, realEnterFunc = SectorHelpFuncDic.TryEnterWeeklyOrDailyChallengeFunc(lastPlayData)
        if isWOrDChallenge then
          AddEnterFunc(realEnterFunc)
          isNeedLoadSector = true
        else
          enterFunc = AddEnterFunc(function()
            if sectorId == SectorEnum.NewbeeSectorId and PlayerDataCenter.sectorStage:GetSelectSectorId() == nil then
              return
            end
            self:EnterSctChapter(sectorId)
          end)
          isNeedLoadSector = true
        end
      end
    end
  elseif dungeonType ~= nil then
    fromWhere = AreaConst.DungeonBattle
    local dunFunc = SectorHelpFuncDic.matDunFuncDic[dungeonType]
    if dunFunc ~= nil then
      local realEnterFunc
      isNeedLoadSector, realEnterFunc = dunFunc(dungeonType, lastPlayData)
      AddEnterFunc(realEnterFunc)
    end
  elseif dungeonLevelType ~= nil then
    fromWhere = AreaConst.DungeonBattle
    local dunFunc = SectorHelpFuncDic.dunFuncDic[dungeonLevelType]
    if dunFunc ~= nil then
      local realEnterFunc
      isNeedLoadSector, realEnterFunc = dunFunc(dungeonLevelType, lastPlayData)
      AddEnterFunc(realEnterFunc)
    end
  end
  if actId ~= nil then
    if actFrameData == nil then
      actFrameData = lastPlayData:GetLPDActData()
      if actFrameData ~= nil then
        actType = actFrameData:GetActivityFrameCat()
      end
    end
    local actFunc = SectorHelpFuncDic.actFuncDic[actType]
    if actFunc ~= nil then
      local realEnterFunc
      isNeedLoadSector, realEnterFunc = actFunc(actType, actId, actFrameData, lastPlayData, asyncFuncList)
      AddEnterFunc(realEnterFunc)
    end
  end
  if isNeedLoadSector then
    local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController, true)
    sectorCtrl:InitSectorCtrl(function()
      sectorCtrl:AddLoadCoCallback(function()
        for _, func in ipairs(enterFuncList) do
          if func ~= nil then
            func()
          end
        end
      end)
      sectorCtrl:SetFrom(fromWhere)
    end, function()
      for _, func in ipairs(asyncFuncList) do
        if func ~= nil then
          func()
        end
      end
    end)
  else
    for _, func in ipairs(enterFuncList) do
      if func ~= nil then
        func()
      end
    end
  end
end

function SectorEntranceHandler:DealUncompleteLevel4TryEnterSector()
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  if sectorCtrl == nil or not sectorCtrl:IsSectorNormalState() then
    return
  end
  local unCompleteEp, dungeonId, moduleId, canFloorOver = ExplorationManager:HasUncompletedEp()
  if unCompleteEp then
    local isOK = self:TryEnterAndOpenMainStage(dungeonId, true)
    if isOK then
      local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
      if sectorEntrance ~= nil then
        sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      end
      return
    end
  end
  local unComplete, dungeonId, moduleId, canFloorOver = WarChessManager:GetIsHaveUncompletedWarChess()
  if unComplete then
    local isOK = self:TryEnterAndOpenMainStage(dungeonId, true)
    if isOK then
      local sectorEntrance = UIManager:GetWindow(UIWindowTypeID.SectorEntrance)
      if sectorEntrance ~= nil then
        sectorEntrance:OnClickSEPageBtn(SectorEnum.ePageIndex.main)
      end
      return
    end
  end
end

function SectorEntranceHandler:TryEnterAndOpenMainStage(stageId, mustSameMap)
  local sectorCtrl = ControllerManager:GetController(ControllerTypeId.SectorController)
  local stageDiff, sectorId
  local sectorStageCfg = self:GetMainStageCfg(stageId)
  if sectorStageCfg == nil then
    return false
  end
  stageDiff = sectorStageCfg.difficulty
  sectorId = sectorStageCfg.sector
  local chapterId = ConfigData.sector_sector_resident.sectorId2ChapterIdMap[sectorId]
  if chapterId == nil then
    return false
  end
  local mapId
  mapId = ConfigData.sector_sector_resident[chapterId].map_id
  if mapId == nil then
    return false
  end
  
  local function enterChapterFunc()
    if SectorStageDetailHelper.IsSectorNoCollide(sectorId) then
      self:EnterSctChapter(sectorId, stageDiff, sectorStageCfg)
    end
  end
  
  local curMapId = sectorCtrl:GetSctCurMapId()
  if curMapId ~= mapId then
    if mustSameMap then
      return false
    end
    sectorCtrl:SetJumpInCallback(enterChapterFunc)
    sectorCtrl:SwitchSectorMap(mapId)
    return true
  end
  enterChapterFunc()
  return true
end

function SectorEntranceHandler:GetMainStageCfg(stageId)
  local sectorStageCfg = ConfigData.sector_stage[stageId]
  if sectorStageCfg == nil then
    local infoCfg = ConfigData.endless.levelDic[stageId]
    if infoCfg ~= nil then
      local endlessCfg = ConfigData.endless[infoCfg.sectorId][infoCfg.index]
      sectorStageCfg = {
        endlessCfg = endlessCfg,
        sector = infoCfg.sectorId,
        difficulty = SectorLevelDetailEnum.eDifficulty.infinity,
        dungeonId = endlessCfg.id
      }
    end
  end
  return sectorStageCfg
end

function SectorEntranceHandler:DealOpenAct(activityFrameData, lastPlayData)
  if activityFrameData == nil then
    local heroGrowCtrl = ControllerManager:GetController(ControllerTypeId.ActivityHeroGrow)
    if heroGrowCtrl ~= nil then
      local sectorId = lastPlayData.sectorId
      local heroGrowActId, heroGorwData, inRuning, inOpening = heroGrowCtrl:GetHeroGrowDataBySectorId(sectorId)
      if heroGrowActId ~= nil then
        local actFunc = SectorHelpFuncDic.actFuncDic[ActivityFrameEnum.eActivityType.HeroGrow]
        if actFunc ~= nil then
          local isNeedLoadSector, realEnterFunc = actFunc(nil, heroGrowActId, activityFrameData, lastPlayData, table.emptytable)
          if realEnterFunc ~= nil then
            realEnterFunc()
          end
          return isNeedLoadSector
        end
      end
    end
  end
  if activityFrameData == nil then
    return
  end
  if lastPlayData == nil then
    lastPlayData = LastPlayData.New()
  end
  lastPlayData:SetLPDIsEnterOrReturn(true)
  local actType = activityFrameData:GetActivityFrameCat()
  local actId = activityFrameData:GetActId()
  local actFunc = SectorHelpFuncDic.actFuncDic[actType]
  if actFunc ~= nil then
    local isNeedLoadSector, realEnterFunc = actFunc(actType, actId, activityFrameData, lastPlayData, table.emptytable)
    if realEnterFunc ~= nil then
      realEnterFunc()
    end
    return isNeedLoadSector
  end
end

function SectorEntranceHandler:CheckSectorValid(sectorId)
  local actType, actId, actFrameData = self:GetActivityDataBySectorId(sectorId)
  if actType ~= nil and SectorEntranceCheckFunc[actType] ~= nil then
    return SectorEntranceCheckFunc[actType](actId, sectorId, actFrameData)
  end
  return PlayerDataCenter.sectorStage:IsSectorUnlock(sectorId)
end

function SectorEntranceHandler:GetMainSectorBySectorId(sectorId)
  local sectorActivity = ConfigData.sector.sectorActivityDic[sectorId]
  if sectorActivity ~= nil then
    return sectorActivity.mainSector
  end
  return sectorId
end

function SectorEntranceHandler:GetMainSectorByActTypeAndId(actType, actId)
  local actTypeInfoDic = ConfigData.sector.actMainSector[actType]
  if actTypeInfoDic == nil then
    return nil
  end
  local actMainSectorCfg = actTypeInfoDic[actId]
  if actMainSectorCfg == nil then
    return nil
  end
  return actMainSectorCfg.mainSector
end

function SectorEntranceHandler:GetWarchessSeasonByActTypeAndId(actType, actId)
  local actTypeInfoDic = ConfigData.sector.actMainSector[actType]
  if actTypeInfoDic == nil then
    return nil
  end
  local actMainSectorCfg = actTypeInfoDic[actId]
  if actMainSectorCfg == nil then
    return nil
  end
  return actMainSectorCfg.warchessSeason
end

function SectorEntranceHandler.TrySpecialExitEp(lastSatgeData, successCallback)
  if lastSatgeData.stageCfg == nil then
    return false
  end
  local sectorId = lastSatgeData.stageCfg.sector
  local whiteDayCtrl = ControllerManager:GetController(ControllerTypeId.WhiteDay)
  local isSuccess = whiteDayCtrl ~= nil and whiteDayCtrl:TryEnterWDSector(sectorId, successCallback)
  if isSuccess then
    return true
  end
  local Winter23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityWinter23)
  
  local function realCallback()
    if successCallback then
      successCallback()
    end
    ActLbUtil.OnActLbInteractEnter(true)
    Winter23Ctrl:ReEnterWinter23MainEp(sectorId, function()
      ActLbUtil.OnActLbInteractEnter(false)
    end)
  end
  
  isSuccess = Winter23Ctrl ~= nil and Winter23Ctrl:TryEnterWTSector(sectorId, realCallback)
  if isSuccess then
    return true
  end
  local Carnival23Ctrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival23)
  
  local function realCallback()
    if successCallback then
      successCallback()
    end
    ActLbUtil.OnActLbInteractEnter(true)
    Carnival23Ctrl:ReEnterCarnival23MainEp(sectorId, function()
      ActLbUtil.OnActLbInteractEnter(false)
    end)
  end
  
  isSuccess = Carnival23Ctrl ~= nil and Carnival23Ctrl:TryEnterCarnivalSector(sectorId, realCallback)
  if isSuccess then
    return true
  end
  return false
end

function SectorEntranceHandler:GetActivityDataBySectorId(sectorId)
  local sectorActivity = ConfigData.sector.sectorActivityDic[sectorId]
  if sectorActivity == nil then
    return self:__GetActivitPluralDataBySectorId(sectorId)
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameId = actFrameCtrl:GetIdByActTypeAndActId(sectorActivity.type, sectorActivity.actId)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  return sectorActivity.type, sectorActivity.actId, actFrameData
end

function SectorEntranceHandler:GetActivityDataForBrotato(stageId)
  local brotatatoCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby)
  if brotatatoCtrl == nil then
    return nil, nil
  end
  return brotatatoCtrl:GetParentActivityData(stageId)
end

function SectorEntranceHandler:__GetActivitPluralDataBySectorId(sectorId)
  local sectorActivityList = ConfigData.sector.sectorActivityPluralDic[sectorId]
  if sectorActivityList == nil then
    return nil, nil
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  for _, sectorActivity in ipairs(sectorActivityList) do
    local actFrameId = actFrameCtrl:GetIdByActTypeAndActId(sectorActivity.type, sectorActivity.actId)
    local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
    if actFrameData ~= nil and actFrameData:IsActivityOpen() then
      return sectorActivity.type, sectorActivity.actId, actFrameData
    end
  end
  return nil, nil
end

function SectorEntranceHandler:GetActivityDataBySeasonId(seasonId)
  local warChessSeasonActivity = ConfigData.activity.warChessSeasonActivityDic[seasonId]
  if warChessSeasonActivity == nil then
    return
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameId = actFrameCtrl:GetIdByActTypeAndActId(warChessSeasonActivity.type, warChessSeasonActivity.actId)
  local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
  return warChessSeasonActivity.type, warChessSeasonActivity.actId, actFrameData
end

return SectorEntranceHandler
