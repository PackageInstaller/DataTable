local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActAnniversary24Data = class("ActAnniversary24Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.ActAnniversary24
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local ActAnniversary24Enum = require("Game.ActivityAnniversary24.Data.ActAnniversary24Enum")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataMul = require("Game.ActivityFrame.ActTermTaskDataMul")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ReinforceCardDataAll = require("Game.Reinforce.Data.ReinforceCardDataAll")

function ActAnniversary24Data:InitActData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_anniversary24_main[msg.actId]
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:__InitRecommendTaskCfg()
  self:UpdateAnniversary24Data(msg)
  self:RefreshRedAnniversary24DailyTask()
  self:RefreshRedAnniversary24OnceTask()
  self:RefreshRedAnni24Main()
  self:RefreshRedAnni24HandBookCollection()
  self:RefreshRedAnni24InifinityRankReward()
  self.__UpdateChildActivityRedCallback = BindCallback(self, self.__UpdateChildActivityRed)
  self._childActivityRedDic = {}
  self:__InitChildActivityRedListen()
end

function ActAnniversary24Data:UpdateAnniversary24Data(msg)
  if self._rfCardDataAll == nil then
    self._rfCardDataAll = ReinforceCardDataAll.New()
    self._rfCardDataAll:InitRfCardDataAll(msg.reinforceCard, self:GetActFrameId())
  else
    self._rfCardDataAll:UpdRfCardDataAll(msg.reinforceCard)
  end
  if msg.reinforceCard.factorUpdate ~= nil then
    local ReinforceCardDataFactor = require("Game.Reinforce.Data.ReinforceCardDataFactor")
    local cardData = ReinforceCardDataFactor.New()
    cardData:InitRfCardDataFac(msg.reinforceCard.factorUpdate)
    self._rfCardDataAll:AddRfFactorCardData(cardData)
  end
  self.recordSectorId = msg.recordSectorId
  self.highExploration = msg.highExploration
  self.getLenReward = msg.getLenReward
  self:RefreshRedAnni24InifinityRankReward()
  self:RefreshRedAnni24InifinityLayerReward()
end

function ActAnniversary24Data:GetActAnv24RfCardDataAll()
  return self._rfCardDataAll
end

function ActAnniversary24Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedAnni24DailyTaskCallback = BindCallback(self, self.RefreshRedAnniversary24DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedAnni24DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedAnni24DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedAnni24DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActAnniversary24Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataMul.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedAnni24OnceTaskCallback = BindCallback(self, self.RefreshRedAnniversary24OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedAnni24OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedAnni24OnceTaskCallback)
end

function ActAnniversary24Data:RefreshRedAnniversary24DailyTask()
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = self:GetActChildRedDot(ActAnniversary24Enum.reddotType.DailyTask)
  if childReddot == nil then
    return
  end
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnniversary24OnceTask()
  local childReddot = self:GetActChildRedDot(ActAnniversary24Enum.reddotType.OnceTask)
  if childReddot == nil then
    return
  end
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnniversary24Shop()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActAnniversary24Enum.reddotType.Shop)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, v in ipairs(self._mainCfg.shop_list) do
    if not userDataCache:GetAnni24ShopLooked(self:GetActId(), v) then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnni24Main()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local flag = false
  local childReddot = reddot:AddChild(ActAnniversary24Enum.reddotType.main)
  local enterFlag, defaultSectorId = self:GetLastAnniversary24MainSector()
  if not enterFlag then
    flag = true
  else
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    if avgPlayCtrl:IsPlayedAllMainAvg(defaultSectorId, 1, nil, nil, true) ~= 0 then
      flag = true
    end
  end
  if not self:IsActivityRunning() then
    flag = false
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnni24HandBookCollection()
  local reddot = self:GetActivityReddot()
  local threeInOneNode = reddot:AddChild(ActAnniversary24Enum.reddotType.ThreeInOne)
  local childReddot = threeInOneNode:AddChild(ActAnniversary24Enum.reddotSubType.HandBookCollection)
  if childReddot == nil then
    return
  end
  local flag = false
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local collectionRate, collectionCount = self._rfCardDataAll:GetAllCardCollectionPackRate(self:GetActId())
  for id, storyRewardCfg in pairs(ConfigData.reinforce_collect_collect_reward) do
    if collectionCount >= storyRewardCfg.condition and not avgPlayCtrl:IsAvgPlayed(storyRewardCfg.story_id) then
      flag = true
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnni24InifinityRankReward()
  local reddot = self:GetActivityReddot()
  local threeInOneNode = reddot:AddChild(ActAnniversary24Enum.reddotType.ThreeInOne)
  local infinityNode = threeInOneNode:AddChild(ActAnniversary24Enum.reddotSubType.Inifinity)
  local childReddot = infinityNode:AddChild(ActAnniversary24Enum.reddotSubType.InfinityRankReward)
  if childReddot == nil then
    return
  end
  local redCount = 0
  local actFrameId = self:GetActFrameId()
  if self:IsActivityRunning() then
    local levelCfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
    for stageId, levelCfg in pairs(levelCfgDic) do
      if levelCfg.infinite_score ~= 0 then
        local curScore = self:GetRankScoreByStageId(stageId)
        local pickedScore = self:GetRankRewardPickedScoreByStageId(stageId)
        local alreadyScore = pickedScore.alreadyScore or table.emptytable
        local rewardGroupId = levelCfg.reward_group_id
        local rewardGroupCfgDic = ConfigData.reinforce_exploration_reward_group[rewardGroupId]
        for value, rewardCfg in pairs(rewardGroupCfgDic) do
          local needScore = rewardCfg.value
          local isPicked = alreadyScore[needScore]
          local isComplete = curScore >= needScore
          if isComplete and not isPicked then
            redCount = redCount + 1
            break
          end
        end
      end
    end
  end
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:RefreshRedAnni24InifinityLayerReward()
  local reddot = self:GetActivityReddot()
  local threeInOneNode = reddot:AddChild(ActAnniversary24Enum.reddotType.ThreeInOne)
  local challengeNode = threeInOneNode:AddChild(ActAnniversary24Enum.reddotSubType.challenge)
  local childReddot = challengeNode:AddChild(ActAnniversary24Enum.reddotSubType.challengeLayerReward)
  if childReddot == nil then
    return
  end
  local redCount = 0
  local actFrameId = self:GetActFrameId()
  if self:IsActivityRunning() then
    local levelCfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
    for stageId, levelCfg in pairs(levelCfgDic) do
      if levelCfg.layer_group ~= 0 then
        local curLayer = self:GetHightestLevelByStageId(stageId)
        local pickedScore = self:GetRankRewardPickedScoreByStageId(stageId)
        local alreadyLayerDic = pickedScore.alreadyLayerLevel or table.emptytable
        local rewardGroupId = levelCfg.reward_group_id
        local rewardGroupCfgDic = ConfigData.reinforce_exploration_reward_group[rewardGroupId]
        for value, rewardCfg in pairs(rewardGroupCfgDic) do
          local needPassedLayer = rewardCfg.value
          local isPicked = alreadyLayerDic[needPassedLayer]
          local isComplete = curLayer >= needPassedLayer
          if isComplete and not isPicked then
            redCount = redCount + 1
            break
          end
        end
      end
    end
  end
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActAnniversary24Data:__InitChildActivityRedListen()
  local actFrameId1 = self._mainCfg.jump_activity_id[1]
  if actFrameId1 ~= nil and actFrameId1 ~= 0 then
    local redDot1 = self:__AddSingleChildRedListen(actFrameId1)
    self._childActivityRedDic[ActAnniversary24Enum.reddotType.Activity1] = redDot1
  end
  local actFrameId2 = self._mainCfg.jump_activity_id[2]
  if actFrameId2 ~= nil and actFrameId2 ~= 0 then
    local redDot2 = self:__AddSingleChildRedListen(actFrameId2)
    self._childActivityRedDic[ActAnniversary24Enum.reddotType.Activity2] = redDot2
  end
  self:__UpdateChildActivityRed()
end

function ActAnniversary24Data:__AddSingleChildRedListen(activityId)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityId)
  if actFrameData == nil then
    return
  end
  local childActivityReddot = actFrameData:GetActivityReddotNode()
  if childActivityReddot == nil then
    return
  end
  RedDotController:AddListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  return childActivityReddot
