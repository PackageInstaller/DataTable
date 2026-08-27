local base = require("Game.ActivityFrame.ActivityBase")
local ActivitySectorIIData = class("ActivitySectorIIData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local ActTechRowData = require("Game.ActivitySectorII.Tech.Data.ActTechRowData")
local ActTechData = require("Game.ActivitySectorII.Tech.Data.ActTechData")
local SectorIIDungeonData = require("Game.ActivitySectorII.Dungeon.Data.SectorIIDungeonData")
local SectorIISectorLevelData = require("Game.ActivitySectorII.MainMap.Data.SectorIISectorLevelData")
local ConditionListener = require("Game.Common.CheckCondition.ConditonListener.ConditionListener")
local SectorIIChallengeDgData = require("Game.ActivitySectorII.Dungeon.Data.SectorIIChallengeDgData")
local TaskEnum = require("Game.Task.TaskEnum")
local ActivitySectorIIEnum = require("Game.ActivitySectorII.ActivitySectorIIEnum")
local actType = ActivityFrameEnum.eActivityType.SectorII
local conditonHeader = {techRow = 100000, tech = 200000}

function ActivitySectorIIData:ctor()
  self.frameActId = nil
  self.actId = nil
  self.actTechType = nil
  self.sectorId = nil
  self.mapDataList = {}
  self.firstLevelData = nil
  self.ActTechDataDic = {}
  self.ActTechRowDataList = {}
  self.DunDataDic = nil
  self.DunOrderList = nil
  self.dunTicketId = nil
  self.actPointId = nil
  self.techId = nil
  self.birdMsg = nil
  self.dunLastSuitDic = nil
  self.dunLastFormatIdDic = nil
  self.sectorIIRedDotRootNode = nil
  self.__conditionListener = ConditionListener.New()
end

function ActivitySectorIIData:InitActSectorIIData(actId)
  self.actId = actId
  base.SetActFrameDataByType(self, ActivityFrameEnum.eActivityType.SectorII, actId)
  local activityController = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameId = activityController:GetIdByActTypeAndActId(ActivityFrameEnum.eActivityType.SectorII, self.actId)
  self.frameActId = frameId
  local sectorIICfg = ConfigData.activity_winter[actId]
  self.dunTicketId = sectorIICfg.cost_id
  self.actPointId = sectorIICfg.point
  self.techId = sectorIICfg.point_tech
  self._actWinterCfg = sectorIICfg
  self:InitSectorIIReddot()
  self:RefreshSectorIIReddot4Task()
  self:RefreshSectorIIShopReddot()
  self:GenAWSectorDatas(sectorIICfg.main_sector)
  self:GenAWTechDatas(actId, sectorIICfg)
  self:GenAWDunDatas(actId, sectorIICfg)
  self:_GenChallengeData()
end

function ActivitySectorIIData:OnSectorIIMsgInitOver()
  for actTechId, atcTechData in pairs(self.ActTechDataDic) do
    if not atcTechData:GetIsUnlock() then
      local unlockCfg = atcTechData:GetUnlockCfg()
      self.__conditionListener:AddConditionChangeListener(conditonHeader.tech + actTechId, function()
        self:RefreshSectorIIReddot4Tech()
      end, unlockCfg.pre_condition, unlockCfg.pre_para1, unlockCfg.pre_para2)
    end
  end
end

function ActivitySectorIIData:GenAWSectorDatas(sectorId)
  self.sectorId = sectorId
  
  local function Add2List(cfg, isStage)
    local mapData
    if isStage then
      local stageExtra = ConfigData.activity_winter_sector_stage_extra[self.sectorId][cfg.id]
      mapData = SectorIISectorLevelData.CreateSectorIIEpLevelData(self.sectorId, cfg, stageExtra)
    else
      local avgExtrCfg = ConfigData.activity_winter_sector_story_extra[self.sectorId][cfg.id]
      mapData = SectorIISectorLevelData.CreateSectorIIStoryLevelData(self.sectorId, cfg, avgExtrCfg)
    end
    table.insert(self.mapDataList, mapData)
    return mapData
  end
  
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local sectorStageCfg = ConfigData.sector_stage.sectorDiffDic[self.sectorId][ExplorationEnum.eDifficultType.Normal]
  local lastLevelData
  local levelMapDic = {}
  for _, stageId in ipairs(sectorStageCfg) do
    local stage = ConfigData.sector_stage[stageId]
    local levelMapData = Add2List(stage, true)
    local isIsolated = ConfigData.activity_winter_sector_stage_extra[self.sectorId][stageId].is_isolated
    if levelMapData ~= nil then
      levelMapDic[stageId] = levelMapData
      if not isIsolated then
        if lastLevelData ~= nil then
          levelMapData:AddAParentSIILevel(lastLevelData)
          lastLevelData:AddAChildSIILevel(levelMapData)
        end
        lastLevelData = levelMapData
      end
    end
  end
  self.firstLevelData = self.mapDataList[1]
  for _, stageId in ipairs(sectorStageCfg) do
    local levelMapData = levelMapDic[stageId]
    if levelMapData ~= nil then
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 1)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 1, i)
        if avgCfg ~= nil then
          local preLevelMapData = Add2List(avgCfg, false)
          if preLevelMapData ~= nil then
            levelMapData:SwiftParent2SIILevel(preLevelMapData)
            levelMapData:AddAParentSIILevel(preLevelMapData)
            preLevelMapData:AddAChildSIILevel(levelMapData)
            if self.firstLevelData == levelMapData then
              self.firstLevelData = preLevelMapData
            end
          end
        end
      end
      local para2num = avgPlayCtrl:GetMainAvgPara2Num(stageId, 2)
      for i = 0, para2num - 1 do
        local avgCfg = avgPlayCtrl:TryGetAvgCfg(eAvgTriggerType.MainAvg, stageId, 2, i)
        if avgCfg ~= nil then
          local afterLevelMapData = Add2List(avgCfg, false)
          if afterLevelMapData ~= nil then
            local childList = levelMapData:GetSIILevelChildList()
            if childList ~= nil then
              for _, chidLevelData in pairs(levelMapData:GetSIILevelChildList()) do
                chidLevelData:ReplaceSIILevelParent(levelMapData, afterLevelMapData)
                afterLevelMapData:AddAChildSIILevel(chidLevelData)
              end
            end
            afterLevelMapData:AddAParentSIILevel(levelMapData)
            levelMapData:CleanSIILevelChildList()
            levelMapData:AddAChildSIILevel(afterLevelMapData)
          end
        end
      end
    end
  end
  local storyExtrCfgDic = ConfigData.activity_winter_sector_story_extra[self.sectorId]
  if storyExtrCfgDic ~= nil then
    for story_id, cfg in pairs(storyExtrCfgDic) do
      if cfg.is_isolated then
        local avgCfg = ConfigData.story_avg[story_id]
        if avgCfg ~= nil then
          local afterLevelMapData = Add2List(avgCfg, false)
        end
      end
    end
  end
  self:RefreshSectorIIReddot4Avg()
end

function ActivitySectorIIData:RefreshAWSectorLevelState()
  for _, levelData in pairs(self.mapDataList) do
    levelData:RefreshSIILevelState()
  end
end

function ActivitySectorIIData:GenAWTechDatas(actId, sectorIICfg)
  local actTechType = sectorIICfg.activity_tech_type
  self.actTechType = actTechType
  local actTechTypeInfo = ConfigData.activity_tech.actTechTypeList[actTechType]
  for index, actTechId in ipairs(actTechTypeInfo.techIds) do
    local atcTechData = ActTechData.CreatAWTechData(actTechId, actType, self.actId)
    self.ActTechDataDic[actTechId] = atcTechData
  end
  for actTechId, atcTechData in pairs(self.ActTechDataDic) do
    local previousTech = atcTechData:GetPreTechId()
    if previousTech ~= nil then
      atcTechData:SetPreTechData(self.ActTechDataDic[previousTech])
    end
  end
  for rowId, techIdList in pairs(actTechTypeInfo.techRowIdDic) do
    local techDataDic = {}
    for _, actTechId in pairs(techIdList) do
      techDataDic[actTechId] = self.ActTechDataDic[actTechId]
    end
    local lineData = ActTechRowData.CreateTechRowData(rowId, techDataDic)
    table.insert(self.ActTechRowDataList, lineData)
    if lineData:GetIsHaveTechAvg() and not lineData:GetIsTechAvgCompleted() then
      do
        local avgCfg = lineData:GetIsTechAvgCfg()
        self.__conditionListener:AddConditionChangeListener(conditonHeader.techRow + rowId, function()
          lineData:RefreshTechAvgState()
          self:RefreshSectorIIReddot4TechAvg()
        end, avgCfg.pre_condition, avgCfg.pre_para1, avgCfg.pre_para2)
      end
    end
  end
  table.sort(self.ActTechRowDataList, function(a, b)
    local aOrder = a:GetRowOrder()
    local bOrder = b:GetRowOrder()
    return aOrder < bOrder
  end)
  self:RefreshSectorIIReddot4Tech()
  self:RefreshSectorIIReddot4TechAvg()