end

function ActAnniversary24Data:__UpdateChildActivityRed()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    self:__UpdateSingleChildRed(childActivityReddot, enum)
  end
end

function ActAnniversary24Data:__UpdateSingleChildRed(childActivityReddot, reddotEnum)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if childActivityReddot ~= nil then
    local childReddot = reddot:AddChild(reddotEnum)
    local flag = childActivityReddot:GetRedDotCount() > 0
    local redCount = flag and 1 or 0
    if childReddot:GetRedDotCount() ~= redCount then
      childReddot:SetRedDotCount(redCount)
    end
  end
end

function ActAnniversary24Data:__RemoveChildActivityRedListen()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    RedDotController:RemoveListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  end
  self._childActivityRedDic = {}
end

function ActAnniversary24Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActAnniversary24Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActAnniversary24Data:GetWinter23SeconedUnlock()
end

function ActAnniversary24Data:IsAnniversary24ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetAnni24ShopLooked(self:GetActId(), shopId)
end

function ActAnniversary24Data:SetAnniversary24ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24ShopLooked(self:GetActId(), shopId)
  self:RefreshRedAnniversary24Shop()
end

function ActAnniversary24Data:OnDataRemoved()
  self:__RemoveChildActivityRedListen()
end

function ActAnniversary24Data:GetAnniversary24DailyTaskData()
  return self._dailyTaskData
end

function ActAnniversary24Data:GetAnniversary24TermTaskData()
  return self._termTaskData
end

function ActAnniversary24Data:GetAnniversary24Cfg()
  return self._mainCfg
end

function ActAnniversary24Data:GetAnni24RfGroupId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetAnni24RfGroupId(self:GetActId())
end