end

function ActivitySectorIIData:GenAWDunDatas(actId, sectorIICfg)
  self.DunDataDic = {}
  local actDungeonLevelType = sectorIICfg.level_type
  local levelTypeCfg = ConfigData.activity_winter_level_type[actId][actDungeonLevelType]
  local posType = levelTypeCfg.pos_id
  self.DunOrderList = levelTypeCfg.dungeon_levels
  for index, dunStageId in ipairs(self.DunOrderList) do
    local extraCfg = ConfigData.activity_winter_dungeon_detail[dunStageId]
    local posCfg = ConfigData.activity_winter_level_pos[posType][index]
    local dungeonData = SectorIIDungeonData.New(dunStageId, self.actInfo, index)
    dungeonData:SetSectorIIDungeonExtraData(posCfg, extraCfg)
    self.DunDataDic[dunStageId] = dungeonData
  end
end

function ActivitySectorIIData:_GenChallengeData()
  local sectorIICfg = self:GetActvWinterCfg()
  local lvTypeCfg = ConfigData.activity_winter_level_type[sectorIICfg.id][sectorIICfg.hard_level_type]
  if #lvTypeCfg.dungeon_levels == 0 then
    error("Cant gen ChallengeData")
    return
  end
  local dungeonId = lvTypeCfg.dungeon_levels[1]
  self._challengeDnData = SectorIIChallengeDgData.New(dungeonId, self)
end

function ActivitySectorIIData:UpdSctIIWinChallengeData(msgVerify)
  self._challengeDnData:UpdSctIIChallengeDgData(msgVerify)
end

function ActivitySectorIIData:GetActvWinChallengeDgData()
  return self._challengeDnData
end

function ActivitySectorIIData:GetActvWinterCfg()
  return ConfigData.activity_winter[self.actId]
end

function ActivitySectorIIData:RefreshAWTechDatas(techMsg)
  if techMsg ~= nil then
    for techId, activityTechElem in pairs(techMsg.techData) do
      local techData = self.ActTechDataDic[techId]
      techData:UpdateWATechByMsg(activityTechElem)
    end
  end
  self:RefreshSectorIIReddot4Tech()
  return self.ActTechDataDic
end

function ActivitySectorIIData:RefreshAWTechData(activityTechElem)
  local techId = activityTechElem.id
  local techData = self:GetTechById(techId)
  if techData ~= nil then
    techData:UpdateWATechByMsg(activityTechElem)
  end
  self:RefreshSectorIIReddot4Tech()
  return techData
end

function ActivitySectorIIData:SetSectorIIBirdData(birdMsg)
  self.birdMsg = birdMsg
end

function ActivitySectorIIData:SetSectorIIDungeonSuitData(dungeonSuits)
  self.dunLastSuitDic = {}
  self.dunLastFormatIdDic = {}
  for _, dungeonSuitElem in ipairs(dungeonSuits) do
    self.dunLastSuitDic[dungeonSuitElem.dungoenId] = dungeonSuitElem.suit
    self.dunLastFormatIdDic[dungeonSuitElem.dungoenId] = dungeonSuitElem.formId
  end
end

function ActivitySectorIIData:GetSectorIITechRowDataList()
  return self.ActTechRowDataList
end

function ActivitySectorIIData:GetSectorIIDungeonDataDic()
  return self.DunDataDic, self.DunOrderList
end

function ActivitySectorIIData:GetSectorIIActFrameId()
  return self.frameActId
end

function ActivitySectorIIData:GetSectorIIActId()
  return self.actId
end

function ActivitySectorIIData:GetSectorIISectorId()
  return self.sectorId
end

function ActivitySectorIIData:GetSectorIISectorMapDataList()
  return self.mapDataList
end

function ActivitySectorIIData:GetSectorIISectorMapNeedFocusData()
  local firstLevelParentlist = self.firstLevelData:GetSIILevelParentList()
  if firstLevelParentlist ~= nil and table.count(firstLevelParentlist) > 0 then
    error("not actually first level")
  end
  
  local function FindFirstNotPlayLevel(levelData)
    if levelData:GetIsLevelUnlock() and not levelData:GetIsLevelClaer() then
      return levelData
    end
    local childList = levelData:GetSIILevelChildList()
    if childList ~= nil then
      for _, childLevelData in pairs(childList) do
        local answer = FindFirstNotPlayLevel(childLevelData)
        if answer ~= nil then
          return answer
        end
      end
    end
  end
  
  return FindFirstNotPlayLevel(self.firstLevelData)
end

function ActivitySectorIIData:GetSectorIIDunTicketId()
  return self.dunTicketId
end

function ActivitySectorIIData:GetSectorIIDunPointId()
  return self.actPointId
end

function ActivitySectorIIData:GetTechId()
  return self.techId
end

function ActivitySectorIIData:GetSectorIITokenId()
  return self._actWinterCfg.token
end

function ActivitySectorIIData:GetSectorIIIShopList()
  return self._actWinterCfg.shop_list
end

function ActivitySectorIIData:GetSectorIIReprintShopId()
  return self._actWinterCfg.remaster_store_jump
end

function ActivitySectorIIData:GetSectorIIReprintShopIcon()
  return self._actWinterCfg.remaster_store_jump_icon
end

function ActivitySectorIIData:GetActivityFrameData()
  local activityController = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local activityFrameData = activityController:GetActivityFrameData(self.frameActId)
  return activityFrameData
end

function ActivitySectorIIData:GetSectorIIActivityTaskList()
  return self._actWinterCfg.task_list
end

function ActivitySectorIIData:GetTechById(techId)
  return self.ActTechDataDic[techId]
end

function ActivitySectorIIData:GetSectorIIFlappyBirdId()
  if self.birdMsg == nil then
    error("not get birdMsg")
  end
  return self.birdMsg.birdId
end

function ActivitySectorIIData:GetSectorIIFlappyBirdMineMaxScore()
  if self.birdMsg == nil then
    error("not get birdMsg")
  end
  return self.birdMsg.highestScore
end

function ActivitySectorIIData:SetSectorIIFlappyBirdMineMaxScore(score)
  if self.birdMsg == nil then
    error("not get birdMsg")
  end
  if (score or 0) < self.birdMsg.highestScore then
    warn("highest score not above current highest score")
    return
  end
  self.birdMsg.highestScore = score
end

function ActivitySectorIIData:GetSectorIIFlappyBirdIsJoinRewards()
  if self.birdMsg == nil then
    error("not get birdMsg")
  end
  return self.birdMsg.joinRewards
end

function ActivitySectorIIData:SetSectorIIFlappyBirdIsJoinRewards(bool)
  if self.birdMsg == nil then
    error("not get birdMsg")
  end
  self.birdMsg.joinRewards = bool
end

function ActivitySectorIIData:GetLastCompleteDungeonSuitDic()
  return self.dunLastSuitDic
end

function ActivitySectorIIData:GetLastCompleteDungeonFormatIdDic()
  return self.dunLastFormatIdDic
end

function ActivitySectorIIData:GetBeDefeatJumpList()
  return self._actWinterCfg.defeat_jump
end

function ActivitySectorIIData:GetSectorIIFirstEnterAvgId()
  return self._actWinterCfg.first_avg
end

function ActivitySectorIIData:GetSectorIIStoreInfo()
  return self._actWinterCfg.remaster_store_info
end

function ActivitySectorIIData:GetSectorIIActivityIsRemaster()
  return self._actWinterCfg.remaster_id ~= 0
end