function ActAnniversary24Data:SetAnni24RfGroupId(groupId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24RfGroupId(self:GetActId(), groupId)
end

function ActAnniversary24Data:GetAnni24PerformId()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetAnni24CheckScenePerformId(self:GetActId())
end

function ActAnniversary24Data:SetAnni24PerformId(performId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24CheckScenePerformId(self:GetActId(), performId)
end

function ActAnniversary24Data:IsAnniversary24Sector(sectorId)
  return self._mainCfg.hard_stage == sectorId or self._mainCfg.normal_sector == sectorId
end

function ActAnniversary24Data:IsAnniversary24DunSector(sectorId)
  return ConfigData.reinforce_exploration_main[self:GetActFrameId()].continue_sector == sectorId
end

function ActAnniversary24Data:GetRelationStage(stageId)
  if not self:IsActivityRunning() then
    return nil
  end
  local stageCfg = ConfigData.sector_stage[stageId]
  if stageCfg == nil or stageCfg.sector ~= self._mainCfg.hard_stage then
    return nil
  end
  local sectorDiffDic = ConfigData.sector_stage.sectorDiffDic[self._mainCfg.normal_sector]
  if sectorDiffDic == nil then
    return nil
  end
  sectorDiffDic = sectorDiffDic[stageCfg.difficulty]
  if sectorDiffDic == nil then
    return nil
  end
  local relationId = sectorDiffDic[stageCfg.num]
  if relationId == nil then
    return nil
  end
  return ConfigData.sector_stage[relationId]
end

function ActAnniversary24Data:SetAnniversary24ClientRecordSector(recordSectorId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24FirstEnterSectorId(self:GetActId(), recordSectorId)
  self.recordSectorId = recordSectorId
  self:RefreshRedAnni24Main()
end

function ActAnniversary24Data:GetLastAnniversary24MainSector()
  if not self.recordSectorId or self.recordSectorId == 0 then
    local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
    local clientDiff = userDataCache:GetAnni24FirstEnterSectorId(self:GetActId())
    self.recordSectorId = clientDiff or nil
  end
  return self.recordSectorId == self._mainCfg.normal_sector or self.recordSectorId == self._mainCfg.hard_stage, self.recordSectorId
end

function ActAnniversary24Data:GetRankRewardPickedScoreByStageId(stageId)
  if self.highExploration == nil or self.highExploration.scoreReward == nil then
    return table.emptytable
  end
  return self.highExploration.scoreReward[stageId] or table.emptytable
end

function ActAnniversary24Data:GetRankScoreByStageId(stageId)
  if self.highExploration == nil or self.highExploration.highScore == nil then
    return 0
  end
  return self.highExploration.highScore[stageId] or 0
end

function ActAnniversary24Data:GetRankScoreIsUnderVerifyByStageId(stageId)
  if self.highExploration == nil or self.highExploration.verifying == nil then
    return false
  end
  return self.highExploration.verifying[stageId] == 1
end

function ActAnniversary24Data:GetHightestLevelByStageId(stageId)
  if self.highExploration == nil or self.highExploration.highLayerLevel == nil then
    return 0
  end
  return self.highExploration.highLayerLevel[stageId] or 0
end

function ActAnniversary24Data:GetCurLevelByStageId(stageId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local layerIndex = userDataCache:GetAnni24SelectLayer(self:GetActId(), stageId)
  return layerIndex
end

function ActAnniversary24Data:SetCurLevelByStageId(stageId, layerIndex)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetAnni24SelectLayer(self:GetActId(), stageId, layerIndex)
end

function ActAnniversary24Data:GetSupportCardRewardProgress(rewardDic)
  local totalNum, pickedNum
  local epMainCfg = ConfigData.reinforce_exploration_main[self:GetActFrameId()]
  local getLenReward = self.getLenReward or table.emptytable
  local rewardDic = rewardDic or table.emptytable
  for itemId, itemNum in pairs(epMainCfg.one_friend_reward) do
    totalNum = epMainCfg.total_friend_reward * itemNum
    pickedNum = (getLenReward[itemId] or 0) + (rewardDic[itemId] or 0)
    return pickedNum, totalNum
  end
  return 0, 0
end

function ActAnniversary24Data:GetRepeatArrangeType()
  return self._mainCfg.farm_stage_arrange
end

function ActAnniversary24Data:GetHeroIsAlReadByEntity(entity)
  local intrctData = entity:GetLbIntrctEntData()
  local objId = intrctData:GetLbIntrctObjId()
  local isAlRead, storyId = self:GetHeroIsAlReadByObjId(objId)
  return isAlRead, storyId
end

function ActAnniversary24Data:GetHeroIsAlReadByObjId(objId)
  local cfgList = ConfigData.activity_anniversary24_talk_surprise[self:GetActFrameId()]
  local storyId = 0
  local lobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  local nowLobbyId = lobbyCtrl:GetActLobbyId()
  for i, v in pairs(cfgList) do
    if v.surprise_param1 == objId and nowLobbyId == v.lobby_id then
      storyId = v.surprise_param2
      break
    end
  end
  if storyId == 0 then
    return true
  end
  return ControllerManager:GetController(ControllerTypeId.AvgPlay, true):IsAvgPlayed(storyId), storyId
end

return ActAnniversary24Data