function ActivitySectorIIData:GetSectorII_ChipSuitLimitNumAdd()
  local logicAdd = PlayerDataCenter.playerBonus:Get_Activity_ChipGroupCarryLimitAdd(self.frameActId)
  return logicAdd
end

function ActivitySectorIIData:GetSectorII_ChipSuitPool()
  local chipPoolQualityDic = PlayerDataCenter.playerBonus:Get_Activity_ChipGroupLevel(self.frameActId)
  local chipPoolList = {}
  for chipPoolId, quality in pairs(chipPoolQualityDic) do
    table.insert(chipPoolList, chipPoolId)
  end
  return chipPoolList, chipPoolQualityDic
end

function ActivitySectorIIData:GetSectorII_Wait4UnlockChipSuit()
  local chipPoolQualityDic = PlayerDataCenter.playerBonus:Get_Activity_ChipGroupLevel(self.frameActId)
  local thisActCouldUseChipSuitDic = ConfigData.activity_tech.couldUnlockChipSuitDic[self.frameActId]
  local wait4UnlockChipSuitList = {}
  local wait4UnlockChipSuitUnlockInfoList = {}
  for chipSuitId, techId in pairs(thisActCouldUseChipSuitDic) do
    if chipPoolQualityDic[chipSuitId] == nil then
      table.insert(wait4UnlockChipSuitList, chipSuitId)
      local techData = self.ActTechDataDic[techId]
      table.insert(wait4UnlockChipSuitUnlockInfoList, {
        index = 0,
        str = techData:GetAWTechName()
      })
    end
  end
  return wait4UnlockChipSuitList, wait4UnlockChipSuitUnlockInfoList
end

function ActivitySectorIIData:GetSectorII_PointMultRat()
  local itemRateDic = PlayerDataCenter.playerBonus:Get_Activity_PointMultRate(self.frameActId)
  return itemRateDic
end

function ActivitySectorIIData:GetSectorII_EffiMultRate()
  local rate = PlayerDataCenter.playerBonus:Get_Activity_EffiMultRate(self.frameActId)
  return rate
end

function ActivitySectorIIData:GetSectorII_IsTurnOnMultEffi()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return saveUserData:GetSectorIIIsTurnOnMultEfficient(self.actId)
end

function ActivitySectorIIData:SetSectorII_IsTurnOnMultEffi(bool)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetSectorIIIsTurnOnMultEfficient(self.actId, bool)
end

function ActivitySectorIIData:GetSectorII_UnlockedBuffList()
  local actBuffUnlockDic = PlayerDataCenter.playerBonus:Get_Activity_UnlockBuff(self.frameActId)
  return actBuffUnlockDic
end

function ActivitySectorIIData:GetSectorII_DelectedBuffList()
  local actBuffDelectDic = PlayerDataCenter.playerBonus:Get_Activity_DeleteBuff(self.frameActId)
  return actBuffDelectDic
end

function ActivitySectorIIData:InitSectorIIReddot()
  local isOk, actSingleNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle)
  if isOk then
    self.sectorIIRedDotRootNode = actSingleNode:AddChild(self.frameActId)
    self.sectorIIRedDotRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIIavg)
    self.sectorIIRedDotRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIITask)
    self.sectorIIRedDotRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.dungeon)
    local techRootNode = self.sectorIIRedDotRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techRoot)
    techRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.tech)
    techRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techAvg)
    self.sectorIIRedDotRootNode:AddChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.recommendShop)
  else
    error("can't get ActivitySingle node")
  end
end

function ActivitySectorIIData:RefreshSectorIIReddotWhenActEnd()
  self:RefreshSectorIIReddot4Avg()
  self:RefreshSectorIIReddot4Dundeon()
  self:RefreshSectorIIReddot4Tech()
  self:RefreshSectorIIReddot4TechAvg()
end

function ActivitySectorIIData:RefreshSectorIIReddot4Avg()
  local notClearAvgNum = 0
  if self:IsActivityRunning() then
    for _, levelData in pairs(self.mapDataList) do
      if not levelData:GetIsBattle() and levelData:GetIsLevelUnlock() and not levelData:GetIsLevelClaer() then
        notClearAvgNum = notClearAvgNum + 1
        break
      end
    end
  end
  self:SetSectorIIReddot(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIIavg, notClearAvgNum)
end

function ActivitySectorIIData:RefreshSectorIIReddot4Dundeon()
  local num = 0
  if self:IsActivityRunning() then
    for dunStageId, sectorIIDungeonData in pairs(self.DunDataDic) do
      if sectorIIDungeonData:GetIsLevelUnlock() and not sectorIIDungeonData:GetIsLevelComplete() then
        num = num + 1
        break
      end
    end
  end
  self:SetSectorIIReddot(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.dungeon, num)
end

function ActivitySectorIIData:RefreshSectorIIReddot4Task()
  local num = 0
  local taskList = self:GetSectorIIActivityTaskList()
  for _, taskId in pairs(taskList) do
    local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
    if taskData ~= nil and taskData:CheckComplete() then
      num = num + 1
      break
    end
  end
  self:SetSectorIIReddot(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIITask, num)
end

function ActivitySectorIIData:RefreshSectorIIReddot4Tech()
  local num = 0
  if self:IsActivityRunning() then
    for techId, techData in pairs(self.ActTechDataDic) do
      if techData:IsCouldLevelUp() then
        num = num + 1
        break
      end
    end
  end
  local reddotNode = self.sectorIIRedDotRootNode:GetChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techRoot)
  local techNode = reddotNode:GetChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.tech)
  techNode:SetRedDotCount(num)
end

function ActivitySectorIIData:RefreshSectorIIReddot4TechAvg()
  local num = 0
  if self:IsActivityRunning() then
    for techId, techRowData in pairs(self.ActTechRowDataList) do
      if techRowData:GetIsTechAvgUnlock() and not techRowData:GetIsTechAvgCompleted() then
        num = num + 1
        break
      end
    end
  end
  local reddotNode = self.sectorIIRedDotRootNode:GetChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techRoot)
  local avgNode = reddotNode:GetChild(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.techAvg)
  avgNode:SetRedDotCount(num)
end

function ActivitySectorIIData:RefreshSectorIIShopReddot()
  local num = 0
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local shopList = self:GetSectorIIIShopList()
  for _, shopId in pairs(shopList) do
    local isLooked = saveUserData:GetSectorIIRecommendShopIsLooked(shopId)
    if not isLooked then
      local shopCfg = ConfigData.shop[shopId]
      local isRecommend = shopCfg.is_recommended
      local isHaveRecommendGood
      if not isRecommend then
        local shopCtrl = ControllerManager:GetController(ControllerTypeId.Shop, true)
        shopCtrl:GetShopData(shopId, function(shopData)
          for shelfId, goodData in pairs(shopData.shopGoodsDic) do
            if goodData.isRecommendGood and not goodData.isSoldOut then
              isHaveRecommendGood = true
              break
            end
          end
        end, true)
      end
      if isRecommend or isHaveRecommendGood then
        num = num + 1
        break
      end
    end
  end
  self:SetSectorIIReddot(ActivitySectorIIEnum.eActSectorIIRedDotTypeId.recommendShop, num)
end

function ActivitySectorIIData:SetSectorIIReddot(typeId, num)
  local reddotNode = self.sectorIIRedDotRootNode:GetChild(typeId)
  reddotNode:SetRedDotCount(num)
end

function ActivitySectorIIData:OffsetSectorIIReddot(typeId, offsetNum)
  local reddotNode = self.sectorIIRedDotRootNode:GetChild(typeId)
  reddotNode:OffsetRedDotCount(offsetNum)
end

function ActivitySectorIIData:__IsHaveReadDot()
  local isOk, taskReddotNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.ActivitySingle, self.frameActId, ActivitySectorIIEnum.eActSectorIIRedDotTypeId.sectorIITask)
  if isOk then
    return taskReddotNode:GetRedDotCount() > 0
  end
end

function ActivitySectorIIData:GetActivityReddotNum()
  local isBlue, num
  isBlue = not self:__IsHaveReadDot()
  num = self.sectorIIRedDotRootNode:GetRedDotCount()
  return isBlue, num
end

function ActivitySectorIIData:GetActSctIIDataAutoSelectStage()
  return nil
end

function ActivitySectorIIData:Delete()
  self.__conditionListener:Delete()
end

return ActivitySectorIIData
